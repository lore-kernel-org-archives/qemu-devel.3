Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC66CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNk8-0000P9-8y; Sat, 30 Aug 2025 11:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wk-0002iL-8v
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wf-0002eU-7O
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:58 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-771f69fd6feso2995891b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506291; x=1757111091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxZ+p1n6Rw5X7moye/vqyXYYqTaMcwsPO8BMV0hGGOA=;
 b=qhCJQP0k0dAWwojEuU8kftght1QUt0UViM3iwY3okKH9XqLHKRY2TC1SBu+6PLr+C3
 dv4z4/u320uTPydknyJg+ezo+NmOJS46X1ulB4KhjMpucHhYGwtlDqfSrwA0l/TX/mXH
 aREsMRV0p4Miy4MkXRLsQ2SGlTZglauJKSqvPbpg9CssvgA7W186zv+qMMbyPuPEJlTp
 LmFUR2xDXGYhcfTG2z0eG5kP2+a9kemNeLFdkPSjcKD8N+Uuw411mHVoSAqJ1GL1fZr5
 TQWBwBSG5nyKa51l6pQU054pN+qt+yM5S9w3J4UwjYcO5Xl6CerWqnoceFMCh0b+NqGu
 7KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506291; x=1757111091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxZ+p1n6Rw5X7moye/vqyXYYqTaMcwsPO8BMV0hGGOA=;
 b=iHkdPQzxR1IdM8aJgO+yNYrsSStj/PQRTtZDGEuj1qn2C32FVbGpXGXqFNzYfvhMUl
 5KkHYCtjk0zDoP4B+Amut5LkX1JsMGKv5rvorSHoNuGMerqhAJGtt5V0pZfB5IkfBHRR
 Nr2W0Q693N/IZCEiG413rW0gcqfE54PufdE8tSL4oeya0gXXPCeFU2oQiKyLcZsa+i8i
 SrzciCw8oZlntzW3/LXZIeq1xf3pv97IPelghlnyWS9lDnQgDTT8jCd2bviA7bkfLcCC
 Zcor26Ldw+r1AREfUAwFF54GMmBaf2DeJv+4QsusQTu/u1OgO6MTbrlc1imIuh7vd11y
 c2sQ==
X-Gm-Message-State: AOJu0YxtKA+rCxaSCtS0Ft36J3yTuWg0HypicOOSZEFApcU4m+0ithZV
 poDyWGGVnUWapcQ60+5lrSEtLyUbbQnkUBnHyzDvS1QM27iq4LBtP3WSPJ45p57A2Q4R+e8zLr4
 B3dXYmPM=
X-Gm-Gg: ASbGncsSn7Si6YTu47PjsFmb+gh2uZrexhITU+WeimYDriixtqjOjEo4L81ZYxIHL6R
 ZqNcdhIMCQkj62bRfKKv99DT2/9nns4THGKNqfj+Vq3OF/EfpaLxC6s7NQrIxkv89AZQCl6Ul6D
 SU3L/46muWMyrz2WklHPt/1fV0PvzWSIVpFIfM2fm75yEllPsROdhmVWN07IevvQC4wtFZnBi2d
 uZELmlIKhKQ/0bJcs3ff48sg1zyOJ1vJ1e1hduGqpMR6M+dKdkIrjLQdaW0xVdkiF5bCnorIcb+
 nh6il1G5Z3sLOqewh/gxHnCzIfqt+yia5JrtzPTvNzvGrIKBw9JWCSAyiVFCHTFB0IqGKaxupez
 fHaByFrQFZC9KHVeEgB8kS8XHrTas7WWflfllwRhpiguilmKUbMOy0olWDipd
X-Google-Smtp-Source: AGHT+IGELuHe97Bqxa0ioERaVP2DO/OrOciPib6Xuohe85rFEcZC9TwtEvIe/ZXpF3u6IJQZomx1DA==
X-Received: by 2002:a05:6a00:3d4d:b0:76b:e868:eedd with SMTP id
 d2e1a72fcca58-7723e3c3156mr356275b3a.24.1756506291275; 
 Fri, 29 Aug 2025 15:24:51 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/91] linux-user/arm: Convert target_elf_gregset_t to a struct
Date: Sat, 30 Aug 2025 08:23:03 +1000
Message-ID: <20250829222427.289668-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

While we're at it, loop over the general registers
rather than open-code them.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e8a7f040ed..0180f6063f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -296,29 +296,17 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 #define EXSTACK_DEFAULT true
 
 #define ELF_NREG    18
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUARMState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
-    (*regs)[0] = tswapreg(env->regs[0]);
-    (*regs)[1] = tswapreg(env->regs[1]);
-    (*regs)[2] = tswapreg(env->regs[2]);
-    (*regs)[3] = tswapreg(env->regs[3]);
-    (*regs)[4] = tswapreg(env->regs[4]);
-    (*regs)[5] = tswapreg(env->regs[5]);
-    (*regs)[6] = tswapreg(env->regs[6]);
-    (*regs)[7] = tswapreg(env->regs[7]);
-    (*regs)[8] = tswapreg(env->regs[8]);
-    (*regs)[9] = tswapreg(env->regs[9]);
-    (*regs)[10] = tswapreg(env->regs[10]);
-    (*regs)[11] = tswapreg(env->regs[11]);
-    (*regs)[12] = tswapreg(env->regs[12]);
-    (*regs)[13] = tswapreg(env->regs[13]);
-    (*regs)[14] = tswapreg(env->regs[14]);
-    (*regs)[15] = tswapreg(env->regs[15]);
-
-    (*regs)[16] = tswapreg(cpsr_read((CPUARMState *)env));
-    (*regs)[17] = tswapreg(env->regs[0]); /* XXX */
+    for (int i = 0; i < 16; ++i) {
+        r->regs[i] = tswapreg(env->regs[i]);
+    }
+    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
+    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


