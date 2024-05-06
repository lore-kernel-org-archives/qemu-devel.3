Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E407C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xeU-0003vP-7m; Mon, 06 May 2024 08:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xe0-0003e3-Lq
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdl-0002VW-3b
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ffso10137955e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999219; x=1715604019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJEndL+RDFNTj+y6nM23b2p4J1hp6d4o1ioofR186sw=;
 b=NMWPXn6gg9SulVb95ge6RffX0FEJO7kCrXhpUZGc4WajoFgMEa/hT+Uh5F6xaXIk+W
 6Y4KDrt0DoNN0JodHh0e4sBVA3Bq4jeYVERsx5R6P+huWXcoxKyqc3zTIqGNe+UZggqU
 dj4LJ3rb3N6kl2lB27WUpDTqj4qmpK6nrsrfk9LYiFNxR7rLUCNZvELDN6rk8XUQTlwi
 bTwEOP2c33N+0s6xOS+8nv0BC5Tl19zANhRdlu5ak8fEKlVMMRai41wlARHIRHH7Bsnk
 90ZlgtL5dZ8PgcZm3+IeOLvapdxkqMwzy+O2+PEkJLQumCTtVvPEDNSzsPXz0UF2tSvi
 Yvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999219; x=1715604019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJEndL+RDFNTj+y6nM23b2p4J1hp6d4o1ioofR186sw=;
 b=JfY2yhyA1X3G9c5eP8W7Ow+0EyszO2HQhOlgNs5RJwiexSJDhM9IAfJ8PJASHcoRNH
 WPDInEp3YeH511cg44nA0cgZXzzxTT0hl+EPYGSZVap3niXTARqScVvVyOlusDxrPMZJ
 HpnX60bE7R4RGlnM6OkTEn98PkAN/S3JdpZCy5wCIrL5wEOJSQX2FhUpeXiQSmjq5yxd
 01joDK0G/eCEUy3Bq7jhnLLxq8BecbUGWGHbWyuvLzY1NVmJCrK8Ej5bu9Hxhg0FXOYk
 hvPcBJlHnhgd0jMCbHdYoCNz/woR39+CYoLwuvohzRXSB+gL5RNtV+DC8uvO7UYIABO3
 3YCw==
X-Gm-Message-State: AOJu0YyhY6PQ95yXSmG1pxVEOkllcldUnpE5yKmHuwR0w6zVC0WUD/sP
 NsrP/GHifXm6CdNWILNe+4abIZdCyMAu7YS8WcjfYHSlrcFT65LNQf9uKLknXPogydyj8VqQD+u
 6
X-Google-Smtp-Source: AGHT+IEbW9pCSxBmVIiD95OekcamcdE9eK6mt4xa/nRLuUkxl05tWUWpuFjMBHs+B0kQCWoFWztOzA==
X-Received: by 2002:a05:600c:3b1b:b0:418:f5a:580b with SMTP id
 m27-20020a05600c3b1b00b004180f5a580bmr11738521wms.18.1714999219311; 
 Mon, 06 May 2024 05:40:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 t12-20020a05600c198c00b0041becb7ff05sm15710181wmq.26.2024.05.06.05.40.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:40:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/28] xen: mapcache: Break out xen_map_cache_init_single()
Date: Mon,  6 May 2024 14:37:25 +0200
Message-ID: <20240506123728.65278-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Break out xen_map_cache_init_single() in preparation for
adding multiple map caches.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <20240430164939.925307-11-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c | 57 ++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index c8a0f4fbc2..6fb2db2612 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -93,23 +93,44 @@ static inline int test_bits(int nr, int size, const unsigned long *addr)
         return 0;
 }
 
-void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
+static MapCache *xen_map_cache_init_single(phys_offset_to_gaddr_t f,
+                                           void *opaque,
+                                           unsigned long max_size)
 {
     unsigned long size;
+    MapCache *mc;
+
+    mc = g_new0(MapCache, 1);
+
+    mc->phys_offset_to_gaddr = f;
+    mc->opaque = opaque;
+    qemu_mutex_init(&mc->lock);
+
+    QTAILQ_INIT(&mc->locked_entries);
+
+    mc->max_mcache_size = max_size;
+
+    mc->nr_buckets =
+        (((mc->max_mcache_size >> XC_PAGE_SHIFT) +
+          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
+         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
+
+    size = mc->nr_buckets * sizeof(MapCacheEntry);
+    size = (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
+    trace_xen_map_cache_init(mc->nr_buckets, size);
+    mc->entry = g_malloc0(size);
+    return mc;
+}
+
+void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
+{
     struct rlimit rlimit_as;
-
-    mapcache = g_new0(MapCache, 1);
-
-    mapcache->phys_offset_to_gaddr = f;
-    mapcache->opaque = opaque;
-    qemu_mutex_init(&mapcache->lock);
-
-    QTAILQ_INIT(&mapcache->locked_entries);
+    unsigned long max_mcache_size;
 
     if (geteuid() == 0) {
         rlimit_as.rlim_cur = RLIM_INFINITY;
         rlimit_as.rlim_max = RLIM_INFINITY;
-        mapcache->max_mcache_size = MCACHE_MAX_SIZE;
+        max_mcache_size = MCACHE_MAX_SIZE;
     } else {
         getrlimit(RLIMIT_AS, &rlimit_as);
         rlimit_as.rlim_cur = rlimit_as.rlim_max;
@@ -119,24 +140,14 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
                         " memory is not infinity");
         }
         if (rlimit_as.rlim_max < MCACHE_MAX_SIZE + NON_MCACHE_MEMORY_SIZE) {
-            mapcache->max_mcache_size = rlimit_as.rlim_max -
-                NON_MCACHE_MEMORY_SIZE;
+            max_mcache_size = rlimit_as.rlim_max - NON_MCACHE_MEMORY_SIZE;
         } else {
-            mapcache->max_mcache_size = MCACHE_MAX_SIZE;
+            max_mcache_size = MCACHE_MAX_SIZE;
         }
     }
 
+    mapcache = xen_map_cache_init_single(f, opaque, max_mcache_size);
     setrlimit(RLIMIT_AS, &rlimit_as);
-
-    mapcache->nr_buckets =
-        (((mapcache->max_mcache_size >> XC_PAGE_SHIFT) +
-          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
-         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
-
-    size = mapcache->nr_buckets * sizeof (MapCacheEntry);
-    size = (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
-    trace_xen_map_cache_init(mapcache->nr_buckets, size);
-    mapcache->entry = g_malloc0(size);
 }
 
 static void xen_remap_bucket(MapCache *mc,
-- 
2.41.0


