Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FE2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgI-0007MK-3a; Mon, 29 Jun 2026 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg8-00075c-34
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg6-0007fd-9n
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4745492ed3aso411174f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734489; x=1783339289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TAfHLqwt5iHzf6/peRCXoSNhAQXJDY0rvTyHjXtfmmc=;
 b=hkYmpmSQEOieJmSAUs8fscij3zBuPynK4RFhUbsjlzA1PtU3xZmzON4R6bcY+5Xqbi
 rG6gBlYMTLddWb644dC2IkIChmpOVu/cZ3wBvGJXyTicXlI+bp/nRCJ5VRyySi+RSsFl
 2HAqrFn7Jc1vtgnQbDDa9GICBJBl6CMiFbuAvLpMKrWU9BbYYDsKUUSp5uam9JqpqKqS
 S/YTZpW/mY4Po5+e1hgokuziJcGhO6yT/+G67uWxH3IGfPej6iViy/TqFN7z+mnNhI5x
 co/l+dtiJdj9GcXl3jhqVEXAlAaqinkdgQ9uyWo27y5BgNW7wCjM8zX53OgHfmIYaeA8
 4jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734489; x=1783339289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TAfHLqwt5iHzf6/peRCXoSNhAQXJDY0rvTyHjXtfmmc=;
 b=RAZ6iJsxnhBVYvClqai6scYsbzs3kPiZZiJtwDe0hfyuHAG/FJj3Y0EvdbILIWPUiC
 Al4qTCt9QpynE5K52voqQKhztsoHpX2+d1p4jRvSE82JhFMqA0P646IrHsV11Y1Tizr2
 bJPW41gt/hqz5MyB1mJ7T+cjjIu8So95begXgpfk2ABXpOTESC7fQzSJw9Be6TTGfoLn
 OLwlt5nKSQ6NyfOXivVHIgWliwFDzck2IooskXOYiQkpfwkehNu3C2siMsWjHI0cgjy+
 OV/0CKIHEN0MLZcWKuIqZXGDZruiqVuKzhqdhcwxt1ofFTix+IqLBjUu3qb+LI9wDUS4
 wuiw==
X-Gm-Message-State: AOJu0YwT91IAD8yIlWEWNzyiiE8/UA4XUekkOOy7oisIXlpPLtk1x+K2
 juczBXRZ7f9mYstHkoc7dSwjlSDSA9c9o2YQO1GJFD3Sn6sTYkSm3IC2uAyBA6etBAijDgJ2UC1
 3QgP5
X-Gm-Gg: AfdE7cl7i7Q53qx0EAnRGijihgeIsWPS1FvB/LNySUjNfwCgjPK4EI4bPb336UquetZ
 +RQ03eVXhKFELgSuL7GECMmmvfBi2r1kIJ0hyIuTsc6Iq2OdUw7gSKxKS1jdRI/IoNBxq2J1zca
 aK7PqlvraH8AhZBLQARhm95WN4j4PCRUbpxS2i4xyOk8g5/FYf9J+DsrOvx2+KCyeji6OY/27eo
 pcEILOCKuL3UxFy1oKDPAOHx8fHzYPpm9YHrpBeEkIWA1TLcARhHSvCUEunJ5yu90GslFohI18n
 kEiHHi9pqR+a8yftNqW0nBOP54Bni9LkxF8D9jxmq+i4u0dxA3kwtS9VUWpKakctdPMKNcpqRko
 UkH4IjAwh4FeKvxCr+Skfr/PHDIUDxzDERKaY/bFgqM4I2JEWGyuK9NK6idjMHlm/fxNj291CAr
 X4rSuJgQqpkCn4g+XHrk71zIuemBGTTywNX5e4CjQa3vXm25fhde4+BFBVjnyNsj2Txay4e/Yt3
 s4WZxrZds8Z8TDmDbE7hA==
X-Received: by 2002:a05:6000:46:b0:46f:9d18:bd3c with SMTP id
 ffacd0b85a97d-46f9d18beafmr13295211f8f.12.1782734487766; 
 Mon, 29 Jun 2026 05:01:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/54] target/arm: Implement FVDOT (FP8 to FP16)
Date: Mon, 29 Jun 2026 13:00:30 +0100
Message-ID: <20260629120032.1645265-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
[PMM: fix wrong sizeof(type) for fp16 output]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260625015159.719300-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/fp8_helper.c      | 23 +++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/sme.decode        |  2 ++
 target/arm/tcg/translate-sme.c   |  4 ++++
 4 files changed, 30 insertions(+)

diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 5606f0fd8e..902e4b0ae9 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -950,3 +950,26 @@ void HELPER(sme_fvdot_idx_sb)(void *vd, void *vn, void *vm,
         } while (++i & 3);
     } while (i < elements);
 }
+
+void HELPER(sme_fvdot_idx_hb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    intptr_t oprsz = simd_maxsz(desc);
+    intptr_t elements = oprsz / sizeof(float16);
+    int idx_n = extract32(desc, SIMD_DATA_SHIFT, 1);
+    int idx_m = extract32(desc, SIMD_DATA_SHIFT + 1, 3);
+    float16 *d = vd;
+    uint8_t *n0 = vn;
+    uint8_t *n1 = vn + sizeof(ARMVectorReg);
+    uint16_t *m = vm;
+    intptr_t i = 0;
+
+    do {
+        uint16_t mm = m[H2(2 * i + idx_m)];
+        do {
+            uint16_t nn = n0[H1(4 * i + idx_n)] | (n1[H1(4 * i + idx_n)] << 8);
+            d[H2(i)] = f8dotadd_h(nn, mm, 2, d[H2(i)], &ctx);
+        } while (++i & 7);
+    } while (i < elements);
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 05bf8dbdc2..126dcadf77 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -43,3 +43,4 @@ DEF_HELPER_FLAGS_7(sme_fmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_7(sme_fmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_fvdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 160cf130d4..3a65e1ad4b 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -821,6 +821,8 @@ FDOT_nx_hb      11000001 0001 .... 1 .. 1.. ...10 0. ...    @azx_4x1_i3_o3
 FVDOTB_sb       11000001 1101 .... 0 .. 01. ....0 0. ...    @azx_4x2_i2_o3
 FVDOTT_sb       11000001 1101 .... 0 .. 01. ....0 1. ...    @azx_4x2_i2_o3
 
+FVDOT_hb        11000001 1101 .... 0 .. 1.. ....1 0. ...    @azx_2x1_i3_o3
+
 ### SME2 Add / Sub array accumulators
 
 ADD_aaz_s       11000001 101 000000 .. 111 ....0 10 ...     @az_2x2_o3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 267a6b0d9b..ff5554eefb 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1273,6 +1273,10 @@ static bool do_fvdot_sb(DisasContext *s, arg_azx_n *a, bool top)
 TRANS_FEAT(FVDOTB_sb, aa64_sme_f8f32, do_fvdot_sb, a, false)
 TRANS_FEAT(FVDOTT_sb, aa64_sme_f8f32, do_fvdot_sb, a, true)
 
+TRANS_FEAT(FVDOT_hb, aa64_sme_f8f16, do_azz_acc_fp8,
+           a->n, 2, a->rv, a->off, a->zn, a->zm,
+           (a->idx << 1), 0, false, gen_helper_sme_fvdot_idx_hb)
+
 static bool do_fmla(DisasContext *s, arg_azz_n *a, bool multi,
                     ARMFPStatusFlavour fpst, gen_helper_gvec_3_ptr *fn)
 {
-- 
2.43.0


