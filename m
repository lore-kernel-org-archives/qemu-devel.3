Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08326C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6Sl-0007lI-8k; Thu, 06 Feb 2025 13:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6Sj-0007hb-Ez
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:18:53 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6Sh-0006pc-Jx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:18:53 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so8950705e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738865929; x=1739470729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nF0gOL375kOEqgBWe6BH6Zaiz34mrVikUB/O+vzSeyU=;
 b=lJyTZgulPhZDU/yoF6OKY0U02otJMjDLM53Tc7ch0Qx6ett9hVidjMEYrNrg7J6JUw
 Xs0YSBXvtAsGs4Jvu6XC/LdwrSA+OMpwsHlMf8ho3lUr1b2P2vgElCfMIRNYmDWmkROY
 Lreu1NhSqSjZsI1kq93q/KXm2iwdyOWIIJ580UFvbpJJhn9086uMljg9zFBOMM3ReEGA
 pm+YAG7OFMMBzTISb4pJSpLHC+MQU4wKLH3JeLu6AXBF2Sb4FtVuO0qIqxNpR+npLl0b
 L5aqSYg9XxQsieILhGj8+Tl3QshJueoUMDfpdAA2Daxez2ccwNiLIqbEFFqEfkAiCDkD
 hfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738865929; x=1739470729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nF0gOL375kOEqgBWe6BH6Zaiz34mrVikUB/O+vzSeyU=;
 b=dv0Gq0CtXWXbXdbncLUZVaVvkTpTAsNhPGRAEEgnnSOteC3TJIWXxnugbjJHzxpR6e
 IPEcvNkk4rByl2wicTLJ6ForENjRAwUzC8dlIG7pO7ogrZa+GVTPDTThuSOTnbVbSR4Z
 AZnkQMUYTSfxDaZhkQ2MR0c75A1S8k364h2OHuqo4vH6xPtauwV1pKPCOK4O2NYcNtee
 DafcJE+XOmFvW8DXh/9DZzFD54+6xxx7szj67Ye3M8l2+Km4tPT1Gp1DiArEr0B4tv6G
 43TNpyWlRqTU/ko6zgMWX3HrHNOS/cuSp9JIkWl84NPLiAhwChf+pvHT8x5QA2/dflx3
 dnnw==
X-Gm-Message-State: AOJu0Ywdt6ScsTujgsfZcsNQGIVWoeSHDLkLKIBw8Ou/XSDq9tDTa2zo
 qSQazsi6DGZqtCck2tSKeRfBgSTEanimSgCRg508tuiut0ixc3uZPjIVo9fbxSCerf9uxUfx1fB
 MgwE=
X-Gm-Gg: ASbGncsAQdxeuDq9yG9iM+HKswwvOV1u9H5//YtGJ0lor5hgJnjf9Nif45+nyUM1gTd
 5FZn/Sn5xGYs+nzNJ/i8gU5kkd1+QuORb0C71VLjibO2bWuJwJhJOEQMmRFINyHj59MEACafPh6
 fcL2RQ84C77OlLax6zgUfQSFTcIalIsyKrFkNmQ4EygvaC4QtafCfq9y6V0v9eq6tKBq/0OtuP7
 pkLxFS9tQ0vEIj9k18/MIxOle8iUNVVKoCzjCWwDF71ovCvY/0O1NOnLzliz2vIrG/jt5MeblZ1
 7RhMe5kYp9blapUjjm328Gr5E4AF0SST+0xhSBv3fNoFWwNtIE0QbF6I9mS8SHg72A==
X-Google-Smtp-Source: AGHT+IEr6mKVF/5i7XI9bPvijw6JSF2ZIebTXVKbzR1YpFeo3XtTLng05fB/qgrsOlZD9l4eG5PdLQ==
X-Received: by 2002:a05:600c:1c0e:b0:434:fdf3:2c26 with SMTP id
 5b1f17b1804b1-439249a8b60mr3401665e9.19.1738865929487; 
 Thu, 06 Feb 2025 10:18:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d40csm62272665e9.9.2025.02.06.10.18.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 10:18:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] hw/riscv/boot: Use 'hwaddr' type for firmware addresses
Date: Thu,  6 Feb 2025 19:18:24 +0100
Message-ID: <20250206181827.41557-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206181827.41557-1-philmd@linaro.org>
References: <20250206181827.41557-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Some places already use the hwaddr type. Use it all over
the API allows it to be target agnostic. Use cpu_env() in
riscv_plic_hart_config_string() to shorten the access.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/riscv/boot.h         | 21 ++++++++++-----------
 include/hw/riscv/boot_opensbi.h | 14 +++++++-------
 hw/riscv/boot.c                 | 28 ++++++++++++++--------------
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 7d59b2e6c63..1f66432eaed 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -20,7 +20,6 @@
 #ifndef RISCV_BOOT_H
 #define RISCV_BOOT_H
 
-#include "exec/cpu-defs.h"
 #include "hw/loader.h"
 #include "hw/riscv/riscv_hart.h"
 
@@ -43,21 +42,21 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
 char *riscv_plic_hart_config_string(int hart_count);
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
-target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-                                          target_ulong firmware_end_addr);
-target_ulong riscv_find_and_load_firmware(MachineState *machine,
-                                          const char *default_machine_firmware,
-                                          hwaddr *firmware_load_addr,
-                                          symbol_fn_t sym_cb);
+hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+                                    hwaddr firmware_end_addr);
+hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    const char *default_machine_firmware,
+                                    hwaddr *firmware_load_addr,
+                                    symbol_fn_t sym_cb);
 const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
 char *riscv_find_firmware(const char *firmware_filename,
                           const char *default_machine_firmware);
-target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr *firmware_load_addr,
-                                 symbol_fn_t sym_cb);
+hwaddr riscv_load_firmware(const char *firmware_filename,
+                           hwaddr *firmware_load_addr,
+                           symbol_fn_t sym_cb);
 void riscv_load_kernel(MachineState *machine,
                        RISCVBootInfo *info,
-                       target_ulong kernel_start_addr,
+                       hwaddr kernel_start_addr,
                        bool load_initrd,
                        symbol_fn_t sym_cb);
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
diff --git a/include/hw/riscv/boot_opensbi.h b/include/hw/riscv/boot_opensbi.h
index 18664a174b5..e6998c668ad 100644
--- a/include/hw/riscv/boot_opensbi.h
+++ b/include/hw/riscv/boot_opensbi.h
@@ -8,7 +8,7 @@
 #ifndef RISCV_BOOT_OPENSBI_H
 #define RISCV_BOOT_OPENSBI_H
 
-#include "exec/cpu-defs.h"
+#include "exec/hwaddr.h"
 
 /** Expected value of info magic ('OSBI' ascii string in hex) */
 #define FW_DYNAMIC_INFO_MAGIC_VALUE     0x4942534f
@@ -31,15 +31,15 @@ enum sbi_scratch_options {
 /** Representation dynamic info passed by previous booting stage */
 struct fw_dynamic_info {
     /** Info magic */
-    target_long magic;
+    hwaddr magic;
     /** Info version */
-    target_long version;
+    hwaddr version;
     /** Next booting stage address */
-    target_long next_addr;
+    hwaddr next_addr;
     /** Next booting stage mode */
-    target_long next_mode;
+    hwaddr next_mode;
     /** Options for OpenSBI library */
-    target_long options;
+    hwaddr options;
     /**
      * Preferred boot HART id
      *
@@ -55,7 +55,7 @@ struct fw_dynamic_info {
      * stage can set it to -1UL which will force the FW_DYNAMIC firmware
      * to use the relocation lottery mechanism.
      */
-    target_long boot_hart;
+    hwaddr boot_hart;
 };
 
 /** Representation dynamic info passed by previous booting stage */
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index c309441b7d8..acc0d221fce 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -21,7 +21,6 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
-#include "exec/cpu-defs.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/riscv/boot.h"
@@ -31,6 +30,7 @@
 #include "system/qtest.h"
 #include "system/kvm.h"
 #include "system/reset.h"
+#include "target/riscv/cpu.h"
 
 #include <libfdt.h>
 
@@ -51,7 +51,7 @@ char *riscv_plic_hart_config_string(int hart_count)
 
     for (i = 0; i < hart_count; i++) {
         CPUState *cs = qemu_get_cpu(i);
-        CPURISCVState *env = &RISCV_CPU(cs)->env;
+        CPURISCVState *env = cpu_env(cs);
 
         if (kvm_enabled()) {
             vals[i] = "S";
@@ -74,8 +74,8 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
     info->is_32bit = riscv_is_32bit(harts);
 }
 
-target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-                                          target_ulong firmware_end_addr) {
+hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+                                    hwaddr firmware_end_addr) {
     if (info->is_32bit) {
         return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
     } else {
@@ -133,13 +133,13 @@ char *riscv_find_firmware(const char *firmware_filename,
     return filename;
 }
 
-target_ulong riscv_find_and_load_firmware(MachineState *machine,
-                                          const char *default_machine_firmware,
-                                          hwaddr *firmware_load_addr,
-                                          symbol_fn_t sym_cb)
+hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    const char *default_machine_firmware,
+                                    hwaddr *firmware_load_addr,
+                                    symbol_fn_t sym_cb)
 {
     char *firmware_filename;
-    target_ulong firmware_end_addr = *firmware_load_addr;
+    hwaddr firmware_end_addr = *firmware_load_addr;
 
     firmware_filename = riscv_find_firmware(machine->firmware,
                                             default_machine_firmware);
@@ -154,11 +154,11 @@ target_ulong riscv_find_and_load_firmware(MachineState *machine,
     return firmware_end_addr;
 }
 
-target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr *firmware_load_addr,
-                                 symbol_fn_t sym_cb)
+hwaddr riscv_load_firmware(const char *firmware_filename,
+                           hwaddr *firmware_load_addr,
+                           symbol_fn_t sym_cb)
 {
-    uint64_t firmware_entry, firmware_end;
+    hwaddr firmware_entry, firmware_end;
     ssize_t firmware_size;
 
     g_assert(firmware_filename != NULL);
@@ -227,7 +227,7 @@ static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 
 void riscv_load_kernel(MachineState *machine,
                        RISCVBootInfo *info,
-                       target_ulong kernel_start_addr,
+                       hwaddr kernel_start_addr,
                        bool load_initrd,
                        symbol_fn_t sym_cb)
 {
-- 
2.47.1


