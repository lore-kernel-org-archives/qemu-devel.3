Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BC0CCA472
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FN0-00061E-AG; Thu, 02 Oct 2025 05:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FMv-00060i-7G
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FMQ-0002Xn-8k
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:56 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so505323f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 02:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759396338; x=1760001138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRkL3uKBK3GPfJe3l6z6nN5MWvM4NomVyla+WcmYVI8=;
 b=yzb2R/Eu6KS1UzqVyc4kYw2vILVm7GeU0Yk2egxACzqnNESaTB14N7pgJ2zpuHSnNq
 O2TPAlsvONJBckWuJKMxYMhMxaMLt9KVVseCgOX8P0x0mB4q8Je/gKyLoCzOWxjN88/I
 pj5u7i1GpnGkAAurjCRw4RcT862SFbBr16h32xRwOT05szhoy23b2B9cGcn7q/kmP0V3
 KeqM0e0bvqm7XhbE833kKMxqtPgMrBkNsbcHoVaqdmKSpYyNLHun+lK6+0gQzz/8ih5j
 2eLgUApF9lFlYryEZaXl7i8/dXyKxGjVEi7pCzTPsbEbP8y/0naerFDdVx4SzqD8YZAe
 tnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759396338; x=1760001138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRkL3uKBK3GPfJe3l6z6nN5MWvM4NomVyla+WcmYVI8=;
 b=BAHHw3TFw+wdfHW+HfYJn/koT9uvWoa3uzLSSPdQ3eKWFILHy7QNIaSbyYb7AuGtAN
 6cBqwocsV5AGfCM8MKVmsaSHKDevg1bMMclfAGFRiPedJAhrgMjEiT7pBwLUL35IQXzW
 fuuWSv95bhusJg+1G8g2k2EhPUChN+BwiPorb16u9QnjjolZA0cCe6ZQjHxVVh2ZPPVt
 ZoJKST0q8+9MxlIcM+cpJln0mmjdrpzmO7lg1sDeH0btgoKRUQJN6VJ6MFWsFmXuHNEf
 xoidfj6Fu3GfWZeurCb8i+gPPZhalF2DQGy77CwF4QOpZhZ/Mw74IyB6Gq3d5xg+i74l
 bVaQ==
X-Gm-Message-State: AOJu0YybZTJVa7vsbilpEwcdifSRH4m3G/ZJmRu5wWVZYRd+DfJrBEXi
 8g0K7d4D5OKR/QoDZmh6HZJB2JblMOVTfVsxU69dehySx/X0SS5p2FVnpil4EDFFdJ6331rMRAb
 u/kZI5OkyhQ==
X-Gm-Gg: ASbGncvN8PC6qIdHsW2gNDJzMGQrRCK3oGR4QLdDv0gYcA6OzMLiNgoS/eNxLO7Nyk+
 CjQcXsg4t8aP0gWTL+SrxhS92c/SkII+m1UV+mPdwUKj29w1betXIWkyS+7PioyysTGvcMJe0Sk
 gW5aJ6sTNksBYCSb5HBJtJ05PNuNwvm32GND/PtSUvF9n11tvoPsdNJC8BYMq4tNQ0tYw1XcnFu
 v2tXZ8OPRJ9X6N++aGInJzTFQK/Z8YkeLvYHKbTOQQoA5n6BboGkHYo10yEh+ti5/UYuA5CtSoo
 aYzDFkAXgFjp6VPzHcFYZGYCaJAvoOJQQ6MQ5F6GuxqLPy1M2b3NqpH6tn9s1dK3PaqLTJ33DUW
 jyhrtz3TBPNuNjYfa05preOT4fN+ZWr/Xn4HPVFBOUkeZP+CI2NMUhGJGLOoEzS0JFLp+gPufvI
 LsAJvtkxgAHIdIinQgKf2e16aW3hRLvA==
X-Google-Smtp-Source: AGHT+IHmGucekTGeTTTaXoCS/CxRJ6VOEefqBXNAL0D0DIaIRYEKtBAhiLnwztukMg5U19QkceFydg==
X-Received: by 2002:a05:6000:40d9:b0:40b:c42e:fe39 with SMTP id
 ffacd0b85a97d-42557824ea2mr5072316f8f.40.1759396337656; 
 Thu, 02 Oct 2025 02:12:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6917a867sm26017935e9.5.2025.10.02.02.12.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 02:12:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 9/9] target/s390x: Replace legacy
 cpu_physical_memory_[un]map() calls (3/3)
Date: Thu,  2 Oct 2025 11:11:32 +0200
Message-ID: <20251002091132.65703-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002091132.65703-1-philmd@linaro.org>
References: <20251002091132.65703-1-philmd@linaro.org>
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

Commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
various load and store APIs") mentioned cpu_physical_memory_*()
methods are legacy, the replacement being address_space_*().

Replace the *_map() / *_unmap() methods in s390_store_status()
and s390_store_adtl_status(). In s390_store_status(), replace
cpu_physical_memory_write() by address_space_stb(), restricting
@ar_id scope. No behavioral change expected.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/sigp.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 2487acdb49e..f5d7bc0fa22 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -13,6 +13,7 @@
 #include "s390x-internal.h"
 #include "hw/boards.h"
 #include "system/hw_accel.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "system/address-spaces.h"
 #include "exec/cputlb.h"
@@ -147,7 +148,8 @@ QEMU_BUILD_BUG_ON(sizeof(SigpSaveArea) != 512);
 #define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
 static int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
 {
-    static const uint8_t ar_id = 1;
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    AddressSpace *as = CPU(cpu)->as;
     SigpSaveArea *sa;
     hwaddr len = sizeof(*sa);
     int i;
@@ -157,17 +159,21 @@ static int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
         return 0;
     }
 
-    sa = cpu_physical_memory_map(addr, &len, true);
+    sa = address_space_map(as, addr, &len, true, attrs);
     if (!sa) {
         return -EFAULT;
     }
     if (len != sizeof(*sa)) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
+        address_space_unmap(as, sa, len, true, 0);
         return -EFAULT;
     }
 
     if (store_arch) {
-        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
+        static const uint8_t ar_id = 1;
+
+        address_space_stb(as, offsetof(LowCore, ar_access_id),
+                          ar_id, attrs, NULL);
+
     }
     for (i = 0; i < 16; ++i) {
         sa->fprs[i] = cpu_to_be64(*get_freg(&cpu->env, i));
@@ -189,7 +195,7 @@ static int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
         sa->crs[i] = cpu_to_be64(cpu->env.cregs[i]);
     }
 
-    cpu_physical_memory_unmap(sa, len, 1, len);
+    address_space_unmap(as, sa, len, true, len);
 
     return 0;
 }
@@ -251,16 +257,18 @@ QEMU_BUILD_BUG_ON(sizeof(SigpAdtlSaveArea) != 4096);
 #define ADTL_GS_MIN_SIZE 2048 /* minimal size of adtl save area for GS */
 static int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    AddressSpace *as = CPU(cpu)->as;
     SigpAdtlSaveArea *sa;
     hwaddr save = len;
     int i;
 
-    sa = cpu_physical_memory_map(addr, &save, true);
+    sa = address_space_map(as, addr, &save, true, attrs);
     if (!sa) {
         return -EFAULT;
     }
     if (save != len) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
+        address_space_unmap(as, sa, len, true, 0);
         return -EFAULT;
     }
 
@@ -276,7 +284,8 @@ static int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
         }
     }
 
-    cpu_physical_memory_unmap(sa, len, 1, len);
+    address_space_unmap(as, sa, len, true, len);
+
     return 0;
 }
 
-- 
2.51.0


