Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343E2C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wBm-0004xd-NH; Tue, 14 May 2024 13:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBY-0004s5-9j
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:39 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBP-0004uL-7z
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:29 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-572baf393ddso1731835a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715708581; x=1716313381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eV/zf5lPaGHYQYWT03Xfqb/pBXEE5bjNOFAW4VPpOm0=;
 b=K6C7F8MmKE4Ov8CCttiljURFvP1yzM0kb5aTbhu0/PH+p1l7gzsoZrOZ4EodxUb1pv
 sOfm80xatt+PSGTvmyrTw80VokDeThm0O/UA6navlavQZRHqeLqn4Ouq88FyVOFctrRG
 7n6/TmgL0QsLfHemW40TgM6ukc/UpR2Hr0hjVZgLJizOfO0a2MTKPzb7Sn+lKmMOhdyQ
 NT6pq0Ck33jAM+sl4T+8aqPIolhxjgllY4J8wfiFwkkGDVcb/aNYig8yp5gEXkWuymbt
 ZCxs16P9vvoNDbIUQOd3CeW9NpFKaAzkjdQrgtxnxmHRmkpZgFVgCRoX530cZKFYwC8P
 I8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708581; x=1716313381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eV/zf5lPaGHYQYWT03Xfqb/pBXEE5bjNOFAW4VPpOm0=;
 b=VWnrx6j3VgdWPp2nfWk/ktaEN/MSEY7utiXepHPuGVFmiFDbBjBA28RnwC0t6C8LzF
 jukcgBZ2dQrzZp6NmkJvsbZgdhe8uJtghsXW+g5KsLaBj7f9cwwTgt0VK3sGLDB2sBCq
 dirbmXIlvdRZQ0X/r3xPL9pP+i/JMAURyAdtu5sYPZ+HPUWlDwVLj+T8RRw4LL7a+k2L
 bKfA+iAsJHBe/JhDVu/4RztvYS2FijXWA3bz/lJcJLTWMLtMzGU8pHHHeFYqEq4V20L8
 fYcRXjSPyC+rXlZAOxdqd1mH5HD4XyPN80MDXK0jxo7qe5NZZkSbnwW+VY8I34+mbi7I
 taXA==
X-Gm-Message-State: AOJu0YxgpUZeoxRUB+CO3ecycIquuTQlc7Lw28stJAPTik03SeYeZQed
 k1UjCUfEHzRK7P4gu/D0XDn9b4Sn1H6RSILWLx3hU6tf8FgCEWgq5xmtd8aDikQ=
X-Google-Smtp-Source: AGHT+IEwG+00oyuc6EgKvIMNyACWyQlvq42Q4PD92poSPYILp5y1r+gY2H+HTIbp4PtmySAbX8DkcQ==
X-Received: by 2002:a17:907:9950:b0:a59:b5a6:65c7 with SMTP id
 a640c23a62f3a-a5a1155e921mr1460896466b.3.1715708580956; 
 Tue, 14 May 2024 10:43:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7fcfsm738917166b.119.2024.05.14.10.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 10:42:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0ABD65FA2D;
 Tue, 14 May 2024 18:42:55 +0100 (BST)
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
Subject: [PATCH 11/11] plugins: remove op from qemu_plugin_inline_cb
Date: Tue, 14 May 2024 18:42:53 +0100
Message-Id: <20240514174253.694591-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514174253.694591-1-alex.bennee@linaro.org>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin.h |  1 -
 plugins/plugin.h      |  4 +++-
 plugins/core.c        | 13 +++++++------
 3 files changed, 10 insertions(+), 8 deletions(-)

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


