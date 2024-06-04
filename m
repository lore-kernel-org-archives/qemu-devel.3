Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F349FC27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9l-0006hE-IW; Tue, 04 Jun 2024 11:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9j-0006gB-Ul
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9h-0001Ic-45
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NhNOG2TNYSsOZ5fCIRNGn6C26A53X/WFY2Ybv9oatgc=;
 b=dUR57LnYaZeNLgtshUbUomN1s1nMUzvAGTp8eDmaFvdAreye+Lz9rlM7sq71W3qiEc2K5X
 fbnNMkwQkMWfQ7F7RWQSmIiez5HI73XNtwg/NVpzsfQx1kovarCsAHvmT8tjT7e+5yQPjs
 425Bdor2UcNAkAm88DEOLy3BFuV5D1c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-l8vD4VqlP3aDUFh1B_7GcA-1; Tue, 04 Jun 2024 11:32:54 -0400
X-MC-Unique: l8vD4VqlP3aDUFh1B_7GcA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8096385A588;
 Tue,  4 Jun 2024 15:32:54 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A88D492BD5;
 Tue,  4 Jun 2024 15:32:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 09/14] qga: define commands which can be run in confidential
 mode
Date: Tue,  4 Jun 2024 16:32:37 +0100
Message-ID: <20240604153242.251334-10-berrange@redhat.com>
In-Reply-To: <20240604153242.251334-1-berrange@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This adds the 'confidential' feature tag to the commands which are
safe to permit in confidential VMs. In a confidential virt scenario,
the host must not be permitted to modify guest data, nor request
information that could compromise guest data.

This effectively limits the QGA to commands which either are part
of the QGA operation, or are related to modifying virtual hardware
to assist in a host mgmt tasks.

This results in the following being permitted

 * guest-sync
 * guest-sync-delimited
 * guest-ping
 * guest-get-time
 * guest-set-time
 * guest-info
 * guest-shutdown
 * guest-fsfreeze-status
 * guest-fsfreeze-freeze
 * guest-fsfreeze-freeze-list
 * guest-fsfreeze-thaw
 * guest-fstrim
 * guest-suspend-disk
 * guest-suspend-ram
 * guest-suspend-hybrid
 * guest-get-vcpus
 * guest-set-vcpus
 * guest-get-memory-blocks
 * guest-set-memory-blocks
 * guest-get-memory-block-info
 * guest-get-host-name
 * guest-get-cpustats

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/qapi-schema.json | 117 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 107 insertions(+), 10 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 9a213dfc06..48ea95cdba 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -78,12 +78,14 @@
 #
 # @fs-frozen: permitted to execute when filesystems are frozen
 #
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 1.1
 ##
 { 'command': 'guest-sync-delimited',
   'data':    { 'id': 'int' },
   'returns': 'int',
-  'features': [ 'fs-frozen'] }
+  'features': [ 'fs-frozen', 'confidential' ] }
 
 ##
 # @guest-sync:
@@ -120,12 +122,14 @@
 #
 # @fs-frozen: permitted to execute when filesystems are frozen
 #
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-sync',
   'data':    { 'id': 'int' },
   'returns': 'int',
-  'features': [ 'fs-frozen'] }
+  'features': [ 'fs-frozen', 'confidential' ] }
 
 ##
 # @guest-ping:
@@ -136,10 +140,12 @@
 #
 # @fs-frozen: permitted to execute when filesystems are frozen
 #
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-ping',
-  'features': [ 'fs-frozen'] }
+  'features': [ 'fs-frozen', 'confidential' ] }
 
 ##
 # @guest-get-time:
@@ -149,10 +155,15 @@
 #
 # Returns: Time in nanoseconds.
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 1.5
 ##
 { 'command': 'guest-get-time',
-  'returns': 'int' }
+  'returns': 'int',
+  'features': [ 'confidential' ] }
 
 ##
 # @guest-set-time:
@@ -175,10 +186,15 @@
 # @time: time of nanoseconds, relative to the Epoch of 1970-01-01 in
 #     UTC.
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 1.5
 ##
 { 'command': 'guest-set-time',
-  'data': { '*time': 'int' } }
+  'data': { '*time': 'int' },
+  'features': [ 'confidential' ] }
 
 ##
 # @GuestAgentCommandInfo:
@@ -222,11 +238,13 @@
 #
 # @fs-frozen: permitted when filesystems are frozen
 #
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-info',
   'returns': 'GuestAgentInfo',
-  'features': [ 'fs-frozen'] }
+  'features': [ 'fs-frozen', 'confidential' ] }
 
 ##
 # @guest-shutdown:
@@ -241,10 +259,15 @@
 # when running with --no-shutdown, by issuing the query-status QMP
 # command to confirm the VM status is "shutdown".
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-shutdown', 'data': { '*mode': 'str' },
-  'success-response': false }
+  'success-response': false,
+  'features': [ 'confidential' ] }
 
 ##
 # @guest-file-open:
@@ -457,11 +480,13 @@
 #
 # @fs-frozen: permitted when filesystems are frozen
 #
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-status',
   'returns': 'GuestFsfreezeStatus',
-  'features': [ 'fs-frozen'],
+  'features': [ 'fs-frozen', 'confidential' ],
   'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
@@ -481,10 +506,15 @@
 #     Volume Shadow-copy Service DLL helper.  The frozen state is
 #     limited for up to 10 seconds by VSS.
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-freeze',
   'returns': 'int',
+  'features': [ 'confidential' ],
   'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
@@ -501,11 +531,16 @@
 #
 # Returns: Number of file systems currently frozen.
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 2.2
 ##
 { 'command': 'guest-fsfreeze-freeze-list',
   'data':    { '*mountpoints': ['str'] },
   'returns': 'int',
+  'features': [ 'confidential' ],
   'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
@@ -524,11 +559,13 @@
 #
 # @fs-frozen: permitted when filesystems are frozen
 #
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-thaw',
   'returns': 'int',
-  'features': [ 'fs-frozen'],
+  'features': [ 'fs-frozen', 'confidential' ],
   'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
@@ -576,11 +613,16 @@
 # Returns: A @GuestFilesystemTrimResponse which contains the status of
 #     all trimmed paths.  (since 2.4)
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 1.2
 ##
 { 'command': 'guest-fstrim',
   'data': { '*minimum': 'int' },
   'returns': 'GuestFilesystemTrimResponse',
+  'features': [ 'confidential' ],
   'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
 
 ##
@@ -608,9 +650,14 @@
 # Notes: It's strongly recommended to issue the guest-sync command
 #     before sending commands when the guest resumes
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 1.1
 ##
 { 'command': 'guest-suspend-disk', 'success-response': false,
+  'features': [ 'confidential' ],
   'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
@@ -645,9 +692,14 @@
 # Notes: It's strongly recommended to issue the guest-sync command
 #     before sending commands when the guest resumes
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 1.1
 ##
 { 'command': 'guest-suspend-ram', 'success-response': false,
+  'features': [ 'confidential' ],
   'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
@@ -681,9 +733,14 @@
 # Notes: It's strongly recommended to issue the guest-sync command
 #     before sending commands when the guest resumes
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 1.1
 ##
 { 'command': 'guest-suspend-hybrid', 'success-response': false,
+  'features': [ 'confidential' ],
   'if': 'CONFIG_LINUX' }
 
 ##
@@ -815,10 +872,15 @@
 # Returns: The list of all VCPUs the guest knows about.  Each VCPU is
 #     put on the list exactly once, but their order is unspecified.
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 1.5
 ##
 { 'command': 'guest-get-vcpus',
   'returns': ['GuestLogicalProcessor'],
+  'features': [ 'confidential' ],
   'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
@@ -857,11 +919,16 @@
 #     - If the reconfiguration of the first node in @vcpus failed.
 #       Guest state has not been changed.
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 1.5
 ##
 { 'command': 'guest-set-vcpus',
   'data':    {'vcpus': ['GuestLogicalProcessor'] },
   'returns': 'int',
+  'features': [ 'confidential' ],
   'if': 'CONFIG_LINUX' }
 
 ##
@@ -1180,10 +1247,15 @@
 #     memory block is put on the list exactly once, but their order is
 #     unspecified.
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 2.3
 ##
 { 'command': 'guest-get-memory-blocks',
   'returns': ['GuestMemoryBlock'],
+  'features': [ 'confidential' ],
   'if': 'CONFIG_LINUX' }
 
 ##
@@ -1254,11 +1326,16 @@
 #     empty on input, or there is an error, and in this case, guest
 #     state will not be changed.
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 2.3
 ##
 { 'command': 'guest-set-memory-blocks',
   'data':    {'mem-blks': ['GuestMemoryBlock'] },
   'returns': ['GuestMemoryBlockResponse'],
+  'features': [ 'confidential' ],
   'if': 'CONFIG_LINUX' }
 
 ##
@@ -1268,10 +1345,15 @@
 #     minimal units of memory block online/offline operations (also
 #     called Logical Memory Hotplug).
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 2.3
 ##
 { 'struct': 'GuestMemoryBlockInfo',
   'data': {'size': 'uint64'},
+  'features': [ 'confidential' ],
   'if': 'CONFIG_LINUX' }
 
 ##
@@ -1281,10 +1363,15 @@
 #
 # Returns: @GuestMemoryBlockInfo
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 2.3
 ##
 { 'command': 'guest-get-memory-block-info',
   'returns': 'GuestMemoryBlockInfo',
+  'features': [ 'confidential' ],
   'if': 'CONFIG_LINUX' }
 
 ##
@@ -1430,10 +1517,15 @@
 #
 # Returns: the host name of the machine
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 2.10
 ##
 { 'command': 'guest-get-host-name',
-  'returns': 'GuestHostName' }
+  'returns': 'GuestHostName',
+  'features': [ 'confidential' ] }
 
 
 ##
@@ -1882,9 +1974,14 @@
 #
 # Returns: List of CPU stats of guest.
 #
+# Features:
+#
+# @confidential: permitted when running inside a confidential VM
+#
 # Since: 7.1
 ##
 { 'command': 'guest-get-cpustats',
   'returns': ['GuestCpuStats'],
+  'features': [ 'confidential' ],
   'if': 'CONFIG_LINUX'
 }
-- 
2.45.1


