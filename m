Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAD8CFC286
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0eww-0006m2-Kd; Tue, 15 Oct 2024 06:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewd-0006hY-6G
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewb-00060j-Gk
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:26 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d447de11dso3774093f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988704; x=1729593504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WcnOseKPBBkqKB9v4L2sxhPAaeMRLCa8ZCiDWul1LqE=;
 b=wc9Y43OQfe1TnNAw15DAykMaCEb9Zg1zNyjliqYSUQKKBSpjVqPcoKUe/tm1NqFyPn
 wtBwUJE61AdyeEBRVADG+RZ90AKq6sC30VVUt744IriIyRqLgbNxSlAQLJYLd3RIRxTF
 yOPDbaukYZitXe9lz2QQQbT03R+6ZivaphN2rVFH1Zfvn698SK8qSmaoLZxJ4Qi1clIg
 pKkoyxjRv37pyro8AjlGfdoubsPqnsi9wD9/kcgqcCLBiMQD99QwkODiQYHWz/A9bcn7
 qY8xSiSFuqyRHDN7so2A193mTJK7gpIqWlYw5iclDFANVs2fCHw1XX2lgj5DjvXMoQhC
 iK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988704; x=1729593504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WcnOseKPBBkqKB9v4L2sxhPAaeMRLCa8ZCiDWul1LqE=;
 b=nvzifC20poQ/WSzCT0+cNNGHo8Z1aHEnxjGW3MeOlaLt8niAos9j8Vq5g+9Avg2mh2
 xM3KpDh2qzf26IQoxKunEBOmxGiAArKSuD0lCyXr+SnvFDdQac2qajSahMtY6YAwGbcQ
 BpH0q1YgxXfHAEXC4ljnx8PocZx0P4HoiPQ6oLMmbB2SuiSqgeIzQvk2WVEIRoX7Zsgw
 R7soC9iEhdpqRCYOvAU76H8O5gqBa7bkSQYzXoHXNDEd7lbMlr7xr4n7Iibp8bKBl22w
 sOz2gjUNiXaUKEwKRHGseRU+vyIpCN/CUA4MRhQj1jHeNSrrv3I43XBPRV4zgtqhfAjn
 /YJg==
X-Gm-Message-State: AOJu0YyOcmtzb3Pr1XdQQG20jvN1JC785Lg8ytceN7yDNcP/PPp4ZFmS
 d1cYdO3Ux5QEzYQ6gFzd0hhM0YnjoeQqX2SR8IclpJU/n3Tjb0Hm9CDu/aUqpV6ILTkAsGijMGk
 t
X-Google-Smtp-Source: AGHT+IFs2saMt4dUcZNcEIXeEbGSxRscNWypZWOv1b7agQ14m8wA5PZPzzpnu/6SZYa8GCQcT3jm4Q==
X-Received: by 2002:a05:6000:181a:b0:37c:cd1d:b87e with SMTP id
 ffacd0b85a97d-37d551d50a7mr10101654f8f.18.1728988703630; 
 Tue, 15 Oct 2024 03:38:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/28] hw/arm/xilinx_zynq: Add various missing unimplemented
 devices
Date: Tue, 15 Oct 2024 11:38:08 +0100
Message-Id: <20241015103808.133024-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Chao Liu <chao.liu@yeah.net>

Add unimplemented-device blocks to the xilinx_zynq board
corresponding to various devices documented in the TRM
and in the device tree.

See: ug585-Zynq-7000-TRM manual B.3 (Module Summary)

Signed-off-by: Chao Liu <chao.liu@yeah.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message. Removed the clearing of
 the ignore_memory_transaction_failures flag]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 37c234f5aba..fde4d946b7c 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -34,6 +34,7 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
 #include "sysemu/reset.h"
 #include "qom/object.h"
 #include "exec/tswap.h"
@@ -373,6 +374,75 @@ static void zynq_init(MachineState *machine)
     sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
     sysbus_mmio_map(busdev, 0, 0xF8007000);
 
+    /*
+     * Refer to the ug585-Zynq-7000-TRM manual B.3 (Module Summary) and
+     * the zynq-7000.dtsi. Add placeholders for unimplemented devices.
+     */
+    create_unimplemented_device("zynq.i2c0", 0xE0004000, 4 * KiB);
+    create_unimplemented_device("zynq.i2c1", 0xE0005000, 4 * KiB);
+    create_unimplemented_device("zynq.can0", 0xE0008000, 4 * KiB);
+    create_unimplemented_device("zynq.can1", 0xE0009000, 4 * KiB);
+    create_unimplemented_device("zynq.gpio", 0xE000A000, 4 * KiB);
+    create_unimplemented_device("zynq.smcc", 0xE000E000, 4 * KiB);
+
+    /* Direct Memory Access Controller, PL330, Non-Secure Mode */
+    create_unimplemented_device("zynq.dma_ns", 0xF8004000, 4 * KiB);
+
+    /* System Watchdog Timer Registers */
+    create_unimplemented_device("zynq.swdt", 0xF8005000, 4 * KiB);
+
+    /* DDR memory controller */
+    create_unimplemented_device("zynq.ddrc", 0xF8006000, 4 * KiB);
+
+    /* AXI_HP Interface (AFI) */
+    create_unimplemented_device("zynq.axi_hp0", 0xF8008000, 0x28);
+    create_unimplemented_device("zynq.axi_hp1", 0xF8009000, 0x28);
+    create_unimplemented_device("zynq.axi_hp2", 0xF800A000, 0x28);
+    create_unimplemented_device("zynq.axi_hp3", 0xF800B000, 0x28);
+
+    create_unimplemented_device("zynq.efuse", 0xF800d000, 0x20);
+
+    /* Embedded Trace Buffer */
+    create_unimplemented_device("zynq.etb", 0xF8801000, 4 * KiB);
+
+    /* Cross Trigger Interface, ETB and TPIU */
+    create_unimplemented_device("zynq.cti_etb_tpiu", 0xF8802000, 4 * KiB);
+
+    /* Trace Port Interface Unit */
+    create_unimplemented_device("zynq.tpiu", 0xF8803000, 4 * KiB);
+
+    /* CoreSight Trace Funnel */
+    create_unimplemented_device("zynq.funnel", 0xF8804000, 4 * KiB);
+
+    /* Instrumentation Trace Macrocell */
+    create_unimplemented_device("zynq.itm", 0xF8805000, 4 * KiB);
+
+    /* Cross Trigger Interface, FTM */
+    create_unimplemented_device("zynq.cti_ftm", 0xF8809000, 4 * KiB);
+
+    /* Fabric Trace Macrocell */
+    create_unimplemented_device("zynq.ftm", 0xF880B000, 4 * KiB);
+
+    /* Cortex A9 Performance Monitoring Unit, CPU */
+    create_unimplemented_device("cortex-a9.pmu0", 0xF8891000, 4 * KiB);
+    create_unimplemented_device("cortex-a9.pmu1", 0xF8893000, 4 * KiB);
+
+    /* Cross Trigger Interface, CPU */
+    create_unimplemented_device("zynq.cpu_cti0", 0xF8898000, 4 * KiB);
+    create_unimplemented_device("zynq.cpu_cti1", 0xF8899000, 4 * KiB);
+
+    /* CoreSight PTM-A9, CPU */
+    create_unimplemented_device("cortex-a9.ptm0", 0xF889c000, 4 * KiB);
+    create_unimplemented_device("cortex-a9.ptm1", 0xF889d000, 4 * KiB);
+
+    /* AMBA NIC301 TrustZone */
+    create_unimplemented_device("zynq.trustZone", 0xF8900000, 0x20);
+
+    /* AMBA Network Interconnect Advanced Quality of Service (QoS-301) */
+    create_unimplemented_device("zynq.qos301_cpu", 0xF8946000, 0x130);
+    create_unimplemented_device("zynq.qos301_dmac", 0xF8947000, 0x130);
+    create_unimplemented_device("zynq.qos301_iou", 0xF8948000, 0x130);
+
     zynq_binfo.ram_size = machine->ram_size;
     zynq_binfo.board_id = 0xd32;
     zynq_binfo.loader_start = 0;
-- 
2.34.1


