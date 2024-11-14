Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60CBD637CF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOS8-0000vh-Lz; Wed, 13 Nov 2024 20:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOS4-0000fW-Op
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:16 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOS1-0002O7-1d
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:16 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so78289f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546909; x=1732151709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8uiLmmGjHl/HLmoj7E2H8Y9eTAxD3FMaBkjbXtSXv0=;
 b=iQd6E1PLfhAmmSxaNkK7kRkbGpRAItX8KK1D+sz5Qu97I6dLfFRg622ZkReGncPSO7
 BBb1kw+FiynOrlM0WmRktdp5zvz5a/8r78t1fq+b9XCREZiClIp+7QW/gQo5D9ugJfYv
 JK3mVKBq3s+ZZBNWv2FyKOi91opTSLqmA/huLfRiEEVMXt0h65Bm8MRdg3BHYLNfoWbO
 ffUwumYbalcDFV3sHUe7+cqYFnIma4AHh2UlWUj77T5qWMSx+fD0uER+cgEypiKvbHJH
 m9F/RFATzLE2g0cPm1deI4wWuHWE2SGFx40iihnfd0MgXYGLqugyiyju8suC/WHFdTMm
 U0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546909; x=1732151709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8uiLmmGjHl/HLmoj7E2H8Y9eTAxD3FMaBkjbXtSXv0=;
 b=qEBSdyaXf/ekgRbZMoWUFhpOw6QnBptEC9ttwpoPw1BoldE3dOO45S/s/X1sJwHf9H
 hQDfSsRDq+xmyan6qXhJvveOO31urYWb6v+U7UV+6ERIuwV1DZ9o4nvFBN83NITrs0WH
 8C6TFTDAIjZI/B0tIc0oYFvqn6TnaDW4Sg0S1+FW8E50nfOqEUUm8n4iWtQ4gnV59GB1
 g2FBxBV1MbuzNo7P71s+TUWUUudNzegknwqsvV5NvYYKegpT+y5xyYOgO4+61sdmmmmG
 8B70lQ4s6x5+Ddn7+a8kzTlAcDQHRKvmvJUtEa7EL1LGeRRHom4mIkEoYKEiWYJK31Dd
 vVAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViNevRySIlCGqeEXvgQR1Efsu/BRfquuySH+19HepAPptoItVJR43jT/9xG3gBtiEMUwlTGcpbjtP2@nongnu.org
X-Gm-Message-State: AOJu0YxLBFNnjJw785waP6i2xepPVtAebrDaBYJfgQZBP5KEqkBYa9r9
 qdv6yy/ulb+cMjM87EgclY4rpzua7jbjYlfwOjbhNdY1vsOzcfWi2CHpFWXOv60=
X-Google-Smtp-Source: AGHT+IHK50zmBoBB15u0Bg6EGMq2iWpXvibiYXl8HwVfa1E+/x1N83Vl6CClqN1LX+DTgZLH9wKKkA==
X-Received: by 2002:a5d:59a6:0:b0:37d:4d3f:51e6 with SMTP id
 ffacd0b85a97d-381f186bf72mr19363024f8f.14.1731546908922; 
 Wed, 13 Nov 2024 17:15:08 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed987d95sm19923679f8f.44.2024.11.13.17.15.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:15:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/24] exec: Declare tlb_init/destroy() in 'exec/cputlb.h'
Date: Thu, 14 Nov 2024 02:12:59 +0100
Message-ID: <20241114011310.3615-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cputlb.h   | 28 +++++++++++++++++++++++-----
 include/exec/exec-all.h | 17 -----------------
 accel/tcg/cpu-exec.c    |  1 +
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 6cac7d530f..5386e53806 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -22,15 +22,33 @@
 
 #include "exec/cpu-common.h"
 
-#ifdef CONFIG_TCG
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+
+/**
+ * tlb_init - initialize a CPU's TLB
+ * @cpu: CPU whose TLB should be initialized
+ */
+void tlb_init(CPUState *cpu);
+
+/**
+ * tlb_destroy - destroy a CPU's TLB
+ * @cpu: CPU whose TLB should be destroyed
+ */
+void tlb_destroy(CPUState *cpu);
 
-#if !defined(CONFIG_USER_ONLY)
-/* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
-#endif
 
-#endif /* CONFIG_TCG */
+#else
+
+static inline void tlb_init(CPUState *cpu)
+{
+}
+static inline void tlb_destroy(CPUState *cpu)
+{
+}
+
+#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
 
 #ifndef CONFIG_USER_ONLY
 
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2c06e54387..d792203773 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -47,17 +47,6 @@ static inline bool cpu_loop_exit_requested(CPUState *cpu)
 }
 
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
-/* cputlb.c */
-/**
- * tlb_init - initialize a CPU's TLB
- * @cpu: CPU whose TLB should be initialized
- */
-void tlb_init(CPUState *cpu);
-/**
- * tlb_destroy - destroy a CPU's TLB
- * @cpu: CPU whose TLB should be destroyed
- */
-void tlb_destroy(CPUState *cpu);
 /**
  * tlb_flush_page:
  * @cpu: CPU whose TLB should be flushed
@@ -242,12 +231,6 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
                   hwaddr paddr, int prot,
                   int mmu_idx, vaddr size);
 #else
-static inline void tlb_init(CPUState *cpu)
-{
-}
-static inline void tlb_destroy(CPUState *cpu)
-{
-}
 static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
 {
 }
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8163295f34..8770493590 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -24,6 +24,7 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "trace.h"
 #include "disas/disas.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
-- 
2.45.2


