Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED29CA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkw-0007uA-Uj; Wed, 30 Sep 2026 06:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj3-0001eh-Hu
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrin-0006r0-TF
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jjNmRV5a7qMI1BELjh79U/bE5Wl8jSHkKGlbAFFXW8=;
 b=Mfld73cjWF4098yhxtPvnsjLrjCGz2YTez0/QC5WnypVxA9R0xysoKDChZnfJjDt1rtash
 ZIxeZI3OHPHX0KYesqBT+nX9rVDFzMIxWMuPO0n5oxANaB2GF0WmPRGzCX+e+ESxjr29o+
 olNxpk+47alPwk5xMv2jHyqFD8qGMDg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-bnP_5o3xNjijcPvldwlIZQ-1; Wed,
 30 Sep 2026 06:39:29 -0400
X-MC-Unique: bnP_5o3xNjijcPvldwlIZQ-1
X-Mimecast-MFC-AGG-ID: bnP_5o3xNjijcPvldwlIZQ_1790764768
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E8CA19540D8; Wed, 30 Sep 2026 10:39:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E39311800591; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1137221E656D; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 090/105] qapi: convert trivial intros for qga/qapi-schema.json
Date: Wed, 30 Sep 2026 12:38:55 +0200
Message-ID: <20260930103910.3934848-91-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

These are all single-sentence introductions immediately followed by a
non-plaintext section; no new insertion point is created.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260922205605.501602-4-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 137 +++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 89 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 8cd0ba048b..90110af573 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -120,8 +120,7 @@
 
 ##
 # @guest-ping:
-#
-# Ping the guest agent, a non-error return implies success
+#     Ping the guest agent, a non-error return implies success
 #
 # Since: 0.15.0
 ##
@@ -129,9 +128,8 @@
 
 ##
 # @guest-get-time:
-#
-# Get the information about guest's System Time relative to the Epoch
-# of 1970-01-01 in UTC.
+#     Get the information about guest's System Time relative to the
+#     Epoch of 1970-01-01 in UTC.
 #
 # Returns: Time in nanoseconds.
 #
@@ -168,8 +166,7 @@
 
 ##
 # @GuestAgentCommandInfo:
-#
-# Information about guest agent commands.
+#     Information about guest agent commands.
 #
 # @name: name of the command
 #
@@ -185,8 +182,7 @@
 
 ##
 # @GuestAgentInfo:
-#
-# Information about guest agent.
+#     Information about guest agent.
 #
 # @version: guest agent version
 #
@@ -200,8 +196,7 @@
 
 ##
 # @guest-info:
-#
-# Get some information about the guest agent.
+#     Get some information about the guest agent.
 #
 # Since: 0.15.0
 ##
@@ -228,8 +223,7 @@
 
 ##
 # @guest-file-open:
-#
-# Open a file in the guest and retrieve a file handle for it
+#     Open a file in the guest and retrieve a file handle for it
 #
 # @path: Full path to the file in the guest to open.
 #
@@ -245,8 +239,7 @@
 
 ##
 # @guest-file-close:
-#
-# Close an open file in the guest
+#     Close an open file in the guest
 #
 # @handle: filehandle returned by `guest-file-open`
 #
@@ -257,8 +250,7 @@
 
 ##
 # @GuestFileRead:
-#
-# Result of guest agent file-read operation
+#     Result of guest agent file-read operation
 #
 # @count: number of bytes read (note: count is *before*
 #     base64-encoding is applied)
@@ -292,8 +284,7 @@
 
 ##
 # @GuestFileWrite:
-#
-# Result of guest agent file-write operation
+#     Result of guest agent file-write operation
 #
 # @count: number of bytes written (note: count is actual bytes
 #     written, after base64-decoding of provided buffer)
@@ -307,8 +298,7 @@
 
 ##
 # @guest-file-write:
-#
-# Write to an open file in the guest.
+#     Write to an open file in the guest.
 #
 # @handle: filehandle returned by `guest-file-open`
 #
@@ -325,8 +315,7 @@
 
 ##
 # @GuestFileSeek:
-#
-# Result of guest agent file-seek operation
+#     Result of guest agent file-seek operation
 #
 # @position: current file position
 #
@@ -339,8 +328,7 @@
 
 ##
 # @QGASeek:
-#
-# Symbolic names for use in `guest-file-seek`
+#     Symbolic names for use in `guest-file-seek`
 #
 # @set: Set to the specified offset (same effect as 'whence':0)
 #
@@ -354,8 +342,7 @@
 
 ##
 # @GuestFileWhence:
-#
-# Controls the meaning of offset to `guest-file-seek`.
+#     Controls the meaning of offset to `guest-file-seek`.
 #
 # @value: Integral value (0 for set, 1 for cur, 2 for end), available
 #     for historical reasons, and might differ from the host's or
@@ -390,8 +377,7 @@
 
 ##
 # @guest-file-flush:
-#
-# Write file changes buffered in userspace to disk/kernel buffers
+#     Write file changes buffered in userspace to disk/kernel buffers
 #
 # @handle: filehandle returned by `guest-file-open`
 #
@@ -402,8 +388,7 @@
 
 ##
 # @GuestFsfreezeStatus:
-#
-# An enumeration of filesystem freeze states
+#     An enumeration of filesystem freeze states
 #
 # @thawed: filesystems thawed/unfrozen
 #
@@ -476,8 +461,7 @@
 
 ##
 # @guest-fsfreeze-thaw:
-#
-# Unfreeze all frozen guest filesystems
+#     Unfreeze all frozen guest filesystems
 #
 # Returns: Number of file systems thawed by this call
 #
@@ -524,8 +508,8 @@
 
 ##
 # @guest-fstrim:
-#
-# Discard (or "trim") blocks which are not in use by the filesystem.
+#     Discard (or "trim") blocks which are not in use by the
+#     filesystem.
 #
 # @minimum: Minimum contiguous free range to discard, in bytes.  Free
 #     ranges smaller than this may be ignored (this is a hint and the
@@ -649,8 +633,7 @@
 
 ##
 # @GuestIpAddressType:
-#
-# An enumeration of supported IP address types
+#     An enumeration of supported IP address types
 #
 # @ipv4: IP version 4
 #
@@ -735,8 +718,7 @@
 
 ##
 # @guest-network-get-interfaces:
-#
-# Get list of guest IP addresses, MAC addresses and netmasks.
+#     Get list of guest IP addresses, MAC addresses and netmasks.
 #
 # Since: 1.1
 ##
@@ -782,9 +764,8 @@
 
 ##
 # @guest-set-vcpus:
-#
-# Attempt to reconfigure (currently: enable/disable) logical
-# processors inside the guest.
+#     Attempt to reconfigure (currently: enable/disable) logical
+#     processors inside the guest.
 #
 # @vcpus: The logical processors to be reconfigured.  This list is
 #     processed node by node in order.  In each node @logical-id is
@@ -825,8 +806,7 @@
 
 ##
 # @GuestDiskBusType:
-#
-# An enumeration of bus type of disks
+#     An enumeration of bus type of disks
 #
 # @ide: IDE disks
 #
@@ -984,8 +964,7 @@
 
 ##
 # @GuestDiskSmart:
-#
-# Disk type related smart information.
+#     Disk type related smart information.
 #
 # @type: disk bus type
 #
@@ -1147,8 +1126,7 @@
 
 ##
 # @GuestMemoryBlockResponseType:
-#
-# An enumeration of memory block operation result.
+#     An enumeration of memory block operation result.
 #
 # @success: the operation of online/offline memory block is
 #     successful.
@@ -1191,9 +1169,8 @@
 
 ##
 # @guest-set-memory-blocks:
-#
-# Attempt to reconfigure (currently: enable/disable) state of memory
-# blocks inside the guest.
+#     Attempt to reconfigure (currently: enable/disable) state of
+#     memory blocks inside the guest.
 #
 # @mem-blks: The memory blocks to be reconfigured.  This list is
 #     processed node by node in order.  In each node @phys-index is
@@ -1236,8 +1213,7 @@
 
 ##
 # @guest-get-memory-block-info:
-#
-# Get information relating to guest memory blocks.
+#     Get information relating to guest memory blocks.
 #
 # Since: 2.3
 ##
@@ -1303,8 +1279,7 @@
 
 ##
 # @GuestExecCaptureOutputMode:
-#
-# An enumeration of `guest-exec` capture modes.
+#     An enumeration of `guest-exec` capture modes.
 #
 # @none: do not capture any output
 #
@@ -1326,8 +1301,7 @@
 
 ##
 # @GuestExecCaptureOutput:
-#
-# Controls what `guest-exec` output gets captures.
+#     Controls what `guest-exec` output gets captures.
 #
 # @flag: captures both stdout and stderr if true.  Equivalent to
 #     `GuestExecCaptureOutputMode`::all.  (since 2.5)
@@ -1342,8 +1316,7 @@
 
 ##
 # @guest-exec:
-#
-# Execute a command in the guest
+#     Execute a command in the guest
 #
 # @path: path or executable name to execute
 #
@@ -1411,8 +1384,7 @@
 
 ##
 # @guest-get-users:
-#
-# Retrieves a list of currently active users on the VM.
+#     Retrieves a list of currently active users on the VM.
 #
 # Returns: A unique list of users.
 #
@@ -1438,8 +1410,7 @@
 
 ##
 # @guest-get-timezone:
-#
-# Retrieves the timezone information from the guest.
+#     Retrieves the timezone information from the guest.
 #
 # Since: 2.10
 ##
@@ -1512,8 +1483,7 @@
 
 ##
 # @guest-get-osinfo:
-#
-# Retrieve guest operating system information
+#     Retrieve guest operating system information
 #
 # Since: 2.10
 ##
@@ -1544,8 +1514,7 @@
 
 ##
 # @GuestDeviceId:
-#
-# Id of the device
+#     Id of the device
 #
 # @type: device type
 #
@@ -1581,8 +1550,7 @@
 
 ##
 # @guest-get-devices:
-#
-# Retrieve information about device drivers in Windows guest
+#     Retrieve information about device drivers in Windows guest
 #
 # Since: 5.2
 ##
@@ -1605,9 +1573,8 @@
 
 ##
 # @guest-ssh-get-authorized-keys:
-#
-# Return the public keys from user .ssh/authorized_keys on Unix
-# systems (not implemented for other systems).
+#     Return the public keys from user .ssh/authorized_keys on Unix
+#     systems (not implemented for other systems).
 #
 # @username: the user account to add the authorized keys
 #
@@ -1620,9 +1587,8 @@
 
 ##
 # @guest-ssh-add-authorized-keys:
-#
-# Append public keys to user .ssh/authorized_keys on Unix systems (not
-# implemented for other systems).
+#     Append public keys to user .ssh/authorized_keys on Unix systems
+#     (not implemented for other systems).
 #
 # @username: the user account to add the authorized keys
 #
@@ -1736,8 +1702,7 @@
 
 ##
 # @guest-get-diskstats:
-#
-# Retrieve information about disk stats.
+#     Retrieve information about disk stats.
 #
 # Returns: List of disk stats of guest.
 #
@@ -1750,8 +1715,7 @@
 
 ##
 # @GuestCpuStatsType:
-#
-# Guest operating systems supporting CPU statistics
+#     Guest operating systems supporting CPU statistics
 #
 # @linux: Linux
 #
@@ -1763,8 +1727,7 @@
 
 ##
 # @GuestLinuxCpuStats:
-#
-# CPU statistics of Linux
+#     CPU statistics of Linux
 #
 # @cpu: CPU index in guest OS
 #
@@ -1808,8 +1771,7 @@
 
 ##
 # @GuestCpuStats:
-#
-# Get statistics of each CPU in millisecond.
+#     Get statistics of each CPU in millisecond.
 #
 # @type: guest operating system
 #
@@ -1823,8 +1785,7 @@
 
 ##
 # @guest-get-cpustats:
-#
-# Retrieve information about CPU stats.
+#     Retrieve information about CPU stats.
 #
 # Returns: List of CPU stats of guest.
 #
@@ -1837,8 +1798,7 @@
 
 ##
 # @GuestLoadAverage:
-#
-# Statistics about process load information
+#     Statistics about process load information
 #
 # @load1m: 1-minute load avage
 #
@@ -1941,8 +1901,7 @@
 
 ##
 # @guest-network-get-route:
-#
-# Retrieve information about route of network.
+#     Retrieve information about route of network.
 #
 # Returns: List of route info of guest.
 #
-- 
2.55.0


