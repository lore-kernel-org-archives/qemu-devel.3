Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F20C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl0G-00038X-AB; Fri, 05 Jul 2024 11:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl07-0002g2-5H
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:31 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzv-0001Hz-2L
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:30 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a77cbb5e987so100505266b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193837; x=1720798637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lf/1KqRAAMtl+wrn2ncS2jotaeqgCn1AGWcRKaNCTcQ=;
 b=evs/7AoS4FzAabJJkG/Qni7EPuOAn8rQuYS9W44G7LIhu/12BhF/7YPKgNzX0YJSjQ
 4H2KfNtH+Iq4BSs4t5wswEJQ0ODJDSSTgxrbDt3m7TNhzfBhGRE8BjMF3IGqs4TlEWnK
 w1x+x2+3Jq5gyJfaYwjygR/6D467YVFMuSkvB8D2pcX7CHQ/x06jt1gRbkQaNfjC/Z7G
 /QF/WggxSYUfvZelkOgVUe6DILQ6rbjBDOr3FHeIoCxHHHUBFBrBDommRiRf4sZiPlc5
 SngQlntEb15zAkdHaCAfnMBKFm/28J5Nhh68QjtykSXL04z9cDDTwhgnkLEFstIU8G+c
 QcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193837; x=1720798637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf/1KqRAAMtl+wrn2ncS2jotaeqgCn1AGWcRKaNCTcQ=;
 b=P1BbFa01ORhhkkeAookoJFX44IDk/BI83zxhE4yHctJGsbFlKSc8fOwOhuNsjI2wOo
 jx4yG6p0K0dNC8QgQbUwtAWITVbhNwkZhLB8mAtcAgF1Q3+umqS0BYx61fjHAlK+u4+v
 mzkQo5Efq8ukwHgdWiU/YQkhdaB81G8jLmOqGwfYvwfupILJRk3QDcAhHnOqvQwmr1Yz
 9424F8G2bS+oWAf8CFgv1++noUZZ+aF5e3FxULMiWJgeDTTkUGTCeWU0wV5FL7uWqy5o
 K3lICuIM/UKSMRw1bbimVwPkpzK6tx24rh2R+1AZKxYMGCNKYLMxwYjn+hi2DKtO1ACQ
 XJBw==
X-Gm-Message-State: AOJu0Yz/M5VvszwCmbrHfeEsLyyX7SDrdDo6Z/ZukxeOHRCmYKoTzdLn
 mMut7qYvTP1u7iSDj0DqBo7+9sWgQSTGGjwN7nRJDnfTBloSs/8tldzywUn51Qb/74xo5aa2BMh
 9
X-Google-Smtp-Source: AGHT+IGiq5+2cuTq3PxYEQ+/myz4MD50poKk6+0coOjHrqCpPRufg96/UpTQM1pWUHNOgk63iWoNDA==
X-Received: by 2002:a17:906:2514:b0:a77:cc6f:e77c with SMTP id
 a640c23a62f3a-a77cc6fed76mr170946166b.58.1720193837413; 
 Fri, 05 Jul 2024 08:37:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77cf0b9181sm54418666b.99.2024.07.05.08.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A3CF5F92B;
 Fri,  5 Jul 2024 16:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 22/40] test/plugins: preserve the instruction record over
 translations
Date: Fri,  5 Jul 2024 16:30:34 +0100
Message-Id: <20240705153052.1219696-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We are interested in the particular instruction so we should use a
stable record for it. We could bring this down to physical address but
for now vaddr + disas seems to do the trick.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-23-alex.bennee@linaro.org>

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 524f9ddde8..baf2d07205 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -43,6 +43,44 @@ typedef struct {
     char *disas;
 } Instruction;
 
+/* A hash table to hold matched instructions */
+static GHashTable *match_insn_records;
+static GMutex match_hash_lock;
+
+
+static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m)
+{
+    g_autofree char *str_hash = g_strdup_printf("%"PRIx64" %s", vaddr, disas);
+    Instruction *record;
+
+    g_mutex_lock(&match_hash_lock);
+
+    if (!match_insn_records) {
+        match_insn_records = g_hash_table_new(g_str_hash, g_str_equal);
+    }
+
+    record = g_hash_table_lookup(match_insn_records, str_hash);
+
+    if (!record) {
+        g_autoptr(GString) ts = g_string_new(str_hash);
+
+        record = g_new0(Instruction, 1);
+        record->disas = g_strdup(disas);
+        record->vaddr = vaddr;
+        record->match = m;
+
+        g_hash_table_insert(match_insn_records, str_hash, record);
+
+        g_string_prepend(ts, "Created record for: ");
+        g_string_append(ts, "\n");
+        qemu_plugin_outs(ts->str);
+    }
+
+    g_mutex_unlock(&match_hash_lock);
+
+    return record;
+}
+
 /*
  * Initialise a new vcpu with reading the register list
  */
@@ -131,16 +169,19 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
          * If we are tracking certain instructions we will need more
          * information about the instruction which we also need to
          * save if there is a hit.
+         *
+         * We only want one record for each occurrence of the matched
+         * instruction.
          */
         if (matches->len) {
             char *insn_disas = qemu_plugin_insn_disas(insn);
             for (int j = 0; j < matches->len; j++) {
                 Match *m = &g_array_index(matches, Match, j);
                 if (g_str_has_prefix(insn_disas, m->match_string)) {
-                    Instruction *rec = g_new0(Instruction, 1);
-                    rec->disas = g_strdup(insn_disas);
-                    rec->vaddr = qemu_plugin_insn_vaddr(insn);
-                    rec->match = m;
+                    Instruction *rec = get_insn_record(insn_disas,
+                                                       qemu_plugin_insn_vaddr(insn),
+                                                       m);
+
                     qemu_plugin_register_vcpu_insn_exec_cb(
                         insn, vcpu_insn_matched_exec_before,
                         QEMU_PLUGIN_CB_NO_REGS, rec);
@@ -173,13 +214,38 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                                qemu_plugin_u64_sum(insn_count));
     }
     qemu_plugin_outs(out->str);
-
     qemu_plugin_scoreboard_free(insn_count.score);
+
+    g_mutex_lock(&match_hash_lock);
+
     for (i = 0; i < matches->len; ++i) {
         Match *m = &g_array_index(matches, Match, i);
+        GHashTableIter iter;
+        Instruction *record;
+        qemu_plugin_u64 hit_e = qemu_plugin_scoreboard_u64_in_struct(m->counts, MatchCount, hits);
+        uint64_t hits = qemu_plugin_u64_sum(hit_e);
+
+        g_string_printf(out, "Match: %s, hits %"PRId64"\n", m->match_string, hits);
+        qemu_plugin_outs(out->str);
+
+        g_hash_table_iter_init(&iter, match_insn_records);
+        while (g_hash_table_iter_next(&iter, NULL, (void **)&record)) {
+            if (record->match == m) {
+                g_string_printf(out,
+                                "  %"PRIx64": %s (hits %"PRId64")\n",
+                                record->vaddr,
+                                record->disas,
+                                record->hits);
+                qemu_plugin_outs(out->str);
+            }
+        }
+
         g_free(m->match_string);
         qemu_plugin_scoreboard_free(m->counts);
     }
+
+    g_mutex_unlock(&match_hash_lock);
+
     g_array_free(matches, TRUE);
     g_array_free(sizes, TRUE);
 }
-- 
2.39.2


