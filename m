Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CE1C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxqx-0003xQ-Kr; Wed, 17 Jul 2024 02:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxqs-0003gb-1I
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:22 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxqq-00030z-B5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:21 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7039e4a4a03so3787649a34.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196559; x=1721801359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L50cMFgY8xp9UNkN7NVIRy+rY10HarTYUNyP2m/NWeU=;
 b=IsQp/wZDpu8zLgwZAb0SbFhmaMOsmMnQ4UKFX3/VppMXOjkux3SW+KDFI2N/Bp6+8F
 ASz2BDceSrwj4mD3ucP4rL9+nLKJTkVDj8Q9zRFwMI+EJ8/CbzG6FD+kXjggrbZVabzo
 fo322R/pORCFszttDv/1jBG8CO7ckXGFJKxOFdPTEy7rd4siYhCrm7kvnVUqvbC277PI
 N4sB5dJRhAMfP9/QkAaflm3J8pketNVs7IIPQIG7Q3G9WAknPlSKpf+49sqjvcQaY2bj
 DTmm3UYmjvDWlADzKiNNtBYuLHGoCDwkKf6MbHlQzEhf1TnPvc5DQuOBXQtKG3QdFxgn
 0nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196559; x=1721801359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L50cMFgY8xp9UNkN7NVIRy+rY10HarTYUNyP2m/NWeU=;
 b=Y0IUojmIO8tPJpKgTtSWCnQdv7PaoXVL0YfdjmdxBCkLUYlbrAMOWrPPYfHt8LSwuR
 EfCbUqc/qSiLnpSR18aSSFJxljV6QMjBaIgvRKRx0IInKPiyPPScNceviqacAikrx4Ii
 JxcZ4Z1H+XmPCXLkunPgMFU812a2YW23OEj2+Ez/L3uASteh06Nq7NBK9F5WCcuCk/fI
 oJsI2u8Tw74gFuBnNPqkwVV8cQtyjWSX71z2GT3yF0SaWT+A3Y4RHW+pRfy7o8f8Yqtc
 K/XU6DfqQ9DOD/y6PXtN/IWGnm0FuMfG1aOAoFHVymJylOw0GR9chM3Gf4KFTPlUMqwF
 clMQ==
X-Gm-Message-State: AOJu0Yz3b98uWiL6MpOHBQAZTT93qF4F5mleAalCBdycihH7DmGUphTf
 ux0NI6Rg0q6e3uuhvuUjkuTpusK5R2ab9ULJyidVK8RVWHSSFScgjUiQ3Q2THvulKBvc6Um7vj4
 CzDQ=
X-Google-Smtp-Source: AGHT+IG7+VplK6yo0DmCdIg8IbahZjpS0D/QCL0K1cA3rpOPTn8ABDO8yWL2iFwj4GkDkpiXKru5aQ==
X-Received: by 2002:a05:6830:4181:b0:703:ba24:7320 with SMTP id
 46e09a7af769-708e378942fmr913594a34.10.1721196558470; 
 Tue, 16 Jul 2024 23:09:18 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/17] target/arm: Convert TBL, TBX to decodetree
Date: Wed, 17 Jul 2024 16:08:49 +1000
Message-ID: <20240717060903.205098-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/arm/tcg/translate-a64.c | 47 ++++++++++------------------------
 target/arm/tcg/a64.decode      |  4 +++
 2 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6ca24d9842..7e3bde93fe 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4657,6 +4657,20 @@ static bool trans_EXTR(DisasContext *s, arg_extract *a)
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
@@ -8897,38 +8911,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
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
@@ -11792,7 +11774,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     /* simd_mod_imm decode is a subset of simd_shift_imm, so must precede it */
     { 0x0f000400, 0x9ff80400, disas_simd_mod_imm },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
-    { 0x0e000000, 0xbf208c00, disas_simd_tb },
     { 0x0e000800, 0xbf208c00, disas_simd_zip_trn },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 05927fade6..45896902d5 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1141,3 +1141,7 @@ FNMSUB          0001 1111 .. 1 ..... 1 ..... ..... .....    @rrrr_hsd
 
 EXT_d           0010 1110 00 0 rm:5 00 imm:3 0 rn:5 rd:5
 EXT_q           0110 1110 00 0 rm:5 0  imm:4 0 rn:5 rd:5
+
+# Advanced SIMD Table Lookup
+
+TBL_TBX         0 q:1 00 1110 000 rm:5 0 len:2 tbx:1 00 rn:5 rd:5
-- 
2.43.0


