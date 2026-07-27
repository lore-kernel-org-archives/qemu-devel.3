Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369BCC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJtd-0001sO-2f; Mon, 27 Jul 2026 07:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtb-0001oh-Ds
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJta-00040K-0d
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=om5CIye3i6lrnEkPPfiq+UulgaM6eC6H/1XHPK2zRuA=;
 b=iz6zN+ck++oBWCVcXX5omDCZ3hUvwCLXC/BQBFtRFFixDL5HFkhlg2cET+H3dhJ1uGikZ7
 S/uPSwmRahrXUjxUdTw3JAwswshAw4CBvpaIPFcWKXbzwaIDGudCs5o76gCijDunYWRwDe
 hFSLKL7jk2VCbRtaYImFxh2h55//pxY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-3LJ2C3foOMe3je7V0tzn6g-1; Mon,
 27 Jul 2026 07:53:20 -0400
X-MC-Unique: 3LJ2C3foOMe3je7V0tzn6g-1
X-Mimecast-MFC-AGG-ID: 3LJ2C3foOMe3je7V0tzn6g_1785153199
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B75C1800752
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 11:53:19 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F0A0180025F; Mon, 27 Jul 2026 11:53:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:28 +0400
Subject: [GIT PULL 19/23] io: add missing coroutine annotation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-19-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hhK3avKdImCgAXvIB7NvRmE1p7D0COK7cwqKnWNle/g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/67H3Qeq+xFEr3MLAxSAUzdX7aUz96M2Gd
 utN3CvdNHyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5Uq8EAClBIF2YrZQsGXy46Vf/p4AkkSY7A/lU34Qw0uBMaQ6xCpOLO9qQVlkyUPEjg55XY1Ett8
 pA41sZAsf1bgq1cziEX50hRrf0voTNlnXv5tXZiXiK8LsRsnjkCaViQnXGBB27scCs13PE83Pdw
 rNzH0q0AQokpTjuQlhmOzKKR9cwBna/bVl924KBhW00NiWF1bUER47NB7BgCTsnCC17Rh3AwGFR
 TTi6GyLUtpLNXx1mHgJrjgABj7PaIlsQ+rQa0i5q+nkFFS6lye+f7i4QvfCZ2eHEIiVvswXI0nD
 ia/7npQrB70EMLIjaFsom9f86LG4uSSF/Qx9dPS2Cjy5adHH4B6/dzZxlxryswM4kbeyh+Wh8kX
 E6XoWUbv1PhVcZEAxNTysQqqX1Fa1i02JyOPZFAa0gzYN4BQdlwYVt0BHg28Eb75kifN80c4gcV
 FglwiUC4KqYApz9b34WHKxBLaXD2UO8Mxntq9oTzbrvX5r47p3WOGQQJxxBUlumxg4E+JrUDrwy
 9UPFU/8u0MpwhSg7fsRIIahg/YZ7+9JGVk18mh4haP1U+pIoJuyV+5DodPvEDOTJxnG0tiGF9c6
 LQbyC4oul1aC/9uUcTGlw00y337/Zka+IcgkQtkBjKaWtNknFcXr+y9HXxE/YuIST1LFzKaSnda
 f8mDX5dN9NQMwNg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


