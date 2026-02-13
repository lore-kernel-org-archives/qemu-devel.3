Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F0EEDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 16:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvaE-0007U5-6H; Fri, 13 Feb 2026 10:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvaC-0007Tw-HT
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:59:52 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvaA-0001eX-Lx
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:59:52 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DFxl1u1408588; Fri, 13 Feb 2026 07:59:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZPIhqHDnPFf25THKzijO+XWTeZd461nFH8SyOdjKL
 O0=; b=JYplWtPGzRQ3pCMA2rehVB6cZRLAP3wEIlfukJgcDoR1r5cSBGjnZyIB3
 Qfl4PKo+NUehGCyHMqAuUl2QjP8iOfvXIasMH2DUwQ0Fh9p72R6nGeKBxgd8Dbh6
 UE0RITsrGJd2RFhLBqn+jVNLb4pLHlVWImJX9p4aYwHWQdFudCZ7YKRbtB9cnI4f
 lU6NVkePLkILkxtfipYci+ZP0mEKJHRzqawzbB+vEx4achIBYkT0KaC6Q7qaWH3S
 94FC+uzoWHdzBjfK/XQo5DGDoSAHSdbm6J1smv8eLF+7i79sdKRaUxdIpv3y3peW
 BGBM80OjWzCj7/saOahgqIxxp8e+g==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023132.outbound.protection.outlook.com
 [40.107.201.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ca738g00b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 07:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ke+aIZElLEd9c8N8RcPtZnuf8NSqnYiFVIcnW+o1YGGQtc9m7XE92Ib9bte3HHiAfGVnhuIFfcV7fXabnFycHvhHcTRVU1t8V8UDp2l0pN0/9a01jJgf45RS01Qqsy8TeqsWTvQQDrprOI4/WA398ETGvvKzTXjBEnO5+IinFCq1CRHY1XaZb/fm0GrX3OzG4r9C0MIQnbIN1bUxgB/OjQMwkEcN9nHPZWXbhTxBfI8nL4m0gvOVHmazq0b8XpZunyHhx1UreFlnWP6z+3hfPrxRFyMu8jXNb3CfrV9OhUB0vQsYCezEp9SWM5E7OSABRwVV3ye5QGon+8vdi3i4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPIhqHDnPFf25THKzijO+XWTeZd461nFH8SyOdjKLO0=;
 b=MyCe0iZlkhcGI/F3TZWqMFTkepc3A/3y6FDNQpnjMvsBb4lo8D7sDA7Npq+0ZhPpV0tMVgFWNiOQJ9pSMzcs4F1NO8A8dJJ1hHU3PXoS20KNlFO7SkWPsokTcMK6qdo9Gs03MEzq6PlFwISaei9S3QNplsFzEsew3OJUkQDOQJOooBaAVe7am257Z4f7kAbsWPaJWhJeEVnCzAAQs65G54T8fGkbyjh+VXCbAwc4to58P9krGn2btFyLq30QXPnpGJBDnzEhsNPODN69HyzM0/X2wsxwSNtY0cfWvfOzfCJhwZoLZH3M0FVBqmgsTjzR7NDoBaJyUvXhAalRLkKCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPIhqHDnPFf25THKzijO+XWTeZd461nFH8SyOdjKLO0=;
 b=QOucctlWBeMqhh8L8d0zc3CmHS0yc3xZVztTgrA8I6Oob2BTjltDe2a6sHmyKc6qdKeAptvZesgtpEm92M3/Fn5URBSmuMP9CORl54YaTxFw9vATSvbJM1MfqLUxW8L2NEf5g3tzQN5gxMWZsAm0VPnCzycZIykaG0sSzTMHWpbO+BhboYfmB1v67nl0EcAyx2jUf/DUgH0m9Eq4p35JaZP6nQKSY8vYujFpeUTOnCSr6qTwrorwylvIIKYEGvMudG5O4Z5W8CGkWWCU56TW3YRT09LVgD9MYyH9RrqkBv2F41tmMbgIB+bLvJTFrBLV8IzdwpzVqKFIZeRRcN8P8A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB7866.namprd02.prod.outlook.com (2603:10b6:610:ed::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 15:59:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:59:45 +0000
Message-ID: <356a535f-98fd-48de-9d04-52de559e8380@nutanix.com>
Date: Fri, 13 Feb 2026 15:59:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/43] audio: rework invalid audsettings error
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-40-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-40-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:610:51::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: bd39bfe8-426d-4e79-814e-08de6b18e818
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dy9oRU9UVi9WektTOC91TzJMb0NpZC9BQVJqT1B1SnBqdTU0aTVVR2s0NmNh?=
 =?utf-8?B?Y0FWajV5Wnl0TWlXRDBQaTZBUXVXNm9scnJIb0NCMExDb1Vsb1FneklCTFZp?=
 =?utf-8?B?M3pKaDcvMWw3TkxGcXhKdkYva1NNTURua2lseGphNlZPWDNwTjk1cXpaMHVN?=
 =?utf-8?B?SzYyZitkSlBNNzhpRnVLTG5YSTJqTS83elBLNFNkNStDa29lNnE2QXVGSzZG?=
 =?utf-8?B?bkFReDNOamJvRVRHQ2sxQzAvcmpvdFJZbEFqOWFHRzRDY2VRK0M5L015dXZS?=
 =?utf-8?B?c3k0K1FBcUNpQWlVZFo1UUpMV3lIdG5PZXVPSUlqcnJlTFFlc2YvdVdUcU4w?=
 =?utf-8?B?YVJJd0VMajhzTXlCbDc5elh3cGp6SEJ5OGpOTTV2UTcrSUYwbUJxVlp2MERR?=
 =?utf-8?B?TXFxYVdqZ3J5QTVuU1Vlc0ZCTVA0ZDkwOFgwMGU1V3NEMkhLTlVDZTRVMGtj?=
 =?utf-8?B?eUlqR3d4NU5TbUYvWFhUb293Uy9CanlhOWFCVm45NDlZNW9QaDlUbXdWTG05?=
 =?utf-8?B?YkNPSXE2M0pMZ0RDUkRZeTJCaVVhcTRlaHRqK0FTbDNGN2ZPVFRhdFZYeTNx?=
 =?utf-8?B?LzFvNFV4NEUrVyttbnRvaEdTclFKL3ZSVGRpUFdObC8vVFJId0F2aUxFREpi?=
 =?utf-8?B?Tk1nOTFDTkF1dC9DTEN1N2p1bnE5TEh4NWNSZVJsNm14UWJ1YWZPL2JWcjlL?=
 =?utf-8?B?T3VjVEtXS1VLaTk3OFpzRVpRbWp1eVJmTS8rVCtFcWhPNE9LYklGQ3FTVWdG?=
 =?utf-8?B?OGxQT0kwVThSYkVIbWRFOTBDeXN0ME1HQVhSMGx1eVdQby9Pd2V5MlBieHEv?=
 =?utf-8?B?Q0NmNm80eGNYWFZaYlRiQ1JpZitNdEdsNXlGZWVTQVRsME5CMkN4RndUaGJS?=
 =?utf-8?B?KzBpVzNOK1hvY1pucGxGUFI5R2FwZzcySThVZFNLeEt0SDRpam1GZ2RXZEgw?=
 =?utf-8?B?NExtWXJtNmxCaTloK1hFZHhjTlYwOU14NFlwaXVTMzA3bVF0blNPY05JUWh1?=
 =?utf-8?B?eTJEUy9KRUxvMTdQVGxNd0t2dUZyZkJ3aGJBS3Vtcjl4V2pBRE9Bc3p0ekUy?=
 =?utf-8?B?NWRFVStMUjZFRjNxYnQ0ZStHSTN1c3pKZDhza1licUkxbnVSYVovZTdiKzBP?=
 =?utf-8?B?NG8rTzFSUzdMa1Z2NzMzTncyclVsaGR3UjlrZUxiOG9xMjUwZ3dFbmYxTWxD?=
 =?utf-8?B?SG04clpqZ0IrSlFsM2RoS1VsTzF6akswSFowd1ZFTEFwMTNGV2YrOHI5S2lB?=
 =?utf-8?B?eUlJVDYyOW9ZMk56SFJFQUV6aENXNlZNNmh4VXQrVEZNQ1JURjZmZ293UkxY?=
 =?utf-8?B?N1NxbE5Rc1hvY0lDamM3UWQzcFpxWFdyTW5Rb3ZmMU42NGpVbHdvSFhuZkZ2?=
 =?utf-8?B?T1pacFloL2dwSUd5Rm1uU0RhUllIRjJ1MytvZW5QYU9lZldSaTd6eUpWak9Y?=
 =?utf-8?B?eUpJd3l5N25Ebm8ySUlyY1g2VS9ZWlZMTjFFbm5WVUJGaDh4YysvSjBpb2NE?=
 =?utf-8?B?UExJMWtLaFRZQmsxdlhBWUllQnJjNEcvSjRCemYvakpOODYyWDhBclZ4Rk5n?=
 =?utf-8?B?TVdFbzNvVGQxRmtVM2NEdFArVlNybGE3WWRjV1ZwUzRrTU1TNWZqK2FWZ01P?=
 =?utf-8?B?cXhKWWhoaSs1UzlvYVo1VDVjL1gwT2tlbFh1eEl0SUQ2RGJkdjVMUW5zb2NV?=
 =?utf-8?B?Njg2U3oxYjBtMHprYVIvUlpTZGljTkFJeXl1TTcweDZIbjRKWnVmQWpPSVBp?=
 =?utf-8?B?b1FBOURPVkJBaVFRUzBFZlpVM0JiQWlQWGJLVGlKWHgvL1VHOG9Ya25DNVRN?=
 =?utf-8?B?OXlsblI3c3gyZzZNTk9CL3RMY21vL1Q0aVRzV3BGMkxVWjd6SFE2dC9FSDlr?=
 =?utf-8?B?ejlIVGdpbHRzYmRiWGc5N2xDTVkvUUZveHRaTGxwdVU5dzhEU2w0ckVTM1lo?=
 =?utf-8?B?S1d2K0pWMjBsanl5RE5pMUgwaGpOQUp0OEFZZ25TdStPMis3SXMvRVo1UUJB?=
 =?utf-8?B?NmhwZko5a09PMHhTeTJCZXhIamk1Smhia0RQY3pxQnpFRDUrdm5VL1QyRGUv?=
 =?utf-8?B?TkZGZStFcmNGNGlGZlg0ZEx3QnFPVzdVL1VzY0JHS1lWc2I2WjM5VVN4UEZW?=
 =?utf-8?Q?xExY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkZJdjIwcFBrOTg2NmIxRUlnRytQdFdzZFczcEY3dWd0REpDK3hrQUt2cExO?=
 =?utf-8?B?SG53N3JZNDVGNndUSEpNZkNUQUozcmlUdU94dXU5cHNZdE1zTmJXOWs2YU96?=
 =?utf-8?B?NjFkTllWaXBSRmMvbjNGZXgxNjJpSDdqMUZQZ0pGTjBDYmJDTnFzOUZWWWg3?=
 =?utf-8?B?Y01MbkNaMGhzdUJIamtUWDdCbGxPcmhPQ1ZpakFoYVNNSU8vWFMzbUcxZ2JQ?=
 =?utf-8?B?cSsrcm5KRWhmY0g5VTB4aXpZRk42elVURDhydGIwYkRiN0lEeThkOTVKWXNN?=
 =?utf-8?B?azB5S0NoYkxGbUI1S2NDTVlFS21DNlovS2tBQjZ5cTg4MWV4cXc1M05nZDc2?=
 =?utf-8?B?Z3RZekxZQ1NSenBOWnh4bG05SXIwWjhmbkp6VHJ3aVAyZlRrRWcxdzJHakZI?=
 =?utf-8?B?UUtDVndhSEd5NTFId3lsQVVwVEozVDh4V2J1YmxyR3dLZmZCUTVKR3BLbUMv?=
 =?utf-8?B?dGNjdFVmL05UcHJ5azNpMlkzejFmWVQzbDY1VWcreEVSNlRIaHN0SmhKQkRv?=
 =?utf-8?B?eTlmbldRdWZ0YitRekJMU21wNitRTkV4eFZaVjRxMEM1VGdXZFFOQ1NiNDBS?=
 =?utf-8?B?TFlmaVZTdnlzYjNwUHFwQkNBUGxRM0E0MnE4dERLaTB4czRYdG1FVXNpalZt?=
 =?utf-8?B?cDlnNEs1WGtPUFNtRWdyYlk0TExLQXE1K3puVVdLRmF5MkpOWkJ2OWFJcTFW?=
 =?utf-8?B?RE0rRkwwbnJ1eENkSXlFUUluK1RhNE5MdDdCSWRObTlHeFZFamJYQ0Z5b2ky?=
 =?utf-8?B?V0lyYlIzbGJDVDdaSkFCdlJFUmsyZkcwWloveWRBNHJBRTJJOGhqQ1VEM1dI?=
 =?utf-8?B?SFBhWlhDMVppcVpPTFN6TEZBb2pzbDY0RE9lVWJGNFA5L3o1bmNXY2NISGk2?=
 =?utf-8?B?ODRqUmJFQzNoU1dOd1JJd3dubzdEZVNrU3d0WUhJY2RBOWlXT093QTk0b1BO?=
 =?utf-8?B?NUlTekFtY2Y5TThtUGMyN1UvVUMvYWlGMndTTEpvZ3poOVRZeWVYc2F2S0FH?=
 =?utf-8?B?dzhGTmhWUGc4bW9rT1dHOTZoQ2FVV0RuMlgvRmYrL1I3UWV6NnNheXJoMmd5?=
 =?utf-8?B?VnBhVjdjUGl6TFovOEJmd0NZdVFIUnNpMzlFMmtPUkpJTFJtSkk0cFNUb2VF?=
 =?utf-8?B?MGhWY2Q4T0xaUzhVY01jZVkzcDRBWmord0dwUlBTQzV0NWZzcFN5ajhSYWRV?=
 =?utf-8?B?ZEYwbjI4WmNlVE5zc2tVaC9NOStuY1N4ZlNVa2N4bElHSFVWOTNTZCtrQTZr?=
 =?utf-8?B?SkxXaHNWU0Z2VTlsaXRGRUYzTG5waGxrU3FKajh6MTdERmV3bjdxYVFVNGM5?=
 =?utf-8?B?NTh0UTUzMHJHczlCaTFIRWM4cnBHRGFnSjY2cGdzQytQNnlvNFpVRlJtc2dS?=
 =?utf-8?B?Rmk2dXU3V2wzL3N5d21iNXB1RCtNWVhwc3NvaFhpMGRLc2luS04vVEpkcXhB?=
 =?utf-8?B?NUxXWDhMSFV4VXMzcnFhc0xaMG0weTltRUdnV005TjAwNzM0MUovTGx1eERN?=
 =?utf-8?B?SzFxTjh3MllrQzJOcU5ERUtHTGdDVDlBRm8zN1ZXZXh2ZnNDRGZwMFBkRUho?=
 =?utf-8?B?WG96cWNvLzFnVE5iZ3lPcGZhMnlxRGhYS1FNZXU5Rzk3MU5OMnVBN0kyYXpi?=
 =?utf-8?B?dUNWbXltaGJ2M1lIc1UwRC9MWXRabzVDTStXeGpKYjg2TU5rZVN0YkZMTURJ?=
 =?utf-8?B?UllESjlXNmZGZUtzR3J0c0xBMFZpbjFmelpNUzN3S3pybWgvd0MzUmU2T3JC?=
 =?utf-8?B?ai90QmoxSGJ6cUFxdE96UzFHTXRVL0FCVHNMQkRYUWtGV2lwaGswcU9HVGxE?=
 =?utf-8?B?TmdUV3p2UWkyd0s5VjVIMCs0eTVsMWRVVlkwUDlDWlpaTUV6R1lMQUpkM1Ix?=
 =?utf-8?B?elpJVkI2YjBHM1hvOVJreDYrZDJMY3FUWDUrVW1MRWx3MUNmTDFFS0FseGl1?=
 =?utf-8?B?a3pmVUp4TVdnYVo2YVZoOWNkbno4eEJyajFiLzVnL3NMWTh6NE1na0FXcXI3?=
 =?utf-8?B?Y0t1aW41N2Y4Mk02REpLQUlaQU1EaEhDa1FWTit2b3JtQzA2UFRLUnZHbkR4?=
 =?utf-8?B?dTlENlJ1NDZQQUh3cWRxMkNnS3FXN2JZdzJ4R1hBanF5RzB0djRtVklxSjJG?=
 =?utf-8?B?K3o0cVRuOHdHZ0xyZ0d0VWVvcW9HTjhQazYwK0hmdHo4QnJHUXVYazExL1ZG?=
 =?utf-8?B?aFlzM0c3eWFQcDhkVGpPc3ovbVVFT2diT21qVTBGTElPd1pqclJYMklYeS9V?=
 =?utf-8?B?cWhOWWdKL2FRdmtoT2h1VGNiZlJISVpWS0lwc2xWTWx1NjBiekliOWhyVldz?=
 =?utf-8?B?UVdacDJRSU1VR3BSTWZQenY3c2xVRm9qVU9jeEx1RlZTRCs5dDE0R2dGUUxr?=
 =?utf-8?Q?Y4QKptuN8pGoqz3I=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd39bfe8-426d-4e79-814e-08de6b18e818
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:59:45.1592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUSPyeYHwqvhHsbRuCz9f4MgItYOQatQbr7faMV4cSVnf08zDwhqT3pkGIaMH7QwpxmLipFOWP9+awED7p1S0xgTqgpRtvmpWWaIFBRyF4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7866
X-Proofpoint-ORIG-GUID: 9__Y40pnvmmF2QDnuk35G77vLmMu3qyu
X-Proofpoint-GUID: 9__Y40pnvmmF2QDnuk35G77vLmMu3qyu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyMyBTYWx0ZWRfX/RWHJjFsl2GN
 CiVUc5oO9EG4mR79bN+1dQNRW9liP7MCMplTV76fBAWlSc2blvKQ/IGAifPQ1kLhGLCXqPZI0Dc
 8tigWJ8fg+jsOgRTjfRetFuqRHXS06FbUPPlzNG8L4TBdlQpEzGb+eEqtrgschwgBmBQPndMBNW
 a0jyC6gTc2kHecZEBVf2wQW9WoR5Wqh/VjSFjYXAOiSzyoup490kpKtf0Ov+iWj9YIMfv2EknYp
 d9ksRZ0MVJup4iG0RMgSAS1q0Dq7hJC+u1RZa7LCmPIy4wlh289NTGWZ689Z0qk7H6FWtodM1i5
 p53hIQEczLaJHAwT2VjcC+DtmMpMpzKfKX1RU+8Os40q5yH45NjoL0ZCuPfM46PfvodCjF0sXCZ
 HTz0SQpmTmJk1ZeLpYGSrnx/a3mzEyuiwyoDMUuKdsMaNcDK8TXzqCQdFEcJXWu4cu6wjhkwAQo
 XE5QlAWT0H3qM2xe6QA==
X-Authority-Analysis: v=2.4 cv=Xs33+FF9 c=1 sm=1 tr=0 ts=698f4a73 cx=c_pps
 a=QUIaisbnC9uoo+9AoKvuvw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=5clEi3or-kwTo0ZxJ-IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Currently, when given invalid settings, QEMU will print to stderr:
> 
> A bug was just triggered in audio_mixeng_backend_open_out
> Save all your work and restart without audio
> I am sorry
> Context:
> audio: frequency=44100 nchannels=0 fmt=S16 endianness=little
> 
> Now it will use error_report() and simply report:
> audio: Invalid audio settings: frequency=44100 nchannels=0 fmt=s16 endian=little
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_template.h  |  5 +++--
>   audio/audio-mixeng-be.c | 41 +++++++----------------------------------
>   2 files changed, 10 insertions(+), 36 deletions(-)
> 
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index e884c8e9b1a..5711f4a26e1 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -513,8 +513,9 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>       trace_audio_open_in(name, as->freq, as->nchannels, as->fmt);
>   #endif
>   
> -    if (audio_bug(__func__, audio_validate_settings(as))) {
> -        audio_print_settings (as);
> +    if (audio_validate_settings(as)) {
> +        g_autofree char *str = audsettings_to_string(as);
> +        error_report("audio: Invalid audio settings: %s", str);
>           goto fail;
>       }
>   
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 5165768a531..e8fae2ab977 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -101,38 +101,11 @@ void AUD_log (const char *cap, const char *fmt, ...)
>       va_end (ap);
>   }
>   
> -static void audio_print_settings (const struct audsettings *as)
> +static char *audsettings_to_string(const struct audsettings *as)
>   {
> -    dolog ("frequency=%d nchannels=%d fmt=", as->freq, as->nchannels);
> -
> -    switch (as->fmt) {
> -    case AUDIO_FORMAT_S8:
> -        AUD_log (NULL, "S8");
> -        break;
> -    case AUDIO_FORMAT_U8:
> -        AUD_log (NULL, "U8");
> -        break;
> -    case AUDIO_FORMAT_S16:
> -        AUD_log (NULL, "S16");
> -        break;
> -    case AUDIO_FORMAT_U16:
> -        AUD_log (NULL, "U16");
> -        break;
> -    case AUDIO_FORMAT_S32:
> -        AUD_log (NULL, "S32");
> -        break;
> -    case AUDIO_FORMAT_U32:
> -        AUD_log (NULL, "U32");
> -        break;
> -    case AUDIO_FORMAT_F32:
> -        AUD_log (NULL, "F32");
> -        break;
> -    default:
> -        AUD_log (NULL, "invalid(%d)", as->fmt);
> -        break;
> -    }
> -
> -    AUD_log (NULL, " endianness=%s\n", as->big_endian ? "big" : "little");
> +    return g_strdup_printf("frequency=%d nchannels=%d fmt=%s endian=%s",
> +                           as->freq, as->nchannels, AudioFormat_str(as->fmt),
> +                           as->big_endian ? "big" : "little");
>   }
>   
>   static int audio_validate_settings (const struct audsettings *as)
> @@ -1607,9 +1580,9 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>           return NULL;
>       }
>   
> -    if (audio_validate_settings (as)) {
> -        dolog ("Invalid settings were passed when trying to add capture\n");
> -        audio_print_settings (as);
> +    if (audio_validate_settings(as)) {
> +        g_autofree char *str = audsettings_to_string(as);
> +        error_report("audio: Invalid audio settings when trying to add capture: %s", str);
>           return NULL;
>       }

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


