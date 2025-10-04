Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B429CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wUh-0001mh-2L; Sat, 04 Oct 2025 03:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUa-0001Wh-MD
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUY-0005ME-AG
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so22727125e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562139; x=1760166939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N1rIMdk5x26opdfLLDtgGIRHEYlRtV327JInj7x9O5U=;
 b=L/2x8QvE4VZkXsO9XLsbR75wJebz8aAfVCOz6mNKA5nwNntQXd1oSkCGImqKqCnmTL
 l5Fp0Df1O62asalr/IhdeR8uTe141aJTBvxsyMIcq+m5vnnaRSUbe4NzPZhllIx4bhOh
 b/gLrgBPN8VCYOZIRKa55ChCMt9XuuIS5c8AYjmE87/ocoHEHY/m7+Vq96gwpnTZOQzZ
 QaM3nvertOnApgJ8MxwzlPt3AkYP7qg11ZuCIvYOhZ/4k4g508sXNJJo15HmdB0G5Gvn
 zZNWNUtUaYOT0h6qjvXqI8GYQXNKgHrIESgJV2TefbSadwokdEL4QWI3QyiJFQFIClE6
 Qx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562139; x=1760166939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1rIMdk5x26opdfLLDtgGIRHEYlRtV327JInj7x9O5U=;
 b=Yv2zxavtwOgAGwnzrDB41v3C5f/MihYPAthNOWp1Mg62ejQFfRH6QRJXatovkfsGsb
 GQQ9c14l3T7eILMsLxCZ7Zpm7CqTgd1mJwAY/VRF/RNsIK86s0eLH4p7JRYk4Vm5GjeJ
 Bf8T6kZzrkNfHj0TWq8jjQfGIDQ5Yn/pEBGR+YX0LnTdSiACsKbdsYA4BSlxfidOYKNX
 QaUMG9Zx2gze2sb59LHQWxvdlm/NOqzPxYcNcOq9mYPAMfU27rz0t9eEfr69LhFAwFfo
 yNXADKALh0gp4kd53GinkA4RSqs5KDSGH9TkHUt5HaUNKy2aB1BhUMObwLkmGGXhL4Id
 yHSw==
X-Gm-Message-State: AOJu0Yw4qySwq7L+ffAKfS8B7mF7U26Fb+RrDtkmdaZ6hBlzMvQS4nXd
 vZZZlp4E+s7OL1rsMY5CeiGXENWDm2tNo6NrdXMdQtuVGtfna/Huoq/jtAuIis/jTxqWGmWqZfA
 gNtMppOWvhQ==
X-Gm-Gg: ASbGnctA5fjdNWB2oXqaB/jeigSdMRKmCpWuacykvgLc0np/sJwo16V8bczcHYKZqyA
 xvyGcAPo3smgU0wPSJ3xTGnksfu6WmYMNPY2/13EHR2hTeANPQOJeJL/YpAtzVAQ6Qtpo2peIUi
 PGG8oX+LJAwX7ZmvcSTcD/Xa/8nyeG8vBilfVGPxrTAWarPTJhlSrF5KS+4Mvd5/UtCJXvsUZuj
 JA0UUWfwWR6SniMk+OmaYlMnmF+vFPOQcPG3rbr6b9KzBzylLv0f2RExRUewrOAYyl4IXAAP8oA
 7VzGgJ6InoT7qpxOkH7nIJiYzXcWDqySKr+fjWp1M51rAoGb106RUrtCBqH5jls13VQEAPM1edq
 8v5ELWrFGfkvgdhcGrScYgK/hIebgr2YLSne2I6aSvrs2gNnV8YRCWj87k+OJCMcJ9Y9+10NQV7
 tysRb8vlpIMvAOG5LItH1YVjjPVJlVf6Hkqu0=
X-Google-Smtp-Source: AGHT+IEtmQ+HborJkBafpVNPtA7PNhjxWb2C/ZgW1HSLqijf4qzMsZREUoIkH7u9uvVtOnr/3B6bqg==
X-Received: by 2002:a05:600c:3b08:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-46e71101a79mr41519025e9.6.1759562139478; 
 Sat, 04 Oct 2025 00:15:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72374ac5sm71057335e9.18.2025.10.04.00.15.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/41] system/physmem: Un-inline
 cpu_physical_memory_range_includes_clean()
Date: Sat,  4 Oct 2025 09:12:58 +0200
Message-ID: <20251004071307.37521-33-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

cpu_physical_memory_all_dirty() doesn't involve any CPU,
remove the 'cpu_' prefix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-10-philmd@linaro.org>
---
 include/system/ram_addr.h | 62 ++-------------------------------------
 system/physmem.c          | 60 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 59 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index cdf25c315be..2dcca260b2b 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -142,69 +142,13 @@ static inline void qemu_ram_block_writeback(RAMBlock *block)
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
-static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
-                                                 ram_addr_t length,
-                                                 unsigned client)
-{
-    DirtyMemoryBlocks *blocks;
-    unsigned long end, page;
-    unsigned long idx, offset, base;
-    bool dirty = true;
-
-    assert(client < DIRTY_MEMORY_NUM);
-
-    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page = start >> TARGET_PAGE_BITS;
-
-    RCU_READ_LOCK_GUARD();
-
-    blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
-
-    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
-    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-    base = page - offset;
-    while (page < end) {
-        unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
-        unsigned long num = next - base;
-        unsigned long found = find_next_zero_bit(blocks->blocks[idx], num, offset);
-        if (found < num) {
-            dirty = false;
-            break;
-        }
-
-        page = next;
-        idx++;
-        offset = 0;
-        base += DIRTY_MEMORY_BLOCK_SIZE;
-    }
-
-    return dirty;
-}
-
 bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
 
 bool cpu_physical_memory_is_clean(ram_addr_t addr);
 
-static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
-                                                               ram_addr_t length,
-                                                               uint8_t mask)
-{
-    uint8_t ret = 0;
-
-    if (mask & (1 << DIRTY_MEMORY_VGA) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA)) {
-        ret |= (1 << DIRTY_MEMORY_VGA);
-    }
-    if (mask & (1 << DIRTY_MEMORY_CODE) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)) {
-        ret |= (1 << DIRTY_MEMORY_CODE);
-    }
-    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATION)) {
-        ret |= (1 << DIRTY_MEMORY_MIGRATION);
-    }
-    return ret;
-}
+uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
+                                                 ram_addr_t length,
+                                                 uint8_t mask);
 
 static inline void cpu_physical_memory_set_dirty_flag(ram_addr_t addr,
                                                       unsigned client)
diff --git a/system/physmem.c b/system/physmem.c
index fb6a7378ff7..2667f289044 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -954,6 +954,66 @@ bool cpu_physical_memory_is_clean(ram_addr_t addr)
     return !(vga && code && migration);
 }
 
+static bool physical_memory_all_dirty(ram_addr_t start, ram_addr_t length,
+                                      unsigned client)
+{
+    DirtyMemoryBlocks *blocks;
+    unsigned long end, page;
+    unsigned long idx, offset, base;
+    bool dirty = true;
+
+    assert(client < DIRTY_MEMORY_NUM);
+
+    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page = start >> TARGET_PAGE_BITS;
+
+    RCU_READ_LOCK_GUARD();
+
+    blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
+
+    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
+    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+    base = page - offset;
+    while (page < end) {
+        unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
+        unsigned long num = next - base;
+        unsigned long found = find_next_zero_bit(blocks->blocks[idx],
+                                                 num, offset);
+        if (found < num) {
+            dirty = false;
+            break;
+        }
+
+        page = next;
+        idx++;
+        offset = 0;
+        base += DIRTY_MEMORY_BLOCK_SIZE;
+    }
+
+    return dirty;
+}
+
+uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
+                                                 ram_addr_t length,
+                                                 uint8_t mask)
+{
+    uint8_t ret = 0;
+
+    if (mask & (1 << DIRTY_MEMORY_VGA) &&
+        !physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA)) {
+        ret |= (1 << DIRTY_MEMORY_VGA);
+    }
+    if (mask & (1 << DIRTY_MEMORY_CODE) &&
+        !physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)) {
+        ret |= (1 << DIRTY_MEMORY_CODE);
+    }
+    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
+        !physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATION)) {
+        ret |= (1 << DIRTY_MEMORY_MIGRATION);
+    }
+    return ret;
+}
+
 /* Note: start and end must be within the same ram block.  */
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-- 
2.51.0


