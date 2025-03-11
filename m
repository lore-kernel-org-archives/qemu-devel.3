Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF381C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts231-0004ZY-2b; Tue, 11 Mar 2025 12:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts21e-0003S5-Gn
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts21b-0005aF-2M
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGNnlMv41hT3Kd3yKEMsx9Cgz6Xb69s2bh36zUad/hU=;
 b=HISSYq4drQIH/+7FOq//0FNDwPmOiaVU9eN1Cq7tUIcco7RdRTjsSlDnZhLemKMYq20MB2
 ekTGqwDPsEmTbghoVuPgNq4FFm4VfFUmJoO0d8Rh9sv2+viPgW0QtNHo3/4flmU6QxUbZJ
 YDtgAVYM5Op0YAHOeMcdGmAieFOZkow=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-FHBKeHQ3ODmQH9H6gACc3g-1; Tue,
 11 Mar 2025 12:00:06 -0400
X-MC-Unique: FHBKeHQ3ODmQH9H6gACc3g-1
X-Mimecast-MFC-AGG-ID: FHBKeHQ3ODmQH9H6gACc3g_1741708805
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9040195608F
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:00:05 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A7A11801747; Tue, 11 Mar 2025 16:00:02 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-10.1 03/10] ui/clipboard: split out QemuClipboardContent
Date: Tue, 11 Mar 2025 19:59:25 +0400
Message-ID: <20250311155932.1472092-4-marcandre.lureau@redhat.com>
In-Reply-To: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Allows to use VMSTATE STRUCT in following migration support patch.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
2.47.0


