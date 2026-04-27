Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711F8FF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5X-0000JJ-QS; Mon, 27 Apr 2026 17:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5T-0000GF-Ii
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:52 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5R-0003V0-2l
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:50 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 22E6640979;
 Mon, 27 Apr 2026 21:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92773C19425;
 Mon, 27 Apr 2026 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323708;
 bh=WKjvKh3WS9aFV3WDMKRIHdU/l7XY2HCHrBoFujAWcmo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Nbqgvr/CVerZdmWVgwmLUzhS3e/nR+tOX8qqkPVj2F5SxsoPWfskiNl4Hs6vcVq5L
 WQvjxC/Uiu2bFpnpxEE4EDNdHUGgk7sopWfZhg94QuzSDjMa7RV+0GgcyymbgfYPyZ
 DnoFy97myfRqp968H7F+8NGZ9iWVSYfsU+8zxaGlVTmtS0mKYkuYEbxUcpkn9aviMV
 OSUN70zC8L0To9ST8NlSzjqNXIWng1c6vcqOAFXK3RfxHw+qJESs0boLMmEHrqc0eS
 9PCPsYMJuN2itvIzajXF4W1McpBRau0AOaEUzlGys0rkIsEz/rn+jwqFTqtwxp7LSB
 rhK7c+ee93LfQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 06/15] linux-user/arm/nwfpe: Use thread-local storage for
 qemufpa
Date: Mon, 27 Apr 2026 23:01:24 +0200
Message-ID: <20260427210133.6016-7-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Fix the thread safety of the emulation by not storing a
pointer in global storage.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/arm/nwfpe/fpa11.c | 3 +--
 linux-user/arm/nwfpe/fpa11.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/arm/nwfpe/fpa11.c b/linux-user/arm/nwfpe/fpa11.c
index 44783934b2..15888463f7 100644
--- a/linux-user/arm/nwfpe/fpa11.c
+++ b/linux-user/arm/nwfpe/fpa11.c
@@ -29,7 +29,7 @@
 //#include <asm/system.h>
 
 
-FPA11* qemufpa = NULL;
+__thread FPA11* qemufpa = NULL;
 
 /* Reset the FPA11 chip.  Called to initialize and reset the emulator. */
 void resetFPA11(void)
@@ -154,7 +154,6 @@ void SetRoundingPrecision(const unsigned int opcode)
 }
 
 /* Emulate the instruction in the opcode. */
-/* ??? This is not thread safe.  */
 unsigned int EmulateAll(unsigned int opcode, FPA11* qfpa)
 {
   unsigned int nRc = 0;
diff --git a/linux-user/arm/nwfpe/fpa11.h b/linux-user/arm/nwfpe/fpa11.h
index 20f9d2eb81..659d38ae3a 100644
--- a/linux-user/arm/nwfpe/fpa11.h
+++ b/linux-user/arm/nwfpe/fpa11.h
@@ -74,7 +74,7 @@ typedef struct tagFPA11 {
     float_status fp_status;      /* QEMU float emulator status */
 } FPA11;
 
-extern FPA11* qemufpa;
+extern __thread FPA11* qemufpa;
 
 void resetFPA11(void);
 void SetRoundingMode(const unsigned int);
-- 
2.53.0


