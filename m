Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C7CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qq-0002VQ-LC; Thu, 09 Jul 2026 22:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qd-0001rp-TZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:31 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qb-00006z-9Q
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:27 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ca7bea5e5b3so369533a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652244; x=1784257044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ny4UGcbyjWyMxmJGfOmf7MJn9Yp0aYcx/FfigMI39mw=;
 b=kK2M67ALRZqprogw/OAUhSLV7KQg+kIBolO+1kw3RQqXKOwovOGE8lfz9fNgFiaYP2
 5Fo2U55hz/llj0rKXwX8gVQHFDavXL9idjFMX0ht20nQBWA+ejjV8UP5md4604ysaeuS
 GmEOwWiJ39LJS3e+qCt1cDsMO5titA2bCF9LB5HjHlnJZ2ubyeAUOWlT1/4TauHG9J+a
 b7ucXAOQs2AQCOFSQkzovVSxcEN+j37kG+dbjeT7haJA09Mt5f0s31kBVlx/8dboZ5Ti
 3H5i+1czUhEOKp4CBdvOu/LprXUXGsHreeRkwfgcSgbvNTAi48G//pQRbryn09tGDpnz
 ta5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652244; x=1784257044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ny4UGcbyjWyMxmJGfOmf7MJn9Yp0aYcx/FfigMI39mw=;
 b=ehHU4bGH83ZdutcacvqnUbjvkN13C+mKw78icNQgV3361AaQJSPoW8sk7zlmMq4yEV
 rLvlPbQ0EYw/EwuxRlaFnvHH9XbIcAtKMuvLBEe9ectMGbVk2rzaCJtUnkZ+C0PzOvlb
 UjYbsRBfpOvxQLrwoEUBhVKyWRYBdvOiNoz+CrkpFlz8HpMxfmRQ48dAWZIXmTqMcvQ+
 XV1GoBy31Qbp3BDF66+GE3dNWLUc4SFCTfjx5P3brHRT+fIzICv2STXrUrb+4S8rovIW
 zeXYFxwug+w8NgDTXu4hZPsowjhIYwU2sbYQXIwzysL1ZvZ9bTFkelzdVdwXWcEhdxPe
 rPbw==
X-Gm-Message-State: AOJu0YxjOpp7ySIuRdJURC/W5bbqDscewuw1x3GlzUaIBxmrgzLFrgnA
 cOt73dJVmHbnSAa1zM3PrtqfNJFcJqdvZ4KnWtIL90IO8joqmZDikY3DGhIOSg==
X-Gm-Gg: AfdE7ckZ/lc3Maxf3daspF4hTi5ZdmkKY82Og2atrWybogpM3u4IVy27pQrb3xPKa8N
 +mVIh+RJPctclnNYNNG6u5H8p302WufSCJoQcRo7/mjboeRlaVFqGWc2usYrtLKECgjK0yuiEA1
 9m2m19KE3NO5G126wSZQpT+bY0Ql5jNV+oRwA+3yJgGP6Bos5QZb4+vJUkSI0CQ/qrXcE3VhWBS
 9oy7yGNrjlhjEjeO5FuCQh9k3l2TwdZlBEprN0XlFZTYvhMdA36hHDE2lltdRlBqt/a0gDCkMe8
 wnmeDqHuu6cM4fdtRTZhNsVICiDk4HSb2QJJ1TNVdSiGfzbKFOUGFKdQtC1jhNozuqOoN87JJ9A
 /GQi2jj4dR6Qpho4LXoLInZBnRQx9DJVQuQoMzYf4LxBijFSKxQvYDonYOU1Fnw6gFB6nYakxsM
 mTep5maq5XylFqS4h+Q00lIM2oHV+Qhc4=
X-Received: by 2002:a05:6a20:a10e:b0:3bf:b1f4:747b with SMTP id
 adf61e73a8af0-3c0bcf497a7mr12374797637.12.1783652243836; 
 Thu, 09 Jul 2026 19:57:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/40] hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD
 is zero
Date: Fri, 10 Jul 2026 12:55:18 +1000
Message-ID: <20260710025525.1704417-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

When capabilities.AMO_HWADD isn't set, DC.tc.GADE and DC.tc.SADE are
reserved bits and setting them throws a DDT_MISCONFIGURED error.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3549
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260630172110.1866951-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 1 +
 hw/riscv/riscv-iommu.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index cc0b1c3ccd..924a1f8c21 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -86,6 +86,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
 #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
 #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
+#define RISCV_IOMMU_CAP_AMO_HWAD        BIT_ULL(24)
 #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
 #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
 #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index bdc409adc9..877d24bc47 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -417,6 +417,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         const bool ade =
             ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC_SADE);
 
+        if (ade && !(s->cap & RISCV_IOMMU_CAP_AMO_HWAD)) {
+            /* GADE/SADE are reserved bits if AMO_HWAD is cleared.  */
+            return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+        }
+
         /* Address range check before first level lookup */
         if (!sc[pass].step) {
             const uint64_t va_len = va_skip + va_bits;
-- 
2.54.0


