Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EDBC7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYbI-0003k0-MS; Tue, 17 Jun 2025 11:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1uRYLL-0001Fx-Jp
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:35:24 -0400
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com
 ([40.107.236.77] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1uRVdp-00030A-2x
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 08:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugW1kou6Du1ztQymwfj6XUV/m3b3Py2OGoVoarWcQtMF75u+fA/5LpPH3sA678eBzVs1D2/TD72GdVb0AdGKgPuXwZ/0LaDlWF78gNV+8RbRa/2zZJrgzJSnqX/Jff0SZ1tZeBhphRNmsQsQFQLLQ3ZWlS44/yYQ8k6p0uIUX/hT4QSPL26BMmwh/1l9oXvHWJbJqNctcHsk9RIf9CH23P9oJXznjusUIb1gKjv9qIxqYbJfKVNHxRDn5FZidXOF1MlW6u5hy2ncd5FNLqOgjxbejFx6KOk5Eo6gm7zbC0F+pgEvGLjJXgYCCqb5Xfd3qIXsdyII+SMjODNY01FHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM1Fi/6zKcxUPVHuNcq6B2cA6UXaFMC+FNQ+E95VxOo=;
 b=r6rQeVZ1HpHv5saxl6aGJ4ODnADxqhb4wX7HyIaQfRBxANdbwEZQmKO60CGtdUMz1Udq70m2sL1S6HyIPDTxjYLdc6ObVNdQVReE2t0lKRpOy5Nk4Nlb81n9Hc5XoC1DTBulcZqa40/jFETf6/wu+ohi30fRI8NXt4kQIqZjOAGhPEbpZlmdlKslwgNjZLs81bGGpZ9lvCmAHEnQIYtck5LPUTjP13eEs250rciVPUM3DN/gJHDH6yTwfVx0U1+lpOJ0Hbkl3rF6QNGB254IdHU7JaMUEZ5RM3uC3sd5dBxAadKV+aknH6sO6CoVLL10CzrgOFnvLjsNaAokFCB5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM1Fi/6zKcxUPVHuNcq6B2cA6UXaFMC+FNQ+E95VxOo=;
 b=iaUXnJLuXGnrl9i7zseEyVmqyNOri3TfxRyVyhkQcODRIYf0XdywFnWLiv9QVV9lm1q5uICY25LQiYh/Cao5rgaZsxYC7Wb0FfkV334LWcDXeD6BqhVPQWvkY1aZKGvy8wxCZC+p1kljpRJSJnfu2pigGyc5gersiyccCHtvxBUZmNezvtWKO90G1RNWVkacYq3qpXzIwPqT9krzf0u0t+37ffuUcn1HkMxzEusklUt58J+B2IP97Zoby69vMxF5RnjyYqE96/1w1fkS+EYp1PXTOdOyM+EtPuYDWNHALGG4osjEupA/RQT3yQ8OlcTjxNwnkzSfGELAjal/oO3m/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 12:37:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 12:37:08 +0000
Date: Tue, 17 Jun 2025 09:37:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <20250617123707.GW1174925@nvidia.com>
References: <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <aE+wCIG8KHb3u1lV@nvidia.com>
 <IA3PR11MB91369A0E98CC76ABDBA365809270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aFDdkxPODYnyG0Vo@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFDdkxPODYnyG0Vo@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: f256298a-adb4-4c91-6a70-08ddad9bac5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IDB/yOr/WcPVsX9Yenl34ISy0B5mDgF8pbk3hjn577cbNwslnfEylzH4/9Dl?=
 =?us-ascii?Q?bq2omnBReDxqUpoXsFDtJbPXDKNzPWUkZHHi9ouKGz9+qfIvfZuUsqU/LPaw?=
 =?us-ascii?Q?rVq66/k1JuvRI632gyIH2retFJQIfJs4aNhgOPpHlF/m46/doBTxutYu8nJi?=
 =?us-ascii?Q?qXCa1BRMsySY0nOogRT+g37MnHsfHYXma3G2mEsrYiGCkE+VSWzvLT94Qfcv?=
 =?us-ascii?Q?C3EE7Pi/r0sbosp3AVkFdabL9AuazE9ey2XklItOhoHXg+m2rLn1JrEbzqil?=
 =?us-ascii?Q?3EKpw3FIkuOvjz9H/TuBSKQ0oYVoZ7+f9qhzq3MXC7qr1qaB4GANPBoT7aUX?=
 =?us-ascii?Q?dC+A00o3kBd7eiwQM+iC1qAK0R7qjFtKAoTppHqjdZjUjzdiqMdldGbh/PGS?=
 =?us-ascii?Q?4FpSxfzdVO/puAeF4gvcwdTfqOHtVKzTB/B1LC0/4Rv2i0pGpuphyAAalg8O?=
 =?us-ascii?Q?ylZeZHxaRsXs+2mMB1NeAkp9W3jNpLYWKbARROtdHjeism98Asz3kcjZzqWs?=
 =?us-ascii?Q?gu1CQBVJRCu0Gc/bZMphgdHA+zQ7GDUgXr9+gi1vNGs+KxyXHdckq3s9mjUX?=
 =?us-ascii?Q?P81OuB4tFMF+fLd0iUPu1OBy6m5cyowpmfFfdgmRFK+BKAFtTFtm9KGOHXmi?=
 =?us-ascii?Q?GrVHuCwrwW8/XKaRfDWs4W666OJnrWQokxXq4UgX2wLj04fkdZsrNWsHIf2E?=
 =?us-ascii?Q?vFtdJNz77ctYjRmFIGftQOVKwhx6VJJI68l+QVrK1nMpFV338SBux5yYKc3F?=
 =?us-ascii?Q?nOQdDsV6cOGbGyK13bF9CcPDYKPyUrJEBNiO2Zsyq5m3qADAIVS/1yW9FDHL?=
 =?us-ascii?Q?F4Q9AmwF5Ga47NOkeK3AMNPz71ZvuyDz6FLV5nPJ8gmAQqEytUz9Q98B/CC5?=
 =?us-ascii?Q?QUNNsSUBmmOvOMtg9A/rzzV618bIE6N3Dj4Vksj2KT3RVIwsceAFRp4HJB+N?=
 =?us-ascii?Q?N+zIuKOivoc8Vai8s1WaBrk6O+QXCDGQJZPlFY9jSJCZ2ix9o0BeFy5YUbGQ?=
 =?us-ascii?Q?TzSKjhXy9PzyMsZXX3S10TRdVK1do64OYO2uc6z7MMxAkXNr3T70KycTidyL?=
 =?us-ascii?Q?dDBkI1ATty4oH1XctChRf4EJ10l/zE3riafk66Dq9Hc5KN4r85NNFOPJXpkd?=
 =?us-ascii?Q?JaBbpBsTHiICwlb1xeEei4DczQOnE+h+ZPPwd5krxfStOTFrEu4KXYAMCIOI?=
 =?us-ascii?Q?ANTfMt9U8KdgO8vjEbAi4pvXinakXPENCXN74RroQY0rOsu8gs4Ah4ryPIF8?=
 =?us-ascii?Q?V0vzVd7fF3k7jd0W35H26wYdMx44/vj6s0yYbHMd69M7+cH5wKFlbOgVpVMR?=
 =?us-ascii?Q?yPllqCwoqHheIXk/KZqhqdbMdpBctcPy9PH7NJFi4qGSXevwj/LLpfQdoEnU?=
 =?us-ascii?Q?gEoO7+Lr8pc68fxhQKCji6+JFADiLcXl1/L2Fvie1JwkbLD1dQtTd8gTdeuk?=
 =?us-ascii?Q?QDim7LHGcTI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RaMj7D1u7vm3hVBKLtVzIqHeXBn0eLMC3SYThMgyFq3jzZ3qV6nHmxNDhCQO?=
 =?us-ascii?Q?jqlyPdajkM40Fy4i3RyNtJc9uIO3d0zXeuVDja4JYAaDPTDl3WJPDvUb+wVv?=
 =?us-ascii?Q?dCI2h1+7zDXsoRE7DPHRsKMU7J35K8mjAfNUkxNxZV1NZ5GhaQvXMaoeooCv?=
 =?us-ascii?Q?8PQcy87zGX4y0YPO94FdnoSBphovPQGAkGfgoWdW6AismYXJpymfwUyxKth2?=
 =?us-ascii?Q?LJYmold2uEQIXESoM+L28J4NR+6oxzdIVhjCQ4TsAnn71OS1SsDCu9eTNVC/?=
 =?us-ascii?Q?nf4ZdLs39sIUpr03o4SKIXM2V6SIrx8Nr8B7qxwGT92lhD25Igsu18r4TfKP?=
 =?us-ascii?Q?/7iMcGu67ZqC2l/sj4ipEfzaORNJlDexk+WCAAljWctWFCBjS8dznioeNBt9?=
 =?us-ascii?Q?lxAIVszZ1XON0eZAg/vAH21483xA3JINvIcmAifrRGgY0kb7bNVeIdu2vDSg?=
 =?us-ascii?Q?3tvzhIzA+zuU2laA7lyc6uBraBnbmv9xNAohMuFYKY1M57MGilLHy8TeM6CB?=
 =?us-ascii?Q?MbxfpBujEopFTZlsonkm/NVSjvdlmiEXfjLZhNDNebZKJ45iYuMux/ZP4u6H?=
 =?us-ascii?Q?COkNaaky02xavwRLhrTXiqO7/uYwcsoUhA99x1DH53TYFBamX9+bXzQsqhLK?=
 =?us-ascii?Q?0iuYa7DThl8jiADl3IEDtlGupPsSB18K77IDzykTpUrA6sqbg2Y6FhDx1SfY?=
 =?us-ascii?Q?vE33cu7reELQhqNNt7IYJlTmeuO1DuODWC97fd9mHxiDyInxPtWgzztmjZCm?=
 =?us-ascii?Q?PKUBfmeHCeTFKabg7gWrqCDqNILwcCgI7O9Gew1VtarsKzMRGR+CUVbq06yL?=
 =?us-ascii?Q?9VBw8SnKQz1H9/hFlm3+GSaNTqZ3huTF8VtlkO1Olr5VJyo8rg7R9k52LPI8?=
 =?us-ascii?Q?RgpUHcGNdppWraaZQbCuoIA7o7wl527f1wkU3kk3bGnExCZm+mURMuQ4OK/k?=
 =?us-ascii?Q?RkI+HGGlnHtuk2AHStphQBXKIT64PlBp6wR5DdRTsRK7NlFCU3VpzUmY3pc5?=
 =?us-ascii?Q?F3fG80s3bfV/YDVlx5296fpcG1ZFp+oc3kz4wFAGa5F38XxGU2RZYA4WszdN?=
 =?us-ascii?Q?RSoGsZLden3EC4gqhzCfIylcTEQAmb2ou9/Vf6eRDOvitfG0sKf9UEx27Sfk?=
 =?us-ascii?Q?bNao1f5tGmMnKddLL+L6GCbU5/RT4M9MGT1dIwzz6LmVhH/Epk4l8RpWKBbE?=
 =?us-ascii?Q?uiBuXX4cr+I+Tmoa6kf+4/vhVRDSZ3mizQqxkLopRpzL9TAUpoViSR4XLrw7?=
 =?us-ascii?Q?OeNdfFYomouWpf92yzZxnLAzX9GaoZEzm/5GQL75Xu3MNMBj5lGQSoGht5y4?=
 =?us-ascii?Q?I7nH3/GXR99iB7r+zU0Rmpz1VJ2DFL0XwRnvhlEb3PYrFUMM6JooJxx6fBT3?=
 =?us-ascii?Q?YP4kF1yn6qB6DwyUOi+EfQQXG9LuxTcRaz+DWVxfl+bxdpMzTMvJ7+z9QClf?=
 =?us-ascii?Q?D53GSaRjJC4rK3J8HjqxEZpGOkRQaQmMSffZo3OYEJv0ISqeU6zw+prFBzAu?=
 =?us-ascii?Q?404vNsYi5V2lHSaPewAytZyu0DeBb2erUJlbWtfIf2OdyOMZvKEYnox8Na3s?=
 =?us-ascii?Q?j8NsAujd8XLiWDW8oXyOe2sI9a28WpfEATj3OgzH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f256298a-adb4-4c91-6a70-08ddad9bac5c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 12:37:08.3938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfpwDHkBIr5fSROG2Y4Mz8wObGdw4VZrrqItlpx4wmaTYayL8v5MEHHJF4UnaZ94
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
Received-SPF: permerror client-ip=40.107.236.77; envelope-from=jgg@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jun 16, 2025 at 08:14:27PM -0700, Nicolin Chen wrote:
> On Mon, Jun 16, 2025 at 08:15:11AM +0000, Duan, Zhenzhong wrote:
> > >IIUIC, the guest kernel cmdline can switch the mode between the
> > >stage1 (nesting) and stage2 (legacy/emulated VT-d), right?
> > 
> > Right. E.g., kexec from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off",
> > Then first kernel will run in scalable mode and use stage1(nesting) and
> > second kernel will run in legacy mode and use stage2.
> 
> In scalable mode, guest kernel has a stage1 (nested) domain and
> host kernel has a stage2 (nesting parent) domain. In this case,
> the VFIO container IOAS could be the system AS corresponding to
> the kernel-managed stage2 domain.
> 
> In legacy mode, guest kernel has a stage2 (normal) domain while
> host kernel has a stage2 (shadow) domain? In this case, the VFIO
> container IOAS should be the iommu AS corresponding to the kernel
> guest-level stage2 domain (or should it be shadow)?

What you want is to disable HW support for legacy mode in qemu so the
kernel rejects sm_off operation.

The HW spec is really goofy, we get an ecap_slts but it only applies
to a PASID table entry (scalable mode). So the HW has to support
second stage for legacy always but can turn it off for PASID?

IMHO the intention was to allow the VMM to not support shadowing, but
it seems the execution was mangled.

I suggest fixing the Linux driver to refuse to run in sm_on mode if
the HW supports scalable mode and ecap_slts = false. That may not be
100% spec compliant but it seems like a reasonable approach.

> The ARM model that Shameer is proposing only allows a nested SMMU
> when such a legacy mode is off. This simplifies a lot of things.
> But the difficulty of the VT-d model is that it has to rely on a
> guest bootcmd during runtime..

ARM is cleaner because it doesn't have these drivers issues. qemu can
reliably say not to use the S2 and all the existing guest kernels will
obey that.

AMD has the same issues, BTW, arguably even worse as I didn't notice
any way to specify if the v1 page table is supported :\

Jason

