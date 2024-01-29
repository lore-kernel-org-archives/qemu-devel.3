Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E2AC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb68-0005hT-A9; Mon, 29 Jan 2024 18:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5w-0005Uo-Dl
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:22 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5u-00054B-RB
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:16 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29036dc3a63so1642227a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571073; x=1707175873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5n462vNeMjlBZwwraV55qst2NUkc1xnzZuaJY63KTM=;
 b=RkQ5cQuyy56crGo4k22EZvL1meEcWr52uSbq4/yI5URm1hu2uYo6RemwldGemnFzOb
 V7R9WrqgeEFKpVwNyUTKD/d06/bGob3H/4wmUEQyL/mnvZa06rPgAh/520uS1F2c8rWn
 Ll0D0ayrriAGP14lyD4u25FdJAdN2dsxaaptQvSsZO59gu1kb5KHt3UOjj/DDebYSwD8
 P1yYbO17wjmPD3aXjvNyVT3IcJU1lwbT6Mm2cx9TKvDR7mR/dLygvQ7563BUokk8DfUx
 tfXOzQ4kkSCmR/wURFKKO17UUHnTFjUJI/XT9rqz2qrGCv1Y7vrj3EWKbO4FlIVLUfhY
 o/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571073; x=1707175873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5n462vNeMjlBZwwraV55qst2NUkc1xnzZuaJY63KTM=;
 b=j6PiKUXFpssGErDf3rhEPbRpjwFxgq0N0M5kG1tVQ7JxiQ0cEBMxRUldfqmcmwIemF
 D37p4J5i2mhInRVF1lI2mywtBtqVDyoVgdhqLY8Zk+YX39tO+rqAfSSbiGtaEkO1G9Qv
 V3PhoxEHHDbXHIU8+ilnVSj95KgJYb8dqBQ/7JADYUkU+kxR+LP7DyitnlIq7KuN2VyD
 KIAkzA4ndZOz59Wt+/OLVng+561JlIKaMddwO0gliUj8OXBqcHyLMfO0mJNn3BruBqcG
 RxaTFjEj2C777KUZyhgNMN8pvH0r0bW4padN1mLUEDZT/1EM/jwPa0dKn90XcO/Hr/TK
 e9jw==
X-Gm-Message-State: AOJu0YzQM7vO1tibkOGo0jZdh8nFosIXKmQmj98bMiEqSFx9TjvOroBV
 l4JwnOQnbC9YdZiK+ARX5+2aYGt1R4+zQii7kz7YV5V/yZfn7rQ9ZCvSiebk9ZEi8FfQG5AWOj3
 Fy3w=
X-Google-Smtp-Source: AGHT+IELY0MFDotUzb0ZnwnULgJJCfBL4u6FM9YZk90q0fvV0ateP3RfFoaPG8qPvXkVKi8yOdj9iQ==
X-Received: by 2002:a17:90a:9d87:b0:290:969:13a2 with SMTP id
 k7-20020a17090a9d8700b00290096913a2mr4274473pjp.37.1706571073394; 
 Mon, 29 Jan 2024 15:31:13 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 11/33] target/loongarch: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:21 +1000
Message-Id: <20240129233043.34558-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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


