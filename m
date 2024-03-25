Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87820C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojfH-0000jN-QP; Mon, 25 Mar 2024 08:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojfA-0000OL-HF
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:53 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojeq-0006gg-Lz
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:52 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-515a86daf09so1713448e87.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370550; x=1711975350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVTG3jxPFJmDWs7WR0b95XLJPKuzwHMgZ07dA9hMpsY=;
 b=a2K5baTf/WfKnDhKFgaK70WEcKnXwEgj4Avj5NXOifiE7kiE74T1PiV8d+6Mbinh5Y
 Ksu3k3KLiQIXNMdatVtDkauZEbRHRyXMq7A4lpjoB0LwUV+Qo+/YVdbPZdqKaDbW4RpB
 bOzoB4/93NJuyNZKzfJMUj6Ii/h4UANp98FkZCC4SBadlVjQYFhrgVlG23OJqSfzu2sB
 3w7qSR2xZxIdRsXfK02bh00Rbfi4AOf9XHgD9siG/srVTwxK03bOuqEbDXwtlaywf5UR
 +C7Fg11FeL5KyZ7CD2Wl2rF+3E09FFJFWcQ5qdPjC2a5/xxTNdHQ7LyQ2gEIubnkzmG7
 31qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370550; x=1711975350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVTG3jxPFJmDWs7WR0b95XLJPKuzwHMgZ07dA9hMpsY=;
 b=eST7PnEsOJ+A0axb+9sx3UpK0+6/SJUCbkdtCgKBhRcSXDjPzYIjpGwPrzYSa4fNaA
 RNs+CbSIEGD6qlSdPiUk/cmoPtHnDMwVXTqi/kUmeiH3V9Cl72Urqoa/ja45iPqlPIEg
 fsOqKcj/Z2tyOgkq5L9I4yMes93jK4YnufIQiyPiXvPw+FkaX/wkNNuhmin+Y4GYEzox
 rjskr0uSveHA2p8ZoVZKJQ8cJrRqQvIpCZrpBSTE/XutmzpAniU2h0IDOU/zaKPF8SR4
 kLPjcJTWYMvmPixyd9kgdrwLhSlc7y8gybesF88efkdoJSUcT51Atl8ui1GXnZWBBSXx
 uC8w==
X-Gm-Message-State: AOJu0YxColvhjJWxrT9uz/T6J9+rvGLH8Z+EJVB3c5aPPWtVwckVVqOa
 wdukWSEWd9jybSZTgAvZmQXc3IGcDIftNSnnfXF5Kv0DVDqay/LYg9SHzccrj1jpzyK4DppxtQD
 D
X-Google-Smtp-Source: AGHT+IF33O8+50Vc8/aTpacYxOmPCVTReJPdNIGrTBJEO6Bie5x6CLNtYSAQEpjJ2CEZ4YkLixfiYQ==
X-Received: by 2002:a19:e001:0:b0:515:9dcd:22ae with SMTP id
 x1-20020a19e001000000b005159dcd22aemr4305654lfg.66.1711370550130; 
 Mon, 25 Mar 2024 05:42:30 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 t20-20020ac243b4000000b00515b1b3a2bdsm35231lfl.194.2024.03.25.05.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:42:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 8/8] plugins: extract cpu_index generate
Date: Mon, 25 Mar 2024 16:41:51 +0400
Message-Id: <20240325124151.336003-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 16618adf1bc..e6fd6fdfae5 100644
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
 
@@ -212,10 +213,7 @@ static void gen_inline_store_u64_cb(struct qemu_plugin_inline_cb *cb)
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


