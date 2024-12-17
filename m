Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B921CE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHi-0004L8-Rt; Tue, 17 Dec 2024 17:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHg-0004Jy-QE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:20 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHd-00019v-Kb
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:20 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-728ea1e0bdbso4575812b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475396; x=1735080196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+nQuV745MSVduGtVwWvyxFW8ma4a2v2SK14uCf1mjQ=;
 b=a/mBksHYTHQ9MkPGP5YM74WEz2oxK4mDr7QnXTbYQ+MEFSVFNcNjd9BryGmFMugfnl
 rIcxnJ/BC3FibTJGS3cp/VYsI7ooq8jUpoNopzqxA+W7PZf5KeRQPy6IsrZSgFJObtya
 miVvADzU+b0CzjGfM6c4mD/30p2FEsXmzgyUcoECW8XrSqNuyMtPeoMufpozEmNNTOy9
 afYVAFgzwJkRwYL5164wicbfSK0J7ScfULG3q1l6W4fIFOeM42aDEJLrC/DqO+xqwd0p
 BeZaFb4atUDB8jrb33EVm4kflANqf5cIK9iS9M48t1Dvm/TPGICwnXMDAsuxFvONIfDc
 GXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475396; x=1735080196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+nQuV745MSVduGtVwWvyxFW8ma4a2v2SK14uCf1mjQ=;
 b=l7U6OJQexbmEVYBbZX37ccD0QgqtT0B/Szj9uMX/0TfLT8yIbYoRD9r3fg1UW8CPKY
 0Et8PadJzz/zGLtiG5+VzIagBaIDYX0WE4wCxCwrz/WVqJN69RwXiOsKhGN3sECgKoGz
 dGiPN9FQHWevvgfXOXl4ii0eMf3y+fwOKSDQ04ZMfFIcwMOw6Jv5O0Z2KWyGN3GUpIBx
 S0dUuJLCS32Q4DfA4i1Tu3zkFjQ7226c9PbMD9luztVW8oXLotRirWBM3SeEBQ3Ltk8a
 ye5IehL8kZCFR0OPq2btCb0PjXLzWWAc+QrBbhQFaMeYbVmj/hXT8gabbGarqxALWupu
 y55g==
X-Gm-Message-State: AOJu0YxIik0dBH56eQFgpaiq6uQQB+oywNoSrKWtWmvj+9bvTFSaArA1
 NBlRbfzPyrtvv0wbs21vqwgXlsTTOUscLE5XO37fBVsNH2T5BTW6CZ/iKMhXNY+881wGK0EBILQ
 MUzQ=
X-Gm-Gg: ASbGncsXykDm6gIP9LyxlSwu5uTUOZgni6C3F+QUtYUTI7NzLjnwooaJr1tEnNN9nZE
 AucKjpnXo1pBo2XLzoXdT+GRa/2cYftOLO3f/BOoj4wyCg/EePpOlqxvulAcEmgyLne9+SJozVl
 JLo7v1YvrHG4fRZx8S1gqdH9+4s8E0PX6TQW0ZY2W0RGIXQ7IC0m1LfGGiTcEjGZnmqApfYH2VG
 IgYedQzitSwzOp6p1sH8wns9HJb2e13VG/XoCjKsoMsb/yf5+L7v8cv
X-Google-Smtp-Source: AGHT+IEVcYxo6vfxppxRKBr1g1wRzj7evYJKsUDoSV9n/lBdfgjMuj/TntCbYjVt5fdyvnhspmDK5Q==
X-Received: by 2002:a05:6a00:114c:b0:71e:16b3:e5dc with SMTP id
 d2e1a72fcca58-72a8d2dee69mr1079991b3a.19.1734475396186; 
 Tue, 17 Dec 2024 14:43:16 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 06/11] contrib/plugins/cache: fix 32-bit build
Date: Tue, 17 Dec 2024 14:43:01 -0800
Message-Id: <20241217224306.2900490-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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
 contrib/plugins/cache.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 512ef6776b7..7baff868609 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -208,7 +208,7 @@ static int fifo_get_first_block(Cache *cache, int set)
 static void fifo_update_on_miss(Cache *cache, int set, int blk_idx)
 {
     GQueue *q = cache->sets[set].fifo_queue;
-    g_queue_push_head(q, GINT_TO_POINTER(blk_idx));
+    g_queue_push_head(q, (gpointer)(intptr_t) blk_idx);
 }
 
 static void fifo_destroy(Cache *cache)
@@ -471,13 +471,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     n_insns = qemu_plugin_tb_n_insns(tb);
     for (i = 0; i < n_insns; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        uint64_t effective_addr;
-
-        if (sys) {
-            effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
-        } else {
-            effective_addr = (uint64_t) qemu_plugin_insn_vaddr(insn);
-        }
+        uint64_t effective_addr = sys ? (uintptr_t) qemu_plugin_insn_haddr(insn) :
+                                        qemu_plugin_insn_vaddr(insn);
 
         /*
          * Instructions might get translated multiple times, we do not create
@@ -485,14 +480,13 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
          * entry from the hash table and register it for the callback again.
          */
         g_mutex_lock(&hashtable_lock);
-        data = g_hash_table_lookup(miss_ht, GUINT_TO_POINTER(effective_addr));
+        data = g_hash_table_lookup(miss_ht, &effective_addr);
         if (data == NULL) {
             data = g_new0(InsnData, 1);
             data->disas_str = qemu_plugin_insn_disas(insn);
             data->symbol = qemu_plugin_insn_symbol(insn);
             data->addr = effective_addr;
-            g_hash_table_insert(miss_ht, GUINT_TO_POINTER(effective_addr),
-                               (gpointer) data);
+            g_hash_table_insert(miss_ht, &data->addr, data);
         }
         g_mutex_unlock(&hashtable_lock);
 
@@ -853,7 +847,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
-    miss_ht = g_hash_table_new_full(NULL, g_direct_equal, NULL, insn_free);
+    miss_ht = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, insn_free);
 
     return 0;
 }
-- 
2.39.5


