Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F355E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2vw-0002QS-Vo; Tue, 10 Dec 2024 11:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2vv-0002Pj-2T
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:17:59 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2vt-0006HC-Bl
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:17:58 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53e3a37ae07so3463462e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847475; x=1734452275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s63N5H1NJdR8gVUhJ6lBSzQfPRwDYdjmVxlruA0DAg4=;
 b=Ox+l6cQQYRcdlnVW4dTu3jv3OdfLjyWTDXRVEankWwhxnO89hnmcxySDkakYFlr7qA
 TGNF+d5x0OASGOBRnArPuOnXSOFHeWghYJJZ1jGqSmPx1wiKJrxlii7fsxfNG4xyz2oG
 17IVJTZ/xcRRLdDUs/mVB5Bv7izEYTtPRjbmHXHZlsnSSIDiGgBbqlL12KTGoXKoCFVu
 M/2I61mnC33pIGebPhNeblah1EyBF15JwLmgvHTh9Hmr/ry/9OK97MQ8pqXMp33SVD2S
 3v1kO/PFtNQcptGhqT46cuVuILHgXD38teQgKCriXdzYTpC73W1iYVqv09UeZC5V/ohT
 TLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847475; x=1734452275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s63N5H1NJdR8gVUhJ6lBSzQfPRwDYdjmVxlruA0DAg4=;
 b=lrxgreKHBdgJZufDt5Pma/mJQTB8AvpuZoHybPscFe2Hu+QYe3n+2ikqkTKYNxD8a2
 tGRYp+0rdnkvNm7RpBUg5h8KYhXfmvnaedrDlsp6hGYpSjNDmOEICYU7qqLgdZX2LcfR
 NTgE66oiKnhMSRm8BfRbbqXBQDzSoEzgf2FRZDQdq5sPbGxLRPtjymNc67zqPsUMo2AK
 Ys+GcsdLRfaID1LyWOBER+Z7HsVFt6pqhusNoT++Dkhn4hXP/FhwpW8ld1o3T4nksjYO
 UR68AF0dIxEmGCyl6Ghh/bCLqFUDncAf+EmXh8VSbeNDEvv3QXxNzQOVXKtgJiDJ8ElM
 yCVg==
X-Gm-Message-State: AOJu0Yw0O3sz1TgOwtcO27BeC36k+nBillepYTAfBuEr+Prqu0o3iLOC
 fADGSMnTm3nJcG5ktVIO56SU2gKNmty+dFCVY78+AnZcw5eTgyVSx5qQmAdKmaSSYw4/D18hPKY
 BZFVpOTIm
X-Gm-Gg: ASbGncuN0Vk6T76RxPT7fAVRSLboDkuGf8BwulaMYQLArfvTF2SrRStcBprrAfaFA0q
 CF2lAuTv+o3AVuu1alPIRNU0dYaE38jZMPgDmERFUZ+qx0nvy0fpBuesw7Sm8uIk+Z9hsuTThao
 oLZ4GL+D51nNK0QE0OiXVCh95QR94alH3haytar9/7Hx/Kw4qrpKloLff2ZpM+WH3rr56sGAGeM
 ydXtHiITHNMo1meIif1lV9cCbj2YQAUfQXIyuNigPTPBKu1cKW7kudmF7A=
X-Google-Smtp-Source: AGHT+IGtYJIcGwZFnh3aX5sCF3MU7gR8VxoKqER77L4ePOK4jJCrg6XsLN2s0ZXtfweGxmG0RdZ9tQ==
X-Received: by 2002:a05:6512:3e19:b0:53e:3a53:f884 with SMTP id
 2adb3069b0e04-53e3a53f931mr5111988e87.35.1733847474913; 
 Tue, 10 Dec 2024 08:17:54 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:17:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/69] target/arm: Convert LSLV, LSRV, ASRV,
 RORV to decodetree
Date: Tue, 10 Dec 2024 10:16:27 -0600
Message-ID: <20241210161733.1830573-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x131.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 46 ++++++++++++++++------------------
 target/arm/tcg/a64.decode      |  4 +++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9f687ba840..8b7ca2c68a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7575,6 +7575,23 @@ static void shift_reg_imm(TCGv_i64 dst, TCGv_i64 src, int sf,
     }
 }
 
+static bool do_shift_reg(DisasContext *s, arg_rrr_sf *a,
+                         enum a64_shift_type shift_type)
+{
+    TCGv_i64 tcg_shift = tcg_temp_new_i64();
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_rn = read_cpu_reg(s, a->rn, a->sf);
+
+    tcg_gen_andi_i64(tcg_shift, cpu_reg(s, a->rm), a->sf ? 63 : 31);
+    shift_reg(tcg_rd, tcg_rn, a->sf, shift_type, tcg_shift);
+    return true;
+}
+
+TRANS(LSLV, do_shift_reg, a, A64_SHIFT_TYPE_LSL)
+TRANS(LSRV, do_shift_reg, a, A64_SHIFT_TYPE_LSR)
+TRANS(ASRV, do_shift_reg, a, A64_SHIFT_TYPE_ASR)
+TRANS(RORV, do_shift_reg, a, A64_SHIFT_TYPE_ROR)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8456,19 +8473,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 }
 
 
-/* LSLV, LSRV, ASRV, RORV */
-static void handle_shift_reg(DisasContext *s,
-                             enum a64_shift_type shift_type, unsigned int sf,
-                             unsigned int rm, unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_shift = tcg_temp_new_i64();
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
-    TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
-
-    tcg_gen_andi_i64(tcg_shift, cpu_reg(s, rm), sf ? 63 : 31);
-    shift_reg(tcg_rd, tcg_rn, sf, shift_type, tcg_shift);
-}
-
 /* CRC32[BHWX], CRC32C[BHWX] */
 static void handle_crc32(DisasContext *s,
                          unsigned int sf, unsigned int sz, bool crc32c,
@@ -8579,18 +8583,6 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
             tcg_gen_or_i64(cpu_reg(s, rd), cpu_reg(s, rm), t);
         }
         break;
-    case 8: /* LSLV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
-        break;
-    case 9: /* LSRV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_LSR, sf, rm, rn, rd);
-        break;
-    case 10: /* ASRV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_ASR, sf, rm, rn, rd);
-        break;
-    case 11: /* RORV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_ROR, sf, rm, rn, rd);
-        break;
     case 12: /* PACGA */
         if (sf == 0 || !dc_isar_feature(aa64_pauth, s)) {
             goto do_unallocated;
@@ -8616,6 +8608,10 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     do_unallocated:
     case 2: /* UDIV */
     case 3: /* SDIV */
+    case 8: /* LSLV */
+    case 9: /* LSRV */
+    case 10: /* ASRV */
+    case 11: /* RORV */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c218f6afbc..3db55b78a6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -658,6 +658,10 @@ CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
 
 UDIV            . 00 11010110 ..... 00001 0 ..... ..... @rrr_sf
 SDIV            . 00 11010110 ..... 00001 1 ..... ..... @rrr_sf
+LSLV            . 00 11010110 ..... 00100 0 ..... ..... @rrr_sf
+LSRV            . 00 11010110 ..... 00100 1 ..... ..... @rrr_sf
+ASRV            . 00 11010110 ..... 00101 0 ..... ..... @rrr_sf
+RORV            . 00 11010110 ..... 00101 1 ..... ..... @rrr_sf
 
 # Data Processing (1-source)
 # Logical (shifted reg)
-- 
2.43.0


