Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F18C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kwN-0003n0-Sy; Wed, 23 Apr 2025 20:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktc-0005va-2o
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:58 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktY-00057m-Ux
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:55 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso354466b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456211; x=1746061011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKvAZCgDROGGpDeqhjLEmq+O8T9Clsaq0QgwgecdQyM=;
 b=TEiy2qc2Az5cbo2+7porNcxEy/LsSQd2DRQ7/5FWRdxvXUBEIW8lOc8jpHWdhL7TfZ
 9OpbRZvd9K/LPnEFq9M77uoIyPYAVNi/2KqN5uw8O4wWSvmq+h06aOqffUdAIcF+OVen
 IP3IJFGxRFQ0o0dref79xKzjscTVAiC1K6/diR+PZ2vysElD45I6mZiBsqslb4h91dmk
 jmnjakuO1uGxCsulJksoTpuprdpJi96tur38ysWJeUNzBKzF00NsVZPhHCCHa+rjP837
 Giw/Ifgc/uW967fplZfVeDyPXp/3h9M/wDjBKhxB9WbgIqV3jSrILuVN2ohDbFsOwKYu
 SDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456211; x=1746061011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKvAZCgDROGGpDeqhjLEmq+O8T9Clsaq0QgwgecdQyM=;
 b=quD5XWej69qiykPbCaQj2r9KsI6w1gs4CRU02eR7m2LioHfsdN1mlBVojjcB0MO3q6
 j9/VNs7DXLRZ8k5krh+a4hJTIwk3PV8vmhUYBuZAXgB0ZbOEiJh8vdVND1Ck8zdUM08Z
 H3UuiQYmuaOuBI7SRmLMR6Yl4dehdGW2p2v9Fmwg6ykchXiLEnta1PrWFW13BKjrCYmC
 wgzre76oLNlQmSyNeEgn4gcWCPeAyqNsqw+g85Ft/1eUv3m9VCRoBXqW2KmAmddjwTV9
 eBTR1fU84QcSX89zwWhUbdbLSwYB0/f9OCwDw5zAp771Zf23hTHOiITskJIhh8HroNxU
 j9Fg==
X-Gm-Message-State: AOJu0Yy/uKDNrawRYCr29pfsPMxBgbyH0zzAR2tplC3oUKL8Yl95tglj
 DJ9toM3+RWLMF6yk91nLEIyN1RXOnB03Atec/+8fwtOD4u0lgjgNkpdL8goVHhDosS+vnXgMugD
 U
X-Gm-Gg: ASbGncsjZwWUE4eFh6JjokIwP422F/9tP0/nhkme18yg3PUFCW7tv5dTZIt3WhF5Czk
 TcLibJhw7ZEYqTN+k1iFgIM7t2xvXtoXk0bcg2Y1WprN8bD8BmNCpWRdM992hWgkzRl7+8sHOer
 1t6YF6QvXNDUEgjssypdCFZ1JJROsJKah3zC1q6CtS6QJFXFHKIVLxS8OhX7EWeu6k//R/2nkfC
 Rd412h4dRR+FdvCen21l+xk9A8OLmMATQ/DGIK5SNxMGm20GsWfxAlLBhLNKQAxN30e1+9jkVvU
 TgvgmVR/SfM6qDnXcg9Qq+zMG0W9au3GUrfwr/zKxZl9LWCvbvfK/11Tbw0ECXpVP3fVbbtB66Q
 =
X-Google-Smtp-Source: AGHT+IGZJ05SwBAdOmi6fuWTKPEo4cAhcb5WxvZ9jokaXemJUpP3cImin8z26tJHZVbt7OymuYifbg==
X-Received: by 2002:a05:6a21:398c:b0:1f5:64fd:68eb with SMTP id
 adf61e73a8af0-20444e71abfmr938486637.7.1745456211559; 
 Wed, 23 Apr 2025 17:56:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 105/148] exec/cpu-all: remove tswap include
Date: Wed, 23 Apr 2025 17:48:50 -0700
Message-ID: <20250424004934.598783-106-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


