Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2AAEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4Y1-0003iH-JO; Tue, 10 Sep 2024 13:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4Xw-0003PK-Rp
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:20:56 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4Xt-0002ny-8U
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:20:56 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d8f06c2459so3777484a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725988852; x=1726593652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZhXggMzxS5/Hj/Hre+veFUkbwOhjo3lATccHPiXGdo=;
 b=mMlMdXp+JDkMNPYFRSItEdB7pQdTvYVQoswW0llIFVNMV1B9Q4rnwvZ6dpGcJGJws6
 fmUTLDVsoE4jo3amGF6tgl0gkmTM/+OC5BwRXtWDUOhFS7r+meiYpKpjFtgVWMlRSwe1
 DZaLiUlVlUB0kFWITJlWduqctlpUjElEq3m4BSQdwmhl5FYqePPp/maaa90y9A+WmBCu
 RVsOg98Se3/4nJjTYc0x8Pzf0l1RjMojDmZTakB4mFlH0lU0P9kpuCKbl/JY3PIoUrD7
 pVshQhK0F6ExrhYugF0KSeaV3tf/UXD/YhB4VluxUH0UKpUaRlknfF3THTHT/jVAuVhS
 s4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988852; x=1726593652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZhXggMzxS5/Hj/Hre+veFUkbwOhjo3lATccHPiXGdo=;
 b=XhivUtuJ+Af5UU8jAtsx4XqN+VYYyYxn3K10e3uyHkciqu6TJ5qDwWTWJBTZrRIsWJ
 cHj09Nf6XNhUvOcTNZap5VMDkwTNSZmBQZjByPgIVTl3XtjIh4cOdzCvM8TaisZiFDKs
 hVxCzv1dEPfdbwmGxXj7348gNJFxfcxNUndwbaheK/iF2g/UO88xsFkn9e/51BfQ4LZl
 yg9bX4aNrkd4jE2rJod31bvRnqBwD29HfDsYrQJCQsUIAeBsJ6vDr61IYhDEXgdx5KGq
 kpurvyEO/jqqrE1dlBOTmMkAxC+ieiiGgiY1tST7g/LuZp7VtkkfxqPV6LesntXj+J41
 +L7g==
X-Gm-Message-State: AOJu0YxfVnXQ2AECFt/I2udseC7HJz9pJy64TmlukTYkukxnMyAvjsIY
 WTZnq3JZ57IIyMjTjt/0Q5tkKAwVjN0wwL+hWHxsiS2edw5HFCZYEalAjYydDezgBqEife3WTsv
 A/NPnlA==
X-Google-Smtp-Source: AGHT+IFK9XOwWrV1ntgyFOK2BB7V0AvWc9JJhE2GI8ln3e2QuSZhO/qi4k+l1ga4J/3NAOqY/CamEQ==
X-Received: by 2002:a17:90b:3007:b0:2d8:f0b4:9acb with SMTP id
 98e67ed59e1d1-2dad513545emr14225866a91.34.1725988851772; 
 Tue, 10 Sep 2024 10:20:51 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db049883e5sm6685310a91.50.2024.09.10.10.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:20:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v8 5/6] tests/tcg/plugins/mem: add option to print memory
 accesses
Date: Tue, 10 Sep 2024 10:20:32 -0700
Message-Id: <20240910172033.1427812-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
References: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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
value accessed, with associated size, type (store vs load), symbol,
instruction address and phys/virt address accessed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/mem.c | 69 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index b650dddcce1..086e6f5bdfc 100644
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


