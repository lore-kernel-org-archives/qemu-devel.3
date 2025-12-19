Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBDFD78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdEv-0001PJ-TK; Fri, 19 Dec 2025 11:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEi-0000ul-AF
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:49 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEf-0006FZ-Ny
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso14727445e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161304; x=1766766104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6HMTxxs6Ve5Sks2R1l9RktCbKwSNfSiUvebbKXSoPQ=;
 b=BLmCs0ob/EfEoCc0emSa9ABG5Su5qTNUeAMMou+ovVS5GSv5N5WNm9vRSQes6y6pgY
 X8odrqe7u5d8ybT+E2BIb0ZuyLmolR+DvURMVw18BYZYY/SXT/ov/w9ZZb/rvXQrYvX6
 tPzID/i+3Rtalg92BOXPEmzJe4/FreIWyHxvP5QrpTB59WhFL7+DRpmprdiICHJYP61B
 7PvyJ/D5UDt73/pkkM5gyHruAq0boRiXFJBTOVptRcvB6rUjwDffY7Rv03hLrcM1zjx/
 ErdiJQ3HvJrmoosdsbRM4kWVuIsQOD4pFqCTgmVwEVuKGgP+ohaJVSbv3nfF5u+qBpgH
 7O4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161304; x=1766766104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I6HMTxxs6Ve5Sks2R1l9RktCbKwSNfSiUvebbKXSoPQ=;
 b=CMWMyf2kq7fXTwG4bUumKcEyidjNI3+MK3HN5gN1sJNtwqqZ5tKdjk0O0SDrzSmJJH
 49JEDwSFyRwOEwXCGGEKmEPnATYtq/tBNuane/Rz+/gPWf5DK+gZS9T8A9jfakn2hYJC
 ioE7t6Mu2VHN5bP6PFbbKdIS6Al7qL6zDFMn7neILzO5ct5rq4TawmyArPfWn/XWENI+
 H2ixTUNba8FDZWHF8/JYyhSje1SCoHoCvDX2qGEk94R0b0eVwQfv1PD7Dgs5JJldXmPW
 7GBsUiMd7VGwi+kZBTemB3qOZOX2rm3uFlVOm2Iq0bxoh1wkQ1awQiG5Ip+jTnhmLImI
 DRuw==
X-Gm-Message-State: AOJu0YyRt8BYuF4nAyJ+SGlLT3GtHAmIvhUeEn+fF89W6lJae0WC5+oW
 Pj5U5D0k3vevdd5u/HHiK9BDG5cvXctvoaz4DH992+GupRdHAu+ipwy6vW+e9ljdrFRBpFyKZ24
 kIlTUSWA=
X-Gm-Gg: AY/fxX5GxsmAJGLzbaFnn3PdaMGfHlEFBnHuMh7EjKVwsv3KwYdSRxIFOF/zfyQFtmp
 DRx46Kdbb7bYc3SRpvGfA6F2eOaXJVxb4sdk48Hl6zQXzjh4Myj0vu0X/7uN1eplAt7+qNq8UTd
 3nMDdES/CQS1NIkH6WfUoXnfh5HH5Nff2Oq9XPwhqztwMZYbxd7KvZ/Ky6mba7LagB/4FAfRo6y
 k+79/DeOkaAmyPIJS/Y1PV+24nVDaSMzrkVoD/X95mFpafDx8V5DCpn3M9q5ZS5Vfo6t7RdaEZK
 Jx5WAMnDP/JwNEXK6TO0d167xbo9lL3tpwsx7PcmdSYV8jcO8CF9OxJv7gKH/1igcneIDlA3ADy
 gYOAOh2uaR4glr6oNaFxzZYn4HY1xPwR+Uw4lixdjzLvVxQG3W1iz3XWZucbU0F1yLVyA18M+S8
 9lAJJoN8D+ec4tPFdeR5BWzBCpv/g2ixu2IKyglUazXI3dRBfR5oZJDPpMGAps
X-Google-Smtp-Source: AGHT+IF2pEdIvPwHF7Ux05TnaxWpLpgng3LAuu9SUfH7MYcLZGQuWvyn0w4KZJl3+pG1IPYdfTUjng==
X-Received: by 2002:a05:600c:1c9f:b0:477:9c73:2680 with SMTP id
 5b1f17b1804b1-47d1957e495mr36548725e9.23.1766161303797; 
 Fri, 19 Dec 2025 08:21:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193621c8sm49606265e9.7.2025.12.19.08.21.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:21:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/24] system/memory: Use explicit endianness in
 ram_device::read/write()
Date: Fri, 19 Dec 2025 17:19:42 +0100
Message-ID: <20251219161953.72724-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
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


