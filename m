Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951F5C83F23
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua6X2-0008Vu-1M; Fri, 11 Jul 2025 01:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6Wf-0007oT-8M
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6WW-0000go-Gq
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752212535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2UJX1seXQXHC4p5Q0gjXCAW3wOPn0ipsh4usuRaeEU=;
 b=Ky4ljvSGJh2imREvx7azJ9+CfRtjhsvc0TfFsPtQlR/bNYfP0as1pn3mZwacOQ5BUi+rox
 OIHo0H6VVsDwhXZNdnpDWuvNHQdChsE2ZLOnJrVzoSBGwIG729t1NP+Ux0fJpGWv1fRwrl
 RHJ83fUqf41QDb5/2GN9/3Dl5PpeUEA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-VDCicuTnMPutOkvkCM0oaQ-1; Fri,
 11 Jul 2025 01:42:12 -0400
X-MC-Unique: VDCicuTnMPutOkvkCM0oaQ-1
X-Mimecast-MFC-AGG-ID: VDCicuTnMPutOkvkCM0oaQ_1752212531
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0020D180028B; Fri, 11 Jul 2025 05:42:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BF881800285; Fri, 11 Jul 2025 05:42:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 15/18] qapi: add cross-references to ui.json
Date: Fri, 11 Jul 2025 01:40:02 -0400
Message-ID: <20250711054005.60969-16-jsnow@redhat.com>
In-Reply-To: <20250711054005.60969-1-jsnow@redhat.com>
References: <20250711054005.60969-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/ui.json | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 7136c985c38..5bc54403cc2 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -39,7 +39,7 @@
 ##
 # @SetPasswordOptions:
 #
-# Options for set_password.
+# Options for `set_password`.
 #
 # @protocol:
 #     - 'vnc' to modify the VNC server password
@@ -63,7 +63,7 @@
 ##
 # @SetPasswordOptionsVnc:
 #
-# Options for set_password specific to the VNC protocol.
+# Options for `set_password` specific to the VNC protocol.
 #
 # @display: The id of the display where the password should be
 #     changed.  Defaults to the first.
@@ -94,7 +94,7 @@
 ##
 # @ExpirePasswordOptions:
 #
-# General options for expire_password.
+# General options for `expire_password`.
 #
 # @protocol:
 #     - 'vnc' to modify the VNC server expiration
@@ -124,7 +124,7 @@
 ##
 # @ExpirePasswordOptionsVnc:
 #
-# Options for expire_password specific to the VNC protocol.
+# Options for `expire_password` specific to the VNC protocol.
 #
 # @display: The id of the display where the expiration should be
 #     changed.  Defaults to the first.
@@ -183,7 +183,7 @@
 #     the head can only be specified in conjunction with the device
 #     ID.  (Since 2.12)
 #
-# @format: image format for screendump.  (default: ppm) (Since 7.1)
+# @format: image format for `screendump`.  (default: ppm) (Since 7.1)
 #
 # Since: 0.14
 #
@@ -310,7 +310,7 @@
 #     unknown if spice server doesn't provide this information.
 #     (since: 1.1)
 #
-# @channels: a list of @SpiceChannel for each active spice channel
+# @channels: a list of `SpiceChannel` for each active spice channel
 #
 # Since: 0.14
 ##
@@ -559,7 +559,7 @@
 #     - 'vencrypt+x509+sasl' if VEncrypt is used with x509 and SASL
 #       auth
 #
-# @clients: a list of @VncClientInfo of all currently connected
+# @clients: a list of `VncClientInfo` of all currently connected
 #     clients
 #
 # Since: 0.14
@@ -622,12 +622,12 @@
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
@@ -846,7 +846,7 @@
 #
 # An enumeration of key name.
 #
-# This is used by the @send-key command.
+# This is used by the `send-key` command.
 #
 # @unmapped: since 2.0
 #
@@ -1017,10 +1017,10 @@
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
@@ -1257,7 +1257,7 @@
 # @head: head to send event(s) to, in case the display device supports
 #     multiple scanouts.
 #
-# @events: List of InputEvent union.
+# @events: List of `InputEvent` union.
 #
 # Since: 2.6
 #
@@ -1361,7 +1361,7 @@
 #     first available node on the host.
 #
 # @p2p: Whether to use peer-to-peer connections (accepted through
-#     @add_client).
+#     `add_client`).
 #
 # @audiodev: Use the specified DBus audiodev to export audio.
 #
@@ -1520,7 +1520,7 @@
 #
 # Display (user interface) options.
 #
-# @type: Which DisplayType QEMU should use.
+# @type: Which `DisplayType` QEMU should use.
 #
 # @full-screen: Start user interface in fullscreen mode
 #     (default: off).
-- 
2.50.0


