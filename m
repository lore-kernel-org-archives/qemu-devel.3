Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011BBCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLY9-0001fb-0M; Wed, 10 Jun 2026 12:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLY3-0000rk-Ef
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLY1-0005eI-HP
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490be03d47bso61609705e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107976; x=1781712776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tzGzc3exx4mCieFx/ieLeRDvt5423vgELp9DrdtzgNU=;
 b=YDrqlIN1OjSJR3QMIlJnmZ9A7C5miVdjtiFp/d8Wt+rCWv04oCrU//WmS+9zzZvHBZ
 FiuvSAcHy+iF4DkYwYKVeZw6EFqJHdBwnknvZLOW8+XbEQOzrBVay4y4+2uLlSYWkoZj
 buRGZv+iphQ7ayvZ+NJX21j3zTQE9sEIQ+MFs7nsKdvBJn2Of/6qB0Aw7bbDVR+OJgkZ
 sh9hic9NvZd7RfA33/pWwfhnoSnajojelRrNYiU62Iw4KmpaHpTxvc0L/gM7ZY498DNw
 CyaJfuGmAb1slUkVotRiLRfnHXK/OPbztXunmj8ZQeEIbpnOqAHkT/523pmB+go/ab+Z
 3pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107976; x=1781712776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tzGzc3exx4mCieFx/ieLeRDvt5423vgELp9DrdtzgNU=;
 b=BAz9BWHP28YQrLyCPJvx4yxl2TFr6R048JM7G+xizwxezZ5Fdng+bYkhkeM2U44FxP
 HDGaSIMGe9MEdOdqUGujk1bUhT/g4mK6IHFnJXIN1KapMD7DwIv0fpL/v4+MKxpSpDKk
 7baMpiDiOJk19sWq5ft5KVqfXbB2r0c+kzuJ3ALG/LvXjHYoNkftnsI3ELZ+efG/pDcB
 IB/iBkwPvyWN+iImGfrVdKUgOdkDN+zLggGj38YzjhMAU1VzYTeTtJ4dexEYFRXsDHaZ
 Q3XNxRdYbzDUYvuJiGSaYFK7urDwTaq9XKaLGpWMWLx2UHRxl0THojwNhk9byoExEkMn
 9n7Q==
X-Gm-Message-State: AOJu0Yy25GUxZFzUif2E0+EkkHfZHdUNrzgcAdTSFpkwT6Q9OD05owuG
 yz4mv3y8dGuqNsNZ7CRpBEh+udJuR/t4UZR+Xoz4l46W3iXI8rXI3dxmlD1uavjzrg+mQbg7lDf
 5Kjqj
X-Gm-Gg: Acq92OGcKv3PjNicxRpeJ5ZXF+iA/VschqOj4NdjUuxdcPbtjj867RB6Ejms//55erz
 CG+wd0HFXpoyVYaYHm5Ta77o7gFr4EOQRhZ0iMRqpmMzQv7QiBOLfxDPMf2U915IaLQylq8v7c9
 x3NYmyLaSxu5d00Xo429gA6qM20LQqvVa/j/mTwkM5o6MKFTHVjDP+LqM3t8RGTMV1TwmpqjPBW
 DX4NiDnGB5EAqrxXi3azR2faF9+DMbJI5KagnkQH2NuzLEQzmzHSxn8gVs1ZkRThIPK/cT/bYlh
 b2jRigCkHB3okco6VajeZWVSquEXBzmE36lBtiTC33NUt3hwjtYjuHHU5vjqIsOhxHdlJ9BaG72
 8F5Dch0mgFfW4d/W4qiMX6axpLiSXHmjb+l6yAfc55QnZAcjAV8u9KYiE8mexEWdE+M8bg+557C
 r0aruxa7vpC87IkaCRQ6omSlNvnt/jok8BvN01jVDEHjaU2C1Jxevq8vr9K1zdg5Ce7MS+bojOK
 1BOL6CFW4iqgB5NzinW56kKLHmYMvKJ3cdY3n3ZxTo=
X-Received: by 2002:a05:600c:3b09:b0:490:b475:af32 with SMTP id
 5b1f17b1804b1-490c25f17d4mr439290265e9.23.1781107975996; 
 Wed, 10 Jun 2026 09:12:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/71] target/arm: Implement F1CVT, F1CVTLT, F2CVT,
 F2CVTLT for SVE
Date: Wed, 10 Jun 2026 17:11:29 +0100
Message-ID: <20260610161202.2235298-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/sve.decode        |  5 +++++
 target/arm/tcg/translate-sve.c   |  9 +++++++++
 4 files changed, 31 insertions(+)

diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 0f3c279696..75c89203fe 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -168,6 +168,22 @@ void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_cvt_finish(env, &ctx);
 }
 
+void HELPER(sve2_fcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H2(i)] = fcvt_fp8_to_f16(n[H1(2 * i + ctx.high)],
+                                   input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
 void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 718463422b..3021dafd44 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -9,3 +9,4 @@ DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e7984fa8e0..ca110f4bc1 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1091,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+F1CVT           01100101 00 001 000 001100 ..... .....          @rd_rn_e0
+F2CVT           01100101 00 001 000 001101 ..... .....          @rd_rn_e0
+F1CVTLT         01100101 00 001 001 001100 ..... .....          @rd_rn_e0
+F2CVTLT         01100101 00 001 001 001101 ..... .....          @rd_rn_e0
+
 BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
 BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 718a21de70..c47e79637e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4082,6 +4082,15 @@ static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
     return true;
 }
 
+TRANS_FEAT_STREAMING_IF(F1CVT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvt_hb, false, false)
+TRANS_FEAT_STREAMING_IF(F2CVT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvt_hb, true, false)
+TRANS_FEAT_STREAMING_IF(F1CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvt_hb, false, true)
+TRANS_FEAT_STREAMING_IF(F2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvt_hb, true, true)
+
 TRANS_FEAT_STREAMING_IF(BF1CVT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_bfcvt, false, false)
 TRANS_FEAT_STREAMING_IF(BF2CVT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
-- 
2.43.0


