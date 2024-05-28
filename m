Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29AEC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxqp-0005pD-7y; Tue, 28 May 2024 10:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sBxqj-0005o6-Ss; Tue, 28 May 2024 10:30:49 -0400
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sBxqY-0002XF-Nt; Tue, 28 May 2024 10:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0VZujhc/73Bnqf/vC9WSwDqWvVtNwn0d0a8RXkMeTrditwUd4DujrOU3WMh14dEjFWSy8gvbuwfeWeZBRt+BiyefLNURLoFIycf57HtGa7t4OwHvMYE1YgYX3WScK2DhRmeCIxtMfGfy4HiAVyvyoms9bQOX58ex2IJJ5n8xU3uhklCjECRcJg4d9LUqYBAQwBrGr2jtsp3dwYqs8uBjgrnzGcYiqMvG+zHJvdfqJRgjcwt70I24gPSQKw7sLXjk/fgVJdWUjk9W6wLoo6Bt/VfjoGmTG/f1jV9u3013ye9Y4JqpLBDaDqqhbxCSG2I7QPr+d5/Vvm8ArCexQGYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tmZef6f24k8fUaf580I+Oczf8RCIZt7scSNvkxivxM=;
 b=bkgWsRFihlBR8NbzGRr3NZV/0+e2S1kxfIx4Ck+qqi6uXTjQP53RvhgvHxjswzlVmlryhZxmL7dkf5n93+Xsh94qOSXAe3Q2jCUdU0nJQrFHaA05G3WWGiJuZky0yUXLyS3rT6Pb41NslbqdfuOOHyZ+g63SXjPxDY6KuKxzh5kR9bOnMzbTWZaUJOTtKOz/NjVd++bnd+Yn48esAkxiAdQAFv/4S+IKGJXZ3TbLWd1Cc0FSWf6am1h64ho+AaI6AP0lnJ+g77fCD080v5DsPW9CbELhIyukm/WkvWqFXIyWe4HkNpuZ+Wfvqsy4/gvbDmARZ06OFJW30P+QCG0DRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tmZef6f24k8fUaf580I+Oczf8RCIZt7scSNvkxivxM=;
 b=GmoIht5wCd0655b6IDXgcog8Yi9Nl9kfqXtQEuhDp0kq43n3JOFPVuDsHjM5OiQ9drHDk5h1mNBqxJZ4AGjv+zyAHuKgJ8KxYt2H/V2Efy9iHRiHLPmm5t4ydzCFPFqVfFHYvumgDkD59yyiEUFZJsP35yP0mrcVVayy73pvxO2Gi1fMbUtzJnTfmSWynMoVwSHhzoIhwactRCidlEyiXUIeAz6a2U40mo7zcOkzf0D7i9S+9fKnhOt5ZDDwtFb7EoaPwFa0dga52hsnqwXw66EfYyLrutrBeGKfnjlVxs4sysmzvYsXFSG2rYYBvklhI7c9+ow2MSgMKjHsvGcIWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB8875.eurprd08.prod.outlook.com (2603:10a6:20b:5b7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:30:32 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%6]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 14:30:32 +0000
Message-ID: <5ca38b76-f34d-47a5-a670-54e90915b7fa@virtuozzo.com>
Date: Tue, 28 May 2024 16:30:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] prealloc: add truncate mode for prealloc filter
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20240430170510.148812-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20240430170510.148812-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0033.eurprd02.prod.outlook.com
 (2603:10a6:803:14::46) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f853e7c-7023-447c-91c8-08dc7f22bb16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFovek9UWmdLbjVRWU93TXpRK0IxajhVUi8yOWwvbnNpdHJ2clU3dmRFYU5y?=
 =?utf-8?B?YitXaGFPUjB3SmFEQ2NvVm92cjViZWZFbG03aGZJOGZGQkkzRUFDQVlVaUgw?=
 =?utf-8?B?MndkV3ZXWTR2TnczRWdjVzVlaVRyMUxIb09JK1NKNTgxckVWZHR1V21JSXJY?=
 =?utf-8?B?VDZqd1ViUDdQaDZjbHAwOWxPV1krUWdNc2cvRWJNakVvUUtiTDB6WHlidkps?=
 =?utf-8?B?OEo4eVJkK1g5azBGSVg2Y2cwY055Y21QVUY1WlR6MDN0TmlNaGI1c08vakw4?=
 =?utf-8?B?a2xRTFhvb09hNVlUYlRJRHJHLzhNcVVZMHZnbnFxTGl3REtVRG1zL0ErRDl3?=
 =?utf-8?B?alMrMmZpZWx0QTFtWkk5K1BNVlMydEJMa09hZytSSkRwNHdiWFNQaWx6YmEr?=
 =?utf-8?B?a0Jib1M0cUNIaDVkWDNzbnlMblNwYTRZMVgxR3FxMDhzQ2NxRjJqK285anlD?=
 =?utf-8?B?N05oWVlMMENDd2lBTW5WTUVnMlBFYUx5OHVQMDByampmQ3R6ZzY2MUU2d0hu?=
 =?utf-8?B?OEZRSmVVbDc5LzBmWCtsaHYva3NXVDNqK0hYeWk1NlBXYkRTN1h6L2ZscDJW?=
 =?utf-8?B?Qm5Wd1lna21OQnNrTlBQYUJzcG9WSWFPQTlwVDZGa3BOWDhZSE80bjZPdUF4?=
 =?utf-8?B?UmltZ1p6WUJPZGtTNzhwRGF2cS9oMjd0ZXFzbGtaZlo2Y2lTUEdySHpqeTlp?=
 =?utf-8?B?MXNmSjI2U1R0ZXRrYnFDYXpUakYwUGNHM0JSLzVFVGpTZTJzenBFUGJjV2g5?=
 =?utf-8?B?Z0VsenVjbGRsRTVDUXA1aHNKZWlNY0NZU1B2N0F3d0o2aCtxOHRqSG91VkMw?=
 =?utf-8?B?MFNESVNOTi9Xb0JHZ3lxL1h4YW4xSDBFSzhwakxIQ0xtWS9PbU5QVlBPZXFP?=
 =?utf-8?B?SlpjQWsyU0xpSVhyYVZ4S0JqWlpLSi95MkRNakFnUG85QWNteWpYTGl5NXc3?=
 =?utf-8?B?TjhHalV0Z1I3dGp4R2haMEdCY2Y3QkZlUWs5U3hMbTU5MUJpcFo3SjByUE41?=
 =?utf-8?B?eForWHR1dmdvZm5Ta1Nva1JVL283bEIwOThQZm1SR1A5ZE1RT0JhVzM4V0tw?=
 =?utf-8?B?WUZlUlJ6MkswckJSTEZLRGR1empSTGNLSUZxbUpCa3Q1bGw3eHVFdnpsRU80?=
 =?utf-8?B?M1UvckNNajlDZWtRZUlsUklOaitHSm1TWS83MHlEQUJVTW1ES2dkVUdrUWZP?=
 =?utf-8?B?OVNzU0d6MVlkTzIvbWlKb1dBODRWd3BkUzNoRWhzUmtuckVHWU91Sldvc0Zm?=
 =?utf-8?B?ZWxYUm9uTWdqWU9kcTczWSs2a2l2L1owdHI2ZFpacGt0S0lNTFJOMHN3UHR6?=
 =?utf-8?B?RVpkU3ZkUUs3d25JUWFUMlVpQlQ5dzBLS3dPak16U3ZqSDBEeWYwQXIxWnJz?=
 =?utf-8?B?N0Nlak83QWUrZTUwazd6dVh5MGNmT1lZWi9zRnJPNjRoZEFlb1JqcDljSU8y?=
 =?utf-8?B?TUp3UUh5ZGtqZytDWU9iRW5vZ1pOMUdRd1JzbmlyVDNoVkVqeURZbW5wdjFD?=
 =?utf-8?B?MXZkV21oZGhSS0tRa1JCd2t4ajM3QTBlb1BwWU1iZTk1UUI1V1lvM05udlRR?=
 =?utf-8?B?U2NtZlFJSkliOFZ1OUI1OWVlNm1JbiswOVBHeXYxMzN5N09ORlZTZnZSNGZU?=
 =?utf-8?B?TEI3dGUvZzdISlBkRExZZVJPTzJ3WW5KMm0zbzV5MlVnK1VzcXVhYWFqU0NQ?=
 =?utf-8?B?akZkUjhnajJZTlRLUVJtNk52ZTZ3N0k2UjFOaFNJcjIxa3QvL25TYkJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXpiaWs1ZzRHanliNTZpMHlsbnUyM2NURWFPQTZlb0pjMDVhOUJWVndRSUNK?=
 =?utf-8?B?RTFvWGlDaEFsNXdNOEJ4ZUhNcDJWUmFEaW9ublJBMXc1OUFiZ010TzBFSVpP?=
 =?utf-8?B?eGhIU0NQemt0WDh6cTlTdUhsdldmRFJjYmFUb3pOZmJOMUhFWERsdnVmUjNS?=
 =?utf-8?B?WTFIUStMM0dkbkJPcTQyMm1hS0VtUUhOZWcvNzNheENwK0FBenJpZnZ3OWlZ?=
 =?utf-8?B?aXcwYUV2YlNsQnJJaVlydzd3S0ViQTM3S04vcUlvTEpQaGlPVzBxRmk0Q1hF?=
 =?utf-8?B?N25EdlIwdnRoTVI0aTc0dEx0a1ZYQzU2dldhR1pzMS95T2JRWDZkOCtzYVdz?=
 =?utf-8?B?U28zanJkNmpPR0tpdW14N3h1UE1zcU90SUdhNGpuL0dJOXB0RUM3Z09mYlZE?=
 =?utf-8?B?anNXV0l3TVQ3aEtJcEh0RkxtVXBCTmRLRUlWcVZmRmY3TmpnbGo3VEFpUEQy?=
 =?utf-8?B?aC9TV1RLUFRZWWpNMk1rRWhxOHU5MTRVdFlpbHVLT0J2bXlMRjZ4TVF0S2kw?=
 =?utf-8?B?Y045VzdZSCtIT1lXMFhwa2t2WWFUZWwrNmQ0YzNxd0xOSll6T3B4M1krR3Ux?=
 =?utf-8?B?TitDWkZiWFVNMVdSc3ViczUyTzdPZUl4NDFCR3owWitLUW9teEgzUFBvQXhk?=
 =?utf-8?B?UmVrMFVRaHYxUkY1a0hSL0lVTmdKZzdtNjFkeTJKS05CdnQxcXJDZ2JEYW9k?=
 =?utf-8?B?TjgvRkhYUmMreE1PeWFERVFaeDA0TU5vZXNnY25WV0VhNEh6a2ZQV25TM291?=
 =?utf-8?B?Q1dlVXBwK3dBRjUrUnFLMFFpNDVFcTJuN0t0UmQvVUxRNG9oUXNTWG5FMnFx?=
 =?utf-8?B?b25vMWtwUnN3dkQwNGdQa0Z4RjJpMzBjMXRtYjd2cm1kRjZsc2o4cjVxVitq?=
 =?utf-8?B?WDFYeFFtL0FsQ0ZQZ3pOV3B5Qld5cTlSSzJoSkdySHdiT0M0d0xSRHVkd014?=
 =?utf-8?B?c2VESm1WcjFKMUtpL0pTZGtNWisraVBLaExCS1hUQjN2ZmVYL0QyMjNlRXpI?=
 =?utf-8?B?WllFRWlIc1FRRVZUVlFZYnlnb1NEWmVzb0tTcStLMTQvRDA4Z2llRGpXS2da?=
 =?utf-8?B?TG5SaG5vN2JteWhYaHo3d3FiNFRPaXJrK0crT3hDczc0bStjS1VocTl1MWN0?=
 =?utf-8?B?a1RBSW9MVnZYeUZORmFWMjJnY3hRQVd1QzJ6WjlvOXRiQ2xiYVg3b1YveEYy?=
 =?utf-8?B?WERUb1lTLzRHbmZra21ZYlhMNlBiRHUxeWNiK0lXZGFsYVpzcGltZHdEZzFo?=
 =?utf-8?B?VTA5aDNyN3ZLN3FGbjZWL3lCYlowRWR0TG8vTWRzVjVCYllEMlRUeXpvcUZi?=
 =?utf-8?B?RmthSEZGZVNkWUtuTDZCWGFOUHMxZ0RFeHBTZ09XMXMyWjRDUkFwZEx1YUpE?=
 =?utf-8?B?bUkxN29EMm94WHNjMm0yZWZZUE5uN3lCUUl4L2tic1hRR1ZvR0xjTUJXSTZ4?=
 =?utf-8?B?QUpHbWZISlRQeXExVmRGamxDWVBZWWlDVHhYNTE5Z1NBcmxqalpSZ0tVMjA4?=
 =?utf-8?B?YXhFOXlibFBxYk1mb3p0d1BROWJEZ29tSy9jNFA1c3pMRyt4KzhkZTVoejhC?=
 =?utf-8?B?OHU1MFdJeE9oNUsxcWI3aXcyc0Z4K1RJT25ZNnVJSjFPYVBic1NFQWNXTjRz?=
 =?utf-8?B?eUZRdW1VZGt0aEp2bENUWDFlOWN5NnVIeTk0emozOHJIQjdPY21uUHRRRUFX?=
 =?utf-8?B?MEVSNThyM3pYWUhTc2VEbTFaL2Z4dy9mL3JwNkVvV2ptRWVnVzE0bU81L3d4?=
 =?utf-8?B?VTQ2MVpCekYvd2h6SHNFOW9qU2VpYm0xY0tZa1FDeHpSS01kUlIra0xwTGZt?=
 =?utf-8?B?MndZb1pyaFduc0JqemgwcFlBVzM3Q3BHa09mNEJPT0RtbjRMR21GN3pGaU1s?=
 =?utf-8?B?R1BqOUdHRlFxM0RJd3o3SnpoaUQyeS9uOFlQTXJYSWZOZ05wb1BtdTEyWWp0?=
 =?utf-8?B?SlBCMGd3d2lQT3FpVEMxTDlpdHlCMzdmVmdEZ2dwVEkwV3NxS1Y1alZzL1FN?=
 =?utf-8?B?MkJYS0NrTDZtUVRxTXArbXBVWjFid29WM0xHMXc2MzI4c3dFQ0VuM1NIK01v?=
 =?utf-8?B?MGhTMktrVG1Zc09VTUZIKzg5QWFyc21kSU1STTREUy9IL05URHJDTzVIMmRt?=
 =?utf-8?Q?SpSOtRfUGYwD2ls0UVqcAY/lS?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f853e7c-7023-447c-91c8-08dc7f22bb16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:30:32.5330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CKya20pGR5poGof/fnRuCBMeZvlJpj5S6xKAqC0TT9a5uf+lESoXRh3ycO0p9HnSYsrsFW/piTayepfep36gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8875
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 4/30/24 19:05, Denis V. Lunev wrote:
> Preallocate filter allows to implement really interesting setups.
>
> Assume that we have
> * shared block device, f.e. iSCSI LUN, implemented with some HW device
> * clustered LVM on top of it
> * QCOW2 image stored inside LVM volume
>
> This allows very cheap clustered setups with all QCOW2 features intact.
> Currently supported setups using QCOW2 with data_file option are not
> so cool as snapshots are not allowed, QCOW2 should be placed into some
> additional distributed storage and so on.
>
> Though QCOW2 inside LVM volume has a drawback. The image is growing and
> in order to accomodate that image LVM volume is to be resized. This
> could be done externally using ENOSPACE event/condition but this is
> cumbersome.
>
> This patch introduces native implementation for such a setup. We should
> just put prealloc filter in between QCOW2 format and file nodes. In that
> case LVM will be resized at proper moment and that is done effectively
> as resizing is done in chinks.
>
> The patch adds allocation mode for this purpose in order to distinguish
> 'fallocate' for ordinary file system and 'truncate'.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   block/preallocate.c | 50 +++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/block/preallocate.c b/block/preallocate.c
> index 4d82125036..6d31627325 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -33,10 +33,24 @@
>   #include "block/block-io.h"
>   #include "block/block_int.h"
>   
> +typedef enum PreallocateMode {
> +    PREALLOCATE_MODE_FALLOCATE = 0,
> +    PREALLOCATE_MODE_TRUNCATE = 1,
> +    PREALLOCATE_MODE__MAX = 2,
> +} PreallocateMode;
> +
> +static QEnumLookup prealloc_mode_lookup = {
> +    .array = (const char *const[]) {
> +        "falloc",
> +        "truncate",
> +    },
> +    .size = PREALLOCATE_MODE__MAX,
> +};
>   
>   typedef struct PreallocateOpts {
>       int64_t prealloc_size;
>       int64_t prealloc_align;
> +    PreallocateMode prealloc_mode;
>   } PreallocateOpts;
>   
>   typedef struct BDRVPreallocateState {
> @@ -79,6 +93,7 @@ typedef struct BDRVPreallocateState {
>   
>   #define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
>   #define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
> +#define PREALLOCATE_OPT_MODE "mode"
>   static QemuOptsList runtime_opts = {
>       .name = "preallocate",
>       .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> @@ -94,7 +109,14 @@ static QemuOptsList runtime_opts = {
>               .type = QEMU_OPT_SIZE,
>               .help = "how much to preallocate, default 128M",
>           },
> -        { /* end of list */ }
> +        {
> +            .name = PREALLOCATE_OPT_MODE,
> +            .type = QEMU_OPT_STRING,
> +            .help = "Preallocation mode on image expansion "
> +                    "(allowed values: falloc, truncate)",
> +            .def_value_str = "falloc",
> +        },
> +        { /* end of list */ },
>       },
>   };
>   
> @@ -102,6 +124,8 @@ static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
>                                       BlockDriverState *child_bs, Error **errp)
>   {
>       QemuOpts *opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> +    Error *local_err = NULL;
> +    char *buf;
>   
>       if (!qemu_opts_absorb_qdict(opts, options, errp)) {
>           return false;
> @@ -112,6 +136,17 @@ static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
>       dest->prealloc_size =
>           qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_SIZE, 128 * MiB);
>   
> +    buf = qemu_opt_get_del(opts, PREALLOCATE_OPT_MODE);
> +    /* prealloc_mode can be downgraded later during allocate_clusters */
> +    dest->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
> +                                          PREALLOCATE_MODE_FALLOCATE,
> +                                          &local_err);
> +    g_free(buf);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return false;
> +    }
> +
>       qemu_opts_del(opts);
>   
>       if (!QEMU_IS_ALIGNED(dest->prealloc_align, BDRV_SECTOR_SIZE)) {
> @@ -335,9 +370,20 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>   
>       want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>   
> -    ret = bdrv_co_pwrite_zeroes(
> +    switch (s->opts.prealloc_mode) {
> +    case PREALLOCATE_MODE_FALLOCATE:
> +        ret = bdrv_co_pwrite_zeroes(
>               bs->file, prealloc_start, prealloc_end - prealloc_start,
>               BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
> +        break;
> +    case PREALLOCATE_MODE_TRUNCATE:
> +        ret = bdrv_co_truncate(bs->file, prealloc_end, false,
> +                               PREALLOC_MODE_OFF, 0, NULL);
> +        break;
> +    default:
> +        return false;
> +    }
> +
>       if (ret < 0) {
>           s->file_end = ret;
>           return false;
ping v2

