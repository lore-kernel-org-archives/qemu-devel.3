Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C53E7DEFC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmwLV-0002ZS-Al; Mon, 02 Feb 2026 11:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vmwLT-0002YX-IN; Mon, 02 Feb 2026 11:00:11 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vmwLR-0000re-Pm; Mon, 02 Feb 2026 11:00:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3gPVpzDrzlkz2tRIPsCW4PCRgxCiLRKiwMyJ4c9q0LxNj/ObQLL7AeUVh/rFS52/OTuJypoZUZ13RNiMUYPGIWy5QNR4KmpZSrokEObeQ1/ActBhp8ZJVsrkTxdHeoHfghC3ANiriUK2j7o71sgobM3wBfc+GhFQZ3jNYYimOYKtIkczn1tmLMuwlS4kQ/2XYBK3Z/bkUO6snn4oV88m1ZdVILFvEBGtaQ1i3RE/OJEeoDPZGspHAQfr+WCyanPPwgzmzHj+6Xvme3YERg1/8Qe7tnkPiksBMcujdYQAdMl7Ka1hA68SzyEpNGe1Cll/orozRf85aUux/Ct6e60hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivV4Skt1wyya6HERJp1B0A6uzpHw/Hx+Np1ABFue3nc=;
 b=c1L0b+9BrGkritEo5KjnURlL6LJ/HfY+YXmhpjRi7qn+5oYHeMM5L1xmNmaX3+Ub01tkov88y6xLbyqEcClgiyyXsJED6onKOleuQ6lQfpYERV/VUEboUFt9XT+eVyHwwKUqEgCrLnpzNvSNig5n1yVoGa85Y1o4EdKS3PWa5cYX4mONLxJtO/sCPU04joEzreNTqswvhbTiMvLQ8UEUdvLFDZ7QcqeSB+ggGE5vE+Hl9rW+NWSywhz+7jzSzNSlj2ztYtK/bL43zcJNjn9NxguxVKSo3ufmh/NbRSQO/2CqHwCXfrvNmnxkxTe9/8Gk/S1MBoolj63C47OB2mlL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivV4Skt1wyya6HERJp1B0A6uzpHw/Hx+Np1ABFue3nc=;
 b=bsDinWNZgTuUweDt5B0/SccpkQ8rdMcg3/iu8UwyIJ+0tGpkSNBRiJrTd2r4KBTAS5SI5xbdeWDkw6dBfUGyaZmfnFskNSRLJrp38YE864I7ZtZGcfnhDZwGXGaaquYA9L0In1vh+gc4cCTSpC/rGlis2WVJ7g3cZq9x/Xo0VsxW2WxwkPdRcyOK9JaOb8z9WkBurBgQTcLy6wVoc0Bl/EradMrPxLnaEP3UwllHI+OWShv0FtgnGhhLFHbXtqY0NPoXP1b+zxeBh2ZvK6hDjV8voK7QUTLJy6J8sPizpwjZQV34vKpLzViryuNqbUDFIYHxhSf9UIjSVqB5aQXmwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:00:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:00:01 +0000
Date: Mon, 2 Feb 2026 12:00:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify
 OAS bits
Message-ID: <20260202160000.GR2223369@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
 <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202151917.GO2223369@nvidia.com>
 <CH3PR12MB754835BE4A5C54387122504AAB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB754835BE4A5C54387122504AAB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-ClientProxiedBy: IA4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6942ae-619d-4c30-29f3-08de62741f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gaKlVuhZdB2XtxWxqadagGitci5RXGwdgJKyCWQLEBkBEtcoOF3/++BcK9wm?=
 =?us-ascii?Q?q4LGsyL9V4UMv6jkmQVhbiZshxH6Xt6OPGnFWX4fl9tvOcDCWR8Mvp4Pjm0h?=
 =?us-ascii?Q?31WwjUXD1XqBL616m+hjX4IqAskdmd2/NfCrVAYuH/W31BDSYfQPGNJV8eDP?=
 =?us-ascii?Q?c+BE81IiOFOX0NyE/G09wtacvSmNO/9tXMSHbC+eb3orD3GJqRNWDaqTiovc?=
 =?us-ascii?Q?HdyHidllkoWvpuDdp+RQhSkHu1kvislofLFu2T8b0vmrGkvxvf9NIJ0P9cgq?=
 =?us-ascii?Q?MKOfj1hB9RRgXfVlZwmdErsYbFHKCFL8NoUT4bFBKcnJsWRGQZWHKzfbN7pV?=
 =?us-ascii?Q?7P1S8loXrCG8lRRlqj6giDLo5e1JkXlsn47rIL8OhjfOj8tt/kD78837c2g9?=
 =?us-ascii?Q?D5eLCgEbaxQol/eAiviEDlbnMPBR93CPFX95S7E5maGu+/iTRgfTzhepLufp?=
 =?us-ascii?Q?fqkzAxasGkkSU3qJziEwQcrUMKHpe1QM/TrtRkxquFKphHqdD/f4A4ZvSa/1?=
 =?us-ascii?Q?viG0m+yyoYnicTRvXwloWZS33BzAiNadKka+oW6Dv+iCWDQ7OziT06peo56K?=
 =?us-ascii?Q?orGRu5/Suy60hhLGpkT4UIbUySubIOqqYBQt+4IsDMR/aJ+09IK41YqufZe1?=
 =?us-ascii?Q?b12MVsSpH59Z49RVyi14VDTqFzgLys25yFDzDJXMtSrFPk5aY3r+l1eKTily?=
 =?us-ascii?Q?yzuOPlbmD7PYrCo2V3dH0w9PYDyDkhMPo+ngWR5rzRO6pnuP6lAwgcG+2XED?=
 =?us-ascii?Q?3xpfeQpaPBBU/eTsJTps7xhMbMMymulxDiMN2CFETalbYvHTipSZSzhe2uLb?=
 =?us-ascii?Q?DG85k5zVU5Y2aK3/2neO/oUojIWrDlipy5FLB4SfCnc7y+YavB7VR2cl2Ci5?=
 =?us-ascii?Q?9Yy/NAVoqjH6UWStialgWEAHBv1ZIJ/Dq4CwqbfqcQ+7P0m8mB5WFMTc3x4Y?=
 =?us-ascii?Q?Yis/esb17+wBZf8xCEI6jJJBiF0QB/6y45iJge8hOdiKti3Noq04hyrJByJq?=
 =?us-ascii?Q?t/cy7WDTD9t0bksHHr1kerq58dOZ6H/Zlu/ruVmVn51ybOMcOJ6i1qORb8WW?=
 =?us-ascii?Q?Z5NdzOFYqfanwVOVLgruhQE+9853jGoMsGPvwb6rRB84Ys/kKcEz9ykNPpcu?=
 =?us-ascii?Q?HJFAVIg+BchuapeMtpz6A0Lln2RH4fouTnxFyOR+wXfYfnB4hymdJtWaKhj7?=
 =?us-ascii?Q?TXPo5t0OH0tEgmp9rES2o+Ua2y1x4/pzzu+XMArX3dTY/TPYwvioWbqui6p5?=
 =?us-ascii?Q?vstgk/Gk4ZV9362xRAMiqGluKdtXRlvJcsuUEWiBTpG8EqbCeGyU5/LH4UGG?=
 =?us-ascii?Q?j8xwZYsxgFjv2shZfAPm0EISI5cf60XKp4iMxAXCoKP0z7mGzC9LUMOaJS9A?=
 =?us-ascii?Q?6aN9j9WLjCte7hV63t10gSgWwiBr4ytrmQqPilGwzYOV7c+zhjCv3naD1iqU?=
 =?us-ascii?Q?iO2aRe+vE+SdV+dBfKzUSuKdasSCoE2Q4mokGpn6mMAyQQ4AUv4AUHtzy6hv?=
 =?us-ascii?Q?b5ZI+X2jhmOMLjq9UrpNfY0WAfw7LSRjY7BR8iNioFWLt7jMmbaQByNQhFUS?=
 =?us-ascii?Q?+ai3obh//RcCx3Z3z5k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+YqbtZfAEUK511GwFL86UTlGhsrq5yr0C3sOI9qNA2zxAWg/vYbIJNEMz82K?=
 =?us-ascii?Q?PrOHYR4TcsC8otICTG/jcBrA3c9BBZ1iVsbmYSl5i9gUeZVpAAFtIGiUzBVg?=
 =?us-ascii?Q?13oieCyXDy+xZI7FoDuMT5YS6oF1tKaXhXbGNlIxMbopcRqrdYuDfg66dIiO?=
 =?us-ascii?Q?p/9EhRgrcF7dW+jYlSk8Cbt68zwpP2wCX9L/r196Pl1WmpAmTcH1LO+HQVJZ?=
 =?us-ascii?Q?+6/RTSdGcSK2lwPrQMNMLfr9JyYxKcHfIMG9nHqiQXcQoOjUVQKd6fRinSs+?=
 =?us-ascii?Q?REq1qYn/Zx/ZjHd+4YvBM9/xrz2UFteM4Yw6VwRwFLAtKJ9vVvgC98uXVx06?=
 =?us-ascii?Q?g6CkEoUwRthOhZtsf2dAqe4LWkObVVxX2saSrGzW8o91acRnma+RzLmuvIsi?=
 =?us-ascii?Q?Q9vf/xE3KBUZJ62zS3SrS1JSOG1qWH2vJLqH3AxVNYxqlk/lZOX0xEhfkuuS?=
 =?us-ascii?Q?ve9BX/MAZXIOX7pGaD4zDaFiBAzYeO0Wfma8OplJfaMUsl2i1IStBmgTmR1X?=
 =?us-ascii?Q?F0FF9P9JFSBO4jok481s794P0v6AooVbB7uDv+qERzT5vwtPCSfYEW2ILop7?=
 =?us-ascii?Q?MxHetbq30f+AFjMVKitd73kOdpNDq9yJl/W6dCUcdlKWAwzzTZi6CQ6reVPP?=
 =?us-ascii?Q?GoBEMsmaPHh3GpZzb23dagTYEk3z6d//fbE0qKQnOtaDUu7nB0ScCRSISQ2G?=
 =?us-ascii?Q?nbpCYx8eMRuyXhpDReyfBQP/OAYKZno1OAtZZ9R4hQBRO6LTbUvlDmhRIIHO?=
 =?us-ascii?Q?FrLix0JIsue/laNCMB5vTCTkM00iQCwEDABPdt4g1IhlErfxujPDrlnuZxre?=
 =?us-ascii?Q?o0EXGr+koSsgr4WEJH3vjoDe4xBHvot6hR58FXEnDVaKjxiWE2qktN3TDFyl?=
 =?us-ascii?Q?NEMJbtZrEFqGXzrmTwBYAX39QPKv4QR3OpqjJogSkoO9sRm1raXZXOzFxh1K?=
 =?us-ascii?Q?ePR99qp+YplqF0WdRW+TtK3j3k7dfSJYsIeq1d1J+zHY+MrSVVDg1az7dShN?=
 =?us-ascii?Q?4WhzbDqkC7oMdUAmT6GIW/lzkLToYvMevZB/qujWfc9ce87PkeRNdSAeO1Z8?=
 =?us-ascii?Q?y3J7a0CeLbJVbSVZ6h+8pkfb13K32Jhjpzb3eEhVp1hFG0MqxFv4j0sWDmzB?=
 =?us-ascii?Q?KgFtDEGc6466S0RheMYFoHEO9p+xlRVCs2sulGodmtuXPJMJIakXKJ+EaCVM?=
 =?us-ascii?Q?dCjpgTdeYHqgdcwZMoWNVSiKnjCNiGV0ctwlDr/kcyQ6pzvAtaJzO/syeZkE?=
 =?us-ascii?Q?qrlbEdbJiV1YB+8J+Z/RH320MHZLMZ2XwhTiPKlPqOIPq7ufTfwIhhGiNTLj?=
 =?us-ascii?Q?IK1gPRExIemHljsbJMfkhwNSlTm9+30iXvTLqA93L6aW5qQrv953rB5njyrM?=
 =?us-ascii?Q?sSxx445BzMYlK8WEadfiAVtk57ZGTbfhqvwMsF1F1WvZh6+A4KgSW+S8pBCY?=
 =?us-ascii?Q?G2SwzISIG9EurKIVXZjVz8cHqFw3EPkd3e+OEOZ0FwAXGrOmOxZ150lFeY6c?=
 =?us-ascii?Q?8mKGyAGgc1YiE7OZTnQh+TQi9JIH7tQ9s66w6OBF2oo7X7qxBDxvpaIY+eQJ?=
 =?us-ascii?Q?mlQCHrpMcBxujojvZ9WuBEpO7ZNRqFrYns6/wyWlm7ujpEFJfdkyQ96AZaEg?=
 =?us-ascii?Q?tQjk+JyCxXwbzDiS1ak7TrWmsdBZo5OCAOaAILd0OMBS629I5PV+nVAMeJaM?=
 =?us-ascii?Q?2fsI7CrgBMxvAbvIbAzD7p5sgZQKwI8RW60G36rOgUzmvvEf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6942ae-619d-4c30-29f3-08de62741f36
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:00:01.4601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIJb73KOXZkwW5KGmPRBqU0Lx0WK2AeALYjjX+8LLHSk5mmE6JydSB/cVo9UXgMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=jgg@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 02, 2026 at 03:38:50PM +0000, Shameer Kolothum Thodi wrote:

> > We can treat ATS as a per-PCIe device property.. I think it would be
> > fine to tell the SMMU that it always has ATS support, it will never do
> > anything with it unless it sees a PCIe device with an ATS cap, and the
> > physical STE generated by the hypervisor should sanitize the EATS.
> > 
> > BIOS overriding it should be reflected as the devices being reported
> > as not supporting ATS, qemu should have a per-device flag to disable
> > ATS.
> 
> Do we have way to detect that(IOMMU_FWSPEC_PCI_RC_ATS) from
> userspace now?

I don't think so.. I was describing how I suspect that should work.

The iommu driver is the only entity that decides if ATS should be
enabled per-device, so it should report back to userspace in iommufd
if the device is allowed to enable ATS or not. That should roll up any
FW overrides and the PCI cap block.

Jason

