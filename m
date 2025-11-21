Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D68CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcq5-0005G3-Sk; Fri, 21 Nov 2025 20:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vMbge-00064v-6X
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:41:13 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vMbgT-0006tB-P4
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:41:09 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so20731645e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763772041; x=1764376841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LdWAJH6s7XticPUwO+/xRlCKqNuhKhU8yKqVINAJxXA=;
 b=ZpRuV3DrHMSL8kGwFaPbXNSNFTzN7Gp8F2H4E/0iwv7aYEHhINBi9IOIzymHGp91Q3
 t7ZtuBoL6Y6O/ahWtC8Qq7q5zTUUPOTBrfYIpWBx+U2wj3x8SkRCIEYOshuL55MjtTTk
 gpiqlrIPr2HBwjOOLzkwo+PZ/psA3xiAHtlwIN038ObhCG5rTuV9yYefPZGyVCCa2Jib
 emhuNFbnqH8Q3QFXa4eJWFPgLH1lZbBAPhgtaWILuVadWbB+Z0G08jbGfkL8IpFjkUZS
 2KgeMa6pg5GWuQp9XvjzGw0G/xk3oSdR1v2xf2mglK9G/F7xt2EP5GCZibSa7u/YwltI
 nc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763772041; x=1764376841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdWAJH6s7XticPUwO+/xRlCKqNuhKhU8yKqVINAJxXA=;
 b=XUvjys3X62R3LKtHjQKpztuEkuHhwhhduFqsdemMtqXwXoXUywecKIt+ysGPoAU99Z
 zFpTs2MX1OgTF2SKEr+9YgFn+qvWCOsQqFS0ci9M+ZKG7wEgkEUBCnFKjHQGIpvqwVDF
 PxBheZeW58lDHejFhj8EbCTT7o+UV3bt4kvgn1ZYMrCXOTuJkmLYa3jYnFpIgkbh0SyJ
 Y/8RhAae8gFNKuTigvSRh+ZmofzfOUXPC2u7I0dgjTg7sMGu7AU8PEvkhNli1F8vLB5O
 bYnEtW2qFdESmtrE+Kuh0A5KxmOgCLcgsypIUVx4uY1EOm2Fo1fu2Fy77GY0WmS6VnOQ
 mhvQ==
X-Gm-Message-State: AOJu0YznUjoy3Tx5QtglMh4OThXqjfp2cI8EhI4dVFEpAVWvasDeehUK
 XqWFGi0PNBPthK2fE13sfI1zN9lITE5iqC58zKmliMYRteKEeBK7QXFj5qiGlFAogn9doWHqdGD
 cx8Ry
X-Gm-Gg: ASbGncvwDvg9HZ5oAYA2tv1Uim/w4R5VRnp8mmv7JSnFBsOWFzg2n86IeG6ao/yk80s
 AVXvKs90Ugy8f4u0mnQtkGxUzZoD5It9otEHWlJMI+W69cqVgBvrND4RnAem8+rZGhsbLDafoD7
 g86Drb5fkj714T0DUsoQiycrhJvxzOq3uwFD/0lZgURjcMNsLEg9rGaz0jPcVdbqLRbEfUHJd40
 +5SiVQC3m5vVhZyZAlf8OgrJ/PatgDWQoYRYorxjkIO6Da+3t0WapA3NEvA0oe76oRG4Nltt3q5
 vj3hag+GNwLzEjLX41ksYt/LYyoT1f/bjcHv5BOYrsVEoB52XNFlniJsLkKAAw2hV+aIOZfpLbw
 HIuIxjhCW1aiPTde5z27UcjM/Y5tWsU+u5OMoB0l1EODYXr5V+xLLS1uFz8114cgR99fRhJHbEX
 DQaBNgl+zGhjY=
X-Google-Smtp-Source: AGHT+IGdaEJgL4z9YyY1O9xJYAAayq2BOL8yrGefufK0H1u6XZHEI5QaPTIkycSFEuXJXrJbxG2xHg==
X-Received: by 2002:a05:600c:a07:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-477c10523aamr28667635e9.0.1763730205762; 
 Fri, 21 Nov 2025 05:03:25 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3af0e1sm40285325e9.10.2025.11.21.05.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 05:03:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D0755F841;
 Fri, 21 Nov 2025 13:03:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH] plugins: shorten aggressively long name
Date: Fri, 21 Nov 2025 13:03:17 +0000
Message-ID: <20251121130317.2874416-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

The old name comes in at a 51 characters, contains at least one
redundant token and exec is arguably implied by inline as all inline
operations occur when instructions are executing.

By putting the name on a substantial diet we can reduce it by 15% and
gain valuable white-space in the process.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/qemu-plugin.h    |  4 ++--
 contrib/plugins/cflow.c       | 22 +++++++++++-----------
 contrib/plugins/howvec.c      |  2 +-
 contrib/plugins/stoptrigger.c | 10 ++++++----
 plugins/api.c                 |  2 +-
 tests/tcg/plugins/discons.c   | 18 +++++++++---------
 tests/tcg/plugins/inline.c    |  6 +++---
 tests/tcg/plugins/insn.c      |  5 +++--
 8 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 60de4fdd3fa..29663591ebf 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -516,7 +516,7 @@ void qemu_plugin_register_vcpu_insn_exec_cond_cb(
     void *userdata);
 
 /**
- * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inline op
+ * qemu_plugin_register_inline_per_vcpu() - insn exec inline op
  * @insn: the opaque qemu_plugin_insn handle for an instruction
  * @op: the type of qemu_plugin_op (e.g. ADD_U64)
  * @entry: entry to run op
@@ -525,7 +525,7 @@ void qemu_plugin_register_vcpu_insn_exec_cond_cb(
  * Insert an inline op to every time an instruction executes.
  */
 QEMU_PLUGIN_API
-void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+void qemu_plugin_register_inline_per_vcpu(
     struct qemu_plugin_insn *insn,
     enum qemu_plugin_op op,
     qemu_plugin_u64 entry,
diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index b5e33f25f9b..cef5ae2239f 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -320,14 +320,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
      * check where we are at. Do this on the first instruction and not
      * the TB so we don't get mixed up with above.
      */
-    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
-                                                      QEMU_PLUGIN_INLINE_STORE_U64,
-                                                      end_block, qemu_plugin_insn_vaddr(last_insn));
-    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
-                                                      QEMU_PLUGIN_INLINE_STORE_U64,
-                                                      pc_after_block,
-                                                      qemu_plugin_insn_vaddr(last_insn) +
-                                                      qemu_plugin_insn_size(last_insn));
+    qemu_plugin_register_inline_per_vcpu(first_insn,
+                                         QEMU_PLUGIN_INLINE_STORE_U64,
+                                         end_block, qemu_plugin_insn_vaddr(last_insn));
+    qemu_plugin_register_inline_per_vcpu(first_insn,
+                                         QEMU_PLUGIN_INLINE_STORE_U64,
+                                         pc_after_block,
+                                         qemu_plugin_insn_vaddr(last_insn) +
+                                         qemu_plugin_insn_size(last_insn));
 
     for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
@@ -355,9 +355,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         }
 
         /* Store the PC of what we are about to execute */
-        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
-                                                            QEMU_PLUGIN_INLINE_STORE_U64,
-                                                            last_pc, ipc);
+        qemu_plugin_register_inline_per_vcpu(insn,
+                                             QEMU_PLUGIN_INLINE_STORE_U64,
+                                             last_pc, ipc);
     }
 }
 
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 42bddb6566d..c60737d57f1 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -321,7 +321,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
         if (cnt) {
             if (do_inline) {
-                qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                qemu_plugin_register_inline_per_vcpu(
                     insn, QEMU_PLUGIN_INLINE_ADD_U64,
                     qemu_plugin_scoreboard_u64(cnt), 1);
             } else {
diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
index b3a6ed66a7b..68c0ed432af 100644
--- a/contrib/plugins/stoptrigger.c
+++ b/contrib/plugins/stoptrigger.c
@@ -73,10 +73,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
         if (exit_on_icount) {
             /* Increment and check scoreboard for each instruction */
-            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
-                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
-            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
-                insn, QEMU_PLUGIN_INLINE_STORE_U64, current_pc, insn_vaddr);
+            qemu_plugin_register_inline_per_vcpu(insn,
+                                                 QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 insn_count, 1);
+            qemu_plugin_register_inline_per_vcpu(insn,
+                                                 QEMU_PLUGIN_INLINE_STORE_U64,
+                                                 current_pc, insn_vaddr);
             qemu_plugin_register_vcpu_insn_exec_cond_cb(
                 insn, exit_icount_reached, QEMU_PLUGIN_CB_NO_REGS,
                 QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, NULL);
diff --git a/plugins/api.c b/plugins/api.c
index eac04cc1f6b..267fa2fd503 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -154,7 +154,7 @@ void qemu_plugin_register_vcpu_insn_exec_cond_cb(
                                        cond, entry, imm, udata);
 }
 
-void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+void qemu_plugin_register_inline_per_vcpu(
     struct qemu_plugin_insn *insn,
     enum qemu_plugin_op op,
     qemu_plugin_u64 entry,
diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
index 2e0e664e823..1348d6e5020 100644
--- a/tests/tcg/plugins/discons.c
+++ b/tests/tcg/plugins/discons.c
@@ -156,15 +156,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         uint64_t next_pc = pc + qemu_plugin_insn_size(insn);
         uint64_t has_next = (i + 1) < n_insns;
 
-        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
-                                                            QEMU_PLUGIN_INLINE_STORE_U64,
-                                                            last_pc, pc);
-        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
-                                                            QEMU_PLUGIN_INLINE_STORE_U64,
-                                                            from_pc, next_pc);
-        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
-                                                            QEMU_PLUGIN_INLINE_STORE_U64,
-                                                            has_from, has_next);
+        qemu_plugin_register_inline_per_vcpu(insn,
+                                             QEMU_PLUGIN_INLINE_STORE_U64,
+                                             last_pc, pc);
+        qemu_plugin_register_inline_per_vcpu(insn,
+                                             QEMU_PLUGIN_INLINE_STORE_U64,
+                                             from_pc, next_pc);
+        qemu_plugin_register_inline_per_vcpu(insn,
+                                             QEMU_PLUGIN_INLINE_STORE_U64,
+                                             has_from, has_next);
         qemu_plugin_register_vcpu_insn_exec_cb(insn, insn_exec,
                                                QEMU_PLUGIN_CB_NO_REGS, NULL);
     }
diff --git a/tests/tcg/plugins/inline.c b/tests/tcg/plugins/inline.c
index 73dde995781..35307501105 100644
--- a/tests/tcg/plugins/inline.c
+++ b/tests/tcg/plugins/inline.c
@@ -244,15 +244,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         void *insn_store = insn;
         void *mem_store = (char *)insn_store + 0xff;
 
-        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+        qemu_plugin_register_inline_per_vcpu(
             insn, QEMU_PLUGIN_INLINE_STORE_U64, data_insn,
             (uintptr_t) insn_store);
         qemu_plugin_register_vcpu_insn_exec_cb(
             insn, vcpu_insn_exec, QEMU_PLUGIN_CB_NO_REGS, insn_store);
-        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+        qemu_plugin_register_inline_per_vcpu(
             insn, QEMU_PLUGIN_INLINE_ADD_U64, count_insn_inline, 1);
 
-        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+        qemu_plugin_register_inline_per_vcpu(
             insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_cond_track_count, 1);
         qemu_plugin_register_vcpu_insn_exec_cond_cb(
             insn, vcpu_insn_cond_exec, QEMU_PLUGIN_CB_NO_REGS,
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed8..b337fda9f13 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -147,8 +147,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
         if (do_inline) {
-            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
-                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
+            qemu_plugin_register_inline_per_vcpu(insn,
+                                                 QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 insn_count, 1);
         } else {
             qemu_plugin_register_vcpu_insn_exec_cb(
                 insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
-- 
2.47.3


