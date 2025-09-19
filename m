Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAB5CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZf9-0002gd-0L; Fri, 19 Sep 2025 07:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZeY-0002UQ-0L
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZeQ-0000qc-Oy
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lse4TUK4YsNm2dA0AOzJMTi63TonEkTeeFzhtxCHbUk=;
 b=ZPiACS2ahJr80kjVZnrM7Pc6SB2AizNOtcxXiK9zdV/274J0pKgiEwJj13FmT2RJhQHDFG
 NMALxKDb1p8s0NN+yk9+rW4qiQICJMsrLIjbCqfsB7S4XRfmabysKpDES+nW0ZcAH91W6F
 awjMVAVIA6LdBSSfB63wndEUq8N5V6M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-L4vFGNtOMFCbfO8N1CjhEQ-1; Fri,
 19 Sep 2025 07:51:34 -0400
X-MC-Unique: L4vFGNtOMFCbfO8N1CjhEQ-1
X-Mimecast-MFC-AGG-ID: L4vFGNtOMFCbfO8N1CjhEQ_1758282691
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 957F119560B7; Fri, 19 Sep 2025 11:51:31 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BECE1955F21; Fri, 19 Sep 2025 11:51:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: [PULL 06/16] util: add qemu_set_blocking() function
Date: Fri, 19 Sep 2025 12:50:07 +0100
Message-ID: <20250919115017.1536203-7-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-1-berrange@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

In generic code we have qio_channel_set_blocking(), which takes
bool parameter, and qemu_file_set_blocking(), which as well takes
bool parameter.

At lower fd-layer we have a mess of functions:

- enough direct calls to Unix-specific g_unix_set_fd_nonblocking()
(of course, all calls are out of Windows-compatible code), which
is glib specific with GError, which we can't use, and have to
handle error-reporting by hand after the call.

and several platform-agnostic qemu_* helpers:

- qemu_socket_set_nonblock(), which asserts success for posix (still,
  in most cases we can handle the error in better way) and ignores
  error for win32 realization

- qemu_socket_try_set_nonblock(), providing and error, but not errp,
so we have to handle it after the call

- qemu_socket_set_block(), which simply ignores an error

Note, that *_socket_* word in original API, which we are going
to substitute was intended, because Windows support these operations
only for sockets. What leads to solution of dropping it again?

1. Having a QEMU-native wrapper with errp parameter
for g_unix_set_fd_nonblocking() for non-socket fds worth doing,
at least to unify error handling.

2. So, if try to keep _socket_ vs _file_ words, we'll have two
actually duplicated functions for Linux, which actually will
be executed successfully on any (good enough) fds, and nothing
prevent using them improperly except for the name. That doesn't
look good.

3. Naming helped us in the world where we crash on errors or
ignore them. Now, with errp parameter, callers are intended to
proper error checking. And for places where we really OK with
crash-on-error semantics (like tests), we have an explicit
&error_abort.

So, this commit starts a series, which will effectively revert
commit ff5927baa7ffb9 "util: rename qemu_*block() socket functions"
(which in turn was reverting f9e8cacc5557e43
"oslib-posix: rename socket_set_nonblock() to qemu_set_nonblock()",
so that's a long story).
Now we don't simply rename, instead we provide the new API and
update all the callers.

This commit only introduces a new fd-layer wrapper. Next commits
will replace old API calls with it, and finally remove old API.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h |  1 +
 util/oslib-posix.c   | 15 +++++++++++++++
 util/oslib-win32.c   | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index be3460b32f..1b38cb7e45 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -687,6 +687,7 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
     G_GNUC_WARN_UNUSED_RESULT;
 
 void qemu_set_cloexec(int fd);
+bool qemu_set_blocking(int fd, bool block, Error **errp);
 
 /* Return a dynamically allocated directory path that is appropriate for storing
  * local state.
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4ff577e5de..c737701075 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -250,6 +250,21 @@ void qemu_anon_ram_free(void *ptr, size_t size)
 #endif
 }
 
+bool qemu_set_blocking(int fd, bool block, Error **errp)
+{
+    g_autoptr(GError) err = NULL;
+
+    if (!g_unix_set_fd_nonblocking(fd, !block, &err)) {
+        error_setg_errno(errp, errno,
+                         "Can't set file descriptor %d %s: %s", fd,
+                         block ? "blocking" : "non-blocking",
+                         err->message);
+        return false;
+    }
+
+    return true;
+}
+
 void qemu_socket_set_block(int fd)
 {
     g_unix_set_fd_nonblocking(fd, false, NULL);
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b7351634ec..03044f5b59 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -177,6 +177,24 @@ static int socket_error(void)
     }
 }
 
+bool qemu_set_blocking(int fd, bool block, Error **errp)
+{
+    unsigned long opt = block ? 0 : 1;
+
+    if (block) {
+        qemu_socket_unselect(fd, NULL);
+    }
+
+    if (ioctlsocket(fd, FIONBIO, &opt) != NO_ERROR) {
+        error_setg_errno(errp, socket_error(),
+                         "Can't set file descriptor %d %s", fd,
+                         block ? "blocking" : "non-blocking");
+        return false;
+    }
+
+    return true;
+}
+
 void qemu_socket_set_block(int fd)
 {
     unsigned long opt = 0;
-- 
2.50.1


