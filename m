Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B4DC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQh-0000b6-Sa; Tue, 22 Apr 2025 15:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP3-0005HM-Cd
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:33 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP1-00075M-5i
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:32 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224341bbc1dso55202715ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350529; x=1745955329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKvAZCgDROGGpDeqhjLEmq+O8T9Clsaq0QgwgecdQyM=;
 b=Qfqp81rMDzU4Y1dip6OhYlTVG16pjOb3Q6LnefK4SW2lYTlJAoNkW12K2lJuBhN4qX
 SAe7zhrQrbj2LRMqHWVlCoT8KbMAh52hBb9KhyIDOERPi6+Ak25y6aX4jpCUnSLsNmh5
 KkY4m6xJZbgu0rU9tMKHx1zKpYrxK6i2rbrnt2R2tg5kTKBKAYZKpqF6jAnSgNUqTE21
 ZA0kCTPgSym2mZ82QwZ259jKP5EW8BoH3h9ThwSIha9hoyQep1ph20HSqYOMKHMaC/ap
 RV83M1tVoISG2IpKQ5pXCrkvUOXQ7R3K4VEwlEIpY6YPO+/VxHNbm3syWgHLjzRt+vxu
 OrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350529; x=1745955329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKvAZCgDROGGpDeqhjLEmq+O8T9Clsaq0QgwgecdQyM=;
 b=crW8yPZkiqgZuPod01WkR/F2eWLbGE80IP0m7C/DS6TztxuvD2shBbkiFNTU7VPf9b
 Bpgo6bzgU7DL/DbQDZx/9i6zGbLAyKVa19FYaa1DDWQPVDhxix33yC+fRVNO4JYQx28b
 YaEoDzwQOGMJLEHvQlg+QvctACG+tfVZdLLSgbaLw82MOzONuWOS9p1b02Thc15wlX4/
 f4Ta+DeCzSdONWM0F4CoLk5k07sZ+qR9iXsmnJUkoJ1tdAelW5Mox6Qes0Sw4yNk0cme
 aOq05F5CF3r8uxvsrTiLki5kDWkY4pDDmYCv5yQgIYehLizUb2tnyyaP5h2U2bueo6W8
 Rlhg==
X-Gm-Message-State: AOJu0Yz6LDUkWF+IlE5aP9RJB3seHn4HoaOXBQpI9Ggorhayf9B8UL4I
 iVZTE2tC/dDx8zb2j/oQsYXmra5sV+KjSQxApCoy/f6s18iFMm75TJNTETb03y68bzWmLfOWMd2
 l
X-Gm-Gg: ASbGncuQb3OtBuCpL3QSUMLEBxJ4zdDAUOT0DHQV1kULCi4QYGmlJPreTJTIRNtu4yZ
 E2sgQbyf50BZczrsbLjV1Qluib4w0jPiDlf+eY94AUfcKJHEa0BekgmF3M+qFXE4dxw4rXzlq4a
 DMKSisj5Bl1TmkdA3Pk33Qr52mpV9LqkXfnNkfI5ltZiA2/RwFX0MB44yA/1KHXkpiv3UEJuguy
 QSgUAEkfD2TCytD+oEONfXkXsNwmfZ8JapLNSOdDdPTVRFK4QLhJkiFewuCzRL3nv21Kk9KAGJe
 cgfT1n/oG0utriseQ8q+GdGoZLUAKc3pqDZTcOEO9DZlPUWcdMS73g1wyUcyW68Af2bdyrf456M
 =
X-Google-Smtp-Source: AGHT+IFutHyhnMmv2BtCnbFuhQFgzHdxRvBBaMdw4Yw+VwZ0wdZ+3CdtAW3eTS6D6Tropq5ec9HlBA==
X-Received: by 2002:a17:903:1a0d:b0:220:e156:63e0 with SMTP id
 d9443c01a7336-22c53566fe7mr200821855ad.8.1745350529512; 
 Tue, 22 Apr 2025 12:35:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 105/147] exec/cpu-all: remove tswap include
Date: Tue, 22 Apr 2025 12:27:34 -0700
Message-ID: <20250422192819.302784-106-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-7-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h               | 1 -
 target/ppc/mmu-hash64.h              | 2 ++
 target/i386/tcg/system/excp_helper.c | 1 +
 target/i386/xsave_helper.c           | 1 +
 target/riscv/vector_helper.c         | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 957c86886e..bfa039ab76 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -21,7 +21,6 @@
 
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
-#include "exec/tswap.h"
 #include "hw/core/cpu.h"
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index ae8d4b37ae..b8fb12a970 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -1,6 +1,8 @@
 #ifndef MMU_HASH64_H
 #define MMU_HASH64_H
 
+#include "exec/tswap.h"
+
 #ifndef CONFIG_USER_ONLY
 
 #ifdef TARGET_PPC64
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index b0b74df72f..4badd73943 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/tlb-flags.h"
+#include "exec/tswap.h"
 #include "tcg/helper-tcg.h"
 
 typedef struct TranslateParams {
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 996e9f3bfe..24ab7be8e9 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -5,6 +5,7 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
+#include "exec/tswap.h"
 
 void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 83978be060..7fffa23bc8 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -26,6 +26,7 @@
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
+#include "exec/tswap.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
-- 
2.43.0


