Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B22C5DF67
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuy3c-00070U-0O; Fri, 14 Aug 2026 15:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wuy3V-0006uG-BL
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 15:59:06 -0400
Received: from mail-westusazon11022122.outbound.protection.outlook.com
 ([52.101.43.122] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wuy3I-0005NQ-7G
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 15:58:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdZYTjPOqmiKf00+p1ZjCEde8JXk2GmKPoEkFktgezHnLk0baEjNtgxonnFpDY4ORsyKCd4xyygf0zDGq6KTYJr8dNDOmHn3mjm4BTrKbbTpg3Bo9G/J1NEYxRTxTgnU/eh1zOhIqrKH6O+ORs3mXWXdHI4PqGis1bCUYSDPXJBWPnLIbZ7cMb9+4c11eWxqAOOuBADIXeSwam1/+6twZDJ3PWTK2ckA7r0Rmd8RqQo9RL7xTmW4E0DE+fx2+Mh0xL8h1JoJWv+pqZil3NAy959VYRTzLbc5RZDX//Ry4KyJvE27L+IC3TJmoAu8RynrSTCS1Klo+Bx2LC0DrUrHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQD+ErcrhaGzWZHtwGe2XKmPuxJ9dQLjTdcjTunyDj8=;
 b=fY3cGx2sJQkYQHsvClQM/XR5dAysSVoSovMm9IWNspDwcXna8LE72HmlWuwFK6N698ZwBveeGYFWUxC8leF/Xnona5FI8M5NJAUjX4kuHu4PdJIIotWJgx8Ynh8lzrznLCKt+V/qf1ddL2SGVEii0Lxa29PQd9hdVRBj00YQEPB5IF4SL3E4rQbtLJvRADBYp1dCgIHJgySMCnQxLY8XRzt/8xm9pQEq3DHz4H4BVjDTimSj7FlZ+oEdsEi1wzN/RPCM0AZD8pZ6hKyE7SYp6Kr8d4qNli+mgddTplJomnfPM7G4BzIizEoRpj/4KMNbudUmrXXGBQrcVj44vcT44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQD+ErcrhaGzWZHtwGe2XKmPuxJ9dQLjTdcjTunyDj8=;
 b=V4S5HOZE48rhylkJxhMwsz6y34gLSvIXAitke9NQc3MklBRWc1KUa4pzXQEpNT8WXGOoyTAn3+JndD9GNeCrfgJNW8uMAGk5Rkw1CWYAgKSHsoag7H/9mMWPIE9bRFTwWEw275Ho4iXt1etPjv7B1KK7VhVh3m2HNg/GpwgM6v820TeR9BbMn0DCqAX9uZ+i8SU9rE/yEi1UhCPOWR6QWsJohVVUI+QctOlEdY3K2Xg6/r4D4zSsfpYuS5l0Zv9EEo609OZvEgwnLNuZvvzcyxRMrNJzy9zgJhh7ovjLlUiZKGdd/r4uy/HAC1CUpqDv9hRtwg628R2mFb9o851EPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BY5PR02MB6180.namprd02.prod.outlook.com (2603:10b6:a03:1fd::16)
 by DM6PR02MB6922.namprd02.prod.outlook.com (2603:10b6:5:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 19:53:38 +0000
Received: from BY5PR02MB6180.namprd02.prod.outlook.com
 ([fe80::5bab:a96b:f604:d7e1]) by BY5PR02MB6180.namprd02.prod.outlook.com
 ([fe80::5bab:a96b:f604:d7e1%6]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 19:53:38 +0000
Date: Fri, 14 Aug 2026 20:53:31 +0100
From: John Levon <john.levon@nutanix.com>
To: Naman Gulati <namangulati@google.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
Subject: Re: [RFC PATCH 2/3] vfio: mmap sparse regions backed by multiple FDs
Message-ID: <an9yM6aSsFaCHokk@lent>
References: <20260811233930.401797-1-namangulati@google.com>
 <20260811233930.401797-3-namangulati@google.com>
 <an7XMMoApuo3ye1d@lent>
 <CAMP57yU0_0YbnuAGt7iAv4p3qW9cX=1TkpsesAVTs06Y9ZJtbQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMP57yU0_0YbnuAGt7iAv4p3qW9cX=1TkpsesAVTs06Y9ZJtbQ@mail.gmail.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0125.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::22) To BY5PR02MB6180.namprd02.prod.outlook.com
 (2603:10b6:a03:1fd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6180:EE_|DM6PR02MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b784e1-0456-4b0a-6229-08defa3dbbaf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|18002099003|22082099003|10067099003|4143699003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: PUnNrW2WtqtD+5vNl+h2zgQ2kCyJ/6uSW/pkDZYzk1JhCAR/rc7n0FYMYIa5ozTOfAmS1k9CY9e4qLe6r2JsKLBHVhinN5L08QLRuPb6fWh2dOE+C6HF5wu6aOJRCY8AbCk/8enZ300SqmGUmkIf6nUnT7EqAGgGt2vBi1/6+HpRaPF2JPZo83ZlqZrq6UwbmOG42UgeA58GTMxtrfor9Xe2KzwBdH+GLF/y8d25cKSAb5dAtaSMUu7fUBJg5meAtu7a+qiZlY1ultngQNuXA7X5XcLeNv+l4/7lhufyEljlQ2D++22nrHBK/MnU9OGMSwiABLVuA23pTV4MSv4dZuxRPHzGGNtC3IHcdP4f5Qzbf3Cev7Rwzwj9r4BL+o8NzLhGglLwMGjzVggw6QZx3hrMYdpan60h8HyCeFgvcplJ3YI8+5MV79jZdp4LLMMAYZMeY5RA/sw+WD/3eiz+CrBwuLTa0bIKMYVOzsEAcZQztnGQXthQC2KEbW27xa0b4RfLO82PPkG45kKisxpzQc7E4AWehvVDAbUZn9XeQqvOD7beoXx5277BbHylrhTzTaKLE/kPOxhXJV05sS0hy57/etcHfWRl9SshuDVEAgMsI7IzVcCYn9kr5dEqFkUlGfTCmVb/d6BjUZSEKu/eh0L4YiwWA/5nQprbHnqFBfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6180.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(18002099003)(22082099003)(10067099003)(4143699003)(3023799007)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iaCQstzUpPIkxbKC5tdIEx5ZhygTQuLOjmW3ZsTdgrSLQLPg5LR2C+HKiI2m?=
 =?us-ascii?Q?OvH4vtF6Uo8/Jc1lTZkWldY7oOwmKpVRN47VIHWmVa9MkE9Y8KaciQ9YmGhk?=
 =?us-ascii?Q?ukp1c+ZGf8l1gOUire78ShYZ6jb+3RPad0O6HIS6SwEjR/M3SrDmPcl12FCk?=
 =?us-ascii?Q?pk+SO6EFI9Thnin5on7+SnhktLGOuRI8WLSQYGdUbCAJxb15XKGKFtBggudY?=
 =?us-ascii?Q?uQBvd4qeutBNbLTMvbe/szllh+KQgns6whLMc+9jTEWXeqICNjqVHZ/m0Qsn?=
 =?us-ascii?Q?4WY2M6DAzIjxydICfx1rMiSc3x4b6ViGYSUWcSYk8u9rPSZ/G3OaJYKCz5q7?=
 =?us-ascii?Q?HAwb4vw0baeIZ64VqWocmKCu5z0lya5R5hNwQZCHx+61eBtlNCOVgZmNMil+?=
 =?us-ascii?Q?3PAQ4Kc/XTK054wFDZmbuL58/TseFjc1v1SfJAY4C1MHjMzht99IhAmiMD3f?=
 =?us-ascii?Q?GowauKC/OcKZLRbi0HMShnTowt0Di/ylOShkfbyx1Zj9HCTkJd+kQ5BvX40c?=
 =?us-ascii?Q?5Ex3fcJM2ohzZZX//cja48jmLrVeskVX2DdhDrzdfxMGsA7bv3AbACbzDXm0?=
 =?us-ascii?Q?Wdvae0IfTdqYGLxmCR4Nk0FrYAiW6YyQGVWvJrXa8aWh2YfgQcxkI4Mr2rMT?=
 =?us-ascii?Q?HWppsQztDL/dB6u67KkV6Yw6zGirrbH0vQgcG0BcsVHdTE+xrEWCy40lcyq7?=
 =?us-ascii?Q?JQUhyia2T733nbZk+gi2S91FLrtjSRuO6SvO2FoL3OgtAQT2e5b+mS9Eqd7Y?=
 =?us-ascii?Q?gOC9mWO9HpDI/JVNIi+mMYqUldlyaHQ99JkdfrFf3DZSN4/qFPncrDMBzSOd?=
 =?us-ascii?Q?yhF+QwyJ7vvE8/kyNbr5WSMRscXcGsy/dQczL0I6rkn0dzxu4rXu4pdz9okG?=
 =?us-ascii?Q?40OXM7ZAeHWHGY0Pcnd7833ph6DtTuY9w/q/jND4aZW5SxXSfIt0ioZJ8FOh?=
 =?us-ascii?Q?XlBgIaYR+jPcjRcXxcZs8r9XzfbQz84WSEVdbAkB4susHa8PD4/rat/OVoqE?=
 =?us-ascii?Q?PsPd5UyTWXqiatju8ldB9Mhcc6V2tynoWAOwn+SmhYd01xVz9wFhLCW2U2XW?=
 =?us-ascii?Q?CqD3kWB1qr0LhK8xDX4ZbE+HKZYFYh7RXn9ZMQKS0knLAhnnlT2fep4JX2cA?=
 =?us-ascii?Q?TMBsJkCwkUBQD0Q1yMSQsTmhd3aI1VKVhCMjSEwxVXqgaxbaFm6MZKQi4ca3?=
 =?us-ascii?Q?nXEHtxi5SfsvOOsUQLtpSUmIXIgKkE/qYEgGHEvqfbwflc2B9r/byNENS/6P?=
 =?us-ascii?Q?uehge/m3YQczHGAwaIRu/INaCfu8UohWLyjdH1BxOVvk9AZSU5Gyb8cpIHVY?=
 =?us-ascii?Q?MMHFcJXWv48E9S0NQJzn7Ndippy1bg+cQnU4hWavULOWHJFfJKHNp4cZHi6h?=
 =?us-ascii?Q?UYgKGHFnD1VXOoRYnRZok2LAlw+xl+sCwp9c1WJOGGQWT1frJYi3gRE5PJXK?=
 =?us-ascii?Q?8O+Tp04gB8DMyEWAODe2CAyyDLyw/aE2iQo0N0fZvT1IVqXiJOj/O5LGR1dN?=
 =?us-ascii?Q?iE4k2NvoHcNeCKqOUK6ArKKtSgPvz2mjTKRsM2XbwOwL6tieeqeGTDnPSI0z?=
 =?us-ascii?Q?cp1wEfpgOaJQC3u4i4z/BYgP474BRIhzCkpqKqMROai5HLll3vXXKozgtEJ7?=
 =?us-ascii?Q?y3ch8NBDl1qZCuUNK0hsLg/vu/MDNJbCXo0mxd8QyGhTqKZgKLEEKRhQE0iZ?=
 =?us-ascii?Q?A0BaT1UlN73sJNUxL2/8lmG/aS1iVdXxrrExhuYkgRU92TNdwq1uMZl+G+Ml?=
 =?us-ascii?Q?Wb7eAZklMw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b784e1-0456-4b0a-6229-08defa3dbbaf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6180.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 19:53:38.6597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cg7o1mnBuKmbM0iGPaqliOzFVqQsZosXUT1r3dRI4bv6WkpFDGfVRQ1IBvSlxk4lK0eg3Ec2c/EK9gMDRpA/qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6922
Received-SPF: pass client-ip=52.101.43.122;
 envelope-from=john.levon@nutanix.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 14, 2026 at 12:48:30PM -0700, Naman Gulati wrote:

> > Given that you've introduced a dependency on VFIORegion in the
> > include/hw/vfio/vfio-device.h for the other callback, I'm wondering why we don't
> > just store an array of VFIORegions in VFIODevice instead of reginfo+region_fds ?
> 
> I tried to maintain the idiom that the VFIORegion region is synonymous
> with one single BAR region. As before each VFIORegion has multiple
> mmap areas underneath, the fd for each is now held in the region_fds
> list.

Sure, I didn't mean to imply otherwise. i.e. each individual region - whatever
the type is - would have region info plus some number of fds.

> > I'm also not sure why we have a sparse mmaps callback - why can't that be
> > generic code that handles both capabilities? Are you concerned about the cap
> > number clashing in future vfio kernel versions perhaps?
> 
> Yes I wanted to encapsulate vfio-user specific handling within the
> vfio-user logic so that it doesn't conflict with the pure vfio device
> handling. It felt odd to me to introduce generic handling of a
> capability that's only exposed by one flavor of device and not the
> other. However, no strong opinions, I can refactor and generalize the
> cap handling if that's preferred, and the risks of cap number clashes
> are okay.

I can see the argument either way.

regards
john

