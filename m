Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09E9E6F084
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 19:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6xLC-00017s-Pk; Fri, 01 Nov 2024 15:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1t6xLB-00017W-Es; Fri, 01 Nov 2024 15:29:49 -0400
Received: from mail-co1nam11on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2416::61c]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1t6xL9-0003nK-FZ; Fri, 01 Nov 2024 15:29:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkkH0Z07u+ODVE7zYuo0c2xMRx+eS6klqOb50ou/bkrGZUDvcZZtSbs3naJzl1RFxldyVgiw4zOIIYIg14oDzlsbPQcuXbo8ZZCzFySTkBTxIoQSrMNGHBummUHlJAMYAfnjZctWeHMxgHu/FKzNyipGnRFIArA+ckONdNwvhqMOMcOShocDBfn/AtFCV9KralEzsPONEYCg9KCT4liiZaBoUiAoUHVM8gmw2OAwax2qxRWZTxly5bp+iwcnPrrtDIw3hvBAKqWCelT0Q6kPUq7DIwDsy0PY5zIhNMQXan2L4HNCp3YeCz6ToVbWBh08WG7uwKUzShBvoC2VvQq9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePeUa30+yR0Pi3qhfyLSj3LrFdn06UX0PVhQqVxTCSE=;
 b=bxe02r+OBg+FTSHZyXXDoVBEfAOfP7WGCRU3XcukmIPY9CLcaK8/nOlgZXa7pfWikvgL+542PdCu8VFneV3v3bQ+MfGrEjP9ScTk8MjJkN+Bc8UZDO1ASTCqt44HYLFIv0AxJfZVpHQAFIigT/cGVrCbRNt81nw4HcnwHh6gl3wuJw1loqEgUObFlzZaFAyQSDYwv76/31zoLoNLkoRPirZ9h7Kld8LI6+eg7ayMhVTOb5dPSdwn3YNBmfXBbXm7OakghV9QTpvI5+Dj8iTNsOq6+1tFQQhJBVSds+lt5lzaZd5GbMc/QHY2VXq8V7ShSPBGUDfezmkRcNHXf5Mpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePeUa30+yR0Pi3qhfyLSj3LrFdn06UX0PVhQqVxTCSE=;
 b=JJdjGbjp515At2e2TI12cUI5NxnrPvd0Ws336ignc8k+YTMusn58KUuasRENcNsL2Jsvv/i3QzEpvETL449iRRu/aI1V7FlqjoyL7T2KCaISj801LvxYTbAdDenmxQPtVGQsA1C70CDWl4B0Wz3knH2DDVjj+G399e8/71zjGkUKk/BN980IXBi9XPMxzEquVJms4opObmDixS8qidHGjMJB1+aw2024RmoJlVUCo4OCbaVH6aqxNKNCtjiTIID8R3/x6/HVZLXnQqXssIYdsdcL0X3Hl+6MvKSGcMnaAOqYrxICSm5d8AbuThXaVaqOXaGl+2C11D6zxmPmZ6uuTA==
Received: from BN9PR03CA0902.namprd03.prod.outlook.com (2603:10b6:408:107::7)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 19:29:35 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::7) by BN9PR03CA0902.outlook.office365.com
 (2603:10b6:408:107::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 19:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 19:29:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 1 Nov 2024
 12:29:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 1 Nov 2024
 12:29:17 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Nov 2024 12:29:16 -0700
Date: Fri, 1 Nov 2024 12:29:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, Michael Shavit
 <mshavit@google.com>, "Andrea Bolognani" <abologna@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Peter Xu" <peterx@redhat.com>, Zhangfei Gao
 <zhangfei.gao@linaro.org>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "arighi@nvidia.com" <arighi@nvidia.com>, "ianm@nvidia.com" <ianm@nvidia.com>, 
 "jan@nvidia.com" <jan@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>
Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Message-ID: <ZyUsClNQwcIkjdZo@Asurada-Nvidia>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <cf4359b18f0d44f09b8901141b678a09@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cf4359b18f0d44f09b8901141b678a09@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8d8e09-0dca-47f0-8baf-08dcfaab8459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CA1RfFK4aoUCNwe2P+jXKuGdwy3q5wtj0ks6X3vKYQvsJ2rEakAaB3CdVzBR?=
 =?us-ascii?Q?72VMTEe/fhZugdEh6fxYNLNLa62DFq5xQS0moms30M2SzCGp78bT5BVmxYwl?=
 =?us-ascii?Q?t0RAa2SCn2QRKsM5B3DtevrNuWXOJbeCFwtAsAc5WrSEduyIBVIZVWTdaOcy?=
 =?us-ascii?Q?N6NqZFpGdt3JiVAZg9c9eYKS7flOAa9LF/II3y3lBYCMdokxfTkyZtAm/D1p?=
 =?us-ascii?Q?DDN2JhrAcS5OHiymncjr/Jwr33GlV2bJjtGahu/A2u1oEpG1clNAFbDRgVXM?=
 =?us-ascii?Q?iXCCUMpZY4HUd0M0bpsn7usRg0PH46g++zxNxZ/SdXK4Xf38QjBEckvAu+zk?=
 =?us-ascii?Q?dpn6ONMcxaPf1vU2Ytl2ODhRuitqkTW+UX7eJOAPGQPoTSdMcRESRNVk52I1?=
 =?us-ascii?Q?36rJeyrIwmrYOBuvq/23H14Vo6gTuaIUGVVW2CDe7F/L8Gowdgu2dn0jYPRW?=
 =?us-ascii?Q?iuZhLf5k3Kw6AzUeBWy6fYJK5vUxmreFoHcjjHRcH8lyEp0VE2NRck5F4QZs?=
 =?us-ascii?Q?3AmOk6+LWyw8OtX2YRTLWnEdezo9fMG99i3QUGvDNzDxJj4zGcseo5o+AyXW?=
 =?us-ascii?Q?6xqinnKaNm77R5xh5y3sTwDuBZYVc0242nlDSvQSAZ7uqPv7C7oVWP6+RJmU?=
 =?us-ascii?Q?CligaomR27ZI5/iZlHS0cwQsAfNuFApEJrl3nnqThsRIgSs5iwsWCTt0LmdC?=
 =?us-ascii?Q?4scKbEdj0xDrKhtiFPz7uxmSTlkREFRVpCjFv0+evTuePgdCLqAnCTc119Zi?=
 =?us-ascii?Q?3LM0pTAQYJavcyRx2EuZQiax9OLz6pH3mIgc1PH528nlqiJrvUcNI8GgLWSv?=
 =?us-ascii?Q?Nw2xE8GVcwUt9W8WLHILZjrX19q15Vq8J52Z71D95Hm78d3Rvwjs0ZexmzJD?=
 =?us-ascii?Q?Gl+hqYwNuRj5KSc+Bd6ZbEvCRzdSRKzev5hEU5F0YEWEVnMYcYygEHW0Sqjn?=
 =?us-ascii?Q?Hvb3lvw7Z7skpql2gNB3QRWuCL4j9aRRLe3XSzCI8SMKxAFI/2Iy8t6JGgg2?=
 =?us-ascii?Q?cIeEKF6/fAiH/QOtGZu+OjOXyPVFgoenx6i+p6jWF/B1kQhJcbeADEhsV4I+?=
 =?us-ascii?Q?/Z0aLyi9tdK13sqnD3989dBLgAcMWkXhLZFoE5QYP9Yjm1vQPlq03QTe4RKx?=
 =?us-ascii?Q?05M5s5iZTZ+s/eGxy2UHCblYq2fb5mSR1QqebrMFXH1nYf5GUc2AjSk3AtcA?=
 =?us-ascii?Q?X9aV4C9T0KLleJnHpOzXpinNKWFvudcsfSIPCY6Y5Wh951ffGp+ypvRMKmvq?=
 =?us-ascii?Q?Z5mfkvBErlVaSkQInu0pNu83h+0JO2iiPt2fxLQ1aShFrmstTlGERhGwpoCq?=
 =?us-ascii?Q?+PaT0fswmFSkMdH+t1kFmY6LZJOmq7/tmBtd96fd4KuK0frhnc2LVoOYEKJA?=
 =?us-ascii?Q?nQJCpGYip0fENC52BwENgESGUtp+mmpOWnvGauTLtpYRSpnHXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 19:29:34.4549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8d8e09-0dca-47f0-8baf-08dcfaab8459
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
Received-SPF: softfail client-ip=2a01:111:f403:2416::61c;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Fri, Nov 01, 2024 at 06:35:23PM +0000, Shameerali Kolothum Thodi wrote:
> > @Shameer,
> > Do you have some update on the pluggable smmuv3 module?
> 
> I have a bare minimum prototype code that works with a pluggable smmuv3.
> 
> ...
> -device pxb-pcie,id=pcie.1,bus_nr=2,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1 \
> -device arm-smmuv3-nested,id=smmuv1,pci-bus=pcie.1 \
> -device vfio-pci-nohotplug,host=0000:75:00.1,bus=pcie.port1,iommufd=iommufd0 \
> -device pxb-pcie,id=pcie.2,bus_nr=8,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=8 \
> -device arm-smmuv3-nested,id=smmuv2,pci-bus=pcie.2 \
> -device vfio-pci-nohotplug,host=0000:7d:02.1,bus=pcie.port2,iommufd=iommufd0 \
> ...
> 
> Something like above can now boot a Guest with the latest kernel. But I am not
> sure it actually works correctly. I need a bit more time to update this and carry
> out some tests. Will target that in Nov.

That looks nice to me! Thanks for the update.

> > Updates on my side:
> > 1) I have kept uAPI updated to the latest version and verified too.
> >    There should be some polishing changes depending on how the basic
> >    nesting infrastructure would look like from Intel/Duan's work.
> > 2) I got some help from NVIDIA folks for the libvirt task. And they
> >    have done some drafting and are now verifying the PCI topology
> >    with "iommu=none".
> >
> > Once the pluggable smmuv3 module is ready to test, we will make some
> > change to libvirt for that and drop the auto-assigning patches from
> > the VIRT code, so as to converge for a libvirt+QEMU test.
> 
> One query I have is, do Qemu still need to check whether the VFIO devices are
> assigned correctly behind the nested vSMMUv3 w.r.t the phys SMMUv3s or not?
> Or we can just trust whatever the user/libvirt specifies?

That's a good point. I assume ideally QEMU should do something,
though that would be somewhat duplicated with libvirt.

> (I think even if we don't explicitly check, at present  it will eventually fail in s2
> HWPT attach  for the viommu if it belongs to a different phys SMMUv3).

Yes. That's what we have. Perhaps simply print something like:
"is the device assigned to the correct arm-smmuv3-nested/pxb?"
?

Thanks
Nicolin

