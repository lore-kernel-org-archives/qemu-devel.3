Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4263C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSVq-00014g-43; Thu, 16 Jan 2025 11:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTw-0003mA-DO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTk-0004YF-SZ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:30 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso11763965e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043939; x=1737648739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ut5L3H7ENukAVXMf9ucpT4mEYkt3Qt71rdTcSo9h+fA=;
 b=qmry38Zp4SddZ+48O5xfOFBaensQWs0VpCDoYB7g/dE3oo2LkPrXeVxIgI7NVvx5JW
 ovQLVHJad2cXesrvRgrdfRZI/rJqbTzV3fOXDoFDTo5ybpV3C3ahIBWN4tGrFScfCfgL
 601pfFOAZQwqllFAH2/EwOd/kvHrFnvmFScTmlKwjoFlvJtC/Y+MpMtUUXlSCRlUCdu+
 Knv5eHmQqDrVCKNleQxZz9b+YOzKpLVKMY85+DA5bkNyVjGzbub0NH05j1okZUnjpn+A
 aENR8yLeQo02rsqXUhaf9v/3UufSd4nlWi23cSEhekJ025PabDvI4lBQTDnHt2te4JOw
 bzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043939; x=1737648739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ut5L3H7ENukAVXMf9ucpT4mEYkt3Qt71rdTcSo9h+fA=;
 b=ubti4jPzE4zeilf3wJ6h5jTM0O/LvAQBUbjEFxuYIwVzf2dFISI8Pz6olCJ1Ooe5ZM
 pDwZqNvQT6jazmsBDnhBoZtljxGKaUAz1xlJdi0oZoEVIobZe4kUtQ/zMfsX8PEMt2n/
 i81ci+bA6Euh8CeMyrwJZJmKMcttTvCl348AejfQyfv481rsX3PkzJf6Iu+HJjRJE2sc
 QTAM9yr6BR5TVtBSul/pOAZDsinz0QyGk0zxOIHrZZLkKb3m6gCe08XBqwHvk52DEiGA
 YJqCbGp15VUcOd9WzqlOFyNfnvlWv0HA5EdTpXHkT4ggreDEHTb6e6U6hPl1OYvZPxJK
 QucQ==
X-Gm-Message-State: AOJu0YyFd4ZUupqjjLFaBDWeB/leM62ILhCBSM0vZwteCAzbZwOOw066
 2wRTU7yzLMHLTTW1rvSK2MmXJD97+HFpa/KzjpFJyR9ns3PoS9eQM1++EfSAzFE=
X-Gm-Gg: ASbGncsFHbt8lYAedf7nSURCu/GDPfxZ9pvj6kAtdTnSZcj5LHXI2QvPINi7ZwjrW/h
 qia/qmlMuMmD4yR2G9yA6+fwYD1aobXohuHAVaQglI76JyUNYArMAU1Iyl7La5At3p8w6y39NOP
 8thheHpDw9WyC9hHCRdnhPdhkVZenOmfCbQlfBlPYkwSufYd2EM8ALAPa8GF1RXvij8OVOm6gkY
 aZtyUywrs8A7kn+x4JE2Ru0TeRiym6LfJUqPjbL0eNsXiWJG6fLcCo=
X-Google-Smtp-Source: AGHT+IFiIASRO/tvVWybzbCnblsXa82rotH5apFPNmLv9gW5wJG87J9xexC8yoOe9TAuGCBUXUAcig==
X-Received: by 2002:a05:600c:1c8f:b0:434:f586:753c with SMTP id
 5b1f17b1804b1-436e2686096mr321124675e9.7.1737043939201; 
 Thu, 16 Jan 2025 08:12:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3288f79sm214917f8f.100.2025.01.16.08.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E36A860898;
 Thu, 16 Jan 2025 16:03:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 15/37] contrib/plugins/stoptrigger: fix 32-bit build
Date: Thu, 16 Jan 2025 16:02:44 +0000
Message-Id: <20250116160306.1709518-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


