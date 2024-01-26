Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DCFC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 06:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTFh7-0005Hi-Vb; Fri, 26 Jan 2024 01:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTFgx-0005Bn-Cj
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 01:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTFgt-0001l0-EN
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 01:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706250469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cp8ZxzKkqZpsj6SYD+QlYEtdgZx10sRCQ+x/2og0xPs=;
 b=TdXa9V7/gNhvcPPM8KULi2iM97FJUlDrdKvGuFMo7uCe/r/9yi8BFERuJZXiCqlR6vrWGb
 W/KGIsBlpEIuh+qcL1f81m0F5cRjLksIW9Ak5hzgRxFyoH7z5rlevbdGisZnHmUMBmH3rn
 0NOn2Rg24pwPb01YwPPn4S8b6Kj+ZXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-OSzW6yY-M7aUAP_rD7smIw-1; Fri, 26 Jan 2024 01:27:47 -0500
X-MC-Unique: OSzW6yY-M7aUAP_rD7smIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38F0983B82A;
 Fri, 26 Jan 2024 06:27:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 172D9200A08E;
 Fri, 26 Jan 2024 06:27:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB5DD21E64DA; Fri, 26 Jan 2024 07:27:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 8/8] qapi: Fix malformed "Since:" section tags (again)
Date: Fri, 26 Jan 2024 07:27:44 +0100
Message-ID: <20240126062744.265588-9-armbru@redhat.com>
In-Reply-To: <20240126062744.265588-1-armbru@redhat.com>
References: <20240126062744.265588-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Since X.Y" is not recognized as a tagged section, and therefore not
formatted as such in generated documentation.  Fix by adding the
required colon.

Previously fixed in commit 433a4fdc420 (qapi: Fix malformed "Since:"
section tags)

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240120095327.666239-8-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json |  4 ++--
 qapi/migration.json  | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ca390c5700..3919156d49 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1361,7 +1361,7 @@
 #     target, i.e. same data and new writes are done synchronously to
 #     both.
 #
-# Since 8.2
+# Since: 8.2
 ##
 { 'struct': 'BlockJobInfoMirror',
   'data': { 'actively-synced': 'bool' } }
@@ -3080,7 +3080,7 @@
 #
 # @type: The job type
 #
-# Since 8.2
+# Since: 8.2
 ##
 { 'union': 'BlockJobChangeOptions',
   'base': { 'id': 'str', 'type': 'JobType' },
diff --git a/qapi/migration.json b/qapi/migration.json
index eb2f883513..489b591c23 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1597,7 +1597,7 @@
 #
 # @file: Direct the migration stream to a file.
 #
-# Since 8.2
+# Since: 8.2
 ##
 { 'enum': 'MigrationAddressType',
   'data': [ 'socket', 'exec', 'rdma', 'file' ] }
@@ -1609,7 +1609,7 @@
 #
 # @offset: The file offset where the migration stream will start
 #
-# Since 8.2
+# Since: 8.2
 ##
 { 'struct': 'FileMigrationArgs',
   'data': { 'filename': 'str',
@@ -1620,7 +1620,7 @@
 #
 # @args: command (list head) and arguments to execute.
 #
-# Since 8.2
+# Since: 8.2
 ##
 { 'struct': 'MigrationExecCommand',
   'data': {'args': [ 'str' ] } }
@@ -1630,7 +1630,7 @@
 #
 # Migration endpoint configuration.
 #
-# Since 8.2
+# Since: 8.2
 ##
 { 'union': 'MigrationAddress',
   'base': { 'transport' : 'MigrationAddressType'},
@@ -1648,7 +1648,7 @@
 #
 # @main: Main outbound migration channel.
 #
-# Since 8.1
+# Since: 8.1
 ##
 { 'enum': 'MigrationChannelType',
   'data': [ 'main' ] }
@@ -1662,7 +1662,7 @@
 #
 # @addr: Migration endpoint configuration on destination interface.
 #
-# Since 8.1
+# Since: 8.1
 ##
 { 'struct': 'MigrationChannel',
   'data': {
@@ -2126,7 +2126,7 @@
 #
 # @millisecond: value is in milliseconds
 #
-# Since 8.2
+# Since: 8.2
 #
 ##
 { 'enum': 'TimeUnit',
-- 
2.43.0


