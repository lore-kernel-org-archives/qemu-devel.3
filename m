Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F98C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbihH-0005L0-9r; Sat, 25 Jan 2025 11:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigl-0004zO-9b
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:20 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigh-0000ma-TT
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:13 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a88ba968aso3029339f8f.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821228; x=1738426028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVfXoDh+6S/jYxx141Eb2tmPZau06sCtOP0dQkqathI=;
 b=rgHzBP+37M63r+F4shB89gvD05ayW14E3gFACR6eVzW3RmgbrnQy8UBL1+S01Umwm3
 X2hUAkGT+wLogQ4eCK4UgjlHgrZ1e9L0ttesMR0bmoBRU3XpbuWGrE/PsjYxPhNLOMaF
 5T9RZKNVMm+Hyqz6hJtsRiY1zbfojaI3j6AwNQv883Q1anURvZ5oMWsaptj7f08IA8Ln
 FXSTnv1cZdZhzv76gM1bTsAhTXOX8Mm/m+RXUqPqx8fLgCfKTkbypYeoA/dn6+Zuy8zZ
 aSK5CrzSfxTpyR0JJTk1UoaacvHGNQE7crA1PPd+WswTVYJek1kQayuVwkIsSCLJIdkc
 7+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821228; x=1738426028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVfXoDh+6S/jYxx141Eb2tmPZau06sCtOP0dQkqathI=;
 b=fieCMNWX1ts3fyxTwYHGtuPFj6XLuDePCZOL91x2y9PCwEbyUN7QWvSwY2bm3ueI+D
 NJlyn+uH/e6wiFWU/2LBgTTSp1+zrvXmrM3b8i80+sThfWRaRRxeCW3jqE9Xg5T8tHdo
 e1X6PRITWChru9PmLgNTCKoOYmkSQvCHz0XfcZK2WlnRkuj0jB2wnWfmKBv/J9ZBNGN1
 UfGSmq6sVoVPU3ikRg9PkF7kOdztk1cjr1S5/+Hmj5N7uzn17ykHNWBJPf4vwYRD9sKz
 UQsewzjnnKQULEri0QUWes1Eyw/cgl5ge1uFtBsBjIq1dGX8E6ldzCg0enrNTz8swylG
 T/jg==
X-Gm-Message-State: AOJu0Yz0bN+xyiaL3boS3iy6zfXMSXC9iv6YBb8J3gnPyf2xmn7YatSp
 S1D0FBUI9B1RzXgWf+1ecPOVP2OZZsV3MR577BRsZ3evLA2iR8poMWSJ5jbq7iPg9byblHQZ2Eu
 TEkA=
X-Gm-Gg: ASbGncsaetFCFv+jEVqHunqwD4yP1YHG2lqR6sudl7bIdDD8L/q0UjLJ7JMYYiK3zML
 ft+JY410t9hFTdwdrD5UrlsRZwl/DCXL9WwYZJ4tOsaIy+Fps1LirowNYj41BuhswFHXsapCxB9
 uv2Fqu0dKGG6SbOB9ejcqoWgAUk0tCWDmV24l4+BBricqJouErBwfR4F7UMNEF6iarjREyE5+iH
 s5fgWR+csN/BCf74ujdzed1c+yB+YAbzVXlqvz6x8sRTqBpBKY7mOOxRhFJDspIZhlcWlfpwrOo
 KJRq0q9nweQTdTm2iDZxXO3EUaWaoEtLqcIBm/2gbMgkMIp6PgYvA92BTP4u
X-Google-Smtp-Source: AGHT+IE29e/VRe+FJHJXaEsdRGwGBRv/PBKLP5qsLl7YLqMkY1j59ys2P07V3dr5BPESbiEE7tdbpQ==
X-Received: by 2002:a5d:59ab:0:b0:386:605:77e with SMTP id
 ffacd0b85a97d-38bf57beaebmr36094501f8f.49.1737821228273; 
 Sat, 25 Jan 2025 08:07:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c42b4sm5952252f8f.99.2025.01.25.08.07.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/24] target/ppc: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:43 +0100
Message-ID: <20250125160552.20546-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
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
 target/ppc/cpu_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c05c2dc42dc..081fb5bd343 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7177,10 +7177,12 @@ static void ppc_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 static bool ppc_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -7418,6 +7420,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps ppc_sysemu_ops = {
+    .has_work = ppc_cpu_has_work,
     .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
@@ -7469,7 +7472,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
-    cc->has_work = ppc_cpu_has_work;
     cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
-- 
2.47.1


