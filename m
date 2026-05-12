Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7D0CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuOQ-0002Io-9R; Tue, 12 May 2026 17:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuOD-0000Id-Om; Tue, 12 May 2026 17:11:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuOB-0004fY-Cn; Tue, 12 May 2026 17:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619303; bh=aandxFzjyN5rMbH5L7FWFE20+iDH+W1KfzlGilX/Frc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Tkr2oGrSaGMMgGKwLo6LZJYhXIL7LbT5QJoilYP43M2NRw3QseEbPRMOeIVxgIDD9
 A5EAbaiP0nwo9LmJFGuRmIIUimgi1jGz2kKtmfuUxqduQbzkpwflAi5JdfSVdGdGiP
 82Slxl0/TDxCGJwsth4EdGcKyA/8QVnKEt2A7qDNyNXAJqulshRhWdiF930wi1+KWj
 MR3GX4xFVHly906xiAyI5gQtXB0Zmee1QoKs95IR8tzm7LKUF5GUmc3Dku5S4ntB+2
 U18Ks/Bmnhlk5SgK3MvATVljdjZyKV2fVEdKn0Ogo1dlkURk2nljp+AozjHxvaxIzC
 GMX3FQOi3aXvQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F44B1AA378;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9A8983ABCE7;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 058/117] target/arm: do_ats_write(): avoid assertion
 when ptw failed
Date: Tue, 12 May 2026 23:54:00 +0300
Message-ID: <20260512205503.361097-58-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In do_ats_write() we try to assert that the cacheattrs from
get_phys_addr_for_at() are in the form we expect:

    /*
     * ATS operations only do S1 or S1+S2 translations, so we never
     * have to deal with the ARMCacheAttrs format for S2 only.
     */
    assert(!res.cacheattrs.is_s2_format);

However, the GetPhysAddrResult struct documents that its fields are
only valid when the page table walk succeeded.  For a two stage page
table walk which fails during stage two, we will return early from
get_phys_addr_twostage() and depending on the fault type the
res.cacheattrs may have been initialized with the stage 2 cache attr
information in stage 2 format.  In this case we will incorrectly
assert here.

Fix the assertion to not look at the res fields if the lookup failed.

Note for stable backports: the do_ats_write() function is in
target/arm/helper.c in older QEMU versions, but the change to the
assert line is the same.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3328
Fixes: 9f225e607f21 ("target/arm: Postpone interpretation of stage 2 descriptor attribute bits")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260331092305.2062580-1-peter.maydell@linaro.org
(cherry picked from commit 84771c64a5ae0f28d4bacc3f85a1f852a70c6edc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 0e8f229aa7..53dd67375d 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -37,8 +37,9 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
      * have to deal with the ARMCacheAttrs format for S2 only.
+     * (Note that res fields are only valid on ptw success.)
      */
-    assert(!res.cacheattrs.is_s2_format);
+    assert(ret || !res.cacheattrs.is_s2_format);
 
     if (ret) {
         /*
-- 
2.47.3


