Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160B1D10C00
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4l0O-0001l2-N3; Sat, 26 Oct 2024 13:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4l0I-0001Zn-0k
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:55:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4l0G-000414-Cv
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:55:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7204dff188eso1804445b3a.1
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729965306; x=1730570106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24+esFE6+JL8RGwya1e53/JfhayCv7uvb5v74uRmx/E=;
 b=J+rwYP8J+0luC+jAv2dTgPqG2WNzBgg+bWUyGHmidDIhWkDM4FNlazSqmAcOxOgfAf
 lfozgfwZRr11wERLPpg0hO2NXzKcjSwKvNXVRpS/V+HadIP3Yz8eO5D6rJ041iPWsBTw
 9DwxNYIH8Mj0hBnymHON0wCLWnvlk7kP8u+FMT6f4UKGBGWuxvlv8LOyKh6ENFwbCOyG
 Aed0OFoNUYuyvgosIwhlwpOE0kn6dhAVWM2Gw6X4lO8V32lgwne+63Shb7KAwt8jub6u
 iOImvWtg+8c/QSDH5KVIx2gcRgFeIl840xWZvMznuxAYEE6E8x/6701VlHvhP7nQJYsY
 RJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729965306; x=1730570106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24+esFE6+JL8RGwya1e53/JfhayCv7uvb5v74uRmx/E=;
 b=GgNhIED17HQl96kNSExKZxn5CcJRf/7lCJgC1BLOyTc0+cX6xPGSdUFH1jhIBNwSAv
 Wdbkc1fRq28+nRhOPMepPrwlvDWBULpT5gl34Up1zbNaSuFWksgpAV16Co7KWbno9SVx
 9eQgQI1kZCHGkbCJW48Bjsoxu3G6ojhnm+G8HbEjIcvbdEXl3tvquGsAWoFGH0RGU2ix
 tSyHmbBWdk02uGJsm2FY6nvxmou7KcqfdwxsKQTUnmip6IPIJBRj9OqB9IRZukDso3dl
 pl8byby7tSiZ76rs/wzR+Z+AqHMjSIpgDevDsSkTYZ8lNQwABrmtrT/RpG5WCG9eOiC/
 /Fgw==
X-Gm-Message-State: AOJu0YxRDZ/VWixYR7K50OAOZp8TOs0sa3FPxWSpJZi1jJeAgOJtDo3R
 ulArtHpoE5j3LDo1DemRLD3z1ae+01uAuLwUjZU6bl5twQm3d+8L1E29RyugCkUFKwzEa+PEthU
 o
X-Google-Smtp-Source: AGHT+IH1iPbQO3sFvgxurbYVYwhhnPmnUfGRsVkQ42fv+zflTQv11fFcZi4UjnCSZUbEh5SB3bRbwg==
X-Received: by 2002:a05:6a20:4499:b0:1d9:1f51:faeb with SMTP id
 adf61e73a8af0-1d9a85349ecmr4471366637.39.1729965306584; 
 Sat, 26 Oct 2024 10:55:06 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8a77412sm2936620a12.94.2024.10.26.10.55.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Oct 2024 10:55:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 9/9] target/mips: Remove unreachable 32-bit code on 64-bit
 Loongson Ext
Date: Sat, 26 Oct 2024 14:53:49 -0300
Message-ID: <20241026175349.84523-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026175349.84523-1-philmd@linaro.org>
References: <20241026175349.84523-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x432.google.com
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

Loongson fixed-point multiplies and divisions opcodes are
specific to 64-bit cores (Loongson-2 and Loongson-3 families).
Simplify by removing the 32-bit checks.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/loong_translate.c | 41 ++-----------------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index c02e60bb15b..a005c279a3e 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -31,13 +31,6 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2, *l3;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -61,8 +54,7 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
     tcg_gen_br(l3);
     gen_set_label(l1);
 
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double && TARGET_LONG_BITS == 64
-                                        ? LLONG_MIN : INT_MIN, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double ? LLONG_MIN : INT_MIN, l2);
     tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
     tcg_gen_mov_tl(cpu_gpr[rd], t0);
 
@@ -93,13 +85,6 @@ static bool gen_lext_DIVU_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -147,13 +132,6 @@ static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2, *l3;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -173,8 +151,7 @@ static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
         tcg_gen_ext32u_tl(t1, t1);
     }
     tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double && TARGET_LONG_BITS == 64
-                                        ? LLONG_MIN : INT_MIN, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double ? LLONG_MIN : INT_MIN, l2);
     tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
     gen_set_label(l1);
     tcg_gen_movi_tl(cpu_gpr[rd], 0);
@@ -205,13 +182,6 @@ static bool gen_lext_MODU_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -257,13 +227,6 @@ static bool gen_lext_MULT_G(DisasContext *s, int rd, int rs, int rt,
 {
     TCGv t0, t1;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
-- 
2.45.2


