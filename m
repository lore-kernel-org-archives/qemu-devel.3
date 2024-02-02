Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8531C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb5-0000Ne-SO; Fri, 02 Feb 2024 10:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb2-0000Ki-9H
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:52 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb0-0004U8-0x
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40fcb6ebe24so2834195e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888208; x=1707493008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jj7yEf/jq38/qH2Zq0rzNEWtL5ZZjFFsH6Lpx3bxpek=;
 b=nZqv9uTCEnwzlMEPDdDaXXH101OjPynvx267T6CZ83r3icjppsH5p+6gKWmWmkwefy
 Ad/RmRCpCJLmnzXN/+ArC2BdXb32qqyXjZ/KZbVYE3zd/cirq+wcGRxoq7zZu1ONU5gt
 Iz3irEh9SX67zKPdLK6/ttom7j8VjWbXKCNWUeuPFtqd17SdSUhAMVrOzhpskhBjLeQM
 MQ4fYw/piPQEK0PClTIM9xd55P2bnzvS7fVefh9Byp1kh/dycReaC2Xcl2hYf5ENRspV
 imxrpCeCus4s6wl5tm0qq/Gf69Kn6sog3LDRnubW0kg3KgMFroAGGuzTcbi3g9Z0rYy5
 cJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888208; x=1707493008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jj7yEf/jq38/qH2Zq0rzNEWtL5ZZjFFsH6Lpx3bxpek=;
 b=XTJoPIt4XgrhcvRd44rEFsJMwyYrUQW47Y3JwPkCLMM5KVXD0TcmzXaP9U6FUEcn61
 Ru480OBfeJiT3vvN6P6FgMIeNCzF8c2UG9Kvj60Ps1HYelXaO+YPHW+xIfCY/Awl/KlH
 zHW9iIXh2/G8VVQI1QMHQBRzhrBkwleJoh+EiRHOpBiV2ARa82ZCqCf2uyaBMjZ8/Pci
 t8tCsqs9jvV/kuFyxLT0ACzXK67VnZ7WfC1Dg23FvsNCUo16ImXLq7TeeiV0tm6hbN0k
 Krt8RWuFW+h2MjTQgoDC7hOaC3LN66mYskkXMKU4VcL7qoSysIGp5Dow4dRtt/ShpH4k
 sE7A==
X-Gm-Message-State: AOJu0Yz/ToIg5tDqCyZZi/JSkgLbwfCLUDW6496Qz/facFxNZW1Hko/A
 bjT+iKWIsziOUfk6Vn6U7m0x9wVZxnvvyHNSb5NRYSgw1vkiTB2Hzyi04GlhBwxHwamqcp8X6Ry
 E
X-Google-Smtp-Source: AGHT+IFxg5kW0RSP+MWlEbr/HQpDhGPLMlQ16KyNGN2nxCaRhEqBj518ti/FcL6pq0bGufBUO14dhA==
X-Received: by 2002:a05:600c:19c9:b0:40e:a0a3:f358 with SMTP id
 u9-20020a05600c19c900b0040ea0a3f358mr6149061wmq.22.1706888208356; 
 Fri, 02 Feb 2024 07:36:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/36] hw/arm/zynq: Check for CPU types in
 machine_run_board_init()
Date: Fri,  2 Feb 2024 15:36:22 +0000
Message-Id: <20240202153637.3710444-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Leverage the common code introduced in commit c9cf636d48 ("machine:
Add a valid_cpu_types property") to check for the single valid CPU
type. Remove the now unused MachineClass::default_cpu_type field.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240129151828.59544-10-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 66d0de139f2..c57bbccb70f 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -355,13 +355,17 @@ static void zynq_init(MachineState *machine)
 
 static void zynq_machine_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = 1;
     mc->no_sdcard = 1;
     mc->ignore_memory_transaction_failures = true;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
 }
 
-- 
2.34.1


