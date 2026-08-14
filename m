Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C5DC5DF6A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw22-0004NG-3O; Fri, 14 Aug 2026 13:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw20-0004IQ-4e
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:24 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1y-0007xi-MP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:23 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d032846c95so19637605ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729761; x=1787334561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xE7L4Waxaj/RwZXErdhNiMdcNAX0AneR7qbMi6sfdII=;
 b=gdVX+BLDbMTbsw6IlTPaNfH3+rMSAIdd2y4bVfwUbXJLi21XC5iaFfH+QiYzNs4cze
 z7bV9L37hfJHJ5o8688x5mMPWUvzre6hBVjaLx7RuNHoGZ1ivDWJWA56IySutCFInDjf
 QWJISrGVjYUa8EJpGInl+zhd3uPiqwNCnyjsjYYv5ysz5Ot8DIzIdTjdnbYc3UChV3/o
 pL5SwXblm+9V5RBq+AHFGPYM9psHVCo/k7iA9SGw11R8mWBrGlx0IRzhOlw+uEcSYWm9
 Miv23lYvlhe7SJqzquEiM+uCjfGKXwt2a6PJ7fXwmJMahMaDKY/PgLGnsAjvaS+TXwuD
 x5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729761; x=1787334561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xE7L4Waxaj/RwZXErdhNiMdcNAX0AneR7qbMi6sfdII=;
 b=XVImCcDUJDCwMrtQVaoQCwLNd9ocgbz/CXMwWa18DR8xJ5gEo/23sLr4dCmdxwhKUN
 M9rpywxg4oFFeQRVD/VcQzGtJeQi0Moo016nXdCTb9ho2DdbbtjXgwPq7Pw6KEc8TTwG
 oaUxt10zDMKGzoXO6vPYMT2UP9W8du+Tz2I0FUyYZPI4QBEFLwzCg+CCQQl3DgbSicOb
 5+5XMR3nfdvx/55NYeCZbPOzOIq6l3aGljUkxRYaThp0eKAxfyb9L58AEVPwggKRJBS3
 5Ph3qW2o/abywAyxOkxST+ux21zTCV47Ew+88OpB1HzI67bNcdhCplRj2hJjPI7nTr8s
 BFgQ==
X-Gm-Message-State: AOJu0YyllZ/CNVjPXWI7T45CgIzoho6+X0U2duksdA+H235X/6Q4s2yH
 J/h4lvvMxbFd9Il8PtEuexb7XddXW9E2J48t3KaL6GBFOc/obL60ho6VHhc+XysRrfSlsg==
X-Gm-Gg: AR+sD107+l0/eu2iM8lHJOqUOJtwHEzEGy3pPLpjcCx6ANkxDBjficosc/QFyM/LayE
 QHNs5yHPCRT2aA8zhcR5cfXZxQEgsMVh24yDbAPsVW05EsjG5yhtm+CqE7aPnQjlGswumGueIVN
 nKT7koXrV8T66muw0hg/GEpS/3QJXNsj8ug3rLaSg5lzcJBGkjVXxOdQg+9ZTDwKJtlLMwDRfzW
 9LXv+u7fwh4s2Ds7ZbN513FTEVnjSCM3nVz3It9z6Ll0HIWu0X/bt8kvhMUC+nqY/7+ttlhIE/3
 sPvUHvdukFT64BRN1vHvtiaPITYgp7tbHrwZeac1BTNz0a35OtzCi4SmSaP8Wm1SRg7X7hX3vnu
 Lzm7fw153w1QdXh9ANXazSdOowYoOwYqK9KHxQKYOQJjq4+7c7xvoXY27VQTEDJw1QLOknfN9KO
 wUo0VJBfrc8mPRxlCcGGUeUs9fg5PEleu5r1Gi2UbyZJjW82q13b6HneI0LbdsDJo+lG6PXIOmR
 f8RvC+i
X-Received: by 2002:a17:902:da89:b0:2cf:a1c0:d4ca with SMTP id
 d9443c01a7336-2d3b0cd1dbfmr94058795ad.22.1786729761162; 
 Fri, 14 Aug 2026 10:49:21 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:49:20 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V12 11/15] vfio-user/proxy: Update tracking iothread users
 with holder name
Date: Sat, 15 Aug 2026 01:48:25 +0800
Message-ID: <20260814174830.1691540-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/vfio-user/proxy.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 197aee07bf..e642fb0ad3 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -898,6 +898,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     QIOChannelSocket *sioc;
     QIOChannel *ioc;
     char *sockname;
+    g_autofree char *path = NULL;
 
     if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
         error_setg(errp, "vfio_user_connect - bad address family");
@@ -917,6 +918,11 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+    path = object_get_canonical_path(OBJECT(proxy->ioc));
+    const IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = path,
+    };
 
     /* init defaults */
     proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
@@ -936,7 +942,8 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
         vfio_user_iothread = iothread_create("vfio-user", errp);
     }
 
-    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->ctx = iothread_ref_and_get_aio_context(vfio_user_iothread,
+                                                  &io_holder);
     proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
@@ -967,6 +974,11 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
+    g_autofree char *path = object_get_canonical_path(OBJECT(proxy->ioc));
+    const IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = path,
+    };
 
     qemu_mutex_lock(&proxy->lock);
 
@@ -1021,6 +1033,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     qemu_cond_destroy(&proxy->close_cv);
     qemu_mutex_destroy(&proxy->lock);
 
+    iothread_unref_and_put_aio_context(vfio_user_iothread, &io_holder);
+
     QLIST_REMOVE(proxy, next);
     if (QLIST_EMPTY(&vfio_user_sockets)) {
         iothread_destroy(vfio_user_iothread);
-- 
2.54.0


