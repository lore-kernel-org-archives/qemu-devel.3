Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA57CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IhA-0005Dl-Q4; Mon, 29 Sep 2025 14:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Igv-0005B1-R0
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ign-0003CN-Al
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso24433065e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170810; x=1759775610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEWvJYylRbkib8yXjJlQ3r1Fc9sZ+i1G3AKqr/Nn6n8=;
 b=X6S+i1uJ5mtMs6kYQ1XgI9f3INEnNVNIDMRogcDToJCSaXA8vHHrKOOF9YfWMI44jQ
 mCEu2SGGAp6IIyiuX5XsUthUV6zsi667cBVPlEnvUP3tnvp7vQW0nM0pUhcQQWyWYqYJ
 9JE/+/6gohGcGxbSx7BU5L6KDNvvl1dZu5EUwC/53bMWJWDdRQC0ALmEEGR5Wim1iteT
 xEgJCo0o4/99B4oJxqj2sf6zr9piCV5IMM6xQRwwBosv/wmujK8bhCp8uTSl+0q3WFfh
 I0legvrt1Pf8kLceRw4Sz/1rJINcHGfJXt5SfCPeZdn49jxvxKdyX8PlNGeqqG6eDM0c
 +DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170810; x=1759775610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEWvJYylRbkib8yXjJlQ3r1Fc9sZ+i1G3AKqr/Nn6n8=;
 b=E/N3rYQCji7gaWog7Ls5VgHp1psCcWK/YK5cE5fMrIK7zuOqMxtrnsgW4N7EJGaXFc
 LtKnAHv8hiPSkbG2Aokknv48UxQX8Ffo9cU0Lf/voUZOiWMbcI5VzCLBF/QlDlrfY3vj
 kE17NeEsTIG+0I1iExe91LP0S/FBKw5oRoEK15dd+vX+gddKbuRe4jXl4kPbpK9GABmg
 wsTs/tgdvtaxRhB4sNBrZcZmZ1pB7geaMIwDmPNNEG4t3ECI4OVgKLDerOGbwmB4/nf8
 Jy5fJPpusu3i+cXJw/EfisCmENjKVcmILokdEo++DYImU4way4oJHNBpIqE+F2vOO49t
 EowA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUV+mR25zBJ3GXZl2f9yAyg7h//1wVtjwhUqtRLtl6dtLDzCkJaI9OuRFpR1XfbtndLlbJkv5B8c9o@nongnu.org
X-Gm-Message-State: AOJu0YxRgOMwZ4qCObvJUTtOSSr7vqcDvg+0LToHyKHwYUKmgAIyeIr3
 0HFPgGbP+Z7eDVRMDmexBKL/99hzeJ0K+BCa8D+CayhhM0VHJkaUwGt8xUdPZ0qyRKs=
X-Gm-Gg: ASbGncszBi/bC5XKJhfEB7utdl2CdRTPbHPr99Vd+lt4TeavQmymklJRXbs5vjMCPbD
 EBmqOT41OD5PM42aKW5rht9uHLHnPUZ7lX865oCQakzRdopanTrmqtlGhwOb9Y3ATacXXJa+Ank
 pC1Eyy/uFJrNAQYwXZGgPOsBiJCbhnptPFJFsGms/1iZT3utPJ4xBwq0EPSZXOjceVSLRWpRktc
 TNwROblE2IWRVRqoNdN4BmVQR6QwfnxZEGu6CHzT8uSkJjZRkB9y1VAhr9aSZ+qzX/lY/eLr8EB
 /HW5MVOy9iIsxiaum6FmPeU/WKo1lD5YbRo3Ls4NAZpIKZi6mUBXHxkoGzoyt8kO3z+mF8nn4+3
 BR/9oF/GarTCFMzZ9AshId/eTfnQbR4Dl6zxgJsqAhrXmlCivjrwUj6EwlK8cP3RnceiLW60pQi
 b6Yr9VuMM=
X-Google-Smtp-Source: AGHT+IFlycBakp5EkJDN7dbxjK7i5JzbYULjjWcaNxhP9aXTBI6jbDWLO50skO4rhy6UhWAATwe2kg==
X-Received: by 2002:a05:600c:609b:b0:46e:4814:4b6f with SMTP id
 5b1f17b1804b1-46e48144bbcmr82071665e9.2.1759170809908; 
 Mon, 29 Sep 2025 11:33:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e42eee0b6sm125709405e9.10.2025.09.29.11.33.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 06/15] system/physmem: Pass address space argument to
 cpu_flush_icache_range()
Date: Mon, 29 Sep 2025 20:32:45 +0200
Message-ID: <20250929183254.85478-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
index 6cfa22d7a80..00203522ae4 100644
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
index fd2331c8d01..dc458cedc3f 100644
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


