Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88ABC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbja1-000275-T4; Sat, 25 Jan 2025 12:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYx-0000xT-LS
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:15 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYv-0000cG-VV
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:15 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43618283d48so21881595e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824592; x=1738429392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNzeIykutuJ1S2XsFr1DnQpgi/RVEgAeGStb8yeCtY8=;
 b=nuh0g/kNJ2xzsMnfmBWbxC3rPkpxT/BcPca5FxGH3Edzn54r56S88Wy7nEQNwRQV3Y
 WQjEUZGWZUMiog1AxlJMxi3XTJUHFEgU8qGFYrs3/k/OjSTBupbqcfE6Zzh5wWQoA9I/
 wu86gmJSG9Z7LTNGMP1SvBMbCq8schHluC1SnTEUaDNFlSFl8hiz11yaLB+UDlum5k4+
 QvArMLpWOD4Yz12JNwhFKIAo3epbx1+ynhphTSpoy5++dSE3EdUT3gs0WQ+JgKwd8ZsT
 vLWh4+NYezpIMtVxBEUcstNNdU7hQeg+hwecQDrHE634ty/TY82+Exxdbeci29UWVHTP
 5hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824592; x=1738429392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNzeIykutuJ1S2XsFr1DnQpgi/RVEgAeGStb8yeCtY8=;
 b=DZ/75B+wURV7jR04H1h90WNTMzn/7jv7MCcSCMiak0CTug/uxtbGfxH5oWlSVowZXD
 0pXIx9vsQwSjno7Eusvd+hOqChjPs04GhUbSmvufq8f9xIGlR3d1LYDMDortPeMosWMX
 p4t+bbAHic4K4bZiTssPII7dk3OXuqwvQi+z559H1/Njl+oPc53AU84kgN7QdBJfLDpn
 bDgU+Fwnjlm7l8WwOgUin/kqRUjaIGfH8+5NvbFUZ2iT5XzBeX6g6q669q+5+VdbA/1d
 oxPnVyUg9LgS3DeNQI6qmSO76nOmYq/rfsaP0Xmj5DxfIvWIk3eJN/8qBQDQMUvqXkeH
 39xg==
X-Gm-Message-State: AOJu0YyX5NwH7sFNnLIxzQN7jo7FCb5yLnd/kKPA63YZxbPiycnsCP+M
 bW5DK1dg+qoAg4xMdlNtiTd8nxx6ObpTm+hwS1Q0lz+kndVKdUPTgh1Gp9mdlBgHqsNwdTJ9zBj
 CGlQ=
X-Gm-Gg: ASbGncvAKfdfQNpxmjymWd46WsjDXXfJZUNwtzvnx9uVHI9l/mfyI/3Wco+jXbKF0q7
 LTe/f10NhMqL+sXaIrFSPWZGjvjcg31PUkqk1Pq3UOdjMHW9S6XJ/UbTNMK6uPgZOfXzXtBhx8D
 iyOVOXKgkXHwf4cZ7QktBUifS2SJjBCMgjaSq0xWO7eeKX3PGBb+ibBCDxBYx0Mixb+qidOCXLD
 teg4M+ZKk8IXPcN2yGhj5XX/JS5NGHHkTgiQRz3DgIkzoC8vukLSbAg0rB41R4CL5GyQXhb+g6V
 OmReZkfiymIjp7VcDpjO14OlDfLjtENv0kPh6iFfK8fRMk6ztlveW48=
X-Google-Smtp-Source: AGHT+IG6C5FVjJO3taUHiZaJ0M2z3Ygvj2xrDOGGUI75F6jQ086TAhu/Q2MFm7/NxuecWidK/yL9bQ==
X-Received: by 2002:a05:600c:1da8:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4389eca3ca1mr338915585e9.17.1737824592051; 
 Sat, 25 Jan 2025 09:03:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd5732edsm65694935e9.36.2025.01.25.09.03.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:03:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 21/24] target/sparc: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:22 +0100
Message-ID: <20250125170125.32855-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
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
 target/sparc/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index fbd38ec334a..94e807f9f84 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -776,11 +776,13 @@ static void sparc_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool sparc_cpu_has_work(CPUState *cs)
 {
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(cpu_env(cs));
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int sparc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -986,6 +988,7 @@ static const Property sparc_cpu_properties[] = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
+    .has_work = sparc_cpu_has_work,
     .get_phys_page_debug = sparc_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
 };
@@ -1027,7 +1030,6 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->has_work = sparc_cpu_has_work;
     cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
-- 
2.47.1


