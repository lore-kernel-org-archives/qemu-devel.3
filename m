Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C29CAC593
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6uB-0000jK-7i; Mon, 15 Sep 2025 06:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6u8-0000iM-H8
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:57:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6tw-0003Zm-FZ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:57:51 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3dad6252eacso1635770f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757933849; x=1758538649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYN8rFRuit4/9qz8Bh4Ga99rBZ3/Ln01//pbnVQl7QU=;
 b=Gr2njwB7/Hy2PTdvEnrbc+iE1FNWrxwSaA+6/fRq3TOQXoBCWZU7QetN5KRgJYl5nn
 04Dn/BQWB/rZ0prrDnrOfbUmgR5BqEauhOz4CW5FyrbNtFlB6RDOQDYTD8kTHGabW0u1
 FPgGPjYXGyAiDTUs92ucbDfRh9P+DOYs+3xYYSCBR9XSa70HxC0akTuPVPD8CKD/ktal
 Rzejc5JIhut5AbmDdjQnWkBxroz9DvpgzTr92YbLADLkixDXB6qIMAww59KXMLMU9oDu
 KzRJRcF07D5k2gVz9BoADUUoqSpTmvDQiMxlBmmVCQFLKk8K1YSteDaBO1Lo5rS2NIKu
 gysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757933849; x=1758538649;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nYN8rFRuit4/9qz8Bh4Ga99rBZ3/Ln01//pbnVQl7QU=;
 b=r9/rfIOowcwcfjbC30/n/C4WDcWq6bQEf4UkPCPbcR3jhvaQ7Rsam6i0Q9FerDqLdS
 RZLWclfROmVp6vhMP6InGfKZI4zGalxDYfj/Lq08lNJqzPAgtBnVKxTuXt0U2ut2l8XJ
 JB5sA0hTfg5nCJJMSKac/mIOe9ULLl+W4oaH7GL+o8i6ucwLRfloAwreITMXsRs0JfMW
 qDA6mynvRWIRnrViZHRzRKnYWdtisdOTkQcnrCeDdEhHd1e3K4L5V4nWeXUkdXA0DLTZ
 h9KuKGSSUqgrRPK55V2eEggQbboCYTsNGh1iNgbO9FJlTCH/MvmVgP+1DuHFlMXubp+P
 cU4g==
X-Gm-Message-State: AOJu0YxfBjZ1rcGeSOQSJlwtYsBspeGFWrPYDwY84dJNbCX5axK0DWdz
 dv7e7Xh6K9TqDQtINlrdL9CaME1jFroR3GPAlhna5xxOMiJwjTylAtGWGkvL2g==
X-Gm-Gg: ASbGncvOaI5HK085M9a7MrjZSqQ06uccTud4oMssDBPEFsODVIDsjkeQioPqAjL4R9X
 hS1wEMfwEy2tMuso2Nj7vbht29llgO+1/Kdn/skc1q7rf1DT6uoMzdYRjm1x0jrYBIMJSV3G6+r
 34oeIB7oug1+fP3iN86LrppOxErMkYP1SrbIgZjUXILy7CKy60mra2JKqXxxyxZQxr328ZwCLWj
 U1ZZNH0nclETDhuEjeJa4utUULYX4n+LOhudL6XxIs91YgAvSDnnWVngcajKbsn5YgjkBVb8aLs
 qsO8w7fTa8TUXcRBzC1JqwFx1uJrOMTySFnUnDBERBhlKWypAhUZ1WAcEs6/d350HHxfIBWT4ZG
 rqgc4EPBiqdNduT2RJjTtLJhS+R6F/i669BM7ItLF
X-Google-Smtp-Source: AGHT+IFg8mHPwSV/OirXAC1o+hjnQBW+CF7LD32eeoA7eJT/1oK21eDqMwj9/OSWFIVCCZB7Z/zPrg==
X-Received: by 2002:a05:6000:601:b0:3e9:ee54:af54 with SMTP id
 ffacd0b85a97d-3e9ee63fca9mr4213097f8f.21.1757933848985; 
 Mon, 15 Sep 2025 03:57:28 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0156d40esm180428055e9.1.2025.09.15.03.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 03:57:28 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:45:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/5] hw/pci-host/bonito: Implement PCIMAP register
In-Reply-To: <20250508-bonito-v1-2-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
 <20250508-bonito-v1-2-4f9f27733028@flygoat.com>
Message-ID: <98664D1B-E236-4DF7-A0FA-F940939D2CAB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 8=2E Mai 2025 14:46:07 UTC schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>PCIMAP controls how PCILO and PCIHi regions map into
>PCI memory space=2E
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
> hw/pci-host/bonito=2Ec | 37 ++++++++++++++++++++++++++++++++-----
> 1 file changed, 32 insertions(+), 5 deletions(-)
>
>diff --git a/hw/pci-host/bonito=2Ec b/hw/pci-host/bonito=2Ec
>index a599a1db4c068325b8c1aa8fb4a45f6b299b581b=2E=2Ef509f22df90ff7ed31ff5=
387a0acc239c22fd5f6 100644
>--- a/hw/pci-host/bonito=2Ec
>+++ b/hw/pci-host/bonito=2Ec
>@@ -137,6 +137,12 @@ FIELD(BONGENCFG, PCIQUEUE,      12, 1)
>=20
> /* 4=2E PCI address map control */
> #define BONITO_PCIMAP           (0x10 >> 2)      /* 0x110 */
>+REG32(PCIMAP,        0x110)
>+FIELD(PCIMAP, LO0, 0, 6)
>+FIELD(PCIMAP, LO1, 6, 6)
>+FIELD(PCIMAP, LO2, 12, 6)
>+FIELD(PCIMAP, 2, 18, 1)
>+
> #define BONITO_PCIMEMBASECFG    (0x14 >> 2)      /* 0x114 */
> #define BONITO_PCIMAP_CFG       (0x18 >> 2)      /* 0x118 */
>=20
>@@ -245,7 +251,6 @@ struct PCIBonitoState {
>     MemoryRegion iomem_cop;
>     MemoryRegion bonito_pciio;
>     MemoryRegion bonito_localio;
>-
> };
> typedef struct PCIBonitoState PCIBonitoState;
>=20
>@@ -254,6 +259,8 @@ struct BonitoState {
>     qemu_irq *pic;
>     PCIBonitoState *pci_dev;
>     MemoryRegion pci_mem;
>+    MemoryRegion *pcimem_lo_alias;
>+    MemoryRegion *pcimem_hi_alias;

These should be (arrays of) values rather than pointers for simplicity and=
 to avoid memory leaks=2E

With this fixed:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

> };
>=20
> #define TYPE_PCI_BONITO "Bonito"
>@@ -293,6 +300,20 @@ static void bonito_set_irq(void *opaque, int irq, in=
t level)
>     bonito_update_irq(s);
> }
>=20
>+static void bonito_update_pcimap(PCIBonitoState *s)
>+{
>+    uint32_t pcimap =3D s->regs[BONITO_PCIMAP];
>+
>+    memory_region_set_alias_offset(&s->pcihost->pcimem_lo_alias[0],
>+                                   FIELD_EX32(pcimap, PCIMAP, LO0) << 26=
);
>+    memory_region_set_alias_offset(&s->pcihost->pcimem_lo_alias[1],
>+                                   FIELD_EX32(pcimap, PCIMAP, LO1) << 26=
);
>+    memory_region_set_alias_offset(&s->pcihost->pcimem_lo_alias[2],
>+                                   FIELD_EX32(pcimap, PCIMAP, LO2) << 26=
);
>+    memory_region_set_alias_offset(s->pcihost->pcimem_hi_alias,
>+                                   FIELD_EX32(pcimap, PCIMAP, 2) << 31);
>+}
>+
> static void bonito_writel(void *opaque, hwaddr addr,
>                           uint64_t val, unsigned size)
> {
>@@ -308,7 +329,6 @@ static void bonito_writel(void *opaque, hwaddr addr,
>     case BONITO_BONPONCFG:
>     case BONITO_IODEVCFG:
>     case BONITO_SDCFG:
>-    case BONITO_PCIMAP:
>     case BONITO_PCIMEMBASECFG:
>     case BONITO_PCIMAP_CFG:
>     case BONITO_GPIODATA:
>@@ -330,6 +350,10 @@ static void bonito_writel(void *opaque, hwaddr addr,
>     case BONITO_MEMSIZE:
>         s->regs[saddr] =3D val;
>         break;
>+    case BONITO_PCIMAP:
>+        s->regs[BONITO_PCIMAP] =3D val;
>+        bonito_update_pcimap(s);
>+        break;
>     case BONITO_BONGENCFG:
>         if (!(s->regs[saddr] & 0x04) && (val & 0x04)) {
>             reset =3D 1; /* bit 2 jump from 0 to 1 cause reset */
>@@ -664,6 +688,8 @@ static void bonito_host_realize(DeviceState *dev, Err=
or **errp)
>         g_free(name);
>     }
>=20
>+    bs->pcimem_lo_alias =3D pcimem_lo_alias;
>+
>     create_unimplemented_device("pci=2Eio", BONITO_PCIIO_BASE, 1 * MiB);
> }
>=20
>@@ -673,7 +699,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error =
**errp)
>     MemoryRegion *host_mem =3D get_system_memory();
>     PCIHostState *phb =3D PCI_HOST_BRIDGE(s->pcihost);
>     BonitoState *bs =3D s->pcihost;
>-    MemoryRegion *pcimem_alias =3D g_new(MemoryRegion, 1);
>+    MemoryRegion *pcimem_hi_alias =3D g_new(MemoryRegion, 1);
>=20
>     /*
>      * Bonito North Bridge, built on FPGA,
>@@ -730,9 +756,10 @@ static void bonito_pci_realize(PCIDevice *dev, Error=
 **errp)
>     create_unimplemented_device("IOCS[3]", BONITO_DEV_BASE + 3 * 256 * K=
iB,
>                                 256 * KiB);
>=20
>-    memory_region_init_alias(pcimem_alias, NULL, "pci=2Emem=2Ealias",
>+    memory_region_init_alias(pcimem_hi_alias, NULL, "pci=2Ememhi=2Ealias=
",
>                              &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
>-    memory_region_add_subregion(host_mem, BONITO_PCIHI_BASE, pcimem_alia=
s);
>+    memory_region_add_subregion(host_mem, BONITO_PCIHI_BASE, pcimem_hi_a=
lias);
>+    bs->pcimem_hi_alias =3D pcimem_hi_alias;
>     create_unimplemented_device("PCI_2",
>                                 (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI=
_SIZE,
>                                 2 * GiB);
>

