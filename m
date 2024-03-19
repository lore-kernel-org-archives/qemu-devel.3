Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29E8CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbdf-0006UP-D9; Tue, 19 Mar 2024 11:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdF-0005tO-N7
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbd0-0004yL-Ln
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:05 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34005b5927eso2061204f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863029; x=1711467829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uhrck07YAgtzhdFq8/D5fUYa0OpjmAt0ZJzdbBj3AUo=;
 b=rqu/EkySLXxLuBe89w6+sgPOBt2YinqCHysLniu6snnzBNL0LM9Bmucbl7hpMAlhRc
 wK6EIlb0wdHq1Tq3kC00WQx5fIVIlkd66wez6jZle/PqAOclD/riKF3cY48sXRFdjF3P
 UKLFEALzORtN1EEkRQf73vv/KeMQlDe3G98Hx+L+kJAsz6aVx0cUNV2Yzdn6ZaLmkSGE
 xNzYXKnGdXllCg5gyzd3VBKov1gE/9/6NFVUmD9sPWfaFEuuah5tauEgI7c/YEg9uwVY
 hEk1nYTE1xoDdBEpZVjvha33LJvi7pAaiMwqFtLORvN9N4B6/XDG5YKbOhRbnYON+HRO
 cd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863029; x=1711467829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uhrck07YAgtzhdFq8/D5fUYa0OpjmAt0ZJzdbBj3AUo=;
 b=nw/hMWlStgXmXdxvPjN/YvXtWHI4udklNhtOXANiQB2rZ964UHP/V/TMeC4QQpqCB9
 g/17DE5LvWCz7LH8GYwxf6rvqfpJvgAX+f/8eP/bT1uPm4T1zWwL9kKb1a/8j+QQrr1X
 PTpOeKnwO2rMceeQVos8Dj6DI6tfG35q2u0HYwoYeWtAscKAuNG67VSVBWDL2SjS0Jw4
 iWCg2dLerS/P9A+YkGw5R+3FeYDI0H5TIOLJnsWna5f5P4nwHzqaBFyJZffVP7iiWz5n
 13XzMS4pPTvyTJMXIx/QOLujQ9VhjxM1/cK2+wPXr8fop/8gUH9aJziIi5VGUn5YTQEk
 iXvw==
X-Gm-Message-State: AOJu0YziZ07Si2ih/PjyevmUT8ZOL3v65i8acaLlh+3zXuH/CptULU2o
 q/AkZLzXn/KhQ4jzVujDLhtjPECxyDOMsXAHfoIlDlopBVd+dQ4mUSpZ6hZsH8lWq+83kzhFhRq
 W
X-Google-Smtp-Source: AGHT+IEFpZRecB1YN1BASCgEdWgX9FWwwygcQlUuWShgXqOrPMO5UwU1c6Pt/uycNJTzkkg1C1hv0w==
X-Received: by 2002:a5d:6a46:0:b0:33e:cc2e:8286 with SMTP id
 t6-20020a5d6a46000000b0033ecc2e8286mr9495145wrw.59.1710863028662; 
 Tue, 19 Mar 2024 08:43:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 w10-20020adff9ca000000b0033e72e104c5sm12591686wrr.34.2024.03.19.08.43.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:43:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH-for-9.1 08/27] target/hexagon: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:37 +0100
Message-ID: <20240319154258.71206-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/cpu.h | 14 --------------
 target/hexagon/cpu.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 935a9c3276..1d42c33827 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -134,20 +134,6 @@ struct ArchCPU {
 
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    uint32_t hex_flags = 0;
-    *pc = env->gpr[HEX_REG_PC];
-    *cs_base = 0;
-    if (*pc == env->gpr[HEX_REG_SA0]) {
-        hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
-    }
-    *flags = hex_flags;
-}
-
 typedef HexagonCPU ArchCPU;
 
 void hexagon_translate_init(void);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 3a716b9be3..5e0a9441f2 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -273,6 +273,18 @@ static void hexagon_restore_state_to_opc(CPUState *cs,
     cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
 }
 
+static void hexagon_get_cpu_state(CPUHexagonState *env, vaddr *pc,
+                                  uint64_t *cs_base, uint32_t *flags)
+{
+    uint32_t hex_flags = 0;
+    *pc = env->gpr[HEX_REG_PC];
+    *cs_base = 0;
+    if (*pc == env->gpr[HEX_REG_SA0]) {
+        hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
+    }
+    *flags = hex_flags;
+}
+
 static void hexagon_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -327,6 +339,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .initialize = hexagon_translate_init,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
+    .get_cpu_state = hexagon_get_cpu_state,
 };
 
 static void hexagon_cpu_class_init(ObjectClass *c, void *data)
-- 
2.41.0


