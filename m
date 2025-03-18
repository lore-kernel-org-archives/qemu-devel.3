Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8627AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueXz-0001H6-V4; Tue, 18 Mar 2025 17:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXo-0001E7-4s
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXl-0000ij-DE
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:15 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2255003f4c6so110619775ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333532; x=1742938332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jprqwHHwWojdGfQ1QgUvwGwX1dYcnH5RZgYMJfPxUv8=;
 b=d7gEwzjo1cC5IG1mJ/NCqtA9TjCE/8371QGLgp0An+SOvsq5HeB8FYTcfez/JkWi4R
 lycxqkkekN/+j+P7w3tpErpwjqa4M2OQhcxabXjO3pJY1xC3aVZIcodiFEfTxc5I80T6
 v8oA8chnZGyWCt4n+5KvGN93SOq+sTNjiqAsQavc+vtdI8bGrj4optKj+7+JBicjwXKe
 UkwyYoqtTL5Pyg+2N/35crot0L7I1twJu3RIDAi/HYXqnwLN694gmaGuALOzlCxWUGIP
 jqm8yrFYhKYLjGXLHNd7QjT7ApT7zK+Z3e2rB/6EB7KFZ+fX+40i8ToLxuqqbZFRQrzB
 7KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333532; x=1742938332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jprqwHHwWojdGfQ1QgUvwGwX1dYcnH5RZgYMJfPxUv8=;
 b=u6BtYajxvYWL2JVS2bM8QKPIkEsyAWIUHG7CPqETiFD2L1Xo6aHMoC/+leCJqGdbVy
 Wk9tpsbtuDZ1tRZ6cOa7O8rMpumP4025owaCGIDN+DvJJ8U7KSxuJ9V6m1Ej8IS5olXf
 o0IVFDEpvQYs6v3CVzSfuGVaZD+9UhyofTg/UYYCmNrTdMHpWi1bhP63BnlqB6A/LWxS
 ciahnRdP/MypDditPZ+iQH2D/U+QH8+V1PU13JisEKreF/BN+mRKd863cd8RRVS91Sj7
 pM8pynfnnA0tmUH66Opu0GDBt/Kj9Ut3PM6EE9tKjBIddjdqLYAY6qPG9qZJc+DYfY40
 EPAQ==
X-Gm-Message-State: AOJu0YyvYh8f8lLEPweul2/qnK0nxWfIfW1ij3ZY6UrnxdgYmRIJOB9p
 AfK/IREoPGJ7S683HkOfNKvrVvfVqw6OlmDq0jwzDWucRVYN0Jl8mJ7R0+5BHYH3Pd4UTtntLuW
 q
X-Gm-Gg: ASbGncuz/cUNuKNGhO57/Xy3MGfEuO9qr1OKHkbnEdxc44yUGvv0IA6gGym864qa4tT
 nOquOnLqn/fSYzXnMs/XjhsTE9baMccHi89sNaXEU2iUXI0n5XgKvJM65PieIEUaFcbBqfkTgsO
 1DMgXySvkoDi2DpMfEtKr+BxsASs+ZTQDl3j709tNKNAxc5uXZEZsJKwICHHPJyKMdLo/rrW0I5
 jMq5tOJaZA0UDBaVoGqI9GRvrfwYGghJnK/hHWnFEs0aL9Tp4q5Mczrwlxrx1sjKrU4B2X6A202
 sD04z+3i2Jj2Xj/gINq06uGzdhW1lPmMERInQTnvm5DN4UrRXcunecKNIiryRjyTPSWjKLMKKq4
 /
X-Google-Smtp-Source: AGHT+IEIu7/GyDOFiencuZ7Et5MffLNubTjeEPnPaSdzazQaR35jtlX7FcAMcwBwT1eve4gDkXx0/A==
X-Received: by 2002:a05:6a21:a44:b0:1f5:873b:3d32 with SMTP id
 adf61e73a8af0-1fbed503e74mr260397637.39.1742333531951; 
 Tue, 18 Mar 2025 14:32:11 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 02/42] accel/tcg: Build plugin-gen.c once
Date: Tue, 18 Mar 2025 14:31:27 -0700
Message-ID: <20250318213209.2579218-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


