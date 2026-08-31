Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F311C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x18ZG-0003AX-H3; Mon, 31 Aug 2026 16:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18ZC-0002q8-Jc
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18ZA-0000B6-NA
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788207916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbbbHuvMBl3KhDhnR1d/E0FiTkXcZ8dsOcmbpvowW8U=;
 b=eZ1KVL/z0WHj0NM5C8DRdAfSA4Uc94evbmT3Q5FEsZGXGEzuYMTFPM+K9JKyPdJOf5Yz2z
 5afJRupAJ02K2Q7Ip1MVJaRymesD6GlvRmp5PJiG9cDHF9jPYxfgshd3AAY2hU1x/DezWi
 2r+kEAOntElGs11vQmyBDbhujoT4/1c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-xQ22YuS6OLOSlcEGZCvDTg-1; Mon,
 31 Aug 2026 16:25:14 -0400
X-MC-Unique: xQ22YuS6OLOSlcEGZCvDTg-1
X-Mimecast-MFC-AGG-ID: xQ22YuS6OLOSlcEGZCvDTg_1788207911
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47781195FE38; Mon, 31 Aug 2026 20:25:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C14B71800577; Mon, 31 Aug 2026 20:25:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 zhenwei pi <zhenwei.pi@linux.dev>, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, linux-cxl@vger.kernel.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 linux-edac@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 36/43] qapi: convert trivial intro sections for char.json
Date: Mon, 31 Aug 2026 16:19:38 -0400
Message-ID: <20260831201945.287730-37-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
 qapi/char.json | 90 +++++++++++++++++---------------------------------
 1 file changed, 30 insertions(+), 60 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index abaccefa97e..7ae67eedff8 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -12,8 +12,7 @@
 
 ##
 # @ChardevInfo:
-#
-# Information about a character device.
+#     Information about a character device.
 #
 # @label: the label of the character device
 #
@@ -35,8 +34,7 @@
 
 ##
 # @query-chardev:
-#
-# Return information about current character devices.
+#     Return information about current character devices.
 #
 # Since: 0.14
 #
@@ -68,8 +66,7 @@
 
 ##
 # @ChardevBackendInfo:
-#
-# Information about a character device backend
+#     Information about a character device backend
 #
 # @name: The backend name
 #
@@ -79,8 +76,7 @@
 
 ##
 # @query-chardev-backends:
-#
-# Return information about character device backends.
+#     Return information about character device backends.
 #
 # Since: 2.0
 #
@@ -108,8 +104,7 @@
 
 ##
 # @DataFormat:
-#
-# An enumeration of data format.
+#     An enumeration of data format.
 #
 # @utf8: Data is a UTF-8 string (RFC 3629)
 #
@@ -122,8 +117,7 @@
 
 ##
 # @ringbuf-write:
-#
-# Write to a ring buffer character device.
+#     Write to a ring buffer character device.
 #
 # @device: the ring buffer character device name
 #
@@ -154,8 +148,7 @@
 
 ##
 # @ringbuf-read:
-#
-# Read from a ring buffer character device.
+#     Read from a ring buffer character device.
 #
 # @device: the ring buffer character device name
 #
@@ -189,8 +182,7 @@
 
 ##
 # @ChardevCommon:
-#
-# Configuration shared across all chardev backends
+#     Configuration shared across all chardev backends
 #
 # @logfile: The name of a logfile to save output
 #
@@ -209,8 +201,7 @@
 
 ##
 # @ChardevFile:
-#
-# Configuration info for file chardevs.
+#     Configuration info for file chardevs.
 #
 # @in: The name of the input file
 #
@@ -229,8 +220,7 @@
 
 ##
 # @ChardevHostdev:
-#
-# Configuration info for device and pipe chardevs.
+#     Configuration info for device and pipe chardevs.
 #
 # @device: The name of the special file for the device, i.e.
 #     /dev/ttyS0 on Unix or COM1: on Windows
@@ -243,8 +233,7 @@
 
 ##
 # @ChardevSocket:
-#
-# Configuration info for (stream) socket chardevs.
+#     Configuration info for (stream) socket chardevs.
 #
 # @addr: socket address to listen on (server=true) or connect to
 #     (server=false)
@@ -295,8 +284,7 @@
 
 ##
 # @ChardevUdp:
-#
-# Configuration info for datagram socket chardevs.
+#     Configuration info for datagram socket chardevs.
 #
 # @remote: remote address
 #
@@ -311,8 +299,7 @@
 
 ##
 # @ChardevMux:
-#
-# Configuration info for mux chardevs.
+#     Configuration info for mux chardevs.
 #
 # @chardev: name of the base chardev.
 #
@@ -324,8 +311,7 @@
 
 ##
 # @ChardevHub:
-#
-# Configuration info for hub chardevs.
+#     Configuration info for hub chardevs.
 #
 # @chardevs: IDs to be added to this hub (maximum 4 devices).
 #
@@ -337,8 +323,7 @@
 
 ##
 # @ChardevStdio:
-#
-# Configuration info for stdio chardevs.
+#     Configuration info for stdio chardevs.
 #
 # @signal: Allow signals (such as SIGINT triggered by ^C) be delivered
 #     to QEMU.  Default: true.
@@ -351,8 +336,7 @@
 
 ##
 # @ChardevSpiceChannel:
-#
-# Configuration info for spice vm channel chardevs.
+#     Configuration info for spice vm channel chardevs.
 #
 # @type: kind of channel (for example vdagent).
 #
@@ -365,8 +349,7 @@
 
 ##
 # @ChardevSpicePort:
-#
-# Configuration info for spice port chardevs.
+#     Configuration info for spice port chardevs.
 #
 # @fqdn: name of the channel (see docs/spice-port-fqdn.txt)
 #
@@ -379,8 +362,7 @@
 
 ##
 # @ChardevVCEncoding:
-#
-# Character encoding expected from the guest on a virtual console.
+#     Character encoding expected from the guest on a virtual console.
 #
 # @cp437: CP437 (8-bit Extended ASCII / VGA).  Every byte maps
 #     directly to a glyph; suitable for DOS or other guests that
@@ -397,8 +379,7 @@
 
 ##
 # @ChardevDBus:
-#
-# Configuration info for DBus chardevs.
+#     Configuration info for DBus chardevs.
 #
 # @name: name of the channel (following docs/spice-port-fqdn.txt)
 #
@@ -415,8 +396,7 @@
 
 ##
 # @ChardevVC:
-#
-# Configuration info for virtual console chardevs.
+#     Configuration info for virtual console chardevs.
 #
 # @width: console width, in pixels
 #
@@ -445,8 +425,7 @@
 
 ##
 # @ChardevRingbuf:
-#
-# Configuration info for ring buffer chardevs.
+#     Configuration info for ring buffer chardevs.
 #
 # @size: ring buffer size, must be power of two, default is 65536
 #
@@ -458,8 +437,7 @@
 
 ##
 # @ChardevQemuVDAgent:
-#
-# Configuration info for QEMU vdagent implementation.
+#     Configuration info for QEMU vdagent implementation.
 #
 # @mouse: enable/disable mouse, default is enabled.
 #
@@ -475,8 +453,7 @@
 
 ##
 # @ChardevPty:
-#
-# Configuration info for pty implementation.
+#     Configuration info for pty implementation.
 #
 # @path: optional path to create a symbolic link that points to the
 #     allocated PTY
@@ -723,8 +700,7 @@
 
 ##
 # @ChardevBackend:
-#
-# Configuration info for the new chardev backend.
+#     Configuration info for the new chardev backend.
 #
 # @type: backend type
 #
@@ -767,8 +743,7 @@
 
 ##
 # @ChardevReturn:
-#
-# Return info about the chardev backend just created.
+#     Return info about the chardev backend just created.
 #
 # @pty: name of the slave pseudoterminal device, present if and only
 #     if a chardev of type 'pty' was created
@@ -780,8 +755,7 @@
 
 ##
 # @chardev-add:
-#
-# Add a character device backend
+#     Add a character device backend
 #
 # @id: the chardev's ID, must be unique
 #
@@ -818,8 +792,7 @@
 
 ##
 # @chardev-change:
-#
-# Change a character device backend
+#     Change a character device backend
 #
 # @id: the chardev's ID
 #
@@ -859,8 +832,7 @@
 
 ##
 # @chardev-remove:
-#
-# Remove a character device backend
+#     Remove a character device backend
 #
 # @id: the chardev's ID, must not be in use
 #
@@ -876,8 +848,7 @@
 
 ##
 # @chardev-send-break:
-#
-# Send a break to a character device
+#     Send a break to a character device
 #
 # @id: the chardev's ID
 #
@@ -893,8 +864,7 @@
 
 ##
 # @VSERPORT_CHANGE:
-#
-# Emitted when the guest opens or closes a virtio-serial port.
+#     Emitted when the guest opens or closes a virtio-serial port.
 #
 # @id: device identifier of the virtio-serial port
 #
-- 
2.55.0


