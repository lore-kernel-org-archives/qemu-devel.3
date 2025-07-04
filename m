Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616DDC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh8v-0001ZY-F9; Fri, 04 Jul 2025 10:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh8E-0000uA-Tl
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh8A-0004ny-Jz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:12 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564AfNXN010658;
 Fri, 4 Jul 2025 07:11:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=j1qyzBpzWeJn6R1Liy8XgtmanxrmjNffL/fGJYcsK
 3k=; b=1MgK7k4dmU1S2ioFaVyfC7y7MwIJsr+WxGQf8DUIHWsUHVw6ixAfJYaP8
 ncclxrww390pzlu/lIFlWT8Se6yOW7atKuR46Sih6aZdSt6d/y3SvIDayiJnZtH2
 mFd90B12bNWlbtEyk6aX7Fg337lVuB3ZLzEVLh++L4fBaV06g/VbsSNr0S6VNZ9W
 shIudF2e7DRvjh2haEB5DZtRVK3Lsj1AsN69uG+UhPjgrIFnMLJbRIL7SVKVS3G3
 TSbPu4kQAJnLWPTUdJELbwlJPoCnSvls8zw15PnZKFVeQ/5cMyBqrLVaXgBYGyuN
 pWhrYLUmGaDG4NsnkYxnoMYsfzYJg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020080.outbound.protection.outlook.com [52.101.85.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47nqmnuesn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtidyZ/xgRFed8rysZiGcnQGyYAVsvdXDQol86OvJTN0UN0CeEgdVzZ2sGLYD0IZnWsvA5jRuPX9vWvlb1eOuAh24Cc+mZPAIIthdHMrfxi/Ahdj+b+Q+PLbEJVfhOrTXKLve4giqTUpt+pp830xtRPkKr9/q8TLTnoo8S9I2greHv9ATWpbvNvvOi5mc6KFGMWl5VkMNVkccaGGNhPgTh79iQvovlnz8vhj2b/yNKbs508Qv97qFQMtbOtTefliJh5PJsiSx+dXBfJ6yCqiemK2jyBrFMo9cjzjkv0wm2KmbF7p1iYeJUaSrh5rWkpIgzenyo/tmvKK0tzl0nHjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1qyzBpzWeJn6R1Liy8XgtmanxrmjNffL/fGJYcsK3k=;
 b=fC1Jl5tJqgF4zSiJ9fP/wv0azWfdfcrUU4yRnmCVuhVQ5qnVr55MJ/mJDpuOorBVWLpn4/1Loy7JawE2EWDCq4XAxKfnut/dqBtJUsAcJx2f0yaahzYa5IikPwlKnBkk5oaGtIbp90kXyNJ79kBGX9yEBvwU6xXLfKVyb6ERMAMHOF7tRO9mslpwzr0Ef5AUzufQkZ09DE5G6VmSbXrJ0l+qRkrVQAFexiUQrTYfzyKCRaNp99Unk0X+5cHsvpVsprCA/YxxQYaRasyU3uUOpxEwIqWs3vJsj6N6Coe8LmyelCutsqSIK1xGAyg1aYrsObdEEq500WP6wRCRmaFHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1qyzBpzWeJn6R1Liy8XgtmanxrmjNffL/fGJYcsK3k=;
 b=SJPp9HKEli5QxOQVbJMF4cBn/M8YJS5d+nHWmi5SGEz1ytAMvdf1OsGlsDstjPJqeCBK4ud7nwhy84eCOAtBV30k41qUqofeACEajkmPYFg9O8MBrPjz7MqkQGiTXCAA52P8a4lGhnslhcfqvVv4LAKKSEbCFdlcOpXox1YEaOyBbECtYAMNVWvF8zbtBm8+laPSEHRw1NZRslV3mgID4pvbxpyqFyU5ibd1acGYa+tT54t5n5Ku4X9wkHDBxbFa0dzOrZMUii7v0hMaMLAIjmOBd7wgWeDbjRrSSFR1l0JmgTQ2dyINEm3Oq/1qMLWRtubpHakKfRN5KcbHllSa3A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9087.namprd02.prod.outlook.com (2603:10b6:208:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:11:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:11:05 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 12/14] hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in
 pc_init_isa()
Date: Fri,  4 Jul 2025 15:09:39 +0100
Message-ID: <20250704141018.674268-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0002.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa5132f-d997-44a4-c7c3-08ddbb049d89
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S240V3dUMVVzMHVXemNZYzUvQVg4YVlDOEVRUTVTc0FoZWp5ZlVraG9aZ0xo?=
 =?utf-8?B?NXBGdklPVVBLVTVidmlMZHRFeStNZmxBbGdvamxnNGFkV1NGOUhXUEZ3QWt1?=
 =?utf-8?B?enlXcFJnQ1FXY1Q2eFNpSXJVakV5d3VNSkhQcUpvYUd0RGFsTHRRd0lrbUFG?=
 =?utf-8?B?bU94TkNPa2xaN0hucVNwYWZ6YUcxN0k1K3hzam91aWFVdkVUeWlxTGRPYktr?=
 =?utf-8?B?WU5kT3VVZTlSUXNPT1BUZTFjdXgzY212eEUyZGZlM053Qlo1NVFNNVBaVHU0?=
 =?utf-8?B?SFdDVTBlRXppWXcwQkFoNHlLOGs5blpDeDVHcks1TWs5NmhIVnFQR011bmxE?=
 =?utf-8?B?UlFIU1FFRm5xWjF1OFpMam1uMStWQW9PVjRKeVBhMHd4b0NHZGpaTVd0dDVY?=
 =?utf-8?B?UmVkeEgwMlh5cmk4Vk9hdzZ1WDMxVkpoU3AxM2NoQ2tFaUJSeGZnRU8vRERr?=
 =?utf-8?B?ZlhZMGhzS0NWWkpwaGxMVkljbWg5c0pzVTlFWGVWRkFGU3ZnVndPRk5vRjBa?=
 =?utf-8?B?TWl6VS9kV3BGZGxTcXV0c1Jva2NrWDFRQVA3bzZ4MjYyZTRZWU5SWDFBbFU4?=
 =?utf-8?B?L2hHTzU0bjE1WnQ1ZWZibExORy9sWmJqOVExcklZN3RMYmtJOW0rSS9MYjZK?=
 =?utf-8?B?WjUvU0JncGFJMjRELzBrREgwOERBZnkwNWY4bEkxaW5weWtsTmI2eEt3aWhG?=
 =?utf-8?B?a0xOT0FvTHJyWW1maEZrY0hCRUdVQnp2UCtIT2tVSWt1MnREVG1sMk1HRWlm?=
 =?utf-8?B?ZGRJN1d0MGpLZlMzR09pSnVYMno0TytpckV1T3psd0xFTGRpMHNJb3RPazJV?=
 =?utf-8?B?R1hKUWVHMXJ5dURBaFMxR3pKV09tOFBpUVpNbDRZUmF5YnRKdVdFQy9GalNF?=
 =?utf-8?B?Y1dMYUhQSEYveHNpTDRkNmVyNDBidUVoeTM1SGs2NFlPYUl1SG4wUzRKcTJy?=
 =?utf-8?B?dHlEVjRzeG1lNDRvbDlkb1RyeWZFbCtrREc4SEo4RHZjMkVUZU1VTVQvM25z?=
 =?utf-8?B?bzVvMjVYaVZKSXBtR3FzUnFMbWVKWmFNczg0ODhYNDFORGJoNG8wYk9BcVVH?=
 =?utf-8?B?bVN2cGNjeWNNYmpBVElUUm8zajVhSUw2Z0JWSXBkT3lmV2dmeHNwNXhYNWJa?=
 =?utf-8?B?ZGp4dC84MkpIazFPdHY0aUkxVm10TjI3ay9xTkhQTW82dkVCVzVlTjhXcUxu?=
 =?utf-8?B?OGJoTGJaNHhnV2lHNW92MDdVZm8vZERLMWg0V2tYZHF6cm9HYnh3VDVKTWZp?=
 =?utf-8?B?NE9pcGQ0Tm1iTXJpRTNCanNQbjdZTVc3QTFtTE94TVQwcEo3aXhUKzJqL1pJ?=
 =?utf-8?B?bXdkWUVpbXplRll3ZjFmUTN6TjJZblVQMC9HVmdzRGVrb0NMaHoxVFlmUXJu?=
 =?utf-8?B?L2JoUlRtcGhLcE91QVN6b2F3aS9wVkV5Y2h2M3NLMGRFVG5xSWxya3M2SDJB?=
 =?utf-8?B?aEpjSGFkcTUvQkdkaW80UzA1UVRnMzZBL2VRRlpYWVY4MVJyNWJVbGpnWmVa?=
 =?utf-8?B?czloendEcS9tSGpDV2NFRWtQWEkwQ0VkUU9RbkNaYkcybEptdVdxdXN1aUFM?=
 =?utf-8?B?LzlVT1BhKzkvY0E0RC8vTi83WXFLWFpZdWl6eFdISkhBWVdKV3NBRjQzeGxJ?=
 =?utf-8?B?dVArN091NHQvVUxKWC9wNis0RnJkSk1iNE01TjhkZUxuK0lSVU4xVThDbTA5?=
 =?utf-8?B?ZXI1eVo0dnVQT0hNY0FoODAreCtLZmtUT0V4WENuUkFVaFZIenV2Z2Naa3Z3?=
 =?utf-8?B?UjlUZ2JBbkxjazY2VWd4NnNtamZ3eEpHUXhaalhYb3BEZm9DUUMyMUY4SkUx?=
 =?utf-8?B?MlJ0eklzY2hSSjEyeHBvc3EweFdIZkJ2YWI4RXE0dDlpTXBEb0lhNm1lRUpo?=
 =?utf-8?B?NkpyWHQ3WXlPaUVDTDViMUJYTDFva3lFZHc0Ykpra25iR05JR29jYm4zL0pC?=
 =?utf-8?Q?ceLqrIcJrA0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U05uV0grN3JzWWRsaEovdmtZa0g2QmYzaWxNY1JGckUydkwyWERUaU1vS0dy?=
 =?utf-8?B?RU51ZzR3VGZCMS9hSFF0VEIyUnhHZURHY3VGMVhybGVVMWk3c2d1c28rM1F1?=
 =?utf-8?B?M2N1LytxQVpxMFhDY1NzUmpuZWhob0puWFIrc3VMa295Y0FlTnVwdzJoTjJ3?=
 =?utf-8?B?dGtPNkkzNG01ZGZaMUV5WWVhN3B1UWt1emtFSlFWS2loN2IvaGFMSlZsU2cr?=
 =?utf-8?B?ODFha3lDUFMxQ2lwMXFhem9OU3krSldWQ2RUWlBEMDdML0YxanJnTDM5QjRG?=
 =?utf-8?B?MG90S1VKb2hBT1JxM0NxcjJ6V2pHbmVxdGVMN0ZjbGV5S0NwczdrL1BNL1FV?=
 =?utf-8?B?a0JTWTFnY2gyT2NjVnJRUnhOK2tibGdoQTJxTmVKQjRneUVDRWhXbFVESXVS?=
 =?utf-8?B?UENlK2NZZ3VwOVozL2h5TnJQaUdNbUxXdHVIMVl0VlQ3dU1taCtpTEJNSTRM?=
 =?utf-8?B?b0g0aTJVTEpnaFZXZmhrQzJiRzgyUWdoOTZNTWg4TjZrU21ZUXA4MWNEMkdV?=
 =?utf-8?B?SVNGSEt6dFBFUUl0V2tNWHk3cUtWa0xJWmg3QVkwcmpNQUd5MEhwVi9RT3NX?=
 =?utf-8?B?d2FkRmdnNk12alJtRGh6OG9KU09tbkd5KzgvQUlkVkp4S3gyNGNtTDdWZFBz?=
 =?utf-8?B?ZGpxbnVkcUhLSkJwV3NmZDJrcVRVUEdHcHBwOEo2b0xpUXJMcjlIMDJqYk1p?=
 =?utf-8?B?am1mYytwb3phclFVUVlWaEF2WmNWNGJQeFdYcjlBY1RXcnJYYU1jcGRGQmZW?=
 =?utf-8?B?U2xYK2ViNEFNWmZtQ1JZcVc1TzFQT2JDS3ZpOWlkdkhFa29oZFJhNC9NNDNR?=
 =?utf-8?B?NFBqWlhtdzQxbnpFdmhUWm5xTE1pRnZ1K3U5QjFrMWhSdHJGR2MzTTl3M3l6?=
 =?utf-8?B?aDA5b3JoaFQ0QmFFa29qc0MzTEVCQjF3SEt6bzU3UkQxMlhzdUluc3p1Nm5O?=
 =?utf-8?B?QkxKUy9BQXV0bmxMdmE4TmRTc1NhWmFXQjNjNlZjU0Jjb3FhVDFQSFZ1TGFT?=
 =?utf-8?B?UG9QazY5UVhldlVaSGU1cTZ4emZQc2JZdWVoMXNWSFVHWmo4dXNheWVFM1p2?=
 =?utf-8?B?RnFSMktqVzErbUNISjJFRFA2UmVrSWphb0NaUng3bUZQWDNQTUlIK0t3eFdM?=
 =?utf-8?B?ZGhONHJWTTdJTklBVVRTNTBkdzB4aTQ2VlRCYmNBZVdUMThlYU1wbmxZYXF4?=
 =?utf-8?B?ckNpN2c1a3FCMHFDTGkzWm9LeElZOUZlb2dSZ0JYdnY1cjZMUVdUZ2hNZktj?=
 =?utf-8?B?aWZyZ1dicTB0R3F6aU9WTUt5SWtpb2Z6ZjUxTmF5WHBwUUllOWVyb1RIQXNQ?=
 =?utf-8?B?Y3dleXhFSjc5SUlQUFZZbXJjbFNmeW5NYTlqL0tRMUFEc2pZeWJOY2l5cDNY?=
 =?utf-8?B?bnA1OWhmS0kxVE4xQVhlWnQvR1lhWGFRY2NibzZDejVJN1cxYWhrTDEvdUZQ?=
 =?utf-8?B?NHZDUkNOdm5mT0Z6UU5jS01nWUNhdXpzSExucEdLYW8vcVZPQUpDR3YxS20x?=
 =?utf-8?B?a05iZmNrYm12Qi9iTWMxVTh5M0FsSzArY25jQnczaGwxdTBzcXR0SFdIdTB3?=
 =?utf-8?B?OWp6VThmcnVxSHNhRVROa3hJM3p5K0JtUGJWRFJIMjlwWU8weWlHMjZDaDRS?=
 =?utf-8?B?YzR4UHYzOFRkNThUUE4rN1NUSnRDYlJrMXg5Tjd4QjZKVmxyQTFoVWxNV3BH?=
 =?utf-8?B?Z3Z0dGV4bEtIcEpUdjNRVGFjZjh0ODJST3ZyQUtkdkVTLzA3SkRwaXF4a0hV?=
 =?utf-8?B?ci9pYi9yME1mWjZQY1FTdlBCbkhadzZjTTVmV1pGdTg4RlVLV01WWlc2WjdE?=
 =?utf-8?B?YWJvR1pvMUNCdFUzbzVlWWlHSUhOdTRkdTZ2bTgrenlaaWpnOElVbG85S1Za?=
 =?utf-8?B?MHROUzJxTGtLd2p4NnRjR1BRbUcrZk5zY3NFTUl3YlVacFBWbHVYNngxcWpD?=
 =?utf-8?B?MXoxdjFPa0tHazFtYW9JaS84dnN0WGpuMjZvdm91WEJnMFBRUkhETVB1OWlE?=
 =?utf-8?B?R0hyc0t3dUdaVnJyd3dUWm1rQnd6YUFyQ1ZuZDA5QVdiNTNvUEpqaUJXamJK?=
 =?utf-8?B?QTl4UWh3dVZXSTRRUjg1dUZ3bDVVbUZJZWJLaVQ0bENweUtlS2l2Yk5qNHA0?=
 =?utf-8?B?Q1kwQ0JabWJCTFgrWkRFOW1lQUk4R3VKYUwzMG9nQlBJQkR3M25LK0EwdkNl?=
 =?utf-8?B?YlZUSGk3cU4zQTBOSG1zenExT3RSOHNMZFIvVVd1QUxpeE1vVXErUHl3NlhI?=
 =?utf-8?B?RWRXQUVDVnpuZ0VEMnk0eEkwL3B3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa5132f-d997-44a4-c7c3-08ddbb049d89
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:11:05.4687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLWADZPc4Ca3fcTNVrQQ6wcLhiSb60o74c93zF4zxoIomh09svj408ActW+xq9M45fHGsnVcd5AujkqpYCAe23xh8zhSKOVyyp/k2aRwiTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9087
X-Proofpoint-ORIG-GUID: MmJLhz2a2teV9MMeufOVZ-92B-4FTiLM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX1p25YGGjNHyf
 ZNPZpumF+EtlZUDmUN6PFV+T50+tQs1JRiXf2ccI6ptt9SfEfF+DAcTzR+EhedMwySiwRVMRLTz
 r7BjfZY9Gl3j2sM01DArmEyKAWAwDyZFucwsbsaTG1sEgFnEQRPl0HOX7Kdt5Ic79hjrjcsQCJU
 7b95g4Jz3L2d1Jb3dxv2X6xFAWn6DCaVZufZn1kJgqLCnE1pHTOp4IZP5FQt4xj0zyPZghWzVzX
 uuSgjpmNOWMpwvaiQT2WjYADmbsdN6ZER12vyR3Q4sYtg6TIeRoWV9cqWk7iqXLh085QFjIknHO
 ekDK9SONBthUDcr6PT3LOk2IkUEp6ijDcz4ONC3w1euc1KSQe5lUR/JwVZA4nXl0wthiijgxFbt
 SlQZ6GRYAiES+vjz1DCL+eE6en5StnPPglldQ50+1Mn/qZ5MUQu2yLWAFxEBlDCFs0O+zfgW
X-Proofpoint-GUID: MmJLhz2a2teV9MMeufOVZ-92B-4FTiLM
X-Authority-Analysis: v=2.4 cv=aomyCTZV c=1 sm=1 tr=0 ts=6867e0fb cx=c_pps
 a=GE11VYRMVHt3yMfnQg1OWA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=m4-MuDShih0a2sssyXkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

By definition PCI can never be enabled on an isapc machine so hardcode the PCIBus argument
of pc_nic_init() to NULL.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4e3fb17506..76b8543bfe 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -501,7 +501,7 @@ static void pc_init_isa(MachineState *machine)
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
 
-    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+    pc_nic_init(pcmc, isa_bus, NULL);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
     for (i = 0; i < MAX_IDE_BUS; i++) {
-- 
2.43.0


