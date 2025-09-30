Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46A5CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vdi-0000Fb-6m; Tue, 30 Sep 2025 04:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdM-00005m-6w
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vcg-0000w3-9u
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:50 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so3554859f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220527; x=1759825327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkYmQo8nriy/yGfh4HWmKxNmJbyJBkEcEbiWP0BNxvs=;
 b=W9u71O8u94q6lclL4u2v3lwSnB8QU0MMAClIhtI/vhKNOtW+DYxe54h7dfj9JfL+7s
 r8pn8sgJTxIDVz+vpQKnW1TMaDpJRV3MyiY6BCI06KMuKiwSASjKuWiw3ztAKWBzjdz3
 VogxWE6HJspdpd9Ea5qAm9vuEItDbcDF1xtLz8N/JwupWB3mQVigCrfebtZ5gBBqRFZ2
 4YMULRaR6Dojpuda2HMQvD571FgdbQYuVfzjnYdQXQkOl6A1UAfE2/Do5/7JLikzn5bn
 8wRynN3/m9qfKJJe4xOpRz3YX0c8wJfiQef7Zp+RaNum69DZXpNaTyrCqrBuvb+G9xw8
 ZLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220527; x=1759825327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YkYmQo8nriy/yGfh4HWmKxNmJbyJBkEcEbiWP0BNxvs=;
 b=dfH9KaD5xbINGYyieeUsitSWs2bJDFbW8k8dvf+1wjUsrt3YA46OOGYGodlQo2rZnF
 b6S136QypkLghWq/KAHqKZFuxEvF9mnHikaiewJeO5DaM0M8xQRSbGf+1DSTeW0HuHf/
 cAEJNSx+gUt5E8MsZfzJNmJ1DeyBlfTSmEyhLjsEV95FYmUWqTdYOoLjLwtmnZYbt/27
 yiZyh4soaLALP3t0AkCEt0jBGCqVBWImx3TfYPffbMJu+CnqCmps32OLUl+TGYTkRDSX
 WexzZlnWHZ2JIFr4ptHfCMdgSIuDg7wB6k6N9x5VUt5djeyPZG7NgYcdwFfeNdVC49ez
 OLNA==
X-Gm-Message-State: AOJu0Ywfow776ZG+MnP3ucooPSpMoqcyhhFdLv+NSOiOM7TpO+S6+u5S
 /Hzd0rDVCKBP9jqGTDAA00YmYfrktmlLmyRHwVRvUfJLQeqRL/IZQrxngQQgns0PTUCgBt3h7cn
 DULfnuACCnw==
X-Gm-Gg: ASbGncuyjaivRlLE6bpfm7fErXGQE2oDeomApgBBCXa/jRBjaG2jjbdXXhg2FgzA6me
 IXhDxELlYgQKXB8MKVTXMq7jUncolsjqGWX58qUYow9RTbqHgf8z3IyHnrahhRXIpwhdZoqNnNg
 KA70DHBW4q+zrVkPqXlV7dIWhnok46gvgsDXoEEjOT5XpN6bGDpE89jr5CAVo/UAEaxDJ8djj0U
 ZdHW8Jz3pnvvVryZ17ktFHU14HMlPSPKNyFosNM3Kvn5TpfpTx4qO3tY5ocCRtK0fcX+FDPetJF
 Bb/dUebV+AkG0Sj+Wlo3aduChPJO5d3x6UVywVPIGlWrjOQLLAzp2QulNZ61mDNCiFtZ7uO+xfb
 VwqyyEhWBBYHKwHrO67W5r/DoSccEX/1TFyODHQuLvXgN8rbSW3XjuVR/8J9cZPe1RMKa3LkKu1
 YZmB5tFzAsTz4WCW5QuLV/lE3MNFVCdCv7h/UG2gVWEw==
X-Google-Smtp-Source: AGHT+IHzRQHYpgb/DyIfYTEXGiArYWqeYdxWvyGmM8w8s+84+M4R5T3PN9QeVLlNgQQ0W4P8WfSxtg==
X-Received: by 2002:a05:6000:26c9:b0:3d2:9cbf:5b73 with SMTP id
 ffacd0b85a97d-40e46515110mr15910423f8f.6.1759220526791; 
 Tue, 30 Sep 2025 01:22:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921bcfsm23056408f8f.43.2025.09.30.01.22.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 07/18] system/physmem: Pass address space argument to
 cpu_flush_icache_range()
Date: Tue, 30 Sep 2025 10:21:14 +0200
Message-ID: <20250930082126.28618-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 546c643961d..dfea90c4d6b 100644
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
index dff8bd5bab7..e0c2962251a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3215,7 +3215,7 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
     return MEMTX_OK;
 }
 
-void cpu_flush_icache_range(hwaddr addr, hwaddr len)
+void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len)
 {
     /*
      * This function should do the same thing as an icache flush that was
@@ -3230,8 +3230,7 @@ void cpu_flush_icache_range(hwaddr addr, hwaddr len)
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


