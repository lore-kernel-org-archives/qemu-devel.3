Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B5CCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 11:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utPPT-000833-4H; Tue, 02 Sep 2025 07:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utPPR-0007rV-2U; Tue, 02 Sep 2025 07:42:45 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utPPL-0001wO-K0; Tue, 02 Sep 2025 07:42:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqTty8P4bvWGfSyYatIvf6bLvi6pIxWRupRYh/tdaN4BD2QuwZWCN7ehizT0ujra3Sl6HK20DXzKVGYmFjUlyzrZ5MZD6oQpENF9fgoQ71pepgeg+F9pYgdPlL70UOtAePupNikMlFSjDkQ38WY5aKd5TU+cX/cAK3jtGxAA4/qwlUepBhJFLnXTGM00ycXfDz1oOCzuORkn/rry11ZOFqmtwl/P8zd99CaSpjc+tCTXOYxJ9R9UJTj6cX1DjuNOGNtuI7yOZBW8XlrWX4xjknlKGbIOF7SXXs3BzRKsDlXuDVcXwzVjYR2OokihHZYFDkdvp5K1nKLcZ+zfY4513A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAMmwPGBAUriOffuVjxETVTO0Xl+MhaqpkfUhpY9MbU=;
 b=QhstzExJumtpPGaNCvi17plpdQz/R4IiFXJNNpkiStTfYbx4ChVfaVnlPCynbbYbUduQo3Q99tPDuASlsjdCDN0AK8x2lXAqc5VqyvMXXL/NlHZm6WG94mfmIBaPPctCs4E/4ceONtqqVKx5bM1O8Lx6yM1HSSto2jRDPZUEh58UqDGq2PtZhN8HTfmaXmFsscfrw6psAVFXqfb3O49uh8eaZVe/MrtUn+RCAYVbh+r66D1UwgbT5Arh+mMxrb5poVUUVpkASyx1KfLU17NEV/uXkqenHZoQI2i4k6jp6QsfEw11QzcEo7Bmxk+qKXhjjfkQ/fnr2BS7dMRrp0FXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAMmwPGBAUriOffuVjxETVTO0Xl+MhaqpkfUhpY9MbU=;
 b=vLgcdqqAwyX3js68vIF8m1jvN9ISb+5j/OhYar6lvS+z10cTPeR/L6g1cJOzwiMwhcx7uF4sxpAzziFcveia0y/5+EN/Cy3hGl6/+cJBJRMy3+J4BgwDTkXIrRp58ATKPrNJndgE+PRpxt756mEwFWlSg8GAO42XU/CgHJG4WRH1dzkyMDBdANgbwxCDzLrDpRhrgFu5DCCHd/ps0Y+YPethU3ndI93WkDGZhfWFKPopuZWzGdFqozlR9n0pfpH+SaGz+g/5IgW3mLdCY//xSfd1gMe3m5McyQ7H/Zqr9+IQfeVFsqFugTVGid2JszLYA8oJoG5lm3FaSvw5+fBrPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS2PR10MB6445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:558::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 11:42:26 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:42:26 +0000
Message-ID: <75b44826-468a-40e9-a1de-38803059e5ba@siemens.com>
Date: Tue, 2 Sep 2025 13:42:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] sd: Add RPMB emulation to eMMC model
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <a2077894-7f0d-4b73-85d1-8a625f2e0445@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a2077894-7f0d-4b73-85d1-8a625f2e0445@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS2PR10MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b8506b-8562-45ff-1f9f-08ddea15c945
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGRsc0tPaXgxUkUvMCtHeG5FNHVaL0dTRFlhalhiZkJjNHJia3prOFI0dXJa?=
 =?utf-8?B?cTcvVEd5UEVMZ0VaNU1sams2NlN6NUhtM3h4Q3NXbDdRR3JWa0t1L2VheEhh?=
 =?utf-8?B?QTAzRnp1RThwOXdnTGIwVUE5a0tRd04wRmh3V1BjakxzWERWZS9uaGViNFpm?=
 =?utf-8?B?TWwxbG1haTBySXY3Y28yMXVEcXQ3azdZMkU1QldtK2lwQ2ZnYjYzQjRiTjBC?=
 =?utf-8?B?R1VqZDJzZjdVdWxhT3UybmEvaFl6ak5hT3pPb2g1OHIvTVRWT0lPdFhHRXVE?=
 =?utf-8?B?am55LzhkQ25rZG1pbUpDOGV1K3Y4NFpZbllwaDhneStmVjZ6SlFJMlhwVjBE?=
 =?utf-8?B?Y1VoMDNZeVR6WTBZMWlnZkVNRXhlR0pQZVVQOHBMb09SZU14anEvRUxXSGtZ?=
 =?utf-8?B?aHJLVit1WW1FU3hRYWxVTEJ5ZUdvY1gyaG90ZTd4WWFvZGw5L1kyL25kc2Fa?=
 =?utf-8?B?aCtSY0NQQXFEVFNYaEV4dEpCZjlJQm55dG9ENm9xcWYzZXlsVUN1ZkVOZWR5?=
 =?utf-8?B?TVkwZW1BNEhiMno4bDZFYlRxN1k4N1Rud0FmajZGOStQTkZsQU9CaXU0SExo?=
 =?utf-8?B?TWJSQkkyTXpnSzhpOEtrc054b01RelZKdWV4MFY4RFZHbGorbGFHMkJHblNS?=
 =?utf-8?B?RDFGU2ZxK1R2TFhtOFJNMjFtL2FUUW9LZ25EanZiZC80RGZaN0ZRZG9XM0Zu?=
 =?utf-8?B?ckF2Vy9uN3BPU1o3VDYwOEpQVnVNaWlXb0Q1MTNIT3pIUy9VdGFDRzFwOW1u?=
 =?utf-8?B?N3ZTbWY0dFZVUDdQVDNYSXVWMUx1alMzN1orUElrWGw2S2hTVUUxdnZ0NndY?=
 =?utf-8?B?ZFNrdU01ZVNVV1pKNFQrOTJSaFJkY1NPWDRaTHJXZ29sZGdpNzlsZzBhaFRF?=
 =?utf-8?B?NGJIT2pONXAyc0lPUitta3lzbyticDhiYjFLOTB5WXdjZW9HdndRUnhRL0R4?=
 =?utf-8?B?V0NYcUtaaW51cjZIdUpZdzRiT2lpTTVBdm1tdkxyNGVCOUltejcxVmZLdnhl?=
 =?utf-8?B?VlZMSllHeTNrQ0Zlb3Zydk9RL2xFblZpMStKTmduWGRMcEJHcEtkSFVrbUda?=
 =?utf-8?B?R2ltbitRU2Ixc2YyUU1PcVp6YXEwaUtGa2UrMlgwYkVNb0I0Mjg4clBzMm4y?=
 =?utf-8?B?RVNlNjVXVyt3ZHR5aWpRT2ZCMUFLNFowRk5EU1ZLSEV3aGx0cmg1Y2lsWlA2?=
 =?utf-8?B?eFBqRWJ5ZVFDR1V4VCtzSk40SkR6dC9PRldZR1diTWtLYnVNR3ovb2JrWjMx?=
 =?utf-8?B?YjNkVWdqNEZ1c1ZkRmEwUG1RTmwzeXpNYlFudVdMRVZ4V3Z3NERGdWkzZWx3?=
 =?utf-8?B?cGFlQ2pxT0ZBYlFJaVJpNERFeU14NW01NzBPdFBkbHV6ZXRjTk8yTFFkV2s5?=
 =?utf-8?B?cUp4ek9GMzRRTG5SemZBbmRTS25FTHUxbEZUVXh0UXkxbEQvOFNMZ1dQa1F3?=
 =?utf-8?B?azBhM0hyNHRVOEg1dS9CMkNrWlhOMUFVdE1QVG1HWmF1Ry9xYUFqaENBU0pG?=
 =?utf-8?B?bXVwa2JtRE92cXNVT0pUb1BGYTRkZGZKZ3NSNUlrN0pGMVI4OHpJTG5QTS9i?=
 =?utf-8?B?K1B6Zm1YQ3F4R2NpOGFONkNaNUlUOHZKUFNhcFQ5d3ZWbStEdkRyS3owbEU1?=
 =?utf-8?B?MmM2ZEl4NzIyUFJkb3VZOGxxdm9qd1J5T1BYZnYrdlBqZTcwNnJSVEJrRVZJ?=
 =?utf-8?B?aXRuNTR4b0tmcXV5VHN5VmxCcys2eG1CWVRyRVZLK2pBenlWUko1SGNnaEZR?=
 =?utf-8?B?Mm1sbGtmNkFucUxVOURteDNRK3JGZGZrRk9SdUpaVHQyZ1dMTEZOZjJ0c0xP?=
 =?utf-8?B?dm0vNUorL2QrZE5sOERvL1htdXFKL3JWdWRjTXhTK0x1L2pieWVScEh3czdz?=
 =?utf-8?B?VHk1dXhUZUlEQmNsNDRwMHpSb3pvOUFZNXdNS2ttbndERUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0srQXg0SUF3amdJKzBXR0VCTFlPd2V0V1J4Y2ZOUnNPR0lGRlVFRHR5dndL?=
 =?utf-8?B?bXJmZU0zYkJTcTE2SUdDRDduV3VkdmE4bEE5U2pHeFJSOUpHeFJwTTdVL0hr?=
 =?utf-8?B?U1hLN0xJNXMzMThDTnNmYjY0QzQyL3IyVGhFZjJOckpmNktoZmd3UUdzK3hX?=
 =?utf-8?B?Z0dYZGdGOHZUQU1qUFg2K0JyVGRYekFrUE9EQmJzZDdLV3RxTldMOWppK2xP?=
 =?utf-8?B?S0FVYlptL3RxcmhETG5nUWV4MlZrbHg0aHBucEp4eStxTEgvZkkyM0drRExv?=
 =?utf-8?B?TFFtMkZNWHI0U2U0UXVFOGxONStqK056SXFrd01tYUZuRndqdFFDZVUvVDFS?=
 =?utf-8?B?VW5GbVI0ZHU3cWpJMUE3WkV2R0NiZ1RncXhTTkxYcVdKK2txS1hSMFVqSDlM?=
 =?utf-8?B?VjBJYk1DU0ZCQXYxZ0pVTHczR1BrblpwQUR5Z2lFK25rMy9JZW96cmEwSG5z?=
 =?utf-8?B?R3dSekwzZHNwQituNm1qM3JxUVFVVTdpV2dwZXRxVjJ3M0k5S3MrMUJhWmw0?=
 =?utf-8?B?bU94R0h3ZjEvMlhsYThmOXBrTjJKNHZFakpsdlFNNStVYjFTeDlpZk5MQzBk?=
 =?utf-8?B?RytpNENaQ1NWMG81VWJCUldwUzJkc0lsaExmQzlNMm1QZ1hVMk54NGl1cnI2?=
 =?utf-8?B?VDhPSWlGSWx5ck1TOUIrRXAwTktZU3c1cVh6N1F0L2x3ZU9rbjRuMEY2aHdG?=
 =?utf-8?B?TUlFcEViUWs2cFRPRkVrTWNrSWRMZEY0eFRIbms5QmRKc21NYjRFNm1WczF5?=
 =?utf-8?B?dlZLbEtTUXdMTzFzNEZDWUJ2U2FjVFpob2M5bFdVS1hncHExaHVka1VLTm5O?=
 =?utf-8?B?RFRobDlaZjFEN1g5UjBuUi9xQmlKOEhkS3ltQ0RNanlqbE9PdDROVnJ1U1Rt?=
 =?utf-8?B?bS8vM3JjKzFmbzFkWSs4WEY4MDJNaFBuM2F4bkxIbzloNFMwRVQ0VDdEclVT?=
 =?utf-8?B?S1dhQzVtVXZoUXdDQlNlOWhEMy9nbEZtS0RKdGxERmMvazlPZEt1WkdDWnZj?=
 =?utf-8?B?MjQ5SFFCdFBPOExNWHUzbmdmYisra3Y2M3hxbWNpeUgyK1FoUFlNKy9aK2dh?=
 =?utf-8?B?YlJUVFRmbDZvMy9YTjJhUWlYc2Y0c004NVk0R3lIOUpxMXQ2RlY3ajhRVjJZ?=
 =?utf-8?B?ZEdyYjlveWg0RXJ6VENpcDFJUFBzdFZzRzhmNUtzSXFVRlhxTnZ4eUNnTThz?=
 =?utf-8?B?NWlRdFQ4WjRJY2RaajM4REU5YnRzKzFHUlhtbkM4WnkyQVl3SXFRN014TERu?=
 =?utf-8?B?cHVwWkZzbEd5MEtRT1VsL0xxeVJ0TDRadkFoaFNIL2cvMkhKRHR2NU9UZXlJ?=
 =?utf-8?B?eTV5dWpVMjVycys5SzNZQ0tLYnkrL3d0MGEvc2c4K0ZPNktWbGpGUlJuZUVq?=
 =?utf-8?B?YWpBR3E0Y0p5S1VCVk1DckR2WVJQcURvTmtjRi9OMEhYTmQ5Zzc2OVgyOS9U?=
 =?utf-8?B?OGdsY1VxNit2Y0t2cTNnb1BDNlF6WlRsMksyM2F5ZkRCRzBkY3UvRDZNWWhm?=
 =?utf-8?B?NTc0Tkk5dXZnV1dEMDI2OHY3Q2RhaDhVMDcyRWg0Wk1jRXFaRi95azh3enZY?=
 =?utf-8?B?UGNPTlRSLzJmQy85ckZ3ZzV6WTZWL1RJMkpvUXQzd2UrejdxZGdwR0IxNUpQ?=
 =?utf-8?B?YllFU3Q3dzQzb3p6aXdudmFCVGNWQ2ZjblNmQUZ2STc4ZkVyUndId24yM216?=
 =?utf-8?B?WmtNdTBacERxb25vWmcrQi82OU55bXc5SzBJSXM5WGl5N1NPYkJVQktndElM?=
 =?utf-8?B?d1EwSXBPTDJZM04xTDNFZ0ZYNy83ME15ejdNQ29XNHdQb0JEYlhVdUErcDhj?=
 =?utf-8?B?a3RwbHNDaGJ5M00wdmhjNWFxWnNhWWVwTjlKQ3J2Y2JKM0xoVDdNVUtDVWww?=
 =?utf-8?B?TGtZQ21JK0pDUFBJeDltVGZFMXBXTUhiRTRLNis5UW95M1NUWWdIZ1NqWTdO?=
 =?utf-8?B?THNmWUpWRVpqUGU0NmNJWW9NcGR2QXpNMjY0c0pPZ1VUL0xEcityK3Q1YXpn?=
 =?utf-8?B?djdZNU15SjhNdVRFd2hCc0pxdFc1d2IwWDgrRjFpWmJVWC83RkozOStVSGV0?=
 =?utf-8?B?ZzA5T1FYTU44VlZPd29CVUthVFlTMFFFS2ZDaGlGZEdXaFZ5VXArRTFmYTM1?=
 =?utf-8?B?bDUycXZvYXprZW1LRkRaTUpDUXpjcVV4enEweExUT25yYmhyUHg4UENGanhT?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b8506b-8562-45ff-1f9f-08ddea15c945
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:42:25.8071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EOl+8u8tbPjq86T6iObRKW6QmT2O5PnCxSwuTU8ePsZqN763wPSlzZS8lKwVh8czSlPcfFFwMJkx09gvil9qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6445
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

On 01.09.25 22:58, Philippe Mathieu-Daudé wrote:
> Hi Jan,
> 
> On 1/9/25 07:56, Jan Kiszka wrote:
> 
>> Jan Kiszka (8):
>>    hw/sd/sdcard: Fix size check for backing block image
>>    hw/sd/sdcard: Add validation for boot-partition-size
> 
>>    hw/sd/sdcard: Refactor sd_bootpart_offset
> 
>>    crypto/hmac: Allow to build hmac over multiple
>>      qcrypto_gnutls_hmac_bytes[v] calls
> I'm queuing the 4 reviewed preparatory patches to alleviate
> your series (and keep the RPMB patches in my TOREVIEW folder
> -- no objection so far, I just need more testing time).
> 

As Alex had one useful proposal for patch 2 - should I patch that on top
then?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

