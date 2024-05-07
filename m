Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D932C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JT6-0003mg-ND; Tue, 07 May 2024 07:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1s4JT5-0003mX-Eu
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:58:47 -0400
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2417::600]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1s4JT1-0001Ez-2U
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:58:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=En98SbUArpIj00R6WjBNH5DyDgXtmt4WRrtEjV9eMGoRJZTLzMoUUfxTUKlwBbq0D4cdXZM63c088upV6n1OhnEsSFvEarYgcwKJmPhtbKGfkR5fah4Z+kgDSavQhjW05c4sITTqgMeVCO5uLkXQ9SxhVL8vxXwgmoa16J6o38WXI4YxtQIKLrcoubNTBJvdw6tyffr7hEuJzW3Z5Trg5MYtm8cbGxPgEBJ/hHbfXtEyxYbLWLxbNfL160DvBH7XQvSWkKZVun2A7cGwH/BQjpx9HWeNYCZjcQS2XQbET/czvL+SwNxFe/refrhe3kxRKcDY76N8uUvnfnRWdsl/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM21HAje/+nyIcK8qVmgbU+pnJ0JHrPvp54gcQGc1ic=;
 b=RTx92tgY/sy38xeXXeXCEjeb0qtct3LHvDUZNSMIywkZM1yB4vvXCVFLocxR+badHWV4pyw1jn8vSNyj6zID4LV8pL5BKA6cH0VIYuTAc+Yh2eUEsLqtf6fHiW9GiIJLZZBFiWJCGvBMcdfClvY117gJ8uw/17dvir+Y9LZlrjXiwUcHTjmADmmBc1EtUGTUVQ8OEOVT56YeHu/eqF6nnudf4hJrsUeieYtMG+FUiRit3WavR2GlcrEqJ/NIXLORRnB+kN4ujhBfHzZGSSe/zT5umxLZLAGPL3uc4cyPBLpRmrCV8d3JI5UuO6TrqWs1wymdm6EBtrebu/mafuXRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM21HAje/+nyIcK8qVmgbU+pnJ0JHrPvp54gcQGc1ic=;
 b=nb1FGdxzJmYFL6Nkys90R9y2OErFgeX2GUpXuD7isSfJRqEiThOreSrt7HTvp42wIAOLl2eC8q4QJ2X14Xp5wfTRBNRny/cNTgOsFSHXyaW0Ub072m7ljzj3L7/WPdZ+LeMArDxfm9BBLZgK2IE9hKn3TrJw8nI11FROV5OKiHG7ph5Xw4k0LlGKsd+OUJoPavdGOOyp2lQU8GyWIehFd1KTiNAq55vydajq9Afccn2bWlqAzjjhSkOsgDpNHnQ8yUInVOWx7Z3I0QqtgK7Zryqtq7xrS1WQMLO2wNHTm+j5GacxHpRsAXjwGC2hftrBoW3iwpzUZseEm87u9AGdXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.38; Tue, 7 May
 2024 11:58:37 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 11:58:37 +0000
Date: Tue, 7 May 2024 08:58:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Message-ID: <20240507115836.GL3341011@nvidia.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <c245b234-60d5-4ee6-a947-c7526d58698e@redhat.com>
 <SJ0PR11MB6744A435E58FC69DF37AA148921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240506120541.GG3341011@nvidia.com>
 <SJ0PR11MB6744C6038585F0014429C27292E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB6744C6038585F0014429C27292E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-ClientProxiedBy: DM6PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:5:60::36) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5a5239-c28a-4771-b976-08dc6e8d0790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L0mXUpNx0henw6VCeIJGamZHiLiLP9Cul/4LvJ/1oZOSFiaEDRvWgowkKjTv?=
 =?us-ascii?Q?srGvXbdX8kEFQ9roWnsDFIIdlSPhiI81h4K3USXflt2v+6mHozrsozrPJb6V?=
 =?us-ascii?Q?Q4o7v0+vS1iXWQbGzT2aAMEx275YuX8P+cmlhrLTZrIU3lLBcSwdcHkADl+V?=
 =?us-ascii?Q?Hpo+oKAmFiyoEiC4VvrhS88Pm8T2JtObNGOx63FkhkorSg/hGmxyoZ99mwYo?=
 =?us-ascii?Q?1sUhvJ6e6AcDao5kNLgptE3LB/078lXxOqxE3Pd+yJVn6DXH58URosiEdEzy?=
 =?us-ascii?Q?Lvdxz/XHzap7bHanj+mRDXdXS8Tany0QtseaioqHVrNo0BFPpVUiFdfGnLQe?=
 =?us-ascii?Q?h7uceI3mqweTdGIUPV9DjI6Ni2IpT469TlDkxFoI1AhDyZrTiEttdw4sz5T+?=
 =?us-ascii?Q?Vru2ySi0HyWBYNAnu7pHWtkcasRb8JEpDFwbovFni6uewgpVk8lNn2PY32nE?=
 =?us-ascii?Q?+NR2dCYW0YXd9d7HvYwtOO7wYXcS5qHzgrjyk3yeJax9xUgbrqdMHVnTzAHm?=
 =?us-ascii?Q?SrJm3oLZfB5pqvpOZmJw6dlF/2XOQjWqfbmeXD/awsEjfndM+wHTVxD0dQlT?=
 =?us-ascii?Q?FHHC6SABDHR7G24F8Il7tfyVjDK6DACAZQZKyhXkJi4gQGYplM+eoYBQJo7m?=
 =?us-ascii?Q?FkQW1bdUvfFYYLJry1L6hCodLk/xrZRwGwo92/qheOV5IG4L4c0VGpCOwnC4?=
 =?us-ascii?Q?NPMg4B05nW0tQkQKQQxxkt/XvvezNiQUSQtsswffacZhvj1IccRO80yK7j57?=
 =?us-ascii?Q?cEtF9UoXtmV+zR/7RM591a+5IOHd3Gu/Ea9ky8gdA9Nk717EhOjWV5Pk/KLH?=
 =?us-ascii?Q?4ILhu5WDJmckwE6JsP6S7TbetLuR6ysnY40Q7ivmhn0wfCOV2aIao4Eid/L4?=
 =?us-ascii?Q?GFu+/oswv350JIxCVwyk+yMBd9GdayKZEutY9TLg8ldMgQHHJcgCEX0cDy7e?=
 =?us-ascii?Q?UrzHz47oiIePrS7k/F9klwBHWWUNBQj4hAVTDBC1v/WacuZkSvSYFCfFmAYE?=
 =?us-ascii?Q?y09im+ml6LcWF2YGZQJZ8jqrytk5hjrvAJ2KHlo7aD8oGBf0C6YW+1SpKV4v?=
 =?us-ascii?Q?SzdA/YgsacDzB9m+q6dzYHSUJcecQOuHu3zuW9geJQhwhgNutqyDXlm/e0gp?=
 =?us-ascii?Q?K+MIVD2gNHm3M0DHwziNICCa7AKD1wMdPRR6KyyxtrLDOtPqOJR7qu9R8b8Z?=
 =?us-ascii?Q?s+04AiTlqWxQ35t/QkhEooiJU63Fdcz8JtdOJjusPb3CDc13U9cQPrIHhC2m?=
 =?us-ascii?Q?j66gyGBusL6uQ3AuzBXNRpdIhfGuj28kYZ5jlxXtrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?leWUbxbUQyzThFo8foKL1+GId5Xxu5n3x9A9/g7SBeoLKC2pFeCpPbweCtYv?=
 =?us-ascii?Q?hhDjGoVzXXhwnrMbXp3S/EIUPINONKkn32BNXoApknPlXOEM8tgp8KKsPJjX?=
 =?us-ascii?Q?7wtABo6Yb9VX+VQCUYiKQB78V3Ut/d0i14QJVRlfBY+FfIj2YnWBfJHE2xKi?=
 =?us-ascii?Q?Bu9W6TEY8bwDyCSFUbiAIF78svub+cWMGNlPKGblmV+XTrYy0dBv04G+xluW?=
 =?us-ascii?Q?A35qDOr/wHRAcvD4NQBbJI6euf3xmr974GR98N92xppOh2kk1cUXUi2WgN7D?=
 =?us-ascii?Q?5CICj2y3AFjnEbV13Rkg5oQNTiWupSBZB+L1gTPoBTx9A+alvS+u24mEB9Hc?=
 =?us-ascii?Q?Gji9Iu1xvipyEncZzwqe0+WdQshBd+lY6u3jaQKNdtuzW8kFNlm9E7qZFvv+?=
 =?us-ascii?Q?fnz4tUDkm4FPx3wGxUU+M5nUYd4qlVr+z1+ushLJ8dh0r1hn617teXmkLhgG?=
 =?us-ascii?Q?joaD5BGbumB3p6tIqcosz60S5sDd2EURx/Au92xCOniPFEB0hTmDn8tKHgYB?=
 =?us-ascii?Q?urQ4x3bkCvdBi6zU72QScOx5mYK67yRsJyLuTk9d8gdEp7djczn8YSMfALrf?=
 =?us-ascii?Q?p+T4p1j9i+NIMObhtDR9rpQZIQEVAM01ZIK3pj4ZZa4Z6RYDK62Vy22lbYFb?=
 =?us-ascii?Q?eLWlAUvvgntCT99dgILzrIqS3E24V/9//GL2NacASnSaZUony6JF6/2IR3EC?=
 =?us-ascii?Q?fO5jWtqsi9577iMoCO4AK0DuYrd+x+hEXzZTL1c+iF7gm9JJQpKaMMN3xG/Q?=
 =?us-ascii?Q?FTY45oMgfU5KQPidt9SrALIyh2U7hjk59yY787ok83xcaP4zLuGzSjDXstco?=
 =?us-ascii?Q?r5Oki1xIVS8UQka2i7NyCor1K1VBsT63y8A/4WRlviAMwvgztnSig+HHymEl?=
 =?us-ascii?Q?K9dJqKHM3Op/jb1ozBxlsolqp/YawLGIzzcFeR+mbEyXv8u6qP1GvzscQngV?=
 =?us-ascii?Q?83XoEuKySBxE5Z9okYoni7qk/LCKgWbaJFTcBZIA18ZRWwS6H/ESruTmYgYJ?=
 =?us-ascii?Q?wfuXCeLMEW7wC60V0llEyxuPeYaqx83oGudKI95klNmAkl4h48ptqa7r9ztc?=
 =?us-ascii?Q?rSVBaroVPWN0lpZlu5X/xrNTIWrExf4LO2Vsbme8GywE1Lh8LHQtWjmUujOJ?=
 =?us-ascii?Q?ZgiK0Y7zgF13ufvViFlhhPO8cto5pi4xpPNswz0n3SsF7z+6kJsqX2H39HcF?=
 =?us-ascii?Q?/5krUbea3z/aL7c+dcwU92l53QZtPN7Fc4Vof7a/1NV3lZSGowUf1c71JO7h?=
 =?us-ascii?Q?EMgGyby7DSDQ0pAd+Eamugv4C0xD1Tqms9OOhBPV0/j6DeebQB0+y1DJA1Pn?=
 =?us-ascii?Q?N5hQMS53ZaYtLAXeL43I/pyRK9bQXyKMYkvOP+9YF3/cKGJAk97Zz6AONr+Y?=
 =?us-ascii?Q?RqQhzmJ3lUQUpG+W9jDm95kPFkMZVdxFYXaAQec0vTWzzOoUWuDMc2999uvZ?=
 =?us-ascii?Q?cAsKIbW/nx7ses1QVIzJ3HaTvQHF16R+skL4VOiGNRw+ppgR9cbJPjUMGv21?=
 =?us-ascii?Q?hXHVuHKTDRw05J5bDFDyouEKUi5SwnZ9FwaDZjyAKTub7hbH6ZZ2vtGvi9Vg?=
 =?us-ascii?Q?F2ArS4+uD0MFD1FjFEY1vY/6H8BJJsh6ucUBsnRG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5a5239-c28a-4771-b976-08dc6e8d0790
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 11:58:37.7401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOmSbvYlRnZmDSxLBs5o9Me+Mx3ubjgJi+9TIoStSTCcT5q9iZF9zBMJexB/mHwg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
Received-SPF: softfail client-ip=2a01:111:f403:2417::600;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Tue, May 07, 2024 at 02:24:30AM +0000, Duan, Zhenzhong wrote:
> >On Mon, May 06, 2024 at 02:30:47AM +0000, Duan, Zhenzhong wrote:
> >
> >> I'm not clear how useful multiple iommufd instances support are.
> >> One possible benefit is for security? It may bring a slightly fine-grained
> >> isolation in kernel.
> >
> >No. I don't think there is any usecase, it is only harmful.
> 
> OK, so we need to limit QEMU to only one iommufd instance.

I don't know about limit, but you don't need to do extra stuff to make
it work.

The main issue will be to get all the viommu instances to share the
same iommufd IOAS for the guest physical mapping. Otherwise each
viommu should be largely unware of the others sharing (or not) a
iommufd.

If you can structure things properly it probably doesn't need a hard
limit, it will just work worse.

Jason

