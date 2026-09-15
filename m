Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC71C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QEx-0003PV-4U; Tue, 15 Sep 2026 06:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEv-0003P1-T2
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:13 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QES-00037b-13
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:13 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccd78e6eso888568a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789467463; x=1790072263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zNkftpkxFVpDoZUxzARQ6dpOC1MsUJSxg+vsslS00BI=;
 b=XccbiOIcbMROOBm46u710VgwIkTqPHnOoEJ2sabfd3Wo4EZMy909fFxgV5Kc52nhX9
 t45cyGj322LBx20/yJ/PSPtqgIQpIduZ8G5G8u1cNVfG0NgeHyjc+PlxTmnewGSGFJaa
 ol2V5k5+VrNL5f0NvnzLa4wxbnO1ssgP4tHclO9Ow6WPASPdq3IrYwwoCFqiwJ4MoyKj
 5vVRCDL+qEk52x7PdF6ML2hqt5GnT+mCtY6hS5ppXOxxzNFYvRK+yK5PJyapvLRpVy1e
 uXVF+QZBjL2Xi9v2BpCu2FM3PoXxYS+U7KpgjPjJInFkJCmjeu3WO6iX5SOsiXq8QlGU
 fAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789467463; x=1790072263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zNkftpkxFVpDoZUxzARQ6dpOC1MsUJSxg+vsslS00BI=;
 b=22g1KvzLoXL/0gDWRVfR1mKNDqzoH31EdF4YRJruWCuwk87dGnZC7jOOipCgvfZ+xh
 oBjCfdvX8Ngk2960gIUQtrU5wEw68DktJii2dk4rh36KZh7UjftRKDqP6PndXDXMzIXQ
 iQPMCf9mE40bR/EnSwZkd4dcieaHHDrkSSZs87siJPXkI3ZALlOK8U6PEe05IpyPkDUq
 Zy6ySWJvQjR+FfvIP+Q+dN+fxFEkd3dn2NoSftkGJ2e0TErwHst7lgmlm6TgOgiZMHTo
 Z/N74miES+bOFow1YDrzEDLE75APNzq+KwwssMJyN4WnD4AEnCTaHAcqRpmSKH4gGSxA
 C00Q==
X-Gm-Message-State: AFuF++k7Kx5yigamurWYo+SJJ6lH/FfgNFZ8O8A1OIY4Th9azYllZxlt
 UvgtdYMhrOTdjRzecdyK/wogD3y255mRfXeiTwltYOBvnLf7oO+dPu5MsoGe1Q==
X-Gm-Gg: AYBFou2/QE+rCwqOdKK44UDD6GKxn60LdhUJf9L1rQrgQJMPcr8dW2ok0fJYIb0EbcA
 iuyE50ySaz+iL9STXJi/KPCV4skyw/sgYoszfL8/6lZkDTeGMbHcZKAlm4XEXOL7aBc+u5nNO3e
 HXTr6xqPvD9jgZYNqtq7TMcxX20Q4YWG/sBijrfaVvjz1YixgyHYKNpQ+iLpUYzg+QNeHsiBsrf
 jyyVpVKs3D71HQpA3IEq+HRkh5uwXs04SVicRfCGuGV/4BCiVr9PpaDMX/CCR0vdJ47OEIiGLic
 AK4AMi1WFbNXql+m5e1vjJFTgFz4RdxzGD9H8Qlu87ve4iGIZTQXLoywOTWgVayhks88pxIifKY
 vZ0gQSArFeOByPEkvjnnBXgJHHXu/ky2cP9fe1LekSKnXl0bivJErwouwhfwcv5jPBj4WSBJKpV
 qsyE+EaM7lLVu4+JuudiNzrV6klnWYZZBE2uXuX9QP8M2Ng5dLLAzXCcMLy/sSoSZmw3Z/kdDpZ
 JDJM+MOMCsjfExCWOxecvvbjxA=
X-Received: by 2002:a17:90b:1c84:b0:39d:f247:bb2 with SMTP id
 98e67ed59e1d1-39dfe128816mr3441605a91.12.1789467462648; 
 Tue, 15 Sep 2026 03:17:42 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdacba6bsm4416868a91.14.2026.09.15.03.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:17:42 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V17 09/13] vfio-user/proxy: Update tracking iothread users
 with holder name
Date: Tue, 15 Sep 2026 18:16:51 +0800
Message-ID: <20260915101655.3216101-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915101655.3216101-1-zhangckid@gmail.com>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.43.0


