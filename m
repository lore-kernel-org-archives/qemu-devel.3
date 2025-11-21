Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6F3CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcj4-0000C7-Of; Fri, 21 Nov 2025 20:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vMbOF-0003WO-Bp; Fri, 21 Nov 2025 19:22:12 -0500
Received: from mail-northcentralusazon11012041.outbound.protection.outlook.com
 ([40.107.200.41] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vMbO4-00023o-VC; Fri, 21 Nov 2025 19:22:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYyGZMbJDR+WxLVxwn+iUfTj6FX6bTitggHo/bvXqGfX3RPYz/xL+5PaNuc00d5i5xTuXDA0BqIURcKCNAHxurowUoWnSbdcU1ysTZGFi2K4UzcDBphPjWfP5tqfPmDOnGaNkAo31hzgAVt56LNtu7KkgSi27bMyW1BCbLbN44jZPdXCi05Mey3db7e2SHlcYtGv5fN821huTb0qlrVqv6vnUzw02TS1AR8NDqIa/w/AcZ7Em7e3T0g01eC+9KpC8ekHEVfJq5RL1Lqrs+HnYW33dyKCOHsTYriyzO543bos/10GyiSn/VbcA1LrvTGY5w9Y5jlnmULY+7FpXsWqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tNpiq2WcMy4ZDTlH93XIN1IqAXdsXwj3TqXTtyNrBo=;
 b=YRyqAs1IsNRU8tfdyMivvdlo3Sbmp5Kv2Pb7LwlfKGs/uXX8y1MmvqntN7azc/1+iMNRKJ8c4/Zbknvgdte327V0EuEyAOQH440QBH0htKIwOsi0itrRaOL052HMU0keA+VKDOya1pFYWeqSdPCd1ae4vm1AmUFSNiXkVuYaHYOjNMXUmWJ04YfSTWjyRsOkDU98e0ZFj09S4vDJuxBn1U0+fxjOluCM9NtQsH6bzMHRyTjdXMoRHxkWBIfsuvFBRAI72tfDQf8/1jKN3Ot+Q76lbIQnm0ZsLbSJiPkaO/oQfAwzcp2MqR07FKnmIuNdmFAIRvnsLLBKICLzZr8F6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tNpiq2WcMy4ZDTlH93XIN1IqAXdsXwj3TqXTtyNrBo=;
 b=ajFi2yHk6FgzJS+gMiHJMgfAS3VngeJgEMFEPG/XQLmlW0Sou+i0PKtwOERErUs1o8DMyA7NjmIO6UZerMBLlOuuCnMQFIkFJE1NkJMQvWo0oaShgl0mtLxJZ7VbvnnclZ04Gd2bUY12dXOlCXcddqsZ01pLAH6CJdGYUcOzebYEbXxqlCf4StD8pUaBqubzeNgtLbgtdZdwxmTbW82Jp6X8K5Fy0hEySoH0hH4bP3cv1iYDz2G8nW+000rOswx+4WLD485/Z8xPkN77FhVRXrTcFs+19ydAOBfrNIi5VoID90nWyi+6ABfBrhLNomq2zPLW6+LTkKgO7OdYSqidqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Fri, 21 Nov
 2025 18:44:53 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 18:44:53 +0000
Date: Fri, 21 Nov 2025 14:44:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID enable
Message-ID: <20251121184452.GG153257@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-34-skolothumtho@nvidia.com>
 <aR+RngqP3HTLZIlH@Asurada-Nvidia>
 <CH3PR12MB75485354E16E462D66567416ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aSCmeoFtzRBEGE8I@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSCmeoFtzRBEGE8I@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:208:d4::33) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b658e47-b325-4d70-4564-08de292e0eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YWcw21kQQfWzCb1b34TkB2zhMmAAsuVjyEt2QPm96cCic29fzgVRaPeIziWr?=
 =?us-ascii?Q?Jgq4O4+ECd0tYz9HbGvzyAvjXMIthu2ubNvyuXx0JOEbT1XdDWm2y4v7LXj+?=
 =?us-ascii?Q?Sy4o5FJzNEbiHKAZ3nyJ0v0udcp02lLKrcvHXxoCSxKHTuOj3dedj++WkdOl?=
 =?us-ascii?Q?4nnXzQPON75EydJYhze7SuMx/vFxLoa8w0eIL4v6NM26AOho0C6San5GVohL?=
 =?us-ascii?Q?1kBXCtAHDT5OWCSz9zTXA+GfBaqo2b8NfAQg3E+Vs3OjhzdrYcI2aKMjDuct?=
 =?us-ascii?Q?A9zeXCUHV5Lo+ch7DfFDumVzwv/4V52M0PBac6nswKeQD8Aq/RSZbr2f1hr5?=
 =?us-ascii?Q?ilPUkYezrA1c4pMGpuzV4+C6AdbfI/qqxXvupbkvHaUl3rDPFT+Z0IO9CQNQ?=
 =?us-ascii?Q?IGCNSCVMg3Ko3K1kovPfZvdox+rgCGO8BsMPK8PjpfFJWQ8CE9fqu/XXPD96?=
 =?us-ascii?Q?Ezz9z3OdpRDpmqIkbmrJlid6bCHzGKZVERRuDDW4JjT3z0NE/XkKUEJfY9yc?=
 =?us-ascii?Q?kJ3a+j7Q6kZ+DHAgQgAfyLeYwEumyOH9wH9d5WKLC+AFQFtb5l57JBzae8Qd?=
 =?us-ascii?Q?82DpmZ79yyvlrQOwgH09Wi65U1cmnnsr3fggSH9TYYXgCwnCl0OLqe9baqxT?=
 =?us-ascii?Q?9zoMlsE4YJFeluhfNbQobI4L7fXboxGf3h2/4MhG8ytA3Krj+8VUbm3NpJWi?=
 =?us-ascii?Q?T6+F8rVZKpB6hULOtWUrrnGmevz4DYnV7QxSGNurDY9X2Z4dat4WsesJV4zs?=
 =?us-ascii?Q?jxdlNviWfhzRWqVpyEFJrj4wiBxblW711PLbvrGbf//7Wgr/vfe8GmQLLESs?=
 =?us-ascii?Q?8b5r8mK0QihyZd5p90nOFvj5koqlhz8GHtJQd8S9OCsm8GI+9637Hn/KcsYa?=
 =?us-ascii?Q?/zc1GRs6b29zrAiLrNsjYQmljbHJGOE1ccWFypNcYO1NeZKnGJE5CkHUXK5S?=
 =?us-ascii?Q?Ok2SW3XA6B8vSuwuGxg6UWYr/Zuqr1PFcccBc3h3F+UltlX8uF/s+et59YcW?=
 =?us-ascii?Q?35VwvLTEAmBnIuB6GE/sZC9h5A8AQ3USVwG6/LWI3JRd2HlWM69D79QykUAq?=
 =?us-ascii?Q?Xkz8eFzMMlCfw4BW3mcTvS0Km0J/062i/Q5jUgs2/hLPEwWS7jYC3ws1rIgl?=
 =?us-ascii?Q?6gNUSd1dJTyCi/E/txlWe4lENtFccrnuqKMBpR4r9+iO0uD5PPdJNyA7isbx?=
 =?us-ascii?Q?EA/FPUmmBthy+3IG2ZEjOw50ydXCPGgtavB998GNAluXLCYx1iFl0ITrawJO?=
 =?us-ascii?Q?40onY2AFjGQZ8WBButn+qf7eGVQG59CQ7MYzE3Sr9muK+HgquvwmxVSFgTyf?=
 =?us-ascii?Q?Ch9yE0XvTt63vAyB4WtH0IhZH5gMVL7N1+AeEVFxx6d0WiSluLyjrCg+nsK9?=
 =?us-ascii?Q?ugJqiDMyNzhSAAGWadHsz6TkDEXeyyOkcR0R28KvJnxOmP9BLKEFlbXPbjvB?=
 =?us-ascii?Q?+B4vq3vbhI624NH5rXrHuoEgnnlBd6KV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yeIw13VBHjUPmY58/C/zoZZG2HrAhS0w0ANlSD6raSlN4JUMQC773l3c/c1X?=
 =?us-ascii?Q?YX8z4zSRo5rhQ+0G8J30pLWaA5y/KbJheaICJl4FrwC6/TeFsI0Tl/WRfOGT?=
 =?us-ascii?Q?BXf00HYtCNSXxfFzbKvhjBfAWWF0ROZRAU5Qp2skQEuglt//R3ML9JfHoZOf?=
 =?us-ascii?Q?O2h1mHdaQJnJLANhivqBqCRhso5IbqCnLKfB613mBkM9lh/cVQ1e8wo3majM?=
 =?us-ascii?Q?nKTcWcJDJAQ39NmI4d8WIbo4rVwtjiXDl5fi7RjmUBUTFoxaXvcEKZ8dT/Sv?=
 =?us-ascii?Q?995JfIa8luSOQsThsE6LZhSGWgPW1rHN7yVjX29+QLfJuExgdmGP5oE342b2?=
 =?us-ascii?Q?Jp4pg6LXEwcwaSFNRd4UtMmoGfrOm9Xh62xmdtYXoyCHYntE+KzsqiPc0Eob?=
 =?us-ascii?Q?H7jg1fKFZiQo0wZY9wsf4spW0Q2SXIXvU5Z5O05R618x1PuWUq+aafjSHuGu?=
 =?us-ascii?Q?HyH8iNdeEAbjtS5lrr7dYZunD746s3jjh+/MEFRLJo2DMr0OamA3iyVNZi/m?=
 =?us-ascii?Q?mCZgYcBJmi6TGwN39hq/jRgtPgdjIHNAw2Yhv442jEtkafTYilsdX7+IDcCY?=
 =?us-ascii?Q?DdWZqt/MStkkV13TOjXQL61BAtGiyFgnL01S+b8gZe6XGJIL7qogmRKyWW8z?=
 =?us-ascii?Q?6u9WfUQ/aG9i5oPuZJdqO+lABsF5L4P7RUsD1mVytsNjP/Qowktns0Cyc2Td?=
 =?us-ascii?Q?VQXDvpol3FmhCZ26i2ulfiIRmXaRUQ5OjinD+rwAjBaRv2miMUlkGKAGFv88?=
 =?us-ascii?Q?fEGykNRr4O2W0Q7CYcxfNkIMYl3m8GYUdebDTcisOoESXbWXZZ1ZLf+cfIjB?=
 =?us-ascii?Q?sEkYif9+ZtwUlMwlNBeT1fa8asVhRHwYv8rCb9iGoy46Dv+L5Fas7dwfMaQw?=
 =?us-ascii?Q?TJ7AG07UeoZRM2jvlq0mWXXEUrYBr5IdLkLmgh/L+Xm3PZW/OVx9f60Hl6/q?=
 =?us-ascii?Q?xEk7A6cd3sLh6DiV5XfaKaiE41E2tY8OqaEKMx1Eq3nymBL6fOgVudomYK9W?=
 =?us-ascii?Q?3YZ8hqyz8QDed2Lxk67IDdStTt4NPw3/suhnLRuxesMdME53vrxHLIilX78d?=
 =?us-ascii?Q?K9S5IL6P0zmQwWb0rM1le0uCdtJCqlv4DiJ5KiI4/su5dUaDMHu7zGpQwfQP?=
 =?us-ascii?Q?yK99YSaGvhMpXdBO1Ycjhr62USIdovOQtZZZVErKSDWGvXWuIFNyNSKroMq/?=
 =?us-ascii?Q?IUt4pmvwZJDxD89nMZfW5j03R/GKxVcYzmkcqgYUoXAEY5Pqr955glJ7/BQx?=
 =?us-ascii?Q?gKMfzPXaM9QFXZEmXg6alhHfduo366gaAz5NynsUypqAltR57kK5SIW3Y/AH?=
 =?us-ascii?Q?LxW2hdjVEIJVF8uKs9gyieaJ+XJumzJ0RIR1MGhtxAV+keQo6HTwLNZyFfBX?=
 =?us-ascii?Q?JLVQ3TnTXIAHdzbe+Lp5opxx0FVaG603p16nJVvJJl7e1Z12R9zRBaEmdrXw?=
 =?us-ascii?Q?78NaOP4O85FgAOqmv0M+/UT+oMcuCyP8lhpuqrH8j+7DdtNDaUFiKJVDWwdn?=
 =?us-ascii?Q?me5ZVtVQ8vPXjd/1B/phQByF+5f2mHPM+I6DiYftexBWgH5xlPpi7g64Ljhs?=
 =?us-ascii?Q?Zf8hPd8LzfJSGiAgHDk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b658e47-b325-4d70-4564-08de292e0eeb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 18:44:53.0940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GG/EFSj+gvmGagUH/jLV+jKmPVKtxA7GIo0pcUeM1/IX5rpysbw3+PCEIByzNcrQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
Received-SPF: permerror client-ip=40.107.200.41; envelope-from=jgg@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

On Fri, Nov 21, 2025 at 09:50:50AM -0800, Nicolin Chen wrote:
> On Fri, Nov 21, 2025 at 02:22:21AM -0800, Shameer Kolothum wrote:
> > > > @@ -2084,6 +2090,7 @@ static const Property smmuv3_properties[] = {
> > > >      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> > > >      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> > > >      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> > > > +    DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
> > > >  };
> > > 
> > > Instead of doing a boolean "pasid", perhaps ssidsize and sidsize
> > > should be configurable. Then, user can follow the not-compatible
> > > print to set correct SSIDSIZE and SIDSIZE.
> > 
> > Do we really need that? Currently both are set to 16 which means 64K
> > values are supported. I think we can make it configurable when any
> > usecase  with >64K requirement comes up.
> 
> For upper boundary, we have SoCs with SSIDSIZE=0x14 i.e. 20. I
> am not sure how user space would use this range, but I feel it
> is better not to cap it. And SIDSIZE=16 is probably way enough
> given that QEMU only has one PCI Bus domain.

Yeah, it should be ssize not pasid.

The use case of these values is exactly defining a SMMU instance type
so that it can migration between different physical HW. So long as
physical can implement the instance type.

Thus you broadly want to make the iidrs configurable in the exact
spec language of the iidrs, IMHO.

Jason

