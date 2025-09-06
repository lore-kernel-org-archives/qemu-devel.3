Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E37CA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulJw-000098-Cx; Sat, 06 Sep 2025 01:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJt-00008c-8x
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJl-0006oS-4c
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45dd7b15a64so12184935e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135904; x=1757740704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVc9sQO+IQWwxU8Et06pJOtpCoTnc3nxzpEuyeramTo=;
 b=VUO1vi9utFEAVD8WfV2dAqWJxAzmq6TSSVGhonvxalC9LjoYPsaZabP/4w2VCHQsIc
 u7gh+Jau6fJxdOwt4cA8qbgJmPoH+U0lr4/IABSe2SSzX9bBZR1A9Q0n7v+mtbemcgYF
 KSZnU0yBfzJOpDNxZ6z5Q1t9a4JgPwFWpvPjJ2K2Lt4C7mxkFfOQWTJklyAwM5ybH3NR
 5bvBkRz84QBPalUYNNRfn4rtae2OQZ9ZFs6obokhZ9ca4LXJLRDRaNJ8TepranVduQNU
 QvONqn9tzokW5yDAcpAxApedIrYQR9BxaD7Sn+2mrot6DzAm1rugnmFlkqwpBN6pM1pD
 3vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135904; x=1757740704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVc9sQO+IQWwxU8Et06pJOtpCoTnc3nxzpEuyeramTo=;
 b=R0wFP8qJ94h9CpirSXTVklArL5bbsxYe7vepqBy0UlOQNecoHEhm12vQh86DJYEczA
 Zh22mH6bm/uQRLn4RmD57lrNIIGz4tcv4dAXcwAlAX03OeSd+bFTzI/5AYlFye7U+Na5
 TQNg18AbgNWdAO4mF2l+vJymL8HCjd58U5cNV5MhJQ5+yNer2xYdoqOme8YepjOrtn4N
 SWy171ieHc7LRqm8wrLn4dJFQxWz0Ozm1NdWvc2EYc0kGt3WSOCafW+N0DYM5BNzimus
 eriDE+5y0zd/xID+AdujQhDjc2oz+carHmbbRDIRy6CwiwxjTQZncN1DqNzt/fq+oIJF
 Rhcg==
X-Gm-Message-State: AOJu0YzjJD+hpkUgIFieOOrGVPLApm1K1akhj15lzoqewMB/ZxoEV//A
 Qux5LbAk04nkJi+eTlNwCuff/mrCU70ceBEQbXrbX2BMzQGOlKd0cD3TZ9GFV6GbauoEsmYhznp
 6kqDDAR4=
X-Gm-Gg: ASbGncuchKiNHb0I+i9JfRPTnd2C90TiJ6ZWvr6sCasZ56rTSeOmu28lrbU3HtOGIh8
 +gfn4aI43k3vNvgi/NNTmeGkbMZXucFCX/2hgI3RTGtCb2+5SMGLNAcrgAHdKBx0tA/oJq9HARA
 BKjHZTWISdIqLYvY/zEUKZApGBzFPyYO0aH6dfhsDeun1bFjOURrI4OGhADW62vTcbU2DKAURfv
 GVAF2ijDPc37ILUBouVPiDJy9QmsBZAFHKWekao09DSNqHd8t6yXJvG9Qm4oRbCcog57ILIwaNR
 y3RpL/ceBqzlaTLrg2/X606cRpiYLZD3TEYi6569yuRrxXEchLCflxMFkKn/4ljI8LqdOeJlLa1
 V0+GKOUL4pM3mXeTSlTZc285xn/3304ApikOe4ArJiQ2mhOZfHu+ndRfZzkF9pW78lOgu9P8D
X-Google-Smtp-Source: AGHT+IE8VPcTg0psR53FHGL2CcfbTMdO36D7dauVqPMWLDpcZNy0IdOT3xDkt2tP/o7Z4KzBDCdYNA==
X-Received: by 2002:a05:600c:3b1d:b0:45b:8ac2:9761 with SMTP id
 5b1f17b1804b1-45dde20e5c0mr7219475e9.13.1757135904236; 
 Fri, 05 Sep 2025 22:18:24 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 02/11] accel/tcg: Split out tb_flush__exclusive
Date: Sat,  6 Sep 2025 07:18:11 +0200
Message-ID: <20250906051820.160432-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Expose a routine to be called when no cpus are running.
Simplify the do_tb_flush run_on_cpu callback, because
that is explicitly called with start_exclusive; there
is no need for the mmap_lock as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tb-flush.h |  1 +
 accel/tcg/tb-maint.c    | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
index 142c240d94..f3898d1826 100644
--- a/include/exec/tb-flush.h
+++ b/include/exec/tb-flush.h
@@ -23,6 +23,7 @@
  */
 void tb_flush(CPUState *cs);
 
+void tb_flush__exclusive(void);
 void tcg_flush_jmp_cache(CPUState *cs);
 
 #endif /* _TB_FLUSH_H_ */
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0048316f99..d1695be00b 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -756,17 +756,14 @@ static void tb_remove(TranslationBlock *tb)
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
-
-    mmap_lock();
-    /* If it is already been done on request of another CPU, just retry. */
-    if (tb_ctx.tb_flush_count != tb_flush_count.host_int) {
-        goto done;
-    }
-    did_flush = true;
+    CPUState *cpu;
 
     CPU_FOREACH(cpu) {
         tcg_flush_jmp_cache(cpu);
@@ -778,11 +775,14 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
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


