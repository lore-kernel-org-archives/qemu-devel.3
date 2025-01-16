Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3D3C02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSVV-0008My-05; Thu, 16 Jan 2025 11:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTo-0003jN-MV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:31 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTg-0004UL-VV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:22 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so820535f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043935; x=1737648735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tw2ZvpgzU+NWUchIsRD68y5QyIwwYntbgovoaeHxtY=;
 b=U1jwbgSFYG60UK647y5+aYgFM18NZo8PYqwI5LflpqOLe/nEsIxiuZN3zPnC1AcnE/
 Vk/cXKmYUdFMiNSedUvfTKGsjuC0mJNa8q45xza7fmbGtadjknlfFenniAoguWDOai3J
 Xq8cZpKbdY/yZIAYaaXpDrG9Sxhh7mxN0/0ZYEomL3glgom/u0xbgmCcZXFj5M1HKRQ3
 lJvIdYygri2q/mwX64+xU6TcqxofE7wmd4vaObLqUGwuKi8DOAq4ahd1hGX/0L9W8hre
 azAa8qvnFVVSqYQOdJBGa5u6xzfbaOCfaaO2f0+LbSN8qL9ODXDQLLW3RZn3opTc4Unj
 qjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043935; x=1737648735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1tw2ZvpgzU+NWUchIsRD68y5QyIwwYntbgovoaeHxtY=;
 b=k0R+gIXQ84ZxABvy+gsCmpWSjeH1ZXKLlaozsq2jgEdbMTTF1/AdZw0lWqCzQTny1m
 NCZRGeZogNWcAUIULz7aTM0+bbAVcXtwkz8+DbJMrNJoDfFfnbW53Q1x7VLGy3tw4uLK
 mRqCok72sKqTzrC0H4zvXx9uIUGWz1sRM10rLQ4TVj1qJAaAkdOTSfr+NnPjhR7H+wmU
 l6nQUWJH5jCt7bhqA7aRN4YmlsB6peCyZ/c0UgHHGbxOq1HzhMRXrK9wDoqYwDOy00qJ
 z5gxgsUz1yQfWsomfIpEeSD5LTHHunQ0sm8tYDacMGkMtHSkZm+ePSPGSNHl3f2GsIUQ
 iKLg==
X-Gm-Message-State: AOJu0Yxa0Rxx4N8wYxgscAYlKSwMQI+K16+iGIjR8SLs/gylfY+kNPBU
 +DFUNGx9kEaf9CZy0+mVNM2Y7qsuLOq8oCEFcqTMEQ6yUGl5C+s/InsbmhzgH9w=
X-Gm-Gg: ASbGncv9YNi1INOyE3SG2V7Rfoh6iUtRHCPtCfs3VBNZnrdHtkf5BfeDzSP9edSTSt3
 VdqIILYdXm3MnQmGpkMjkEFL9JbjJEf6ck4oO7wbkR6TpeS0bkw1FTm4KRl/vX8fVkKh/Lbm5F7
 OuWVNTu0qTfOrpD+PYisduErQE5h6tBlfI41FB3KHFEasWhO1VY10LN7aGQ/E5R7YmZ4co7r9T1
 I4C5tygW8pK1vtUer8JqhgGwxMsUsPu5/DGDYmVAxc8c6h2EGa7dbA=
X-Google-Smtp-Source: AGHT+IGnfvTtnI7E4oNHqlXQI2bazi5SEQJtx08jOCHrkj2xZJGiDn5LEEmOYIhrudWVMrOpabQJUw==
X-Received: by 2002:a05:6000:18ad:b0:38a:6183:77b9 with SMTP id
 ffacd0b85a97d-38bec4eecb3mr2742753f8f.6.1737043934873; 
 Thu, 16 Jan 2025 08:12:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf321508esm248143f8f.10.2025.01.16.08.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 359786082D;
 Thu, 16 Jan 2025 16:03:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 18/37] contrib/plugins/cflow: fix 32-bit build
Date: Thu, 16 Jan 2025 16:02:47 +0000
Message-Id: <20250116160306.1709518-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


