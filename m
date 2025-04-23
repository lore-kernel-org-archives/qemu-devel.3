Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDF9C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XwV-0004QH-Jh; Wed, 23 Apr 2025 07:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwM-0004NS-1l
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:06:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwJ-0000LD-H0
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:06:53 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227914acd20so6898755ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745406409; x=1746011209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBwBwBvoQvjFeMA6D6SU8+WJZtp4ESASlnNymXsh7Fc=;
 b=T1Yr+hdu7xfD/8GbVhWlomF5CI3JxcV4+otLTXRl0lMLFHZGCjq6f9WGcCVSmxwaHP
 VMFUElG+WeRUGkoBPBZd2gMR/341M96UmeDe2WHfqSgTYwiIlTM0rGKTuQfMHAoq+rVF
 vrV3clNURZB1+jWQguJI/2sqe9BdK7QPFL4SauvcoFXzNeE3Rfk+18F3ZBQNfZ1eX31z
 MlYZL9B312x2fMuwYQK65xUyMxKpcvt6J/SFk6lmp0+R12GQxr7MkI1KGBE8pj9Mwrdw
 FGMO8E5tjMPzWw/fDkOcMSmnYWfqz7rbXpFe9qmyCMuWZwHknxRm6lOxdad+orOKPrfS
 LawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406409; x=1746011209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBwBwBvoQvjFeMA6D6SU8+WJZtp4ESASlnNymXsh7Fc=;
 b=hieIjrLkcyJCF4w1MsvWESoHODq7cRGoua4x8SyL5a5hvjEe0Q/aFdc98n6Iqoaj02
 Z+RalBuQNc66jHlxQx5xqHOsJRwVIVsnIxGfG18PjEQiCQQp2vHOABwTxwkQu57ip8Eo
 tDGxVK7qn4KK5u7b6kWd6LzdkZMb7JiwuSlA7nrsyZwT9keyTY/wsr5ixu6srHa02V/i
 1twn8aFo7j6Dtm2hee/jxRAF+9eWrUSdZF+Q0XD2p6GQdOuqvF2z4ZhAhS5H1NwmwglW
 r7KHr9nuISJqgFqzdCyq101dUl5xhcO93AiXCgl1uhkXa36Mb010PEAZ44JHtV45em2x
 Xdcw==
X-Gm-Message-State: AOJu0YzpguReh50c9r+69J1JWBbkozzFmAvXxnsbHHbDINXsPq/wkvzY
 3YxM5Wvlc9uU7JideMgT1DasCVcTsKasXA4hPRizuSIH2MzeK30FamslKNayh0vjC+rMP4LW9e1
 /
X-Gm-Gg: ASbGnctYaeDhYMZKVflpQ+tQwhnK55hf7Nbqq7LxKJ1KYC33vqHcpTRYkTgEgQlr8nP
 OKNeFXHXrnv1Y9lzTQTHxmlC5gbXG7Q29EjMevWDYXp9LBku3XZKqlafVuw3UywJ81RB5qBybNZ
 382LalSuJcqSAU+vbtegjFjsa9eEAvrkidzwfHNnRA8shwewSQYrA8ukakjCslK1jQI6GI+NsCZ
 TiluWoGQBi+vv+BIUD4cMHHkBxt5r2gICfl5HUZyX2BWsEN3aE+/HxOEBr+FXfzf4ezhbTFcCKH
 +CWZG5FGb8D64Jdd0fZkpWK+u3RTyJTCl86KiQTSRzXOw++klfJP2P8Puy74rsQ=
X-Google-Smtp-Source: AGHT+IHiyz9XO2LcNoIncGAEEe3v/qQpte6TP+eRnmKO9QVO2qHkf6ZWsWF/inde0ZcsEp+l6RaeSQ==
X-Received: by 2002:a17:902:ebc3:b0:21f:1348:10e6 with SMTP id
 d9443c01a7336-22da31bfb8dmr40237285ad.13.1745406408804; 
 Wed, 23 Apr 2025 04:06:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bcc0:89f4:3b90:a265:963d:8357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf3b1sm101509895ad.248.2025.04.23.04.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 04:06:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/9] hw/riscv/virt.c: use s->memmap in virt_machine_done()
Date: Wed, 23 Apr 2025 08:06:24 -0300
Message-ID: <20250423110630.2249904-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index fdf0318e15..473416bcf3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1430,9 +1430,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
 {
     RISCVVirtState *s = container_of(notifier, RISCVVirtState,
                                      machine_done);
-    const MemMapEntry *memmap = virt_memmap;
     MachineState *machine = MACHINE(s);
-    hwaddr start_addr = memmap[VIRT_DRAM].base;
+    hwaddr start_addr = s->memmap[VIRT_DRAM].base;
     target_ulong firmware_end_addr, kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint64_t fdt_load_addr;
@@ -1476,14 +1475,14 @@ static void virt_machine_done(Notifier *notifier, void *data)
              * let's overwrite the address we jump to after reset to
              * the base of the flash.
              */
-            start_addr = virt_memmap[VIRT_FLASH].base;
+            start_addr = s->memmap[VIRT_FLASH].base;
         } else {
             /*
              * Pflash was supplied but either KVM guest or bios is not none.
              * In this case, base of the flash would contain S-mode payload.
              */
             riscv_setup_firmware_boot(machine);
-            kernel_entry = virt_memmap[VIRT_FLASH].base;
+            kernel_entry = s->memmap[VIRT_FLASH].base;
         }
     }
 
@@ -1497,15 +1496,15 @@ static void virt_machine_done(Notifier *notifier, void *data)
         kernel_entry = boot_info.image_low_addr;
     }
 
-    fdt_load_addr = riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
-                                           memmap[VIRT_DRAM].size,
+    fdt_load_addr = riscv_compute_fdt_addr(s->memmap[VIRT_DRAM].base,
+                                           s->memmap[VIRT_DRAM].size,
                                            machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
     riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
-                              virt_memmap[VIRT_MROM].base,
-                              virt_memmap[VIRT_MROM].size, kernel_entry,
+                              s->memmap[VIRT_MROM].base,
+                              s->memmap[VIRT_MROM].size, kernel_entry,
                               fdt_load_addr);
 
     /*
-- 
2.49.0


