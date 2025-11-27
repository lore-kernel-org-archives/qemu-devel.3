Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBADD116F3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 09:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOYCK-0000zp-TY; Thu, 27 Nov 2025 04:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOYCH-0000xv-Ai
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 04:21:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOYCE-00044r-NR
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 04:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764235309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTY2f6HX0TY+PLfvubNL872HBK9do9hCRqshlxstT+Y=;
 b=C8AYnrKqyIX0tN2P7xRh15ysfZ87TE/eq/W4xIXoLBICxMxJmct0czdtSCbWzOXwYj7/Q+
 96h241AT1Eus1Dg4MNvKxONfkFXMYqYpyUHkOezIC9/Y654CiqO02uaZZWfoOKbo0edRrR
 ON8nN81x3GFiOqj8r5yVGCS95LSkriA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-0DQzy2IfOBm9TWsXdGtJoQ-1; Thu,
 27 Nov 2025 04:21:46 -0500
X-MC-Unique: 0DQzy2IfOBm9TWsXdGtJoQ-1
X-Mimecast-MFC-AGG-ID: 0DQzy2IfOBm9TWsXdGtJoQ_1764235305
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27885180034D; Thu, 27 Nov 2025 09:21:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.104])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9043A180047F; Thu, 27 Nov 2025 09:21:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1F6AB18009BA; Thu, 27 Nov 2025 10:21:42 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] move pcap structs to header file
Date: Thu, 27 Nov 2025 10:21:40 +0100
Message-ID: <20251127092142.204471-2-kraxel@redhat.com>
In-Reply-To: <20251127092142.204471-1-kraxel@redhat.com>
References: <20251127092142.204471-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Allow reusing them elsewhere in qemu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/pcap.h | 30 ++++++++++++++++++++++++++++++
 hw/usb/pcap.c       | 24 +-----------------------
 2 files changed, 31 insertions(+), 23 deletions(-)
 create mode 100644 include/qemu/pcap.h

diff --git a/include/qemu/pcap.h b/include/qemu/pcap.h
new file mode 100644
index 000000000000..05aba83c15be
--- /dev/null
+++ b/include/qemu/pcap.h
@@ -0,0 +1,30 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_PCAP_H
+#define QEMU_PCAP_H
+
+#define PCAP_MAGIC                   0xa1b2c3d4
+#define PCAP_MAJOR                   2
+#define PCAP_MINOR                   4
+
+/* https://wiki.wireshark.org/Development/LibpcapFileFormat */
+
+struct pcap_hdr {
+    uint32_t magic_number;   /* magic number */
+    uint16_t version_major;  /* major version number */
+    uint16_t version_minor;  /* minor version number */
+    int32_t  thiszone;       /* GMT to local correction */
+    uint32_t sigfigs;        /* accuracy of timestamps */
+    uint32_t snaplen;        /* max length of captured packets, in octets */
+    uint32_t network;        /* data link type */
+};
+
+struct pcaprec_hdr {
+    uint32_t ts_sec;         /* timestamp seconds */
+    uint32_t ts_usec;        /* timestamp microseconds */
+    uint32_t incl_len;       /* number of octets of packet saved in file */
+    uint32_t orig_len;       /* actual length of packet */
+};
+
+#endif /* QEMU_PCAP_H */
diff --git a/hw/usb/pcap.c b/hw/usb/pcap.c
index dbff00be252e..10ca6279f7d3 100644
--- a/hw/usb/pcap.c
+++ b/hw/usb/pcap.c
@@ -8,31 +8,9 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/pcap.h"
 #include "hw/usb.h"
 
-#define PCAP_MAGIC                   0xa1b2c3d4
-#define PCAP_MAJOR                   2
-#define PCAP_MINOR                   4
-
-/* https://wiki.wireshark.org/Development/LibpcapFileFormat */
-
-struct pcap_hdr {
-    uint32_t magic_number;   /* magic number */
-    uint16_t version_major;  /* major version number */
-    uint16_t version_minor;  /* minor version number */
-    int32_t  thiszone;       /* GMT to local correction */
-    uint32_t sigfigs;        /* accuracy of timestamps */
-    uint32_t snaplen;        /* max length of captured packets, in octets */
-    uint32_t network;        /* data link type */
-};
-
-struct pcaprec_hdr {
-    uint32_t ts_sec;         /* timestamp seconds */
-    uint32_t ts_usec;        /* timestamp microseconds */
-    uint32_t incl_len;       /* number of octets of packet saved in file */
-    uint32_t orig_len;       /* actual length of packet */
-};
-
 /* https://www.tcpdump.org/linktypes.html */
 /* linux: Documentation/usb/usbmon.rst */
 /* linux: drivers/usb/mon/mon_bin.c */
-- 
2.52.0


