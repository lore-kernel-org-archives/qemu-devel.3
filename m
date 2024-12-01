Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED6BD49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWi-0001Ek-9z; Sun, 01 Dec 2024 10:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWe-0001Au-7w
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:20 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWa-00043B-Ga
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:19 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f1dc7c6c67so903518eaf.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065572; x=1733670372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2K3bD/y5P6zAvU+4G/5z3hxC4KhsNKhW8wgn11RzbE=;
 b=miuMmj09vjBvS5HZ5LGHA/ukIf82rFQCwR/WSbui1rTmzta+HTvtWcfakEerAwAtcK
 LWA9Z20YA63550g/EhjK6bceYZtz1Fj1HBJC7g8fpQlYHSiZKAjoIyeEdA3FU+4qRW0j
 GQ6x07RZCpFz0stD7zaqhfRYnF4udFPS5u2X8GUewAvX5fdHZw+Wb8vvKjaJhbJ8ICQq
 UsolIXflrek0RPH0eBi+31CLuTJuUWK5v5yGdyXfRX5stod/V+U2XfNHM/HDaxbT+sid
 rfl8Gdrjivgi74LTlWFbokrb7uGx1/p/EdeXFG7b8q4yBWF0+5fNeyS4+/7eYRipuE3j
 dEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065572; x=1733670372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2K3bD/y5P6zAvU+4G/5z3hxC4KhsNKhW8wgn11RzbE=;
 b=BQYj1dE66zlK9SloFare1bHNktwzncUXvLqmzo1Gd4VKqyzTzYbf+ENwxX0Lwt6gQp
 TPIy1y8UqR4h88cgKVXpjpwlwfx9LJL/+Nh9jgTHLWq/z6QM6tCn4+4YEw4re2pwMI+O
 O0OZbECP3YdZtT9uVg589MYJCubPMR4zjKNChA+eKJMaWTp02OzMudFYqYCInZ4rhUPu
 UGIo4Zs28TlLbKGLvwusULnYSuhxg3Em3SDE9NL3tHF+rMSFIPa06SbenguQtcS3XtVi
 5YRpk5jsFz8C7tW9DjV7OF4evArrJxWpCBAEvlST7+LTa9zTkOdi89Ktvbddk4JIgC1M
 ACmw==
X-Gm-Message-State: AOJu0YyFMiEFwUp/3pBYxyijp5zdX/F6wXoWP9OXHMvoTKhgtwRxenRN
 nTlZytwbWPqHB4WZMHMJgqsUM3lq1EqrNq1rc3IP2QGtndepU8voiXJZ75/1UwmAnYw6io4+7eG
 yAV8=
X-Gm-Gg: ASbGncu6IkFiFHa6M1YOUtfYrgS0lcJHRcg91ZxcuT2KmH34j6IxZYYMu5CTaK4De+m
 ivi5iomsbXYOANu0FNAq7iletj/V3EYFEuBpT4SvDZOWVCgX2srVCaRRu+ACeX0josuzs+TglJF
 nxYlxoWCWdetBp4AHZqUAgAAFnK1qf5U9Va2ugNO4xFq8FhsPOvtYsk9TadXjr3z6DbGf4ROmag
 FaHZGz+iRh0M4kwrIilhl4c5ar4N/dU5+zj9andYDviwSHv936rYuzPZF04iK/Jmi8k8gvcdnuD
 fdO4y3huHlPNc7jFwjvr03704x9WfJNZh3TI
X-Google-Smtp-Source: AGHT+IFiKDnZG2MEDbzAIxliaXPD9C5RmIsu3upMHCKJie7MlgvVUdHb18S0uMPJmxDPQEW64Nt1pA==
X-Received: by 2002:a05:6830:43a2:b0:718:1160:670d with SMTP id
 46e09a7af769-71d65cf3da2mr14482298a34.19.1733065572347; 
 Sun, 01 Dec 2024 07:06:12 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/67] target/arm: Convert UDIV, SDIV to decodetree
Date: Sun,  1 Dec 2024 09:05:01 -0600
Message-ID: <20241201150607.12812-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 64 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      | 22 ++++++++++++
 2 files changed, 54 insertions(+), 32 deletions(-)

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
index 197437ba8e..c218f6afbc 100644
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
@@ -649,6 +650,27 @@ CPYP            00 011 1 01000 ..... .... 01 ..... ..... @cpy
 CPYM            00 011 1 01010 ..... .... 01 ..... ..... @cpy
 CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
 
+### Data Processing (register)
+
+# Data Processing (2-source)
+
+@rrr_sf         sf:1 .......... rm:5 ...... rn:5 rd:5   &rrr_sf
+
+UDIV            . 00 11010110 ..... 00001 0 ..... ..... @rrr_sf
+SDIV            . 00 11010110 ..... 00001 1 ..... ..... @rrr_sf
+
+# Data Processing (1-source)
+# Logical (shifted reg)
+# Add/subtract (shifted reg)
+# Add/subtract (extended reg)
+# Add/subtract (carry)
+# Rotate right into flags
+# Evaluate into flags
+# Conditional compare (regster)
+# Conditional compare (immediate)
+# Conditional select
+# Data Processing (3-source)
+
 ### Cryptographic AES
 
 AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
-- 
2.43.0


