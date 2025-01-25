Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62CCC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiiN-0006Sr-VB; Sat, 25 Jan 2025 11:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigZ-0004xR-2h
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigW-0000ly-Nn
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:02 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so34746425e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821219; x=1738426019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McaXcSpNynHCA9tSKGj/1Op/r9CMceoElpHx5WUOIrU=;
 b=mmfL5Qy5chrnB+SXRHGG3XajjavekGTIS/CYQ4xqRIMSwtIDDzVkVC1GvsxXt2ijrJ
 sI8h1iiPa3F/KNUXvu9a7wdrT+sehQEGwNP7jZ2UZPwmuQJPqLbrPvST+4U3zRwx9N0M
 CDeFIZqZ6yzOXHBhMl7FK1be10sL3ymuakxC5g6om3H5KZWc/jphYb24xXSWsJ0QY/lP
 mLBBvlFWaRAFelinwsAUCGspptEYDnpgXMY+GVQ/PZV8a657Xr83wRwoVoa5g0u9q0kh
 zgu5NKZUlR1GSGJqaY0FLAmnzVZRiE4klzDXg6rYgNtrrghma0w8TPQBsmjDHR7s7wVO
 gHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821219; x=1738426019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McaXcSpNynHCA9tSKGj/1Op/r9CMceoElpHx5WUOIrU=;
 b=ZRre7hCw33Nw0l9SwoNkpxyh7Z/AYqslmibgXUCPagAr4brcCOhEYWRQwTDfpixcs9
 ovu/6T1+ynUEuj18xO9Ix4FKxLXMzzZkOwIcu0YqUeykbYWaR+L0e1S/dL9891ypmBdy
 B41Q5JANNxH5ZNY8/arBRt+oKS22Ey3G0we/CRvbA+xiUQDcXv/JVsZ6b2AneBoP1BmM
 /eRAyi/ITifUYLlEkcr37szbBN3JCuBgP2GycxbYOAz3ivV5y4AM0FCzJoYLImPutnNn
 uFU72EVcmLrOtLP3DIljk0q2oZXK95bQv4qD9M3AxTO3ql6aeUZ03nUnoNQq6zkPY2Ku
 TuoQ==
X-Gm-Message-State: AOJu0YxilQiiosW/lfz5hgh91nucU2fmE2XXLMPr5+7qleqY8Ol80Dpa
 sZSr5aUexbVTm9as9wSPEoEP2gTphfocEgPTYUDecKTENxdvVddIPEaoSaguKyEevDz4UUnnnQM
 rs8Y=
X-Gm-Gg: ASbGnctAvTmdKrGNKTMKAchhlfpS65Bx5Vi/2MjMKnT437l+QYVw+2brGTec9kKOGka
 TxjBP5Nleu4Cy0bqiHyp6wmLCO0gsQo8ATBaWIzJoNszk0Rtva/Nv5KEq8o9RFhrpc8lEzXcuO8
 wfVaLkSzXwhc55Mf2HmsgOuadB2T5GOwrLwvza6rFWf9Wi0JnYBTXKNz8pOOfCG54pq++HYyjuC
 xvuhXE8A10yW6s2R+mhUDgsDrW9b4z9ASKZMeo9NV2RhzDzMI0Z7bUTxOr5BSSppH66aZa3/Q7c
 xXK6r36ipq7wDCSIeyPbSe428ZTBj6J/MqiZ9JVVB2DaUtnCPVICuHskIi4z
X-Google-Smtp-Source: AGHT+IHCnMPr6Kj/99W06ZXWMSTu/6Y9nxq4GADDNX5XU+CEP945s8WXjn5tiQnYQ+Q+X+n2j9eH6A==
X-Received: by 2002:a05:600c:46cb:b0:436:1b96:7072 with SMTP id
 5b1f17b1804b1-438913bebe7mr327719045e9.5.1737821218155; 
 Sat, 25 Jan 2025 08:06:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd5082d3sm64038195e9.22.2025.01.25.08.06.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/24] target/mips: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:41 +0100
Message-ID: <20250125160552.20546-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Move has_work() from CPUClass to SysemuCPUOps and
cpu_mips_hw_interrupts_enabled() to system.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/internal.h | 4 ++--
 target/mips/cpu.c      | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 91c786cff8a..28eb28936ba 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -162,8 +162,6 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
 
 extern const VMStateDescription vmstate_mips_cpu;
 
-#endif /* !CONFIG_USER_ONLY */
-
 static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
 {
     return (env->CP0_Status & (1 << CP0St_IE)) &&
@@ -206,6 +204,8 @@ static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
     return r;
 }
 
+#endif /* !CONFIG_USER_ONLY */
+
 void msa_reset(CPUMIPSState *env);
 
 /* cp0_timer.c */
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 47cd7cfdcef..0b3ac4e60a3 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -132,6 +132,7 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
     return cpu->env.active_tc.PC;
 }
 
+#if !defined(CONFIG_USER_ONLY)
 static bool mips_cpu_has_work(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
@@ -177,6 +178,7 @@ static bool mips_cpu_has_work(CPUState *cs)
     }
     return has_work;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 {
@@ -534,6 +536,7 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps mips_sysemu_ops = {
+    .has_work = mips_cpu_has_work,
     .get_phys_page_debug = mips_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_mips_cpu,
 };
@@ -577,7 +580,6 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->has_work = mips_cpu_has_work;
     cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
-- 
2.47.1


