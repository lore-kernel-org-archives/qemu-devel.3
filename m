Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729B9CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4rh-0004Pr-1o; Fri, 29 May 2026 17:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qp-0003WL-NK
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qh-00031c-7s
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:38 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82f8893bff3so6707844b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090466; x=1780695266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3FbloHK6w+/ukY/MY1iEubAmBIssvvNZxFHmduZNWk=;
 b=YK1O32u4dCi4HdJGw7Vjd7arpwF83UTImrZQy9rSrME0gnur/Sap/RiE1mzEfnWBDa
 skFkB2RWnzgRe0GWMfowAy4Fj6H0r9DRsQ8Lzzf8TZughdwdyHzrOm3fzpLH9RAQNMcJ
 CU5F+1evTMHYF7XjYPOyMVgmUp4R2ru5an6gywPqyE4S3+H7dhUBiVBw8558VLju8Emp
 Z9F7X/yuYf/cnW4/yfK4LtnNE60DayiOY55nD6QS67QswsbvVAtVvBnFNKxpX/NrV3PJ
 y0nAVIXSvZnRhp52/k1+xav6h1f7Sj1vT3DGRbp0SeBcePMn082l8A/9d29Aa98EoeNq
 03YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090466; x=1780695266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m3FbloHK6w+/ukY/MY1iEubAmBIssvvNZxFHmduZNWk=;
 b=MSRYdjPv6BYULkDy8oS3v9YaAuDcwZfEOoyrn6Ffm7UtncgLO93U2JsdDgAWyopT5a
 q/Gq0sE3Mu1jhOlDOnseKTEuqHsEDs9EeJTgPqJToqGnD9EytE5qnnfQ4ex8blONh92/
 77sw8PkSmiucaCuj2HJ11fA2PC2ufVbOqoxAo/pSAFertMcMhEVemhxUjD4kUclwqbuS
 0X33gLULtQFgHk7XmKmkgxgnWODOFiDqqMs6VXoPVbwpbepDg3rs/WJlvFK9TBismsuC
 nKNfQBDu526U0nu3Vvn0uLuSq01JmzQ2Txqn4Uj5sdp6A8ACQlZKNNNyTdmlJx/CmsW/
 cuNA==
X-Gm-Message-State: AOJu0Yx98ELWIaFcbMxmy3KaUaD1g7nL85HR7vKqltNM8ZenBKAU2NRy
 nygaXxUC8beDYZhJ9JyUryVu/x8cIfpE6usTmCjbIqM5Nf6qjbffKb0Bzx9mVzFKvgw=
X-Gm-Gg: Acq92OEwMNuywQ+nYCa5Vh6uFOBTYJ1RjFuuK97o5IopEtRiJDdsWmXvAl6v/sn1Etl
 lLiG/tYVQi7x/o+y3G3INy85gdA9Nj0zcLcfnJomvHXh5CjhLlC/fYKXc6fi7DLoWlk+DBS7iqu
 bz/MYjUAW96vf2zRQpnUlL3TBKbmwCR+S53vAjyM6uYXvr0Y+PPARv+esmsN1eilsp1/bbOUQ7B
 cV8qBJHloauEyuPTjGN4lVkP9BBXqyeAsoMezaAMZ6dl388Jt21FnQ8Uf6uUZSq5QlBTCUaVb6B
 bLkVs8cegtiBF1Jh3SyLI2xjcG71zRCYb20v6vPte8+U/jvfukswmGclwa6MJhfV02zixLy7ToI
 eaFmSFNP7rtpj4yQlf6i9NhRIXehwv1T3BKHhkVfkO9e3KCzZkBusD02YQ2k3/+VtgkjflNbUO5
 S7Qkr0c/dU7Pj0QNus3Ws53rIBcTPYlfI3Rmvh9sV8bEFKTEltLXy/Y+ytIiiszk0=
X-Received: by 2002:a05:6a00:8c5:b0:82c:d7c4:4c56 with SMTP id
 d2e1a72fcca58-842253ed738mr1178545b3a.15.1780090466052; 
 Fri, 29 May 2026 14:34:26 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.34.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:25 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 12/15] vfio-user/proxy: Update tracking iothread users with
 holder name
Date: Sat, 30 May 2026 05:33:18 +0800
Message-ID: <20260529213321.96271-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x429.google.com
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
index 314dfd23d8..756f368849 100644
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
         vfio_user_iothread = iothread_create("VFIO user", errp);
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


