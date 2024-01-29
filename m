Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB86C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 18:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUWnQ-0005Jz-R6; Mon, 29 Jan 2024 13:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rUWnK-0005Ej-AT
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:55:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rUWnH-0006PG-Of
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706554542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSTY22VwfnXSjtHs7hBgZd5jrWWFKxIQR6WlHNyAw1o=;
 b=BW+txYzxbF+5jpgq1DaZDkTzKdlvC8+SJcE/UKwkT/nbnrbkf5B3hO07TvYgA2aNL59q68
 xFEGz7b4ZBua14ouzzF1aI0yUWFh8l+s//5nhx0+lb5V/gBvq8kohfKYwWf4iVFXv8Btl8
 IclprTgDNFhPJjEAoCQWVJPHYk9Ne44=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-kVrxNtyeNfe1tkM4pIZmGQ-1; Mon,
 29 Jan 2024 13:54:30 -0500
X-MC-Unique: kVrxNtyeNfe1tkM4pIZmGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB7A63816B45;
 Mon, 29 Jan 2024 18:54:29 +0000 (UTC)
Received: from hush.home.annexia.org (unknown [10.42.28.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 240342166B31;
 Mon, 29 Jan 2024 18:54:29 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com
Subject: [PATCH [repost]] block/blkio: Don't assume size_t is 64 bit
Date: Mon, 29 Jan 2024 18:53:55 +0000
Message-ID: <20240129185427.2952727-2-rjones@redhat.com>
In-Reply-To: <20240129185427.2952727-1-rjones@redhat.com>
References: <20240129185427.2952727-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

With GCC 14 the code failed to compile on i686 (and was wrong for any
version of GCC):

../block/blkio.c: In function ‘blkio_file_open’:
../block/blkio.c:857:28: error: passing argument 3 of ‘blkio_get_uint64’ from incompatible pointer type [-Wincompatible-pointer-types]
  857 |                            &s->mem_region_alignment);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~
      |                            |
      |                            size_t * {aka unsigned int *}
In file included from ../block/blkio.c:12:
/usr/include/blkio.h:49:67: note: expected ‘uint64_t *’ {aka ‘long long unsigned int *’} but argument is of type ‘size_t *’ {aka ‘unsigned int *’}
   49 | int blkio_get_uint64(struct blkio *b, const char *name, uint64_t *value);
      |                                                         ~~~~~~~~~~^~~~~

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/blkio.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blkio.c b/block/blkio.c
index 0a0a6c0f5fd..52d78935147 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -794,6 +794,7 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
     const char *blkio_driver = bs->drv->protocol_name;
     BDRVBlkioState *s = bs->opaque;
     int ret;
+    uint64_t val;
 
     ret = blkio_create(blkio_driver, &s->blkio);
     if (ret < 0) {
@@ -854,7 +855,7 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = blkio_get_uint64(s->blkio,
                            "mem-region-alignment",
-                           &s->mem_region_alignment);
+                           &val);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
                          "failed to get mem-region-alignment: %s",
@@ -862,6 +863,15 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
         blkio_destroy(&s->blkio);
         return ret;
     }
+#if HOST_LONG_BITS == 32
+    if (val > SIZE_MAX) {
+        error_setg_errno(errp, ERANGE,
+                         "mem-region-alignment too large for size_t");
+        blkio_destroy(&s->blkio);
+        return -ERANGE;
+    }
+#endif
+    s->mem_region_alignment = (size_t)val;
 
     ret = blkio_get_bool(s->blkio,
                          "may-pin-mem-regions",
-- 
2.43.0


