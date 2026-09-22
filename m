Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866CBC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97Xf-0000KP-0W; Tue, 22 Sep 2026 16:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97XP-0000Fs-UT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97XO-00045D-EJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790110585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hO6U0r43tcwIk1YxVH+Jad9U+KcRDjTIv+P59ADGJEo=;
 b=LQf2oY0QY9MkvaeDBtXCrEzriKdO/WR66brcdXVn1IVMJPe6XrIYJa2Ia7NeDSRzu1mQ74
 E09PD7bKfgh8nFpYRcaysxzUdU5SSdd4yryznN/sMMR/ygMajKoAC4tfV5bFhk8iyvnEWl
 zL2S+Y3PgLPDcqfGTEX4/lNYQP91SBE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-xlp_FLPXNHGSAHfsHoZIAA-1; Tue,
 22 Sep 2026 16:56:21 -0400
X-MC-Unique: xlp_FLPXNHGSAHfsHoZIAA-1
X-Mimecast-MFC-AGG-ID: xlp_FLPXNHGSAHfsHoZIAA_1790110579
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EE7F1944A85; Tue, 22 Sep 2026 20:56:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA3E41956087; Tue, 22 Sep 2026 20:56:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 1/8] qapi: convert/split remaining qapi/qmp intro sections
Date: Tue, 22 Sep 2026 16:55:58 -0400
Message-ID: <20260922205605.501602-2-jsnow@redhat.com>
In-Reply-To: <20260922205605.501602-1-jsnow@redhat.com>
References: <20260922205605.501602-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A few slipped in during the mass conversion, get those too. Mostly
trivial conversion, with the exception of @x-qemu-io which introduces
a new split.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block.json         |  5 +++--
 qapi/machine-s390x.json |  3 +--
 qapi/machine.json       |  3 +--
 qapi/net.json           | 24 ++++++++----------------
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 13c47e1eb44..0a88d405a26 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -597,9 +597,10 @@
 
 ##
 # @x-qemu-io:
+#     Run a qemu-io command on a block device.
 #
-# Run a qemu-io command on a block device.  Take either a block
-# backend name or a qdev ID to identify the device.
+# Take either a block backend name or a qdev ID to identify the
+# device.
 #
 # @device: the block backend name, node-name to run the
 #     command on.
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index 670a1f9d926..8d8cbe2fb75 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -138,8 +138,7 @@
 
 ##
 # @BootCertificates:
-#
-# Boot certificates for secure IPL.
+#     Boot certificates for secure IPL.
 #
 # @path: path to an X.509 certificate file or a directory containing
 #      certificate files.
diff --git a/qapi/machine.json b/qapi/machine.json
index 1220116bf7d..6eb14c62851 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1390,8 +1390,7 @@
 
 ##
 # @SpMemDeviceInfo:
-#
-# sp-mem device state information
+#     sp-mem device state information
 #
 # @id: device's ID
 #
diff --git a/qapi/net.json b/qapi/net.json
index 2a186a71b93..f0312dfb714 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1275,8 +1275,7 @@
 
 ##
 # @UsernetInfo:
-#
-# Information about a user-mode network stack (slirp).
+#     Information about a user-mode network stack (slirp).
 #
 # @hub-id: The hub id, if available.
 #
@@ -1295,8 +1294,7 @@
 
 ##
 # @x-query-usernet:
-#
-# Query user-mode network stack connection states.
+#     Query user-mode network stack connection states.
 #
 # Features:
 #
@@ -1319,8 +1317,7 @@
 
 ##
 # @NetFilterInfo:
-#
-# Information about a netfilter attached to a network client.
+#     Information about a netfilter attached to a network client.
 #
 # @name: filter object name (QOM path component)
 #
@@ -1339,8 +1336,7 @@
 
 ##
 # @NetworkClientInfo:
-#
-# Information about a network client.
+#     Information about a network client.
 #
 # @name: unique network client identifier
 #
@@ -1369,8 +1365,7 @@
 
 ##
 # @NetHubPortInfo:
-#
-# Information about a hub port.
+#     Information about a hub port.
 #
 # @name: hub port identifier
 #
@@ -1385,8 +1380,7 @@
 
 ##
 # @NetHubInfo:
-#
-# Information about a network hub.
+#     Information about a network hub.
 #
 # @id: hub identifier
 #
@@ -1401,8 +1395,7 @@
 
 ##
 # @NetworkInfo:
-#
-# Information about the network configuration.
+#     Information about the network configuration.
 #
 # @hubs: network hubs and their ports
 #
@@ -1417,8 +1410,7 @@
 
 ##
 # @x-query-network:
-#
-# Query the network configuration including hubs and clients.
+#     Query the network configuration including hubs and clients.
 #
 # Features:
 #
-- 
2.55.0


