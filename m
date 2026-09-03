Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D41C624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20c7-0007ed-By; Thu, 03 Sep 2026 02:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x20by-0007Xq-Nj; Thu, 03 Sep 2026 02:07:47 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x20bw-00089h-Rz; Thu, 03 Sep 2026 02:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQNho6/2W96adcat7y0JAUvs+d5r8iMLeJdpFp3ZC7m4o5o9c+d8HQZz2gV0WqM4wU+YGZPokX7gYw07ByUyog+HgNipnROJNJv6KuwcX4ZYCxSOfHz4FdmNOKKy3WHAX5tZ3i4UR3dKEQ+jIncH4+Wyi9MT1DrhUflWBLeujr9GCdVojqFDTl+qfRY9dAEDOYog/7bxdnAnej/zPSgZEQ+o+KwdHFcSP0ldVPmKkuC2TNaZVVTzGYqC5A1exCOfNqEw0dOU5GeE71UDPBj29Q/ZFUnGLmlF1IdG1QeGOOm9m/qGGLofrqhuR6d0dFk8QL3cu9xNBF7d19LoCpHfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMx7Fj1Eue4eE5coAdif8tXBPDir81h3X96iVBq7m/g=;
 b=XU9nwIMT/JvUCQrZaMY8nSkz1xYcJ10vzHPcHWAg9B1VB14D+GdZ6uOXc0osXVQYZ4YvpeeRp7E4ADALVHHqaRWUmvCcW4cwiSRJmjfYo19DddP6O5K28JOZSHCAx5EbwcTDdtO4XDng5dp9FBM2W2Urf5O4+WvgT1zhMHOY6rMKQImwEvcHo3BFy04LD1i+/8/nhihuc7WMXpQgn9IEa1xXOJVdtQN+Ms3LL60jQonBoJPywhCsIvMsJxWhv7dAexT/cgEKulyjZx+zjFrKUD5FvqX+47baf2UZnlLDsujcvK6YvjaHJZfhMFIj5UosuP0t/iBjjkW9c8BcJ4m9jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMx7Fj1Eue4eE5coAdif8tXBPDir81h3X96iVBq7m/g=;
 b=aulQFn2FCbFHEEwDCWuXajmXRqOAxbTE9ooMmYi/HtFZKC/PhuBCT/WuvVWfcxI/iQQlcGyY6s0KYyAaxvY/f4VhBguTWjG19n78X9NtjZzIx3kGOpYWKxw0GUjktjMiX6TIYADmA8bNtikebS1EunShtnBxzKwi6Lcb23raGJCnMmkvReOC9pGJz3Oc/YLQIAMI8BkhgJsF6Dtf33VSKgr9QbvbatqPil41rDrauSGhXYsFd+MEMxEQJRBjYuUSrEMNc9kHoxSnWtYSqNddZlOicXHp8jWKJoAtDoSb9IptGninfqvWXg1J37f2atpoA+ysUF4zqcSR2AVIPRtNzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SE3PR02MB9348.apcprd02.prod.outlook.com (2603:1096:101:32e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 06:07:40 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 06:07:40 +0000
Date: Thu, 3 Sep 2026 14:07:35 +0800
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 05/16] hw/intc/sifive_plic: Take a MemoryRegion for
 the created device
Message-ID: <apkOnzQxrSnkdIZT@ChaodeMacBook-Pro.local>
References: <20260903055131.257903-1-joel@jms.id.au>
 <20260903055131.257903-6-joel@jms.id.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903055131.257903-6-joel@jms.id.au>
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SE3PR02MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a687932-5f27-4317-21b9-08df0981a8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: tx/di6MKnqaLoKmA8Njtm046R1f9DrQld0EQqEAvhEf7cpqIU5I4oPOUYpjHngZJhbNcpZ6JPo/hMWqI+hXW5hhIfERJZdd7HNJWrC8056t3QOE5F0oCYy7NNlNxkMk/wtcq9f4tDJVkAadeaPSJGtnY09kGOtMYIdc9GS7LYAHYw5ztaCAz6bHElYoggkN6rWUKSoXdSHst2pVTBVzW19tfYEwT1w/uLcE5DF4lB1eZhyGhG5UNlZ5/7Td0ZyXJil/eMkR5kkg+FC/gFiu9Cpt2n5PFwwU5V/1J+zz1LSipY2blc8vZgujr2BNOfT2E3aa9cT/SmLs0mNqqP1nK+xMQyvI3Gkxq7OCcs4nIE56+eLh6eBBMXgVzRsuMKUo2ogQSAzYXpKVjNu2PbKaYfpOYdjd9GDqcMUyASgKLJnSDCkYKixMoh50noGyYOryZyEUN2XynXh5a1fGLs2h/aFoGFDqlErohec4NfSL4Jj6H0MgwuE2ZMoXkwvuUtYpjaIvSt/aoWVdFL2OhABBKAfBjCDIKGB8ofIjD8EN+dbNj1lGxP3BYvf+i+cWHC0ZozslB2L+oY1nIvpBZRbmurlC1TqhhBOvRJYkQc/F77spJRjDMtO8hMU8LIzOkQwjWonnLcS+nzsKSvX/B/tA+HxURESWEK83NurQXKSU8WJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GKB5TiYzQKlR/qD3lTOZjCgO4lnvbrXSqcx410k+sBfDr1/CaJd0AUij0x?=
 =?iso-8859-1?Q?iHgWBvIdIRoRZ93jMXp6ZpTzCggSxBmY9VfoxrJEm4ShO23kQekYXM5IME?=
 =?iso-8859-1?Q?J8bA1R5VuFdZAPGsNzhZ26iLoZUdn+RW3VBNwa2DKBixSskw1+bOdPWCuz?=
 =?iso-8859-1?Q?Z6ZY8S8nyQQFMwd76v7sBmra9hnaH4E+Ffalq1jaYBJv6vDTeZy8Jn3Dgp?=
 =?iso-8859-1?Q?rSN9Wf3aYppxLHUa3jne+3fDn+ypPUG7M7rZiqg1UVN5D1ZIl+Yhs7DdjR?=
 =?iso-8859-1?Q?pyb65bLak3ST1UBvSaPyr6etob0glK8BwH0BUWhVRGoQ9HWXJs55n4/1Xf?=
 =?iso-8859-1?Q?n0IXWEyNru/viXV7dG3FTSibR9gwHxLpNUuD9XKYsGQ91TpkOg2Q3Bnj/K?=
 =?iso-8859-1?Q?rHw7ABuyMG02JlgRC3AdWsR1UeiqSmho2Iud7yyi2f1mck74zYldTTRbpn?=
 =?iso-8859-1?Q?tc/kZEDLVf4EKvJXXQH9rxdm65j09+ksdxspbL6HNJF8g/zwq++S5oLsuW?=
 =?iso-8859-1?Q?HSSkCzet23+QJP6WPIQARvfv+BvLI/hFiRKxv+MIeyNZQZXQZ/2jiHg9nC?=
 =?iso-8859-1?Q?0gwNPLMT7I//FNO5mjbi6bQzVFUxA2FmOhzbk1Qv8rPOjQUUP/P0gN1xEN?=
 =?iso-8859-1?Q?vJiwJyXFgrcZ3DSfpGFTpzzGuzvCi84OInf0oToYvuMhL3FLTIp/7zCiqV?=
 =?iso-8859-1?Q?EALuI6Clz/Bxe7gvwrOEMZYBn/RnesoCroWG+DeZGn/l5kNnL84pwYOA3x?=
 =?iso-8859-1?Q?D7tqAOVp1kqVEn9beZYbgASSdR+JA8LKyTQdUOm/pRHRADqaSZd5gkhPW3?=
 =?iso-8859-1?Q?hnagW3NDLACoykVAu5AGgfkvdLcjgrMIN3wGOGGmA5duVHz/QZlG5wbJv5?=
 =?iso-8859-1?Q?WtCaUv/MCOxmLEH8Lb6qVBb3bUz/OmvQk/a3DFxSzMrgUQIjXXKGg8Mbyf?=
 =?iso-8859-1?Q?6YyZ9zjT7aBFV1CnRYVNgyHlsbv34H1vyMcwfkONhZgKPZ4NhDKM6E5dsb?=
 =?iso-8859-1?Q?hfAZn0t/7iyS9JW84m+wo2TluG4SPo8+ykQI5qrsukyn4gcSjtI+Pjo/zT?=
 =?iso-8859-1?Q?I9DZG3XMMPaEh6IsTRjks2wnrt5qE//LymIN+Fhe9iXR8tUISkzaqusRrv?=
 =?iso-8859-1?Q?0IiVqk0RNP+7W+4zNMwRo+wgncwyg+FzANpaPXLLGIQyiJY1EjjKGM71wB?=
 =?iso-8859-1?Q?T/zt/I2l8y0ylg7MD9n2az2wfhl5gR2D2PF02RcDOgLTH2Hz4HDmL55D7+?=
 =?iso-8859-1?Q?klwHj+ZfDhZELkMk3CW8HB5+kOZQkvkDfSVHCM0j18XSfPOPE3ASNzk2B2?=
 =?iso-8859-1?Q?W7yWU61GPv/qWW2FpuEBIbcee5RGontYQ739Zb31VtW5V1LQb7X6f0nQcR?=
 =?iso-8859-1?Q?YI5PyUPw9zkhCxMWYXQLLq04Ka0x3XLIlOrtej4DClvlZdzZPyNI3RLvNw?=
 =?iso-8859-1?Q?IcyxUxPzSwl4GeWfNvHlS3DAXOMVFNmhfSoTxrRPJnQK1VZYT8A85POgiB?=
 =?iso-8859-1?Q?uYwWErrC/MECsW6EQ0sGDTmQvkp3TjGl3dEH/V/wmyk8wiSqRnp24hSv+P?=
 =?iso-8859-1?Q?UB1C5v7+Lsw81TrTIwdafEDh1h1pb0UDPnebD2M01M8184e7Vglb5rciLl?=
 =?iso-8859-1?Q?C1pihzOEI2oE4ipoQ20oVgIx0KKiITPnLANZfro2lIeBQUX2I1VvM3Sfda?=
 =?iso-8859-1?Q?53cLfIDpjkkTF4CCOfnUO90+ljmAZGA7+RXgsPXr11G/DhkJPmqK+S5fhA?=
 =?iso-8859-1?Q?KLzmVTNLkK1XLMiN0vMRjA9jpWml4YY32k27o7eDSZ4Kv1z5RyYDCc1l2E?=
 =?iso-8859-1?Q?QIzmdwdvOBMWBDCnrpvG2wfOPO/dSP4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a687932-5f27-4317-21b9-08df0981a8fa
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 06:07:40.1864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3q/4MuuiGZlchDmsD99fiURCaOCX9J+mMKUQnYSeUQM0+AWIA2cGHgyESSU2CllasDItQXhnF1nxodbG9DkelO8v0hVsY1EvTQ19+jVSro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR02MB9348
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Chao Liu <chao.liu@processmission.com>
From:  Chao Liu via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 03, 2026 at 03:21:19PM +0800, Joel Stanley wrote:
> sifive_plic_create() maps the device it creates into system_memory,
> which prevents its use by SoCs that map devices into their own memory
> container.
> 
> Add a MemoryRegion parameter and map the device into it instead of
> calling sysbus_mmio_map(). All callers pass system_memory, so there is
> no change in behaviour.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  include/hw/intc/sifive_plic.h | 4 ++--
>  hw/intc/sifive_plic.c         | 7 ++++---
>  hw/riscv/k230.c               | 3 ++-
>  hw/riscv/microchip_pfsoc.c    | 3 ++-
>  hw/riscv/shakti_c.c           | 3 ++-
>  hw/riscv/sifive_e.c           | 2 +-
>  hw/riscv/sifive_u.c           | 3 ++-
>  hw/riscv/virt.c               | 1 +
>  8 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
> index 32973dbf281e..064754c3f628 100644
> --- a/include/hw/intc/sifive_plic.h
> +++ b/include/hw/intc/sifive_plic.h
> @@ -76,8 +76,8 @@ struct SiFivePLICState {
>      qemu_irq *s_external_irqs;
>  };
>  
> -DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
> -    uint32_t num_harts,
> +DeviceState *sifive_plic_create(MemoryRegion *container,
> +    hwaddr addr, char *hart_config, uint32_t num_harts,
>      uint32_t hartid_base, uint32_t num_sources,
>      uint32_t num_priorities, uint32_t priority_base,
>      uint32_t pending_base, uint32_t enable_base,
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index 9c84ff06a9fd..90f17e6ee724 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -473,8 +473,8 @@ type_init(sifive_plic_register_types)
>  /*
>   * Create PLIC device.
>   */
> -DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
> -    uint32_t num_harts,
> +DeviceState *sifive_plic_create(MemoryRegion *container,
> +    hwaddr addr, char *hart_config, uint32_t num_harts,
>      uint32_t hartid_base, uint32_t num_sources,
>      uint32_t num_priorities, uint32_t priority_base,
>      uint32_t pending_base, uint32_t enable_base,
> @@ -499,7 +499,8 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
>      qdev_prop_set_uint32(dev, "context-stride", context_stride);
>      qdev_prop_set_uint32(dev, "aperture-size", aperture_size);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    memory_region_add_subregion(container, addr,
> +        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>  
>      plic = SIFIVE_PLIC(dev);
>  
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 1ef4260c5391..6b0f0453c80b 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -134,7 +134,8 @@ static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
>      plic_hart_config = riscv_plic_hart_config_string(hartid_count);
>  
>      /* Per-socket PLIC */
> -    return sifive_plic_create(memmap[K230_DEV_PLIC].base,
> +    return sifive_plic_create(get_system_memory(),
> +                              memmap[K230_DEV_PLIC].base,
>                                plic_hart_config, hartid_count, base_hartid,
>                                K230_PLIC_NUM_SOURCES,
>                                K230_PLIC_NUM_PRIORITIES,
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index a6026776d4de..1f6d9f5ae1ed 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -282,7 +282,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>      plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
>  
>      /* PLIC */
> -    s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
> +    s->plic = sifive_plic_create(system_memory,
> +        memmap[MICROCHIP_PFSOC_PLIC].base,
>          plic_hart_config, ms->smp.cpus, 0,
>          MICROCHIP_PFSOC_PLIC_NUM_SOURCES,
>          MICROCHIP_PFSOC_PLIC_NUM_PRIORITIES,
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index 86ff8f8fcaab..62052bf7c61e 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -115,7 +115,8 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
>  
>      sysbus_realize(SYS_BUS_DEVICE(&sss->cpus), &error_abort);
>  
> -    sss->plic = sifive_plic_create(shakti_c_memmap[SHAKTI_C_PLIC].base,
> +    sss->plic = sifive_plic_create(system_memory,
> +        shakti_c_memmap[SHAKTI_C_PLIC].base,
>          (char *)SHAKTI_C_PLIC_HART_CONFIG, ms->smp.cpus, 0,
>          SHAKTI_C_PLIC_NUM_SOURCES,
>          SHAKTI_C_PLIC_NUM_PRIORITIES,
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 0ea444f43bc5..81d7995ddcfb 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -214,7 +214,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>          memmap[SIFIVE_E_DEV_MROM].base, &s->mask_rom);
>  
>      /* MMIO */
> -    s->plic = sifive_plic_create(memmap[SIFIVE_E_DEV_PLIC].base,
> +    s->plic = sifive_plic_create(sys_mem, memmap[SIFIVE_E_DEV_PLIC].base,
>          (char *)SIFIVE_E_PLIC_HART_CONFIG, ms->smp.cpus, 0,
>          SIFIVE_E_PLIC_NUM_SOURCES,
>          SIFIVE_E_PLIC_NUM_PRIORITIES,
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 6bbf2c4504d8..632194a06ea1 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -774,7 +774,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
>  
>      /* MMIO */
> -    s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
> +    s->plic = sifive_plic_create(system_memory,
> +        memmap[SIFIVE_U_DEV_PLIC].base,
>          plic_hart_config, ms->smp.cpus, 0,
>          SIFIVE_U_PLIC_NUM_SOURCES,
>          SIFIVE_U_PLIC_NUM_PRIORITIES,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 8fd742181e28..a7b5af4e4c88 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -561,6 +561,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
>  
>      /* Per-socket PLIC */
>      return sifive_plic_create(
> +             get_system_memory(),
>               memmap[VIRT_PLIC].base + socket * memmap[VIRT_PLIC].size,
>               plic_hart_config, hart_count, base_hartid,
>               VIRT_IRQCHIP_NUM_SOURCES,
> -- 
> 2.47.3
> 

