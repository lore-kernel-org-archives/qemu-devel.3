Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAE4C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 16:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLmey-00059b-7K; Mon, 24 Jun 2024 12:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sLmen-00056v-KA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 12:35:11 -0400
Received: from mail-co1nam11on2080.outbound.protection.outlook.com
 ([40.107.220.80] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sLmeh-0004aj-FR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 12:35:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzjVjWfTJK/WIyfO9J+U6vvAWJvAspr7iYF+SVNw7ZBqMHlhGrLEK+2xo8PdcmRqAf5+5hJrNEccW43nVxgZRrUujuJDXG5pFqLekKADF0we1TdXvzbA93M6wPvHkishG3YGMdG3RqazHQBtRAATOFUzBvOI7R0lRwSNKkppwus4g2ObxJZQArGqVR7Z5bi/ODGqWDUpaacEWnKYDXN13QvdpszVmzeaWycPyAaVarniyE7xhVaDS0g3BNI9zMF5NvyH7XFfzo0XEpd276y/3R86bx8lhLTLH+VdU/WJn+cLaK+kMLSqOrP9M0sMgec79bOi9CMLeHVZo3OMv2orew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCZmusuIm8XxQ7qIp+3Rc9oTb48al0yiEspASq55Bck=;
 b=A/yYJyzS7vaMyFn+xWwvkZeHAXkzeyHsSTAPJbgZpvNDapzoyURPLvYPFFpjv4G/y0yK/EGSAKV9yKhxDpFYq/l327Xn0P/x5XEzrRa4o4N9kwjPYiCIxTKxET/uX1OoaKkCqSo/H1cyuEJBlDKOFOcqIcuomhQirURc9S82WHy+FjJ5ShKaRLe2B1G4/0fFnG5UzfpAJpZuymMs0oEj/0uQnTDDjEe+tmegUGZVWMtfyvQqtvw3quTZM6l5y+eWnAfyFvDrvA0hoBa2Z4+riqncRnm92FimHGNoCymkKz5hc97Ng0lvbELu9DooO1ZYJpjp8HdTOWS8YyqFsk7Edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCZmusuIm8XxQ7qIp+3Rc9oTb48al0yiEspASq55Bck=;
 b=0PVQKXIrqmG7747d1NUO76D376J4JtBFaK7V+txbNHFVeNAzKaD4TzcOP/8QnVRK0NsGfVMxCDOYbbbPcxKT5db6qGIu2yrOfyZ37L3h4abzTJZ6BO1+YldmUaLrXzzYiFlNBYeGO2hVWZKHXuzDQCqcBhf/qBnWirzcdOZPDSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 16:29:47 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 16:29:47 +0000
Date: Mon, 24 Jun 2024 11:29:43 -0500
From: John Allen <john.allen@amd.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, William Roche <william.roche@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PULL 39/42] i386: Add support for SUCCOR feature
Message-ID: <Znme94BaC+ouse4d@AUS-L1-JOHALLEN.amd.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
 <20240608083415.2769160-40-pbonzini@redhat.com>
 <c54d5f72-ecfd-46e0-baf9-324fdedd2ed3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54d5f72-ecfd-46e0-baf9-324fdedd2ed3@intel.com>
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 43db7e26-f301-45e8-2677-08dc946adcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XOIHP6v78k/SWW3JOD9ZcnIsvxEIgC0LgLG3N671jOxR/o9xG7OaTHfGyBqe?=
 =?us-ascii?Q?9EfaLbOm33T899QwicCVHEKKB7JJEuS5Bh/7Dz29DLBuqdUDBd5gO3NxgmYz?=
 =?us-ascii?Q?kYlrNL2iohQ73fFXkx/0R98iW9/numJiEJK3fxv1TIAKsA4DbRpBVdGFYVNS?=
 =?us-ascii?Q?v0s3Zv/PccaUEUb17LpCraNzl4y3xSkwn0eX+YLEk3g0EDWycKQ+d65+0HVA?=
 =?us-ascii?Q?bln8xBmOtucS7i0yQ8+X6kW86WI9lY5gPAlpydW7etXKTxXUelW8FetfQNIk?=
 =?us-ascii?Q?0H6XRAhie9g2GNOFQzDeMQGTSPlCE/zR+jB3gb9b4KjgLriNkNnzVVoZhhf5?=
 =?us-ascii?Q?mLKN2uFCGsZ5SaiVVB50hCLdCcJISV5jD0idUnAb02VAzmbHW8S7yMS8i5A8?=
 =?us-ascii?Q?VlyI+QuY2OJHdB/AK3ko+tUL1Ut2RPCmPSh4/KOncK6/+ig262mWN8zLVyRO?=
 =?us-ascii?Q?wKGdVRD1sd/m/Ypdtsxw1xLk5KyNdf8dEp2pmzAdPwfIeh+GiAa4sd7GHsip?=
 =?us-ascii?Q?TR4BSe/Gwn0qgQJ0Ul2N8DY7vX/dM+dLd8by960ifKCPs3UmeIhdXC2kEs6x?=
 =?us-ascii?Q?gPo0Wk0NAOLZijNr9cDEK8lukCUsevBhZxD4fWlmzRUWHA3GjK+lofDh7JKH?=
 =?us-ascii?Q?6ixDMRbXLHmsNM2DHXumietP/9F3qtC2Bfd6I1jyfOz8QhWF7Pw5f9pVEDjI?=
 =?us-ascii?Q?+by9Rbj2rMhhXJ24fWeeQUrEJtwnMvJA1yKz8oocORB41Nwoih26fmTjvWxH?=
 =?us-ascii?Q?gQqZdzXx9VWWhC3c3TYeN95wAnjNa27s9WL/MXdVuutjmCapILVTSCWMCsTq?=
 =?us-ascii?Q?D/frHsMkh0pXEB1KfuYlyyqvtE3DFFpTD43aCnyKIA8OYGW/Th3Bfz6bClpn?=
 =?us-ascii?Q?tWSyX1IdSFehub1jjkG31jwe/kuokCKzTziWRtq9mvnV1lla9Eq/+1Ln6SbV?=
 =?us-ascii?Q?8n99rOKviZ9iSfvfDPnEAJBPSRxdStNWZvtR/n2EkS3vE/HUlGQVEtO4nVq8?=
 =?us-ascii?Q?LwPmBabG45hhWGRxCZEvWlANYqGzNrJsby++XhFRaSeJvF+RfGTCWWZoFqWZ?=
 =?us-ascii?Q?YQ9H6ZV4mzx9KG0599buTZyHrYSNJ/Noh8aSvOLtFCTBGGXW8yheusvrb3uu?=
 =?us-ascii?Q?zwastFgIhzSUp17NGF6h5d/Xr4WdNcx//ZGEE8ZtojnBWR3c7UbxoXBhi2Kz?=
 =?us-ascii?Q?rfZ2CNleuxedU/Bdgbh8EUEsGF6YAx0SdnQgDo1qW9y6w4zKqEIdXzxKNcBv?=
 =?us-ascii?Q?Fy0SeAtMpw9A3OJUe2Z2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5995.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qp/4iZBfaas9o5SrZYd3InsOCDxwP6zPG4ffxHxROuafgGByEe50NzdgArtL?=
 =?us-ascii?Q?aJ7x6X4gge+QZxfqNDFaCRDtHs9riAvIs7ECSuTtaSJlQydP3SJ/sjBYMU3/?=
 =?us-ascii?Q?xur+yBsRcInCmzhb5G5eyzK56usuLIgKs2im1EzDIaPXr6j8S6BXYfuiH2W+?=
 =?us-ascii?Q?JeGE0yl/IKqTdGvSRGee1OaItXt288KwKr1+ZSnC+OcrSTHGOJZjQ5ibPotZ?=
 =?us-ascii?Q?bIIAPje36oh7BXUpjhE1VEGyC9a2W9ew14Lgg5tfeC2zDcWiq0R2sqlUXIG2?=
 =?us-ascii?Q?1Oio96Q8vxH2VkZ2W4HzDH6LyNB3PNVxr1sBrinMp2Tdw8Q6ZqOCVLIyUBfI?=
 =?us-ascii?Q?AosKxvAProDgjEldH9I1Uek5axf4zw/wOuLmAYtxN8D8PTRfXNdXsvG5+CLa?=
 =?us-ascii?Q?K/M/cxd2aeKd6r2DjUutYEwOfwWdA7xIeroGkCf6rvYzJ8XsopshFDKiFWWf?=
 =?us-ascii?Q?NDE83AJWSn0457NQJvoQIYDS6uBfMWq0v8tiV0DU3wo2St0sXDtVrAjTSpDL?=
 =?us-ascii?Q?0ycROMwBDCwSBW8tI/SoZKdOKewMBneU142rQeIVIDJhopYi9xz7uvjJG5lf?=
 =?us-ascii?Q?zgDvXZ99K+S+lqsrN3YkAfHiTl/77WhMOc4JOeRGgMAUrCwgE/3N1I348U5R?=
 =?us-ascii?Q?o+1gnAlyTBmC8T5/fq3JGzm/WXCFy5o4q61OEB7GsKfMHGalzrcg9/9KCmJo?=
 =?us-ascii?Q?QGSQeJG7y0L1PuUH+SqjhP82knlETJhf0Mqt2njPz8p8cTeRuT6JqF/ASEK0?=
 =?us-ascii?Q?4vwRoQV5zoZniRg67BfegX17JrpcPIPlrKrMXqrSaOQ8Duy5MeszxITm/ONs?=
 =?us-ascii?Q?Jq+DPYvc243EP675LGqUn346UlKmbyifArMf0loqGf5LfZNdyAf/+fPUQyod?=
 =?us-ascii?Q?5CX/zdjYNuCpdOrq503ufHlaF2nz635TxVVxAy+mP2Dfx4v9ZzoqmRs9Q4vr?=
 =?us-ascii?Q?LC4b+1IhCBjcwe7c6rYnLsFnlG5Bu6ZdPpvX4JwlJXyIIewqACor4c5wvdrp?=
 =?us-ascii?Q?ekob+ERj3SDkghrTq8YrUSHv0nIg+U8Ho+GUs9Y9jCYXdJa8vTnpQTSZ9YE9?=
 =?us-ascii?Q?apRTbmEtH03neECB2QV8LJzDjRfIEi8Uel+Z9IDp21Wg1JB/eo91aR5nVR59?=
 =?us-ascii?Q?UqSsyO6kVK+PD4+toyXE4xFZuX3z9N3I4JCHHRWj+ie+euhHnpaPb4g/d714?=
 =?us-ascii?Q?u2FPqrSPmPLFkarocKepfwq1IE4RxuMn2dtf+QzaBQ4XglqEaALvo/oaIKji?=
 =?us-ascii?Q?p0VJWeMWWZpO7IrD8LWeUD4ivkn2F2ZG6kIP37sNNOy4qc/hPSvKLSKTenyT?=
 =?us-ascii?Q?abD/naHtl+fYd7svQ6sO5vWEsLG1HuBQiWUuak/jVBDtFpe7xVE/ovX4PGwE?=
 =?us-ascii?Q?L6hol8RlLQJi8wqofqYUB393c8tHPFVh6qh4GFm4xvcUHOUJaznWJt4iQy8Y?=
 =?us-ascii?Q?iAmjNV/kASZAR9runzZq7k5tcayQGnx+N6N86hwyHNh5vU2psh2IqHWhMcxF?=
 =?us-ascii?Q?pY9XIKQQzAQ58hY1vmJVjKJ7Q56GFX8Wr/tnI2X4TvlGCd6g3kZQE56IMn93?=
 =?us-ascii?Q?7dXL85/mW94zlW2J03TN+LNdTbTdqdQRePLdvbrt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43db7e26-f301-45e8-2677-08dc946adcfc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 16:29:47.6890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMVsOtOI43WIYgVjkoLxjacVjnUycayp1F/1W6vSExz5KNcg88UnaiJo++3gyA7YlskAXJIkkQ+ixfPoqiN8KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
Received-SPF: permerror client-ip=40.107.220.80;
 envelope-from=John.Allen@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Jun 13, 2024 at 05:50:08PM +0800, Xiaoyao Li wrote:
> On 6/8/2024 4:34 PM, Paolo Bonzini wrote:
> > From: John Allen <john.allen@amd.com>
> > 
> > Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
> > be exposed to guests to allow them to handle machine check exceptions on AMD
> > hosts.
> > 
> > ----
> > v2:
> >    - Add "succor" feature word.
> >    - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.
> > 
> > Reported-by: William Roche <william.roche@oracle.com>
> > Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> > Signed-off-by: John Allen <john.allen@amd.com>
> > Message-ID: <20240603193622.47156-3-john.allen@amd.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> [snip]
> ...
> 
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index 55a9e8a70cf..56d8e2a89ec 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -532,6 +532,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
> >            */
> >           cpuid_1_edx = kvm_arch_get_supported_cpuid(s, 1, 0, R_EDX);
> >           ret |= cpuid_1_edx & CPUID_EXT2_AMD_ALIASES;
> > +    } else if (function == 0x80000007 && reg == R_EBX) {
> > +        ret |= CPUID_8000_0007_EBX_SUCCOR;
> 
> IMO, this is incorrect.
> 
> Why make it supported unconditionally? Shouldn't there be a KVM patch to
> report it in KVM_GET_SUPPORTED_CPUID?
> 
> If make it supported unconditionally, all VMs boot with "-cpu host/max" will
> see the CPUID bits, even if it is Intel VMs.

Paolo,

This change in kvm_arch_get_supported_cpuid was added based on your
suggestion here:
https://lore.kernel.org/all/d4c1bb9b-8438-ed00-c79d-e8ad2a7e4eed@redhat.com/

Is there something missing from the patch needed to prevent the bits
from being seen on Intel VMs?

I am planning to send a patch early this week to report the bits for KVM
and a patch that removes the above change for qemu. Is there another way
you would prefer to handle it?

Thanks,
John

> 
> 
> >       } else if (function == KVM_CPUID_FEATURES && reg == R_EAX) {
> >           /* kvm_pv_unhalt is reported by GET_SUPPORTED_CPUID, but it can't
> >            * be enabled without the in-kernel irqchip
> 

