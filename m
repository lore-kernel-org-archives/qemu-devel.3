Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F85CCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV9C-0001xx-M6; Sun, 19 Oct 2025 11:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9A-0001wG-8c
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:36 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV98-0003BW-OT
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:36 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id AB24A60A75
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:33 +0200 (CEST)
Received: (qmail 23117 invoked by uid 990); 19 Oct 2025 15:16:33 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:29 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v8 08/25] target/hppa: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:14:57 +0200
Message-ID: <f34973e93815d100d8216173eddb7d4f72cea847.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999999) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=PrAAKrvTEoAw77iOkjbdm6WPBb80G5xPz9yg7zljNC4=;
 b=FOjxn2xUeclito7V4p3KW1c0UZ8GZ6gnvSw7Z/RF1BmlD6PNGSbMP8o4UQYFci2I+oK+17GUMv
 s/SzAcFA02f66gSpyvietB4PMgyR0XviI6vhbovvgRal5BE3WX+lLc/HUmx7XtR1WCPDjrQgHQ6V
 /pOJWld+DDxJrw2/E3pCun2JWoOTKySfZjIVXvWCGzSkM7U7tv7lUob2EzRu5s/RUTHuH3X75cyy
 7H930fgcsK89vpPrqdRi3iNdjwQspel2lHz239Lq0sCQEl2WhoCzGLZvzcI6yY1dfw+pfCHDlfjr
 VMz1U7zE2waxrV2HYE54p667sbvZzbCLMc+GP8224qsvJQf4g/wvoZBrRqse1B7/kTEmEjD8xbGN
 8XOs0XE2z3C8Zloypo8nPYlmVPjHZVlPla9qJS7f6TSkFnXITwwFonH/vwfzduI8R/RA4oM2LWal
 F+3YE0wGKH8gGpx8DyEhy2kxfXscFl1RsSSBBmwxmSoG3PfdSO8EyYEkGCXcMoSVakvV/A5HQ8+w
 e7mHGgIP5DOD8+Cp03ufW3RicekKBJbyl5p22Dw1BW1E0qhV2F6Ppf55HoNouSBK5FvQwncVscUf
 WenvyIMypyyy5C4xBWAcMR3sQ8l/OI81jho9TUzAbwnvbfJM2cZqaW/UQCyqO95f9+86N4bAHk68
 4=
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

We identified a number of exceptions as interrupts, and we assume every
other exception is a (syncroneous) exceptions. PA-RISC appears to not
have any form of host-call.

This change places the hook for PA-RISC targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/hppa/int_helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 191ae19404..4e4869285b 100644
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
@@ -212,6 +214,21 @@ void hppa_cpu_do_interrupt(CPUState *cs)
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
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    }
+
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static const char * const names[] = {
             [EXCP_HPMC]          = "high priority machine check",
-- 
2.49.1


