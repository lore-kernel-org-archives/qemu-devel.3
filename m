Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14273CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL24-00019X-Dy; Mon, 27 Oct 2025 07:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1l-0000oc-Uh
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:48 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1Q-0005gR-DP
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:41 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63c556b4e0cso507704a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563037; x=1762167837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+B5t2CS/T8KjhtvrkR91LD1xXhHenjI0bMGIecipr8=;
 b=GgXLmexawwlsv/1igkmwbYEFBzAoXdecLpStTG1L3LsljiasGqe4uPKBmgV1kbQuQE
 G0ThAwNrXqXtm9ncpITlV0XBqnIlacEhBhjCmvc/BgQIYNfb9ofYmYZRwO7cgJTHda0d
 yzvd3C/Y3AJD0tJOgh73/Jx4TRFecgWg9htWO4P7e3OZZE930pXN8HMFNLV1pNMt9CoS
 dLX9ciEgX9a7lVjKQ1F+aujPJC7Ot0jk3Ou4XpnyQNJHr+wTEOU6jmIZdSkLBLdWLTR5
 DrDwId+mZ8hXcWSQIrwj1/ZgHb896cMKEvPGIBJxsJthEuYNanQObj3K/id5odYZF4mo
 X/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563037; x=1762167837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+B5t2CS/T8KjhtvrkR91LD1xXhHenjI0bMGIecipr8=;
 b=C1jnzpq4uEfUqzPzjcCubO5yx45ZOm167NEeBUQjG94ZxqMRlOBA4m/YXQR0WLx5kX
 Z35xBY9/G2OfQ3H0BmQKW5Dc+m2Xc7+QLW/HBLiVPvY8483JoHeOhPR+4pce6KEkWzEF
 jyYq+bp2l3q8SXBhGN8TX+4qWE7yirJ+FO0wvjGn+hDHjJYSu4j/ejZ/HDowGxtTJcKK
 y/klt12vyJ6RaisdnBUtRTxoLuFpa09fDjnEPna2HZAAE+lSbtmE41M32g5GA5849Llu
 TdOXabtDlYwAv9IzuLRAQ7kawFqIg0ExsA95aIXdZl3ocLg319pUguOYsJE2kCjkIeew
 Fvxg==
X-Gm-Message-State: AOJu0YzZPs3NvOM7fTjYVEK4vSfGrC1yKfCHCmCnSnayEXU2rxEs7UDC
 MwMO5RZMQKX/nJZMM7LSp45i6apxLLib2PA3R0BRhGVpTiryf93lGT28WReCtKzjx68=
X-Gm-Gg: ASbGncurqNcQOQZK42nUITALGW6cBbuSGYHd9gNvnqwk/HNvMaA5QClCwvMLapmL+Pu
 bG2nyUCsur5WTk48Idib6ALudGR+feHANeoMN0U6tDYxOuw8vqg5WZN+YJzNnlLmhIDfqpdd4ZE
 w349yG4Thg4To18Ab5kfzkbxSFX8QZCsoeDmX7EjpeFLmyVql/R3MzAxZL+MX367CKx/yipU6HR
 qvzHv2gp7FU8mzwSrwkm6lvprd4SodOjaWQjeqC+nLUkqR8P/Nen5DZNLc6JHIgqBNYD+U7EGad
 OnlGdF5NCCctUFRyGbQXgvlrmObOXNkXPl1KGl/8f/Z80k7+NsTrUitu9JRfu2zAn/mM+sCd4Cm
 OVgqyS2dumoovw/Gc96L/MycDXdOgHwLqYBA4cJsVgr7COBNc+rd87ESmdXl1AlwupJFzkUQM4g
 ayR+/+v5nft3s=
X-Google-Smtp-Source: AGHT+IFOqsFhi++XSrIN3tvwX7vv/Rng/GC5ur0yItPZWJFnvIrwnw8USTNuYmK9pTg/cUeHEl2iog==
X-Received: by 2002:a05:6402:5650:b0:636:6801:eed7 with SMTP id
 4fb4d7f45d1cf-63c1f6d05b1mr25599778a12.32.1761563037184; 
 Mon, 27 Oct 2025 04:03:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efb97b3sm5942298a12.30.2025.10.27.04.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A56E160C1B;
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
Subject: [PATCH 17/35] target/m68k: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:24 +0000
Message-ID: <20251027110344.2289945-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

This change places hooks for Motorola 68000 targets.

Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/m68k/op_helper.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index f29ae12af84..e9c20a8e032 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -22,6 +22,7 @@
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "semihosting/semihost.h"
+#include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
 
@@ -183,6 +184,21 @@ static const char *m68k_exception_name(int index)
     return "Unassigned";
 }
 
+static void do_plugin_vcpu_interrupt_cb(CPUState *cs, uint64_t from)
+{
+    switch (cs->exception_index) {
+    case EXCP_SPURIOUS ... EXCP_INT_LEVEL_7:
+        qemu_plugin_vcpu_interrupt_cb(cs, from);
+        break;
+    case EXCP_SEMIHOSTING:
+        qemu_plugin_vcpu_hostcall_cb(cs, from);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from);
+        break;
+    }
+}
+
 static void cf_interrupt_all(CPUM68KState *env, int is_hw)
 {
     CPUState *cs = env_cpu(env);
@@ -203,6 +219,7 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
             return;
         case EXCP_SEMIHOSTING:
             do_m68k_semihosting(env, env->dregs[0]);
+            qemu_plugin_vcpu_hostcall_cb(cs, retaddr);
             return;
         }
     }
@@ -239,6 +256,8 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
     env->aregs[7] = sp;
     /* Jump to vector.  */
     env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+
+    do_plugin_vcpu_interrupt_cb(cs, retaddr);
 }
 
 static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
@@ -277,6 +296,7 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     uint32_t sp;
     uint32_t vector;
     uint16_t sr, oldsr;
+    uint64_t last_pc = env->pc;
 
     if (!is_hw) {
         switch (cs->exception_index) {
@@ -417,6 +437,8 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     env->aregs[7] = sp;
     /* Jump to vector.  */
     env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+
+    do_plugin_vcpu_interrupt_cb(cs, last_pc);
 }
 
 static void do_interrupt_all(CPUM68KState *env, int is_hw)
-- 
2.47.3


