Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D8BC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XwZ-0004Sv-87; Wed, 23 Apr 2025 07:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwO-0004Np-Dq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:06:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwM-0000Lm-Fw
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:06:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2260c91576aso53863605ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745406411; x=1746011211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYCFXEMOiDwtpCz9IBOk6xfq5jbJwwkBz5cOXQbM8AA=;
 b=oPtYDOTONj/l0Oxf8jbH7jsvVl6+WaNvSESWTgKj1QQrIQ5C1Q2xgMUIb8fkVQdq4Z
 0nrMRTw5LaeipRc/7FECfQX+xkarSHAbeBW0ugoXeNY3MFGvSZwy3JTdLzoDNZpxMeo5
 w9QdGMQ0Xq5WLR4zxFMES3pXX5uYlqi8LY62W1FvC1YbClXFfk7XbDnolDHR8qexrFiJ
 r+DE+Iot0VJnr87TnHgLg91F6SyvZBCV8+oq8vODaXredsdDcE+iE1dDZErAoWBG2ajg
 mM8ZoaNDWGudpfaZ/ae/hv10XRLRpuDW+R1ur7K0M2Ts2QqDamfQ78BLL9mYMP7ETPbx
 P2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406411; x=1746011211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYCFXEMOiDwtpCz9IBOk6xfq5jbJwwkBz5cOXQbM8AA=;
 b=REG2ezwpA0Dz4wTJ4nFSMVJwafYRUlmCy//Ew3gpjdi/qomAeTcdpmgM+tbEOtvSit
 TPX7yigWF8OFZbOxmXcEuGecW7fZtFfnWVyqqu7d23TmIwYLqznHLTD/eyyIDrLOKyjF
 Nb6vcc8do/+liRWO3xLXK8InbRFw1QcHUWLnJnvK3Nu2MPGRLgu6jFXBZtO2kvtz1kLX
 vT0xoENa0XLdcVUrSuP/gn+h7smXsQ6FypcBePwyr7nzarjIYXd1YlAXRKZpMnr02ZdR
 NwFmH4gdD39U6tjNRECyVokp35w4PCUfDrjxrwJPfz5dOW007Zl7/1UrRNFNZQO+ykqh
 EeIA==
X-Gm-Message-State: AOJu0Yyn8lM9mXugJ22XAVmsgrw9lYvCbxCmAyAHv3J/MW1q7bq5QWX2
 spO6H8nM0c860cVbq1yxxqYuvQsqTPzpJMCzTd7qmGLKW0vrulJbMK1yVsRZ8kAmW4Z3HU3w/Qz
 2
X-Gm-Gg: ASbGncuMXPgI0wWY4cKAhTJS0rJ+x9FrVHBAfBELy/6m1An/jg3tGdaD8jAyNlKBaX7
 Q2oqfoeUwUC1UaqirdPqWfeGJiUAeVlwVczldtlGembkzO7vPG7+zpZQ0HcNJcuVTidfZqQaqC/
 32GIgQrGSr6UTMiwWZ1dk7I+EVk6HuUmHr6ByO373E6e6jwkNjQvohF8Nk6Uj11a8//Qbvyu35P
 RJiRDSBNFTy4X1f12vOByv3lT4MbT7nrTr559YefC8g5KNEwWGVB63bHa177exNWhUkgm0qoLSW
 Vs2VIENCdp0tIO7A7zN53fKkn6UiOmGZ6mfvbVA9lOdjrUsVlzHCJx2yxABTyzM=
X-Google-Smtp-Source: AGHT+IHh3twLKgbjwZedKi9BrZQqbESwav1b3IoIC2S5u8ee7MTQAbGBTtovpkoYOSZBiWt0GmI8xQ==
X-Received: by 2002:a17:903:11c5:b0:221:85:f384 with SMTP id
 d9443c01a7336-22c5359c36cmr260513425ad.16.1745406411477; 
 Wed, 23 Apr 2025 04:06:51 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bcc0:89f4:3b90:a265:963d:8357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf3b1sm101509895ad.248.2025.04.23.04.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 04:06:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 4/9] hw/riscv/virt.c: add 'base' arg in create_fw_cfg()
Date: Wed, 23 Apr 2025 08:06:25 -0300
Message-ID: <20250423110630.2249904-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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

The function can receive the value via s->memmap[VIRT_FW_CFG].base from
the caller, avoiding the use of virt_memmap.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 473416bcf3..77ebb517f2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1262,9 +1262,8 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     return dev;
 }
 
-static FWCfgState *create_fw_cfg(const MachineState *ms)
+static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
-    hwaddr base = virt_memmap[VIRT_FW_CFG].base;
     FWCfgState *fw_cfg;
 
     fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16,
@@ -1682,7 +1681,7 @@ static void virt_machine_init(MachineState *machine)
      * Init fw_cfg. Must be done before riscv_load_fdt, otherwise the
      * device tree cannot be altered and we get FDT_ERR_NOSPACE.
      */
-    s->fw_cfg = create_fw_cfg(machine);
+    s->fw_cfg = create_fw_cfg(machine, s->memmap[VIRT_FW_CFG].base);
     rom_set_fw(s->fw_cfg);
 
     /* SiFive Test MMIO device */
-- 
2.49.0


