Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DA7CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NFY-0000xP-7k; Wed, 08 Oct 2025 02:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NFP-0000tg-Q0
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:02:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NFN-0000eW-DE
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:01:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so6084535f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759903315; x=1760508115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQsmpoPeW153QfGVuuE1WH9+2W3pcJi50GVTjfdpbVs=;
 b=coeOLRatdeTb6EP9cSvVIuo/nYgePOeZmTW9ba75wIm6gVa2z8w22mMdlvgTdou7Tt
 ztmQ8VIDGudoHK8Is4c87u3RWxyWWhmRcXoMEY3VkUb+3jtUmQKb8haxLpXzgF2huhuU
 EryHyikm0Cj87Hj5pmB8XkU1ro+JL68YynHzraenpRCjsE5tzOKxovAf+D9aie2MRbdX
 LpC4Qf0xSfNRf5xPd8wS7JVY/ORP7m2r+nafIIcvdTh6ugsn4obZoCLAlC231UfibTRx
 X1LG1I/FLKAmJWPsN3nlzXmhYePO1EzAQu73u+mk3rgFnBtOPGz7TdnL7YZBH8IgcLEf
 FMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759903315; x=1760508115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQsmpoPeW153QfGVuuE1WH9+2W3pcJi50GVTjfdpbVs=;
 b=qEuUWMWj3OQmGScD8JJPfvlG8oOucOD1IoN3/oon9p2L8DvXArlaZ8g2vy4YhX4d51
 S4nvOudfCV03KJh7bKcCf7dCG9+15DG4KBbhqRGCQ+muoK7zaHPQBp5Dm55R4aGqrTnK
 zSlrJrUltk47BSBlQ7Kjzin55stFeGTiMLJ00hClbMLSJ0bRYgc72zvraLYaKuRhDK/R
 ov+1GuXZRiXegXWjx4RywMoCbjCNMIyXMpH8apTEy4dyZiI1BJpmhilAFo12VTHYubXr
 7gX1+ixyTYCfKe314APyI25BfV0sP5d9uxo4yf2k9xdAhXhAMq7GWZoeiuTzvB70gkAu
 cvpw==
X-Gm-Message-State: AOJu0YwGDl0qL77hbWBqdF3cf0n/evXUqBISEhyH3lCaTgRtTg1nTgKN
 /v79Q//cQm4UHWaeAvFs/Eu3qnaM5TTe1Yq1jiCcqbId+MAYWAAtPkZhDQDJXezhD6PDwGNtjXr
 3pkpFF0D7yODX
X-Gm-Gg: ASbGncs85E09TDbPrjoXzqIjYHEfexj0ojl3cyliZf4LgE0ZdXLhAR7z3cG4MR3Azdg
 /FGLsPK4Kx2GxTAFIYNRc8d/F/BjUKQbFV73/p6Lp6Km5ykW7uPxD05ZUxaq9hC20a7p1klX5t3
 WZpTVHEUQYeSOXJjH2jYk755wbVETOAGCzHSFBfX5LYtBFT3Iz5TQ4k9HTHDiFIoVlp+8BOontt
 3x9enKH68ew785JDpVYGyZvrVvwN+x2RA2OmHBR6IH7TQmOV18yKASVlJM53+JlLNoYbQZjkKBa
 TEp37R2PGXLB7SYI0XVV1DZptu47ocXP8NIh/m9uCng47hjb7f8cotu32AKQuCQDbLlbaXI0z0X
 e/BAPQlaz5hhUOCXKiBYKdTYgqzn1i+3bc3FyHo7sOjs58RHMA2qrDok0y6tqv5sKygrpzmDmLP
 oeTgP0w26IBctm2Dj/pFeYHfa3
X-Google-Smtp-Source: AGHT+IHkllW7Co1meslhNQIl9ob6K+Ub1q0nI7YMNqutZGBiOShVAOxGquX4cji9hRQ9unqJ3cHesg==
X-Received: by 2002:a05:6000:4205:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-4266f752fb9mr1037761f8f.43.1759903315173; 
 Tue, 07 Oct 2025 23:01:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4cc3sm28196503f8f.55.2025.10.07.23.01.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:01:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] target/microblaze: Convert CPUMBState::res_addr field to
 uint32_t type
Date: Wed,  8 Oct 2025 08:01:29 +0200
Message-ID: <20251008060129.87579-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008060129.87579-1-philmd@linaro.org>
References: <20251008060129.87579-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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
index ff33e64a710..04fbd4fe17f 100644
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


