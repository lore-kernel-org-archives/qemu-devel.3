Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182E6C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zE-0005By-Nn; Sat, 21 Jun 2025 19:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z8-00058H-44
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:58 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z6-0004Us-A4
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:57 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so3128698b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549855; x=1751154655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ICByI+4ExTYH+S11FCLkD5JW+Oc5NQlro8bLkrVImyw=;
 b=rahywydNqSG2LfY43vhIsuuZCksey1kFmn1ezU/C+qgcSaJ7miu7mgRPSAm+qV0Yg8
 NnjP3jbXvjCAgXOfnwQNLAbIQr5/ecqZiplwhmKJnAYvz9NPYk/q7BYl2Buce1mqoz+D
 P5uA0sbEErk6tnQpx2N2B40vV77iPuSBiOMaSJQyhwIQ+8CXxtLTOkXTJBqPw/owW5jx
 Iz7L6S8nT8B7E5Pn0sz2FWi6My8VmSaGJOkym72o+m7GMKKbhFHhPiniR94C6145N5Qm
 xAqICQLZypwV7E1b16NN1v3GtBjEz9GFSy6OxSrgYOeK7QX/L4KbYu5ro+yGAaataJLs
 KJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549855; x=1751154655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICByI+4ExTYH+S11FCLkD5JW+Oc5NQlro8bLkrVImyw=;
 b=m4SRbAggRevydCfd1wfReevKn+vQvig+RnN3cXQ6/K5ecrn9MrCYCxlQy1Y5/pDi/s
 Uxy5tTJw/wYklbq2sf6ZkdkqFjV5S4uT5CaLLtX5br2sVsqXx7NBdnyeRrZmYlYMNw0E
 lWFwdgfGwcEQ2ZrxSY+06d0C2zQSKOELDwSLmwrFWQLztRW4DOonWL6VS5n6oYC0bhZH
 r9N6KdnogNw93730zZPPU413Jln4EsD5gCAB0hJeCg1t1NiWLjTbzeFX9thsYNtasXex
 aYuUFemXng3cJCAU8asMzUqz4M6IqtAwJODtG1zg9PD0hNmp0NClzG7PNA/qUEfTRUi8
 /lRQ==
X-Gm-Message-State: AOJu0Yy7qHokFoSfmb8CqETMIUK6bByZogwVkXw2oCX48Sl5+Yd1y7f5
 DpUJlpA2rfy0ZLwiCrNOEq+THK1pBfsNQXjofhoqZ3Xi+Zzo9vUZooPlRcmIYd/9UuiulaURNTg
 07XF1
X-Gm-Gg: ASbGncsdT1qwAC6uQ+PbyjgdxuH3mcd8i+aseAyCz04l7zjugQj6n7xnXRtP2VBk4KO
 8gPW08z9+hrjU7Gm74VW5zWwoabXn95Vhw3r0qsa8aicLs7YQrf/+vNhAYZnb1f74zTkXz+h3WF
 Rl9armWMXlYzw5L1z183J+Fg8zB2SPaF58g9bZqOqXCscs+l4O4ovebhLSSNAOej0XBFVDWk+kD
 yp43cfbDAQjq+fOZYe6EULNmUWSzObO6T9Fl/ZldG1NXA3mkeL3gNH+2a2H05NZIA5R3EzvjBTu
 93gLtolKLbiADjYZaqw1yRQgInQQDJPAJZ9IEzlAqXxMsm4E2JHZ2zM8GXqnU9Z8gyvVb1YpXWR
 A/ps1yEfYdkMWLRRen01yNNlmplYUcUU=
X-Google-Smtp-Source: AGHT+IFwBd7GHHqE9ShE7/o3/IrYvakHKfRyJA16OMsvmCsTH6Gu4ux6+n8LWkUGU9/YBc1SRhTuKw==
X-Received: by 2002:a05:6300:628c:b0:220:4750:1fb1 with SMTP id
 adf61e73a8af0-220475021a3mr1401999637.4.1750549854974; 
 Sat, 21 Jun 2025 16:50:54 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 025/101] target/arm: Implement SME2 MOVA to/from array,
 multiple registers
Date: Sat, 21 Jun 2025 16:49:21 -0700
Message-ID: <20250621235037.74091-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     |  5 +++++
 target/arm/tcg/translate-sme.c | 30 ++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 12 ++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 5153824a49..a083b18ea3 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -209,6 +209,11 @@ static inline int plus_2(DisasContext *s, int x)
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
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a818a549cb..8a901f158c 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -268,6 +268,36 @@ TRANS_FEAT(MOVA_tz4, aa64_sme2, do_mova_tile_n, a, 4, false)
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
+    t_za = get_zarray(s, a->rv, a->off, n);
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
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5eca5f4acf..37bd0c6198 100644
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
-- 
2.43.0


