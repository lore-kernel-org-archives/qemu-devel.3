Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F434CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEW0L-0002Ps-4O; Thu, 30 Oct 2025 13:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEW0D-0002Oa-28
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEVzz-0005J8-M9
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761843578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FQqSwxzlY/jt/p8yntQFpycFXxTFVhchNKEJY6m+p5c=;
 b=M/jYCD/LQDrcGqFfr4WHKG90v4yENMFbhcg7CoVbALR3lTh7alhcw3UfjnkLHAKMx0kzQ6
 RRqPMjAmvUaaaU3n+5oHg5CNrwE7VtV0zlQrh5WKAwN4XI1uMe1w6tsq1Rt9wbUSBHfvfG
 QY1yMtmIHP44JiE8Na42gOXl0ESxOMA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-W7btx3zsNuqqNCytLytaBA-1; Thu,
 30 Oct 2025 12:59:36 -0400
X-MC-Unique: W7btx3zsNuqqNCytLytaBA-1
X-Mimecast-MFC-AGG-ID: W7btx3zsNuqqNCytLytaBA_1761843575
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B627218015CC; Thu, 30 Oct 2025 16:59:35 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9ACD41800451; Thu, 30 Oct 2025 16:59:34 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: yoshinori.sato@nifty.com,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] rx: cpu: fix interrupts check in rx_cpu_do_interrupt()
Date: Thu, 30 Oct 2025 17:59:32 +0100
Message-ID: <20251030165932.138512-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Commit [1] broke interrupt handling, replacing interrupts fetch with a bool
and then the remaining code attempting to check individual bits
on that bool value, which effectively masked those interrupts.

Fix it by checking individual interrupt bits directly instead of
old 'fetch then check' approach.

1)
Fixes: 87511341c30d ("add cpu_test_interrupt()/cpu_set_interrupt() helpers and use them tree wide")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/rx/helper.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index 41c9606fd1..19af212b7d 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -40,11 +40,9 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
     env->psw_c = FIELD_EX32(psw, PSW, C);
 }
 
-#define INT_FLAGS (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR)
 void rx_cpu_do_interrupt(CPUState *cs)
 {
     CPURXState *env = cpu_env(cs);
-    int do_irq = cpu_test_interrupt(cs, INT_FLAGS);
     uint32_t save_psw;
 
     env->in_sleep = 0;
@@ -57,27 +55,24 @@ void rx_cpu_do_interrupt(CPUState *cs)
     save_psw = rx_cpu_pack_psw(env);
     env->psw_pm = env->psw_i = env->psw_u = 0;
 
-    if (do_irq) {
-        if (do_irq & CPU_INTERRUPT_FIR) {
-            env->bpc = env->pc;
-            env->bpsw = save_psw;
-            env->pc = env->fintv;
-            env->psw_ipl = 15;
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
-            qemu_set_irq(env->ack, env->ack_irq);
-            qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
-        } else if (do_irq & CPU_INTERRUPT_HARD) {
-            env->isp -= 4;
-            cpu_stl_data(env, env->isp, save_psw);
-            env->isp -= 4;
-            cpu_stl_data(env, env->isp, env->pc);
-            env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
-            env->psw_ipl = env->ack_ipl;
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-            qemu_set_irq(env->ack, env->ack_irq);
-            qemu_log_mask(CPU_LOG_INT,
-                          "interrupt 0x%02x raised\n", env->ack_irq);
-        }
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_FIR)) {
+        env->bpc = env->pc;
+        env->bpsw = save_psw;
+        env->pc = env->fintv;
+        env->psw_ipl = 15;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
+        qemu_set_irq(env->ack, env->ack_irq);
+        qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
+    } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
+        env->isp -= 4;
+        cpu_stl_data(env, env->isp, save_psw);
+        env->isp -= 4;
+        cpu_stl_data(env, env->isp, env->pc);
+        env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
+        env->psw_ipl = env->ack_ipl;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        qemu_set_irq(env->ack, env->ack_irq);
+        qemu_log_mask(CPU_LOG_INT, "interrupt 0x%02x raised\n", env->ack_irq);
     } else {
         uint32_t vec = cs->exception_index;
         const char *expname = "unknown exception";
-- 
2.47.3


