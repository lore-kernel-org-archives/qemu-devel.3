Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CF5C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XwX-0004Rj-FI; Wed, 23 Apr 2025 07:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwR-0004Ol-AH
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:07:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwP-0000MA-4n
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:06:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so66144965ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745406414; x=1746011214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOYMdiojT2/r6R0mXFsFLmQO6pzYznGqc+aniPhJJNA=;
 b=eGZaBWPAr6HA++UYCudnGRJ/Xk+I8voQb5XIuz6L1n5goX9ZTcZvCH3GYKa/t/3S3r
 sE9GZ9Cl6NHz/KEG9qoGaFtE1BmkmAgVxtMlhR4Z59oeDXF16xZH8b1CsisJbuv2/ypg
 jgjwApruR9/qPq1EMGkDlk7bcOX/u5Xkj7IXAJlukQjGQBSx4sR5FwFq6ftxPJmgxCtm
 wER7pzbGL4Det8W6RIZ3i783WFEEx7Pi1u0/LFC//hoQo3gOOsxGNvAnl7oPA6WNuGen
 ADkPTiPh4u0m/yxLFs9MpdR0HMPuJF7jwe4i7IcHltHP0D/1g5Rho5efzBbxpLj9pvy2
 +9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406414; x=1746011214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOYMdiojT2/r6R0mXFsFLmQO6pzYznGqc+aniPhJJNA=;
 b=dogxMZinr//OA8nw2UDAqzOBRHNX8IHKQBTk5O6AaMo/ahJKFoA2wIoBJ0Uos8kbsk
 hvOIMHMIlIbcDUILnQTh69/Cww7B/dY84qgm/zZPCbulqsgxqUS81+ZnUv7Li3kNfqi0
 GfDwNDoqpYZliJmYD3Mm4JfoUaDbD/eJN0j9dEoyfXxVpN4HHTWYQ9TtERL8kCSpkTKR
 IrJM0c6ndGjcsXsQ+Woe8I0zisStmPIUv6xiP/CX5w3qe6mAVieGZtEnCX0YGPC0SwF5
 2OjlCQEAmlBWU4KLnAqJNZkU6070bUBB6NIftc3pShZ7wE9REw/vUZ/6ERCgVghq1LMA
 V4zQ==
X-Gm-Message-State: AOJu0Yz1/2uFHGq//pqi0ZCV2PhHtCpYx+UhhUAm2LYUTV8hzCGtiRuJ
 72eMpEdWXq3zlqua1l9fyW1io5uS0ASdvYo1P8+NySJS1ZjdsVc/EhRGO35b4d5nXy1KJ/Smw5l
 H
X-Gm-Gg: ASbGncuWtp+iMbKdCmUjHXRIAjlpznU488Lr97mLsFVK/RXBuOD+voITpfYQ+GykjaD
 hsZliKS3MG4ZQGwqGMWi+CzTGoG8HZl71HtQeIvq06p1O5cOnUGeZ0DGDABLst6a0Z1znrdUPAl
 G8p3FMA4c+HQ4a2VPo+GVZVimwrqwE7h9HK6YvPaTwtTZekhMncpHQ+cqbGJ98imvIHx/zOj60d
 WH/qKKIOLpg46uolnIQPCsqt9bt0usuGsInT1PtEBpAOMslbB5qyNBzBkG8matWzV9h1e4KIyK/
 Mm5OBqI6gorwdOO9/T2DYGz8Ju4YUMTIhy8aVOadDNMyCM+nODL7Xjs5GRpOqLI=
X-Google-Smtp-Source: AGHT+IHUL7oP7Mv9XUEcApwneT9S834LfOh7h9WJDSU09Smg+MkhC+AApzzdFRnmF2v5BfUOSLHXrA==
X-Received: by 2002:a17:903:2383:b0:215:b9a6:5cb9 with SMTP id
 d9443c01a7336-22c53573d04mr314210705ad.5.1745406414266; 
 Wed, 23 Apr 2025 04:06:54 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bcc0:89f4:3b90:a265:963d:8357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf3b1sm101509895ad.248.2025.04.23.04.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 04:06:53 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 5/9] hw/riscv/virt.c: use s->memmap in create_fdt() path
Date: Wed, 23 Apr 2025 08:06:26 -0300
Message-ID: <20250423110630.2249904-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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

create_fdt(), create_fdt_flash() and create_fdt_fw_cfg() can access the
memmap via their RISCVVirtState pointers.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 77ebb517f2..02f3659d38 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -996,7 +996,7 @@ static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
     }
 }
 
-static void create_fdt_flash(RISCVVirtState *s, const MemMapEntry *memmap)
+static void create_fdt_flash(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
     hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
@@ -1011,11 +1011,11 @@ static void create_fdt_flash(RISCVVirtState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
 }
 
-static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memmap)
+static void create_fdt_fw_cfg(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
-    hwaddr base = memmap[VIRT_FW_CFG].base;
-    hwaddr size = memmap[VIRT_FW_CFG].size;
+    hwaddr base = s->memmap[VIRT_FW_CFG].base;
+    hwaddr size = s->memmap[VIRT_FW_CFG].size;
     g_autofree char *nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
 
     qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -1146,7 +1146,7 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_rtc(s, s->memmap, irq_mmio_phandle);
 }
 
-static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
+static void create_fdt(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
     uint8_t rng_seed[32];
@@ -1173,7 +1173,8 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
      * The "/soc/pci@..." node is needed for PCIE hotplugs
      * that might happen before finalize_fdt().
      */
-    name = g_strdup_printf("/soc/pci@%lx", (long) memmap[VIRT_PCIE_ECAM].base);
+    name = g_strdup_printf("/soc/pci@%lx",
+                           (long) s->memmap[VIRT_PCIE_ECAM].base);
     qemu_fdt_add_subnode(ms->fdt, name);
 
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
@@ -1185,8 +1186,8 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_flash(s, memmap);
-    create_fdt_fw_cfg(s, memmap);
+    create_fdt_flash(s);
+    create_fdt_fw_cfg(s);
     create_fdt_pmu(s);
 }
 
@@ -1720,7 +1721,7 @@ static void virt_machine_init(MachineState *machine)
             exit(1);
         }
     } else {
-        create_fdt(s, s->memmap);
+        create_fdt(s);
     }
 
     if (virt_is_iommu_sys_enabled(s)) {
-- 
2.49.0


