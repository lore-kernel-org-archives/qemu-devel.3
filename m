Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B846C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5I9-0000Ni-Sj; Thu, 06 Feb 2025 12:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg5H8-0007id-3H; Thu, 06 Feb 2025 12:03:01 -0500
Received: from mail-dm6nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2417::61a]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg5H5-0001Mv-WC; Thu, 06 Feb 2025 12:02:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiUlMNuqrUBTEpTxbcfA7TRyB4H8J1F8iTuvMA4eVhACOi7JWcjHdQM+l6QyHaZZ/rD5quaFgiuV2+yycbFjYs4Xly2kroLlxIU2+AGFq6wCeUcSD9p3UzZhwswLx20EXS2n+qPDPdqkscMUhgWoaMw7MFnvzc7+R4hCmzVcswXuksp6pZJYjibgJHdHJ1z2hucPOSQAqglZRNq9FxygNhndItHsErR3v29lP5qBkRzCeWimbnucKBvgR+qWmcMqjxrgsXAgw2GlCyGVEpYdZyM6DNbUMvOvaZm2YRB0V7IQxeeZ76qx9UzfRpGKvRtJWnXtB7gb+d4acLU3GSxYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/Ss5QSfeP5VgpUV331B2EzZhOK9eSSjhpvSw0YtT9g=;
 b=vlXNVBiB5vuTd2gB4mAb+IBZHEy8Ada2HrFP1C02eS8L20vFRFvKzOqSaLNE6znLsIAKzRqVdZTf51QdjO24qw0IBds3NntTcm5GVm/0RXWix1NQetq8khkebRtTTX2aHZ10PehAO8BLhjy8kG4z1zJzMdT/u+/vZSJ1Pcv/+36T9u06niaIAls2VO+2uUbp0ZZYtMEIppXtv7dK0talzBpXXDlEKCwR1E++gGakS3OvcbHLchwKVkFC2HacgbEc/KC7S9v5+jSu+OkFYOOymhxTcnBBnPAq9jFE8HouF+Fd7Wcoia0g9YpR5kTRbeqlnk2CmaLHmMokg+RE/wD9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/Ss5QSfeP5VgpUV331B2EzZhOK9eSSjhpvSw0YtT9g=;
 b=mmWC4AF5a2Mn5avPELLrPYdMZe+rC977nu2kDj6fOxmi4b7NeKOp3mcF1mZ3lBhYtklfd5BnI3D+ZMwQF/XAZNa0uQvzhG0XCcND8FgbjVhCMTPqbaTg+RqIdwf+QgGzu2VsWGtggwzJAbmVizjh14zlaNes5isD7jiIqay8RcaMl+/g6nMteja2LR+feP3vqEdjWoE62s4nMv359ENL29ZZpx1SqpkHDM6/rvfhwelUt/TRCEpkuaeXUozrUgkJM/64SxzhRswy+l8FCIWgzbYt7P5n8+2N2fis31DRbh3gsegpvH9noNbHbw8kR0SgduRorqX5z1T2AwVfzR6O/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 17:02:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 17:02:39 +0000
Date: Thu, 6 Feb 2025 13:02:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <20250206170238.GG2960738@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com>
 <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <Z51DmtP83741RAsb@redhat.com>
 <47d2c2556d794d87abf440263b2f7cd8@huawei.com>
 <Z6SQ3_5bcqseyzVa@redhat.com>
 <f898b6de4a664fe8810b06b7741e3120@huawei.com>
 <Z6TLSdwgajmHVmGH@redhat.com>
 <71116749d1234ab48a205fd2588151ec@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71116749d1234ab48a205fd2588151ec@huawei.com>
X-ClientProxiedBy: BN9P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: f45afc10-945b-4721-4751-08dd46d01042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8KgGlRVeszMHbanhnCWtTvlzi4VteYt4JEdn1KP7bIgSezRlzQ5jj2fvZvcH?=
 =?us-ascii?Q?LfMGmgZaoTyZtkOOnHWMBiW1i14aGp07DkBnLWBvkulWw33zsRAJ8uXl7xgi?=
 =?us-ascii?Q?bECYXKXSM+SFSox29oe/9/lyehYk4pN0WPYLE7VPX8iB2mdmn2w/9qEPiMKF?=
 =?us-ascii?Q?Volc+2LZWzL0YM8JpD3dV12bGlmcAE0BiVSpjayFY/en//Z0HpiSP2i5M0Fm?=
 =?us-ascii?Q?HuiFu7VumQgY9WZPruDAFi1f/MQl+xkitR/vROq5lO+/z3khHfkghX+gQ3ok?=
 =?us-ascii?Q?1gNYv3HxLgyunMEOHmzCwtHjvEaa2EiaJqzFaDIPhNAPyQEyKzZXQW+COWFY?=
 =?us-ascii?Q?0OAaGeSSMMLKqWM0aGxraohITHshlsBkCEL0kR6xeaZDBvTwSlvpIGkmk1Cv?=
 =?us-ascii?Q?4cCtf1tIq+4MWEorRIMbHQRLk2QcIY5+noVDnEDXAhtGjPDUiA7no2XWu/h1?=
 =?us-ascii?Q?P9D9Vhq1N+oZcHmQQz8pIvwnk34EIcXcplfYXBG5AMFnXliHPEGQJk4Vxf2i?=
 =?us-ascii?Q?4uIHvl8kHOwHSDrVrawL06WNfohLt9LDMxC1oly4W/T5/6KW6ignYABLpKcg?=
 =?us-ascii?Q?v5R5dF5042Et6OGnuc+v6p3RfN3tdNF4xPnNgey+1jQMRWOOPp/igkxsqLgQ?=
 =?us-ascii?Q?bXzjdczjEzXZoYLaW/wTjf3tzhSMpwQC/Qv0koAA1S3m//TmCnTLPmQ68xeV?=
 =?us-ascii?Q?UJMTEgge7qEIPU03SJdNQivVXTCjMNvKpCSkUqcSxfogvwgVnxUsqsQhB1Ik?=
 =?us-ascii?Q?HHwkYN+qPrAbsdv0bfNwzmTJ9zq/Etsf51Z58L0Dj4g2ylUmo3ddTkWJ3/jS?=
 =?us-ascii?Q?R5SgyB1m9CnmdLJp34MFvIN6v1J8t1tXqdyWxeFsBH0zx4RA5Mxegqip1zfy?=
 =?us-ascii?Q?G3IHTIv+rPj2OqEz67v5SoztQSMApQjQhXzuguDPl3vaalvSXJimFhykGBHr?=
 =?us-ascii?Q?/EaFlnEElsU4KwDyn3tmqmtX+76gnWqd6K158ek1q7ZX5MWjHlC9VgKxlojf?=
 =?us-ascii?Q?fuN8rwI7m4GOS7LWMrKIiUqq2ZMrrlegE/4hqBPrjXH+hIIMGcLgV6Qdj/9q?=
 =?us-ascii?Q?FAG+XAja2aW2cmB2QYnTPvcUo4eUr2kidCNxNKr3Q64v18SLch3ntEkinEGH?=
 =?us-ascii?Q?NSlX04Gx6x77IKGVuM0jZcqp3vh1DPtxJNSrzDxSrubnZpG9dmmDRJnTrYVW?=
 =?us-ascii?Q?6MjdM7C2tti+C+AyUz887uSjq6YuNrC015UDLVkGHxNebG8c1YNf2nbCYxO5?=
 =?us-ascii?Q?tkRLN0vGL/qe5Y3dB2XJLMAGvVBCKkReKCCI7EmsYl19hrq3ZezWMLjc6/+G?=
 =?us-ascii?Q?ZcJqwDUYi2VnrpTylgenA7cH3Vr7outRRvm3Ed3T2RYPhfa+HpdcMjSXICCP?=
 =?us-ascii?Q?DFQhXm93tpKxzUFh+YMWFnwNLrHX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8CWkUR+OC8HxYixzksCaDvkjJLHcKJ8nU6OuBHntEpund5UEaLkxn6dDUAb8?=
 =?us-ascii?Q?jWyaV8pYi1da4LTFbGLz4yKMoQ5gvo4rrwfGsFZtLd8OM9mFCDpSL8X33ocP?=
 =?us-ascii?Q?8gQicYfdYQwbQ6UEYOvys0yK5lyLkiUm7kQJ6NNskFtzQDtC1sxaO3WgVH2s?=
 =?us-ascii?Q?92Dw40hCy+o61Mw25TitUVMihCr9qc5at0iMdBQgtDVB2Zj6+tWNNin/zp1B?=
 =?us-ascii?Q?F/LTyniw4BkfqmuGSJIk5eenvE23lAbncDRwr/SzSHN4b68InwqEn4+P5Dog?=
 =?us-ascii?Q?HsfDASgQ8V57pbGjgs2rATeCl6dkokhx9ozRpQY5JfGuRqlZ1uqD/UyoPPWw?=
 =?us-ascii?Q?HZ8UNL8XIav7PasXsjsBFpOjCN8hDSgzXo6IofhqcyYOXeR742LJF1+6GXU7?=
 =?us-ascii?Q?UbFE4PppFwHM0iHNB38r2S0PHOx6u/5Ji4S0oXQ0Q6GLSl1jtGPgsQzCXFJ9?=
 =?us-ascii?Q?fWXdgE4Hx7XquM8yQg8rumunsdf06UqEV8HxkwAvObEXd9SoqYfwUnXCDQ9M?=
 =?us-ascii?Q?oKlV7FB9+zaUDoIaH1/AxzlCk5w1dGmVFUx/0ZxHuFa9RFQAJy/17Pd/zIGJ?=
 =?us-ascii?Q?P1h34GTJlVfM2bCUeXcMI/hP46Cukl5bkK83+gbMGcbsvhZsY5J2Nz8XV4ko?=
 =?us-ascii?Q?MnzaebRX8nihDns35Gfq7W+iwnUQMkGd5DYhdPNRp6Qcz86mol6CqnpLhJCI?=
 =?us-ascii?Q?dp+jK6lJ2TBCF6lQjXSqDcvz9qOqLXZ7FPLTG8tVL3ZO08ddbutIUimvqr5s?=
 =?us-ascii?Q?4JHM9i7OcAAfz+g/wAwDBX00R+uE1s4QnOHZnSJ2g8LK2C1pi7bUvX1TbXMx?=
 =?us-ascii?Q?vW1O2DWjj55Gi5cT53lVjUxRwKsGzmQfyd9EuJIi23yQFz6hIB/j4bbJfWna?=
 =?us-ascii?Q?vqBpiwN9oYfpFtI5tDIBUBqpj0Cqkb1YPXdRkUqBGsc4nDkPcssG6+ioHGaw?=
 =?us-ascii?Q?J47hiDGo/BcgxFrCYiCj/Z5WxxyDFirfRg+Eu9H7D8xYPdor3Uzy/RlRqwlm?=
 =?us-ascii?Q?7HbW61X/LIAgSFudf9ekH/nS0OnZo3eSbH81dh0TsA4x8B2H2kdjuzf555hB?=
 =?us-ascii?Q?4Zjie7s9V6hWxi+e9JAeILaNZgewtnERfdzGEOox3o7vVa2cCqzokZPC8wcI?=
 =?us-ascii?Q?DjaqUGlMkwpVhTM0CbGa9DEXjbcp0maIttshHqC8q0frvYCV1eWrxJ3HnVAN?=
 =?us-ascii?Q?NRVKucewAIXTkI0XmXlM1cWa1fui9qTp/z/Fb9v07kOfOurqTcmJ7yYj2b4v?=
 =?us-ascii?Q?zLKJ1idy9SV1FwLADokZb3A057crVHZd/vM2Z5N96SgCW3foQ3epeDdQldzg?=
 =?us-ascii?Q?onw+fYj8K3M3t90zQiAx/0k+rxErIZduL7CZ+2511mYPvYVjQw24tLFeTdi7?=
 =?us-ascii?Q?7eFwScdJlve9GMw0U0LGR5Gfeg8/a6FrRnz3YNU4daiZT1Zi7SBAFagCrIAj?=
 =?us-ascii?Q?4OMj9by6ECtFZFGG5+swCKZxY/4huHlH73ywMR+NKtjnOwdw/jL5eCyEctHn?=
 =?us-ascii?Q?t2C83DHL3x7t+/WgxvkCjHbDFripqtY3PYVGZGz3TjetE1/vQC2CyaaQ73Zw?=
 =?us-ascii?Q?s7MeRuuvyxs9YQrFNgYgQsK5VI2M7tuFL054nYFA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45afc10-945b-4721-4751-08dd46d01042
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:02:39.8776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw13bCgbhgwPENtqmLDiM2RaGZbaAEFtHBHuiLPk1/7mIOapEeTrC1mRHveUAmlo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
Received-SPF: softfail client-ip=2a01:111:f403:2417::61a;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 06, 2025 at 03:07:06PM +0000, Shameerali Kolothum Thodi wrote:
> > If we set the physical/guest SMMU relationship directly, then at the
> > time the VFIO device is plugged, we can diagnose the incorrectly
> > placed VFIO device, and better reason about behaviour.
> 
> Agree.

Can you just take in a VFIO cdev FD reference on this command line:

 -device arm-smmuv3-accel,id=smmuv2,bus=pcie.2

And that will lock the pSMMU/vSMMU relationship?

Jason

