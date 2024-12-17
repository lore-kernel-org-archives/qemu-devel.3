Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620E8E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3u-0008KJ-7A; Mon, 16 Dec 2024 20:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3f-0008Hu-W2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:32 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3c-0004ym-6K
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:30 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2164b662090so37317485ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397647; x=1735002447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/SJ8lccCav6ChcddekLPgsSkxigdbVgR6d9YvtHR4g=;
 b=xZVrHgbGlqVQAW37RsY5ho6l/MUYpEYktwyHDvaNnVNEWOxydFqGEtQSKcAJirKr+t
 iKZOj/X0Hc6WF0Qsjt8Oe11wiqG5G11di1pHH0Xlru14GWvptmdyeU6wVaDQEEHejtVp
 0A6+2DylIvbIE/DRER+5SM5QHPkXmx27MNJDYy1sW+e6d+c3cbV8e09q+RE/7WyNStQk
 yUNgpr7g8PohRtnjJLOh1OLf32KTNgcrPPz3FJCJMw9/Kv8xnAVldnRTgbyv2ql0lAhI
 4QjlV+/a4KySODYjcMhSeiC2Ksxh8juEVL2hzHabi0JXTSgIl/gO+kagWTOl/GC64P/q
 HufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397647; x=1735002447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/SJ8lccCav6ChcddekLPgsSkxigdbVgR6d9YvtHR4g=;
 b=dZzu5/O0WdzDUaxGDO3sDu5mFafHQ9uQpQsFNHovSjdUy7i57vg4f6obfOkDo+Q4+n
 EcMURo5xcnEFKUqrRCw4IqZSeLk5XYPWfr4d8Yk3tiNYNNjpLN4vUS9rEHH4CCHZEE4L
 mA8R7JlUhoYgs81qbWnrCIz60TckBCwKU7wxHB8ejaJChVzifcPOJ4UjSGba13vNmZBG
 bDKY4oMYn4Zqu2mTPHDJroDfgZBRhgmxDwsPV49cYsCF9mGYRgqNRmqelMjohbaDw1jd
 zTTlFZyPGhOllYPCqRy4W2ikLtcTeC76agpU4NivXZ6ZA25MjRDseeAQuJ09aNMCUJEJ
 ghiQ==
X-Gm-Message-State: AOJu0YzbgbHOrWJ7ebIJYTB68ttnZkfzSb3uBZT6MEoH2w+0DrVv2R6E
 Px4Ep0mAaCMaw3aNykCpaGZyjHoNolRnKL1NS6oYVTJIyA2czePeC9EJbKPeEpOJf5WG4yeow+P
 I5kk=
X-Gm-Gg: ASbGncuuuWqh11bRxtcxw6WS0nY2G+XNinYGTzHZw2hCKxso1Ma7b5TlRepTFGzlosX
 dcinqyFFH/EhQFe9gxakTestlbWkzIZ/IIMNwOQImDgz4Zw03/ulCEDTsoZsw3hne5oKDyZBLZ0
 goo16elUE0MnRoBFWijx0GrxI50jjPEtkusbP8k2Gm0gIZDUPl3rzsfsFb259c/Qj9a+FPbqbTi
 UW9Kg91fbO1mricmBLl+zeLQL5nwqf0E0pKtZXty66eT6RqGNK4yOhoHZm+b5NFVZhRFVlJKqbV
 wAIoJ/Bl7mDEGPs=
X-Google-Smtp-Source: AGHT+IG4iQ39pa5kcA70JuHX6P8I+qAW0DvHvglLdMyyKL04C6ryTKFxQJWX9m3xXZqRYMmlEl82EA==
X-Received: by 2002:a17:902:da8f:b0:216:51fb:bb28 with SMTP id
 d9443c01a7336-218c9024fd8mr17837005ad.51.1734397646947; 
 Mon, 16 Dec 2024 17:07:26 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:26 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 10/13] contrib/plugins/cflow: fix 32-bit build
Date: Mon, 16 Dec 2024 17:07:04 -0800
Message-Id: <20241217010707.2557258-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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


