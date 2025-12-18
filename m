Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA09D711C9
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLY5-0001EM-Rf; Thu, 18 Dec 2025 16:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLXy-0001DI-CZ
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:28:30 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLXw-0007Ee-93
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:28:30 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so948035f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093306; x=1766698106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6HMTxxs6Ve5Sks2R1l9RktCbKwSNfSiUvebbKXSoPQ=;
 b=fOyXC9eWK3L1rd2bPKAVMUr/xWOBOsI3z5NjnGvQXoQukcbm84VME1i4xmynEp9PAC
 uWJLmB8l4K50FsULOQNsRiyi7J2CvML8MHXw7QRasOa42oBeTOnJ/eJaHxUUOrguIqWf
 aBTUdEO0TeQYYvmqMAqNoBvuIyoqdzD4f656xGY2U3dPTfLNewHBD0Ep+OOfxDPI0Tls
 zJZneZ4sdKz2ayvdxrP9ArsqXdd6Xrws0kTdk4lRBs9z0QHqkUJquxwGMuE6Ctpk8k/p
 z77PlogzvHE9rWy5kXJBvpDk3PTo98wZ9VS9LV/SD8M5CypoHaDiWBDS8+utzmqX1NTi
 MROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093306; x=1766698106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I6HMTxxs6Ve5Sks2R1l9RktCbKwSNfSiUvebbKXSoPQ=;
 b=SWHkIV01KRf8rgTc9hhXAqNkrOU2abqsVYixnwcHJcJ4MLOCI9YxLhcs/DH5xb2n8y
 X33xwAaPXQlRSoiAOR37FidExRXXD2Z8rcinFTXkbt0olHonOgEfXu+AsjdPx91lCRuQ
 FZljXko9tF7rCntmTOERjM0aa+Y9MCTvO/+WMBIpqI1jlELW3kwDzT5cGaGLkIIvnkV6
 4ekg83y7tdfFuDiaj1An8v/C7hr1n2r8Gu6U+FqURPFOhl4ViHEe9Mnwkf6/hWCxwCf1
 HvBXfuaLwFfd4CuL4FdYufmGSDvBGM2WP81cQUwP1+X+8KSzOrSk+OGUaf/xN4tEM7EP
 XqDQ==
X-Gm-Message-State: AOJu0YwjpNALsv7K+TwbiN1ganZWObJ/x5fBKYiEIy8nuShlVtTb9Ij8
 fXA+fvjuuPey1nrZE/8/Roj5VoUh7zk6LyVcCu/CrBpu6fQSv9v0+/idLhNS3nIqdRG0r1/lKM+
 fll427zE=
X-Gm-Gg: AY/fxX5TafwhhMz16RyBFkGjPx/qXQAQ5PBXOHkqyLHWb5USbwDcK6pCp0bJGCWvvOU
 HKAoAVxfHgF0Af3RzhAw2cHuC9rNpyBrrpPjolXLJHlhbtYlPHG+dd9afoYzvqCvWR44mRKxR1F
 O/7AUa4VVnSqHrKXW2GE2GimKJaLxQi9vhFa0m/+ipcirCOKdUf2wGyKfN9KqFNxNz2vRqxgfMX
 mX0CP9Y1w82bbeXA7S5ixbmvszO/cGGwxhBa04FDhJ7/fQZDKezFiwme628YDVhF9KW6tgU6QeH
 uchEYmbvw8aw9m50tLBGChK23Qkimm1TsMlED2P3lbhoLSnBjQ8ihXXmLYczPIfRr2WMPVwq5Ys
 ZH5WTd/eWiHuRx3HCxTN5zJ3bLI4/B9b+XrhLVBvxgdP+X27JWvVp3nUGI/1WfMc1UzKGkXgdDD
 A82+KSU7hKY/NyIhfAsNgJsAduVN4tqAC+W2fyZVXLoo6Ef2fzMhjizg7x0ZbI
X-Google-Smtp-Source: AGHT+IEirV0DT3iV3gJMWLAtlllkOQAolkTzB/ofps8NhJRYPSQ6yOwKN1+BCrmcryd/SEm3mE8shw==
X-Received: by 2002:a05:6000:3109:b0:430:f494:6a9c with SMTP id
 ffacd0b85a97d-4324e4cd1b9mr747742f8f.17.1766093306422; 
 Thu, 18 Dec 2025 13:28:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227e0sm1068294f8f.17.2025.12.18.13.28.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:28:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 1/4] system/memory: Use explicit endianness in
 ram_device::read/write()
Date: Thu, 18 Dec 2025 22:28:11 +0100
Message-ID: <20251218212814.61445-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218212814.61445-1-philmd@linaro.org>
References: <20251218212814.61445-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Replace the ldn_he_p/stn_he_p() calls by their explicit endianness
variants. Duplicate the MemoryRegionOps, using one entry for BIG
and another for LITTLE endianness. Select the proper MemoryRegionOps
in memory_region_init_ram_device_ptr().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory.c | 68 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 8b84661ae36..5bcdeaf0bee 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1361,41 +1361,69 @@ const MemoryRegionOps unassigned_mem_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static uint64_t memory_region_ram_device_read(void *opaque,
-                                              hwaddr addr, unsigned size)
+static uint64_t memory_region_ram_device_read_le(void *opaque,
+                                                 hwaddr addr, unsigned size)
 {
     MemoryRegion *mr = opaque;
-    uint64_t data = ldn_he_p(mr->ram_block->host + addr, size);
+    uint64_t data = ldn_le_p(mr->ram_block->host + addr, size);
 
     trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data, size);
 
     return data;
 }
 
-static void memory_region_ram_device_write(void *opaque, hwaddr addr,
-                                           uint64_t data, unsigned size)
+static uint64_t memory_region_ram_device_read_be(void *opaque,
+                                                 hwaddr addr, unsigned size)
+{
+    MemoryRegion *mr = opaque;
+    uint64_t data = ldn_be_p(mr->ram_block->host + addr, size);
+
+    trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data, size);
+
+    return data;
+}
+
+static void memory_region_ram_device_write_le(void *opaque, hwaddr addr,
+                                              uint64_t data, unsigned size)
 {
     MemoryRegion *mr = opaque;
 
     trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
 
-    stn_he_p(mr->ram_block->host + addr, size, data);
+    stn_le_p(mr->ram_block->host + addr, size, data);
 }
 
-static const MemoryRegionOps ram_device_mem_ops = {
-    .read = memory_region_ram_device_read,
-    .write = memory_region_ram_device_write,
-    .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-        .unaligned = true,
-    },
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-        .unaligned = true,
+static void memory_region_ram_device_write_be(void *opaque, hwaddr addr,
+                                              uint64_t data, unsigned size)
+{
+    MemoryRegion *mr = opaque;
+
+    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
+
+    stn_be_p(mr->ram_block->host + addr, size, data);
+}
+
+static const MemoryRegionOps ram_device_mem_ops[2] = {
+    [0 ... 1] = {
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 8,
+            .unaligned = true,
+        },
+        .impl = {
+            .min_access_size = 1,
+            .max_access_size = 8,
+            .unaligned = true,
+        },
     },
+
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [0].read = memory_region_ram_device_read_le,
+    [0].write = memory_region_ram_device_write_le,
+
+    [1].endianness = DEVICE_BIG_ENDIAN,
+    [1].read = memory_region_ram_device_read_be,
+    [1].write = memory_region_ram_device_write_be,
 };
 
 bool memory_region_access_valid(MemoryRegion *mr,
@@ -1712,7 +1740,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
     mr->ram = true;
     mr->terminates = true;
     mr->ram_device = true;
-    mr->ops = &ram_device_mem_ops;
+    mr->ops = &ram_device_mem_ops[HOST_BIG_ENDIAN];
     mr->opaque = mr;
     mr->destructor = memory_region_destructor_ram;
 
-- 
2.52.0


