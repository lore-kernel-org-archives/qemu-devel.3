Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D645BC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQYa-0007Ut-SZ; Mon, 13 Jan 2025 14:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYI-0006Tm-GY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:51 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYG-0007W6-Mp
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43626213fffso35173935e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798203; x=1737403003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FqRH3YIN+zJIf0SKXmNG5cYuASAzw080yXp4y743Edg=;
 b=R8vnZS0aw6vVv2XxG4Eprb5LFVA7+KMQSeEWTjpqzgFP8+2RH7U/4Du4OSzH7v5JJw
 +HXyPsFgKLE2tmsRt1Im46aLhy7fQ9sWAgJl/TaRjU0JBSrI+DQsd8W1C6bBKgDFJh44
 WtcFjjg8dVIZlMcOvhoFC0q2iwxqJ4XDgWUZi9ZdHcwNS7k/Hz4bninbsHcH0/ZfT6h6
 hUPPGjCbXkvajfaAwqv2ywVObm0a5ZfVVbqzTBV2MdUIVDTF9qlv14yz4NDRmmJEwpj0
 XGgUY8oHVo+TUW50NwXmCQMi+/qW1LKogXLtASW4uTs2H3RMsZdxetHvkJv1ISjuD5mP
 M8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798203; x=1737403003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FqRH3YIN+zJIf0SKXmNG5cYuASAzw080yXp4y743Edg=;
 b=rGhzDeQWaQWmxEkilIvZe+y18qjWgGopNfH6YuAXXpnbFRAu17B/0Vc9INzdFsfecS
 M9WO5qipqjk2uLn8ZdD9v2s89/dVCuUgFh4KGgfMcJAHnwiHrt1Y/vw+O/O+jSyxeZRw
 eQASFLecC6RzyTkrqqK3T9T5StuxQb7R/uP857G8O3f5O9ClQbmRVhQh46K26e9E6N71
 BcS8LMykXb37j29/bVp7tap8u3LoZhAlNLMB3Dl4G3B+Rv/tco3HhzzYS1kYRdHfrNVm
 wl9tZVdt6LF9l4WgHbwEKeyxqC5DBqwMWr8c98gEhmwFdvIz062GPhbABmCzAW5H48ga
 9xCg==
X-Gm-Message-State: AOJu0Yy9BaeiwdXdQH75c5X5783IWZ+xDPWjq8lDn7eDqfxenuxD9Gvl
 T66PxnqBvOZQIQp8rQoSOxQN/g651RAQ/I+pxb9OTv152rMwN8jytmpIE8lsU0wg78KEVADX8SM
 Ea/0=
X-Gm-Gg: ASbGnctblrYO8Vgrz2oN4V33sNo+2b4HAVJzisfhYvHd1cChFgXsRrkQvdnKwwpAvjl
 P044ILdLMF4/1n2QP2P+CCTm9IYuefIK7KdjAXhkuXaWQ3VDWBkZNMt0zSaugGilQEPlh+WZSmr
 Wxkr6Vzi9T5KLMhwaXzR/59rvv143WAOTxmDAL+pPe6uIVbKx6QCPIqaDXJxAWB7rhQuNXscVS0
 ikk5AJD+QwldskjVW+RvMkLI0I98TH3680Kqxh2pGlCxBW2/Wi3TPDuRLqJkRqNFE1MWHYQsJkU
 gkKKkL5yGYw5Y8+MF4KaNuo6V8Iq3fE=
X-Google-Smtp-Source: AGHT+IGM3+c/7mvmX5G8SlMNiKJpdPu7kj2W7wo9TN1QN/Q/+5T5X7qrRIfU5fla9Wy2I/amzTICKQ==
X-Received: by 2002:a5d:584b:0:b0:385:fa26:f0b5 with SMTP id
 ffacd0b85a97d-38a8b0f0b40mr13851108f8f.20.1736798203004; 
 Mon, 13 Jan 2025 11:56:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8299sm12997724f8f.74.2025.01.13.11.56.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 15/19] hw/mips/bootloader: Propagate CPU env to
 bl_gen_jalr()
Date: Mon, 13 Jan 2025 20:55:21 +0100
Message-ID: <20250113195525.57150-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
 hw/mips/bootloader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 288dccce473..a0fc840e89f 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -127,7 +127,7 @@ static void bl_gen_dsll(void **p, bl_reg rd, bl_reg rt, uint8_t sa)
     }
 }
 
-static void bl_gen_jalr(void **p, bl_reg rs)
+static void bl_gen_jalr(const CPUMIPSState *env, void **p, bl_reg rs)
 {
     if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
         uint32_t insn = 0;
@@ -253,7 +253,7 @@ void bl_gen_jump_to(const MIPSCPU *cpu, void **p, target_ulong jump_addr)
     const CPUMIPSState *env = &cpu->env;
 
     bl_gen_load_ulong(env, p, BL_REG_T9, jump_addr);
-    bl_gen_jalr(p, BL_REG_T9);
+    bl_gen_jalr(env, p, BL_REG_T9);
     bl_gen_nop(p); /* delay slot */
 }
 
-- 
2.47.1


