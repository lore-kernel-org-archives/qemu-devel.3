Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71273C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwLv-0005Np-NI; Sun, 27 Jul 2025 04:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLY-0004mM-MC
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:04 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLW-00040m-Ts
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2363616a1a6so27448365ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603381; x=1754208181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbpMjeNAOgpQVH9iBoeuKkwL+dC1QrhKT8NKphlDlP4=;
 b=GJJmfbdxILLlEF2zVNIvKamnfckpXwwB4shyKFpDertlV7rst3835X/mZzDWNjUbRA
 fDvd0ZMGY1ePlaRIxLRg/8JfvusDVRBH+aZBaosAvoEz1KcQM9/pSIwZm2yxC1bwtOcR
 6gBEceKK+vxUtYvnBfeFdxyatYJDeZMKVVcyx3R+eRxFjd5F2qFrcuUGBJsIt6sqrdxY
 6wv97MEWwsSamFOTkjKw+D9/FRP7vWSFgXXLuEIvlkwg7TSzKFPTH4tk7fd07zTXHcG4
 D2zrOoGPZ1Ne9SXHlh9xHw5Va4J/lWzHWza1ufYIm0dYLmsGFbw943sct80kdK5sp/D4
 9Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603381; x=1754208181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbpMjeNAOgpQVH9iBoeuKkwL+dC1QrhKT8NKphlDlP4=;
 b=DtDTfM58563IhgZrgKmLMxG3Fb8tqsx1w+pus52Ksyh8HUo2bfBRmN2xsoiTxuP5+s
 9nZ2jJAMU7/65H+4U9G6h6LdWpi5xpx/y9X6MtpG54Tfp9BTTSLSlhNszSLZK1I73KUa
 l+atIOAXJ9LF9AS+3Sbd25JASswdULDNmiHMER2jWSDBY0ntrwXsvVcA9OHygQ3aENla
 LUuvFRPBSRyYPubXQhlpwlnTN05OTQkg0WysmgVXHlgqAGOWxL/dHvkYQcbMQ0TYRVVB
 0tozKh4Y7IbRSJvCxEkZtWkUyJf4EYNPW4kiaHwasZlEoI6CM/wF/MirMHRP0F6dpvZ2
 wsig==
X-Gm-Message-State: AOJu0YxHJvXWwebJjT76StBZmNRhCI0SKwMuK8nR+bFgbyGmfIkB2AfR
 aWLObfgpFpSLJGwz+p9zTq1g0rdJCtjzh9YnRERWou/8UPJUpyARbzvE5la/nZMIGAzIWqZUkF2
 BhR0N
X-Gm-Gg: ASbGncs2Yr7W64osa30OK22yImEOOeRMXv90cF0oEnMuhir1/35OiS8tPNc/CGjRCgY
 oxscaqbnxWr/wOWEhGcK3pvlWeTRx3pS28F9ZcRBWee3c3rg+IwNgJ+B+QYezG2DgS17V8/tbif
 HPfsmSx2Ist5WJ0FUBqHh5Z0vONzeOyydYiMvcA/y6i6KQB3Co2khTjpaeM4FHjk5RtlinsEehU
 8QytqLDDp+BDX2VPA83XpeOgNRuGTP01mS82uslya6POkhMpag7XUTtKZ/g/KY82xrOGxy0DZzz
 KmsWTfsked777jaeq9xCf2M77fN37oI4ef74beP21kelZKqw+aBnAlfjPCHptT6WZMTVyzqQVJN
 4frARJPeA9y9AwoL9eWL6QzR0KRA0pTA707n7peARlcGDwjIxdcCP9MKS2agkPReRexkmsRja0q
 /PlYhHh2Lkdw==
X-Google-Smtp-Source: AGHT+IHy12h5qkeycTEEJLcoisd4bZvo7IHvdtEy7VEqPK40yZPem+FDlhXPWwrKV/krk2O51UMOZA==
X-Received: by 2002:a17:902:d503:b0:234:d679:72f7 with SMTP id
 d9443c01a7336-23fb30998c2mr111630205ad.23.1753603381522; 
 Sun, 27 Jul 2025 01:03:01 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/82] target/arm: Skip permission check from
 arm_cpu_get_phys_page_attrs_debug
Date: Sat, 26 Jul 2025 22:01:35 -1000
Message-ID: <20250727080254.83840-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Do not require read permission when translating addresses
for debugging purposes.

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


