Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8C0CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbcu-0005Wr-2T; Tue, 19 Mar 2024 11:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcr-0005Ul-Lf
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcp-0004rz-Nw
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:41 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33ed7ba1a42so2099346f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863017; x=1711467817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kOlmQKWOdk+OL6bKivQd41MjZmQhEJZYUXe/hoRFYk=;
 b=jurkxHUVSIc24pBN3Fram4I9F2nMu1vzIsCMPSHhb8nZY+uyWIsKB6g7frflcdsSKJ
 hJhotZYFeA3Ya3hDNNmCYnGewuZPKg8FWSIuyAFX4xywyzrFxpVsga7kPq+JGSLA8eTk
 t4qsTnQoATBPNSGH6sQDGx0lJbUX6JskzVgqer+QmWEAIy0b1DwnQH4PbN1raHoGY4I3
 qVt84nVvwSX9+0OFc60ozt/ThHVAvqf278FtE0XYmzZNmiONz7G6CGuJsLfRL8NUORWb
 GmvW8a2JWXvkb0sdEig8dEhLgn9NXwS3qAed2qpQiE3zqWtoDyklWFBrDrN9iZiahp/S
 z4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863017; x=1711467817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kOlmQKWOdk+OL6bKivQd41MjZmQhEJZYUXe/hoRFYk=;
 b=SeROMYIRFsKFikU1zGOb6LIbh2WAkKiivznG9pGoh2uxU3CTn7mbn5O2l89kqcTFD8
 zqh+S2+u7gu+677xxsxFzPqNupuQFMQiAz5rRKE4FghKmHH1WM08IAnFQ4m+EQ2MB0go
 l6Vp+fbSj3nlxln1frn+fNx3MsWm+CFbR9LIEFZG583uBrE/EJronT43bzBrboDOgYAc
 dymClJvvxQqUBDqAG2XCkvQN9SstGsy6DF7ymEpzETtgmO8JsP9c0Jiq15nDOyM0IFf2
 4SodFOLVDH4MR+tczaQzKwZ41lDsUPNqsi5Kh/8F2gccS1+LB/i1bjFn6bnuX02xXn49
 JOqQ==
X-Gm-Message-State: AOJu0Yx8dIIcInxODXxiQaUg3FCEk8gk3vcl3Yi79ZwLEnKXODZL7KVJ
 6m4wzRCRVFFs/uoCOjFiX/zSeRDvYNyLSmO2Peo2S+tlu2abxn8NextCFO8FrMp1nibyCSXihYt
 A
X-Google-Smtp-Source: AGHT+IFA3/92jzYGUvg+RoHJvsJy9Qs+ZM75uWtDiI4wnl0LT5YR5aHq9nZRFrf8XXq1D3bYjvibuQ==
X-Received: by 2002:a5d:5190:0:b0:33d:82a1:626d with SMTP id
 k16-20020a5d5190000000b0033d82a1626dmr1877582wrv.38.1710863017273; 
 Tue, 19 Mar 2024 08:43:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a5d504b000000b0033e7a102cfesm12592441wrt.64.2024.03.19.08.43.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:43:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH-for-9.1 06/27] target/avr: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:35 +0100
Message-ID: <20240319154258.71206-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
 target/avr/cpu.h | 20 --------------------
 target/avr/cpu.c | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 0c0aa580f5..284041a87a 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -193,26 +193,6 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags = 0;
-
-    *pc = env->pc_w * 2;
-    *cs_base = 0;
-
-    if (env->fullacc) {
-        flags |= TB_FLAGS_FULL_ACCESS;
-    }
-    if (env->skip) {
-        flags |= TB_FLAGS_SKIP;
-    }
-
-    *pflags = flags;
-}
-
 static inline int cpu_interrupts_enabled(CPUAVRState *env)
 {
     return env->sregI != 0;
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 45ee1b5f89..c765f49c9f 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -66,6 +66,24 @@ static void avr_restore_state_to_opc(CPUState *cs,
     cpu_env(cs)->pc_w = data[0];
 }
 
+static void avr_get_cpu_state(CPUAVRState *env, vaddr *pc,
+                              uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags = 0;
+
+    *pc = env->pc_w * 2;
+    *cs_base = 0;
+
+    if (env->fullacc) {
+        flags |= TB_FLAGS_FULL_ACCESS;
+    }
+    if (env->skip) {
+        flags |= TB_FLAGS_SKIP;
+    }
+
+    *pflags = flags;
+}
+
 static void avr_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -209,6 +227,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .initialize = avr_cpu_tcg_init,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
+    .get_cpu_state = avr_get_cpu_state,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
-- 
2.41.0


