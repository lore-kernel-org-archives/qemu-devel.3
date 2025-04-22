Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4619DC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JId-0002aM-4r; Tue, 22 Apr 2025 15:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIP-0002Ue-LG
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:43 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIJ-0006CI-06
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:40 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so5299808a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350113; x=1745954913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jprqwHHwWojdGfQ1QgUvwGwX1dYcnH5RZgYMJfPxUv8=;
 b=mQGACf9dhegM/COoRNRFK/Fbn96R+tb8J+wRYPiJgnOd0TFIpMcnu/jELbOTetI+jv
 PAI5OiGe5YZ8XH1zHaRH80yG74H8bERRcMcXPzhlvK8K7KSyWznb2QgSuRj/P/jHJmIA
 Q2LIW1VjKYLG5m3yQac5UWJRgR6dfzfp0eCY1J992PQUiINghAoTRDU+XDKe4vUZFr1N
 Od92hZRJ/p89oRi550dSA/J78h3e4OtA4PmhVhNu+KLyPiZvDAcC7hTbUkhQuBTPXHtF
 eICE/SuCdbyYVc2sIBoQmg4dvo+krvzQFwbFXsFla70v8nZ2nGSENG5yp0R7hAFsxuiu
 iEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350113; x=1745954913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jprqwHHwWojdGfQ1QgUvwGwX1dYcnH5RZgYMJfPxUv8=;
 b=Z6JamqI17gFCR5Yu4q1LCaWL/NuFTEhRrA5lQu7t0G2U+GtNkVp+HiiHegBmBSyIVf
 qkE9mmzg7jLxJV6ZAlBeKnFyh5JGcjxmuhCKGdyw0itMNv0+mc5GAIEYTeAohzWGwneT
 q9U4V9f7woEG41euikHdqOGB60ud/Mnln9cqz+iGznefNbVBJ+3FEFE1xZEKdcPiZsev
 dVosjXbr2BFLbqz0E8ro18aLyM/UlQ1P/VSoZVJx+kCA7XvvDpNTBLOuNaoTplfr7z6a
 wtLxjSYzA1qRAiHixpYPfIJtB9nA+wZqrhSEupuHBdFvtvzsvJkus0f7AFr+tqtLs5vN
 GWsw==
X-Gm-Message-State: AOJu0YxnziAGAoyJY7XqG/AiNTZJ0tuUZGHGAHkBPYD/L6577dJoblix
 9/vbyVBI+1n0M4Pc7loCwckJTe+yLHT5wq6k6sDzVqATG+mLIRgxBKilmLhceYzkpSSRiTSi0X+
 y
X-Gm-Gg: ASbGncvUVWWWTVIoQZTkIiOZzSOQp8aCNdtYp4jrukXHdrOGr3SIkHdkFWsbkabcFDe
 /T/yGXU1B4u1XeQsQXYO32OxlcixLtIxsRnn25kAL3V9Hftfynbw4VOjvWBA48QePO0PXsT0936
 07QgE72faIOHRSTuA91qmrWvnzY8/tCUthUvkNeZkDxbdzK63YsKNSn3U+fA/alNvHqQuPF8Lmr
 6KzfxCSJiXvN50wzaAuH5CKFGE+fbhmyyHtl0tYoUsBPLZmtOJ3SF8xjoHiOmMKq/NZa8e2gLdP
 jTtAgpbW4/ZF502KCkkdNZisphZzrbduKyerpisWcgYyj9oqRP8FfVCHtTDqsPxub78MQg8LRiA
 =
X-Google-Smtp-Source: AGHT+IEDIfI3INze8eWIOIADXSblh/NNFwPGO+YNXLb6Fk61tZEsuFBXN3l9b5kekOFsJObT101koQ==
X-Received: by 2002:a17:90b:582b:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-3087bb36bd4mr24228876a91.5.1745350113569; 
 Tue, 22 Apr 2025 12:28:33 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 020/147] accel/tcg: Build plugin-gen.c once
Date: Tue, 22 Apr 2025 12:26:09 -0700
Message-ID: <20250422192819.302784-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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


