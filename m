Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBCEC54E55
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsSJ-0008Qq-9q; Wed, 06 Mar 2024 09:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsSC-0007tV-Ah
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:08 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS6-0001Vq-AK
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:07 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d146737e6so5398563f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736059; x=1710340859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEf14uJYxbgFMCoXRLS0Jki4pRXZFLa5uR3yiXxdk30=;
 b=B+k1MVf5wxQZR74Q36tRW2SIx8TPREdsxuP63ESt79CzCWLMK12cp1ov8hIY2lar0g
 tK8U5qTR2enQmF7++tyWyD6UDc2quUzdWnkmC6sshReqj5QhjRy9QD2FRFmeYdeHusvs
 Kiz2Kk32JdnBQPQNCZzp79q4fq7nunwdYKpmwOQPVr9yph/YdFKzZ+YnDRzPDydNM4du
 ydEPEOLWeZl3P1haUjtpeZdYkemDvsUL6+ah+FsZwtxN1KbS7+rqKfSDNvb1E4Ol2+rF
 s8rAgDl+OXAxfyU18K/P2JvgxDLmDXQ2ag+3CoSoFKuSY5oxjfcElTQGOvCsb1zssC90
 Ildw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736059; x=1710340859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YEf14uJYxbgFMCoXRLS0Jki4pRXZFLa5uR3yiXxdk30=;
 b=I/ueC7BNib0UZg2vmgY9ZY98N3ki12S6cWgWLwBbPHhR2HPFlMRxU+6+ITt6I9OdTC
 l762mRZ2AQHqzVgSLB2/6wx190MIL02OY/chVbXxBCVxUyzwv3qpylGnD/y+NgKvkPDW
 pqMlE+tX8ZpyxOLSmjaedwFfHKkFFYiVEhN++ifwkLhR9LOk8Bno1IXTbTBw46v2orqW
 Bso95l2roEMjPAB4K4HXie63QzFI81nBJBBEQvS+CN4ZauPG2t5HfYmmV3gN5gwi5g4A
 iFshudlvbU6Riiy59WbcBYHkUoJB21bp+1THN6LBFxSY6B7dcK7BAAqc6rIPihkhi4H9
 lWLg==
X-Gm-Message-State: AOJu0Yy4ghxGG5As7DF+sHGGk+G4FOqt3tCVdOULR/uh8/2mtzSXHcmZ
 IDb5AhuIHXCiGdUFiYg+F3LQrotYvLZuBii9LBq7aeur8B3+PFnNxq2jMqcNIKo=
X-Google-Smtp-Source: AGHT+IHAY9hcDxAgZ1GLN8woakH1H8WbjQe8m7RA1rxtNuD2wGywztTOjt8OkMafhypMKH6tlYqxUQ==
X-Received: by 2002:adf:e44d:0:b0:33e:1629:651d with SMTP id
 t13-20020adfe44d000000b0033e1629651dmr10244734wrm.15.1709736058915; 
 Wed, 06 Mar 2024 06:40:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g1-20020adfd1e1000000b0033e3a24f17esm9242234wrd.76.2024.03.06.06.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BBE4A5F9EB;
 Wed,  6 Mar 2024 14:40:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 24/29] plugins: remove non per_vcpu inline operation from API
Date: Wed,  6 Mar 2024 14:40:36 +0000
Message-Id: <20240306144041.3787188-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20240305121005.3528075-25-alex.bennee@linaro.org>

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


