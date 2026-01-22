Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48763C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqcA-0004LN-RX; Thu, 22 Jan 2026 04:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viqbo-0004K0-6O
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:04:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viqbl-0007Z2-N2
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769072644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RFjaoM2BbNzDADGvNkAKJCVDL/z8wE6KQkgPtidcAmc=;
 b=GNKZ68+fQksrcmkcPHDeVzR0ALsJLWc5cbQ1opKtui43m3r3toXFuz+Zkvgg0vFjdQg2pE
 5d19bmw+reRwrl48QobZuhuTc5ar66+iU0LA38Ela5/RZ1mMoCvtEiZu1nq+nrb+Lkrkh7
 CuVNOG6sJ+Sgq5hJGDI1W6YtN2/RCZs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-SIMB3yfCPJuRIMvsjKZU9g-1; Thu,
 22 Jan 2026 04:04:00 -0500
X-MC-Unique: SIMB3yfCPJuRIMvsjKZU9g-1
X-Mimecast-MFC-AGG-ID: SIMB3yfCPJuRIMvsjKZU9g_1769072639
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 482961944F2F; Thu, 22 Jan 2026 09:03:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.255])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5978B1958DC0; Thu, 22 Jan 2026 09:03:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] Replace CONFIG_WIN32 with CONFIG_WIN64
Date: Thu, 22 Jan 2026 10:03:52 +0100
Message-ID: <20260122090352.9901-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

We stopped supported 32-bit Windows hosts a while ago already, so
let's rename CONFIG_WIN32 to CONFIG_WIN64 now to make it clear
that this switch is not about 32-bit Windows anymore.

The patch has been created with a simple sed statement:

 sed -i s/CONFIG_WIN32/CONFIG_WIN64/g $(grep -rl CONFIG_WIN32 *)

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build           |  2 +-
 qapi/char.json        |  4 +--
 qapi/misc.json        |  2 +-
 qga/qapi-schema.json  | 76 +++++++++++++++++++++----------------------
 include/qemu/futex.h  |  2 +-
 include/qemu/xattr.h  |  2 +-
 hw/usb/host-libusb.c  | 18 +++++-----
 io/channel-watch.c    | 10 +++---
 ui/gtk.c              |  2 +-
 util/cacheflush.c     |  4 +--
 util/sys_membarrier.c |  2 +-
 scripts/checkpatch.pl |  2 +-
 12 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/meson.build b/meson.build
index a84f14258b0..01b9a5c22ce 100644
--- a/meson.build
+++ b/meson.build
@@ -2422,7 +2422,7 @@ config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
 config_host_data.set('CONFIG_LINUX', host_os == 'linux')
 config_host_data.set('CONFIG_POSIX', host_os != 'windows')
-config_host_data.set('CONFIG_WIN32', host_os == 'windows')
+config_host_data.set('CONFIG_WIN64', host_os == 'windows')
 config_host_data.set('CONFIG_LZO', lzo.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_BLKIO', blkio.found())
diff --git a/qapi/char.json b/qapi/char.json
index 140614f82c3..7853a093b1b 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -528,7 +528,7 @@
             { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
             'testdev',
             'stdio',
-            { 'name': 'console', 'if': 'CONFIG_WIN32' },
+            { 'name': 'console', 'if': 'CONFIG_WIN64' },
             { 'name': 'spicevmc', 'if': 'CONFIG_SPICE' },
             { 'name': 'spiceport', 'if': 'CONFIG_SPICE' },
             { 'name': 'qemu-vdagent', 'if': 'CONFIG_SPICE_PROTOCOL' },
@@ -722,7 +722,7 @@
             'testdev': 'ChardevCommonWrapper',
             'stdio': 'ChardevStdioWrapper',
             'console': { 'type': 'ChardevCommonWrapper',
-                         'if': 'CONFIG_WIN32' },
+                         'if': 'CONFIG_WIN64' },
             'spicevmc': { 'type': 'ChardevSpiceChannelWrapper',
                           'if': 'CONFIG_SPICE' },
             'spiceport': { 'type': 'ChardevSpicePortWrapper',
diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2fe..1122fa899ca 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -291,7 +291,7 @@
 #          "arguments": { "info": "abcd123..", "fdname": "skclient" } }
 #     <- { "return": {} }
 ##
-{ 'command': 'get-win32-socket', 'data': {'info': 'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN32' }
+{ 'command': 'get-win32-socket', 'data': {'info': 'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN64' }
 
 ##
 # @closefd:
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 5791b49ddea..2079b92004c 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -413,7 +413,7 @@
 ##
 { 'enum': 'GuestFsfreezeStatus',
   'data': [ 'thawed', 'frozen' ],
-  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-status:
@@ -428,7 +428,7 @@
 ##
 { 'command': 'guest-fsfreeze-status',
   'returns': 'GuestFsfreezeStatus',
-  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-freeze:
@@ -451,7 +451,7 @@
 ##
 { 'command': 'guest-fsfreeze-freeze',
   'returns': 'int',
-  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-freeze-list:
@@ -472,7 +472,7 @@
 { 'command': 'guest-fsfreeze-freeze-list',
   'data':    { '*mountpoints': ['str'] },
   'returns': 'int',
-  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-thaw:
@@ -490,7 +490,7 @@
 ##
 { 'command': 'guest-fsfreeze-thaw',
   'returns': 'int',
-  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @GuestFilesystemTrimResult:
@@ -508,7 +508,7 @@
 { 'struct': 'GuestFilesystemTrimResult',
   'data': {'path': 'str',
            '*trimmed': 'int', '*minimum': 'int', '*error': 'str'},
-  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'CONFIG_FSTRIM'] } }
 
 ##
 # @GuestFilesystemTrimResponse:
@@ -520,7 +520,7 @@
 ##
 { 'struct': 'GuestFilesystemTrimResponse',
   'data': {'paths': ['GuestFilesystemTrimResult']},
-  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'CONFIG_FSTRIM'] } }
 
 ##
 # @guest-fstrim:
@@ -542,7 +542,7 @@
 { 'command': 'guest-fstrim',
   'data': { '*minimum': 'int' },
   'returns': 'GuestFilesystemTrimResponse',
-  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'CONFIG_FSTRIM'] } }
 
 ##
 # @guest-suspend-disk:
@@ -572,7 +572,7 @@
 # Since: 1.1
 ##
 { 'command': 'guest-suspend-disk', 'success-response': false,
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN64'] } }
 
 ##
 # @guest-suspend-ram:
@@ -609,7 +609,7 @@
 # Since: 1.1
 ##
 { 'command': 'guest-suspend-ram', 'success-response': false,
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN64'] } }
 
 ##
 # @guest-suspend-hybrid:
@@ -660,7 +660,7 @@
 ##
 { 'enum': 'GuestIpAddressType',
   'data': [ 'ipv4', 'ipv6' ],
-  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestIpAddress:
@@ -677,7 +677,7 @@
   'data': {'ip-address': 'str',
            'ip-address-type': 'GuestIpAddressType',
            'prefix': 'int'},
-  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestNetworkInterfaceStat:
@@ -710,7 +710,7 @@
             'tx-errs': 'uint64',
             'tx-dropped': 'uint64'
            },
-  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestNetworkInterface:
@@ -731,7 +731,7 @@
            '*hardware-address': 'str',
            '*ip-addresses': ['GuestIpAddress'],
            '*statistics': 'GuestNetworkInterfaceStat' },
-  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @guest-network-get-interfaces:
@@ -742,7 +742,7 @@
 ##
 { 'command': 'guest-network-get-interfaces',
   'returns': ['GuestNetworkInterface'],
-  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
+  'if': { 'any': ['CONFIG_WIN64', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestLogicalProcessor:
@@ -762,7 +762,7 @@
   'data': {'logical-id': 'int',
            'online': 'bool',
            '*can-offline': 'bool'},
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN64'] } }
 
 ##
 # @guest-get-vcpus:
@@ -778,7 +778,7 @@
 ##
 { 'command': 'guest-get-vcpus',
   'returns': ['GuestLogicalProcessor'],
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN64'] } }
 
 ##
 # @guest-set-vcpus:
@@ -874,7 +874,7 @@
   'data': [ 'ide', 'fdc', 'scsi', 'virtio', 'xen', 'usb', 'uml', 'sata',
             'sd', 'unknown', 'ieee1394', 'ssa', 'fibre', 'raid', 'iscsi',
             'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestPCIAddress:
@@ -892,7 +892,7 @@
 { 'struct': 'GuestPCIAddress',
   'data': {'domain': 'int', 'bus': 'int',
            'slot': 'int', 'function': 'int'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestCCWAddress:
@@ -912,7 +912,7 @@
            'ssid': 'int',
            'subchno': 'int',
            'devno': 'int'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestDiskAddress:
@@ -942,7 +942,7 @@
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str',
            '*ccw-address': 'GuestCCWAddress'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestNVMeSmart:
@@ -980,7 +980,7 @@
            'media-errors-hi': 'uint64',
            'number-of-error-log-entries-lo': 'uint64',
            'number-of-error-log-entries-hi': 'uint64' },
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LIBUDEV' ] } }
 
 ##
 # @GuestDiskSmart:
@@ -995,7 +995,7 @@
   'base': { 'type': 'GuestDiskBusType' },
   'discriminator': 'type',
   'data': { 'nvme': 'GuestNVMeSmart' },
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LIBUDEV' ] } }
 
 ##
 # @GuestDiskInfo:
@@ -1021,7 +1021,7 @@
   'data': {'name': 'str', 'partition': 'bool', '*dependencies': ['str'],
            '*address': 'GuestDiskAddress', '*alias': 'str',
            '*smart': 'GuestDiskSmart'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LIBUDEV' ] } }
 
 ##
 # @guest-get-disks:
@@ -1035,7 +1035,7 @@
 ##
 { 'command': 'guest-get-disks',
   'returns': ['GuestDiskInfo'],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LIBUDEV' ] } }
 
 ##
 # @GuestFilesystemInfo:
@@ -1063,7 +1063,7 @@
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
            '*used-bytes': 'uint64', '*total-bytes': 'uint64',
            '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LINUX' ] } }
 
 ##
 # @guest-get-fsinfo:
@@ -1077,7 +1077,7 @@
 ##
 { 'command': 'guest-get-fsinfo',
   'returns': ['GuestFilesystemInfo'],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LINUX' ] } }
 
 ##
 # @guest-set-user-password:
@@ -1105,7 +1105,7 @@
 ##
 { 'command': 'guest-set-user-password',
   'data': { 'username': 'str', 'password': 'str', 'crypted': 'bool' },
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
+  'if': { 'any': [ 'CONFIG_WIN64', 'CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
 
 ##
 # @GuestMemoryBlock:
@@ -1322,7 +1322,7 @@
 ##
  { 'enum': 'GuestExecCaptureOutputMode',
    'data': [ 'none', 'stdout', 'stderr', 'separated',
-             { 'name': 'merged', 'if': { 'not': 'CONFIG_WIN32' } } ] }
+             { 'name': 'merged', 'if': { 'not': 'CONFIG_WIN64' } } ] }
 
 ##
 # @GuestExecCaptureOutput:
@@ -1407,7 +1407,7 @@
 ##
 { 'struct': 'GuestUser',
   'data': { 'user': 'str', 'login-time': 'number', '*domain': 'str' },
-  'if': { 'any': ['CONFIG_WIN32', 'HAVE_UTMPX' ] } }
+  'if': { 'any': ['CONFIG_WIN64', 'HAVE_UTMPX' ] } }
 
 ##
 # @guest-get-users:
@@ -1420,7 +1420,7 @@
 ##
 { 'command': 'guest-get-users',
   'returns': ['GuestUser'],
-  'if': { 'any': ['CONFIG_WIN32', 'HAVE_UTMPX' ] } }
+  'if': { 'any': ['CONFIG_WIN64', 'HAVE_UTMPX' ] } }
 
 ##
 # @GuestTimezone:
@@ -1527,7 +1527,7 @@
 ##
 { 'enum': 'GuestDeviceType',
   'data': [ 'pci' ],
-  'if': 'CONFIG_WIN32' }
+  'if': 'CONFIG_WIN64' }
 
 ##
 # @GuestDeviceIdPCI:
@@ -1540,7 +1540,7 @@
 ##
 { 'struct': 'GuestDeviceIdPCI',
   'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' },
-  'if': 'CONFIG_WIN32' }
+  'if': 'CONFIG_WIN64' }
 
 ##
 # @GuestDeviceId:
@@ -1555,7 +1555,7 @@
   'base': { 'type': 'GuestDeviceType' },
   'discriminator': 'type',
   'data': { 'pci': 'GuestDeviceIdPCI' },
-  'if': 'CONFIG_WIN32' }
+  'if': 'CONFIG_WIN64' }
 
 ##
 # @GuestDeviceInfo:
@@ -1577,7 +1577,7 @@
       '*driver-version': 'str',
       '*id': 'GuestDeviceId'
   },
-  'if': 'CONFIG_WIN32' }
+  'if': 'CONFIG_WIN64' }
 
 ##
 # @guest-get-devices:
@@ -1588,7 +1588,7 @@
 ##
 { 'command': 'guest-get-devices',
   'returns': ['GuestDeviceInfo'],
-  'if': 'CONFIG_WIN32' }
+  'if': 'CONFIG_WIN64' }
 
 ##
 # @GuestAuthorizedKeys:
@@ -1854,7 +1854,7 @@
       'load5m': 'number',
       'load15m': 'number'
   },
-  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_GETLOADAVG'] }
+  'if': { 'any': ['CONFIG_WIN64', 'CONFIG_GETLOADAVG'] }
 }
 
 ##
@@ -1873,7 +1873,7 @@
 ##
 { 'command': 'guest-get-load',
   'returns': 'GuestLoadAverage',
-  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_GETLOADAVG'] }
+  'if': { 'any': ['CONFIG_WIN64', 'CONFIG_GETLOADAVG'] }
 }
 
 ##
diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index 607613eec83..7eb219daa37 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -55,7 +55,7 @@ static inline void qemu_futex_wait(void *f, unsigned val)
         }
     }
 }
-#elif defined(CONFIG_WIN32)
+#elif defined(CONFIG_WIN64)
 #include <synchapi.h>
 
 static inline void qemu_futex_wake_all(void *f)
diff --git a/include/qemu/xattr.h b/include/qemu/xattr.h
index 224ba1276e6..063c93a66e7 100644
--- a/include/qemu/xattr.h
+++ b/include/qemu/xattr.h
@@ -25,7 +25,7 @@
 #  if !defined(ENOATTR)
 #    define ENOATTR ENODATA
 #  endif
-#  ifndef CONFIG_WIN32
+#  ifndef CONFIG_WIN64
 #    ifdef CONFIG_FREEBSD
 #      include <sys/extattr.h>
 #    else
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b9f3ad3f66d..2f20614534f 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -35,7 +35,7 @@
 
 #include "qemu/osdep.h"
 #include "qom/object.h"
-#ifndef CONFIG_WIN32
+#ifndef CONFIG_WIN64
 #include <poll.h>
 #endif
 #include <libusb.h>
@@ -233,7 +233,7 @@ static const char *err_names[] = {
 static libusb_context *ctx;
 static uint32_t loglevel;
 
-#ifndef CONFIG_WIN32
+#ifndef CONFIG_WIN64
 
 static void usb_host_handle_fd(void *opaque)
 {
@@ -277,11 +277,11 @@ static void usb_host_timer(void *opaque)
     usb_host_timer_kick();
 }
 
-#endif /* !CONFIG_WIN32 */
+#endif /* !CONFIG_WIN64 */
 
 static int usb_host_init(void)
 {
-#ifndef CONFIG_WIN32
+#ifndef CONFIG_WIN64
     const struct libusb_pollfd **poll;
 #endif
     int rc;
@@ -298,7 +298,7 @@ static int usb_host_init(void)
 #else
     libusb_set_debug(ctx, loglevel);
 #endif
-#ifdef CONFIG_WIN32
+#ifdef CONFIG_WIN64
     poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, usb_host_timer, NULL);
     usb_host_timer_kick();
 #else
@@ -388,7 +388,7 @@ static USBHostRequest *usb_host_req_alloc(USBHostDevice *s, USBPacket *p,
         r->buffer = g_malloc(bufsize);
     }
     QTAILQ_INSERT_TAIL(&s->requests, r, next);
-#ifdef CONFIG_WIN32
+#ifdef CONFIG_WIN64
     request_count++;
     usb_host_timer_kick();
 #endif
@@ -397,7 +397,7 @@ static USBHostRequest *usb_host_req_alloc(USBHostDevice *s, USBPacket *p,
 
 static void usb_host_req_free(USBHostRequest *r)
 {
-#ifdef CONFIG_WIN32
+#ifdef CONFIG_WIN64
     request_count--;
 #endif
     QTAILQ_REMOVE(&r->host->requests, r, next);
@@ -971,7 +971,7 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
             goto fail;
         }
     } else {
-#if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN32)
+#if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN64)
         trace_usb_host_open_hostfd(hostfd);
 
         rc = libusb_wrap_sys_device(ctx, hostfd, &s->dh);
@@ -1208,7 +1208,7 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
     QTAILQ_INIT(&s->isorings);
     s->hostfd = -1;
 
-#if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN32)
+#if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN64)
     if (s->hostdevice) {
         int fd;
         s->needs_autoscan = false;
diff --git a/io/channel-watch.c b/io/channel-watch.c
index 018648b36b4..ddd0aa1548a 100644
--- a/io/channel-watch.c
+++ b/io/channel-watch.c
@@ -30,7 +30,7 @@ struct QIOChannelFDSource {
 };
 
 
-#ifdef CONFIG_WIN32
+#ifdef CONFIG_WIN64
 typedef struct QIOChannelSocketSource QIOChannelSocketSource;
 struct QIOChannelSocketSource {
     GSource parent;
@@ -96,7 +96,7 @@ qio_channel_fd_source_finalize(GSource *source)
 }
 
 
-#ifdef CONFIG_WIN32
+#ifdef CONFIG_WIN64
 static gboolean
 qio_channel_socket_source_prepare(GSource *source G_GNUC_UNUSED,
                                   gint *timeout)
@@ -261,7 +261,7 @@ GSource *qio_channel_create_fd_watch(QIOChannel *ioc,
 
     ssource->condition = condition;
 
-#ifdef CONFIG_WIN32
+#ifdef CONFIG_WIN64
     ssource->fd.fd = (gint64)_get_osfhandle(fd);
 #else
     ssource->fd.fd = fd;
@@ -273,7 +273,7 @@ GSource *qio_channel_create_fd_watch(QIOChannel *ioc,
     return source;
 }
 
-#ifdef CONFIG_WIN32
+#ifdef CONFIG_WIN64
 GSource *qio_channel_create_socket_watch(QIOChannel *ioc,
                                          int sockfd,
                                          GIOCondition condition)
@@ -329,7 +329,7 @@ GSource *qio_channel_create_fd_pair_watch(QIOChannel *ioc,
 
     ssource->condition = condition;
 
-#ifdef CONFIG_WIN32
+#ifdef CONFIG_WIN64
     ssource->fdread.fd = (gint64)_get_osfhandle(fdread);
     ssource->fdwrite.fd = (gint64)_get_osfhandle(fdwrite);
 #else
diff --git a/ui/gtk.c b/ui/gtk.c
index e83a3666258..60eb1c245a0 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1363,7 +1363,7 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
 static gboolean gd_grab_broken_event(GtkWidget *widget,
                                      GdkEventGrabBroken *event, void *opaque)
 {
-#ifdef CONFIG_WIN32
+#ifdef CONFIG_WIN64
     /*
      * On Windows the Ctrl-Alt-Del key combination can't be grabbed. This
      * key combination leaves all three keys in a stuck condition. We use
diff --git a/util/cacheflush.c b/util/cacheflush.c
index c043c5f881a..70cf924a263 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -121,7 +121,7 @@ static void sys_cache_info(int *isize, int *dsize)
 static bool have_coherent_icache;
 #endif
 
-#if defined(__aarch64__) && !defined(CONFIG_DARWIN) && !defined(CONFIG_WIN32)
+#if defined(__aarch64__) && !defined(CONFIG_DARWIN) && !defined(CONFIG_WIN64)
 /*
  * Apple does not expose CTR_EL0, so we must use system interfaces.
  * Windows neither, but we use a generic implementation of flush_idcache_range
@@ -231,7 +231,7 @@ static void __attribute__((constructor)) init_cache_info(void)
 
 /* Wasm doesn't have executable region of memory. */
 
-#elif defined(__aarch64__) && !defined(CONFIG_WIN32)
+#elif defined(__aarch64__) && !defined(CONFIG_WIN64)
 /*
  * For Windows, we use generic implementation of flush_idcache_range, that
  * performs a call to FlushInstructionCache, through __builtin___clear_cache.
diff --git a/util/sys_membarrier.c b/util/sys_membarrier.c
index 1362c0c4c59..a866f4faadc 100644
--- a/util/sys_membarrier.c
+++ b/util/sys_membarrier.c
@@ -23,7 +23,7 @@ membarrier(int cmd, int flags)
 
 void smp_mb_global(void)
 {
-#if defined CONFIG_WIN32
+#if defined CONFIG_WIN64
     FlushProcessWriteBuffers();
 #elif defined CONFIG_LINUX
     membarrier(MEMBARRIER_CMD_SHARED, 0);
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3a9557417f7..4cb583bdebd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3110,7 +3110,7 @@ sub process {
 			}
 		}
 # check of hardware specific defines
-# we have e.g. CONFIG_LINUX and CONFIG_WIN32 for common cases
+# we have e.g. CONFIG_LINUX and CONFIG_WIN64 for common cases
 # where they might be necessary.
 		if ($line =~ m@^.\s*\#\s*if.*\b__@) {
 			WARN("architecture specific defines should be avoided\n" .  $herecurr);
-- 
2.52.0


