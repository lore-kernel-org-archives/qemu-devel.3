Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDCCC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEmN-0003SP-35; Mon, 27 Jul 2026 02:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woEm9-0003O0-K9; Mon, 27 Jul 2026 02:25:22 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woEm7-00086E-UA; Mon, 27 Jul 2026 02:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JufwKdwyADiHSGAKHDICSrilqqJmM7ElnzsAPF91vfoVsV7yP67vYF1WBSDPsqLgFG4XTpgqwd2makUDK2HJySoj5djMEW30cY8LajeQQhfAVHJn1Ik45seat70Drr2uJXn6wvACgOwhY2dT3sFbKLtQ57eOZT9zHkHD4EYDxKM27i1QbnAN9s2/wuwj8ykCT8pe9OOTCv+YWgW4nZvHhYFbK3QLSxEGlK26QKO/2QJGT1tPRyHFhHrtbUsRiW3xswvPM1VosX3HaHStItRmpF99P8kOt/zd8YagAhT2tBdDpXJ6Ar0ASWwWb3NYCgfPE048u3HEJZp6hYGeWG2Q/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtKRcVMah0RxpUYgW9XBeUVrKpOuNDoLTQzo3yofJ+w=;
 b=GA1CMQB1SsztUh5kUGwSPkoJ2TJkNyYs8BR8iZnvxWKmidODa3Uf1aTzKRbAhD8RWF74pg7jNsJHr8+WtO3U3B9T8Sf8VmbocmX1WNdMhTshx0jZj0EajapaVbMVkXJUftW3hl0NFtPzvNOZbUMEQ7h6UgZRkGOX59g6CnhjshGFoUfW1EXmchtmx9XEQ/S7GOeO3qLaOO/WooLGxWHtVa3ugbVpACbEotqqfxCSRoVKwcvpwLguG5sksPyhH4HQwzbcC/Diqu5Rm8mdMgL2v7sHFmj+1HgFU+4krZDm5GvL+V2a7UYZFsFKTEgMyjy7l6lDc+A2ekCz4O4sFYz8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtKRcVMah0RxpUYgW9XBeUVrKpOuNDoLTQzo3yofJ+w=;
 b=a6vRDTGEd/nsT3yu/TUPmF+NOzXmV0TT5xX1ZudbG7KlhsTbqiPhmDNs6DVIPZGVzJHz+CbPCyJ/NC7f+gPAwLNKItUQB+To5BqD4di9Tjjq+7AvtCm7+Qgmknfus+sZz6Z781kCJ/frq0k7+5u8ICGgeLcLfqIkQEF+nrhgk9rB5078h3JXKfJm+e2ltymmGVP44N5pqVKZ150pCIWSoIAGGC2BUYa4Am2eA2AkcMSJJCHUuMmUTCUNhFFeVOCHJnWBpEljFkqZX2tmEE+Q1q6fTme7uX9sbHreDnxRFyYljbcF8edR9ZTOXet4+KktoC7nISZh3lkcjEkkBU00dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5624.apcprd02.prod.outlook.com (2603:1096:400:1b0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:25:13 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:25:13 +0000
Date: Mon, 27 Jul 2026 14:25:08 +0800
From: Chao Liu <chao.liu@processmission.com>
To: flavien.solt97@gmail.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 3/3] tests/qtest: add RISC-V IOMMU MRIF notice tests
Message-ID: <amb5vEsBhpbHbHJ-@ChaodeMacBook-Pro.local>
References: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
 <CANVUYGsmXiKSQdb_BjCVPo1dvmF0K5-B63iQpszqqYLhZsc_Zg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANVUYGsmXiKSQdb_BjCVPo1dvmF0K5-B63iQpszqqYLhZsc_Zg@mail.gmail.com>
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: a688c71b-3c7b-437d-1f67-08deeba7d112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|7416014|366016|23010399003|1800799024|6133799003|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hJ6QSV9oRBMj+BjOg/hQiOZo8RqjbUg27dLicsSsnhhch8+BRedwG462x73SUeZDBMBzapvYf/+j9AzoFO7/E7b5EU34T3l7HHPJ97IGTzfNuaUFlLZ1OeUjyjVBh4n2lpWPMmSdJuTouwF40df+owNxeFg3TfEEJXYPy8Zcvme0xtqTCgiyUW3z/fy7pQesCiAV4+mXCgVsVvAEPRlHue3G97akIbH/sY+iCLqz0mm/pdsbpcww2AA4Hoz+qaBNkmzNcyvW7bXypXoWvf3KMor8eiWFnZlRvGq/Axo0QMCVdN4RBxHcJs493ngUn8oa6aZ7wsfcFUmy3xMyjOKSNZMHQejGQ7BWGkUUU2iAXYGz3K2BH41xibrMLJO67/AOJHF1aUnyrM62jak1aXw/jB5EWX3pWiPsHoWFWq81hw14V9M7mTosK+3HSc6xHFZMroPHpqXSUMMvhEW2H9QAmVA3HgLHdt4wi9dsOWvBQwdI4TdvYTBX14Jv3UKfm/AzrNNNLuq6zi+fn7zyFCuoRC0UpSANlC0koJGM6kzvvwpDCPd1bW7ym+cy0H8elpu4GX9aSMkAUUewh+r6MMyPvebFUSd6bOG/0f60pt754Zfz+GexNSJjTh29LnGbYuHXEcGJnWK4w8ouCVaR1S0GQE5O0vgGNrjvl5r2xdF3Gao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(7416014)(366016)(23010399003)(1800799024)(6133799003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U4FumZdcseRbnRhRq9c98D+ZUPiWrXkYiSbA3bYNpAAfcKUZbPfVGoN7LPpX?=
 =?us-ascii?Q?uhPUqiV2/WSEe6TFAmiI2UqcN6eVHUhsmkKqqN5Iwh3z18nM17ljWZCxWugt?=
 =?us-ascii?Q?m80HOc4l8K6ANxc8u9Wwq/dDgvT7OHWuHsGCdUun0Rjz4de2ffb3/yV4/FWb?=
 =?us-ascii?Q?s3YlLZYoaU3Co7h/w0u2m+HcZj538p1HdaujEeeiaJFWZlNOPUMiBZbCDA6u?=
 =?us-ascii?Q?jv4aL0eDxbJcWtulDAIxu5k0S7vnIPRJUjHPKXSfAPdSo3Iw9LEcBUCSUcxL?=
 =?us-ascii?Q?bOA8S6rT9+FTs9HPuI1bn5sLEUnonPxgIINWSeRhGtHMWkrcpGoQg5NzSqF+?=
 =?us-ascii?Q?OZXmeuU6HvY1I94jXlII8tqhQPu0czlpKr66gUzD3MZn0wIKcnhdqfusrTV1?=
 =?us-ascii?Q?ctuIq9ARdfSmTcyULAQvLn77XkEIfWTnS6wyRZH0b+O+FC/djlGqSA9HU43z?=
 =?us-ascii?Q?l7bnykntSQSH24T0Zt0ACCbGpwwUSvoo90+eyBbuUJ86PmbvKd42Ozj+Zg4O?=
 =?us-ascii?Q?Cj+PKaTJ6F0mc6wuE1P8C1ajWbXTxiRgxkHANGKCO7TaMtF1NRf+WOTu+rMP?=
 =?us-ascii?Q?HN6Rc1DHlCXS680274XMZOIcyER+TpBSl5StG1WF89F16noTxMOthyNQcDNb?=
 =?us-ascii?Q?D1jHaYMUyt0bYSA8wNkbYLSHKkswstGlkljw/FEokuJKxaAiYTqmCSuWs6rD?=
 =?us-ascii?Q?wz5jqAxvMBHorKIBq5bYqvdRXpjkCrnP92AC+SwQ3PZgK0Nx33xJFA94DJ7t?=
 =?us-ascii?Q?ww1lwmniylacIbNnkmsB4LHOeY+dowlX4Te6vJH/KYpINi/L0nukHpd65NoR?=
 =?us-ascii?Q?vfXxkvqJhHlQ5X9GWX0ypmxIPhBZ+A6buNbS6lJ53GrnqUBM+MsH730gU8ob?=
 =?us-ascii?Q?XiccnEjB32wWDwSVhcLP0hDLHSoWae7sfPzAScLzLZGoZ4eOafl+V9z2TtfL?=
 =?us-ascii?Q?WZEJfqnEN50vSdlZmGUQ6IwDyHE48lpR88yugo+/IMGKvK3abB4fDAgL018S?=
 =?us-ascii?Q?Mi+zpQMH6aqpxIEUpLFxWa0dHFKuTU3nONyQrk6V/cie1YiYHx1Z7pveGCj3?=
 =?us-ascii?Q?a6LAifxGKa44V0FmklLmlObQi+Yb7n+mdg1rYUMi9HfNQLYkhTTOAXK36hKM?=
 =?us-ascii?Q?M8AEyMuBNWvfQZDmFG6/fSC7L0cwmh6wQR62Nx9GXkqvj2pLUX0/Zf8DRiAm?=
 =?us-ascii?Q?NGcmJMJH37d2lH9dUW2rur1M/JDwmjIVs1Vldswr3zg4cQfmWDzeeU4L3QYs?=
 =?us-ascii?Q?HOAr39EdU6GGBT+q1d/1l4/xlLwTeYdYrA8QmNxEvM54Jz4iOWNtkAq/7w+Y?=
 =?us-ascii?Q?Z6ZnPOl6i+hObS3uloHEL3av6xc0ZkjtyeQKhFlsndyi2y5Gy5H1l+6JraOT?=
 =?us-ascii?Q?fkRzohpj2efJOF4hM9yQKEhG5Bns8J4SE+mkaGzc9pqJz+U5gF9ucImcyVHM?=
 =?us-ascii?Q?XC6Czcp2pKV+fGP0S5S5CER5iAWqARLrNcZxoT2jKcYBcjMkwmOw+aWpgqVD?=
 =?us-ascii?Q?L3DHc+DNyktot1sgXrUIWnx1FHh7EXbbf76sy0WPvC22tbiYesdiJCWJh2i/?=
 =?us-ascii?Q?GFeoYh6Ws4To1+tg0PMmTsNXSjmbwIpxEJ9h2GWD5eWmBOQdoqDKOLEFtnzM?=
 =?us-ascii?Q?q5TmK2kEsUbG8UG0dyXSe5O330jW5eU1AZMYMelHxvApe3PJF/Mv82/RsoNs?=
 =?us-ascii?Q?35nckbESS+TwctHm1pIn21Em0vnkscmrTNU9hUvfUoet5iVl50jIUBHVt0/3?=
 =?us-ascii?Q?8eQMFSEQvzf6MvGnVQEf6LvsF+/FfMk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a688c71b-3c7b-437d-1f67-08deeba7d112
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:25:13.4354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwPNUBNM5JxPRZjacSYD1ezHnLCmgSRo8VPgnEHACiG7qVHwKbf5zZc9clWjImr55R2FNuICor+aeHN0oIdxZjxgEm5+PnTN+IY3+0VqTUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5624
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

On Sun, Jul 26, 2026 at 07:28:27PM +0800, flavien.solt97@gmail.com wrote:
> From a13bfa64b84ac70c9e257253616ce650fc3e794b Mon Sep 17 00:00:00 2001
> From: Flavien Solt <flavien.solt97@gmail.com>
> Date: Sun, 26 Jul 2026 17:54:04 +0800
> Subject: [PATCH v3 3/3] tests/qtest: add RISC-V IOMMU MRIF notice tests
> 
> Exercise MRIF-mode MSI writes through iommu-testdev with the destination
> interrupt-enable bit both clear and set. Each case requires the pending
> bit to be stored plus the configured notice ID to reach guest memory.
> 
> The enable-clear case regresses the notice suppression fixed by the
> previous patch. The enable-set case provides a control for the existing
> path.
> 
> Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  tests/qtest/iommu-riscv-test.c | 102 +++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
> index 2638024..85f79ea 100644
> --- a/tests/qtest/iommu-riscv-test.c
> +++ b/tests/qtest/iommu-riscv-test.c
> @@ -14,6 +14,7 @@
>  #include "hw/pci/pci_regs.h"
>  #include "hw/misc/iommu-testdev.h"
>  #include "hw/riscv/riscv-iommu-bits.h"
> +#include "libqos/qos-iommu-testdev.h"
>  #include "libqos/qos-riscv-iommu.h"
>  #include "libqos/riscv-iommu.h"
> 
> @@ -26,6 +27,13 @@
>  #define RISCV_BUS_MMIO_LIMIT       0x80000000
>  #define RISCV_ECAM_ALLOC_PTR       0x30000000
> 
> +#define RISCV_MRIF_MSI_IOVA        0x00000000fee00000ull
> +#define RISCV_MRIF_MSI_PT_GPA      (QRIOMMU_SPACE_OFFS + 0x00030000ull)
> +#define RISCV_MRIF_BASE_GPA        (QRIOMMU_SPACE_OFFS + 0x00031000ull)
> +#define RISCV_MRIF_NOTICE_GPA      (QRIOMMU_SPACE_OFFS + 0x00032000ull)
> +#define RISCV_MRIF_INTID           5u
> +#define RISCV_MRIF_NOTICE_ID       0x12du
> +
>  typedef struct RiscvIommuTestState {
>      QTestState *qts;
>      QGenericPCIBus gbus;
> @@ -264,6 +272,96 @@ static void test_riscv_iommu_nested(void)
>      run_riscv_iommu_translation(&cfg);
>  }
> 
> +static void riscv_iommu_setup_mrif_context(RiscvIommuTestState *state)
> +{
> +    uint64_t dc_addr;
> +    uint64_t msiptp;
> +    uint64_t pte0;
> +    uint64_t pte1;
> +
> +    qtest_memset(state->qts, QRIOMMU_SPACE_OFFS + QRIOMMU_DDT_BASE, 0,
> +                 0x1000);
> +    qtest_memset(state->qts, RISCV_MRIF_MSI_PT_GPA, 0, 0x1000);
> +    qtest_memset(state->qts, RISCV_MRIF_BASE_GPA, 0, 0x1000);
> +    qtest_memset(state->qts, RISCV_MRIF_NOTICE_GPA, 0, 4);
> +
> +    dc_addr = QRIOMMU_SPACE_OFFS + QRIOMMU_DDT_BASE +
> +              state->testdev->devfn * sizeof(struct riscv_iommu_dc);
> +
> +    msiptp = (RISCV_MRIF_MSI_PT_GPA >> 12) |
> +             ((uint64_t)RISCV_IOMMU_DC_MSIPTP_MODE_FLAT << 60);
> +
> +    qtest_writeq(state->qts, dc_addr + 0, RISCV_IOMMU_DC_TC_V);
> +    qtest_writeq(state->qts, dc_addr + 8, 0);
> +    qtest_writeq(state->qts, dc_addr + 16, 0);
> +    qtest_writeq(state->qts, dc_addr + 24, 0);
> +    qtest_writeq(state->qts, dc_addr + 32, msiptp);
> +    qtest_writeq(state->qts, dc_addr + 40, 0);
> +    qtest_writeq(state->qts, dc_addr + 48, RISCV_MRIF_MSI_IOVA >> 12);
> +    qtest_writeq(state->qts, dc_addr + 56, 0);
> +
> +    pte0 = RISCV_IOMMU_MSI_PTE_V |
> +           ((uint64_t)RISCV_IOMMU_MSI_PTE_M_MRIF << 1) |
> +           ((RISCV_MRIF_BASE_GPA >> 9) << 7);
> +    pte1 = ((RISCV_MRIF_NOTICE_GPA >> 12) << 10) | RISCV_MRIF_NOTICE_ID;
> +
> +    qtest_writeq(state->qts, RISCV_MRIF_MSI_PT_GPA, pte0);
> +    qtest_writeq(state->qts, RISCV_MRIF_MSI_PT_GPA + 8, pte1);
> +
> +    qriommu_program_regs(state->qts, state->iommu_base);
> +}
> +
> +static void run_riscv_iommu_mrif_notice(bool enable_bit)
> +{
> +    RiscvIommuTestState state = { 0 };
> +    uint64_t pending;
> +    uint64_t enabled;
> +    uint32_t notice;
> +    uint32_t dma_result;
> +
> +    if (!riscv_iommu_test_setup(&state)) {
> +        return;
> +    }
> +
> +    riscv_iommu_check(state.qts, state.iommu_base, QRIOMMU_TM_BARE);
> +    riscv_iommu_setup_mrif_context(&state);
> +
> +    enabled = enable_bit ? (1ull << RISCV_MRIF_INTID) : 0;
> +    qtest_writeq(state.qts, RISCV_MRIF_BASE_GPA + 8, enabled);
> +    qpci_io_writel(state.testdev, state.testdev_bar, ITD_REG_DMA_WRITE_VAL,
> +                   RISCV_MRIF_INTID);
> +
> +    dma_result = qos_iommu_testdev_trigger_dma(
> +        state.testdev, state.testdev_bar, RISCV_MRIF_MSI_IOVA,
> +        RISCV_MRIF_NOTICE_GPA, DMA_LEN, qriommu_build_dma_attrs());
> +
> +    pending = qtest_readq(state.qts, RISCV_MRIF_BASE_GPA);
> +    notice = qtest_readl(state.qts, RISCV_MRIF_NOTICE_GPA);
> +
> +    g_test_message("MRIF notice: enable=%u pending=0x%" PRIx64
> +                   " notice=0x%x", enable_bit, pending, notice);
> +
> +    /*
> +     * Interrupt remapping consumes the original DMA write; the generic
> +     * test device cannot read it back from the supplied physical address.
> +     */
> +    g_assert_cmpuint(dma_result, ==, ITD_DMA_ERR_MISMATCH);
> +    g_assert_cmpuint(pending & (1ull << RISCV_MRIF_INTID), !=, 0);
> +    g_assert_cmpuint(notice, ==, RISCV_MRIF_NOTICE_ID);
> +
> +    riscv_iommu_test_teardown(&state);
> +}
> +
> +static void test_riscv_iommu_mrif_notice_enable_clear(void)
> +{
> +    run_riscv_iommu_mrif_notice(false);
> +}
> +
> +static void test_riscv_iommu_mrif_notice_enable_set(void)
> +{
> +    run_riscv_iommu_mrif_notice(true);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -275,5 +373,9 @@ int main(int argc, char **argv)
>                     test_riscv_iommu_g_stage_only);
>      qtest_add_func("/iommu-testdev/translation/ns-nested",
>                     test_riscv_iommu_nested);
> +    qtest_add_func("/iommu-testdev/mrif-notice/enable-clear",
> +                   test_riscv_iommu_mrif_notice_enable_clear);
> +    qtest_add_func("/iommu-testdev/mrif-notice/enable-set",
> +                   test_riscv_iommu_mrif_notice_enable_set);
>      return g_test_run();
>  }
> -- 
> 2.54.0

