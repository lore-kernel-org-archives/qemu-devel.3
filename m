Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B47DE77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgDC-0005Nv-T5; Tue, 17 Dec 2024 17:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgDA-0005Mg-Q1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:40 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD9-0008RM-3G
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:40 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2166022c5caso46791865ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475118; x=1735079918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/SJ8lccCav6ChcddekLPgsSkxigdbVgR6d9YvtHR4g=;
 b=EVZCPNmq+Y0Kx1X4rWnupSux7MF18Kx0VpLrF/nMeFGcyMlAtxHFuUTqyE+NK+dTTF
 sLusVFVbBzCo0g+OTqG3p7DslhJDrQHgcm8FIOK03a0EOvQmSzcgUvKdFd+NYOaAcaIJ
 1O9d5cX+/Wo6muUXcswRDzoIr+TIg0kKPfRIf9kCHjLWS2+QN/2dnSo0dj02KhhnE73R
 KD6Q4rm8yReI0cuKERhR+0h57Dvscqkwm6OftqYC/q3c8QKTtY62e9qQJPya25LoOoFb
 u0ilVt4Z6IeIEhdOIL8uJQwxP9yiJszogHvYUuxfg8sfJC5Jje0eTvXuwf/yXMUdszY5
 ft3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475118; x=1735079918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/SJ8lccCav6ChcddekLPgsSkxigdbVgR6d9YvtHR4g=;
 b=gZoY/dIglsfYVtDbSZK5F+vEn+kB48/SlkiuQFDRHY3Bg/5QdnnLsLupjPrF4ver0d
 UO5vjP+lvCxCJDaSDfCkeVhw3gK8BGJBE2ObSvQgc1Z/Ygb0KlL8zJYY4nXQ1WWMjXVB
 YWOMGzDmE7iUbi+Z+uLngMbB/3hkXm0Oi7kKyCqrrNGC0U5J0vJNjwqJz3IhI0bGz5G8
 ywJb3E5doNDwKHuQHzg6B8JNJq7r3FksJs/2diWFr1bNg45YxY83pAqpCP+GuKqINkY7
 FVtZ/jDpwtVIAlGe056WdTmMcjTyyDpvigFLgQaS9UFdBqD9vB9r+O6nQKAwsjCaOzCR
 bvkg==
X-Gm-Message-State: AOJu0Yw4wHV0THWVieJzpXIUXrXnjXBQxFQs61lkHEofmUze989vmIoe
 tTdUK+qdWTKRIbX9wx8cxfl2tv47f+HzPiwFhe25Q6hlbAGtFrSvwLTktEUCSqWwMAiF+F57i0S
 /yac=
X-Gm-Gg: ASbGnctgggYqW3thnhRpgctfLRCYF3XZB6UmBPiaShW1XEhlAp6MKilZjOM5rI0Eqwq
 MjL2lERX123XjVgyj8WgIO9sSqZaqYfLRjVG40dCPe6C9wdlkTBlkWBF8Im6oZDhCR5q1IPfy8J
 OrQ5F+vwzOhQJFiqQ7MDpIEVrz7Pa+7b3i9YE3A5vgO+JYxA5ArIHJ5mjI86X6ni17JoJ8vWKMT
 V/Zd3iyTQRgbhqveoVBasnjRdzjZujJHkwJdOaNqU7gKURrgl7wM2KL
X-Google-Smtp-Source: AGHT+IHbbfLni4t9BhV50Iy2UhoCdSpWY1XXFVem3nLMCiYSloMhqBgcsNz/1wouIpwYnh+g4tobIQ==
X-Received: by 2002:a17:902:e741:b0:216:386e:dbc with SMTP id
 d9443c01a7336-218d6fdfd08mr8068185ad.13.1734475117772; 
 Tue, 17 Dec 2024 14:38:37 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:37 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 08/11] contrib/plugins/cflow: fix 32-bit build
Date: Tue, 17 Dec 2024 14:38:22 -0800
Message-Id: <20241217223825.2895749-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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
 contrib/plugins/cflow.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index b39974d1cf3..930ecb46fcd 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -76,6 +76,8 @@ typedef struct {
 
 /* We use this to track the current execution state */
 typedef struct {
+    /* address of current translated block */
+    uint64_t tb_pc;
     /* address of end of block */
     uint64_t end_block;
     /* next pc after end of block */
@@ -85,6 +87,7 @@ typedef struct {
 } VCPUScoreBoard;
 
 /* descriptors for accessing the above scoreboard */
+static qemu_plugin_u64 tb_pc;
 static qemu_plugin_u64 end_block;
 static qemu_plugin_u64 pc_after_block;
 static qemu_plugin_u64 last_pc;
@@ -189,10 +192,11 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 static void plugin_init(void)
 {
     g_mutex_init(&node_lock);
-    nodes = g_hash_table_new(NULL, g_direct_equal);
+    nodes = g_hash_table_new(g_int64_hash, g_int64_equal);
     state = qemu_plugin_scoreboard_new(sizeof(VCPUScoreBoard));
 
     /* score board declarations */
+    tb_pc = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, tb_pc);
     end_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard,
                                                      end_block);
     pc_after_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard,
@@ -215,10 +219,10 @@ static NodeData *fetch_node(uint64_t addr, bool create_if_not_found)
     NodeData *node = NULL;
 
     g_mutex_lock(&node_lock);
-    node = (NodeData *) g_hash_table_lookup(nodes, (gconstpointer) addr);
+    node = (NodeData *) g_hash_table_lookup(nodes, &addr);
     if (!node && create_if_not_found) {
         node = create_node(addr);
-        g_hash_table_insert(nodes, (gpointer) addr, (gpointer) node);
+        g_hash_table_insert(nodes, &node->addr, node);
     }
     g_mutex_unlock(&node_lock);
     return node;
@@ -234,7 +238,7 @@ static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
     uint64_t lpc = qemu_plugin_u64_get(last_pc, cpu_index);
     uint64_t ebpc = qemu_plugin_u64_get(end_block, cpu_index);
     uint64_t npc = qemu_plugin_u64_get(pc_after_block, cpu_index);
-    uint64_t pc = GPOINTER_TO_UINT(udata);
+    uint64_t pc = qemu_plugin_u64_get(tb_pc, cpu_index);
 
     /* return early for address 0 */
     if (!lpc) {
@@ -305,10 +309,11 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
      * handle both early block exits and normal branches in the
      * callback if we hit it.
      */
-    gpointer udata = GUINT_TO_POINTER(pc);
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_STORE_U64, tb_pc, pc);
     qemu_plugin_register_vcpu_tb_exec_cond_cb(
         tb, vcpu_tb_branched_exec, QEMU_PLUGIN_CB_NO_REGS,
-        QEMU_PLUGIN_COND_NE, pc_after_block, pc, udata);
+        QEMU_PLUGIN_COND_NE, pc_after_block, pc, NULL);
 
     /*
      * Now we can set start/end for this block so the next block can
-- 
2.39.5


