Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55620C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 16:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSHw0-0001Qj-Tc; Thu, 19 Jun 2025 12:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHvk-0001Lz-7p
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:16:01 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHve-0003fO-QC
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:15:57 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so689053b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750349753; x=1750954553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xl2CsCbMIdd7IA6Ry113lx92Qe9OahNuvq02EUlL3YI=;
 b=ckdFEnsZ9+q1N+cXbq1s/g55aQkTvsn7+/8mnsCxOnAP4pXy4b0tVZRg652I0Cddpq
 QDyn5vKUxjgeZqGuWD//pnj5GeZ1WCgY5+DPDX17ghVCt1MRpyko8CIaVV6JmR6x/Epg
 FT9Vo7s3lRlySRYoufrh+hiHvvcYG/06UjWZFf6ucVdEdru7XIm7yUN0PCt+ZjXGs0Lh
 OAkhusc70qEhfLcwmpGr/TNMn1tBxDF+gNGSXtxKQPvlPXwVB9IEJjoce1zqVYpUIpjc
 c5u/ziHnWwyW1R9jQRBLOdNdsmxtA4Ln0Njw2Ner1eW8Xe3Jpd4nt5ZJdNfV5oMCI9dh
 msNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750349753; x=1750954553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xl2CsCbMIdd7IA6Ry113lx92Qe9OahNuvq02EUlL3YI=;
 b=siojYVWn9y4xT1d+3YPUKi+uRM+8oSusRpiS1xESjSRZmBLr6ognvWHcuKCWHYDZSl
 GxqzfVSQRkHlLVfIVpraXryW1IqXAQ4wE9T9S+xTUZ4CLvonAp1lSCEkCg2hvF6KrSrx
 8xYY9WHoIYCeCRrJp5n6jCF+V5uqlL/pLkJK71afRxW6n1+SvJOctyK2hhIzKIMTXlRj
 fH3hPVCf0UB3TOmhEkSAOIC1ed7sOSbSCWlU0m3Q5rzBnqKnTVc+iL2H7fbuc0sx3CzX
 4PF/Cr2EXBVeeoGQmNmeN/hM4fupLXImVFryAbbCmzPKoNp2yjBk9L4nnO/Qi8WPnYcu
 KPsg==
X-Gm-Message-State: AOJu0YysG8kChyDnRM8n+JyN4e29EjUPJ/ngyByVQh18q6Za5C9f3UKv
 jfIL33dPPSP8qi3F+gAlbhc1ZEHXXzyU1rS+2HY4bcmoyA4YWekGeaVc4M2+haFQ
X-Gm-Gg: ASbGncu3HNjRiGZiEE1q+G27pOT0L6xoJDDJlCNowC1VQswlzYP5oKUMXer50CQ2UQF
 nF/20SXKijfYiUPBpckPtzCIEI81W1dPTKvgYTw7NWv1jgq/+3tEIpuXsJWssUPNYT0hIpT6NjC
 ww2t0GLqscS72hmU6BqQ9Fnd+XBKDWF3Uvr3Jt0Bb8iCqMWaMsxujTtCWY3zoq2snKLhBFycdVq
 eLRhAinxUw+6k7K9pnAKus2UGxx12Kgi4wR/gU69FOk3fvlCOuTVuqhhejUSMNgYw6cP6/QpTvJ
 HFe3TOfDg5Tqabw7azHYCOkDqL4Gfb3H7jeNsiAKSTzQtWt9iuHgnpFvhUKB6g==
X-Google-Smtp-Source: AGHT+IFVWKAM8H60gdn7Jp++YgRbEjqKdH1eQrXsxj2ZNtUID18RGXcd84WGWYkI0gebaoytM/X5uw==
X-Received: by 2002:a05:6a21:62cc:b0:21e:2b2c:8f4f with SMTP id
 adf61e73a8af0-2201113b564mr6743453637.7.1750349752859; 
 Thu, 19 Jun 2025 09:15:52 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe168a0f8sm13168683a12.53.2025.06.19.09.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 09:15:52 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v13 4/7] plugins: Add memory virtual address write API
Date: Thu, 19 Jun 2025 09:15:44 -0700
Message-ID: <20250619161547.1401448-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619161547.1401448-1-rowanbhart@gmail.com>
References: <20250619161547.1401448-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x433.google.com
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
index 9c9ebf6ce0..4167c46c2a 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -958,6 +958,27 @@ QEMU_PLUGIN_API
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
index 3f04399c26..1f64a9ea64 100644
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


