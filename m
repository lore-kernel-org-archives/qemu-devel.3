Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2412CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 12:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGd0Q-0004vF-Rc; Wed, 05 Nov 2025 07:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGd0J-0004uh-Aa; Wed, 05 Nov 2025 07:52:49 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGd0H-00081w-L4; Wed, 05 Nov 2025 07:52:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaAAzpilOUx/yDsP+aOhC5oIOjmRP0/Bf9kMW1NopbTTIeFIIjpbao0f0OyRAb69G/wo5nmPzsUbNiDWkOOJ/g5fTdNRLxzZk34RbpIwiXFkaSPUb3EhpGamkeIgt90SqLRUkl/QTl0HqcIcaDni486n2NPI3yeOWYdoY7ih6rBFq6r+Nyr+p6z9bO12YiQs59HHS4iq0wEXqf5nYS4pCAJnV+WGfwzYijAmIdqXm1oSGb5ZAGHnCm5vpu6+0jbMywgAXcpiq30u0QYwR1TjOpBk1YCwy+A1pkaRn/sZM7xeKoDSxUVWqGMpBW6uYaLlH1wUHLZZT3ANJzcWuoRJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTwQtFnoUsvcLXdSMcdmm1qXgOF/RlMa6kZFapVgDi4=;
 b=PmWQecAp0jmAoXOHFdMh80DzsZspKxDk5GIYGpRfJ8L3AREH5mUPa1g2BTzZLhb3oC2fvEvnOshPZMzv/jNs+wu9LMAt7rsGHpq6C5lXAeY/abQi8pYCivd60E4+vFSD5TQ9GHp0b9GX8dOU41xezl30Lzy0kFZ98B2tNsbIIbXBMNRcGdeen5noZUiBwcOaElx53RfOzdbcm4knusPB/9YQyYr6YH1v9fy6KwD9QEmshcsw5uZzqw42Piqo6UKwR3/hIRtkFY9E8PZjHW9uPgAPXh464jei879KjI7HzMymOMC3jysHOD1fj0BUeFT3DXf0JwTKKg82wo8IJ+xILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTwQtFnoUsvcLXdSMcdmm1qXgOF/RlMa6kZFapVgDi4=;
 b=BXtNxsQmeQeacs/YszLosjAaQWbcQAF6j45gyzmRaqr28gT9aiSbH3jUxDQCwHZg02wtfOw5dufJA7C7Rv18ZUmppRJmREPIXpwPeWhMY5NszO94I4TWoFR0qcdeNQny2aD/uT56LnJ35eBWvDRdXHiQ4wtmeLavp8axe0G7bVbGpgfgqI54exjsqnUvfZa5QD0x5/ucgfezxyODscbjK9rsZHOmquC8XjXYvWjHGtqwhq/JbBW6ws/AYYFnRN+f+xCKbpaKMdtHJNMxR4j1MHggHRoZvJxHFKjXIk54U0cCLp5JSxKdXWPWjqDVwsXmk4TULorByR4Gab7H8deu8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 12:52:39 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 12:52:39 +0000
Date: Wed, 5 Nov 2025 08:52:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <20251105125238.GQ1537560@nvidia.com>
References: <20251104153535.GH1537560@nvidia.com>
 <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
 <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
 <20251104180928.GK1537560@nvidia.com>
 <aQpJi37XslsYV+Ez@Asurada-Nvidia>
 <20251104185651.GL1537560@nvidia.com>
 <aQpUpv3Rde0PCCIv@Asurada-Nvidia>
 <20251104193521.GM1537560@nvidia.com>
 <CH3PR12MB75487B28A865028A45757447ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75487B28A865028A45757447ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:208:15e::44) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 1869affc-20ec-4432-e2ed-08de1c6a33c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TuLcq5B59Z4fChw8EgAuEvsc180kWMtJ4sV/AthzoCwI3DHcK3iF0wuXhMaB?=
 =?us-ascii?Q?AZaf90u9DFP2FlsNgNKFdsTYF6gQ1L0a6sctlbhosO70yMNpuu98wZOEbMWo?=
 =?us-ascii?Q?/MqvLmwjWvRxWH8bvG9TPnAqNPIiMdZcq9nZ1DwPcgFaKS9+F/pNfi9wPfUa?=
 =?us-ascii?Q?0BTIStctB9mfW2GplgL+nGUcu1ZMTFViZ0q7Djwa480CACjm9iabzsgsBb+p?=
 =?us-ascii?Q?qbFSbg1dH3g1/xacxGS6MohKK6Bcn4LXO1+s0HaBT0ZazV3vXu5JiMkZsk23?=
 =?us-ascii?Q?PTTfxJXtu0vDzMqVw+htM96fl4ZDGQXyKQ0wyejv1b7cOMeBNd35FpY+9YZW?=
 =?us-ascii?Q?QDyKO1UTfAebfVmEArflfJU0ZvGUVz/AOaGPOrvoDWQp0IpS7A1gJW26MWZF?=
 =?us-ascii?Q?f/Ksrg1oi2AN3wJXp6DsVnsm2gCRFZH3PDVJANZ+3LM+iOjV0p91yw4xZcIF?=
 =?us-ascii?Q?ckR97RsGoyYPpadft2Id9lPLfDiz0XS827HpkUmwvNhuZYyVFF5yrHx9ZiCG?=
 =?us-ascii?Q?wn/u6MPVMRQoSkvtlEpSrPjhB6Z+SYAdwARwGx9b9ud/9vwFcIuck0NiV+Yn?=
 =?us-ascii?Q?AwmzR8AF2NgWcPRDzIT4DsPD2G1Ta8y5srKS0X3fhE33yb/vtKQwcuqECtRi?=
 =?us-ascii?Q?y4Nsf0sT6nDPu6AK6tcM9NVF28K9xt418nqJkYMyjRCEGFvlGWAMAp3/2e3i?=
 =?us-ascii?Q?Sedpep3vvqtEA+F+Q0piT5LDmqlxX9VFKynI2BqiGCdOYs6jyeIxsYBQ8YAr?=
 =?us-ascii?Q?tcHMMR77+BKy69d0tZgi2R9tUqaFv0/TWqrPnCE7LKdXKp/2dUekcf8NitHh?=
 =?us-ascii?Q?9woIG7fxThk+hwLsIgkU/wCgQzLXDgB2iBbmz176j2IrXGClsggkRh6+cgCk?=
 =?us-ascii?Q?Cml9x7NRUVRB3H3MfxehvU+3g+7msfQl+oyftEomaRmzEOQxFWT1EYr9JFni?=
 =?us-ascii?Q?qb3SJHnsIjXLoSc6TNbiuK8dgnye7w71iY01ImFdN0Poe5Js8BxArnos4j1A?=
 =?us-ascii?Q?2QUKcGlwikQNEaQVXO7KX8Cvmwme0Fpd84geKLJ7X8lgqKUwgG0ojD/HCP5z?=
 =?us-ascii?Q?fWumvp9cqwtokUw24v58D7HiKuGCqgDzFGm28hzdNjD0/7RBGqxX6j2ZvQ1d?=
 =?us-ascii?Q?xQDWln9NQcIbuPyyHME7KgkBF7D0ugIZQyh8OtmsuNPg/g7nXb2kxlDwFsEr?=
 =?us-ascii?Q?ESoCUjoaArapsaauwNDgRS9hkl9bgOKTXx1piAIzEv6dV0RGF5473hx/NQdp?=
 =?us-ascii?Q?z8oc36SqMGI8JIpD8yFe+19TDEqgSY2RruidvVMzKrBtTwOzEkNMsQPQyQzR?=
 =?us-ascii?Q?596GIZifC5GvzVQHyS926cSKChf+ozgtYdHuUKXYLUSMCu6874xAhshqwJMP?=
 =?us-ascii?Q?zVvsV0USvL/aF0GWGBmOSbSgy6t1fFjYzZox9niLxQ66vhE8jVAc9qhiwA8Q?=
 =?us-ascii?Q?L8shAj+AGFO8xt+cOtsrH9fIIid2hW3h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gWRL1z3CoM68EiYMIL63+RIZG6JHqvxDMnFX7BJ7TjaIFQ5H+S1/q03Pr3ug?=
 =?us-ascii?Q?RTnERgBQyFAM/cVqEsxH9bbqAEguVZiQ3nueukdBj/yULcnFydJIDzKt46Q7?=
 =?us-ascii?Q?1V92+xQIFWu+vBRidLYvO1O2D6Gls5UYVTXjJVhpQZNqpWSqHruuyMHOmiZK?=
 =?us-ascii?Q?CT8e1SKnv2HI9LyEywSy/dD3rJGVlZ6UubzhX4k0/q2f179CNk/bFSZBEv9F?=
 =?us-ascii?Q?LaZYljUmB1BpBucasOdZdh8J/F4Jngm0/OiVNrDhK7B/UQgr+Pxa9SClFoBe?=
 =?us-ascii?Q?p9852enB/Oz6hkMNM75NSYFify+iQKGpQtoIBJhbsLd71Cnd6Cpsr6iUxSs5?=
 =?us-ascii?Q?hcG5duMLiFIugI3RIqybbDq/sRBTDWU62115vqEXZvRKK7QNoYZ/iCy5y5HC?=
 =?us-ascii?Q?CMDzOYjZAZBBDMzxeRxysMhB+SmQtM4ZqZn6eHD8+7j8BCakQFEs0ojF6lrF?=
 =?us-ascii?Q?OKVuuHVn9S4kYZWa33NcMsQ1lf3Wi76ce9XbO5dWesFUcx1jAMlVKu4nQrmi?=
 =?us-ascii?Q?Nxaj98SvORSHp0RJuWCLlU2Smq99QQB3FJK3SJA6/Yrk+zI53wubXXZ1fOru?=
 =?us-ascii?Q?5stuuiGpVP6OsYy3QuFEWXwtU7+LqXMK7uX3EB8HAbqiSm1N22QR8fV668bS?=
 =?us-ascii?Q?pUIRyOJ/wsZALxFrpAWfeh9JEWgZ7hWlE2D5R1YhRPzsztUMQCVheE0Pyg1p?=
 =?us-ascii?Q?+QQ6n/Akg05LKIkyPwavb2sz8vlJAa+cA6tatXnU2TmiWbGgBo3fj2PetBch?=
 =?us-ascii?Q?NDGhTccoyxLQIe/jYu7B639Tj4s6bqcmjtTB8Ke0CYkIJCuW2Phr0md6PE1X?=
 =?us-ascii?Q?ouQmXxChZla02s//OL93fiGzXxbB9CgxnlmGzBtcv41aP/7kdBHYiCV/s+Oy?=
 =?us-ascii?Q?mGk9SHXEZSyD6jUpH5U5VWnWVJ3+zJl52BZvHXpvA3KpMsIhx3u2yis5xPpi?=
 =?us-ascii?Q?iHKPO2VrXilIC30oooipG/T+AT+4RNnW9gExxlIefcg41nXajAsVruc1SWRQ?=
 =?us-ascii?Q?Nq3TnjtTdsQlCTq/tasdTN7SmuDBqmNtlsg7dpRwSQzPHvgDcYx1XgI+hUcz?=
 =?us-ascii?Q?Lu2ZY1GiHb5bQ0WO6xy/Dp+Yej81YotWfY0mb/SGgPsyRCSW78xtS0SQAhCM?=
 =?us-ascii?Q?JVxqnxGRmY3srgVucr/Amfyr5in3dAveh1rCxw82B0GKC5SSQKFp6vw5JcfI?=
 =?us-ascii?Q?aOMOBdAnfws4+7YLvEKMEsRb1HROwFx/HqeLYFLoTifvyVc4kmQfDULq3BTr?=
 =?us-ascii?Q?lperVVxxkURfQA4pMXeq1XVnrBw89ZhBShFg+h7zi3f+E41js9xHexfazNlX?=
 =?us-ascii?Q?Y/b6jOE1IyR2yJVC/e4mFXN6Vdf06OUSGILzHaTyYbVXvsehE0/eBVxb4VNI?=
 =?us-ascii?Q?oeHLSNgk+ZNJ97pWofZ1wEGwQ0X6WY2qkhXX8Vu4UJsxdO/tJcgzRDTVoXm/?=
 =?us-ascii?Q?ieq/ynWElvkCqZ6iagN0mZqtqqY8c4gt1jkITiCQCCnVIW+0D/DccekZptJW?=
 =?us-ascii?Q?RDtBbWDmku/+D6kI2Sqacd/UMj8srVMD4NcgAt3pfJ4d/JBaQh18B0f3Pg2Z?=
 =?us-ascii?Q?D1kg+R5nXszgEHbg+p8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1869affc-20ec-4432-e2ed-08de1c6a33c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 12:52:39.5135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 880cm/1CjvigWOtRvBW/XvYfH7diHh0byjClXWSeB/Utx4epwqLyJ6gvdQ9UjAFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=jgg@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Tue, Nov 04, 2025 at 07:46:46PM +0000, Shameer Kolothum wrote:

> If we ignore and don't return the correct doorbell (gPA) here, 
> Qemu will end up invoking KVM_SET_GSI_ROUTING with wrong doorbell
> which sets up the in-kernel vgic irq routing information. And when HW
> raises the IRQ, KVM can't inject it properly.

That cannot be true.

Again, there is no way for qmeu to put something meaningful into the
'struct kvm_irq_routing_msi' address_lo/hi. It cannot walk the page
tables so it just ends up with some random meaningless guest IOVA.

Qemu MUST ignore the vMSI's address information.

So either the kernel ignores address_lo/high

OR qemu should match the vPCI device to its single vGIC and put in the
kernel expected address_lo/high always.

It should never, ever use the value from the guest once nesting is
enabled, and it should never be trying to translate the vMSI through
some S2, or any other, address space.

Translation is OK for non-nesting only.

Jason

