Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E12C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7sr-00041c-Ao; Wed, 12 Aug 2026 08:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sq-00041K-9z
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sl-0008TJ-Fh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so7803915e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786536990; x=1787141790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z5zj04oLCqK4rU9GyIrSuq0uJ3klWGkxX80UdVC+ysU=;
 b=d1wYI4Y1bk1+pipW2tcvHGL9EeULxjnGRXaJSd68+sB4/c+4rTDUmUQwt9zqAw6Jzf
 b53MpyCEDZgRDSZVZbD8W9+0b5/+erVOLC5jFFbERJ18OBDX4FbmByEjD+jhwNUfHU69
 YyUJlZYefopGq90UB5noTyb1H47w1dzBRAH1S8NaFlIvUtbuePoSIP3KrFlLt2bdWOKC
 GeEPp8qWlDd5lJogmSKqOfl5LAsejr0O9Mmm+5Rh9FPEuBWm9viV9OQEVRF/zDPk2SZl
 Y3bdefdM63+erRPlGMBJBL3hd/CaokxvQGL9Zq94gsyg4YbDbAHH15tB5vaunU2TGmcm
 AZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536990; x=1787141790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z5zj04oLCqK4rU9GyIrSuq0uJ3klWGkxX80UdVC+ysU=;
 b=OyKLhm3wn6I++qRRpzc46Jm3vQoNJ0LJJ86a/eYZAzj1etdfew3rM/aFnT8gARUyva
 eHEsXp1bOH3FsMole8c2UeOeSE8npJvWqzszmot+GB5xfttmThwp4uW510ZEtZ4m0PNv
 eJUwqNk+8usvDZCLf1oUuFY8jROHbhDtdy7HvxaLhKaHYRjZ2IDU9sswpMp9Bt4nuztL
 Yo3QYZpwgE5PqspNApcouVaUmpdYxfLhrUV7AWMWwkCLbvdRG8I56arZeP5CyDvOMsMN
 EqXYN3vU0KSY3yy9/aoqd9HXpXafxncW0Zj+8f/wCNeLso0Vg7R5XWIC0sj+mT75e1us
 TCpA==
X-Gm-Message-State: AOJu0YzEKVKQvAfpFX4uUbY4dQ12Sttfy6RSbkL3hDUB1/LwlgAEnu2q
 IekrjuP1E/012b0mDM/K5uJOFdK7irZ84rFa94mL+b4jGPZj/gIwVjIi7TCtXCYImzmJ4Htouuo
 f1TOE
X-Gm-Gg: AR+sD12kmHJKY60O2LWBn2Fe16mhDx3LMEQ8HuJ4Qid1ncf0M5zzw9Z1POxZOM92tr1
 mjFjmXH7LMzGlE7VgyVzQQ0Mexqq4BgW5RO8UmVb/4cLPaPf+RhJIS1lnzQ7plNOlvAlsogSPrJ
 OwKfcUC1lo4R/7VK9+vK5nFBXFXlb3NBhZoNHAlL9fDT43Wqqfy2HY3yXsnwNNPjW2HH5mPFl1/
 Xc2lodrbWZQ42WLbj1BCNUaxWVE2GD4hD+Sn2MPCgxXfgg0rZ7YuTtp3C3WWE/JEoO6hdD0LhYK
 epo7/YAJrGEWwsPo1DyNspBWKzl3mlIwUAgUjV5n4Ituyox9aOtvFTtmEOLveHOXqc4aRV+HeNe
 +pDaKM5TgwVaUZYhNtk7eeS5rt5PmpZ3ZnvDcXsJy02ELsydkhoHS2eushJIgK1kKbJBdOLaJLR
 3yr7uNFEebMu8QPWn0DqW25khpGUYLw9N2oSAmBHNscWBHZuyp9o2RFEUuUxGzGCYGIq1Q5r2Jm
 m0pX4snNfPJgxKBphv6kkSuFLwcIxdgCGuenyLYUql0zFCj9JJ+tLX1WkzG+jJwuFzGFe5xVRB+
 ykjl
X-Received: by 2002:a05:600c:8b52:b0:495:4491:b8c2 with SMTP id
 5b1f17b1804b1-4997c0e6f2emr73873955e9.3.1786536989656; 
 Wed, 12 Aug 2026 05:16:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/26] target/arm: Implement FTMOPA (non-widening, FP16)
Date: Wed, 12 Aug 2026 13:15:58 +0100
Message-ID: <20260812121622.649730-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713230244.70174-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        | 5 +++++
 target/arm/tcg/helper-sme-defs.h | 1 +
 target/arm/tcg/sme.decode        | 3 +++
 target/arm/tcg/sme_helper.c      | 6 ++++++
 target/arm/tcg/translate-sme.c   | 2 ++
 5 files changed, 17 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 6370c03e2a..4190398a1d 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1842,6 +1842,11 @@ static inline bool isar_feature_aa64_sme_mop4_i16i64(const ARMISARegisters *id)
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_i16i64(id);
 }
 
+static inline bool isar_feature_aa64_sme_tmop_f16f16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f16f16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 8107eb40af..84707e6c71 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -405,4 +405,5 @@ DEF_HELPER_FLAGS_4(sme_usmop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_usmop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_usmop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_6(sme_ftmopa_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sme_ftmopa_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 0250177d0d..16ed3ca391 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1137,7 +1137,10 @@ USMOP4_dh       1010 0001 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 &tmop           zad zn zm zk idx
 %tmop_zk        10:3 !function=expand_tmop_zk
 
+@tmop_o1        .... .... ... zm:5 ... ... .... idx:2 ... zad:1 \
+                &tmop zn=%zn_ax2 zk=%tmop_zk
 @tmop_o2        .... .... ... zm:5 ... ... .... idx:2 .. zad:2 \
                 &tmop zn=%zn_ax2 zk=%tmop_zk
 
+FTMOPA_hh       1000 0001 010 ..... 000 ... .... .. 100 .       @tmop_o1
 FTMOPA_ss       1000 0000 010 ..... 000 ... .... .. 00 ..       @tmop_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 571b0add34..49fd3d07e4 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2693,6 +2693,12 @@ void HELPER(sme_fmop4a_hh)(void *vza, void *vzn, void *vzm,
     sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_fmop4a_hh);
 }
 
+void HELPER(sme_ftmopa_hh)(void *vza, void *vzn, void *vzm, void *vzk,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_tmop(vza, vzn, vzm, vzk, fpst, desc, MO_16, inner_fmop4a_hh);
+}
+
 static void inner_fmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
 {
     float16 *d = vd, *n = vn, *m = vm;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 3cfd52dca4..5ad59ab99b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2156,5 +2156,7 @@ static bool do_tmop_fp(DisasContext *s, arg_tmop *a, MemOp esz,
     return true;
 }
 
+TRANS_FEAT(FTMOPA_hh, aa64_sme_tmop_f16f16, do_tmop_fp,
+           a, MO_16, FPST_ZA_F16, gen_helper_sme_ftmopa_hh)
 TRANS_FEAT(FTMOPA_ss, aa64_sme_tmop, do_tmop_fp,
            a, MO_32, FPST_ZA, gen_helper_sme_ftmopa_ss)
-- 
2.43.0


