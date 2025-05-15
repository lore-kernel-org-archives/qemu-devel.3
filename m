Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F0BC3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFan9-0000r8-RI; Thu, 15 May 2025 11:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFala-0006OB-8E
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:04 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalV-0006ED-CM
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:01 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FBPdHa007971;
 Thu, 15 May 2025 08:44:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UH6f2tmI7ATg3KzwM9TyWxj1523guBD6/z5O7cFLN
 GY=; b=zeBLZ6kWVNx0dBoJSTKY6ofThymmBqD/X8j9ELnN6mb39LhxCzYXY707R
 V6xQvku4kIdrSmI7bcTWtD61ZH8mwpFmtE7FaZl6NepoBmgfGoDd17J4rf7vxZU6
 qMs92XyWzpit0g60QsJ7t3r17sT8dZ5NERy6vPFM5g8YVKcR9oMs1e9JvTT5KTZc
 OCEg85dzgOqXJ1QjFX1GNiYC16l8fwtKU6ThyPWP2lRXLaEP4ki0IRh9SQd4MMyx
 Dg9o7Yc7bZAMCYjrG445sj2zqjnkhvJ8uUO6FKExb2gO6Aavy3GB/czVw+TSyUR9
 6kjYZT5gL9CYDNbq+xiSvwZnw823g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012010.outbound.protection.outlook.com
 [40.93.14.10])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbd0we20-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZjK907shxxp3m1vGXdCDSFRXey+OYOw3lhvLm8qKJOiJ3ERWzaSeIufw2bjJ0jZ+Ez0sl0MResxXuKINr2sfzo7BSsPNCoodc9+1or0DxR0mXyWoYE05kNidPoR4XVgcxHTHsssXe2suqJyfO7uH1DJklGd6CmNaQTBtfnqnzXZGXXcdRK+NhseFxw4y0bmOy/xiNqO2xOmhyiQkBzo/N4JCDyUKzr+fAdI7zw9Qobijnmzn+s4TEosK0OZ4Pu6y99+6fFxcyuPw+1aX6mbhgdlK1dfaxpZ0oUoM/mncKxD0eFPGbwBIIm94LMVepS/8IYPgrV+vpouGE81Xqg24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH6f2tmI7ATg3KzwM9TyWxj1523guBD6/z5O7cFLNGY=;
 b=zEunaJpHOvEX2mSf1vS0iUk8M8fGzCVY+okWDtDkHPDN51LegiDnRQRPMCEVYo4WNccGKgZfAuRaa9FlaBM3474/QEsTy4DibmYaQ06UZRssgtzOTwH1080ozPaqoAT67Jl23Vko+7qCk17BULtTL8OR4R1A7n8ZvhjdGXMLN+21VH68lsi+8S58iJOP9a47Rhu54FroW5eOHjRvg6JRPcakb1WayClaTL8B3lKxRdrV4A9uZ57ARg9BVhhA7gNDZosqw1apbUKz8ZeZN4kJz6GDUPCNljIuRR+i3+JuqTxVZsp9tlO7m6wQLtbpL0kEDDikv5F5D7wPMRm5adorEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH6f2tmI7ATg3KzwM9TyWxj1523guBD6/z5O7cFLNGY=;
 b=U13TxZmGYdKswzqva+0Aop9x06K1ANJFTDf0KN2porqQzO+cqKb+w8d9Kss9C5rE5AL8fa6KPPfOcPVnmKnRvwXLTRgfOOSN/TYnrdjwm8NJNmv3Qrcouba+eVmTe0B+GI/9CsY0LwTzdTGco5ODV9Tt+cBsXZjDfB58iaXOOFu2VmvOY03zDS6Ab/mW7RE4A0Xjn7a45LbpEj7iuyPxIVJbwXoV75y2McKzWCRmgeVnX8QYPZ2jOtej0Hd2DZiqekw/DbMlrJ6sNgE1cnidyeq8k0Q+EUg9YeTz7AenYmPDk7SnMcqHs3KRfAZ5CUXn4H8spBrZ0TAZ1ysxMtMc+Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 15:44:54 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:54 +0000
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
Subject: [PATCH 14/27] vfio-user: implement VFIO_USER_DEVICE_GET_INFO
Date: Thu, 15 May 2025 16:43:59 +0100
Message-ID: <20250515154413.210315-15-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY1PR02MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fc8fb0-df49-4fc1-af1e-08dd93c76fb0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFJYWXQxanIwYVJHVHZuVXVCbUZMM0kzeGc5WjFtdCtOdlJDUkhkRFN6UEsy?=
 =?utf-8?B?RFZ4UnRSVjEyVThpeklnOGpXbEU1a01WZGMvcXU2OVFEdmo0Sms4bTF4c3Ez?=
 =?utf-8?B?TnZzTkhaM2J3R2t2bzEyY0tPV25pQ2Jwd3lMeTZkN3RrYmo2RHBJRk1YRyt6?=
 =?utf-8?B?blVlblVWeU11OWdEQ2o2aXY0cTg1elNxUE54UnFLNEQ1K2NFYWpCc3RmTXo4?=
 =?utf-8?B?a0dFdzZSR0dwai9vQlVqUW5wb2FGMmo4WDdSNGRnWGdoTHR6UkczQWVXa1cv?=
 =?utf-8?B?cThXd05yRkExU3gxcUNoUDF3YjhOaXVNc2RHdG9lR2RWL2FaWXo1Sit4YmJC?=
 =?utf-8?B?WC83dVB4V1ZwbEpLNHVwUHVBNVZUVkZwUVE4ZzF6dXU2bnBFZkdqVmxTZ3NV?=
 =?utf-8?B?ZmxoRFhOOVkyQWJRYm02UklWQkhuNjRONkRxZEJBNEJUbFpIeFZ5WFBHYkNP?=
 =?utf-8?B?UXpGamxraTZhZ2lPUmx2OFNmWFJzY1hEVEFDNGhsbEFTTU4rVy9xbzhPVkRo?=
 =?utf-8?B?SEFWWjkrU0pUTVVVRWdUa0dhWVNjS20wNjR5a1ZjZXFmL2ZVSWdHbmlrM29a?=
 =?utf-8?B?RkJwdU9iY1hBQ0J2TDFjYVNFQlBxUHBDMHp6dGRGRFJCR09JYXZDVXBKYURL?=
 =?utf-8?B?dnd0Q3lZeHdBNWxma3N0UnRWOEtjaVdmcW1kMGRqekJjcVZQb1BwWkhJazhx?=
 =?utf-8?B?dkkxNG95UFN2cCt0MXJ4allDb09RWTc5OXFydGR4RzYzSVk2ZXU5RkpzRjFt?=
 =?utf-8?B?OTFvREJwSXZwS2VRWkdGRUpKSlBqLzc5SlUvb1kyQnJQd0JJVS9QZUlCRGVT?=
 =?utf-8?B?VjlzQk5TVlk2Q0MzM3JqcWlQSFh0c25IUXFPU280WEFUZDhUR2dpN1ZlaHV5?=
 =?utf-8?B?K3NRa2VydGtYdDBkeUpmT3BLSzZ3TGVuN21MdUhxK3UzWVE2dE5jc1pHMlB6?=
 =?utf-8?B?UE5wdUpLdlVwOW56MW5ES2JoazFwY1N1ZEdNYUU2azluN1FPNEE1UGlrT3h3?=
 =?utf-8?B?c0ZkbXU3NEhMUmRiVmFPc25uZFdEd09TTFVqUm94NEtWS21WLzhwN25FbDVh?=
 =?utf-8?B?NmFXeHRYcm1IS3BqZlJNLytKRlpZazVUTGFSbGtrampPNDVJZ0hWRFd5WVEv?=
 =?utf-8?B?RmhHdUE2SnpjU1lkZzJHMC9IRmNoaVZRbXdaOEFiN1ZqSVloU2F1dkE3RTlT?=
 =?utf-8?B?RExGOENYU0dQZ3RyVEI0QnFURks3cGpxUGRYMU9Xd3duTmR6eHEvajc0bmtE?=
 =?utf-8?B?VjhyRG1BOUlEaFBqVGhCelcycDdBMDRJUkN6dDNncHA1Uy92L3RQeHdXQkU1?=
 =?utf-8?B?TzV1WmN4L0lSTWwvNGdwd3A1NzhXMFk5a2dKRXZ5M0h6NUQzc0xIckUxM0RB?=
 =?utf-8?B?S1pTRVZqWGJpSkFlY0dBY1NIejUwUkJkRDRRWHRqR3J2REd6UjlQMkFSU3I3?=
 =?utf-8?B?RVU1Uk9zMVJWaFJmR0NYSTFNa2FtVENHRGx0YmJtVlB3eU4ya2FUanIwOG1s?=
 =?utf-8?B?S1B0OEVOaHd5TU9kT1FzN2d5RTZnOFBmNzVqWFZTTlFvalFWUmRROHY0cHNn?=
 =?utf-8?B?aDBSZDdxNCtpa24wT0tFaDI5K1MvNU1KVHpkelZpRzZNYjFqWDdwYUdkcEhU?=
 =?utf-8?B?ckhXM1pSS3FYbm1TZTJMSW1kbzFoWjhqazB4dEtOdGFGZTVsaHAvSS85Wnpx?=
 =?utf-8?B?ZEhyQitCSDZvMUxPZ1Rma2FyM2dqdWdtQzFjWlZLeHE0d3llTEU4QnRvMW44?=
 =?utf-8?B?UmtmSnJXb1V0b1VDTy9ieTZlYUM2SmZKU2o4a3ZDR0RzN3ErVFQ5R3BTNjJM?=
 =?utf-8?B?MThmenVINS9DbnRFcHRGNmd0dkNGUHpOZnBZaFhKQnNUQVp4RTJmYUlTRXUw?=
 =?utf-8?B?QjFjaldoOFp3S1o2ZnF4TE55djJ6ZHhhcFN6RlRKK3NUOFA2TlZydkNJRVRq?=
 =?utf-8?Q?JVGkp+Eat/M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1dudXF2MTgxK3ZsOG5JeTRZd0lscXBjREJycmhCTExhMXRFdzlWaFNlMGRO?=
 =?utf-8?B?bmY1YUhQZ0tzbWRyWXluN1ppZnpWanpwME83NW1sUUdmcHZaSHNMVS9LSkpJ?=
 =?utf-8?B?ZE0vZjdXK3RGeVR1eW5SU09rbG5qaEFsU1Y4aGFucVA2OGN5VlZBQWcvcklw?=
 =?utf-8?B?MWROb3Z5WTF2blhCSm15Q0VQZGczNk9CaTZmV3RTM3ViSGZtVEh3STdnc2ZB?=
 =?utf-8?B?N3pHUUd3Q1ROUVp3TXY5ZS9aUFNxejJ5N1dEc2UrbzJUSUNGN1NzYmdXdThn?=
 =?utf-8?B?RDIyZnhSUkNaNERqVjNYa2ZWYk92UlZiaUxzTXRPbk91aHV5eFhoNzRneFRV?=
 =?utf-8?B?aTBUak51d0cweEN5YnQ1bTFWTlk4bEZkanlyNjdzRmRtQVEzRkMzRnVWbEZC?=
 =?utf-8?B?S1RwKzkvaWJFdW5FWkFCZWpOYmduV3cvRUJLV0V0ZUk2TlEwak4yaVh6QmxE?=
 =?utf-8?B?R3JFeUZLOUFneGdGK01qZjI2OVRTNm9UNFRneVo1eUc5UElsVHlNNk9BUWJL?=
 =?utf-8?B?Y2FKYVAremFwQjk1QVlhZGhsUTZmSml1L2lYL3NZN2hzUzBBMnFGM1VPSHow?=
 =?utf-8?B?NkZJcDBWUjRQR3o3SlVxa2UxbVA5b2Y5Z0gydlJ1TUlpa0U5Zm8wTENpai94?=
 =?utf-8?B?T3VsWWpWc3k4T1U3eWVOT1Vjc1NkdmNHTjUvU1FESzNjR2d6RkptbkpDY0RU?=
 =?utf-8?B?TnFvOWovcXhDWE9aamJFUDNCbGdORXZrbXozdkhJeGJNNG42SE5Ib01HcVVE?=
 =?utf-8?B?b0thWGFNZXJ5MmF1L1lrY0ozRGNVcmltUHJOK0NXVlBVVklMcmZPY09SSk9m?=
 =?utf-8?B?empjcDgwdk1vWDFyUklETXRmb1o0OVpaU2YremRYcS9FaVNUb0pKN2dWUk1a?=
 =?utf-8?B?bWtxaGFXYS9uelprZDB1c1hTMHNLVUxBZkE5VHMxamJrclJCMUJYRUo2TVFX?=
 =?utf-8?B?N1V3UWF3Tml1VzBFZEVJK0ZNK1d0cUVHMGtiWHV3UCtkVVJmc3VLYStOVUk3?=
 =?utf-8?B?cHAwOGNsYk55MUxWLzZHbW1mUzQ4VVFmM0YzanB4NUxwVkFIUDc4MVZHUG1h?=
 =?utf-8?B?NnpqOThON2NZOXdoT05OdDlkbnNWbWhJZ0x6YW1mSjdheitBM1ZlSHQyc2Qv?=
 =?utf-8?B?RUlueGpjZ3NQU3hiMm1tbXNnK2txZy9NblJkRHoyb3F2cStPdHp6aGdtS1Fp?=
 =?utf-8?B?TmIySExqZjNZMjUzU1AzZlFwOWp2UUxmUHk3ckhTNzNnOUg0MVZiNTZtSHJK?=
 =?utf-8?B?TmFsNDhIb0hGS2FtZzhEVXBWcHU2MWlMRWhzUWhTUUJwN2RadlJkODJvQUFv?=
 =?utf-8?B?VWo3WXRSQU4yUFFITlNTRExvYnZNazNmYnVBNVZWelh4MENjTm12a29ZYVJn?=
 =?utf-8?B?cVlCY2poTDRoY2I4clh2SHZiSFJDVG1udGdXdldTZ05aVW1QZmpud1dNTy9q?=
 =?utf-8?B?WElyMkRMbDV5VzRpR0VPWTBMamxrVkRveE5GVDNYZHlvK2JyNTdFUkhNSkVG?=
 =?utf-8?B?SEJnZlNRWms4Ung5VGd1bFB4Z1plai83WVFEQ0dZMTRObmZOMG5UM1hiam55?=
 =?utf-8?B?bU83WFppUUxoYm1tQU5ZQ3V3dm5TQzBoZTZIcE40bXpRTGhTQXF5ekxiVlA5?=
 =?utf-8?B?N3RId2xuYURKRUppNVJsRU1MbnlwZityRFV3KzVzMnllQ1FCNTFFeVRVZm9v?=
 =?utf-8?B?NmxieXZuY2JmK1lzRXEyNjZyUjZVRndWQlZrRWpHWDhjWUtOMVptWkNscnlO?=
 =?utf-8?B?MlRmQVlEcWN3WkZrdkU4Q041YW9wbXFGWXZnSzlOQ2k5TnlycjZseHJkb2lp?=
 =?utf-8?B?TzRPVFdRc1pQUTV1R2R0UDZ2L0paWUdpN1gzVHRPdk1LQ3hXYTVJQk5yYmpP?=
 =?utf-8?B?ZDZDNktpZlZGRUpEcjY2enE2Q1Z1eUw2S1htbHVHWmdzTEhhUXloZVQ1eEFG?=
 =?utf-8?B?ZVpNdUc1YWtsOGJVUHZ0RVU1WDdORnUrcEtkQ3JaUWlPTk9jNEtWSHhnTTdl?=
 =?utf-8?B?SW9UdTErNkEreWxhQU5RZDR4Sm52djRia0ZjazhOME9UL1BKQkRld041dzlS?=
 =?utf-8?B?My9jd1E2VGZ3NENaZnR1M0tQVTZ2SXM0dGMzeXBjbDdiQjEyRTNzWW5NU0Ju?=
 =?utf-8?Q?VG0xlpoJU1VOnZYr3p6vUEw4n?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fc8fb0-df49-4fc1-af1e-08dd93c76fb0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:53.9568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hCeq2EHZBLalzNHacBOl6xwZyYBUE3iYhljrgbKMUgCPm0L2lKhnqA7dbDYzkz6Q8Gl+jINFsV8rWwXRo0frQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Proofpoint-ORIG-GUID: PXDWcYO7l42vwPFyKbyrAC7Iu4jTasA1
X-Proofpoint-GUID: PXDWcYO7l42vwPFyKbyrAC7Iu4jTasA1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX4ARMFHEXA62i
 b9evb7u5fYnHkIJbTbHNM3cNw4caDT7Ab+XNhXA0ocgxDzrFh/AUX1ZIqimCSqe5IymBODjRV7a
 Cy3aBXR/kPin4S4c6Q8XKnq8x/7F7pkZTTF1Ke3oaG6apG7Wfkko1wWR/58b8XFx2ORngvpLn+L
 b52kegu9WH6NQ2tIkU5XzPQj7ltBRR6V+T30CAMBl/PW/W80/fjjJ2Qz5J9SkqwsFiS4FSSk4nL
 LCHOK5OachLhtwo7SggTI9/y3L1oFDze4n7QnjJlN+8ONrYjXUTq9d0WkCOGtBW0oX1WEFyTvXj
 q7U9x/THpTWf4r+Lzfrnv1nV/rj8Npq9vvKp/3vps/gv7o1hRMJ5CYNcIkZtTEkTZSLy4pluC4t
 g/g7GyHHe8YEuWUIQTythg85IuKMlpNP8TS0ndMbHhsG25RmxMnD2fMqw5LDYWNS+43F44tr
X-Authority-Analysis: v=2.4 cv=KKlaDEFo c=1 sm=1 tr=0 ts=68260bf7 cx=c_pps
 a=5L1ZokDb34JZJib1CqSWiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=9e9T-0rTUHAn1w8HAtsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Add support for getting basic device information.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h     | 23 ++++++++++++++++++
 hw/vfio-user/protocol.h   | 12 ++++++++++
 hw/vfio-user/proxy.h      |  7 ++++++
 hw/vfio-user/container.c  | 10 +++++++-
 hw/vfio-user/device.c     | 50 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/proxy.c      | 12 ++++------
 hw/vfio-user/meson.build  |  1 +
 hw/vfio-user/trace-events |  1 +
 8 files changed, 107 insertions(+), 9 deletions(-)
 create mode 100644 hw/vfio-user/device.h
 create mode 100644 hw/vfio-user/device.c

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
new file mode 100644
index 0000000000..f27f26b479
--- /dev/null
+++ b/hw/vfio-user/device.h
@@ -0,0 +1,23 @@
+#ifndef VFIO_USER_DEVICE_H
+#define VFIO_USER_DEVICE_H
+
+/*
+ * vfio protocol over a UNIX socket device handling.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "linux/vfio.h"
+
+#include "hw/vfio-user/proxy.h"
+
+int vfio_user_get_device_info(VFIOUserProxy *proxy,
+                              struct vfio_device_info *info);
+
+#endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 74ea2a94e6..648badff46 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -115,4 +115,16 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DEVICE_GET_INFO
+ * imported from struct vfio_device_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t num_regions;
+    uint32_t num_irqs;
+} VFIOUserDeviceInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 33e8a4d83b..9c6b2cdf35 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -15,7 +15,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/queue.h"
 #include "qemu/sockets.h"
+#include "qemu/thread.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
@@ -99,4 +101,9 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags);
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize);
+
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 2892845b4f..6f0eb86a75 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/vfio-user/container.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
@@ -144,7 +145,14 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
 static bool vfio_user_device_get(VFIOUserContainer *container,
                                  VFIODevice *vbasedev, Error **errp)
 {
-    struct vfio_device_info info = { 0 };
+    struct vfio_device_info info = { .argsz = sizeof(info) };
+    int ret;
+
+    ret = vfio_user_get_device_info(vbasedev->proxy, &info);
+    if (ret) {
+        error_setg_errno(errp, -ret, "get info failure");
+        return ret;
+    }
 
     vbasedev->fd = -1;
 
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
new file mode 100644
index 0000000000..e081033ff1
--- /dev/null
+++ b/hw/vfio-user/device.c
@@ -0,0 +1,50 @@
+/*
+ * vfio protocol over a UNIX socket device handling.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/vfio-user/device.h"
+#include "hw/vfio-user/trace.h"
+
+/*
+ * These are to defend against a malign server trying
+ * to force us to run out of memory.
+ */
+#define VFIO_USER_MAX_REGIONS   100
+#define VFIO_USER_MAX_IRQS      50
+
+int vfio_user_get_device_info(VFIOUserProxy *proxy,
+                              struct vfio_device_info *info)
+{
+    VFIOUserDeviceInfo msg;
+    uint32_t argsz = sizeof(msg) - sizeof(msg.hdr);
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_INFO, sizeof(msg), 0);
+    msg.argsz = argsz;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_info(msg.num_regions, msg.num_irqs);
+
+    memcpy(info, &msg.argsz, argsz);
+
+    /* defend against a malicious server */
+    if (info->num_regions > VFIO_USER_MAX_REGIONS ||
+        info->num_irqs > VFIO_USER_MAX_IRQS) {
+        error_printf("%s: invalid reply\n", __func__);
+        return -EINVAL;
+    }
+
+    return 0;
+}
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 0bc12da865..34df9bba7b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -42,10 +42,6 @@ static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize);
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -613,8 +609,8 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     return 0;
 }
 
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize)
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize)
 {
     VFIOUserMsg *msg;
     int ret;
@@ -785,8 +781,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy);
 }
 
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags)
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags)
 {
     static uint16_t next_id;
 
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index 695b341547..19bdee688c 100644
--- a/hw/vfio-user/meson.build
+++ b/hw/vfio-user/meson.build
@@ -1,6 +1,7 @@
 vfio_user_ss = ss.source_set()
 vfio_user_ss.add(files(
   'container.c',
+  'device.c',
   'pci.c',
   'proxy.c',
 ))
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 7a3645024f..6b06a3ed82 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -6,3 +6,4 @@ vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
+vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
-- 
2.43.0


