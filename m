Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B3BC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkisP-00023m-Bt; Fri, 17 Jul 2026 09:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wkisN-00023O-59; Fri, 17 Jul 2026 09:45:15 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wkisK-0000nD-IB; Fri, 17 Jul 2026 09:45:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTs6J1jMzzE02HXd3exCQNHIsKccr/vsyYU/621VgIQvTK+nyvPmIo8pPX6Myg589mYDRkFRafBgvYgKNjxCSC/IGFQfWXvpkJhY/rix/t/azNmywe5ySjPS67YsjZolOxhjEQt35m9H7K9cNeg6i3KQRL0QtSBUE7twWz0rNyhkDv+/ACegmSHKvTNhtn9ntA+ASExFlMIU58bTneP0FbuAIaPpgLFTAxUo6mmLObuiGVGp+FgV0cqcpryEb1U6vKlLVtYJBn4fDcc+vvThiwRpjXOCHxUPSBhhppYlep0wTDHWMx2EZg8fX5MZVYpZYEITcmoPrx2lQdfO00LzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVK7A2Dv2zEeMfzt2aoRafrQPJPmjn+y8lH7m0HooZ8=;
 b=n5dq/B0yT9pCX2vavx3zdxyRrwUJLCS25gClGZucqodx4sopJwV8bQzqV1LNWZDDT9xAtGRDaFWNPDuZ5qhRXmueLQA32KvyZEw2FydnuxUE5h/sEYGFbqxDaS+c37z1xkjhriiSOn0sTEy8lGwC4Xabvz4E9woFS0G9BW3zySQPWUc3GKq4cFuQuOj4B4DZpCEPqoBGMwXgmHC6OIi/uqrDhgsohO6asb6OmtlEZop5GcjB70Njp2OdyRZP3cCyWZQt15v77YF3ntEgbMmFs8rGPNS461x56DOGFNvE0YKbpYIzLfOhLBOEKW3YPnXAp3FV6r7gWLSn+b2/ZLXZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVK7A2Dv2zEeMfzt2aoRafrQPJPmjn+y8lH7m0HooZ8=;
 b=KXPtdUh3tX73oY+dJpbEYUiiZX14U/kLxUOX7I9Jccbtgtmx+spZNEW+6T45yJJjmgM45LmcDbE1JLPF1sodJi0ftGLWOvbTR2MFE/fSbBjYHNmEwRGA2w81zqW/cO5qdCtUj/Ob+QO3mG/828cbJ0Pa6yhJE3XFEPEIs+wxUiUiroqkguWzysGBorJk9cVpOz8U3FZwE1y7R9dK+GX0KCsVXSi9KcGcCDXbtk8UiGvLxVDoLU3wtotbkTadsgYEjVyFtPXR+19bzVq/JIwi7GSSWTvzjI4tiTXdGldSDBRzPOZmVsJBB9XLbs5u7/MIzgTFKMBFGr3L6ogxsn/lRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SE3PR02MB8925.apcprd02.prod.outlook.com (2603:1096:101:2f0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:45:02 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:45:02 +0000
Date: Fri, 17 Jul 2026 21:44:56 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/3] hw/misc/k230_iomux: add Kendryte K230 IOMUX model
Message-ID: <aloxy47qh79wHYr9@ChaodeMacBook-Pro.local>
References: <cover.1784022244.git.flamboyant.h.01@gmail.com>
 <42d005d6e530e2cf2c7df8634e8b82c0f77d1702.1784022244.git.flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d005d6e530e2cf2c7df8634e8b82c0f77d1702.1784022244.git.flamboyant.h.01@gmail.com>
X-ClientProxiedBy: PH7PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:510:325::9) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SE3PR02MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: d9639871-7b85-4968-8dd2-08dee40999ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|1800799024|366016|7416014|376014|23010399003|56012099006|4143699003|6133799003|22082099003|18002099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: PTLMLsXJ17fTTi+H6fde1pBnaUDwBTTIupL/1xvUYDHHaL6YIo/lhAtGGhIda6HRbQJNe0Kc4CT73nd97ZJZ3JEt4hGipmjEE0Kz5QLv02a9mIZ+yeVjXY1q1XaSVxyWmoyJMt1TN5+sI0AbJnlY85uHkVwXc6LYEu8MKFv5F3erV5CPoL9PQbgewBTXkv144XHxVJyl72W1DPeTiib28/eqQ42CuTcqWCTAr1OKFZsBHeAlP0ZmN+zJkpci+UOHIoX5MwxQpcoyiGhuzw5DUKmGTyYJnmtULdQ5EmY+k8++y9SRLLOozxKE4yDeq99mlWzvTZudFcavOhhfrZhCanNazfrumTJScIimTMeeecGawOu15fCNyHVcPpb+5SrdURY4qWwstrl+82iFEBrn4NWOeOhVdkA9BpxZ93kZ73acvd4mbhFws0c8c+YdfyqyZrRlKapat9koVceeTIDg2IXeg8oYLq4TK2qQ5w4aEa+nCmI/7mDdNPipgzcgdDgPuXKMAyFTh6QG739NKyEObd9Ik92cuPzcwHGOkWpf1pgCTs+DJb7BOwZTsGd0Ydll6HoO3U1Tss6H1hKkvxE8TqvNwtKY0D5JKSdY2ao+E1I0OKYBw9kKPsCtEpXbIPgz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003)(10067099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IOiWh23JfZ4k59CdRQI0Bl+QWk17+29+o41yrY7qSeBq/Dwcsm5/Gx8xYgPB?=
 =?us-ascii?Q?GA5TEH3nQdO12grN5erLbAfxYM7iGn+Iq7c/qkvrGprW35MgF+Ju7k/TI3iZ?=
 =?us-ascii?Q?knwnSMvHQ06M/zDz5PtH3wZuhLwAmWuDUUHRlzq+MYS2eddLupseuUGBH8l7?=
 =?us-ascii?Q?rhpAbBoyq/7f8VMpv7RZL6p+huus+aq3kxbLQ+cUwJo1XjDRYecSAjjGfyFt?=
 =?us-ascii?Q?qhpP4XV/7nv0FEUCFYVHu9htOSJbS2yPq7ZcsDH2cG8YvdIuJJArql23SDVw?=
 =?us-ascii?Q?evyl/5g2kjDEu9FZzNZY0Dc2c12aV1YxkQqvYcqCfYPPHYwxyo2VwoHXpSP2?=
 =?us-ascii?Q?q4zM/N5DOVbLCMwG+TFHeHwwSxTWfiPcwqSrIWC8jW6hm7bz8yhaD3hX6LSZ?=
 =?us-ascii?Q?luDao/cjJBp4rI4lAqfkwxiz3dtfnFxoTAZsJpFCuGCatWzzBxIHTSLNgrCp?=
 =?us-ascii?Q?jaG1YrISkgj/pfYWNggbFw4KmtktGBlCW6cUuLSYxX0OO0SNBs0mc5XDvwi0?=
 =?us-ascii?Q?iIUM1a7ZMp5t3vr1b+bjCRRHkiWKfWGMHIN+mqtDPnnu/YH8YuLAzIevgT5S?=
 =?us-ascii?Q?jjpCCxrQHosUVXQDQcLMaUQd2Ojrl9IJK1JDjkqzkYENnPnaiVXEx2emaMEl?=
 =?us-ascii?Q?MUHf0PM5bOJZTIDN0MRkjA/3BAfxaVaZxoFFrcHiKEFXteyWeJzoLZIXpogl?=
 =?us-ascii?Q?zR73i7iuFT6MzeFHAZCnsr/SBXNb8DQBudfweuGR4Tr5w5Cgy5ReROS+9KKW?=
 =?us-ascii?Q?muvyF2ZTmfqIQE8fWgiR+ms3x//Zn27G9RX2y6QZ6jyxUmmUnSsKscZpke7A?=
 =?us-ascii?Q?EjKHd2oQojGau6fG6u2/CpX1KyMoPWJEAuKKW9FkHtwTZ1WKB2eKBcoi7rmX?=
 =?us-ascii?Q?yTkUiGVyyXI3HfTkKZzp1K/+6s0A6iJMFCggg5iR20L8WmMpllr/PvFxlLcd?=
 =?us-ascii?Q?t5HxgN9bK7DSa7Uxz6/4KfgA8N59fr9tUAJj8HxIG2u4iYnOvPTIaPjAeKNJ?=
 =?us-ascii?Q?ZQ/lT558ilaDOaVQiK+kpW8nJqVkXPn8cFLOWMFbikD5YjMi8ifdf+ECYgkB?=
 =?us-ascii?Q?pMT2ODtMYM//mES9/fgv+wICXW85JtOgVf+o3d05cKZjCag7yTCibj6ys91x?=
 =?us-ascii?Q?fxu5IC1lH9vteDzygXYSVxLfVmotIygMkwdzX+9Njq0HP7RVl1q5m44L6RlZ?=
 =?us-ascii?Q?qnQOHmCRrAaFHLGv2qoY0+eFcfFYa4gNGkX6VrpSkQGt0xFUgqmZAY5OiL0m?=
 =?us-ascii?Q?7hvDe2JGUvoq9w4bjg3RCaddLBMDPCMrgJ223ub+3ACHt/GNm9F0hacEbfnR?=
 =?us-ascii?Q?+t5idQecalRMnFus9Vz6Eq70VUPkOgosZzKWynZ7WNZcW0Wo5Dz8cFFr0LxV?=
 =?us-ascii?Q?NkJOySuJc0OPy1l95RJeoJrAi3Cfwumwra9A7u+O5IJa+3LyfV22mdhSBABi?=
 =?us-ascii?Q?5Vha9EePKxsVZcFvt7kpVgInx7cpQBQintP1nTFybLsVNmo5rFlnRls4gN1M?=
 =?us-ascii?Q?ukA5obXRSLpeMsLa8M4ysoelqgF3SFuYLB1f+svhHLOA2u4SYDUw745n50H1?=
 =?us-ascii?Q?82h1TpP9oQZHB1PgdSRJcrTAJ7DWprntoSmST4EF64KMxRq9fJto92XggsyG?=
 =?us-ascii?Q?G7Z5rus9x/MjOJZqyv/qd/du+tRnGPgriw0X2oRXM7nW5QiLw6AISIwRfEeF?=
 =?us-ascii?Q?00iEyqnU+dEGp6dUCYoVL/Tk/PErLzGf/xscMVB7Wq+ezGcqbSHwiwzeWXOz?=
 =?us-ascii?Q?vsyuDl8A3CjTEQv8oWS/k/ZxHlUM+qA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9639871-7b85-4968-8dd2-08dee40999ca
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:45:02.0973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/Erkgy1qX7atlf8mlvYEyEKiM71vKGiasNx//h4QBngYwyPTNMkwSKA+nci6ZPT9WmwgPGaHYZHwY91qZESWosBzPctPepM4AvibXa3jmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR02MB8925
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 14, 2026 at 06:22:00PM +0800, Kangjie Huang wrote:
> Add a SysBus model for the 64 K230 Function IO configuration
> registers documented by the K230 Technical Reference Manual.
> 
> Preserve the writable configuration fields across aligned 32-bit
> accesses, apply the documented reset values, and ignore writes to
> read-only and reserved fields. Offsets outside the documented register
> list read as zero and ignore writes.
> 
> This provides the register behavior used by the Kendryte SDK U-Boot
> pinctrl-single driver and Linux IOMUX configuration code.
> 
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/misc/Kconfig              |   3 +
>  hw/misc/k230_iomux.c         | 124 +++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build          |   2 +
>  hw/misc/trace-events         |   4 ++
>  include/hw/misc/k230_iomux.h |  34 ++++++++++
>  5 files changed, 167 insertions(+)
>  create mode 100644 hw/misc/k230_iomux.c
>  create mode 100644 include/hw/misc/k230_iomux.h
> 
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 1543ee6653..573d24a9df 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
>  config XLNX_ZYNQ_DDRC
>      bool
>  
> +config K230_IOMUX
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/k230_iomux.c b/hw/misc/k230_iomux.c
> new file mode 100644
> index 0000000000..cc40dc8ae4
> --- /dev/null
> +++ b/hw/misc/k230_iomux.c
> @@ -0,0 +1,124 @@
> +/*
> + * Kendryte K230 IOMUX
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides the Function IO configuration registers documented by the K230
> + * Technical Reference Manual.
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/k230_iomux.h"
> +#include "migration/vmstate.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +
> +/* TRM V0.3.1 section 12.9.2.1 Function IO register list. */
> +static const uint32_t k230_iomux_reset_values[K230_IOMUX_NUM_REGS] = {
> +    0x944, 0x944, 0x929, 0x908, 0x888, 0x908, 0x948, 0x890,
> +    0x890, 0x890, 0x910, 0x890, 0x890, 0x8a9, 0xa9e, 0xabf,
> +    0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
> +    0xb1e, 0xa90, 0xabf, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
> +    0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0x890, 0x910,
> +    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x890, 0x910,
> +    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x89e, 0x89f,
> +    0x99e, 0x99e, 0x99e, 0x99e, 0x890, 0x890, 0x8a9, 0x8a9,
> +};
> +
> +static void k230_iomux_reset(DeviceState *dev)
> +{
> +    K230IomuxState *s = K230_IOMUX(dev);
> +
> +    memcpy(s->regs, k230_iomux_reset_values,
> +           sizeof(k230_iomux_reset_values));
> +}
> +
> +static uint64_t k230_iomux_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    K230IomuxState *s = K230_IOMUX(opaque);
> +    uint32_t value = 0;
> +
> +    if (offset < K230_IOMUX_REGS_SIZE) {
> +        value = s->regs[offset >> 2];
> +    }
> +
> +    trace_k230_iomux_read(offset, value);
> +    return value;
> +}
> +
> +static void k230_iomux_write(void *opaque, hwaddr offset,
> +                             uint64_t value, unsigned size)
> +{
> +    K230IomuxState *s = K230_IOMUX(opaque);
> +
> +    trace_k230_iomux_write(offset, value);
> +    if (offset < K230_IOMUX_REGS_SIZE) {
> +        s->regs[offset >> 2] = value & K230_IOMUX_WRITABLE_MASK;
> +    }
> +}
> +
> +static const MemoryRegionOps k230_iomux_ops = {
> +    .read = k230_iomux_read,
> +    .write = k230_iomux_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void k230_iomux_init(Object *obj)
> +{
> +    K230IomuxState *s = K230_IOMUX(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &k230_iomux_ops, s,
> +                          TYPE_K230_IOMUX, K230_IOMUX_MMIO_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static const VMStateDescription vmstate_k230_iomux = {
> +    .name = "k230.iomux",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, K230IomuxState, K230_IOMUX_NUM_REGS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void k230_iomux_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "Kendryte K230 IOMUX";
> +    dc->vmsd = &vmstate_k230_iomux;
> +    device_class_set_legacy_reset(dc, k230_iomux_reset);
> +}
> +
> +static const TypeInfo k230_iomux_info = {
> +    .name          = TYPE_K230_IOMUX,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230IomuxState),
> +    .instance_init = k230_iomux_init,
> +    .class_init    = k230_iomux_class_init,
> +};
> +
> +static void k230_iomux_register_types(void)
> +{
> +    type_register_static(&k230_iomux_info);
> +}
> +
> +type_init(k230_iomux_register_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..31e5145a35 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -168,3 +168,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
>  
>  # HPPA devices
>  system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
> +
> +system_ss.add(when: 'CONFIG_K230_IOMUX', if_true: files('k230_iomux.c'))
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9a868b3ef..388967c9e1 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -405,6 +405,10 @@ djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRI
>  iosb_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
>  iosb_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
>  
> +# k230_iomux.c
> +k230_iomux_read(uint64_t offset, uint32_t value) "offset=0x%" PRIx64 " value=0x%" PRIx32
> +k230_iomux_write(uint64_t offset, uint64_t value) "offset=0x%" PRIx64 " value=0x%" PRIx64
> +
>  # aspeed_sli.c
>  aspeed_sli_write(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
>  aspeed_sli_read(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> diff --git a/include/hw/misc/k230_iomux.h b/include/hw/misc/k230_iomux.h
> new file mode 100644
> index 0000000000..15a16ef4de
> --- /dev/null
> +++ b/include/hw/misc/k230_iomux.h
> @@ -0,0 +1,34 @@
> +/*
> + * Kendryte K230 IOMUX
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_K230_IOMUX_H
> +#define HW_MISC_K230_IOMUX_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_K230_IOMUX "riscv.k230.iomux"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230IomuxState, K230_IOMUX)
> +
> +#define K230_IOMUX_MMIO_SIZE 0x800
> +#define K230_IOMUX_NUM_REGS 64
> +#define K230_IOMUX_REGS_SIZE \
> +    (K230_IOMUX_NUM_REGS * sizeof(uint32_t))
> +#define K230_IOMUX_WRITABLE_MASK 0x00003fff
> +
> +struct K230IomuxState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    uint32_t regs[K230_IOMUX_NUM_REGS];
> +};
> +
> +#endif /* HW_MISC_K230_IOMUX_H */
> -- 
> 2.43.0
> 

