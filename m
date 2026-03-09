Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F768EF36E6
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 06:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUMH-0007vM-UY; Mon, 09 Mar 2026 02:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUMF-0007v1-Vk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:51 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUME-000278-Co
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:51 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-56a9076813bso4437611e0c.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 23:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773038689; x=1773643489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2tMEsPmEaiHyXknwk29SjcZVAaayzKi1p57s2lEHB0=;
 b=XmqA6fo/4c1uVD1d70si61mKP9HXkueuObtL6Qv0v1rTV5ppEiGeOp+KVdgEfhFWNL
 H/YD5KPrY/c3eiRxFCwqvqXniGA0wM7+57ywu8TaDqDIirU57oWov3jo6FEl0QXzDt1U
 qk/jmKU2wtR/L62SVG/SWdxcWAklpnTLtkGhNL4KUn+dje6n7VkNnR3FTWcwhOS27TnS
 3gDxVc6C8WpzQzenhcS9Jx2fnnzvb4hpevckjj9qgBUZY3DVLjNd1+aUJjXZhHxFPFMB
 zC9Om5Yt55tLKNBcPLACVeK0XmwjHmZR4yMQKKt0Oc9InoeJWd/s8MiiWEqDBPOzfK2O
 Xrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773038689; x=1773643489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a2tMEsPmEaiHyXknwk29SjcZVAaayzKi1p57s2lEHB0=;
 b=otOVmhPlFRHeUQ2ywWM4Fo0Z0oGq/rap/ohh+BnhN2ofJ8w1A3Eq5oZWaYzQksijzc
 TjW+yoAVeaUEO2B+D6xDMompIZnARGXM2dM4f2cxsVazpabf9EXrEH65/z9lXyECdZmK
 dNLMIIjmUMSECxP+tds0eNYtXD+e2qxEcKimR+JzOU4ty4dVPgCcRLtAgGW57ths29UL
 0QSWBSMD/CE+U56aral2Mq0qei1oYjhbpJ+lG+Nsns1lnfLbh0dkwbg20NeN0ocCWxQQ
 1Q/rK759gtBR52SgCncwGNQcOhYP3R5fvtic4mG8yc54wrCWZs4ES9x+UOdkN2Vzf62S
 UJdQ==
X-Gm-Message-State: AOJu0Yw6xo/B/WcQWJGUFhl+KKydM1nsR4x8Adh04Fr+cw9ghUv/r5/L
 XeWYKAs2sn67O7hocCWOQwiukXREjV0tQ3VFHnOUL2+gCh3LEQKJ+/3yllQaqyXQ
X-Gm-Gg: ATEYQzz++sSXJuuLKN2b2Ri35FrynOCleom9mAel73rATVkJaXCM86clBBDLQ79zUMQ
 WEXDTcY8ytKblKIVHBb0zUI7Mn/igTnRUrBGiqicJsLPAEH/E0YR3abBnQ8pr0fLW8hTeu/SLuI
 leWb5FmvAcpJiJX3vDpe35FF6rN7ucxtsrc0XyYqDzlVlBdJ5B6EvrhYK94IwafUFFf0vmDbWV0
 ORWHv3eoibgth59oBBeBzxpavUCijPFxow5MPFTfhSSeHvHJr04y0PNEWsh6p8D2EM2yObZpkYs
 O/LYWgjcF1N5omko9Zvz+mOLKMzwOSF+uPV/Y+JYFUiJ0qBVtRNzyYAm4TU+35eiLdGmZCA3SB8
 Z452rqXDVn+G1djTGPkRiAsd1Tdj0cyWF+2DoY7Ikr+GQza7zNpoQ+NH7OMHzTDmKe4lR1ioOhI
 v4BZb6tECIwXWpVQaoBO/Z2nzw+83ZkwKjKxrIlbeQOz6UwMStxMHu4JTZSg==
X-Received: by 2002:a05:6122:1350:b0:566:36e7:8934 with SMTP id
 71dfb90a1353d-56b07e8b7dcmr3378593e0c.16.1773038688827; 
 Sun, 08 Mar 2026 23:44:48 -0700 (PDT)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56b09a2614fsm9529782e0c.7.2026.03.08.23.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 23:44:47 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PULL v1 3/5] physmem: xen: Conditionalize use of the mapcache
Date: Mon,  9 Mar 2026 07:44:33 +0100
Message-ID: <20260309064436.51860-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309064436.51860-1-edgar.iglesias@gmail.com>
References: <20260309064436.51860-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Conditionalize use of the mapcache. This is in preparation
to optionally disable the mapcache at runtime.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 system/physmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index e5ff26acec..7eecd81877 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -578,7 +578,9 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
                                     is_write, true, &as, attrs);
     mr = section.mr;
 
-    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
+    if (xen_map_cache_enabled() &&
+        memory_access_is_direct(mr, is_write, attrs)) {
+        /* mapcache: Next page may be unmapped or in a different bucket/VA. */
         hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
         *plen = MIN(page, *plen);
     }
@@ -2577,7 +2579,7 @@ static void reclaim_ramblock(RAMBlock *block)
 {
     if (block->flags & RAM_PREALLOC) {
         ;
-    } else if (xen_enabled()) {
+    } else if (xen_map_cache_enabled()) {
         xen_invalidate_map_cache_entry(block->host);
 #if !defined(_WIN32) && !defined(EMSCRIPTEN)
     } else if (block->fd >= 0) {
@@ -2736,7 +2738,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
         len = *size;
     }
 
-    if (xen_enabled() && block->host == NULL) {
+    if (xen_map_cache_enabled() && block->host == NULL) {
         /* We need to check if the requested address is in the RAM
          * because we don't want to map the entire memory in QEMU.
          * In that case just map the requested area.
@@ -2785,7 +2787,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
     RAMBlock *block;
     uint8_t *host = ptr;
 
-    if (xen_enabled()) {
+    if (xen_map_cache_enabled()) {
         ram_addr_t ram_addr;
         RCU_READ_LOCK_GUARD();
         ram_addr = xen_ram_addr_from_mapcache(ptr);
@@ -3787,7 +3789,7 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
         if (is_write) {
             invalidate_and_set_dirty(mr, addr1, access_len);
         }
-        if (xen_enabled()) {
+        if (xen_map_cache_enabled()) {
             xen_invalidate_map_cache_entry(buffer);
         }
         memory_region_unref(mr);
@@ -3898,7 +3900,7 @@ void address_space_cache_destroy(MemoryRegionCache *cache)
         return;
     }
 
-    if (xen_enabled()) {
+    if (xen_map_cache_enabled()) {
         xen_invalidate_map_cache_entry(cache->ptr);
     }
     memory_region_unref(cache->mrs.mr);
-- 
2.43.0


