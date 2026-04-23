Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D824BFDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyqt-0003eQ-W4; Thu, 23 Apr 2026 14:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFyqr-0003dg-MO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFyqq-0001Lm-58
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776969154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vc/pJGjkgyWmQP2xxj1GO1bV3g12ILLASq9+yGdKiXc=;
 b=bmslIhkO5jFNHPNc3qlPoOFhRg1+4qwESMDbfv5sQmcafrczyAQJ5gLeJC/NqjfeAoGarA
 gsFBr57OJ91BdHce/C/Do0AhkVU7pqM5ucYT7x39i4IZfNy54maeabp4YgHQpQ/BERs8B0
 GcY9MDjv+e9IhJrXvbHcyVyjiuC02rM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-atrXGNEUPUOcnYAuEOsHfw-1; Thu, 23 Apr 2026 14:32:26 -0400
X-MC-Unique: atrXGNEUPUOcnYAuEOsHfw-1
X-Mimecast-MFC-AGG-ID: atrXGNEUPUOcnYAuEOsHfw_1776969145
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8aca4660827so202096256d6.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776969145; x=1777573945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vc/pJGjkgyWmQP2xxj1GO1bV3g12ILLASq9+yGdKiXc=;
 b=FvB+vSkohgwRYE+GYPX+t+mSNfuNnVmclrTraztq8sn7QSQdc7MRTpwV1LpAaNfDxZ
 dxtwAJE1wRtw5GJu4AfEFhOrmzZ+sfBQ8MvToNXL6+H1helXPEqVw86IwVEykMv5wB5A
 rX2+y2MmLeLEhEEFgQmFqsQeTNchYr3GG+7y9Urt+PO0NVXEy2+Pwk8rSJv9c2anRuiD
 YK/Fu0HYTvXdUmQeIRdnNj8XN9xaCdOQuw0J/vk8aQykxCV8BnVqSHykfwgFiVl/5v/I
 ney6zIMw2q39ioF6BLk3JXsg6EEiDM5gBv3x0sj8snpaKgxB0yYFXIqQy9jC9Z0OSsFI
 9g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776969145; x=1777573945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vc/pJGjkgyWmQP2xxj1GO1bV3g12ILLASq9+yGdKiXc=;
 b=VvAEp3pHximMr8QfT9Gnj/S8ORIdOQ+jvm2xYFS20R9Qz6eWunM2HLt7RMVnC39ux0
 w4Yo9hu5tFnTmGV1wiiAOF06e//VTpU3CrXob0Bx7SGSYOBdTVQlBNI7eN6cREliG0j3
 clLEcr0xTYOPMdvqLk5adyvHLToS+empl2P/GAwP4+kBVdPCVEFVt7D0+/xMod7uVjU8
 +qi+W+TkwTi6qAQkGMKUAaNSNVfxo/ECy1/lEe5R2OwnwBPaW0rlznJpWQfhW5MMu3DO
 NeUzZs+P8zjNDIKl85/mADCXakotkLRot/5o963sumUIwpJoFejzX+9bmv9vYTjiFTMQ
 WrXA==
X-Gm-Message-State: AOJu0YxrwDf0wxXs4Uh89RxV6QXMvDaJPgg2nHIffpQC5QrwwTeXVKAb
 FH+hmWHzPpkvsvIjRwMeKcGwO00IM71/PAYvQlvBfHITs6V7FHNdHv5aNL5pNkdmuePuhxIbwRy
 3cpAXemBabR0uulXO1rGIoMnAAu8PZD+bAkkhZHwAYuiCCeDGMem5wAHsmLWKb5yI0T04lovbvl
 /yW8xGjMF4wIqrI7zDs0mcR3F80hcjJddenW/AIA==
X-Gm-Gg: AeBDiesp/gRil08oHpUooaL9p/oRkQon7wgP19JwcZ5o/9nBZSpq48J4KazS3km4ddM
 3ulcUZShAjQ4hbWESLHUj/+t36fbC+lc+PG/rbjnTt4imoyPP0iQgocUa3Bm15cFLaWT7jUSjHY
 j1U96rQKcqS0Cty/aL7WCRo7F7foUa9B9jwh0yDjOwNDkfM6ub8kRQMKSAfpgz9VGjy/4WM3mI2
 qwybj0H3wOKKDb6uwxxLKMHPzZxLwIc7a7k2/qVI70ozhYNMADeUwIRWK8PV4fDf2NXuHaI8Yv6
 kRazfqQDSCNzW5g+48w9nMeY1HSmA0mizdBZemLXp9Wb15YvYgNm64GHltcP+6ZRMdcP6LUmUPG
 Ql3LlV/F4DO+ePsLVQBcJscdtvh/yc7N4BiYU0xKz0cuZHInkERv1ai0=
X-Received: by 2002:a05:6214:20ad:b0:8a7:e3fd:4d8f with SMTP id
 6a1803df08f44-8b027ff7df1mr414627306d6.8.1776969144877; 
 Thu, 23 Apr 2026 11:32:24 -0700 (PDT)
X-Received: by 2002:a05:6214:20ad:b0:8a7:e3fd:4d8f with SMTP id
 6a1803df08f44-8b027ff7df1mr414626366d6.8.1776969144212; 
 Thu, 23 Apr 2026 11:32:24 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae92fc8sm160665566d6.40.2026.04.23.11.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 11:32:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Zhang Chen <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 3/3] qio: Fix qom-list-properties crash on net listener object
Date: Thu, 23 Apr 2026 14:32:12 -0400
Message-ID: <20260423183212.468047-4-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423183212.468047-1-peterx@redhat.com>
References: <20260423183212.468047-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QIO net listener object will crash with raw object_new() then
dereference the object, like what QMP command qom-list-properties would do.
Fix it by moving mutex init into instance_init().

Cc: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/87a4uvw066.fsf@pond.sub.org
Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 io/net-listener.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/io/net-listener.c b/io/net-listener.c
index 9410d72da9..a772756eb5 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -35,11 +35,7 @@ struct QIONetListenerSource {
 
 QIONetListener *qio_net_listener_new(void)
 {
-    QIONetListener *listener;
-
-    listener = QIO_NET_LISTENER(object_new(TYPE_QIO_NET_LISTENER));
-    qemu_mutex_init(&listener->lock);
-    return listener;
+    return QIO_NET_LISTENER(object_new(TYPE_QIO_NET_LISTENER));
 }
 
 void qio_net_listener_set_name(QIONetListener *listener,
@@ -440,6 +436,13 @@ qio_net_listener_get_local_address(QIONetListener *listener, size_t n,
     return qio_channel_socket_get_local_address(sioc, errp);
 }
 
+static void qio_net_listener_init(Object *obj)
+{
+    QIONetListener *listener = QIO_NET_LISTENER(obj);
+
+    qemu_mutex_init(&listener->lock);
+}
+
 static void qio_net_listener_finalize(Object *obj)
 {
     QIONetListener *listener = QIO_NET_LISTENER(obj);
@@ -462,6 +465,7 @@ static void qio_net_listener_finalize(Object *obj)
 static const TypeInfo qio_net_listener_info = {
     .parent = TYPE_OBJECT,
     .name = TYPE_QIO_NET_LISTENER,
+    .instance_init = qio_net_listener_init,
     .instance_size = sizeof(QIONetListener),
     .instance_finalize = qio_net_listener_finalize,
 };
-- 
2.53.0


