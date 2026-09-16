Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DC6C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6owP-0004x4-Vj; Wed, 16 Sep 2026 08:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1x6owK-0004ux-GI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:40:42 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1x6owI-0004CV-C3
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:40:39 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9ab667so1043307fac.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1789562437; x=1790167237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g8oEo7D9iYKvCKk37zByHEQLHp5NBlGac6gC1FFqQIY=;
 b=ZHLo/5zy4eq+N1blGD8nKoa9pwtKp/TJEHu/TD25DDzpfqKfGJAYg1Hc5BsRk4igbK
 9inGtWjN1kI7wSgjIgGsqVLB2v8GkL8xRlUVQpPnSlcRvjOu1++k18m2ro/Pd9jsklTf
 N3vx0zr50syz1CrewfD498NDDBdHpA/lndhpCfPrTOHtV8NZz22mxhncwKFk0VYmNKdj
 4JD8Q6r4uzodshmM8heyuyiiSLMbbiTnMCAoI/hTpaeFsCLipt+O3D3n+wpP4FYiIaW+
 zWUIHPVD+czYhI6IzHbo8SOy7YowvAH+nhx+D1pwd5WteyZd2R1hZIQUmBUNShsbfNXW
 dZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562437; x=1790167237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g8oEo7D9iYKvCKk37zByHEQLHp5NBlGac6gC1FFqQIY=;
 b=0gVMiu1KIz7t/x8VbAskbLDEXRAzMmSPaNKeYfauNF/JtBKaIQz5R1PTdxzsRKgKwd
 Jai1dA4HIALRCniXyp1KSD03DQXC5jkLIk+vEyaoqehVfI4N79PkNFHG3JXXOqxBpNDk
 q3ljmrjtU3UQ3p2gfRltpwgHcjpuqNe72gn+rLwhLzZ2OQ4aTdO9qFLMmcYyvJpcrCac
 b+Db46axXrDRKVlGWTZjRp9zpswTK5Bv4XTACjcHOypOASiTf8rB/V8aAu7JWzDkpOt8
 S5lRDkyp+oUY9FubPnBGAZLEbc1HNa/GuMlINjzlLCqTAVga31sOZgn6Zb8ckh4av8Tf
 64Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvByP9n1gtYhlvaOTMmRc/KaucF38XwbQlZXjlm1qQcAFtgaBFgQucV3kiZFqgV8Kp5kUijgFbfyE/y/1@nongnu.org
X-Gm-Message-State: AFuF++ky13o9H28luhdqLydrT78Y6Dwvslzw1MHLPw/nR/LV8ihylMFx
 bEDBH/HkvBvPOt3TbefZZ6ZdzahwxQHTudZ3BAPfIIoBY29S43Fc866ZsEv4CzVWuwI=
X-Gm-Gg: AYBFou3bd1q2dU2t5bI6v49/aHzakAPKNF4JkHFAlDok5NjylCde4GxI+9OqsMFPTQM
 czR+8X3Oh4GXefbgmlZk8bKJCOckN1mLbsagHIPenrS3jn2Iqz6qUczn+zneDDTkUObaLZY/NOT
 KQzwFhC09UkrIGNkrvK8Tvu+tl/a56SkjVmPo3myFTmxAlJ58np0sReBPRs6Nvl/PwyzyUqu6z1
 78/GIbGoOu1u7NH1shh9kJrIzyjnTJlObg2ZnvkCt+rkDxmHI5pYE3op3O7KXOyEjU02ZJOmrH8
 GeOFoqGRT1vp7+3gu2u6GBxN4aW2Fcsq3XGeoqFowSX7u4zBzZM2OcRoNZ+bgnSVqJbAV82RHpS
 TteE8KwhhDvFexrRiVjRpLFNFS99EHilHLIQr4KrPZsI0oHsIyILL27u2zXzwx3kzJSw3BAaBYw
 o6jgDk49ZxXhi4lLRdER3AaHYgvmXRRGfFfGVTeobNuqjXJVjgEy6xgcyioAiD1nRSNsna7xpE9
 3cIwsnSw2irOag5cX5ld6PyHkFj7IxR
X-Received: by 2002:a05:6870:a08c:b0:479:7931:cd6a with SMTP id
 586e51a60fabf-48478060b7cmr2200186fac.32.1789562436958; 
 Wed, 16 Sep 2026 05:40:36 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48427b26d1csm2551321fac.2.2026.09.16.05.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:40:36 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: richard.henderson@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH v2] accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
Date: Wed, 16 Sep 2026 12:39:58 +0000
Message-Id: <20260916123958.1884903-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=antonb@tenstorrent.com; helo=mail-oa2-x10.google.com
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

Update tlb_plugin_lookup() to check TLB_MMIO in slow_flags.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7f7c208ba1..3ca777d59c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1593,7 +1593,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
     data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
     /* We must have an iotlb entry for MMIO */
-    if (tlb_addr & TLB_MMIO) {
+    if (full->slow_flags[access_type] & TLB_MMIO) {
         MemoryRegionSection *section = full->section;
         data->is_io = true;
         data->mr = section->mr;
-- 
2.34.1


