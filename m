Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19DAC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZo-0002dS-Cl; Wed, 28 May 2025 14:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZX-0002MR-BY
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZR-00072K-EL
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhaXYgSLlaEdDDwJq+c/JBxsK0whcEhnGMHoK3fywgM=;
 b=YD9p6b6BUV/cQpG74bGuDq+q093Q10u40hTRi03O6Hg8dj6hA+LsqHNQiNLojmdx/9djq5
 T7oI2VoaOGWCDoF5Dr05jOX9ekyiqUOpnAWGwSYaO+Ygu0EZ3eN7sqhC9V4rHX9cCERe/e
 hvFEwN8edkT45LME76myN6oB2w0tUkA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-cNd_8r5JOV2WSafmO8gXuA-1; Wed,
 28 May 2025 14:31:56 -0400
X-MC-Unique: cNd_8r5JOV2WSafmO8gXuA-1
X-Mimecast-MFC-AGG-ID: cNd_8r5JOV2WSafmO8gXuA_1748457115
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3073C180056F; Wed, 28 May 2025 18:31:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C6ED3000714; Wed, 28 May 2025 18:31:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97ED821E66AB; Wed, 28 May 2025 20:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/13] qapi: make SEV commands unconditionally available
Date: Wed, 28 May 2025 20:31:41 +0200
Message-ID: <20250528183151.2839034-4-armbru@redhat.com>
In-Reply-To: <20250528183151.2839034-1-armbru@redhat.com>
References: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This removes the TARGET_I386 condition from the SEV confidential
virtualization commands, moving them to the recently introduced
misc-i386.json QAPI file, given they are inherantly i386 specific
commands.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250522190542.588267-4-pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc-i386.json           | 278 ++++++++++++++++++++++++++++++++
 qapi/misc-target.json         | 291 ----------------------------------
 stubs/monitor-i386-sev.c      |  36 +++++
 target/i386/sev-system-stub.c |  32 ----
 target/i386/sev.c             |   2 +-
 stubs/meson.build             |   1 +
 6 files changed, 316 insertions(+), 324 deletions(-)
 create mode 100644 stubs/monitor-i386-sev.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index d5bfd91405..360adadfe0 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -22,3 +22,281 @@
 #     <- { "return": {} }
 ##
 { 'command': 'rtc-reset-reinjection' }
+
+##
+# @SevState:
+#
+# An enumeration of SEV state information used during @query-sev.
+#
+# @uninit: The guest is uninitialized.
+#
+# @launch-update: The guest is currently being launched; plaintext
+#     data and register state is being imported.
+#
+# @launch-secret: The guest is currently being launched; ciphertext
+#     data is being imported.
+#
+# @running: The guest is fully launched or migrated in.
+#
+# @send-update: The guest is currently being migrated out to another
+#     machine.
+#
+# @receive-update: The guest is currently being migrated from another
+#     machine.
+#
+# Since: 2.12
+##
+{ 'enum': 'SevState',
+  'data': ['uninit', 'launch-update', 'launch-secret', 'running',
+           'send-update', 'receive-update' ] }
+
+##
+# @SevGuestType:
+#
+# An enumeration indicating the type of SEV guest being run.
+#
+# @sev: The guest is a legacy SEV or SEV-ES guest.
+#
+# @sev-snp: The guest is an SEV-SNP guest.
+#
+# Since: 6.2
+##
+{ 'enum': 'SevGuestType',
+  'data': [ 'sev', 'sev-snp' ] }
+
+##
+# @SevGuestInfo:
+#
+# Information specific to legacy SEV/SEV-ES guests.
+#
+# @policy: SEV policy value
+#
+# @handle: SEV firmware handle
+#
+# Since: 2.12
+##
+{ 'struct': 'SevGuestInfo',
+  'data': { 'policy': 'uint32',
+            'handle': 'uint32' } }
+
+##
+# @SevSnpGuestInfo:
+#
+# Information specific to SEV-SNP guests.
+#
+# @snp-policy: SEV-SNP policy value
+#
+# Since: 9.1
+##
+{ 'struct': 'SevSnpGuestInfo',
+  'data': { 'snp-policy': 'uint64' } }
+
+##
+# @SevInfo:
+#
+# Information about Secure Encrypted Virtualization (SEV) support
+#
+# @enabled: true if SEV is active
+#
+# @api-major: SEV API major version
+#
+# @api-minor: SEV API minor version
+#
+# @build-id: SEV FW build id
+#
+# @state: SEV guest state
+#
+# @sev-type: Type of SEV guest being run
+#
+# Since: 2.12
+##
+{ 'union': 'SevInfo',
+  'base': { 'enabled': 'bool',
+            'api-major': 'uint8',
+            'api-minor' : 'uint8',
+            'build-id' : 'uint8',
+            'state' : 'SevState',
+            'sev-type' : 'SevGuestType' },
+  'discriminator': 'sev-type',
+  'data': {
+      'sev': 'SevGuestInfo',
+      'sev-snp': 'SevSnpGuestInfo' } }
+
+
+##
+# @query-sev:
+#
+# Returns information about SEV/SEV-ES/SEV-SNP.
+#
+# If unavailable due to an incompatible configuration the returned
+# @enabled field is set to 'false' and the state of all other fields
+# is unspecified.
+#
+# Returns: @SevInfo
+#
+# Since: 2.12
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-sev" }
+#     <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
+#                      "build-id" : 0, "policy" : 0, "state" : "running",
+#                      "handle" : 1 } }
+##
+{ 'command': 'query-sev', 'returns': 'SevInfo' }
+
+##
+# @SevLaunchMeasureInfo:
+#
+# SEV Guest Launch measurement information
+#
+# @data: the measurement value encoded in base64
+#
+# Since: 2.12
+##
+{ 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'} }
+
+##
+# @query-sev-launch-measure:
+#
+# Query the SEV/SEV-ES guest launch information.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object.  The launch
+# measurement for SEV-SNP guests is only available within the guest.
+#
+# Returns: The @SevLaunchMeasureInfo for the guest
+#
+# Errors:
+#     - If the launch measurement is unavailable, either due to an
+#       invalid guest configuration or if the guest has not reached
+#       the required SEV state, GenericError
+#
+# Since: 2.12
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-sev-launch-measure" }
+#     <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
+##
+{ 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo' }
+
+##
+# @SevCapability:
+#
+# The struct describes capability for a Secure Encrypted
+# Virtualization feature.
+#
+# @pdh: Platform Diffie-Hellman key (base64 encoded)
+#
+# @cert-chain: PDH certificate chain (base64 encoded)
+#
+# @cpu0-id: Unique ID of CPU0 (base64 encoded) (since 7.1)
+#
+# @cbitpos: C-bit location in page table entry
+#
+# @reduced-phys-bits: Number of physical Address bit reduction when
+#     SEV is enabled
+#
+# Since: 2.12
+##
+{ 'struct': 'SevCapability',
+  'data': { 'pdh': 'str',
+            'cert-chain': 'str',
+            'cpu0-id': 'str',
+            'cbitpos': 'int',
+            'reduced-phys-bits': 'int'} }
+
+##
+# @query-sev-capabilities:
+#
+# Get SEV capabilities.
+#
+# This is only supported on AMD X86 platforms with KVM enabled.
+#
+# Returns: SevCapability objects.
+#
+# Errors:
+#     - If SEV is not available on the platform, GenericError
+#
+# Since: 2.12
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-sev-capabilities" }
+#     <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
+#                      "cpu0-id": "2lvmGwo+...61iEinw==",
+#                      "cbitpos": 47, "reduced-phys-bits": 1}}
+##
+{ 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
+
+##
+# @sev-inject-launch-secret:
+#
+# This command injects a secret blob into memory of a SEV/SEV-ES
+# guest.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object.  SEV-SNP guests do
+# not support launch secret injection.
+#
+# @packet-header: the launch secret packet header encoded in base64
+#
+# @secret: the launch secret data to be injected encoded in base64
+#
+# @gpa: the guest physical address where secret will be injected.
+#
+# Errors:
+#     - If launch secret injection is not possible, either due to
+#       an invalid guest configuration, or if the guest has not
+#       reached the required SEV state, GenericError
+#
+# Since: 6.0
+##
+{ 'command': 'sev-inject-launch-secret',
+  'data': { 'packet-header': 'str', 'secret': 'str', '*gpa': 'uint64' } }
+
+##
+# @SevAttestationReport:
+#
+# The struct describes attestation report for a Secure Encrypted
+# Virtualization feature.
+#
+# @data: guest attestation report (base64 encoded)
+#
+# Since: 6.1
+##
+{ 'struct': 'SevAttestationReport',
+  'data': { 'data': 'str'} }
+
+##
+# @query-sev-attestation-report:
+#
+# This command is used to get the SEV attestation report.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object.  The attestation
+# report for SEV-SNP guests is only available within the guest.
+#
+# @mnonce: a random 16 bytes value encoded in base64 (it will be
+#     included in report)
+#
+# Returns: SevAttestationReport objects.
+#
+# Errors:
+#     - This will return an error if the attestation report is
+#       unavailable, either due to an invalid guest configuration
+#       or if the guest has not reached the required SEV state,
+#       GenericError
+#
+# Since: 6.1
+#
+# .. qmp-example::
+#
+#     -> { "execute" : "query-sev-attestation-report",
+#                      "arguments": { "mnonce": "aaaaaaa" } }
+#     <- { "return" : { "data": "aaaaaaaabbbddddd"} }
+##
+{ 'command': 'query-sev-attestation-report',
+  'data': { 'mnonce': 'str' },
+  'returns': 'SevAttestationReport' }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index e19a12e88a..c0d7b311f3 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -2,297 +2,6 @@
 # vim: filetype=python
 #
 
-##
-# @SevState:
-#
-# An enumeration of SEV state information used during @query-sev.
-#
-# @uninit: The guest is uninitialized.
-#
-# @launch-update: The guest is currently being launched; plaintext
-#     data and register state is being imported.
-#
-# @launch-secret: The guest is currently being launched; ciphertext
-#     data is being imported.
-#
-# @running: The guest is fully launched or migrated in.
-#
-# @send-update: The guest is currently being migrated out to another
-#     machine.
-#
-# @receive-update: The guest is currently being migrated from another
-#     machine.
-#
-# Since: 2.12
-##
-{ 'enum': 'SevState',
-  'data': ['uninit', 'launch-update', 'launch-secret', 'running',
-           'send-update', 'receive-update' ],
-  'if': 'TARGET_I386' }
-
-##
-# @SevGuestType:
-#
-# An enumeration indicating the type of SEV guest being run.
-#
-# @sev: The guest is a legacy SEV or SEV-ES guest.
-#
-# @sev-snp: The guest is an SEV-SNP guest.
-#
-# Since: 6.2
-##
-{ 'enum': 'SevGuestType',
-  'data': [ 'sev', 'sev-snp' ],
-  'if': 'TARGET_I386' }
-
-##
-# @SevGuestInfo:
-#
-# Information specific to legacy SEV/SEV-ES guests.
-#
-# @policy: SEV policy value
-#
-# @handle: SEV firmware handle
-#
-# Since: 2.12
-##
-{ 'struct': 'SevGuestInfo',
-  'data': { 'policy': 'uint32',
-            'handle': 'uint32' },
-  'if': 'TARGET_I386' }
-
-##
-# @SevSnpGuestInfo:
-#
-# Information specific to SEV-SNP guests.
-#
-# @snp-policy: SEV-SNP policy value
-#
-# Since: 9.1
-##
-{ 'struct': 'SevSnpGuestInfo',
-  'data': { 'snp-policy': 'uint64' },
-  'if': 'TARGET_I386' }
-
-##
-# @SevInfo:
-#
-# Information about Secure Encrypted Virtualization (SEV) support
-#
-# @enabled: true if SEV is active
-#
-# @api-major: SEV API major version
-#
-# @api-minor: SEV API minor version
-#
-# @build-id: SEV FW build id
-#
-# @state: SEV guest state
-#
-# @sev-type: Type of SEV guest being run
-#
-# Since: 2.12
-##
-{ 'union': 'SevInfo',
-  'base': { 'enabled': 'bool',
-            'api-major': 'uint8',
-            'api-minor' : 'uint8',
-            'build-id' : 'uint8',
-            'state' : 'SevState',
-            'sev-type' : 'SevGuestType' },
-  'discriminator': 'sev-type',
-  'data': {
-      'sev': 'SevGuestInfo',
-      'sev-snp': 'SevSnpGuestInfo' },
-  'if': 'TARGET_I386' }
-
-
-##
-# @query-sev:
-#
-# Returns information about SEV/SEV-ES/SEV-SNP.
-#
-# If unavailable due to an incompatible configuration the returned
-# @enabled field is set to 'false' and the state of all other fields
-# is unspecified.
-#
-# Returns: @SevInfo
-#
-# Since: 2.12
-#
-# .. qmp-example::
-#
-#     -> { "execute": "query-sev" }
-#     <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
-#                      "build-id" : 0, "policy" : 0, "state" : "running",
-#                      "handle" : 1 } }
-##
-{ 'command': 'query-sev', 'returns': 'SevInfo',
-  'if': 'TARGET_I386' }
-
-##
-# @SevLaunchMeasureInfo:
-#
-# SEV Guest Launch measurement information
-#
-# @data: the measurement value encoded in base64
-#
-# Since: 2.12
-##
-{ 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'},
-  'if': 'TARGET_I386' }
-
-##
-# @query-sev-launch-measure:
-#
-# Query the SEV/SEV-ES guest launch information.
-#
-# This is only valid on x86 machines configured with KVM and the
-# 'sev-guest' confidential virtualization object.  The launch
-# measurement for SEV-SNP guests is only available within the guest.
-#
-# Returns: The @SevLaunchMeasureInfo for the guest
-#
-# Errors:
-#     - If the launch measurement is unavailable, either due to an
-#       invalid guest configuration or if the guest has not reached
-#       the required SEV state, GenericError
-#
-# Since: 2.12
-#
-# .. qmp-example::
-#
-#     -> { "execute": "query-sev-launch-measure" }
-#     <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
-##
-{ 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo',
-  'if': 'TARGET_I386' }
-
-##
-# @SevCapability:
-#
-# The struct describes capability for a Secure Encrypted
-# Virtualization feature.
-#
-# @pdh: Platform Diffie-Hellman key (base64 encoded)
-#
-# @cert-chain: PDH certificate chain (base64 encoded)
-#
-# @cpu0-id: Unique ID of CPU0 (base64 encoded) (since 7.1)
-#
-# @cbitpos: C-bit location in page table entry
-#
-# @reduced-phys-bits: Number of physical Address bit reduction when
-#     SEV is enabled
-#
-# Since: 2.12
-##
-{ 'struct': 'SevCapability',
-  'data': { 'pdh': 'str',
-            'cert-chain': 'str',
-            'cpu0-id': 'str',
-            'cbitpos': 'int',
-            'reduced-phys-bits': 'int'},
-  'if': 'TARGET_I386' }
-
-##
-# @query-sev-capabilities:
-#
-# Get SEV capabilities.
-#
-# This is only supported on AMD X86 platforms with KVM enabled.
-#
-# Returns: SevCapability objects.
-#
-# Errors:
-#     - If SEV is not available on the platform, GenericError
-#
-# Since: 2.12
-#
-# .. qmp-example::
-#
-#     -> { "execute": "query-sev-capabilities" }
-#     <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
-#                      "cpu0-id": "2lvmGwo+...61iEinw==",
-#                      "cbitpos": 47, "reduced-phys-bits": 1}}
-##
-{ 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
-  'if': 'TARGET_I386' }
-
-##
-# @sev-inject-launch-secret:
-#
-# This command injects a secret blob into memory of a SEV/SEV-ES
-# guest.
-#
-# This is only valid on x86 machines configured with KVM and the
-# 'sev-guest' confidential virtualization object.  SEV-SNP guests do
-# not support launch secret injection.
-#
-# @packet-header: the launch secret packet header encoded in base64
-#
-# @secret: the launch secret data to be injected encoded in base64
-#
-# @gpa: the guest physical address where secret will be injected.
-#
-# Errors:
-#     - If launch secret injection is not possible, either due to
-#       an invalid guest configuration, or if the guest has not
-#       reached the required SEV state, GenericError
-#
-# Since: 6.0
-##
-{ 'command': 'sev-inject-launch-secret',
-  'data': { 'packet-header': 'str', 'secret': 'str', '*gpa': 'uint64' },
-  'if': 'TARGET_I386' }
-
-##
-# @SevAttestationReport:
-#
-# The struct describes attestation report for a Secure Encrypted
-# Virtualization feature.
-#
-# @data: guest attestation report (base64 encoded)
-#
-# Since: 6.1
-##
-{ 'struct': 'SevAttestationReport',
-  'data': { 'data': 'str'},
-  'if': 'TARGET_I386' }
-
-##
-# @query-sev-attestation-report:
-#
-# This command is used to get the SEV attestation report.
-#
-# This is only valid on x86 machines configured with KVM and the
-# 'sev-guest' confidential virtualization object.  The attestation
-# report for SEV-SNP guests is only available within the guest.
-#
-# @mnonce: a random 16 bytes value encoded in base64 (it will be
-#     included in report)
-#
-# Returns: SevAttestationReport objects.
-#
-# Errors:
-#     - This will return an error if the attestation report is
-#       unavailable, either due to an invalid guest configuration
-#       or if the guest has not reached the required SEV state,
-#       GenericError
-#
-# Since: 6.1
-#
-# .. qmp-example::
-#
-#     -> { "execute" : "query-sev-attestation-report",
-#                      "arguments": { "mnonce": "aaaaaaa" } }
-#     <- { "return" : { "data": "aaaaaaaabbbddddd"} }
-##
-{ 'command': 'query-sev-attestation-report',
-  'data': { 'mnonce': 'str' },
-  'returns': 'SevAttestationReport',
-  'if': 'TARGET_I386' }
-
 ##
 # @GICCapability:
 #
diff --git a/stubs/monitor-i386-sev.c b/stubs/monitor-i386-sev.c
new file mode 100644
index 0000000000..d4f024128c
--- /dev/null
+++ b/stubs/monitor-i386-sev.c
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
+
+SevInfo *qmp_query_sev(Error **errp)
+{
+    error_setg(errp, "SEV is not available in this QEMU");
+    return NULL;
+}
+
+SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
+{
+    error_setg(errp, "SEV is not available in this QEMU");
+    return NULL;
+}
+
+SevCapability *qmp_query_sev_capabilities(Error **errp)
+{
+    error_setg(errp, "SEV is not available in this QEMU");
+    return NULL;
+}
+
+void qmp_sev_inject_launch_secret(const char *packet_header, const char *secret,
+                                  bool has_gpa, uint64_t gpa, Error **errp)
+{
+    error_setg(errp, "SEV is not available in this QEMU");
+}
+
+SevAttestationReport *qmp_query_sev_attestation_report(const char *mnonce,
+                                                       Error **errp)
+{
+    error_setg(errp, "SEV is not available in this QEMU");
+    return NULL;
+}
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index d5bf886e79..7c5c02a565 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -14,34 +14,9 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
-#include "qapi/qapi-commands-misc-target.h"
 #include "qapi/error.h"
 #include "sev.h"
 
-SevInfo *qmp_query_sev(Error **errp)
-{
-    error_setg(errp, "SEV is not available in this QEMU");
-    return NULL;
-}
-
-SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
-{
-    error_setg(errp, "SEV is not available in this QEMU");
-    return NULL;
-}
-
-SevCapability *qmp_query_sev_capabilities(Error **errp)
-{
-    error_setg(errp, "SEV is not available in this QEMU");
-    return NULL;
-}
-
-void qmp_sev_inject_launch_secret(const char *packet_header, const char *secret,
-                                  bool has_gpa, uint64_t gpa, Error **errp)
-{
-    error_setg(errp, "SEV is not available in this QEMU");
-}
-
 int sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
 {
     g_assert_not_reached();
@@ -56,13 +31,6 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
     g_assert_not_reached();
 }
 
-SevAttestationReport *qmp_query_sev_attestation_report(const char *mnonce,
-                                                       Error **errp)
-{
-    error_setg(errp, "SEV is not available in this QEMU");
-    return NULL;
-}
-
 void hmp_info_sev(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "SEV is not available in this QEMU\n");
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 7ee700d6a3..56dd64e659 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -37,7 +37,7 @@
 #include "qom/object.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
-#include "qapi/qapi-commands-misc-target.h"
+#include "qapi/qapi-commands-misc-i386.h"
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
 #include "system/address-spaces.h"
diff --git a/stubs/meson.build b/stubs/meson.build
index 9907b54c1e..9922ec7b88 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -78,6 +78,7 @@ if have_system
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('monitor-i386-rtc.c'))
+  stub_ss.add(files('monitor-i386-sev.c'))
 endif
 
 if have_system or have_user
-- 
2.48.1


