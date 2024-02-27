Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98D4C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 11:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revoA-00006n-UL; Tue, 27 Feb 2024 06:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revo6-0008Vy-Ua
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revnz-0005UB-Se
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709033966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hApo3bP8JAl36Ec2KBYwXYppV1B+zlAZrfGQOhuCsXE=;
 b=DgnoUeKef5E895asdYtP/9VwMzOXjO29JskBMSYJMS9+hnfhB3sXr3uXxNT3lO/qhWjvq3
 3PLRZklc0xjO1V9Q2pstI/oQjuWlo2W4pdwRgQzpbdRH/5+0CK96kZj4TZAfsjhoh4PU1I
 yBr3NtB5lC/KSi/VsLUyw8qWUst8FT0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-ByjFKczgOiqH_Nni-5Gr0w-1; Tue,
 27 Feb 2024 06:39:22 -0500
X-MC-Unique: ByjFKczgOiqH_Nni-5Gr0w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F160381D4C4;
 Tue, 27 Feb 2024 11:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 428C0492BE3;
 Tue, 27 Feb 2024 11:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 33BEA21E66A3; Tue, 27 Feb 2024 12:39:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 kkostiuk@redhat.com
Subject: [PATCH 04/13] qapi: Move error documentation to new "Errors" sections
Date: Tue, 27 Feb 2024 12:39:12 +0100
Message-ID: <20240227113921.236097-5-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-1-armbru@redhat.com>
References: <20240227113921.236097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json     | 44 ++++++++++++++++++++++++++++++++++++++++
 qapi/block-export.json   | 23 ++++++++++++---------
 qapi/block.json          |  8 ++++++--
 qapi/machine-target.json | 35 ++++++++++++++++++++------------
 qapi/machine.json        |  6 ++++++
 qapi/misc.json           | 10 +++++++--
 qapi/net.json            | 14 ++++++++++---
 qapi/qdev.json           |  2 ++
 qapi/qom.json            |  4 ++++
 qapi/transaction.json    |  3 ++-
 qapi/ui.json             |  6 ++++++
 qapi/yank.json           |  2 ++
 12 files changed, 126 insertions(+), 31 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 22b8634422..cea46b4668 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1458,6 +1458,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 0.14
@@ -1676,6 +1678,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 0.14
@@ -1756,6 +1760,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If "device" does not exist or cannot be determined,
 #       DeviceNotFound
 #
@@ -1856,6 +1862,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If @device does not exist, DeviceNotFound
 #     - Any other error returns a GenericError.
 #
@@ -1896,6 +1904,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @device is not a valid block device, GenericError
 #
 # Since: 1.6
@@ -1923,6 +1933,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 2.3
@@ -2129,6 +2141,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @device is not a valid block device, GenericError
 #
 # Since: 1.3
@@ -2306,6 +2320,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
 #     - If @name is already taken, GenericError with an explanation
 #
@@ -2330,6 +2346,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
 #     - If @name is not found, GenericError with an explanation
 #     - if @name is frozen by an operation, GenericError
@@ -2355,6 +2373,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found, GenericError with an explanation
 #
@@ -2377,6 +2397,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found, GenericError with an explanation
 #
@@ -2399,6 +2421,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found, GenericError with an explanation
 #
@@ -2429,6 +2453,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If any bitmap in @bitmaps or @target is not found,
 #       GenericError
@@ -2471,6 +2497,8 @@
 #
 # Returns:
 #     - BlockDirtyBitmapSha256 on success
+#
+# Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found or if hashing has failed, GenericError
 #       with an explanation
@@ -2868,6 +2896,8 @@
 #
 # Returns:
 #     - Nothing on success.
+#
+# Errors:
 #     - If @device does not exist, DeviceNotFound.
 #
 # Since: 1.1
@@ -2907,6 +2937,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
 #
@@ -2952,6 +2984,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
 #
@@ -2979,6 +3013,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
 #
@@ -3004,6 +3040,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
 #
@@ -3036,6 +3074,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
 #
@@ -6072,6 +6112,8 @@
 #
 # Returns:
 #     - nothing on success
+#
+# Errors:
 #     - If @device is not a valid block device, GenericError
 #     - If any snapshot matching @name exists, or @name is empty,
 #       GenericError
@@ -6109,6 +6151,8 @@
 #
 # Returns:
 #     - SnapshotInfo on success
+#
+# Errors:
 #     - If @device is not a valid block device, GenericError
 #     - If snapshot not found, GenericError
 #     - If the format of the image used does not support it,
diff --git a/qapi/block-export.json b/qapi/block-export.json
index d9bd376b48..3919a2d5b9 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -65,7 +65,8 @@
 #     server from advertising multiple client support (since 5.2;
 #     default: 0).
 #
-# Returns: error if the server is already running.
+# Errors:
+#     - if the server is already running
 #
 # Since: 1.3
 ##
@@ -247,8 +248,9 @@
 # @deprecated: This command is deprecated.  Use @block-export-add
 #     instead.
 #
-# Returns: error if the server is not running, or export with the same
-#     name already exists.
+# Errors:
+#     - if the server is not running
+#     - if an export with the same name already exists
 #
 # Since: 1.3
 ##
@@ -294,11 +296,10 @@
 # @deprecated: This command is deprecated.  Use @block-export-del
 #     instead.
 #
-# Returns: error if
-#
-#     - the server is not running
-#     - export is not found
-#     - mode is 'safe' and there are existing connections
+# Errors:
+#     - if the server is not running
+#     - if export is not found
+#     - if mode is 'safe' and there are existing connections
 #
 # Since: 2.12
 ##
@@ -415,8 +416,10 @@
 # @mode: Mode of command operation.  See @BlockExportRemoveMode
 #     description.  Default is 'safe'.
 #
-# Returns: Error if the export is not found or @mode is 'safe' and the
-#     export is still in use (e.g. by existing client connections)
+# Errors:
+#     - if the export is not found
+#     - if @mode is 'safe' and the export is still in use (e.g. by
+#       existing client connections)
 #
 # Since: 5.2
 ##
diff --git a/qapi/block.json b/qapi/block.json
index 79a0bcc208..dab616799a 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -112,6 +112,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
 # Notes: Ejecting a device with no media results in success
@@ -461,6 +463,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 1.1
@@ -540,8 +544,8 @@
 # @boundaries-flush: list of interval boundary values for flush
 #     latency histogram.
 #
-# Returns: error if device is not found or any boundary arrays are
-#     invalid.
+# Errors:
+#     - if device is not found or any boundary arrays are invalid.
 #
 # Since: 4.0
 #
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 2c5dda735e..db6c0fae98 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -154,10 +154,13 @@
 # Some architectures may not support comparing CPU models.  s390x
 # supports comparing CPU models.
 #
-# Returns: a CpuModelBaselineInfo.  Returns an error if comparing CPU
-#     models is not supported, if a model cannot be used, if a model
-#     contains an unknown cpu definition name, unknown properties or
-#     properties with wrong types.
+# Returns: a CpuModelBaselineInfo
+#
+# Errors:
+#     - if comparing CPU models is not supported
+#     - if a model cannot be used
+#     - if a model contains an unknown cpu definition name, unknown
+#       properties or properties with wrong types.
 #
 # Note: this command isn't specific to s390x, but is only implemented
 #     on this architecture currently.
@@ -201,10 +204,13 @@
 # Some architectures may not support baselining CPU models.  s390x
 # supports baselining CPU models.
 #
-# Returns: a CpuModelBaselineInfo.  Returns an error if baselining CPU
-#     models is not supported, if a model cannot be used, if a model
-#     contains an unknown cpu definition name, unknown properties or
-#     properties with wrong types.
+# Returns: a CpuModelBaselineInfo
+#
+# Errors:
+#     - if baselining CPU models is not supported
+#     - if a model cannot be used
+#     - if a model contains an unknown cpu definition name, unknown
+#       properties or properties with wrong types.
 #
 # Note: this command isn't specific to s390x, but is only implemented
 #     on this architecture currently.
@@ -263,11 +269,14 @@
 # Some architectures may not support all expansion types.  s390x
 # supports "full" and "static". Arm only supports "full".
 #
-# Returns: a CpuModelExpansionInfo.  Returns an error if expanding CPU
-#     models is not supported, if the model cannot be expanded, if the
-#     model contains an unknown CPU definition name, unknown
-#     properties or properties with a wrong type.  Also returns an
-#     error if an expansion type is not supported.
+# Returns: a CpuModelExpansionInfo
+#
+# Errors:
+#     - if expanding CPU models is not supported
+#     - if the model cannot be expanded
+#     - if the model contains an unknown CPU definition name, unknown
+#       properties or properties with a wrong type
+#     - if an expansion type is not supported
 #
 # Since: 2.8
 ##
diff --git a/qapi/machine.json b/qapi/machine.json
index 93b4677286..0985c61740 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1062,6 +1062,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If the balloon driver is enabled but not functional because
 #       the KVM kernel module cannot support it, KVMMissingCap
 #     - If no balloon device is present, DeviceNotActive
@@ -1100,6 +1102,8 @@
 #
 # Returns:
 #     - @BalloonInfo on success
+#
+# Errors:
 #     - If the balloon driver is enabled but not functional because
 #       the KVM kernel module cannot support it, KVMMissingCap
 #     - If no balloon device is present, DeviceNotActive
@@ -1164,6 +1168,8 @@
 #
 # Returns:
 #     - @HvBalloonInfo on success
+#
+# Errors:
 #     - If no hv-balloon device is present, guest memory status
 #       reporting is not enabled or no guest memory status report
 #       received yet, GenericError
diff --git a/qapi/misc.json b/qapi/misc.json
index 11c55c2b6c..578f574a68 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -345,6 +345,8 @@
 #
 # Returns:
 #     - @AddfdInfo on success
+#
+# Errors:
 #     - If file descriptor was not received, GenericError
 #     - If @fdset-id is a negative value, GenericError
 #
@@ -376,6 +378,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If @fdset-id or @fd is not found, GenericError
 #
 # Since: 1.2
@@ -528,8 +532,10 @@
 # @option: option name
 #
 # Returns: list of @CommandLineOptionInfo for all options (or for the
-#     given @option).  Returns an error if the given @option doesn't
-#     exist.
+#     given @option).
+#
+# Errors:
+#     - if the given @option doesn't exist
 #
 # Since: 1.5
 #
diff --git a/qapi/net.json b/qapi/net.json
index 1374caac64..09e644a742 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -19,6 +19,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If @name is not a valid network device, DeviceNotFound
 #
 # Since: 0.14
@@ -46,6 +48,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If @type is not a valid network backend, DeviceNotFound
 #
 # Example:
@@ -67,6 +71,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If @id is not a valid network backend, DeviceNotFound
 #
 # Since: 0.14
@@ -828,9 +834,11 @@
 # @name: net client name
 #
 # Returns: list of @RxFilterInfo for all NICs (or for the given NIC).
-#     Returns an error if the given @name doesn't exist, or given NIC
-#     doesn't support rx-filter querying, or given net client isn't a
-#     NIC.
+#
+# Errors:
+#     - if the given @name doesn't exist
+#     - if the given NIC doesn't support rx-filter querying
+#     - if the given net client isn't a NIC
 #
 # Since: 1.6
 #
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 32ffaee644..cc72c55a99 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -91,6 +91,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If @id is not a valid device, DeviceNotFound
 #
 # Notes: When this command completes, the device may not be removed
diff --git a/qapi/qom.json b/qapi/qom.json
index 2a6e49365a..33aa30bb41 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1058,6 +1058,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - Error if @qom-type is not a valid class name
 #
 # Since: 2.0
@@ -1081,6 +1083,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - Error if @id is not a valid id for a QOM object
 #
 # Since: 2.0
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 45233ddd2a..78cc21800d 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -236,7 +236,8 @@
 #
 # Returns: nothing on success
 #
-#     Errors depend on the operations of the transaction
+# Errors:
+#     Any errors from commands in the transaction
 #
 # Note: The transaction aborts on the first failure.  Therefore, there
 #     will be information on only one failed operation returned in an
diff --git a/qapi/ui.json b/qapi/ui.json
index e3999b7c07..199a412c5a 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -80,6 +80,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If Spice is not enabled, DeviceNotFound
 #
 # Since: 0.14
@@ -142,6 +144,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If @protocol is 'spice' and Spice is not active,
 #       DeviceNotFound
 #
@@ -1038,6 +1042,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - If key is unknown or redundant, GenericError
 #
 # Since: 1.3
diff --git a/qapi/yank.json b/qapi/yank.json
index b7aeb9ceef..a457284b45 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -80,6 +80,8 @@
 #
 # Returns:
 #     - Nothing on success
+#
+# Errors:
 #     - @DeviceNotFound error, if any of the YankInstances doesn't exist
 #
 # Example:
-- 
2.43.0


