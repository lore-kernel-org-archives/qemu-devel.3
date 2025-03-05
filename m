Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA59C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqqs-0008Lu-Ht; Wed, 05 Mar 2025 10:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqp-0008KQ-AD
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:04 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqn-0002Ja-G6
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:02 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so40122975e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189199; x=1741793999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2KTLDysQM0wVa4x1RgyrU9A2skfuDU+tMT+Lbpm30s=;
 b=cZefp6PYzpclDmYXYAulhsMPbtYEw8oU4f8ykGRJPY3SYbGQTMrWN7gqfwBqcr/n50
 FK2qoblPMtcfBf1SUfk44mEebk9X2dpF4kNzYpfD1oys7bT+osqxqYDAu7JSZ2eI5sqU
 TWJXmaqALu4BXU0GaqqTDz9TJ8UXZKF3OnRM+3PvYrigDj9CzoB1hCO6JCch7j8bIWBm
 hz0dRXgFJge1/KsmxtOmVJzA/+0BxFR7cTiNloA+zbT+1eOSgVClOOTJimnfCH8X6XxW
 hbE0NM3534dxaWGb9ZA/mC3g5gSZajF0qGANTOPMbCzOjYRnp2961xeGUIqvo9AKWU6p
 86eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189199; x=1741793999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2KTLDysQM0wVa4x1RgyrU9A2skfuDU+tMT+Lbpm30s=;
 b=GwpxrAdUg5N/7ZAjAoSqI3yerZhLKM1VOImvVpZlsyPiKFc2kQHDIzn/v9X2VmzY1M
 tuGjED63YHOufXmym5rvSuQye6mG4iqyP3vB4duO5AoQaXI88TxjHxK6BSm1k5GbA6bR
 7d2/380jvbf3Pgl+lA8P5MezQTJZ6BeI8BDap0c/bo6kpi6tNPSNJ0RpHwRoC/mi8CJU
 JljVIn1y/LvWVQag69yLRkiSjGdZrjcGXpoEMqIJx6WyiR9wtWBLqEMiei0nlVxVEb8v
 oDiwPCEXEkAGHT8EgVF6+rZ0QPNocOJyhjIqD/C6tdnBSp1b/SHKVN5w8NOaVLo0L0rI
 zHLw==
X-Gm-Message-State: AOJu0YzqtbekSodfivbW7C/+uAxlfmx/zgNn9lcEgFrZLUdl0mlppuM3
 oI+wkxKQ+Cgn47jc7vMt7LibPoZ5XjGLPrL4ZmLuctMRYJbwfZuiB7m9Qw76oFIxK114ShWo8DM
 rYVU=
X-Gm-Gg: ASbGncvo+HLsie5HGs9+hRkD732Y8aYlK72RDvhXPEolCCGXp1MyadobU2FdA4nm8am
 IhWFfoX7b8+5+nb56plkp7dsBzt4fuSq1OMXSF4K6JfKuP3mwXOKhgLxxE6SW78WUR8LhkxB88N
 VY3VHipj/RusM2KK5Ya2Nnq2Z8vydW6uXqCxSuA459EUJhE57LWWQS23UgkbGeAEMY3kyuBUdJ2
 8v0rBQjayKpOPkdKBysACrLTp6PWe23pK+YQGf4UhpbTLh5EJqnJucyWm4hsYFGQw6a5U90anO2
 D5wCddPh0z8stFuYsSYkfMbiVA0RHW8SLS/kp5iV36CAeWGvnG0UAgZJVRIpbUv8oeS5++A2ZSE
 z4Jsuni7jpTKs/U5LVB8=
X-Google-Smtp-Source: AGHT+IHEb4a6rWDKmaXzEfsK4vZCgV1/vwsRpaXSrY5DLqOzPUkpFyFw4hzqDTCH2wyV+Oos6Ge0ng==
X-Received: by 2002:a5d:64a6:0:b0:391:80f:8055 with SMTP id
 ffacd0b85a97d-3911f74064bmr3611689f8f.18.1741189199555; 
 Wed, 05 Mar 2025 07:39:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391188029e0sm5643708f8f.52.2025.03.05.07.39.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:39:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 06/18] hw/mips/mipssim: Replace TARGET_MIPS64 by
 legacy_binary_is_64bit()
Date: Wed,  5 Mar 2025 16:39:16 +0100
Message-ID: <20250305153929.43687-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For legacy MIPS binaries, legacy_binary_is_64bit() is
equivalent of the compile time TARGET_MIPS64 definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/mipssim.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index c530688e769..f94dbdc428b 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
+#include "qemu/legacy_binary_info.h"
 #include "exec/address-spaces.h"
 #include "hw/clock.h"
 #include "hw/mips/mips.h"
@@ -152,13 +153,10 @@ mips_mipssim_init(MachineState *machine)
     CPUMIPSState *env;
     ResetData *reset_info;
     int bios_size;
+    unsigned clock_hz = (legacy_binary_is_64bit() ? 6 : 12) * 1000 * 1000;
 
     cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
-#ifdef TARGET_MIPS64
-    clock_set_hz(cpuclk, 6000000); /* 6 MHz */
-#else
-    clock_set_hz(cpuclk, 12000000); /* 12 MHz */
-#endif
+    clock_set_hz(cpuclk, clock_hz);
 
     /* Init CPUs. */
     cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk,
@@ -241,11 +239,8 @@ static void mips_mipssim_machine_init(MachineClass *mc)
 {
     mc->desc = "MIPS MIPSsim platform";
     mc->init = mips_mipssim_init;
-#ifdef TARGET_MIPS64
-    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("5Kf");
-#else
-    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
-#endif
+    mc->default_cpu_type = legacy_binary_is_64bit() ? MIPS_CPU_TYPE_NAME("5Kf")
+                                                    : MIPS_CPU_TYPE_NAME("24Kf");
     mc->default_ram_id = "mips_mipssim.ram";
 }
 
-- 
2.47.1


