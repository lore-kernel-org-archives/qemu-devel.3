Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7F8F532D4
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 05:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4uHg-0006Yo-KI; Tue, 24 Mar 2026 01:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1w4uHf-0006Wq-EM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:26:31 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1w4uHc-0000LX-Uv
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:26:31 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-829a27414a3so2161639b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 22:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1774329987; x=1774934787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pXZrWvTVYsv2t2m1a7BOD7mXOMDtxAvtUL+4FsrXNC4=;
 b=gic0txKDYfWpM4atLntpp71ZFNsPEElWoMoeMkjc+v6FYo2q2lFynfLoNY6AB/6mlW
 xFhMJbsq+B9fuPDJdaH4uTZDTZAqmP+JcjQMlZ8dqbTu4kc67Tf66jKR5GGRzjY2Zr8H
 C8jRknYQMyw+ijcVXTXWiA+9q/6V8K0hZuSsR5tGnfHwoqMDhT8WXXW9dJG7rTC04SyB
 enShRGcrQ6u4FX/YV6NCTQ+2//gnaZ5gYQO7lnqBSsBHGuJiv/P2O3lPeyT5P8QsMAp9
 LqPw3Lq575ioING0mF7+54YgQ39gfZkLpJ0rM7octzEmtpdY0PJb/PjbWvP1LozTn6Yz
 6wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774329987; x=1774934787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXZrWvTVYsv2t2m1a7BOD7mXOMDtxAvtUL+4FsrXNC4=;
 b=SpvsSNzX3XV7LzizHOHAmJaLBmX+qdi+xFi3jTl52i4G57/dtkDbBlWfjX4Kot1XJr
 lBe+/AB5ALbnAGE+i7yDPdfEAcmTTPO/Av+jaPneLJ+JXmKiDqRKiauZaW9V4zZRri3M
 VKnGQtS0/jWZq98NjolnS79x0jEm0+e4T+SrgC8NZJfbgRQc5NWVy+Mys6OEGZvOjBv3
 9JlfigbQxd2wdtWv4ILOXhQQa4WKCJaZGeegtoZ0w5GGp7rlfKZ3Q6EpQY/PYc0ositS
 3kkgt5kL8apCMY1RFQAPM9vEjMRjutu+eFhhhG6g/alGqO1y4uEohoIQ3DxkbxDzJV27
 QgFw==
X-Gm-Message-State: AOJu0YwvCmPGMnaNEzT35nHc/d2sAgRlDbO9DhLCzAgHGPU15BLYWnCp
 mTbkYCWNw84jYLCIvbyQybAJJ4/c3KABldnSH/IyjEy46NklayQO7onUEks4253oSVQ+iRhDy+A
 mCSbYyxreZdNMqmBcvBIKhuCEzjZW5377A71jiNLmHMFHSfjTK/8NmbVBTNKWUL1qRHrz4KwkI4
 drrRA6MUlKQRKYs99A8NHTZQ9DAPaY8pt67HRY8b8rMzw=
X-Gm-Gg: ATEYQzyuAbfrlsUy1TRdzpbSgfYJ8Y/yVwm71A1UIALzlifzrXjmkgT1hz24y3tBN4W
 2rPpYc8SswrFC3CWaI/hJAFVeSkI+DX1L7qcRK5P3/IEIHgHb769TxV9FYJNbb+lmb4sAwAyGmk
 daFqlJ0UD603J2TjQSqW7qHrUkgWYWqJ2kGAaSTNkXViX/j0/nnc721+eVukZ/4WeOUo9NIObws
 Oc1RCuZ88yERQ3pE/bgv99zqDHENGX4MJ8IvqwJp1NF+MbeDarReeuoeUPhIhIabWwMqwPL03zE
 mYKE8uQ5G0q/053wdHO1Q4KeRJcCglio19yv2XHAvqt3ElwtBn/c+2ug3HA5TOu196v+16GOAi4
 CjoyzXMq25FyXf+B467hcEd/6yfsnG87fAe9Xb44gRPp0t60mC4X8DgB0KC85XUeo2HCkrCQaM8
 ymUYhW0+oqRr9+32yiJBzORT/A5Sc7NC4DraoTMjjK0QX23g8hchMtjWlIU6MS3g==
X-Received: by 2002:a05:6a00:a14:b0:82c:2445:bd45 with SMTP id
 d2e1a72fcca58-82c2445c921mr10514383b3a.10.1774329986324; 
 Mon, 23 Mar 2026 22:26:26 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0410a3d7sm11582655b3a.55.2026.03.23.22.26.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 22:26:25 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH] hw/riscv/riscv-iommu: Use standard EN_PRI bit for PRI
Date: Tue, 24 Mar 2026 13:26:20 +0800
Message-ID: <20260324052620.36049-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x435.google.com
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

Replace the temporary custom extension bit (TC[32]) with the
standard EN_PRI bit defined in RISC-V IOMMU specification.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/riscv-iommu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 225394ea83..7d5c8cd7f5 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1572,11 +1572,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
 
     iot_cache = g_hash_table_ref(s->iot_cache);
-    /*
-     * TC[32] is reserved for custom extensions, used here to temporarily
-     * enable automatic page-request generation for ATS queries.
-     */
-    enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
+    enable_pri = (iotlb->perm == IOMMU_NONE) &&
+        (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);
     enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
 
     /* Check for ATS request. */
-- 
2.48.1


