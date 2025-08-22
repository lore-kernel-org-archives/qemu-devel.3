Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B02CCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 13:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSDa-00062J-Ca; Fri, 22 Aug 2025 09:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1l-0005uG-OC
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1g-0007DG-N6
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-24457f581aeso14254775ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1755854734; x=1756459534;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R20a+AC/qNPmE0yIiAxw+Sd4sMt8EwUMqbCQvSGoLUU=;
 b=Cbc+DdP+nEw/Z6cIzsFTlJMbgJyMUx2SeE9Kh1TTgzEbOrfnzfzNpb8JvymWyEP2kX
 RNNE3l+sOLv4F4FC/U9t97hHoaToOVIoyfCFb0OBQbdF9Kv6hXjEHQA4QP2ttExp+TUB
 7wErscJMU48F4H49T1pH9NiL0sg3LZwBI7i+pMSRY+82o5Cnx7sMys95WJN7qiwjayFF
 aaB38Q2f1vWrmj6AOWopmvsLZA7zZ7wm+R2XYBGrVgxFWhyZXcYCoyeNkJOpyLlo/lvC
 7M0DtAqs7Yw1kDi5qEjw+HQLYHgEDubkmq2gXdTTDPECVe0kWJXgPm0jt17UcIGrQ2xs
 TO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755854734; x=1756459534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R20a+AC/qNPmE0yIiAxw+Sd4sMt8EwUMqbCQvSGoLUU=;
 b=L8gc5k6JTaUVSOzrReobPAH60ElatzwKc6bDmcn2I6Pd93UDpmRYGDdcAEWLfSX829
 i1BUohZdvZyOHYcJrSSNEjLgWZygRhA6YI6Pbj0jhr6NoSB4IE7sTkE9aGrm+ieVRNWn
 AlWA1mr1Qn0ZW7nFFN+5iNR9fJ7ZNcBMhrTgCoh5n16vgfUwoW7OCvsGA9ZMZoEnG5/E
 m5gzYhGzTV4cxA3u6GJhOVjNjTVJ8KFFn+/AUTkLj0J0xdsm1sjRL4tm3TqNV1MRUITM
 nLeLP/Hm1rwRGppo30VN/JbN7tdYLxC0617YgjG66OZHbVO8pdBci/DgcMFqEmq83hjA
 idFg==
X-Gm-Message-State: AOJu0Yw+nPJfAZS9/lerl9LY+AKtsb++ajsnoYwPqB9zHbmoCMd5jWB5
 9Gwds7OQttkeG2iS7QDyufTD7LLsiIo2x7Tz0QrEkc2phQX6eVTSz7QaPb7TsJHkajUQsAZ9DRr
 NHY9pQTQ=
X-Gm-Gg: ASbGnctlq1lbXeJqZgeNR7FKoL/yvsTy18tnSrGxn1Ym8BgN75EIROkMU59rWHJW5ZA
 iV1e1t3QKHbs23UWq9szc/t8WHgerZceSUHZcLxeDdgGi0/x4vwLrddZ/pI6rpVbEFgIzKM5RW+
 9lwBb4/gYuedpwn0QnOtsfMpdxX/guq/+UKI9nNKNtgPDkK/GnXvcWVC284xoo3wE0bNqxxG78n
 bFDWWdrmeshZQToYOC6K8ZKjekzAkuFneBp4chlP/8+I59rSfUj29UsCkJXkpVAowr5lB8Zk5HK
 RqoRBTscwI27rVT7m1JDukyOBKQFVo1Tpk3MOqUM67RPs+hTAlEEH2/JoMbkWq2pfL2j8dO9wj7
 GtoSW3VT6hyOOW5w2F4LH4EvWTS8v/dZzjQNSEv/jKJ3KSP3lUuLzzs46N6F1YT0=
X-Google-Smtp-Source: AGHT+IFnOQkuYNR3us3g/t0v9sCtLB39/Rrvw8wAMw0jAQ9pIcZSj3GKQCggiTQjqnu34PL16LXtbQ==
X-Received: by 2002:a17:903:24d:b0:243:3fe:4294 with SMTP id
 d9443c01a7336-2462ee0bf56mr36122615ad.12.1755854733604; 
 Fri, 22 Aug 2025 02:25:33 -0700 (PDT)
Received: from warg.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed4c6fb7sm78560215ad.89.2025.08.22.02.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 02:25:33 -0700 (PDT)
From: CJ Chen <cjchen@igel.co.jp>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, CJ Chen <cjchen@igel.co.jp>
Subject: [RFC PATCH v2 5/9] system/memory: support unaligned access
Date: Fri, 22 Aug 2025 18:24:06 +0900
Message-Id: <20250822092410.25833-6-cjchen@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822092410.25833-1-cjchen@igel.co.jp>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=cjchen@igel.co.jp; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 Aug 2025 09:53:58 -0400
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

From: Tomoyuki Hirose <hrstmyk811m@gmail.com>

The previous code ignored 'impl.unaligned' and handled unaligned
accesses as-is. But this implementation could not emulate specific
registers of some devices that allow unaligned access such as xHCI
Host Controller Capability Registers.

This commit emulates an unaligned access with multiple aligned
accesses. Additionally, the overwriting of the max access size is
removed to retrieve the actual max access size.

Based-on-a-patch-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
Signed-off-by: CJ Chen <cjchen@igel.co.jp>
Tested-by: CJ Chen <cjchen@igel.co.jp>
Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
---
 system/memory.c  | 147 ++++++++++++++++++++++++++++++++++++++---------
 system/physmem.c |   8 ---
 2 files changed, 119 insertions(+), 36 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 63b983efcd..d6071b4414 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -509,27 +509,118 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
     return mr->ops->write_with_attrs(mr->opaque, addr, tmp, size, attrs);
 }
 
+typedef MemTxResult (*MemoryRegionAccessFn)(MemoryRegion *mr,
+                                            hwaddr addr,
+                                            uint64_t *value,
+                                            unsigned size,
+                                            signed shift,
+                                            uint64_t mask,
+                                            MemTxAttrs attrs);
+
+static MemTxResult access_emulation(hwaddr addr,
+                                    uint64_t *value,
+                                    unsigned int size,
+                                    unsigned int access_size_min,
+                                    unsigned int access_size_max,
+                                    MemoryRegion *mr,
+                                    MemTxAttrs attrs,
+                                    MemoryRegionAccessFn access_fn_read,
+                                    MemoryRegionAccessFn access_fn_write,
+                                    bool is_write)
+{
+    hwaddr a;
+    uint8_t *d;
+    uint64_t v;
+    MemTxResult r = MEMTX_OK;
+    bool is_big_endian = devend_big_endian(mr->ops->endianness);
+    void (*store)(void *, int, uint64_t) = is_big_endian ? stn_be_p : stn_le_p;
+    uint64_t (*load)(const void *, int) = is_big_endian ? ldn_be_p : ldn_le_p;
+    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
+    uint64_t access_mask = MAKE_64BIT_MASK(0, access_size * 8);
+    hwaddr round_down = mr->ops->impl.unaligned && addr + size <= mr->size ?
+        0 : addr % access_size;
+    hwaddr start = addr - round_down;
+    hwaddr tail = addr + size <= mr->size ? addr + size : mr->size;
+    uint8_t data[16] = {0};
+    g_assert(size <= 8);
+
+    for (a = start, d = data, v = 0; a < tail;
+         a += access_size, d += access_size, v = 0) {
+        r |= access_fn_read(mr, a, &v, access_size, 0, access_mask,
+                            attrs);
+        store(d, access_size, v);
+    }
+    if (is_write) {
+        stn_he_p(&data[round_down], size, load(value, size));
+        for (a = start, d = data; a < tail;
+             a += access_size, d += access_size) {
+            v = load(d, access_size);
+            r |= access_fn_write(mr, a, &v, access_size, 0, access_mask,
+                                 attrs);
+        }
+    } else {
+        store(value, size, ldn_he_p(&data[round_down], size));
+    }
+
+    return r;
+}
+
+static bool is_access_fastpath(hwaddr addr,
+                               unsigned int size,
+                               unsigned int access_size_min,
+                               unsigned int access_size_max,
+                               MemoryRegion *mr)
+{
+    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
+    hwaddr round_down = mr->ops->impl.unaligned && addr + size <= mr->size ?
+        0 : addr % access_size;
+
+    return round_down == 0 && access_size <= size;
+}
+
+static MemTxResult access_fastpath(hwaddr addr,
+                                   uint64_t *value,
+                                   unsigned int size,
+                                   unsigned int access_size_min,
+                                   unsigned int access_size_max,
+                                   MemoryRegion *mr,
+                                   MemTxAttrs attrs,
+                                   MemoryRegionAccessFn fastpath)
+{
+    MemTxResult r = MEMTX_OK;
+    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
+    uint64_t access_mask = MAKE_64BIT_MASK(0, access_size * 8);
+
+    if (devend_big_endian(mr->ops->endianness)) {
+        for (size_t i = 0; i < size; i += access_size) {
+            r |= fastpath(mr, addr + i, value, access_size,
+                          (size - access_size - i) * 8, access_mask, attrs);
+        }
+    } else {
+        for (size_t i = 0; i < size; i += access_size) {
+            r |= fastpath(mr, addr + i, value, access_size,
+                          i * 8, access_mask, attrs);
+        }
+    }
+
+    return r;
+}
+
 static MemTxResult access_with_adjusted_size(hwaddr addr,
                                       uint64_t *value,
                                       unsigned size,
                                       unsigned access_size_min,
                                       unsigned access_size_max,
-                                      MemTxResult (*access_fn)
-                                                  (MemoryRegion *mr,
-                                                   hwaddr addr,
-                                                   uint64_t *value,
-                                                   unsigned size,
-                                                   signed shift,
-                                                   uint64_t mask,
-                                                   MemTxAttrs attrs),
+                                      MemoryRegionAccessFn access_fn_read,
+                                      MemoryRegionAccessFn access_fn_write,
+                                      bool is_write,
                                       MemoryRegion *mr,
                                       MemTxAttrs attrs)
 {
-    uint64_t access_mask;
-    unsigned access_size;
-    unsigned i;
     MemTxResult r = MEMTX_OK;
     bool reentrancy_guard_applied = false;
+    MemoryRegionAccessFn access_fn_fastpath =
+        is_write ? access_fn_write : access_fn_read;
 
     if (!access_size_min) {
         access_size_min = 1;
@@ -551,20 +642,16 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
         reentrancy_guard_applied = true;
     }
 
-    /* FIXME: support unaligned access? */
-    access_size = MAX(MIN(size, access_size_max), access_size_min);
-    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
-    if (devend_big_endian(mr->ops->endianness)) {
-        for (i = 0; i < size; i += access_size) {
-            r |= access_fn(mr, addr + i, value, access_size,
-                        (size - access_size - i) * 8, access_mask, attrs);
-        }
+    if (is_access_fastpath(addr, size, access_size_min, access_size_max, mr)) {
+        r |= access_fastpath(addr, value, size,
+                             access_size_min, access_size_max, mr, attrs,
+                             access_fn_fastpath);
     } else {
-        for (i = 0; i < size; i += access_size) {
-            r |= access_fn(mr, addr + i, value, access_size, i * 8,
-                        access_mask, attrs);
-        }
+        r |= access_emulation(addr, value, size,
+                              access_size_min, access_size_max, mr, attrs,
+                              access_fn_read, access_fn_write, is_write);
     }
+
     if (mr->dev && reentrancy_guard_applied) {
         mr->dev->mem_reentrancy_guard.engaged_in_io = false;
     }
@@ -1450,13 +1537,15 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
                                          memory_region_read_accessor,
-                                         mr, attrs);
+                                         memory_region_write_accessor,
+                                         false, mr, attrs);
     } else {
         return access_with_adjusted_size(addr, pval, size,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
                                          memory_region_read_with_attrs_accessor,
-                                         mr, attrs);
+                                         memory_region_write_with_attrs_accessor,
+                                         false, mr, attrs);
     }
 }
 
@@ -1544,15 +1633,17 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
         return access_with_adjusted_size(addr, &data, size,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
-                                         memory_region_write_accessor, mr,
-                                         attrs);
+                                         memory_region_read_accessor,
+                                         memory_region_write_accessor,
+                                         true, mr, attrs);
     } else {
         return
             access_with_adjusted_size(addr, &data, size,
                                       mr->ops->impl.min_access_size,
                                       mr->ops->impl.max_access_size,
+                                      memory_region_read_with_attrs_accessor,
                                       memory_region_write_with_attrs_accessor,
-                                      mr, attrs);
+                                      true, mr, attrs);
     }
 }
 
diff --git a/system/physmem.c b/system/physmem.c
index a8a9ca309e..9c5f3fbef1 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2864,14 +2864,6 @@ int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
         access_size_max = 4;
     }
 
-    /* Bound the maximum access by the alignment of the address.  */
-    if (!mr->ops->impl.unaligned) {
-        unsigned align_size_max = addr & -addr;
-        if (align_size_max != 0 && align_size_max < access_size_max) {
-            access_size_max = align_size_max;
-        }
-    }
-
     /* Don't attempt accesses larger than the maximum.  */
     if (l > access_size_max) {
         l = access_size_max;
-- 
2.25.1


