Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6173FC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xcY-0002ii-Tk; Mon, 06 May 2024 08:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xc6-0001l7-1I
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:42 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xc4-00021p-Ey
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34f0e55787aso822513f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999113; x=1715603913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRaulFrVbkjbtSZtw7OLq918oPDYvf4Hs2z9z8eLBTc=;
 b=gzmMQyf8Bi7+T1ssq1FFZpGVmwXjQ1SyOVcFtj44J9XMJ+lPD92ipdMRvjoh2dJq/E
 JqKatqH62UrNSivCLLeeuRRMKbEsDc/SYyGFuqyL5iybyUVQsnYgAcWn/1sMUdfHjCpP
 dxLZR/mX2rDS+61NzXaAfLUm/qsMhFP0QFJjXX1KmtphAgC8AOj2bAke3Zvt2F3fdltE
 iS3ck5A5Ud57MJXybtilKqnCyfz4Y2pQXqvMbxcbSXRqX1Lb6+k1q6in0GNEH/r2uMv+
 sIyw+il1TdJxQCvs4GUlhuCBMXXjM0+ezFJ4Af1M9ebd8F/cQbDlG3ub7xAhwvhwMbTQ
 bmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999113; x=1715603913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRaulFrVbkjbtSZtw7OLq918oPDYvf4Hs2z9z8eLBTc=;
 b=D1rA7ev9YHMgdiix5plVHYyuZ39KUyjw92hG9olvANWU6MFiIv9QWC2dCOhBUZJYGC
 Z2HxT6LPetRyhT4ij+SEE8ZLRMUltp5tCDr5q7hIgvEYzRaUuZI1IV+5J5I4VmZek25D
 yh2nkhyR4RYcYaTdXZza4S9XE+OLZzmXF2pgugpS7BZs8oynpkHgBiUipSkdJheXCdZd
 28wWDwMDqHKA3+e3Kd2IHzRxOMVkBEnIJ5qJDg0ZkBePA92WKdc9y1fO/qwlH1m5x415
 R9mrXxwPdNTrSWSIvacmkAqe9iFhNOVs0qsIuzbStXsnY4pNmgn0nX4/J3VfDYfcFkIM
 TvZg==
X-Gm-Message-State: AOJu0Yzs9t8+k7j858anM/h3EQ5Af//RitesmnAbw+0PNe6wWxGPxiKP
 YzegMukD3motPJT0nnvakgpknI7hq+NIvshizBcexssKkn3zpXdpeuSAB3q0dPGQCWEnKmgzvke
 n
X-Google-Smtp-Source: AGHT+IGqTROF3GTy53nP+LdLFPCbvIdi7FvZr2toTO2gJgz22vqbfJAk9KFb71QUg3s5JFTWuoboCQ==
X-Received: by 2002:a5d:678b:0:b0:348:b435:273b with SMTP id
 v11-20020a5d678b000000b00348b435273bmr7293332wru.54.1714999113584; 
 Mon, 06 May 2024 05:38:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 g4-20020a5d5404000000b0034ca136f0e9sm10605321wrv.88.2024.05.06.05.38.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:38:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/28] accel/tcg: Move user definition of cpu_interrupt() to
 user-exec.c
Date: Mon,  6 May 2024 14:37:08 +0200
Message-ID: <20240506123728.65278-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-4-philmd@linaro.org>
---
 accel/tcg/translate-all.c | 9 ---------
 accel/tcg/user-exec.c     | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 83cc14fbde..fdf6d8ac19 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -644,15 +644,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cpu_loop_exit_noexc(cpu);
 }
 
-#else /* CONFIG_USER_ONLY */
-
-void cpu_interrupt(CPUState *cpu, int mask)
-{
-    g_assert(bql_locked());
-    cpu->interrupt_request |= mask;
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
-}
-
 #endif /* CONFIG_USER_ONLY */
 
 /*
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d34313a612..80d24540ed 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -24,6 +24,7 @@
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
 #include "exec/cpu_ldst.h"
+#include "qemu/main-loop.h"
 #include "exec/translate-all.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
@@ -38,6 +39,13 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
+void cpu_interrupt(CPUState *cpu, int mask)
+{
+    g_assert(bql_locked());
+    cpu->interrupt_request |= mask;
+    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+}
+
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
-- 
2.41.0


