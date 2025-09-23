Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD96DCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Vs-0003PM-7J; Tue, 23 Sep 2025 09:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13VB-0000c5-8F; Tue, 23 Sep 2025 09:56:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13V8-0004OA-M2; Tue, 23 Sep 2025 09:56:16 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N70npi4104692; Tue, 23 Sep 2025 06:55:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wxazHk60G6Jn850JDHwAL5yhGfVSFG3RF9u5O++6+
 0Y=; b=BJyubxcxIhj0ZW/eo6TsPsHqXnUWNhj8vE6ky/RU1CKvJeu3E6LVKCYd5
 ddAR82R5weXjxKHGWBkTmm3HjzUmQ68crwhD+u983eSrmKsI7qxmVCrViM5Sz2lL
 6qlSRT4Kp2n/a/uBFqYt6AQF3pVdjdIlrR/MaSNfjIqg+5/wHNIDmBT3FcMY0Awd
 t6CSd7lTQXVtl9/wyk76IwMJwUZS4hF378A2wtePRIZLkJ4cj9fKQ3+pyADd3SuN
 tkutjPhVo4mo9BFkZIftFOKhA6m2Fua6lBNtVqelnsWSuStJiLZ4a1Hqh5QCWJpp
 gQA+9/HUZsnw99TkyNwEViumHbMlQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023133.outbound.protection.outlook.com
 [40.93.196.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49bb1fa8bh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pofD3RzQGJ4eWna339bnDeF2bGsz5bu4JsUQBPKZehyb5bCg6UhfXpLIj1ecwYfFnTTzPZZVN4n+NodS/BQ7+RJd4bL8+YfdayXJIO5YF0FA79Za6qFGEu70FH8b4sMUwXWf4xZ3a9tWKtm+z2bJIScLa0+2/a2O+K4eRxk60eUHapun95z7AQ0HtfFtHQElP9s3zpeUSzdcWMowtBRzE9VgmxBke1zJaAG339F5CV+IwwRJM3Lgg7BYDtWaW72FLyNSJ5a0Oy61/IU6gQSGplb4X1C1le/YEvOulw98hcumZO/XnCde+dWePqkOPJaZEbyiQMDCu7elPMdU5wRKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxazHk60G6Jn850JDHwAL5yhGfVSFG3RF9u5O++6+0Y=;
 b=YKygHmmCtVQnqBFGPw2bevx7NtHBjd0QWdWAMb4usLnmmHOa29T9AGefG0qiekv3WhNASf3XrrBrhqr/l9ngW7tFBBamGT6WPcaCYyeq1sfgNV5BgpL47pG1i2r14o0ulw4VxypU+VQrtT95DPncehlATw7OAEFb2xNd2Xm5Ee4fy2Q05aQDCE6RvnJ05SItUOu4Zx1fV2lNKEb4Pl7m1wdpp2OETiogY8hhkxedxEwc+rXNy5/le2uPEpbyd+JxLG4AzvLpMNaIR7bWEttfR7SDpZsELP70lTh+wDQ32zCQT8MYseNL8q+Pgnxn7PUJ8NnXLQ7I/OFAmtGUwmdOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxazHk60G6Jn850JDHwAL5yhGfVSFG3RF9u5O++6+0Y=;
 b=x3L7I1P2oGdO88mSGrjVTLIDRVTlv+YF8qmyY76webDGTKjyYggAKDVVgJDS8lhST+qT+mbrEH57vjz+NFrTz26RBhtCEFVmniP1cjquNzgnmiAYhIqubmjNawjFIVVb0EkAH6/cltSBK18AmtRi45x7F7dyyIk9nzJ3Dl1cqlrGudmkzUV9J+FX1Xm8CZNs+ppvipBhSXKeXjKJCQ16RzR+xCh3wLGxhslXRx00GqSKzBQ0oB/jBMmRh5yp+soqkIU3naPnx2hrpSbyR0hZYO7Dc6P65QP4ugNX+hi5dlCtVObBMJckG1X8zdm7kE2r83DAs9c1qXc0LlON4lku0Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:55:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:55:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 26/27] vfio-user/pci.c: rename vfio_user_instance_finalize()
 to vfio_user_pci_finalize()
Date: Tue, 23 Sep 2025 14:53:32 +0100
Message-ID: <20250923135352.1157250-27-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc3d681-aecb-4c47-ec36-08ddfaa8e054
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3t00jdQlgtiZ03padRn49ais+hyqhI0AARmsXtPq/XJXY2CIjLLi/PUYGCHv?=
 =?us-ascii?Q?c+LMzny6FRFkevLLaGAvlhHIcg5rVDXecvaUgn2g5ab2jP2lG0F96YO3BrwB?=
 =?us-ascii?Q?lu+KMSVHnbC98XC/m++19jaeDC8Xemd5rB6LCHtEBUsZNQLHllbuOMzuHRjX?=
 =?us-ascii?Q?YApFpBFOvBduNH1XTLPu/x3xfRU5tfYYTTq3lMTKlF/pzZA+HhxFbrbIGh05?=
 =?us-ascii?Q?4Zq6pucVU1ePqOzqRv52QeOL52+bmqhBjsQE+ERBpTRMp6P12cxyfzLY9X+9?=
 =?us-ascii?Q?vJcGQREgl7zcQ6QOCMyOOUqFVP/OzXSMINvjdJe6UUOPOH7jQd/rP0Stq6jj?=
 =?us-ascii?Q?238HwK8LJ2fi/NYRRXcG9ZOZSzOYICL7Cyt0VYi9XsCuN1OWJ5Xe4PW8y3gH?=
 =?us-ascii?Q?VI4d9xDH5KK1reppOklhU7bIjCWe/xsKRINPhcdSb6zWXnrRXEcabsS09BI+?=
 =?us-ascii?Q?71Atw2iFH9en20P+eVIt3FxWlU75xVWvyhgsADi23L3bWOMfh6gYgdRmdB8u?=
 =?us-ascii?Q?RD41eoadTlIJDCesdElO58ieCmbBU3v9q/Ft+zTfhVKFwgvczSWt0cc4fa6/?=
 =?us-ascii?Q?2cwl329FEoPWTxAEnnnuAlriE4YPpfT+7fFoqM1G5rkNq16CjIasr2nxipCb?=
 =?us-ascii?Q?YBQMLg5o5l1mdOZKNHC4MGOipdudVUlvjBRpnosgqCxXZ0BZW92zNdEfD206?=
 =?us-ascii?Q?uXEAldr1V9d96fVUZ1QLDDACIphiwWqDZq40Ham+/jordZCe1jmJ1HmcqRMU?=
 =?us-ascii?Q?OeN07IqNl7693EvjxxTFgrFBuW2ceUsOmsvYRS0a6C+5c3qEI7QoHiJtHrof?=
 =?us-ascii?Q?eoiI0mAUJqeoXUykKU+GjecRiYB3tPbTZ0imz0XvwaktSCUXeX3j8N2njDJr?=
 =?us-ascii?Q?c1uxGSVky2mtYaB0KTuu27CiVcouPcK5i2KizbfgydubKeCv08hnu/aUAiji?=
 =?us-ascii?Q?tyvQuLILNE1qxJcjUY4CQWCbBqWaF/NbQDV2IcrcA2l72Pq3qNE+FIsQQOLM?=
 =?us-ascii?Q?zasMeGJiNLwP4uy1JG9Rvcwyp6CHwm63zbiQrEeba+SaTWbVyl/8n3WCbdJw?=
 =?us-ascii?Q?lZcdOicoZqFVV31ch7WnX/ycBv51rnelOqy0KCGuqEYE3HvV0IczN952KxGX?=
 =?us-ascii?Q?t0RP8Fj2LCbyRa4OyViiy90Y5odUkwmP/TnoAl7cYMOGrq0cBfQxfPhaURmH?=
 =?us-ascii?Q?EraCB0wVHypmHddEmddLacMYtA9ZiPvRQRXNcEQo0gnP7v8J1oQmlIRYGJip?=
 =?us-ascii?Q?TL5g4kzkydiOZObfYvxPlnFBfPB0N/ZKgbRTYUzjz6GskkyKYeG816fmHgr7?=
 =?us-ascii?Q?oqmhiPC+pzOM/aE/FyCrxzHRwwBvOeVgCu41k94+J8F0OmFnB9wCIhh+Vm/4?=
 =?us-ascii?Q?PbNTEy+q82tU/mXobYrjB2Rc7L4W9URWPC1TBRMNsg5QRs0geh7Yc4/nZf54?=
 =?us-ascii?Q?tpRC3z1wszBk86aVEIf1DlrjPur/yol9ripmBzr7inNPZi75R1LR3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+QSTKakbfiNq4UzsUk5jDAAWivy3bwzRLrQZGUciLWIHT0GGHbkYAOSXs75?=
 =?us-ascii?Q?D1XvaDR3PiRunrOd5TlbO57rSOVMismMVePRpdFmB8dCQRzjzu2Jk8pbwTOz?=
 =?us-ascii?Q?h4SGk4rZl1PWw0BEftS9VUegTY9a4ZWFCRGl/26yZp2/9T+6I8bRDen/fgrb?=
 =?us-ascii?Q?rA/OAs+n6xcb6VDSFyvsryJkqcFw8F3PzvPhcnMzYM2yzjetM7lu7MNWQeyB?=
 =?us-ascii?Q?tWYX7cZ/sdPnbEktubQmnZsTpdaQrroVFfdaR5kPY2Y4vPwFoEHMVMA3Y+Hk?=
 =?us-ascii?Q?YWCR1TsDgu50yv2b97iaMCuT0dXsOuBKT1bw15wNoUzEe/ZQYutUCwl7ZpAj?=
 =?us-ascii?Q?PsMjJ9U2cVm5gCQD9YvhopVuKf1/1DUqBhCoMtbvhpOLvqc4aeYS0M7NSdVz?=
 =?us-ascii?Q?0AR/2oBgx4RLPQBjpt9g6RGS4XBycDTBzThyn15jQoNGBhtt/4KS+l37zq7q?=
 =?us-ascii?Q?UiOT17AjYMQhUtg+QzmfDYdsMg0DqmjFbMuRI0qoFMiGvJu6srW7OFXUmpGt?=
 =?us-ascii?Q?KVz1o8XCcL+5KaeTKG4lC9JXtuSADqKXDn30RoqkrEUqJF4nQe50/sYChOlU?=
 =?us-ascii?Q?nHWmY0u80IQL/CII65UqLOevVveQeIcfqv0aq/hb5Wauk//VxoOm7GmeNjtm?=
 =?us-ascii?Q?AsUGOfOKFazWrFBIA1VKa6Z6uvHVip24MIfxX92k5MV2LtTMyWYRkDu+BdJc?=
 =?us-ascii?Q?VJ3DxIC36n8Q8dwJwqojJC7vaC4LcIH3JHNO0LHo5aYYjl9UbsNaPFb2dR67?=
 =?us-ascii?Q?p94G8G4nqilI0ANhl5EaceJBJRg/ZOjSmHTRjWXf00PKO8XUbwZRWwak9iL7?=
 =?us-ascii?Q?CucfRSwi9HWLLK8nTHOcJFRMj2b5u6ek9v/CJv83oMLsMIUvZ8yg9Pz05yVK?=
 =?us-ascii?Q?yzkBIfAA6SsEYRh5D2XPBm/L//M5dpa7qsN/O1fA241KeR+7EisQzu+UsL55?=
 =?us-ascii?Q?89qt8Vp8qVubljEXzgOEGbtj3q2Tt8nkGrLxzAtCmJQ87GPy2xh/4+WhuWsa?=
 =?us-ascii?Q?pemH6pS3u1BgAmTvwKl2zzg3CRH/3o/XSQnxqdZS9tpVzIzbFqoQTi7/GecU?=
 =?us-ascii?Q?2rIZT4r7Ig+02v4v31d2FujaOTF3Cfb0pDk84lz4iZRJYipCxs+vA9SLnPYz?=
 =?us-ascii?Q?qO5jUW82X+/Qa1mUvj5phKAjXNkKtRvDhpOyHO6aS2SWGADaklac5t0dOiSx?=
 =?us-ascii?Q?JaF9mChYvsBI7TSdvXg+zeEOl+IGYyDlStpxBiGdyClqUrfDgNQnOIGDbW8r?=
 =?us-ascii?Q?B/LUsmBOW3RXslkMM7EH9on8ncYpG92HJ5b+AzFQNAhPm91siNgrycO54EZb?=
 =?us-ascii?Q?3y0VYbx/Xzdes1/HTTHvj3cZDqam7MSu7iBGqDNY5rRyjVSiBew7o5wloeft?=
 =?us-ascii?Q?dHNbHLZIqq7BY5DiTjvcAVPfzgUxD6BbCe1nTjm1pFekTN6TU6/Hmvx0l3JJ?=
 =?us-ascii?Q?aP0f33t8BYnTIt1zT5PH4FIASq9EB6L07qtUOKc8GVKxgOKyENOqdpCnWi4J?=
 =?us-ascii?Q?gz/zQ+WYNEEEiP0QqmHcyv+c6B6AG7Un6wrffhNdc/BZ7Mqefx/FpPD5xufP?=
 =?us-ascii?Q?VqDg+kW+PpTjD9NHnSHnZ471OwfOPCDZMuWKo3PPT3bB0HomO4R6AwasKSwq?=
 =?us-ascii?Q?o039Hc4a6rSQ0NQf9EJcUV9hJYVauhRbZ5w4pViJyTZdqF4KhNRjc50ShYls?=
 =?us-ascii?Q?2jciUw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc3d681-aecb-4c47-ec36-08ddfaa8e054
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:38.2482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+w4gb3yfkc9gvVq6qsQ51getrDQv3Hv59ZHseZSiNimqhdMZGip4lNcXBJLS1Wp4GnOaMslqyUgVqY1tgHwxKkFbQQ8QwbeovMB3QvgjHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Authority-Analysis: v=2.4 cv=C5PpyRP+ c=1 sm=1 tr=0 ts=68d2a6dc cx=c_pps
 a=pt7H9/Fs7R05i13VUf3btA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=VO-VGI-_H-TUAJbT1awA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX2vdJkiRJ48yg
 iyF31DzLO0IqlsHveibQ7VjrvPM33gAzFGdprpNAX3Rc5Ty7fq7ZaUT/pTQ41BhyWQb8HwSAi/u
 yCbo/jjRKMslPQXB9JvB0jD2PenODhb2a22GsuCvbqX7AQivNThT4EbeLff/0RPVqlneTTgr3HH
 k3lx97ieSguNGBEwwfJn/mEet6GGIOT/q/5zSM3UAJiawhMT1L+TnQzWhI7FIgi4NVFnydnlAiq
 9RMpHsPdE7tEWbYWgSOWpY5noF2OlW8AkZUj3UGC7tJ9jv9r8TM9r1LF8SuLHocsXvpEe9WRxzI
 ADgQlAZCfncEBAPbg2xzwO+e/HmEhZ+OxgLXBu849Va2j4koqVPZYw6jws0Ugs=
X-Proofpoint-GUID: 34WhJugshfw7ZK3kDqbQk_L2YmfQO-6r
X-Proofpoint-ORIG-GUID: 34WhJugshfw7ZK3kDqbQk_L2YmfQO-6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

This is the more typical naming convention for QOM finalize() functions, in
particular it changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 52561900fd..d4f5c7b9d7 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -370,7 +370,7 @@ static void vfio_user_pci_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
-static void vfio_user_instance_finalize(Object *obj)
+static void vfio_user_pci_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -469,7 +469,7 @@ static const TypeInfo vfio_user_pci_dev_info = {
     .instance_size = sizeof(VFIOUserPCIDevice),
     .class_init = vfio_user_pci_class_init,
     .instance_init = vfio_user_pci_init,
-    .instance_finalize = vfio_user_instance_finalize,
+    .instance_finalize = vfio_user_pci_finalize,
 };
 
 static void register_vfio_user_dev_type(void)
-- 
2.43.0


