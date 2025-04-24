Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385B3C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kzZ-0000RY-BW; Wed, 23 Apr 2025 21:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kx0-0005ax-OG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:26 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwy-0005YT-LR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:26 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso411793a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456423; x=1746061223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCb0nI+2CCy6xbgQ0QUcGLa1ZUmAGxVEjmnQDdUz4pI=;
 b=Aqs/fsk4hGfooCkFjiB1ZrTQGnMzOOdl5Gjk6q/rbuEs88SxZczMQ7d40Pval/YMhN
 PriJ8ZKbG1XYRdhSEIIhgB2DGtu10voqs0NOJUFNSJJ09cG5gJ1/sWPTrfvRJwkxauQC
 3705OKd8ui/Iy804bIcJBDmEL2b0SCxLJSA/7IbWMZO2yjoAPzpsOAekrLDoHPavWjZg
 baAd+FgXxFUSs8MltsMwU3RkZAZWNCQ8M103x9bNGF7xcnMIXD+bOeVJb7EQTjJYNMRA
 kFZli1eRuXGtyYyEZYcwV3L3kcz8xHRE9TOq/kbTEgnlHTpqH0TUkq5440/HpB0akFyY
 9+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456423; x=1746061223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCb0nI+2CCy6xbgQ0QUcGLa1ZUmAGxVEjmnQDdUz4pI=;
 b=qW5ifMkodIMvkgZVWZk9rrqtrzkcBgrn2B8d2mfqGaJaqP0guR3Uqe129hSGKOY25x
 yzHlHOmph/Xs2AQvTN3d/itkTw3qZE8U6RmLpEA1mlwn69GXNTJKkBMQC+BBBNsncgxR
 yxrZwyBuaZNJHGjdtd9A0wZsy1ipKUNpdj5hQOvPniUC/FrbZl+eAd5LTFxQCivbVamj
 cmrAz0cvdoCJhGwmf+xblVxmxr/uEMknGI1auyUBPQfKJoegPUnjyLeqN3uuVyO/aEGc
 0E1Ig4ig7mtGn+epx2pb5leOk6+otNX9zKtGnSB5kF7lR7XnBlWKvaXqvdUKkBuzcNxT
 UcBg==
X-Gm-Message-State: AOJu0YyYAiveLml9bTcHWIGbf5/op4fEw4vagGzjxnpl/1CiSKarciZ0
 LPH4U5dLRODp+k1rZpvZoa4ZSrEMsLRZ9BG6aNv1TmixAGWsdZKLGjo+7B5Czq9GqEV3Ioth0wc
 s
X-Gm-Gg: ASbGncsHV+wFVfvjLbT2fstyoZmcEZYGfM9DMQylXMD3KNEbjZl30AlAw7Va0QlyL8/
 T6wvapOy2KbdPS9fYMpvka2QZes9WYN7dPY/M240RBURSOaODflQdU46BI25ZaZEZMeP53pwM3N
 7V/FGAPQQC29l247RWRhQKZ9bg28Ys8dq227dUtBVumt6D576CdbGqRHXUbhZmY2HGs9/OzB8yP
 f+wPELt8mAY/vbME435oc/W8b8XCygXhnQmbSnoWm4DrIaRqgNwgEf0stEFm7cuqaKfE8iFwM5b
 o/hzBfBJbkevliYR7bSWnb29YnAShJaYF9DYDcOkqywkau4IkL0QDram3Q1yoEH8bhMzBBC31U8
 =
X-Google-Smtp-Source: AGHT+IGPdGQX9JxcE7qeXL2O0yXhLq0MVwYKOZGyUlZKMLv3UEpwWxjoP3UjS+ZQzHcAfLXgVWj/wg==
X-Received: by 2002:a05:6a20:9f8d:b0:1ee:c598:7a87 with SMTP id
 adf61e73a8af0-20445fb9734mr592964637.14.1745456422765; 
 Wed, 23 Apr 2025 18:00:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 146/148] target/riscv: Remove AccelCPUClass::cpu_class_init need
Date: Wed, 23 Apr 2025 17:49:31 -0700
Message-ID: <20250424004934.598783-147-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Expose riscv_tcg_ops symbol, then directly set it as
CPUClass::tcg_ops in TYPE_RISCV_CPU's class_init(),
using CONFIG_TCG #ifdef'ry. No need for the
AccelCPUClass::cpu_class_init() handler anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250405161320.76854-2-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/tcg-cpu.h |  2 ++
 target/riscv/cpu.c         |  3 +++
 target/riscv/tcg/tcg-cpu.c | 16 +---------------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
index ce94253fe4..a23716a5ac 100644
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
index ad534cee51..2b830b3317 100644
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
index 88f7cdb887..44fdf6c4cf 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -140,7 +140,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
     env->excp_uw2 = data[2];
 }
 
-static const TCGCPUOps riscv_tcg_ops = {
+const TCGCPUOps riscv_tcg_ops = {
     .guest_default_memory_order = 0,
 
     .initialize = riscv_translate_init,
@@ -1527,24 +1527,10 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
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
2.43.0


