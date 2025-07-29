Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148DDC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRM-0001nK-NY; Tue, 29 Jul 2025 20:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguEw-0001HT-9S
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:16 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguEu-0003z2-61
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-769a21bd4d5so1282173b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833610; x=1754438410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xsa98zLjycws072TZ9ULZ4wir2nAMTZECnV1abgrHqw=;
 b=NfxvJE1vBYyfXUdPhUO5IfOtxGxk8QRGGY2obqXrDKsoVEackH89zYFZETHNrDhpFQ
 r26PnuGtlvh3XMVnN6TZEqEDexHQ90iUxE37E228xZNBOOfqU7Aa7thjZOc+sysFcOe3
 kDFU+u6fha9PKhxlZGZn306zL6oqOzM1I8u1qiAVhinkFomCh0sU7VXWg+zdfAQgaN3j
 YyAvdF7YZjc7/1PKkkZMrWEBMiqwung9hb9VYRlfKVTMrmodvHb+NdzcSMnxecnITNUb
 L2ZT9rWeT4PZQlRlydTAlhs7/0qiPCw/E+bnJjxXzviKfgH9V479Unsguci7zCsMmcG8
 yxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833610; x=1754438410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xsa98zLjycws072TZ9ULZ4wir2nAMTZECnV1abgrHqw=;
 b=tLtsYSNkmfhA868hJm8+rrNMG9F+5j6dchpQsqHrfcwBcHao/Ao5y6hvaKT2qz4sgF
 Mw1Noer7ZSAvvkZ0NVHNzuPDMzBIkgcDDbDA1jqB1K2VagZwfVM6Z9TYTlV+uhWqd3Zh
 BF6pZIJ/C2Mc3bQvrDrFKbmrpXFX/OZq9f5GsZ3RIdCutoqj2vf3VR9XaT/Z0xvTkWu8
 sk+GAUmsaR0yEToD4xPVZHUI/Ump1bN6PJuNQ9Cl3dkBSQtDvIbKTwKsidg2yWr4srgh
 pfVu9LGnCYvIQPMfgJucjH/nqSvf3Wy+sCX8AIaZvburGRxMT8ijJt4AgoxWmHBvT9pe
 tB0Q==
X-Gm-Message-State: AOJu0YwwZsJgomLR+brcFxpeHQMLcK47b+fEIgf+QxjoOZy3U1Iz+TrM
 l2u9DnDiio4GcVo1Do8kjTGN/5Vnlj60rhJxdHtLpTuKPBfiAo6nk7vx5Ojiac08tEvrUQUnNWO
 DPO/L
X-Gm-Gg: ASbGnctnjcnb1kgn2gXQB0LRQrdyECShWYyq492BUU2Mj/WrNIqSNW8X3ZVeEVjqm/u
 W4bUR2RFWHy9p4qpSiFqSi8uEXPcAlKHFP+CxAepP+ynBrZa5upyhoCII5RSN6SnAAl/q+7Kg7s
 3R3vOFi3+hRY3dGpNMdrTEf3tE7/wgL5iJKBU2/dlx3cnkto68hJ0e4JykGP6tmH+C3t+oFshhn
 2oC4mq2ITdthd0VUYiGtNVOtdjmCHXtPksA1m7+l71xAQuCtAh4XC/zJ7BtleRquw2HljvXe5ed
 eSzBWv7lPvR+G/4xMVvJ2o+8HGx3xT2RkQdfMCyIiq9GwYMmQ3MKkAOFlMjdXtQ/IvCBYMa8rXx
 +5vrx+YP0T/26s9aC/M5TyPdO+5M2Pnim0lozfXEqBlReqNN8UkQBPsQYab+ZNGNbQE9gflVSOL
 urk749wYEuqg==
X-Google-Smtp-Source: AGHT+IET9tLo0lXMXHlAcoSdzVwbv/hOFnpBvEklin3OpPTOA7OF/36QQOY1Kfex3wPGWpsFhGeWhw==
X-Received: by 2002:a05:6a20:9392:b0:21f:39c9:2122 with SMTP id
 adf61e73a8af0-23dc0d84dacmr1894018637.2.1753833609787; 
 Tue, 29 Jul 2025 17:00:09 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/89] linux-user: Move get_elf_hwcap to {i386,
 x86_64}/elfload.c
Date: Tue, 29 Jul 2025 13:58:35 -1000
Message-ID: <20250730000003.599084-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Change the return type to abi_ulong, and pass in the cpu.
Duplicate the one line function between i386 and x86_64,
as most other additions to elfload.c won't be common.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h         |  3 +++
 linux-user/elfload.c        |  9 +--------
 linux-user/i386/elfload.c   | 10 ++++++++++
 linux-user/x86_64/elfload.c | 10 ++++++++++
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index e102e6f410..a2869ec5de 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -98,6 +98,9 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 
 extern unsigned long guest_stack_size;
 
+#if defined(TARGET_I386) || defined(TARGET_X86_64)
+abi_ulong get_elf_hwcap(CPUState *cs);
+#endif
 #if defined(TARGET_S390X) || defined(TARGET_AARCH64) || defined(TARGET_ARM)
 uint32_t get_elf_hwcap(void);
 const char *elf_hwcap_str(uint32_t bit);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ea214105ff..f05888055f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -158,14 +158,7 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-    X86CPU *cpu = X86_CPU(thread_cpu);
-
-    return cpu->env.features[FEAT_1_EDX];
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index 73fa78ef14..df171d896a 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    return cpu_env(cs)->features[FEAT_1_EDX];
+}
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 73fa78ef14..df171d896a 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    return cpu_env(cs)->features[FEAT_1_EDX];
+}
-- 
2.43.0


