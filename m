Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F69C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 20:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGwP-00076I-Nr; Mon, 17 Mar 2025 16:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuGwF-000740-BN; Mon, 17 Mar 2025 16:19:55 -0400
Received: from mail-bn7nam10on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2009::630]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuGw3-0002ER-7L; Mon, 17 Mar 2025 16:19:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNzpgBi7ZTevGFzuN+i+QkvUpU0pS6ZJqEdEMHDy+CpfsLmy8L6iZLhe0vNYPGeU9mS3aOhxYQvUUM93N96sSj07z37+WazMpcZ1c9kThRujxeNzkf5d8oGwlowOgarlswTB51lDh1tb6VpJJ7q3+/rin4hFCpwk4vUTdPp+KYFUrmDOwWi83g+tAuiZq5v0yzMiy0BqwWp17vnEQGOJrKt4IjShX2MN8VWQNAKU3vvJFgE24/9q/OEt1S87qOYD/MRHxVmPRYob5/Ed+ITXxPn3Im8fj4WbsHgh8h9DfHax/A4EGwDZ2890e6sOdhWPaS/+owxssLlLrVgdXjrcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhYAzmX0US2UqCdw/cp3ubwd7J6VKBrvM0Tz1LJMNWQ=;
 b=c9ASHBSmWPSU9BIgaBwohH3VykWi4k/g3dE/EtiDyJlm8KBQHTyFuyqY7RBp/sa08bktv7OJUGJg0ZvTp32iqTpjtIyOzN+PNsJ6CjO/45HNc9qikKaBglGpXsN5kiPynrRXn/BgZ0NA/W++azdPHiRMbcY++NIqGy9F9me3/QKxjPnZf5d1GUpbLPYPHvbn0pecJdn6x86ZP4o+a3hbiC5ZteEnVePF0WOWnHZ1t0+jfPnuvjXAMqrff+HUf5Hwfly+lku7WyTy5LulUZ4ABt0mHhEYo+v2LHHMCChPK/JUKz8+behZqS5JG+RP9tje8rg2TLPhCOp8DMh+BYXpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhYAzmX0US2UqCdw/cp3ubwd7J6VKBrvM0Tz1LJMNWQ=;
 b=B70e9kpvwORDeVtAPSMw1ocwcor7/RjXxeqGq+tp/RdRC+GsWIOSZ5+zOGwU5L5eh4TeJMfjJqEjXX4Hybv0f1yai6mgV3eOJ5e6sfYQLUaM5wROw9PQITvoWLLIBmeDDBHWgT+ssQ7Kl5FsarzPLro2YTuLHta6fdnzn5j+FY8SK91Ar7+LgFCxwEUsT0WA6HwFXQB0ZpnYVhGQLVwOvug0WOpIns/7HHpk4cklNn04HuNNjL4ZbrGDPW1gLK1ZOeB1WbAvB7UebIzHAUKXZ2qJnHGWG7EaHWatOKIVf3Br9vTgvH6XtxzJ6pUzk5XIu07txzyrxWraUo53bJzGdw==
Received: from SJ0PR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:332::34)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 20:19:37 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::3b) by SJ0PR05CA0089.outlook.office365.com
 (2603:10b6:a03:332::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 20:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 20:19:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 13:19:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 13:19:20 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 17 Mar 2025 13:19:19 -0700
Date: Mon, 17 Mar 2025 13:19:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <20250317192453.GR9311@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250317192453.GR9311@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: be717946-c084-4f27-244c-08dd65910a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8k8xl2ilkSsbDMNhAl4O5iTZkcsaQRfHpD9GXZ6khfXVKoPrK7aJjGqEjK27?=
 =?us-ascii?Q?prngCeCirvFrAHc6faJt0E9cuLvBIAWZ8B+WRKEp0vicD34UaPAgxFvfUk5H?=
 =?us-ascii?Q?04ViSwT6+nPxUDy3GfzlNb4eKO+SIegb11dwh3BjzqYMFQedXfhewZf8qZkf?=
 =?us-ascii?Q?cifSFbwzosIrDRKIGfCPGpT/fbuw/Qm5kNVVHBMQtKGtwgXpFDk61mCcBxJg?=
 =?us-ascii?Q?PfD+thFoJPESVhRye3xeRJK5CkI+W/BBNscAIPbNsAhKJh3xp2VU4rz1qzSK?=
 =?us-ascii?Q?Ikjgkc0eIh1TmB3N/BUzN1pyNcOnePefwfSL5mAVLxO87CYBXJIEwF5w1YIg?=
 =?us-ascii?Q?q3dgu90Zwb/mb3hJYsI0GQgB0d89hZKcqe63jXf9msvnoEuapmXCvooPL4bL?=
 =?us-ascii?Q?1VX7ba//3/6bm93Fb38izERT0lYB7zGDm6EKTbK63Wqu90kpnsLVcmhfmM8w?=
 =?us-ascii?Q?q4yCZUPh0nwT2trWV8dZAu+WTYLxsTPVjlBzEUYZczJ0V64qSKtmqEFZ5BwH?=
 =?us-ascii?Q?vdCVbdNh68pAI7ZOm4+5FJCO8K+d9Wv76wmQEsu1EihSu/mSMHK6/azXhkh/?=
 =?us-ascii?Q?h7GNf2yFTxy8/BFOg8fPMold+uIg82UQtJTVSKX3pOdOGUAVeJFXrTWb4amc?=
 =?us-ascii?Q?wgFKfagNF5oGRAz6Z3VQy2OPF0noiY2h8TmfANbiRkFG/0ITAQXJGCUsikny?=
 =?us-ascii?Q?3N+Lege5X3T22qlAA2Jn9Vdqdty+BeKAL+NDQoBZC2Kghci57wTCcffnf4Fo?=
 =?us-ascii?Q?aknyYSpauPlwoeuqZdOh5603D689Ci/7WOhjb/YKz0hHpezOhWV+Qjha2pIt?=
 =?us-ascii?Q?Nyt3ThMhXyPHmXU2OEX1CWZ5TIf4dykEaOH+6aLtYoqt1wOjbvgWntHumD9F?=
 =?us-ascii?Q?Zetz/60VTddyicXR3622g/dvTM/W/cwzV6AHCxHGT6a7epeg8FQA+GBrvb+Z?=
 =?us-ascii?Q?XDfodDLx5ztJYpc6jKJ/7DDex+m3bTvRf/9dK1sNQjVmzC0ZTZD3pdFc/kLl?=
 =?us-ascii?Q?x5lnQ6zc0fpgkKqv6yryTPtYIpf/o1f8arj2xYdTR1rhjT6s1aboPynlrxpN?=
 =?us-ascii?Q?fgenVUkW6Jp3g8HldINF03OcNmiBkVHECRSBIeHMRYivHA4hMEid0W6BM1SX?=
 =?us-ascii?Q?DipzA0L7HscdRlAEkhnKdpe5jI3E4yCAltH9uXSFMudrso6mIH6s0xvQiWgb?=
 =?us-ascii?Q?RBd2l6Bt7iw13vWyIXeXY9xLqD4Ppi+Hpo14y4yFVfUN9XvbsJe4DFFqR2h1?=
 =?us-ascii?Q?N1Yo0l8qEn1RbjfkOApoZsPg5Vq9Tbx7WFr514R4CYwZHcsY1W0dyGMcxg6M?=
 =?us-ascii?Q?5EiVCOstEA1ad7sUIkqGuBb0XhujyHLes0eJ7vJ1rdTojdqXJFiRiUXsE1Uh?=
 =?us-ascii?Q?9mMn5P/BINL9I3pKvhpaweLQzrmIe4eNSlRJZVCPU8GblaCa8o1nI1mr3cCH?=
 =?us-ascii?Q?OEMs9T+LqpgofnbfPAUecQBtkAheU1i3raq7C2o/l5gYz2xqjpoV5G68EyD3?=
 =?us-ascii?Q?FjvqRXYx6dSXPl4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 20:19:37.3505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be717946-c084-4f27-244c-08dd65910a59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C
Received-SPF: permerror client-ip=2a01:111:f403:2009::630;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

On Mon, Mar 17, 2025 at 04:24:53PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 17, 2025 at 12:10:19PM -0700, Nicolin Chen wrote:
> > Another question: how does an emulated device work with a vSMMUv3?
> > I could imagine that all the accel steps would be bypassed since
> > !sdev->idev. Yet, the emulated iotlb should cache its translation
> > so we will need to flush the iotlb, which will increase complexity
> > as the TLBI command dispatching function will need to be aware what
> > ASID is for emulated device and what is for vfio device..
> 
> I think you should block it. We already expect different vSMMU's
> depending on the physical SMMU under the PCI device, it makes sense
> that a SW VFIO device would have it's own, non-accelerated, vSMMU
> model in the guest.

Yea, I agree and it'd be cleaner for an implementation separating
them.

In my mind, the general idea of "accel=on" is also to keep things
in a more efficient way: passthrough devices go to HW-accelerated
vSMMUs (separated PCIE buses), while emulated ones go to a vSMMU-
bypassed (PCIE0).

Though I do see the point from QEMU prospective that user may want
to start a VM with HW-accelerated vSMMU for one passthrough device
using a simple setup without caring about the routing via command.

Thanks
Nicolin

