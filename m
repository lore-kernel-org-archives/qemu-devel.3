Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D3DC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 07:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA1p2-0001dj-Fv; Wed, 30 Apr 2025 03:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1uA1oy-0001c8-0a
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:25:32 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1uA1ow-0004EG-5u
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:25:31 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 7C4A41C1125; Wed, 30 Apr 2025 09:25:25 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v5 6/7] h264: add hardware encoders
Date: Wed, 30 Apr 2025 09:25:23 +0200
Message-Id: <20250430072524.3650582-7-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250430072524.3650582-1-dietmar@proxmox.com>
References: <20250430072524.3650582-1-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

add most common hardware encoders:

- nvh264enc: for NVidia hardware
- vaapih264enc: for common AMD and Intel cards

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc-enc-h264.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
index 09b974a787..98055c095f 100644
--- a/ui/vnc-enc-h264.c
+++ b/ui/vnc-enc-h264.c
@@ -20,7 +20,7 @@ static char *get_available_encoder(const char *encoder_list)
 
     if (!strcmp(encoder_list, "")) {
         /* use default list */
-        encoder_list = "x264enc:openh264enc";
+        encoder_list = "nvh264enc:vaapih264enc:x264enc:openh264enc";
     }
 
     encoder_array = g_strsplit(encoder_list, ":", -1);
@@ -50,7 +50,19 @@ static GstElement *create_encoder(const char *encoder_name)
         return NULL;
     }
 
-    if (!strcmp(encoder_name, "x264enc")) {
+    if (!strcmp(encoder_name, "nvh264enc")) {
+        g_object_set(
+            encoder,
+            "preset", 8,         /* p1 - fastest */
+            "multi-pass", 1,     /* multipass disabled */
+            "tune", 2,           /* low latency */
+            "zerolatency", true, /* low latency */
+            /* avoid access unit delimiters (Nal Unit Type 9) - not required */
+            "aud", false,
+            NULL);
+    } else if (!strcmp(encoder_name, "vaapih264enc")) {
+        g_object_set(encoder, "tune", 1, NULL); /* high compression */
+    } else if (!strcmp(encoder_name, "x264enc")) {
         g_object_set(
             encoder,
             "tune", 4, /* zerolatency */
-- 
2.39.5


