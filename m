Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F12C55174
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 02:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqiMa-00075B-Do; Sun, 02 Aug 2026 22:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wqiMX-00070y-OM; Sun, 02 Aug 2026 22:25:10 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wqiMU-0008Te-3c; Sun, 02 Aug 2026 22:25:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCG2p0AreF9fjGYZ6ub5eqcg7bE0ibZDUX0A6Le+3qDLLka94dtffU7qAW2KqZKSEu+X87iDVvMe6eQzaGSW7zKuZGmc7PE8ea3TNCxF7LNsD08GPoImwWlZ0rpSyjnVA6CGaUJnS/QJXd9cr1Da70qaESWHOcarJOtHBO9w1Oez2m4FYXnd6Wvk1BBQM4sxnK1mGIGj1+I1/Qi8afsQ6rC7tTrcEnneyZkt8GDdoHNZ54Z4LaFTSoQFQ1rDCLO0zKMm1UY86fTFzrr+lAKliV/IzejFWBKLKXbIwtrbmreM58qWHwdJ51CuMjXSAP/Ou2Q4fZP9k94VDQvt71L9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP4ZvBzcCdy1rgNtAjmPrU+fK4nSUHAbrznDfvqnlEY=;
 b=gZYRecLqNJfNpr8nigEoPybxZE0/2DAZmTVD88mkZfl+/bMji97cHQt4VjSDUSy15QP7a/+9KvEC5s60SnQNdu8JqlZTxLBXn5qAXO5E7ecvf/DxkcPowG3IDUQ4Kl90ZDQCBwylESik7ar0WjpHssDpTjylHYIU8e6HXzG7ehI3XFhP4vLZAPd9H/SYBqnlUzAAAGQdUfUubrziOl8iPyQ0yHYlfrcQkei7r2i4Ci2aNrA5HP8kQcSYF2vHCDNS0ywyD0/YSwgfE/5q2znzNcGJ83g3B285jDb0xjLSHm7cK0VWBLEkl3zOgAWV6i4OeeoRkHooslQMjEALGY7fYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP4ZvBzcCdy1rgNtAjmPrU+fK4nSUHAbrznDfvqnlEY=;
 b=IArtuqPJbCcajGP4CQRrBtHntaEnJtmVDwAn5Om8Jv4EHOdVcVhFq+1TobXLNzkrx77FlU/oReBuQFXGo+HRRNjBdupsJjEV2pNkotjnUqtkaIEAG2/+2gLMoklnjIcYVHnbz/ama/vDs0ZGvVOvpjnfu33vUgKECl0d10pG5OP2YPt8l4QX0ngdWA6UjfXb0GlB3w2X8ZAHF+IW5WEpVW1J0VXkAiw1H2ztMTv75tpNTDOEHTBwtzxFrF9qCR4e6IQsGrb7yMvazBhCs4NzzzIqS1x4NsAO2E1HBagDiNl7LpvDAwOQ/StTWJY6S7m1tFk32xxfFkvbGJT7Sxqq8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6426.apcprd02.prod.outlook.com (2603:1096:820:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 02:24:58 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 02:24:58 +0000
Date: Mon, 3 Aug 2026 10:24:52 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 1/2] hw/misc: Add Tenstorrent Atlantis PRCM model
Message-ID: <am_5OAFG6L6ZnoXE@ChaodeMacBook-Pro.local>
References: <20260729-atlantis_prcm-v1-0-502882933e51@oss.tenstorrent.com>
 <20260729-atlantis_prcm-v1-1-502882933e51@oss.tenstorrent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-atlantis_prcm-v1-1-502882933e51@oss.tenstorrent.com>
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: b828d383-a3e0-4bf4-9c99-08def10669d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|22082099003|18002099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: cD5BYXv8dwR4vpmOjltIRrb9VzhDV14kIZ0iefoJ1vzWEmTim4+NHYNJsuQJBwPqG/b2UcIlOtWVAxc25IhEkfYsQp23jYBFtC6FpwSQTZxoQiuBX/fElfYFJU/kmAWG9aXlAxrGHZ42uOJNp/eKCYwVJsD4yufEaS1BqN3eHEBCXkhmtBunLgpai6n8QqC7n0uzoXhns87qC4VaDnF07M8PApjJSMKP6+aS7J1jH9oh0lG3m37dR6/ufgw3XtVTptQYT3xKxiS3vBAxkukezeHYckUp1QIURM9c7kpr9SjcgPfZ/IHGIerFbHgV7dMYHeD0IT9cTGfK7GoYMz0YaRWPjaGROfYibjUA3HQ7d7Ode/GXv9KipZGpoz9sNLlU3snNR7b9U02B5VwCEp+ifSePqFoI+ULZEL+SzoUbvDtaEi7p8Z1uTpCEDbki02OnjGqhPS47hAcnWvuJGsBrDpcVhqqUsWtRLuqiiVmt5Cf+Qkr2oOjL0n6nWqZTfQawZwX7YKBln9A7mNaRWZIhTXAVie7bnS4iawJCrv/KP0iJu75Eyat2I/V6PGihFgMW1WH9uPdU26EouyYCTrfoR3VcN+q40Wg2QH20cxi0DSRSjCMIV/329wnumaJmAzfXl0WwUBKZLhl+za4EjEAbyY0Uf1KXEtJuZi5Q7fYIId8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4qoGKzrPbc7pDN+SCebW2r12S5FYwn6KA6aT0ZhZLZTWVrN7C7wG4pGb6kD?=
 =?us-ascii?Q?e3ok3cFrcR783NV9DRMsOwu+EwHD07UHsMjyHesDEWnkdGcWmEDg7nDmjE0T?=
 =?us-ascii?Q?iUCpVqoZ1kO3tpY+uSFD7JZtdJDoEzgOWqe3mazAHEDB9PdERRakWhLjQZZF?=
 =?us-ascii?Q?fNENtjQQpkKM2AcO4Q8tCHCyBMJ/fTPe0nCufJ18ElvxU2djBo8sT4D4aadA?=
 =?us-ascii?Q?uq+vumnb3TpnOGpVfqxtrqMUB0JFMnJqLJO0g7+MjwMxKQvJI+aM1W7Q4o/b?=
 =?us-ascii?Q?q3IxzoZKELlBu1yzt7OxirE2MKuRtUdXhu63AkPVVd0KCW7PU5xDuAMLEbNA?=
 =?us-ascii?Q?zGxuq3UijE3XX/McsFqm7/jOuu4k28kGMv1X8O3kIZ1ZoscOxIjQ3w0brF0f?=
 =?us-ascii?Q?SUYwb1K5FDeiVb9y6n3iK2t5K7RmrYCcs3E/LPjK2T2uk2W3Uf9dkjEjKdGL?=
 =?us-ascii?Q?3snmYv/MxPD4xk2jLa4vAk2Cvi41PJIdFyGWYpxro9V0qlgeou4zaE5QbZZ9?=
 =?us-ascii?Q?4y3OgXPI21CBek4C++fLI3s25Xe84mhYFMgAbapLm0G3Vvvr3hDxLoO04TbZ?=
 =?us-ascii?Q?D3R2Syk1p0G3UvJd5zM+48wwLyTem+tgvJ+VM9llosAeFfLuw3H7nAx2vnMk?=
 =?us-ascii?Q?uAtFv8a2oDeJQhS6IxNAFNgAR4y07YU1Iv5eXOq8qhZZ5x3Y+/ePZHGgpf6R?=
 =?us-ascii?Q?34xSPddrxNzdd809gmHUZWsZG6gI4lVgulohU7RAp6NgXoqxGyn88QxAydkw?=
 =?us-ascii?Q?NjCx7tUXzO9TUS1Yd2R3YUaV1+nNiG0t+4KoSTlviYdMQt3m0AU1FQ+w8aoU?=
 =?us-ascii?Q?dxGFEb5JJT/ZNvEXlfRYOIlT5IwRdlGR1zKBwTOrqK+MoG67CiUL5xnkE4CU?=
 =?us-ascii?Q?Ve7o6gSQkEdfxjhXzuPMGforo5YFvg20KL3Jkleey6DWBKIUkvEl7lF4jKI4?=
 =?us-ascii?Q?SK/PusdJ1rOYuicAf18kvzfYSVtuvwcbTl0suemIdsmBNf61UVUbJRQko3g3?=
 =?us-ascii?Q?TOPvf7Eg2kOGiS+T7VSY1X81sLY//Dcwn/6NTyL37IaLS/nIL1BsLPr09T1U?=
 =?us-ascii?Q?oTPO5mVxvnpYUtl7HhO3zHAR0O67ltwT6jsrvfQojZRFfL6RN/5TDdGtEzPa?=
 =?us-ascii?Q?o4FlHsvKlIAucRaN7Dk03wEEvo+R4vw20F4Jb0kBe4XzVaQAo1RcAJHN8mvl?=
 =?us-ascii?Q?Xa2o9L312cX+0sOTORV/5LQiI0gHFDJhUdT+0+jWqdWxfGlfYHvD+580cRP9?=
 =?us-ascii?Q?J7+mFYw90NJcBnRS7aJtkjAnlMNzCmZbTgfG02P3QYohL+CV1gOaKWIglJSS?=
 =?us-ascii?Q?XGHaEdk+hQVJszP+nRdPaBrbsMAYVQjmgNdewxROKo7IvvClfJM/vUEh3eiO?=
 =?us-ascii?Q?enbBezkUHZKfUflGp1tziZBPFQi2UFocoLvwyPEvVkurAyY2OUQwJph0RG+J?=
 =?us-ascii?Q?EQ6kXoFrHSbM2l3arGr2uDEd7iQl3yfz0RioO1dLLdC9H/p3lhXH8VftYgpQ?=
 =?us-ascii?Q?C97iC34W4a78YfYWjrChcHEFdZluUXX0qkvDT7m7SWGwAX21lC83Atg2/uw5?=
 =?us-ascii?Q?3qJBXVuEnlsFIsRedW3PATb4xAfdbj/xZ7U7cpXMURFYgtpJuH+3A98HCbvg?=
 =?us-ascii?Q?6Ykt/AxBLrQMcnB9eSv+gN7kuWgBijWBZY8g0M5IaC6vx3zwwoDlEDVwlvhl?=
 =?us-ascii?Q?KtWi6bty3F8/Ug0oVbcgdq+dR771GChI5DeWLdULR/YpGoAuEMSOKyamFyhX?=
 =?us-ascii?Q?VAH9C4275MEOlkAZWJdVe6veuzEiHCk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b828d383-a3e0-4bf4-9c99-08def10669d9
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 02:24:58.3231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L//8MuLCP7cP75vX2KyEPBldqWPjpJJZLN7kh5tnW4p1WJXX7+ZRFIhdxbemDGInaZmJfBvN7K/poSFK4E1WRGQgL9ZKit6lbooq45yNwZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6426
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Wed, Jul 29, 2026 at 10:21:34AM +0800, Anirudh Srinivasan wrote:
> This device present in Tenstorrent Atlantis has registers that control
> clocks, reset and other misc functionality in the SoC. This commit adds
> models for the RCPU, HSIO, PCIE, MM and 2 DDR PRCMs.
> 
> Co-developed-by: Portia Stephens <portias@oss.tenstorrent.com>
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
>  MAINTAINERS                        |   2 +
>  hw/misc/meson.build                |   1 +
>  hw/misc/trace-events               |   4 +
>  hw/misc/tt_atlantis_prcm.c         | 436 +++++++++++++++++++++++++++++++++++++
>  include/hw/misc/tt_atlantis_prcm.h |  51 +++++
>  5 files changed, 494 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e25df9493c..49c1a5ad76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1802,7 +1802,9 @@ R: Portia Stephens <portias@oss.tenstorrent.com>
>  L: qemu-riscv@nongnu.org
>  S: Supported
>  F: docs/system/riscv/tt_*.rst
> +F: hw/misc/tt_*.c
>  F: hw/riscv/tt_*.c
> +F: include/hw/misc/tt_*.h
>  F: include/hw/riscv/tt_*.h
>  F: tests/functional/riscv64/test_tt_*.py
>  
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..26627013f3 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -36,6 +36,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
> +system_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis_prcm.c'))
>  
>  subdir('macio')
>  
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9a868b3ef..9359a4e66d 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -442,3 +442,7 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
>  iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
>  iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
>  iommu_testdev_dma_armed(bool armed) "armed=%d"
> +
> +# tt_atlantis_prcm.c
> +tt_atlantis_prcm_read(uint32_t domain, uint64_t offset, uint64_t data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> +tt_atlantis_prcm_write(uint32_t domain, uint64_t offset, uint64_t data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> diff --git a/hw/misc/tt_atlantis_prcm.c b/hw/misc/tt_atlantis_prcm.c
> new file mode 100644
> index 0000000000..d341e1a8c3
> --- /dev/null
> +++ b/hw/misc/tt_atlantis_prcm.c
> @@ -0,0 +1,436 @@
> +/*
> + * PRCM (Clock and Reset Controller) in Tenstorrent Atlantis SoC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2026 Tenstorrent
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "hw/misc/tt_atlantis_prcm.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/core/irq.h"
> +#include "trace.h"
> +
> +#define TO_REG(offset) ((offset) >> 2)
> +
> +#define PLL_LOCK_BIT        31
> +#define PLL_FBDIV_LSB       14
> +#define PLL_POSTDIV2_LSB    11
> +#define PLL_POSTDIV1_LSB    8
> +#define PLL_REFDIV_LSB      2
> +#define PLL_BYPASS_BIT      1
> +
> +#define PLL_RESET_VAL(BYPASS, REFDIV, POSTDIV1, POSTDIV2, FBDIV, LOCK)         \
> +  ((LOCK << PLL_LOCK_BIT) | (FBDIV << PLL_FBDIV_LSB) |                         \
> +   (POSTDIV2 << PLL_POSTDIV2_LSB) | (POSTDIV1 << PLL_POSTDIV1_LSB) |           \
> +   (REFDIV << PLL_REFDIV_LSB) | (BYPASS << PLL_BYPASS_BIT))
> +
> +#define RCPU_PLL_RCPU_CFG   TO_REG(0)
> +#define RCPU_PLL_NOCC_CFG   TO_REG(0x4)
> +#define RCPU_NOCC_CLK_CFG   TO_REG(0x8)
> +#define RCPU_RCPU_DIV_CFG   TO_REG(0xc)
> +#define RCPU_RCPU_BLK_CG    TO_REG(0x14)
> +#define RCPU_LSIO_BLK_CG    TO_REG(0x18)
> +#define RCPU_RCPU_BLK_RST   TO_REG(0x1c)
> +#define RCPU_LSIO_BLK_RST   TO_REG(0x20)
> +#define RCPU_PLL_RCPU_EN    TO_REG(0x11c)
> +#define RCPU_PLL_NOCC_EN    TO_REG(0x120)
> +#define RCPU_PLL_MM_EN      TO_REG(0x0124)
> +#define RCPU_PLL1_MM_EN     TO_REG(0x0128)
> +#define RCPU_PLL_HSIO_EN    TO_REG(0x12c)
> +#define RCPU_PLL_PCIE_EN    TO_REG(0x138)
> +#define RCPU_PLL_I2S_EN     TO_REG(0x13C)
> +#define RCPU_PLL_MM_CFG     TO_REG(0x19c)
> +#define RCPU_PLL_HSIO_CFG   TO_REG(0x1a0)
> +#define RCPU_PLL_PCIE_CFG   TO_REG(0x1ac)
> +#define RCPU_BOOT_MODE_CFG  TO_REG(0x1b0)
> +#define RCPU_PLL_I2S_CFG    TO_REG(0x1f4)
> +#define RCPU_I2S_DIV_CFG    TO_REG(0x1f8)
> +#define RCPU_BUS_CFG        TO_REG(0x1fc)
> +#define RCPU_PLL1_MM_CFG    TO_REG(0x2a4)
> +
> +#define HSIO_HSIO_DIV_CFG       TO_REG(0x0)
> +#define HSIO_HSIO_DIV_CFG1      TO_REG(0x4)
> +#define HSIO_HSIO_BLK_CG        TO_REG(0x8)
> +#define HSIO_HSIO_BLK_RST       TO_REG(0xc)
> +#define HSIO_HSIO_GMAC_DIV_CFG  TO_REG(0x10)
> +
> +#define PCIE_SUBS_RST_CTL   TO_REG(0x0)
> +#define PCIE_SUBS_CG_CTL    TO_REG(0x4)
> +#define PCIE_SUBS_CK_CTL    TO_REG(0x8)
> +
> +#define MM_MM_CLK_GATE_CFG  TO_REG(0x8)
> +#define MM_MM_CLK_DIV_CFG   TO_REG(0xC)
> +#define MM_MM_CLK_SEL_CFG   TO_REG(0x10)
> +#define MM_MM_RSTN          TO_REG(0x14)
> +#define MM_MM_CLK_DIV_CFG1  TO_REG(0x130)
> +
> +#define DDRC_STAT           TO_REG(0x10014)
> +#define DDRC_DFISTAT        TO_REG(0x10514)
> +#define DDRC_SWSTAT         TO_REG(0x10c84)
> +
> +#define PLL_EN              BIT(0)
> +#define RCPU_PLL_BUS_CG_EN  BIT(7)
> +#define HSIO_PLL_BUS_CG_EN  BIT(3)
> +#define PCIE_PLL_BUS_CG_EN  BIT(1)
> +#define NOCC_PLL_BUS_CG_EN  BIT(0)
> +
> +#define RCPU_BOOT_MODE_UART      (0x0 << 4)
> +#define RCPU_BOOT_MODE_NOR       (0x1 << 4)
> +#define RCPU_BOOT_MODE_SD        (0x2 << 4)
> +
> +#define RCPU_DOMAIN_SIZE   0x10000
> +#define HSIO_DOMAIN_SIZE   0x510
> +#define PCIE_DOMAIN_SIZE   0x100
> +#define MM_DOMAIN_SIZE     0x1000
> +#define DDRC0_DOMAIN_SIZE  0x101000
> +#define DDRC1_DOMAIN_SIZE  0x101000
> +
> +static uint64_t tt_atlantis_prcm_read(void *opaque, hwaddr offset,
> +                                               unsigned size) {
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(opaque);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +    uint32_t data;
> +
> +    if (offset >= c->regs_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        return 0;
> +    }
> +    data = s->regs[TO_REG(offset)];
> +
> +    trace_tt_atlantis_prcm_read(c->domain, offset, data);
> +    return data;
> +}
> +
> +static void tt_atlantis_prcm_write(void *opaque, hwaddr offset,
> +                                            uint64_t data, unsigned size) {
Consider aligning the wrapped lines with the first parameter.

> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(opaque);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +
> +    trace_tt_atlantis_prcm_write(c->domain, offset, data);
> +
> +    if (offset >= c->regs_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        return;
> +    }
> +
> +    switch (TO_REG(offset)) {
> +    default:
> +        s->regs[TO_REG(offset)] = data;
> +        break;
> +    }
> +}
> +
> +static void tt_atlantis_prcm_rcpu_write(void *opaque, hwaddr offset,
> +                                            uint64_t data, unsigned size) {
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(opaque);
> +
> +    tt_atlantis_prcm_write(opaque, offset, data, size);
> +
> +    bool pll_en_written = false;
> +    uint32_t pll_reg_offset;
> +    switch TO_REG(offset)
> +    {
> +        case RCPU_PLL_RCPU_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_RCPU_CFG;
> +            break;
This should follow the QEMU coding style:

    switch (TO_REG(offset)) {
    case RCPU_PLL_RCPU_EN:
        pll_en_written = true;
        pll_reg_offset = RCPU_PLL_RCPU_CFG;
        break;
    ...
    case RCPU_PLL_I2S_EN:
        pll_en_written = true;
        pll_reg_offset = RCPU_PLL_I2S_CFG;
        break;
    default:
      g_assert_not_reached();
    }

Thanks,
Chao
> +        case RCPU_PLL_NOCC_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_NOCC_CFG;
> +            break;
> +        case RCPU_PLL_HSIO_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_HSIO_CFG;
> +            break;
> +        case RCPU_PLL_PCIE_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_PCIE_CFG;
> +            break;
> +        case RCPU_PLL_MM_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_MM_CFG;
> +            break;
> +        case RCPU_PLL1_MM_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL1_MM_CFG;
> +            break;
> +        case RCPU_PLL_I2S_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_I2S_CFG;
> +            break;
> +    }
> +    if (pll_en_written) {
> +        if (data & PLL_EN) {
> +            s->regs[pll_reg_offset] |= BIT(PLL_LOCK_BIT);
> +        } else {
> +            s->regs[pll_reg_offset] &= ~BIT(PLL_LOCK_BIT);
> +        }
> +    }
> +}
> +
> +static const MemoryRegionOps tt_atlantis_prcm_ops = {
> +    .read = tt_atlantis_prcm_read,
> +    .write = tt_atlantis_prcm_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static const MemoryRegionOps tt_atlantis_prcm_rcpu_ops = {
> +    .read = tt_atlantis_prcm_read,
> +    .write = tt_atlantis_prcm_rcpu_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static void tt_atlantis_prcm_realize(DeviceState *dev, Error **errp)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +
> +    if (c->domain >= PRCM_DOMAIN_COUNT) {
> +        error_setg(errp,
> +                   "domain %d is larger than max number of possible domains %d",
> +                   c->domain, PRCM_DOMAIN_COUNT);
> +        return;
> +    }
> +    s->regs = g_new0(uint32_t, TO_REG(c->regs_size));
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), c->ops, s,
> +                          TYPE_TT_ATLANTIS_PRCM, c->regs_size);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +}
> +
> +static void tt_atlantis_prcm_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +
> +    memset(s->regs, 0, c->regs_size);
> +}
> +
> +static void tt_atlantis_prcm_rcpu_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    tt_atlantis_prcm_reset(dev);
> +
> +    s->regs[RCPU_PLL_RCPU_CFG] = PLL_RESET_VAL(1, 0, 4, 0, 100, 1);
> +    s->regs[RCPU_PLL_NOCC_CFG] = PLL_RESET_VAL(0, 2, 2, 2, 267, 1);
> +    s->regs[RCPU_NOCC_CLK_CFG] = (0x25f31 << 1) | BIT(0);
> +    s->regs[RCPU_RCPU_DIV_CFG] = (0xb8c2 << 1);
> +    s->regs[RCPU_RCPU_BLK_CG] = 0;
> +    s->regs[RCPU_LSIO_BLK_CG] = 0;
> +    s->regs[RCPU_RCPU_BLK_RST] = 0xffffffff;
> +    s->regs[RCPU_LSIO_BLK_RST] = 0xffffffff;
> +    s->regs[RCPU_PLL_RCPU_EN] = PLL_EN;
> +    s->regs[RCPU_PLL_NOCC_EN] = PLL_EN;
> +    s->regs[RCPU_PLL_HSIO_EN] = 0;
> +    s->regs[RCPU_PLL_MM_EN] = 0;
> +    s->regs[RCPU_PLL1_MM_EN] = 0;
> +    s->regs[RCPU_PLL_I2S_EN] = 0;
> +    s->regs[RCPU_PLL_PCIE_EN] = 0;
> +    s->regs[RCPU_PLL_HSIO_CFG] = PLL_RESET_VAL(0, 1, 2, 1, 50, 0);
> +    s->regs[RCPU_PLL_PCIE_CFG] = PLL_RESET_VAL(0, 2, 3, 1, 250, 0);
> +    s->regs[RCPU_BOOT_MODE_CFG] = RCPU_BOOT_MODE_SD;
> +    s->regs[RCPU_PLL_MM_CFG] = PLL_RESET_VAL(0, 1, 2, 1, 50, 1);
> +    s->regs[RCPU_PLL1_MM_CFG] = PLL_RESET_VAL(0, 1, 2, 1, 50, 1);
> +    s->regs[RCPU_PLL_I2S_CFG] = PLL_RESET_VAL(0, 1, 6, 6, 33, 0);
> +    s->regs[RCPU_I2S_DIV_CFG] = 0xde69ad31;
> +    s->regs[RCPU_BUS_CFG] = NOCC_PLL_BUS_CG_EN | HSIO_PLL_BUS_CG_EN;
> +}
> +
> +static void tt_atlantis_prcm_ddrc_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    tt_atlantis_prcm_reset(dev);
> +
> +    s->regs[DDRC_STAT] = 0x1;
> +    s->regs[DDRC_DFISTAT] = 0x1;
> +    s->regs[DDRC_SWSTAT] = 0x1;
> +}
> +
> +static void tt_atlantis_prcm_hsio_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    tt_atlantis_prcm_reset(dev);
> +
> +    s->regs[HSIO_HSIO_DIV_CFG] = 0x20821731;
> +    s->regs[HSIO_HSIO_DIV_CFG1] = 0x8;
> +    s->regs[HSIO_HSIO_BLK_CG] = 0;
> +    s->regs[HSIO_HSIO_BLK_RST] = 0;
> +    s->regs[HSIO_HSIO_GMAC_DIV_CFG] = 0;
> +}
> +
> +static void tt_atlantis_prcm_pcie_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    tt_atlantis_prcm_reset(dev);
> +
> +    s->regs[PCIE_SUBS_RST_CTL] = 0;
> +    s->regs[PCIE_SUBS_CG_CTL] = 0;
> +    s->regs[PCIE_SUBS_CK_CTL] = 0x44908;
> +}
> +
> +static void tt_atlantis_prcm_mm_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    tt_atlantis_prcm_reset(dev);
> +
> +    s->regs[MM_MM_CLK_GATE_CFG] = 0;
> +    s->regs[MM_MM_CLK_DIV_CFG] = 0xddc8312;
> +    s->regs[MM_MM_CLK_SEL_CFG] = 0;
> +    s->regs[MM_MM_RSTN] = 0;
> +    s->regs[MM_MM_CLK_DIV_CFG1] = 0x333;
> +}
> +
> +static void tt_atlantis_prcm_unrealize(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +
> +    g_free(s->regs);
> +}
> +
> +static void tt_atlantis_prcm_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    dc->unrealize = tt_atlantis_prcm_unrealize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_reset);
> +    dc->desc = "Tenstorrent Atlantis PRCM Controller";
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_rcpu_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_rcpu_reset);
> +    dc->desc = "Tenstorrent Atlantis RCPU PRCM Controller";
> +    c->domain = PRCM_DOMAIN_RCPU;
> +    c->regs_size = RCPU_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_rcpu_ops;
> +}
> +
> +static void tt_atlantis_prcm_hsio_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_hsio_reset);
> +    dc->desc = "Tenstorrent Atlantis HSIO PRCM Controller";
> +    c->domain = PRCM_DOMAIN_HSIO;
> +    c->regs_size = HSIO_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_pcie_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_pcie_reset);
> +    dc->desc = "Tenstorrent Atlantis PCIE PRCM Controller";
> +    c->domain = PRCM_DOMAIN_PCIE;
> +    c->regs_size = PCIE_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_mm_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_mm_reset);
> +    dc->desc = "Tenstorrent Atlantis MM PRCM Controller";
> +    c->domain = PRCM_DOMAIN_MM;
> +    c->regs_size = MM_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_ddrc0_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_ddrc_reset);
> +    dc->desc = "Tenstorrent Atlantis DDR Memory Controller 0 PRCM";
> +    c->domain = PRCM_DOMAIN_DDRC0;
> +    c->regs_size = DDRC0_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_ddrc1_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_ddrc_reset);
> +    dc->desc = "Tenstorrent Atlantis DDR Memory Controller 1 PRCM";
> +    c->domain = PRCM_DOMAIN_DDRC1;
> +    c->regs_size = DDRC1_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static const TypeInfo tt_atlantis_prcm_types[] = {
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(TTAtlantisPRCMState),
> +        .class_init = tt_atlantis_prcm_class_init,
> +        .class_size = sizeof(TTAtlantisPRCMClass),
> +        .abstract = true,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_RCPU,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_rcpu_class_init,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_HSIO,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_hsio_class_init,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_PCIE,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_pcie_class_init,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_MM,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_mm_class_init,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_DDRC0,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_ddrc0_class_init,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_DDRC1,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_ddrc1_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(tt_atlantis_prcm_types);
> diff --git a/include/hw/misc/tt_atlantis_prcm.h b/include/hw/misc/tt_atlantis_prcm.h
> new file mode 100644
> index 0000000000..acb8a9b38b
> --- /dev/null
> +++ b/include/hw/misc/tt_atlantis_prcm.h
> @@ -0,0 +1,51 @@
> +/*
> + * Clock, Reset, Pinctrl PRCM in Tenstorrent Atlantis SoC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2026 Tenstorrent
> + */
> +
> +#ifndef TT_ATLANTIS_PRCM_H
> +#define TT_ATLANTIS_PRCM_H
> +
> +#include "hw/core/sysbus.h"
> +
> +#define TYPE_TT_ATLANTIS_PRCM "tt.atlantis.prcm"
> +#define TYPE_TT_ATLANTIS_PRCM_RCPU "tt.atlantis.prcm.rcpu"
> +#define TYPE_TT_ATLANTIS_PRCM_HSIO "tt.atlantis.prcm.hsio"
> +#define TYPE_TT_ATLANTIS_PRCM_PCIE "tt.atlantis.prcm.pcie"
> +#define TYPE_TT_ATLANTIS_PRCM_MM "tt.atlantis.prcm.mm"
> +#define TYPE_TT_ATLANTIS_PRCM_DDRC0 "tt.atlantis.prcm.ddrc0"
> +#define TYPE_TT_ATLANTIS_PRCM_DDRC1 "tt.atlantis.prcm.ddrc1"
> +OBJECT_DECLARE_TYPE(TTAtlantisPRCMState, TTAtlantisPRCMClass,
> +                           TT_ATLANTIS_PRCM);
> +
> +
> +enum {
> +    PRCM_DOMAIN_RCPU = 0,
> +    PRCM_DOMAIN_HSIO = 1,
> +    PRCM_DOMAIN_PCIE = 2,
> +    PRCM_DOMAIN_MM = 3,
> +    PRCM_DOMAIN_DDRC0 = 4,
> +    PRCM_DOMAIN_DDRC1 = 5,
> +    PRCM_DOMAIN_COUNT = 6
> +};
> +
> +struct TTAtlantisPRCMState {
> +    SysBusDevice parent;
> +
> +    MemoryRegion mmio;
> +
> +    uint32_t *regs;
> +};
> +
> +struct TTAtlantisPRCMClass {
> +    SysBusDeviceClass parent_class;
> +
> +    uint32_t domain;
> +    uint32_t regs_size;
> +    const MemoryRegionOps *ops;
> +};
> +
> +#endif
> 
> -- 
> 2.43.0
> 

