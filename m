Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684D1C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRzF-0007UT-Jo; Thu, 27 Aug 2026 00:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRzC-0007OV-CX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:45:10 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRz9-0005ss-Ka
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:45:09 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-848743155bcso863804b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787805905; x=1788410705; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EiqvocLshCKaSrDdaVvWYd0DxB5KbnFOEtyhshD2Cog=;
 b=Pq0uVy1TzJ8fi8I/hwe/sVrTmmmxSRILV7kg3olkWr+GJVOun37p4KRonynBicn1im
 Tf37azq4c5wG3y6fEjbSfnO7JzH1XyioAr0c7FihHtkUQPCBbfkamapQP1njpHWTqJdU
 tkEMERxGnG6If2p5XU7lizbG2xe8OmKrAT/B33xu2g/yO9lsFrKy/cllx7NDCcZ1WELk
 bKygl7Us3N4T3jTx16V/YSC9FwZZwM02Ga3NY5SerqzAv+wrhamAZTWEE5gI9lRlyhJT
 yLhn791Yzcn6n9BJ75nWHgH+NsBJgn/eszCpePTCoOkXDb5TCxBqRFMx0QRbyXmQhOKE
 Rnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787805905; x=1788410705;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EiqvocLshCKaSrDdaVvWYd0DxB5KbnFOEtyhshD2Cog=;
 b=rxJ2DXPuibLzXf7VY3rGZXMH6DwfCJYFfVa/ZuFP+5v9yCWY5+EChGlhDVlTlGaWZR
 gMk9goNZZQtVhmZhm/kESAtK/A2pB5KrVLltwg7dloFIykyUsaZ/v59DMP00brlgEKaW
 pCDobF5eiyuRrqjbuP+LQE9tR2eUg1i1Zb8uraMKqn5dh2LK8XVvBBVS/L6J60Ovg48I
 FPEwNIPWXVfZSIaa691WphYbXz9kPd+C+MSw2VV3dBRjUAn9BlKGNX7NNEfGjIkHXSTv
 LLOf2AycgoyOBOjvjb2LO7xX/Oz74auioG7bmi0d+ScsecdsjAU3mms0PK7n7/iepHkv
 ysrg==
X-Gm-Message-State: AFuF++ma8n5U0ZwSCkagJEUhigVppteD5fpC9OsL+Lyn+COxiFs+4p6j
 FxE8LwG5AHzIZFa4VYF9QLIIZiJIk+v2vBibyJVDG0WzdqW5RC2ApRZiebDLMPd3YYHia6KUdNh
 9p8l9Jv8=
X-Gm-Gg: AR+sD13ATSzhIRL4uxFIr3pwrOXGJ62dVSbsvcsqYsQo4GWGPxbHNlGS1wyuIIpSHKB
 OKZ4KPb7kaNitEjMncDWBpTVasilSieIomsJ9mXAWve1rvjeQ3RFo4uM6MDCXq2aF49SyTguXbg
 K7eLQTsZB7WvKPGo6ZFUD1tllz37jzUdynM+Q8FYuJI+kpj5KAmtM7291tN2FQ5pCV5ctdCqCxP
 Pn5uTWmLsjTDh1CXwzr99vy4D2tP/ccEHsDElsyPiydEhUxh2qLk/3nFo210Ag02atV2gfliYth
 nd25sjm6Gt/8sWwMmBKSLY1wr9cA5EdIOfTmAtUXxKS8EhfVEQoEpYEFMdAKbN01d5GjvTwfRZm
 EA6melS0WKFf3i0V5025iLdVFdm2hlryPG6INQ3FSYVtSat0R6eZBvwOhdmMGEOHnJWpB2vMvrJ
 lQNvTuQd0rXW1Ocm7ikrB8uizIYelON/uyFauHFr9FivjPsdDuhY8V9rLvsJCdbx6H41LpaV5Hq
 l+rfVHxZqGeJqlhZw==
X-Received: by 2002:a05:6a00:8d86:b0:848:2eac:bfb2 with SMTP id
 d2e1a72fcca58-853748a0551mr24793842b3a.13.1787805905297; 
 Wed, 26 Aug 2026 21:45:05 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm1606003b3a.44.2026.08.26.21.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 21:45:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PULL 2/4] disas: Replace straggling CS_ARCH_SYSZ
Date: Wed, 26 Aug 2026 21:45:00 -0700
Message-ID: <20260827044502.778915-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827044502.778915-1-richard.henderson@linaro.org>
References: <20260827044502.778915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Eric Farman <farman@linux.ibm.com>

When updating to capstone v6, the define CS_ARCH_SYSZ was replaced
with CS_ARCH_SYSTEMZ, except here. On systems without capstone-devel
installed, this causes a compile error:

  ../disas/disas-host.c: In function ‘initialize_debug_host’:
  ../disas/disas-host.c:78:24: error: ‘CS_ARCH_SYSZ’ undeclared (first use in this function); did you mean ‘CS_ARCH_SH’?
     78 |     s->info.cap_arch = CS_ARCH_SYSZ;
        |                        ^~~~~~~~~~~~
        |                        CS_ARCH_SH
  ../disas/disas-host.c:78:24: note: each undeclared identifier is reported only once for each function it appears in

Rather than making capstone required, replace the constant
with the same one used elsewhere after that change.

Fixes: c8220a096f ("target/s390x: Update capstone disassembly to v6")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260824143033.306201-1-farman@linux.ibm.com>
---
 disas/disas-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/disas-host.c b/disas/disas-host.c
index d41235250a0..799f5e86c40 100644
--- a/disas/disas-host.c
+++ b/disas/disas-host.c
@@ -75,7 +75,7 @@ static void initialize_debug_host(CPUDebug *s)
 #elif defined(__m68k__)
     s->info.print_insn = print_insn_m68k;
 #elif defined(__s390x__)
-    s->info.cap_arch = CS_ARCH_SYSZ;
+    s->info.cap_arch = CS_ARCH_SYSTEMZ;
     s->info.cap_insn_unit = 2;
     s->info.cap_insn_split = 6;
 #elif defined(__hppa__)
-- 
2.53.0


