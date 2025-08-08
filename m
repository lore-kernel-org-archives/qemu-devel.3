Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4972C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukI9Y-00079S-2u; Fri, 08 Aug 2025 04:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9U-00073p-BU
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9S-0006U6-Lr
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0a8mAgbX2PYqZidFDUyDRO19lWaXvm1R8I1vvmw2cEs=;
 b=GSiwyBpKPD1vK/wyy4QW80MBzk/OuQdwz5m0Vaxe9SUfX8Wbp+6eyau+aNqWBeVaMtN0bB
 YxoFjo/c5nZZJ0L34BxEz6mqVhSCtT0PgqJ5JbxKz9SqOrTSYyX3UTTLt2rvZYbCyEDLcL
 wydv7JWL1KhjZfn+92Hnj62+CBEYitQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-IXfNtXw6NtCKghThBOYIvQ-1; Fri,
 08 Aug 2025 04:08:30 -0400
X-MC-Unique: IXfNtXw6NtCKghThBOYIvQ-1
X-Mimecast-MFC-AGG-ID: IXfNtXw6NtCKghThBOYIvQ_1754640509
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4EB4180034F; Fri,  8 Aug 2025 08:08:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7241719560B4; Fri,  8 Aug 2025 08:08:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6B35721E66D2; Fri, 08 Aug 2025 10:08:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp,
	marcandre.lureau@redhat.com
Subject: [PATCH 10/12] ui/dbus: Clean up dbus_update_gl_cb() error checking
Date: Fri,  8 Aug 2025 10:08:21 +0200
Message-ID: <20250808080823.2638861-11-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-1-armbru@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From GLib "Rules for use of GError":

    A GError* must be initialized to NULL before passing its address
    to a function that can report errors.

dbus_update_gl_cb() seemingly violates this rule: it passes &err to
qemu_dbus_display1_listener_call_update_dmabuf_finish() and to
qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish()
without clearing it in between.  Harmless, because the first call is
guarded by #ifdef CONFIG_GBM, the second by #ifdef WIN32, and the two
are mutually exclusive.  I think.

Clean this up to be obviously correct.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ui/dbus-listener.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 42875b8eed..09d7a319b1 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -221,18 +221,21 @@ static void dbus_update_gl_cb(GObject *source_object,
 #ifdef CONFIG_GBM
     success = qemu_dbus_display1_listener_call_update_dmabuf_finish(
         ddl->proxy, res, &err);
+    if (!success) {
+        error_report("Failed to call update: %s", err->message);
+    }
 #endif
 
 #ifdef WIN32
     success = qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish(
         ddl->d3d11_proxy, res, &err);
-    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
-#endif
-
     if (!success) {
         error_report("Failed to call update: %s", err->message);
     }
 
+    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
+#endif
+
     graphic_hw_gl_block(ddl->dcl.con, false);
     g_object_unref(ddl);
 }
-- 
2.49.0


