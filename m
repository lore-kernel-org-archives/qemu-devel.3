Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC40C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Ri-00048u-75; Wed, 15 May 2024 03:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rd-00046Y-Op
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rb-0001Zq-DK
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41ffad2426eso48854145e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759578; x=1716364378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHmxyaHJvfTQV6eJCp+0w5/I7rCSGxf4lZPvvgw/PM4=;
 b=c1fFZEoZQE131nGH/6H3/4+xJj0Dc750RMzM+AWRkM16s13X0mTdrDCPT/sGHLFXx4
 n7H3vvEBpV/yw4XYbbSPrdImo93O/DawUW4vbkyyHsCQEnPm1JHWPobNsu4kLhN+Yu1F
 RW+R2hxNWTi/5JeuMCMXCtiCnzbNtOpl38rdNiqfma5m0+8yT3EubfY7CPSROb9GWlOy
 FlxhWI26pVUVn9xlZCsiKc3Gd+jFAJdz/kBrU9q4Bvgevm1a+fKYX00rO72p1q8S4nff
 M8O4MWdRYjphvR3EVuYl3dv75hxN6G3ErRfBwXRQH5tr70EO/+FoISofilpUbUb30gYz
 4F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759578; x=1716364378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHmxyaHJvfTQV6eJCp+0w5/I7rCSGxf4lZPvvgw/PM4=;
 b=c6P07/8CmWKg7ZzfVawyx/lcBBudUzYSVIJVtR+7TcdqYfQcgxs/eSNelNXutKMWCR
 /ya4QhLqdsOgv7iP7qrjPiTQKyZDG10DbuWcj+8Sy5/tmtY1YiDQO1II+3kJLTgtAuxO
 2xx35pSNR6C/a2dvXclI+v7tvfNRRjOdOpuefmCoFckME1Fm1Yua87jpwHqS6tNSKbrZ
 WExp59LddwiRkG5GWfDiYfhpFQNBNe/1SzeYWY4Wq1/71z15vuR1UZnw7Mii0uT14G0j
 ujh7awnIChxq3MgtBwRGyOB9XWsA9nuLLPhE6U5tKHrwcdnG9ATdxzxOwNW5Uu4RsRaj
 r58w==
X-Gm-Message-State: AOJu0YwooE6fsqyfd9eelaMA65Ub3J/ZrEcPP+Arjqog5Mi3iIWq2ZCm
 1aXTwj3vuqW13JCwRlg9+Rd4vxwRbeVYJID3haAXgX3HpIgJQUPWbRB7Yrza/H8tOvOgznRke44
 UYKE=
X-Google-Smtp-Source: AGHT+IG0tNk9txYPfj6BPVHxCdb9l+S8B3q1bBM2VCG6HkqqlGqSzG/3t69mtklzATlrXWCN03GO2g==
X-Received: by 2002:a05:600c:3548:b0:41a:6edd:6c1d with SMTP id
 5b1f17b1804b1-41feac55e10mr130103785e9.32.1715759578121; 
 Wed, 15 May 2024 00:52:58 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/34] plugins: Use DisasContextBase for qemu_plugin_insn_haddr
Date: Wed, 15 May 2024 09:52:26 +0200
Message-Id: <20240515075247.68024-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  |  4 ----
 accel/tcg/plugin-gen.c | 20 --------------------
 plugins/api.c          | 25 ++++++++++++++++++++++++-
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index c28d0ca31c..da0f37e269 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -99,7 +99,6 @@ struct qemu_plugin_dyn_cb {
 /* Internal context for instrumenting an instruction */
 struct qemu_plugin_insn {
     uint64_t vaddr;
-    void *haddr;
     GArray *insn_cbs;
     GArray *mem_cbs;
     uint8_t len;
@@ -120,9 +119,6 @@ struct qemu_plugin_tb {
     GPtrArray *insns;
     size_t n;
     uint64_t vaddr;
-    uint64_t vaddr2;
-    void *haddr1;
-    void *haddr2;
 
     /* if set, the TB calls helpers that might access guest memory */
     bool mem_helper;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 2aa1e08c17..c36632e8df 100644
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
index 9e4aa9d2d9..0ae19774df 100644
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


