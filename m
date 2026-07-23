Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB866C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmlRE-0004P8-LM; Thu, 23 Jul 2026 00:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlR2-0004CF-Vl
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlQz-0004su-F5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784782404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqpQURYzqagcZw6PUEaGQX94Y2bhPgrE5ybIwr9ASNk=;
 b=hapXdTNTYf8mV+OG32ChQe1Et+utbyvW1H2Fv3tA1+uYWxXAX03519gSW1eQvBSuXMkA8D
 IfREduCmV5LYZ4Y5Uxm4hBhhtugrqC5j1BFI47i0qJaP3SRntBZQ+IJh7OoNWgLnh0DE2t
 FPTWzVAxHGGJTZlUiRvHZABR4HGeePQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-2u3NbkSaOaqH6BtjDhRcyA-1; Thu,
 23 Jul 2026 00:53:19 -0400
X-MC-Unique: 2u3NbkSaOaqH6BtjDhRcyA-1
X-Mimecast-MFC-AGG-ID: 2u3NbkSaOaqH6BtjDhRcyA_1784782396
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77ED41805F05; Thu, 23 Jul 2026 04:53:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDD4918002AE; Thu, 23 Jul 2026 04:53:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 30/44] qapi: convert trivial intro sections for
 block-export.json
Date: Thu, 23 Jul 2026 00:47:51 -0400
Message-ID: <20260723044805.527643-31-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=jsnow@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-export.json | 87 +++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 52 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index dd724acf1cb..e9f7e72c8ee 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -37,10 +37,9 @@
 
 ##
 # @NbdServerOptions:
-#
-# Keep this type consistent with the `NbdServerOptionsLegacy` type.
-# The only intended difference is using `SocketAddress` instead of
-# `SocketAddressLegacy`.
+#     Keep this type consistent with the `NbdServerOptionsLegacy`
+#     type.  The only intended difference is using `SocketAddress`
+#     instead of `SocketAddressLegacy`.
 #
 # @addr: Address on which to listen (since 4.2).
 ##
@@ -50,10 +49,9 @@
 
 ##
 # @NbdServerOptionsLegacy:
-#
-# Keep this type consistent with the `NbdServerOptions` type.  The
-# only intended difference is using `SocketAddressLegacy` instead of
-# `SocketAddress`.
+#     Keep this type consistent with the `NbdServerOptions` type.  The
+#     only intended difference is using `SocketAddressLegacy` instead
+#     of `SocketAddress`.
 #
 # @addr: Address on which to listen (since 1.3).
 ##
@@ -63,11 +61,11 @@
 
 ##
 # @nbd-server-start:
-#
-# Start an NBD server listening on the given host and port.  Block
-# devices can then be exported using `nbd-server-add`.  The NBD server
-# will present them as named exports; for example, another QEMU
-# instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
+#     Start an NBD server listening on the given host and port.  Block
+#     devices can then be exported using `nbd-server-add`.  The NBD
+#     server will present them as named exports; for example, another
+#     QEMU instance could refer to them as
+#     "nbd:HOST:PORT:exportname=NAME".
 #
 # Errors:
 #     - if the server is already running
@@ -80,9 +78,8 @@
 
 ##
 # @BlockExportOptionsNbdBase:
-#
-# An NBD block export (common options shared between `nbd-server-add`
-# and the NBD branch of `block-export-add`).
+#     An NBD block export (common options shared between
+#     `nbd-server-add` and the NBD branch of `block-export-add`).
 #
 # @name: Export name.  If unspecified, the @device parameter is used
 #     as the export name.  (Since 2.12)
@@ -97,9 +94,8 @@
 
 ##
 # @BlockExportOptionsNbd:
-#
-# An NBD block export (distinct options used in the NBD branch of
-# `block-export-add`).
+#     An NBD block export (distinct options used in the NBD branch of
+#     `block-export-add`).
 #
 # @bitmaps: Also export each of the named dirty bitmaps reachable from
 #     @device, so the NBD client can use NBD_OPT_SET_META_CONTEXT with
@@ -121,8 +117,7 @@
 
 ##
 # @BlockExportOptionsVhostUserBlk:
-#
-# A vhost-user-blk block export.
+#     A vhost-user-blk block export.
 #
 # @addr: The vhost-user socket on which to listen.  Both 'unix' and
 #     'fd' `SocketAddress` types are supported.  Passed fds must be
@@ -143,8 +138,7 @@
 
 ##
 # @FuseExportAllowOther:
-#
-# Possible allow_other modes for FUSE exports.
+#     Possible allow_other modes for FUSE exports.
 #
 # @off: Do not pass allow_other as a mount option.
 #
@@ -195,8 +189,7 @@
 
 ##
 # @BlockExportOptionsVduseBlk:
-#
-# A vduse-blk block export.
+#     A vduse-blk block export.
 #
 # @name: the name of VDUSE device (must be unique across the host).
 #
@@ -221,8 +214,7 @@
 
 ##
 # @NbdServerAddOptions:
-#
-# An NBD block export, per legacy `nbd-server-add` command.
+#     An NBD block export, per legacy `nbd-server-add` command.
 #
 # @device: The device name or node name of the node to be exported
 #
@@ -266,8 +258,7 @@
 
 ##
 # @BlockExportRemoveMode:
-#
-# Mode for removing a block export.
+#     Mode for removing a block export.
 #
 # @safe: Remove export if there are no existing connections, fail
 #     otherwise.
@@ -289,8 +280,7 @@
 
 ##
 # @nbd-server-remove:
-#
-# Remove NBD export by name.
+#     Remove NBD export by name.
 #
 # @name: Block export id.
 #
@@ -316,9 +306,8 @@
 
 ##
 # @nbd-server-stop:
-#
-# Stop QEMU's embedded NBD server, and unregister all devices
-# previously added via `nbd-server-add`.
+#     Stop QEMU's embedded NBD server, and unregister all devices
+#     previously added via `nbd-server-add`.
 #
 # Since: 1.3
 ##
@@ -327,8 +316,7 @@
 
 ##
 # @BlockExportType:
-#
-# An enumeration of block export types
+#     An enumeration of block export types
 #
 # @nbd: NBD export
 #
@@ -349,9 +337,8 @@
 
 ##
 # @BlockExportOptions:
-#
-# Describes a block export, i.e. how single node should be exported on
-# an external interface.
+#     Describes a block export, i.e. how single node should be
+#     exported on an external interface.
 #
 # @type: Block export type
 #
@@ -412,9 +399,8 @@
 
 ##
 # @BlockExportIothreads:
-#
-# Specify a single or multiple I/O threads in which to run a block
-# export's I/O.
+#     Specify a single or multiple I/O threads in which to run a block
+#     export's I/O.
 #
 # @single: Run the export's I/O in the given single I/O thread.
 #
@@ -436,8 +422,7 @@
 
 ##
 # @block-export-add:
-#
-# Creates a new block export.
+#     Creates a new block export.
 #
 # Since: 5.2
 ##
@@ -447,10 +432,10 @@
 
 ##
 # @block-export-del:
-#
-# Request to remove a block export.  This drops the user's reference
-# to the export, but the export may still stay around after this
-# command returns until the shutdown of the export has completed.
+#     Request to remove a block export.  This drops the user's
+#     reference to the export, but the export may still stay around
+#     after this command returns until the shutdown of the export has
+#     completed.
 #
 # @id: Block export id.
 #
@@ -470,8 +455,7 @@
 
 ##
 # @BLOCK_EXPORT_DELETED:
-#
-# Emitted when a block export is removed and its id can be reused.
+#     Emitted when a block export is removed and its id can be reused.
 #
 # @id: Block export id.
 #
@@ -482,8 +466,7 @@
 
 ##
 # @BlockExportInfo:
-#
-# Information about a single block export.
+#     Information about a single block export.
 #
 # @id: The unique identifier for the block export
 #
-- 
2.55.0


