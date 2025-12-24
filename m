Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1366E776C4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRhu-0007eo-Vo; Wed, 24 Dec 2025 11:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRhd-0007Ym-HA
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:12 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRha-0003b2-Q7
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:09 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so44068135e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593622; x=1767198422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9A1gr5CJUaSQgBXQcHovtENYxaFT/E0t2tXqegO2h5o=;
 b=XNXfMo9MyDNq1uVDd0AH42Up2+yI1glak3yQVuc9zry+hAa7FvMegEHSlC0SZTrsJ4
 PIa6oc+LYr0VfEd8E8xbStNv5txz7ieUt2v/qvuj0v9MePusM/dCAHdcIE+X2sUf4zdh
 v0LZ14/9797pVXQNFrtqGpcFYoM5EP/CGduI+VkjCWGh341UqKtc2Ua3DEhFbTJfSDwc
 4/Q5vVXHMSIjTVdg4Fg40DteNUsKx/gfY3jONMuqXF3PpaXu6Czh8WKaHw1fzaDITc7F
 yh62uNCl53JprtUGYrnJxR4ywcqfZHR3amGUuvoKFUj3jAjvFo3mYdBYI21QDiur1nrT
 5N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593622; x=1767198422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9A1gr5CJUaSQgBXQcHovtENYxaFT/E0t2tXqegO2h5o=;
 b=toWBTfiQB/seq6OC4KW3S9nqHRLqJ+NCAiBxZCh9JDE/KpgvoX8xioMwxz20Qvd5UF
 kBA/NN2OTwox1MeStywoCDQq8ucvMKvGxEUQecUjLv8M+AMlvOQcqyKEtq/O39X7GG3z
 oGNixqnxC0u8rCqkTP/8kObeBZ/oZ6j6EYhA9Heg1AhwenggnsgkGK1WfkOztSDN+C/U
 /1OS1U5TpVtAABPOkF7zZWfdOUgIhlp/1W7fWDixAQ+2rbRO5dYpug1rMO2ttJS8OITZ
 QpOLS6OirU1X4Bii4qTMhhROblvnc0zX20Rk1IDYDlH2YFT5Psjgkuz+/iT/PTDFEANt
 boIg==
X-Gm-Message-State: AOJu0Ywkp477f97bmuOfIrKBOc9aTcmgvMvq30W/vt2/Mze9Yq/weKvk
 flH4+lgEVWmg71VcnKgHFN3rHUlx632NetAc9GHW1Xxb3rIbS6Al+CZ94OFxXaeLIOngHNdmknN
 8olImmio=
X-Gm-Gg: AY/fxX5Km3xIA+OqRZNisShu1veq5KFHLoKiACaXTCxdpXfpoRHJzMTBcOxCf4lpLcV
 9kAAvrP/x9TSR3sRXr/5EyhbJSW0czNShFeke04/M/g7BM0yR4FKQkM06S1IgQQ5q98q26MX2C4
 W33pA4EZ6hQ/CaL3zs4IFbF65LA65a5q1TPqK7Ec/GZZuLGfhor0dMSCQ+j/oPCgb4pbXO3BbIz
 FFTbLj2dimLUNnXoM4koHJgBqVyEvoQLG1z4Ys7qupR+xuNSbLEi99D4h/LYbUv0N0drfjv3zJa
 VsCoRW1UueY28AKgYqpc1P7Il7dIaCZGVVBsUYArbuVJ43rmd5jxZVxeMdOvaCG5DPUWWyzQtDq
 GOHK1r1/LfNLB9TtZD7j6f3vNOwfE6FbCe/HOPKudqiJKYVogYNyryzu4fwMYZ+Nkt2ghKO70OP
 Q0MnwAutXJ8JuKtkTMxTt0aER+PU0SYwlXT0IyDe/b3Q65h2lAFazQ0co=
X-Google-Smtp-Source: AGHT+IH9FETtIJ2Dw3KXjNvWApTaUQIc2RHgg2H6eHT5VrDqDZHPI9TIMfrmKVuObpGZvXIvnJRPtQ==
X-Received: by 2002:a05:600c:3b0d:b0:477:569c:34e9 with SMTP id
 5b1f17b1804b1-47d20021316mr175842555e9.23.1766593622429; 
 Wed, 24 Dec 2025 08:27:02 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3bbe1c8sm139674375e9.11.2025.12.24.08.27.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:27:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/9] hw/sparc: Use explicit big-endian LD/ST API
Date: Wed, 24 Dec 2025 17:26:34 +0100
Message-ID: <20251224162642.90857-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162642.90857-1-philmd@linaro.org>
References: <20251224162642.90857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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


