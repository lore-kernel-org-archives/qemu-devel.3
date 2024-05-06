Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141D3C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xdd-0001pw-8S; Mon, 06 May 2024 08:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdb-0001cS-A8
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:11 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdN-0002GC-33
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41ecffed96cso7453785e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999195; x=1715603995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4urpjGwVcUdPIyFtNL9dEzEEHSDiRFQ9VHY+BzuV2Y=;
 b=IVKtoWjqKtVktFcdAandzSSu+DFdycOSpfmuhQezv2PFoph5VPsV2SQ04GgDNRjjTq
 JWqjlJn79nnWxuEK/qyUXtDUuN9B4wDtTZYbo8zjVXZdya5sbYTGy58WcJOR0+8N0ATy
 np5MikktY13SNQLSY/XbMr9tHPYycNFikzNZEFfNe21KPQlbdrmg8kPNH7o3wIi6Xojc
 acAYDtziyJEbrdQFZxy2V5B9CI/LvviWx7w60+0XyIqZ9UoLVzGz9PyZ+k17+z9/CEy4
 JTZ28IhPgw7N+qpWm0yABKasGheat43gfKk96dYDN6ZG2758138XWdq2W4CDJIhypZUT
 DgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999195; x=1715603995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4urpjGwVcUdPIyFtNL9dEzEEHSDiRFQ9VHY+BzuV2Y=;
 b=Bdua9xNPbyYIlMkf0AgRd3oNwO4SlCr7LmoKgx49SJ/IlXGWdFTDBNxYef0f8F4zgi
 JG3i2sFqCtm3cyspRe7VNR7p++cSP+JvNOIOQAFdPfiJag8knadNknrd8/m+ail14iam
 Qm1p6CUy12oG9wAAPS02KhfaUjDmNgku2f/gFKDGyo2nLrtoelo6CPdKvXCjI3IJW5Az
 7gnnZ8N37UWIVG1qrMIpe0PqH7WwcBjZal0tec1NS+EIZWrNJ6RDWUNP8O10URqlAHof
 pwUe4Wnc8KYubM3/HMIr5GZKLFsGhBIV2+rmWisaZnXnY/+jLi8ASVEhPI9zb/GWnVgq
 D9dA==
X-Gm-Message-State: AOJu0YwDGob71BkwlkPRndC4ujPm+xItM6NdvVNtRAAxXVEzXFK8HlvZ
 zqc5EWf1GDYsKgYoMQs79varLRMQBB4WrmeFCh+hngo+PmKv1MU0RCYVQc5sqVaBQ4DYNKdeLnk
 X
X-Google-Smtp-Source: AGHT+IGPNRwKYFoQVYPoXwYarwqyoWZi7MGx8rAfs5YxJLb6ey0aUamn0u7zx0t7PnylKyU0HBsgWw==
X-Received: by 2002:adf:f0cd:0:b0:34d:7cdf:7fb3 with SMTP id
 x13-20020adff0cd000000b0034d7cdf7fb3mr7038544wro.62.1714999195378; 
 Mon, 06 May 2024 05:39:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 b12-20020a5d4d8c000000b0034e65b8b43fsm8616106wru.8.2024.05.06.05.39.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:39:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/28] xen: mapcache: Break out
 xen_ram_addr_from_mapcache_single
Date: Mon,  6 May 2024 14:37:21 +0200
Message-ID: <20240506123728.65278-22-philmd@linaro.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Break out xen_ram_addr_from_mapcache_single(), a multi-cache
aware version of xen_ram_addr_from_mapcache.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240430164939.925307-7-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 6bb3e0b362..1927334e9f 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -377,7 +377,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
     return p;
 }
 
-ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
+static ram_addr_t xen_ram_addr_from_mapcache_single(MapCache *mc, void *ptr)
 {
     MapCacheEntry *entry = NULL;
     MapCacheRev *reventry;
@@ -386,8 +386,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     ram_addr_t raddr;
     int found = 0;
 
-    mapcache_lock(mapcache);
-    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+    mapcache_lock(mc);
+    QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
         if (reventry->vaddr_req == ptr) {
             paddr_index = reventry->paddr_index;
             size = reventry->size;
@@ -397,11 +397,11 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     }
     if (!found) {
         trace_xen_ram_addr_from_mapcache_not_found(ptr);
-        mapcache_unlock(mapcache);
+        mapcache_unlock(mc);
         return RAM_ADDR_INVALID;
     }
 
-    entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
+    entry = &mc->entry[paddr_index % mc->nr_buckets];
     while (entry && (entry->paddr_index != paddr_index || entry->size != size)) {
         entry = entry->next;
     }
@@ -412,10 +412,15 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
              ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
     }
-    mapcache_unlock(mapcache);
+    mapcache_unlock(mc);
     return raddr;
 }
 
+ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
+{
+    return xen_ram_addr_from_mapcache_single(mapcache, ptr);
+}
+
 static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
 {
     MapCacheEntry *entry = NULL, *pentry = NULL;
-- 
2.41.0


