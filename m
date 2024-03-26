Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5305ACD1283
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp60z-000583-KW; Tue, 26 Mar 2024 08:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp60y-00057h-EE
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:34:52 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp60w-0000df-TJ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:34:52 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-513cf9bacf1so7376858e87.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711456489; x=1712061289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7VfVydk8X6xAOfkDzXyCX6+wA+A3zYuyrN3TJWFm9Y=;
 b=aD7QolHA2fYhHih+ZVPzNwiZTS7Tw/UZk9BRqX1Gh30alZwBTQaEQfeQRU08LrsfUS
 at69T6KyXNTZYqUGnogdQg+zleKzHfgJufj+V7AWu2w1vWo8Iih6a1r66wKGMMokNKyn
 NSq0+3aY5/rd0uAGNZh5rHobpVxFC/colRXzkgcHpkTXHJCf+RJgp+D8PZ2FUbryDlV9
 IgUIghPtbzqNR5pMNY9KtUS7rM8mqw/83KApIKHN2izbVdrSB/Lxv2e1o6/Qq/Z5vR+J
 MUiad68VjsOZfuWeMSDeuy4S/vk22KwMKElQJFZS5eu9saDp4nJGCa9HkbdWa/yivdel
 fI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456489; x=1712061289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7VfVydk8X6xAOfkDzXyCX6+wA+A3zYuyrN3TJWFm9Y=;
 b=OUayLe+3n53Rnu94y3beXBRUxBsVmS4by5DoyJVlNhsjYcJ5FUv8Gwmxeksyhtr0jj
 LnBmYXzy+aMixice5//Sl+uZ0cynJeD45spE/xNa3R2trRSVVZ6Spx6EEHx0W3rxl3ZJ
 J7bKrRFoGO0xxGG5fuNDVaEP1Jk5uDia2030TBX6BEYfOlAQTVX5HMl2AqL5o2bGkJ33
 YYHNnpqaIonijR/Fs+dL2OaabM2pXM0H+2cvBT77LXoTWj1+J5/UWfjTcd2AsNn1q8PV
 diz6+IZXJxiGmgeWr9LRrdZJyL6hUcQ8BWVCoDL4A3nzz4SbWT801rGUsmjkybj4Yro3
 45Gg==
X-Gm-Message-State: AOJu0YwDxpbvJwKKDGvLFWBAivCgNluKK5gbUxYF/I7EKJb4PNZcZESA
 faH3EzdCvQcOy0gWP1nW4XtSjkSdLb7NMi5uq8+776/nWEugeq+JHx3GTq3lp9wIk0PaPAPjMrY
 Sqr8=
X-Google-Smtp-Source: AGHT+IHWDELf7Ew47iLifPnlmiFC5ibXSsMMmbkiLZLtVNeDz6sd73naskKontGTgFebu3NTrS/Xng==
X-Received: by 2002:a19:5f5a:0:b0:513:af26:8cd0 with SMTP id
 a26-20020a195f5a000000b00513af268cd0mr5969007lfj.68.1711456488605; 
 Tue, 26 Mar 2024 05:34:48 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 y19-20020a1c4b13000000b004148090cf85sm716317wma.0.2024.03.26.05.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 05:34:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 2/9] plugins: extract generate ptr for qemu_plugin_u64
Date: Tue, 26 Mar 2024 16:34:19 +0400
Message-Id: <20240326123426.761473-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
References: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
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


