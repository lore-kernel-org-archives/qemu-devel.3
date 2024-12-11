Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E81E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPhm-0001H9-LO; Wed, 11 Dec 2024 11:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhS-0000N0-Ga
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:34 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhQ-0002DT-6H
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:34 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d8adbda583so77405276d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934991; x=1734539791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZntTIOGg/1bzhdSiC1UurASxEDoLtQtjFGk9EIblI20=;
 b=p2boiI6BDnlvTXf9XEPGlqyrfyLTT74mWcdfgQzuTGjKselph2HmMv7pT0l62JIL9G
 vIg5EScuYYT//T4wqrPB01VBujIN05LrTd6KAZQbZvpQp3eArqeKLsez1OtI2Yecrj5L
 Gi1n7+JJ8IQLOpo+JxANDq2wT2P2RQaAHXiUBTtZGdmcYA/7EscM8MXc0h1zNl1a6/OD
 x73kxhYrkAYkwadQBOy6cHOiBZ+qQET3Xp4p8JQdYr10F5ArFhzZDsQ0FtZ6PspE1VeA
 CVEbbdoJ9SG0o6xxKB7WF4jqGHZfqzj54DV9ujGWsPVnkJ7uFXpQm6CfWVefRwcyJ6fj
 ie0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934991; x=1734539791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZntTIOGg/1bzhdSiC1UurASxEDoLtQtjFGk9EIblI20=;
 b=o6QurwA4V8BYvT8Cg1xjnKOqL5+5kv9uvJXLtpj9+OfR6tbC9XQgFRAxhOXCBk18EZ
 a3VzHk5gM9xC1i1Y/9mgu83ylM+Za3M7aLJpEwGIFdSn5Q+igHyZWRBy26qcIqh5TcO9
 +r41wkdP9MXq2iWR9bV5f2CzNL4jtuY+QMcCc6EEGvzHGZHBjGIuivDgTH8FJLKgs+Am
 bsNjGSnE7krhZhF3vGcpUUlueHtAbFyQJqtlVeWim8i4s3MlSgi2729SegXsohPjtgm/
 qkNBhIxphTia3ewOHFumiwdWxtqlKNRp6B8PH87pJbWsSv3TnnaPCYQA5hQ+shzhmt09
 bl8A==
X-Gm-Message-State: AOJu0YyrqNbe5uz8DTDb9qu22cMI33LoEIkjJ81Ci0i3x4PQe+DNIqlS
 dsqz09yT5YA+GiiW0Mzi0z1wIDFQFmPSpniY+zPEVchjwEivOAqmK6C8LxRq0Pw+XpCu3eb8Q4X
 9KtlnHQmG
X-Gm-Gg: ASbGncuRtNpEI/RPHtXbwSww+zE4dksRDMFIaGtcpTz6UvFUjYPmCZaVCucPdhlwkwg
 O029yCRNXlnRAF0juJO5W7VKWnC58iU+xu9E/7AbhLmNo1jX0BZwETbGDOglmrejYEIqbQFEAOB
 bayz0s1qP+h1XSvZsBfVPDUNbx94plOkL4dE80MfsgXhJy3D3cuvJUlpJCP0ib+zCw+lZF02tkt
 JMec0tJX4pSIzRExRefhDXlLnxhQehN1srvR2kToOJs1tBb1TNv0h5lpQ4I3Q==
X-Google-Smtp-Source: AGHT+IFxRi7BFD769viVHgHAdtCnEpxeqbcfj5s/2WDYuNkK8d1bcJw3vg6rn7Ey+BXDg/TlgH0VDg==
X-Received: by 2002:a05:6214:401c:b0:6d4:18ce:117f with SMTP id
 6a1803df08f44-6d934aeda1emr48974016d6.20.1733934991280; 
 Wed, 11 Dec 2024 08:36:31 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:36:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 52/69] target/arm: Convert SHLL to decodetree
Date: Wed, 11 Dec 2024 10:30:19 -0600
Message-ID: <20241211163036.2297116-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf33.google.com
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
 target/arm/tcg/translate-a64.c | 75 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  2 +
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1c454a37f4..c5d456de3b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9113,6 +9113,43 @@ static ArithOneOp * const f_vector_bfcvtn[] = {
 };
 TRANS_FEAT(BFCVTN_v, aa64_bf16, do_2misc_narrow_vector, a, f_vector_bfcvtn)
 
+static bool trans_SHLL_v(DisasContext *s, arg_qrr_e *a)
+{
+    static NeonGenWidenFn * const widenfns[3] = {
+        gen_helper_neon_widen_u8,
+        gen_helper_neon_widen_u16,
+        tcg_gen_extu_i32_i64,
+    };
+    NeonGenWidenFn *widenfn;
+    TCGv_i64 tcg_res[2];
+    TCGv_i32 tcg_op;
+    int part, pass;
+
+    if (a->esz == MO_64) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    tcg_op = tcg_temp_new_i32();
+    widenfn = widenfns[a->esz];
+    part = a->q ? 2 : 0;
+
+    for (pass = 0; pass < 2; pass++) {
+        read_vec_element_i32(s, tcg_op, a->rn, part + pass, MO_32);
+        tcg_res[pass] = tcg_temp_new_i64();
+        widenfn(tcg_res[pass], tcg_op);
+        tcg_gen_shli_i64(tcg_res[pass], tcg_res[pass], 8 << a->esz);
+    }
+
+    for (pass = 0; pass < 2; pass++) {
+        write_vec_element(s, tcg_res[pass], a->rd, pass, MO_64);
+    }
+    return true;
+}
+
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9901,33 +9938,6 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
     }
 }
 
-static void handle_shll(DisasContext *s, bool is_q, int size, int rn, int rd)
-{
-    /* Implement SHLL and SHLL2 */
-    int pass;
-    int part = is_q ? 2 : 0;
-    TCGv_i64 tcg_res[2];
-
-    for (pass = 0; pass < 2; pass++) {
-        static NeonGenWidenFn * const widenfns[3] = {
-            gen_helper_neon_widen_u8,
-            gen_helper_neon_widen_u16,
-            tcg_gen_extu_i32_i64,
-        };
-        NeonGenWidenFn *widenfn = widenfns[size];
-        TCGv_i32 tcg_op = tcg_temp_new_i32();
-
-        read_vec_element_i32(s, tcg_op, rn, part + pass, MO_32);
-        tcg_res[pass] = tcg_temp_new_i64();
-        widenfn(tcg_res[pass], tcg_op);
-        tcg_gen_shli_i64(tcg_res[pass], tcg_res[pass], 8 << size);
-    }
-
-    for (pass = 0; pass < 2; pass++) {
-        write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
-    }
-}
-
 /* AdvSIMD two reg misc
  *   31  30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+-----------+--------+-----+------+------+
@@ -9948,16 +9958,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x13: /* SHLL, SHLL2 */
-        if (u == 0 || size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_shll(s, is_q, size, rn, rd);
-        return;
     case 0xc ... 0xf:
     case 0x16 ... 0x1f:
     {
@@ -10118,6 +10118,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
     case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
+    case 0x13: /* SHLL, SHLL2 */
     case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         unallocated_encoding(s);
         return;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d8902dfb22..ec0d46a563 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1685,3 +1685,5 @@ UQXTN_v         0.10 1110 ..1 00001 01001 0 ..... .....     @qrr_e
 FCVTN_v         0.00 1110 0.1 00001 01101 0 ..... .....     @qrr_hs
 FCVTXN_v        0.10 1110 011 00001 01101 0 ..... .....     @qrr_s
 BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
+
+SHLL_v          0.10 1110 ..1 00001 00111 0 ..... .....     @qrr_e
-- 
2.43.0


