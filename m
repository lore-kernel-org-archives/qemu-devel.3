Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E781C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Cy-0006TU-Cs; Thu, 23 Jan 2025 16:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5CS-0005Gb-VS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:21 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5CR-0002to-AQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436249df846so9783575e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669437; x=1738274237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Im7eIVxJk5Ymo2cFyecUnjgdjN1o5ulRwaFN1Y9Xi8s=;
 b=H0hUp4rHxW7HwzkRSha5KxflKZ6IlDcGNXY4/PVJ4Ob6VFyrhX3qAvTA18Dpmf1Gm6
 OW+seXtkFNn5oqPCVHDxIu3m3ENYJ3AYLcoT9fvknh4ZaOc1xi9BtmobP+bkG4ByQcZR
 WfZvcgEJBilOLivQN//oe8uTQWxTam7GsIQG0UwF6azzPWpj9oG59ge58E3KAEPD1u4l
 IYW2KgyfdHfCSuObKzH6xmW8Pc0h+JPo2u8lTf2IbaO89ieGttVfDl+kxJd4BnajswEb
 14K+aOfZc5sqpiggpLM+5M6ef/17RmplWHBTNt0Cvob/YpatV4DWa9PFI7UL55hFcsd4
 qKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669437; x=1738274237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Im7eIVxJk5Ymo2cFyecUnjgdjN1o5ulRwaFN1Y9Xi8s=;
 b=E4bO7Da8DndpSPmcCgO5VYuNyGH7Fb9izhxg0hGQlATEpRPC77a581wj/ijP/WUKFT
 EGBwmPtwqfLZumdU1mb9bn24slT21i81oYOPDp8TfZlXA+9UI+CEHDeaF1jJ779mle3X
 2ELf3mA30GNx+UOwddpTsA2LnqdwS1OnBmLYNy5IXV0OoIm1VLAhTAVjGbrsdWP8Epnz
 hC50VAeQzp+U1TNgPm4UI6fpqtWs1A0gVYiPkUn9gCGvRAHEtgSEkRB6lC0SUFJvJ+X1
 CcGPKV4TnmcTIlbAk/H6HohjSlWQdvhYFwm3ibost0zr6ji9hICNO55JX+KpUU/Lp5jQ
 KPaw==
X-Gm-Message-State: AOJu0Ywz8Kw7Butk2h7iZQ0Y3Xxbv7SDy//CTDThbmjEt50S+IkW6z0M
 dmfFHZd/gQ8LIdWHLpfcHbQmFE2w82ensjNtnhYz9y/LlH8Lk+6iXCSdEpGFMtdcgv2Z54SJ53+
 YQ3c=
X-Gm-Gg: ASbGncs0+TAE/xKf5k41YFdjL24kL1WCFbQXwRsoA8mZPD283j3mrZ7Dx9OT3ACKjGO
 PGJilIkpUnL1PV8UjwsJixNekAAEJggQaJq6sZIzuoPlnKWFafYat9AcnQn0mw93v6jcft3NsN3
 xpYuAqFAzWg5MAQ3J97en6ibk/yWGN1fOCnwG95sSVi+nMyXkme7cSOvGFCFp0QnduWWF5nQkxt
 f0R2BDBJWrWOl2dSx/Omj5RpZHyMORLA8+0+7kPP3XJ8aK/2AF8uTvqOujn/vIAOwxvxg5JFxyP
 kEplH1r1JbPnLGy1xRkcVjf7JQSLbSoNxBpULjISRmWm0I3Y+p7Ork8=
X-Google-Smtp-Source: AGHT+IFyVa6qxjwK3Qr2ejEKumGM5h3Tg4rQ496BYHUuBcUz7hVIR19xcV0U3V4aHJOkpA2QhuRjog==
X-Received: by 2002:a05:600c:450d:b0:436:840b:261c with SMTP id
 5b1f17b1804b1-438914340afmr234916505e9.19.1737669436711; 
 Thu, 23 Jan 2025 13:57:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f367sm5061595e9.7.2025.01.23.13.57.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:57:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/15] target/ppc: Make powerpc_excp() prototype public
Date: Thu, 23 Jan 2025 22:56:07 +0100
Message-ID: <20250123215609.30432-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

In order to move TCG specific code dependent on powerpc_excp()
in the next commit, expose its prototype in "internal.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h    | 1 +
 target/ppc/excp_helper.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 3f9dc6f514e..779305f09d1 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -291,6 +291,7 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
+void powerpc_excp(PowerPCCPU *cpu, int excp);
 bool is_prefix_insn_excp(CPUPPCState *env, int excp);
 void ppc_tcg_hv_emu(CPUPPCState *env, target_ulong *new_msr,
                     int *srr0, int *srr1);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 661d9650d9f..f0e734e1412 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1494,7 +1494,7 @@ static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 }
 #endif /* TARGET_PPC64 */
 
-static void powerpc_excp(PowerPCCPU *cpu, int excp)
+void powerpc_excp(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
 
-- 
2.47.1


