Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9741FC27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWG-0007vl-Uy; Sat, 22 Jun 2024 08:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW7-0007kg-RQ
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW4-0000JO-On
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-362b32fbb3bso1973550f8f.2
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058007; x=1719662807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=azdAp+TG1VIrt8vW4aIFwdtaw2axsecfAU0t9ommjDQ=;
 b=fe/sJd00w6WZoe3L+ZqeiSeHHiL4/XjmzNua9iKzYSN/zjAaOELw+ncxqjy03Ov10u
 PbbbN+xvYH9/8iUn8q7EcBL3WL53mi7vI5c4ePGk29fCgEFj44hgxw2AQIatpl3ho7R3
 3U2N9XcyUMH/MQwRVCTiHfuM+R3OsSdElP/5qG16FdFpFZTBciKLacBpKIoIS3nqEBIo
 I88/uYxe5RfQvt2hN1h69LIPAs5oeVuC7UTT9vsiztSAHsBtj/L9gm8Nfo3CFXqBlHo/
 orwNOOtkR2r3KRS9fIjzQxc/C6OOnft4UIaaXNNwwtzrFalB92jaQonN0cxNkOGwaIAR
 0MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058007; x=1719662807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=azdAp+TG1VIrt8vW4aIFwdtaw2axsecfAU0t9ommjDQ=;
 b=QsJyOJnvs5EIsr4WFQ0ifKe40eUCNNwCwJIRnX4mj4okVi0RDzVLuRQ99Vcf2RjJK9
 Segn1jdlaCo3aUAkwk2GyjJURxN814FW9Y8OBOKp5soS79J5svoNH4ARjObTRp/GfmT2
 Ndxqd+FlCE/vVMte/zywVHFXDwRx8xL1DxWrYsXroF+W6/STmtW9e0oefC2W6yYzSfAa
 5MIX+F6oLHz48Np1DtitjNiq09bGaodovjD1OSQEmPka2FgMK/B9Gb8sqNZNrrKicilI
 B98UC14xt1GSsFQhbBIydlBZ0TYFOW3JjnXcXyuK+3nx60h2bHLPSs15S1wnFvNtxwhx
 b3iw==
X-Gm-Message-State: AOJu0YxhYjbaaj1cEsnN0jlI825XfOqRYqdMbGGT6KE7qZ0jpCdmPTGQ
 U/BdGFl2/eAZsRlgWCrGs9UgJ3DqCUurg3Gd2ywQMM4wNxFX6zG9TemqDw7BKL5qMHEAgoM2tex
 oqjM=
X-Google-Smtp-Source: AGHT+IF/CpnDyouPRGM3H4ujTJ4PcLUGBQJa5HieelbmPV71js6ArmKpsvzXlNYwKmcbjEOzm3DVUQ==
X-Received: by 2002:a05:6000:10d:b0:35f:2f3b:ba90 with SMTP id
 ffacd0b85a97d-366e7a1955amr247498f8f.18.1719058007260; 
 Sat, 22 Jun 2024 05:06:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/18] hw/arm/xilinx_zynq: Fix IRQ/FIQ routing
Date: Sat, 22 Jun 2024 13:06:29 +0100
Message-Id: <20240622120643.3797539-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

Fix the system bus interrupt line to CPU core assignment.

Fixes: ddcf58e044ce0 ("hw/arm/xilinx_zynq: Support up to two CPU cores")
Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240610052906.4432-1-sebastian.huber@embedded-brains.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 7f7a3d23fbe..c79661bbc1b 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -252,10 +252,11 @@ static void zynq_init(MachineState *machine)
     zynq_binfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
     sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
     for (n = 0; n < smp_cpus; n++) {
+        /* See "hw/intc/arm_gic.h" for the IRQ line association */
         DeviceState *cpudev = DEVICE(zynq_machine->cpu[n]);
-        sysbus_connect_irq(busdev, (2 * n) + 0,
+        sysbus_connect_irq(busdev, n,
                            qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(busdev, (2 * n) + 1,
+        sysbus_connect_irq(busdev, smp_cpus + n,
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
     }
 
-- 
2.34.1


