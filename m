Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFEEC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojfC-0000PA-4Q; Mon, 25 Mar 2024 08:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojeb-0008Rw-Pd
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:17 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojeZ-0006dq-3m
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:17 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d48d75ab70so63117721fa.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370531; x=1711975331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBbBJBKlzbAiSe9s/4Me+wF/GqPYbBpWR9ono1LAYxM=;
 b=zSCp4U32PYwyuU0StsZ7jdGC3tBQmrdnvZaEi47ugIX4sfrFbrtbEDWuLBLYH6r/4B
 nNyAIxciFajX4z8r2AKqzyNymibwn2qmjBAuQuVgFOYpLJi0av3H6fcXEqAD7JR61lkQ
 /aEH3SwTgPq7rlIptdEkipJwza92lElcWfiAr1pUmilMlf3kxlaVEs3lrBXwc28vhC2k
 lN3AC6SpKj/YRf+boHKtfWWNmDU+ucZPz9GhMrBgdS8TgRn+HEBiJcFe7Ia6GlREUyhI
 ujdXwLJsF904ua5pxRDQfQTZZvS7lAImDFb66Bl3P9NmUJXaxb77JXCfn2K8FaQRcmHU
 KC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370531; x=1711975331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBbBJBKlzbAiSe9s/4Me+wF/GqPYbBpWR9ono1LAYxM=;
 b=p4t5KsqCx9zqE9Y0ikug0wa8gS7QfdfyHhJ4TWzAE2FexLBDuHQPNFKYeDzk8IGwPm
 srzf0hZIDrsOOrbpkL7GVKHcvGVIeEBPESwUSnBpIvJ+rlke74JMXsyxEgBTE16HdL92
 5xk48jhBidMdMEKQ9D79rLxtHNXM63nCPy6eUFw8P1nuMA1gQd2VzguaPvJBSSU8sMBP
 arWWAphRzVp2jXSbAB6q192L+yPm02xd2N+IsJ7SSC1qm0vZRmF3DihDs/m6E178aE5r
 +ceBHZ/lM1QXmpojivmR873Y6UM1zp8cXTMsVK4E3LHwrDx9oMF3Kt36+89cBqwfuUsV
 7dzQ==
X-Gm-Message-State: AOJu0YwwLtlFqkWyIwkQzvOVi5Y+cTNxlO0HNIlk8l0syrEAgLnovRAb
 7MWxAMxNfM6Y4p8ZvJKIG9oA4tHXuxrXN07el5J6D6THn7owuRIcq7iPL3TTiwe3LvGCniWrD4M
 m
X-Google-Smtp-Source: AGHT+IFYapgpp/gKLjq3CZpLJctbFLeD7IVQWTzDiEzqirTg3IyAFgwWfVF7GLFaVKi32CDuyFs1bA==
X-Received: by 2002:a05:6512:32a3:b0:513:cfd5:4217 with SMTP id
 q3-20020a05651232a300b00513cfd54217mr4741540lfe.1.1711370531318; 
 Mon, 25 Mar 2024 05:42:11 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 t20-20020ac243b4000000b00515b1b3a2bdsm35231lfl.194.2024.03.25.05.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:42:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 2/8] plugins: extract generate ptr for qemu_plugin_u64
Date: Mon, 25 Mar 2024 16:41:45 +0400
Message-Id: <20240325124151.336003-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lj1-x231.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 41d4d83f547..d3667203546 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -120,24 +120,33 @@ static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_i32(cpu_index);
 }
 
-static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
+static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
 {
-    GArray *arr = cb->inline_insn.entry.score->data;
-    size_t offset = cb->inline_insn.entry.offset;
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-    TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
 
+    GArray *arr = entry.score->data;
+    char *base_ptr = arr->data + entry.offset;
+    size_t entry_size = g_array_get_element_size(arr);
+
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_muli_i32(cpu_index, cpu_index, g_array_get_element_size(arr));
+    tcg_gen_muli_i32(cpu_index, cpu_index, entry_size);
     tcg_gen_ext_i32_ptr(ptr, cpu_index);
     tcg_temp_free_i32(cpu_index);
+    tcg_gen_addi_ptr(ptr, ptr, (intptr_t) base_ptr);
 
-    tcg_gen_addi_ptr(ptr, ptr, (intptr_t)arr->data);
-    tcg_gen_ld_i64(val, ptr, offset);
+    return ptr;
+}
+
+static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
+    TCGv_i64 val = tcg_temp_ebb_new_i64();
+
+    tcg_gen_ld_i64(val, ptr, 0);
     tcg_gen_addi_i64(val, val, cb->inline_insn.imm);
-    tcg_gen_st_i64(val, ptr, offset);
+    tcg_gen_st_i64(val, ptr, 0);
 
     tcg_temp_free_i64(val);
     tcg_temp_free_ptr(ptr);
-- 
2.39.2


