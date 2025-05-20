Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB47C54E65
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOXl-000570-7W; Tue, 20 May 2025 11:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOXT-0004bG-IG
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOXQ-0002nx-SH
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:54 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KEqgNb027716;
 Tue, 20 May 2025 08:05:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NYHfEYolJYtB7ztdkTtSBJXJfFu8OJVZtPxqxjVBU
 gw=; b=Dat0Gmjnno3WqePPiuucR29OvKp/N+egOSsZIBr4Fr8N6m6hGbh1Lbqua
 oit9utHmAXuYwq92WtN46/r77xu2DJTPvXZAvntL6jqv3LK1X1QATdZe70JPMwxB
 Fhl5NhTc5Cht0kBgBNJyHDAH1aZaMVHLn6rrLylI01NOhQFeO5oyfsvojDV+Q9d0
 XapsUJaeDaGEwOHvdoy/F6kBtTElEcVN7t9eAm4iEEmRJcCqEfadwMaWTdHrQM4c
 ERfISw+sUHnT5qZJaCRBc4La6f9mJk/zHibBAi4vpE86JDZPwRc8EzqAbfwaMqEL
 Vtu1R0hUoYHxrZzEMvOAJQxzxelww==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshhec1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlzlOX04m/c5n6NtOO5csETChK8p3NvVTpm2IkgCjslZPGfU+/JeDlxT9cFCKQSXq9jY5ZX256s3yyUMBk0I1h26b7pSReMqL10IeCGOVJGp5Y0qyJtHRBpKwBZWATXVXO+UvBhWP1zrFtsW9raI0BYZXygqxohN+KjaZOlNFr4izHlWmgEZnE4ZHgSUGkyjl01iskLptO2Sa032o2/GBVst4t9pTWnsCmaghdIO5HBi6xooAQ5IAMB6AIGeh0hrh4geS5a+ysRsMVP3aDAPcrYHC9y+yptnz9ypzDWbkGxiu+AZYh+E0uahKFYzc91KuPnngaAVEx7ohuxMDYNa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYHfEYolJYtB7ztdkTtSBJXJfFu8OJVZtPxqxjVBUgw=;
 b=NltH22GIxkKs4KNmNHgBEaEmp6pBK/vNEOeWfRY1ZNjfRtGB7IJdnQSUenNlc+8GR9ZDs6lkixuo1Wz9dcJXnGXZTgUweT6R77sv+4JEW4c1YYAFngQCQ5JLIAIwk0VQQLKeDez7E7hcleSmV9y/brGrOWL4yAHKziC492fpwo2G3rL9Xc8KYAhpklSaKGoQsxx3su4WIHhry07JAyJRb7UFObJB8+w3qtDKwAblYxPleHLZIPdfXIw1agiDLtMs5lDcLiXsGoP0owjX2h+DSCJF1oxXaNBkkJBuprYoHxaq9DZ6Xc1pmrvQ2wbWtrUQ7JgLDP2cQX76WyAFx6Ju9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYHfEYolJYtB7ztdkTtSBJXJfFu8OJVZtPxqxjVBUgw=;
 b=p+qXTHMIatEbDANOvRZqDY0X8e0otEi+htcdKOSu6vMTfpSC9Pfn8wHkRhxcLcpxJs/1+DIUi81ohQYLcLbjAt73I0z1MbPY9TKPTFvirSSjWvHuNxbdlauDFiDwNBDxh5VetxDdxgSc9tzvdjJxYB1NifqN1D8qROvv/b/sePgRt0Gr4Eb5QjO4vctr5n9ojeieHi7TOjW1jSm9tzCckRHJbUPnavuLtEgA0hrdPI4SPCn9getYs2v5bJ73zAEVPDS7U5sJdu1x1NzzgukIeMYvwUqRC4nqM7bNDZin8/4suDU/h/hQ+8YWEDwaP2pqeddCaluD8fvRBFmvPkg9lA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8582.namprd02.prod.outlook.com (2603:10b6:510:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:38 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 29/29] docs: add vfio-user documentation
Date: Tue, 20 May 2025 16:04:18 +0100
Message-ID: <20250520150419.2172078-30-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 9821a76b-a70b-4b91-d6ed-08dd97afc799
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6iQfReRzTh6zMYgOGFlUOyB1IPrh1i79lw/W9t3CDgpTDwtGFT89KlKymfoc?=
 =?us-ascii?Q?38v2Io1jXJ9D+NhGQoFksHYdv3CPxeNlVkQQUtPqlSLknzvmAqHMfCnj1iK1?=
 =?us-ascii?Q?8y0kAR+2PClJcHmjPdZjCLjoA14BH8M5MdaesGIKzMX+f1sGYL8l6Es6h0A+?=
 =?us-ascii?Q?/7J1oPRtimgIJ90VgFLxisD58XnfyJic7oyaZjaJHemp4oFow4zkROt72xr+?=
 =?us-ascii?Q?Px/B4OLYa+iJQOKATObj0rHMR17c3oJlmXVBMa6kGca6QJytr3Ik40fvIS9u?=
 =?us-ascii?Q?x3V/Y44nf/E63zg8bvyeWPGVNXWNxKzpdvd9TvbGPijsjK1SHbYchw6udWyK?=
 =?us-ascii?Q?DYqh08TGy7oy3tXHvZQhYg6QhJzJIj0YA6gP6fX++JJ+9eKCDlHUw9EqbR3S?=
 =?us-ascii?Q?r6T3Kuid++YWv6UW1tGJ3fzifsF9Jmz+PEJtLMPYcTjZ04EKu63fDUe37v58?=
 =?us-ascii?Q?5T/4NHN1lR8aDjH1DUjRW2ClK9n9UCqsPU9f/5vlhKDOXXt+HY+03gvFoqxh?=
 =?us-ascii?Q?5V+np6sg5qorwzcu7JYrJy31tYPmxhW4p6uudyhibpGA8Q6fKURsUqvoHezu?=
 =?us-ascii?Q?umpKQDe+zwCmcYlM2Xc/JqOsggMW/M44Q9yQX5LkkkCjpbzERwcWyeJBa1ZG?=
 =?us-ascii?Q?90StrVuIEWQ6jXyqikPsaKEs1ODzjl3RqAzFJC3IHssjFM1qM7nxZ9oz37St?=
 =?us-ascii?Q?KYSaafGUoW1PERhDDXY1HPwcoUeMHtmjlceKCpt4crYIRoyX+cG3pFQIyJzm?=
 =?us-ascii?Q?ueTJmUOFHm2yhYK7X2LC4/0Tx/wOHpN4LqbaisUR2clupedbN4u9lSLcno3j?=
 =?us-ascii?Q?KnD6nzlFZYo4wA7ZHvDofBEOVhfiB/c3w6lIs662cffbhBjFw/bk2lW07GtW?=
 =?us-ascii?Q?iyhV9AeS6NkLfy2eLyqPeDIV0mA1osavrc14fGoOAwTzER+bmqGttLjaQ3Ye?=
 =?us-ascii?Q?N6Ro9Q+CbofI2gB7ePnnrAAD+WwGKutAuk+QHJbOZQZYxmjdREp7mVUn1DBa?=
 =?us-ascii?Q?MYeTXg0CSF4qCQ3siTXsN2E/DbnpIinKSPlMVhNmNBuvKiuPsTo23+RtTCOe?=
 =?us-ascii?Q?WQtU+X/wt1eARMedSCJH5lg6DFvkJoEzMlwpzwj6DtbeP8GJptlvBSQ2cgvj?=
 =?us-ascii?Q?2QNoW8dMOrRj87OU3sih+ECLixggepNrCiGsRNp/SBsQU7EwOw90f4UDsaCV?=
 =?us-ascii?Q?v9i+df+UMes8lQ66pLc3SskkrvciXfx9bCoamzpJUwGPGzv6ikM6n1CwyC3O?=
 =?us-ascii?Q?DWaAU7Z4SYcy/6QS3b4F3wEDLPaLzptpJRqNokCVRVSDQAooP0O9lpUqsqdK?=
 =?us-ascii?Q?cGt+7aiH0KY8MZSXbpN6LAv0vlW70zu0+dYtHZVJuzZ3zVI66gzkSqxYqbPx?=
 =?us-ascii?Q?rYB2cOv5+x25Q81NBWr3BN5hTK0Xct0JG2WEZAPpqoqxNwBEoXuIK4XT6gHm?=
 =?us-ascii?Q?fIhNnDQpApU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3y4I5ccDHYpIZK7Ktmvs02GogIvtylTpHelOo3vD4VYhtSD9+PjWB0XMWbx8?=
 =?us-ascii?Q?KHfrSdI9i+SNU0sEsfI4vGCIf7wQnrmzTPvDhRlI0iUzeCjn/kLjfxX1YDAf?=
 =?us-ascii?Q?YcoFlLdYcMGX9NJwTG4jevxuJehSaL6S+rNyNcJi9lln/eYznIwDuqZ/aHOt?=
 =?us-ascii?Q?1OMkrbS+2Ce80DMG8sz0RLDUtFn9Z4RWvU5RBDMF0WYos4/vQHX3FOK9h43b?=
 =?us-ascii?Q?tTMiPa2oFA0PwqH6BZBIbASRDSlHtwiBU0LxADqZxLkvaTPBYaaMIbX3NHvf?=
 =?us-ascii?Q?2GvspBcKg17GoBV70Ol8Z7mN8ZgcsF2kxpCM8LN6Y2wV5YaXDqgd1Iya5ak7?=
 =?us-ascii?Q?eei4tLVyC+xvT3L53PrHxTXANSlF7FIYJcnAEQdh8LOqvYCyP89S3DeJnWsT?=
 =?us-ascii?Q?QRk5iOvCFc1S3H5DAlA/z5wNtSY0fBeFKvC/EhnNqVvhyj1sjNc6Wh05UW6R?=
 =?us-ascii?Q?jAOSSRTW1Nwkk+NlwlAZBrW7Ml0vdqzmCIjqZl1jJ4ZQ9safMHf4KZg2RoUC?=
 =?us-ascii?Q?weuSqdKWgAuavpO+xSOq3imDB57L4MEnooEOBvPhfIL+/j5D+X+gt8HoIQI7?=
 =?us-ascii?Q?qNyJ7fLYzNeK/YheOr9av57pnoQkB9oPkok/tD5SKTFKQ+6vMIkQ/FX3QPos?=
 =?us-ascii?Q?KCbYqYFeGRSMhdgEBLFYCrdlXEOm5lnpXmscWr1uetvaGq4NJHaWEXiqLzSP?=
 =?us-ascii?Q?7Umv9S9qW4XFm6JToj1DuhE1xib0+7DNWDyyKVPTJKADnphU2UnnKPBLDE+2?=
 =?us-ascii?Q?wfHFSgrYgrS4r4JXa5lwp50y94cLaXJjYQu2wfE+UgmSC9VCLQge637z2Jaa?=
 =?us-ascii?Q?vMk4lbfVKTeyk4K5uqJDK/bRM2UksETygO5ui/M3BKpqglUYzRIPdN4fkRzK?=
 =?us-ascii?Q?yGzw+eHaOlK4nSzHH9BT1qMieVvO0elgbNhSMjXNCBpPyhtOCjYEYf+uKrne?=
 =?us-ascii?Q?4uzmno2wyKEq0geXfE/5kLqaaYsKk3T0vdrz6cWjtQR6lM3jbm5QfAeyHuq9?=
 =?us-ascii?Q?T+l4rTJ9rhxv8M5/f+oXi9VfNiW3fvjfPMK0jWmTysqZpw1YgqyvC9epOWym?=
 =?us-ascii?Q?EPX3BovHL05HHyHTnl8T/GOvxA1YM+fOu4gWLY4hWu54eW2XgvBj0nbZxcV1?=
 =?us-ascii?Q?+TNPAdVWH9aUHsu8/jFS15QGfOGMNaP9+aBODwSoJz+hnv/EL17ejl4EXrGl?=
 =?us-ascii?Q?RGoOlZI60jTPGOeRXrt23Ib/xZPz4UTjI4eNTsLRyKZ5YBrniPuHvdEJTwC8?=
 =?us-ascii?Q?lxZBg4QDA0NOwfBJA0GA3WmziriuT6JMXxRltTRfvlzK1Y1A59sUfQp8U9bM?=
 =?us-ascii?Q?MKep7FtcdmbQja2+f6K3adMvTsxTkDXJJcQIpYwWp22qpPBp2sKp4q9vjOcd?=
 =?us-ascii?Q?r3xVKuQR7wT0vk9Tj1khVjYkbAjyOPc9Nsj9VJJAav0hq9MCKvvf0KoMr9JT?=
 =?us-ascii?Q?FbxorvplRumTi6Su08UcADSWKmvrIMIoSs4rGacDHRFKqsIN6312g411fTW+?=
 =?us-ascii?Q?LZM9qXAvUg5I+7AlJ3o/6Qss42ssfsD7ASmSFQRHIwgpJVc3ufZOQw8/uY6d?=
 =?us-ascii?Q?f50yaxSAG/i6D+OXiIjKesG6kpOUjKcd9WHUDx5D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9821a76b-a70b-4b91-d6ed-08dd97afc799
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:38.2057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4BUY142ZZKjwtPvXJXcPDcPxFE959dstBffQLLa3HnYoUBB2hnrzW5B7FPaHTdPY4JZxK39BeUzYVfw4wP0Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8582
X-Proofpoint-GUID: Jsg35I8VSrZ0lmDsUugOPZUzmNRNZSG3
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682c9a44 cx=c_pps
 a=wXDgSYWbwZencpnnUUTq5g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8 a=64Cc0HZtAAAA:8 a=LOSiUy74ef7l4vre4JwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfXwTJ/p3iefjKQ
 ToMI2Mi0C5tD/5DspkOa2rTxvo7dT7YDgGdH7BFvBjlWTlOM+5TTT9Yh0Kso/MpLIhCLMyZ+2ZF
 Ix36hnJ0S/9gS8ffylWnV0XYh7n/cK1ON16dLRBkiXbA8guCHbL6qge9pxY9hTL6nt67IL5Ud68
 BwMTM2eu8PUtgnnjSASXZ1jHp09jZO8UfV04px32jBC42WIqsdgMlBSpwj7NQ+s4eoyDLE//gEc
 jPLpcoqqrmETeuhdHFAhg1t8wDndyOuSFKiIUavcs9l7eJ/xUH7HVtFeX1r7otLqJfNsRZRc80H
 +ar3XTjBzC1dK5tppjpmkwiPpAL8XuTZluU9/FMW3FEaYJ551igVAYyVS992K5vPb2N3Gt19VKP
 ADzEBwToGdlh8UtizKuTJG2GxVgUrLlBfyVqI9naxzAnm2cLmmLig0z1waaOowJ60sm8uLab
X-Proofpoint-ORIG-GUID: Jsg35I8VSrZ0lmDsUugOPZUzmNRNZSG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add some basic documentation on vfio-user usage.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 docs/system/device-emulation.rst  |  1 +
 docs/system/devices/vfio-user.rst | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 docs/system/devices/vfio-user.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index a1b0d7997e..911381643f 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -85,6 +85,7 @@ Emulated Devices
    devices/can.rst
    devices/ccid.rst
    devices/cxl.rst
+   devices/vfio-user.rst
    devices/ivshmem.rst
    devices/ivshmem-flat.rst
    devices/keyboard.rst
diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
new file mode 100644
index 0000000000..e33e49d283
--- /dev/null
+++ b/docs/system/devices/vfio-user.rst
@@ -0,0 +1,24 @@
+=========
+vfio-user
+=========
+
+QEMU includes a ``vfio-user`` client. The ``vfio-user`` specification allows for
+implementing (PCI) devices in userspace outside of QEMU; it is similar to
+``vhost-user`` in this respect (see :doc:`vhost-user`), but can emulate arbitrary
+PCI devices, not just ``virtio``. Whereas ``vfio`` is handled by the host
+kernel, ``vfio-user``, while similar in implementation, is handled entirely in
+userspace.
+
+For example, SPDK includes a virtual PCI NVMe controller implementation; by
+setting up a ``vfio-user`` UNIX socket between QEMU and SPDK, a VM can send NVMe
+I/O to the SPDK process.
+
+Presuming a suitable ``vfio-user`` server has opened a socket at
+``/tmp/vfio-user.sock``, a device can be configured with for example:
+
+.. code-block:: console
+
+-device vfio-user-pci,socket=/tmp/vfio-user.sock,bus=pcie.0,addr=0x9
+
+See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
+information.
-- 
2.43.0


