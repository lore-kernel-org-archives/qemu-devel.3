Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65049CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIOI-0005rc-2z; Tue, 04 Nov 2025 09:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGIOC-0005ql-Hk; Tue, 04 Nov 2025 09:52:04 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGIOA-0005K4-SZ; Tue, 04 Nov 2025 09:52:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nh+L88nTYvb43EkAY1J/LLWupYJeDZDht00k6b8XlM8umNCPMUGFkFEBv79AjdARY9liRk5lIa7tmyT898xB8mRgkPp5wiSbQ/Vvs2Y5CO3oJKto/D6VvTy+j67ORD+AbCe8fKSheijPfVZYHqvmQHsQQs/mkItp9W7w2TW4pSAEnae0sdvIM74N+lf2kdrnrPtuZtr3echy+5rmX6PUkZGH400+l8hscBM3NEsDr2A4cDaN6W7NdZgxAyClQNaV2Vi9EWd6An+qYFGBNbM1I8GplzzfpHs48BPRD6aTuGX/YbY7TtkolruTvE7phTWg0RzaLJPre6HORfeQeIhnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp5Ev06hvoZFtGWr+k6MJNkMcZ57O9Uv6SF+4sZAiRQ=;
 b=LDPylh61rgTNDMW+D/Sgkt3CY1R1Z1YXZALlyJJG9qU/QY8USKSmr277+9LEGPCpGn8gjmTKg4ImY2JXUkclNd+0cUtGdeGWgAwaW1ujAPgMUPUWcCFW8dXW/9SoPFxQuHEJXYMT4GhRcazxNprpjOpRuo8+t2Ef4fzZ8MVOIngY8OlGzQEfAUJROhU1Wj7RZRTE1vNk6YTehlAy0O+9OUWiyrFrBtul2KIlvOm9xDXqBB5KOMG1TrRCVAgmRl3ovbNdHjFv7nxYnH4uiZ4jn2yM/28Os6EcdglyZ2hvG0B9bw0HI6zdED9ML5c7a8R+hLLWHC1aWjtMfsX07wTgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp5Ev06hvoZFtGWr+k6MJNkMcZ57O9Uv6SF+4sZAiRQ=;
 b=ArqsjUS2tC+KLTeFeBxynW4horRh308/r5LCWwqjI9V5jhqn7a1foNWKlr9a195OnW5PDkjmL1AzdEywzHp+Y3GrmhO3PDORLkF8qhctldc4C2qTQxQSIiwR5Vl34+ibLfONPndwpfJiktGSyrwH15gnrp6YIiRr5by4VJ8mQoi8nVeXrqEjw3eFRMxgipMheVjKkWTfDPdoPni7IFp3ZLgh9yBWALk0HI3jG5l0qSgUGbRDdW8SiTCmzT9vcVDC3cmLChwdA3kWLFiXZqDMwKkNcO0lgIhzfkTx9QwPG2IKE6Dm2PkVIM8S84m316btJP5O3hiYqUFE9zoZyvLyDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:51:58 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 14:51:57 +0000
Date: Tue, 4 Nov 2025 10:51:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
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
Message-ID: <20251104145157.GF1537560@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <20251104142052.GD1537560@nvidia.com>
 <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-ClientProxiedBy: BN0PR04CA0136.namprd04.prod.outlook.com
 (2603:10b6:408:ed::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: c99256e4-d024-43d5-b800-08de1bb1b413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t0Sa5Gxge1ZUtbwh8yVlVbjZ0uwLOy2J6P//2p/SfUTuNqMRfmA3UZ5mJXsO?=
 =?us-ascii?Q?VzxkFo4z2GcOHRqYwTZz9PU01UdWg4E0XlUvtlhREG0leGZzpbr+GuJnpqdK?=
 =?us-ascii?Q?xzM+SasxdpGFwDEryS4PZs+ISTMdtCRsFayx108CHeWJfe+zu3Gk9l5vC7gP?=
 =?us-ascii?Q?ED44KK/FUKZ3P/lIN5rUqUjHL7HeyjQ/0y7pjhcppluO8LWsCYtdasKy52rf?=
 =?us-ascii?Q?rPVbYNkffVFX0kI/Cguv6V7L8c3EXyfOGzE+xwufoqlppulyOHWJfiORYpIF?=
 =?us-ascii?Q?MxrS8HzjWeeJxpYqLTfYmBgef9a3lUWDAA8rDYguNOTNOU0N7s4qDlowmpZ/?=
 =?us-ascii?Q?yUd/bAUUtIV+48fDxRfiYlJYJa8D95ZYdT5sIVQ1YeDO0owranuze/HYcqTl?=
 =?us-ascii?Q?e6HwmEXmAByjv5e5p5ABqYYAkB6PEh9dFDDje01h6QJo5eG7mHqL0iMeFWrF?=
 =?us-ascii?Q?y2L9HQTBloUtMIuOI/aBXX1vKBD9WYIlKpyYrrqwCTdrktAUv0sz73IKc1Iu?=
 =?us-ascii?Q?eS5DC0GA+EViWOGv+O5pV+MGEvRj9iB0jFd38axt+1+O2Vc49QhaElLvaW69?=
 =?us-ascii?Q?TzU8E5qqRusl3qwIbdazMulW6FHuZcWMY967sDSIcmDkM+JuP0eKw+b0BxRV?=
 =?us-ascii?Q?xbhb+cF05akwm+X4OvPIAdt2uvh7XRA81xlBGCJbo4RAw08h8WGo8JuRVNAP?=
 =?us-ascii?Q?6Ng/zU5MWIsY77HNV7vVuDkzYcsSGQajkxnCGr5paYCA4jHRGHGTaUXxzQOg?=
 =?us-ascii?Q?OjrIY+GXallviOu9fIWrZkCB2qvzwtuKvwlbnP82AATvm9y2Egt4cWVdSlLm?=
 =?us-ascii?Q?RKHh1AxzCokpAk0S9r1ahQtoa+ZkU13FdTz32bNN6GfYx5ra/6hUnCYQU+6U?=
 =?us-ascii?Q?/Gqz3XLcUX2xG/nLGVTeJwMXQu2y5ts6U9WkgSq06FDSe48QQHlwFS0zGimF?=
 =?us-ascii?Q?ZjhLMYDHDgE9sIRTSIJRDCg1sWByP1bV3yQgRrfgGQdqpcUqGyr2klC8QJ4f?=
 =?us-ascii?Q?0XPcuE1Ta6d4KCWLgutHhmPELVWZW1/5EPCZGLckyZCNXwjCjyboPshDNAZ3?=
 =?us-ascii?Q?NUYSE3isuoPxSeJNUc0DRpLk2ZvPEwSrpNGnFy6ilKkosltFH23Ds+ptzH9M?=
 =?us-ascii?Q?WmyB7RKpuJUUqROO4BdXlST4z7Zdj7aWRW+ZfheJci+G5GRsvw9RzMOBP93+?=
 =?us-ascii?Q?eCYpHLKavkj24Ek28JGbCPSyjznsrl0gKKGD/QPfKO6QuspfMjHbAkHV0/au?=
 =?us-ascii?Q?nPQak2g1EXSLKsRAgAQaWOwkBwN5mEZH55nVBY8E+NBNqiwuyd0Ws3K3EXwF?=
 =?us-ascii?Q?1NUDjxnq+jn6Et9BNBoUAoqvURdzQJP74t59h2wGcniU15U2f3nASxH0QPsO?=
 =?us-ascii?Q?YzAfQ/UM+PVR/jg31mYrJ30zABO0sB/z2NvxZUps0M/IdL4cpNgmQwoP6VUn?=
 =?us-ascii?Q?gBUqRlJTy75ZWByWcWVuJZc94eP89JL6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yJuNXiDx/TVnvP9e9hQ6lb7H2jJr9BZZ73Swnf0zyAAbm6gyHWlcnrUIstAt?=
 =?us-ascii?Q?Q43by4VMwxWbP3rurEAsXuiJHP78G4IH9110PnL3NcAHegQW1wQnopZSxg6z?=
 =?us-ascii?Q?DmSEpkbzR7A/78s6oAUcHk5TDhjga+0AlzfG0GMwyY0uCtUqrq5KiH66XR/l?=
 =?us-ascii?Q?fqO54AKF8N47cuSGXzbO5EfS+fAkehc4d3HixqXwtt2CaEZNfJLTwlFMZa9V?=
 =?us-ascii?Q?qc2ZEzU+b8WLae/AS0NBxTIPPkPgEvCvHUBwkUbSP5cqIwwGQEBqkuGG/v1v?=
 =?us-ascii?Q?shQi4wBQFlVqOGkXYyX05bDJ2oXuTUWIKr9CCnH4wABcWjAVMc/aU4ExdJ3y?=
 =?us-ascii?Q?8iSjIwmlgwTRF5MkiMLSZ4eneoq/8idhOjRn9M/vsslTvLYpN5HnKVat/DHK?=
 =?us-ascii?Q?kMt7M9y0kUAUZS0CWl12/WVHkBLJAeTNdGC1HbrhV9JB0AXi/ycthkw3j87U?=
 =?us-ascii?Q?1MURY/CpcxLcuuyj5KF2R1GkAfaiwlyQw3eJM9E+oi6VBwZbgmetcsGQHl/P?=
 =?us-ascii?Q?DsQMfRCI0qvtlP+e4ngZ/MFZqx+d/goPL6tSNgtyAOK/jQHNZYx31AxaoQE8?=
 =?us-ascii?Q?9OozymPmgtlylgu+jwEJ15ec50vLog5AIpYZ5Typwijm26hC312+CY6siSf5?=
 =?us-ascii?Q?nSGy4xPA/2YfksAvS33X5Bv5l+KbnBH7wribGYJzyvUGu305ccpSzrGwMT87?=
 =?us-ascii?Q?uZn8zTSNtf8nV79jv6/fYX1EI7MoHdnT80XZZwvHWqrdlIIdnq/+IQoZF+29?=
 =?us-ascii?Q?zY8IudEmS0iKjw4s84oiaq08TkkvQERxAn8InP6ZebhSDvvz0LpjzPfBOxtP?=
 =?us-ascii?Q?aCjSa9XpMGRB5k4dmkMlLiy+d47DUMvB2Y35iUc3T56TJEykossTrVNAwd1R?=
 =?us-ascii?Q?eHSwOsA4A2hv+F9iO3xuW15SAdQn+sRpSwPGZRTaaSCPoDNewRNMDX/6Fz3X?=
 =?us-ascii?Q?RwJ0AZUFElCF7Cw3Di4iDEl6+cqlSTAMCMkUrXxy8xTvm8Mk1qZvZKex51/i?=
 =?us-ascii?Q?oTXZmFnDEUECX6CC6mIp/je4/UAMGi7UY6qx8WC/Pd5pKoXeaApwZq/lpA12?=
 =?us-ascii?Q?Ecz5x9OXVxETr3K0YX81zf5IePUyG599QJkISZHJ4clVxMOkUMbbjiCBIO7S?=
 =?us-ascii?Q?+VQXTa0CKh+5YTTvAhhhllktmrhtlMkYYTG3cyGowUWRQW2L4Oa43+B7bsrG?=
 =?us-ascii?Q?sb659pFUbRWF5xFlHAUcUipg9l1fh1e/vYzIGmk85E/OAhVIKLyElV6d8mJ+?=
 =?us-ascii?Q?U9btOvkMujImv+YVHFG3W4WyA4rpqWnym2jZCwHVk+bDmvlRewC/hrpn2fOl?=
 =?us-ascii?Q?oL6O5aWv+UYRiT5p6nhGNDIGuoIpuUDClF1LuhWXmd0bdytqVJIWhRVUbt1K?=
 =?us-ascii?Q?HHyziTt8rdv/5Aqj8TYE0i6tySEFfSSL/STHeZlRpL4fslRPBYP4OTUwbDLA?=
 =?us-ascii?Q?WE2dXtUDSMfsSIalb4GQ57xZ28H568/fhJVtmdZdvxZbWp8Reqnpz8WGQJ8i?=
 =?us-ascii?Q?qtyCT/QBU8bTY4qkNlw03S2aCEWbWNZwxZHnT/ONWaT4Ux41dIyE7hrWgvbu?=
 =?us-ascii?Q?Ko4ASPAQxsFOKfGybQ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99256e4-d024-43d5-b800-08de1bb1b413
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:51:57.8816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCSIEuPL9D4U1GuNn7PHFPXWEBXXlgf5kKEob5UbWw8mTmSIxCbMTOLTriAVKzov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=jgg@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 02:42:57PM +0000, Shameer Kolothum wrote:
> > On Tue, Nov 04, 2025 at 03:11:55PM +0100, Eric Auger wrote:
> > > > However, QEMU/KVM also calls this callback when resolving
> > > > MSI doorbells:
> > > >
> > > >   kvm_irqchip_add_msi_route()
> > > >     kvm_arch_fixup_msi_route()
> > > >       pci_device_iommu_address_space()
> > > >         get_address_space()
> > > >
> > > > VFIO device in the guest with a SMMUv3 is programmed with a gIOVA for
> > > > MSI doorbell. This gIOVA can't be used to setup the MSI doorbell
> > > > directly. This needs to be translated to vITS gPA. In order to do the
> > > > doorbell transalation it needs IOMMU address space.
> > 
> > Why does qemu do anything with the msi address? It is opaque and qemu
> > cannot determine anything meaningful from it. I expect it to ignore it?
> 
> I am afraid not. Guest MSI table write gets trapped and it then configures the 
> doorbell( this is where this patch comes handy) and sets up the KVM 
> routing etc.

Sure it is trapped, but nothing should be looking at the MSI address
from the guest, it is meaningless and wrong information. Just ignore
it.

Jason

