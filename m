Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55274C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 18:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIX5t-0001ao-TI; Fri, 23 May 2025 14:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIX5g-0001BT-1E
 for qemu-devel@nongnu.org; Fri, 23 May 2025 14:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIX5c-0003C0-0q
 for qemu-devel@nongnu.org; Fri, 23 May 2025 14:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748024749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vD9Sq0XGFwT8zKvpjpez4T9cyat1cUwlICoLGsQvhgw=;
 b=QNM/tEUVI/4MsbYsyEah60nMAPV56w1B4Q3Nmbo4F3Bb+PrV/vpuhpzi5DWg9TuIMm+tMg
 j/9JCC0CClBApFJB3B/hKU4G5ddlleGPNiVxVXf5okLOGzP26Krex7NKqqIXpwEwNF8096
 GnQoiTop4um7mlj/2wlzGBSzn1fAqU8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-qSi6WVFJMkqG0sVjU3_MCQ-1; Fri,
 23 May 2025 14:25:48 -0400
X-MC-Unique: qSi6WVFJMkqG0sVjU3_MCQ-1
X-Mimecast-MFC-AGG-ID: qSi6WVFJMkqG0sVjU3_MCQ_1748024745
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C07A31956094; Fri, 23 May 2025 18:25:44 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.78])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 853AF1944A89; Fri, 23 May 2025 18:25:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
 Ani Sinha <anisinha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 4/4] qapi: rephrase return docs to avoid type name
Date: Fri, 23 May 2025 14:24:42 -0400
Message-ID: <20250523182442.54469-5-jsnow@redhat.com>
In-Reply-To: <20250523182442.54469-1-jsnow@redhat.com>
References: <20250523182442.54469-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Well, I tried. Maybe not very hard. Sorry!

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json     | 6 +++---
 qapi/block-export.json   | 2 +-
 qapi/block.json          | 2 +-
 qapi/control.json        | 5 ++---
 qapi/dump.json           | 5 ++---
 qapi/introspect.json     | 6 +++---
 qapi/job.json            | 2 +-
 qapi/machine-target.json | 7 +++----
 qapi/misc-target.json    | 2 +-
 qapi/misc.json           | 5 ++---
 qapi/net.json            | 2 +-
 qapi/pci.json            | 2 +-
 qapi/qdev.json           | 3 +--
 qapi/qom.json            | 8 +++-----
 qapi/stats.json          | 2 +-
 qapi/trace.json          | 2 +-
 qapi/ui.json             | 2 +-
 qapi/virtio.json         | 6 +++---
 18 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 92b2e368b72..eb97b70cd80 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -763,7 +763,7 @@
 #
 # Get a list of BlockInfo for all virtual block devices.
 #
-# Returns: a list of @BlockInfo describing each virtual block device.
+# Returns: a list describing each virtual block device.
 #     Filter nodes that were created implicitly are skipped over.
 #
 # Since: 0.14
@@ -1168,7 +1168,7 @@
 #     nodes that were created implicitly are skipped over in this
 #     mode.  (Since 2.3)
 #
-# Returns: A list of @BlockStats for each virtual block devices.
+# Returns: A list of statistics for each virtual block device.
 #
 # Since: 0.14
 #
@@ -1440,7 +1440,7 @@
 #
 # Return information about long-running block device operations.
 #
-# Returns: a list of @BlockJobInfo for each active block job
+# Returns: a list of job info for each active block job
 #
 # Since: 1.1
 ##
diff --git a/qapi/block-export.json b/qapi/block-export.json
index c783e01a532..84852606e52 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -472,7 +472,7 @@
 ##
 # @query-block-exports:
 #
-# Returns: A list of BlockExportInfo describing all block exports
+# Returns: A list describing all block exports
 #
 # Since: 5.2
 ##
diff --git a/qapi/block.json b/qapi/block.json
index e66666f5c64..bdbbe78854f 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -86,7 +86,7 @@
 # Returns a list of information about each persistent reservation
 # manager.
 #
-# Returns: a list of @PRManagerInfo for each persistent reservation
+# Returns: a list of manager info for each persistent reservation
 #     manager
 #
 # Since: 3.0
diff --git a/qapi/control.json b/qapi/control.json
index 336386f79e1..2e45bf25df8 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -93,8 +93,7 @@
 #
 # Returns the current version of QEMU.
 #
-# Returns: A @VersionInfo object describing the current version of
-#     QEMU.
+# Returns: An object describing the current version of QEMU.
 #
 # Since: 0.14
 #
@@ -131,7 +130,7 @@
 #
 # Return a list of supported QMP commands by this server
 #
-# Returns: A list of @CommandInfo for all supported commands
+# Returns: A list of all supported commands
 #
 # Since: 0.14
 #
diff --git a/qapi/dump.json b/qapi/dump.json
index d7826c0e323..1bd6bacc5ce 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -146,7 +146,7 @@
 #
 # Query latest dump status.
 #
-# Returns: A @DumpStatus object showing the dump status.
+# Returns: An object showing the dump status.
 #
 # Since: 2.6
 #
@@ -197,8 +197,7 @@
 #
 # Returns the available formats for dump-guest-memory
 #
-# Returns: A @DumpGuestMemoryCapability object listing available
-#     formats for dump-guest-memory
+# Returns: An object listing available formats for dump-guest-memory
 #
 # Since: 2.0
 #
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 01bb242947c..7daec5045fb 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -34,10 +34,10 @@
 # string into a specific enum or from one specific type into an
 # alternate that includes the original type alongside something else.
 #
-# Returns: array of @SchemaInfo, where each element describes an
-#     entity in the ABI: command, event, type, ...
+# Returns: an array where each element describes an entity in the ABI:
+#     command, event, type, ...
 #
-#     The order of the various SchemaInfo is unspecified; however, all
+#     The order of the various elements is unspecified; however, all
 #     names are guaranteed to be unique (no name will be duplicated
 #     with different meta-types).
 #
diff --git a/qapi/job.json b/qapi/job.json
index cfc3beedd21..856dd688f95 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -269,7 +269,7 @@
 #
 # Return information about jobs.
 #
-# Returns: a list with a @JobInfo for each active job
+# Returns: a list with info for each active job
 #
 # Since: 3.0
 ##
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index e4b464eb1a4..7d306d8fa56 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -162,8 +162,7 @@
 # @modelb: description of the second CPU model to compare, referred to
 #     as "model B" in CpuModelCompareResult
 #
-# Returns: a CpuModelCompareInfo describing how both CPU models
-#     compare
+# Returns: An object describing how both CPU models compare
 #
 # Errors:
 #     - if comparing CPU models is not supported
@@ -218,7 +217,7 @@
 #
 # @modelb: description of the second CPU model to baseline
 #
-# Returns: a CpuModelBaselineInfo describing the baselined CPU model
+# Returns: An object describing the baselined CPU model
 #
 # Errors:
 #     - if baselining CPU models is not supported
@@ -296,7 +295,7 @@
 #
 # @type: expansion type, specifying how to expand the CPU model
 #
-# Returns: a CpuModelExpansionInfo describing the expanded CPU model
+# Returns: An object describing the expanded CPU model
 #
 # Errors:
 #     - if expanding CPU models is not supported
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 94624cb45e0..799a4ad1ce1 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -158,7 +158,7 @@
 #
 # Query the SEV guest launch information.
 #
-# Returns: The @SevLaunchMeasureInfo for the guest
+# Returns: The guest's SEV guest launch measurement info
 #
 # Since: 2.12
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index de5dd531071..3d10aeb215c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -105,7 +105,7 @@
 #    declared using the ``-object iothread`` command-line option.  It
 #    is always the main thread of the process.
 #
-# Returns: a list of @IOThreadInfo for each iothread
+# Returns: a list of info for each iothread
 #
 # Since: 2.0
 #
@@ -509,8 +509,7 @@
 #
 # @option: option name
 #
-# Returns: list of @CommandLineOptionInfo for all options (or for the
-#     given @option).
+# Returns: list of objects for all options (or for the given @option).
 #
 # Errors:
 #     - if the given @option doesn't exist
diff --git a/qapi/net.json b/qapi/net.json
index 310cc4fd190..43739fd0259 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -845,7 +845,7 @@
 #
 # @name: net client name
 #
-# Returns: list of @RxFilterInfo for all NICs (or for the given NIC).
+# Returns: list of info for all NICs (or for the given NIC).
 #
 # Errors:
 #     - if the given @name doesn't exist
diff --git a/qapi/pci.json b/qapi/pci.json
index dc85a41d28b..29549d94551 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -175,7 +175,7 @@
 #
 # Return information about the PCI bus topology of the guest.
 #
-# Returns: a list of @PciInfo for each PCI bus.  Each bus is
+# Returns: a list of info for each PCI bus.  Each bus is
 #     represented by a json-object, which has a key with a json-array
 #     of all PCI devices attached to it.  Each device is represented
 #     by a json-object.
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 32c7d100463..5d18fb8e0e0 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -17,8 +17,7 @@
 #
 # @typename: the type name of a device
 #
-# Returns: a list of ObjectPropertyInfo describing a devices
-#     properties
+# Returns: a list describing a devices properties
 #
 # .. note:: Objects can create properties at runtime, for example to
 #    describe links between different devices and/or objects.  These
diff --git a/qapi/qom.json b/qapi/qom.json
index 04c118e4d61..44f5f25c19e 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -54,8 +54,7 @@
 # @path: the path within the object model.  See @qom-get for a
 #     description of this parameter.
 #
-# Returns: a list of @ObjectPropertyInfo that describe the properties
-#     of the object.
+# Returns: a list that describe the properties of the object.
 #
 # Since: 1.2
 #
@@ -178,8 +177,7 @@
 #
 # @abstract: if true, include abstract types in the results
 #
-# Returns: a list of @ObjectTypeInfo or an empty list if no results
-#     are found
+# Returns: a list of types, or an empty list if no results are found
 #
 # Since: 1.1
 ##
@@ -199,7 +197,7 @@
 #    describe links between different devices and/or objects.  These
 #    properties are not included in the output of this command.
 #
-# Returns: a list of ObjectPropertyInfo describing object properties
+# Returns: a list describing object properties
 #
 # Since: 2.12
 ##
diff --git a/qapi/stats.json b/qapi/stats.json
index 8902ef94e08..7e7f1dabbc3 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -186,7 +186,7 @@
 # The arguments are a StatsFilter and specify the provider and objects
 # to return statistics about.
 #
-# Returns: a list of StatsResult, one for each provider and object
+# Returns: a list of statistics, one for each provider and object
 #     (e.g., for each vCPU).
 #
 # Since: 7.1
diff --git a/qapi/trace.json b/qapi/trace.json
index eb5f63f5135..11f0b5c3427 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -47,7 +47,7 @@
 #
 # @name: Event name pattern (case-sensitive glob).
 #
-# Returns: a list of @TraceEventInfo for the matching events
+# Returns: a list of info for the matching events
 #
 # Since: 2.2
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index 46843bdbefa..a1015801b1b 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -816,7 +816,7 @@
 #
 # Returns information about each active mouse device
 #
-# Returns: a list of @MouseInfo for each device
+# Returns: a list of info for each device
 #
 # Since: 0.14
 #
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 93c576a21da..cee0e100d44 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -199,7 +199,7 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtioStatus of the virtio device
+# Returns: Status of the virtio device
 #
 # Since: 7.2
 #
@@ -563,7 +563,7 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtQueueStatus of the VirtQueue
+# Returns: Status of the queue
 #
 # .. note:: last_avail_idx will not be displayed in the case where the
 #    selected VirtIODevice has a running vhost device and the
@@ -698,7 +698,7 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtVhostQueueStatus of the vhost_virtqueue
+# Returns: Status of the vhost_virtqueue
 #
 # Since: 7.2
 #
-- 
2.48.1


