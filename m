Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308D8C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojfF-0000Vx-BK; Mon, 25 Mar 2024 08:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojec-0008SX-9R
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:24 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojea-0006e3-GC
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:17 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-512ed314881so3074958e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370534; x=1711975334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xa0cGVykUGxKfnAtL7QB1M6ycqNL5KJpeAnibJ6bZdY=;
 b=NnkUHyGs/HYkPiSBIwE7e5Ohrbd9JtgDr2RfrchwbTtYGCiEJQy1+SRU2x2KXDUx2M
 ceFDNvboNwWY5NAbfkoIlZC0OYxeKgx+icBsfTQIFrlJzBrrSVgumQS4hLgHNo+Kfv0V
 HkEYV+tuH9q8RXfgG+cudOWsXpTyHqet41AmQJrxznpw61YzaPXNllWik8KB/fJkxmFH
 AS43yclALMVi0mAo3eWMv++DkQ9gr8RuO4uN4EW/GUT2UTByAluVcjpHxVnXM5xQDpHg
 4JE5MnIfLu3/SWES3bEcYdHYWuIeQj4yF3o/AnvE48R2J87wND5TdCd/PZ7w7PrKxpyN
 60rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370534; x=1711975334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xa0cGVykUGxKfnAtL7QB1M6ycqNL5KJpeAnibJ6bZdY=;
 b=NpT2S3gN9Vdma3FLypfnVNrHlR59R0Tr58gPlBcwWIKy8CBkaYm4dZCpipkV//lPTX
 5B9cziTWqNZ5q+kh/Eq+KqI47JY5RUbV2snkChBwYpitiaQdNhavQk5Zfeqq1XyqLYDX
 OdH/CJhy2Y6jXC9KaMBkCiJl+TOK0KSzt9+G4qL4EIlx3SstqIPkz4dbveJce8R9pUnu
 J/9bdfitokBqGocF7Vx6FWyFL7H5YClwppS8bi2+8YSSf16CX9Y7Tz8qEpQLFQWKMoML
 9qJh8Up/r5lJzR58ZJ2eb8on6wTY8pWU1x19Latpfl80KrsYymeWaXWUij38cRe0jnLd
 RAxQ==
X-Gm-Message-State: AOJu0YxV0CsyMu7NY1xbRop4tB0KZAdZFnPr1jpTeO+3xRmmOcs2zGTC
 Uxx699AKYekfQ1QdhQJP0mk0IzhekyE0VXv7n+G6Z6xTvyxSXvKN79F0hrKL9G4P7sASlpoYWEp
 w
X-Google-Smtp-Source: AGHT+IFDV9ZH/Q6lbrsVRAPhtjBq6vOqXtVK2jDk4cW5sSgvOo8kaCR4lHQqBtgZHG78DI9BcbKONw==
X-Received: by 2002:a05:6512:70d:b0:513:13eb:c99b with SMTP id
 b13-20020a056512070d00b0051313ebc99bmr4933812lfs.62.1711370534389; 
 Mon, 25 Mar 2024 05:42:14 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 t20-20020ac243b4000000b00515b1b3a2bdsm35231lfl.194.2024.03.25.05.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:42:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 3/8] plugins: add new inline op STORE_U64
Date: Mon, 25 Mar 2024 16:41:46 +0400
Message-Id: <20240325124151.336003-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x132.google.com
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
 include/qemu/plugin.h      |  1 +
 include/qemu/qemu-plugin.h |  4 ++--
 accel/tcg/plugin-gen.c     | 15 +++++++++++++++
 plugins/core.c             |  6 ++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 23271fbe36a..d1d9b4490df 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -69,6 +69,7 @@ enum plugin_dyn_cb_type {
     PLUGIN_CB_REGULAR,
     PLUGIN_CB_MEM_REGULAR,
     PLUGIN_CB_INLINE_ADD_U64,
+    PLUGIN_CB_INLINE_STORE_U64,
 };
 
 /*
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4fc6c3739b2..c5cac897a0b 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -305,12 +305,12 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
  * enum qemu_plugin_op - describes an inline op
  *
  * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t
- *
- * Note: currently only a single inline op is supported.
+ * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t
  */
 
 enum qemu_plugin_op {
     QEMU_PLUGIN_INLINE_ADD_U64,
+    QEMU_PLUGIN_INLINE_STORE_U64,
 };
 
 /**
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index d3667203546..45856a75cda 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -152,6 +152,18 @@ static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_ptr(ptr);
 }
 
+static void gen_inline_store_u64_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
+    TCGv_i64 val = tcg_temp_ebb_new_i64();
+
+    tcg_gen_movi_i64(val, cb->inline_insn.imm);
+    tcg_gen_st_i64(val, ptr, 0);
+
+    tcg_temp_free_i64(val);
+    tcg_temp_free_ptr(ptr);
+}
+
 static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
                        qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
@@ -177,6 +189,9 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
     case PLUGIN_CB_INLINE_ADD_U64:
         gen_inline_add_u64_cb(cb);
         break;
+    case PLUGIN_CB_INLINE_STORE_U64:
+        gen_inline_store_u64_cb(cb);
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/plugins/core.c b/plugins/core.c
index a8557b54ff7..e1bf0dc3717 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -321,6 +321,8 @@ static enum plugin_dyn_cb_type op_to_cb_type(enum qemu_plugin_op op)
     switch (op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
         return PLUGIN_CB_INLINE_ADD_U64;
+    case QEMU_PLUGIN_INLINE_STORE_U64:
+        return PLUGIN_CB_INLINE_STORE_U64;
     default:
         g_assert_not_reached();
     }
@@ -535,6 +537,9 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
     case QEMU_PLUGIN_INLINE_ADD_U64:
         *val += cb->inline_insn.imm;
         break;
+    case QEMU_PLUGIN_INLINE_STORE_U64:
+        *val = cb->inline_insn.imm;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -562,6 +567,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                                    vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
+        case PLUGIN_CB_INLINE_STORE_U64:
             exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
-- 
2.39.2


