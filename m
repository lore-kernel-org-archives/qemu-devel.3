Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F86CF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBPJ-000381-S8; Mon, 30 Sep 2024 04:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBP6-0002bh-SQ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:05:13 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBP4-0004Hg-M1
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:05:12 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so452246866b.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727683508; x=1728288308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5V3kOB6PMSOt7GvVRYTAhn4zZrY1jWMSTBtmM5O9vw=;
 b=cmx8PXj+TrH8L7f/gA/swJBGw77cZ1mk5Tw+YEHsHKofPIdY82ccDhdCs2i+OE/QcB
 ZRXGRuhN2JcRyS91511x7jULFSOJG2GTRmdoJhfTR7na7547MvIl+qYViORZw3LYIP6V
 M/6kN9t6nj0W7Lkjxmkj9nln1GZSx+/aptP+v2tTI68NHavzCEbDIOWAZhm9ti3qVy5g
 f8lnsrT3fsQkd+HYIXrSFN/AIaVKEjQK4DhS4ANZwaFc6yTHslZaaC/tk4V1LkL3QHed
 ux33y/nK0KlHgL9KKKwly/d+nbuw0DW/G3QKQ0IpUertTdKN4ds3lp6NLXlMgpkY/JO1
 hRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683508; x=1728288308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h5V3kOB6PMSOt7GvVRYTAhn4zZrY1jWMSTBtmM5O9vw=;
 b=ueznpnFVQm5bpjfFGEQ3diSDawu7ie2Fwg2emibrEoA5EZ/z7TiKVPziNKuwxalRTG
 RsVIlDVBAzHFDMC1KjGORaJ5tUoyTMimoV5zzQS/9qfNSJzVK5M1CmciVHHV75yjWBB/
 kvyid6AeFxSGTEPKJ9PXbdJGzurYqslD3HW3xyJqC/uXVq3aLC1jWU9qz74DBrun6RuQ
 Jh8eqp7/zxvCMm+cHARLRYHciB03/Y65TpmFJxXzUg/fDULZVn+N32AmoFZ7pe6fCaJq
 7HgMUO53LquyndT9xcXfSIIn10O0EXQvLIyjrB2qsr7O1TPz8abJYbJ+rLhnN7IRDfYx
 5/+Q==
X-Gm-Message-State: AOJu0Yyg6x5rp1SOBTbfddopmQ/BOKe7DotX+ht6oywdrD3RrZ857T10
 Wwiie3i8vkSjsVgcVDeI6msnH6yjaUiTMhhpjfxZAjMDA1vkM0voFmiOl4L+Dtf3vHXTp5GEslR
 ajx0=
X-Google-Smtp-Source: AGHT+IF9ceLg1Tk+l2rdJmvlOhYmg7G7ZqzHxY0PwujIuYTvs3nnaYA8IbnEtTruWsA0+LWvGrZZRQ==
X-Received: by 2002:a5d:6448:0:b0:37c:d162:8295 with SMTP id
 ffacd0b85a97d-37cd5aafa24mr6498931f8f.29.1727681737564; 
 Mon, 30 Sep 2024 00:35:37 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d331sm8359558f8f.10.2024.09.30.00.35.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:35:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 05/13] hw/mips: Add cpu_is_bigendian field to BlCpuCfg
 structure
Date: Mon, 30 Sep 2024 09:34:42 +0200
Message-ID: <20240930073450.33195-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add the BlCpuCfg::cpu_is_bigendian field, initialize it in
machine code. Bootloader API use the ld/st_endian_p() to
dispatch to target endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/bootloader.h |  1 +
 hw/mips/bootloader.c         | 10 +++++-----
 hw/mips/boston.c             |  2 +-
 hw/mips/fuloong2e.c          |  2 +-
 hw/mips/malta.c              |  2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/hw/mips/bootloader.h b/include/hw/mips/bootloader.h
index 744eb11d0e..ef778a38d0 100644
--- a/include/hw/mips/bootloader.h
+++ b/include/hw/mips/bootloader.h
@@ -13,6 +13,7 @@
 #include "exec/target_long.h"
 
 typedef struct bl_cpu_cfg {
+    bool cpu_is_bigendian;
 } BlCpuCfg;
 
 void bl_gen_jump_to(const BlCpuCfg *cfg, void **p, target_ulong jump_addr);
diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index ee1a1c4f20..258cc5d8c8 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -58,9 +58,9 @@ static void st_nm32_p(const BlCpuCfg *cfg, void **ptr, uint32_t insn)
 {
     uint16_t *p = *ptr;
 
-    stw_p(p, insn >> 16);
+    stw_endian_p(cfg->cpu_is_bigendian, p, insn >> 16);
     p++;
-    stw_p(p, insn >> 0);
+    stw_endian_p(cfg->cpu_is_bigendian, p, insn >> 0);
     p++;
 
     *ptr = p;
@@ -74,7 +74,7 @@ static void bl_gen_nop(const BlCpuCfg *cfg, void **ptr)
     } else {
         uint32_t *p = *ptr;
 
-        stl_p(p, 0);
+        stl_endian_p(cfg->cpu_is_bigendian, p, 0);
         p++;
         *ptr = p;
     }
@@ -95,7 +95,7 @@ static void bl_gen_r_type(const BlCpuCfg *cfg,
     insn = deposit32(insn, 6, 5, shift);
     insn = deposit32(insn, 0, 6, funct);
 
-    stl_p(p, insn);
+    stl_endian_p(cfg->cpu_is_bigendian, p, insn);
     p++;
 
     *ptr = p;
@@ -113,7 +113,7 @@ static void bl_gen_i_type(const BlCpuCfg *cfg,
     insn = deposit32(insn, 16, 5, rt);
     insn = deposit32(insn, 0, 16, imm);
 
-    stl_p(p, insn);
+    stl_endian_p(cfg->cpu_is_bigendian, p, insn);
     p++;
 
     *ptr = p;
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 8e210876e1..d4dd242d0d 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -325,7 +325,7 @@ type_init(boston_register_types)
 
 static void gen_firmware(void *p, hwaddr kernel_entry, hwaddr fdt_addr)
 {
-    const BlCpuCfg bl_cfg = { };
+    const BlCpuCfg bl_cfg = { .cpu_is_bigendian = TARGET_BIG_ENDIAN };
     uint64_t regaddr;
 
     /* Move CM GCRs */
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index a989637d3b..4fe5108845 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -165,7 +165,7 @@ static uint64_t load_kernel(MIPSCPU *cpu)
 static void write_bootloader(CPUMIPSState *env, uint8_t *base,
                              uint64_t kernel_addr)
 {
-    const BlCpuCfg bl_cfg = { };
+    const BlCpuCfg bl_cfg = { .cpu_is_bigendian = false };
     uint32_t *p;
 
     /* Small bootloader */
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index fc485cc884..6e73c896ff 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -624,7 +624,7 @@ static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
     static const char pci_pins_cfg[PCI_NUM_PINS] = {
         10, 10, 11, 11 /* PIIX IRQRC[A:D] */
     };
-    const BlCpuCfg bl_cfg = { };
+    const BlCpuCfg bl_cfg = { .cpu_is_bigendian = TARGET_BIG_ENDIAN };
 
     /* Bus endianness is always reversed */
 #if TARGET_BIG_ENDIAN
-- 
2.45.2


