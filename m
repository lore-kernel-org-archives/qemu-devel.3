Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB12E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8dZ-000589-Qu; Sun, 12 Jan 2025 19:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dX-00055N-77
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:59 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dV-0000nv-Km
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361c705434so26496375e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729336; x=1737334136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjcLIqHjS0KwZ5g9pteWJiKRnJ/jUR3zkxQLD75pUx0=;
 b=o0LWr3Jg4649Q9Smymm2j50VP3BAzSPJ4OiVIbmkv9S10oWM5/GxOnXBapyl4yRpW3
 gEIykz+WibDANH02BW4Ed0ShKoD2thI3nMMMINGQdFp6z6ESpryj/j5U+nDS2ROxN8Zv
 00nYh8EYJPu0rc9J9ZESu4ourjaT36p2+vSKGj66Fco73zitJ0DzMumOiuyD2DJm2Rdk
 ve5+nttc2nZRoD7gBvsF0TOYHoIt1YoTTFKQ4F8hp7XVmROauR0KiLhOyNlqYlhUAKEU
 jxIkR1RhgoE3XpkaPYDYUu9tMKwGTYzMHGuH3zQUpaFaxdZ2phRWBIYHzfVr1uzRY9yg
 zFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729336; x=1737334136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjcLIqHjS0KwZ5g9pteWJiKRnJ/jUR3zkxQLD75pUx0=;
 b=aXFK1OuX3DnE5HHI0JXPAyABaB25ibDskS+YDx1RdDXSQbjOtAcSLOcSx3+5dLQZEG
 zNw4HLm42beIbMfTlzdSsqZLm2QWRO+yc6FQ1DeOqW0pTbU+B1MhilgyXRoz9wAZK9Tn
 cdGz6XPS3VZpKCCWObihZH7OKGwEIA4q2juJE2ltfM47TGO+0BCueinhwm148IqUXKoK
 wmPyUmukphJyaEKs+Ck7SGCIdK/j7b4DnH3XPjbMpGyz9QiXo7xE6nSElk9gImP/ny2X
 PwHAI7i8bqh4d0xcn+9LJWjGSvk0ErPPaPDCzenSEYh4dYwpEH7CUdHq0h3wmEPLtmOt
 Qyxw==
X-Gm-Message-State: AOJu0Yyir5Kju8vGQgZsqppK+EVmjnhnIjtgHZyk5a8xH97DE1XcAcS2
 4h8TxAO7EkeY0Q9kLSg+ctfhQVF9NVU+F1Vs/rx5klWoib9X4ycNK1XqLV8dk73CIrUIkLTs8CR
 ZtrI=
X-Gm-Gg: ASbGnctZWj9DTy7E3NIx4UvP6ApmntKXgo6hGgh6fGZ/GcDh18Q+4+v3oJcVebIxZuM
 Ick5T5HlakS4MTLgv5BTbQrbudXI+tM1vsfbVHlRPbLs2xpVeapvtwN0oznxw6DMdTuvf+EW8VQ
 EWIgIBA0FIJj3pqNjQR+89OIjugPMPL43fzYnEDU2agQTCgTZcxHXurdrrfPaLoVznjSTAy0UU0
 4kZTBzHAg5UWDyiPEyw+1EBYXSIjifxlKCC5f5e3INkpxvEqQ0KtfvAEIuHHcupbRpAICI2U3ic
 aMRsUVWZXcyU877Vs/f28qvkCP8YJm8=
X-Google-Smtp-Source: AGHT+IEzu6liPF/9kJtzdTg+6OiWpOo8BgsLsMexz6lfcKMo3PtZ3yiB7+0Miyq5B8+4u3hyzqs/+g==
X-Received: by 2002:a5d:59ab:0:b0:385:df6b:7ef6 with SMTP id
 ffacd0b85a97d-38a873579a8mr17602393f8f.51.1736729335848; 
 Sun, 12 Jan 2025 16:48:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38bd0dsm10735862f8f.45.2025.01.12.16.48.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:48:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 11/23] hw/mips/bootloader: Propagate CPU env to bl_gen_dli()
Date: Mon, 13 Jan 2025 01:47:36 +0100
Message-ID: <20250113004748.41658-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
declared bl_gen_dli() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 32811e48cdd..95ee59f33c9 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -228,19 +228,20 @@ static void bl_gen_li(const CPUMIPSState *env, void **p,
     }
 }
 
-static void bl_gen_dli(void **p, bl_reg rt, uint64_t imm)
+static void bl_gen_dli(const CPUMIPSState *env, void **p,
+                       bl_reg rt, uint64_t imm)
 {
-    bl_gen_li(&MIPS_CPU(first_cpu)->env, p, rt, extract64(imm, 32, 32));
-    bl_gen_dsll(&MIPS_CPU(first_cpu)->env, p, rt, rt, 16);
+    bl_gen_li(env, p, rt, extract64(imm, 32, 32));
+    bl_gen_dsll(env, p, rt, rt, 16);
     bl_gen_ori(p, rt, rt, extract64(imm, 16, 16));
-    bl_gen_dsll(&MIPS_CPU(first_cpu)->env, p, rt, rt, 16);
+    bl_gen_dsll(env, p, rt, rt, 16);
     bl_gen_ori(p, rt, rt, extract64(imm, 0, 16));
 }
 
 static void bl_gen_load_ulong(void **p, bl_reg rt, target_ulong imm)
 {
     if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
-        bl_gen_dli(p, rt, imm); /* 64bit */
+        bl_gen_dli(&MIPS_CPU(first_cpu)->env, p, rt, imm); /* 64bit */
     } else {
         bl_gen_li(&MIPS_CPU(first_cpu)->env, p, rt, imm); /* 32bit */
     }
@@ -301,7 +302,7 @@ void bl_gen_write_u32(void **p, target_ulong addr, uint32_t val)
 
 void bl_gen_write_u64(void **p, target_ulong addr, uint64_t val)
 {
-    bl_gen_dli(p, BL_REG_K0, val);
+    bl_gen_dli(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, val);
     bl_gen_load_ulong(p, BL_REG_K1, addr);
     bl_gen_sd(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
-- 
2.47.1


