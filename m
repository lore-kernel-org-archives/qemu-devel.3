Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5BAC54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBEy-0000wN-5N; Thu, 22 May 2025 15:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEq-0000vG-74
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:57 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEn-0006SD-DQ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:55 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-742c035f2afso3759295b3a.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940752; x=1748545552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htF0VZgASZ43ct5qX/VW/MjRlaWWMAyaJawS0GNM9SY=;
 b=rZVshwKiv7YJKwqEubwpD1EIjZGaj4c7RpFql/Clvofgg916OPswb2OzmzizE5uFNT
 MeLG5sbJWrAEuRx7wTc9d9YDjaAfTbfex8DAYAlVlZC5eZOaN4E3FDown2UcsdgI2PtU
 /aNUHYGvlrggZFAfH2pcU6r+WG1wpilkEnqREgDybMmDmZ0BaXhFZDBwAoe7hgWf2XQ5
 v7EVUVFHpNbaMftFShEwZiy1EsaAHp8WfWKdylz9lt91eIH6gMiIsq4LX2qTnlsYUF/+
 rCW1qMusjQYfBlEQM0BqE4eJlwt63pcmGZWpB5UNiIQIfYiY+xQPw0oDu8exjs1Ts66A
 nXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940752; x=1748545552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htF0VZgASZ43ct5qX/VW/MjRlaWWMAyaJawS0GNM9SY=;
 b=n2vT3b3P/WpQobr46McmkRxbYaXRr5UZTwMIrxw7DZbNr0zUwjnPNkySEYYzB9hNDh
 xzOMu/R2LdCpOvTuUGmrFijDoaAXhu6GinQDi/+taypjzjOY/0qfdTdyE2AGdW3yyfn8
 QjTdRuzvdnx9mRWx+o1Sv2JtA9y94Mzxj88BLG721izz7IjH5vUGHpHIINkWtRgW1ReW
 ghLO/rVAZzZXVYwM0/GAB7vvXWRzLRZyQ5XkQ4359GJT22URiR2+QUMguCG7MK/MHz6L
 ixEHzkvQVZNTga1DrHlbXvh+J9No4Gykn6ou9q23h40J2O128dbLdSgfFJ8L3q0PzpCJ
 Z94A==
X-Gm-Message-State: AOJu0Yzbj1T8RsjE06prce6GlVQzHA108BE1FMu2hQYCQAOk8vOMjWGD
 a2r8zYnscQeGTZ7dXTrELfE54h2tf3tMeDSqSNDYyt+hUq+XgZgSSNMo0daq8A+20C8jK9fVqCa
 8aGEP
X-Gm-Gg: ASbGncvkdIZ/yRKqc75CJeuDIhiDWCf6auPqOS2z6TOalF4SXxBs2kOx3Z566Z+JMwO
 oMUH125DF7xFifQZKcyhuOz35n7pcfA2P1FgjPY3pFPbpjUTFBbt4FCVIEQOoeAQgLbRxsv6lLz
 lso3MdpJ8CP3xHON95U4hRgM0OvQV1pOiOa5pJ7BND5rm/ptTlgvZ+arpwRUmZgzlF4bRVnUIIi
 RX41ygSIZJkkumdC/GBS3VaXDEZMViCrAEkVAC8Xxcl04C0qSpXwpJVNuic8iE9qzVKjvHGTzcl
 YwfrlxZZgSbGgLZsgV2ztcdXVCUgotVl5HOZZCAWpkTqOjRhPp4=
X-Google-Smtp-Source: AGHT+IGRME/yrK0PKFoQFGYBL3f9+3v7eC35PCSMRLduwQtKtZx/xMAo31jHxeOtoLXRA4GNu0gOrA==
X-Received: by 2002:a05:6a20:258e:b0:1f5:7fcb:397d with SMTP id
 adf61e73a8af0-2162189eedemr36771719637.16.1747940751836; 
 Thu, 22 May 2025 12:05:51 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 03/15] qapi: make SEV commands unconditionally available
Date: Thu, 22 May 2025 12:05:30 -0700
Message-ID: <20250522190542.588267-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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


