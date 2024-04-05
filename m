Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF2ECD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgl9-0005zO-0v; Fri, 05 Apr 2024 06:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl4-0005xo-Iw
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:18 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl0-0004gj-Ke
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:18 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c5d940525fso985213b6e.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312713; x=1712917513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T2Vrez6mekYUNx0Ri9P+RnqhJ98QDuVTU99320zojAI=;
 b=dDKMe5PX+SCI1hyDq766XnWgLng6q+1UpnHE5WAbIOv8znedrMn2DN/4EcMzqcN6Kz
 PbKGsmZJP8jRM+aN4afLbO6JMgxpDCxA06/wmoBrmyvCCCG1t2BzMZtUJN0tRgUSAnMg
 XrIxKMzCGLKX2CXOFHPCh2RAtb/aP0dq2FuKW4fQ+ljkZS/kxYK+4/2SQnHp0Q43HgIz
 dwyTqIFpvfgP7PTS/NPoN6EbyA9V+dVEWKg4cFOM3Ry15XZ3XIelbvG8hZS9Y/jkAQBj
 cCwXReudAo03yJ+G3Gl8Oc1Rvij/C2Nm/PT0iu5FVJXH7QFD0SNxQgzrfCEFSgs081Z1
 hbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312713; x=1712917513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2Vrez6mekYUNx0Ri9P+RnqhJ98QDuVTU99320zojAI=;
 b=AfGDb3LxCpSt3Xk2GgPeg3TElIyPmDkQgNvDr0kSAZdg545SRNAHlt22IOJcWdpVvC
 70I7UT35n8Aj4wZT3furTZVC9gXGf8zUndLlzQsq3umIuNpGx88sOxBZxbc0X7mBk4ly
 73+spqED0yFEPXRmw8PfRhyRuVw6ZcmNVA9SgVFfYoyfdpgqyejoccxhu2aJ+meRBEBk
 ib/KhM/xhqPam5uxIW2+hQBUVAM55St78PlJrHTb0x/+XgnPYf57m5Uq5zjSuE/Nbi3T
 BbPEL0wBSA+M9e2f3vleUIJEs0uQrbFXlnzlAH4Dkhee6iFN/eMo7w7GRP9uMwyfw4c4
 xnpg==
X-Gm-Message-State: AOJu0YxSlgh9p3ojEsMNzp3Mcvblz2Ve5cc4ww8Y/9SZW2luSZeGMULx
 CaVrZsn9FRMOOnRxcgUWEpZl0u+VCJv9Cvjs4pFkKJ2TOwIx8NkNeaGDDCiF8OtgdoEbbb+Zwnu
 2
X-Google-Smtp-Source: AGHT+IGaqKktYn/ESAZw0S3W7PI9A5XtP0RlpzTip8PJiK/9BGrrhModXSNJgL9DJ37ERTqDLdS2yg==
X-Received: by 2002:a05:6870:829f:b0:22e:aa18:bdd5 with SMTP id
 q31-20020a056870829f00b0022eaa18bdd5mr1241356oae.12.1712312713376; 
 Fri, 05 Apr 2024 03:25:13 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/32] plugins: Copy memory in qemu_plugin_insn_data
Date: Fri,  5 Apr 2024 00:24:36 -1000
Message-Id: <20240405102459.462551-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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


