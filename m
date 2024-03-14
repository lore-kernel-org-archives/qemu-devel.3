Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A6BC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 11:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkj66-0005Ab-Ob; Thu, 14 Mar 2024 07:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rkj5v-00058h-Jz
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rkj5u-0003QR-2X
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710415073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vCIE0YmZFuvbvv/sX02hPd9ARHpV/dzxOgjsuL+QjFw=;
 b=ThEQUx9Pwp+Jz51vL8FWnMuCZSoA0xg+1RR42s8JVHTTeuEKVAsKciP55FlqtXBCghQ9Ge
 gYGOwcE+5lciD+hMpiXOaqksLLCdnytk2Ge+Jex4oeswv6SENF97Qr5RmHgTwWyQLCXnBF
 dJWpm9H741lmUWUXt7pdhULZvQ0f/zQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-_Kqej3gPNw-v4sE_GsavSg-1; Thu, 14 Mar 2024 07:17:49 -0400
X-MC-Unique: _Kqej3gPNw-v4sE_GsavSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42ABE101A586;
 Thu, 14 Mar 2024 11:17:49 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2C1BC1576F;
 Thu, 14 Mar 2024 11:17:45 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: stefanha@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 mtosatti@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH] file-posix: rearrange BDRVRawState fields
Date: Thu, 14 Mar 2024 16:47:41 +0530
Message-ID: <20240314111741.1508705-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Rearrange BRDVRawState structure fields to avoid memory
fragments in its object's memory and save some(~8) bytes
per object.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 block/file-posix.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 78a8cea03b..584346ea3e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -135,12 +135,6 @@
 #define RAW_LOCK_SHARED_BASE           200
 
 typedef struct BDRVRawState {
-    int fd;
-    bool use_lock;
-    int type;
-    int open_flags;
-    size_t buf_align;
-
     /* The current permissions. */
     uint64_t perm;
     uint64_t shared_perm;
@@ -151,29 +145,34 @@ typedef struct BDRVRawState {
     uint64_t locked_shared_perm;
 
     uint64_t aio_max_batch;
+    struct {
+        uint64_t discard_nb_ok;
+        uint64_t discard_nb_failed;
+        uint64_t discard_bytes_ok;
+    } stats;
 
+    PRManager *pr_mgr;
+    BDRVReopenState *reopen_state;
+
+    size_t buf_align;
+    int fd;
+    int type;
+    int open_flags;
     int perm_change_fd;
     int perm_change_flags;
-    BDRVReopenState *reopen_state;
+    int page_cache_inconsistent; /* errno from fdatasync failure */
 
+    bool use_lock;
+    bool has_fallocate;
+    bool needs_alignment;
+    bool force_alignment;
+    bool drop_cache;
+    bool check_cache_dropped;
     bool has_discard:1;
     bool has_write_zeroes:1;
     bool use_linux_aio:1;
     bool has_laio_fdsync:1;
     bool use_linux_io_uring:1;
-    int page_cache_inconsistent; /* errno from fdatasync failure */
-    bool has_fallocate;
-    bool needs_alignment;
-    bool force_alignment;
-    bool drop_cache;
-    bool check_cache_dropped;
-    struct {
-        uint64_t discard_nb_ok;
-        uint64_t discard_nb_failed;
-        uint64_t discard_bytes_ok;
-    } stats;
-
-    PRManager *pr_mgr;
 } BDRVRawState;
 
 typedef struct BDRVRawReopenState {
-- 
2.44.0


