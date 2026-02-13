Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE7DEDF142
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpyG-0006hn-Vf; Fri, 13 Feb 2026 05:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpyF-0006h9-Hm
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:00:19 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpyD-0001Sk-2O
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:00:19 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D2YbdL070772; Fri, 13 Feb 2026 02:00:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Hks7krn6TBTxzkhMQ2girwqLRv09569W2f1cVaGsf
 Pg=; b=JMtQsEAn91lp28XP0cvbgYKZ/HntYsFv8aX2UHYxBe2YsP1F/6SedCILS
 9vFoCVQtc4Iey3C+RX81E7wZOwnPyXE+pVEnhCbNDKkKn9zgrEjEw2Ockm3OTRum
 T13P//e2W1rx13W7BlOqGN0QrlI2x91x8sayl1dUjF5rWAcP89zZuJ2J1NrgPyfp
 suE1NbcqvUvsSD7rKn+HBce0/hrRqCtem8vCER5XL6aTwuG1jiPHE7lYoaq2GiSi
 I1k5BBzStw2Jj6P0LMDNVpodzQ6WnvCZubfHLoHQdlqwQRKQXXoOmgDrb/u7Jn0L
 HGeHOGc64IX9/JzrwAMlBXwUcLgKw==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022135.outbound.protection.outlook.com
 [40.107.200.135])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9u9f8wtd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:00:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDiCbKM4vhZ+3whZN92BX508mx4TAZ9QFAolQRyRuuxl73WYgIdyjjtN51GXXowiQojbrpjJENkHsjzfaLvBRBoRRD/Lf5fD7OC+f6v+pd2457aMmdUbp8dzgeem5gLuq9DpuHo5nni3VxTLVVRTtWClP227t9vux1yme9QH4AXAlYoFq4dcG3A7qWnFpFpvirIG5Jg+wMVXB1ryxYkq9rHBpWpUoVOZA0Mz4NICZQSxlodfbc2An9cV6clG6CRz83dGu13BTZQ29jit2mEaPVl+lQvHnfvyx/PfuW/YRW23q3+D5+vbzkCq0wnW82eUGEpkwQZqv/uT4j6nyaAfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hks7krn6TBTxzkhMQ2girwqLRv09569W2f1cVaGsfPg=;
 b=tx7atYo755Wl8yHrtpQRMO1L1mJvpjnrWNskHvn2XDQ2g2ma9BpX8hu0eryXYrv9a9np2I+G5pADmgWKx0kLTv0ZIUthFkJfkhJRoyVDsgDRVxN0nq4MIPFPKgHpr1ovfxzNKKi+vX4CPE5tMvCWLdALAbNDyKzV/GVMphOWJJ/OgSEIYH4NHb5FEkCbcoaUH6VptnLFhkBczrMg2zCugdPQnacUn58Nw1LKsti7yOAim8+y1qBpqxzSDXAieXtRucChtQ4lHiJ/FVxJEn7DlVihTzKH5EDD8WCr3m+JbCCBZOwI+Ir7BK1U7bqy0dV1F6Z8RSQmhR3QmX3ovzwPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hks7krn6TBTxzkhMQ2girwqLRv09569W2f1cVaGsfPg=;
 b=tWcGAzVYKpK4BCGN58yvbF0fqXli8jZv/cO5/QSfAjzK4sJYDLU7B+to5r9KOoSlPfDVLtsk3QB0XS9vQeBR8i8ufKybmXPw/RLkl4l4qGp/pWa3OAy1gbZKEHdRL6wJOVB8EGoIRyGudcqL7l4juX3eFpGMHNAsJFSzl6awQ3l7tckTytC3Esr6Jn8QY2/PxHlYYJEDujoV1k/S9MLv4TSu1x9fOnXBvfX4g+Uf8SYCVvmMpL/hR6SycE82Xag93h3BZPxCBn9bP3ruUU/rg4huvBIrrQaubSUVUL5/cpJ/Vbjxz9ZyNPm7N4HN1wR7VdUAkn9fR5V83otxHQhdvA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6848.namprd02.prod.outlook.com (2603:10b6:208:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 10:00:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:00:11 +0000
Message-ID: <b459cdf5-f03e-4ebb-bdec-e08443ea03fb@nutanix.com>
Date: Fri, 13 Feb 2026 10:00:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/43] audio/pa: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-8-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0250.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 0978e0f4-184e-4848-e64f-08de6ae6ad43
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aG9lUXFyeFZxekQrZ2phY0NHa01OckNCV01OSU95UW0ybjlmcHkybDdzZGwr?=
 =?utf-8?B?RG9qN1NNalpiZFJVTHlDaE1RK1puRGRuSC8yK3dzRm5TUVprak5ka2w4ck9q?=
 =?utf-8?B?Nm1LU0t6NkpxOFhja0FqNU54N08xQk9kaXJnc0xqS3pGLzlvaWpjcVFIUkcw?=
 =?utf-8?B?R0VrN0ZSNWNBQ3NLaDljdjFCcUpobThPMXBMa0Y4SGhnY3p2cFRNb2IxUklp?=
 =?utf-8?B?VnVkazB5T0pudFpENmRHMEY0enBNODJWZ1d4WjB2SmYzUlNwMVEzNXhjczdL?=
 =?utf-8?B?SVg5UTZKcE51blpJSkdUTnpBdGxYeDljQnF0ZDFoSUY5ZWluSEhyMnNUUlBR?=
 =?utf-8?B?R2FaMWVkanRpbTdLRWxCZkkrbGxZV0tFVEFmNXc2VXdvSFl0SjFtOTdkR0RO?=
 =?utf-8?B?NW8xUW9QOEZ0ejNsdm9uampTNXlzNG5TUEN5NnkwYVlEN3hJV0h2VGQxTFZt?=
 =?utf-8?B?QXJJNW9WT2NBSklMQm9sU2g3NDJKU0IvTGFxcWZMZVBZN2dqQUF4emhkSzIv?=
 =?utf-8?B?cjdvVkw3Y0VRVEZUeGhhcTNNR1N4TzJZcEEzTytSNDRybkl3bnZxM25uMnR1?=
 =?utf-8?B?citoTFVITGszSW9jbHE1VFh0L29ZSFp2VXFPTDBVMWo1ZUU3MEJtb3lxZnlv?=
 =?utf-8?B?aHkvMllOYXUrUVUrOUR3M0dWblNkcDkyMERJdGlJdzhjRlpiaGRFYUVBWnFs?=
 =?utf-8?B?eFl0NGhIT2FYd0RITGRncDI2ZDdnYURMM3R3eVltSFpwZzZoZXB3d3hvYi9S?=
 =?utf-8?B?cFpOUlBiRUIxT2ZKYUFJTldvV1NBVkI5Q3o2SWRteWhaTkhqZTd2TDMwMHd3?=
 =?utf-8?B?TFRiMHp4WWc3d3lpcXZtWkRiYWRoOE5XMjF6VUY2bWNNYy9DUmpMNlF3SXdM?=
 =?utf-8?B?SjlLc0I5OTg1eSs1V0tOOEdqRDdKYloxRkUrZHhwMlRVUkNzdDY1UUZRblpE?=
 =?utf-8?B?Nmc3RzZ3T0pyN05jdjZteHdaLzdoTURBRWliMDZLS0lQcmcvbUxmd08wSE94?=
 =?utf-8?B?VUJVanQwZVRUTTVXbEdEV1FpUjlMTHBHRSsrbFdYQ21JbWJiV2l3U3JJL1li?=
 =?utf-8?B?eHl4ZURxV1NQNktMdEtGZlJjV2NTdExJTm85Rk4xSE8rVkg4TkthUmxnbGFB?=
 =?utf-8?B?NVZXSy8rQjZyaFgzdU80NEUxd2x1TUc2OVdJM1hDS0tMT3piRUVobm5odndE?=
 =?utf-8?B?a2E1NGFyeEdOa3JuOUlZMTFHSitMTFc5TE5EWFNROFFSbk5FM2xla1pUa3Q2?=
 =?utf-8?B?aGVMUHh2b2QyL2ZDTDYyRytLSTNhaHoyeFF1NE9XY3pjZzRMZXRaV1o3NFVI?=
 =?utf-8?B?UDFjVFhJQU9PTlBpTko1b0JtWmVjNHg5KzdzdEh3RVhYZ1dCSmU0TThPU2dJ?=
 =?utf-8?B?RWllZ0NXZXZSUUtKWkxuMFJaVU5ack1uRTRiT1hkVzN1UDQ0T1JncFRMUXJO?=
 =?utf-8?B?b0UvUTFreWN2OXZ4Ykp2MGppbkROdGZrOUxmdWIzYlNPN0FuaG5QKzRBRzg3?=
 =?utf-8?B?ZXFKKzQ4RHFYMTVIdEVBSjVyS1lSdnN2M0xlVldMVjN5RmVQaFBYM3VFNkdN?=
 =?utf-8?B?QnVBcHJCQk5tMXcxZkNrQmxIMkMxcE5sUlFWL0dPZVQ1RjhCeHB3UVdTdnAr?=
 =?utf-8?B?d0l6YmdMZFNzSjZDZDVscnl0RU12VnBlcFRsWjY2V0Z2NXZZd1RYalRZcENt?=
 =?utf-8?B?M3ZKMUtyZ2NMem1BMFBnSVBqd1FsT2lyT1Rkd2djT3I1NTRMaS9lanFCRW5C?=
 =?utf-8?B?QzNsODZQUmd1WC9aYVVoeWMwL0NvempKQzgzRTRTMU1EbFRlRWZUdTFrRWJQ?=
 =?utf-8?B?M042Q3VvdFhZM0JKeFhsMnV0RDFjZHdzaTlqUGZ1bFVKMlJjd1Y3YlJHVmZU?=
 =?utf-8?B?MWg1enN5WlM3dW9SUE1sUnozakoyVmpqak55Z0k5TWN1czk1Q2NlUGpwa1Nm?=
 =?utf-8?B?THM1eDJyRlB0YytmNFJFSDRNZzVkZHpHZ2dsTFhTSkJSNVpGd3lDL0pTSEww?=
 =?utf-8?B?eXNibS9ReCtVcCthVmdESTdsV1NIVnRJbCs1anV2RGVTeGRHVU8raE5Raytx?=
 =?utf-8?B?YjV1TmxVVlJFTzdDano2Sm9OMlJGVWxEamNGWEd6TmMwNkw1c3l5Y0lwMFh0?=
 =?utf-8?Q?DOMA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckpGczh0YVRkZTlKbWVlajNsbHRwRHFZejVqckc4SVJLVUJ5MTRJRnlUMEVk?=
 =?utf-8?B?M1VZWDUrRVNKVFg3Z3Jwd241aGlWZnV4eE9Ec0tCUXkzOGxwVVBrUFVMR2lj?=
 =?utf-8?B?RWFsV3J3RU1ZZTVINXZrRUgzdGlNZUpqNlltVUdUVnl4OE5IeWVKdjY5MWUx?=
 =?utf-8?B?SUQ2bE5iaWEzR01waVZUKytUaCtsUHJIbnMzNW41VWplNlFzbDBaS256MWJj?=
 =?utf-8?B?eWF6b295THJDK0RVTW5temw1T0VpZXJvWWJ1eDJVTklybmsrTkV4MHlheklj?=
 =?utf-8?B?V2REVjYycUNqb0N0UHFlVlZZT3NURHZxZ3BDVzJGQ2lDS3dQWDI3OVV4Vk8x?=
 =?utf-8?B?V1I0aW1lMnZ4RDAvci9jYUVHeDJkdjJZZ215dkV4RWMvdm05THhoL2xLY3J3?=
 =?utf-8?B?YmJtcmt1U2lGQzJqaE5hdHlhVWM1VmNVN0I0dXFDdWxwSmN5NW1FcGVVSmxQ?=
 =?utf-8?B?MEtOREJIWTRVU1paaDBCRkxtaldQU2VMTWRvZ0dibXJvOThyODlyVnBlSVBV?=
 =?utf-8?B?VFc3cHJycHdvdUsybjdPdnFnNFdpT1E3d09GZEZDYi9LR0RjSEFrRXFWeDlY?=
 =?utf-8?B?V1p0NW1BSUN5RWpaNXgydlRlL0g1aWdlaS96LzdkM2UrREYxUlZoMUdKdUZB?=
 =?utf-8?B?VmRvREI4ODdkOEVjaHJpWkRuQjdaZ1VBem1LMlg1MFdaR2o0UU5TdzYwVUph?=
 =?utf-8?B?dXUzckNDYkxEUXJ1OTJHYWZPTkg5U0l4eFhia1M0ejk5c0lnMGFnek1USmRG?=
 =?utf-8?B?SzhDR0xnLy81Q29HQ3BYL0tSNnVyQnRQZXZpaE1XcFdoZm9Lai9nc1MzTVQ3?=
 =?utf-8?B?NXdwWEltVTJlb2hLQWwxbGl0VTY1ODJzc3N0YkpHcC9LM3dHY1pTd2QwS3hI?=
 =?utf-8?B?NXJvUlhLa2J2M1lNejFNcVU0WDY1Y3liNytjWHdRWWlkZWhjM3FlaU45Uk9W?=
 =?utf-8?B?UGRJeiszSEY3bzh5TVQ3dmxrY1RvWUV5ci8wVVJYajhHY09FZGpHdEZTMm1t?=
 =?utf-8?B?SjNHREowTFFCYzViY0VtM2R2NnVKNTZjVmgweEFVVmdiWlMyZ3YzREVvUzV4?=
 =?utf-8?B?SHZoMnZnNmRPQjdNZENXSkQxNldmSlVXSzdwWnR3d3hwMEYwTDB1UXpXWDJ2?=
 =?utf-8?B?SW11clNRNmw0dy9wR1FKWW5uNHFrSmNkdC9PTWxmeFFTUlZaSERNMDNUVGdp?=
 =?utf-8?B?RlMreVBJT2VFdUY0QXFUd3NsS2ZneHRIVVlsQjRWMllVS3FYaVpZR3RtZlNX?=
 =?utf-8?B?d21DcUpETlEvSnE3YVAzVDBsTGpzc0JaY2NNSzZqdm9RMER3ZWQvUnozd3dq?=
 =?utf-8?B?c1RyV1NHMUdwSDFHYWVFcGlteU5WMHcvTXVITHlMOVYzWlVDUFdjQTNYUnVQ?=
 =?utf-8?B?SzFrek8yNmdzZjdqUFNEMUdwMXNFbDVCai9Pc2RGeFhmZVFudEF6S0NzeHVO?=
 =?utf-8?B?V0VEL1MrUGJDc0FKRG9hWHFyd0lkd3Jzdmo5dW9qY0RPMUx4aFNwTjhSb0tX?=
 =?utf-8?B?MXRYU0t2YmpKSHNCQWpZdytsbmtFb1dRK0ZPK2RKMDVRczhlUGNadys1Y3Yx?=
 =?utf-8?B?V0FqUUpMYWU3QWVIbTNXcW44MlJrR29pOUhjaHZKMjNUc3FKYVJzcDAyczN1?=
 =?utf-8?B?MFZ4cUU5T0pScXFtRDgram5qYmFaZHV0enhKUjJrVW9iRTR3WlU2enA2WnYr?=
 =?utf-8?B?d2lKQ0kvL1Q3TkFMSzR1aTNQZ2Zkc0ErbVhqOUdBc1Y1ZTNSdURpQzBMOEph?=
 =?utf-8?B?VURyaHpSZ3h3QUtDNHczM0pOUnQyWVlhdzRDeU1qcVJlSjBjcmhNM2daem54?=
 =?utf-8?B?ZkxhV2xZK2Z4dGtzclRsT2xBYlZsT1NQOG8vTFpRRXpyY09VcTF0NmNIVFNE?=
 =?utf-8?B?ZEhKaHN6bjQ1bXhtbUJJZkhtTldjaE44N1VsUTJjOERTUytyQXIreEpRY0tm?=
 =?utf-8?B?ajRKZ1NYa1hMTGtzN3ZGQ3BwYTJORWw1RnNYQ3NTR05FODBvTUhGaUJnbm5O?=
 =?utf-8?B?UDR5aXhjaEtjZk54TDFQb2dEUUUvQUVjSUwrREJPY3U1YlJLcGlyR3M0M3NN?=
 =?utf-8?B?L0tyZklicVVDQ3RUZjgzbU1WUTlDWWV0WXR5Sy9UdzFVNUVXSWIvd2k1NEl0?=
 =?utf-8?B?QlZQK0RWLzNZVGhFUWFsSTZiQUhKU0szY2UxSUJ0cmdRSG1LOFBaQmtacmx5?=
 =?utf-8?B?ejBlQXpMR0IwbytNVGpwUGhBeG5tVEhCYVRJNWh0aHJONkxTU1YyQnl6NE0w?=
 =?utf-8?B?NjhEcUFuZW1Pak1sZWRpSDJQVkgwUDlDRllJN1hsNnJxVnhPMHRnMkd4UEZl?=
 =?utf-8?B?MzJzK2hmL3ZkM25jS3F3TDg2WmNMK2UzSzBMUGNDUmI3T2VXeDU5SlBiWE9H?=
 =?utf-8?Q?+Gjgzff5frEsM9oI=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0978e0f4-184e-4848-e64f-08de6ae6ad43
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:00:11.6111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQvkLOWDKPRf05EN2q0lsb0qU/9WhCvEDNua+cA7JkFGM4HMDGn5hY+bxjEj1JyBiIXXHaJCp+GFThmqQGVJb7iKY3tkJOuU3yPdsYVjePA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6848
X-Authority-Analysis: v=2.4 cv=OuBCCi/t c=1 sm=1 tr=0 ts=698ef62d cx=c_pps
 a=qA2lyNeKfuBKxbHetcl1Mg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=8o11-kSyLMeeCoeMEp0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3Dt491dmGKV3CBUs7VFd36I0aDP05Sqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NiBTYWx0ZWRfX9YbSW7KQ1hSs
 WvFQoc2ha8wQrIZ64zwJhAQwS8kNR7rV1num71ubKfT2156H1LaOlQC7nuQG2P90PZjKcum03jU
 IhoAEldUDsN1qPOfQaZs/I5jIRaB2fYkGmC71PttR1Rc2itwDv3angT5MbPlNv72Wbd/Dj7oDKF
 CcA49pFuwiLxMNBBxJvYBPPYXTndqS41543Yuqg6960APTziHwT8hQv9tUf5IgXQLI/IHbi4poL
 JqbF9WMY3KJGZHw6GlEJ5FTBA4yK12+1JrrmOS88/OUK2ufUhQMgl4R7xHJhxadPjF+dfo1WN4b
 9vvxLYQm2p5MEY7LQsSbh0ERNPGDLrUA/71OkDHv06l/gd5wWXTcFzJOjeY1f5H/AwHeG6pUHQZ
 qr11UdrvJnmWzIWavreVYejtoq8EdT6qRx/Hv3yZ7TZtiPaXzI0zS/KAwv6Xf7/8cuQ239ehB+c
 Uk/pS0YIMLU5PW83iWA==
X-Proofpoint-ORIG-GUID: 3Dt491dmGKV3CBUs7VFd36I0aDP05Sqe
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
> Migrate the PulseAudio backend from the legacy driver init/fini
> callbacks to proper QOM realize and finalize methods.
> 
> The paaudio struct fields are now embedded directly in the AudioPa
> QOM object instead of being allocated separately as drv_opaque. This
> allows accessing the backend state through proper QOM type casting
> with AUDIO_PA() rather than casting drv_opaque pointers.
> 
> The PulseAudio connection is now managed through the QOM lifecycle,
> with the connection reference acquired in realize and released in
> finalize.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/paaudio.c | 109 +++++++++++++++++++++++++-----------------------
>   1 file changed, 57 insertions(+), 52 deletions(-)
> 
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 941f75f25e8..8191b54468e 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -14,19 +14,10 @@
>   #define TYPE_AUDIO_PA "audio-pa"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioPa, AUDIO_PA)
>   
> -struct AudioPa {
> -    AudioMixengBackend parent;
> -};
> +static AudioBackendClass *audio_pa_parent_class;
>   
>   static struct audio_driver pa_audio_driver;
>   
> -static void audio_pa_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &pa_audio_driver;
> -}
> -
>   typedef struct PAConnection {
>       char *server;
>       int refcount;
> @@ -36,18 +27,19 @@ typedef struct PAConnection {
>       pa_context *context;
>   } PAConnection;
>   
> -static QTAILQ_HEAD(PAConnectionHead, PAConnection) pa_conns =
> -    QTAILQ_HEAD_INITIALIZER(pa_conns);
> +struct AudioPa {
> +    AudioMixengBackend parent;
>   
> -typedef struct {
> -    Audiodev *dev;
>       PAConnection *conn;
> -} paaudio;
> +};
> +
> +static QTAILQ_HEAD(PAConnectionHead, PAConnection) pa_conns =
> +    QTAILQ_HEAD_INITIALIZER(pa_conns);
>   
>   typedef struct {
>       HWVoiceOut hw;
>       pa_stream *stream;
> -    paaudio *g;
> +    AudioPa *g;
>   } PAVoiceOut;
>   
>   typedef struct {
> @@ -55,7 +47,7 @@ typedef struct {
>       pa_stream *stream;
>       const void *read_data;
>       size_t read_length;
> -    paaudio *g;
> +    AudioPa *g;
>   } PAVoiceIn;
>   
>   static void qpa_conn_fini(PAConnection *c);
> @@ -529,23 +521,25 @@ fail:
>   static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
>                           void *drv_opaque)
>   {
> +    AudioMixengBackend *amb = hw->s;
> +    AudioPa *apa = AUDIO_PA(amb);
>       int error;
>       pa_sample_spec ss;
>       pa_buffer_attr ba;
>       struct audsettings obt_as = *as;
>       PAVoiceOut *pa = (PAVoiceOut *) hw;
> -    paaudio *g = pa->g = drv_opaque;
> -    AudiodevPaOptions *popts = &g->dev->u.pa;
> +    AudiodevPaOptions *popts = &amb->dev->u.pa;
>       AudiodevPaPerDirectionOptions *ppdo = popts->out;
> -    PAConnection *c = g->conn;
> +    PAConnection *c = apa->conn;
>   
> +    pa->g = apa;
>       ss.format = audfmt_to_pa (as->fmt, as->endianness);
>       ss.channels = as->nchannels;
>       ss.rate = as->freq;
>   
>       ba.tlength = pa_usec_to_bytes(ppdo->latency, &ss);
>       ba.minreq = pa_usec_to_bytes(MIN(ppdo->latency >> 2,
> -                                     (g->dev->timer_period >> 2) * 3), &ss);
> +                                     (amb->dev->timer_period >> 2) * 3), &ss);
>       ba.maxlength = -1;
>       ba.prebuf = -1;
>   
> @@ -553,7 +547,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
>   
>       pa->stream = qpa_simple_new (
>           c,
> -        ppdo->stream_name ?: g->dev->id,
> +        ppdo->stream_name ?: amb->dev->id,
>           PA_STREAM_PLAYBACK,
>           ppdo->name,
>           &ss,
> @@ -578,23 +572,25 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
>   
>   static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>   {
> +    AudioMixengBackend *amb = hw->s;
> +    AudioPa *apa = AUDIO_PA(amb);
>       int error;
>       pa_sample_spec ss;
>       pa_buffer_attr ba;
>       struct audsettings obt_as = *as;
>       PAVoiceIn *pa = (PAVoiceIn *) hw;
> -    paaudio *g = pa->g = drv_opaque;
> -    AudiodevPaOptions *popts = &g->dev->u.pa;
> +    AudiodevPaOptions *popts = &amb->dev->u.pa;
>       AudiodevPaPerDirectionOptions *ppdo = popts->in;
> -    PAConnection *c = g->conn;
> +    PAConnection *c = apa->conn;
>   
> +    pa->g = apa;
>       ss.format = audfmt_to_pa (as->fmt, as->endianness);
>       ss.channels = as->nchannels;
>       ss.rate = as->freq;
>   
> -    ba.fragsize = pa_usec_to_bytes((g->dev->timer_period >> 1) * 3, &ss);
> +    ba.fragsize = pa_usec_to_bytes((amb->dev->timer_period >> 1) * 3, &ss);
>       ba.maxlength = pa_usec_to_bytes(
> -        MAX(ppdo->latency, g->dev->timer_period * 3), &ss);
> +        MAX(ppdo->latency, amb->dev->timer_period * 3), &ss);
>       ba.minreq = -1;
>       ba.prebuf = -1;
>   
> @@ -602,7 +598,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>   
>       pa->stream = qpa_simple_new (
>           c,
> -        ppdo->stream_name ?: g->dev->id,
> +        ppdo->stream_name ?: amb->dev->id,
>           PA_STREAM_RECORD,
>           ppdo->name,
>           &ss,
> @@ -834,15 +830,20 @@ fail:
>       return NULL;
>   }
>   
> -static void *qpa_audio_init(Audiodev *dev, Error **errp)
> +static bool
> +audio_pa_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>   {
> -    paaudio *g;
> +    AudioPa *apa = AUDIO_PA(abe);
>       AudiodevPaOptions *popts = &dev->u.pa;
>       const char *server;
>       PAConnection *c;
>   
>       assert(dev->driver == AUDIODEV_DRIVER_PA);
>   
> +    if (!audio_pa_parent_class->realize(abe, dev, errp)) {
> +        return false;
> +    }
> +
>       if (!popts->server) {
>           char pidfile[64];
>           char *runtime;
> @@ -851,42 +852,38 @@ static void *qpa_audio_init(Audiodev *dev, Error **errp)
>           runtime = getenv("XDG_RUNTIME_DIR");
>           if (!runtime) {
>               error_setg(errp, "XDG_RUNTIME_DIR not set");
> -            return NULL;
> +            return false;
>           }
>           snprintf(pidfile, sizeof(pidfile), "%s/pulse/pid", runtime);
>           if (stat(pidfile, &st) != 0) {
>               error_setg_errno(errp, errno, "could not stat pidfile %s", pidfile);
> -            return NULL;
> +            return false;
>           }
>       }
>   
>       qpa_validate_per_direction_opts(dev, popts->in);
>       qpa_validate_per_direction_opts(dev, popts->out);
>   
> -    g = g_new0(paaudio, 1);
>       server = popts->server;
> -
> -    g->dev = dev;
> -
>       QTAILQ_FOREACH(c, &pa_conns, list) {
>           if (server == NULL || c->server == NULL ?
>               server == c->server :
>               strcmp(server, c->server) == 0) {
> -            g->conn = c;
> +            apa->conn = c;
>               break;
>           }
>       }
> -    if (!g->conn) {
> -        g->conn = qpa_conn_init(server);
> +    if (!apa->conn) {
> +        apa->conn = qpa_conn_init(server);
>       }
> -    if (!g->conn) {
> -        g_free(g);
> +    if (!apa->conn) {
>           error_setg(errp, "could not connect to PulseAudio server");
> -        return NULL;
> +        return false;
>       }
>   
> -    ++g->conn->refcount;
> -    return g;
> +    ++apa->conn->refcount;
> +
> +    return true;
>   }
>   
>   static void qpa_conn_fini(PAConnection *c)
> @@ -908,16 +905,14 @@ static void qpa_conn_fini(PAConnection *c)
>       g_free(c);
>   }
>   
> -static void qpa_audio_fini (void *opaque)
> +static void audio_pa_finalize(Object *obj)
>   {
> -    paaudio *g = opaque;
> -    PAConnection *c = g->conn;
> +    AudioPa *apa = AUDIO_PA(obj);
> +    PAConnection *c = apa->conn;
>   
> -    if (--c->refcount == 0) {
> +    if (c && --c->refcount == 0) {
>           qpa_conn_fini(c);
>       }
> -
> -    g_free(g);
>   }
>   
>   static struct audio_pcm_ops qpa_pcm_ops = {
> @@ -939,8 +934,6 @@ static struct audio_pcm_ops qpa_pcm_ops = {
>   
>   static struct audio_driver pa_audio_driver = {
>       .name           = "pa",
> -    .init           = qpa_audio_init,
> -    .fini           = qpa_audio_fini,
>       .pcm_ops        = &qpa_pcm_ops,
>       .max_voices_out = INT_MAX,
>       .max_voices_in  = INT_MAX,
> @@ -948,11 +941,23 @@ static struct audio_driver pa_audio_driver = {
>       .voice_size_in  = sizeof (PAVoiceIn),
>   };
>   
> +static void audio_pa_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    audio_pa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> +
> +    b->realize = audio_pa_realize;
> +    k->driver = &pa_audio_driver;
> +}
> +
>   static const TypeInfo audio_pa_info = {
>       .name = TYPE_AUDIO_PA,
>       .parent = TYPE_AUDIO_MIXENG_BACKEND,
>       .instance_size = sizeof(AudioPa),
>       .class_init = audio_pa_class_init,
> +    .instance_finalize = audio_pa_finalize,
>   };
>   
>   static void register_audio_pa(void)

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


