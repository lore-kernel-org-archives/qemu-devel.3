Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DDCC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVq5-0008U8-H7; Wed, 25 Jun 2025 15:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpx-0008Ce-3l
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpv-0004QK-5b
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:12 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PErU54026909;
 Wed, 25 Jun 2025 12:31:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Ts/w8AhN1+z0KUmhSHPsWe7gANtjE18DYXmyv7iOT
 to=; b=YFrjEW7MFL+rjUIQWcqvgzuZl0i0yM7XtkfSwlFkT4mW+lHrjnLJW16x1
 ncSFde4DAbU3wNMOUEya74pHtyjOszdgx/RgmR3RKeRVVwT1UgrUKScK9l0PFWTj
 NKrKrma6H0kdB4aSojNjraNoAjNOivA5ucmvOb1Xpemi+FEvPXQSG/Np+Z35G7dc
 t1WvXYZjYqivjwkbk6qtVnFJNu9Brzevj5lcKT2RFLMRsyEBHuQLeBHwUE6JgOXS
 3Lga7Li7cI5t4r2UaJnOoSkhVGJVOqMPq9uvy9Jo+SwPQcYJSaV/Vk9A6oxYk4+8
 auv7DR8w7uBF586eMS6ZWHIxmir2A==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2095.outbound.protection.outlook.com [40.107.93.95])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0hhuw-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsxo/lemeu7jtrQtk2m1Blw/6nKUQDubgupcO2wwMBcK/QiHwukDlGrbFw5KmVkW83Uy/kaSztzR8yCebfdy/vY7lsdYFvrnjWFF2jUG5a+XzE4YpG6dQKavYzWDjD5B7XftX+nAO52QDDxwljq9vHZ8BfMWlBGpl+Gr7xcHQBpfSreF05IPz9nhtOzl/xVxz2TzvX8WGSTMKuZs3SEJgvnv97kvNf/JOPRiN6z0GwTQaAdaYzJy4U0wTIujKNdz0GdRMCFn/GKLv8L1wozw1I/MpwO6gUsQhOzT5mYkU6xRfVCMnzA2tLT+WFcr2EFe8c8JvDmgC7ZtKzHAXmcqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts/w8AhN1+z0KUmhSHPsWe7gANtjE18DYXmyv7iOTto=;
 b=m1DU+09lIglmPhpfSDrSpTI+oC3Ew0j5rfbksVJ0gCzatfNQGP6EPnv6IfQBhA2mo1Y7nuuagk2bby+0W9hXmC8ElJ6S0Oj4SbYeXamptUbmHkVTou0rMvzRWnRdRzEZGF94/A/Y/aE0aq0TDxG1bnx346M/mNQ4spzvRfJW3W0Gss+XZidBVEUefqo+8VJiDi88nl/+2pFIrLeCtarhCT8IpCzLMqfgdZL8m1Gl94204fD7JhRSZMksK2EyHkAySE+8VpPIDeNVKIyrDTk8Ag3sc/KwDlhKvaHsdZeWmuq+bz+N9xGyOdtrf+jMjl4d/sKL5hY9DbJQ9jnlsDqepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts/w8AhN1+z0KUmhSHPsWe7gANtjE18DYXmyv7iOTto=;
 b=PIuz2H0qWZqFPius5qVMeFygnVAlyna2LWhuuSapc8NUhrhA1QBEfti3IEqn89lLk94zZqclKYF1yxF+a/049Y+1p1pLffuwCK1UUGovi2qeo/TFIrJ6YccKsCnulyv4SszyT5MYmi4+nNG84Wfdh8IQxsajfgfxtZSlZCHsJjSoGq5o+AJjNV6twPQcBodR/MNSB+MLa/vfALA32CqRdrF7cCsRl5UJK5pmsVd9nvUHMKjnt9jZQAAbWJZWV9W0dcSMeAg/Wsh7mHrR/a55+32J2VWnUjdJN6e0hQxxfDe9Ry23OrkfnJ3b5+FXChuqw8bKc1tWtAXbNulnf0l8aw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA0PR02MB7308.namprd02.prod.outlook.com (2603:10b6:806:d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 19:31:06 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:31:06 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 18/19] docs: add vfio-user documentation
Date: Wed, 25 Jun 2025 20:30:10 +0100
Message-ID: <20250625193012.2316242-19-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA0PR02MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 84df9379-0182-4074-d6fc-08ddb41ed46b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fc4jNK8Sn5BZ2N4WUicb8bVgfeJAQKsOXfnOQhk1mh2XiF/5ZJvNV0R8pQsh?=
 =?us-ascii?Q?2ACjqGh43vxFhzhPioqsVY7uRLzQnxv5CEDiFjnzfcDy24oTQ2n7kAcgUD3+?=
 =?us-ascii?Q?cdeYgEH4FT+tk+Zh010rFDslPmUFEwM44iwoiNGM9Eoz0adrvI2rLwMxltzq?=
 =?us-ascii?Q?nS+SFcpTaqdc/PH9zEYYo/9OpdrNp6T1ccptBB7e8jJEK7Ti2hw7Gdj6WY+w?=
 =?us-ascii?Q?LnZhvwf0AtA+XUPBmTj5KhXW/O0/DUlSnjZg6kQs5pj/48Xd0gwgcnwBHltP?=
 =?us-ascii?Q?eKxyLcScgtcaYlDOYvJ/LZWRgZkXVEoOZ7kqj/3mtwRLLAMAkEa90WNqJKXl?=
 =?us-ascii?Q?M/qtRru0UKCYo8f4nrmJJNYynDpG9QbzNKchGbc3nKFK5TLtfVh6UkmTu8V4?=
 =?us-ascii?Q?fjFGvbmi8G/FbdJjiSV0dUjoGPlAp64F50pLVrF5bvMM6vBg/MNWiao1jcdw?=
 =?us-ascii?Q?78l96qNznNw+HKA35i4XYSGjXr9493QZwwxx4ejp9gKFJeGDZrKBsNASP3f3?=
 =?us-ascii?Q?ILfMMG9nwRVYhRUbWMEApD/Fu34OdR2bwHmbiU22CU1m+bJL3x/qqW6DCwOk?=
 =?us-ascii?Q?d3E1/M26/hs6vh4TRlHaavruHtxYdXYBk+4k+zwIKDBJAv6JdZ3d8X/M0FQq?=
 =?us-ascii?Q?MBZ7QQZzJzLKsWUDRTquMgtxPoO3/+Nf+KLX44Zhbv7taQcX5aMmYylFoke2?=
 =?us-ascii?Q?OOlDFFd2iAO8JPp1ZriadFr9JQrB9UTiHPJXTH+xYbdX0mBF/DrA5ESCYW8+?=
 =?us-ascii?Q?ntjhRWaBiH2b17jrAbkPMqOskAySxB3KpTJjTWgylwllkl0bQPEDMk6fcZt1?=
 =?us-ascii?Q?pc3jwOSzDRrq1pyFblP3UaFmsEFB4KLqf+e8aenqpeUwCwtb9D4dOVUij0JZ?=
 =?us-ascii?Q?njJQ4TyvIxduOX4y4jsgGJdTk6Z7JG25TgHrtD9rkPzEiM0luswOa2UxehKC?=
 =?us-ascii?Q?eb95l0O4E3ScChLozL23UK9d19IyhBTSgU+/8OsZ30FrUtN2n6bHJ0hKtbwa?=
 =?us-ascii?Q?PskH2JsBTjfdCjRWyK4DAYhyfpSgLJg4YB70H0xgZngOdv9APM1Hl0QSzOUJ?=
 =?us-ascii?Q?3bSB1CTSpkCnY990kApojMskE61uspWCNP0RiZmUlW5iLUpC7FyJj4alOgid?=
 =?us-ascii?Q?0OMmN/6IuxzHLu8Y2n0NE4A19JGvhX02Fo9uwpRkFwXiqOvul/Kikf2zUxcv?=
 =?us-ascii?Q?XqCYLEvOJ0a7KnJqU+CbF3ITE6szghDYwtta9SiEs+S1K8C+JIKgQC68ncK8?=
 =?us-ascii?Q?7uRLxp3F7obgMUKdfAW4wtQpKWnVN00Ecbk1XxSghMYWoS795tLU9tHqc286?=
 =?us-ascii?Q?YmQK0qaqU5sadOMyWNTXIw6HHvv6LPF+RdsA4KlAGOBHvjj1bSPYvpWi3NCG?=
 =?us-ascii?Q?B9cwHx+Bdvffb+qOK6D/bCIIUSFPikwGnFQuL9hwZxVeA08kgZuLA3MfypQr?=
 =?us-ascii?Q?fK3XZ3YRH/8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uoIJR2mye5zPftQGUugRLutdfG/lIEAsnMXTL/2enmxkqEAF8mGRaJ/QikfU?=
 =?us-ascii?Q?sqayeRRVcyjieKifdfjvArqmbqaHkSJ9P5DjKb957tDQ97au3YqR97zJBX4m?=
 =?us-ascii?Q?IICNi5rHfTNAgqV+HSO5t0jsXPyMNl4vFRyo6cL4g/91xX+hDpmr0VurF+Q/?=
 =?us-ascii?Q?PnkWnpZmkwJqufRpd+6q3ji8Ti5TQrrf8x2/qv7L/umH8E1WSK6tWSHaCdyH?=
 =?us-ascii?Q?yqsIzIaipNQx5gfA/b2T2i6agQnGqRRtBc5rL3YBs0hWty2VkJuH+Vz3YRyT?=
 =?us-ascii?Q?kjkk/ooyWgO1IlFroXCse01RDQdZRGuR+2mj1eR2sMdbY+6wEx3aPbhGvUa5?=
 =?us-ascii?Q?PXIlCOyraIcFj7HD0UBhVNHjYuZWHZZsh0NeDccAvgx1GskUru0ZbNsbKFfD?=
 =?us-ascii?Q?rusj170JTXwSxXwSX/JMTgapPRF6PDMnnKh3Qf4BS39CKukHPayhSCPn6CsY?=
 =?us-ascii?Q?36GCDlzKjzMA6Nh4TjblgqywIY4cHn6I/ECodzIDaxN7R0EOB9CB3dsn9TIy?=
 =?us-ascii?Q?FI7MCe4cGqX3MM1nlQ6m9hhOml60LkT7OS56T/r8IdRwnKMSHww7PLw5Nzct?=
 =?us-ascii?Q?UZc/2a2ogw8sJ6D19aJeiO8flGFin1ZHeb+6yz0hmvujpTthj6VAhp35TFc1?=
 =?us-ascii?Q?QuQdvN9h/D9h6Buq39+WTw+zkJjz9iDJJiiWk46QsO+WDvuJtHbRmHFZGXui?=
 =?us-ascii?Q?tjO4lbkDP2QOk8BxUOtLY0EQjFYfporZ7kWDwf0tKR4NbQjr7VsyEiABiASy?=
 =?us-ascii?Q?gm8P8k/EOvcAaDYEc+46lqds7duVcJTaVYIHh2/ZNv1dfm2hqV+AXJgBh5Wl?=
 =?us-ascii?Q?pFToIY6NBNEmx4WQIA+o3RoDw1ucSnR1HC7l5eTjsF2BZfbzaf2GFn7WdXtd?=
 =?us-ascii?Q?0WruO9TmWYgRwe20yjMeYCVN2If4p/ghKCmtXuY/d/jjVeQq6PsCbDr2+Vj5?=
 =?us-ascii?Q?WAYtPciUALA8XC0wJ+ImM+qyCK3gkzDlddat2h1gJe70fjOQGk43wUq0eC2B?=
 =?us-ascii?Q?i1zBG9GsinUfIGmZKb5Ff05PXhQGh9sXwCF1lMSSb9RUiGDC5oMkArinY6ZQ?=
 =?us-ascii?Q?MO0pXu6hd8RQwtySR4eEFWQncgxNp/ZB0X37Vl2S0iv0TPSpOYJiBW306BRG?=
 =?us-ascii?Q?K1LvYTNCehP6hj/va59IV9e1cumnvNj9D+9USDPm19Px6bA5r/YFKZb5Nb0s?=
 =?us-ascii?Q?+nyBMMsXZvvrOpgom/xtmXWyA+Te9erQ/ntE9voEuBJSDxbf4jU5tYWTQC4F?=
 =?us-ascii?Q?tM710dENwAxYAQPQlrCppRgx0nLRlu4XJx7zqKYu4wdfU27Se7bNyqzGc7nH?=
 =?us-ascii?Q?qZjoGw/YDmwcIuOc9Ax4lQl2dfKRBTC/TTlu+ipLXTDHuL3t9SbaNCg1YUid?=
 =?us-ascii?Q?47G2OZ9L2KN20c+ddbXql96/HP9Mft2lb5b60MMyIIePUzXp10a5e4V5LGwK?=
 =?us-ascii?Q?byx8H06k7glZnGtY5xkWD9OJvblKc9Up8H5c9gfu7Fs0LSPVfsaas1lp+C5R?=
 =?us-ascii?Q?4y1eEZge3u59se18Dv0UmLyUknRR0fdsOfwQsEyVkTrf54MMs+/8kdpg1Izu?=
 =?us-ascii?Q?9e5wHvHUk3FOpTiXCbyRDUTaquFnEU/CG1+nI5dJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84df9379-0182-4074-d6fc-08ddb41ed46b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:31:06.5505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ccn+yJwDdG5hyOmFwzZR40TylJRqmlmicf0kCGPTzE42UC7J2Ff1pEfZBPkKS0Vp83jKtLTcPXiRV5CtkJQCjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7308
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX2Wr9XsncJm3P
 1kU16ZdxH511GHVTE2kJqVQ6RyGDcndjpVYViC5UqQQQhOgOvrF7BZYWDBWnOEeaybtOLDlCoxH
 TZu77s5itIthd96f70esJWnMUamTm3RzEYoc7NmD1E37aPxrOuUb/AfrwRzxWSRobU2FSOXtAZt
 rOS0LSH6RhrH2WAyla7Wjyl4I3d0CFNAcvR/xsXwQ0wkDJvNn0ClYD3LvkzjGJLQBAjLfS6FV/P
 aWqEu7OUDghClO9khs+SJkUEV2GE/LqD9Cm64s59qYrCGW3qp0+3qJS5AoEdNVvKMaExUZ9OEEl
 X7wlMwLoUuy0v3qDoL2dbknaNtW9vJxlkRT6w0l9ZRzSYCXKIjvv5ie/KRmIPdiV+wbXftZiqT/
 MnFF4NLGtOHpO26ExRBtvKYz4j3Sf0ViaCck33RoVeYDfNmdc5qfozdA3v04f2+jIWIIZVOD
X-Proofpoint-GUID: zZF_yTVd8t81n0Dc9a0jWtt7EUR-8PpE
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=685c4e7d cx=c_pps
 a=DIZmGg09oD0WH6Bj2PzylQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=LOSiUy74ef7l4vre4JwA:9
X-Proofpoint-ORIG-GUID: zZF_yTVd8t81n0Dc9a0jWtt7EUR-8PpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add some basic documentation on vfio-user usage.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 docs/system/device-emulation.rst  |  1 +
 docs/system/devices/vfio-user.rst | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
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
index 0000000000..b6dcaa5615
--- /dev/null
+++ b/docs/system/devices/vfio-user.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
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
+-device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
+
+See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
+information.
-- 
2.43.0


