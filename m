Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F27CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp60w-00057R-Qy; Tue, 26 Mar 2024 08:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp60v-00056t-HO
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:34:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp60t-0000dO-WE
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:34:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4148c6af2d3so8335315e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711456485; x=1712061285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrYhcbQiD/iBdvr35vsxxSuWauM+6gxOSzxNrMmsmbY=;
 b=oe8RA2DVOAn5RiG1nUh+bmU2nGBfsx58517XEvbczx0JHmN0BWatEOL/+Rp/i3IOjt
 74K+ZEZWTenfxBGUE2EmYDzC50f5BBpBL7RxlW5hFaqu8IWavRv+75qAvsNU0BeeMuZw
 M8rwT4KoU/gRjKi+Xzs0d0SvJk/Cn6t+CZ9pFaOiFJQa/TqfpF9JbjrX3XeI8cnBH37w
 xWCWUE7OmnW4aNxOGvsFuYi7OnVIHMmdj1P9CNFFRVKlI+MQ+DQ7FnO1G1V2pqoyEYgq
 yDcAiQpnkVwkb4yIk228eEmY5YhNRMGjs7vQgVNHO8odgZ8UoC8DD3NI1w3OKCFr21+5
 aFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456485; x=1712061285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrYhcbQiD/iBdvr35vsxxSuWauM+6gxOSzxNrMmsmbY=;
 b=Ao6mALPOWdY4oxCA6aOHRDQKPWTCLnIF3S8tbPn9KdwcwizQhLFHnE/9vJgkwAGY1m
 0GW0TiHBSAFSGf2CETvnDitE5QxkL0IxmNZX1GABWDBlze6LJb2sc93I6U2QUEmA4DQ8
 lcdwQ0L0wGFXhGOBM2izXrgakQG7qk4EgowdQ5UlOyHkQsfrKY5t2atiQxYhh/EoLu86
 qn8Op8RDvhKVnD4VUFcKVsv3bECQXl5hvZxvVUFjqllJRYmqH3VLPJ4xRvIUlkZOKAtE
 Q4T+jUO6Vf7UBl/v7DPJllul9rI5JFMZU/gR1aFTawPgq3G7wqXwAMl62CEsbomdBL4u
 imYg==
X-Gm-Message-State: AOJu0Yw642NER4cI5dpiK4pGtoDc0/Src9exmS89LNwkSvnNEyQCIRsC
 DTQzH2YqPv7yHCN7nzrrsXYXm6u/TbrlZk8nl5eH3ITXGtU42AnKEIzWRpeQqkxqqp9k0rpOlC+
 /C9w=
X-Google-Smtp-Source: AGHT+IFDLHw+bx5jmaOGf7ZDIw7+qBbiykKkHJ4MD+Xltk7GQZqyRLTfXiyMiWsef8C52gJqerd3jg==
X-Received: by 2002:a05:600c:2e51:b0:414:250:ccaa with SMTP id
 q17-20020a05600c2e5100b004140250ccaamr7189953wmf.12.1711456485419; 
 Tue, 26 Mar 2024 05:34:45 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 y19-20020a1c4b13000000b004148090cf85sm716317wma.0.2024.03.26.05.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 05:34:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 1/9] plugins: prepare introduction of new inline ops
Date: Tue, 26 Mar 2024 16:34:18 +0400
Message-Id: <20240326123426.761473-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
References: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x329.google.com
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

Until now, only add_u64 was available, and all functions assumed this or
were named uniquely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h  |  2 +-
 accel/tcg/plugin-gen.c |  6 +++---
 plugins/core.c         | 14 ++++++++++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 201889cbeec..23271fbe36a 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -68,7 +68,7 @@ union qemu_plugin_cb_sig {
 enum plugin_dyn_cb_type {
     PLUGIN_CB_REGULAR,
     PLUGIN_CB_MEM_REGULAR,
-    PLUGIN_CB_INLINE,
+    PLUGIN_CB_INLINE_ADD_U64,
 };
 
 /*
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c3548257798..41d4d83f547 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -120,7 +120,7 @@ static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_i32(cpu_index);
 }
 
-static void gen_inline_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
 {
     GArray *arr = cb->inline_insn.entry.score->data;
     size_t offset = cb->inline_insn.entry.offset;
@@ -165,8 +165,8 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
     case PLUGIN_CB_REGULAR:
         gen_udata_cb(cb);
         break;
-    case PLUGIN_CB_INLINE:
-        gen_inline_cb(cb);
+    case PLUGIN_CB_INLINE_ADD_U64:
+        gen_inline_add_u64_cb(cb);
         break;
     default:
         g_assert_not_reached();
diff --git a/plugins/core.c b/plugins/core.c
index 0213513ec65..a8557b54ff7 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -316,6 +316,16 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
     return &g_array_index(cbs, struct qemu_plugin_dyn_cb, cbs->len - 1);
 }
 
+static enum plugin_dyn_cb_type op_to_cb_type(enum qemu_plugin_op op)
+{
+    switch (op) {
+    case QEMU_PLUGIN_INLINE_ADD_U64:
+        return PLUGIN_CB_INLINE_ADD_U64;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
@@ -326,7 +336,7 @@ void plugin_register_inline_op_on_entry(GArray **arr,
 
     dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = NULL;
-    dyn_cb->type = PLUGIN_CB_INLINE;
+    dyn_cb->type = op_to_cb_type(op);
     dyn_cb->rw = rw;
     dyn_cb->inline_insn.entry = entry;
     dyn_cb->inline_insn.op = op;
@@ -551,7 +561,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
             cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
                                    vaddr, cb->userp);
             break;
-        case PLUGIN_CB_INLINE:
+        case PLUGIN_CB_INLINE_ADD_U64:
             exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
-- 
2.39.2


