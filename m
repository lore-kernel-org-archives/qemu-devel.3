Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FB8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzFa-0006xO-Ty; Tue, 11 Mar 2025 09:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzE4-00057z-GP; Tue, 11 Mar 2025 09:00:54 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzE2-00009A-29; Tue, 11 Mar 2025 09:00:52 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso9046295a91.1; 
 Tue, 11 Mar 2025 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698047; x=1742302847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hQkVoYW8C4C1nZdyf/BtCP5nliX3X99Cb593+4du5g=;
 b=eDfIKjgbC3EK/TrN147pmQtrskKRtuJrbvpVJY7T4OJiVu5sXmoECtFWrxW6OS9o0K
 R5HeIHvuFgFc3e6jyiMH1nhvDRIIFrsCREBqwuf2t73uMJMp4/LWV86+K5KCfmErArkM
 RdTLnwVvmkdgHUCJhlwJrvRV7SP/4bySlC1wfe0ATLeN9nbB+zxEnpbXh0dGEgYyHqNv
 nL5s5bKwHysTXM4tYZwrWPmtpGi6N1tO5OUGAnm16UprscJGrevJ3V79DOORVz3yuabP
 s5GV4FqS0no4HCKJeb/s1Qi+dcIErZxt2lLCGhNGdOkhVbtyNs2Wph22CMbER4ru1HsC
 iBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698047; x=1742302847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9hQkVoYW8C4C1nZdyf/BtCP5nliX3X99Cb593+4du5g=;
 b=sdobTb9i3f/LW4SVUavfrjTCH+dXFH0MO0cuuGzu8XksHMNe29ZpAuVXry4WMqfvRK
 xnpD5DnykXu3Mdw5FCtAt7ziJ2Flo3oNEDR1C31ZL5HxVOB0n/QXpI5eTvGIL9xOtDzG
 xsnD7rvBWJ4NXQepQLcs3Mc4GAoiGS4lu8EswjVsXiBQn6sXa3FkSOdJWHdcvQ3dWO3v
 f31C7wITXsGjNvqyTibE/w4kcBz5vhzVicNW5srMcFT7GQPMQk0zUf+Fb3/vABXJ9gNy
 XqsEeJE/QRFHv6WMwHHLgAJgMeKopqLCSlE+73l/l63D4k+Pn5f8xrYk+wyaKY+dcjnJ
 kleQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhK2aCfRzv2756leJTmhuLM+8lI31RPsfEPwZa5hn4gtvgSHaywa/0uBFrf0nOw3SOH0jeuH5iDg==@nongnu.org
X-Gm-Message-State: AOJu0Yydugn3LwOqLuO1QglvVzcpOy3K479v8CleckwB0eEn1+XWYKFG
 +MswCm9uQ7HPWVgRJBt8h7zg7mMbd4wVjnXqVKW3tC8om9qV60qTSKRxzA==
X-Gm-Gg: ASbGnctuSpOmoWTpTIwttihpmRMF2rGR9JdQ7LdOuHU4V8lLxK9wT4TtHTSpAhAnBnP
 mVP3EKt0if0cpNw2Dmyb0yh86hfP2AZ74S92DXMGVJmIkDA9UtooGY9ZcOMwuUoBmqZlhdIxgzn
 S4Uat8WGnUWnqyRSgL0V9UjQoejRN2Pi0knceMMpScgdv8WonwGKvmEHIeRBIuifo2+Ij+KR4Xq
 caDmcRcZZMzS0DApW6rCgy4zgCDiNATV9jfEZxU/R6CQDdRnQukpwpv68VNjbcqzOG1SHYsVYjK
 oyi6qE/+BpwOABN3PO2SKTfFQlGm6MeUn1oqzDCOuXOgkvIxboo=
X-Google-Smtp-Source: AGHT+IEQ5vWLyxKrkPdFANZhmP0hlFYINaCgpY7ahdt7nD9w+s45rEgz72q1SOQAueIKMEHSrqgTeQ==
X-Received: by 2002:a17:90b:1f8c:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-301004f7fb3mr4645081a91.1.1741698047502; 
 Tue, 11 Mar 2025 06:00:47 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/72] target/ppc: Ensure powerpc_mcheck_checkstop() is only
 called under TCG
Date: Tue, 11 Mar 2025 22:57:40 +1000
Message-ID: <20250311125815.903177-47-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250127102620.39159-7-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 8956466db1..b08cd53688 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "system/tcg.h"
 #include "system/system.h"
 #include "system/runstate.h"
 #include "cpu.h"
@@ -30,7 +31,6 @@
 #include "trace.h"
 
 #ifdef CONFIG_TCG
-#include "system/tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #endif
@@ -443,13 +443,11 @@ void helper_attn(CPUPPCState *env)
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
     /* KVM guests always have MSR[ME] enabled */
-#ifdef CONFIG_TCG
     if (FIELD_EX64(env->msr, MSR, ME)) {
         return;
     }
-
+    assert(tcg_enabled());
     powerpc_checkstop(env, "machine check with MSR[ME]=0");
-#endif
 }
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
-- 
2.47.1


