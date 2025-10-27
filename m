Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6911ACCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL2B-0001HV-2B; Mon, 27 Oct 2025 07:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1y-0000zh-32
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:54 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1S-0005g9-5H
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:53 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-63bdfd73e6eso10284696a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563036; x=1762167836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tc/ncHQ43H5RAM4g98aEerDqB5nJ7XC9XRTlxHTgjE=;
 b=RC6W0lZoe2DPpgJuvPbnkpvI2CHFJov4P0RbMXSvPm5HiBQeFPMU0tGjvk1zxiVRET
 jhJMbdR6idwvZX3aHQREyEDAHhx085ycv1byqAWs4uwawbAMwPjmT/otbcOOTBZccD7M
 EV4FqvKtJ/oOV5gbVkR/QKr722By5jaOjkaTmB3iF4320yERYvkYadfvKwJjIdR3qL5f
 NQo1t+HspSB+QYfao4l82rlR01T8yr4hz12E5phYJbNQUQvu/qnx7GWKtKhujEt4hoSu
 lOULW40XFfd5detS3bPn73JF88QKM4rFezPilpqVPGhhJ91Ljcc/hRxMpkMuMQ0mmeOo
 Trkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563036; x=1762167836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tc/ncHQ43H5RAM4g98aEerDqB5nJ7XC9XRTlxHTgjE=;
 b=dvRh3ZYFHTHvz5MnELTf1uGbGGlSAy/8dwRW+8YDhFpzMo4aRCtoh6o8KBvOZwMSZ9
 6UUKNo/lmedMur5ePgm1YtansSZJaDyjU7dI9GXGoTk7+rSa0YEl/jk+4Ww4g//3cogJ
 J8bF0U9q72H3vNuF8utC84lT7XAP1EOjwnVZTxySHYbU1OzkNT3XNoTFdfBDfCuvJeIP
 6BTLyp5CjumHXY7tri5dFEIdQsZINa8A097D1kTao7b5bmgYlKQIkF1M1Z/A2F7JEO8l
 Bshk1bT5MufCQ4ASKceB9Bcy2fboiHkcdJXqDoSjGQq7csnDYfOhHtCrbQ54w0JKnCXG
 44Rw==
X-Gm-Message-State: AOJu0Yy6YC57fhsem1QB3qfvCFLnylTPSLo6uOFz5+sbn1CeCHPvv9Na
 XIq5MgW0AbxNrkyVZ5Acad+B0I2kLIw0NCP4WHSPXCeJiBAEpXxrHL6kZ7F4n8M1gio=
X-Gm-Gg: ASbGnctEaznyfzTwx2804j9PKkQ8sEnE+1mqBqDBuMlL/1qrFvQChynNd3IULv7cYLC
 ZcE3ebeWcdpxEttRK/tM5383RBkex70sFecA0th8RUYlM/8sHBma2XiM9ToySlR6V3CxcyD0Rt0
 NyCETQBcaAMNhtDXooDjvQD00/+nOEk1OT3is0xBcCtAs2LK3KRx6Qi7kphHAJfj3cutCD8ziF3
 mW9Ez/6akDzMnOjQwuc7lZOyki9rWeKj9VtOA8TXN4A7L/BVMFVL9c7rqRQ5/IPTjdVcWUCAsad
 s8xv/7y/opOPdEwkdYiAqAQqIwVmT+67DrkkN5GKOHm7PXw0wIqsvlXqOiVHiklGGCgejxIK9Dw
 4Ck+o19aRGO033zhk/TmPYsoVMniCVL/ZBtyrwPLdpYTI8hWVoksGnNOkyjNkp1mN5Sgb4HcGKv
 fsrt5oO2RfpsM=
X-Google-Smtp-Source: AGHT+IERY0LRDtAh/P/JnbkEdSaGPZN26CjXuTfwQxfSVQ5HKYkzM6nMMAvqidpDE39wy9t9gsU+wA==
X-Received: by 2002:aa7:cf0a:0:b0:63e:6f85:1ef3 with SMTP id
 4fb4d7f45d1cf-63e6f851f34mr5947239a12.12.1761563036495; 
 Mon, 27 Oct 2025 04:03:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efb950csm6163591a12.28.2025.10.27.04.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7AA5F60A94;
 Mon, 27 Oct 2025 11:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 15/35] target/i386: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:22 +0000
Message-ID: <20251027110344.2289945-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/i386/tcg/excp_helper.c | 3 +++
 target/i386/tcg/seg_helper.c  | 4 ++++
 2 files changed, 7 insertions(+)

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


