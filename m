Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73850C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qn-0002Cx-Rc; Thu, 09 Jul 2026 22:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QX-0001iT-UT
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:26 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QV-00006U-97
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:20 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c981c2c37cbso322415a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652238; x=1784257038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zngc8++rDgHsEz930J3TVwiP7P95jxbHJgjE5BMDNeI=;
 b=TkCeKOo8G6P//sZDXir30ptoUC3Z6TvfQsSUQmH7Meeq2SdyGKAxaSqX6PPVwCeJb4
 3JRQ8Vr7BDUjnwRgmj0PJpYTENSBxvj4WPdZGiQJusANO3sxjeyUUcs9oBtT5/Da6AqW
 Ug2DYbmD0yr6aPa8UcvjLlzwujEliHe3OaTlQywFmnjEI9LGNSZeJjBoyTG5nryPCHDs
 HbHjUPXfUDnjr6QzvxL4tcWHUJshgyldxhSXjeeYzlW8vteMleFecqb6XxwNSZ7xVeb6
 o708liY/3Lf3mSFx4K9ZAc4S6MIy8SInC8dHQCpPe0OdvGfQcQbP/Nu3MCoQ0jyEkKGy
 WUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652238; x=1784257038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zngc8++rDgHsEz930J3TVwiP7P95jxbHJgjE5BMDNeI=;
 b=VKydvV0yqluksrwhrOA8sOenqPQ1YDU+vQRVOKsmCNtiij9nGRViYraI+YgdDxCBgY
 rhjL6AjJZ1OY+9wk12EK4sk1CypJS+IjX8lofNJ2IsMqH08lymmht81HNb3w4TCV2z95
 +NdVGfq1O7UyrGEd4JgSQbu00VVNd8oZUKnukQEt4aH4rwh2FGulyWHjqTHQL5E/CvzX
 9Io3SewY38dnFgSbtb5b8ce0Jazp7Y9Wj1BRHjszq0VMmkdni7efcaHmht89ttPiXECk
 ENVR/xFgNnr9Bda9RnDoGKr71bhTFm4NzTDv9AR6AlA9TdaYoPWIMJXaiwepxQTPRAyk
 IfCg==
X-Gm-Message-State: AOJu0Ywt5u4o0xo6y7YXYQ4h6CEGigFwgfTZte1DdTXOoZSjIqi5I2/W
 Iwl7qXIVIFVsb2InQqFVjjXP/+3SNQk3/n8HiLjq98ONd5ggAJ2ofnjOFjIekQ==
X-Gm-Gg: AfdE7ck/ryydKCG3+JprflGhhe+lVYWApHppBhQcc/aMa4SttzooC4Sz1OZRK2RrHKX
 g6GimT8YEzmG8XhPaj35KrgsQPUbO78pJ1jeQWEpFtRy+7WNuzQMr/PWiGA+XwIsCxFoX0cdfVQ
 JKR1hXFYsrLG8v1c1sBqO9KUUksNe/ZgJsMJmLdw/kBwlm19yoc1ZVkMs6mnuf6IRUd0FE74hAI
 B+pEBqMYChq8Aapw6/74JD3iKO3iwYtx1hvTRx7T57XW4YHBUkmn3Pvk5OFzXJdmk7Dtre642ne
 Y15YsklNZDaDEw80OiBmw2X12BgDcSgNUV+lyYqpw6neilnny517H2Y0O+uvNnqJzdfji+eCi6p
 S2HvfSv24DLwciDGkRlSpkjsYeWfdBn0IpP8ZBOapH2yRuVzBnYQvZNyOfLtJ617jl2LI+rENVY
 efH3o3sQM/O9QK0PgerS/vbD9TM76Sl2o=
X-Received: by 2002:a05:6a20:918e:b0:3bf:b3d5:ce2d with SMTP id
 adf61e73a8af0-3c0bce18b54mr11943205637.7.1783652237566; 
 Thu, 09 Jul 2026 19:57:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/40] hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
Date: Fri, 10 Jul 2026 12:55:16 +1000
Message-ID: <20260710025525.1704417-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We must check if IOHGATP_PPN is 16kb aligned for non-bare GATP modes.

Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3550
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260702203616.1795588-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 12f20fa4bd..d3710aa3a2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -862,6 +862,21 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
         return false;
     }
 
+    if (gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
+        uint64_t iohgatp_ppn = get_field(ctx->gatp,
+                                         RISCV_IOMMU_DC_IOHGATP_PPN);
+
+        /*
+         * One of the conditions for a misconfigured DDT entry
+         * according to the riscv-spec: "DC.iohgatp.MODE is not
+         * Bare and the root page table (address) determined by
+         * DC.iohgatp.PPN is not aligned to a 16-KiB boundary."
+         */
+        if (PPN_PHYS(iohgatp_ppn) & ((1ULL << 14) - 1)) {
+            return false;
+        }
+    }
+
     fsc_mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
 
     if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
-- 
2.54.0


