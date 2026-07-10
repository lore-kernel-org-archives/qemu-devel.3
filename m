Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BA8C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1PA-0007IH-Dj; Thu, 09 Jul 2026 22:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1P8-0007Hv-B9
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:54 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1P6-0008Lm-Os
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:54 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso323879b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652151; x=1784256951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+40W3U3aXppQIKmmgpDKYpEBlgnR/8DBQlvnCXRDAHQ=;
 b=rdqalGPjQ1Gcecw+gIc+sIKl1uBR1PqePZdYOrlbjRHABLcW1wARo4qyeEGuzjSgrX
 HpzmfNk0W6ZiLgGvygrCVrAH5SfztQIxyw6i3qVQxlJxvMGUuaVc/Wvbg10A3s4sNKL3
 ZnAS4nLjgE0ZSfogKsSlAiHhz0H+m3Jowru0CjihiQm5IyQn63hMQ8y8oWvlWW3FdSXc
 uhWvV877HRr9rOhhPAN1cBXYjU2dt8WArBc/moFnKYOGuXHfV3wtgfFnQ83/Sjpr9FyA
 D9WNNothikWSz4GToTqS/mhAr0x7xaM/iwMmTGo+ZGJEdxtqEovpkoHJSQkjjUy30hZ5
 Wb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652151; x=1784256951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+40W3U3aXppQIKmmgpDKYpEBlgnR/8DBQlvnCXRDAHQ=;
 b=r4XXcRaxM67Tx0lvxjJ9zH6ca/vt/E7srLkWodDjgR4C/Cs580JvlGRg2w6230FjKh
 Y8q3qvmteMT1GzOH2Cg62JLLNPUH0uaKcaFfPuq8e/fhOIQXIzKO21ZfWyK6S1APHFTM
 62lcnEXMCEdSJQGdspa0zNz3dHCm4WkG7zAl2AGeVeSvyakqsEwpw2A4+ayuxUlhtxeW
 7QcHSIRgxgnIgZKta82ypOTbxF/19R8vdMX0oZ7Zp+sPkHwMCIMoTQZUA7/vhiNtikdW
 28JPhSvLzXx8vzEI+lffjcKNpReLYwG8Uoa3wycLTsydYNUq5B2odDvDEfBV0hItpHm3
 EGLg==
X-Gm-Message-State: AOJu0Yw2vab0buga8jhngkEtgjTf3Z4dJeT1cIRms/VAJnH40oz4c0Ub
 6IWi5jvxXCv7nwyT+xr6o7Lm0x42jXPLl3s4fbchWROp2sq/PwP05RYX8m3y7Q==
X-Gm-Gg: AfdE7ckMFOXIf5dLAuZjpX4ZLy8gk565BHUkixJmZQC+aoivmqpV9ecJdRA7beY+SD4
 Ryx9BI9td64ZoLj4V4k4Jh62NaqnyQgH8K8OzwL3qKeQ6iLNWl0d/lApAiOZYpHGNUX2/oRBqxe
 lM9nc6Ca48oanGebWrTMP53uTG5ZJIhlrsF7W9tuFFo4fd/ScNl+DKBLOIx+j+1WFIySM40bppF
 ZuT9GABrysyzmIi5dWnzByOuwLaKJw/3oNS6xdF6IweAfDja8xcCbHcWV92C0GPAVOjn6WqnBn5
 GpR7041UjaSzpkjl2+bDr7VAU0SEDHMcPrHsqhkCs2Ck/RWDTwupxwdlX+jzxYF2dZb1SPmQ6S0
 h52Ge9r8Ad8C1uzq6SCTfQnqhRPPhepuSRtS4Qnv4A4YdO91SWL+1DXuuYdZDw23xFXcpOHwijS
 TZltCBBTfS/pPFrtjEa/htrKo6n20L4Q8=
X-Received: by 2002:a05:6a21:700b:b0:3c0:9c19:65a5 with SMTP id
 adf61e73a8af0-3c0bd3137b7mr12746467637.61.1783652151358; 
 Thu, 09 Jul 2026 19:55:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:55:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/40] hw/riscv/riscv-iommu.c: fault for non-user PTE in G_STAGE
Date: Fri, 10 Jul 2026 12:54:49 +1000
Message-ID: <20260710025525.1704417-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

riscv-iommu spec 1.0 says:

"When checking the U bit in a second-stage PTE, the transaction
 is treated as not requesting supervisor privilege."

We need to *always* fault in case we're on G_STAGE and PTE_U is cleared
since we can't be on supervisor mode at this point.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3555
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260701121111.537654-4-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c35e9f0119..6b20940b89 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -495,6 +495,16 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Access bit not set */
         } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
             break;                /* Dirty bit not set */
+        } else if (pass == G_STAGE && !(pte & PTE_U)) {
+            /*
+             * riscv-iommu spec 1.0: "When checking the U bit in a
+             * second-stage PTE, the transaction is treated as
+             * not requesting supervisor privilege."
+             *
+             * I.e. we need to fault if this is a non-user PTE since
+             * we are always in user mode at this point.
+             */
+            break;
         } else {
             /* Leaf PTE, translation completed. */
             sc[pass].step = sc[pass].levels;
-- 
2.54.0


