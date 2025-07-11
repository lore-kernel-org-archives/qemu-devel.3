Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818ADC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua630-0000dj-Qz; Fri, 11 Jul 2025 01:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua62v-0000Z5-Rp
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua62s-0000Ie-GA
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752210697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8CKJZCT0DA9UWpXbjPd98IwiuYkj5ENa3pOYyLRZYc=;
 b=VW0l95R87nmHWrT66Oy1iVwvNCf/fw1bxkmU4MUj0eChXgxFaorQVMm9TFDfl4jkVjbHbC
 6h2JyRH6XA+TZeI/oGee2O/Mv5CnoNJ9sx99mAcvT6kN8XE3rnxkBc6DQpnoaQp54bjvd+
 9a/KnxxcktdRfSod4jtub3fWcdAGbac=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-7S6m4M6JOcaCxz-9U1A3dg-1; Fri,
 11 Jul 2025 01:11:35 -0400
X-MC-Unique: 7S6m4M6JOcaCxz-9U1A3dg-1
X-Mimecast-MFC-AGG-ID: 7S6m4M6JOcaCxz-9U1A3dg_1752210693
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B44491801211; Fri, 11 Jul 2025 05:11:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F449300022A; Fri, 11 Jul 2025 05:11:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jiri Pirko <jiri@resnulli.us>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Lukas Straub <lukasstraub2@web.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v6 3/4] qapi: remove trivial "Returns:" sections
Date: Fri, 11 Jul 2025 01:10:44 -0400
Message-ID: <20250711051045.51110-4-jsnow@redhat.com>
In-Reply-To: <20250711051045.51110-1-jsnow@redhat.com>
References: <20250711051045.51110-1-jsnow@redhat.com>
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

The new qapidoc.py can generate "Returns" statements with type
information just fine, so we can remove it from the source where it
doesn't add anything particularly novel or helpful and just repeats the
type info.

This patch is fairly "gentle" and doesn't aggressively touch other
"Returns" lines that could be rephrased to omit repeating type
information; it only removes lines that appear appropriate to wholly
remove.

To help facilitate auto-generated placement, several doc blocks have a
"TODO:" line inserted to help the placement algorithm differentiate the
introductory paragraph(s) from the rest of the documentation.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/audio.json      |  2 --
 qapi/block-core.json |  8 --------
 qapi/char.json       |  8 --------
 qapi/cryptodev.json  |  2 --
 qapi/machine.json    | 22 ----------------------
 qapi/migration.json  | 12 ++----------
 qapi/misc-i386.json  | 10 ----------
 qapi/misc.json       |  7 -------
 qapi/rocker.json     |  4 ----
 qapi/run-state.json  |  2 --
 qapi/tpm.json        |  4 ----
 qapi/ui.json         |  8 --------
 qapi/virtio.json     |  2 --
 qapi/yank.json       |  2 +-
 14 files changed, 3 insertions(+), 90 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 16de231f6d8..e8c469f3452 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -535,8 +535,6 @@
 #
 # Return information about audiodev configuration
 #
-# Returns: array of @Audiodev
-#
 # Since: 8.0
 ##
 { 'command': 'query-audiodevs',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1df6644f0de..d64f482d9bd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1950,8 +1950,6 @@
 # @flat: Omit the nested data about backing image ("backing-image"
 #     key) if true.  Default is false (Since 5.0)
 #
-# Returns: the list of BlockDeviceInfo
-#
 # Since: 2.0
 #
 # .. qmp-example::
@@ -2464,9 +2462,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns:
-#     BlockDirtyBitmapSha256
-#
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found or if hashing has failed, GenericError
@@ -6202,9 +6197,6 @@
 #
 # @name: optional the snapshot's name to be deleted
 #
-# Returns:
-#     SnapshotInfo
-#
 # Errors:
 #     - If @device is not a valid block device, GenericError
 #     - If snapshot not found, GenericError
diff --git a/qapi/char.json b/qapi/char.json
index df6e325e2e1..c189f629c1c 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -36,8 +36,6 @@
 #
 # Return information about current character devices.
 #
-# Returns: a list of @ChardevInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -82,8 +80,6 @@
 #
 # Return information about character device backends.
 #
-# Returns: a list of @ChardevBackendInfo
-#
 # Since: 2.0
 #
 # .. qmp-example::
@@ -772,8 +768,6 @@
 #
 # @backend: backend type and parameters
 #
-# Returns: ChardevReturn.
-#
 # Since: 1.4
 #
 # .. qmp-example::
@@ -812,8 +806,6 @@
 #
 # @backend: new backend type and parameters
 #
-# Returns: ChardevReturn.
-#
 # Since: 2.10
 #
 # .. qmp-example::
diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index b13db264034..b028abf927b 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -96,8 +96,6 @@
 #
 # Return information about current crypto devices.
 #
-# Returns: a list of @QCryptodevInfo
-#
 # Since: 8.0
 ##
 { 'command': 'query-cryptodev', 'returns': ['QCryptodevInfo']}
diff --git a/qapi/machine.json b/qapi/machine.json
index e3e0505a4b4..b2062f21088 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -101,8 +101,6 @@
 #
 # Return information about all virtual CPUs.
 #
-# Returns: list of @CpuInfoFast
-#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -218,8 +216,6 @@
 #
 # @unstable: Argument @compat-props is experimental.
 #
-# Returns: a list of MachineInfo
-#
 # Since: 1.2
 #
 # .. qmp-example::
@@ -268,8 +264,6 @@
 #
 # Return information on the current virtual machine.
 #
-# Returns: CurrentMachineParams
-#
 # Since: 4.0
 ##
 { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
@@ -291,8 +285,6 @@
 #
 # Return information about the target for this QEMU
 #
-# Returns: QemuTargetInfo
-#
 # Since: 1.2
 ##
 { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
@@ -316,8 +308,6 @@
 #
 # Query the guest UUID information.
 #
-# Returns: The @UuidInfo for the guest
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -469,8 +459,6 @@
 #
 # Return information about KVM acceleration
 #
-# Returns: @KvmInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -932,8 +920,6 @@
 #
 # Return information for all memory backends.
 #
-# Returns: a list of @Memdev.
-#
 # Since: 2.1
 #
 # .. qmp-example::
@@ -1049,8 +1035,6 @@
 #
 # TODO: Better documentation; currently there is none.
 #
-# Returns: a list of HotpluggableCPU objects.
-#
 # Since: 2.7
 #
 # .. qmp-example::
@@ -1172,9 +1156,6 @@
 #
 # Return information about the balloon device.
 #
-# Returns:
-#     @BalloonInfo
-#
 # Errors:
 #     - If the balloon driver is enabled but not functional because
 #       the KVM kernel module cannot support it, KVMMissingCap
@@ -1238,9 +1219,6 @@
 # Return the hv-balloon driver data contained in the last received
 # "STATUS" message from the guest.
 #
-# Returns:
-#     @HvBalloonInfo
-#
 # Errors:
 #     - If no hv-balloon device is present, guest memory status
 #       reporting is not enabled or no guest memory status report
diff --git a/qapi/migration.json b/qapi/migration.json
index e8a7d3b2a95..59a213aeb6c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -286,8 +286,6 @@
 # is active there will be another json-object with RAM migration
 # status.
 #
-# Returns: @MigrationInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -537,8 +535,6 @@
 #
 # Return information about the current migration capabilities status
 #
-# Returns: @MigrationCapabilityStatus
-#
 # Since: 1.2
 #
 # .. qmp-example::
@@ -1324,8 +1320,6 @@
 #
 # Return information about the current migration parameters
 #
-# Returns: @MigrationParameters
-#
 # Since: 2.4
 #
 # .. qmp-example::
@@ -1906,7 +1900,7 @@
 #
 # Query replication status while the vm is running.
 #
-# Returns: A @ReplicationStatus object showing the status.
+# TODO: This line is a hack to separate the example from the body
 #
 # .. qmp-example::
 #
@@ -1960,7 +1954,7 @@
 #
 # Query COLO status while the vm is running.
 #
-# Returns: A @COLOStatus object showing the status.
+# TODO: This line is a hack to separate the example from the body
 #
 # .. qmp-example::
 #
@@ -2335,8 +2329,6 @@
 #
 # @deprecated: This command is deprecated with no replacement yet.
 #
-# Returns: @MigrationThreadInfo
-#
 # Since: 7.2
 ##
 { 'command': 'query-migrationthreads',
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 5fefa0a4840..5b3bf597a2f 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -132,8 +132,6 @@
 # @enabled field is set to 'false' and the state of all other fields
 # is unspecified.
 #
-# Returns: @SevInfo
-#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -214,8 +212,6 @@
 #
 # This is only supported on AMD X86 platforms with KVM enabled.
 #
-# Returns: SevCapability objects.
-#
 # Errors:
 #     - If SEV is not available on the platform, GenericError
 #
@@ -281,8 +277,6 @@
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
 #
-# Returns: SevAttestationReport objects.
-#
 # Errors:
 #     - This will return an error if the attestation report is
 #       unavailable, either due to an invalid guest configuration
@@ -345,8 +339,6 @@
 #
 # Return information about configured SGX capabilities of guest
 #
-# Returns: @SgxInfo
-#
 # Since: 6.2
 #
 # .. qmp-example::
@@ -364,8 +356,6 @@
 #
 # Return information about SGX capabilities of host
 #
-# Returns: @SgxInfo
-#
 # Since: 6.2
 #
 # .. qmp-example::
diff --git a/qapi/misc.json b/qapi/misc.json
index 4b9e601cfa5..8c98fb569a9 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -56,8 +56,6 @@
 #
 # Return the name information of a guest.
 #
-# Returns: @NameInfo of the guest
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -332,9 +330,6 @@
 #
 # @opaque: A free-form string that can be used to describe the fd.
 #
-# Returns:
-#     @AddfdInfo
-#
 # Errors:
 #     - If file descriptor was not received, GenericError
 #     - If @fdset-id is a negative value, GenericError
@@ -415,8 +410,6 @@
 #
 # Return information describing all fd sets.
 #
-# Returns: A list of @FdsetInfo
-#
 # Since: 1.2
 #
 # .. note:: The list of fd sets is shared by all monitor connections.
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 0c7ef1f77c8..2d2ae3bbafc 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -28,8 +28,6 @@
 #
 # @name: switch name
 #
-# Returns: @Rocker information
-#
 # Since: 2.4
 #
 # .. qmp-example::
@@ -98,8 +96,6 @@
 #
 # @name: port name
 #
-# Returns: a list of @RockerPort information
-#
 # Since: 2.4
 #
 # .. qmp-example::
diff --git a/qapi/run-state.json b/qapi/run-state.json
index fd09beb35cb..759f8730059 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -119,8 +119,6 @@
 #
 # Query the run status of the VM
 #
-# Returns: @StatusInfo reflecting the VM
-#
 # Since: 0.14
 #
 # .. qmp-example::
diff --git a/qapi/tpm.json b/qapi/tpm.json
index a16a72edb98..f749e6869df 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -27,8 +27,6 @@
 #
 # Return a list of supported TPM models
 #
-# Returns: a list of TpmModel
-#
 # Since: 1.5
 #
 # .. qmp-example::
@@ -58,8 +56,6 @@
 #
 # Return a list of supported TPM types
 #
-# Returns: a list of TpmType
-#
 # Since: 1.5
 #
 # .. qmp-example::
diff --git a/qapi/ui.json b/qapi/ui.json
index 514fa159b10..ff52ca5a1ce 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -325,8 +325,6 @@
 #
 # Return information about the current SPICE server
 #
-# Returns: @SpiceInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -656,8 +654,6 @@
 #
 # Return information about the current VNC server
 #
-# Returns: @VncInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -687,8 +683,6 @@
 #
 # Return a list of vnc servers.  The list can be empty.
 #
-# Returns: a list of @VncInfo2
-#
 # Since: 2.3
 ##
 { 'command': 'query-vnc-servers', 'returns': ['VncInfo2'],
@@ -1564,8 +1558,6 @@
 #
 # Return information about display configuration
 #
-# Returns: @DisplayOptions
-#
 # Since: 3.1
 ##
 { 'command': 'query-display-options',
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 73df718a261..28feadcd4bc 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -847,8 +847,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtioQueueElement information
-#
 # Since: 7.2
 #
 # .. qmp-example::
diff --git a/qapi/yank.json b/qapi/yank.json
index 30f46c97c98..5f26d6c0149 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -102,7 +102,7 @@
 #
 # Query yank instances.  See @YankInstance for more information.
 #
-# Returns: list of @YankInstance
+# TODO: This line is a hack to separate the example from the body
 #
 # .. qmp-example::
 #
-- 
2.50.0


