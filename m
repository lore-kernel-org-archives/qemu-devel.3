Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2F1CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ay6-0006Kb-F3; Tue, 23 Sep 2025 17:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay3-0006JK-OV
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:35 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay1-0003iq-Kr
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:35 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-25669596921so66114935ad.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664472; x=1759269272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agxaWfpnEWArDK9o57t/fXwGBS1U1BVOfgrXUxLn8BM=;
 b=vwXymSI78IiAI2AxtCUS+jznz8GWLTDekjMSCYOwxoAmqAMzJWV5U0ElbLENRthYSM
 yn8by/1klWEiSK/nqdBGwHFVt9MvcRtrEwJBhodrMZbmW43ssR23bg+zKiPDnRlg8sHI
 NTAn1z7X/6BL1Ufs+2P03Q4oPbpBUBo5LnCL31P0k/qDVP94cexQTRhtA235OjwAlOmX
 E9xcYvLrhEFslyusVtwzDtho6Qf6wkQ620RtYO0Xfa0/OYFEo22M2xtBP8TRQCr0zBuU
 bvLvXI4+AE1H5eJtCbPrpxsjHRzTCgPrQockn63LfxtlooZ5vRVptyRSWAUdJzCxVez7
 XPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664472; x=1759269272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agxaWfpnEWArDK9o57t/fXwGBS1U1BVOfgrXUxLn8BM=;
 b=BQjuqiWCE12cRZghkYpNq6J3b1SFbq+jV0O4Z1KOr1cAdbNVdMFEHCw11ZVyEOuvnu
 d/8YODhazU5/gKVfEaC5dyqFVHngYxVlZYC0ubcG1OpKuHhg9gc26UEnrmvzcFTzxq7w
 89IOBdNk49kjnxmNP9MrvMTEznTaWZ/JgrYmfBFue2IcARQ15XO9FnfOglblnLA/jylJ
 GPG8CQdUjigQS5xcDw9X+kdnJ66nNxWkshJ8E9nIWrbQszAKsuE6HdK4qOmojyFUkrpD
 4WuZvUXKwZF1KPQikd5c/lqlbJj/BDv0tOc8EZC4Vkzc726etpT4+87M+R2T/Q6HmY+S
 phpA==
X-Gm-Message-State: AOJu0YwKKxLPff4TZeSFFMqdhhDSPbW0N1YVvUMkprN4sVnC06QMvNaR
 x1N1ImKol9h9Zc1Ri+PjuTrUsNR8sPeECqTzntxewOmVEy6z9uU3tAVyl1gEU079S/TB8g2KGnW
 e0hkt
X-Gm-Gg: ASbGncvbqK0MTxRzLKcCu0Pk76bMiNhesaj6Hv6IjxlrzNd8Xw3hjtdgzXNYAo6P3h4
 TG4NNVuCUsFzQVfAXYDRZW0r/H97MqcGubHiWuPcf/HxfuYnSJNMolJu2aPNrqGDBBGsiH+ACe0
 0mXNgnJ6W+DrZxsOIv/MIRdPUdkUviau0hFDqthiMppTrWgHBBv12q2YzQoRjdXimT9Q7Kz7/KT
 Cs4lQqtRfkc3IgLgEsyOirMLpAkPlQUBcArEm2QSUDJNQyOvGPyb9VjUUxENd/8z37BfDVXHLVp
 IDpFFH370VFzjMuwFzYn39oVfDxWRjTDHAmoktHYgDoCp7VRX5aB98vf0ip27mINpCTwNr4R1rc
 jiAwKjyXWUCuV0zRxwpyi5mfARCEW
X-Google-Smtp-Source: AGHT+IFN1KQmevhSJzTkMXAQS3kwzeKmbbwBoUbN9ZX/MarJ5D1El0pGkznTm2Llh1bvT3QwGEbLLQ==
X-Received: by 2002:a17:902:e5d0:b0:267:a231:34d0 with SMTP id
 d9443c01a7336-27cc5623567mr45497615ad.42.1758664471926; 
 Tue, 23 Sep 2025 14:54:31 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/10] plugins: Use tb_flush__exclusive_or_serial
Date: Tue, 23 Sep 2025 14:54:21 -0700
Message-ID: <20250923215425.3685950-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


