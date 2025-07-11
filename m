Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E06C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua6Xe-0001n3-Jx; Fri, 11 Jul 2025 01:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6X4-0000MW-7v
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6Wz-0000kr-56
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752212558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PRbzPaStfiycL8A4sj0sKc1UuLvhifMkMkQpJb871gM=;
 b=Zg4ueTYt6zWWKWJBcj8N+pkLXzmHp+gnPdDfTCCt3j5fUOl+pnmU1+upk89nllqLFuC94v
 aAsFTV0Ou1GOte+ZTyRnyi3ZrSIFbYN+dRyXkhAjHNaa4sWlTWwBQT1uMwVmyGU5H9vsGg
 kyFzA/2/dpW7Oa+oxvaxXp+E9NYDCP4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-7hMWNG9aP8WwL0ZZ8u4Ukg-1; Fri,
 11 Jul 2025 01:42:27 -0400
X-MC-Unique: 7hMWNG9aP8WwL0ZZ8u4Ukg-1
X-Mimecast-MFC-AGG-ID: 7hMWNG9aP8WwL0ZZ8u4Ukg_1752212546
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 303781800366; Fri, 11 Jul 2025 05:42:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3E7F1800285; Fri, 11 Jul 2025 05:42:18 +0000 (UTC)
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
Subject: [PATCH v2 17/18] qapi: add cross-references to yank.json
Date: Fri, 11 Jul 2025 01:40:04 -0400
Message-ID: <20250711054005.60969-18-jsnow@redhat.com>
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
Acked-by: Lukas Straub <lukasstraub2@web.de>
---
 qapi/yank.json | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/yank.json b/qapi/yank.json
index 5f26d6c0149..f1b737e87d6 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -9,7 +9,7 @@
 ##
 # @YankInstanceType:
 #
-# An enumeration of yank instance types.  See @YankInstance for more
+# An enumeration of yank instance types.  See `YankInstance` for more
 # information.
 #
 # Since: 6.0
@@ -20,7 +20,7 @@
 ##
 # @YankInstanceBlockNode:
 #
-# Specifies which block graph node to yank.  See @YankInstance for
+# Specifies which block graph node to yank.  See `YankInstance` for
 # more information.
 #
 # @node-name: the name of the block graph node
@@ -33,7 +33,7 @@
 ##
 # @YankInstanceChardev:
 #
-# Specifies which character device to yank.  See @YankInstance for
+# Specifies which character device to yank.  See `YankInstance` for
 # more information.
 #
 # @id: the chardev's ID
@@ -46,7 +46,7 @@
 ##
 # @YankInstance:
 #
-# A yank instance can be yanked with the @yank qmp command to recover
+# A yank instance can be yanked with the `yank` qmp command to recover
 # from a hanging QEMU.
 #
 # @type: yank instance type
@@ -57,9 +57,9 @@
 #   nbd server without attempting to reconnect.
 # - socket chardev: Yanking it will shut down the connected socket.
 # - migration: Yanking it will shut down all migration connections.
-#   Unlike @migrate_cancel, it will not notify the migration process,
+#   Unlike `migrate_cancel`, it will not notify the migration process,
 #   so migration will go into @failed state, instead of @cancelled
-#   state.  @yank should be used to recover from hangs.
+#   state.  `yank` should be used to recover from hangs.
 #
 # Since: 6.0
 ##
@@ -74,7 +74,7 @@
 # @yank:
 #
 # Try to recover from hanging QEMU by yanking the specified instances.
-# See @YankInstance for more information.
+# See `YankInstance` for more information.
 #
 # @instances: the instances to be yanked
 #
@@ -100,7 +100,7 @@
 ##
 # @query-yank:
 #
-# Query yank instances.  See @YankInstance for more information.
+# Query yank instances.  See `YankInstance` for more information.
 #
 # TODO: This line is a hack to separate the example from the body
 #
-- 
2.50.0


