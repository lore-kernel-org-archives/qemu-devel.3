Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7477C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSOv-0006QN-IC; Mon, 12 Feb 2024 04:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOk-0006Kv-Ib
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOg-0003ck-QM
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKntLsGrFtedbI7s+XI7zBKuLM1M07ucXmU+tyll0u4=;
 b=cVabqJTy1bT8kjbVUTajS73mpQhla+QAITID9CtCFRMl9euRnzv65MGJSWzeQMqvIMQS6W
 nQ/5rkQNrx2Jx7HW/9YXjmBWlKA/cgEBv4sHJjzA1Gs4ja4HBbA6MVlvZc8gzZ5RTYdhzo
 zUGwUKioy7k92FyDxT4NA6Q6Rw62gzI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-7SNryyq2M8K69ri479lf7Q-1; Mon, 12 Feb 2024 04:14:40 -0500
X-MC-Unique: 7SNryyq2M8K69ri479lf7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 183BE831019;
 Mon, 12 Feb 2024 09:14:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCAC620BB064;
 Mon, 12 Feb 2024 09:14:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 884B821E60DD; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/18] qapi: Require member documentation (with loophole)
Date: Mon, 12 Feb 2024 10:14:24 +0100
Message-ID: <20240212091436.688598-7-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
References: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The QAPI generator forces you to document your stuff.  Except for
command arguments, event data, and members of enum and object types:
these the generator silently "documents" as "Not documented".

We can't require proper documentation there without first fixing all
the offenders.  We've always had too many offenders to pull that off.
Right now, we have more than 500.  Worse, we seem to fix old ones no
faster than we add new ones: in the past year, we fixed 22 ones, but
added 26 new ones.

To help arrest the backsliding, make missing documentation an error
unless the command, type, or event is in listed in new pragma
documentation-exceptions.

List all the current offenders: 117 commands and types in qapi/, and 9
in qga/.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240205074709.3613229-7-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/qapi-code-gen.rst                  |   5 +
 qapi/pragma.json                              | 119 ++++++++++++++++++
 qga/qapi-schema.json                          |  13 +-
 scripts/qapi/parser.py                        |   7 +-
 scripts/qapi/source.py                        |   2 +
 .../qapi-schema/doc-bad-alternate-member.json |   2 +
 tests/qapi-schema/doc-good.json               |   4 +-
 7 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 69c8a1e8bd..756adc187e 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -167,6 +167,7 @@ Syntax::
                    '*doc-required': BOOL,
                    '*command-name-exceptions': [ STRING, ... ],
                    '*command-returns-exceptions': [ STRING, ... ],
+                   '*documentation-exceptions': [ STRING, ... ],
                    '*member-name-exceptions': [ STRING, ... ] } }
 
 The pragma directive lets you control optional generator behavior.
@@ -183,6 +184,10 @@ may contain ``"_"`` instead of ``"-"``.  Default is none.
 Pragma 'command-returns-exceptions' takes a list of commands that may
 violate the rules on permitted return types.  Default is none.
 
+Pragma 'documentation-exceptions' takes a list of types, commands, and
+events whose members / arguments need not be documented.  Default is
+none.
+
 Pragma 'member-name-exceptions' takes a list of types whose member
 names may contain uppercase letters, and ``"_"`` instead of ``"-"``.
 Default is none.
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 0aa4eeddd3..0fa64742b5 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -31,6 +31,125 @@
         'query-tpm-models',
         'query-tpm-types',
         'ringbuf-read' ],
+    # Types, commands, and events with undocumented members / arguments:
+    'documentation-exceptions': [
+        'AbortWrapper',
+        'AudiodevDriver',
+        'BlkdebugEvent',
+        'BlockDirtyBitmapAddWrapper',
+        'BlockDirtyBitmapMergeWrapper',
+        'BlockDirtyBitmapWrapper',
+        'BlockExportOptions',
+        'BlockStatsSpecific',
+        'BlockdevBackupWrapper',
+        'BlockdevDriver',
+        'BlockdevQcow2Encryption',
+        'BlockdevQcow2EncryptionFormat',
+        'BlockdevQcowEncryption',
+        'BlockdevSnapshotInternalWrapper',
+        'BlockdevSnapshotSyncWrapper',
+        'BlockdevSnapshotWrapper',
+        'BlockdevVmdkAdapterType',
+        'ChardevBackend',
+        'ChardevBackendKind',
+        'ChardevCommonWrapper',
+        'ChardevDBusWrapper',
+        'ChardevFileWrapper',
+        'ChardevHostdevWrapper',
+        'ChardevMuxWrapper',
+        'ChardevQemuVDAgentWrapper',
+        'ChardevRingbufWrapper',
+        'ChardevSocketWrapper',
+        'ChardevSpiceChannelWrapper',
+        'ChardevSpicePortWrapper',
+        'ChardevStdioWrapper',
+        'ChardevUdpWrapper',
+        'ChardevVCWrapper',
+        'CpuS390Entitlement',
+        'CpuS390Polarization',
+        'CpuS390State',
+        'CxlCorErrorType',
+        'DisplayProtocol',
+        'DriveBackupWrapper',
+        'DummyBlockCoreForceArrays',
+        'DummyForceArrays',
+        'DummyVirtioForceArrays',
+        'DumpGuestMemoryCapability',
+        'GrabToggleKeys',
+        'GuestPanicInformationHyperV',
+        'HotKeyMod',
+        'HvBalloonDeviceInfoWrapper',
+        'ImageInfoSpecific',
+        'ImageInfoSpecificFileWrapper',
+        'ImageInfoSpecificKind',
+        'ImageInfoSpecificLUKSWrapper',
+        'ImageInfoSpecificQCow2Wrapper',
+        'ImageInfoSpecificRbdWrapper',
+        'ImageInfoSpecificVmdkWrapper',
+        'InetSocketAddressWrapper',
+        'InputAxis',
+        'InputBtnEventWrapper',
+        'InputButton',
+        'InputKeyEventWrapper',
+        'InputMoveEventWrapper',
+        'InputMultiTouchEvent',
+        'InputMultiTouchEventWrapper',
+        'InputMultiTouchType',
+        'IntWrapper',
+        'IscsiHeaderDigest',
+        'IscsiTransport',
+        'JSONType',
+        'KeyValue',
+        'KeyValueKind',
+        'MemoryDeviceInfo',
+        'MemoryDeviceInfoKind',
+        'MigrateSetParameters',
+        'MigrationAddress',
+        'NetClientDriver',
+        'NumaOptions',
+        'ObjectType',
+        'PCDIMMDeviceInfoWrapper',
+        'PciMemoryRegion',
+        'QCryptoAkCipherKeyType',
+        'QCryptoAkCipherOptions',
+        'QCryptodevBackendServiceType',
+        'QKeyCode',
+        'QKeyCodeWrapper',
+        'Qcow2OverlapCheckFlags',
+        'RbdAuthMode',
+        'RbdEncryptionCreateOptions',
+        'RbdImageEncryptionFormat',
+        'SgxEPCDeviceInfoWrapper',
+        'SocketAddressLegacy',
+        'SshHostKeyCheck',
+        'StatsFilter',
+        'StatsValue',
+        'String',
+        'StringWrapper',
+        'SysEmuTarget',
+        'TPMEmulatorOptionsWrapper',
+        'TPMPassthroughOptionsWrapper',
+        'ThrottleGroupProperties',
+        'TransactionAction',
+        'UnixSocketAddressWrapper',
+        'VirtioMEMDeviceInfoWrapper',
+        'VirtioPMEMDeviceInfoWrapper',
+        'VncPrimaryAuth',
+        'VncVencryptSubAuth',
+        'VsockSocketAddressWrapper',
+        'X86CPURegister32',
+        'XDbgBlockGraph',
+        'YankInstance',
+        'YankInstanceType',
+        'blockdev-reopen',
+        'query-cpu-model-baseline',
+        'query-cpu-model-comparison',
+        'query-cpu-model-expansion',
+        'query-rocker',
+        'query-rocker-ports',
+        'query-stats-schemas',
+        'watchdog-set-action',
+        'yank' ],
     # Externally visible types whose member names may use uppercase
     'member-name-exceptions': [     # visible in:
         'ACPISlotType',             # query-acpi-ospm-status
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 50b0a558c7..b9501c8c81 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -33,7 +33,18 @@
         'guest-get-time',
         'guest-set-vcpus',
         'guest-sync',
-        'guest-sync-delimited' ] } }
+        'guest-sync-delimited' ],
+    # Types and commands with undocumented members:
+    'documentation-exceptions': [
+        'GuestCpuStats',
+        'GuestCpuStatsType',
+        'GuestDeviceId',
+        'GuestDeviceType',
+        'GuestDiskSmart',
+        'GuestDiskStatsInfo',
+        'GuestNVMeSmart',
+        'guest-set-memory-blocks',
+        'guest-set-vcpus' ] } }
 
 ##
 # @guest-sync-delimited:
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 48cd55a38c..88221b3c64 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -238,6 +238,8 @@ def check_list_str(name: str, value: object) -> List[str]:
             pragma.command_name_exceptions = check_list_str(name, value)
         elif name == 'command-returns-exceptions':
             pragma.command_returns_exceptions = check_list_str(name, value)
+        elif name == 'documentation-exceptions':
+            pragma.documentation_exceptions = check_list_str(name, value)
         elif name == 'member-name-exceptions':
             pragma.member_name_exceptions = check_list_str(name, value)
         else:
@@ -739,7 +741,10 @@ def _append_freeform(self, line: str) -> None:
 
     def connect_member(self, member: 'QAPISchemaMember') -> None:
         if member.name not in self.args:
-            # Undocumented TODO outlaw
+            if self.symbol not in member.info.pragma.documentation_exceptions:
+                raise QAPISemError(member.info,
+                                   "%s '%s' lacks documentation"
+                                   % (member.role, member.name))
             self.args[member.name] = QAPIDoc.ArgSection(self._parser,
                                                         member.name)
         self.args[member.name].connect(member)
diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index 04193cc964..7b379fdc92 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -24,6 +24,8 @@ def __init__(self) -> None:
         self.command_name_exceptions: List[str] = []
         # Commands allowed to return a non-dictionary
         self.command_returns_exceptions: List[str] = []
+        # Types, commands, and events with undocumented members
+        self.documentation_exceptions: List[str] = []
         # Types whose member names may violate case conventions
         self.member_name_exceptions: List[str] = []
 
diff --git a/tests/qapi-schema/doc-bad-alternate-member.json b/tests/qapi-schema/doc-bad-alternate-member.json
index fa4143da4c..37593b6698 100644
--- a/tests/qapi-schema/doc-bad-alternate-member.json
+++ b/tests/qapi-schema/doc-bad-alternate-member.json
@@ -2,6 +2,8 @@
 
 ##
 # @AorB:
+# @a: a
+# @b: b
 # @aa: a
 # @bb: b
 ##
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 976f9e1aaa..24a84fe6d7 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -3,7 +3,9 @@
 #
 # Positive QAPI doc comment tests
 
-{ 'pragma': { 'doc-required': true } }
+{ 'pragma': {
+    'doc-required': true,
+    'documentation-exceptions': [ 'Enum', 'Variant1', 'Alternate', 'cmd' ] } }
 
 ##
 # = Section
-- 
2.43.0


