Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0697CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJH-0005lp-U4; Fri, 04 Oct 2024 12:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlHN-00012F-N6
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:49 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlHE-0006XK-D4
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:39 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5398e7dda5fso2436446e87.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059733; x=1728664533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6M7F9MlipNOYzrQaom9GAgFYoDMLlj7tvvuZZcP6m74=;
 b=ZYz+7t0TtaAPsYKGt8H5gHvKwveX6NZfEZcJ6CoTN2XjjBAEVW0dbDdjVtJVM9tBvV
 1s4d/0gDwgYrY/3ObyVbCpuOSw0hHN74XeHcezXNRg81KqkL1m4MAjzugw2kMEsRrIUo
 5FNqAuIkbZKIzQE/SN6FOxdcQ2M57zNE6mgtYMUQjFLFWSR/MtobeRWtv9K+PL+gHPdX
 ALGiA+QjQaRsXAJ58mbdEPerSo6Z3Ar79/LMMzv9jHSr93x+L4WdwUpPGyCaK1qet6vW
 mCpq1KKzu0Cuddb17ZQtox93HgIWcquQqjEuRa/882NwM9IiieYu/mHQ/zHL91z0frnB
 BJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059733; x=1728664533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6M7F9MlipNOYzrQaom9GAgFYoDMLlj7tvvuZZcP6m74=;
 b=J1jVMBGKTP09vSVmjPq7H5OhKg9wghMyx83Seg+Q2TuNOXyO2206ft10Kh/T+IbvLe
 iXuqmkDX/+56lJzZGS8PBbAt5VtuLuSE/hWhnbixrGtEfvgm5+pL2KLW2Ow83Ta71DUN
 8tZ/njeBWQwK/SU0pjNEHMfv2kixvMQMk7cl16Cin4z1IYup2foY9Ie/MzKlMFEazrQe
 bzM/M98BeTU77eb5mmvamp8bI3BpnwUw9S1Ii9pALL5g7FRv0VeKU3pfBJWqGS4Ebyiy
 H+JdhgqiB2hGLilxTOUOQpZRnfTFgxF0XitFKVcIbhkyVr1oaABbTfpvI3iCXa5iGA8c
 JVnQ==
X-Gm-Message-State: AOJu0YxLNSqwiGwEP2ZUHptOoUJs63sxaVXyUh1kchn0iVP+AugIJEKH
 dGR9mYLGkoYBxbM83CpQXllHcHAy6QlEnNRkEjV0xU9zurSDqSWK3XVV6DlGE/22CPZcYQE+5fL
 6QBoIQQ==
X-Google-Smtp-Source: AGHT+IE75adEi58xxY+eb+s/8/wYi+gBrnWmrL7GuordUIripl+cJqkS9CGThpKCYM4+XMTAlK1Wdg==
X-Received: by 2002:a05:6512:1387:b0:539:955b:43d0 with SMTP id
 2adb3069b0e04-539ab9d0ad2mr2091898e87.47.1728059733102; 
 Fri, 04 Oct 2024 09:35:33 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff23e0bsm1307e87.243.2024.10.04.09.35.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:35:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 19/25] hw/sparc: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:35 -0300
Message-ID: <20241004163042.85922-20-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

for a in uw w l q;do sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" $(git grep -wlE '(ld|st)u?[wlq]_p' hw/sparc/);done

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


