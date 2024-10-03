Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E695CCF34D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVUD-0000qJ-TO; Thu, 03 Oct 2024 19:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVU6-00009r-IU
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVU3-00042g-Hf
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so14748715e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727999025; x=1728603825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40sQ4VfLlzD0bwKrU0yv53LEQFzkHa33/3LdJQsX1lI=;
 b=C6dSb+HU7s024JWuPCW04mC67eiQRg5D9BCm3dH1rg2h0fkBdmTIDraO5cwKBgzXgt
 hTg7Db2e3/s7W0e51KMaaoG+GQu9HURSXcyrWLHVFb1EFEBpBnnCvY8frWJn2ebwhq5x
 6ssIsnLbx2eRKdxbFST6RYYgkeU8oOmtXnWrR5o9zsYsK+6ih4RyEfxduus95PsWWciS
 e0PpeDEnDDIg4Px+DeOTYMUOaH0xtrTHkwPpLUIAI895WuyKx5801XhezBPnAM7jEbVv
 5cbAg3ABC8JejCvKLON4BNrMs7EEp8Ma/V+hBuRh/qAjK1PTkCGo46iFC5aVGgPm4EeJ
 mFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727999025; x=1728603825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40sQ4VfLlzD0bwKrU0yv53LEQFzkHa33/3LdJQsX1lI=;
 b=wHUNRAggdv6lC6WbWioxBleShoRfz5dO/FBdAy5mddUAyWU+GeDOuE0nNQB76DTQJL
 4sCnW67Lu7uvZpmFTab3xBKOpwluLtn40GnhnVnlvFlyvDlXp2NxkX2IrwLz5gNxPW9t
 5hMQeBYI7wZkPgP1VHa2m1UR2QL+gZqz8ocHnye8tFKw64NEG7NTn9Y4ilRWo2q2kXus
 XWZDEd/cF/mog6rAPImSpxJ6kIc0apId3xTHRRus1uAbfzegGfNJgyKC1Utdvl83CDms
 wZ5rU4a8sci+ASHpl8mQe8741682vYZPeP3v25lKp0ke1bIcqhXDu5yAtL1m9kRS6soC
 lasw==
X-Gm-Message-State: AOJu0YyRz6mFByijVKmGOnVsFwQAQGwhdw4T+olLlrkqFJEJnJx7PlYX
 ZGB57N/VeSCYAORVcFRkTK87/mw8TgndDlArexZrtc2nWjhkylAlgHvvZziy8hYxJ6mljk0dJgs
 skUw=
X-Google-Smtp-Source: AGHT+IE6wDFO3YWjtJCgM/UhCvl215hi1nTPJ7ePzE5qEO3OwVI5fPDybbhIShNyCPzor5JXBSc9KA==
X-Received: by 2002:adf:f7c1:0:b0:37c:ced2:843b with SMTP id
 ffacd0b85a97d-37d0e6f0373mr594835f8f.20.1727999024875; 
 Thu, 03 Oct 2024 16:43:44 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b1d566sm1315975e9.14.2024.10.03.16.43.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:43:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 11/16] hw/sparc: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 01:42:06 +0200
Message-ID: <20241003234211.53644-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
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

The SPARC architecture uses big endianness. Directly use
the big-endian LD/ST API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c   | 42 +++++++++++++++++++++---------------------
 hw/sparc/sun4m.c   |  6 +++---
 hw/sparc64/sun4u.c |  6 +++---
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 6aaa04cb191..021b5070128 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -78,21 +78,21 @@ typedef struct ResetData {
 
 static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
 {
-    stl_p(code++, 0x82100000); /* mov %g0, %g1                */
-    stl_p(code++, 0x84100000); /* mov %g0, %g2                */
-    stl_p(code++, 0x03000000 +
+    stl_be_p(code++, 0x82100000); /* mov %g0, %g1                */
+    stl_be_p(code++, 0x84100000); /* mov %g0, %g2                */
+    stl_be_p(code++, 0x03000000 +
       extract32(addr, 10, 22));
                                /* sethi %hi(addr), %g1        */
-    stl_p(code++, 0x82106000 +
+    stl_be_p(code++, 0x82106000 +
       extract32(addr, 0, 10));
                                /* or %g1, addr, %g1           */
-    stl_p(code++, 0x05000000 +
+    stl_be_p(code++, 0x05000000 +
       extract32(val, 10, 22));
                                /* sethi %hi(val), %g2         */
-    stl_p(code++, 0x8410a000 +
+    stl_be_p(code++, 0x8410a000 +
       extract32(val, 0, 10));
                                /* or %g2, val, %g2            */
-    stl_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
+    stl_be_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
 
     return code;
 }
@@ -112,13 +112,13 @@ static void write_bootloader(void *ptr, hwaddr kernel_addr)
 
     /* If we are running on a secondary CPU, jump directly to the kernel.  */
 
-    stl_p(p++, 0x85444000); /* rd %asr17, %g2      */
-    stl_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
-    stl_p(p++, 0x80908000); /* tst  %g2            */
+    stl_be_p(p++, 0x85444000); /* rd %asr17, %g2      */
+    stl_be_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
+    stl_be_p(p++, 0x80908000); /* tst  %g2            */
     /* Filled below.  */
     sec_cpu_branch_p = p;
-    stl_p(p++, 0x0BADC0DE); /* bne xxx             */
-    stl_p(p++, 0x01000000); /* nop */
+    stl_be_p(p++, 0x0BADC0DE); /* bne xxx             */
+    stl_be_p(p++, 0x01000000); /* nop */
 
     /* Initialize the UARTs                                        */
     /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
@@ -133,17 +133,17 @@ static void write_bootloader(void *ptr, hwaddr kernel_addr)
     p = gen_store_u32(p, 0x80000318, 3);
 
     /* Now, the relative branch above can be computed.  */
-    stl_p(sec_cpu_branch_p, 0x12800000
-          + (p - sec_cpu_branch_p));
+    stl_be_p(sec_cpu_branch_p, 0x12800000
+             + (p - sec_cpu_branch_p));
 
     /* JUMP to the entry point                                     */
-    stl_p(p++, 0x82100000); /* mov %g0, %g1 */
-    stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
-                            /* sethi %hi(kernel_addr), %g1 */
-    stl_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
-                            /* or kernel_addr, %g1 */
-    stl_p(p++, 0x81c04000); /* jmp  %g1 */
-    stl_p(p++, 0x01000000); /* nop */
+    stl_be_p(p++, 0x82100000); /* mov %g0, %g1 */
+    stl_be_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
+                               /* sethi %hi(kernel_addr), %g1 */
+    stl_be_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
+                               /* or kernel_addr, %g1 */
+    stl_be_p(p++, 0x81c04000); /* jmp  %g1 */
+    stl_be_p(p++, 0x01000000); /* nop */
 }
 
 static void leon3_cpu_reset(void *opaque)
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d52e6a7213f..f375f0d389b 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -271,9 +271,9 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
         if (*initrd_size > 0) {
             for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
                 ptr = rom_ptr(KERNEL_LOAD_ADDR + i, 24);
-                if (ptr && ldl_p(ptr) == 0x48647253) { /* HdrS */
-                    stl_p(ptr + 16, INITRD_LOAD_ADDR);
-                    stl_p(ptr + 20, *initrd_size);
+                if (ptr && ldl_be_p(ptr) == 0x48647253) { /* HdrS */
+                    stl_be_p(ptr + 16, INITRD_LOAD_ADDR);
+                    stl_be_p(ptr + 20, *initrd_size);
                     break;
                 }
             }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 4ece1ac1ffc..e591e5a741a 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -210,9 +210,9 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
         if (*initrd_size > 0) {
             for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
                 ptr = rom_ptr(*kernel_addr + i, 32);
-                if (ptr && ldl_p(ptr + 8) == 0x48647253) { /* HdrS */
-                    stl_p(ptr + 24, *initrd_addr + *kernel_addr);
-                    stl_p(ptr + 28, *initrd_size);
+                if (ptr && ldl_be_p(ptr + 8) == 0x48647253) { /* HdrS */
+                    stl_be_p(ptr + 24, *initrd_addr + *kernel_addr);
+                    stl_be_p(ptr + 28, *initrd_size);
                     break;
                 }
             }
-- 
2.45.2


