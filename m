Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AF9C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUJJ-0006yU-7a; Fri, 26 Jan 2024 17:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJH-0006xO-QK
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:27 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJE-0003Nu-Ij
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:27 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2cf4696b90fso8375371fa.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306662; x=1706911462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44vj1U77cG8ByngsPLkvtVP46j6F/SEPuSA1albtNLM=;
 b=Qdg5POseFn96pizitSylgPijIrzKPtAg0qpl8eWI0nT7Z/FgAQsngbiFY//li5o8L+
 klriDw5oNLLb890mf1Xp4lD5lOxg+IZDaxaVS9gv4OkIQc5mdkqMiGsXUqu3EwT7c40A
 fP9CXIvDOerUomCyx3PlEFmjkavPI7R1QSlki+DeLucz6y1KyL80rY8ZnXkPnOYg0yjW
 dAKdwXmy3RGXPrKZ5UzD7oqMtezV9fhClDnfDbEh33CHq3HjWtTaC1gxY47zVVO698rl
 Kjb+g9fGUh1L7Z1OPVFyZUozS7bMs4dqBknTjfv4vOGVeC+eiRD3BjMuC8wCjQ/80+DC
 VzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306662; x=1706911462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44vj1U77cG8ByngsPLkvtVP46j6F/SEPuSA1albtNLM=;
 b=XK070mZHLGn3kHEy7Wy6LoSiMJl46cJ5q0i/PycXzquPeRB3QxOWBgm7psUi8kCLqO
 N/fbufZdlDQgmZmEn1L8A7v0Eyq95n1Tc7SG/7HMdfQCVfzIdnniBbqgbSfYfA49YonY
 azo0y49s3wJNbAILgToavmdgti3r4gtLt1TBDD3Sd5aakKF6T8Jq8voIhSRsc8cFByG6
 T5bkBDTYOtLUBwowalEJEGmt44nF7/pSUwAEK7TTTgKCYrBlSZiI2ENnRcp3lsnktx+r
 HKmfhcpqpDSI1zR41bqdwWCFVWz/Y4g0GCMx9Urxd8xi4Xq+5QZXy/SNpR/Jhz4wh96t
 6tbA==
X-Gm-Message-State: AOJu0YytcQYn7QZTKgiLBPt9Y8phm2XOAoEp36yvQLC7TlvSMCLQzRGh
 bQ5x9JxuuGhj8JT8dEM14KP7A9irZ4haTWyeszm4/Mx2KP5TnWiNWvsMJ+IKFg8gRuI1330/5DS
 O
X-Google-Smtp-Source: AGHT+IEnfgWYNd5eOLvLxcXg8k3YinEkfDQvcjv1CL6+umhezAI8wEelphIMVoflH/5EHRA+97EafA==
X-Received: by 2002:a05:651c:1a29:b0:2cf:127d:a79f with SMTP id
 by41-20020a05651c1a2900b002cf127da79fmr334833ljb.51.1706306662283; 
 Fri, 26 Jan 2024 14:04:22 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a056402180e00b0055920196ddesm1004348edy.54.2024.01.26.14.04.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:04:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/23] scripts/coccinelle: Add cpu_env.cocci_template script
Date: Fri, 26 Jan 2024 23:03:44 +0100
Message-ID: <20240126220407.95022-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add a Coccinelle script to convert the following slow path
(due to the QOM cast macro):

  &ARCH_CPU(..)->env

to the following fast path:

  cpu_env(..)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                               |  1 +
 scripts/coccinelle/cpu_env.cocci_template | 92 +++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 scripts/coccinelle/cpu_env.cocci_template

diff --git a/MAINTAINERS b/MAINTAINERS
index dfaca8323e..1d57130ff8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -157,6 +157,7 @@ F: accel/tcg/
 F: accel/stubs/tcg-stub.c
 F: util/cacheinfo.c
 F: util/cacheflush.c
+F: scripts/coccinelle/cpu_env.cocci_template
 F: scripts/decodetree.py
 F: docs/devel/decodetree.rst
 F: docs/devel/tcg*
diff --git a/scripts/coccinelle/cpu_env.cocci_template b/scripts/coccinelle/cpu_env.cocci_template
new file mode 100644
index 0000000000..462ed418bb
--- /dev/null
+++ b/scripts/coccinelle/cpu_env.cocci_template
@@ -0,0 +1,92 @@
+/*
+
+ Convert &ARCH_CPU(..)->env to use cpu_env(..).
+
+ Rationale: ARCH_CPU() might be slow, being a QOM cast macro.
+            cpu_env() is its fast equivalent.
+
+ SPDX-License-Identifier: GPL-2.0-or-later
+ SPDX-FileCopyrightText: Linaro Ltd 2024
+ SPDX-FileContributor: Philippe Mathieu-Daudé
+
+ Usage as of v8.2.0:
+
+ $ for targetdir in target/*; do test -d $targetdir || continue; \
+       export target=${targetdir:7}; \
+       sed \
+           -e "s/__CPUArchState__/$( \
+               git grep -h --no-line-number '@env: #CPU.*State' \
+                   target/$target/cpu.h \
+               | sed -n -e 's/.*\(CPU.*State\).\?/\1/p')/g" \
+           -e "s/__ARCHCPU__/$( \
+               git grep -h --no-line-number OBJECT_DECLARE_CPU_TYPE.*CPU \
+                   target/$target/cpu-qom.h \
+               | sed -n -e 's/.*(\(.*\), .*, .*)/\1/p')/g" \
+           -e "s/__ARCH_CPU__/$( \
+               git grep -h --no-line-number OBJECT_DECLARE_CPU_TYPE.*CPU \
+                   target/$target/cpu-qom.h \
+               | sed -n -e 's/.*(.*, .*, \(.*\))/\1/p')/g" \
+       < scripts/coccinelle/cpu_env.cocci_template \
+       > $TMPDIR/cpu_env_$target.cocci; \
+       for dir in hw target/$target; do \
+           spatch --macro-file scripts/cocci-macro-file.h \
+                  --sp-file $TMPDIR/cpu_env_$target.cocci \
+                  --keep-comments \
+                  --dir $dir \
+                  --in-place; \
+       done; \
+   done
+
+*/
+
+/* Argument is CPUState* */
+@ CPUState_arg_used @
+CPUState *cs;
+identifier cpu;
+identifier env;
+@@
+-    __ARCHCPU__ *cpu = __ARCH_CPU__(cs);
+-    __CPUArchState__ *env = &cpu->env;
++    __CPUArchState__ *env = cpu_env(cs);
+     ... when != cpu
+
+/*
+ * Argument is not CPUState* but a related QOM object.
+ * CPU() is not a QOM macro but a cast (See commit 0d6d1ab499).
+ */
+@ depends on never CPUState_arg_used @
+identifier obj;
+identifier cpu;
+identifier env;
+@@
+-    __ARCHCPU__ *cpu = __ARCH_CPU__(obj);
+-    __CPUArchState__ *env = &cpu->env;
++    __CPUArchState__ *env = cpu_env(CPU(obj));
+     ... when != cpu
+
+/* Both first_cpu/current_cpu are CPUState* */
+@@
+symbol first_cpu;
+symbol current_cpu;
+@@
+(
+-    CPU(first_cpu)
++    first_cpu
+|
+-    CPU(current_cpu)
++    current_cpu
+)
+
+/* When single use of 'env', call cpu_env() in place */
+@@
+type CPUArchState;
+identifier env;
+expression cs;
+@@
+ {
+-    CPUArchState *env = cpu_env(cs);
+     ... when != env
+-     env
++     cpu_env(cs)
+     ... when != env
+ }
-- 
2.41.0


