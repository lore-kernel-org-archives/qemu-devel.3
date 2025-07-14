Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920C6C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKq9-0005Iw-MU; Mon, 14 Jul 2025 11:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUr-0000RX-3B
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUa-0003ds-Ko
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gu0Nw++4SHJ8XHnnfrFj2RqSLlAToFmeOtmbH8TIShk=;
 b=f1iSGj0D8ylXEdK/K7Bt1tGifFofVaivD3c7KIMityimFUv/mIGbUC1ddP4i+oW2IysMkr
 Uu3sEwDy9Xmk2r4lOR9H7dGMsTjnK8Xfrp/gojVy0bSOKjHaJqHeGitcxg9Pw+zlACjIPP
 7PsRj3vLJbASvRg51MD3e0BqnHooNdQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631--JazQtFrPjO2jY91WI6GnQ-1; Mon,
 14 Jul 2025 09:45:10 -0400
X-MC-Unique: -JazQtFrPjO2jY91WI6GnQ-1
X-Mimecast-MFC-AGG-ID: -JazQtFrPjO2jY91WI6GnQ_1752500708
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D38DF19560AA
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DD17195609D
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0ACE521E6617; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 18/32] qapi: add cross-references to Machine core
Date: Mon, 14 Jul 2025 15:44:44 +0200
Message-ID: <20250714134458.2991097-19-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711054005.60969-8-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine-common.json | 20 +++++-----
 qapi/machine.json        | 80 ++++++++++++++++++++--------------------
 2 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index 0f01599130..ed3d20a2fb 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -28,29 +28,29 @@
 #
 # @thread: thread level, which would also be called SMT level or
 #     logical processor level.  The @threads option in
-#     SMPConfiguration is used to configure the topology of this
+#     `SMPConfiguration` is used to configure the topology of this
 #     level.
 #
-# @core: core level.  The @cores option in SMPConfiguration is used
+# @core: core level.  The @cores option in `SMPConfiguration` is used
 #     to configure the topology of this level.
 #
-# @module: module level.  The @modules option in SMPConfiguration is
+# @module: module level.  The @modules option in `SMPConfiguration` is
 #     used to configure the topology of this level.
 #
-# @cluster: cluster level.  The @clusters option in SMPConfiguration
+# @cluster: cluster level.  The @clusters option in `SMPConfiguration`
 #     is used to configure the topology of this level.
 #
-# @die: die level.  The @dies option in SMPConfiguration is used to
+# @die: die level.  The @dies option in `SMPConfiguration` is used to
 #     configure the topology of this level.
 #
 # @socket: socket level, which would also be called package level.
-#     The @sockets option in SMPConfiguration is used to configure
+#     The @sockets option in `SMPConfiguration` is used to configure
 #     the topology of this level.
 #
-# @book: book level.  The @books option in SMPConfiguration is used
+# @book: book level.  The @books option in `SMPConfiguration` is used
 #     to configure the topology of this level.
 #
-# @drawer: drawer level.  The @drawers option in SMPConfiguration is
+# @drawer: drawer level.  The @drawers option in `SMPConfiguration` is
 #     used to configure the topology of this level.
 #
 # @default: default level.  Some architectures will have default
@@ -104,9 +104,9 @@
 ##
 # @SmpCachePropertiesWrapper:
 #
-# List wrapper of SmpCacheProperties.
+# List wrapper of `SmpCacheProperties`.
 #
-# @caches: the list of SmpCacheProperties.
+# @caches: the list of `SmpCacheProperties`.
 #
 # Since 9.2
 ##
diff --git a/qapi/machine.json b/qapi/machine.json
index 2364893cba..f9bfda2151 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -188,7 +188,7 @@
 # @acpi: machine type supports ACPI (since 8.0)
 #
 # @compat-props: The machine type's compatibility properties.  Only
-#     present when query-machines argument @compat-props is true.
+#     present when `query-machines` argument @compat-props is true.
 #     (since 9.1)
 #
 # Features:
@@ -377,7 +377,7 @@
 #
 # Wake up guest from suspend.  If the guest has wake-up from suspend
 # support enabled (wakeup-suspend-support flag from
-# query-current-machine), wake-up guest from suspend if the guest is
+# `query-current-machine`), wake-up guest from suspend if the guest is
 # in SUSPENDED state.  Return an error otherwise.
 #
 # Since: 1.1
@@ -589,7 +589,7 @@
 #
 # List of CXL Fixed Memory Windows.
 #
-# @cxl-fmw: List of CXLFixedMemoryWindowOptions
+# @cxl-fmw: List of `CXLFixedMemoryWindowOptions`
 #
 # Since: 7.1
 ##
@@ -644,10 +644,10 @@
 ##
 # @NumaCpuOptions:
 #
-# Option "-numa cpu" overrides default cpu to node mapping.  It
-# accepts the same set of cpu properties as returned by
-# query-hotpluggable-cpus[].props, where node-id could be used to
-# override default node mapping.
+# Option "-numa cpu" overrides default cpu to node mapping.  It accepts
+# the same set of cpu properties as returned by
+# `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`, where
+# node-id could be used to override default node mapping.
 #
 # Since: 2.10
 ##
@@ -661,7 +661,7 @@
 # The memory hierarchy in the System Locality Latency and Bandwidth
 # Information Structure of HMAT (Heterogeneous Memory Attribute Table)
 #
-# For more information about @HmatLBMemoryHierarchy, see chapter
+# For more information about `HmatLBMemoryHierarchy`, see chapter
 # 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
 #
 # @memory: the structure represents the memory performance
@@ -683,7 +683,7 @@
 # Data type in the System Locality Latency and Bandwidth Information
 # Structure of HMAT (Heterogeneous Memory Attribute Table)
 #
-# For more information about @HmatLBDataType, see chapter 5.2.27.4:
+# For more information about `HmatLBDataType`, see chapter 5.2.27.4:
 # Table 5-146: Field "Data Type" of ACPI 6.3 spec.
 #
 # @access-latency: access latency (nanoseconds)
@@ -710,7 +710,7 @@
 # Set the system locality latency and bandwidth information between
 # Initiator and Target proximity Domains.
 #
-# For more information about @NumaHmatLBOptions, see chapter 5.2.27.4:
+# For more information about `NumaHmatLBOptions`, see chapter 5.2.27.4:
 # Table 5-146 of ACPI 6.3 spec.
 #
 # @initiator: the Initiator Proximity Domain.
@@ -746,7 +746,7 @@
 # Cache associativity in the Memory Side Cache Information Structure
 # of HMAT
 #
-# For more information of @HmatCacheAssociativity, see chapter
+# For more information of `HmatCacheAssociativity`, see chapter
 # 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
 #
 # @none: None (no memory side cache in this proximity domain, or cache
@@ -767,7 +767,7 @@
 # Cache write policy in the Memory Side Cache Information Structure of
 # HMAT
 #
-# For more information of @HmatCacheWritePolicy, see chapter 5.2.27.5:
+# For more information of `HmatCacheWritePolicy`, see chapter 5.2.27.5:
 # Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
 #
 # @none: None (no memory side cache in this proximity domain, or cache
@@ -787,7 +787,7 @@
 #
 # Set the memory side cache information for a given memory domain.
 #
-# For more information of @NumaHmatCacheOptions, see chapter 5.2.27.5:
+# For more information of `NumaHmatCacheOptions`, see chapter 5.2.27.5:
 # Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
 #
 # @node-id: the memory proximity domain to which the memory belongs.
@@ -964,7 +964,7 @@
 #
 # The ids other than the node-id specify the position of the CPU
 # within the CPU topology (as defined by the machine property "smp",
-# thus see also type @SMPConfiguration)
+# thus see also type `SMPConfiguration`)
 #
 # @node-id: NUMA node ID the CPU belongs to
 #
@@ -992,7 +992,7 @@
 # Since: 2.7
 ##
 { 'struct': 'CpuInstanceProperties',
-  # Keep these in sync with the properties device_add accepts
+  # Keep these in sync with the properties `device_add` accepts
   'data': { '*node-id': 'int',
             '*drawer-id': 'int',
             '*book-id': 'int',
@@ -1008,19 +1008,19 @@
 ##
 # @HotpluggableCPU:
 #
-# @type: CPU object type for usage with device_add command
+# @type: CPU object type for usage with `device_add` command
 #
 # @props: list of properties to pass for hotplugging a CPU with
-#     device_add
+#     `device_add`
 #
-# @vcpus-count: number of logical VCPU threads @HotpluggableCPU
+# @vcpus-count: number of logical VCPU threads `HotpluggableCPU`
 #     provides
 #
 # @qom-path: link to existing CPU object if CPU is present or omitted
 #     if CPU is not present.
 #
 # .. note:: Management should be prepared to pass through additional
-#    properties with device_add.
+#    properties with `device_add`.
 #
 # Since: 2.7
 ##
@@ -1179,7 +1179,7 @@
 # @BALLOON_CHANGE:
 #
 # Emitted when the guest changes the actual BALLOON level.  This value
-# is equivalent to the @actual field return by the 'query-balloon'
+# is equivalent to the @actual field return by the `query-balloon`
 # command
 #
 # @actual: the logical size of the VM in bytes.  Formula used:
@@ -1965,7 +1965,7 @@
 #
 # The result of a CPU model baseline.
 #
-# @model: the baselined CpuModelInfo.
+# @model: the baselined `CpuModelInfo`.
 #
 # Since: 2.8
 ##
@@ -2014,28 +2014,28 @@
 #
 # * QEMU version: CPU models may look different depending on the QEMU
 #   version.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
+#   `query-cpu-definitions`.)
 # * machine-type: CPU model may look different depending on the
 #   machine-type.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
+#   `query-cpu-definitions`.)
 # * machine options (including accelerator): in some architectures,
 #   CPU models may look different depending on machine and accelerator
 #   options.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
+#   `query-cpu-definitions`.)
 # * "-cpu" arguments and global properties: arguments to the -cpu
 #   option and global properties may affect expansion of CPU models.
-#   Using query-cpu-model-expansion while using these is not advised.
+#   Using `query-cpu-model-expansion` while using these is not advised.
 #
 # Some architectures may not support comparing CPU models.  s390x
 # supports comparing CPU models.
 #
 # @modela: description of the first CPU model to compare, referred to
-#     as "model A" in CpuModelCompareResult
+#     as "model A" in `CpuModelCompareResult`
 #
 # @modelb: description of the second CPU model to compare, referred to
-#     as "model B" in CpuModelCompareResult
+#     as "model B" in `CpuModelCompareResult`
 #
-# Returns: a CpuModelCompareInfo describing how both CPU models
+# Returns: a `CpuModelCompareInfo` describing how both CPU models
 #     compare
 #
 # Errors:
@@ -2068,17 +2068,17 @@
 #
 # * QEMU version: CPU models may look different depending on the QEMU
 #   version.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
+#   `query-cpu-definitions`.)
 # * machine-type: CPU model may look different depending on the
 #   machine-type.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
+#   `query-cpu-definitions`.)
 # * machine options (including accelerator): in some architectures,
 #   CPU models may look different depending on machine and accelerator
 #   options.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
+#   `query-cpu-definitions`.)
 # * "-cpu" arguments and global properties: arguments to the -cpu
 #   option and global properties may affect expansion of CPU models.
-#   Using query-cpu-model-expansion while using these is not advised.
+#   Using `query-cpu-model-expansion` while using these is not advised.
 #
 # Some architectures may not support baselining CPU models.  s390x
 # supports baselining CPU models.
@@ -2087,7 +2087,7 @@
 #
 # @modelb: description of the second CPU model to baseline
 #
-# Returns: a CpuModelBaselineInfo describing the baselined CPU model
+# Returns: a `CpuModelBaselineInfo` describing the baselined CPU model
 #
 # Errors:
 #     - if baselining CPU models is not supported by the target
@@ -2107,7 +2107,7 @@
 #
 # The result of a cpu model expansion.
 #
-# @model: the expanded CpuModelInfo.
+# @model: the expanded `CpuModelInfo`.
 #
 # @deprecated-props: an optional list of properties that are flagged as
 #     deprecated by the CPU vendor.  The list depends on the
@@ -2136,17 +2136,17 @@
 #
 # * QEMU version: CPU models may look different depending on the QEMU
 #   version.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
+#   `query-cpu-definitions`.)
 # * machine-type: CPU model may look different depending on the
 #   machine-type.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
+#   `query-cpu-definitions`.)
 # * machine options (including accelerator): in some architectures,
 #   CPU models may look different depending on machine and accelerator
 #   options.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
+#   `query-cpu-definitions`.)
 # * "-cpu" arguments and global properties: arguments to the -cpu
 #   option and global properties may affect expansion of CPU models.
-#   Using query-cpu-model-expansion while using these is not advised.
+#   Using `query-cpu-model-expansion` while using these is not advised.
 #
 # Some architectures may not support all expansion types.  s390x
 # supports "full" and "static".  Arm only supports "full".
@@ -2155,7 +2155,7 @@
 #
 # @type: expansion type, specifying how to expand the CPU model
 #
-# Returns: a CpuModelExpansionInfo describing the expanded CPU model
+# Returns: a `CpuModelExpansionInfo` describing the expanded CPU model
 #
 # Errors:
 #     - if expanding CPU models is not supported
@@ -2194,7 +2194,7 @@
 #     from running in the current host.  (since 2.8)
 #
 # @typename: Type name that can be used as argument to
-#     @device-list-properties, to introspect properties configurable
+#     `device-list-properties`, to introspect properties configurable
 #     using -cpu or -global.  (since 2.9)
 #
 # @alias-of: Name of CPU model this model is an alias for.  The target
-- 
2.49.0


