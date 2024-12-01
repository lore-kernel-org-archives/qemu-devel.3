Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93BFD49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlb3-0001wz-HD; Sun, 01 Dec 2024 10:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaT-00087O-Qo
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:18 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaS-0005Fu-7O
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:17 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71d46995b34so1619119a34.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065814; x=1733670614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEDqEqk94vzn4bViKXoAxj0y4sF9hh+x/V/JUQRicrc=;
 b=DxxmLifEoZTo9DXP4WVWMwuB5zL8b3P99pRltRC0b2VJBV2cm4haJ1LGE8HDxb5fOs
 Kz2ZwEpiuwV728NxgpdU4/ANYezWyiqirZ9t7h/4/o5f7h7+wuF6+JSjJxW1t1VtBFTs
 Xg1aCHk3erkVNkdFThul1tbzprJwCsm3hJr6Z7rpLp3LmtHStrwIoK3apeiihhWJmSIH
 j7+pAicdcxYWYvChm9F558UTem7JE4abPqedAT3hRxq0IQ4evU6RaRMQGbpRPRov/vs4
 CKTOB4v5pvhr9RUdjGiP6aNBsahoCj0np5bnaQLuQiVrnCA+k0RIPGjaTZf4BZ6gHXZt
 GI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065814; x=1733670614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEDqEqk94vzn4bViKXoAxj0y4sF9hh+x/V/JUQRicrc=;
 b=ZhNZeI4HpY+6UYGZjupHPZyqy6tRdYZM5ckvw4qrTSBTOzBPcMzAAMhdglQ7Eg4bwX
 GIei7Rdz7v7tatQ8SdQnVmOoE7zPnvdt8dSZ2gzpBnqZ4Cfhc3Qpd98b0NDyPU2INqlL
 gLS9L1ZnCOh3z7ZKSOL0REQSJOkigTM97GbC4cuReQTc4mEc9vnupAOxg7qM6IOfhyc+
 nP/YLXDEZUJo8CcfTh3d0dShwFYCwvE43zT/mn0lOshUolWd5eC0qmDu9zooLFz8xDrF
 MPD9wg1nFmzz0nyrsnGgV+Z241p9EZqp37ZE72B/7sDnl9ATgUv9jgDo1Ohqzzd5AE02
 h2+g==
X-Gm-Message-State: AOJu0YyKK5eBeA6BD+t+gAps0RH612sTH9F/SPyoUeCEDTy+vgG7MzED
 eAqBkNn8G7u4Oj+icRf4UKKKOEbj+VfDTAjs4FRJ94h2fvIAQ1LlR0qVRwyt8//aTWydOPnooNr
 58g4=
X-Gm-Gg: ASbGnctfOe7teE3UO5Tv0bDVRV6rSiXD5z4Xzb6MNXLSt++XQgAIj8oqnRTj4SY8gj5
 hTseZXbgA/xC4AtBPHbnwGpPUDpb+3r2QSZ13xpCZyNd9/aVDlcodr+FeezetwjQFPTu3ytgrd8
 QFE9k0m35oXyvy6MmXXi3uEJsViVNjBHM98vKKREaiaswht8K1vKCgT4Us/GJ0R/VF7Gm2A4kVF
 7/Wv0zqrK46ee298gFyUPH5JbawtSfWKW7XL941fN637T5hdgLcJA9/aktuMwBzOU3D31ZtWe9D
 oPEsVi/KCjvrgJSldSLuKS4xZp+CXEyLFOY7
X-Google-Smtp-Source: AGHT+IHQChBYk8GxCaWd2BubwF3Zx892bFU6atH7et1WSoy6Oty6OFU9uFW6Dz/SpPNIUfL9Xzo30Q==
X-Received: by 2002:a05:6830:3142:b0:71d:4dbb:7232 with SMTP id
 46e09a7af769-71d70ba8e87mr8285675a34.3.1733065813791; 
 Sun, 01 Dec 2024 07:10:13 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 57/67] target/arm: Convert [US]CVTF (vector,
 integer) scalar to decodetree
Date: Sun,  1 Dec 2024 09:05:56 -0600
Message-ID: <20241201150607.12812-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 35 ++++++++++++++++++++++++----------
 target/arm/tcg/a64.decode      |  6 ++++++
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bdeb0288fd..9808b976fd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8603,6 +8603,29 @@ static bool do_cvtf_g(DisasContext *s, arg_fcvt *a, bool is_signed)
 TRANS(SCVTF_g, do_cvtf_g, a, true)
 TRANS(UCVTF_g, do_cvtf_g, a, false)
 
+/*
+ * [US]CVTF (vector), scalar version.
+ * Which sounds weird, but really just means input from fp register
+ * instead of input from general register.  Input and output element
+ * size are always equal.
+ */
+static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, bool is_signed)
+{
+    TCGv_i64 tcg_int;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    tcg_int = tcg_temp_new_i64();
+    read_vec_element(s, tcg_int, a->rn, 0, a->esz | (is_signed ? MO_SIGN : 0));
+    return do_cvtf_scalar(s, a->esz, a->rd, a->shift, tcg_int, is_signed);
+}
+
+TRANS(SCVTF_f, do_cvtf_f, a, true)
+TRANS(UCVTF_f, do_cvtf_f, a, false)
+
 static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
                            TCGv_i64 tcg_out, int shift, int rn,
                            ARMFPRounding rmode)
@@ -9850,16 +9873,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x6d: /* FCMLE (zero) */
             handle_2misc_fcmp_zero(s, opcode, true, u, true, size, rn, rd);
             return;
-        case 0x1d: /* SCVTF */
-        case 0x5d: /* UCVTF */
-        {
-            bool is_signed = (opcode == 0x1d);
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_simd_intfp_conv(s, rd, rn, 1, is_signed, 0, size);
-            return;
-        }
         case 0x3d: /* FRECPE */
         case 0x3f: /* FRECPX */
         case 0x7d: /* FRSQRTE */
@@ -9879,6 +9892,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x1c: /* FCVTAS */
         case 0x5c: /* FCVTAU */
         case 0x56: /* FCVTXN, FCVTXN2 */
+        case 0x1d: /* SCVTF */
+        case 0x5d: /* UCVTF */
         default:
             unallocated_encoding(s);
             return;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 4cb5b20826..707715f433 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1657,6 +1657,12 @@ FCVTXN_s        0111 1110 011 00001 01101 0 ..... .....     @rr_s
 @icvt_sd        . ....... .. ...... ...... rn:5 rd:5 \
                 &fcvt sf=0 esz=%esz_sd shift=0
 
+SCVTF_f         0101 1110 011 11001 11011 0 ..... .....     @icvt_h
+SCVTF_f         0101 1110 0.1 00001 11011 0 ..... .....     @icvt_sd
+
+UCVTF_f         0111 1110 011 11001 11011 0 ..... .....     @icvt_h
+UCVTF_f         0111 1110 0.1 00001 11011 0 ..... .....     @icvt_sd
+
 FCVTNS_f        0101 1110 011 11001 10101 0 ..... .....     @icvt_h
 FCVTNS_f        0101 1110 0.1 00001 10101 0 ..... .....     @icvt_sd
 FCVTNU_f        0111 1110 011 11001 10101 0 ..... .....     @icvt_h
-- 
2.43.0


