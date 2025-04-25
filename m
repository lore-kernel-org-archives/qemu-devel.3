Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1418AC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Hdc-0008Pw-Ro; Fri, 25 Apr 2025 07:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8Hda-0008Pf-O1
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdY-0000Pb-LQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:34 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P2ACi8022644;
 Fri, 25 Apr 2025 04:54:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TccoNF3C5j/PdSr3M46QlvDbmfPnz6zbifM6re68H
 eA=; b=ZiTyZX0+/GEMcGxDTchCcGFnHV8aGe4xmRSZeCxfnQJse7xWsR3glOL+L
 Tz58NHWhyt8LYCcTSvDvBPULcDPLn50t8JJaa5e9RYjW8VDN5i5pmx13YIdgCWTS
 a2U0CvD0Alx5uVFT2ITVdem0DZrotmtNK9Cy0LdsJNO7UxYFtmoD+jZGTh9/4c5f
 TNsOKIsviBCDVofrjBnYdq/2dPDNxJ3I0CUFbkjjI6QE//0/FKVhTM/Ew3GXXKz8
 QHIPrgNL3uajt/afzrVxYdL1fRalS+iXbJNNVVbsJyPuRFlwXNyoaNxIoXe6zM5Y
 VBEX/tG7AzrSNYtb4Gla28O+wKhmA==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww21b9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nybb/grG5P4J3ThVophv9oalTSmzyb8htmHY469v+cahSS9BQ4L++xBOd18xZXPxMzdh/JRSV698b6pyOCbNznSMGsI23Kj/R6WAv7l56jyz0XyRPLd28JzeRT2FL3EXFX59cBAGVmLbobD8sVkw2zSyOwnj2YDmcL8hG3QpXCrukGuJUZxhAgIKYlJDN2vmPvZxKubx/xvEnnPcIzPVsiM5Cxp4USpw8utK4h6QYPXp3sDNdlT/ex4Gh2r718j5eDc1Vrc4kcwmvWyAzmKHY1SU7tclDytjHPf9GRsIL4+dcyeHL8Qjsfp5Px6Fj4tf5QI2AJDAmQd74mEuBc401w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TccoNF3C5j/PdSr3M46QlvDbmfPnz6zbifM6re68HeA=;
 b=JmyPwmkFLBtmFxAs5H5mZSocVwP/0j/6yOeRIbcRwRnxGOiB8MeaV/c2eQOgWkca2pZqOAyVHZ7INlFuMjkPSVLadtZk4nCaaOzyrqhqWR4iMRZ4J2FzQDhTaHjpLVN5jDXhk4QzYQj2nifGB3gsMBYPCoJ2sWVwmqkQowCDEz6Jmkpu7UeChVTFWSOVydbPHzIEnAXxmwQEe2LYJfirm67ANq88Wo6qPa06skO/rBa99xfLOdpawyELYrNEJKXj2upFGUsYdGIJ0Zi1GyeFW89o+iS2A5Sg6weuGYDOP16sdWP5l+CK7OwcFGL/sx+lvr9UThpWtkCfP7smlAVW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TccoNF3C5j/PdSr3M46QlvDbmfPnz6zbifM6re68HeA=;
 b=nQZAEfJ5lX2rsww87bx3Ql916rQ5h0d3KBG+gG6LAcVz9VI6S0PwHTpacE8d9RhpFQ/h3Svw7nkIqMtPb+YWm4+8b5XShRvKiS3iBJ7q/ma/wIuyhIaeegAmQjUhGIp1YSp+gaLFXqE5kMUaQoaUp/FCHg1uuSJ6Rob4z6hxnqqbcM2TxDkdHQWtA/IN7xh5grme2DJDeqbs5w9YgW2B134DV2n5JW4RJOqcOms65TeXQ9YPw624vraVoJ2Ntsh2IZzTVFO0AeAqLOxNGVf69GIyntV9L4J6TIiRbNTqdLhkPUpnoqxxYA1QmozlFuG269jv/OMqVhh6Tdd9VUfPaA==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:28 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:28 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 08/12] hw/i386/pc_piix.c: remove
 pc_system_flash_cleanup_unused() from pc_init_isa()
Date: Fri, 25 Apr 2025 12:37:55 +0100
Message-ID: <20250425115401.59417-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::25) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8fc600-d11a-408d-cd5d-08dd83efeee1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LuqAlN31xSjgGcmesr32zHzLyoBpTtyr4iK9Yd7Z1AndCtXNGLe46Ge6m6Pj?=
 =?us-ascii?Q?roEk8dhW2y/wGAJ+bpomAPaSvuJ1KO8+RbK/mnqZRTC6byCytP4GSYw23EEB?=
 =?us-ascii?Q?VglDhSvK0TnCUISRGqq8YK7JGCLQGlYXLVyVa5f5MuD/G84rsDcniRKfXe5l?=
 =?us-ascii?Q?fHHlsJ3VguUsYROJr80mKSa+H2QuFzoPocLINyYzdeP0/7P8p/FwihUeNsos?=
 =?us-ascii?Q?HsC+MLCqgZkcgHvwFVSrjRc0mZYNcXOn+fwjAlpuohwiGNbh4Wene6MxRjTq?=
 =?us-ascii?Q?8ztSl+ffe+mjfaLJiolR1mgOJAX6J2hE/QISDKXyoucBE5PeZj81DU+fva2l?=
 =?us-ascii?Q?rps7T407qhok4bOsJKbDNoRb9c7CM/RHRnhg2t2G9xQ6Iau5L0f03rfbBZyr?=
 =?us-ascii?Q?VJHX2riM7Wgi1hDTDMcJiK28uL6Q/NDoVme2XspxMhcjrThcOhCk1ZCnk4J7?=
 =?us-ascii?Q?YENBuyzyAC0gbiOY2QeUQ+6OVwsfv+V3ZiMuPSCC3IYY8qJ3kbfuAdDi5Frq?=
 =?us-ascii?Q?KioG1QrGBvdV3wsmmN+cved+Wns3qbMq0+eATYnIN/Ud2Rrm5oTOPhaNobZl?=
 =?us-ascii?Q?XzxgTO1hJEi8v0QwrNyLXisUygMAMmzuTXn0oECLepS6/WNCrfcvMkg1yDkY?=
 =?us-ascii?Q?1+ZbwZBNVbtUiSiOOdFqh9fyBiYKhYPsZ0kTNG8JISW/UGG+cTPVUO2Y5ygk?=
 =?us-ascii?Q?/dV7pXN33FHrqP9k7KSSXZl7XtBi92qbTvx5ERHQOdqG0pAQGDC0neMCHW3r?=
 =?us-ascii?Q?1FiwTVczJrzL3N/Xb6LVzY7dP7uCj5swe27BtqAxp3oFZge6rwuv8Z0MCK2h?=
 =?us-ascii?Q?/n3RSkdONZfpLGxaRmQYxE2vstF8x7TCGbIaKlchtW32vTPrMX6/4gTbhHRz?=
 =?us-ascii?Q?2sCCPuis4FaoVl5EkZzVvBuh7yG5CfZoB8S9qO5tYlwI4NRMs5jV3Me1RGFc?=
 =?us-ascii?Q?/gmNOhsdzGL4ftXKkn2XbVyQ5bAcoD/VxHlNKOHzKSdBY+lIWmZcYCuT2qO+?=
 =?us-ascii?Q?LkBmnD+8V+c7ts5m2eQaCk16KimuMbFqvt1B5dZ7yk7EhbIO1UmEU95XtBIF?=
 =?us-ascii?Q?BCnZ3oI6AUu7Lp+ilUycVm224hAJm3qLCn+Z038MdcrgSd21nWYyHT+fO0s7?=
 =?us-ascii?Q?Kg5XNtEnMa/XoKOhjaQ8MUmlZ+/ku9jbhVilNIi0EdsmPUGhbaQfCS4iCCur?=
 =?us-ascii?Q?pwFgfkgBG0RmrIJJCLXsTIZou+Px7FrOBVY/5CmJd1ZqopyUYQpX3IvEyw3g?=
 =?us-ascii?Q?kDGtnzUhThsKdANyJGB5azC3jdbB4k4XtO2Aq0RBcMxcE3rjv00IohZPi1sM?=
 =?us-ascii?Q?JwQdDx4aLSAq9+UuakXZg//RMO0Cu6DqvDUWQUJvdHtcGl69tfzIuip9yz8n?=
 =?us-ascii?Q?OvkGhVoNl9L7iH2UG+aIaRyx6mwDmsgQj45T8Td+cWYz4DYKbl5QRBmgoOYE?=
 =?us-ascii?Q?Rv5nodGvrgk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mUfdNTo/2etedPQ338DwYtQB3UztZEnhU9su0XScPgrkA4/uh/vWiMcYMGIx?=
 =?us-ascii?Q?zi2Mj+r9FmZin/0nb5SmkhYmb5bQgu7eA2uHL5PHjiNuZvIiE7I/vvGmePtV?=
 =?us-ascii?Q?nyxsk4oO7fetIWSX15IOBRfS7Ympr3sF7PqJyW6y0M2bCNbBIDm2kXSESbsa?=
 =?us-ascii?Q?3l86QXswIFvfvtjeBF7B4/DHIYIyfabZeekWOzY10v46G+uKT20AG9gSF68c?=
 =?us-ascii?Q?iWe+9jv27pOYiB5hW3pWrv6y6/HRccURcLQ1lBTTxRmLCDnVUIYlQIzvb+LO?=
 =?us-ascii?Q?xej0ZuZMZ2wD5LgXkVEWbWUpobK4SXiioIEtbgMiArSG/rF0m0O0Mmbfr7hv?=
 =?us-ascii?Q?lEW0AHOxZ/PQBEeEy48RYtklMC4c4ipj74WHfbxssfEDc/GFL7ew6XRa5puD?=
 =?us-ascii?Q?CYUaJIn+YSIlyWFLl7YPL0wm0ARvscWo9RidOa0NVmGlwh6OXuvWQeoNv25d?=
 =?us-ascii?Q?dWPIQuLJSksUw17NwP1I5Id84MEfh7s7lPNunN9jToD/8rOBlCt5G7ZhBdLH?=
 =?us-ascii?Q?+j7UA7cW+d6mBVdjTFDwgf+wFnO8De7Z9m+isl7YyfQaifu9XpvSv5nhPonZ?=
 =?us-ascii?Q?n00X1Mg41hHem8FvVIo++DCpS7O7Q/SUnxrsVLUkAL1GOfrBeK6dCHEVcvRq?=
 =?us-ascii?Q?PWmcWk6tfd10PuK6qI08bWL+RCEfU8kmVGCV3ST4O0W8ZAoyHE1g9+UNS1Vf?=
 =?us-ascii?Q?jvdO3SeVasOXfZi5dlbxVhWSna+93qkqFlWea4wDzzGQ55p8Tj1LF4+zr/+T?=
 =?us-ascii?Q?RP7qUgY5PEi8Ol0d3ThGMVybtZksvMwet2oMqSsYYS7Lmf4VY072V2+FUypa?=
 =?us-ascii?Q?A3UdTeLlYPBhaCOISXB/Ol997hgbqW8fO6/peoVP7KM7d2x889bxrRzUlDnF?=
 =?us-ascii?Q?TIMTHeFFx3WmTT0VM4YBq90uzvAcDPtm2DC1M/Xmi35nSjJA+kncrWuTnvRm?=
 =?us-ascii?Q?nDIM09rNwR4BQbBwC82VMeyQHeABZ3aLSCM/axqcWaeczJ+s7Ye6kX/9druR?=
 =?us-ascii?Q?lhULUO4Nji9rBYcnKVeDK41yzrOojBdMpE5b6WTACGhfj2y8K0W6NjaVqGpy?=
 =?us-ascii?Q?XaYOMs7/eoCElmYTR2FVzqNQjfUsSdHIa2ki2vmMVafQDANRspdVRgZVROdm?=
 =?us-ascii?Q?hrl6rMsxBp0R+pufba/k/VUgJwY1n5EKwKovrmsJZ5CSACHCLCjmCNCnEfJq?=
 =?us-ascii?Q?YZMmurPEG0u5p+G5fCuAUVgu82FgLz7jdIPbzHDiFxC/xoWmTyIpvzicMRvq?=
 =?us-ascii?Q?M5VPUftW6Is4KTrhOICz03jZX++wpr4Ucn/Ckh58AOvDL0EZ2fzMEW14bHNc?=
 =?us-ascii?Q?WYlrg/O/NGC6wIDwpKuBzhO6D4Ya1hyOsBtB862oxsHJ0mQczne/V9EHoUMZ?=
 =?us-ascii?Q?C73+hFUbZTQ5XXnxCwfWhvebU1DmuegKVJb/Q0BoWWWx0pjJmk+fB8ECUxtB?=
 =?us-ascii?Q?rhg6NQvx5tj4equgJAfEaWDm+6sxCTKqVZ6zeaBPNDr7w8HMjEFESqVUv9kH?=
 =?us-ascii?Q?3h7MR1xtavirtzVCpXgSqoZSDwIV2m26UhYpdbF6Ycbh+b0hj5ojD+tBeIG5?=
 =?us-ascii?Q?fUazGZRMU5x4p60YNkUkFsH1DfUedvmp9C6O9asV+kNa/UWNV2OQVwYsyoc2?=
 =?us-ascii?Q?1HoEWp4Zr44JgVVL0NWq+Kqd9JkbgA1GWgPdSToowK+dszn8afxWSTumdXIu?=
 =?us-ascii?Q?fSGXUA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8fc600-d11a-408d-cd5d-08dd83efeee1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:28.5702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X8nfpUQULjgZrmL8ksjkbHxrNXGzE8uwJnw7PJczGm0JGmYGsIOXkiXJGgOWr4AhCRhQ1iateyu0qtlNldQ9Ix0Z+oHTzRBDsDZpZHOsuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Authority-Analysis: v=2.4 cv=BevY0qt2 c=1 sm=1 tr=0 ts=680b77f6 cx=c_pps
 a=MGIL9jhmtb3Hqg0nl2vIzw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=mnHwG4yJ6Weg6gPWIr4A:9
X-Proofpoint-GUID: VjVQQIHR0zaa4-Vkal__C4PhNKY-v5iG
X-Proofpoint-ORIG-GUID: VjVQQIHR0zaa4-Vkal__C4PhNKY-v5iG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfX32ucln85ZfuS
 b73qRAsyv+mvx1LeE1o72pdtNnszM9FxZBh/r6rp2qCTGG5t/QUDVH74GmeOHABO4fazNgH06Sl
 Bqu0Ig1R45mdOzh9Zdsq6XD90GFdx483CdomTSximDHNXNHCG0mkiMfb/Ma+qBxCMLX55tfqpqv
 2VrdYwX3QR1xloLGqbT1KbPSfeMs8M2y9hMKVGVFbHBHHpqagOT4ddW5S/R0eif/kmo1zJcwNAs
 YZhmH6Mtpwjwy2sKgFOKa0gK7itpR0vK4a21hVUuKwa9f0FnQgjtq6SlYsBE6Fh4uUbiYcYzejR
 t4MX3r0MsGrTpPosqyN+sQSKGUK0lEpt9v36fNWCSVmehpnkXe8BPHGQhgiterRZO6n6Js4V2uU
 hSU3bn9fxJAb0A3yc1y4+HTH5G+0oUf1McQgGJzSQCSp0lMOOocQ9aAJoTb3xXxGYyBEkf2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

This function contains 'assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled)' and so we can
safely assume that it should never be used for the isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9c78f485dd..28e5158f5b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -449,7 +449,6 @@ static void pc_init_isa(MachineState *machine)
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
-- 
2.43.0


