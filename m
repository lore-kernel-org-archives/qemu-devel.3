Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B74CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQkI-0005Sk-EM; Mon, 12 Jan 2026 17:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkG-0005BV-IV
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:44 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkE-0002vO-P2
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:44 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso60041995e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258241; x=1768863041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ras1IMApp603uPUkGN2gtalv8z8CpghVMPwPfzKwAUQ=;
 b=SdYz5la4UdKZvsdsoTLp2IxYQLtB2xahWUAUO+HilTeaD2cC9+fTxudJR03eDLXxST
 TTKd6kb9lTOlJawlLYQHVZO4mO8807MF/PHOgf4UtupdN93gFVrl6EhTfkoOiNXCgM9j
 skV0ivMzTHVE2BfQnnDcVfBPKRW3jqiV7XN7yMIhLgjd+iWBW+hX5v0Jpamla0pFRLf8
 QNonFLW4JYysL5gwFaTBZOn36Zmi2ENk+3xJCrQjPUduP2BC0CsT9yHPaZHsnue143Q7
 PL4QQAGpzvYOSzUEsEWdciqOTQMmZxWU0hWhjYkPh9YzTk3GJd25e4iqdGxQ4o2t7PAw
 cP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258241; x=1768863041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ras1IMApp603uPUkGN2gtalv8z8CpghVMPwPfzKwAUQ=;
 b=wyluWdA0O4LtF2bVE1X+1YRCj5MfFa7YFogrklwwZC6ienRv5cW0TTqZKZzDbO0Agm
 fhDop8IEW3+8kijxbAKESS4DEi2xxput5+waDRxaZCZCGq91wmUh0RDowJqhrOYCJVPa
 4iAz75gm5eX2MyXrRir7o/S4zOYPYvwSJ9fHlqpaqwvNKR/bdBSzm7muEXaVmXCisnLg
 eWQmx58/PYIpKkEtX287kwoa+lblf1wbYc4ajEcLVYyHDjnfPV0fAjBoohCGmaoCRv9t
 OehRlO3YQ+TuWBR/VYzQ2l+8cPaZS9UQ7j50JH8G4McryhnTljaxwHFp0qnTYTkEfTdl
 /HZA==
X-Gm-Message-State: AOJu0YwQt/bgsfXWq8Olb4tZ50sbU9XOZlltmUS92BTA0ZIUOkSjPfL5
 l2iEbtdj/FwSCWaoXX09WfgEzH2JiBtCaJlngWQKk7OT05/9KpBq3scYd4Rkxe+nWuZzuUxe+Dk
 Y7iSpjXo=
X-Gm-Gg: AY/fxX5kvSqBexW8VccUlAZAOny8SdoS29JXgQ1qmhByPY7uDS5lFnu1JisJbs6hq3Z
 7vdIivTQEelf5UdliLBw2Z34nM9Hr0vpqp44b0cjKq0dHZLemR0WgIn1pJrZWFJtU95HgrMzbxi
 buz6ckoeoMvPeiPZnIcefr2K3zoGNoiDRPSd8AicnMyPc9yuHM8xEpGYmNQQGstsXbbefQ/xZ7K
 od+Lm234PjON89A5YV4Yc0MztubQ2q/geJpLI7Nm1v3iCL94Sf43u4OFBvKb3tPd3OiM5NGU2Xg
 gdKY2q1WP67THoWuNDuulNIA/q+0BlM9I4IJdQx6URGljM3+nUIR2pqWVRHQFC3X/wo1J+E3Sqe
 kf+tLpmIcQiTdiWuTVxMBvxN8Jxqk0IaJZGTWSAab4a6PqGaJSCT0wGSAa0AQdAN/QBg1CuL32Z
 WbQA19nmqJBnUfvnxFFTUv0745XSRGcHjoge/BVxcEA6UWo8NZFlC6j/2hkTrZ
X-Google-Smtp-Source: AGHT+IFe1b6Dl2utcQILMrhWXdcYiJKAhy2tslkMNwEMEW+LHPLgSOKyIGpi87WtHPnt6piVLd6gUA==
X-Received: by 2002:a05:600c:1d04:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-47d84b3a06fmr237479385e9.27.1768258240649; 
 Mon, 12 Jan 2026 14:50:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653cd6sm393950135e9.9.2026.01.12.14.50.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:50:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/61] target/alpha: Introduce alpha_phys_addr_space_bits()
Date: Mon, 12 Jan 2026 23:48:10 +0100
Message-ID: <20260112224857.42068-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Anton Johansson <anjo@rev.ng>

In preparation for dropping TARGET_PHYS_ADDR_SPACE_BITS, add a
a runtime function to correctly represent the size of the physical
address space for EV4-6 based on the current CPU version.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20260112-phys_addr-v3-1-5f90fdb4015f@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/alpha/target_proc.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
index da437ee0e56..6b491ffa3a7 100644
--- a/linux-user/alpha/target_proc.h
+++ b/linux-user/alpha/target_proc.h
@@ -6,6 +6,27 @@
 #ifndef ALPHA_TARGET_PROC_H
 #define ALPHA_TARGET_PROC_H
 
+#include "qemu/osdep.h"
+#include "target/alpha/cpu.h"
+
+static uint8_t alpha_phys_addr_space_bits(CPUAlphaState *env)
+{
+    switch (env->implver) {
+    case IMPLVER_2106x:
+        /* EV4 */
+        return 34;
+    case IMPLVER_21164:
+        /* EV5 */
+        return 40;
+    case IMPLVER_21264:
+    case IMPLVER_21364:
+        /* EV6 and EV7*/
+        return 44;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 {
     int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
@@ -57,7 +78,7 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
             "L1 Dcache\t\t: n/a\n"
             "L2 cache\t\t: n/a\n"
             "L3 cache\t\t: n/a\n",
-            model, TARGET_PAGE_SIZE, TARGET_PHYS_ADDR_SPACE_BITS,
+            model, TARGET_PAGE_SIZE, alpha_phys_addr_space_bits(cpu_env),
             max_cpus, num_cpus, cpu_mask);
 
     return 0;
-- 
2.52.0


