Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB32C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKhW-0007wb-9Q; Mon, 14 Jul 2025 11:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ubJNc-0004gM-Bn
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:38:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ubJNU-0002N1-NH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:38:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23636167b30so38167555ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752500273; x=1753105073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zlc0P8VCWmuofdzqL3bOeDpuJqP0QcfGjEi1Fn+DLbo=;
 b=WiuPhoXhUZM6AUJ21tvNC5ayNJN2VaQD5beu23DHRay4lRhqI7M8d9UONY0CVgLzVK
 qo0O2eXhnBVrpRvqdyht5WPQP4jLcnd8WfTkwjnQ8d5ETjMmJr8oGy/baP9IlM7sBHAc
 QZlSQleXI0/oHbMCCiIbkcS7AGhGvO+wTb1wpL+BUQTyjXXIQBgn2e4sAvbMeyG33ahy
 SGa1qb0vM2pqfrCPCQGL0W3Erk6UuCqLQGljybTso41WWFrpubr5fi2kQc3TKwmV0FhX
 0ugBcASJrJMvQAd21Tm4I/Bp6oHIGElMGeLW/Wn6wAboHIlYyK45GJE0Ocx7TcMzewKh
 ymYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752500273; x=1753105073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zlc0P8VCWmuofdzqL3bOeDpuJqP0QcfGjEi1Fn+DLbo=;
 b=XBtjmSWre62hrbIQQyJFjVijqXRHbwIVtzpmfjOcriw2yXybpCHz6yjopml/Gglz98
 zh2d3vBjv0GcGQeH9hzw8HdCD+uBWS5DvwJkSvW1jE00U9KzzKmVxcXxpfjMXfPd9ICf
 9DmSOhGcLxK3aPRH8Ve2xr42eEQBarNaq0zmrZv6TYHRf4utAMeMU0J8WbQvV72PeBXj
 1uUnuoREf0D6O7unvQ68uj25oiUKdkOci5kpRuwV99TsWO5MhrIihucBhvIyMZSVlDZv
 U4n80rXj9goQz+W1CR+LVIkw4sD124qXkFY0rnn/uL1P4fwFAdNdYYcZGAU74JIh6xks
 CmAw==
X-Gm-Message-State: AOJu0Yw/VeCAHzJNQIWrd5lMipTeCJHXECr++Dj4HppyA/QB9Z8Scblv
 znghFbIPctFkKxm9Gs3dLkTLW2BP6gtR9kQQ4pgoP82B8lzE8Mf523wTQ4vNQ+4LraZuiyW2WDK
 yX3wm
X-Gm-Gg: ASbGncs8phYPZSl7d3BBcP/B4mdk8VvZ6InEmeNvmXJsOprchBpIVvauYuTLtOU1YsB
 YCB1vcJsJ9zFHvy8DFpR58uhHmDnWGnOEQAxQOBcAALcq7B1Si8Nr3uwGwmIWqT0AhIHZw/O5Jl
 KTLjaC3bNiyLBYkICayWNOebHmixchI8HdQAqBHqysq7QQN67swpgfNArqMxPY5vdxD3z2hm4bT
 kO44WKC32PY3FgBQA4PDwlMhUw/vglkJ5HPwq+rxPbcbZNn7eKs2ZMDnf8gl3xDNXA5CUPVORC2
 lLbQENp+UPwq6pOyoSQxFODSdwOznB/qWrHOw4K2zD60QtUJTPyJdOltfGdjOhqXCiBAvS1jETH
 92WkAMl2cuH/wjiQk1g8KSaTdrnd4xbqy6Q==
X-Google-Smtp-Source: AGHT+IFjC5ilZU2AnzoM2lcWxZwG8Acxcl60+TH+ujeKwFLYuCiHmUaYOUXzFNMIS+MNiuIbyLe3Ng==
X-Received: by 2002:a17:903:13ce:b0:235:81c7:3c45 with SMTP id
 d9443c01a7336-23dee0de80cmr196832965ad.46.1752500272855; 
 Mon, 14 Jul 2025 06:37:52 -0700 (PDT)
Received: from grind ([177.170.118.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4285a22sm92883555ad.22.2025.07.14.06.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:37:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/riscv: do not call GETPC() in check_ret_from_m_mode()
Date: Mon, 14 Jul 2025 10:37:39 -0300
Message-ID: <20250714133739.1248296-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

GETPC() should always be called from the top level helper, e.g. the
first helper that is called by the translation code. We stopped doing
that in commit 3157a553ec, and then we introduced problems when
unwinding the exceptions being thrown by helper_mret(), as reported by
[1].

Call GETPC() at the top level helper and pass the value along.

[1] https://gitlab.com/qemu-project/qemu/-/issues/3020

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 3157a553ec ("target/riscv: Add Smrnmi mnret instruction")
Closes: https://gitlab.com/qemu-project/qemu/-/issues/3020
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/op_helper.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 15460bf84b..110292e84d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -355,21 +355,22 @@ target_ulong helper_sret(CPURISCVState *env)
 }
 
 static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
-                                  target_ulong prev_priv)
+                                  target_ulong prev_priv,
+                                  uintptr_t ra)
 {
     if (!(env->priv >= PRV_M)) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
 
     if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
                                     env->priv_ver,
                                     env->misa_ext) && (retpc & 0x3)) {
-        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, ra);
     }
 
     if (riscv_cpu_cfg(env)->pmp &&
         !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
-        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, ra);
     }
 }
 static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
@@ -394,8 +395,9 @@ target_ulong helper_mret(CPURISCVState *env)
     target_ulong retpc = env->mepc & get_xepc_mask(env);
     uint64_t mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
+    uintptr_t ra = GETPC();
 
-    check_ret_from_m_mode(env, retpc, prev_priv);
+    check_ret_from_m_mode(env, retpc, prev_priv, ra);
 
     target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
                              (prev_priv != PRV_M);
@@ -443,8 +445,9 @@ target_ulong helper_mnret(CPURISCVState *env)
     target_ulong retpc = env->mnepc;
     target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
     target_ulong prev_virt;
+    uintptr_t ra = GETPC();
 
-    check_ret_from_m_mode(env, retpc, prev_priv);
+    check_ret_from_m_mode(env, retpc, prev_priv, ra);
 
     prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV) &&
                 (prev_priv != PRV_M);
-- 
2.50.1


