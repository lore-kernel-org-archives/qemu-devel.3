Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71832C369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2z-00029r-Ls; Fri, 25 Apr 2025 11:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2o-0001Fp-CJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:50 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2m-0004CL-Bd
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so1928040f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595166; x=1746199966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teMG3JygoBDrbKMTX3hz7+h4Vn64sYsEGgE4H+sueD8=;
 b=uH5Aw6RcZ//9egpKj9mTt5MF6XoWpF9SFkvt6DAZYlIltG67UDkrvrb8a75sbgdZDF
 o4qhBje/XeIjE8wJO83tasTgrbYVppzXU9S1tSASLma1thDfnJ5qrxE/Ti4NsucTyfDe
 EKvPX2SoXvfwSJkYjrLc2OYuqDlwZ6pF6q0Q+WolXd2++bNS00gGM8SFLskglnAKNcD2
 SXhC85gzyFR44ZUaDHT23WYMezl7WN/O6GZ/4c396vM8i0NRgMIrOJztIe8Cvq1DCh8W
 c9ysZkiPbCKsFemSo7HKdb5XbnvoFeYFF3Y/8RmKc4JtWWp2HNCCdy3vk095IbETthxY
 nbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595166; x=1746199966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teMG3JygoBDrbKMTX3hz7+h4Vn64sYsEGgE4H+sueD8=;
 b=cTIPHNCU5nz7pd8A1DxQgXAF1DpjE8m8SQEOaan3lZfwoSd5WqTgU8zBnK3Dz+9qy7
 NQ5U40hH0J+xRrtK1ttf66Nn4xRQKZzl3DD7c39FtfAAmQYzInyhXx01IzZnsWqUlbVK
 ImlslJ5BKskVxXbEuNMy55O3AM6VSbhaMTj/k2jOrZ0xBbx4JT74XO7vxls6n1BRj7Dh
 bqWHZCJ2YJhhjHjImyspPFJO5H1VdjhQ/tZ0XDKTxeDOlDAn3ArF/1TBWRuisazFEhsm
 s9lCqmhK6w711C6m/0HscR6hcrMHtAzD5I5R3TR5SywO4lnEawiAWLJJ/Ckhu2/UP4ii
 NCtg==
X-Gm-Message-State: AOJu0YzT7ORnxEuiubts9LGWqPk9qUN0mc8Kxkll6e//cOVEVPkP2ij3
 KrCohFtq9QuP/5kN61jzim9IF4PjMQ1Ibpll0LbBPQmQNuiZWh2su99rtZRLLa1Up8pRFzjSxwe
 5
X-Gm-Gg: ASbGncst2AdoCHQyvhhE/x7aSR/AyNVEy95a47afLl4YHNpVhBe7EDbKZBBNgsEfoFV
 Ubf9m8+0/1voGx2uk6FFNHZApcN3AHk73ZstZBu9eH/Nkq/T7TrhLaW4+thsvpp8erL5ek/90Se
 D8+FLjCkhiRlYnKokUHB0eV6Lb0Cm7U3Jl/hltcjhd2ziqrvuCLXvD7lLsPU6+nf3DKknMIsaW6
 jXsA9VOK5UjheqNDV3xGzyNHkbnElfvp2kg3q6Rqhrf+9PVRo07AhizU7IzSgIu5CM6L/Ly1JTQ
 Rg1tPh6wVw5sLzHgudfXCqnEU0Hw5hgenDbdncShoO/vsDaxBytaExRSoJq0tu+8a8ZGnlC8IDx
 AzwltDu1FNjycHdg=
X-Google-Smtp-Source: AGHT+IHVPOnV4OysBe/RFdgzwdK35ucDEHmhUOGjZsO9JM18gpu9z+0CWkK34iJo7v/vX5e1NAjQAg==
X-Received: by 2002:a05:6000:40ca:b0:39c:1257:ccae with SMTP id
 ffacd0b85a97d-3a074fa76bcmr2068527f8f.57.1745595166423; 
 Fri, 25 Apr 2025 08:32:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a53108f2sm28032085e9.19.2025.04.25.08.32.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 49/58] hw/microblaze: Evaluate TARGET_BIG_ENDIAN at compile time
Date: Fri, 25 Apr 2025 17:28:33 +0200
Message-ID: <20250425152843.69638-50-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
time via #ifdef'ry, do it in C at compile time

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250417131004.47205-8-philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c | 12 ++++++------
 hw/microblaze/xlnx-zynqmp-pmu.c     | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index c887c7a99ed..bea6b689fd1 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -218,12 +218,12 @@ petalogix_ml605_init(MachineState *machine)
 
 static void petalogix_ml605_machine_init(MachineClass *mc)
 {
-#if TARGET_BIG_ENDIAN
-    mc->desc = "PetaLogix linux refdesign for xilinx ml605 (big endian)";
-    mc->deprecation_reason = "big endian support is not tested";
-#else
-    mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
-#endif
+    if (TARGET_BIG_ENDIAN) {
+        mc->desc = "PetaLogix linux refdesign for xilinx ml605 (big endian)";
+        mc->deprecation_reason = "big endian support is not tested";
+    } else {
+        mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
+    }
     mc->init = petalogix_ml605_init;
 }
 
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index ea1430f4081..ed40b5f2e05 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -181,12 +181,12 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
 
 static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
 {
-#if TARGET_BIG_ENDIAN
-    mc->desc = "Xilinx ZynqMP PMU machine (big endian)";
-    mc->deprecation_reason = "big endian support is not tested";
-#else
-    mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
-#endif
+    if (TARGET_BIG_ENDIAN) {
+        mc->desc = "Xilinx ZynqMP PMU machine (big endian)";
+        mc->deprecation_reason = "big endian support is not tested";
+    } else {
+        mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
+    }
     mc->init = xlnx_zynqmp_pmu_init;
 }
 
-- 
2.47.1


