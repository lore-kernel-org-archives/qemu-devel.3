Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B51BC36018
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u169K-0000VR-Kt; Sat, 05 Apr 2025 12:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169H-0000V8-8K
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169F-0005D1-D5
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso2084858f8f.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869611; x=1744474411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfypuBuFqBrJN/RG4a0oTJgQCsI2EHmEmRAR6WvMt9k=;
 b=vxLHTfg/D4TKtTufBIKTh7tG6LRGwIk033RYo5cGKjIBks1ayPus5i6jdRoGNH3zE6
 Gz8SgwiNyZAGp9mc0X4FBlDa+6V63op0R2BBMEC7t9q+UjOvzDPZrdGTNrhANWmwLidy
 V6F5zZeS495+66oM8IeR0MkjIQE/dYPUWoqtnNSA6Gp4O7Q8KFjVxzkxG7QYuFXwPgGW
 +Od3YKIe3WKm48gtLl/yl+Y7fJ0qLYOxq3kqdOp0wcozmvsm9BeAZQ8ZQ+gU+EZBCE1Q
 BxONsWILC9zZn8NCSi8sy0MH+Pue5uosl8bJ05i6djOr3Y1ZwmY9foH13QKhEHHXoQWr
 DDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869611; x=1744474411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SfypuBuFqBrJN/RG4a0oTJgQCsI2EHmEmRAR6WvMt9k=;
 b=JbuHdZQMdUgqPPtMIQHdLMx6kNe+g2VilwbXECvsoDhDZnxQ9lFLidE69oP0LL7Yc/
 clElosp/4EvpMziwDmpIhWhYXoSEBWa6qU9hs9vNDfNDRing6T1u4v17qrF5Y21oi/A3
 tluC++lfqXw6wO8c5Toe8kaOw5RumDdP/OhQ7b7m+8hrRZUDllvAMMUQaVkKXRMKqHLJ
 T4X1cPO9VUhhe4Q6/pLL04QPBl6B2w1e70bxHx47cpb0qqFTjHzM25/EV/ffx7HLXn5X
 B8mvlo3KeFymQklJvt+cVCM0GDbYVcA9U6vza7UoI1xRlxxOVDtichXzdCa4VsudBLmt
 G4bw==
X-Gm-Message-State: AOJu0YxCDWKGWoBhtnbnsA4N/d37KTH2JzMJPIuI3aZKEwFg+OMyaNRn
 Y352mYe13YOdYIpo0fJUkM6XAEvZQW8NFtDS4tPTc8ClaW2rGhonq9u10dAkS+Gy95/abEPZRTC
 d
X-Gm-Gg: ASbGnctXIMHXWj/FBxDwyzZEFa5Q4EpuL+MVaJfeRlvaiRMg2ECQChXtdcxmgQnfpvw
 m27UAA/XEyqDFwt1QzzrRmakqxEe6y2r+4dHRh7n6Iz8X8IOCNaEXZKgz9nGQKqKn7Swh8zaEur
 PVglkbMwG5lZGxh0W44OBTRy1oi030DbK8tNjFf0Wxsjjx3aDPXfEilmtolbkEIdE6xUVTcD6vS
 TICyGarq9eVxNfHmlqTjYDScFY6vZxu6SwOM+JuKBzwEzD9ZYppRr9fRJY3QCdpIcK0OtsCvm1r
 IFIImU7ckYloakm206T5VhQPboD1l8WXgbtELRHa0bOr6UhmNm3EPqVyOmIYTuyodGLeDQsPUwy
 JlBcBDvXflHleb1LLDSxK5o6e
X-Google-Smtp-Source: AGHT+IEji6hzt7oIRu2XldisRC52cX4+S9rrdxnid68Q5DfxvJOEnh4R1oFoswk8/IR2bpWiu8TyTw==
X-Received: by 2002:a5d:5f4b:0:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-39cb35aeb5amr6857276f8f.8.1743869611520; 
 Sat, 05 Apr 2025 09:13:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d75335591sm1134461f8f.1.2025.04.05.09.13.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:13:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 02/16] target/i386: Remove
 AccelCPUClass::cpu_class_init need
Date: Sat,  5 Apr 2025 18:13:06 +0200
Message-ID: <20250405161320.76854-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Expose x86_tcg_ops symbol, then directly set it as
CPUClass::tcg_ops in TYPE_X86_CPU's class_init(),
using CONFIG_TCG #ifdef'ry. No need for the
AccelCPUClass::cpu_class_init() handler anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/tcg-cpu.h |  4 ++++
 target/i386/cpu.c         |  4 ++++
 target/i386/tcg/tcg-cpu.c | 14 +-------------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
index 7580f8afb4f..85bcd61678f 100644
--- a/target/i386/tcg/tcg-cpu.h
+++ b/target/i386/tcg/tcg-cpu.h
@@ -19,6 +19,8 @@
 #ifndef TCG_CPU_H
 #define TCG_CPU_H
 
+#include "cpu.h"
+
 #define XSAVE_FCW_FSW_OFFSET    0x000
 #define XSAVE_FTW_FOP_OFFSET    0x004
 #define XSAVE_CWD_RIP_OFFSET    0x008
@@ -76,6 +78,8 @@ QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, zmm_hi256_state) != XSAVE_ZMM_HI256_OFF
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, hi16_zmm_state) != XSAVE_HI16_ZMM_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, pkru_state) != XSAVE_PKRU_OFFSET);
 
+extern const TCGCPUOps x86_tcg_ops;
+
 bool tcg_cpu_realizefn(CPUState *cs, Error **errp);
 
 int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d930ebd262e..31487f4b282 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -43,6 +43,7 @@
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
 #endif
+#include "tcg/tcg-cpu.h"
 
 #include "disas/capstone.h"
 #include "cpu-internal.h"
@@ -8903,6 +8904,9 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &i386_sysemu_ops;
 #endif /* !CONFIG_USER_ONLY */
+#ifdef CONFIG_TCG
+    cc->tcg_ops = &x86_tcg_ops;
+#endif /* CONFIG_TCG */
 
     cc->gdb_arch_name = x86_gdb_arch_name;
 #ifdef TARGET_X86_64
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 35b17f2b183..27c163d17e2 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -124,7 +124,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 
 #include "accel/tcg/cpu-ops.h"
 
-static const TCGCPUOps x86_tcg_ops = {
+const TCGCPUOps x86_tcg_ops = {
     .initialize = tcg_x86_init,
     .translate_code = x86_translate_code,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
@@ -148,17 +148,6 @@ static const TCGCPUOps x86_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void x86_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
-{
-    /* for x86, all cpus use the same set of operations */
-    cc->tcg_ops = &x86_tcg_ops;
-}
-
-static void x86_tcg_cpu_class_init(CPUClass *cc)
-{
-    cc->init_accel_cpu = x86_tcg_cpu_init_ops;
-}
-
 static void x86_tcg_cpu_xsave_init(void)
 {
 #define XO(bit, field) \
@@ -207,7 +196,6 @@ static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
     acc->cpu_target_realize = tcg_cpu_realizefn;
 #endif /* CONFIG_USER_ONLY */
 
-    acc->cpu_class_init = x86_tcg_cpu_class_init;
     acc->cpu_instance_init = x86_tcg_cpu_instance_init;
 }
 static const TypeInfo x86_tcg_cpu_accel_type_info = {
-- 
2.47.1


