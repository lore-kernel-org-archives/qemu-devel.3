Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7E9CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95p7-0003qx-5y; Wed, 15 Oct 2025 14:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95ov-0003oR-It
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95ok-0006GM-CM
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so5307259f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551297; x=1761156097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrPHlsfsgalogJYV5kdJutsTBB8awCOsQOV06x5p5gM=;
 b=VCCHOJa79TO8nsBMTpTeio/r2gQhA2GiHojgtcbXrHdJcI0yphIiKyBpTUIXh94mEx
 uj/FKtoc4AO7mbO3Y/Nlg49V2LbcH2X6ptid4C5OwFTvsvK/aPueo14AnWsfsbhzh7uL
 oTES6vLMnKR+kd3GNriskmXbl1uIqVhlShc/z2HHJ61T/XZwQ970xm+PyuaQsg/t17tX
 tMO9eaPdVQkzUmU6fIoHKpYeFm6c46PmoDeZHyV16VAtBeAKueVrcNuQYxqCIKYKEU0l
 ncD3x82emcadesFo17e5TwmPDyloViaCmT7VeMHmyfaXwulAAHDMJW1Cumr2p0hag6nW
 jjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551297; x=1761156097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrPHlsfsgalogJYV5kdJutsTBB8awCOsQOV06x5p5gM=;
 b=TFkcGywg5mspEPHR6lpU6GSLisCIc/TREEfzI4iv/ekF5IlQEznhQeHGUn++MwsioH
 6rkR6OsG1pH0q7CZcsBG0ZGExjqFPU5qqADXQAnig67tfV4Jte/auJl5GEmzeQc5ssWc
 vcvGkMFElnoyuFK4t9+1sh80Ml+xWQvJFhtDt49N5JL9NTKYZSjuO8CZfHkt0W16vyG0
 z9cqE2SFb81jsmUcxnBrVtOs9O5GErlA78MWIGhqlJ8fNBLJgq5SVCT4/HDWcTvNkVpM
 gfMv+6O280DmyzTwmmqx3PN0AXtMNOQXN6SsYyhmnRpItKqhFNI6vJSAXwRacnei38EI
 m1fg==
X-Gm-Message-State: AOJu0YwS9py1eOWuZCr6TU0ScoTcmWZMfejQnKqBDs9p6AnJQm9GTNKq
 gDpbxwQbESpF8msTPpJhkJ24pjta5Skf5knSDXM1sSmNyYRrYbMw7Uey7uadyTVfaZL12WyvOiZ
 7Cq8QQlihlw==
X-Gm-Gg: ASbGncs9JAxHmUwLVbmNNGNfb6Onr9W4SsAlKee0RxX9XT3+GhBaZ/m6b8nGJgkOo9O
 PnPGmRJru2s8DUWx1x/Et19bATtIivIOPkgoxFE/03uPNjC4eqWnsOqVU7gfeWwTh6plHpCx5gZ
 ZMNiPyChVGbKGl8RcyvSDL9uwB7vyAYhPahR84gCAVg8PNH3GPXeg/DNpzbA6wPAabU5XD0/p9b
 Nm/27/0ux7gwga7ueAGveX28+3WUz7AdDRWIMbh8TcTwn6vnOGaxw4mNs3drcPVWtgEsyE3MUc6
 ex1ZMq6V08+BWGs7Pqt+6AJIZ2wHqzjrgpeuR3hworvigIfUVrFSDiXUd5uhQN6HxSLAJypZKBa
 +jVPn+5fvJYRkyfJ7wOWtCZkhslab1m8yMs/UQuWbT20uJveCsragDovl4kOSm4spJiwFAI6oR5
 84+xfzgTrV+x7TH+08bWqCL5yccp6T0g==
X-Google-Smtp-Source: AGHT+IFC+NefnqddUSKxjh0l5NYKR/NIZLfhlDGGPJS9Jle9EJtDpPjETc4rorfbsat69fGq3hoLUA==
X-Received: by 2002:a5d:5c84:0:b0:3ee:1461:165f with SMTP id
 ffacd0b85a97d-4266e8f801amr18061095f8f.31.1760551296717; 
 Wed, 15 Oct 2025 11:01:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d49bsm31762559f8f.10.2025.10.15.11.01.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 11:01:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/7] target/microblaze: Remove target_ulong use in
 helper_stackprot()
Date: Wed, 15 Oct 2025 20:01:12 +0200
Message-ID: <20251015180115.97493-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015180115.97493-1-philmd@linaro.org>
References: <20251015180115.97493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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


