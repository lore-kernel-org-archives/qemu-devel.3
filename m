Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585B6C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsmb-000863-7W; Sat, 24 May 2025 13:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmX-00085H-Fy
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmU-0000hp-JU
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZuFyNddtzdEXCgFSA8r/ddPt7P6cIbBy3sqMuqzbVo=;
 b=bKZJ2pNwcBwX1V0mXPaJaNjIkIXozS6GiFKKSf3s2xtGpN8sddbLkxBEQ+6RBww//ZbLMO
 r6skcSZB2vtsLtdlNIIzzq9N5C3g95CDJxh7fGEIcbjSdPwbp3q619JhEw6LLkwNlZnt0g
 XlmANWr1J4zYEhSReyUy2qVnRQhY618=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-NXYsMlOEN_eqfVGEN-C9-w-1; Sat,
 24 May 2025 13:35:32 -0400
X-MC-Unique: NXYsMlOEN_eqfVGEN-C9-w-1
X-Mimecast-MFC-AGG-ID: NXYsMlOEN_eqfVGEN-C9-w_1748108131
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86B32195608A
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 17:35:31 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76ADF195608D; Sat, 24 May 2025 17:35:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com
Subject: [PULL 04/19] ui/clipboard: add vmstate_cbinfo
Date: Sat, 24 May 2025 19:34:57 +0200
Message-ID: <20250524173514.317886-5-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Add a VMStateDescriptor for QemuClipboardInfo.

Each clipboard owner will have to save its QemuClipboardInfo and
reregister its owned clipboard after loading. (the global cbinfo has
only pointers to owners, so it can't restore the relation with its owner
if it was to handle migration)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/ui/clipboard.h |  3 +++
 ui/clipboard.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 88cfff91ef..62a96ce9ff 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -2,6 +2,7 @@
 #define QEMU_CLIPBOARD_H
 
 #include "qemu/notify.h"
+#include "migration/vmstate.h"
 
 /**
  * DOC: Introduction
@@ -27,6 +28,8 @@ typedef struct QemuClipboardNotify QemuClipboardNotify;
 typedef struct QemuClipboardInfo QemuClipboardInfo;
 typedef struct QemuClipboardContent QemuClipboardContent;
 
+extern const VMStateDescription vmstate_cbinfo;
+
 /**
  * enum QemuClipboardType
  *
diff --git a/ui/clipboard.c b/ui/clipboard.c
index 132086eb13..f5db60c63d 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -7,6 +7,32 @@ static NotifierList clipboard_notifiers =
 
 static QemuClipboardInfo *cbinfo[QEMU_CLIPBOARD_SELECTION__COUNT];
 
+static const VMStateDescription vmstate_cbcontent = {
+    .name = "clipboard/content",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(available, QemuClipboardContent),
+        VMSTATE_BOOL(requested, QemuClipboardContent),
+        VMSTATE_UINT32(size, QemuClipboardContent),
+        VMSTATE_VBUFFER_ALLOC_UINT32(data, QemuClipboardContent, 0, 0, size),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_cbinfo = {
+    .name = "clipboard",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(selection, QemuClipboardInfo),
+        VMSTATE_BOOL(has_serial, QemuClipboardInfo),
+        VMSTATE_UINT32(serial, QemuClipboardInfo),
+        VMSTATE_STRUCT_ARRAY(types, QemuClipboardInfo, QEMU_CLIPBOARD_TYPE__COUNT, 0, vmstate_cbcontent, QemuClipboardContent),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
 {
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
-- 
2.49.0


