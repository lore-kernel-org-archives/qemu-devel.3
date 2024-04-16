Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31FEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwa5L-00081Q-6A; Tue, 16 Apr 2024 00:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5J-0007t8-5t
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5H-00079u-8g
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e6723c606dso14272295ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713240374; x=1713845174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAiLRxdfYErxgfOh0gQk21KRRPoDj9hGg+dmJqqgE+Q=;
 b=dmmm1wld2bdTpFmPVDYZi7adYMZi+fk1ubyDMpALGVZS8AuhmDoRjn6dX7hvrCoxdv
 QpLgzv2tNGr6oFUDljkM66mFhgy0J4E+PExZKzzuMVcg4PvIcW3Bgjnzn4JwipRMISqQ
 md9WeCWnlqWc4X50XYl6DJrV9hiinGq69eONhxqL5eJrnoXoVfjjl8jE+LsuISN2UBGu
 Cwp9fZbuaPmrdKJ8v7SfjqAvPRsuiZC7bxFvfvLrCNM/Z0zCoshl+UEsEdPWh3iyYB3r
 At62ILxfPWredZPsPad/PbEQ+PVyyP8n6uFlzvK3i9fiH1anu/HfHYGEIlqAtWWUqFQc
 yt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240374; x=1713845174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aAiLRxdfYErxgfOh0gQk21KRRPoDj9hGg+dmJqqgE+Q=;
 b=v6RdAS+4WWRSaSwFkuEqYgFauvzhXzEJcWsdPwGOLojIl64ZZ1bSmyKQMbatFx6Q53
 qT0KdDdZMANrSQF0/hDquqb7WOdnG9MfHPBDz1u8QE27EbJ92Rw3iZxr80WTkkJdbkBC
 X5vmKPfdDe4lGb4SbmNmLGQKMcAOBXRY6RcXpNbJrHyt3Gim7QL9ct3OVseZYh8luI2M
 4wfJtEiL/nV0t4gFmYI3kjzKzR0cYZZRb9mEa7jAKaNqducK+JmnhyyOEcySanu+2/gR
 O8ADow+mItif3D//rmRgcuk18hwseNiz3moujBY83/TTzSFqI1bjpTux+v7Jkt7ZRNSc
 GyIg==
X-Gm-Message-State: AOJu0YyceXigHApE/Kx8+bI0c7XGrnoyW0QxVyoKrut6RIy9FNwVLgDI
 2EmPxLf7v4OnlhVkDc/g5B0ngkHujFdBaJAQ8pHIaqvxBCdSxEXVBWJfl/wKA6kMXLEmLr+v4K+
 y
X-Google-Smtp-Source: AGHT+IEgvbOda4SoTtCo0RS7v5GODFA/XHhXV5nmZafOfpYSGwklwj+wYQHcjgsrMc066qgF/v11iw==
X-Received: by 2002:a17:902:ed4c:b0:1dd:e114:121c with SMTP id
 y12-20020a170902ed4c00b001dde114121cmr13250311plb.56.1713240373959; 
 Mon, 15 Apr 2024 21:06:13 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a170902f68100b001e3e244e5c0sm8694439plg.78.2024.04.15.21.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 21:06:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 3/7] accel/tcg: Return the TranslationBlock from
 cpu_unwind_state_data
Date: Mon, 15 Apr 2024 21:06:05 -0700
Message-Id: <20240416040609.1313605-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416040609.1313605-1-richard.henderson@linaro.org>
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Fix the i386 get_memio_eip function to use tb->cflags
instead of cs->tcg_cflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 9 +++++----
 accel/tcg/translate-all.c | 9 +++++----
 target/i386/helper.c      | 6 ++++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6346df17ce..f056132cab 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -176,12 +176,13 @@ void list_cpus(void);
  * @host_pc: the host pc within the translation
  * @data: output data
  *
- * Attempt to load the the unwind state for a host pc occurring in
- * translated code.  If @host_pc is not in translated code, the
- * function returns false; otherwise @data is loaded.
+ * Attempt to load the the unwind state for a host pc occurring in translated
+ * code.  If @host_pc is not in translated code, the function returns NULL;
+ * otherwise @data is loaded and the TranslationBlock is returned.
  * This is the same unwind info as given to restore_state_to_opc.
  */
-bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
+const TranslationBlock *cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc,
+                                              uint64_t *data);
 
 /**
  * cpu_restore_state:
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 83cc14fbde..c745bc5b6c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -243,15 +243,16 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
     return false;
 }
 
-bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
+const TranslationBlock *
+cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
 {
     if (in_code_gen_buffer((const void *)(host_pc - tcg_splitwx_diff))) {
         TranslationBlock *tb = tcg_tb_lookup(host_pc);
-        if (tb) {
-            return cpu_unwind_data_from_tb(tb, host_pc, data) >= 0;
+        if (tb && cpu_unwind_data_from_tb(tb, host_pc, data) >= 0) {
+            return tb;
         }
     }
-    return false;
+    return NULL;
 }
 
 void page_init(void)
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 23ccb23a5b..eaa691a851 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -517,13 +517,15 @@ static inline target_ulong get_memio_eip(CPUX86State *env)
 #ifdef CONFIG_TCG
     uint64_t data[TARGET_INSN_START_WORDS];
     CPUState *cs = env_cpu(env);
+    const TranslationBlock *tb;
 
-    if (!cpu_unwind_state_data(cs, cs->mem_io_pc, data)) {
+    tb = cpu_unwind_state_data(cs, cs->mem_io_pc, data);
+    if (!tb) {
         return env->eip;
     }
 
     /* Per x86_restore_state_to_opc. */
-    if (cs->tcg_cflags & CF_PCREL) {
+    if (tb->cflags & CF_PCREL) {
         return (env->eip & TARGET_PAGE_MASK) | data[0];
     } else {
         return data[0] - env->segs[R_CS].base;
-- 
2.34.1


