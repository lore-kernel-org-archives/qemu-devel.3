Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FCFCDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwi-00064S-8U; Thu, 19 Sep 2024 09:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwH-0004XV-HQ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:18 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwE-00010V-HF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:16 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f77fe7ccc4so8881501fa.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751472; x=1727356272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=skHPuVnsvR6Ul8cA6v8OopyRl4icBlvvZ1tc+HPXORU=;
 b=EZkPS4/Xk+dh2GfAkUxDf/yFUZsmlZukrfI+aKtu8dVsKrsp+xecqNYb5fxQXbhQac
 aF13fdyrdZ6hxswnloul7Aj3H2hakmiU/SRUHO5pKb2g1CMViozUGf10jW7kfmghNfQE
 jQ9iTXj2b5BPV0u3JBk5bdnmxDVTqGBuCWs9DL6CpY+25PWstgAhRhWsxmHr9wprds4v
 8OiLcOJvf87mqPZ6KRkdQMejj/z23XgyCm8lEzZ+R+biCS5mY9ohnl0aUBHLbGiNM3Gc
 fIQ546iYncdBURjJw4GeJJxt6VLMb7hvz3Oic/NR6k8ewIpuDJVP7++7hYsqQbyyzZlZ
 WoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751472; x=1727356272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skHPuVnsvR6Ul8cA6v8OopyRl4icBlvvZ1tc+HPXORU=;
 b=imsqRujAS3UfWOkf1AsN2EZYj5ARR0X9fEQjBxZ+uDZVnlmaEyAIp8y/vdWKuzbGtG
 we09LZMiD9CTfvQ8j0/9/V5Xkweu8kOw4SKywmBe7LyARLIfiejlWa7Oor04q2cpZ/Ea
 q/asqmWUMYy2xzNi1jHRkX4SgWhlyNqBH3WFXoNEiGK+OJcd59lP0IIxsdn9Xh7JraO8
 NsF+EoXnERD8BSfhBdxnYDZdM2KpXVrc0I0gZ+x8S2dvJaaz3cMl3u9ygECDkr2I6B33
 yp0nojgi3oAgyQnZHP25f78jPVIxvfBGm0mKtYGke7QahTZEyLMBL7wh+P0nBH3zWMRn
 tEqQ==
X-Gm-Message-State: AOJu0Yw+I9WT/oRauZ3LvjaU/R+dnUsG9ZyT5FygvTCjyFwrlR+9LfTb
 yWIWVZmnK7Y34osuyKFoSbFo1hvv8zLzz08SZQ+/UBHBARgkXHfI+5kKYACR+oWAK+I/0z5SCJ2
 C
X-Google-Smtp-Source: AGHT+IFiScWjuOMR5Q8bP2lxTW5noo4EDRfRBFR/Zsm95dEaUqIRgysui1tJ21805XnWO9l95a/bwQ==
X-Received: by 2002:a2e:be1f:0:b0:2f7:64b9:ff90 with SMTP id
 38308e7fff4ca-2f7918e9558mr116755271fa.9.1726751471945; 
 Thu, 19 Sep 2024 06:11:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/38] target/arm: Convert TBL, TBX to decodetree
Date: Thu, 19 Sep 2024 14:10:35 +0100
Message-Id: <20240919131106.3362543-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 +++
 target/arm/tcg/translate-a64.c | 47 ++++++++++------------------------
 2 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f72f95865fb..e2a3ef62efb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1141,3 +1141,7 @@ FNMSUB          0001 1111 .. 1 ..... 1 ..... ..... .....    @rrrr_hsd
 
 EXT_d           0010 1110 00 0 rm:5 00 imm:3 0 rn:5 rd:5
 EXT_q           0110 1110 00 0 rm:5 0  imm:4 0 rn:5 rd:5
+
+# Advanced SIMD Table Lookup
+
+TBL_TBX         0 q:1 00 1110 000 rm:5 0 len:2 tbx:1 00 rn:5 rd:5
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 48188d41165..70173c67c26 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4680,6 +4680,20 @@ static bool trans_EXTR(DisasContext *s, arg_extract *a)
     return true;
 }
 
+static bool trans_TBL_TBX(DisasContext *s, arg_TBL_TBX *a)
+{
+    if (fp_access_check(s)) {
+        int len = (a->len + 1) * 16;
+
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rm), tcg_env,
+                           a->q ? 16 : 8, vec_full_reg_size(s),
+                           (len << 6) | (a->tbx << 5) | a->rn,
+                           gen_helper_simd_tblx);
+    }
+    return true;
+}
+
 /*
  * Cryptographic AES, SHA, SHA512
  */
@@ -8938,38 +8952,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
     }
 }
 
-/* TBL/TBX
- *   31  30 29         24 23 22  21 20  16 15  14 13  12  11 10 9    5 4    0
- * +---+---+-------------+-----+---+------+---+-----+----+-----+------+------+
- * | 0 | Q | 0 0 1 1 1 0 | op2 | 0 |  Rm  | 0 | len | op | 0 0 |  Rn  |  Rd  |
- * +---+---+-------------+-----+---+------+---+-----+----+-----+------+------+
- */
-static void disas_simd_tb(DisasContext *s, uint32_t insn)
-{
-    int op2 = extract32(insn, 22, 2);
-    int is_q = extract32(insn, 30, 1);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    int is_tbx = extract32(insn, 12, 1);
-    int len = (extract32(insn, 13, 2) + 1) * 16;
-
-    if (op2 != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, rd),
-                       vec_full_reg_offset(s, rm), tcg_env,
-                       is_q ? 16 : 8, vec_full_reg_size(s),
-                       (len << 6) | (is_tbx << 5) | rn,
-                       gen_helper_simd_tblx);
-}
-
 /* ZIP/UZP/TRN
  *   31  30 29         24 23  22  21 20   16 15 14 12 11 10 9    5 4    0
  * +---+---+-------------+------+---+------+---+------------------+------+
@@ -11834,7 +11816,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     /* simd_mod_imm decode is a subset of simd_shift_imm, so must precede it */
     { 0x0f000400, 0x9ff80400, disas_simd_mod_imm },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
-    { 0x0e000000, 0xbf208c00, disas_simd_tb },
     { 0x0e000800, 0xbf208c00, disas_simd_zip_trn },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-- 
2.34.1


