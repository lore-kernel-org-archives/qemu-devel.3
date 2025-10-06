Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944ABCAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 09:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hyk-0006Qe-Oe; Mon, 06 Oct 2025 05:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyb-0006Lu-SW
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:53 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyZ-0003pf-TT
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:53 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id B3A3F60B94
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:57:39 +0200 (CEST)
Received: (qmail 18731 invoked by uid 990); 6 Oct 2025 09:57:39 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:57:39 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v7 08/25] target/hppa: call plugin trap callbacks
Date: Mon,  6 Oct 2025 11:57:03 +0200
Message-ID: <bfdf4d5590d40c345a96fda9bc2dda992721f073.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.075005) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.675005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=91oBEkE9sM09e8POP/XtNPoBLu68yemmD0bUlcGlFTs=;
 b=E8ZMSpTxr0LcZm32SLheFcnZB5tophq03ZjHq52X6TdvvbIp0z5ozppe17qo+E5fKI3D4I3Ug6
 PidghCZjjQJ9eb3x6tOK4biYxaszFvLLRwNMmxI0kmQ5e3ylzE+VQttbQYp3jLI6d7Yqrawu7Kfl
 muFcVL19yZaXNSk6hBXvNfudhBI5y4+s6qabhzWgSDkMf183YrASFF82Nrgcta22kTiZhCs6kDcr
 iozfjsI86NxQA6CKspkOT9/fB4jICQ3lB8jdvYAg+BK5UPJOh8Y7HGDQ1fpiEP/xJlFx/lRu/gVK
 XWeNuBseGD48yeGU9VITIxUg2ukQKfNn/+wP2oCMzfkUl2orrQSS+O9gHGFyo4wjFTg8kwUDxkdZ
 iLnSolezxzcJKf6NSx/CLXTR9fcie4phNdCrOyyCdtV/Q2M5Tz6a6JsBWX+9jcErIRKF1euWwOJ9
 ktf4VbQpSW0GrysZvHLGCPlFoGIluQoyBQZSdF7oSVu3hH5wTC7HsfK+1VW0M+Hj+D7PqtA+CdcG
 3KpePiY/NodkIUPwMBm1kiZbdygN1cOetJChaXYIcR9gphGY4AIeSAe5x7c4lE56awMtzOtBJCN/
 liTs9zhrCQbS7KiMVdvhbP4aOlE9Xpwz1UW98GnuwbtDXW444XGGqQpRCjB1KeHJkWy2RjqMS4Mh
 A=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We identified a number of exceptions as interrupts, and we assume
exceptions that are not explicitly listed do exist and should be
regarded as interrupts. This unfortunately forces us to list all
(syncroneous) exceptions. We decided to also list every single
known interrupt as they are few and we prefer to complete an almost
complete list, partially as a visual aid to confirm that we did not miss
any named exception index.

PA-RISC appears to not have any form of host-call.

This change places the hook for PA-RISC targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/hppa/int_helper.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 191ae19404..0742990c90 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
 #include "hw/hppa/hppa_hardware.h"
+#include "qemu/plugin.h"
 
 static void eval_interrupt(HPPACPU *cpu)
 {
@@ -95,6 +96,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     CPUHPPAState *env = &cpu->env;
     int i = cs->exception_index;
     uint64_t old_psw, old_gva_offset_mask;
+    uint64_t last_pc = cs->cc->get_pc(cs);
 
     /* As documented in pa2.0 -- interruption handling.  */
     /* step 1 */
@@ -212,6 +214,48 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     env->iasq_f = 0;
     env->iasq_b = 0;
 
+    switch (i) {
+    case EXCP_HPMC:
+    case EXCP_POWER_FAIL:
+    case EXCP_RC:
+    case EXCP_EXT_INTERRUPT:
+    case EXCP_LPMC:
+    case EXCP_PER_INTERRUPT:
+    case EXCP_TOC:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    case EXCP_ITLB_MISS:
+    case EXCP_IMP:
+    case EXCP_ILL:
+    case EXCP_BREAK:
+    case EXCP_PRIV_OPR:
+    case EXCP_PRIV_REG:
+    case EXCP_OVERFLOW:
+    case EXCP_COND:
+    case EXCP_ASSIST:
+    case EXCP_DTLB_MISS:
+    case EXCP_NA_ITLB_MISS:
+    case EXCP_NA_DTLB_MISS:
+    case EXCP_DMP:
+    case EXCP_DMB:
+    case EXCP_TLB_DIRTY:
+    case EXCP_PAGE_REF:
+    case EXCP_ASSIST_EMU:
+    case EXCP_HPT:
+    case EXCP_LPT:
+    case EXCP_TB:
+    case EXCP_DMAR:
+    case EXCP_DMPI:
+    case EXCP_UNALIGN:
+    case EXCP_SYSCALL:
+    case EXCP_SYSCALL_LWS:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    }
+
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static const char * const names[] = {
             [EXCP_HPMC]          = "high priority machine check",
-- 
2.49.1


