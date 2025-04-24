Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D044C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmr-0005JA-Ul; Wed, 23 Apr 2025 20:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmo-0005FI-1n
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:54 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmm-0004LP-89
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:53 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so274099b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455791; x=1746060591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jprqwHHwWojdGfQ1QgUvwGwX1dYcnH5RZgYMJfPxUv8=;
 b=oFk404LKh6YDydM0dVJz7LgeWO6r9gnTgosAvL+EOzFPErijbNqBR9P2wsTp6djq5r
 8EC4EJwD1kby6zouICZEBNJ6YLAOJU5Uk5CLt1BVwbHikpzKO6w9oQ99ydfjHp0Z7AKL
 dX8xJTuUxXjzFbm46anmJlASwd9YtmQUeRN9fL6wPutgm380b93+ZAT0WS70RwN8NP4w
 r16XkBy10c6bvHzvRMTBdzkXzjBAcVLb1G2UQGvuzEUshiehpC9vWkdJBXfXoXkipbpq
 RK1iwxlh9IK3ps06bL5LxObJHPpR8ANcDQox1QlQ0xbeHu3Z0Wzs7rg5gfeKsb5mC+MH
 vcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455791; x=1746060591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jprqwHHwWojdGfQ1QgUvwGwX1dYcnH5RZgYMJfPxUv8=;
 b=WWYDO8Iy5EN8nKT+GF4lEBklFCv407WpAn8eXkK5AH4YO7hQSqDbIqEtSexJU2pzDk
 aFSJ+NK1a/DpvyU67+wxmyg1pamSwAkHKzEvWldFaktju4eOeS+E/m2nsn3sYuENmc/Q
 C9z8XWewxOsRjEjWWU4Te/cWwM0PY/zJEucA2QlT2UhJhhoTQ5pYrle4/pT6khAPR22M
 Iz70rJheOARU054f+LViK7BYi9IQpRHL5rXV+/xFXmF71rZHC+BWtUf5jNi29W4ztnsy
 8xDs4Of+PoY3oWZSm68nQxxs1bUVhEoIZgW3JYKhTYebAPuNOFOmWPCB6TNJtQPSuSZU
 a1mA==
X-Gm-Message-State: AOJu0YznV7YFSZoi31S0+8+zJINoyMrI5TbEam6Z+zhDN9Z4ipS/VSsu
 dB5iF8vTbnOoKJXnDzgY8ByijlWlehLjteqcG8lbuumlOOw992Xb9AY3sbh6rBLkAXg9cl5yrwU
 t
X-Gm-Gg: ASbGncv2D0bKTpQT8S1n6uWA1FWni/mTBvyvPjIcGnDl438BL7y7kgSrJ93wuyemUip
 SdIf/8RTow9Qm8hd+9WxCsf94MQVyOKxcTEYn4QwbV/iHmYR+rxRN/yGcBJb0B0jQxJpWZhPT3X
 NOh1mWvPyVUWRdaJ2hCJWenbZcx0i2HCe9OLoXSJvwoGrz8jT7Ew9coZ+lhMtRmwz9YpV3NQ/27
 KWVUABA7x1SHKTjzZ7XZTL353MWJH+l3CrDxzzN9ze1GWF7MMkfcgntC5EqVZWjsaiQqqKRmwV5
 eoScmvtMTcIM7J/OFkjMhc2TwLdnb82iHKZzGE5FrBvo6bcP31rQxtEYpDkNeAB+s3Jdfa5mlnk
 =
X-Google-Smtp-Source: AGHT+IG7Jp4gMJh6YEoy+EXSmKGTe5Vp/wOqHU83CZDg9NjIPK2CsI4zwIiU3jKys4HpffxhpGos/A==
X-Received: by 2002:a05:6a21:338d:b0:1f3:33bf:6640 with SMTP id
 adf61e73a8af0-20444f0813fmr797340637.18.1745455791008; 
 Wed, 23 Apr 2025 17:49:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 020/148] accel/tcg: Build plugin-gen.c once
Date: Wed, 23 Apr 2025 17:47:25 -0700
Message-ID: <20250424004934.598783-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

We assert that env immediately follows CPUState in cpu-all.h.
Change the offsetof expressions to be based on CPUState instead
of ArchCPU.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 13 +++++--------
 accel/tcg/meson.build  |  7 ++++---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 7e5f040bf7..c1da753894 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -22,13 +22,12 @@
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
-#include "cpu.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
-#include "tcg/tcg-op.h"
-#include "exec/exec-all.h"
+#include "tcg/tcg-op-common.h"
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 
 enum plugin_gen_from {
     PLUGIN_GEN_FROM_TB,
@@ -89,15 +88,13 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     qemu_plugin_add_dyn_cb_arr(arr);
 
     tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
-                   offsetof(CPUState, neg.plugin_mem_cbs) -
-                   offsetof(ArchCPU, env));
+                   offsetof(CPUState, neg.plugin_mem_cbs) - sizeof(CPUState));
 }
 
 static void gen_disable_mem_helper(void)
 {
     tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
-                   offsetof(CPUState, neg.plugin_mem_cbs) -
-                   offsetof(ArchCPU, env));
+                   offsetof(CPUState, neg.plugin_mem_cbs) - sizeof(CPUState));
 }
 
 static TCGv_i32 gen_cpu_index(void)
@@ -113,7 +110,7 @@ static TCGv_i32 gen_cpu_index(void)
     }
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+                   offsetof(CPUState, cpu_index) - sizeof(CPUState));
     return cpu_index;
 }
 
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 14bf797fda..185830d0f5 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -3,6 +3,10 @@ common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
 ))
+if get_option('plugins')
+  common_ss.add(when: 'CONFIG_TCG', if_true: files('plugin-gen.c'))
+endif
+
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
@@ -12,9 +16,6 @@ tcg_specific_ss.add(files(
   'translator.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-if get_option('plugins')
-  tcg_specific_ss.add(files('plugin-gen.c'))
-endif
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
-- 
2.43.0


