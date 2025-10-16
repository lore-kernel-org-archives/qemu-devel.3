Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C93DCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvw-0001Mi-Ch; Thu, 16 Oct 2025 08:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MvJ-0007if-4k
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MvA-0008KW-DC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:35 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4710022571cso5274685e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617042; x=1761221842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5NgDp5yOCnDId3jcAimzuz3YUwO+MGOGw57YXkaEomM=;
 b=qVqrGrhWqLmCUdib4SvXxo+xPtttfqUKfK4kU6r1CCLn8b0+4NFhdYhR+HU/b413P6
 Hg6syV6//VKBMx21ZzxAbDDcVn/hBgmlhfc1sbVaVd5rKfOMbtCPPIN6lYIRFLxvwNQW
 DIsq+/EQ7Dko4e4w4qVhvAuAYMyQq01sOytTl+dzF2PVW+lideVh9HcO79SAawahvfke
 qslmmyhi7qGTKW7mw41SFWc1koZ+WIktjCjj0xqH9OvSBARJgpt5P6uayTEGrVO4AsLD
 rq9vkcBJKY7/GtooYxmKZaugHF8Y8VaU3brM3juJz/S6L+7unhjlLNvWMSzyayaPjQ41
 9lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617042; x=1761221842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5NgDp5yOCnDId3jcAimzuz3YUwO+MGOGw57YXkaEomM=;
 b=LfBdAHq/3IG7XxXf8RHrig61D9r1JcQwQcJxZZnNbRtHKRWLL7r+Q4/MrX54xJ68JV
 Fwdvl4woFgfqY0ipCp50yrD+bCdljQ4T47gz5c5Vq7SJah/gHvw0YdjeIpP7v4BgBA6J
 bSf450roaRYCFjKtlUBtPqLxk8qR6umPrW6An7EWSQtvq9qJ7aVS8tUawZXp6OgEHTSn
 MwdZoJ0z6rohzI+hCvsXk0sopao1xGk4EloTh/z0SfxphJejaW7W831T+nM2cCwehjJX
 y/XwWPeIvMwPzvCNTsNIntLReGZm5GDjduSIPtmRgnazsQ5h4kV/nfKy3+XjAsWyqaXZ
 2Oiw==
X-Gm-Message-State: AOJu0YyxXxlbcQ4ouWBabA+8zSakA2y5lSoUJgueY4d3PwM33uVMDHUL
 YR032EjIG8kyAB8r4zYKwjDDprOzBkFUCl8z+Qcfx23KaEjJMFKbRLFbpSg+Bdlq7KW1tzaMUnx
 FfcgpFjE=
X-Gm-Gg: ASbGncvMUFQHWg8ADPMarbAwpK5mYusSP/zN90LjEZNnIeRQgFXWDz0Ew8AmkJ5goEY
 2pgLJTWlmRaOe+4uGz0nKcAOaMZbiGrajbNolaWRIn+fcNVClQmPtqIha/BdSdanbCVMqjc26Mf
 MLm89x/Q2wdxSiJKdVtFaK+LPsvBPGwgPzvZj5wubjZeQolu+LvuYe97N78tTpqzGIM4R+MAnWD
 gpfjiLf8LOFsYmZeeoQCkKa354VTw9lPxKJtT1uD0OE3UTk6wA0DXfOI69pDYWLAWBWC+FJjlG2
 FF3QXR2q2VhbvKlUplWHSLgs4MFUKml5GKbRW55oKPl/fwQ8iFuXftZz8Woq3n7AP5zlZPrbyJL
 xcTTdMX+GXOWsOddMt4dqWvwKAEc0crWU5VD2b0xYZ2dvSkJJh0eST07aCFs9eUmN2WLvc561od
 aT/mMsFb/gTG5w4bqJr1mGo6ZNwJqUyWm74OogNp2Y2No+IrZ+y+iLj5Tlq83p40FifErXQKtJt
 9o=
X-Google-Smtp-Source: AGHT+IFYTR9wMmQ9mbV7zbiblvLLRdNKEas0vPWiWH5Cga8ieuhTA9bx90hwkLPrg6qirIHfGTYnKA==
X-Received: by 2002:a05:600c:138f:b0:46e:19f8:88d8 with SMTP id
 5b1f17b1804b1-46fa9b17d03mr262734225e9.34.1760617042369; 
 Thu, 16 Oct 2025 05:17:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711443e7a1sm24894805e9.9.2025.10.16.05.17.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/75] target/microblaze: Remove target_ulong use in
 helper_stackprot()
Date: Thu, 16 Oct 2025 14:14:39 +0200
Message-ID: <20251016121532.14042-24-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since commit 36a9529e60e ("target/microblaze: Simplify
compute_ldst_addr_type{a,b}"), helper_stackprot() takes
a TCGv_i32 argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251015180115.97493-5-philmd@linaro.org>
---
 target/microblaze/helper.h    | 2 +-
 target/microblaze/op_helper.c | 4 ++--
 target/microblaze/translate.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index ef4fad9b91e..01eba592b26 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -20,7 +20,7 @@ DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
 DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
 
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index b8365b3b1d2..df93c4229d6 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -365,13 +365,13 @@ uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
     return 0;
 }
 
-void helper_stackprot(CPUMBState *env, target_ulong addr)
+void helper_stackprot(CPUMBState *env, uint32_t addr)
 {
     if (addr < env->slr || addr > env->shr) {
         CPUState *cs = env_cpu(env);
 
         qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
-                      TARGET_FMT_lx " %x %x\n",
+                                   "0x%x 0x%x 0x%x\n",
                       addr, env->slr, env->shr);
 
         env->ear = addr;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b93a40fedbc..994e1d5cef0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -606,7 +606,7 @@ DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
 static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 {
-    TCGv ret;
+    TCGv_i32 ret;
 
     /* If any of the regs is r0, set t to the value of the other reg.  */
     if (ra && rb) {
@@ -628,7 +628,7 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 
 static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 {
-    TCGv ret;
+    TCGv_i32 ret;
 
     /* If any of the regs is r0, set t to the value of the other reg.  */
     if (ra && imm) {
-- 
2.51.0


