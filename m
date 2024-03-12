Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95E9C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk375-0005Nt-RS; Tue, 12 Mar 2024 10:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rk36z-0005NE-80
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:28:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rk36v-0005PL-Bx
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:28:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-413e642806fso169495e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1710253688; x=1710858488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8yhocMsTnBM9RxbWE+rnkoHnCZQapESNY+2+Nhur+g=;
 b=HX2N7E6U/HOsAQyGxZ7NHQBXsZyOwy0kjTW6zxPMytZ3A07GI6ljxeaZq6FWtLXZl9
 8sM9pI9Ns7P/E3EL5qU20SkHd3yfETd4HyqE5cYdG/NyvqYhyIsvnGSLW6uTr3ENzYhf
 QO1+RN+q5UBB46tVh0d9kut81D+pX4vJY2dGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710253688; x=1710858488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8yhocMsTnBM9RxbWE+rnkoHnCZQapESNY+2+Nhur+g=;
 b=APbSWf9VMkE9aCZOhIaz00YduSJMzZLwYUyTbIDZUBLVoU8WFWUSP8P2rZ50vdc+7x
 /iNgSSSGa/aDX9ewrMWXMl2lCyKfzzN+/3drbyHXPXsntI7mOmb6Ui2tsaRv+d6BrFSI
 RhbACLAdKqmYrZ1hMkNtuM0zX8HfFH4iRSMOLfoK1v9Bkq5TBrp99pISTECfxPMQ0KZ5
 mT20Z8aXCNFTOuEo8VLFLugAHV+SWo135RB3GfUq8VYuPhCdXlyfeLJ+DpAvG8mUjnEo
 DQuHHLQqO5A03qQCIvLKCjHMc0gI5/T6TOrxKwc0bZT4T2z7+FB+GOS6JRNyyw5FOB4X
 gxfw==
X-Gm-Message-State: AOJu0YzkLoWB1uiHOk5+5c38fKZOT9fbQusONGr2f9ddrDIe6qHOwIa/
 XjvgiBw+dm5f3pWgAg7hMzECMe9aDzs5YIA9kvhdbjEJDo/caRiLjjepuK2Fs06WYaFSOvQ3XfB
 A
X-Google-Smtp-Source: AGHT+IFwwMUJ7IS7QPhDsUKLmaL2ThpgcxUY4sHiuWDlxBPvSNMOq0R7FMOkswp3Hq0AM9ENHwuErA==
X-Received: by 2002:a05:600c:3d9b:b0:413:38c6:2c7a with SMTP id
 bi27-20020a05600c3d9b00b0041338c62c7amr1370102wmb.22.1710253687811; 
 Tue, 12 Mar 2024 07:28:07 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92320-cmbg19-2-0-cust35.5-4.cable.virginm.net. [82.13.64.36])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c198d00b00412b0e51ef9sm12810270wmq.31.2024.03.12.07.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:28:07 -0700 (PDT)
From: Anthony PERARD <anthony.perard@citrix.com>
To: qemu-devel@nongnu.org
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PULL 2/3] xen: Drop out of coroutine context
 xen_invalidate_map_cache_entry
Date: Tue, 12 Mar 2024 14:27:56 +0000
Message-Id: <20240312142757.34141-3-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312142757.34141-1-anthony.perard@citrix.com>
References: <20240312142757.34141-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peng Fan <peng.fan@nxp.com>

xen_invalidate_map_cache_entry is not expected to run in a
coroutine. Without this, there is crash:

    signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
    threadid=<optimized out>) at pthread_kill.c:78
    at /usr/src/debug/glibc/2.38+git-r0/sysdeps/posix/raise.c:26
    fmt=0xffff9e1ca8a8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
    assertion=assertion@entry=0xaaaae0d25740 "!qemu_in_coroutine()",
    file=file@entry=0xaaaae0d301a8 "../qemu-xen-dir-remote/block/graph-lock.c", line=line@entry=260,
    function=function@entry=0xaaaae0e522c0 <__PRETTY_FUNCTION__.3> "bdrv_graph_rdlock_main_loop") at assert.c:92
    assertion=assertion@entry=0xaaaae0d25740 "!qemu_in_coroutine()",
    file=file@entry=0xaaaae0d301a8 "../qemu-xen-dir-remote/block/graph-lock.c", line=line@entry=260,
    function=function@entry=0xaaaae0e522c0 <__PRETTY_FUNCTION__.3> "bdrv_graph_rdlock_main_loop") at assert.c:101
    at ../qemu-xen-dir-remote/block/graph-lock.c:260
    at /home/Freenix/work/sw-stash/xen/upstream/tools/qemu-xen-dir-remote/include/block/graph-lock.h:259
    host=host@entry=0xffff742c8000, size=size@entry=2097152)
    at ../qemu-xen-dir-remote/block/io.c:3362
    host=0xffff742c8000, size=2097152)
    at ../qemu-xen-dir-remote/block/block-backend.c:2859
    host=<optimized out>, size=<optimized out>, max_size=<optimized out>)
    at ../qemu-xen-dir-remote/block/block-ram-registrar.c:33
    size=2097152, max_size=2097152)
    at ../qemu-xen-dir-remote/hw/core/numa.c:883
    buffer=buffer@entry=0xffff743c5000 "")
    at ../qemu-xen-dir-remote/hw/xen/xen-mapcache.c:475
    buffer=buffer@entry=0xffff743c5000 "")
    at ../qemu-xen-dir-remote/hw/xen/xen-mapcache.c:487
    as=as@entry=0xaaaae1ca3ae8 <address_space_memory>, buffer=0xffff743c5000,
    len=<optimized out>, is_write=is_write@entry=true,
    access_len=access_len@entry=32768)
    at ../qemu-xen-dir-remote/system/physmem.c:3199
    dir=DMA_DIRECTION_FROM_DEVICE, len=<optimized out>,
    buffer=<optimized out>, as=0xaaaae1ca3ae8 <address_space_memory>)
    at /home/Freenix/work/sw-stash/xen/upstream/tools/qemu-xen-dir-remote/include/sysemu/dma.h:236
    elem=elem@entry=0xaaaaf620aa30, len=len@entry=32769)
    at ../qemu-xen-dir-remote/hw/virtio/virtio.c:758
    elem=elem@entry=0xaaaaf620aa30, len=len@entry=32769, idx=idx@entry=0)
    at ../qemu-xen-dir-remote/hw/virtio/virtio.c:919
    elem=elem@entry=0xaaaaf620aa30, len=32769)
    at ../qemu-xen-dir-remote/hw/virtio/virtio.c:994
    req=req@entry=0xaaaaf620aa30, status=status@entry=0 '\000')
    at ../qemu-xen-dir-remote/hw/block/virtio-blk.c:67
    ret=0) at ../qemu-xen-dir-remote/hw/block/virtio-blk.c:136
    at ../qemu-xen-dir-remote/block/block-backend.c:1559
--Type <RET> for more, q to quit, c to continue without paging--
    at ../qemu-xen-dir-remote/block/block-backend.c:1614
    i1=<optimized out>) at ../qemu-xen-dir-remote/util/coroutine-ucontext.c:177
    at ../sysdeps/unix/sysv/linux/aarch64/setcontext.S:123

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Message-Id: <20240124021450.21656-1-peng.fan@oss.nxp.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen-mapcache.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 4f956d048e..7f59080ba7 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -476,11 +476,37 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
     g_free(entry);
 }
 
-void xen_invalidate_map_cache_entry(uint8_t *buffer)
+typedef struct XenMapCacheData {
+    Coroutine *co;
+    uint8_t *buffer;
+} XenMapCacheData;
+
+static void xen_invalidate_map_cache_entry_bh(void *opaque)
 {
+    XenMapCacheData *data = opaque;
+
     mapcache_lock();
-    xen_invalidate_map_cache_entry_unlocked(buffer);
+    xen_invalidate_map_cache_entry_unlocked(data->buffer);
     mapcache_unlock();
+
+    aio_co_wake(data->co);
+}
+
+void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
+{
+    if (qemu_in_coroutine()) {
+        XenMapCacheData data = {
+            .co = qemu_coroutine_self(),
+            .buffer = buffer,
+        };
+        aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
+                                xen_invalidate_map_cache_entry_bh, &data);
+        qemu_coroutine_yield();
+    } else {
+        mapcache_lock();
+        xen_invalidate_map_cache_entry_unlocked(buffer);
+        mapcache_unlock();
+    }
 }
 
 void xen_invalidate_map_cache(void)
-- 
Anthony PERARD


