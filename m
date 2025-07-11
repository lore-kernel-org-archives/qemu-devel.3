Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D916CC83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAWY-0005MR-SF; Fri, 11 Jul 2025 05:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWW-0005Gv-BA
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWQ-0004k6-33
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:32 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7IlLG032197;
 Fri, 11 Jul 2025 02:58:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SUXCVGbswc88cBpdVvWx0KBKeED+dWZMUqkHPl3ZG
 Tg=; b=kAvxINgNGhXGpZfXS97+LzPic2W1ddN78qGDLUbhtcICB/K0pRyOJ64kR
 JMe0ge/nH72FWp1SXvgG+syQUMdAUIORn1kffhBl6oB400olCWQQY2qRUQ5A+oUx
 /e90f80y58PnmrSmC662TcVtE0y11Dg/tYyBy9PZduufbOaTeXXd1/6nIyES+iBD
 EuavkS6uHSyHgUckU3RHBu9H72WwxdnyXzBJlQfaI1QzEdPpjFulwhH8Jkrdbmm7
 17Kpbmr3Gv8CWqR02n67XBW/WPI6IlLH1tZvrJJIQY7ACSV6GbxnLxeVsgl85uu1
 El4NI/nrAh8dvt34oKtJBjOb5vJkg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022101.outbound.protection.outlook.com
 [40.93.195.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q1karqk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdli0EZyO528ldP60F3PbZApCUUXlbIGaG1j/EbeKhgsc+7h0cbGYS48R/8UgqebEmWVKa3V+WQ5mQIrUZ49445w0wGqtWn7G+ZrO7Dz3/hKwAuEC0szG8fDHRi3Ku8tAVK9HNWpzGOa+4Yx5y1W6FWRTptXgPKNVecl71Hbt10lL5x6qlOrnv6RTGLbWRQtQwQRL/+cJplB+TiCvxZckrG66O2RqRunCqq9tJtWCcr6MgSTLCIq0dO63aaoX9hUnu4x/+akmQlTHFDQnC5j7hOpTAXOlyRVXKer3w0VWxK3vth8wggAhDALd4GKFv6mb0By22//ICY6V5v8cvf2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUXCVGbswc88cBpdVvWx0KBKeED+dWZMUqkHPl3ZGTg=;
 b=Ng2XsA0vCPLQKTmJI1xUm9P+uXq/LTfN7Igw3jlP1i1Rt6IHeb2blgwSTILCftlT/8tyEonQiDDfhh1oFQfmN0ROF5ubvzlSst+D99WTDGswSacVqdYaLMA1FNflKC4+ajtxtroTXA61BPWSCo2Q1vxKxGZ3a7TioyoeW7Tgn+bR73aRYERxGjiKayl1aLHDh5xRxRlIRWa/uJyt3mq0Qh/K3wb6XwQFONWP+GQgroqkfpwwyVf/60l6MX4diuFmtrMG5O+bPZ81vL4YOCBumUPoAbthsA9X+3Y5sL7yOSCwPWLJEVkHp9kdJq2nRoj0HkrV9V/gHTPJFrmQ//eKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUXCVGbswc88cBpdVvWx0KBKeED+dWZMUqkHPl3ZGTg=;
 b=wyIImAcvWxMjn6NgO2wIT9GOI7sZ6weZKDY85Etxvw2OYQ2Ew6arrRvLqgS9Q+v+RBr+A+kXGVZYy+7MVHRL3ed79EtrT3WMUoGJBl3AuhuqzIRzMaALxjCLJEb8J8Bfd49/dTmRei1GGeqpo6oejRApWNhv4pgXZ0rGQ7Gp/1J+b1eCj4Y8DfY5r7aWfxnR0OoYytcEAmo12wWb2fP62j1ca49ACjB9pFmPULVvpHMR1tSLmIixf3stzBi6GqXJYpeX2PM6C81HHELoz+6XGs2j3fncSE4xJMAUKV7xZ2mPc5i5HBAjYjhcMr7UB2S2fkxXlVLg5+4S9g3mxIS+Pg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 09:58:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 02/19] hw/i386/pc_piix.c: remove include for loader.h
Date: Fri, 11 Jul 2025 10:57:04 +0100
Message-ID: <20250711095812.543857-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0643.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH4PR02MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2da201-40b9-42ad-931c-08ddc06178d3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kLrK5bZghsjzq/ofitch+yrLR8rPbFG0GJejiVTiOpeCPQnx72Iecbqcsfwp?=
 =?us-ascii?Q?JFkvRchsGlJ8tCIch26Gw4fVX6dUKTIoaS0JVkHtjJPGGmhS9tnWdGpz1zh6?=
 =?us-ascii?Q?6liwJ1RejxRgtSM8SXT9hqrtJf2SnThqGbdRRuj3w9KNYsRV9ZDZjze4hAao?=
 =?us-ascii?Q?Hj+BypH/x3aDWTEyHxFudzBJzlddK71P0vE6RTPZqNiSyjg+qmvGcsHwuEaM?=
 =?us-ascii?Q?asKcpndeOR1GdLaF7MWFU/L+wxCEk/L1Y/jQ98SUDDPPr8We+iFY1iBcm2DY?=
 =?us-ascii?Q?Z9wCkc1yxdIwl9tiW38ESnmVNOtprQ9mS0pQlnxrmBbd0e8rxPgrBfEWB2zT?=
 =?us-ascii?Q?uFAdbcTOpp1S8J9F1W6xqQPE+ieS4sm2p0TIrmUHt1bkHvjIYtIa8UqB4FpN?=
 =?us-ascii?Q?f7PxvhczyZdZSKLWoUkunQA9c0ENQMN6uIq4Qr82maDoGL3IS94tO5sudh07?=
 =?us-ascii?Q?ThGCpRlokQg5kwMov+oI3k1gQJII7wqJBAl562jcfgsmCsA0AoGMyu/Shd6f?=
 =?us-ascii?Q?Y1YzefzIKrZAO6+CBecFI0sJhybOG7N9uPsM42hywWDSnzy7zSmAAC0a4x/l?=
 =?us-ascii?Q?Umw1KogLtmo38gz3vh6K/kj9v6KQBhLz4WZmvtTsC/TjmTe50m8Xyr1uIUnG?=
 =?us-ascii?Q?y3hdcrmIx6dxDtjwHbe/uWx/eWkWodvPAB03aJv3pwDMEC7CNjwA1LxiuQl6?=
 =?us-ascii?Q?d8oQ72AHoxl0PhONYzmjFmsbnKMdf5aGBd7MfctRal9rcNGlg6ugqbbq5N7j?=
 =?us-ascii?Q?gCuPgh5Jg/5/cSdDfZyREzZakIVcILGy34mF0p9GSunyXB2Qhl8jAKbOfhr0?=
 =?us-ascii?Q?6vhCMT3u+jStbSgVlacmQasv35zzxZmelekkBOEoLGz+liIOJ1mU/m6Y1uBs?=
 =?us-ascii?Q?YZxB1CnrxV+OvelC4wrGRHBqRdAjoe2ghhMKcjOpD0KwBA0MpKzcCNJP39rl?=
 =?us-ascii?Q?cWYyfZqDs6LMUh+EZRDA4wL1G1ZmMmLrWDwXOkgTR6U9gDBc/NckePjk7vvt?=
 =?us-ascii?Q?R0Imt/6XVEUUEUf7BYFWxrObsCzLqJHLmaTfTuXyvPHcsIMDgULZFVf780Jr?=
 =?us-ascii?Q?hTuYbPVYowFwRX4uPLVGZXA8FiyuKyNKGynHjVvPiW/claVGZksFZrjQkdOn?=
 =?us-ascii?Q?w9nBfv1yqFzeyYSzRwm49JT8vGrwwNM5pwmBzb2ZxdtNAIsX/WTPC2g0izs7?=
 =?us-ascii?Q?DhksAkQV24yViRPeQ+VeT3vz5JV3LO5/0RLU/go2I50TzDcbtf1hbj1JlYz1?=
 =?us-ascii?Q?Heck80Vqlzh7ep5A+yRxfQUugbzuInSB68TjiruU+BzndL7/7Lo7BKjexgJR?=
 =?us-ascii?Q?qHCkGAg3MkDsav3wJbMtanDK53mvwQYq3j61vFqD7XHyzH+gebSadZHr2n/Z?=
 =?us-ascii?Q?IBCPL3ghdwUL+En7NxvyW5VhjVeyJMDSYCeYQ0dSq6oQ1LVUqU7T80WADdZf?=
 =?us-ascii?Q?tKNxnG8y3DM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/iEesPtK01lICnlUdnK42tLcfEhUHSbGEA1tDtdvXCxxK/U12SjLTfJWsxF0?=
 =?us-ascii?Q?ykw43o8SnlEUj473q1wRtwhyGy1Sou70JkP+8XB8oI4y///kQ+0uoLByblAM?=
 =?us-ascii?Q?4X+3CtspOq20jefVtbrvBAe5Tb7lxT/eqe0xob64CgXFby7AyYqaGgl3chKg?=
 =?us-ascii?Q?3NIA8yTGeoesxhXfPeDcuKhq6y1NbMfMpDajEeKMuBALioLt3eTbk7sSHo6c?=
 =?us-ascii?Q?mpdJ0hglywJlWQ5jeRjTG7Y/g29C3KubrYeFk5L6cAqdJJhvrtqO+iSOlKYS?=
 =?us-ascii?Q?kKNaGi7sAPWCtc6c+aFgbzqt1T1ZG0/ijwqZCEzo0I+acGjS8SMwX2ZYUDb+?=
 =?us-ascii?Q?JfIQlu5fMg/FzRLHmaJYHZ7X7GmLvmVYKKt4VPiqxnfRFnRecdx2/lRZCw4J?=
 =?us-ascii?Q?famyYzv4j+lWz4XGEcJdFZTXHAbqjzLDQpo20c+8EgLatUB+v1q4IdHoQqnH?=
 =?us-ascii?Q?ApH2BZCtqwPT9bqv6Ahuio5415JHJazKZ/Y+d9lRt5EXGGhb0yOE1SJgn99f?=
 =?us-ascii?Q?e28ftXuemWEhTPh2ZPoNB4A/9DsDhpAK70/wr6OALSF0Ja7c0r5HD0UktQ6u?=
 =?us-ascii?Q?kEMHm/24D2n5n7H7BNswdgbQ0b3sB214Z+p08A63Z+H300Ajf6/3g4x9/cCV?=
 =?us-ascii?Q?0int+nbcxDiv/mugsnN5wiElMPTxM7cF7tGByFh2Eu3TMWc/O3Hdwm8WcBOT?=
 =?us-ascii?Q?IwyDD9772TzFuNYGC5l8oBRus6vtkbBZjLT7BgbJC2bv7Cb5sO9QQI3NgXGt?=
 =?us-ascii?Q?zfBxV4rfQeEn6QZlXxFowTkjgKMRfrC4teFS0vZ0JMXA0+RUT4vvOSPKuoYA?=
 =?us-ascii?Q?Q7smUzCmhFB+5hqvxgliHnRgEGEyDfUcCKW23sZ8z2Sq5tdHo8C1Tisiz0bl?=
 =?us-ascii?Q?Tqf6qVvngn5sFwhMu/dFdDwzK1euGaqwbvfozb4MYbp/Szj0iMrI09XGj2vN?=
 =?us-ascii?Q?TMuJGRcQ/D3w5IF0MdcZA2NmYO7MZalbptqwUsMHOZ1jtfY7flQIMLXWOEQU?=
 =?us-ascii?Q?wngdOxXe4PzpRWN0fI2anQGKDrzPOcwr0cb5EriCK2SyzLsdvMBypoyrIcSQ?=
 =?us-ascii?Q?R7489CZTjbT+u0D4MVP0NxoDqVz9x8etN1pbjtglsgUBj03gYdyaU0UkICEA?=
 =?us-ascii?Q?6/ylCRxDZhVrurim7iDNlEbO6E50zhS87A76O/KS9s5XkuBHRsw5B8djkyAJ?=
 =?us-ascii?Q?pQLOPwk4hD/+PCT1OnTlPHaJpPda0yeYNPvoxor8Hh0aFjcAvIKZ/5QPeTzQ?=
 =?us-ascii?Q?cY2su4AOMWfPH+l0GuuSUGPfguAC07eZhKAT5ggnT9yqZ3QtKzj7z9odgIds?=
 =?us-ascii?Q?VaWdtfzoBMZgqwFOXLkiMLHMAAzV/O51rxHVoaG7rhlQGvM4Bh9cV017c+Tp?=
 =?us-ascii?Q?ci//ZOU9p6EB22vhg+DYVj4U78I5RgYMZlnkyPhw4pcJeOM+Mrdmi0l2jOtc?=
 =?us-ascii?Q?u1krbtuM0Bs92FEMro5fW55lv08r1g7oQjbieh65jSUZZPogm0msjiNs7qEY?=
 =?us-ascii?Q?cLr/CPNMCGztiouRKyZhTdMqF7hzmBucs47wWdNobSNZMxwB3mvG9YuLZAp4?=
 =?us-ascii?Q?DQj2/mxfXM2zJ940/aXZBHhbMvOIT+37npvVqrjm4qJBfHfFqksmPf8DPXUR?=
 =?us-ascii?Q?BAjh5qazFX+Cj4tVN/KX1l+1llidC+UWjzGkmk4LvRnt+ra+igj4txawaXF5?=
 =?us-ascii?Q?yu2X6Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2da201-40b9-42ad-931c-08ddc06178d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:22.9364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IofLG7j6QI/jwU5twdwktKpWJkc1NtiyITsSOPTOu4MQOgsgtDM5bSy4TRqux79bBEZdqfS+0+TKm97yTc2kE8rfNMrlr2gf++nPv8ooz3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX1j7h1q7X6D7G
 lTdr0azZwOwPJYLYdZJezwzn+Ev6je2ikmitfx+2qdRtWBHvdjvDDT80uR1SOsFcYQ9enMLQ8Yx
 dGB6QkIHtPtuZnjYbw1OqDzCT45PghlINGoD/lHRXOqK3P5SgTJTDPLQYw4633txuZIV7SE/bep
 whAnviCIL9YrNVmfB3XR+chrT0PPDAbncwC9/Hv7W8YQ2ZTV2jYWaE+Z1Qz1q7vkxCRDpkdtJKk
 W2T4ll31fWGfS7h28KkszngTFPRW0DruNU1oXyZhyrRaKAdkFgtxOQPUZU9QL7zf1n7gklQxW3x
 MzRMV8ofjknCca9z9b3N60TDyfCrLAAXYHdO7FWrnZty4LcBxXK9m6xEEb447Se7DLxyFwe5CZ9
 eAKmj3AB+iRA/gB7vMXtN9x8jYAnFZ+5MNQZ11VUDMKMkmIZQ5KMzGUrz4Ikey9zbTHeufT7
X-Proofpoint-ORIG-GUID: ndq7cmLf94A2g7DQ5qwSo_p6dAoIpkKW
X-Authority-Analysis: v=2.4 cv=Do9W+H/+ c=1 sm=1 tr=0 ts=6870e040 cx=c_pps
 a=qdGNMY5putnn3dTEtBI8ag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=2ibDuaHqQIY5G2AKcNYA:9
X-Proofpoint-GUID: ndq7cmLf94A2g7DQ5qwSo_p6dAoIpkKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

This header is not required since the loader functionality is handled separately
by pc_memory_init() in pc.c.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 34beea993e..4b0eeb4497 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -28,7 +28,6 @@
 #include "qemu/units.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/dma/i8257.h"
-#include "hw/loader.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
-- 
2.43.0


