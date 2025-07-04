Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5507C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdRy-0006By-9F; Fri, 04 Jul 2025 06:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRw-000683-0t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRr-0006db-QR
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d54214adso4993035e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624113; x=1752228913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VLdxvBumjozr6AaX1LMKeVrCwgZ9kkvv1MIJjkhu7gw=;
 b=UliwEVu2iH6fMFNPE+dGUvZd8o8jlPdK7KqC69OA7ufYk4z4LOAt53HKy/ZNFcqLw2
 Db4Rxak0ZW57mWj9CJDPZ/myY/b1h2tIUxQI0bYAAJoK0NvNDaTwaBnmuZ8QuQXCUM3X
 Y77elkIPsmMYAjGHfJUT5FRIp7d1Q+P7vTfTT5qcutj03S5Ph/bPS5yBZSQaoJ6yixzM
 N34MzkMm95gmvqHxkqxyBDszR91J0qaF5mQsj+vHQe/LxJLTQa65Vnpo2NXXLX2nwGBu
 +3ct++djo/BJuyhQQ3pQOHOQ7YwLH8sZulWngC23UKeKHJctIUCnDLV50qPgG7OwTD9d
 ab3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624113; x=1752228913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLdxvBumjozr6AaX1LMKeVrCwgZ9kkvv1MIJjkhu7gw=;
 b=LfN5Aatv3sEgD/YylHw7b+KCl3m/7DmiyraX3J5Y2+kPcwvaPsv5teLny1qwi8CnRd
 NdnRvdH8JJ3UzNsIgHj7MjRJrHUgLEREgcfXWwA3InNIhNnS4Qo8N31cVVxqTiDYO+lE
 PSpDoZaTFlocDKg8+Bo3CGtyrYWXQwfkRE6d2OIbnWiZ2uBXY7VQrk+CIytpweACZutk
 eZvouD71YcCzi8mnb+5WEka6bnPQN1l8BmyY5NhWJOtfOFOIYocqtzYdkxez/lga+KjW
 OPFCdHy2PUyvJDTknOiRX/7gZ26A01h4lzp0Vup5rRE4schgkEZQ+zScA10AqqwjkfPb
 MTvw==
X-Gm-Message-State: AOJu0Yygo+pcHG1adZ9sqF9AMq+kJTv8BUbSoWtKc5gVViEismiyKvsZ
 Fgz3VAjNSvNDdM/mAWH1+n41gHLYCSprxookw3Bh+ibjN6QFQkq1Afskj7IS+Wph+dK8BJj3jLL
 2+EYmOeM=
X-Gm-Gg: ASbGncsOy4boHrrUBGZ8GaxKJEdLFRh6nRSsx8f7rx6fB8T1vJfMPRatctb+jm3urkZ
 LXViuh/c8Iycq/67KEBMbcmW7b9U9lNK4t9yZYj+YFEZuVJeNyJ73CCpCK2xXn6hUSFtPcxYWLB
 uD5w6IyohywsBgRlpDwwM5nB5l8C30KKu4oVMJpjiNgi7Jhl9TSiWDrcJfFBRmmJKH+KxQvkxbl
 guLdI4pi7S4wd98d9+kYYrMqBXlh7d00eZjoeePymPiHj3r6hDSKy7Wz8PFzN4/y5GIog++OHzk
 JZJnsUdng+ufFRi2gXEVBb8vIT6LS4UV2kz+sZdIk/olj/IwP/LjA3qN/qb4FHLJxSwdHF6wtig
 R2qb6o5alBSQ9skNsf40PAcS47a0ZuPLdXQPlIHTvLnAYomg=
X-Google-Smtp-Source: AGHT+IFY/oMcoCkngkbc2pXXcV1O5nES63mgCHkFSqX3Obiii3KFGcQH/3cYI1Uq/xN+ri4HFI3Stw==
X-Received: by 2002:a05:600d:16:b0:450:d00d:d0 with SMTP id
 5b1f17b1804b1-454b3ab5cefmr12197045e9.19.1751624113201; 
 Fri, 04 Jul 2025 03:15:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1695577sm22359315e9.27.2025.07.04.03.15.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/31] accel/hvf: Restrict internal declarations
Date: Fri,  4 Jul 2025 12:14:09 +0200
Message-ID: <20250704101433.8813-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
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

Common code only needs to know whether HVF is enabled and
the QOM type. Move the rest to "hvf_int.h", removing the
need for COMPILING_PER_TARGET #ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-15-philmd@linaro.org>
---
 include/system/hvf.h     | 38 --------------------------------------
 include/system/hvf_int.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index a9a502f0c8f..d3dcf088b3f 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -14,10 +14,6 @@
 #define HVF_H
 
 #include "qemu/accel.h"
-#include "qemu/queue.h"
-#include "exec/vaddr.h"
-#include "qom/object.h"
-#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_HVF
@@ -40,38 +36,4 @@ typedef struct HVFState HVFState;
 DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
                          TYPE_HVF_ACCEL)
 
-#ifdef COMPILING_PER_TARGET
-struct hvf_sw_breakpoint {
-    vaddr pc;
-    vaddr saved_insn;
-    int use_count;
-    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
-};
-
-struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu,
-                                                 vaddr pc);
-int hvf_sw_breakpoints_active(CPUState *cpu);
-
-int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
-int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
-int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
-int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
-void hvf_arch_remove_all_hw_breakpoints(void);
-
-/*
- * hvf_update_guest_debug:
- * @cs: CPUState for the CPU to update
- *
- * Update guest to enable or disable debugging. Per-arch specifics will be
- * handled by calling down to hvf_arch_update_guest_debug.
- */
-int hvf_update_guest_debug(CPUState *cpu);
-void hvf_arch_update_guest_debug(CPUState *cpu);
-
-/*
- * Return whether the guest supports debugging.
- */
-bool hvf_arch_supports_guest_debug(void);
-#endif /* COMPILING_PER_TARGET */
-
 #endif
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d774e58df91..4f6db40c34e 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -12,6 +12,8 @@
 #define HVF_INT_H
 
 #include "qemu/queue.h"
+#include "exec/vaddr.h"
+#include "qom/object.h"
 
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
@@ -77,4 +79,36 @@ int hvf_put_registers(CPUState *);
 int hvf_get_registers(CPUState *);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
+struct hvf_sw_breakpoint {
+    vaddr pc;
+    vaddr saved_insn;
+    int use_count;
+    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
+};
+
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu,
+                                                 vaddr pc);
+int hvf_sw_breakpoints_active(CPUState *cpu);
+
+int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
+int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
+int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
+int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
+void hvf_arch_remove_all_hw_breakpoints(void);
+
+/*
+ * hvf_update_guest_debug:
+ * @cs: CPUState for the CPU to update
+ *
+ * Update guest to enable or disable debugging. Per-arch specifics will be
+ * handled by calling down to hvf_arch_update_guest_debug.
+ */
+int hvf_update_guest_debug(CPUState *cpu);
+void hvf_arch_update_guest_debug(CPUState *cpu);
+
+/*
+ * Return whether the guest supports debugging.
+ */
+bool hvf_arch_supports_guest_debug(void);
+
 #endif
-- 
2.49.0


