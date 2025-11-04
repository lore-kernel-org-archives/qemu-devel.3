Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8455CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCFi-0007AG-GD; Tue, 04 Nov 2025 03:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGCFh-0007A3-6s; Tue, 04 Nov 2025 03:18:53 -0500
Received: from mail-northeuropeazon11010057.outbound.protection.outlook.com
 ([52.101.84.57] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGCFV-00007Z-72; Tue, 04 Nov 2025 03:18:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBrIQYO5NNz9T9UKvzZ8D22+dISMkzfcfGT1nu/PEWbSMXATGVvQQ5KovEUfnRZXMCB9AGobHKuFYPXGd0gkeaXEA4B98pDVkIC2pxQ0rmSxf+Ty5xmnlfz/ZqlgApIdfT8I3XRO7C9/0crPbfQ4kmNqBF5dpJ0zwvvEipKyqnEvRNraEx23ui15pCTRkLmJnpLcr75jekGx4evlX+9OYkGznuDKdiXznvmeokp6XfZnBpb738uy5Bz/jcBnma+cOML3SbFR+SMn3uGKoE5fvCfyHDk0Lg0M9q9kyeTgHh1bzp4RcTADLYtAGIE9/g+K16jaIBpav1jWHhMdhRFF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Qk4i6IqPj69Jjnt9BAHAAZPKCl/IR//ofugLVpoLew=;
 b=HIxP7oEyaEiTJfbebTnYZWtAp01nAMKyd7//2J3w/BzJpwOA346622A7YI+bp90YnTQ9NvgZigq+9lIeJubqQUWGmBXta2JT35n4yorZCch0w07FE1T4Mx3VT/XtrWq01/AAEse5tZZw+X8sXLVi+gQ5x8ShJLv1/hPnH561ekmXlCohU1FdRTl5A9QytvhOlZb0UsTsPXTYtE2Qnk/zzx26rMvTqT9xqgOLpmhX6LoSCQfKNrhGiZgphnugpGzokrF9Tc321vUlb3bgo+PPkScZyB5VGIupjnpt8bf7Hrsw+iiuOx0LUHtul1/WKxCys6awa9NkmFqh2Jnlmz9T9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qk4i6IqPj69Jjnt9BAHAAZPKCl/IR//ofugLVpoLew=;
 b=zslzJc0miOjo5PDqkqLV35Qq9kg4nysyqD5ynzFTkXqXSTBI1p49CR+sq+V92SilErqux7PswOJ5jaIg0sXsOEM1Hu9wMLBMgtOGw+fQ1xafq2lDNUBNSxBPtVV+UpOgl1kQ6RLU2JwbYA+zVyOXJkeT7CLxLBZCT6ODxc+IhgsWG2DAno+mVpGfJ2b/ABh+VjrgXtd6ua3RF7d2R8Pv6URZ37UL/bO/p2gUpvdi77afZmZ9ibKRgVroZdyg+mpn0JYSva+TmxQ8yH6ExdjxqNov6suZYJdFENnnzMjjTcpZ8SVm2HCv21XdFsReNBnf9fI/sn9m4a4g5JIqWPwpQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 06:30:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 06:30:29 +0000
Message-ID: <08287450-4889-4329-b21c-87fde274b13f@siemens.com>
Date: Tue, 4 Nov 2025 07:30:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] scripts: Add helper script to generate eMMC block
 device images
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
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bfd49f9a-0a37-4e1d-b7e2-f0e59943915e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bc1139-f567-4c5a-dcfd-08de1b6ba61f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXJ4TmlLTjZhbnFXeVloVzJ2MDluU3NtYnE5TzBVWlh4ZHEzL2wvRHhKWnBY?=
 =?utf-8?B?MlpBR1RtdmlWcnExbDRnSmt1S3FodWkyZ3pzTm5lZmxoUCs0YUU2QitJVFAr?=
 =?utf-8?B?algzbTBYRFp1bzlFY3hFVC95V2lXeW41RnhqN1A1SUlEYzBKMVhPSlk0Q3Iz?=
 =?utf-8?B?cUUycStONm5WU3Z3VXhFdFNFVExaYWE2eXdzMmdMdjV3NmhzbmFhWUJXRHMv?=
 =?utf-8?B?NXFuY1VWYTVzUno0ZTE0bHFhSEs1ZmxmUjJYYVF0Q1N0eXhRZ3Y3QTZIaDds?=
 =?utf-8?B?UzVhOWpMMkN4dW1HNENVdHpUSXJxVmZjVG1QN2wyb1lJRzZTakIwaHhEcUQx?=
 =?utf-8?B?aVQ4TWpwbEYvS0xYU1FaWVBNcmN3QjNNNUdYR0toOEgyOUV4NzB2eEVQSEN5?=
 =?utf-8?B?MUl6dzRjdEZjS1lnT2Z6VzV4TlYvclVoV2FhOGdVY3V6ZFVtd2U3TUd6bjNh?=
 =?utf-8?B?TFRDd3JTYkJoUS81QkFOVlg4Tk5IRzBaYVgyd1JmOXBQOGpEUmRYSG5PdmUw?=
 =?utf-8?B?TGZGaWNHaHJCaGxOT3EvbHZiYzd1Q2w4ZUlMcFNrSlBEVzdTeHJHRVhRRlVo?=
 =?utf-8?B?MXFlcm9SZlQyVVJ6UXlQNGh5R1lUQ3p1RnJHdVVvaGxYZ0NLWVpPUXRsZFpS?=
 =?utf-8?B?Mi9BRkNBMTNpR2tkV0E5c0hLa1k3Mzg3YTZHMEVRTlhvYU5KUjcwTDJScWRO?=
 =?utf-8?B?SFFlVzhBKzNMVU1hNHJsTHNhZFVOQ0dZZkxoVFpSS2o3eTE1ZDB0b1p6bWFX?=
 =?utf-8?B?NUxYS1VKbXcxVXFkUG82VlVvWU5oYlZTRzczc0hZZUpCWElVMlJNd1Nrc2xW?=
 =?utf-8?B?b2Z5WSs5a20vcG1TWXplbnhTSUEzNjY0UjlkdFM2ZTErSEZXWnc5NFE0TG5S?=
 =?utf-8?B?VTYwelJmNWE4RndLb29vOE14MG8zZWRvZFdMVjhKM251Qlk2L2NOSlBMdklk?=
 =?utf-8?B?eHRENDgwMXltSWZsYzR0Zk0rSnQrZk9PNzBtaFloVFpnNkpRMmlubm1FMlBD?=
 =?utf-8?B?UStMZTVSL0pxNEhWYllwV2htS1VZRktpMmtXQ1YybG9vT0N4REg4U1U0U2or?=
 =?utf-8?B?N0Z6cStaa3hScCt2MlUvZHUwL0YrNHhrMFhBVjdaNCtQSEpaTFVCaXpNZzlp?=
 =?utf-8?B?Q3FKR1JXUDVRSGFIMFNVWVZ5bEZwT2dWMVJUcjNVandGOWNLR2MySTRpUnh1?=
 =?utf-8?B?UlFQd0wrNStWM01uazF3T2NKMWhxeVNGaDlhVGdKcFlEZ0d4M2xucUNCSHJC?=
 =?utf-8?B?SVhmL055aGVpRWE1VVA0ZVJzR1JwR0pnMTdBY083cHFEVkFJWVZjcUtGNVhl?=
 =?utf-8?B?eXZWdU5yRS9NRGh6VjRsbXpHalozRGY2WlFuSFZIb3puMXJPQjVZQlZxTVdG?=
 =?utf-8?B?ZzhZS3ltQTBveE1SS0dZVmtTTlZuc3BXejlCK2xvMkNSVWRnaWQyWkc0YXp3?=
 =?utf-8?B?ak5heE81K1JJemhVT2dIRzRyV0g1RHFpbFhvVGZ0STdyWExnbDY4Zm5YNjA3?=
 =?utf-8?B?S1c2TkdHMUZXRzFia0RIckY2TWVIdFJVT09jbXN1cnRSQmF5djN0dGdZbEJi?=
 =?utf-8?B?N2MrMG8zdFRIR3dydnNUaFFNeHVUZG03WTAwZTVYRGZJYTBwRkY1TTdHNXZ1?=
 =?utf-8?B?djUyMUhWMXpzMzVwK2NvOXJ3Y2Jhb1BXVHgvT2lkR2E4MkhzZGltVS9NamRx?=
 =?utf-8?B?Y2hFQnFkMzh1aTV6Q3JYNFplK0tQWW1ZRjY1cWkya3BEUjZ1V081dzFFZWph?=
 =?utf-8?B?aVdJSzZTOUFuTUJsRG9Kb3Q2cnJXZnVyV3EvZGo1d0s0b05YTUdiMWR4MnVO?=
 =?utf-8?B?TjZWSHhrU0ZZVVhVeW5sZFR6UDg1TmV0RVVHSnU2V3pGRlVKTk9MVWpoV0FS?=
 =?utf-8?B?ZGltKzFSNEU1MFg5TnR0S0tFNVBuZExWWlpJbEt2NjBPajdNOVc5NTlFOXlE?=
 =?utf-8?Q?QVwv8k6nj9MNWdmRCHo+lkZrgQ7ngLwg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjRNQ29ZMmlvQkxqNkE1MnYrRG41bHFzbW1IWUdkUU5KaHVUaUVpK2xLejI5?=
 =?utf-8?B?V0c0QmtDR1RyejVWSXB4U3E1c0JnNlBWU1l3UG1yenhiY0hYbGRZRUcyeS9Q?=
 =?utf-8?B?VUpGWTAvSVhadllSQlRyT29lTGRpQWQvajl6NUZkSFdIQmNBQ3NLREMrS0U4?=
 =?utf-8?B?VTZZS29mVTVWamxGUEdFUFpPenhYNTdWVVBmcGsrSWlMV25Ub3pFY2t0dEFa?=
 =?utf-8?B?TEwxNXpoZ1dVUlRQUG9oaE1mMkp6R2thMExZYjF6elFxTm1zNDVkMFp2ZzZp?=
 =?utf-8?B?cC85bmtmT3JHUlhtUUJucjlOV0h3WXJ2ZzB5OXNaYmgxUTAyRlFpV2FqTnNV?=
 =?utf-8?B?RTNtQmgzSW9iRVhPT21Ja0xXQTE5cVJsZVo5bGRvLzdFTTNzTk5XYzZHYXZ1?=
 =?utf-8?B?eTZlaGpEdGI0bUsxZzMxTTJWZGR6VFB1N0JxRm9CT3Y3WlJwRVY0OUlIaHYr?=
 =?utf-8?B?T3dWMkliS2sySnVlRE9LN3hNenlJOFVVMnhtaFFOSENmTjdYRmxnT0JFNzFS?=
 =?utf-8?B?Vm84MEozMHczSlAwMXJmYXMxakpSRGtjdW8wQjJ5bC9PREdMdHJTR3hEWXFs?=
 =?utf-8?B?YnQ0KzVab3lJOXRONktkcy83d1JRMVFMeUpBQzVHdCtmS21nMGQzQ1BrZU1C?=
 =?utf-8?B?djljVFpXYk1JbGViMmNEOEpmbFc3SnBmM3dSM0dTZ3lrUEF5VWM0Q3o0UUky?=
 =?utf-8?B?eUd4amMzbktyVit6NFFoLzh1cGlzMDVQWnpwL0ZuY0ZibU1vNzJxR2hTUlJX?=
 =?utf-8?B?V3BWVnRlMUt3cmJqZTV2dUIySkNjQ0IrWFJiSVkvRDErZEE5cjhEc3FaT085?=
 =?utf-8?B?eEQ3WFZneGdJWnV1SUV2OW5YclFDVTZjRS9PUDc1Z1J0MzNmNVAzaGw3NnRl?=
 =?utf-8?B?TlNXV0hMcW1hK2VSdzE0WjFIMFQ5eWpiOVllYnZCdkh6MTE1TEhPNkZocjB2?=
 =?utf-8?B?dXF3dDVuenRpeW9ldEg1Ukd3SEVYSU4xN2lUdTFpSmNvSmFOazB5QTRINFVI?=
 =?utf-8?B?amkxcktEVUJYaEUvM3RiSExBZXlRUTFhTmo1eTZnZWVidkg5WDJHeDBkaW8x?=
 =?utf-8?B?SUFBNHEyN2RSSXQyMUtqNGNJUVl5c3JWdHVhdDd6and0YUZ1Nmt4OC82Wml6?=
 =?utf-8?B?NzRYWEQwWmFYbkNqNVBCQ1hMQ0RNNlJSQnNEamlEM0FGMVpWVStMMzFXUlF1?=
 =?utf-8?B?WW1OUjZzbHdCbXR3UjllLy9zQTFYOHN2ZHUzS29keHErZ0FMVldRcGpZTHFm?=
 =?utf-8?B?U0U0WnVvc1VmTVdDWU01SEdOZE5TVFhTR3FxWEsxVGFPQ21TQldGMW1mWVBj?=
 =?utf-8?B?UzVDYlVKQ0I0bzViNi9tQ0VTSk43UlhjZmd3bzYxaW5DaWdHMVNSSU9kWDZ3?=
 =?utf-8?B?U1lMdjNVaGd5R2NqQ0dyeEJCbmk4UU1HL1BuTWk4OVZCWWhuTGJzcWR6YTh3?=
 =?utf-8?B?N0txbVRLdjEzNldPUDM4LzBFb0o5eEhIMlRJNXl6UkhQcnNxMElxMnlySGlR?=
 =?utf-8?B?ekJpeVFhaXhQV0N1ZVdWQXV0MWF0QXEySXVUNjFpYnVFdnVlQ3ByQSswWHdj?=
 =?utf-8?B?TDRSTEJkNmNTd2Fqc2ErMzRib3Awci9lYmlIdWNsWFFGc2E3QWhteER5bzg3?=
 =?utf-8?B?R3VLZFZtelV6NkdXd3gzUFg0RzhNSXNZeFpKSlU5UWJwTForUFp4K004VENL?=
 =?utf-8?B?Yjh1MUw0VDlSbjhWdWJLQmNXTFcwbkxXWFlHR1VBVmFBOG1ueERQU05aQ2tv?=
 =?utf-8?B?ZGY5QjcvSi9YbmxuUlpVZkkwV01EdjZTZTA5N3FaY0lpTzZwL1RwUnVpMzBT?=
 =?utf-8?B?bDY5Y3BXK3pOaE9uVnBsaW5oTGl6YmhMbUk4RmtjRHJSMStLRGdXWHFQT3dQ?=
 =?utf-8?B?ZG5IUGhNZkdkY20yN0pia1hCODcxbUwyU2JETDhrWllEeHEzU0ZyRTNIOUF5?=
 =?utf-8?B?cUswWkxsU09kc2ZIV2crcGtOL00wMWlXRmFKdkdwR29Tckx0UDV3TGdBNjkr?=
 =?utf-8?B?ZG5ibC80U3ZjV2VjYkovU201RDE0VUpxMkZVeW9wQmtHTi9zQVhYckIydDRo?=
 =?utf-8?B?WHJFYjQ3eWszKzRGL0VMNEcvRlJ5ZWhadlZ0Uzc0Wjhxdld1eUh3VkY3S1la?=
 =?utf-8?Q?WbnNVGjq6j+82ahpAce3+lcKR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bc1139-f567-4c5a-dcfd-08de1b6ba61f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:30:29.8133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzLhw8/i8w9lZ8hKPbwq6OXwkx9qURGT+i7wH7s1/H9zPrYbS2/6y5qFRG4yTDD9cVYeWe/EAm47rqs6tc5FWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9249
Received-SPF: pass client-ip=52.101.84.57; envelope-from=jan.kiszka@siemens.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 03.11.25 14:12, Philippe Mathieu-Daudé wrote:
> Hi Jan,
> 
> On 17/10/25 14:03, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> As an eMMC block device image may consist of more than just the user
>> data partition, provide a helper script that can compose the image from
>> boot partitions, an RPMB partition and the user data image. The script
>> also does the required size validation and/or rounding.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   scripts/mkemmc.sh | 218 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 218 insertions(+)
>>   create mode 100755 scripts/mkemmc.sh
>>
>> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
>> new file mode 100755
>> index 0000000000..1a2b7a6193
>> --- /dev/null
>> +++ b/scripts/mkemmc.sh
>> @@ -0,0 +1,218 @@
>> +#!/bin/sh -e
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Create eMMC block device image from boot, RPMB and user data images
>> +#
>> +# Copyright (c) Siemens, 2025
>> +#
>> +# Authors:
>> +#  Jan Kiszka <jan.kiszka@siemens.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL version 2.
>> +# See the COPYING file in the top-level directory.
>> +#
>> +
>> +usage() {
>> +    echo "$0 [OPTIONS] USER_IMG[:SIZE] OUTPUT_IMG"
>> +    echo ""
>> +    echo "SIZE must be a power of 2 up to 2G and multiples of 512
>> byte from there on."
>> +    echo "If no SIZE is specified, the size of USER_ING will be used
>> (rounded up)."
>> +    echo ""
>> +    echo "Supported options:"
>> +    echo "  -b BOOT1_IMG[:SIZE]   Add boot partitions. SIZE must be
>> multiples of 128K. If"
>> +    echo "                          no SIZE is specified, the size of
>> BOOT1_IMG will be"
>> +    echo "                          used (rounded up). BOOT1_IMG will
>> be stored in boot"
>> +    echo "                          partition 1, and a boot partition
>> 2 of the same size"
>> +    echo "                          will be created as empty (all
>> zeros) unless -B is"
>> +    echo "                          specified as well."
>> +    echo "  -B BOOT2_IMG          Fill boot partition 2 with
>> BOOT2_IMG. Must be combined"
>> +    echo "                          with -b which is also defining
>> the partition size."
>> +    echo "  -r RPMB_IMG[:SIZE]    Add RPMB partition. SIZE must be
>> multiples of 128K. If"
>> +    echo "                          no SIZE is specified, the size of
>> RPMB_IMG will be"
>> +    echo "                          used (rounded up)."
>> +    echo "  -h, --help            This help"
>> +    echo ""
>> +    echo "All SIZE parameters support the units K, M, G. If SIZE is
>> smaller than the"
>> +    echo "associated image, it will be truncated in the output image."
>> +    exit "$1"
>> +}
>> +
>> +process_size() {
>> +    name=$1
>> +    image_file=$2
>> +    alignment=$3
>> +    image_arg=$4
>> +    if [ "${image_arg#*:}" = "$image_arg"  ]; then
>> +        if ! size=$(stat -L -c %s "$image_file" 2>/dev/null); then
>> +            echo "Missing $name image '$image_file'." >&2
>> +            exit 1
>> +        fi
>> +        if [ "$alignment" = 128 ]; then
>> +            size=$(( (size + 128 * 1024 - 1) & ~(128 * 1024 - 1) ))
>> +        elif [ $size -gt $((2 * 1024 * 1024 * 1024)) ]; then
>> +            size=$(( (size + 511) & ~511 ))
>> +        elif [ $(( size & (size - 1) )) -gt 0 ]; then
>> +            n=0
>> +            while [ "$size" -gt 0 ]; do
>> +                size=$((size >> 1))
>> +                n=$((n + 1))
>> +            done
>> +            size=$((1 << n))
>> +        fi
>> +    else
>> +        value="${image_arg#*:}"
>> +        if [ "${value%K}" != "$value" ]; then
>> +            size=${value%K}
>> +            multiplier=1024
>> +        elif [ "${value%M}" != "$value" ]; then
>> +            size=${value%M}
>> +            multiplier=$((1024 * 1024))
>> +        elif [ "${value%G}" != "$value" ]; then
>> +            size=${value%G}
>> +            multiplier=$((1024 * 1024 * 1024))
>> +        else
>> +            size=$value
>> +            multiplier=1
>> +        fi
>> +        if [ "$size" -eq "$size" ] 2>/dev/null; then
> 
> I don't get this check, should one be "$value"?
> 

Likely deserves a comment, I had to refresh my own memory as well:
This checks if $size is a valid integer value. If we just run the
multiplication below, we won't be able to react properly.

>> +            size=$((size * multiplier))
>> +        else
>> +            echo "Invalid value '$value' specified for $image_file
>> image size." >&2
>> +            exit 1
>> +        fi
>> +        if [ "$alignment" = 128 ]; then
>> +            if [ $(( size & (128 * 1024 - 1) )) -ne 0 ]; then
>> +                echo "The $name image size must be multiples of
>> 128K." >&2
>> +                exit 1
>> +            fi
>> +        elif [ $size -gt $((2 * 1024 * 1024 * 1024)) ]; then
>> +            if [ $(( size & 511)) -ne 0 ]; then
>> +                echo "The $name image size must be multiples of 512
>> (if >2G)." >&2
>> +                exit 1
>> +            fi
>> +        elif [ $(( size & (size - 1) )) -gt 0 ]; then
>> +            echo "The $name image size must be power of 2 (up to
>> 2G)." >&2
>> +            exit 1
>> +        fi
>> +    fi
>> +    echo $size
>> +}
>> +
>> +check_truncation() {
>> +    image_file=$1
>> +    output_size=$2
>> +    if [ "$image_file" = "/dev/zero" ]; then
>> +        return
>> +    fi
>> +    if ! actual_size=$(stat -L -c %s "$image_file" 2>/dev/null); then
>> +        echo "Missing image '$image_file'." >&2
>> +        exit 1
>> +    fi
>> +    if [ "$actual_size" -gt "$output_size" ]; then
>> +        echo "Warning: image '$image_file' will be truncated on output."
>> +    fi
>> +}
>> +
>> +userimg=
>> +outimg=
>> +bootimg1=
>> +bootimg2=/dev/zero
>> +bootsz=0
>> +rpmbimg=
>> +rpmbsz=0
>> +
>> +while [ $# -gt 0 ]; do
>> +    case "$1" in
>> +        -b)
>> +            shift
>> +            [ $# -ge 1 ] || usage 1
>> +            bootimg1=${1%%:*}
>> +            bootsz=$(process_size boot "$bootimg1" 128 "$1")
>> +            shift
>> +            ;;
>> +        -B)
>> +            shift
>> +            [ $# -ge 1 ] || usage 1
>> +            bootimg2=$1
>> +            shift
>> +            ;;
>> +        -r)
>> +            shift
>> +            [ $# -ge 1 ] || usage 1
>> +            rpmbimg=${1%%:*}
>> +            rpmbsz=$(process_size RPMB "$rpmbimg" 128 "$1")
>> +            shift
>> +            ;;
>> +        -h|--help)
>> +            usage 0
>> +            ;;
>> +        *)
>> +            if [ -z "$userimg" ]; then
>> +                userimg=${1%%:*}
>> +                usersz=$(process_size user "$userimg" U "$1")
>> +            elif [ -z "$outimg" ]; then
>> +                outimg=$1
>> +            else
>> +                usage 1
>> +            fi
>> +            shift
>> +            ;;
>> +    esac
>> +done
>> +
>> +[ -n "$outimg" ] || usage 1
>> +
>> +if [ "$bootsz" -gt $((32640 * 1024)) ]; then
> 
> Running on macOS:
> 
> scripts/mkemmc.sh: line 165: [: : integer expression expected
> scripts/mkemmc.sh: line 169: [: : integer expression expected
> scripts/mkemmc.sh: line 179: [: : integer expression expected
> scripts/mkemmc.sh: line 191: [: : integer expression expected
> scripts/mkemmc.sh: line 200: [: : integer expression expected
> scripts/mkemmc.sh: line 202: [: : integer expression expected
> scripts/mkemmc.sh: line 204: [: : integer expression expected
> 
> $ sh --version
> GNU bash, version 3.2.57(1)-release (arm64-apple-darwin24)
> 
> When using dash:
> 
> scripts/mkemmc.sh: 165: [: Illegal number:
> scripts/mkemmc.sh: 169: [: Illegal number:
> scripts/mkemmc.sh: 179: [: Illegal number:
> scripts/mkemmc.sh: 191: [: Illegal number:
> scripts/mkemmc.sh: 200: [: Illegal number:
> scripts/mkemmc.sh: 202: [: Illegal number:
> scripts/mkemmc.sh: 204: [: Illegal number:
> 
> Should we replace s/[/[[/?

No, that would be invalid outside of bash. There must be a logical error.

How did you invoke the script? What was the value of bootsz then?

> 
>> +    echo "Boot image size is larger than 32640K." >&2
>> +    exit 1
>> +fi
>> +if [ "$rpmbsz" -gt $((16384 * 1024)) ]; then
>> +    echo "RPMB image size is larger than 16384K." >&2
>> +    exit 1
>> +fi
>> +
>> +echo "Creating eMMC image"
>> +
>> +truncate "$outimg" -s 0
> I'd replace here by:
>    truncate -s 0 "$outimg"
> 
> to avoid on macOS:
> 
> usage: truncate [-c] -s [+|-|%|/]size[K|k|M|m|G|g|T|t] file ...
>        truncate [-c] -r rfile file ...
> 

Will do.

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
>> +truncate "$outimg" -s $pos
> 
> truncate -s $pos "$outimg"
> 
>> +
>> +echo ""
>> +echo "Instantiate by appending to the qemu command line:"
>> +echo "  -drive file=$outimg,if=none,format=raw,id=emmc-img"
>> +echo "  -device emmc,boot-partition-size=$bootsz,rpmb-partition-
>> size=$rpmbsz,drive=emmc-img"
> 

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

