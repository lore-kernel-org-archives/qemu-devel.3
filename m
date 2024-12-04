Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67C9E77171
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvyV-000143-8X; Wed, 04 Dec 2024 15:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyI-0000Uy-07
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:27:43 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyF-0000yX-DK
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:27:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so2129595e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344056; x=1733948856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OthQd7angO3Yu/emzCL7LUH+S5aSARcEIzo6mzzFka8=;
 b=WELlmwSjK0NpqMScJxkhVgND5CiF3ZZMT06gjH3xL0GfW14TqaEcOd6rvpX/Y/gdPa
 RKPz/JqZEJ0Kk1+kafFhAp++PGO7e6Ev6cw8+UiNJAhUPUi1y5t65a9L2zi9uRuvNo/H
 qowrzPWJ/W7PgkipixJQ9vvfRKQSDGRUdOusLK/XeWUU07S0Rtw1MnFfFmX0YjcG91wb
 PmhqXw7pszkAnxetzR+yBzx5EzE/dIwZvMJfhZIA9gX7CD0iQaPyi9/flG1Nvjle4RVn
 4Jt2HRAMI267sErj4dGb6STezc/HJwfFmeVb2mLGEPijioJGq2Sd5Ro2Nj6mKE35vbyl
 uHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344056; x=1733948856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OthQd7angO3Yu/emzCL7LUH+S5aSARcEIzo6mzzFka8=;
 b=e5XeoLKqhd4GTZGFCPmLHbjaJl6S6qX9bSZ4Yc38Wrj79EXiZDM0Kp3e48EcG2/q0u
 sKBqnl9sQPQmOarXy7O+lc1tAJvYjAnKKkFv66oxm8wmpWAOjFvSBE0I81HiKqCelE21
 deklYdvX92y2i8dc71Fi4jEN3S9XqayTGDuLTG2RKNB4bJ2yFDKHJdJSE29QzPfEAl6t
 XK/hIeDfgxJIYuRW4RcNhsQmlcm5dUprCTGynGlfn9lOIMHNHVf5fE9nJxTEHJv77wXj
 W4VVG3kqfz3zWJTZ5amkmQzHL1S5Nio7K6KEO/fZhFjRq77xYl0Ofvr24SrzMyC9Ssvo
 pSLQ==
X-Gm-Message-State: AOJu0YxTFIXpgirCUG+HHt6rKVS5drN5m8ZttsnJKaPRdYgfAnzJmZnI
 r44joyHRGVIjJCkNa68F4mxbA63BDAfGB6rp3sIO3OFWWlhQ7PBikBhQEP3ykb7oa3ySsDBcmpc
 F
X-Gm-Gg: ASbGnctYCVjOxpPhS1RDzy3SK4UF0NDwHDnhS6p94mcB/A25uPpYVtIoqAFYNQgqrNu
 wEpIAIw4clR6SoxoxeU0RUftH4mn1sZ3hCLhOLTBXElqyvWsoMBb9OH/qwzTmivgN/Jh4zk3sv3
 YMIQUVfhe1NIIkyil94tlFnXUE5Q9PGQlnhTSsA3dvZKKQ3kAs4Sc7qI4ixsveQSBqbMJ6G9BDN
 WFwT3M3liVMOFm3RLnPw2UplTztqX+pI5v1UkYpUrZ+8wRmGLv3aTlPzG9dezEfoWAh8OhEr9mI
 Y43Bh4UZ5OAsgRqi5oKyFaiD
X-Google-Smtp-Source: AGHT+IGL1weHWkR4ZXBoHZExspgYdvLCkRNqGxIFbn/7+ohyglQiN1a7pmCzjsSY7fMDCBu9sIdPnQ==
X-Received: by 2002:a05:600c:3103:b0:431:5c7b:e939 with SMTP id
 5b1f17b1804b1-434d09d1d68mr81549135e9.18.1733344056242; 
 Wed, 04 Dec 2024 12:27:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527eeedsm35050045e9.19.2024.12.04.12.27.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:27:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/20] target/microblaze: Implement
 CPUClass::datapath_is_big_endian
Date: Wed,  4 Dec 2024 21:25:52 +0100
Message-ID: <20241204202602.58083-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
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

Implement the MicroBlaze datapath_is_big_endian() handler,
returning the value of the ENDI bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/cpu.h |  2 ++
 target/microblaze/cpu.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3e5a3e5c605..dd6b61b34ba 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -412,6 +412,8 @@ void mb_tcg_init(void);
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
+bool mb_cpu_datapath_is_big_endian(CPUState *cs);
+
 static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 710eb1146c1..3a0e5713415 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/module.h"
+#include "sysemu/hw_accel.h"
 #include "hw/qdev-properties.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
@@ -119,6 +120,15 @@ static bool mb_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
+bool mb_cpu_datapath_is_big_endian(CPUState *cs)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+
+    cpu_synchronize_state(cs);
+
+    return !cpu->cfg.endi;
+}
+
 static int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUMBState *env = cpu_env(cs);
@@ -447,6 +457,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
+    cc->datapath_is_big_endian = mb_cpu_datapath_is_big_endian;
     cc->has_work = mb_cpu_has_work;
     cc->mmu_index = mb_cpu_mmu_index;
     cc->dump_state = mb_cpu_dump_state;
-- 
2.45.2


