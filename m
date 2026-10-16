Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7F9CCF2C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiol-0002Vz-74; Fri, 16 Oct 2026 10:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiof-0002SH-GW
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiod-0006hN-Sk
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:49 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5MkL3333363; Fri, 16 Oct 2026 07:21:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=po3EEb9dG7/G0E+Na053cQN8h6xsnwFa0pjZGUjYe
 P8=; b=2jJAEPWMQRMdu3qolB1cjaxR+nOoo3Gh2CW0UE04Sm1XpwuH1L/dzEzzZ
 VSq0I/f5G5K13pttOGF/zoehiMcVwlyiPkh8GvVdQHKKV2NiqYct73WM5Pi6gi1Z
 5SdZpF5wta9Jt0nBz2uvW/xcSv3+5lS3Nsc6+7+wh5FS4Iy46WQx1dsyNw6i/prG
 NgUWCdzyib7fEIqMymPYSwpOQ8ZXYxPdqfYIlm44muzv+kEMYpar3sDRjo6DNDug
 Pe1JkhnhLTE5Dv0CddL50nDw79ANNtrrmwAOfdXa/6ZuOL+APwwfLjLOJ+4fMCq6
 JRWYfDU2LmpMetEZ1QIzcOqNVYfRg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020117.outbound.protection.outlook.com [52.101.56.117])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4haukukqdw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnvJlJFctGcQvO8cl6uWOJoAuobKE1xLc7mQeVPIxqY9jdwDUnigBwUfr/c0nKzV1fYGqnvxoyQZQ0K/q0tFPXxwjdRChgNJmIpSltAmAIDMNcYOscWzCj8MPOlcbAAGWoacLU2GVPrsUci/s4piMgUmNtDS/c7exmTdFosbpfNUTbAGSz7QKJikI4b2uixRRIrI0mU1+cxJ460zw56e7rCeABxPFPpJ4zEOiicZhl9NxA1rJbfZKaylFBsJSHAmfHzvj3C3a8NpW/+Ho58V56dXSrBHIbndQXR22c4xwnoTt0UYqvjJoko88RcXHF/qujlOkzZulXEoL6RMfTiSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=po3EEb9dG7/G0E+Na053cQN8h6xsnwFa0pjZGUjYeP8=;
 b=iOc0FgQFXy5c/hXaoZzsiAXzx25XGFZG9fH6WB5ocRUZlBUN8FGcm1sZ2ZB87AKhASg1AcxuBSr88s5XPFoQySDfXF/WhfT3LnjQzlQUPRSWHtnL56CfIPbZEiLOoigOS+U4HiRap+IesJLT5VC1p13WMpGDQEH6ZgJeql5+5ED4VLGw5soyMH5Gv2IXzpPEGyeYeZsLBW0Nn1Ni+LIaGZ0lU6s+GXGkVSL5jmsYscfXsjSy4zun+ACcABRpRjc/7Y8cHFQO22lGGpaxBh9DVCfwkPImKKZdPgiE2ciFSrq8e1vD7gRnIlk58sw050mzLEH2R9tDHsAwk+yjYIbTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po3EEb9dG7/G0E+Na053cQN8h6xsnwFa0pjZGUjYeP8=;
 b=sziSnpcLOUroF99ADTaVORq+z5sMZNBaRHxHDh0/p78Xd02LC5lPS9asEykgvc+EiI/r01zNjVMTzqyfczZfCIXzv36uyjt1xJ/WbH9EDRjhgBRqEKcmWLSfHtRGjZT0B4vpZ0k85tTdW2TCGTDRYoqnodXprALjwBO2TWi8d8s1x/Nah+Sx/+Pbla91hcz8wpH5iUZ5fyInnv1m7JR3smbHlShix9rpQMdAEe6psvgTu36KrQijCV2zl+U0Cm4QHQ+kzIlUtPpu7N50wCVcd0rc4Jp1A0+9Y1pe+xjN5CI8JjkDS3Enuhggd2110dvDH6YJhwWT0iaUlRr4H9WSMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11424.namprd02.prod.outlook.com (2603:10b6:8:352::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 15/27] i8259_common.c: convert to use DEFINE_TYPES() macro
Date: Fri, 16 Oct 2026 15:19:21 +0100
Message-ID: <20261016142031.1204281-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: 476986ab-4b69-46fd-9f13-08df2b90cacb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: kUXsU9uCBiee/u9yUypQJojr5dhQDxPRfDbnxbj581f0/R0bqlSPj7F9wJ3A7Hy8WLF4pIOWpf72fkVibc77sWxrGUmhH8I+RV9qug0+aM7TqFFlGwZEkeOh7Shj5LT0do239gaL5/Ydpf5tbcEQOeFkwFrtKosBt30DJ3Ja0sLCMbU5VGRAL/9HLjmMQkifUEldeCFrQmD+apIMWyNF03pCVCwKOUsdmzHpUum606N9AvxoO7n17QDo1r2/d2zPUwjy9q18RN3ItNdvuJV90i1qdbByd/50JPkRNDbdbIF/0ffTOF1RwdKyYhc6udi1fao4UOwGEtVlVkTS2Rw2UKt7T4KlUlWhLhabzfPj8XhQY2x6h91cnh3uo25Sm+JCkUtjN8NR39R/PkhZ2kxoCiKRm9nvQEgS2brIHSRKpfRuIuHC4wRSWxH7Tp9+1ED0f+aO1R6UNDCkH7h27vytOz0mJdmJQv0QZ0xw31mNpS0FDEqp28NKgPMxFbsmaxvbwW1bOgziZqnzh7VFZpMBgK320jO2WgF1ilclUrVQNiMgOyNO+tYUxDS7304f0a6DJrCbBZkQltqgibSXTZRRBP0Xnx8WxyOomov3RAEPyShZmM5/jnKMdm/gXH6Nr1RSFHRVUXAOTUiMzxVsMAbLM9p7A90R/OwJ2H6k5wm8HSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wdef5kK/dG0+2rn/O+kxgYfd5djpgLaQb0qIvOJ9zzAYA48TsviJePyLXqDl?=
 =?us-ascii?Q?yft1Xs3dXZUw3KtWylK4UAMCBcdobYZMvDqohHJayX3dsZXGglpA/SjWhHUc?=
 =?us-ascii?Q?GOHD6g7BsVz+Bxoj0r6k6oyFGbtY8roM4HWXWwkKzvBty/BhrTTO9CSetYr3?=
 =?us-ascii?Q?J1NPST35SgE3Vtn3tbBO08VNibRrWJzEskFCWmsV3bRb59yHT5Qr5H8HHiJ6?=
 =?us-ascii?Q?7S/gVDIeUxZzYiAkUhYXoeXaqwe4tHBX/+M1Qg6/EZO6MdkP+Zt6NU7hGbbD?=
 =?us-ascii?Q?VTdNL7IuTWzebkG5PxYW0y/Fy/NipL3ygXZSpu0VznQDl+HFJhpv+RiVB40r?=
 =?us-ascii?Q?1j+XK9Mqn+X9SGeil/gPpx9StQJB716dNoQW6X9m/Q+1LHLrahjTaNCksYjf?=
 =?us-ascii?Q?AboD2EbgvWSD/O9Rynv2NF8uFzBAWLeSqOl+JLT1Qf1j+99uJTJZ/qcrySSm?=
 =?us-ascii?Q?Iq0TSxOqaQuVzTpAWfJWrX+Tv0qd3OFv6ZRjx5sAaCyuz736dSgefWzKvLWs?=
 =?us-ascii?Q?Ws3E3ku9pT0DwSa3wZWZSVOctgccNbaCwnz1IZd3/5ZV/NbEiYrsX73TU3uJ?=
 =?us-ascii?Q?V+bTXHygpZZYD73108a0KVlA79jlLxTKS9PMcmT3bzN0Fs+Vh+ZVMx8Yt7gU?=
 =?us-ascii?Q?ZScz8d1eZthnKZ3+qzmPajd9PdSHNAlg8ZYpo4iaEqtu4sE8NrCtsm1oe4ei?=
 =?us-ascii?Q?hxKMr9dE7FK1vknqhQsshtSmh6NZv5YY4dOMl5ARJlCQM7kRC5rRrOQ9dz2I?=
 =?us-ascii?Q?772rsNIqVCjKDINbEYgoMl9c14oJ+9etc2YvyTwkXNUzpdqEjF6Q0xCSgHkR?=
 =?us-ascii?Q?U0dsVuRWGIGy1PsC4gXydNwAufKAyDIn2qnl66mFrQZ2VnGu2h13cpLmGnDV?=
 =?us-ascii?Q?p0hktMaEaDIrulhubmwRzM8wPjS5aMBzsF5dSbWs6YCeBFBtS/w+OYicLm2Y?=
 =?us-ascii?Q?NEUkPGeswETByCwfQJukZgB14SQWn4bpDqWSif2y5oghYcrdT0cKzmJs0ruw?=
 =?us-ascii?Q?+KJMoXbAp0IWk59hmpE4u+7Sh2Ya0pHFJUMbrk9jTH8BK9Vnn+ZXv2/cu22u?=
 =?us-ascii?Q?o/tCyN4iuLzWxJg5eKqGQNiBkQgYbJzGl3h6KSInjLwSPIAyM1BkvA3zYt/m?=
 =?us-ascii?Q?5Rwi3ghkYPYaEepE4/EV46qynofwTjDU9X/fGl5Kp/LFFnW4oq1JwItRjfZ4?=
 =?us-ascii?Q?J+90L5WAZ/usbNQkWTKRONis/mDsNSM8DY1A4sCs4bJESjmpWOvqgJkacWVt?=
 =?us-ascii?Q?1W8wLrFHKX9rl9XtNFbzgDS8CVfSdiPPzc0xvESPAjbFhqHn6o0UENZLDYyC?=
 =?us-ascii?Q?VDuil25XxE1zShSIT6gZRa8Fs35neleQq00leD6xlblRWBEH4ozimuwt3Fna?=
 =?us-ascii?Q?7s+NELzofG144BmQapZlyoKVTkPSJBMPr4y6KDSY1h019gTWVhdK0jsygA0a?=
 =?us-ascii?Q?YHmZnK7o7gmSWW081iTbif3Mu9JWKIT5GH2BuQfHuCdBRJxbSAPHM8c6oivC?=
 =?us-ascii?Q?0TGnBBCHbD9Op9jZCMK3aHt2kQtYdmHWoacp8IdPrFzgm/uDYDuhY4CxufUj?=
 =?us-ascii?Q?KwQpqY2x8uV2jCcLlcSSHsMp4X1NwqtwhutIVrZekJsrSlYU0gmwPTfKNh5Z?=
 =?us-ascii?Q?I5nhTQLBgaT/UgKYgbDhPNYJVLEZioWjgaNjMwzQq42BPaPnU8j6zOxa04S0?=
 =?us-ascii?Q?JEnTB2O6t0kAYtauBH4lwRT0iv1CQw99yTCm9GRB/s8zTNOH23a9eTDQBmqg?=
 =?us-ascii?Q?ReMeHs3fS/8HLYFhl+8fHRqgkn4yiTw=3D?=
X-Exchange-RoutingPolicyChecked: oXKv5Ad3xuW1lHiWcGbKAa7M+f+qQeQH5OWe2ETqebJEtjDfvGu/UoaI6U4M4QCCLvcLqQ7EcKJB9vJd3Q2ImVRyeN8jzEoGvHff9njJNYXuaz+dxNV582EG0nQnUUOPBvVXbE+z1a6uTxEUpO2/WZdlmQirvtYcdrBZQcsHWl3d2TtmeTRZU9Yq8i+GsevtNeRMNOVxVAFsBCErv6YUQDWR0c2s2uXrHg0xMsgFoBNCP8Av0rBbj2zYNmDYrzFsSEJftUAmptn4CsR34YMTz5a4ErUuF72ZkthfpPitug54W0oZ4HF0LQccI4M+H/giOE7XBBnsdGUI7e9rDBJNhA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476986ab-4b69-46fd-9f13-08df2b90cacb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:38.8585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvOtc1kbvibCdr/61CNNwIPrFakpYVwe1pXOX1hcGLXdRI2a7qeYEWZFES8s8TozCH/9okryVk5ECGWLgaLhFd9kjWUAwoVopoQbRP0sOjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11424
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX6bSPqhh2e87O
 UbzdbsN8qYh2y5/IqMAedm9wl1qZhgfxCPjC4baXRFf4dtu8ocVDeSnNJcgZHPouGU4cBw6QGYM
 LmyqGMYncHf1QrR63WHTzQ4gA8nCDTM=
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ad232f4 cx=c_pps
 a=v6Z6meDQFn3ji2zknzBGMg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=bPck6Z4TT5Um9jj7BtEA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ePNY4L1EQ_7rW3CuPYUeBCEX-HIJAeOU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX070aBJZGe0w/
 VCE5/KUF7DyzpieCvcRSV0GaLhRMW54g3bTWCmv5S2BvmAvbo9ttuJ4KKPGDKuZHyfekk1jezhM
 WO7MD8wIoC0qzWZqJaJQzLrI73kG6lo/ap4rKDXsp6+zdGb29WsOP23FJ6IV4OyO2H8G6yzkXS7
 m1wWTuALFiQR9FCzTEN9o/ZKLktipzj968uz+yNBNiczg5oZRPXCBaVvZDoq3RySQSEDzQXbLQ+
 jNEE+dx2SULy8JXqy85amkbYV0rRhu+2eC7IHBazLbwXfsbz9tEhJFDOUjMqWmuP9bo6K4QaYEr
 ntiJJ+8P8ILsXnDkFfO269BS69k/N4R3xhnf4AEX+DdYU/Ns8a/xuCrMjwVbmSQX+2KXzmq8h7O
 Tng56Vouq4wCYOLXT3FO2VQHaYtF97KYWEM8UQFyTQTUmPjfz84bBAnz3nD+ZLzCsAkfjyzzubS
 8q232Lh/pLJ5QRV8+Ig==
X-Proofpoint-ORIG-GUID: ePNY4L1EQ_7rW3CuPYUeBCEX-HIJAeOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/i8259_common.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 31bd663439..09b761321a 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -220,22 +220,19 @@ static void i8259_common_class_init(ObjectClass *klass, const void *data)
     ic->print_info = i8259_common_print_info;
 }
 
-static const TypeInfo i8259_common_type = {
-    .name = TYPE_I8259_COMMON,
-    .parent = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(I8259CommonState),
-    .class_size = sizeof(I8259CommonClass),
-    .class_init = i8259_common_class_init,
-    .abstract = true,
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_INTERRUPT_STATS_PROVIDER },
-        { }
+static const TypeInfo i8259_common_type_infos[] = {
+    {
+        .name = TYPE_I8259_COMMON,
+        .parent = TYPE_ISA_DEVICE,
+        .instance_size = sizeof(I8259CommonState),
+        .class_size = sizeof(I8259CommonClass),
+        .class_init = i8259_common_class_init,
+        .abstract = true,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
-static void i8259_common_register_types(void)
-{
-    type_register_static(&i8259_common_type);
-}
-
-type_init(i8259_common_register_types)
+DEFINE_TYPES(i8259_common_type_infos)
-- 
2.43.0


