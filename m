Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8E4E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzl-0004pl-K9; Thu, 09 Jan 2025 12:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvza-0004jg-QK
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:47 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzY-000713-NS
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:46 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so201615366b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442403; x=1737047203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ut5L3H7ENukAVXMf9ucpT4mEYkt3Qt71rdTcSo9h+fA=;
 b=pNeAFtsS07JUQGrjKwQwmhuF9qR1RGXeF3fcCo1I+gLfofvYdPG4NZmelf2jY4QkiL
 39FgRrvQ0TG7ZkcBAxsdpKM4s/pVbS16CaoWzETbeq6/Qnv/iCI9E/inPm2ibHFQlAjC
 TR7i7lHPxI4to9rFIQ6tIUnaYGUH7Lusi1TexKjJYBQB7L99XsQgujx0lREu/0c1dEg0
 AHxn2Qe1HVoTPBWTVyMFC8n6Rq5ojqcUbWQnM8Rw5bRnWlLa1ANbuDS6ksZ+FzTD21iq
 CZxwVzYA21JzATlro2c50oKuokE3tPwGcRQFIYJk3F1s1/9Joe/4xIjyqaNzAY5HuvqX
 WfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442403; x=1737047203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ut5L3H7ENukAVXMf9ucpT4mEYkt3Qt71rdTcSo9h+fA=;
 b=A9CVImicdtzlmfGkqG1xyy8geLgXkeZNuQA1IBCQzv6ud7mRoyqv2jsphsmVu7EGdO
 3kFtsLz++2Mk3IFoFbLook17h7fJ4WAWMpXMPei4BxxcGcfFRHyYkvheF+ErlxQqBtrO
 2U1x1Khz0DxfAQGZoFL2gf+958aSk9QQkoZp2o/3vGILITWgOVf8Ke55Ud3Ep8hnv4sr
 u3gC321T9JHh2o5xUcKfx32dhdK8gVe1TtO9bTKwRm08lnAOqvniGiT7b2o9qrPwNOG+
 C5Ol48G4Npqa8COrdiQGBaXLe/ee/6/gqFegx+IKHR+3zTpmKzZKIfZplzDCrmCw8JBM
 Sl2g==
X-Gm-Message-State: AOJu0YzhP6avJFVJfbW4joBIPte3R6V9hQBXr2RYPIiXwN1HJMUWDlni
 CF+5GDRURN4OC4kYrvSMnDlcPZr3yXxS0CqDyEqE3VhFxSz+Dz7rbD9LsaGhZf0=
X-Gm-Gg: ASbGncsEexvFagnPyTUP1APjDvKTJvZ92smEWUaBWQRP9r/nX++qchc9R00VzcVeAs6
 QY3IGkcTmudj6otDk+D4v5fVS5aJZtksUhpaVAUlvQgNvuCRcZREAdgQW7OndB32ixK7s3Ejml/
 Q6x6mSjJW+Z1HYcvL5rkXCdnwPr9s10vfaV44oFmof4hfnE8Ht1SGyvbaN0jqNE/M1YeQRBi3Ny
 5I4EsdBKQH+cyDu3CcXp6YkBPzX0oa+PNrYJPbzmcCj7I3apRCp254=
X-Google-Smtp-Source: AGHT+IEoaBRUevKB7EqKBW/bvgYG0c2NkjvCxp1sQC7VeUASL5aBBu4kA2UUpM2r4IioLM5PlFZBBA==
X-Received: by 2002:a17:907:9722:b0:aab:d8e4:2062 with SMTP id
 a640c23a62f3a-ab2abde5646mr767667166b.56.1736442402883; 
 Thu, 09 Jan 2025 09:06:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b0ab6sm87944666b.155.2025.01.09.09.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A80D6017C;
 Thu,  9 Jan 2025 17:06:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 15/22] contrib/plugins/stoptrigger: fix 32-bit build
Date: Thu,  9 Jan 2025 17:06:12 +0000
Message-Id: <20250109170619.2271193-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241217224306.2900490-6-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/stoptrigger.c | 48 ++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
index 03ee22f4c6..b3a6ed66a7 100644
--- a/contrib/plugins/stoptrigger.c
+++ b/contrib/plugins/stoptrigger.c
@@ -21,9 +21,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 /* Scoreboard to track executed instructions count */
 typedef struct {
     uint64_t insn_count;
+    uint64_t current_pc;
 } InstructionsCount;
 static struct qemu_plugin_scoreboard *insn_count_sb;
 static qemu_plugin_u64 insn_count;
+static qemu_plugin_u64 current_pc;
 
 static uint64_t icount;
 static int icount_exit_code;
@@ -34,6 +36,11 @@ static bool exit_on_address;
 /* Map trigger addresses to exit code */
 static GHashTable *addrs_ht;
 
+typedef struct {
+    uint64_t exit_addr;
+    int exit_code;
+} ExitInfo;
+
 static void exit_emulation(int return_code, char *message)
 {
     qemu_plugin_outs(message);
@@ -43,23 +50,18 @@ static void exit_emulation(int return_code, char *message)
 
 static void exit_icount_reached(unsigned int cpu_index, void *udata)
 {
-    uint64_t insn_vaddr = GPOINTER_TO_UINT(udata);
+    uint64_t insn_vaddr = qemu_plugin_u64_get(current_pc, cpu_index);
     char *msg = g_strdup_printf("icount reached at 0x%" PRIx64 ", exiting\n",
                                 insn_vaddr);
-
     exit_emulation(icount_exit_code, msg);
 }
 
 static void exit_address_reached(unsigned int cpu_index, void *udata)
 {
-    uint64_t insn_vaddr = GPOINTER_TO_UINT(udata);
-    char *msg = g_strdup_printf("0x%" PRIx64 " reached, exiting\n", insn_vaddr);
-    int exit_code;
-
-    exit_code = GPOINTER_TO_INT(
-        g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)));
-
-    exit_emulation(exit_code, msg);
+    ExitInfo *ei = udata;
+    g_assert(ei);
+    char *msg = g_strdup_printf("0x%" PRIx64 " reached, exiting\n", ei->exit_addr);
+    exit_emulation(ei->exit_code, msg);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -67,23 +69,25 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     size_t tb_n = qemu_plugin_tb_n_insns(tb);
     for (size_t i = 0; i < tb_n; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        gpointer insn_vaddr = GUINT_TO_POINTER(qemu_plugin_insn_vaddr(insn));
+        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
 
         if (exit_on_icount) {
             /* Increment and check scoreboard for each instruction */
             qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
+            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_STORE_U64, current_pc, insn_vaddr);
             qemu_plugin_register_vcpu_insn_exec_cond_cb(
                 insn, exit_icount_reached, QEMU_PLUGIN_CB_NO_REGS,
-                QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, insn_vaddr);
+                QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, NULL);
         }
 
         if (exit_on_address) {
-            if (g_hash_table_contains(addrs_ht, insn_vaddr)) {
+            ExitInfo *ei = g_hash_table_lookup(addrs_ht, &insn_vaddr);
+            if (ei) {
                 /* Exit triggered by address */
                 qemu_plugin_register_vcpu_insn_exec_cb(
-                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS,
-                    insn_vaddr);
+                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS, ei);
             }
         }
     }
@@ -99,11 +103,13 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info, int argc,
                                            char **argv)
 {
-    addrs_ht = g_hash_table_new(NULL, g_direct_equal);
+    addrs_ht = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, g_free);
 
     insn_count_sb = qemu_plugin_scoreboard_new(sizeof(InstructionsCount));
     insn_count = qemu_plugin_scoreboard_u64_in_struct(
         insn_count_sb, InstructionsCount, insn_count);
+    current_pc = qemu_plugin_scoreboard_u64_in_struct(
+        insn_count_sb, InstructionsCount, current_pc);
 
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
@@ -124,13 +130,13 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             exit_on_icount = true;
         } else if (g_strcmp0(tokens[0], "addr") == 0) {
             g_auto(GStrv) addr_tokens = g_strsplit(tokens[1], ":", 2);
-            uint64_t exit_addr = g_ascii_strtoull(addr_tokens[0], NULL, 0);
-            int exit_code = 0;
+            ExitInfo *ei = g_malloc(sizeof(ExitInfo));
+            ei->exit_addr = g_ascii_strtoull(addr_tokens[0], NULL, 0);
+            ei->exit_code = 0;
             if (addr_tokens[1]) {
-                exit_code = g_ascii_strtoull(addr_tokens[1], NULL, 0);
+                ei->exit_code = g_ascii_strtoull(addr_tokens[1], NULL, 0);
             }
-            g_hash_table_insert(addrs_ht, GUINT_TO_POINTER(exit_addr),
-                                GINT_TO_POINTER(exit_code));
+            g_hash_table_insert(addrs_ht, &ei->exit_addr, ei);
             exit_on_address = true;
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
-- 
2.39.5


