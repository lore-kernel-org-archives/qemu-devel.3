Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF8CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL33B-0001US-4v; Tue, 10 Dec 2024 11:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32V-0007vW-Nf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:50 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32T-0007bG-TC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:47 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53df6322ea7so6691559e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847884; x=1734452684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVi8HKOFpwBjScONxOFKy9dvoAVKizq2Tu+OgqB6Ev8=;
 b=e+7/e1A8viKTedkXeJWiFAusJOolIQlnMuKGpMFicaGp2WJsVhXmBLpcLPAeewIpdL
 2GB2SJN+YP0PEpMSPrsgylI4VOPY795fK0Yzkoe0Mpt9xtDc+fWU1YGn/UdZ6g9hjn2w
 1h3vCwz7N71NgNaJqvUTA2QvEpX0tvvckrEjl6WV32d9CU9pVKicfjRoWsGyXGffnvYs
 cp0UXrkj4TiUbw7l9j1QFN7fZHH9DvUSbwML/gJesJl1egze2jrPNH+tj++hTMCB1BnJ
 mGilgifzrQfnOk+xOiwCb8CmVbSqukP65fINnkH2yQdZ23TGmQVgsv571jmBY/4W9uKj
 AdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847884; x=1734452684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vVi8HKOFpwBjScONxOFKy9dvoAVKizq2Tu+OgqB6Ev8=;
 b=apYNz6OFLb/v1JVKHz/EqnutcJV1B9M+D8cTGZNwvCWJGNXoWPbnFCzsIJ8xgghGHd
 neb9QMy+1C+gg/E9Qj7SYPhOTb3uwuyvQLo749zNHOiWo3Wq+C7KwgOAq1e7bWIp0M61
 buY5AAAm/4r8/Xuv9TvylDaDe8s6HKse+0znRC4L1xZpT27lflLX96ZgN3eFDipUrMLY
 Z4NbbAudta3on+EvVeUlIzscJln5+ysZ0Q7m3hMkZvBrFuJpq7+2a+UMw21/5Wi8t16x
 y+SB/SdAXQY5gb4K3FFXuFYM+e+C78qbH2U1H/7pcEKN45T2EjuENJLNCZP4T6idXwHG
 L/DQ==
X-Gm-Message-State: AOJu0Yz3MY8m7bCWN7Bjj6e0/jIAL4XZOFNi1f3ptJkZZQF46/MdLYlF
 /FQ5IZO1BfHJ/W+5dW6+xmv4sPKGGZrQcH7w1trg3ZXvK8GK/uwu9o7WJh2WT5cMCASVuJj5Uqj
 lKOHkcOvu
X-Gm-Gg: ASbGncsbPu/xlOKOKJzeK7P35lyYF6MhLUPQxUMrGXLeA3DNJ/3PIh7WryXA+Zdk4Ou
 ht/auLBXMKnNlIz2uTzKvtM7mYvWbjyXIHjMxTvqVeHRaF/MsVuTwDBS2ahMXnh/By9Rnskg3u+
 FdL3jFzbvurZUwF/zqVyNnQI4hpqDnmlgO56wABYC7AEwpuWVrErh0gUXikdVgHy3kg6Rv7r9vn
 GrViq17aoJRTNUg9iJLU4lgI1E4FU+lIjy/+AXJJRJWmRwK3lVAwWl3qsQ=
X-Google-Smtp-Source: AGHT+IHnxaFEhx3V+grQ3FyxTQuuLhLl+niVS8Lxjmc37Uy0xgZr0r8O+6qbsLbzOwPVydGbLT1CRA==
X-Received: by 2002:a05:6512:2395:b0:540:1a3f:e848 with SMTP id
 2adb3069b0e04-540240bc467mr1987456e87.15.1733847884222; 
 Tue, 10 Dec 2024 08:24:44 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 60/69] target/arm: Convert [US]CVTF (vector,
 fixed-point) scalar to decodetree
Date: Tue, 10 Dec 2024 10:17:24 -0600
Message-ID: <20241210161733.1830573-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x132.google.com
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

Remove disas_simd_scalar_shift_imm as these were the
last insns decoded by that function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 47 ----------------------------------
 target/arm/tcg/a64.decode      |  8 ++++++
 2 files changed, 8 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6e9d040ebf..08f24908a4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9531,52 +9531,6 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
     gen_restore_rmode(tcg_rmode, tcg_fpstatus);
 }
 
-/* AdvSIMD scalar shift by immediate
- *  31 30  29 28         23 22  19 18  16 15    11  10 9    5 4    0
- * +-----+---+-------------+------+------+--------+---+------+------+
- * | 0 1 | U | 1 1 1 1 1 0 | immh | immb | opcode | 1 |  Rn  |  Rd  |
- * +-----+---+-------------+------+------+--------+---+------+------+
- *
- * This is the scalar version so it works on a fixed sized registers
- */
-static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 11, 5);
-    int immb = extract32(insn, 16, 3);
-    int immh = extract32(insn, 19, 4);
-    bool is_u = extract32(insn, 29, 1);
-
-    if (immh == 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0x1c: /* SCVTF, UCVTF */
-        handle_simd_shift_intfp_conv(s, true, false, is_u, immh, immb,
-                                     opcode, rn, rd);
-        break;
-    default:
-    case 0x00: /* SSHR / USHR */
-    case 0x02: /* SSRA / USRA */
-    case 0x04: /* SRSHR / URSHR */
-    case 0x06: /* SRSRA / URSRA */
-    case 0x08: /* SRI */
-    case 0x0a: /* SHL / SLI */
-    case 0x0c: /* SQSHLU */
-    case 0x0e: /* SQSHL, UQSHL */
-    case 0x10: /* SQSHRUN */
-    case 0x11: /* SQRSHRUN */
-    case 0x12: /* SQSHRN, UQSHRN */
-    case 0x13: /* SQRSHRN, UQRSHRN */
-    case 0x1f: /* FCVTZS, FCVTZU */
-        unallocated_encoding(s);
-        break;
-    }
-}
-
 static void handle_2misc_64(DisasContext *s, int opcode, bool u,
                             TCGv_i64 tcg_rd, TCGv_i64 tcg_rn,
                             TCGv_i32 tcg_rmode, TCGv_ptr tcg_fpstatus)
@@ -10476,7 +10430,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
-    { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 146500d9c4..30e1834d99 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1699,6 +1699,14 @@ FCVTAU_f        0111 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
 @fcvt_fixed_d   .... .... . 1 ...... ...... rn:5 rd:5       \
                 &fcvt sf=0 esz=3 shift=%fcvt_f_sh_d
 
+SCVTF_f         0101 1111 0 ....... 111001 ..... .....      @fcvt_fixed_h
+SCVTF_f         0101 1111 0 ....... 111001 ..... .....      @fcvt_fixed_s
+SCVTF_f         0101 1111 0 ....... 111001 ..... .....      @fcvt_fixed_d
+
+UCVTF_f         0111 1111 0 ....... 111001 ..... .....      @fcvt_fixed_h
+UCVTF_f         0111 1111 0 ....... 111001 ..... .....      @fcvt_fixed_s
+UCVTF_f         0111 1111 0 ....... 111001 ..... .....      @fcvt_fixed_d
+
 FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_h
 FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_s
 FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_d
-- 
2.43.0


