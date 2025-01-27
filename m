Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFBCC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMLe-0002yC-O2; Mon, 27 Jan 2025 05:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcML1-0002HN-Fz
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKz-00023f-SY
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:27 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so49012195e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973644; x=1738578444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzpnpQZgTCpT2g1dzq5DHmJ6x3mOiCDX9Ya9+aFts1Y=;
 b=bidTfYXrpnkDEp0krrJDRLdwd0DZB/wMmRmWkH/yMCe8Udy7JGST2xpcjuKXMABp5G
 yjBJKYULM+74zJ+JyJP/HIZLFpdjNTFm8wJTF3eXvxd7ug4b6XI1K3mvoYsNTD/GuS3m
 4XqYoIK4dFpcrjcg5jGa7mmsosi9weuLZO6ctlLA1gbhPN+CGwMcko9VLNOm25bo2/oS
 eWGUWBPXRl45tHVQvfo+Z2pzv+lJZhyAD/EkjlIQRXGRUh+dNVUtjb0+ppjnuKd8hZOg
 tTMaJlKr4w8qgY5Uw1iX5yIWA+9OSjwWldqtwrKCAGYUO8jIE3xnj0jxRgY9y8zSueY0
 xiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973644; x=1738578444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzpnpQZgTCpT2g1dzq5DHmJ6x3mOiCDX9Ya9+aFts1Y=;
 b=dsjkUULqnUUd7W3BQCmgcthTjGcVHR4F5ZTI5QwSv6aNrerSk1oHbhD//++XO0abl1
 +/JD/5myDX8oUBeXQZcKSycqHi93pj93tVCyiCmVGuU6EZBfY5ZWS5cBLCCq1admBv8F
 s3fVmU3fAwn8ReJHBo99J2IEd3yThats3YNOSQDFcQKDl1RBunUgK+Lu4FNOecBAV/aZ
 SXGwiJNefC/z/vs/PXEVKFjPmyjrkTVXZdgAKzQYYK8dqjPo6J8zUZDaLMwtaA8AEQhA
 HkEQMPr58QpoJDqYw9cZpeE0gPz9xqjLIfzqUBJ2K7h4nbfyLSoKC1aXAphhm8JpoiPo
 YScw==
X-Gm-Message-State: AOJu0YywNijVqoryHFltzhnyivDfFM564AJyQnHV1ZBHjiVxZakP6TPy
 1ZaKLSuxntDoaOksD0bgSvyNsldbmtMaTJT2I5im8uvNFJupUorz9thc/HB0oPGVcGalhfMp5Qs
 /wi8=
X-Gm-Gg: ASbGncvsxEcERntYsSYraOGcuQJIaKCe8pqXrD/22b4KTMHk6aNXJFBtCIjN1le2pzL
 ScJL6JSVl2YPwMh8pD5MfUWRVXIxj9At7BPVp3l4NxEeubntkcYVBq5SuWX6ht9d1M59mZAYOSr
 2K++7du3Rz3EEwBi0fdq4hqgVF78U0LokKWElEXZkDefKY/732ZJgUD9R3n2PmRMoYmc8VfUYgs
 nzmHGdpVusF4n7WQ35YTuQphTpGdKsnuob1+KuvbrsjTnLAyNg3jfMFh5i35rT1UjjYqODCuAun
 BY3OUZVGbSR0E0p/jO3TF2AOy3BRhkanV7G4gNPklWhBNEOjNxzCNCM=
X-Google-Smtp-Source: AGHT+IEU0hjlRT8rqny+nncUcro2MpvqsbdJa4VexVaflsK6C3h0Ex3stm0HsInc19bT1JtiXm6o6g==
X-Received: by 2002:a05:600c:3b02:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-4389143ba53mr390629435e9.30.1737973643869; 
 Mon, 27 Jan 2025 02:27:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507e0csm124511525e9.20.2025.01.27.02.27.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:27:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/15] target/ppc: Make powerpc_excp() prototype public
Date: Mon, 27 Jan 2025 11:26:17 +0100
Message-ID: <20250127102620.39159-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 0e66b29ec68..b8997ba31db 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -291,6 +291,7 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
+void powerpc_excp(PowerPCCPU *cpu, int excp);
 
 #if defined(TARGET_PPC64)
 bool is_prefix_insn_excp(CPUPPCState *env, int excp);
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


