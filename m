Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A26E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHj-0004Lb-6a; Tue, 17 Dec 2024 17:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHg-0004Jn-Ad
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:20 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHe-0001AK-J4
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:20 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-725f4623df7so5204430b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475397; x=1735080197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSO3SqC3k3PD4UDj10nreaVmTIRbnjLL+fnwPXL6Pds=;
 b=gB5X4eeJskPzkm8pmNWS2gNYrLWy4EYVV3NRbKRJsGIjPho2dLFYHWKrScTwjHNo6+
 RL6XFQ13t7uTS/XUS0ZizHh1fPNJvFmdHqoh4RSa+ZifX4B+JJJxKwBeX2nU6m/4PTKs
 2Xl5tA2wgwAYPHexNRMZ+fjG1bS0x65bSwVN+eHShuf1EYgbxyQDgA6mGyc5fRqetP/q
 1IjF5RlDmnDTn7ASxPf+6TiyWTKqaECZGBgcb1Wnt0URetoKTZpnsq7wnhNwUKoV9zSN
 xhqgERzeAKnG1TM1s9ilVUDyJaGPaj5OPeMIp3xa94StNvRM9q96Oh5X4ko1uD+e0h4n
 VKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475397; x=1735080197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gSO3SqC3k3PD4UDj10nreaVmTIRbnjLL+fnwPXL6Pds=;
 b=wOZ8m+IHJdJFzLwM5+bX+NwpqtTVQvstGOEhVDPFlaZpEG7lVdc6gT7FSK0SGJstpG
 /45Af/ZgVjyLwFqzQp0AwiVKYppUEdeCHCioFWDSJAPCxQovZ/aylLEirv1wIbWxgJGO
 COKAyWP3YxpYckPLWnohvDQwOYOk4Szc8XY17bCQXgu6rCDAx+WOAiaSODVsTlbSfukU
 8ASWYyavqsnAirwSln0pQMOGYT4RW8s5moJpJO2AJiGoTuGC3hHMbB8ZyyE9YN4R08Gf
 mKxfi9D+FY+K5oO2PWTvQHMmNrruVQgH4RQ3KnO47gHCicjfJwBk9o5J3dskVTNyiCh7
 Injw==
X-Gm-Message-State: AOJu0Yy/c442VNdenUR2TgOJq9gxzb2JicVp7+ngiS/mqagVvKkzcRwa
 HiK7KnXQro8VEwsyxo8jvXQUIa+xc40o9cnNE38U/5L7jHUcr5nJSTCwETIb75ghoaxkY4eAVkt
 T8hw=
X-Gm-Gg: ASbGncvYWXVuVIOAMuHrDFFEKTK/9jhAFv2+uM83NRt85sqXD5xu9tIopWekow6vw5l
 es1L9HfpokSsuNN6FY/VOijp+MY+557ziLvFFa/GDnSuF0IIFtlJAN0/I5AEhlOZPnfX++QEx7M
 NMirvfIQZPagMNLkfrw4PFHwyaNx9qhzwbYcIi2QnKYk6HDcEGM3NAv7KcM6SqJxnuc4b0Y3n2h
 10LPtp8SkPKdFo/CiOE//PKPYYWx71Qs2pWoxP+X3t67txY/b8xD1k2
X-Google-Smtp-Source: AGHT+IGcC9iroE+cDy4FJzJW+JsVd7PUZwPGM3vEdrc/l84rdn36WbmNhgU6yGnJSBVid6dMlMXJsg==
X-Received: by 2002:a05:6a00:6c98:b0:729:643:744f with SMTP id
 d2e1a72fcca58-72a8d2ee4f9mr906549b3a.25.1734475397117; 
 Tue, 17 Dec 2024 14:43:17 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 07/11] contrib/plugins/hotblocks: fix 32-bit build
Date: Tue, 17 Dec 2024 14:43:02 -0800
Message-Id: <20241217224306.2900490-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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
 contrib/plugins/hotblocks.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 02bc5078bdd..f12bfb7a267 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -29,7 +29,7 @@ static guint64 limit = 20;
  *
  * The internals of the TCG are not exposed to plugins so we can only
  * get the starting PC for each block. We cheat this slightly by
- * xor'ing the number of instructions to the hash to help
+ * checking the number of instructions as well to help
  * differentiate.
  */
 typedef struct {
@@ -50,6 +50,20 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
     return count_a > count_b ? -1 : 1;
 }
 
+static guint exec_count_hash(gconstpointer v)
+{
+    const ExecCount *e = v;
+    return e->start_addr ^ e->insns;
+}
+
+static gboolean exec_count_equal(gconstpointer v1, gconstpointer v2)
+{
+    const ExecCount *ea = v1;
+    const ExecCount *eb = v2;
+    return (ea->start_addr == eb->start_addr) &&
+           (ea->insns == eb->insns);
+}
+
 static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
 {
     ExecCount *cnt = value;
@@ -91,7 +105,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
 static void plugin_init(void)
 {
-    hotblocks = g_hash_table_new(NULL, g_direct_equal);
+    hotblocks = g_hash_table_new(exec_count_hash, exec_count_equal);
 }
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
@@ -111,10 +125,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     ExecCount *cnt;
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
     size_t insns = qemu_plugin_tb_n_insns(tb);
-    uint64_t hash = pc ^ insns;
 
     g_mutex_lock(&lock);
-    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
+    {
+        ExecCount e;
+        e.start_addr = pc;
+        e.insns = insns;
+        cnt = (ExecCount *) g_hash_table_lookup(hotblocks, &e);
+    }
+
     if (cnt) {
         cnt->trans_count++;
     } else {
@@ -123,7 +142,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         cnt->trans_count = 1;
         cnt->insns = insns;
         cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
-        g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
+        g_hash_table_insert(hotblocks, cnt, cnt);
     }
 
     g_mutex_unlock(&lock);
-- 
2.39.5


