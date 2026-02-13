Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF8CEDF151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqQK-0000oM-99; Fri, 13 Feb 2026 05:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqQJ-0000j6-0n
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:29:19 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqQH-0000NV-EG
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:29:18 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DAIFU02354268; Fri, 13 Feb 2026 02:29:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=l4sDFdSriThlovWzyq9TYji0WN+E2g89fZtP6ZOkE
 bQ=; b=TFtsqL/+wTpgCctSdZsis+ODXKOjmw6FZ7SKMU56QTXAsOKgaEbHmHJx8
 rJIFKgXoc8a5OTDu7VXKv8r4EFES7dcNQVfpbZJwg1+wwnxWQl+3mOp/4f1bj+S4
 oSrojZKjo982HTOSP2OeRqd3MquHRziE80X4q/9mkm6tYEa8vx8KJ+xf4RlJHewC
 HAjq1N68kPGdYOAQKRlvs81eM1kPE6mlodt3EGvfzJ9fKBN3cRWXIbHKFW54upaf
 Fk7V+0ELhp1oYAlMYvp4PL4uK9USEMp08zuBkZbB1ST8ExKjr275NLpbuyvUHgPF
 YqXyxKvGRb9y/2RCdMtGrHxksAZWQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020093.outbound.protection.outlook.com [52.101.85.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9fukash6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:29:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7AOmw+9qWB407WkuhOgbONYu4/bAyQtQkzPWCrI2YTcCCOjcjTYLb5bTNOj3+u3DWvYbEaDttKg+OEAPbWw7sH42c93fgiu93iE5wmzGzR5UvWjaY5Knu8WS3Tvw5tgi5jeOzp6IXaVTCKN8+hGe0gbITc2wyVeJubYZGg171oromuWVwUHkvto7MPQ/NlCGECFK3NNKjGJed7eRgbhj1y1TlQ00XG1dN5zmmBOpNwvBuf+JAlhGkZOsvUsqmZKjtL+yWseDWoHsDE5JNLkeFQJRnXVT+sop317UklV/+RP9TBl4Nfx0IuomiI0IG5wgx8wkSVgu0Ws79UrBaFGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4sDFdSriThlovWzyq9TYji0WN+E2g89fZtP6ZOkEbQ=;
 b=xj3GTkAdpLupZc7HL1X0uxKcNnq/XGi6jyU/e0kJ2984Kov2oCxssDQqlacwRMeFdi8vcMKCciRGH95ztCfHLvDm4hatcI0cUlk9lkz9wZJ2lH3R2CbXsmy/3jSqYJ/ilzby8lwZyr897c0Uhu0F4ufAdvsZM5rp5v8XnwtyrqFFL3OH2Ac7yaPI+O4h9oJKlvrBOkQoVfAfdWzFSE5AQoDOd/JFl5B92ZH2+PzSZG7Fg+gKYMQnYZTIjNs80kI0RVhEprOBOJZP6w7Bna6YSxhwckUpWHZAhKPy4HL4m7GTZv1itjhzj7Qgg3ZDKfezvJSwQpWdDvJrnu0WHilLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4sDFdSriThlovWzyq9TYji0WN+E2g89fZtP6ZOkEbQ=;
 b=dkVbaOsMnpUlb8YMjMEiqVdIMyz4iWyp9Vv7gFHKT9inmZEE+eiALgpVs25Uy1wLrJ+nv6asayDK5ZD6PgyOg+KkR3Jx5gsHaankAcx/EkKWXJ2NLga1DwduarsLs0/XvClMxGXDdQsOWTkB9yBWuiLyf0KYIelm1vDVGl8n81NrkaWtE+Jr8Shf0ye//NGhiNc/I6q3BWwdklHTDU6EBkkTiENH5jaOgsNBRojhzxSWjqjpChrHvs4Ddfk5HjF/fpJ51YtlmfOUEr6TaZ10XoU5HLuEEO8Lgu9amGXmjADzyYQFgXr96DkQk5ONfqLL4bBflJ70ro37eZVogueYuw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8416.namprd02.prod.outlook.com (2603:10b6:806:1f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 10:29:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:29:11 +0000
Message-ID: <e9da43ef-e111-4bac-98ad-d341b5276a46@nutanix.com>
Date: Fri, 13 Feb 2026 10:29:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/43] audio/coreaudio: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-13-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0245.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: a42b0062-bc6c-4192-a704-08de6aeaba32
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2pqRHY2cGMvS2FDbFkrU2h5YnMwak8vbk5KN1RvN25xek9Ib0M3Z0VBbmFs?=
 =?utf-8?B?U09EOFlpNDYwUnJ0OVFlL0NZTm9QSnkwK1ErQVNBdlV4WkNZYlVPK0ZtK21I?=
 =?utf-8?B?Z2RxSjU4R0RmSU9ieTlPNTlmMkUrTG1lZVBNR1RIdm5odVNHUk9PRElpZHRI?=
 =?utf-8?B?a04rQXUyWVo4bEh3ZjZUZ3kzWEtWblhNWCszM1VvWXNvNkVBRXR5OGt6MnMr?=
 =?utf-8?B?blUxRFJWa0I3L1hTcXdjUFR3OTZsRWU1Qm9QcVdhalhLbTk5N05LUEFJNk11?=
 =?utf-8?B?M0Q5TnFQMlZpOEhwaEhITC9HUnlwS2o0Zi82QkpjYUs5ZkpBaG9KNnlaTVg5?=
 =?utf-8?B?emQ0aDdXSTVURG91clE2RmlHaUNTRnZoWU4vNllibGdyRTYzd1lxa3hpLy8r?=
 =?utf-8?B?cFVvT3RPSVI3WGdOdElCaGxReEtiSWR1Qi9NZXFSUFUxVWJJVE5oNWVWMWhR?=
 =?utf-8?B?cW1yYU9Wekt3djFiS0NiMFBiNG5waHpqaXZvbC9ZTU9OQTZOaUdvWS9OMm5t?=
 =?utf-8?B?SzFtaHZjVGV1MlRnWUxiQlkvUjZWWFE2OEtwMzVVOTVtbGNoZmIrOHZWL3Zr?=
 =?utf-8?B?aFIvMVFOeUVPNERGaHMvR1BXRjU1djdPOTRtcVQ1NU4wc3JCNnFaNWtKS1Z0?=
 =?utf-8?B?a21aQkh2S2gzVElzbTVjMENSVmhjeEJZNmZJRFZIWnNlRVBqSmFBaGs1UTk3?=
 =?utf-8?B?ZlRFOWVITTJidHFyWlltUFEraUs0c0pIS0JwaWs5RVNDbThSZ00rN1lMOWQy?=
 =?utf-8?B?cEUxUGUyd0VtVUFmZmtRcW9LSXd6Z1pKeitLckJvL3ErNytHbEN3ZkJGRGZk?=
 =?utf-8?B?QWl5ZjlKdm5Fd1pFRjVvanFhN2toakQvVDlWK1RpbTVZdFcyOEgvbmdYSGxZ?=
 =?utf-8?B?cEtGVXpnM0FIdCtSMHllT3d6UkhUelpuL3lTSU5hNDhmVlllTU4zdW5ZTHAr?=
 =?utf-8?B?anBVbUFWVDVDNlM5TTFoV05Sd2FlYjhPYVE2YUJLcTJuakQrQ2tjdldwblhE?=
 =?utf-8?B?eVl3Zy9hZk0wNG8zaE9lUE96T2FnVlpWQTBENXZsakwxUHZ4T0RHazcxWWtK?=
 =?utf-8?B?U24wMWRUZkZCcm12bXhMcHFDOHQranQrQkJvSUhIejY2VGNGTy9ZNkFaMkMy?=
 =?utf-8?B?Y2ptdm5PN1Y3RlBnL1gwVlgzTXlJQURCczBoSURMYWhoeDUvcTZtRkhLRElu?=
 =?utf-8?B?eEs1Y3RFNDdyTWgyNC84TGoyZElRQ1Y0WGVlTEp3SWcxQTIweVJaNllCN3Yw?=
 =?utf-8?B?M0IrZ2RtOWFMTEJhM1ZaVUViR2hFZmsvWVhIN1N1YnNTbVc3OUhDdlo4a1hC?=
 =?utf-8?B?ZHk2bnJDeUg0NFgwaW93WVgwNC8rczllK3VMM2dmcFFJdHNYK0hIOTRnN21m?=
 =?utf-8?B?aHZad3NmNFFsbU1pUU4rZjVDcHNjZFhHY1picTJZT1FGODRNZGNTWjhCWGFF?=
 =?utf-8?B?SEJMekU4OWhxcWMzcWk1YmYyUHF1N0h6aS9XeVBXc09nem11Z09MeStQaHdk?=
 =?utf-8?B?SU9MWHcrUmJ3R1ZJbURyUm9GOFk4NDBHcURIZ25HNnhzdndEVStSUEtyZzVW?=
 =?utf-8?B?TUxDZkxpc0dRVVhybjl6aHoyRmJkMzRBeEV5alNOYm96RmdFbEtKOHVyWHl2?=
 =?utf-8?B?Z1MvWEV3VDEweGlLcDJvZWsxdG5mdGtRMDlYUjdSQUVPeTlMUVU5Z2o1V3VK?=
 =?utf-8?B?OXE4RzFEQUtLZkJoeC9zWTQyUUJQVEpLZGFmUHJaaHBEWi9mT1JESkU0dTRW?=
 =?utf-8?B?emFLREhCb2NJZW5CSmFHNVNTWE1HbEljUENYaVlzM1dtdGk0TGF2aS9oRGgz?=
 =?utf-8?B?eVJ3NFZrcW4wTFFnQ1pHQXhlLzdGTWUrRHNPNjFTZ2I1VGQwQnl4azdXY0Yw?=
 =?utf-8?B?WFZyaFBrSW5iU0l1bjhMSUdNWW1HUVQvZ1dVWUVpZGlNdThYYlh6cEp2NEpY?=
 =?utf-8?B?bjZxL20wSSs2MmxCTEpsNWdPMSt2TS9UWXo5Q2tUS3NIVWg1WDZraXphUWJz?=
 =?utf-8?B?VUJXcUpmVTd2T3dIV21ZeHcyK09jdUhJTTFTOGx2OG5MUmpvbXZqTmxKWjJT?=
 =?utf-8?B?QlZLemFURjlBR00zZzVyQ2lSVFJYS0V6M2piUkhUTWJjdUEwSFZLZUFERW1Y?=
 =?utf-8?Q?S2Ik=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXJXZW1FcHBvYnpqbGRmb1VNcFVsTlZhanR2UWR4UEVZQmhZSEN1TVloQ3JT?=
 =?utf-8?B?UVZ3YUxqOWNqbU5vL2VyYkIxcXpnRkp0WWVMek1VZkozYzdMY0J1WFhkTHhJ?=
 =?utf-8?B?MHdHRzBjSEhoYTZjOGFPRFVXL1Bud21GZER6NWliYWlSZUFJdnFRRTNhaHI2?=
 =?utf-8?B?bitOcFVNM0daTzZWaFp5V1loOTcrVnEzaG5LZ1RjN2FBSzZ3elRTZjJXTTNR?=
 =?utf-8?B?aWMwR0RzQzkzNUR4eGo4WFpQYWhXQ1BkUjd0SGRzblRkNEdBeUVTdXBtUDlq?=
 =?utf-8?B?ZzVHb3FvNmtEbjhPa25MRndrbitkc28rS3k1QWl5dlhXam1WSFZObzFtMWhn?=
 =?utf-8?B?Vm9jRHFlUXhzZHRhQXFpRFp4N3IxZDJ6WTgzN2MwQVI1cWFQRm1KWWEreE1k?=
 =?utf-8?B?USszcGZaZ0VIRzQ3UnlLSVZxenhFTnplQmRQemFVRFhzak9yQjBmNzYrcVJR?=
 =?utf-8?B?OVJXYVlmQXRJRjZnUmpaVFlTYnlTVWdGUDBqQ2FTNlkwcnVFb0FrbWpmOHZF?=
 =?utf-8?B?R3J3RndiWFArUW9qSk9ydXJoQTh5cWNNQUQxdWxwS3RlbkRzWXRidHpjL3hu?=
 =?utf-8?B?bzFTdmtIODN6bjRReVhDWFczbktnWjVOQ2pQTE5xOGNpM0xJWmJjY05tcVZa?=
 =?utf-8?B?MTZIWmJaL2JYYXBZRzFqakFsQUVqQWd5My8wY20yb3F5cmlFcHIyZjhCUldy?=
 =?utf-8?B?dTByaTlrQnVzcmQ1VlR2ZWFTYXdVcU9UKy80S0tKZW0zNEVFNlE0SXFvN015?=
 =?utf-8?B?RHF2THN6VjNEUHRGN0FKdG9OQ1dQdHNTbVBmZDlYb0d4Zy9VVVFxblZ0Qm1m?=
 =?utf-8?B?ZksyMVQ0RGt6dzF4STBBcmxOQmJHUy9xQW9vR2VvZHlkMWMyR2FubWRLVVBV?=
 =?utf-8?B?YkNtcTRDUmFNRUVHcEhpYWEvTGpmL1VpK1VhN2lxcXhaNUJhQ0FJNFp4SHYw?=
 =?utf-8?B?ajJCcm5yRGxYb0N0SzcvMTlKa3BWZEU0NEhYcWdjamdrZy9iVHFmcDRNejk2?=
 =?utf-8?B?Vncva0xCa2VNRk5JWkRHREkzSndqUnlCWHllVWRYM1o5ZEVxUXZzdXdEQmQv?=
 =?utf-8?B?M3JIWVlKbzdwd2lwZnpRbDd3ZlRNK1BQcmh3NFY5SER3Vm44eDR4bGJkcUg1?=
 =?utf-8?B?cEY5WVJtUFZGZEMxaWpRKzZPeExDMVd5UGN3V2lXeFBzUkI1YnVzSDNOcVNo?=
 =?utf-8?B?S0JoZU03cGw0WU44Zjh1SWk2a1ZsOXdyUTNudHZ5UmM3eGdsZFZ1QXBFZk1y?=
 =?utf-8?B?UktzK2pGUFJrYnVaZXpsZE9nNll6WkFnUkhXSVBlUDR5Zm1na0JrMk1iaytU?=
 =?utf-8?B?eEJsWmZRS3NyeEcrYU1WdGhjYjdWbi9SenlwM0JUaVE5RjY0SFBjT0lNVzhi?=
 =?utf-8?B?MFFMc3k5RlRnNmwxWkpSN2tKVlhJcnJnMHEwNktvQVBRRThsUlJpbXpsMC83?=
 =?utf-8?B?YUJnb1RXTm1CZGtEZ1UyaEd4eHJ6dlY5QXBkOWJKdmNXT2ExMDVrQWx3R3hC?=
 =?utf-8?B?UmNLajNaNHVSZzhablU0eEFTdlNFTHBnOTlGT3IyTkh4bU1rREFEQ1RtSHNE?=
 =?utf-8?B?cE5tZGFndERQRURXSkVWaTlKMEt4SDc4Qzd3UDdjSTlKV2RsRWhyZ1QyaGhG?=
 =?utf-8?B?RjNkTzkwY1F1WkpyUjhIeEY1UDlXaWhuOHlmZzVES25hR0ZWWklHWnkrK2Q5?=
 =?utf-8?B?cDhHMXNVNXFLYjcvcE1ySFN5TmtxZFhycDU5ZXp0cFFvbDVOTzdsVWU1UmRj?=
 =?utf-8?B?bXpFWFFCRWZDYzNyODBxVUFxMnRMczlqNmEvN0JSdkhwbXduL1FKVXIrL3E0?=
 =?utf-8?B?MmdNRkVlUUxxMGRlbHc0ZDRab1RQOFd4U0RyV2pzVXBiNGNjcjBHZ3lwckl0?=
 =?utf-8?B?cG0yRTljN1hjYVRCTjArNTI4ZUNRWDIxck9CbnlLdVhMNDFKVjlyS012YnhJ?=
 =?utf-8?B?bndlWkZrb2h3Ym9HVzZSa3ZneGo2M1oxN0F3aTVoYnNuN1NKeTQ1UEd2TUpM?=
 =?utf-8?B?SzM4WjBLbFM2MEVVU0dmWllEclpGTGJJU1BRTkZoZFQxRmJLcEJTamNYMG4r?=
 =?utf-8?B?VnU2d1YwWElubjU2WGtPR3Z1MnBxMmRadjEvOWdreGVKTnNJRGtlTDZibmNR?=
 =?utf-8?B?ZS91WlY0L0ZmOUpmMVZITTFyVCtpM1JxaXFVYU1BeEtCZkNlc1RsQmt6Lzlk?=
 =?utf-8?B?YUJXYjlGVkF6bjJKbFRTQUVlRHJSdzlnQjc0ejZZRTI5YWExY2xUWDU5Qmhx?=
 =?utf-8?B?T2llb1BIby9JcXhGNmhRcjQ3WjVDV0NrTHlZMFU2cUxSSEthb2VCYUs1WWRU?=
 =?utf-8?B?RjdWVnliMWk4eUsvblNWK3hJdEJhNmFkbHBxQ1BTRXVEbHE5SnEzV3p6WEtv?=
 =?utf-8?Q?3Uqqz/7SVV6Drmpo=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42b0062-bc6c-4192-a704-08de6aeaba32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:29:11.3984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSAQOz1gfxG8TQCBXJv0O0EJleNG9qUG6y6NC/XIKeunGlbmjLGne8ZlDbjNDbbCYhQ0/ZvQDOCPMn6v6ITl9C5wBn6FSNk5+ZYRyaIs9/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8416
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4MCBTYWx0ZWRfXzd4XWKGHh36T
 qZXSbbQNEmiOU+KKzESdi0er44eUdlKyG47Mq8BfphXBnXjPuL4DRnAbG6CVISVu4VzfMjrTcgn
 F8MsFD2fkN//u4QWVTIM8frYoaqyRAdQrDPSFvwwtCA7jr3RJrHVVq72724oF2PN92zp7JsR3Yh
 MzngF+MmYc5188wZs1vHc4B7Oloj/gF3PbIdD7QnHUq/p1lH/9F3USvxJo++Of0gY9dlz5wgT5g
 szttb3L8QCxW1McpOlxCPcwjtEYbdN6MsUHOYLLIV0wvSrgh/H3efJk/a4rRI7T3ruGV+hhsdug
 XWZhKBhV9lXu6ETyReIwnuglhDfK+DpklXyogcezzzVEIUNVeYql/MsM3kQVrtdS4O0akwYnGiP
 w+O91I1bm4Gw+Q52lUeBXLpufKAMcq00HuvyWEszd1oMZhtMmA3Yl1jRQEktscmQo9BcQuPeN5B
 lYFHkSBnvugZ6taJvIw==
X-Proofpoint-GUID: bDXfwTbfoa9ntv24OQNkHD1-V1n9el6H
X-Authority-Analysis: v=2.4 cv=NoHcssdJ c=1 sm=1 tr=0 ts=698efcf8 cx=c_pps
 a=GdPAKRNZCFWq8uDyhvyBig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=x9yPCtKXQY2UeJxozoEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bDXfwTbfoa9ntv24OQNkHD1-V1n9el6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Remove the legacy driver init/fini callbacks from the CoreAudio backend.
> 
> Both coreaudio_audio_init() and coreaudio_audio_fini() were no-ops that
> performed no real initialization or cleanup work. Access to the
> Audiodev is now through hw->s->dev instead of the drv_opaque pointer.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/coreaudio.m | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 710ef0fe6ba..4ab2abfc6f7 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -579,7 +579,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
>       OSStatus status;
>       coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
>       int err;
> -    Audiodev *dev = drv_opaque;
> +    Audiodev *dev = hw->s->dev;
>       AudiodevCoreaudioPerDirectionOptions *cpdo = dev->u.coreaudio.out;
>       struct audsettings obt_as;
>   
> @@ -656,15 +656,6 @@ static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
>       update_device_playback_state(core);
>   }
>   
> -static void *coreaudio_audio_init(Audiodev *dev, Error **errp)
> -{
> -    return dev;
> -}
> -
> -static void coreaudio_audio_fini (void *opaque)
> -{
> -}
> -
>   static struct audio_pcm_ops coreaudio_pcm_ops = {
>       .init_out = coreaudio_init_out,
>       .fini_out = coreaudio_fini_out,
> @@ -681,8 +672,6 @@ static void coreaudio_audio_fini (void *opaque)
>   
>   static struct audio_driver coreaudio_audio_driver = {
>       .name           = "coreaudio",
> -    .init           = coreaudio_audio_init,
> -    .fini           = coreaudio_audio_fini,
>       .pcm_ops        = &coreaudio_pcm_ops,
>       .max_voices_out = 1,
>       .max_voices_in  = 0,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


