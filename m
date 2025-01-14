Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02CEE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfG1-0005GE-8A; Tue, 14 Jan 2025 06:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFk-00057q-ME
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:39 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFi-0005RM-DT
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:36 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d9f0a6adb4so2511305a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854713; x=1737459513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/fE5ihsW9j0TdJrNyGqxXoPll6S7jQ7QqKUoC+ldgQ=;
 b=EiAKUpZcwOFI06m7urrkvBIoSp4kTL0AH5oviK90IZhpsjJ9o08W0tHqh0d69OWS5F
 XMVtTAo/5iYhzPjyX+YvV0RRk0pZkECP8omuaylKumeLj0e6N8Xu+6FA7zIahQkET1NQ
 JCCrEZoLll4VrweqP380wumJt0LVlNc9ZjTKTd7g6AsDUXMI8vF1olS1qE6hD3SHvJFQ
 /rerE3C7hfOs6soZ364DcXyJ8LiEVi5jflvxvOYxEw3JF/7qj8dB84ShLGzXdCyx9m2T
 yIlLV61F8abl+ZpgJ6wPQc7s8BwBEmjGyDUBO5tRBq50rWwCakZ8bWDsUV7Re6Mjt9Ab
 SIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854713; x=1737459513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/fE5ihsW9j0TdJrNyGqxXoPll6S7jQ7QqKUoC+ldgQ=;
 b=hxv2Q7IZRP4/AMZ6yaWgnr8LimNa4GEaC2n2KFY0pTUaQEx1VrpC9qu5ASSylqZgtN
 C0j0gk0GS2dXhWITU3RRbhbbF3bLVQ2KsB8Wx64cMSM/Tar1twVEERRLEF3qBLqqdc8c
 coAqnrepVCm2AEN+R29to+M/tuVOvlXop6+e044iVL2HyBOySnuLZYKhq5JK/3/eCrdm
 a6E2+RoW++YqNSfnE6oHYv+1Fu4Dgdr/kf/DupoBSJyi/O4NOS1fm6dtKKaFImpjVjL9
 GE1dPyo/4rieR3vEn/jxJgitQUvPcaaZAlTgOlNhRTXMghDEOedg8F7agdh3OPLT7nul
 /FvQ==
X-Gm-Message-State: AOJu0Yypz9j0f/QeAp+H68mDijsXzxQPS3xE+i73J7QH5rMd6ibmDXoN
 vyiqjjNBADZkp45mFdzFOCEGyZUKV96zJBg1swuyeqi8i9qFIEZl7gKSAEYtVgM=
X-Gm-Gg: ASbGncueB2GZ/f0NLdBB/I9fPrYS7tT5HxmRcgPIPsbIMoyJgFCiv70ghy8xysbabmx
 dDM4p/roEgeRJGRs2Ii2pKAyRr5jWEWYYZVl+UilC9hJNz513au56PViavwoMYyI14gml6r1oys
 CgoWXpz8Un2OlgSlrmesrew4kEJFD8DAK7W1AXTxS6GiWqhMnOc8pp5uF2zg7urs/EVAGTmpfjy
 ETjAD3VKB11bHI6wEDIsLBgSLxbz/zHX9HGbQ2AJPvNu+mzU3i7gdg=
X-Google-Smtp-Source: AGHT+IG/bnZ5cO56fM8HkTlll4LQMmrJ2LrO//U09fldEGFNa/p4/0dQfsmGTPwaZV4P85Kyq/zZWg==
X-Received: by 2002:a05:6402:50c6:b0:5d0:b2c8:8d04 with SMTP id
 4fb4d7f45d1cf-5d972e147famr26113739a12.18.1736854713029; 
 Tue, 14 Jan 2025 03:38:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c3206sm6331486a12.46.2025.01.14.03.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4473D5FA07;
 Tue, 14 Jan 2025 11:38:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 16/37] contrib/plugins/cache: fix 32-bit build
Date: Tue, 14 Jan 2025 11:38:00 +0000
Message-Id: <20250114113821.768750-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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
Message-Id: <20241217224306.2900490-7-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/cache.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 512ef6776b..7baff86860 100644
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


