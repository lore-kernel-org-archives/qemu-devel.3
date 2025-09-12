Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C25CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 17:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux7dB-0000r7-P8; Fri, 12 Sep 2025 13:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1ux7d0-0000qm-U6; Fri, 12 Sep 2025 13:32:08 -0400
Received: from mail-mw2nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2412::624]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1ux7cw-0006Rx-VD; Fri, 12 Sep 2025 13:32:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkxKiRXn1lbqyrzKTHBXSZlp3PxSfoBWtKyAHASMDgaAMin21suF8JUh8HsUj7MSXaCrbQoReVeFMCRliErJFwZa7PYOUQbJ1EHiuHaeT/iX339ZK91wOa80mhA0RMnL0/YNNkPS15PbfUMeq/IpqvJx8+VrqLV9a/OtILyWQthQxA/o2KSrLsh4zRRtqz+fIo7eDftW/WoUCKHjf3+EnUY3CysqqKZKb+Wo8Qky22eNCbhgpwrp/QaIjXmWUWEV9XWxExJ+H5DkmgMgbcndO/7EkuC4X0wtaQotPUhH2xYCtdBAnIYg67B3J81mxz1iEd5ddf7KbIIHvGAz/1/kVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9Wg2/peuM1cZ9FPUJbuFaooHMLJ+N0ZGv4g0NfGZHk=;
 b=uaSPud7cQai87EpUicybsk5g/RBrY6z9QmEM4ETJE5FzYVT1Mx5Tj3QUL7ZD8IrJrVdx7h5UIbWYJTQPRLAdpFl9obhjzUafiYBPE9ToKRDxej74qXGPZtK3swWJaeR3pcjvMwoMlVuKkmmxDSvYxhozN2bBFoXneJXT6VoarTGD00HAzQ+5YkXNE3HlDBV4lBxyXf5eOVfbgTalj5nvuPTfRXZLxbz7fEfjMlPTtXM+8WcupibbYsXHoXohjOVglA9MgMO3Qmz1m4TCEI7lqspj7igTQf2HLhd5rT5dboFQtmsULl/O+7u0DyxbOwtxWi/Ex8sYPK+mqm1RWmDSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9Wg2/peuM1cZ9FPUJbuFaooHMLJ+N0ZGv4g0NfGZHk=;
 b=OnURfC59K2C9X5FZije8WqzushhMd/DPjLkmjL8A81Q7iB51I0YYNlmc30mWUW+7jrj92Pw1APxQJ2elbmOmEBzOk3zVmzI2B4XM95OIRApgZBLjpMqh793Z1NRe9RYHeMnd5I8CgRw8uR/kc5HfqMn4c57HnTc1PpJE7wxzHwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11)
 by SA5PPF530AE3851.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 17:31:55 +0000
Received: from DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d]) by DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 17:31:55 +0000
Date: Fri, 12 Sep 2025 19:31:52 +0200
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v5 04/47] hw/arm/xlnx-versal: canfd: refactor creation
Message-ID: <aMRZCBCAZLER7uzd@zapote>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <20250912100059.103997-5-luc.michel@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912100059.103997-5-luc.michel@amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: BN9PR03CA0879.namprd03.prod.outlook.com
 (2603:10b6:408:13c::14) To DM6PR12MB4090.namprd12.prod.outlook.com
 (2603:10b6:5:217::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 016eb3de-e8f5-484d-2132-08ddf22244a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?S4QVyaha0FxHbQosRq95Kbd1gaF2tgMyujMBsq5DSOtlTydicZ+QiTwD8i?=
 =?iso-8859-1?Q?UmZIoPsAsdOTqJfXulqIZp34OoTgmISTSnJ3HJ6cMisF/m+85jLBRkTOdZ?=
 =?iso-8859-1?Q?NjJLpZRyZ06/a0BPD4dDQN7g8jIRM3SdpFaqT+445o6UWpjqvdA5X5x3Ch?=
 =?iso-8859-1?Q?qZCRUXMKdzyYch5QQiADSxkNVmjWs4DrXCOS0OCsBaIhSmikgIdlcVcMFW?=
 =?iso-8859-1?Q?hXjL78ip69wIcuGxBZTX6FxiuxJcGzeIJ6wsGyBa6cS0hA0oVn/1ndgODR?=
 =?iso-8859-1?Q?0s5wXJRESZDmC43QBrt9a32Xik6t12k3utV6jZmBc7PSxA4Qy1ElUxlKrf?=
 =?iso-8859-1?Q?eCH9km6RsTxdXJeABk/hK6NIllpTwG2NY0DsH+ET/sJgLSDzMwkPLSA2Rx?=
 =?iso-8859-1?Q?krX5PDA5rrix8Mc1V1/r42OnYnI7MJDRYpq7U6wcYTkD5hiwFl0m3Ke6Se?=
 =?iso-8859-1?Q?axwF3oDLLnABrqU/6neNfAu6Q3MTqoftQu0wN4Z5qqxcBL+kMaZ7P+s9pi?=
 =?iso-8859-1?Q?dCBxS8Aqbq+o0R0sgbnlQej21jJNM9NAH68bZPa+nL5HingY6V42funFXT?=
 =?iso-8859-1?Q?5XF18UoEmfood4HXnyXKdQKyrIZJO9Y30vO2+CmytiXg1MlLIBRrfttPv7?=
 =?iso-8859-1?Q?1IzSXzM4/W5D7OzU7VPlulRd5pajMs63qw1JYdhPXgzIyI7XPeaT/gxUnZ?=
 =?iso-8859-1?Q?yaVf3fu8pSxjo27mmEF14xH5B6jJwYfhLNavJcLE0SD8GcNnjUnqfvf7zD?=
 =?iso-8859-1?Q?+gMbAAVPJSeibLYhvcBUdJrhZ16GuQCIic/Ublb40gOOSKRmtsa7L3nmQM?=
 =?iso-8859-1?Q?6bhy8838mbffncB0z5ZRERTCZTSMrBbshGXw/62GghdFt6irIgvo1LsoZb?=
 =?iso-8859-1?Q?xuqXeeUaaKGKZN2cfrIsWwi+QoLJ8hr45h5D8Cm8xTAvA2zKq3MvIykJ7n?=
 =?iso-8859-1?Q?zaCwTrgkAtmHdfOkkUQsft7C+AJDBoKLnzTLILOwX4MlEAmdq2GwmyZ+bB?=
 =?iso-8859-1?Q?xISxHH6WuhCLkG5UfhSaNVlgEFuc4GVWPSmZPydKjjJ4u4Qo8WrrsMpS5x?=
 =?iso-8859-1?Q?O/SwZwracKJd0+Y0aTpYX4vEHC9Ji/QAWTwRzYFBIONDaQjliTsOO+r2uk?=
 =?iso-8859-1?Q?Rnv61mUdCL3KGBtK/jA90WLJHaMeZZqhFK55gAvjq6yrNEb7IlRB+JYWoB?=
 =?iso-8859-1?Q?hg16CrJRwpYY4pJc6HVAnkaOHvOBbghCQsKuS84r39dDuqYknq0d5vHyhR?=
 =?iso-8859-1?Q?6Qe10SWh/Bt38l93WaJbCpxJF3KDzdJ0/5Zn8bFzGoKgMgTw3xN7OoZDtk?=
 =?iso-8859-1?Q?UmYbg8dj68hpwAG9ehqrcfQL6FUnDrw2jlyWzAruam5mFJNKhCkZpjH6tm?=
 =?iso-8859-1?Q?b/SFFn2KChHj5NpJNdFp2UrGjGoM5RmTPksfWFuUJG/UAb7yGY5+SGxF7C?=
 =?iso-8859-1?Q?GKnznAnzXB1oL2Fc/2LJZLmu6L8elmN4nKqDQO2W6mAjDkSSzIiHTBYo0J?=
 =?iso-8859-1?Q?I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qC+rLH7X4ykeNnvSYY6t9eEZMfVrpJKoMiI7zezVmo+/bDGYZZMtdULpl5?=
 =?iso-8859-1?Q?9BOdkYFcShESNMVFcoxrdo/C71HlZnTCoiZwlEkNjRiPWzE/lfkXkFnMMG?=
 =?iso-8859-1?Q?ZHTHnMIj0GcpbIXUMc/cQgqmWLLp7OyvpiMLjklXrG2BAlX96F7gl5MY4r?=
 =?iso-8859-1?Q?e4/xl+vsFH1NMuBLNr70peJ+SHVH5XDv7aeHVMF9IT+43RfIB0f8ZpbkMe?=
 =?iso-8859-1?Q?XyZeaQO8T5mdlQh3HFWfJfOoZRkca4VZWHYd4Ra5Yt9MEVO5I+g07erjZR?=
 =?iso-8859-1?Q?PjBHfBNMq0u/GWMjstnKYDfLdxaWlSUjT2Vmdo4WyyOJkv7pFXbMHX4pNO?=
 =?iso-8859-1?Q?/Ey9bCyoOsjLs607wHJIIdR7cKWp1+OQcK3IrCDh9ECTXb37mWXLc9IcUy?=
 =?iso-8859-1?Q?ZqknoBS1ZpsRUjpboojSMJ0DIuauoW9ixQFQ1wZbA/bh1DjsTaGT74u3sL?=
 =?iso-8859-1?Q?TbfP+qk8WjqnEhZ/gYUqlH4RszA4eEQl58aUN1hkKOiTe/CkhLNtMiQjDk?=
 =?iso-8859-1?Q?X3RRL4XMw+5HJu+DwSkw35kIVv6gMeKoVVmHAckyazFXfFb2/XZsUCsD+v?=
 =?iso-8859-1?Q?myStnoWRtMDMAqoHRfyLH2LB2Mfi93vpUmABCTe3/RyT7be53Qrb/2SYhM?=
 =?iso-8859-1?Q?wkUx+iIB3iupSdixQfsb1prj8fH59Tak/yjJj3yFTcguOG3h2EaYLS0znD?=
 =?iso-8859-1?Q?iYS+x4eAvhNopixAaVtLwlNktzmh2ljTwp7lxZKqUFV/Pj+iF9xLW0vEiU?=
 =?iso-8859-1?Q?DZZ7AspUpD/mNhEJG6jgJPrX8Nmo/2JZyYLdAScpptndVU7Tb/3wDDPCvx?=
 =?iso-8859-1?Q?bRxAHnIY/HBJlbYqxLL09iwUKqFVjozGNUa9M5iorFRtfxzE2fCWmkOvsy?=
 =?iso-8859-1?Q?F5ShZzEzYA8/j7B/kl3xcAE2dFej0gwQIGx7jeGsEXA+Ty4diOibDORHHg?=
 =?iso-8859-1?Q?a9HfRCsA5vcird2ST/eBIJ0v/wS8Al1+DsoT43qPX43fni+zebVwjjov6r?=
 =?iso-8859-1?Q?DeNoIavx0Dn4g7JYQsa2pVckqX4MUqVBbt+mKCoMcENsa7aCIKfagEo26i?=
 =?iso-8859-1?Q?vINkD9prtfRuen+UgQc0TXOO/DbETNQlSfA6d0+mcn1joFpwWKatyoNbo+?=
 =?iso-8859-1?Q?MXwNKqfKzFfrkjxKvqBw9ONn6C4iU0rUgVJV659s8Nc/WHKbR6EjNV0FkN?=
 =?iso-8859-1?Q?ocOQhrYjpn/ONGKo3S28UwYHILe2KAcm5uNQ1P+Ojw4aSSZnoLta5NjfG6?=
 =?iso-8859-1?Q?a9LawBz28CsptENEt0Gwcari6+pzxBO4JvGDax4++LyWfil9VA+NTrtXAr?=
 =?iso-8859-1?Q?Fo+pJK+3qe1eC0dBBml7IEnycVAWrKaJW6HlHF1L8MhZE1cUMSoVOF/DHQ?=
 =?iso-8859-1?Q?iGImpS0skOye3bY5o/Zl5+Jo72tUqbAP412mZAB0FQ+memW1pQSoBIc5e6?=
 =?iso-8859-1?Q?lA/R//M5TDCkZM/D1APjaaPAMcdovtbViYSkInZjufCYwAnUpX+kbNoSpf?=
 =?iso-8859-1?Q?R7ZjoIiyRL+JCmvsorN4L6Nv4AZbH9d66Hwd00qMUgBfMRbXsHalzBKo4s?=
 =?iso-8859-1?Q?cciTYg/tDYL4wc9F57FleuNGLMLgAZE1pGxPwrHRsI2aaRre12KY1dJ185?=
 =?iso-8859-1?Q?I9vDzv7gExGcyuofrqybAzbDhuzIhalBM3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016eb3de-e8f5-484d-2132-08ddf22244a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 17:31:55.3330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9xheKWy+cZ0NC+3fZXKc8hfvpK83Q9pwSrjIlZN0Yx9CmYU6v514B7kVBHnlaoA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851
Received-SPF: permerror client-ip=2a01:111:f403:2412::624;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  "Edgar E. Iglesias" <edgar.iglesias@amd.com>
From:  "Edgar E. Iglesias" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 12, 2025 at 12:00:13PM +0200, Luc Michel wrote:
> Refactor the CAN controllers creation using the VersalMap structure.
> 
> Note that the connection to the CRL is removed for now and will be
> re-added by next commits.
> 
> The xlnx-versal-virt machine now dynamically creates the correct amount
> of CAN bus link properties based on the number of CAN controller
> advertised by the SoC.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/arm/xlnx-versal.h |  7 +--
>  hw/arm/xlnx-versal-virt.c    | 73 +++++++++-------------------
>  hw/arm/xlnx-versal.c         | 94 +++++++++++++++++++++++++-----------
>  3 files changed, 95 insertions(+), 79 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index b01ddeb1423..007c91b596e 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -29,11 +29,11 @@
>  #include "hw/ssi/xlnx-versal-ospi.h"
>  #include "hw/dma/xlnx_csu_dma.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
>  #include "hw/misc/xlnx-versal-trng.h"
> -#include "hw/net/xlnx-versal-canfd.h"
> +#include "net/can_emu.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "target/arm/cpu.h"
>  #include "hw/arm/xlnx-versal-version.h"
>  
> @@ -81,12 +81,10 @@ struct Versal {
>          struct {
>              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
>              OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
>              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
>              VersalUsb2 usb;
> -            CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
> -            XlnxVersalCANFDState canfd[XLNX_VERSAL_NR_CANFD];
>          } iou;
>  
>          /* Real-time Processing Unit.  */
>          struct {
>              MemoryRegion mr;
> @@ -139,10 +137,11 @@ struct Versal {
>          uint32_t clk_125mhz;
>      } phandle;
>  
>      struct {
>          MemoryRegion *mr_ddr;
> +        CanBusState **canbus;
>          void *fdt;
>      } cfg;
>  };
>  
>  struct VersalClass {
> @@ -155,10 +154,12 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
>  {
>      g_assert(!qdev_is_realized(DEVICE(s)));
>      s->cfg.fdt = fdt;
>  }
>  
> +int versal_get_num_can(VersalVersion version);
> +
>  /* Memory-map and IRQ definitions. Copied a subset from
>   * auto-generated files.  */
>  
>  #define VERSAL_GIC_MAINT_IRQ        9
>  #define VERSAL_TIMER_VIRT_IRQ       11
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index e1deae11317..334252564be 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -41,15 +41,15 @@ struct VersalVirt {
>          uint32_t ethernet_phy[2];
>          uint32_t clk_125Mhz;
>          uint32_t clk_25Mhz;
>          uint32_t usb;
>          uint32_t dwc;
> -        uint32_t canfd[2];
>      } phandle;
>      struct arm_boot_info binfo;
>  
> -    CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
> +    CanBusState **canbus;
> +
>      struct {
>          bool secure;
>      } cfg;
>      char *ospi_model;
>  };
> @@ -207,42 +207,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
>      qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
>      qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
>      g_free(name);
>  }
>  
> -static void fdt_add_canfd_nodes(VersalVirt *s)
> -{
> -    uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
> -    uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
> -    unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
> -    const char clocknames[] = "can_clk\0s_axi_aclk";
> -    int i;
> -
> -    /* Create and connect CANFD0 and CANFD1 nodes to canbus0. */
> -    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
> -        char *name = g_strdup_printf("/canfd@%" PRIx64, addrs[i]);
> -        qemu_fdt_add_subnode(s->fdt, name);
> -
> -        qemu_fdt_setprop_cell(s->fdt, name, "rx-fifo-depth", 0x40);
> -        qemu_fdt_setprop_cell(s->fdt, name, "tx-mailbox-count", 0x20);
> -
> -        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> -                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
> -        qemu_fdt_setprop(s->fdt, name, "clock-names",
> -                         clocknames, sizeof(clocknames));
> -        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
> -                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                     2, addrs[i], 2, size[i]);
> -        qemu_fdt_setprop_string(s->fdt, name, "compatible",
> -                                "xlnx,canfd-2.0");
> -
> -        g_free(name);
> -    }
> -}
> -
>  static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
>                                       uint32_t phandle)
>  {
>      char *name = g_strdup_printf("%s/fixed-link", gemname);
>  
> @@ -659,22 +627,25 @@ static void versal_virt_init(MachineState *machine)
>  
>      object_initialize_child(OBJECT(machine), "xlnx-versal", &s->soc,
>                              TYPE_XLNX_VERSAL);
>      object_property_set_link(OBJECT(&s->soc), "ddr", OBJECT(machine->ram),
>                               &error_abort);
> -    object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
> -                             &error_abort);
> -    object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
> -                             &error_abort);
> +
> +    for (i = 0; i < versal_get_num_can(VERSAL_VER_VERSAL); i++) {
> +        g_autofree char *prop_name = g_strdup_printf("canbus%d", i);
> +
> +        object_property_set_link(OBJECT(&s->soc), prop_name,
> +                                 OBJECT(s->canbus[i]),
> +                                 &error_abort);
> +    }
>  
>      fdt_create(s);
>      versal_set_fdt(&s->soc, s->fdt);
>      sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>      create_virtio_regions(s);
>  
>      fdt_add_gem_nodes(s);
> -    fdt_add_canfd_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
>      fdt_add_usb_xhci_nodes(s);
>      fdt_add_sd_nodes(s);
> @@ -753,30 +724,34 @@ static void versal_virt_init(MachineState *machine)
>  }
>  
>  static void versal_virt_machine_instance_init(Object *obj)
>  {
>      VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +    size_t i, num_can;
> +
> +    num_can = versal_get_num_can(VERSAL_VER_VERSAL);
> +    s->canbus = g_new0(CanBusState *, num_can);
>  
>      /*
> -     * User can set canbus0 and canbus1 properties to can-bus object and connect
> -     * to socketcan(optional) interface via command line.
> +     * User can set canbusx properties to can-bus object and optionally connect
> +     * to socketcan interface via command line.
>       */
> -    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
> -                             (Object **)&s->canbus[0],
> -                             object_property_allow_set_link,
> -                             0);
> -    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
> -                             (Object **)&s->canbus[1],
> -                             object_property_allow_set_link,
> -                             0);
> +    for (i = 0; i < num_can; i++) {
> +        g_autofree char *prop_name = g_strdup_printf("canbus%zu", i);
> +
> +        object_property_add_link(obj, prop_name, TYPE_CAN_BUS,
> +                                 (Object **) &s->canbus[i],
> +                                 object_property_allow_set_link, 0);
> +    }
>  }
>  
>  static void versal_virt_machine_finalize(Object *obj)
>  {
>      VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
>  
>      g_free(s->ospi_model);
> +    g_free(s->canbus);
>  }
>  
>  static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 87468cbc291..7ed1001dab3 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -25,10 +25,11 @@
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
>  #include "system/device_tree.h"
>  #include "hw/arm/fdt.h"
>  #include "hw/char/pl011.h"
> +#include "hw/net/xlnx-versal-canfd.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -41,16 +42,23 @@ typedef struct VersalSimplePeriphMap {
>  } VersalSimplePeriphMap;
>  
>  typedef struct VersalMap {
>      VersalSimplePeriphMap uart[2];
>      size_t num_uart;
> +
> +    VersalSimplePeriphMap canfd[4];
> +    size_t num_canfd;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
>      .num_uart = 2,
> +
> +    .canfd[0] = { 0xff060000, 20 },
> +    .canfd[1] = { 0xff070000, 21 },
> +    .num_canfd = 2,
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -284,40 +292,46 @@ static void versal_create_uart(Versal *s,
>      if (chardev_idx == 0) {
>          qemu_fdt_setprop_string(s->cfg.fdt, "/chosen", "stdout-path", node);
>      }
>  }
>  
> -static void versal_create_canfds(Versal *s, qemu_irq *pic)
> +static void versal_create_canfd(Versal *s, const VersalSimplePeriphMap *map,
> +                                CanBusState *bus)
>  {
> -    int i;
> -    uint32_t irqs[] = { VERSAL_CANFD0_IRQ_0, VERSAL_CANFD1_IRQ_0};
> -    uint64_t addrs[] = { MM_CANFD0, MM_CANFD1 };
> +    SysBusDevice *sbd;
> +    MemoryRegion *mr;
> +    g_autofree char *node;
> +    const char compatible[] = "xlnx,canfd-2.0";
> +    const char clocknames[] = "can_clk\0s_axi_aclk";
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.canfd); i++) {
> -        char *name = g_strdup_printf("canfd%d", i);
> -        SysBusDevice *sbd;
> -        MemoryRegion *mr;
> +    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XILINX_CANFD));
> +    object_property_add_child(OBJECT(s), "canfd[*]", OBJECT(sbd));
>  
> -        object_initialize_child(OBJECT(s), name, &s->lpd.iou.canfd[i],
> -                                TYPE_XILINX_CANFD);
> -        sbd = SYS_BUS_DEVICE(&s->lpd.iou.canfd[i]);
> +    object_property_set_int(OBJECT(sbd), "ext_clk_freq",
> +                            25 * 1000 * 1000 , &error_abort);
>  
> -        object_property_set_int(OBJECT(&s->lpd.iou.canfd[i]), "ext_clk_freq",
> -                                XLNX_VERSAL_CANFD_REF_CLK , &error_abort);
> +    object_property_set_link(OBJECT(sbd), "canfdbus", OBJECT(bus),
> +                             &error_abort);
>  
> -        object_property_set_link(OBJECT(&s->lpd.iou.canfd[i]), "canfdbus",
> -                                 OBJECT(s->lpd.iou.canbus[i]),
> -                                 &error_abort);
> +    sysbus_realize_and_unref(sbd, &error_fatal);
>  
> -        sysbus_realize(sbd, &error_fatal);
> +    mr = sysbus_mmio_get_region(sbd, 0);
> +    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
>  
> -        mr = sysbus_mmio_get_region(sbd, 0);
> -        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
> +    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
>  
> -        sysbus_connect_irq(sbd, 0, pic[irqs[i]]);
> -        g_free(name);
> -    }
> +    node = versal_fdt_add_simple_subnode(s, "/canfd", map->addr, 0x10000,
> +                                         compatible, sizeof(compatible));
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node, "rx-fifo-depth", 0x40);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node, "tx-mailbox-count", 0x20);
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
> +                           s->phandle.clk_25mhz, s->phandle.clk_25mhz);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
> +                     clocknames, sizeof(clocknames));
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
> +                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>  }
>  
>  static void versal_create_usbs(Versal *s, qemu_irq *pic)
>  {
>      DeviceState *dev;
> @@ -1046,11 +1060,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
>  
>      for (i = 0; i < map->num_uart; i++) {
>          versal_create_uart(s, &map->uart[i], i);
>      }
>  
> -    versal_create_canfds(s, pic);
> +    for (i = 0; i < map->num_canfd; i++) {
> +        versal_create_canfd(s, &map->canfd[i], s->cfg.canbus[i]);
> +    }
> +
>      versal_create_usbs(s, pic);
>      versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
>      versal_create_sds(s, pic);
>      versal_create_pmc_apb_irq_orgate(s, pic);
> @@ -1074,28 +1091,50 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
>      memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
>                                          &s->lpd.rpu.mr_ps_alias, 0);
>  }
>  
> +int versal_get_num_can(VersalVersion version)
> +{
> +    const VersalMap *map = VERSION_TO_MAP[version];
> +
> +    return map->num_canfd;
> +}


Is there a QOM way to do this? Like a read-only prop?
Or do we usually handle these kind of things by non-QOM side interfaces?




> +
>  static void versal_base_init(Object *obj)
>  {
>      Versal *s = XLNX_VERSAL_BASE(obj);
> +    size_t i, num_can;
>  
>      memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
>      memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
>      memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
>      memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
>                               "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
> +
> +    num_can = versal_get_map(s)->num_canfd;
> +    s->cfg.canbus = g_new0(CanBusState *, num_can);
> +
> +    for (i = 0; i < num_can; i++) {
> +        g_autofree char *prop_name = g_strdup_printf("canbus%zu", i);
> +
> +        object_property_add_link(obj, prop_name, TYPE_CAN_BUS,
> +                                 (Object **) &s->cfg.canbus[i],
> +                                 object_property_allow_set_link, 0);
> +    }
> +}
> +
> +static void versal_base_finalize(Object *obj)
> +{
> +    Versal *s = XLNX_VERSAL_BASE(obj);
> +
> +    g_free(s->cfg.canbus);
>  }
>  
>  static const Property versal_properties[] = {
>      DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
>                       MemoryRegion *),
> -    DEFINE_PROP_LINK("canbus0", Versal, lpd.iou.canbus[0],
> -                      TYPE_CAN_BUS, CanBusState *),
> -    DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
> -                      TYPE_CAN_BUS, CanBusState *),
>  };
>  
>  static void versal_base_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1115,10 +1154,11 @@ static void versal_class_init(ObjectClass *klass, const void *data)
>  static const TypeInfo versal_base_info = {
>      .name = TYPE_XLNX_VERSAL_BASE,
>      .parent = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(Versal),
>      .instance_init = versal_base_init,
> +    .instance_finalize = versal_base_finalize,
>      .class_init = versal_base_class_init,
>      .class_size = sizeof(VersalClass),
>      .abstract = true,
>  };
>  
> -- 
> 2.50.1
> 

