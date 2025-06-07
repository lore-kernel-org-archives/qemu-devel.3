Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E8EC61CE8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9g-000316-TT; Fri, 06 Jun 2025 20:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9e-00030U-RC
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:22 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9d-0006QB-3O
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:22 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556Kvu6o017760;
 Fri, 6 Jun 2025 17:11:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=f5mqVllGtPuPrRQDhSXEAGDYfQ9/kcL/55Za2ANYW
 To=; b=XI1GajnZnFT/BToSgFB7k9f6C9qROZ7iX5NwdzrRERluPctdsraWj/ko/
 timwYojME5Pax/91asT/uFQjL7GcWa5Tf0tKYl0M+ljx/o2dGN/+/WJOBCPu28kr
 kCWVS9lMCkavSIynUiEVVwYthk66mT/eE4+W/s0s8LEy4qJHu7QryBir9Mq8NTg9
 qtK0uWlzwSrJBJ58sQzBRZHtek96ldafN5IgelAiPhnEiCNoSyMkSvCqWNcEXCUq
 9G4jsylqfRWxSgGiRVTVAvbrsTVdqgnnkmzxe1TBvgtJaW7hF05jJGWlwgK1/8+U
 PYr23mIzHiwvj4R/yum8qViTgSTsw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2137.outbound.protection.outlook.com [40.107.237.137])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4747u3r8fj-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+MwpVAaWRUqQ577GHjbFlJgs7zCEbFpSlaQiz1bzavYmQXAO8bxiHT12dEjoLEEV2cWTUzbBgBNSMf3MWUWjaCNY0daOBfhVejpG1hOR6/WSGfDU2H/dLkbInsw/qUlvugKPRHdDFUoz1HSZkoql2jhgzoCRrbveEi0FUwMS5VjO+rPDU+/aCneU5YueJ9BmLGzh5Gl7N5jcfttFd7PCLxpmtWYvy5chpoHYL4F+JyRR4tNHl/T/SHu0t7KUnYd61R2f3Ap6Ew8T8KPjJ4T2GNsi3GFi6gmz2R8DYBOS6zAWrB+r1m51fyWOJ5URUjM7Pf1qS8mnrYBm+KtuIJw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5mqVllGtPuPrRQDhSXEAGDYfQ9/kcL/55Za2ANYWTo=;
 b=FkRLRwP3PfgxdVr3+NyGa8Ql7qPAuij9CPhLvaztX6Je2v13CgOmtCE0suLGD18HjvSShSY60t1vJr0oclC4ynQoyqufWnCqmSEszVyJN+CwPb6vdaVf4XMaPsc773A/hNtzHL6iNy/vYv64vIQ6GV/ciZinjkbeJLEwcVNgW/1Cu/r7Pb8sGt2lsOFMX1Qk5BEK5x/q8slg0bbhDzXj9TjM+7SNbv4T0VwVp/Yn+AEWWAqx1j8YhfKTgZiT2ecHUv22l91XSCPQ3erprIA1zXciko9Lp+Xni+AeLzabHb24TKBD5kEi6qiVKzlfBcbJLqvgDX9hZDDZaRYFP5B6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5mqVllGtPuPrRQDhSXEAGDYfQ9/kcL/55Za2ANYWTo=;
 b=o7zfW/IvumeW4nhkJQUZjTFPzgajKnz1GtgUgexNjDvYPfW4OOtpCZ5ikOZ3JQXbo0PewkT0hHvcP0CdZvF5Aob3jM71vpVDGHbfM8JcZZ51Ox0zQWCg0gGI0nv/Mbv8ZE6q+BtkvLCAL5IoBi5iu4UiP8HSuBRKEioIuPqhyPgIZzpzuj+VBKRbzAo2qjSLoYOU0Xknz4JjzLCvQokPMjkfqNcJ6fqpea59ImvmHBPVAsPIj4OjHCsAecph6oV/ktLPLXcgA/b/Bb4q/sS1AX0t0kYkuew18d6RY1T3GVyi134hzDxUrGP6yZTV0SmK02ZrZdU2Q80uHiDxK1Ri0Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:17 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:17 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 13/23] vfio-user: set up PCI in vfio_user_pci_realize()
Date: Fri,  6 Jun 2025 17:10:45 -0700
Message-ID: <20250607001056.335310-14-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 7633b914-a42c-4c32-4ff4-08dda557d2c9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W+OPb4jc5fi7qcAgxf+5pfdQJsgvzNTN1Y0tQrESJo9b+d4k1IX6jKxcAPnZ?=
 =?us-ascii?Q?XErKkERxzoD0axiqqeZPc87Jc8ZESn6nWxpeYSi+xDEzYvbODQeQf1jzMksC?=
 =?us-ascii?Q?S6qqEJw1+fKr7Px2G12RG3dMy4R00NjzlCX82cRS5PsEJTiMWVlzSH+5xgIu?=
 =?us-ascii?Q?TOblncGzhTa4GT8n0ajYC6yLujk40fUQBP6w8foNEKx9S4MbRTE4QQ6+53GS?=
 =?us-ascii?Q?45kiwGZbRXe0dP1pZ4gAHqdkyjPUOyG3XDrHUcaA6RiUq0BHEfjE55bWMSc7?=
 =?us-ascii?Q?A/2+gwp0tG2UuZdNfw5zaRkxJ9EqwQ5c1HkiM++0dhhuw5vqfA/UfrBMxLtN?=
 =?us-ascii?Q?p9U63s0IpMSxL9sE7YMqjQIs1FtwgX90RQNqJaQZWhFa1qaXYx0tk+DVe1Nw?=
 =?us-ascii?Q?ani3uPgjiF6cEE4o0TpSTD2QqpYiS+a+1Xf2mlllcLSmGIdFujEijF+wmqkR?=
 =?us-ascii?Q?IBscMjpAmivSnr7SNbBqExOzeVRrThi50rrcvwjbEiPTTwsxzrWjCe9fbHia?=
 =?us-ascii?Q?2zKtY2TTACROpRXOUlbNOzeRJyLuU2J8penBDKLQccu7lef8ncd84NuTbHK9?=
 =?us-ascii?Q?5cRdihzsZ2hu8l4cjDdxCLhs81hBMjkwQpPfaJ0ArG56B3bhdl1U09HV8/Sy?=
 =?us-ascii?Q?Hc0EFiIoqqjGaniWAnj8h3qxwWmIt+JQrlbPNuxgGIJW3IEr1FdfjXkYG1/W?=
 =?us-ascii?Q?e66O0OC3hQgqXlJ8D1AidoHTDJaanwg6rlbgPA24xsfogkHtvIxEk88PjMcy?=
 =?us-ascii?Q?zhEIHPhhKC69iPvFWe0pkdJGtLup1eUtPGlfwacbnIN2e0OQaLzS8g0eYupi?=
 =?us-ascii?Q?g9fd1q3ZRg2J99iRIRwmpTw0GWkm/+mKnzlim7l4uQ+KueFyNjxJot1WlPZy?=
 =?us-ascii?Q?RBw2oUAQs/0xr5oJr5bspMwMHF1KqhU/GTFqbf1CdHuaCxxJJygPz4cmGWuz?=
 =?us-ascii?Q?4b2kq4IpK0su2fj3WXr8H6fXZyLeLfKyt8GCZQspnU+OUNpvIgvwmvbYs8od?=
 =?us-ascii?Q?xIH/sivDGZMGucAsV76TwdcvST118Pxq8wdX9xWLh8o54B7UwPqtAoRt2CBE?=
 =?us-ascii?Q?i83zcfzoPjZT4G6PudfhzZR7dXy93Ztv8AXz+he+cmH4mr9sH+Y9R1oPmZdA?=
 =?us-ascii?Q?NByjnrmG23pFQPLum/g/oMfqyymDn2HmrITmxE3D7JComnJHDS36CI10t/6o?=
 =?us-ascii?Q?auGptax5zzwM1PxaZeBC4oBNo8aRVd5lBkreQT1S70uTXh/N5ZjBBT1uhH/c?=
 =?us-ascii?Q?zRyEPBQB/5MU5mhwhy02Kn4k3BxKuSVimEicJOzF5H1TjT1Qys6jig6cTxEi?=
 =?us-ascii?Q?mcFZnLkxyrioaTch3qKGbscSxSdQujfxsFySWMNgOySm1jaTq/aQLzsgrVYZ?=
 =?us-ascii?Q?ZsKjTi+SzRIs20XfAspF2iyg2G/VDLfkpQgLLPJri48TF2eHZbL/SDzu5pXd?=
 =?us-ascii?Q?MUvLu06o7pE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uuAs1LoArNaRSqgYiL5x03TTBXhaMjuPa2apfdzyhtnThbf0pxrVPQ7vqA/y?=
 =?us-ascii?Q?HoNRoqdSsuh7NrfTkua9d6fZKAp2zGuQzae0bIhBcKr/dVYckXE3QPJNpm4A?=
 =?us-ascii?Q?uUW+L5QjqWHhrZ/FAyUjpeX7XwZCd+fcVq/PuSqdy1lfMvfWeEcCxcILFIiU?=
 =?us-ascii?Q?nNR40W4VZPqgUYVKUqll9KXaXQ0goJlddEvDh4xwWHcfBbOFZOuRxswqSgf1?=
 =?us-ascii?Q?fBzxt8FCamPqyPx4Tgp5PEBWOoAzC1TL24HnZLC4QH1sLrl+aJxr/a3L4Xdg?=
 =?us-ascii?Q?8W9eVnPo0LKpYnIyM5gRzbSDm2+KsKDKOr7mZNk5j5VjIRVt93aNkxR50Wr6?=
 =?us-ascii?Q?T5fNCYvTgaZ0EpXT2ekNAUjTXuyDN38ZYdxNTVsBBT94TOgnIOA+qOTEYc9z?=
 =?us-ascii?Q?ugr9dZSPpiid5qSg16ITc5NZTG5cmpPApX8XDcDCrslWkDkpBPM7he4O1PT2?=
 =?us-ascii?Q?n+6qp6pk5OqdWnnU9DEmrYvDSoQ2ZqX3QW0eFbnLE17sxfEl1oyKvSLSyyoA?=
 =?us-ascii?Q?tA5I3djNTiHiAuNmbjmafCT1Ewv7+DL9HFivUFeWKUPDfW8UaLDuCO/vpXrp?=
 =?us-ascii?Q?OKEheNEccliiDnXlcB5HA64sXH1rGMeUq7LTGXAI+9gGqBVGQ2JUJ5fpgXpa?=
 =?us-ascii?Q?U/j4r5XlnH9E3IWv1xZX5Q5HVr8ZZRTIF5U3Q+17dhcnrSlGG7ZW45boJur4?=
 =?us-ascii?Q?VAJrPc/jYFVQixv86uZTV3Q98X8RjPNHgOanucpPsJcIeZDO4kdOmqj7RPV9?=
 =?us-ascii?Q?yakWmq3p92UaF+AEEbeq20TVJoWhP1s2kbu44iDFPUvivP3qPdv5/QLMfR6f?=
 =?us-ascii?Q?v4K9bL8i7I41xymQsEFiE6DRuA8Q3sBszTCIpqL78ACmoi0w2YvbSNvx8a/3?=
 =?us-ascii?Q?4KMO1ez1Uh7yizxxHMeYOPgXb+3JGZB0+qJXDG9UfgQjQKgV7TvzwtKmt2/N?=
 =?us-ascii?Q?uQWiRLZjQfvZzP36DndhX6fcStwmMg1t8ngrUKq8x6RFye7J4x03lDC+dJZl?=
 =?us-ascii?Q?/ng35vHIyx5Koq6FOtPGFnXt4tqUacC4AOqArTBdwovATDXB6QlAPQY0tRGW?=
 =?us-ascii?Q?chj6qspDNfXZHdKErtPh5XzQyH+L3txj07AgLhb8ZlYXxH63+Gv6c2AMHxMN?=
 =?us-ascii?Q?zhRZwe6yeNKhsp6v0klq0bjPDQa6tG4VdlBg67ZL8ao3c8xD+/zKseWdD4Y8?=
 =?us-ascii?Q?mSIyZ8gRcrJ7736gYug8jCm15JAmKWbyso/SU4erARzruJgDN5ErXylo2nfe?=
 =?us-ascii?Q?Xruwpt5yed/us+uSxNH2RQuXxQWZ2f9KjIm9GnyAdVDYBGrzSYlHmQe8f3Zn?=
 =?us-ascii?Q?gPqlF1cz48AY7EQ5Mwfas15iXMeRhwxz+IWs1Bh82iZ7OdjeV7rTbb2wrpzg?=
 =?us-ascii?Q?hDVW5x1f1fomAoDtsN15DyeOXKkhFFZYlRmLIAbCFTQZ3pvjqSlyo+foKo2m?=
 =?us-ascii?Q?ScQ9Heih8L8fd08jXCku8+jQWsDE6aPtSuLrhAYARwkp7OxZtJ1UNXbk1k71?=
 =?us-ascii?Q?O1zhv1FatmkQzLSRNfbRkJMex52XTBxmh2nXYlJ2sYV2MAy0H5BM93J7nYzc?=
 =?us-ascii?Q?T3ce3aZI8HYVKhUtHNGQBq16XmOfaCA6Uv7/ZJdi?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7633b914-a42c-4c32-4ff4-08dda557d2c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:17.5076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSAfJzuPN4RvoGL9Ik5xQcrEJOZHYqBwJ46xZPjipSRAe3cl+SypqT4DqVE/o4AThsWHJMnA1w0nBel9ykWBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Authority-Analysis: v=2.4 cv=cpSbk04i c=1 sm=1 tr=0 ts=684383a7 cx=c_pps
 a=kojefl/8vcI7rOD5WQpBNw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=uN1uQ0dK97G9gywtELIA:9
X-Proofpoint-ORIG-GUID: X9xdfSyrXr8hrlwNdDydDdzdrfUFhEVc
X-Proofpoint-GUID: X9xdfSyrXr8hrlwNdDydDdzdrfUFhEVc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX80DFTXUcf4im
 NwkHm0ko+XwJaMWVi4OwKtar9Gkt67lkl9Qz46R9BnUWsRBX7UO/7WTTu8Y3lImsfiaTTaQVgB9
 0JIQTZgs4fcT7C4lFKNhdKs/TyduQAwmi/nbqvxlfVuI77vc+6SVdHC2aOJC8unKzz5SIWRS33V
 nrwi/vDqT4v0WIPRtSMenGti+g79kLtBy7NGDbd5nfFfLswysUFl/hmaOpMS4MdaRwvFkCcyEf3
 tb3oJqRMBebOrU7Dy3dIdylS1ilXH7iEB6gUwhYs1SD+mvGpdWXoLrsmqyvVI/GpgMw4PzmzFBS
 2XFZsfbs1Af02XfUMqQtC+2UmPgXrhF0i4rh5LAGY4YEbCh6d+Xvv9YX5lmwS4hMSfhKWB1r8Uq
 hRtj3EFunfIeV20Cuv0Mji2uVm0IHWGnhsF+fFz5WtDR5qUBR8nNH9sq5Rd2PYs3GQOs5TqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Re-use PCI setup functions from hw/vfio/pci.c to realize the vfio-user
PCI device.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/pci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index c2e7283489..5ac3fb087f 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -124,10 +124,39 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    if (!vfio_pci_populate_device(vdev, errp)) {
+        goto error;
+    }
+
+    if (!vfio_pci_config_setup(vdev, errp)) {
+        goto error;
+    }
+
+    /*
+     * vfio_pci_config_setup will have registered the device's BARs
+     * and setup any MSIX BARs, so errors after it succeeds must
+     * use out_teardown
+     */
+
+    if (!vfio_pci_add_capabilities(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    if (!vfio_pci_interrupt_setup(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    vfio_pci_register_err_notifier(vdev);
+    vfio_pci_register_req_notifier(vdev);
+
     return;
 
+out_teardown:
+    vfio_pci_teardown_msi(vdev);
+    vfio_pci_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+    vfio_pci_put_device(vdev);
 }
 
 static void vfio_user_instance_init(Object *obj)
-- 
2.43.0


