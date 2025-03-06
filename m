Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635A9C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVp-0004y2-Dl; Thu, 06 Mar 2025 10:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVS-0004UM-NA
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:30 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDV6-0006km-Eu
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:09 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-391211ea598so631518f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276266; x=1741881066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/DxhRNL6h72ajthgv6sxFLibq8RyJHMeyPI1bV4pMio=;
 b=s2STrUh/p2U9sWuPBU46eDMbI9RPHrw1t95UykA5l0NGhGFIoi39tTW2sw87TOWgM3
 R4Fs/U7ggwYzRBrbxWYPNqlGfQ06zrsopehDYkpMSD4WU6PpEmxzU+cp35Wn+oh0ZgMk
 0mdXTr4GQdXFPb9XsTh2mwy2wMAFl1Ye8h7h0oIInPbWet4S+j7S8xI8nMXOkMPRS2dU
 b9QUql0rYoR5TvPUsKiBynd06VQ2Oiscg4PXRtj4s+aIvU/9qBTkWHNus1y8iS7CaLAF
 GcSFeKpLBQeKhayXXXxgx7C+9+OCb+GeteD4UEYGMgkf5HyBqJsv/MIxkvvJfaCjp4dI
 fvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276266; x=1741881066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/DxhRNL6h72ajthgv6sxFLibq8RyJHMeyPI1bV4pMio=;
 b=NFNOlTjteNMTCg9yABmcCgfEaTyxHxjDWKlSZrGVvXo5yxv0BKcDyyI5r6NqBndhrQ
 D7iQFNaUzGRXQCRaJmeQfI0bY8aLJIY0ce8S1zygHj3duzJ6TcWHkeMW3EjMGacq4s5M
 4eoMW/JhiWuq0CKQ2HCl5lN+XbK+vHG6ryvG2Pd/Jsf2zY0MTwnJQQu6eDxNjDFLyao4
 H/lZCheWk/Wj9+ps2TQmd0U3X/v3LSROQ8v/JZ3CRc5xMvLyqlQIp/rufkYH8Tlccaei
 QCiSmJgNOXEbL1Qkqfk4pue1Tl0hLvRQHrXcYQ+tvJf5vUCLDm7oalVmp++LAPKlMegw
 Lk3g==
X-Gm-Message-State: AOJu0YxpnzgOnplkAwAXJ2l3oma98XSurUCrQsGoiaEzh1Pjj6hKMnpg
 7xPR8d8p2nrnPhvy/7gPjot3pVU48rXhXS6XdST87sipCQFJBSRfbMJPz7+CbcSjs0Dpv4ft0Xr
 VEiQ=
X-Gm-Gg: ASbGnctg2wLLOC8EQFD/YiFbO4kXw2uZTQDrp7yy3jSLo8bOPq6Y1/rsTvsqySaVEZd
 cuw0nIbYH2G+guqp5/0zH8sx5IXenD2WX0E8u8D+E2DF/774GetOi+GRR0kNIFGY+9FyQsWvpZY
 yvBgJn8nZvlMURa3QkHoePfzzNk4bmEUvKYrruZ11gRf6TjaCidQbw9WJfphypL6ygCfDSHn0CP
 vtOlum7OqL92KpGRK2vuLSKDYtOfCWQZagRQw5bwRRXqd4JTfNg0Mo6wIK5aPSFr3prD5h5kG8/
 ExGKVUxT9yw9CZDX9csUNrIFdbFaXLekGy/jcImn0mwh0XEgtBD+Mq86zXp5ShusvyaPYx2T4MV
 igM/Y4wJRxZl4FZIjVFo=
X-Google-Smtp-Source: AGHT+IHfrORliDrZ745y3s294xlXByFLox+pgX87rrNnEB6HGf+3bp0ACQvxZMjcSK8IxkAnvY63Ew==
X-Received: by 2002:a5d:6486:0:b0:391:a74:d7dc with SMTP id
 ffacd0b85a97d-3911f7ce121mr6838226f8f.50.1741276266436; 
 Thu, 06 Mar 2025 07:51:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfbab43sm2453993f8f.15.2025.03.06.07.51.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:51:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/54] target/i386: Constify X86CPUModel uses
Date: Thu,  6 Mar 2025 16:47:28 +0100
Message-ID: <20250306154737.70886-47-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210133134.90879-2-philmd@linaro.org>
---
 target/i386/cpu.h | 2 +-
 target/i386/cpu.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 10ce019e3f8..7882b63b9b6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2327,7 +2327,7 @@ struct X86CPUClass {
      * CPU definition, automatically loaded by instance_init if not NULL.
      * Should be eventually replaced by subclass-specific property defaults.
      */
-    X86CPUModel *model;
+    const X86CPUModel *model;
 
     bool host_cpuid_required;
     int ordering;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ab328485acc..b3e1c2bca49 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6563,7 +6563,7 @@ void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
  * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
  */
 
-static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
+static void x86_cpu_apply_version_props(X86CPU *cpu, const X86CPUModel *model)
 {
     const X86CPUVersionDefinition *vdef;
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
@@ -6592,7 +6592,7 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
 }
 
 static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
-                                                         X86CPUModel *model)
+                                                       const X86CPUModel *model)
 {
     const X86CPUVersionDefinition *vdef;
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
@@ -6620,7 +6620,7 @@ static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
  * Load data from X86CPUDefinition into a X86CPU object.
  * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
  */
-static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
+static void x86_cpu_load_model(X86CPU *cpu, const X86CPUModel *model)
 {
     const X86CPUDefinition *def = model->cpudef;
     CPUX86State *env = &cpu->env;
@@ -6690,7 +6690,7 @@ static const gchar *x86_gdb_arch_name(CPUState *cs)
 
 static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
-    X86CPUModel *model = data;
+    const X86CPUModel *model = data;
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
 
-- 
2.47.1


