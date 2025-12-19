Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA8AD78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdDY-0006Jh-JO; Fri, 19 Dec 2025 11:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDS-0006CM-M8
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:30 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDO-0005y9-Si
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42e2e77f519so1400827f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161225; x=1766766025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcMU1k1986zvYwyLzb//gpQrHqBilxoxS5xhcinB0TY=;
 b=CD0ja8/hI3AGrIeosiNlCCaFaRreh/qt2mjrgjN3txu3veh3ePoLQ1epAhg+FRukpr
 fxBOBZXxBgUqKrxr2dVd950JzKa+Snosd4z/mDaPWGrjlkwdVZCewzJFzc0wiDWj8C08
 ywfr44Nmzg5v/tBwihLBxvMoCkehb9/V4FViQjbOvQbDtHMcrFXNOCAARMRQJxUGcYg0
 AZiex5GqCUwWYhAUopAzAeQ1p77ffrzdvgm5u/b4WZY+hX0mqLRUmOsefrFIcax9B7vO
 5JzHGrq6GLZExXlUP9y5vL0VVaajqUHU9oxYKOE3OTcj7h5ULuoDrYXZqJTkJllbUh7Y
 iE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161225; x=1766766025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XcMU1k1986zvYwyLzb//gpQrHqBilxoxS5xhcinB0TY=;
 b=vs74NvZr3xatLHFoTlapUaGHrZxHMl2UmQ1aILHiS5HVo4Ns7K7xYxz5Vp8mchQzk6
 +P9/1SW4KQ6QOB3v8jCGs2ZTHndZNK+LVqayp5Fd0/H5KKkWoHnO15UWf7ivAIRg+WXe
 +zwlIzTSi4+3IcP7/djf1LYCuXdiUe5P7n1vAVUIDGgdptK1h2ID/HBi6FAAZtANcACE
 iHkChhoPRxiuToBXFukTFSz6qp1i+rhpyHavUYdH3WQ2lifqMPKKdm7/o1U8aqG2tXY0
 lwKXaD6Fthhe9vAMeqIDGxCVyO1V92LQp92GBrMYRTNtf1wjbthA/fxc1Texf5TsGsU3
 3NbA==
X-Gm-Message-State: AOJu0Yz/tE8Q7s9OvtiZC193vgw0KWYZX+7h6ojU+O6PBzGw3jQpCvTC
 WJ9uM3lbqF75WCqyZ2io0Hznx6aBhHaw8NGO4j/rTfcyFeOX5Q+fa9pFsukIJCmtaoqrv5E7oY0
 F/0li8Sc=
X-Gm-Gg: AY/fxX6Accyy/sXU+syNCBCcwjYUReWcnXCTX6zVjZgRpZBohnhtQWZyPH/1nLvzbdA
 kbtfqEZYlVaA0n0Xwlw+yLCeUYNEh5RHKhUCqbzApQkzz/g01K6g72212dkLL+ziBlcSaVn/UzW
 dNbgL2NyrlO6qeV0yCq7z3D1Uuh9Ax/tVasPBzC6GUqD2+5tG9td9sqiVxdoAiexlj8O6A37b7p
 pCDgVmRf1J6SqTet8Ggw0x+5q2wWyNXI3uRZpGB7lpnA93WY6cnHy1N/K/NaywtujFk3G1rQ8mM
 8mxLZZCcCl1JG6/YZXVgih2eJSjh4/BBq99Q1ltAfK1nqsywTZ4dkarYvls1WOHZuiNg7drwXHE
 zc4y6Ty8SiPz/PUq6S7ZKKQsnWABaSEcjQUlwszol55KWNIhUrjtMseCs7FVZKceqMJydPZ3y+e
 0v/NsyDU/vpVuH9cZ6biiA7pa/OBWW0UTmV6+M8d+DkfK9lSrJ9Zhjymj5C1Gk
X-Google-Smtp-Source: AGHT+IE+7QpyqkemrCjz7smCR4u5qB4Ydg7lXsIxsqGHh2+8bsGJSXuuUyFsH4gzHDfikghW5P6RoA==
X-Received: by 2002:a05:6000:200f:b0:431:8f8:7f2e with SMTP id
 ffacd0b85a97d-4324e50615emr4172277f8f.33.1766161224872; 
 Fri, 19 Dec 2025 08:20:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1af2bsm5989466f8f.1.2025.12.19.08.20.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:20:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/24] system/physmem: Use explicit endianness in
 subpage_ops::read/write()
Date: Fri, 19 Dec 2025 17:19:31 +0100
Message-ID: <20251219161953.72724-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Replace the ldn_p/stn_p() calls by their explicit endianness
variants. Duplicate the MemoryRegionOps, replacing the single
DEVICE_NATIVE_ENDIAN entry by a pair of LITTLE and BIG ones.
Select the proper MemoryRegionOps in subpage_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c | 76 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 17 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 7e914ecf648..9fe84679cac 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2894,8 +2894,8 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
                                   bool is_write, MemTxAttrs attrs);
 
-static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
-                                unsigned len, MemTxAttrs attrs)
+static MemTxResult subpage_read_le(void *opaque, hwaddr addr, uint64_t *data,
+                                   unsigned len, MemTxAttrs attrs)
 {
     subpage_t *subpage = opaque;
     uint8_t buf[8];
@@ -2906,18 +2906,49 @@ static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
     if (res) {
         return res;
     }
-    *data = ldn_p(buf, len);
+    *data = ldn_le_p(buf, len);
     return MEMTX_OK;
 }
 
-static MemTxResult subpage_write(void *opaque, hwaddr addr,
-                                 uint64_t value, unsigned len, MemTxAttrs attrs)
+static MemTxResult subpage_read_be(void *opaque, hwaddr addr, uint64_t *data,
+                                   unsigned len, MemTxAttrs attrs)
+{
+    subpage_t *subpage = opaque;
+    uint8_t buf[8];
+    MemTxResult res;
+
+    trace_subpage_read(subpage, len, addr);
+    res = flatview_read(subpage->fv, addr + subpage->base, attrs, buf, len);
+    if (res) {
+        return res;
+    }
+    *data = ldn_be_p(buf, len);
+    return MEMTX_OK;
+}
+
+static MemTxResult subpage_write_le(void *opaque, hwaddr addr,
+                                    uint64_t value, unsigned len,
+                                    MemTxAttrs attrs)
 {
     subpage_t *subpage = opaque;
     uint8_t buf[8];
 
     trace_subpage_write(subpage, len, addr, value);
-    stn_p(buf, len, value);
+    stn_le_p(buf, len, value);
+
+    return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
+}
+
+static MemTxResult subpage_write_be(void *opaque, hwaddr addr,
+                                    uint64_t value, unsigned len,
+                                    MemTxAttrs attrs)
+{
+    subpage_t *subpage = opaque;
+    uint8_t buf[8];
+
+    trace_subpage_write(subpage, len, addr, value);
+    stn_be_p(buf, len, value);
+
     return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
 }
 
@@ -2933,15 +2964,26 @@ static bool subpage_accepts(void *opaque, hwaddr addr,
                                  len, is_write, attrs);
 }
 
-static const MemoryRegionOps subpage_ops = {
-    .read_with_attrs = subpage_read,
-    .write_with_attrs = subpage_write,
-    .impl.min_access_size = 1,
-    .impl.max_access_size = 8,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 8,
-    .valid.accepts = subpage_accepts,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+static const MemoryRegionOps subpage_ops[2] = {
+    [0 ... 1] = {
+        .impl = {
+            .min_access_size = 1,
+            .max_access_size = 8,
+        },
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 8,
+            .accepts = subpage_accepts,
+        },
+    },
+
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [0].read_with_attrs = subpage_read_le,
+    [0].write_with_attrs = subpage_write_le,
+
+    [1].endianness = DEVICE_BIG_ENDIAN,
+    [1].read_with_attrs = subpage_read_be,
+    [1].write_with_attrs = subpage_write_be,
 };
 
 static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
@@ -2969,8 +3011,8 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base)
     mmio = g_malloc0(sizeof(subpage_t) + TARGET_PAGE_SIZE * sizeof(uint16_t));
     mmio->fv = fv;
     mmio->base = base;
-    memory_region_init_io(&mmio->iomem, NULL, &subpage_ops, mmio,
-                          NULL, TARGET_PAGE_SIZE);
+    memory_region_init_io(&mmio->iomem, NULL, &subpage_ops[target_big_endian()],
+                          mmio, NULL, TARGET_PAGE_SIZE);
     mmio->iomem.subpage = true;
     trace_subpage_init(mmio, base, TARGET_PAGE_SIZE);
 
-- 
2.52.0


