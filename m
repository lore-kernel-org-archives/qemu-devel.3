Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B398C44521
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlirU-0003ee-JT; Mon, 20 Jul 2026 03:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlirT-0003e2-7f
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlirR-0006kL-S3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784534185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QTOvl8AY8NN1PStmYWdJeZDvzMfZigdv0pXiWXClfA=;
 b=H4jciwD9x26wAq8zFhGgeBT020uLXcy1HRsGXK/3bY7bfcUDKhwmyUAld70beK9+SYgDvP
 pLWyN3gPhoUrx+4y7e5AgFab/9uNp0Da9938pikSrblLmaz+WJkBlnlXSnWdwYIhZbix2V
 DUPX8zFhFk3peLsmLZt0UPrJGLOqibg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-z8nqN9IpM2Kmb4j07aKHRg-1; Mon,
 20 Jul 2026 03:56:21 -0400
X-MC-Unique: z8nqN9IpM2Kmb4j07aKHRg-1
X-Mimecast-MFC-AGG-ID: z8nqN9IpM2Kmb4j07aKHRg_1784534179
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FE43195C267; Mon, 20 Jul 2026 07:56:19 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 906E930002D6; Mon, 20 Jul 2026 07:56:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Jul 2026 11:55:32 +0400
Subject: [PATCH 3/8] io: add missing coroutine annotation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-co-v1-3-fabb4db3c204@redhat.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
In-Reply-To: <20260720-co-v1-0-fabb4db3c204@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0uczZ0FGO8LAP5viyGHp+/jxtNxL630HdwYtMufZx5w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqXdSJR+JAKejvppC4K18+1jyEdnxLV+7l5FH4d
 bj0E9E18KWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCal3UiQAKCRDa6OEJdZac
 5SpTD/sEFsZvOhVNETpyJacq1WDjsQwhdf6vVRDTle6EPuCTnI0qNdl+pJJuAjRq4OXzlExwWkw
 38rosD1s5i54gl1cfM7H84MjiRUM9o7BwCenABwGJ2G8aQ2rh0oPRyhp6wezlsB3aNdi515bqln
 NhVNh+DxLRNf7aszVouX1zTNvEC0I1RX2dcUAwq/dIMPZeccIpIzoxX44GomuVjE3mcNNmioBCL
 oJGmog+loSSa/zDjEGkBsAvohWF+1wGArD5cACn2Ylkp7zZ032f7dK9fyqtv86R0/VfYAZX2LHn
 TvN5BGICiE3ZBOyaZGWuJ0lwL5jqDTh41ajF8a/tNkfvY3mG7Xjyc+Js0L9/uXUKfeN2I1nWBvG
 9Cv9acyi4lp0swyUgdtDLAxsWuKI6es1t7Bx8LNm4w+JretscHcwO3lHOzUkWdMBd01RAq9SGz2
 NSjZUG/OtlIEtKeb5tBr7GXrUDNb8hoxaGI6yy6M2Yf0OyTYYMVmbu8baeWI8VH4FwL7syDmyk9
 w2OgH+Pqm0mFiOFbw63hF944tNW96l6qrPIo6bfcJTFK8jWo6S6nW+s0sORab94LTXqG7rQaB9b
 hSCbNoXPe949y+hV67xrIJ/bqFXFGkVvGPzDbbZ+VmGVkbuEqdbV8SzLFvtNdjDQXuSs8rloSGM
 MZKUhjzwKJNzReQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/io/channel.h | 4 ++--
 io/channel.c         | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 98485c9280a..c90ace20d53 100644
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
index 2853dadb684..620256f310d 100644
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


