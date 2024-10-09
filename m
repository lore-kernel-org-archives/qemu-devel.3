Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEDCCF042B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCa-0004Rj-1P; Tue, 08 Oct 2024 20:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCW-0004OV-9N
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCQ-0002sM-Jh
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:11 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20b86298710so53279755ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432305; x=1729037105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQhK8NjjgW/kNvx5X1m22TpA6VVxTZtyOqTVcWaZJho=;
 b=Dmn9fQ2vtmubV1jQOcXh1e9bPMTS5lnAx37z3EXDNsWO2iPFArUgTDphSvJ1uWphO/
 4GPrAf4UrwYZ7GDhEGM+ap92L+vb46127Rdzr/ttm6yAw5ta5ntlaqs5N+fYz66002rA
 gm0PZZQQaCKQ2aR//2dGEuRfl1DFjZlZZGztb13PNE8JFjKPlNLbm0ulL1iL8tJabbQD
 XmdGF36vYr5xEjiiHWMPAyWn1VCqEed2OHmjCCk8Zntw6HkMaEggjGa/ClPKLonCiz8E
 7LmkiQ210jXScJkds7krDJph6LoRROZ43vRoN3Sxv+6dhgtQAPcZ3yPzpMsqjoQOmYAn
 G4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432305; x=1729037105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQhK8NjjgW/kNvx5X1m22TpA6VVxTZtyOqTVcWaZJho=;
 b=k007mwMK15WJWrMOqkmyySfDwzjamZKCqf5sa7jBdBlU40FLJJyA1/eEcxi/Yh7px6
 6YsuEOckrHm7P4CTNTxGHxP24bv1bzirh1++iOhPZ7vP/I9PW6Caam+Nk+imr0p551Yz
 jOLu//dNOidpJYx8olZhzrCH1QFKylmPBTho4LkHaJhGF2WlRJHcf9euIIwMi/IZh133
 43sWcCCuMAhgoV0xjHQg4rjrnuQZcKRZ9I3zmMb8lO7r/XWTf0PMvvNSnWdDNcsK0U3j
 jUs6UMamvThigRbmpWH7mXav/42slrgJ6VIGakN2maoWfRboDIgd5tWfb4n3s2WSVYZ8
 Yitw==
X-Gm-Message-State: AOJu0Yz7e/JfVIqvLrqxGUwVTky9rxp7fwingSvjZ1USLHX0vPVwwoM9
 sM+CMH9FHfvq3SGMv+qU4dJFRU6vy+8DbumUK0Q+8X4+HG0UVeL2BGsKPWf3YCMEbc2kbxyMc/b
 G
X-Google-Smtp-Source: AGHT+IGk0V3WqNWZpuoKiyjHCbvkavwK7mPvzoRJ0f7iYAkKJh77UVywliO2AjnwG+Rua0FM3sG5Mg==
X-Received: by 2002:a17:903:2309:b0:20b:51c2:d789 with SMTP id
 d9443c01a7336-20c63711761mr12234395ad.16.1728432305301; 
 Tue, 08 Oct 2024 17:05:05 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:05:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 10/20] target/hppa: Handle alignment faults in
 hppa_get_physical_address
Date: Tue,  8 Oct 2024 17:04:43 -0700
Message-ID: <20241009000453.315652-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In Chapter 5, Interruptions, the group 3 exceptions lists
"Unaligned data reference trap" has higher priority than
"Data memory break trap".

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f71cedd7a9..d38054da8a 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -221,7 +221,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
             g_assert_not_reached();
         }
         prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        goto egress;
+        goto egress_align;
     }
 
     /* Find a valid tlb entry that matches the virtual address.  */
@@ -323,6 +323,11 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         }
     }
 
+ egress_align:
+    if (addr & ((1u << memop_alignment_bits(mop)) - 1)) {
+        ret = EXCP_UNALIGN;
+    }
+
  egress:
     *pphys = phys;
     *pprot = prot;
-- 
2.43.0


