Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF19CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Upf-0001j9-DF; Wed, 24 Sep 2025 15:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmC-000729-QK
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:42 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkC-0007uv-PG
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:40 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3306eb96da1so156714a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740486; x=1759345286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9QzifhX/pUAPgBGpctKmSSQO8vSWa/Oizh0/a1q/CE=;
 b=KjLf20wWZBXcAJyc6lEp3iiTuJc1WHVFsA8WYvan5lEk3YD7soGtP2cHkYTnVJOgrO
 7Wwti6GLvTfxJWHMDjuzfzz68PgpZAgTQngKyi6LFFSrh5YbO+A9XZwSRmwxrfxZ256h
 lNd3u31vakHV8nIsACyGQ+fuvjl0wrNN7AEt+gLlTkS2to7ETToEa450pHO5VHG2MZ0v
 E/0Xtf7yKViheK84LQzUvJlgQoU19PdSQeX8cYXwa1Fn6XcMN0xF4Zbslh3CWptStqUl
 uJQZ60Z3N/C3XZmNIAr4tL4k8ypOx6h1NHelPSP/H3TBS1vteeyRsudMGS/EqxOyMRY/
 Lvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740486; x=1759345286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9QzifhX/pUAPgBGpctKmSSQO8vSWa/Oizh0/a1q/CE=;
 b=cipVs/ml77TACCivquL4xI/GQr8Tq6fFVS2TrO8tHz0rd+Icszeosxas8+VScSvDCB
 iaZaFd1QlsuY5NvMu40MFz7J5y/PSEgXkQy3cHLlrhXUHvCftgXS111kIiAJmDYmn7f4
 7bbDM1VtdsuHcrxHh9mQj68G9FI7t44SEXIkSFtGaW4kQaTFQnop83bLCsRNwx9MyatI
 yFsmnNASBksPncrX+IcWhvcaMg7/MBbaSSQt4/jviTX/q/s7wu09MpiGVVjmQx33CyQb
 FjTnNsfKnv5licAzhcTO6Lx13yVYAYT4j77AzLgREKx8jrsBwwITkvP+jI9xaQohKr9Z
 DodA==
X-Gm-Message-State: AOJu0Yzfvid+KnSJhMRKhnckzfL82oyXfU8jJK0AxHUdH91dSWPnHPxy
 kwfRvthGwOQGPyNINAlibPs8Y+MysitfUmusbyDh3ONdZxvtZhuIoZF94O43WLmpRx6/hPVW1Xt
 FIzJ1
X-Gm-Gg: ASbGnctjYuGXzOCaO9faOPkDBBMXPVpLheRtBjeBfYgBYgjVYWObh0A3C4SaAzVMBSo
 ID+Udn9Bp+ga/WTn7C5EGIL9NkHlV0AxZPp4qR2l2wlfJqxwrs7DOaJ/QoyLIjAxO7mVemuU+B0
 IwH/gqoQPAhYoM+UlqQsimX/AOle5Ma6AswPWnNdJIBfYXboYLwzrHXXW1Ai2qBxG7cg6XdTz2+
 2xOTV/o3c6hoXfov2uGWmOK7ZX+ri8ZcGm/sD4TRhhVDMD9cZemBmIk1jBeZHFoW1PMz5gGElFH
 AN+Ww74Vir89/FD11UrFXn746vq2kA2s/IkTblGguDhFdNCj8OCTTjBZxcN54PayPE1TtPEV09I
 ph2g782mmLnVZFIjUiSyh9fbWKLQl
X-Google-Smtp-Source: AGHT+IEan9kSLI3NN/2Xjwpg0Gwr18PuJXmaRpPcmK5pGi0sPSTsQZlXw9tXm/+Luzehke1f7PdbFA==
X-Received: by 2002:a17:90b:3890:b0:32e:3c57:8a9d with SMTP id
 98e67ed59e1d1-3342a30ed08mr680096a91.30.1758740486251; 
 Wed, 24 Sep 2025 12:01:26 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 25/32] accel/tcg: Split out tb_flush__exclusive_or_serial
Date: Wed, 24 Sep 2025 12:00:58 -0700
Message-ID: <20250924190106.7089-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
index e6d45c9c12..b4566a81d7 100644
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


