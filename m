Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6D6CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EuA-0006tX-Mn; Thu, 02 Oct 2025 04:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Ett-0006kd-0B
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Etg-0000td-Kx
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so6476565e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394554; x=1759999354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q36ac4tAhT01s84agsdvLvLQt0ctAJzIb51YlTVbcXM=;
 b=Tv4eSTFhlwWZbYXIF+RGTvxGl5266HGlaknPaeovODSjUd6ad1nSi2VlO2PJZi4nte
 x8X8Ug9Ejgnl2/gnT01fqDEVSZFHNeqYwLQjvL86sb1vK4aRY+k/DkAkflXJrCFKnfmj
 MkOm3ZyH8/eQGDt2kL0MJ2fGdk3OCkcpLr2weXrDSDgL3WiCirbmwaFofwPa4A9gSEdT
 Fpt6RaH8YI2ztpxF5sDgxQu6h+WtlxujG3PcQVGoP9lsiVeUHrxEaoCPvFUEup3XlnU3
 i36E+8hED7uHYDLy8cAqGdtR+WK4Egrh+BHgOPFcutw9bihY2LrpHwMJTRA5Q8U1/C9I
 b9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394554; x=1759999354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q36ac4tAhT01s84agsdvLvLQt0ctAJzIb51YlTVbcXM=;
 b=QmUzlzhc9LmfiBoWf2rf5Z5/1hY5MqcPUADOxi7QT/+6eN1SCpDyyoEXGt9Ipsj8TT
 LXDDcC9oOOZYxekPBZ2762SbIroFuLGcg6AEY6nR8+fgkZ8GYBspkiJU3XiEOkgqoXZu
 oSyIU8lINBySRPskv/kYX3Kl26HL3A3Q5xt/mQOz1ItjxFqe7w2L0erC492TfLa1/khK
 3FRf5MCCg6i5HDqgnbw9ocf6SiqLFdUmMI8bi+FWhKxRfvRG0AFU26uh8YWmgS/ohZ84
 RTY/WW0jBbBWuzu1TL9EvaiuEjzdiYT5Uk6UThAP80XUAIXxGbmA19PCARcf4Vbo8i4S
 9a9g==
X-Gm-Message-State: AOJu0Yx6RDvzatnNHHIjx5gwYCqR/Sn73967k7LScyPtiSDasoqpfV+M
 uY1EYshUjnc3zEOnre/DZbsLHW/dB7IfFq0CfLQw6c158bJMuvtPv0qXu6x83YfrsCXKk/eUxlx
 yaL5pcrJz0A==
X-Gm-Gg: ASbGncsBA56wpyMlyOy2dM5dN3V+pQ7EjFNAxj082OxiYlXrW8jnwKxbv5hAD3E+D2O
 flobCKRmT2hYAKHh/X7DHOEwfYeTnhqRD4UZV6AVeWIuYLWMZf72fSY/N0qWgjTA4WzryTJypdZ
 4HCdMKYTySEGuG3uGtzPggTnjSDH4J5tWpgiRCZA0Us7VtheiuFJgkkqdL4X32hdT9sQSBdb5Ud
 uZ3oZChViMwc5RjRBrIc47KHhkseBK9rHqwqz7hg3jbjAIsjJ+p2gto/H3PKEb9E6ujyX3MrXbg
 NZU+GYWirIzG9P8yHMcaSy151qWgKIGXRc4enp2ilHsHjZFPgoS5ub9Gso0MOU6VYzNoNYoiwEI
 kNuF8AdCuZhDpiPCwcejbwPnk2IZKrvzfeWbkLKfyb0mx+OlS6Em/IjjS6o+ynWYHC0XQWdIcU6
 INxJq4QRxZJJElHKh1IZCsJ0XEbj6Uaqm1IXP8s91n
X-Google-Smtp-Source: AGHT+IGvW2QY4XT4rE3gnCvd4C2svQ9D2UQ58ymAoAfIs0dUKEvFj1XA9d+49KzTkmba3O5b3qx94Q==
X-Received: by 2002:a05:600c:524f:b0:45b:8adf:cf2b with SMTP id
 5b1f17b1804b1-46e61267b13mr46680795e9.21.1759394553640; 
 Thu, 02 Oct 2025 01:42:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d869d50sm2773210f8f.0.2025.10.02.01.42.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 06/17] system/physmem: Pass address space argument to
 cpu_flush_icache_range()
Date: Thu,  2 Oct 2025 10:41:51 +0200
Message-ID: <20251002084203.63899-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Rename cpu_flush_icache_range() as address_space_flush_icache_range(),
passing an address space by argument. The single caller, rom_reset(),
already operates on an address space. Use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 2 --
 include/system/memory.h   | 2 ++
 hw/core/loader.c          | 2 +-
 system/physmem.c          | 5 ++---
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index a73463a7038..6c7d84aacb4 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -156,8 +156,6 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
  */
 void qemu_flush_coalesced_mmio_buffer(void);
 
-void cpu_flush_icache_range(hwaddr start, hwaddr len);
-
 typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
diff --git a/include/system/memory.h b/include/system/memory.h
index 1b2b0e5ce1e..19c7ff393c4 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2977,6 +2977,8 @@ void address_space_cache_invalidate(MemoryRegionCache *cache,
  */
 void address_space_cache_destroy(MemoryRegionCache *cache);
 
+void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len);
+
 /* address_space_get_iotlb_entry: translate an address into an IOTLB
  * entry. Should be called from an RCU critical section.
  */
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 524af6f14a0..477661a0255 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1242,7 +1242,7 @@ static void rom_reset(void *unused)
          * that the instruction cache for that new region is clear, so that the
          * CPU definitely fetches its instructions from the just written data.
          */
-        cpu_flush_icache_range(rom->addr, rom->datasize);
+        address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
 
         trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
     }
diff --git a/system/physmem.c b/system/physmem.c
index 4745aaacd8f..29ac80af887 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3214,7 +3214,7 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
     return MEMTX_OK;
 }
 
-void cpu_flush_icache_range(hwaddr addr, hwaddr len)
+void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len)
 {
     /*
      * This function should do the same thing as an icache flush that was
@@ -3229,8 +3229,7 @@ void cpu_flush_icache_range(hwaddr addr, hwaddr len)
     RCU_READ_LOCK_GUARD();
     while (len > 0) {
         hwaddr addr1, l = len;
-        MemoryRegion *mr = address_space_translate(&address_space_memory,
-                                                   addr, &addr1, &l, true,
+        MemoryRegion *mr = address_space_translate(as, addr, &addr1, &l, true,
                                                    MEMTXATTRS_UNSPECIFIED);
 
         if (!memory_region_supports_direct_access(mr)) {
-- 
2.51.0


