Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A6AC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80X-0007Qt-5z; Thu, 06 Feb 2025 14:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80H-0007Fe-Ky
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:39 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80F-0000YO-JX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:37 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fa21145217so540659a91.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871854; x=1739476654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yQG/JZUJN3De10B8fCU7OOg4fPLVxH4C3YmmWb37OE=;
 b=sblUhMtYqNrXo+qr+6uxk0I9QlXp/t6dOpJI5b6tmOO7PzRjmIL9nlEdUJoSLORc9z
 Ff0ZwwP/ATr1HRQCCc7XJ1hbUhuqkaGVwY6R4uHEuo9yz98AboRqxDwlf1g/KWY+8O3v
 SsemM3dQNGqE/CI3sn8p+wm08NVfQxbl9PQIai+y2Reew/nDv4UUNSz2HsrHW1b6IVjY
 3wOhsQSdt07Ri5skSEDFJdt2UaTuC4cNCvZZDDVFuUoNpjuvwLznLSDBtvILgMPwJRKR
 O5v335eim7OzIvE0nUBxaxo5um6PicXHHHEvKpHvsVsFj0Z/qBH/E23Z3FKHwf4Eqmsc
 /DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871854; x=1739476654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6yQG/JZUJN3De10B8fCU7OOg4fPLVxH4C3YmmWb37OE=;
 b=ga09dMtLdfpLmGdeXU1NhHwlmuOKnXG4QNG+eCsG/gll7AESuCLyCzORTMQNG96iWc
 BdY+lwq49/TCDm7x4x3Cujef7J5Cv8O0uu9rnJKoDN1QU3eTfrSzz8ww4hi3LtO32mKf
 3PBxj8XSVUyfWCTjeRelFoEJD6a/IIkvnzFvGRr/sM9IZtPQeG0U5Ik1aQ4DIlzPp25k
 wAlrTJjRZwrsajlRJzq65nH53KFMb37izlGEpAIw1x2XYNBZPdwHiPlmSI7kKX4O6bIM
 H6UFraqgPJEPG1ci0k2rxo7QJmRm14REemjtcUQVoCCE6e4C6ZW14IbwVCGTmwpivJbE
 2XNA==
X-Gm-Message-State: AOJu0Ywu29acpS1t3xUWk+dhuKDWJwXyzWiLks90ETk3/n/d455Vkf81
 QK5eVwCBkkURl18TDU/clretoAAWzajXcQqBLg71PhTA+3BIZX+AR/gxVunBZiCNJyAJpFSze5v
 B
X-Gm-Gg: ASbGncsaRGwFRGQhpNk0ZTMv9qISvA5BObZFaQ3SVUwJxHkJtezZHb0GUYIjhI5ceuR
 gQDirmMY79JArDZfljIj7eAbWAb3BzJazQ9wWTRk3OHPqyeURD+azoOaK0q7lTyRnDFwp/PbFrL
 cGzVnW13H4H33RPpfFWl0b5DE0Tt4rrQRq+drFEg1ZM9b5d8jnxOJFaeNGYUAyylObenBYN6Y2v
 x5hNJoyIhbfn+7osinKq7kULXQhXO5X16E/4oC6OXg5l4oyDZSuZuBKNFX+fcqBaJ6KlBsc6QBM
 S7IgG5Ap/hyXS3l09PKCNm3RHLBSDA2r4u6Bdb9Jww6cTtM=
X-Google-Smtp-Source: AGHT+IHBjENCHHP5feFG5yRm3zvudTLshkYIFzLVMuObxCv4EAxFy4kYo/v9MlGMp3dBNKu5P4ndEA==
X-Received: by 2002:a05:6a00:3016:b0:725:e499:5b86 with SMTP id
 d2e1a72fcca58-7305d546034mr1030433b3a.20.1738871853734; 
 Thu, 06 Feb 2025 11:57:33 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 23/61] target/arm: Implement SME2 BMOPA
Date: Thu,  6 Feb 2025 11:56:37 -0800
Message-ID: <20250206195715.2150758-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 target/arm/tcg/helper-sme.h    |  3 +++
 target/arm/tcg/sme_helper.c    | 34 ++++++++++++++++++++++++----------
 target/arm/tcg/translate-sme.c |  2 ++
 target/arm/tcg/sme.decode      |  2 ++
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 8246ce774c..17d1a7c102 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -153,3 +153,6 @@ DEF_HELPER_FLAGS_6(sme_sumopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sme_usmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sme2_bmopa_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index ee81bece12..6d8e2cedc9 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1267,17 +1267,31 @@ DEF_IMOP_64(umopa_d, uint16_t, uint16_t)
 DEF_IMOP_64(sumopa_d, int16_t, uint16_t)
 DEF_IMOP_64(usmopa_d, uint16_t, int16_t)
 
-#define DEF_IMOPH(NAME, S) \
-    void HELPER(sme_##NAME##_##S)(void *vza, void *vzn, void *vzm,          \
+#define DEF_IMOPH(P, NAME, S) \
+    void HELPER(P##_##NAME##_##S)(void *vza, void *vzn, void *vzm,          \
                                   void *vpn, void *vpm, uint32_t desc)      \
     { do_imopa_##S(vza, vzn, vzm, vpn, vpm, desc, NAME##_##S); }
 
-DEF_IMOPH(smopa, s)
-DEF_IMOPH(umopa, s)
-DEF_IMOPH(sumopa, s)
-DEF_IMOPH(usmopa, s)
+DEF_IMOPH(sme, smopa, s)
+DEF_IMOPH(sme, umopa, s)
+DEF_IMOPH(sme, sumopa, s)
+DEF_IMOPH(sme, usmopa, s)
 
-DEF_IMOPH(smopa, d)
-DEF_IMOPH(umopa, d)
-DEF_IMOPH(sumopa, d)
-DEF_IMOPH(usmopa, d)
+DEF_IMOPH(sme, smopa, d)
+DEF_IMOPH(sme, umopa, d)
+DEF_IMOPH(sme, sumopa, d)
+DEF_IMOPH(sme, usmopa, d)
+
+static uint32_t bmopa_s(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg)
+{
+    uint32_t sum = ctpop32(~(n ^ m));
+    if (neg) {
+        sum = -sum;
+    }
+    if (!(p & 1)) {
+        sum = 0;
+    }
+    return a + sum;
+}
+
+DEF_IMOPH(sme2, bmopa, s)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8a901f158c..25139cb7aa 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -507,3 +507,5 @@ TRANS_FEAT(SMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_smopa_
 TRANS_FEAT(UMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_umopa_d)
 TRANS_FEAT(SUMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_sumopa_d)
 TRANS_FEAT(USMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_usmopa_d)
+
+TRANS_FEAT(BMOPA, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_bmopa_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 37bd0c6198..de8d04cb87 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -165,3 +165,5 @@ SMOPA_d         1010000 0 11 0 ..... ... ... ..... . 0 ...      @op_64
 SUMOPA_d        1010000 0 11 1 ..... ... ... ..... . 0 ...      @op_64
 USMOPA_d        1010000 1 11 0 ..... ... ... ..... . 0 ...      @op_64
 UMOPA_d         1010000 1 11 1 ..... ... ... ..... . 0 ...      @op_64
+
+BMOPA           1000000 0 10 0 ..... ... ... ..... . 10 ..      @op_32
-- 
2.43.0


