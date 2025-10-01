Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF523CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s8J-0001yG-Hl; Wed, 01 Oct 2025 04:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s82-0001fc-Tk
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s7C-0006G3-PT
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e5b7dfeb0so8564425e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306981; x=1759911781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOqPvVAdOz/3hFjUsdAFf2tJOS39s9qPYq5sN81Yu4U=;
 b=VpFDDgi3E9BuE06VArKCx00Yo1D/Zuv/Ofp6SxSnF8b/UUosLq3gl4ihgYYtBeLSzp
 TdS3Zw8wOJY2gh17PAqtJUkfd2CRtPLljOkREFIrILK+SiHYEPgJsBpscW+tMXm7EYV5
 m6PUo9jMIdEHbc+o7+PyEuAqg2oh7nTtRHSBtsU4Yl7ZGbipJb+pMqkXpGiFxO7Mcx4d
 vzsiGUmooD8eI1bJJPbf00ne5rThmzqXNL5cn2qNovoAqoN0Q1TTG7WZ0n30qTTQi22h
 Ko67yWHFaZRgZukStKvsl3iYQof6aaMQ/+9JIblN7epDrQyJg/UzSBtvLhBO4cUgD9ZQ
 LbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306981; x=1759911781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HOqPvVAdOz/3hFjUsdAFf2tJOS39s9qPYq5sN81Yu4U=;
 b=IJC7iMhdYde+4rjZuwKGX+yJNTdcv7tjCtsRTgZeZAof5Q/Ucg1CgvrYRQMc2SoFXt
 RDcBAADl30pzkI/pgpwL0aVREXk/PXEFDM5XVqcTmrQxlToNtEuaQ+U9mWEPz/dC/eLK
 8wcvD4I/yPD3TYCrQBdYL4eqL3tFBZnCGtwnyjXKrYGRQ1dflhG3PykWTEOuW5H8rBiB
 WNX32MfnqBtkFOzg5UZ29GT1/eDDsS0ZoRcneF8izQHFfhae7h2ryuN7u9BZFWgnCoNy
 cmWurDiftx/XwSk92iJsRPfoTzmY4Sx71/ff9C3T6XpaPqBWPj1UQTHfCKkFnrwCENnw
 XCPQ==
X-Gm-Message-State: AOJu0Yztem7SDp52PR8Ri/KKFi2QnmWic5cE/pKi9XqI0EzmDw7k82dB
 XAvkQdWOb3GDJ26MmxLOobmtIicmVe4Q4aWsB3I5uygrQ6EMJ8p8GEM1sz2bCoohd0KQKOUqYE+
 Ln7k/oTCkZw==
X-Gm-Gg: ASbGncufw0rG/PuuSBP1z3R/22cXhl2spK0DQAcTMTD/8wYzQm3hGXh7auX7x7uilue
 vuCU6A1GxG50sCA4O7l8f4AFAWbOt7Zz8Dpt2AoLihGQ50YP+CmPQ9l5FeWmIRpylGXk/xfkFTg
 pdlfwpdL0YBO0cLN9M4BmQHoxAcu0X4UxUKSI/NlM8w08lI76j5Im6QcQw0jTId77ebN6aEj+jr
 WA6EUghlrQ3lbYNLQUSiXXsTCLAxjLQk2+qhmLu4ykAUbRmA3k+DE7djolQWtKZftBm0pzbJ4TZ
 H2ggrhUxYqMqYZlmtN45Cy/kPs5Vmo69Z1wxhJgzML99Ih68YWXcjJz8Mf93VTJJ46UOAHT9ijD
 /oJ13zUHTMyQIbS/pLONPvUMiaxDgw38CKXE6bN1VTJHjYsG5gawN+xAwr2Z4I/uncKPFUEAqYF
 rkA5sy5SIK4HZm+J+qTfBj
X-Google-Smtp-Source: AGHT+IEfJgBTWJXo/xTm4FeZN+2Or//riROV16Lac62nDF49jLqWqoeqFpWnxe66gIQZozq8Gvzg1w==
X-Received: by 2002:a05:600c:3b22:b0:46e:36fa:6b40 with SMTP id
 5b1f17b1804b1-46e612baa03mr22761255e9.24.1759306981243; 
 Wed, 01 Oct 2025 01:23:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b9c88sm28154505e9.22.2025.10.01.01.22.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:23:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 17/25] system/physmem: Un-inline
 cpu_physical_memory_set_dirty_range()
Date: Wed,  1 Oct 2025 10:21:17 +0200
Message-ID: <20251001082127.65741-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Avoid maintaining large functions in header, rely on the
linker to optimize at linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ram_addr.h | 53 ++-------------------------------------
 system/physmem.c          | 51 +++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 84a8b5c003d..6377dd19a2f 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -152,57 +152,8 @@ uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t addr,
 
 void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
 
-static inline void cpu_physical_memory_set_dirty_range(ram_addr_t addr,
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
-    end = TARGET_PAGE_ALIGN(addr + length) >> TARGET_PAGE_BITS;
-    page = addr >> TARGET_PAGE_BITS;
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
-        xen_hvm_modified_memory(addr, length);
-    }
-}
+void cpu_physical_memory_set_dirty_range(ram_addr_t addr, ram_addr_t length,
+                                         uint8_t mask);
 
 #if !defined(_WIN32)
 
diff --git a/system/physmem.c b/system/physmem.c
index cb0efbeabb2..383aecb391f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1033,6 +1033,57 @@ void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client)
     set_bit_atomic(offset, blocks->blocks[idx]);
 }
 
+void cpu_physical_memory_set_dirty_range(ram_addr_t addr, ram_addr_t length,
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
+    end = TARGET_PAGE_ALIGN(addr + length) >> TARGET_PAGE_BITS;
+    page = addr >> TARGET_PAGE_BITS;
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
+        xen_hvm_modified_memory(addr, length);
+    }
+}
+
 /* Note: start and end must be within the same ram block.  */
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-- 
2.51.0


