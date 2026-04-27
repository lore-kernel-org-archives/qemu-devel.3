Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E050FF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRs8-0001lc-O8; Mon, 27 Apr 2026 15:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrk-0001JV-HH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRri-0007qk-GB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bCdTxip8FNtJt22m42Ll7TRz6Zd06sy9UeGEc0+Czr8=;
 b=f3A9fCvJpf5xWSfH6nlhZfK/k994QHoXyWsAaZ9pzlTy++FIwsdpBiQftbAj2FYUGMqp3/
 HPZdF8Tcn7AMvJxSCVQQKKNbTcictPR7Ry2bxWNB90LCI6f02iNy1bUfuvL3U6ar2cDxQm
 gNnKF5W/vZ6jAOelfRHYoQ6YG9GMXHk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-155wX3K5NM25kz0SWDP0TA-1; Mon,
 27 Apr 2026 15:43:31 -0400
X-MC-Unique: 155wX3K5NM25kz0SWDP0TA-1
X-Mimecast-MFC-AGG-ID: 155wX3K5NM25kz0SWDP0TA_1777319010
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C400519560B6
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:43:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C806180045E; Mon, 27 Apr 2026 19:43:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:10 +0400
Subject: [PATCH 11/41] RFC io/net-listener: move mutex init to
 instance_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-11-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 peterx@redhat.com, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AI5iHywR+QJtls1SfbIwtt7tGFLKNLtYM1nZ2EPFdE8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUTPj7CJgSq8YwiimLt+PkyyUp1rMGmtyHC
 fUZCH1hgIqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5biiD/oCqLacfxTJFTvmKcd+iTxjz1hp0q4/2fXdcMOyWC5NtM7bFf4vvyuObSTCDUrePO7S3Lb
 bK4VliKw3SWZVBqy0/XmXv6ipdScP6ww7bCog11BdzpsSFb1yHWB81SawlPJ80cS29Cm7wRC1Sz
 wEEBMqAsTcqM0+WnknyAoQmo0ase6qshynQLT74CKNkRtL41ucPLeU8D+W3kEz9/1tk0Xl69oy8
 zsI53Ae9f/atKlLFrwswDGfaRB9lgB689yY03EjyimHefgR5P8dl4gBgo/1x0AThBIP6zjEHZ2o
 CagxczwoCazE44ytloYJkU8z08r/jGRYMuLfnUKXUCaee6FVTbcsXHmtcIcze2dkjha7U/TfmKD
 rRRiLUF4DBWnLH8JO4ejwopNKQK9y2zwsEp2iIUpO9itNCrurd6/0pAw1DyXlXAqpCjy+nXt1wJ
 jIqtNE9RTwFbk8CPwVQIcA6SEZIdb2M/rmegtSX4ZngyOCgwJQKRKY0GXdZoNIyAL/DdXCs4DSw
 1o8HQEMQJhnSiaBAvDjAtc5MQJ/+QQhCvTbbPW1+QRMQD2exEh32BLYcy/s1hRDgg8srPqRtqXc
 3AM9uFG7tiKUP6qMyDqu5UJ4YCBYw4lqSrcO/8obt0YmA59H8zhvxuCFhNnERCtQDYCSYCWP4C8
 omTw+LsJqwH9lvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

The QIONetListener mutex is initialized in the convenience
constructor qio_net_listener_new() rather than in an instance_init.
This means a bare object_new(TYPE_QIO_NET_LISTENER) produces an
object with an uninitialized mutex, but instance_finalize
unconditionally calls qemu_mutex_destroy() on it, which aborts.

Move the mutex initialization to a proper instance_init so that init
and finalize are always paired regardless of how the object is
created.

This patch is just added for completeness, but "qio: Fix
qom-list-properties crash on net listener object" from Peter Xu is
basically the same.

Fixes: 9d86181874a ("qio: Protect NetListener callback with mutex")
Cc: peterx@redhat.com
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 io/net-listener.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/io/net-listener.c b/io/net-listener.c
index 9410d72da9c..1fd0f6cb5ab 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -38,7 +38,6 @@ QIONetListener *qio_net_listener_new(void)
     QIONetListener *listener;
 
     listener = QIO_NET_LISTENER(object_new(TYPE_QIO_NET_LISTENER));
-    qemu_mutex_init(&listener->lock);
     return listener;
 }
 
@@ -440,6 +439,13 @@ qio_net_listener_get_local_address(QIONetListener *listener, size_t n,
     return qio_channel_socket_get_local_address(sioc, errp);
 }
 
+static void qio_net_listener_instance_init(Object *obj)
+{
+    QIONetListener *listener = QIO_NET_LISTENER(obj);
+
+    qemu_mutex_init(&listener->lock);
+}
+
 static void qio_net_listener_finalize(Object *obj)
 {
     QIONetListener *listener = QIO_NET_LISTENER(obj);
@@ -463,6 +469,7 @@ static const TypeInfo qio_net_listener_info = {
     .parent = TYPE_OBJECT,
     .name = TYPE_QIO_NET_LISTENER,
     .instance_size = sizeof(QIONetListener),
+    .instance_init = qio_net_listener_instance_init,
     .instance_finalize = qio_net_listener_finalize,
 };
 

-- 
2.53.0


