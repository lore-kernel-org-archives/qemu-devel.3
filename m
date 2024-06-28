Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B61C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAx5-00059z-00; Fri, 28 Jun 2024 08:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwY-0004pu-77
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:11 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwW-0005i4-Ct
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:09 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a72b3e1c14cso59398666b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578587; x=1720183387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1MGJW50FjVhjyrhFQsVUOHRmt7nlCHL11oCXI6mA2A=;
 b=aXDK7s1a4YfH+G14MLYD3/WM6lE5p2Jq82EY0s2uq6EGrFLN50v58xCU0gh/C9RgWG
 c7WMbru+fukWQwRzNjOrYBg+HYih0ZmZHUXZH9ZR3YGUiUy2uR8XndbXCAUOWWzVhA0i
 NRRz3qPXS5gcLQ0CnnNEasf9p2XQAvANSDFolZJPlzkmCHEUiS7WfOCgZcC60TxGGbwq
 sm2MccapOjp5HQ5y8kKCN4ykqIryjMf9sWmwwUFN6F1vWYWNsXUhF7MlJwUThOIlyqu8
 A5RnUHj0StIcC/thalhFf29jdfgstnsuv+/yxhjEH7TEQMaK6/VXPm12HY9JgG5JlnVB
 5y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578587; x=1720183387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1MGJW50FjVhjyrhFQsVUOHRmt7nlCHL11oCXI6mA2A=;
 b=UBUrE6sSbrOTnw37z36aAJ3kREWOP0Ffg/9eq8S/EfkPiaJ676/nsJIzyqESC64DFQ
 Z1Td7WeLocOh9jKIHYto/cM2Thp7Pq5rnJqN73h7JHbG0aWpQnicGZ4FRtLiawZNfjmM
 jHkkr8q1fzmPx7wUBrfTE5bFarvQgTJHjixboesX01l/TMEB3Pt/HKLpZPUA/v2iYLXb
 t1bpGLtGbj3bAHHqgC7xzXdb+LpcIuebOKIj5Bkppj0Jd/LWnZwBeqg+ewKphk7amO7f
 g1TLipgSKderTtzQxl4h7YI8uehHkaTKUW+SKjODLBV62Bwqmh0kYNNsaFDJIEaeui2U
 TLXQ==
X-Gm-Message-State: AOJu0YyxBO0ORqWwQjNMb+YxOGTARHe/LRVY8LgDgwnp0FMhglIQ75XW
 MyVWAY+UArjZLcUfd7NsrcgWSRYMb8ZYZHIWbgA/X8xwCVv7pHvWuBmLNJG8nx8=
X-Google-Smtp-Source: AGHT+IGUyHaqE2H3ZeowGjOBN+7huQjG5y7y0uB/P99OvwUd34QrWa4YAfI42VJ7WhJZNPkifvwC8g==
X-Received: by 2002:a17:906:2657:b0:a6f:1590:ab06 with SMTP id
 a640c23a62f3a-a7245b56d21mr979825866b.31.1719578586715; 
 Fri, 28 Jun 2024 05:43:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf1bc08sm76310066b.28.2024.06.28.05.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:43:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B76F55FA15;
 Fri, 28 Jun 2024 13:42:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 08/23] test/plugins: preserve the instruction record over
 translations
Date: Fri, 28 Jun 2024 13:42:43 +0100
Message-Id: <20240628124258.832466-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

We are interested in the particular instruction so we should use a
stable record for it. We could bring this down to physical address but
for now vaddr + disas seems to do the trick.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/insn.c | 76 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

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


