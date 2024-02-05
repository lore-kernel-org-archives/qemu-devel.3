Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00294C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWtiC-0003MK-E8; Mon, 05 Feb 2024 02:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthN-00033G-RE
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthG-000650-B4
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nisO7NDwANGkx/Ygd8b0iE9B6pGSK738IZE8IpZHy1Y=;
 b=buGNb+OS9oMinG/Sk28L01J0wDSiNG1rk7/t6dt0M/mfnfnctPAGoMXoV8T2vyFBBhTFWj
 J60p/GfWajUUHQVo2oHCH0qCf6NAyXn6euQxjfNzZb4nmvDll31mhmB9zHP8fkzg7F5xte
 kwd3/MySmyisQLIgyn9a4PX9CCxYTQY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-LQPSFQAgMtOrJsU66NZ-3Q-1; Mon,
 05 Feb 2024 02:47:14 -0500
X-MC-Unique: LQPSFQAgMtOrJsU66NZ-3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 445361C54463;
 Mon,  5 Feb 2024 07:47:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0177A1121313;
 Mon,  5 Feb 2024 07:47:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 71FD121E5A5B; Mon,  5 Feb 2024 08:47:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, fan.ni@samsung.com,
 farosas@suse.de, hreitz@redhat.com, jasowang@redhat.com, jiri@resnulli.us,
 jonathan.cameron@huawei.com, kkostiuk@redhat.com, kraxel@redhat.com,
 kwolf@redhat.com, lukasstraub2@web.de, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, qemu-block@nongnu.org,
 stefanb@linux.ibm.com, wangyanan55@huawei.com
Subject: [PATCH 15/15] qapi: Add missing union tag documentation
Date: Mon,  5 Feb 2024 08:47:09 +0100
Message-ID: <20240205074709.3613229-16-armbru@redhat.com>
In-Reply-To: <20240205074709.3613229-1-armbru@redhat.com>
References: <20240205074709.3613229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Low-hanging fruit, and except for StatsFilter, the only members of
these unions lacking documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json   | 12 ++++++++++++
 qapi/block-export.json |  2 ++
 qapi/char.json         |  2 ++
 qapi/crypto.json       |  2 ++
 qapi/machine.json      |  4 ++++
 qapi/migration.json    |  2 ++
 qapi/pragma.json       | 16 ----------------
 qapi/sockets.json      |  2 ++
 qapi/stats.json        |  2 ++
 qapi/transaction.json  |  2 ++
 qapi/ui.json           |  2 ++
 qapi/yank.json         |  2 ++
 12 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 55b583f079..ded6437c06 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -252,6 +252,8 @@
 # A discriminated record of image format specific information
 # structures.
 #
+# @type: block driver name
+#
 # Since: 1.7
 ##
 { 'union': 'ImageInfoSpecific',
@@ -1102,6 +1104,8 @@
 #
 # Block driver specific statistics
 #
+# @driver: block driver name
+#
 # Since: 4.2
 ##
 { 'union': 'BlockStatsSpecific',
@@ -3472,6 +3476,8 @@
 ##
 # @BlockdevQcowEncryption:
 #
+# @format: encryption format
+#
 # Since: 2.10
 ##
 { 'union': 'BlockdevQcowEncryption',
@@ -3506,6 +3512,8 @@
 ##
 # @BlockdevQcow2Encryption:
 #
+# @format: encryption format
+#
 # Since: 2.10
 ##
 { 'union': 'BlockdevQcow2Encryption',
@@ -3656,6 +3664,8 @@
 ##
 # @SshHostKeyCheck:
 #
+# @mode: How to check the host key
+#
 # Since: 2.12
 ##
 { 'union': 'SshHostKeyCheck',
@@ -4225,6 +4235,8 @@
 ##
 # @RbdEncryptionCreateOptions:
 #
+# @format: Encryption format.
+#
 # Since: 6.1
 ##
 { 'union': 'RbdEncryptionCreateOptions',
diff --git a/qapi/block-export.json b/qapi/block-export.json
index e063e9255a..d9bd376b48 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -346,6 +346,8 @@
 # Describes a block export, i.e. how single node should be exported on
 # an external interface.
 #
+# @type: Block export type
+#
 # @id: A unique identifier for the block export (across all export
 #     types)
 #
diff --git a/qapi/char.json b/qapi/char.json
index e3e1b2c9f5..390e3ef1b9 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -634,6 +634,8 @@
 #
 # Configuration info for the new chardev backend.
 #
+# @type: backend type
+#
 # Since: 1.4
 ##
 { 'union': 'ChardevBackend',
diff --git a/qapi/crypto.json b/qapi/crypto.json
index fd3d46ebd1..03de66e6f6 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -645,6 +645,8 @@
 # The options that are available for all asymmetric key algorithms
 # when creating a new QCryptoAkCipher.
 #
+# @alg: encryption cipher algorithm
+#
 # Since: 7.1
 ##
 { 'union': 'QCryptoAkCipherOptions',
diff --git a/qapi/machine.json b/qapi/machine.json
index 6a25e39f44..d816c5c02e 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -443,6 +443,8 @@
 #
 # A discriminated record of NUMA options.  (for OptsVisitor)
 #
+# @type: NUMA option type
+#
 # Since: 2.1
 ##
 { 'union': 'NumaOptions',
@@ -1448,6 +1450,8 @@
 #
 # Union containing information about a memory device
 #
+# @type: memory device type
+#
 # Since: 2.1
 ##
 { 'union': 'MemoryDeviceInfo',
diff --git a/qapi/migration.json b/qapi/migration.json
index bf89765a26..7c8881abda 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1630,6 +1630,8 @@
 #
 # Migration endpoint configuration.
 #
+# @transport: The migration stream transport mechanism
+#
 # Since: 8.2
 ##
 { 'union': 'MigrationAddress',
diff --git a/qapi/pragma.json b/qapi/pragma.json
index d5e3f6f142..7ac05ccc26 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -39,18 +39,13 @@
         'BlockDirtyBitmapAddWrapper',
         'BlockDirtyBitmapMergeWrapper',
         'BlockDirtyBitmapWrapper',
-        'BlockExportOptions',
-        'BlockStatsSpecific',
         'BlockdevBackupWrapper',
         'BlockdevDriver',
-        'BlockdevQcow2Encryption',
         'BlockdevQcow2EncryptionFormat',
-        'BlockdevQcowEncryption',
         'BlockdevSnapshotInternalWrapper',
         'BlockdevSnapshotSyncWrapper',
         'BlockdevSnapshotWrapper',
         'BlockdevVmdkAdapterType',
-        'ChardevBackend',
         'ChardevBackendKind',
         'CpuS390Entitlement',
         'CpuS390Polarization',
@@ -64,7 +59,6 @@
         'GrabToggleKeys',
         'GuestPanicInformationHyperV',
         'HotKeyMod',
-        'ImageInfoSpecific',
         'ImageInfoSpecificKind',
         'InputAxis',
         'InputButton',
@@ -73,38 +67,28 @@
         'IscsiHeaderDigest',
         'IscsiTransport',
         'JSONType',
-        'KeyValue',
         'KeyValueKind',
-        'MemoryDeviceInfo',
         'MemoryDeviceInfoKind',
         'MigrateSetParameters',
-        'MigrationAddress',
         'NetClientDriver',
-        'NumaOptions',
         'ObjectType',
         'PciMemoryRegion',
         'QCryptoAkCipherKeyType',
-        'QCryptoAkCipherOptions',
         'QCryptodevBackendServiceType',
         'QKeyCode',
         'Qcow2OverlapCheckFlags',
         'RbdAuthMode',
-        'RbdEncryptionCreateOptions',
         'RbdImageEncryptionFormat',
-        'SocketAddressLegacy',
-        'SshHostKeyCheck',
         'StatsFilter',
         'StatsValue',
         'String',
         'StringWrapper',
         'SysEmuTarget',
         'ThrottleGroupProperties',
-        'TransactionAction',
         'VncPrimaryAuth',
         'VncVencryptSubAuth',
         'X86CPURegister32',
         'XDbgBlockGraph',
-        'YankInstance',
         'YankInstanceType',
         'blockdev-reopen',
         'query-cpu-model-baseline',
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 5e6af5504d..ef777928e7 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -178,6 +178,8 @@
 # Captures the address of a socket, which could also be a named file
 # descriptor
 #
+# @type: Transport type
+#
 # Note: This type is deprecated in favor of SocketAddress.  The
 #     difference between SocketAddressLegacy and SocketAddress is that
 #     the latter has fewer {} on the wire.
diff --git a/qapi/stats.json b/qapi/stats.json
index 01791e86d5..ce9d8161ec 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -120,6 +120,8 @@
 # - which providers to request statistics from
 # - which named values to return within each provider
 #
+# @target: the kind of objects to query
+#
 # Since: 7.1
 ##
 { 'union': 'StatsFilter',
diff --git a/qapi/transaction.json b/qapi/transaction.json
index cffee2de28..7a95c081e9 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -158,6 +158,8 @@
 # A discriminated record of operations that can be performed with
 # @transaction.
 #
+# @type: the operation to be performed
+#
 # Since: 1.1
 ##
 { 'union': 'TransactionAction',
diff --git a/qapi/ui.json b/qapi/ui.json
index 1eccad0a83..b6d7e142b7 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1012,6 +1012,8 @@
 #
 # Represents a keyboard key.
 #
+# @type: key encoding
+#
 # Since: 1.3
 ##
 { 'union': 'KeyValue',
diff --git a/qapi/yank.json b/qapi/yank.json
index bfc71a07a6..ee038a11a1 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -49,6 +49,8 @@
 # A yank instance can be yanked with the @yank qmp command to recover
 # from a hanging QEMU.
 #
+# @type: yank instance type
+#
 # Currently implemented yank instances:
 #
 # - nbd block device: Yanking it will shut down the connection to the
-- 
2.43.0


