Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF26C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UJc-0000cu-1O; Thu, 03 Apr 2025 19:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJY-0000cg-OG
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJX-0000Qx-3k
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so12473295e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724177; x=1744328977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0ep8yRGHXOIWXj4vAOUVPYwAcqcNEFgoSYnOV75PYE=;
 b=pSTaIbcbzl9ZKMqyGykW6fIguwkOOE5HdT3IianBvUQKLRAZD6AMAhpacxKP/8BKYU
 qIDS7xsTCjicYAywtHwfZKVISB+cGKLs2VwXIZ4s7lAFCYhNkELDuijmCseYuc5pAqlw
 8J1Pt9kcFG7ERZ+GV/DOzg9UiKTUmREg6IxgsaNBA6IVQCMGLKdb8ishlNsJ6Nn6NdcX
 c/PH6g+wahxPUzfkmySGA7FCCvAI1N+wgDS5uToKYM2sOsfRHKOJ6unTDYFUkWGglOuC
 4VHl8TIfqeX05PH8dnBrC7TOzlTN28+dBeyCmPDZC2/P+QmN9C5osFnkuiCzSnP1Xkjg
 XeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724177; x=1744328977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0ep8yRGHXOIWXj4vAOUVPYwAcqcNEFgoSYnOV75PYE=;
 b=ANp2CQxzmejMtLFDUR+vJQ/IG9cPmt6Dx9qy2Rm9vubIH9Po5JCpLXBy/F3M08Myrw
 eYUw+WCunDMvulZDoIuze1iFMrw9QGimr70XTkMlIvioPejJlxJ9FEN8rAnL09scGAZz
 CeJlLLuTccT0hJk3xBhQO4yZI4JZmTDyRQlQBPSRHFqryz1QPiPzs/36xGSNtbWuIf6q
 PLM7o3KQm10qT6peBqK69j5g+TwnPd8QkbyONXZEhvdxuF2nR4KhXFgAjGYPapj2otZt
 THmw3mRtU5uk2PJAP7f51K/6zVWnzh7K9PF+MirwEgw4uWL4Y3WNuyg+NZXxW8269Tqa
 39ig==
X-Gm-Message-State: AOJu0YyuzGNiXpkMdLkOrrx8RVuDkg50GWEiTasmNHD8tNRqUuICEmHy
 why6YjKhnI0LPEsDd6Wq9SBmAR7bFGXGlFKIn6fRv84TyamSvpveEUJ1JX/PNSJ3aDHJRRgNtpQ
 E
X-Gm-Gg: ASbGnctOc3hv3JAqBZyrrG5FFMyuYFLMrRrkG2i5+mhpdJ2LmwUc1eO8L+yfM98m61j
 QD1R/ZH2L6sQZsOhFu6UkTTe5LW2w5yk9GaTpL0ls2bMkupypMisQ9eeqfEsmLbnkMpFE5QVyIs
 KK9fr1UlT3dkYJuR8OtGuGyE6nou91yipnmo8u7vU1aNNQMg+NEHVMGP69UxpsXcq2wLYBWyobY
 sbc6H9vTz3PUu+e8/ioVsUo2ocIY/SXC7OKKJ6cEPQLr6QfJv/hOCCDpePLpv85rncej5V/9P5z
 dlRCZhaZkTJ4F1NblbbSavF5+3Pbz2dG4+oDq4KGTokqJbRdE66zyQJfIlYss4ieRD1aofD0rqY
 qELW/m7FphtTPKPoUFxY=
X-Google-Smtp-Source: AGHT+IECrfbvudhCb0PsPXvzL5GgXBfXlHKDKK1yYhWZfxUJgBCsodMcZioGLnrhayFw/j8Eb/QNsw==
X-Received: by 2002:a05:600c:1d29:b0:43c:fbe2:df3c with SMTP id
 5b1f17b1804b1-43ecf9c7c26mr6622225e9.26.1743724177281; 
 Thu, 03 Apr 2025 16:49:37 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a9da1sm2903124f8f.22.2025.04.03.16.49.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:49:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 03/19] qemu: Factor target_system_arch() out
Date: Fri,  4 Apr 2025 01:48:58 +0200
Message-ID: <20250403234914.9154-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target_info-impl.h |  4 ++++
 include/qemu/target_info.h      |  4 ++++
 hw/core/machine-qmp-cmds.c      |  6 ++----
 target_info-stub.c              |  1 +
 target_info.c                   | 12 ++++++++++++
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/qemu/target_info-impl.h b/include/qemu/target_info-impl.h
index 00bb746572b..0cec211e362 100644
--- a/include/qemu/target_info-impl.h
+++ b/include/qemu/target_info-impl.h
@@ -10,6 +10,7 @@
 #define QEMU_TARGET_INFO_IMPL_H
 
 #include "qemu/target_info.h"
+#include "qapi/qapi-types-machine.h"
 
 struct BinaryTargetInfo {
 
@@ -19,6 +20,9 @@ struct BinaryTargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *const name;
 
+    /* related to TARGET_ARCH definition */
+    SysEmuTarget system_arch;
+
 };
 
 #endif
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
index 5b8f17a15a3..6ca36dae8a3 100644
--- a/include/qemu/target_info.h
+++ b/include/qemu/target_info.h
@@ -9,6 +9,8 @@
 #ifndef QEMU_TARGET_INFO_H
 #define QEMU_TARGET_INFO_H
 
+#include "qapi/qapi-types-machine.h"
+
 typedef struct BinaryTargetInfo BinaryTargetInfo;
 
 const BinaryTargetInfo *target_info(void);
@@ -17,4 +19,6 @@ bool target_info_is_stub(void);
 
 const char *target_name(void);
 
+SysEmuTarget target_system_arch(void);
+
 #endif
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 6701e210f54..9e2dd348c06 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -36,8 +36,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoFastList *head = NULL, **tail = &head;
-    SysEmuTarget target = qapi_enum_parse(&SysEmuTarget_lookup, target_name(),
-                                          -1, &error_abort);
+    SysEmuTarget target = target_system_arch();
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
@@ -137,8 +136,7 @@ TargetInfo *qmp_query_target(Error **errp)
 {
     TargetInfo *info = g_malloc0(sizeof(*info));
 
-    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                                 &error_abort);
+    info->arch = target_system_arch();
 
     return info;
 }
diff --git a/target_info-stub.c b/target_info-stub.c
index db61a335908..46a240ac66a 100644
--- a/target_info-stub.c
+++ b/target_info-stub.c
@@ -14,6 +14,7 @@
 static const BinaryTargetInfo target_info_stub = {
     .is_stub = true,
     .name = TARGET_NAME,
+    .system_arch = -1,
 };
 
 const BinaryTargetInfo *target_info(void)
diff --git a/target_info.c b/target_info.c
index 6b44ea9fc0e..be4f19009b3 100644
--- a/target_info.c
+++ b/target_info.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/target_info-impl.h"
 #include "qemu/target_info.h"
+#include "qapi/error.h"
 
 bool target_info_is_stub(void)
 {
@@ -19,3 +20,14 @@ const char *target_name(void)
 {
     return target_info()->name;
 }
+
+SysEmuTarget target_system_arch(void)
+{
+    SysEmuTarget system_arch = target_info()->system_arch;
+
+    if (system_arch >= SYS_EMU_TARGET__MAX) {
+        system_arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
+                                      &error_abort);
+    }
+    return system_arch;
+}
-- 
2.47.1


