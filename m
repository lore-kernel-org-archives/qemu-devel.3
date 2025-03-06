Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CABFC28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVp-0004yC-DO; Thu, 06 Mar 2025 10:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUS-0003l8-RM
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:29 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUR-0006hM-48
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:28 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bd45e4d91so5733365e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276225; x=1741881025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BUX6zYPG6f15eLnBlXMyTHI0pnIpQboe8CXPknmBs/s=;
 b=kEjyKDT0Gveyo07K/bZRAQT/bkUGGaBcr4QQf/eZUwKXxSc18Oa7mym4NEYmaXO4gC
 VgrsXM3ZN9Uknao0un39SL/KsAxppIi2EeH3Iafx+txyg0ohcxqxnmTcLCUr35gLwyWe
 ZQcHLXyHQIod3BzNfhg8eZT9Gj9bN26D9/Fa2VeO/Pmuvmn0uYl4j9uxNkhkHtzck5N8
 EuQfjVzf/t4vvdWFExpD8+Ew/9irbH/cJrMdFCS8Cjw4Hd6WWL74D7wiOLDuftranNMe
 48W858yeKjV00TgrDq/sdA+UjUAbqZeO5UvQKHfKuz+wMz6OD4ckkfz0adaDPMVeE2Us
 uG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276225; x=1741881025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUX6zYPG6f15eLnBlXMyTHI0pnIpQboe8CXPknmBs/s=;
 b=J1XIRYRfMs5jUsZDpUGYs27doYYdbrARJOHnMNT3m7vvwNVEdQkyNyzLyssNko9ezk
 /AeLC/qDQ41inrTu+yr23du6xd2WpCRM1ClXmZZPXXCfXAr/YL0oQw/vIpDvdz8LmRbw
 Hqt8aQOtmeIZYVtvh5R/V6HNUGoDXeKOvLqnzA1YEZZ3zsqIYmCUxBPXIvGcvwusfi99
 joHc0rwlVWLF0TfS32aQ0cLxviQ0jMVSb9Zwzb4muBO+6eae5asvSw8247EFIPm2lsJz
 SZhwBy21DNUUwEuuTfING4ymtMs/JgFYA4wXBHPrLcvQxibg8AEKu3MLqQLXcVRcYTSi
 HYKw==
X-Gm-Message-State: AOJu0YzTnSikMWGGjTOQu5flftyZzPrbGroqKmXB8rUtF4MgwXzqFztO
 HH2nl0s+n4DKKR2DlTWH+obtJ1Uk7Z2v5Xrw5J75x1U5MhgUZfrhMBFTlK+yWYslgbNB7AiFhd5
 11vI=
X-Gm-Gg: ASbGncsX+o5kGBDI44vXLnAkEo2e102RIaTbXkx9IVmdfQQ7ZmxfbcEtbWgE5VVzzDi
 6oz59+ifNtEFvkBM1lyHnWCQwNrsWfRYuVi7gApM8tUEe0G1wC8Tc3Grv3tF6kWM/ldpFhHPy8J
 y9BAdxQ4kLmVJJI0rXmDHfCGfVAW3u84Gwi+pRA6etaeGxb3h9Q94hvtPIxwKGQ17jRSZo+TF49
 iQYP1dN0FW8LAAJkKWPF7QWADm/sSWHzbX55oSO5IJhe+hR3bE+PMbZpjZDMZcntfO5vH8MlHoh
 qHXAu2WXv2hM+OdHwsC8P2IMW4RSUx/smepc58pKY7FNdLqdNPmduT+vh+Yv5yjB+aDoP5QspCX
 n+x1mXwWKZvg2Y2QqnO4=
X-Google-Smtp-Source: AGHT+IEvkLEVWVnVJ0+3wlCN6PfwpqRiojj1/29nXQzQ8XxLkgdpXjS9Od/6r4SMeYYz9exmhAUSeA==
X-Received: by 2002:a05:600c:4997:b0:43b:c824:97fa with SMTP id
 5b1f17b1804b1-43bdb3e12f3mr31592375e9.14.1741276224782; 
 Thu, 06 Mar 2025 07:50:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c88esm52884005e9.36.2025.03.06.07.50.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/54] target: Set disassemble_info::endian value for
 big-endian targets
Date: Thu,  6 Mar 2025 16:47:19 +0100
Message-ID: <20250306154737.70886-38-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field for big-endian targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210212931.62401-3-philmd@linaro.org>
---
 target/hppa/cpu.c     | 1 +
 target/m68k/cpu.c     | 1 +
 target/openrisc/cpu.c | 1 +
 target/s390x/cpu.c    | 1 +
 target/sparc/cpu.c    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 4bb5cff624e..d15f8c9c217 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -150,6 +150,7 @@ static int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
 static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     info->mach = bfd_mach_hppa20;
+    info->endian = BFD_ENDIAN_BIG;
     info->print_insn = print_insn_hppa;
 }
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index eedda07c2ab..df8b9c53fca 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -157,6 +157,7 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
 static void m68k_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
     info->print_insn = print_insn_m68k;
+    info->endian = BFD_ENDIAN_BIG;
     info->mach = 0;
 }
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 785b065b513..e8c357ae836 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -83,6 +83,7 @@ static int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
 
 static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+    info->endian = BFD_ENDIAN_BIG;
     info->print_insn = print_insn_or1k;
 }
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3bea014f9ee..972d265478d 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -243,6 +243,7 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->cap_arch = CS_ARCH_SYSZ;
+    info->endian = BFD_ENDIAN_BIG;
     info->cap_insn_unit = 2;
     info->cap_insn_split = 6;
 }
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e3b46137178..9fd222e4c82 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -106,6 +106,7 @@ static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->print_insn = print_insn_sparc;
+    info->endian = BFD_ENDIAN_BIG;
 #ifdef TARGET_SPARC64
     info->mach = bfd_mach_sparc_v9b;
 #endif
-- 
2.47.1


