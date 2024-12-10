Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BCAE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xn-0005LK-GX; Tue, 10 Dec 2024 11:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xg-0004vD-JM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:48 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xc-0006YO-Q9
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:47 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53df19bf6a9so6638075e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847583; x=1734452383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WKSI6cr1CPrTsqeI72Zls4iEeURwQEM5mywoVvBUjA=;
 b=IcUSA1X9kFiKDWEDAhcIW5992AlaV9VxpsTxJn+UCKO8JhPGRp0gNiD19AqDl2hp14
 u0/5AWB8BgUZkhnGwvX9iBOIpu7Df3WEPPATvlY2sEKMqRm7iU3fVRfFYDrzVjED9y38
 57vydJCIkFPzrXMca9HbM8Fkbk0CG9iGOSlfK95FQIpo0VvEOSFGfDGgh1kfxxeyhSm4
 naiZd0CC7POeZjjIneEixwZKTHU5uDiQl6mWkgB+fSkNk8VA7JQ5T1M20VbUElezuRzk
 AzZ5OX2j6SHH5YDz0g43xjdzcSBDMjJj/TxHMhy4SwKUyigl2NwR92rn5aCJ0ovVssrY
 g6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847583; x=1734452383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WKSI6cr1CPrTsqeI72Zls4iEeURwQEM5mywoVvBUjA=;
 b=dit+Ioe+CeIYmqO3fFZvOtZ9CMA1aIxrGJDlBgawNMClrEsTlwvhcPJHiinYpct15P
 TsDvAxkPtLLTosygDubNXBuh2JetVxGF9XgidiJ36jdAiGruHH0ebMXXSkBlY8PnQZl2
 dBru2Ii13Z0i1tnxhvXMBE89SfhvY83rq3vOzOxfoff7FtKY8qrgh94OlIpdkXyFLw4e
 9FPjEUcmQwLvj0K6Qsju1txtiRi3X00iOcMqrTXjVYXYyo/OzslFfkh7QrSueemMiWrN
 1zwyffsjr4Wjhi3ztl7DTC+468KDrwiK6MlU/OpBRHxsoan22RSQRdcB0ZZ4IjVGUWZc
 qTiw==
X-Gm-Message-State: AOJu0YzqiKqpH9LCr5tDECIPznzRz34VF6u9KUQsmDcy/mDbtSErrmmT
 a6MJ8e9Oe2KJZ/ny1BvKu80+sVS5K6fb9uN3BPWymdDE2KzcaDYpXMRKYxGlbIIH7aWtXciYgiA
 qOJV7NUbd
X-Gm-Gg: ASbGncvvrpjQVtLocwJdtTgVdQOwVbvt2fDhhr9FG76VozKKrvXOUVDaJMbNL3r1HiP
 txjV/iDcHCM713k3EvcyZf6Ru6xyQEemAKfeYjtRxI0U+Bi6NjB3SN0SPamn9tgqN2EwVnzJAec
 OGxH2EcuZNE6zwp+uR1jcYoaNeIq8TdCiCRDZmwuPwvwuRKAI7VkI72WiLHwZKgG3eUwF6EDMZO
 xo178zvixkVUKpvDVbCcyalY68r87+IeVKNHGGKsSzljN9ybY7eDGEy2lE=
X-Google-Smtp-Source: AGHT+IHgsNYH7Vz0hjZHVlTdXHTmWpPB72u5Wy8HcJdpNg4Bw99AlU1LZh9D2rEPsswa31bmP1NhZw==
X-Received: by 2002:a05:6512:2207:b0:53e:3a8a:79b3 with SMTP id
 2adb3069b0e04-53e3a8a79bbmr3976421e87.21.1733847583090; 
 Tue, 10 Dec 2024 08:19:43 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 30/69] target/arm: Convert FRINT{32,
 64}[ZX] (scalar) to decodetree
Date: Tue, 10 Dec 2024 10:16:54 -0600
Message-ID: <20241210161733.1830573-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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

Remove handle_fp_1src_single and handle_fp_1src_double as
these were the last insns decoded by those functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 146 ++++-----------------------------
 target/arm/tcg/a64.decode      |   5 ++
 2 files changed, 22 insertions(+), 129 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ef0379d17f..5a48a2ef2d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8425,112 +8425,23 @@ static const FPScalar1 f_scalar_bfcvt = {
 };
 TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar, a, &f_scalar_bfcvt, -1)
 
-/* Floating-point data-processing (1 source) - single precision */
-static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
-{
-    void (*gen_fpst)(TCGv_i32, TCGv_i32, TCGv_ptr);
-    TCGv_i32 tcg_op, tcg_res;
-    TCGv_ptr fpst;
-    int rmode = -1;
+static const FPScalar1 f_scalar_frint32 = {
+    NULL,
+    gen_helper_frint32_s,
+    gen_helper_frint32_d,
+};
+TRANS_FEAT(FRINT32Z_s, aa64_frint, do_fp1_scalar, a,
+           &f_scalar_frint32, FPROUNDING_ZERO)
+TRANS_FEAT(FRINT32X_s, aa64_frint, do_fp1_scalar, a, &f_scalar_frint32, -1)
 
-    tcg_op = read_fp_sreg(s, rn);
-    tcg_res = tcg_temp_new_i32();
-
-    switch (opcode) {
-    case 0x10: /* FRINT32Z */
-        rmode = FPROUNDING_ZERO;
-        gen_fpst = gen_helper_frint32_s;
-        break;
-    case 0x11: /* FRINT32X */
-        gen_fpst = gen_helper_frint32_s;
-        break;
-    case 0x12: /* FRINT64Z */
-        rmode = FPROUNDING_ZERO;
-        gen_fpst = gen_helper_frint64_s;
-        break;
-    case 0x13: /* FRINT64X */
-        gen_fpst = gen_helper_frint64_s;
-        break;
-    default:
-    case 0x0: /* FMOV */
-    case 0x1: /* FABS */
-    case 0x2: /* FNEG */
-    case 0x3: /* FSQRT */
-    case 0x6: /* BFCVT */
-    case 0x8: /* FRINTN */
-    case 0x9: /* FRINTP */
-    case 0xa: /* FRINTM */
-    case 0xb: /* FRINTZ */
-    case 0xc: /* FRINTA */
-    case 0xe: /* FRINTX */
-    case 0xf: /* FRINTI */
-        g_assert_not_reached();
-    }
-
-    fpst = fpstatus_ptr(FPST_FPCR);
-    if (rmode >= 0) {
-        TCGv_i32 tcg_rmode = gen_set_rmode(rmode, fpst);
-        gen_fpst(tcg_res, tcg_op, fpst);
-        gen_restore_rmode(tcg_rmode, fpst);
-    } else {
-        gen_fpst(tcg_res, tcg_op, fpst);
-    }
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
-/* Floating-point data-processing (1 source) - double precision */
-static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
-{
-    void (*gen_fpst)(TCGv_i64, TCGv_i64, TCGv_ptr);
-    TCGv_i64 tcg_op, tcg_res;
-    TCGv_ptr fpst;
-    int rmode = -1;
-
-    tcg_op = read_fp_dreg(s, rn);
-    tcg_res = tcg_temp_new_i64();
-
-    switch (opcode) {
-    case 0x10: /* FRINT32Z */
-        rmode = FPROUNDING_ZERO;
-        gen_fpst = gen_helper_frint32_d;
-        break;
-    case 0x11: /* FRINT32X */
-        gen_fpst = gen_helper_frint32_d;
-        break;
-    case 0x12: /* FRINT64Z */
-        rmode = FPROUNDING_ZERO;
-        gen_fpst = gen_helper_frint64_d;
-        break;
-    case 0x13: /* FRINT64X */
-        gen_fpst = gen_helper_frint64_d;
-        break;
-    default:
-    case 0x0: /* FMOV */
-    case 0x1: /* FABS */
-    case 0x2: /* FNEG */
-    case 0x3: /* FSQRT */
-    case 0x8: /* FRINTN */
-    case 0x9: /* FRINTP */
-    case 0xa: /* FRINTM */
-    case 0xb: /* FRINTZ */
-    case 0xc: /* FRINTA */
-    case 0xe: /* FRINTX */
-    case 0xf: /* FRINTI */
-        g_assert_not_reached();
-    }
-
-    fpst = fpstatus_ptr(FPST_FPCR);
-    if (rmode >= 0) {
-        TCGv_i32 tcg_rmode = gen_set_rmode(rmode, fpst);
-        gen_fpst(tcg_res, tcg_op, fpst);
-        gen_restore_rmode(tcg_rmode, fpst);
-    } else {
-        gen_fpst(tcg_res, tcg_op, fpst);
-    }
-
-    write_fp_dreg(s, rd, tcg_res);
-}
+static const FPScalar1 f_scalar_frint64 = {
+    NULL,
+    gen_helper_frint64_s,
+    gen_helper_frint64_d,
+};
+TRANS_FEAT(FRINT64Z_s, aa64_frint, do_fp1_scalar, a,
+           &f_scalar_frint64, FPROUNDING_ZERO)
+TRANS_FEAT(FRINT64X_s, aa64_frint, do_fp1_scalar, a, &f_scalar_frint64, -1)
 
 static void handle_fp_fcvt(DisasContext *s, int opcode,
                            int rd, int rn, int dtype, int ntype)
@@ -8631,30 +8542,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
         break;
     }
 
-    case 0x10 ... 0x13: /* FRINT{32,64}{X,Z} */
-        if (type > 1 || !dc_isar_feature(aa64_frint, s)) {
-            goto do_unallocated;
-        }
-        /* 32-to-32 and 64-to-64 ops */
-        switch (type) {
-        case 0:
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_fp_1src_single(s, opcode, rd, rn);
-            break;
-        case 1:
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_fp_1src_double(s, opcode, rd, rn);
-            break;
-        case 3:
-        default:
-            goto do_unallocated;
-        }
-        break;
-
     default:
     do_unallocated:
     case 0x0: /* FMOV */
@@ -8669,6 +8556,7 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     case 0xc: /* FRINTA */
     case 0xe: /* FRINTX */
     case 0xf: /* FRINTI */
+    case 0x10 ... 0x13: /* FRINT{32,64}{X,Z} */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 4a48fcff1d..4f7b3ee3d9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1340,6 +1340,11 @@ FRINTI_s        00011110 .. 1 001111 10000 ..... .....      @rr_hsd
 
 BFCVT_s         00011110 01 1 000110 10000 ..... .....      @rr_s
 
+FRINT32Z_s      00011110 0. 1 010000 10000 ..... .....      @rr_sd
+FRINT32X_s      00011110 0. 1 010001 10000 ..... .....      @rr_sd
+FRINT64Z_s      00011110 0. 1 010010 10000 ..... .....      @rr_sd
+FRINT64X_s      00011110 0. 1 010011 10000 ..... .....      @rr_sd
+
 # Floating-point Immediate
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
-- 
2.43.0


