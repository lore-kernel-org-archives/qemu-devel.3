Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36C6C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdqH-0006Pq-0x; Mon, 24 Feb 2025 14:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdpC-0005iG-HJ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:09:11 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdp8-0004s3-C4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:09:05 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-221057b6ac4so91918465ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424140; x=1741028940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PlFgyYMLHSiIYGuT1lQVY7DxANtlkqeHfC/q4DqwtKg=;
 b=pXcQhnlrrw++uGxWHtEaJzigR1oL2HGqBA7H9fzPHUdDhZYUoRCXV+lrgK/mlEu4QC
 N+C7boTPR22YQkswvDgUUkhg9p3Bk4zTFIKiOxpzZuQF2LXpgyWMw63GjNucMGwuCjQ8
 brFQJ1EXemaMBhL4bnnRutPoqyoTO6PhwAm+moJn7Bi1zraeAhc/8c6BwItDenT/ZNUi
 aXc7CYFD5eumZXUAaxRDmqy6zP7Fpf5wO7aUDTqlHjPTl29VjQwTogE9B9zBh72KNQpv
 3yFw+uV1f4L6dJImLkyLtnHEutk8D0Svj4WByRVgcDPp5WMu0c5YxMT8TboEKMfRN0N9
 H26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424140; x=1741028940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PlFgyYMLHSiIYGuT1lQVY7DxANtlkqeHfC/q4DqwtKg=;
 b=tJC7KHkUYNQSkSj15Eg2HSocywSnQXAkGasRgCe2FVn34ew8nWX4bmEdveH0a/KfUO
 yywAycxA6MzBf5NrtqpKQnvWOxcdPEwEPtG0b1r+LONXiKvQotfBmkggVJnhyvr2riyQ
 fBtK1QxO3W+3tf2MUMlurWG3LaiDfW7cZFI2V9sldyHqrnI4P4aIkSvEaumPogzFl+sW
 VzHQL/UFqGxLkvLR9CY9meT0+ZYc7/FWI3uu8XavJspjz/EMy0JwS8LiBTcibYYy7Nda
 /AVp7rOD9/vE63k//xmJXxLkFI94u/0mmdr4bgr/oL1OhvG1wmrz8XCYoFwUvDLjlQjw
 v8CA==
X-Gm-Message-State: AOJu0YyRvpJoa8qt7t9KvbzGeO5MvMbanXH+/ITm1SydPFTGcZtHvb+W
 ML9hZh9nD8Jwk7jm4HDnORr6s+IRFTy+H4BA8bIk9wj4Lx7eMooCiHrgi/TO0cbs1o3/pcuzilj
 q
X-Gm-Gg: ASbGncvbJU5RNO30S7TRo+ajrYvT7vNYmi7140tvIPE2A6xL72PnZWBOxBz5Z2dVSMM
 hzed/wHggCjXWP5NFzXoR57fufg6cP0n6o7A/CRNKHV46b04s81Co67zvsKTECCCkq3qpqVbuki
 LJTb2s6Tb2dttGP19C91ncO55wtrD0C99ZqtXJ6Jm++FtHs2K05o/cCdEfx7erUdzUg5NtX8SV0
 2fhnBaqFQqRI4Evyk18mUsEWi3edRh+rawp2SJM0NUFodku6TYpzDESPLU6OIP2edN5jQ1RAzDx
 nRHO3Ox0Z/PyKdlvHXA1x1TxIq3bdA==
X-Google-Smtp-Source: AGHT+IH+ng/T7lBNgBAgSCavnA2awGELH2dwZ0aHudfmAdGS155OhnZexaZN1WnI000uQVZya23rGw==
X-Received: by 2002:a17:902:e744:b0:21f:89e5:2715 with SMTP id
 d9443c01a7336-221a0edd8cbmr224356635ad.19.1740424140190; 
 Mon, 24 Feb 2025 11:09:00 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:08:59 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 09/11] hw/riscv/riscv-iommu.c: add RISCV_IOMMU_CAP_HPM cap
Date: Mon, 24 Feb 2025 16:08:24 -0300
Message-ID: <20250224190826.1858473-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Now that we have every piece in place we can advertise CAP_HTM to
software, allowing any HPM aware driver to make use of the counters.

HPM is enabled/disabled via the 'hpm-counters' attribute. Default value
is 31, max value is also 31. Setting it to zero will disable HPM
support.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index cdbb848181..d46beb2d64 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2357,6 +2357,15 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
                   RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
     }
 
+    if (s->hpm_cntrs > 0) {
+        /* Clip number of HPM counters to maximum supported (31). */
+        if (s->hpm_cntrs > RISCV_IOMMU_IOCOUNT_NUM) {
+            s->hpm_cntrs = RISCV_IOMMU_IOCOUNT_NUM;
+        }
+        /* Enable hardware performance monitor interface */
+        s->cap |= RISCV_IOMMU_CAP_HPM;
+    }
+
     /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrough) */
     s->ddtp = set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
                         RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MODE_BARE);
@@ -2404,6 +2413,18 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
             RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
     }
 
+    /* If HPM registers are enabled. */
+    if (s->cap & RISCV_IOMMU_CAP_HPM) {
+        /* +1 for cycle counter bit. */
+        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_IOCOUNTINH],
+                 ~((2 << s->hpm_cntrs) - 1));
+        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_IOHPMCYCLES], 0);
+        memset(&s->regs_ro[RISCV_IOMMU_REG_IOHPMCTR_BASE],
+               0x00, s->hpm_cntrs * 8);
+        memset(&s->regs_ro[RISCV_IOMMU_REG_IOHPMEVT_BASE],
+               0x00, s->hpm_cntrs * 8);
+    }
+
     /* Memory region for downstream access, if specified. */
     if (s->target_mr) {
         s->target_as = g_new0(AddressSpace, 1);
-- 
2.48.1


