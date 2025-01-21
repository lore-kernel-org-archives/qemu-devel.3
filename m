Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B003C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFE8-0005iC-KW; Tue, 21 Jan 2025 09:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCI-0002Qs-A1
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCG-0003d9-D7
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:42 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso58501475e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469539; x=1738074339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26PmvKZTfrtdcJJ/pIkG+XcoOAjc8KeXuItpvNN6yaQ=;
 b=tMxS0X67tGfF3I+TyrsH3/w6ECmbjJoiamkSRg+BckI3xvz1Jaya1n2Mh6sRW4eb4o
 GGg/vLvSa+44tYeoiP1jroJrq/LRvaNs7c+bWJeJzKT0OiNGdqU2B8b+2AgqAB8CRR2f
 JhJU+Tx83tVjwZBRc64M9wD0iW8h26azyuzSXC1RB59z1AYju/UBMVLaAAN6rxVndNbL
 uZ0Siv/F1HO0MoKL0TBtaNo5TjX+95DQRumW3hLd7baG0ngL+/mw8T3dYUdyg73jRHkH
 kTqtOVQOoAv3Z3AnLsTBUgTjccRi19/PKE1PhHEQvLOhAIxKedq6A0gsRqP5rvRI2i0z
 lehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469539; x=1738074339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26PmvKZTfrtdcJJ/pIkG+XcoOAjc8KeXuItpvNN6yaQ=;
 b=ukkuqILP5UCfKbrCaBzsT68yIZo1veU45fEg1GtU0gx5J4b7miTUph2wFt+ss7Sobx
 SH9RhhV4XEH6bBseZsY/6MIzN+ujb+gyuSKmm4wezIp7FaN7m/ZndR+tzEApTG9VPnOa
 n61h16u6yEgIN2YkatxP+u1ARRFtKntj5d8RKSdU+hediPzRkdZjX58HxaMtzISqIDM3
 ATL1+3dfTDhUflH84vvxKv7eKUQKzpktn5AufF1p6zEmvSU82c3fFUwVsfBxXTcbe8O9
 9UhO4oBMGW1+MMz4S5+Yy6N2v9ExdeVqauAhpWtyad7jsjBj6PiSscG0HCMj2Mkwdxg5
 SVKQ==
X-Gm-Message-State: AOJu0Yw45Aji3YYGNTpHdSjFA/h0u9b69LLg816+Q6lOa6mVdO8/Nfl2
 /5157pBjZGyEdeuKKJxM0YjdcAClrdfQ6IkohEC7aMbW7GOhaJQAxA36G4f/RyLhr0fP6QrgzIv
 AviQ=
X-Gm-Gg: ASbGncubEggPm8/tI1sULjT6+kEOvr4teZ5fDRq5T9f/LbfD+qP6GjUFqn1YJyS7GWD
 5l3Pj8hH/1o+F0VavCQfrrUs+jbFyB3I57AKbn8lt/fuT73VkJLVcnpX8/AMRapJ6DD0xaCO21o
 p9IRCDckvaSZiE6IyTT9D9e/TWf+LmSyq7nI3b/SQST2XJJx88Fq0gxskIX+hTIGgzzmcYcYURp
 HOikmvSZWhYLFuMj+ivNsMLKP37VNFfJBvTbi4u7WAym3sDuYyIXYWBdF71QKiMUuS7gxQjU0GQ
 krg2VSiO18r+5i81QpwjjiY9fz0NoNHeha+AAWq7OnqQ
X-Google-Smtp-Source: AGHT+IHn7OCXdpP6y0WKV3U3dWvYNFXahS3mrVA1x0yj2ZHdNgu1Q64ITNT06q0vuAJgcLpA6VmsGw==
X-Received: by 2002:a05:600c:4f84:b0:434:a90b:94fe with SMTP id
 5b1f17b1804b1-438913ca9bamr175432655e9.10.1737469538002; 
 Tue, 21 Jan 2025 06:25:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7540ae7sm239090455e9.33.2025.01.21.06.25.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:25:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 24/28] target/sh4: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:37 +0100
Message-ID: <20250121142341.17001-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
 target/sh4/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 24a22724c61..80a66e1f1d6 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -82,12 +82,12 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
     }
     return false;
 }
-#endif
 
 static bool superh_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -243,6 +243,7 @@ static const VMStateDescription vmstate_sh_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sh4_sysemu_ops = {
+    .has_work = superh_cpu_has_work,
     .get_phys_page_debug = superh_cpu_get_phys_page_debug,
 };
 #endif
@@ -279,7 +280,6 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
-    cc->has_work = superh_cpu_has_work;
     cc->mmu_index = sh4_cpu_mmu_index;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
-- 
2.47.1


