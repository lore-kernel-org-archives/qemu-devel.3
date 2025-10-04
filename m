Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665C6CCA472
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wV7-0002MX-D7; Sat, 04 Oct 2025 03:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUi-0001xn-UU
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUg-0005N9-Lo
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso1975347f8f.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562148; x=1760166948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WF5Bt7esqOMLNtQooANTIYPWL9UFDgUZeAmTDtH6u04=;
 b=NencHNMZvCPddsj3w2rg2YlcH03HLw36vTt41RVdcQ81dDUI34zAFNalVciBtPiAab
 bA9aY9WkxjZxpgt7QIjUNKLOXzg7NK5jsg5tlEpRP3G3bE+hmmwIypgKYlZ77Wqu15nL
 SiyNiShWexbzvNcacbPfaVQt/BjoCiM8HCqi8t+olxWnrRzSzQyLxJ/YBZLg5EC0UZzX
 /lKnhX6U0R/zE5qWKZ++P/X9lkRfMeZiNYohkX4PDFasd6QTq9u2cKHUQqtMOrwe/l7+
 Q+J0gdrySbiVyYOogqMLLcpXwRm85BqDirRA4SF5XJXDyOBo60JC/DhYqdsNeKIHA4dv
 XU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562148; x=1760166948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WF5Bt7esqOMLNtQooANTIYPWL9UFDgUZeAmTDtH6u04=;
 b=Z7tU1UpBBtyMY6LHm44tZ+OJfgCtME5CkLbpqpoobViGBqAnnP23h5JxMhJo9r8dk1
 HAKMzyulpUIzuLHb/9tPUeqw/xYXQ1Z1PGLC4vhljpfbQoHr1Ku8IqvbKFi4IQ+kkH5Q
 JRdnjMLuDOPZgaG7xqz/rLQt5bzuhP/X/nnHJJIgdlEM7LKa+k84siBRVFL8jLB6zl8X
 r35Nn8eW87YnEydmuNkR8hA1N71SjKHTsA0rH/6jSevTdFdeSXpW9tt2dxSoUDkthIV0
 XwQyZFI8WAAANTYpudh+Fl+kEUOwSN/udKpzLf07Ls+SfEpqKabAQeEcGV0eHGXzgw4m
 nlMA==
X-Gm-Message-State: AOJu0YyosJ2Fm2Ng0/z7rhAz+XsIsFHmk4qf7CWI9g4Tq+zu+wjCjMJW
 HI36U2flAJbYD+2Bz7bWpOblnV6kYd+VDZbPCkJ6BaQ7ViezGg2nT2REn0mJY3b4jcu7gy75CJG
 QyMDKjDU9Fw==
X-Gm-Gg: ASbGncsEnvtAEJ22ZXgPwQFJ67pCTO1pZJAeDlrYOxHcGYffJ7Bq+KiVj7+CjiEvQWY
 YTsYPaeTygCX2UkcCzgRtsXHXGe9JksENoPbEb4J3mwWr+N/yX+JFlMOommp4FoWdl9Wzq9LBVH
 pjQ99969G7D8wc9rU2Te7cyj8tIxbAOS+r2+rcFdMntPZiuAPpbTllYdh4OMIwDKmg/qmyQNA0D
 Vza9daScpYTPeomvKFjyNvsVMLaloScpITaEoRHVzvLE8rZ+PDZnnABV04y+IF+D8h4TrSlcaon
 1LdE1aNlJfB/pA0NoFjACmCjsN7xNTWL5jVQRgn4+l0uTMiUxjtFChH1xflV5ZEJn1+AFkg9utf
 gOSX5iGJXs0uorrtKNvHQJXiBpT82Agj5jrh+vK+qkLGBgT3z3eDPo/YbXXMZpWyFfSuIMYzIME
 4Z36jAaTnNiOY7OjFaeznutOgt
X-Google-Smtp-Source: AGHT+IHkPi4cFFu567Y6AhVPPdKDM5rQScYh4s/y2rD6zEoXbRBsoZP2+8OMKz4Y5MGB6QSDNCvgGA==
X-Received: by 2002:a05:6000:2381:b0:3f4:8579:36b8 with SMTP id
 ffacd0b85a97d-42567193916mr3734894f8f.45.1759562148422; 
 Sat, 04 Oct 2025 00:15:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9719sm11262917f8f.31.2025.10.04.00.15.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/41] system/physmem: Un-inline
 cpu_physical_memory_set_dirty_range()
Date: Sat,  4 Oct 2025 09:13:00 +0200
Message-ID: <20251004071307.37521-35-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Avoid maintaining large functions in header, rely on the
linker to optimize at linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-12-philmd@linaro.org>
---
 include/system/ram_addr.h | 53 ++-------------------------------------
 system/physmem.c          | 51 +++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 81d26eb1492..ca5ae842442 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -152,57 +152,8 @@ uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
 
 void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
 
-static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
-                                                       ram_addr_t length,
-                                                       uint8_t mask)
-{
-    DirtyMemoryBlocks *blocks[DIRTY_MEMORY_NUM];
-    unsigned long end, page;
-    unsigned long idx, offset, base;
-    int i;
-
-    if (!mask && !xen_enabled()) {
-        return;
-    }
-
-    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page = start >> TARGET_PAGE_BITS;
-
-    WITH_RCU_READ_LOCK_GUARD() {
-        for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
-            blocks[i] = qatomic_rcu_read(&ram_list.dirty_memory[i]);
-        }
-
-        idx = page / DIRTY_MEMORY_BLOCK_SIZE;
-        offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-        base = page - offset;
-        while (page < end) {
-            unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
-
-            if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
-                bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks[idx],
-                                  offset, next - page);
-            }
-            if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
-                bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
-                                  offset, next - page);
-            }
-            if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
-                bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
-                                  offset, next - page);
-            }
-
-            page = next;
-            idx++;
-            offset = 0;
-            base += DIRTY_MEMORY_BLOCK_SIZE;
-        }
-    }
-
-    if (xen_enabled()) {
-        xen_hvm_modified_memory(start, length);
-    }
-}
+void cpu_physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
+                                         uint8_t mask);
 
 #if !defined(_WIN32)
 
diff --git a/system/physmem.c b/system/physmem.c
index 96d23630a12..8e6c6dddc3c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1032,6 +1032,57 @@ void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client)
     set_bit_atomic(offset, blocks->blocks[idx]);
 }
 
+void cpu_physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
+                                         uint8_t mask)
+{
+    DirtyMemoryBlocks *blocks[DIRTY_MEMORY_NUM];
+    unsigned long end, page;
+    unsigned long idx, offset, base;
+    int i;
+
+    if (!mask && !xen_enabled()) {
+        return;
+    }
+
+    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page = start >> TARGET_PAGE_BITS;
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
+            blocks[i] = qatomic_rcu_read(&ram_list.dirty_memory[i]);
+        }
+
+        idx = page / DIRTY_MEMORY_BLOCK_SIZE;
+        offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+        base = page - offset;
+        while (page < end) {
+            unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
+
+            if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks[idx],
+                                  offset, next - page);
+            }
+            if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
+                                  offset, next - page);
+            }
+            if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
+                                  offset, next - page);
+            }
+
+            page = next;
+            idx++;
+            offset = 0;
+            base += DIRTY_MEMORY_BLOCK_SIZE;
+        }
+    }
+
+    if (xen_enabled()) {
+        xen_hvm_modified_memory(start, length);
+    }
+}
+
 /* Note: start and end must be within the same ram block.  */
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-- 
2.51.0


