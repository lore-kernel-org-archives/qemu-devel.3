Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708D5CD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAd-0007xf-J8; Tue, 16 Jun 2026 15:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZK-Ai
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ87-00012V-Mk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-461a15bb819so939283f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636841; x=1782241641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2/1GUAAh//nPT3HEYKqYiftP4JHRiGntoWcmixhZGfs=;
 b=vX4BkK7kUz2Qvd6lnOTan3iKK7wlK08zzrU36Z5KJCFXzn7azh1UBr4WXh7srewi/Q
 j5Axj5pQfNYTuKG6ttDsoqVE5RVk+uMTzzw4M226BtH862RwTkqlM7lVOaGxNSYFO/zz
 irOZN09gKymYYq+M/VC2M/ySqpdyBEQxFkh0lNDfOOJDqq/iZ119Xcm9vgsJezdr10lu
 ZKC6X21UG/jp8k6kkjn0979dmDuLLOZ6vYKNuxg1EIF6zSyckXHxBg9afcn55S6CgOvE
 AnT0665MbwKDGfIFmRPKavfq4MnN2o68xZgybWxSixj9v7gIWt7cbu1T0DgOLLx+el7b
 hvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636841; x=1782241641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2/1GUAAh//nPT3HEYKqYiftP4JHRiGntoWcmixhZGfs=;
 b=OwlIJ2aHRCS1vteKX8EY+XJyNL7ygv6ca/3st+glnjRk1DBg37zKt7nsnuoCvHul6K
 83Nc94nMKZADG+VGWA2Xqat+7pUgNH5mfkuTmv3pxK8086cxKWT5oN/l8Uu0JIL9o/gI
 f+s5TgaorGLrl1jQHQO5f94NaR80klxf6o6XW2Ms7eBjMTedmkFRKIbGx4iMoNoU2wBE
 D7m77YTAcEGk7m8JpXDXbOyaoORFe2z/wAwDOCDIDbv5VAijs2QJrGYS+6Yngg1f5woX
 fI8j3YSb/iBBRr+9Vfim7u/sImd4Z10PAqN/Mpj9K9BqjJPzVQFdfeLjfEbOwL6EOi5T
 O/YQ==
X-Gm-Message-State: AOJu0YwIl42PeDHUk5Bt6IzT9/Cs/8JGJ0poq7fTOrPLcklNw7DWepgB
 4g428jEc/bndreUcrQxztbOE1oNw8GlOPzvQ8qdsnqG7VjYo2b/6XVcXOuIIH6Ql6fSKInJKNi9
 xYOle
X-Gm-Gg: Acq92OHZDoFvIu8zs/MhLZAa17svW5Jpj5Dv2CvQ/CWNTrEYVFGGwlteNcPybMrkRt0
 xrueA4TPPjbTiRuT96epbQOlm4KhxBN/XTo1iim/smFlSCCEgheZVw2lJ9RDv5SNlywmvZO3VBW
 lfQAHjT+9bRaSRWbATpMnDHAvW5qzzta4hR/gLav08FIqGiIONxYn6bSmJWA3zN6lfqDbySDXzS
 1+kgr26WPFXElNV+dyeEgITXtOK/IPrU0WSwzrrCUNnEU1+q2FST67sJybT60xEYybtGQ5vQ43p
 XAN7j96rg+rNzDaSAweUr2ymkyKy0eBKxtmPjBNo5OopXgRhfKJQ4XQQ//GiTOxofQq/YgSgQRO
 isNeuuHpu/eHcQXg4Q8vaGF4FMEvX0DUGwBsgdfvr93rrB2VW4NDqekvC30/xkfyqdth8+iSV52
 q55yommj2doZEP71r4QGY52zwfAxLmpnJCt4sACR3NPZ7OgGzRKAeVv4hJQFCiubMDmahVXoJ56
 RJKJntvUvXW4COkrX5P6d3TuFfEIeND
X-Received: by 2002:a05:6000:40df:b0:461:a15f:6b31 with SMTP id
 ffacd0b85a97d-4623f2e766dmr968329f8f.3.1781636841101; 
 Tue, 16 Jun 2026 12:07:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/61] hw/arm/tegra241-cmdqv: Limit queue size based on backend
 page size
Date: Tue, 16 Jun 2026 20:06:12 +0100
Message-ID: <20260616190639.3462006-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

CMDQV HW performs DMA accesses to guest queue memory by its host
physical address set up via IOMMUFD. This requires the guest queue
to be contiguous in both guest PA and host PA space. With Tegra241
CMDQV enabled, we must only advertise a command queue size (CMDQS)
that the host can safely back with physically contiguous memory.
Allowing a queue size larger than the host page size could cause
the hardware to DMA across page boundaries, leading to faults.

Use qemu_minrampagesize() to find the smallest memory-backend page
size in use, then cap IDR1.CMDQS so the guest cannot configure a
command queue that exceeds that contiguous backing.

Note this is done at SMMUv3 init, before any guest queue GPA is
known, so the cap is conservative. Maximum queue size is 8MiB;
it is recommended to back the VM with hugepage sizes large enough
so CMDQS stays at the HW maximum. Smaller backing pages reduce
CMDQS accordingly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-26-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 0ed2a03612..4b8f8b15c7 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -14,6 +14,8 @@
 #include "hw/arm/smmuv3-common.h"
 #include "hw/core/irq.h"
 #include "smmuv3-accel.h"
+#include "smmuv3-internal.h"
+#include "system/hostmem.h"
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
@@ -866,6 +868,8 @@ free_viommu:
 static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
 {
     int i;
+    long pgsize;
+    uint32_t val;
 
     cmdqv->config = V_CONFIG_RESET;
     cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
@@ -897,6 +901,22 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
         cmdqv->vcmdq_base[i] = 0;
         cmdqv->vcmdq_cons_indx_base[i] = 0;
     }
+
+    /*
+     * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
+     * queue fits entirely within the smallest backend page size, ensuring
+     * the command queue is physically contiguous in host memory.
+     *
+     *   IDR1.CMDQS = log2(max_qsz) - entry_shift
+     *
+     * where entry_shift = 4 (each CMDQ entry is 16 bytes = 2^4).
+     */
+    pgsize = qemu_minrampagesize();
+    if (pgsize == LONG_MAX) {
+        pgsize = qemu_real_host_page_size();
+    }
+    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(ctz64(pgsize) - 4, val));
 }
 
 static void tegra241_cmdqv_reset(SMMUv3State *s)
-- 
2.43.0


