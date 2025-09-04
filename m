Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD33ECA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGs4-0003UQ-LO; Thu, 04 Sep 2025 16:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGrw-0003SC-8e
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:45 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGrp-0000id-Jd
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:43 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 6FB2360BF8
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:21 +0200 (CEST)
Received: (qmail 32607 invoked by uid 990); 4 Sep 2025 20:47:21 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:21 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v6 07/25] target/avr: call plugin trap callbacks
Date: Thu,  4 Sep 2025 22:46:44 +0200
Message-ID: <20cc1b234a31dd02dfb36702ebe2fc68e18ceb75.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.997689) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.597689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=aiXM/t745WPvpZ4qvo3agcHEz8akJ3QnkTB+iJHf8wQ=;
 b=KI4lCuOI3w4zzugOoGzG6e3YaCMrfbDo37yfm/9bkigeUKhN5waQRp+xLLsFc4N5mgOLcMFsVW
 5+1qNfi/hOI4rPJK8k3iH5dtnpyUV1Oo0zhwbfYtvTSFa+axoKenC9Jz+V4dFEhBh2pXtAo8Z1se
 msNCXbWJmpd4O7szg/qbMH6M3u2NsMkR+L3gH9xJpgPFDnCUUjoHurl6IaSLEfil3Lj8kGvpDEPh
 lN6PaCVbofYhtIEopD8p7oj0iyFnN2voe89LVNcyhZxijI8dWNIF/v4sqX0mgZMgqfHbbRXYRZTd
 RMU+sG9Jv+w/L+W1E+VwAFNN+kSTq3H2I11rLehQz5hPxYsCjJkIJqhgIThY2S0yshCvVJxDxneC
 lvQ5GAPf3Y9rC9SlwhGHfisOGf9ai1vUScppoREsO7Qw3FcONiWepwSuiyHPUAyWOVW+y/b+g8XP
 hHH9uimPjgwLJAexqUpjgu2iwFcjncZ3JPcQt85fWi4/L0Ql97h1UNWGq+onsUK+SGuDWPmNnI9A
 hO1GbO+cGP3vGbN6vjDfA2rt6sBTYzMmuUcni7TVZxv1PWTNWy5HYd4zvPB2728iTrIb8Rh/EemN
 nDdIx6nYwDDEpGHQrLol/3mhtuFbNO/Zg2faCiZ9MkE7K69xdN15ywKgiTcSv1OCrzPf4udfktT+
 I=
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
index b9cd6d5ef2..f28cc08637 100644
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


