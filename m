Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000C5C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkos-0006b4-K2; Sun, 27 Sep 2026 05:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoE-0005M3-53
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:35 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoA-0007gY-94
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:33 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc797656e44so467773a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499866; x=1791104666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3sOHdUEHN4gpVB3b1E8vPPHzKg1lSZSAe8P9+6/P9hU=;
 b=bfi8GCCazjDBvq05POLiaWhrjyzXD79MtcM2a5BWYaKV8LHlqKy+a45WRlP3We8efh
 uxiUeOYZ59IhzwFkjn4Sit5WX6PJesi8iwjBWNQM8++tMgEbwc1ImGA4FNUq+3kmRP/B
 sK8wdVeDXh++sMKHR/FTh2UZQA7uvnra9pGEgMMhF+kkbG6zE4sIDzMEXCBuFEy40qkc
 hki9RpWcNXw1/AS+qRytlBh4v9teBbXRJlxjSJET5k0F3e/RYnE4VD7Uxp/9XQsYfGpC
 6+yqEn0l7hgBIPahFrV4iE1IfNxSGf9sWFsugH4L97mzH5fFTRKM3OyakmTp8I/Sb4kD
 J4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499866; x=1791104666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3sOHdUEHN4gpVB3b1E8vPPHzKg1lSZSAe8P9+6/P9hU=;
 b=RSDIjHGUhw98NKVBzi7tKx/NdYI0ZMo9iFUM2uoWOGFNB5scyHse9rbwfacax70SSq
 icIKIng2eFWgaoLzkk3Yfg73Eee7FiYrid4ed9yfofSqE0X1qw+F4HU9MEv9fRsK8UtR
 ymc4P+UFzcwqt1RqqWUcGEk2RdBao4r/Xl/NqfnroJQytxef9+xMXkQuIMVsFWJnt28q
 v8fzlYxHz1DiCJ0Veb/eGeiUUzJ4qEZFeXI9kcm2xu5nlJHM5fBUehWD+oMg4bwTpSjF
 FqmBxZ5ysDBWkh/hTddKCHo9g+UVk+0TQ6Ty/u0pNYvOCYwuu7ow2mYlV1ywqBTXoSD0
 h2ew==
X-Gm-Message-State: AFq9FYJbnCgW8e8kjj7IJAk0o7VAZIoRx4pubiAnU8k1nqj2MudwjXzU
 bcL/agxmv8VuZtINijsEDYRv3WD1+EieWshfbr9KabBSMjrf9j4e4q2oLKdeQ+QizLnmdPML1nd
 +uc20
X-Gm-Gg: AYBFou3z1VIF9NG9IGrbP5DsZM0gqFzYHFtHI/G7uUfXvUkXD7nKUC4taYuGxvuKR3x
 MmWM3hphOyPnvuTkn4YdH4DJ1bAUKXDRdAxabvaoESstSG4UNvV7Mdvb+7saPNlmTAAGOaZcw9P
 o4iUJUd7QuNqDUFBglX9yiab8UCbLRt6WRiRxx4rlb7tI+uH85Ii+WVa+gLB3NDqRQhw3bBXTqC
 XkfXudtymPGDqDpchDS9d5RwKxrP2SLbkZ4a4OjiFedj+BepijbHkSwq9toHCXar2WkiZ6u5F8W
 H49ArOjONEpGKgywdwQjjQNcjJUbsCV049G46m58c1EjRLrUUJiuDlaPBRcYMm3rpMNP+WaQHM+
 HTJ/kUs7hIpjyd0W9njtSVKItlHJhRyknJd1t6HSgpMJURFaHluTIK9isN+5A71wud91kwjOeBL
 N4Cmddr5sXWXjs2P7BjnwIvCX47B91vVjc6bG2XA5Lr+Argxi9/P1S+NzyCoome5BnXRck/5IyJ
 +iM3aaPBQjNMnv8IelOunDhgLMHpQ==
X-Received: by 2002:a17:90b:2745:b0:39e:5c75:acbb with SMTP id
 98e67ed59e1d1-3a098ad3c68mr8169894a91.11.1790499866178; 
 Sun, 27 Sep 2026 02:04:26 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 068/101] tcg: Generic expansion of tcg_gen_ext16s_*
Date: Sun, 27 Sep 2026 01:59:38 -0700
Message-ID: <20260927090011.10724-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 260f65f3305..d8bd08ff1ec 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -185,7 +184,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1cdcf3aeeca..4c1fc9633c1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -21,6 +21,7 @@ DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
+DEF2(ext16s, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 60a4f1c196b..c4ae16273fc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -610,6 +610,11 @@ void tcg_gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_extract(type, dst, src, 0, 8);
 }
 
+void tcg_gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_sextract(type, dst, src, 0, 16);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1176,11 +1181,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_extract_i32(ret, arg, 0, 16);
@@ -1472,11 +1472,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 32);
-- 
2.53.0


