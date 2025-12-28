Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4726E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0BL-00043z-8B; Sun, 28 Dec 2025 18:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1va0BH-000434-WF
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1va0BG-0001b8-7n
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766964489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5HyYx8efx0XTs0/jsEr8rRxcOQQmyGr/ilmb2vidVY=;
 b=jE4Zgu9bAlDGQLu5iRYWuWQ660Svam83gvKLXqjgjf7o++0LiTs0cklqlOm0aPZzNFxxAW
 7RFWRgjhzw2PA7Pu0Vk6FZMVLzXRQIDow4bpJF2oCIlwqh28YMEMPE+tzpSGZY6mAD9TTv
 kTFnE7lPG/2NUteqbyeu7JJgrs+6fyk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-qQxnb6a1NS6P48O-0wyQeA-1; Sun,
 28 Dec 2025 18:27:01 -0500
X-MC-Unique: qQxnb6a1NS6P48O-0wyQeA-1
X-Mimecast-MFC-AGG-ID: qQxnb6a1NS6P48O-0wyQeA_1766964420
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42D801956088; Sun, 28 Dec 2025 23:27:00 +0000 (UTC)
Received: from harajuku.usersys.redhat.com.homenet.telecomitalia.it (unknown
 [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5598819560AB; Sun, 28 Dec 2025 23:26:58 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/2] docs/interop/firmware: Introduce extended syntax for
 FirmwareMappingMemory
Date: Mon, 29 Dec 2025 00:26:49 +0100
Message-ID: <20251228232649.1708400-3-abologna@redhat.com>
In-Reply-To: <20251228232649.1708400-1-abologna@redhat.com>
References: <20251228232649.1708400-1-abologna@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

The new syntax allows describing firmwares that are loaded as
ROMs but also support NVRAM storage. This is the case for edk2
builds that are set up to use the uefi-vars QEMU device, and
whose descriptors would advertise the 'host-uefi-vars' feature.

The extended syntax intentionally mirrors FirmwareMappingFlash
since it needs to cover the exact same scenarios, which are a
strict superset of the ones FirmwareMappingMemory supports
today.

Unfortunately there doesn't seem to be a way to make the legacy
syntax and the extended one coexist within the boundaries of
the QAPI type system, at least not in a semantically-meaningful
fashion.

Given that the specification, despite being maintained in a
machine-readable format, is really intended to be used by the
humans authoring firmware descriptors or writing code that
parses them, and that dealing with the additional complexity on
the consumer side is in practice very easy (as confirmed by
implementing support for it in libvirt), the decision was made
to favor alignment with FirmwareMappingFlash over QAPI purity,
and to bridge the gap with extensive inline documentation.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
---
 docs/interop/firmware.json | 186 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 181 insertions(+), 5 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index ef9b976a34..686964ec83 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -369,21 +369,197 @@
 { 'struct' : 'FirmwareMappingKernel',
   'data'   : { 'filename' : 'str' } }
 
+##
+# @FirmwareMemoryExecutableFormat:
+#
+# Formats that are supported for firmware executables.
+#
+# @raw: Raw disk image format.
+#
+# Since: 11.0
+##
+{ 'enum': 'FirmwareMemoryExecutableFormat',
+  'data': [ 'raw' ] }
+
+##
+# @FirmwareMemoryNvramFormat:
+#
+# Formats that are supported for firmware NVRAM files.
+#
+# @json: JSON format.
+#
+# Since: 11.0
+##
+{ 'enum': 'FirmwareMemoryNvramFormat',
+  'data': [ 'json' ] }
+
+##
+# @FirmwareMemoryExecutableFile:
+#
+# Describes the firmware executable.
+#
+# @filename: Filename on the host filesystem where the executable can
+#     be found.
+#
+# @format: Block format of the file pointed to by @filename.
+#
+# Since: 11.0
+##
+{ 'struct' : 'FirmwareMemoryExecutableFile',
+  'data'   : { 'filename' : 'str',
+               'format'   : 'FirmwareMemoryExecutableFormat' } }
+
+##
+# @FirmwareMemoryNvramTemplateFile:
+#
+# Describes the NVRAM template to be used together with the
+# corresponding firmware executable.
+#
+# @filename: Filename on the host filesystem where the NVRAM template
+#     can be found.
+#
+# @format: Block format of the file pointed to by @filename.
+#
+# Since: 11.0
+##
+{ 'struct' : 'FirmwareMemoryNvramTemplateFile',
+  'data'   : { 'filename' : 'str',
+               'format'   : 'FirmwareMemoryNvramFormat' } }
+
+##
+# @FirmwareMemoryMode:
+#
+# Describes how the firmware build handles variable persistence.
+#
+# @split: the executable file contains code while the NVRAM template
+#     provides variable storage.  The executable can be shared
+#     between multiple guests.  The NVRAM template must be cloned for
+#     each new guest and configured read-write.
+#
+# @stateless: the executable file contains code and variable storage
+#     is not persisted.  The executable can be shared between
+#     multiple guests.  No NVRAM template will be specified.
+#
+# Since: 11.0
+##
+{ 'enum' : 'FirmwareMemoryMode',
+  'data' : [ 'split', 'stateless' ] }
+
 ##
 # @FirmwareMappingMemory:
 #
 # Describes loading and mapping properties for the firmware
 # executable, when @FirmwareDevice is @memory.
 #
-# @filename: Identifies the firmware executable.  The firmware
-#     executable may be shared by multiple virtual machine
-#     definitions.  The corresponding QEMU command line option is
-#     "-bios @filename".
+# Two syntaxes are possible: a legacy one, which can only describe
+# stateless firmware builds, and an extended one, which can
+# additionally describe firmware builds that support variable
+# storage via the "uefi-vars" device appropriate for the
+# architecture.
+#
+# The two syntaxes are mutually exclusive. In particular:
+#
+# - only one of @filename and @executable can be specified;
+#
+# - if @filename is specified, @mode must be omitted and its value
+#   is assumed to be @stateless.  If @executable is used instead,
+#   the value for @mode must be provided explicitly;
+#
+# - @nvram-template can only be specified together with @executable,
+#   and in this case the value of @mode must be @split.
+#
+# Based on these rules,
+#
+# ::
+#
+#     {
+#         "mapping: {
+#             "device": "memory",
+#             "filename": "/path/to/firmware.bin"
+#         }
+#     }
+#
+# and
+#
+# ::
+#
+#     {
+#         "mapping": {
+#             "device": "memory",
+#             "mode": "stateless",
+#             "executable": {
+#                 "filename": "/path/to/firmware.bin",
+#                 "format": "raw"
+#             }
+#         }
+#     }
+#
+# are completely equivalent, whereas
+#
+# ::
+#
+#     {
+#         "mapping": {
+#             "device": "memory",
+#             "mode": "split",
+#             "executable": {
+#                 "filename": "/path/to/firmware.bin",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/path/to/variables.json",
+#                 "format": "json"
+#             }
+#         }
+#     }
+#
+# can only be described using the extended syntax.
+#
+# @mode: Describes how the firmware build handles variable storage.
+#     Must be present when @executable is used and absent when
+#     @filename is used; in the latter scenario, its value will be
+#     assumed to be @stateless.  Since: 11.0
+#
+# @executable: Describes the firmware excutable.  The corresponding
+#     QEMU command line option is "-bios @executable.@filename".
+#     Since: 11.0
+#
+# @nvram-template: Describes the NVRAM template compatible with
+#     @executable, when @mode is set to @split, otherwise it should
+#     not be present.  Management software instantiates an individual
+#     copy -- a specific NVRAM file -- from @nvram-template.@filename
+#     for each new virtual machine definition created.
+#     @nvram-template.@filename itself is never mapped into virtual
+#     machines, only individual copies of it are.  An NVRAM file is
+#     typically used for persistently storing the non-volatile UEFI
+#     variables of a virtual machine definition.  The corresponding
+#     QEMU command line option is
+#
+#     ::
+#
+#         -device uefi-vars-x64,jsonfile=FILENAME_OF_PRIVATE_NVRAM_FILE
+#
+#     on x86_64 and
+#
+#     ::
+#
+#         -device uefi-vars-sysbus,jsonfile=FILENAME_OF_PRIVATE_NVRAM_FILE
+#
+#     on other architectures (aarch64, riscv64, loongarch64).
+#     Since: 11.0
+#
+# @filename: Legacy syntax that can only describe @stateless firmware
+#     builds.  The corresponding QEMU command line option is "-bios
+#     @filename".  If present, none of the other attributes (@mode,
+#     @executable, @template) can be present.
 #
 # Since: 3.0
 ##
 { 'struct' : 'FirmwareMappingMemory',
-  'data'   : { 'filename' : 'str' } }
+  'data'   : { '*mode'           : 'FirmwareMemoryMode',
+               '*executable'     : 'FirmwareMemoryExecutableFile',
+               '*nvram-template' : 'FirmwareMemoryNvramTemplateFile',
+               '*filename'       : 'str' } }
 
 ##
 # @FirmwareMappingIgvm:
-- 
2.52.0


