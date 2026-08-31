Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78634C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14SS-0002pp-Ig; Mon, 31 Aug 2026 12:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14SN-0002nK-Rj
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:59 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14SJ-0001gB-BV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:59 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so64242a91.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192114; x=1788796914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qiABzT9brkBXTSb3Fx2nSHH2TcbG/h2o76wYEP9lGD4=;
 b=ULna3fzr/Yhx69Zx6VGfVre+0mB6/daz0Nr1FVi1/D/PBgyJwHOo82SqUlivgIZ02G
 IiaGYnE6KEAmD7ph08ywzdm0NY6QsSG1VvKtbZ89dLfghY7VvqKzwKT3fuzQr/IAFMW4
 5tU9i3ZJByvp8OasRIcfB51NiYnZoSIwVeKffBoyvALWAsg7x6kz+CzMGiUfTzJQzRht
 T6hXqrxCxpeMNHxiQKuPyr1ayFhjZq/RXYv7uOGKxorZ0a5/LuOmcO9dWkCo/cqp8hfK
 2k96q8upGQEgHT0V7VQiYDwjq32ZtZDjY/elRkJg7oCjjgVC9RA8c8rukHk+SIRCnbHE
 yj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192114; x=1788796914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qiABzT9brkBXTSb3Fx2nSHH2TcbG/h2o76wYEP9lGD4=;
 b=P39rDo96aHB1+Pztz1jU5nFFpKVipzNkVQog9klRFgTJMSms9N4yPi/Ll4aSlg8ojN
 ZngFcqUeDXlLaqDbH+xv+CyUy7Hykc/w8L9wl1F4a2giXJP8LOru8TyVEZWhp3TNFJhe
 8KttbOaBaDV5ni93kufYVMcLZqeDL7gHIgiUdHc3XLFJsLTfZ4fpmxRtfhGO08Li8Zbd
 2hFL4LPA81sdLpTm3uO6rj0b/hqGhsmUIvdlBKZcPIaxebmTVNa8DCUftHuwtGbUfYML
 9JmpmZpq2C+fHF59/2KuDzAYE5CF+1bhukAc95iiLBe0I3NWT8J8n8Vgs+nv1wEetxkW
 z6Rg==
X-Gm-Message-State: AFuF++m/aMR6cIAiY1dUFHTxjE1zk+ygs7Y0NH6Mz3heOCaM4yUu4g6z
 PjoO7OrB+7JS9QIS0y/XXiZz3PCP4g7nBdAyYjRIJ3CWt4vHIoZ5dsxD0fepjQ==
X-Gm-Gg: AYBFou3N61YJfAiYyKnNcULHwzFzrCJVjh6UbrCRybF5SUwWBFwJQsQ4wc3623lXwMc
 tx4D/8I5z7VQ/LYDS+vO+7y/MwKte0WJ7JS5TkPIDThUJg91PVIhrQvkWVdwtoHhAXGrMu5yg4b
 bS9fQtoM7LU3QFuJoLTjC2d8XN3QULQmG8/mMa4nqu90xlA7TB1S+y2J8Z6/yQa+9VFQGhpZi9y
 UJZRGOeQuI69B3rGgla74MufRphCi6gKn4+rHHowo5YJQfm8ckyb1TSZxhmsQ4iG0CYuhO+3YbY
 GFODuqb+o4+w5oUISBtWbDuj36qwhgMN0cpXRBO3N2RG2DnBp6176cvuLiBTGtw6swFjeJn6i86
 i8JiT98Q//fVqKD4hWPWlwo0iehimcqOYG2RvEuXbAr7LlFfyyum4q1b7pJGiZ0suPu7FOFQe7u
 IFRtvTqJWVISG8r28S0EBS6tWAcRfYQryWTmmxiLbTF8nlvsyiFQGsKusPpUBFofoyQRVzWG92U
 KIPR27Z
X-Received: by 2002:a17:90b:3889:b0:398:c8f3:d076 with SMTP id
 98e67ed59e1d1-398da8d5422mr8104261a91.31.1788192113600; 
 Mon, 31 Aug 2026 09:01:53 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm22689520eec.4.2026.08.31.09.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:01:52 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V14 11/15] vfio-user/proxy: Update tracking iothread users
 with holder name
Date: Tue,  1 Sep 2026 00:00:32 +0800
Message-ID: <20260831160038.221776-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831160038.221776-1-zhangckid@gmail.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1036.google.com
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
2.55.0


