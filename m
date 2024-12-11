Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A4CE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPhq-0001an-SX; Wed, 11 Dec 2024 11:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhj-00017b-8G
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:51 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhe-0002I5-Ua
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:49 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d8edad9932so39772606d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733935006; x=1734539806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmnG9zV0F6eG9aGozAfqS/Ir0uR/PDhoKeXguNvBnYQ=;
 b=aIma41Ndsti+hWY0C2DhLuq0j9eh8aQB0zsC1+Gw7+0yc8Q/HLQ6sz0IRdZjAX94U4
 q0kMxzAO5CKI3F3C/YWG98wbpwILTv2iQzFImDGasUuEu0eKkCIJg7mSzTEZb3CDS8sw
 SD5RPMRjZFypQ8HsMy0mVyc/wGlkJlyduDJ7c00WUMzDRnk1sfLnkgCyDkrvSFxnqztH
 CvmdyJgOyzcNZpov85SPAcWTPTMb31ulZjqb//v6pc3OClQxU5Tv6PS/E+s1cqlwyWMO
 vFxRGXiJIOeU+uPw7OwvYsM78mclOJYOXFt+vN25x2ogyR1OyNOtCiR+Un3594LT/4P8
 csYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733935006; x=1734539806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmnG9zV0F6eG9aGozAfqS/Ir0uR/PDhoKeXguNvBnYQ=;
 b=T7UXYBxwgQiR5/MfQ0fpwmfj0SKEZc4JkgEy8xZSlCci99BmCms7lA1/Z1m/erRp3G
 /3HFVcNh0UT6ECqdDyHweuRzI7dgSdEbUqeVzrWBxTHAu0/8YpSvNbrGrKZzD6zEd1MO
 pNMmNXXFpFHrjgYxVnhQrjhVoBEerE0YeddtS30/zmAEGfrBt/1Sz/1rDQOT5WdTxehS
 UXsmcw8NNnEk73zjGBsi/JUf1grcxi80SJTpu14hucfZx/EIl0H5FLR3aQ7q87e4gTFK
 6cGeHIaWaRO0C2oOUarXEeBEemvizeJ/qo5QO5g9mE5SNDcpGsUbq4ELf6h7Iw/lYju4
 wpNQ==
X-Gm-Message-State: AOJu0YyrhSuxNKrIK2snIyeGvwGllVgvt8b7IhL922aW76fE+uVPle9o
 19LZu6Om3kUEWUeWgZf1Re7MWMLj3TD/sIe7jdPEkuY1AWQWDaGqX4syQ+r2GEA4XfE9N+DBqcv
 jRC14mLyJ
X-Gm-Gg: ASbGncuH84/BgqaVYbhzM70kNJfCt5DHeeSzgy/75ER5+6k34XpA6JgGvVDiMiSh8Vz
 H/fGxJCi72q3c3+GuJdGCaej8gFMc2nN5iVUaGPvRk5EdfCgYUtlhoDlGE3UQ6QhmzpKfkYlhGq
 p09t4BxyyJadykDEMptn8jzkUXEGWN6TlvdvuLj3O7JK7WjhCuQvz/PCe0N4y6KD1tekHPmpx6Q
 s6iRSNkfEoQraIIiuEsdFxdhQjRYtc7tmWA4Nlgrv+9w+/4JYXrcAOhwJJheTOC
X-Google-Smtp-Source: AGHT+IFBd3cJqmsJ1L3Ue+YKTl457Vp+Teq+yBMdM/6g53Bha81Eh5orhZqsw5hlukfzIxg6PrasDQ==
X-Received: by 2002:ad4:518e:0:b0:6da:dbf0:962a with SMTP id
 6a1803df08f44-6dadbf0985dmr29519856d6.9.1733935005974; 
 Wed, 11 Dec 2024 08:36:45 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:36:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 60/69] target/arm: Convert [US]CVTF (vector,
 fixed-point) scalar to decodetree
Date: Wed, 11 Dec 2024 10:30:27 -0600
Message-ID: <20241211163036.2297116-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf30.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


