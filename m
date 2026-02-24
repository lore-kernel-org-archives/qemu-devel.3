Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07974E9B263
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 13:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vustg-0001WN-1x; Tue, 24 Feb 2026 08:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1vustd-0001VQ-Lr
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:56:17 -0500
Received: from mail-westcentralusazon11010052.outbound.protection.outlook.com
 ([40.93.198.52] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1vustb-0001Az-7J
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:56:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQiJkCpm7JAD6e+fFWmI8adIkOz+TfkeevzwMC1ACvnTAZ0vxwFis7ildWCSyzv9nPv9ZOJiD8N8jca0/quooQJj/H3c2jgXpYy6GXznj6PfBPdMD7pvVd6GGP3KClZPE/m5vHcGKmvxmwktwA+X2Dhf1/kid+3g6HbQjhgB9iFRKkWmMp8XnDa2emhIJfaJDKNju77T3JHMYLPMi86srrO3gour4CWPfmqn9SNLNlsI/l6B6zl75jZJPXoEWSIW/d75/QKsyMn1f8gWL0/zH+j4KDdw4xeWVaEJgfeS/WtEsG+Q/+f3jlfykiXxt+V6xpybjye2SuYcxYCOZyEAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8BsgWS0S7SwdyRQQd19RMvaphkH7W2fc57mcHQ/3i4=;
 b=mQt5JYQduhYHUvQK+QyMjjNmFDPLdGuflzR/4K9X6UKDkeguEpEmZ92lUCdIEYw2oiEV2GfHoLfueD7iR37iOmeep2AZmeaj4GYnJiahkw6kyi1GSgDrtcMCARg9sHdmDlOs/AS2cHLfV0KntY7vk0+g0R0xeoL9z2D2kmYJJD1IO38b1x+eYnDPFbYHM2fK4QKwJpcGksBhxuPwMLvDDpEpKQlKiI32UUFVj0bWMqAd3LIPFkCtgKX+hVrTDWXIjWwr7+skGDLNkFXMPJz/h0RU+Ykxf4b9UhUjMebXipLqHuvxYPy9aWE/oYFeZHKjADFZ9seNhYcKDNlJuHsSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8BsgWS0S7SwdyRQQd19RMvaphkH7W2fc57mcHQ/3i4=;
 b=hZNZcuem6jkKSx7FUjPeNG11EEYmXjLqgIKw0ObyvZYqgs7dYz3XunBMgHYQ2aYSYcqaOVeOyhRCY76qZbZMOK+mNpT8VX+nCOluGJnRoJRI36SzTLfTVpDc6jFfjaVbTmqW0xr6dz6Z1nSM6zbO6RjAFrnl3FDpX3n5CBYgaBO5EWBWKi4sq82aAIu43+IAiftTG5EWryJpZS3URWGX1gSgnuoyFI8lnK0CHSBPfeGIzskZltiSle11DqHdDs4UqKjKirAxrRHNfTQdv9Jd+WFw+zHAh9nPfki/HEebRRiyZzFwZ8qPIxA0l1zqaFjD0dgT3QsQEVzgm3x/NWR4AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:51:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:51:08 +0000
Date: Tue, 24 Feb 2026 09:51:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ankit Agrawal <ankita@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "mst@redhat.com" <mst@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <aZ2sylCydE9Js1ec@nvidia.com>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo>
 <20260223111302.00000081@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223111302.00000081@huawei.com>
X-ClientProxiedBy: YQBPR0101CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcb7b1e-4687-4210-d0bd-08de73abc2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k7AQ0SOrb4WpdtgwneyNy1WrC2Oy1YOeNC1GWLXWIF7Jscq17nob5tluEyfd?=
 =?us-ascii?Q?xJfOfA9OAchq3AwYBsgq4ru3vnGEI9qocv/tE4OPf/Z7pXNKC9Kk2iIkBFiJ?=
 =?us-ascii?Q?pOttifZoZQHt4REnchGvvQEr23/nXgixLbqk0Mx51a//y75uGceOYvLmUrzg?=
 =?us-ascii?Q?MoisCY/OT6BCaEin2QkntlBUA7pC8oRv3CWYdvAFT53P01/cMQZ3H5iwZRCa?=
 =?us-ascii?Q?L6mIpG4jU4HJZwAvFaK73Ue+AWiY8u72J156NwiJEOOv/ZdfGwIDJrOvd+eg?=
 =?us-ascii?Q?W513dSoWaObb292UzWELRlwi77tRqK5KstrrW9qG8SfI3qg/aYfGM60/PteD?=
 =?us-ascii?Q?cLOxdypPxy3Zvgxobz+jMMkslaVILFtiUAtuqyIkG1xGWIZsvY48E8AK+vRv?=
 =?us-ascii?Q?3S81lIcUCE7TocypmpFVftM9awaBjCmRHcV+xktjyawAl0zffoMycIqT/KE+?=
 =?us-ascii?Q?zbO6+fjFqDAhnCJ2sUUYpJk53cJ1iZFySMSRcqty/xMN3JM77Ym8O8mLfKot?=
 =?us-ascii?Q?cAc3h1L5+FkfRtOr8lC4Nq4+4o4lJ3ZJNKkeR3PQsMr0tBaXBfev6kXYCf6n?=
 =?us-ascii?Q?JBhKgNKGGsY5hoNKaGrBgiiEiLwoXYJYiUVBOqM6KLNVcsjtd5BkDyvI+UYE?=
 =?us-ascii?Q?R296gI0sSoglI68j4FYjwDYeDZum4SaWMUVFGFyzFs7rZXLJ5AbYwv3Y5qoY?=
 =?us-ascii?Q?BIKtmp0XFNZSfPeqB4nsPVWzQ68WspEe9OGyB0mIeAyaGspoHSbLbqlrUCw0?=
 =?us-ascii?Q?LQ4bv4FZC3vMFPtIgLunrkv7MWcvwcDcSRl5L9FNZ/pjGL9K0MH41AOuKKUq?=
 =?us-ascii?Q?CDoJdF1wvDAm3JIoPTCkXUetKszWg+eE8yP4LCvOxXYIBM2fvFHMB5cSX+lw?=
 =?us-ascii?Q?j1kT+QyHKryOXsZMMdAwBhXeu4snGx6eqGUCbH0uKeTqcZlCStW6XZqYqwMt?=
 =?us-ascii?Q?hWs/nH5Epox0228qJzZt2BJBcISWJNE4NAmUfYN93/xGH+BQ0MaSK+4JxtsM?=
 =?us-ascii?Q?K+GNtdssAH7Ws8f1ylC4n3Iu/QkIa7/A1WloAqUTTXW1672BUCtVF2IKMVAL?=
 =?us-ascii?Q?JDxNDUMTJuKIJloAkXaqqILkp0uvbYB4u0qPRPERDXmBV/LCNhsD3YoqNje4?=
 =?us-ascii?Q?ngiigYg7Ctr6spgs1l6o31SnDf84V4rCn+u758PNmNGO8gidDQtU/pjwJKI3?=
 =?us-ascii?Q?ZBoNXyWUJ3h6kH70j7mBQcxDKA9Q+VEo56v1F2qv0AQ8E67P3TVqvxW6w3LT?=
 =?us-ascii?Q?5PYGoEFug/eGrmtYXcvzf2BNXcg/EPv1ahQk5eVZgUv7raBL/83ZH6jQla0S?=
 =?us-ascii?Q?26O9qYXc3Uvi2sYZnEQM56N7Rin+Rqw/Io77dxNM/Zubs9fMlmdNO9/OQ75v?=
 =?us-ascii?Q?NkmzZqGehVXYYs9waRY76cYDBfjDK0NgSpLTg7mbgzSHFJgKIUCvZK1mctX8?=
 =?us-ascii?Q?k0e4yqdA8L+t6EfBY5P4wg/SJ7HkcbfqGSKHJ1PGge8UFMS3gl0+/Bc6Mhgs?=
 =?us-ascii?Q?emqBmpSjKxsAVJksDKH+VCuB2VepJHcymMVb6YMPqzrf+jJSfm0nvvTZXL1A?=
 =?us-ascii?Q?7qiQayNZ8+LD3r8SCIo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qwBlwQzOvacZsBZuUYxi9L6yacDW+nAtk0WyAhbQuVJRH5maLC/26bVk8BTi?=
 =?us-ascii?Q?5sWWZGldaz+NqZUXuyr8iNHgx1zt9dR91tftqSAAeo8cr9F6QOAcnp2A3dbi?=
 =?us-ascii?Q?dHj4HCOIW1Cwgj7jw6Yobx6EWHpjgVulXjiFUqGizFhDiSl0l+12G50pxeJm?=
 =?us-ascii?Q?ZHovSawq4Uu6aFbXXfezp846KGzLHJLvc0PJpNor5ue4WnYBLK+Usb3D/zt1?=
 =?us-ascii?Q?B58e7O8J4xvo8wxTOjJzZpQys76aartw2/OQWZrbkIM/pjj5n5rqluTWqL1e?=
 =?us-ascii?Q?JEv/L9fx8G6H+sFtQU+F0l4qBJX/PXx69q7kHrdy+WXjK9qvIFTXm0JyApD3?=
 =?us-ascii?Q?9aSneyson8Z/c+Jj6iUnICAo1a8b86DkmW9GOOSD+5i76pfU0cYqxBAJZr0t?=
 =?us-ascii?Q?F3sSfSywby2LsUkC9DfEYHIwcojI13s7dRrSfFB+KSVnSqKmm9zto8BMdeVR?=
 =?us-ascii?Q?vehKjD3Z9TTaP9AAN47sLQrjkxSIE4THY2UJIOO/oW3Nc7qHb3K/LJzuxDKY?=
 =?us-ascii?Q?5IztdsmDdUC/Pq/Say+WYTEtdrvU9g9Jwd8m5LcdzifpLQ+BE1e+QvS8mP8D?=
 =?us-ascii?Q?uDBa/A9nkUBbLd72y/9xwOLzX3JUNbe/Njg8J1CEMudrmoff4iML8qGAooJa?=
 =?us-ascii?Q?ndT+zN+4BL8S2rUAGYqNLl12QmOoGdcBnnw5KPOQd6XqhCBUJ4RMYsaZ05gG?=
 =?us-ascii?Q?v0VSApDIvWzKZZ4GP9C5+1OA/xqqw8b9dg1m6dasYljwRuDMd/KK1mdyBYek?=
 =?us-ascii?Q?/YyehMRoQuRq1e98r9dgraJyqUrfIm4IBhRsqDHQ0J7uROFZ2J2UfWK2Ecr/?=
 =?us-ascii?Q?k/NZZ/cytL3c0FBnaPm4JFoHTeI6T3jrR4r6k8ecoNoROBWXerZwc6pk6IeN?=
 =?us-ascii?Q?VTaHBIIukZ19UAB9KF8njg1TE+4tT7QdAnQzm/3t7eiMJnv8BssQqfyTwoou?=
 =?us-ascii?Q?HCxEAG3v3N19lCbqJVfFV4ofyGb7+AMi14N4GZTEBAXmjiScgkmHl1HkIRqx?=
 =?us-ascii?Q?F7UNLrYin3uzy+ozcbZfaJp9Os7ILbu89B3l86ybPymkVyQCHCEiQUrlP1BG?=
 =?us-ascii?Q?Z6KOebyCyb3/O/5maCP4ewceA8Zce6SRFPFDuo91jLiQ2aQ/l9sgebfmsKqc?=
 =?us-ascii?Q?alQ1PxB6qHHbaHQQIVRXe9kilX+m8FWQdkWgk47uLacXjudci2jd1jDswTm0?=
 =?us-ascii?Q?r7g+Aj0oRI5xgONoxVWgyNUTXvzO5PZD2XVp547Erx87+YN+RW6cm/lupFWU?=
 =?us-ascii?Q?uS6HPD/zIOOcBZIHGrNtnthwa7SHMB6E3IifimpESNWJf8kQo6w/XglHUdi7?=
 =?us-ascii?Q?4edxw6gbsR71cBZVGUWIZI7vnCag3T/7QSUgYOQ38Qdhx/chzVTT1MRpd0P0?=
 =?us-ascii?Q?FS+L4WJ4VFpsKpXROd2YfvaPwCUHaZ3lJKpJmi7ZxnhjpMJg+Qs3zG3ryZJ6?=
 =?us-ascii?Q?JRo/qIaCXwf/6nhUMH8flGui4Q5H/zP1Oig+qeR0TPjXBOZtO6R5bJGrtUc3?=
 =?us-ascii?Q?9aoGunqX1jGPCOTFGlxlpkJt5aqJgUkFpcsOTOBo8BM+LqgKgI+42V5WznTO?=
 =?us-ascii?Q?gMj7ZQE7FA/ba1Jdr5tE3euy/uwPpTKgw7P1WQDrw5L1911WniZRJ+TGIdhr?=
 =?us-ascii?Q?ZR+RxXIuDfKfUvvtpGHvYbVWPLYNQBYvqd1LlPMzlZHgf42ThEqQhMa3mXKP?=
 =?us-ascii?Q?q0fVuuzfhS23YZPaWWsAtDe3OVeRAyxOsLrotrFn/8zQXn4Y+/NGbcGE+TYa?=
 =?us-ascii?Q?Ls/tkfaTjg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcb7b1e-4687-4210-d0bd-08de73abc2b7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:51:07.9770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWokW0qYhTmwv2zXyVactMHi7Qu6ZE/WBpURyqisW5NreEEB4G+QmTyKd2wxeINT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
Received-SPF: permerror client-ip=40.93.198.52; envelope-from=jgg@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Mon, Feb 23, 2026 at 11:13:02AM +0000, Jonathan Cameron wrote:

> Ankit, can you give an example complete with table dumps please.
> 
> I'm a little unsure on where things are getting scrambled.
> Everything should be keyed of PXM.  Sounds like we have a bug
> somewhere but ordering shouldn't be relevant.

I understood the issue is Linux assigns the uAPI visible NUMA node
numbers based on the ordering. The proximity/etc internal to the
kernel (I thought) was OK?

Then the problem is that uAPI has developed meaning based on what the
bare metal HW does and now there are SW stacks that are expecting
these platforms to have certain NUMA IDs in the Linux uAPI. Sure you
can argue this is bad/etc/etc but the point of QEMU is to allow
creating VMs that closely match real HW and in this instance real HW
produces an ACPI table with a certain ordering and the SW is sensitive
to this ordering.

Even if there is some Linux bug mis-parsing the ACPI, then that still
should be addressed from a qemu perspective by providing the ACPI
construction that doesn't trigger any bug so existing VM images will
work under qemu.

Thus qemu needs a way to reflect the ordering on the command line to
properly emulate this system and accomodate the existing VM software...

Jason

