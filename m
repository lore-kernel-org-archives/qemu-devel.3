Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC462C54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogy8-0005K5-8Y; Tue, 28 Jul 2026 08:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy5-0005IS-SU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy3-0002yc-Vb
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso21940115e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241890; x=1785846690; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HjzRm4/vAf36krK1NQLIMmFfWZ78E2Nswa/LRXVgusY=;
 b=IqObXCHQkf+cr8mvRm0Tkk0H6ZxgvRpAS4XS3xDoc/UjRv9V3G1ir5g6XHhRou8bJq
 fL+UcqT1d4DqoMUBXLyU5LzJ5T1K3yLbNK2kSB8VA/4EXQzrtvxcAjZPnRMLWHYZdD9q
 UYuTI++6zBEnVraZ721/OL6AU+uKabWorTS4OIu/RoKPLUmSKcPplsIxuT+t9tg5OhZl
 AsEPlTsgSsXO6N9lI96uENBEHPgTcym5K6FH1Rpt+gUYEykCa8K3AwOfJeIrmemCyBqg
 X+FSuRvpGGDcOrBP5+hjoc0GzHMlU8aWzP9UGVTx0lDVopKvFrRCc783qxKWSwvJSrTF
 6pjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241890; x=1785846690;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HjzRm4/vAf36krK1NQLIMmFfWZ78E2Nswa/LRXVgusY=;
 b=IwmDiMo2tslV/LW/sX3uSYii3Vwdj2AOilevGZCDucej5KqOctj6p8Gn++JCRH08zX
 Vj8do4xB7ULvdQlZvdpGa4O3EbUy7pxsjhuI8HYHeVRX/sxd/znwLQybY5ViEsSueyKM
 O1JbrngBw7ocHpwZbi+YixiOYhDpEKqik2Ak/E2X6/51G21VGoVZZQ0cdmCNEz24fBVW
 4dV5ToMYA4Wv4OLFILLGCJY0Sj12jG5R2HIneQ6Yka4x4SXBPtt/Rq3TRfXde221Q/MA
 y7yAXWkXRpJqvp6b5DmzS9v7SakowQfYVQ1kOzEY5F5NZ26IhN2xuLcEnP7LyWkjOgGB
 plDA==
X-Gm-Message-State: AOJu0Yx32l18Jsy2L3W+KmrYtdQfVUZLAPwSHFWYfs7hy00YmAeGZ7Hu
 qDqYLMpUI9XkbSzW0vrZmepr+91GEm5GcauiQDvv8v5LkneAnHW9ArODOyNk75KDdGP8DNh8Rpy
 OM34Y
X-Gm-Gg: AR+sD12ZeMmYn6CnkK3vKVSWpeUI2YjvBdindcYYW7PS3JW1vdaJYYVWNjomwJsGN2U
 FRylglcBYdJwzAOE/xK3Ns4ugRwRwZ2KwBrCvNjD8WQaaFPJJ4efNIHI7JQXKWbSqdmP2hCXFEw
 lCBGchmz37Fmlkx2N8TNEYlxuf0qTbObQ6Esb+eHmTQpyj27AnVqLCklvkG4L8SDU3g+dtkRTLZ
 LFdrAVHZ1Wn6qS2bZIhRhtQY2/A53Sc985gClilKLCuclLHaMIuH1w+RSZksijQR47UC/SQVidE
 AeKRFzBVMZHRamiMMO5p5kBqK3JVV98La0yBlR+uohJWaFqVbLr1pmYOmmXy+xokLoOopZ4fdHm
 i7D2ZRfBPX4WmntTmNz+F5yyknzNyT9hxfiP4jR28P3URW637Fgj1fCm4fkRaNNBBV1rkp7BVxS
 3eSvlbEBIEj48SSRR4MdRnko4CyCacOYVHfgyVgPskxv19G8tCqw8l3HRds75EsGWzrGweOKSzu
 z3/7DqC+b4=
X-Received: by 2002:a05:600c:1d06:b0:494:282:106c with SMTP id
 5b1f17b1804b1-496c643562amr23677735e9.16.1785241889895; 
 Tue, 28 Jul 2026 05:31:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM /
 WHPX
Date: Tue, 28 Jul 2026 13:31:08 +0100
Message-ID: <20260728123127.1711653-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

KVM and WHPX GICv3 implementations call gicv3_init_irqs_and_mmio()
which is defined in arm_gicv3_common.c, itself build when ARM_GIC
is selected. Both KVM and WHPX are conditional on ARM_GICV3,
itself selecting ARM_GIC. Only build the ARM_GICV3 accelerator
variants when ARM_GICV3 is selected.

 $ git grep -w gicv3_init_irqs_and_mmio
 hw/intc/arm_gicv3_common.c:314:void gicv3_init_irqs_and_mmio(GICv3State *s,
 hw/intc/arm_gicv3.c:450:    gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops);
 hw/intc/arm_gicv3_hvf.c:710:    gicv3_init_irqs_and_mmio(s, hvf_gicv3_set_irq, NULL);
 hw/intc/arm_gicv3_kvm.c:822:    gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
 hw/intc/arm_gicv3_whpx.c:186:    gicv3_init_irqs_and_mmio(s, whpx_gicv3_set_irq, NULL);

Fixes: a7bf30342e6 ("hw/intc: Initial implementation of vGICv3")
Fixes: e4c95f78a47 ("hw, target, accel: whpx: change apic_in_platform to kernel_irqchip")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260721122135.6288-2-philmd@oss.qualcomm.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index fac2d228f9b..377de78bb41 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -45,10 +45,10 @@ specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
-specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
+specific_ss.add(when: ['CONFIG_WHPX', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_whpx.c'))
 specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
 stub_ss.add(files('arm_gicv3_hvf_stub.c'))
-specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
+specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
 specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
-- 
2.43.0


