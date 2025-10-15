Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F712CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95p7-0003r4-Ps; Wed, 15 Oct 2025 14:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95p0-0003p2-Kf
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:02:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95ox-0006IY-Vl
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-471076f819bso6435755e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551312; x=1761156112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydpGCC0LIW2PAhQ+ZiXzjeql1xkA2A/Rbq9DlidsyIQ=;
 b=BLHTf7ATJ6+yL6O2Tc/tUtLIURvXeqxqtNJpXZlYethg+rdq0npio8RUSqdA/rh6dj
 07apgJGCwLqvYWF9/7uMSPGzhxx85OzjZJNNE2UrcoJUzVFRqii00qYMd7T2geOshcXw
 f4jjHuV4hNYKn0LbTTjfUOatsJMD5UgAPyRa521xgJxlWq8/Jsm0rEE9PO33k1I9/3v1
 jFV0dsxixSykpCw8SjNbPlkQdm8yVcAmtUnJ1XWFFMi/4Poz0hF2DxyhN9RN7c0LmrxZ
 SvdcOFCWiGmbfSUf03yl0vq074doCbRKdNU8W8kTXpu5L3751hUpzOgqHLvfvCFqLisr
 95eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551312; x=1761156112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydpGCC0LIW2PAhQ+ZiXzjeql1xkA2A/Rbq9DlidsyIQ=;
 b=gddQiakJ3D30lS+yt0x3Bp4YcZgXt4iO4f5NHNA6kI2Vn3YcTVPie9kc/sSQ1vUO16
 3PHSQHZ+ECGzEfAcNgDI4AhDjgP333NHNpRaQKvlfNzQRtMW3DJY81haIjZLLkVyfteN
 D19ufOFbmrhmfehRS0BULHkbj9TTVUTfuuaecD5e3l7Ml5LORweSyPYzrndAI6YBxhhZ
 8ixPzsC0g1GijW5BxmI/wQiCPb/BY5gzmzdYNKumpddwJ2Tt+vX7Et8eQVCmszApHUQ5
 hs7NF9iFHvjHPu+anLeexX2NLLIG1yy+kQn4GPFdjSIJpffsZurj+6eTkyc51ov01hLf
 fhPg==
X-Gm-Message-State: AOJu0YyEz+lT4Lv3jHqBSYl86KqKaSKeFF4XCjhakJkPhJrCygiHIAGk
 cBaNFvc5rbrwk8h2U5x1pFQ8Z/IhfJz3ujchu0xkQFFy6Y8iljy2s2GFMtAAndRQfv/F2KkhSh1
 8X/eJf5khQMuo
X-Gm-Gg: ASbGnctmCDapNv6ahzSZ0Ge6qjVMwc49vKbEBC8pZNM7qsz2Cf9hXc7JOeQg6FXYZoT
 BkcQtvX3Z4HoWnFjcDCP9AvDCXo3GeH5O9HtCxOKg6wSRyIn5JWbUHa68Ou0xKLZUg++b4MLJ96
 jLwtInSMiGG0VWiviAUif/HCh86p+99ZtUBgoAwuQkkG0GQ4fNerkUaBj1dErNHOQ3ewkVPsPYa
 x2brwOj5OrNBk4hxnbycucel+L5VBRQdJG04vdmC1bVm0kV31LO8/5VggkklyCOBlc5uuQrYFle
 AvFKB4G9Nh+7oyMAW+xtYAWlBkcbISA0yH3touAmsXi9wKt9xc0k89qILgkwRZo4wnKec0LlZNV
 jbe9jvbQPa5uubJ7CxHAraFtbaIFNNQ0PKF3U8cpaCJieEY1/wdAP3DgH/6Z86YXIT6XgUGmbGf
 zKq94MgUoIFR/ySGVrKk8=
X-Google-Smtp-Source: AGHT+IFdXO3naW5yJ+HbKMV5IS6jeFA7HB7J325a1M1NSWM9hLWX0tOuKoLNrZhFs47IsvBE80Bv9Q==
X-Received: by 2002:a05:600c:3511:b0:471:60c:1501 with SMTP id
 5b1f17b1804b1-471060c1576mr23190745e9.28.1760551311990; 
 Wed, 15 Oct 2025 11:01:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1284sm29982493f8f.45.2025.10.15.11.01.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 11:01:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 7/7] target/microblaze: Convert CPUMBState::res_addr field
 to uint32_t type
Date: Wed, 15 Oct 2025 20:01:15 +0200
Message-ID: <20251015180115.97493-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015180115.97493-1-philmd@linaro.org>
References: <20251015180115.97493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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


