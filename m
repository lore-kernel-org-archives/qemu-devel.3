Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0A3CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHipx-0003r6-04; Fri, 16 Oct 2026 10:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiok-0002gC-5v
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiog-0006i2-QO
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:53 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5MK63333355; Fri, 16 Oct 2026 07:21:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=svd63FWM8ezPOcqPD+qPN+weE2ncrsjkAO4QJk1oY
 wU=; b=DFydhXXBiNoUqUJ8fa1xVBvWZn45jOxUyFWbvXuqBUO0fdvZCf3XWv1PL
 eFFBLUQBZInJolYQZTw3u8WgIYHdwbnXuykvDbmmPawlx8emg8UAPc5zQ6uCzqTy
 n7dj1uWZ85fk2kPc8ZsI8XO7qMosj7UU2FNRMMO0cpMXYFRI9yxSW5gFJF/HYHN6
 +5+cTZZ9c5y0fZdAsAMVxD9isPKrmApgvsLVcocmDf93FvbyLvfb3mfViKKchfSN
 rFAOMSr+MEJoTSFepiuTb5jKCoQyNsRezXvnu6tg5grRV9Wt4SsmIWsLGAFFjVcN
 fj0nQz+D9msvpO0LEwEHRpTjcQezA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020128.outbound.protection.outlook.com [52.101.61.128])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4haukukqe3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ0Ucik/WbJY0ECp/LUc3fWzhj8cUWFFjcin+OgCR0YmMHD7DsZVQ2UUHcBdQq0emN2fRCmSSpdtvfyDtmMOGJP/ou6TlP2LsU/0KgzDGLCeuLVYfHLwP2cnYjwS6rvDXYBLN2yVsjq6us9AB218yN9Lzn4r31ioat7NQz7RoKX/8vwQ+NH/20fu1M9qGs8gceqTKqx7wTqrnbSWMm44fzfiCVaSPUEiegvNHm9CHidCkMDDu4J8TXbQVp6l2/Xb2RTcwtCzEF1kTasxdvbrIJmm6yOimYNFSNY4smRg0ccox1zPd8/g7j+QPQ2ksRE8bXuS2ec8MCKWGlywVK1I8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svd63FWM8ezPOcqPD+qPN+weE2ncrsjkAO4QJk1oYwU=;
 b=Yvk6I8Tq1iBo0r3BddTE3JxYtR9XFAbTB7UydpJC7kd63X+C6Nt/LQU62UCI6KlBZ1qPwcqg9H3jRsvL/TfXMoxhwe2jYr1VZKTawYkkca8z4tE80QUjcsIo7ea5M8xu9wgm9OO0EyJ+aSf5wI1WDeRoal6L1N0NgSn9SfLeUVaBw2iqC0H01eHpZcK4/BiAZAikeagCVtAhK9hck5lbWGSZR6PHHmfK9IDAptVW8SJcnJ6ugYgUXvYlGew8x7EKY+gwpk41qT0p2iMPR12xvcNkvcHPAmXNPrpZROtqoVTiKosdEoXiDjwhkH19/7tXtXOnAEfVbBKXT32QzPSPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svd63FWM8ezPOcqPD+qPN+weE2ncrsjkAO4QJk1oYwU=;
 b=JSnxeOocyOfp+goIvlf9AdpGJ72Rl502rTC91odWNxpGGEErnpPyQn7J5jittPaMVzZeYe7aKdIGzGh741xGLYQc23lMSCcShHRz8DlC/Lt3O85RK/lFkkGC8XV2wrg8hXfjonHBAy9bOeeX8EZglenUBHZ9kHHijWcpMmirCKX+8i2OI0euo98zyOtx0tVU6/XErL19wMxJp6RvU5vC3i/6RDHpOcVv23PdpbMX4ks9N7ii50a70ZxWzvn1mFVCxo6r/HiiaorA+X4zeTXkp/ZPkuc0xtIA5/GvlW/zuDw1/FEBDROgIurkAM7/6O2bxyKBj8U7dppX4YOtlekafg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6547.namprd02.prod.outlook.com (2603:10b6:208:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:04 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 07/27] i8259.c: always use cs for I8259CommonState variables
Date: Fri, 16 Oct 2026 15:19:13 +0100
Message-ID: <20261016142031.1204281-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: a0948d43-d9bd-46f1-1fe6-08df2b90b640
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|10067099003|3023799007|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: CsPLnfRjLNbQMopmTB5fZvif67alPJET2IBzMxeK/7y9ajUh2S5hOxAdDlFH8AONFtQzPJJKvXex2k82jHLAZQw3RxwfzEFbUG9+FWvZ+qNKHP5qGOwPfIElYRZ4DkI2moelOLLLqKoHEL9WAozBPH2FRnGFd9c1BqJGV2ME60477zaKpx3H4L3fGKeJ63Qf2myZd4PJAOrirgfmhgSZJvRUL1UPJR2WAHhI23DddpeNBx/QibUo32e61C0k7/xlcdCifyfCyL2+7FLk4k769bbr1w8/S1IEGyOxtK+SHkTJlt6RtyuxPthmJZ7aNel53wSd6hk5hW6m3Pu40RiKZcYExEtd0XIRWuM8w/4RqCZ810GR4MjJVimTZ+m9kq3RW+lSqE2C4kisRqPc3b/+qwrpI2A3bjwa6SCowCrNYqUjYNVsbsDuty2/hZzhMGDdBY/6jBL44bjyNDCiV9wDv82fXhab6LAfYJlzLqiSQK8WYK7x6bG63E59MjsK1pPOUI7aOyKRbyTHPnjmlHAsp6M/U8U0uzrtsCSk33Zcz9/5or37gaGdl1dwnhwZ+o7Tboig0USqr4NcfJnEnHrpndpXNrsp0tUQOjZcNZpBTOJwDjxlqJfmi9q6WjMLNF0UWZ3xsBdZatvVHzp038RwKqbD4aW2EO2tlNLNIb7K0Ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(10067099003)(3023799007)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O/jKcjRbR5fUNDIN/MvW+6q4t4e7YYHLJbmIdJAzy97Yyi7m6c7/2VLeQ/0o?=
 =?us-ascii?Q?9leS6I17V3AQGLBjpH3/1fnJ430E6lHWTtJKp1j2KD5XF1oETh1zVtHau9S8?=
 =?us-ascii?Q?+nHp3wwbSeb41FXUEhPr7lNENY/qfxIUx8JdJ05Nwft6F8hbr1DndwHAhozs?=
 =?us-ascii?Q?doInN2k5uOAFNe36GwsI8dmvCZavAgct5MiiE7j+S7fyy8RqttBjHi7aHx2T?=
 =?us-ascii?Q?EK+RotudVpUblYKmhQMtOTR/tpOeDqNHTWTVy37PUKvmCXIGKLR1+2F2cttK?=
 =?us-ascii?Q?j/VIKDQe24XMbDwdSlFNGUgG68E6xO5rhAzUrGc0+0E4KXT/eYPpUnLjaJyC?=
 =?us-ascii?Q?jrl4xOJUjAuv3C782U2m49yozAtEQIChS7tpRb0tT2dxRWjX2xTAXryA4cAU?=
 =?us-ascii?Q?iTtEZR2QNDMh3Jg+d5I93ZYANv0Qqa7EZwRo80kjNfCBvxHtZOu/NQFy0TFe?=
 =?us-ascii?Q?WODvlhGxgP9CWaEGT7yoYajMu1kXGXYR7GAAHY1zgN4AK5VEeOnXdV2ePuyv?=
 =?us-ascii?Q?7KJ5fAk9AGvoetDoEKppaODNJU4Z5zw9gWUyeR6FqYCEmzAk8C9jO4+0w0mC?=
 =?us-ascii?Q?fiRYJehbrZLAgoKf16fHCP0XGuj5hOD8lXVRrjtZFgXApOpc1HHE9ZAVYgvx?=
 =?us-ascii?Q?ylk6cP0wZa9wURIXR9i+fwkpG7kBHqAs5XMX8qcQDjNfnbnpCvWRdtfY6zZm?=
 =?us-ascii?Q?rQm8fESrctVxqPDVdf2XbVab0ITn5+eWXepmwT6VIzOuEw5BrZdWUQDU7vKW?=
 =?us-ascii?Q?lx8FdNTFcyCYBEW5lfolQiIYqKAewKygOsbqyinpW0becSdj6jGuEp93zoZh?=
 =?us-ascii?Q?2dzYtfglDhiB0LD6SXSfsbqVbvBb/Lcr1BhOTUAcHPPe5w3wsVy7kewcuYAw?=
 =?us-ascii?Q?vRAfGDfO7+5dpnerx91b0oBiGOxrf3WbvaIOi8+5KI3Fhh4/SYwA2nfymX15?=
 =?us-ascii?Q?do5BXm8JHHClEQ0wx8JGg7S5nzJuv+5u8rV/jY5LX3TCdTDBtwrYXNyCqD0f?=
 =?us-ascii?Q?MrdnQSV3gtGaQgkTMws+x91HkcPTQ4EJYvUtpI9RdBuM7gCIp21wLdzcoQBO?=
 =?us-ascii?Q?Xpha07eVzYURu8CzYICpV261TvlpfOyrdrHIdY3s+0QFKyFPea/jZISBPd5u?=
 =?us-ascii?Q?LRG22TitQKUUEr3elaB0255y+nhDhQrGygjUJEcb8mEfQ2cGyIE7gsvbhh//?=
 =?us-ascii?Q?Cvkwyo2daX6+HlGOxuqWt8QksVxdEDpSx8kuBAi2k420M2I/y3f5v+xTBTqE?=
 =?us-ascii?Q?n8F5UkBi7ohbJj2ZxevRZhN25K/XetmggQctmqmUaYWzstDgKLXupO/eE3ft?=
 =?us-ascii?Q?B/3qwbX9sLkK0BR5UZjecj70BXjEFEpoO+i7kQ/JdOeTbwTQVTyNTfAFyFHn?=
 =?us-ascii?Q?1CQahO6KncEqPQoFJtkwUtRf/I2wKbGoVZoJtRf90gTDbxrKqRQIhsfZAYG1?=
 =?us-ascii?Q?NOWiqb2mkeqMhDgP/GPoSJDEQjQAH8E7i+1AsxjugLgJt0+frUO4P7SXL6hY?=
 =?us-ascii?Q?Daq7f2HaS/+stxgq/8Z25eLQQCTJ+xkTvwUamUnllgJUlm/KwqTlhhuySo5Q?=
 =?us-ascii?Q?Aj44uE5aciOJBRUhT3s5KagH4FxzjmxtGw9uIJIMv1pO5HihqzDEQrnyHj7L?=
 =?us-ascii?Q?dk1HP2U3M7M5DwVSre0qFeNufEqjF5B/AfGScEfYS0FCuYGQodZmCbSLWajX?=
 =?us-ascii?Q?neWPy0KSR5oYgDQ2LNtoS17KgeOA2aq3nKh2S5Yl7vopaWELrav9qQjW55uw?=
 =?us-ascii?Q?tGp/VX8HwTqxCL20VFNixhp3K+ciVzg=3D?=
X-Exchange-RoutingPolicyChecked: 3RmwBOUbmoSz3VvbiQIrTvYi5bO+PNuRB3mCZfCK+M/evEjtd6kjYh+8mubViB9JwbNaszNLNATFmBaYbgjd94EmLmDwvP3Mk4m9N7bb++uVGDQxOPtcYlRBkc1TdQ7DHhQO7Dk8ZmL8BNf8vy9lD+kT0wQRNEXSLGDXP/PsjnoDb8c8isnqbfK+8v+mcNopmcfL1ZYI5tVfFH9GXeTd+5ILOoc6W/IytK90+TB8rO+vblPucDso3KnVcCxSDel1d/saWveQOkb3hVBaMd/JrVFEoCsCrHWg4XbQYpSwYNN6UqTlbi01fjJeCFgARprWZkNdMvQTIS/9DgoAy8gy2g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0948d43-d9bd-46f1-1fe6-08df2b90b640
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:04.7960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0gNrThslOlyMy3F4yWg96d8cqINHthZU/l2H6CAIGukls3RXjLwBfmq3BsdpUJOi47TWUZZ5vQR3+n67ElXPCkNQ8vwv2uC7SLTZ1OpQfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6547
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX4vZKa+1YxGZx
 WcMy5QS6sGzDmatkddoz7NiUeRUXowlbG3PjAcO12n1grwY17Cj/yAFZ+6epIBVLWuEvKKpNDYs
 f6KlZyUU6ULXlby5jMsGNdVDwqw1ntA=
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ad232f6 cx=c_pps
 a=8h7WK4dQWB09CNKj11a7yw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=zV1iqHTY6MOlpgDiNWkA:9
X-Proofpoint-GUID: DFMP2JQtX8tPTSkUBfw37ybxcVl-xCMK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX1L6/MWftkwbV
 JZ6u9Mrt/pOnKOgECdxkAYplWHEBqg4/D8QltC6dg7ObL5i7q+4xGYIh4zqssASgLJvu2zJY5dx
 +cOOfXBJjA+w+Y9zSDdc++SfUQvghzAHuamOm4lfg1bTBWSgbMQ8pqNl5tLEA9NA+GWXBHRwAgG
 lcTh6OdcyOCd35IDwiFSsocwJHNcUq47bLIUJH7ENjryOnn2aOU/QnJRD0jAoQCJr9RqkfKdayF
 GTjspUI1xna92rAXndJsDvagR2n+yNKx3E33Td3AvZjJq9T74/SoH5ViR4uJgUn+AKVJQs71trV
 Rv+PwSw0C8AwDZGiwGXvzlPX8lZKrbw3UiN9+emwmXYmFiGKDlCEl6FckJUtnEAoFmufqdW5AJC
 F4GPrnqVWnynN0tozHduYphH2B/LSV8axqxajX2/93XsQodydLwyoFe0CzS1eRlP1nVw07pZXwR
 6MAptGL/YXFwY6oDYBg==
X-Proofpoint-ORIG-GUID: DFMP2JQtX8tPTSkUBfw37ybxcVl-xCMK
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

The use of consistent variable names makes it much easier to follow which
fields are being accessed from I8259CommonState.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 192 ++++++++++++++++++++++++------------------------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 81827f2734..700412df74 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -59,7 +59,7 @@ static I8259CommonState *slave_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
-static int get_priority(I8259CommonState *s, int mask)
+static int get_priority(I8259CommonState *cs, int mask)
 {
     int priority;
 
@@ -67,63 +67,63 @@ static int get_priority(I8259CommonState *s, int mask)
         return 8;
     }
     priority = 0;
-    while ((mask & (1 << ((priority + s->priority_add) & 7))) == 0) {
+    while ((mask & (1 << ((priority + cs->priority_add) & 7))) == 0) {
         priority++;
     }
     return priority;
 }
 
 /* return the pic wanted interrupt. return -1 if none */
-static int pic_get_irq(I8259CommonState *s)
+static int pic_get_irq(I8259CommonState *cs)
 {
     int mask, cur_priority, priority;
 
-    mask = s->irr & ~s->imr;
-    priority = get_priority(s, mask);
+    mask = cs->irr & ~cs->imr;
+    priority = get_priority(cs, mask);
     if (priority == 8) {
         return -1;
     }
     /* compute current priority. If special fully nested mode on the
        master, the IRQ coming from the slave is not taken into account
        for the priority computation. */
-    mask = s->isr;
-    if (s->special_mask) {
-        mask &= ~s->imr;
+    mask = cs->isr;
+    if (cs->special_mask) {
+        mask &= ~cs->imr;
     }
-    if (s->special_fully_nested_mode && s->master) {
+    if (cs->special_fully_nested_mode && cs->master) {
         mask &= ~(1 << 2);
     }
-    cur_priority = get_priority(s, mask);
+    cur_priority = get_priority(cs, mask);
     if (priority < cur_priority) {
         /* higher priority found: an irq should be generated */
-        return (priority + s->priority_add) & 7;
+        return (priority + cs->priority_add) & 7;
     } else {
         return -1;
     }
 }
 
 /* Update INT output. Must be called every time the output may have changed. */
-static void pic_update_irq(I8259CommonState *s)
+static void pic_update_irq(I8259CommonState *cs)
 {
     int irq;
 
-    irq = pic_get_irq(s);
+    irq = pic_get_irq(cs);
     if (irq >= 0) {
-        trace_pic_update_irq(s->master, s->imr, s->irr, s->priority_add);
-        qemu_irq_raise(s->int_out[0]);
+        trace_pic_update_irq(cs->master, cs->imr, cs->irr, cs->priority_add);
+        qemu_irq_raise(cs->int_out[0]);
     } else {
-        qemu_irq_lower(s->int_out[0]);
+        qemu_irq_lower(cs->int_out[0]);
     }
 }
 
 /* set irq level. If an edge is detected, then the IRR is set to 1 */
 static void pic_set_irq(void *opaque, int irq, int level)
 {
-    I8259CommonState *s = opaque;
+    I8259CommonState *cs = opaque;
     int mask = 1 << irq;
-    int irq_index = s->master ? irq : irq + 8;
+    int irq_index = cs->master ? irq : irq + 8;
 
-    trace_pic_set_irq(s->master, irq, level);
+    trace_pic_set_irq(cs->master, irq, level);
     pic_stat_update_irq(irq_index, level);
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -132,44 +132,44 @@ static void pic_set_irq(void *opaque, int irq, int level)
     }
 #endif
 
-    if (s->ltim || (s->elcr & mask)) {
+    if (cs->ltim || (cs->elcr & mask)) {
         /* level triggered */
         if (level) {
-            s->irr |= mask;
-            s->last_irr |= mask;
+            cs->irr |= mask;
+            cs->last_irr |= mask;
         } else {
-            s->irr &= ~mask;
-            s->last_irr &= ~mask;
+            cs->irr &= ~mask;
+            cs->last_irr &= ~mask;
         }
     } else {
         /* edge triggered */
         if (level) {
-            if ((s->last_irr & mask) == 0) {
-                s->irr |= mask;
+            if ((cs->last_irr & mask) == 0) {
+                cs->irr |= mask;
             }
-            s->last_irr |= mask;
+            cs->last_irr |= mask;
         } else {
-            s->last_irr &= ~mask;
+            cs->last_irr &= ~mask;
         }
     }
-    pic_update_irq(s);
+    pic_update_irq(cs);
 }
 
 /* acknowledge interrupt 'irq' */
-static void pic_intack(I8259CommonState *s, int irq)
+static void pic_intack(I8259CommonState *cs, int irq)
 {
-    if (s->auto_eoi) {
-        if (s->rotate_on_auto_eoi) {
-            s->priority_add = (irq + 1) & 7;
+    if (cs->auto_eoi) {
+        if (cs->rotate_on_auto_eoi) {
+            cs->priority_add = (irq + 1) & 7;
         }
     } else {
-        s->isr |= (1 << irq);
+        cs->isr |= (1 << irq);
     }
     /* We don't clear a level sensitive interrupt here */
-    if (!s->ltim && !(s->elcr & (1 << irq))) {
-        s->irr &= ~(1 << irq);
+    if (!cs->ltim && !(cs->elcr & (1 << irq))) {
+        cs->irr &= ~(1 << irq);
     }
-    pic_update_irq(s);
+    pic_update_irq(cs);
 }
 
 int pic_read_irq(I8259State *s)
@@ -213,81 +213,81 @@ int pic_read_irq(I8259State *s)
     return intno;
 }
 
-static void pic_init_reset(I8259CommonState *s)
+static void pic_init_reset(I8259CommonState *cs)
 {
-    pic_reset_common(s);
-    pic_update_irq(s);
+    pic_reset_common(cs);
+    pic_update_irq(cs);
 }
 
 static void pic_reset(DeviceState *dev)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
 
-    s->elcr = 0;
-    s->ltim = 0;
-    pic_init_reset(s);
+    cs->elcr = 0;
+    cs->ltim = 0;
+    pic_init_reset(cs);
 }
 
 static void pic_ioport_write(void *opaque, hwaddr addr64,
                              uint64_t val64, unsigned size)
 {
-    I8259CommonState *s = opaque;
+    I8259CommonState *cs = opaque;
     uint32_t addr = addr64;
     uint32_t val = val64;
     int priority, cmd, irq;
 
-    trace_pic_ioport_write(s->master, addr, val);
+    trace_pic_ioport_write(cs->master, addr, val);
 
     if (addr == 0) {
         if (val & 0x10) {
-            pic_init_reset(s);
-            s->init_state = 1;
-            s->init4 = val & 1;
-            s->single_mode = val & 2;
-            s->ltim = val & 8;
+            pic_init_reset(cs);
+            cs->init_state = 1;
+            cs->init4 = val & 1;
+            cs->single_mode = val & 2;
+            cs->ltim = val & 8;
         } else if (val & 0x08) {
             if (val & 0x04) {
-                s->poll = 1;
+                cs->poll = 1;
             }
             if (val & 0x02) {
-                s->read_reg_select = val & 1;
+                cs->read_reg_select = val & 1;
             }
             if (val & 0x40) {
-                s->special_mask = (val >> 5) & 1;
+                cs->special_mask = (val >> 5) & 1;
             }
         } else {
             cmd = val >> 5;
             switch (cmd) {
             case 0:
             case 4:
-                s->rotate_on_auto_eoi = cmd >> 2;
+                cs->rotate_on_auto_eoi = cmd >> 2;
                 break;
             case 1: /* end of interrupt */
             case 5:
-                priority = get_priority(s, s->isr);
+                priority = get_priority(cs, cs->isr);
                 if (priority != 8) {
-                    irq = (priority + s->priority_add) & 7;
-                    s->isr &= ~(1 << irq);
+                    irq = (priority + cs->priority_add) & 7;
+                    cs->isr &= ~(1 << irq);
                     if (cmd == 5) {
-                        s->priority_add = (irq + 1) & 7;
+                        cs->priority_add = (irq + 1) & 7;
                     }
-                    pic_update_irq(s);
+                    pic_update_irq(cs);
                 }
                 break;
             case 3:
                 irq = val & 7;
-                s->isr &= ~(1 << irq);
-                pic_update_irq(s);
+                cs->isr &= ~(1 << irq);
+                pic_update_irq(cs);
                 break;
             case 6:
-                s->priority_add = (val + 1) & 7;
-                pic_update_irq(s);
+                cs->priority_add = (val + 1) & 7;
+                pic_update_irq(cs);
                 break;
             case 7:
                 irq = val & 7;
-                s->isr &= ~(1 << irq);
-                s->priority_add = (irq + 1) & 7;
-                pic_update_irq(s);
+                cs->isr &= ~(1 << irq);
+                cs->priority_add = (irq + 1) & 7;
+                pic_update_irq(cs);
                 break;
             default:
                 /* no operation */
@@ -295,27 +295,27 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
             }
         }
     } else {
-        switch (s->init_state) {
+        switch (cs->init_state) {
         case 0:
             /* normal mode */
-            s->imr = val;
-            pic_update_irq(s);
+            cs->imr = val;
+            pic_update_irq(cs);
             break;
         case 1:
-            s->irq_base = val & 0xf8;
-            s->init_state = s->single_mode ? (s->init4 ? 3 : 0) : 2;
+            cs->irq_base = val & 0xf8;
+            cs->init_state = cs->single_mode ? (cs->init4 ? 3 : 0) : 2;
             break;
         case 2:
-            if (s->init4) {
-                s->init_state = 3;
+            if (cs->init4) {
+                cs->init_state = 3;
             } else {
-                s->init_state = 0;
+                cs->init_state = 0;
             }
             break;
         case 3:
-            s->special_fully_nested_mode = (val >> 4) & 1;
-            s->auto_eoi = (val >> 1) & 1;
-            s->init_state = 0;
+            cs->special_fully_nested_mode = (val >> 4) & 1;
+            cs->auto_eoi = (val >> 1) & 1;
+            cs->init_state = 0;
             break;
         }
     }
@@ -324,30 +324,30 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
 static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    I8259CommonState *s = opaque;
+    I8259CommonState *cs = opaque;
     int ret;
 
-    if (s->poll) {
-        ret = pic_get_irq(s);
+    if (cs->poll) {
+        ret = pic_get_irq(cs);
         if (ret >= 0) {
-            pic_intack(s, ret);
+            pic_intack(cs, ret);
             ret |= 0x80;
         } else {
             ret = 0;
         }
-        s->poll = 0;
+        cs->poll = 0;
     } else {
         if (addr == 0) {
-            if (s->read_reg_select) {
-                ret = s->isr;
+            if (cs->read_reg_select) {
+                ret = cs->isr;
             } else {
-                ret = s->irr;
+                ret = cs->irr;
             }
         } else {
-            ret = s->imr;
+            ret = cs->imr;
         }
     }
-    trace_pic_ioport_read(s->master, addr, ret);
+    trace_pic_ioport_read(cs->master, addr, ret);
     return ret;
 }
 
@@ -361,15 +361,15 @@ int pic_get_output(I8259State *s)
 static void elcr_ioport_write(void *opaque, hwaddr addr,
                               uint64_t val, unsigned size)
 {
-    I8259CommonState *s = opaque;
-    s->elcr = val & s->elcr_mask;
+    I8259CommonState *cs = opaque;
+    cs->elcr = val & cs->elcr_mask;
 }
 
 static uint64_t elcr_ioport_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
-    I8259CommonState *s = opaque;
-    return s->elcr;
+    I8259CommonState *cs = opaque;
+    return cs->elcr;
 }
 
 static const MemoryRegionOps pic_base_ioport_ops = {
@@ -392,15 +392,15 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
     I8259Class *k = I8259_GET_CLASS(dev);
 
-    memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
+    memory_region_init_io(&cs->base_io, OBJECT(cs), &pic_base_ioport_ops, cs,
                           "pic", 2);
-    memory_region_init_io(&s->elcr_io, OBJECT(s), &pic_elcr_ioport_ops, s,
+    memory_region_init_io(&cs->elcr_io, OBJECT(cs), &pic_elcr_ioport_ops, cs,
                           "elcr", 1);
 
-    qdev_init_gpio_out(dev, s->int_out, ARRAY_SIZE(s->int_out));
+    qdev_init_gpio_out(dev, cs->int_out, ARRAY_SIZE(cs->int_out));
     qdev_init_gpio_in(dev, pic_set_irq, 8);
 
     k->parent_realize(dev, errp);
-- 
2.43.0


