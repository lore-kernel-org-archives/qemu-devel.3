Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3435EFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRut-00030N-7I; Mon, 27 Apr 2026 15:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRuW-0002kx-Gf
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRuS-0000EP-SH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6i+QH3SjfjPRSHNBCrqV1LYOaaUKzs1HKnK3Bilxho=;
 b=cZM+23B4J8odJSHwdE6FaVi1B8mv+JJ7pfwwewCEp/VE4rrn+/6z3fkdC0Z07VrEBOSXVi
 K28bAhFHyrrwwTZFZnQckPn80y0Pc+7URQjxAYKLRk8foXUqdKFKFIPJN32U56n9cwOVY9
 wN68YfYdpjNVYBx3OD4/Va0Qi1ciI9Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10--tR7JTepPMSEozC2RIB65w-1; Mon,
 27 Apr 2026 15:46:18 -0400
X-MC-Unique: -tR7JTepPMSEozC2RIB65w-1
X-Mimecast-MFC-AGG-ID: -tR7JTepPMSEozC2RIB65w_1777319176
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 560AF1800464; Mon, 27 Apr 2026 19:46:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D29D8300070A; Mon, 27 Apr 2026 19:46:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:37 +0400
Subject: [PATCH 38/41] target/riscv: fix general_user_opts hash table leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-38-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ohWQ4ogs9grZ7aGeieqq2xi6Mm2yl57k/5oP/ZyoGyE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wWY7ZTkeW15/SrtnvRCsP8KCpaGLL3aZisI
 pRCltWKIoiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FgAKCRDa6OEJdZac
 5U86D/9GvHmn4W0G0j6vfpJCCGnTQ2XR7qJeScmBMKakAQUe6RPe/nHP89IE7igLhDyEE3Ny9Ve
 3jLmsIiyOLLH8ppP7KbAHow0mfL3ScJbW96VBhkSzUeEHNKVtdi6ruuvQG106nz+E0KiPsTG1vt
 sP179uozxOdWO+T0sAxs8TBDDAnJxsdOTsPk8KJfBFl4HXmGPXS2nL07aElPJRafRlfyjI+qQIu
 fqqw9OMjb7aMf0SFCo4ZTQC8gslVnVp7rAkihQ6Y3bSKFtHVbileJ79pJoP6scKp8//R6n7h4YC
 rXMDS7qhTzJvkNSr/4mEX8IqZ97KLJM2RYMiSNbrWJXou9riUGdLI/n4UVTcyF3st78i7O31pZZ
 +pkdJsHT5CIjchStuhDbG2go+8vmdgIw0HRZSNKpj9XiewgwfHUcKvPdKwnW8lq5Q4FFPpEXdrd
 4Am0/6JsQzMZq0TqJngerTueAJED3jOwxMMUr5WkX8oMqnMiVA9dUyJ3qg1e9ldg3T0lm5jt5jI
 pzA2DC/z3hEqQe3GRlux9BUPGHcQyaTF1bb69fviGOk26DqmUd9UsM/9cHPa/u/x5zf/j+lVBGb
 vtcgUR2SxZdSc8Y1Zu1tjiazmfwoe+2wwMFVY0btwhOR2AZJIe8xQEb1s5BpnmpGomEKMQmKbfI
 f1Z3kDEDrdrrUBA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The global general_user_opts hash table is recreated on every
riscv_cpu_init() call, leaking the previous one. Clear any existing
table before creating a new one, and destroy it on CPU finalization.

Fixes: d167a2247ede ("target/riscv: move 'pmu-mask' and 'pmu-num' to riscv_cpu_properties[]")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8ac935ac06e..15fa03e22a4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1101,6 +1101,7 @@ static void riscv_cpu_init(Object *obj)
                             "riscv.cpu.rnmi", RNMI_MAX);
 #endif /* CONFIG_USER_ONLY */
 
+    g_clear_pointer(&general_user_opts, g_hash_table_destroy);
     general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
 
     /*
@@ -2961,6 +2962,11 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
     DEFINE_RISCV_CPU(type_name, parent_type_name,             \
         .profile = &(profile_))
 
+static void riscv_cpu_instance_finalize(Object *obj)
+{
+    g_clear_pointer(&general_user_opts, g_hash_table_destroy);
+}
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -2968,6 +2974,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof(RISCVCPU),
         .instance_init = riscv_cpu_init,
+        .instance_finalize = riscv_cpu_instance_finalize,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,

-- 
2.53.0


