Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0F2CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXI-0004sy-IT; Tue, 13 Oct 2026 09:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVR-000306-OG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVP-0004pH-TU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4w2kqN7nKI9H0x1oFus4fQv43AF/ZYiSq3XXENoMVM=;
 b=BYkXwWKkeuCrQfNMP70gAJcyqFGoKV1BY1G2UQBBS8E3V1b2CuoPR+0ZQxipILPVd2V0qc
 M3i3ozfuSeIxgwPjcrMYmKVcYLTQuA2OD/RwX454qAcKSbJEHzLg5L3xXhe4aboBBcgdv0
 m3SRqD6yMgUlFS+75zvpAuxMBIztXDU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-W7Wi0Nb1NASzGUnhmh-4Qw-1; Tue,
 13 Oct 2026 13:25:19 +0000
X-MC-Unique: W7Wi0Nb1NASzGUnhmh-4Qw-1
X-Mimecast-MFC-AGG-ID: W7Wi0Nb1NASzGUnhmh-4Qw_1791897918
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D76919772FC; Tue, 13 Oct 2026 13:25:18 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A51EE195604B; Tue, 13 Oct 2026 13:25:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:29 +0400
Subject: [GIT PULL 32/40] ui/console: use QLIST_FOREACH_SAFE in dpy_refresh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-32-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9bxm+kt5qevzLrrv6OvoaryWOzc/XGE2Oz2Y464xhS4=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGrOMMSiJjvejeSA8FqWOhCP2bWf/jaZ8QDQRlhUNIo5rX8Jg
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqzjDEAAoJENro4Ql1lpzlBbsP/igq
 4U3ExxQU6a6dmN1upGAQncbouZ3JpH73MGAWH/rMGv2yDEWcp0CtASlkCsL8zZrSlss033/QGNX
 rkufZ5G/m2RXw32kGMGqQD4DYKxBM3Mr2E+sf0KzESkIXfM9HWx+UmC61Vry5iW/VJtgzy6lnbI
 wwIL7zWCChXKyQv/iR7AphQWHavsXEDxAJTkcCoQtT8lZgkkyvh57SVyblHDjH1k8ulBqrwEfEt
 6U7NguOMvrXRtQq+TlefRVZzzJPCGODJAfDFYNVQJ33nlLvG7fFng7M6k5w2uK5t4KfMvSpkD2L
 kH8WL3FeOJwItASygz7gfBo/jw7ortOycWXnDG3j4InjH8vOUQPqgncLDKk3hEjitvB9hwaAz5D
 L5ysDSEMdqpuTlXc9epyLRIUvR65EJhxjIVlRbaR2Jeks6ml0+xqNtNNsgsvN944bHyAmevW0Ho
 cl0dclVsxKFyGcA5BPkTVSuuCFZ0nDdVCVNVXhpyJk/eD+NHC1W8LQpdid0k2bmLvV9srRDZG1A
 2tDDbCKljBHCedhQig4dNvF4XZCGPp9Sx1nT6XzPpWO81m9lojY8scX1xVEOyjWVK2OXstSMriy
 Uzdzpcg8E7WEnPyDPTz+UR+hMVKuj51783RdjTI8Sq1GS/NdAC/F39fo6jFTvQEB4y5oUWkCkCD
 L1rxu
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

A display listener's dpy_refresh callback could potentially unregister
itself from the listener list, which would invalidate the iteration
pointer. Switch to QLIST_FOREACH_SAFE to allow safe removal during
traversal.

Reported-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-15-ccbef537cbeb@redhat.com>
---
 ui/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 795c9857de82..b7357172007e 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -828,9 +828,9 @@ bool qemu_console_check_format(QemuConsole *con,
 
 static void dpy_refresh(DisplayState *s)
 {
-    DisplayChangeListener *dcl;
+    DisplayChangeListener *dcl, *next_dcl;
 
-    QLIST_FOREACH(dcl, &s->listeners, next) {
+    QLIST_FOREACH_SAFE(dcl, &s->listeners, next, next_dcl) {
         if (dcl->ops->dpy_refresh) {
             dcl->ops->dpy_refresh(dcl);
         }

-- 
2.56.0.116.g6de20f6092dc


