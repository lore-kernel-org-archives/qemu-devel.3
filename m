Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32434CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hye-0006O3-Q8; Mon, 06 Oct 2025 05:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyZ-0006Kk-Uc
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:51 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyY-0003os-DP
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:51 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id A934260B7B
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:57:38 +0200 (CEST)
Received: (qmail 18688 invoked by uid 990); 6 Oct 2025 09:57:38 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:57:38 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 05/25] target/alpha: call plugin trap callbacks
Date: Mon,  6 Oct 2025 11:57:00 +0200
Message-ID: <7c6fe7d9cb00f84bb912b1e4393c656815b5cc7d.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.995421) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.595421
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=NQdS6b7lSZHjuzHV/xnNiUQELPfMS5Qhlg2RCswDKUA=;
 b=B3kpuZdbD/clCUytsY2r2M24fy77jOvlamf+MH5GiZur/NEf+uT6hMuV/EXa5vAv71UONBWj+P
 z9WQLlYo3tpApggUU4vpls+YzIWb0c9M36VBWiCla4O6lqh2E0QlpY7hH2sjHQEqZfVtfAay885v
 Ul3H0JY0WCNYNwxkPFB+ztw4yy+voVOhZfnDUSaBHa8qsOgMSI4ObWiWujhUou0S0bTpeDLghdje
 RdR2tpKkLTkZL8siokiJRTY1HGGQspnLupKktqFYOsD9EdoLsJsscQHlH4H1XCHCEtb0dK5ljqJq
 AI90CCNxTVGjhbvbU6va+Ez2dbrTVaMbWGpqaLDaK+jT4+vhzAx1I/2CBhEpqBbKDvkAolzBDG+H
 d8TFVkl/6VaQNdKWWlAtePXBQbF6S5uF34AHLIIp9j/HC5P4wpnV03NjZmZ4Ilhs4pwcpD2KprcS
 ARo9UF63KfW6m9tE5qeWyjGzv3xsfLQzrSUUZJ604XS7a9o+IzFfaKwF80jU7v4nguY5gYEUAY2M
 7V1TB8h1Ky68MAtRDjn7Vy0ABfOGRGHInNxCDZOmpRr+f5OTTAniWxo0HoSNDCtgyViX/UhLRDQr
 zJ0sZiatcYgRI9O4G5/ehNlgknU8DmeJQoAIzmGuZYdGFjgNfws7e4kNvSS76XMGGlbLCxng81N6
 A=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.49.1


