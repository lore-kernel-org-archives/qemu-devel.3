Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E30E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8di-0005Uk-VU; Sun, 12 Jan 2025 19:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dc-0005Pf-U6
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:05 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8db-0000ox-3D
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436249df846so25760475e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729341; x=1737334141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxBO2LM7TvF6Z9ULUfgrFZWB9JLE9hlbq/zhhRtO/AA=;
 b=KeEnAnvTJtnE0VCP/COko3HRcNzVTGcopuRsfi6MIxO4X/Atn0IkVOtXHLk9obIYWA
 +SK0asXgmFMDx01bQJGtCRDeosKZJQz7kO4EFr/ZJMJKSNs9MQAJ1FschRWJEUobH2NF
 ljtSRpEr5UAn2ZjDR1YQrXc+1QT1yasgtXdNzIJ2tgBxZ3L2h+FK+ijASZ5SVoBs2YjA
 eU6Ifm1rXL8oAdS9oGi/TlM6OXmjTstGg1xCCMvqHKrb6rTCmWO0luseMvwd3dpIcJp0
 o3hZo2/HZDo64PPIAM043Gxy1RcTI7D5sV7dXhm5fb3EHdVy4bvCzbkL2zLBuhDH4AVq
 9j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729341; x=1737334141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxBO2LM7TvF6Z9ULUfgrFZWB9JLE9hlbq/zhhRtO/AA=;
 b=ihsAaM5tiaIbJ0gmZhQvcq1heHZmmm7ucc6gjI0iOFerjbrN/59Na5YYz2jDZ4h/Wd
 +pSHyXXG8Zbxa7+ujYx77Y4ydxPBbivSg9SycBgAroASFMe4IgPajjD+n/W/maeVzDgp
 3W+aw9MlTCbp8cjcdekNfWsTny5qddPnYmuHi/xRreCjq/kb2he4SsMzAFJBlMxpF2t3
 2xoieD7svE6j740MwG467JWXTwli3Y9dv/cyNY6GZtHgXzegiUrod01m1nmEbgQViSY3
 O6k8fYw8FXIZdETsS3UAFrnaI8srHEArpkV6XF6Hy1ys7eMx21haPVGVsn5wu+BhlQ7n
 NGIg==
X-Gm-Message-State: AOJu0YzBqwejtMh8JY3sL9VaR5jZ8eRuI/Zal0gMH7eBigO50YRms8n0
 5QyIZrZsJ6ZSB/8Y/bgLmfX5zYGhgTvzxdXALOETZgX67O+2pv5z5RKN2Fkexg+5I3tvYu9C+XG
 w3CI=
X-Gm-Gg: ASbGncseEPnJwA3HmjtbqGGuLwb9WZ0Gdz4ABJ4LVLw/Qg4iRn8kNSOm+HMa/Q9rYFS
 w5MvUks1b/Funnr0Xnl8RMhkbIiR+rbStgcvEibpyXPvXdQ+aZ7wH1tZu3xNId2hNgWhKLzSlgX
 5dx8HCVA1gw4nPugGi8V7Us6nC/fp8YkxIdHMuebzAK9UksfNHTjDLV0Dn7k/1s/qaD3pyI/XVR
 MdtkABvrRJY8w7aEnFL/ILiZ0z0ZQCUOo+r5gUXAeDXM5wPqItslJA1O/TDvdbwimR0a5FShK3W
 Ijww4Knrm016ZGG/TuSjI0rYpdPY5Lo=
X-Google-Smtp-Source: AGHT+IFfb7Y4vwnu7llG1gfOzg61+pLifvKt6muZDNvjYcX/VXz96bO6S6AduDsbpwsnvWdO5Hyl2A==
X-Received: by 2002:a05:600c:3b99:b0:434:f925:f5c9 with SMTP id
 5b1f17b1804b1-436e266dfe9mr148100005e9.6.1736729341154; 
 Sun, 12 Jan 2025 16:49:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc08eesm162988605e9.10.2025.01.12.16.48.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 12/23] hw/mips/bootloader: Propagate CPU env to
 bl_gen_load_ulong()
Date: Mon, 13 Jan 2025 01:47:37 +0100
Message-ID: <20250113004748.41658-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Propagate the target specific CPU env to the locally
declared bl_gen_load_ulong() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 95ee59f33c9..e29eb5e92f3 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -238,19 +238,20 @@ static void bl_gen_dli(const CPUMIPSState *env, void **p,
     bl_gen_ori(p, rt, rt, extract64(imm, 0, 16));
 }
 
-static void bl_gen_load_ulong(void **p, bl_reg rt, target_ulong imm)
+static void bl_gen_load_ulong(const CPUMIPSState *env, void **p,
+                              bl_reg rt, target_ulong imm)
 {
-    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
-        bl_gen_dli(&MIPS_CPU(first_cpu)->env, p, rt, imm); /* 64bit */
+    if (bootcpu_supports_isa(env, ISA_MIPS3)) {
+        bl_gen_dli(env, p, rt, imm); /* 64bit */
     } else {
-        bl_gen_li(&MIPS_CPU(first_cpu)->env, p, rt, imm); /* 32bit */
+        bl_gen_li(env, p, rt, imm); /* 32bit */
     }
 }
 
 /* Helpers */
 void bl_gen_jump_to(void **p, target_ulong jump_addr)
 {
-    bl_gen_load_ulong(p, BL_REG_T9, jump_addr);
+    bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_T9, jump_addr);
     bl_gen_jalr(&MIPS_CPU(first_cpu)->env, p, BL_REG_T9);
     bl_gen_nop(&MIPS_CPU(first_cpu)->env, p); /* delay slot */
 }
@@ -264,19 +265,19 @@ void bl_gen_jump_kernel(void **p,
                         target_ulong kernel_addr)
 {
     if (set_sp) {
-        bl_gen_load_ulong(p, BL_REG_SP, sp);
+        bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_SP, sp);
     }
     if (set_a0) {
-        bl_gen_load_ulong(p, BL_REG_A0, a0);
+        bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_A0, a0);
     }
     if (set_a1) {
-        bl_gen_load_ulong(p, BL_REG_A1, a1);
+        bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_A1, a1);
     }
     if (set_a2) {
-        bl_gen_load_ulong(p, BL_REG_A2, a2);
+        bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_A2, a2);
     }
     if (set_a3) {
-        bl_gen_load_ulong(p, BL_REG_A3, a3);
+        bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_A3, a3);
     }
 
     bl_gen_jump_to(p, kernel_addr);
@@ -284,8 +285,8 @@ void bl_gen_jump_kernel(void **p,
 
 void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
 {
-    bl_gen_load_ulong(p, BL_REG_K0, val);
-    bl_gen_load_ulong(p, BL_REG_K1, addr);
+    bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, val);
+    bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_K1, addr);
     if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
         bl_gen_sd(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
     } else {
@@ -296,13 +297,13 @@ void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
 void bl_gen_write_u32(void **p, target_ulong addr, uint32_t val)
 {
     bl_gen_li(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, val);
-    bl_gen_load_ulong(p, BL_REG_K1, addr);
+    bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_K1, addr);
     bl_gen_sw(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
 
 void bl_gen_write_u64(void **p, target_ulong addr, uint64_t val)
 {
     bl_gen_dli(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, val);
-    bl_gen_load_ulong(p, BL_REG_K1, addr);
+    bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_K1, addr);
     bl_gen_sd(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
-- 
2.47.1


