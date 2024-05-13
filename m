Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA2AC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QSc-0005Oh-N9; Mon, 13 May 2024 03:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QSX-0005FC-Tt
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:50:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QSU-0001zD-W3
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:50:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34e28e32ea4so2520456f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586653; x=1716191453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IL2hAokqpmQr3sSx0rCsqvvhI5ki9eqOu02SaoXaEMQ=;
 b=wqDvvEL66jQSH8KvL0FPFNSZOR4vRc16C+dKHkpq/5/arxF54cNdxDRwlh2sBrfjWU
 oUuq5eKmdVfxO7NSc+vICJiy5Zq3K7L9m/vXZAKu55q7TwR96nzpuRNv4q3WNfVX3OMX
 0xHV4JrgvVjBTT7QU4C3mNsQIA2vSIdNS+3rj54terTxzYbdRPrqZISZ1aw1PfdjeG/K
 r1cE99I4ZXvGYR38RsaEaaMbcyz/ebCuq0rmATR9BLwuqfiWC1Rmi6TgZ7EczesQuh8M
 nWmIvxzkQARztLaD9R8QqW74fZ3q9ndKFfKU6hXsXZK0TWiRmklgCKQznGgutWrbI5XB
 i++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586653; x=1716191453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IL2hAokqpmQr3sSx0rCsqvvhI5ki9eqOu02SaoXaEMQ=;
 b=PcWsWzJFcL1l5LdRWYmpNPEYC4yXZB0SvNBEYLnq2w29FT13Jjv2eU/R8k+baU45TZ
 SVJS3dUKC8bazCPZsx8DJUUPywoQdgZKS5pzV8Vy1xt3867+M9hJJA4ZiPXnWK6A4R4b
 ifJdIh0OihwByPROXI89tL5M24kChWtaJWLjHH5f8DcjFiJoXwaR1zNA+sp59J2bdn2/
 K723IDg/29ny2u2mSoQX3YRqE8IJoE8fSta2gk9mzIQ6VGUyn77PbYdk8HyLGiwy/2Bm
 vAblgiQMf6NpXHqvw2ny7pjeDiFqZk30Q3IeXFxL8eyTyo+lZ6JULhM8vC53e9ldqDJ6
 JGwg==
X-Gm-Message-State: AOJu0Yw/Nh7P1vblfXgaldauBqAI32p/VQAK2Udhoh2qIiAzA9nLKLOg
 8TX3EKRZCXbqgQxlWLCL0hGRfUWc1TmCPiNhOGu8AKKt465KW1CCm6dXYShnKyIgRfH+Ud6ANyQ
 O744=
X-Google-Smtp-Source: AGHT+IFXCNQkKT6F9xFmWb1yRl1jHxWjLWM7fQQV+7dDAx1w6JBgoZ+GYV7fdAVXMW7KAklDxJCWcQ==
X-Received: by 2002:adf:e649:0:b0:34b:81b3:2c62 with SMTP id
 ffacd0b85a97d-3504a73e850mr5604558f8f.35.1715586653713; 
 Mon, 13 May 2024 00:50:53 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a50sm10374262f8f.30.2024.05.13.00.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:50:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 45/45] target/hppa: Log cpu state on return-from-interrupt
Date: Mon, 13 May 2024 09:47:17 +0200
Message-Id: <20240513074717.130949-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

Inverse of the logging on taking an interrupt.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/sys_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 22d6c89964..9b43b556fd 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
@@ -93,6 +94,17 @@ void HELPER(rfi)(CPUHPPAState *env)
     env->iaoq_b = env->cr_back[1];
     env->iasq_f = (env->cr[CR_IIASQ] << 32) & ~(env->iaoq_f & mask);
     env->iasq_b = (env->cr_back[0] << 32) & ~(env->iaoq_b & mask);
+
+    if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        FILE *logfile = qemu_log_trylock();
+        if (logfile) {
+            CPUState *cs = env_cpu(env);
+
+            fprintf(logfile, "RFI: cpu %d\n", cs->cpu_index);
+            hppa_cpu_dump_state(cs, logfile, 0);
+            qemu_log_unlock(logfile);
+        }
+    }
 }
 
 static void getshadowregs(CPUHPPAState *env)
-- 
2.34.1


