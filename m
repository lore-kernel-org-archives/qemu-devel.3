Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132A8C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTuO-0000Q2-8f; Mon, 10 Feb 2025 08:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTt3-00085i-GS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:31:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTt1-00065L-M8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:31:45 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43948021a45so5837435e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194301; x=1739799101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVG9LleBgVUQXQy5aq+er1NbCMyLlUd6s760Io8ryMc=;
 b=t1ZKdIMwaHQA2mPC2qpzDgphzl0qyd3twds2/45l5vbpHPd0Pqcoz0i+4wq5QZLpnK
 iU7IWL2z02sGHH91U1u7oXzhV0RFAnSDrA2SA+tM/v2pHISrCQgo0BUdzPZvsLmflqo4
 HUkeCvLwK0wfG3343MaYLzl7tbZNEnk816gYLY7s287KWkgM1waRIbM0wwWQAOgtUIlr
 d+Nnq/WdWz5Pv4Cs1DZUQScB6A/mNU1OBqbhKkgO9pWrRrZPprpdWDFdYXw81xgpXVto
 aZg+keo3/0G4ZeJCHnjRbovNM9U/SsnNhkZKV1RLguSBj3CtA9iNlcw88rao/4B8wvNr
 GYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194301; x=1739799101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVG9LleBgVUQXQy5aq+er1NbCMyLlUd6s760Io8ryMc=;
 b=B7hzbD+lIzoCpj1Q5/D3zTlwSuHtQGlQWP+VmAWZ+7Q3S477E6D25zbXb31av6Z2jA
 b6/HAvEt96dYUhAfEp+AjGP9UFgsqnFwVPjg4YSTPs6aHMjIEQdjZGbook0ACLdfB15A
 jbIHxT+3J9AF5IQPnf+6OSz8MKSGx2Gv94tk8ppBnRRXNgNFXKps2+AM1yueDKK8SxqK
 f28mlgYlLArvLzT9ZqB5IF2EXKlB0/PxKr5vVWLQuc/V7C4HHCgYXyo7fqqFuAndYOUk
 B/JAK1mVWe7m00tDx4n7Nlo3g79ubYd1OPSV6+wZcdg7CLFMxErtnY3wogDt0PisjXPy
 1k6Q==
X-Gm-Message-State: AOJu0YygcIIEy6bCMFxwkvKy4knxExmvKpsMtfVFh6bpD42GF0pFLJZM
 yZM2dRGpheTBoQP3rTSQ/TdXuP17MphAFzXETA7CLzB0h3NgtE6Pd+gPCxa4OGRNuty2EF6ks6K
 W7RU=
X-Gm-Gg: ASbGncsscSfLvM55gSzAfSkYM5Q70ozAfkZuTb03P2FSM7xdQHodx5AMPhVvIUKwL+l
 ENnx9G5mKEyk+J7H48dTvm8ySolG105vMhSTN95NUO2bgVOlbaXaKxNbo5V0ACR4qGV4FHStvJo
 Czoi/oMXE/NZj5SPH2MGt9PJDWb44RjLbicqGCMZzixSqK/g58Z8k9jrFTKjreYxFD0VhUeUPyF
 qpjyirVeJa99ZgJMbApdsDbAp2wsbbHH15JNN1nUw+JX1TjfDWsTayQL3ptrULz7IpOWlZgucCf
 MS+9XrQa59RoXS6TwpgiAfB/mKTVhvAtzEeOT2xpAtPgdFxGbkGTfVNJSXTbMrxUbAttbBU=
X-Google-Smtp-Source: AGHT+IG0yhrlyVEd+hFqzg2RXipAj1y7ia32IeCHs6zDWxv5vFKlBeMNvc3N14xmZn5Lp9slk4K8sQ==
X-Received: by 2002:a05:600c:4254:b0:439:30bd:7df9 with SMTP id
 5b1f17b1804b1-43930bd7f9fmr59531505e9.9.1739194301407; 
 Mon, 10 Feb 2025 05:31:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf4438sm185433705e9.25.2025.02.10.05.31.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 05:31:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/11] target/i386: Constify X86CPUModel uses
Date: Mon, 10 Feb 2025 14:31:24 +0100
Message-ID: <20250210133134.90879-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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


