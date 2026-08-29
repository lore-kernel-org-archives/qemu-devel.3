Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C14C61DD3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09R6-0004IA-KL; Fri, 28 Aug 2026 23:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09R6-0004Hw-0K; Fri, 28 Aug 2026 23:08:52 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09R3-0005ml-Kv; Fri, 28 Aug 2026 23:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrhhptgbkiDS9YSQqoODiiHWqG4qWTVdFXFQT/KtKI5s6TSrzWaxejSzdpkGOyk7xvD2iliXz3k2Z6315NJJwn8gTWiTVXbvLHBO7sitdiPDzeYcT8lzYmxFkDGpKS9OhDgwB8K+O3ukPn8NKGgCQTG5ZOQY2l7WnUf4uSxpv2euWr1mYhXQ/Yye5aHps8xrauOqMaKj7Pcju0oa9pB2I0Vu2FTEwIny+aPYnPJb7W08l4oeZm1j58N8M5zeNf6opiDwDCcXY3jUdDKuChhcBQL3/AJWfsYlg2e5q0FZey+Px6puKH9wn1+GB4mzWNXYaRhK2GdsCXX4TW2E/8vHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9fzhNQym+sXch0QmdPybqubg9z9qjM2rMAK6ItZx1w=;
 b=zAOPdlwV7xBnJODmq8qshChbhhfHU0Qfn7KVP7ElQm68AvRzsmMVvKncruHrvfLdqrYKe64IJuC7YVX4ypK+cGU4ZP14NuoKZqa0Mu6lLtdq3cOCyAYKAgeYAXCen/EUTGHLwTz++8DxYvfsZawZFkOcW7nRvQwwy50Vvqow3TWQTVRKNprLN5ZxK8MjvF5FSxTsChJ4ZpIlxvSec/w4NK1aoK8w/0zXSt6q1Qb6kFtM2Af9KNAnbSv+pNhZtQDi3or4ZLX6uqkjLBaNvAh0pd3QrLWq+hYi8hFgZx7+f8VERWl0ge0moVx+E9w+N/pOUsidbuLROP0wn+l1+y11Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9fzhNQym+sXch0QmdPybqubg9z9qjM2rMAK6ItZx1w=;
 b=f6O0Z8UkEa4W4cqfF6yrKU9DCO+uYZjWEerf8eVPOUugHXCnnYZ2NN5/tDaf/0g0ywe9EEqTCmEeRZyJ9rxDYI7TsMAMtOQmhFhHDH4vOXrsdrd7KrLrYVYzMHtAJ/G/AI2VuZWM9fVYqP8Zhmkode7lTVsc7DMSnmsTfZlZNxqkLYb6SHygy2Wd2rNQ8HVj5UQXFTLkTUW0X1E/kb9U9HEGKfSuCXnpyRpNO0GE9smr3n2JZFyxcoLxZr+v1uyAA3SA49OuvfN7N79i/Q26BsMZXBCZMba9PI2hrvHVCnIbvx7xEraDPyx14FgyLKj2iWGFkaI4dz7sj98oaPgrhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:08:45 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:08:45 +0000
Date: Sat, 29 Aug 2026 11:08:39 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 06/15] hw/riscv/fdt_common, virt.c: add
 riscv_create_fdt_imsic()
Message-ID: <apJNJ6nwf4zrWUzh@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-7-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828203918.350131-7-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH8PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::12) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a3a0ae-e987-4168-e413-08df057ad621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TRasXn83wuXxEN4YCe/5Vhah0rcDDesS1athfMzv9DET0ZZckyrR+xXnZtUbpwLwlrGrz5SbxTJdW5TPU/fb9P1IJGfLxNjKU2d63bbKVQ9fIOF+HI1x1jWMIuClQhFsRfUdiL9ZVl5E970zjDIsW8wORpw4kdAcgZd7jmA4f18m1o4VJVugixDPaYnf6a2qHzbrwgJP3ibn8OtZzNBOt8Lxaq4rX2RkwVH4IMO8GXRav6L2x4DilUFBdb8ED1FNC2S8e2zdqEhrpvXojyPvoamq4UyNFtkZQ/HUTQgsoFCGjJBO1KhJFMoEsbH/W6qwQfkwNh2sftjwRXpEAPIooYoC5G27Klv39jTXTebIT9ktg+VGkTOcTHAAbhlz7/lxJXp4QCvqY/u/B6KgtLVNyE+frs8OnMIoFhK+ntZ547NvQfjijnAQ66VgsifwNoJSwOHnQw+EQCIfsEp5sMGiHh4VnSTevU35uwiBvCxCFYvCB2uuzZ4+xHDBuX+osNkOQmrerlWf9yqr2TrpBbNZZzNmqigGlHJMwBrGYIUFp58y1lUPzFq20h236Lecj+4jxTAnj4K4vjfHWyUL+ZyMh5VZP61YFGt7cfOfZJqU2Gwmma2tfhwAGbI8LPvANRlk3q1hBbndobz9U2sWDxe2VXke+e4cWOsubgOEKp7hKYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9Uj5mR4tjMBfGdDAE5JNJUHtSZF7lYqke0NjJ4GQJIhY0kkjbjw4ff5xz6?=
 =?iso-8859-1?Q?vogtbwd/G+OUQ/1i6OOwOFTqao3ua5rWrd/hKFmR11mDfR5e82Uxe/2gwF?=
 =?iso-8859-1?Q?mYpoGqLGrJ1ZKFNiAnsGQ8mn+CG7Ajye98O4etPVS7z9iQLzIk4XYj14Eb?=
 =?iso-8859-1?Q?rSD39eI/iGQeNKflvZeopnBj+CfcfcaX4vSRP0lbxtSIc0XIzfPu1XxFuF?=
 =?iso-8859-1?Q?pvXokL3jUU5Zo3qKpMQIvaswcgjXXmJw3US2tlAJqS6NTXLBE0+rlSD3F4?=
 =?iso-8859-1?Q?6mkMdhN5sk1BYh4SiKa/31O6k8pGJdgduqKhdN5N5HCr/EHqEAOnzIfECv?=
 =?iso-8859-1?Q?HJNSJ5aW3bwk3Ke5/BdwBS5jskl7P2ye92Qtl603MpnwiAdK6IkbWXw9ms?=
 =?iso-8859-1?Q?NKd7GXGEaqR5Js6NOTnmDfQMIVWBZn726zwnDm1riybxQGBEx0D3Spvjh7?=
 =?iso-8859-1?Q?WQ/vVPAKK3TG4dnhzI7dv6CUmvggtskLcZyu2KSOwGG/7F+BPNwDKgAV7s?=
 =?iso-8859-1?Q?BVzfBKiZN6kGTqY8AAaqKFCBg+U2PL/fKWS1kJWgl81eUjbi9EL8qwrBhc?=
 =?iso-8859-1?Q?qsthaG8wH693dyfkR2pSMqJ8Ce8p47aGvEIIaEvOBt81TM6TXDTWQAYHhU?=
 =?iso-8859-1?Q?nDSFL9Pl1wmYUh0uQy6FBRQ5JZl0AMaxXiFp22rf867n3TK8qvTUhpiPxG?=
 =?iso-8859-1?Q?j2Jya+ur+N26vx6qzAGbwDNzvBnFZLr15xrZRoFf7Xtd1sSSxyLbRDyeIB?=
 =?iso-8859-1?Q?Ensugr2r/dGEPQ+KVj+phIFwrqV4ZoXT1U8P/5zOHRKBDqXBUF2D+r7hg/?=
 =?iso-8859-1?Q?iFSS9xMUxUI5E04tOq4QEOGSEwNKKqgNGzivr/Bh8qf6huWfqkIbF+iM8R?=
 =?iso-8859-1?Q?fnuZaVfZVpcwIq1IYbR5Tz3yZyVWkxTf+eNyficlVfBwbvCaj9CE1Cwzns?=
 =?iso-8859-1?Q?47SWJp/1yd3QbljjGKx5YAy5aOtAftTkoyRyRuztcHtTFtOj1LBjLuALDT?=
 =?iso-8859-1?Q?llL6Y+jB5Q6O8Q20pxNButcTi9+mGj82Z8x9FBJ3bZhr20evf1ioCzzSCE?=
 =?iso-8859-1?Q?uuSYqQ+kkVWFOIgUtQqG0esIgYNfDSTyerYvNuyS4//U0D+P8ML+5KSJps?=
 =?iso-8859-1?Q?FXwX/M7Agz6FaWnhaZ19Pkff5y/fqgvOiOIHD+dNkHO8TLcNXStTAJiTcX?=
 =?iso-8859-1?Q?IOPh3lPhXuPTPNWt6IbXK8Rckq/IB+eJHY7Q/MZ/ltr7BUiXsCw3r98zEO?=
 =?iso-8859-1?Q?8hXzkgWHofUJ9CwkZLzd2DyERb6BPJ5/PN9NyogHlugPgvJYpPC1u5sXGP?=
 =?iso-8859-1?Q?mrrfc5yGGsZ5vONrpRoJxK1Q+idt0z3z0h5IRoCmyOYX3OUWySucwmYqc/?=
 =?iso-8859-1?Q?k1FtueFcATK+QDlzmCEZw0+CA/LJS/a/DUxecX+6ArFHslZDW4whmeysoJ?=
 =?iso-8859-1?Q?uNIQnxWu/bFIb4VhXXZcp2wHhNezpLMhG0f5/0vUrtDXwEvCRCXzsU+cTd?=
 =?iso-8859-1?Q?d4O9bAQp40pMWQYMUAGGC90x78HddrC3EetAYulVahHnH0/aBuJgqpaoC8?=
 =?iso-8859-1?Q?fJME+HsE3ZDTBxZQPnLJQiLoEwDz4dNokug6M+iVB0wdpd1PJO0RKTIdwl?=
 =?iso-8859-1?Q?JL+arWBC0duXst8wUNkw7g40BtAkKBS3CVVPl8oXkqJidw2prrMM25Kw3M?=
 =?iso-8859-1?Q?+Jvdv2qEBvxTd/kXz8EDrQQ2KwBKhtumhE39+7LQDz4FRPaOSuCAi0K4zn?=
 =?iso-8859-1?Q?xrwQ1i1F1vg+E9+RmtS3muR864p4TqWS78SZiCY6LjGsvMnIfKncsR66ZG?=
 =?iso-8859-1?Q?nKc6PCq78SZnDnyBE+fqpCHyKjyyUZg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a3a0ae-e987-4168-e413-08df057ad621
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:08:44.9493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTt0wvwplNsNCYqwsjX9T8FLvBqyk+azOiWHVO+nTPtaEmqXdv8QSqsPWPQ6iOk9gttbxTLAh6ngDDo+Wb0HUEGDxOEkKRbvxjuDfPG4IGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5574
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Aug 28, 2026 at 05:39:08PM +0800, Daniel Henrique Barboza wrote:
> The FDT related to interrupt controllers should definitely be put into
> helpers, even if only 'virt' benefits from it, due to the amount of code
> that is relieved from the board alone.  We'll start with 'imsic'.
> 
> For this endeavor we're going to use a helper struct that will carry all
> the extra FDT arguments in a human format.  The alternative would be to
> add 8 more function arguments, on top of 4 phandle arguments that we're
> passing around in all these controllers, and that's not only a poor
> reading experience but it's quite error prone too.
> 
> We do not want to crowd the fdt-helper with non-FDT logic, hence we're
> handling the !kvm_enabled() cond in virt.c using the imsic_m_base
> argument.  This is a pattern that we'll fall back on in the next
> patches too.
> 
> No FDT changes made.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/fdt-common.c         |  98 ++++++++++++++++++++++++++++++
>  hw/riscv/virt.c               | 108 +++++-----------------------------
>  include/hw/riscv/fdt-common.h |  21 +++++++
>  3 files changed, 133 insertions(+), 94 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index 38813b6aa7..ae24ad0011 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -15,8 +15,10 @@
>  #include "target/riscv/cpu_bits.h"
>  #include "hw/riscv/riscv-iommu-bits.h"
>  #include "hw/riscv/iommu.h"
> +#include "hw/intc/riscv_imsic.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pcie_host.h"
> +#include "hw/riscv/aia.h"
>  
>  void *riscv_create_board_device_tree(const char *model, const char *compatible,
>                                       int *fdt_size)
> @@ -495,3 +497,99 @@ void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
>  
>      create_pcie_irq_map(fdt, name, irq_pcie_phandle, aia_type, pcie_irq);
>  }
> +
> +static void create_fdt_one_imsic(void *fdt, IMSICFdtProps *props,
> +                                 hwaddr base_addr,
> +                                 uint32_t *intc_phandles, uint32_t msi_phandle,
> +                                 bool m_mode, uint32_t imsic_guest_bits)
> +{
> +    RISCVHartArrayState *soc = (RISCVHartArrayState *)props->soc;
> +    g_autofree char *imsic_name = NULL;
> +    g_autofree uint32_t *imsic_cells = NULL;
> +    g_autofree uint32_t *imsic_regs = NULL;
> +    uint32_t imsic_max_hart_per_socket = 0;
> +    static const char * const imsic_compat[2] = {
> +        "qemu,imsics", "riscv,imsics"
> +    };
> +
> +    imsic_cells = g_new0(uint32_t, props->smp_cpus * 2);
> +    imsic_regs = g_new0(uint32_t, props->socket_count * 4);
> +
> +    for (int cpu = 0; cpu < props->smp_cpus; cpu++) {
> +        imsic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> +        imsic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
> +    }
> +
> +    for (int socket = 0; socket < props->socket_count; socket++) {
> +        hwaddr imsic_addr = base_addr + socket * props->imsic_group_max_size;
> +        uint32_t imsic_size = IMSIC_HART_SIZE(imsic_guest_bits) *
> +                              soc[socket].num_harts;
> +
> +        imsic_regs[socket * 4 + 0] = cpu_to_be32(imsic_addr >> 32);
> +        imsic_regs[socket * 4 + 1] = cpu_to_be32(imsic_addr);
> +        imsic_regs[socket * 4 + 2] = 0;
> +        imsic_regs[socket * 4 + 3] = cpu_to_be32(imsic_size);
> +        if (imsic_max_hart_per_socket < soc[socket].num_harts) {
> +            imsic_max_hart_per_socket = soc[socket].num_harts;
> +        }
> +    }
> +
> +    imsic_name = g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx,
> +                                 base_addr);
> +    qemu_fdt_add_subnode(fdt, imsic_name);
> +
> +    qemu_fdt_setprop_string_array(fdt, imsic_name, "compatible",
> +                                  (char **)&imsic_compat,
> +                                  ARRAY_SIZE(imsic_compat));
> +
> +    qemu_fdt_setprop_cell(fdt, imsic_name, "#interrupt-cells",
> +                          FDT_IMSIC_INT_CELLS);
> +    qemu_fdt_setprop(fdt, imsic_name, "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop(fdt, imsic_name, "msi-controller", NULL, 0);
> +    qemu_fdt_setprop(fdt, imsic_name, "interrupts-extended",
> +                     imsic_cells, props->smp_cpus * sizeof(uint32_t) * 2);
> +    qemu_fdt_setprop(fdt, imsic_name, "reg", imsic_regs,
> +                     props->socket_count * sizeof(uint32_t) * 4);
> +    qemu_fdt_setprop_cell(fdt, imsic_name, "riscv,num-ids",
> +                          props->irqchip_num_msis);
> +
> +    if (imsic_guest_bits) {
> +        qemu_fdt_setprop_cell(fdt, imsic_name, "riscv,guest-index-bits",
> +                              imsic_guest_bits);
> +    }
> +
> +    if (props->socket_count > 1) {
> +        qemu_fdt_setprop_cell(fdt, imsic_name, "riscv,hart-index-bits",
> +                              imsic_num_bits(imsic_max_hart_per_socket));
> +        qemu_fdt_setprop_cell(fdt, imsic_name, "riscv,group-index-bits",
> +                              imsic_num_bits(props->socket_count));
> +        qemu_fdt_setprop_cell(fdt, imsic_name, "riscv,group-index-shift",
> +                              IMSIC_MMIO_GROUP_MIN_SHIFT);
> +    }
> +    qemu_fdt_setprop_cell(fdt, imsic_name, "phandle", msi_phandle);
> +}
> +
> +void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *props,
> +                            uint32_t *next_phandle, uint32_t *intc_phandles,
> +                            uint32_t *msi_m_phandle, uint32_t *msi_s_phandle)
> +{
> +    if (next_phandle) {
> +        *msi_m_phandle = (*next_phandle)++;
> +        *msi_s_phandle = (*next_phandle)++;
> +    } else {
> +        *msi_m_phandle = qemu_fdt_alloc_phandle(fdt);
> +        *msi_s_phandle = qemu_fdt_alloc_phandle(fdt);
> +    }
> +
> +    if (props->imsic_m_base) {
> +        /* M-level IMSIC node */
> +        create_fdt_one_imsic(fdt, props, props->imsic_m_base,
> +                             intc_phandles, *msi_m_phandle, true, 0);
> +    }
> +
> +    /* S-level IMSIC node */
> +    create_fdt_one_imsic(fdt, props, props->imsic_s_base,
> +                         intc_phandles, *msi_s_phandle, false,
> +                         imsic_num_bits(props->aia_guests + 1));
> +
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a28e6d200a..468ec90696 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -320,98 +320,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>      }
>  }
>  
> -static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
> -                                 uint32_t *intc_phandles, uint32_t msi_phandle,
> -                                 bool m_mode, uint32_t imsic_guest_bits)
> -{
> -    int cpu, socket;
> -    g_autofree char *imsic_name = NULL;
> -    MachineState *ms = MACHINE(s);
> -    int socket_count = riscv_socket_count(ms);
> -    uint32_t imsic_max_hart_per_socket, imsic_size;
> -    hwaddr imsic_addr;
> -    g_autofree uint32_t *imsic_cells = NULL;
> -    g_autofree uint32_t *imsic_regs = NULL;
> -    static const char * const imsic_compat[2] = {
> -        "qemu,imsics", "riscv,imsics"
> -    };
> -
> -    imsic_cells = g_new0(uint32_t, ms->smp.cpus * 2);
> -    imsic_regs = g_new0(uint32_t, socket_count * 4);
> -
> -    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
> -        imsic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -        imsic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
> -    }
> -
> -    imsic_max_hart_per_socket = 0;
> -    for (socket = 0; socket < socket_count; socket++) {
> -        imsic_addr = base_addr + socket * VIRT_IMSIC_GROUP_MAX_SIZE;
> -        imsic_size = IMSIC_HART_SIZE(imsic_guest_bits) *
> -                     s->soc[socket].num_harts;
> -        imsic_regs[socket * 4 + 0] = cpu_to_be32(imsic_addr >> 32);
> -        imsic_regs[socket * 4 + 1] = cpu_to_be32(imsic_addr);
> -        imsic_regs[socket * 4 + 2] = 0;
> -        imsic_regs[socket * 4 + 3] = cpu_to_be32(imsic_size);
> -        if (imsic_max_hart_per_socket < s->soc[socket].num_harts) {
> -            imsic_max_hart_per_socket = s->soc[socket].num_harts;
> -        }
> -    }
> -
> -    imsic_name = g_strdup_printf("/soc/interrupt-controller@%lx",
> -                                 (unsigned long)base_addr);
> -    qemu_fdt_add_subnode(ms->fdt, imsic_name);
> -    qemu_fdt_setprop_string_array(ms->fdt, imsic_name, "compatible",
> -                                  (char **)&imsic_compat,
> -                                  ARRAY_SIZE(imsic_compat));
> -
> -    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
> -                          FDT_IMSIC_INT_CELLS);
> -    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
> -    qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
> -    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
> -                     imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
> -    qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
> -                     socket_count * sizeof(uint32_t) * 4);
> -    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,num-ids",
> -                     VIRT_IRQCHIP_NUM_MSIS);
> -
> -    if (imsic_guest_bits) {
> -        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,guest-index-bits",
> -                              imsic_guest_bits);
> -    }
> -
> -    if (socket_count > 1) {
> -        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,hart-index-bits",
> -                              imsic_num_bits(imsic_max_hart_per_socket));
> -        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-bits",
> -                              imsic_num_bits(socket_count));
> -        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-shift",
> -                              IMSIC_MMIO_GROUP_MIN_SHIFT);
> -    }
> -    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "phandle", msi_phandle);
> -}
> -
> -static void create_fdt_imsic(RISCVVirtState *s,
> -                             uint32_t *phandle, uint32_t *intc_phandles,
> -                             uint32_t *msi_m_phandle, uint32_t *msi_s_phandle)
> -{
> -    *msi_m_phandle = (*phandle)++;
> -    *msi_s_phandle = (*phandle)++;
> -
> -    if (!kvm_enabled()) {
> -        /* M-level IMSIC node */
> -        create_fdt_one_imsic(s, s->memmap[VIRT_IMSIC_M].base, intc_phandles,
> -                             *msi_m_phandle, true, 0);
> -    }
> -
> -    /* S-level IMSIC node */
> -    create_fdt_one_imsic(s, s->memmap[VIRT_IMSIC_S].base, intc_phandles,
> -                         *msi_s_phandle, false,
> -                         imsic_num_bits(s->aia_guests + 1));
> -
> -}
> -
>  /* Caller must free string after use */
>  static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
>  {
> @@ -585,8 +493,20 @@ static void create_fdt_sockets(RISCVVirtState *s,
>      }
>  
>      if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
> -        create_fdt_imsic(s, phandle, intc_phandles,
> -                         &msi_m_phandle, &msi_s_phandle);
> +        IMSICFdtProps props = {
> +            .soc = &s->soc,
> +            .socket_count = riscv_socket_count(ms),
> +            .smp_cpus = ms->smp.cpus,
> +            .imsic_m_base = !kvm_enabled() ? s->memmap[VIRT_IMSIC_M].base : 0,
> +            .imsic_s_base = s->memmap[VIRT_IMSIC_S].base,
> +            .imsic_group_max_size = VIRT_IMSIC_GROUP_MAX_SIZE,
> +            .irqchip_num_msis = VIRT_IRQCHIP_NUM_MSIS,
> +            .aia_guests = s->aia_guests
> +        };
> +
> +        riscv_create_fdt_imsic(ms->fdt, &props, phandle, intc_phandles,
> +                               &msi_m_phandle, &msi_s_phandle);
> +
>          *msi_pcie_phandle = msi_s_phandle;
>      }
>  
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index 3750230865..182c03d8ce 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -10,6 +10,8 @@
>  #define RISCV_VIRT_FDT_H
>  
>  #include "target/riscv/cpu.h"
> +#include "hw/core/boards.h"
> +#include "hw/riscv/riscv_hart.h"
>  
>  #define FDT_PCI_ADDR_CELLS    3
>  #define FDT_PCI_INT_CELLS     1
> @@ -32,6 +34,22 @@ typedef enum RISCVAIAType {
>      AIA_TYPE_APLIC_IMSIC,
>  } RISCVAIAType;
>  
> +typedef struct IMSICFdtProps {
> +    /*
> +     * Machines will statically allocate RISCVHartArrayState[] pointer,
> +     * e.g. "RISCVHartArrayState soc[VIRT_SOCKETS_MAX]".  We'll have
> +     * to use a void* pointer to handle a soc with variable sizes.
> +     */
> +    void *soc;
> +    hwaddr imsic_m_base;
> +    hwaddr imsic_s_base;
> +    int socket_count;
> +    int smp_cpus;
> +    int imsic_group_max_size;
> +    int irqchip_num_msis;
> +    int aia_guests;
> +} IMSICFdtProps;
> +
>  void *riscv_create_board_device_tree(const char *model, const char *compatible,
>                                       int *fdt_size);
>  void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> @@ -77,4 +95,7 @@ void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
>                             uint32_t irq_pcie_phandle,
>                             uint32_t msi_pcie_phandle,
>                             uint32_t iommu_sys_phandle, uint32_t pcie_irq);
> +void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *fdt_props,
> +                            uint32_t *next_phandle, uint32_t *intc_phandles,
> +                            uint32_t *msi_m_phandle, uint32_t *msi_s_phandle);
>  #endif
> -- 
> 2.43.0
> 

