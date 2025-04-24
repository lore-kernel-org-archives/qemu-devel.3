Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7806CC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u837V-0008Cd-Av; Thu, 24 Apr 2025 16:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837P-0008Bx-9p
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837N-0004yz-0T
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso6871755e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526259; x=1746131059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3lVw6KIn3D7NgOMBRI5zDO2652ucdToVqyJMqAEbX4=;
 b=nEcnab2IpQFDa3A6+v12Xf/nTLAUTA2SmBFiQHocFfimEfXwvPZ13Dxms6C/X2Vt1n
 MlI/VAtMpwKH+nOP+eQSIHtkyyXKUIw0E3PlGLaLq/G022N7Mjd+LlVmAxFYAh7Yxxnm
 t7XUta6wOB12KueQ2wJd6jM97MG6caX/G2xQ2diQZVAi7RBt/mhW/pKghGEQ4hGGj66c
 TWtgiVjP3938uY6nB41i/UsGJSqU2by+TlcQtV6sJenaL8zneKWjzfBVcKqNZ7bKvViD
 wsEiWuk1IuI4BrviRaSlYfnJjj0sm/YBmry8erULO3u64OFb5uWxEyyCFnj4ZmUFEwDb
 zEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526259; x=1746131059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3lVw6KIn3D7NgOMBRI5zDO2652ucdToVqyJMqAEbX4=;
 b=LUkZWd86o0+8UbV6LXZchWp8A/eEfOc3fT4depYacFX5xzqD6o9tsqD8ZoC4/IDnic
 as5Ly3g8O1DCu1jZtXaAbbWBtnY/tdArvpcZP7fdd3NwTypTChuVhJf2Hyebe/Q7v/+f
 vs5HSpEC6eYIreWwnrMdlyOGqKt5E3vzchGJEM3SY+b1zgOZ/YTmhLlZPLn4b4D9WBIM
 lAUepGnd3qWGzvXUzf6FP4vTGOZdQrO2QJSNw5PzbpBLniqTYMZ/KpFpEnnPF3/wRRpM
 VdqTSSIVbSLRYwXs8oqgUdXn45FzZwyKiKGNDcpsgujcgOED+PPtHhkuXwpEQxpdFX+I
 i/hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX75ApQ94JYMQhMh1OyrgDtRA/hpm8cUqVstxmdp2DIh6BYP9DkpnjRwlr3rmAKl5KPaA4NkYDXABZp@nongnu.org
X-Gm-Message-State: AOJu0YxUxXCbmGjs7YtcJFXehxjUvfmS95Vpyzfmb/0Wh6+fAyDfyDvU
 k+4pN+D4rC5vM9wWPH5qQ6iqL96wmnmiYiXbGC8pYCiiJGzCa/tPMG87U4pfb2s=
X-Gm-Gg: ASbGncu5H79gPYNqYkr8llzociXv2jfS+K856LZOdEnnIoFWf9b2gASU8qe5gCibs01
 3EsVcWhqyl47pL6tUj2pk9O5rFYs/pKKszWvxiKU1XBdE3Pa3iZtKFao3QBM70NELHH1tZbc01I
 Xle6EeG996wgonGXTbzMldbh/iwr5GY0nwdxKcpG/OjR6DKnL7Sl6pyWQfk+E/gYZB1hc6VmbY0
 juzFhL+6/CUFlvsco74Kh/bkAUyT6PIsQ/TOmrO4j1coPYBftlo4Dcylee3VXVKsXm4wK2guzXt
 S+capeouNqiwLnEjPfWdDXsDlBcW1SWB5nRn5HLPWMj6unPEl69vkPZaKgB1kco7iCL2IECeb6o
 Z6v9HRd+WYOUSjeQ=
X-Google-Smtp-Source: AGHT+IEz9b+gcPjY9cJkB/xLgeEZGP8GawUo1yGz/gmAVrGjKW101y29AV4vHQti8FafaQk3+7McnQ==
X-Received: by 2002:a05:600c:3496:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-4409bd18487mr40783235e9.14.1745526259237; 
 Thu, 24 Apr 2025 13:24:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a530324dsm833685e9.10.2025.04.24.13.24.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:24:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/13] accel/tcg: Use vaddr for walk_memory_regions callback
Date: Thu, 24 Apr 2025 22:24:00 +0200
Message-ID: <20250424202412.91612-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Use vaddr instead of target_ulong.  At the same time,
use int instead of unsigned long for flags, to match
page_set_flags().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250424011918.599958-13-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/user/page-protection.h |  5 ++---
 accel/tcg/user-exec.c          | 10 +++++-----
 linux-user/elfload.c           | 19 +++++++++----------
 linux-user/syscall.c           |  8 ++++----
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 1de72e31e68..8f0b769b134 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -14,6 +14,7 @@
 
 #include "cpu-param.h"
 #include "exec/target_long.h"
+#include "exec/vaddr.h"
 #include "exec/translation-block.h"
 
 int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc);
@@ -88,9 +89,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
 __attribute__((returns_nonnull))
 void *page_get_target_data(target_ulong address);
 
-typedef int (*walk_memory_regions_fn)(void *, target_ulong,
-                                      target_ulong, unsigned long);
-
+typedef int (*walk_memory_regions_fn)(void *, vaddr, vaddr, int);
 int walk_memory_regions(void *, walk_memory_regions_fn);
 
 void page_dump(FILE *f);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 17e3be337f5..25d86567e70 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -199,13 +199,13 @@ int walk_memory_regions(void *priv, walk_memory_regions_fn fn)
     return rc;
 }
 
-static int dump_region(void *priv, target_ulong start,
-                       target_ulong end, unsigned long prot)
+static int dump_region(void *opaque, vaddr start, vaddr end, int prot)
 {
-    FILE *f = (FILE *)priv;
+    FILE *f = opaque;
 
-    fprintf(f, TARGET_FMT_lx"-"TARGET_FMT_lx" "TARGET_FMT_lx" %c%c%c\n",
-            start, end, end - start,
+    fprintf(f, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
+            " " TARGET_ABI_FMT_ptr " %c%c%c\n",
+            (abi_ptr)start, (abi_ptr)end, (abi_ptr)(end - start),
             ((prot & PAGE_READ) ? 'r' : '-'),
             ((prot & PAGE_WRITE) ? 'w' : '-'),
             ((prot & PAGE_EXEC) ? 'x' : '-'));
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7519b6bcda3..e281745e485 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4044,8 +4044,7 @@ static inline void bswap_note(struct elf_note *en) { }
 /*
  * Calculate file (dump) size of given memory region.
  */
-static size_t vma_dump_size(target_ulong start, target_ulong end,
-                            unsigned long flags)
+static size_t vma_dump_size(vaddr start, vaddr end, int flags)
 {
     /* The area must be readable. */
     if (!(flags & PAGE_READ)) {
@@ -4238,8 +4237,8 @@ static int dump_write(int fd, const void *ptr, size_t size)
     return (0);
 }
 
-static int wmr_page_unprotect_regions(void *opaque, target_ulong start,
-                                      target_ulong end, unsigned long flags)
+static int wmr_page_unprotect_regions(void *opaque, vaddr start,
+                                      vaddr end, int flags)
 {
     if ((flags & (PAGE_WRITE | PAGE_WRITE_ORG)) == PAGE_WRITE_ORG) {
         size_t step = MAX(TARGET_PAGE_SIZE, qemu_real_host_page_size());
@@ -4260,8 +4259,8 @@ typedef struct {
     size_t size;
 } CountAndSizeRegions;
 
-static int wmr_count_and_size_regions(void *opaque, target_ulong start,
-                                      target_ulong end, unsigned long flags)
+static int wmr_count_and_size_regions(void *opaque, vaddr start,
+                                      vaddr end, int flags)
 {
     CountAndSizeRegions *css = opaque;
 
@@ -4275,8 +4274,8 @@ typedef struct {
     off_t offset;
 } FillRegionPhdr;
 
-static int wmr_fill_region_phdr(void *opaque, target_ulong start,
-                                target_ulong end, unsigned long flags)
+static int wmr_fill_region_phdr(void *opaque, vaddr start,
+                                vaddr end, int flags)
 {
     FillRegionPhdr *d = opaque;
     struct elf_phdr *phdr = d->phdr;
@@ -4298,8 +4297,8 @@ static int wmr_fill_region_phdr(void *opaque, target_ulong start,
     return 0;
 }
 
-static int wmr_write_region(void *opaque, target_ulong start,
-                            target_ulong end, unsigned long flags)
+static int wmr_write_region(void *opaque, vaddr start,
+                            vaddr end, int flags)
 {
     int fd = *(int *)opaque;
     size_t size = vma_dump_size(start, end, flags);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5826ac3adbb..23b901b7133 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8135,8 +8135,8 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
  * Callback for walk_memory_regions, when read_self_maps() fails.
  * Proceed without the benefit of host /proc/self/maps cross-check.
  */
-static int open_self_maps_3(void *opaque, target_ulong guest_start,
-                            target_ulong guest_end, unsigned long flags)
+static int open_self_maps_3(void *opaque, vaddr guest_start,
+                            vaddr guest_end, int flags)
 {
     static const MapInfo mi = { .is_priv = true };
 
@@ -8147,8 +8147,8 @@ static int open_self_maps_3(void *opaque, target_ulong guest_start,
 /*
  * Callback for walk_memory_regions, when read_self_maps() succeeds.
  */
-static int open_self_maps_2(void *opaque, target_ulong guest_start,
-                            target_ulong guest_end, unsigned long flags)
+static int open_self_maps_2(void *opaque, vaddr guest_start,
+                            vaddr guest_end, int flags)
 {
     const struct open_self_maps_data *d = opaque;
     uintptr_t host_start = (uintptr_t)g2h_untagged(guest_start);
-- 
2.47.1


