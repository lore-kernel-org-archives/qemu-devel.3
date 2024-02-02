Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61AEC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSF-0001D4-Ji; Fri, 02 Feb 2024 00:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSD-0001CX-MZ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:09 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSC-0001hk-5r
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:09 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6dfefb490f9so730885b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853065; x=1707457865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAmZNL9zYMPpuAsM9Gmw83HdlClN4X7nwCS0CqUYsPQ=;
 b=JZPzlnof9jffflidWcVsmyiFpmOrDvm/aKSfoKMJCeM1U40HsDngqWGTe6oqndNNhK
 65jVsINj6jgm7PST6Q4Mw7eCVrf0MIpm3iMZQeM2kHGNlIpENAWYMT9R4xJbKdfHuZfR
 NWmNzYvHj209Ahxx5GFFpC6u4nCTQeG/1JYLNmvV8CshUF5b3866qdplLemKOaS+OMSD
 zU2jj0qGBxHp8PAJxK0SU9tse4VSUKIJbmXweKs8uFluWVtn9G68kn89BTNz6uU34zei
 xaSrcbS4mQ912RA4pA9+d0+H2E7jUidUP7fcN3P67uCR053DvMIGvhdPnbEcZQCNuF4T
 PpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853065; x=1707457865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAmZNL9zYMPpuAsM9Gmw83HdlClN4X7nwCS0CqUYsPQ=;
 b=euQe/EDYjEClvkh7Hkv1EA10cuDJNhGqnP22y8O51UGFM9hzTikXMj4fpy3i1LJe+j
 7pxijQKADsb18Ha5O3Yfq+eVKg3opTnOg/mHgaNxGnJQKKIjAzpwowaHvPmXb2MsdyMf
 mmqsfsBjJEaqVJF8Ky1M3cgL9OW+vZXomzVQs3OrJBO/CemHSsDd+hMP+J1G0tH+Hl2B
 iZWvk5hm62GuAWvP3BmsTyxtemYzpnlRKV1/lI2Z1tlVe7NFeRlSz7AnZ/Ru499ekqrN
 d+Aw/+zFyWb9EhQOWxqd0P1Stg73Oe1tEowA6XmUDSjTWh7YQy1ffGp8mqZoSzLn9tos
 Akog==
X-Gm-Message-State: AOJu0YyegxtTW8fe+X/JIRxE9LMWRp/qMnDB8uqhDLW4oXZ98WAWQg7J
 SK8xuY+CFMmYXgXdm5Chmpz/iRGYvVSYeWo/j6kX2xhzl75PcvYSKjhoeKipJNtG6vg1UXmv1vT
 LJOQ=
X-Google-Smtp-Source: AGHT+IElAzn6TmK6qK3yl/KaKEinfRTeQeD3KdsXD0JWJaay0AGqR9lxD7D0HyGo1l8n29wI6v8l2A==
X-Received: by 2002:aa7:810e:0:b0:6dd:a086:1e0f with SMTP id
 b14-20020aa7810e000000b006dda0861e0fmr1208361pfi.32.1706853065709; 
 Thu, 01 Feb 2024 21:51:05 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/57] target/loongarch: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:50 +1000
Message-Id: <20240202055036.684176-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/loongarch/cpu.h |  6 ++----
 target/loongarch/cpu.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 0fa5e0ca93..5dfcfeb3a4 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -408,15 +408,13 @@ struct LoongArchCPUClass {
 #define MMU_IDX_USER     MMU_PLV_USER
 #define MMU_IDX_DA       4
 
+int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch);
 static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return MMU_IDX_USER;
 #else
-    if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
-        return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    }
-    return MMU_IDX_DA;
+    return loongarch_cpu_mmu_index(env_cpu(env), ifetch);
 #endif
 }
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb8dde7def..cbecc63213 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -375,6 +375,16 @@ static bool loongarch_cpu_has_work(CPUState *cs)
 #endif
 }
 
+int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPULoongArchState *env = cpu_env(cs);
+
+    if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
+        return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
+    }
+    return MMU_IDX_DA;
+}
+
 static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -779,6 +789,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = loongarch_cpu_class_by_name;
     cc->has_work = loongarch_cpu_has_work;
+    cc->mmu_index = loongarch_cpu_mmu_index;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
-- 
2.34.1


