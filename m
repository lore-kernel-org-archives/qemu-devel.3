Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84EDFF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 15:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGfIm-00085q-BF; Sat, 25 Apr 2026 11:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGfIV-00080c-8A
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:52:00 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGfIS-00012i-EA
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:51:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DCBE600AE;
 Sat, 25 Apr 2026 15:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5973C2BCB0;
 Sat, 25 Apr 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777132315;
 bh=WKjvKh3WS9aFV3WDMKRIHdU/l7XY2HCHrBoFujAWcmo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IuK9+2/Kzv45kxn55JGrCq2cK4wb6wfaKmO2Zt3ZifjomNPOXTKPSltJ7/5zeEA6c
 NYgV1Dc7mnTo6TGRrc9730Nhd6GYYITELtdgFEGQ6nDnHchwr6ZHqqKZfbYH4XeLkX
 kYS2ofre6hPRXDuahN+rRSRojBdrVh5Grcastj5HrchKMsbZtzkhYUm2GMGXPqeyBV
 rM6Rz7n4aFevTHG5GxRq1dCMVqLm/Tp4CNwFlCWsZwLEAUAf1bNuk3WLZMgAINf1LO
 PYTb2N6e9wWQLC4om8b5mYhloRx8OBPJrVFN1FA0359MtjJ06HaLJwdpNg3n5Jb3Fe
 NFwZkhkM6qkmg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/14] linux-user/arm/nwfpe: Use thread-local storage for
 qemufpa
Date: Sat, 25 Apr 2026 17:51:32 +0200
Message-ID: <20260425155140.50186-7-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425155140.50186-1-deller@kernel.org>
References: <20260425155140.50186-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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


