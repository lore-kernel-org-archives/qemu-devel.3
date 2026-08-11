Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D505C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqRZ-0004YP-5g; Tue, 11 Aug 2026 13:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRU-0004Wu-5c
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:12 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRR-0000S8-Fi
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:11 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so172835a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786469948; x=1787074748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GV7Ua9V/Sjx6+gmIOmwjUOl9YM8UQhaC8JaZ+jlAiiY=;
 b=px6IBtfxJjqIFNUS54wBo46JYmu/Qz9EpjiVKdr8OuQwIEzquXUefGXJ8HOnlE67o7
 91pbl74vJ0Y6uPI5WY4weVbZKyhKrbSwEpN9AAN+StDwhajEFSd3iDVjCwxGy0A+GQml
 Gv6ZTRGU1wGRYsagdRIqy/LXWLIDyqBSIOlHDGWBz07FtLcrQ8CaNBS4/WjsTIJz3OAg
 fpv7bA0Rn1t0hM3h8Q6mZtqVxpuLtBFufJipspWQd3eYQ8LTUD38K6iTY/nQRnlG4Hdg
 6Dr7qGq4XZsE4g+FS3sIB/cUkIvV18bcfHKqBh3iqFiVaEFfJ8Am7F0/ctc9foY6VnjP
 jTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786469948; x=1787074748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GV7Ua9V/Sjx6+gmIOmwjUOl9YM8UQhaC8JaZ+jlAiiY=;
 b=fqXlxJoOD0XOMCojFceaWIECkwqxwyeZzkdKPL93c8eXtAKv4rnqqcvbAhfnxXCtAI
 rR/sLuA0zfPirCRzygZ2kraUp38wxSLHj8nx5M4lZGL5Nl1/UGAekh32kOnxs3mukaby
 4QtoYKOt1jeR8nK/isDat9nLVfLNMUhbRg4LYvt4wGhhJTPxsntiNzbpP906QaGD1a+i
 zz9XXgsboQUao9j7Z5/cAPRkw5xPcRP5ifqqFueTzj1Cg9Pm5GVsQaQg1fq2C6Z57P/F
 uZsqJaPtYAj/hmKBd9prFj+X00J/8oyggPLYMVHzAR+J6wn8Co1mYSOdhSnMiOWCpbAD
 +exQ==
X-Gm-Message-State: AOJu0Yy2zfg4LojU+8iroyyBxEytw4XA0/RHDl+vb2oZa1lYxuOrjpXG
 tz9pEza5Pw8FAGe9rt0XxaCFAZKRiJC0jHiWEdKn1p9yq7c2+kMrBtZqc/lBRRd/V/BpcTQvXIh
 h+Ysp
X-Gm-Gg: AR+sD13y+2usCA06Qx6HAr0Fh7pU8ae1sm+WlbRWMNKLIn/BSIcdkVC49GpRqlssYhf
 wurOqBoIKKhikv+XMztBnWUWiz987myChPbr7WVSeIQSygEy3ueRge2Qp4oBxAO7kTmbZLojCTW
 QngfWkHO5q1qTrXlUKeObPQMUcCI5BTmv7QsMMBuN5Cra3HKGwlecMnNMjJgH/pM6iMiPDmxmZQ
 6eO8RXXxxKcf0AentevzYMdXGwnDEuKbJbpouD/77bEvmTcT1XI6EDrDGBxW5JLZ1+OT+vb7gxR
 Pe/kwJNZkF8WBAUP0kJyyMbVvDjM6DK411DK4FkS5/1A9cnO+INy087uUo1hKz0IQYOlc4cG07c
 1A/rbrv+kPXLV4jt0LqSKzqhL3ZL3OZv3g9eQY5I45ANKuZuF0I/8exAX2oMHXN9rVNdeIBiuQq
 dQYrvGOuVJfJPoZwspIi/mAu9T9RGAwc84AwG942kozq69md4vLNYC6N27
X-Received: by 2002:a05:6402:249e:b0:698:3602:d0d with SMTP id
 4fb4d7f45d1cf-6a36451dd1amr2791285a12.17.1786469947999; 
 Tue, 11 Aug 2026 10:39:07 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ef7525sm880945a12.29.2026.08.11.10.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:39:06 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/8] parallels: validate dirty bitmap granularity
Date: Tue, 11 Aug 2026 19:38:51 +0200
Message-ID: <20260811173857.396571-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811173857.396571-1-den@openvz.org>
References: <20260811173857.396571-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=den@openvz.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


