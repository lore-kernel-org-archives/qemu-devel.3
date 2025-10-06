Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4ADCAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 09:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hyb-0006Lp-QO; Mon, 06 Oct 2025 05:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hya-0006Kt-Dm
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:52 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyY-0003p0-NR
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:52 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 6DB8C60B77
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:57:39 +0200 (CEST)
Received: (qmail 18717 invoked by uid 990); 6 Oct 2025 09:57:39 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:57:39 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v7 07/25] target/avr: call plugin trap callbacks
Date: Mon,  6 Oct 2025 11:57:02 +0200
Message-ID: <7ee40163fe5b9535b427934537936df18cd62785.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.995321) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.595321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=2UlKhbKoOoVQGSJ3KTG/q+t+0tUNYOPi6CGni73Tih0=;
 b=oldR2IcHwLO8YV1ZIWOOHoQ997jgOCpfeDgACO5KQ4BpfB2yXdu8WAd41d/eFkWdRsxmXlHGoE
 PjvptFh5dMKj6HNuD1h9Xj3DRcTNUNlmFXHcfBXchyByt8LN4Wb4WDpTV+5GKS/46qgCIrvZjPZg
 r/jCpXXZhQFIUtCepJTAD00FJNvU2W44Ghm73e2x2ApY+7vVEeCe4cXSSkdk5pSVNE+uhWGx+TgF
 v8xoxGeG9pWlkRMLs+HxRVdZz5s+plDjvCbSBwDYhVfQG8SaowvH+XCfHUyK82sZE8FaqxYFG2MD
 fIX+C2MYs3nvJLn8PePmRUNo3Z++wM9MY+7zLtirx0BWRYRvGF5NbzYxK5GFGG97Jy1brbR5ylvW
 Sbh4zTIL1pZDDNwAut0SFMRczRt/XiSHwd2KHM0LG2Ks1GlN5gtfBaMoWne64U2TB7pqym+UXeMp
 0Hcok4fNVDov3a/Ro6vLZAHoi3Pthihf6/m6GmjUpsQRNEffEJnvUmuAdcxLyJ8S9T9MsMIDnHps
 PmrSXaVs7A1gXB0X6riZiTZFP4xAdznDFR+kh3HfUmr3D0Di1por1dNcJJiMH73PhqpEg1CJNssA
 l1lVmuozZkE7JMTanv4yrgYDSDUPmv6A5b9p8MNeezpybC2YzvjYFRS+cqUzA0Y3KSt4m7Fz6nPh
 s=
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


