Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516BBC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcTyb-0005qV-UZ; Tue, 20 Feb 2024 12:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1rcTya-0005qM-QR
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:32:16 -0500
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com
 ([40.107.94.50] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1rcTyY-0003fw-Go
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:32:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f84L/NQ1AO/naPxfhh6YfX9IpHBKIrOjrSqgmDpqoFiX8BdTVOKaubnRRa1iawm8GFYPbzdYN3+SzW5T/IUgoHKwCM3qd38RweJ65Ipt+bZ5xwdM2MWHdkB1tZq+N11xWXm2VOoHs3ClX2DfeXVDfH4+F+Lj91pUH2P2KD9weQI0+BPlaIe06Oa7Vf2k1pYIBQG+hUm+0xNeRFrZLpeyVo5Ue+wV0jSfkREHaTZaagdVSr0agsH85mQDWweqSXQwlARsfpSnoeF3DGAkJBv59+PL31Beabum0vpnoHHTH94lvSBHBysJaCoVi8XsHkeuEPt9toK7Fod3utQtP02lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm+eD/mOV24+03m9YXfNVYvX121gpKV5tJATR29HP7o=;
 b=Dl+UrDHalOJb2OwjKIdYUOj61FlF8oV5VUo3zGoXKLbefqobgS42yM43e1mF7Kmph29wnqdBHt0R3V4/VnFijk2LGwEZgQwLtPBOFosnxsCKifCVWZ0NlhTEkbky14uG4LDbFWuegpydLk75ZXRKJZgpQrPIfe5EwpIKkVSRimpQ7ikNsISnKEKDgB7v6AlLROsxQffau8fhs4r45CdvMtstYhvMVhVF29OH8yIsgB1OYlmZFsPAKe0QKAFFwG1n5IwT3OH9oAR9XY5yDl5iHRC6t5v6GGXSfDRFOzBe6n9COUd/UFNJ4WCDTrOodCcSwymNGZJyRULHXjaqt1h6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm+eD/mOV24+03m9YXfNVYvX121gpKV5tJATR29HP7o=;
 b=2B7Vj/6eSB2RUppYs6pD/RSR5TLlPFtF0pomzlU6zCra1xe4Ol7odMVaimIcokQCOS1QvWKOEWnHOIS00bPFqM5+aEMHq9FxzpPjPGrgKq6VeZac9YN4pllawj/IHJHM2YrdQqfciSQ14ZL8JJRZHSoQnK0O1AZ5dHFeC5XCYYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 17:27:08 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::319f:fe56:89b9:4638]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::319f:fe56:89b9:4638%5]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 17:27:08 +0000
Date: Tue, 20 Feb 2024 11:27:03 -0600
From: John Allen <john.allen@amd.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: pbonzini@redhat.com, william.roche@oracle.com, yazen.ghannam@amd.com,
 michael.roth@amd.com, babu.moger@amd.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org, "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v4 0/3] Fix MCE handling on AMD hosts
Message-ID: <ZdTg5y6P0iuNYzZZ@AUS-L1-JOHALLEN.amd.com>
References: <20230912211824.90952-1-john.allen@amd.com>
 <afc99063-1916-4a0c-a763-f515a4595e73@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc99063-1916-4a0c-a763-f515a4595e73@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::34) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 219168ff-7140-4ddf-83af-08dc323929fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdA1h6rniUoXYEovvU+cszbyLJb9wlKiKLNdDCqfYaoAGMXWVva+79bMyzxnW6zW+MfAIZqjH9AMtYCkCUYiSwpPHgjq63HsAuKxGhUlUuGcT/SN6eAuCjBzj3rfN9HoMDKmwUpeHGsVasKRiCbCgL2p2yWLLjd8Su7PLPyTVmq3GWV6c//HppiNHWx/fSSlWylI/McQHIZDZXeoX92XkgX52aSB0pN6xi6+SWAfHDgvV4AYgraSaNwtsYQkEcoeUgRPSB+cONHJjh/DjbUm1RnoHqMq4l/MG8SAwjtR3dPGzPH/AGken1zhCnkbkgBm/8y3KvUwQrwBiWZEGyEbEpdlW97B9UUfbgVJ+D3oV/HCUrrauPDqLoWvd/aXqtgEPIfIGcdveUyywzrVWxefARX+IG9wARppkiGdrW0IYSY2Bv+lNLdI/jYUpTarUjIZqFVOSGPphDSWljnsI9frhMsIR4Cgxw0qzLfinpyaCuK66chHY9mao1WAUhvabeHY/toVXtr7rNuV2GNEF2Wn7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5995.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7znlvkrYKjKco46hvwpe76D5LFHwDEpp/cAX2omR62QThTx8L4StLVF+EP2b?=
 =?us-ascii?Q?3FmDNordOSUMjl8k0gPMuwo7bVN7lnyvzIMubHgq/vmqPEG035KMKqMy8c3r?=
 =?us-ascii?Q?fTJ071zXXHVER0m3HRvg2jgCmytpOEWtJkwonhI1lvVLi1ViwQnu50GyOHoJ?=
 =?us-ascii?Q?FCJlCrzdhHBV7ABq404TgvQt8N9dGfPwp3EL3crYP7uMwLiXhNh6uIxVHA/D?=
 =?us-ascii?Q?qqsOl+vjgLNQ/7GbEld0KEhNAYIcYpDusm/EMvgUT4akot7wODI7F2O6tvtq?=
 =?us-ascii?Q?XEmfvYVHpZ9Qh9E6wKa3tILobE6ajhj1iexuri6Zn39irjRCj9iYyvlyM78J?=
 =?us-ascii?Q?24J8FoE6Smsfy2Ssh3RUzniaqX3ycdXPz/A0tcn3G56eRUVLeez2XgbgXg2m?=
 =?us-ascii?Q?dM0bl7XaAB2Tt4a0M9H+z25wdaNdddAxIiWtNDQHHNf2m5PmbNPAcg2awC4L?=
 =?us-ascii?Q?ag3gT9hn+UDQJfkaFlx+Kt7mB6dOHdKRh444LPfTGHW/QL103xeVNg1pNPsr?=
 =?us-ascii?Q?Wj5iECD5bLXKuIj+HRpD2ihbEAcdKOPK9k2ppaff4Q3o8NBhKK6k5G9Sp4i4?=
 =?us-ascii?Q?L8OE8McAWh7j9vg92kt90mFFMipmMf1If3Syb6UHGlaTt9W53CBe9H/z0nXx?=
 =?us-ascii?Q?qwmWIGMoc7tN3ciItiVUITIITWq7No5wchroaD2VvZZCvZBxKX4+1IT5lIXk?=
 =?us-ascii?Q?lNPwjUPktc+oM/SEJ4+iElIX9OnXkO+5XhDDxyxG4wCe8ytps1TFkPhxMeBC?=
 =?us-ascii?Q?2tgsrcONdegCB9H1XcuA5v0zW1sHgIhuGR4bgCFz+afzzIsFo+ZmckgbzLPi?=
 =?us-ascii?Q?t+tz8D9c4VBXYjhFmli//eU4E4Ac6o5qoXyaOqjbYsD+ySk6m93UsymcnecU?=
 =?us-ascii?Q?B6Snwl+I1kqiMUxHDJ4MdmQl0AxIhrwbQuoIwF65iK3c/PKhQ+9CDRid7/rA?=
 =?us-ascii?Q?eeNN+OcEmJQqZFoACyHlAgyPIQNnE/VtXIwzofdxYQxraDVClJpQ55f71g5w?=
 =?us-ascii?Q?0Gp3qv19JPZ5sC+nyWWTPJYcynghi5PpUhXLoIytvPGIwaHDqKzbdRgmEpCZ?=
 =?us-ascii?Q?mwKB+uG5eZS6e5NKdwyrvnQ2/yOgku63tryxwKw5D963dMUdHGSZ6toHe98T?=
 =?us-ascii?Q?edvdF4fORo/JFZZm2pV1wBWUuDvmh+BMnB4QMRTHHGrZdf+NT8Sp1ObzOzvd?=
 =?us-ascii?Q?1dSCgr54IUd+mSeaNXFp30kVoyKANwEh97M7L4l3VvOXIhAhXfrHwY0AcuRc?=
 =?us-ascii?Q?vqiG6EGPMw9TspTT+UoLME6rhNGEwG51+Ka8IVaqdk3Z5UNO4+K2LjEe9PDV?=
 =?us-ascii?Q?cajtxGeyr91uDeBuwYYtEfxlC8jVn/H02v8ntwdsJ4eWSn22bL9iYMqYn9tF?=
 =?us-ascii?Q?01zTQ03tZQe2RRbge8M1HY4otp0pxlXLH2KUJaVf5S/AAdb+AhTIh81jkaxp?=
 =?us-ascii?Q?nPtnEu1eIpf94PZSxe1LpAJLC4sUvHzCkOwQ07kg18BXY7+70yHPUCjzsJML?=
 =?us-ascii?Q?YM9o4vY1wCLwqoK86RkCb/vVw/DH6zkhb02okOs8H2VOihbKADSVxR2Y8CK0?=
 =?us-ascii?Q?kLKYg1ro8NkStTWODKPXcjaRcbNgnZGpjbdLB/OO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219168ff-7140-4ddf-83af-08dc323929fa
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:27:08.3901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbxmG6rZO3Bm+BPU7aRlsJZFMsnZc4LIr8DAAbpUE2TmWnhu0neNyfbtm06lnD4I/khHo9vFOe2IAX1zOSKxeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
Received-SPF: softfail client-ip=40.107.94.50; envelope-from=John.Allen@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 07, 2024 at 11:21:05AM +0000, Joao Martins wrote:
> On 12/09/2023 22:18, John Allen wrote:
> > In the event that a guest process attempts to access memory that has
> > been poisoned in response to a deferred uncorrected MCE, an AMD system
> > will currently generate a SIGBUS error which will result in the entire
> > guest being shutdown. Ideally, we only want to kill the guest process
> > that accessed poisoned memory in this case.
> > 
> > This support has been included in qemu for Intel hosts for a long time,
> > but there are a couple of changes needed for AMD hosts. First, we will
> > need to expose the SUCCOR cpuid bit to guests. Second, we need to modify
> > the MCE injection code to avoid Intel specific behavior when we are
> > running on an AMD host.
> > 
> 
> Is there any update with respect to this series?
> 
> John's series should fix MCE injection on AMD; as today it is just crashing the
> guest (sadly) when an MCE happens in the hypervisor.
> 
> William, Paolo, I think the sort-of-dependency(?) of this where we block
> migration if there was a poisoned page on is already in Peter's migration
> tree[1] (CC'ed). So perhaps this series just needs John to resend it given that
> it's been a couple months since v4?

It looks like this series still applies cleanly to latest qemu, but I
can resend if needed.

Thanks,
John

> 
> [1]
> https://lore.kernel.org/qemu-devel/20240130190640.139364-2-william.roche@oracle.com/
> 
> > v2:
> >   - Add "succor" feature word.
> >   - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.
> > 
> > v3:
> >   - Reorder series. Only enable SUCCOR after bugs have been fixed.
> >   - Introduce new patch ignoring AO errors.
> > 
> > v4:
> >   - Remove redundant check for AO errors.
> > 
> > John Allen (2):
> >   i386: Fix MCE support for AMD hosts
> >   i386: Add support for SUCCOR feature
> > 
> > William Roche (1):
> >   i386: Explicitly ignore unsupported BUS_MCEERR_AO MCE on AMD guest
> > 
> >  target/i386/cpu.c     | 18 +++++++++++++++++-
> >  target/i386/cpu.h     |  4 ++++
> >  target/i386/helper.c  |  4 ++++
> >  target/i386/kvm/kvm.c | 28 ++++++++++++++++++++--------
> >  4 files changed, 45 insertions(+), 9 deletions(-)
> > 
> 

