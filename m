Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93676CCD183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV98-0001vi-1M; Sun, 19 Oct 2025 11:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV96-0001vJ-8K
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:32 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV94-0003BA-F5
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:32 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 66FAD60A6C
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:29 +0200 (CEST)
Received: (qmail 22990 invoked by uid 990); 19 Oct 2025 15:16:29 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:25 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v8 07/25] target/avr: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:14:56 +0200
Message-ID: <81eae4d94240303cebbbc8638841249bd7536ede.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999884) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=2UlKhbKoOoVQGSJ3KTG/q+t+0tUNYOPi6CGni73Tih0=;
 b=PAP+mvK0AYON9rydNo5drzp7BYiNMLR0B1aa2hhv56xrmR0yw2V1OAUVC6loZmJQNtcVG8tlQD
 HcxLExFZCq5rFpl/zRvvi6wp9v61mLWFuFXai6KP3c3NLKpKdW951rNEow1vivZBFZD8MmYTdMR9
 yY7a1jvpX85jr4BwDcOkYRoyWLIsrgjAqdlpvEkn00wQ+W1xxOxAINvajGlFYKEFwRTznePyB8El
 FIWayMw6EOl/APpAm+8xCoqAqiBwm8bRdUz/ubW8NGTwjXOLw/TCCg/dCXeMq8EW4SQclh8OfrLr
 5/HRqqF2n77cZcILcH4z3pUZSLeNKupnnBYaXPanSXY0aqS6c6HmG8o8A53qTmGq+fXfhhqvTZRz
 Dpc69eGMCrHxmAQV/gtpptt28QD3jYYDS/LVjQw8c08pgmaTh1EU29RSn8/tFHxb4JOsuuthla24
 LLYZkKbhZiC+gTIYZQMc3ELSklOC+sV1sea/jxlUhArq30cRUSf7eHmHwGAGCLsehXFCOdjFurPy
 TlEqZ8LMpbcjvRGrsrRNJu4Z3cIzZY/mcIvqVnPnyDHagL9i6WLejUPLPIDmAXpUUcf0xvuCdlE1
 gW5agQIpPXc7iOdWV3LyGEo8v8KXhaT8m0agm3nPQ5wv1nlc1b0Yee9RVIOx3+evw+shesxQ5u34
 Q=
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places the hook for AVR targets. That architecture appears
to only know interrupts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/avr/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 4b29ab3526..365c8c60e1 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -28,6 +28,7 @@
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
+#include "qemu/plugin.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
@@ -102,6 +103,8 @@ void avr_cpu_do_interrupt(CPUState *cs)
     env->sregI = 0; /* clear Global Interrupt Flag */
 
     cs->exception_index = -1;
+
+    qemu_plugin_vcpu_interrupt_cb(cs, ret);
 }
 
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.49.1


