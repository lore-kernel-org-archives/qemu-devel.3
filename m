Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E0EC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xdK-0007ql-Qv; Mon, 06 May 2024 08:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdJ-0007bq-0l
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdH-0002FA-2u
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41ba0bb5837so12252795e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999189; x=1715603989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1p0/bn0v9GB+8nuG2nruzO91sj0ZUfXKvZH/Fy9rq7U=;
 b=d4gLKbveEe4X1q8Vid5upgyFd/8ozH1QK6AY1NkfSc6MCie8EOyF/sF+zbf7qTKnlS
 ffEC74IdSUf0h9aGuX1cc77QieOjyWI/izrZDn11GNDLgv8z1UN/t2aqt8Zg1FbBxJQl
 RxJ9FpT0j3CHaFnoiBMVVeGFckn8ZXw1FD4HU0E06zYHDsfN5gTMU98zIrKEv5qmispC
 qD0UzKgTNRszeX1kdTparvQrwdWX9hDji4FuVt5JIv67Rxmr27GGLmPDgR9QT0M7rPwf
 /4oxKU8UrfHLmneICg6SALj9dhWDIJ74Y0l6z+0/pog3srgMi6/GnBGblnVn0MsrLML8
 xApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999189; x=1715603989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1p0/bn0v9GB+8nuG2nruzO91sj0ZUfXKvZH/Fy9rq7U=;
 b=fPT2wEkh+C70oJujn94Pv1anv0aQxGPdi9MdjxcGccA3OYGfjZO5VV6nzvUvLjn8r3
 SOrSEdleY3ExbR34Y9LCOeflq/xar7b2nyYnd5dhEYN20d3rXBHfFPwJJLHVwmadXm84
 5dnrgysIedVZv++iP38x5md4RbS/vF8nYkeQMtKwT+qvpugtwxqBroptMl1dFasWxCNZ
 x27cedD0mvR8WHjLfKHNKiHUfyJftZORtiI6dHpFhs8dZpuKRBWMXC/411ZtBAASZOcW
 r/WCmzgj9h33ynZ2NrCGfGpwGvja4notGGHjCrCTtCCLDkWe9SaU1LmJUKlSzhCUjCdY
 QnVw==
X-Gm-Message-State: AOJu0Yy+XuBmOebDyHr4KXdYs7eRGNwI9xnvflPzFbTK5eUlhi4TyMzu
 8eYOiOEaYROWMllPrf8TBPHkDG+5/1wcRcqTlWF8GBRku/zY3Dc5YSxWUavru+ORj4aJRy75lLV
 k
X-Google-Smtp-Source: AGHT+IE333ToYqtTxLOqMVXEoZqDwY5eSkpBSHiWA8AgOwiCUvATpQJZie1VWWDZVFv+5dFTBV0Ceg==
X-Received: by 2002:a05:600c:5251:b0:418:e04b:ee63 with SMTP id
 fc17-20020a05600c525100b00418e04bee63mr6910750wmb.36.1714999189222; 
 Mon, 06 May 2024 05:39:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 je8-20020a05600c1f8800b0041bf28aa11dsm15935813wmb.42.2024.05.06.05.39.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:39:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/28] xen: mapcache: Refactor xen_remap_bucket for
 multi-instance
Date: Mon,  6 May 2024 14:37:20 +0200
Message-ID: <20240506123728.65278-21-philmd@linaro.org>
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add MapCache argument to xen_remap_bucket in preparation
to support multiple map caches.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240430164939.925307-6-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 9e0a56b41b..6bb3e0b362 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -139,7 +139,8 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
     mapcache->entry = g_malloc0(size);
 }
 
-static void xen_remap_bucket(MapCacheEntry *entry,
+static void xen_remap_bucket(MapCache *mc,
+                             MapCacheEntry *entry,
                              void *vaddr,
                              hwaddr size,
                              hwaddr address_index,
@@ -313,14 +314,14 @@ tryagain:
     if (!entry) {
         entry = g_new0(MapCacheEntry, 1);
         pentry->next = entry;
-        xen_remap_bucket(entry, NULL, cache_size, address_index, dummy);
+        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
     } else if (!entry->lock) {
         if (!entry->vaddr_base || entry->paddr_index != address_index ||
                 entry->size != cache_size ||
                 !test_bits(address_offset >> XC_PAGE_SHIFT,
                     test_bit_size >> XC_PAGE_SHIFT,
                     entry->valid_mapping)) {
-            xen_remap_bucket(entry, NULL, cache_size, address_index, dummy);
+            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
         }
     }
 
@@ -588,7 +589,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
 
     trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
 
-    xen_remap_bucket(entry, entry->vaddr_base,
+    xen_remap_bucket(mapcache, entry, entry->vaddr_base,
                      cache_size, address_index, false);
     if (!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
-- 
2.41.0


