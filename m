Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C624CCA472
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wT8-0005Ht-GH; Sat, 04 Oct 2025 03:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wT7-000567-1f
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wT3-00050B-5C
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so33320085e9.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562047; x=1760166847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mwvyQFx2VxMSTouCYAvoQjOWQQOK5yKSb+lwrAMBkP0=;
 b=tC5MTx5HqoIDkiscNn6ZB0dA0cntmmqew0DJCdbsiXWL9WhRh3yMHBv7lxNA/xweV4
 nxiBLC5tv3dU9OnQLqcfN1XihLfj+vOAUsl0oLX2EF483dq05r9BWRQldCXZuDpGEkpw
 KcbsSKe15oNIOPv2+QmVsBof95Pilu+sho1XSaQIczjsPgh0OJ8tzysRYkATBkb3F8iy
 9Y0sK1goijeMjCBbNvT46u+vO4kjUlikN5cq40EGfbE0N/fQjOnXTa45HeVRHI/VSXmc
 fR3xt4hKefDQsJZl+5UOHUascmsu+rZZ2G40LwThMAlCrzDOz2wUCrmZgkBA7E3OYlWy
 VGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562047; x=1760166847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwvyQFx2VxMSTouCYAvoQjOWQQOK5yKSb+lwrAMBkP0=;
 b=ANrlHHoc8Qo5lAuJRU4sgQv8B895STfFA+e7f5O7u2e2k4yT4xXxAMwfoY+Vo7W+1T
 QF9MzxP4a4nZc+jTiEx3OzJ+mvuZmYzJ5oKl9+AWwcsjCf+s03On/vTxhUyzo4WmB+NS
 GAoMnw8/icw6CDCayHJGdChlglpOsGP7hGTF+82dqmnoBiSMcj29JhdItIGlDp2Qu93/
 eqonhQJ46wM/g2tre13gV0wNBeOYqTc8sjtTmS4lO4wUmR4KVB66BIa67LGNk4NEYZrH
 U19CnKuqXVXgwAsZP/SrHOCrGM3mL10egj+ra6kKymxHGdLd6r+q8nrQjibfl4DckmH+
 Su3A==
X-Gm-Message-State: AOJu0Yy6j2WjSO6seG/FDV2AdY02xM1GoA8BaY4FPJ0NRrvtugsLD1i9
 KxQrTk5Fl/ZcZl9/3YHT6D3YlgvXcyY0YA/G5u+waYs45jjQCTA44Yg9MvwKwEW8w1s9P/PvQgZ
 bact1w1FAMA==
X-Gm-Gg: ASbGncuzs4UN03eiU7HivEGZGqLUzYvV7TIJVhg6mrLpOJSoJn42urY3r/NYk4RMX/9
 4gatMt0PkDxRAOtCZ4ceVdfMgepBGnvbSD8KmamzWeC9P4NGnM32Vvh5q95Z8mzg1H38V6+Ewl9
 amf4RHVYSpyoSZWlESYHzvIKlewj0V18Hj2otyp3/SCRPxWSz4EKvj6WCoN3OMs9wHVEPFS66Rr
 b5TrkEVnz0kTCIGzO8mAhSfDoTgp5xxuYyGPmqknvo3kjV6mpDS7NAaLmqFCe+4u8G3u/o6ERY9
 DcinbICOurT8nnuV7dd1D+3Gf0FlWwK6b6QcK/7EnZXColFNu6DnY+zYXgccDELjaQ6IOHWndAl
 AxKM+JpODOblj6OI1+ikFlceQwmviP+179LgjLfo9Uy8zvuXElhvLw4F6Emgyl3w6jPJp98P6io
 SsITayY//appZmrop5ghMd+7EDeeHGq6tpDVc=
X-Google-Smtp-Source: AGHT+IEI9fFdjJkYEKVsa1XCZqw2OIcVaGaNkzcxjTy+seLPO84pxvx/mYSlMrmtiANugad47W7DLA==
X-Received: by 2002:a05:600c:1550:b0:46e:4882:94c7 with SMTP id
 5b1f17b1804b1-46e71153745mr34737575e9.28.1759562046614; 
 Sat, 04 Oct 2025 00:14:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c4afb3asm92978525e9.6.2025.10.04.00.14.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/41] system/physmem: Pass address space argument to
 cpu_flush_icache_range()
Date: Sat,  4 Oct 2025 09:12:38 +0200
Message-ID: <20251004071307.37521-13-philmd@linaro.org>
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

Rename cpu_flush_icache_range() as address_space_flush_icache_range(),
passing an address space by argument. The single caller, rom_reset(),
already operates on an address space. Use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-7-philmd@linaro.org>
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


