Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848B8CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ay4-0006Js-Fy; Tue, 23 Sep 2025 17:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay2-0006Ih-0Z
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:34 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay0-0003iV-5o
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:33 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b555b0fb839so1556845a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664470; x=1759269270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUBd7tS/TsoOS8gEfUczns3Sij2rmJYe3yGqDRcLhFc=;
 b=dDwvkof6Nd04Pa4pcCJM/pFa23sx+sZzHV36E8Xg5x0esQS3L54j0ZSnnjTMTMtelx
 /JYEgvZjjv69lOfwqTAgKADTtKxTmQT28/iqLv6Ibquy1iL9oCVcYNLrmMtoUc0Uboyd
 FuTOA59HzKOLuTvdGpNgPd8KQYEQucnJJI8wuP2ZBvUge+mI6GNWsHxUCp7UB6+lxJJN
 n5cMcfVqILEi8TrZZTuP0Fs40RZUancs7Rcdp+wWkNOSN+DvEir+w3OWVVjVqfXNhEv8
 PRS8xbH8BCzO8OqMDYKvgVrLE3gzoHyiz+K7Q3FFvtSTjaBvfVhD5aCMvToqhWBZKA7Q
 5Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664470; x=1759269270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUBd7tS/TsoOS8gEfUczns3Sij2rmJYe3yGqDRcLhFc=;
 b=v3b70KWwFygSJTKF1XGWiV2/h+jxFipd93sImWqoAYVIOo/sW0ho+BCNcfdWfBg2cK
 PcwskOUZ5jqTIx8EIn9AyC87552icrK78zVzD93mWFKY/+KTcasawyXWgD097kT6tkDP
 a53o1/KZaPODPva4m8lMv5XSmbrpWpqnV50PaxLgdlP0/HVVe9swi6HRY4aZQQPh5OOz
 Gu82msYOcWIZzMSsV+yCTUVQjk6ezkSOMWm0GKQdspCrJ09Cop60EpTMJKpHM5JUezmF
 E/CeIBGZrqXgMkeoeH+5IAnSU3uNM14+PSYypKU00Uj1BTxo5/G98m3900oZ2s81Dfal
 l59Q==
X-Gm-Message-State: AOJu0Yxc+Dholy24wxqBiaVUf05OEgIA6zUueXrrPstG/4zcMl2AjBVY
 2OFnd0Rf4VUKSZp0u5o0Ne08+m0CpTQmWt5ofDVpoA2HkzgGzcbQ+fYANAMJCBRSDMDNr83C6Ag
 0w38C
X-Gm-Gg: ASbGncu0EpPVkbKqJBL9aJWrWLpvhPdQv8VASUSjABZnLPMXNJdk5kPSPRQTms7Ll6N
 2rhTq7sjAhqfofKCEGimyRbWupXH6D2kfwXPjk1rqi+vdSjt1R1n/pTYYj1gL9fFAAMNoHu6RsE
 soh4MzOdBubvT/6Y5A/n8vXWhD80E2fMQAU7bLnKlZlqybg4RTkex+9iIDMa2b/av0bVTvFxsj5
 Q3GfR9OS/0tKG9GmZpmBKypHEfVo00bXxvRVapbQRiSvQb1WEjDZFD2pfYVeO2GyMbKYpxFH0sB
 LxD9j+dY9DMBg4Wbyl02GBEyFUXLwfEm1oSw3ZRwnlS5wPatmLs4isW5JQjk/bA4gvqJPwACasC
 OelXjxcmge0yf1x5za2d3QdmzHnSu
X-Google-Smtp-Source: AGHT+IEhHgnBjwlDLeIy4g++0rZqmNsZg4l2sAa4hSJA2xaRjwZ/Dvbgyw/f+ZgsB6TUWAxDYivMfg==
X-Received: by 2002:a17:903:190:b0:277:9193:f2da with SMTP id
 d9443c01a7336-27cc0dbb137mr51075005ad.5.1758664470467; 
 Tue, 23 Sep 2025 14:54:30 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 05/10] accel/tcg: Split out tb_flush__exclusive_or_serial
Date: Tue, 23 Sep 2025 14:54:19 -0700
Message-ID: <20250923215425.3685950-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tb-flush.h | 15 +++++++++++++++
 accel/tcg/tb-maint.c    | 39 +++++++++++++++++++++++++--------------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
index 142c240d94..090ffc8818 100644
--- a/include/exec/tb-flush.h
+++ b/include/exec/tb-flush.h
@@ -8,6 +8,21 @@
 #ifndef _TB_FLUSH_H_
 #define _TB_FLUSH_H_
 
+/**
+ * tb_flush__exclusive_or_serial()
+ *
+ * Used to flush all the translation blocks in the system.  Mostly this is
+ * used to empty the code generation buffer after it is full.  Sometimes it
+ * is used when it is simpler to flush everything than work out which
+ * individual translations are now invalid.
+ *
+ * Must be called from an exclusive or serial context, e.g. start_exclusive,
+ * vm_stop, or when there is only one vcpu.  Note that start_exclusive cannot
+ * be called from within the cpu run loop, so this cannot be called from
+ * within target code.
+ */
+void tb_flush__exclusive_or_serial(void);
+
 /**
  * tb_flush() - flush all translation blocks
  * @cs: CPUState (must be valid, but treated as anonymous pointer)
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0048316f99..7be9a1c4de 100644
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
 
 
@@ -88,7 +91,10 @@ static IntervalTreeRoot tb_root;
 
 static void tb_remove_all(void)
 {
-    assert_memory_lock();
+    /*
+     * Only called from tb_flush__exclusive_or_serial, where we have already
+     * asserted that we're in an exclusive state.
+     */
     memset(&tb_root, 0, sizeof(tb_root));
 }
 
@@ -756,17 +762,19 @@ static void tb_remove(TranslationBlock *tb)
 }
 #endif /* CONFIG_USER_ONLY */
 
-/* flush all the translation blocks */
-static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
+/*
+ * Flush all the translation blocks.
+ * Must be called from a context in which no cpus are running,
+ * e.g. start_exclusive() or vm_stop().
+ */
+void tb_flush__exclusive_or_serial(void)
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
+    /* Note that cpu_in_serial_context checks cpu_in_exclusive_context. */
+    assert(!runstate_is_running() ||
+           (current_cpu && cpu_in_serial_context(current_cpu)));
 
     CPU_FOREACH(cpu) {
         tcg_flush_jmp_cache(cpu);
@@ -778,11 +786,14 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
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
+        tb_flush__exclusive_or_serial();
     }
 }
 
-- 
2.43.0


