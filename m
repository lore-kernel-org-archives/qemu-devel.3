Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B35FCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKQx-0003wN-PS; Tue, 04 Nov 2025 12:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGKPq-0003I3-Hb; Tue, 04 Nov 2025 12:01:59 -0500
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGKPo-00012j-Fq; Tue, 04 Nov 2025 12:01:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRYXLOCef8o9VrZF4AB2gh7bqmY9nV3GXmbDkvyWM5DjjOF8F1fhcpbg3K7R0p5WEwBPBqEoFuIVa94rbFmVOoGC8UABnoJDpad5e91D/PH5xOpDy9XZfP7QzWO5Z6juWRjRHcbxKKwClTWwtfZazitd7PHFRUnzMW++bHvQTVkVJbpwaYWBEC55nLuPY/9m+VWH3Ib4rPXT2PJrVb1qVf2Bcu8X1DbeuP0TC4UXMVZ0PpRzlmJryVhIH8GJeGiNOaHCBXUZG1Bphvc+XLEH206VZWoVL6K2NMgxWDPkHRnQyWZErJIBMO5Z9lGM5qAHnbViR5sUO7GqSWA0xunuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s5Q+38mxHi9p9EsX32OFuI8Vb8ZkB/ACsJDAbAFKNU=;
 b=DjN+9UjtW4/Wbe9nXttNOGK6+S+eXgVNdvzHPqUdKoJgOwjevkDRBrtCBY4SzztkKOzUkTiixhFPzWs26fK3zPlBscjFwUwxIUz0o6rGWwC8mJAxf4Ibj4fPEXd7KomyFsgkRR8yE4BzjWAHJp367c2/wtTnIsTEyUyshrppmxeJGh1SB3sKycGH7jms5XzqGmAej4Mwm8zCdPksDSwyUUf5DeQwjwELPYxyC1essBH9YU7aK2bsuA2HhH0euhFQdMSzukoreKNiy05nXoswM5hNCah6LqtW67ZTQkh3pfCDvafR6mNe91pP8oXKr1MScbnxb/2F3TEXrW06mIinJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s5Q+38mxHi9p9EsX32OFuI8Vb8ZkB/ACsJDAbAFKNU=;
 b=ZnQquzbcqAwRdprXC4TLJkOFjMfbnseAvJduO0tC1AhXpexwkKrklOvSqlT3vQMWi7QH8QbdtsUPNb7/v3fNp2CVibBLVXRpPKloidwaqFQlp8Rs+qDmZY4Qhmwem5agnl8B3Cuv3RdXcUQxtD2g5QvTMwK98H9AEu9igy4Qq2Zyb4zNJ9w0sn7ovR6Fjlu1BqKaxk2y+JYbUdP70ux/ib2Qy69qm42e+LEvQHX6KnRT1uboNmtbv+j3Bn80gvw/LuKpCZjKu7Cxts6umeATt0kKd6iSk9JjjUMp6IMh+Xm+MIBQ2VYID64D7U3qht6cWqpKMbuh2XjsqmoBQUWWlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9499.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:308::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:01:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 17:01:42 +0000
Message-ID: <54352779-fbed-42c4-a5f7-ddf63a1ed0a7@siemens.com>
Date: Tue, 4 Nov 2025 18:01:40 +0100
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
 <48efe021-614f-4c77-8770-bdb7b5e3cfdc@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <48efe021-614f-4c77-8770-bdb7b5e3cfdc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: e40d1b79-ef34-4367-4aae-08de1bc3d3c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sy9Va1pMNWRwM3FKTWVzd0ZIWGdrOXpaYWgrckUzMXFKQlViSUszeC9MOFdE?=
 =?utf-8?B?YkJwalBXWFdkWk9xdU1EbTMyWWNsaGJ3M2lRb1hocGQ2ZEFiSGRSRisrSVdN?=
 =?utf-8?B?TFc5OGppRkhvamhNaEFuKytaM041aHAvSXJxSWU1V0c0NW4zVlRBQWRFOS96?=
 =?utf-8?B?R0lxV3hLcVpxdWpwL0dObFQrMVA4M01kazRJdnBYZ0xqMGI0L0t6bTlyaHNK?=
 =?utf-8?B?WXRBeVplS3p4NERnUmZCbE9Ndm5wU3dvSTBjWGZ4b3JZaFJISUUrSHg5UmpO?=
 =?utf-8?B?N0JRNm5XMU9GdWxJandUSXhQTW1LTXFZQU56c1krcUFabld0WGtlb2x1Sm1v?=
 =?utf-8?B?aXdnbmtkc3pOUVFXTnBVYjNhRGtLdFh3aDFScXFSWXRTbzNqYkd5MndEZ2ZN?=
 =?utf-8?B?RUIwUVpYdndlb0tjYy8vNVZQWGZGK3dBTHczR01hQS9OcGt5ZlA4bVZIc1dt?=
 =?utf-8?B?WER0VlRpWE4zMGhsSFNNekZEYVo3MWJoanI2bmFZSGo2RGJkVTd3bW9LNW02?=
 =?utf-8?B?VWl6bVFpaEd5dlNUY1hZa0ZaRkw4cCtmaDR4T05wWUl6cjdKTTZWWitNUGUr?=
 =?utf-8?B?RFNJYStVRDhMNzlpVjNLVEZFV05PdFFnd3A2c0hGUnQ0eGJ2VkhmVHYrQmU4?=
 =?utf-8?B?TU5nbHp3akRad3dZTjFnNXdzZXV5blE0NXFQSjIyNlRCR3l4SmpCUFM4OUJD?=
 =?utf-8?B?VjFlOU5ld21BMHlnRFlHYjdQd3hDWHlKeUp0OThZaUhVeUU4aDhORW1RY3k5?=
 =?utf-8?B?VmJKWVJDN3FqYVFReW5mNldUWGUrNnpjNFAvMktrK1NoMVc0bytzQ3FTRDBI?=
 =?utf-8?B?T0hUT0t3b241Qi9XbWlGdGt6MlRQVFFKZENkS04vRU4wWW1ma0ZyaTNPYXNk?=
 =?utf-8?B?enZEZzBubUtDcVlXZ2xrT3pWWWFqL1lzOW5ITlZCS1gzR210bnU3enM1U3M1?=
 =?utf-8?B?UU5pY3FYUFl0bGtMZ0M1bzBOUUxQVTBPWDFqK2tFdmRoT0JwTEliVW1pTDgz?=
 =?utf-8?B?bnR4V2FuaDVGV0pudlAyMUlQR0pqSGJHeko1NWR6TTRqaHhQWmxFQlVLK3RZ?=
 =?utf-8?B?WEljQ3NvR1o4V2F3VEVnQnNtenI2bXhuZXVyT0dMbkdjVEl1UUx4cWR2UWE2?=
 =?utf-8?B?YUNKWm1ibzRNempqUjROVzl3b1Y1TW1nNjhKWDRsU2l2VlN0UmFIYnA0NzFG?=
 =?utf-8?B?M3hMM3U3Wkt5NHZtbHVRdjJyVjNxQmVmRW1pb2ZxeUNNZjNtRDhDbFg3Wllq?=
 =?utf-8?B?V1RqU0JtdWRpZTJCOW00dUFzZUIwc2pVbkVCTXg2TGppTUxaN3hoQnFTTysx?=
 =?utf-8?B?RzMzT2RYVkI2WFkxSmJxMnd3eXZvOG81VmlWcUEzMmVqOVE4WSt1MU5Eejhp?=
 =?utf-8?B?L2g1OCt6WktTVkZJT1hHUGc3WHNsZWkyYXdYNmxGVTZyc2tXN1ZTelJOemV2?=
 =?utf-8?B?N05SeEYyeTNjbHVVdVpHaHFSd09PcE5YVGUrZExlUWMvWFpBbzZtZjVBQ3ZI?=
 =?utf-8?B?a2NTcGN4b2QrZk9oMHZjSG1ZL3BJWE5UNGkwY3ZsOWtqWExQbEYxUTlRTlBR?=
 =?utf-8?B?STVndm1MRVRWb0E4WU10Z28zM1NUclBmY21qS2R6ajJFcG5SeFdCYUtLT0tP?=
 =?utf-8?B?M2VVdUhhcDBPcW9rY2U3VUMrbkp4bHdudjR0am9ldWtmOGZqZmRvbnc3eDU2?=
 =?utf-8?B?ZEtwL2F4UWZ2UXpZVTdwRnJVenA1eGxhQjBuWnA4V0VPTVBkTTlDZzBsSXNG?=
 =?utf-8?B?eUVGN3BSc25IWG9aOVZsSkxKTnRpNmF3cldZRS8yVS9HUWpNU0ZySFJaVHFE?=
 =?utf-8?B?dHNZNm5hbjZ5azB6d0UzMlZ4QkN1TyszMTN5dUtjSFB5TVpDVzh1ODUveGVw?=
 =?utf-8?B?V2orWFprL3NEMzBPandnNXpzYlBaNWU2cjIyZERFd1B1S1labmtjbmJVZTJ2?=
 =?utf-8?Q?iXngR5/0qJ68v+QbTnlp3T9ifF7vKXfw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNYeXVWWjN5U0hSTEpwa1NrSGhkQWJJZFJGY2h1T3RrVTk2dHJGQ2xnM0s4?=
 =?utf-8?B?cjVQYWI3MCs5MzhibXlIb1IrUHVFYUlJY3MzUWlaQVJ1RmlXU3cvemZmSW1q?=
 =?utf-8?B?Q0hXVHZyR2RZdlR2Yi9lT2UxU09WdkJHWEVKb1RoL3NjUUpqdVR5NTczN3Rm?=
 =?utf-8?B?SzRIbThCampvbVg3SFExdjBma0FFekNlSmFpWVRVTXU3VkJrZzZKK1JKUjZQ?=
 =?utf-8?B?UC9jME4zbWxMQVlZVzlFQ05ZOWYzUzZzU1Q0SHJyL0w3Mmd3OW13UGpLdnlK?=
 =?utf-8?B?cjFKUW9hSjVack1DKzE1Qko1UVBxeHIyV0tHRmxwUndyWWNyZzZ5anplZGdq?=
 =?utf-8?B?YXl4dThYeHV6UER5WFduenRIVlBuYnE3QUh6VWJWazI3VUNrN1pYMzlGMlNm?=
 =?utf-8?B?ais2RTJUWFBRak44R1p4aXRQQUF3bDFJWndmdWQzV3FOQnlXcVVyRFc5RGp3?=
 =?utf-8?B?Z1AvbHlkUDRuQmlpZktQODV0bjVTeXVsS2FldlpiTWJTS3N3djFUTVNwRTFF?=
 =?utf-8?B?d2F0VnJ6UlZ4dGVmcVA3Mk1SMDRpbXJiZ3lRREJ4VTF4cTFPd1JOSmdzRGlJ?=
 =?utf-8?B?RkZ5S2F6TkV1V2paZjhYYjlqY2RjTU91Q2VHdEZHYlBTQ3NmSDZxejRoYVdY?=
 =?utf-8?B?SnNId05ud00zK09CVjZXN1hCL1hJTTMxc3hNK0Vyb3RtT0pCRGllZnVyTTZ5?=
 =?utf-8?B?bVBQSWlLYUF5TmRRWlhNWlZsNURvTFI5d1pEc1dJNU0wc1JsUGxRWiszZkhw?=
 =?utf-8?B?RG1ybUkwWXpTQ2pWeXJ0ZzcwMkQ2TE5WZXdEK084ZURCMDBzNDMzZVUxQmxj?=
 =?utf-8?B?NWlkOWNxdmRzZ3h4Ymg0NTJaWnIzMSs4Mk1sOG45aUM2NDczWWU5YWlyanN0?=
 =?utf-8?B?L3JWamg4enZ6ZXdZTFJnQVJSWEhtYk9iM0tMVVVxTEtsSkNSdFF1NkxCN2hB?=
 =?utf-8?B?a2hKMlQ2TGtxcHJKc25sOXlLcTd4cWlCNGE3OUNvd1drN2R3RXVlRWVuZGk5?=
 =?utf-8?B?Y2lKWS9jZUFmRFk5RWY3ZnNYc2RtUTh1SDZUSmdTVUsxOFpGYXYzNVFqRTRI?=
 =?utf-8?B?UkVIU2cvTGxEeU1iVGkzMklUUEN3TlNDTitTT0RZNmdHSmQxc2F0ZzZVb2JS?=
 =?utf-8?B?RGVoeWR6eElhNUI2MmczS2tFejZmcmIrQ053U3hTVndHdFdsQkF3WVlkK0R3?=
 =?utf-8?B?VjU5MVdZcHpURnVLY2s3TXBJNlRmbUVxUUMwRmcrWVJ5azdJT01rNWljN0lB?=
 =?utf-8?B?VmpyV2MzMkU3WURQaW5BRk5kcUdIMWZsNUNsRmY4OE15RlBpcnA1ZVNoM2E5?=
 =?utf-8?B?UDVPTDB0NlJxSVFzdFAzVStsT1BYQzhPN2JLSnFaL1QrYmJpYVplRmdyZ2E2?=
 =?utf-8?B?L09NN0swMmlDUDVhTUxjbzVyNGhPUm1ESnowb0Vya1dRYVFqQkd3RktPZDdX?=
 =?utf-8?B?bmJSZDk3bjBWWHhsVURXaGIrQTU5QzF4WU1SeVhGYmZsUWhxVnJaS0dmdERL?=
 =?utf-8?B?bU5yV2JEbklMYW1sNXkybWRzbmlwZVFVdkE2SjkrVXBCWnh0aFZMcGIwTmRG?=
 =?utf-8?B?eHV6bE9jbHhuYWQ0TFpSSlA0ZTR0U0JmN1FmNlJjeE5JQmc0MEdqUXl6NGRv?=
 =?utf-8?B?TnhtS1EvWkZUaE1rdllFYmRNRUdYTEQ5NUVHL1o4VnpWYjhzYndpS1B5NlUz?=
 =?utf-8?B?RldwV1BKZzZNcnd4OGNUTzJzWCtVQjU4ODZXSHRaNmZibnRqNDcwRUplRnBl?=
 =?utf-8?B?MTEwUlY5MmhjOU9mTFJjTUxKRDhLUHB6K0VSNy9XMmt0Q3hYcnRlNmZMSU1n?=
 =?utf-8?B?MEh3aHNEUTMwZFNBcGxPZkxkVk15clZQM2h2K2FXYzFTa0JmT1NJTnZkcE1D?=
 =?utf-8?B?d2N5aGRVL09USlJwR3dGRXR5MnBwa1V4VVR1Yjl2c0UwYnJKZFpBMFR4Vk1O?=
 =?utf-8?B?U2hsOStUU1kvNmlsQVVnWXNic2d4TDBhYWNsOGVRT1BsUENVemtzdUU5eE1E?=
 =?utf-8?B?Z3M1VFB6NGdRUlJmTzBybWkvUGdDNXdxOEdHNWhTMEdJLzJLdUdkUmJyNDcv?=
 =?utf-8?B?ZmZ6WVUvT3ViekJjdnFCQXJoL0pVZXpjNVNIZUpaZzBBbzFRRkpHcVVaTFJR?=
 =?utf-8?B?MEpwaTBZWmxjTTVIOXlCcW5IRE8zMkt4dHI3TVppbkkrUGxXVmMzN2tFMkNV?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40d1b79-ef34-4367-4aae-08de1bc3d3c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:01:41.9692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fhQdDZANiADGbcQAiTQlT8NH5TGYzDEYcMKujP0Xd2Dm5pIh8Sonz6OVEJ2eKYrnKrwS6fyvgFgQ+d1VEd3Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9499
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 04.11.25 17:55, Philippe Mathieu-Daudé wrote:
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
>>
>> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
>> new file mode 100755
>> index 0000000000..45dc3f08fa
>> --- /dev/null
>> +++ b/scripts/mkemmc.sh
>> @@ -0,0 +1,219 @@
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
> 
> Failing CI with:
> 
> ERROR: New file 'scripts/mkemmc.sh' must not have license boilerplate
> header text, only the SPDX-License-Identifier, unless this file was
> copied from existing code already having such text.
> 
> Do you mind if I drop these 2 lines?

No problem, drop them - old header template.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

