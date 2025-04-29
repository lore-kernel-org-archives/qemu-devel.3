Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34B1C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d6B-0000Uk-Vl; Tue, 29 Apr 2025 01:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d56-0007lB-0B
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:32 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d52-00061w-BF
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:31 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2240b4de12bso83081785ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902826; x=1746507626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T48CGR80HJJotOhNXvyZIfy4YYqwAzwBstE/RhDVQ28=;
 b=ySU9sluD+4KR98+I7Dtv6upHe3JE3MHC6cEh9of9lylRK51d3mdvv/QWgex3U+J+g5
 em0+TcSmrnf2z0QLNIf1xsQvXAD77HrwWXzatxdl+JaaBif244ahNFviPrsgSlf5DAkP
 ZVvSRd125rOktuWspSi8qjYnFGr8gLETCD7ID1g1+4UUgIKYh2vAAhTjP1TFqHYHQKSW
 igBWMSwaQJjiF4o/Y4Ytg6gFC6nMKJRRIJDfHOSqDTMFxpfyIc3v2Fc2CkU8kgULhORg
 Llkait1Q+/VAY/aX8xK1Qr5QTo5KzmDyU4vObq0Ir5dn3urBCD+USJ7sm4kAO2lk749c
 uxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902826; x=1746507626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T48CGR80HJJotOhNXvyZIfy4YYqwAzwBstE/RhDVQ28=;
 b=NZxCNm/ymCU56IDj4H05S1ivpOzw+y1Oh3fAgsyLvbQZ/vqfqJ8hVZruTbQj7Nnt+e
 2tjeDVH7eORGOZzr1YSnwJC06cG7+jRPI2p6a42GHaFYF9rNNUSUUDfwWdXnrmRGkTA9
 tpifll/zbr5B/n7dnANjWeciNBHl3n6XoESle0xJ3SFszwj3eGzM4DPUTxZtp+W21/Ti
 LSsjGpHaMbSptzLAIJensVTLlZMgUnBKajsB2wftmpd2U/rPefPiXDAiEaEid0vuTDj2
 8ESB0k09x84gpOSWBRLHG77PFSoNB5NUdeVVOkKCF3638FYHQ0qLirEt5EHl5jQ4sMCq
 2kFw==
X-Gm-Message-State: AOJu0YzoTDeUq+Z893YNV0/nc5KJqIHUGqp1hVNkwV/jR3tandRkJcl5
 DYUHGhbqKnhpE+F1Tt/gLwJ8kAmCfrs/pC6v+BFJB0ObDNCAVtw4CedKIfu+lGmwqxOYpSpwFpT
 J
X-Gm-Gg: ASbGncubXM0LNyOymOr4+wnQbC//72sb0Wgg7d8wIX8wGtthhVwrR3t2K5IoF+58SDt
 zQnEOO1r7XLSdOsAM3tje0VSV6O6l8mPuL7x3mR0SMYhDcJFETeDP1mc9eP72cB9dVsvQgKMsQh
 B19jBGgzvEw8bARigBrKgA80Z3evPe5+b8nIii1umzUuv0n04hc9jI3eX4xOYf0eLITM9dIxoKE
 JrjJB77yCN8gujE4PmxYGMj3Ku40nGKTHbRzzfWLpeiYpRzk5J07ixUzbBQj2LEg11zi0Dz01Nb
 fcFVxvWe+zDx6ayymDyVWcELKXnQ45bYz0bjG8v0
X-Google-Smtp-Source: AGHT+IG/bsI8Plp6wLuUi6N8xxtzsYztKsAI19kdOE80Gua3/ANpLwzdO+O+AKBzWj5n2J/cQnM0Ug==
X-Received: by 2002:a17:902:ea01:b0:224:1ce1:a3f4 with SMTP id
 d9443c01a7336-22dc69f83eamr176304425ad.1.1745902826200; 
 Mon, 28 Apr 2025 22:00:26 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 11/13] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
Date: Mon, 28 Apr 2025 22:00:08 -0700
Message-ID: <20250429050010.971128-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Need to stub cpu64 finalize functions.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c         |  2 --
 target/arm/cpu32-stubs.c | 24 ++++++++++++++++++++++++
 target/arm/meson.build   | 11 +++++++----
 3 files changed, 31 insertions(+), 6 deletions(-)
 create mode 100644 target/arm/cpu32-stubs.c

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 48ebaf614ee..79a853609dd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1908,7 +1908,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
 
-#ifdef TARGET_AARCH64
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         arm_cpu_sve_finalize(cpu, &local_err);
         if (local_err != NULL) {
@@ -1944,7 +1943,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
     }
-#endif
 
     if (kvm_enabled()) {
         kvm_arm_steal_time_finalize(cpu, &local_err);
diff --git a/target/arm/cpu32-stubs.c b/target/arm/cpu32-stubs.c
new file mode 100644
index 00000000000..fda7ccee4b5
--- /dev/null
+++ b/target/arm/cpu32-stubs.c
@@ -0,0 +1,24 @@
+#include "qemu/osdep.h"
+#include "target/arm/cpu.h"
+#include "target/arm/internals.h"
+#include <glib.h>
+
+void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3065081d241..c39ddc4427b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,10 +11,13 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-  'cpu64.c',
-  'gdbstub64.c',
-))
+arm_ss.add(when: 'TARGET_AARCH64',
+  if_true: files(
+    'cpu64.c',
+    'gdbstub64.c'),
+  if_false: files(
+    'cpu32-stubs.c'),
+)
 
 arm_system_ss = ss.source_set()
 arm_system_ss.add(files(
-- 
2.47.2


