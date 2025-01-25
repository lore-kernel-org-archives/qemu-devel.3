Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875ECC0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbig7-0004OS-3h; Sat, 25 Jan 2025 11:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbifw-0004LN-Cb
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:24 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbifu-0000hG-SK
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso20548555e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821180; x=1738425980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlhipGgHKI5N0qn8K1o15KvLAOg1D9rjFfwCNaRH9Tg=;
 b=uRMvEuBwpKb9qKh5ecteLWRakajXOqgvTH6Ofg17ofOlXKU9yMHa+HKLznQa5ehWaL
 lZsBybt5EWNShIGObBpiQ7xxMY+ESbejO/EuzUF4jsnf1QP0xiPQ7ltT//nggzCrQttQ
 klvMDuEmP4moIzIEAxw2ju9fwNKkRxnVwtoX1iJmG1e4qbqsm0KtqyHsni6KykvpCvIv
 Qn+u9Fmrdh5loMf6TSIpJgL21pJAs4Ymqm4Pot4IioKBgw8W1VrJVi0Fw2orzsg4KthY
 5x+OInU96mlceJgmeTRc5/V1xze2PS30XYDoar/AbJTOlUCCFxHYmu6Ud8fPqSkF5aJe
 BHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821180; x=1738425980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlhipGgHKI5N0qn8K1o15KvLAOg1D9rjFfwCNaRH9Tg=;
 b=tm/46D2B9O1ypCgzPi6aW+0oOmZUEl4l8CzBPW8VTNfbUATe36k+WYl8Lha/LJ5x3i
 eA+ENUZjHbhKDCmRUHTPQZm5WPx7j30Tu2N9+uouEmdwV9HK/JHM+edhP1NBlEDp1MzS
 f1agCOt62yVDrY5DmziBeslHlHT3J6oWh4RuADQiR4XxuL0yN4iv+NWSq/L7FcVcRofF
 CksYK9iJmgKllzRaNqtohiGYXm3Ro5vfJWt/uxxAtDZ61dk7slZ+pFnZ1F3udGLxTrHP
 B44PsmOpkdh84CSAuLEDnz3OLzaBrYiRA4+TjyIWMJC51ieqEL/22qI6EYy4oQhLEsSM
 8hkg==
X-Gm-Message-State: AOJu0YxUft+9bpzUQvDUse5pPhE3Qose0JKDRoJ5/uEJY7opBg1MjH73
 QD35WEcuiM4ILEPwkB6WuteDNp+/7IMGpamLnpZkMPaF3WAMa0O2YN8jaqXeWHi3bTHLt6l3Mvz
 mj00=
X-Gm-Gg: ASbGncucQZBgTKMmH4AEpayybn6zWxTSEEYq9paWNzyWup7cx2gl7t9eHmBpFpNOCos
 TqcTeKjFNwpks1u4bQ1+ugD1Bb+WIVRU1ldgc5Ld6/U0t7pBSQReJ7pADnhbuLqmaiQmN4lBfZ/
 u+BWMKk4PftpL51PLCQZHNOmoTG6NzIW+RDvJxPSKN4FwjA2l71EVCwiSqPXHaF9g9gZtA/fGKy
 lYrInc4iVfMtqwCfGC5TD5MayAgX0Q30ZJTIHJgliN+JRNN4jKUViadv6nMEPEbxS8zBDpUjdO0
 c4sTLWnvubpKqGN6rhsrRiXXwVmTOP6zR6SEdizqL+WsDI2GRQi2XG0d7iVZ
X-Google-Smtp-Source: AGHT+IEnLIsGd10DavwQAxzAjrn67xOsO/BHm6h3+Q5PA2j6IvFcQFS89ljG5R89xegJ/0J75ENPwA==
X-Received: by 2002:a05:600c:5486:b0:436:51bb:7a52 with SMTP id
 5b1f17b1804b1-438913c9c93mr329979235e9.7.1737821180586; 
 Sat, 25 Jan 2025 08:06:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa479sm66599865e9.5.2025.01.25.08.06.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/24] target/arm: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:33 +0100
Message-ID: <20250125160552.20546-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 048b825a006..322c95038d5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -123,6 +123,7 @@ void arm_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 /*
  * With SCTLR_ELx.NMI == 0, IRQ with Superpriority is masked identically with
  * IRQ without Superpriority. Moreover, if the GIC is configured so that
@@ -141,6 +142,7 @@ static bool arm_cpu_has_work(CPUState *cs)
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
          | CPU_INTERRUPT_EXITTB);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -2671,6 +2673,7 @@ static const gchar *arm_gdb_arch_name(CPUState *cs)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps arm_sysemu_ops = {
+    .has_work = arm_cpu_has_work,
     .get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug,
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
@@ -2721,7 +2724,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
-    cc->has_work = arm_cpu_has_work;
     cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
-- 
2.47.1


