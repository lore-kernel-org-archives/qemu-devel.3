Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C05FC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kuU-0007ID-BU; Wed, 23 Apr 2025 20:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktQ-0005lL-Ku
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:48 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktO-00055C-9m
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so352478b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456200; x=1746061000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEXzmO/KCSQQZKkw02RCDXKV53yZWyTGZY0ovHpDmRg=;
 b=J3u1w79YpeokMsP10Lk23NtOiTG/QV6vJ1KgZGZ8ZglYY7YbpXYkZCgSfWj/AuZbaK
 hEC4njoBEc1exfIkR4buyGLZ0NijIgo8l/9mlS0c1iq4DpMcT34aQYOU33AupSlOLu1H
 SHZjj9Djn+Hfq16Roe1m+smtzxoZzlzPAr5FUfDjhxXVWAu5NmY3bQzridWKRlUAVpFv
 5OpO/8J41yBNIYwxqMG5AvmtqAywDiKGbLSkBLteC3o1b2jjH1zT4Uxo6eLUmV1lspQw
 YugDLgWuEExat3ghHPjwc4bvsimT2WxbZOl7t64iinizA7yFwK6BCk69pqQqsMRcM5mc
 1ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456200; x=1746061000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEXzmO/KCSQQZKkw02RCDXKV53yZWyTGZY0ovHpDmRg=;
 b=X2lP6X1swBgm3wtNt20gAHzE5LQumwbbzW8W1KMR2NfLWeh9WmYUCVHGzFhbFGCV+e
 s5ljcFfgvKoxP/y++oFDfHz6TGk8to2zzcUWqmQ+3IgheRW973Dz/JhCs8H/Mt9fUv0o
 d1UrNR8ZvESq8eUn5lFrCcGLJfFYchOzNl3cxxVy/cRNfc4IHwo1q9GHfMMHc/ow90wu
 Z2HMFKGWuLp8T7cRCGH4XLJ0vvM2v5HaFNF2Y4DDV1kjCYCR5JS2jK4PxDiq1yJ3pY7T
 Dit9CenkKA7ifBuIu+M++FD4JI/tli+zrhc0hBMO2uD6JyUYrJhkZcqgXCbhcj+e7yT/
 mmYQ==
X-Gm-Message-State: AOJu0YxklER5xf3xSMrz4DaNCacM/38mbfVh4E5wbnAZCO3Hn84vY4cd
 89UU+7esjEvjeifsdYzRwmOu/wis7tojGgWUeO1yBCx1+45ji94M1zNMqfoROo4euyRToNGojRu
 c
X-Gm-Gg: ASbGncuIiOzZLgwriyDfw/e+aaihGDtseokfRmwzd3GiFvDDLwJuvVL6aCsK/3VepHT
 Gg5No2ojHUf4qw9lDRLOSbzg8DN1BX0ZYbZyiCt/bOBTDWQI2vo36h9PCQdped2i9KDZzLL/ovS
 8gZXQw4bnf6UT8h6VfHqF8wNByPxVIC8ALixovWXay5Cv6K9PzkdOz717hJJYe1bVqvlg5FCR/J
 /oTENLsFZrhxxiOOAA3V/8rSjwvM7hbj+b5pom+r3aXjvWQ7OFW0O2eO0G+I2wqV1HtQvyBRJl3
 i5hku/QQ+T61R4GGoGqSgfd/e2nxF+e0BMpsdxTUFWDvv+tP46cLL+h5gGFfwMs/cZcg64sMPN7
 +i3zT3u6cpA==
X-Google-Smtp-Source: AGHT+IE/s6+WrCNZpU4ABQmKHMHx5Q/Uen49bpAAq8EWUHwQlFiELA8JJ8nb/9IHXbDMo1cdHFqkqA==
X-Received: by 2002:a05:6a00:448a:b0:736:ab49:d56 with SMTP id
 d2e1a72fcca58-73e244bab2amr1088797b3a.1.1745456200475; 
 Wed, 23 Apr 2025 17:56:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 089/148] target/s390x: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:34 -0700
Message-ID: <20250424004934.598783-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
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

Convert CPUClass::mmu_index() to TCGCPUOps::mmu_index(),
restricting s390x_cpu_mmu_index() to TCG #ifdef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-19-philmd@linaro.org>
---
 target/s390x/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 1f75629ddc..d15b1943e0 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -126,11 +126,6 @@ static vaddr s390_cpu_get_pc(CPUState *cs)
     return cpu->env.psw.addr;
 }
 
-static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return s390x_env_mmu_index(cpu_env(cs), ifetch);
-}
-
 static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
 {
     S390CPU *s390_cpu = S390_CPU(cpu);
@@ -308,6 +303,11 @@ static const Property s390x_cpu_properties[] = {
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 
+static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return s390x_env_mmu_index(cpu_env(cs), ifetch);
+}
+
 void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -348,6 +348,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
     .restore_state_to_opc = s390x_restore_state_to_opc,
+    .mmu_index = s390x_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = s390_cpu_record_sigsegv,
@@ -378,7 +379,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
-    cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
     cc->set_pc = s390_cpu_set_pc;
-- 
2.43.0


