Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA52C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xdk-0002X3-FY; Mon, 06 May 2024 08:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdh-0002I0-0f
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:17 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdf-0002Rk-3C
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:16 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34d99ec52e1so1165529f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999213; x=1715604013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAoBz8aoMGUtkfGWAKV8DQjUNcnX+pc6qT9VuQpXWc0=;
 b=uigCCNJYID6Wu/qX+qzNWl+O/WIpAJbet0JjbVfoKne1YF7QBofhc3qffq+3goKSxm
 39wK3kgj7G8bJK9sD7/utKUprhBhfK1xWR1zzEgvnHDLeWcyPej+WPEEZwHlxdGzDmhb
 o6hDeMaJJiksdR6lPvOqobkY7JLQvUKwduJuaGD5UIaoEjbLUERBwjbNoxHxj5wj2nQS
 5yNaP9SNshh+LliqOc6eYNp/ZiPcYeOnJQlUNZcZimycvzrLlRpfb/7/TIl0wY9t2JpH
 LwbRYupcD5NHCh52LPBg4SKWdJ5tQj475N+DU+d2cD1RYrw+e0/S4mqTRyNVVcRkXR4u
 7Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999213; x=1715604013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAoBz8aoMGUtkfGWAKV8DQjUNcnX+pc6qT9VuQpXWc0=;
 b=csR07Uqt0GbGlJks1r9rUZEG6h4YnepRhxyxUAJUWWIJgqYAa5lTokizRsdYWSbdrI
 OXNd/0XRIo3FqyvH/tOC15+LfoqoAu5sgxZnADS1Wj5wsrHN0rla/pp7AKsubhQCi6Ln
 XoxbsQ9yK57/RRzj/m9p5BsRVVZergJKgu8vJrR51UNexGxgcJFITOz2pREH3UkUPZfh
 oJpuTOeunR7A2SvbyK9KVJIR67O3qwsYxNFoTftB4gtoJX2VY/2Te5Nxvjj4UvUHJudm
 ihyTYLej011fFBe4sxIO500OzPBNMzGtW6mhsVoxd98ucxbhbIQeBuW4vWNCgJjU9DDb
 fLJw==
X-Gm-Message-State: AOJu0YxWCqZ6n512wriAnBReL5kAlJ+2kOqzAPtSb8Pc7Z8WS95yg62J
 I5Qxn7cKms/icUjIyw/9FXzTpNC3d/+BBW6rGH3gp1IA/EOAesyZF9chl6leEWnv+tcNoNcydHD
 y
X-Google-Smtp-Source: AGHT+IGRSRx8a4QqPlbHh2WMjTuV54zaoQ12q+OR7BO7678FsSS4bBvWdyKME2l8Uyn+6O/cPKGfXQ==
X-Received: by 2002:a5d:5511:0:b0:34d:74cb:c0be with SMTP id
 b17-20020a5d5511000000b0034d74cbc0bemr6789600wrv.35.1714999213228; 
 Mon, 06 May 2024 05:40:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 d18-20020adfef92000000b0034c71090653sm10579327wro.57.2024.05.06.05.40.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:40:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/28] xen: mapcache: Break out
 xen_invalidate_map_cache_single()
Date: Mon,  6 May 2024 14:37:24 +0200
Message-ID: <20240506123728.65278-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
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

Break out xen_invalidate_map_cache_single().

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240430164939.925307-10-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 3e6a1a0a93..c8a0f4fbc2 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -513,17 +513,14 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
     }
 }
 
-void xen_invalidate_map_cache(void)
+static void xen_invalidate_map_cache_single(MapCache *mc)
 {
     unsigned long i;
     MapCacheRev *reventry;
 
-    /* Flush pending AIO before destroying the mapcache */
-    bdrv_drain_all();
+    mapcache_lock(mc);
 
-    mapcache_lock(mapcache);
-
-    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
+    QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
         if (!reventry->dma) {
             continue;
         }
@@ -531,8 +528,8 @@ void xen_invalidate_map_cache(void)
                                        reventry->vaddr_req);
     }
 
-    for (i = 0; i < mapcache->nr_buckets; i++) {
-        MapCacheEntry *entry = &mapcache->entry[i];
+    for (i = 0; i < mc->nr_buckets; i++) {
+        MapCacheEntry *entry = &mc->entry[i];
 
         if (entry->vaddr_base == NULL) {
             continue;
@@ -553,9 +550,17 @@ void xen_invalidate_map_cache(void)
         entry->valid_mapping = NULL;
     }
 
-    mapcache->last_entry = NULL;
+    mc->last_entry = NULL;
 
-    mapcache_unlock(mapcache);
+    mapcache_unlock(mc);
+}
+
+void xen_invalidate_map_cache(void)
+{
+    /* Flush pending AIO before destroying the mapcache */
+    bdrv_drain_all();
+
+    xen_invalidate_map_cache_single(mapcache);
 }
 
 static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
-- 
2.41.0


