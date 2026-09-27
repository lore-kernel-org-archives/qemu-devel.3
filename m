Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB67C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksX-0008LM-2q; Sun, 27 Sep 2026 05:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrO-0002AN-PY
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:53 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrN-0008GY-74
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:50 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so1122822a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500068; x=1791104868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UX0xQBovpEREz5D93muEOF8+6jWv4DzWOIo1Qb5cFS4=;
 b=ubrdCNwd+63BeBGxnq9ByeXitRvuvdjlxIsdeX6vl9DJhNMKRY8jcue9INvXR4xy2H
 Zlv8bpM4ROnoA1cSP7QSpGApKTr7QM/l4LodPx74Cw+OK6a62XIWcq67pHYGZeXFyiKE
 +4V4/gy5taHFpe4FGgCUfVYeNJMZST+mPOUSq4LadN4jeSsEzhDH9a8Z3UrCqBpEZbPS
 54zhED8ISaFMN6Nw/erhTOPQ4AL3EnhQcLxrpbwbx6BbRCJwG7lkExyqplTspd8kt7M7
 bW6P8IhNXD7DEB8VKMTL97PURGsMpgOj1shBpIme9/JVtFK8s1EgOoeUjgmbGJ7SQX6k
 qDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500068; x=1791104868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UX0xQBovpEREz5D93muEOF8+6jWv4DzWOIo1Qb5cFS4=;
 b=oSzWQ8tYFZ6Q7PFmlM4md+7o0Z5KJaEM1vgOVFYJGUR1SijULdHdAtWjYtHWJEIbji
 oKB909R8ex0yilr7bJHIRczE/Rx3ZlMTFH7Qu9mgBbzpgUA67KkP8ITl/y8grbv5qmc3
 X+zmT/DMp1TrLfL0+bsAz+Yk8M1KCJoe8q9a/cVgHj6GXL9oLda/OgJdzs2Ffg6ZiEsQ
 I3P5dEivxLReHE0t8SdiBaqbhnWJs7ibWLHYHJ+YmAclclnoWgnV2SUDYzanZyD2hGzf
 DFtaFWnjNmDv59O8PQTncvOvZVwFbUZpqP0eUbkrZY2/Ywkgwo+Ko6oHUsK/E4Ikq6tO
 +xOA==
X-Gm-Message-State: AFq9FYICyIeAivsev8dFhzKM9G3+Ys9iVgKrCQlvseak5U33gwCwairN
 MDjxwCj0XMzt4STL2jdCKXZTEFypmnSSwfs+5o8mJa1iONgyTl0+rnIYV9gZFlk4cSfk2BQ+ke5
 Vy5SF
X-Gm-Gg: AYBFou0vMgFVl2QoD95G/lfCkJdx3QtpwZV2dAfyJAwdBCBNGWzpNRHztcmoQPhN4WQ
 raeMmGPzu4RJ6oXv+6AImZx7aIOJRpq6lw+uKSuWyk7ByTIR6VyWU6d39C7jSPDM9ymwnJ/yKmW
 14P7XRzuAzigBbxqTPgr0mINisnKgxBRCkDB6QnWWkJG9wbLR6uXsE8S2gPU9BrjXk/c3ZhBcDB
 eyooXqIXA5813yAQJtXLERXa4HC7g7U0E97Xd2rxWxVu7rFsOaXsRa80naLsXfD27cdAIzuWZLg
 jJsFoiPO9e7GU3x1qykNuXtSD/oS3W/8jTT3JpYYx8j2af1qVAvOZ55xqDslvFmv8f7nKahOPC6
 9yrQfaRtlO/YOqUybrH+S4yj6J/LuPsTy0v9/Hae9yqzbPzsWiGLgzNrdPGGJdOqk2l4W7AgN45
 EXcNXXrK+9o4tvrsxzRXonfBIE7pm8XSMMMYd9HryEx/8fHn9/iGflaAnMeYOCnYzXIfXg86f1Y
 UCpmofvl7JmwnqKJZ9ShEqx04HKSegyV7ho1hbyrQ==
X-Received: by 2002:a17:90b:55d0:b0:398:9bd5:490b with SMTP id
 98e67ed59e1d1-3a098cdbb1fmr8519247a91.18.1790500067622; 
 Sun, 27 Sep 2026 02:07:47 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 086/101] tcg: Split out gen_bitswap
Date: Sun, 27 Sep 2026 01:59:56 -0700
Message-ID: <20260927090011.10724-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 58 ++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0bf7c2fdff1..0c6146cfbe6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -290,6 +290,27 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF5
 #undef DEF6
 
+/*
+ * Internal helper for bit and byte reversal.
+ * Given a repeating matched block of 1's and 0's, swap the bits within
+ * those two blocks.  E.g.  mask=00ff00ff, shift the input bits left and
+ * right 8 bits.
+ */
+static void tcg_gen_bitswap(TCGType type, TCGTemp *dst,
+                            TCGTemp *src, uint64_t mask)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+    g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+    TCGTemp *tmask = tcg_constant_internal(type, mask);
+    TCGTemp *tshift = tcg_constant_internal(type, cto64(mask));
+
+    tcg_gen_and(type, t0, src, tmask);
+    tcg_gen_shr(type, t1, src, tshift);
+    tcg_gen_shl(type, t0, t0, tshift);
+    tcg_gen_and(type, t1, t1, tmask);
+    tcg_gen_or(type, dst, t0, t1);
+}
+
 /*
  * Generic expansions for templated operations.
  * We have used compiler type checks to ensure all TCGTemp
@@ -1292,43 +1313,14 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-/*
- * Internal helper for bit and byte reversal.
- * Given a repeating matched block of 1's and 0's, swap the bits within
- * those two blocks.  E.g.  mask=00ff00ff, shift the input bits left and
- * right 8 bits.
- */
-static void gen_bitswap_i32(TCGv_i32 ret, TCGv_i32 arg, uint32_t mask)
+static void gen_bitswap_i32(TCGv_i32 dst, TCGv_i32 src, uint32_t mask)
 {
-    TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-    TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-    int sh = cto32(mask);
-
-    tcg_gen_andi_i32(t0, arg, mask);
-    tcg_gen_shri_i32(t1, arg, sh);
-    tcg_gen_shli_i32(t0, t0, sh);
-    tcg_gen_andi_i32(t1, t1, mask);
-    tcg_gen_or_i32(ret, t0, t1);
-
-    tcg_temp_free_i32(t0);
-    tcg_temp_free_i32(t1);
+    tcg_gen_bitswap(TCG_TYPE_I32, tcgv_i32_temp(dst), tcgv_i32_temp(src), mask);
 }
 
-/* Similarly for 64-bit operands. */
-static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
+static void gen_bitswap_i64(TCGv_i64 dst, TCGv_i64 src, uint64_t mask)
 {
-    TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-    int sh = cto64(mask);
-
-    tcg_gen_andi_i64(t0, arg, mask);
-    tcg_gen_shri_i64(t1, arg, sh);
-    tcg_gen_shli_i64(t0, t0, sh);
-    tcg_gen_andi_i64(t1, t1, mask);
-    tcg_gen_or_i64(ret, t0, t1);
-
-    tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
+    tcg_gen_bitswap(TCG_TYPE_I64, tcgv_i64_temp(dst), tcgv_i64_temp(src), mask);
 }
 
 /*
-- 
2.53.0


