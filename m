Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E74C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfG0-0005Fu-Hw; Tue, 14 Jan 2025 06:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFk-00057s-QY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:39 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFi-0005RG-1f
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:36 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3d2a30afcso8965857a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854712; x=1737459512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tw2ZvpgzU+NWUchIsRD68y5QyIwwYntbgovoaeHxtY=;
 b=bLxZWzE4VnYikUOh4+mFixrEzmJ3y3HvjNYGuY24XYuTKAgNufCDLtmiiPnvBB6DjQ
 8fqG89Xtj7koZ9MmryDrn3PzvXr09WNNhTSsIPZis8r76Fg/Gul8hMQYirxPjb5k0TMc
 MIGc4N8h7lymABzvoGLaIk+msEXiywK/Mz6FpHo4dtaLj3XRyJiPzVtQjPW/DI/duxDP
 u993zTfthjINTWtYQDqoUiiY9kRM+4SjxsHIss6p54/OhaYX5FFtZyCsLvn6Nxpnd/o+
 +k8f1iXhlAgGJ6iK2UpYEiaQttMd8gWZ0WVA+lxk6/Nb2smCIkfjVPNltbXVxEWZV+2l
 n7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854712; x=1737459512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1tw2ZvpgzU+NWUchIsRD68y5QyIwwYntbgovoaeHxtY=;
 b=H68Gvw/okiuTFzXXOPZgr4IT4oPOmkqx5mJ6MvsAve1LyOjJnO7OHUdIDvOyCQ9IYT
 bTQFxRXCAjtsr5c0fNLeNO81SM+VTTLe7jc76z/Zi7qSFIAnTJjwx5I34ES4EbYQqhNW
 TE0a2TDmwnFLpQg+w44EuKql+8G0WihGu7iWhlGxLlTMjOCPjgNQ1dG0udvZyJ9ybicE
 fAbhGAK03srXvf55fqpQKsmPwn+wJJISpetAjkZC6jFPbtri/Oa/PqFYo4FuGViMwG+X
 620XSEDZ8r1rJVsywIgJ5HFXagSGW0dcwKG4omF33ghcEl8sRMGtmGVdwlnumHrn+VLi
 CoEA==
X-Gm-Message-State: AOJu0Yxdsx1XXTUDV4C7NsKZfSPeezme7BrLunfYn5QbnP7zI37Bhddt
 GE9BSPitSvlASLgHeHMJngodapwWt0NoqCsSi3DbNT2fJdW9R0/hOFA/7zMwarM=
X-Gm-Gg: ASbGncsEpDXxelYMaa8PoyDIsj2PxPz2/ih0oXAOx8l9iJxRJcdB8Kluf9np6qZPlB+
 Q+hvLzkkUiq+39weeDjXuhgpmGN2vgfYaovqNTMmfNbDru0Ovz1PiG/v4EGgUN7/pjH6lGe+Ol2
 3D3Y2oCtfjOdy1CjkOz2usYDMgLGtx9zmZPtGhmtfRWx7FzGwZmaDdZgDhuo70nRTQTihvYq8Jj
 bJA/kijTV/8t1rvYRmFjWRdD+s3Eyh0wP6G0eFXc24nf5oKxdqNIwE=
X-Google-Smtp-Source: AGHT+IH5l8tyYZzDXjxfReJ7G5JPeLJ/xOhm5FIlHm0HKvPfvl4RjUelb8Uf1wr0l+ZfG8ujHB3SLw==
X-Received: by 2002:a17:907:3f95:b0:aae:b259:ef6a with SMTP id
 a640c23a62f3a-ab2aad3a453mr2389981466b.0.1736854712532; 
 Tue, 14 Jan 2025 03:38:32 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905ecb7sm618679266b.26.2025.01.14.03.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 739925FA08;
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
Subject: [PATCH v2 18/37] contrib/plugins/cflow: fix 32-bit build
Date: Tue, 14 Jan 2025 11:38:02 +0000
Message-Id: <20250114113821.768750-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-9-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/cflow.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index b39974d1cf..930ecb46fc 100644
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


