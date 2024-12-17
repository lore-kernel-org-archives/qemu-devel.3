Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566AAE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3p-0008JU-Cs; Mon, 16 Dec 2024 20:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3f-0008Ht-W3
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:32 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3d-0004yy-Ht
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:31 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-725f4623df7so4079370b3a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397648; x=1735002448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crzqjDJBZdpI+EWDwy4Pgv4ZHNVlbcwq1nqGrijGMLQ=;
 b=afI4yBFZ37rqkhm56I+kuJ12HOAEO1J9MdQBQTT6Fpn9C+t5LVA9sPsIJ9Jd/bgd0D
 loJKgdexiNEALovJUSZuosIXaDVPjkqDUWCOICaGkfFlgM4VnV4msTJx7gii9+vOp1VK
 c7n6LtySy023mRsdDvNX4fEYC8EoHG0BeMzoJ2P9YnH86uF6BLgHjWqOkJly+VJ2RMbj
 ijHUA2mmkEko16+Oc7j1BJbfMZu0smBvjUYm3XFzeUsEEpzg0gha9mEz7of4K5+WyLUM
 rh1TkpeiZruSr+TamHuNwi8RN1pDFYRh6iqNvCrDYHdT0U7NNpLl9fQnfV2hKh3kJMMK
 6DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397648; x=1735002448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crzqjDJBZdpI+EWDwy4Pgv4ZHNVlbcwq1nqGrijGMLQ=;
 b=cpqgFKYSLh/tTrKWLIzcr6kOZX0TnycekLLtKwP9sQYOl0jUQlXbnq4LRyPMmxZg9h
 AdFgclaALupVZ7US9+mVkFKOOMIcDX5rs38yX2eUGktuxQSVDJkwhlsGs8qkLinJWMsV
 AsBXQ1Z1NdwSzj3gLtsPqfF/GGPA0iXxoYlsW9dc/95xAaW72Mz5YQR9ztCL3tlvf0oq
 csPXTKbubaqZyiYWTlzF6/i0sAu4z+4AJ0hFl8ZDJgRxx9XhVmtmMqtiSPe9nKE5yOxU
 QCgiTlDvaLezhH+D1ksxQUbk2YTQbo/ALtXcto41NIATGoQ5AdP9dAH95c25CZjx6gWS
 O3Yg==
X-Gm-Message-State: AOJu0YxwFOs487Cr5INhp3PjvoA+PVRhJuK1+5bOLQVczf4QUJwrc3cF
 08uRdG4M6RRHvJpOcXb90mNz+5BAhs+Z+wAvRhbAN2G0KAFbkEDH6KyRksbPGceDqxzjnvh8dpL
 ESMw=
X-Gm-Gg: ASbGncvwunYAk+XXWASMoFzjyhz7MZQB8ZmE0sYL27R/DKSw3A9nAiaQIzLaLvv4Eqf
 dxVWSRGKPrapKsTxArRUxtYlB2tPxUC+cptWBzcksmWyY+my6TuRFWzmu2j/Uj1ZGiPNCW6YhaX
 gm30sB9ry0D1n2E3rFEn4i0HsJltCqOhsmulbDV3PxbOT3qwQPikJqbQMgHKmrwYtLYMCyLW6oa
 URevqO5nkVlX/Sr2T75irF9zAgnVGccGvXBGFEfw/tpnDyEGdh5eQZBMAazIh8DLKsoWj0RrVQY
 kD81v/5z6OhgoPo=
X-Google-Smtp-Source: AGHT+IHyEiMBQ4GWwfOir47vM3RerNDp/uUTBNqYA6XERifyarGlYkG9N5sXNdZtZyuTZyNwKsVwfA==
X-Received: by 2002:a17:902:e545:b0:216:7ee9:2212 with SMTP id
 d9443c01a7336-218929ca98cmr207825885ad.23.1734397647842; 
 Mon, 16 Dec 2024 17:07:27 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:27 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 11/13] contrib/plugins/hwprofile: fix 32-bit build
Date: Mon, 16 Dec 2024 17:07:05 -0800
Message-Id: <20241217010707.2557258-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hwprofile.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index 739ac0c66b5..2a4cbc47d40 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -43,6 +43,8 @@ typedef struct {
 
 static GMutex lock;
 static GHashTable *devices;
+static struct qemu_plugin_scoreboard *source_pc_scoreboard;
+static qemu_plugin_u64 source_pc;
 
 /* track the access pattern to a piece of HW */
 static bool pattern;
@@ -159,7 +161,7 @@ static DeviceCounts *new_count(const char *name, uint64_t base)
     count->name = name;
     count->base = base;
     if (pattern || source) {
-        count->detail = g_hash_table_new(NULL, NULL);
+        count->detail = g_hash_table_new(g_int64_hash, g_int64_equal);
     }
     g_hash_table_insert(devices, (gpointer) name, count);
     return count;
@@ -169,7 +171,7 @@ static IOLocationCounts *new_location(GHashTable *table, uint64_t off_or_pc)
 {
     IOLocationCounts *loc = g_new0(IOLocationCounts, 1);
     loc->off_or_pc = off_or_pc;
-    g_hash_table_insert(table, (gpointer) off_or_pc, loc);
+    g_hash_table_insert(table, &loc->off_or_pc, loc);
     return loc;
 }
 
@@ -224,12 +226,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
 
         /* either track offsets or source of access */
         if (source) {
-            off = (uint64_t) udata;
+            off = qemu_plugin_u64_get(source_pc, cpu_index);
         }
 
         if (pattern || source) {
             IOLocationCounts *io_count = g_hash_table_lookup(counts->detail,
-                                                             (gpointer) off);
+                                                             &off);
             if (!io_count) {
                 io_count = new_location(counts->detail, off);
             }
@@ -247,10 +249,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
     for (i = 0; i < n; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        gpointer udata = (gpointer) (source ? qemu_plugin_insn_vaddr(insn) : 0);
+        if (source) {
+            uint64_t pc = qemu_plugin_insn_vaddr(insn);
+            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+                    insn, rw, QEMU_PLUGIN_INLINE_STORE_U64,
+                    source_pc, pc);
+        }
         qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
-                                         QEMU_PLUGIN_CB_NO_REGS,
-                                         rw, udata);
+                                         QEMU_PLUGIN_CB_NO_REGS, rw, NULL);
     }
 }
 
@@ -306,10 +312,9 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         return -1;
     }
 
-    /* Just warn about overflow */
-    if (info->system.smp_vcpus > 64 ||
-        info->system.max_vcpus > 64) {
-        fprintf(stderr, "hwprofile: can only track up to 64 CPUs\n");
+    if (source) {
+        source_pc_scoreboard = qemu_plugin_scoreboard_new(sizeof(uint64_t));
+        source_pc = qemu_plugin_scoreboard_u64(source_pc_scoreboard);
     }
 
     plugin_init();
-- 
2.39.5


