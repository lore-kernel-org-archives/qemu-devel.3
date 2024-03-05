Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03515C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTeu-0006FW-Bm; Tue, 05 Mar 2024 07:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTdh-0002gy-Uk
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:11:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcr-0001VG-Fg
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:11:20 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412de18edcaso17025045e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640620; x=1710245420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqNj0COIQuCCXg0hZT7WW42rxn79Q0Rei6wd0zzibZM=;
 b=QEiKOBRz+cu1icMi/mXn8vteHRi2/VIxGbfHCbDcSSFWUcPDqZJh/Mt2dC5fNZ9r/2
 u5fMltc7OApY5sHa/d4FEw4GoYkRP4BlV6JRvmgRE3vMFuW4PdNL/bv2AtPyXVDasTD/
 /ndXSaCQkh22Z1j2u94i7BJ/EuaabAZb1MajmT8oP1EOXbNtBMITTgRBeRmbgulz8SVk
 ygJ0sX4cZ2nhi0AZ84HQUvFgNkvaiE7ijOiNJhYVP++ObuXkNx88nvdfue1mw5jvLlhC
 o8Qy5dH1ZzyjUBGsn3wJSKPvC4HJsiC86vuoUPAtdbyRwzyfsCoYyseacCCrSB0VeH7t
 46rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640620; x=1710245420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqNj0COIQuCCXg0hZT7WW42rxn79Q0Rei6wd0zzibZM=;
 b=ECONR1wCMzXzEPIotWRhT+tsqXyT58X22QKycDsOLZypo/CUVEQ5BsdiqpS/a9Q0S0
 Czpjrs/H47wvFqCzpVfXVbE6fajpFzXh8+VDLjOOK1eL/8qdQJonUuJRh0FsgtT4FcWJ
 g0FdtGqDoHAVcIpDQDq60Rm1nuNazaLgANZGkzzegZduNgqAmDGzwI7zexYRi5Qab6W9
 xop5lrwaqomZjpGzLEFzDHyuTw2u8O7CMmGGGzUGEdWbGwH8bBtQlLn2Iy44YnJBrXvy
 MmCN2v56XUcXg6BLhxyaA8u0oztOA9MDalU/9dZIk0ARwDXqg/+faffprbFluSWbNdl0
 zI5Q==
X-Gm-Message-State: AOJu0Yy7p0IUxP7MMlu5URD51aBXVx+YiSGyufKKGsb4pBobKpVV4EWS
 QS6zEC4ub4gNi6UlPnjtr1MfrMaB6znZ8jZXjfjrL4oTijNKmp2Xp7TwpskykzE=
X-Google-Smtp-Source: AGHT+IEqVG6j+NSW1otiPJgcGPmMZvnShCR4A9sLFt8NX4RKuQuujLXaq43uqssyg5ssOHVIvgapgA==
X-Received: by 2002:a05:600c:1546:b0:412:e7e1:b5c with SMTP id
 f6-20020a05600c154600b00412e7e10b5cmr2930430wmg.15.1709640620050; 
 Tue, 05 Mar 2024 04:10:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k40-20020a05600c1ca800b00412b643b5a3sm17627256wms.11.2024.03.05.04.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E54B75F9DF;
 Tue,  5 Mar 2024 12:10:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 15/29] plugins: define qemu_plugin_u64
Date: Tue,  5 Mar 2024 12:09:51 +0000
Message-Id: <20240305121005.3528075-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Message-Id: <20240304130036.124418-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
index 76b2e652b9c..8910cbb2c46 100644
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


