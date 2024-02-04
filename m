Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22B6C48292
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEY-00020I-Ii; Sun, 04 Feb 2024 16:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEX-000203-Tz
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:01 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEW-0003US-8f
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d74045c463so29331815ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082859; x=1707687659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2xt3v9hngTFbwI41n9Aj+nylg/m+N+vO+1fc4NZ/KE=;
 b=L1CJLyLOL8xuN5b59GI+Nscww4WKGYBIbCIiJBJfvu+1hLJO2LiSIPNZhZFZ9hv3XH
 yClFCRFo0ZhE0DQ8q0GxA65rfyInEn9tWFVN1lnXQmAzRs1DzdaKG3y8K8yYuNmrsG+M
 +YVbNvJBc5sAZmxDKelbY68aFF5UQzpDUYNehMQCr8Zawfs7tSjhKawLxffbDJePda4V
 rYl/kzE7nnLLnUc0RwsY3wBMjpEBVniu7BqegR1BjXc9mcPpwhmG9v5oabQ4oiF6KleM
 FkR2SZgZBCyZJNYcA+ynEWgjM0RxwSnNbmwU4FRH/Ni1ll9GQKj1Z1K6ic7GF16dhcCs
 7+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082859; x=1707687659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2xt3v9hngTFbwI41n9Aj+nylg/m+N+vO+1fc4NZ/KE=;
 b=Pp8gLHwyZlGy+51AISnXejRUSkrPwClud8vd4VRm0JndD2OFiYi2cvFThnR+EAL1Zl
 LKY8QMEI66lJ08R0XZpXMksCl/eI6ROTlfivxCCAKxBX50QZK8C/2QhIPna0hLn3UT9e
 TUp/9sn4cf4QUpO2lU2l9SR2vbstPpe0VYM3MkKCpgT0FH/VQKfCvO+u9/7jUAUpAved
 8JQqb4ZorC+k/yJoEs7RYCb+KFyenv1dJBjwrKYk6G/9SRjdZVJuDOw/QWis2j2tXU7G
 Jp8sxKUO13seJGALzacWNUmls2agbcnp0MCrlu1STm5GQafyLyXJRtxFZDBaFTJJVTQM
 3G/g==
X-Gm-Message-State: AOJu0YzIOa+k27tHjIYTj4B2cQmOMXpoyMw1ZMSZlf7+NEyFTLd3SeV2
 FZKwwrXobv9AcQt6F0eQn4COLKD1JDQW2txQM4LvpyJ/+ftTwsNzeExMcjAVhJmoT/2p+1p1rwI
 CaVM=
X-Google-Smtp-Source: AGHT+IE41lNFMvmPTtKp4rHlt7RPWJ8LedG7eSOtxX3qOGLqOoeS971NSozcUC8UZ/Ni2j+DUjYEVA==
X-Received: by 2002:a17:902:f551:b0:1d9:95c5:296e with SMTP id
 h17-20020a170902f55100b001d995c5296emr3751432plf.53.1707082858825; 
 Sun, 04 Feb 2024 13:40:58 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:40:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/39] tcg: Introduce TCG_COND_TST{EQ,NE}
Date: Mon,  5 Feb 2024 07:40:14 +1000
Message-Id: <20240204214052.5639-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add the enumerators, adjust the helpers to match, and dump.
Not supported anywhere else just yet.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-cond.h | 74 ++++++++++++++++++++++++++++++------------
 tcg/tcg.c              |  4 ++-
 docs/devel/tcg-ops.rst |  2 ++
 3 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-cond.h b/include/tcg/tcg-cond.h
index 2a38a386d4..5cadbd6ff2 100644
--- a/include/tcg/tcg-cond.h
+++ b/include/tcg/tcg-cond.h
@@ -29,26 +29,34 @@
  * Conditions.  Note that these are laid out for easy manipulation by
  * the functions below:
  *    bit 0 is used for inverting;
- *    bit 1 is signed,
- *    bit 2 is unsigned,
- *    bit 3 is used with bit 0 for swapping signed/unsigned.
+ *    bit 1 is used for conditions that need swapping (signed/unsigned).
+ *    bit 2 is used with bit 1 for swapping.
+ *    bit 3 is used for unsigned conditions.
  */
 typedef enum {
     /* non-signed */
     TCG_COND_NEVER  = 0 | 0 | 0 | 0,
     TCG_COND_ALWAYS = 0 | 0 | 0 | 1,
+
+    /* equality */
     TCG_COND_EQ     = 8 | 0 | 0 | 0,
     TCG_COND_NE     = 8 | 0 | 0 | 1,
+
+    /* "test" i.e. and then compare vs 0 */
+    TCG_COND_TSTEQ  = 8 | 4 | 0 | 0,
+    TCG_COND_TSTNE  = 8 | 4 | 0 | 1,
+
     /* signed */
     TCG_COND_LT     = 0 | 0 | 2 | 0,
     TCG_COND_GE     = 0 | 0 | 2 | 1,
-    TCG_COND_LE     = 8 | 0 | 2 | 0,
-    TCG_COND_GT     = 8 | 0 | 2 | 1,
+    TCG_COND_GT     = 0 | 4 | 2 | 0,
+    TCG_COND_LE     = 0 | 4 | 2 | 1,
+
     /* unsigned */
-    TCG_COND_LTU    = 0 | 4 | 0 | 0,
-    TCG_COND_GEU    = 0 | 4 | 0 | 1,
-    TCG_COND_LEU    = 8 | 4 | 0 | 0,
-    TCG_COND_GTU    = 8 | 4 | 0 | 1,
+    TCG_COND_LTU    = 8 | 0 | 2 | 0,
+    TCG_COND_GEU    = 8 | 0 | 2 | 1,
+    TCG_COND_GTU    = 8 | 4 | 2 | 0,
+    TCG_COND_LEU    = 8 | 4 | 2 | 1,
 } TCGCond;
 
 /* Invert the sense of the comparison.  */
@@ -60,25 +68,49 @@ static inline TCGCond tcg_invert_cond(TCGCond c)
 /* Swap the operands in a comparison.  */
 static inline TCGCond tcg_swap_cond(TCGCond c)
 {
-    return c & 6 ? (TCGCond)(c ^ 9) : c;
+    return (TCGCond)(c ^ ((c & 2) << 1));
 }
 
-/* Create an "unsigned" version of a "signed" comparison.  */
-static inline TCGCond tcg_unsigned_cond(TCGCond c)
+/* Must a comparison be considered signed?  */
+static inline bool is_signed_cond(TCGCond c)
 {
-    return c & 2 ? (TCGCond)(c ^ 6) : c;
-}
-
-/* Create a "signed" version of an "unsigned" comparison.  */
-static inline TCGCond tcg_signed_cond(TCGCond c)
-{
-    return c & 4 ? (TCGCond)(c ^ 6) : c;
+    return (c & (8 | 2)) == 2;
 }
 
 /* Must a comparison be considered unsigned?  */
 static inline bool is_unsigned_cond(TCGCond c)
 {
-    return (c & 4) != 0;
+    return (c & (8 | 2)) == (8 | 2);
+}
+
+/* Must a comparison be considered a test?  */
+static inline bool is_tst_cond(TCGCond c)
+{
+    return (c | 1) == TCG_COND_TSTNE;
+}
+
+/* Create an "unsigned" version of a "signed" comparison.  */
+static inline TCGCond tcg_unsigned_cond(TCGCond c)
+{
+    return is_signed_cond(c) ? (TCGCond)(c + 8) : c;
+}
+
+/* Create a "signed" version of an "unsigned" comparison.  */
+static inline TCGCond tcg_signed_cond(TCGCond c)
+{
+    return is_unsigned_cond(c) ? (TCGCond)(c - 8) : c;
+}
+
+/* Create the eq/ne version of a tsteq/tstne comparison.  */
+static inline TCGCond tcg_tst_eqne_cond(TCGCond c)
+{
+    return is_tst_cond(c) ? (TCGCond)(c - 4) : c;
+}
+
+/* Create the lt/ge version of a tstne/tsteq comparison of the sign.  */
+static inline TCGCond tcg_tst_ltge_cond(TCGCond c)
+{
+    return is_tst_cond(c) ? (TCGCond)(c ^ 0xf) : c;
 }
 
 /*
@@ -92,7 +124,7 @@ static inline TCGCond tcg_high_cond(TCGCond c)
     case TCG_COND_LE:
     case TCG_COND_GEU:
     case TCG_COND_LEU:
-        return (TCGCond)(c ^ 8);
+        return (TCGCond)(c ^ (4 | 1));
     default:
         return c;
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index eeff4c1d51..eeeb9b0c70 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2482,7 +2482,9 @@ static const char * const cond_name[] =
     [TCG_COND_LTU] = "ltu",
     [TCG_COND_GEU] = "geu",
     [TCG_COND_LEU] = "leu",
-    [TCG_COND_GTU] = "gtu"
+    [TCG_COND_GTU] = "gtu",
+    [TCG_COND_TSTEQ] = "tsteq",
+    [TCG_COND_TSTNE] = "tstne",
 };
 
 static const char * const ldst_name[(MO_BSWAP | MO_SSIZE) + 1] =
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 8ae59ea02b..d46b625e0e 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -253,6 +253,8 @@ Jumps/Labels
        |   ``TCG_COND_GEU /* unsigned */``
        |   ``TCG_COND_LEU /* unsigned */``
        |   ``TCG_COND_GTU /* unsigned */``
+       |   ``TCG_COND_TSTEQ /* t1 & t2 == 0 */``
+       |   ``TCG_COND_TSTNE /* t1 & t2 != 0 */``
 
 Arithmetic
 ----------
-- 
2.34.1


