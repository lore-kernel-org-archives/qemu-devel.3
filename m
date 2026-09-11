Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5B2C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50MY-0007jP-7K; Fri, 11 Sep 2026 08:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50MV-0007fF-RE
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50MU-00077K-Ai
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789129689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R654KBPGUvh+oIEaBe90/0D2bgbO+xK4JzNc+JEMxNw=;
 b=FMoAoz5QeRsJM5jTSGuREsAX4MX1S/r8SiwvmA23drco3mVIYKa5xF3P8AidCpeF1c6shu
 976tUgP7/G+KmzKIfPEWjsu7bRzUHrCSrTv7VNU4AgNRyjvO1eCjChXU9DaXUDmcz4U+KB
 3uopPvmiarln/OAqgZGo8P2hc+5bdKg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-HHVhrSFWMlKQUgwcz3XV1g-1; Fri,
 11 Sep 2026 08:28:07 -0400
X-MC-Unique: HHVhrSFWMlKQUgwcz3XV1g-1
X-Mimecast-MFC-AGG-ID: HHVhrSFWMlKQUgwcz3XV1g_1789129684
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B6491800598; Fri, 11 Sep 2026 12:28:04 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23DC73000229; Fri, 11 Sep 2026 12:28:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 16:27:31 +0400
Subject: [PATCH 08/10] target/riscv: bypass smstateen check in debugger
 mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-query-reg-v1-8-0c04f0c02cf3@redhat.com>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
In-Reply-To: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=773;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LMrjJTVTVpO2R0XX7vgTv//RHImMSQWNJTx8uS10AB0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqo/OvQ16YWYZ57x+2HOU3K6EmSbrY109lK5myr
 95vNB0h1MCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqPzrwAKCRDa6OEJdZac
 5QTzD/oCsf37URwa3TSnmZOnWsq92c/+qvcBVl3Qd3wHnFHLkALTL0WNNBAYB++IYWAKtaqfXjB
 nRy4e+rOdJ4I6v9qj1jp6R26mqxr+dGeQ6wJMwQcisK5FdE0Exga7cpdi+ly9D+6fciYOGjsgrs
 ttmCSTmlvm3hy433P0CvuXt4FOYbIuD5AW4AFtpRTdoyL8eAzJvOKxPrzLV69Wqsh6ltRp/zWBc
 xOPPLrZe/Gc9HfXKOrl8bBJ64xXrR0w+bf0KdyBxCK4XmNah4TbwO+jAH+PVxL+2CIzylic/6BP
 BKxIlnwM9Lttyb/eCsCJwL7EGhhBJ0QoifkvFRHdxH985VKVmA6ezdj22A4tTi4BoASVdsXIpg4
 BgGTtE7O01PG4qlN3ZBMFnpLdA7vJVSdoXQd4ntCAMIKsEUUD6me1N18Pt+iML9OChBCOhRXkKc
 cTKxhHO32ysCBGi26TwSButCTucJwy2kMv+ATX9h5X/vteqcVuF9a1RVodkEaq1VJcPYzjIwneC
 DfGILKR8CL6IxXEENNl/BDcVYuZ5fElHVKvpgvmGwyh9UW5HRthu5BYjw2jRHdwriyaKDudsNCr
 cSe/klj/Lw9BBTe+euWPoolpDO9OJONZc/2NyJ9te+mShEmsObXeQejTmCS8nVjhULAkeoG+PBl
 1vQjIoI2Q8a5JOA==
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow to read CSRs gated by Smstateen extension when env->debugger.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/tcg/csr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index bd4b6dc114bc..93a7f419f29f 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -53,7 +53,8 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
 {
     bool virt = env->virt_enabled;
 
-    if (env->priv == PRV_M || !riscv_cpu_cfg(env)->ext_smstateen) {
+    if (env->debugger || env->priv == PRV_M ||
+        !riscv_cpu_cfg(env)->ext_smstateen) {
         return RISCV_EXCP_NONE;
     }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


