Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1579BC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsZy-0006gZ-03; Wed, 06 Mar 2024 09:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZo-0006bd-QC
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:01 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZn-0004E4-19
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:00 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso621499f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736537; x=1710341337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hywCMkQ2+8lFixtPYqWIxK0iCOhK3WSJjT1Lu+td+xY=;
 b=hMW5dmogBIjc5EUrC3VNXIkaHjMM6xYGC9QpuCtV3izw3imu1cPMurfiqelRU3zEWB
 IG7yNTRhn9CgjrpgOij9xY+UzR5yrIP8cd1NQrnyCvl45mfxf+ARU+G2Qpokc5En5VWW
 a6K5w6VfI0QShPpdnZM0GEo6qv6Pwm/sosSufyV7mlxVr4Fn7505ezIwiFd3jUKfgqqA
 q+biAOa1eHzTZR/TImcnspw0uv+YM66VjPEz0nqJgjysVH0aKYMQ/gyaeTCyL+ayQnE2
 NwV/UY45cetjQz1iywV+3zh+u4pcHwtuKl9n1tRuzB6FS7pmRmb0rQs9ekRxTYm1Kf6Z
 6h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736537; x=1710341337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hywCMkQ2+8lFixtPYqWIxK0iCOhK3WSJjT1Lu+td+xY=;
 b=CJjdmOynDHskkoe/8XkokD1V4W6jsu5a+GcMaMwflqLlmOzH2aMZcaHHAK88ue8vJl
 oDEV2zyY5jT8j9GoNt5js7lXJUcC2p3Xc3fHzY7ePDAZFetAIK1wup7mrtX6dZomkf+A
 RZVKMq8qXiS4PJ36dm1HJzxhpXX/mMk6y4MLhZLYsOYHQ5pU+0RjGYYGdX14Y6C6RKv/
 DivVX7rth2DtU/KzA4kQkH7H6DqMPRXnixUD8v3GJ93xradUbbkKRk4g2Q9Gw7aH/mjK
 z5uEwOpyjHqvTLq051hADT969v9DNU1l1xLP7UeKHHYmnPkrng1ubK54Tu43oPjDoUOj
 6y+w==
X-Gm-Message-State: AOJu0YymubXMtJxtVlVZHnketCep86qiBPEg0rrQjU1PybegyWPTEu/v
 H1pNvl2VkSvlUMDM0QdsZHHzoDQW6EKbLeTyQ2bd44ek33nlYukdnxe9LR8tVBw=
X-Google-Smtp-Source: AGHT+IG/H+ES/tSKZQVyuYvH4+qNDenyabEpbL7pWboqwIPMp3pSQR9Oc3K+Wbd5+cMiynk/o0HNPg==
X-Received: by 2002:a5d:6446:0:b0:33d:754c:8daf with SMTP id
 d6-20020a5d6446000000b0033d754c8dafmr5147480wrw.10.1709736537173; 
 Wed, 06 Mar 2024 06:48:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n3-20020adfe783000000b0033b79d385f6sm17590705wrm.47.2024.03.06.06.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:48:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 940825F9E6;
 Wed,  6 Mar 2024 14:40:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 22/29] contrib/plugins/hotblocks: migrate to new per_vcpu API
Date: Wed,  6 Mar 2024 14:40:34 +0000
Message-Id: <20240306144041.3787188-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240304130036.124418-10-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-23-alex.bennee@linaro.org>

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 4de1b134944..02bc5078bdd 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -34,8 +34,8 @@ static guint64 limit = 20;
  */
 typedef struct {
     uint64_t start_addr;
-    uint64_t exec_count;
-    int      trans_count;
+    struct qemu_plugin_scoreboard *exec_count;
+    int trans_count;
     unsigned long insns;
 } ExecCount;
 
@@ -43,7 +43,17 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 {
     ExecCount *ea = (ExecCount *) a;
     ExecCount *eb = (ExecCount *) b;
-    return ea->exec_count > eb->exec_count ? -1 : 1;
+    uint64_t count_a =
+        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(ea->exec_count));
+    uint64_t count_b =
+        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(eb->exec_count));
+    return count_a > count_b ? -1 : 1;
+}
+
+static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
+{
+    ExecCount *cnt = value;
+    qemu_plugin_scoreboard_free(cnt->exec_count);
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
@@ -52,7 +62,6 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     GList *counts, *it;
     int i;
 
-    g_mutex_lock(&lock);
     g_string_append_printf(report, "%d entries in the hash table\n",
                            g_hash_table_size(hotblocks));
     counts = g_hash_table_get_values(hotblocks);
@@ -63,16 +72,21 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
         for (i = 0; i < limit && it->next; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
-            g_string_append_printf(report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
-                                   rec->start_addr, rec->trans_count,
-                                   rec->insns, rec->exec_count);
+            g_string_append_printf(
+                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
+                rec->start_addr, rec->trans_count,
+                rec->insns,
+                qemu_plugin_u64_sum(
+                    qemu_plugin_scoreboard_u64(rec->exec_count)));
         }
 
         g_list_free(it);
     }
-    g_mutex_unlock(&lock);
 
     qemu_plugin_outs(report->str);
+
+    g_hash_table_foreach(hotblocks, exec_count_free, NULL);
+    g_hash_table_destroy(hotblocks);
 }
 
 static void plugin_init(void)
@@ -82,15 +96,9 @@ static void plugin_init(void)
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 {
-    ExecCount *cnt;
-    uint64_t hash = (uint64_t) udata;
-
-    g_mutex_lock(&lock);
-    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
-    /* should always succeed */
-    g_assert(cnt);
-    cnt->exec_count++;
-    g_mutex_unlock(&lock);
+    ExecCount *cnt = (ExecCount *)udata;
+    qemu_plugin_u64_add(qemu_plugin_scoreboard_u64(cnt->exec_count),
+                        cpu_index, 1);
 }
 
 /*
@@ -114,18 +122,20 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         cnt->start_addr = pc;
         cnt->trans_count = 1;
         cnt->insns = insns;
+        cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
         g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
     }
 
     g_mutex_unlock(&lock);
 
     if (do_inline) {
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &cnt->exec_count, 1);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64,
+            qemu_plugin_scoreboard_u64(cnt->exec_count), 1);
     } else {
         qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
                                              QEMU_PLUGIN_CB_NO_REGS,
-                                             (void *)hash);
+                                             (void *)cnt);
     }
 }
 
-- 
2.39.2


