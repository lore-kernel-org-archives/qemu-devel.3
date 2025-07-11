Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DD0C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 22:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaMb4-000156-K2; Fri, 11 Jul 2025 18:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYa-0007Pb-Hr
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:40 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYX-0008Oc-2J
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:27 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40b99490728so1716966b6e.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752274162; x=1752878962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbpMjeNAOgpQVH9iBoeuKkwL+dC1QrhKT8NKphlDlP4=;
 b=VTjf1FQWCHgo+V2FxsALuWDkv+TyRaiyvFGB49aBvi+xifLP7E6gToh6knb8UZTigz
 x4X6LqXJKTjQpy+p5BrVJOMAW2beuIK7EC1VMOqPcGT1a+Dd3PgwJy8A5Ton5UfFGq7L
 TQct9xe2JICCMD2JSs2LlvarWSqlkpuhBPi6FfMkzOXYH/BoTK9y6H0QIqzSD6JJkJIu
 NMRz6D53X78U7wbTbcwsIo1ZzSxoKQ4gDx0Z/NqgIzeN4eVUnX2maIm5inC+CqaNaIPN
 bOA2MN9AIVD7r3+tJWjIFJ7liqbVllxXU9IjQR4BT5u24BZjc27wqOu1De1fgKr2VXHp
 Xotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752274162; x=1752878962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbpMjeNAOgpQVH9iBoeuKkwL+dC1QrhKT8NKphlDlP4=;
 b=evlquaivy/c9ZbFCD87u2aWojzalFtloJLUwlBKR0z4L6Zu3geWcGeu7SVgmPKswbG
 zPnGk5iRgJ5rpotO1jnvstpSXu7wfn3nM42cCnK4jOGjCWySV72aVb2akJyeBMlaiyKC
 KRAHNR+53GeJ5RdF9VT78WjQE2Tx/jjsqtBgLkcDPIeM9ScgHXINwUIJpJfOq4WpG30z
 I7QCrP4rppzvFA095lYfNvh7MbMo8veNLnZ0rzA7y+xgXu8TJ5omp7gj4UdGtijmB7Lp
 Aun0FYP8UYXBqX1f0Jg5KxTUHhyCoxqcVS3mlJxcQMaYjfo/JdjwLIWwdNoq0rrtROYl
 PQlw==
X-Gm-Message-State: AOJu0YxUIpp9hynWK3r9n2lS8zCaXuAsC6pr2LK1syKU7DKe0i9tVsT4
 1Yx/KlACYu8Z0/puV+QFAyZtm9fsqulNyYgTeOM2Z/su1EWqzpZdzQ+FyapGPmWyRjK8GDlnVBb
 MDJC6dk8=
X-Gm-Gg: ASbGnctSdaw3qtIq6VS2+iv6RK+nMnV0AiGG/cOLzMbQNr1hvAdb1uzqcbP6ZIbmQZX
 kclUPQ/9M408K6NdXFJllPCoBA48QgWyn7rOYDQKoprJZqoF5HF2mVTM94Ln4Nhmifyef+Pdmjs
 j1lpoemWVSR6yfssEXnqx6QpDO7hDA5QTDibBSmgvihSlxtdVoBCKG2jlNoErYvgufuGCKBi7dQ
 QYogFRBA1/2qJAddQ5FCg4v1Vx0H3kTiW1AJHB7lIFY7vTWNX9/A1JbjchtL/EIbdCTGqj+eS9x
 8JuDOUxPJ/GkOyiDr0UIcDjOtSnv0sTj//IigJT64BQCjQhUugsMsz1rHpHlMVAXIaXPD14gnDF
 ZWTnjF2okd8Wx/FGd8M+/zwqbfXzlAV70/EoKfhB7bV7SQUOwgbQktTCbDZxbFveJwAp/lcnQUl
 CvBxZY20DU
X-Google-Smtp-Source: AGHT+IHd/cShmp/DDpinxsJhjSfIokOny9YTjZKob2rm3OVi4pqd7xfB9nwXs1iaZCN0Aks+bo5Ivw==
X-Received: by 2002:a05:6808:1995:b0:407:9d24:af03 with SMTP id
 5614622812f47-4151f835e39mr3565860b6e.14.1752274162167; 
 Fri, 11 Jul 2025 15:49:22 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c6064sm696638b6e.20.2025.07.11.15.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 15:49:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 3/9] target/arm: Skip permission check from
 arm_cpu_get_phys_page_attrs_debug
Date: Fri, 11 Jul 2025 16:49:09 -0600
Message-ID: <20250711224915.62369-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711224915.62369-1-richard.henderson@linaro.org>
References: <20250711224915.62369-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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


