Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C58C0218E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiiR-0006UU-Ri; Sat, 25 Jan 2025 11:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbihT-0005gg-3H
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:08:01 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbihQ-0000qs-BT
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso21777825e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821267; x=1738426067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UoGE6unHTvdGpTVXrJG1+71hPq/Dfx21A2EoHEuKVI=;
 b=hHYsesyxy0gJMSS/wGrF/rwHtjJIq4fNXH/Pj6jF+6IXEqu070v99jdCy0tfoZxJEo
 DDEWSxZYkiwQkSHgbx+ftNwd/dAtd8Ut/5Wof88jkbyi/ksx34gRxJedXW0UfBO5c/NA
 TaQj7Ue8/Mg1/mBUPV+J4X6JY9TD9DEOYEvolO0aRkNnWmp0l8x7fcGIfCvH9R8357Bn
 WewTV/EVypWJb0NuowInkE9aNW30tNrwpjrv8JMmgxZBmWsjBkmWkNEexx5PtnVdl6O/
 fvHXm80PPEMUr9VM5zKYKlbN03nNoZednxjj4Lu9EGcCUXrHVWlhptO4eyHIUaucPF4x
 A98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821267; x=1738426067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UoGE6unHTvdGpTVXrJG1+71hPq/Dfx21A2EoHEuKVI=;
 b=suhO9O/1+1ILaN7QpO60wCCcF2/9eftefPyqXSZHXBE1tFiIYvjjeepNwxEof8XIi2
 PutpV2tK+WC4qUC56oHvZ6ChgmO21bSDpn0CzUjmO/BjYJIVMKwyWQQL5eJAm4p4ZNGP
 BlaZ7JKtjBkoCDenLRK0foH1HbkeXPCWEi3a7z//aMAOxWpHX8GEaeTfl12KaK5OikHG
 BdUTL/WkBR0t6CkbBF6N8rDjZ9MxKt/gvrNdv2gP9E5LjOhSULauEoYAhYq1z4p2UkuK
 TSb51FjiTLlQaf53wafOlf3UtPatrFhp1qK7XRBxM2Jmr9o8d19ipnDY0APtSvy8pPiJ
 mooQ==
X-Gm-Message-State: AOJu0YwSzc5oCVFA03w3dPxS3mKJm6CR2oPbO/QbuuNUuGS4FOkhED22
 vjiUmb55GwsQHPFlajoh/HkO1q2YmtntpANvHYYSJoGfgh+aOuvXH1F4nNnxnBoP4zvzm6+DRR/
 IRx8=
X-Gm-Gg: ASbGnctdvT4zBhlT1YRxx9z82G5r9SfXzP8C44tLGxjZR/5xKrlZbZtUw1FhHaRbfo6
 /SIvNmlKOWyuRiFPkrpVxtqVnKUNMikwpgkOjAkTBe/8S7+z70EfTNnBpiYPdwUspfJvRfldron
 RNlkgUe4IgOTygxXTxjhSdr094h5+zhDZIGCcxDSAlQAmSVPTeJeFdBFn2Ei+QUG7BUCYlj9EHp
 HnBRwsecKBGK7UFRXJR9Nk6iOyUFleHuozomHedhYen+XdFhRzQlOcJCNlzIp9lbxkl/rpe9d27
 5ZZjUNe+xZfAoXXfGLP4D/+gB0LiZchvsKDOit2YFf9dM82+iuvhNeGmJTk+oMBY3CEMOXw=
X-Google-Smtp-Source: AGHT+IFiUi6iyKyDvhKyW97+Syu6lKgE51e685uianCVdMwKhVvn1nZpJmv7uNn4wf0DSHL98eR99Q==
X-Received: by 2002:a05:600c:4ed4:b0:434:fdbc:5cf7 with SMTP id
 5b1f17b1804b1-438914373e4mr310199725e9.27.1737821267377; 
 Sat, 25 Jan 2025 08:07:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa463sm65705545e9.8.2025.01.25.08.07.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 23/24] target/xtensa: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:51 +0100
Message-ID: <20250125160552.20546-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Move has_work() from CPUClass to SysemuCPUOps, simplifying
xtensa_cpu_has_work() by directly using CPU env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 4eb699d1f45..c5d7682f4bf 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -63,16 +63,14 @@ static void xtensa_restore_state_to_opc(CPUState *cs,
     cpu->env.pc = data[0];
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool xtensa_cpu_has_work(CPUState *cs)
 {
-#ifndef CONFIG_USER_ONLY
-    XtensaCPU *cpu = XTENSA_CPU(cs);
+    CPUXtensaState *env = cpu_env(cs);
 
-    return !cpu->env.runstall && cpu->env.pending_irq_level;
-#else
-    return true;
-#endif
+    return !env->runstall && env->pending_irq_level;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int xtensa_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -224,6 +222,7 @@ static const VMStateDescription vmstate_xtensa_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps xtensa_sysemu_ops = {
+    .has_work = xtensa_cpu_has_work,
     .get_phys_page_debug = xtensa_cpu_get_phys_page_debug,
 };
 #endif
@@ -261,7 +260,6 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
                                        &xcc->parent_phases);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->has_work = xtensa_cpu_has_work;
     cc->mmu_index = xtensa_cpu_mmu_index;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
-- 
2.47.1


