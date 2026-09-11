Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924C0C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yB1-0006lT-Ai; Fri, 11 Sep 2026 06:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAt-0006bz-7s
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:08:05 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAq-0007JK-VM
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:08:02 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cebad4adso678485a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789121279; x=1789726079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zNkftpkxFVpDoZUxzARQ6dpOC1MsUJSxg+vsslS00BI=;
 b=Wg4xiCygpzAy/voxCjd77iXdoXd+bVrzcrE1YYcOaLtTfrp+Ey/ou3w1s0n9M140jJ
 LO4htqF7hBq7ATQhHgq8+GJk0WzKebSoh2ptDSKwM9LzNDmfni2WlkA4xo+u1MOmKPDZ
 fNdc5eCzpMH+MwkeEQ+vK0T4PIvx4yIAPZsnbq6EnJIJasRl3X6yrsWNy1fFEHJe5mdA
 AzsUvNOWoyaa8rD4Pl2350L73tKDQukZgAt/r8UWd71TEIbKTvHHKIIgWkujLQrvPryz
 rRHSdnWCarKphstLk+deICgEk2dvpBjeTUtzehGtjLYvwH26y4OIKPW2dOZgzajhOjay
 tZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121279; x=1789726079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zNkftpkxFVpDoZUxzARQ6dpOC1MsUJSxg+vsslS00BI=;
 b=gWH4TSDCiIlB0VRFXsnZjqWsE0vvz/luAJ35KEztVwxWGI254cn+C6RrfVOnunuhMI
 XEEkwMdZ3QNiMbVop6EkvOMMC7WWNBCGRjJpIU8lhTSfFi7r17RVJRp5YhIlUYttm7Wz
 5fSH8zRnOGQ2ZhF5n53vwkfb7/e8PYYolezkjMuHCFGReWW2vm1PvUPrIUB5pXTH8ZEr
 esnWKqmxjqFrMTGd68u08h3OcJCm3herTlEib4oRG/yp6iquATKY6w9ApS9RpKfotqX0
 Hy0kGRkyqpztMssmI+1IUtT19wwA6N4Ou6BFTJ89bJCeaZOVxoBDXHUCKvlywRagQmuO
 1agA==
X-Gm-Message-State: AFuF++lhifAjh4/1Camlw3K2uzxroBEVUacvQ+pt8Gnjg0KB3KXbJ8wI
 rkTHxhTB955kHM5dn78NgVcnHorZ8MrnF7iQmrYC9ePTvdtN72M5CAGRJnrUnw==
X-Gm-Gg: AYBFou2/gHaQaQCaHxU8EQQY199Hvfg50T6bWbCe+IdqZgwgjYcZlYEOyv1BwF9ahoT
 rHBVcvl3srhvrhzcw5Z1sf0Wr5I0r1oJzfX1qb8QXH58RaX2nihmbA4twUY6k1vWj3Ra+AKp8SL
 84Xm6QLXwJZTlAV1YORw5AkZqSr7rz0hdHo6gESmnC2PJSe0Woi6VFI5kWcT7bOnPovVcGPzYHH
 elwQV2UGxgerSbwg7sXJQSpwAlWhehsPB22rhBfaxOmcSGLbeCT82pgfbwxmZXWyiuRSOYWXriT
 DLS7OyxXbwKzWJWV61TNdiqUD1ywF/OACJv9zAbACBMMMbz+aYUdRSyuFwZC4U9+cL1YIsUk245
 uiEe/C/Edh1fzuX86zHjNKpvuzotyoDYCFLJFE2uq6IgxoqQS/YAz5+TneuQm8PD25y9MnJvmmO
 hXatXcrFvoDz5l3s4N72oKHU2vIkF2p6drDqXHALxrjUomquj0n730j5VXhzddGMMsP4dAem/0o
 i2oMru2tgFpV8S3Q9mVQQKJ1YE=
X-Received: by 2002:a17:90b:2588:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-39d9bd99cc7mr6315063a91.10.1789121278837; 
 Fri, 11 Sep 2026 03:07:58 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm4514800a91.8.2026.09.11.03.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:07:58 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V16 09/13] vfio-user/proxy: Update tracking iothread users
 with holder name
Date: Fri, 11 Sep 2026 18:07:05 +0800
Message-ID: <20260911100709.726366-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911100709.726366-1-zhangckid@gmail.com>
References: <20260911100709.726366-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=zhangckid@gmail.com; helo=mail-pz2-x10.google.com
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


