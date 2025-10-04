Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F66ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wWD-0002xd-Bp; Sat, 04 Oct 2025 03:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUS-0001T0-Rp
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUQ-0005LZ-Hr
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so33594335e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562131; x=1760166931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J/dsfrCgDgsboYbRHkPVd69dbAQ7DCQxcmAFHhGXQcc=;
 b=mjhpJfOcA3qikbmKK0V6Je4kGGpc1OTsWkoVUq7yWJadw3SeF0l9N/69PB1d2NZLAv
 2QsgvrPV7XdoIr8k55YMtaES+UFIMUhHHEUbjV4bITjL1MpgSS5RhUVBmz1HvSXhSojQ
 DIWZZXRoILDHcBpBcPrev4UOfAQLl2Td2Ss8Qzr/P9wWnhfSrD25ogoRjhmPmPim1LMr
 tBf7G0+G6HuXIcZ3RfiyfhotBkWt3gKHpDV+Au1DzyB7c7d/vCl3A5ZbTULGgOX2qVqg
 YOE1Ur3vpCF34JKUQQOnbD/5Cvihxtw6Kha/q69WlBoAHGgPvFhWLwmw9nSW2bbCubdi
 YToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562131; x=1760166931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/dsfrCgDgsboYbRHkPVd69dbAQ7DCQxcmAFHhGXQcc=;
 b=Jcs74JowG9hFq81jqdh9ceG/v6CaxNBYxzU/yrjK/5xRmboIV9LRlw7G18U39xPjBd
 PpsDTABkkP+tkOIon3C6X0U8sTzgvBs40YwQv1WJAhet8uKaEpKCl4LSlmHpi4Z6xPs9
 7m/gOiRCB0YWIyB6ai0IL01NrHGna7SgGZ8Zj0F1Z0z6u6jBSoQSDEtVoQMLn3DGleum
 RqgImAP0K9376mAWcGIcUwG2ybr41phT2FFCNRSFS2V570iIxQYtDvDBK1mxx/DMit0n
 greX1NxChEiDrSVhoMoJF/4QbnFX5a+logKIA+KvMtlGLRLACKyNg/pWWbUTB4ROIPKi
 uS1A==
X-Gm-Message-State: AOJu0YzlZWDcVh0lZwGeB+k9V2Yq8FPOS06XbNaUkRc3CjUAaD6YEgPR
 mKEFPukcCnDLyN5rXZpRNb2bjg64PRKhctw8JkE7bVvu0jfaL5z5BgPtJvAsjoieS7AqYwtY5B3
 B/nyDaaM2Kw==
X-Gm-Gg: ASbGncvkCB7/VaA78U0XF4Pm2fmfozuPGeWJ77Pf8piYm+yhoZHwVVrU/TyZXclguyz
 qIQRflEeG2f0HGVIQPnhLzONFeUtceaI4NEefSOjGrb4yOAny7IocBpbNyW/YLieCugr0l5XNCR
 FLHFuXK31TT+Au5nqIImAKGybRZ8m67VHrqL8lvIBJJCss71AL5Oapu8vMfHpLSlKtIk8BzShsE
 qypveoXQcLPJ2qgonrR/Yjb4VMwGscdkymFUJAMefCxzfOL7oEf7Kz6XoS4U17QfCV/45XRXXrB
 Ezgq6Xd415uF9uJ5POmkBXf/MLgbvOcMhE7AN+dTCKmbI1e2kkPZCo7y0iRl/n6s409u8aOnZMK
 sE93iolyTo4ZPWQLDAOFVqhpaLPUXVYAii/sti2SovMKD1ukEVpfZPpInOvd58k4N2sSeLPC16p
 i8LDA5cnvnqqmXlGhmGnzTlXuQ
X-Google-Smtp-Source: AGHT+IHIiJZvoc5vnEJeFzKq+I46Erq3MMN5iCgZDS+00bFJMR8JH9QebyJMLB1oU+PcwaJyNP3IcQ==
X-Received: by 2002:a05:600c:4e01:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-46e711465d9mr37330725e9.29.1759562130596; 
 Sat, 04 Oct 2025 00:15:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234f547sm65183125e9.9.2025.10.04.00.15.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/41] system/physmem: Un-inline
 cpu_physical_memory_get_dirty_flag()
Date: Sat,  4 Oct 2025 09:12:56 +0200
Message-ID: <20251004071307.37521-31-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

cpu_physical_memory_get_dirty() doesn't involve any CPU,
remove the 'cpu_' prefix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-8-philmd@linaro.org>
---
 include/system/ram_addr.h | 46 +--------------------------------------
 system/physmem.c          | 44 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index f74a0ecee56..f8a307d1a3d 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -142,46 +142,6 @@ static inline void qemu_ram_block_writeback(RAMBlock *block)
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
-static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
-                                                 ram_addr_t length,
-                                                 unsigned client)
-{
-    DirtyMemoryBlocks *blocks;
-    unsigned long end, page;
-    unsigned long idx, offset, base;
-    bool dirty = false;
-
-    assert(client < DIRTY_MEMORY_NUM);
-
-    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page = start >> TARGET_PAGE_BITS;
-
-    WITH_RCU_READ_LOCK_GUARD() {
-        blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
-
-        idx = page / DIRTY_MEMORY_BLOCK_SIZE;
-        offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-        base = page - offset;
-        while (page < end) {
-            unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
-            unsigned long num = next - base;
-            unsigned long found = find_next_bit(blocks->blocks[idx],
-                                                num, offset);
-            if (found < num) {
-                dirty = true;
-                break;
-            }
-
-            page = next;
-            idx++;
-            offset = 0;
-            base += DIRTY_MEMORY_BLOCK_SIZE;
-        }
-    }
-
-    return dirty;
-}
-
 static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
                                                  ram_addr_t length,
                                                  unsigned client)
@@ -221,11 +181,7 @@ static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
     return dirty;
 }
 
-static inline bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr,
-                                                      unsigned client)
-{
-    return cpu_physical_memory_get_dirty(addr, 1, client);
-}
+bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
 
 static inline bool cpu_physical_memory_is_clean(ram_addr_t addr)
 {
diff --git a/system/physmem.c b/system/physmem.c
index 0ff7349fbbf..a8d201d7048 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -901,6 +901,50 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
     }
 }
 
+static bool physical_memory_get_dirty(ram_addr_t start, ram_addr_t length,
+                                      unsigned client)
+{
+    DirtyMemoryBlocks *blocks;
+    unsigned long end, page;
+    unsigned long idx, offset, base;
+    bool dirty = false;
+
+    assert(client < DIRTY_MEMORY_NUM);
+
+    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page = start >> TARGET_PAGE_BITS;
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
+
+        idx = page / DIRTY_MEMORY_BLOCK_SIZE;
+        offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+        base = page - offset;
+        while (page < end) {
+            unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
+            unsigned long num = next - base;
+            unsigned long found = find_next_bit(blocks->blocks[idx],
+                                                num, offset);
+            if (found < num) {
+                dirty = true;
+                break;
+            }
+
+            page = next;
+            idx++;
+            offset = 0;
+            base += DIRTY_MEMORY_BLOCK_SIZE;
+        }
+    }
+
+    return dirty;
+}
+
+bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client)
+{
+    return physical_memory_get_dirty(addr, 1, client);
+}
+
 /* Note: start and end must be within the same ram block.  */
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-- 
2.51.0


