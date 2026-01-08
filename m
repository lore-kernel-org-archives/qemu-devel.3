Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB6ECF6AB6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmQn-0004gb-BU; Thu, 08 Jan 2026 04:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1vdmQd-0004Wn-Ht
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:35:41 -0500
Received: from mail-westeuropeazon11020078.outbound.protection.outlook.com
 ([52.101.69.78] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1vdmQb-0006KH-MT
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:35:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiKRsA99yvau2UMpkINUe/zdB5+O2Ut6AVS04bWHxpbELCGhsd/3N3gGHDQPiUOn9hwPogkuG3TfVLspP/7jb/KVJ/QZb1vgP31MErQb8EeNDJnhAi52JS6IVo2X4yeVaecnOhwXsONVRUHWaaFhQKk3h0+lfga/Q0KiAZifOKUK1tGjMv9v3rZa7lkgmETXX2YyBS2mBY1/J7BLnvjfiAhuZmjfmfNPbD0E77Roqc+krOwlluVsz5Jefora5nXMvT28fRDcXdiDoiVWbl231sTiy7vBSgdV7UVNjMS3k2OqeWBhU0ZWDyAQlRuddlOGU/C9boHANq8QLt75OPYSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvLkEpBb9CZxrvy9pD6Wa1Uxg+lOkj1FOBXFhQQXgSg=;
 b=kED75sjXZuA7PzX7i6gLEUIgktF0iVJIjaUgMGgnSBdOhBmktrz7dxvw+6X2ybjse4UgHjXQZilubhVjVTzzJtqoUvBQHUMokbACs9Ww+dYSG9Mb6KsoT40qaAHqzt/ntDZLgMitlIHbfNbqh5h+WKMuq8UxQJhX8noGOntwKEPcHejTb+UO30s4k3oFjS+0wy+xZEXd+45piMffYTrD8Vz6n57+/5bCBrp22QXUCediAZqc6y9PY+ahNnhEjgIospkuZpnpidc4XfJd/phuZ+MgJ4dR9x8WNZdPlLYTxoOdRKaMlchRtkj/TlW3fiwsRxxEYPkSXjcYqvx87Xo1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvLkEpBb9CZxrvy9pD6Wa1Uxg+lOkj1FOBXFhQQXgSg=;
 b=uC78xLx+aba+SxrvaAsVUJS/JA+rBPObbGLRlhkFCVYndE83FvuMB+VkyKm3i5G5RShnAf8Qta6StBzSSLjxWK2o17KlKtxVe/9V/3hYq56fdA+QciQVDdJM08OAFq1D71f6Pe/GuZi3NIFoM4c7kSz48+toCl9mJME4JAT7H/SidnDKc+TbTQbyUQOW+YNPR4AVaTJ+PFHNdqY3a8uQfMzbuVTaKtfJxDCsJLkFUFprT8KW9MccB+Yz7KpJDF3iLZk+cbJeC+y1/xGUGZypPw9jK65fCPZe+5HqD/3ajy6yCrAkB1DG7WE3CaflAPTsGaUi31B2wrdddSSl9RVPAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU0PR08MB7414.eurprd08.prod.outlook.com (2603:10a6:10:352::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Thu, 8 Jan
 2026 09:30:30 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:30:30 +0000
Message-ID: <9bef9acb-3153-4ef8-b3c6-6ff6303336f5@virtuozzo.com>
Date: Thu, 8 Jan 2026 10:30:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dump: enhance win_dump_available to report properly
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
 <20250911123656.413160-3-nikolai.barybin@virtuozzo.com>
 <CAMxuvaysfdUSQyuzPpXMLRRxKsHjkjYV48S8L_HSWtWmn4ysXA@mail.gmail.com>
 <CAJ+F1C+sYiFKRHKz7Zzqe+=K-_aOa6ZzT4=buo3jTV+f714SqA@mail.gmail.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAJ+F1C+sYiFKRHKz7Zzqe+=K-_aOa6ZzT4=buo3jTV+f714SqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0014.eurprd08.prod.outlook.com
 (2603:10a6:803:104::27) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU0PR08MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: f6010437-eeb1-4395-c83b-08de4e9890ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkwwSUNuNnNwbmM5YitLaW44TnR3YTZwMDkxZlpuQXA5R1VsQWNNemFFUXZr?=
 =?utf-8?B?RHhvMWdpSnJkcmYyTnpETlJoc2FhcytkbGtMUEhvYitLcUhsMDNKVzlIZVNO?=
 =?utf-8?B?ck1CdzAyL3hidS95OU54alB3VkZ6VFUzL3owWWc4SDg3K3dSQTZwRU4vTlF6?=
 =?utf-8?B?NERuMi9ES3R1bVF4Q1NMSmdadU5BZGpGSXpzMnFvYlU3MFN6cTdjcE93dklj?=
 =?utf-8?B?RUttUVdlS3A2TGJWQTM5YWpxSlB5dVJlNlJqZ1UzZUtRdGR3MXR2cUtNakdO?=
 =?utf-8?B?Y1B5d2IyWmNoMllnZVI5aysrYlNpZlRubFJrRE9pR2ZlYm1EUEJyeXhSL04w?=
 =?utf-8?B?a0NvNkdlY2VSbmlFOTVKRXYreVI5MFF0OGxuMGd3aGc0eENTa0ZDcXFkYjBm?=
 =?utf-8?B?MWhHN05xMVhYenlFQXZ6cmpTN29hQmJNMzJSU08vL2tLdS9LM1Y5eHVmMlUx?=
 =?utf-8?B?R2dVUGZKS2h3TWhyOUhvaTdTZzBiU2xtaFROTzNwc3FBb28zanAvczZ3bVB1?=
 =?utf-8?B?ZnNsNXdQd3VscWgxUUxGK21EQSs4Q0dlbmdjaGdCVkdEbTE5NnIzRWdHczVN?=
 =?utf-8?B?Rkw4SXR1Mlk5S1Zmc1paVVhCSDQ3VFJYSlQzVUdrMDVlSTdIV3lSZlZoSzVI?=
 =?utf-8?B?VEtIZm1XQWh2YThrR1V5alBQY1dGTHd0RVIvM1FGUnY1RFpITXVxNGhuaGZY?=
 =?utf-8?B?V2s3MWhmRXZWcDJsL1RhUXVNUHFWTGNtQ0pPTU9MdjVYK1NLMTBZcHFTL3k5?=
 =?utf-8?B?WTFET21VTFo5ZmZJVlRUajk5OXhXSThuNHpiT3ZvMG9Jd3BzUXNzM0NRUkNB?=
 =?utf-8?B?QUplTk5LYjRyWnRvb1IzQkpiaEFpSzdOa1lQTFl3SHVrbHpDUzE4N05uRGd0?=
 =?utf-8?B?dStWd2pveDhkOVJGY2thMjhDaXVsWnVxZzUwZmQ2TXVmb25VV0xFZVNOMEhi?=
 =?utf-8?B?ZzFhSHZHYzh4RHAyWkJGNVJ6S1g2MENDTXZ2alJpUjNGZDZiSmN6ZWpmQTVD?=
 =?utf-8?B?RnIybmYvMnBsOHU4bWZFbVFqWHRhUTBOVTZ6cEV2SWtUdXBta2ZFV1ZodnVX?=
 =?utf-8?B?N254OXVKV2xGcFROU1NrYVZINFZiYk5mRlczM2FWdjIwOHJhTWJ2U1RJbWkz?=
 =?utf-8?B?OUt6T2phYTQ3dVNOdXNaVW9vLzErdHlRbW5kT1pOb2hNV2lZbGdoZzdNM0tO?=
 =?utf-8?B?a2RpeXNicGlJNEZ4anUxbGpLVjRJWnlZQzZIbW96OHljQzFyelU2VDdlN2NM?=
 =?utf-8?B?bUVacTR1eVRWSGFnajRCRmgzdWV1WEpFdHJtTW9kcmg0aE1GK2FWbEYwNmQv?=
 =?utf-8?B?c1JPNjNrVFVTVlpDTEhSUUQ1TkdEMjdNVHYrK05mQ292dExxd1M1QURPUjhG?=
 =?utf-8?B?WGR3UjFUMGZCNEVXWnhIUFNkdGFWTzhuTVlFN1dHVnRDWkxnMnpRa2NtQjh5?=
 =?utf-8?B?Y2c5Zk1GczFJUWgzY3lUNUZNZENkWFl4M0R6L2U1R05IajYxYzY0czZPSU8w?=
 =?utf-8?B?UU9TRFdUK1YxRXpOeDd3OXo1YnJXQ29vdnppQm1wV2cvVG5aMkZ5bjcyU0xP?=
 =?utf-8?B?eXJVdTV6Y3R6am9SK1ovYWZEQ09OL3cvdlFGS3VIWnliZFNodGhLZkJMT3Rj?=
 =?utf-8?B?anRXSjVXakFid2d6RUY2dmhkVUc5cTBQZkZGdGUrTGY5NGx6b0ZEYXpteW1k?=
 =?utf-8?B?QTNhMzJpZVFVcll3SFNJVElmU0VxSkh5RENnbG9KN1QrRDZOaiswaTdhTVF4?=
 =?utf-8?B?ai8xaTNYUmlEMHJ5RmlWbzBXbWZnblZadU9nSnY4eE5HcG5hZlhIY20zY2d1?=
 =?utf-8?B?ejV6NmN4M3RENUd2alRkS1JXUmhGVGpVT0pVWlc0cFh2OGRrTkNKMktOVDQx?=
 =?utf-8?B?ZUNYRnQwL2IyMys4MThDYUhuWHJ0MkdIeWpzY3g5VVRkWGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkdXVUoxV090a3ZxTE5qY0JrNUw1RlE3SUowY3VNWjZZajRuekx5cGdCY0RR?=
 =?utf-8?B?eDUzZUJ2MHZQSGtPaEF2RmpVNDJnSEd0RUJJODM1OXBKWmVRczBHY0dZTWxQ?=
 =?utf-8?B?djVURG1MUmpzdXgvSElNeXhMTlU4OStHeGc5Z0dncUFGeEI1WmFiaVhZc0cx?=
 =?utf-8?B?Wkc2emdPVkpyZlRxYzNMVGRKbjlucHpnWDlxNW5RM2lFazI2bTJDRHlkRUwx?=
 =?utf-8?B?QU9pd2hFK05PcGZ2WVZWalBZcm9hQTVKcGtDRlBnUCtPZmozaHJERHJIT3Nl?=
 =?utf-8?B?aFR0TGpsamxzYk93T1YyU1lHQ3Ara3h2RmhHZEtNZ3h6aEc2NFQxMVR6S042?=
 =?utf-8?B?YXV4S3NCZ1B0cndGclY1S2RYTytOUTdpcENJbHl4WmQ3V1Q4NTV6REhsRmJx?=
 =?utf-8?B?ZGhXL1djdmhTKzNWNTdJdU4vUCtJOTlwNGN5ckhpc3orcGhGUkFXTFlLZmNr?=
 =?utf-8?B?dWplS0VXc2x5MjNia09HN0Z1cVc1VG8zVitxNlZJVXg5MFBHYTB6aWkyUWYv?=
 =?utf-8?B?UHFXa1lFQkY5OWQvTi9WQUN4cWViaWc3ay9hcUlpNTNXZVRhZHB1RFE0UWc4?=
 =?utf-8?B?UklYeElJU21FQlQrYlkxRjVaRkxsNU1qSG93RWZsS2hWQy9ZaG9SQ0xFcUh6?=
 =?utf-8?B?MkF5c1o5UCszVDRpR2h2YWdxR1BVYWZXVGtQZ1NyQVhxYjhodnhwYzJSVXZK?=
 =?utf-8?B?VnhHdVcvTldYM1VZWi9rMnMvTWxiVHNzeGZNSnBXUC9TekRETDgrQ1d6RTZK?=
 =?utf-8?B?Q3JJd3JHdjRFOW9GVW9UNEFPbXA1eS9KMHRLdXB1bDQ4S1dXQnQ5Tk1wZ1JE?=
 =?utf-8?B?NHBsV1Q0Q2lvSmo0cnd2eEllYUFUWWlqbUhUU3llWmFkWTVvWEhMd21NRWV4?=
 =?utf-8?B?Z2pXNFFKbHpYUGtZRU9SemNrc3BrWDRLc1o2ajBHUTV1V0lySjJzQzhDM2xT?=
 =?utf-8?B?T1RUQ3JWNG9yV1pNandHbVVWRnZGZW1lYzhvRmd3OXUralpIbnB5Q1lxMXBK?=
 =?utf-8?B?Yys5akEwMGNpOXE1d0R5Nm04NkJyV1JhNDVPUEkwOG0rWmtYb1k2emZmc1Bp?=
 =?utf-8?B?OHV5bUxEOHNGeDNkYmFhbDFQWU84THJ0MEZQVDBaWThMVUpWWklrOFJDVDhn?=
 =?utf-8?B?ZGhva3JOTTFMMXh2L0ZpUXdyOFM4dnlkQXRrTFowUjNKZDJPcW8wdzFzNm1h?=
 =?utf-8?B?QmJpWlc4SDlOcitDeUpibGhxemczVFkxZVFSSDF6OFhBSzlsZ2xBRGpPZlk2?=
 =?utf-8?B?ODliL1EwU0d0M1ZWdnJHODg3NnlTcnI2eE5HbDZzOW81SVlmZm9TVjVhZXpK?=
 =?utf-8?B?cWloUUlCQ2NTUEJYM01IWlJqMC92akJVdEc4NXllTDM0UXE2UWlwdVpuSXRF?=
 =?utf-8?B?d2M0Q0VLQzRTTEVRUXNLYmRmRmdua0JqVVVXb1kyeThMWCs5aUcwbENrY05W?=
 =?utf-8?B?V2ZQZUc0eXV6K0Zab1hKZHpydit2ZmhDVFpvYWh6aC9jY3ZQblZuYVdHS2Ir?=
 =?utf-8?B?QlRGRXY1OGlnSWF1MEJ3Y3puQjNuTFBYemRuN2VLRVd2QkZxK3JON2tDWUFL?=
 =?utf-8?B?dTdRMURPK2NCZjE3UUsyMU0yd3ZUNkp0MnMvZlBmV3BvQ1FwTms0UkJvdW10?=
 =?utf-8?B?RVFLNVhjRUpxL0x6TlFTaW1ZZFJrZ2E0SXh2UEdFUFpZcVJ2bUVoNUFYWkNj?=
 =?utf-8?B?ZXhSakFhV1NRTEw3MkZnaHJTZVZEQmhXb3VNd2FVU3BITXpWNHhQS1JnOUVw?=
 =?utf-8?B?YWRmdmJBaVpwQ0pDcHlwUVFrMk0zWHpTUGllYy8rSU1yVEpNRUxrS1NkZVRl?=
 =?utf-8?B?TTVJTXoxTXJpYWFVdWVKck9ZUGtaTDZianplN1c1NW5YOVE4RkFkVzFLWExy?=
 =?utf-8?B?cHdxVnJMWEhhY1VJMzg0eXhGRUFWOXlpZGlBeGV6MUpxd2pFZzR3Q3FaaUIw?=
 =?utf-8?B?NENUU01BZlZLTlMvKzFVTy9UY3dYVWIxdlpIcXFhSlp4ejJhYXFab1h4cGRP?=
 =?utf-8?B?RmtaN1BGOFNhNmc2M2FEdndrenN1TnVKcVZuc09wM3B4N0dXS1pSc1hmMzBv?=
 =?utf-8?B?aUdaWmk4UkdTTW1VYlhFQ05aQis1VUpwc1JKK2RlUVJKdXZraExhL09uaXJo?=
 =?utf-8?B?di9jVUtVejB3Mk9vcEk4blFVQ3hPdXVuNU5ybXJQdDRMOWRyWnlNWTRXK0V6?=
 =?utf-8?B?WUZsRFdvR0M5SldyQmVJY1F0WGRyblNPRGwwV3lVYnpXeEJ4d3lHemhhT0VX?=
 =?utf-8?B?TnVLaHVyWEFNTXBvc2h6YzlwTHlCeFVWcFlCUWM0Ui9LNU9FQS9XQWFhWlhM?=
 =?utf-8?B?d0VwY0VlaWNaS3c5dVk4VU9ydDlUUEJsdUtzaWp5dW5seVB2Sndudz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6010437-eeb1-4395-c83b-08de4e9890ba
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:30:30.4762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaanC/eA0rkpp3KH/GcqndYTCHqX3VGLVRuR1z2ePm42MgSFkY3nCcDcXRustccc0J7ViSMlw8nooxJ3+HeVxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7414
Received-SPF: pass client-ip=52.101.69.78; envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/8/26 09:11, Marc-André Lureau wrote:
> Hi Nikolai
>
> On Wed, Sep 24, 2025 at 12:30 PM Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
>> Hi
>>
>> On Thu, Sep 11, 2025 at 4:37 PM Nikolai Barybin <nikolai.barybin@virtuozzo.com> wrote:
>>> QMP query-dump-guest-memory-capability reports win dump as available for
>>> any x86 VM, which is false.
>>>
>>> This patch implements proper query of vmcoreinfo and calculation of
>>> guest note size. Based on that we can surely report whether win dump
>>> available or not.
>>>
>>> To perform this I suggest to split dump_init() into dump_preinit() and
>>> dump_init_complete() to avoid exausting copypaste in
>>> win_dump_available().
>>>
>>> For further reference one may review this libvirt discussion:
>>> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
>>> [PATCH 0/4] Allow xml-configured coredump format on VM crash
>>>
>>> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>
> Have you looked at my review & updated the patches? thanks
I will send updated version next week after vacation. Nikolai has
left Virtuozzo.

Thank you for the reminder and best regards,
    Den

