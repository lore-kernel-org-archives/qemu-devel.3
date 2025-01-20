Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11208C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZymk-00061r-NA; Mon, 20 Jan 2025 15:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tZyi5-0007PV-2Q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:49:25 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tZyi2-0006Om-Tt
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:49:24 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2165cb60719so80775595ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737406161; x=1738010961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k61SOT55tEchcCOAJasCWVeJl795sl3BG5VEaxPqZrA=;
 b=AKqxVdGYXeK8FP0ZaLhYR2TfEL5DxKzLqRtoRVJ/djqJhLCSXAQTWGEwHb/Tx9V4hX
 TUlCvkkuayTtGfQN4l3cUubkGTdpSrg5nMkyTk9vH1Ag/SAyoe1VKW2OeqqoMs40ViJu
 VcvLN3fsa8ouRINyYR2Ho0Vw5B8s6iXWD8LOux4yTSNQvVXZK4aeFPNmHj3F2XPqeEAo
 w3dph8OuT+Wy+wPzc6lpW5vppD3qnJ1cgZxzSHvYf78QiPJDGf1vrjw5Ko3kLOGaizHF
 uFe8OGs3k4r8rWnCqvsJTizuzKfoPrxQ3YH0BD09bXFfNEBugOmJBlVNSOx59gobqimu
 Nwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406161; x=1738010961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k61SOT55tEchcCOAJasCWVeJl795sl3BG5VEaxPqZrA=;
 b=sY6dNH2g2PzirZpckNoYNU9zOJ1xa3C16SlCJGj0ZnRVa8kbX7Q6CzUzvgvQvuje0t
 F0ueTLXUG8SOCMpuP+bfIruJv258Qjry4640TMB1ELARU0CiVogTH4kShV5ugz3NXIXm
 8TiQ3HKyQizAAoakSABogiSyk5mCW9aJJBXXtpSHcdLJ90U8mEz0JR0oSjBi5IjjngA/
 bqUB8sQY5vHfrG6bDdiPHMe3MlLko6XN7Ao7PAM5VDRmycLjiUxs2nYs6XLQnGR/DBGw
 px1RtS32OlxWS4647BLmR5x2wq8GW7KdTwDYTHv2nTaeBjQtJYwIr9H9Jtun0V67snRJ
 dABg==
X-Gm-Message-State: AOJu0YxyS0M9p1eHdD1p1qDkYwunc91s1GnfAjXadjB1/dSBs0VQRegf
 7SDYJdz6x5VsWRiQA2gmHhf3UQt3DTclHSZl49YhvcY/dIJ52qX/1kAtEv1ry/GcJtkjqnj8wr4
 J
X-Gm-Gg: ASbGncup7HzdqUGjJiSr6CZRz9uVUu6Vamvx/hOn+QoZqP6/KvJgnSyq8rcIe/6I3i4
 Hj1OIGXe6f8yYTQwvQx9nmz55HCBzUul2e3FB4iw2uyhOepp2AAmwAwoO/5rZSCL7kfTQSsDd+x
 QJVJ3AxHET8UtMC9nCopdkJQ1WijWObhsLxCqPpQFJR5MN4irYPxxdyKH6/tRXD3LP+W+wG9i5b
 8Zuyqw4xNKNhwC/ROh9S2cOa6jxdUqIWxa2wwba4VEMf8GelrcyTn/QwDQ+hgc+CJIIv3ytmQ==
X-Google-Smtp-Source: AGHT+IGtuukGcSUmWnykLMPXW8Lx6HsIlWQ8GcCSKIGy785sd6lHUQ6LpW3YTlEHnvNrY4HP6ixtuQ==
X-Received: by 2002:a17:902:fc48:b0:215:787a:f91a with SMTP id
 d9443c01a7336-21c355eabe6mr257812495ad.44.1737406161159; 
 Mon, 20 Jan 2025 12:49:21 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea08e4sm64865025ad.7.2025.01.20.12.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:49:20 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/2] target/riscv/debug.c: use wp size = 4 for 32-bit CPUs
Date: Mon, 20 Jan 2025 17:49:09 -0300
Message-ID: <20250120204910.1317013-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250120204910.1317013-1-dbarboza@ventanamicro.com>
References: <20250120204910.1317013-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The mcontrol select bit (19) is always zero, meaning our triggers will
always match virtual addresses. In this condition, if the user does not
specify a size for the trigger, the access size defaults to XLEN.

At this moment we're using def_size = 8 regardless of CPU XLEN. Use
def_size = 4 in case we're running 32 bits.

Fixes: 95799e36c1 ("target/riscv: Add initial support for the Sdtrig extension")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/debug.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index f6241a80be..9db4048523 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -478,7 +478,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     bool enabled = type2_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
     int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
-    uint32_t size;
+    uint32_t size, def_size;
 
     if (!enabled) {
         return;
@@ -501,7 +501,9 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
             cpu_watchpoint_insert(cs, addr, size, flags,
                                   &env->cpu_watchpoint[index]);
         } else {
-            cpu_watchpoint_insert(cs, addr, 8, flags,
+            def_size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
+
+            cpu_watchpoint_insert(cs, addr, def_size, flags,
                                   &env->cpu_watchpoint[index]);
         }
     }
-- 
2.47.1


