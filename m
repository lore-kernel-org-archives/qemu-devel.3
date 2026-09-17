Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DC2C982D3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JC-0002eY-FJ; Thu, 17 Sep 2026 04:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J8-0002dy-NZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:27 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J4-0001t5-P6
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:26 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so501750a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633041; x=1790237841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/y17RFPQ5FOAvkOFQg0z/rhHA5VqFQc+R5zas0hgZno=;
 b=JY+s+1Nndbobe4G+8X93dNzXwyyV1Ee1Svc7TsIQ/IXGxmoWNp8ZaiVG7577y44RgG
 WlZhXl4CeVzj187S+P5lC3+T/B8qnpqQoUU9prFsUUc80L2flFKufId9CNXNsV0bJGfJ
 jhjr9JOcwH2ttlQmTikUFiTK7d0eSIW2/4pzqjJudeiWtvomq9FFZzpSylXokCDADwQK
 0NtucnfQBwH4KOuK8ApW6KxS97NBGDF7fpSqPWbSRTQj1I6kO3h2L4T8zln7jh0Y69sZ
 X4bw+E9+I4hUdjYf/1L4noQXWqIAWwFLHFie12AIQm7CIwBs8860hHhS3FAEUiT19j9a
 t8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633041; x=1790237841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/y17RFPQ5FOAvkOFQg0z/rhHA5VqFQc+R5zas0hgZno=;
 b=NPz3a5pQ7K+IR2nC2ekg9K8kPHEMgQkd16n75l1tO9TOhLptYxO/dsEK9LY8EPAUgp
 j18/LJBHi3nLbif7oiSB1S+aw81rjzZrF7ez29c8b8zUfTc6pSmScBUIZUSYs0pVZbNR
 nGY+Qu9feTnTtOLzYmZyFJ8tueYrlhNu8NipeRkWnVyaRgStizSsF++0EWxth5P5V1vy
 91blj02eqA8Ud6Bz7apXhqHXQ91pOrkd6nD7KjEfeEQ/Vvdq8/vf838B+keLgNfvPi1K
 5bAy/+1bgYQWI37Dg/7+l1+Au0+6Zy4b4nZX5MBSMeT1mEsXOxGQS0VrM9FH0rDtRUtn
 hy4Q==
X-Gm-Message-State: AFuF++nbLcz67WGswTk5Kd+QNLwcTy0dlsBhcNu4uUy56wiY1Yi58MHM
 wRzIvrzrPmxuhxYUYs7H+N2tB6p2GiTZsQ/84slq8Uu+MK2OQa4DMAwDxl5KEYUFCXNetL4i6ar
 FKvTZGo4=
X-Gm-Gg: AYBFou3fqwULDzEB4tDTjK5kvv0iDxbNXbvMA26eW/r76r3zoN2sFsKKUR9RRYQKymM
 7Q8iF5tyOz5Cfg5zZWn9BdIhDy2gu5CJEO+j7W6iGBlHBU2QPgxOuRNhDAzrSnEHw1zooyZ9f7l
 0nMOoYWQbHfubWg3CJkrotc6iDKV36Gc4XZu5cNm6tv46ccmOOWOcHxNo2NMWIVbu7p+83sSy+B
 QxLtFgz40KrQLfiyDRucxQCCoNxaNzaaKwkmfOBZ6B5n2jY7zOlKVm/93guFZHTZPljKR8TUaNc
 akf9/WS95A48ijIdQTAd7LTH4ttEDHza3Zo+/OhZGBC6nZv5RYJLWPOdSq5enEUO5sHtpxvFRjW
 S5T7aELVxXM+M5/RWy7HrVMJSMjFtzz17yI1ZZuTkYOykSZSEXVkBR7Iq/kfwuIdf2FLYjU27sM
 eSqS1Kntqwsob81uHKAY6pveyy8nPiHnf0Z40OTBiVA1cl+XTsQWDQoFT+qAc5pHDG4lNoqiEfA
 0SQ6Lk=
X-Received: by 2002:a17:90b:2d45:b0:39e:261:4e0d with SMTP id
 98e67ed59e1d1-39e1e506786mr14922459a91.25.1789633041232; 
 Thu, 17 Sep 2026 01:17:21 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 02/16] tcg: Add tcg_gen_lea_{i32,i64,tl}
Date: Wed, 16 Sep 2026 22:17:02 -1000
Message-ID: <20260917081716.946668-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h         |  2 ++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 43 ++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 37211642365..a7d001c959c 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -83,6 +83,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_shri_tl tcg_gen_shri_i64
 #define tcg_gen_sar_tl tcg_gen_sar_i64
 #define tcg_gen_sari_tl tcg_gen_sari_i64
+#define tcg_gen_lea_tl tcg_gen_lea_i64
 #define tcg_gen_brcond_tl tcg_gen_brcond_i64
 #define tcg_gen_brcondi_tl tcg_gen_brcondi_i64
 #define tcg_gen_setcond_tl tcg_gen_setcond_i64
@@ -209,6 +210,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_shri_tl tcg_gen_shri_i32
 #define tcg_gen_sar_tl tcg_gen_sar_i32
 #define tcg_gen_sari_tl tcg_gen_sari_i32
+#define tcg_gen_lea_tl tcg_gen_lea_i32
 #define tcg_gen_brcond_tl tcg_gen_brcond_i32
 #define tcg_gen_brcondi_tl tcg_gen_brcondi_i32
 #define tcg_gen_setcond_tl tcg_gen_setcond_i32
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 4d121470bec..b60edca6e42 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -36,6 +36,7 @@ DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld16u, TCGV, TCGv_ptr, tcg_target_long)
+DEF5(lea, TCGV, TCGV, TCGV, unsigned, TINT)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 855a81c886f..d271d83a7d2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -930,6 +930,49 @@ static void gen_ld16u(TCGType type, TCGTemp *dst,
     gen_op_tti(INDEX_op_ld16u, type, dst, base, ofs);
 }
 
+static void gen_lea(TCGType type, TCGTemp *dst, TCGTemp *base,
+                    TCGTemp *index, unsigned sh, int64_t imm)
+{
+    g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+    if (imm != 0) {
+        if (TCG_TARGET_lea_imm_valid(type, imm)) {
+            /*
+             * The immediate is non-zero and valid.
+             * If the shift is out of range, perform the shift first
+             * so that we can still emit (base + t + imm) as one insn.
+             */
+            if (!TCG_TARGET_lea_sh_valid(type, sh)) {
+                gen_shli(type, t, index, sh);
+                index = t;
+                sh = 0;
+            }
+            gen_op_tttii(INDEX_op_lea, type, dst, base, index, sh, imm);
+            return;
+        }
+
+        /*
+         * If we can make the immediate smaller by folding it
+         * into index before the shift, do so.
+         */
+        if (sh != 0 && imm == (imm >> sh) << sh) {
+            gen_addi(type, t, index, imm >> sh);
+            index = t;
+            imm = 0;
+        }
+    }
+
+    if (sh == 0) {
+        gen_add(type, dst, base, index);
+    } else if (TCG_TARGET_lea_sh_valid(TCG_TYPE_I32, sh)) {
+        gen_op_tttii(INDEX_op_lea, type, dst, base, index, sh, 0);
+    } else {
+        gen_shli(type, t, index, sh);
+        gen_add(type, dst, base, t);
+    }
+    gen_addi(type, dst, dst, imm);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
-- 
2.53.0


