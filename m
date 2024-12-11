Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D73C3ABA0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWH3-0000pg-DT; Wed, 11 Dec 2024 18:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLWH2-0000pP-12
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:37:44 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLWH0-0007Q2-00
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:37:43 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so50205e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733960260; x=1734565060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/Mn/Kq2pCLPi33bMQOIuejS0tt/kGcgJxICKl7/0zU=;
 b=KAT/CXBS+eZ7Zyux/LxfEmnH0MIt6Ts69WXdBY1F4T98vM66kdmxY6uOb+AzhHC/Ki
 HKeUAZEhrCr5BZLQqmQBi49QDOjnIidb6/MjfU6loAJB8PxI+jgiZYgnzAzlylg+Llvk
 CLwDdxoDB7rOFhW8ga5GxaUw8FWAkSmO7cdE0cmWtczQbIsY47TY8vv+er3Mg2FPksZF
 ntpj2RHe+IlmP9A589+VJo9wEiSa3/IWb4jF6GnZvMm3Br0xVbVFmZsbUYsCBTnWqcIh
 rQG0rHGergSQ9azR12rcD/fgbV0lveqyJTDTJxneMmr/XGWWhM7Yi/uedCLvbI3S/u0k
 q0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733960260; x=1734565060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/Mn/Kq2pCLPi33bMQOIuejS0tt/kGcgJxICKl7/0zU=;
 b=i9ya9BFCuTUD4sKpoi2cYz1equ9qnOwn3qr59KrFiSft9o22F48WMWJ16sKqaz3dUr
 wasBZLK1Qr52DhWs+G5bFNFgxzElVmQgOaUvmfUIzhjA0R4aeCuK75Cqww5YT30MrZv5
 bLMySu4qCYo5Ue+vj5PrhgdvjoT6npd5atPvqAR0ro6Da5qsknVZ53NrDNFWVU11q91m
 5qcVJDLhGFglK+wvXRXGYTvPjZW9iEBieCgiBhKfI8LtSxRWBrlNge6l+ZWFRTDOhlkt
 wjpoiYtzIq2uAu2TDZFImqVPT2quCJY8B9ohnAbMxd0l0k1xhrXfKrHPm6QXdsKtXfrp
 McLQ==
X-Gm-Message-State: AOJu0YwFQiFz+9z/1TQqQ5djp1yATCMT2LpdYJvhGMJXP53NxjwxG8gl
 SklpXvYYbtJG5RtOlX6UzhlUrlIHE5HsXKtuPlZf9j/52B12K2qlWWIyQZat8iMKlCT4QiNVama
 8
X-Gm-Gg: ASbGnctL0vro5gkjWdMoWT1px10SxL1f76kJqT3YEUIb1F97m/33Xvo6VcI/jnr0a7I
 IUFfYlFphPnbM/vpRZzyc38eJSOWNAeahxokGz6TP5me1LNls4pqSor/8wlHNTGc/CnTFpaNHpy
 S2KSZpxrHxUez7BfwBqvnhQiqg+JyXZYP6btIWcs0nRYn0TiDNb0ydlq4TLasqDpv7LrJhC+gP2
 opWqH+1R5dlc3FbBDjd0P/XPhFeDAKXcsAdfTNHgD0ANaqDOkieB/pbsiEj2mny5XPpxOM0vBZ4
 NNvj1Yhvo5pOa8bu5ZZjY/+Zv3pzLqZI9w==
X-Google-Smtp-Source: AGHT+IEjUy16v4ODfUXOmm/HhcPE1QIBbD3+NzBYGP5jSWtHjDj4NXd+ZY73zPE6AVqXth6Ss0RUjg==
X-Received: by 2002:a5d:6d89:0:b0:385:fd31:ca31 with SMTP id
 ffacd0b85a97d-387877dc573mr925530f8f.53.1733960260028; 
 Wed, 11 Dec 2024 15:37:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f521sm2342749f8f.16.2024.12.11.15.37.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:37:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bandan Das <bsd@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] qtest/fuzz: Remove uses of 'first_cpu'
Date: Thu, 12 Dec 2024 00:37:27 +0100
Message-ID: <20241211233727.98923-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211233727.98923-1-philmd@linaro.org>
References: <20241211233727.98923-1-philmd@linaro.org>
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

There is no vCPU within the QTest accelerator (well, they
are stubs doing nothing, see dummy_cpu_thread_fn).

Directly access the global &address_space_memory to reduce
access to the 'first_cpu' global (which is meaningless in
a heterogeneous emulation setup).

Cast the returned value to (void) to explicit we don't
care about invalid accesses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
We will likely remove &address_space_memory too, but one
global at a time. first_cpu is more annoying so I'm starting
with it.
---
 tests/qtest/fuzz/generic_fuzz.c   |  3 +-
 tests/qtest/fuzz/qtest_wrappers.c | 53 ++++++++++++++++---------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index d107a496da6..a72a3e99f7d 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -20,6 +20,7 @@
 #include "tests/qtest/libqos/pci-pc.h"
 #include "fuzz.h"
 #include "string.h"
+#include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ramblock.h"
 #include "hw/qdev-core.h"
@@ -239,7 +240,7 @@ void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr)
     MemoryRegion *mr1;
     while (len > 0) {
         l = len;
-        mr1 = address_space_translate(first_cpu->as,
+        mr1 = address_space_translate(&address_space_memory,
                                       addr, &addr1, &l, true,
                                       MEMTXATTRS_UNSPECIFIED);
 
diff --git a/tests/qtest/fuzz/qtest_wrappers.c b/tests/qtest/fuzz/qtest_wrappers.c
index 0580f8df860..a2d562dc7ed 100644
--- a/tests/qtest/fuzz/qtest_wrappers.c
+++ b/tests/qtest/fuzz/qtest_wrappers.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/cpu.h"
+#include "exec/address-spaces.h"
 #include "exec/ioport.h"
 
 #include "fuzz.h"
@@ -107,8 +108,8 @@ uint8_t __wrap_qtest_readb(QTestState *s, uint64_t addr)
 {
     uint8_t value;
     if (!serialize) {
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            &value, 1);
+        (void)address_space_read(&address_space_memory, addr,
+                                 MEMTXATTRS_UNSPECIFIED, &value, 1);
         return value;
     } else {
         return __real_qtest_readb(s, addr);
@@ -119,8 +120,8 @@ uint16_t __wrap_qtest_readw(QTestState *s, uint64_t addr)
 {
     uint16_t value;
     if (!serialize) {
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            &value, 2);
+        (void)address_space_read(&address_space_memory, addr,
+                                 MEMTXATTRS_UNSPECIFIED, &value, 2);
         return value;
     } else {
         return __real_qtest_readw(s, addr);
@@ -131,8 +132,8 @@ uint32_t __wrap_qtest_readl(QTestState *s, uint64_t addr)
 {
     uint32_t value;
     if (!serialize) {
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            &value, 4);
+        (void)address_space_read(&address_space_memory, addr,
+                                 MEMTXATTRS_UNSPECIFIED, &value, 4);
         return value;
     } else {
         return __real_qtest_readl(s, addr);
@@ -143,8 +144,8 @@ uint64_t __wrap_qtest_readq(QTestState *s, uint64_t addr)
 {
     uint64_t value;
     if (!serialize) {
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            &value, 8);
+        (void)address_space_read(&address_space_memory, addr,
+                                 MEMTXATTRS_UNSPECIFIED, &value, 8);
         return value;
     } else {
         return __real_qtest_readq(s, addr);
@@ -154,8 +155,8 @@ uint64_t __wrap_qtest_readq(QTestState *s, uint64_t addr)
 void __wrap_qtest_writeb(QTestState *s, uint64_t addr, uint8_t value)
 {
     if (!serialize) {
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            &value, 1);
+        (void)address_space_write(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, &value, 1);
     } else {
         __real_qtest_writeb(s, addr, value);
     }
@@ -164,8 +165,8 @@ void __wrap_qtest_writeb(QTestState *s, uint64_t addr, uint8_t value)
 void __wrap_qtest_writew(QTestState *s, uint64_t addr, uint16_t value)
 {
     if (!serialize) {
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            &value, 2);
+        (void)address_space_write(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, &value, 2);
     } else {
         __real_qtest_writew(s, addr, value);
     }
@@ -174,8 +175,8 @@ void __wrap_qtest_writew(QTestState *s, uint64_t addr, uint16_t value)
 void __wrap_qtest_writel(QTestState *s, uint64_t addr, uint32_t value)
 {
     if (!serialize) {
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            &value, 4);
+        (void)address_space_write(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, &value, 4);
     } else {
         __real_qtest_writel(s, addr, value);
     }
@@ -184,8 +185,8 @@ void __wrap_qtest_writel(QTestState *s, uint64_t addr, uint32_t value)
 void __wrap_qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
 {
     if (!serialize) {
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            &value, 8);
+        (void)address_space_write(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, &value, 8);
     } else {
         __real_qtest_writeq(s, addr, value);
     }
@@ -194,8 +195,8 @@ void __wrap_qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
 void __wrap_qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
 {
     if (!serialize) {
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                           size);
+        (void)address_space_read(&address_space_memory, addr,
+                                 MEMTXATTRS_UNSPECIFIED, data, size);
     } else {
         __real_qtest_memread(s, addr, data, size);
     }
@@ -204,8 +205,8 @@ void __wrap_qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
 void __wrap_qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
 {
     if (!serialize) {
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                           size);
+        (void)address_space_read(&address_space_memory, addr,
+                                 MEMTXATTRS_UNSPECIFIED, data, size);
     } else {
         __real_qtest_bufread(s, addr, data, size);
     }
@@ -215,8 +216,8 @@ void __wrap_qtest_memwrite(QTestState *s, uint64_t addr, const void *data,
                            size_t size)
 {
     if (!serialize) {
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            data, size);
+        (void)address_space_write(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, data, size);
     } else {
         __real_qtest_memwrite(s, addr, data, size);
     }
@@ -226,8 +227,8 @@ void __wrap_qtest_bufwrite(QTestState *s, uint64_t addr,
                     const void *data, size_t size)
 {
     if (!serialize) {
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            data, size);
+        (void)address_space_write(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, data, size);
     } else {
         __real_qtest_bufwrite(s, addr, data, size);
     }
@@ -239,8 +240,8 @@ void __wrap_qtest_memset(QTestState *s, uint64_t addr,
     if (!serialize) {
         data = malloc(size);
         memset(data, patt, size);
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                            data, size);
+        (void)address_space_write(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, data, size);
     } else {
         __real_qtest_memset(s, addr, patt, size);
     }
-- 
2.45.2


