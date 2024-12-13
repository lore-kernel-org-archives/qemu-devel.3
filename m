Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53302E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Yb-0003UK-Ty; Fri, 13 Dec 2024 12:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xg-0007iI-Gc
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xd-0001es-Oa
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:32 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385df53e559so1604215f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111208; x=1734716008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6CYlCkAXadMVLpj7YlTvLBxky39lmdyPLmwYujAWn20=;
 b=NCqIMSlTM7rKSk4ZadzfFNM5fxixVLMSDHzyL4R/Yl5i7KLUCiUHzLGULijqfy2SN1
 2j4e3Nq2gfI8WcRUUoUoYGTtnykVX2yYNDr2HmfAS0mBSPGmENw4WJtH9Yqo7/8kXsqT
 G3wMGg6k9NlcvrszA1wHXrAXX9iYeEHNDAAY3RQDDVkPC4sYYQHKyd+SHN7MchYZX6Ds
 jAYPYi1XPhHQqq7kVx7r00oCyeQiRZVOvqmbwHC/8fLM2lK3dwy23noG6vAkrVlA1XBK
 7yIHzaZA2YrE+75OF+CDk+eX0AxUpyy3xh5UKWAYDP/ZcUq/2HMR5Wrq3n+pMErZ2gw1
 J7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111208; x=1734716008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6CYlCkAXadMVLpj7YlTvLBxky39lmdyPLmwYujAWn20=;
 b=BQOoFRPuVdx7PFpoUX+XpF4t8r3txNwK4vbChVyFixPLdBuZwSlaw9MG5auKBghJFp
 s1GDkJ6BGb48uMBdshgeN3bYQ4rS50pMp/4rDy7w1/LYDGbisB34CHzxfFMZPoYqScR/
 1R75fs49kJgwbIm2qyRWCNKRmIx7lopnkMLi9CslXYrygWXovji2IROlgaqdd1JWl+6S
 FAtSH6IjcbzPoqGXP1nX9W2SQHVZGToup3lztckQ2XHqdHr7ZZqFVlDpTzI6SaIrPYCG
 CvIycj4HNG1vselcqau18q5s1i/XjstQ/pOvzyfChalGou86LP9o6iov7hwNDorsKqJf
 Ua6Q==
X-Gm-Message-State: AOJu0Yxk3b/iSlh0oCCu1LgKl/7pTB+tT8JxfoXwXLtRf+n6cD3lz3cg
 9TC9QaSAMCjCPo51IV/Vx/+5kbED3tkUCKBTgKqjNrx/IqrKSA2GVn5CJI0+Fu4bwvbKay8WmQR
 I
X-Gm-Gg: ASbGncvJ1MtucS6PK3/xF9gMLUihG4lm/zEsp1VSiFrlyilYYwaftGr/6vOETPXIg8C
 ACry12UFgUbt8LGwB00tbqFI1aO000TxylEVoIVYB7K/ZM4Icyvo/qamk3OqZwwk3QXByF7m6lw
 fRQzBb9nad9UdLnIBgj9QmE5HBni06UTDrng5QKqKswRFt0ao/4yFDUb58W8nCx90gxiiaR1qxV
 0rezKmm2vstyxW05ilw1Zk1KSrqGus9f1kl6hxDjn84WI0Rbj3RZm2i5SSduQ==
X-Google-Smtp-Source: AGHT+IGOpoCrNMKBvGLQL0z8p3kCtQr/NAzfW4oZFfICkCmXlK9lyN3J3vSP9RxrEMbkRjZVqir8pQ==
X-Received: by 2002:a05:6000:4609:b0:385:fac7:89b9 with SMTP id
 ffacd0b85a97d-3889ad37d7amr2725035f8f.59.1734111208195; 
 Fri, 13 Dec 2024 09:33:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/85] target/arm: Implement gen_gvec_fabs, gen_gvec_fneg
Date: Fri, 13 Dec 2024 17:31:57 +0000
Message-Id: <20241213173229.3308926-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Move the current implementation out of translate-neon.c,
and extend to handle all element sizes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-54-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h      |  6 ++++++
 target/arm/tcg/gengvec.c        | 14 ++++++++++++++
 target/arm/tcg/translate-neon.c | 20 ++------------------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index edd775d5640..b996de2c156 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -602,6 +602,12 @@ void gen_gvec_uaddlp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_uadalp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                      uint32_t opr_sz, uint32_t max_sz);
 
+/* These exclusively manipulate the sign bit. */
+void gen_gvec_fabs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz);
+void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 2755da8ac71..01c9d5436d4 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2697,3 +2697,17 @@ void gen_gvec_uadalp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     assert(vece <= MO_32);
     tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
 }
+
+void gen_gvec_fabs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz)
+{
+    uint64_t s_bit = 1ull << ((8 << vece) - 1);
+    tcg_gen_gvec_andi(vece, dofs, aofs, s_bit - 1, oprsz, maxsz);
+}
+
+void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz)
+{
+    uint64_t s_bit = 1ull << ((8 << vece) - 1);
+    tcg_gen_gvec_xori(vece, dofs, aofs, s_bit, oprsz, maxsz);
+}
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 0821f10fad5..b9b3d1c1fbc 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3041,14 +3041,6 @@ static bool do_2misc(DisasContext *s, arg_2misc *a, NeonGenOneOpFn *fn)
     return true;
 }
 
-static void gen_VABS_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                       uint32_t oprsz, uint32_t maxsz)
-{
-    tcg_gen_gvec_andi(vece, rd_ofs, rm_ofs,
-                      vece == MO_16 ? 0x7fff : 0x7fffffff,
-                      oprsz, maxsz);
-}
-
 static bool trans_VABS_F(DisasContext *s, arg_2misc *a)
 {
     if (a->size == MO_16) {
@@ -3058,15 +3050,7 @@ static bool trans_VABS_F(DisasContext *s, arg_2misc *a)
     } else if (a->size != MO_32) {
         return false;
     }
-    return do_2misc_vec(s, a, gen_VABS_F);
-}
-
-static void gen_VNEG_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                       uint32_t oprsz, uint32_t maxsz)
-{
-    tcg_gen_gvec_xori(vece, rd_ofs, rm_ofs,
-                      vece == MO_16 ? 0x8000 : 0x80000000,
-                      oprsz, maxsz);
+    return do_2misc_vec(s, a, gen_gvec_fabs);
 }
 
 static bool trans_VNEG_F(DisasContext *s, arg_2misc *a)
@@ -3078,7 +3062,7 @@ static bool trans_VNEG_F(DisasContext *s, arg_2misc *a)
     } else if (a->size != MO_32) {
         return false;
     }
-    return do_2misc_vec(s, a, gen_VNEG_F);
+    return do_2misc_vec(s, a, gen_gvec_fneg);
 }
 
 static bool trans_VRECPE(DisasContext *s, arg_2misc *a)
-- 
2.34.1


