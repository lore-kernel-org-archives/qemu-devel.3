Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280E1C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VnB-0006DF-5P; Wed, 09 Apr 2025 09:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vn9-0006CH-CJ; Wed, 09 Apr 2025 09:48:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vn3-0005bH-Kl; Wed, 09 Apr 2025 09:48:35 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5396u4sE006456;
 Wed, 9 Apr 2025 06:48:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kBd+2MuP3jIbBsdmAwFmAprwdtHHPPi462Dwmamg+
 10=; b=YEJ4La+oNXy6fuC4iH31NP6J4ZGuLTgAOPaLNrI6nuEelaUgEbQF37Hod
 OPGLHMUkQYU+80RN1aUsAWE+DFRd0dTZiPo0YfOMngp851ndZ7EZJ5L+MziEGe0P
 yVnWf1KOcMH0IzNxNqxkElonS2+j9ClT62v/sQlie4nAbOrwvbbBot858dbmqeYy
 F7Jeef57cFihCSHpocTA5xvguMp9vJDNgjBMOZt7BUuQW4kEwyRu9CkNtXbVy9ue
 noybmG3ZhUSQKVNbRAUhF0L4Zk5x0aGuRYzzvZK6k/kpkGCEdKQM1jj3fQT8EqMq
 L780QlYjd9sLsToGPscBmCaRjQ/lQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012032.outbound.protection.outlook.com [40.93.1.32])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45u3kksbh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4HKlHR4+io62ADRO/N3VbB83svPaLjfRPpLiqn0EHGmb0fekbjZM9um6/go8KYSAU+WOz8qFJyKA4UatmJ1C3qsAIOpd1x9hjuv3k/WxOrkY7vacmNsP8rzMX27kyd9JxCn+GSyu3qGuD53DBjdi1PReSa63/2dRFoiHYquScY7v62wxYsThQ4pXrEJ8TiQUx5ON1TWqY9sdomlkOi0i0LJ1jcKfFGPLJLUlyPHn0stx6SRW/8EGQA2vyp4d/2GMEpbLHQ6sZA+sjGG67SCSviCvaOIHCzGk6y13X93DDTlx7SbhFRNBZaiePIBAB/7ppQEVxfbyAo3JyVn9BEj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBd+2MuP3jIbBsdmAwFmAprwdtHHPPi462Dwmamg+10=;
 b=YmWNtt+ylZcmOTrmUjYlIqzM0wWVKsYUrr6Zgt17at4cUAY7nYmaRua5B+xCEx+daX5W8K9gwwALaMycgL696Sj3vee4tVrlt3jcIoA6R5Mq1KBM08QpT7m3CoGarFUvl+Hg3lqCG8Vmr4Ygjec4I4KYj15plCWGKwZ0VExN4HgUreqk4WiwJHyqfVrN8hoy4fiS2ngvqfYvb8siWUCZg7MOzDN4hxiHZRHRcW4YX1VG54t/Ky3HLeT7Keuv8e3sRmqr8bJNAcfcwIhIq5AZLZwi16EVtCnF24jwtUYG8OwuVpLYkHlY7crgNpw+cs5301VILVPAAs0Twct0DC2eLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBd+2MuP3jIbBsdmAwFmAprwdtHHPPi462Dwmamg+10=;
 b=BYLEbnXojMFXbrXe8G5IjjWWkGxF6GjdSrkekf4QidVrnN/VRB9NFqEEu4GS6LOxCC2tcoS8qYSgY0RjDOKU0uivw/j0mTihiZcx5dEERq5U1VRYHUTSDcDIBqxXmPk0JRho7XmPwaACxuSFxo2Apbmz/mE/kaw8hH/9y3BlyPAgFH6nj9kWOGn4oTVbFVithvusp0VG4iKYP9q7dTRZLR3rTM+kXsZbfbBghKyHTqVsgW1lORpQT7n27XkN5hKD4ly+rST2iojGQ6msfCY259bAxaI09Js8W4WgtDuy59A41MkOm1OK1jJTODeI8tcYTxbr+vrzi6xopqd+vo+/vA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10356.namprd02.prod.outlook.com (2603:10b6:303:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 13:48:21 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:21 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 01/14] vfio: refactor out vfio_interrupt_setup()
Date: Wed,  9 Apr 2025 15:48:01 +0200
Message-Id: <20250409134814.478903-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409134814.478903-1-john.levon@nutanix.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MWHPR02MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6ef6af-98be-431d-a60d-08dd776d312a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i91NLlX0KqRCW986oFsgrBZsnm8FcIj6h3SG4GAhYyRSSfzHXqGO9cwZqYfk?=
 =?us-ascii?Q?LrKAXgv6aInQwcK0LdAfLSyz8zTN6E3yuKlhNXKS4yKe6ze/npFtXglf/okG?=
 =?us-ascii?Q?EG4KWDkLCEmo1IGlVB+jidauHSHr4H0+fOO0xfVWhRI6GHK+P9YxStf3TcuR?=
 =?us-ascii?Q?8IJ3/R5c833DWvpFJX8sGHBJ8sLy47X8PfYZUt+7cWhPp8jQ9a4DvrSg/oXS?=
 =?us-ascii?Q?Rxj+EON/ErgdNWKbTQfyLEP+ZghaNFSo5+1QaBMWhBolY0bRVChezXPdeCy0?=
 =?us-ascii?Q?AuE0CLkHGa7B1A/JEhIHq6Medc6jvmQ9pJ755iNia80R+oDoMpAj2t6RRiSz?=
 =?us-ascii?Q?7Qg4UhJCk0qWy6OGFGQEvhOJdni+gZuDPJdMpB/fZJmwSQuknEkMgRodz0AI?=
 =?us-ascii?Q?D7NnNyykVy8IkT0IGItwLyZYJNEZEvaiqcPQgnpXCshN4+PGUtPW34kk/1kH?=
 =?us-ascii?Q?7EV5V6+x6zAxAiVWR40q03a2zUiwBxpVC21lMFvmwebdLxkFISmfN7FJViwl?=
 =?us-ascii?Q?ek6nkTF9gjkCLf9xlf2Lu48j3WzeyCYJmBi20y7NBfNvRxudBqzfc19D55JQ?=
 =?us-ascii?Q?iM8WHXHUmlb1pX5zEaylXI0C1qnXAR34TPgU/M59cFXK1kMBb1aeh4YuYJK1?=
 =?us-ascii?Q?PI0eHY1V90q3v/H78h7XfGas2oOrSViwz8J/MCXr827zbyyBPGcJm96LBqCc?=
 =?us-ascii?Q?y5EIAX7FTzr18UGxilYT8kwGKmDsusx0OMiilA70wkUHA/PRG3QLUKlWOgkt?=
 =?us-ascii?Q?QXisCOfdZwN4jNKwdgTOY7buG/CaKD9fuRbwaG3GmzNyygRbI977QLi6JxJ5?=
 =?us-ascii?Q?baewwa3D7BAloA0TKFc8Qlyy9lt/NR85Pw+yX0y/lBbP3aO+ucTkd8ie2mZC?=
 =?us-ascii?Q?C1piJJ+0yXRym+inJElHK4LCEoQ15qJbp3WteF3tiPgrhTh54JpZA3Q6SP8L?=
 =?us-ascii?Q?3PkqIr0viBAthmKrvGNgnuHUGzxM/jQNQ8AWSZYhKo2/Z3RDESORGmpOjIch?=
 =?us-ascii?Q?CruLpzQqS6xtC8pX2m5o9Ex8g9Q0r9phL44axKfdYCSOcJQ2OwbVueJK/wl/?=
 =?us-ascii?Q?3L20KeU1Mm016HVJNvx/rgKElg3PN9DhbTSywcLDySa+p2vfhk/zBRdUgbyP?=
 =?us-ascii?Q?HCVYvE3x4bZQ1YFOjKEbXgnb4bV6SEKCMp14+6D19w1cCm0JcZvuLTELeuMe?=
 =?us-ascii?Q?++i1+T78npxvwqclCsbzkiF+bnmIA4ieKwlgTnL0VYGEMOBlIZI4rb5jObob?=
 =?us-ascii?Q?454y7TIBAu8fXeLcaMTlmefK2zTdjPtr+KTNLkBJuI2sk1mJcOVdkTrUn2WC?=
 =?us-ascii?Q?M+iqveLrm1GB85lHk09KObCWadouotsWOR0uXzfZ6u9p4FKoBFdikIOuTqE9?=
 =?us-ascii?Q?2B3A1+XPiUrNnckM48AjvTZzQKxq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dcZsY2PGk0qftJiSR40bwut5JEj08OVK/qpD7K9lTUKlx6fOykPZcYYDhn2n?=
 =?us-ascii?Q?QY35XeLgperVDd8idF+8n5TU9tL+f3pTa0ZylL+lQPBYQ5YwT3LfpGQ+Id3W?=
 =?us-ascii?Q?yvVyPIbV1jfaJ+Qci2NXKFbFmWiGmI/Ft11aZeP3YaWJi5QLqsZE/26ylUW2?=
 =?us-ascii?Q?p3AU1df4bAXZ4gTsznxBZw3edSeQhRdDxCK8565aRpiOiCxIMDbz4uk1Fw3g?=
 =?us-ascii?Q?J0TAir+XuqH/u8F60DHk/Ft0WRUJ0N3Z5jA1wWsKKLuKOTCQsD4ULYh+o1hk?=
 =?us-ascii?Q?QFE5mwYUYFJ2bdhTB5qffNd4gaH1twYntkhRHXjjYEJsl99YCZlvah2zX0Ni?=
 =?us-ascii?Q?j9bxXFcvW4jfOFGHrY7fMOHWf9wv4chjY9ShJ/xUBBu8tmAD4vQUYRU9+Xr/?=
 =?us-ascii?Q?0q7L4QDGSg6OFx9RTzaVQljE1Rre4VGfy6onXkENiTVHeKZR0wguF7e8OgJW?=
 =?us-ascii?Q?nklKLXsh0f+f2PfL7fLvDJHh96MAOG0elJpVKxXV+n0qhpc6NOECZIBDiQPO?=
 =?us-ascii?Q?u2O1JEz3ez/V9LBgmKHJ4sqJt9vbIxqdfhLWGz5YuaVbkqAmE3Wi6/bCIb8o?=
 =?us-ascii?Q?OWwTagQvhJVsrqCG4FaXsngKjhjgeqH48SMZ8oWeWIXQvbffJC4d1vPspMW1?=
 =?us-ascii?Q?ri+kMC3ZUK8LwEsD/bTrrIr90eMN1MyCmpcuuM779C25d/12kILpOooRtw9J?=
 =?us-ascii?Q?JL1BBevmSQC3gaXTTtv/Km972d7eaHp2RDoVhrspttO4XXCABVQvbun1f3Su?=
 =?us-ascii?Q?oSoEDroggehf3rKry9BBWxG271Z7uo+9nf/18DZcMJCfevHYAOOPWik/NMsv?=
 =?us-ascii?Q?lQv4KBHvkoc7yABU3YwhcUdwbJcEn21kGJOTLXX7N3m/NtD4Rrop2qo/wGdz?=
 =?us-ascii?Q?q1tu61G8kanrDmW44Ko/rtHylnVXjUxseE5pkyckphMQVjupaoHAy+2eSOmy?=
 =?us-ascii?Q?Onq0JKt/d70gGCd7Gz9nvsgr6hS5FaC2Emd84M9Mw9QXDhTchq56KJdMAh4c?=
 =?us-ascii?Q?ypp6fqKJzBUPBmQzpL5br6bXgtYZENRqeZKoCKdkvaAuopePrg9SRxb3xzNB?=
 =?us-ascii?Q?Hj+AFvv8E2egZ9dvp0Yst7tbI9TGVb7tP5UgExesm9sqTYHOOiIE8dg1Tfeb?=
 =?us-ascii?Q?u7deJz8/irSCuEdPqLbLi3+9zL4bSuzvqScrxfV84Vpqkx6UP9xdfHlWdZ4z?=
 =?us-ascii?Q?bbAOq/qjb6VEH38QebUAWzFP+7Tu+UTBv+4yN5xxOdg8NMRHGHwy24bU1Lfg?=
 =?us-ascii?Q?AHIQWCiqaMGlBdfd46RWN+qhkaLUpL6/nEp7VVgBMpOkTVAIgXRZIoO3Nnx8?=
 =?us-ascii?Q?Y2GmTzHyVn587AP0ssgCaEnBi0BtoNrXdxICLjsmdGBJI8jR355QNrCjioBS?=
 =?us-ascii?Q?EdQFi8p4EVqU4Wvmc2z4CBNeczsbacczuU6NwepuUci3ancQw5DF4So6QlCf?=
 =?us-ascii?Q?FsHwLe4va3lfbgikUQ7G6CTeCadYNiiRVX5KdyzA4E/s0tsuTonP6ZoPVcZK?=
 =?us-ascii?Q?imU0N6vtQdTax9i6CNTVs7UmuEYH8sWMslBfEPJGmdtOwVtDVwLDTYpTIcPI?=
 =?us-ascii?Q?MlbxIyWzG7oSj9HauFQdYqZbTMfq2E02JlkrWJUO?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6ef6af-98be-431d-a60d-08dd776d312a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:21.8064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03PEp0odY3UBe/q2wiRN9zynQxiQrRyIeYUW3ZVyOj2uE4E+n3mkCs/1nVlvRhJPzYp3dJloJqO+vooSLaXgVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10356
X-Proofpoint-ORIG-GUID: foCNld5d48-0156yJFYUWA0XVL7g46t1
X-Authority-Analysis: v=2.4 cv=d+b1yQjE c=1 sm=1 tr=0 ts=67f67aa7 cx=c_pps
 a=fM4bIjZpJamw6RFag0UgWw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=dhT5AhTmqo_bmTCJ8pQA:9
X-Proofpoint-GUID: foCNld5d48-0156yJFYUWA0XVL7g46t1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor the interrupt setup code out of vfio_realize() for readability.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 55 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 05a7a62204..02f23efaba 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2963,6 +2963,38 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    PCIDevice *pdev = &vdev->pdev;
+
+    /* QEMU emulates all of MSI & MSIX */
+    if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
+        memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
+               MSIX_CAP_LENGTH);
+    }
+
+    if (pdev->cap_present & QEMU_PCI_CAP_MSI) {
+        memset(vdev->emulated_config_bits + pdev->msi_cap, 0xff,
+               vdev->msi_cap_size);
+    }
+
+    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
+        vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                             vfio_intx_mmap_enable, vdev);
+        pci_device_set_intx_routing_notifier(&vdev->pdev,
+                                             vfio_intx_routing_notifier);
+        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
+        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
+        if (!vfio_intx_enable(vdev, errp)) {
+            timer_free(vdev->intx.mmap_timer);
+            pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+            kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+            return false;
+        }
+    }
+    return true;
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
@@ -3142,27 +3174,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         vfio_bar_quirk_setup(vdev, i);
     }
 
-    /* QEMU emulates all of MSI & MSIX */
-    if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
-        memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
-               MSIX_CAP_LENGTH);
-    }
-
-    if (pdev->cap_present & QEMU_PCI_CAP_MSI) {
-        memset(vdev->emulated_config_bits + pdev->msi_cap, 0xff,
-               vdev->msi_cap_size);
-    }
-
-    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
-        vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                                  vfio_intx_mmap_enable, vdev);
-        pci_device_set_intx_routing_notifier(&vdev->pdev,
-                                             vfio_intx_routing_notifier);
-        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
-        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
-        if (!vfio_intx_enable(vdev, errp)) {
-            goto out_deregister;
-        }
+    if (!vfio_interrupt_setup(vdev, errp)) {
+        goto out_unset_idev;
     }
 
     if (vdev->display != ON_OFF_AUTO_OFF) {
-- 
2.34.1


