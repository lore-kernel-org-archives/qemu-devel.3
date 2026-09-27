Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF717C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkrl-0003VV-DC; Sun, 27 Sep 2026 05:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkpn-0000rP-Lp; Sun, 27 Sep 2026 05:06:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkpl-00087i-Tz; Sun, 27 Sep 2026 05:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499957; bh=ptbt+9JEYY2oqtwgL+itYqXSvq7YBetqi7jvNMLrBy8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MSJ9BVFlwjlGuZCvWeeUUGUAmltc7TFrYU865eTewumY56Nf81sLjROIi0+ZuGN3n
 9feXHTPJQsOxX4dgNVGwauyTuYNDABWFutw2eSyH4iGpvGX7mkzdt773cN4xgAdITP
 X6jF6c3DPib4+3TPTot5NgQSP/hbt6o+NdA8+m3Ri5k1Nbbl+45bW9u3JlUcDvPGwP
 Q8YsoZvjphLWhaMqK+W2hLrJB3K+Tw2EPH421WgWG/axMc29gTVKkkOb2F2L5nJyGF
 Ph9uCOJHLL39scDq2hRvSiDDxRHQPmuYY8kzS20eYx/p9kRGALv2e5aymR/61wbM1n
 20lnCQ24RNmjA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4930A1D8B12;
 Sun, 27 Sep 2026 12:05:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3E4754320CB;
 Sun, 27 Sep 2026 12:05:57 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E32EB5E655; Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Felix Yan <felixonmars@archlinux.org>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 65/86] linux-user/loongarch64: Detect vector stores
 in host_signal_write()
Date: Sun, 27 Sep 2026 12:05:12 +0300
Message-ID: <20260927090540.102811-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: SignKirigami <prcups@krgm.moe>

Recognize LSX/LASX stores in the LoongArch host signal handler to fix
internal QEMU crashes when RISC-V vector stores hit write-protected code
pages through host memcpy.

Signed-off-by: Felix Yan <felixonmars@archlinux.org>
Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit e95f53e30be7935d98e38eb09cd6360fe2886249)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/include/host/loongarch64/host-signal.h b/linux-user/include/host/loongarch64/host-signal.h
index d33c3fc03e4..eb4308cf090 100644
--- a/linux-user/include/host/loongarch64/host-signal.h
+++ b/linux-user/include/host/loongarch64/host-signal.h
@@ -61,6 +61,10 @@ static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
             return true;
         }
         break;
+    case 0b001011: /* v{ld,st}, xv{ld,st} */
+        return (insn >> 22) & 1;
+    case 0b001100: /* v{ldrepl,stelm}, xv{ldrepl,stelm} */
+        return (insn >> 24) & 1;
     case 0b001110: /* indexed, atomic, bounds-checking memory operations */
         switch ((insn >> 15) & 0b11111111111) {
         case 0b00000100000: /* stx.b */
@@ -69,6 +73,8 @@ static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
         case 0b00000111000: /* stx.d */
         case 0b00001110000: /* fstx.s */
         case 0b00001111000: /* fstx.d */
+        case 0b00010001000: /* vstx */
+        case 0b00010011000: /* xvstx */
         case 0b00011101100: /* fstgt.s */
         case 0b00011101101: /* fstgt.d */
         case 0b00011101110: /* fstle.s */
-- 
2.47.3


