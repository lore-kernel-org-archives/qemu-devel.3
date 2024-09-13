Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8C5FC616A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4p-0006rd-QU; Fri, 13 Sep 2024 13:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4g-0006Ci-Bt
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:14 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4Y-0005v0-T6
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:12 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5367ae52a01so1701296e87.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248425; x=1726853225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNcKpK3gqW5pd0AiX4NmCCbDvgLi1QOfUkQVya3+J3c=;
 b=dMhgqKHttWXwg9Hh6JYeL1Tj8VkZyAbigPLnhy/oIv+rApl6Lv0uhT2bATbqWvIhvm
 QNhR0b0KaIaeMvBls27WvnIE0lDwgHB0EMIH2AS3Z0X/6Wal+fMman/ISsf/XbvFjvlu
 W0xuT7GG9jYjXpctWgENIf8LEq48nUfoCOOl12bkmVKMqlkvF8omOM53R7kgx1tmJ0Jc
 akgUMZKwy/T0tiMjg/sLd/Dlzi/gSFRrpEWGUxeepznASLM0D9XgW6COyBqLnMgG0DVM
 14fra2FuRO0SSpE2rMJLrnc4MZX0T+s+a/DoKEY4CAkauZE835VGVq1/X9Q6GmiJcwZk
 5VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248425; x=1726853225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNcKpK3gqW5pd0AiX4NmCCbDvgLi1QOfUkQVya3+J3c=;
 b=C4LuD/FH/acL0ZDUDuxqAFRTRZUK1QjkBYG6WhJ5RlIuSEu7d8VgOM+3xbNCR9S2Pb
 aG5j1xEGhxsylofKYNq2IkutJB8ImTMeaYPMjwhWxDLekcR6/oNCRxvfr83cyJ3q0RCM
 RYHyuA3+begkCEZAp6F3onHRzplXbBMUO9Vbu+BN522ThnzsYq+2wuEMeUvugvazx/Ak
 CufjZHqI58QMxUkwSUSyEdNHn4wJgjf4H1jkTQ3cl+YcYXEwstsn8TKns8WzQEIQozj7
 a3I1xJgzqvB6XuJF7e0buNhB3sAz0dTwua4Vea6VRbbwB+kZjzceBTDN+f2d8HdDP48K
 6ifg==
X-Gm-Message-State: AOJu0YzNI4hSey/VbZKN3g6vq8noGZh5OizEJudhnC1Lln2zUConbgpe
 YksM+XOvBYZvQYx5H16dTUz/fBfSvB0KmIQuPd47ofQs1TrB+RCgtd9HrVEEo+g=
X-Google-Smtp-Source: AGHT+IHG6h9u+sMY4i8mG9ksmPVhqCM9SZTCG1cORERdH/GeIADh8bXIQknvkCNDzhne4hprxudoGA==
X-Received: by 2002:a05:6512:224f:b0:530:aa09:b6bf with SMTP id
 2adb3069b0e04-5367fee270emr2138919e87.24.1726248424436; 
 Fri, 13 Sep 2024 10:27:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d400afsm894067866b.189.2024.09.13.10.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:27:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DCE115FA0F;
 Fri, 13 Sep 2024 18:26:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 08/17] tests/tcg/plugins/mem: add option to print memory
 accesses
Date: Fri, 13 Sep 2024 18:26:46 +0100
Message-Id: <20240913172655.173873-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
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

By using "print-accesses=true" option, mem plugin will now print every
value accessed, with associated size, type (store vs load), symbol,
instruction address and phys/virt address accessed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240724194708.1843704-6-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/plugins/mem.c | 69 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index b650dddcce..086e6f5bdf 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -21,10 +21,15 @@ typedef struct {
     uint64_t io_count;
 } CPUCount;
 
+typedef struct {
+    uint64_t vaddr;
+    const char *sym;
+} InsnInfo;
+
 static struct qemu_plugin_scoreboard *counts;
 static qemu_plugin_u64 mem_count;
 static qemu_plugin_u64 io_count;
-static bool do_inline, do_callback;
+static bool do_inline, do_callback, do_print_accesses;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
 
@@ -60,6 +65,44 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     }
 }
 
+static void print_access(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                         uint64_t vaddr, void *udata)
+{
+    InsnInfo *insn_info = udata;
+    unsigned size = 8 << qemu_plugin_mem_size_shift(meminfo);
+    const char *type = qemu_plugin_mem_is_store(meminfo) ? "store" : "load";
+    qemu_plugin_mem_value value = qemu_plugin_mem_get_value(meminfo);
+    uint64_t hwaddr =
+        qemu_plugin_hwaddr_phys_addr(qemu_plugin_get_hwaddr(meminfo, vaddr));
+    g_autoptr(GString) out = g_string_new("");
+    g_string_printf(out,
+                    "0x%"PRIx64",%s,0x%"PRIx64",0x%"PRIx64",%d,%s,",
+                    insn_info->vaddr, insn_info->sym,
+                    vaddr, hwaddr, size, type);
+    switch (value.type) {
+    case QEMU_PLUGIN_MEM_VALUE_U8:
+        g_string_append_printf(out, "0x%02"PRIx8, value.data.u8);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U16:
+        g_string_append_printf(out, "0x%04"PRIx16, value.data.u16);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U32:
+        g_string_append_printf(out, "0x%08"PRIx32, value.data.u32);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U64:
+        g_string_append_printf(out, "0x%016"PRIx64, value.data.u64);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U128:
+        g_string_append_printf(out, "0x%016"PRIx64"%016"PRIx64,
+                               value.data.u128.high, value.data.u128.low);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    g_string_append_printf(out, "\n");
+    qemu_plugin_outs(out->str);
+}
+
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
@@ -79,6 +122,16 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                              QEMU_PLUGIN_CB_NO_REGS,
                                              rw, NULL);
         }
+        if (do_print_accesses) {
+            /* we leak this pointer, to avoid locking to keep track of it */
+            InsnInfo *insn_info = g_malloc(sizeof(InsnInfo));
+            const char *sym = qemu_plugin_insn_symbol(insn);
+            insn_info->sym = sym ? sym : "";
+            insn_info->vaddr = qemu_plugin_insn_vaddr(insn);
+            qemu_plugin_register_vcpu_mem_cb(insn, print_access,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             rw, (void *) insn_info);
+        }
     }
 }
 
@@ -117,6 +170,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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
@@ -129,6 +188,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         return -1;
     }
 
+    if (do_print_accesses) {
+        g_autoptr(GString) out = g_string_new("");
+        g_string_printf(out,
+                "insn_vaddr,insn_symbol,mem_vaddr,mem_hwaddr,"
+                "access_size,access_type,mem_value\n");
+        qemu_plugin_outs(out->str);
+    }
+
     counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
     mem_count = qemu_plugin_scoreboard_u64_in_struct(
         counts, CPUCount, mem_count);
-- 
2.39.2


