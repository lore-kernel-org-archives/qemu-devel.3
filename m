Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4192EC53219
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnZ0U-0000fq-Si; Sat, 25 Jul 2026 05:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0F-0000dr-GU
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0D-0004Tq-6j
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784972944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=om5CIye3i6lrnEkPPfiq+UulgaM6eC6H/1XHPK2zRuA=;
 b=Kitw1uPwupgTTphcYwpi53xO6uRP74/xirhLgZ//Xv22tJ1Wkrxta2PzxIZxTC1nfzFFYc
 dguKspLgH5+mEPHKPArkj/lKfm/5pT9nd8XwSF4ayzcBwVPHTkHfwtiJmQVUGOXg6Tig/0
 V/aLLp0rxwXnHMCPYSMplUVpparv0J4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-8qtqlocdObSmloqw3eCJ0w-1; Sat,
 25 Jul 2026 05:49:01 -0400
X-MC-Unique: 8qtqlocdObSmloqw3eCJ0w-1
X-Mimecast-MFC-AGG-ID: 8qtqlocdObSmloqw3eCJ0w_1784972939
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9624B1800C35; Sat, 25 Jul 2026 09:48:58 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0837E15AD; Sat, 25 Jul 2026 09:48:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 13:48:34 +0400
Subject: [PATCH v2 3/8] io: add missing coroutine annotation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-co-v2-3-d3552ddb3931@redhat.com>
References: <20260725-co-v2-0-d3552ddb3931@redhat.com>
In-Reply-To: <20260725-co-v2-0-d3552ddb3931@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hhK3avKdImCgAXvIB7NvRmE1p7D0COK7cwqKnWNle/g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZIZzeDY3v/u02EPWgKg8h2Y9qqMbxC8tbSZol
 9UFxg2JA6uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamSGcwAKCRDa6OEJdZac
 5W9FEACkxbRuybsgqPhJFHRnyhXpFxZMy1BAcH9DcOHSozjWSSJYfgx5mkUyJlAbcOTwlJaKt/P
 goJB5UinVDym73+x4ZLqQcaLfe4+Qsz9X58MyAVlc/xRwKrK/oQTONTXjBHZ0L8dlKVohTUwwlY
 NjyeKe/UZ0T/hXnLniERWlQujHe7UrBUqRTaq5166SsYU5fpF8hQ+IexJHTDEuGEPBtp1BkccU0
 Kk660LTATwk4GWKKxgie5DK6ZdmfThGclqIWhrqawLAAmAR0jvDt/ZhK3c5H+hvsOTwWoY2BbuY
 X4k2NyX/ePC45gBMuY+PaqQxflVaj27p9fjhNKMTdkVIPMv2DENrL8A/oyubDt/ovY+Dc9OT5z0
 9BwLOQITCf4RjXQ+Ipz1C18tx6WbS3rF0zepzqzi2brZbgGXgyAl+ZqEvYwqf34MryBUNxn+GDf
 z6onnYQYYWoksNmYaxC3UlO64Ix0jkZ6kNhn4C2S4cv4JRnBIG+isbEM7yuww31MgtzmP1rrAgV
 A3FUUZ4MqLqMvCRKxnz0UTdduLlZD1ugwQj2XNeS9Q+i4L579CFAE3mSocap6EvglQlxo8Aty6x
 kSmtLTyMbTMCYazOXfesBncXAAj7sXDGZSmMUs4xKEjI0dz6frEKpFUwqwjj2DKMpqVHxf8XW0K
 qlcmZvYuZkm9liQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fixes: 1edf0df28409 ("io: Add qio_channel_wait_cond() helper")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/io/channel.h | 4 ++--
 io/channel.c         | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 98485c9280a6..c90ace20d535 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -1016,8 +1016,8 @@ void qio_channel_wait(QIOChannel *ioc,
  * This will work with/without a coroutine context, by automatically select
  * the proper API to wait.
  */
-void qio_channel_wait_cond(QIOChannel *ioc,
-                           GIOCondition condition);
+void coroutine_mixed_fn qio_channel_wait_cond(QIOChannel *ioc,
+                        GIOCondition condition);
 
 /**
  * qio_channel_set_aio_fd_handler:
diff --git a/io/channel.c b/io/channel.c
index 2853dadb684e..620256f310db 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -905,8 +905,9 @@ void qio_channel_wait(QIOChannel *ioc,
     g_main_context_unref(ctxt);
 }
 
-void qio_channel_wait_cond(QIOChannel *ioc,
-                           GIOCondition condition)
+void coroutine_mixed_fn
+qio_channel_wait_cond(QIOChannel *ioc,
+                      GIOCondition condition)
 {
     if (qemu_in_coroutine()) {
         qio_channel_yield(ioc, condition);

-- 
2.55.0


