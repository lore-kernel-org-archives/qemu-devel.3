Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2911ED1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlY-0004rw-SD; Tue, 15 Oct 2024 11:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlP-0004NI-NG
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlN-0000zA-GJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:10 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20b5affde14so34058195ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007228; x=1729612028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBs9jz8Noj8v7jUvWI495axiHObd3uNNAVFIb2VRWYI=;
 b=RvgUw0khACxFqevrOmcgS92Q3GisCIGyNCFztVIVCbC6JXPywse74i90a184T4Aqsu
 cy3P1QrzroEXZ9M1GfJ2+ZFE9WrarZDaXJ0VSg43g0mxdozGbVyvWeqiPkRYm50nw2ZZ
 rgTzo8N2nCcTCbjo1dOmrqXq+C2H6AUx79lCNSgqR+3YxtjdYOr8ivV6yRu8PWTkWz1A
 K0fpCI71HOwaAQPzcVjLVHAqRkI5Q7Hatxx2NZ5aD3k2x2vih0lK8ozL1XO/ahaaGVv/
 d+SLxjzxUKx6JdFnlUjqF26RmpBl99r5cUOXlv/wmovzscd0oT7bIXmGTZ3f+XE9CxZ3
 fbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007228; x=1729612028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBs9jz8Noj8v7jUvWI495axiHObd3uNNAVFIb2VRWYI=;
 b=j9wQ+ezh9YqXX1ewJaRrNiIBSojzglRgc0Y7AgMQ6vc7sPdhdUtcg+8fTZGtOt7n9M
 7uPd3207DvcoZF4HwnUxwzsZDb7ndmG2a/s9EvmG6XkPw87IZlWB9EDGyOO29/Dtvbo7
 GnFqoXgi8UEkQ0ht1LNoe5xvVc9WoscBijqwPV0/nAKVz+nMud20bHmcNtBIZOLhjuAK
 rzeQ14IZzy2rwKn9yWE+NZvJrYb/1C66A+km6bIZ9F+vLFrA3YwDhEOe8k9HHEDwxOG8
 r4HzejFeH+bcvT3lB2vXoch83yinc8iyiClqhP10JE6yhmZOVtSeZRTmcHzsdptWAgyb
 gpRQ==
X-Gm-Message-State: AOJu0Yy+eSCt+6FP4KE/aP1undH/1hV9TJc9gLP0Ki1FkAYu5vqGKy+X
 +pT+OcwIQNTc56nAyZCSlThN87JVPv01m8rw1iKjdlxJHxHzWBErNwwFPsyFExbspBppeJP/o4W
 U
X-Google-Smtp-Source: AGHT+IHmThAZj0IkdllI/xICeINoeZBTbsKb8AIDkdZH3gRjB7r6uM4yUSYNsovzIm1VWs0S2pQVUw==
X-Received: by 2002:a17:902:e752:b0:20c:f39e:4c15 with SMTP id
 d9443c01a7336-20d27ec931dmr9553815ad.22.1729007227996; 
 Tue, 15 Oct 2024 08:47:07 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b67dsm13523355ad.195.2024.10.15.08.47.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:47:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/33] target/mips: Replace MO_TE by mo_endian_env() in
 get_pte()
Date: Tue, 15 Oct 2024 12:44:29 -0300
Message-ID: <20241015154443.71763-21-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace compile-time MO_TE evaluation by runtime mo_endian_env()
one, which expand target endianness from vCPU env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-5-philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 3836137750e..e98bb959517 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -601,7 +601,7 @@ static bool get_pte(CPUMIPSState *env, uint64_t vaddr, MemOp op,
         return false;
     }
 
-    oi = make_memop_idx(op | MO_TE, ptw_mmu_idx);
+    oi = make_memop_idx(op | mo_endian_env(env), ptw_mmu_idx);
     if (op == MO_64) {
         *pte = cpu_ldq_mmu(env, vaddr, oi, 0);
     } else {
-- 
2.45.2


