Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB59C88E56
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 19:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5TFM-000490-7j; Sat, 12 Sep 2026 15:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vpyr@vpyr.dev>) id 1x5SWW-0006zj-EU
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 14:32:27 -0400
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vpyr@vpyr.dev>) id 1x5SWN-0003Rn-W2
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 14:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpyr.dev;
 s=protonmail; t=1789237905; x=1789497105;
 bh=lG8uPhg6jzddMF852YF2YdbVQvv5+vkwccZgzFIV5C8=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=C+bzILiR/0jNPQSGJ1KnY3fT7MawHrhCpot7afXVDKsiyyPuYbC01iQrm4mhMZPBU
 puDCDuUEtfuIGaf1rlHhPyi+8cnLh3xoWMgEpux/SLKCYeMhP0EvKFWkiqCExu3lvR
 bmjcgZAg/Y8yp5ICEgzlbU/TGZyRgHi2IqSO6zc5THS5r67a4hFSP68sY1r5mRcZXV
 yBCAQrfuKKQvroVdQ833ZQRWsrg5tbqXGdbN4h43NtGlnozIZKeF8kRjC9G8kmVhV+
 Wqoj8RUNqy3kACc/bNkmaGb4UvxatA6vO+9xZ9PegNZZuUm9FgRiA2HCtGM3gixrn/
 YZIyHJmAF1/+g==
X-Pm-Submission-Id: 4hj0PB3rPpz2ScWS
From: vpyr <vpyr@vpyr.dev>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, vpyr <vpyr@proton.me>,
 Felipe Junger <vpyr@vpyr.dev>
Subject: [PATCH] arm11mpcore: initialize SCTLR reset value
Date: Sat, 12 Sep 2026 15:31:10 -0300
Message-ID: <20260912183110.502358-1-vpyr@vpyr.dev>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.9.210.45; envelope-from=vpyr@vpyr.dev;
 helo=mail-06.mail-europe.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM=1.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 12 Sep 2026 15:18:41 -0400
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

From: vpyr <vpyr@proton.me>

Initialize reset_sctlr to 0x00054078 in arm11mpcore_initfn.

Previously, the generic reset mechanism initialized SCTLR to zero because
reset_sctlr was not set by the ARM11 MPCore CPU initialization function.
The new value follows the fixed-bit requirements documented in ARM DDI 0360F,
section 3.4.7, Table 3-20:

- Bits [21:16]: 000101, contributing 0x00050000
- Bit [14]: Should Be One / Read As One, contributing 0x00004000
- Bits [6:3]: Should Be One, contributing 0x00000078

V, U, and EE remain clear because their reset values depend on the VINITHI
and CFGEND configuration signals.

After rebuilding, the test read SCTLR as 0x00054078 instead of zero, and the
0x00050078 mask check passed.

Signed-off-by: Felipe Junger <vpyr@vpyr.dev>
---
 target/arm/tcg/cpu32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index f292a269bf..1999e50290 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -218,6 +218,7 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->isar.mvfr0 = 0x11111111;
     cpu->isar.mvfr1 = 0x00000000;
     cpu->ctr = 0x1d192992; /* 32K icache 32K dcache */
+    cpu->reset_sctlr = 0x00054078;
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0);
-- 
2.55.0


