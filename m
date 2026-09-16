Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18FDC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNp-0007o7-1Z; Wed, 16 Sep 2026 09:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNa-00077q-7c
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:50 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNY-0001XC-CH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:49 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c4bf3dedf3so615688b6e.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564127; x=1790168927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TAIqV0L4pcsexZYXYg2n1SLrwSHAalOcoQCJhMfQtx4=;
 b=EReh1nZ8eAS8+6Z1I6e807/+fHeDNir/qaqhl+2bu1hhEwloS44eNf8zipg4Q7B5A+
 7OGPMpQrZ5FUr49hnFaLEr+3obVb6vtN5fqYzdrK0H8D/ZFetkXMWbjRhBJZFTu303dW
 dseuCli9vouqlxVtjDk2uq4dsvgWxypjl6Tqgp9wsnT4fJ2ZeFXVMyqF19ZI8dAWNn0Q
 Zxj3I4FFjBy9RoM3xUHJGUh5b9Xj0gcsPkEERF98QxHxDny3qPQ5U2G6HaSLv6jnGmqj
 +BFKQOLXV02wG0OZduKxBS6gXNUxyAWbtAoteQjv8yKaQdCqI8z9lcXPauIaTkXB7yoP
 jJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564127; x=1790168927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TAIqV0L4pcsexZYXYg2n1SLrwSHAalOcoQCJhMfQtx4=;
 b=jwEwlSGQJHRr3hFtZAgOS2foeWvjcSXp5yvvBiDWgbQcZ/IhTvTsMLx0UGIAlWiof1
 yEMk3MOrhtJo7ZyU9VZn0nMj1tNu/v1mPx9YVzWrVMcbx6YpwLJILbwN66a8oom8uSjD
 /aPl/2K7BVPy83HZ30KuhHCtD2foORbIkhtbn6wtsGRxYQGMPNlH+6OvuVxohXz/JV2Y
 DrTjNsAvkyZDD/WgIk7u/sTbWJNxZzYLOBK6qPsTitSG85WUQQFGlV1/1f1rp8n+FL8Q
 4i+dXWZI26iN45dtJkOKOXnco1kGYHnHAlGGRExqWchlDOInVt2diyGRrOEsKA7Nih9G
 E07g==
X-Gm-Message-State: AFuF++nwiAU0Bao6/67QTYj9s79NbKput4T3QGtAPvO9or8Bi8/AAeNs
 myOa6rt3Ko7x9cYfO665HZz9XYTDBg8JqbI7/Dc2xNYZV3kcQBm3xCwJFg0RfMNp99qIdPu4qaY
 0qMUgEpQ=
X-Gm-Gg: AYBFou32vECKshop53r3kxuTjQoYSvQQiOZX0YVDJUBh8YxKr00+g92HJ6tT1a7BBgu
 gTmUKdomRGJJvwMgMhYC9pRPFqcjev1Jm2g//6PQqaqdi4kmaU9l8e2MVTRu7T/s5dKJspOKtUJ
 Sb2e+CTZts9dUI8UbBSXM3caqJe/XPhxmWbbWYYK0TVkrxmGncEcjzJ2JTyf4/AjDT24Q91oMTs
 vyYuq9UGdIJ/tAetglZ4vGqhrZnA7S1PLHJtCAY2QBsZgnZa48LmNfOqdSSkICJuI+EnpyOBpN5
 TpawTEQ4QpllULF3cbJ5YSE30xlZNlLBJXTcFkytHE1uLFxYNgjMmmqYzMPUf3ICpI0lJrYMYYT
 hFQq/1KLeeqgTSOq+/mCZxBSFJgQpvqUx9uwv88cZaXoI7r5t+1ipcDYs4KxI7d2h932KJHRgxU
 k0miI1t5KCmuAajlDTipB+2abL5iprQ1s5AEMJ3kPRRCeI8O2bKE6S9jzW8u4w/SW/Ku9gouMlR
 msVfQk=
X-Received: by 2002:a05:6820:6ad0:b0:6b7:83d6:2924 with SMTP id
 006d021491bc7-6c7d350308emr2284569eaf.39.1789564127020; 
 Wed, 16 Sep 2026 06:08:47 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 74/92] tcg: Generic expansion of tcg_gen_umax_*
Date: Wed, 16 Sep 2026 03:03:49 -1000
Message-ID: <20260916130409.3382710-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x11.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e9f7703b687..79a3e82c98f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -186,7 +185,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 70f1fc48a26..1405dff32aa 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -59,6 +59,7 @@ DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0ad6649a355..d8b205812f3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1170,6 +1170,15 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_umax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        gen_op_ttt(INDEX_op_umax, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_GTU, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_umin, type, 0)) {
@@ -1476,15 +1485,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -1989,15 +1989,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.53.0


