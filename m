Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18886CAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swh-0004Oq-CV; Mon, 22 Sep 2025 22:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swb-0004Jy-Ex
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:54 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swL-0003hY-F0
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77f35113821so1498296b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595172; x=1759199972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Wx1IpKJt7P9pYpYwnZlwVnkoKrnXLfmcCjmrbQwDAg=;
 b=DKV6GTRQmX4IUK3EHUixc5b/5xs/NR3MzgQb1xDh91iknFDWt/ImAReP0FfQz7f+yv
 0//LkMhzRu74NrAHNm9MqCoCKjTfS3h8qPd/9FDHj0EYvAELxEgqG+96QGKdw1k7QyWo
 dLVLFbmefRTFA+L4bAXbqIrwirAEeo0KLIHUYmHbHX7hjO+AKKxl+iYgK/FAKIFGWVqq
 4MEWkJ1h28CKoFJtlEhqiZRgPw55dlzD2w+i1uVyQp/6v2rNCXzCImB1RoiBn20pTqV2
 +kVGaEIo6ABzNknBBAW3GsAZAoy/7k/HA1pAiinYxL1m3aZf9gkqVwQMUN2On1cJOSaL
 iE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595172; x=1759199972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Wx1IpKJt7P9pYpYwnZlwVnkoKrnXLfmcCjmrbQwDAg=;
 b=J2Tsjlg4B5Ze1xytkVKv+PdDegY9ZS8pN9fIieEmG2M+TI4tjhIZP/S2K6EYPMrGer
 cwpv8qeinOpNIAsdZMx60/hrwVaJCUpAeXtIIdNucwcfm2tLUi6SEab/+2AMbwnjJn1Z
 da6bkWnu443uybeufyF1ttj0uwnNp2DfDfDRdob7Zde9X1a61E8N/FB5q3RSLPlL1XpL
 g64U/uU8odFSGAe05XnoS+pb1Z0CB1AON9w91/oEu43T+/r0o+rmq6zrTRAvXwiPWGPK
 z8W3J17e4sMH+cm8vN8bjNK6bgN6JUofG2bUoqFm2H1KutJdC8QtEnxt1TyZxNOU+0/+
 Rejg==
X-Gm-Message-State: AOJu0YyOciNNcpF9XTZH5OZonM7XGOsPzf2ZvZwl7y/8rqMAdLNcp8i+
 T9+fWGyPWPJZ3J2LxjPTihIOSmy1hKiPh9HBV3WEA7vb+0mdhDhVSiGOoa5i7mhklbeoxUSp4HO
 Jzaqc
X-Gm-Gg: ASbGncueOY6/mU5ZfGd/TI7rPs3a9mc+GUSuCQdhqUs1SAFOVUvIZiLZcAnblgxOljg
 YpSOsFOJcyZLu17NloKf7VEOB2gd578bE4yR/Pws701hnDnHSyusG2yqNf+WfMlyuKzRRO70HxR
 zLlLGh+FryCzAKniRrXx3tMXmr/gBIFplllveSRdREtSQ7sBFznwTqHfi9avM5IxyGtgBdTA+K+
 PqBuZRRvAyBImYNDWE3Bei7owTT5dhbNP48yAJgc/vd/3rGHCmmx4hpdXcW8nu2YQueJc69JAiS
 fg64p2iwTTOY18Tr7MW5EYQ9L38DtzkCJgrgiREewGUSt+7BVAAtZKT9l75dk0UvvsTrGZTMRs1
 gvOB15GLuufkrmEIGi6Ijwa2hygYOP4qQhEck6XE=
X-Google-Smtp-Source: AGHT+IFk0Ol0fUOi6mk3Hx34RNQSNa6E5BJWKc4agxTq1oAoj+deIa5Accqy6iwcXO1+DmmvQG6RcA==
X-Received: by 2002:a05:6a20:3d08:b0:2ca:1b5:9d4d with SMTP id
 adf61e73a8af0-2cfd4836d5cmr1645685637.2.1758595171830; 
 Mon, 22 Sep 2025 19:39:31 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 11/12] accel/tcg: Remove tb_flush
Date: Mon, 22 Sep 2025 19:39:15 -0700
Message-ID: <20250923023922.3102471-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

All uses have been replaced with tb_flush__exclusive.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tb-flush.h | 15 ---------------
 accel/tcg/tb-maint.c    | 22 ----------------------
 2 files changed, 37 deletions(-)

diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
index 5076b13bbd..d6586b9d5f 100644
--- a/include/exec/tb-flush.h
+++ b/include/exec/tb-flush.h
@@ -21,21 +21,6 @@
  */
 void tb_flush__exclusive(void);
 
-/**
- * tb_flush() - flush all translation blocks
- * @cs: CPUState (must be valid, but treated as anonymous pointer)
- *
- * Used to flush all the translation blocks in the system. Sometimes
- * it is simpler to flush everything than work out which individual
- * translations are now invalid and ensure they are not called
- * anymore.
- *
- * tb_flush() takes care of running the flush in an exclusive context
- * if it is not already running in one. This means no guest code will
- * run until this complete.
- */
-void tb_flush(CPUState *cs);
-
 void tcg_flush_jmp_cache(CPUState *cs);
 
 #endif /* _TB_FLUSH_H_ */
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 71216fa75e..879ed12442 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -785,28 +785,6 @@ void tb_flush__exclusive(void)
     qemu_plugin_flush_cb();
 }
 
-static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
-{
-    /* If it is already been done on request of another CPU, just retry. */
-    if (tb_ctx.tb_flush_count == tb_flush_count.host_int) {
-        tb_flush__exclusive();
-    }
-}
-
-void tb_flush(CPUState *cpu)
-{
-    if (tcg_enabled()) {
-        unsigned tb_flush_count = qatomic_read(&tb_ctx.tb_flush_count);
-
-        if (cpu_in_serial_context(cpu)) {
-            do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
-        } else {
-            async_safe_run_on_cpu(cpu, do_tb_flush,
-                                  RUN_ON_CPU_HOST_INT(tb_flush_count));
-        }
-    }
-}
-
 /* remove @orig from its @n_orig-th jump list */
 static inline void tb_remove_from_jmp_list(TranslationBlock *orig, int n_orig)
 {
-- 
2.43.0


