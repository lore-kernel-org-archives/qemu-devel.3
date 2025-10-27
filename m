Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BFCCCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL9n-0006jy-Ft; Mon, 27 Oct 2025 07:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9i-0006gV-EX
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:54 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9D-0007c4-6E
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:54 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63bea08a326so6450069a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563534; x=1762168334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOIWat0zdvoLqu/dm2Cji7uUG0JRvbRh67vkFVnoxR0=;
 b=iW9VegSAwyykgu1vq5W01FUJ+YhkX1BGgNjBs5vO+zMsZ8rdB22gmk5TSYHQKl6T/f
 eQCsfRpQ3j7FDGy5IE9SCKTCDEHagDVfOZ5VqrGIn3YbMaruOIqv9zSZ4BzXsXZnNljt
 WBOwU1O7agn7NLuOZkOcrknciSyHMIP9thIv8mrO9uKrgI8BWRbD47L83bJ/e/gdMlJE
 8U6CfdNp4PRMAKcsbpkV3HMLFkJRMJ+X3FD33Tn/QeIP1QpCWM7DQID1Ronhj6FqV/2S
 SsVu4PR1BPNJBF//UxJic9HKvzb7XsrLw4KAm4RNX2Tn9xF81x487ICYlV8KH12IrIZh
 5ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563534; x=1762168334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOIWat0zdvoLqu/dm2Cji7uUG0JRvbRh67vkFVnoxR0=;
 b=HJUM88/TUH8USh8zmJ7CqF547dHrTOj5AWXsTGHIzGT66uYjSo2BRSyDYzRBZZa7/k
 YXmzjfI9UBND4VGQDcsbDFySdDFF7glqfIVdzyFda8ielPxj2teuf6wWWcOuoUVllh3U
 IKCsdpKs0b+9bDpf59yId2mMeNCZ3IyaLmMGWlnRzM2VneKGXzZ2D9WBDLscv78kg2LM
 RNMd2A90omzjq5mrBjAhqTaYdZzo16FMK5vfoToq7O/E0ZtyTdZ4J6pyfnaSX4lqHPO4
 lUPCiK+7c7dRFAEwrrL6vqqs3MtCmnGqAxpKSj7QaD77/BJSAKkBGrVgoSQCpH1I9RSX
 sXFQ==
X-Gm-Message-State: AOJu0Yw51ImSf5Q4AFV7O9bF1wEleaC1CZWzg9z4Yah99qhxzUXTNa5v
 RkguCeJYqmAfVU9PNDgOFvQOUFVJs9E3QrdDH33PIj/XyL9X/+EghlQ7v6QmHuTP5rg=
X-Gm-Gg: ASbGncvB7WeF8bfq3dpnDMyl8zVdgXDxF9Vd+zcvqkhaJlajZ/b+2Jgnq5nmO76KMuR
 A6hAFIFYn2sl0gxG+sf8kHBKc8N1QsckvmvvmCyZhgrDoSu8W0isHq3hh0wJRTpIjnstyxrh4ph
 FRCL4oR8S0O2kTTlOFgGhzQ99Bfj+ykzSdoqVYLiTnnsDUEwNzk+RQuEOKtF+BGCnKKWLjJlPEm
 2GxveYD+YBVr6TbJUC0+5gXXiVqWTvg9DX5QcOcIFepyiTZ/ogQQtZAcIf6ia0785Q6yfQXfYTm
 ojA13Ok5bsLaoKcHPDFPe9bINibpaGZMuFVpAYvA3t94oP4QNMcuOeozJG4E69ky/sf0OosoTHw
 VU3k7eZgM6cwAP1q42O6l/YnLKgkDDeeuz97ZgzCCcagXT9uo7FqecOrjxQIAGxrhEQ6ZmhHjZQ
 scDp9hQe1/zr4=
X-Google-Smtp-Source: AGHT+IG7xohgDbdCZpEaQql0WKu05/9DRCJ7c6eaYimOVb8vqucvzuXNIHI9wIYvrcQfxrfUbcLyJw==
X-Received: by 2002:a05:6402:4504:b0:634:ab34:ed40 with SMTP id
 4fb4d7f45d1cf-63c1f580cf2mr34888236a12.0.1761563533781; 
 Mon, 27 Oct 2025 04:12:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef95cb9sm6162733a12.17.2025.10.27.04.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:12:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC74960CB8;
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
Subject: [PATCH 18/35] target/microblaze: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:25 +0000
Message-ID: <20251027110344.2289945-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places the hook for MicroBlaze targets. This architecture
has one special "exception" for interrupts and no host calls.

Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/microblaze/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index cf577a72268..a1857b72172 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -27,6 +27,7 @@
 #include "qemu/host-utils.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
+#include "qemu/plugin.h"
 
 
 G_NORETURN
@@ -35,6 +36,7 @@ static void mb_unaligned_access_internal(CPUState *cs, uint64_t addr,
 {
     CPUMBState *env = cpu_env(cs);
     uint32_t esr, iflags;
+    uint64_t last_pc = env->pc;
 
     /* Recover the pc and iflags from the corresponding insn_start.  */
     cpu_restore_state(cs, retaddr);
@@ -54,6 +56,7 @@ static void mb_unaligned_access_internal(CPUState *cs, uint64_t addr,
     env->ear = addr;
     env->esr = esr;
     cs->exception_index = EXCP_HW_EXCP;
+    qemu_plugin_vcpu_exception_cb(cs, last_pc);
     cpu_loop_exit(cs);
 }
 
@@ -152,6 +155,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     CPUMBState *env = &cpu->env;
     uint32_t t, msr = mb_cpu_read_msr(env);
     bool set_esr;
+    uint64_t last_pc = env->pc;
 
     /* IMM flag cannot propagate across a branch and into the dslot.  */
     assert((env->iflags & (D_FLAG | IMM_FLAG)) != (D_FLAG | IMM_FLAG));
@@ -256,6 +260,12 @@ void mb_cpu_do_interrupt(CPUState *cs)
     env->res_addr = RES_ADDR_NONE;
     env->iflags = 0;
 
+    if (cs->exception_index == EXCP_IRQ) {
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+    }
+
     if (!set_esr) {
         qemu_log_mask(CPU_LOG_INT,
                       "         to pc=%08x msr=%08x\n", env->pc, msr);
-- 
2.47.3


