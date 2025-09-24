Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E93FCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Upa-0001Sm-BU; Wed, 24 Sep 2025 15:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmC-00072A-SB
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:42 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkD-0007vJ-IV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:40 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-32eb76b9039so184258a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740488; x=1759345288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agxaWfpnEWArDK9o57t/fXwGBS1U1BVOfgrXUxLn8BM=;
 b=vQnKKPqURx5N6BcUgDQRVyx2Vlb0zhagl5arvesJUuqV+uAnU0GE7/UOio8cRrf7zc
 oxwTwjx8F2VHQreh9HFoux0XrKX740uZdA9G+BMP+1+cBkbfTTT2tvS1P2LIYAUlmXJe
 X/AZKTa9mXtJko21wNnNiFIBwirjDFf/gGLFONtrewVSGb4nFKuKeMcTc8vC7TJozx0W
 NR0H8RbHCGI5cg/NyIiaFlJTaDTgv7beJ1eHPJH+jQwTbsDf3KAb1nMn6i2b6j1Kq1+D
 8BxJ0bNhWyzt1cZ32hrfZk7TykBD+bmLOIV0D/ydhl62NG+QZfVjCyFuwKBd0/KGfNF2
 SYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740488; x=1759345288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agxaWfpnEWArDK9o57t/fXwGBS1U1BVOfgrXUxLn8BM=;
 b=GM5ubu7sFrdCRJ05dpUclCDCG6zlizPpCCiXyZfmn6g7c6JFOG6O4WeluYqLJz69ef
 ENZPSfI0qIt4KlVos0K6cAJdnr4gQIDrHCLovBepib2bCowkwAxDXCOzEmJjoUHLHl0a
 Z6saxuAa4kiZ5iStQiI+7YQJNUEz6r0RiwzMMufjX6EhX+zdNE9Uhz9IG0+NfFI2DHhj
 2gmv18tfRoVPFDKhAQigr+1qFcEAnjUeV09Chto/7IK9OCGJbAL8YNVJGauuVWRhCku6
 W+7oJFAIHFnEedk5lEPL/em1W5HtyFlp34H/gJKzv5jXsz034YNcL90B5Pf0oCVUbyeC
 nhHg==
X-Gm-Message-State: AOJu0YwOaqMRXe2m5vPwxr9cnKNAUtB2Q2voFLpknJWiG/KH1obJqh2P
 KvHBlY8oqEzCwgchu6xd164TYHmte+8OtqMk9dLxVpBUURRuhMkd0SnQlW/HSaQ7puw6DZ7MvaZ
 1lRJB
X-Gm-Gg: ASbGncvZBqiWggv3qXkXdjBFfvv8EWjPiToXQOdVmVpY36/3CHljVl+09YzYaURPnPf
 rY65qzm6hkf9p0ck4G5zfrLWf32G0SqoHNN34wr6TrFSBLucth59vCDqq/xwzlhXJsKgdKLNVqd
 z5e5QMOIO0GAwGCjizk+KHcp27pP/UYLdbyjitd7fqn3dG4Ln0huQmbb9Z55K4EwpWCuNq2acDp
 4xYlGMI5bc83AYJugrLXT3YWVqsCYuF9E5Lit654P8+LR85dV0SEE6VQui29xtFuivLKyWcmhEv
 EKqMznnUk6LFh4PZe887GNB6qs8H0I6ZX26JUPNG2EvLDn+zdZzh2QyleesX3qgVOq4DM5s7LOI
 Pn9W7WHCb6wHDZX5qHvx/2HbD938m
X-Google-Smtp-Source: AGHT+IEJMrkorSpNyd1up5txbfb7tr2Z0M6ccwtLH2UvY2r8hprh5ymbsPIpkVgn8K2MOF9Hy/mOjg==
X-Received: by 2002:a17:90b:1347:b0:330:6edd:9cf with SMTP id
 98e67ed59e1d1-3342a2b0f1fmr678957a91.22.1758740487709; 
 Wed, 24 Sep 2025 12:01:27 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/32] plugins: Use tb_flush__exclusive_or_serial
Date: Wed, 24 Sep 2025 12:01:00 -0700
Message-ID: <20250924190106.7089-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

In all cases, we are already within start_exclusive.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 4 ++--
 plugins/core.c         | 6 ++----
 plugins/loader.c       | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 9920381a84..1ffcb4b2d2 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -102,8 +102,8 @@ static TCGv_i32 gen_cpu_index(void)
     /*
      * Optimize when we run with a single vcpu. All values using cpu_index,
      * including scoreboard index, will be optimized out.
-     * User-mode calls tb_flush when setting this flag. In system-mode, all
-     * vcpus are created before generating code.
+     * User-mode flushes all TBs when setting this flag.
+     * In system-mode, all vcpus are created before generating code.
      */
     if (!tcg_cflags_has(current_cpu, CF_PARALLEL)) {
         return tcg_constant_i32(current_cpu->cpu_index);
diff --git a/plugins/core.c b/plugins/core.c
index c6e9ef1478..ead09fd2f1 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -248,7 +248,7 @@ static void plugin_grow_scoreboards__locked(CPUState *cpu)
         }
         plugin.scoreboard_alloc_size = scoreboard_size;
         /* force all tb to be flushed, as scoreboard pointers were changed. */
-        tb_flush(cpu);
+        tb_flush__exclusive_or_serial();
     }
     end_exclusive();
 }
@@ -684,8 +684,6 @@ void qemu_plugin_user_exit(void)
      * with the one in fork_start(). That is:
      * - start_exclusive(), which acquires qemu_cpu_list_lock,
      *   must be called before acquiring plugin.lock.
-     * - tb_flush(), which acquires mmap_lock(), must be called
-     *   while plugin.lock is not held.
      */
     start_exclusive();
 
@@ -705,7 +703,7 @@ void qemu_plugin_user_exit(void)
     }
     qemu_rec_mutex_unlock(&plugin.lock);
 
-    tb_flush(current_cpu);
+    tb_flush__exclusive_or_serial();
     end_exclusive();
 
     /* now it's safe to handle the exit case */
diff --git a/plugins/loader.c b/plugins/loader.c
index 8f0d75c904..ba10ebac99 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -377,8 +377,7 @@ static void plugin_flush_destroy(CPUState *cpu, run_on_cpu_data arg)
 {
     struct qemu_plugin_reset_data *data = arg.host_ptr;
 
-    g_assert(cpu_in_exclusive_context(cpu));
-    tb_flush(cpu);
+    tb_flush__exclusive_or_serial();
     plugin_reset_destroy(data);
 }
 
-- 
2.43.0


