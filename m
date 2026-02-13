Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4833CEDF148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqSn-0003N0-57; Fri, 13 Feb 2026 05:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqSl-0003Mi-Hh
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:31:51 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqSj-0000oH-8L
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:31:51 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9tWaH1341893; Fri, 13 Feb 2026 02:31:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Em2/yvyeVP6jgfVEOC/EEvbfOL44DAduoWW79I/2z
 3I=; b=kplLiO42b885ZvC1xANPWeDcG7dWzHt30q/wHlCs2PXhtHX1+sby6oVGX
 APdxuCKW6U06dfdDhM2v30F1cVkXkoNjzkMlTIjafJyfMVo4T/pVnOempahf5fMD
 DHDOXeRyS1pHZipLNsP5FL33ZWZZ7DZ5eI14Vo7sJd0amiRxFJE+RkZwYhkvzGks
 Oer9ZwM5NKKCSWhrd3/ELdNPFkoW8FIuy+lh9BEUO2A2f/1jsZWq19caCHjh9sQU
 AMRLOJCm8Kr6Qkv9FzCDpumtsUPDXehhY3YFDn5uf3XpeEc69U3p37mC+eUUf5Ph
 pvJ5iO62yHISasoAlFCXjCaPWKq3w==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022120.outbound.protection.outlook.com [52.101.43.120])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8k9s7nk7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:31:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1PjtiHA6PHGg1s2zVWrUqdEGaBnEgBEU+L17Tx/dkl2+SDETlGw7cOFI8RRlW9e5ZRi3EQHJ84T1lhThYmh01Q3K6bJOT9UX4sWmxCPpb4JgUulXarRFn/VrXGu5/4v2p5Q5q12/+Cr5C7m+uMEXfbVIX62NgxqCxzjRvQSJ1+Ys3mBKE8L9d8ZUQ6pKScP05/HaQuF9nDlzIBtRcklV54573KoUGUIdUonc9YvzpIgz+m+ahhLgmURLooT3/qC0ZckU6GMPVz7sqx81/JsiBhWK8Cna/epLK52UFKlBtOkDKngCyf0EI+8hu5q2n5/4JRaR+NANpTWd2J7cgsacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em2/yvyeVP6jgfVEOC/EEvbfOL44DAduoWW79I/2z3I=;
 b=jXgZZQfnMerJoSzHkUigpL3uHdswwKJBn9F5ckH/aDUUJWpBBmOQQQHNP3tRFXgzXkAUQc0q8NuNayoBQoPYPWE0Bagv2MT1aSjLz/SxmPL7agDBdr4U9/8d+ywZZGsDmkWuIzs3Nz9pnWS+/W+/C4/yNpbxcm8bZNJ2g1kFQCQGFLP+2yHquLoijpbj6Sdl9Jnj4zjhJ6pGZHqdy/Er0IUBRY/89qp6absaTYJCPSyCaGwThOxJLurNZvx6KtJjtuF24hPseFTWxM78pnCtkGWhSBh5wNJCcFZXgSXs2ln0NArzTPAAJJlhqF3bBMJqe0HWozEtBPoWJ9Se3FDdsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em2/yvyeVP6jgfVEOC/EEvbfOL44DAduoWW79I/2z3I=;
 b=nX80NmWggqpMwvR87Xnw/0wKHTbnnB6G+N66h8kubWUqoeHZ+FVQOlPSZ+7a8TKFH1y21qNqzP4r6JS/o9ClWxvgkNwLm3f0/jjWwsuVUgZP/kHYQUPftEutHcYnveW/UljAW27IRSY6I6ZD2qtT08EtupSijJgm3RmPhzSQpqE6G4zB9usELnBbAuixL5tD2Kg0k8/v/0j2YJIbUuOWxwTAv2L3nLthK/pjiF7z1NhuJSFShAt8DOtTyxrKHsaqn8Y1B704hpXNCKtYayuV67Hf6T+ig8zaGQ3XSC4U9ZqaKugT6RghXKfkMkBpXLy57KlL/ziRiNeyZNa5byCjDA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8416.namprd02.prod.outlook.com (2603:10b6:806:1f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 10:31:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:31:44 +0000
Message-ID: <bf46463b-cc36-412e-b3a1-3418c5c43817@nutanix.com>
Date: Fri, 13 Feb 2026 10:31:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/43] audio/dsound: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-14-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-14-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0592.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfdc629-a8b1-4a3c-5c48-08de6aeb15ab
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T21ZZ2QrR3c2dWJKUjRLS21DcmlxVEhYTmwrbFpRYkVQeTV1Z2RaK1JnMENl?=
 =?utf-8?B?R21OVEFkYmRQVWttUStDc2h3aHJ2SDdDQXFkVjZVVk04akRwL0I4c0ErRjNl?=
 =?utf-8?B?L3Y4b2JRUEtjZExldjBTWnVTR0wydmtLM09LdEZLcm5HM0hxVjcrSWR2UHM4?=
 =?utf-8?B?SlF3ODhnd3JrWUpoSnh6YVRHZ3BpRlJRYjNnTGlJT3hmTmFPRkpCWnJ1dDF3?=
 =?utf-8?B?Smh6UWgrSXdvTlRYUDlEZUNxQmYybU82a0xNMW5qMmIveU1EdEczTng3SDBI?=
 =?utf-8?B?M3huaXdlclJ0d2k2cXo0Zlp1UE5wQitpQ3lyWVRXeW1GQ1NDWHJIaFlkZlpY?=
 =?utf-8?B?RFVSQnpGWU9maFZWWUErdENjMk5sTWNIaGsxZ0FZOTdYY1loN053RVZublVz?=
 =?utf-8?B?azBrMkRDNWlGRi9kUWdMV0dFU2psVTMvQkNYVG43c0ZYR29oc2ZxUkxTNFVN?=
 =?utf-8?B?anladlI4VlY2USttTHduZ3RPYmFkMVJ1N0xTN1ZDU0FSMWNENzBEbU1Kd0hq?=
 =?utf-8?B?Y2hybS9nU2tlNFZ4QlR3RkZHUlpuZFpsV3lrKzhQMkVDcllNU1BIbHdSUlB1?=
 =?utf-8?B?ZWViTTBFa2ZOdktUaTlOWGIzRjVWd0ZyZGE3TjloN05HQm5EMzhYUkZzZ2Fs?=
 =?utf-8?B?UmtrL3hSL0JoYXBialh2Z1RKc2dDcFFiejBZbHVicXF4eVpZdmV6TEpDSjYy?=
 =?utf-8?B?UXpZUi9wOEcreitPdkNrTzZRckMzMmFwNk5EUzZCS3hSRmtqU0N3VXZuZ3F4?=
 =?utf-8?B?MG1Seng2VlFtcHRxUERFdGtXVm5PMnRPQWhQcVVlYVRNNVBpMXFqWGo3eHM5?=
 =?utf-8?B?aVhtU1gvbUFqYkx6Z0VwMm5oMXNqT2lnOEs0RzRHdm1DL2YwU0tNUmxJOTZI?=
 =?utf-8?B?M0lkYVpxWmlQeTFWQkFCMTVmb0VPbnltOXZuOXN5a2oweEc5NjlESmhWUE81?=
 =?utf-8?B?eFp2enMvbGVjTGdZYlVFRTNnZjlzc2JqTHFxMnFTTFgxYjE1dGY2eHJ3YVBj?=
 =?utf-8?B?cUdQajB4b3BVYVNGcHBvZFU5SUNmb3AzY3dYaHJ5ODVxSWRqdnlGTXBBNFVD?=
 =?utf-8?B?bk5pZVhwTmVZWVVFdG94dDFsSDVoTnVlOXI1SUVsK2tsWlhIN0RWYk5VN2lW?=
 =?utf-8?B?aWlKcll6dVJQbUlvQm9oZS8vRXk3a1I0SzZTRkgxZGVnS0xoWTlzd3lUa1I2?=
 =?utf-8?B?T1NHY1FGSkM4cUVvSlU2Z0hYeEFqc1RCWk5RUDJ4NW5aQTJyMUpyVXZNRWt6?=
 =?utf-8?B?TTRvNmQrMTVBa1hHZWpLTGNvanRLdjhYMWRjRWdUOWwzUHB2TzNQS3pLR3d2?=
 =?utf-8?B?RkhWQjdnK1RBQWxmZnMvSGppU0cwUDRFNWVnS1pWM0tEeHp2Qm55dmZuaTY1?=
 =?utf-8?B?dkpvcUFocWR2emEwNTA5YWNZajlOOWVvN0hVQmZ6MEZnWnUwWHEvd2N5NjVS?=
 =?utf-8?B?UFFueWU3Z0VKU1o2cUI4QlJiL2RIOFdPbVJFOGttOTgwdG9Vcys1Y1NKOWpa?=
 =?utf-8?B?LzE4Y3R4RU9VOTNxNk16Smk5RzFKc2pFNEhKNXA5THVwWlVobFFUTUs4V3Rs?=
 =?utf-8?B?Nk1ZeUlpbSs1V3BoUlVEaHE1aTdvejBpeVBmQnZ6U0VjM3hEK2o3b1RzRzhY?=
 =?utf-8?B?Nm1LL0xaV3cxN0VCalE5ekM4b2xTZUZFZ3puSGI4RUpKL2t4dWVNSDZhd3RP?=
 =?utf-8?B?WVhZVWNkT2h2d0QxZ0ROM2hJa1BuQUIvLzZHbGovTm5nNXJFaFA0UExNS2ox?=
 =?utf-8?B?S0NBUEUvSjJxc3JTaUdsZkJVZm9iVlpvNU9XblJCc0VMc3g5a1djaWhyVmoy?=
 =?utf-8?B?a21FeGtnS1VubU1Lend1aUNmUVh5a3lKRTRTQVJPZ2dqSTYwVC80UjZGOW9u?=
 =?utf-8?B?U092SmlLVkd4QkJJdjJuN2Jtdk1BK0dZSUF5cjZMQVZSb0ltQmxjSTVIR0xQ?=
 =?utf-8?B?UXdYMUkwa01TQmtQQ1V1RU5oNDVDMTlEVkpVaVpJalFLYUNJRG5OV3I3WGJM?=
 =?utf-8?B?MkthWTh0NDIzTzNNQXdDbjdjZlJkYU51LzB4QjM0akdZek1kZXVreU9aazRy?=
 =?utf-8?B?OGpDaGtHWUZ0WU1GWVZDSFM3eWIyRG9DeFUzYlhENDJ1R2IyUHo5N2pEdWRv?=
 =?utf-8?Q?2CHo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUc3c3U5UTFicnRBMTdqY3pmVEJQN2RHYzJjN1g3TXQ5RTJTWTh4RXZlTDAr?=
 =?utf-8?B?OFlnRWRWYWMvVmlDbTNqSThYMGRhN3g0bEN6REpZdUNabXF0NFJUSjlLZzlF?=
 =?utf-8?B?OCtEa3g2VTEyUWVsRUtyY0RyNUs3eGZYWU8xdXJiWmpTc3pFU0l0djNJZzVa?=
 =?utf-8?B?TFBtYVpJVC81UzFqL0NUdDZ6RlcweEpiSkxKNktjTy9mTjhTeWdmdTNBd3px?=
 =?utf-8?B?c2Zmamk4RkVleDVKTXJiRSt0d1BRR2NEODNvdjNxQkoxb2VpMmNuUlFTQjNm?=
 =?utf-8?B?VFRySlV2SWF4eExxbHJlejZjMllQWFo0SzNpcHlYRm9yM3JWemV2ZFVBSWFM?=
 =?utf-8?B?cURKVXpTZEFReVRmZ1Rqd2hiODdGdDNQV0xHKzI2WXNQYTBXenhlM2Q5RW4y?=
 =?utf-8?B?WkZmZUNDekJPWitvY2VKWTZiYVJpeTZTeW1HeWc4RzFXelU4eDhYcjJtQ3B6?=
 =?utf-8?B?L1YvM25nZXl6VnBVYWUwc2FaQVBONlNHR2h4aE1UTzlYNS9ocGJlVmFCRVVj?=
 =?utf-8?B?ZDRZdk1kd2pVL0JDcEZ4aVB1QlRwaUkvQSt1N0dQeFFlSGkrYXhYbXRvNngx?=
 =?utf-8?B?V096ZXhDNkhYTnJhbTRaQmgzQ0EyU1kzMlh1UWVVZjlXZDBXcHVIWHpra0Ft?=
 =?utf-8?B?L0ZOdERJem43UE5VREVxOWUvK2doZndtTzVBT2x0VXRXYkJTaitXVVBMakxu?=
 =?utf-8?B?WE1YY2Z2UmZpMkR6dU93QjJxSnJvNTZyQjhzOEdwYVlKT3pCL2N5UFUxK3Yr?=
 =?utf-8?B?T2MrRTh1dHRIdVhNVDB0cUlVb3JyUWlLRmVTM2N0em1xL2wwRGtJcVJFZXpq?=
 =?utf-8?B?MUJ2ME1NY0lYeTFBTHZOUGR0WmEvZjhkMHhtYmNJR2ZNMzY1L3dhSnV3WHpt?=
 =?utf-8?B?ZytvV1dBWXJXOUU3QjFjUmxPR2l1TlJZdS80VXpQNVlXMHkvbDlMbGk2dW9v?=
 =?utf-8?B?N1E0Z2x2Qm5COEdJSXRRajU1eGpCNEVoeXduVEZLbmxkbnEzNVFQK1JEZ1dp?=
 =?utf-8?B?YkRTWHlFb3hlT21tcitWVWtya04zZkYyRkI3YitKYlZIeE1aYUJMN3ozUEpW?=
 =?utf-8?B?bjVXSzN6UEFlYU9qZTBIY2RBZ2x0c2RYcWZmN3ZuN1R3RkY1UVR5b0FaNjB2?=
 =?utf-8?B?cENCL1RHRG1ObWdPcnF2OFBDek5KU2xFZDJ6NisxQ3ZJUWFzL0o5UGhNNTR3?=
 =?utf-8?B?YTZ1MFk1ZFYreXRlaCswTW52NHNPUzF4TlgyMUE0dHVmTGt2Y2c1M0V1VFdD?=
 =?utf-8?B?VjA2SjZtNGdpbnFiV3N4NkFnV2x0czU3S1ZnRUlpeXZNU0dRcFBnL0JmZlYy?=
 =?utf-8?B?NTNyKzhWNElQUlpTbXJhR3MyNTZ4Y2hnSzhLUnpDK2hGUE45Yk4wVTNrM2xm?=
 =?utf-8?B?cmYxYVRQaTBPY0gzc2pwcU9TSzF6VUVtblFvWURzMWhRNk9Cc2xabGhDUm9p?=
 =?utf-8?B?UTJKajRxU2FNU2dVaVloclBWZmZubXBtdjVmYzhKbGVZdEJhTjZCRGdvYndL?=
 =?utf-8?B?YzNDeWNpTTA5K3plWWRHYkZXcFVyTHp0VW5RUHl3QWN6dW5vM0hzS3lSelBw?=
 =?utf-8?B?bEYvdXI2MWY3a0ZxU1V2S0Yvd2JvbzhwVk5KamRyaWc5ektQQzljWkk5WG9h?=
 =?utf-8?B?VGxzc3d3VG50TWwzUWdaZkFBU0ZGRTBVVmRxYUY0N1VkZS9pd1lSN3BwWWlv?=
 =?utf-8?B?cG1wQVdBV3Mxd210QjZacElBVDUvWkxjYXBESWJqdE1nZE04dUZ0UVU5R3hT?=
 =?utf-8?B?bXFkR3lNQjRvWlFjUWJ6MVZlVFh6djVTVVE0R3NodXFLTmt1Tk9kczcvc09D?=
 =?utf-8?B?OTBQSkw4bHRvTXdFSWkxK0RYaFgycGxhclJNZ3RiV0RZSytRZVEwaHgyMWpy?=
 =?utf-8?B?RUNsbWhZSWdTTGJTTm52V21jc0pyY3E4cVJrTWRoWGtLNWlIQ21XSGw1QjhB?=
 =?utf-8?B?aXVoeXZTVU1TWTZGTjNDK3NNNmc0elJyd21TTzZmZ3lwNWpBUXp3MEx0U1dZ?=
 =?utf-8?B?c1ZZUkE5dVIwZ2R0di94bGVNRXFoOTd0SktkU1ZQUXVKN1NTVVNNeVdad3lh?=
 =?utf-8?B?R3RWSkpqZ2ZoYXh2bmZrdkhlczVtM0dzazdPMkF5RHVBeWMrTy8vVTdBN1pL?=
 =?utf-8?B?TzV0c0RUZ1FDdFNxL2JHT2Nub0N5Nlp2ZWNkQ0g4S3ZrR0pkTElTYk5pdjNS?=
 =?utf-8?B?T2s2WnNtRFp6SUhqd3dLUStoT000Wms3TUQ3L2x1Y3prdVZ0NnVQNUdyK3RP?=
 =?utf-8?B?MmYxQXhaMzlxT2p4Y3ZCaFJ1akRlcmtFeHV0SzFpblVlWmk4NkFVcSthM2dW?=
 =?utf-8?B?WDRQdjZYaXZqalg2T0xDS1VsS1hDSllKUCs4MGRGeDA5eEZHVGd6YzVnTVhr?=
 =?utf-8?Q?p89NcNL4PRRoDaqo=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfdc629-a8b1-4a3c-5c48-08de6aeb15ab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:31:44.7958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsIzjisaLkOyd4zdVHvGTcBLED/7rCXnZJfeVf5D537Tlun/9ZalL6071MY8zqQs+NO8v/NGws5h4/0QQt1EcwRCHdahLD+jPm+ltGuJad0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8416
X-Proofpoint-GUID: F4eLC_QvcJLNzBz2_u5qEVhvlUoccOmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4MCBTYWx0ZWRfXz5dq+BJdIava
 HMLTU0xAbYEEnvvrLG1rkt9smgAACzVT9h3aji1uyF5XMktcaLhnVxNXdMtqpf7PsocRui8EOyP
 HE6tW7M4rmb5O2VpjzV8CW1k99BARxwjQG/z9U5MVlzULzQXIHPfV7Ej1syASHWjNL4+0lYh2i/
 GaUwg4FKyfIN+HgLuT/Ygh17mN+knEOF26HBtmBErFQdVCAhlxFwHWkHE5URoODCPvA/APwD6qe
 HGiJ5/yoxPksoCC6rvlCVXg1dR0BImAES6shRQYiK1AG9Fbupkrfs4DyKejmZzEEL2g4lrWrKFI
 gpnIGaBYRRfmL1yENGoJ6eO8EOlqiN/d+GQPFaSlAzPaKLboZ/ZY2INg2MrfXMSEMbZVKDWYaWM
 TSLBIFakiAum8roZ0S8Yzd9f6pBYjwdteRsUp5DqblCdTZ5Cd+I6JIQDx6QvXmZG4dQGYdtp9gL
 FUoxEjWqXY9yoTDeuuA==
X-Proofpoint-ORIG-GUID: F4eLC_QvcJLNzBz2_u5qEVhvlUoccOmO
X-Authority-Analysis: v=2.4 cv=DrxbOW/+ c=1 sm=1 tr=0 ts=698efd93 cx=c_pps
 a=lYPjzR6fd3Dugfv94BBcLQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=4-uh649DKE_nLJacOdAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Migrate the DirectSound audio backend from the legacy driver init/fini
> callbacks to proper QOM realize and finalize methods.
> 
> The dsound struct fields are now embedded directly in the AudioDsound
> QOM object instead of being allocated separately as drv_opaque. This
> allows accessing the backend state through proper QOM type casting
> with AUDIO_DSOUND() rather than casting drv_opaque pointers.
> 
> The DirectSound and DirectSoundCapture COM objects are now managed
> through the QOM lifecycle, with initialization in realize and cleanup
> in finalize.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/dsound_template.h |  9 ++---
>   audio/dsoundaudio.c     | 87 +++++++++++++++++++----------------------
>   2 files changed, 45 insertions(+), 51 deletions(-)
> 
> diff --git a/audio/dsound_template.h b/audio/dsound_template.h
> index 0678f2de38b..7979773eb86 100644
> --- a/audio/dsound_template.h
> +++ b/audio/dsound_template.h
> @@ -72,7 +72,7 @@ static int glue (dsound_lock_, TYPE) (
>       DWORD *blen1p,
>       DWORD *blen2p,
>       int entire,
> -    dsound *s
> +    AudioDsound *s
>       )
>   {
>       HRESULT hr;
> @@ -166,7 +166,7 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
>   {
>       int err;
>       HRESULT hr;
> -    dsound *s = drv_opaque;
> +    AudioDsound *s = AUDIO_DSOUND(hw->s);
>       WAVEFORMATEX wfx;
>       struct audsettings obt_as;
>   #ifdef DSBTYPE_IN
> @@ -174,13 +174,13 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
>       DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
>       DSCBUFFERDESC bd;
>       DSCBCAPS bc;
> -    AudiodevPerDirectionOptions *pdo = s->dev->u.dsound.in;
> +    AudiodevPerDirectionOptions *pdo = hw->s->dev->u.dsound.in;
>   #else
>       const char *typ = "DAC";
>       DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
>       DSBUFFERDESC bd;
>       DSBCAPS bc;
> -    AudiodevPerDirectionOptions *pdo = s->dev->u.dsound.out;
> +    AudiodevPerDirectionOptions *pdo = hw->s->dev->u.dsound.out;
>   #endif
>   
>       if (!s->FIELD2) {
> @@ -256,7 +256,6 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
>       }
>       hw->size_emul = bc.dwBufferBytes;
>       hw->samples = bc.dwBufferBytes / hw->info.bytes_per_frame;
> -    ds->s = s;
>   
>   #ifdef DEBUG_DSOUND
>       dolog ("caps %ld, desc %ld\n",
> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index 3de6a3dee9c..4ecf2ade003 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -45,40 +45,30 @@
>   #define TYPE_AUDIO_DSOUND "audio-dsound"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioDsound, AUDIO_DSOUND)
>   
> +static AudioBackendClass *audio_dsound_parent_class;
> +
>   struct AudioDsound {
>       AudioMixengBackend parent;
> +
> +    LPDIRECTSOUND dsound;
> +    LPDIRECTSOUNDCAPTURE dsound_capture;
> +    struct audsettings settings;
>   };
>   
>   static struct audio_driver dsound_audio_driver;
>   
> -static void audio_dsound_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &dsound_audio_driver;
> -}
> -
>   /* #define DEBUG_DSOUND */
>   
> -typedef struct {
> -    LPDIRECTSOUND dsound;
> -    LPDIRECTSOUNDCAPTURE dsound_capture;
> -    struct audsettings settings;
> -    Audiodev *dev;
> -} dsound;
> -
>   typedef struct {
>       HWVoiceOut hw;
>       LPDIRECTSOUNDBUFFER dsound_buffer;
>       bool first_time;
> -    dsound *s;
>   } DSoundVoiceOut;
>   
>   typedef struct {
>       HWVoiceIn hw;
>       LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer;
>       bool first_time;
> -    dsound *s;
>   } DSoundVoiceIn;
>   
>   static const char *dserror(HRESULT hr)
> @@ -276,7 +266,7 @@ static void print_wave_format (WAVEFORMATEX *wfx)
>   }
>   #endif
>   
> -static int dsound_restore_out (LPDIRECTSOUNDBUFFER dsb, dsound *s)
> +static int dsound_restore_out (LPDIRECTSOUNDBUFFER dsb, AudioDsound *s)
>   {
>       HRESULT hr;
>   
> @@ -295,7 +285,7 @@ static int dsound_restore_out (LPDIRECTSOUNDBUFFER dsb, dsound *s)
>   #undef DSBTYPE_IN
>   
>   static int dsound_get_status_out (LPDIRECTSOUNDBUFFER dsb, DWORD *statusp,
> -                                  dsound *s)
> +                                  AudioDsound *s)
>   {
>       HRESULT hr;
>   
> @@ -328,7 +318,7 @@ static int dsound_get_status_in (LPDIRECTSOUNDCAPTUREBUFFER dscb,
>   }
>   
>   static void dsound_clear_sample (HWVoiceOut *hw, LPDIRECTSOUNDBUFFER dsb,
> -                                 dsound *s)
> +                                 AudioDsound *s)
>   {
>       int err;
>       LPVOID p1, p2;
> @@ -372,9 +362,9 @@ static void dsound_enable_out(HWVoiceOut *hw, bool enable)
>   {
>       HRESULT hr;
>       DWORD status;
> +    AudioDsound *s = AUDIO_DSOUND(hw->s);
>       DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
>       LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
> -    dsound *s = ds->s;
>   
>       if (!dsb) {
>           dolog ("Attempt to control voice without a buffer\n");
> @@ -450,7 +440,7 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
>       assert(req_size > 0);
>   
>       err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
> -                          &act_size, NULL, false, ds->s);
> +                          &act_size, NULL, false, AUDIO_DSOUND(hw->s));
>       if (err) {
>           dolog("Failed to lock buffer\n");
>           *size = 0;
> @@ -553,7 +543,7 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
>       }
>   
>       err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
> -                         &act_size, NULL, false, ds->s);
> +                         &act_size, NULL, false, AUDIO_DSOUND(hw->s));
>       if (err) {
>           dolog("Failed to lock buffer\n");
>           *size = 0;
> @@ -577,13 +567,12 @@ static void dsound_put_buffer_in(HWVoiceIn *hw, void *buf, size_t len)
>       hw->pos_emul = (hw->pos_emul + len) % hw->size_emul;
>   }
>   
> -static void dsound_audio_fini (void *opaque)
> +static void audio_dsound_finalize(Object *obj)
>   {
> +    AudioDsound *s = AUDIO_DSOUND(obj);
>       HRESULT hr;
> -    dsound *s = opaque;
>   
>       if (!s->dsound) {
> -        g_free(s);
>           return;
>       }
>   
> @@ -594,7 +583,6 @@ static void dsound_audio_fini (void *opaque)
>       s->dsound = NULL;
>   
>       if (!s->dsound_capture) {
> -        g_free(s);
>           return;
>       }
>   
> @@ -603,18 +591,21 @@ static void dsound_audio_fini (void *opaque)
>           dsound_logerr (hr, "Could not release DirectSoundCapture\n");
>       }
>       s->dsound_capture = NULL;
> -
> -    g_free(s);
>   }
>   
> -static void *dsound_audio_init(Audiodev *dev, Error **errp)
> +static bool
> +audio_dsound_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>   {
> +    AudioDsound *s = AUDIO_DSOUND(abe);
>       HRESULT hr;
> -    dsound *s = g_new0(dsound, 1);
>       AudiodevDsoundOptions *dso;
>   
>       assert(dev->driver == AUDIODEV_DRIVER_DSOUND);
> -    s->dev = dev;
> +
> +    if (!audio_dsound_parent_class->realize(abe, dev, errp)) {
> +        return false;
> +    }
> +
>       dso = &dev->u.dsound;
>   
>       if (!dso->has_latency) {
> @@ -625,8 +616,7 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
>       hr = CoInitialize (NULL);
>       if (FAILED (hr)) {
>           dserror_set(errp, hr, "Could not initialize COM");
> -        dsound_audio_fini(s);
> -        return NULL;
> +        return false;
>       }
>   
>       hr = CoCreateInstance (
> @@ -638,15 +628,13 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
>           );
>       if (FAILED (hr)) {
>           dserror_set(errp, hr, "Could not create DirectSound instance");
> -        dsound_audio_fini(s);
> -        return NULL;
> +        return false;
>       }
>   
>       hr = IDirectSound_Initialize (s->dsound, NULL);
>       if (FAILED (hr)) {
>           dserror_set(errp, hr, "Could not initialize DirectSound");
> -        dsound_audio_fini(s);
> -        return NULL;
> +        return false;
>       }
>   
>       hr = CoCreateInstance (
> @@ -658,15 +646,13 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
>           );
>       if (FAILED (hr)) {
>           dserror_set(errp, hr, "Could not create DirectSoundCapture instance");
> -        dsound_audio_fini(s);
> -        return NULL;
> +        return false;
>       }
>   
>       hr = IDirectSoundCapture_Initialize (s->dsound_capture, NULL);
>       if (FAILED(hr)) {
>           dserror_set(errp, hr, "Could not initialize DirectSoundCapture");
> -        dsound_audio_fini(s);
> -        return NULL;
> +        return false;
>       }
>   
>       hr = IDirectSound_SetCooperativeLevel (
> @@ -676,11 +662,10 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
>       );
>       if (FAILED(hr)) {
>           dserror_set(errp, hr, "Could not set cooperative level");
> -        dsound_audio_fini(s);
> -        return NULL;
> +        return false;
>       }
>   
> -    return s;
> +    return true;
>   }
>   
>   static struct audio_pcm_ops dsound_pcm_ops = {
> @@ -702,8 +687,6 @@ static struct audio_pcm_ops dsound_pcm_ops = {
>   
>   static struct audio_driver dsound_audio_driver = {
>       .name           = "dsound",
> -    .init           = dsound_audio_init,
> -    .fini           = dsound_audio_fini,
>       .pcm_ops        = &dsound_pcm_ops,
>       .max_voices_out = INT_MAX,
>       .max_voices_in  = 1,
> @@ -711,11 +694,23 @@ static struct audio_driver dsound_audio_driver = {
>       .voice_size_in  = sizeof (DSoundVoiceIn)
>   };
>   
> +static void audio_dsound_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    audio_dsound_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> +
> +    b->realize = audio_dsound_realize;
> +    k->driver = &dsound_audio_driver;
> +}
> +
>   static const TypeInfo audio_dsound_info = {
>       .name = TYPE_AUDIO_DSOUND,
>       .parent = TYPE_AUDIO_MIXENG_BACKEND,
>       .instance_size = sizeof(AudioDsound),
>       .class_init = audio_dsound_class_init,
> +    .instance_finalize = audio_dsound_finalize,
>   };
>   
>   static void register_audio_dsound(void)

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


