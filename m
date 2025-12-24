Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10506E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQjP-0004sW-PT; Wed, 24 Dec 2025 10:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQj9-0004ZD-0T
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:45 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQj4-0004nC-9g
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:36 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-64b4f730a02so9769927a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589870; x=1767194670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6HMTxxs6Ve5Sks2R1l9RktCbKwSNfSiUvebbKXSoPQ=;
 b=Lw8IQ/pRcmKQLYge8+Yz7w0r8nHsMoWoDcrAOtmyJSRETW61udmd+11Y5zYTCkFA94
 Es0K/JQUBb3v6ig6jRK8Vw1RugmKAU3kYgdpZNbqcmyK4TIX6A5spjmPEZKjTPGBRBwL
 GsiCj+hLEdkdksAIXOkP07tRJWkHY3kVYtuqeQKCWsG2II2PlMgoF+SPCdLSVKa1Hw+s
 QKoQJx9zkXprH8luaQTSuATJpOOB4aVyZZCyd3FQQ3ObqUvxiWXe1s3OPpYSB5nuKI4Z
 1Dz9e0hxo8/I8zT8LgYhDYFx/1CnpVR83qsCiRrJZFheTdwVrmQE5jfgzrWExEfTHGCX
 QUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589870; x=1767194670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I6HMTxxs6Ve5Sks2R1l9RktCbKwSNfSiUvebbKXSoPQ=;
 b=OptES95VH+Gad5Bw4URrhWLemkmNL4Ue5Lz9CZFWEnyoaNhatoqzyApotdlr5IHN1s
 DIlH3uZggQog+06Ie71F0A1fKPH+Vwv7McCrEYCdREmx6AE/+aXrPphjrRdYX1jG+zv0
 DClM8srBZnSiVJnOLRrYEYB78APZy97JY3NW6OjEnFyjFQUKzhvdK04ignS1NF/8vkoh
 BPgw33VuiltoaaIDvQnLjFjXsY8n69E3kMjPXT1uEjYVDuncO0UM91/A2E4nbz3j74AU
 Xcw15zgAZXFPcmyqMbkHg/xBNPC+gjCmxgxlaBMCGH+yF03ux1x4lFLGptn8DlEykTdT
 liew==
X-Gm-Message-State: AOJu0YydtsVXT9XP+uw8siVjOQVLx6KaQC9jmGNL0A8BshTdB/KdWnJd
 Eomp4DKMrj7yOt+gP4my09qlW7fWra95iF7TP74mPQMTui8fod+p2cyPP7+WVQcXiEzCVqjeN+k
 edx85u58=
X-Gm-Gg: AY/fxX45MhWEAaTS2EJRy2E39qaLSuBIfBnLKmIQEMAR8R65o6rrCAvLFmgo46tqf9y
 ZArjLXr5Xwdq3HGRY5l0A2j+WzEX4vXvSuSDOuT/wC8TXM5Ge8gqowaXnLm0Ls2WuPA9KvNaT7E
 pzIOi/dHILE9Cs+1vq4R6Dy1vrKvP1X+kOZiUS/w7hGPcKgI71TzFB+htGannM1vl3FQIw/01KT
 4yp5ktQZIhhcY6JbavDPUgQTIaIWbPY9zIe6Mq0cCoPQAai4HpAp2kNmSaoGv9Q2ybPc68oPsyU
 kXgCm6QJ1aFrv5ukIhKReuBl2M8sShypLmvMqXUUwZvR8+rGG9eJCJjp5VYHdUBjdaXVFnwouC7
 FlNnROnDuhzN0nZ5Toqx4eYHcusbAr3Eom6I/hWZZRcKXYhRNGSyQdLtNvPdM0I/4RHhdCz453c
 Fy5vRxeoVN0CqTk53YhAdKVakuP4f/5TKVb/TtNyi1JXAgIYGB2K23tAA=
X-Google-Smtp-Source: AGHT+IHykvB/+tVzUX2j/nsmsWYciJgYvbhQSmiDYoaGzTUaeOfEnMinypkoyN9q7gjm8BukjHS7aw==
X-Received: by 2002:a05:6402:2356:b0:64d:4f75:aa28 with SMTP id
 4fb4d7f45d1cf-64d4f75adb0mr11287635a12.18.1766589870379; 
 Wed, 24 Dec 2025 07:24:30 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91056726sm16630876a12.10.2025.12.24.07.24.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:24:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 14/25] system/memory: Use explicit endianness in
 ram_device::read/write()
Date: Wed, 24 Dec 2025 16:21:57 +0100
Message-ID: <20251224152210.87880-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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


