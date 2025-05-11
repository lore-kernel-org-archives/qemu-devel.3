Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5F6C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WH-0006V0-Mi; Sun, 11 May 2025 09:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WD-0006Q7-2o
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:01 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WB-0006p0-EY
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:00 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id B42A5180052
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:47 +0200 (CEST)
Received: (qmail 25974 invoked by uid 990); 11 May 2025 13:14:47 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:47 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 05/23] target/alpha: call plugin trap callbacks
Date: Sun, 11 May 2025 15:13:57 +0200
Message-ID: <6a14e26661d3bfb9120f504a7c4de0b5023d2412.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999406) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=5JCAPKLe/6ZLVixYexxl1bNlbmlq04Bh5tEHZjqm5Ms=;
 b=hv1RE/0h/RZkVzHdzUMaP8qOIpcdn8jfWVM4Xb31Kmewqz26EjteH2LJBmhlzzff6mfPaq8L+G
 Wu9hghZheuUYj04eMqfYvf3KdKMwgqbziB0Kf7rJ1Xn3r2iIdgfUjT+Nccf60xmcmKwqOG2yryJV
 2xS3q61R10YhrjF+O8MVNDQPQ09lziE+zzgxAjuFE5HhE9ZTtIIpIdQOAcCjNF51NucjJzR5HmW/
 1V+/GYIfwxyZGoNDXGLMZYsGU98dMHM7QgINyq86cpbppAVDmnJKUqzfgIPuJj0g2QJ/uVQ9YbOV
 l+RpgFHUgB/5zQIlffrSS8Fb6wWqKIbewXZX7W5Osu/6A1Ms/MaVrZ+sz+IlvwelScngpB4CvXoN
 4WpKUtDcqR8QfkfMfBPRhPgsOHoUUQf7ODCV5FMhs802O3/VAaYsRhGzKmg0f5rUkm++/QTA+++I
 bpgBV2nZE3hcKnyJruMZkbkdPl1UHPAx2a+hPtPHgkQOWQcD19Ys0EnGivrJtr6ADGCKB0Z6BAgj
 tmckkcbMaWX1gA9KTGvCg+Q4V6zZdG6LWLOqYU8/jOrPUlv5WQkjJo/IFz6F88O3DIn8RkQzL+Zl
 VijObrqDM18gbbLCpuEA//ghdg8vwYOr9sHvd1KduXQRjTdiUslb4Bsydyk+A6hhav4Z9Ayo89Pj
 A=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for Alpha targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/alpha/helper.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 096eac3445..a9af52a928 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -27,6 +27,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 #include "system/memory.h"
+#include "qemu/plugin.h"
 
 
 #define CONVERT_BIT(X, SRC, DST) \
@@ -328,6 +329,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 {
     CPUAlphaState *env = cpu_env(cs);
     int i = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
@@ -431,6 +433,17 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 
     /* Switch to PALmode.  */
     env->flags |= ENV_FLAG_PAL_MODE;
+
+    switch (i) {
+    case EXCP_SMP_INTERRUPT:
+    case EXCP_CLK_INTERRUPT:
+    case EXCP_DEV_INTERRUPT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    }
 }
 
 bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.49.0


