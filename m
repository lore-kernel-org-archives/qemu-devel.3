Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46877C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrnE-0004xK-R7; Mon, 19 May 2025 00:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmv-0004lt-As
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:41 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmt-00049Q-J0
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:41 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso4433542a12.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627656; x=1748232456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsKoSChLOgf9IXWkPW+gBtADC5q1GRWfNKybDJ3aAWQ=;
 b=D5r7RZsMp0SMf3mb2lyMr8krJs/ABzkAVB+GSIzpJpXREq+pcfPqk3LSW+jVBqO3Rb
 sgeqcUzumn4PtIIyh5hp5RAIHsKM2hYCYbJsCIcq7AwiRZW5zwQ51fwqwxSPa9D0kb28
 ZCYZAdhfbefgrsoXpyyG2iQhYa/d65hj5txitWQ1PRbOAyzvsuMKAQTuqWIYEFtAbnQM
 k/8HxFxhv24UYcrZvuel5rk6Qn9CT88yt09GKtJ2CwYsQxExNGK8aFhj6j1SrhP38VDv
 jHDOsPWCl+5FgE7yPFNcejinXwQ9WlYgIF78ksYiPkd7TBS6ZSNt6ODZHeUF/dhHvpa5
 YY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627656; x=1748232456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsKoSChLOgf9IXWkPW+gBtADC5q1GRWfNKybDJ3aAWQ=;
 b=Z7JyvCfe9leNBx5tV0GjTcgwggQq1+gQcRZLbCWzu/6t+woogxgGtfIUA5z/h3PSgH
 zkErb6vnIK8O5lbtBeyL2OBRkrXByy8GW3COi/UjSFxLPwAmZRFkcnoTfUwHVKckO273
 1eQQ4odAUg8h+h2P8SHPUo8kzmWSCOWMwLE/BYqUsjNqEHPU43Z4ao4WU0eOPFRUYnM5
 d6t3Pa3uUGTLO/9uIS0+6NDn6k9ow/4QXcLcGdmMu+/iirQBEJtVNnpcWTuAYEl91bgF
 okUMV6fv/5EPeOq4rye/ZgJ9Wr1MEVtrDNwugIeqDi8P+6MBqM5tq9LiCq9W54UF3VAm
 PMfw==
X-Gm-Message-State: AOJu0YxINooMFl8dEAxk9rm4r/LSXNvMbxilgN1ZSfNOABQn4T+8T70P
 oK6c0sBgDal8E0ftlsYivgow3D389gC6ZvzmIjtHOHhnJhcm5RA8j2TT8lRfTQ==
X-Gm-Gg: ASbGncuUW9iNepnkquTqSNRZaoRyVPJqR0hYeVe4kWkcA7aFH4OzunX2cR5lW4Nb+5X
 h4mElhRseTsSodOgsI6cj/P2B6sDWN0+Trw8nfeBRdTs8hWW2R+No562/Dy55IsQ9ijCaVcci43
 XFCGYL1Ip3KZZVsFGgRpRSf6AjfbL1c9DFfYeWlGPa1p5hoRQSqmNlt7K5IJRtRVRBKtX1NeiA0
 kYDvhwkr74mxUj3ZMHmljts2mEO2FNWj9f7jmb6EqKJvzfHsH6anDkPn40vTw74lTbIjPLnhW/0
 pJMWCpd4KbeB4dFXrWiKRAUWLZ6cmsDAKS+6jDPSeH8IH3gCyPVFYwnsUHzAC8Jftqdnckn3Mx0
 1FiJTTdGEiGnRrZ34yvLra7MfdVqeZqfVT8Ie6n0syZbaqUUG30kZry81
X-Google-Smtp-Source: AGHT+IEb2u61/bsK4ij3F3u0eIjtE+N/nrQ1XXcYgyC1b7vol+gRE7yExMvg3Tbit2bWwK8y50Gb8w==
X-Received: by 2002:a17:902:f78c:b0:215:7421:262 with SMTP id
 d9443c01a7336-231de35f13fmr188046155ad.12.1747627656601; 
 Sun, 18 May 2025 21:07:36 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:35 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/56] hw/riscv: More flexible FDT placement for MPFS
Date: Mon, 19 May 2025 14:05:07 +1000
Message-ID: <20250519040555.3797167-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

If the kernel entry is in the high DRAM area, place the FDT into this
area.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250319061342.26435-3-sebastian.huber@embedded-brains.de>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/microchip_pfsoc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index e39ee657cd..6bb44e3ac5 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -626,8 +626,15 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
         kernel_entry = boot_info.image_low_addr;
 
         /* Compute the fdt load address in dram */
-        fdt_load_addr = riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_DRAM_LO].base,
-                                               memmap[MICROCHIP_PFSOC_DRAM_LO].size,
+        hwaddr kernel_ram_base = memmap[MICROCHIP_PFSOC_DRAM_LO].base;
+        hwaddr kernel_ram_size = memmap[MICROCHIP_PFSOC_DRAM_LO].size;
+
+        if (kernel_entry - kernel_ram_base >= kernel_ram_size) {
+            kernel_ram_base = memmap[MICROCHIP_PFSOC_DRAM_HI].base;
+            kernel_ram_size = mem_high_size;
+        }
+
+        fdt_load_addr = riscv_compute_fdt_addr(kernel_ram_base, kernel_ram_size,
                                                machine, &boot_info);
         riscv_load_fdt(fdt_load_addr, machine->fdt);
 
-- 
2.49.0


