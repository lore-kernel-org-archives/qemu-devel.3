Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748F9C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xcz-0004hi-6f; Mon, 06 May 2024 08:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcv-0004Ak-54
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcr-0002AP-Tq
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41b869326daso12685915e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999163; x=1715603963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2dIn65/w/ORbBuM0bD/NrI0A+aMa+5s4kd6JrVU3Ow=;
 b=ne9/5zCF4a6KBoTxso5oiw1IT0sa2um0InHsTdtLsJ4qRxmES+r1vLagCwbG8Hg30S
 0U296T7XMfbIKbOt4zrBwc09wI0V0ZOsaDNMf2XJV3mY5H3biL0LIPaZ+DA52a4W3kh3
 ENwdn98zXGwN7/1lBhkQeDcs9auHq8n4qDExo6iTaAwKQ/7CfYfQ7a4K7X+adfOe46f4
 RIFAIn1KOWN9VlSPWnDX/oj2NZNPs2bvkDfLtvWTPMGNLmzxd7Ix//hjnAIANnf3UCwH
 BYp8N1VDYKvPPXHfZIwOxFsNkoLw44YXOEODQJArQuFQGkhnlzmqzLkZKqPlK16a/oIs
 r9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999163; x=1715603963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2dIn65/w/ORbBuM0bD/NrI0A+aMa+5s4kd6JrVU3Ow=;
 b=RGwEfhHAldY4TPdlediV2FGzl+OdiLlyW4rgpLzK/3YdTNVcy2QDjD5Tv5kYYpJbC2
 MZmX4hBe8vkFXRx0oe046eb85TcMJIpHWfFq7ejm4AZybZjpluyas9OYDNXd3fi4lhpq
 IEE7N4E4JLabqvstlPwVLB9mY+tVmkNJVgqJv1BSYPIIFojNlleaCI+WKKy47FdJ2vPu
 T5LYvz+QdzKwqCK4Rg38Kr2mHYDLDAGkMdsYtv0h87yw68Z1sleSZCFdEZzEO5JSyjI9
 n4ebNHtr+XebNVQSzVzN6v/9bvf5QEQQzux41+11qnx1Lx+N2ltX0jUJgE9uwL391NUv
 nh4w==
X-Gm-Message-State: AOJu0YxDtAZyv3+BLqbN40DAmEhVK8YcaCS1YY7BhUO1R0PJM1M0X7Wb
 wKfv51qfBT4wPRw5Yau59di21E0d3ShmBGoyzPHJdh7RxakMbRIc293VmS9K4+O3HMPkNyNTwrj
 a
X-Google-Smtp-Source: AGHT+IG5LkalA9evUZcXrg2R+nrEB2VaTNou43/ArIbteJYO9aS4/UNI94k7ZjyXXW7zG/TkPHWsgg==
X-Received: by 2002:a05:6000:1963:b0:34a:d1d4:cb3c with SMTP id
 da3-20020a056000196300b0034ad1d4cb3cmr9155061wrb.39.1714999163635; 
 Mon, 06 May 2024 05:39:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 t7-20020a5d6907000000b00349bd105089sm10559984wru.47.2024.05.06.05.39.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:39:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Juergen Gross <jgross@suse.com>, Vikram Garhwal <vikram.garhwal@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/28] softmmu: let qemu_map_ram_ptr() use qemu_ram_ptr_length()
Date: Mon,  6 May 2024 14:37:16 +0200
Message-ID: <20240506123728.65278-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Juergen Gross <jgross@suse.com>

qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so
modify qemu_ram_ptr_length() a little bit and use it for
qemu_map_ram_ptr(), too.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227223501.28475-4-vikram.garhwal@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20240430164939.925307-2-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 56 ++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 44e477a1a5..8278e31c1a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2189,43 +2189,17 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
 }
 #endif /* !_WIN32 */
 
-/* Return a host pointer to ram allocated with qemu_ram_alloc.
- * This should not be used for general purpose DMA.  Use address_space_map
- * or address_space_rw instead. For local memory (e.g. video ram) that the
- * device owns, use memory_region_get_ram_ptr.
- *
- * Called within RCU critical section.
- */
-void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr)
-{
-    if (block == NULL) {
-        block = qemu_get_ram_block(addr);
-        addr -= block->offset;
-    }
-
-    if (xen_enabled() && block->host == NULL) {
-        /* We need to check if the requested address is in the RAM
-         * because we don't want to map the entire memory in QEMU.
-         * In that case just map until the end of the page.
-         */
-        if (block->offset == 0) {
-            return xen_map_cache(addr, 0, 0, false);
-        }
-
-        block->host = xen_map_cache(block->offset, block->max_length, 1, false);
-    }
-    return ramblock_ptr(block, addr);
-}
-
-/* Return a host pointer to guest's ram. Similar to qemu_map_ram_ptr
- * but takes a size argument.
+/*
+ * Return a host pointer to guest's ram.
  *
  * Called within RCU critical section.
  */
 static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
                                  hwaddr *size, bool lock)
 {
-    if (*size == 0) {
+    hwaddr len = 0;
+
+    if (size && *size == 0) {
         return NULL;
     }
 
@@ -2233,7 +2207,10 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
         block = qemu_get_ram_block(addr);
         addr -= block->offset;
     }
-    *size = MIN(*size, block->max_length - addr);
+    if (size) {
+        *size = MIN(*size, block->max_length - addr);
+        len = *size;
+    }
 
     if (xen_enabled() && block->host == NULL) {
         /* We need to check if the requested address is in the RAM
@@ -2241,7 +2218,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(addr, *size, lock, lock);
+            return xen_map_cache(addr, len, lock, lock);
         }
 
         block->host = xen_map_cache(block->offset, block->max_length, 1, lock);
@@ -2250,6 +2227,19 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
     return ramblock_ptr(block, addr);
 }
 
+/*
+ * Return a host pointer to ram allocated with qemu_ram_alloc.
+ * This should not be used for general purpose DMA.  Use address_space_map
+ * or address_space_rw instead. For local memory (e.g. video ram) that the
+ * device owns, use memory_region_get_ram_ptr.
+ *
+ * Called within RCU critical section.
+ */
+void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
+{
+    return qemu_ram_ptr_length(ram_block, addr, NULL, false);
+}
+
 /* Return the offset of a hostpointer within a ramblock */
 ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
 {
-- 
2.41.0


