Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA14C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JT1-00061p-Vr; Tue, 22 Apr 2025 15:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSP-0004Ks-31
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:02 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSM-0007Np-Mc
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so23725265ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350737; x=1745955537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCb0nI+2CCy6xbgQ0QUcGLa1ZUmAGxVEjmnQDdUz4pI=;
 b=t1jd2P++avcm45conNuRd0V9gBEOm2yuhTiMJpRNl2J/TLGBZwdBpIlkYOhYxbDVLD
 6zVHhbXsaQN4zJLTn88B6keg5xxtqKB7vGbzbR2VNHdD3H3JJC9V8D7GQ7DTrm/mEYMV
 hpmaEyLdN7kSySzxYxRcLi4vuPM20+tGXGSkxI5OBa3dVJDt6uHBqJol8TFUFLuWZBBG
 yqLBhqt3jOi5BC3PVc+ptOwHa2T1UqIK3ICcdEq3OMvNFMBlJP5i734wKobA4WQPVT/J
 5F9NRyW8gMhd80qv68RJEm+qK3Zv4VxefrvFAJKEqiFX6f5a+4m/XmIVWM6ota+wiY/k
 9/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350737; x=1745955537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCb0nI+2CCy6xbgQ0QUcGLa1ZUmAGxVEjmnQDdUz4pI=;
 b=JVR3G+Hgum23qoCaS6hpDSESne6efxup6+xCbfmEC6qtW0nGSFZRM8/kZmmQ4Jz3Tl
 g7007BgURwzHgR54UFJKwoEOMlwMUyOc58Fu5Y4Awb8eWfxY52TMpzfw5Tg5imWgw52A
 aZS5Oul5ehOzcpUF25d+vi2JDVsjFEemdacccqlr0QULGk0uf7qiE/02DKNiL79OyIw3
 dXRR7XVRLy00JX2VOwN6kTvxhc2XMCSoIEhurNe+/diK8KlxdiGn6ew0LaWZH4UZedg4
 iJz9XpC/UFOXfQZAOinGz3QdP4rrYCzlcLOuZppQ6S2VxhZm37lLKzYT+85OmCvCopfe
 f6SQ==
X-Gm-Message-State: AOJu0YwSB7l2BsxrIag6ViKKSxJK82FbSpj7Z/8nYEMSWVsOEVy5i9RX
 FxVxisnZUwiYBkR7pc7i8JOn+QefcUFPQnxBvk8LMmoJRIHAw+H/LHohSumGq0LGr1KpQGgfDk/
 B
X-Gm-Gg: ASbGncsmgJjKMy4FvbE5hQeQ93lqP4eNodYXNRMZGpTt6ZasUjT9NI4VkqcfJY2IgpT
 Q+6O69aCqzsliy5Z3p/dhXYh2H0IQFRDyGDk/Mqv3nsup5fdeTCESyw/5v0a1Gpgp7MnEjJepDU
 XW0jrUb7U4VjCSVbeT8SRRbYc+ot4se+ITmXF0vLh8OHi2UhpbGpNOh6NcMXG3tQZ89D+bJ/EfV
 mM+3vwwOifIzbgsyIIzBFpyHX7U5MlyiASgO/0T+ReOl5Xu2ZrYsGp6adSSE7WN+gPrFOMrTT/M
 Zkg10luffN8/s5X0vyESdG2Hulv2oCVqN1ihDJ3askmgZNlxuROsX/ir48yqjCBvCSQ33Jo3BjA
 =
X-Google-Smtp-Source: AGHT+IEJoOituXy0/PTNSMRaXHdmEJwDzZVsh54EDpKftpM6BdXek50eQDExtZ/2P1RfKmAS/wAE2w==
X-Received: by 2002:a17:902:cec8:b0:215:a179:14ca with SMTP id
 d9443c01a7336-22c5357a118mr233458515ad.2.1745350736728; 
 Tue, 22 Apr 2025 12:38:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 145/147] target/riscv: Remove AccelCPUClass::cpu_class_init
 need
Date: Tue, 22 Apr 2025 12:28:14 -0700
Message-ID: <20250422192819.302784-146-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


