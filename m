Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD7DCA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNw8-0008Ti-ED; Sat, 30 Aug 2025 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEM6-0005y2-4P
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:26 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEM4-0004AW-IC
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:25 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-77238cb3cbbso727114b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532543; x=1757137343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPlzqMTyUH1o75eqZe6kHnvlek/VG80/rmWxffANEJg=;
 b=RmKBZPqwMqEHDiMO3HNsyn/DgO7NURTg50VQ0H3v41Zre5KXBESZfRtYCeUCmKugyt
 C/094xRln6+rSPQ6KnorVnQ6GzLYH34aKOrz5IMD5WTvQPrng39ggkf3V6TGC1a8Xvp0
 DqGZpA60Ez3BakmEoJ/TZFQCYCg1udc6a/wwl9jRVv2L8WLqlqXmpGqICLXZbn9LotGt
 lQfn9wHVBXaQ6Uxw6vgpMkmA+ZuP9naeWed4XAcAoN183ZC7lFkKk01xOIEStd/ME/Ex
 Zkevo7GzIbPEoqjCWkvqroQ5TCk2exFg40agzHu1KNCQqLBUSEBDspvSusLF5CkH6W+G
 w8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532543; x=1757137343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPlzqMTyUH1o75eqZe6kHnvlek/VG80/rmWxffANEJg=;
 b=bj8aZNWFP800HIRoSpEzHGimMt4aaIylnkil4uquURT7dvo1C2/x73FLmA6qYpIj7Z
 k2/bwOzpfLh1p/irwppTnAZBsbzM4gGkzn8J6d6B1zxww7iNvT5+V3X2Q60ZK88pdoF1
 kkTy8uNBLixpiuL/MpZn8GPGcJZo9NZmP4njOmuZnhlJhrlz7VLLnB005OJsthkQyoWp
 6HW1Vz10CqMVW+6fdLAtOIxDEnucKb12GBIvmPDOdbAz75jwKVLdlkILgtMzZyWRJH/P
 IX2kanIupQyOF873y5SMx+jgXAbw0glYAqZ5R4lw+ZfHqFY2HvUwta2VmWbk8YwtI5zV
 1d1w==
X-Gm-Message-State: AOJu0Yy4Di2o2ohk+FEbZAJ4eWX5MiKDem7Jk6w0eOv8TjTAYsLwexsH
 MBud+sXWUip5mCgrNf5shuLp8XBp1MpDiS0KqwySag7EGuE6fMwko9CQ+CX88sMIl7tjI3lyrvN
 slfPserE=
X-Gm-Gg: ASbGncu9hg5pk3mjlIXwX2IfBsFWaIxvv3/grE65d+1tSFcoMyKwWuGlywfvMXF4i4T
 hfA7Z9BpHcDwYCqdaYhDiJF+yKbPvnSYexJ6qudvNw9gc0YnLaHgJmwV31ZpQno00rE9dqo25ka
 gFzq0JOrILrDwHt9MUlggD/Ziu42u6Zg5NwEfXTPOjEcJDtTPb59UnuepE/L4+A862oB67xVbzK
 ewDlb5aT2Sf+UrGM5dN/ABLiQloK8diA7tP6ZG3IDyLS/R/Epv1ydEh5oDEimzhxKJOPpQObQ+F
 q5drrOWfHeZtfvXqq/WP0JgJPBIHFxsuhZKz1xoQTVu5u0aiYzzAwteb8W3sZBR/rSAq/VrQ2RK
 icgbSKNsCFEpyOpjqpxQVACdgrEKJycoZt0mexxNjRckYNd5xH5XAL7u/RJzd9QUQ5sT9YvE=
X-Google-Smtp-Source: AGHT+IEwt1XnJrjDqrslx8RzcVEHugcigKgHhfuwS3PbkeD+NxqNVXecM0s5uhZypZZrK9wKm/4PqA==
X-Received: by 2002:a05:6a21:32a7:b0:23f:f4df:6ce3 with SMTP id
 adf61e73a8af0-243d6e01f60mr1526362637.18.1756532543274; 
 Fri, 29 Aug 2025 22:42:23 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 17/84] target/arm: Cache NV1 early in get_phys_addr_lpae
Date: Sat, 30 Aug 2025 15:40:21 +1000
Message-ID: <20250830054128.448363-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

We were not using the correct security space in the existing call
to nv_nv1_enabled, because it may have been modified for NSTable.

Cache it early, as we will shortly need it elsewhere as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index aecac27c54..214279ffeb 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -76,6 +76,8 @@ typedef struct S1Translate {
      * may be suppressed for debug or AT insns.
      */
     uint8_t in_prot_check;
+    /* Cached EffectiveHCR_EL2_NVx() bit */
+    bool in_nv1;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -1642,12 +1644,6 @@ static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
     }
 }
 
-static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
-{
-    uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
-    return (hcr & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
-}
-
 /**
  * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
  *
@@ -1699,6 +1695,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                    !arm_el_is_aa64(env, 1));
         level = 0;
 
+        /* Cache NV1 before we adjust ptw->in_space for NSTable. */
+        ptw->in_nv1 = (arm_hcr_el2_eff_secstate(env, ptw->in_space)
+                       & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
+
         /*
          * If TxSZ is programmed to a value larger than the maximum,
          * or smaller than the effective minimum, it is IMPLEMENTATION
@@ -2074,7 +2074,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         xn = extract64(attrs, 54, 1);
         pxn = extract64(attrs, 53, 1);
 
-        if (el == 1 && nv_nv1_enabled(env, ptw)) {
+        if (el == 1 && ptw->in_nv1) {
             /*
              * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1}, the block/page
              * descriptor bit 54 holds PXN, 53 is RES0, and the effective value
-- 
2.43.0


