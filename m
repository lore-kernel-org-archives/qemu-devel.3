Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2B9C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KzT-0000BT-3s; Fri, 25 Apr 2025 11:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzP-00008j-DL
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:19 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzM-0003Xc-3c
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso1445971f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594954; x=1746199754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N+NeZfMB8SbiSdHd89pEWWZOxvwrwKsx++jezVzDGy8=;
 b=qNrbp2oPtxk1F11NVA5ahhsSGOuVtQmG42rcfvfzAuSlzo8Iv9GZgaC2oW3BGxb3vQ
 pmz5yPIWoGbQC83VxVYpPGhAp5r8GhEwhA7zRA5yFjJbsEQn6AgmKvLazBTjv6SWlPfC
 ycnJxLPPeOI8DIfg9RYSqZgq4tn9+yCn5jxh4XJA/i2bge2EJhoTJNWv6sv2GWAmog49
 c7QUbF5lz7LiY0piPvjv5kLND9pY4zbz4FphmczRed/8xWP+gcfvGV9vuUWTdoltDx+r
 uNterG7JskgW/ypC/Kgi+5W0IYJJbFgktdqkgLTJwKtV4CeNpeX+qa4025nU8BBn1GyO
 LarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594954; x=1746199754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+NeZfMB8SbiSdHd89pEWWZOxvwrwKsx++jezVzDGy8=;
 b=waHuCW0YPYi1Yn5YmCodQmhc1/zJJZihipoXQrhQunkQUMC1aGcSlQuxVaFmHwqnXL
 SjlUzCBIXsHMOeI9i1J2bwbI9sOZXAhod0UUc8jzHsfsAasxOazd67WSjumxT0bBjgyN
 JNrc+hSJcnqMEEX3+pAZGicTqfavsvv70gxA+nW9CzJQRqWFyBiSQ/ZZnpGtoZFAAO4b
 wuG8XcBKV+iM+ssIJzowvJ+Wy42kTshijp1IVkIa2idF5vx7v2IT8lIBPf3FYzs4+9Fw
 JFKMtv4mEwfhXbTOKffd8HdJDrs6GDv9vJhEmBSGedk1NzLeYlunenrtGYjlTiqL9tC3
 T8Qw==
X-Gm-Message-State: AOJu0Yynpwm1SNU3vPgMNK3fk8jzmm689bg8IXcCoSra5IBaOySrQ2aN
 CoIiZqn43UmAR8gSUY+5TqQtaYiZ/jPC7AvJ/PwzoxyMKB1e4c8lgCRUvET2qjTTrOQyeZPO3yI
 k
X-Gm-Gg: ASbGncu/Kk9kaF69bis9HZoBQpk10Txl5UvPLTgwcXNVlKQhwbWLtVOS0O+s7RAQ6cE
 78byrArFd/mz2f/JibdtPc6UTNprUvYA1HSAyZAnl/jnRD+RVqajX5TkCzyI/r89VbEL4XHSIMO
 2N3CmKLp10iulg0EXZNuBdsUIXlCJgb6BKn6evU3/DqaYh5isYgIPveF34uR88EcvGS8qaAbyY/
 34jLSl2o4pzdgjN/HxeN4UxJvzLM+MqEZKxcv/th+B6lVth1DCretokKLT4aPzFFy2Tq+ZlIr1k
 Xzf0JicgMLmQb4ey+8BmJiRrewMkfTKS1zMDeYtEdy0dyRrIOETeSZZbZIr35t1J1bvKLrzI1Vx
 BS3Q5+fS8s7hmhos=
X-Google-Smtp-Source: AGHT+IGPgXQHfJ2G2bPN/5L1hr8D8iSg/itASteSLMGsF+PsebJiHIaHhpaQEY1KjxaRedU+8h4J/Q==
X-Received: by 2002:a05:6000:2485:b0:39e:e588:672a with SMTP id
 ffacd0b85a97d-3a074e0f0c0mr2263448f8f.7.1745594954216; 
 Fri, 25 Apr 2025 08:29:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ccb8e1sm2705366f8f.59.2025.04.25.08.29.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/58] target/ppc: Register CPUClass:list_cpus
Date: Fri, 25 Apr 2025 17:27:50 +0200
Message-ID: <20250425152843.69638-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Register ppc_cpu_list() as CPUClass:list_cpus callback.
Reduce its scope and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250324185837.46506-4-philmd@linaro.org>
---
 target/ppc/cpu.h      | 4 ----
 target/ppc/cpu_init.c | 3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3c02f7f7d45..f4cc823c5c2 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1610,8 +1610,6 @@ void ppc_store_dawrx1(CPUPPCState *env, uint32_t value);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr(CPUPPCState *env, target_ulong value);
 
-void ppc_cpu_list(void);
-
 /* Time-base and decrementer management */
 uint64_t cpu_ppc_load_tbl(CPUPPCState *env);
 uint32_t cpu_ppc_load_tbu(CPUPPCState *env);
@@ -1673,8 +1671,6 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
 int ppc_dcr_read(ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
 int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
-#define cpu_list ppc_cpu_list
-
 /* MMU modes definitions */
 #define MMU_USER_IDX 0
 static inline int ppc_env_mmu_index(CPUPPCState *env, bool ifetch)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index fde7d71fc68..077991ed535 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7177,7 +7177,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     g_free(name);
 }
 
-void ppc_cpu_list(void)
+static void ppc_cpu_list(void)
 {
     GSList *list;
 
@@ -7521,6 +7521,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
+    cc->list_cpus = ppc_cpu_list;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
     cc->get_pc = ppc_cpu_get_pc;
-- 
2.47.1


