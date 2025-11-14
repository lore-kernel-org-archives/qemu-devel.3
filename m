Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2E1CE8D4C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJwAS-00070A-7K; Fri, 14 Nov 2025 10:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJw6t-000415-25
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:53:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJw6q-0006vo-HR
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:53:14 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so3913025e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763135586; x=1763740386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kn5c0rFEEizBXTC7aBt1xGr5YfY0on2lsv1lAacChqM=;
 b=dTUu7pPY/dHtwkP1CY47WN4+Jc5srFE/sFq7XdOoCY65cscG0hdAsZSE5I1D4cfDrU
 W2W4baVXN9qnQZqlg84CPMt+a+QupIpqx53VkywOSj2Y9wTiGpElXBL1Z6pzyyrGlxAg
 R9T/+lebmS3LHlnDkLWK8knP+zFZj6AbMeJ1YqgpSapZg79T8uvPvxYKWOtTr/Mrt0ei
 1DANZgXujm8yjMNrSEyFIX5jHENdQUc81cer2xwffR8AGlae2ch51ope7fDRVJnBCutb
 sRq+yLkLFlb/laD2+sEdUKkGU2myZqreaChXQAsBfz7giqkOzC5t54lkPxR5r0ZL7K7N
 za7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763135586; x=1763740386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kn5c0rFEEizBXTC7aBt1xGr5YfY0on2lsv1lAacChqM=;
 b=ij7AiUDNnrFTLp1NAKJuWrcgQdz66Xe6xXIMJeWvRlERkRTaqYnU0ue4EnWKPLljbb
 7CgJFRhuJNRBE+jk1uo6T8X6g4N5KV0OCuhrm+868DI2Qt6bTeLKfdG8g3ha0v3DU/Zz
 gTJKk8pP5P8WSCSRISowzTXc0tCfkKxCflkXmEeOcXJ11PvZnDgylA/ATIDamDDnyLcU
 Y1wQMOZx5kgbXV9wLcc2pSNY2uXH9cUOMq93iH3QCTg0PNcc2KdoEaAWv25St0XYt72m
 m/12ogEzS+owXxUJCwhaizsUGMEgPGptew3YsKiVP7MJ5CUJtwuj25Rz93XMkm2PWeg4
 dakQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/PoEFEfsOxLTlbAU5Gfh2WN2ZSZqzpCZ3Aic+0m74vKUNgrLr1u1AddyV+vxD6PFzXBMAHRp9NCeF@nongnu.org
X-Gm-Message-State: AOJu0YwO/Kfm97xRpNdmGPo1T9JBX/dBhc4Qp7wxBXuHYwzJrwu2mzHq
 0NSsbZ1rkknykAEoSn0Ajw6mEVkoYf+ZeV/nXVZynbfHtQJUH8ifMSZ2GyCajJG/TRJ7d+jk6BU
 sHG8L
X-Gm-Gg: ASbGncuYTqB464UXWNGAenLJP5eh8mMLNI3D5s5BhHN3vlsvEXvYUm9lXbo5iXGbirK
 o45LY3ggAawYQFepKBV1rkBNgEj5tdyJv6evhZZSApnjwmspVBNNmOdWaGbK+MEgqDtDjQWP/Yq
 xO5pezpdZ/k5NUAMjunC895s0MItjLG0P+gJOM7vaPSnsI4VMCFpwByK9v/WSoX2OzWeYOlRXAo
 cEh/GtGMyLLOTa3Z8Jg83RuL+WVCw9DkZHetYIWBpM6WO7H7upegEOh3/CxO3drFzczXokBlb/g
 yMTR8oWxz0BWH5KhNBJiARWRBWyL29BIgaghoRCBsEIagWIrxCRSglIX6hNGz7kfBwNpjELshXu
 pg36GPRP65K8At8icqvQyMirbzgGvHLHNeEol8lsBmBC/+8Iz6ExADfvbrfoZ1PnToowglH1o47
 r+Cd6ycLmqh0vr/gmf
X-Google-Smtp-Source: AGHT+IGs0TJ80FYcSwpn5Sku4gNGj5g6O//GcMj042qkRvnDaVMJtkuYUOWsHvzn1yGXifckHElqFA==
X-Received: by 2002:a05:600c:6288:b0:46e:4a60:ea2c with SMTP id
 5b1f17b1804b1-4778feb83eemr32865315e9.37.1763135586228; 
 Fri, 14 Nov 2025 07:53:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19aa0sm10502645f8f.37.2025.11.14.07.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:53:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/armv7m: Disable reentrancy guard for v7m_sysreg_ns_ops
 MRs
Date: Fri, 14 Nov 2025 15:53:04 +0000
Message-ID: <20251114155304.2662414-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

For M-profile cores which support TrustZone, there are some memory
areas which are "NS aliases" -- a Secure access to these addresses
really performs an NS access to a different part of the device.  We
implement these using MemoryRegionOps read and write functions which
pass the access on with adjusted attributes using
memory_region_dispatch_read() and memory_region_dispatch_write().

Since the MR we are dispatching to is owned by the same device that
owns the NS-alias MR (the TYPE_ARMV7M container object), this trips
the reentrancy-guard that is applied by access_with_adjusted_size().

Mark the NS alias MemoryRegions as disable_reentrancy_guard; this is
safe because v7m_sysreg_ns_read() and v7m_sysreg_ns_write() do not
touch any of the device's state.  (Any further reentrancy attempts by
the underlying MR will still be caught.)

Without this fix, an attempt to read from an address like 0xe002e010,
which is a register in the NS systick alias, will fail and provoke

 qemu-system-arm: warning: Blocked re-entrant IO on MemoryRegion: v7m_systick at addr: 0x0

We didn't notice this earlier because almost all code accesses
the registers and systick via the non-alias addresses; the NS
aliases are only need for the rarer case of Secure code that needs
to manage the NS timer or system state on behalf of NS code.

Note that although the v7m_systick_ops read and write functions
also call memory_region_dispatch_{read,write}, this MR does not
need to have the reentrancy-guard disabled because the underlying
MR that it forwards to is owned by a different device (the
TYPE_SYSTICK timer device).

Reported via a stackoverflow question:
https://stackoverflow.com/questions/79808107/what-this-error-is-even-about-qemu-system-arm-warning-blocked-re-entrant-io

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armv7m.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index c4a9c3ac529..7fa1b37630e 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -442,6 +442,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
                               &v7m_sysreg_ns_ops,
                               sysbus_mmio_get_region(sbd, 0),
                               "nvic_sysregs_ns", 0x1000);
+        /*
+         * This MR calls memory_region_dispatch_read/write to access the
+         * real region for the NVIC sysregs (which is also owned by this
+         * device), so reentrancy through here is expected and safe.
+         */
+        s->sysreg_ns_mem.disable_reentrancy_guard = true;
         memory_region_add_subregion(&s->container, 0xe002e000,
                                     &s->sysreg_ns_mem);
     }
@@ -499,6 +505,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         memory_region_init_io(&s->systick_ns_mem, OBJECT(s),
                               &v7m_sysreg_ns_ops, &s->systickmem,
                               "v7m_systick_ns", 0xe0);
+        /*
+         * This MR calls memory_region_dispatch_read/write to access the
+         * real region for the systick regs (which is also owned by this
+         * device), so reentrancy through here is expected and safe.
+         */
+        s->systick_ns_mem.disable_reentrancy_guard = true;
         memory_region_add_subregion_overlap(&s->container, 0xe002e010,
                                             &s->systick_ns_mem, 1);
     }
-- 
2.43.0


