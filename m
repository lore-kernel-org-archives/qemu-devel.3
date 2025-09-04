Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63230CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGtz-0006F3-94; Thu, 04 Sep 2025 16:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGtg-0005q1-Lt
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:49:33 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGtY-0000zq-AT
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:49:32 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id F3D8260BF4
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:49:17 +0200 (CEST)
Received: (qmail 2401 invoked by uid 990); 4 Sep 2025 20:49:17 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:49:17 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v6 22/25] target/xtensa: call plugin trap callbacks
Date: Thu,  4 Sep 2025 22:48:57 +0200
Message-ID: <e54cd13ab5f6471e319816d34d50f4882e37c4e3.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999869) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=TvAisglz35MKJSZs9p85pseD3eQknxSupu+M7mUEgdw=;
 b=T0wiw7j3szSMbJbhka3DFbKrkLrc37aHRt1bA15B7bbr5VcFF4mSCFZ00R5rck5UwUy097oJWB
 ByQ/QgRpfhcSxLs3QN4tgGIq7ob0OepO4ArNHlafz5WuMyzQmVz+YTPvNT59+Bh5XyZuNuTrF6lf
 3UNdEHnFmMKChLF9QchIUwb/KJOYTlS7C8/TDzvKQh9EpjxDSRb1nyWJx+HSeVJCCiNItINdv+Ut
 7v+VtZNLy9+7aHz6aEuS9dflPxy5c/2c5ob4I9a0OFmdH+QQx5BFOW0XKDxySro1nG26DBEZiJ2l
 iDUYh9xBTIdgJjL+7B1kUO2EPYXG+Nv1231UdPVCcavxvKLHKegZHWY00TsDjq1nrZn9E5GAHTHG
 s9E0aku0CkNnQN4IKK4A3mRahF9yRr40yHHT2V5IHkV1RVwcjdHjAj4f1qdWh/CmO3+lPSrkB2I0
 pC19eFuxoBmGUZKWwtpbjefVm5NPqHfi5aMcbzSUQe+IoJDqjuvmt2ehNXDC1CEdv9gTad9LV+lc
 HlqeDmc7ZIsyWdp6t5MTyfj+xJ6y90CIRNGYUdx5pXGtfEKUJzwcB8BYG75pPGdAiBYB4WJyUMeQ
 M0g+0FtKZX2Xp3srWAjmgVF/7qy78YKL1mnwcvxiaCmAfPZyPQ3YHvn6FwSciRtDOWjMzqv4vcuQ
 c=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for xtensa targets.

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/xtensa/exc_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index b611c9bf97..fdc522698d 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -32,6 +32,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/atomic.h"
+#include "qemu/plugin.h"
 
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
 {
@@ -207,6 +208,8 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     CPUXtensaState *env = cpu_env(cs);
 
     if (cs->exception_index == EXC_IRQ) {
+        uint64_t last_pc = env->pc;
+
         qemu_log_mask(CPU_LOG_INT,
                       "%s(EXC_IRQ) level = %d, cintlevel = %d, "
                       "pc = %08x, a0 = %08x, ps = %08x, "
@@ -218,6 +221,7 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
                       env->sregs[INTSET], env->sregs[INTENABLE],
                       env->sregs[CCOUNT]);
         handle_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
     }
 
     switch (cs->exception_index) {
@@ -238,9 +242,11 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
                       env->sregs[CCOUNT]);
         if (env->config->exception_vector[cs->exception_index]) {
             uint32_t vector;
+            uint64_t last_pc = env->pc;
 
             vector = env->config->exception_vector[cs->exception_index];
             env->pc = relocated_vector(env, vector);
+            qemu_plugin_vcpu_exception_cb(cs, last_pc);
         } else {
             qemu_log_mask(CPU_LOG_INT,
                           "%s(pc = %08x) bad exception_index: %d\n",
-- 
2.49.1


