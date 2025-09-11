Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B82CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 14:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwiCJ-0000Mo-9w; Thu, 11 Sep 2025 10:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uwiCF-0000MN-KU
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:22:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uwiC9-0000mI-Sn
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:22:46 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58BDv6E03241837; Thu, 11 Sep 2025 07:22:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=EQaa6+CJtfAQd
 aVjUWbgsjO/l8WrwNbpAl5OtMvTiGg=; b=HvRUORNAxvCpr63ktRZBg5cbtEvMK
 zG1mm/vBqUH32X2vNoGNIBoXzQJLB0FvujCkYSo25SvgXmQebNHPJc6KDvfXvgdF
 BAW+koRBjWuxKrr3JyGPGlxnyavgCbOiJSqtGyZ4pYcpoDXFf4TJTFg8iMLm2Gus
 2KeJkFJfCmaxI0lrYaMehy6j9q4nVfbfMVxiaT9Rngj36U03AzhdANr9UxviB9Hx
 z8LkxwUqjVKu2YM+BLbjYWDsJ71g5XdUS5ulpOevzs+3ouXqx0mlKQlUXdmI4sRR
 aaIRaDE7iQWMwKmLxR/c3z+hwFZzXvgPciyykekXCJT0vd8tIMzCyVSHA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021100.outbound.protection.outlook.com [52.101.62.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 493yrv825j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 07:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHT/owGsyyMK0wDkMHCHtCVePRbZjU+R1aypwVgT5vc5ADze/jtXT3jjphApuFJNtXvfHrlkxH/vr8L0l0KK0kyPKQxo91tg4Auql2oNWLHxxAUOwKB2dR1pA3TW3yTSSVoTaWB3mAp3l/u60G+AE5BF7+JkYSdkYe65xqUZQVcp07tGIGLR6u/8Epo0fzG9/lZQ8MgnY8NS5Q/tIPODRMpeHpfUPoZzeYsx2fsKQj6dX1NZOcrEp2ErnQszlXYrB/uGLtP4oVsiyS6AFQvm9T2IdPrsZoPTQSvMJ6ju8r9Xd3UZEqVKRi3tOhbif0q2e/51w0D4EMspejgMjVtKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQaa6+CJtfAQdaVjUWbgsjO/l8WrwNbpAl5OtMvTiGg=;
 b=nDRvCQv3yJYLXfofVewdd2UJ68fBGRNRI8ivbNuGHH4fpF8SZ4nlOEHb795bysAxOMkZji2W9y7T/7Q6vmGlEQYRssmN1myu9ginSge9DMxwHQTzypkPydvsC10xFE7McflqS3NkITsjZkz2jUR+oR1JkuPkf4DhcUd6x507ydUCULeYqBpb2oYF/2Th+5j0aZnXyy1gOyJIpv7pHk1pQJ84DmVxPri33GWDOKx14E7vFLL2JfhM2Wod624cwQCfK5pikW94ZA1HBCc5Mtwcr2oVYZfNRh6zXJuLgevWfnHJLrYnubvvfljooPquEprxy3pW/Qtur8XfucamQa8grQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQaa6+CJtfAQdaVjUWbgsjO/l8WrwNbpAl5OtMvTiGg=;
 b=h6g51q5vY8jSEjlXtSJtPGXUzy8SDKNUEUt/vQFenJZu6RWckjTx+f4GWHIaWnWtSgbgYQNL+5TY6AhCkjfp/3bvBh6JClC8JFO1Ofyrw9e046CQ51yOQ91+4rPAUMLbcInQfTu/qEzpW/xi8bfHSU0kWoCEMEf2kZ9/VXdfHaAw4jga8kR43WWJb262RsHZtd90ilaSpk4mRJk24DEPbAiyMmhdeBvLae5QjKlUOr1AJDmKUYXMI7e2L/7pATPyZ+35GuNXqQAE6YL0O7/HIIbrNmb9veBixtio8RK2EvllUgonZUXqdhYpMFtQgzpqvfYFIpuo9834pe4YJBV/iQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8017.namprd02.prod.outlook.com (2603:10b6:208:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:22:32 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:22:32 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v5] tests/functional: add a vfio-user smoke test
Date: Thu, 11 Sep 2025 16:22:28 +0200
Message-ID: <20250911142228.1955529-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e157f4b-9223-4a68-bc36-08ddf13ea566
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MWpgfpa0/lMlb4wI6IUttq8b4A0IbjL9J8ULik3lEgZ0aGpEgZ+3HijMUL4D?=
 =?us-ascii?Q?6nL6ecjFbScDzzANE/d5rRLIP1RTZMlLLt9yHeM4MAYFEzdkvtrkAu6TV60g?=
 =?us-ascii?Q?88O7iOHq5TuLHhbloEUFn3fflcNNLh8hQRfsOfENwQkdDgGaDwV2rQDrdk0h?=
 =?us-ascii?Q?dHRT2JamLxU4DzE4IGPndyazpVcCm30F63QjFla+9xYF810r00mwdPUEkcgR?=
 =?us-ascii?Q?CQAuN7VYN7Yg6aPRUn2j1rJAAWz5M0QMgskyeM+finj7D+pKq9Lrtf8ULfEL?=
 =?us-ascii?Q?j9XVHBOqQgnV7YSKUXoginLInauAGIwnlkvtvYasL1K1D37E88j4FKUOV+ap?=
 =?us-ascii?Q?vehcjIj4DeJZPMK5Y3BVPsv7VG3+Iq30jg5ITKV1dQMImZwsPVAALqGyFK5c?=
 =?us-ascii?Q?xmaODHMyGUWwH66RWfRYGJ+/UcQ3jKwW7nz0d0JUAhUJu/xj71jHczKTnj5n?=
 =?us-ascii?Q?yBM1wiODAkCX1HOLKHkDhzQFxm1lApTwh9cyDoemaWWE8kBpxS4eCabyvYVg?=
 =?us-ascii?Q?eOP+v1c4bvfhW9qp0Fx0lqN6mRFefNP6kCTo+hyDUVOyArGKhompO7Aad6aY?=
 =?us-ascii?Q?LQZC2boCD0Wdw2DTSCZmRYaGX1n7ZCEY1CKEtIV261me8W0ug7L2bKOtcJhd?=
 =?us-ascii?Q?cwTrFSeaejnHVrPNMCgO6dyVqEpPeROVeZx1ItoP5pgTYMtgSBzeG6B/skOr?=
 =?us-ascii?Q?EJYRAjYc2hvgXqRZqPhehY7JgRyg0zgJrT6d9CKPww9+vrYs3FwW010UmszU?=
 =?us-ascii?Q?klC9RrPb1ed4AG9mjANiO11ZexCXXOO0qfyRjhwoJ8dnEY/PVOkPMr3ep2u0?=
 =?us-ascii?Q?zkI42p0EY7/1GmriGt5/yoVzxeXzbEHfGsHakxqwR+RAjEF0E92aRqC/UgDY?=
 =?us-ascii?Q?4wxsEVTaHTfUycSKWYHMp0MCs1BOI6Vc/5fK6x72DB2nnFmzrkUhB+XUQCxw?=
 =?us-ascii?Q?wKAH+vIqiqmEEmOyxcllS6jYWroXompBxBobWXMuoFky5mYuVTjru62qFLSd?=
 =?us-ascii?Q?IRiwyky2f64APfdU6xM1CqKFagvEgQEutMFBmaZF9O6u5j1L/lCY7bys/7yN?=
 =?us-ascii?Q?SLSU3k601vC83ObHxyEgN5bUFHsu9noSVF75ANmxgoDHjXM1vVcYylsVeINI?=
 =?us-ascii?Q?i6m4FUSGXeZaA2aJPc6QEnGEtnjtSqLWVPAAh/+X37r2E1ubJwSu5eMLHMh9?=
 =?us-ascii?Q?l9PJWY7+lRLnd4wHWV23P/pQ5H2i9V8C/QYJIOHAwqYNQHJkCOv4/UbtDOt/?=
 =?us-ascii?Q?FzkhMLld+QhkY567nyTlrwj8/foQWaPS9ImOYvWocAzjn2b8qAKyx7UuJTh/?=
 =?us-ascii?Q?z3ByGVf8WX+7sciSl0+Xqlu5VK38JT4gM5Jjj6vd9KyHyMLomlXul3dD9vh/?=
 =?us-ascii?Q?TFnlDAcfqHhASHfD9BKQJDuI7m1KotA1TZr9cvgC/t5ueuX/S42+OJINw+oE?=
 =?us-ascii?Q?LlSq6k5j7wo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2KPbVsmC8iVGqpE54+j+fPmM8f1vUq3+azksTR+JAiYXu7VhOhTgSlG++Lx?=
 =?us-ascii?Q?xVfN+Xpg8qoHo+IR1ysE3PlMV+oPQQXV8SoUjlhBXkWOCY6Y4nk+cXwxOmPO?=
 =?us-ascii?Q?834/MNFV2pOQT5+5F1AnDB6tTWlr3HaUN+9bkxbdo/LyM3J9SIdFxEqWJMy2?=
 =?us-ascii?Q?qnBjjdNRbwkaBwpO8Qz+e7ECPR7RcFYtwsLxf3harml3D3fr09tNpSNmQ0WG?=
 =?us-ascii?Q?9I2VCB53cZ2U8jOG4Z+JVtt07Y05uZIM+qEoOpaDmrvADtOxbfcMC2t5XS/X?=
 =?us-ascii?Q?kr+XlGQpl4TQmyo+KnIlOj5K4brAhTQNuwsEeawAmkfkpPY8Jhuj/yERKfsg?=
 =?us-ascii?Q?0Q0rlEPJyhGxGWa+8Idv8SQK4b9EEO1+IlDTE7ulp9VbLlLuP/I7wUZ37+D4?=
 =?us-ascii?Q?Bhd6CvSEY23qbgQBNFpdQNrfuOBG37RhSWH0OPFPGZCFm2EeuLB7VU3jOyZu?=
 =?us-ascii?Q?axmZ9v8KqsciZ8YAlC6kiYYjv4ZzjEJubX+cQU08HxNQ7IprqC9oQNWpIgZA?=
 =?us-ascii?Q?q9F+hQmXr14QNhNkMDcEm3rbCHUE1OvRZG24Mds7mqIT6fFRbYtGeIwU+n5n?=
 =?us-ascii?Q?GD0nBVecMHUE31a6AtFJwH+EgMbkmlt0qXxUfwz4A33DAhjDgy59hYKdZT+F?=
 =?us-ascii?Q?FSUCI5WBIGdjH+o53g5BQwX/0BrajXzz3PIAWCnYQhCVmlgETseJhLISUMt9?=
 =?us-ascii?Q?vIKg3qPRXZM3ojCpDEtA/NKWGrL5o/X4zFmJZ4aE5fqzSPW5yBKFXOAQNyJ8?=
 =?us-ascii?Q?W83WRvh0DJJphwmypkEbH4dEy5yZOGGXnZhR4qNB/JKusi8F8f+mQsCyMWO8?=
 =?us-ascii?Q?UzN/gQmVA6m0GrGChQaIHnPGtQlpNQw6LZkZ0KP5bXzyT9lAOqjbYQvJPb8B?=
 =?us-ascii?Q?w+TD2amE1JkQezjTB6//urKczuBZBEaT2yWST5jSw2+aOj+N50nVN5mjyLf+?=
 =?us-ascii?Q?vOpWSYLRe4pJhhYmcuyCfgsF5pQ2HFILpLwIhXV4C5c/ZiH2kwEfL0Y8gx0s?=
 =?us-ascii?Q?/EFVJc/xbmlvMHXzFJwAQJod9kxTRi1PCBaXcvPSG4BYxlHvYleUOdj0gqq1?=
 =?us-ascii?Q?SG7AmO+9hM6EyzrTG1chkeFnu4lXwU5Kttji+IXHpwsMYvak92mXYmeRhRe+?=
 =?us-ascii?Q?Ewwd9nWixwgD1Sv3n54mVBXTQimHCbWXBwYka0KEuAyq+8W1/8vBmHcjKzMl?=
 =?us-ascii?Q?CJtkqX/sUx5cn00o3yGjKRdWrE67uXhP1xZVjxtea1o7gZ2Df6iAsnse/OC6?=
 =?us-ascii?Q?xKlxq6+DRauBV4DMT3hY5Oae7/vd3/UdGJu55vJgRPUU8wTIc78eGMPeMvzD?=
 =?us-ascii?Q?uaoopvYfkyr7rb9bNC8Tnupa4O+bXoK4NXLuA8WEiHWjqms1gLt48jJx5Jan?=
 =?us-ascii?Q?RBIV8nqrfNkbOWE08vhCBcyffZq1mKlCofgnHc+CVK15pcysovEmEVVZNyG9?=
 =?us-ascii?Q?pKtcar9b8SMyFsrhtaLyL2LF+R0PBgHPT4LkEh5Z4KAFFeZZAqYt+ZqtpY5P?=
 =?us-ascii?Q?kEMBtNMPRUDNGm7AUvM8tj/T97PB5c7RQcvZOKfBozhKmud1cRwmWSuzuR9a?=
 =?us-ascii?Q?9hmorlKrwGdeVnkhOxJ6kGvnHz9BxKlcEFO5pdrJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e157f4b-9223-4a68-bc36-08ddf13ea566
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:22:32.4203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae11z6I/ElUibcM2Q2F2C6Bw2t5PdHOwNybmRd/jSUpMgMtu/A9pJ2ModbcfpQC011gEOFwZdWfN9nnvpmFr+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8017
X-Proofpoint-GUID: i7oWTxsAx7orv-lrN-9jOUhG8Xe_Q4XG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDEyNiBTYWx0ZWRfX0w5iKQMH2mQ3
 WHxMxpkA+4SLBJ03mjbyRsautMNjZ9ctUcB+VTUjKBo8mpNKKnDoDuAK8ldqTAl/Ks18LpFrYTp
 ZNGuofKTXsI2fI6Ovtr2OOEYk3JhK68E1WJSF/oxc3a0ZsJGPmMHQzSqLGif/Lh18N+mYTNGM5g
 xFQzunTwZUTc8WLpzqF+op54HW0PcgY2R/CZliZZmKRpkuIFIRiYaZngJmdAq/OCWUYE9ztFUA5
 soyM5mGus4bVix1XDcY32eSrtn16I8hwBNcCxgl4z8UDLXFwIW8CFWGPPzMOEyxLD40vjpgOrdY
 eMJ+hXN/itezy7tYM+CEjmnjmKNOoztXCJ4l+dgZu1LeoeMS+Vs9M40QuSJcP8=
X-Authority-Analysis: v=2.4 cv=HLLDFptv c=1 sm=1 tr=0 ts=68c2db2a cx=c_pps
 a=qXr7QywujOwG71/BKD+DQg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=Qao5vpg7bkeMYIVlSYQA:9
X-Proofpoint-ORIG-GUID: i7oWTxsAx7orv-lrN-9jOUhG8Xe_Q4XG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Add a basic test of the vfio-user PCI client implementation.

Co-authored-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                                   |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vfio_user_client.py           | 197 ++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vfio_user_client.py

diff --git a/MAINTAINERS b/MAINTAINERS
index fb045388b9..738db4f83b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4307,6 +4307,7 @@ F: docs/system/devices/vfio-user.rst
 F: hw/vfio-user/*
 F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
+F: tests/functional/x86_64/test_vfio_user_client.py
 
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index d0b4667bb8..eed1936976 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -31,6 +31,7 @@ tests_x86_64_system_thorough = [
   'replay',
   'reverse_debug',
   'tuxrun',
+  'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
 ]
diff --git a/tests/functional/x86_64/test_vfio_user_client.py b/tests/functional/x86_64/test_vfio_user_client.py
new file mode 100755
index 0000000000..1e4c5bc875
--- /dev/null
+++ b/tests/functional/x86_64/test_vfio_user_client.py
@@ -0,0 +1,197 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2025 Nutanix, Inc.
+#
+# Author:
+#  Mark Cave-Ayland <mark.caveayland@nutanix.com>
+#  John Levon <john.levon@nutanix.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Check basic vfio-user-pci client functionality. The test starts two VMs:
+
+    - the server VM runs the libvfio-user "gpio" example server inside it,
+      piping vfio-user traffic between a local UNIX socket and a virtio-serial
+      port. On the host, the virtio-serial port is backed by a local socket.
+
+    - the client VM loads the gpio-pci-idio-16 kernel module, with the
+      vfio-user client connecting to the above local UNIX socket.
+
+This way, we don't depend on trying to run a vfio-user server on the host
+itself.
+
+Once both VMs are running, we run some basic configuration on the gpio device
+and verify that the server is logging the expected out. As this is consistent
+given the same VM images, we just do a simple direct comparison.
+"""
+
+import difflib
+import logging
+import os
+import select
+import shutil
+import socket
+import subprocess
+import time
+
+from qemu_test import Asset
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+# Exact output can vary, so we just sample for some expected lines.
+EXPECTED_SERVER_LINES = [
+    "gpio: adding DMA region [0, 0xc0000) offset=0 flags=0x3",
+    "gpio: devinfo flags 0x3, num_regions 9, num_irqs 5",
+    "gpio: region_info[0] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[1] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[2] offset 0 flags 0x3 size 256 argsz 32",
+    "gpio: region_info[3] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[4] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[5] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[7] offset 0 flags 0x3 size 256 argsz 32",
+    "gpio: region7: read 256 bytes at 0",
+    "gpio: region7: read 0 from (0x30:4)",
+    "gpio: cleared EROM",
+    "gpio: I/O space enabled",
+    "gpio: memory space enabled",
+    "gpio: SERR# enabled",
+    "gpio: region7: wrote 0x103 to (0x4:2)",
+    "gpio: I/O space enabled",
+    "gpio: memory space enabled",
+]
+
+class VfioUserClient(QemuSystemTest):
+
+    ASSET_REPO = 'https://github.com/mcayland-ntx/libvfio-user-test'
+
+    ASSET_KERNEL = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/bzImage',
+        '40292fa6ce95d516e26bccf5974e138d0db65a6de0bc540cabae060fe9dea605'
+    )
+
+    ASSET_ROOTFS = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/rootfs.ext2',
+        'e1e3abae8aebb8e6e77f08b1c531caeacf46250c94c815655c6bbea59fc3d1c1'
+    )
+
+
+    def prepare_images(self):
+        """Download the images for the VMs."""
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.rootfs_path = self.ASSET_ROOTFS.fetch()
+
+    def configure_server_vm_args(self, server_vm, sock_path):
+        """
+        Configuration for the server VM. Set up virtio-serial device backed by
+        the given socket path.
+        """
+        server_vm.add_args('-kernel', self.kernel_path)
+        server_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        server_vm.add_args('-drive',
+            f"file={self.rootfs_path},if=ide,format=raw,id=drv0")
+        server_vm.add_args('-snapshot')
+        server_vm.add_args('-chardev',
+            f"socket,id=sock0,path={sock_path},telnet=off,server=on,wait=off")
+        server_vm.add_args('-device', 'virtio-serial')
+        server_vm.add_args('-device',
+            'virtserialport,chardev=sock0,name=org.fedoraproject.port.0')
+
+    def configure_client_vm_args(self, client_vm, sock_path):
+        """
+        Configuration for the client VM. Point the vfio-user-pci device to the
+        socket path configured above.
+        """
+
+        client_vm.add_args('-kernel', self.kernel_path)
+        client_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        client_vm.add_args('-drive',
+            f'file={self.rootfs_path},if=ide,format=raw,id=drv0')
+        client_vm.add_args('-snapshot')
+        client_vm.add_args('-device',
+            '{"driver":"vfio-user-pci",' +
+            '"socket":{"path": "%s", "type": "unix"}}' % sock_path)
+
+    def setup_vfio_user_pci_server(self, server_vm):
+        """
+        Start the libvfio-user server within the server VM, and arrange
+        for data to shuttle between its socket and the virtio serial port.
+        """
+        wait_for_console_pattern(self, 'login:', None, server_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, server_vm)
+
+        exec_command_and_wait_for_pattern(self,
+            'gpio-pci-idio-16 -v /tmp/vfio-user.sock >/var/tmp/gpio.out 2>&1 &',
+            '#', None, server_vm)
+        # wait for libvfio-user to initialize properly
+        exec_command_and_wait_for_pattern(self, 'sleep 5', '#', None, server_vm)
+        exec_command_and_wait_for_pattern(self,
+            'socat UNIX-CONNECT:/tmp/vfio-user.sock /dev/vport0p1,ignoreeof ' +
+            ' &', '#', None, server_vm)
+
+    def test_vfio_user_pci(self):
+        self.prepare_images()
+        self.set_machine('pc')
+        self.require_device('virtio-serial')
+        self.require_device('vfio-user-pci')
+
+        sock_dir = self.socket_dir()
+        socket_path = sock_dir.name + '/vfio-user.sock'
+
+        server_vm = self.get_vm(name='server')
+        server_vm.set_console()
+        self.configure_server_vm_args(server_vm, socket_path)
+
+        server_vm.launch()
+
+        self.log.debug('starting libvfio-user server')
+
+        self.setup_vfio_user_pci_server(server_vm)
+
+        client_vm = self.get_vm(name="client")
+        client_vm.set_console()
+        self.configure_client_vm_args(client_vm, socket_path)
+
+        try:
+            client_vm.launch()
+        except:
+            self.log.error('client VM failed to start, dumping server logs')
+            exec_command_and_wait_for_pattern(self, 'cat /var/tmp/gpio.out',
+                '#', None, server_vm)
+            raise
+
+        self.log.debug('waiting for client VM boot')
+
+        wait_for_console_pattern(self, 'login:', None, client_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, client_vm)
+
+        #
+        # Here, we'd like to actually interact with the gpio device a little
+        # more as described at:
+        #
+        # https://github.com/nutanix/libvfio-user/blob/master/docs/qemu.md
+        #
+        # Unfortunately, the buildroot Linux kernel has some undiagnosed issue
+        # so we don't get /sys/class/gpio. Nonetheless just the basic
+        # initialization and setup is enough for basic testing of vfio-user.
+        #
+
+        self.log.debug('collecting libvfio-user server output')
+
+        out = exec_command_and_wait_for_pattern(self,
+            'cat /var/tmp/gpio.out',
+            'gpio: region2: wrote 0 to (0x1:1)',
+            None, server_vm)
+
+        gpio_server_out = [s for s in out.decode().splitlines()
+                                   if s.startswith("gpio:")]
+
+        for line in EXPECTED_SERVER_LINES:
+            if line not in gpio_server_out:
+                self.log.error(f'Missing server debug line: {line}')
+                self.fail(False)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


