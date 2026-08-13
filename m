Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36006C5AC67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 05:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuNzD-0005tv-TI; Thu, 13 Aug 2026 01:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wuNzC-0005tf-6h; Thu, 13 Aug 2026 01:28:14 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wuNz9-0003CA-Fd; Thu, 13 Aug 2026 01:28:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXudItU8ib6OVrLAiDCadFUcm0iGB9d5SUYf4K9dWc6WK06zQdn6PFig4AxA2ql9GIiKilUeobEz1Ku/4sRBNgNMBMk41n8eXqFivTJzbMmtlfkk06d3Wq+JbuVAu+/7ksfuCWycoqz1t2DZuz9XZjUTM7PLaQTbwiw4g46ZOa/fl0RkDf6a8yaO6RdVu4o2x8mD4Ph0TI2ci3Cj5FEP1oFFrHqlmyoSdz1XHLwMHrbmX5TjXbEcFp1kRyqk46fTqGd2d8FLJZTt5EGJh8pGgiGNTWZYs2RZAAh4+ckXITnCvBv8DbPhAv4DLBQzYjiVdRPiSCrrxXE6BS/iEosAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOPAf4SamKi/wIWp/IaF8YpGqwsFlc75oNOpgGlUjRw=;
 b=GHhYj+GYIwaQRhs5lgP4LBPBIHbxy/JmoDW/2UEX3dvC8mEHmH2pTI7FCGzfHTyMxyf6W8aHhn2vSydVU5o6jq6qJVk5o23wUSgX6YV8koCz8h3buvGu9WxNs53J6xPF9YQ60Qq1OQdRlmPHyU0EgVbFH4AXee51aet6u14pTjMrQFh9r844h8cuAQ1iBpWkdPPxAehQ8bkdDC3RIEzseXgj+18ACVh9CGxpa2Fxyfm7/BMSnMhJunlEYrXgzv4bVXaBSBS+kB6CBvxHkd9ryAObgJWpkwpLYTAahPm+jHvZgZDxV7c6Y/my7aTUMh+WSMF6hDFYSt3ZM8hlIEQsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOPAf4SamKi/wIWp/IaF8YpGqwsFlc75oNOpgGlUjRw=;
 b=KCjVoQt5B7nD18KXAp/7oR5qqoKjMiXHbFqpxcUX675eWtzvDRm1xbJsWeLlSO2u+wvBA+RgvlrYDgRolMgRzqT3IZGh45VgKu/4RUypEg1VrSrWRUoAoidxqYYDfwEMBhgivbiBJ+EyJI81LgF7EP4fjZagwoZYlE0J0GOmM/5YdcplLCY2oKt5mNNyewKo93mFxXP+GyVdq9RazG6kpmHWuHCA+FjEAWh/66pf8TGEeiWbNzN1PDzDzLqyFB8Rq8sREG5OqGEDb/vO/QT1JyZE+H99dKc/DYY6jBJ0llalodBl3BFiEEO+Sz0EMxS0O1CKuIdQ8uDbMViODPaSmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB7505.apcprd02.prod.outlook.com (2603:1096:405:49::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 05:28:03 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 05:28:02 +0000
Date: Thu, 13 Aug 2026 13:27:55 +0800
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
Subject: Re: [PATCH v2 3/3] tests/qtest: add test for K230 IOMUX
Message-ID: <an04CSOPf-dJQhj3@ChaodeMacBook-Pro.local>
References: <cover.1784022244.git.flamboyant.h.01@gmail.com>
 <8986fd154ff098dc843f0ab2a4cbcf9a6c07b343.1784022244.git.flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8986fd154ff098dc843f0ab2a4cbcf9a6c07b343.1784022244.git.flamboyant.h.01@gmail.com>
X-ClientProxiedBy: PH7P220CA0140.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::17) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b14227-9dd9-40e6-ca42-08def8fba4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: W+14ZvigqWsvGeNkyMBgk85lxsVofxjp8tuBff6ehuMPIpcThjrOhNmG9z+zDWX4CqcS1d198N7dWOsALhL7XwxpoWzt5g4iOmF4D74vW34x6rOc0pVNwXtCkrdURlf4J8htfxI9eN/GbqlBIalN70p8QE1Wt3Ecb1UJrNsjxb2onnqj63U2ISOOzKvTezkByYiVQLHuQ7aI1zXINIJMBhve8fjqjE0qwGuuwASH6AZcAiYLc7iIXf/AcAJdiEdKex/IV3Ck14rs6LFGOdmHcKBHIdfESg1v1HArutrnr1LPFPs0RSanw0rRABSlZrGuvfs0pEyS0FHbxo4sGgfnKfH4rJt2D0FTc5hMzEwBZ1JYCKm7RPMoTE3/1WxdeKWlwBIqV2asPPiF7Ipaopa2/iCU35OAqT6BCh6epQvQsebzDlfOKeGAAnKFvQP2FE6rJynivEQvoXRoskQPgu4CkbW2dafkRMVhAX5/MkA7xaGZU9OwVvvYoaRR6AjyRvpyhACS9BmCkkphI0g3QO+QwZuQ83qridCVL9+6riRCAjXu1Sq8UwMdPqnBzxImBVLq1SeIBojBCPD9Kw8WkG40lud1CvR290zFj2fc9s5aMU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2hmSXpINFNsV3RwVGkvU0laYTJLQzcybDFwTjgzMWw0Nm5TTmRsWkdmdS84?=
 =?utf-8?B?RFhJWk1oeFZHM2ZUcmpNTDk4aHFYbG5KRUlwMlJPUVhjak56emFhcVhaYjFo?=
 =?utf-8?B?VDloMXhiWHNkYVdhTWtKYTZQaXFUWld2ZzUvbUtsUkZBVys1bk9pY0plRTJF?=
 =?utf-8?B?VDNDcVNPKzF2TUJqS3h3M1o3SWFJU09OaTBZY1draS9HZm05MkRhbERUd3Bp?=
 =?utf-8?B?cGEwbjJQZU1LRVlWR0UxeGIrMzArbnp1SlErZHdHd1YyNjVINVdjUHhuVHM4?=
 =?utf-8?B?b0lZNFc1SXZQMExBUjJ4OEw1Mjh1MzFMM0hSZWVyS04rOEkzNEZFZmRXUjFo?=
 =?utf-8?B?dzY1VTg0R0Qrck91ZnZKb0UwR3ZNL1JldGIwMFVFU2dENE5wdVpMUWlzTVp0?=
 =?utf-8?B?bXdVLzFLQWxyZEZ0TmJUZTdDK010R09LdlBsSlBsRHRTUjdjMjRMZjVEdnQ3?=
 =?utf-8?B?R2tpUDdaTVptNmhMYVlKTXhPSjhaMEFadURWcll1ZWNIRVhUK1AzNGxaUU8x?=
 =?utf-8?B?TlZBcVoyVml0aCtKbEY1bWR0akFaeXpYbDAvb1c0UVFkMW53UXM4eGVGWXU0?=
 =?utf-8?B?ZkJkdVdnTURGZ2ZITndkY0MvczVDMXBYTFFVaEdkMzMwRkZVTDhrWWU2SWgx?=
 =?utf-8?B?WStoSVJld2FiS0pOQXhFT0JkV24xL0hqMUN3RjFpVlkvQTVldG1tMm5yd3Qv?=
 =?utf-8?B?RHowUGpYYzIyaDVULzRIS3RwSUJWaTFYeGpoRjdBdkNqS2FnM3ZsdkJwd0Z3?=
 =?utf-8?B?MS95ZDF0Z0ZGaFEwNmNJUHJrVlA2Um51OFRSQWJwNkV2UmRVS0R0WXhXZndF?=
 =?utf-8?B?eWdiYVJ0QXRDMEp6eGJRaHUvVUN1TFRyL2F2cktBcmI0d0NFd292N2NnM3RE?=
 =?utf-8?B?L3NIWDlNcDdkWXpkYkQ1a3BZVFYxbTFVMm8xSEtBeFg0eGF4RG9GOXh3R3BQ?=
 =?utf-8?B?cGtFd0FlbVpnZzRVdXhhelNCbzlqQ2VPc2FDNU55MkJpUktoRm5ORysrbStZ?=
 =?utf-8?B?Yks3SHpYcFFTTTNxTUExa2pkaHdKeDFMMnQ0OXdzTkpoQkhHU3RSeU5PRDAv?=
 =?utf-8?B?MmlaY0lJS1cxbTlFaHlIaWJBdlJPVTZxVjV5RERMblc3NjVpa2lsN1Z3c2Rz?=
 =?utf-8?B?YjVqeEZ2RVNITzFESDJvMzNlenVCTVNWckFlSS81MTZKdTBjNjhjMWg1bEw1?=
 =?utf-8?B?MURSS1I3Q3RvTWlJS2pyS2U4Q1dzc2JwaUdjZFlhSmhHSml0VVdldFFubmNQ?=
 =?utf-8?B?VzdneWczWmM0ejNUbHVuaTh5QWhPem52MXZSNjBnL0w3TTczVTZuSk1Cak40?=
 =?utf-8?B?bFVqQ2VWOVYxNy9NemVUWE5xUHVKWiswMEVuTW1qSGFnT1UvNGYwQklDZnpU?=
 =?utf-8?B?M015RDdGeXFSdnVOZ3JlV29GckFzMitpVUtsdzkvODZrM1llNy8wT1oxVS9v?=
 =?utf-8?B?OTUvb25ycHQrcnpHd3FTblBoUGlrTmlsSDRZSG10MXIwNFdOcnFZbERSU3Y4?=
 =?utf-8?B?VXBnbUE0R1FpeHMrM2FlVWo0ZU9QdFVyVlRsN0JBZWhwMTYzK2VJbzAwOFht?=
 =?utf-8?B?WWpBZi9XbWlPVzd5aFZHekM4bDNVTDgzL1JYRDIzTm1YSGcvR0NZVmtCalZ3?=
 =?utf-8?B?YWo0RVIyUEdUaG0wMHVOckJTVHV6dHBXK2N5ZDB0V09HTEZ4dk1TcWZJbnlw?=
 =?utf-8?B?UmgyZGxBVjlTUllUNkU2MGo1eEdLY29HeWFGVVUwZGxRaTNnS0hwWG40Z1JE?=
 =?utf-8?B?eFo2UkowR2ZkVGMrRzhJQWZxTGZTZ2U0ZjM5N0J4K1JBaFpodzRmRWhMNit6?=
 =?utf-8?B?OUdwNUJqQXI3MWRoc1lEeExpajJHeGNUc2J2VFJKaTBVWFZCaVlhc1orcnR3?=
 =?utf-8?B?cG5sT1grUHE3WTdOeG40clc0RWdnVWRRdkhjTzhSOW1hWG9LdUoya0lrcDhI?=
 =?utf-8?B?WEZ3aXFLYmRGcjN3MCtOcER6U3Bkb2d5SkxqNVRuZ2hhbFpZcTZXY2tvV3NR?=
 =?utf-8?B?b09oWTZRL3VGcStUYXJyZG5HOThadEVmbnpsS1hJeURiUjlSQ20xNW1jdjBs?=
 =?utf-8?B?a3ZzMklRN3VtdS9lenZLclBNVVhzL1AyVWF5dWtXeTJiMTJmYnVkSjczUjNj?=
 =?utf-8?B?Z3FKdEVGdElhWlRNQTEvSlBWdHNFQ1pYbG5Nc3ZPb2ZYb1ZJYTJ3dFpzaWgr?=
 =?utf-8?B?VHFBOUpNdVllbW91OUpXWUJGYWs3WWVvYzNBaVNDeC9NeEF6L2pERklqK3NJ?=
 =?utf-8?B?dzRBTzkvYkRZQmJzaks2VWZRZHlYbXBmV05tRDVPOHFnL2doTDRSZkMvSXdH?=
 =?utf-8?B?eUlBYStVMEVVRllUVGoxOEFZSlRrMG5OOERuNUhnWGRONkkzb1JGai84N3Rr?=
 =?utf-8?Q?WJfZPgn4WPVqK1oc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b14227-9dd9-40e6-ca42-08def8fba4f7
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 05:28:02.4643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt+aSimtkWRotAOuPkS0hMncpYQdP/4ABkRsaYH19CwYQs7bcPxjCUCY+EvVZ6KynB87Foinb0aNjrrBU7aLZQXfLAPXRXfgRkr2jEu9NGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7505
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jul 14, 2026 at 06:22:02PM +0800, Kangjie Huang wrote:
> Cover the 64 documented reset values, writable field storage and
> masking, read-modify-write accesses, the final IO63 register, reserved
> offsets, and system reset.
> 
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> ---
>  tests/qtest/k230-iomux-test.c | 155 ++++++++++++++++++++++++++++++++++
k230-iomux-test.c needs to be added to MAINTAINERS.

>  tests/qtest/meson.build       |   5 +-
>  2 files changed, 159 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/k230-iomux-test.c
> 
> diff --git a/tests/qtest/k230-iomux-test.c b/tests/qtest/k230-iomux-test.c
> new file mode 100644
> index 0000000000..39653cf832
> --- /dev/null
> +++ b/tests/qtest/k230-iomux-test.c
> @@ -0,0 +1,155 @@
> +/*
> + * QTest testcase for Kendryte K230 IOMUX
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides test coverage for the Function IO configuration registers.
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "hw/misc/k230_iomux.h"
> +
> +#define K230_IOMUX_BASE 0x91105000
> +#define K230_IOMUX_IO0  (K230_IOMUX_BASE + 0x00)
> +#define K230_IOMUX_IO1  (K230_IOMUX_BASE + 0x04)
> +#define K230_IOMUX_IO63 (K230_IOMUX_BASE + 0xfc)
> +#define K230_IOMUX_RESERVED_FIRST (K230_IOMUX_BASE + 0x100)
> +#define K230_IOMUX_RESERVED_LAST \
> +    (K230_IOMUX_BASE + K230_IOMUX_MMIO_SIZE - 4)
> +#define K230_IOMUX_IO_SEL_MASK (0x7 << 11)
> +#define K230_IOMUX_IO_SEL(value) ((value) << 11)
> +
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
> +static void test_reset_values(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    for (size_t i = 0; i < G_N_ELEMENTS(k230_iomux_reset_values); i++) {
> +        g_assert_cmphex(qtest_readl(qts, K230_IOMUX_BASE +
> +                                    i * sizeof(uint32_t)), ==,
> +                        k230_iomux_reset_values[i]);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_rw(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_IOMUX_IO0, 0x00001234);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x00001234);
> +
> +    qtest_writel(qts, K230_IOMUX_IO1, 0x00002abc);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==, 0x00002abc);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x00001234);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_write_mask(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_IOMUX_IO0, UINT32_MAX);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==,
> +                    K230_IOMUX_WRITABLE_MASK);
Please use a separate mask in the test. Reusing the implementation’s mask
could let the test pass even if the mask is wrong. A short comment explaining
the mask would also be helpful.

    /* Bits 13:0 are RW; bits 30:14 are reserved; bit 31 (DI) is RO. */
    #define K230_IOMUX_EXPECTED_WRITABLE_MASK 0x00003fff

    [...]

    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==,
                    K230_IOMUX_EXPECTED_WRITABLE_MASK);

Thanks,
Chao
> +    qtest_quit(qts);
> +}
> +
> +static void test_rmw(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint32_t value;
> +
> +    value = qtest_readl(qts, K230_IOMUX_IO0);
> +    value = (value & ~K230_IOMUX_IO_SEL_MASK) | K230_IOMUX_IO_SEL(3);
> +    qtest_writel(qts, K230_IOMUX_IO0, value);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==,
> +                    (k230_iomux_reset_values[0] &
> +                     ~K230_IOMUX_IO_SEL_MASK) | K230_IOMUX_IO_SEL(3));
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_io63_rw(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_IOMUX_IO63, 0x00000abc);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO63), ==, 0x00000abc);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_reserved_offsets(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_IOMUX_RESERVED_FIRST, 0x00001234);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_RESERVED_FIRST), ==, 0);
> +
> +    qtest_writel(qts, K230_IOMUX_RESERVED_LAST, 0x00002abc);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_RESERVED_LAST), ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_reset_after_write(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_IOMUX_IO0, 0x00001234);
> +    qtest_writel(qts, K230_IOMUX_IO1, 0x00002abc);
> +    qtest_writel(qts, K230_IOMUX_IO63, 0x00000abc);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x00001234);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==, 0x00002abc);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO63), ==, 0x00000abc);
> +
> +    qtest_system_reset(qts);
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==,
> +                    k230_iomux_reset_values[0]);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==,
> +                    k230_iomux_reset_values[1]);
> +    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO63), ==,
> +                    k230_iomux_reset_values[63]);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230-iomux/reset", test_reset_values);
> +    qtest_add_func("/k230-iomux/rw", test_rw);
> +    qtest_add_func("/k230-iomux/write-mask", test_write_mask);
> +    qtest_add_func("/k230-iomux/rmw", test_rmw);
> +    qtest_add_func("/k230-iomux/io63-rw", test_io63_rw);
> +    qtest_add_func("/k230-iomux/reserved-offsets", test_reserved_offsets);
> +    qtest_add_func("/k230-iomux/reset-after-write", test_reset_after_write);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 56ff860e21..cb8001ecbf 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -297,7 +297,10 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>     ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ? [
> +    'k230-wdt-test',
> +    'k230-iomux-test',
> +  ] : [])
>  
>  qtests_hexagon = ['boot-serial-test']
>  
> -- 
> 2.43.0
> 

