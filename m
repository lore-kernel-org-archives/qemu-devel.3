Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5F9C369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7l0a-0003fw-DD; Wed, 23 Apr 2025 21:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kx1-0005mo-Lu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:28 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwz-0005Yg-EI
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:27 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b03bc416962so274683a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456424; x=1746061224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUCugy16Yk60Mq47s28P0+0wiiVLsU6AqUaVBrtQ/5g=;
 b=qlDWOGE0J9vO2yKZbrFR6cvGlbwTSKXB5VWV17L5DbbAIGuZR072HVhH7zA0Ra+qjY
 yLkKSP0RqhxmhwI3/QKo9qFNCFQejH73OJ28AVtVEWpmRWzvHIKmn8WghmeX1L4lRkv1
 xy/HEA70IzURAF6KyxfwkVpPMPOM5X/DKD4603EtQBtveY+dXK+Ap4R0G5ztwi3nGDjO
 aMM5sZ9T7SEeL2TkVSiLE+oaEHRm2hH9sWTyaZ/1uCa68mAWXHpTMktv2ahKGX7MgOdf
 jtZOiSM5p8tlD0pc1OfJ4ZwbZHQ8iJKUJgJV7s7PvfDgh8ZCcNDT2tQ30t8m8a3HJ5Me
 9qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456424; x=1746061224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUCugy16Yk60Mq47s28P0+0wiiVLsU6AqUaVBrtQ/5g=;
 b=rJ7QgQauI1FJFvm2vYQsItyFFFv1W+oYLPGmeEF4i1cPyQdg3ec9n3SnSui/LWu52C
 cXsYIwu+D99fuwPfruqQX7x/+9+2jXIRGk1Oka6GWlTql2XNgeOs1V3m7w0S5Cjbz+d/
 weW5qvm97KZx/e5DrjbGaxcFRW/cu5tE6rqc4KmigcToRmCzEJxuEPWoHDELofZQUYkR
 uAnppTLs/PnupwJ1KRJru/TJcNL18lknrtyaTM/MQoUICnOtiMOsq4ikkzA09/E1DON5
 EppNI2fOOo2YPtWWmTpWhRTp0cC4Yy4GFANgd5aMpc5JflyrpBB68kY5tbcGhfejuhx8
 biNw==
X-Gm-Message-State: AOJu0Yx7drM5P33oNPy9A/R1N8LhTFnuwrE04A+zSNDiQFJzPqAiS3bv
 lgeuI+UyPe6xOrmDKsaKQX8pEBpgusiLn/ZRx5FI2aU7VZbLFe4eebFVfM1CEl19Xuph/t4/FCc
 p
X-Gm-Gg: ASbGncs/Fj7wIzr/8wpVNdjuJl+aJGi1wDnf5bTu6crZbsh+UToiOYTfA8r+Rn067jy
 +eKRGLy/356EI2ryN2KMuT8d8sL9Xhlu4FQ33J5L8Otlf2Mg8+MlR91zR352trS6TRtnCO1beMp
 P8wKVn7yQrnX0mbvZxZH6Dv2+mY9sfk/Qu9/uSO21051grbE7a7wtdzxgDL1OaZuWEM379je+Mu
 TzUcmAfUmN+e3hp949OeQVsaV7bQdTM+86SLiK/VDTGhoxMFgS00cHmOgq1eHSRYRgXj2aL3pTo
 O98oFbaTJ1TJC4xK7ERcZ5N96Qfpb+zn9F69YdI/O2cZdWi33eEF6TMjG+ldtbJ6bBZaaMWmiRc
 //rXN/ATKTg==
X-Google-Smtp-Source: AGHT+IEt+7EJDRc1Y58gWOb+pmtjhoX/jzHX8cmcs/JUqXjLynjSpF3Xf6RlNaPzkYrOttUseQ2hSA==
X-Received: by 2002:a17:902:ebc1:b0:224:6ee:ad with SMTP id
 d9443c01a7336-22db3db16ddmr10598365ad.44.1745456423627; 
 Wed, 23 Apr 2025 18:00:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 147/148] target/i386: Remove AccelCPUClass::cpu_class_init need
Date: Wed, 23 Apr 2025 17:49:32 -0700
Message-ID: <20250424004934.598783-148-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Expose x86_tcg_ops symbol, then directly set it as
CPUClass::tcg_ops in TYPE_X86_CPU's class_init(),
using CONFIG_TCG #ifdef'ry. No need for the
AccelCPUClass::cpu_class_init() handler anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250405161320.76854-3-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/tcg-cpu.h |  4 ++++
 target/i386/cpu.c         |  4 ++++
 target/i386/tcg/tcg-cpu.c | 14 +-------------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
index 7580f8afb4..85bcd61678 100644
--- a/target/i386/tcg/tcg-cpu.h
+++ b/target/i386/tcg/tcg-cpu.h
@@ -19,6 +19,8 @@
 #ifndef TCG_CPU_H
 #define TCG_CPU_H
 
+#include "cpu.h"
+
 #define XSAVE_FCW_FSW_OFFSET    0x000
 #define XSAVE_FTW_FOP_OFFSET    0x004
 #define XSAVE_CWD_RIP_OFFSET    0x008
@@ -76,6 +78,8 @@ QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, zmm_hi256_state) != XSAVE_ZMM_HI256_OFF
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, hi16_zmm_state) != XSAVE_HI16_ZMM_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, pkru_state) != XSAVE_PKRU_OFFSET);
 
+extern const TCGCPUOps x86_tcg_ops;
+
 bool tcg_cpu_realizefn(CPUState *cs, Error **errp);
 
 int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 57f62cc869..1f970aa4da 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -43,6 +43,7 @@
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
 #endif
+#include "tcg/tcg-cpu.h"
 
 #include "disas/capstone.h"
 #include "cpu-internal.h"
@@ -8915,6 +8916,9 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &i386_sysemu_ops;
 #endif /* !CONFIG_USER_ONLY */
+#ifdef CONFIG_TCG
+    cc->tcg_ops = &x86_tcg_ops;
+#endif /* CONFIG_TCG */
 
     cc->gdb_arch_name = x86_gdb_arch_name;
 #ifdef TARGET_X86_64
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index d941df0956..e13d0f6f86 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -124,7 +124,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 
 #include "accel/tcg/cpu-ops.h"
 
-static const TCGCPUOps x86_tcg_ops = {
+const TCGCPUOps x86_tcg_ops = {
     /*
      * The x86 has a strong memory model with some store-after-load re-ordering
      */
@@ -152,17 +152,6 @@ static const TCGCPUOps x86_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-static void x86_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
-{
-    /* for x86, all cpus use the same set of operations */
-    cc->tcg_ops = &x86_tcg_ops;
-}
-
-static void x86_tcg_cpu_class_init(CPUClass *cc)
-{
-    cc->init_accel_cpu = x86_tcg_cpu_init_ops;
-}
-
 static void x86_tcg_cpu_xsave_init(void)
 {
 #define XO(bit, field) \
@@ -211,7 +200,6 @@ static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
     acc->cpu_target_realize = tcg_cpu_realizefn;
 #endif /* CONFIG_USER_ONLY */
 
-    acc->cpu_class_init = x86_tcg_cpu_class_init;
     acc->cpu_instance_init = x86_tcg_cpu_instance_init;
 }
 static const TypeInfo x86_tcg_cpu_accel_type_info = {
-- 
2.43.0


