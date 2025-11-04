Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B4CCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKQi-0003Ve-Gk; Tue, 04 Nov 2025 12:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGKOR-0002vo-Lt; Tue, 04 Nov 2025 12:00:35 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGKOK-0007Rs-BW; Tue, 04 Nov 2025 12:00:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt4Fk8ZxaaTqrOUTk7RvwoIPgEFtQ1Jiw+YzfzNHhllKjRc28YBw9X3ZeXlOOK334uB4F4703KzXJbmsw7LL29CmX1FAGrDiHg/la0gV2ZchCbrqmmgiEJu0R/u0bMH5+aPKxIZy/WmtFDcuKLVe9AA4OPpvpuCwzHjoreWw2lxQp+ZDKbAKqm4Caw+xpPuGgUrG7Qd3TmjGk/3LSsTCujB+V1SOxt6TA1x5AUg5/kmr30LoiugprqUi4Onw46u4F0ssjG09vhLsQs4ceFrqQORqQU9muWHmyWSXckWIPfe/hnpgIfuwTBjnGxlAcRdVOfqg0x1AAHKEz69p/LU4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5n9h1v8Vl4790wW/CJd2RNFha7m1eL/UaP9vXD4+0c=;
 b=Fb2K7Dqr5vUnF/QMwh2qvRvDQwwrpwCYokl1y5slJd7s7yEQxQxBj1omZw9iGMZr9T3vtSWW0EuqrXsS42ZpjMZ2fcjU4ZyiZnDhZ2XvqVsWASMWxYMj19neQuASzeJybzQ+nObTcH/Ueauhd7F43ZzVlEugdch+Dp5m1H3s1PKje21KVXif89lGczOlKq/gyVLc0/wn1cVhPkEgEA0RjS/LCrUnSl/jhC3O3gQFmznZtBIxVKlBp5LDMS+ug4GDhS893peZ6RCz6lLN83L+53Ao3m+uc8ptZoXxUFXbHz0l6FmFdSKmvqF3657oBAInjUwWMdGWjxs7uKZkMXvRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5n9h1v8Vl4790wW/CJd2RNFha7m1eL/UaP9vXD4+0c=;
 b=eEcUqa97bS+cM9Vwx2isN7CE452gM87IoAT7YCwW/G6HQDzxYQHNPSSLoE6om5EPOtqg/FdnDd25Z1+SaTdLZAwUFof1tBWdLTPf29fpM61Khar+8pAOnc8kzSVt+XtvElDsJ6BTRYsohKZ/uhlGp7eEb1q17pIEWRBicEJ9uwtICrqc1UqctunHqKLXozMpcTk2R6s/XlEaMZj/l9oNpw7J0lJn2PDGm8ZY+3E0jSwMzPHps+KRVMdzN3gD53FuvEpFyR4MFBsMWMeVCi1rqaVTmrLc1jlNQ+G2+/R0iamMJt/HUF2k66Wm/oH00Q+amCZo1O6B5XJgaT7fVYFs+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5189.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:00:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 17:00:13 +0000
Message-ID: <c3bfb192-aad0-4fcb-a787-78f3a2d19695@siemens.com>
Date: Tue, 4 Nov 2025 18:00:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.1 5/6] scripts: Add helper script to generate eMMC
 block device images
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <60f265e0b2bea18fe6ef41742600a7e933e3c47f.1762261430.git.jan.kiszka@siemens.com>
 <eecefa8e-44ae-45ff-85d0-3f9b786948e0@siemens.com>
 <8884e7f9-eff4-4bbd-be5e-9d6d2012ff6c@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8884e7f9-eff4-4bbd-be5e-9d6d2012ff6c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: de561578-e47a-4070-86e6-08de1bc39f2b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWVxeGdEZlV1cXBvNWJNcEZlN1I4UEFuUm1YamREMHBPcmJsR3FmUlpYQXph?=
 =?utf-8?B?ZFAzVW95UUN2YWNwaDI5OVBsbEd4aVU2M2VTMmVtMkVGZ2dXQmsxZjN2YkZZ?=
 =?utf-8?B?Z2swMHU1QlRlY1pWRnR3NzZtMXoxbG1yS0lmUUFpaGx5MVQyQzdJbTI0WGJ2?=
 =?utf-8?B?Ym9DN3pFWU82UzdldnZ2L1pQMkZ0R0JvU1NhdU1VZGMzSFRhY29Kc2VHc3NZ?=
 =?utf-8?B?MzdTWTFraW44aXpDQXgvY2VxSEt3VGc4NUNEYkpBMGh6d0g4dTFlR1ZIL1FC?=
 =?utf-8?B?dGNOZ0xWbU5TbWhBRFhXOUE4ZXY5OCtTWURIN2xYckJiMWJ3c2RSMjhBcm16?=
 =?utf-8?B?TXRHazNkK2dBcGNiT0tlRW1sUUVTeXNxbENXV3E2cVJBcWZrcWs0UUFOcFJX?=
 =?utf-8?B?SnorWjZrQjBmZjV2KzV6aFRhN0lQSFk0dFNJNkFpZVJTQzhMZmxaTFZGcTVh?=
 =?utf-8?B?Y3pqbVg1VzBWMkJCaE1zMmFhME0wSGVMc0MzSkRoREt1eFkxM2NpWFNubmlm?=
 =?utf-8?B?WWVsc3hMWTBhSFFPbzZGdU5veHczM0VkWEhBc0hRaElvUSt4aFNiaDFiYWNJ?=
 =?utf-8?B?QTlyTU13Q3pNb3Y4bnhST1U2YTc4Q2NGZ1c0QUR3SjNaUmlkMmtraFFtSjFu?=
 =?utf-8?B?L0R2b1pGZnVpK1R4eUNwY0VRNFUvWDFYNGt6NDd5YTFTWkdDUzF6NWFmUVNx?=
 =?utf-8?B?dTZuQndLd3NockxHeW9DV05JWUZFK2FQL2J4aE0zQksyL1o5U3BBVldIeFpI?=
 =?utf-8?B?OS9wNktCd3BLK0sxRG44VU9NL0VuZWpEMTEzbzlZNnFzUDhOY2tjWUhQUHRx?=
 =?utf-8?B?V3VZTmkzblhsQllNYVVqcDJqaXhRSFNxc1ZkRmlvMEF5TTBIaVJmUmdHdHhD?=
 =?utf-8?B?aWlaRXZGdGpwWGtSYW1xeVlpSFAzTEZvOFVqYnd4R1FCV25xTnZrbFZ3SThQ?=
 =?utf-8?B?NGFta2sxSnptWGFPUDFTZUZDeTN1cjNzdFJkaE9uTUoyZlg3bG1XNzRSOVJj?=
 =?utf-8?B?anlHWDdVekxMNDQrYmY0b1VXWkk3UitRdGQ1VGhEelVCZEs3ZVpxY0U2YXFJ?=
 =?utf-8?B?TDExb2xWb2lSNGU0S05GcmRjcGtaOGdEU0NyZnkxZFV4eWdtTk91UE1NZXFy?=
 =?utf-8?B?Y3RINzFuckJQQTZzUlp6NExqbjBsUlpyZ2svWEp5QTU4TU05NjU1SXZBdWht?=
 =?utf-8?B?WWVPK1dIbzh4S3ZKUUhFTVlLWk13eUtMNVUvK1o0MWJYQnQ2UHVQbmVwNXRp?=
 =?utf-8?B?ckRqNzNlYlQwS0psUHkxYld3Nm1KaW02ZFhaVWo0VjcyMDZDcW1IWVNwUSt4?=
 =?utf-8?B?bExYckk0cjRtY2kwREsxenRWREsxN3VheDkvSGdiamJaTnNqUGFxMDdGaVJS?=
 =?utf-8?B?NzQvTm9HUmIyK00rZUZsM3g5QXQrVHRtQjVNQzFGVVNXcHlib3FMblo1ZjBE?=
 =?utf-8?B?T1lhQUt2ckh1RXJEV2ZEWFFYNFJjRmdZRDZuZWZFZmZDUWtYczFyaE9MUFBj?=
 =?utf-8?B?dk1NQmwxWitnRmFSRTJmeWdzVjVtSXBYOHppdHdrZ3NtdlA3YTI4V28wcVUv?=
 =?utf-8?B?MzBtWWVuWnYzU3N6bkdWOUQzRThjUEViRmtsQitsc0VmMW9jUjRMa1c1QUNV?=
 =?utf-8?B?MU1JU2JQbmp2cVNSYUg2dGRlenRGcjNnQWZUa3QxL2Y3REVzYm5lZVlWdjlY?=
 =?utf-8?B?L3h0MktnMUhmUDlOZGdCWmlTUDN4OGIrQ1J0ZkQ4R1FvR2cvNU9VS3gyU3VM?=
 =?utf-8?B?cFR5MGFBT0pTVjZxK0J6YitMVEdpQytONDF4WmQrbkQwdDIvUlczOE44N1J1?=
 =?utf-8?B?TXZXWWhja3pPVitsMThwc0VCemRmZ1Q2WDFFTGJLNWM2NjE1MGlWRlBIMk5Y?=
 =?utf-8?B?OUFKaGNBK2FpcDY1QTc4cnFNSzlwUExwUWQzOVdtYndQY0pBdmFPSmlsZVZJ?=
 =?utf-8?Q?9JkGKla+cJnbN0jjglGPBdKviHS8P6nw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emRwNGtnT1hQU1p3SnlaOEVPL05OZGdkc2FUeXZiQzRQcU50MVFnY1BGNEwz?=
 =?utf-8?B?dGlNKzdacndEVWFYUGZoMng4dE96dDdIbWRLTVIyUHo5bDhQYTZ5dElVdVMz?=
 =?utf-8?B?VTlSaGQwY3RtRHpaUnRrUHNNM1d6ME1yeUQreFJjMEtKd2xzbFcxazhNZkdy?=
 =?utf-8?B?Zi9FaTVNM25FdmVKbk50Yk90dlFNUGNtK2RpZzZadWNCKy9LZTNWcTZqT2RL?=
 =?utf-8?B?ZXhNc3Rvc2VBQVBadEw1WmVrWXk0RVphZHNZREFRSEFhN3FSODhYOFhaVUxT?=
 =?utf-8?B?cWo4T3pTRzQvR3VFeE4rSkRHbTJvTEhEMlp1RFNobFVscFF1cVlITUdrdWZW?=
 =?utf-8?B?aUJod016VFlUanFHNEZwU3AyZVBiamVpQjN3UDBKSjZZU2tnMVlaemw0WC9Z?=
 =?utf-8?B?U0NYZVFYSHg3Y041YmZ0TUhBWlFMM0dleUUrTXd6RlMzaWF5Q240QkdqQW41?=
 =?utf-8?B?YTgrUXlwY3dDMzhVejNDbGRyUDZRMWd4T3F0cXV4TFFkdGE4UkhKa2svV0ZE?=
 =?utf-8?B?cWRWRzFNS1VObWNWa3BaL3Y3SS9RS1ZCbjVsK1YrcDdldzJ6dDVwMG0yWC9X?=
 =?utf-8?B?cFhRME4rd2JTMWxoMGJqWDdRcDN6TmRqdmtBYXo2bFUyaHI0NVE3VG9VVk5z?=
 =?utf-8?B?NnVPRnpCNGdFUGY1SXc1V3JiTFFuRklZanNUcldFM1F5bGcyQ0cva1FqK3Z3?=
 =?utf-8?B?cUcxcGVyeVNITllZUmlGeEZlcmNEWVlsR3I5MGRPa1k3NzAvTVlESTNBbFUr?=
 =?utf-8?B?UVdkdnltRHZ5Kzc0U2VkTlRHc3pyZGtLOC9JRXB1Q0xCNXJuNEFkVDc5NU1i?=
 =?utf-8?B?ZURxQWxBU0x0QnBrdVlQVnZ3UlgvTFZVSGc1Z0hCM3lBWGM3eFplcVU3TzM3?=
 =?utf-8?B?M0gyaUJ2VUxjR1VSeTE5cWhvSEp6cVBadjNLVlVYeTcxbVNlNTFITlN3Z2t1?=
 =?utf-8?B?OFV2NWNUR05aRDQ4YWliTHFXMjhncVNwUXBkamo2MUhxVHJOWXhoM3NIVTl2?=
 =?utf-8?B?UzgwTW9acEwrYytEVVFkSEdxMUJrN0F3UDljakpsM1ZNL3RqcmtQdkdndkJy?=
 =?utf-8?B?WXA0c3lFWTVwZHRoK3JnL2JzZ0hxOHcwa3lLTEVpUVJUdEZScXUrQVdBR1NQ?=
 =?utf-8?B?Ni9ScmEvUEhhcDZLMW9UV1h1SkwyQTNuUzRLWEVVVENLajlPdHFVeVpzNlU3?=
 =?utf-8?B?ZWlEcHNWblNXbDRXcUJqVXZtVDFJeVk4QUV6R2p0MEx6dUpTTWFaaDIrUFFM?=
 =?utf-8?B?eVRtSXY5dUhyQSthYmszVnk1cFVhZ1VMYVBaMlBJRXduU3B2K29GNUw3TkJK?=
 =?utf-8?B?TzNycE05ZnBNd2hJMlBPYVF2ZmVCY29SbzV4YXJ1bUl4NjZibG9MTlFyYzRJ?=
 =?utf-8?B?ZThkYU1sWnFuNCtVbnFuVVUzUXRGbUhyay9BRHl1dHZ1N2JKVU9tT1Y5bStu?=
 =?utf-8?B?MTg5WTZBbHZHMFg0cFFoMzBwMm85L3pneHdrM0IyS3dlR0l4N3JCMFJvTEpB?=
 =?utf-8?B?L2NhbWlCYnQwS2VTVUdWU0FodTRQS0NlWmszeksrYVlrdXJobUVEWlN0MVNw?=
 =?utf-8?B?SENGdzBJR0xpZHJzMzhFYW1wbXVjbDRrcy9WOGw5dzdhOTlrMlpOWkplVVJK?=
 =?utf-8?B?VFdaNnRvTm1WODRDN0lLeFNNYlhuV05pMUdDdW5lRFJPWXFPSndiZlIvNXBK?=
 =?utf-8?B?V2hwR2dUTlJCZE8vbVMxTHczUjNnYThNNm5HL2J5MmNsK0lTNkJHNWRLeFJx?=
 =?utf-8?B?NDl4dlpObStZTERnSGxUOURmVnpsNSthUEdnME5MZ01DQ1l1ZFdGbUxIVk5x?=
 =?utf-8?B?bnd5UzRxak52YjdDVnZ6NEpqU3hpU2ZObmFnNmJSRmpxbFpGZXFvT3M1SlVk?=
 =?utf-8?B?aG90aFFMYk9EcXltdVorWTlGQUFwSWNzSTZ1VGl5Q3E4T3IvY2gzMXZuY2tC?=
 =?utf-8?B?c3p0MmNNUS80YnJ0RENHdzRFNFU4Ry9od28yNHl4WjgzTWEyKzFBaXREamRE?=
 =?utf-8?B?d21PQTN2VlFyZ3pnamJkWFA3b0w1aWJKa1hRbUlWd3ZXM3U5SWlRMW5wdVhl?=
 =?utf-8?B?VmFjclZlTkZXa1FvL29NSEFTL0xCQXora3dnNUZRTDFyR0FOZGl5STZUQWRX?=
 =?utf-8?Q?w0jJFxmD8OlSYWm9mVJ9GgdD8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de561578-e47a-4070-86e6-08de1bc39f2b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:00:13.7322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CnU+NTNzLe8mqjOWNqn1+qoQWZ28pF9EI8JORktiGb/VJlefjDm0xSuhXpko3C6GlWkR5ae5OjKLyBbPOj6xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5189
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 04.11.25 17:27, Philippe Mathieu-Daudé wrote:
> On 4/11/25 15:45, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> As an eMMC block device image may consist of more than just the user
>> data partition, provide a helper script that can compose the image from
>> boot partitions, an RPMB partition and the user data image. The script
>> also does the required size validation and/or rounding.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Changes in v6.1:
>>   - address BSD shell portability issue of stat -c
>>
>>   scripts/mkemmc.sh | 219 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 219 insertions(+)
>>   create mode 100755 scripts/mkemmc.sh
> 
> 
>> +echo "Creating eMMC image"
>> +
>> +truncate -s 0 "$outimg"
>> +pos=0
>> +
>> +if [ "$bootsz" -gt 0 ]; then
>> +    echo "  Boot partition 1 and 2:   $((bootsz / 1024))K each"
>> +    blocks=$(( bootsz / (128 * 1024) ))
>> +    check_truncation "$bootimg1" "$bootsz"
>> +    dd if="$bootimg1" of="$outimg" conv=sparse bs=128K count=$blocks \
>> +        status=none
>> +    check_truncation "$bootimg2" "$bootsz"
>> +    dd if="$bootimg2" of="$outimg" conv=sparse bs=128K count=$blocks \
>> +        seek=$blocks status=none
>> +    pos=$((2 * bootsz))
>> +fi
>> +
>> +if [ "$rpmbsz" -gt 0 ]; then
>> +    echo "  RPMB partition:           $((rpmbsz / 1024))K"
>> +    blocks=$(( rpmbsz / (128 * 1024) ))
>> +    check_truncation "$rpmbimg" "$rpmbsz"
>> +    dd if="$rpmbimg" of="$outimg" conv=sparse bs=128K count=$blocks \
>> +        seek=$(( pos / (128 * 1024) )) status=none
>> +    pos=$((pos + rpmbsz))
>> +fi
> 
> Still:
> 
> $ dash scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
                                                         ^^
User error ;-). This must be just "...:2M".

> Invalid value '2MB' specified for /dev/zero image size.
> scripts/mkemmc.sh: 170: [: Illegal number:
> Creating eMMC image
>   Boot partition 1 and 2:   128K each
> scripts/mkemmc.sh: 192: [: Illegal number:
>   User data:                4 bytes
> 
> $ bash scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
> Invalid value '2MB' specified for /dev/zero image size.
> scripts/mkemmc.sh: line 170: [: : integer expression expected
> Creating eMMC image
>   Boot partition 1 and 2:   128K each
> scripts/mkemmc.sh: line 192: [: : integer expression expected
>   User data:                4 bytes
> 
> But now the file is generated :)

...which is actually a bug as well: We are not terminating the script
inside the process_size function when calling "exit" there. Deviates
from the behavior under Linux. Sigh.

Jan

> 
> We'll fix on top.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +
>> +if [ "$usersz" -lt 1024 ]; then
>> +    echo "  User data:                $usersz bytes"
>> +elif [ "$usersz" -lt $((1024 * 1024)) ]; then
>> +    echo "  User data:                $(( (usersz + 1023) / 1024 ))K
>> ($usersz)"
>> +elif [ "$usersz" -lt $((1024 * 1024 * 1024)) ]; then
>> +    echo "  User data:                $(( (usersz + 1048575) /
>> 1048576))M ($usersz)"
>> +else
>> +    echo "  User data:                $(( (usersz + 1073741823) /
>> 1073741824))G ($usersz)"
>> +fi
>> +check_truncation "$userimg" "$usersz"
>> +dd if="$userimg" of="$outimg" conv=sparse bs=128K seek=$(( pos / (128
>> * 1024) )) \
>> +    count=$(( (usersz + 128 * 1024 - 1) / (128 * 1024) )) status=none
>> +pos=$((pos + usersz))
>> +truncate -s $pos "$outimg"
>> +
>> +echo ""
>> +echo "Instantiate by appending to the qemu command line:"
>> +echo "  -drive file=$outimg,if=none,format=raw,id=emmc-img"
>> +echo "  -device emmc,boot-partition-size=$bootsz,rpmb-partition-
>> size=$rpmbsz,drive=emmc-img"
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

