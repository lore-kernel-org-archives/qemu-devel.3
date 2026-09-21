Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7575C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kzu-00079R-JH; Mon, 21 Sep 2026 16:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8kzq-00078s-P2
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8kzh-0002Nf-DO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790023928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S89AtTXdNpjr2AAqPJOd1mhSmMhfH8axiJcWiyBL6aI=;
 b=WS6Ymx8fDu+X5+//7vQbV9n1E6GT74auqr6KswnYmM/7CrkJog3OkizsUB3JHxUccjIlY5
 OXwjUhOhEbGZ86NsnEhQgFDS6JXpWqiOUd56p4RNR+oT8c5u92UO9pMin8j+AoFWmVCk/P
 DxvvnMyiwt6OxgltHuV8nOUZ2Ves23A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-fm4X7OtoPS6Rw-PmPkij-g-1; Mon,
 21 Sep 2026 16:52:05 -0400
X-MC-Unique: fm4X7OtoPS6Rw-PmPkij-g-1
X-Mimecast-MFC-AGG-ID: fm4X7OtoPS6Rw-PmPkij-g_1790023923
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2B8418558AD; Mon, 21 Sep 2026 20:52:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D32C41B; Mon, 21 Sep 2026 20:51:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 1/9] qapi: convert remaining simple sections
Date: Mon, 21 Sep 2026 16:51:39 -0400
Message-ID: <20260921205147.1857168-2-jsnow@redhat.com>
In-Reply-To: <20260921205147.1857168-1-jsnow@redhat.com>
References: <20260921205147.1857168-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A few slipped in during the mass conversion, get those too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block.json         |  5 ++---
 qapi/machine-s390x.json |  3 +--
 qapi/machine.json       |  3 +--
 qapi/net.json           | 24 ++++++++----------------
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 13c47e1eb44..68d4e47d911 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -597,9 +597,8 @@
 
 ##
 # @x-qemu-io:
-#
-# Run a qemu-io command on a block device.  Take either a block
-# backend name or a qdev ID to identify the device.
+#     Run a qemu-io command on a block device.  Take either a block
+#     backend name or a qdev ID to identify the device.
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


