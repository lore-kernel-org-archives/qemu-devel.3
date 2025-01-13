Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6BBC02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQYN-0006RV-Uu; Mon, 13 Jan 2025 14:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXz-0006HI-0F
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:30 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXx-0007UP-Bb
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:26 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361c705434so33966135e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798183; x=1737402983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KU/KR+rn7RTb6ySlzmeDHd0Rdpb697i1vtawNm8I+sc=;
 b=beDQx5cBcr/mFRk12BA9edIqWaLNWrlUdLu44wn+G6sHJRK6kT+LG783vQQevXhjSo
 DD2fr0kqYzVvAh1JMNHbjWW1ig/OPNB8ucIbfCbJd8QQ6ypu7q70TmMRXpwzz9CB32BV
 WCEJ5Zs7wbZPVMQ7lLpilm6TjQcvmDXzL9OnthJfg5VZMDsYEIOKH9Lct9bUHL5SFPR5
 /Ts2Y3nI2spQrxkIlKlGJxcwpHlnLHQyOdYkSpDijY+/ZJV9LVj+HsZzBHxWc8agOnjp
 PwVLKQZGjI/4VSeSMZ89CdTo5GaM91NYB7N8DJVm7YPb+XBT3AHAbQCKu2KT7wcoxGmf
 f/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798183; x=1737402983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KU/KR+rn7RTb6ySlzmeDHd0Rdpb697i1vtawNm8I+sc=;
 b=C2v1AdpfIWVmFQqBbenGEoBJLhj1H8EjKun1Qu4GvX631mFt8mClEmwttK6zV8P77g
 HeeF/rdx7fPpum1Sch+OuZkfCZT0n8hh9yLLYYdHiDN0YnR/+Z5+uYneo4aKjFABpHV0
 Eka+lKoYjntPb2nmy4uZbE+yUYZaIJC1b4yI22foOj/MA16jm/9CdBD1C65zl0Em+t/N
 em31Rv9EJfij9xoxW/pJoz9Wpyxj3VhlDjV2qYZm2MfzWYJBUmIQl2/z1Qz589aEhFaW
 Dfh8hhauwwxoGoaC8DnBhMPxuYmScUJNCfoXLISNUelVxI9M0OgYRowE0UgebL09y3aV
 9IbA==
X-Gm-Message-State: AOJu0YyrA9G/Xuwqy/wEIJWy8uNsKeOtNEXgfWrEc396bCBx0KLuvTfg
 0HUkPveetd8GRzHmEGtBcgibfMxbPnjemtmtNihxFHZhUGjpiutjpynYm1W+FbF4eqJR8paOA0G
 OL+U=
X-Gm-Gg: ASbGncvi/crjHeIIJfhbKnGa4YMCCL4XsKPolbYj74La98OR2mtSUC+LsZevnfwEYxJ
 Z2Xk7Kl9uGpPBXKKBP4CO2DwJSv2wsvcsiylchDPBazr353Q57cnuQAKTUIgK9Hp+1bqJevrBKH
 pqTKlmPfsGTs/h3Ol95BLd8k4fxPvuNzdtHsPPNeUMLWJYzzGvgZV5/7R/Qhs1VLzrfLfDKQHh6
 +W9oKR5WVXBtDPxj6rLbGV4AbgSmvqaK22VE5NTVB3iAjhZTmE/zKL0aL1Re6Kyocy0p6+avKuG
 jelwTZ764lPbJbOawksdx3BuYmsC5Qk=
X-Google-Smtp-Source: AGHT+IEX8qU1ZCl5fImdkihlhIhl0VfQoM5TKjgarLyT4KxJ3hNmdvf3xDfCyb8v6eePsKucWg2S8Q==
X-Received: by 2002:a05:600c:5848:b0:436:f3f6:9582 with SMTP id
 5b1f17b1804b1-436f3f695dfmr93982305e9.8.1736798183417; 
 Mon, 13 Jan 2025 11:56:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436ed48f4b2sm140328005e9.24.2025.01.13.11.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 11/19] hw/mips/bootloader: Propagate CPU to bl_gen_jump_[to,
 kernel]()
Date: Mon, 13 Jan 2025 20:55:17 +0100
Message-ID: <20250113195525.57150-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Propagate the target agnostic CPU pointer to the publicly
declared bl_gen_jump_to() and bl_gen_jump_kernel() functions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/bootloader.h | 6 ++++--
 hw/mips/bootloader.c         | 6 +++---
 hw/mips/boston.c             | 2 +-
 hw/mips/fuloong2e.c          | 2 +-
 hw/mips/malta.c              | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/mips/bootloader.h b/include/hw/mips/bootloader.h
index bc54ea8c7fb..173410f54ea 100644
--- a/include/hw/mips/bootloader.h
+++ b/include/hw/mips/bootloader.h
@@ -15,14 +15,16 @@
 /**
  * bl_gen_jump_to: Generate bootloader code to jump to an address
  *
+ * @cpu: The MIPS CPU which will run the bootloader code
  * @ptr: Pointer to buffer where to write the bootloader code
  * @jump_addr: Address to jump to
  */
-void bl_gen_jump_to(void **ptr, target_ulong jump_addr);
+void bl_gen_jump_to(const MIPSCPU *cpu, void **ptr, target_ulong jump_addr);
 
 /**
  * bl_gen_jump_kernel: Generate bootloader code to jump to a Linux kernel
  *
+ * @cpu: The MIPS CPU which will run the bootloader code
  * @ptr: Pointer to buffer where to write the bootloader code
  * @set_sp: Whether to set $sp register
  * @set_a0: Whether to set $a0 register
@@ -36,7 +38,7 @@ void bl_gen_jump_to(void **ptr, target_ulong jump_addr);
  * @a3: Value to set $a0 to if @set_a3 is set
  * @kernel_addr: Start address of the kernel to jump to
  */
-void bl_gen_jump_kernel(void **ptr,
+void bl_gen_jump_kernel(const MIPSCPU *cpu, void **ptr,
                         bool set_sp, target_ulong sp,
                         bool set_a0, target_ulong a0,
                         bool set_a1, target_ulong a1,
diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 7db3bf7511f..9b074d9903b 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -243,14 +243,14 @@ static void bl_gen_load_ulong(void **p, bl_reg rt, target_ulong imm)
 }
 
 /* Helpers */
-void bl_gen_jump_to(void **p, target_ulong jump_addr)
+void bl_gen_jump_to(const MIPSCPU *cpu, void **p, target_ulong jump_addr)
 {
     bl_gen_load_ulong(p, BL_REG_T9, jump_addr);
     bl_gen_jalr(p, BL_REG_T9);
     bl_gen_nop(p); /* delay slot */
 }
 
-void bl_gen_jump_kernel(void **p,
+void bl_gen_jump_kernel(const MIPSCPU *cpu, void **p,
                         bool set_sp, target_ulong sp,
                         bool set_a0, target_ulong a0,
                         bool set_a1, target_ulong a1,
@@ -274,7 +274,7 @@ void bl_gen_jump_kernel(void **p,
         bl_gen_load_ulong(p, BL_REG_A3, a3);
     }
 
-    bl_gen_jump_to(p, kernel_addr);
+    bl_gen_jump_to(cpu, p, kernel_addr);
 }
 
 void bl_gen_write_ulong(const MIPSCPU *cpu, void **p,
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index b646c104df7..f2c0e335e73 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -353,7 +353,7 @@ static void gen_firmware(const MIPSCPU *cpu, void *p,
      * a2/$6 = 0
      * a3/$7 = 0
      */
-    bl_gen_jump_kernel(&p,
+    bl_gen_jump_kernel(cpu, &p,
                        true, 0, true, (int32_t)-2,
                        true, fdt_addr, true, 0, true, 0,
                        kernel_entry);
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index c4080a8a6e3..1e55adacdd2 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -179,7 +179,7 @@ static void write_bootloader(const MIPSCPU *cpu, uint8_t *base,
     /* Second part of the bootloader */
     p = (uint32_t *)(base + 0x040);
 
-    bl_gen_jump_kernel((void **)&p,
+    bl_gen_jump_kernel(cpu, (void **)&p,
                        true, ENVP_VADDR - 64,
                        true, 2, true, ENVP_VADDR,
                        true, ENVP_VADDR + 8,
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 9bc3fc9da3e..f96a78d2939 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -681,7 +681,7 @@ static void bl_setup_gt64120_jump_kernel(MaltaState *s, void **p,
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0xcfc),
                      tswap32(ldl_be_p(pci_pins_cfg)));
 
-    bl_gen_jump_kernel(p,
+    bl_gen_jump_kernel(cpu, p,
                        true, ENVP_VADDR - 64,
                        /*
                         * If semihosting is used, arguments have already
-- 
2.47.1


