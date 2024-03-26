Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C054DCD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp61L-0005RN-0p; Tue, 26 Mar 2024 08:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp61I-0005PS-Nm
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:35:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp61G-0000hK-Rk
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:35:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4148c6132b4so6864115e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711456507; x=1712061307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QfuoecfnqrMZjXVMkUyk45mCnFveAvGVHI65TWYIPA=;
 b=atwE7df5+t5ysT6qlNYPbt7uiCrvg1BcZ16XRW6rNXqxFgzQUpo3mXGixy/S8/e8P6
 4QpGVJquUjJ/jf3ERhxTdVwhZTo5QUG7ouML8fGjrdR2hXCQHTsRJ4JpUfNBtKHYsdud
 LohMxubbRc/TrNV3WBd6zDPmL2EvgNHkjWkRV0ZauaiYBMSFlMSQk+Chz1nDuJtnYqJw
 DmvKDB1C4/zEsb3TBg640Sbm/EdytEYsbm4Ht6iaFPD+/6iqzBJJ7prjWs/65NKrIBon
 VHM07VNtYxcbcTitiSgCtfeWHtMFcSNV1kcJZDV5+j/qobWjcOdZGe7mj58DZr+cVwCL
 70zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456507; x=1712061307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QfuoecfnqrMZjXVMkUyk45mCnFveAvGVHI65TWYIPA=;
 b=kuiZM7PWplMNb8WdzP0cASazwwd6KQbozPtFWCqxm02VYOxnM7OR7S0WDlVZ/eBtr2
 4biK+Sre3je+FqOcaMjrJMpkzV9BRQ3SnQ9FKuklhn3oUAC5CIqqNnkdvbEzkGFP0616
 +UvfJuwKPrpUHTLRYCBjcNcmFGQ7FE6pBDhipdbaVVyspdfHW87FnZShyffNwJHKuk25
 Swr61sjtTmfNaHBIF9Nof8y8mOppbtW7JneULXJcAm82a/dplQedDKNBmIY/Y16DBJtf
 tohAjLvwuLpjRlB7qkJxgMXQhG1QdKrqysbcaUPPJZGyLhBq8bP9o/c61s/CV5LJoAki
 p0GQ==
X-Gm-Message-State: AOJu0YxHhLZr2pwvR1KVG1j741VP2Dsl9yfGVrKAAZAB6EBfFgSNQTkq
 miYqKES4kS9RNF7PqR/7dXB3wLk4Q2V4HErklILpyQNHEGvDAQwX7HUq107gQNiBpo5ejXCJyDG
 b42Q=
X-Google-Smtp-Source: AGHT+IFK18wsRKqW/l9tBFEUG6+AjzKD9uBgDb6iNqYZhRGoscdCf9HBhiISCw6/W1LWAfj7oJiUfg==
X-Received: by 2002:a05:600c:3217:b0:414:6467:d8e9 with SMTP id
 r23-20020a05600c321700b004146467d8e9mr1250601wmp.17.1711456507429; 
 Tue, 26 Mar 2024 05:35:07 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 y19-20020a1c4b13000000b004148090cf85sm716317wma.0.2024.03.26.05.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 05:35:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 8/9] plugins: extract cpu_index generate
Date: Tue, 26 Mar 2024 16:34:25 +0400
Message-Id: <20240326123426.761473-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
References: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index d00a2b3fd67..eaa0160cab1 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -108,12 +108,17 @@ static void gen_disable_mem_helper(void)
                    offsetof(ArchCPU, env));
 }
 
+static TCGv_i32 gen_cpu_index(void)
+{
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    return cpu_index;
+}
+
 static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
 {
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    TCGv_i32 cpu_index = gen_cpu_index();
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
@@ -128,9 +133,7 @@ static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
     char *base_ptr = arr->data + entry.offset;
     size_t entry_size = g_array_get_element_size(arr);
 
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    TCGv_i32 cpu_index = gen_cpu_index();
     tcg_gen_muli_i32(cpu_index, cpu_index, entry_size);
     tcg_gen_ext_i32_ptr(ptr, cpu_index);
     tcg_temp_free_i32(cpu_index);
@@ -163,7 +166,6 @@ static TCGCond plugin_cond_to_tcgcond(enum qemu_plugin_cond cond)
 static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
 {
     TCGv_ptr ptr = gen_plugin_u64_ptr(cb->entry);
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGLabel *after_cb = gen_new_label();
 
@@ -172,15 +174,14 @@ static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
 
     tcg_gen_ld_i64(val, ptr, 0);
     tcg_gen_brcondi_i64(cond, val, cb->imm, after_cb);
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    TCGv_i32 cpu_index = gen_cpu_index();
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_temp_free_i32(cpu_index);
     gen_set_label(after_cb);
 
     tcg_temp_free_i64(val);
-    tcg_temp_free_i32(cpu_index);
     tcg_temp_free_ptr(ptr);
 }
 
@@ -210,10 +211,7 @@ static void gen_inline_store_u64_cb(struct qemu_plugin_inline_cb *cb)
 static void gen_mem_cb(struct qemu_plugin_regular_cb *cb,
                        qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    TCGv_i32 cpu_index = gen_cpu_index();
     tcg_gen_call4(cb->f.vcpu_mem, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_i32_temp(tcg_constant_i32(meminfo)),
-- 
2.39.2


