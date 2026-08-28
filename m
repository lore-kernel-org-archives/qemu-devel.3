Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE03C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 19:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x01pM-0001hP-Hg; Fri, 28 Aug 2026 15:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x01pK-0001gD-Fr; Fri, 28 Aug 2026 15:01:22 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x01pH-0004dF-W5; Fri, 28 Aug 2026 15:01:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcKUfukV18wVpR1Zf/PpFsgaAr5I4YCUnByO7moZ8YhTMkRhjgsEOvJv3okcw/VqReH2A+1JLoipmkA0XOoa4lz8W1vc37x4PHSDizCKVwr3PSmDySAZ1ZgwxSzfh4eHGPnHDQRVZrCSePOjAJf7br1Eu4WvpVJZ11hUw7wUA1bVo949Xe4KtRkHbeIXxP8C48wnUsb1Z3XFy+54zBIxtcaPLMhSrOJbSmCWpwZL+pYRAQhwyMu0jWAavasJckMBb1A6gBJJz74BR69jVKUk5pzQHuFYlivVS8uaM388JZyhXkppFmoqr4K0ExrT/URe8zUS0kROOnlajfwwfqHXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wVtsUhbto/DC/z1nS/YtTVwD82HKKrtZgrSbhxZFQs=;
 b=t3CrVAKU4IJBJOxz230qclth28oglZyJCJy+FlmQeDz9D4Z6BU3yV5WUwmCSE88MKHQEWHtrTU12NOBk1cSYyS4WNaAFdfoe2Yle7m4eBxRWYGsbyXiWjx2ND3LE3G7O/N3FrBk7/EoHOj+dQjIEkunK6XKeEjfmuj5i+ALEH2kfzGIykGmXQtStqyd3vQUw8MPdD+t7AQU2ZzvGs/FdorcXC83sp16BndCXfupsIRRtEsEgw6CbsUPgeJivopL8v7oUncBMN8U6Yx35MPP6nCnUIcNqWESdCg5jHls6sEUowYs+NppYSj7Ym0gbajXhyRL+uPNw4t7fp/owac0KFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wVtsUhbto/DC/z1nS/YtTVwD82HKKrtZgrSbhxZFQs=;
 b=W/IqKrshaDrp5ELzx6UbNcCeK/iN1CDWxJetK2yzk8YWL1k9ICG4FcwHk9V3f7NR2bGy3XNDoEkbjKJkMf6kzwQrXthbGE4u0FiG8G9x14PUunOUPTeExeo+Z1XaDiDBcnyycqULSpcGwk7iV41+j6UGn3qNW3gp/PGdIEbbhhP8eYssl1JXPctYxwdNxSLzCWPDzJBXeIfXXVaFEU+10sPt5CVd2br5Q1Mg9QZZQEMyuF8hZDxHrfSuFDEC7V6G/gi2VfioUanszsVfmGOhksMlZna37apygULGRQbJsex5Mg8LL0p9l9H2v2AZIr6M+jJovZ29yEFkJ06Pshq9CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SE3PR02MB9321.apcprd02.prod.outlook.com (2603:1096:101:333::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 28 Aug
 2026 19:01:12 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 19:01:12 +0000
Date: Sat, 29 Aug 2026 03:01:06 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v4 08/14] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_socket_aclint()
Message-ID: <apHH1upnh8udUUT-@ChaodeMacBook-Pro.local>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
 <20260827222608.329788-9-daniel.barboza@oss.qualcomm.com>
 <apEGhbfBmPgZrT8r@ChaodeMacBook-Pro.local>
 <8274e2f5-38a5-4aee-842d-c1408a166f51@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8274e2f5-38a5-4aee-842d-c1408a166f51@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SE3PR02MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7d3c14-e17d-4dad-e643-08df0536ba39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|56012099006|10067099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: e6q+SqVtBa8DTBklULyv9HtbGQvupR/dhjlM8Oelxy2SbCt6hqxwfjcLSzqu5qOZ3yIt3VJSCKh7vlIAy7EnMBjTQsjNA+3Ei7K6WqC0PEeKTiIPvnKU2DNsyIz539D5Do9gPBH+SGxTLNfeb6v8JwneVfJlZ+QWHXxCNV6JKlF9E1P3bdufELc8rbbLLtOE5rtD4VF8kcpivZAk6/4X1NsYLZd7NuiyRxHSK/lr4fnwkgt/q0foCXEaYcEOLMq0ki+WTrj+k/DuG1Ysg0IdhbBEIYtUJ9WQ0iggEbb7BtfQono4trHSVmntUFYAfiRiwpDziascD/mb7tQwzBQhpMwnLAzl6uUY3h1Xx50GSfqyquSFJdqpwRPgzNQlCAwV2seBaYkwvun1i6Wv4jcVopGcmT5ymaZEdAA/5J4s2mZREjpPtsJ9dMYQ4uB+/WMSbNmVuan/r1zkFYitzt1PMuBMEuOho/21HlMgb1jAy1/JgvC1rVbtU4N5U+ZuUpUeNgeqW2nofBpDIl03n3rGw2C2BTY2uWJct0WGYayGRpCN+bbp2Md4rjFsjurcfXUPFjkpd015TlnqPTuE1hJri1Y1mQeKgmVzOP+lBbqmTbRkNOYM+RqdKLrKPmCyuClt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(10067099003)(6133799003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?U3t0ggsYafJLELAWe2dPSCZ8+OjBafRN1lSYtqfrIO+woBttRPzBqoc0XL?=
 =?iso-8859-1?Q?Fphc9XLsDSyZvRjTr4PFrooL8YApt8v9/plg6rLsql3lLXpXyE9ggtnxJx?=
 =?iso-8859-1?Q?Agak9tpKfXSGPu7BVsl9D2ZzmEhSuXXhdvLF86T/5Ryy6n9FPSva4pnjdm?=
 =?iso-8859-1?Q?7yW+slW7ldLloWiyHywUHLyDdoqr3LMCpAYvNbT7iyJ+dO6bzHQq5lrDSp?=
 =?iso-8859-1?Q?j82SNBKovWkwCmchREMqsy3uw7MC16O8spuhxTHZqG7Kyl/7l4QNiAoNkI?=
 =?iso-8859-1?Q?eEF1dT70cnO0RfdemS9po0Mz+HtjVL57UhShIdwYn9FO770BDhoawZKMRe?=
 =?iso-8859-1?Q?sZVuhlLz2yvE9B/rw+eF76XaGqbcTB+GVR03+0UZPy54/x8rB5Gl6URotP?=
 =?iso-8859-1?Q?Kj5z1v861uBbuS87S/evEENRWuM7REReAfCBEmrfYNfX4/RRneEvyjTiUc?=
 =?iso-8859-1?Q?h0OOa7KGKEPy+7lO6bQ9WelVkV1pFslcEJfvp7a2wC0xZVLM5ShJYfaNB2?=
 =?iso-8859-1?Q?Gk95snjJi0q+NtlYx77EnsXdvY4BtOhI4xYknGPZHxjIilCyRqJWi4htu0?=
 =?iso-8859-1?Q?835CAsR99rjOfm5hPkdgz32TtS7pfrTgJ8b6Dce9MWhT8FIXllVSrA04Mp?=
 =?iso-8859-1?Q?0QRZVRJ8mUJeTy7ugkrSv4FN+en4+LRdBOiXZNzZrBuDUrS7CvGdD7Jxqu?=
 =?iso-8859-1?Q?/l8I67L/R4wOnD+hz/up9mYaLMPhrFNafdRSTO0CBNrWyv18+Cx2970dbj?=
 =?iso-8859-1?Q?FoW6H5YilaIb7XE/CkbH6NjD9kqTAkx3m8LSWc7bxEVy1lIlmA0l06TEQC?=
 =?iso-8859-1?Q?3vrZKHj6quBNtDQfMV0G32rAGVxd9ZeYAXN7lgR5o/p3K5yVy7GfZiuVMN?=
 =?iso-8859-1?Q?MmWukzeTlysCAVW2w8pD+zNlSDyWCozlImlWQNPs6LIuOZMqPPJJ6ybFpR?=
 =?iso-8859-1?Q?NQemXk8clQO7IXXDX41tYxxT+0S/rodTXTxEYDmxBoJNwyYPXGZghmLgom?=
 =?iso-8859-1?Q?txz3i0+YMZ4u2gRbf/pHF4efLq/FcMFGDir/tK1Rc9AayhIaLE5sqxYYKn?=
 =?iso-8859-1?Q?QP+hC3BD1p6ZPvd/ui4q/lB8meEvpDtvM9122G0L61Vsc88y6pl+d1h6qd?=
 =?iso-8859-1?Q?gMTb9ozG1TJTV+44ssBBOsWPzdhp1MIeOtseiH3+A3QNhVx8g+rRwxeFk4?=
 =?iso-8859-1?Q?IYddrIfpADLNxd9RIoWtjK1YDsBBhyj2EjA5Fe40lY/0RbEBEsWm+YEU2q?=
 =?iso-8859-1?Q?B72DRr3yFRPY8zxU2q7iE6hWjbFXT34e64O6NToE9EIGDlKSgYuoqYw8mH?=
 =?iso-8859-1?Q?HR04G9J756GPdu4yWEgdYd5oXYkLYdzCixYMzbrKmSX/UQC9jXvcvyN/fs?=
 =?iso-8859-1?Q?s/RM6PlVlXCECUccODg+93ukjc4XgYEvlFtQrNbzc2oW1LCcCLVXJGzUDe?=
 =?iso-8859-1?Q?DaWt+kXlUiVuaxMzCNZ0McTZHwfrIDrOfw64i1kh4Wc0EMAuPMuNjRAD58?=
 =?iso-8859-1?Q?lTd2CmECKZXqI/Jrt48g8xP39PPLfQSI3RcoYMnic3EeuETdVt7lmHlGfx?=
 =?iso-8859-1?Q?5kJpRUvOPXiK8/COhCdBUD8a7rLlOE0tDqi18uMXF5Ux+BSDnQpZD9ibpG?=
 =?iso-8859-1?Q?6rxhGmhkQ4MXNvMDMw16jtxjON2ADO+Bf7xGpOmjr7Cb+vgyT0+r0o+Gch?=
 =?iso-8859-1?Q?azHqguZWiwA021ovLbGsRqQdtxom3ex/e84wCXkXaAfnBf419VV+vk4DU7?=
 =?iso-8859-1?Q?fKXUucMUTtBRr6rKrSwb4EpFFJdzZTzZSXEVS+FYr79w0eEx4AcmFrYbUq?=
 =?iso-8859-1?Q?unmVo+HiPiOkiHRQShnD1CBWQqqg8gg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7d3c14-e17d-4dad-e643-08df0536ba39
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 19:01:12.3679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rRT1IUDPjGTrYuZWjn9L/CkWIoPToIY19Q9Nk0HXhiAwuFnMyLE2mBabUAXsMaLI65+LwABnATXKNGVt3UkRYuFhScoDAYAqz6nnMMCON8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR02MB9321
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
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

Hi Daniel,

On Fri, Aug 28, 2026 at 12:40:38PM +0800, Daniel Henrique Barboza wrote:
> 
> 
> On 8/28/2026 1:13 AM, Chao Liu wrote:
> > On Thu, Aug 27, 2026 at 07:26:01PM +0800, Daniel Henrique Barboza wrote:
> > > Yet another FDT that we want to move to a helper to avoid copy/pasting
> > > code to other boards that will use a mtimer.  In particular the future
> > > 'riscv-server-ref' board.
> > > 
> > > No FDT changes made.
> > > 
> > > Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > > Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> > > ---
> > >   hw/riscv/fdt-common.c         |  96 ++++++++++++++++++++++++++++++++
> > >   hw/riscv/virt.c               | 101 ++++------------------------------
> > >   include/hw/riscv/fdt-common.h |  11 ++++
> > >   3 files changed, 119 insertions(+), 89 deletions(-)
> > > 
> > > diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> > > index d815c5adff..76a783709d 100644
> > > --- a/hw/riscv/fdt-common.c
> > > +++ b/hw/riscv/fdt-common.c
> > > @@ -16,6 +16,7 @@
> > >   #include "target/riscv/cpu_bits.h"
> > >   #include "hw/riscv/riscv-iommu-bits.h"
> > >   #include "hw/riscv/iommu.h"
> > > +#include "hw/intc/riscv_aclint.h"
> > >   #include "hw/intc/riscv_imsic.h"
> > >   #include "hw/pci/pci.h"
> > >   #include "hw/pci/pcie_host.h"
> > > @@ -702,3 +703,98 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
> > >       aplic_phandles[props->socket] = aplic_s_phandle;
> > >   }
> > > +
> > > +void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
> > > +                                    uint32_t *intc_phandles)
> > > +{
> > > +    uint32_t aclint_cells_size = props->num_harts * sizeof(uint32_t) * 2;
> > > +    g_autofree uint32_t *aclint_mswi_cells = NULL;
> > > +    g_autofree uint32_t *aclint_sswi_cells = NULL;
> > > +    g_autofree uint32_t *aclint_mtimer_cells = NULL;
> > > +    hwaddr addr, size;
> > > +    char *name;
> > > +    int cpu;
> > > +
> > > +    aclint_mswi_cells = g_new0(uint32_t, props->num_harts * 2);
> > > +    aclint_mtimer_cells = g_new0(uint32_t, props->num_harts * 2);
> > > +    aclint_sswi_cells = g_new0(uint32_t, props->num_harts * 2);
> > > +
> > > +    for (cpu = 0; cpu < props->num_harts; cpu++) {
> > > +        aclint_mswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> > > +        aclint_mswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_SOFT);
> > > +        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> > > +        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
> > > +        aclint_sswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> > > +        aclint_sswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_SOFT);
> > > +    }
> > > +
> > > +    if (props->aia_type != AIA_TYPE_APLIC_IMSIC) {
> > > +        addr = props->clint->base + (props->clint->size * props->socket);
> > > +        name = g_strdup_printf("/soc/mswi@%"HWADDR_PRIx, addr);
> > > +
> > > +        qemu_fdt_add_subnode(fdt, name);
> > > +        qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aclint-mswi");
> > > +        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> > > +                                     2, addr, 2, RISCV_ACLINT_SWI_SIZE);
> > > +        qemu_fdt_setprop(fdt, name, "interrupts-extended",
> > > +                         aclint_mswi_cells, aclint_cells_size);
> > > +        qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
> > > +        qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 0);
> > > +
> > > +        if (props->numa_enabled) {
> > > +            qemu_fdt_setprop_cell(fdt, name, "numa-node-id", props->socket);
> > > +        }
> > > +
> > > +        g_free(name);
> > > +    }
> > > +
> > > +    if (props->aia_type == AIA_TYPE_APLIC_IMSIC) {
> > > +        addr = props->clint->base +
> > > +               (RISCV_ACLINT_DEFAULT_MTIMER_SIZE * props->socket);
> > > +        size = RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
> > > +    } else {
> > > +        addr = props->clint->base + RISCV_ACLINT_SWI_SIZE +
> > > +               (props->clint->size * props->socket);
> > > +        size = props->clint->size - RISCV_ACLINT_SWI_SIZE;
> > > +    }
> > > +
> > > +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx, addr);
> > > +    qemu_fdt_add_subnode(fdt, name);
> > > +    qemu_fdt_setprop_string(fdt, name, "compatible",
> > > +                            "riscv,aclint-mtimer");
> > > +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> > > +        2, addr,
> > Should be:
> > 	   2, addr + RISCV_ACLINT_DEFAULT_MTIME,
> > 
> > I found an MTIMER FDT issue in the virt machine FDT.
> > 
> > Command:
> > 
> > ```
> >    timeout 30s ./build/qemu-system-riscv64 \
> >      -machine virt,aia=aplic-imsic,aia-guests=5,aclint=on,dumpdtb=/tmp/virt.dtb \
> >      -smp 2 -display none -nodefaults
> > 
> >    dtc -I dtb -O dts /tmp/virt.dtb | grep -A4 mtimer@
> > ```
> > 
> > The generated FDT contains:
> > 
> >                  mtimer@2000000 {
> >                          interrupts-extended = <0x04 0x07 0x02 0x07>;
> >                          reg = <0x00 0x2000000 0x00 0x08 0x00 0x2000000 0x00 0x7ff8>;
> >                          compatible = "riscv,aclint-mtimer";
> >                  };
> > 
> > without this patches:
> > 
> >                    mtimer@2000000 {
> >                            interrupts-extended = <0x04 0x07 0x02 0x07>;
> >                            reg = <0x00 0x2007ff8 0x00 0x08 0x00 0x2000000 0x00 0x7ff8>;
> >                            compatible = "riscv,aclint-mtimer";
> >                    };
> > 
> > The first address should be 0x20007ff8.
> 
> That was intentional and I forgot to document it in the commit msg. The
> "No FDT changes made" I said doesn't apply here. My bad!
Thanks for clarifying. I also noticed this waring during my previous
review and testing.

> 
> If you use 'dtc' in the current 'virt' DT you'll get warnings:
> 
> dtc -I dtb -O dts virt.dtb > virt.dts
> 
> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"
Yes, the warning is valid, and I can reproduce it as well.

> 
> 
> This happens because the unit address in the node name doesn't match the
> first address in 'reg'.  For mtimer@2000000, "reg" must be reg = <0x00 0x2000000 (...)>.
> For mtimer@2008000, reg = <0x00 2008000 (...)> and so on.
I agree that the address in the node name should match the first address
in `reg`, as described by the Devicetree Spec [1].

However, I think the value that needs to change is the node name, not
the first address in `reg`.

See ACLINT spec, an MITER device has two separate base addr: one for MTIME
and another for the MTIMECMP registers [2].

In the current QEMU implement, `addr` is the MTIMECMP base address, while
the MTIME register is located at:

	addr + RISCV_ACLINT_DEFAULT_METIME

For this example:

	MTIMECMP base = 0x2000000
	MITIME   base = 0x2007ff8

So the existing `reg` property correctly describes the two register
regions:

	reg = <0x00 0x2007ff8 0x00 0x08
	       0x00 0x2000000 0x00 0x7ff8>

> 
> 
> Now, does this change break aclint in 'virt'?  Because in that case we'll
> just keep the "dtc" warning and live with it.  Aside from the existing tests
> we have in QEMU I didn't do a deep dive in aclint.
Yes, I think using `addr` here would make the ACLINT description
incorrect. `addr` is the MTIMECMP base address, while MTIME is located
at `addr + RISCV_ACLINT_DEFAULT_MTIME`.

Please keep the first `reg` address as it was:

      qemu_fdt_setprop_sized_cells(fdt, name, "reg",
-          2, addr,
+          2, addr + RISCV_ACLINT_DEFAULT_MTIME,
           2, size - RISCV_ACLINT_DEFAULT_MTIME,
           2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
           2, RISCV_ACLINT_DEFAULT_MTIME);

Since this patch is mainly a code-duplication cleanup, I suggest
leaving the generated FDT unchanged here. The unit-address fix can be
sent as a separate follow-up patch:

- name = g_strdup_printf("/soc/mtimer@%" HWADDR_PRIx, addr);
+ name = g_strdup_printf("/soc/mtimer@%" HWADDR_PRIx,
+                        addr + RISCV_ACLINT_DEFAULT_MTIME);

--

LINK:

[1] Devicetree Specification, Section 2.2.1, "Node Names":
    https://devicetree-specification.readthedocs.io/en/stable/devicetree-basics.html#node-names

[2] RISC-V ACLINT Specification, "Machine-level Timer Device (MTIMER)",
    Section "Register Map":
    https://github.com/riscvarchive/riscv-aclint/blob/main/riscv-aclint.adoc


Thanks,
Chao
> 
> 
> Thanks,
> Daniel
> 
> > 
> > > +        2, size - RISCV_ACLINT_DEFAULT_MTIME,
> > > +        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> > > +        2, RISCV_ACLINT_DEFAULT_MTIME);
> > 
> > [...]
> > 
> > > +    qemu_fdt_setprop(fdt, name, "interrupts-extended",
> > > -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> > > -        2, addr + RISCV_ACLINT_DEFAULT_MTIME,
> > I think this is the original code that was moved here.
> > 
> > Thanks,
> > Chao
> > > -        2, size - RISCV_ACLINT_DEFAULT_MTIME,
> > > -        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> > > -        2, RISCV_ACLINT_DEFAULT_MTIME);
> > 
> 

