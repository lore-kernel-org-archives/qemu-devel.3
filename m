Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B59C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBwE-00086d-Ve; Wed, 28 May 2025 04:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvd-0007uW-5s
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:25 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBva-0005DY-BG
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a3771c0f8cso3017361f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420061; x=1749024861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bhe7gTBV4OnhfdghdltDpo0UDe7FOL4IHQZxPqBae80=;
 b=UD5OIJKUzV0vCCaRA5/OaM/dv5BltA8HtpXpr8g6keNa/bsDSZRXIGJ2rDO3sQbcKi
 zZLAujcF1Hx6asihX8ANYOe2xmorSSq8uMaw5RWljfSWDNFBEeWWErC3MHtVfduh8yD1
 d93MJv7E/bxCmtQcA7QavtT0qTJzYBZvmfiTb/W0CymjiKk8i6JxgG0pPyigwCL/MYGN
 sWxETEnGrkFGrCwN1Sz8gqEMQyNSKC2Hzfu7akzGrIpHwC8HzpPKcyKsHhEmSXHMPDLs
 aXixzqPwP7WQJ6BgLnlOXTmWO26un9vNmRF1Aa8FfdYscI8wx08JqH3VRZoPkgzq8Klu
 La5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420061; x=1749024861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bhe7gTBV4OnhfdghdltDpo0UDe7FOL4IHQZxPqBae80=;
 b=R226QT7imaPrFy3jcCpytWGATwmadZPfp/IV6rI2MF4WmRbA3c2C364WveJUYPQBSB
 /XLQy+EOPp9CeEVt/H+fXOaXWZuZ48UTqBVB7vyOD1XtfvzLoid8qE7AxkirlY7Yk0Cs
 EShLRg7OcJA5kDr5ap80UyWHfj5PSUPrFt/TnA1f8uKTwcseCWKbIibrrzMCT/WFF4jJ
 IliXIBA3/lvdHPfjOL6eC9WfP/uR8XX5AZbVWHrrBoUamZhUXXaiPU8oR375IdJa76w2
 XHVkmIwAM0luZ5lr3KXDpfd1kXmoG1Up5MRQ6QDnEKFu+6gg4zXBYtGrSXpxk5R+kgqi
 HaiA==
X-Gm-Message-State: AOJu0YwVXaZDxsmjy4atc/h5sElf+mjC2QCcHGCRJccfoe3s/3P/6skf
 HrXSsRvMp//TC/cEbKDXrqxQTWnZUSMknCkSWt4OrOO63GFFmTWJYvgNWF96g5ElNtRbeKbDIWa
 +VckOtIhJLQ==
X-Gm-Gg: ASbGncu+NycMWNJHDD1IOyoXSzFjVkZdDhAxnNppUkRWMtRUKAPmi5LYaTmC7GOPk/0
 tzeKOMv3HMxf+AN5o/VVaQsJ6eGu3menprGh2JXvkKOTqpwGPEyWaZe0gBIn+D0pRx67Lu2piBz
 IyXNwPv8DP8m3TKFRLoeC8lhiX6o3mpk2C+MPOUF+8jy3JG06jZgmouyARsRQe8gJy9IbKLDpC9
 sDZD+aYhlpLATTo/s8l8q1NTuZXbIP9kI5MJ/0SPV1k54ONnm6Q8Bz+D4v9g/wOCr8hxDr2mhKU
 eyvGRV5FoLbJwMX8RKynV8y38IriZu7v8VHoFF6nBOmNQhx/kiGfp1Co
X-Google-Smtp-Source: AGHT+IEgySZhOngGkq3oASTqwG+hBWUByFPV6JS6+HGFtFoFq1oI0+kwIwMirad7gcy4aKFyAH+HnA==
X-Received: by 2002:a05:6000:2082:b0:3a1:f68b:57c9 with SMTP id
 ffacd0b85a97d-3a4cb407b33mr11670938f8f.6.1748420060730; 
 Wed, 28 May 2025 01:14:20 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 06/28] target/microblaze: Split out
 mb_transaction_failed_internal
Date: Wed, 28 May 2025 09:13:48 +0100
Message-ID: <20250528081410.157251-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use an explicit 64-bit type for the address to store in EAR.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/op_helper.c | 70 +++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 9e838dfa15..4c39207a55 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -393,38 +393,52 @@ void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
     mmu_write(env, ext, rn, v);
 }
 
+static void mb_transaction_failed_internal(CPUState *cs, hwaddr physaddr,
+                                           uint64_t addr, unsigned size,
+                                           MMUAccessType access_type,
+                                           uintptr_t retaddr)
+{
+    CPUMBState *env = cpu_env(cs);
+    MicroBlazeCPU *cpu = env_archcpu(env);
+    const char *access_name = "INVALID";
+    bool take = env->msr & MSR_EE;
+    uint32_t esr = ESR_EC_DATA_BUS;
+
+    switch (access_type) {
+    case MMU_INST_FETCH:
+        access_name = "INST_FETCH";
+        esr = ESR_EC_INSN_BUS;
+        take &= cpu->cfg.iopb_bus_exception;
+        break;
+    case MMU_DATA_LOAD:
+        access_name = "DATA_LOAD";
+        take &= cpu->cfg.dopb_bus_exception;
+        break;
+    case MMU_DATA_STORE:
+        access_name = "DATA_STORE";
+        take &= cpu->cfg.dopb_bus_exception;
+        break;
+    }
+
+    qemu_log_mask(CPU_LOG_INT, "Transaction failed: addr 0x%" PRIx64
+                  "physaddr 0x" HWADDR_FMT_plx " size %d access-type %s (%s)\n",
+                  addr, physaddr, size, access_name,
+                  take ? "TAKEN" : "DROPPED");
+
+    if (take) {
+        env->esr = esr;
+        env->ear = addr;
+        cs->exception_index = EXCP_HW_EXCP;
+        cpu_loop_exit_restore(cs, retaddr);
+    }
+}
+
 void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                unsigned size, MMUAccessType access_type,
                                int mmu_idx, MemTxAttrs attrs,
                                MemTxResult response, uintptr_t retaddr)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
-
-    qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
-                  " physaddr 0x" HWADDR_FMT_plx " size %d access type %s\n",
-                  addr, physaddr, size,
-                  access_type == MMU_INST_FETCH ? "INST_FETCH" :
-                  (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
-
-    if (!(env->msr & MSR_EE)) {
-        return;
-    }
-
-    if (access_type == MMU_INST_FETCH) {
-        if (!cpu->cfg.iopb_bus_exception) {
-            return;
-        }
-        env->esr = ESR_EC_INSN_BUS;
-    } else {
-        if (!cpu->cfg.dopb_bus_exception) {
-            return;
-        }
-        env->esr = ESR_EC_DATA_BUS;
-    }
-
-    env->ear = addr;
-    cs->exception_index = EXCP_HW_EXCP;
-    cpu_loop_exit_restore(cs, retaddr);
+    mb_transaction_failed_internal(cs, physaddr, addr, size,
+                                   access_type, retaddr);
 }
 #endif
-- 
2.43.0


