Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8E0C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWQG-0001Sx-F4; Wed, 22 Jul 2026 08:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQ0-0001Kj-JW; Wed, 22 Jul 2026 08:51:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWPx-0002LY-4S; Wed, 22 Jul 2026 08:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=4kbCOMfTn3JZdp+8ABXEDnWPGsAgWE0wR8oCHUg5/Vg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lMHNbYZ7+J9Iu7l2hLzr+TDaR9+0LtKcPPngMwlnWaObgkXM2rUsIQyI0DBlWCGPc
 apNk+glShFftkGCq77d3U9YBjmaiD3iT9OoAp+k8ehO10axDr0G5fkiaWOjgQMfqkC
 LIxV7hYDLKD0SHya6qHtL8VU2BjmQYlkmPJ+k+N+FMvduGdn3l8hEtsrVr8mFfnd40
 JuOOCGXptDW4oh6z5+9dZ+CGQ6m776gjBi5Z4DeL/SeMI5csyvtLE86YrGgXKOAYgl
 PVX8Sz9DFC7C4DZEUZmN1bXv1qzXks6vC7sc6MgIGgCAn/LQ8HjhOnFI6uCEy4XfFJ
 2z2Co7WXflHKA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 85D241C3B30;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CCFA23F3780;
 Wed, 22 Jul 2026 15:49:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 965CB17F35; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 083/127] target/arm: Be more defensive for invalid
 tlbi_aa64_get_range
Date: Wed, 22 Jul 2026 15:48:08 +0300
Message-ID: <20260722124859.32371-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

It's possible to program TCR_ELx with an invalid granule size,
which could match passing an invalid granule size to TLBI RVA,
which would then fall through to assert in arm_granule_bits.

Cc: qemu-stable@nongnu.org
Fixes: 3c003f7029e ("target/arm: Use ARMGranuleSize in ARMVAParameters")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260710175818.528974-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 79cabc6cb7fb3a47d193cbb9a6bee71af5536dfc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 1a0a3325836..b24eb57788b 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -854,7 +854,7 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
     gran = tlbi_range_tg_to_gran_size(page_size_granule);
 
     /* The granule encoded in value must match the granule in use. */
-    if (gran != param.gran) {
+    if (gran != param.gran || gran == GranInvalid) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid tlbi page size granule %d\n",
                       page_size_granule);
         return ret;
-- 
2.47.3


