Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD18C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyl-0000jX-Dm; Wed, 07 May 2025 19:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyh-0000hX-RO
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:04 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnye-0007Aw-Tq
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:03 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2264aefc45dso6270645ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659699; x=1747264499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQFNYs+5MBLEhk/YpwGvftpZAYeWxZFFM99PsEI42kc=;
 b=T6oEGNuDa5xqFlDDTr9rHQBB6+3cOEoeGgJN5z84UvIq1fQWnHlvURZcj0zfO++Qfb
 F12daF1cI1gzaELysnhKoHQYtlkf6nIO4oYQaznaUCou97LiAQBhQI9Ij4+MPxU9qwvw
 /bag4OUFRUs3bSvRgDU9me3Co8I5Ofubby6Y98tr7u8bkG8p1MU4MKETu4yQOdijGoM7
 BImvsvZ6pckMpLIPHDOe44Nz+qOsvqgASqG+me7LvVZG8HpdLuyqGaw2l4lW2d5qZfH4
 IX/xtxGtQko1+XDkE5dEnmuRvkDcUN56wW6YGdxG/Zk+3C3ePgle4iFYeQBZqiqGh2Pp
 e1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659699; x=1747264499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQFNYs+5MBLEhk/YpwGvftpZAYeWxZFFM99PsEI42kc=;
 b=tpdYLyKbUGxPjE38UKlIHV31yzExlB/yc4U5ZrRfhD0QB8cXWi8BPTAS2kVfdWrkTi
 X2g69F8jcwGea9ue6m7Znt7dHM38hiIXo7/BhDlbPBP8z6wiXgQITcVvpSP+xDxBsc9p
 oR8QX9siawoGWYcfzoLGYrnfPz80euEsou9ICHk0R3CPU8aOD1JcwnAC9sAHi6sEcY9t
 SSF5Xg9W4OkniGWWYOCRKX8YGYfsq52g2g6OjbIqS+heqfIFpAlGN0R9VRR9DI0xpeif
 JZyz8eb2LDT54pLaDWKvbS7JDaSBurn8quwFDpT+plV9WRGHHJlEB6XS7/Sbs4cDC/Ft
 Feog==
X-Gm-Message-State: AOJu0Yy08/ixty0R8uvloLr/yyWjHUEFHQWW9eq+Ywg+V/HuYMtRDXJ0
 K1wrGV07FAcUTwNSzxIbDbhha9IxT7n5RRgIKg+lXZtMLqLDubIcfklDe7NPin1IXGBd17Ll/Jz
 s+LqHow==
X-Gm-Gg: ASbGncuJhgerMg3IG01AVudtz2S448rrWujxhHTo+u8kM3NTqRXB3oReri5a8xLmb8B
 wErtDlUTVjPCH8Zb341JKgZ9S+2iVn2/16+ChVWTiAsxQyIhQOvEubROYeQZYafFsuepHqArMx0
 gNcKFIfR/S9rYMY7av6x3CaN+KlGFXG+2ITK9KvItFbTXT+1AgQzchSahaBTs5p74ojMNMU/MAq
 Z2P7oTdQ+KKuzpsQEIi3z6dD9fGO9FkW/nNDGNiPqLeH4xgy60t9N805wQat+Ms9ChKvMu9AZD5
 dIzj0hjDFXuSvYISQQmgGu/G+lTkaUZt6vHYHNeC
X-Google-Smtp-Source: AGHT+IFEoRfQsYrvh8/50kwwZBMMzjb0S1mqp/fy8lbubOgUdWtR4vUsb970fbOPikIFeUQYSPrv1A==
X-Received: by 2002:a17:902:d487:b0:227:ac2a:2472 with SMTP id
 d9443c01a7336-22e865f7ea1mr17243255ad.28.1746659699493; 
 Wed, 07 May 2025 16:14:59 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:14:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 09/13] qapi: transform target specific 'if' in runtime checks
Date: Wed,  7 May 2025 16:14:39 -0700
Message-ID: <20250507231442.879619-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/machine-target.json | 84 ++++++++++++++++++++++++----------------
 qapi/misc-target.json    | 48 ++++++++++++-----------
 scripts/qapi/expr.py     |  9 +++--
 3 files changed, 81 insertions(+), 60 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 541f93eeb78..6174b7291ca 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -96,7 +96,7 @@
 ##
 { 'struct': 'CpuModelBaselineInfo',
   'data': { 'model': 'CpuModelInfo' },
-  'if': 'TARGET_S390X' }
+  'runtime_if': 'target_s390x()' }
 
 ##
 # @CpuModelCompareInfo:
@@ -120,7 +120,7 @@
 { 'struct': 'CpuModelCompareInfo',
   'data': { 'result': 'CpuModelCompareResult',
             'responsible-properties': ['str'] },
-  'if': 'TARGET_S390X' }
+  'runtime_if': 'target_s390x()' }
 
 ##
 # @query-cpu-model-comparison:
@@ -179,7 +179,7 @@
 { 'command': 'query-cpu-model-comparison',
   'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
   'returns': 'CpuModelCompareInfo',
-  'if': 'TARGET_S390X' }
+  'runtime_if': 'target_s390x()' }
 
 ##
 # @query-cpu-model-baseline:
@@ -235,7 +235,7 @@
   'data': { 'modela': 'CpuModelInfo',
             'modelb': 'CpuModelInfo' },
   'returns': 'CpuModelBaselineInfo',
-  'if': 'TARGET_S390X' }
+  'runtime_if': 'target_s390x()' }
 
 ##
 # @CpuModelExpansionInfo:
@@ -256,12 +256,15 @@
 { 'struct': 'CpuModelExpansionInfo',
   'data': { 'model': 'CpuModelInfo',
             'deprecated-props' : { 'type': ['str'],
-                                   'if': 'TARGET_S390X' } },
-  'if': { 'any': [ 'TARGET_S390X',
-                   'TARGET_I386',
-                   'TARGET_ARM',
-                   'TARGET_LOONGARCH64',
-                   'TARGET_RISCV' ] } }
+                                   'runtime_if': 'target_s390x()'} },
+  'runtime_if': { 'any': [ 'target_s390x()',
+                           'target_i386()',
+                           'target_x86_64()',
+                           'target_arm()',
+                           'target_aarch64()',
+                           'target_loongarch64()',
+                           'target_riscv32()',
+                           'target_riscv64()' ] } }
 
 ##
 # @query-cpu-model-expansion:
@@ -311,11 +314,14 @@
   'data': { 'type': 'CpuModelExpansionType',
             'model': 'CpuModelInfo' },
   'returns': 'CpuModelExpansionInfo',
-  'if': { 'any': [ 'TARGET_S390X',
-                   'TARGET_I386',
-                   'TARGET_ARM',
-                   'TARGET_LOONGARCH64',
-                   'TARGET_RISCV' ] } }
+  'runtime_if': { 'any': [ 'target_s390x()',
+                           'target_i386()',
+                           'target_x86_64()',
+                           'target_arm()',
+                           'target_aarch64()',
+                           'target_loongarch64()',
+                           'target_riscv32()',
+                           'target_riscv64()' ] } }
 
 ##
 # @CpuDefinitionInfo:
@@ -378,13 +384,18 @@
             'typename': 'str',
             '*alias-of' : 'str',
             'deprecated' : 'bool' },
-  'if': { 'any': [ 'TARGET_PPC',
-                   'TARGET_ARM',
-                   'TARGET_I386',
-                   'TARGET_S390X',
-                   'TARGET_MIPS',
-                   'TARGET_LOONGARCH64',
-                   'TARGET_RISCV' ] } }
+  'runtime_if': { 'any': [ 'target_ppc()',
+                           'target_ppc64()',
+                           'target_arm()',
+                           'target_aarch64()',
+                           'target_i386()',
+                           'target_x86_64()',
+                           'target_s390x()',
+                           'target_mips()',
+                           'target_mips64()',
+                           'target_loongarch64()',
+                           'target_riscv32()',
+                           'target_riscv64()' ] } }
 
 ##
 # @query-cpu-definitions:
@@ -396,13 +407,18 @@
 # Since: 1.2
 ##
 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
-  'if': { 'any': [ 'TARGET_PPC',
-                   'TARGET_ARM',
-                   'TARGET_I386',
-                   'TARGET_S390X',
-                   'TARGET_MIPS',
-                   'TARGET_LOONGARCH64',
-                   'TARGET_RISCV' ] } }
+  'runtime_if': { 'any': [ 'target_ppc()',
+                           'target_ppc64()',
+                           'target_arm()',
+                           'target_aarch64()',
+                           'target_i386()',
+                           'target_x86_64()',
+                           'target_s390x()',
+                           'target_mips()',
+                           'target_mips64()',
+                           'target_loongarch64()',
+                           'target_riscv32()',
+                           'target_riscv64()' ] } }
 
 ##
 # @S390CpuPolarization:
@@ -414,7 +430,7 @@
 ##
 { 'enum': 'S390CpuPolarization',
   'data': [ 'horizontal', 'vertical' ],
-  'if': 'TARGET_S390X'
+  'runtime_if': 'target_s390x()'
 }
 
 ##
@@ -453,7 +469,7 @@
       '*dedicated': 'bool'
   },
   'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
+  'runtime_if': { 'all': [ 'target_s390x()' , 'target_has_kvm()' ] }
 }
 
 ##
@@ -489,7 +505,7 @@
 { 'event': 'CPU_POLARIZATION_CHANGE',
   'data': { 'polarization': 'S390CpuPolarization' },
   'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+  'runtime_if': { 'all': [ 'target_s390x()' , 'target_has_kvm()' ] }
 }
 
 ##
@@ -503,7 +519,7 @@
 ##
 { 'struct': 'CpuPolarizationInfo',
   'data': { 'polarization': 'S390CpuPolarization' },
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+  'runtime_if': { 'all': [ 'target_s390x()' , 'target_has_kvm()' ] }
 }
 
 ##
@@ -519,5 +535,5 @@
 ##
 { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
   'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+  'runtime_if': { 'all': [ 'target_s390x()' , 'target_has_kvm()' ] }
 }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 42e4a7417dc..54500533e5b 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -17,7 +17,7 @@
 #     <- { "return": {} }
 ##
 { 'command': 'rtc-reset-reinjection',
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @SevState:
@@ -45,7 +45,7 @@
 { 'enum': 'SevState',
   'data': ['uninit', 'launch-update', 'launch-secret', 'running',
            'send-update', 'receive-update' ],
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @SevGuestType:
@@ -60,7 +60,7 @@
 ##
 { 'enum': 'SevGuestType',
   'data': [ 'sev', 'sev-snp' ],
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @SevGuestInfo:
@@ -76,7 +76,7 @@
 { 'struct': 'SevGuestInfo',
   'data': { 'policy': 'uint32',
             'handle': 'uint32' },
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @SevSnpGuestInfo:
@@ -89,7 +89,7 @@
 ##
 { 'struct': 'SevSnpGuestInfo',
   'data': { 'snp-policy': 'uint64' },
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @SevInfo:
@@ -121,7 +121,7 @@
   'data': {
       'sev': 'SevGuestInfo',
       'sev-snp': 'SevSnpGuestInfo' },
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 
 ##
@@ -141,7 +141,7 @@
 #                      "handle" : 1 } }
 ##
 { 'command': 'query-sev', 'returns': 'SevInfo',
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @SevLaunchMeasureInfo:
@@ -153,7 +153,7 @@
 # Since: 2.12
 ##
 { 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'},
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @query-sev-launch-measure:
@@ -170,7 +170,7 @@
 #     <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
 ##
 { 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo',
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @SevCapability:
@@ -197,7 +197,7 @@
             'cpu0-id': 'str',
             'cbitpos': 'int',
             'reduced-phys-bits': 'int'},
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @query-sev-capabilities:
@@ -217,7 +217,7 @@
 #                      "cbitpos": 47, "reduced-phys-bits": 1}}
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @sev-inject-launch-secret:
@@ -234,7 +234,7 @@
 ##
 { 'command': 'sev-inject-launch-secret',
   'data': { 'packet-header': 'str', 'secret': 'str', '*gpa': 'uint64' },
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @SevAttestationReport:
@@ -248,7 +248,7 @@
 ##
 { 'struct': 'SevAttestationReport',
   'data': { 'data': 'str'},
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @query-sev-attestation-report:
@@ -272,7 +272,7 @@
 { 'command': 'query-sev-attestation-report',
   'data': { 'mnonce': 'str' },
   'returns': 'SevAttestationReport',
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @GICCapability:
@@ -297,7 +297,7 @@
   'data': { 'version': 'int',
             'emulated': 'bool',
             'kernel': 'bool' },
-  'if': 'TARGET_ARM' }
+  'runtime_if': { 'any': [ 'target_arm()', 'target_aarch64()' ] } }
 
 ##
 # @query-gic-capabilities:
@@ -316,7 +316,7 @@
 #                     { "version": 3, "emulated": false, "kernel": true } ] }
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
-  'if': 'TARGET_ARM' }
+  'runtime_if': { 'any': [ 'target_arm()', 'target_aarch64()' ] } }
 
 ##
 # @SGXEPCSection:
@@ -356,7 +356,7 @@
             'sgx2': 'bool',
             'flc': 'bool',
             'sections': ['SGXEPCSection']},
-   'if': 'TARGET_I386' }
+   'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @query-sgx:
@@ -375,7 +375,8 @@
 #                      "sections": [{"node": 0, "size": 67108864},
 #                      {"node": 1, "size": 29360128}]} }
 ##
-{ 'command': 'query-sgx', 'returns': 'SGXInfo', 'if': 'TARGET_I386' }
+{ 'command': 'query-sgx', 'returns': 'SGXInfo',
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @query-sgx-capabilities:
@@ -394,7 +395,8 @@
 #                      "section" : [{"node": 0, "size": 67108864},
 #                      {"node": 1, "size": 29360128}]} }
 ##
-{ 'command': 'query-sgx-capabilities', 'returns': 'SGXInfo', 'if': 'TARGET_I386' }
+{ 'command': 'query-sgx-capabilities', 'returns': 'SGXInfo',
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 
 ##
@@ -418,7 +420,7 @@
 ##
 { 'enum': 'EvtchnPortType',
   'data': ['closed', 'unbound', 'interdomain', 'pirq', 'virq', 'ipi'],
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @EvtchnInfo:
@@ -449,7 +451,7 @@
            'target': 'uint16',
            'pending': 'bool',
            'masked': 'bool'},
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 
 ##
@@ -488,7 +490,7 @@
 ##
 { 'command': 'xen-event-list',
   'returns': ['EvtchnInfo'],
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
 
 ##
 # @xen-event-inject:
@@ -506,4 +508,4 @@
 ##
 { 'command': 'xen-event-inject',
   'data': { 'port': 'uint32' },
-  'if': 'TARGET_I386' }
+  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 5ae26395964..f31f28ecb10 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -638,7 +638,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
 
         if meta == 'enum':
             check_keys(expr, info, meta,
-                       ['enum', 'data'], ['if', 'features', 'prefix'])
+                       ['enum', 'data'], ['if', 'runtime_if', 'features',
+                                          'prefix'])
             check_enum(expr)
         elif meta == 'union':
             check_keys(expr, info, meta,
@@ -654,7 +655,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
             check_alternate(expr)
         elif meta == 'struct':
             check_keys(expr, info, meta,
-                       ['struct', 'data'], ['base', 'if', 'features'])
+                       ['struct', 'data'], ['base', 'if', 'runtime_if',
+                                            'features'])
             normalize_members(expr['data'])
             check_struct(expr)
         elif meta == 'command':
@@ -667,7 +669,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
             check_command(expr)
         elif meta == 'event':
             check_keys(expr, info, meta,
-                       ['event'], ['data', 'boxed', 'if', 'features'])
+                       ['event'], ['data', 'boxed', 'if', 'runtime_if',
+                                   'features'])
             normalize_members(expr.get('data'))
             check_event(expr)
         else:
-- 
2.47.2


