Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB05CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUye-0001Uv-Ny; Tue, 02 Sep 2025 13:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utUyW-0001KN-Nx; Tue, 02 Sep 2025 13:39:21 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utUyU-00053i-5L; Tue, 02 Sep 2025 13:39:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBuphm5h/HuN7ddP5dA6b1hhnsWObDiyWd4s3mgFRJfYaFyE3tUindgFy0XMS3U5r3caqrXasjnnwRrfUJ/+KqbBzgb7ptRx8V7EAimLkWlex0Psd2eMTVKK6reOdQTteZKEgRVJjj6GcfKDm3jxZT7W/oByp6WS0Tuz7csXIoLoLWUk8cb7K9wAwakWRK8WHeBB05NSBRucVe/g+As/FXIW87N0xDgEO/8QfbEZyLJmyiLZqkUReVXRBLQo1Ws/YXWGfH2rdwu6N3/l7zQhaCxvokQZJpBb5mawM2ZlC+mv/QZuKNYKeMBe5hR1EZEGLsDIXQvCvvMKCtlc2rmLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMDx4NPY+Miv286Zqh54CqdyjJwqEmVwjP5q/AP71AY=;
 b=v6z+VbT0f/duZMfssXpx0flk5kvvmgPtDWFcKp3fv7FyIdyD10kEIO6kb3UykJl3u24T7YZ47CinCeFRP98ePOVuag7zGSv8f7ipUhVU4TlOb9elsUDEPFZRTR8s4JLU9SSXJ4057WlPJMaspZcTv5gK3uUFbAsLUDozWXx9OW5fMlaj68LtyYOiq3MhK7Y2+MvNsscWsEUb+k04R/sIEYsQnsOnvPOxzHDDP5jpBZAUhu01i+a/s9iFHG4WjS9pRN56WvshGBOTmMk68Ed5FwcQz3Md8EJFL751CDhzsj6pByAuCK24pSax5vo0QdbYJj0MgVPior4Hbbmh5pbG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMDx4NPY+Miv286Zqh54CqdyjJwqEmVwjP5q/AP71AY=;
 b=JSI9tFQzfjapL9RymOxuDom2jVSpKKF37OwmyAKAnCv/cfZMySHYlrr4/IKqCBuVumS6ADyddpNFjpxYDbXo9+baNJtnbW/QNpXGaRqwIGZfBfrCsELir/UvKWrnHNqh7olET9LjW1ngCnA7L/3VEI5LzAc3dHRl2QXm/Ns71vJjFaGMow7TTOO5Csy4yTd/RdAq3pqh4dOH+vSsIgpMz275TbgzAwA3kDnZxPprjnfBLbCZoEwyKpTiqinJWzddO6+yPmihC4DmjCGdIL4psD3CWLGpzajE9IULNQ2USoKvDTm9DrkuKV8XijZ2bzU3g2nbbQpeylb38Pnoe6vOBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV2PR10MB6455.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Tue, 2 Sep
 2025 17:39:11 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 17:39:11 +0000
Message-ID: <c84dcfe7-4938-4f5f-ae49-36f2f5f36da4@siemens.com>
Date: Tue, 2 Sep 2025 19:39:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Jan_L=C3=BCbbe?=
 <jlu@pengutronix.de>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
 <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
 <d21f6449-e646-42fc-8277-b011a886e9c9@linaro.org>
 <41d2e67e-3345-4720-b3aa-1051224025de@siemens.com>
 <21b6726a-1ceb-4782-a219-36f32cebb774@siemens.com>
 <CANCZdfrTouq9JVPQqxFdKttZ0xqfgPAjMX8fLNVEf+YdLwDhtg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CANCZdfrTouq9JVPQqxFdKttZ0xqfgPAjMX8fLNVEf+YdLwDhtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:610:4e::30) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV2PR10MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b471d9-3b35-41b1-e3f8-08ddea47a02d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnBCVDFuOWtWd3ZPVnR6VmZMY0cyT1IyelFWMXBtaE9uVElSVWxDZmJYbFRH?=
 =?utf-8?B?dG1sbThtN0Y0Mm1QcmtrczQ5bjlMeVNiNlBXbzVYcXhCQ0ZUL0UxYWNWSEYv?=
 =?utf-8?B?ckdTcHljbk5ybGhETTl1M0FEcytHM0N1dngwa0c0L2hOZ25KdTcrV3NuZVNO?=
 =?utf-8?B?YUVUVUEwV1VPWk1FUVBNbGpiYXU3Tmg2VW1MT3IvMTlzaFZEZjZFUXdJSmVk?=
 =?utf-8?B?aUxINElKbjBiZk1xaXpOcTRyRDFhMnhScVYvZXJJTEs2MFYvaEVETUVTVUdj?=
 =?utf-8?B?cEpyZ1hIWHJHSFdjcEpCL083bTJhT3ovRVhNaDd3QjE2QTJpcHlQV1hISDR5?=
 =?utf-8?B?bDlUMTZNVE1vRFNxM0pTRzNQQmsybTN5ZHhURFV6T2dhNXZkaFdEb2RZWFhx?=
 =?utf-8?B?WlMzVjdkTXhDUWxUYUtvWlp1RFZqTU96cEhUS2RqOHlkbW9lVVQwR1Npc2Ft?=
 =?utf-8?B?YmZWT3BEQ3gzR1YzOWVIWnowUiszUFY4TUM1MytZRXBid1dFSTRRVWQ3RTZ2?=
 =?utf-8?B?YXNTMENPejJkRDhGZ0dXR0JUbFVXSzEzbkxtaE1nS2gvZ2hrUUlrWFM3MEh3?=
 =?utf-8?B?cDdPeU5yUTZWMFpiWmpaa2RZaVZQS1NHWGY3OCtrVVJnZEtXbi9Fai9jUnln?=
 =?utf-8?B?VUZ6MXBPVHRTN3F0MlQ2cHZXTW1GSHZKRy90a0FlRTBKN0FOL0Y4eVdaZ2t2?=
 =?utf-8?B?Z0JIUUR1QWpoaXI1REpzZEpvQTJzOXAycFNQdWxuc1l2S0hQdGpsRVlqeGpM?=
 =?utf-8?B?ak81TXRtOEJGbnY4d3RMNE1tZjIvQTZKTHN4WmFzZ29OKzNvazdqeXM1OEFW?=
 =?utf-8?B?U05TeUs2QjVjdVV5TUorSmpGVEorRFpUSXZ1cEl1bWZwVEU1VjQvZzFwUzN4?=
 =?utf-8?B?cXBOOEpjNi9GWlBUd2V3czNXU3BLUU8zMks2YlVXcllLdCtnek5oVzFmVUhh?=
 =?utf-8?B?NVFWNDh0S3h1SjRuSEJJbWc3OXVmUWlrYjlVdzlHRTZSSFhYRnJ3ZUJUS0Iv?=
 =?utf-8?B?RnNRMVp4a2x6MjVSSnJYSEwzcmhxQzdGeWRBbzc0VXRBaTc0OGszN2VnSmMw?=
 =?utf-8?B?Zzd2TTZDSmtTRkZpbTJiV2cxU0I2NHVMWVhDbTROUTR3Yy8wdjJaaVBYTzk3?=
 =?utf-8?B?NmVLdWs5aHR1Tzk2NDFOL0VKazBySkpPY3pwZ2dIWk1EcEU2dk5jRDBRTXFy?=
 =?utf-8?B?ZlowS2pKQS9mU05Gc3UvaktydGVhTnNvV0tsSEpwSExseFZ0TCszdWlQZmdX?=
 =?utf-8?B?eFZ4U053R2xDaWZFUVd4dGRxS1J1d3N4UlVMQ3I1ZkpCeWdpSTF6TlNEMm9U?=
 =?utf-8?B?Z0k2ZEpNQjB4V0JFZ2kvVW5kSjMwaTJudHgyY25DRlQvTDhoMzJMeElCdm9w?=
 =?utf-8?B?S0xML1pOU0pHRzlOK1VKUjZ2Y1pISDA5S3hxcTZGQU10dk9BcUlWUFA3QzUx?=
 =?utf-8?B?RWU2S1hsR3hpM1JqSWhJOVhTWGJGTHcvS2RDM0ZTS3lxV0dEVVJ0aWg0UHlD?=
 =?utf-8?B?ZmFtQkV6SFMvem9kejFXWGxTUllvaE9odlF5OFhIZjk4U3NZLys3NDNLa0V0?=
 =?utf-8?B?MGM2ODM0TVduSzlzRU5NYVdLa0VBMy9UdVdqaWVINUdCcDdRa1lCMFlmOGNq?=
 =?utf-8?B?UmNjamRyUHlneS9wQVVaUnFzSkQyTTJtN0JqQWdpZHZuOWtFYUduL3lwUHpL?=
 =?utf-8?B?eHlYSnV4c3VPR0p0VG12NzZ6WkZKTWwzWDNXdlRCWUFKc0NLVGxGdmpQV3JI?=
 =?utf-8?B?YzhyWlZhTDk4alJ4TnB4aVJMTm40QUtnWEV2MzlITEw4YXdSaHVXSFN1VmR0?=
 =?utf-8?Q?6/RBvZvldtwgtOnkP3wdJvqnj6OCjBek+tUjU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJSZS9NOGxVZ05ZOTQyNEN3Qzg0UEJxMS95RmVKMnRteDViVVZ2YmhUOStz?=
 =?utf-8?B?OEtlSXVIMFRzYUE5Mi95WTVUbHVLdlNITzNNMlppQ1NQK2t6WjJ5czdHR3d5?=
 =?utf-8?B?VFVRMGw5ZkJCTENYeGtrYURLNEt4V055QzMxaDQ4cGxSWUFYc0ZkdTV1TG84?=
 =?utf-8?B?T3I0eFM0ZG1IcWJXTUNpa25SMjkwTlhNUllwWmxMMXFjZmJ1WnZvbkZwY3Bm?=
 =?utf-8?B?Y0xpVHlFempPZUxzM2VDR2grYlRjeWJJS2F5VDFHYXJCbGd2d3grd3hQTHlv?=
 =?utf-8?B?WmZIdVowRENrSDZ1UnVORERPaGdPZjR3dkxuK2o2OTEwckgwNFh2VVFIVDh5?=
 =?utf-8?B?dHExWm9KSnVFcmhpY2tZSENMME1aNGQ1ZlNkbEpPc3UwdHNGZlE2YWdzLzc5?=
 =?utf-8?B?WStZQm5HODh1Y245OWo5VFdCa0U1RzZWOWE2dVhxaVRzcW5mV1N5SXVRdUhl?=
 =?utf-8?B?OE9oR0F3Z3Y2WEJvekV3dU9YSlBlOThNNXdDRWNpbXlKdE5JMzFSSVMvS2lT?=
 =?utf-8?B?TzhkdjJOb0cralRabThzUHFzWmhJYUtZU1d1aVJaSGhsd2ZGV0hqT3NQUjRD?=
 =?utf-8?B?bktnMHBKUk56dVNvY0I4Q0dKcVJFVUV0UWFMZ3JuR1cyWG1WQXJvdVI3UnY3?=
 =?utf-8?B?cDhaYysvQWQxR3dDOEZkSTRZYjNicVJWWjJ4dVoxS1FhMFhrMG4zWTZXVG9a?=
 =?utf-8?B?U2lVZU9LVTNPSVNTemplSTJEamJQY2krSGl4czRwZStyUmxvNndScXp4dHdD?=
 =?utf-8?B?cWhjeTlTWFNvcDFhWG9vUnJzU1JjckV0NDBROC9Qd3RvVG1mY0t2dGlnYXN3?=
 =?utf-8?B?dnljbkhnbC84REtxT1E5bXNmcEZ2R0poOTh4bVo0WHhmeG1vNjBsK2F3d1R2?=
 =?utf-8?B?aU1HRnZLRDVITU1UMXdkK0VrUVNSWHgxRy8rclR0eSsvNTluSWZDNFM4UnVa?=
 =?utf-8?B?SHhBT0FiK08zQ1RObU9MYS9DcWpTKzVDUnhHTXlLditxcjR3NEt4TlQ0QnNm?=
 =?utf-8?B?N3hoWURBSnViZTN3S3NBUmt6c3VFdDJ6UU01ZCtSWnRrQW1nRkVUQ29YK2pK?=
 =?utf-8?B?QmxxaGJXQ1NKWUFOaVVqWUFxRDU4bVNyOGE5T2NqbjZFMlhTNUlWWjZTMnZt?=
 =?utf-8?B?WWVQelpNSndaU2MzdmFyOHEzMDVlM2FIZ3IxNVdMVUNsRGkraVpGVGNEenNi?=
 =?utf-8?B?alJFNFVvR0xxTGhPYVArS2twWmVRbVhEcktubDRFZEZwTTBtTlhJU3Q3UEpR?=
 =?utf-8?B?NzAwRTZOTkdFeWVZdlhIRmdzZW5yQllnV3I4SEtNSDR4Q1pTUFQzNHhEUlVN?=
 =?utf-8?B?WmFQVSthdDh2NnNQYzMrK2wvWDBZQnFLQVRCbXN3Z1QycEtMakh5M2ZIdzdl?=
 =?utf-8?B?OXBzU2ExNmhSTFRjUUEyYWtYMm5STzY4S2FUclNYYlI0MEhLNzJJKzUxZGgz?=
 =?utf-8?B?UzhrOFNSVUoxNTI3djRQV0ZSTll2NWlWZWRhcjhxZXpYYVlNd0owNWVGUjY3?=
 =?utf-8?B?Zmo1R1VSOE1DUVNzV25uNXpRb01PVFUwb3N6dFQ5MmZybG9OVTZWbnM1dC84?=
 =?utf-8?B?MFAxaUNDaE5OZEhTZTZkeHB2S3lxMVNIS2QxN04vRUVITG5HaFR1SWljdTRN?=
 =?utf-8?B?Vm8yQnRRN3BqSDNIaUFIc3BHZGYyenQwWkkya0tuOFNBTy83VVlYQXd2TzdY?=
 =?utf-8?B?QjUyVzBOTklVdUt4RlMxSFZCc1BGVVpZVUQ1bEhGNENNbGNMZ3NWZmh5LzZs?=
 =?utf-8?B?WG5NK0l2MjhjekoxMk96U1VyeEVmczZYWkN5aFUrSEIwWU5OSzVlazNKNE85?=
 =?utf-8?B?NG5NN2l4QWVINlpzUGhkcCtzR3BOeWkwWWxhVzhZT3lBakp0L3dpelloWVlP?=
 =?utf-8?B?NHZNTXExb1o1ZlhFbkM0NEh1dHFOR1I2ZnZUMmlScEQ1SGxJbGRsRkozRXJq?=
 =?utf-8?B?SnArTEpZeUJxY0tYalJrTHI3VWxpeWxvRnEyV1N5V2VqRy8rSCtKeDNFK1Vx?=
 =?utf-8?B?TkFwMS80QmhTVHE0RFkrR3VaOERETWhUamVTV2FlYklYcXlIWUU4b2MrWEJ2?=
 =?utf-8?B?R3JOZjFUcG1pVUZoUDhBK3lCQk9FV0xMRzAyQ0w0QmQ3MFcwSTdhUFpnSlk4?=
 =?utf-8?B?VzdCMmpDK25VdXFaQXpDa1V4YmxaRTZnUm93SzhpbWhsWGRIQU1MMm4rYkZ5?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b471d9-3b35-41b1-e3f8-08ddea47a02d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:39:11.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alwo6Cx8rFYsj0W3zUD5Q65t5XBlVMNe23omEgaeJzl2hOBGkiG4PmPect+QyOe5t6yjYE0A+VUZkTjvH7U6pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6455
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URI_HEX=0.1 autolearn=no autolearn_force=no
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

On 02.09.25 19:20, Warner Losh wrote:
> 
> 
> On Tue, Sep 2, 2025 at 10:40 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 02.09.25 18:24, Jan Kiszka wrote:
>     > On 02.09.25 18:20, Philippe Mathieu-Daudé wrote:
>     >> On 2/9/25 18:14, Philippe Mathieu-Daudé wrote:
>     >>> On 2/9/25 18:00, Cédric Le Goater wrote:
>     >>>> On 9/2/25 17:55, Philippe Mathieu-Daudé wrote:
>     >>>>> On 2/9/25 17:47, Cédric Le Goater wrote:
>     >>>>>> On 9/2/25 17:45, Philippe Mathieu-Daudé wrote:
>     >>>>>>> On 2/9/25 17:43, Philippe Mathieu-Daudé wrote:
>     >>>>>>>> On 2/9/25 17:34, Jan Kiszka wrote:
>     >>>>>>>>> On 02.09.25 17:06, Philippe Mathieu-Daudé wrote:
>     >>>>>>>>>> On 1/9/25 07:56, Jan Kiszka wrote:
>     >>>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>>
>     >>>>>>>>>>>
>     >>>>>>>>>>> The power-of-2 rule applies to the user data area, not the
>     >>>>>>>>>>> complete
>     >>>>>>>>>>> block image. The latter can be concatenation of boot
>     partition
>     >>>>>>>>>>> images
>     >>>>>>>>>>> and the user data.
>     >>>>>>>>>>>
>     >>>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>>
>     >>>>>>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
>     >>>>>>>>>>> ---
>     >>>>>>>>>>>    hw/sd/sd.c | 2 +-
>     >>>>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>     >>>>>>>>>>>
>     >>>>>>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>     >>>>>>>>>>> index 8c290595f0..16aee210b4 100644
>     >>>>>>>>>>> --- a/hw/sd/sd.c
>     >>>>>>>>>>> +++ b/hw/sd/sd.c
>     >>>>>>>>>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState
>     *dev,
>     >>>>>>>>>>> Error
>     >>>>>>>>>>> **errp)
>     >>>>>>>>>>>                return;
>     >>>>>>>>>>>            }
>     >>>>>>>>>>>    -        blk_size = blk_getlength(sd->blk);
>     >>>>>>>>>>> +        blk_size = blk_getlength(sd->blk) - sd-
>     >>>>>>>>>>>> boot_part_size * 2;
>     >>>>>>>>>>>            if (blk_size > 0 && !is_power_of_2(blk_size)) {
>     >>>>>>>>>>>                int64_t blk_size_aligned =
>     pow2ceil(blk_size);
>     >>>>>>>>>>>                char *blk_size_str;
>     >>>>>>>>>>
>     >>>>>>>>>> This seems to break the tests/functional/arm/
>     >>>>>>>>>> test_aspeed_rainier.py
>     >>>>>>>>>> test due to mmc-p10bmc-20240617.qcow2 size:
>     >>>>>>>>>>
>     >>>>>>>>>> Command: /builds/qemu-project/qemu/build/qemu-system-arm -
>     >>>>>>>>>> display none -
>     >>>>>>>>>> vga none -chardev socket,id=mon,fd=5 -mon
>     >>>>>>>>>> chardev=mon,mode=control -
>     >>>>>>>>>> machine rainier-bmc -chardev socket,id=console,fd=10 -serial
>     >>>>>>>>>> chardev:console -drive file=/builds/qemu-project/qemu/
>     >>>>>>>>>> functional- cache/
>     >>>>>>>>>> download/
>     >>>>>>>>>>
>     d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 -net nic -net user -snapshot
>     >>>>>>>>>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
>     >>>>>>>>>> SD card size has to be a power of 2, e.g. 16 GiB.
>     >>>>>>>>>>
>     >>>>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
>     <https://gitlab.com/qemu-project/qemu/-/jobs/11217561316>
>     >>>>>>>>>>
>     >>>>>>>>>
>     >>>>>>>>> Hmm, then the test was always wrong as well. I suspect the
>     >>>>>>>>> aspeed is
>     >>>>>>>>> enabling boot partitions by default, and the image was created
>     >>>>>>>>> to pass
>     >>>>>>>>> the wrong alignment check. Where / by whom is the image
>     maintained?
>     >>>>>>>>
>     >>>>>>>> Cédric Le Goater (Cc'ed).
>     >>>>>>>>
>     >>>>>>>> The test comes from:
>     >>>>>>>> https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb-
>     <https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb->
>     >>>>>>>> a85f-09964268533d@kaod.org/ <http://
>     a85f-09964268533d@kaod.org/>
>     >>>>>>>>
>     >>>>>>>> Maybe also relevant to your suspicion:
>     >>>>>>>> https://lore.kernel.org/qemu-devel/e401d119-402e-0edd-
>     <https://lore.kernel.org/qemu-devel/e401d119-402e-0edd->
>     >>>>>>>> c2bf-28950ba48ccb@kaod.org/ <http://
>     c2bf-28950ba48ccb@kaod.org/>
>     >>>
>     >>> [*]
>     >>>
>     >>>>>>>
>     >>>>>>> Digging further:
>     >>>>>>> https://lore.kernel.org/qemu- <https://lore.kernel.org/qemu->
>     >>>>>>>
>     devel/9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/
>     <http://9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/>
>     >>>>>>>
>     >>>>>>
>     >>>>>> yes commit c078298301a8 might have some impact there.
>     >>>>>
>     >>>>> With Jan patch, your script doesn't need anymore the
>     >>>>>
>     >>>>>    echo "Fixing size to keep qemu happy..."
>     >>>>>
>     >>>>> kludge.
>     >>>>
>     >>>> which script ?
>     >>>
>     >>> The one you pasted in [*]:
>     >>>
>     >>> -- 
>     >>> #!/bin/sh
>     >>>
>     >>> URLBASE=https://jenkins.openbmc.org/view/latest/job/latest-
>     master/ <https://jenkins.openbmc.org/view/latest/job/latest-master/>
>     >>> label=docker-builder,target=witherspoon-tacoma/lastSuccessfulBuild/
>     >>> artifact/openbmc/build/tmp/deploy/images/witherspoon-tacoma/
>     >>>
>     >>> IMAGESIZE=128
>     >>> OUTFILE=mmc.img
>     >>>
>     >>> FILES="u-boot.bin u-boot-spl.bin obmc-phosphor-image-witherspoon-
>     >>> tacoma.wic.xz"
>     >>>
>     >>> for file in ${FILES}; do
>     >>>
>     >>>      if test -f ${file}; then
>     >>>          echo "${file}: Already downloaded"
>     >>>      else
>     >>>          echo "${file}: Downloading"
>     >>>          wget -nv ${URLBASE}/${file}
>     >>>      fi
>     >>> done
>     >>>
>     >>> echo
>     >>>
>     >>> echo "Creating empty image..."
>     >>> dd status=none if=/dev/zero of=${OUTFILE} bs=1M count=${IMAGESIZE}
>     >>> echo "Adding SPL..."
>     >>> dd status=none if=u-boot-spl.bin of=${OUTFILE} conv=notrunc
>     >>> echo "Adding u-boot..."
>     >>> dd status=none if=u-boot.bin of=${OUTFILE} conv=notrunc bs=1K
>     seek=64
>     >>> echo "Adding userdata..."
>     >>> unxz -c obmc-phosphor-image-witherspoon-tacoma.wic.xz | dd
>     >>> status=progress of=${OUTFILE} conv=notrunc bs=1M seek=2
>     >>> echo "Fixing size to keep qemu happy..."
>     >>> truncate --size 16G ${OUTFILE}
>     >>>
>     >>> echo "Done!"
>     >>> echo
>     >>> echo " qemu-system-arm -M tacoma-bmc -nographic -drive
>     >>> file=mmc.img,if=sd,index=2,format=raw"
>     >>> ---
>     >>
>     >> FTR the alignment check was added to shut up fuzzed CVEs in commit
>     >> a9bcedd15a5 ("hw/sd/sdcard: Do not allow invalid SD card sizes"):
>     >>
>     >>     QEMU allows to create SD card with unrealistic sizes. This could
>     >>     work, but some guests (at least Linux) consider sizes that
>     are not
>     >>     a power of 2 as a firmware bug and fix the card size to the next
>     >>     power of 2.
>     >>
>     >>     While the possibility to use small SD card images has been
>     seen as
>     >>     a feature, it became a bug with CVE-2020-13253, where the
>     guest is
>     >>     able to do OOB read/write accesses past the image size end.
>     >>
>     >>     In a pair of commits we will fix CVE-2020-13253 as:
>     >>
>     >>         Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>     >>         occurred and no data transfer is performed.
>     >>
>     >>         Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>     >>         occurred and no data transfer is performed.
>     >>
>     >>         WP_VIOLATION errors are not modified: the error bit is
>     set, we
>     >>         stay in receive-data state, wait for a stop command. All
>     further
>     >>         data transfer is ignored. See the check on sd->card_status at
>     >>         the beginning of sd_read_data() and sd_write_data().
>     >>
>     >>     While this is the correct behavior, in case QEMU create
>     smaller SD
>     >>     cards, guests still try to access past the image size end,
>     and QEMU
>     >>     considers this is an invalid address, thus "all further data
>     >>     transfer is ignored". This is wrong and make the guest
>     looping until
>     >>     eventually timeouts.
>     >>
>     >>     Fix by not allowing invalid SD card sizes (suggesting the
>     expected
>     >>     size as a hint):
>     >>
>     >>       $ qemu-system-arm -M orangepi-pc -drive
>     >> file=rootfs.ext2,if=sd,format=raw
>     >>       qemu-system-arm: Invalid SD card size: 60 MiB
>     >>       SD card size has to be a power of 2, e.g. 64 MiB.
>     >>       You can resize disk images with 'qemu-img resize
>     <imagefile> <new-
>     >> size>'
>     >>       (note that this will lose data if you make the image
>     smaller than
>     >> it currently is).
>     >>
>     >>
>     >> I expect us to be safe and able to deal with non-pow2 regions if
>     we use
>     >> QEMUSGList from the "system/dma.h" API. But this is a rework
>     nobody had
>     >> time to do so far.
>     >
>     > We have to tell two things apart: partitions sizes on the one side and
>     > backing storage sizes. The partitions sizes are (to my reading)
>     clearly
>     > defined in the spec, and the user partition (alone!) has to be
>     power of
>     > 2. The boot and RPMB partitions are multiples of 128K. The sum of them
>     > all is nowhere limited to power of 2 or even only multiples of 128K.
>     >
> 
>     Re-reading the part of the device capacity, the rules are more complex:
>      - power of two up to 2 GB
>      - multiple of 512 bytes beyond that
> 
> 
> Kinda. It is power of 2 up to 2GiB, but there were a number of 4GiB cards
> that were not high capacity cards that encoded their size and were otherwise
> low capacity cards. Qemu doesn't need to support that. Its existing capacity
> check should be enough.
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index da5bdd134a..18b3f93965 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2151,7 +2151,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
>          }
> 
>          blk_size = blk_getlength(sd->blk);
> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> +        if (blk_size > 0 && (blksize < SDSC_MAX_CAPACITY && !
> is_power_of_2(blk_size)) {

Close but not yet correct: <=

I have a patch under test for staging that also enforces the 512-byte rule.

Jan

>              int64_t blk_size_aligned = pow2ceil(blk_size);
>              char *blk_size_str;
> 
> is what I'm running with, but it should have a second check for 512k
> size if not an ext_csd situation.
> 
> High capacity cards, though have a limitation where it's the number of
> 1024 sectors (which are 512 bytes), so the limit is 512k. It encodes the
> CSD differently than normal capacity cards. Thankfully, we have this in
> our code already.
> 
> And really high capacity cards have an extended structure the size of
> the card is reported in, and that appears to be in sectors.
>  
> 
>     So that power-of-two enforcement was and still is likely too strict.
> 
> 
> Agreed.
> 
> Warner
>  
> 
>     But I still see no indication, neither in the existing eMMC code of QEMU
>     nor the spec, that the boot and RPMB partition sizes are included in
>     that.
> 
>     Jan
> 
>     -- 
>     Siemens AG, Foundational Technologies
>     Linux Expert Center
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

