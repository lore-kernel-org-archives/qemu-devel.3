Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F314C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 18:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZwmJ-0006fT-F7; Mon, 20 Jan 2025 13:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1tZwll-0006FX-JV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:45:13 -0500
Received: from mail-dm3nam02on2077.outbound.protection.outlook.com
 ([40.107.95.77] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1tZwli-00081Z-5B
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:45:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpdfvyH+gt8OPyS2GfqCsQ92EQ7QBXhxJ9rGsTKttGspoA7Pkr3PY5M8i15yHhuZjYp0+cVfANnyUQ4pjOTRExnCzabqy9T+zOpBcbUZEXocfs6ANbiTYotqPFd4XPGXoCf4BDcgdU5njBtgPCX8YeW7BoEThxYz1Dcc9kNhlF26ZngoxmhtHVyxTEpuoQ7Jnc+ORX1egrWw7zqXwzcoXWIFxNncI71+49uykbIgYKmZyX7ls+OdlgOYKodcHaRR0lKe7whF6NGCIwpPEZHEIi8zqdCyTW16AeN1z+ghMKIcEMs/Hxv81RXem9XoQ+dsInDLrXGyvul36CeoDy6F+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFWPLi1DPHCco1XGQrcOs5w6kyf+g5Nx47uKOwn+gOA=;
 b=KDu4lFOfY5YhPae5CiLq2C1J0cI6In/nje4m/rtPnA4k/+ry8jVVQJqn1dDuI1vxxkISXOptv2vopBxF/mQHRuz5f5hl9uT/UwxHDSDEO60bh2BoVovjsu/HIFzEV6y7Tch/Yq5p2J7KfRPkSOA/Olioswc5lwHz7igSZGI0muyA9SZnWA+duSTQn8CE96OpYAt/4iUITFgQexT+QxReIqe7KEL4xzLAXQjtH37ckRAiyHINLH5Z9mt6z4qPztyeEuTOTR5FRgTSCKIQCTQLnnu5q2paYNwjMMAwNOTobyhHDPN+DXINMWk0e9wPgduRerSdvpyomZJkjFm8/tAJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFWPLi1DPHCco1XGQrcOs5w6kyf+g5Nx47uKOwn+gOA=;
 b=Or2zPGnK7+u+6BHMtTvMIIKkt+EstuIrp0FWjgBQtKwDO/Pehb5BjNZFrXMmyf7OaSWfXxm0sStGbExNR8ee9zobZSRFnyNkeDQs1kgE1ZNJkwM44uAgen89RumwQ+EXo+xlQQLqA5ml+bz+WIAwMFka+j+ukoNLdl1VduZXN/VU2ef4IZxTqgFHLKbUyh/v6w0ojQkTwogGcPMGZDbKdYAX+dH5aIJ92OnDyYlHIGf8eEC/hkhTtdQnGRDphPXV6cTay4sZW+Lytb2Y7Tmtre+wImmdZN03ZQXl28gREU+t2oRbCJlp7MbK9vQVXLUprlyO76xTGhrb2gFLyPP34A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 18:39:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Mon, 20 Jan 2025
 18:39:56 +0000
Date: Mon, 20 Jan 2025 14:39:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 0/7] Enable shared device assignment
Message-ID: <20250120183954.GR5556@nvidia.com>
References: <57a3869d-f3d1-4125-aaa5-e529fb659421@intel.com>
 <008bfbf2-3ea4-4e6c-ad0d-91655cdfc4e8@amd.com>
 <1361f0b4-ddf8-4a83-ba21-b68321d921da@intel.com>
 <c318c89b-967d-456e-ade1-3a8cacb21bd7@redhat.com>
 <20250110132021.GE5556@nvidia.com>
 <17db435a-8eca-4132-8481-34a6b0e986cb@redhat.com>
 <20250110141401.GG5556@nvidia.com>
 <9d925eaa-ba32-41f4-8845-448d26cef4c7@amd.com>
 <20250115124933.GL5556@nvidia.com>
 <cc3428b1-22b7-432a-9c74-12b7e36b6cc6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3428b1-22b7-432a-9c74-12b7e36b6cc6@redhat.com>
X-ClientProxiedBy: BN0PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:408:e9::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 952eb97c-5a6e-4eb6-5d1a-08dd3981d5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZfiJCckAq1csTjd4g8zMYwmjNPLOpyr4u0MS4smPi4M4cUoPouNnxgs53vh2?=
 =?us-ascii?Q?LFtJr8JYRxQyCp4P+yij3BQBDdZdpp4byrXa9J/4DvI2UBR85ebAy2xSHBAd?=
 =?us-ascii?Q?4qOPRmoVOnTbX65Ix/zlBfxdPRc2Mk8y1xqCAMl+Hb8sCLFxhvEYYGtZMCvi?=
 =?us-ascii?Q?QS8YBCNwn1aCsTbJ3/JHYVpCHjQISKMX3DjB3anXZMb5RgY9LavDk1iARFOd?=
 =?us-ascii?Q?IXA+5ueXiDNJvUs9vAbjJYYHKEnat1FasApDP8m1aADFbgwYvYreubPZF+7V?=
 =?us-ascii?Q?6GwUaFykf5IUaOE9/DwZ5iUMPC9LQcKGaAJfU0au1cXvJWh3MU2yHVbR15L+?=
 =?us-ascii?Q?5juCCWTQNYXX4CaIZqwZdo5cEa1FizemimxTqpz61ZTqWTyDvFtwvUJrQdls?=
 =?us-ascii?Q?iaTrzQzLIowj73vIspcv0VzJUMKWCsgdVZfL9uMUII+aXjtDxvCZ0CKHY7oB?=
 =?us-ascii?Q?tePD1aFLuHso36Y9H3P2iEDuowoULo5RZJHZSwjSgZN6rtVzylYReqMSjNxh?=
 =?us-ascii?Q?juj6c7Scien0GFtgEZyjZ73tVgDlZF37nkiESBN+kdXK6k8/Yk/7/qD8mGqQ?=
 =?us-ascii?Q?rIwD3Bm0nwFzzlLTid3xrWVSIbgRnrAvmQ+RWvlzV5ri/oy9PqUwhjn1EcbP?=
 =?us-ascii?Q?FMbjBQB5TPLrCft1dBllFuSc01nEptII7HWkZUtnXQ0XbBk0O1jwffDSGNua?=
 =?us-ascii?Q?w1rpZTY5rh1UoKLPBWB0NSUdxtFzdlBFdOzPCMM6tFF5x8qOjPMwKeQrsVII?=
 =?us-ascii?Q?B/2+ijDcazAPYf9q/0szbtPfqUUIvb/MoXgAD6PKhLpHYUjKPYvO9RjA2BOG?=
 =?us-ascii?Q?KrzK3HUmuWNSXqZbPKalz8vABcRZb3wpHOICO8VqwMAr36Z5ZLwMoyZp7l2D?=
 =?us-ascii?Q?XvXGKHLx2q6Chvz+SD7AtO5d1m58vVq7AfWdXuqggtsZNUzalyncaq1KTgHD?=
 =?us-ascii?Q?aeRmaGO4M2n1VdTVvfIVhFsFFxwaLGb6s10IRLbvL1P0jyZv1wgVb/wfLE6r?=
 =?us-ascii?Q?5CKYsDGjMD9ZEloj8tn7cZNy7g/CwI3xKXwzb7GiH36cvEt8uOFq7sSSboAk?=
 =?us-ascii?Q?p+1PB2AAUOxrkafXH4zgFgI8PCqOaSysX6cJnCO6joub9jMqunqoMalMpPYs?=
 =?us-ascii?Q?wznnhvksWouWnjWt40Y+Fr7tQKs8Jprb0TuYq9YuxgVavnbzQYXOYRM/FwSH?=
 =?us-ascii?Q?bMdC291Aioo6DzF4we4gg9Q7WofZhe/RtQ/Gl7Jio9SzNsqR4R3USWNY+8fs?=
 =?us-ascii?Q?YvS9o8Ug7WB34HsQkmWnHhLrfztvpjioxUqSVin5ibbp6maiPQc21HNC9rXE?=
 =?us-ascii?Q?xaeVccGKK3CJkHFM5NiDnpHJc4iePQlmug2eP7tHvSCheEExLfNN4/1ulMhW?=
 =?us-ascii?Q?NV8tunJ4cbojMwWbrjr1Fo8G1mdE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u6yzZk05RWF+qHoWVI+CgrCOZJH+wYUbP1EluPF8MalTTOw2EKJWRYDn2CBr?=
 =?us-ascii?Q?ntOlrnuoyiMKsgQ3B15gxHZS/A1AMw3Hhv+971GTQj1FC8uSLIiRyMis0Tu4?=
 =?us-ascii?Q?aiU8DUkClR+a2eBMUTprjom03Paao6REjHIM8bAGF+3sChWME5ylDFSxn/PL?=
 =?us-ascii?Q?RmfrS+cNBbmGh2+NErvvbDgQAWZsT+CAm8fPrwgxhnpPGw5XZGA3tVyP7DTZ?=
 =?us-ascii?Q?ZBVq8AnbpVfLk93FnH8/1D5Ifxsxd5pDEWn3WwfQN8GtXkY6QESa4yFR7W4k?=
 =?us-ascii?Q?cuVe2zFRg4oGnKxrFKNwFuGdcUzJm/iVGcL+lqx4z2PWYYsa5Mu5eFo92H7K?=
 =?us-ascii?Q?TSQfAeGZCbTne+DseVF2DzTz8ZtnxLoYA78JdqoXpy5RLqPb2yB/OR32//74?=
 =?us-ascii?Q?ObLdPU5UjBYIMc7w74FapV9FONCVImTthfZ6O9GaJUUYjR1S4oMpLk326l/e?=
 =?us-ascii?Q?Y5iwLKL3Wr/aXSoq4be7xs6oToSmZnoJAl0m5YDD0owZu0TAy1MquvZWRGje?=
 =?us-ascii?Q?MOMX9/6EsusxxNtjCN2qbgYt5wGmgHdXtsj4aRutkB2s2SQ5QahnVlTFZGEb?=
 =?us-ascii?Q?1AsOr9Z5Hs2PyLaGPlZlcw85c49dHQvsnr5e1H8CQdX0PBEJ7UlMmfasjpbS?=
 =?us-ascii?Q?f9HY1M1RsCNvE4FgMDVllL+WoSJstq4rUL9h+KTvc9s+61en893Mx56Qs/nW?=
 =?us-ascii?Q?WJd2Qia2AWOaefV0pyqiABBAdw8EnlQUroE4wz35ljNn3JI191Gv4xxPWr2T?=
 =?us-ascii?Q?ppL9IZOiNzFR9Mo0WqrqUCSlPT1sddFmLr1ec1zJbvKyI/DvCMw1LDqPTPYD?=
 =?us-ascii?Q?JJMEM8pcj6c0ia/AB/Mbjifed4nRqZnvZ9kIRTVH/7QkX8hpaAQGHMeAWN+D?=
 =?us-ascii?Q?dPaRYSO3c0QmsmGhFi3Ild4HUUhwXbSm6V3HgXaJMbq4w/GLAGyHNoI5R08O?=
 =?us-ascii?Q?HDVP8F0xnYm1cohKYc3h/mYNdY3uwAYGNgZb+iLbuzKpfsmXhxLdJYsSaFWs?=
 =?us-ascii?Q?rLzbjKzLwIipUS2GraQajTEhZZ+OTGm3Wyv1hcHTOjSe95i4xFMcng1IIog8?=
 =?us-ascii?Q?+DtqRZONpcSbzDgRst/P183m2B/UmPmsj/amFQMRqIRbAtDxTQ4vR9PfKlzk?=
 =?us-ascii?Q?yr2ImjLJ65XBacW5ttiRdoiAowEqmU+Z0wOMIm3/TKV4tQhx5FZYpi9VxYJu?=
 =?us-ascii?Q?7LZL9FlQnGa5/MOtdZwd2qxriKcu62k45J9prnhAuJ0W6S0fsiKE3m/D9/uU?=
 =?us-ascii?Q?8idorLBKvg43PUkwQPlWIwHMCU3kwkxzbH4CQuclpGq4HRyHipQL9kn/KxDJ?=
 =?us-ascii?Q?8aVIdGJr3G26XXXkQdQKNYKu4c6qNmrvA6naZeHqUrlH5Ek3x1EGqP0PHD5Z?=
 =?us-ascii?Q?gfqUB/utZfjzQIaNW54PcXvQBVrbZ1OAY/BwIFVCrkRY4K4SUcZzCZLLcYjC?=
 =?us-ascii?Q?JpzstSB0NEQ5jRnSdCZj9VG4gRHeAq6s/WTB57utrIke/44v4L5/VEUiLpmq?=
 =?us-ascii?Q?EvIy7kf8bavR/78UaL017FqUVtcGI55hbYM13XlCVIFU63d6IEtIu3KRaQbQ?=
 =?us-ascii?Q?AkUYw4PaOv7fd/qhMwJo/9YaIoK6eY4aNe6Y4T0Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952eb97c-5a6e-4eb6-5d1a-08dd3981d5ff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 18:39:56.1959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlT8rU0LnPaq8oYfbjEOSTEKoO6ggcwKx7/ATR7exM6o8V7/Ag1gmLf63/7NaexP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
Received-SPF: softfail client-ip=40.107.95.77; envelope-from=jgg@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.036, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 20, 2025 at 01:57:36PM +0100, David Hildenbrand wrote:
> > I don't want to overload those APIs, I prefer to see a new API that is
> > just about splitting areas. Splitting is a special operation that can
> > fail depending on driver support.
> 
> So we'd just always perform a split-before-unmap. If split fails, we're in
> trouble, just like we would be when unmap would fail.
> 
> If the split succeeded, the unmap will succeed *and* be atomic.
> 
> That sounds reasonable to me and virtio-mem could benefit from that as well.

Yeah, we just went through removing implicit split on unmap behaviors
from the code in iommu and I think it was a mistake that existed at
all.

Very few places even want/expect to do split. Instead we ended up with
this situation where it was hard to tell who was even using it, if at
all. Turned out nobody used it.

So I'd like the very special behavior marked out in code. If
performance is a concern I'd prefer to see split gain a auto-unmap
option.

Jason

