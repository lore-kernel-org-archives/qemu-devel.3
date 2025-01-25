Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22902C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiiO-0006T9-1c; Sat, 25 Jan 2025 11:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigd-0004yn-Rh
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:19 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigb-0000mH-EH
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:06 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso21608625e9.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821223; x=1738426023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVxLloB16KKQ3LatAF3/z7GPltBurV7JlIRTNmwrSfY=;
 b=Qn6RA2CzLgOWX/mJZpX9lxHieJWnrfHFBAgqhHKEpUbOxfMxDtxo37WRIUDgWxDho4
 4xR698cVoohRAPdpV9DN18CZ/JJjD+acrmIpzHG3pTZh9Shb28xdNg/GUInrcbbwt414
 XZrEM6fJBinWB3k9m1YFhrmo93t8ZrF6rh2/4V0GmZNFmSMfEQEkwenlHkisDxh/4dLm
 +1XBQWXxMKT3KNx0S5I/LB0gJ+4tR7TEDm0B3lLViZFDQpJqvs4HZK4aYBF2pUeqHcz1
 1wN2zNOvIivJMOqr18sDkKZHbJgiLHXCbX5XMGg2lV2ZBLOFkgOl8XTK3l1ZhF7bCe7/
 0YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821223; x=1738426023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVxLloB16KKQ3LatAF3/z7GPltBurV7JlIRTNmwrSfY=;
 b=rM4XA/1QMWHdP+CxC16kE2zhfyFdchQB6yraPnrppTiS3LvR1Amf/QEGy67znbW49u
 pDEdpaumYa42wBvZWGKLbrybPSMwR4eGFEKmbXIZNUbB+HYxhBFz48IM5vWg120Z/Ugu
 6CWi+3aI8LIMpGMiHGyzt3B7wTPnR5IuZJyVdpEzXlbP6nWvGoFWiyz1OonMu0RWzFKJ
 8pbKaSa1k5nZbctkQwnSpJZ3s/U6aamdVae5HfDSq6v1xaqQSm6UCuBKaU7WltL3tsLg
 Q0kvgyQBIE2g+dm57Gh8Zu67m7pi4vVMWwQs2YV3yEnbFuo6YkNI4lRVMH0wpICkk32K
 E71A==
X-Gm-Message-State: AOJu0YxLjGpi9JVqiLtJJMaqFJXobWLuIdq2QUYh+XDrLLQT9PSUqvRE
 5rJLY0rTSZyKw8YY5nX1NWlyPG81O6Ah919HK/KGkfAtCnmxImT3tx3lngcNnCc5eMgdhEfqcHO
 DoOk=
X-Gm-Gg: ASbGnctQaZAAd3IqfU6tplJrIARGBzAiBbDuniksCScxrY88YXPgE1Z/ZSmlJ3pSFnX
 sW+NdFJZOzxmKsBCJqX31DRL0B6hgVSVEvyf2d0gjDGq7TmpbqDpMW37QUUOim4BiU9/Z6392/p
 G0c3M7dQSzdJcAfKKlbf5fPfC8raCSZmUVR2T3xCionnKwfEO3Edy6D5AcG+Qth0CVY3SB4TuoA
 lVw8Nrjeec0LG9dAFMdkL99mB/B4D51T/LQOQllfQdwkji/ioK40efDAxwAF7GyMsAAkSe/OKlu
 pP+1h4+UTt9piAPEBrfXfA/olWVo72B8YmYOWNDDpJejXPvNJi2DbM3RyEo4
X-Google-Smtp-Source: AGHT+IFyR373lNCFlgrhe7uQR2OQbsebZQ8SvwmPr31yGf2wcKxXyVTE1hhLqfKj/KTDF5AdQs1ABg==
X-Received: by 2002:a05:600c:138a:b0:435:194:3cdf with SMTP id
 5b1f17b1804b1-438914292demr315723785e9.19.1737821223566; 
 Sat, 25 Jan 2025 08:07:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4b9a1bsm64480165e9.30.2025.01.25.08.07.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 14/24] target/openrisc: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:42 +0100
Message-ID: <20250125160552.20546-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 target/openrisc/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b7bab0d7abf..5d80c4aa9ac 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -63,11 +63,13 @@ static void openrisc_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD |
                                     CPU_INTERRUPT_TIMER);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -228,6 +230,7 @@ static void openrisc_any_initfn(Object *obj)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps openrisc_sysemu_ops = {
+    .has_work = openrisc_cpu_has_work,
     .get_phys_page_debug = openrisc_cpu_get_phys_page_debug,
 };
 #endif
@@ -261,7 +264,6 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
                                        &occ->parent_phases);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
-    cc->has_work = openrisc_cpu_has_work;
     cc->mmu_index = openrisc_cpu_mmu_index;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
-- 
2.47.1


