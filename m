Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746E7CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPn-0008KI-Ey; Sat, 16 May 2026 20:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOr-0007Fb-Sw
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOl-000544-BW
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82faf871346so869736b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977825; x=1779582625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLgm9UDQEHLrvYYVImCj/f7lgJUJBmTicj8qoBhaXM0=;
 b=KepTBpZn7mFbolK24gdbIea7ECowoct3RpMh66SI5HQVanADGaJWpeZHUc5p5VAG7x
 2B4Bikb+NLfRKfPA0sScGWYmp2x/xaQwzp8HdMHS3enIc1/C/HzjO8XHBunQy7WhsNrb
 a8sjAWaMmDSSpPMgvDDIkHP7oWdO3sOqxkuYqtFbrdPBQvSL1O/sCk9MfbX5/JxaSYPp
 2Kfn3MgSmsCNSYFguMYmG0SsKaEa6Al0ma8zWGkdo9X/57cadWxJaFkpi7Wgp+bprIH9
 WyOiox08693u+lthFN0lujNOg/p/MEommwcGZhZThtN7azF5dJPQHdTv8x5hym2iCYFG
 rvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977825; x=1779582625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jLgm9UDQEHLrvYYVImCj/f7lgJUJBmTicj8qoBhaXM0=;
 b=eJO9EzPBfhnhKUMwiZNQc1VRDF35T0cQW6y3cj6gA6+fKVgBhzohskBOAiKA3SSt7A
 /fORpzRlrjuwbbkC6zWrkmkJHZTnTh8NgfcL+EpoYQjbXtSEtp2Wu0IwLVflGl40KImA
 4ncULc/uGqtNMchKBES9jH5QuSGcE+yk5OBfQPL0YmsPKU281hQm3L5x6amaiDzlkoS0
 vc6YQRmAII2Dr3XK9VujhMcgZIjx/LAynGFu/XrI3dS1w3nW07T//jn9d6jgdNHpH+rf
 223oPQFkPuCH8j1o4hDyR5U6Y6mXO7sJljyaODKCnvWxtq4Za1QAIh4aL4tCbCOQYRFX
 82vg==
X-Gm-Message-State: AOJu0YwG2P7OiqfkRuJs6Rol8c/qqyYJ5GCPKM0M7m290RcYIsurhyTA
 qALb9DEBEZ5KbU+7W3E9QuKCAUkcbqL6AGcbLVSY9BLyD0f8k68GKZgcF1KaHmQHQ5tbJOvejwi
 ytEGe
X-Gm-Gg: Acq92OE6ROUFQ4wK1HQnkKfOpqhs8UyyY7iP9qT/kV47ldPbnVG1m7zH979Q6ixF2wl
 SPXyLV0OxDBGBPP9BK+aoYDbCQ+yVKI9kYi+rsoMU/uc1tZQyOOTokuJjOnuOBivf8MKvLSY3sV
 dNnmeUUQ+d3W4wW2xUqe3yaOsvX772onW0IZqt7zAQwR9/2K2fzesAHHDc4k/ABxJ4SSlUDLmUN
 SfdDjK1kb8SIUtzmxdz+ZnZAwVt4zGGwE5JOnLZPYcinCGk4AR91aMvG54bcV+qtHj7gUZ7m7nk
 NsjhdF2V0XWaBHmhmfpQJ0RLhHrcP37o9sTg2cGiJyPoPHkJritQw4lOba7zXM4rTop4eY9NvT2
 9RSg2lBo7hvvSJvs5OYn3zAcoXN9iFVAjvJsbXspncM9TDnPSsZuHMsCZpRYRA+vYFH4Ob5N1Un
 6mR8Al+ieBtv0BKI3oz8NdFlzeLfu3
X-Received: by 2002:a05:6a00:390f:b0:838:af72:fb2f with SMTP id
 d2e1a72fcca58-83f33aec2a5mr10335136b3a.6.1778977825480; 
 Sat, 16 May 2026 17:30:25 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 25/63] target/arm: Rename SME BFCVT patterns to BFCVT_hs
Date: Sat, 16 May 2026 17:29:24 -0700
Message-ID: <20260517003002.321430-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

The existing pattern is BFCVT (single-precision to BFloat16).
In preparation for introducing more insns of the same name,
append the operand sizes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 2 +-
 target/arm/tcg/sme_helper.c      | 2 +-
 target/arm/tcg/translate-sme.c   | 4 ++--
 target/arm/tcg/sme.decode        | 2 +-
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
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 7ef6f5d71b..30355662d9 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1726,7 +1726,7 @@ DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
 #undef DO_MLALL_IDX
 
 /* Convert and compress */
-void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+void HELPER(sme2_bfcvt_hs)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
     ARMVectorReg scratch;
     size_t oprsz = simd_oprsz(desc);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e2d17de165..88c1d78c40 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1448,8 +1448,8 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
     return true;
 }
 
-TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
-           FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVT_hs, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvt_hs)
 TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_bfcvtn)
 TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
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
-- 
2.43.0


