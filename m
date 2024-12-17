Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D894E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgDH-0005Pv-44; Tue, 17 Dec 2024 17:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgDF-0005On-IY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:45 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgDC-0008Rv-M9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:44 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166f1e589cso60827445ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475118; x=1735079918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crzqjDJBZdpI+EWDwy4Pgv4ZHNVlbcwq1nqGrijGMLQ=;
 b=GBakGgpdlKbZZ+Bgs/BvkKHoBFTS690D/DbyPL1d8Sd2B6ZnKz8cDqAdSncW31wNfa
 IK0bHrX9rGBfzFxZdFIj54wHLkYrjphIHSR9A1X8+RDJLcH1/UI/wPv2WSe08TxvDbnC
 jhdD3G5vbr2iiHmY1sapgVaIhGE4kZWLpiqfDBqZpIo+ldZ04nxw2+aiX9FZX+iHxpYa
 xsphDre0CyDgnzFtC+4f13Fe6V0aP7Wg9NKxqYEzBQtGfaK3xa1gbN3SlrcEmIJLJflo
 2cwU9YNPzx9sIRtHr3uPIhjJfLn1yORmkDbO72O+TNBVEb1hOOsLXBUXr57s8KHyrZgH
 4ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475118; x=1735079918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crzqjDJBZdpI+EWDwy4Pgv4ZHNVlbcwq1nqGrijGMLQ=;
 b=MSsK2ea2BN51O6JahGzeNK+zamO0TgIq03+Dre1yNSSa8pNsxRdXURLvjAYGcoC8xh
 05lfYS3ugiDE+Y9D26a/UNriIdGfP0RbrY30A9QwJem8rxQwsBNfqQLu8tSsD/uS7Gvp
 7ISwmmBTPJ4Kg7PwC/uSUNAXrJxEo3yi+XUbGHpYyPd0l2e7wcieEZ70+6X2jLTSvrKZ
 17QHieexdLP7MQOW6709kyold1Qh0aA9EoZi54QkUA0RadyUE1tXT8VDSIROxiu4Wim/
 qzHV7NkcEFlkLEbuq1l9yJjwZ0fkH4Yy16M07O+YjxWCZt4/8/IP2NRnvWjv/2a0pBAZ
 LeAA==
X-Gm-Message-State: AOJu0YxNjzNF5Q+47G5zyPw2JEQ1a+up9qDW+SaP39DrtzcG+jUiZ95W
 bBdQOj2C6Sf2QxcuUCJCMihwCVoHO0Elvj/qJvP7e4Jh3plPbEzJmm0fpd62UVMFY6oUIXf89XI
 vxqQ=
X-Gm-Gg: ASbGnct+pU8wvOzuvKbl7h6zT6RtLOITrjF6ZDq2uMfq9YTZ1pzZNMvWVHYKo0OowA0
 cOYK0Wp14fDUYUfgZx2wfDasbGAouVb2VA1WmiIBoFI+h/dbBRXl6Thekgr6/EH5sv9XvGjCfhQ
 OyE/BRbmHQYCnU4nVYDIICLGArgYrnPHv5h1MLsiFMMh2hmZJ5OZUDj4Mc58FsUCuOjsREeMRXq
 t5yaVzyEwFxmBgUpIuofnSgZSfe2YR8yjD3NRQQTQwslwAYkDamFoXX
X-Google-Smtp-Source: AGHT+IEWbymAA4dBwJqzzF4yZDv/aLY4XKJ3fyhhMbQKepRIh7N8u2qCS+Kxzyv+vPEFZAG93GDLgg==
X-Received: by 2002:a17:903:1250:b0:215:6f9b:e447 with SMTP id
 d9443c01a7336-218d722d546mr5866875ad.30.1734475118667; 
 Tue, 17 Dec 2024 14:38:38 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:38 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 09/11] contrib/plugins/hwprofile: fix 32-bit build
Date: Tue, 17 Dec 2024 14:38:23 -0800
Message-Id: <20241217223825.2895749-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hwprofile.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index 739ac0c66b5..2a4cbc47d40 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -43,6 +43,8 @@ typedef struct {
 
 static GMutex lock;
 static GHashTable *devices;
+static struct qemu_plugin_scoreboard *source_pc_scoreboard;
+static qemu_plugin_u64 source_pc;
 
 /* track the access pattern to a piece of HW */
 static bool pattern;
@@ -159,7 +161,7 @@ static DeviceCounts *new_count(const char *name, uint64_t base)
     count->name = name;
     count->base = base;
     if (pattern || source) {
-        count->detail = g_hash_table_new(NULL, NULL);
+        count->detail = g_hash_table_new(g_int64_hash, g_int64_equal);
     }
     g_hash_table_insert(devices, (gpointer) name, count);
     return count;
@@ -169,7 +171,7 @@ static IOLocationCounts *new_location(GHashTable *table, uint64_t off_or_pc)
 {
     IOLocationCounts *loc = g_new0(IOLocationCounts, 1);
     loc->off_or_pc = off_or_pc;
-    g_hash_table_insert(table, (gpointer) off_or_pc, loc);
+    g_hash_table_insert(table, &loc->off_or_pc, loc);
     return loc;
 }
 
@@ -224,12 +226,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
 
         /* either track offsets or source of access */
         if (source) {
-            off = (uint64_t) udata;
+            off = qemu_plugin_u64_get(source_pc, cpu_index);
         }
 
         if (pattern || source) {
             IOLocationCounts *io_count = g_hash_table_lookup(counts->detail,
-                                                             (gpointer) off);
+                                                             &off);
             if (!io_count) {
                 io_count = new_location(counts->detail, off);
             }
@@ -247,10 +249,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
     for (i = 0; i < n; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        gpointer udata = (gpointer) (source ? qemu_plugin_insn_vaddr(insn) : 0);
+        if (source) {
+            uint64_t pc = qemu_plugin_insn_vaddr(insn);
+            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+                    insn, rw, QEMU_PLUGIN_INLINE_STORE_U64,
+                    source_pc, pc);
+        }
         qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
-                                         QEMU_PLUGIN_CB_NO_REGS,
-                                         rw, udata);
+                                         QEMU_PLUGIN_CB_NO_REGS, rw, NULL);
     }
 }
 
@@ -306,10 +312,9 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         return -1;
     }
 
-    /* Just warn about overflow */
-    if (info->system.smp_vcpus > 64 ||
-        info->system.max_vcpus > 64) {
-        fprintf(stderr, "hwprofile: can only track up to 64 CPUs\n");
+    if (source) {
+        source_pc_scoreboard = qemu_plugin_scoreboard_new(sizeof(uint64_t));
+        source_pc = qemu_plugin_scoreboard_u64(source_pc_scoreboard);
     }
 
     plugin_init();
-- 
2.39.5


