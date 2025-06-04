Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CFCC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIU-00026t-SA; Tue, 03 Jun 2025 22:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIS-00025r-ME; Tue, 03 Jun 2025 22:56:08 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIR-0000OV-06; Tue, 03 Jun 2025 22:56:08 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-23035b3edf1so57516975ad.3; 
 Tue, 03 Jun 2025 19:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005765; x=1749610565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXzQjQHha3k8G+tIoP6yHELVJ1uynYIijybQ2TGYkZE=;
 b=miXOEAK27hp/QOSSLH6MFV65V1EPQDX0P0tACjG0hM3EmGGaJ8hmOh88GnvxcRKU/H
 Zlxcz9/HpZusnvI70eMHa1rktT24F7WzrPYHKmJIrnoLyM2cZSWcVMDwyy6WcKoMRl1o
 run9LrmnZ4Yz5qVrz9cg9L1y0BjoPWh4UWtqp7WimBNksu20pxCfOKlFY+nGRTUln7SD
 uQANJ8/cvNA4R5ggPowEOUQR+MWr9ZhylzgUcgbT0RjFZ13m/Fuo81Hbm3NVSFD6PC+0
 z7DOf0NHjJ4556GkGi0Gh8rFeviQiZbfJJIYLmks3O2U0FsEdXnFwEr7dVfBjEAUaZN3
 vraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005765; x=1749610565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YXzQjQHha3k8G+tIoP6yHELVJ1uynYIijybQ2TGYkZE=;
 b=YUH34MWY6goXJifTHRBscRsnTUrw1CZpuV0bZHTJfJaE8Q0KhUuWD4NCQGhPFQb3VX
 QpSv/cB8FeoBWgeV9PiWxc7kMUb9PFXeGBSoLOgT+vJ6t7PGyPv9Mmw7LgKsftVGbkBp
 KHhbHEjJyses3HEiuU3X8MpIPXKhTcAquHqF5ax/To7rVmyNeRktNbr2sddMQGsu8jNh
 5HtdBirAYxvhN8BTlC0N5RAUOF3fNABXZvmVORl5FDyYV3Qd39xjgTVRxR6a4iO1eDL9
 nXLH2edzRfULphnrCFUoeFLLlXeoc35ArcJAdL+sL/YhGj39LOh6v7vdchewVpqSTcl8
 m6Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKYWhd3MIfrksL6002EM1wqvXzOoiV1+kTPs2AT8QGyA0Z4CC1HGdmyNuJds4uZ9fFEDz5d657O6/F@nongnu.org
X-Gm-Message-State: AOJu0YwAZkugjQfUegBOK+BlKcLm6Ntg8/sAoUuR7UuBu0ZMayt+MyVR
 dBs9OsGi6LmGea+79UGQgRe3XQEIO/WDCydzRzLd3kTw/6lKrKcxDT2E
X-Gm-Gg: ASbGncvicxQWv7f5UvRHRWq4UVuAgLP1TjKVrOei63/Pz0/t470uCVCuMMnslaLsKjL
 7koCBHipGTUZU3trsQQ8Ia541Sm7leqSUYjtlzcioK6yoUs425tz+blsJEZphqECZdDnh2M7qmZ
 V5VRltQjgAFEFG3moDPMUtVwEtMfy7DFxv0zarKYYF8WxMrjkN8yU/q0urE/CBMCiagCmSoxEEF
 xjX0yJxr6lRSxcoyHrpvF1htLAKziwojfeHqng30ysVCAZdbzoUKFR2s06fRSjCNaDSdTFNKhaP
 5ICnTUQ/Co2fuEvjTjxLDjD+9KocJiE0SZxmfep3dK6AftsE1ZtboSwnJ08nwA==
X-Google-Smtp-Source: AGHT+IGdXUuCkBK5O2SiIkB46e1SDPEkceyhhNez1Fgnq5pidi75Z8zcIxBwI/37GGM0ObT+w75PmA==
X-Received: by 2002:a17:902:e74e:b0:223:65dc:4580 with SMTP id
 d9443c01a7336-235e151c771mr12561885ad.52.1749005765304; 
 Tue, 03 Jun 2025 19:56:05 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:56:04 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 04/12] hw/riscv/virt: Use setprop_sized_cells for aplic
Date: Wed,  4 Jun 2025 12:24:40 +0930
Message-ID: <20250604025450.85327-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e074a296751a..205fa6e44f29 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -655,8 +655,8 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
         qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle);
     }
 
-    qemu_fdt_setprop_cells(ms->fdt, aplic_name, "reg",
-                           0x0, aplic_addr, 0x0, aplic_size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, aplic_name, "reg",
+                                 2, aplic_addr, 2, aplic_size);
     qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
                           VIRT_IRQCHIP_NUM_SOURCES);
 
-- 
2.47.2


