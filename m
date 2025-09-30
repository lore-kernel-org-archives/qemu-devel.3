Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE38FCCA46F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RkS-0001fW-WE; Tue, 30 Sep 2025 00:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RkQ-0001e6-VQ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:13:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RkK-0000le-T5
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:13:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3e8ef75b146so3727301f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205626; x=1759810426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6XZQA4g1t2k7eXHW7Di/TUkQvEa/xc7WHxCnzJSKoM=;
 b=lHzMG+yyjDRozOZGjr2nuKgT7A8TpqOpCuHAoDW+JDQj59ubQ8PAyvNRmXRSJtQFUY
 qtHfJSvMbnQXZo5yat6eEmtx7bnclypf4GU6acr6yjAdz1zRCz6FHeGc5f1PCPsXkQPm
 hZVSiPK2XoavbdbjgRY3lDKPMTzGrFOAf+x3Wu+qLAvz1wMyZMulpLcGyTuRRsw/xoZU
 7RZ50A36Z7aYMdjSX0zHN3lMpsoPdO3+CnoqZRdjCnIVBRFTBhQN8vzRLvIWAsHCVrNX
 d3nm4LUywb0x8+I2on00VEbaT+2WPacSyMPPuNPkWpZDIaVnlYcmynleralKlIMrKmam
 J6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205626; x=1759810426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6XZQA4g1t2k7eXHW7Di/TUkQvEa/xc7WHxCnzJSKoM=;
 b=S5EdK7UrXEymXGB7CSB35xVh1MhlW6WB71FPvbfHO0Vp6D5EcJNIOsoj70w8dbuLi0
 EubGCgh/9t6bFZnzxS5PnU7SOxKFXEEjIXzPGGwHVDNbXo1QhJMFLO0lYxxQKwQygvyd
 g4r8irfuoisYfpdOhrFQiC1w5Z0aNIjiEieUdAZxZ31+aTeGriwTZ36oO+A15M5ruwns
 xMH48y2frn7JgeD1sA96kgXUEzkB8PG7Q5ezZzcEIx6qxuM5j00QmqydKcAc+C6Pzem7
 MM7+lyn08g/ZJZ+WSRxHWxNwOSYHnCiAVkd537CrZik5RXTN17RVZr2l7luKHwreedlz
 m8Qg==
X-Gm-Message-State: AOJu0YxKX8pUwYi+4FpXhrOm45Xud/IBinVvJuTOs8dAusZb/T85whd3
 1HxeR6enuR/tBq5fdmrc2p3SUaqMRwkGiv9nUXt0xfwByrctDJWY3Ef6fk8NUOPpIYACSYhp9ry
 ESDAEWE0l3A==
X-Gm-Gg: ASbGncv5x0HNZbEemzbOLTrAW3jaSYTDp13zS4p+8nZ5V52YcuZHKPcLc0xuvaVXl1c
 sn0jM2+ZDriY0x3VxA5LEQBzg3TrUoCns5YXAIaogs3cn5VkxHT4QKelQVXfpWwVNfrJYdVHeaa
 HNxw/6e37WXEcCP5luuk13RnApLE/UrSbe8X6sUgfdxBjzRwIHr2qyZzPP0PpbbQpH6WZ1nYuIC
 ugQoNrHfkHdZzCgnLLZFhJ4hscxcDjRiak1UrMPfapqjgEfZaaHMHY3M4s9f3xLgG6SLf+CeOcc
 1X44hmTZor5IVDaGC3jojiO2NgjQrlUYCcgvykMNagHpjjIckaZqA7VJkyKVXpQ5YwZmzRZrTCN
 g0Dv5LyHixdRbwH8fzPBXKVMyfgwNJ7bo71TwV9Azlz4D/nzHAH7zBF8zItL4at/pYRTcrMEjmO
 uBVS1YGsCcltk1T2D8OrHI3dQcv9IYUfYsmu33VemDlw==
X-Google-Smtp-Source: AGHT+IH4qhPqaNC0ZqE7vVzxj8tSipzOFCi7y5DLl309Ye1K/9debpwVgj0eZ2sdSCTFy4WRMq+1ZQ==
X-Received: by 2002:a05:6000:2901:b0:3ef:42fe:8539 with SMTP id
 ffacd0b85a97d-40e47ee0a37mr19502672f8f.25.1759205626154; 
 Mon, 29 Sep 2025 21:13:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc56f7badsm20596977f8f.29.2025.09.29.21.13.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:13:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 03/17] system/memory: Factor address_space_is_io() out
Date: Tue, 30 Sep 2025 06:13:11 +0200
Message-ID: <20250930041326.6448-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Factor address_space_is_io() out of cpu_physical_memory_is_io().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h |  9 +++++++++
 system/physmem.c        | 21 ++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3e5bf3ef05e..546c643961d 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -3030,6 +3030,15 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
 bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
                                 bool is_write, MemTxAttrs attrs);
 
+/**
+ * address_space_is_io: check whether an guest physical addresses
+ *                      whithin an address space is I/O memory.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ */
+bool address_space_is_io(AddressSpace *as, hwaddr addr);
+
 /* address_space_map: map a physical memory region into a host virtual address
  *
  * May map a subset of the requested range, given by and returned in @plen.
diff --git a/system/physmem.c b/system/physmem.c
index 2d1697fce4c..be8e66dfe02 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3358,6 +3358,17 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr,
     return flatview_access_valid(fv, addr, len, is_write, attrs);
 }
 
+bool address_space_is_io(AddressSpace *as, hwaddr addr)
+{
+    MemoryRegion *mr;
+
+    RCU_READ_LOCK_GUARD();
+    mr = address_space_translate(as, addr, &addr, NULL, false,
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
+    return address_space_is_io(&address_space_memory, phys_addr);
 }
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
-- 
2.51.0


