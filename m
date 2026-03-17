Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D884EF3381C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QDw-0004bg-5T; Tue, 17 Mar 2026 04:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCG-0001Uw-3B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCC-0006n0-0b
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkEYT5wpR4Ys9ytN70/AlMugRB4ENeg9RxZzymCS7rM=;
 b=Sbn0Z9mdKZG8r9wWKGNoDjfNX5YuyUF2z/iaiV28hO/RFFVLt5f9w8m+qYMSoUGvZTcxEu
 Bol+WaSi4Eyr3WHV4Bs6+4/5l+5Q53Q9R9P1Lgna2F9FvzR5JWOuOYtU5qo2frlzS+SuJM
 7E8XVyBuYmltXDiUVa270qutnuByAIg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-8JziJq1gOtGQB4iFWgIoPw-1; Tue,
 17 Mar 2026 04:54:33 -0400
X-MC-Unique: 8JziJq1gOtGQB4iFWgIoPw-1
X-Mimecast-MFC-AGG-ID: 8JziJq1gOtGQB4iFWgIoPw_1773737672
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCFAF1800365
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C909919560AB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:54 +0400
Subject: [PATCH 40/60] ui: minor code simplification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-40-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Q0M7GWnDFRrF6HdZ6kHjqcXeOxYXVszPB8J9MyF5eo8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXcCVuv4mctGMkLPRFiStHPdIGAyvvbd8SLn
 +aIGKX7qV2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5QtYD/9okE700t4zcWeJJvCjjHeAuSD88ABb8KddFilJYKoz3u2OKKzk16G/raQmhrbi49z8o5h
 lNV3RlHf0WrVeW3pKcmfo0nUuHAGgULgHJisiBJnq5kA0XN/iKASenIwCzatDEU5dI35X5KnUOx
 HKH4Cg36IR0Oi9OQwyuKG1oEuXIDYiE1aLfdluTK0cjqGuuuVgAAD+U+qGnmDsYpGRYfrgA9evf
 /q1OMmr8nAfcaDQocfztMdaHzkMSFsxp1zcXjGJAQWU6ndFUmRLXpPog47WjAS0+4HqfjkOcAaW
 pnbkXMdN70x/PuPXtNlb95lflhcF48GfV8csz2lQMbVy/sCb46k9oNR1PKKwOdsreL9fT/CPLwf
 E8FKMpx5DRQPFQJadDvI/SmkOEdlAbb3Y6ChtBY0HStfV/rlMRL4UX/EYeS3D1HuFTer7Cdfkie
 /2Y9SLjnOgzyZ5bThExZutzM2PpJl4PsJVqtCkqlqz5Tm6j+rqOns8BlV14fhliT4Rxm99rZHjk
 3JnAh0frZ/B9lOjW+eGe0uq0JZbHYAJO6YNhpuOaKpItN3NtqIJliyQpQzKxAfas1Iu1+xUzvjc
 CgRiZqfQ0BidyQ1KZwTUHj7FEO3EImZVWvykkQr56DXSa+RmAvwLQR23gD10XMqw/VXng+XZaBZ
 0keVaa7QMz6uFFg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Remove the extra "info" variable and its initialization.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/sdl2.c | 10 +++++-----
 ui/vnc.c  |  7 ++-----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index aaaede56e0e..3ffb8acaff8 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -600,11 +600,11 @@ static void handle_windowevent(SDL_Event *ev)
     switch (ev->window.event) {
     case SDL_WINDOWEVENT_RESIZED:
         {
-            QemuUIInfo info;
-            memset(&info, 0, sizeof(info));
-            info.width = ev->window.data1;
-            info.height = ev->window.data2;
-            dpy_set_ui_info(scon->dcl.con, &info, true);
+            dpy_set_ui_info(scon->dcl.con,
+                &(QemuUIInfo) {
+                    .width = ev->window.data1,
+                    .height = ev->window.data2,
+                }, true);
         }
         sdl2_redraw(scon);
         break;
diff --git a/ui/vnc.c b/ui/vnc.c
index 4aa446a48d7..87ec3e6d799 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2638,11 +2638,8 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
 
         trace_vnc_msg_client_set_desktop_size(vs, vs->ioc, w, h, screens);
         if (dpy_ui_info_supported(vs->vd->dcl.con)) {
-            QemuUIInfo info;
-            memset(&info, 0, sizeof(info));
-            info.width = w;
-            info.height = h;
-            dpy_set_ui_info(vs->vd->dcl.con, &info, false);
+            dpy_set_ui_info(vs->vd->dcl.con,
+                &(QemuUIInfo){ .width = w, .height = h }, false);
             vnc_desktop_resize_ext(vs, 4 /* Request forwarded */);
         } else {
             vnc_desktop_resize_ext(vs, 3 /* Invalid screen layout */);

-- 
2.53.0


