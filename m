Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D687ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 09:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGDIx-0007ru-PC; Tue, 04 Nov 2025 04:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGDIt-0007qT-Oi; Tue, 04 Nov 2025 04:26:15 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGDIp-0007Vr-Hd; Tue, 04 Nov 2025 04:26:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5fdWPR6J65e95LfIFpqW5QUwMRjDcS89lN0dH1d79p0YZbdVZFbMzrqA3lTDtF27DqM0WYrNKQOmmvujiaH4ZukloO8e+odCUjC/gdGJFdyi1pcoQnc5Ph0Df2neGkqdhs7RPuAICoQZTpHiZd8DFapRmt9YzWsTktPL5cHSxkdi/fk5Q5XKOF889sux+E8ExYJkia3fBGdMmKI1Wbiy/LBy1D8R7mArU1QiIgnWkPHwfb0HH0LDVsdPLLYbcV/zXHKDcd+2DR6o/24oecqE2DXfK6W4eCfGoSjReSMZu/8IjDC38pK5gyNQswQVGNQHztvn139zIuCfL2WrcypDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMMJWm1dnx8W4/PFzBej+2HNM3ZsIgqT9J4YAU/HQ64=;
 b=IFgY0n/YZPrmXqyskgUAEcXIi/mbgQyiEFqsVWxmjsru9zPcpysGqCX/92hAGlmzAVVpmi5CKS3Sr1UaEIAQhl/XKYRHdqznUfzPzGZFiCuS4gM13qdOpZ00UdkkMmXJHGPE1y/FucI9nAmQeU/AAKQapEfkxVfJBhVDUpAluDHcD0bdFtPECiHVAzLjdAU8ner8UXqCyNQ6mSecHJEMoYV8cAW6/i0REf18RCNjgh32yEMXUuO6P3b6S82atweS2HGlf98TtjHZkpuRphnQQEbnGaBOPCiRh1w9yilTD7XqCzbr9UuL8JMndS/1LIGXwPpJdjoHaUDgL+52xcdD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMMJWm1dnx8W4/PFzBej+2HNM3ZsIgqT9J4YAU/HQ64=;
 b=YwYiRSWxeIca6L8vbzx1gql3YqAJCGv2raJ9udd9pjUp9hHSa3USzTAGgmnJlwqVxjtFGSschKyjMIyA+vHo/ou4P01N9or6hJWzROL0KcJcT5HGEFoA/9yu3tmOeNc79L2b43i2aCGFBZezDHSQ0sH4c7HbHiSrzEhWKCvdT7EyKLRGOw0eLmp9putKNJg5h21HoJwPltIf0J14rxFPGpCtUW/3rPmNABaGTswrf+HMQqCe9oIVbxKkdOg4uMkawFJs3oEHIe/DthNWWrD3LdMe+4I01KyLpcCHqhmG1tocu0//XpFqBj4UDurNW7NlOgkji6frFBDQz7I+fNu6/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7394.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:605::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 09:26:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 09:26:07 +0000
Message-ID: <b4becb69-cf74-4e1b-97f3-52756b8a69d2@siemens.com>
Date: Tue, 4 Nov 2025 10:26:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] scripts: Add helper script to generate eMMC block
 device images
From: Jan Kiszka <jan.kiszka@siemens.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Eric Blake <eblake@redhat.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <5c9c6495ad4afc9d11f856bafcb797fed8fccecc.1760702638.git.jan.kiszka@siemens.com>
 <bfd49f9a-0a37-4e1d-b7e2-f0e59943915e@linaro.org>
 <08287450-4889-4329-b21c-87fde274b13f@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <08287450-4889-4329-b21c-87fde274b13f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b55231e-4f61-48c0-732a-08de1b842ef4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MU5PbmE1NlRqZlJNQ2w0MlM5ZDlLZnNBMVVGYUw5ZFFzaVFXVzlnMlkzV3BX?=
 =?utf-8?B?dG0xS2VkZ0NNN2JlQWtTemRBS25iNmdwR1NsMkNROXRzMkFBWkl3R1VrNVZs?=
 =?utf-8?B?UWIrMmZoWDVwNldwNDhYNGcwRTR4U0tSQUFHZ2dwNS9DR1dwZ1hmVHh0cmZN?=
 =?utf-8?B?Y3ZpNUtFcWZ1MWZ1MEc0QmY2WGFMZWdnZVNHYlhxdk52QkxGOS9yVmxXVjlk?=
 =?utf-8?B?NU1CeFlWUERaS3ZtOFBvY1ZSVWtHZmFQazArNkJEL0x5YlJUWjJUeGpIbTdQ?=
 =?utf-8?B?cE9nMnphRTdZQkNnZzhIREY4SmI3dkZPSHhqVkU4eWNrSU9DMUxjM0pGMFZl?=
 =?utf-8?B?U3NjTEJ3L3N3UkRkTlpYZmRncnhRb2NDZklMa2E0UTJuM1N2V3c4eHZiUmZ4?=
 =?utf-8?B?dDJxRGNKNkt0bG1BWW4xRVdzMHREOXlENDZTVHlsSmhQN0lRbTlEaXRlVHd1?=
 =?utf-8?B?K2swbVZ4c1Exc1hhZWx4ckYraVJXQnkrRFVZNk5pVVQweFRQR0svdkRPcVlY?=
 =?utf-8?B?YnV3TStjODBFMk1tZW5SVHc2ZEZxZThtL0JoejJPN2Vtb09NWWNudjhJY05C?=
 =?utf-8?B?c0FqTHFmSGRSd1NnRFRqTHVmdnNhNllYVzVjMXVGWUlpL2JmOTJKeitSM0VQ?=
 =?utf-8?B?QmxndUVHc2ZhQzB1SzBIdmdEOVp3T0JkeW9PeUlYN2ViUUZKN1pGdVpJclh6?=
 =?utf-8?B?dzlZaWJCbnl1d25jYTFMQU0va2NIMmFFOFh4a213NVV1RTFwbU15YktWZEhy?=
 =?utf-8?B?SlM1WnpoNnFnVjJPaUFWQTg2aG9GN2lnNjdudXZlbloxakF2OGJlbUx1TFNM?=
 =?utf-8?B?NlBpYVVxQWM2S1pUc1B2TExQM3hPVjZHRnJGaGFGTndsZmY0alJQUkNuQzBQ?=
 =?utf-8?B?Rzl1S1RIblFwTHBrRGFLa1pXWGdBemg2U3U3TkRiVy9BVkYxaGlZUnZtWUVD?=
 =?utf-8?B?NHRrWitjcElqRy93d2pIWmc0SXc0WWJOMXdpa2thaWoyOENOYmt0VW92YjNx?=
 =?utf-8?B?eFVNLzYxalJ3MnVXeFNyeHc2aERJS1BpNW9XMGhWZXFOVkpyVzRDK2RLTnNY?=
 =?utf-8?B?dDNjZ0FyVEduOE5Pdm1obG5RK2JnT010Z241SGIrZDZ6a2JZMXZLOHV4Q0FU?=
 =?utf-8?B?dnBUbVZKVHNUQ0llYlVRNWErMUVrVFJqUm9vR052WHNzMEsxK2ZvQ3FwYk5R?=
 =?utf-8?B?dWdZaXExL2hzWnJkNXliNEZrMnJxQ2d6LzlDaEp5c0RxTjZ4UklxaVN1Q1Zn?=
 =?utf-8?B?OThvcUpTNzFyM3dzQjdEajRybElRd0xBTTV4UXFZSXc4NjhQMHhRelBldUJy?=
 =?utf-8?B?SEhXUnFvQXRqV1hUOXBuUWtXYzIzVElEUHlmd2dwTlZoNWFlL2VjWXR6Sk5l?=
 =?utf-8?B?YVNaUVM4NHQzZmxNZXdEUUlQNW95bEFWd3hrajlhbm1aUzUvNitMU0VtZTRm?=
 =?utf-8?B?WU9mMkY4Y3JWeWpUVnAvckF4Yy80Y0VXbjJnWDR2SXQvODhCbnB3NWJuOGNh?=
 =?utf-8?B?RkN5NU14U3NnOTRMdFhVZ3NLcC92TXJTTnRDQ0xPZzJJeHc3NFh1NzI4SWpo?=
 =?utf-8?B?MzhhOCsyc1RuZmN4Yzc4eElIdFB4MDkrRjFtMElqbVBuQXUvQ0xhenNFVE5q?=
 =?utf-8?B?SlBiV1VucFVjNFZHdEhKNmFMWm5nT0RxcTNTQlZxVThSdWR5WWxPQ3ZFa0lu?=
 =?utf-8?B?VFZaQlZHcXBKNDhNa3U2N1lwYnMxeDNwb2Z3N0k0b1A1MXRFMDc4ZzVMdEdG?=
 =?utf-8?B?ZXU2b3dJM3NOeVJjZEFWUFZIRGt0aldqS0VLdjVCL0Z1dDYxVUJoUW0zeFV0?=
 =?utf-8?B?Q0JwWUxoYnZ6ckkvMUdReStBMk9GQmN0VE42NnJkbkNzU05RSzZ6R2Vlb2wx?=
 =?utf-8?B?UFdTUGlHL1NHV3JCV0o5eks0WXNWOXdOQlNWMVE2R3FxNVlmOW10Ti9peEdS?=
 =?utf-8?Q?X2M797TJ3W5+H3JOKTbRYSmuhRMGBoUp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWlWV0dVaHVYeUdvWkhwUVBldFRHVFhzb3BYODMwSGRNckxKQUNXaTRPcDkv?=
 =?utf-8?B?Z241ZURkN1ZZa05ZRlI4dStmRk9hTzQwaU1MTDNZNnFIN1E0SUJyVkdiOUtv?=
 =?utf-8?B?c3hYQUVlYkVKcXkzQ1pvazZURU5CUDZtRTVIMkExNUFiU2ZWUnVmLzF3bm4v?=
 =?utf-8?B?RFVMWFhnbEZqRU1SNUZTM2x5b05GL2MxZ0VHWXdQYXllSXpBUmpEaUVIdGN3?=
 =?utf-8?B?TEp3eWQ4djUwSjgyOENZR1BmM3VxMDd3NVVOZHYyVHlWZWsvRlUxbmd5SEJN?=
 =?utf-8?B?akthRUZyV2JjQjhXc2gxN0N4OGR6VFdnS3Vxb0NOektiK1J2OUJsbjR2MDJk?=
 =?utf-8?B?cVQ5UXZQUWdxVlhUb3ZiVTFSYlkyZjdwU0dKODNHem9sRE1taFV5QVBPYTBW?=
 =?utf-8?B?RUVmY20rdkhUd2JzV1VjVWFONjA4cW8wNUNMYWtjbzAwekduVFdXV01pRjFT?=
 =?utf-8?B?bXhiOE5uaTF5c1Z3OGJHMXZOZlg3eHVzbHdXMThPRmdmdmZDdHRIa2lrNUto?=
 =?utf-8?B?ZklvWnVIQi9pU0tBZFpwUVFSZkNXS0ZwTHJ3bCt5U3NZbzdmcEhQLzZoaytL?=
 =?utf-8?B?dWRSTzBYeExEUGVjMkhqdmpNNmhkOHVkZEtOZGpHdEpBakU3a2lySzJwUnM3?=
 =?utf-8?B?SmwyM3BnOXZMc0V0NDd5T2xuT1lBczhRRTRYWEhUb3dsS2NVUlZ2M2d3THNX?=
 =?utf-8?B?T0d4WFRlVWFVdmpXTXA0UVhGellSM21vVkg1RTVYd1lFSnFQQUNSWkJNZVY1?=
 =?utf-8?B?eVlhdXN5dmxxdFBjaFBJaFFIWmxrekN3WWpFUU45TmZpWWRISG11ZHdpTUVq?=
 =?utf-8?B?bzV0RG9zSnkzdkswN2lGa0ExcWs3T3ZzKzVIc1dCNlJZTnJvMzNSVlQ4NFgr?=
 =?utf-8?B?ZnhmRXZRWTFJVzlMbEtSaVFCYUhOVWhWaDhpUlNhb1VEVG1uWHdRa2I4ajlD?=
 =?utf-8?B?VnJ0MXZKbFhxK3RWYjBrbUJqYkMvR2U3MG9GWGVIamdPVzh3N0tPeHJnV2FK?=
 =?utf-8?B?cnpHWkQ0TklJVzViWXNGZWl5Q3htSG1iTi8vTGJWM2NzdU83L3V2ZTNDTC9m?=
 =?utf-8?B?VUZDREZ5S2xKL2lnTlNRUDhEb2JrY1NlVUFWU2tLUnF6dDkzQ3BoKzFENWVR?=
 =?utf-8?B?bi90VHhldG1OMVZBeGpSSkNjRGtJVmsyMHJmSENqb0hMYk82aWFuOFRoTkRD?=
 =?utf-8?B?akhVMGVIZi9sVzNiYUw1Mk5zWXJBcktTSGJ1NURlcVZJUjRIV3BZcXJ6RlVB?=
 =?utf-8?B?bHUrL0xYSDlJbUZaNW1JTFlvcUxYbVRIMXd3enFKb2lYTjFFNFo1ZlA2VTJD?=
 =?utf-8?B?Zk5ua3N0TTRzTlJKMS85Q0VuUVJ6QjZVa2NUbHpvaU10QUEwczMvcVdGWit3?=
 =?utf-8?B?MEtadk9zUnVYa3FTaWdoRm80OFdHdGt5S0d6aWlqRllCMFJOdE0wTGVRc1Z1?=
 =?utf-8?B?MFgwekhBSmJyb2xnWkFzQzVYYWlLZ1E3SnpYYy9ySVMvaER2ZkJSTXlmQytx?=
 =?utf-8?B?Z0h4cnlWN0EyczdZRFpuaDJvSFdNMjhXdTlOSUdIVHUwSWI4V2plVFk4YXhY?=
 =?utf-8?B?SHBNYUJQMzZEWWI0a2czNWFJWklrQ0Uwb05MNTVCNUZTSXRxcVdGNFZzUjR1?=
 =?utf-8?B?ZnBWNEVFektIQmFpaWlkUWkvd09FUWg1Z0pkRjQvQkEzRTh3NEZkcmp3cU1m?=
 =?utf-8?B?VkpoNDFBQ0dpVWxhVGpPMm15Vk1LMWNPTWk2blpQd3NYeVRNYUJnOWRsL0dR?=
 =?utf-8?B?MXUvNU16WllVUm5sMUtuNVk4bkZnaFU0Y2dHREdrZTVqMWo3Mi9YOHNvcjhv?=
 =?utf-8?B?SGFxaEhzOEM5UTUyenpBTG45OHJ2djk4NWxROXJ5Ykh2aWhRek94U283VHBQ?=
 =?utf-8?B?SGo0MUFPVU96aUdRSU1NWVp0aWlmSU84QmI3OEpKNUc4NXRObjFnTVRYZkJx?=
 =?utf-8?B?ekpkaVdaYjFtMXU4VXYyNVR5V3d4L21RazBaRFkvQm5jamJJU2prQ2FrUWVH?=
 =?utf-8?B?MXk0cHdBQzB0MkNEc2xseTkvS290YU9jbVFtaUNlcytCSjV0cGk2dFdsT1Fi?=
 =?utf-8?B?VFRpdmFUSXdXcWlMZE5nMVEzRlpMVEI2SVgzNGxSWmUzSDhIdkMxVTFpeXA2?=
 =?utf-8?Q?PbW9v9YEdtXLXdFYYOUu0Xj0T?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b55231e-4f61-48c0-732a-08de1b842ef4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 09:26:07.2767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkrriN5dAXXvH1r7BzKhUcdhcQnMLeG3snOJDkgIeyT8f2kA2+t0mgNTuVN9Oua1518/ue6UG2sIosTec922cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7394
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

On 04.11.25 07:30, Jan Kiszka wrote:
> On 03.11.25 14:12, Philippe Mathieu-Daudé wrote:
>> Hi Jan,
>>
>> On 17/10/25 14:03, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> As an eMMC block device image may consist of more than just the user
>>> data partition, provide a helper script that can compose the image from
>>> boot partitions, an RPMB partition and the user data image. The script
>>> also does the required size validation and/or rounding.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>   scripts/mkemmc.sh | 218 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 218 insertions(+)
>>>   create mode 100755 scripts/mkemmc.sh
>>>
>>> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
>>> new file mode 100755
>>> index 0000000000..1a2b7a6193
>>> --- /dev/null
>>> +++ b/scripts/mkemmc.sh
>>> @@ -0,0 +1,218 @@
>>> +#!/bin/sh -e
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +#
>>> +# Create eMMC block device image from boot, RPMB and user data images
>>> +#
>>> +# Copyright (c) Siemens, 2025
>>> +#
>>> +# Authors:
>>> +#  Jan Kiszka <jan.kiszka@siemens.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL version 2.
>>> +# See the COPYING file in the top-level directory.
>>> +#
>>> +
>>> +usage() {
>>> +    echo "$0 [OPTIONS] USER_IMG[:SIZE] OUTPUT_IMG"
>>> +    echo ""
>>> +    echo "SIZE must be a power of 2 up to 2G and multiples of 512
>>> byte from there on."
>>> +    echo "If no SIZE is specified, the size of USER_ING will be used
>>> (rounded up)."
>>> +    echo ""
>>> +    echo "Supported options:"
>>> +    echo "  -b BOOT1_IMG[:SIZE]   Add boot partitions. SIZE must be
>>> multiples of 128K. If"
>>> +    echo "                          no SIZE is specified, the size of
>>> BOOT1_IMG will be"
>>> +    echo "                          used (rounded up). BOOT1_IMG will
>>> be stored in boot"
>>> +    echo "                          partition 1, and a boot partition
>>> 2 of the same size"
>>> +    echo "                          will be created as empty (all
>>> zeros) unless -B is"
>>> +    echo "                          specified as well."
>>> +    echo "  -B BOOT2_IMG          Fill boot partition 2 with
>>> BOOT2_IMG. Must be combined"
>>> +    echo "                          with -b which is also defining
>>> the partition size."
>>> +    echo "  -r RPMB_IMG[:SIZE]    Add RPMB partition. SIZE must be
>>> multiples of 128K. If"
>>> +    echo "                          no SIZE is specified, the size of
>>> RPMB_IMG will be"
>>> +    echo "                          used (rounded up)."
>>> +    echo "  -h, --help            This help"
>>> +    echo ""
>>> +    echo "All SIZE parameters support the units K, M, G. If SIZE is
>>> smaller than the"
>>> +    echo "associated image, it will be truncated in the output image."
>>> +    exit "$1"
>>> +}
>>> +
>>> +process_size() {
>>> +    name=$1
>>> +    image_file=$2
>>> +    alignment=$3
>>> +    image_arg=$4
>>> +    if [ "${image_arg#*:}" = "$image_arg"  ]; then
>>> +        if ! size=$(stat -L -c %s "$image_file" 2>/dev/null); then
>>> +            echo "Missing $name image '$image_file'." >&2
>>> +            exit 1
>>> +        fi
>>> +        if [ "$alignment" = 128 ]; then
>>> +            size=$(( (size + 128 * 1024 - 1) & ~(128 * 1024 - 1) ))
>>> +        elif [ $size -gt $((2 * 1024 * 1024 * 1024)) ]; then
>>> +            size=$(( (size + 511) & ~511 ))
>>> +        elif [ $(( size & (size - 1) )) -gt 0 ]; then
>>> +            n=0
>>> +            while [ "$size" -gt 0 ]; do
>>> +                size=$((size >> 1))
>>> +                n=$((n + 1))
>>> +            done
>>> +            size=$((1 << n))
>>> +        fi
>>> +    else
>>> +        value="${image_arg#*:}"
>>> +        if [ "${value%K}" != "$value" ]; then
>>> +            size=${value%K}
>>> +            multiplier=1024
>>> +        elif [ "${value%M}" != "$value" ]; then
>>> +            size=${value%M}
>>> +            multiplier=$((1024 * 1024))
>>> +        elif [ "${value%G}" != "$value" ]; then
>>> +            size=${value%G}
>>> +            multiplier=$((1024 * 1024 * 1024))
>>> +        else
>>> +            size=$value
>>> +            multiplier=1
>>> +        fi
>>> +        if [ "$size" -eq "$size" ] 2>/dev/null; then
>>
>> I don't get this check, should one be "$value"?
>>
> 
> Likely deserves a comment, I had to refresh my own memory as well:
> This checks if $size is a valid integer value. If we just run the
> multiplication below, we won't be able to react properly.
> 
>>> +            size=$((size * multiplier))
>>> +        else
>>> +            echo "Invalid value '$value' specified for $image_file
>>> image size." >&2
>>> +            exit 1
>>> +        fi
>>> +        if [ "$alignment" = 128 ]; then
>>> +            if [ $(( size & (128 * 1024 - 1) )) -ne 0 ]; then
>>> +                echo "The $name image size must be multiples of
>>> 128K." >&2
>>> +                exit 1
>>> +            fi
>>> +        elif [ $size -gt $((2 * 1024 * 1024 * 1024)) ]; then
>>> +            if [ $(( size & 511)) -ne 0 ]; then
>>> +                echo "The $name image size must be multiples of 512
>>> (if >2G)." >&2
>>> +                exit 1
>>> +            fi
>>> +        elif [ $(( size & (size - 1) )) -gt 0 ]; then
>>> +            echo "The $name image size must be power of 2 (up to
>>> 2G)." >&2
>>> +            exit 1
>>> +        fi
>>> +    fi
>>> +    echo $size
>>> +}
>>> +
>>> +check_truncation() {
>>> +    image_file=$1
>>> +    output_size=$2
>>> +    if [ "$image_file" = "/dev/zero" ]; then
>>> +        return
>>> +    fi
>>> +    if ! actual_size=$(stat -L -c %s "$image_file" 2>/dev/null); then
>>> +        echo "Missing image '$image_file'." >&2
>>> +        exit 1
>>> +    fi
>>> +    if [ "$actual_size" -gt "$output_size" ]; then
>>> +        echo "Warning: image '$image_file' will be truncated on output."
>>> +    fi
>>> +}
>>> +
>>> +userimg=
>>> +outimg=
>>> +bootimg1=
>>> +bootimg2=/dev/zero
>>> +bootsz=0
>>> +rpmbimg=
>>> +rpmbsz=0
>>> +
>>> +while [ $# -gt 0 ]; do
>>> +    case "$1" in
>>> +        -b)
>>> +            shift
>>> +            [ $# -ge 1 ] || usage 1
>>> +            bootimg1=${1%%:*}
>>> +            bootsz=$(process_size boot "$bootimg1" 128 "$1")
>>> +            shift
>>> +            ;;
>>> +        -B)
>>> +            shift
>>> +            [ $# -ge 1 ] || usage 1
>>> +            bootimg2=$1
>>> +            shift
>>> +            ;;
>>> +        -r)
>>> +            shift
>>> +            [ $# -ge 1 ] || usage 1
>>> +            rpmbimg=${1%%:*}
>>> +            rpmbsz=$(process_size RPMB "$rpmbimg" 128 "$1")
>>> +            shift
>>> +            ;;
>>> +        -h|--help)
>>> +            usage 0
>>> +            ;;
>>> +        *)
>>> +            if [ -z "$userimg" ]; then
>>> +                userimg=${1%%:*}
>>> +                usersz=$(process_size user "$userimg" U "$1")
>>> +            elif [ -z "$outimg" ]; then
>>> +                outimg=$1
>>> +            else
>>> +                usage 1
>>> +            fi
>>> +            shift
>>> +            ;;
>>> +    esac
>>> +done
>>> +
>>> +[ -n "$outimg" ] || usage 1
>>> +
>>> +if [ "$bootsz" -gt $((32640 * 1024)) ]; then
>>
>> Running on macOS:
>>
>> scripts/mkemmc.sh: line 165: [: : integer expression expected
>> scripts/mkemmc.sh: line 169: [: : integer expression expected
>> scripts/mkemmc.sh: line 179: [: : integer expression expected
>> scripts/mkemmc.sh: line 191: [: : integer expression expected
>> scripts/mkemmc.sh: line 200: [: : integer expression expected
>> scripts/mkemmc.sh: line 202: [: : integer expression expected
>> scripts/mkemmc.sh: line 204: [: : integer expression expected
>>
>> $ sh --version
>> GNU bash, version 3.2.57(1)-release (arm64-apple-darwin24)
>>
>> When using dash:
>>
>> scripts/mkemmc.sh: 165: [: Illegal number:
>> scripts/mkemmc.sh: 169: [: Illegal number:
>> scripts/mkemmc.sh: 179: [: Illegal number:
>> scripts/mkemmc.sh: 191: [: Illegal number:
>> scripts/mkemmc.sh: 200: [: Illegal number:
>> scripts/mkemmc.sh: 202: [: Illegal number:
>> scripts/mkemmc.sh: 204: [: Illegal number:
>>
>> Should we replace s/[/[[/?
> 
> No, that would be invalid outside of bash. There must be a logical error.
> 
> How did you invoke the script? What was the value of bootsz then?
> 

I tried with dash from debian trixie, and there is no issue like yours
visible.

What problem could macOS have here? Will need your help, don't have
anything mac-like around right now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

