Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658FDC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdO-0001KC-A1; Fri, 17 Jan 2025 08:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcy-00010x-Gz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:13 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcv-0002Ev-NY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:12 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab39f84cbf1so8394666b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121388; x=1737726188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiXe8STMjZ/F+kxQHLyLYOsg7/4BbTiTdjsaFjR8pnU=;
 b=J4+PKZNrBMkMZKJdWqT+lRuU7hKImRtkkAfJ2J4v20tnA2knEYHUWoAUXQB72l42yt
 v+ilVvRziKNi7A+vh+ke5RDpHzDHxRWLgdLCzzjkxn1L8wfITBidTns/5k645+6UOScd
 vU/T9jlT3WWqug7k0U33EAxcKmvEKQLXjhRO+NrsUmhV/FomggXcKEzJIgVcfy4UZdEi
 kPlvqw1+lV+9vjRwdIBPOnHxlmWxZ3p7fljGgnlGPjPKGk5zT0H/A4GtGfjPQ6RxT/jB
 cVKxobhbCMEuZiVMWJJLWupSXGDBzfueJJsYf4fVrnuOs7FOmxd2tAPOwxj3sJS6uYes
 C+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121388; x=1737726188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiXe8STMjZ/F+kxQHLyLYOsg7/4BbTiTdjsaFjR8pnU=;
 b=ZcFM9yzQ+x4n75HjnU8D0KgAp8XyoBlPn2zaXNvbA80lmydAsQYDzBzKyFrYytgte2
 HIfAjYNNITwdUn/O+/qYYdcztJEdRB27nJlvZlqfO3cg+DwUYjEtH5soTZeuHNcKSl2E
 enBsIzAhFpOmWIiU8hY0eeu5jMHhvlASokp1Djtnlhf25HAOe36Z3An+g9gSmGvWzKLs
 DyhNSuhuDtKOzwMJ5VBj/7Xs/Mp/JekiTQrBd+Mf4XKMHnD3qi4yxciM2onyqaG3aSuC
 oMSgfNOUoKNYNCsJNo86fOaVnAEtOxPAVYu1NIUm6yh8J+yAmd14+oncg7aa2SrV3d48
 FBFw==
X-Gm-Message-State: AOJu0YzakgO4Ay7tSIaNIDOKkBRLbSPmD32AG25RGLwfKmZyoDhSmegb
 NVUdMhfkA+1d1fWdqP/lJRq7Sh4ElxR5ngz/G3kocZNaUbaAHSBDKLi5DLUcvkQ=
X-Gm-Gg: ASbGncuyTR3Elm8jOcmvD+MBS0vTf7fI7jNXnTFo0v0Hb64dOqi9eY9lMSMGLE0AYML
 BHt3q4hNVgWrq8dSYGb1x+vpwa41haFppfZtILHT9DAxG/SXGeHyPOZ3etWIMD+q9iAatEvU7WO
 DnnQ8jufg/iBudBaMpCmCvijCiJKPMdXMtMetxuAsQC3twBJArjBRWJ554VGZwZZv8lJtghEGai
 7yW85PFHubzlh++Dpy10aCxMLxP8dObSW3xd/FtASLVpZ9XRzCk/9g=
X-Google-Smtp-Source: AGHT+IEN5n82hptquB3NRYEd4t3U1UsYOBI1zv/AsqeQsilEI7ArhLP0ncotOkDSpcDDkh2e0LaDbg==
X-Received: by 2002:a17:907:c0d:b0:ab2:f5e9:9a39 with SMTP id
 a640c23a62f3a-ab38b15d2camr244111866b.23.1737121387859; 
 Fri, 17 Jan 2025 05:43:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab39aa6a7besm38099866b.68.2025.01.17.05.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:04 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 96939608C2;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 18/37] contrib/plugins/cflow: fix 32-bit build
Date: Fri, 17 Jan 2025 13:42:37 +0000
Message-Id: <20250117134256.2079356-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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
Message-Id: <20250116160306.1709518-19-alex.bennee@linaro.org>

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


