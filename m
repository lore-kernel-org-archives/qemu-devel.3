Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61A8C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4d-0006Ct-PQ; Wed, 21 May 2025 18:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4X-0006Ac-Ih
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:01 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4O-0005YU-F1
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:01 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23274dbcbc2so24989425ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867068; x=1748471868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htF0VZgASZ43ct5qX/VW/MjRlaWWMAyaJawS0GNM9SY=;
 b=WY/7dFVfW0T63NYi+6cfblR2ZFWNqCd6rClqV5SC/ceBYAlJRE6P5/TuM6ao774S0L
 PVTE7HcaK6NqriGYMdAA4Tm96ISSI7w9I3xWiJ354OfZT6LbHqHv9kSRILkb5pu7anLn
 aLGBMew/BuuUM+HotH7ioBKgYnNhEWGUbXY0XkrdhLIG1jIa3bsabJHeHmFSkhIDi4L+
 A9oKXv6hLcclt33LvgGFMA5riDX2d3yRGr9EmkxWNTa47kMmjgyLdN3wfVUieZFf49Qk
 /8rxpyfWt6pDapBN/7lm9VBAagJn4DfglLqiJ2LjyTXNcflez8t5NQXqozpRu/y4+SSC
 8srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867068; x=1748471868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htF0VZgASZ43ct5qX/VW/MjRlaWWMAyaJawS0GNM9SY=;
 b=JPMVnNsWRI6nWFGevCTIwDpcO5cEPtfngY7fwmGrSxaw3Kaz/jTNuz5cgVPGK6juOQ
 cdXdcmqrDlaJHKBiLG63Kt/H1+mmQRO3QdwTCFUY2FBpihkIwFPYGLPz+7T4TYtwcNi4
 gU8RFKdcceXpVZdKiUuwLqOn6W6xG7CYDDbEqZWGX3SGYAQuVX8E8e9JedFGMTfG1361
 3YgYEeRquxaV88mh0V5P1M/EPqxS9Al/qT9XcACMNHel4Q5PrehsIQxY5kzChgq/VCy7
 uwGG84Yuv0spUJLaUs2ZuBh8A1Fkc4MZe4WJIOA0lbn6MqnS/uR2Dw2IwxSYjpwkUew1
 wyxQ==
X-Gm-Message-State: AOJu0YyUP2E9wMasjaAC4SQRmLfrCSDUgAQQPiKJ7MpIASE3CKEOTXwx
 fKpdV5R6X/xBCFE7NufwEN3HPhBp+8C9iEe1riQT25f7/pIttzLKhQSukXkNXtkI8qHccjPWAZZ
 cv3RO
X-Gm-Gg: ASbGncsqq4qmQ3L7n4q5u7hg4eKqg0yr77fEcTOWu0+aIHtBTw3bH2PqDkCIefwSqmq
 SsY+D1yB+wz6yrtdEWglOgfz/2SFGPMbLPg00deCdkTNi8BPY2FFnWxabXC7juJwkMPwvV6r9op
 UavcSMSYzT0bsxF91dQ4N5dV5xbsERorZq9aQVpHYLyU0UT9TwU7G08gGH6d+2gLA3JzkKYpy5C
 bHLP9MUjXLPxjEuZReHThGgckkjzK1WtFu1JIi4TGd4vFIh+b8cuhdBYIANa2ETVcE9UofqyDWk
 TRDXtAurTJ+mwzIt/kNnCz5CCSFDaS0Knmp6R0UcRXqXrvuC+X0=
X-Google-Smtp-Source: AGHT+IGxZWngZAeMOLFAZ8ZHvpk9qxKqMwgVCdVAwuCUsFTVHX+wXQWc+73f600fNX/fe2B5vNylAg==
X-Received: by 2002:a17:902:fc46:b0:231:cb8e:472e with SMTP id
 d9443c01a7336-231de3b9eedmr323389595ad.46.1747867067789; 
 Wed, 21 May 2025 15:37:47 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 03/14] qapi: make SEV commands unconditionally available
Date: Wed, 21 May 2025 15:37:29 -0700
Message-ID: <20250521223740.249720-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 qapi/misc-i386.json           | 271 ++++++++++++++++++++++++++++++++
 qapi/misc-target.json         | 284 ----------------------------------
 stubs/monitor-i386-sev.c      |  36 +++++
 target/i386/sev-system-stub.c |  32 ----
 target/i386/sev.c             |   2 +-
 stubs/meson.build             |   1 +
 6 files changed, 309 insertions(+), 317 deletions(-)
 create mode 100644 stubs/monitor-i386-sev.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index d5bfd91405e..de0e4ab67ff 100644
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
index 6b857efc1cc..c0d7b311f30 100644
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
diff --git a/stubs/monitor-i386-sev.c b/stubs/monitor-i386-sev.c
new file mode 100644
index 00000000000..d4f024128ca
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
index d5bf886e799..7c5c02a5657 100644
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
index 7ee700d6a35..56dd64e659a 100644
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
index 9907b54c1e6..9922ec7b88e 100644
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
2.47.2


