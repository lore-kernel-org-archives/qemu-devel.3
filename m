Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F00C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rh-00048H-IQ; Wed, 15 May 2024 03:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rc-00045A-9X
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RZ-0001ZK-60
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-420180b5898so18897865e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759576; x=1716364376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtQK7Z5/e08tg2ZG57AjvcglO+yjRFx9a1dcx4y70SE=;
 b=IERvbZaenhzUbRe8lCagMk4x/mlhJswv8u1YyHQUqaYWnuZtz1CZEBmaVq+jn1FJKj
 FAiHgIwazbwQ256YUvVCyLXRryo8VGmc6vXdnlJw+gg998f6+YPArYIop+dOXZF9Dtk3
 TUOdcCVZ16fq3UtTt1f5QtyZTm79uVhQK6IANpFeFwAJHrku6Er1D8ccktf+J/a3kobb
 m3zUzpbtAks2InYhJvh1jbcA6njtyPuQ7HS+pX6dC5szo/C45Rhe+luU6hRWSseinwmx
 jUFlhxfeOMFKshtnz823BTjrN9ksahns0x2PTfx4w6oaR3Cpz2umjJpaJaDF9vm1Su54
 SpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759576; x=1716364376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CtQK7Z5/e08tg2ZG57AjvcglO+yjRFx9a1dcx4y70SE=;
 b=p7O8k5szPdUrj1rZsCda4QjKVZkNEYViS57vxxLGklKMpl0JQEuv1fjSDtVJtm/mQ1
 2x4PuOfDhbEVQIMatZ9EhF6LfMiLevKm8RMGtY6H2/PMKeWBnsp5kY21joDE7nOKT8zT
 4yKbeEKbLEjvLBmJx0Y2myg7SCICbkRsOmSBrLE24s9G5ou7KpI8hhocQym8G1/0iyKI
 kEdbcm2+mATufg9DnyIG+EWD2AMA7v5zl7bdoY6oVKI7EUm+q7UFN5synh3EJsumL8ni
 wKNG6eEUofr9MDwq57vcFCzaTEAymR2AaYi9tN3wQPXRcPnWAMq0QUi9RhLJPfRwAscU
 4gHA==
X-Gm-Message-State: AOJu0YyLZc1m7bcU1UXlxM6yKckIH5RndaTW87U6oimFw686CMmUGXGd
 zYaWSJ8lJrp1H4Z40vd4CYcurnNruD1Q6CZQvdRqjEIh6NJNE9ohBHvrtMogT71pjmR9YHj3VbL
 rSh4=
X-Google-Smtp-Source: AGHT+IFZDTUoIfvdFaFjiR6wL3uvvuLEhv8DXG7nZiF3Wztz8Ypwh38hbExnnJ2xXbZvX85OgadJJQ==
X-Received: by 2002:a05:600c:3108:b0:419:678e:64ce with SMTP id
 5b1f17b1804b1-41fead6ae05mr118953635e9.36.1715759575849; 
 Wed, 15 May 2024 00:52:55 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/34] plugins: Copy memory in qemu_plugin_insn_data
Date: Wed, 15 May 2024 09:52:22 +0200
Message-Id: <20240515075247.68024-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 2144da1fe8..5ff4e9d325 100644
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


