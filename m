Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF519CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLCx-0008Ue-JR; Tue, 04 Nov 2025 12:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGLCQ-0008Oi-4s; Tue, 04 Nov 2025 12:52:13 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGLCN-0006Vv-Td; Tue, 04 Nov 2025 12:52:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDFRCMqe9NkNw+WCoJV0af/ONNAt19IJq0tz85yZz+nDcDAPjUXEE+GxGd9R+UVMc9Tg3ljhfuu+Eqe+cnxMu/NFj8iffxLyW0YtOEyHQlax3c7GnTpmHLU/xh0c9/gceYlDaeu3qiVnKkeQSwp6mVRwAncGqkIdI7URIX3mhS9KGt/QkhlLh4kHNrjCq+tZYps5i7L0xAZqRUNt93W8SgXznirWBM0h966ulWLW9PpmLw9qvD6QDLk+naXAdvVSRjxglU9j7VY7WO9vmuVbce85XeNfI8Efz2Jn0+I1abu6Z0dvyaI3/QF9ezJQsV4HfcCAPLqakOaYtS9N1KW/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEvb2P3Pa40DvqsrWqi2OvHNmOqt9PG7EHhOeEV4XJs=;
 b=M1gwrDnzrHbHU65mjCsECV+cVUBZHvSvIKCkk5PXn8BRmZ69Jhpp7An6xFNuqcSKenTbG4e0rh7ojz5AD2BA/QHr4nqBYnpwqlnPN+QyB6bXO8A/ocYKudSNJG8nRxt1o6jN9qQdlLOLGm/tm++zcPJWnELyWMmXp9Ty5Hrt9Pr9IcF6rYk6ymKvcdnmYzduovuVCcYUn7LPWPFV3+7fBEe2YbUNiDoiEn1Fri1t1YhjM8pH0DxOoWVRxiCwRl3yFka9F+49UJdmXTn9d1nLK0tfrFgbrCOrYiZj+CwLjC0mdvUzYkueYFPgBeRAZVvfJZO/XaRN9EYQZH5AcHdVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEvb2P3Pa40DvqsrWqi2OvHNmOqt9PG7EHhOeEV4XJs=;
 b=IsaDYphrhIIFRfnhmqdfhnXniE7eGwXXzNtG62IlSWSKMMJZtv2r+bf4SPJ0w8be6z0fm5MraFMgQIov4OrNpwG/YX6zkKaSuxH0KPnJ+p0xc70eoM6BUoz29Hj+HeHMlN+DFhrb7YHIY1T//0+f5+aNeoV4pKiVFYZ5eN3/cmpdxNilxFEFy0uKKSFwc+9hTu66SroNfEi0U2WZ7Jt3lA1Yu8EWPOAO6VRClbQXoK6msxlBilziyYXBYkISujLv74KRoK5gl4WWihx8OfxRZxOhZHgQmSFZAjWb1eHbNaBmFQ/StftA8YSF1T5eDpbgpo3JvFdafGwS8BRyI05Nvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6206.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:52:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 17:52:00 +0000
Message-ID: <90690bc9-ea9f-4f55-9699-924f7599efdb@siemens.com>
Date: Tue, 4 Nov 2025 18:51:58 +0100
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
 <c3bfb192-aad0-4fcb-a787-78f3a2d19695@siemens.com>
 <b38ee8cc-8d9a-4398-b6df-3857a0994d0c@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b38ee8cc-8d9a-4398-b6df-3857a0994d0c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff58b09-678d-4143-abc7-08de1bcadaba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGUyVlFSYXZLRkFqTmNIUTV5eDJ5K0hVUFBnNS9SNlBxbmt0REtqL28vNlFR?=
 =?utf-8?B?RE56TTZsN21GN0hEUnErUEhyanJaZnZKM1NDWXlxalV0RHY3OHMxYkFFT3ls?=
 =?utf-8?B?a1ZLSkF3NlN5ZGFXR1laMzU2L0VNek9RM2IyZlJMVkNLajhNdlFLTElPR1Zx?=
 =?utf-8?B?anRFYnRLWUdoY3BEbGwxM2ZTUnJlbjRscFZkWVUxWmpDR2craStoOVl6S2Jk?=
 =?utf-8?B?OUgzTGlOdWFDWE5uYURZQStqNTRxT3hRQmQvb3F2dmZFcGVTR1EzekU0dk56?=
 =?utf-8?B?TTRDTWtRNlc1NW9idXY4LzhKWDRuY2lyY3dJczNIK2R2OHFLVUlpSE1EeEJW?=
 =?utf-8?B?ZEVJbVMza2dTbXNqZk5XTGhpWWhnU3pZQW8xeXB5R2ZQRDc4TFUyeWU2Nmp2?=
 =?utf-8?B?YjBiQUpMZEdwNnQ2MUtyWFpRZUtXYzNaTkVvZWJQZzR6N3BydW9Nc0IzZWRT?=
 =?utf-8?B?cXNDenlxU1VVSWpsZU9FanovU2RESVM4L3lvd1czTnJ5V0h1ZFFOQzBTcFlB?=
 =?utf-8?B?d0NqUXdXS09lK2swRWhxcTROSlcrSE1TL1FLSVlycTV3SklKOUF4MzJ2dVBO?=
 =?utf-8?B?dDVoanBQemcrY2JIK2dSTEM3UDFWdnN2R1IvWlU2Z2NYREFJcWYyb0gzcmpo?=
 =?utf-8?B?Zk9ieFRDejJaYTl4OGxuRVRyaldsdzB4N0dNdFk5amF5QmdSOEhJY1dzUVVW?=
 =?utf-8?B?bWdCMmJtSDN5OXlRTlVCQTRGNnBJSm1ZbGFLY0VTdU1uWUYxaC8zem1tekJ1?=
 =?utf-8?B?Umx6aExIUVVWdGQyS2RoTHZEYkR2WmxlcTNBVjNUODNCWlhmRDNIbytRMmdZ?=
 =?utf-8?B?b05qeFcrZ2tlRFkzRGdzRlg3UXluTWJ3bEpVaUNXT1BkKzhnVWhJcS9QMVRE?=
 =?utf-8?B?bS83WjlwT2dNbmE2VGpvaUZ2OFluRGlhSFJBV1h0enVvbXhieTVSWTkyTFNZ?=
 =?utf-8?B?cVlHZXE5dUowNnFtK1RIMEFCczBpKzlZWkhXTERPNVR2bGFRR3BocDcxSjBr?=
 =?utf-8?B?Q3luNmlNWGFNSXg1NURtZ000VnRzcDlkZkFGbzVPTVk5eFFEVkRQUnE4NDg2?=
 =?utf-8?B?RjdUek1zTExxK0psWENKLyttUWlPN3l4aXgrWlk3QVh5M0dlMG84M0ZPZ2pT?=
 =?utf-8?B?VVVFdnZWYVl2ZDRHekRHbVB0RDBWWnhIYThUYTFTbmVRSmJHOFozeXh3WHVL?=
 =?utf-8?B?bllEQnEwQW9GNjF5b1JOQzY0SFh5MDlDUW1WTjJFblRvUkRjeHMrSWprN1hq?=
 =?utf-8?B?TExXcXptSnZPTVpyNjVlSzNpQytoYVM4Y1UwOGQ2cFozTUE3eHJmTk1kZWxT?=
 =?utf-8?B?d0JOZXRLU2svaGkvZWJObmhwUEh3R054NndGbjhLblV6dTUvMnduNVFxWU14?=
 =?utf-8?B?cURiMnY2ZmJxN0RoZVMvVmI5QUhRdHROYjZTTElLbmQ1dW5XK2hFOGo0REtT?=
 =?utf-8?B?TThGKy9OR1pUWFRlL1VFS1pOdTVMcm5Xcm0zRWtoemZkUUhSZnRSOE1Ub1Rp?=
 =?utf-8?B?cFVvdXo5cVErS2VjWGZ3MGNRL2wxbEVZQjZTdk15TVc1OFc3T0YzaVdSb3Fn?=
 =?utf-8?B?RHlKbi9qVFVNaTlQNFVFcmtlOFFEVzFFN0VEZmY2Tlh3WTE5eXMzMm9HZzg2?=
 =?utf-8?B?cVF4YWF6Rk95bVRwZHVVQ3JIQjJvcFRaa1ZsT1VhUHhab3VXS3RwNG1MajNm?=
 =?utf-8?B?OXV0M1I4a3UvOHVBYnJOVXU1THA1Ym5OQ0RqYkRTT1lYZ2hmaXdTUUxLcTdF?=
 =?utf-8?B?dndJMWM1aDRwQlRDZ2JISjRpYmd1STZvV3hNZXJ2b2ttWGI3clhKd1RHcUsv?=
 =?utf-8?B?T3cyeG1VUVMxc2ZYbDhRc09UcnB6RWx6YVdGN2pjM3djUGZqRDNHcFVkR09I?=
 =?utf-8?B?MDNjWUN1amxrYWZ1eFNUaVM4V3dYYzRkNC9xNVo4NW96L0JPOXEyTTN0dXBi?=
 =?utf-8?Q?lGo5eejQzjbtUXmP/DXKHmrQYWx0NNEV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZCSml1OEdGQmdUellVbUYwMzhNbUx3M3hLSENZTGxpbU5IdXFReTB6UFBF?=
 =?utf-8?B?THd1eHVNby9SbkQ5SGNWajNraDEwUUo1SlFhQk9IcTZjTUVoSVRhZjVZV2VF?=
 =?utf-8?B?Qytxd3BFTmErTlFIZU5CSjNsOXMzREMxZ3JRVEczNDRmcWVCTXRia1h1MDg4?=
 =?utf-8?B?ZTVNWHJnR1FaaENkcVZKVlRkQllkUk9QdzlMdDVFUTA3T2FPQVAzTmsrNkNI?=
 =?utf-8?B?YlZ1a1RIMlB2WjdVZUlWZVFsc0RsdHEvYTE0VUJuYjNKeWRGeHQrM0lJWlRs?=
 =?utf-8?B?UzY5NnFaTm9DVGtVbHBubnRDbnB4WTIyQWMwS1pVb01HVDVhM1FTQURTendT?=
 =?utf-8?B?cVZHL0tGQWJYTTFtSGQzeVF4ZDdiVWJjYzN6MisxODN4c3RneW5ZK3I4clRR?=
 =?utf-8?B?b0VHaTUzZlF6VllUcktjOEZxTjA1VXdlSnpwSmE5U0Uwcy9lYUl1Q3ZnaFJk?=
 =?utf-8?B?Q3ZmMHJzRTd6OWxqL3U3MFR1a1BudFBROHY4WUtveGdvU0lnYk9HczZqazRT?=
 =?utf-8?B?VGdGRWt1eEh3RHVWTlFCbnJHZHNOSC92SW94eDFGY2tpR2FTUENPREFqWHFU?=
 =?utf-8?B?QWJsOGU4ZkhLWDFwbVpRY1haaklaZTdLT0ozM1pyOG5LRHVjOVpYK1MyaDg5?=
 =?utf-8?B?U242dXdPNW5TY01SOFRXNXlIRnlBSW42UGFxVUhUU1VVdFJ2OFBEZFBKdWx3?=
 =?utf-8?B?QXJuYno3UGlrQnFwRXhuTWFtaUhoOWlaZnNyWTBXY1Q0VnFFMVhTazJmRW9a?=
 =?utf-8?B?Nkt3U0VIMGt5YTVEcjhVU1RUaUpHWmQrZDVvWnVuUUM1RjF5VUdIK1ZUSXdP?=
 =?utf-8?B?OHNYc1lZL3RkaHc2bStrd1VUS1BxQWk1VVNjd01hZUxKRzdkYmFEcW54Q3lz?=
 =?utf-8?B?SUNkQzJoRTRGZUxETFhTdHE5SVFjNUpKMUhvaW1nVDBMYU5UVjNSaWl0MDQ2?=
 =?utf-8?B?OHZGa0JCemVhNlNweGJrdXVPb1hKaGNYZlBtbTYrRlhXV1IrdVMwZDBxYjNV?=
 =?utf-8?B?VzVBUmVkQlA0czRHQk9ZRk92aHJYcTVoa2ZhVmkzendiUmJxSWVPTGx5cGVL?=
 =?utf-8?B?U1JIQlhPMnRmVUVld2NtVGV1dFVqU3krcHdmdEFWTDZuQW42S1VSUXFnMGJS?=
 =?utf-8?B?eUR3NHFQR2xLempReldtcXRSYzlLYjlLeWZSdjJCREc0a1JWcVZhb0pPUEtB?=
 =?utf-8?B?amkwZ3hldm4ybVllZjRhS2NWQkRBNkZwcWZhMTdNeTMxTDVsREdObGVaTVd5?=
 =?utf-8?B?bmxCVTV4RnNLMkRPeGpVOEhkWjFwRDRyMjVoTXZQL212VEdQMUo0QXQxa3kx?=
 =?utf-8?B?NmxrQ3pvVEQzeGVhQkN5NENQSmNKbDVXVUtFbU1aNWxYNHRlNzNQMFFSQ0N1?=
 =?utf-8?B?UnU0VEFjNmVJV2g2MWtyZkZVWW5saG4zbHVhY2cwaGFpYjNpMEpobzVoREZ0?=
 =?utf-8?B?K1ZEL3BFMWFleGxyT2FDR1o1NnAzb0hyQzRZY2MwMmxuaGpaTXRUa2NVQ0JD?=
 =?utf-8?B?Tit4SEVJOGg2UkZVVTZKQkVQeXRETTN2Sit6cVRQTVV6eHpkVWZ3K0lHRjdF?=
 =?utf-8?B?Y1o1S0w5RWdZc0gxNG9DTi9hQy9oTlFTeEJMOG03WWZVeTN5dFliMUh2UnFj?=
 =?utf-8?B?RFlkQWNZamxRdzEvclZSV2VqUFBlMnFwcGRyWDJ6TUVSSncvejQ2NEt4bzJz?=
 =?utf-8?B?SXcxL2NLUFZBSVJIWFNtMEh4ekl4RGFrNHo5WnVPanV1N1ZScjg0K1lzbEIw?=
 =?utf-8?B?WEthUTA1Ym1na3ZGVk1qOXpjWU1mV3d3WXBHOUdaOFpMUFVUYURYcmFqS0dR?=
 =?utf-8?B?YXpDbjI2dTM0NXVFN0Iya2tZQis4V2l4SWJzdWJrMnJpV2wyb0ZVOE5JbjV5?=
 =?utf-8?B?YUVCdTQxMDhLNFJLSVk1T0k0RzN6TnY4TW8raWF1S2plS2VQR1ZzdjBOeGE1?=
 =?utf-8?B?aUszWS91ZjJ3TFNMcXpPSWlOUGhpNDNOcGszZHY0L01lVmdHY3QzVk5OOVF1?=
 =?utf-8?B?RHUzSUluUGxOMzY2VVF1T1I4dmJUNDFyRnVaZktUakMwdE1OTHR1NHJKancy?=
 =?utf-8?B?TEN4RWlKQnNYSjRMNW1qT3o4TmdGWXJIUEtkK1pZY24rV1RmMFRKZlNxQjFy?=
 =?utf-8?Q?RrU2OpwK+WfP8CdTsMk0xoPKe?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff58b09-678d-4143-abc7-08de1bcadaba
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:52:00.1467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn19SqTNJrJ82+5lNQlvYeIrmZ0uBVHx+8jriyyJu3Yn8W9nIM7EBRTw6mq6XkC6u7aClChYGZvG3ejj54L71Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6206
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

On 04.11.25 18:18, Philippe Mathieu-Daudé wrote:
> On 4/11/25 18:00, Jan Kiszka wrote:
>> On 04.11.25 17:27, Philippe Mathieu-Daudé wrote:
>>> On 4/11/25 15:45, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> As an eMMC block device image may consist of more than just the user
>>>> data partition, provide a helper script that can compose the image from
>>>> boot partitions, an RPMB partition and the user data image. The script
>>>> also does the required size validation and/or rounding.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
> 
> 
>>> Still:
>>>
>>> $ dash scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img
>>> emmc.img
>>                                                           ^^
>> User error ;-). This must be just "...:2M".
> 
> Per the doc:
> 
> +.. code-block:: console
> +
> +    scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
> 
> (I'll update it)
> 

Ouch, indeed.

>>
>>> Invalid value '2MB' specified for /dev/zero image size.
>>> scripts/mkemmc.sh: 170: [: Illegal number:
>>> Creating eMMC image
>>>    Boot partition 1 and 2:   128K each
>>> scripts/mkemmc.sh: 192: [: Illegal number:
>>>    User data:                4 bytes
>>>
>>> $ bash scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img
>>> emmc.img
>>> Invalid value '2MB' specified for /dev/zero image size.
>>> scripts/mkemmc.sh: line 170: [: : integer expression expected
>>> Creating eMMC image
>>>    Boot partition 1 and 2:   128K each
>>> scripts/mkemmc.sh: line 192: [: : integer expression expected
>>>    User data:                4 bytes
>>>
>>> But now the file is generated :)
>>
>> ...which is actually a bug as well: We are not terminating the script
>> inside the process_size function when calling "exit" there. Deviates
>> from the behavior under Linux. Sigh.
> If you have a diff I can test & squash.

Someone rather needs to debug. A first remote experiment couldn't
explain why we are not terminating. If you could run with -x, that trace
may be a first hint.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

