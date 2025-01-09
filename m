Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920A3E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzj-0004nn-3N; Thu, 09 Jan 2025 12:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzc-0004kO-69
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:48 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvza-00071K-JQ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:47 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaeecbb7309so234906566b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442404; x=1737047204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/fE5ihsW9j0TdJrNyGqxXoPll6S7jQ7QqKUoC+ldgQ=;
 b=b9ftj7sSxHdokjBEEBrjOQX2wnzS0epXNEezILVAfdlb9xm2vWxXnlZrW2tvCfqcl3
 n3amqxactCykHJt1TQIZb5GIqy+xFzEMX7BBPW1F5wCMc/+RdX9MyfuVOz3IWslfR+6+
 0gIznNvaM95Qc7Xhv3qZgBLeqP26xo4JknfNCkIlLU8+FT1vxwI6yzrICp23ZQrBXEgl
 qeMgAuch9d6D50I8Ga015JGG4wpK4Xv0Je2fGlvTeCBgQWXcnF57/j7IP0vi+BSA/vSp
 yIFG9RQ9vayZKoyRqnZB/2sc7PqZjp4SDiucXAn8pwFKjTO4zd3hhLfMOJ947xF9//X5
 vFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442404; x=1737047204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/fE5ihsW9j0TdJrNyGqxXoPll6S7jQ7QqKUoC+ldgQ=;
 b=JzOvBF0x22DAc/l4qL7FIGFKhkYxsnOxdPNIYeOuBlXxVKllDq0k+zy8fHZJ0aT+V1
 0oyfbIz/mz/O6st+R4ig5u0KL20NraPkp/ADB5IO9L5Q8HfB/XqKNzyPf+EcEQsbwjb3
 mQYJbeRzdHF/QGSDczRaVXhSF15e53GXtsnlQnkm/iILO1uPSrYXG853ZrKH2iMX7qHu
 SE511qnoF+XvNWJRyDOPFNOoF9AdvL/Ext2b4yGM1J84MpwpFrzHsOWeZSbg7WIAt4Fw
 k3mDlC1QWHZVsR4gpuUR8mpulGcG5iZQbR3O3n6CLKSnMN9BjCwwoBf7laAr888+CDAu
 gQHA==
X-Gm-Message-State: AOJu0YxYw3GEIBajBQcgaJOZepFD4OG+fdNUyhC9xqlDOMYEzxGVIkEr
 uOZ7ugrQk31UvNMyHuyp58PheP2ciOuTTAXZtdAdngGR85eoGB5h9nfACeItcXuG784fcr2QH6m
 r8ZQ=
X-Gm-Gg: ASbGncs55PrJTBxyN7qA21s9NwqtuO8R0iSldEV1+1ANCn6JXj0VL5vu4K6dZWpxm75
 /cSiAytFXLPZBCKMGFmr5zuUhKWo+TDfhIPf8pi7AXrT/eGgrL9hNr0jOIUYbCZHqeFBO96637K
 ixcP+1zjI+pLQmT5CMJEM0VKp0zjKxym7yY4vIELDE2ibdJgOYozE+AaqQE7fIs6PU//4L4RxZJ
 5JBeo7QnglLiarfh+KmTVJ+NmocX/utJcBthX0erVU47Wv0JbUFVHQ=
X-Google-Smtp-Source: AGHT+IEazkSadyYQEpjjstVhwIunHe2OcQrPHDs4Cf9+kHQwFu+fabYFOP4BscyRXR7YfR0J8zLG+g==
X-Received: by 2002:a17:907:930b:b0:ab2:d829:cf4c with SMTP id
 a640c23a62f3a-ab2d829da15mr101212766b.33.1736442403817; 
 Thu, 09 Jan 2025 09:06:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c29fsm765151a12.9.2025.01.09.09.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 52BDC60679;
 Thu,  9 Jan 2025 17:06:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 16/22] contrib/plugins/cache: fix 32-bit build
Date: Thu,  9 Jan 2025 17:06:13 +0000
Message-Id: <20250109170619.2271193-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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


