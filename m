Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C2FE8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIGT-0002AN-OP; Tue, 03 Feb 2026 10:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIGS-00028J-L1
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:24:28 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIGQ-0003B0-3a
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:24:27 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6137ihZI940566; Tue, 3 Feb 2026 07:24:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QxYqMFe+kicc9VeiHw+4luGZ+p6UxSTMFrC+1f9W6
 Ik=; b=TE+19uru3hchyxrvl8dhaVZg+gOuJjci+MSh8sxwcWNmLWZOr7ru06TSl
 1ImeGZCwOhGnitMjOoXT/RpcEcma+Rg+v28YAlRuD0VgIoTxl5uwRxJiLiB+2rp4
 8jTj1lQxTGHy3mwFxFqg1GI/gnRjIKc7Lpq16/hcI99nGcExo8k/gWX3inoAL8xy
 lMXGoZWpThilk4NVcShRPAyFLVbKBDC9MzBBMtqTacZs/isi+k8VZSYgISbhUAuR
 0LZLxUM6rDiOaS9+RjnFCMvsOaQIXdQzw7VnStx4civqZ9LlxTVsxPd0H85lEKjM
 v2PKp7IhzKuTonOwzv1TcnZ6h/euw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020072.outbound.protection.outlook.com [52.101.85.72])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c1hxdf08c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 07:24:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDpyJkVsXQtpj/RF6smD6rFjlkKOMrsCSUe6uEB4O5wh6jAv+l+Nc3f0G/+K5WSx6UWoMdUz8rLk9wgUwNvSWfA6m9yGnp+BvNMbMPsj4qYQJxkbi2Gq0sfeq8Z18YCktHSUnfcEWPaLqL0uuxFLU/HtArKBrPTyUcLzguRZjptSnrEdaP1fnFYKO+U2im9wQgDqXHRKpqTiZ4VJAVRXAbKUxf0HMmLI8Z+1esBANQ5km9CMreNjancHN1nDAMJkqK9sXHt88Nuc68KoPX5XIXplyCAQR85kPBYqKBWg1JbGAVvySlZCMIH2IQEFlEo3Kzt54f8mrhPgszjnUKfqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxYqMFe+kicc9VeiHw+4luGZ+p6UxSTMFrC+1f9W6Ik=;
 b=w+YJh62DjhSXxlXhtIBxyT+AhxwdFrT3n50+ziouSFBPiytHxD6nj+aqf+QLu9Ah0z3AfWic+6n+h27WDenQFKmhrLHyfRW+W88BBc9X2njI9O0eCiFF70m0MCGcDO79vKQafP8FtEGHTYJdJyyQcXTgzx1gohd0aBoZauUIu7dNpIS2omGe9CFnya4lHbtxjCa1b1BwgQZA4sFxNImlru1kHWeZDx534IGg5GKW2kXt03+tTCvX2YcF55Ah7oucFgMRAFmqT0vMUPORSh+AzLogf1shTQKJO+bbIrENpsJKvD2BpkKbLqYz61xTmbl1T2TLXNqhOp5G5gQlYURbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxYqMFe+kicc9VeiHw+4luGZ+p6UxSTMFrC+1f9W6Ik=;
 b=p3ng1J3vra0BzxehlxAQeBSUBnfDAMAzdWvs3TT2OeEhjb2Cu8shZEE+ycOAVMtFp4RZrfsn+zbWsC6RFLcRq/H49XnBwNhnh6yEA0Lo02l+z//c4VuTaX2iUEaL9D4XAQPuFZxUr9fGACaCwvVIDnA88HZGTm7Vb+AdYyHujLUncoMXit18E4iDI7Vpfen9FaOEMllJXZeJIL0leuTZLOmvsVo+aEVyIjz9Ud44xrG7tHmBmDyCGGdp7jPH+Z9w0dTpRjjVZJaTaWhiZbZ0+QNhIOnXa0FNR0uyO/xYqyt3mDebpt3zhCvn3AGGoZMnha6OAKQwuNBLr+zblN3PIw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA6PR02MB10741.namprd02.prod.outlook.com (2603:10b6:806:43b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:24:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:24:20 +0000
Message-ID: <f112c0d6-3b70-43ee-ad96-cc220f49afd0@nutanix.com>
Date: Tue, 3 Feb 2026 15:24:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/37] adlib: remove dead code
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-3-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0176.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA6PR02MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b990c5c-9c93-4c14-400a-08de63384d6c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0M4S0JRTVFqWVpyTW1lUHo0NE0rSlZ0MTJ2Y2dUY0xySDFvWForYWsyQk5N?=
 =?utf-8?B?aGJVRit1cGh0RWhrNVlhcUQzNW8za1U4cTlBNGJXQkpmdVBGUkdhb05EeEtB?=
 =?utf-8?B?RW1kK1YyUCtUR2ZXNHM1UUdFaDJvYjk4MlFGWU1tZjk0SEpiaUlHbGt0a2dU?=
 =?utf-8?B?YmYzcGxRVjJNTzYwYlBiaW96S0F5c2NHQ0R6bEZ4WHFEeVJuZmR3c1RBcGk0?=
 =?utf-8?B?czVVUHJoLzE0R0tsaFNoelhvbzBWa0FYbmZMRXQ1OGlTdzBDVE10UCtRK0RX?=
 =?utf-8?B?QVdka3ZUb0lxMlM0M1JYcEd6RDd6a2lrdTIxdmNWdDJSako5b25Ra2pJZVJM?=
 =?utf-8?B?a0t2cU9XK2FzT292SE9DRjlLelFnb2tRbTU1ZFdBTEpjUW9tM0MyaWFHMXZu?=
 =?utf-8?B?NGNJRlVIUUtpNzhJUWo4SXR4dzhOOENsR2k2T3BPcS9qVldYeTVmbGd1aXVn?=
 =?utf-8?B?amt4eDhUZ3BPYlRHbUxIbWowelhmRk1wY3hUZVFCdXJWNHFVM1NkYUVlYm1W?=
 =?utf-8?B?cVZnMkF4ZkRQbWFTQUsrYTBQbXNhUlk0RkUzODNVbVF5RVUzbU4yUGpYTkJw?=
 =?utf-8?B?a1RkblJnQWVQeHVOZGF2QW9EU3RzNllLZTlPdDFWd1pNS2FBOEJyTC81NDZT?=
 =?utf-8?B?dlRwbXcvZUJWQjZTRWVoRkg2bXV4Q0QwaGdnVkFHQmx0YzVsVmpEV3dBZXRk?=
 =?utf-8?B?SmFHYmdVWnBQSGNhN3VHandiaVV6SWJVanRLR1FTeTFxUHRucitudFR6MCtl?=
 =?utf-8?B?Z01nRUIvVHFEamo2R1pXQi9Ma1pYeFZ5eTFRNUYwTE5YTVBhTENyaWtLdHoy?=
 =?utf-8?B?T2t5SmxBN1pyTjdleHN0ZFlxSTd0YjBwcit3cHVEWis4RWtGeTZHeXg2K3RS?=
 =?utf-8?B?U1l5S1RIWmJKYUJzT2ZOL2puZy8xaHhBZEhjdnYrSk5kK3o1OWNYcEFMRUM2?=
 =?utf-8?B?RkRsejRUZmhDd0tvcHhnbTNNR0R6dVRaZVBPeHRXeVRacDlMQVBweGgxdGhx?=
 =?utf-8?B?ZG00Vlh5NUdYTTZxTXI2bUl3eXh2TTd3bXMzVHdaQlppbVNRNVhsQS9qRUFa?=
 =?utf-8?B?OVNJcFBIOUNvRVNicC9ZbjVBa3NqRmFUS2NEa3VuUnFvU2JUWVhjcnRGUlBz?=
 =?utf-8?B?UncvMzFzUkdxM2J0dlFLbW5sRnQ3WmZDeVRaZHk1bzEyZmllN3ZhQnBEK1Za?=
 =?utf-8?B?TEF5YjA5cGhwUzlFZFM4R0w0eS9EZHFRejdaTGYzZTVrVzdSTVIzMjRWN2RP?=
 =?utf-8?B?Sjl6aVJWUmp6MUx0QnR5eTVnWHIyZ2pkckJGNjUxUDdyTWc0NkFxMk9tdHFu?=
 =?utf-8?B?KzMzaVBlNzQreGhVek1FNlNrNFJsWHNNcElwc2hzOC8zVUg5bDgzNXhHdE9Y?=
 =?utf-8?B?dFpOU3pzTG1JblIxQUhVWjhiRUQwWEtXeHd4a0Ewbms0SnR3dEFaVXdqcUN5?=
 =?utf-8?B?eTRYRkY1dG9MdExkc3JJUnp5TkhsenBzbDA2TGd5N2R5SVBRdWxqSU10NU1X?=
 =?utf-8?B?WHhmUzdRQnJDaXAyR2lJdVlwUjllOEE2OGUrMDhmRzYya1ZXTVJBODQ0ZjRO?=
 =?utf-8?B?djIvZk1LS0I0WFNKTjNyc0V1ZkNUSVpxUkpSUG93L2szWi80by9QclpTeEwv?=
 =?utf-8?B?K1ZTMnorSnFLVzRONFFlTm15MTBKL24zSTFmSUhPdU5GWWx0c0RFZ2ZEb1Uy?=
 =?utf-8?B?bEd5cFp3Y2lHMUdsSm52NFdpYSt4ZHZFcXc1T2RBUmJJSDNsdng5MEN4Tk1F?=
 =?utf-8?B?T0h1Z3p6RGFuZElSbk5tOXFtTlJ0Q2hnZHlXVkdaWG9BVGhTbkpkUFNaZVpv?=
 =?utf-8?B?VTFIS1A0UzI1anFvVlRLejhvSzZSWHFQNURIT0wvT0ZQNEJpVTZoTTA3Ymsr?=
 =?utf-8?B?dWdkSUpWQkdvTnkyTitNOWN4c2JOQm9pa1pYR3BPRE45QnVoM1YxUUE0S1I3?=
 =?utf-8?B?M0xNK3RrUHR5MlBQZzFZUWtPbmYybFh4ckNRWVpjek1xM05ONDdMVHpBdkwr?=
 =?utf-8?B?WFJIR1RwSUR6c1VCTWxHdHVyNzF6dC9zSkFzalZrWlRLRzJWekhRV2VDWk1l?=
 =?utf-8?B?cy82dG1DMUFuOG5qYXJkYmYyRnd2b2lEY1EwUklEbkZwVjZMTmRKY1dtak5m?=
 =?utf-8?Q?LoRQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wi9ONDkwMkh2Q0UwbDUzdzV2bFgwSGllcXBXSk5vYTRZSU5pR0FlK2tJQklt?=
 =?utf-8?B?MDFKMkZYU3VyZ3NXakx5cVUzOUtIdXhXdHpOSjFwb1lFaEgxQUJTSEh4UE9a?=
 =?utf-8?B?TGdMVXZnVFZpSGJUTmN0KzJRdzdMaS9XR3RYekY1d3JQdWJCTHVjcVFmRkRJ?=
 =?utf-8?B?MDJZMEt2S0x3TFVMWHhvVnBteHRUUWMwZ01CUzc0WGlMYVllM0R5d1pjNG51?=
 =?utf-8?B?YXM4SVYvQ0FyeXBCZ0NjYzBVY0hncG82SkI3c2lubURJT3RrSW5LRWk3cVQz?=
 =?utf-8?B?bi93YVo3K1NzQUdIQWpHeXE0UlFoTkNvWU91VklHeGZXRmV6YmthTVN3c25I?=
 =?utf-8?B?VVF2eHluQWFQVDNibmt2YUVXOWpJRnZMckdDZ1h6MGwrWWs2anFSNEhhb2xS?=
 =?utf-8?B?OUVoRFNLWURrQ1d1b2pWZ0ZEQ0hXcmFxNEJSajM4Uy80TGpyS0Q4UGdyNDJZ?=
 =?utf-8?B?a1lzZ1FZdFdlVGplUmpGa2N2VENZTEtGckFSTXpvS1p3LzJwVlRsTHg3TFNP?=
 =?utf-8?B?WEk4bGs2c0Z5Yng3Y0paTHZDN1R6L1NBSVowWDZjdDQ4SWxtSUwxUEk2dzZK?=
 =?utf-8?B?SzY5K1ZtZkxqRHNXbXArSU8ra25LeklnNVJjcVBXR3lhMUVhV0J1MVJaMUty?=
 =?utf-8?B?OE5uV05xUW1RT2F2ZzZmSzJ0TFBlUDVjaERSZ040Z0w3djh6VUwzQWJjcnRH?=
 =?utf-8?B?bGtDd24welBPWEVqZUhhTnlIWG1RR0RLajVDRGFzeFhmdW5tSnd3K0FuQUhC?=
 =?utf-8?B?akcxZ2NnbDVuYWdab3BFRmFsc1NLeFhCRXpicUkyR2oyN0lmeE1nbHd5TUJK?=
 =?utf-8?B?ZnJubllJNjJjU1VGVWc4ZUtzUURoWUdRQzhsUi9UbGJ5cmJoaGZ5b0V3SFk4?=
 =?utf-8?B?MXRNWDF5bU5aU3VBcE5nekZrL2l3Wjl6bXBxU3dRVWNIbWZVMHlnREZDdjhW?=
 =?utf-8?B?Tk1BdUtEcGhxd0JMYlorTlplNkJiSTZwUzhieHJacjYwaWFrQmhQNWpEdkFq?=
 =?utf-8?B?eFR0dyt4dmF1SzVxdnRQek4yd3BpMlRPZkUwajZLbS9mUUlvRDhwM3Zmc1hO?=
 =?utf-8?B?Z012em5SSDd5U2hGWWcrL3NaTzFReXZ1N2JoWWF0WXVqbys0VTcyZE9UVkhO?=
 =?utf-8?B?ZURMcFNjcnpjeUd3cmh0SmlsVnpUWVpxZDIzaGNJUXJxUEprdHB6T3E2RXZj?=
 =?utf-8?B?ZWlQeXlNTmVFdENLTmQ4U2s5RlVMTlplMHdwdGVzaytlTVROMmRickpJbGFX?=
 =?utf-8?B?TnhVcHMzUzlFVnIvYjFyNVZqSU5aMit0ZzRSK1kxUWgxTGJzdXlUaW8yT0Va?=
 =?utf-8?B?SjlJV2l2Rnk2R2F2dGhLSk9QMnl4LzJNMGhtMkRubnFxUWlMaTA3ME1EbHNQ?=
 =?utf-8?B?TWdxM0R5UG5lYytxRlpSWGh2R2hDNHUwbGFBdjZLZnZVR085VWdrMjYrMytP?=
 =?utf-8?B?Yk8vbE5ZSkJyK0lRcFIyblNFaWZDaVkxOWtCQzF4RFBnTkZtdkdUY0NWSFBl?=
 =?utf-8?B?UncvcmhUUVVHdVIwSTY0U010OHpOUDBYREhQVzZ3TTNUWWJqcS83OVBBb01E?=
 =?utf-8?B?d01seXVGZVJvZ1NwR0p2eHQ5TGkyZ3A1VkNnZDVlS1BwcjVzL3ZYYzRpQkkz?=
 =?utf-8?B?bkt4Qi9xdnpCQTlLRXAxSmt1bzRoN2YzSEVUemMxeWZBN0FOSTkxUWhtQjRK?=
 =?utf-8?B?UVFVUUZxVVhzUWEvTXdJYTcrOHpWaEhOVmszY0xINjVWYU16MTV5YmVDSXB1?=
 =?utf-8?B?djNTTllRRW9aMUwxVkhrY0NzdUVvODZnVmNqTDlZK3Juc2tvZnlmYUlXMStv?=
 =?utf-8?B?RkJmUkNpU3RkQXdlbDR5OWlCSVE3emVadUY0a2Q0RmJRamdkeFF5Q1EwYzdx?=
 =?utf-8?B?cTN4VWMxVXhyQS9lRHdlcGUwc1NLckVJM1B2OTVVc0dCQVQ0a3EzZTJVL3hN?=
 =?utf-8?B?Y2VCWXJhQkxmaGZnZDRiK3QzQ25qTDBsWmtBb25TaGlCazVvWHlzYStZZ0JV?=
 =?utf-8?B?S1Q2S1pObWNSTDVRSUdVamVFRGJ4bUNtblJVQ0FoVGtGbGw1V1ZqN2o2SVkx?=
 =?utf-8?B?Nk9QQTNaMVBQbFJvTUR1WWllSFpRcHEyZTdCdzJUOStYRGkyR2hDcEI0N3JG?=
 =?utf-8?B?OTR0TG8xQmJUeVIzTkVBaVJWZ3dEV0ErNlh0UVdmY21jMUV3eEordm9PV0Fx?=
 =?utf-8?B?aDI5SFVpWElpOExtek5wcmdWMXo2YXFFeE4wY0NNVEY4VTl6UnA1ZEZHbkx3?=
 =?utf-8?B?QkEzZTV1SVRmWVNNbmM4akpSREhHWUFSOXA1VktKTHRBaW41M291N2xqdDJ2?=
 =?utf-8?B?NjdHbFc3OE1DQTdkNFI5ZHNJMVdYKzdKMkh1U3p1MEx6ZU9DT1c0U25NcTUr?=
 =?utf-8?Q?UG9440CzHDCWXSUk=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b990c5c-9c93-4c14-400a-08de63384d6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:24:20.2920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tJZ1Re8uCSNDw7suJPoYCZI5LxVuOtzUMiF+fF4H7rMSXJ8115yE8I8V0af4tcLaO2YUZfI/ACwnXizwYSeUfMXwUuO6d2ff8wgkV9SfLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10741
X-Authority-Analysis: v=2.4 cv=J4inLQnS c=1 sm=1 tr=0 ts=69821328 cx=c_pps
 a=mDKNUizQ5y4JSpmwThTN4w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=jqBOaJPrDsu9gHqj3qQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: R2aqYrkf9IgZdfA24sZ4dqDdaTdEgiFI
X-Proofpoint-GUID: R2aqYrkf9IgZdfA24sZ4dqDdaTdEgiFI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyMyBTYWx0ZWRfX37ake8aapqHi
 j2xxTC63N8FFhCWVgHp+qK1sWSmBxh7odNLlvSDR9JPuOqVG4EI0Flcr8BFJTIeiYYbXAur2nSY
 PpiHXJYGHe4a2DLgBQwdGcPuFgc6Ot3gnX3PUhLYmoVjf6e4a5Dhlm+Fdm9iF/7iYfE8U4F1wn3
 KRBxKzI0Rhue4SeagPcNIcUlGg0BcYMIfxR5zRwgS9yLq0CLjI44mS1xgtMbR72oKggPirqaPGH
 XBwphe+r1/eSA+aFjiKg/ISonPmiYMNtxMjEykke8hzxZxncaUKtBV63SPELp+YT9jUjS9vPt4t
 9PiF5vdTy0LvULt1JsMMzGzaLRKLYe1r58b+Gs86Eawv8qLgrapyrsl+XBoWc8BEPuE0k70S2kA
 Qg89x1CY8x+ppGZu+Z2Igh8SjqpaCcXjZ8nJF2GnCxBGU/e6izZRi26IWdVCzr3Gewt86XnTZD4
 GhDnkdAqWa1A5kQ1A0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Previous commit drop the need for this field.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/audio/adlib.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index efab5107a4c..f79654627f5 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -66,7 +66,6 @@ struct AdlibState {
>       int64_t exp[2];
>   #endif
>       int16_t *mixbuf;
> -    uint64_t dexp[2];
>       SWVoiceOut *voice;
>       int left, pos, samples;
>       FM_OPL *opl;
> @@ -133,7 +132,6 @@ static void timer_handler (void *opaque, int c, double interval_Sec)
>       s->exp[n] = exp;
>   #endif
>   
> -    s->dexp[n] = interval_Sec * 1000000.0;
>   }
>   
>   static int write_audio (AdlibState *s, int samples)

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


