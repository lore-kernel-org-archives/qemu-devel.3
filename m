Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AFBCFB42D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2o-0006T1-Ne; Sat, 05 Oct 2024 16:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2f-0006On-Si
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2e-0001n1-Cp
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20b01da232aso25564635ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158775; x=1728763575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=or+46uGq1e2/GbDMKkBXfTr+x8kd8hih+f1GC2rPQFE=;
 b=ALs6xGQZEfb9+x/t/egHxvOEcBfGC29eE+mpgBu78nFAWVtu4MQLHnc33lvGIfGZDk
 nnM0Rbw+w2iq07PJ2PGv9QorquM1BicyQ3ZdgWueIs+ZWc/fC4CEswsDSg73oYi8TUUR
 6pWDDlyhVhst8fbVBwANj8oF3HWqVJnV2Lz+V3TfbOv85EbUUxShTsAfZxhLMuYevG0c
 rAHhTF2fd5k0vNTpIG2mcEkXYpmY84b3cygXR0zmcVykUKga/DG4kMLyGHuDsf2n3mCf
 oB9yd3eBQ1456kTwZ8vCzQJzf2w+xf5ztSbVdO/0/Kju+cURnouyrn8XOLhROaTRZaNl
 k5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158775; x=1728763575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=or+46uGq1e2/GbDMKkBXfTr+x8kd8hih+f1GC2rPQFE=;
 b=lWkPvbU8ywhC2VMp1njpYg++a3Uo3RWuCJPqDPg8I26eWf3mWuFGGoevZBQiHPfzTl
 qX7dgFV+osfA3rzky2eoB/zQV1OEZLBPxz4cDggxbcNu/rsrt56n0BVEkMaYBaSZzucF
 opArStBIrEn6w/11dJGaWSxlNpmiaKGdq2KejClYHlq42K0+rPuzXfpT4ha7++GfTG0+
 iob+cf/gGAldbwe+FIVqCAH3rq4+Riv3Xu7AacWUZ6bSvlwq2z0Kx18yW+CwfIwz/wFU
 MbD/fQwqsewvz38W6EIpxy98stokhsHUORd88Cor9X58XUZ5YSjHb4l1ep6y1FUVNtrv
 7+DQ==
X-Gm-Message-State: AOJu0YyBiV31wOdJuf1nYNZFvR26FQXVjgyzLU2OFtjlDGNRwlVNjdfd
 VyJGl5KvepOPRz+WVGzWIMZeeLw+bHogdXnUsb0ZvFT+ZhHrQm5+kv07mIEW8eKhgvCHgsGF/XY
 1
X-Google-Smtp-Source: AGHT+IGg8sgiEBRoSbtsp5hCkfkIAZ+oEWQnrBAFFM+N7oyUTJv3AhGKcIaJbMYi1S9IuPikpnwrog==
X-Received: by 2002:a17:902:d2ca:b0:206:9dfb:3e9e with SMTP id
 d9443c01a7336-20be189892dmr148488525ad.10.1728158774767; 
 Sat, 05 Oct 2024 13:06:14 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 14/21] target/arm: Pass MemOp to
 get_phys_addr_with_space_nogpc
Date: Sat,  5 Oct 2024 13:05:53 -0700
Message-ID: <20241005200600.493604-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Zero is the safe do-nothing value for callers to use.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 3 ++-
 target/arm/helper.c    | 4 ++--
 target/arm/ptw.c       | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2b16579fa5..a6088d551c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1461,6 +1461,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
  * @env: CPUARMState
  * @address: virtual address to get physical address for
  * @access_type: 0 for read, 1 for write, 2 for execute
+ * @memop: memory operation feeding this access, or 0 for none
  * @mmu_idx: MMU index indicating required translation regime
  * @space: security space for the access
  * @result: set on translation success.
@@ -1470,7 +1471,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
  * a Granule Protection Check on the resulting address.
  */
 bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
-                                    MMUAccessType access_type,
+                                    MMUAccessType access_type, MemOp memop,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
                                     ARMMMUFaultInfo *fi)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f77b40734..f2f329e00a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3602,8 +3602,8 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
      * I_MXTJT: Granule protection checks are not performed on the final address
      * of a successful translation.
      */
-    ret = get_phys_addr_with_space_nogpc(env, value, access_type, mmu_idx, ss,
-                                         &res, &fi);
+    ret = get_phys_addr_with_space_nogpc(env, value, access_type, 0,
+                                         mmu_idx, ss, &res, &fi);
 
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 373095a339..9af86da597 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3559,7 +3559,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
 }
 
 bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
-                                    MMUAccessType access_type,
+                                    MMUAccessType access_type, MemOp memop,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
                                     ARMMMUFaultInfo *fi)
-- 
2.43.0


