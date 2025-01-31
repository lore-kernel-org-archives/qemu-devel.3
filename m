Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB02C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 14:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdsPW-00071J-E5; Fri, 31 Jan 2025 09:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tdsPT-00070D-W2; Fri, 31 Jan 2025 09:54:20 -0500
Received: from mail-mw2nam04on20627.outbound.protection.outlook.com
 ([2a01:111:f403:240a::627]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tdsPS-0007CP-47; Fri, 31 Jan 2025 09:54:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu+ED13UlzfwUOIERiuDdqkGHitmr4/l78GVgFygbW3j7iQquEwqc0grfTEIFupmftpHEnUcxgQXSpbdKtp+0ylTm7EIOEZm6fhVKPyeX0F3Vc/2cPNieIAG8WETWVlrRmnW7QL9FcUzL/StU25Qt3dMx436JPkxbUupvz1//mr7ZtwTvS2QNu7MuuEZv6vcPshWNDczMyFdGMxXwjIW7nv1kUxIbznNhXNi/PZNPLvWZzEn6UXYJxt0yrJFyrIVcIXhKts1JTiXhrFIu/4/1Wo0yEhSkYtv5PV4Sd4mC9iUOCTCD5RPutwB38+wbvTUaty6hlTKs3jaBO+hFZCreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q9ePAsnaZU1fLyMEqizWl3htt59YlMHXAkcWPq/V+A=;
 b=Zi59jD4iinp9cEREi/PiK2xtQNMQTkcyw3djBZkpGcuvgEbUMt4VFAMxHRgLrKx+YUreBkz0yufoqeo9WPA8MDkz/dDzVBtCffTYEFfEOI/HOE9CzRri44f9q7ynPJsAhOIstmrZUW92UJB4s41urWcBypD7jj9qbFSOLj0pPw3dAGCp1DYKoUPgU/Rzq8wrEyqAG9/IFYV4oioh0KqEqiSBjEN5lG2fgVwtjKw6kLbvPO5eZ0ZLt0WEZXLC/2RrBPVONAkEXhy5rERKUQQWa7nZth8rLhb/Tslyt/XcCIvL7pIDKPj5UpKpBdPpBrgyKhKd7v/YrocjcB888NyLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q9ePAsnaZU1fLyMEqizWl3htt59YlMHXAkcWPq/V+A=;
 b=c5JbpftonBgaAfO/WV7nqv+je4ZQ8R//dtAyhinA2N04473i9hH7IsinJhCE7PF06j3VjS+Z0Y2L1fpb8PqwkgO20dbHd5I8Tie9s/WLHdtp1xGK47hcckLkj80ZjMyVbIpoc6n+yk+MpFpur1gE+++48iPG3PxNrQ0Flw/lIKKlbu6dia2SmouvtAPDJyWYkLQNaAKPVT8QOBoHESfGI5fr5wQC/fV6FCH/xWKHfc5YeUjUdJmNKat2cb3K1iYGgB+DVQVVJky7OIbp4+Yj72gjMLE3zcCci4wCI0WbO0zXK5TGxoMc43beIXugSNbOmRH5hSO038j3QTo+Vfqdgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 31 Jan
 2025 14:54:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 14:54:12 +0000
Date: Fri, 31 Jan 2025 10:54:11 -0400
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
 Nathan Chen <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <20250131145411.GR5556@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com>
 <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <fc91e1a798324390b2a556fae5d40f46@huawei.com>
 <20250131142404.GP5556@nvidia.com>
 <3efcea1171af4b2f81be842f2c55fe51@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3efcea1171af4b2f81be842f2c55fe51@huawei.com>
X-ClientProxiedBy: BN7PR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:408:34::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e061ceb-f7b0-453d-2fc3-08dd42071fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FhnJivCh6JWS5yNlV/032WCI3cV/buy/e7aMGZUzIzcOUE8NK+GqN7lxJRBx?=
 =?us-ascii?Q?9Dt+W7a678XLHA+Z3sX+DsRK5WsvNwwFm6jbc2GglEEfGDDSvXiw+UXn8rSG?=
 =?us-ascii?Q?32emv4/m3ykCSsa2dKV730UmrpL051nEtuFBWIiXnrvMjXpCrru3J/bpuLh8?=
 =?us-ascii?Q?PKwZN5lpiopZVmvq9hsFMZCfz6/6FdraYCl69WZ4mkuYKz1W2qH3ARjDEYnV?=
 =?us-ascii?Q?3Ekb+ORwt4RD9Vq/PXaAsAnFu1iMvoL1KsKOKdu8Uykqx93Zy2qf/JOdPYF5?=
 =?us-ascii?Q?G/uhGhOsOFNxD22OQsSboV3u6Vnd55Sa+30Euu9xv6JYHoDyRhUoqKvDp1F0?=
 =?us-ascii?Q?KYdEm77k9T+TX5zPv5WvgLjcWu3yq6HbfdYXGRo3aZBG6XxPGoHPxqCJkTBk?=
 =?us-ascii?Q?UbgK1JxvbpGjL2beSlSo8Q4iQ/pDH/aAl5J0ba2qfqvIYDCzJMRWa2M9SQ1y?=
 =?us-ascii?Q?nLQsuxzKYELCirvll1GHulDtBg5Zd4QnHgkOT5wqc+MuyMoDjGBHeOhDbtxD?=
 =?us-ascii?Q?usmTU4JuJyth2Srk49v4srEZyG1ekvoSeTzJVbTkt2TxkLVkfpLuBsLoWwzi?=
 =?us-ascii?Q?mZ6CwM8vhhhaqbf1jRu71gqTsT37KB+9QU2fvfjpVBzKuePkIlD8FlPK22U2?=
 =?us-ascii?Q?XYf5lYVmtXrlCw3s4teSzUdiPPuGwJSPs9YHE9Fj4hbRGHnwfF1yGWRckV2R?=
 =?us-ascii?Q?Ykw2XvpLCL1GoXTBZtx7QrcDH3JfmAXOy0rfLxh2/QjiN3C8IvRLT+9TqVsc?=
 =?us-ascii?Q?dc8TX7i1pBajK1S7/X7ygS41WQ8qY+PDOouDYLF7FT9bkzsWnrAtVJ6YlHhX?=
 =?us-ascii?Q?bRKouc5OWlJQlVFP6FWE1CLZdm95DHvpYMwFbnMkUwCakz6sRmA/QiaatC4G?=
 =?us-ascii?Q?WFeZCeaGxU5POD1dLrKE2TArzBQ13TINmLgG0EeXJDj+S43UiENrCLTCWcnd?=
 =?us-ascii?Q?cocbUBpaVjBdR7CnOIyyfEmQLUGjnLOXc6lDtYuPKn5Ejkz9fUjMUs/B/rlT?=
 =?us-ascii?Q?kNlRY1zwwgSTv1GkpkIXmdgWKuu8LkJhSaRbGyUC1hxXs70ImhAIPjJG2aJ7?=
 =?us-ascii?Q?u+f39FNrPhRCMCGi3k06FHoBx2q3R+GAxH6y9ZDROcHgOVkJK7PMWfVvIPOk?=
 =?us-ascii?Q?/8DYHbH2WkAXE/0MizwQ44a/T22kw+vi96rQTyhCJSFVa1FCOmzQJsDYNVof?=
 =?us-ascii?Q?Sad90F1osUC613GPgOyyTN/KAdgpksikG19VDOMHXZgEA9brXnwQY1Qza/XY?=
 =?us-ascii?Q?xipPMLfyzpfUYbP9QXN6f6G5qbIJKcP11czx0D5uZcEV6J/Q8RnAWlsU2mHe?=
 =?us-ascii?Q?3RXLY49p3VoV9dxJW7S1T/OoichYaMjZx0vhny5F1tqayuAf8VBjeZILHWiD?=
 =?us-ascii?Q?Dii8jwwKpv9g3bP5DEOfC86fDULi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ZASN90ixHNbeWyCR1HZZ/pukMmSZtEvjf4FtUPMP4FIYeduK8AIQ0prB2Xy?=
 =?us-ascii?Q?52bxVlpmJempwU2AsXmWabIAonqQrpzatI4Tlyr2CAIxBkQK0Sffw0hbtEkD?=
 =?us-ascii?Q?OjaGVtVt0VDQ7riSQ3wn0wZrslO0weTUpU5YYkR5uO+FNZO/C0gtlOon9mY/?=
 =?us-ascii?Q?xyvPrAqPJ6AIHrwnPYsIpJkHG1GTfKjHYDnTOX+EgCqcmWVTQOgKK+d+x5Wo?=
 =?us-ascii?Q?oRAVkc04QGPR5IN5rI3gpz6R2lvINIZXEapV/ePopLpdYI3MVhT+xNoYmlAp?=
 =?us-ascii?Q?XtQN+L2Yu0FiWZnGITQVZU55Nm1kzwanSLQurBUj1Hv6Mtqi1sDa5eYP0L39?=
 =?us-ascii?Q?jDLfQqPMl3yO+lvcQ5E/6jNIshYGqmM7AVd4OU5xH95Y4wpGfVu5S2glSGz0?=
 =?us-ascii?Q?aB7WZ8zi/yr3hwO/FbLXo/91jIi1gM9kVgf1vNVhWU6cHegkIFIwCas1yw1X?=
 =?us-ascii?Q?5gJOtvEG6b/edWNA2enYmjmveC6Qd6blIOAkLv8RmbjcU355jb0Rg7BeUOGq?=
 =?us-ascii?Q?1xAOyF5/+ES87drPYttkoscnG5BbAojlDHub6XgibDj29I7kfwJumeLlF8o/?=
 =?us-ascii?Q?AlAbKEVBkT9GeIsoJvUftvNal8l/tkYc4Q4Vdv3ggCx9mtaZnNCqDbWtNjCK?=
 =?us-ascii?Q?aecOiLyYxGmMWhM4HUGXS2XC7nqB+abSM9e/YOlCiQAP2azu6M4+EYLNzRa3?=
 =?us-ascii?Q?W/r5ttdT5d0tOkVK+nfazbWeuBsBuJ6w1Cejap2RvsRneVsMeLrdwgMocy+j?=
 =?us-ascii?Q?MNHA2Wck9T7EUnlqhZ1LvFDVJXhBbVXf2xNjjzVLZf8eHhx2wcvNXLk2LMsD?=
 =?us-ascii?Q?l4O3aXh8o4YOMe2ojWrv4h2xd5IlcN/DURn6wO5NpOjPpGYIsby+7ZzCNFDB?=
 =?us-ascii?Q?gKJnh0dNRd+MOkeu9Brk0YN5W0x2f2IirjpJl3/K2J6/HGz0nxVgW+9aBsx/?=
 =?us-ascii?Q?+XT8tk7SnkTw5+OlFlEPIqS90Nqx87NbNGYG5Oi8n3cl9Mckn2ocOFFj3Y2u?=
 =?us-ascii?Q?ax5CXRhujyxC3wH/iuN17d6klk1uw/d7yZUNGE2jgaOEOaySABTXexq3xvJJ?=
 =?us-ascii?Q?NnbsEru9OSNUercX4Xcw9pMcAx3xsEu3O/jgRjl9YgVo1TXTLqaluOJ98fCd?=
 =?us-ascii?Q?OoObAEv1ZbZvaOUNHgW80M7uuuSO1CERWXkUcToer9L75S976V+CtJs94T1F?=
 =?us-ascii?Q?zBjWugsdk/2IDbBqf61VKWNal4yP/lnI0QOQfkaC8CQnzkOnY2fTJK0ufArT?=
 =?us-ascii?Q?ccauEbasSF1yvsdsDViWvjuFOoUe++jj0ID0+Mp3hAighfGJGvjEV8XgPFfI?=
 =?us-ascii?Q?j5gS41VrOpeGft8Cf8HZ2ZOtwEV1ShPKNICxN7ZSVzroh8MqtyZ5aMcPbVoB?=
 =?us-ascii?Q?MntmjDUzWOAhdcmMAkx32hSz4cGJvu1aoxx5P1jXCveAjaQTRmrGPnwZYUM6?=
 =?us-ascii?Q?WmZvvwtUbDeKBCbMx+0bT70CxU3qDhLN96iWWaZ6CACLlpsjUlG7Ls6is7sU?=
 =?us-ascii?Q?jA3J9KrFzELqMlYSNx1IDii1nvAIomu0eawbJbkGBqH9tte921J2n7JGzIE/?=
 =?us-ascii?Q?GumX1VFRVGc7g/ELGESxuX2xQWcdnd2EsE2D/Grf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e061ceb-f7b0-453d-2fc3-08dd42071fb2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 14:54:12.2165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WOiAV9q0FsC9XDdxR8ZQkcjkgJVtYUc8YCWulMNRqXVV2WWrvUoyrZqPb/SAmY3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
Received-SPF: softfail client-ip=2a01:111:f403:240a::627;
 envelope-from=jgg@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On Fri, Jan 31, 2025 at 02:39:53PM +0000, Shameerali Kolothum Thodi wrote:

> > > And Qemu does some checking to make sure that the device is indeed
> > associated
> > > with the specified phys-smmuv3.  This can be done going through the
> > sysfs path checking
> > > which is what I guess libvirt is currently doing to populate the topology.
> > So basically
> > > Qemu is just replicating that to validate again.
> > 
> > I would prefer that iommufd users not have to go out to sysfs..
> > 
> > > Or another option is extending the IOMMU_GET_HW_INFO IOCTL to
> > return the phys
> > > smmuv3 base address which can avoid going through the sysfs.
> > 
> > It also doesn't seem great to expose a physical address. But we could
> > have an 'iommu instance id' that was a unique small integer?
> 
> Ok. But how the user space can map that to the device?

Why does it need to?

libvirt picks some label for the vsmmu instance, it doesn't matter
what the string is.

qemu validates that all of the vsmmu instances are only linked to PCI
device that have the same iommu ID. This is already happening in the
kernel, it will fail attaches to mismatched instances.

Nothing further is needed?

Jason

