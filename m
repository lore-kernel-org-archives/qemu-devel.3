Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BEFC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xdY-0001Go-8L; Mon, 06 May 2024 08:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdV-00011R-LK
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:05 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdT-0002Gq-7e
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:05 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34d8d11a523so860616f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999201; x=1715604001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6DhMzJBpLSItZebFXH5mHvd8v4e+bkGKskA9q4u7KM=;
 b=xOrNbAgIWzT3YyEstzCiU+px8SG9o1AS4nlz5R9bxq+asHZqpbmF9UOO6h29fiA8wf
 A4zPejCCccrYdlSP0Z95ZTnNAXC5bC36WkhgxFw5yTS50F96VMcue0dgYgUsKzXbxuvu
 DGyoFtFIj3yl4GWI/pByAcSP4GEpLLwM/pAwKARgVzbdG8GcxGUwlv4Yh48IrA2wzBR0
 o84YJnT6Bp6qLEnfidnmgLhEYsulj15MuvW1w5ICVKTNKw1RHqjFvCLxY2PvONe3Fwl+
 duacTuMQsMb+HAlYSivDgN90pOZr+WBtkp4Bfd/2zeqxiScP3Ee5hdpsUcwKAqEZbRMe
 Sdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999201; x=1715604001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6DhMzJBpLSItZebFXH5mHvd8v4e+bkGKskA9q4u7KM=;
 b=qWKzMbIFEQuRrvFzAxubggipvqbTUmT1hnOj5780GVYgpenkdDF7Rof5CVYEAAy2hq
 Uk6KkevzK89Kr1qHq2MKovNn+YHVdsZaP6dQTcYp2rQ0+Wqo7qMkVWLSjp6Rqh/McZB3
 Xh/IF3vF+ktrN1q7FHyM+dDaZxTMJPPhP6d9pnNEbtWQI209R8jtW3XWoAK0upJ7Ityo
 c0eICv+CHzluTzfHQbhYiNI0MYMFiakPrCLpWjRWqGOzjQzL6hsfolP0Sq89xFWiOtLb
 WbC/CL0CKQWmwEfvFm2/BK7D7eKGB5axmdDbVLeP6eqvmPm7rLVwaH93tIhWn5RH33DC
 UccQ==
X-Gm-Message-State: AOJu0YwL8iKSv/f0fXG/LugE1aofUQ6ELKJ+TNJUDHYOxeW/xfSJiCpn
 9RGCTu2IxBBEW1aHmiNtba7WI1XLX+MU85q2ioIwRk8Spcf+LsQAA/A0TlopOUQ+cqhH8i9DmbZ
 4
X-Google-Smtp-Source: AGHT+IGv5p6KzExxLVsRNSJv/e4zQ6xoDnlwDd4O8LrYnlUMJVcVYIXkk7aJwtEFUfAVOGY4+uw6Lw==
X-Received: by 2002:adf:f305:0:b0:34d:8190:72f4 with SMTP id
 i5-20020adff305000000b0034d819072f4mr6325091wro.1.1714999201314; 
 Mon, 06 May 2024 05:40:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 z8-20020a5d6548000000b0034dbb122af4sm10586926wrv.113.2024.05.06.05.40.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:40:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/28] xen: mapcache: Refactor xen_replace_cache_entry_unlocked
Date: Mon,  6 May 2024 14:37:22 +0200
Message-ID: <20240506123728.65278-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Add MapCache argument to xen_replace_cache_entry_unlocked in
preparation for supporting multiple map caches.

No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240430164939.925307-8-edgar.iglesias@gmail.com>
[PMD: Remove last global mapcache pointer, reported by sstabellini]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 1927334e9f..96c422981e 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -557,7 +557,8 @@ void xen_invalidate_map_cache(void)
     mapcache_unlock(mapcache);
 }
 
-static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
+static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
+                                                 hwaddr old_phys_addr,
                                                  hwaddr new_phys_addr,
                                                  hwaddr size)
 {
@@ -579,7 +580,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
         cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
     }
 
-    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
+    entry = &mc->entry[address_index % mc->nr_buckets];
     while (entry && !(entry->paddr_index == address_index &&
                       entry->size == cache_size)) {
         entry = entry->next;
@@ -594,7 +595,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
 
     trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
 
-    xen_remap_bucket(mapcache, entry, entry->vaddr_base,
+    xen_remap_bucket(mc, entry, entry->vaddr_base,
                      cache_size, address_index, false);
     if (!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
@@ -615,7 +616,8 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
     uint8_t *p;
 
     mapcache_lock(mapcache);
-    p = xen_replace_cache_entry_unlocked(old_phys_addr, new_phys_addr, size);
+    p = xen_replace_cache_entry_unlocked(mapcache, old_phys_addr,
+                                         new_phys_addr, size);
     mapcache_unlock(mapcache);
     return p;
 }
-- 
2.41.0


