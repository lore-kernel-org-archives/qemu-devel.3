Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F144CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnwX-0003XT-IN; Thu, 08 Oct 2026 09:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnw0-0002p6-Df
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvy-0002SI-DK
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaFh6F7o7jmYAvW8pN0oZibDz415CvO9xNihmiOpBqs=;
 b=Z6WPvbx0wGMBOfwyW/u8lxj7EuA4vO0dOxcxS6USiotY4m4lecm+LvEQ/cgHVPA+It5Ov4
 p/Cf2kirj5sUh5GEcEDjAcw1ngtyHyirZa9dJDNf2ee1/9gBtJPvTVlrtUwi4yXiMcdk7i
 jAYVrvaDoUBpUTra1IvVv2QMQsJjwHY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-KiKFqzTcN7KlAXpukC1yFg-1; Thu,
 08 Oct 2026 09:13:03 -0400
X-MC-Unique: KiKFqzTcN7KlAXpukC1yFg-1
X-Mimecast-MFC-AGG-ID: KiKFqzTcN7KlAXpukC1yFg_1791465182
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC88D1944D22; Thu,  8 Oct 2026 13:13:01 +0000 (UTC)
Received: from eblake.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFF7D30000E8; Thu,  8 Oct 2026 13:12:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org (open list:Dirty Bitmaps)
Subject: [PULL 09/15] migration: add QEMU_COUNTED_STRING_SIZE for counted
 string buffers
Date: Thu,  8 Oct 2026 08:11:48 -0500
Message-ID: <20261008131216.2437896-26-eblake@redhat.com>
In-Reply-To: <20261008131216.2437896-17-eblake@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

A counted string carries its length in one byte, so the buffer that
qemu_get_counted_string() fills must hold 256 bytes. The dirty bitmap
load state spells that size as a bare 256 for both of its alias buffers.
Name it next to the qemu_get_counted_string() prototype and use it there,
in the length assert of qemu_put_counted_string() and in DBMLoadState.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-stable@nongnu.org
Message-ID: <20261006170738.453977-2-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/migration/qemu-file-types.h | 6 +++++-
 migration/block-dirty-bitmap.c      | 4 ++--
 migration/qemu-file.c               | 5 +++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
index adec5abc071..2a073bed299 100644
--- a/include/migration/qemu-file-types.h
+++ b/include/migration/qemu-file-types.h
@@ -163,7 +163,11 @@ static inline void qemu_get_sbe64s(QEMUFile *f, int64_t *pv)
     qemu_get_be64s(f, (uint64_t *)pv);
 }

-size_t coroutine_mixed_fn qemu_get_counted_string(QEMUFile *f, char buf[256]);
+/* Buffer size for a string whose length is sent as a single byte */
+#define QEMU_COUNTED_STRING_SIZE 256
+
+size_t coroutine_mixed_fn
+qemu_get_counted_string(QEMUFile *f, char buf[QEMU_COUNTED_STRING_SIZE]);

 void qemu_put_counted_string(QEMUFile *f, const char *name);

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 1b8f39c12bb..1386f436355 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -145,8 +145,8 @@ typedef struct LoadBitmapState {
 /* State of the dirty bitmap migration (DBM) during load process */
 typedef struct DBMLoadState {
     uint32_t flags;
-    char node_alias[256];
-    char bitmap_alias[256];
+    char node_alias[QEMU_COUNTED_STRING_SIZE];
+    char bitmap_alias[QEMU_COUNTED_STRING_SIZE];
     char bitmap_name[BDRV_BITMAP_MAX_NAME_SIZE + 1];
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 7735e618549..df3f96fb240 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -829,7 +829,8 @@ uint64_t qemu_get_be64(QEMUFile *f)
  *          else 0
  *          (Note a 0 length string will return 0 either way)
  */
-size_t coroutine_mixed_fn qemu_get_counted_string(QEMUFile *f, char buf[256])
+size_t coroutine_mixed_fn
+qemu_get_counted_string(QEMUFile *f, char buf[QEMU_COUNTED_STRING_SIZE])
 {
     size_t len = qemu_get_byte(f);
     size_t res = qemu_get_buffer(f, (uint8_t *)buf, len);
@@ -847,7 +848,7 @@ void qemu_put_counted_string(QEMUFile *f, const char *str)
 {
     size_t len = strlen(str);

-    assert(len < 256);
+    assert(len < QEMU_COUNTED_STRING_SIZE);
     qemu_put_byte(f, len);
     qemu_put_buffer(f, (const uint8_t *)str, len);
 }
-- 
2.56.0


