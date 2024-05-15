Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD20C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 20:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7LAE-00018i-N3; Wed, 15 May 2024 16:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA9-00013a-M2
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:45 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA7-0004G5-UE
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:45 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-572e48f91e9so2509827a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715804622; x=1716409422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8l+Ilv7VeF5QKcYGINL5nyqXVwuf6cAItY3C7pcDDws=;
 b=steeKQp/CCMOGhq6nLyft1ja6a6ZcRt1WPXBhamG6OgzNqGa2xROzr6UaBO49X3WTF
 IU6oTo7/j/nPDQ1H33zVcqiGo/+LJ5dmlCIxGgxP1XEnkNnE0rV5vneuQjOCZbd17HvW
 TJ7KaH2RhhbSf3604eeEz7azZfR2ZKgL/cwGfhtThT1B9qafndVeLuBo4+0U5bOgarBB
 4fQBuH64jGZFSqPsgvuZHqy1J8za+iF+Qll3J2RAsXap3mqhQx8EP3OlHk3yRVzA4uzN
 ZiROYXDUBMJ6z6W85driB37h1tbe3vjA+UbdIjeCNd8jH00PIgJWW7TiIDIv+X1qstb1
 MR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715804622; x=1716409422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8l+Ilv7VeF5QKcYGINL5nyqXVwuf6cAItY3C7pcDDws=;
 b=Ls/XcL+odStm8LNmuvgDwAp8C0fjgXERYWTAddf0zsDXMahGvATGSUj1DV0yBgdOjh
 DC3RxmnHz0fEFI7i2UINT5LqTI6wzhUNfdvzjDr9D2Yao/kGWgaye7AoIOOrBU3j4Rd/
 OpmqtAXPJwlxfgFEvwsLXXZWtzra0euz4BQApapmdRjYtxzZN+WyNFumB/E8h8asZeFt
 wVWwunISD3MeS51iXsuHZcG+UjsVz2MFTznRC7/+GEfeHdSMN8QZI8y6I2tLdAL5S0X6
 exRL039OcDSEZmtpuSRUUYq86LX5q9SCx2/vHgwEeR+VtCne/2qQgkn1gGiZeO8B9BED
 Il9A==
X-Gm-Message-State: AOJu0YzTtpKCn+eO1XMu3mGNhUgftkJvwOjA/9R6/ouWmHrXx3jkOzQ3
 0fkopb6ZL9fW4AORDxEY/3DakHbLw3mop/VtZOYm21/jhQoQe4meztF4aSHkUnM=
X-Google-Smtp-Source: AGHT+IFv3qGHmC+Xq9R0eAJMGZq2Leqpq0E00Z83SNI3qBLX/QKXOqLznE8+SZF5sUrlQhBx6ak6Kw==
X-Received: by 2002:a17:906:3618:b0:a59:9c14:a774 with SMTP id
 a640c23a62f3a-a5a2d680d90mr1119373766b.74.1715804622457; 
 Wed, 15 May 2024 13:23:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17892450sm904940366b.63.2024.05.15.13.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 13:23:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC65B5FA2D;
 Wed, 15 May 2024 21:23:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 11/11] plugins: remove op from qemu_plugin_inline_cb
Date: Wed, 15 May 2024 21:23:34 +0100
Message-Id: <20240515202334.710324-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515202334.710324-1-alex.bennee@linaro.org>
References: <20240515202334.710324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

This field is not needed as the callback type already holds this
information.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240502211522.346467-10-pierrick.bouvier@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240514174253.694591-12-alex.bennee@linaro.org>

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 98d27dded9..796fc13706 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -83,7 +83,6 @@ struct qemu_plugin_regular_cb {
 
 struct qemu_plugin_inline_cb {
     qemu_plugin_u64 entry;
-    enum qemu_plugin_op op;
     uint64_t imm;
     enum qemu_plugin_mem_rw rw;
 };
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 80d5daa917..30e2299a54 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -108,7 +108,9 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata);
 
-void exec_inline_op(struct qemu_plugin_inline_cb *cb, int cpu_index);
+void exec_inline_op(enum plugin_dyn_cb_type type,
+                    struct qemu_plugin_inline_cb *cb,
+                    int cpu_index);
 
 int plugin_num_vcpus(void);
 
diff --git a/plugins/core.c b/plugins/core.c
index 1c85edc5e5..0726bc7f25 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -338,7 +338,6 @@ void plugin_register_inline_op_on_entry(GArray **arr,
 
     struct qemu_plugin_inline_cb inline_cb = { .rw = rw,
                                                .entry = entry,
-                                               .op = op,
                                                .imm = imm };
     dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->type = op_to_cb_type(op);
@@ -557,7 +556,9 @@ void qemu_plugin_flush_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
 
-void exec_inline_op(struct qemu_plugin_inline_cb *cb, int cpu_index)
+void exec_inline_op(enum plugin_dyn_cb_type type,
+                    struct qemu_plugin_inline_cb *cb,
+                    int cpu_index)
 {
     char *ptr = cb->entry.score->data->data;
     size_t elem_size = g_array_get_element_size(
@@ -565,11 +566,11 @@ void exec_inline_op(struct qemu_plugin_inline_cb *cb, int cpu_index)
     size_t offset = cb->entry.offset;
     uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
-    switch (cb->op) {
-    case QEMU_PLUGIN_INLINE_ADD_U64:
+    switch (type) {
+    case PLUGIN_CB_INLINE_ADD_U64:
         *val += cb->imm;
         break;
-    case QEMU_PLUGIN_INLINE_STORE_U64:
+    case PLUGIN_CB_INLINE_STORE_U64:
         *val = cb->imm;
         break;
     default:
@@ -601,7 +602,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
         case PLUGIN_CB_INLINE_ADD_U64:
         case PLUGIN_CB_INLINE_STORE_U64:
             if (rw && cb->inline_insn.rw) {
-                exec_inline_op(&cb->inline_insn, cpu->cpu_index);
+                exec_inline_op(cb->type, &cb->inline_insn, cpu->cpu_index);
             }
             break;
         default:
-- 
2.39.2


