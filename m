Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E81EC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wBp-0004zb-9w; Tue, 14 May 2024 13:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBk-0004ui-Bs
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:45 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBh-0004ul-8v
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:44 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52192578b95so6897609e87.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715708583; x=1716313383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWnBwMuw66Zw+u1x4hTmI03qXiyp3WcyiBkWmxW0plY=;
 b=d92fBC7HRihQA36v5zU67jB2OjDjrCSSalP1AXpaREvbTBPg+InedPaO3Uc5Gs1SER
 Ut0CfQKSP2okJzoVyUTyht857ZEU1r+d4r1zCYu82ByDl2DiahGomjj6Oi/X39K0rgr5
 Z9FTOlC2HN2DzoOhAfFaOBa98YG2/7HMkajxnmeJqUCLGuu5/rpVHme5eMVE/P1217D+
 IzipvCl3Df3gatdgrQr8jSMtBWozhrB0a0Tt8YwHd2MfSe+6G3R0HKBKTTpPu4R/GxXH
 EOxMjJdGW7g/gfBxTfEyHJHeqUMnjLduWXs+MD6fWKDGrjIcyPZDoQSjkpClDDJFRei7
 sqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708583; x=1716313383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FWnBwMuw66Zw+u1x4hTmI03qXiyp3WcyiBkWmxW0plY=;
 b=Pwq29iFy8dZhlM8BsQKXICCpu8VWVfYDiNlCa3tP+vTM3VgVjPjI5tZN8tjYb+jlkY
 qYipg7ALYgcIv0PIDg3+iBep2OZ/xem1n66b5NoNhl7dxIHxnVmz/gpGSy0NjB+k16DP
 3Ue7o0JPTFe3G8HWQr7SbE9+o+JKsvqzo2rGWnEoUF/BXMTylFHiUg+DFJKhJpQdGa2N
 tItD7FYHmoD33B27wD5VU/m1CY0YtaieN2bZ4cl4XOo1WOWxrIbpYaJJLujXL2AkjDVf
 v3IlrgPRSAcoZWBhHR5TVwUs9wUy0DRuOKvmcNuFk3p8xFdpsBsLSECzJTzYWdEg0lTx
 rV8Q==
X-Gm-Message-State: AOJu0YwLLU4foldnrUa24sliNTn7Im96jS3zcsEt9kvbhykPtcLN908f
 m08F5g/xI/rU/KIGd9Gt1lAIeO5B+JUrw86hdm5fxcPb7mNYs9OF8n/t19Mqd1s=
X-Google-Smtp-Source: AGHT+IFVE60pdiJSEZavcmhu8VtBYy3eqj7BY1eP0c4XEcLEOF1D4wfyFFbv5gh1p4gp8hlL5uS4kw==
X-Received: by 2002:a05:6512:3283:b0:51f:1bf8:610e with SMTP id
 2adb3069b0e04-5220fc6d559mr8340465e87.37.1715708582637; 
 Tue, 14 May 2024 10:43:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57421480d99sm5758823a12.8.2024.05.14.10.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 10:42:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E419C5FA2C;
 Tue, 14 May 2024 18:42:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 10/11] plugins: extract cpu_index generate
Date: Tue, 14 May 2024 18:42:52 +0100
Message-Id: <20240514174253.694591-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514174253.694591-1-alex.bennee@linaro.org>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Factorizes function to access current cpu index for a given vcpu.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240502211522.346467-9-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/plugin-gen.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index e018728573..c9b298667f 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -101,12 +101,17 @@ static void gen_disable_mem_helper(void)
                    offsetof(ArchCPU, env));
 }
 
-static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
+static TCGv_i32 gen_cpu_index(void)
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    return cpu_index;
+}
+
+static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
+{
+    TCGv_i32 cpu_index = gen_cpu_index();
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
@@ -121,9 +126,7 @@ static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
     char *base_ptr = arr->data + entry.offset;
     size_t entry_size = g_array_get_element_size(arr);
 
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    TCGv_i32 cpu_index = gen_cpu_index();
     tcg_gen_muli_i32(cpu_index, cpu_index, entry_size);
     tcg_gen_ext_i32_ptr(ptr, cpu_index);
     tcg_temp_free_i32(cpu_index);
@@ -156,7 +159,6 @@ static TCGCond plugin_cond_to_tcgcond(enum qemu_plugin_cond cond)
 static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
 {
     TCGv_ptr ptr = gen_plugin_u64_ptr(cb->entry);
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGLabel *after_cb = gen_new_label();
 
@@ -165,15 +167,14 @@ static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
 
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
 
@@ -203,10 +204,7 @@ static void gen_inline_store_u64_cb(struct qemu_plugin_inline_cb *cb)
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


