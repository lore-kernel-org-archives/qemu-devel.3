Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0413C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucJsX-0005oU-NU; Thu, 17 Jul 2025 04:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucJrv-0005Cp-1B
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucJrp-0000wU-JH
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752740484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xAwGXP+CStL0izplHa1IHGOqPpERz0L6soxz47mg7c=;
 b=cb6KzZ+7WuFEygpXhze9pl8HQUbk01nocx2UAlsV3GQpj07PTAQC3pe5Tbtzl2n3DStwMD
 TMeajUz7sHriw0fxkp2Ok+v2YvyvpWO8sDW4vo/0S4RWm1Rd+vPCK3r+qOXX0F0Dt7nO3/
 MOqg/WvJXKfQreBSjMNo0bJktMB03e8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-g4ZgAooiNQSzk9tyciaCig-1; Thu,
 17 Jul 2025 04:21:21 -0400
X-MC-Unique: g4ZgAooiNQSzk9tyciaCig-1
X-Mimecast-MFC-AGG-ID: g4ZgAooiNQSzk9tyciaCig_1752740481
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22B6E18004A7; Thu, 17 Jul 2025 08:21:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5903530001BE; Thu, 17 Jul 2025 08:21:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC34021E675E; Thu, 17 Jul 2025 10:21:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 jsnow@redhat.com
Subject: [PATCH 4/4] qga: Add cross-references
Date: Thu, 17 Jul 2025 10:21:17 +0200
Message-ID: <20250717082117.3767754-5-armbru@redhat.com>
In-Reply-To: <20250717082117.3767754-1-armbru@redhat.com>
References: <20250717082117.3767754-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Enclose command and type names in `backquotes`, so they become links
in generated HTML.

We did this for qapi/ in merge commit 504632dcc631.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 50 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 6c26ace3c9..31d454999f 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -96,11 +96,11 @@
 # In cases where a partial stale response was previously received by
 # the client, this cannot always be done reliably.  One particular
 # scenario being if qemu-ga responses are fed character-by-character
-# into a JSON parser.  In these situations, using guest-sync-delimited
+# into a JSON parser.  In these situations, using `guest-sync-delimited`
 # may be optimal.
 #
 # For clients that fetch responses line by line and convert them to
-# JSON objects, guest-sync should be sufficient, but note that in
+# JSON objects, `guest-sync` should be sufficient, but note that in
 # cases where the channel is dirty some attempts at parsing the
 # response may result in a parser error.
 #
@@ -247,7 +247,7 @@
 #
 # Close an open file in the guest
 #
-# @handle: filehandle returned by guest-file-open
+# @handle: filehandle returned by `guest-file-open`
 #
 # Since: 0.15.0
 ##
@@ -278,7 +278,7 @@
 # As this command is just for limited, ad-hoc debugging, such as log
 # file access, the number of bytes to read is limited to 48 MB.
 #
-# @handle: filehandle returned by guest-file-open
+# @handle: filehandle returned by `guest-file-open`
 #
 # @count: maximum number of bytes to read (default is 4KB, maximum is
 #     48MB)
@@ -309,7 +309,7 @@
 #
 # Write to an open file in the guest.
 #
-# @handle: filehandle returned by guest-file-open
+# @handle: filehandle returned by `guest-file-open`
 #
 # @buf-b64: base64-encoded string representing data to be written
 #
@@ -340,7 +340,7 @@
 ##
 # @QGASeek:
 #
-# Symbolic names for use in @guest-file-seek
+# Symbolic names for use in `guest-file-seek`
 #
 # @set: Set to the specified offset (same effect as 'whence':0)
 #
@@ -355,7 +355,7 @@
 ##
 # @GuestFileWhence:
 #
-# Controls the meaning of offset to @guest-file-seek.
+# Controls the meaning of offset to `guest-file-seek`.
 #
 # @value: Integral value (0 for set, 1 for cur, 2 for end), available
 #     for historical reasons, and might differ from the host's or
@@ -375,7 +375,7 @@
 # current file position afterward.  Also encapsulates ftell()'s
 # functionality, with offset=0 and whence=1.
 #
-# @handle: filehandle returned by guest-file-open
+# @handle: filehandle returned by `guest-file-open`
 #
 # @offset: bytes to skip over in the file stream
 #
@@ -393,7 +393,7 @@
 #
 # Write file changes buffered in userspace to disk/kernel buffers
 #
-# @handle: filehandle returned by guest-file-open
+# @handle: filehandle returned by `guest-file-open`
 #
 # Since: 0.15.0
 ##
@@ -434,12 +434,12 @@
 # @guest-fsfreeze-freeze:
 #
 # Sync and freeze all freezable, local guest filesystems.  If this
-# command succeeded, you may call @guest-fsfreeze-thaw later to
+# command succeeded, you may call `guest-fsfreeze-thaw` later to
 # unfreeze.
 #
 # On error, all filesystems will be thawed.  If no filesystems are
-# frozen as a result of this call, then @guest-fsfreeze-status will
-# remain "thawed" and calling @guest-fsfreeze-thaw is not necessary.
+# frozen as a result of this call, then `guest-fsfreeze-status` will
+# remain "thawed" and calling `guest-fsfreeze-thaw` is not necessary.
 #
 # Returns: Number of file systems currently frozen.
 #
@@ -457,7 +457,7 @@
 # @guest-fsfreeze-freeze-list:
 #
 # Sync and freeze specified guest filesystems.  See also
-# @guest-fsfreeze-freeze.
+# `guest-fsfreeze-freeze`.
 #
 # On error, all filesystems will be thawed.
 #
@@ -482,7 +482,7 @@
 # Returns: Number of file systems thawed by this call
 #
 # .. note:: If the return value does not match the previous call to
-#    guest-fsfreeze-freeze, this likely means some freezable filesystems
+#    `guest-fsfreeze-freeze`, this likely means some freezable filesystems
 #    were unfrozen before this call, and that the filesystem state may
 #    have changed before issuing this command.
 #
@@ -513,7 +513,7 @@
 ##
 # @GuestFilesystemTrimResponse:
 #
-# @paths: list of @GuestFilesystemTrimResult per path that was trimmed
+# @paths: list of `GuestFilesystemTrimResult` per path that was trimmed
 #
 # Since: 2.4
 ##
@@ -565,7 +565,7 @@
 # Errors:
 #     - If suspend to disk is not supported, Unsupported
 #
-# .. note:: It's strongly recommended to issue the guest-sync command
+# .. note:: It's strongly recommended to issue the `guest-sync` command
 #    before sending commands when the guest resumes.
 #
 # Since: 1.1
@@ -585,7 +585,7 @@
 # - pm-utils (via pm-hibernate)
 # - manual write into sysfs
 #
-# IMPORTANT: guest-suspend-ram requires working wakeup support in
+# IMPORTANT: `guest-suspend-ram` requires working wakeup support in
 # QEMU. You should check QMP command query-current-machine returns
 # wakeup-suspend-support: true before issuing this command.  Failure
 # in doing so can result in a suspended guest that QEMU will not be
@@ -602,7 +602,7 @@
 # Errors:
 #     - If suspend to ram is not supported, Unsupported
 #
-# .. note:: It's strongly recommended to issue the guest-sync command
+# .. note:: It's strongly recommended to issue the `guest-sync` command
 #    before sending commands when the guest resumes.
 #
 # Since: 1.1
@@ -621,7 +621,7 @@
 # - systemd hybrid-sleep
 # - pm-utils (via pm-suspend-hybrid)
 #
-# IMPORTANT: guest-suspend-hybrid requires working wakeup support in
+# IMPORTANT: `guest-suspend-hybrid` requires working wakeup support in
 # QEMU. You should check QMP command query-current-machine returns
 # wakeup-suspend-support: true before issuing this command.  Failure
 # in doing so can result in a suspended guest that QEMU will not be
@@ -638,7 +638,7 @@
 # Errors:
 #     - If hybrid suspend is not supported, Unsupported
 #
-# .. note:: It's strongly recommended to issue the guest-sync command
+# .. note:: It's strongly recommended to issue the `guest-sync` command
 #    before sending commands when the guest resumes.
 #
 # Since: 1.1
@@ -1171,7 +1171,7 @@
 ##
 # @GuestMemoryBlockResponse:
 #
-# @phys-index: same with the 'phys-index' member of @GuestMemoryBlock.
+# @phys-index: same with the 'phys-index' member of `GuestMemoryBlock`.
 #
 # @response: the result of memory block operation.
 #
@@ -1277,10 +1277,10 @@
 # @guest-exec-status:
 #
 # Check status of process associated with PID retrieved via
-# guest-exec.  Reap the process and associated metadata if it has
+# `guest-exec`.  Reap the process and associated metadata if it has
 # exited.
 #
-# @pid: pid returned from guest-exec
+# @pid: pid returned from `guest-exec`
 #
 # Since: 2.5
 ##
@@ -1301,7 +1301,7 @@
 ##
 # @GuestExecCaptureOutputMode:
 #
-# An enumeration of guest-exec capture modes.
+# An enumeration of `guest-exec` capture modes.
 #
 # @none: do not capture any output
 #
@@ -1324,7 +1324,7 @@
 ##
 # @GuestExecCaptureOutput:
 #
-# Controls what guest-exec output gets captures.
+# Controls what `guest-exec` output gets captures.
 #
 # @flag: captures both stdout and stderr if true.  Equivalent to
 #     GuestExecCaptureOutputMode::all.  (since 2.5)
-- 
2.49.0


