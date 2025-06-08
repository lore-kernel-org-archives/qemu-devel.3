Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFD0C5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 22:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOOrl-00059I-5D; Sun, 08 Jun 2025 18:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOOrg-00057w-Q6
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:51:44 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOOre-00030S-Vt
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:51:44 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so3098194a12.2
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749423101; x=1750027901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kHyq1A+XK96SyPvU4MKltHc8xWdrIyj5Y6tcGDR4NI=;
 b=XrtbuLpigduj3LBU+xDBRFAy1NacDxKrc28htJ2rKeI6LacSjDrdF4ZbSJekLEzI3d
 GcP1d6Z3Wvu4Y6yqyZlF8uBWL3GHNULUiPAHIem3YyEKyMZZCXh48mHoIGdykUgJunTy
 crfJz8AZDiuEHmxGUiPJ4o5noq3svuJKihxM2YzmbACvzA+WuGcnOiIuBtnhfHxRl6zL
 a0uYLsJBEWzYsc+qJBYnHf58CCxBPsmvfSrlKrD0rnaiGeFs9CYw0rFhFUf9WIVAzWnX
 tMHVUzl7wPfmzzdUMR4Lf1cG9Cgx0B41Xq5DRVLnB/5l7ftcdjnKxiF/WEQaO4eoU4oI
 OXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749423101; x=1750027901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kHyq1A+XK96SyPvU4MKltHc8xWdrIyj5Y6tcGDR4NI=;
 b=T/BDdG+kBSX1f8pLfSgU/ulMdi/7YzBso5yocGqHhj8K1OBY3E6Udn/37X1AVFmEnT
 BKkIISO0sviPrUctrJS3Q+5xBoFeJac9aQD8vUT1l9fT8+AbiAB0dvLoky+L/DAf4+Y/
 YjrwIUli2F/8z2vsC60oedzP19RUO2U12PjNjZFXdjbuxVYhqlfkaiftYUbD46boOBis
 CDRtnQ8k5DxzNFPafzS5mX8WBypncNi+lZjsyA8Vwg3X/UbcEXchRS2eSKFqq1YojkDt
 IoGwEjT3Jz/n2WMbAg/OiI1P6ThPXexLp4CMTi71hV0WJ6ymQOve4paxZPvgH/l7IGhD
 5ATw==
X-Gm-Message-State: AOJu0YzWBuDpFvKeDhd6cu1TEO15Fhx/none4/Fe3tKkaVGhP5O07xi4
 kKuj+5g+Ea8aPYz7ELY5YJaPawYuDHd77ZUwLnzZx12zqOD27pNqRZO6Ml99H94fLxk=
X-Gm-Gg: ASbGncvsNZRNwBEebGPkmcEf1KQYZb0imQTA7z3GmVzMinZd3nYxWX7MihDMHdeAEVQ
 Z+qza7S3VjmqJ5BPZ+sGpB8rE35PFL5m8SUajcw2TovYDAoWbBmH/v6Hv7m3KySE2WLqVwBEIyf
 NIlJaR01EzFE1q1myrWllNWAVX/cZ+XbPI8WrOeDZ+AtW6H2nicJCZAqAwIm81D9aCFTAze4AD5
 m45MIXJ8qSWwXWwowm/s/I4l/QrEqjhW3w6O0K3rX0oZO4J5kVFRQOQIvP6YXRSvXOhEz23RV79
 HFwwJ5GPxusLMqiCPtirNx0nPCr+dTJDd9q7x6Cm869uAxRsxPQ=
X-Google-Smtp-Source: AGHT+IG1v5N4aoxRnf+KKgkl3CO5Hz7MrHujTr5rv5300MWfIl8IXSwXeL+5JmqEfQIVVk4c1AOS0Q==
X-Received: by 2002:a17:90b:4d8c:b0:311:b0d3:865 with SMTP id
 98e67ed59e1d1-3134707752emr12988141a91.32.1749423101367; 
 Sun, 08 Jun 2025 15:51:41 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b128012sm4395970a91.32.2025.06.08.15.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 15:51:40 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v8 4/9] plugins: Add memory virtual address write API
Date: Sun,  8 Jun 2025 15:51:31 -0700
Message-ID: <20250608225136.3340370-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608225136.3340370-1-rowanbhart@gmail.com>
References: <20250608225136.3340370-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

This patch adds functions to the plugins API to allow reading and
writing memory via virtual addresses. These functions only permit doing
so on the current CPU, because there is no way to ensure consistency if
plugins are allowed to read or write to other CPUs that aren't currently
in the context of the plugin.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
 plugins/api.c              | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 120fb626a6..8ae7758b95 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -948,6 +948,27 @@ QEMU_PLUGIN_API
 bool qemu_plugin_read_memory_vaddr(uint64_t addr,
                                    GByteArray *data, size_t len);
 
+/**
+ * qemu_plugin_write_memory_vaddr() - write to memory using a virtual address
+ *
+ * @addr: A virtual address to write to
+ * @data: A byte array containing the data to write
+ *
+ * The contents of @data will be written to memory starting at the virtual
+ * address @addr.
+ *
+ * This function does not guarantee consistency of writes, nor does it ensure
+ * that pending writes are flushed either before or after the write takes place,
+ * so callers should take care to only call this function in vCPU context (i.e.
+ * in callbacks) and avoid depending on the existence of data written using this
+ * function which may be overwritten afterward.
+ *
+ * Returns true on success and false on failure.
+ */
+QEMU_PLUGIN_API
+bool qemu_plugin_write_memory_vaddr(uint64_t addr,
+                                   GByteArray *data);
+
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
  *
diff --git a/plugins/api.c b/plugins/api.c
index 16141f5c25..7258b6590b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -476,6 +476,24 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
     return true;
 }
 
+bool qemu_plugin_write_memory_vaddr(uint64_t addr, GByteArray *data)
+{
+    g_assert(current_cpu);
+
+    if (data->len == 0) {
+        return false;
+    }
+
+    int result = cpu_memory_rw_debug(current_cpu, addr, data->data,
+                                     data->len, true);
+
+    if (result < 0) {
+        return false;
+    }
+
+    return true;
+}
+
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
-- 
2.49.0


