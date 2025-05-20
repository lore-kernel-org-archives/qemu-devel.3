Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428A6C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWv-0003Po-N7; Tue, 20 May 2025 11:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWt-0003PH-Vt
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWs-0002ic-9E
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:19 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7HZOD032326;
 Tue, 20 May 2025 08:05:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=D2KfDXoz36GvTozb9uD8eLJAsTvhv+Uhiu8xE+c6D
 QY=; b=go2ZSbJXB66Ysaesh7WnmbLLxGn+WZ3EOk9GhRRlgoT45qKuxxBeRexK/
 d+QbkDsehxy52gUZjnR2cMmzbFt8uUrEwGV3T0m7NlxvbLbR8P0hgifD2b8d0jXm
 dZUzDSZzFJCrKfiq3PrBRv1V0Ay9u2514J1ImZWAeEHXK+MpPWGJQkjuUWgoF6GN
 Y5x4jLyDLLtTImhZRBYDCTTH9ghQ9QsYrOw/ac2z6Fkjbml+5DRuGL1x3iKF4zIF
 T7Hj+gQs0sxzBfj4Fb1TPUFKPbuCW67XSu1m0QEZhAotCZvOo2lQZS1iYjsSP/TX
 qyktYOKpp4qk0dbv0qgBqrzyWJ9YQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjheae9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5mXx13EjeagT7NiLpT1SyOKviLZX2FMGhv5jtHd+9daRqoimU0edz8F5xZzZyszLL8lH6kgGlCLgqh/Sr9BoJHgSaLQbXZ6zodil7NYs9Rki/xHEa0rzw+aj3BnUz3xCpuw8lurl30vg4hIfZAGqTSyFTIq1Cau8rZvPKwsFQ/mcHIyQ+88CqBpUIOWtKsgSKJNKdW0pGcjIGAjZTFp4QziEZ4IJujLeD9tsjF96B/cUYhX2DKlpZRNv2D36A0cEeZ/ddlf69mGKyt6T4SHWh4tghBvFOwnUeiE/UEdHiZqyzvUF4qFiP3jXY4Ag3ZK/QcatTulboL7i4FGLRiT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2KfDXoz36GvTozb9uD8eLJAsTvhv+Uhiu8xE+c6DQY=;
 b=SdMLRxIWabSajgffl5KWCfT5lkY+UHi2vqP70xH2z+WroXPo7BXyyX+B9DtYcZ1gITGm7ucmCHh8yYe7qpnQlB5h69Icdpleab1oQTAIHgitGGqogEez7IzkjRK6Zw9DQval10YNx0B6nxBcWQGpdo7el3BR8wKHPqc2fR75Zw3+KbJdb4QYiWc+TIJW2ZVzgEfohwJ14kJ7ZIUfuEIH8KVMsVRZYEm8gfEB5dqjmVS8uSg8DxyMvBU7gj4BgQuPcxWjuu6P2d9iszZbS6fTQlAtSzmRyB5LPBrbBqnd1IYm2wsUjkLF03435fnGQ6ms/2sOXV+GOx9yeyMf3/HvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2KfDXoz36GvTozb9uD8eLJAsTvhv+Uhiu8xE+c6DQY=;
 b=XOYJSI6C0y4Zll19m0KWIV2lKZwPTReumfShEe7jVzAYEdq39GRV9xp5znhSsRZACAznZPBHZFCwukWrXW7xxaB8z6ypFT3NIeaoDKVZf368lWvgdD6mS42YxmHSlzY1aGqd0ekxvZ3C7ZMOAbCm94y7uZXgzyn7ywQbXMszz25SVfjYKPMo485K/blphiotijSyIAnnduTTKqXBTqZ9pguJWrRZ4whxMmbAS1dGZPiUzSVFrtlynmmJonogbp1flcZksKullEmqI2WIMCtU8BKMnkshv/Sp2gmVl//kioGCOKPMzg/jE0IL2WP1rNxqGVrrMZ7Jdxtl5qIL9ssSPA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:14 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:12 +0000
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 19/29] vfio-user: set up PCI in vfio_user_pci_realize()
Date: Tue, 20 May 2025 16:04:08 +0100
Message-ID: <20250520150419.2172078-20-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e2dd07-821f-45f5-f948-08dd97afb86b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J1abW10EYGjGw6f+hEGn8X/BGe3ho5yNAvI+USV6x2CIw/UqAOxuD8an8l77?=
 =?us-ascii?Q?A63um+IxPsExUdK6W9E0cvYJHLgXvA5aKFDhEWGiSxTA0tLBLS2VHYE7+sf+?=
 =?us-ascii?Q?U4BZUiUPMvhHFL0wlJwW73YhtI8b58PuxA/l4kCa8TPQowNPRrza8DqyT+ip?=
 =?us-ascii?Q?D46AnA7PbpQrJVIDCnL2xr6FRr4S55ejX7IrloZfO57hkaIhik+lFWsRXhE+?=
 =?us-ascii?Q?/faXp8KfrlzZz8WWW5y2jSsvaSZvXwFgejeMVJzjqsseiABBTlDom8ENKQz/?=
 =?us-ascii?Q?lyL4Qgk4woO3dtjZyUW3awYojYu/uX4023fIFZHLfsQnQqEiekR368HfgAMD?=
 =?us-ascii?Q?GAo5bgoza+a9TV4tOdkiWLxAP2etMYlvBqQSUnJfMBvI1Fq/6AiPSuNhmjKo?=
 =?us-ascii?Q?wXKuLwMd4OncuTMPK3JYD36oKqWuqaXofMA9/I1ApRscPspYMM8tNpqPXe04?=
 =?us-ascii?Q?2O8jI1pYQ5nOx3gKNqDvmiyac7tseDFoX4QjWbf5+F3cEMtexQTjUZBBCHM6?=
 =?us-ascii?Q?gXJeWMp8DnX4Wiah9DpxM7rlryPLPFpUEezNKKOvXt7Tyjffi5stabYIUC92?=
 =?us-ascii?Q?QXHps8da35BWE8OUJrpQT14jrl+5kT8OKK8v4eUaMItn10WnP7mA75atgKxb?=
 =?us-ascii?Q?41lJbfe+hUN2RLlOFi2Hy/oC78TZrOYU0MPhkWgU1eIk868nGnASV5H0oJMv?=
 =?us-ascii?Q?xGX+sGleefbRzyFWrG0R7eQF9A+B5/w3ILvs9AApmlw2WBO4FXSJLYOphO42?=
 =?us-ascii?Q?SeyPWWrzwQHoxuWWzgtxUPjqjsyHJISVkD37lkG9wjwTav5FOHtTMy8u2IzK?=
 =?us-ascii?Q?+/VjziU7Dxq2OosGET/qKSKKmHKbc4RKaNK7xL2kD4L016PdttTKnjgcW0GW?=
 =?us-ascii?Q?mQZqxNszLyzHE3/wZZUHMXL1Z6DaC2D85DPKdVQS4s3AbRssHvmXIwke+v7K?=
 =?us-ascii?Q?JHXRndLPxvKhEK7t1Ws3GU541kmtPSaEotv2UKDvXiFo2cB1UlGoYl61UYrh?=
 =?us-ascii?Q?SrMnyp0vA51iNlu5NFYfiUd6FJeeubcvNFQQXgw1POTLdDXWRG12z0ULEEVD?=
 =?us-ascii?Q?UsCrodMI8zpJW6B7Ay+g21JZ9IxJrRpNykG7bU//nD0b8FQ5Kjgs2XVvLXay?=
 =?us-ascii?Q?Xu8DHlXa/ktjAHaHfgk0qabZ0NSXM6HvcAhSMALWHheqaGK85yFTLTopD9/v?=
 =?us-ascii?Q?pc2pyX4tfAlpHEVp2fq1nlmo90uecpq50IrgWwj2Em2gKqEBOQqEId9jg2R3?=
 =?us-ascii?Q?hmIZSUHr0BVA7FI7tE/Yp+d7yiwrUVQFWuSVleqt7MY7R+PQRvsPHEO6ioJg?=
 =?us-ascii?Q?/ENP6vJLXiiSiMhzpk7T8N50sb4MaseXTPqhP+4AtKkPJ66Iqyf+utE/ck1d?=
 =?us-ascii?Q?EedviC9D2RuV5ByYWKetTv6h09ZpyGooYo/AuqVFrI7a8N/5ur+/NvYl+zgR?=
 =?us-ascii?Q?JD4+C1smvjU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GQMR4kvyTLgfWSHAmZx0MCXJKf7EGMj0LIhclI31tDAjBTuqnX8GmJ6u/+rF?=
 =?us-ascii?Q?dOMrEf6LNdEFKoh7ACXCm2kolTMhUZirbkvqlmZ7hqK+syeFLyoRlHo7j9eH?=
 =?us-ascii?Q?NWeFXkglm0KzGm/wOsEL5y467kQQrolcRjmwaKnheQ25tg+gTh+aMKsaXOcJ?=
 =?us-ascii?Q?Zx2iF3ul3a6M/+uMyP7Db18kWUcwYrhEOAs9f2HkljtNagcFbyvKljd+Rgk9?=
 =?us-ascii?Q?6eJh/rTd6zKP43ctDSVVas9qTMRIBZDl17ijwfI2tWyIiTvHvP5FG9Q0cFnf?=
 =?us-ascii?Q?5fvT9d5g8bN9JbzxQ0xm9bnyPtgph9UvJ04GlpQiQ7HzqzCjX0ZQoJq59mO+?=
 =?us-ascii?Q?qyqpMKQzWhskuStGY9HdaCtAG14cB4NytWw/nkqzzPIzI1vUaAPqJU+NAV4J?=
 =?us-ascii?Q?xxiyjAxPP8Z4zi19Zw00PWtzStY2KxvV/LNMBhdyoAFKYh0n+jy5SjwKeReT?=
 =?us-ascii?Q?Hiw1mqoulOrF0oD7usdRIG2TCdjlP7imK1Q8v6NPaYRwOdeWrukPoPiGF+Ft?=
 =?us-ascii?Q?8nw+I5YF9gnDkUZqIoXxEUIZyzRt5MXAJEH7Zx/cydsA3BHmeO7SaVRzvT//?=
 =?us-ascii?Q?sscRu2GqT9tMwS5U4K0oqW/cqE1P9/qBtvcGXGuYwzZqHPq/iz9vFQ3MNdkE?=
 =?us-ascii?Q?RmOWRfNKwfXMLXhprYgihlmXtax6gUx8MchozX3+GK/5v7NaQ5vS23FYDTC1?=
 =?us-ascii?Q?ugWjLv6prUXNIi6/HVlVSoEmmPTuOpR8TNqpfADNNT+3IV7JQTaCBCaOF2h4?=
 =?us-ascii?Q?5Mcymf8THwlmxpeHaEa3joCFVFyq7OXJ69LVEQ+tP5blWoifb4T9Yyj8uQ7A?=
 =?us-ascii?Q?puAzeOCAhE0wZ6h1zo84pwUYOnCFAgfpzI8lwb0D1K2jRrvwG1xyMbmLRlcC?=
 =?us-ascii?Q?78s4uc5BtY0lgWp8TWqMhY6XoaZv2eKH5nv7dBeE6NLSRNhsXShMRSGBB8Lm?=
 =?us-ascii?Q?fh55iMexaTccnib84SWouUUEAjCUz3WZXDfqO5xlgFGPPfQY4Fr51fDEyk5U?=
 =?us-ascii?Q?xYtJg0/00vcZ2lrElgsYA7WjsX1nrE3GGDZkRrSftCSca/YQZ/vIC2Xnc4uk?=
 =?us-ascii?Q?mMiH0NkBl+VWp9rVjEwkcyMLy0bYd9HOomQwjGTzu8AZCbwN1/t0/VG7d7fR?=
 =?us-ascii?Q?vR+TCZBF08On8msoMWzUtOATPi3SE1XaydEeiLjmalNRdjR5HlPQR0hLepYn?=
 =?us-ascii?Q?8jg01TrWegoAYuJjxJVgvCMh86mPJs7Qeas0/v9C8jmiTTQAdFNGsCL3S9gn?=
 =?us-ascii?Q?3HuSBYyQloTJ1GFMBCCnu2QZL5x+bWoppdpv3XtnfAA0LQETCFjhzN3uAWaP?=
 =?us-ascii?Q?l6GhscxPORQbScqxxLJvY9WrOC2vFtWzfYgiMmJx4Zdari6o1uM0/rP01Oka?=
 =?us-ascii?Q?ofvfQwDDi/Vn5eAho6JI7yIqK2YCeOyNlixwUXb6YCt/Z81V+vRhOcOlxHFV?=
 =?us-ascii?Q?UrubNcklmjElY4x+sbeKh4Lw0zanFMlUqLUCBSuqlUNYz8tjPY0siNj52Ccb?=
 =?us-ascii?Q?k7oyuRcp+/C425v0yECXxpw3CRqL09i4yx0tnBAfRKkrbU4GamNpZzQ0aILI?=
 =?us-ascii?Q?E9G5j3MvmS9k360EWuIIjDmJ15en3XdBYdfq0jds?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e2dd07-821f-45f5-f948-08dd97afb86b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:12.6894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkncICB7EfNFWRrXmjdzyohdSQxdY+BYkIrnncTqeYvzHEqqP1eSxyaL3VBO21ZCXDtojyj1sq2+ezuT16acQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX/+E70JjwwciH
 hJlvsD+cS4Lss+gsNuF9NQQrJPqcaC9BIo+iQy0rumtMPUbyA5AYt6WIxCu1WB1AVA4VlR5exRi
 8wJ7dl5HzEdHn+GtGAAt3ax9+C4sv5tPG76yiZkdb8na3Bq+qFv2zd3ckw7Qw5hrriELLlp70vk
 /BpBuWSnWm3I7RHTrecbWZHa/ewjChHk4BKeATDX29XmsUDd7Pw6wRGlq1nwY+3k/9C2k3eEsM8
 azG52eMIVrTNgAj+ATlHw/6hHKvFE6CMzoN2VXue0X0dwGCBAkQ2yqwWOpdLgSX1rbW+KH+9rWD
 58GdzPf84gdMCMRd6vebQACmfpPTyrkxhD8GpotEgTGIquVcDJSitMvhOuLjIb9I5wExykXL9F8
 +4o8/i7sJwRtrcXUmLRbmSCRmF9JbDZjb6LXgY250Q8rXI1UC81wSko6EJfZSZ1oBGYZES2s
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682c9a2c cx=c_pps
 a=hHPfuxNGWHHq0fQgDGst2w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=uN1uQ0dK97G9gywtELIA:9
X-Proofpoint-GUID: jC-gMajbju0LevC2RVRTRuVUBLhE7He4
X-Proofpoint-ORIG-GUID: jC-gMajbju0LevC2RVRTRuVUBLhE7He4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Re-use PCI setup functions from hw/vfio/pci.c to realize the vfio-user
PCI device.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/pci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 3dfbc33c52..481c6cdef7 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -115,8 +115,36 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
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
 }
-- 
2.43.0


