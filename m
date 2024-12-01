Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CB1D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlbZ-0004H1-U6; Sun, 01 Dec 2024 10:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaU-00089q-FJ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:19 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaS-0005GP-86
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:17 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71d5984e56fso1526945a34.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065815; x=1733670615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vs1A3RHcACoGULTwDSuyWgmFAKJoxObVS6XkdoRByFU=;
 b=BAOmR+o9cHpRQ1+fizPddZ1LYJb75DS+S8nRhxJKHZ2nV92Dwv2QTcfdF4nVRLcg7T
 yXFwzDCw5ZQUf1dO/2TPekHIBBnggs2fT8/TJAz/6YaAMo6ikZAonJEfFQNgRbgGEsbY
 kxHhO57EAJjxoEkEakPh6PxZrRhn+kGXUmjvts/bavVq8Gzmzp7N9rXdBouFgHyNiM14
 8AyFLUrGICOoTwPL3+T78uBM6VLyXJnt6ujzQBugEM9UgL2+kOgiR9Ge347k+umrRNtm
 hUQPCoYpU/JsS2GDuZ05xwj1LdtWVoKV28xoOnb85F12osmgHbNdQB61iPLontsdxCr0
 RY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065815; x=1733670615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vs1A3RHcACoGULTwDSuyWgmFAKJoxObVS6XkdoRByFU=;
 b=DFD1RwMfH1dWy4QnAbm5P+apHfW34HdiqLkLOn3U81RtlDiyWKzmFXjDtzpaYPeyEz
 eSXd8rdC2Md4zcEyh0Hy5kU3FWksPvdHadkc11xRudjlBfkMaLljBcQYvm2305Fp03/N
 82M4a0YS6dS44i61YQ9T5bnHKJiecP7CKSNF38F2X7PxW39V/8UzmGRsuNBg03ZFdas+
 4sIUXeZPAwjvJGrmScNfhfuz4b/d4kg63staDZzILLj8uQ3dCc95FkThCCAkSjOahQE9
 8oU0qJbFESlWZOj93XYfBts45iuTeYbpALaF8nxIqYQX7HKKO3Nqr4SsIScY7+Ffbz/3
 6Zgg==
X-Gm-Message-State: AOJu0YyZ+A5h9nJ5EtSmnC+nvEKRbTfXb8eVZRCjy4/StWkijU8C4Xt9
 QKVbsmyMpMOvQmNQaDoSEhjcAUhW7uEISxREfCRXiwu/Dmdkcqjl5imrlokjMlzArbyVugBMA7T
 SEqU=
X-Gm-Gg: ASbGncuTjcZIQYWeRJpZVvQZ65rUHHawlW+bHVuG+KYW30eEPYBLneCXw2krLowPc+r
 MEUb6rn0liaGkqe3xFhiU6edccm08xQu9MM2AhRhW/TFpNYxDtByUVgSfNTKj24dWeAc2fCbMQY
 DnUc2Vz9b0w+yL6FD5w1CALaCJkOI0pMEroHRJ9QX3Q4CyeEDq+3RtdaeXW4BtLBp6ddJiOu8do
 Qs7x7eJpHozmugkXX3KPOF08V8GSIaM2pF+Yu2Ot1KDRjPjbTdI0YUdPDK2671FmECb8bpsK5Kj
 xcCdLd2PoAgREH9xqXE1YkJubr6opTfoJSyN
X-Google-Smtp-Source: AGHT+IGya5fEYEEUeH8BaSexJJBgRDSY1/izVpQYmPjq+T8oIzlPpj4/izAdPeldDV4CGC/36DjcIg==
X-Received: by 2002:a05:6830:6f8c:b0:71d:4385:665e with SMTP id
 46e09a7af769-71d65c93a1bmr10803522a34.9.1733065814943; 
 Sun, 01 Dec 2024 07:10:14 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 58/67] target/arm: Convert [US]CVTF (vector,
 fixed-point) scalar to decodetree
Date: Sun,  1 Dec 2024 09:05:57 -0600
Message-ID: <20241201150607.12812-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 9808b976fd..ea178f85c2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9543,52 +9543,6 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
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
@@ -10489,7 +10443,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
-    { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 707715f433..197555555e 100644
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


