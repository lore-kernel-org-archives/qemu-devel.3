Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8CAC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 22:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s70AW-0005q2-6Q; Tue, 14 May 2024 17:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70AR-0005lU-Oo
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70AP-00009P-CC
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715723916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sr9surEDs9NJNE7QhRLrNBImeHlnfOAEwLxKeLnQ19I=;
 b=WKWQ4eHMLb16zcQClripPwC34Y5mpiFDrEwmF7aMrcepc99No04xM6UuJCP4vaCrqqBjhy
 KnACfgAnukI1M/Jw4k050r0Dd7LAejIIx1w5oJ0N+90QmxQ6Oea8022GYwRA+c/2ThZQcM
 Hu9hVCxwReABhCOHsCkHTC1uBmGgJiM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-nN_yexIePkaGz3WTI0BTLw-1; Tue, 14 May 2024 17:58:33 -0400
X-MC-Unique: nN_yexIePkaGz3WTI0BTLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C312E101A55E;
 Tue, 14 May 2024 21:58:32 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF8E06BC0;
 Tue, 14 May 2024 21:58:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Mads Ynddal <mads@ynddal.dk>,
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 15/20] qapi: remove developer factoring comments from QAPI doc
 blocks
Date: Tue, 14 May 2024 17:57:34 -0400
Message-ID: <20240514215740.940155-16-jsnow@redhat.com>
In-Reply-To: <20240514215740.940155-1-jsnow@redhat.com>
References: <20240514215740.940155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is part of a project to overhaul the QMP reference manual. One goal
of this overhaul is to "inline" inherited argument sections into command
reference sections. A consequence of this design decision is that
inherited doc block sections need to be merged with the inheritor's
sections.

When documentation is written for types whose primary purpose is to be
inherited by other types, we need to know how to merge those paragraphs
into the descendent. Much of the time, these paragraphs aren't actually
useful to end users.

Either remove information that's of little to no use to *either*
audience, and convert what's left to garden-variety comments to prevent
it from showing up in rendered documentation.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/audio.json        |  5 ++---
 qapi/block-core.json   | 47 ++++++++++++++++++------------------------
 qapi/block-export.json | 10 ++++-----
 qapi/char.json         |  5 ++---
 qapi/crypto.json       | 33 ++++++++++++-----------------
 qapi/machine.json      | 10 ++++-----
 qapi/net.json          |  7 ++-----
 qapi/qom.json          | 30 +++++++++++----------------
 qapi/ui.json           | 14 -------------
 9 files changed, 59 insertions(+), 102 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 519697c0cd8..ee09cd231b6 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -10,11 +10,10 @@
 # = Audio
 ##
 
-##
-# @AudiodevPerDirectionOptions:
-#
 # General audio backend options that are used for both playback and
 # recording.
+##
+# @AudiodevPerDirectionOptions:
 #
 # @mixing-engine: use QEMU's mixing engine to mix all streams inside
 #     QEMU and convert audio formats when not supported by the
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 746d1694c25..64fe5240cc9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -267,10 +267,9 @@
       'file': 'ImageInfoSpecificFileWrapper'
   } }
 
-##
-# @BlockNodeInfo:
-#
 # Information about a QEMU image file
+##
+# @BlockNodeInfo:
 #
 # @filename: name of the image file
 #
@@ -1494,8 +1493,6 @@
 ##
 # @BlockdevSnapshotSync:
 #
-# Either @device or @node-name must be set but not both.
-#
 # @device: the name of the device to take a snapshot of.
 #
 # @node-name: graph node name to generate the snapshot from (Since
@@ -1512,6 +1509,9 @@
 #
 # @mode: whether and how QEMU should create a new image, default is
 #     'absolute-paths'.
+#
+# Note: Either @device or @node-name must be set but not both.
+#
 ##
 { 'struct': 'BlockdevSnapshotSync',
   'data': { '*device': 'str', '*node-name': 'str',
@@ -2139,10 +2139,9 @@
   'data': 'DriveMirror',
   'allow-preconfig': true }
 
-##
-# @DriveMirror:
-#
 # A set of parameters describing drive mirror setup.
+##
+# @DriveMirror:
 #
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
@@ -2553,10 +2552,9 @@
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' },
   'allow-preconfig': true }
 
-##
-# @BlockIOThrottle:
-#
 # A set of parameters describing block throttling.
+##
+# @BlockIOThrottle:
 #
 # @device: Block device name
 #
@@ -3073,10 +3071,9 @@
 { 'struct': 'BlockJobChangeOptionsMirror',
   'data': { 'copy-mode' : 'MirrorCopyMode' } }
 
-##
-# @BlockJobChangeOptions:
-#
 # Block job options that can be changed after job creation.
+##
+# @BlockJobChangeOptions:
 #
 # @id: The job identifier
 #
@@ -3332,11 +3329,10 @@
   'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
             '*label': 'str', '*rw': 'bool' } }
 
-##
-# @BlockdevOptionsGenericFormat:
-#
 # Driver specific block device options for image format that have no
 # option besides their data source.
+##
+# @BlockdevOptionsGenericFormat:
 #
 # @file: reference to or definition of the data source block device
 #
@@ -3363,11 +3359,10 @@
   'data': { '*key-secret': 'str',
             '*header': 'BlockdevRef'} }
 
-##
-# @BlockdevOptionsGenericCOWFormat:
-#
 # Driver specific block device options for image format that have no
 # option besides their data source and an optional backing file.
+##
+# @BlockdevOptionsGenericCOWFormat:
 #
 # @backing: reference to or definition of the backing file block
 #     device, null disables the backing file entirely.  Defaults to
@@ -4385,11 +4380,10 @@
             '*page-cache-size': 'int',
             '*debug': 'int' } }
 
-##
-# @BlockdevOptionsCurlBase:
-#
 # Driver specific block device options shared by all protocols
 # supported by the curl backend.
+##
+# @BlockdevOptionsCurlBase:
 #
 # @url: URL of the image file
 #
@@ -4645,11 +4639,10 @@
   'data': { 'target': 'BlockdevRef', '*bitmap': 'BlockDirtyBitmap',
             '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32' } }
 
-##
-# @BlockdevOptions:
-#
 # Options for creating a block device.  Many options are available for
-# all block devices, independent of the block driver:
+# all block devices, independent of the block driver.
+##
+# @BlockdevOptions:
 #
 # @driver: block driver name
 #
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 3919a2d5b9d..dc328097a94 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -77,11 +77,10 @@
             '*max-connections': 'uint32' },
   'allow-preconfig': true }
 
-##
-# @BlockExportOptionsNbdBase:
-#
 # An NBD block export (common options shared between nbd-server-add
 # and the NBD branch of block-export-add).
+##
+# @BlockExportOptionsNbdBase:
 #
 # @name: Export name.  If unspecified, the @device parameter is used
 #     as the export name.  (Since 2.12)
@@ -213,10 +212,9 @@
             '*logical-block-size': 'size',
             '*serial': 'str' } }
 
-##
-# @NbdServerAddOptions:
-#
 # An NBD block export, per legacy nbd-server-add command.
+##
+# @NbdServerAddOptions:
 #
 # @device: The device name or node name of the node to be exported
 #
diff --git a/qapi/char.json b/qapi/char.json
index 777dde55d97..ab4c23976ed 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -189,10 +189,9 @@
   'data': {'device': 'str', 'size': 'int', '*format': 'DataFormat'},
   'returns': 'str' }
 
-##
-# @ChardevCommon:
-#
 # Configuration shared across all chardev backends
+##
+# @ChardevCommon:
 #
 # @logfile: The name of a logfile to save output
 #
diff --git a/qapi/crypto.json b/qapi/crypto.json
index e102be337bb..d4ac5f23c8c 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -163,10 +163,9 @@
 #  'prefix': 'QCRYPTO_BLOCK_FORMAT',
   'data': ['qcow', 'luks']}
 
-##
-# @QCryptoBlockOptionsBase:
-#
 # The common options that apply to all full disk encryption formats
+##
+# @QCryptoBlockOptionsBase:
 #
 # @format: the encryption format
 #
@@ -175,10 +174,9 @@
 { 'struct': 'QCryptoBlockOptionsBase',
   'data': { 'format': 'QCryptoBlockFormat' }}
 
-##
-# @QCryptoBlockOptionsQCow:
-#
 # The options that apply to QCow/QCow2 AES-CBC encryption format
+##
+# @QCryptoBlockOptionsQCow:
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when probing image for
@@ -189,11 +187,10 @@
 { 'struct': 'QCryptoBlockOptionsQCow',
   'data': { '*key-secret': 'str' }}
 
+# The options that apply to LUKS encryption format:
 ##
 # @QCryptoBlockOptionsLUKS:
 #
-# The options that apply to LUKS encryption format
-#
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when probing image for
 #     metadata only.
@@ -203,10 +200,9 @@
 { 'struct': 'QCryptoBlockOptionsLUKS',
   'data': { '*key-secret': 'str' }}
 
-##
-# @QCryptoBlockCreateOptionsLUKS:
-#
 # The options that apply to LUKS encryption format initialization
+##
+# @QCryptoBlockCreateOptionsLUKS:
 #
 # @cipher-alg: the cipher algorithm for data encryption Currently
 #     defaults to 'aes-256'.
@@ -268,11 +264,10 @@
   'data': { 'qcow': 'QCryptoBlockOptionsQCow',
             'luks': 'QCryptoBlockCreateOptionsLUKS' } }
 
-##
-# @QCryptoBlockInfoBase:
-#
 # The common information that applies to all full disk encryption
 # formats
+##
+# @QCryptoBlockInfoBase:
 #
 # @format: the encryption format
 #
@@ -424,10 +419,9 @@
   'data': {
           'luks': 'QCryptoBlockAmendOptionsLUKS' } }
 
-##
-# @SecretCommonProperties:
-#
 # Properties for objects of classes derived from secret-common.
+##
+# @SecretCommonProperties:
 #
 # @loaded: if true, the secret is loaded immediately when applying
 #     this option and will probably fail when processing the next
@@ -490,10 +484,9 @@
   'base': 'SecretCommonProperties',
   'data': { 'serial': 'int32' } }
 
-##
-# @TlsCredsProperties:
-#
 # Properties for objects of classes derived from tls-creds.
+##
+# @TlsCredsProperties:
 #
 # @verify-peer: if true the peer credentials will be verified once the
 #     handshake is completed.  This is a no-op for anonymous
diff --git a/qapi/machine.json b/qapi/machine.json
index 64a77557571..35cca12ba41 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -497,10 +497,9 @@
 { 'enum': 'NumaOptionsType',
   'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
 
-##
-# @NumaOptions:
-#
 # A discriminated record of NUMA options.  (for OptsVisitor)
+##
+# @NumaOptions:
 #
 # @type: NUMA option type
 #
@@ -1198,10 +1197,9 @@
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
 
-##
-# @HvBalloonInfo:
-#
 # hv-balloon guest-provided memory status information.
+##
+# @HvBalloonInfo:
 #
 # @committed: the amount of memory in use inside the guest plus the
 #     amount of the memory unusable inside the guest (ballooned out,
diff --git a/qapi/net.json b/qapi/net.json
index c19df435a53..dc616d010f0 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -722,10 +722,9 @@
             { 'name': 'vmnet-shared', 'if': 'CONFIG_VMNET' },
             { 'name': 'vmnet-bridged', 'if': 'CONFIG_VMNET' }] }
 
-##
-# @Netdev:
-#
 # Captures the configuration of a network device.
+##
+# @Netdev:
 #
 # @id: identifier for monitor commands.
 #
@@ -894,8 +893,6 @@
 ##
 # @AnnounceParameters:
 #
-# Parameters for self-announce timers
-#
 # @initial: Initial delay (in ms) before sending the first GARP/RARP
 #     announcement
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index 38dde6d785a..8f0601859b1 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -272,11 +272,10 @@
             '*max_queue_size': 'uint32',
             '*vnet_hdr_support': 'bool' } }
 
-##
-# @CryptodevBackendProperties:
-#
 # Properties for cryptodev-backend and cryptodev-backend-builtin
 # objects.
+##
+# @CryptodevBackendProperties:
 #
 # @queues: the number of queues for the cryptodev backend.  Ignored
 #     for cryptodev-backend and must be 1 for
@@ -338,10 +337,9 @@
 { 'enum': 'NetfilterInsert',
   'data': [ 'before', 'behind' ] }
 
-##
-# @NetfilterProperties:
-#
 # Properties for objects of classes derived from netfilter.
+##
+# @NetfilterProperties:
 #
 # @netdev: id of the network device backend to filter
 #
@@ -516,10 +514,9 @@
             '*repeat': 'bool',
             '*grab-toggle': 'GrabToggleKeys' } }
 
-##
-# @EventLoopBaseProperties:
-#
 # Common properties for event loops
+##
+# @EventLoopBaseProperties:
 #
 # @aio-max-batch: maximum number of requests in a batch for the AIO
 #     engine, 0 means that the engine will use its default.
@@ -576,10 +573,9 @@
   'base': 'EventLoopBaseProperties',
   'data': {} }
 
-##
-# @MemoryBackendProperties:
-#
 # Properties for objects of classes derived from memory-backend.
+##
+# @MemoryBackendProperties:
 #
 # @merge: if true, mark the memory as mergeable (default depends on
 #     the machine type)
@@ -826,10 +822,9 @@
   'data': { 'pci-dev': 'str',
             'node': 'uint32' } }
 
-##
-# @RngProperties:
-#
 # Properties for objects of classes derived from rng.
+##
+# @RngProperties:
 #
 # @opened: if true, the device is opened immediately when applying
 #     this option and will probably fail when processing the next
@@ -1008,10 +1003,9 @@
     { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] }
   ] }
 
-##
-# @ObjectOptions:
-#
 # Describes the options of a user creatable QOM object.
+##
+# @ObjectOptions:
 #
 # @qom-type: the class name for the object to be created
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index c12f5292571..2d0aa407aca 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -39,8 +39,6 @@
 ##
 # @SetPasswordOptions:
 #
-# Options for set_password.
-#
 # @protocol:
 #     - 'vnc' to modify the VNC server password
 #     - 'spice' to modify the Spice server password
@@ -94,8 +92,6 @@
 ##
 # @ExpirePasswordOptions:
 #
-# General options for expire_password.
-#
 # @protocol:
 #     - 'vnc' to modify the VNC server expiration
 #     - 'spice' to modify the Spice server expiration
@@ -206,8 +202,6 @@
 ##
 # @SpiceBasicInfo:
 #
-# The basic information for SPICE network connection
-#
 # @host: IP address
 #
 # @port: port number
@@ -469,8 +463,6 @@
 ##
 # @VncBasicInfo:
 #
-# The basic information for vnc network connection
-#
 # @host: IP address
 #
 # @service: The service name of the vnc port.  This may depend on the
@@ -1598,8 +1590,6 @@
 ##
 # @DisplayReloadOptions:
 #
-# Options of the display configuration reload.
-#
 # @type: Specify the display type.
 #
 # Since: 6.0
@@ -1641,8 +1631,6 @@
 ##
 # @DisplayUpdateOptionsVNC:
 #
-# Specify the VNC reload options.
-#
 # @addresses: If specified, change set of addresses to listen for
 #     connections.  Addresses configured for websockets are not
 #     touched.
@@ -1655,8 +1643,6 @@
 ##
 # @DisplayUpdateOptions:
 #
-# Options of the display configuration reload.
-#
 # @type: Specify the display type.
 #
 # Since: 7.1
-- 
2.44.0


