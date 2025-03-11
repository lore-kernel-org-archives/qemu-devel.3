Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504A3C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts28x-0002eM-H6; Tue, 11 Mar 2025 12:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts22H-00046v-Gz
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts22F-0005jz-Ff
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZPpGI81j++snYsw6LbhCm/alkStFwshXp6ZyPjgkUs=;
 b=FLbnTSQbNI3TjafXuB0hrpA8zHCBuRdaPB/y1XrQop2++5/PU3gJkH6h+MDpoecoKf2utm
 TV5KLx0jiP0vEJO+aVj9MC+84sFz+sTMtRe+jdG9Loea7WrXgxgX8GRPzAeRTa3CD7MCNj
 NUKGBYqqUhbXTKQIN69zUI+4RPz/2Hk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-Korm2aBePAeNgd6zyKpnBA-1; Tue,
 11 Mar 2025 12:00:46 -0400
X-MC-Unique: Korm2aBePAeNgd6zyKpnBA-1
X-Mimecast-MFC-AGG-ID: Korm2aBePAeNgd6zyKpnBA_1741708845
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67E83180AF65
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:00:45 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D92A18001E9; Tue, 11 Mar 2025 16:00:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-10.1 08/10] ui/vdagent: factor out clipboard peer
 registration
Date: Tue, 11 Mar 2025 19:59:30 +0400
Message-ID: <20250311155932.1472092-9-marcandre.lureau@redhat.com>
In-Reply-To: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This allows common code reuse during migration.

Note that resetting the serial is now done regardless if the clipboard
peer was registered or not. This should still be correct.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vdagent.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 011a9057ee..125c659af7 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -694,6 +694,18 @@ static void vdagent_chr_open(Chardev *chr,
     *be_opened = true;
 }
 
+static void vdagent_clipboard_peer_register(VDAgentChardev *vd)
+{
+    if (vd->cbpeer.notifier.notify != NULL) {
+        return;
+    }
+
+    vd->cbpeer.name = "vdagent";
+    vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
+    vd->cbpeer.request = vdagent_clipboard_request;
+    qemu_clipboard_peer_register(&vd->cbpeer);
+}
+
 static void vdagent_chr_recv_caps(VDAgentChardev *vd, VDAgentMessage *msg)
 {
     VDAgentAnnounceCapabilities *caps = (void *)msg->data;
@@ -720,13 +732,9 @@ static void vdagent_chr_recv_caps(VDAgentChardev *vd, VDAgentMessage *msg)
 
     memset(vd->last_serial, 0, sizeof(vd->last_serial));
 
-    if (have_clipboard(vd) && vd->cbpeer.notifier.notify == NULL) {
+    if (have_clipboard(vd)) {
         qemu_clipboard_reset_serial();
-
-        vd->cbpeer.name = "vdagent";
-        vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
-        vd->cbpeer.request = vdagent_clipboard_request;
-        qemu_clipboard_peer_register(&vd->cbpeer);
+        vdagent_clipboard_peer_register(vd);
     }
 }
 
-- 
2.47.0


