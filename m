Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5666C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwz3M-0001Q0-9d; Thu, 20 Aug 2026 05:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwz3J-0001PX-Dv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:27:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwz3H-000119-9V
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:27:13 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JLDPl71539500; Thu, 20 Aug 2026 02:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lI2VYxubEzvynyer8rsoh/ya3BuF6clS9dm4Mi4TP
 nY=; b=haRyPE8cJlMSvr7bzlUMIk+U4hdO6beriXzzh3rbRsnOV6Uhx/nZNvwob
 9fTeuWOUrMQ7/EvY+GB/Ap38xMbaQYxjt14SahGSPD62MWFvw8HXALysKGqFR9Yj
 o0Wjff9QgFR8jVpVrmBlZF5tc9N/ThY1/cN9TqaWAuU2+aGOeO80umsz0Nldkkyf
 5p62Aqp9zzu4uA8mE0DP4vVcBw1AiWrrDaHih2RsI3TRb24A4yiBzcnVIZL/d7I4
 yFJ+R6CSjsK1xj7SppfaBJo4TPMw/j1WQoOaRc9+Nd7Fctxj3t53OeW2roGU6kiS
 mAn96ZmjPvgIpKSYJcWz0/3fUJ67g==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023099.outbound.protection.outlook.com
 [40.93.201.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4rvhdxea-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 02:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfWBzd1Hp6xRodi6xW4wuwgsFrKYs0xetWHzGLwnFWwzAyQVOnoxpmtyGi0Nwx9H/9/Dx3Vs5hB+Jd8+5l40sUsRX8ZnEte1MXVIRq/i9keuNTVQ/0W1tnaWxhJDHcoOmoaAbLxgYqJIDQwSbHbnF51YtAC6wPtwNuIuMa40ddrrIRlKzIFAIUXi1g/LRpBfFmvshzKbfm3w5Dztf/Cmtm5VzivXQfRyXyK5Tm7a0y1n/QG/7ti1+FDqRLFAak6SDAl3dHlcHUJqaiyucTqON4rVJRY9Ksr6Ljv0pZ7UijcXjO+rM8tch6a1aWr0A3xU2nrzW/Q8LfuvHktCJH04ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI2VYxubEzvynyer8rsoh/ya3BuF6clS9dm4Mi4TPnY=;
 b=j69Djyh/WA4tSxj9FwOunSG2cFlxMR40bwo5jK6inzVHkXsWDNPIfOQ3878QGABGr3R/fl7I+5VV7leooR2rMyWm0mQwijWG4rwbJ+BUp77pZv7XLY3nkBzWuePOVdhGImg5cQ37gA4Fwfqtzbo4HGaLtacYmzVySumEYDH2gN1mh8/8wOuQuqrz/o0cWI1vN/MnauMAfF/WetE3YjgxOTEsRGdns/7Om+xqmVEs+mRsIjUKwNjY9etxqmCVFu5J9zrnnkujoCRm14rQrHVk6dxO6uY/LCoQzpPpLlgfchTX6rzkvASVd1yuP45G17wxnEm0bkiZkjh0zG+Rzl8drw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI2VYxubEzvynyer8rsoh/ya3BuF6clS9dm4Mi4TPnY=;
 b=RJYOb1ZYZ10ok6ahRPviAGozcOZr0PIYlMZh4PN/+w5XCyphSJMboIdvVYvIg5jiUhPe9uZzfF//i88uR+ljz7RHZFfc8gVYV63aMC3YhB60siIeHeWCuN8m9Nff9f5ck5nql+FRECe+gq6hWS7boZ8RSiWS6tMyxtxtBQ+cpWvTCokhPzbh3jPQ8zO8zdxyFTn3bbv+D100ptGz73d14kdXlqtrhCN7tqDozjIbA6RZFttvfyYXyvxrF+nccZbkvCtLwA2LeN/CEWRTBfOCu8FcOtbd9+eELb3vqQrkn/liuATkDmZmzRV9VpiWi5QUyr9pl+DPQTfJDhGyiNCB8Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7250.namprd02.prod.outlook.com (2603:10b6:303:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:27:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 09:27:04 +0000
Message-ID: <b5b003cf-0997-48c2-adce-3632bba01f12@nutanix.com>
Date: Thu, 20 Aug 2026 10:26:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] accel/tcg: Make halt-to-exec transition explicit
 and remove cpu_exec_halt
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:806:27::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cce38fc-c531-49d9-72dc-08defe9d3264
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|10067099003|56012099006|4133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ca0bFToysZ4crXYW8mQze+ZIvHMj38HWdqS1/cs9Yim0tf+JsJFcmjsmPcFvjG5pcKYJ9UGEaCEHhLswpZd3DqjRZ24quSCwpORM8imrsRzPHM92j1Jod/7WCyOiuo/56tLx9ibFLb7lypP8FqW74tPp18bPKLpaUztiTDayphFs79KjPiEDcRHE9gofcc6HBQPSjMPri8FKTtfg0yU+MVWNeEG0zMRi/9911yQtmlCEQYdxUD4KBI1JwyzhLl57FWhP5TnJ5nxZkL9puT0omy35IVd+QpuV4p9l0WWX/qD9Q42y2ivQn65aPelB37hTcCfwX48qnSMyDzJGSVninlt/unWnr5GS38PRtMHkzMpvSzkNQDTYfLe4eWZ+yBddOenrwCxrtRUAyJ744m8auUBCc9vbTRyII+dWkQwTzeIOz00vpFp3oIV/UDJ6Hb6j7GpCQlgRAmcmD3Kev7h165S8oP7xNK59kPKbp8IlTg19d8/ibagHbX9C2oUYCSfkQ+d61ldM+LGsD0yR9rAXW2ZIZ8NLg6FzZl/lHVuSYbfu5fzKI3bz2J7fVdEZ3wzmCU0CHrlwXQS9vtIhAFn+Dk7BI4XPuRDvjmi636zbu60FoYwEAhitzm1stgC4cVLnCNJnfleJWeC768JP2l49GpHExMbKWEBdKgckOIVHRaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(4133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yjg1TTBBTk94UXFldWhFalZMU0MwUXdKTW91K1FCNWdrZW1LM08zQTdhVHND?=
 =?utf-8?B?QkgydXBkR2toMkZ0M0N0bEk4MmMrWWsrSTliMFZHRmhEa01CcVNsR3VYU1Yr?=
 =?utf-8?B?ZDBtckJhQy9RUTFoYjhNaFNuaXZWaGhXVmswMkFIR3YyVjEvU24zVHlxRVQ4?=
 =?utf-8?B?UW5VdGNVdUhUd0VSWnI0R0FzYUVndVQvOFdsTnRNRytwMmNZNGFmUHJiRXlB?=
 =?utf-8?B?V2JRbFV6aEdINUJjZlJaM0ZFL0FTSGRuZ0NrS0xCRlM4bUVwZGd4Y0JndTdh?=
 =?utf-8?B?WUpQb1VtcFFDd0FYeXFjUExxcXUrWERrblpxM0kvTEpMTklXSVltWDl0cjQ3?=
 =?utf-8?B?aXlVdkRsSzJkUExZK1FRSnQ0a21xdWdpT2M4aTVybGlUc3hnaXlqM1VDUWZH?=
 =?utf-8?B?TzJ0Y3NxUWhwZXNFTzVYM0N6RFFHSk91VitadG9wVGJkTUhoK1kzNWFZK2x1?=
 =?utf-8?B?YTNPak56Z1JneG5RMm55Y08yVnJWT1EyN2VUVXhBUnhzWnJLQWlIaVNqUk14?=
 =?utf-8?B?RXRuTnF1YklUSEVCakkzZkdpNnBSMWJ0cXRSZWs1dkwxN2EzSElyRjVTdVJ2?=
 =?utf-8?B?K2VraTVyQ1RjS1lqTjBrNnFqSThNMVVPNFRFQm91NTV4dXV6WExjYUgxTkZM?=
 =?utf-8?B?bnpRQlhMelRVVmxjLzZkT21PRURHc0ZjMTcwL0NQa0N5ZkxnK0JtYjRVZ2VP?=
 =?utf-8?B?MmNmRHdmWGlkdWtCRjQ3WHd3UnNvaSsvTWQ4Y1Z3R3BUNkgzZytKV2NCVXJk?=
 =?utf-8?B?TFovbnFiYzNwWFdJR0RIRGM1M0dEbVhrQmtiYkhqVWdwZjBtRHUvbmlzU1dh?=
 =?utf-8?B?S1dtajdHS0R1bU5NZytsbWpHQTc4clJ2d2dPc1dBRkFjdGtWbzBjcTZtNDUx?=
 =?utf-8?B?OXNhMjEyYXM4Vmh4S3RsRWkvNk9iVVROT0pEdmNFLzQwZEpiRm5uRVFCL1hB?=
 =?utf-8?B?a2R2S1VVbDE2eUJ2bWdCWnhlNCtYaTl4cGRWd0p5SVd6TUNiaUM1S1BaT1l0?=
 =?utf-8?B?WU85M2RNYVBHWjJHV29yTnI2alVnbzd4T2JMK3BQdU85Z2RIOG81bWRZKzV3?=
 =?utf-8?B?NDJXOURHSlRPdFpKTk4rR0lPU3d2Z2FoUDNRZHF3c0NsWU9zVlREdlNDQmJ0?=
 =?utf-8?B?Umk4eFpQMW1NQTViWjg1dVVyVDRudC9za1ZrOEdUODI0TzdRclZzK3hSQWlt?=
 =?utf-8?B?N2toSEQ4ME5kSHdpK1A3NHJZUW9TTHBKK3BoQ05kamdZNzdDWlNya1pIR3Vz?=
 =?utf-8?B?UTZvM1NpVUJGejVRMVRxaU8rT3ZsU1hrVzkxQzZwRmJQY0xUS2U3MEw0Yk12?=
 =?utf-8?B?c1NzamdwQ1pJTlo4QVhhUCtwUFo1bnRwTWJSQVBXa1V4czg5V2dVd2dDVkgr?=
 =?utf-8?B?ZTg3cTJHNDFhOUkyVlYyem9nTHFXNjUzMFhYMmJlMndkbE9NU2dCL2lKOWJr?=
 =?utf-8?B?Mjg4WEpIZldvSHhYZW5tYUh6UW1nYkwrTUZ6Zm13SmZNb1JSUDlYMEVhc0gz?=
 =?utf-8?B?cHNBcms5d25oVlBWWmRKSlkyaG82K3BEdlI2UEFtaTVkOWtWM2cxSFlNY1BG?=
 =?utf-8?B?MHNGY2NjbStMMnNsVk9Db3Y0VWladjhZd0hPYml5cHBtVHFZd2FsSUNSbXFP?=
 =?utf-8?B?Ry8wVlJsdkZBSTN4Q0xaNTN1WjZvU3VYb3hicTFNZ3NDd1FuODlKWVExUnE1?=
 =?utf-8?B?U0I1MFkwZ2wwSUxDamd6UHNBOEtIM3N1bCt6eHVLang3ck9WbHo3Ym5Hb2ZE?=
 =?utf-8?B?ZUFBOEw4VkluOWdNTWVUK0J5ZGxLK2swd2lGUnY3OEw3SjRoblFwSW1qRUh2?=
 =?utf-8?B?bUZpcjJ1aUFJV1R3N2YxNW9CeDBUc2VsTnJXZ0ovL2doU1Z1MVU1U2kxNlc5?=
 =?utf-8?B?ZTE2YlorUkRpU1VuUkdCdVhKRW84WlpCdjFPa0o3bVg2ZFYyWW9ybERjaW9P?=
 =?utf-8?B?d3lINi9PWVM5Q1pnQmhsZFdCRHRQKyt1N1JPdzlqUXdRRkV6ejRzaGlQSGl4?=
 =?utf-8?B?TVh6RUZRZlFiWlhURFFiWkJwclJwWmUvRjJWajNKYjRTaHAwVkthazVJT1RM?=
 =?utf-8?B?R0hDMnEyNjhaTHhrMjFyaXZQNWthVXQzMVJObm5jQ2hob2l1TjhVeHcrSGtW?=
 =?utf-8?B?d2VXSEdPSy9xWDBmeUlSWENvSFBOaFZKaWJGd0JpUnAzUC9jaDZpTWRGSCtI?=
 =?utf-8?B?azNieXp1M1EyS2M4c05SRG1VcG1DRFZtRjBZYWhaWGcxSDdsQTRQNUJ1NFgz?=
 =?utf-8?B?eVQ3SjJtcjQ5OTJIMWQzK0EzWlRiRWRIdWZRanQ5WGkxeFIyUHgvSWMrck15?=
 =?utf-8?B?bnR0b1U2Mys0Nk1Wa2V0SFplWGd2Ym9reWFFTHdDekQxdTYyNnBabENTUG04?=
 =?utf-8?Q?oCG4Dg7fP1ud2GOk=3D?=
X-Exchange-RoutingPolicyChecked: AUrkR4bAlulVWpRcKbCoInjyLGy8KTv//QRLEmrpgm5C1sJZpfImwbDqoNgEVILIvifdyIv3hO7NMea0G0dvaDZ4PMYCoT571gWF7JTpgbsZe+TYxjf6HWQw3cGadhpsQXQcWinaUHyXHS13b3oRDAAhz9v50GwEIj4FWwuQ/wC+iqVQrpM2rfxeux5TyGcpiGKZOeo+gN9r9ssuQyMHxjFse/HMOiq1mFvBJLhXFaECOh6UxY4bU6jAZd0kLz5UKhSC+H4sGFjdriM/kHkN9zh84R68EoPkcUfP1CJCia9y8zBhubDLqtqGmi0qRIndMtfjvdNCUuFWpFc0rim6Aw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cce38fc-c531-49d9-72dc-08defe9d3264
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:27:04.3901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewRSsIkkfeV7eq4tWyjrSeyNHZ+Wwzih82f8Su681F1MgEmMZjdS/0hTqVtO6aw+VmM4nI+jC4jB1btGF85+kQj2Ules4B6uHphM/moaIic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7250
X-Proofpoint-GUID: y9SvsVrpLPAgeHDWSJi-hwlXEszkUrBI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA2OCBTYWx0ZWRfXzY+DOlmK3mmQ
 aVSKIwxPjOyXIZw+kx/MWPBoqh9NwcfW6K0zybn9SmCnjRPQptzW3i4L/tlOozIgpBxHx9NwOzr
 RQWvfat1qniXrc5M/DFPHZmVAs1U0HIbnWtXpf83rmSDup0aTue4DOTgh2p6PAZt7MpD8lyLZy8
 oGVfs2+NCAmzXMqB3rIW2rqMGz0UqlHohHn2l8qboxqaM21Y0P9gcnOkARWBlNiKQ/ZJUewjUSo
 RPc9MU04r4/+6H4wL0au0jpCvn6MWHMRZ5RxnQ81/oPZzqN6EL0ZCTvSfLR/q669BCAuVXL4s3j
 /N8Tn6jjACcwjES61YIEg/cb+UxMCVmmOBKo5rQShwFK0vFX1vDhVFXVZ4nxmEXNZRhXC8TI27m
 xdedTv6TNu2HGMmFb2ZXYXDJjhflqIKK+yWcmz3Hu3YOzOY0WAJrlFyZgjioigFSxwBX8rm/9b7
 4bguFo58DfbUM+0PQQA==
X-Authority-Analysis: v=2.4 cv=LpaiDHdc c=1 sm=1 tr=0 ts=6a86c86b cx=c_pps
 a=ajv5h6Eily4lkhfMD1AUMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=AQE35fvaS_4MK9rjs_4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: y9SvsVrpLPAgeHDWSJi-hwlXEszkUrBI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA2OCBTYWx0ZWRfXznGgySMlfeee
 aeyAo/uey1FOg/PefqXaVmeqEkkOcc8xR7p5ASDVaDFo8peGP7xaonsLKmK5XoQ7hzPo8ViSngq
 SC9nsrY5VcZ9nJRveFAK5tj1jtb5ZHY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On 19/08/2026 15:56, Philippe Mathieu-Daudé wrote:

Hi Phil,

No objections to the idea of the patch, however I do have a couple of 
questions:

> This series was inspired by a previous thread on the list [*].
> 
> Refactor the CPU halt-to-execution transition logic in TCG as
> something more explicit and composable.
> 
> Core problem: TCGCPUOps::cpu_exec_halt callback mixed concerns,
> it checked for work, processed async events, and handled state
> transitions all in one place.
> 
> Solution: introduces two dedicated callbacks:
> 
>    * process_async_events(): Process target-specific async events
>      before checking for work. Called early in cpu_exec().

Can you explain exactly what you mean by async events here in the 
context of TCG? Looking at the thread indicated below suggests this is 
terminology borrowed from KVM with which I am less familiar.

>    * transition_halt_to_exec(): Perform target-specific state updates
>      when transitioning from halt to execution.

That's quite a name :) Would something like cpu_exec_resume() be more 
descriptive here (as well as keeping the cpu_exec_ prefix used by other 
callbacks)?

> This separation allows the generic cpu_exec() code to orchestrate
> the flow cleanly (process events, check for work, transition state).
> 
> Only 2 targets need to be migrated (x86 and ARM) then we can remove
> the redundant cpu_exec_halt() hook.
> 
> The changes are expected to be purely refactoring with no functional
> impact.
> 
> Series structure:
> 
>    Patches 1-2: Preparatory refactoring and guard additions
>    Patch 3: Introduce the new hooks and orchestration logic
>    Patch 4: Refactor cpu_exec() flow to use new infrastructure
>    Patches 5-7: x86 extraction and conversion
>    Patches 8-9: ARM extraction and conversion
>    Patch 10: Remove the now-redundant cpu_exec_halt hook
> 
> Testing: CI test suite
> 
> [*] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_qemu-2Ddevel_CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN-3D3M2cGw-40mail.gmail.com_&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=sBca7couYmrH5p0nURqPPrh51jIPm0xJ4Tk5aHPSTzVFUbwS1-pc6webrznl259Y&s=eDmByvd3KnM-OoPHj78lDNqJAdxt6w0rKnaJOuyWJbM&e=
> 
> Philippe Mathieu-Daudé (11):
>    accel/tcg: Rename for exception codes named @ret as @excp
>    accel/tcg: Restrict EXCP_HALTED handling to system emulation
>    accel/tcg: Check %halted field in cpu_handle_halt() caller
>    accel/tcg: Refactor halt-to-execution flow in cpu_exec()
>    accel/tcg: Introduce .process_async_events and
>      .transition_halt_to_exec
>    target/arm: Extract halt-to-exec transition out of arm_cpu_exec_halt()
>    target/arm: Convert cpu_exec_halt() to transition_halt_to_exec()
>    target/i386: Extract async event processing out of x86_cpu_exec_halt()
>    target/i386: Extract halt-to-exec transition out of
>      x86_cpu_exec_halt()
>    target/i386: Convert cpu_exec_halt() to transition_halt_to_exec()
>    accel/tcg: Remove the now redundant cpu_exec_halt() hook
> 
>   include/accel/tcg/cpu-ops.h         | 30 +++++++-------
>   target/arm/internals.h              |  3 --
>   target/i386/tcg/helper-tcg.h        |  3 +-
>   accel/tcg/cpu-exec.c                | 63 ++++++++++++++++-------------
>   accel/tcg/tcg-accel-ops-mttcg.c     |  7 ++--
>   accel/tcg/tcg-accel-ops-rr.c        |  8 ++--
>   accel/tcg/tcg-accel-ops.c           |  7 ++--
>   target/alpha/cpu.c                  |  1 -
>   target/arm/cpu.c                    | 22 +++++-----
>   target/arm/tcg/cpu-v7m.c            |  1 -
>   target/avr/cpu.c                    |  1 -
>   target/hexagon/cpu.c                |  1 -
>   target/hppa/cpu.c                   |  1 -
>   target/i386/tcg/system/seg_helper.c | 14 ++++---
>   target/i386/tcg/tcg-cpu.c           |  3 +-
>   target/loongarch/tcg/tcg_cpu.c      |  1 -
>   target/m68k/cpu.c                   |  1 -
>   target/microblaze/cpu.c             |  1 -
>   target/mips/cpu.c                   |  1 -
>   target/or1k/cpu.c                   |  1 -
>   target/ppc/cpu_init.c               |  1 -
>   target/riscv/tcg/tcg-cpu.c          |  1 -
>   target/rx/cpu.c                     |  1 -
>   target/s390x/cpu.c                  |  1 -
>   target/sh4/cpu.c                    |  1 -
>   target/sparc/cpu.c                  |  1 -
>   target/tricore/cpu.c                |  1 -
>   target/xtensa/cpu.c                 |  1 -
>   28 files changed, 84 insertions(+), 94 deletions(-)


ATB,

Mark.


