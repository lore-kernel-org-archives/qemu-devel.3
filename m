Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2265C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKMG-0002yv-0u; Wed, 12 Feb 2025 16:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKM3-0002wU-DX
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:11 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKM1-0000U3-JP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:11 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso1278955e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739395987; x=1740000787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyHOKWoeSC403uuReOzBJ6t1qCvcqW/3Uih7M9Jpk2E=;
 b=cOOETH3OnexnE+4Wo6fGkn2kycG1c8dHUar70lXeXc/xH2LPOt6bzFq5bCr0BIwWyA
 tHk+HfVYoJDlU2nuXCrQ71adnZT6bV1wP8yWc4RTqoj663WIbreHhJ4N99yBicclfSzu
 YwcJfZBr3A4ayyQVAFK/kg0AT82PZywSVM1Euvkr5UFWMq0dlEuANWOtaMqp6Rma4LnS
 pR7wLwL6haIKALLN6uapynaq8CfO9ogShsSQ9C2z4lRcpNsiCnnLw94DuRB0+Uo/CBRt
 svH5xZ2hftTCiLNRrsLhFirbCT44ummocCtZFO8IsTYX9hmbNxfYoh9zFkElvXBDhtVs
 vmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739395987; x=1740000787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YyHOKWoeSC403uuReOzBJ6t1qCvcqW/3Uih7M9Jpk2E=;
 b=m2V1ylha202kttzAzh0o1GddtDHj93D9MW1QX6aq9XOmvxLfOR3uHiN69CXe8YykwV
 axO9ei8bISqZsF4Aaay7LdCn+6HaoyN0smMsErSYijgi/Hkdr6QYvb2oko4pA6aygUBv
 uGwJcJEZru+MDOrrwh4FfvdSD80mPJ+Z30VQMWoprNYx1lOOEInsJAF0z4dJ2hPbr48g
 3u9ILDDsaKiaJxPl/cwmMGISdajPCFT3l/WVKLxL0+UdlAz3JZO4yDOtx/DSdBfR6JLA
 PFSERZtWOmozjm3ZTY+cNB+XYv8K3aM+hIZQjkfuuDVk5CQqeVe1iD2umlpcKca0RZQm
 XWIw==
X-Gm-Message-State: AOJu0YxD1QS8qDekaJeBQ5yXhSU7ntLUcuPgR0/8LEgJp7vIcFScOU4p
 fE56LesIoy3hYGOVy1Xz+PccbfHdStn9ZwcZai/hniJNJlpuY+Mk9DClJWgRyUZPyzreOdVMrlq
 mppo=
X-Gm-Gg: ASbGncuL1cUZOzt5C8kN3mnBD2pGPRUtk609RI/nYobx4EZs9o7VkKQNCwXSss6SjAc
 T1iFLfig7etu9tlI2AHyVO35C7sobU3JH6sYl/MJT1qe2JCXrY2oxJUB0LMYgqmpIZgOtNZIWK0
 Dfyjygby+un+KZvuKHSU8zIvbU3fshERDTZ5UJQx5ulaPLVTbrHOv1H3olNHmwUzm5TWf9667Pm
 qJU9Voka8x1jEroDCl/2OBR7IoMgvu0uIdRNRO3ijeckQ4qLvtfRznviEFXqLi3YCxj1cI7Jivs
 5ojdKJY+VOgAja1eKoDsGy5mKfostSJ+1ZGVoUS22TtgQnVI+V7gcRPez3LZdMlszA==
X-Google-Smtp-Source: AGHT+IHkxQCCpkTO0KjUXBnkOH/jnfo+/JzF8rC7b2kEDpvgCkn9QRMy1WgTH5GNNYKuNAtuTfszfg==
X-Received: by 2002:a05:6000:381:b0:38f:230d:4c77 with SMTP id
 ffacd0b85a97d-38f230d4e90mr1116619f8f.46.1739395987325; 
 Wed, 12 Feb 2025 13:33:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7987sm20517f8f.87.2025.02.12.13.33.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:33:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/19] target/i386: Constify X86CPUModel uses
Date: Wed, 12 Feb 2025 22:32:33 +0100
Message-ID: <20250212213249.45574-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
---
 target/i386/cpu.h | 2 +-
 target/i386/cpu.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c67b42d34fc..f9ce6970ee1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2288,7 +2288,7 @@ struct X86CPUClass {
      * CPU definition, automatically loaded by instance_init if not NULL.
      * Should be eventually replaced by subclass-specific property defaults.
      */
-    X86CPUModel *model;
+    const X86CPUModel *model;
 
     bool host_cpuid_required;
     int ordering;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5dd60d2812..4b2da45366b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6436,7 +6436,7 @@ void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
  * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
  */
 
-static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
+static void x86_cpu_apply_version_props(X86CPU *cpu, const X86CPUModel *model)
 {
     const X86CPUVersionDefinition *vdef;
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
@@ -6465,7 +6465,7 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
 }
 
 static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
-                                                         X86CPUModel *model)
+                                                       const X86CPUModel *model)
 {
     const X86CPUVersionDefinition *vdef;
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
@@ -6493,7 +6493,7 @@ static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
  * Load data from X86CPUDefinition into a X86CPU object.
  * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
  */
-static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
+static void x86_cpu_load_model(X86CPU *cpu, const X86CPUModel *model)
 {
     const X86CPUDefinition *def = model->cpudef;
     CPUX86State *env = &cpu->env;
@@ -6563,7 +6563,7 @@ static const gchar *x86_gdb_arch_name(CPUState *cs)
 
 static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
-    X86CPUModel *model = data;
+    const X86CPUModel *model = data;
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
 
-- 
2.47.1


