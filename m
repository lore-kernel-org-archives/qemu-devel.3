Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6D5E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xU-0004Cf-3c; Tue, 10 Dec 2024 11:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wk-0002nA-UI
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:52 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wi-0006QE-Nj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:50 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53df19bf6a9so6636850e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847527; x=1734452327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oj/RkpXIcAPwY3YCVzEeJhtiY5v3oKNvSYJvuwDEeY=;
 b=WRDiHQROX7lsGE37nSzhyfqPvTtkcpJw3/ZZmuX1YcmVgHYtX937lxNw/kpigcpCVB
 49LvlYqevIJ93eDEU75tnRGMx3/oG6fu3affHN/qu0kvyEAAMgEONzGYUgEnIzSgSsBf
 p3Ukswb+7B7MxnobhsAfkjUxpcgtHMBA9XI8V/98B/gEQY5F/fWQIiV4Kjl94BeA4eqr
 ZdjlvqBQ/gn7boF7oFv83XtL3Kalzr9dOhMr0v17/vqxfQhxRyKPpS2Z7fy4z6JU7d4H
 7bkcus7btl4GVFU6ZI+owVFkQ6rW9OUwDjnk64oDBU9dlZ89VSo57iMqaDwUUhv9KtWB
 3Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847527; x=1734452327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oj/RkpXIcAPwY3YCVzEeJhtiY5v3oKNvSYJvuwDEeY=;
 b=t6h6tL9h/yf0I6Z2UhPd6/6moG4+ykJiQzaA7yL1h99yH4KycAp/Z5hIWX0vxeWwa5
 SvzEp9Ux02Lo0QzRWoNnO2qthH9Vo6q3mh+QEjG1fZinGkovExieQqhaefd+o+YgxUCI
 1+OF+0a0nDZcMZiFV+8qNNhD259u7UiFwmvkU0LTt5El7WynUFq611g1i+RYJwn4FIXt
 MPY0vuA5KjRzyeFOtTNQED5lwarLwRmGKn30lOmJyiGk1pFPd4GlCAh/0or+OqOFNop8
 sDpKvjnGeEKs2qrfGm7Of4Xo7ggBgyjCqOCOUtRsXY3YJEXB67lFts/g+KSp8GezAucf
 pahQ==
X-Gm-Message-State: AOJu0YzSWX7sYwm0iOHDV/W4JRFo5j2B44sgDzqEmWy51ObKpCtJo1m1
 JV2aHezlIOsmV6Xv1HD1i3RhO7LqAk/27iQPwLhTDLOeHTNqnNA3AVlEpQ0wgyFv+NImQbGFB2y
 nhsQWNGCh
X-Gm-Gg: ASbGnctN+y+rpZ6/B1F/ZWGTWo8b4yqYmOumoUH/je6gIeI0NS9bJKgKJujikMaY3zd
 fPnVivGNP3BDJNTI+4+EtcIi3rIpTd/S+0tWAzJWxy6dDQ7oAgSD9XFMIds7MZQhjRhRGGn1E2J
 URejx09ZSnurKbLwXTvEJJPOnIYyMxRidCx38xVk53fcwLYWKUqWoCtXhaaGXr5ORrN/z9sotTK
 EwmTzQ7dD+ofSzd17TERbppmT7a1yCxdJ2ibOjMG8j2zXA66jkIQ+H8yVE=
X-Google-Smtp-Source: AGHT+IEWeDVjXvnROePaDqr38/4apBq9l8W6QT1jR/rItMHCQdqcEQbIiAyFIqyPoI5aioXJnd1vng==
X-Received: by 2002:ac2:4e06:0:b0:540:2549:b56e with SMTP id
 2adb3069b0e04-5402549b696mr1653248e87.12.1733847527037; 
 Tue, 10 Dec 2024 08:18:47 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 16/69] target/arm: Convert RMIF to decodetree
Date: Tue, 10 Dec 2024 10:16:40 -0600
Message-ID: <20241210161733.1830573-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 32 +++++++++-----------------------
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d7747fcf57..1af41e22eb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8045,30 +8045,18 @@ TRANS(SBC, do_adc_sbc, a, true, false)
 TRANS(ADCS, do_adc_sbc, a, false, true)
 TRANS(SBCS, do_adc_sbc, a, true, true)
 
-/*
- * Rotate right into flags
- *  31 30 29                21       15          10      5  4      0
- * +--+--+--+-----------------+--------+-----------+------+--+------+
- * |sf|op| S| 1 1 0 1 0 0 0 0 |  imm6  | 0 0 0 0 1 |  Rn  |o2| mask |
- * +--+--+--+-----------------+--------+-----------+------+--+------+
- */
-static void disas_rotate_right_into_flags(DisasContext *s, uint32_t insn)
+static bool trans_RMIF(DisasContext *s, arg_RMIF *a)
 {
-    int mask = extract32(insn, 0, 4);
-    int o2 = extract32(insn, 4, 1);
-    int rn = extract32(insn, 5, 5);
-    int imm6 = extract32(insn, 15, 6);
-    int sf_op_s = extract32(insn, 29, 3);
+    int mask = a->mask;
     TCGv_i64 tcg_rn;
     TCGv_i32 nzcv;
 
-    if (sf_op_s != 5 || o2 != 0 || !dc_isar_feature(aa64_condm_4, s)) {
-        unallocated_encoding(s);
-        return;
+    if (!dc_isar_feature(aa64_condm_4, s)) {
+        return false;
     }
 
-    tcg_rn = read_cpu_reg(s, rn, 1);
-    tcg_gen_rotri_i64(tcg_rn, tcg_rn, imm6);
+    tcg_rn = read_cpu_reg(s, a->rn, 1);
+    tcg_gen_rotri_i64(tcg_rn, tcg_rn, a->imm);
 
     nzcv = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(nzcv, tcg_rn);
@@ -8086,6 +8074,7 @@ static void disas_rotate_right_into_flags(DisasContext *s, uint32_t insn)
     if (mask & 1) { /* V */
         tcg_gen_shli_i32(cpu_VF, nzcv, 31 - 0);
     }
+    return true;
 }
 
 /*
@@ -8297,11 +8286,6 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     switch (op2) {
     case 0x0:
         switch (op3) {
-        case 0x01: /* Rotate right into flags */
-        case 0x21:
-            disas_rotate_right_into_flags(s, insn);
-            break;
-
         case 0x02: /* Evaluate into flags */
         case 0x12:
         case 0x22:
@@ -8311,6 +8295,8 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 
         default:
         case 0x00: /* Add/subtract (with carry) */
+        case 0x01: /* Rotate right into flags */
+        case 0x21:
             goto do_unallocated;
         }
         break;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7a40ca455e..454494742e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -753,6 +753,9 @@ SBC             . 10 11010000 ..... 000000 ..... .....  @rrr_sf
 SBCS            . 11 11010000 ..... 000000 ..... .....  @rrr_sf
 
 # Rotate right into flags
+
+RMIF            1 01 11010000 imm:6 00001 rn:5 0 mask:4
+
 # Evaluate into flags
 # Conditional compare (regster)
 # Conditional compare (immediate)
-- 
2.43.0


