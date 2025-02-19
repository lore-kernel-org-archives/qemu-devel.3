Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775F6C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOM-0003IJ-EK; Wed, 19 Feb 2025 09:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOJ-0003HJ-HH; Wed, 19 Feb 2025 09:49:35 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOH-0007BS-F2; Wed, 19 Feb 2025 09:49:35 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9AX1j005473;
 Wed, 19 Feb 2025 06:49:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=HQdSA7x38g8YEsjh3cyKdpWtPJB9DO8ho7wS3JbgW
 V0=; b=LGweDeW7voL2bp7exPHQjFgAEsUN98wd0TcjR/9sxhFjm0juwZh2/2ux/
 cbuufqvYluOh3ca03LV4LY/qdphWyE3QBpoBDaNHH00d2vjHTkre2dKA2jsIFw89
 EIrHUhQiNl1cgQPpNKTHyEDTXXvc9YGNRR69bQ5QvZjZSNGW9Gv0xQ0e5Whm1Rm0
 +v7uqBADv4aYqFubK6eUlNLYNHYNpPpxvP6wjyFUBzvzfAK9L5t1u9C+rkhoWuYR
 VNhhWMKOKSpL5SujEN94aVbZEUGWRGnemQTGlHcr2QefRqt6vXJkSb32rLYhA7x0
 dmtkImHdyCBuphNh+u6udhiub4/og==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013063.outbound.protection.outlook.com
 [40.93.20.63])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basxr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mt8Nt6WVqi+3CjOsgT+LkTs2SLyN+wiM+JoWP4y72wQi9vUj57bnaYzw0lsdy+YWSLIGIFCjYE98V7fLjM2KqLREi2r4lFTyYAv8BgJUAcUZ/ePkE4CNLPWN6EYC4k9548sL1INlD4VBBWZjdDk8rYXqeJV7NH3uj2+NL3C4S4XQkLClgB6nldJbz/lSn2tVQ9/NGs906LOXJNXBNUlDsmVbT0H8PhbVttbzzfH7kDUpn6Ye8aU8UnzbGsdIfir0TXtJGAcwOw+He3neuK4NKDnTwg7BbAVe499G2dfk6QH9lBfPHLPAPc6ohqGHbAN8wwoJ/MMwiiN/9KEsGurD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQdSA7x38g8YEsjh3cyKdpWtPJB9DO8ho7wS3JbgWV0=;
 b=tu2P5qG4TXlYj1Y985T/gVO/J/88QgXUnGZ5QiYJNDDqDnK+ezAMlDby0T3Mml7IgAFxqhXrqVUCKOrbghAYo+GNR3CUWZ7jmxFel9kovscw2I5yycz2hbV4p6RwGyU9Pm/RGbpAMWVTxutl0UD4edyyCXm4ugeEhjzJ6/G5z4R8jyzzCAXN1sKv+XuKthJoSbMKDCAIbxQpPdlm+tfp7XBfM6M/9PqK2VEZ1B19N6fVkOhXStY2+XQLxiet1qCOYK6jW+XGJNHbR4pkAuXdmjCHs9Jrfq1h2Ijv1W9alS0qdHlXEd/8QjShkTzJiGHbLrCYI2qXYT+7WMJmT9wo0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQdSA7x38g8YEsjh3cyKdpWtPJB9DO8ho7wS3JbgWV0=;
 b=KjAGC4yJ7t6fROLhlPHWJJLF5XYm2FF3q0JZMgljfslaQq2Z2C4FesLO0IYup3mMNcDdyQX1jKl3dvde+K/gCyM6eOFtAFbccFA5INC5DxbI/VFXdrSqq8mGbZrn6HS59tvfnNgZIRLSm+9m7B56/0eYbU0XUvQiYvPEqDmM9SUDJKS9N+y048PtB1VfgDCcGVYWrnFCDIoWHL8qz2Z/2nlM/nSji5ctxBOhoRCS8eFitLrmNFE+qGlZblO0jkIzhecnk7L15qk0JjBbIaLXP6KvOEUQkW8rKOnPYazk2zcd1GGfGlHrfPHEFk4Ub7hpjhkKrerEpM02z6yy+CbIlg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:28 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:27 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 05/28] vfio: add vfio_prepare_device()
Date: Wed, 19 Feb 2025 15:48:35 +0100
Message-Id: <20250219144858.266455-6-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cfc5eb-cbdc-4ac1-7567-08dd50f49c18
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eCPDiyTBFPu66P4VbXa8ABtn4Joxv0kVuEf01Q4oS6YW85kdNw7uPrLCEqRZ?=
 =?us-ascii?Q?NeGO/nbIpnLIiSKdaFncdq9TRrOK2vzevu4W064tW2WZMJyyTlmVmF4eZzKL?=
 =?us-ascii?Q?eoDwrO1haSjyk7NM7VFUDf0yUWeDRmHXwQsF5TaMbsWFcBYxZd/Tp0SqeLV6?=
 =?us-ascii?Q?oKXsmyy67TnJzYBG8jZs+Do6axhsJQdBQzBC6YqzlUkK4ZqOHUhP2lok678E?=
 =?us-ascii?Q?R+raYmSLuwa/HWx3hyHJe7reXq2SnlblxEdtLBCKmN2A0yTB7enK2dx52Jul?=
 =?us-ascii?Q?pMcZd5+nnB4S/G1wcMDGe0VTia7RNv/KitF/LXMeL70irAk9hljgBkkwJGjU?=
 =?us-ascii?Q?0ax670ujqsAtgtRUf9jWMSd4WkcR4uFy0x3+lyBDnsC1uCiu96xsQ8WLEP5q?=
 =?us-ascii?Q?aZSQHxI7tXu6MWqaq9NxXmEcGIKwbRnPPOqNksO3ycEkFJt85ImaZrYL6jL9?=
 =?us-ascii?Q?J88ydvjQahvvvbZHfxqqWzx2EUVwWlMEHa3CU4b8JuLruKTi87NWkvI0cJk/?=
 =?us-ascii?Q?OPdv/uiQQ+CDEx0d3vEHfpA/LnbEBdR92JM0CpYkNGmqpqmtgKo46awL9vWV?=
 =?us-ascii?Q?mRrM0yDFm2FUtr9//5Z4/q9EfN3xD7TRy/LrfPCa6gm/uFnE5ut6Y8Qh7VJm?=
 =?us-ascii?Q?hg4qnL6XJO9YLKvHJhSoTpMU04tNktbNvNrtPcpSE87m/NtXLPZPMVnhQM3q?=
 =?us-ascii?Q?Pfu0Q+35DxO+LMT9VjObzFvUVMrW9XyAB7ZLdKLnvFcshdB3dhvyQIyM+anL?=
 =?us-ascii?Q?m+VhnBwHuEcqbPWvPEUFLryBDF7IX54hgCTfZoJFKyZ0pDrAOQtBou2xDyhd?=
 =?us-ascii?Q?slVssgwa/BgdeMJpe5dqYqojo2MGLS/MLzkOKBeBmZxLBhgu+vnZXfWSTZiC?=
 =?us-ascii?Q?HiaSm+btR78cSsLnrVtdPtEV/+11dWsVdw1cDtb9KZoXr7+djrB/o1nDh663?=
 =?us-ascii?Q?ogPUy2nQrFx1vtVImAQtmCNQyJYBTRIw2eqEdsF4ZSs4K6oPzSoTwrbHEjaq?=
 =?us-ascii?Q?5OfDYHn8+n5Nc5yFADpkOIGFWOATDrv/ZpKYC2xb0q3bgVppQdBS+zRWjxku?=
 =?us-ascii?Q?+5Wp/9qxAAubMkX18d89BPLaPXdO9fV+urUNs7QAHZdnRfT9ZBzXDLl8C64K?=
 =?us-ascii?Q?xYjF4qnoCK0M0k2pCD/8qimHGUUbjNwQULQgnbpHj+s63XNeFetXSyvjqB4F?=
 =?us-ascii?Q?IGiBLunNOniuAPwP8xgsMpYnlO2LzzYnp6L9tzc5fzRd1kTZkSkCgBJ4NUHj?=
 =?us-ascii?Q?RxJ1MSwYpvQs5WWG0rKs9ReS/Zfi4RtDKaZM2TNlS3pmHB7MXpYivfb5axbf?=
 =?us-ascii?Q?JMkfU3hfCX2Ng0IVhTlHUbHMhTLvIDTLDe0f6HnvoNU4BezZeriIQuDbfLuT?=
 =?us-ascii?Q?E6TX7UwZdh6IOT740Bx+eqAhE79T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iN3ieMTC2RN3av4PfQQyQtoLYv2qwp6scf+NeSMTp8P4w5PjYRaUIyFXiz5b?=
 =?us-ascii?Q?nnUgq4aBsoS6TCcAXrGLsrXYHpwMRn4AcrHJz3ReY55ISRvhliJGwHpDPVwW?=
 =?us-ascii?Q?UGrwTCed9Ihhj729sFHtFMxcxOYdP5EAwyOrEQgPWqQaLr40e2HVPWv2+gO9?=
 =?us-ascii?Q?m0gnFWzLxODguGbcl00yT7rgDdg7knPPNRiRXj5eKvHkLRezEn/IZg55byVD?=
 =?us-ascii?Q?vshrGpLeKbn3uTlxIl/eFHK8I+vFneHkzyBdN/u0FMMEYQhtT0b9Gz+L18yw?=
 =?us-ascii?Q?WcUKhg/rcvDLnEx/nixiOKb+WPKbLUppWg2XDBWo5HUNMGZC2VrWc9MqgHj0?=
 =?us-ascii?Q?bP+lLdG0V2rL2FF3icpDRpwByWU944BYC4wMfpUtpWTynn+Bled16/Qf2ZrI?=
 =?us-ascii?Q?LxqbagE1CJuVILZMnWgMr2LDZ5PSuDyIungL8Izv9+KZuXOCIH1r6ivxQgYM?=
 =?us-ascii?Q?O4OD22AN/SD99FJR+Bqs//LpEqzWqDoLu4ONiF2HvlyTToFqvCmUdXJQ39Tz?=
 =?us-ascii?Q?1yZtB1dhDQs+zgw9TFNarmuP+A15B9ng9fUMJGa1h3QoLn9Z8RCluqfFeMdk?=
 =?us-ascii?Q?AT3mRw0Pyi3GSHsWuJDBEoC/qIbKkSUtG9SkaucPPs+wxkiimCnSeLXAvaFy?=
 =?us-ascii?Q?L578+mZQphqIGpbKP7CrFpIx239m8BY8S7sPcqE3ADKMUsmu/sQyJUXfaNBF?=
 =?us-ascii?Q?kynz0NOKEnQIEDmk16Zkvv2FvwoQVmNZwNc3Piar0oTbwx2qGU3HKKwHLhu5?=
 =?us-ascii?Q?kgU9l8oaxhhCdZr4B7U88r2iBUVNFGyNmFOyCujg7NFhDkQCIALwBbFGpqgS?=
 =?us-ascii?Q?kW8h3bWAWwP7hCPOWalNANrZUe1nSQ+vqtaR+jrkaY6YTHr3tSvfQG22ybtj?=
 =?us-ascii?Q?+lXnIvX68kMx28VPDWe0DHSkuCHT4jVw+GljmTZiTmtgG0AqfDW9eSCdEIsN?=
 =?us-ascii?Q?CX1B/YB1WCm755mt+7yNGQQpqGHD8/8h3djcKIsG2vzVuVOmH5lNjsrJBZKe?=
 =?us-ascii?Q?2AUpjmD62TrMeiFQqLZ06pqwV+mFvji0Hsi/utdJTayXu6QgVWGsU9dLHvVz?=
 =?us-ascii?Q?CIdnue4BNjAI1LjB1p5d6QaFN5v96ZlJb3HG488g57M2SSHbO9BObgi9HoCB?=
 =?us-ascii?Q?iXjCWfmQD6DiBD3qVqdQ4Vy3W2alAaj6H1Ga2MdBoyQtcAylI4XW2TitVIzU?=
 =?us-ascii?Q?INOpNGeqhLDvTyBK0+U56zZIlP1n/Ik7HSKVfF19NTqwONE49POXKKQ1ulLI?=
 =?us-ascii?Q?MO2YW0ls7f5NwHTf/QfR8NZp+xcgeoRlmpUX6kqYr6/pFPpPQDvvScwCej1/?=
 =?us-ascii?Q?1Tp/AimUDFNSjiJZJjmo61/zhMTncM/Uc/ZZt/IJyHFOeHgeZr8D8T7BX33w?=
 =?us-ascii?Q?yeNjOED43HmB/UmuKHH81QRcWgdeHMvHoXDrh1S+xdVfwnFKlZMSLKb8JEQC?=
 =?us-ascii?Q?EMefqpGHPGrC25VGtvX+dXw8P3rp5tqMQldu1oSzw+3C4fFHTXpotVX3TJyu?=
 =?us-ascii?Q?H3mkgoUXl3QX+8F7MAj9ozYLeCGBn1iIywsc8RTArf16Jz0GfWwsmyG6a0zh?=
 =?us-ascii?Q?FkyWARNc1y2U7DaTXijpLkwXHB53eH5ruwAS55E2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cfc5eb-cbdc-4ac1-7567-08dd50f49c18
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:27.8789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ3QELh6jZyod5bxmvijoqIywWrdI8i0KBwVm+z7nyOXQ7rmuW+/OWV+54TS7uxiwIeTmHjhO1mew0vDHP8Rdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-GUID: WRd8pl8y2CcjgXEDh_mkVUAWLrtZohUl
X-Authority-Analysis: v=2.4 cv=bfyRUPPB c=1 sm=1 tr=0 ts=67b5ef79 cx=c_pps
 a=FN31aPQdsEfnd7fT0GsFIA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=nsq3sfgFcGYXhcUyotgA:9 a=YF8NTHzWcJO_nPwQaAZU:22
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: WRd8pl8y2CcjgXEDh_mkVUAWLrtZohUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

Commonize some initialization code shared by the legacy and iommufd vfio
implementations (and later by vfio-user).

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c              | 19 +++++++++++++++++++
 hw/vfio/container.c           | 14 +-------------
 hw/vfio/iommufd.c             |  9 +--------
 include/hw/vfio/vfio-common.h |  2 ++
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index eefd735bc6..4434e0a0a2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1569,6 +1569,25 @@ retry:
     return info;
 }
 
+void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         VFIOGroup *group, struct vfio_device_info *info)
+{
+    vbasedev->group = group;
+
+    vbasedev->num_irqs = info->num_irqs;
+    vbasedev->num_regions = info->num_regions;
+    vbasedev->flags = info->flags;
+    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
+
+    vbasedev->bcontainer = bcontainer;
+    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
+    if (group) {
+        QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
+    }
+
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+}
+
 bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
                                       VFIODevice *vbasedev, AddressSpace *as,
                                       Error **errp)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 82987063e5..37a3befbc5 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -876,17 +876,11 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
     }
 
     vbasedev->fd = fd;
-    vbasedev->group = group;
-    QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
 
-    vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
-    vbasedev->flags = info->flags;
+    vfio_prepare_device(vbasedev, &group->container->bcontainer, group, info);
 
     trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
 
-    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
-
     return true;
 }
 
@@ -939,7 +933,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    VFIOContainerBase *bcontainer;
 
     if (groupid < 0) {
         return false;
@@ -968,11 +961,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         return false;
     }
 
-    bcontainer = &group->container->bcontainer;
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
-
     return true;
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e295f251c0..85c70eae37 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -604,14 +604,7 @@ found_container:
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
-    vbasedev->group = 0;
-    vbasedev->num_irqs = dev_info.num_irqs;
-    vbasedev->num_regions = dev_info.num_regions;
-    vbasedev->flags = dev_info.flags;
-    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    vfio_prepare_device(vbasedev, bcontainer, NULL, &dev_info);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c40f8de6bc..ae3ecbd9f6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -250,6 +250,8 @@ void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
+void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         VFIOGroup *group, struct vfio_device_info *info);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
-- 
2.34.1


