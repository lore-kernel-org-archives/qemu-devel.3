Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDFACAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 06:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyOmS-0005R4-1F; Tue, 16 Sep 2025 02:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uyOmO-0005Qg-AR; Tue, 16 Sep 2025 02:03:04 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uyOmL-0005C2-Pf; Tue, 16 Sep 2025 02:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxlfvNA7KhoIiLOJmmwacrPf98mMzI+iiyR4y3UL7GeJ3CrENhwKfl4UAZHBso9wXr1v1U5O1q+zylKGfU/aSuw+AMD+OIs9OlYiCYqzAhjGS+uNH65SYMSpQhrIqWDSYeCGzblnDXQVxhdH3BMts8MLunjqoPrZw46naonp4v3pH4qE7aHysWYJIqBPZ/MdHbB4KcUjWUg3PidRtt8zoQy00M23GimobHiXhSXIy/t8Vbt6SGPT46KdbYgez8HD43ADH0pCb9JHF7sD4rAQaKGASSHXmZV7YhOJvEFPs7CDkFbx4M+y1sUWQctJBeCAb4bOTuGN4tUlYms2JGfOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ytJ3hIJ1BTjYa3bWFRZy13QWEWLiCEuFI+By4rSqYE=;
 b=tbB6RN0A/XRnHt7Wz+jwF/PVglpiegVywJ1BqWEc8mC4sjVYyzpcPIs9oF2RBa+o82EPBVB5Fl4r9LgmHWzKSYHmWN3IAEfZiPgocPdZ25qDLzwlnH6/LzRH9nJVGdNU/MWdwXXDBNtu5HPQlWnOvIc+A/EQ5Ra4pAlJwzWnmKOkvhfeGWbQ9PBfZXZUTjbPrQllRsfiSxfjl0vXCrmks4DKXJEk9rsYeuWlTvg6l8GUbYP4ETggg6mFoGSm5Go3R1zMLlS7NgMkecvAu3oNQXrn49PxLRZ3to76rbWQsabiq5JK5TSr+5mtxQYb4kS7xXepErC0ajVyWA817Dx/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ytJ3hIJ1BTjYa3bWFRZy13QWEWLiCEuFI+By4rSqYE=;
 b=Ve/aYJdn6wx/zPTbMIx17i3RTSAZe0HRErutv8e51ojH7phGIrJPLwiKULnFRG+oVHWldUrmrxjuzQRenElgSK2UIrTa7af5q0iO9mpnjNiAsX8l6yLzL1NiZZDSEvgBbAAV360baKPHy3NssEm1wP67r0bjPbFt25Njohwhiq8b1XNSNNi53lfcxFQRxgJn6Hbof9gzc3Eqb0bngAhKSCrAZ5IIpryatz0wXQ6g6A39rxG9BdU45zSwzTlO8sc9YY4C+rjLh+0rXHXB5hdSaVImoXQfvyMtoiItMLEIlaYbJu3NLYTnbnnNmGSLwyiHayy+tjZrTLIXWn/kurzVZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB5805.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:50b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 06:02:54 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 06:02:54 +0000
Message-ID: <ee929dcc-f83c-489f-8a1c-f74398cbaa57@siemens.com>
Date: Tue, 16 Sep 2025 08:02:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] docs: Add eMMC device model description
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
 <bf2b2d675264fd41fbe55ad3fb2e528e6d72ad97.1757854006.git.jan.kiszka@siemens.com>
 <e718145e-f39b-4af8-997a-cc4c8972049a@kaod.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e718145e-f39b-4af8-997a-cc4c8972049a@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c760cc4-cc42-4cb7-cb09-08ddf4e6ad28
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1A1dURmbTJqQzVHMVIyYTlRajQra1FuOFl5MC9ZY0V5SHF1V2p3Um0ySGxD?=
 =?utf-8?B?SmJZZG1pK3Y0NUhreE9LK3FmVUtJTXlDVUdGbHlKdWNNd3FQbllic0Q5TjZN?=
 =?utf-8?B?c2R3NUU1MVYzU0hrejlPQWhuRVhyUHpIV1lwbitPL0V3NEFrckEwS1FIaENU?=
 =?utf-8?B?ZS9ubS93RzlsSmVFRDloZlVwc0VEeEZrbXczdWxxcDBNT0xIaEQxVHU4clcw?=
 =?utf-8?B?ZXZrTmtmTFcwZ1lxUVZuUTVaK3h0aGtLWG1Sa1NmOGY5a1JvT3l5SndyUUN6?=
 =?utf-8?B?SEkvMnFBY0YrMElmbmxBaHlTMjNVOTFxQ09JU2h1a0NVY1dWbG8vVGd5ZjRM?=
 =?utf-8?B?Z0VJM2VZWC9kV2gwZ2ZxTERWa3VIUVlFei9Gcmg4ek1TcllzT2Jjc0dnVSty?=
 =?utf-8?B?ZmRMVXFFZ2FYdTJnbWE4WDVudVdiSG1TRm55MHVPZllETEExTkN0cDNNODlS?=
 =?utf-8?B?YXV3VVd6NVJPSVRjVG9PdGtIajNzQkxQWHVpRmhvRGR0dnpSQnFRYU1WTHFo?=
 =?utf-8?B?WkFNWGVXdEl4dFVCUkpxUklMdFhPQUhlWm1RZEEvdktUZ21IbmtqVzdyZER5?=
 =?utf-8?B?Z2hxaW1waFBtYnliUGhiRWtKcjg0ajAxQThnSmQ5SFdVVnozMU40RWMrU3c3?=
 =?utf-8?B?ci94bjdNcG15WGlwVEo3ekZFODJyaVJzS2dYY21DcWRPeFAzVWFoc3NqeWRw?=
 =?utf-8?B?VWgwSkU1RmFJUnpnNmxlaE1sMGdSeXdlRVlYb2Y3OCtENmhrL2xSemJtZ3pV?=
 =?utf-8?B?NC9hNFljajBEY0ptMEpEZFp5M2F2RFBUUFFMd1JqTjhhN1gwRVlSVEtKUVRF?=
 =?utf-8?B?UVBUeXE4RFpoQloxUm9mM0U3N1F2akFkWC9KbkZtVm4vaTZTYUlOVGhNcVlR?=
 =?utf-8?B?MUo1Q2lpYkRKM2pxUWk1cVlmcVBGUFBDeElCZEdoR05iU2UvRUZDbmsxK1pR?=
 =?utf-8?B?eHU3NG1SREpUcnJWaUN0ZGg3UFNDNkpaK2txTHg5ekZwNDVmbFNzcmlBME9r?=
 =?utf-8?B?cUxoS1JyOE9IY0NUQ1VCc2R0bXZObWVING5JV3VSbHVubVM2bmdhSGZ5VnAz?=
 =?utf-8?B?S2p2L1ZKNTUwaEp2MzBnZDhQa21FaEEzbzJwcExIRnlBZHc4akYrSmFGZ2xI?=
 =?utf-8?B?aGJwNkNSYWZ0RGVnVkpkRmx3dmZhT05QNmdmTlM1blUzM0dNZExwZUN4OEFZ?=
 =?utf-8?B?emtJNmN1dmRNVmZQMUQxMjNRK25YeU9JUVZZMFdkVW94MGJxSXNYRFZZaFJW?=
 =?utf-8?B?dnpmY3M3dHZqZUtJZEZUVFRieVdjaDBCZEZtRDZhWDBUaHY1QzNBMEVXcERv?=
 =?utf-8?B?ZkdqRHdqZ1BVN2I1ay9hbmo4eVV3SDc5SjljWDRmM2NlSzdKcUJYdGVMNGFp?=
 =?utf-8?B?NVR0K2NTVXFXUitlOVM3THNlcUtsMEhIeDlTYlpuVlplcVFycThpWG4vTVg5?=
 =?utf-8?B?a0Zmb2U0R2UzWFozYWRjWlN5cWk0UTVrNVhZNVZRVUNiVHdDS2E3R2p4MFJp?=
 =?utf-8?B?b0w0SGlzUEl1VWYycXdiUkQ0UThZQjYzSkU1MC90ZXpXNWwwQjdtWnFsOVpT?=
 =?utf-8?B?MWhuWU8wemc5cWZ1a1A3RWtUQWxNSjNWZUkvY3NyNUJFMnl3QS9HTEdVcTNZ?=
 =?utf-8?B?c1ErNWt6UVlaZkxOVWNLdkVwMExWSnF5UHJCQmNCanNKUzc3RkxMNExCVVpz?=
 =?utf-8?B?OStHc1JiaUFTdzZoc1ZyNytCc2tsQlRlVnBxL1pUSWQyeGo0YmNlckl0SDFS?=
 =?utf-8?B?Z0ZnTUVJKzhka2lNaTlib0d1K3U3cGY4RHNOZlZDYzVjVnNveXBpYzdYdTNY?=
 =?utf-8?B?c1E2djdta3lmdk1lSEdVSXozZVVxdEJhTzdiSjVZZ1ZHdDB3RHhFMk1iTy9H?=
 =?utf-8?B?YVJwTlBXWmhaM0s3NVlGaS93azdQWERyZkFzMndnSFFFdnB5cWd3Q1c1SThU?=
 =?utf-8?Q?TVIkDY/yc2k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCt3Wkl0VGR5RTdJdU1CRjROdUFPdWxDRnQ4YkswTjg4RFBRZGVienFHSTBn?=
 =?utf-8?B?dGZjcDF5Tks1UHpmSkl2VlNxTEhiVUVaaDVoUmovTEljYW44aktFQ2ZHVkJY?=
 =?utf-8?B?THZyejlCM0xEM0cvdzNNVCthZmduTko3eE15TGM3L3dzQUxmK3p1TVFWcXM2?=
 =?utf-8?B?bnBrY2tqMUxpRmRETUJYSkw1Zjk0bkJGSXZnbXM2b1pkWjNDZmEwL1kzNHhF?=
 =?utf-8?B?MGtBQVp3ZXZHTTNsL0pDcy84Y1VCaFlKUDZJRHJ3TmJLVE1JWkxkVTd5UTho?=
 =?utf-8?B?bldMVEcvaUZtYk9TVE9FaFFkUTNnVUxoR0h5MUFVaHIySHl5bzQrVnAycWdQ?=
 =?utf-8?B?OHBHcG5iSFhjdTY2ajdlQ2xjLzcxek5QdVAzUUtvcVp2aGxLbVJHMGZ3ZFdl?=
 =?utf-8?B?Q1RFeEJmQnBkcHhSMVRuUE5WNzBCUkhDY0EzNUxiNHhWS1hzZ3NBTnF0NU9N?=
 =?utf-8?B?N0Q2Q2Y3OEFnN1lmWWZyQ0Y0UWtWMklJcURnRTNPb294UjFtVHJ0elFhVzBp?=
 =?utf-8?B?VTN2cEZpcDJTdVEvaVliNFc0SXY2TmlVS0tzRFluODdVcktzYVZnM3ZtcU5R?=
 =?utf-8?B?MzQ3NEI5V0JOdEpuRHphMzcrWkkyMkZWdzh6Q2d1RjZaa05LSmhWVGY0Z1l2?=
 =?utf-8?B?RE43anVFUU4rV21zNEpsQUM5MnZUdzFjNldFa2N6Wk1FZzkwdXJxanFFNlQ0?=
 =?utf-8?B?dGpIMnhYSjJaSzUzK3V6cUU4cXdJSzJZN29xUDMxSmVmZ015cGJzUzZuVXl6?=
 =?utf-8?B?NzNCS3VCc0J4eUQvc1hhaWt1TGZxUTRWUDdRRGVVbWIrZ3ZPL2hCTVZkMXFm?=
 =?utf-8?B?OGhkRDNHeTVSaHNRR3Vsd1czNUlCbFRhaDBKS2VYc0JvZGo1aGtUN1M3YjFx?=
 =?utf-8?B?cGd2bVJBRDVGV3h3RHBkeVVEVVJGdjU1d0tVRnZCS1FLZ2J1T01nWHA5bDFv?=
 =?utf-8?B?Zy9UbTAwTjlKY1hhcFhEL3o5aDY2NTdZOXM3QlBidFlBOVp0WkRBd0d1RWQx?=
 =?utf-8?B?bklidndFSGU0b29nWTFFeHVCcDA3TS9mNUZrOHZaWmlMV2VYcXB5VHpUTHJo?=
 =?utf-8?B?SU5JWHBuUFRQVWF6WENUUVhQRUMzejV4UWlzVHFuRkZ4dmduWGVIR21tK0th?=
 =?utf-8?B?ZDhPMnJENmJUY0xpcVpxcVB2Y081UWxZQWFKQ0dpMytOU2lxQ3Nxc0xzTkRj?=
 =?utf-8?B?dXBNZXl2UVNSOVJMZ1IvaHV0QkU4YTArejVoSlpja3M4THFMajhURzlaZkhP?=
 =?utf-8?B?enhWRjk5bUVoU0REaTV4WEVjVnpKRG1SRzRZanRrREwzR3RaK2NzL3N0K29I?=
 =?utf-8?B?a2V3SDJjbWlvS2RJdHhPMXd1RzJPaHVGNXhuUm9INXRoaVh0NXhva2ZsVWND?=
 =?utf-8?B?WUxSZ3V6NlIxWTk0MHhBdG1SdmFxMXp3MVJEN0ZpcTQzMzhnSUF0MlF5ZmN4?=
 =?utf-8?B?TXJWVHBYWEZOKytHWi9adDhzU3hpcnFVSm90R2JIdGNxTHJsRXB2Skx6d3lY?=
 =?utf-8?B?YkFtQVdiS0FaYlh5SGRxK2xHNDB1N0hwRGFMejdiR21PcW5vc25oWXVFOTBy?=
 =?utf-8?B?SVlWUFFlVUdic01JSit1empmTkFDczBURXh6alhqcGs3NUt3K1dGR0pTNTgv?=
 =?utf-8?B?RU5rcFo0QStnV1JWcHpYWDdIOHo5ZEEzbHdseHRwMms1UzV5YzY4dHAwTjFC?=
 =?utf-8?B?S1IwdmxwZ1hWaWtENzdYS0tMcG9meXRacFEvdDNadVc5QkdjYnFMTXEwSHdW?=
 =?utf-8?B?REl1eU9mNW9CcVB3ZWVOWHU4dWFnZVgzWUR0OUVSd1NRVmtqMDVJVElFME1B?=
 =?utf-8?B?MkpHbUwvSzVJMWIwR1U5eTlwMUdUblpMRzdReUVscnJJWmZKdEVybkgwaC9m?=
 =?utf-8?B?ZHBmSlRtL1Zhb3hpdnRVM0phbFFvR1VuenhSNVU2ZEdXS2RFdVQ0cTMrYWxu?=
 =?utf-8?B?elpPN2dsdHdxekJMVHVrVVFOSEZQaVVDc2VtRU5QL1lJaitWTyttNlBWRlBD?=
 =?utf-8?B?NnY1SjR1NGlKdTZ1WDFNa2NOYzg4Q3RHcVY5SU1CS3RLSXBodVJjcm04OWhG?=
 =?utf-8?B?SnRIaTR5YkNjZkVrY2lncW9JVU1tSFA1eHVlbFd1TDBINHBpVVJ3eERqN0xo?=
 =?utf-8?B?YTN6V2NtdHNDNnBnU2pEVE93anBYUjdGaFFQZENZbUpHdDh0UUk2NzBZN1lT?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c760cc4-cc42-4cb7-cb09-08ddf4e6ad28
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 06:02:54.3156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIrHclA0YUKzUR9l6cmDpep99/5XYUoXwqm0iXjE1oizbjgbsP/frAnviorDiDpSxdJpKAGGQySRiMUTX7z9Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5805
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=jan.kiszka@siemens.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

On 15.09.25 19:37, Cédric Le Goater wrote:
> On 9/14/25 14:46, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   docs/system/device-emulation.rst |  1 +
>>   docs/system/devices/emmc.rst     | 52 ++++++++++++++++++++++++++++++++
>>   2 files changed, 53 insertions(+)
>>   create mode 100644 docs/system/devices/emmc.rst
>>
>> diff --git a/docs/system/device-emulation.rst b/docs/system/device-
>> emulation.rst
>> index 911381643f..36429b1d17 100644
>> --- a/docs/system/device-emulation.rst
>> +++ b/docs/system/device-emulation.rst
>> @@ -101,3 +101,4 @@ Emulated Devices
>>      devices/canokey.rst
>>      devices/usb-u2f.rst
>>      devices/igb.rst
>> +   devices/emmc.rst
>> diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
>> new file mode 100644
>> index 0000000000..dbea6d6c7e
>> --- /dev/null
>> +++ b/docs/system/devices/emmc.rst
>> @@ -0,0 +1,52 @@
>> +==============
>> +eMMC Emulation
>> +==============
>> +
>> +Besides SD card emulation, QEMU also offers an eMMC model as found on
>> many
>> +embedded boards. An eMMC, just like an SD card, is connected to the
>> machine
>> +via an SDHCI controller.
>> +
>> +Create eMMC Images
>> +==================
>> +
>> +A recent eMMC consists of 4 partitions: 2 boot partitions, 1 Replay
>> protected
>> +Memory Block (RPMB), and the user data area. QEMU expects backing
>> images for
>> +the eMMC to contain those partitions concatenated in exactly that order.
>> +However, the boot partitions as well as the RPMB might be absent if
>> their sizes
>> +are configured to zero.
>> +
>> +The eMMC specification defines alignment constraints for the
>> partitions. The
>> +two boot partitions must be of the same size. Furthermore, boot and RPMB
>> +partitions must be multiples of 128 KB with a maximum of 32640 KB for
>> each
>> +boot partition and 16384K for the RPMB partition.
>> +
>> +The alignment constrain of the user data area depends on its size. Up
>> to 2
>> +GByte, the size must be a power of 2. From 2 GByte onward, the size
>> has to be
>> +multiples of 512 byte.
>> +
>> +QEMU is enforcing those alignment rules before instantiating the device.
>> +Therefore, the provided image has to strictly follow them as well.
>> The helper
>> +script `scripts/mkemmc.sh` can be used to create compliant images,
>> with or
> 
> the single backquote would interpret scripts/mkemmc.sh as a ref. I think
> you want ``scripts/mkemmc.sh``
> 
>> +without pre-filled partitions. E.g., to create an eMMC image from a
>> firmware
>> +image and an OS image with an empty 2 MByte RPMB, use the following
>> command:
>> +
>> +.. code-block:: console
>> +
>> +    scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
>> +
>> +This will take care of rounding up the partition sizes to the next
>> valid value
>> +and will leave the RPMB and the second boot partition empty (zeroed).
>> +
>> +Adding eMMC Devices
>> +===================
>> +
>> +An eMMC is either automatically created by a machine model (e.g.
>> Aspeed boards)
>> +or can be user-created when using a PCI-attached SDHCI controller. To
>> +instantiate the eMMC image from the example above while assuming that
>> the
>> +firmware needs a boot partitions of 1 MB, use the following options:
>> +
>> +.. code-block:: console
>> +
>> +    -drive file=emmc.img,if=none,format=raw,id=emmc-img
>> +    -device sdhci-pci
>> +    -device emmc,drive=emmc-img,boot-partition-size=1048576,rpmb-
>> partition-size=2097152
> 
> I will see if I can adjust the existing aspeed test with your proposal.
> 

Thanks in advance! Yeah, the existing alignment rules were incorrect
once you turned on boot partitions. So there is unfortunately no way
around fixing images that followed them.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

