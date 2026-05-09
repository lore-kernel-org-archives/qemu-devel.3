Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6E5CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcGw-0001Sp-Ci; Sat, 09 May 2026 03:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcGu-0001Hk-Ki
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcGt-0007R7-7c
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4N3hQj9EjQUIZF134aiZJrF9XMeohYQd/6PSpXWb5D8=;
 b=Wvc9Bx2rkJxih80TCcXNLYQVHb3KQdOBpa5L9q6a4UID5ccGNpqzwrX4BBYqwkwfQ8fkLH
 RAA/w09LvZgwFv+xWSKK65tTZRpEtWhv/DQ34st0HW0EJl2sTRkLI5boULbGU7lNmt/Lkh
 0a7DkMCIjb0oCtOpGHYNac8Mcawv4Ko=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-zWOr4QtXP6CwMPr6Xok5aQ-1; Sat,
 09 May 2026 03:38:44 -0400
X-MC-Unique: zWOr4QtXP6CwMPr6Xok5aQ-1
X-Mimecast-MFC-AGG-ID: zWOr4QtXP6CwMPr6Xok5aQ_1778312323
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D250C1956088; Sat,  9 May 2026 07:38:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79E3B180075C; Sat,  9 May 2026 07:38:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 24/32] ui/vnc: defer listener registration until the console is
 known
Date: Sat,  9 May 2026 11:36:10 +0400
Message-ID: <20260509073621.1011778-25-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Previously, the display change listener was registered early in
vnc_display_new() without a console, requiring vnc_display_open() to
conditionally unregister and re-register it when the actual console was
resolved. Since vnc_display_new() and vnc_display_open() were merged in
the previous commit, simply delay the registration and keyboard state
initialization to vnc_display_open(), after the console has been looked
up. This removes the conditional re-registration and simplifies the code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index d65153a5001..ea1579135b8 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3457,8 +3457,6 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
 
     vnc_start_worker_thread(vd);
 
-    register_displaychangelistener(&vd->dcl);
-    vd->kbd = qkbd_state_init(vd->dcl.con);
     vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
         &vmstate_change_handler, vd);
 
@@ -4269,13 +4267,9 @@ static bool vnc_display_open(VncDisplay *vd, Error **errp)
         con = qemu_console_lookup_default();
     }
 
-    if (con != vd->dcl.con) {
-        qkbd_state_free(vd->kbd);
-        unregister_displaychangelistener(&vd->dcl);
-        vd->dcl.con = con;
-        register_displaychangelistener(&vd->dcl);
-        vd->kbd = qkbd_state_init(vd->dcl.con);
-    }
+    vd->dcl.con = con;
+    register_displaychangelistener(&vd->dcl);
+    vd->kbd = qkbd_state_init(vd->dcl.con);
     qkbd_state_set_delay(vd->kbd, key_delay_ms);
 
     if (saddr_list == NULL) {
-- 
2.54.0


