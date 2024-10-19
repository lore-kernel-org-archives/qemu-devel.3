Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A04D3C922
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 16:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2CUt-0001vT-AI; Sat, 19 Oct 2024 12:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUr-0001v7-76
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:09 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUo-0003h3-TD
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:08 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 02A3217F9F4
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 18:39:59 +0200 (CEST)
Received: (qmail 9771 invoked by uid 990); 19 Oct 2024 16:39:58 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 19 Oct 2024 18:39:58 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH v2 4/7] target/arm: call plugin trap callbacks
Date: Sat, 19 Oct 2024 18:39:37 +0200
Message-ID: <be4c64f56a4a7f25a2769c0eccd2ed6e1d8cb9ee.1729355735.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729355735.git.neither@nut.email>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.83479) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.43479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=QW5b+c8GerXmJWDNBXe+kTqzYLQkqZ+V6ikpQTJsG78=;
 b=Dwzd9ejyKQW+iC6emONffpP14xKf6tH85Pp3LCf3wawqHFZHM/nrBRRrnN6hfpmuiG0hKnFrbS
 aG1W1P4Ng/k+3WOVGgNAt3JRZXw6nz1rIuhdLlJOvcdUxralJIuUsXx64Dle78VjR9ptrelCQcmn
 LmDZZW85shk1H1Aff2YA6d+aphCSSbLZeEPyyHU3btUfOl/drs/gwk+WEwQfRekg16p5xY3n80YR
 n7ODFibt+cbEiqIXAidJdKi0v0kB6VPAtBH6weFMhmnBMmb+nIwc/jVSPaSkh6khhELYYw7oZtLm
 MMk9JDzpl5FGJFSht3FqhYbiz5G/y+bUB2wolQxCr/PnSUWd+es1s3jlaCJ0kwkHT8hwa2Hld8vA
 lMGA25QrST6h39s4uABTlZYHCAk6/C8Wg+aIIKyYku+zyc7s7kOiq/R4vgjQOnz7NWxKbL7ZThQp
 I741x7rweD3RQn6YeMN3C3mKAWrEmEslDKMSBktaKbHpbAhQ54/ipb4FcnGq8PY6lDVPg3wunQHx
 1XhMKbYTo6wcOgh/wVD9o8gcj+E9shLe6UaSPuAS74gAtlpsxENLaTpGKmcMwFh//FaFTwNMzP+v
 IDSBExGb7Yiz7Im9VCZ6/CdnCCzhRvJ5+MrwCYtKHh5InX4ftzuAiZR0zDyD4KDHuImo3srsdA6E
 w=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This change places hooks for ARM (and Aarch64) targets. We decided to
treat the (V)IRQ, (VI/VF)NMI, (V)FIQ and VSERR exceptions as interrupts
since they are, presumably, async in nature.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/arm/helper.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0a731a38e8..f636e216c8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -31,6 +31,7 @@
 #endif
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
+#include "qemu/plugin.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
@@ -11147,6 +11148,24 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     }
 }
 
+static void arm_do_plugin_vcpu_interrupt_cb(CPUState *cs)
+{
+    switch (cs->exception_index) {
+    case EXCP_IRQ:
+    case EXCP_VIRQ:
+    case EXCP_NMI:
+    case EXCP_VINMI:
+    case EXCP_FIQ:
+    case EXCP_VFIQ:
+    case EXCP_VFNMI:
+    case EXCP_VSERR:
+        qemu_plugin_vcpu_interrupt_cb(cs);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs);
+    }
+}
+
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
 {
     /*
@@ -11819,6 +11838,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
+        arm_do_plugin_vcpu_interrupt_cb(cs);
         return;
     }
 
@@ -11830,6 +11850,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 #ifdef CONFIG_TCG
     if (cs->exception_index == EXCP_SEMIHOST) {
         tcg_handle_semihosting(cs);
+        qemu_plugin_vcpu_semihosting_cb(cs);
         return;
     }
 #endif
@@ -11855,6 +11876,8 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (!kvm_enabled()) {
         cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
     }
+
+    arm_do_plugin_vcpu_interrupt_cb(cs);
 }
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.45.2


