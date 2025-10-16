Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45494CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvx-0001QT-AU; Thu, 16 Oct 2025 08:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mvf-00089l-6b
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MvU-0008ML-5e
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so6069845e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617056; x=1761221856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hqAm09FNNNsCLJ2l1MwRt8dw6+jXQWERN6neWN3YjvU=;
 b=ovCas/1L/POonxSMWPH5RIQFDahMBU6OIwxjNgbIYLJIMTG0ys4eO2TZldE8H1mQet
 O/sBZ9NdrxMALi2oOiAFx7EfpbCjGhfRwSG0NBbwNHTzWSgxM+Lr9AZcw8OjZMjNx5cc
 67RV9uWrNbLPYL2iYbPWDwi2WOLBF7gF31sGctzeU+Yha3rDcBouLnqv0RTCmWrtTUMD
 drEaU2Q7/IlXjjqrYrdAuSbrCJeVkWcFhiuKTzczmbkanMd2wpSKfikGWYgwZQqVVYGD
 jQJJyusZ5jrHSX7fe7Ht9lXebDkYRfxzJO/JTY7s4oQupC92nT9JaVrl/4sXdxyOnJ0v
 k6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617056; x=1761221856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hqAm09FNNNsCLJ2l1MwRt8dw6+jXQWERN6neWN3YjvU=;
 b=ldosqo5X/2J0WPxdndOgbxp97S/A3mhg/DlHkb+lZWCHP6cWnFgPfWK+Jm5SdtIuxF
 J6toL1r/BdK//ZzWO36rCkAUC0kJlxHtnDV9EeYBT1JD2DiW8eIFAQUZIAMb0dqhfrhD
 8pvS8cJunn0bE9ldSVeEIx+iRm57itNUqxNHSqKd19bLvjUuCw7LysuEYkRLS2mrLADM
 6Lxs5frkkazgOviVG7V7Vywq3UeiTwMcv9EXsByHUhf95Nbviwp0KosMXlYSZfFFYTkv
 sKMACNSEuMTB6eiTe56Jghazvuq6TKG4ftr0LXqCKlXk7GbAgAE39JaSoOBCoylsERDf
 VOMg==
X-Gm-Message-State: AOJu0Yz9H24i3BPrF5n7A/1gdkDV1USMU4tyQmmUYnxs81bbT+P5dDYo
 L1V73dg2C9B5eOZL1VfH5knBMdbr8d2KOZdE4rjRnyoZRn+ZjAlLYzfj2FP+aVLOODitHPCuJ4z
 Gm/Y8FKM=
X-Gm-Gg: ASbGncvt4+Yp9hcvan4nLzTOdncjLrs32kECaFXsm8dTIHmgotr9oaMy71cBmr2GP+J
 L4lPAFoKpU5fWn78L8APwUPJprxLHjM49Wp5x9PqeLGFFPyfpbEjWDaccwKencTVuul6hoTwe1+
 Jdn6oGXHmtYQpSyf+ajxetLAy7cSNkVbHywXrsImvbEAR0Yv6kjH+Y1BKEiyzbpLZU0p2TAREIq
 AFv0YSdbuvTkGuJhmWXW3nQH51hGEvopC3KPPEJcBV8xFV5T83Eg0pZHPmXmWhc2LjzTDXLAunK
 ++0uzBnyD/1Uv1wODsX5WwyjT1wEfhStM6LpFjce37Kftt/4MQyDoNQF7V4giNwXLusC1OYMM5z
 by6uCVaOY/sha9O71dg6cUyktEWTs29/jqoslUO97N41IGTJP7/3nrkGbz6bd5iQTJVpNMD0euI
 idyl6hfHiuXDCcOFdUOyaG9J8Ta1XW1w/mrrrma8DVAn/FZJkOaSxs5jGXNMb4TMvb
X-Google-Smtp-Source: AGHT+IHtXGdM18Hob9ifLvfdJ8dFXdDU5rPcHu/PYJ85o2yu75fUmW0r8QQ8QEYoXMqpMx3jpp1w4g==
X-Received: by 2002:a05:600c:35cc:b0:471:1435:b0ea with SMTP id
 5b1f17b1804b1-4711435b1b5mr12800175e9.24.1760617056055; 
 Thu, 16 Oct 2025 05:17:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ca4931csm22989805e9.0.2025.10.16.05.17.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/75] target/microblaze: Convert CPUMBState::res_addr field to
 uint32_t type
Date: Thu, 16 Oct 2025 14:14:42 +0200
Message-ID: <20251016121532.14042-27-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

CPUMBState::@res_addr field is used as u32 since commit
cfeea807e5a ("target-microblaze: Tighten up TCGv_i32 vs
TCGv type usage"). Convert it as such, bumping the migration
version. Use the RES_ADDR_NONE definition when appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251015180115.97493-8-philmd@linaro.org>
---
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/machine.c   |  6 +++---
 target/microblaze/translate.c | 17 +++++++++--------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3ce28b302fe..14b107876a4 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -259,7 +259,7 @@ struct CPUArchState {
 
     /* lwx/swx reserved address */
 #define RES_ADDR_NONE 0xffffffff /* Use 0xffffffff to indicate no reservation */
-    target_ulong res_addr;
+    uint32_t res_addr;
     uint32_t res_val;
 
     /* Internal flags.  */
diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index a4cf38dc891..48efa546d39 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -78,7 +78,7 @@ static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT32(iflags, CPUMBState),
 
     VMSTATE_UINT32(res_val, CPUMBState),
-    VMSTATE_UINTTL(res_addr, CPUMBState),
+    VMSTATE_UINT32(res_addr, CPUMBState),
 
     VMSTATE_STRUCT(mmu, CPUMBState, 0, vmstate_mmu, MicroBlazeMMU),
 
@@ -87,8 +87,8 @@ static const VMStateField vmstate_env_fields[] = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 0,
-    .minimum_version_id = 0,
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = vmstate_env_fields,
 };
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index ed53848bad5..6442a250c5d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -55,7 +55,7 @@ static TCGv_i32 cpu_imm;
 static TCGv_i32 cpu_bvalue;
 static TCGv_i32 cpu_btarget;
 static TCGv_i32 cpu_iflags;
-static TCGv cpu_res_addr;
+static TCGv_i32 cpu_res_addr;
 static TCGv_i32 cpu_res_val;
 
 /* This is the state at translation time.  */
@@ -857,7 +857,7 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 
     tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index,
                         mo_endian(dc) | MO_UL);
-    tcg_gen_mov_tl(cpu_res_addr, addr);
+    tcg_gen_mov_i32(cpu_res_addr, addr);
 
     if (arg->rd) {
         tcg_gen_mov_i32(cpu_R[arg->rd], cpu_res_val);
@@ -1024,7 +1024,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
      * branch, but we know we can use the equal version in the global.
      * In either case, addr is no longer needed.
      */
-    tcg_gen_brcond_tl(TCG_COND_NE, cpu_res_addr, addr, swx_fail);
+    tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_addr, addr, swx_fail);
 
     /*
      * Compare the value loaded during lwx with current contents of
@@ -1052,7 +1052,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
      * Prevent the saved address from working again without another ldx.
      * Akin to the pseudocode setting reservation = 0.
      */
-    tcg_gen_movi_tl(cpu_res_addr, -1);
+    tcg_gen_movi_i32(cpu_res_addr, RES_ADDR_NONE);
     return true;
 }
 
@@ -1173,7 +1173,7 @@ static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
         tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
     }
     tcg_gen_ori_i32(cpu_msr, cpu_msr, MSR_BIP);
-    tcg_gen_movi_tl(cpu_res_addr, -1);
+    tcg_gen_movi_i32(cpu_res_addr, RES_ADDR_NONE);
 
     dc->base.is_jmp = DISAS_EXIT;
     return true;
@@ -1194,7 +1194,7 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
     if (arg->rd) {
         tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
     }
-    tcg_gen_movi_tl(cpu_res_addr, -1);
+    tcg_gen_movi_i32(cpu_res_addr, RES_ADDR_NONE);
 
 #ifdef CONFIG_USER_ONLY
     switch (imm) {
@@ -1885,6 +1885,7 @@ void mb_tcg_init(void)
           tcg_global_mem_new_i32(tcg_env, i32s[i].ofs, i32s[i].name);
     }
 
-    cpu_res_addr =
-        tcg_global_mem_new(tcg_env, offsetof(CPUMBState, res_addr), "res_addr");
+    cpu_res_addr = tcg_global_mem_new_i32(tcg_env,
+                                          offsetof(CPUMBState, res_addr),
+                                          "res_addr");
 }
-- 
2.51.0


