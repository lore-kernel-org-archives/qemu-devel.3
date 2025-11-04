Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670F4CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 19:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGMob-0006qN-Oc; Tue, 04 Nov 2025 14:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGMoT-0006pj-Fe; Tue, 04 Nov 2025 14:35:30 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGMoR-0002oG-VW; Tue, 04 Nov 2025 14:35:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRho+r2ueI23JAdQE3/mz4M08tk+JjEmjzHVZ1bI2NA/ONgDi+QHSOq3/rYzI8E0yKJtVhlXZzT35fYLgQ9s+34rA1x2W8CZYYJBL/Futd5jDrtfObWgMKRQn3/5r0lNuXyMJud5PiYX49yl8VtbjkyzMYipGy2q4aYCGXRTZ0Vq8tDadyKefH5y0IkV1bFkHBCVzTGpJJmzLyNrBa2/jx5k6/lh07QOnlOyMvyrEXmrRGomphxhuLU4RofwO69Sme4013JFWNF3J1YTcIN/3DTylqhVMJ8Tpjkvid3Ev6iJUOVgCLF052/hZXRbgY9ylGQ+k6CZlmB1OKG9wT+P5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzjED+cJomHRwJOCq7eXDDo9rzB89fOWtnKakkISSg0=;
 b=nkW9Ab0JCiusS4acPovMMU1YB8KcoIidQEW9TMz10QKnqkNhSrBFS3ZG3remRwCGeqa1gfdqcWJKd53BySyTp/LVq8aRVnKI/Y4f7Eb0AWUUrGdWYTVUrqQz8rM13EADMz14IJXHuzDSZtmHSopTT5GeSqw6n2Q65clsR8KiLtth9q1WNagiwQaMIRbJbB96hGOtMW14IR3Z5kcVkvYgfPTLSDU9Vs4OJqP/dbMfrnSW/jZKwbk4OgDgpJd4OxdfrK97ZCLmXmKtiU2mIdUX3eKBA/DN9b6DO6GNsuqwThgN6BKuyMyKEUNWoOjemK/SNb6MuGv3n0Th1DoStnmD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzjED+cJomHRwJOCq7eXDDo9rzB89fOWtnKakkISSg0=;
 b=VyAHbKrUzAUi8lASLV5HhV6CJg7dSJhCtSnD25Wdh/9f0S6y4T93Hzm/y5oPndUlwCNzz/9yyRlNOisW7U12GsYyHzPBEfh6rR/b86D1n/7TDL9X5Vx9jm51GM9bt7+0eYtEizBe3V4ze1KOR0NdI0Ay0hL9WYIVPYE3POPW5rFAA3K0PVws15zAD4HnaDouaSQyseV6pophPSCyDsOTZ7Yg+r7yzJ2hZAdd7gxyDpauIG565R4/z/bR9ZsCKfn/V37efNWCb0aztP7COlHVfPXw8nlr1J5e40nnRrqdNJV0Pg03wIzSEVT6YTcqcxwB7O2ZQ7V20mhMjGTI7FER9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 19:35:22 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 19:35:22 +0000
Date: Tue, 4 Nov 2025 15:35:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
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
Message-ID: <20251104193521.GM1537560@nvidia.com>
References: <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com>
 <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
 <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
 <20251104180928.GK1537560@nvidia.com>
 <aQpJi37XslsYV+Ez@Asurada-Nvidia>
 <20251104185651.GL1537560@nvidia.com>
 <aQpUpv3Rde0PCCIv@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQpUpv3Rde0PCCIv@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:208:32d::29) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: cad5f7cc-88fc-4206-d0d3-08de1bd94b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fDp0CC3jT5G/He/rrPICLdY9lzFrCWC9o4dcQVV+vflRnZ2pXwmaqjGkKfmS?=
 =?us-ascii?Q?ZGI1yNu7orf8I3tmSidw+Og+MOQCnCTXsdjeTVhx+CpwWD+wf/A8OY/6iSu4?=
 =?us-ascii?Q?rlpVo3d21KPgX6nQPt5hDfZzXxr2BqnFtOq4tbdy+TfZKfOMHgZljwa5A1U+?=
 =?us-ascii?Q?T19cMfd5yMvfeYcN7HkoapyPwxUyYM/LAFBsRGdenpiRKJ68AZWujANz7yk4?=
 =?us-ascii?Q?GNCxsZegwRkS6Ge2CLu/+ZGW2lzKPGQ9MKWJjbUikfRDRD5MTew3XawWi51U?=
 =?us-ascii?Q?nKD/gidxPKKuTADxlq2Pgs8yb/5fu+iYrgnezApJ0KwNPh0f3n4mXwiqt33l?=
 =?us-ascii?Q?yI5g45O8Z7nkQfEvFPZHItoOIA1TqJOzbf9n3N7AK0LBemNoGs3dXqODw+Ru?=
 =?us-ascii?Q?lTfFguq9v+v5U+kYwrZBnSoYHCE6EF2m1rdHu0yofUzZ4EbuGp+q69bzCNs2?=
 =?us-ascii?Q?Z7UpHYN6BFV2qwHPNJQSkMGv70G+/cGJW7V1ef9fnp/sza0MUczsWb2muA2x?=
 =?us-ascii?Q?G6wowFKfrRj1Sf1c3rIl6Wlzgorbmhj474YSv7vR7EoQa009KVOaZ+fkRrKi?=
 =?us-ascii?Q?+dq23pRRKrWjhCX0Ksg96b1pi+/5XqiwMw7HD2GV2823b9IrUT0GamQQ3w7X?=
 =?us-ascii?Q?uoWCaiMv/GkyCPfVQs67wWNBc/dl/R3xhi+jq0LNivT2oTIucu62oWAXz8E3?=
 =?us-ascii?Q?eZ++3+gRTXB5CKLQOwJxQwQEhk73EcXQMyyXIyQmijVo343mHIGNEcXgvMQn?=
 =?us-ascii?Q?FyAbHexPvkYejoaOagIskHdH8nPhUgejbfXXI+Ku43S+YXfOO3/CRHsCEAqh?=
 =?us-ascii?Q?0H5PGDV7KnuO4kyZA8Cnd3wLqq9lMQw2veQIhghtvpUacJWZ67hjCZ0TzoT9?=
 =?us-ascii?Q?BagrD0hr5C30ItQjgy4yjtL6IOKKPxOA3nFZ8PynJwy6fNN7ZSgcsLn+d3e9?=
 =?us-ascii?Q?qNgMXsivxacjEwiHmpw2ZIR5XkCmfVLqKfkXp0s1KOlu/kSPqw31nz/+7g9+?=
 =?us-ascii?Q?f/HCLK/QBaK+s+mcJGosioe3RqglOMRrpidDYDAwWmY4A/5HDfK2TwmzJbCo?=
 =?us-ascii?Q?TKSg2nBZYX48ysY7Bd4Hc478suTWXti8gnN+YjnDr9e3fwPfwylXCqccPsu2?=
 =?us-ascii?Q?+9EjvXPRxbrzRhY0LodE9tStGM5xVGI0gKbhsKbhQhOBwq2TqvqEShlL4jBa?=
 =?us-ascii?Q?wHo5ljLSrm/YY8DBUq7sNBKVZM3AxgqIH3WyfhOJKyNP/81IhQ9XeS4tpiHM?=
 =?us-ascii?Q?qwFNd7XH3ysZPLNQRrrzJneTCqeXNz1vQC6/3x9u5Mt6K0m60ImipJDhm99g?=
 =?us-ascii?Q?qMX9zpJRfnpdu6TAhPb/Mxiixoz1/n4c0LM1k49PDOv5qDAPKNKBhInrYNZX?=
 =?us-ascii?Q?c5sxyeF3RZXDqdTNccBX/GB4E5w60KbIyl3Tb74mBtyj5aa74k3RIBQlkP50?=
 =?us-ascii?Q?uD6amvatCqRxLXd0tj1O4bvfsYdqLBpt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aWdItISTasHXgifL3zrHrXuIomYWtao/sNhoUzwdgToJPOU5x+5nsjMMtTXm?=
 =?us-ascii?Q?hwbrln5hrDlo5StudJ7TYhcF8GkORMGRGDZpZqSwXeUk1RnNzRGXTIHKuQtY?=
 =?us-ascii?Q?dzWH4yuH30ZVCRc+MHb9l++LZBaD16+YXsWhiGGvNGFdIfeHXWTlbTqtPjD6?=
 =?us-ascii?Q?i63BX50Y70mFto/4Jg2Wji7rbAbacG8bqnZXsj93d3IhtXE8sm8vrLPoQ1yW?=
 =?us-ascii?Q?4LjtWUGVo/AVYo+NncTzCDHILMWpqBF27P91+tDQ7UGLBeXpnqAqXQR7nt6S?=
 =?us-ascii?Q?l9loa0RRNyKUjCCv8tZoTGEverGx1TlAz4r9vqRsfogJTbAcAQciSJ+b9oQ3?=
 =?us-ascii?Q?QdtrJPseF2r1LwCp745AptPVrnYTBXz8gimFYz616a2XZg2xxTryHZIkp249?=
 =?us-ascii?Q?9rSnvELCszXWzSxMsiPApHNQ1f+w7L3iOqkQwoXeTcrgyebbOPOinBHSBrlU?=
 =?us-ascii?Q?+vvZDDCkUlxzwJvbwx8rep+Ox4RGArqVIAgodedE45nt8PWRXsfl6APzdEhE?=
 =?us-ascii?Q?4zJhWzVjjQZQL78mDCku8AteBnkvfSgP1Y08Y0BlnH2Ol9SoZuueq5w0U8vp?=
 =?us-ascii?Q?1oqXcvy0LMbjFQryoRF0jE4lER3YX5547DZ973yOegjRj05WDGzp/7rmImKO?=
 =?us-ascii?Q?5oXVxdfv7OiyF5xlmv2k39mD6JlVNLDB4afeZH8oAU160hySBQGJLdZRsv1u?=
 =?us-ascii?Q?2W9gHBrJX91ii1b4el8XhqHeiN9qi4SsaBuc+r5diYRW7h2izj07/q4EwWed?=
 =?us-ascii?Q?21DMv5uHhLZN0hKmhMHXtBBD5FacoPjrRv5SCUOM/GfNMdFo31gaB3uYl57k?=
 =?us-ascii?Q?JkjTSaUojxEc2iyXVug0UVFjUlLdMX1WlNficJ8pRBjdBcartS7xZnbX8DkH?=
 =?us-ascii?Q?E2b5HVXwetLDCU8obLkIM2sI2dJQPWvRvsmNwYgx1TCaB/6LTQoAU+pQ15WT?=
 =?us-ascii?Q?pQXJff8NZ14ieaKXcQEDW4S9byIgsMLilZEVAkJS31OADjVJ9vs5ttJlqwot?=
 =?us-ascii?Q?lM1bbB8+abhC5uLXFa2aSYzug/M6Bm919O2XWiloqIb8+rmu8VG5nz0+azcj?=
 =?us-ascii?Q?+fAXzBhXlwogtszJ226Pyv05GMm+uzj44yDtc9olf2RLt9r656cnHG8D+PaV?=
 =?us-ascii?Q?W04ZfYTX/NQWj2vWMZgz1+kpzevAaY7Hl5biczAsTgWRldATR3vx0QMJq0qN?=
 =?us-ascii?Q?GtbKWqW4O3GNzUZl+ihmlF5fVAJ2XhqNdyFOax89DxFhjZJXsJwQVSED/oP4?=
 =?us-ascii?Q?yjJHvsjrEQV3Mzu8DXFoHu4G9FXVuWDCPVq9M538HjDbiWIWnFPYcfz2FH1z?=
 =?us-ascii?Q?omhKEYFc1b8lFwe+QsJN0A/ylOj4jq0T9kxYHzdbeSn/X+jGS2YqKuY01OnV?=
 =?us-ascii?Q?GLA/KEnq7azPNFvkCpv2bcN5gQvxku184hGvq3lQABv5ZxGhGjFQvn8y5yyP?=
 =?us-ascii?Q?LM0t/bY5EfpytS4kmhJOR/J+P3jxeOiPFhuiZ0hX4O6uhKcBEj+mvz8YTSm6?=
 =?us-ascii?Q?OOBoqz08wID+t8vL8hL6917VtHq0CEDQbdbYQfG91H0fJL8IMkWZoxvlIa1e?=
 =?us-ascii?Q?cMnL3EHYvIRpu5QW+/s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad5f7cc-88fc-4206-d0d3-08de1bd94b95
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:35:22.4781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FiDauJdmKlXiLtS7JdYh+brtVq7ZCSzf1WGg4vOYp8eRwoo7+bJBwlbh7nhVvWP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=jgg@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Nov 04, 2025 at 11:31:50AM -0800, Nicolin Chen wrote:
> On Tue, Nov 04, 2025 at 02:56:51PM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 04, 2025 at 10:44:27AM -0800, Nicolin Chen wrote:
> > > KVM would always get the IRQ from HW, since the HW is programmed
> > > correctly. But if gIOVA->vITS is not mapped, i.e. gIOVA is given
> > > incorrectly, it can't inject the IRQ.
> > 
> > But this is a software interrupt, and I think it should still just
> > ignore vMSI's address and assume it is mapped to a legal ITS
> > page. There is just no way to validate it.
> >
> > Even SW MSI shouldn't fail because the vMSI has some weird IOVA in it
> > that isn't mapped in the S2. That's wrong and is something the guest
> > is permitted to do.
> 
> Hmm, that feels like a self-correction? But in a baremetal case,
> if HW is programmed with a weird IOVA, interrupt would not work,
> right?

Right, but qemu has no way to duplicate that behavior unless it walks
the full s1 and s2 page tables, which we have said it isn't going to
do.

So it should probably just ignore this check and assume the IOVA is
set properly, exactly the same as if it was HW injected using the RMR.

Jason

