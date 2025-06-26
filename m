Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DAFC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 19:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUsgV-0000gr-Bu; Thu, 26 Jun 2025 15:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uUsgN-0000be-2t
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 15:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uUsgF-00057a-8D
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 15:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750967681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s28E4ejHgupYpoM6RHXyoXR3oJzE00JOPcpznByxl/0=;
 b=B+LRDAyokDvNjStsvyDSlPxgFApMDLS8JZMNtkkPRYHZvTMc7Db1qj7BtDihiA+TELcU++
 FjrRl/qQek5XpQzvKrAwo9F1W99mM7Idcg8ib8/VuVSKyjfSA0obMTHntEKGiHcalvUvjS
 82FZLkHeQ4yBcxOsONRQFjcwatn8iDA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-RjLhN6pTPiOZDZeRUPA2pA-1; Thu,
 26 Jun 2025 15:54:38 -0400
X-MC-Unique: RjLhN6pTPiOZDZeRUPA2pA-1
X-Mimecast-MFC-AGG-ID: RjLhN6pTPiOZDZeRUPA2pA_1750967675
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2F4D18089B5; Thu, 26 Jun 2025 19:54:33 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.58])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FF7330002C0; Thu, 26 Jun 2025 19:54:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Jiri Pirko <jiri@resnulli.us>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-trivial@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
 Lukas Straub <lukasstraub2@web.de>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 4/4] qapi: rephrase return docs to avoid type name
Date: Thu, 26 Jun 2025 15:53:37 -0400
Message-ID: <20250626195337.2158250-5-jsnow@redhat.com>
In-Reply-To: <20250626195337.2158250-1-jsnow@redhat.com>
References: <20250626195337.2158250-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 qapi/block-core.json   | 6 +++---
 qapi/block-export.json | 2 +-
 qapi/block.json        | 2 +-
 qapi/control.json      | 5 ++---
 qapi/dump.json         | 5 ++---
 qapi/introspect.json   | 6 +++---
 qapi/job.json          | 2 +-
 qapi/misc-i386.json    | 2 +-
 qapi/misc.json         | 5 ++---
 qapi/net.json          | 2 +-
 qapi/pci.json          | 2 +-
 qapi/qdev.json         | 3 +--
 qapi/qom.json          | 8 +++-----
 qapi/stats.json        | 2 +-
 qapi/trace.json        | 2 +-
 qapi/ui.json           | 2 +-
 qapi/virtio.json       | 6 +++---
 17 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d64f482d9bd..f18db3149a3 100644
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
index ed4deb54db2..3edbc5436a3 100644
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
index 1490a1a17f8..d288344c648 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -86,7 +86,7 @@
 # Return a list of information about each persistent reservation
 # manager.
 #
-# Returns: a list of @PRManagerInfo for each persistent reservation
+# Returns: a list of manager info for each persistent reservation
 #     manager
 #
 # Since: 3.0
diff --git a/qapi/control.json b/qapi/control.json
index 34b733f63b6..3aeb8f4f6fb 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -93,8 +93,7 @@
 #
 # Return the current version of QEMU.
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
index d0ba1f0596f..3a9b67efb1b 100644
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
 # Return the available formats for dump-guest-memory
 #
-# Returns: A @DumpGuestMemoryCapability object listing available
-#     formats for dump-guest-memory
+# Returns: An object listing available formats for dump-guest-memory
 #
 # Since: 2.0
 #
diff --git a/qapi/introspect.json b/qapi/introspect.json
index e9e02972821..a5340268d13 100644
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
index 126fa5ce602..c1ddae9c0fe 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -295,7 +295,7 @@
 #
 # Return information about jobs.
 #
-# Returns: a list with a @JobInfo for each active job
+# Returns: a list with info for each active job
 #
 # Since: 3.0
 ##
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 5b3bf597a2f..c0c57f9ab25 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -163,7 +163,7 @@
 # 'sev-guest' confidential virtualization object.  The launch
 # measurement for SEV-SNP guests is only available within the guest.
 #
-# Returns: The @SevLaunchMeasureInfo for the guest
+# Returns: The guest's SEV guest launch measurement info
 #
 # Errors:
 #     - If the launch measurement is unavailable, either due to an
diff --git a/qapi/misc.json b/qapi/misc.json
index 8c98fb569a9..70dbcb0aecf 100644
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
index 97ea1839813..371ade0dc6a 100644
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
index b133b064471..c6fdce7f7bc 100644
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
index ff52ca5a1ce..7136c985c38 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -816,7 +816,7 @@
 #
 # Return information about each active mouse device
 #
-# Returns: a list of @MouseInfo for each device
+# Returns: a list of info for each device
 #
 # Since: 0.14
 #
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 28feadcd4bc..d1556dbf24a 100644
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


