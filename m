Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE58C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJfBr-0001r4-PO; Tue, 18 Jun 2024 16:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJfBp-0001og-7J; Tue, 18 Jun 2024 16:12:25 -0400
Received: from mail-mw2nam10on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2412::604]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJfBm-0000b9-Lu; Tue, 18 Jun 2024 16:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWgH1+oDkcaWgg/rlyJWUs+YopAffdUP+JST1gQUtnLyMTubBPaRKrQdHkKex4EEDgCLiL2RCinM4E0zaVFIP1Xh/b3ee7lmuyIxPuVofXYuVzhNjh6J++wjLvagCxVOgxnksJPJruHpv6PxOcyIj0zNeg2PoqbXjPV/SymQ5Xeiih5WEm7IhZEKj7klWAdv94IfcP3l570UFeR2xWy2+r85Bt457b50rqqHOxLaclas5e72dLJzF6nwr0hophO5fmqx8v3752KTxgKQAJTQ0JFbUOFctkRX55TpJ77LfgyhiCtVB3WrfdhM5xE4oRQxkCPxwuitHs/WC9Sl9YIaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0MX1Gf07Sdj9Dc+JOkLHI+KmHwnAek1mOH/kGEkbsk=;
 b=RCsske7bJd1e1XwxS5PS2+edfIAinnslGzmK7TunkBQVTDOzUkH+BOfJP/BCrF07waninK7fDiXCHShx8Gkk0DGWym91nNNn/W4Q4xMU2MGo+9pXmh21yy8IaJLCx8CGSKatbWKE33jiQsimDM5kQ8/lZWl5R5B3O152bbicGbctphkolGKdnSYGVW3GtEwBaJokxkY7xlW/+rE81jYNxQm9WUp8xVwlWexxxNMuxJHpkQaUvC5VvJjf0Li8OsPgPHPGEXzximqKH/0Ywgs6+VLksHOEkVdFtgjHN9d5FSipPcKMk3TFjiwm6DIwaF4gMWIY2Hsj1TQz90pddI57GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0MX1Gf07Sdj9Dc+JOkLHI+KmHwnAek1mOH/kGEkbsk=;
 b=m/LDdSiz8ggnBX0bt4LXkSO6swymJzWwVVCEduEkiLVIO14+LODYsmlFiRSfM2ecD2QoVva6LjRPwSzdOTKwFTTQ2YSHC9FPsi0EkN9nSa/hVuRHIuyAoB989jKxxwge6nRS09cLlZpuezq+mnzR8QA5CkquCs8dOtVY+YdzUNJs5E7YIGR8ccyuEZ5N4ZVDls+iyfYq4niMajTMCrfMMaW7eX+WAKNrZrqAaB+Ymy7slwSQHT7Z/Del2bmcVd1RRXK256oL2el+1H6AJGaBHJvKiXMoRPa+QOsBoFiQ2iPTWQR3B5nuwKE4ERUJyNLIdRsLZqdc2l6QP4aHm2mc8w==
Received: from SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 20:12:15 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::36) by SJ0PR05CA0130.outlook.office365.com
 (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 20:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 20:12:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 13:12:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 18 Jun 2024 13:12:03 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 18 Jun 2024 13:12:03 -0700
Date: Tue, 18 Jun 2024 13:12:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <peter.maydell@linaro.org>, <wangxingang5@huawei.com>,
 <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] hw/arm/virt-acpi-build: Fix IORT id_count
Message-ID: <ZnHqEcdhrmT9OBt7@Asurada-Nvidia>
References: <20240617223945.906996-1-nicolinc@nvidia.com>
 <20240618155630-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618155630-mutt-send-email-mst@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e7f8f5-5f5c-41e0-935e-08dc8fd2f2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nJ6itgIt6Z9Y5pgJAq7kz1YECxdIImMvQpQYm7Al6OrOfup0SBqgMvaX4NGK?=
 =?us-ascii?Q?njEgw9qb+O27jXvV1yRQp2RWzON03W2jjcUOjkEN2SzPpjQZxVgMBFEgFA9+?=
 =?us-ascii?Q?nkHlEmOrHeu7maH5p8rKZZv60rFg8jN3rop0yUm35dpWV/hhucBAJ7ks8hVM?=
 =?us-ascii?Q?y9vpNfpkvlY+HvyAoFrzEyQkHLVEZBWILxPxlyVfuRSHsPm0FV1MI0l7rfRa?=
 =?us-ascii?Q?9Q2Pel42+rtglyRREtZX/ckMXSTtOsWEn25IbjN7pDsQjjCn9AhUDvyXEVJW?=
 =?us-ascii?Q?TDReyfA2fvdBwo3CnvXG5Wiwe15T9I/j3mn3r9l4XVOzRllV0bT2j7KV4d3d?=
 =?us-ascii?Q?WbCkVDClVlqmHz98vNqT+KyJ1fAclS7SGLK5tMp5SRynfiRWcWSvbv4bOSFL?=
 =?us-ascii?Q?v0JFtp0IIz+5a8Qo9269g10XMYMgM+Bp17+H6Hd5nf7i+kciafHoNU9IEDEM?=
 =?us-ascii?Q?D2coPbveKQzJV+zonLYLM8hX2NP0uO6tlQc8SdZyGGNm6XlZYRb6q6m6Mkqc?=
 =?us-ascii?Q?Ucmdw5OU1EkNAZwDPr0yETWwTo2iB0+l9VHUO/4YFVUBFDF32VlI/0zgCJVR?=
 =?us-ascii?Q?DD6Is/FLR/HU9SRCKZogXRO4abbqCZmIOZ3AZ1L4w4fx4gy7zcLYsEjkBLUQ?=
 =?us-ascii?Q?N7XeKlhkZbD9DlSZJ+JfTVyNppJrSYYB8ismsBXehJA1DNM0oyzYtIGUjG2h?=
 =?us-ascii?Q?50sGxhcG9ta7utQuwn0JEgklhEaihyK941ocXM1O8UscZM9+RpASp8jOQ8WN?=
 =?us-ascii?Q?d0PvnlU8+63Y4zZ2orDcSUOzrO/ZQkQOCE3w2J+G1dP2sPGqoOEbEIkpOAB1?=
 =?us-ascii?Q?wCQVn32Y4Uf/LY+d2rKHssmjyaCnlI06/f9LKhxRFbKLHad9DCb8zGeFfwXA?=
 =?us-ascii?Q?tqz/jWcDCsEWGA9XPTxUyigw7fmNaShgJRXwRzN8GCbzYvV6rwH7HXXS11Bi?=
 =?us-ascii?Q?m/CDMc2v/nxskJMLTgdQcoRAC3O+UhdTAIRTqvvCwA+rd/TZvlAbywZ6kutJ?=
 =?us-ascii?Q?jQH2TyEWkYvs4TIh10+FuNa9TT4g7iAwyHFmvs+AjxE+pEXFdahWW28fSwLy?=
 =?us-ascii?Q?mQ06V59B9aF+5QEY/4UN8edeob19JC/OUrcmMEvN1M6NoxpttA0kuYqIDBGR?=
 =?us-ascii?Q?bnvQ8HN/G29d/iyuTrCKTyf2gpys3ZDHgyPomOQJkWIpW/jOaPv7o9M2q1ED?=
 =?us-ascii?Q?lxThMzdApKIsIrZtDi8Xzr5angtdfETugXqMhV18aysOKW7JmWq7yfFNbbGG?=
 =?us-ascii?Q?2DJsuNiskEJfJJT7Kg8Fnsf/hpkTBrkt28cx/YqzaK6tQdtl2m053K+1/Bir?=
 =?us-ascii?Q?4MFXDDceRg1kNtMNdbZOhFAlW5PGTKnnT4QTnwQ5MQKLlLQGRIl5t3k0Ib9D?=
 =?us-ascii?Q?1aD234cnC4Ocgy5TKsc5sBk0u08AukYoAacR8pwcrlEj0f7cSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:12:15.6165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e7f8f5-5f5c-41e0-935e-08dc8fd2f2a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
Received-SPF: softfail client-ip=2a01:111:f403:2412::604;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 18, 2024 at 04:03:34PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 17, 2024 at 03:39:45PM -0700, Nicolin Chen wrote:
> > -            next_range.input_base = idmap->input_base + idmap->id_count;
> > +            next_range.input_base = idmap->input_base + idmap->id_count + 1;
> >          }
> 
> 
> All this has to be written in the way that actually refers to the
> spec. id_count is nowhere in the spec and one has to know that
> in the end this is used by build_iort_id_mapping to figure out
> where this comes from. Not good.
> 
> I think the best way is to fix build_iort_id_mapping:
> make it subtract 1 from id_count.
> 
> Then change text from "Number of IDs" to "Number of IDs - The number of IDs in the range minus one"
> 
> You should also add the reference to IO Remapping Table document
> near build_iort_id_mapping, it is currently unclear which table this
> refers to.
> 
> Of couse this means the only correct use has to be tweaked so the change
> to build_iort_id_mapping does not break it: 0xFFFF -> 0x10000 - but
> that's good for readability, anyway.

OK. I will send a v3 following that.

Thanks
Nicolin

