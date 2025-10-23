Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB21CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn3g-0003gv-Op; Thu, 23 Oct 2025 00:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3a-0003fM-0x
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:10 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3V-0001SR-Sz
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:09 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so4940115ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194161; x=1761798961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7I1EmyVr0Z9l3lsKRKPgw+o81O8dMBCIP+/0Fha9Is=;
 b=JPoj8mv10AjrUVYUlYIOqcCr9GVBZMB+21G6Teiz+qOLdaD3TyIkpwIjSP0k0KGnnn
 WyB7xFrbbCVBWTfamQIZR/E87SHcJWF7MgnIVPYSn9V0hZn4p7DhCGjiQkK9HRVwt6kl
 rpAO+3i+BR8QeN9kkRVZinUHHUGP8bznrw+Vqj57ohU7CjCUBySX6/VPEtKmg0q3TkDP
 Fus66T5BXtef2JFgrwyOkatV5gKOZJSzmq6KxHbIwE0AlI9/qrG+3iNWenPKmf/o8Ti4
 OMrT8c3o3rpuvhsTjLcrBrZSs9dZUnYJIsfr6Q+AE0g71D0v+E1idSEf7pww+8Y9sp7I
 9UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194161; x=1761798961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7I1EmyVr0Z9l3lsKRKPgw+o81O8dMBCIP+/0Fha9Is=;
 b=PeKvhrA02ZGmmErrHp1stCeOqHeJcfGiXeqdGPQP2vuKKWBk6FkJdpbIKrRdu0gVve
 DrY2gvVlvfuflptNy2RiS1mYcPL5J1nVRfz5DoNbz/VBZ2+qwl+v5du7xgZxwc0NjtWj
 YvtsNB/UcPX1hCl8m16DKkxDjV2gwCMDaCzEJFjOsmjCHocKCUKJZfmbp0vLfgLVfbb2
 BwVeKHkfkSXO449GKeEDv60cuafPtXBOIfXclRYTEeLFBV2/BzDl2SC/4ScL4lL7SxdQ
 qIfYYeNdGvYQBg+Yv/P5dtvuPaymPGlnw3mQcjMnqzXmo0kCenRkvf9CcOezH84v0can
 zOrg==
X-Gm-Message-State: AOJu0YxgQ+z6J6LsacHzyX2OBIFxJgukACwT/xhzyIrUQUpaabGsXu+O
 GoIW/Jp9nC4eVL64jp0v7kBYCD/DkLDaWcyS+P1wjGPMCuxbZYc5/WqW4Equ1w==
X-Gm-Gg: ASbGncsSr/VfW8lHDQtXJ3kdbKNu4Urf3CToM/ih2T12ycINAp3Y2U827G7QRKjSquD
 U9Yj1CDAENezhZxeH5JNZluovZDiLlD1ib9cfMzD0JZwqUqXIMflHGF0lNBxTTiTqtgzWhfEv4M
 AK/LtZkuE5S7j4PlJfHWRVeMN5ouJTNdr4VQwmM7CNzQCu8aNWa7FsLhjhuxdkYP58cBQPALSjD
 c0PxgiYyTJEMf3RjT8TlnBsFFdpGHeD2NHJpyjWJEvp5jGXDqQjcXs0TOtGGYGIGANLc6y0LZ5L
 iq2ToduRV4nDBRCW8A4My+GRUORL65yYq8iyoEnYX2ZXxJ/Wl4D5RMF8EiiwA5Wkn6kM/wE5iiM
 Us4GIUeczWfpszlNRE+zCz69pnXchFQTjTg4dfKgV4UEzW8QVIiaO/b3o/rJTQcDwxoL7LJlJ7Z
 bzATY44InGoGEmU63Bic+DbIQlvZYk0X6B55IJs4jMONSnait665GBDI8DT3PuaX2DtB84xwh6X
 uotU/YL
X-Google-Smtp-Source: AGHT+IF47HN8rrC3ZlSMRmugaO33hwRHFobXG5raR/o1mJ2WUkQ7cI92WloN+F8UZwkXgdfIoX4wEQ==
X-Received: by 2002:a17:902:ce12:b0:28e:7fce:6685 with SMTP id
 d9443c01a7336-290cb94792amr262276635ad.32.1761194160659; 
 Wed, 22 Oct 2025 21:36:00 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:35:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/37] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Date: Thu, 23 Oct 2025 14:35:13 +1000
Message-ID: <20251023043520.1777130-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20251018154522.745788-13-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 7d8b91ef04..44be6e03d3 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -424,6 +424,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
 
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NULL,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size = load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
-- 
2.51.0


