Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA2FCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ige-00051H-IG; Mon, 29 Sep 2025 14:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IgW-000502-VN
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IgS-00031t-Bk
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so38189215e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170788; x=1759775588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGMp7t36URRQSytZ84th6z88iiyCKyUd2WF0ymWy9Sc=;
 b=kNblKHb+av1Qs06CUh3LC+xJN9lP+95IKG2HV9fSMbZ0bhLbh48xeTQnyjCnvOS1nR
 xYY7Msn91ku9VJ/9gIwSIerEsp11qC5uTESGwWioPdTsA+NSC+Wsyv63+/mptDMagxqm
 qW2fck+OxBNFLK1VqlFC09ailxiYQIFLv/vLoaOPch2wmFTTKND3MzMx7ZWRSMdxYDTY
 As5I6UVElaaJfoGTv0pgckIChR025i6EEAaqUh54xzCh1cmEKLLnNO+g94sEp6MXdIj9
 u3OMNrfTlPooIDLHzyH1Je6lJEMfBXy2ByrKRjXtO6gPrRSb3r4l/NQIMvDxCh9J4U2x
 wvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170788; x=1759775588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rGMp7t36URRQSytZ84th6z88iiyCKyUd2WF0ymWy9Sc=;
 b=opBXlL9RseZkfbYn1UY0N7qdGFrY0SYtkF9EQWaJRydBFYkpLKjdprCGdFstx3rpBp
 H6JNZBP0fkMhdY51EfhX9psRiFgOE7shDQx7MBcWT5YseY4hk6zSWEthwSJh6O7VEdbV
 ZelonJIQjPSSxSio1dH2AkMBQcgYvqx23Aw5M9OYMNeCLeDWjijF4uBVY09IcyG5cjqA
 mr4OJd1DvR6p7QM4jJh11r8k7rxfomZEqVAApWs2ivcWdE43SopUHJlvDkLE0ESuKf44
 ZnkOpT9WW2HVYNJSekgGZuRfVKzq0VbiCrLM1T0h/h8OwuOus3LCYl4QqWVhrM3D/koZ
 5pBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHmFnjMFHXzu5gcCzMS4yCPY7WDrZeS1FD7l+VmwhE8aRJjLYywQQ+ICIC1XFQgnxlmeCZ12bI+PjE@nongnu.org
X-Gm-Message-State: AOJu0YydOIC3BIHHIU1nRhvcXfmOPErIK6+qXhI2uB2+9SzQAxOT+dhT
 YPYU3SCpk6Q1k2TnGz2rbgJbDSHD4TPLBtPm9jDKybbhUgK2bNAd+rg4/9AZin1/8IY=
X-Gm-Gg: ASbGncsxLhmucM9qNzyWxFypzIrUVlYV2EwJTpTt5pwM00dAEbhVbJKIWlqbno+mVhV
 2snOwAH99q/EwjTQa8kecGmTlSVsXeKG8i43aRk6nQiZ3ix1sav44cV2lJD2k1Ca4m6N4qQRpqU
 1j8DOCCQUopUFwGQlbx6ukRW1WzA+bnIMA+ForOyHaoQiulWgm75Ors5wQkzhUbA2YQFniaFXcc
 WOvENThgsJoe5505ApbemNwYfDQGNUebzcXU9vaRIiYXp+cZ0a/TAy+wl8kmy9UAE9NYMD4RuBQ
 kWe5a5jOu6UTA20uCQHwa2vluRFgVaevACTfyc7PN5dZoy4tXm2Y1JG+7CJ3NHm3Z5P78SKtD5z
 S42KEBrdd6NVK+hMmJqkJ/rzmeukSshRCGuMBUd5OPFwOrONjYxRZm8FLU0tbBHP0SCNIr+PX
X-Google-Smtp-Source: AGHT+IHywbu3bHq36g4SNbzTfpiE+7B23z7rbV7w73oeTvg9ANkjyrRL+PYW3W+Y3jHxmFSC/MGdsQ==
X-Received: by 2002:a05:600c:6303:b0:46e:376c:b1f0 with SMTP id
 5b1f17b1804b1-46e376cb318mr142020765e9.7.1759170788090; 
 Mon, 29 Sep 2025 11:33:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602f15sm19310452f8f.39.2025.09.29.11.33.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:07 -0700 (PDT)
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
Subject: [PATCH 02/15] system/memory: Factor address_space_memory_is_io() out
Date: Mon, 29 Sep 2025 20:32:41 +0200
Message-ID: <20250929183254.85478-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Factor address_space_memory_is_io() out of cpu_physical_memory_is_io()
passing the address space and range length as argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h | 10 ++++++++++
 system/physmem.c        | 21 ++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index aa85fc27a10..6cfa22d7a80 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -3029,6 +3029,16 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
 bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
                                 bool is_write, MemTxAttrs attrs);
 
+/**
+ * address_space_memory_is_io: check whether an address space range is
+ *                             I/O memory.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @len: length of the area to be checked
+ */
+bool address_space_memory_is_io(AddressSpace *as, hwaddr addr, hwaddr len);
+
 /* address_space_map: map a physical memory region into a host virtual address
  *
  * May map a subset of the requested range, given by and returned in @plen.
diff --git a/system/physmem.c b/system/physmem.c
index 8a8be3a80e2..18b3d38dc0c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3358,6 +3358,17 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr,
     return flatview_access_valid(fv, addr, len, is_write, attrs);
 }
 
+bool address_space_memory_is_io(AddressSpace *as, hwaddr addr, hwaddr len)
+{
+    MemoryRegion*mr;
+
+    RCU_READ_LOCK_GUARD();
+    mr = address_space_translate(as, addr, &addr, &len, false,
+                                 MEMTXATTRS_UNSPECIFIED);
+
+    return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
+}
+
 static hwaddr
 flatview_extend_translation(FlatView *fv, hwaddr addr,
                             hwaddr target_len,
@@ -3754,15 +3765,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 
 bool cpu_physical_memory_is_io(hwaddr phys_addr)
 {
-    MemoryRegion*mr;
-    hwaddr l = 1;
-
-    RCU_READ_LOCK_GUARD();
-    mr = address_space_translate(&address_space_memory,
-                                 phys_addr, &phys_addr, &l, false,
-                                 MEMTXATTRS_UNSPECIFIED);
-
-    return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
+    return address_space_memory_is_io(&address_space_memory, phys_addr, 1);
 }
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
-- 
2.51.0


