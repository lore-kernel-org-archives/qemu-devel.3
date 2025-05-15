Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E311C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFano-0003SP-3V; Thu, 15 May 2025 11:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFam9-0007TZ-40
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalz-0006S4-8h
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:36 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7nlpw026476;
 Thu, 15 May 2025 08:45:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EP6LNxi0OkTDKZVHQpL/4sevJ46U+iDmQuqSFoRqc
 iw=; b=R2yXdYIwz6au3zNyFfHKNpmKSCt21KqamOvaWTpjsXIIVw4gSPT5zUmss
 fKJ/I3c88dT9f0mFx4TjLqXgW1z7OW4Sd9Dk0QbqINnWPgW1A+wSBG8SMz79oBlC
 DVi9MDLs5OVRS87k0s/EdCcnQzxvU4Fqsn/zyukb48cWiLFkPhOdHZiIGqL2uuIZ
 YaCJGNrLvDykXsb0BHIe20/oJr0UchOXPxf98YqeA+vgWnicX36N0Zuy4yAAH8co
 O1odE2hlBNvro21+dqhq6qFdqlkLLunuiGajNUA2zd0oWckM/bRLWI5WYWMLBfjz
 4KK7ufeQNhX+Q5m4y+x1lv9ACjv3Q==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010004.outbound.protection.outlook.com [40.93.11.4])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mjmtvrfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbdva2adC/Fe9qyxFDT7xIxC5UgDDgCT+KrwFCJpLKUEQ8IIZeNec+mLsPVk+/WPgqUdR8LLA0COEJyU/5aYpFTJ9OOYCLarcHJ+B3pNi2WherjA96Nqo1eFibKxE21LTPMQZKOUpaK2VnYFMRuMWjyWcHWJ6HLFDs1RbTj5g7g10u9QMfgcmjfSzPkkuc36odC+bH5aB6iesFkdGnqYw5GrnsSE6bA0EL1foj03UWGS11oc7Olxl2QWibVyet5Lulq8QPGoBzfw05UM73xiv/BPO/UD6tV05fMonMYOleoel4GHoWWmC/88+35QhJ5Aa1AukJf3VgbGNsOQFFEPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP6LNxi0OkTDKZVHQpL/4sevJ46U+iDmQuqSFoRqciw=;
 b=Ie2Q8uCvodVLXDBkvREGflZxPG4RMvhHJF55KbPOiHvWNP5Vz3qTIEL1vm6YCUpIkZxoqlaCQBx6uwLAea3NkJcGqBeH4GgxiFS+6Oqrsv++WfJGdKpE6czJ4E+b5MzRxV+LGkymLivSlbenkLp/Gy2ZoMZS+e5elqq10vmz3FdcL0qxpRkBT9iZ4as90MQsWr2ffTGPntz64Vha7y6T6nmUfybPt7e1gsdbE2cJpuQyMAfmoqp8odM5XEkRDhlDxWahhqsi5h4ulYciiekvbyp8f1/XGzSFLpxkiHBoumSWkv7JVnnugP25PosQcUfydXwfvZHzgzEVG9OtI2r2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP6LNxi0OkTDKZVHQpL/4sevJ46U+iDmQuqSFoRqciw=;
 b=othVWCMEGmcL7A3GYNvyUydPU1uidF31hRzfrDNB9pTCXxOevBhBkElky2grY+Xw2WHfLCnFDwyadrQct6Ius4vhzW758Umj9ofuLETj0guMmvlKKEsIZC90WoVykDzEDGMeP9Z11uInMLhkToGJwfChdDGkMsowtZ0FwszKxkuS4kIvUaLy1Y0GQ/+E5dXw+6IB05p50/9Fcc73mx2aUWUH3gLfHj1iH5KHNtpLgxxTb21YF9f16Z2hYi75FJREBSKFBxvEalAJrU7VbM+0zOBG5aD7splBrLQrGA51P9KXKW+2lWksdAJkCrp13L8WHxdmPRvOzsxfrhVbXh4kdA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:45:17 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:17 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 23/27] vfio-user: implement VFIO_USER_DMA_READ/WRITE
Date: Thu, 15 May 2025 16:44:08 +0100
Message-ID: <20250515154413.210315-24-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e68cadc-eceb-46c3-5b2e-08dd93c77db3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dgp5RobE/C5S/E78fArUHiUG7spAWpiWbnxZJljqdnMySi+VYGcGkLeWcJP4?=
 =?us-ascii?Q?cLSlulGarJBUwNMVWnpI/QOzLq8LMq2jVUgr25djKxNOg0DpC8JgWvkKOTTv?=
 =?us-ascii?Q?II/PaVwLx9JQ4h02rCZ+1VSEQnboFSg2aQuPUr3S7TOyEpQ1R/8iEhocj9uQ?=
 =?us-ascii?Q?EFNWo8bdeDF5gjSyMpw34vfI24yx+LjoLSna8sY9FGjmMXnpEV5/ElbP2sOD?=
 =?us-ascii?Q?SHdrjaFPd3H8ZlS8+vVxNr8eBKlRi1Q+fB9Cgwl0LlgsJaxEmH1vGUqS3qE2?=
 =?us-ascii?Q?t734b6V/sl0b4L8pDeAGK7dPv7DIRCHnLxbkyCvo2vooqQuiHj8eCHzWQ02z?=
 =?us-ascii?Q?kprQvX0VRUkR1dKQrej3j7cDyYYGncmcuKKD7iPP6RG3KM33dGE3pbzfyt9E?=
 =?us-ascii?Q?F8ypah8vHY5LofywNPVw2TDfzVKpON93uq0K9+cxkSiIrkOmkxyZsowStFqL?=
 =?us-ascii?Q?f0tOLeS/rS7t2fwF4Cdxo4sbTmiVZuuUrfG0kT6KU62W7t9WV8yxqECCmkz8?=
 =?us-ascii?Q?y0INvGAkIyKzK7YcJDRZ7parlejNgxELTWyoLFzK37572a6uUwyE/78OO9ax?=
 =?us-ascii?Q?gHRSRRXgIUoQducrn6cv7pw+gr9cc47yx2Xx2VdRwzqKPt4y/rGwdF4MX5e8?=
 =?us-ascii?Q?MLONOx1uq3dLEhArP7sNXNDaQ+scaXnuyWIJUsq8H7bhkwBT4SUayMsZkK8U?=
 =?us-ascii?Q?/X9MKfH7mCCDhHwBZs0kYhankD8YWyEu4Sf/pIPmlyz75ozBPl8VWmBHEslS?=
 =?us-ascii?Q?sJhSYYsFDBupaPQ3QIHhue47i8Rdjp00WUV1dv0AGMo+ZkjAF7KXxEOmQ4Zy?=
 =?us-ascii?Q?rTn6d8T/4iMR1iBwIShpQpYLfae8UdF7dXP2VHxKF3leED8dUWfTMhY62gxR?=
 =?us-ascii?Q?PaHXeVwflYDZmQ3xxZ2nN6t/7GHhs4eaA26u04FiMNZucYtr6h/UxNn1Mj4m?=
 =?us-ascii?Q?7m/jRWwJPglJxjW58u6y4HY8NVdHQqE03Bi6LGvAW0FEe0uabuyx8JcG0EmP?=
 =?us-ascii?Q?dAcDIUAyBKXNR3kEdHE7qt7+RsY7zcRCZtw8eYiJznYl9Sg6yEuLMyjg9Qxr?=
 =?us-ascii?Q?PqtElL9FRxUo1MEV0EPgknzir1vzC15UXMWetibfvRgVGpz3fwz1b9NY70lf?=
 =?us-ascii?Q?p/MHgTmmOE9USPAVPQm3Qs5EQJEK4DvqyeTBHlpjrvPXklH1doD+gNxRorzL?=
 =?us-ascii?Q?Z2QvE82ppPzODUiE6NqnIwZiunQwn0b1iuaMui8RddRjOXgt1J9hWObtuABj?=
 =?us-ascii?Q?ufKW2otEJryIw5aOSfJsmWbHYixzlbx6SiSRfLodiegznau56Z2orX2kfxo/?=
 =?us-ascii?Q?TtPly7rsUaqmRSV805yNAU60BrW+VuEvRZCtrflxncxnmJHEXbxgyH5n2rmC?=
 =?us-ascii?Q?bsEwdX1dLkXhSAoKra35SSbSYl8sR4hM17TakpXdXo1Ui6IhBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?48yCuf8eLefk0y9iWEtGIsEnpD1qMBglW2Gu0J8Nqdpyah0RQBpAPiASoliu?=
 =?us-ascii?Q?Mj4nkkow+LeQDh2r0hyoGb7DwGnL8xtBd7pQuxq9DUqI6udz5uL/oA2Jldpb?=
 =?us-ascii?Q?fOMGY8e7xN9X8nTkUluI28kNNfzKXt9NpWbcok6V1QQYvDtR6ABx1zMiwnYQ?=
 =?us-ascii?Q?qX4HAeDVRCqERsDy5mko16l5PVl1/UecqjWZtUDS5qMANROSmWqQelDo/76P?=
 =?us-ascii?Q?Ht8besHF30rgs+s7Cb3FWCaw4xwLIO8IidO4Xfohz5Z+xfFAAwsgdcD524TJ?=
 =?us-ascii?Q?JgYXa2r25sjaHv/Wei2notKgrXpNBO5zqhW6/4lU/kiMVVoHUwRyWQDK77cJ?=
 =?us-ascii?Q?lkjbeBmhtnKNCbGmf5HwGqMQy/bg3e0Nh7/GIYGZGvEGTe8fm4gxXo0URUMB?=
 =?us-ascii?Q?O4G2wWgPQJlvfJmLhbKa69EAU6O26hE3SI6fS23+87E/XWg8nzs48fZpuUXb?=
 =?us-ascii?Q?3mzxTmuCIpU1UqCqYi3JL51Qsf0h3ylqKOxrLC2o90iIUZc302EnnEtvUDnG?=
 =?us-ascii?Q?WmFLo5iE/wL+Q9qmGtumbbz/9fp56ZnBjqW4W4UrCYwTntP31AegCiPZJH7y?=
 =?us-ascii?Q?dHXK3eGoDvEU6FswFAjvav5xCU6KJbaQY1h3AoERSAqe0WkyM8vlGHS+Fvms?=
 =?us-ascii?Q?dXSA3d4RHnsoiFtP0KuQiM4dfeyxmmyaLly529HpwnlMaPZGsU1n9epMBbhA?=
 =?us-ascii?Q?m9hCjr/keVMgDA81VAd0hwF0n9Ek/DE9K+peYSYVO89wp4WAZ7xc4Qs0MHvA?=
 =?us-ascii?Q?XsDiM28n5vugrr65V0DycZjRs1cNEMbPnr+X0H+ujJtUm4NH/pHSByOSpae5?=
 =?us-ascii?Q?ukbGGbHNna4/yVrOdPmwSVGhTcPQ7v45Lh+22LrDXOlmoPyEgDAon/uhMM7m?=
 =?us-ascii?Q?dzyXbwP1e1JmwZL1yHYGbh+Up7PViKZDQqUhfkFtgwkvkivAgxm+T1VCKjyE?=
 =?us-ascii?Q?G+SrmnyfxeRE4pgiam6SI1HBd5vlBGQ1lwFHFqr384mIsQbd8WZW01Sh62s/?=
 =?us-ascii?Q?OVZ30bRA/WSxDDGbYHzgt5lbAOMWW5dS3ZBFpCQGQjFF2Oh2QRL0dhnIFxFW?=
 =?us-ascii?Q?2semA+3ldEW2k5f+e9waFbys3jBEqRIIVef8ZTWKS8ZLLxc4xpEsgZ/VXHhh?=
 =?us-ascii?Q?rZ1EFN12QvnxVm9B3WerHLkOLHhw0AfEcSLsF2yOU/GHAfDiN/A24jBa3yDC?=
 =?us-ascii?Q?NckR7XUJzM5ORJFPerVENS7nnDfq8EQNLRpp3v0+VOsdSggffpceBll2l9Of?=
 =?us-ascii?Q?OI1FcN2Gck5JT5LZKOnU1ejmVe56DEElBpQkJN4nizjpilF/VcOGToEkwd2b?=
 =?us-ascii?Q?zDo2YR+MHRcOLdZmIHKNFuR+I0EJj2EQSBbXe0/JSLU5NOjVRtm6M+UxRsst?=
 =?us-ascii?Q?AB1frTYfinJlYBA9Spgnx3wxpgBoBsz0eUPdW4JZGsFbuKWo5GSA5o0nz3Ti?=
 =?us-ascii?Q?M5MThEe34fLxmTliiFLV2lmIvIGslo6xKljQnLiF730T99Sx1D6eHnCtTLY8?=
 =?us-ascii?Q?7zN0KEE7jMNDZPJNvcniKCAH88cnOQOC/m8njB6KTzzkZynxaBfaHMdPU8ki?=
 =?us-ascii?Q?3OBEs9l1RGtYJcNRMMSIfa7hMALEFxhf9PPf+5Ng?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e68cadc-eceb-46c3-5b2e-08dd93c77db3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:17.4756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYZFGYM0VUjI6qZdjzsBh9JyXZnXS0Yn+PgQLOL2Zd1pEvkNxDnELUYVSRLUn2G3Khudnr/PdKyfDPfe3yGFJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Authority-Analysis: v=2.4 cv=TauWtQQh c=1 sm=1 tr=0 ts=68260c10 cx=c_pps
 a=uYdjBAypVXkA+ZVpDPXefQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=qTvU7B1ccVJYr7cy3AMA:9
X-Proofpoint-ORIG-GUID: HQs8iF1CMexSwQpCC9EatLxtxb_06Z17
X-Proofpoint-GUID: HQs8iF1CMexSwQpCC9EatLxtxb_06Z17
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX8nMmb65rhEJD
 q3VlvLQ318BiFZcH6GTNP3lC7Y0uqj0Uqo+nlaW+b6HdUSYgDVgBapb0UGzuJ/P3DQsCxLPNAcW
 rnHY6Hm97uJ8RJOw5eofLaqLjbXYT9JFUuWKNJlGcWt/e1GdhyExie09sfIYfMIEkWOx/GsL0VD
 yzQ3kfdR512iAzVhuFZqEZcCE0EkpcBym0lq0pVOnPeaa55BT/aXVlrbKOxOmWMJOPRJtrb05Zq
 gH+RHlGG5Cq8KWrMPHQ2DPhTw67xFvR6k8nU5bHNp0/S6FpoeN+Y/Yh23h8wAp6hD7a1ArRlhHI
 kDn8s4nulWgtXJTFs66gOkWTz9T9qI3c1hw4vPUEprNoNLITjfQpLLGSNMP0j8DMbZYwP+fSZOu
 tM2cWV511/jw+8zakWlJAWaKrOB9cpkhvbEmNhTyhRQ1iC4WpunjjYyAFRNWG87F89kvE6Xa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Unlike most other messages, this is a server->client message, for when a
server wants to do "DMA"; this is slow, so normally the server has
memory directly mapped instead.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h |  13 ++++-
 hw/vfio-user/proxy.h    |   3 ++
 hw/vfio-user/pci.c      | 111 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/proxy.c    |  84 ++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 4fa6d03b3f..8f589faef4 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -203,7 +203,18 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
-/*imported from struct vfio_bitmap */
+/*
+ * VFIO_USER_DMA_READ
+ * VFIO_USER_DMA_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t count;
+    char data[];
+} VFIOUserDMARW;
+
+/* imported from struct vfio_bitmap */
 typedef struct {
     uint64_t pgsize;
     uint64_t size;
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 01fed3f17d..8f2d529846 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -104,6 +104,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 VFIOUserFDs *vfio_user_getfds(int numfds);
+void vfio_user_putfds(VFIOUserMsg *msg);
 
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
@@ -112,5 +113,7 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
 void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize);
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 55cc811d3c..a55a0a0972 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -11,6 +11,7 @@
 
 #include <sys/ioctl.h>
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
@@ -82,6 +83,95 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
     vdev->msix->pba_region = NULL;
 }
 
+static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    VFIOUserDMARW *res;
+    MemTxResult r;
+    size_t size;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    if (msg->count > proxy->max_xfer_size) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    /* switch to our own message buffer */
+    size = msg->count + sizeof(VFIOUserDMARW);
+    res = g_malloc0(size);
+    memcpy(res, msg, sizeof(*res));
+    g_free(msg);
+
+    r = pci_dma_read(pdev, res->offset, &res->data, res->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if (res->hdr.flags & VFIO_USER_NO_REPLY) {
+            g_free(res);
+            return;
+        }
+        vfio_user_send_reply(proxy, &res->hdr, size);
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_read unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &res->hdr, EINVAL);
+    }
+}
+
+static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    MemTxResult r;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    /* make sure transfer count isn't larger than the message data */
+    if (msg->count > msg->hdr.size - sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    r = pci_dma_write(pdev, msg->offset, &msg->data, msg->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if ((msg->hdr.flags & VFIO_USER_NO_REPLY) == 0) {
+            vfio_user_send_reply(proxy, &msg->hdr, sizeof(msg->hdr));
+        } else {
+            g_free(msg);
+        }
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_write unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &msg->hdr, EINVAL);
+    }
+}
+
 /*
  * Incoming request message callback.
  *
@@ -89,7 +179,28 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
  */
 static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
 {
+    VFIOPCIDevice *vdev = opaque;
+    VFIOUserHdr *hdr = msg->hdr;
+
+    /* no incoming PCI requests pass FDs */
+    if (msg->fds != NULL) {
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, EINVAL);
+        vfio_user_putfds(msg);
+        return;
+    }
 
+    switch (hdr->command) {
+    case VFIO_USER_DMA_READ:
+        vfio_user_dma_read(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    case VFIO_USER_DMA_WRITE:
+        vfio_user_dma_write(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    default:
+        error_printf("vfio_user_pci_process_req unknown cmd %d\n",
+                     hdr->command);
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, ENOSYS);
+    }
 }
 
 /*
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 6d1446c38b..0935b72e9f 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -362,6 +362,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy)
         *msg->hdr = hdr;
         data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
+            error_setg(&local_err, "vfio_user_recv request larger than max");
+            goto err;
+        }
         buf = g_malloc0(hdr.size);
         memcpy(buf, &hdr, sizeof(hdr));
         data = buf + sizeof(hdr);
@@ -676,6 +680,33 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * async send - msg can be queued, but will be freed when sent
+ */
+static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                 VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (!(hdr->flags & (VFIO_USER_NO_REPLY | VFIO_USER_REPLY))) {
+        error_printf("vfio_user_send_async on sync message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
 void vfio_user_wait_reqs(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *msg;
@@ -720,6 +751,59 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * Reply to an incoming request.
+ */
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size)
+{
+
+    if (size < sizeof(VFIOUserHdr)) {
+        error_printf("vfio_user_send_reply - size too small\n");
+        g_free(hdr);
+        return;
+    }
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->size = size;
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Send an error reply to an incoming request.
+ */
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error)
+{
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = error;
+    hdr->size = sizeof(*hdr);
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Close FDs erroneously received in an incoming request.
+ */
+void vfio_user_putfds(VFIOUserMsg *msg)
+{
+    VFIOUserFDs *fds = msg->fds;
+    int i;
+
+    for (i = 0; i < fds->recv_fds; i++) {
+        close(fds->fds[i]);
+    }
+    g_free(fds);
+    msg->fds = NULL;
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-- 
2.43.0


