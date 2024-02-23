Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8B4C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXuC-00045A-Ma; Fri, 23 Feb 2024 10:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjV-0006Ka-3H; Fri, 23 Feb 2024 10:45:05 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjT-0006Qe-Fv; Fri, 23 Feb 2024 10:45:04 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dbf1fe91fcso7853655ad.3; 
 Fri, 23 Feb 2024 07:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703101; x=1709307901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEEjnwTPwPSl9XjoxG6VwSL0Y2eO/O+492wWXLaJtVY=;
 b=VpR/V3fil7qbWCPaLgBwWRZMfr1czqBeTj2MT9E9YwgPUu4UX0EvEYByWUEwTxIF1p
 D7c+TA/o++7a3Q0Og9SC8poWGUbeRLN/xg8taYyebxyvULzWilLFVlsjDRevTbZ/GGXm
 wdB+MH4JgCrLA5oDe8OEFy0qihQLXZj3n94GpqTuXP0z7AwZ5xjRzEq9YScpE+zKNaZO
 PR9TYrJcNcTq2Xa4dqQhLTGh5NnVnv4tORyM31EcGQ9XWwev7ruYF8iYb11a/Vioa64O
 rJLY1lpzcA4ARbSD2YIRnrCfJ4rItNAD555DRoIXlyMrjBXA6fA75Yr9B3gIUNLtl+F7
 bKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703101; x=1709307901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEEjnwTPwPSl9XjoxG6VwSL0Y2eO/O+492wWXLaJtVY=;
 b=EKmIh928VvdQSwKBSNLGYidc2a+Hl5q66XwjtXWFopusnjgQg/j/O49jiS3wcaMfxY
 orDMoDY+8WaQWrIn7gG9TjIXoMEH/yGsueC51pKPSCjFUNBu5FMEGboSvL5DD5+GHOh6
 cgsm1icE3y97viA73mmQyauhSRGyP74u8sv+7w6HnCFVQYrLpAQuV6ZrXhejKx00RCbb
 KN5N9HirH8skk2Q69ICOFUz2IHy+h5aqzLb8/UC7YV9JEcimREnnXNZLZlWgu7NE6XXp
 DaMzu2n48U3Q6itM5TkQ/qOc+mkYegYRRQx3ufar0qWIKKfDkOmRuREcZfD9jPkCUQoH
 KoBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiUj+F0xFTfMmKsAM11Lv7TzJYmgEwFop5ZwGBazVl/8W3CnBij/Z79hAniIEDtL/t8L5OMYSAAyLowHORxZ165Y+W
X-Gm-Message-State: AOJu0Yy+aAC+xur6k8CVk12YB7/149zYql/qzoxSPtIPd/5QqNeEGfSs
 Ifee/nvfw19EG0CJaEKfrMvQP6PyJKPRH/wyBDfTEQe1ZNqjYyHqQMpXwJqi
X-Google-Smtp-Source: AGHT+IEVlZPPSI0a3oJSttrN6i8jv9eyNXvtkD29CP6Njzeq0yDnD9wWWTAmXaZjZp6TQH5kwnS5JQ==
X-Received: by 2002:a17:902:e548:b0:1dc:1391:e074 with SMTP id
 n8-20020a170902e54800b001dc1391e074mr138729plf.49.1708703101420; 
 Fri, 23 Feb 2024 07:45:01 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 28/47] ppc/pnv: Add a pca9554 I2C device to powernv10-rainier
Date: Sat, 24 Feb 2024 01:41:47 +1000
Message-ID: <20240223154211.1001692-29-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

For powernv10-rainier, the Power Hypervisor code expects to see a
pca9554 device connected to the 3rd PNV I2C engine on port 1 at I2C
address 0x25 (or left-justified address of 0x4A).  This is used by
the hypervisor code to detect if a "Cable Card" is present.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/misc/Kconfig     | 4 ++++
 hw/misc/meson.build | 1 +
 hw/ppc/Kconfig      | 1 +
 hw/ppc/pnv.c        | 6 ++++++
 4 files changed, 12 insertions(+)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4fc6b29b43..83ad849b62 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -34,6 +34,10 @@ config PCA9552
     bool
     depends on I2C
 
+config PCA9554
+    bool
+    depends on I2C
+
 config I2C_ECHO
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e4ef1da5a5..746686835b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
 system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
+system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
 system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 0e5acfd1c4..a890699082 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -33,6 +33,7 @@ config POWERNV
     select FDT_PPC
     select PCI_POWERNV
     select PCA9552
+    select PCA9554
 
 config PPC405
     bool
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 97bdfb2d1e..0755fab155 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1913,6 +1913,12 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
         qdev_connect_gpio_out(DEVICE(dev), 2, qdev_get_gpio_in(DEVICE(dev), 7));
         qdev_connect_gpio_out(DEVICE(dev), 3, qdev_get_gpio_in(DEVICE(dev), 8));
         qdev_connect_gpio_out(DEVICE(dev), 4, qdev_get_gpio_in(DEVICE(dev), 9));
+
+        /*
+         * Add a PCA9554 I2C device for cable card presence detection
+         * to engine 2, bus 1, address 0x25
+         */
+        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9554", 0x25);
     }
 }
 
-- 
2.42.0


