Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C89C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 19:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfP9b-0005xU-SI; Wed, 28 Feb 2024 13:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rfP9a-0005wu-FP
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:59:42 -0500
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:200a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rfP9X-0002hb-Le
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:59:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKKffKVFoFNfkK8yShRZy5bFmSYyW8pdubLgocFHZIPy1+fX+MPgtOwCwlaepvn7RpacbP9NDkrmBLnrK8O3qKYhTMTHCrB32T8lzsnHz1sxK44uZh5dJi2KftJiibtLlrBEK3hbvdGgomAxc0UguD+TM7eX+0fqGdQQo8KJjck12FJGtmh+AbN71jPWX4NHJqH8Sn/oD35QMHqJoopr1Z43PgHlAAO2SreFzbWZNQEiRhJoz9cnZOZuBmt37sVE0hTQGttTxZpHC1G21aHHsXJVvlntLxrIGWR61lPinjlsePOBihYB0h5LP/CFyCkO4VeSroBQXR8B159xYJiwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3KiCCq+LtiSG68Rjj84XQX3n29XZIN+b32wu3mEfOM=;
 b=Cjm5eTOKs8M/jx32SrZMzpAn2/r7/IpARDuN8Ot5t9bKPvtvoqwEfyEQuSsv70Y/KTiqX652N5GbsLo2rN7N2eg+gtRMeyQQTCel2CDA4Dgqy7IjMxGd14pcM1H1uyWR94aS3tri7EuPBiZiFCyDfsIbwdOo58rHUsAa/HVlKwSARmSa40w5XB1BH483GJvhV1vT0Z6Vn1m4Kwu20dLibg6trQM5TGghlI8U5B6KyDE01d+iXuJob0nXYbXcB3qm2slAfjk31BuR0zdrfRbCHbV2H+s7AHasyByi4/xvUfW25fP41IiO1sM9M91X21M/zy/2/1UFLz7nvBWoLUxjxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3KiCCq+LtiSG68Rjj84XQX3n29XZIN+b32wu3mEfOM=;
 b=Ac1ksgsenY5+15wiK3lJiegT4zHPnA2Tv6ms++fRlBIkbUO4biIMLCeNo6ZFW1H3QpVJ0vI0CdjHm6pTR6vPatPLF3MkGYIZdRFqppJX2aRQqey2iix/Cg7+Pdwu14bSYHDUZJBTG0MlRoA/5Z2DImXOeGTdSiMM1ABSUccnSgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 18:59:35 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::312:3543:c506:3207]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::312:3543:c506:3207%6]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 18:59:35 +0000
Date: Wed, 28 Feb 2024 10:59:32 -0800
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com
Subject: Re: [QEMU][PATCH v3 0/7] Xen: support grant mappings.
Message-ID: <Zd-ClG4RSAzfli50@amd.com>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <9kisd.h00guzdfowp4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9kisd.h00guzdfowp4@linaro.org>
X-ClientProxiedBy: BYAPR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::28) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|DM6PR12MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: eceb5790-96ab-4069-b598-08dc388f67b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohyWh76bXAWQ7IdrEA0zjbXhFzI2DRWTczcNnc26oJBNfuR+OuxFIFmctlVq3kte7IWLNJCeDpweCD5fyXyHVyUytKPVbsPkm+HgA51g98bR073h5tzPZoc1jxBg4yxAZDgK2nK8zlAp53g8cLRjsy41P27raEgF0BpBuD/DMpAfHWXJIa83q4CNENn/TcuZZa6JK2jr+JlVVW5ySlMvrZR14g+IQk/caG/7huaCVgmR+eLLbHZNP9NipAl2okzTj9O6bYNsLkM0u1KNrzkWVhllmQOiyqLTjvA1IwQfswTjPmImPTkASC+I7qpS+zgd7H++JXDKbd59SVF3bSloeTB9tCf/rmyRWxthT5ApYH4ouUB0mOcZ3D5H9SgogtMEBitM/Q/md5+QKb37hWVjZ/wFlx3uOK7PeTfW+VV2Ee3cSOrXV6dRXkGohbWts8pi248eQlu/GDHGSEBtCJn1FNgrJgjT8LYYuTUD0PIESLWFZ+CQtrevLq5lekE/CytwPHw0ycp34Y1ISDMaz3VR/pmFzHILDEuZ8BIqgqmE7iYHwoKsXWlGkNn5/LLT8pkaWGdWW6IF7HH2EbHBm5F9YMRniiPJeXTWuAR2JTwCwB1tnoh/KcqbaFFQxNOdD+mx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXJhdEVocC9FWkg4Vmhoc0Y3U3ZHZEY4dk5JVmYvNWFQb0Y4aGxwd1JXazV1?=
 =?utf-8?B?aDZ1S2phM0R5ZERCcHVaMVRQNDFWZm9mRmNTd0ZuWFNqQmNVVFlnOW9TY1lT?=
 =?utf-8?B?Z3o2Yy9ydW1zKy90ZWttWUdtRkNveVJmTHY4R2xPV0d5eWVwT3R4SEFxUGI5?=
 =?utf-8?B?a2pqbXZOeldLWWlkc3FBWjlFcjByWml5bzJhdXppbE5hMXhVOGJ1WW91bVBO?=
 =?utf-8?B?ZFJLYmpIamlLcEdNUlQ1bHdjSDhsOE1Bd1JYejd3SlZHTmJRdGw2RFVHcGhq?=
 =?utf-8?B?dkFmYXNkTmFpSU1kWllJaFJsV21NK3JRbEtQTFhucmhpUUdCUDFoMitmcWJO?=
 =?utf-8?B?b1h6UVBRQmw5TEZuK01RK1Q2OEl0QTdlREZWdkw4YklaeVFuMjh2cHhHTlEv?=
 =?utf-8?B?em1BYnhndjJTR09hWDFNVFJkSVdIR1B1eFcyT09GcG9ScWRwZW45LzJOYWlv?=
 =?utf-8?B?eUkzVTZMM2N6QmlmZlNuQ0dTamxCQW90WXlzRGI3VWJyRTdzNEh4bno2eG12?=
 =?utf-8?B?bVNtS0UxUThScGZHSk1MV2F0SDZKajd0VUVjdGdrdWYrTEQzNWpUSXhGY3RB?=
 =?utf-8?B?R2trSzhjRmhKa2NMZlNqVHE3R3ZHNDV1UW45d3NuT2xhc01tZnd0cklhUnlV?=
 =?utf-8?B?ZEJIalpWUTZOMmlPL1NvWDM5Q295VHFrSUhhaG5rM3RQc3dXcit3OUptc3I1?=
 =?utf-8?B?aHNWd2dlOGV2bmcrYTMzR25oR1k0djJ6UWZwNGdlTXBva3FCYnM3R3VsTW1M?=
 =?utf-8?B?cXZ3TmliVUdCZlBiNmNTZWV2eGYybkFwR25ZSHBva2RjYWp4aW9GeU1TcnlO?=
 =?utf-8?B?d29VVVRvZ2hvWkRnQnB2VkErc2prT2xiT3RFUSttNnVDRkdIZG8wZHZjNHJT?=
 =?utf-8?B?eWhzZWhyU1U2SUZRTmRaYmc4bkNaN0NGRFRvNG1tUUxmUThqeGRnOWhQdml3?=
 =?utf-8?B?M3ZsTVVlVXFyYmhXbENrdU1SRjdrRUZTczBLbEt2NVFoTjhROEpyK0V4K1Jh?=
 =?utf-8?B?aEZZN3kzdEhHMVFuQmNtWWRsVjVFamxHYlRzVmlEdlBFMnRGYjh3cnVlb0ND?=
 =?utf-8?B?WjZKZElWY2I0Q09YZFkzZWM1NmgzdVpZZXdKZW5JZDd3Sklud2hiU29pc08x?=
 =?utf-8?B?L2dWd3NDRndSM0JQbklnTUJOMjY2cXAwTTZNVEkwUVpZNmZQL2tYN01uZTdi?=
 =?utf-8?B?dDlsd255aGVnL1BuYTA0OU5pc01OaWd2RjA2eVVoRDU3Qlo5bFJLNlhXQXNC?=
 =?utf-8?B?dzZQRHVpdUowOWZuUThZZ0lkR2lNRVlFS25IV0trZjNUUm1La0Jva3M5VkJV?=
 =?utf-8?B?ODdqaEkvQ3FvZFNXUnp3c1dyZkd5Y0RBeWhEVDJNa2FHc0p2ek1haFZtekd1?=
 =?utf-8?B?RTNXa2JzVkVCTnJzaWdDUXJ0TlA5WXU4S1B5YmRiQ3pONzA0RWtiNUZ1K0Q1?=
 =?utf-8?B?eWYzVHB1UENhOVlBODZyVUJ0THVSdGZrWVdyR0t0cWR3cWxyWTZ6MzhTcEx2?=
 =?utf-8?B?R0dUaE1WbFdUZ1FXTlNHTnp4QnJXbEFBQWFtcTIycjhpSldDRDJRb3FwY3hP?=
 =?utf-8?B?b1Z6MmtHdFUwaGNOK2NCL0l5TTJlNnQ1M3Jmb0c2T1l6dURsbnFkYTIvSmxx?=
 =?utf-8?B?UHF0dzR1a2tkcWNJdENZeUlTaUtKTWZ1M2lQcDdMM25McVdwaTAvVjR6U2xD?=
 =?utf-8?B?S3JRcDJoV1Zhd3hzUCtZZ0NjRHhQQ2U0Y1BiVU9NWjZTK3JMOG5RZE8wRktG?=
 =?utf-8?B?c212ajRHem91RDFOV3NLMTlTNFY1OEdUQ3RvZ3BuazhlbmJmbHNyaUNZN05x?=
 =?utf-8?B?OWswTk5VNSt5R1FxUGt0VmNoTjFZRWN6Y0N4YnhVY0o1S2NCaXQxZFhOVnJL?=
 =?utf-8?B?NkRNc0dZc3U4Z05SYXgwU0gzWC9IR0lPQk1qRVZRUlJLZmNwaVdKR25WeElQ?=
 =?utf-8?B?Tnd5Z1VOdjVEQzBjcittVndxOWR6YUVNV1JMWTUzdnhwVUdtSklXY2k3allw?=
 =?utf-8?B?SkxsVzVtMm5PTXFEbC9GNEt3UEEvMzJtV0NoeXdycFZORDNPbGVLQUM0M3JE?=
 =?utf-8?B?VU51Nnc2RFdIU0VnQTV1Q09sbmQvSUZQL2d3dENaZXZlSlk0ekVsSENNYll5?=
 =?utf-8?Q?UWgsz1oGV18WnNuJcEg8CCnHL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eceb5790-96ab-4069-b598-08dc388f67b1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:59:35.3142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 663GQUJ58cIZI35KFFIylmEGnYiuQzD7vxQms6vJCjaGgGZFOkqg7rzKLHryQeOFFxPPxGSUidqeRhkLHLhfpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
Received-SPF: softfail client-ip=2a01:111:f403:200a::600;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi Manos,
On Wed, Feb 28, 2024 at 03:27:12PM +0200, Manos Pitsidianakis wrote:
> Hello Vikram,
> 
> Series doesn't apply on master. Can you rebase and also provide a
> base-commit with --base=<COMMIT_SHA> when you use git-format-patch? This
> will help git rebase if there are any conflicts found locally.
I rebased it with latest master and it works fine. Series is based on following
commit: bfe8020c814a30479a4241aaa78b63960655962b.

For v4, I will send a version with base-commit id.

Can you please share what is base-commit id on your side?

Thanks!
> 
> Thanks,
> 
> On Wed, 28 Feb 2024 00:34, Vikram Garhwal <vikram.garhwal@amd.com> wrote:
> > Hi,
> > This patch series add support for grant mappings as a pseudo RAM region for Xen.
> > 
> > Enabling grant mappings patches(first 6) are written by Juergen in 2021.
> > 
> > QEMU Virtio device provides an emulated backends for Virtio frontned devices
> > in Xen.
> > Please set "iommu_platform=on" option when invoking QEMU. As this will set
> > VIRTIO_F_ACCESS_PLATFORM feature which will be used by virtio frontend in Xen
> > to know whether backend supports grants or not.
> > 
> > Changelog:
> > v2->v3:
> >    Drop patch 1/7. This was done because device unplug is an x86-only case.
> >    Add missing qemu_mutex_unlock() before return.
> > v1->v2:
> >    Split patch 2/7 to keep phymem.c changes in a separate.
> >    In patch "xen: add map and unmap callbacks for grant" add check for total
> >        allowed grant < XEN_MAX_VIRTIO_GRANTS.
> >    Fix formatting issues and re-based with master latest.
> > 
> > Regards,
> > Vikram
> > 
> > Juergen Gross (5):
> >  xen: add pseudo RAM region for grant mappings
> >  softmmu: let qemu_map_ram_ptr() use qemu_ram_ptr_length()
> >  xen: let xen_ram_addr_from_mapcache() return -1 in case of not found
> >    entry
> >  memory: add MemoryRegion map and unmap callbacks
> >  xen: add map and unmap callbacks for grant region
> > 
> > Vikram Garhwal (2):
> >  softmmu: physmem: Split ram_block_add()
> >  hw: arm: Add grant mapping.
> > 
> > hw/arm/xen_arm.c                |   3 +
> > hw/i386/xen/xen-hvm.c           |   3 +
> > hw/xen/xen-hvm-common.c         |   4 +-
> > hw/xen/xen-mapcache.c           | 214 ++++++++++++++++++++++++++++++--
> > include/exec/memory.h           |  21 ++++
> > include/exec/ram_addr.h         |   1 +
> > include/hw/xen/xen-hvm-common.h |   2 +
> > include/hw/xen/xen_pvdev.h      |   3 +
> > include/sysemu/xen-mapcache.h   |   3 +
> > system/physmem.c                | 179 +++++++++++++++-----------
> > 10 files changed, 351 insertions(+), 82 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 
> > 

