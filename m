Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B1BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5d-0005qT-DT; Wed, 24 Apr 2024 19:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5Y-0005ob-Ux
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:44 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5W-0003S0-R2
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:44 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2a54fb929c8so340442a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001501; x=1714606301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T2Vrez6mekYUNx0Ri9P+RnqhJ98QDuVTU99320zojAI=;
 b=ILrRpKxmhE4zjNTCIk5BVahwlp9KytRwYBThqbPsZb8nliuSXvlgsYAob+KVhCQR39
 US8DLDVhXkFxCGZ6SE7s8BFjxOJXmD7yqU+j7QSJk3qIJPckhMywk0VLMzbnPZSqQ25f
 GwLtSJ10yjDdAqJ8+PxYdUaTl9Fe0CoNAEisnHg0bhfM93EyfToL+6alLCDEijUoDc7Z
 xlhj7GK+vufpPGOw9J/T4HLyHS4NeITdFzX9N9ngntdNpCrVXMseh1Eu5pNvZzFwb9wu
 wK3F2410lLXDTSK/DnByLCc5IUUsXPnZQZvgtHxk9eWR7SMhBXe2ZsHO7FSYno6g+0YL
 L06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001501; x=1714606301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2Vrez6mekYUNx0Ri9P+RnqhJ98QDuVTU99320zojAI=;
 b=ay3uDdfwgC2YJcFgy0Nc3b2q/tqOiDp/udq2R0H6ub8ENaF4Kkl/MmOU0JkvOvMrcu
 9ML/5uuN6IV6vWeHddDbq8WPXkQfQBmQxJOmMFSELWiU4FqTg/w8hwukhAxjFi8EVuvq
 yFIyqeEFvQaqJxEbJ7N50GkEoRYCM9wqd7uOUYMeteze5MZlvleUHxpgrlt6QLPfYdbS
 eUiB/RG9OyDE51TJJzyFTMti1922NvlsY5uztoJwNNDsSQ2oKshb5yA4nE52Sg4L7cT7
 dxnvnrhUsneBVI5nqxhq7GQuSvEtsHs8czAFXmPWvm1diA5tBgLhOzzVZJFz4IukOpMp
 zcdA==
X-Gm-Message-State: AOJu0Yx+0UtdM1HkGbvI4I7+orpWip4K/STIlO7MGeOfSoWpZ4Af/NYj
 7faEgslPXJ/Pn02v2rNCb/87UKpi7BgpQeyFBACO5Bg2RDnryGfD2pj9VCKJ4ZNcHKw9I9i0A7f
 i
X-Google-Smtp-Source: AGHT+IGSxH0YofhAnkCHIa/4vUIhGsZhYuz5pWwJtQyMV3R1aeor4JJZ69Xy2YSP+4EGYEYnyxYBzg==
X-Received: by 2002:a17:90a:8405:b0:2aa:c5a0:99a7 with SMTP id
 j5-20020a17090a840500b002aac5a099a7mr4181726pjn.12.1714001501214; 
 Wed, 24 Apr 2024 16:31:41 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/33] plugins: Copy memory in qemu_plugin_insn_data
Date: Wed, 24 Apr 2024 16:31:07 -0700
Message-Id: <20240424233131.988727-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Instead of returning a host pointer, copy the data into
storage provided by the caller.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/qemu-plugin.h | 15 +++++++--------
 contrib/plugins/execlog.c  |  5 +++--
 contrib/plugins/howvec.c   |  4 ++--
 plugins/api.c              |  7 +++++--
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4fc6c3739b..5f36c2d1ac 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -61,7 +61,7 @@ typedef uint64_t qemu_plugin_id_t;
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 2
+#define QEMU_PLUGIN_VERSION 3
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -394,17 +394,16 @@ struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
 
 /**
- * qemu_plugin_insn_data() - return ptr to instruction data
+ * qemu_plugin_insn_data() - copy instruction data
  * @insn: opaque instruction handle from qemu_plugin_tb_get_insn()
+ * @dest: destination into which data is copied
+ * @len: length of dest
  *
- * Note: data is only valid for duration of callback. See
- * qemu_plugin_insn_size() to calculate size of stream.
- *
- * Returns: pointer to a stream of bytes containing the value of this
- * instructions opcode.
+ * Returns the number of bytes copied, minimum of @len and insn size.
  */
 QEMU_PLUGIN_API
-const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
+size_t qemu_plugin_insn_data(const struct qemu_plugin_insn *insn,
+                             void *dest, size_t len);
 
 /**
  * qemu_plugin_insn_size() - return size of instruction
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index fab18113d4..371db97eb1 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -258,8 +258,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                                        NULL);
             }
         } else {
-            uint32_t insn_opcode;
-            insn_opcode = *((uint32_t *)qemu_plugin_insn_data(insn));
+            uint32_t insn_opcode = 0;
+            qemu_plugin_insn_data(insn, &insn_opcode, sizeof(insn_opcode));
+
             char *output = g_strdup_printf("0x%"PRIx64", 0x%"PRIx32", \"%s\"",
                                            insn_vaddr, insn_opcode, insn_disas);
 
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 94bbc53820..9be67f7453 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -252,7 +252,7 @@ static struct qemu_plugin_scoreboard *find_counter(
 {
     int i;
     uint64_t *cnt = NULL;
-    uint32_t opcode;
+    uint32_t opcode = 0;
     InsnClassExecCount *class = NULL;
 
     /*
@@ -261,7 +261,7 @@ static struct qemu_plugin_scoreboard *find_counter(
      * They would probably benefit from a more tailored plugin.
      * However we can fall back to individual instruction counting.
      */
-    opcode = *((uint32_t *)qemu_plugin_insn_data(insn));
+    qemu_plugin_insn_data(insn, &opcode, sizeof(opcode));
 
     for (i = 0; !cnt && i < class_table_sz; i++) {
         class = &class_table[i];
diff --git a/plugins/api.c b/plugins/api.c
index 3912c9cc8f..4e9125ea29 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -216,9 +216,12 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
  * instruction being translated.
  */
 
-const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn)
+size_t qemu_plugin_insn_data(const struct qemu_plugin_insn *insn,
+                             void *dest, size_t len)
 {
-    return insn->data->data;
+    len = MIN(len, insn->data->len);
+    memcpy(dest, insn->data->data, len);
+    return len;
 }
 
 size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn)
-- 
2.34.1


