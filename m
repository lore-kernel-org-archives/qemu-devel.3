Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40833C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEM-0000N6-Ly; Fri, 04 Jul 2025 12:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEL-0000Lq-6F
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEJ-0006Ef-Ao
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so9789455e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646338; x=1752251138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eJFuT0WxcqICGZmitJ/XZejUQHP1th9lKbUxFGlZobg=;
 b=dK4hBqICIIJ7dQjGqEIRbfjVCc80HK9NCF6UtGInnPfDsROtlO3bt5JjI5mswyJEzQ
 75tm/Mg4YHLdGa0JNdKQkvbZtuVaOMGKR6aJL5O3RmzJZXjpovL4WugqooJP2igmUc2G
 U8P6rOb9tM5JoXBi66E4Gn+HObHvoXyVkPqj2zCyxie4elEWsMyItXT83C0D5Gba8tW4
 CqOgDneSRjhQ4x1ufYuwTvKOQRNA0BUL0itqcnZcDVFPzslO1aNZpszqNjftGPqozKdZ
 wtlrvhZcfeXoiW1NKf7MrqO1Y45v/TNUVokAC4EsfCuN+iSkJtgQT9VMMMD4ZVVAvcUF
 Z+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646338; x=1752251138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJFuT0WxcqICGZmitJ/XZejUQHP1th9lKbUxFGlZobg=;
 b=Ila8XgybUh0ltAipPODechl5hG4TUlxvAj87uVlTkDPEe3zekwOT52szbxVNYAUjyb
 mPqLbrpwaI83QzevQ4Qyl4etuEk4qkh5eJeZePYwtmoC50Kf98OifylI2MxuRx7vaDAz
 lStmunP/ydkqMEe9BIiQzc1BKsU59zh2zp4vRthW0Hp+DGEJdCl0CthHVM1PTxtNmRS1
 WVluZ+lW1++cNw0kU17pw27JiGkW0vrg/P2JQqFNvKMYslXXCo3kmkgZpYr0W0WcueA7
 26Qn+EWNAeUiHmJ4XMoGsk/QmQ30sGc2ZeKVMR2/OHl44AykxBLH01QIha/rouTFWBl5
 ar8A==
X-Gm-Message-State: AOJu0YyOGJfkoAopAe+1UnHsonlD4AN+8imiDbhiaoDkkoq+bPouMUug
 OVK+kUcLC2v5UoCv1vKveWKcfr93/JVUQAk7w6EsaHZrlPdzybbFY4Np5P18P8qaeNYV9bwt+Q4
 hvs/N
X-Gm-Gg: ASbGncvTKMR0vFGHVUOZ80qRq3wgKriMDeay67Laa4P3OGh05h3sKLmPkJsNOHaNCCq
 9oOb2bXUDqmPbNm9OTGehaNEXSgLwN6i6lJ2YrPwz7py23rZCt/kDIOw7gjQHztPSO2OeWE1bsf
 rkrLL1ncWBlnOp8zpvmCPB/4gPgkvtc9AWcOPEfI2f67kj205NvpvVZ81mEliWwge3EWe+mYIyj
 0VatiWzQyZcemvJXnf+M6XjuabVAelUatPjvbpWbIS7f/Ljo3sP56wBk4zlCGLqRMsrVcgydclD
 cexooxNKxqIjkVtO0gA1yr0s8K1YZqTX0lzNYo+YKjVXpS+EN7v+PLheKyiez3q9Ly4d
X-Google-Smtp-Source: AGHT+IHE4yqnPxRMGrE4RmJ/w/uuz6mLswwr1DfpCMcAlrW1kvC1d7kFkVZX4N3TlWrjOdVb5/ppVA==
X-Received: by 2002:a05:600c:3153:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-454b4ea5f53mr35214705e9.16.1751646337878; 
 Fri, 04 Jul 2025 09:25:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 038/119] target/arm: Implement SME2 MOVA to/from array,
 multiple registers
Date: Fri,  4 Jul 2025 17:23:38 +0100
Message-ID: <20250704162501.249138-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: <qemu-devel.nongnu.org>
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
Message-id: 20250704142112.1018902-27-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h     |  5 +++++
 target/arm/tcg/sme.decode      | 12 ++++++++++++
 target/arm/tcg/translate-sme.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 7336b7db721..a18d07540e6 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -210,6 +210,11 @@ static inline int plus_2(DisasContext *s, int x)
     return x + 2;
 }
 
+static inline int plus_8(DisasContext *s, int x)
+{
+    return x + 8;
+}
+
 static inline int plus_12(DisasContext *s, int x)
 {
     return x + 12;
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5eca5f4acff..37bd0c6198d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -27,6 +27,8 @@ ZERO_zt0        11000000 01 001 00000000000 00000001
 ### SME Move into/from Array
 
 %mova_rs        13:2 !function=plus_12
+%mova_rv        13:2 !function=plus_8
+&mova_a         rv zr off
 &mova_p         esz rs pg zr za off v:bool
 &mova_t         esz rs zr za off v:bool
 
@@ -88,6 +90,16 @@ MOVA_zt4        11000000 10 00011 0 v:1 .. 001 000 za:2       zr:3 00 \
 MOVA_zt4        11000000 11 00011 0 v:1 .. 001 00 za:3        zr:3 00 \
                 &mova_t rs=%mova_rs esz=3 off=0
 
+MOVA_az2        11000000 00 00010 00 .. 010 zr:4  000 off:3  \
+                &mova_a rv=%mova_rv
+MOVA_az4        11000000 00 00010 00 .. 011 zr:3 0000 off:3  \
+                &mova_a rv=%mova_rv
+
+MOVA_za2        11000000 00 00011 00 .. 010 00 off:3 zr:4 0  \
+                &mova_a rv=%mova_rv
+MOVA_za4        11000000 00 00011 00 .. 011 00 off:3 zr:3 00 \
+                &mova_a rv=%mova_rv
+
 ### SME Move into/from ZT0
 
 MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7d4c7d7e855..7b275dd2b84 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -298,6 +298,36 @@ TRANS_FEAT(MOVA_tz4, aa64_sme2, do_mova_tile_n, a, 4, false)
 TRANS_FEAT(MOVA_zt2, aa64_sme2, do_mova_tile_n, a, 2, true)
 TRANS_FEAT(MOVA_zt4, aa64_sme2, do_mova_tile_n, a, 4, true)
 
+static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n, bool to_vec)
+{
+    TCGv_ptr t_za;
+    int svl;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    svl = streaming_vec_reg_size(s);
+    t_za = get_zarray(s, a->rv, a->off, n, 0);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zr = vec_full_reg_offset(s, a->zr * n + i);
+
+        if (to_vec) {
+            tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, o_za, svl, svl);
+        } else {
+            tcg_gen_gvec_mov_var(MO_8, t_za, o_za, tcg_env, o_zr, svl, svl);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(MOVA_az2, aa64_sme2, do_mova_array_n, a, 2, false)
+TRANS_FEAT(MOVA_az4, aa64_sme2, do_mova_array_n, a, 4, false)
+TRANS_FEAT(MOVA_za2, aa64_sme2, do_mova_array_n, a, 2, true)
+TRANS_FEAT(MOVA_za4, aa64_sme2, do_mova_array_n, a, 4, true)
+
 static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
                     void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
 {
-- 
2.43.0


