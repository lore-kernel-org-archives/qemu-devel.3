Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF3D606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZzMaFjqY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNUKy-0007uY-GY; Sun, 01 Nov 2026 07:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUKu-0007tI-DG
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:06:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUKs-0003YE-Qq
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793534814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkzCoMBne4yhbLodSAeLb+5Jz/ibmp2fQ2re3FGRHR4=;
 b=ZzMaFjqYQJBfuTjpEROz8gXgMQudt/hqU43SYts58oc3LvT/5uPU4WXDDdU6OmiOrImSIR
 LYwSgt2Od6vQJZiVd4ib3YxX5CEJ/AZMt+azrRArL6ZWU2qH5zDWkrpcBx3Eu76NFDUwsf
 mpx6miwdiYlRRtVsWqWHWJ7guWd/4zE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-RAOX55OdM02w2wvHYqKnfA-1; Sun,
 01 Nov 2026 07:06:50 -0500
X-MC-Unique: RAOX55OdM02w2wvHYqKnfA-1
X-Mimecast-MFC-AGG-ID: RAOX55OdM02w2wvHYqKnfA_1793534810
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9B43180AA95; Sun,  1 Nov 2026 12:06:49 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A04571800480; Sun,  1 Nov 2026 12:06:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 01 Nov 2026 16:06:35 +0400
Subject: [GIT PULL 2/9] ui/clipboard: keep track of clipboard peer side
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-ui-v1-2-8af305cef69a@redhat.com>
References: <20261101-ui-v1-0-8af305cef69a@redhat.com>
In-Reply-To: <20261101-ui-v1-0-8af305cef69a@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3785;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bQ4oyJIFVeGiON7gtnbKpjYCBO+L7545FkNw6xUQiQE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ytOVqKikD7vTH5KjKydVVHkvMEM01OkyisIJ
 UsI7ki2nUKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaucrTgAKCRDa6OEJdZac
 5c9CD/98tvfb84g2H37MjsDvHOdsyp5mZJy0UqevvSv8nPcvGnU/EboK+CqiDDE8ilmpEIzgt0o
 nwJ6KZZdQdWepwW41ZFWhlct+T1OEle81soyxX4Z3dsX0q3vVAD66fi6Q+eo/iQCZ05DaG3+jMC
 mhv7wT3uhZpc6CKui3rx7DPOWcK0y//Bo/AOiyYqZziAASgQCkTi7Awj/uX05CzoErk6oXlDdBN
 4nUlU4UOHu1xbIVdZUnXpOLpvToJ/rNsPoUoWcI6Y/HHGcfr0or7oCILwRplT9C4M62/kzuUoU4
 leHbnsmVgv+4s9Ogy1efTXykOrEQT1mtXDfpF5XPiHwzbse2Cc19nlulqUN7NqoXbuovOQzxIrN
 76M7qq+iXCrwfytNXz74oiGSo4qqCXDFKU8V+yQoYuIWC4zEdc9ME6ha1c9kQqR1YufMMrsjpRM
 ANmRa1xfgH10patTH8r6CKRGe/skrpwu+iNfqTfgyar3qYDBet/oyjwCc7z7Jya4QwL5r/FOHh1
 T4ssV3nDQa7qOGJRRFbyKnAZ1pkHr1AtDbTWvwx9RFHf5dlag7v1UGWg/9s1IahpR2L4xFZ85AP
 doc3eZOfwpL58tNPsDXwdkorvU6jwWOOuRtDJw3KcACmNc3buaDyMXMxP6tAp0Wz09h8iuokkdp
 E1I2jiHHCYSMG9g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lukasz Kornicki <lucas.kornicki@nutanix.com>

Add a "guest" flag to QemuClipboardPeer and set it on vdagent peer.

Use the flag to keep track of number of registered guest peers and
allow to query for their presence with
qemu_clipboard_guest_peer_present().

This change makes it possible for a clipboard peer to determine if
any guest side peers are present so they can tell whether a guest is
actually able to participate in clipboard exchange.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261030141442.264308-3-lucas.kornicki@nutanix.com>
---
 include/ui/clipboard.h |  9 +++++++++
 ui/clipboard.c         | 17 +++++++++++++++++
 ui/vdagent.c           |  1 +
 3 files changed, 27 insertions(+)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 6166af513906..250f1d8ea53e 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -62,6 +62,7 @@ enum QemuClipboardSelection {
  * struct QemuClipboardPeer
  *
  * @name: peer name.
+ * @guest: is peer guest side.
  * @notifier: notifier for clipboard updates.
  * @request: callback for clipboard data requests.
  *
@@ -69,6 +70,7 @@ enum QemuClipboardSelection {
  */
 struct QemuClipboardPeer {
     const char *name;
+    bool guest;
     Notifier notifier;
     void (*request)(QemuClipboardInfo *info,
                     QemuClipboardType type);
@@ -179,6 +181,13 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer);
  */
 void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer);
 
+/**
+ * qemu_clipboard_guest_peer_present
+ *
+ * Return TRUE if a guest side clipboard peer is currently registered.
+ */
+bool qemu_clipboard_guest_peer_present(void);
+
 /**
  * qemu_clipboard_peer_owns
  *
diff --git a/ui/clipboard.c b/ui/clipboard.c
index 3d8f58a85508..f750b494eb6b 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -12,6 +12,8 @@ static VMChangeStateEntry *cb_change_state_entry = NULL;
 
 static bool cb_reset_serial_on_resume = false;
 
+static int guest_peer_count;
+
 static const VMStateDescription vmstate_cbcontent = {
     .name = "clipboard/content",
     .version_id = 0,
@@ -80,6 +82,10 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
         cb_change_state_entry = qemu_add_vm_change_state_handler(qemu_clipboard_change_state, NULL);
     }
 
+    if (peer->guest) {
+        guest_peer_count++;
+    }
+
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
     qemu_clipboard_notify_peer_update(peer, true);
 }
@@ -92,6 +98,12 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
+
+    if (peer->guest) {
+        assert(guest_peer_count > 0);
+        guest_peer_count--;
+    }
+
     qemu_clipboard_notify_peer_update(peer, false);
 
     if (QLIST_EMPTY(&clipboard_notifiers.notifiers)) {
@@ -100,6 +112,11 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
     }
 }
 
+bool qemu_clipboard_guest_peer_present(void)
+{
+    return guest_peer_count > 0;
+}
+
 bool qemu_clipboard_peer_owns(QemuClipboardPeer *peer,
                               QemuClipboardSelection selection)
 {
diff --git a/ui/vdagent.c b/ui/vdagent.c
index cc32a94fb9c0..cdd4cedad2c1 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -695,6 +695,7 @@ static void vdagent_clipboard_peer_register(VDAgentChardev *vd)
     }
 
     vd->cbpeer.name = "vdagent";
+    vd->cbpeer.guest = true;
     vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
     vd->cbpeer.request = vdagent_clipboard_request;
     qemu_clipboard_peer_register(&vd->cbpeer);

-- 
2.56.0.116.g6de20f6092dc


