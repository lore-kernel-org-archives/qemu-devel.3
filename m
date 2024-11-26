Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C13CD6554E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 19:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG0pK-0001hU-1l; Tue, 26 Nov 2024 14:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0pI-0001dQ-0l
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 14:02:20 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0pG-00030n-1Y
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 14:02:19 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ea6f821decso5104622a91.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 11:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732647736; x=1733252536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fciZBZFx7H12wEpRAgDGyrQsACWT0gMu0Jx7arFxq70=;
 b=L2YexA6eawAHQEzNrGmd6T1a4Qdwij5APsaM3FRimLXMDkqfPjRqkHlabiqKS4ND+s
 8+WPIukq3xCf1vyzpFy1EO+EyRpa8cbVKZ9iEnbVm0EB9UBzUhPINVCc14BVTzJWBmKt
 FvV5l7xTjMcxJyqF3rviTAdfXJ1QNdWqE8v/nD9pELFoQVKpQvlatVis+tvGtlhOor2l
 irhnvMV+zmRc5CPCfseoshxH6ZJ2Z2umu47JtXWOwW6B65YjSd1WjGWdfTDnAfbOTihK
 Qjvz+QVJD06o6B8TPCMmXa3PKBvtsg/LBxnNIHiFKjjpVU0Ez6IITgEvX3QKAHDCh+YD
 Y5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732647736; x=1733252536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fciZBZFx7H12wEpRAgDGyrQsACWT0gMu0Jx7arFxq70=;
 b=JHxx7pINfKteuRz61wjKpK0lzRamjSlh5LwY1RfpgK/GRQlwsPxSWATxiPXo5QAvMF
 LA1spWx2vcOADLYqZJVkD+GQAowTr3hhevmpSd3cZ4qMojP+50BFhvxRV9rqkWieeXl8
 sJ5Bq+fJC7xDYP+WbW6uYdt2kzwjzyrOGVAB2TN9vcAs4F1lnM38ZDG5quu+mIfkepRs
 8ZGIkRiH76eklAyStWcOAZh11qjrczUnMv0XPXO4/mnA6uNd9i2dsAIlosKjeMy1W/Ac
 +MciykPeWiE4dUWNu7bvknIYU2ssuLHdvoINeOCJuv1MF03dy+FqDkiFxyhaNhph/fai
 ErdA==
X-Gm-Message-State: AOJu0Yzv8DJ1ysRIWnQwfqGGnaWG9L5AR6WpU2jFZsWHWKUubc2xuZWy
 6kxueTuJoauaddFk3WU0mLruhJcWDgWx/y7RzCM4DAjdN5xmhxv0NcWHu9W8699BGz5M6HunfPO
 CPHg=
X-Gm-Gg: ASbGncsRhmKUT1rx62t+shiSfJhOt7uNlywfjWD1+FUFpxDyy3xj7mlD0juNBjz+/bi
 lmbQfOGcLLGrNdF04RXXw4ug+zfuQcf17YnirUxC2VhNmIJJGTciLDs2FoODCjqnNvu++Y6gkdZ
 G6Hea/yKV91XRc+/KxuckNxJ1jhCa8fLCjqBFKagIWeQa+NPLiawhhDjsujlI+bmgcYb6htBQbJ
 glVLzb6t8fhjo9HVxg0V1D0euuSGT6hRl8Q/ppb4WxXLzYPnyNBfOoOXxECPL0l2FC/dZpGuJC8
 U3AKJh2fJImTqA==
X-Google-Smtp-Source: AGHT+IHIU6ItMIPtThpFR4gs0xXwui8NAnkbLaFnaaPqhvFyc7fPqkXJuhvTkh40IeWpwjhHTqmMIQ==
X-Received: by 2002:a17:90b:4a:b0:2ea:c2d3:a075 with SMTP id
 98e67ed59e1d1-2ee08ecd9f0mr531990a91.17.1732647736466; 
 Tue, 26 Nov 2024 11:02:16 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2eb0d048b73sm9187834a91.35.2024.11.26.11.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 11:02:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH] plugins: optimize cpu_index code generation
Date: Tue, 26 Nov 2024 11:02:03 -0800
Message-Id: <20241126190203.3094635-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

When running with a single vcpu, we can return a constant instead of a
load when accessing cpu_index.
A side effect is that all tcg operations using it are optimized, most
notably scoreboard access.
When running a simple loop in user-mode, the speedup is around 20%.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c |  7 +++++++
 plugins/core.c         | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 0f47bfbb489..2eabeecbdcf 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -102,6 +102,13 @@ static void gen_disable_mem_helper(void)
 
 static TCGv_i32 gen_cpu_index(void)
 {
+    /*
+     * Optimize when we run with a single vcpu. All values using cpu_index,
+     * including scoreboard index, will be optimized out.
+     */
+    if (qemu_plugin_num_vcpus() == 1) {
+        return tcg_constant_i32(0);
+    }
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
diff --git a/plugins/core.c b/plugins/core.c
index bb105e8e688..8e32ca5ee08 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -266,6 +266,19 @@ static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
 
     assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
     qemu_rec_mutex_lock(&plugin.lock);
+
+    /*
+     * We want to flush tb when a second cpu appear.
+     * When generating plugin code, we optimize cpu_index for num_vcpus == 1.
+     */
+    if (plugin.num_vcpus == 1) {
+        qemu_rec_mutex_unlock(&plugin.lock);
+        start_exclusive();
+        qemu_rec_mutex_lock(&plugin.lock);
+        tb_flush(cpu);
+        end_exclusive();
+    }
+
     plugin.num_vcpus = MAX(plugin.num_vcpus, cpu->cpu_index + 1);
     plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
     success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
-- 
2.39.5


