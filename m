Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928CBC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdP-0001Kq-7W; Fri, 17 Jan 2025 08:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcy-00010v-8A
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:12 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0002E6-8t
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:12 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5db6921ad3dso3267259a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121386; x=1737726186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBv2PMpv7wLfaY8LQVmtPxp8duzrePMVvgjGXUc6BNI=;
 b=gLZlRaGJIsFYmAeg5HQCy/jm5netThD/fy4jGsGYl2tnZbl9GvBuvXOtodWVRbotOV
 X5wausohTMsLTSy3969SrkyvwkSdj27oEIBy1CSp0eqnrH9+JrXfb7MZ0w6x+4xyvuwL
 7jGKvn2MAllMaysNcV7LcjFNFoZx3Ru4/0DSPKV3K7DFrI8tCPCW3Fk0uUTIJg35ughi
 0SKYlPP71ALpDpruZ8xjbu0gnjwEz8wRHJBOKdzPHw9WbPdTpD6NpVDB4qUcSRfuns50
 /76aJcxK8TXsPBeciRDmMyuuahtsmxW5etSn9hfSJoR2g1d+4gY3M48MSeedoXFNQWAw
 q5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121386; x=1737726186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBv2PMpv7wLfaY8LQVmtPxp8duzrePMVvgjGXUc6BNI=;
 b=TFBnBo3taG/+jtxeYbDB+cbCVwB6XUehRonOYCWgTAp0uYZr80nDQa//fXM8YVomMc
 rLXt8zurE7m/q8Ow8Mkl1n26Kb9+DPrHTT9zbEkz2tJs3Nq1+UhGfsAmjzWh0jnQuzh1
 aZN5PwKyvXzfxZPwHCh+HFwgMcvKlupmSo/SLtsH9EqYwaRMPD2q2QRHnAMbAsyxSl/P
 ahHMUnn58W6xYPioY6AU3SR9L/Q3i4MC3nvzr/E3Omg9lnkzig+oEMA0MwdmSfWARXHD
 KOJcRHtl1Qi1X0vc4QQ1YLNU0tGmhhhMjMI0nd4Dt8B7eTSWh4bidCt3hvta+cxvygH4
 I/+Q==
X-Gm-Message-State: AOJu0YxMcxRD0pZeMl6F1xAsQ8Nbg9dXJkIIlBTxr304UPaq2WWNdh66
 Pyvsuuj0nriGHcRx6SaSbmquLuZ4B+MF9H9nV45zAPAS/5RtDyrQu0t5yZCUIPo=
X-Gm-Gg: ASbGncsc7lIant2y4AI6q+ZEmcZNbZeyqluUTQc6ojLoH9TGo/e9ri5Cbd2zAKQ05LH
 rLQiDR9C7/yY0AI+KQcW7k+j7cHNXdWK+9cqYF2YVsxFR05HAGMxW7bhc8TCzbycpcJdULkl22C
 CyhWTOlHa6Ilyj2IlgpNivCOlIhpiYf7XkRgQERyi4iBDTK8YA1M6sY06uuYIbtENvOEe4j9pYR
 Q4xTSAtjC7XUAUx+zoGBGHYMuJ12JpLTD54Oa3htTORUQN3n6JJ4Io=
X-Google-Smtp-Source: AGHT+IHT5NlwyUpLnZb80925VL9OQXZm42EUK/Vud/2Gkh+7TcbE3GNWOitgzFVfG6XrMx6TVlywjg==
X-Received: by 2002:a17:907:7e92:b0:ab3:3b81:876f with SMTP id
 a640c23a62f3a-ab38b1b17dfmr274869766b.4.1737121385967; 
 Fri, 17 Jan 2025 05:43:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c74cd8sm173350166b.3.2025.01.17.05.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 531DD6084C;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 15/37] contrib/plugins/stoptrigger: fix 32-bit build
Date: Fri, 17 Jan 2025 13:42:34 +0000
Message-Id: <20250117134256.2079356-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
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
Message-Id: <20250116160306.1709518-16-alex.bennee@linaro.org>

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


