Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B586CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SF-0004Jp-9x; Wed, 29 Oct 2025 11:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SB-0004Du-Td
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:16 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rv-0002tV-OU
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:14 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b6d53684cfdso6960966b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753056; x=1762357856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sq/TUmwSETrlaqqQV4sQGzo1zOqcOiHNyoh3bdGBVw4=;
 b=swKqLKYrf41b2W64MVesEwFgjbx+MYzdXFrH184hJ3VWtHZ5eTPZ2DC06fo6PDS8Tq
 lazZAqN2VTCMPxM+qi+xgcCgFC+v8vdY4zuyV6yYS1zQyxdqBU8vhOdtd6qYDK0VNtkj
 w2q2WIVc1l+JhCN/xYLYE26yRpioFNrLEuSmk09WqO85mq24rD4hA+jkV0/pIuY+IykH
 HmoO8o/rD88SjYxRK1ix8PV4W50YK09EB4prufxQeiuOgYx+AzKaWfk1KRoG2sQn8SMw
 FvOr+r3YgR8eOwcRCssjgU7RcqLJJvW4HJLqfAVNjvHzkarJciYutii27QDr9ifYnf7H
 xrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753056; x=1762357856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sq/TUmwSETrlaqqQV4sQGzo1zOqcOiHNyoh3bdGBVw4=;
 b=u34Jcp9SZ8DzvjBEjLirAFGRlyR/u1CrTSNovJbvAIQkWVzxtnYlTnowG0k+tqnv3V
 owqfkPF8ETOeYyBJv/q/oNJ6Zun42pHaemPfuMibMjZdMoT6i6HhNIJLBnoSIJIuDvON
 eukJF8Wl+85ApbgmkZdDpxrILNVKUWFj52hIpPIXAjBVYSrA2OnhmX0GtdP3NLA/5XQ9
 LWbUqGs1kZCGvm5xzXY2MwiIL4aW2EQShcq/weVSY4mu8qAZP8Spc0hFMqfMJdGAzv4I
 QzaoQNBtcNyGRqEoFF4kwFFvSrsOqzJRwXc2Al1BgcLXXHOACu7m4IpJMt7hzqhMKGvq
 QcOQ==
X-Gm-Message-State: AOJu0YyQU9lq09ySyk6BQNeNcIc94TUmOehUKP409Yup66pPG3WfafRI
 ud55wrlHDStXxH+zfV/4TjCNpZt2I8pKV2GvgUYWX0IZGWuRzgKKiyv9QLVspSuivNQ=
X-Gm-Gg: ASbGncvmY5Nf+5im2WiCmrkY6Cl6VY3pNj74IKkXPXQEos+xQgNq8lHGhWMfr4ZfUaW
 jN9TPk0SC6P/kWYIVr+2WhrQEE6xJ48StdjZ7YMDlkIEPuZ9Kqjz4S5V6VfrZaIDenI/TEnfL9j
 1OQuT0w2S+RVt83USM8LLNWPeGdS43ba5gPUgb59x2ie7soxxrTH+t+gr+O7+Dz441V4imHRjgz
 HR6yYVJDPxo7KMvX017qBkWXIt3mTGeZCqR3fuY20rO855mpb6fONltmc7cWiQoqgYGndZKB7W2
 hUgV7ioDSUkwMajgpWxNfzjk4eVZKC9rGXHreohTEHf1BS3fPavTNumGVmlliBuxwOOkDltgh4T
 QO67UYkrspoij57W4pN+1G4Urt3z+r8wRjVp6YKX7i/3vHE9dS7q1E7wydiDnstaqpu+KuLJ/IL
 OY
X-Google-Smtp-Source: AGHT+IG74OQPKARQTpIENvif4hlJ0v1eYEstH8OUjhOpOxSQzDx+ELc7GUw1WosxHGQk8lfdgx/i2A==
X-Received: by 2002:a17:907:d8e:b0:b54:8670:7c2d with SMTP id
 a640c23a62f3a-b703d55d49fmr336038766b.55.1761753056365; 
 Wed, 29 Oct 2025 08:50:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d854430dbsm1454544666b.63.2025.10.29.08.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5639460A76;
 Wed, 29 Oct 2025 15:50:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 15/35] target/i386: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:24 +0000
Message-ID: <20251029155045.257802-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places the hook for x86 targets.

Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027110344.2289945-16-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 6fb8036d988..32f2784e923 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -23,6 +23,7 @@
 #include "system/runstate.h"
 #include "exec/helper-proto.h"
 #include "helper-tcg.h"
+#include "qemu/plugin.h"
 
 G_NORETURN void helper_raise_interrupt(CPUX86State *env, int intno,
                                           int next_eip_addend)
@@ -93,6 +94,7 @@ void raise_interrupt2(CPUX86State *env, int intno,
                       uintptr_t retaddr)
 {
     CPUState *cs = env_cpu(env);
+    uint64_t last_pc = env->eip + env->segs[R_CS].base;
 
     if (!is_int) {
         cpu_svm_check_intercept_param(env, SVM_EXIT_EXCP_BASE + intno,
@@ -106,6 +108,7 @@ void raise_interrupt2(CPUX86State *env, int intno,
     env->error_code = error_code;
     env->exception_is_int = is_int;
     env->exception_next_eip = env->eip + next_eip_addend;
+    qemu_plugin_vcpu_exception_cb(cs, last_pc);
     cpu_loop_exit_restore(cs, retaddr);
 }
 
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index f49fe851cdf..667b1c38696 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -29,6 +29,7 @@
 #include "seg_helper.h"
 #include "access.h"
 #include "tcg-cpu.h"
+#include "qemu/plugin.h"
 
 #ifdef TARGET_X86_64
 #define SET_ESP(val, sp_mask)                                   \
@@ -1192,6 +1193,7 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
                       int error_code, target_ulong next_eip, int is_hw)
 {
     CPUX86State *env = &cpu->env;
+    uint64_t last_pc = env->eip + env->segs[R_CS].base;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         if ((env->cr[0] & CR0_PE_MASK)) {
@@ -1263,6 +1265,8 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
                  event_inj & ~SVM_EVTINJ_VALID);
     }
 #endif
+
+    qemu_plugin_vcpu_interrupt_cb(CPU(cpu), last_pc);
 }
 
 void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw)
-- 
2.47.3


