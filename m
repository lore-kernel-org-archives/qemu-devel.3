Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366CBC531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmlRd-0004r1-Ad; Thu, 23 Jul 2026 00:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlRM-0004YD-LZ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlRK-0004xc-7V
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784782425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WvVNT9FP84PI//trYRCoAZS9q9GdrG1oeUvWQayikpo=;
 b=UEtELHgYSfgLcfWXxBzrsPL3ArzJR1pLdVIEJkdpjFaiRncOQJ5h+7kWc5kywivbi6fctQ
 QVCW6AbFwrxWD9zmI5gBVvr5h40NEfw+Nebrp3dZPqZ7MqgdQJV308E2eGh3lGEaer+4En
 3K1bajn7fThp2Fk2y00W+xdS5z0WKXc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-Z0nYtQrROaGc1WxEnAlu_g-1; Thu,
 23 Jul 2026 00:53:40 -0400
X-MC-Unique: Z0nYtQrROaGc1WxEnAlu_g-1
X-Mimecast-MFC-AGG-ID: Z0nYtQrROaGc1WxEnAlu_g_1784782416
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 009F61977539; Thu, 23 Jul 2026 04:53:36 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DE9318002B4; Thu, 23 Jul 2026 04:53:27 +0000 (UTC)
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
Subject: [PATCH v2 32/44] qapi: convert trivial intro sections for block.json
Date: Thu, 23 Jul 2026 00:47:53 -0400
Message-ID: <20260723044805.527643-33-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=jsnow@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
 qapi/block.json | 58 +++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e3..e47592d5500 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -16,11 +16,10 @@
 
 ##
 # @BiosAtaTranslation:
-#
-# Policy that BIOS should use to interpret cylinder/head/sector
-# addresses.  Note that Bochs BIOS and SeaBIOS will not actually
-# translate logical CHS to physical; instead, they will use logical
-# block addressing.
+#     Policy that BIOS should use to interpret cylinder/head/sector
+#     addresses.  Note that Bochs BIOS and SeaBIOS will not actually
+#     translate logical CHS to physical; instead, they will use
+#     logical block addressing.
 #
 # @auto: If cylinder/heads/sizes are passed, choose between none and
 #     LBA depending on the size of the disk.  If they are not passed,
@@ -50,8 +49,8 @@
 
 ##
 # @FloppyDriveType:
-#
-# Type of floppy drive to be emulated by the Floppy Disk Controller.
+#     Type of floppy drive to be emulated by the
+#     Floppy Disk Controller.
 #
 # @144: 1.44MB 3.5" drive
 #
@@ -70,8 +69,7 @@
 
 ##
 # @PRManagerInfo:
-#
-# Information about a persistent reservation manager
+#     Information about a persistent reservation manager
 #
 # @id: the identifier of the persistent reservation manager
 #
@@ -85,9 +83,8 @@
 
 ##
 # @query-pr-managers:
-#
-# Return a list of information about each persistent reservation
-# manager.
+#     Return a list of information about each persistent reservation
+#     manager.
 #
 # Returns: a list of manager info for each persistent reservation
 #     manager
@@ -99,8 +96,7 @@
 
 ##
 # @eject:
-#
-# Ejects the medium from a removable drive.
+#     Ejects the medium from a removable drive.
 #
 # @device: Block device name
 #
@@ -264,10 +260,10 @@
 
 ##
 # @blockdev-insert-medium:
-#
-# Inserts a medium (a block driver state tree) into a block device.
-# That block device's tray must currently be open (unless there is no
-# attached guest device) and there must be no medium inserted already.
+#     Inserts a medium (a block driver state tree) into a block
+#     device.  That block device's tray must currently be open (unless
+#     there is no attached guest device) and there must be no medium
+#     inserted already.
 #
 # @id: The name or QOM path of the guest device
 #
@@ -297,9 +293,8 @@
 
 ##
 # @BlockdevChangeReadOnlyMode:
-#
-# Specifies the new read-only mode of a block device subject to the
-# `blockdev-change-medium` command.
+#     Specifies the new read-only mode of a block device subject to
+#     the `blockdev-change-medium` command.
 #
 # @retain: Retains the current read-only mode
 #
@@ -314,12 +309,11 @@
 
 ##
 # @blockdev-change-medium:
-#
-# Changes the medium inserted into a block device by ejecting the
-# current medium and loading a new image file which is inserted as the
-# new medium (this command combines `blockdev-open-tray`,
-# `blockdev-remove-medium`, `blockdev-insert-medium` and
-# `blockdev-close-tray`).
+#     Changes the medium inserted into a block device by ejecting the
+#     current medium and loading a new image file which is inserted as
+#     the new medium (this command combines `blockdev-open-tray`,
+#     `blockdev-remove-medium`, `blockdev-insert-medium` and
+#     `blockdev-close-tray`).
 #
 # @device: Block device name
 #
@@ -385,9 +379,8 @@
 
 ##
 # @DEVICE_TRAY_MOVED:
-#
-# Emitted whenever the tray of a removable device is moved by the
-# guest or by HMP/QMP commands
+#     Emitted whenever the tray of a removable device is moved by the
+#     guest or by HMP/QMP commands
 #
 # @device: Block device name.  This is always present for
 #     compatibility reasons, but it can be empty ("") if the image
@@ -414,9 +407,8 @@
 
 ##
 # @PR_MANAGER_STATUS_CHANGED:
-#
-# Emitted whenever the connected status of a persistent reservation
-# manager changes.
+#     Emitted whenever the connected status of a persistent
+#     reservation manager changes.
 #
 # @id: The id of the PR manager object
 #
-- 
2.55.0


