Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C4607BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dn20wA0+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtSl-0005aC-N8; Mon, 02 Nov 2026 09:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtSe-0005V3-Gw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:56:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtSc-0001tT-DH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793631392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GAVfXa0OBdk6ckNZk50zCZW/qXMMI9eVpmxxM8dhmVo=;
 b=dn20wA0+/omRV6cU/ccu4QO2FdDlHtR/P+7KjcloBQxNNifvaymK0C+7Fr+C4J+26CWBmx
 Cvia/exWq+Rp+lOCFEB+Sz1Bq+WtwGWF7hiqeW1oQMDKz/o7TfrvQeLFOmqxQeuxzWBjPD
 mYxQrr6AedXhs3VgDNEBgYUh/gAnZKg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-QCcLtGRaNiaGZXg3VjPjtg-1; Mon,
 02 Nov 2026 09:56:31 -0500
X-MC-Unique: QCcLtGRaNiaGZXg3VjPjtg-1
X-Mimecast-MFC-AGG-ID: QCcLtGRaNiaGZXg3VjPjtg_1793631390
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17ECB195605C
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 14:56:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CC7318000A3
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 14:56:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A3A121E6884; Mon, 02 Nov 2026 15:56:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	jsnow@redhat.com
Subject: [PATCH] qapi: Consistently use x.y with since
Date: Mon,  2 Nov 2026 15:56:27 +0100
Message-ID: <20261102145627.3224952-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

docs/devel/qapi-code-gen.rst documents "Since: x.y.z" and "(since
x.y.z)", but we almost always use just x.y.  Adjust the doc and the
exceptions to the ruling practice.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst |  4 ++--
 docs/interop/firmware.json   |  4 ++--
 qapi/accelerator.json        |  6 +++---
 qapi/crypto.json             |  2 +-
 qga/qapi-schema.json         | 38 ++++++++++++++++++------------------
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index b1cc5b5f0d..f276a2bc9b 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1001,7 +1001,7 @@ indented like this::
 .. FIXME union branches should be described, too.
 
 Extensions added after the definition was first released carry a
-"(since x.y.z)" comment.
+"(since x.y)" comment.
 
 The feature descriptions must be preceded by a blank line and then a
 line "Features:", like this::
@@ -1034,7 +1034,7 @@ detailing a relevant error condition.  For example::
  #     - If @device does not exist, DeviceNotFound
  #     - Any other error returns a GenericError.
 
-A "Since: x.y.z" tagged section lists the release that introduced the
+A "Since: x.y" tagged section lists the release that introduced the
 definition.
 
 "TODO" sections are not rendered (they are for developers, not users of
diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 1efd32c631..c8bf0ef1a1 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -283,7 +283,7 @@
 #     and can be shared between multiple guests.  No NVRAM template
 #     will be specified.
 #
-# Since: 7.0.0
+# Since: 7.0
 ##
 { 'enum': 'FirmwareFlashMode',
   'data': [ 'split', 'combined', 'stateless' ] }
@@ -296,7 +296,7 @@
 #
 # @mode: Describes how the firmware build handles code versus variable
 #     storage.  If not present, it must be treated as if it was
-#     configured with value @split.  Since: 7.0.0
+#     configured with value @split.  (Since: 7.0)
 #
 # @executable: Identifies the firmware executable.  The @mode
 #     indicates whether there will be an associated NVRAM template
diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index efc0fa8141..e422fc7ee6 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -78,7 +78,7 @@
 #
 # @xen: Xen
 #
-# Since: 10.2.0
+# Since: 10.2
 ##
 { 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'mshv', 'nvmm', 'qtest', 'tcg', 'whpx', 'xen'] }
 
@@ -91,7 +91,7 @@
 # @present: the list of accelerators that are built into this
 #     executable
 #
-# Since: 10.2.0
+# Since: 10.2
 ##
 { 'struct': 'AcceleratorInfo', 'data': {'enabled': 'Accelerator', 'present': ['Accelerator']} }
 
@@ -101,7 +101,7 @@
 #
 # Returns: @AcceleratorInfo
 #
-# Since: 10.2.0
+# Since: 10.2
 #
 # .. qmp-example::
 #
diff --git a/qapi/crypto.json b/qapi/crypto.json
index a8d753d360..0fd1af1b68 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -57,7 +57,7 @@
 #
 # @ripemd160: RIPEMD-160.  (since 2.7)
 #
-# @sm3: SM3.  (since 9.2.0)
+# @sm3: SM3.  (since 9.2)
 #
 # Since: 2.6
 ##
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 7b937713e6..531fb8f8e0 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -110,7 +110,7 @@
 #
 # Returns: The unique integer id passed in by the client
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-sync',
   'data':    { 'id': 'int' },
@@ -120,7 +120,7 @@
 # @guest-ping:
 #     Ping the guest agent, a non-error return implies success
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-ping' }
 
@@ -172,7 +172,7 @@
 # @success-response: whether command returns a response on success
 #     (since 1.7)
 #
-# Since: 1.1.0
+# Since: 1.1
 ##
 { 'struct': 'GuestAgentCommandInfo',
   'data': { 'name': 'str', 'enabled': 'bool', 'success-response': 'bool' } }
@@ -185,7 +185,7 @@
 #
 # @supported_commands: Information about guest agent commands
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'struct': 'GuestAgentInfo',
   'data': { 'version': 'str',
@@ -195,7 +195,7 @@
 # @guest-info:
 #     Get some information about the guest agent.
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-info',
   'returns': 'GuestAgentInfo' }
@@ -213,7 +213,7 @@
 # when running with --no-shutdown, by issuing the `query-status` QMP
 # command to confirm the VM status is "shutdown".
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-shutdown', 'data': { '*mode': 'str' },
   'success-response': false }
@@ -228,7 +228,7 @@
 #
 # Returns: Guest file handle
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-file-open',
   'data':    { 'path': 'str', '*mode': 'str' },
@@ -240,7 +240,7 @@
 #
 # @handle: filehandle returned by `guest-file-open`
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-file-close',
   'data': { 'handle': 'int' } }
@@ -256,7 +256,7 @@
 #
 # @eof: whether EOF was encountered during read operation.
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'struct': 'GuestFileRead',
   'data': { 'count': 'int', 'buf-b64': 'str', 'eof': 'bool' } }
@@ -273,7 +273,7 @@
 # @count: maximum number of bytes to read (default is 4KB, maximum is
 #     48MB)
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-file-read',
   'data':    { 'handle': 'int', '*count': 'int' },
@@ -288,7 +288,7 @@
 #
 # @eof: whether EOF was encountered during write operation.
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'struct': 'GuestFileWrite',
   'data': { 'count': 'int', 'eof': 'bool' } }
@@ -304,7 +304,7 @@
 # @count: bytes to write (actual bytes, after base64-decode), default
 #     is all content in buf-b64 buffer after base64 decoding
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-file-write',
   'data':    { 'handle': 'int', 'buf-b64': 'str', '*count': 'int' },
@@ -318,7 +318,7 @@
 #
 # @eof: whether EOF was encountered during file seek
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'struct': 'GuestFileSeek',
   'data': { 'position': 'int', 'eof': 'bool' } }
@@ -364,7 +364,7 @@
 #
 # @whence: Symbolic or numeric code for interpreting offset
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-file-seek',
   'data':    { 'handle': 'int', 'offset': 'int',
@@ -377,7 +377,7 @@
 #
 # @handle: filehandle returned by `guest-file-open`
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-file-flush',
   'data': { 'handle': 'int' } }
@@ -390,7 +390,7 @@
 #
 # @frozen: all non-network guest filesystems frozen
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'enum': 'GuestFsfreezeStatus',
   'data': [ 'thawed', 'frozen' ],
@@ -404,7 +404,7 @@
 #    result of some other guest processes having issued an fs
 #    freeze/thaw.
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-fsfreeze-status',
   'returns': 'GuestFsfreezeStatus',
@@ -427,7 +427,7 @@
 #    Volume Shadow-copy Service DLL helper.  The frozen state is
 #    limited for up to 10 seconds by VSS.
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-fsfreeze-freeze',
   'returns': 'int',
@@ -464,7 +464,7 @@
 #    filesystems were unfrozen before this call, and that the
 #    filesystem state may have changed before issuing this command.
 #
-# Since: 0.15.0
+# Since: 0.15
 ##
 { 'command': 'guest-fsfreeze-thaw',
   'returns': 'int',
-- 
2.55.0


