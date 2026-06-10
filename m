Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18297CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYB-0001qU-1K; Wed, 10 Jun 2026 12:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXz-0000Hu-0h
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXx-0005ce-6D
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so4869419f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107971; x=1781712771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A2R1q5pRZ2OfWAMYKkq4Lv2KWKmCUbmCVmUiB62Lcts=;
 b=rEik9CNXIphBxK45l/mG+t7bsPDS11pqX01HFRVK1TuXFccuOhWnHk/du9To4CUS8G
 JRiG10mWMQfpJWIUd+kIqfx2scNpPv+YnoXW2wnlxoXMboziUA8Lx3toWqXfosXgLL1o
 fm1ot/+c6h3Ru6zpjJsrKeayIu+PDs//UO9MJQWl4EECM5GR2hhiYEqntcqhwOq/Mhqh
 z3Kr+NOZbaWFpkVA2TS8O2WJ7LRQOBOK+7xVIanUamTU1jlLJtRX8AAkOJTZRPDy2FJx
 Qp5RpWI1IuxHRXrgk4Kmxls6Co5SJAtbvTRpMm5xrS2WfW9allpuOQy54HfbiRyQzNyM
 tfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107971; x=1781712771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A2R1q5pRZ2OfWAMYKkq4Lv2KWKmCUbmCVmUiB62Lcts=;
 b=jNNEq0lUrly5+1hnxgmK2ANk3+DX4sdY5na4m192fJdtvQVoeGBTzm/cuiNOn0ieDg
 Uf4Tuks1TcJV56/dldCO12Jo3CXNga87+JOM3mWIIEdtpTNcNGmOSWHxAqd1uedHIMEO
 lXWA4mMxr/nm8emEkuQXFKISkK8GFY/xgas4kbGWfrtrLbZ95oMKM2aIgwRElq4jCkqA
 VqX7wxl11vALekXAbjagfZ7O+xdj5Wf5wvntwx5C6aMg/dRBqnjEUssuDctKcuBnpO30
 +LOG+CHUnUgLV1Duk/mI7oLybG8KupeiLfh2MI2AD9Q01nfKgceTXA5A0pCpS33mE/Nl
 djbg==
X-Gm-Message-State: AOJu0Yz8PKEmDuyenRDjGqEFy/i8z7VxTSlldgpA5FXya5GGvkJyVJhu
 zheosjyC6sgm4knD6g9UyE/CXhTbzwjA3wSSFbOihIBIOx6b0QDuqOgwiK0iAft+Nxqpau/u7i6
 3Jbut
X-Gm-Gg: Acq92OEtd+lU/ISBt1RukjyOwPzEfABeQWAbd/c9XbLjgWPUnfjvPiLE7qbP45u0u0s
 kWO+eNM6T+28Mz43kfKtPjpFSfdN3VQmh6QWL30VGmPH4gsdO8GCBuJZfc/ZcLFZcDhPW/PRT9m
 pjKZffGNHnDoA1cTlUvRCZbSrwRtItlubSZMmpv5GBIo0DAV/Gn5kgA3Lv2p0QlvO/wRjv+1ibI
 iqMZK6Tmqa9PPPn/3TkNg8IyTf8Su2LQdhk1/lkjKVJHBbX9FDdHzNGC+NU3PZCGft0MRKWe0ZI
 D3uxGRIkV+DVuYU0lAYBDPln7ZxzbZiHHhvceZv8g4ZOPKTPS0gtIndYiElEPTprZs22+38HZ/g
 /JxlAXrfxwm/Y/eYyWGOiPzbp7r0WlCOvkULg8/tPhmmBluAUpw3IPE+/x9roju+Ps752Bh8t5h
 NMrkSgnRQHFy+IIkGi5tu/Nu19AsCxWiTMxsgbZ4iscynTodzoONHvwZfSKAOyraurD0qnt7/Xk
 m1VesHpt5bzg4VA8S9CJeQ2oO4BejQnXGGf6mgqLhs=
X-Received: by 2002:a05:6000:46dc:b0:460:1d74:a1b2 with SMTP id
 ffacd0b85a97d-460305146c4mr29247259f8f.16.1781107971474; 
 Wed, 10 Jun 2026 09:12:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/71] target/arm: Rename SME BFCVT patterns to BFCVT_hs
Date: Wed, 10 Jun 2026 17:11:26 +0100
Message-ID: <20260610161202.2235298-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The existing pattern is BFCVT (single-precision to BFloat16).
In preparation for introducing more insns of the same name,
append the operand sizes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 2 +-
 target/arm/tcg/sme.decode        | 2 +-
 target/arm/tcg/sme_helper.c      | 2 +-
 target/arm/tcg/translate-sme.c   | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index c551797c6f..01aad4c231 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -250,7 +250,7 @@ DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_sumlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvt_hs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ee874be1a6..7a8e1abb59 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -789,7 +789,7 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
 @zz_4x2_n1      ........ ... ..... ...... .... . .....      \
                 &zz_n n=1 zd=%zd_ax4 zn=%zn_ax2
 
-BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
+BFCVT_hs        11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index bd207de755..8e8e6c00ca 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1725,7 +1725,7 @@ DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
 #undef DO_MLALL_IDX
 
 /* Convert and compress */
-void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+void HELPER(sme2_bfcvt_hs)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
     ARMVectorReg scratch;
     size_t oprsz = simd_oprsz(desc);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 82aa14131b..652a72e972 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1448,8 +1448,8 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
     return true;
 }
 
-TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
-           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVT_hs, aa64_sme2, do_zz_fpst, a, 0,
+           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt_hs)
 TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvtn)
 TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
-- 
2.43.0


