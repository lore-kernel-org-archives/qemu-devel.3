Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790C2C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 17:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uedMe-0001Pc-7Q; Wed, 23 Jul 2025 13:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1uedK7-0001If-0b
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 13:32:12 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1uedK3-0005s6-UA
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 13:32:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4oBlcqph8cI0zRUUtAdPVfNM0jRFM8/gIPQCJnLRhkyMlFSBiD/pMZLuhionSDbZVeUs8fQxKkfuJIFmpOXxsCbdENzbsg8nKjyJJVLhCmiNgGnGTObPTvq1+//eVlRNXtqBAamziD8MyzvyFfDLtycSDutuk9+JVO5/6afL2MtfMeu97M1mS6i731YG+sFnhJuNULmw1nUyhVyuwNgnzeslJ5VCp73EG0DQJpLEBEz2gn/r/cQLXrqZEZ9LRLlHI7kNmDW5u53CX35lHls6B9D7vctVs3ndUXJhQjgDYL8qWs1ylMZ91soP1mCgZLdovMWQl4DW+2Vn5n0SVUG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3ivPwE6Lw4Wyf7hpg+/NQz+51c32aEi6IBvwL3X9mU=;
 b=L8hoLrePA9sjPg0sZg4T1G+0/EPKlnCyEcSsaTPEA8VWU3wsM7PCgPkHstOinHpeDsPjITVMnzuskgjQztRvKToeh9pi1mZYKiCLBR16OisH1D8FN3zSNoOB1x7xNRvLFWdzp1pAuHeNMpFp/JhHzFWSRIZ8f5cD0mfHxEMalm9djj4Kj0FJ9cnHTKPXLvqhmkyo5I2FlTACcYw5YqmNyo/bGa0GfxWskhHXqaZNnh3OTzxFmXoK7LG09Zq5hV3/UcIcI+1m/c/SbuuIZjTJZ/EG2cDUYozbu3aTjiYT615IYuMaGiNg9npi5NGa3iGeuU0PRzjbPPecIKpYu80LbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3ivPwE6Lw4Wyf7hpg+/NQz+51c32aEi6IBvwL3X9mU=;
 b=ezRP9PWMWwUhencVFAWKARSGOYyJq8odk9E7kCh4OBRvZGBE0eOVvOhcNrbCi2IySR8zPEXyRNJ/JHcs6NmLAuqN6nsrBO3EAc4HVp85Mc22DA8hQgq6mzisrMdCjRHCQLxPYTC4XLtwg3RDGk3RyNc5fQ+irRAU4CugEjQERIAc+gw1oE2mC2r9OuUWzT6hl5iixXeGcE+4c/Dg6PZf9sqavemNkHhmZJji1j983BM69PY5cdIG6+VqbtqBIfGLi9r/QKfg8g82D7ev9usciFW+qOsXvoRExalLxyth3ll17YBpNDIE+oV89OOIlvp2//RqjrQK2kQhRAri+F7u8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6957.eurprd08.prod.outlook.com (2603:10a6:10:2bc::10)
 by VI0PR08MB11170.eurprd08.prod.outlook.com (2603:10a6:800:251::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 17:32:01 +0000
Received: from DB9PR08MB6957.eurprd08.prod.outlook.com
 ([fe80::eb0e:8527:5bb3:a9eb]) by DB9PR08MB6957.eurprd08.prod.outlook.com
 ([fe80::eb0e:8527:5bb3:a9eb%2]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 17:32:00 +0000
Message-ID: <584056e0-0507-4a24-b4be-8f31ebc75f65@virtuozzo.com>
Date: Wed, 23 Jul 2025 19:31:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dump: enhance win_dump_available to report properly
To: Nikolai Barybin <nikolai.barybin@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250723170402.75798-1-nikolai.barybin@virtuozzo.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20250723170402.75798-1-nikolai.barybin@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0102.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::43) To DB9PR08MB6957.eurprd08.prod.outlook.com
 (2603:10a6:10:2bc::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6957:EE_|VI0PR08MB11170:EE_
X-MS-Office365-Filtering-Correlation-Id: 314fb27b-ede2-42ed-57b2-08ddca0ed491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0FVcjkrYlVkUEZyS0paSDVaYWRSaS9USC9HL09JT3FnS0dpL2VVbWFwRU5n?=
 =?utf-8?B?NDBQV1Arc3dQRGFWWmdXa0x3cG5nS0NaczV1RExHbXF6cFdoZDIvVWhuZjZR?=
 =?utf-8?B?M01id1RONURESERZVjRWNnpkK2ZoR1U1RjZ4aDZZcXBxaTNDMEVvRnA5Ykc2?=
 =?utf-8?B?MDdpQmJPY1VrT1RHWWxFalhtZk1ZeTQraTkzeDZYcVhIUzVYMlZPTEkvdnli?=
 =?utf-8?B?UWlSMnRIUGtLSmhHVWhCMG9vS2hWdjNLT2szRmtCYVpqTjZab1pkTFdHZ0JJ?=
 =?utf-8?B?QUhPYTAwNXhLeXlkMVRBcm1wT3o2MUNEOUJadGNDVXdMclpNeHF2WFF4U1do?=
 =?utf-8?B?djFqWVl0WnZTaXpRclJBdjJCMnEwZUZvWGhTY3FmY21uS1BEVDVkdFNlSTlp?=
 =?utf-8?B?WEJyRTJhSkN6TmpXUnpJS2F5L05zVWFDOVI2Z1JjRHpEbDYzeVUyakc5a2t0?=
 =?utf-8?B?T3ZqSzFuL3E4ZFZra2VRdGM1dWpTVEtkTC9kWmFSbGRRbFlmMy9QTjFISWZK?=
 =?utf-8?B?cFB6WnJuYS9FekIrcFZ6MnFaUDVvN0hCeG50M3JNNHp4N1FUcm5pZHNYYVFD?=
 =?utf-8?B?QitPUlcwWXBjMmRRVVRqcFBYTVBETDcvUE9uQmpGVTFKVlYxWjFtb3dna1gz?=
 =?utf-8?B?aTM1V3BMUFNDSzBZRXRwREtSdWxTdTE1TTlOSXh3em1PdFJDdUEwWTlwSUtx?=
 =?utf-8?B?NFN5NEdvMDcyMWg2cGV6OVluM0hOVXhTeUlTN0R6QWYyekpBbHZCbFdIMGJV?=
 =?utf-8?B?SHJ0NXlMQTBRV2hvdVQybkNidFl4TlRQc3Y2eXVyeG5GTVZyU2tqN2FpZVlk?=
 =?utf-8?B?SmxSdDlHU2NMRFIxbFVWckM5aUZHU1ZtbmxkeTZFVTNBNzNqZVlpbkZQS0Zp?=
 =?utf-8?B?dldVaDI5THd4M2JwbE1tbWpSVTZNSENleDE5V2xQVk1NV1MxREVXRlozYmlz?=
 =?utf-8?B?U2hoMit2SVdhR254bWU4RHBGNlgzYXlZOVgzaFpQWStsUiswMThpdk93TUt4?=
 =?utf-8?B?YzY2d2dBQU1OTkpscXpzdVVoQkwwdzArOUJoVFJSUytrNkdleEc0MkppVWJi?=
 =?utf-8?B?SGZYalFOWnNFZXJvQXlwU0xwUHpOcEZYYi9pVkNuVHBnQUlCMUNTbDh5N1hi?=
 =?utf-8?B?aXZHU3BZQnRXd1NEMU9Ddm10SngrNm1ZQUovTXhBUG9xU0U1N1dKT1U0cG5K?=
 =?utf-8?B?TGVHUFJQWno5WCtPVkRBYnRRK3hXaDVZT1F1eG5PbFNWQTZoWDZyakUvUVJo?=
 =?utf-8?B?MGt0Wk9RVU50Kzk0OXp0WDVyaGRsWE15djNXUlBDSUg2NGFMS0Y2SWwxZ3Jk?=
 =?utf-8?B?eHVhVTJSL1dnUUtSQTZDVWNvQml0MURBc1hXWDlqUkx5QlpjVkFlbCt6dXoy?=
 =?utf-8?B?L3VhRjRSLzhUalNyMmVWVEhUc0lJSjBNL1dRdk1lbzFpT3g0cnpYZUpjN0ly?=
 =?utf-8?B?dEVvQ2pEbk5DeXVSaDBvaFo2YmZSSzgwZFg3UUdraiswV2FlMm5KQlJJUmxm?=
 =?utf-8?B?Z01rK3ZacVRSWnJFZlZBSEtvdkFPbVpMYm5BbjdRSEhIeklTRExvNjE5clUx?=
 =?utf-8?B?cEUwYnJJUFlwQVZDWTNuQm5idFlEazZIazlCMzlVV09qVnhpSDNBTXJXb2RM?=
 =?utf-8?B?RmhuZEdCU002RXAzUEI5MTJibVVPeWRzWTJsODFPVlRmdmtPVndOMkFmNHlN?=
 =?utf-8?B?RitQRzZGWDQvZDdZSk9XNFdFaFgvSm9QZWJYK3NNd1J3VXV2b3VDT1I3Mktr?=
 =?utf-8?B?RTdRTHVhdUxXVVZRcDVpazdweThhbUpUMDJrYzhyTjhRZ0NiLzdXK1UydUtW?=
 =?utf-8?Q?jsIIvHCja2APOVifgH9/l3S6tTVqTTntpQzwE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR08MB6957.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a054cjl4eGRRVEQ3S0ZBS2tNUzNRR0pUbVlaTW1lMGdZRGdxbjJlVjVKNStG?=
 =?utf-8?B?b2dybWx0clV2UlFaZmx0YkFXWG9TVXlIRmZTamdHbzV3L1A5V1lFUGY3THhD?=
 =?utf-8?B?U0lLRTdVdE5GeXBpUnZNMHpZenByWFRFcEFRaWNuM1JnbkhQeXpyUW5SMFlt?=
 =?utf-8?B?WUI2Wmw0ajlKc3dxNVJMeUc3WGd5T0FqaG9vR044WGFTdlM3WDZHUDVDaXgw?=
 =?utf-8?B?eVQ3YS93QVV4eE9qbHgzNkpIWG1JRDVseno3Tk5KQ0xLNUtLaXE4OWV2ZkpF?=
 =?utf-8?B?cENYMzZVLzREUGFyS3pSRlZ5ckxFN1JuaS9qclZNeFdQcnpUOUR1bVJBS3Z6?=
 =?utf-8?B?THRac0RUcS9SNDY5L1NWYm53bHBpdGg5WHhPWHh1bnpzNUJTWWtlUnZONm54?=
 =?utf-8?B?UTk1NHVpV0VpWDV3TlFtZEFHNVZTQjlGaHBOLzA4YjBEUm5JTEt0M3BuTE9v?=
 =?utf-8?B?ajNhZ2ZMMTk5THVMMW8yaVc1a3laU1FXQW1GVmMrZVJkbkh2Q3oyQ0thYlJo?=
 =?utf-8?B?M3pQaDJicGlua0drdmhxbTNZTStpQjQydkdWeVdMc0IwY0RHeTFjQS80TTRy?=
 =?utf-8?B?RUgwOHE1UlVjUHllYzZOdUhJZlZjV1AwZ0RIMHZZWXl0Y0NRaTdDOVg0cUVR?=
 =?utf-8?B?QW5hanVKcGMwSk14by9YbEtWM21idWZ3MUFacnpsamVtcnVST1c5ZytzdHdQ?=
 =?utf-8?B?WTJYNStpak5WbzZ6ZVZuZXJCWSt3L25WbWVjT2p4ckVKZDVEbVZCK3RVQ1lp?=
 =?utf-8?B?Q3hHOW1VQVkybk5YY2V6ckNFdEdDSGprRE90NnBnQ20xZzBwemRuZnNYSHJU?=
 =?utf-8?B?UnlpaFpZVDVqZmQ2bElPTHFhbGF4WXI3cnhiNXJEeDZCK2loN1RhNHJQSStt?=
 =?utf-8?B?UktESUQxWVVuNWpCSC84cUUxa2tyWE5iOTN6Smpmckt5eGJwcUtPT3VsWUxN?=
 =?utf-8?B?YUEwTjNyak9nRTducjZ6U0pZS2dXelhkMWpmZEcwRWZ5K0s5eWRmeVZJTUsv?=
 =?utf-8?B?SFpicEtZOUd1M2NnYmlrVDR4TjgyOEN0dFo4Ry96cEFyaXBNNk01ZnBaVnNH?=
 =?utf-8?B?Z3Q1NkpvV3NKZmwxdWp6WElDTG5NSGs4MjY0NnM0aG5DazVsU1ExYXV2T096?=
 =?utf-8?B?MEM0UEhVbkhJRGZzMk1YYUcxanpseGNYOHAxT0NXM1hSSFREaHBCL3RpTWtN?=
 =?utf-8?B?WVZQMCsrOFBTSTNvbVZybEtzcHk5dUlvZ3lhWmpJdjhyUHR5Z05qQzltQUw5?=
 =?utf-8?B?TXRhNm9DS2tnd3NHYXhOeHNwM0JBVXRndFZHb1dQb2pGUUhlUkkwRjNCSXZR?=
 =?utf-8?B?SWN2V3ZLL0QxMzdzaktuSDZ6OHIreEIxWWFxQXlsNkRJcDBLMHRVdEIyQzRX?=
 =?utf-8?B?djhDZ0xPT3pwT0d2ZkU3a1lMM1lxd1QvQTk1WVlNT1ZWOTcvQkR1c2J5bXpq?=
 =?utf-8?B?T1l4dXU3cEM1eHVhalBjQU52OEJ6VzgyaWZKMTlzS2J5REw5S0lQSEg5bVlt?=
 =?utf-8?B?eUR5Yk9rWldQd1hLZFVaRndtVFMxS1VmR0t3UFhKR3hYcjhGYWtad3BlRVN3?=
 =?utf-8?B?WnkwZDhDVk1EdWppUmNwNmx1L1ZldXYwZVBRK3BuNkxMTmF5QU9lek9Bakpn?=
 =?utf-8?B?MzRvRUlrK1NkQ2x4cUtMWGtZZXozaWc0UE1GcnduYTBLTWk0di9VTXBXVkNR?=
 =?utf-8?B?dDFQQU5QRUZ2d2VCczRaR2F2RC8rYzdFWHlyWm04U1BWYlF3NVhEWHBLV0sw?=
 =?utf-8?B?KzVjQjlqQUVLOGQwRmVYTEgxUlNXTXhrSFlUNU92N2F3Y3ZkYzR5ejZIRDI4?=
 =?utf-8?B?czFKMGVkdHhnOXlvU3lLOXVsSnQxNklsVWlNRkMrempSc1lrcStYSSswWkJO?=
 =?utf-8?B?cnlTVWdJUVdNbzNsa201TURqMHgrZE93M3hXcGtXRDJOUHVFcFRVZTJOMXlX?=
 =?utf-8?B?bW5tbVRmc251aUdTemZ1NW9TUGVPYjZZczFlcVVQcytxUUN6OHNFZE0rSkNM?=
 =?utf-8?B?TjFiZW5VQnMwZEM2bXR3dlpkOGJqbkxHSXJhbTI1NmJoZW1pRlNhLy95Zndp?=
 =?utf-8?B?S29lTWRKb1hCK05BK2RhY0FPemZOUnNyd2w2TjZNbVdvcTU3Ty9NZkF1Mits?=
 =?utf-8?Q?imgWLEBNVaRxUVmUYCFmdsQM5?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314fb27b-ede2-42ed-57b2-08ddca0ed491
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6957.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:32:00.9209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+UCcf/dwV6XgQ9td3+anvOR5aS9y9ILHlKHHJ/nqWtIIeMGOsLnINZmrALJh4QT5pK3xz/uk41peUwJCz+s5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11170
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 7/23/25 19:04, Nikolai Barybin wrote:
> QMP query-dump-guest-memory-capability reports win dump as available for
> any x86 VM, which is false.
>
> This patch implements proper query of vmcoreinfo and calculation of
> guest note size. Based on that we can surely report whether win dump
> available or not.
>
> For further reference one may review this libvirt discussion:
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
> [PATCH 0/4] Allow xml-configured coredump format on VM crash
>
> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
> ---
>   dump/win_dump.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
>
> diff --git a/dump/win_dump.c b/dump/win_dump.c
> index 3162e8bd48..4bb1b28e63 100644
> --- a/dump/win_dump.c
> +++ b/dump/win_dump.c
> @@ -14,14 +14,74 @@
>   #include "qemu/error-report.h"
>   #include "exec/cpu-defs.h"
>   #include "hw/core/cpu.h"
> +#include "hw/misc/vmcoreinfo.h"
>   #include "qemu/win_dump_defs.h"
>   #include "win_dump.h"
>   #include "cpu.h"
> +#include "elf.h"
>   
>   #if defined(TARGET_X86_64)
>   
> +#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
> +    ((DIV_ROUND_UP((hdr_size), 4) +                     \
> +      DIV_ROUND_UP((name_size), 4) +                    \
> +      DIV_ROUND_UP((desc_size), 4)) * 4)
> +
>   bool win_dump_available(Error **errp)
>   {
> +    uint64_t addr, note_head_size, name_size, desc_size;
> +    uint32_t size;
> +    uint16_t guest_format;
> +    uint8_t *guest_note = NULL;
> +    size_t guest_note_size = 0;
> +    VMCoreInfoState *vmci = vmcoreinfo_find();
> +    ArchDumpInfo dump_info = {};
> +    GuestPhysBlockList blocks = {};
> +    int ret;
> +
> +    if (!vmci || !vmci->has_vmcoreinfo)
> +        return false;
> +
> +    ret = cpu_get_dump_info(&dump_info, &blocks);
This will not work IMHO. cpu_get_dump_info tries to operate
with a real guest memory, which is not provided. This means
that guest executable is impossible to find.

For me this is looking like Windows dump could not be enabled
after the patch.

> +    if (ret < 0)
> +        return false;
> +
> +    guest_format = le16_to_cpu(vmci->vmcoreinfo.guest_format);
> +    if (guest_format != FW_CFG_VMCOREINFO_FORMAT_ELF)
> +        return false;
> +
> +    size = le32_to_cpu(vmci->vmcoreinfo.size);
> +    addr = le64_to_cpu(vmci->vmcoreinfo.paddr);
> +    note_head_size = dump_info.d_class == ELFCLASS64 ?
> +        sizeof(Elf64_Nhdr) : sizeof(Elf32_Nhdr);

note_head_size assignment could go to if below saving conditional

> +
> +    guest_note = g_malloc(size + 1);
leaked at the end of the call

> +    cpu_physical_memory_read(addr, guest_note, size);
> +    if (dump_info.d_class == ELFCLASS64) {
> +        const Elf64_Nhdr *hdr = (void *)guest_note;
> +        if (dump_info.d_endian == ELFDATA2LSB) {
> +            name_size = cpu_to_le64(hdr->n_namesz);
> +            desc_size = cpu_to_le64(hdr->n_descsz);
you are going to use these values as integers below,
thus it is required to do conversion from the guest
endianity to the local one, i.e. le64_to_cpu


> +        } else {
> +            name_size = cpu_to_be64(hdr->n_namesz);
> +            desc_size = cpu_to_be64(hdr->n_descsz);
same as above

> +        }
> +    } else {
> +        const Elf32_Nhdr *hdr = (void *)guest_note;
> +        if (dump_info.d_endian == ELFDATA2LSB) {
> +            name_size = cpu_to_le32(hdr->n_namesz);
> +            desc_size = cpu_to_le32(hdr->n_descsz);
same as above

> +        } else {
> +            name_size = cpu_to_be32(hdr->n_namesz);
> +            desc_size = cpu_to_be32(hdr->n_descsz);
same as above

> +        }
> +    }
> +
> +    guest_note_size = ELF_NOTE_SIZE(note_head_size, name_size, desc_size);
> +    if (guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE64 &&
> +        guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE32)
> +        return false;
> +
personally I prefer
return guest_note_size == VMCOREINFO_WIN_DUMP_NOTE_SIZE64 || 
guest_note_size == VMCOREINFO_WIN_DUMP_NOTE_SIZE32;

>       return true;
>   }
>   


