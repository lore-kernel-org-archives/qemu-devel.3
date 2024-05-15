Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A4BC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 20:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7LAF-0001AF-MO; Wed, 15 May 2024 16:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA9-00013W-5u
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:45 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA6-0004FU-9A
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:44 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a5a5cb0e6b7so229072466b.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715804621; x=1716409421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXjx6EwI5iNgHe7xs2dDKKM4FwIFf0HMSdJE7zxTZRA=;
 b=Bc68M96cecym702znOSTI/tTlYkilNDAbH7SZcFVhRL3FXeFAVbN2KIQpjBa3zjzzy
 jO04aYqaCuPtmTebrFv4h0DT9EmPiJMuX2YQYIFJzAj8bC5c8kHC0T/rejlCT4rxKpx5
 AUHsd1L5kbxF+5U5YLoBSsf3HQGJj7X5Vy1uAovTKZTl2qISE+wRkx7IjzMTVdgrV2Uj
 xSGKr3ucwTd1c2ZctASID7Jlqauu8CSArireeSDTPJPe55TC3O78O1WH1KBEJPyQWQPn
 eIvycJUOPnr0dDZbrK82AhTDNesAfeuQx51fhUW/SinE9XeW277NEIbodLcpyqF3QU2b
 1ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715804621; x=1716409421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXjx6EwI5iNgHe7xs2dDKKM4FwIFf0HMSdJE7zxTZRA=;
 b=tnNxgj4znSjKuEIQ+Vki7nmCgsXK2BRXwObApv/TkY5QcqVVRMRRoQeKvkujJtbxWq
 QRzK/6hhU8XGwYwsrgAqbktg08tGqdVoOZmM9KrG1FqyQpwThircoLVz6LBhKQQMJbjC
 rGtUbpqHeiWlAKXwcS6Sz7A4GYYmcAI9DhiTn1JhWtFyRNhOyRjCE/v46SKfcGcOhiMx
 2zQWJXgvBAsaK0o+o83KA+uEUPDmuxq/qLpADyEzENajbmRDDuZ2eH9s0cNIsvzKSa1E
 NkIPUOycCboiZC9PFCWtYPImm/YIxpsnIkvujacx1/Lqv6htXkndREwBc5HlArDJ+jbo
 NW5w==
X-Gm-Message-State: AOJu0Yyr22qefYa7IxfFEm5c+F9+BjB3/4r35DElDcpKOzSz3O4ERd9e
 NLjkEKDYX0bwPyUet5cD0lRTAej2YVtCygOabcT3GM8w7rkbhmzBc/5NDiZeEzs=
X-Google-Smtp-Source: AGHT+IGwX/rvPBP3DL2sIv22svx0TsD47URP8IUDwEakdHSRayjheM0H/pOe7oUOvrdGutgrMRRXDw==
X-Received: by 2002:a17:906:22c7:b0:a59:be21:3577 with SMTP id
 a640c23a62f3a-a5a2d5cd472mr1087559666b.43.1715804620798; 
 Wed, 15 May 2024 13:23:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17555sm895581466b.189.2024.05.15.13.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 13:23:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A4C7D5FA2C;
 Wed, 15 May 2024 21:23:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/11] plugins: extract cpu_index generate
Date: Wed, 15 May 2024 21:23:33 +0100
Message-Id: <20240515202334.710324-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515202334.710324-1-alex.bennee@linaro.org>
References: <20240515202334.710324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Factorizes function to access current cpu index for a given vcpu.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240502211522.346467-9-pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240514174253.694591-11-alex.bennee@linaro.org>

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


