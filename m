Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ED3C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3w-0001T1-Ob; Mon, 19 May 2025 00:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrp2-0008TT-Pn
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:56 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroz-0004Oo-0G
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:51 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30dfd9e7fa8so4929785a91.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627787; x=1748232587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXvxkbFCVrdBL5uAGVM/FxbZOq84FCzkwXE2y02RSA8=;
 b=hKvMC2o+j5VXn0vqRk8JQv+ASZNg3+HY5T9n/8ZLBOUFFMmN1PKLbsk2JYdV7Ggo9U
 6JUiG3OszxFQaH5b+uONfUd07UapuQsGNZqWDqpNtpoDHfgzFqyOtAlU4/I0XiQ8/JC2
 w0GRQ640i0ACjAqU8u09mzcyZMtkH4oJfxL+2xkq91OF/YajKJ4g5PXWf0lWRm1eZD8v
 IKfyb72KY44YnY+dypp5kyp7M1bbQpol5YeyRgYX3YCxEN0g/0Wj1YKpTVA9fIQBtgvP
 IBhRAnB42L2JGVVWW/A814YVh5hgCO+M6Eo5yTtX93Wx3fyvNzHKZms3VmiiDqIJt3Q8
 sOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627787; x=1748232587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXvxkbFCVrdBL5uAGVM/FxbZOq84FCzkwXE2y02RSA8=;
 b=lPlMSFVJjVzYuPfdOH8OC9r2tf6eCb8fDov9xk1ihuWTlyBcyirxkmjvG2tgClE76l
 rZS4Hg0kNj3DyKjvsJGF/5n+Up+O+ilc6L3MzCBxY7aF79u+Q4lsdrlXQEd56Fzgn9og
 3mrCGZTYUDd/7M3QwY5G/NDAK3fyUEf1NAfhvN1PGRqD8nNMLgQe+mOBStUyA+Phgk9/
 HCaXdRja5PgInTM09wEIwsKo8AV00h06y7gxk71OT3nNIxJqCq0O41luIGcBEdJYBzI2
 E5NcRyf1JyrVZc2FHlVIbkmocVYNCsBuciW+2PvEAxZpG4Xua0M5R1VN+zRXQXH7s6MW
 ODDw==
X-Gm-Message-State: AOJu0YwGTGKkrBzgcyt8Cg7nP8CNUW5oDCPGscZAqkyR74d5e/Y4Oo13
 Ep4c9kcz0TY4e+WiEkGeY7n6Tf5ozklr06giJTpq0NKNslYf9Dg+TTpUpO50wA==
X-Gm-Gg: ASbGncv4EN7CH75zXwXu/HV4U2dssZJl2WVOZRIQMw9CrLYj+hBoxBs6J6AL0zt43tR
 Rc4ztxQV4p8j6FQgEHzM4JDrQuOa4jMuev2ZgrPpSEnQ3r+3PGvKk9Mr3zUmVT9uVurqBMyg9e5
 icxj6k664R6sTCakfekEMF6JX08rO0CwzWQusMwMDW4xl/+krCS6ehDYoMLxRSVo2QLn+aGYKYZ
 qxrYhn11bAS4M5amwtyq6cw4S52dEBY1oSz7aHY6svWIBk+Gk+RYo0xgm5UoltTythlJ9Mr7AC9
 Batc0yQ4iupW75E5vTKL6URoBd4/430a7alFmDfuoFH9KbFMlKh9esJDgbtYfpZHizZxlKi1IIN
 aFRATX9Tq7oEGI502T3ehLKOVlGuQTpBTwKqPZaKsLur5gWGCnPDIIvKe+GlUWGuKEmk=
X-Google-Smtp-Source: AGHT+IEPxzSQ8z9EeXNZ9TV+Dc9PQypkNgnXsx6QWJj50MvMg7tSPHk54qS84Sfcx72e7SDdbmanKw==
X-Received: by 2002:a17:903:244e:b0:22e:3b65:9286 with SMTP id
 d9443c01a7336-231de3bb4afmr165334295ad.49.1747627787103; 
 Sun, 18 May 2025 21:09:47 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 50/56] hw/riscv/virt.c: use s->memmap in virt_machine_done()
Date: Mon, 19 May 2025 14:05:47 +1000
Message-ID: <20250519040555.3797167-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429125811.224803-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 843665a5bd..b349b2b1cf 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1425,9 +1425,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
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
@@ -1471,14 +1470,14 @@ static void virt_machine_done(Notifier *notifier, void *data)
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
 
@@ -1492,15 +1491,15 @@ static void virt_machine_done(Notifier *notifier, void *data)
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


