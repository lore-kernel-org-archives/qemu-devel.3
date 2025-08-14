Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC254CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXQ-0001Ml-8X; Thu, 14 Aug 2025 08:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXL-0001Kw-Ps
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:33 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXF-0004BM-FP
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:31 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-321cf75482fso1869299a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176301; x=1755781101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMQri4iirPxW00R1ccJFExnMIuYM+qTTYK6RBx2pETs=;
 b=kScnhijMkh4fK2TAPt87EurG5Y/CEYpuG1KGasSqvmKgIcu8LnkzIkQRCZWGnyKERg
 rTcre6mD2BoALSiUVZxmXxNEdWOhVgn8iB9FwyQm6eb/2dpOgeK+IokUwen/qozZeSKb
 2nNYGK4DTtMdNiPteMAvIpA/Z4P1EP40YdEACoEvXPvUyIxBBvgJ5zWj4sgPgCNLEbWw
 59bREfJGZeUwlhgN7nDKBnX6tD6OpldOAvgVZTy72z262zYIN23kg2ATyp2h6LvsptQi
 FIjrA4DUeg1GZkVCe50PCx/hIZXVJPuqP28CBUfHJWLYKVTSRs5+/PrXAOJb9iVUzZgm
 kQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176301; x=1755781101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kMQri4iirPxW00R1ccJFExnMIuYM+qTTYK6RBx2pETs=;
 b=QR7nqWnU78PFGsKz0I9aDExeX0gh40nLV0ygZNORIC51A4SuvAGgAIqaqwlbB+oyDa
 egUg+jFMK3VN/i4r68XbnCcsjHNDUNocAuIeEntn0XktmPI0n9jiTY2Aw0INFVzfztz+
 y9EHYKTG5fHzmuld6LYLNg3zinEP+Oy8K3V/aLscMlC2Yk7YTj67GGoyA2C4/nkrRyw8
 zD0W8iBpmpQkVBCi/JAQyetz+dcXx3DlFPTPbnvrjzusjAv4yTQRYr/LaRGroEgLzF0y
 +lgfhkFHG86e82wbvFA8l/Hr3+fEFOzMZrbCFgt+WWJGfz8/IO4kzKEFhNg6Nh9q3Wss
 TX0A==
X-Gm-Message-State: AOJu0YxPNQMKwRq1R9ce22TxveO2Czmbv2lV0ptagS8yW2RCPDuTl9ZX
 oJOOPBrETGxNE074p7CUyBhjGFy9hGPYevp7vHs6Fvhaci53n5DncoPOyP8/g1XfkS0hpr3xXVi
 /em8tE3s=
X-Gm-Gg: ASbGncvtutXBROVsfH+Lo9tw38NdI1+JplQZKZhXPPvCh4M3ixCyly/0GmoS5wrIAMK
 rnzbas9hN80M2xke+i9qodk1BMXxRyxF8yKrdDkdttblXsNfSwiWLVoGfndU6+UMU5Le5J1TK/T
 EIIry3A5v+Koo8xppQb7Has2o3Z3WaLoQwTPX9RsibZi1UjIfQSDt46QzRgfG8N1Zw01vI7MmB1
 IrkSvNl2QKlZZRvSF4pBV8FSDU6qYLaSHz1zV3wr5uat58tgCs2Nu18dHHlUa6+7XfCXkFJk8w3
 ldsYf4jy2VwepZ7h+I7R2fio9yedlDPzui9KtAZSf49x8p2QiPWju+WiMCf9y8PtTON1dMY0M6y
 zxNu4NRKAxVd1JjFVs1h1YX3m700NuONImZG5Cc46M5tqLRc=
X-Google-Smtp-Source: AGHT+IFZ5p52PRXa1B5zoo+oD3zwqhlKplNSRUKode8dH/AgWf95c1aSo4HrroWTDanby1M1KeMciQ==
X-Received: by 2002:a17:90b:17cb:b0:31e:a8c4:c188 with SMTP id
 98e67ed59e1d1-32329ae5446mr3782241a91.14.1755176300530; 
 Thu, 14 Aug 2025 05:58:20 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 06/85] target/arm: Skip permission check from
 arm_cpu_get_phys_page_attrs_debug
Date: Thu, 14 Aug 2025 22:56:33 +1000
Message-ID: <20250814125752.164107-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Do not require read permission when translating addresses
for debugging purposes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1b90e33f52..c7db93b95c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3646,7 +3646,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
-        .in_prot_check = PAGE_READ,
+        .in_prot_check = 0,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-- 
2.43.0


