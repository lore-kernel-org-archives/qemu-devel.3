Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452C7E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPd6-000508-Br; Wed, 11 Dec 2024 11:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcA-0003Gx-Lc
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:08 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPc8-00018v-Rm
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:06 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-467918c360aso5206951cf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934664; x=1734539464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifcSfCHSTTtxXndi5QQbGHpzoZtEugLsXBXrGvDqkmU=;
 b=PFWBMLA4D3f8YLrZ2ikn7HvTKOHB8++C6vAjRuesDA1b4m3bd1rU1Luun6viGtNOgg
 KX9ubPYUUBBQha5z4M+GsebBz1y9CqWcPdIkDcHDGcgbJNYB+r7QXXZFAITR/bNfSTdo
 7hnTLnJtExJfTpGAYXiZnlhMhKb8FNLMLxCK9GhH2Aba6wlrhpoPJAuzxKVsCOd5ypr2
 HDVNw8GUEHqCqTELkXl5HYygxZoTGrqvggpckXzzEsIQ+FhY4JbQEUEnknfSsIBG3PSV
 /ZE6375fiJt9V+9Ix6hCLUCn7+fuDCo8eNNPtsVG/7gS+A6Iqfbsoh89HoNIMqr+l1y2
 wY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934664; x=1734539464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifcSfCHSTTtxXndi5QQbGHpzoZtEugLsXBXrGvDqkmU=;
 b=vvYrTaDh2mO6yuVEApRr2VZMmDWJCjhrhBrC+hzQGe5Be/EznkAgvGIXZujrtL+0nq
 UKH4oNLpKkv+EFzmSxEod40xNXXLhdRGZR4NCFCOHoBBwd/50/vwcBR7Y2wG9N6q/fCS
 yNm4zhv+S8NNm2y8DWwP4VyQgEJO8qms+vDQpu6m6NnYt0I3QcoIU0TGLWNjw0uuwOti
 I5Pea1fmVTmR3ZA/0bZvbHm1/ZFygJlVnrdDu01SERiDU5lynjpVcC24r74fx21DwhjU
 bUqED2/+2N5suGE6MbNwsLQoVzVDSOuKLr+G6m5wu2uKWQrRb3+LfqIgFLJPOa0YnlZf
 tLAw==
X-Gm-Message-State: AOJu0Yxc5wLqUoC++1Yj/KUvyn0xH+qRPEFk60zNogSWFuyR0tGM0+Ae
 aYVFT5ixiWHjzXnzlG1tUFUFVIJ+HasZQkc1RdATID+1T/sVWoCdnpbCZHxBm8jnbAGQmH5xXSx
 ZigjUmc9f
X-Gm-Gg: ASbGncvweV7YzT6dt2AY41mXm2EzOaRGm+FrIvIHHjl9CB3cvWa/U7zGeK+aL8S1KI3
 iM/jWN85BYWc37bPhm9jHJnaU+FWpGkP9jcdyjUAxcgFtBQWSjQZaRyD4X+Un/sCgeyzFRBUbhq
 Ikx7TcFuiQ+NyKMQo4BZ8GHsw3G4FRr8zJqQtGRm9BQ8E0Hrlf/mr0MiyGZxbR95iU6VfcljjXy
 eNUpWoGASkTvh0dx8bME7PtvIa/kmxJoqjjp9l7GpQQwRQpzog5DCXTBw0I4Q==
X-Google-Smtp-Source: AGHT+IEs4DeUBL/n2fhJ1WeRK03xY+6asPXLgMeywi79P2okcMjp47jSMm6PHss9DKURtjfh5NVXlw==
X-Received: by 2002:ac8:5803:0:b0:467:5711:bdb8 with SMTP id
 d75a77b69052e-46795444052mr5950951cf.46.1733934663468; 
 Wed, 11 Dec 2024 08:31:03 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/69] target/arm: Convert UDIV, SDIV to decodetree
Date: Wed, 11 Dec 2024 10:29:29 -0600
Message-ID: <20241211163036.2297116-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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
 target/arm/tcg/translate-a64.c | 64 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  7 ++++
 2 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b2851ea503..9f687ba840 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7485,6 +7485,36 @@ TRANS(UQRSHRN_si, do_scalar_shift_imm_narrow, a, uqrshrn_fns, 0, false)
 TRANS(SQSHRUN_si, do_scalar_shift_imm_narrow, a, sqshrun_fns, MO_SIGN, false)
 TRANS(SQRSHRUN_si, do_scalar_shift_imm_narrow, a, sqrshrun_fns, MO_SIGN, false)
 
+static bool do_div(DisasContext *s, arg_rrr_sf *a, bool is_signed)
+{
+    TCGv_i64 tcg_n, tcg_m, tcg_rd;
+    tcg_rd = cpu_reg(s, a->rd);
+
+    if (!a->sf && is_signed) {
+        tcg_n = tcg_temp_new_i64();
+        tcg_m = tcg_temp_new_i64();
+        tcg_gen_ext32s_i64(tcg_n, cpu_reg(s, a->rn));
+        tcg_gen_ext32s_i64(tcg_m, cpu_reg(s, a->rm));
+    } else {
+        tcg_n = read_cpu_reg(s, a->rn, a->sf);
+        tcg_m = read_cpu_reg(s, a->rm, a->sf);
+    }
+
+    if (is_signed) {
+        gen_helper_sdiv64(tcg_rd, tcg_n, tcg_m);
+    } else {
+        gen_helper_udiv64(tcg_rd, tcg_n, tcg_m);
+    }
+
+    if (!a->sf) { /* zero extend final result */
+        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+    }
+    return true;
+}
+
+TRANS(SDIV, do_div, a, true)
+TRANS(UDIV, do_div, a, false)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -8425,32 +8455,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 #undef MAP
 }
 
-static void handle_div(DisasContext *s, bool is_signed, unsigned int sf,
-                       unsigned int rm, unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_n, tcg_m, tcg_rd;
-    tcg_rd = cpu_reg(s, rd);
-
-    if (!sf && is_signed) {
-        tcg_n = tcg_temp_new_i64();
-        tcg_m = tcg_temp_new_i64();
-        tcg_gen_ext32s_i64(tcg_n, cpu_reg(s, rn));
-        tcg_gen_ext32s_i64(tcg_m, cpu_reg(s, rm));
-    } else {
-        tcg_n = read_cpu_reg(s, rn, sf);
-        tcg_m = read_cpu_reg(s, rm, sf);
-    }
-
-    if (is_signed) {
-        gen_helper_sdiv64(tcg_rd, tcg_n, tcg_m);
-    } else {
-        gen_helper_udiv64(tcg_rd, tcg_n, tcg_m);
-    }
-
-    if (!sf) { /* zero extend final result */
-        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
-    }
-}
 
 /* LSLV, LSRV, ASRV, RORV */
 static void handle_shift_reg(DisasContext *s,
@@ -8552,12 +8556,6 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
             }
         }
         break;
-    case 2: /* UDIV */
-        handle_div(s, false, sf, rm, rn, rd);
-        break;
-    case 3: /* SDIV */
-        handle_div(s, true, sf, rm, rn, rd);
-        break;
     case 4: /* IRG */
         if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
             goto do_unallocated;
@@ -8616,6 +8614,8 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     }
     default:
     do_unallocated:
+    case 2: /* UDIV */
+    case 3: /* SDIV */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d28efb884d..c218f6afbc 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -28,6 +28,7 @@
 &r              rn
 &ri             rd imm
 &rri_sf         rd rn imm sf
+&rrr_sf         rd rn rm sf
 &i              imm
 &rr_e           rd rn esz
 &rri_e          rd rn imm esz
@@ -652,6 +653,12 @@ CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
 ### Data Processing (register)
 
 # Data Processing (2-source)
+
+@rrr_sf         sf:1 .......... rm:5 ...... rn:5 rd:5   &rrr_sf
+
+UDIV            . 00 11010110 ..... 00001 0 ..... ..... @rrr_sf
+SDIV            . 00 11010110 ..... 00001 1 ..... ..... @rrr_sf
+
 # Data Processing (1-source)
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
-- 
2.43.0


