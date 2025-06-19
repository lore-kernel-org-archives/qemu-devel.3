Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F91DC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFOl-0005UP-Kf; Thu, 19 Jun 2025 09:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNq-0004Se-Us
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNn-0008H2-VA
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:50 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J3EV5u001584;
 Thu, 19 Jun 2025 06:32:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hMgoJgjOg7ssfmFRY5ufTDdstNzwMj4vOLAsc1Sx8
 QY=; b=EE0FvaOJRGWmscjEWVrBUN3C7JdCtlK1XIxyRshGZ86wiBP3EfsUeYTYE
 xe3zD+LcY/nvjkplPWZ6XBxbHnHFaCbhUAh0auf4f+tO72zCT3bwnNC3Se76VAQf
 7b11n9q/WNGneE2bJpzpng5T1EQSy98EifCw1LzdHH3cTb7LJO+Bk5W8U5MTij/c
 gZfusJO6lUALdlCSLemYU9/RkQq30OFkFngJp+w6DvzSULhVPPxN8NkAnK4DhUQK
 89/Uy5NSPyndbCKdWFUIygFRP2oC7mh2rk1m6pAjjclKK5KfJ7zjk+3Qin8d7IvH
 R5nd/jT8KjLYYOHRo2f76c4Ym5gzA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022092.outbound.protection.outlook.com [52.101.43.92])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4796mbkv13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mabBmBEud2xFOVQ9n6OB8IkXq2ZnbHT1p6bU9RgpiXB2o8RkzIcbdsZHG7DLYgdK7xQaAbKpKRJctCdYgDuoZZWdkiiqtp7pxXS3Dudj/EsDNLvAZNH8dz0pQpCF2cZtG9e2AiB8/hyRBFa7gku8jUigOVPcCS+TSjJS/VLCha4ImhDdr1bOCQO0AB/N8GhC9oJ3/54NbEtHlncyZedeINCMBszNOdn+6xR5YuX4YMRRsBgRYEZRFgt8oe/ifiJp4KVC9+qtvzofmfvCg2/E2iq5419HUMLgo6J4muiKGYh9g7mC/EUniT0dE4HjM4XTVybMhwcUStq6PQ6pCcK3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMgoJgjOg7ssfmFRY5ufTDdstNzwMj4vOLAsc1Sx8QY=;
 b=sGq4WOVGchB0jOpnDZ6wWqFwLFVnVCw4994iGsQ40P9tYuZE55FX761rz3OKyAd4Su/5CH5/RS5vEt/+OCqW6yYn3xPmkwiMsy2vklqKbgfeQCVfChNZbDDSiKYYUxuP+zPQv3wFBtOScXAYMaIJet7qMOryfB5B8cDH/Uwn0s9HrDSyYuMX8WdZAHj+vaun1b4bxkZnQXu8ihzsoUr6elwFEgQC+QH0YZbFCzP6wQRnhyqG5tDIa2x+kHoYS5BR5LdbGlLj0/4B2qhy+moPE++JTxuoS0IV+XvH3hFsffBIO6Q+suuIxuBF9h0zoPadcSkRkjFg0mFzGVsWmuuM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMgoJgjOg7ssfmFRY5ufTDdstNzwMj4vOLAsc1Sx8QY=;
 b=eFGoOEyXPWVzfz29O3lWry0bNWovCogNRsptfkRDH4vXEwdCWPejleZMgwlzE9Auv0AsxP4qsNQARsgM30lyjpifY6zkSs9mXphNruC/zVF+s96lQ1FouR5RMmMlqMKHJAWgZNPrxOgZXtZcysebAjn8Z4n+k7I+7N9zoRBUb842PS8Hkx3uWtkjAsuXb/8KpAdsfEV/j2ESdxKdqTutey2chCaGGQaSgVDvnLp+kHwv/8bqhJdfKkYH2JcNHxw5121gLUWuyCmOZsxEftwJH96Rdm9vcrRldXnxydfUNnwI4tI4KIOHjMWIdazrp7PyLHMf6SWfS4p/NO+e9ihkUw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8458.namprd02.prod.outlook.com (2603:10b6:303:156::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 13:32:43 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:42 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 18/19] docs: add vfio-user documentation
Date: Thu, 19 Jun 2025 06:31:52 -0700
Message-ID: <20250619133154.264786-19-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CO1PR02MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d7767a-9ef7-410f-da1a-08ddaf35c479
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TtGV3R1D85RVdr36npYxGE1MvlvxQkssUiCIJal5QeR1PeSQEhtgnmuTJMvf?=
 =?us-ascii?Q?JvKuBldRDQ7udoO6tVpoR2RHlZFCJVcbHrWDeeeE0YO4LPOKdSbQW1I/p/rm?=
 =?us-ascii?Q?fynOw00QxLwY4BAyoK0bjmRRK/AS4xv027GkxqM/w1k3yLuU7Tk8AU8StOv/?=
 =?us-ascii?Q?l7CFPfADAtkVRuSuvKPQiMJSPYYd/S5sqXmm/O50ADhryYqyGjEC/XPenfBG?=
 =?us-ascii?Q?b6ixZuQwazsvy4TfsP2crhMQ/qD5EvLAa0IK23x9K9ICBQLrgpCXbscc78hP?=
 =?us-ascii?Q?7DJ7AWKMApGrolJvAgE4bjIvqpbICz+vD8PMvaO/AzmhYZ5t3ZhSDdKoyNJn?=
 =?us-ascii?Q?u+X3IXOo3cY0/alZRpuK5vY9KOasmoLAKKWXU/WQW1nV37p5+clxMXa6F+aH?=
 =?us-ascii?Q?IEobeVt4mKmYECbGciewskFEKETFmidOlQZkCWETCuWzqKrtursAlolL3osJ?=
 =?us-ascii?Q?8EjSDUO0yesQtsmC/JO7L85qeDMn5jli5fIJ2s6KYEH3bl9GZgSiu289a2Fy?=
 =?us-ascii?Q?GoPSWW2bT4TqAHv08jWpfK3RPqcAWn33APoDYCziIJHNy3I8WrF3tlptic3k?=
 =?us-ascii?Q?UUDENFlvKZz9GUDRn7dvfbhVJWRkiRDsbhBFer7WaDtszlblw3u30xbDRGN6?=
 =?us-ascii?Q?Q1vn6588ses9f3PHk8lYjLLvcrEow5UDJ+kK9aaDFesUhzdCTAcbm/hZI4U5?=
 =?us-ascii?Q?c11+AouBL6asjx+7Nkp3wxGt2MeXVfrbQO6nI/iBV+SeeQxuB20D+fbVuOVz?=
 =?us-ascii?Q?QsVGuAJfT143eopOK+3GCKnLGklDTCmVPJnYBHj2UXx2/FKjnvp+bG0SuJ4c?=
 =?us-ascii?Q?rCTvHmaDzqlW+J8gTb1g5ONz33h1kPfa7cToNjcD7x2Fr682HbddGIGjZyOD?=
 =?us-ascii?Q?MVkFyR2nI5doSGA5l38fx16JmCC73nTRPKEK7+QOPJUon5+JCT7BrOjpNgMe?=
 =?us-ascii?Q?C8SdperW5QEJEHKd7GEDb9wd1AceqA9K2nT7SdnsVN56eY1RvVoJ0403TX4X?=
 =?us-ascii?Q?+a8abss9UvC5zSgO5UBF/HYA1CUNpiwEm3syizrMeaZuY8dOCy+w0au5mAgo?=
 =?us-ascii?Q?VgkQ1UnaD7lRNSt5/2NHqeHHmxa2wPOyunLR9uLEWYPRNDk/HI4UgrnnW37k?=
 =?us-ascii?Q?ZXra6+U/tkxgD4hVBjbwYIAC5Qp7TKK/AsFdvxI9Cm1D7lmLfmC4MhRcKTvp?=
 =?us-ascii?Q?dTv285Tlmi9xOm4tpnv+dd5EQ8hQ+lR6PyGC+HFdsijIlvu9++/+EJbUaXAk?=
 =?us-ascii?Q?1+iocscH8/GAMgH8T+ATMskjabeTgJE+apYuAD/sop8+DJaufljW8wciDC+1?=
 =?us-ascii?Q?3VzlS3P3FgMkPuRakKn1r8FP+NWq/Xsvhnulpo3pTCqNPbzzHLJG2VX8vF8W?=
 =?us-ascii?Q?gmEae7JJ2M+EC6iacFDvxtTzLaXoT8iHC2gJvKBJlDtSQfsXqti9VHIeu1gy?=
 =?us-ascii?Q?Lr8aLmCaGdg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3aG2KN/r58lNyw6rXYH3x2uB8OAJ48PZwx7Yr0Tc1BaROVt11RGXf6rvs7LY?=
 =?us-ascii?Q?IUHzQb+HaC4gJV2dRKlFo98g0ANedMSL78NKqMQYQVusw9RnSSOtu//fy3VG?=
 =?us-ascii?Q?TvXgajZ674w7dmDWPuZRccfw5L5SPcIMbmhqnVePl19PsTfRnnWmW+Zbv19Q?=
 =?us-ascii?Q?uuqnZ7gEVrdaBsJ925l4G/8Tp1P0596YfiegJJQ/yTrHmtH3Mps5oWJI8rW4?=
 =?us-ascii?Q?EUXagzdrxtxxhHqjiCH36u7Q17Euye+RI0OeB6ELxl6UluE3gDrUPoljNkPb?=
 =?us-ascii?Q?j59Ad1T4g8Lv9VG/luyev5KI0Vd1itGcaKS9dSfXQx2Tw8cAYeM5R05R6+j5?=
 =?us-ascii?Q?7lBdcl3BrVBuzfWP+JEN6T9m+6e6+koqJaJjKOTA5LjzrIGrQPVVVXw1qTO9?=
 =?us-ascii?Q?+kAt2lbt2o889d5dxNH2izxW8Y5iwUl8yNaT/LGcGMIPXDlwAjfW8DKeRsmb?=
 =?us-ascii?Q?eFHR5Uu89eEdnTWgcfbvouh7+HZt/2l6MQdZ8+eTwSqyupM/tTScogo6/Ijw?=
 =?us-ascii?Q?2PnNhqIVxlv/4+OkIzliomlx2RURAVnBRX32RFIBtPEOhIp6tV+tAZMyCf3t?=
 =?us-ascii?Q?iekpLMBAPskIpnu4SFcmv2xnjhvFfZ2TjJf38ZPML4RmoAHTsS1tk86nArQH?=
 =?us-ascii?Q?EwUVp0eT65bJ4CZXuxW7p68oZ17iu1F4jXfwC2VI2Qkggf6d5W3LywDOo+In?=
 =?us-ascii?Q?HhCABr0ciOf7jenbSNeT6BTQihd5cExwDv5Ii40AytjnJB3vd1u2fR1xn3sp?=
 =?us-ascii?Q?9NiLkNvDnc4S5z7oeOGkqLr7f2NWU3SR+1RI+8dECggw0JaB33+euSR/4/A2?=
 =?us-ascii?Q?OoKs0d9H0/J6FQxR9lvIXtqHdoP2EPs6JTxPPV3VNVz3YUEcuy27u7CsdNFL?=
 =?us-ascii?Q?kd/kOxTbmWnFeMQYOroEV2848SGCnaEdCTgt5jSajGTpaMLTVRYc/OZtsMvb?=
 =?us-ascii?Q?/SRpinh7qb8jon01VkOI7HKnI3EXQ+5i6QoShkY4pb3LU8VcSUPFf2mnBQJe?=
 =?us-ascii?Q?0VgmBVL1k9CRn0s1mleBO7+Xdbg3jl576p5ZuA0ISo5c2o430/watcUCkvm3?=
 =?us-ascii?Q?6K0YJKHFHBJQr2vHGGtbRccqIMSDpIHDY1SWXFVaZ80/wJWo9wnkPA3lX+Ke?=
 =?us-ascii?Q?+Bd4FPeL0lysZT9ZOmValO9Lv3SurbvUunxSoXxF7XQMMnPKhpJktNa3oUTY?=
 =?us-ascii?Q?+0RVq+Qr1LBGqM7xtulnOR3VMMPnuchnE3H+JmUJorlEvmh2f6n6U9g8PuEr?=
 =?us-ascii?Q?AVvWoTfXbgjA5GJL+FGXN/K8+AB/ag7BqoVHRt9cd3FnG2H/Lr3S2KQedZhd?=
 =?us-ascii?Q?lW6opr4YQetLyZwAeBQHRA8Zi9WfmWmGe4j3V8SoMYOyseZ8sU+ly8R01mZB?=
 =?us-ascii?Q?fmd9wzwE+3A/gli+nC2xf7vGCKstMjpRRu1vmACPoZ09Ieb1LSllfAp6NXM5?=
 =?us-ascii?Q?zt2Im8swQ0h5G4H10ODs7i9YA+9Kr6dSjCBE8Z2QD8aVkLxMFpNTyC8/f30s?=
 =?us-ascii?Q?FpsO+sCnNhDQiHbw+0F+lVrlIIo+asgr5rdYO5ev51cLE5Wqq1I1YptcJer2?=
 =?us-ascii?Q?4QhjNPWRZVwT7AMGTqkw+2NBzVrVhKZq/7S50WJv?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d7767a-9ef7-410f-da1a-08ddaf35c479
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:42.5205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFHYrixLeP3kYbXP81BCkfTDfhVhBaPJC6FXIjzTOzrcgBmfdoKNVp2KPtTP1QurgdCEF6RnpH7jfEnHqispAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8458
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMyBTYWx0ZWRfX3zhSHi9X32L/
 n5wtnffwyIuKv0zCA3oMn+ohz0uFWDWYYnBUNS6kyxYFv4TCAYFpTjg69hPhRWxxoPCMmSGi0An
 usaYwIoEnVcuwokulbfoQDVcRlaeEJ7hG71mJrmhAiTVQYkq9ruq881MLDb6rHcUsfjG8dDaPgj
 5HWv6xPQ1aFvbNHoJGLu4nFuxRI86n+/EO8gvY/wMKDVe6quigYm7xN1EQbcpsdoaWi4K2axTnh
 RsaHn+UOOGZTOYgbCDvBnU1eC7xCD8lwYlbw3Etme2e5ZH3DjZOugz6cwojlv5dkzEjTrAqvFMm
 SqQzDDyUsCWfGjc6tqPbFwZ0zMbjIgLqp7pC9cB63Hlf5iwnWSaE2JSxPTQwM2Rq7/jszgQVdBN
 bJ4Ujph/AJjk+LxV/BpzCbYJXSnMGzJgAK8QelaxjG/kZLKBhnt+O5jvAY2fI/m0xwowF5Zi
X-Proofpoint-GUID: W8b5LNX2zWirr8XFNYl_OzZXr18VN4PR
X-Proofpoint-ORIG-GUID: W8b5LNX2zWirr8XFNYl_OzZXr18VN4PR
X-Authority-Analysis: v=2.4 cv=cJXgskeN c=1 sm=1 tr=0 ts=6854117e cx=c_pps
 a=VT9wVgPwsxARPCPuKYV0eQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=LOSiUy74ef7l4vre4JwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 0000000000..5d8965d4ef
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
+-device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
+
+See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
+information.
-- 
2.43.0


