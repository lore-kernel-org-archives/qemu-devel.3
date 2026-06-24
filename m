Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2B0CDE001
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHm4-00074W-FP; Wed, 24 Jun 2026 03:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHkB-0005JF-Pq
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:59 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHkA-00036e-9b
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:55 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-37d82f3a244so455098a91.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284993; x=1782889793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Led6dtm27lEqwR8zEWN3ior7m9T5nwFBmwYxnZK8iTw=;
 b=CfuO5E9t83Xzje+KcR+h4K3ZuTf9YQ8wg9iUpTKcjycbQCMV1yBd9t51oquC7Z1SbP
 J7/AGboeyM9s2AOkL4DPbThrQLLxlHfX2ry7KYvZjULNyC25WvMM7MMHD+xZiV6HzuJ+
 5jAZo9NIQdskRnd4dDHWbsFauNZGvBaB9zf5iLYxZMcrIvV89F19PVgUJsyI4FuE+RmG
 xM9fW2PjM67a4TaF5SJ8Lw15j8XJQaHX8A/N/zvETHrcsYwPl8gdSeBYcVXzFqdozuK2
 YLPy3kHu3Q2fL7Jlg0lHrXHonrLarp9+axDx2/s1g9SkgmIf4T5OohLPtaOUhAHgWR74
 FBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284993; x=1782889793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Led6dtm27lEqwR8zEWN3ior7m9T5nwFBmwYxnZK8iTw=;
 b=r1UKecNBGOH+qIM7KVmJ27rrQra3ltiJbOInAQ0eLDIe5Aex5t57XlyecVE39TctQU
 89XbunE2fHYz+a5oHlP3iA0Kjh84r1qAzn04zAyarAskFgPQYlMGEJo9XhlpNo5Ks6rn
 KHo80IHYNmGGy9NrsASN5CElgC+OfUOU8uSXyYCFg7NxivKHSHwk9Rz5XokB6aZO7j48
 pTnDaF3aYkpcq5Owl0/IeU3W8aQB38U3gyI1dwDsqFdzwE2JNUwtq+O/AkSDPzRouFZH
 +A+etYYU1AlkTCbKOJaYXDWeEW1emmtJw+ByueupYNe8FouCDODAxOKNj9rA+FLAUS+H
 MbNA==
X-Gm-Message-State: AOJu0Yw4BYkswyYeT7oqLXJKtZWzUzIBCXEf9OVhIosEIea9CcCLvVQA
 tamqSSi2FnV8hS76tnbEN8iV9uXPdHhFSuQQsW/Mqhs8xP9Elcq+oy0gKtyKhRQmn90=
X-Gm-Gg: AfdE7cn9cc8+a7x2bHcbVoxDwjEosTvZej3VxBj/QWuY2rI1d5iTToePyckzR5DUWIp
 Jb9aHRWEKqa5zOEQc+YjFyrILDlqbuZXnLsqAyp5zmyaJ3++RANND3JM02YOa6Qs7la9WTegVh2
 1cEF+Y8knxuHQbrwnysV/zGqG4JACbuipvKRRlmJ+L0DKwP2jC62hbZ0oU2RfMosDZkzrip1Tzm
 rwFQ9I8HsiOOiZf7GXMqfbCWNVpxUUInANCApiidvxz2HihYFmvT0NZKnrsRP4SZn8EhUzUUQSU
 +81CUZ5Gs0PmeEXW9EHdOoAW824QiFnHkUI5VjepzjxZBvkFPnd66mV6ciY7jO4AZuntMSLNof1
 Q8y7LAeQ1NpE82x5NFMe3GHJ6MSm8+hQySusu/RdyWjIO9GV1sf9O3XC4/kefSUYOrlYYL1pTIo
 lLoQo85GsvraFH/bWahArsWH/sqPYkloWjT8GMoTm6SD3sOtlv3fr3
X-Received: by 2002:a05:6300:83:b0:39b:89e0:2e37 with SMTP id
 adf61e73a8af0-3bc51b6c387mr18634900637.14.1782284992793; 
 Wed, 24 Jun 2026 00:09:52 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:52 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 13/17] vfio-user/proxy: Update tracking iothread users with
 holder name
Date: Wed, 24 Jun 2026 15:08:47 +0800
Message-ID: <20260624070851.13342-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/vfio-user/proxy.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 0f7d8425d6..b4f749f245 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -898,6 +898,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     QIOChannelSocket *sioc;
     QIOChannel *ioc;
     char *sockname;
+    g_autofree char *path;
 
     if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
         error_setg(errp, "vfio_user_connect - bad address family");
@@ -917,6 +918,11 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+    path = object_get_canonical_path(OBJECT(proxy->ioc));
+    IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = (char *)path,
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
+    IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = (char *)path,
+    };
 
     qemu_mutex_lock(&proxy->lock);
 
@@ -1021,6 +1033,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     qemu_cond_destroy(&proxy->close_cv);
     qemu_mutex_destroy(&proxy->lock);
 
+    iothread_put_aio_context(vfio_user_iothread, &io_holder);
+
     QLIST_REMOVE(proxy, next);
     if (QLIST_EMPTY(&vfio_user_sockets)) {
         iothread_destroy(vfio_user_iothread);
-- 
2.49.0


