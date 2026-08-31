Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19A9C624D3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x18YT-0006xV-7Q; Mon, 31 Aug 2026 16:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18YR-0006gR-DX
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18YP-0008Lp-Ko
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788207869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCn/Ycwrut66144uUrLT80zpCgg+RoqrOgG6fdXeCGY=;
 b=iL0vPIVM9jZyZQpHJgqd/UbjhtMdk5qEf5/2S8N8Jwx9Lq1CbwDZKFJO3hrAGfLMNTsEdE
 Plffu04Wqe+SbvkKgxlNmQgTk2MfUJA/u28vIJNgqutR/P8c2sdExnVh4Vqc9vcDYyk06I
 rrp8Pp0NGyEW2kYvJ2G1SvBJOfkIjkw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-w_h5KMCUOy67bYeZnNAPSA-1; Mon,
 31 Aug 2026 16:24:25 -0400
X-MC-Unique: w_h5KMCUOy67bYeZnNAPSA-1
X-Mimecast-MFC-AGG-ID: w_h5KMCUOy67bYeZnNAPSA_1788207862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6427A18E678F; Mon, 31 Aug 2026 20:24:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 597B21800347; Mon, 31 Aug 2026 20:24:15 +0000 (UTC)
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
Subject: [PATCH v4 29/43] qapi: convert trivial intro sections for
 block-export.json
Date: Mon, 31 Aug 2026 16:19:31 -0400
Message-ID: <20260831201945.287730-30-jsnow@redhat.com>
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
 qapi/block-export.json | 50 +++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index dd724acf1cb..154f07b0b95 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -80,9 +80,8 @@
 
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
@@ -97,9 +96,8 @@
 
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
@@ -121,8 +119,7 @@
 
 ##
 # @BlockExportOptionsVhostUserBlk:
-#
-# A vhost-user-blk block export.
+#     A vhost-user-blk block export.
 #
 # @addr: The vhost-user socket on which to listen.  Both 'unix' and
 #     'fd' `SocketAddress` types are supported.  Passed fds must be
@@ -143,8 +140,7 @@
 
 ##
 # @FuseExportAllowOther:
-#
-# Possible allow_other modes for FUSE exports.
+#     Possible allow_other modes for FUSE exports.
 #
 # @off: Do not pass allow_other as a mount option.
 #
@@ -195,8 +191,7 @@
 
 ##
 # @BlockExportOptionsVduseBlk:
-#
-# A vduse-blk block export.
+#     A vduse-blk block export.
 #
 # @name: the name of VDUSE device (must be unique across the host).
 #
@@ -221,8 +216,7 @@
 
 ##
 # @NbdServerAddOptions:
-#
-# An NBD block export, per legacy `nbd-server-add` command.
+#     An NBD block export, per legacy `nbd-server-add` command.
 #
 # @device: The device name or node name of the node to be exported
 #
@@ -266,8 +260,7 @@
 
 ##
 # @BlockExportRemoveMode:
-#
-# Mode for removing a block export.
+#     Mode for removing a block export.
 #
 # @safe: Remove export if there are no existing connections, fail
 #     otherwise.
@@ -289,8 +282,7 @@
 
 ##
 # @nbd-server-remove:
-#
-# Remove NBD export by name.
+#     Remove NBD export by name.
 #
 # @name: Block export id.
 #
@@ -316,9 +308,8 @@
 
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
@@ -327,8 +318,7 @@
 
 ##
 # @BlockExportType:
-#
-# An enumeration of block export types
+#     An enumeration of block export types
 #
 # @nbd: NBD export
 #
@@ -412,9 +402,8 @@
 
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
@@ -436,8 +425,7 @@
 
 ##
 # @block-export-add:
-#
-# Creates a new block export.
+#     Creates a new block export.
 #
 # Since: 5.2
 ##
@@ -470,8 +458,7 @@
 
 ##
 # @BLOCK_EXPORT_DELETED:
-#
-# Emitted when a block export is removed and its id can be reused.
+#     Emitted when a block export is removed and its id can be reused.
 #
 # @id: Block export id.
 #
@@ -482,8 +469,7 @@
 
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


