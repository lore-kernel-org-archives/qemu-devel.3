Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F50C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJWy-0007Jc-Sj; Wed, 26 Aug 2026 15:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWw-0007EW-Hq
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWv-0006fK-2S
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787773404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBjfSrh5PfkhhEWxcRNzfkVdUgV/WtbECn/x1oGAF6I=;
 b=U1YjC8quyeYAsPsXYFVMmfFhQbzVuI+CKO7fUQ6D+Diwoxn1LZB9jJY+ieNLSoa90JKCNR
 JQ6F2rD/Wpb/4d3iLUV78aefa3WYW/oU57yisUoxzNJLv9wbVV87AsLkmOpxrClBv952QO
 hjUjKKWltMF9/wfinDXzO+c3fKN5Ndc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-B5q4-qiGPjuR5KGL_GZZnQ-1; Wed,
 26 Aug 2026 15:43:21 -0400
X-MC-Unique: B5q4-qiGPjuR5KGL_GZZnQ-1
X-Mimecast-MFC-AGG-ID: B5q4-qiGPjuR5KGL_GZZnQ_1787773396
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CB31195607A; Wed, 26 Aug 2026 19:43:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5788818005AC; Wed, 26 Aug 2026 19:43:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, linux-cxl@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 31/43] qapi: convert trivial intro sections for block.json
Date: Wed, 26 Aug 2026 15:38:28 -0400
Message-ID: <20260826193840.2152000-32-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
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
 qapi/block.json | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e3..189f2e28204 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -50,8 +50,8 @@
 
 ##
 # @FloppyDriveType:
-#
-# Type of floppy drive to be emulated by the Floppy Disk Controller.
+#     Type of floppy drive to be emulated by the
+#     Floppy Disk Controller.
 #
 # @144: 1.44MB 3.5" drive
 #
@@ -70,8 +70,7 @@
 
 ##
 # @PRManagerInfo:
-#
-# Information about a persistent reservation manager
+#     Information about a persistent reservation manager
 #
 # @id: the identifier of the persistent reservation manager
 #
@@ -85,9 +84,8 @@
 
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
@@ -99,8 +97,7 @@
 
 ##
 # @eject:
-#
-# Ejects the medium from a removable drive.
+#     Ejects the medium from a removable drive.
 #
 # @device: Block device name
 #
@@ -297,9 +294,8 @@
 
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
@@ -314,12 +310,11 @@
 
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
@@ -385,9 +380,8 @@
 
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
@@ -414,9 +408,8 @@
 
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


