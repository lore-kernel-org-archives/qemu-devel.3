Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEC6CF34C4
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fY-00025K-Rr; Sat, 05 Oct 2024 11:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fU-00022o-TT
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fT-0002N1-7h
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:04 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b64584fd4so30733735ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141961; x=1728746761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wa2JC5GTiuZOa9FUt+c/E5R/4D7wBSs90VoPwelenc=;
 b=XKTTdeWxdO6WqJvEnBdtufVtG6Bpz43HNEB+Qkp9dFQiBi90H631W1LMJOql3p6Xjw
 nKu4e+araHW7rmJjK5KuzyAQoFChSLrmL/yHPxv1ov31M9faNjcTNyTnCfmZyPHzvp1X
 VxRJT8JhKKmE55bfaRmqyGlC4Orlv3wZVGwHQQz2qxPHFEK+tOaz3wbDqusJmrZonGe8
 Il9+JDqS4P+N1IHAGoLisGfM/rzmiNui+Ch7wzSQY2Nj7tUNRrX2YjJ8r+VUj+ukUaG2
 vnzzo6IwwXeWv44BD1ycJCRGijrAiMyFnHXkY9x3nD9edU9IFJVdg9HLTT3tgz64k/Pa
 k5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141961; x=1728746761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wa2JC5GTiuZOa9FUt+c/E5R/4D7wBSs90VoPwelenc=;
 b=hu5CN0dL7KLuP0QoyrQrV3q0+RJVogVleVuDp4ZhEvzle00RJSt2A3wqSPlXqhqL7z
 FDaXlIiLSRk7AcHhkz+g3tF+fceZdV2xh8hvicSbIRdk9msfBc/rs0dqIvPbjMLyrYGx
 DltPoqnd6OQantP1f8Cty58cKqseq/Kvd3dj7H4X7wlppzJN4Srdykl163BuUT0LBTYP
 xv5fF/yX9JUty0ZO0RwzThdwq/r1c8xZqXB3J+UPRJg1+h9vp9lxRAv697qxoy/mQzy8
 QIRMfNyHN+fFEqwnknGdt2s4X7VIA6Ksrz1PjU9Y1T5/CR8tPvdJCrqSg/IHQqFc2CpQ
 1+Fg==
X-Gm-Message-State: AOJu0YyrwnuhohmkXFP6Q8IHUakEXdpWd3Z37F/BCDZwHfdbri++3d9a
 1q5gn9biZxLSh+Gyzzd0tdfwk524fI0sDLbHh09tal0+ASHulCIxbcXv9hVD1ER7ynZBzKeFF3H
 t
X-Google-Smtp-Source: AGHT+IG91WPfsC5D7LXHeMJAPorkuse9kNn6CykSYZIeBAI70lXeJDkn5eW9lfVj7aitw+VRpPphGg==
X-Received: by 2002:a17:902:e887:b0:20b:8036:f77f with SMTP id
 d9443c01a7336-20bff1a9178mr88727005ad.46.1728141961604; 
 Sat, 05 Oct 2024 08:26:01 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:26:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 09/20] target/hppa: Perform access rights before protection id
 check
Date: Sat,  5 Oct 2024 08:25:40 -0700
Message-ID: <20241005152551.307923-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
"Data memory access rights trap" in priority order ahead of
"Data memory protection ID trap".

Swap these checks in hppa_get_physical_address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a386c80fa4..f027c494e2 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -267,6 +267,12 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         goto egress;
     }
 
+    if (unlikely(!(prot & type))) {
+        /* Not allowed -- Inst/Data Memory Access Rights Fault. */
+        ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
+        goto egress;
+    }
+
     /* access_id == 0 means public page and no check is performed */
     if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
         int access_prot = (hppa_is_pa20(env)
@@ -281,12 +287,6 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         prot &= access_prot;
     }
 
-    if (unlikely(!(prot & type))) {
-        /* Not allowed -- Inst/Data Memory Access Rights Fault. */
-        ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
-        goto egress;
-    }
-
     /*
      * In priority order, check for conditions which raise faults.
      * Remove PROT bits that cover the condition we want to check,
-- 
2.43.0


