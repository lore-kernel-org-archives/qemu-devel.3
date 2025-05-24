Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61474C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsmu-0008Ul-Uk; Sat, 24 May 2025 13:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmm-0008Ee-4q
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmj-0000jN-St
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rJw3QVQTA9bB0if4ANHAV4qW4nScS/fUz8P5Ca7OuI=;
 b=Wpy1DQ45SP5ReY5XNAaWF2JOj1XHL4BE/5uTe0u5YhWq0T25OjS4nmLenrDV0jwnD4rZ9J
 Tl10dDUmMw1jxmz2gwv0tsk50ylcryka5xvepXubQKrKcT1BX1+vaY3Fh6mWWIEGuMLcFl
 6dkbXttzIGVSSG9jZ4V3TweVczoOcr0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-eOUfVA_pPIqTids8NT6NEA-1; Sat,
 24 May 2025 13:35:46 -0400
X-MC-Unique: eOUfVA_pPIqTids8NT6NEA-1
X-Mimecast-MFC-AGG-ID: eOUfVA_pPIqTids8NT6NEA_1748108145
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BE9E1800361
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 17:35:45 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B5AF19560AB; Sat, 24 May 2025 17:35:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com
Subject: [PULL 08/19] ui/vdagent: factor out clipboard peer registration
Date: Sat, 24 May 2025 19:35:01 +0200
Message-ID: <20250524173514.317886-9-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vdagent.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 210b8c14ca..fcbd7b167b 100644
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
2.49.0


