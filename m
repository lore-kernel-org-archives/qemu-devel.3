Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2043BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swY-0004HF-2f; Mon, 22 Sep 2025 22:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swR-0004GK-M6
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swG-0003go-Im
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77e6495c999so3620568b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595165; x=1759199965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlRPEyr6JX0DFMZok14KKZ2onuzUr1d8B5RA0kC17uw=;
 b=NzMguD1L4PW4TSePmSa32beLkfLd0xc006aohfzgxXKRJL1llJAU5C18aVOVlSh7Gs
 4Q2WStlhmWtwv7W6V+2NSI7pQEVFzzNq/GbGagbQ4W6z6RiT8WWnfOxa/F7uxkAVETYc
 r2OSbz1IhgjDvkhQhouTHzoVB7YBpvqW2SqHXkFCF5RbYmgOETFzhDhR10zrMr2C0bjk
 5SHkWgjOkk+WlMFyJKLKj+luJ72hft/GUUHHZniAKsjGsUSaFsr/qFiP3/Fn345CK4xa
 1Sfo57NOQD9ZsVjc0hIw2TypZ7F71jRDcwjdc4MLPutafo/ED9j9XAw9I1D16zXlMWWM
 EqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595165; x=1759199965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlRPEyr6JX0DFMZok14KKZ2onuzUr1d8B5RA0kC17uw=;
 b=OAMKOPmAWmc63OOH5BRp0ncVmBsmyLNwDgUbQr6Thu+IXwhZHyGmbs4iUHSLSKIUU3
 Qzezsx8T/gvJWR9Z6Nk07FaYMgr18Ef8qVkinKcPIpkaidNCWuNHaDIYzc/s9m47eJAS
 RVsu9XknFbkSJ9fkcomL2rmzGE/Y6sAZ8aDN6AN13H7t4SrIqS/QeqmCITKtwj5h2wWC
 f118/nFmaHAwWV70BWi+MmM2roe03C5ymIdNKesH2X8gBe9PMDZJ2UPog27PNsmRMkP9
 P0joDxHCQPkfVFh5tyTpNURalYD7q8gDv8SBygJoF9gyfGr3fUWiAjEO580QvcXQNDSx
 MI+w==
X-Gm-Message-State: AOJu0YyweWCmyKNwdRU/6mPQ//tFy/gQHUmWX+SytWJ3DdspRghleWyg
 y+UddrsJBbB3NRJ3WbYukc34gO9Zg8nJudU/1+oayOkzTiBRIzGVe7NAYsLv2XLz64m3ytPvovt
 n1AAJ
X-Gm-Gg: ASbGnct60N25OvDITsqGX3N9uE7Wbp+AEgk51ggFIaVOxvstQUXZa1TZck6NcRnt7c1
 iSAh9Oc4J517p03KE/Ac4lPwilY+0oVoONU9sTIuTQMZ/hIhpwiotrgY/SCe175VncbZTfW9LBt
 Nykg4CR5w1yOIVlUMpsiHdEJSew5sz1jf8OXguCdG4JLgB79Egpt4XEeXvH3r4jkpT5i6agJgtp
 /tda6TBz/6SwMEkwv3mBPpblC1iCdYepe75lD9NCvNAfvkRfZTRVmozeZ6OXrsxULAuG+k53Jmc
 H2ojSQacSkVtiKNAK1lWX1UIgzvGNjBikN2vJ1P3W3M1orEgg5vzF0aQMXHuxOy9u5ps2VBm6vg
 rLx3esxUpTzsFYzo+ose3vSOrutyvm/2/F1JsPhE=
X-Google-Smtp-Source: AGHT+IGw5XfCFFqL/6knWB2DMFx0ReMia4ARx93zwc1N7Lj1aocwAnmYBKVFCYB7osnl8m63oL/spg==
X-Received: by 2002:a05:6a00:b8f:b0:76b:42e5:fa84 with SMTP id
 d2e1a72fcca58-77f5389806amr1092111b3a.7.1758595165378; 
 Mon, 22 Sep 2025 19:39:25 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 02/12] accel/tcg: Split out tb_flush__exclusive
Date: Mon, 22 Sep 2025 19:39:06 -0700
Message-ID: <20250923023922.3102471-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Expose a routine to be called when no cpus are running.
Simplify the do_tb_flush run_on_cpu callback, because
that is explicitly called with start_exclusive; there
is no need for the mmap_lock as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tb-flush.h | 13 +++++++++++++
 accel/tcg/tb-maint.c    | 33 ++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
index 142c240d94..5076b13bbd 100644
--- a/include/exec/tb-flush.h
+++ b/include/exec/tb-flush.h
@@ -8,6 +8,19 @@
 #ifndef _TB_FLUSH_H_
 #define _TB_FLUSH_H_
 
+/**
+ * tb_flush__exclusive() - flush all translation blocks
+ *
+ * Used to flush all the translation blocks in the system.
+ * Sometimes it is simpler to flush everything than work out which
+ * individual translations are now invalid and ensure they are
+ * not called anymore.
+ *
+ * Must be called from an exclusive context, e.g. start_exclusive
+ * or vm_stop.
+ */
+void tb_flush__exclusive(void);
+
 /**
  * tb_flush() - flush all translation blocks
  * @cs: CPUState (must be valid, but treated as anonymous pointer)
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0048316f99..71216fa75e 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -36,6 +36,9 @@
 #include "internal-common.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
+#define runstate_is_running()  true
+#else
+#include "system/runstate.h"
 #endif
 
 
@@ -756,17 +759,18 @@ static void tb_remove(TranslationBlock *tb)
 }
 #endif /* CONFIG_USER_ONLY */
 
-/* flush all the translation blocks */
-static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
+/*
+ * Flush all the translation blocks.
+ * Must be called from a context in which no cpus are running,
+ * e.g. start_exclusive() or vm_stop().
+ */
+void tb_flush__exclusive(void)
 {
-    bool did_flush = false;
+    CPUState *cpu;
 
-    mmap_lock();
-    /* If it is already been done on request of another CPU, just retry. */
-    if (tb_ctx.tb_flush_count != tb_flush_count.host_int) {
-        goto done;
-    }
-    did_flush = true;
+    assert(tcg_enabled());
+    assert(!runstate_is_running() ||
+           (current_cpu && cpu_in_serial_context(current_cpu)));
 
     CPU_FOREACH(cpu) {
         tcg_flush_jmp_cache(cpu);
@@ -778,11 +782,14 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     tcg_region_reset_all();
     /* XXX: flush processor icache at this point if cache flush is expensive */
     qatomic_inc(&tb_ctx.tb_flush_count);
+    qemu_plugin_flush_cb();
+}
 
-done:
-    mmap_unlock();
-    if (did_flush) {
-        qemu_plugin_flush_cb();
+static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
+{
+    /* If it is already been done on request of another CPU, just retry. */
+    if (tb_ctx.tb_flush_count == tb_flush_count.host_int) {
+        tb_flush__exclusive();
     }
 }
 
-- 
2.43.0


