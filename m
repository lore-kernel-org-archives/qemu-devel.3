Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052AFC88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pkn-00053P-EP; Thu, 10 Sep 2026 21:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPX-0001g1-4i
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPU-00078h-TL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso4412705e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083747; x=1789688547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W3Bx8pnT2sDuexNJA7DxABZ4LqKNGDa3976jN1luce0=;
 b=mK7Z1ZYD99A+ad+/VKzVnnmZ9xTLrHlXxJitM42UyJ8dV55kWuxFTh4Q+2mWND9rbK
 8man9jDCti/zAEHxsi7V3dozSn+Q1YrYp5AqW8N4RWSUm8Ks8yAsy7frV02yYENjv63z
 sNnC+QgPicqC5V0f51UL7TJ6BmBKyqG85aaV6e/elHORQffT6lQSX1NSvmFBkOHRQu5u
 iPAFoQ31ZDwTx2aSlYUh6eKbAABlEpEPUuYgnFKP2ESpAyCbOlWDstdiu7FlMajw65Da
 SpVEXsevlqE+1aISFnX9E/buikIoQ0mCDJRLEH8PjvIl2lSu+A7cQn7iEQ2d8DTRijrk
 DQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083747; x=1789688547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W3Bx8pnT2sDuexNJA7DxABZ4LqKNGDa3976jN1luce0=;
 b=lGMIQQKmzmZ4BYZQuJnuNCDEO5sZK8fc53cGWiTOamji0LllEDxCxv1NA0iPHr3cPg
 4oHZzSsNmOM/9FNvgAuQpamvv2bM6k6r1sH1e8RthaKi4+k287vzT2Lne1dVu3oi4WYt
 8zvF/FvHrXoM3ZRxTzZbhJyBehSmtWQJMe1bLuE+L37uN6GWkszQT02FPpEFkhqeveI0
 uHB1doZeQW5xXzXminQSldxcf/PPJ5EahU9HcvoQH2+WgrbETj26iTxe8OvO6mvFQkwd
 biJ7OR57VTpGRe1Rj/yrbNoQI5v80Wfauj+lsz4ShdDpCFjAU49smkQ+zKzGG6c5WO++
 bvsA==
X-Gm-Message-State: AFuF++nQE2SPDzfAkCE02oAtonvUIw/TYnLn5Jwg/od89Bv1uxXTj6mr
 XWyFiPGr+AOg5H+8zjaBOu7FovLgGZDWIp2jy9au5Gvegrc4fcPz731F8nJFJcuiBbI=
X-Gm-Gg: AYBFou1jZiZqkFd1h3iKqGIbsEZ2LVZVUccv8/ScQVT3xhwAGtLTHWIpk/Dye9bIt0Q
 C4wDGQSIKL7buzN6dg//iesYF/XYV+kxKUdlzU7eePjHGYk5mMZ6EyB88njMq0exwGpWFhhbAqH
 z1GwpMt3uagimoiXxYxu5C1Ku6IXOiB7oRJ1Cps4+UypaU0r6FbRfJRviI3vyKlSV3De94AlPkF
 yndmwZXlP9tqr8WdfvIrxCL9cO7CunJSKeO3LKLGY4I9pt891xfryAbfc0apDcyk04poxoAteFW
 Vs1X6pXuhxF4ekh33pPwktwYT25PutEt/p0UP2muBYLyrpJMxvziOEfmg8fAh6YUZZIq0O60GBg
 XAZV/RkT7U8JHEnrwc5EBPTQBC3hx+EAByXbis61CM3kwEsQn+MNbMpYXMYmxoEToM0N2F/YZoe
 Tvh3R9l5gplHh421U/ojAQ1wyj8HgT14svagDwQUaaerzeOH4Mj/ZrAphjxLcSwenRUqzs
X-Received: by 2002:a05:600c:3b90:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49e619805f1mr14921895e9.4.1789083747197; 
 Thu, 10 Sep 2026 16:42:27 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:26 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 02/29] parallels: validate dirty bitmap granularity
Date: Fri, 11 Sep 2026 01:41:55 +0200
Message-ID: <20260910234222.3039975-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
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

From: Denis V. Lunev <den@openvz.org>

bf.granularity comes from the image and is passed to
bdrv_create_dirty_bitmap(), which asserts on it. An otherwise valid
image thus aborts qemu-img for a granularity of zero or one which is
not a power of two. The shift by BDRV_SECTOR_BITS is done on a
uint32_t as well, so 1 << 23 sectors and above wrap to zero and hit
the same assertion.

Compute the granularity in 64 bits and reject what
bdrv_create_dirty_bitmap() cannot accept.

Fixes: baefd977002e ("parallels: support bitmap extension for read-only mode")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index baee86a159..830ac78a11 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -31,6 +31,7 @@
 #include "parallels.h"
 #include "crypto/hash.h"
 #include "qemu/bswap.h"
+#include "qemu/host-utils.h"
 #include "qemu/uuid.h"
 #include "qemu/memalign.h"
 
@@ -122,7 +123,7 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
     BdrvDirtyBitmap *bitmap;
     QemuUUID uuid;
     char uuidstr[UUID_STR_LEN];
-    uint64_t bm_size, tab_size;
+    uint64_t bm_size, tab_size, granularity;
     int i;
 
     if (data_size < sizeof(bf)) {
@@ -133,7 +134,7 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
     }
     memcpy(&bf, data, sizeof(bf));
     bf.size = le64_to_cpu(bf.size);
-    bf.granularity = le32_to_cpu(bf.granularity) << BDRV_SECTOR_BITS;
+    bf.granularity = le32_to_cpu(bf.granularity);
     bf.l1_size = le32_to_cpu(bf.l1_size);
     data += sizeof(bf);
     data_size -= sizeof(bf);
@@ -144,6 +145,16 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
         return NULL;
     }
 
+    /* bdrv_create_dirty_bitmap() asserts on an unusable granularity */
+    granularity = (uint64_t)bf.granularity << BDRV_SECTOR_BITS;
+    if (granularity < BDRV_SECTOR_SIZE || granularity > UINT32_MAX ||
+        !is_power_of_2(granularity)) {
+        error_setg(errp, "Invalid bitmap granularity %" PRIu64 ", expected a "
+                   "power of two of at least %" PRIu64 " bytes", granularity,
+                   (uint64_t)BDRV_SECTOR_SIZE);
+        return NULL;
+    }
+
     if (bf.l1_size * sizeof(uint64_t) > data_size) {
         error_setg(errp, "Bitmaps feature corrupted: l1 table exceeds "
                    "extension data_size");
@@ -152,7 +163,7 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
 
     memcpy(&uuid, bf.id, sizeof(uuid));
     qemu_uuid_unparse(&uuid, uuidstr);
-    bitmap = bdrv_create_dirty_bitmap(bs, bf.granularity, uuidstr, errp);
+    bitmap = bdrv_create_dirty_bitmap(bs, granularity, uuidstr, errp);
     if (!bitmap) {
         return NULL;
     }
-- 
2.53.0


