Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FAAC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9643-0000aS-Fr; Tue, 22 Sep 2026 15:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963g-0000YF-15
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:40 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963e-0002Ol-6a
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:39 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7fcb425fb68so205115a34.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104895; x=1790709695;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3802hVch7coeY9/Oku8VrNAJ9qmzEerk66SLOd1unrI=;
 b=HaR9ij48corK7+mQy9sZdF3QTOdT28TUasWcEDC9hv2YMgqwDvAWNA6oHzDZYq6E0k
 RokJngVEyZ5aIH6v1po9ORDtE0CHqlhsiYtFROzFTHf9TqjzUZSSMG3N+G1aJsIbqyOw
 NcmfYyD8Egx/rYPYOHbEHAlQnNw+seQrskUfJlA6wysJBp9+1ZseDHURz6FXNU0KnBJA
 lj0+G4mQun7F3+vHALuFbiaHdr7g7UgtaWNH5yoWZZlwCTa+3b0YA+nVU70/Ezx9q2ED
 GjMDiWh6PHSvn2BZXGaQPCOxj+kpWOVqOgzjnMFnFDYvHOikWBnzWHFjPIb5I2BoB3Wz
 l3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104895; x=1790709695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3802hVch7coeY9/Oku8VrNAJ9qmzEerk66SLOd1unrI=;
 b=UTR6s6S2NeHuMJpUuXJVx/RRQP1KCk+zk35u8D9MCfGk92N7jgp+z2CJ5BhYH3Q1WL
 MeBjyqvMhAy5J3DqGNFLo8oHSouostq1NRvy74kHz7P4V4QyWPt9IURkyuYMiQUknHtE
 7dj17MKTU50p/oCudQBloUEzaGbcpDhivY/Iitu2GYb0IWB9POr0elEcEy/molo+mkgB
 tmjuAmjqpWb2tlBEt9+/r2pmxWCseflGKQxO8r9dGHt/ZAriv75A7PrwxQcBeKKfr9J1
 B6MEatU4dyYUlwgxMu3UpMQMQX47vtjWWnMDQqIMF1rlbNLoCY34cRGJtRLQRS+QqNvX
 IVMg==
X-Gm-Message-State: AFuF++mhNE2JDZ8GsrrryfUlAY7MLs3GfwmjDWPmhc5MOkHMoiZMPPFI
 FW6cuB/KccGNm0ln/hpxM15vVqLzB2CRQMkXplI7I5H5OoK4/CNbtSFPpM/rosbgeJziN9f+p8U
 simUstsE=
X-Gm-Gg: AYBFou3bJd1XCjNjjGcp8vczgVIjZSQ9CRWjRMUcIZsWU/8rBR42J81ZmU44VAUkZLM
 7HyzIDr413gpj8ZtUdJYutM9AwhvjsgDYQLj87aEt9MBRYXEuZMaA2bPGhitVhvpwurx4hPzdlc
 m/vxI8JB6MbpKInXvB3+U8sJ2k70wGF3fPbzKIRETF6UpFzP51Uaq3awudjLpMSoSUjtI8WSf3b
 Tm1FMk8GBqs0q3uNE2YWpk5Rx2AY19IA5oBlb5ob6JZLnKAB9t5ENkm6Nqqyef/lH43jUdTZjES
 aohrtjCeUhSPkp0WcAik+1bOBQNJyg3/7lOv7rxnVdO0FgS1JYap9VEaVDd8hOMUBNkk/nihO5W
 cqeAMplnhAPKcSPImyKNn+dBOOeG9/np1nLflHe16WpgiuXWC7mB+KTA+I5kVhsqxx38+Pgt0De
 txXlhicjp5lpnHbevSySFitmD7DqOjfnwTckVsExq7D5soS/7SFYcVTWqkzA==
X-Received: by 2002:a05:6820:a07:b0:6b1:3cb7:f535 with SMTP id
 006d021491bc7-6d2cce832c9mr343990eaf.0.1790104894767; 
 Tue, 22 Sep 2026 12:21:34 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:34 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/11] bsd-user: Move tb_flush stuff to begin_parallel_context
Date: Tue, 22 Sep 2026 13:21:04 -0600
Message-ID: <20260922192109.98467-7-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


