Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F8FD24455
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz13t-0007XM-Ec; Thu, 10 Oct 2024 17:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13j-0007Nt-6N
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13g-0004fA-Dg
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:50:58 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c56b816faso13723975ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597051; x=1729201851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/eEZSTQpqPfWDWhUcjUtkLny/Dd9OUObCuW9KXLFI8=;
 b=br9n6WMsLMrU7+oW01NcgOPs24xavYBIzuHxErplGv4Dd2QKL00f+ed4uI6aj6VLRL
 yvu6uGBiw3/cTF40uBXsL7tkeW3PMvzKx2Ah2vNg2jDVXYqHnzgkA1MNarnWw9XGKbe7
 MDM6peznIU9I2utGhI6Zs5CLxF3fZIn3JIrxZKnneMIHponMw+9JspUpGIs39oRNy1VK
 hEVJSmxiTzEf0MAKHzirjeQQVuvjtHkFinW576SWl4JZBp6Cyt3OnifGyz7DfIAb5qQA
 6Zut+9CA9TqGcJu54bW0VSJlybE1Q3td9w3QcB5Q8jUURdlwzQiaIlH/5vL1rck1NJ+4
 es1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597051; x=1729201851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/eEZSTQpqPfWDWhUcjUtkLny/Dd9OUObCuW9KXLFI8=;
 b=twXVgttXiYSDTrCSDUcVrY/NmTl45eZHB/SO4zXLkA0kA55TVCjujAlIBqUn0DjR2G
 Ebe4syMFvCFJ4NoJk9t6UCRjB3GKeFnMskOYOTN0jsMCdtGqqwfPCFNIEH00B1Z2H0vS
 TOUQ+y0XfZ95kUDyn8tCw53C/LTqyTJD7SSM0GeOhLBxOqujpGaxdUHpLY2KTiWMKqVv
 mM4LfeA/nrQt79wLRzLKcZsiAmLxe5AzbiTJ9AKX4RsDY4pcwiPV7LU39rIu+cUIanIl
 Wwa0aO5wlgRcdoMuMBUMQkSDXGPL18tbKHVeN2+PtCuRMvUhHKpJZLvsQY6TzEM2kIh5
 hRUg==
X-Gm-Message-State: AOJu0YxLBnfzNwCl73X9+20bYxt38S9/G4hBHriGVQPO9vzV8XMig5PU
 yeqTD+JKjuyQLCMAOpvBKNpDIzmQf66+m73azSSbDtvE6s49wFauuBH+Nq649wmsgQ+Dci9w2EE
 n
X-Google-Smtp-Source: AGHT+IFOrjRSzt5g9GCOZU/lFWpJZ0gBZ/5amXdYzd649oGkGX4kdcftaxz5qBKqpFBAS3xnR/lc3Q==
X-Received: by 2002:a17:902:d490:b0:20b:a9f3:7996 with SMTP id
 d9443c01a7336-20ca16b6a37mr4695565ad.51.1728597051601; 
 Thu, 10 Oct 2024 14:50:51 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c348a05sm13714415ad.282.2024.10.10.14.50.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:50:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 04/16] target/mips: Replace MO_TE by mo_endian_env() in
 get_pte()
Date: Thu, 10 Oct 2024 18:50:02 -0300
Message-ID: <20241010215015.44326-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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


