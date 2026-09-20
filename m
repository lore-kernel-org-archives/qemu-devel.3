Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D8CC982D0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zJ-0006Tc-Rl; Sun, 20 Sep 2026 01:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zH-0006TD-NT
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:15 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zF-0002CD-NF
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:15 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466ccde2ad9so2203104fac.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881669; x=1790486469;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QiyB9c5Bdg+QodldLg9j0v9/pkYpX+URx43sSQBZr2E=;
 b=vejsnDy5a2Hd+3cUWSzCtEK1cCdpLwCrADcLqLmui53aK+naXVRIu58G+i4BAoDpWn
 hE3z4Nd4v1DVFsvf6k8Ln03yFxGQROGXxn1D1x6tBh+UYcM6B40zB+IZIX7evGRlyxB/
 O5LevZBvIXYSE7zftPIGF7NJkSHO/N6AH8SSXESjaWIaTtafs7gzltOE0lC66aBvKEhu
 FS7k52ZkgNbtKnwF08pEiOAgUWNN5X7en5omKhKUcyerjpJSoEhYmvq1CEp9h9avIjRH
 Re+n4IzN8n8VZ79cVTgXoH3hYH/ZzmuoRgvu41qSujOzqLgkXA8Zd7QVOlzFOrcs6L6s
 4vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881669; x=1790486469;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QiyB9c5Bdg+QodldLg9j0v9/pkYpX+URx43sSQBZr2E=;
 b=ZR+sM5Nlisn4f1OIi/CKf+Wzl3gw4UNdwMqZDBNcEkqkPPl8kbfwu5AYkceibK8Xt0
 uGvgTCee3Q5OpXSf6UPb5Xkpmntc1JlSDSr/9cP3tBuTPqIVA9bYYImhnTSXCoHTdji8
 vpamVzQiCxqY9e/rgZ8ya9MujtHfy1PjVfz8WQ8UJlKP1t7OQLGNeAo8EgUEmr4FxWjg
 I/Eu8NFQjAiwwxnY9HSfx0U75Jv5tAvHpLnTYF7RuJBm2uQNpm4vKtcGHuGvmCjpayhk
 k7T1HiS2mrYK0Tb0JFIxuHS1d+XH2qXbVja0aYrghVqTWEUi4eXggZizpwJiMwckJwWG
 hqmg==
X-Gm-Message-State: AFuF++nmWE42d5ZXLuJH6mC8+vofGsFHkxVckHpVZsdwgBzCDMuR0r70
 2zNXTkUPjPignj7xSQQuZ0QNGqKO1KyJodyobX/dQ41FbS1wlEp7y0IsxJ2EP/vAxxc=
X-Gm-Gg: AYBFou1lxNdXMfOZWRUvAQYtZ9tSY4rfUzNzlphMIhCLefjs4GUj9AnmF7FVFona1rZ
 DySiSFjqnSDDVt1STGRGP2x+jhpPXUgjFznnH2DfcQWLYD3hNpu38hGbZpx5H0yCpx9TzPHnKGj
 DvvAH6vC8eLc5dS82tjrvdiF2Xi229W2ZbRs27KBlWVrojHMDBuJjJSWhiwWVDrQ6DzfVPpwjZa
 OrhFfNA4fyPgfVhp+oDeev92Jxou/UDKCwGfhAEupccyxOloD3viNcu8u4f6O7KtxOiHdPK4UO8
 LZARfut2JstUg/4W0DFnoOIL5opTEbERb73/pBexkYtSEBOvDOHJAhtkqV8VYL1avpqDg7HFNrE
 ZUWkx9EZU4VwbatUuk+tkUaVpqeFdwrHEAmYGHWXA+2bQwTYh1Ooxde/QLXrsWDewY5OuJChuQm
 vv6Oc9VRRcMtrCsyMN4xp22/qj6UGaqVCsbPwPxbX5acjJltoXA9JxssVEiA==
X-Received: by 2002:a05:6870:a68a:b0:43a:19fb:8b99 with SMTP id
 586e51a60fabf-486e5134537mr6364416fac.9.1789881669385; 
 Sat, 19 Sep 2026 22:21:09 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:08 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:43 -0600
Subject: [PATCH 07/14] bsd-user: Move tb_flush stuff to begin_parallel_context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-7-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=7822MqM1d4BPQEPXjJR1UtmKlfh1OxDmw/FX+cBOnkE=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20wjQfNwjwMxWzj7gkjECwJlGYINl4LeQi2U
 VkDtCNN2v2JAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBcHBAAjoc8g2o1TjJvjBgfwvkKs2oFX3n2d2X
 DO0RZPUXMxn/NAQoCXZZqO4Je5ECYbrTX0dL8LTSBzv/1ILLg3pEvlObJ940wojzs1FSBo1RcRE
 dgXNSkP7SFJK7RoiX5THV7miOHN95q0W0Uh6bm+ztkQ9R6bgSlVsQho5xOVSDEojJVC03hKD+Wx
 FggvEhz2CuYbccHA0XqsBFFsR/+otjLcISH2gabrMtzG7/kQHyLUeTMuz49QNORBfWtvhuV1skK
 0feWvnb8I+KB/2PG9zYlWAnOnHYQfx4U9Qs2gcSPmcIJz9B6e9jFeESpYlYTi5UeFD021FU+np1
 8EOQbpowvpQaJZ04WQ0nukqCdRPggyQr56/kko5EcJvg1PNlsyGbpmJCzkzHet6U8r1CgwNY3Yu
 xjDICdDy0jrOtn7gavcYgzYwfuz4B1hlmLUVL3JTXWGz0lmIl1CLlAysfyzScFdRsjlwgarb3Dy
 DyNhZY+Xbv4Q/cS5ofof5ZrGgDKLaZHNBqIjawgeW+G+arPJXuJvF1OUHNM+WGjHtJTDMTBo+Pe
 6lf+073MbWkPdwW3E2dXbq7v9Q6enWWclnLzvxTy0Dfe5/NNAzvNR1jRnP7+tdVhI7NGJLVZs/q
 Ma/KJzBQn89Yakf6MFVBxchlyV6XtC7TTAAl2QPBFyfpPgrS5gYU=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:30::10;
 envelope-from=imp@bsdimp.com; helo=mail-oa2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Catch up with linux-user 430014bee7a6c26a70e9f3854428843d5918cdf5 and
impelment begin_parallel_context. We'd already moved to using
tb_flush__exclusive_or_serial, but need this in several places, like
linux-user has.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c |  6 +-----
 bsd-user/qemu.h              | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index eaab062d3d..4ffa76a798 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -16,7 +16,6 @@
 #include "target_arch_thread.h"
 #include "qemu/guest-random.h"
 #include "tcg/startup.h"
-#include "exec/tb-flush.h"
 
 #include "os-thread.h"
 
@@ -1622,10 +1621,7 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
      * generate code for parallel execution and flush old translations.
      * Do this now so that the copy gets CF_PARALLEL too.
      */
-    if (!(cpu->tcg_cflags & CF_PARALLEL)) {
-        cpu->tcg_cflags |= CF_PARALLEL;
-        tb_flush__exclusive_or_serial();
-    }
+    begin_parallel_context(cpu);
 
     new_env = cpu_copy(env);
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index d2dd8c2ee8..851b0c2c5f 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -41,6 +41,7 @@ extern char **environ;
 #include "target.h"
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
+#include "exec/tb-flush.h"
 #include "accel/tcg/vcpu-state.h"
 
 #include "qemu-os.h"
@@ -529,4 +530,21 @@ static inline uint64_t target_arg64(uint32_t word0, uint32_t word1)
 
 #include "user/safe-syscall.h"
 
+/* In user-internal.h in linux-user XXX consider similar cleanup */
+
+/**
+ * begin_parallel_context
+ * @cs: the CPU context
+ *
+ * Called when starting the second vcpu, or joining shared memory.
+ */
+static inline void begin_parallel_context(CPUState *cs)
+{
+    if (!tcg_cflags_has(cs, CF_PARALLEL)) {
+        tb_flush__exclusive_or_serial();
+        tcg_cflags_set(cs, CF_PARALLEL);
+    }
+}
+
+
 #endif /* QEMU_H */

-- 
2.55.0


