Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29663C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTne-0006LW-8I; Tue, 05 Mar 2024 07:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTlI-0000lW-Eo
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:19:13 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTky-0003H1-I0
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:19:12 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51320ca689aso6735112e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709641129; x=1710245929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kw6JUcERnGErKtDrZC0R6JilUy4T39Q2xkp4LDaFvz4=;
 b=c0MDYANBj3tUv90G2HbytfS7TrzCFzxUcIJ2HDJWtncNOVtJzXAEP4jb+3DXYUcNqX
 zjrtOwfzc4p5LxlipaeE2rQQqJ+VFXM6gIvLABufKiUXfzdQ9m4Q0XxABpeHbFOw9JUD
 Or4WB3oKGZ0Keknk5R5UuMLFkYdxP9PX064STdeABMbisAL/magIKm0uptWMj4aAzGPs
 inWP9Hb92ziS7AuFGwIRUCNBUG7VmhQhT4gzCC8R/vutaIltso6qosiUIybT+0BLJ5Do
 ujT8eGgt6sHuBKVXxOUp5zZGse+QpKJkYy72wNn+xvxyPw7UK9OZFAh61MqpPZSr+2Ou
 U66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641129; x=1710245929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kw6JUcERnGErKtDrZC0R6JilUy4T39Q2xkp4LDaFvz4=;
 b=hvkAY73dMb2ck2wvg9wVKyXIU5/obdaRrxmbI0eaLNyysNbe2rv8GmPlSLeqbg9a4H
 vsKu5YB0NLx4V1SaI3sWGitZabEYFv12NI4zgfxTLGvgKajU6BEq3Pv+LIP7KQL12IBU
 KgpKlgiKvz2qjhtbPunAkflA1R5WUUT40EiKS8zbKGW9dqnVGq49PFqCI8RP+Ia76DNF
 a8IE47X9mhS1oPxBv/l3BDbNOtC2w/SSVmOp3g8IYI6z8fAiZSkQmj1Q5JOA5EVsOn3T
 2uSs6SQy82hfcejr30NuUw15R0RYC9j/I6ChTPcNEpDuIQTv7amMGeb1IEPDvkj272Cq
 +asQ==
X-Gm-Message-State: AOJu0YxXA4JRxZFHpoZ8IuE3EBHLqw1nHYMEaPZI9eBcokeIWe6Imr5t
 M/ZNWm7gcPexNBsLrdHpwgpGVkZrPMGOFB7c0/83JGhX2hP5XukzOn8vCufpApBQ1KU5yZpKHjX
 U
X-Google-Smtp-Source: AGHT+IGIgDyo78sr5q2yjB4OUiehbcjF4u/5+NyYwrnbTpZz9MSK4VzX9BR2yEV5+DSxn2Z8+q4wBg==
X-Received: by 2002:ac2:5a49:0:b0:513:1cfd:14b2 with SMTP id
 r9-20020ac25a49000000b005131cfd14b2mr1215139lfn.33.1709641129284; 
 Tue, 05 Mar 2024 04:18:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o14-20020a05600c510e00b00412aff7874esm17909166wms.48.2024.03.05.04.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:18:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B32FA5F9F4;
 Tue,  5 Mar 2024 12:10:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 24/29] plugins: remove non per_vcpu inline operation from API
Date: Tue,  5 Mar 2024 12:10:00 +0000
Message-Id: <20240305121005.3528075-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Now we have a thread-safe equivalent of inline operation, and that all
plugins were changed to use it, there is no point to keep the old API.

In more, it will help when we implement more functionality (conditional
callbacks), as we can assume that we operate on a scoreboard.

API version bump was already done as part of this series.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240304130036.124418-12-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/qemu-plugin.h   | 58 ++++--------------------------------
 plugins/api.c                | 29 ------------------
 plugins/qemu-plugins.symbols |  3 --
 3 files changed, 5 insertions(+), 85 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 6bbad068c01..4fc6c3739b2 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -52,7 +52,11 @@ typedef uint64_t qemu_plugin_id_t;
  * The plugins export the API they were built against by exposing the
  * symbol qemu_plugin_version which can be checked.
  *
- * version 2: removed qemu_plugin_n_vcpus and qemu_plugin_n_max_vcpus
+ * version 2:
+ * - removed qemu_plugin_n_vcpus and qemu_plugin_n_max_vcpus
+ * - Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
+ *   Those functions are replaced by *_per_vcpu variants, which guarantee
+ *   thread-safety for operations.
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
@@ -309,25 +313,6 @@ enum qemu_plugin_op {
     QEMU_PLUGIN_INLINE_ADD_U64,
 };
 
-/**
- * qemu_plugin_register_vcpu_tb_exec_inline() - execution inline op
- * @tb: the opaque qemu_plugin_tb handle for the translation
- * @op: the type of qemu_plugin_op (e.g. ADD_U64)
- * @ptr: the target memory location for the op
- * @imm: the op data (e.g. 1)
- *
- * Insert an inline op to every time a translated unit executes.
- * Useful if you just want to increment a single counter somewhere in
- * memory.
- *
- * Note: ops are not atomic so in multi-threaded/multi-smp situations
- * you will get inexact results.
- */
-QEMU_PLUGIN_API
-void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
-                                              enum qemu_plugin_op op,
-                                              void *ptr, uint64_t imm);
-
 /**
  * qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu() - execution inline op
  * @tb: the opaque qemu_plugin_tb handle for the translation
@@ -359,21 +344,6 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             enum qemu_plugin_cb_flags flags,
                                             void *userdata);
 
-/**
- * qemu_plugin_register_vcpu_insn_exec_inline() - insn execution inline op
- * @insn: the opaque qemu_plugin_insn handle for an instruction
- * @op: the type of qemu_plugin_op (e.g. ADD_U64)
- * @ptr: the target memory location for the op
- * @imm: the op data (e.g. 1)
- *
- * Insert an inline op to every time an instruction executes. Useful
- * if you just want to increment a single counter somewhere in memory.
- */
-QEMU_PLUGIN_API
-void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
-                                                enum qemu_plugin_op op,
-                                                void *ptr, uint64_t imm);
-
 /**
  * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inline op
  * @insn: the opaque qemu_plugin_insn handle for an instruction
@@ -597,24 +567,6 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       enum qemu_plugin_mem_rw rw,
                                       void *userdata);
 
-/**
- * qemu_plugin_register_vcpu_mem_inline() - register an inline op to any memory access
- * @insn: handle for instruction to instrument
- * @rw: apply to reads, writes or both
- * @op: the op, of type qemu_plugin_op
- * @ptr: pointer memory for the op
- * @imm: immediate data for @op
- *
- * This registers a inline op every memory access generated by the
- * instruction. This provides for a lightweight but not thread-safe
- * way of counting the number of operations done.
- */
-QEMU_PLUGIN_API
-void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
-                                          enum qemu_plugin_mem_rw rw,
-                                          enum qemu_plugin_op op, void *ptr,
-                                          uint64_t imm);
-
 /**
  * qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op for mem access
  * @insn: handle for instruction to instrument
diff --git a/plugins/api.c b/plugins/api.c
index 6470f1dc0f2..8fa5a600ac3 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -101,16 +101,6 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
     }
 }
 
-void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
-                                              enum qemu_plugin_op op,
-                                              void *ptr, uint64_t imm)
-{
-    if (!tb->mem_only) {
-        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
-                                  0, op, ptr, imm);
-    }
-}
-
 void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
     struct qemu_plugin_tb *tb,
     enum qemu_plugin_op op,
@@ -138,16 +128,6 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
     }
 }
 
-void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
-                                                enum qemu_plugin_op op,
-                                                void *ptr, uint64_t imm)
-{
-    if (!insn->mem_only) {
-        plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
-                                  0, op, ptr, imm);
-    }
-}
-
 void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
     struct qemu_plugin_insn *insn,
     enum qemu_plugin_op op,
@@ -175,15 +155,6 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                 cb, flags, rw, udata);
 }
 
-void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
-                                          enum qemu_plugin_mem_rw rw,
-                                          enum qemu_plugin_op op, void *ptr,
-                                          uint64_t imm)
-{
-    plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE],
-                              rw, op, ptr, imm);
-}
-
 void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
     struct qemu_plugin_insn *insn,
     enum qemu_plugin_mem_rw rw,
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 0d8141b85f1..a9fac056c7f 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -27,16 +27,13 @@
   qemu_plugin_register_vcpu_idle_cb;
   qemu_plugin_register_vcpu_init_cb;
   qemu_plugin_register_vcpu_insn_exec_cb;
-  qemu_plugin_register_vcpu_insn_exec_inline;
   qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_mem_cb;
-  qemu_plugin_register_vcpu_mem_inline;
   qemu_plugin_register_vcpu_mem_inline_per_vcpu;
   qemu_plugin_register_vcpu_resume_cb;
   qemu_plugin_register_vcpu_syscall_cb;
   qemu_plugin_register_vcpu_syscall_ret_cb;
   qemu_plugin_register_vcpu_tb_exec_cb;
-  qemu_plugin_register_vcpu_tb_exec_inline;
   qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_reset;
-- 
2.39.2


