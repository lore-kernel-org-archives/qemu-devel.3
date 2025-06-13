Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A198DC7114A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 20:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQB9j-0002ZV-Uu; Fri, 13 Jun 2025 16:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQB9W-0002RW-Lv
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQB9U-00057P-CR
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749847047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vqchYLPDttKtUQMO8KfLbliSrBbXWpIklnlSkfI99yI=;
 b=Ax50Se+s/ni7Kw2soAOWvqkxJUBbTrcK7JnJAJJDSs9UmKtL7V9z8iK8U5Uvjb2motd+8m
 +OUv2GUEd5CEiRcUdpk/EJZnw2Spur2ZUiCsNIcSmlTVSp9cQsrz8rDCP7wMDRJhCNZn5g
 SR58lgHEv8w6hzDl6g+tomqpB2lfDuc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-Ssm1gxv4O3Wh1j_xLUibLQ-1; Fri,
 13 Jun 2025 16:37:24 -0400
X-MC-Unique: Ssm1gxv4O3Wh1j_xLUibLQ-1
X-Mimecast-MFC-AGG-ID: Ssm1gxv4O3Wh1j_xLUibLQ_1749847042
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7828418002ED; Fri, 13 Jun 2025 20:37:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.203])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B30230044CC; Fri, 13 Jun 2025 20:37:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 07/18] qapi: add cross-references to Machine core
Date: Fri, 13 Jun 2025 16:36:09 -0400
Message-ID: <20250613203620.1283814-8-jsnow@redhat.com>
In-Reply-To: <20250613203620.1283814-1-jsnow@redhat.com>
References: <20250613203620.1283814-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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
---
 qapi/machine-common.json |  20 ++++----
 qapi/machine.json        | 100 +++++++++++++++++++--------------------
 2 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index 298e51f373a..a9f56cbbb43 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -26,29 +26,29 @@
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
@@ -102,9 +102,9 @@
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
index 6aa8abe6cce..a18c23a273c 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -186,7 +186,7 @@
 # @acpi: machine type supports ACPI (since 8.0)
 #
 # @compat-props: The machine type's compatibility properties.  Only
-#     present when query-machines argument @compat-props is true.
+#     present when `query-machines` argument @compat-props is true.
 #     (since 9.1)
 #
 # Features:
@@ -375,7 +375,7 @@
 #
 # Wake up guest from suspend.  If the guest has wake-up from suspend
 # support enabled (wakeup-suspend-support flag from
-# query-current-machine), wake-up guest from suspend if the guest is
+# `query-current-machine`), wake-up guest from suspend if the guest is
 # in SUSPENDED state.  Return an error otherwise.
 #
 # Since: 1.1
@@ -587,7 +587,7 @@
 #
 # List of CXL Fixed Memory Windows.
 #
-# @cxl-fmw: List of CXLFixedMemoryWindowOptions
+# @cxl-fmw: List of `CXLFixedMemoryWindowOptions`
 #
 # Since: 7.1
 ##
@@ -642,10 +642,10 @@
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
@@ -659,7 +659,7 @@
 # The memory hierarchy in the System Locality Latency and Bandwidth
 # Information Structure of HMAT (Heterogeneous Memory Attribute Table)
 #
-# For more information about @HmatLBMemoryHierarchy, see chapter
+# For more information about `HmatLBMemoryHierarchy`, see chapter
 # 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
 #
 # @memory: the structure represents the memory performance
@@ -681,7 +681,7 @@
 # Data type in the System Locality Latency and Bandwidth Information
 # Structure of HMAT (Heterogeneous Memory Attribute Table)
 #
-# For more information about @HmatLBDataType, see chapter 5.2.27.4:
+# For more information about `HmatLBDataType`, see chapter 5.2.27.4:
 # Table 5-146: Field "Data Type" of ACPI 6.3 spec.
 #
 # @access-latency: access latency (nanoseconds)
@@ -708,7 +708,7 @@
 # Set the system locality latency and bandwidth information between
 # Initiator and Target proximity Domains.
 #
-# For more information about @NumaHmatLBOptions, see chapter 5.2.27.4:
+# For more information about `NumaHmatLBOptions`, see chapter 5.2.27.4:
 # Table 5-146 of ACPI 6.3 spec.
 #
 # @initiator: the Initiator Proximity Domain.
@@ -744,7 +744,7 @@
 # Cache associativity in the Memory Side Cache Information Structure
 # of HMAT
 #
-# For more information of @HmatCacheAssociativity, see chapter
+# For more information of `HmatCacheAssociativity`, see chapter
 # 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
 #
 # @none: None (no memory side cache in this proximity domain, or cache
@@ -765,7 +765,7 @@
 # Cache write policy in the Memory Side Cache Information Structure of
 # HMAT
 #
-# For more information of @HmatCacheWritePolicy, see chapter 5.2.27.5:
+# For more information of `HmatCacheWritePolicy`, see chapter 5.2.27.5:
 # Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
 #
 # @none: None (no memory side cache in this proximity domain, or cache
@@ -785,7 +785,7 @@
 #
 # Set the memory side cache information for a given memory domain.
 #
-# For more information of @NumaHmatCacheOptions, see chapter 5.2.27.5:
+# For more information of `NumaHmatCacheOptions`, see chapter 5.2.27.5:
 # Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
 #
 # @node-id: the memory proximity domain to which the memory belongs.
@@ -962,7 +962,7 @@
 #
 # The ids other than the node-id specify the position of the CPU
 # within the CPU topology (as defined by the machine property "smp",
-# thus see also type @SMPConfiguration)
+# thus see also type `SMPConfiguration`)
 #
 # @node-id: NUMA node ID the CPU belongs to
 #
@@ -990,7 +990,7 @@
 # Since: 2.7
 ##
 { 'struct': 'CpuInstanceProperties',
-  # Keep these in sync with the properties device_add accepts
+  # Keep these in sync with the properties `device_add` accepts
   'data': { '*node-id': 'int',
             '*drawer-id': 'int',
             '*book-id': 'int',
@@ -1006,19 +1006,19 @@
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
@@ -1107,23 +1107,23 @@
 ##
 # @balloon:
 #
-# Request the balloon driver to change its balloon size.
+# Request the `balloon` driver to change its `balloon` size.
 #
 # @value: the target logical size of the VM in bytes.  We can deduce
-#     the size of the balloon using this formula:
+#     the size of the `balloon` using this formula:
 #
 #        logical_vm_size = vm_ram_size - balloon_size
 #
 #     From it we have: balloon_size = vm_ram_size - @value
 #
 # Errors:
-#     - If the balloon driver is enabled but not functional because
+#     - If the `balloon` driver is enabled but not functional because
 #       the KVM kernel module cannot support it, KVMMissingCap
-#     - If no balloon device is present, DeviceNotActive
+#     - If no `balloon` device is present, DeviceNotActive
 #
 # .. note:: This command just issues a request to the guest.  When it
-#    returns, the balloon size may not have changed.  A guest can
-#    change the balloon size independent of this command.
+#    returns, the `balloon` size may not have changed.  A guest can
+#    change the `balloon` size independent of this command.
 #
 # Since: 0.14
 #
@@ -1142,7 +1142,7 @@
 ##
 # @BalloonInfo:
 #
-# Information about the guest balloon device.
+# Information about the guest `balloon` device.
 #
 # @actual: the logical size of the VM in bytes.  Formula used:
 #     logical_vm_size = vm_ram_size - balloon_size
@@ -1154,12 +1154,12 @@
 ##
 # @query-balloon:
 #
-# Return information about the balloon device.
+# Return information about the `balloon` device.
 #
 # Errors:
-#     - If the balloon driver is enabled but not functional because
+#     - If the `balloon` driver is enabled but not functional because
 #       the KVM kernel module cannot support it, KVMMissingCap
-#     - If no balloon device is present, DeviceNotActive
+#     - If no `balloon` device is present, DeviceNotActive
 #
 # Since: 0.14
 #
@@ -1979,7 +1979,7 @@
 #
 # The result of a CPU model baseline.
 #
-# @model: the baselined CpuModelInfo.
+# @model: the baselined `CpuModelInfo`.
 #
 # Since: 2.8
 ##
@@ -2028,28 +2028,28 @@
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
@@ -2082,17 +2082,17 @@
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
@@ -2101,7 +2101,7 @@
 #
 # @modelb: description of the second CPU model to baseline
 #
-# Returns: a CpuModelBaselineInfo describing the baselined CPU model
+# Returns: a `CpuModelBaselineInfo` describing the baselined CPU model
 #
 # Errors:
 #     - if baselining CPU models is not supported by the target
@@ -2121,7 +2121,7 @@
 #
 # The result of a cpu model expansion.
 #
-# @model: the expanded CpuModelInfo.
+# @model: the expanded `CpuModelInfo`.
 #
 # @deprecated-props: an optional list of properties that are flagged as
 #     deprecated by the CPU vendor.  The list depends on the
@@ -2150,17 +2150,17 @@
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
@@ -2169,7 +2169,7 @@
 #
 # @type: expansion type, specifying how to expand the CPU model
 #
-# Returns: a CpuModelExpansionInfo describing the expanded CPU model
+# Returns: a `CpuModelExpansionInfo` describing the expanded CPU model
 #
 # Errors:
 #     - if expanding CPU models is not supported
@@ -2208,7 +2208,7 @@
 #     from running in the current host.  (since 2.8)
 #
 # @typename: Type name that can be used as argument to
-#     @device-list-properties, to introspect properties configurable
+#     `device-list-properties`, to introspect properties configurable
 #     using -cpu or -global.  (since 2.9)
 #
 # @alias-of: Name of CPU model this model is an alias for.  The target
@@ -2252,7 +2252,7 @@
 #
 # Return a list of supported virtual CPU definitions
 #
-# Returns: a list of CpuDefinitionInfo
+# Returns: a list of `CpuDefinitionInfo`
 #
 # Since: 1.2
 ##
-- 
2.48.1


