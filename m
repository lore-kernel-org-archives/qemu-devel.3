Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8A5CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMchF-0007Kg-5N; Fri, 21 Nov 2025 20:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMbNy-0003J9-It; Fri, 21 Nov 2025 19:21:54 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMbLv-0001BG-Gc; Fri, 21 Nov 2025 19:21:50 -0500
Received: from DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) by
 LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.11; Sat, 22 Nov 2025 00:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBckMuqXkwN8rXykd6NPvOVvL7B7zz6JROgggZwEqHimFkjoQuCdNGqi6FfVR0Wk590ZW9dTIDqAmswPdZsEJFQi5vq8PuLjo9PYmUmzd32K1gsAuB/bpU+jYYSXQa0JxdxSJxlBpUgQd6/yaqnYHBAr6/YzoVwJztb0cqjlMdCX5o17jrOTgIUCbE8Ar4OBQSm0ExnVykcHwDNw/rfjE8tvf41TZb4c66FEmV54UNwd7o4PnS/UgIE2bPz1M2blfmjhMwgDN2b49gidUj+1W+hnc+0DXSI3VHzGROYibanzx+585gnrJsOr0c2WM1suMmq8QQj8NB+FSBW2cYiHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHF+cqzisYysAUSssyT50eUF5nbSTFl5T9oG5TS+Y/4=;
 b=gMhFHaVZeN4BeOgpdsGsC+iU9oc4hA56dzCF1DIBlI6QsNN0OPnhFIlUGdLQSUxvTn+rtyZMNk3P8UjGEaOuxo/Ng/BU2MMknu5X7RQxb6phhLVGyCrTNCqjV9JfoT2DIhDy40gvb8aZyK0WY786NIzuae7sKWZU6rbJiTS7zR3moAKn1H0MRtWQcAHWAJKqrjbJ3sh5K3G8iZtzj+is2e6uuGesobKbsujJhIl8X9TaY7X7iVnKjWJ7ytc5oKtAwolyyExAu0OmfIi0FFhSP+BuIGD56Nd3BbOFtb5vhnmWu35hih4boKiGumHU02z1aApKX65bifrHO/XgeYIOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHF+cqzisYysAUSssyT50eUF5nbSTFl5T9oG5TS+Y/4=;
 b=AR5AzNxNJY+OpNz58eFGARyXRjGFB5ODu23BYsjoPG0Je/VYeZMtzoPAZoPB2MzABWdiLRSIQ46wlYgFOQbw+yOaGswq6JaBKPwTb0sH3Uyx8jIdeubSiCicRNiAtg64IEqHbayy8Uhx9v4PeSkNt2NEYqiTVeX3BH5ZZijBkHYybVYuiYk5zOOA5Cnsnilz7tut+KH60+s6V2cgXms1YVhuYaHjKrKFeHm5kCJMihN9+0tqlQm42eZAWESMkeeODzTS+rgrsFMc/5uGi1Huqq0f8BNufQNROyL4oLA24TVFzAqk9d//kMgSuu2JnUahki/e4pNrKdJKnVDWEW4kNw==
Received: from MN2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:208:23c::31)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 17:51:18 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::a9) by MN2PR18CA0026.outlook.office365.com
 (2603:10b6:208:23c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Fri,
 21 Nov 2025 17:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 17:51:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 09:50:53 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 09:50:52 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 21 Nov 2025 09:50:51 -0800
Date: Fri, 21 Nov 2025 09:50:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID enable
Message-ID: <aSCmeoFtzRBEGE8I@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-34-skolothumtho@nvidia.com>
 <aR+RngqP3HTLZIlH@Asurada-Nvidia>
 <CH3PR12MB75485354E16E462D66567416ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75485354E16E462D66567416ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DS7PR12MB8370:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5ad4c8-444c-4f51-dfc5-08de2926926e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GviM0fMWsR9b176cR4cFH/GA6PlTl8BJRbVvC6YzFPzMU/VyEgMdywiaVwAN?=
 =?us-ascii?Q?KnxhBmA6w8lNiEfceYOaLJHcDTnWM/3WvXjcDCow0UqR0k8GzUZiOlmwktyL?=
 =?us-ascii?Q?iWxPS1B3VFzObYGXiOupOWqjYRYUAliuR1+Bp81zG5pacjMKOQK8XxGc2oOf?=
 =?us-ascii?Q?6amNcsrz6y6143qqRQTmU/uKMtXqMr1sLqpxVKMqSA5dux/DvfUIdJohJmz4?=
 =?us-ascii?Q?YAnPAdHncHoeVe272YSmTMgIwfzKy5ixfEhujmM0giniZlTjVp7GLEICiic+?=
 =?us-ascii?Q?APjoh1hspN57/P5V4R+YdtlrKzA1OWAcXb5NQz4xLpb2ZBfcpG7ZGUEcWbzA?=
 =?us-ascii?Q?qrurETl6KrhkLR9UfQxTiHaOuo9BUiHBlZy1xA3NYO9KP6NwsT5jRinmBNht?=
 =?us-ascii?Q?1ukxYIr1BVYyxiEMka0A8TxinVmZIkCdrB0rhHyI+bTH90fKL56NJQU4wxjQ?=
 =?us-ascii?Q?/tpXogTqTQn0ka2EVGrVlHCVS4bKoFET8XgIQ+vE8ZOJVDKrNqMj6OoGykoc?=
 =?us-ascii?Q?n+UnYJfq6mfAzBqgkNzDlmnfAPnryw1S49nwEf4sl9XFD8gFL06oKOpXo3GO?=
 =?us-ascii?Q?eJzl4esJYWNurBpkVG+EIdEaGiyfpAH5qZvWlH8/397st9g5xgGAg66+M6mo?=
 =?us-ascii?Q?0wfT8WXGw+sYkxAS48VBMuwn1yt3TF3AS0IB1vfemRPOctW+p1sLdWc0JU9e?=
 =?us-ascii?Q?qjPDiU1kKejaPMK7Vqmfi1YMb6rBliPC/3Sh5z8w2kkI8QS4VPcCS+Dgae1b?=
 =?us-ascii?Q?kIGKQW/RiIIMoBrriWE2zyLBUgyR1YhJqQWarZkxgkWmrnGX6lYzaJvPlkWe?=
 =?us-ascii?Q?NZN4VY3ym2i/OX1Z/P4GTZpvfNQZQABcKT10657+DyzPcDSuxzx364Ygqu0d?=
 =?us-ascii?Q?YVe7Cq0D3w1oOPpBFkKo76iO51++5ldD6q4F4pDbHufWwaqqG/AB7CGOyM6v?=
 =?us-ascii?Q?327MBPY8ebGAP4BlL/LQfaQpME73s6t+ML4Pi9whoNm8J+Ih+jr/t9P1xeGu?=
 =?us-ascii?Q?pQzgwJiPlnVmtoOdeSusrShHKn1DlprHQREJLjHsg6qvPUrJtN8vGpY+DsEO?=
 =?us-ascii?Q?uMU45ehYDx082F5ij+jMgO602ZORVGYrQt7j+XhBikESzWYh4TZn0pWkW8bS?=
 =?us-ascii?Q?ZQa63RtPt1gNtUfwPzKISkyK0Eo1xd0mM38zE2kEwmO8ry764ncHBIyz2Rvz?=
 =?us-ascii?Q?3VJ5mqUdOq2dMCcS/4Zy1vsRBI1F7fT7TKZJJNxCRKpcmkJmPtUOQgoCqASL?=
 =?us-ascii?Q?3kDDgSG3chm1bTVQx0wtxR33SXmYVZ8xtAt1D89eXOeMw0XjpXmpvTmMm3e+?=
 =?us-ascii?Q?l3EUMKhdcXf9cOGju+2/Jb99hJtFrThOJraQNZ7A3lYWGCNcQAVrJY5UGjAM?=
 =?us-ascii?Q?clr67R5kq9E+kkcEi7J3YVJ9To57J/zyrUs/X9BVvOZBCIA1AFjnH7ilHskq?=
 =?us-ascii?Q?1JZAbZNwUzjkxXlgGvDbapwgVfW+qVV74XEvGfHPD8KR/bgpW8YOv6Mf8h9j?=
 =?us-ascii?Q?EpHdT6lVFArYsscJsN5WUhL0OE7fBMjMDLah3dQrCjFuqwu9oEVlk0I0mgoe?=
 =?us-ascii?Q?3VuRiL0kwHVtaw8eEmo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 17:51:17.3606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5ad4c8-444c-4f51-dfc5-08de2926926e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
X-OriginatorOrg: Nvidia.com
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=nicolinc@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

On Fri, Nov 21, 2025 at 02:22:21AM -0800, Shameer Kolothum wrote:
> > > @@ -2084,6 +2090,7 @@ static const Property smmuv3_properties[] = {
> > >      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> > >      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> > >      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> > > +    DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
> > >  };
> > 
> > Instead of doing a boolean "pasid", perhaps ssidsize and sidsize
> > should be configurable. Then, user can follow the not-compatible
> > print to set correct SSIDSIZE and SIDSIZE.
> 
> Do we really need that? Currently both are set to 16 which means 64K
> values are supported. I think we can make it configurable when any
> usecase  with >64K requirement comes up.

For upper boundary, we have SoCs with SSIDSIZE=0x14 i.e. 20. I
am not sure how user space would use this range, but I feel it
is better not to cap it. And SIDSIZE=16 is probably way enough
given that QEMU only has one PCI Bus domain.

For lower boundary, SMMUv3 spec defines:
  SSIDSIZE, bits [10:6]
  Max bits of SubstreamID.
  Valid range 0 to 20 inclusive, 0 meaning no substreams are supported.
and
  SIDSIZE, bits [5:0]
  Max bits of StreamID.
  This value is between 0 and 32 inclusive.
  Note: 0 is a legal value. In this case the SMMU supports one stream.

We apply a hard requirement that a host value must >= VM value.
This might not work for hardware that has smaller numbers.

Yes, we may add an SIDSIZE when somebody actually wants it. But
the "bool pasid" would be very useless when we add an SSIDSIZE.

So, I think it's nicer to define "uint32 ssidsize" in the first
place, which also aligns the QEMU parameter with the HW naming.

Nicolin

