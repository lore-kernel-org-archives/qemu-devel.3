Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FF6C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u169D-0000Ut-U1; Sat, 05 Apr 2025 12:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169C-0000US-AK
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169A-0005Cb-PO
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso19556535e9.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869607; x=1744474407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANZQVjU67KVuQJeoPfw/89aw1dlWs89ZP1DiG1XztSM=;
 b=lIxNC42pArGQ15dV3rf4zjzf9VftHLgSKwhsfJA1Ow0KZKLqHdtfmJpkfN5RbFEJ/w
 pntrEe8HI5VwL8G29PMkXjZkJC21iXUoANPJMEKgsQ18DoyEYNSlDNAeT2BYUia76t5E
 /jH9kQ6A7DTXAkKDTcevYyReWwANovJAELH0vKGyK+AV4/IgF+EsWJ3vfXadHcTuvDP+
 m3rXPGl1ba/uBEoNXbCWsuYyMgUELsmxwa4/1RXOd9mYXYvt8ef9/Dwxmc1LycR5kUw8
 Dpuq/LIE/BmNKzh/7AEm03wq9MsPS1c0EEcwsMDSS2QYVPOKmlfOgUEH6eDcxLOus16d
 YPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869607; x=1744474407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANZQVjU67KVuQJeoPfw/89aw1dlWs89ZP1DiG1XztSM=;
 b=tZEcql6jTqugvyGlScjowVLh3pYts4d/NtnB/G5r+KMWkmCeKxjNLvRvX9IOowV/Qs
 Yo2Ac1H1t3FQjbYGSnYUQPi0jfisqHKmXum5gQ2u+j3hJNatVFzW+NmVgFKkZKLQ6b2e
 vZ5860JuZNUR/oBlQUpMReeo65XTgA/rsDHkG6EMRxTj7Xz+LDjutp8uLM84a5hY1zSd
 v7K46uiqAVxbDJdJU74oFY2WPOQGgySbXSjXTjdZXdg/CPrsSpMJw9bzRsx0WQHIx+7J
 bKLgg5v+Ngc11dT5o20lovoJ96XGvj3gSWzK+3BzSWzAtyXmvoCsqv+FfcQ/+PAW1m3F
 YBEA==
X-Gm-Message-State: AOJu0YwqA+mftijFkcPGOP9pg05ml9LnSSYPppjnfTln3NJ7ncknNkrS
 aTQohPuDXiOYIiO6T1L9lXi187VDIvHFJFkdyHarANtGNsFBealTAoUQ8StHU6pZVLh3NP+wsrb
 K
X-Gm-Gg: ASbGnct/qtgq6+/lLk9hf0AWQ4AVc66RSQ17mI/TpTF2AUrELAOZ5s7kTUpq7gWphYp
 iMpI2+hor7OShOrkwqTAsc+5R6SIrA+UwNfhMz9WzUacjGa+LG3qSHdHh822y/GQb5R4zMuWaIY
 EErwt9Uaq9dgm9a+IJHeDjnhRrqZnf4+Ez9BStSMS9FeqRJuZO7iTn2pqBqTnruf5CvzuiIdLqW
 a9NbxDDnUnRgByWdHafFvcDnWh3PYwPlE69RaMK4YdnyPZ9kk8l6oBHxeUe6xLIdkNjUnbPNpZD
 Y6sxek2c69qi/pK8pk2FYD3f5pv2VaP08TTT4T6SSVn/pIJbMM9eDreWg4b1c8EheGHcXtn4F2d
 A6i+C5999PTXJCDEUpuUqBWiZ
X-Google-Smtp-Source: AGHT+IH/PdqEfYYIj7CgeMsupEBgL87K6yrRLVU6Rw4edNe4M2zhybiNogJ24e+3qXW11z7wwh+xRA==
X-Received: by 2002:a5d:59ae:0:b0:39c:27cc:7ba3 with SMTP id
 ffacd0b85a97d-39cb35aa8ecmr6867752f8f.33.1743869606962; 
 Sat, 05 Apr 2025 09:13:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec366a699sm76334805e9.38.2025.04.05.09.13.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:13:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 01/16] target/riscv: Remove
 AccelCPUClass::cpu_class_init need
Date: Sat,  5 Apr 2025 18:13:05 +0200
Message-ID: <20250405161320.76854-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Expose riscv_tcg_ops symbol, then directly set it as
CPUClass::tcg_ops in TYPE_RISCV_CPU's class_init(),
using CONFIG_TCG #ifdef'ry. No need for the
AccelCPUClass::cpu_class_init() handler anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/tcg/tcg-cpu.h |  2 ++
 target/riscv/cpu.c         |  3 +++
 target/riscv/tcg/tcg-cpu.c | 16 +---------------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
index ce94253fe42..a23716a5acf 100644
--- a/target/riscv/tcg/tcg-cpu.h
+++ b/target/riscv/tcg/tcg-cpu.h
@@ -26,6 +26,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);
 
+extern const TCGCPUOps riscv_tcg_ops;
+
 struct DisasContext;
 struct RISCVCPUConfig;
 typedef struct RISCVDecoder {
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ad534cee51f..2b830b33178 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3054,6 +3054,9 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
     cc->get_arch_id = riscv_get_arch_id;
 #endif
     cc->gdb_arch_name = riscv_gdb_arch_name;
+#ifdef CONFIG_TCG
+    cc->tcg_ops = &riscv_tcg_ops;
+#endif /* CONFIG_TCG */
 
     device_class_set_props(dc, riscv_cpu_properties);
 }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5d0429b4d00..6a87367f239 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -139,7 +139,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
     env->excp_uw2 = data[2];
 }
 
-static const TCGCPUOps riscv_tcg_ops = {
+const TCGCPUOps riscv_tcg_ops = {
     .initialize = riscv_translate_init,
     .translate_code = riscv_translate_code,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
@@ -1524,24 +1524,10 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
     }
 }
 
-static void riscv_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
-{
-    /*
-     * All cpus use the same set of operations.
-     */
-    cc->tcg_ops = &riscv_tcg_ops;
-}
-
-static void riscv_tcg_cpu_class_init(CPUClass *cc)
-{
-    cc->init_accel_cpu = riscv_tcg_cpu_init_ops;
-}
-
 static void riscv_tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_class_init = riscv_tcg_cpu_class_init;
     acc->cpu_instance_init = riscv_tcg_cpu_instance_init;
     acc->cpu_target_realize = riscv_tcg_cpu_realize;
 }
-- 
2.47.1


