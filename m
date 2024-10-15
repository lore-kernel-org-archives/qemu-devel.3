Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8627D1D879
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jkk-0001Im-0u; Tue, 15 Oct 2024 11:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkB-0000lk-Br
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:57 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jk9-0000my-1R
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:55 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e70c32cd7so1312317b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007151; x=1729611951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAYPvc4MvYXzz9JrX6iaI+URWPP2ZVGYdAtSbEKt48E=;
 b=ZcP43lYGBGFIasMjxFUsqAF/p+WpOd50uEudzdQe4a+sDNIWQ2pYziSRwDEt5Q2i33
 7IdCVaRO9m6KKUWrZa5ct3jSqmrzJfUtVpGxM6PTUW12y7395F90S3UAJXzFvkcm5hdi
 1AtHS1YSv6Orwpnw9luwI5ngSBB7ZSGAYpwNDyXHZY+xq2BZfgdg6GZFE4QTDYttNlL8
 gU7EwUUHuPKYX7xvtJ5JJ49MfYIq94KSKvnZARI1UqMgv4mDwvG3ILCbzI0T3t31xDIQ
 AkHwPR2lUQyjjKAY4Mjv2+KPY0MqWylmjBrs0vembjD+GK5elcroqI/CCaaOBWyXZnnS
 sPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007151; x=1729611951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAYPvc4MvYXzz9JrX6iaI+URWPP2ZVGYdAtSbEKt48E=;
 b=NnKEwvhab09admFL89IMtJWkEcBROYw6boDYIwOiOKCPPdwIwLvpY+ED8qVGz3Xras
 PmkRnED/mRDXcsmT1aRQVQdsWAVm3oDCmf0JHzXYbyW9P/9pZh6FZgKSfzTVs1CPT7j2
 YbWWAgVnFL92crUZU0ZBM9xnmsvmbXZ9HmTo/e5uUF+80gf87qkvdRcUKZGxzbwyH3wL
 +IXnCgkgn3PT9kaZfrrTAyjJEU7kxr/xc64arBKqdf4pqEdF89mYPebN0UnBOkbywAGa
 KJTaYWot/cVtO+xMxmihN6hgH9lSvIks4be+oPR2igEYM4T0cSrNoLqX1X7CbfRDljtX
 DUbQ==
X-Gm-Message-State: AOJu0Yzz/YfNvrhDBOMTJo0TXWFhfkr6g5OxelmB+36330ftj347+wP6
 ny9Rrm3ceDo/JnRWWGD3uu/45Ls1fqrldEbyqydfEc9GYOKBQFyG7DcrWuWZG6iPOiYwqv7XJ7P
 F
X-Google-Smtp-Source: AGHT+IHah/txmS12fo5sQyETEbZR9GQoUzMT+84D1dMKydbhlAljrQV5zl4cpGc/M44skVdZCN8UTw==
X-Received: by 2002:a05:6a00:174c:b0:71e:5e04:be9b with SMTP id
 d2e1a72fcca58-71e7da46331mr1331898b3a.12.1729007150701; 
 Tue, 15 Oct 2024 08:45:50 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77518a76sm1414240b3a.220.2024.10.15.08.45.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:45:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/33] hw/i386: Use explicit little-endian LD/ST API
Date: Tue, 15 Oct 2024 12:44:18 -0300
Message-ID: <20241015154443.71763-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The x86 architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' hw/i386/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004163042.85922-9-philmd@linaro.org>
---
 hw/i386/multiboot.c  | 39 +++++++++++++++++++--------------------
 hw/i386/x86-common.c | 26 +++++++++++++-------------
 2 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 3332712ab35..b2648bff71a 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -133,9 +133,9 @@ static void mb_add_mod(MultibootState *s,
 
     p = (char *)s->mb_buf + s->offset_mbinfo + MB_MOD_SIZE * s->mb_mods_count;
 
-    stl_p(p + MB_MOD_START,   start);
-    stl_p(p + MB_MOD_END,     end);
-    stl_p(p + MB_MOD_CMDLINE, cmdline_phys);
+    stl_le_p(p + MB_MOD_START,   start);
+    stl_le_p(p + MB_MOD_END,     end);
+    stl_le_p(p + MB_MOD_CMDLINE, cmdline_phys);
 
     mb_debug("mod%02d: "HWADDR_FMT_plx" - "HWADDR_FMT_plx,
              s->mb_mods_count, start, end);
@@ -168,9 +168,9 @@ int load_multiboot(X86MachineState *x86ms,
     /* Ok, let's see if it is a multiboot image.
        The header is 12x32bit long, so the latest entry may be 8192 - 48. */
     for (i = 0; i < (8192 - 48); i += 4) {
-        if (ldl_p(header+i) == 0x1BADB002) {
-            uint32_t checksum = ldl_p(header+i+8);
-            flags = ldl_p(header+i+4);
+        if (ldl_le_p(header + i) == 0x1BADB002) {
+            uint32_t checksum = ldl_le_p(header + i + 8);
+            flags = ldl_le_p(header + i + 4);
             checksum += flags;
             checksum += (uint32_t)0x1BADB002;
             if (!checksum) {
@@ -223,11 +223,11 @@ int load_multiboot(X86MachineState *x86ms,
                  mb_kernel_size, (size_t)mh_entry_addr);
     } else {
         /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_ADDR. */
-        uint32_t mh_header_addr = ldl_p(header+i+12);
-        uint32_t mh_load_end_addr = ldl_p(header+i+20);
-        uint32_t mh_bss_end_addr = ldl_p(header+i+24);
+        uint32_t mh_header_addr = ldl_le_p(header + i + 12);
+        uint32_t mh_load_end_addr = ldl_le_p(header + i + 20);
+        uint32_t mh_bss_end_addr = ldl_le_p(header + i + 24);
 
-        mh_load_addr = ldl_p(header+i+16);
+        mh_load_addr = ldl_le_p(header + i + 16);
         if (mh_header_addr < mh_load_addr) {
             error_report("invalid load_addr address");
             exit(1);
@@ -239,7 +239,7 @@ int load_multiboot(X86MachineState *x86ms,
 
         uint32_t mb_kernel_text_offset = i - (mh_header_addr - mh_load_addr);
         uint32_t mb_load_size = 0;
-        mh_entry_addr = ldl_p(header+i+28);
+        mh_entry_addr = ldl_le_p(header + i + 28);
 
         if (mh_load_end_addr) {
             if (mh_load_end_addr < mh_load_addr) {
@@ -364,22 +364,21 @@ int load_multiboot(X86MachineState *x86ms,
 
     /* Commandline support */
     kcmdline = g_strdup_printf("%s %s", kernel_filename, kernel_cmdline);
-    stl_p(bootinfo + MBI_CMDLINE, mb_add_cmdline(&mbs, kcmdline));
-
-    stl_p(bootinfo + MBI_BOOTLOADER, mb_add_bootloader(&mbs, bootloader_name));
-
-    stl_p(bootinfo + MBI_MODS_ADDR,  mbs.mb_buf_phys + mbs.offset_mbinfo);
-    stl_p(bootinfo + MBI_MODS_COUNT, mbs.mb_mods_count); /* mods_count */
+    stl_le_p(bootinfo + MBI_CMDLINE, mb_add_cmdline(&mbs, kcmdline));
+    stl_le_p(bootinfo + MBI_BOOTLOADER, mb_add_bootloader(&mbs,
+                                                          bootloader_name));
+    stl_le_p(bootinfo + MBI_MODS_ADDR,  mbs.mb_buf_phys + mbs.offset_mbinfo);
+    stl_le_p(bootinfo + MBI_MODS_COUNT, mbs.mb_mods_count); /* mods_count */
 
     /* the kernel is where we want it to be now */
-    stl_p(bootinfo + MBI_FLAGS, MULTIBOOT_FLAGS_MEMORY
+    stl_le_p(bootinfo + MBI_FLAGS, MULTIBOOT_FLAGS_MEMORY
                                 | MULTIBOOT_FLAGS_BOOT_DEVICE
                                 | MULTIBOOT_FLAGS_CMDLINE
                                 | MULTIBOOT_FLAGS_MODULES
                                 | MULTIBOOT_FLAGS_MMAP
                                 | MULTIBOOT_FLAGS_BOOTLOADER);
-    stl_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -boot switch? */
-    stl_p(bootinfo + MBI_MMAP_ADDR,   ADDR_E820_MAP);
+    stl_le_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -boot switch? */
+    stl_le_p(bootinfo + MBI_MMAP_ADDR,   ADDR_E820_MAP);
 
     mb_debug("multiboot: entry_addr = %#x", mh_entry_addr);
     mb_debug("           mb_buf_phys   = "HWADDR_FMT_plx, mbs.mb_buf_phys);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 992ea1f25e9..b86c38212ea 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -586,7 +586,7 @@ static bool load_elfboot(const char *kernel_filename,
     uint64_t elf_low, elf_high;
     int kernel_size;
 
-    if (ldl_p(header) != 0x464c457f) {
+    if (ldl_le_p(header) != 0x464c457f) {
         return false; /* no elfboot */
     }
 
@@ -669,8 +669,8 @@ void x86_load_linux(X86MachineState *x86ms,
      * kernel protocol version.
      * Please see https://www.kernel.org/doc/Documentation/x86/boot.txt
      */
-    if (ldl_p(header + 0x202) == 0x53726448) /* Magic signature "HdrS" */ {
-        protocol = lduw_p(header + 0x206);
+    if (ldl_le_p(header + 0x202) == 0x53726448) /* Magic signature "HdrS" */ {
+        protocol = lduw_le_p(header + 0x206);
     } else {
         /*
          * This could be a multiboot kernel. If it is, let's stop treating it
@@ -762,7 +762,7 @@ void x86_load_linux(X86MachineState *x86ms,
 
     /* highest address for loading the initrd */
     if (protocol >= 0x20c &&
-        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
+        lduw_le_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
         /*
          * Linux has supported initrd up to 4 GB for a very long time (2007,
          * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
@@ -781,7 +781,7 @@ void x86_load_linux(X86MachineState *x86ms,
          */
         initrd_max = UINT32_MAX;
     } else if (protocol >= 0x203) {
-        initrd_max = ldl_p(header + 0x22c);
+        initrd_max = ldl_le_p(header + 0x22c);
     } else {
         initrd_max = 0x37ffffff;
     }
@@ -797,10 +797,10 @@ void x86_load_linux(X86MachineState *x86ms,
     sev_load_ctx.cmdline_size = strlen(kernel_cmdline) + 1;
 
     if (protocol >= 0x202) {
-        stl_p(header + 0x228, cmdline_addr);
+        stl_le_p(header + 0x228, cmdline_addr);
     } else {
-        stw_p(header + 0x20, 0xA33F);
-        stw_p(header + 0x22, cmdline_addr - real_addr);
+        stw_le_p(header + 0x20, 0xA33F);
+        stw_le_p(header + 0x22, cmdline_addr - real_addr);
     }
 
     /* handle vga= parameter */
@@ -824,7 +824,7 @@ void x86_load_linux(X86MachineState *x86ms,
                 exit(1);
             }
         }
-        stw_p(header + 0x1fa, video_mode);
+        stw_le_p(header + 0x1fa, video_mode);
     }
 
     /* loader type */
@@ -839,7 +839,7 @@ void x86_load_linux(X86MachineState *x86ms,
     /* heap */
     if (protocol >= 0x201) {
         header[0x211] |= 0x80; /* CAN_USE_HEAP */
-        stw_p(header + 0x224, cmdline_addr - real_addr - 0x200);
+        stw_le_p(header + 0x224, cmdline_addr - real_addr - 0x200);
     }
 
     /* load initrd */
@@ -879,8 +879,8 @@ void x86_load_linux(X86MachineState *x86ms,
         sev_load_ctx.initrd_data = initrd_data;
         sev_load_ctx.initrd_size = initrd_size;
 
-        stl_p(header + 0x218, initrd_addr);
-        stl_p(header + 0x21c, initrd_size);
+        stl_le_p(header + 0x218, initrd_addr);
+        stl_le_p(header + 0x21c, initrd_size);
     }
 
     /* load kernel and setup */
@@ -926,7 +926,7 @@ void x86_load_linux(X86MachineState *x86ms,
         kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
         kernel = g_realloc(kernel, kernel_size);
 
-        stq_p(header + 0x250, prot_addr + setup_data_offset);
+        stq_le_p(header + 0x250, prot_addr + setup_data_offset);
 
         setup_data = (struct setup_data *)(kernel + setup_data_offset);
         setup_data->next = 0;
-- 
2.45.2


