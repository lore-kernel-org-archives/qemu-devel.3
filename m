Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86FFEE6421
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZmW-0005FD-8h; Wed, 11 Sep 2024 22:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm7-0003X3-F1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm5-0004Em-Mj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2054feabfc3so3989765ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108896; x=1726713696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VN/OyWZOlf14GGid3MwJllcvvXpFY2jXHANTDkgK01A=;
 b=TAt4d7fp5ert/ZzRYCNXI2CvVF/xkCLvLOYhufWrgdahXWLS09SG1a58cj7IJNfIIo
 hHbqNd+KC/sFG+JdaeMxYPPzgJihOjcSvFg8SyUSc0F1zhyXx92lx74PS5FHHwlmV8Xh
 ylNbrAODIUBjj5w/1tcipSTFGw/lfr8YHivDMond2562OjnYEnqbX+2rFSw+jJ9Ar4Df
 CX6H7ahSKH25VKGH1xEG3H/eX9H9QIdPDD7BkZOEmT6t0DQ6+SpUofxqkQnd/CyQT44m
 1rfQrVWZFlhSXd9GpVodTI5nQf1TJSljvrDX/Wb0jIbZuxbmAu6VUlT8wjOZUuuIKtyM
 BmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108896; x=1726713696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VN/OyWZOlf14GGid3MwJllcvvXpFY2jXHANTDkgK01A=;
 b=Q/eClAKRMFDSDPNwAtFGKa3PdeNyuPzbjRAyfQHzs+cnuE6EyF6fpGcxK2dSqxWrng
 qvHRvayAU1n555ieiVG2b6DNRUq1rsPR/d7yVLjitxnpy673E8O8KwuI/XitEe+jMovK
 yvsXnHvU2+/qxAsOfwc1WGaFLlFfblI6sdkYr9qKcggiF4FeC9e0ld/a+KIoooqcZMnx
 aD3rPqGMrLCvrmfOA0I8wvyj5CjBi7YgPH1nclAQdQGBNUFsu7TgWyWeXbHYCJ16ErcN
 UuX9l/uwWvV21Ihn18nlJAPEf49VpwXrDtsWnEw5gePFfYXy/uXtFkzJ98oeNCur2AIq
 dz4w==
X-Gm-Message-State: AOJu0YyPY76kroZbpHEGseo4NE08U0OLbsWW5w/9TE+H/8K+Nk9lcsD0
 PaUWG+8PsYkWLXSU2AkoMBc6XPvZ6/Y2YBs0bw+JTVigeTuF5JtuW0Jo8eYSDunhsI8h+0WS7ep
 F
X-Google-Smtp-Source: AGHT+IH65NSJV5Hq2yuFPfDIpbHwlqPc9aLhKMZN9XI+bQkAGd4Hahlgccdl2fhQJqgR7h9wIORtdQ==
X-Received: by 2002:a17:902:cecd:b0:206:b960:2e97 with SMTP id
 d9443c01a7336-2076e4128femr20234995ad.45.1726108896358; 
 Wed, 11 Sep 2024 19:41:36 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 22/29] target/arm: Convert SHRN, RSHRN to decodetree
Date: Wed, 11 Sep 2024 19:41:07 -0700
Message-ID: <20240912024114.1097832-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 95 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  8 +++
 2 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f4deacd554..8871087af0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7091,6 +7091,51 @@ static void gen_urshr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
     }
 }
 
+static bool do_vec_shift_imm_narrow(DisasContext *s, arg_qrri_e *a,
+                                    WideShiftImmFn * const fns[3], MemOp sign)
+{
+    TCGv_i64 tcg_rn, tcg_rd;
+    int esz = a->esz;
+    int esize;
+    WideShiftImmFn *fn;
+
+    tcg_debug_assert(esz >= MO_8 && esz <= MO_32);
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    tcg_rn = tcg_temp_new_i64();
+    tcg_rd = tcg_temp_new_i64();
+    tcg_gen_movi_i64(tcg_rd, 0);
+
+    fn = fns[esz];
+    esize = 8 << esz;
+    for (int i = 0, elements = 8 >> esz; i < elements; i++) {
+        read_vec_element(s, tcg_rn, a->rn, i, (esz + 1) | sign);
+        fn(tcg_rn, tcg_rn, a->imm);
+        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, esize * i, esize);
+    }
+
+    write_vec_element(s, tcg_rd, a->rd, a->q, MO_64);
+    clear_vec_high(s, a->q, a->rd);
+    return true;
+}
+
+static WideShiftImmFn * const shrn_fns[] = {
+    tcg_gen_shri_i64,
+    tcg_gen_shri_i64,
+    gen_ushr_d,
+};
+TRANS(SHRN_v, do_vec_shift_imm_narrow, a, shrn_fns, 0)
+
+static WideShiftImmFn * const rshrn_fns[] = {
+    gen_urshr_bhs,
+    gen_urshr_bhs,
+    gen_urshr_d,
+};
+TRANS(RSHRN_v, do_vec_shift_imm_narrow, a, rshrn_fns, 0)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -10496,52 +10541,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* SHRN/RSHRN - Shift right with narrowing (and potential rounding) */
-static void handle_vec_simd_shrn(DisasContext *s, bool is_q,
-                                 int immh, int immb, int opcode, int rn, int rd)
-{
-    int immhb = immh << 3 | immb;
-    int size = 32 - clz32(immh) - 1;
-    int dsize = 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    int shift = (2 * esize) - immhb;
-    bool round = extract32(opcode, 0, 1);
-    TCGv_i64 tcg_rn, tcg_rd, tcg_final;
-    int i;
-
-    if (extract32(immh, 3, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    tcg_rn = tcg_temp_new_i64();
-    tcg_rd = tcg_temp_new_i64();
-    tcg_final = tcg_temp_new_i64();
-    read_vec_element(s, tcg_final, rd, is_q ? 1 : 0, MO_64);
-
-    for (i = 0; i < elements; i++) {
-        read_vec_element(s, tcg_rn, rn, i, size+1);
-        handle_shri_with_rndacc(tcg_rd, tcg_rn, round,
-                                false, true, size+1, shift);
-
-        tcg_gen_deposit_i64(tcg_final, tcg_final, tcg_rd, esize * i, esize);
-    }
-
-    if (!is_q) {
-        write_vec_element(s, tcg_final, rd, 0, MO_64);
-    } else {
-        write_vec_element(s, tcg_final, rd, 1, MO_64);
-    }
-
-    clear_vec_high(s, is_q, rd);
-}
-
-
 /* AdvSIMD shift by immediate
  *  31  30   29 28         23 22  19 18  16 15    11  10 9    5 4    0
  * +---+---+---+-------------+------+------+--------+---+------+------+
@@ -10564,13 +10563,13 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x10: /* SHRN */
+    case 0x10: /* SHRN / SQSHRUN */
     case 0x11: /* RSHRN / SQRSHRUN */
         if (is_u) {
             handle_vec_simd_sqshrn(s, false, is_q, false, true, immh, immb,
                                    opcode, rn, rd);
         } else {
-            handle_vec_simd_shrn(s, is_q, immh, immb, opcode, rn, rd);
+            unallocated_encoding(s);
         }
         break;
     case 0x12: /* SQSHRN / UQSHRN */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bf67f8a357..164ed575b9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1277,3 +1277,11 @@ SSHLL_v         0.00 11110 .... ... 10100 1 ..... .....     @q_shli_s
 USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_b
 USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_h
 USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_s
+
+SHRN_v          0.00 11110 .... ... 10000 1 ..... .....     @q_shri_b
+SHRN_v          0.00 11110 .... ... 10000 1 ..... .....     @q_shri_h
+SHRN_v          0.00 11110 .... ... 10000 1 ..... .....     @q_shri_s
+
+RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_b
+RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_h
+RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_s
-- 
2.43.0


