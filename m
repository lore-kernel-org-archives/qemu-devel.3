Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFE6CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7ER-0002J8-Fd; Mon, 15 Jun 2026 09:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1wZ7EQ-0002IH-9K
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:20:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1wZ7EO-0003SH-Lt
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:20:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c0c35980fdso34489755ad.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1781529599; x=1782134399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6836T5/9ABy0QjxO3ZIoH9hu+UCUy16a/wZ/W/LKwY=;
 b=RgbNxsFX4PYUqZOpDJFZr0ZB+yfhHCaEhDa1TwjYKVFGyhyNFmQTD7g64A9D9f+FmP
 JgyFwQY8DimfESZmqwEVCnVoX3pYz+yVate+h0R/cyt6tjzMgAximwNDpJEBFw8y23Rl
 Nhfbdn+XM3Q8AKOxWifzNRKzVymXbVU+aNOp2siXQnj1bxNqc0gCXNkCOZXzH/MOC0Wx
 zjIBcqsz/iNB0aYVjhxH/oCJqKAstksj8nip2Xdefq9ytrH+ehwOOGGWUVqO/VXXRm0s
 nQ030p5Zo/+21P+5TObphrNudQlCZidLnbg+8ocSv3ZhNx3Z2G4U4rhy5b3ZTlH8V4eM
 LRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781529599; x=1782134399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z6836T5/9ABy0QjxO3ZIoH9hu+UCUy16a/wZ/W/LKwY=;
 b=qcs8sRkJOEW8l3kakAtgsTwiewcRqy04I2l7x1oKhy5VKKvntXveOQS2Dx2pj+yH+l
 9UxQ2IefTD+tjpqc3PhnfGEzBzYYfPgkDSoYzbywXgXy8WUsIXNrsyofdZr2c66BPuTh
 icx4eW+qEL4D86JGTdubKST0D6OjTsSXEuYc9c1QOOzLtYhA4PInuzNOEMbDWHqsJq2v
 piGF+4V9qHD/vOpXboCDr6uh/KLPDsCfOY7k1t8d6IEV3U+SLCxErccPCpyb6HXzL+nP
 +Els0FX6Ol+F+Lte4bipDfIc74ypMQCii1IF74xg/YSl8C7f9FGVqLBbluSr0LzfPmwm
 2aNA==
X-Gm-Message-State: AOJu0Yw2iIVUBbHSH0Wxj56Kt1Uq1gZN7kLGXpukyQUZKfhvpOgbP3+J
 bma4yEZcrWUxllXy4WSAbImLT7zThHO1k1YlB1iurUBDXK8g5jzN/goyKA6gi+G4TBQC8jgjJtO
 MecxJ
X-Gm-Gg: Acq92OHt4oKqE3pHA1PhpfPdDiz5yZQPTY81GvgqxYFH4m1ycnjNA4J+8cLcMyaxG5H
 4dyTx30KFrarSn25RdZxWB8dTAPCZ5l7G0RHqnoqntCrmk1+wPVBAqTDpuvL9sfdM2w2Gn840QC
 JoQ7bnm/Pvn6SYcYbkvCP5xQ9MHb8dsDHRvepdAjEAPwzHsq5FrHOKCrgyv5FW1+z1GBQ1bHb1r
 maX/RYk+dF8UzaKjuAMlNJHoNUnrtZnv3PiVn0eRhw+8Jhxgp4pv96ORF1NBN5+cyw8DU4FS99J
 NtKX8sqIJErp0Tp9TPD948qwVvB3JS0fHw3XgMjZd4vw63tOIE4FEPpsUUupxS9weLML9Ajb1NA
 qYn8ilePwyyajNa5r5o4NzEwa8y+/lI4u2Kq8QIM0HjofOcwA3Mv3YOSuPbtYTwNLAJGc9vVK1P
 SKe/5i/V6SDlJk/rq4iR0A8KplyfFLRdVIWEvvAyRTBg==
X-Received: by 2002:a17:902:e84a:b0:2ba:4ad9:70f6 with SMTP id
 d9443c01a7336-2c412d2854fmr169799505ad.31.1781529599158; 
 Mon, 15 Jun 2026 06:19:59 -0700 (PDT)
Received: from n37-012-226.byted.org ([115.190.40.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm101483565ad.55.2026.06.15.06.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 06:19:58 -0700 (PDT)
From: Qingwei Hu <qingwei.hu@bytedance.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jim.shu@sifive.com, nutty.liu@hotmail.com,
 Qingwei Hu <qingwei.hu@bytedance.com>
Subject: [PATCH v2 2/2] hw/intc: riscv_imsic: Skip reset for KVM irqchip
Date: Mon, 15 Jun 2026 21:19:25 +0800
Message-Id: <20260615131925.3019370-3-qingwei.hu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260615131925.3019370-1-qingwei.hu@bytedance.com>
References: <20260615131925.3019370-1-qingwei.hu@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=qingwei.hu@bytedance.com; helo=mail-pl1-x629.google.com
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

The emulated IMSIC state arrays are only allocated when QEMU handles
the interrupt controller state itself. With KVM AIA/APLIC-IMSIC, the
interrupt controller state is owned by the KVM in-kernel irqchip, so
these emulated state arrays are not allocated.

The IMSIC reset handler still clears those arrays unconditionally. This
makes qemu_system_reset(), which runs during machine creation,
dereference NULL pointers with -machine virt,aia=aplic-imsic and KVM.

Skip the emulated IMSIC reset path when the interrupt controller is
handled by KVM. The emulated path is unchanged for TCG and for
configurations that use QEMU emulation.

Fixes: 766391483b ("hw/intc: riscv_imsic: Add reset API to IMSIC")
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
---
 hw/intc/riscv_imsic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index ac59496c22..f1f23c3a3e 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -347,6 +347,10 @@ static void riscv_imsic_reset_enter(Object *obj, ResetType type)
     RISCVIMSICState *imsic = RISCV_IMSIC(obj);
     int i;
 
+    if (kvm_irqchip_in_kernel()) {
+        return;
+    }
+
     memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
     memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
 
-- 
2.47.3


