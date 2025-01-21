Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5851CC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFEI-00078p-7N; Tue, 21 Jan 2025 09:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCX-0002rx-Rs
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:58 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCV-0003ii-6U
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43635796b48so36655935e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469553; x=1738074353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5HU2b7p1M8gNy7Q1wMvIjKnoAVWtRUTk8UBT9dkhhN4=;
 b=x6oEL+TMpKCORxVcsobLgkJ4lcBE97kQGMWWFC9hsOA6vuK7UHhlYyAtEiXgtThPUO
 7WG131z1HEBh9g4b5X9SILX9WJienge/1GsQj9RhYsYypCjg6suaxsXcR0tyOF/+YXRp
 id4AYjkd18odwte9UQxK3BkHbY1Z2rkst539sfIU9Rx4Xu/AYO5BC1fk9ZaMGbAgWzJO
 q1kLfsMoG9xb97gQI5h+jXvSiZdIr/K/spQ5E1+YKHl8TjIXoLu0skKBk00ssiPTMXV0
 cZdonGlD6UswZXE+jx5HdRxTv2L1ts8dJFt2ljOv5hGNjniDpu3sHbkmGxYPM/vCmXCd
 nrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469553; x=1738074353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HU2b7p1M8gNy7Q1wMvIjKnoAVWtRUTk8UBT9dkhhN4=;
 b=GzhxelY/Ry1e87kzZpWMc2fSCl1vkTfPzeSWhOM5DiMN684dJbd5EkfGdnzb04re0I
 oRdm82lmxPvy3+5nV22oqJ8E12llLLkDYY3SqRrMwJcb68p/G3b6mh8H3XYkp3JuUagq
 +4vjITB5fhPxQjacmU3l6JXET1sTicRMZVkwgvnhfJWQmSMtP/ZB3bWgWrFIqTZ11J9u
 hL/5HJr+HcT2kEE9lpzyslCYANE2pM404oohE2u7hB/mMoN02+jKgpVnYPlA1iifKxot
 64/N9zYYnKOqb/cqzrXRayhTB7+WZ2aS6JZwf0isknz5JpfoK7FpGEpaO9ud51cicfPs
 YCZQ==
X-Gm-Message-State: AOJu0Yzu/upcREcj03NY2uEESHooXr7GZWIwWMePJrY5Wv5kC0R4Af/T
 72Y+WVJApj5zpClm3SATH7WDgw5f0tNFSMpoDjAGVaaLEqHXVBh/4h9k7F66NwVtIyU7RIDo7rN
 0sFE=
X-Gm-Gg: ASbGncu1KaFMU3g3uSNKDYvcUgbxgR15YbowBdICZHHR5UYOLWx1eVMquhcSKQs2Tiu
 BtipM2EdB2zQj9N8SEOM/U5rRQC7SLciZGWirbOSU3qOYAdFb3LTA7Z++oTW0m7VwNj5S0HOJlf
 mcywwWhRblpU5PYzeoHtuXCrbWyCkdgJKMrpaExEVjNgVmd3uuxQPsNfOtARp2QLRnRIKn1nq2u
 WzlNdjxdAkPT1p0FY0PnbLYHY8QB0F2Sb9y2JWfEB0EtDeXGrQ948J5rLh7Ei77SuzK56MdmioM
 tIV8Rdsa0rhDyOaKgC+/zjLc76IZmIjbR/ceI4VrKEEH
X-Google-Smtp-Source: AGHT+IE9NOtTTWXPLNGkrwN4J7V9evFmJq/+qT1gaX2Pu4XxtqujvUkrdCA/cP4YvoV9KqWVRvG4nQ==
X-Received: by 2002:a05:600c:26c6:b0:436:1af3:5b13 with SMTP id
 5b1f17b1804b1-437c6b475f9mr239225505e9.15.1737469552939; 
 Tue, 21 Jan 2025 06:25:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890413053sm183998275e9.10.2025.01.21.06.25.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:25:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 27/28] target/xtensa: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:40 +0100
Message-ID: <20250121142341.17001-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Move has_work() from CPUClass to SysemuCPUOps, simplifying
xtensa_cpu_has_work() by directly using CPU env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


