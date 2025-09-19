Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDF7CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZgA-00046G-85; Fri, 19 Sep 2025 07:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZfq-0003l4-Et
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZfi-00010Y-5I
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvMIDTfhkqExxjxXfh4Y8++3SmI4tPG6/nea+iq54aw=;
 b=akhFatovUQVBV7r2PcLXk3m4bKt4/zZRVNFqmPolVRtktYaKPhXsoRNHRXSV4FeNNeFI+9
 gLBOZgj1M8XLiZz4choP8F5JLmAdR9iFzTkB2F3Qbr0AJjQTVvlDvQIJpr5KJQrETCCqjM
 RVV+6jpMrQz6sSqNQk2ZvfhYKet7Rg8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-CUaULWqdO1mMvd0XplFWUA-1; Fri,
 19 Sep 2025 07:52:55 -0400
X-MC-Unique: CUaULWqdO1mMvd0XplFWUA-1
X-Mimecast-MFC-AGG-ID: CUaULWqdO1mMvd0XplFWUA_1758282772
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5B9218002CA; Fri, 19 Sep 2025 11:52:52 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E19871955F21; Fri, 19 Sep 2025 11:52:42 +0000 (UTC)
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
Subject: [PULL 14/16] chardev: qemu_chr_open_fd(): add errp
Date: Fri, 19 Sep 2025 12:50:15 +0100
Message-ID: <20250919115017.1536203-15-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-1-berrange@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Every caller already support errp, let's go further.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-fd.c         | 12 ++++++++----
 chardev/char-file.c       |  6 +++++-
 chardev/char-pipe.c       |  9 ++++++++-
 chardev/char-serial.c     |  5 ++++-
 chardev/char-stdio.c      |  7 +++++--
 include/chardev/char-fd.h |  2 +-
 6 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 739dc68c36..4ee286f323 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -206,14 +206,16 @@ int qmp_chardev_open_file_source(char *src, int flags, Error **errp)
 }
 
 /* open a character device to a unix fd */
-void qemu_chr_open_fd(Chardev *chr,
-                      int fd_in, int fd_out)
+bool qemu_chr_open_fd(Chardev *chr,
+                      int fd_in, int fd_out, Error **errp)
 {
     FDChardev *s = FD_CHARDEV(chr);
     g_autofree char *name = NULL;
 
     if (fd_out >= 0) {
-        qemu_set_blocking(fd_out, false, &error_abort);
+        if (!qemu_set_blocking(fd_out, false, errp)) {
+            return false;
+        }
     }
 
     if (fd_out == fd_in && fd_in >= 0) {
@@ -221,7 +223,7 @@ void qemu_chr_open_fd(Chardev *chr,
         name = g_strdup_printf("chardev-file-%s", chr->label);
         qio_channel_set_name(QIO_CHANNEL(s->ioc_in), name);
         s->ioc_out = QIO_CHANNEL(object_ref(s->ioc_in));
-        return;
+        return true;
     }
 
     if (fd_in >= 0) {
@@ -236,6 +238,8 @@ void qemu_chr_open_fd(Chardev *chr,
         name = g_strdup_printf("chardev-file-out-%s", chr->label);
         qio_channel_set_name(QIO_CHANNEL(s->ioc_out), name);
     }
+
+    return true;
 }
 
 static void char_fd_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/char-file.c b/chardev/char-file.c
index a9e8c5e0d7..89e9cb849c 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -92,7 +92,11 @@ static void qmp_chardev_open_file(Chardev *chr,
         }
     }
 
-    qemu_chr_open_fd(chr, in, out);
+    if (!qemu_chr_open_fd(chr, in, out, errp)) {
+        qemu_close(out);
+        qemu_close(in);
+        return;
+    }
 #endif
 }
 
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 3d1b0ce2d2..e9f3bb8290 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -150,7 +150,14 @@ static void qemu_chr_open_pipe(Chardev *chr,
             return;
         }
     }
-    qemu_chr_open_fd(chr, fd_in, fd_out);
+
+    if (!qemu_chr_open_fd(chr, fd_in, fd_out, errp)) {
+        close(fd_in);
+        if (fd_out != fd_in) {
+            close(fd_out);
+        }
+        return;
+    }
 }
 
 #endif /* !_WIN32 */
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 1ff31dcde3..c622d758db 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -276,7 +276,10 @@ static void qmp_chardev_open_serial(Chardev *chr,
     }
     tty_serial_init(fd, 115200, 'N', 8, 1);
 
-    qemu_chr_open_fd(chr, fd, fd);
+    if (!qemu_chr_open_fd(chr, fd, fd, errp)) {
+        close(fd);
+        return;
+    }
 }
 #endif /* __linux__ || __sun__ */
 
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 193727e807..2568164a10 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -110,14 +110,17 @@ static void qemu_chr_open_stdio(Chardev *chr,
     if (!qemu_set_blocking(0, false, errp)) {
         return;
     }
+
+    if (!qemu_chr_open_fd(chr, 0, 1, errp)) {
+        return;
+    }
+
     atexit(term_exit);
 
     memset(&act, 0, sizeof(act));
     act.sa_handler = term_stdio_handler;
     sigaction(SIGCONT, &act, NULL);
 
-    qemu_chr_open_fd(chr, 0, 1);
-
     stdio_allow_signal = !opts->has_signal || opts->signal;
     qemu_chr_set_echo_stdio(chr, false);
 }
diff --git a/include/chardev/char-fd.h b/include/chardev/char-fd.h
index 9de0e440de..6fe43062ca 100644
--- a/include/chardev/char-fd.h
+++ b/include/chardev/char-fd.h
@@ -41,7 +41,7 @@ typedef struct FDChardev FDChardev;
 DECLARE_INSTANCE_CHECKER(FDChardev, FD_CHARDEV,
                          TYPE_CHARDEV_FD)
 
-void qemu_chr_open_fd(Chardev *chr, int fd_in, int fd_out);
+bool qemu_chr_open_fd(Chardev *chr, int fd_in, int fd_out, Error **errp);
 int qmp_chardev_open_file_source(char *src, int flags, Error **errp);
 
 #endif /* CHAR_FD_H */
-- 
2.50.1


