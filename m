Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970AACD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4v4-0000d5-S3; Mon, 15 Jun 2026 06:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ4tv-0000RA-Jg
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:50:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ4to-0001Si-FA
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:50:37 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso2826073f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781520634; x=1782125434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XQnKDUmeMi6ki8lCRaBDX4eBXYuzkjCC2EWJzcsXgik=;
 b=kXS/Amtp0j0TkC5KgFTeBI4Y6KvMy/Oob+oCEInAAhlST33tJkxVxqtY1tr+n8tVGJ
 d467BGXVe7NMafTfC4aKEP1KsjRsEApTdU3lZ2RU/VQBkwSXdmClhkK+vOpa5ixMJPLe
 oFLmvNEVFoyMtb7DwAmqYNJg0dWt8ooHji4th7ZIZSxYA2PzNwP2u/OMXsgHsIBLejPq
 8AcXoEMHCjv7bR9Foi3CDyMIdAsn3NGDYKe6I4lC7zDQu0+Dh/m8W7PrHC6JCVOKNLGj
 JxQmdn9JCOZWA7bSNXVZ4gboCQ/QnxyOqkRT/DcTa093fsD7lOvxKV1m67bpOXb678rp
 UPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781520634; x=1782125434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XQnKDUmeMi6ki8lCRaBDX4eBXYuzkjCC2EWJzcsXgik=;
 b=BcJSyZ6zLjs8Dt/iXTMLLxc+vZzlFbQ583ks/zTQ76Pd18Th0xoiycIs65xKSniCMD
 ET5P6DqOvj/KBZnMkmIG3hyVE3R9VknF95uTYfdft3tzTH6SqP6uHZ9wtse/EmxBSNOl
 3I4i+flfiTfJltNKLSnnsZWSdK7zc7tYUvpdhMUCYvzH1Nh7ahwkp7l6HS6HrnrQ42Ub
 aqxHAP0v0BGJe7EecAHleSNBlUre1wsaleUb3E48c7tMI+3k6Mat4scKe9Q6/fi13Lri
 A6/vVOZKiJKtigT45qnJnm0M32db3hrIy9P1MvieitbNSA0l2bJfftnd2dlWA4h3uxB5
 6EPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8diqkZ7p/bd+9klN/p3ZF7ug0Rhqo8BEPYM3+2rct1v08UfxiVZp+sQqrseOEOnpye5oUNLA+HddhO@nongnu.org
X-Gm-Message-State: AOJu0Yy8STUjD0YDegJTP7C8DiZuLZSJgm6XedrlkauYjbTK7zXxiloU
 Hp5zSIfVZMUTj6CQjvAQf8S7TYVl15C1Bi9qmcipAGhlCYLjPgWXd+/xepx/HAfFTo3uhVZx3X+
 Ec6+H
X-Gm-Gg: Acq92OGbUHkFNSBLG5+L4/xQk7HwkcFPrXFYIr/kSY75v/ZPBe2sLf5XyPJZQPX5Yda
 /bngRZ6+Rl03wTrgyEifN26Y4ve2nvR10bqL21nT3KoH5GRaTJ7yEnq8ZECAPQjkYvX/MwqrskY
 qZH14E8gTXamMEDipqsnQkzpeIep0qyGsgpD7NEjOislU/GUst9S6fL6AuUsTWuGtivzw5+gm4w
 4QCtftY6k1aJwnXhsRnu+TD7fhXqqFgzawYPSibYENKVoEyZ/GYAL1GgBt48POGANdYx67P1Vcd
 9rfvJyCRuFcQzRd8m3bO5DNezOms5U8Jj9e2uw4VNe07eYSfYS1r4H964HshFM9aTQ4ayATSo6+
 sPT6AHaRcVFbxuyYVDqHyseku9+1ofKKeYnA5Gbc8SrGY7ILIjKMxJyTvradjGLaMGOXAmcT1pI
 nbF/hKrHkInUpEL6ZCYCerqI4t02O0bJYEilrho4vZzzr7oFgLPq9HSE19+nTXqSJMcRKDlZqnA
 yD3BtMWfU0pZ0kDhCMOg1bSQooGYL4V+KX8TToiGAM=
X-Received: by 2002:a05:6000:2013:b0:45e:ea68:5237 with SMTP id
 ffacd0b85a97d-46074b81e48mr13869506f8f.11.1781520633814; 
 Mon, 15 Jun 2026 03:50:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm33863674f8f.8.2026.06.15.03.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 03:50:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/5] target/arm: GICv5 cpuif: Tag ICC_PPI_PRIORITYR<n> regs as
 ARM_CP_NO_RAW
Date: Mon, 15 Jun 2026 11:50:27 +0100
Message-ID: <20260615105029.2898872-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615105029.2898872-1-peter.maydell@linaro.org>
References: <20260615105029.2898872-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

The GICv5 system registers are all tagged with ARM_CP_NO_RAW, because
we don't want them to use the standard mechanisms for migration or
KVM state synchronization.  (GICv5 handling of both migration and KVM
support is a "will be implemented later" feature.) We missed this tag
on the ICC_PPI_PRIORITYR<n>_EL1 registers; add it.

Fixes: ef540c1d301 ("target/arm: GICv5 cpuif: Implement PPI priority registers")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 09c3fdda61..1aa4bde799 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -950,7 +950,7 @@ void define_gicv5_cpuif_regs(ARMCPU *cpu)
                 .name = name, .state = ARM_CP_STATE_AA64,
                 .opc0 = 3, .opc1 = 0, .crn = 12,
                 .crm = 14 + (i >> 3), .opc2 = i & 7,
-                .access = PL1_RW, .type = ARM_CP_IO,
+                .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
                 .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_priority[i]),
                 .writefn = gic_ppi_priority_write, .raw_writefn = raw_write,
             };
-- 
2.43.0


