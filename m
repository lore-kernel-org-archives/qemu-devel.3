Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87A1C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbigT-0004nC-Es; Sat, 25 Jan 2025 11:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigO-0004hh-F3
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:52 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigM-0000lL-Tr
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:52 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso32239165e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821209; x=1738426009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoQ5t8eM4wCpvT97M9dMQOs6qSsBVPtoxCHVU1aZxhE=;
 b=g0kUjjDrpKxKA7Y1DinBul2kfZ5n2R6fJDH16aRNRzIpxlH3OOLijPFciJrnMmwuGI
 wUq9CMwme0EMWtqA72b8diWyU8MdfSnIAGHrIqLgFqPd2Kw4702iGEQqs5HcgLS1eWzw
 D1TtwGB+5W+MfuMj12pWG5+nkhffLXajGdaFjjxcixWZKXDzfCQmEb9K3R7z9TcP2mI+
 nVNF4/bzwlGPwV0KGaxJLCHRiyE1itKI986x8Pzc5g5hTzi9oVbYu7+Hi3xYoKfdCBeF
 N2/9pHKXxIjVNsUxRC6VgA8mnlthBYcS2L6WjgfH9+E7X4iF2f8FeEoRpoZVWBIxJgGL
 k3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821209; x=1738426009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yoQ5t8eM4wCpvT97M9dMQOs6qSsBVPtoxCHVU1aZxhE=;
 b=KFq/pJ4uJQvwjJmnssNciHhlgPgNC7Q/l66NEcogaxDAQiPio2yJ8sbpkZUMLx1wSb
 mcKeYEhAr2UBYpdasGpEDt0ctid8eHeI6nzT3CzPA4bxhqGCOriucpHT9wna7mbQbXzX
 yxrx/O4eJMuFcYzHlIE1H3JNzATpr92DeJzil50Mng4VlP6sW9NT1rnNAV8Y/tXGeZcX
 Q4q4s75WIE11VvD4pg+fnlFZl4TFewzfkyrjQZI7UOZ/CoWVcRYhBq2d+DEzKhaDDNpZ
 +zuEJUIVwmgFpXEP/QlNjBjpWvQA1hENufa85oe3jP17KE5Z5aZsZzrewKvKbtSxvrAC
 81ew==
X-Gm-Message-State: AOJu0YyhkSLC/VjaTUvE5mKq82Ejsui+/doR8n/vxmF3h64Z4QvgAFSD
 QbivrIBApmBggZ60DRp55tikLBUUpqYCU5lLM9QHtkhJBC3Aokt5OumiU40VUGcRpbVbwA/bOgS
 XFcI=
X-Gm-Gg: ASbGnctbYPdxYGMTZktpDygwtLja/LR+uQ3aiPJtoqByaHITsChxwT1pEa/70L2z+N6
 ifKdeBdgizGH6MNuXCA67+wo3CsF2OD3TVZeC/Tt74PWyUFpTbli/C9iKrHV9klh8xKHROU7KlM
 LFlmfkFPFX74HjYxbxG7dpYXfEz4j0h/yB3GcWkWThTciQR6rVG2Irug0ThhuM4RPU91vDAQWa6
 g5vvMmy2A17++zE8y99VIA/HqjUW3sWQFAWZsL6TxXFisV0iCzW7tuGXGJxFdE7HGbLMwwSFTSY
 QubWxfyuA9GzyngI4Z5RRsGSwFFqT+NQMrOSH8tU56JFlbe9Xr9NDG+f2zpH
X-Google-Smtp-Source: AGHT+IFuk614/SQNsATqkDcTFnF32ZQWSllROnIjTf92x9cZHKb1qoFw1csQKbkwXGzNPqK5/5A+6w==
X-Received: by 2002:a05:6000:1f85:b0:385:e374:be1 with SMTP id
 ffacd0b85a97d-38bf5662b18mr33155014f8f.13.1737821208961; 
 Sat, 25 Jan 2025 08:06:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d70bsm6061750f8f.33.2025.01.25.08.06.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/24] target/m68k: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:39 +0100
Message-ID: <20250125160552.20546-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
 target/m68k/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 41dfdf58045..eb7fb4f7e4c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -51,10 +51,12 @@ static void m68k_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool m68k_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int m68k_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -543,6 +545,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
+    .has_work = m68k_cpu_has_work,
     .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
 };
 #endif /* !CONFIG_USER_ONLY */
@@ -576,7 +579,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
-    cc->has_work = m68k_cpu_has_work;
     cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
-- 
2.47.1


