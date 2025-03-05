Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD577C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxl-0003Xh-Ts; Tue, 04 Mar 2025 20:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxj-0003W3-S2
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:19 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxi-0008Tw-3l
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:19 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22113560c57so118905275ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139656; x=1741744456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cnDsZ6O9ZtIfrPZ08I3SlUP4EkCO0c3KoTjhEdGuUI=;
 b=U/xgzq0rcgqUrjWhyt5NNK2EFqOMehRndbpBbIOI1kY+0kxWzfCO0Dt3E6pPohnrJv
 ACZE5h4V8qjsw/2IP49vUDy8PSMKZhubif6gxtjokGgeq1Dxix8jAt0FSpDYI/t+yQLT
 cfkUBTzThcw2mG+PeZ3pGoePs8+Bo2L0aKWkYDopw9m9jyHOlbsDkPoWboupmzcNyPzs
 mF0Q7BMkHvda9dYo1Ku7gAHapFSfS46hXhO5Powgo4hSDezR+Za4f1RDSJ+oHznEJyE1
 VNpwDFywUEwmmaDuBZXMZ8lVkh9SLHdTdHadSL9js82TCUv3Mtr66aXR5UM/77PayIJM
 iBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139656; x=1741744456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cnDsZ6O9ZtIfrPZ08I3SlUP4EkCO0c3KoTjhEdGuUI=;
 b=oidvkTsfb4J1AjFTbbYQ8n9TdEIp86d5TEn1RVfURSRp7VdGJsxQDlibtxKugvA7hm
 uB6w6NwPzSWMBY2KfP8yvTD6OcH8uH6jbm10x+ZG99d/C35SoxWPhJmXGtUxDmisCIkH
 6Oq56wUbCN540KJpFphTuyEisFhd9P0xOzVDDzNkTzIY3uNHddllhkmX6E/qDwMS7ZoH
 07WSPlc57B7KnGFDI6jWitXb8MdAMXQizDBKL1xg6Zrm7O1gSSjcX8QIqFWuDsODS8Zm
 fAA+KTxRUAP8JvW0voKsq8evDu+3l0bE3INW7pf6HXXuMDZb4O8ldtdr9vSEjSXDkT9V
 AGKg==
X-Gm-Message-State: AOJu0YxNP/wJPcl8u4mfutDKA76/qfzYJpzECzyu51DpaSHBI1tFcU+5
 qptClO4PI6uz9HPmjSmP00j4E9o2AX93OYfDakqAgICzABvY3pFNTakT8ULo3rs=
X-Gm-Gg: ASbGnct/jZhqSI9AhdTz3CCkpBd/cRdm6p1xXRgL1qNyhMoCNluDRw3P1inwmfsAHv1
 zIhlHRlFB9K3gC+5pgsrF8j1RZi47bYg8/pVH9t9oitAFBbSPR9Nc1FyBfcR7tRMhpGyBaydwvl
 9pZvvHPs3qhZ64mF6levbaTJuGkwVckAhCrPd1mQryrpNH8E6fRGDpRipQVIVcERGmg16IcNfZg
 g6Rqyu7UKYVl8pNE2EzVO6oIvJCy98XFlOsBrSMGskYKduHwJhpnTlCY3+pzm/HGSj7DSvYa8eq
 fu3OcCugBSA9JJW+dqv98vipEem6wd+Z9oQIP0QFEzvipkldSNiK9RXUg0yI7Te0sWY1POATAU/
 9C2eoBgHQe3gCZQekLIfiJCt1Psmj6ZjX2H6BlYXW24M2O3FQAYs=
X-Google-Smtp-Source: AGHT+IGjcHdILQk+eWMxRqeLOEMROLjhpD2JtvEjT7Ysa/ULNCtgyJeGJjhO0A7dtmIhGtwT/5/3LQ==
X-Received: by 2002:a17:902:c406:b0:215:9642:4d7a with SMTP id
 d9443c01a7336-223f1ba4773mr20529985ad.0.1741139656460; 
 Tue, 04 Mar 2025 17:54:16 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:15 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 21/59] MAINTAINERS: Remove Bin Meng from RISC-V maintainers
Date: Wed,  5 Mar 2025 11:52:29 +1000
Message-ID: <20250305015307.1463560-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Alistair Francis <alistair23@gmail.com>

Bin Meng has been a long time contributor and maintainer for QEMU RISC-V
and has been very beneficial to the RISC-V ecosystem.

Unfortunately his email has started to bounce so this patch is removing
them from MAINTAINERS. If in the future Bin Meng wants to return we will
happily re-add them.

Note that I'm not removing Bin Meng as a "SD (Secure Card)" maintainer.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250128060546.1374394-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e7fc6fa91..433cf66e8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -319,7 +319,6 @@ F: tests/functional/test_ppc_74xx.py
 RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
-M: Bin Meng <bmeng.cn@gmail.com>
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
@@ -1618,7 +1617,6 @@ F: include/hw/riscv/opentitan.h
 F: include/hw/*/ibex_*.h
 
 Microchip PolarFire SoC Icicle Kit
-M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
@@ -1645,7 +1643,6 @@ F: include/hw/char/shakti_uart.h
 
 SiFive Machines
 M: Alistair Francis <Alistair.Francis@wdc.com>
-M: Bin Meng <bmeng.cn@gmail.com>
 M: Palmer Dabbelt <palmer@dabbelt.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -3747,7 +3744,7 @@ S: Orphan
 F: hw/i386/amd_iommu.?
 
 OpenSBI Firmware
-M: Bin Meng <bmeng.cn@gmail.com>
+L: qemu-riscv@nongnu.org
 S: Supported
 F: pc-bios/opensbi-*
 F: .gitlab-ci.d/opensbi.yml
-- 
2.48.1


