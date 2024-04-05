Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B005CC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglB-000602-8H; Fri, 05 Apr 2024 06:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl8-0005zQ-9U
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:22 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl6-0004jW-67
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:21 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so1009219b3a.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312718; x=1712917518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wv67pMXMsVcEOwYDni8f26C2u4kTVwgef8xc6CDT8l8=;
 b=Czz6dgmM+hIGNAkIotrzPIGZjSxxFrN/Krfv7i9ZMt/AmTHDbdgxu4VvArvYFDYe7r
 6zUXxwsZ34yeAyiakUyKne8BBmRytGMYEeJKdrCYZLIuwwIqmwwX/Rr/f8rIF857IBfC
 k3jScSZBO5TkixQDwWvxKTelcFZtoaUFYisOhyiKtrOKW5KUjEfrVIzypYPYn9iNXHh+
 vdeTJmocWHpKvJmw0PofUvhLxV9G/dnQSv8qhEVlMwHupaufhEts2dzctmpyPyZHJqeo
 noVxisOWhxDVMzVOI+Mh60KIQ0yVMfULk1Obyr/gdyeY4rhYQZ4yNoYrYFVr6LpEPHdC
 658g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312718; x=1712917518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wv67pMXMsVcEOwYDni8f26C2u4kTVwgef8xc6CDT8l8=;
 b=FlTXmzdEc1ocPa24fFDRlC9VLuJk5bDHerC8SBB9q3zjCcN3u10QOE5Op5By7uOAz6
 OAR9gzUZfViPIprZ30E87KlmVk5ZnV8Ljws0cAieRjhfxnhelc2Eob062cHFyChLGCq3
 HoU051nniopj5VIjGHW6HIt6t0AgFrt9LxxWhYKGxXMqCtbsC9vzjxdLo4VP35OE53Q5
 jd+59yIcVa2AkbTDCHoK8hi2iJ+LL466mMOi4xxQ9d6GqDQzj4EjOPUezoKQfN/p36uS
 epm37d84tBcv69/Up/tEy7rfdY0XHdsBvtdkSaW6i+qBNSlkiBpFr6Vcet6PY9E1KJQp
 BH6w==
X-Gm-Message-State: AOJu0YwGTERjYFB8qjTtWRboWD5KtKmfh5qXYPf67qE63hj9lDk9eh0N
 RhyR6A7rA+Dt2YrBfdOzy09pH7bHrCLEmNx6An2NgAl/asoa3a8oi7TVnYdmT6rBrd2KRlLPqlh
 J
X-Google-Smtp-Source: AGHT+IECFs1qsqTmYw4HW2un6pD87pgWdBGlL9ZJlhjZaEcFlMGgV+Nagv71QWgRh9IzBokunqaUnQ==
X-Received: by 2002:a05:6a00:928e:b0:6ea:b7b1:ef26 with SMTP id
 jw14-20020a056a00928e00b006eab7b1ef26mr1131842pfb.26.1712312718530; 
 Fri, 05 Apr 2024 03:25:18 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/32] plugins: Use DisasContextBase for qemu_plugin_insn_haddr
Date: Fri,  5 Apr 2024 00:24:40 -1000
Message-Id: <20240405102459.462551-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

We can delay the computation of haddr until the plugin
actually requests it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  |  4 ----
 accel/tcg/plugin-gen.c | 20 --------------------
 plugins/api.c          | 25 ++++++++++++++++++++++++-
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 03081be543..3db0e75d16 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -98,7 +98,6 @@ struct qemu_plugin_dyn_cb {
 /* Internal context for instrumenting an instruction */
 struct qemu_plugin_insn {
     uint64_t vaddr;
-    void *haddr;
     GArray *insn_cbs;
     GArray *mem_cbs;
     uint8_t len;
@@ -119,9 +118,6 @@ struct qemu_plugin_tb {
     GPtrArray *insns;
     size_t n;
     uint64_t vaddr;
-    uint64_t vaddr2;
-    void *haddr1;
-    void *haddr2;
 
     /* if set, the TB calls helpers that might access guest memory */
     bool mem_helper;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index a4656859c6..b036773d3c 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -319,9 +319,6 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db)
         ret = true;
 
         ptb->vaddr = db->pc_first;
-        ptb->vaddr2 = -1;
-        ptb->haddr1 = db->host_addr[0];
-        ptb->haddr2 = NULL;
         ptb->mem_helper = false;
 
         tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
@@ -363,23 +360,6 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
     pc = db->pc_next;
     insn->vaddr = pc;
 
-    /*
-     * Detect page crossing to get the new host address.
-     * Note that we skip this when haddr1 == NULL, e.g. when we're
-     * fetching instructions from a region not backed by RAM.
-     */
-    if (ptb->haddr1 == NULL) {
-        insn->haddr = NULL;
-    } else if (is_same_page(db, db->pc_next)) {
-        insn->haddr = ptb->haddr1 + pc - ptb->vaddr;
-    } else {
-        if (ptb->vaddr2 == -1) {
-            ptb->vaddr2 = TARGET_PAGE_ALIGN(db->pc_first);
-            get_page_addr_code_hostp(cpu_env(cpu), ptb->vaddr2, &ptb->haddr2);
-        }
-        insn->haddr = ptb->haddr2 + pc - ptb->vaddr2;
-    }
-
     tcg_gen_plugin_cb(PLUGIN_GEN_FROM_INSN);
 }
 
diff --git a/plugins/api.c b/plugins/api.c
index 39895a1cb1..4b6690c7d6 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -242,7 +242,30 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
 
 void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
 {
-    return insn->haddr;
+    const DisasContextBase *db = tcg_ctx->plugin_db;
+    vaddr page0_last = db->pc_first | ~TARGET_PAGE_MASK;
+
+    if (db->fake_insn) {
+        return NULL;
+    }
+
+    /*
+     * ??? The return value is not intended for use of host memory,
+     * but as a proxy for address space and physical address.
+     * Thus we are only interested in the first byte and do not
+     * care about spanning pages.
+     */
+    if (insn->vaddr <= page0_last) {
+        if (db->host_addr[0] == NULL) {
+            return NULL;
+        }
+        return db->host_addr[0] + insn->vaddr - db->pc_first;
+    } else {
+        if (db->host_addr[1] == NULL) {
+            return NULL;
+        }
+        return db->host_addr[1] + insn->vaddr - (page0_last + 1);
+    }
 }
 
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
-- 
2.34.1


