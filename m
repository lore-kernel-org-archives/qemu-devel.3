Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027C5CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Eu2-0006ny-5q; Thu, 02 Oct 2025 04:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Eth-0006g8-Ga
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:47 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EtN-0000s6-GG
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so642157f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394534; x=1759999334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWUjqrhoII9IYKgjMFDNsLi+Cgv2QEPokr0XBtkHqiA=;
 b=NEVak5cIVXDcj1830AAQcfXMs9lOpXZXNA0om6CyKyYeYnB5Lg7t2kdY+L4Ux6Ii1e
 BslbubZfZg9aoaS6YKpigMQ7fIl9w04IynhbKNb514f/RJkgrhoJLs/oZfiwRmurThdM
 rp1qoHTXBUAgN73dY2+i9ewN6ceDqXxQlMAXGLYBWed/1HPO6UIe4fGgqesvBANU0GFR
 So8zWEqY/8Y8SJrRWcnPLbHuhAfVwTOLca0TErOqJG+wzOUU6BQyms1UwNMnhXt/pbOY
 ZI8qaXtZxteIv7NyBP3OQ7m3ITNNWrHJQyVj6iYpqq3Q9CZzpiHXjyaSXeiWvFgPwd3+
 UPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394534; x=1759999334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWUjqrhoII9IYKgjMFDNsLi+Cgv2QEPokr0XBtkHqiA=;
 b=fjU1w3JFJwFJF4sqk6VPOH7r+WcmQBoRkjObvkOpDe/WDdATBDRIDB+rWAb6jjK2DM
 IOAEmBLxUwYSJvqfE11xc+B5qETePlkYL4e4FqNN8whNEuKurArwP6QFpRNKOexXYMDw
 rvM6R1ADkH+908YER20FWKIqdEJBUwUSCIHb0vFEU0gkYgL3DquIknejZX9n++AaV3tb
 WU2GoAXVWYGUb1K5wrBuJynMsk2/0bXJMF+fekhouz94UbEsbeTTk3VHzOkoC4xnpwkM
 pjJyos7GaOZ2gQWuNOC6TOMKqkYBGv5LGkJh8Wrg1mWcymaCjIJHJK4RFrpaC9NndXPc
 r7Fg==
X-Gm-Message-State: AOJu0Ywg0TRek67Ka3hbra1kOeI0VgxjORWXc7LvsaXCE54q3kWEPRd1
 PzdEJQoZuq3/zBI9x+Cb3jw06YwLVKs6qK08/VXGn7bXsnES4ssfDVEskDJI+13fdCyIMGSwr2l
 N+VBZQH53/Q==
X-Gm-Gg: ASbGncuKOq81Z1bfYcfiyOtb97YXBUpIoFFTk++imcIkUVZqgyTWofitcSzhW7XkIGd
 QlUFnXEMc5j+j/153OKsiINX/ro0HmLwA4rZ56EDgunXRnAdRlIKz4/hv4tWG5v/iHhG2rS8UXj
 dhZx+QZ0zILrdNJAy5NOaXFOKFkKflcisSWhdVvbwmCu+F4FHzNXNtlrD/62aRnEUOSWJUoi7AN
 sNwoBS2fiIs5u8Mp3ZKbVxt+sH+vtwluLdc8LvAdvku1OaYkFo2u49KU+XRQXlFTY3ZNz3mhkrs
 NXZi4eWU5ft7dxvdFILVcexyI+I9LutiLYnJU7HCD9p3jBP+DrK/7kupDJimScQwapL6OEVpr4N
 qYRTixtapiXXKeKcJnoec3S+LEa+To9elyMn6WmfT2MJyr/Jx+w0nkXMaiGWMburDgMSXc8LRhb
 S5kk9kKoWRydHHqusu7PCwUzPehc4ZLg==
X-Google-Smtp-Source: AGHT+IGTHDHXIrJOhOoypYRjJsVDikLhcyRvRa/vBA1Wlz/iaLsadlO4HdF+yc3FSV0R35r+UTvjog==
X-Received: by 2002:a05:6000:2586:b0:3e4:d981:e312 with SMTP id
 ffacd0b85a97d-42557817210mr5123294f8f.62.1759394534260; 
 Thu, 02 Oct 2025 01:42:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e960asm2619549f8f.37.2025.10.02.01.42.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 02/17] system/memory: Factor address_space_is_io() out
Date: Thu,  2 Oct 2025 10:41:47 +0200
Message-ID: <20251002084203.63899-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
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

Factor address_space_is_io() out of cpu_physical_memory_is_io().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/memory.h |  9 +++++++++
 system/physmem.c        | 21 ++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index aa85fc27a10..1b2b0e5ce1e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -3029,6 +3029,15 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
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
index 225ab817883..c2829ab407a 100644
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


