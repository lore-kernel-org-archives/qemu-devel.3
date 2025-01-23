Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB32C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 04:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taoYE-0007z8-69; Wed, 22 Jan 2025 23:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1taoYA-0007yD-Bl; Wed, 22 Jan 2025 23:10:38 -0500
Received: from mail-bn7nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2009::609]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1taoY7-0001Df-VD; Wed, 22 Jan 2025 23:10:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9VfQaGrnLiIrRmlRZ6ZI8cCw/cFLGaOL3krdLQ0sx+ayv4MT5S9eWXQbxYlIcVrM7+y/efJGxJLXWZHQ17HKiiWRsYsQejjgb/137kx9ho99MRNl8pkCWC2Z7dCCMybyVY31wNl7PfZBxQJgw4fmmswIN57HGMDQFvS5wI0p2H3G0kbmgLSDKyPHjZlNjybBnJNr6n44i1T4oOUV6nhlztmzwo2mejhYhZI23Wc1RfjNMBGZW/jHcHLE35wFYJUwbfQIlumzshzj0gKWyxQ4Lh5hEsE0wZV0OIVXjHSpMHtMaP1gufM9XylC9SZaX5z/9RBLhqyZlcpZXDI2LrbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SckVeoF5BcZrsjOQoBHbFmTw8x0H/Y9GqZzXIcXO3E=;
 b=l09BgVw7BwbHtupd922IurrKlvGMa2jDgV+LQD9dDezYyM8Oqyb7uBlzw7ygePEswh8WsCP9o5tOCwprEafauU6sPLOJS3D5T7SNRID9vjNRBKtHP/LEgyETzd/uP4kRCJg6gJwTyHli7cpWbeusz8n1+nuihBqvTdQG3ZxjAzUocF1LlmgvVf5twoOoi6K5P5DP/4Ue1oxNvYzJEdySZhaDtVIYzzypdt10kfZJFsEhHso00WmvQQ1FmBLpINLa4OZ+dhqSs/ZLHQr+MgG8ofI24J/VWQP8eWNBvkQcq2pTZL++QLks+fbQB/w/Orb6D87gU9MjJRrklWafCOrJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SckVeoF5BcZrsjOQoBHbFmTw8x0H/Y9GqZzXIcXO3E=;
 b=ep1amcFMQvNfWPWQB1Tryqfl0am9y/w9JOuPmIh3kMgtEGP15tmUYvoY/gqrUSF5N1VNLdwsGjHIbwK1xZgFVp3HL/EXW294giBKTVTUNaWxT+HYrwy5ejf4lwj9vcbTGpmqcyx6FqOUT9box0OvUwt63DYVLsc6g9kurNsjZ8TSApd66IPMNsaHJBy2i3Or2OSHywFVn6iIDxY8p9ilN+wcw12WpEasA89woc4E9/3UUeqig8l3e5CPKVbYlggmtUQsbMHveYnfvFGr1rb0IS/s/T5nwghGnURB0rzr3SYYLn29yLKlmgB8nOClNkq3GqThPCodKwqaLCIATjF+yQ==
Received: from CH5P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::20)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 04:10:30 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::45) by CH5P221CA0004.outlook.office365.com
 (2603:10b6:610:1f2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Thu,
 23 Jan 2025 04:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 04:10:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 20:10:17 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 20:10:16 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 22 Jan 2025 20:10:13 -0800
Date: Wed, 22 Jan 2025 20:10:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Donald Dutile <ddutile@redhat.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Daniel
 =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z5HBJOgO4tUJApY+@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <568014f5-25fd-439b-b70c-9cf50f31255b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <568014f5-25fd-439b-b70c-9cf50f31255b@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b0a5e8-acb7-4919-57d4-08dd3b63dfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iqzEsC+ADXs9ztn7UflCZd4mgzOGOqBLQMqo5Kay0pbb2pPh5GidfTlHbvm5?=
 =?us-ascii?Q?nTRdGU5yiNQoTgEGx68PnTtZ5OZfWH999/lPNcI+9ryEt04HMzO7QSEvtyql?=
 =?us-ascii?Q?q8scPv3WD2nZBHv1xuKSZdgxlK1cGVREJPTdCbpL9GUS9/EoGwiHN5DijOSp?=
 =?us-ascii?Q?wktYyCSZP/wv1zpyykHr49FlnofeuKLjMpyJQkMourjks/70BF+nELuwrz+9?=
 =?us-ascii?Q?g1bHFdNP8jZdDXE62hdV2aEyiffJcdV2bxpgMyL8KYFoRH+cbStSw4x1QbQd?=
 =?us-ascii?Q?Jbg8VUA9h4RBtQiKVyooKdd8SwYGvISJoNEZaLe08bAfTBjiKE1MklM/d79C?=
 =?us-ascii?Q?X/b1uE7GJ8xuJ+RLUL/Ufle7OQx48HpuV0ekk8YQPX5Mr40h1omQ/AkjSP/l?=
 =?us-ascii?Q?ldP6TtQH9BLECwGh8x2C6v8NfNeMdJUJ+POHiBR9tV3bFOnwK5E3bMIGkMMu?=
 =?us-ascii?Q?N3uixonut4kNei5d1cXlMFhLV1ZvAMQWjxpw5MhfI134J1wmuIuohRpDGl7R?=
 =?us-ascii?Q?A2nEbL2qTszk5LT2xVtKRkHndPSW+GqylTvRjFHsukrFx0QV86gdfnI/SNuY?=
 =?us-ascii?Q?y6Y5Rtt3B8d8fwEN4HMbZ2q//PPzzMoWRUy612HrrC+E+7OrvbG0/uVEbiK9?=
 =?us-ascii?Q?oiQ4BjbgSA2JpKrn14WiTd9jeiO5dkClfoiG6Ju7VWILAfIoIrpf4Sm+g2lt?=
 =?us-ascii?Q?x+qrLFHemi2vj57pjEE1zkNxspKcniRBwkNkuapH3ElK7kFzt1vvHCOvVmDn?=
 =?us-ascii?Q?MZPfwElNrcnNuPvEJkSTjZmtFoIBUqJqU5o5JXHVKTMNIbH/U8ltCcfbr0R+?=
 =?us-ascii?Q?ulv2O0GLq9NumZMD8AKJB9k2qDdrsd4t3q/h5sJAAjJq4EdQb3WWkgL+YE2f?=
 =?us-ascii?Q?2eI3KrYikDZ0Ns/c9aR5LobYIJ38GuRJvyrsvpiUPHEzG6eFJ6ZrE+RO30TA?=
 =?us-ascii?Q?O309rUI9oAqBJFQk8zh2FpQcqgoeRQJtxkMHSxANj3rhjnVqIEUm8+tICB40?=
 =?us-ascii?Q?J7TrKLsJOu+810K5aoxk08h5ThfAKbZwViJLPUHWAMoJjsLQmnPldzL/oflX?=
 =?us-ascii?Q?Tln2So8PU4MeZ3pPcOYgOBoRQSdbqzqxvdZL5EF91nPYnIMaOj6qZF2RbRPq?=
 =?us-ascii?Q?xQQce3cqyUG0g8Uu++vKKeW2XKS6MWOlHiBXldIt85onrD3vq35Xb57ItfVx?=
 =?us-ascii?Q?7OylDLNIU/hhF9tsAKVgm3/m/QodrsUmxPwry0rMEQpZuGndwfChZ8QbshXg?=
 =?us-ascii?Q?zbVgLrw//d9+64tw3Kt2WmVGWlkATxWFc5SbS8kYcvMVW5l0ZKgKDk1J91tC?=
 =?us-ascii?Q?9OkGaJ2jpGB/4jNZlgbPJSYTaSfOCg3bJKaYRrzr5Ux2pBt4nPhnAunCBT0K?=
 =?us-ascii?Q?8LJMsm/u0mRkN7ydLYr5PXvP1aVr4wdoC3ajm7MJq7sTD8V8xHxXG+eXZ1qk?=
 =?us-ascii?Q?A1ZdOD4hpHGVD93Y3+AsI6WPdgqi+nG1tsSQQDRAEvsGJ3m82p+QeaRD1CZW?=
 =?us-ascii?Q?H1zhvLt3A1E8zLY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 04:10:29.6313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b0a5e8-acb7-4919-57d4-08dd3b63dfbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
Received-SPF: softfail client-ip=2a01:111:f403:2009::609;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Hi Don,

On Fri, Jan 10, 2025 at 11:05:24PM -0500, Donald Dutile wrote:
> On 1/8/25 11:45 PM, Nicolin Chen wrote:
> > On Mon, Dec 16, 2024 at 10:01:29AM +0000, Shameerali Kolothum Thodi wrote:
> > > And patches prior to this commit adds that support:
> > > 4ccdbe3: ("cover-letter: Add HW accelerated nesting support for arm
> > > SMMUv3")
> > > 
> > > Nicolin is soon going to send out those for review. Or I can include
> > > those in this series so that it gives a complete picture. Nicolin?
> > 
> > Just found that I forgot to reply this one...sorry
> > 
> > I asked Don/Eric to take over that vSMMU series:
> > https://lore.kernel.org/qemu-devel/Zy0jiPItu8A3wNTL@Asurada-Nvidia/
> > (The majority of my effort has been still on the kernel side:
> >   previously vIOMMU/vDEVICE, and now vEVENTQ/MSI/vCMDQ..)
> > 
> > Don/Eric, is there any update from your side?
> > 
> Apologies for delayed response, been at customer site, and haven't been keeping up w/biz email.
> Eric is probably waiting for me to get back and chat as well.
> Will look to reply early next week.
 
I wonder if we can make some progress in Feb? If so, we can start
to wrap up the iommufd uAPI patches for HWPT, which was a part of
intel's series but never got sent since their emulated series is
seemingly still pending?

One detail for the uAPI patches is to decide how vIOMMU code will
interact with those backend APIs.. Hopefully, you and Eric should
have something in mind :)

Thanks
Nicolin

