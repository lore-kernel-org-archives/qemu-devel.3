Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63078C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txWte-0003dW-55; Wed, 26 Mar 2025 15:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txWtd-0003dO-CF
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txWta-0008Kq-RO
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743019118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7/cT8odGIwsVDppA9+AzgyMdi6K8Q9X/4nrZa1HWck=;
 b=NuBl8hab3l1nbHqiocbzlAvTx0SHZxZTjfVdiXh88JbTl/mdRyNK0O4m08C2ZxCicPU14p
 pZSKOvdtcGVk+ofypnaBWKV8Kc42fw6JFI4PQ0kBW7TUWfF+yjPBs0Db9nYc8P11dFi05a
 ddC8ZP9kD9qZps6eONIYcLRnagfNSiw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-8OHieB8bMxmt_nfLt7H-hg-1; Wed,
 26 Mar 2025 15:58:32 -0400
X-MC-Unique: 8OHieB8bMxmt_nfLt7H-hg-1
X-Mimecast-MFC-AGG-ID: 8OHieB8bMxmt_nfLt7H-hg_1743019106
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93DDA18004A9; Wed, 26 Mar 2025 19:58:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.152])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 822811801762; Wed, 26 Mar 2025 19:58:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Hanna Reitz <hreitz@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-block@nongnu.org,
 Lukas Straub <lukasstraub2@web.de>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Zhenwei Pi <pizhenwei@bytedance.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v2 3/4] qapi: remove trivial "Returns:" sections
Date: Wed, 26 Mar 2025 15:57:55 -0400
Message-ID: <20250326195756.330817-4-jsnow@redhat.com>
In-Reply-To: <20250326195756.330817-1-jsnow@redhat.com>
References: <20250326195756.330817-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The new qapidoc transmogrifier can generate "Returns" statements with
type information just fine, so we can remove it from the source where it
doesn't add anything particularly novel or helpful and just repeats the
type info.

This patch does not touch Returns: lines that add some information
(potentially helpful, potentially not) but repeats the type information
to remove that type.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/audio.json          |  2 --
 qapi/block-core.json     |  8 --------
 qapi/char.json           |  8 --------
 qapi/cryptodev.json      |  2 --
 qapi/machine-target.json |  2 --
 qapi/machine.json        | 22 ----------------------
 qapi/migration.json      | 12 ------------
 qapi/misc-target.json    | 12 ------------
 qapi/misc.json           |  7 -------
 qapi/rocker.json         |  4 ----
 qapi/run-state.json      |  2 --
 qapi/tpm.json            |  4 ----
 qapi/ui.json             |  8 --------
 qapi/virtio.json         |  2 --
 qapi/yank.json           |  1 -
 15 files changed, 96 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index dd5a58d13e6..d49ca4cae47 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -535,8 +535,6 @@
 #
 # Returns information about audiodev configuration
 #
-# Returns: array of @Audiodev
-#
 # Since: 8.0
 ##
 { 'command': 'query-audiodevs',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b1937780e19..92b2e368b72 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1949,8 +1949,6 @@
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
@@ -6157,9 +6152,6 @@
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
index dde2f9538f8..6a82db0d156 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -36,8 +36,6 @@
 #
 # Returns information about current character devices.
 #
-# Returns: a list of @ChardevInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -82,8 +80,6 @@
 #
 # Returns information about character device backends.
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
index 04d0e21d209..e8371b9d950 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -96,8 +96,6 @@
 #
 # Returns information about current crypto devices.
 #
-# Returns: a list of @QCryptodevInfo
-#
 # Since: 8.0
 ##
 { 'command': 'query-cryptodev', 'returns': ['QCryptodevInfo']}
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 541f93eeb78..37e75520094 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -391,8 +391,6 @@
 #
 # Return a list of supported virtual CPU definitions
 #
-# Returns: a list of CpuDefinitionInfo
-#
 # Since: 1.2
 ##
 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09e..415d39a1d68 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -101,8 +101,6 @@
 #
 # Returns information about all virtual CPUs.
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
-# Returns: TargetInfo
-#
 # Since: 1.2
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
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
 # Returns information about KVM acceleration
 #
-# Returns: @KvmInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -932,8 +920,6 @@
 #
 # Returns information for all memory backends.
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
 # Returns the hv-balloon driver data contained in the last received
 # "STATUS" message from the guest.
 #
-# Returns:
-#     @HvBalloonInfo
-#
 # Errors:
 #     - If no hv-balloon device is present, guest memory status
 #       reporting is not enabled or no guest memory status report
diff --git a/qapi/migration.json b/qapi/migration.json
index 8b9c53595c4..b0e9452e7fa 100644
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
 # Returns information about the current migration capabilities status
 #
-# Returns: @MigrationCapabilityStatus
-#
 # Since: 1.2
 #
 # .. qmp-example::
@@ -1322,8 +1318,6 @@
 #
 # Returns information about the current migration parameters
 #
-# Returns: @MigrationParameters
-#
 # Since: 2.4
 #
 # .. qmp-example::
@@ -1904,8 +1898,6 @@
 #
 # Query replication status while the vm is running.
 #
-# Returns: A @ReplicationStatus object showing the status.
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-xen-replication-status" }
@@ -1958,8 +1950,6 @@
 #
 # Query COLO status while the vm is running.
 #
-# Returns: A @COLOStatus object showing the status.
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-colo-status" }
@@ -2333,8 +2323,6 @@
 #
 # @deprecated: This command is deprecated with no replacement yet.
 #
-# Returns: @MigrationThreadInfo
-#
 # Since: 7.2
 ##
 { 'command': 'query-migrationthreads',
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 8d70bd24d8c..59a8f5b2bed 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -129,8 +129,6 @@
 #
 # Returns information about SEV
 #
-# Returns: @SevInfo
-#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -205,8 +203,6 @@
 # This command is used to get the SEV capabilities, and is supported
 # on AMD X86 platforms only.
 #
-# Returns: SevCapability objects.
-#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -259,8 +255,6 @@
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
 #
-# Returns: SevAttestationReport objects.
-#
 # Since: 6.1
 #
 # .. qmp-example::
@@ -324,8 +318,6 @@
 # This command is ARM-only.  It will return a list of GICCapability
 # objects that describe its capability bits.
 #
-# Returns: a list of GICCapability objects.
-#
 # Since: 2.6
 #
 # .. qmp-example::
@@ -382,8 +374,6 @@
 #
 # Returns information about SGX
 #
-# Returns: @SGXInfo
-#
 # Since: 6.2
 #
 # .. qmp-example::
@@ -401,8 +391,6 @@
 #
 # Returns information from host SGX capabilities
 #
-# Returns: @SGXInfo
-#
 # Since: 6.2
 #
 # .. qmp-example::
diff --git a/qapi/misc.json b/qapi/misc.json
index 559b66f2017..de5dd531071 100644
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
index 51aa5b49307..d1714a08d71 100644
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
index ce95cfa46b7..ff2d694ee2f 100644
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
index c536d4e5241..46843bdbefa 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -325,8 +325,6 @@
 #
 # Returns information about the current SPICE server
 #
-# Returns: @SpiceInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -656,8 +654,6 @@
 #
 # Returns information about the current VNC server
 #
-# Returns: @VncInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -687,8 +683,6 @@
 #
 # Returns a list of vnc servers.  The list can be empty.
 #
-# Returns: a list of @VncInfo2
-#
 # Since: 2.3
 ##
 { 'command': 'query-vnc-servers', 'returns': ['VncInfo2'],
@@ -1564,8 +1558,6 @@
 #
 # Returns information about display configuration
 #
-# Returns: @DisplayOptions
-#
 # Since: 3.1
 ##
 { 'command': 'query-display-options',
diff --git a/qapi/virtio.json b/qapi/virtio.json
index d351d2166ef..93c576a21da 100644
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
index 30f46c97c98..9bd8ecce27f 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -102,7 +102,6 @@
 #
 # Query yank instances.  See @YankInstance for more information.
 #
-# Returns: list of @YankInstance
 #
 # .. qmp-example::
 #
-- 
2.48.1


