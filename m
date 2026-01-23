Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88522D72350
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 08:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjCao-0008Th-71; Fri, 23 Jan 2026 03:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vjCah-0008Rt-Tj
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 03:32:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vjCaf-00036M-JI
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 03:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769157144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5moUTgnSky3AjIqQlnWoNR4pt4s6o4jMt/dbxxHozGo=;
 b=QhQIxhSuMpdmifpGKALRdF9tz/mlDcwhZGBR+1m503+3aIphHJVY0lNcSdlCcke1e86PFt
 2naJSz2C9L4KegVEAMLecG9QjrLRnQxuMeUfTntZGvIQsqkifoYorO3vmizzgz6M4zl/oB
 wY9WLXQzL3CrT467VZra7R/p7tN/1vA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-3Hq8G740O9qWwJLl1C12gw-1; Fri,
 23 Jan 2026 03:32:21 -0500
X-MC-Unique: 3Hq8G740O9qWwJLl1C12gw-1
X-Mimecast-MFC-AGG-ID: 3Hq8G740O9qWwJLl1C12gw_1769157140
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90809180034A; Fri, 23 Jan 2026 08:32:20 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.44.34.167])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A87491800240; Fri, 23 Jan 2026 08:32:17 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH 3/3] docs/interop: Add firmware digests to schema
Date: Fri, 23 Jan 2026 09:32:04 +0100
Message-ID: <20260123083204.999920-4-osteffen@redhat.com>
In-Reply-To: <20260123083204.999920-1-osteffen@redhat.com>
References: <20260123083204.999920-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new optional top-level array called "digests" to the firmware JSON
metadata schema. This can be used to attach different kinds of
digests/hash values associated with the firmware image to the metadata
file. The entries in the array are of a fixed type of JSON object,
which describes the kind of digest, the hash algorithm used, as well as
the value itself.

The only kind of supported digest type for now is the expected launch
digest for confidential VMs running on AMD SEV-SNP. The list of allowed
types can be extended in the future as needed to support other
use-cases.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 docs/interop/firmware.json | 86 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index dabfa692fd..46d6b431c0 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -426,6 +426,53 @@
                       'memory' : 'FirmwareMappingMemory',
                       'igvm'   : 'FirmwareMappingIgvm' } }
 
+##
+# @FirmwareDigestType:
+#
+# Type of digest.
+#
+# @amd-sev-snp-launch: AMD SEV-SNP launch digest.
+##
+{ 'enum': 'FirmwareDigestType',
+  'data': [ 'amd-sev-snp-launch' ] }
+
+##
+# @AmdSevSnpLaunchHashAlg:
+#
+# Hash algorithms used for AMD SEV-SNP launch digests.
+#
+# @sha384: SHA-384
+##
+{ 'enum': 'AmdSevSnpLaunchHashAlg',
+  'data': [ 'sha384' ] }
+
+##
+# @AmdSevSnpLaunchDigest:
+#
+# Description of a launch digest as used by AMD SEV-SNP
+#
+# @hash-alg: Hashing algorithm
+#
+# @value: Digest value as hex string
+##
+{ 'struct' : 'AmdSevSnpLaunchDigest',
+  'data'   : { 'hash-alg' : 'AmdSevSnpLaunchHashAlg',
+               'value'    : 'str' } }
+
+##
+# @FirmwareDigest:
+#
+# Digests associated with the firmware image
+#
+# For example launch digests for attestation of confidential VMs.
+#
+# @type: Kind of digest.
+##
+{ 'union'         : 'FirmwareDigest',
+  'base'          : { 'type' : 'FirmwareDigestType' },
+  'discriminator' : 'type',
+  'data'          : { 'amd-sev-snp-launch' : 'AmdSevSnpLaunchDigest' } }
+
 ##
 # @Firmware:
 #
@@ -512,6 +559,10 @@
 #     debugging purposes only, and management software shall
 #     explicitly ignore it.
 #
+# @digests: (optional) Digest information associated with the
+#     firmware image, for example launch digests for confidential
+#     virtualization.
+#
 # Since: 3.0
 #
 # .. qmp-example::
@@ -713,6 +764,38 @@
 #             "-D DEBUG_PRINT_ERROR_LEVEL=0x80000000"
 #         ]
 #     }
+#
+#     {
+#        "description": "Coconut SVSM for QEMU under AMD SEV-SNP",
+#        "interface-types": [
+#            "uefi",
+#            "svsm"
+#         ],
+#        "mapping": {
+#           "device": "igvm",
+#           "filename": "/usr/share/coconut-svsm/coconut-qemu.igvm"
+#        },
+#        "targets": [
+#           {
+#              "architecture": "x86_64",
+#              "machines": [
+#                  "pc-q35-*"
+#              ]
+#           }
+#        ],
+#        "features": [
+#           "amd-sev-snp",
+#           "vtpm"
+#        ],
+#        "tags": [],
+#        "digests": [
+#           {
+#             "type": "amd-sev-snp-launch",
+#             "hash-alg": "sha384",
+#             "value": "ec664e889ed6c1b2763cacf7899d95b7f347373eb982e523419feea3aa362d891b3bf025f292267a5854049091789c3e"
+#           }
+#        ]
+#     }
 ##
 { 'struct' : 'Firmware',
   'data'   : { 'description'     : 'str',
@@ -720,4 +803,5 @@
                'mapping'         : 'FirmwareMapping',
                'targets'         : [ 'FirmwareTarget' ],
                'features'        : [ 'FirmwareFeature' ],
-               'tags'            : [ 'str' ] } }
+               'tags'            : [ 'str' ],
+               '*digests'        : [ 'FirmwareDigest' ] } }
-- 
2.52.0


