Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58368E77183
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3t-0008JX-2A; Mon, 16 Dec 2024 20:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3d-0008HZ-BN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:29 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3b-0004yY-OK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:29 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7fd4998b0dbso3796923a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397645; x=1735002445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRvxSz/fwAJJS5uNNaJOchif7N0SvzPTk+9aEXLD21I=;
 b=uTlAj5ug76XHJsUAiZ3SID3uC80twji2FkuBhvYySwaZ1t5MenPPQ+EHA3yaVyK7Qq
 Vd3y1E24KLfqjApvZzYkN64vv/4LQhnMAfZN4ULQHQO9KgheTsnPcSBfNRJRjmtRL6yR
 pNlZ4irz1rFf9pbmQ+nl+/awNTTUaj3dmBfqlpAbNTvpNaP8O7/hDRrnXj4CvGB+zYYS
 mlm+05WbVpf8EufupvQylpYRmqHNgh4jeQnJStWImi4i5oNJWnd9r8vwFd7CCyfzywA8
 PxnNNOiWQQUYvzPRPLMFO3MQyBpDdxO2kbwRjbmFKNk1aRT2AvGwLowo+h4YVEU4dwDw
 FFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397645; x=1735002445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRvxSz/fwAJJS5uNNaJOchif7N0SvzPTk+9aEXLD21I=;
 b=BlGf8Tjs+mca6ECETV3YcX7Cnl7n8UfLpO0uWri9MOlYBPuFjnn+CST3+2ZoNHLUr3
 cNWzZrvoNUdX1ogeAzX2GGYuYdQhGXOrNBoDJdjKFvX3bXk0jBVqTrjiSW6VWtV8Emr1
 SeMlBuEtLLSi6i9Xvo2apNo3r0dg8+xCzMJnu6HdKUENj0/a96+gVGV+N0nLQz8rSqHS
 CMX7+PH9L51WnZpwIuPwZbH6Oo3GNRmhzTcn2Ba6mVenowlZRJxCLbVjc8g5jXSfYir9
 AJZ4moOaqWGRkLykZGUOR22BtC6J6LkigW4rERX26gUaWk0glAZzrnjwXfqvQoh2RpsA
 /qDw==
X-Gm-Message-State: AOJu0YyMi4aVmXNztSC0T53H/8IRNkxzJpsyEv6/sj3JGN2sVc1KhqRK
 oMJrDpHy0fSp7EWRiFDO6WSYSOCiChsGdjOdQlhgCDtGF35DL7lzwKufl63c2MajuNdqVd7lbGg
 Bsq4=
X-Gm-Gg: ASbGncugaBqq0lfBbJmMaedI3C3rPJLAtwtuXHjd+2ki3p0eQ4Wo82+PmWsXa2F/5Lh
 5Gwc32JYcBqzNqAAO4yPzSaaYfKKYISRNimvRqm/3CWgg07VtN+dsVoZ332C9m5kLXix1joCQTi
 GdEYVwUy06keLyct+gfHvBtxuLUuCO4vSrHcZYBiFYH+NESjMA2KAHhq/5pPKddovsWoeR4mkaR
 YlO9NgmSuKJpiCHp20KNquqQX7XqLns6kO/3KW/AB58si88geEqCZmxu/yW66utXDiGAlKVqs27
 HdItlnZ9l+TlFC4=
X-Google-Smtp-Source: AGHT+IFtJqMXxBPUbbAFfROyFj/WtQl4bvrnNFhW8FXIiQIA0tixCBM45QBcbPxRTiHgAZXVNYz1/Q==
X-Received: by 2002:a17:902:f607:b0:216:4e9f:4ec9 with SMTP id
 d9443c01a7336-21892a34331mr216767305ad.38.1734397645100; 
 Mon, 16 Dec 2024 17:07:25 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:24 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 08/13] contrib/plugins/cache: fix 32-bit build
Date: Mon, 16 Dec 2024 17:07:02 -0800
Message-Id: <20241217010707.2557258-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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
index 512ef6776b7..cc6922c3c95 100644
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
+        uint64_t effective_addr = sys ? qemu_plugin_insn_haddr(insn) :
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


