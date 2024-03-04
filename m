Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB768C54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7wQ-00010B-L5; Mon, 04 Mar 2024 08:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7wJ-0000qy-NQ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:07 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7wH-0000Xp-Ou
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:07 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a45670f9508so84630666b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709557263; x=1710162063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5Cts3jLtVZqVds2/HzjKgVNqkIHL6jaHibVwwKPKDg=;
 b=vnYRHdud61lEDrF2aSmerfLP2IoioTVCH9820Cf65gnEEem69keCRNSwpCA4fW25ww
 jWvZRc79CO8mTNz5LDvIXaCrwRS3j5/bCXZQMzW25vmfmuxlYKc5csrC297VMaCEVlwD
 pRrWOx2l98cfe3Ow/vFbBEmBNgmgsXl3XyQlQTWp/54cTTkawItv9SuxnQte164UxgKh
 9njcqUEC3pGFgk5WSXfpt81EKYgmmIDWgpwaeS5wH0baBf/rWMAp0fkxd/BPI5rlMO9N
 oRUb2V9IycHyBdOzikh/QLMVzXmAZ4h+1Lk+yBbrbaQQt2QsJmk28VmXo+v56eAQpMN6
 i0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709557263; x=1710162063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5Cts3jLtVZqVds2/HzjKgVNqkIHL6jaHibVwwKPKDg=;
 b=xKESlc4F6j6633OzCFCyN5THErUdeVBOv8pHfg9NdqKThMdsQpCfodPmH+WSvUdljb
 kiRAh+StxHGkgKOvtrHb3Lhr03HimHX14GTehumj5QW6QuAw+uUTKwfoZzQY2q15ASVo
 4hO826nTZO1SXTcVTYq38q/2nrOdWlZ9mUsIcQAyCoNMrhoWhNBALRpub7LsrCSPXX4v
 YpD/M2bbDMIApABRN45amVXe9lTDak1Fy/FnhLEyE6ACUgfCqakO6G3BTH11Hx9AsrnQ
 QmTCVPoK0rirbUMKW9/51qKexFxqgGVH91pvSh0S1pJUWm4hb4qHi3qIuCujZEs5ZPBt
 sl7g==
X-Gm-Message-State: AOJu0Yzfnh3MY9UqUq5RnxiLD+3oTmCluYSk3SX7yex7V/qdICpnxrhd
 i58AsuV+004s0jKwV/t5lVEPyAcivc7OEfkfdroIsqyM71Erxsc7JBNl9NiknV2OwBSc7C3J3cm
 i6ro=
X-Google-Smtp-Source: AGHT+IE0TtH/eDDHDNKhDxAvQploDMzhXJ8tyZlskKUXM7tF0yzuxcUOw0cQGgPxYNBh9OwNpGq28w==
X-Received: by 2002:a17:906:4f02:b0:a45:3ca0:40c2 with SMTP id
 t2-20020a1709064f0200b00a453ca040c2mr1976378eju.74.1709557263173; 
 Mon, 04 Mar 2024 05:01:03 -0800 (PST)
Received: from debian.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 tj7-20020a170907c24700b00a413d1eda4bsm4806136ejc.87.2024.03.04.05.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:01:02 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 02/12] plugins: define qemu_plugin_u64
Date: Mon,  4 Mar 2024 17:00:26 +0400
Message-Id: <20240304130036.124418-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
References: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Additionally to the scoreboard, we define a qemu_plugin_u64, which is a
simple struct holding a pointer to a scoreboard, and a given offset.
This allows to have a scoreboard containing structs, without having to
bring offset to operate on a specific field.

Since most of the plugins are simply collecting a sum of per-cpu values,
qemu_plugin_u64 directly support this operation as well.

All inline operations defined later will use a qemu_plugin_u64 as input.

New functions:
- qemu_plugin_u64_add
- qemu_plugin_u64_get
- qemu_plugin_u64_set
- qemu_plugin_u64_sum
New macros:
- qemu_plugin_scoreboard_u64
- qemu_plugin_scoreboard_u64_in_struct

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 52 ++++++++++++++++++++++++++++++++++++
 plugins/api.c                | 34 +++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  4 +++
 3 files changed, 90 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 31c468ddb2c..ebf9a645e15 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -225,6 +225,17 @@ struct qemu_plugin_insn;
 /** struct qemu_plugin_scoreboard - Opaque handle for a scoreboard */
 struct qemu_plugin_scoreboard;
 
+/**
+ * typedef qemu_plugin_u64 - uint64_t member of an entry in a scoreboard
+ *
+ * This field allows to access a specific uint64_t member in one given entry,
+ * located at a specified offset. Inline operations expect this as entry.
+ */
+typedef struct {
+    struct qemu_plugin_scoreboard *score;
+    size_t offset;
+} qemu_plugin_u64;
+
 /**
  * enum qemu_plugin_cb_flags - type of callback
  *
@@ -784,4 +795,45 @@ QEMU_PLUGIN_API
 void *qemu_plugin_scoreboard_find(struct qemu_plugin_scoreboard *score,
                                   unsigned int vcpu_index);
 
+/* Macros to define a qemu_plugin_u64 */
+#define qemu_plugin_scoreboard_u64(score) \
+    (qemu_plugin_u64) {score, 0}
+#define qemu_plugin_scoreboard_u64_in_struct(score, type, member) \
+    (qemu_plugin_u64) {score, offsetof(type, member)}
+
+/**
+ * qemu_plugin_u64_add() - add a value to a qemu_plugin_u64 for a given vcpu
+ * @entry: entry to query
+ * @vcpu_index: entry index
+ * @added: value to add
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_u64_add(qemu_plugin_u64 entry, unsigned int vcpu_index,
+                         uint64_t added);
+
+/**
+ * qemu_plugin_u64_get() - get value of a qemu_plugin_u64 for a given vcpu
+ * @entry: entry to query
+ * @vcpu_index: entry index
+ */
+QEMU_PLUGIN_API
+uint64_t qemu_plugin_u64_get(qemu_plugin_u64 entry, unsigned int vcpu_index);
+
+/**
+ * qemu_plugin_u64_set() - set value of a qemu_plugin_u64 for a given vcpu
+ * @entry: entry to query
+ * @vcpu_index: entry index
+ * @val: new value
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
+                         uint64_t val);
+
+/**
+ * qemu_plugin_u64_sum() - return sum of all vcpu entries in a scoreboard
+ * @entry: entry to sum
+ */
+QEMU_PLUGIN_API
+uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
+
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index f8b15510ff7..f4518a68afe 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -484,3 +484,37 @@ void *qemu_plugin_scoreboard_find(struct qemu_plugin_scoreboard *score,
     char *base_ptr = score->data->data;
     return base_ptr + vcpu_index * g_array_get_element_size(score->data);
 }
+
+static uint64_t *plugin_u64_address(qemu_plugin_u64 entry,
+                                    unsigned int vcpu_index)
+{
+    char *ptr = qemu_plugin_scoreboard_find(entry.score, vcpu_index);
+    return (uint64_t *)(ptr + entry.offset);
+}
+
+void qemu_plugin_u64_add(qemu_plugin_u64 entry, unsigned int vcpu_index,
+                         uint64_t added)
+{
+    *plugin_u64_address(entry, vcpu_index) += added;
+}
+
+uint64_t qemu_plugin_u64_get(qemu_plugin_u64 entry,
+                             unsigned int vcpu_index)
+{
+    return *plugin_u64_address(entry, vcpu_index);
+}
+
+void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
+                         uint64_t val)
+{
+    *plugin_u64_address(entry, vcpu_index) = val;
+}
+
+uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry)
+{
+    uint64_t total = 0;
+    for (int i = 0, n = qemu_plugin_num_vcpus(); i < n; ++i) {
+        total += qemu_plugin_u64_get(entry, i);
+    }
+    return total;
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 3f93e7d6b13..6204453d0fd 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -44,6 +44,10 @@
   qemu_plugin_tb_get_insn;
   qemu_plugin_tb_n_insns;
   qemu_plugin_tb_vaddr;
+  qemu_plugin_u64_add;
+  qemu_plugin_u64_get;
+  qemu_plugin_u64_set;
+  qemu_plugin_u64_sum;
   qemu_plugin_uninstall;
   qemu_plugin_vcpu_for_each;
 };
-- 
2.39.2


