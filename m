Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1F606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=hYBAh3uc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLAZ-0005Aa-Vs; Mon, 26 Oct 2026 09:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAT-00051b-S1; Mon, 26 Oct 2026 09:55:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAR-00007k-Ni; Mon, 26 Oct 2026 09:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=Vqs8wFsGldC2ygR6EC59PUz7KRNZs6bB8Z3TZJY0mNI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hYBAh3ucQv2AW7Al6yo4qQnOC4oPAWSollP38jBUZ3octv2R+026myeSubNm1t4F2
 KXPXcXcmt+xEoIZbyOJmfue7Mpt4JVtRmEHSPrzgAkQEd/8pdGC+oPR4GK5AZVmZ/U
 4hs43+T/iWdFYFFqkQCYy+XG1IkKMDDixkFRlJ/GhmeW2mL+SF7pUwiauXlTXmAJ36
 buqWJmmKTJALu83BHrbtRwVqOf8QliaM13lTcZdgxevpsDOJ3ZqtLosej3aBhPCdPn
 7KPSnel6JUOYl6Lyml4JphDD0AKhqpybIasi/FJSNa11cmqVuzgJpqLbUVcENrGgPd
 +4iQPKIGNRr/Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9FE501E127D;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D74944B8C9;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8B96293489; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 71/91] migration: add QEMU_COUNTED_STRING_SIZE for
 counted string buffers
Date: Mon, 26 Oct 2026 16:54:14 +0300
Message-ID: <20261026135441.1019505-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
(cherry picked from commit 319cd41f110ada2cbb7dd17700893327a3cb925e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
index ceec6fabf92..702e761c0ed 100644
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
index 45c330b6d32..cfc19bf9c7a 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -860,7 +860,8 @@ uint64_t qemu_get_be64(QEMUFile *f)
  *          else 0
  *          (Note a 0 length string will return 0 either way)
  */
-size_t coroutine_mixed_fn qemu_get_counted_string(QEMUFile *f, char buf[256])
+size_t coroutine_mixed_fn
+qemu_get_counted_string(QEMUFile *f, char buf[QEMU_COUNTED_STRING_SIZE])
 {
     size_t len = qemu_get_byte(f);
     size_t res = qemu_get_buffer(f, (uint8_t *)buf, len);
@@ -878,7 +879,7 @@ void qemu_put_counted_string(QEMUFile *f, const char *str)
 {
     size_t len = strlen(str);
 
-    assert(len < 256);
+    assert(len < QEMU_COUNTED_STRING_SIZE);
     qemu_put_byte(f, len);
     qemu_put_buffer(f, (const uint8_t *)str, len);
 }
-- 
2.47.3


