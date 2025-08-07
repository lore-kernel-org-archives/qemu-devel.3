Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52478CA0EC0
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 13:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk0cr-0002Ub-NQ; Thu, 07 Aug 2025 09:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1uk0co-0002SL-Tz; Thu, 07 Aug 2025 09:25:43 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1uk0ck-0004R9-Qa; Thu, 07 Aug 2025 09:25:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+8zCvOAfLw7MPuSIw+R8iS8n/BxDazHkwgNdNz3AljDHcye/HYr/keyRhOY8HvbAYcM8oj5iTbE7aOSEw73e0QRnidqaFbbVmlanLMR9Tbm9GYTIpV65CS9j2SfQp8xAeEngrGIy94fYk6FG9z45ruZ3qlPPHV4dwNBGsaFg9qPWPjQmB90TvFaDrFKpb6cmcIs04ecpSYVE61t5d8w9eczkzesumir5pVJr96NL9gY0d/hjOGA3MbfSEd3uwfZceF9Th3o5qOUOo8dp5kN1n8u6UvswnwT/xX4CPEd/PFf3Nszmc1R1+SU6yOIzFxdk3KngvbtKyMTAnL3KcKDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAdlurXiUNgtMb/TeTBHWTXD3TfwxZlHqOgykbIWOVQ=;
 b=usz4VSZ0quWQZyphQ6FrDzWAQ6NELPgB1dia8iw/mZoeWX2NLsLLPsHN+WFDHYxFpGZC8W07XP5CthcZIvf6refyCQGnNbKFe1q2VvyVQ7KyVLu+LrVsbCV7TkOtDGEsFApXSc2GIJFSbbeAdJOuuzPO//CP2JQzBI4gLY24yDchM82C0yIWJxowJTerj24ZvDuCUs1VOHfgqD702EQuPY9fvf1VgmVmWUuDKKYUed5mIe22n6vGhmi5s7rGJ8TtA3gISrySkJ4GhWV6+ws5dNAysaWNjbVcqi6wgQ+6wEIsAf+Nl9z37M7O0fVL4nLdRrLulyMF7G2Nur7Y4GefjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAdlurXiUNgtMb/TeTBHWTXD3TfwxZlHqOgykbIWOVQ=;
 b=muGheDSKDkLIU0XKSmJL0kYPsFcoG4uJTN1tvbmi9HOsapXY8SXOk6iO0dgKycfFHzUDfFfvqM7TiBP7Zq1YoHrr8pccyybiwyuPRpj2yN4YyJXuhBvpfDLhx8pkZ6tGsd4yMFC6Pm0OsIAb1XEtYqOw92zarpsmtYn6g+F8bDSNb7fjl8Dr5LwhtaEJO4OKoEgXuL8oqHk2pDlnXLGTT1p8Lhx96vfB6ZuWhlbhqIfl49jyHnmL9oEGCfFe6DmgEI8EbStCHrI31OoalSQKMNnVRr4JVJ/VYdAB7qVtxE5vEi+852P3Kb+Jp6PDwn22KJ+hwdogcfCkZbTEs7xLVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV1PR08MB8177.eurprd08.prod.outlook.com (2603:10a6:150:93::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Thu, 7 Aug
 2025 13:25:30 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%3]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 13:25:30 +0000
Message-ID: <8b936ee9-c1f7-42aa-8c17-777e3c5c3e5a@virtuozzo.com>
Date: Thu, 7 Aug 2025 15:25:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] qemu-img: add sub-command --remove-all to
 'qemu-img bitmap'
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20250723192916.1065781-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20250723192916.1065781-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0008.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::20) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV1PR08MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6c1dbe-d564-404a-02f6-08ddd5b5e178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmNKcjNQdTh1cGVCdEdseUUxeUp6MjNsNEUxaHZ2Q0JNQWpGWVNtdUpucU5R?=
 =?utf-8?B?clpWbmw2TlppL3NOaWovOGFKZDVXMjFuU1NobEJFQWk4UEE2TFhyTkZSSlJW?=
 =?utf-8?B?akNIaWQzeHVsODZFazg5Ti9BREluVE41VnNGakJBa3JDc28rMXA3NnZLMEtI?=
 =?utf-8?B?Y1pJUGtzN2ZzeGFkdGFyQXdpaHRkWVQwSlhNZHFEdC94Qjg4RUFyWkg4bTl2?=
 =?utf-8?B?WUFWaXUxSk04aFl2QythOGlreXRYMmVWS3FDSWRYeXhHeHI2SGZYSnptTm4v?=
 =?utf-8?B?OUlxc2d2enArTS83b2dyRnMxZEtlWERmRk5pWDBlK3hDQ3prYU5xclA1WnMz?=
 =?utf-8?B?NWNxa1dwUkNPQ3Q0bWtTUW1MUit6TzVOaWh2Q2VIYUtZZzdPWWJpWFE1NlVs?=
 =?utf-8?B?K25XRnVUb01oY1pVdUhJZUtNNmxZc3RwNkcxbVBvcVUyOS83VWV4aVpadURG?=
 =?utf-8?B?aTMvdkpHTUdCWSs0Z3VpdCtzbmlLSW96RTRvc0VuZFpISHBnSXVnTGp5RXlm?=
 =?utf-8?B?SE1zRXdoR2F5YWc4Mytzcy90OWdDaFRqZ1NyS1lEUDJYTWFtUmdCVnVsU0Uy?=
 =?utf-8?B?d0w4NXhDd3YvdDFzWEFKeTV4MVNOL3RZbEQyRUZ4Y3hHamJVNFR2cWg1RUJZ?=
 =?utf-8?B?S2NIUVBvZVQya2RSRmdnTjdyNlVoR252WlRrN1U2anozM2VVNEJtSDd4MStV?=
 =?utf-8?B?UWdXMjBmTndTRENuKytUamZWSjJ0TFcreU1jRFZVcVNKdXFRL2Q3VlRoNTg4?=
 =?utf-8?B?a1ZHQnJ0cC9aRjN1ckRIWFJFMk1HRThEZUZjRWR3Y0RINnhwemZXUDNudHlt?=
 =?utf-8?B?R1AwaWR1VTR5OGJsNklwWC92dUx1cTdsRXJ3RkxFaldoc1JlbWV3dGt1clpD?=
 =?utf-8?B?dTJ3Y3RQZE5DMjMwTjdRbFJSeW9vUTlvaGhNcWhnYWxqb1U1QUlwTVZjYTJx?=
 =?utf-8?B?SU9pNDVOUjBmTUJlellQeU1OTzA2SjBneXBVZXBmRTBuZlRrZFplZDJrV2h3?=
 =?utf-8?B?cmNuaGNHN3U1bXZ2bU56OUIyMEZNWFp1SVI2TlV5THpaOGVjUWRtMlMzenhT?=
 =?utf-8?B?cUh1K0FteTgxRXF2d0xwbXIvY2phMFUyNUpUTkxsRWNpWk9JRnpPaTVJejQ1?=
 =?utf-8?B?M3JoRGtsTkRtQWYxNVVqOGE5WDB0RTVSRXZDeXhlb1hoRlZkMW5tdmpWaFJ5?=
 =?utf-8?B?TCs1a2xqLzRSUXJhbml5ck9ZdldUVlBBUjRVcWhPakhrNTN0WmNyOUhpS3kz?=
 =?utf-8?B?RDlVVkpoeSs0QlhqeTFzWStqWkZyRndDN3ZUMkJPbkhxRnZLeVVoVU5TT0Ex?=
 =?utf-8?B?WHJKaEhjMmZ6NTJQN2tNNStHLzBBWjJnYWZ1SEozdzM0ekVwLy9vTUJBZHZM?=
 =?utf-8?B?cnlVK3NKRnVIWXdiMTJZMk9wcVpXcWJDNzJLYWJmYXl2Q1h5OE5iMVNzWVdx?=
 =?utf-8?B?RWMraUcrM2FxYk91STVBRS90TmNjK1h6Vm9ESFZkeEFLL0IwQ2RUWkRMUjky?=
 =?utf-8?B?TGxGbXNZWElOQzNFSStqU1BUczZ0ZVc2TWFCUTVTQ2xwcUs1V2FPT0k3TUhs?=
 =?utf-8?B?V3RzNk1qQkhFMEJOOW5aWmtUR2tHVW1wWVRMeWVJWkkyT0g3T3U3TExpc2U1?=
 =?utf-8?B?dzd4YVhLL0pvSjdZT015ZG1OMEdndk9ETStLVmdHZXpNSUVTNUduRDY4blRw?=
 =?utf-8?B?MEZmUCtURkpwaUY4NVBYNXpyUlZXME1LbFNnNlcyWm5Hb0VpS1p2dlQvOWRL?=
 =?utf-8?B?Tnp4RHJ0MkNBSUF5dWlMNnJ6Y0R5S0Nhd0hNZXJYRnMxOTE2MG1iTSs2QUZu?=
 =?utf-8?B?T0wxYXNBQ2ZpUmtSYVdnS3M2M2tlT2sza1hSekZRdTBnRjIrUHMrNTQ3Lzl3?=
 =?utf-8?B?VzY5b0hYanNRTHVaNVN5emYvQzAybDJjcURwR2pLamJtbW44YkVBZ3pEZ2pW?=
 =?utf-8?Q?gn5HhX5dccg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZExJMnBlZ1F5OFdpQm12UEExcUJtRTJnRWw1YW55RUFoS3RHOCtEanRKaC9h?=
 =?utf-8?B?VXEwcWE4NHQzQkwxV3ZFR2hFdy9QQlE3RnhVVXBKMFBRMnYrdjcyU0pYYUNx?=
 =?utf-8?B?K3VKN1lBVkprMUtZclo3TkdVa2Q4RXJObVRsTnNsS3lKeWUrc05GYk5rSGg1?=
 =?utf-8?B?Y0RvUjZsRlRhajVydU50MjBvOXRVaXVBNVNLNHByMnZHZ2xBNnZSVHVnd0VR?=
 =?utf-8?B?dE1ncUR5Y0ZsN2hkTUJYQm5nNkh5eTYxZkZXQnhyd3F2bFYxSGtpcFJDRUpa?=
 =?utf-8?B?VmhlN21LaVJpS2xhMnhzdHBVMXRmclBWUEpiQThYNGhjTWMwK0FoVWFjUi9r?=
 =?utf-8?B?Syt3MDR4VG1wa0RmT2oxY01JTDNBbUYzaVlUV2h0T2RDZXl5V3hCem1wcHZq?=
 =?utf-8?B?ZzlFYnpEdHBscmhEbE4xa3V2eUlPTTY1eHRKSUMvTnlIUU1KQ3ZUbzRtNzFu?=
 =?utf-8?B?a2kwN2hiSDBBNG1nZitObjQyV0kyUUNSRS94cEpLTHJwRjYzbkpNTDNmZDls?=
 =?utf-8?B?ZE9Hc1kxT2pZV2ZaVnlTTm1JSGV3WS9GVXZnb2cxUWVWQjUzZXJKQTZSQ21h?=
 =?utf-8?B?cVhTdXZLcWlGaEdtM0RXUW5NKzF3bCtFenhPU1Z2RjdGY3Q3UHN1cTZuN1Jj?=
 =?utf-8?B?dzZnVWhydDRBOXhvZXF3d05yZlNYRTNQczYrdmJReVhFQ1hTa0hVSzcyR2Y2?=
 =?utf-8?B?UzlFVlorUGVuTXhiZFlWYmNqbUlVQ3dhNTZDNllrL014eitmTGhFV29JZXIr?=
 =?utf-8?B?VHk5dFpwcTNWRjJjTVpucStPVkl2TlVJbndmcHZmYkRQVis1TE8wZ2h3RHRo?=
 =?utf-8?B?QzNqZUhsWTlYOGhqSHRHVFAvaWU3ZCtmNXBNaUlDaVhGYm9UTkR6d2tmWE9p?=
 =?utf-8?B?T21aNUpWamZ0QVBpOGc5L3hJaUVwUTdGbytvRW9JZlZseHlBeG44dkI3cGpJ?=
 =?utf-8?B?R3VhTUpNdTRLbkJoV3dBcUh0ZC9JT2RBU0trRUlHRlY4bC9FTk1zTmxHc282?=
 =?utf-8?B?NVdCNGlZMURzU1ZtUnhIeEVZSXdvallDM0txS01KTUIyTWxpSDVYSW1xUkZv?=
 =?utf-8?B?N01hSjlpbFd5Z3ExTDVOQUVoN3JJdFhPaTBMVG1ndzZMMk1tREZqQzNwa3BG?=
 =?utf-8?B?UUhkSHNWN1dad1QwcmoydFQvdi9jU0dJZjFJOWVaNFk1RTBLNkJQQ3RlOHFr?=
 =?utf-8?B?RVdobHVMZm9iMDdzTXZ2MGN1alBUWU4rSWsvajNscnluaHRRZnlqY1A1Rllz?=
 =?utf-8?B?aTkzUGdqdklOS2RWMWRHa0dWUG94aTZKaUNmY0ZrYnlpU2UyU1p3aE1jdlMw?=
 =?utf-8?B?ZTZjMzlvbUtHTUtqL1RDU3FIcUY4RE0xcVNXUFR0RHV6SFd0cEdaanBXNlJq?=
 =?utf-8?B?d3YxYVRNY1oxN3ZPMU1tTVgxS0lvbFAxTWx0M3hTY2k1UktOMlFXeDhDVXZx?=
 =?utf-8?B?eWUyVTRrUmd0Ty9rME5yNG5RTlE0NXV4UEpKNzIzV282eFhiUzRXVW11eXRV?=
 =?utf-8?B?T0QzRWdvWWNONDVEUXMybXFLQXNwdHBaQ3FJQ3dES2QrckhGUU9hYVpJbXZI?=
 =?utf-8?B?U3BNWUV1Y2t1Z29QRXhHeFBvbTZCd0lydDNZZ3pacU5qdFhFbElFLyswVGMv?=
 =?utf-8?B?TmFjRmtFcXR1bjkzcGFZclNZWG1lNjlXTi9qOXhzVVZQUjdGNi9sYXFwYVFH?=
 =?utf-8?B?SVR0dkhaNnkvcEN6RWtpT2E5SDNYZWMyQXpqWWtSQzllZkNZSG1CVm5PT0Yx?=
 =?utf-8?B?cFoxaEk3YnBFRkRJd2U0b2ZOQkRzT3hXcUEzaGR4K1dFakJMRWhvZHV0UjN1?=
 =?utf-8?B?WlFkMzA0Tm8rWE9maEdYWnlqRi9raHB1TFpQS1kreVlnUGtiM0NnbDR6QVdp?=
 =?utf-8?B?Ly9Mams2N3VsR3RYSlNuZG9aRmx4R0NoQ3FUMXhTdjJ0VXp4MlErV0tXOE8v?=
 =?utf-8?B?dkhvRGNpam8zN1k2cE00VUdkMSs4akUyaFhVcTFtQmxmM0g2TVJucy9HaUgr?=
 =?utf-8?B?ZjZyZGg5OU5TYU5sTmxLVW0zN2ZEdlRVKy8xM05SbWVkSGVYR3NLV1NNL0o1?=
 =?utf-8?B?SG1JT2doeTJOa1pOTFlQdFVUY3IyaTBTdzlrUXRDcjl4Sm5iVWZGV3lVZXpL?=
 =?utf-8?Q?cCZY4MhbUlEssqMl4trjamD3C?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6c1dbe-d564-404a-02f6-08ddd5b5e178
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 13:25:30.6810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNrUEo+vDGfKldgA1Ks4FHePqtQzpXTK/yv8HY4BfRS5I/bG+AvPv1fFfeQR10NibQzg/HXciY7R0AjGuqcywg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8177
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=den@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/23/25 21:29, Denis V. Lunev wrote:
>  From time to time it is needed to remove all bitmaps from the image.
> Before this patch the process is not very convinient. One should
> perform
>      qemu-img info
> and parse the output to obtain all names. After that one should
> sequentially call
>      qemu-img bitmap --remove
> for each present bitmap.
>
> The patch adds --remove-all sub-command to 'qemu-img bitmap'.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> ---
> Changes from v1:
> * rebased to latest head
> * adopted bitmap help to the new layout
>
>   docs/tools/qemu-img.rst |  4 +++-
>   qemu-img.c              | 47 ++++++++++++++++++++++++++++++++++-------
>   2 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 5e7b85079d..db739ab5c8 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -301,7 +301,7 @@ Command description:
>     For write tests, by default a buffer filled with zeros is written. This can be
>     overridden with a pattern byte specified by *PATTERN*.
>   
> -.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
> +.. option:: bitmap (--merge SOURCE | --add | --remove | --remove-all | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
>   
>     Perform one or more modifications of the persistent bitmap *BITMAP*
>     in the disk image *FILENAME*.  The various modifications are:
> @@ -310,6 +310,8 @@ Command description:
>   
>     ``--remove`` to remove *BITMAP*.
>   
> +  ``--remove-all`` to remove all bitmaps.
> +
>     ``--clear`` to clear *BITMAP*.
>   
>     ``--enable`` to change *BITMAP* to start recording future edits.
> diff --git a/qemu-img.c b/qemu-img.c
> index 7a162fdc08..ddd449c1ed 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -86,6 +86,7 @@ enum {
>       OPTION_BITMAPS = 275,
>       OPTION_FORCE = 276,
>       OPTION_SKIP_BROKEN = 277,
> +    OPTION_REMOVE_ALL = 278,
>   };
>   
>   typedef enum OutputFormat {
> @@ -4992,6 +4993,7 @@ enum ImgBitmapAct {
>       BITMAP_ENABLE,
>       BITMAP_DISABLE,
>       BITMAP_MERGE,
> +    BITMAP_REMOVE_ALL,
>   };
>   typedef struct ImgBitmapAction {
>       enum ImgBitmapAct act;
> @@ -5010,7 +5012,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>       BlockDriverState *bs = NULL, *src_bs = NULL;
>       bool image_opts = false;
>       int64_t granularity = 0;
> -    bool add = false, merge = false;
> +    bool add = false, merge = false, remove_all = false, any = false;
>       QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
>       ImgBitmapAction *act, *act_next;
>       const char *op;
> @@ -5026,6 +5028,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>               {"add", no_argument, 0, OPTION_ADD},
>               {"granularity", required_argument, 0, 'g'},
>               {"remove", no_argument, 0, OPTION_REMOVE},
> +            {"remove-all", no_argument, 0, OPTION_REMOVE_ALL},
>               {"clear", no_argument, 0, OPTION_CLEAR},
>               {"enable", no_argument, 0, OPTION_ENABLE},
>               {"disable", no_argument, 0, OPTION_DISABLE},
> @@ -5044,8 +5047,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>           switch (c) {
>           case 'h':
>               cmd_help(ccmd, "[-f FMT | --image-opts]\n"
> -"        ( --add [-g SIZE] | --remove | --clear | --enable | --disable |\n"
> -"          --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
> +"        ( --add [-g SIZE] | --remove | --remove-all | --clear | --enable |\n"
> +"          --disable | --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
>   "        [--object OBJDEF] FILE BITMAP\n"
>   ,
>   "  -f, --format FMT\n"
> @@ -5060,6 +5063,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>   "     with optional multiplier suffix (in powers of 1024)\n"
>   "  --remove\n"
>   "     removes BITMAP from FILE\n"
> +"  --remove-all\n"
> +"     removes all bitmaps from FILE\n"
>   "  --clear\n"
>   "     clears BITMAP in FILE\n"
>   "  --enable, --disable\n"
> @@ -5089,7 +5094,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_ADD;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> -            add = true;
> +            add = any = true;
>               break;
>           case 'g':
>               granularity = cvtnum("granularity", optarg, true);
> @@ -5101,28 +5106,38 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_REMOVE;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
> +            break;
> +        case OPTION_REMOVE_ALL:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_REMOVE_ALL;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            remove_all = true;
>               break;
>           case OPTION_CLEAR:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_CLEAR;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>               break;
>           case OPTION_ENABLE:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_ENABLE;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>               break;
>           case OPTION_DISABLE:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_DISABLE;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>               break;
>           case OPTION_MERGE:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_MERGE;
>               act->src = optarg;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> -            merge = true;
> +            any = merge = true;
>               break;
>           case 'b':
>               src_filename = optarg;
> @@ -5139,8 +5154,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>       }
>   
>       if (QSIMPLEQ_EMPTY(&actions)) {
> -        error_report("Need at least one of --add, --remove, --clear, "
> -                     "--enable, --disable, or --merge");
> +        error_report("Need at least one of --add, --remove, --remove-all, "
> +                     "--clear, --enable, --disable, or --merge");
>           goto out;
>       }
>   
> @@ -5158,10 +5173,14 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>           goto out;
>       }
>   
> -    if (optind != argc - 2) {
> +    if (any && optind != argc - 2) {
>           error_report("Expecting filename and bitmap name");
>           goto out;
>       }
> +    if (!any && remove_all && optind != argc - 1) {
> +        error_report("Expecting filename");
> +        goto out;
> +    }
>   
>       filename = argv[optind];
>       bitmap = argv[optind + 1];
> @@ -5199,6 +5218,18 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>               qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
>               op = "remove";
>               break;
> +        case BITMAP_REMOVE_ALL: {
> +            while (1) {
> +                BdrvDirtyBitmap *bm = bdrv_dirty_bitmap_first(bs);
> +                if (bm == NULL) {
> +                    break;
> +                }
> +                qmp_block_dirty_bitmap_remove(bs->node_name,
> +                                              bdrv_dirty_bitmap_name(bm), &err);
> +            }
> +            op = "remove-all";
> +            break;
> +        }
>           case BITMAP_CLEAR:
>               qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
>               op = "clear";
ping v2

