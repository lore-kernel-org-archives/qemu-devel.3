Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4187FC54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsmV-000842-64; Sat, 24 May 2025 13:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmT-000829-M6
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmR-0000hb-QX
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcU2UzgUgmjGurT+mbQ0JWX31VSR3k8SI1q4CZDrBIg=;
 b=cIASB00bO/kcE0qCwDWQ17p0xN/sLp8NW6VMs5FCUwRH7/wt6OQ1HsuEg3UCnP7cijbrRO
 728tpPaeHF9u6JuVH2Q9es9CByUKh1TfOSCx8PSh45ELug4IxA946kXu6NCN/1ZDZiM2Cy
 EoWMnRuHz5SJJbaYD6pwDfzcGvnE7tU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-f546gCtzMVWezvXWshJS3w-1; Sat,
 24 May 2025 13:35:29 -0400
X-MC-Unique: f546gCtzMVWezvXWshJS3w-1
X-Mimecast-MFC-AGG-ID: f546gCtzMVWezvXWshJS3w_1748108128
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D3A11800446
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 17:35:28 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6381719560AB; Sat, 24 May 2025 17:35:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com
Subject: [PULL 03/19] ui/clipboard: split out QemuClipboardContent
Date: Sat, 24 May 2025 19:34:56 +0200
Message-ID: <20250524173514.317886-4-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124;
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

Allows to use VMSTATE STRUCT in following migration support patch.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/ui/clipboard.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 14b6099e73..88cfff91ef 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -25,6 +25,7 @@ typedef enum QemuClipboardSelection QemuClipboardSelection;
 typedef struct QemuClipboardPeer QemuClipboardPeer;
 typedef struct QemuClipboardNotify QemuClipboardNotify;
 typedef struct QemuClipboardInfo QemuClipboardInfo;
+typedef struct QemuClipboardContent QemuClipboardContent;
 
 /**
  * enum QemuClipboardType
@@ -97,6 +98,24 @@ struct QemuClipboardNotify {
     };
 };
 
+
+/**
+ * struct QemuClipboardContent
+ *
+ * @available: whether the data is available
+ * @requested: whether the data was requested
+ * @size: the size of the @data
+ * @data: the clipboard data
+ *
+ * Clipboard content.
+ */
+struct QemuClipboardContent {
+    bool available;
+    bool requested;
+    uint32_t size;
+    void *data;
+};
+
 /**
  * struct QemuClipboardInfo
  *
@@ -115,12 +134,7 @@ struct QemuClipboardInfo {
     int selection; /* QemuClipboardSelection */
     bool has_serial;
     uint32_t serial;
-    struct {
-        bool available;
-        bool requested;
-        size_t size;
-        void *data;
-    } types[QEMU_CLIPBOARD_TYPE__COUNT];
+    QemuClipboardContent types[QEMU_CLIPBOARD_TYPE__COUNT];
 };
 
 /**
-- 
2.49.0


