Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2166CC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xdi-0002Ob-Bc; Mon, 06 May 2024 08:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdf-00027g-JQ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdZ-0002IW-FW
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34db6a299b8so1194869f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999207; x=1715604007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ri6vQTLDDsyaTfFoI8+TokF2rNRkB8/RJlz+zNYMusQ=;
 b=KpiB54GC5hJhVs68H1UYudugF/+wT9O5J2zkZdmKD31b0xPCyf0sZWMI3rAwBZNbEg
 KKJsDzcbci45sB/Bq6OKWk+r3dXS1caTXRam1zDxP02zX3SfSfta7jHS3Cz/Tsc/l079
 EfgETt67gUNjZvLE8eSYL0pqr1W8brGA4rn7WC7qbSOVhDhZ69EovSwVCO76TZlZ1DMX
 8Rrrt3AXxFN+ge+KhoQuonbl2AQsE5BWXluvJ8vSPcw/b3/jFsC0CzfQtkONuTbqCKwx
 VkYFzL3YluTvNnvKoFZo46CR1DWRnqK5syxX34dU4sDKAHUivQdFtEt7saoylHFpt8cV
 AdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999207; x=1715604007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ri6vQTLDDsyaTfFoI8+TokF2rNRkB8/RJlz+zNYMusQ=;
 b=sXksf4f2G+K5QthJYMf1Zkh9sQdqYnYmCWRZGYYMgWviY6wfxBoOJkBufZFffD5nNI
 i5dHC0/FfrkXvl1xoepweQK/Vbytg30eXvIVYtQ50jZgn874kf6cXAfHDODo5EyJIbzu
 JfDeRKZ1hxBVRr9TApNLlL9hSEzzQH5+A+ZKrsi5QDFvidi4uiJUL//Bpc7+QJiC5jf9
 fhN8tYKl/jWjNmNnzF0vDFgNqha5v3OVYbxjVWLKCDYGzD5M8+QSdtl1omFxmLoCZB0h
 71o2LjljTyI+OEFOBrVLpJUq0QxxdBa1VwZ9HVOLx7qVocEKHnobesRL0Kwbv9ahrcRL
 uPQQ==
X-Gm-Message-State: AOJu0YziL1e8Xe2fM4IY2+N/imuZ6yj12HapNZvG+ClNR7Fm9TEwzZKU
 lBQ7ER3g+fSmH1Ut9t/kAhsAqplUHEATSdA9bzKi72nvKMZRlcK1g/bdCykPq4SD5hejuwAiOfY
 e
X-Google-Smtp-Source: AGHT+IExjxfnAg+QCSmi2xtpf/6/diX5tlYTTgSKCXT6HemC00zQq3tPaOYEV1pS6KZrruagaDww1g==
X-Received: by 2002:a5d:4409:0:b0:34d:384:2dd4 with SMTP id
 z9-20020a5d4409000000b0034d03842dd4mr6242519wrq.60.1714999207264; 
 Mon, 06 May 2024 05:40:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 j30-20020a5d6e5e000000b0034db5f648a8sm10669808wrz.77.2024.05.06.05.40.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:40:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/28] xen: mapcache: Refactor
 xen_invalidate_map_cache_entry_unlocked
Date: Mon,  6 May 2024 14:37:23 +0200
Message-ID: <20240506123728.65278-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add MapCache argument to xen_invalidate_map_cache_entry_unlocked.
This is in preparation for supporting multiple map caches.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240430164939.925307-9-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 96c422981e..3e6a1a0a93 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -421,7 +421,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     return xen_ram_addr_from_mapcache_single(mapcache, ptr);
 }
 
-static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
+static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
+                                                    uint8_t *buffer)
 {
     MapCacheEntry *entry = NULL, *pentry = NULL;
     MapCacheRev *reventry;
@@ -429,7 +430,7 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
     hwaddr size;
     int found = 0;
 
-    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+    QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
         if (reventry->vaddr_req == buffer) {
             paddr_index = reventry->paddr_index;
             size = reventry->size;
@@ -439,7 +440,7 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
     }
     if (!found) {
         trace_xen_invalidate_map_cache_entry_unlocked_not_found(buffer);
-        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+        QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
             trace_xen_invalidate_map_cache_entry_unlocked_found(
                 reventry->paddr_index,
                 reventry->vaddr_req
@@ -447,15 +448,15 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
         }
         return;
     }
-    QTAILQ_REMOVE(&mapcache->locked_entries, reventry, next);
+    QTAILQ_REMOVE(&mc->locked_entries, reventry, next);
     g_free(reventry);
 
-    if (mapcache->last_entry != NULL &&
-        mapcache->last_entry->paddr_index == paddr_index) {
-        mapcache->last_entry = NULL;
+    if (mc->last_entry != NULL &&
+        mc->last_entry->paddr_index == paddr_index) {
+        mc->last_entry = NULL;
     }
 
-    entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
+    entry = &mc->entry[paddr_index % mc->nr_buckets];
     while (entry && (entry->paddr_index != paddr_index || entry->size != size)) {
         pentry = entry;
         entry = entry->next;
@@ -489,7 +490,7 @@ static void xen_invalidate_map_cache_entry_bh(void *opaque)
     XenMapCacheData *data = opaque;
 
     mapcache_lock(mapcache);
-    xen_invalidate_map_cache_entry_unlocked(data->buffer);
+    xen_invalidate_map_cache_entry_unlocked(mapcache, data->buffer);
     mapcache_unlock(mapcache);
 
     aio_co_wake(data->co);
@@ -507,7 +508,7 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
         qemu_coroutine_yield();
     } else {
         mapcache_lock(mapcache);
-        xen_invalidate_map_cache_entry_unlocked(buffer);
+        xen_invalidate_map_cache_entry_unlocked(mapcache, buffer);
         mapcache_unlock(mapcache);
     }
 }
-- 
2.41.0


