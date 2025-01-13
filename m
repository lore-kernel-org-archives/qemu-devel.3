Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65804E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8dQ-0004p5-Gy; Sun, 12 Jan 2025 19:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dB-0004Zd-Mh
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dA-0000kk-5I
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:37 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso39862105e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729313; x=1737334113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoCXQwiSZHcZTwdJr/g1JL9VhUwkxRIR68QUTMcGTac=;
 b=TMILdDMPk2mOdAevYWKHZi6Z3ZkX5eHkoQXJMF6cVcEvNZDpVLIkYMLNRYy2T4dWoz
 SSjhvbz+0fxdEz/HREHLJCIC8XPf1ov1M6kG3BeocVdfl9o7DKV94D31tVG7BAOq75co
 HZvGxfc11r03J6k3uWhAUmfflE71K4BEWFE8zXkUaq55Z5eRpDGXjb4ekKb57aOxuD2q
 vRY+vLvXUKUeV37KwiE2rqZsKzwoq/09UKRKSA8PGov/kvJXisBT75GSp/LtwevAoT07
 vTn7smHJUgk5HGXPrFrdXSxynvV4PRhG/9LCyY2tvJ7TgPtKqwj2dE9IdR2C5k+gbPpR
 lbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729313; x=1737334113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qoCXQwiSZHcZTwdJr/g1JL9VhUwkxRIR68QUTMcGTac=;
 b=je2xgo4y0twN241s6sglrlVkfiKTG3EhiMjyvKepaBvbFdkC3kvKC9p0qZYPqFH8Eg
 eR8Vi8HKjZbkRWvEr9EOXplBWqZwVGo3XL3CjRyCPaMlYYTerRXbB2u9a8hez+RrNwMK
 wqcKgx2sz+xYDT0RcXsDBNBs3hcbVu1W1oVD1Qy/1rhVt4mwwXjpFC+Ktf+QDVXlss29
 HG/lozc+27SPorMNfm+hCv6vdkClvCSatupQ+qIFbn4bzpwDXfEFwOgLUFC9ldeH+k9s
 nvAYxCeYMWbfNz+lK6D/1e9l0yOgbUupgo3bPgy3AGrnA+X2Vrai8b5wumzhaEGuMZ6S
 uIgw==
X-Gm-Message-State: AOJu0YxjjHY/hFzmyMhq+pSyJjbwUc5uWWGZp28/Ss/1LYTupky5mzmF
 z9TjIXpOXAOYouDa5DrwO3mIRpj2BMcTvvIMQJOCjkipVlOOX08o7xoaLC1a5UgAi8VZfAIQuR2
 KFSE=
X-Gm-Gg: ASbGnctGdFqaSifeEPBmeDZKr+U5NyVs0c+VeiQx4f1p1y7iyxpwNhQJzQZ1cv66GW4
 6vojPwU01lWktGwWvm2s6Y9NRw8BrP/+x8Yv9YMXZEUAyq2j1OaNWZst7SgkrIfliFm4dXhRclo
 +/CgCQAKEAW8vXZOW38EbJ83jxLwtb/hHjYqaXeIOecNxeq0lnzWTqZweWY6IjA3KZFP/ct27XM
 nh6jUMj6XNe6P4aJrVgGr9ylyYUmGvNQkv9GDmwNa8Pgxuhlr/6OOHsGvQxz32y/UNM9OHUx3+b
 PLzR7JXpX8Ue94cMorkI0ozRzzOcYkk=
X-Google-Smtp-Source: AGHT+IGiG+AJlNOJFHnhARXFEvWsYcXfdEdWu/AR5EMlPmeQjlNQAPihA833yRDHRJEaNK8SHI6fjA==
X-Received: by 2002:a5d:59ab:0:b0:386:37f5:99f6 with SMTP id
 ffacd0b85a97d-38a8733bf6dmr17067497f8f.53.1736729313372; 
 Sun, 12 Jan 2025 16:48:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d154sm11057172f8f.10.2025.01.12.16.48.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:48:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 07/23] hw/mips/bootloader: Propagate CPU env to bl_gen_jalr()
Date: Mon, 13 Jan 2025 01:47:32 +0100
Message-ID: <20250113004748.41658-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
declared bl_gen_jalr() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 7cf1f01d225..9f35b23653a 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -128,9 +128,9 @@ static void bl_gen_dsll(const CPUMIPSState *env, void **p,
     }
 }
 
-static void bl_gen_jalr(void **p, bl_reg rs)
+static void bl_gen_jalr(const CPUMIPSState *env, void **p, bl_reg rs)
 {
-    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(env, ISA_NANOMIPS32)) {
         uint32_t insn = 0;
 
         insn = deposit32(insn, 26, 6, 0b010010); /* JALRC */
@@ -247,7 +247,7 @@ static void bl_gen_load_ulong(void **p, bl_reg rt, target_ulong imm)
 void bl_gen_jump_to(void **p, target_ulong jump_addr)
 {
     bl_gen_load_ulong(p, BL_REG_T9, jump_addr);
-    bl_gen_jalr(p, BL_REG_T9);
+    bl_gen_jalr(&MIPS_CPU(first_cpu)->env, p, BL_REG_T9);
     bl_gen_nop(&MIPS_CPU(first_cpu)->env, p); /* delay slot */
 }
 
-- 
2.47.1


