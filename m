Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D225ACFD37A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNpzb-0006Fm-3F; Tue, 25 Nov 2025 05:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vNpzO-0006Bi-RH
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:09:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vNpzM-0002Mg-CI
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764065375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfXef5zgcxWshb5+Sdzi4qxSkYwDTi2EO2nL7cfOGAE=;
 b=barf+aICXHKy1K+STHJhoZnbfFN1B4hXrq7jyGHZDNNp/drmqmCn2NobR5mKSSJ2W661Ai
 qmyDuLTNa+T4jz630JYS0PN6e0S2P313gg2Ey6dZ3WoB3SG7LCgmNpkQ6kcY9wadG+vWKe
 jgZGfLSTgfnpSh6JFNxBAJEaVtcP1CA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-bHXv6fHnNGi0xpME9UcLFw-1; Tue,
 25 Nov 2025 05:09:33 -0500
X-MC-Unique: bHXv6fHnNGi0xpME9UcLFw-1
X-Mimecast-MFC-AGG-ID: bHXv6fHnNGi0xpME9UcLFw_1764065372
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CC801800343; Tue, 25 Nov 2025 10:09:32 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.42])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EBB21800451; Tue, 25 Nov 2025 10:09:28 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v3 05/11] target/arm/helper: Skip hidden registers
Date: Tue, 25 Nov 2025 11:07:54 +0100
Message-ID: <20251125100859.506228-6-eric.auger@redhat.com>
In-Reply-To: <20251125100859.506228-1-eric.auger@redhat.com>
References: <20251125100859.506228-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In case a cpreg is hidden, skip it when initialing the cpreg
list.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- use kvm_regidx
---
 target/arm/helper.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b..91ebefc50c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -235,9 +235,13 @@ static void add_cpreg_to_list(gpointer key, gpointer value, gpointer opaque)
     ARMCPU *cpu = opaque;
     uint32_t regidx = (uintptr_t)key;
     const ARMCPRegInfo *ri = value;
+    uint64_t kvm_regidx = cpreg_to_kvm_id(regidx);
 
+    if (arm_cpu_hidden_reg(cpu, kvm_regidx)) {
+        return;
+    }
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
-        cpu->cpreg_indexes[cpu->cpreg_array_len] = cpreg_to_kvm_id(regidx);
+        cpu->cpreg_indexes[cpu->cpreg_array_len] = kvm_regidx;
         /* The value array need not be initialized at this point */
         cpu->cpreg_array_len++;
     }
@@ -247,6 +251,12 @@ static void count_cpreg(gpointer key, gpointer value, gpointer opaque)
 {
     ARMCPU *cpu = opaque;
     const ARMCPRegInfo *ri = value;
+    uint32_t regidx = (uintptr_t)key;
+    uint64_t kvm_regidx = cpreg_to_kvm_id(regidx);
+
+    if (arm_cpu_hidden_reg(cpu, kvm_regidx)) {
+        return;
+    }
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
         cpu->cpreg_array_len++;
-- 
2.52.0


