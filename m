Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FD1C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKr0-0007pL-4R; Mon, 14 Jul 2025 11:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUl-0000NM-PA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUW-0003cn-Kt
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFLSITaLGea3HEeMCDS/Nwpgz657YCK89G+6JKg8/+Q=;
 b=hfY/THoAhbNNog/Gqke+6z2rO/Qa4ZjoWhjQhd07ieFhyVSEQL58yhNHdCYGAM+PZhQ7T1
 KUjeOKRqMjbAJY1cHT2dwVwlmC/kqHUghNzedbrouavL8cP1+UiIMd6S3z5nbuQDofrfUS
 YH8YXBTAlb8b02LZdFSkRRZ0QbOxJMc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-xoIKI8lPMAWPb67gonsa_A-1; Mon,
 14 Jul 2025 09:45:09 -0400
X-MC-Unique: xoIKI8lPMAWPb67gonsa_A-1
X-Mimecast-MFC-AGG-ID: xoIKI8lPMAWPb67gonsa_A_1752500709
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E67A1956094
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7A31180045B
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 293F121E65DC; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 26/32] qapi: add cross-references to ui.json
Date: Mon, 14 Jul 2025 15:44:52 +0200
Message-ID: <20250714134458.2991097-27-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711054005.60969-16-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/ui.json | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index b48266c458..c672cf10f9 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -41,7 +41,7 @@
 ##
 # @SetPasswordOptions:
 #
-# Options for set_password.
+# Options for `set_password`.
 #
 # @protocol:
 #     - 'vnc' to modify the VNC server password
@@ -65,7 +65,7 @@
 ##
 # @SetPasswordOptionsVnc:
 #
-# Options for set_password specific to the VNC protocol.
+# Options for `set_password` specific to the VNC protocol.
 #
 # @display: The id of the display where the password should be
 #     changed.  Defaults to the first.
@@ -96,7 +96,7 @@
 ##
 # @ExpirePasswordOptions:
 #
-# General options for expire_password.
+# General options for `expire_password`.
 #
 # @protocol:
 #     - 'vnc' to modify the VNC server expiration
@@ -126,7 +126,7 @@
 ##
 # @ExpirePasswordOptionsVnc:
 #
-# Options for expire_password specific to the VNC protocol.
+# Options for `expire_password` specific to the VNC protocol.
 #
 # @display: The id of the display where the expiration should be
 #     changed.  Defaults to the first.
@@ -185,7 +185,7 @@
 #     the head can only be specified in conjunction with the device
 #     ID.  (Since 2.12)
 #
-# @format: image format for screendump.  (default: ppm) (Since 7.1)
+# @format: image format for `screendump`.  (default: ppm) (Since 7.1)
 #
 # Since: 0.14
 #
@@ -313,7 +313,7 @@
 #     unknown if spice server doesn't provide this information.
 #     (since: 1.1)
 #
-# @channels: a list of @SpiceChannel for each active spice channel
+# @channels: a list of `SpiceChannel` for each active spice channel
 #
 # Since: 0.14
 ##
@@ -563,7 +563,7 @@
 #     - 'vencrypt+x509+sasl' if VEncrypt is used with x509 and SASL
 #       auth
 #
-# @clients: a list of @VncClientInfo of all currently connected
+# @clients: a list of `VncClientInfo` of all currently connected
 #     clients
 #
 # Since: 0.14
@@ -626,12 +626,12 @@
 #
 # @id: vnc server name.
 #
-# @server: A list of @VncBasincInfo describing all listening sockets.
+# @server: A list of `VncBasicInfo` describing all listening sockets.
 #     The list can be empty (in case the vnc server is disabled).  It
 #     also may have multiple entries: normal + websocket, possibly
 #     also ipv4 + ipv6 in the future.
 #
-# @clients: A list of @VncClientInfo of all currently connected
+# @clients: A list of `VncClientInfo` of all currently connected
 #     clients.  The list can be empty, for obvious reasons.
 #
 # @auth: The current authentication type used by the non-websockets
@@ -852,7 +852,7 @@
 #
 # An enumeration of key name.
 #
-# This is used by the @send-key command.
+# This is used by the `send-key` command.
 #
 # @unmapped: since 2.0
 #
@@ -1023,10 +1023,10 @@
 #
 # Send keys to guest.
 #
-# @keys: An array of @KeyValue elements.  All @KeyValues in this array
-#     are simultaneously sent to the guest.  A @KeyValue.number value
-#     is sent directly to the guest, while @KeyValue.qcode must be a
-#     valid @QKeyCode value
+# @keys: An array of `KeyValue` elements.  All @KeyValues in this array
+#     are simultaneously sent to the guest.  A `KeyValue`.number value
+#     is sent directly to the guest, while `KeyValue`.qcode must be a
+#     valid `QKeyCode` value
 #
 # @hold-time: time to delay key up events, milliseconds.  Defaults to
 #     100
@@ -1263,7 +1263,7 @@
 # @head: head to send event(s) to, in case the display device supports
 #     multiple scanouts.
 #
-# @events: List of InputEvent union.
+# @events: List of `InputEvent` union.
 #
 # Since: 2.6
 #
@@ -1367,7 +1367,7 @@
 #     first available node on the host.
 #
 # @p2p: Whether to use peer-to-peer connections (accepted through
-#     @add_client).
+#     `add_client`).
 #
 # @audiodev: Use the specified DBus audiodev to export audio.
 #
@@ -1526,7 +1526,7 @@
 #
 # Display (user interface) options.
 #
-# @type: Which DisplayType QEMU should use.
+# @type: Which `DisplayType` QEMU should use.
 #
 # @full-screen: Start user interface in fullscreen mode
 #     (default: off).
-- 
2.49.0


