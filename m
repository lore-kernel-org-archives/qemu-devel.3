Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D5AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7BBQ-0001Gk-HK; Wed, 15 May 2024 05:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7BBN-0000vi-6S
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:44:21 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7BBL-0002W0-3R
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:44:20 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5210684cee6so7748627e87.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766257; x=1716371057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IL2hAokqpmQr3sSx0rCsqvvhI5ki9eqOu02SaoXaEMQ=;
 b=WtiV8xHQPSrHAjxzzNI1ARs/tHqyEorPwAROEtYxzdkryV54HQgjEcJF6Oax7T2qsO
 gapB0DSN9DM4wV7ns0QHPu2GISpmHd5DkI7xXJO/041abYJfc/O97Dy6ZT4vH7oFd9NB
 QXmYA3JkqHrrsQNLff1Abx2JHvUqcUmSIcUzEEuYCfFkFJjxB2BJeZy2R11yI+gpFDGe
 2zmbUPTVQCDfo40OKACisQLL/8RngcFgVKSh4FO4Yr2A2CxI0ssU4d+lZcM2ddSBHAIN
 N60dKu3EgUnKLJsDz1LtknXQ20ZtnWQyHqfRnALK/GptlQDVBNVzQDL+LwYRJ23ahMcl
 5Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766257; x=1716371057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IL2hAokqpmQr3sSx0rCsqvvhI5ki9eqOu02SaoXaEMQ=;
 b=gbRPqBDDciWdnxU81/iM6CRyJ4hmZK7K8GblK+4YvmLXaN+4/8W2mF+N6ndzbZlwZO
 v/qdBYjT63mgbmd9zr+rkSsUL7Q2G4ZPTGOpJjR1nA/u75Aq1qoBabHul1IRFFk4rjbr
 RaRatfpxHnWgOzZ85LeJS6HIQzxKXfnchsgFdMK/Yqi0AzyzGGucTowix2o522sGfdxV
 HkXLSWP4QGXBrZDlzYxm/TQIybRPK/gzo31a5Aok5ZfI4L3lxr053R+gaevGiO7rQzRE
 NCRYF/gt5Gf8X4/zUAA4dR/UoJLlMqSSJHHJOrmkQaQGzmo91Db4IJ5ROu2OiN01u7+J
 eHTw==
X-Gm-Message-State: AOJu0YzIGTVpYHV6y/SPZdWwej2t5neyjaWQSo77NtGQapNUDLJdGrk8
 AvFRsIks+OtGUc/ALj+JzTJe0AePWG4umcGxljWhy/vuiI1mjJdFvRnVRueJAAX+d5NJSWD74pV
 Ihvk=
X-Google-Smtp-Source: AGHT+IHimFPxr7Bkua+qHxR+pjYGoB6BMafEwq2LuO0Ds9UxBKomq7HRoFiaYNqi8L3uC5de+ez0jw==
X-Received: by 2002:a19:770b:0:b0:51e:f8ae:db35 with SMTP id
 2adb3069b0e04-5220fe798b9mr9813528e87.43.1715766255434; 
 Wed, 15 May 2024 02:44:15 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbc334sm15926239f8f.103.2024.05.15.02.44.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:44:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/43] target/hppa: Log cpu state on return-from-interrupt
Date: Wed, 15 May 2024 11:40:43 +0200
Message-Id: <20240515094043.82850-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
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


