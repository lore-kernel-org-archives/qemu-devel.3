Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E2CC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMbpF-0003Bn-Fy; Wed, 26 Jun 2024 19:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbp9-00039S-DF
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:12 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbp6-0000PB-KQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:10 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f9fb3ca81bso34335585ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719443587; x=1720048387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtCGpIl6luQ3ISJAfvlxdEXOg6zayrBpIY7vxCz1GF8=;
 b=btot52pcmJkIttEQiOHpjsvXZgZeLdvJvW/PGfbaalpnfVuvtuTZA1OdQim7tqqkUw
 d4b3hIRenCs5HhHoBA+GpGqiMP9hcjiMaGJJKGiJPHn0qmfjHgZxCukceOUXw1DulIvJ
 dDJr983aIQ/71n81+rhsnvK36o0zJK/fuWvMcDiF56dqYw7EesVHYu8bqJdKaM/fKLWR
 Osqke8HzkzjV7W8eCEOyHR3ZQ+Fqwz8EHX1rYXg6phxwhmZWzpsS+1CUvdNx+/f9pBrb
 YicZXq8chXivr7Sro4c62+7cErznxjMjaxvibqEC01A4DFllo8uuBzBVfITNigaquIu6
 QtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719443587; x=1720048387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtCGpIl6luQ3ISJAfvlxdEXOg6zayrBpIY7vxCz1GF8=;
 b=vQOZoynIBmeh8xf1+wJHQpAafPBUClMf0XiQTK5K5HISs6SynYaQw4OLcQk7BI5qPd
 78r38LmG9y4xlOH6D/gNPeVk5RprSuAlbuCo4N1avM9fWHKdfWlm79qY/F0jl98+H4pA
 2JX0qH7e9aWY7O75WQYNCBS9q+ZeSvoPcC65Lmk5qpddulAu/wgetm15GuHvFXgNhfCL
 kz0kvSWAF55v9K3vAgwe8bpCzPDXrcGYsKNiTaku6vkUfwDGcd+RuCEFdTn/aW2PdGW/
 cLM0rOgCNki817Bw993EknuMcSS5vd24F4Jq/G1+gdnTrfUWfP7hYJUIv3nO6xqGNzL+
 RIZg==
X-Gm-Message-State: AOJu0Yx+FwUxwCVKu6tmhvPM02369/pWqo18Oe9yurVEwRP/ZNVOEr0W
 R0RDpG67pUkNZci0RdKIiiueI4hydXiK4BckSZcCQ2AZbPryaSgDsfubJBsKd3tHbwD653YPXcN
 AU8I=
X-Google-Smtp-Source: AGHT+IFCLvtHvjMgdin6zv+Hb78vkOnv5sHZA9BT9Gy89rsFpNABdH6N2zbRh3MiP6b9Zpl1SWFZFQ==
X-Received: by 2002:a17:902:f54c:b0:1f6:225e:67a1 with SMTP id
 d9443c01a7336-1fa2413cddemr139393005ad.56.1719443586759; 
 Wed, 26 Jun 2024 16:13:06 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac82cd3bsm478215ad.0.2024.06.26.16.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:13:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 6/7] tests/plugin/mem: add option to print memory accesses
Date: Wed, 26 Jun 2024 16:12:54 -0700
Message-Id: <20240626231255.339353-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
References: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

By using "print-accesses=true" option, mem plugin will now print every
value accessed, with associated size, type (store vs load) and symbol
where this happens.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/mem.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index b650dddcce1..d897034a044 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -24,7 +24,7 @@ typedef struct {
 static struct qemu_plugin_scoreboard *counts;
 static qemu_plugin_u64 mem_count;
 static qemu_plugin_u64 io_count;
-static bool do_inline, do_callback;
+static bool do_inline, do_callback, do_print_accesses;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
 
@@ -60,6 +60,20 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     }
 }
 
+static void print_access(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                         uint64_t vaddr, void *udata)
+{
+    unsigned size = 8 << qemu_plugin_mem_size_shift(meminfo);
+    const char *type = qemu_plugin_mem_is_store(meminfo) ? "store" : "load";
+    uint64_t upper = qemu_plugin_mem_get_value_upper_bits(meminfo);
+    uint64_t lower = qemu_plugin_mem_get_value_lower_bits(meminfo);
+    const char *sym = udata ? udata : "";
+    g_autoptr(GString) out = g_string_new("");
+    g_string_printf(out, "access: 0x%.0"PRIx64"%"PRIx64",%d,%s,%s\n",
+                    upper, lower, size, type, sym);
+    qemu_plugin_outs(out->str);
+}
+
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
@@ -79,6 +93,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                              QEMU_PLUGIN_CB_NO_REGS,
                                              rw, NULL);
         }
+        if (do_print_accesses) {
+            const char *sym = qemu_plugin_insn_symbol(insn);
+            qemu_plugin_register_vcpu_mem_cb(insn, print_access,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             rw, (void *) sym);
+        }
     }
 }
 
@@ -117,6 +137,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "print-accesses") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &do_print_accesses)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.39.2


