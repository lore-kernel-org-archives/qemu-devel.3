Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C250C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1lz-00031j-1y; Thu, 08 May 2025 09:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1lp-0002P1-K6
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1lm-00079D-Ni
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746712717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=crC+k0b0i/O7N0wVW98y2h8pM3pX5gYtGqMbTI+DA7w=;
 b=WwG2Zgwp+gJX/tK9riAw4N/p6mlU0Iv82K3NlwyXelz55dU44amxMukrFNTZsJwVSZwF7t
 NjsIOTTBQQ3GozbeCC09KWLw18/j719x16gZv6gw7Gdz0dOmHrF3eP36Cfa+W0IakGbiYv
 WdCsheVf4pRBHpekjANgFDWyRu3yPdQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-X0DNcH9-PFSY_UEiaVWxjw-1; Thu,
 08 May 2025 09:58:34 -0400
X-MC-Unique: X0DNcH9-PFSY_UEiaVWxjw-1
X-Mimecast-MFC-AGG-ID: X0DNcH9-PFSY_UEiaVWxjw_1746712712
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE3B6180048E; Thu,  8 May 2025 13:58:32 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C26C2180049D; Thu,  8 May 2025 13:58:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/10] qapi: make SEV commands unconditionally available
Date: Thu,  8 May 2025 14:58:09 +0100
Message-ID: <20250508135816.673087-4-berrange@redhat.com>
In-Reply-To: <20250508135816.673087-1-berrange@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This removes the TARGET_I386 condition from the SEV confidential
virtualization commands, moving them to the recently introduced
misc-i386.json QAPI file, given they are inherantly i386 specific
commands.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/misc-i386.json           | 271 ++++++++++++++++++++++++++++++++
 qapi/misc-target.json         | 284 ----------------------------------
 stubs/meson.build             |   1 +
 stubs/monitor-i386-sev.c      |  36 +++++
 target/i386/sev-system-stub.c |  32 ----
 target/i386/sev.c             |   2 +-
 6 files changed, 309 insertions(+), 317 deletions(-)
 create mode 100644 stubs/monitor-i386-sev.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index d5bfd91405..de0e4ab67f 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -22,3 +22,274 @@
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
+# If unavailable due to an incompatible configuration the
+# returned @enabled field will be set to 'false' and the
+# state of all other fields is undefined.
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
+# 'sev-guest' confidential virtualization object. The launch
+# measurement for SEV-SNP guests is only available within
+# the guest.
+#
+# This will return an error if the launch measurement is
+# unavailable, either due to an invalid guest configuration
+# or if the guest has not reached the required SEV state.
+#
+# Returns: The @SevLaunchMeasureInfo for the guest
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
+# This command is used to get the SEV capabilities, and is only
+# supported on AMD X86 platforms with KVM enabled. If SEV is not
+# available on the platform an error will be returned.
+#
+# Returns: SevCapability objects.
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
+# This command injects a secret blob into memory of a SEV/SEV-ES guest.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object. SEV-SNP guests
+# do not support launch secret injection
+#
+# This will return an error if launch secret injection is not possible,
+# either due to an invalid guest configuration, or if the guest has not
+# reached the required SEV state.
+#
+# @packet-header: the launch secret packet header encoded in base64
+#
+# @secret: the launch secret data to be injected encoded in base64
+#
+# @gpa: the guest physical address where secret will be injected.
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
+# 'sev-guest' confidential virtualization object. The attestation
+# report for SEV-SNP guests is only available within the guest.
+#
+# This will return an error if the attestation report is
+# unavailable, either due to an invalid guest configuration
+# or if the guest has not reached the required SEV state.
+#
+# @mnonce: a random 16 bytes value encoded in base64 (it will be
+#     included in report)
+#
+# Returns: SevAttestationReport objects.
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
index ae55e437a5..ba4403a924 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -2,290 +2,6 @@
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
-# If unavailable due to an incompatible configuration the
-# returned @enabled field will be set to 'false' and the
-# state of all other fields is undefined.
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
-# 'sev-guest' confidential virtualization object. The launch
-# measurement for SEV-SNP guests is only available within
-# the guest.
-#
-# This will return an error if the launch measurement is
-# unavailable, either due to an invalid guest configuration
-# or if the guest has not reached the required SEV state.
-#
-# Returns: The @SevLaunchMeasureInfo for the guest
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
-# This command is used to get the SEV capabilities, and is only
-# supported on AMD X86 platforms with KVM enabled. If SEV is not
-# available on the platform an error will be returned.
-#
-# Returns: SevCapability objects.
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
-# This command injects a secret blob into memory of a SEV/SEV-ES guest.
-#
-# This is only valid on x86 machines configured with KVM and the
-# 'sev-guest' confidential virtualization object. SEV-SNP guests
-# do not support launch secret injection
-#
-# This will return an error if launch secret injection is not possible,
-# either due to an invalid guest configuration, or if the guest has not
-# reached the required SEV state.
-#
-# @packet-header: the launch secret packet header encoded in base64
-#
-# @secret: the launch secret data to be injected encoded in base64
-#
-# @gpa: the guest physical address where secret will be injected.
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
-# 'sev-guest' confidential virtualization object. The attestation
-# report for SEV-SNP guests is only available within the guest.
-#
-# This will return an error if the attestation report is
-# unavailable, either due to an invalid guest configuration
-# or if the guest has not reached the required SEV state.
-#
-# @mnonce: a random 16 bytes value encoded in base64 (it will be
-#     included in report)
-#
-# Returns: SevAttestationReport objects.
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
-- 
2.49.0


