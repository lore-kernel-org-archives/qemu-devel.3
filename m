Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0242BC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFB9-0000j9-2v; Tue, 21 Jan 2025 09:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFB4-0000aN-6B
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFB1-000379-Mz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:25 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4368a293339so65574685e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469462; x=1738074262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0wDf/v1rzss+MDug7NzvC/4aBpdZSiYNuTsdH6L/x4=;
 b=DZpJgyMKiq84AbJ+d9mDJcCdIeyXn+WnR44sn+SYVVr09UA81Z7rgE/AvBJyO1AiDi
 Q4O+uhVd0CfxvU2xhxqCNq3il5CeHt/dGkPRvOdM54LzPwHXvN2y2qgECYzfR6INtU9X
 GsU9BOzN1iFM/B+NOfZWxDORztQFKIBos1xv2RvcdrMz3vm/lPiRd3C1f6sQKCnsfZtJ
 OBfYoxsqe4mgZFfjwGa9RoYKEHy4egDe01pL5OKIBqoCUTlN2vGwDtY/0uysO6BZdNPG
 GIsv9icRlBK2POww3O4eH4d5q+0Hf66RDFbYLsZZu1QPeNyRPkumYdGrVRyFKYKh15yS
 kLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469462; x=1738074262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0wDf/v1rzss+MDug7NzvC/4aBpdZSiYNuTsdH6L/x4=;
 b=l00hmFG/CkQSCuGnbJMrymSdOOumH5IbkByAxnnl0eZnpwdg0tW7TKad9/uVldud+t
 5PWCUuv/bpmSxSVT+ScgTsn7aAKe3A9ddK97juil4I+T70lk1Nu06u2ZYntFir12A2pX
 9wd8lknmkFjfHUyJ9rv9fDSNDvkVNMxrVNbPy2+fEa92ZRcjlDUq7A1sMnTnwd7YULlK
 d7jb3usHwv2oJR1ZKzKLeHVK0rFbJYt6svzePeoxrvjO+djQFhuAZp9GoWuvPDBiwgmn
 mKcS+efRoTipafuakJqLOz/h9OtT1R7cIYKF2rYPbGsTtzafPMo7Ina9vmxfEUFWXvUM
 /RMQ==
X-Gm-Message-State: AOJu0Yy3wLsDB8MwfOzPVGfSHAxhac+/4GCvqLlTgzvZ9eOnlWOF8dMl
 0uT+8vDeVbJ5OkcMbng7LujOvdxIaPntkPdPQo9VGxA6ZvboQLa/C/Oemx8F91nIXmLPCuAqEeH
 UviE=
X-Gm-Gg: ASbGncuCQUFKMFe4pk29iCBRnjGtpJkHlnOFDkJKBc3a5Fr44py7rFHVdFq3yuby2rf
 1jkNA+vtvQADkdL/s7jitmLOE4Xj8Tf3Xiqo19knPOHNs1nwUtvvygCwEsRe3fQnNlwt9UV2O9X
 n31su7FzarSyJ7mFMJKNdUOTvABHYpOZcjKYrDKWOCSimo1QbLab4yIVVaUsQ7sjSFmPnv22wCS
 nP29yF1yIdAESs/epxu5UIgI7/BDhVkddjDZiarjd6rpNUWE8Q51EZZfhpXaMoBhqjqwDNkhAhm
 naeJbRG1O+dEdn8VoN//WhuzyUgET2efrk/87Ij9A68S
X-Google-Smtp-Source: AGHT+IHYUFOS6tZvpJOkAfU3W0IUvXEkurbm7qTDimNOrMxqJ3vKyynrsbG/ez0xMFK9Dxc30Yf2ug==
X-Received: by 2002:a05:600c:4f42:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-438913cafacmr182541425e9.11.1737469461663; 
 Tue, 21 Jan 2025 06:24:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438a1f07e1bsm134634695e9.7.2025.01.21.06.24.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:24:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/28] target/alpha: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:21 +0100
Message-ID: <20250121142341.17001-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index e1b898e5755..83164a694d8 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -63,6 +63,7 @@ static void alpha_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool alpha_cpu_has_work(CPUState *cs)
 {
     /* Here we are checking to see if the CPU should wake up from HALT.
@@ -77,6 +78,7 @@ static bool alpha_cpu_has_work(CPUState *cs)
                                     | CPU_INTERRUPT_SMP
                                     | CPU_INTERRUPT_MCHK);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -216,6 +218,7 @@ static void alpha_cpu_initfn(Object *obj)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps alpha_sysemu_ops = {
+    .has_work = alpha_cpu_has_work,
     .get_phys_page_debug = alpha_cpu_get_phys_page_debug,
 };
 #endif
@@ -251,7 +254,6 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
-    cc->has_work = alpha_cpu_has_work;
     cc->mmu_index = alpha_cpu_mmu_index;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
-- 
2.47.1


