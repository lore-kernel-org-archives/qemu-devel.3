Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B57FFD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvK-0003Qk-OM; Tue, 10 Mar 2026 12:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzv9-0003L3-0t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzv7-0000uK-F9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EerOtERlXoVSU73mqwwBbXk9WG5MEwl6IjYw0Ivbe4o=;
 b=iQN2QHJrPEpc5SuTIe1h1a3+VgzSNgNyxKHslD2TAqqimrwEIxyxHgHcI4d1CUFOXZf1Na
 O65iFZMi1ql7Syl5kS3zK9AyiJYXW8gdlkk3Oofi7+pJAkf+tt8AmYx3xG4Gj5/wuDJ0t3
 aG6mXMfBSD4W3iHByUMW9TEFPl6bZZk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-AXSMoUFENKizoniwXHTxaQ-1; Tue,
 10 Mar 2026 12:26:55 -0400
X-MC-Unique: AXSMoUFENKizoniwXHTxaQ-1
X-Mimecast-MFC-AGG-ID: AXSMoUFENKizoniwXHTxaQ_1773160014
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B74721956094; Tue, 10 Mar 2026 16:26:54 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9157419560A6; Tue, 10 Mar 2026 16:26:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 15/28] block: Move qemu_fcntl_addfl() into osdep.c
Date: Tue, 10 Mar 2026 17:26:09 +0100
Message-ID: <20260310162622.333137-16-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Hanna Czenczek <hreitz@redhat.com>

Move file-posix's helper to add a flag (or a set of flags) to an FD's
existing set of flags into osdep.c for other places to use.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-16-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/osdep.h |  1 +
 block/file-posix.c   | 17 +----------------
 util/osdep.c         | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index b384b5b506b..f151578b5ce 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -633,6 +633,7 @@ int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
+int qemu_fcntl_addfl(int fd, int flag);
 #endif
 
 bool qemu_has_direct_io(void);
diff --git a/block/file-posix.c b/block/file-posix.c
index 6265d2e248b..e49b13d6abb 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1056,21 +1056,6 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
     return ret;
 }
 
-/* Sets a specific flag */
-static int fcntl_setfl(int fd, int flag)
-{
-    int flags;
-
-    flags = fcntl(fd, F_GETFL);
-    if (flags == -1) {
-        return -errno;
-    }
-    if (fcntl(fd, F_SETFL, flags | flag) == -1) {
-        return -errno;
-    }
-    return 0;
-}
-
 static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
                                  int *open_flags, uint64_t perm, Error **errp)
 {
@@ -1109,7 +1094,7 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
         /* dup the original fd */
         fd = qemu_dup(s->fd);
         if (fd >= 0) {
-            ret = fcntl_setfl(fd, *open_flags);
+            ret = qemu_fcntl_addfl(fd, *open_flags);
             if (ret) {
                 qemu_close(fd);
                 fd = -1;
diff --git a/util/osdep.c b/util/osdep.c
index 770369831bc..000e7daac8b 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -280,6 +280,24 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
         return fl.l_type == F_UNLCK ? 0 : -EAGAIN;
     }
 }
+
+/**
+ * Set the given flag(s) (fcntl GETFL/SETFL) on the given FD, while retaining
+ * other flags.
+ */
+int qemu_fcntl_addfl(int fd, int flag)
+{
+    int flags;
+
+    flags = fcntl(fd, F_GETFL);
+    if (flags == -1) {
+        return -errno;
+    }
+    if (fcntl(fd, F_SETFL, flags | flag) == -1) {
+        return -errno;
+    }
+    return 0;
+}
 #endif
 
 bool qemu_has_direct_io(void)
-- 
2.53.0


