Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DA1C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSD-0001CW-O3; Fri, 02 Feb 2024 00:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSC-0001CO-DN
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:08 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmS9-0001gy-2V
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:06 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ddc5faeb7fso1441422b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853063; x=1707457863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhgRzqqv/s/Iq4v6+M5jYHJ7Q0ZBinPRbaKXKXc9JsM=;
 b=Vpv9DpClyoAwEQVHT9X6/F1Pfd7RzfLgWqsnrGs2bIRbbXIcOtVqPwYA19T5h1TxS9
 yaGMU6LJNKbzipykA5+rofisntFUsuILVpvPYUtKAPCdnTxsmMIgIqQnew8z0VnZUI+H
 xpRFoSCAaDm1MMSdzCuBhrrw0cnuerIV3pqFjESoCqIOyd9iiP17/DD4JfmcLzWU6t+F
 M9vywLtrxnbko6sPf1lW+bxwQiw24mvEDY+4WjLoq3X7zYQJjI1CLxJ0jOIbR0zIcQVn
 OEJJM6QpU6jsT+eTUiqLsAi71j25S59y6riYOh6BRAosI6XZ7ese5gxUDk5qwNx5q2up
 ImHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853063; x=1707457863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhgRzqqv/s/Iq4v6+M5jYHJ7Q0ZBinPRbaKXKXc9JsM=;
 b=ZDeL1fPvD1uxElFTclek7N0VLt8G2HE/ikacfTE/3tExKWTQB4l8igoN0YEtkKNXnz
 ZThMX6P4Ic7DPkKzdI5mnZgqFOtadkj2nUt1RIsDyVWtZTWdzqPRcRn5knPOpya9P8Ye
 FXPW9vwf/ZMzCHrXagC18Dg+y9HtOcT93oSY+xmzcTBt2WlUesg9aXwE7tZNmdPxORwz
 pPF1AYiYn6cBYu+JvW9ViCRnTF8RwxGQlWZMpb5qk0XOvwO2nKemQfyV5lk2v/cGNaTP
 nN9yDFIBtoZ7GVZa521kAGKBp0fn2NEpC/a5BpJg79ZUB5EZkzVRMPuDlad1Qbjop/Mb
 pefg==
X-Gm-Message-State: AOJu0YwdTcVWnawxm4B1Pg+0DkjZ3ENJXSpgKdERyqT0VOPd3+G0PY1r
 1p05RX6/t5+tx3gwGIfco/RWe1inMcPDm6FLiuEpcz9o7IzwkqVnwuFvTVxpv0KHN7eyFeIKh3e
 RaoU=
X-Google-Smtp-Source: AGHT+IHlLedb+90ytSvxU8vznETy98ZnPOnnihBo9YDTnH9W7A1xbKOCM9ePUcSvbutZDcLcopUKFg==
X-Received: by 2002:aa7:86d2:0:b0:6de:3319:ac22 with SMTP id
 h18-20020aa786d2000000b006de3319ac22mr7553191pfo.2.1706853063710; 
 Thu, 01 Feb 2024 21:51:03 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/57] target/i386: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:49 +1000
Message-Id: <20240202055036.684176-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 13 ++++++-------
 target/i386/cpu.c | 10 ++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7f0786e8b9..62bdb02378 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2296,13 +2296,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define MMU_NESTED_IDX  3
 #define MMU_PHYS_IDX    4
 
-static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
-{
-    return (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER_IDX :
-        (!(env->hflags & HF_SMAP_MASK) || (env->eflags & AC_MASK))
-        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
-}
-
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
     return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
@@ -2322,6 +2315,12 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 #include "hw/i386/apic.h"
 #endif
 
+int x86_cpu_mmu_index(CPUState *cs, bool ifetch);
+static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
+{
+    return x86_cpu_mmu_index(env_cpu(env), ifetch);
+}
+
 static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 03822d9ba8..280bcb7d00 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7720,6 +7720,15 @@ static bool x86_cpu_has_work(CPUState *cs)
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
 
+int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUX86State *env = cpu_env(cs);
+
+    return (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER_IDX :
+        (!(env->hflags & HF_SMAP_MASK) || (env->eflags & AC_MASK))
+        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
+}
+
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -7954,6 +7963,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->has_work = x86_cpu_has_work;
+    cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
     cc->get_pc = x86_cpu_get_pc;
-- 
2.34.1


