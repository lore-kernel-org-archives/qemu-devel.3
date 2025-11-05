Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5753CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 18:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGiK8-0000EU-3j; Wed, 05 Nov 2025 13:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGiK5-0000Dh-Oc; Wed, 05 Nov 2025 13:33:33 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGiK3-0001zS-VY; Wed, 05 Nov 2025 13:33:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfhMMnioOLPyFUZPzzGrSyV1GcZGcYM1RhpC8Qq627jsrhRULkHP9NYx27yzCrpquHnEz1PmUmm4RaksLSWQ3Fc/3dbFnJ6HyTf0UL383pzK4R6wWvPYWbB8RVaQdDYxmiTage4woK/uvovSMa0nOiYizJXNGnHgq/n0+wlqRB8BarQmPDN3XNXjaJDPtN9gpjnYZ1OOEf/0VddCBJhq6dSUoCt6AXE3OQHkN59RFXl+TdQNzaRoNxtfuKoC1QyhZICyF1B2pQJWTX1c0H1g2tpVQDcjVwTJqd43I86zGZVmGZC53OYJW5fsRAJyBguL2iMBhe3RMZ7WGoMi/RRTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAQaJmVk8PDYtgrxTkJm+ZlObwTFL6d1C3yX2Pk7OSc=;
 b=gv0Ujh/WsXdfZqBha7r9DwnhsdvfQ8e7mrHKxngCN4/8gVFwlINlvFSUsTn7eIHdbbIh2HCakBoUCX7UDbYkPg9TomHb/WLGV2qk6gWhRqtXm0WWVzEd9mkyLBjvmmBv3JHeesbq5cskHWDEk4Zj6nSsKRmfnI+iI7h5RkkE1VHBoyDj4tFvreAtYsSVkO+8xEU5uGDjcuBFF6Cii73zX1oHF3kBGTa7QW2hnXx+uC10oKDk2c2qzh5ju6ZO3eq9psMmNPBpJsP6iJMdtZ2tfZGbzNxcRnn+1hQJpmfYu3TEY+usZL4BxXGe1dSkT2lNRZngsM21R1flYPV2bQOfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAQaJmVk8PDYtgrxTkJm+ZlObwTFL6d1C3yX2Pk7OSc=;
 b=fNvvLhKQLNBgeAz/bTc2C4o5aquZJLydoP+Dfpt/R2CmihpYsvxPIjmdP7TBMhwGdZTX6UCW7285virPBKwukAAS9OrATm3e2MeCNxBKorj58FbfRpBL0q6FcDNHHZTXq86cEH+s0hTiTiGLp//6eb0aUdTKFAmBaLc5NMCmV/nMy23ouwl4Ga/1+nJsDnMJPNUuMfMtK69HTpjSE4Vyvzvk5sG8GXLLgJxUGg+vZvYgXDwbQx07I6vmBg31Ficiv2sf1l31TMU/ZsruI3JQllfW6PRwRqTsnCyglibQaC/8MD4506RY3ZOOJCxuExxMD3A91M7QHcNoINZiUJUzCw==
Received: from MN0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:52c::26)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 18:33:23 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::90) by MN0PR05CA0019.outlook.office365.com
 (2603:10b6:208:52c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.5 via Frontend Transport; Wed, 5
 Nov 2025 18:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 18:33:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:33:11 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 5 Nov 2025 10:33:11 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:33:10 -0800
Date: Wed, 5 Nov 2025 10:33:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <aQuYZM/8SX+RtDtv@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
 <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <7ac24d9a-0caf-48cb-832c-812fecc5c82c@redhat.com>
 <20251105181049.GU1537560@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251105181049.GU1537560@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc68c06-4144-4de3-b3d7-08de1c99cd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?688/ckdTDWb2bMeeNpqA5lE/jvmnSF/PijPxboREslri7RRqjBe8kJTHt0UB?=
 =?us-ascii?Q?CQdw697azZ5sN/mA5BxS2V6/b5I7XnkApUUN+m5IY48ftg1q7Jpj+jkXgJRl?=
 =?us-ascii?Q?ozm+Hvx6OnNRWUYTCYrAG2D5bfXJFXjak4pGvSU9ryHgCbiJb/klI2o5f0Sk?=
 =?us-ascii?Q?HMrvIo8lAYmB9zGQWpmmopP3u40MLRWRdBOo66iBJBFHqtX/+yM/tW4yGJc7?=
 =?us-ascii?Q?V/aPbxUOoK2Z6w3D7YlXJ2KQLNk0tvUYzv+gKeITeoUuLm8TxVCI+H38D/wA?=
 =?us-ascii?Q?jllmu4W10ScOZv5a9jvo5rnQX3y9W7NTEaeQPSI+UYisYzkJ9mgeaJqMnQNN?=
 =?us-ascii?Q?pM01BUAhyn325OyAWHdiWLjqtDgTAwz5K0lvf9RjtIimAgiH/HWKNIMHxByq?=
 =?us-ascii?Q?r5JrrhWE08rMtwAuCCmBRKUgZyhwrBOVDJPBMvNlfqFEyJc9j3iPjzFuSD68?=
 =?us-ascii?Q?nDrQxaR+E9Df3rqGzgaf9D9CDwedzqI97ihoPIrp6mea9Z1yQVswfq/4XAlA?=
 =?us-ascii?Q?UP6O48O3Mjrau4LWaC2gS5Sq6XTwCnCcbBQyBl46KdiDzcbqXHhloI/BNYsj?=
 =?us-ascii?Q?F9KV0sh8W1xVmnkQH62op2PkgahdoIkpg7+PgbXILQKhh5ZNpr6Y3AF/2dGD?=
 =?us-ascii?Q?ZwD5vDVC6Bvt+N5vfOWyzoy97RmAAiA+Ohl2kc5XQWIpnPEFOEbRPNJBFEf7?=
 =?us-ascii?Q?yEDSVH8zJC7To0IjJCZoJzvec3rHBaO4Qlj607YPHR/ZoT9Qf2Mlj4E6fpkK?=
 =?us-ascii?Q?JDC18EwFhQ8XuIvhk98qKPGFiXB1nErVZwhNV0nb90mzJurCyu1hq8G9elfM?=
 =?us-ascii?Q?+SQ5LqMVY19P7bDjCIh2Qv0SVqmT3ZF2a41kPR1k5vxzpxejAkdMsDHewzPy?=
 =?us-ascii?Q?o/+uUaBp0UwwXps7aIWLUeSDCjaQwUqk2M9rKLvR3gR2eD+oH4uSeShtjmsW?=
 =?us-ascii?Q?qyZMronNRb6WHaANJ514Ns1PrYUG3SXUM0wkwId6nWD17G6sTgoHZt2aVruv?=
 =?us-ascii?Q?PEZQjQhuxF4V1uEfWPWIZc//ZC4EoGseENAHsw2mxGZ2E7z0YEEe1JEIXTRe?=
 =?us-ascii?Q?JBJRR/+rhtU/HIdJL98LOwcr1N3x9gEWF+G1ep0d6Gd3K8C7o1Zl3sXDb9/u?=
 =?us-ascii?Q?K6LGKpuxEenuhlBvoWm62eR4nd4X8GZQZgmRuRm5PuTYsQQWM2C9Dm1Rb12z?=
 =?us-ascii?Q?e0kEvPBnuR+5FeTB8o1lS8PIX8SApK4YU/adCkaDIcDjQcs0yUn10jlbFxwS?=
 =?us-ascii?Q?XyWRFyK2gGaABFpmiwvKbVX4Hx07//xkSFOvtAdS3snYYhLeF+BbpMjsKGST?=
 =?us-ascii?Q?LhDPAM6Zjc/mvcvBnvRElJT+bglLEqUXuALa0D+SGUUtEMbwJJ++NFQ71Hyw?=
 =?us-ascii?Q?pIh2uhCb1YkFljgRkRRlRqIfeOJtvjbI5OXJQjp8Kdh6fQNkKcDt8sAtL7uw?=
 =?us-ascii?Q?nmiTaOhy21D9D/uw4t6C/Au+84zIdO/TJAi/ap7cE+ZDxVZYb99/Z/kFWK0e?=
 =?us-ascii?Q?meHweSXt0mLcNQcSuYgaF3WH7G1oToP0RR5cDRC4ie0s6akGEosaYMBDUNmI?=
 =?us-ascii?Q?OS8K92Asazb74ctqfHk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 18:33:23.2858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc68c06-4144-4de3-b3d7-08de1c99cd63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Wed, Nov 05, 2025 at 02:10:49PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 05, 2025 at 06:25:05PM +0100, Eric Auger wrote:
> > if the guest doorbell address is wrong because not properly translated,
> > vgic_msi_to_its() will fail to identify the ITS to inject the MSI in.
> > See kernel kvm/vgic/vgic-its.c vgic_msi_to_its and
> > vgic_its_inject_msi
> 
> Which has been exactly my point to Nicolin. There is no way to
> "properly translate" the vMSI address in a HW accelerated SMMU
> emulation.

Hmm, I still can't connect the dots here. QEMU knows where the
guest CD table is to get the stage-1 translation table to walk
through. We could choose to not let it walk through. Yet, why?

Asking this to know what we should justify for the patch in a
different direction.

> The vMSI address must only be used for some future non-RMR HW only
> path.
> 
> To keep this flow working qemu must ignore the IOVA from the guest and
> always replace it with its own idea of what the correct ITS address is
> for KVM to work. It means we don't correctly emulate guest
> misconfiguration of the MSI address.

That is something alternative in my mind, to simplify things,
especially we are having a discussion, on the other side, for
selecting a correct (QEMU) address space depending on whether
vIOMMU needs a stage-1 translation or not. This MSI translate
thing makes the whole narrative more complicated indeed.

We could use a different PCI op to forward the vITS physical
address to KVM layer bypassing the translation pathway.

Thanks
Nicolin

