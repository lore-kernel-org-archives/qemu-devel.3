Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C54D6E2AE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 22:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWMHC-0001Q9-Ve; Thu, 18 Dec 2025 17:15:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHB-0001Pk-BQ
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:13 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMH9-0006q4-3h
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:13 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso4650875e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 14:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766096109; x=1766700909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9A1gr5CJUaSQgBXQcHovtENYxaFT/E0t2tXqegO2h5o=;
 b=sWATqa3uHy59IEyAQfwz7C+o684LG0qIFpI8bCtHxcPBiDg6qSluOW+M4oB7coNWS0
 43ckuYQS7rLtxh/61qaYd5g87Dw3oOkY4+Uex9xeFIlk0kMuQky+iQTx/e+z6ue5iQcF
 RnNyD7zWd0aH9lOaf7fsHHy+NaRf9yV8NT5WPJqK56afieTGWG6VY50Coo787X11rnH3
 tcnJ63VoVf4MGxw9yrglg4eE5ypOlJYoX3v2B+WGtpumQXv2p6aKRWE1YtmgnFWK/Y46
 kXEXxJ02pb2nAQaWKW+wdPzKUvEK7Q9270Ug1ZfyEGtob7YOkKJmt7Z0t+eRpSenK7zr
 chmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766096109; x=1766700909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9A1gr5CJUaSQgBXQcHovtENYxaFT/E0t2tXqegO2h5o=;
 b=rFG3q1tOuASCCJMGfI8XBjDP1P1Uxpfh5K2zEIKkXZBWWELZLtxwKm1Ld0ALfcCBa4
 L0kucxxAfqpWXYp6iyRFrILCotmDGP+d9dUGqmB3/HWx0NMX3f1WdFnZFpp2JpuzkeT/
 kUR4qBAze+qukwRyORMa4I1sQuyBaaTMZyCBVQFvfLCaRcgIc4UC2KwKUg0T3C/LtKHH
 MQ6+lRyCtRnLc3uP3E7HGVm+wkfBJCfjnJGIc4C6C1DBOqcH6gASBWPPbAHYXxsVta0F
 FDc0AVMVa43Mz6gkNrD2+48TJ24BXcLsrGw45dPeJedPcn6u7P9E38G4fWrX2n+4d1q5
 mJaQ==
X-Gm-Message-State: AOJu0Ywg/UJCLG/y8Pv4BNHVfc+M8/HHsp2J8yIm7Luu2KSFOgfUoLee
 tqYikL3Ca7eIdCmdpwrJT8WeaHhD3hHHzgUNEVyxnGmEbs7IKEBOKqTXXG9iPjvbRIUcoElrLqD
 Zy9jaJr0=
X-Gm-Gg: AY/fxX6qnWgPlXjSiRBRf3zMlaVpCjjb0YF7jFmZwpyeIaGlx6JYh/uUSfRxkWDhQnr
 ChgGLLYTtuIPOucm0XodkbqDF1XGaNd08mNKKqeogE2ZL9OUQEqau29PlXE4KjxEbNPPPm829cz
 mcQT7VH8Q8Fd12sJXqSqseE+K6QU941ul26IyQjm8MYCUdPj4lnwmP8qcc1TSICmpCK64VxsFfc
 1MVKh5KD2IcQxFIWoVQ1fHS052MkK9FECKnmq2HStr3MLPhIZPOhvQrd4cgC8WoTzxPsXEO8H4n
 u99TvqX/PoPSsRNsl+irve0BKRlgmF1MwJNumCJLxYGFzvqUPae05nz1oqI1S00S4JvfM19ciHh
 xZBnkXrhV3wRY7L5uazk7N+rsNGhtsUl6BVDG304FudaL/ht19HFj0jbSPilf/5Rk5wHt4xOhyf
 BgCqEc0Upk+QCbTUGMoMdcvSbO1RRbkaXyqTmzU229eWenVTTwGJFdj7zvFO/HaD/JKKNtrFadL
 KQYvlUIBg==
X-Google-Smtp-Source: AGHT+IEWA0AqhiqGd6C3tlcRx7U7sx7I9Zn+5xAeQJTS3aSRMVHJ1129lbAkrTpzL0xmXuMcoFWi4Q==
X-Received: by 2002:a05:600c:8216:b0:477:97c7:9be7 with SMTP id
 5b1f17b1804b1-47d19549a07mr6458775e9.1.1766096109032; 
 Thu, 18 Dec 2025 14:15:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a40c5dsm22108935e9.6.2025.12.18.14.15.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 14:15:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] hw/sparc: Use explicit big-endian LD/ST API
Date: Thu, 18 Dec 2025 23:14:52 +0100
Message-ID: <20251218221457.73341-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218221457.73341-1-philmd@linaro.org>
References: <20251218221457.73341-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The SPARC architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' hw/sparc*/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Chigot Clément <chigot@adacore.com>
---
 hw/sparc/leon3.c   | 42 +++++++++++++++++++++---------------------
 hw/sparc/sun4m.c   |  6 +++---
 hw/sparc64/sun4u.c |  6 +++---
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 631c6113b5c..0414e9df573 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -78,21 +78,21 @@ typedef struct ResetData {
 
 static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
 {
-    stl_p(code++, 0x82100000); /* mov %g0, %g1                */
-    stl_p(code++, 0x84100000); /* mov %g0, %g2                */
-    stl_p(code++, 0x03000000 +
+    stl_be_p(code++, 0x82100000); /* mov %g0, %g1             */
+    stl_be_p(code++, 0x84100000); /* mov %g0, %g2             */
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
+    stl_be_p(code++, 0xc4204000); /* st %g2, [ %g1 ]          */
 
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
index 53d7ae08ae9..52ca9586001 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -268,9 +268,9 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
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
index 82c3e7c855b..e83c82fc9ae 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -206,9 +206,9 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
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
2.52.0


