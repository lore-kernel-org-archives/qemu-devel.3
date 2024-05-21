Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBDCC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9N4b-0005m6-3y; Tue, 21 May 2024 06:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9N4Z-0005le-LI; Tue, 21 May 2024 06:50:23 -0400
Received: from mail-db8eur05on2071f.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::71f]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9N4W-0007FA-5p; Tue, 21 May 2024 06:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/M3OCSEOBaVxBMJNz4EmsEN9747ag/8AZXDO0u0P+H3Em/HyE2sLkFe60WOdutGXWMi3DgLG9wicoHhMY7RCAOglXlU9dWz5ooevIJc9in2kqd5ECoEG7Wd54dmWiagwZC0OCgFCjpi3DZNywyTub9IdAtsbjxHP1BYsDK/9XnPrHa4VnYdyIhj+b2ob7gCQqnD+DGDE6LtNpzD9Q4rM/fJbxAG8pHh1a7UYwiuzNEh02zzauWt+lpXJJt1C/V2hotQNKSn+DzmdnQ2P6IuhLzyA8rjE+QZ6VFshhx6JDfrZ1YtCsmpvzD+/N3Y3BUJpDLr4Lv59u90u55Ico1zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVMpI92TMyyIfj6scHsxQYW606HpzP+9v8Ko7PObq5c=;
 b=oK7s5XVzABAzmbQsRYdNqhsak/HddSSLE7DdPiY4Fbl9YqTzsqXkZ3cm2nQprwEbCHlK3NybmMw0p6d62JfoUNodJKYncT1SG1mwa1Gb0VoFIi+nYbUiwjtMggHjvUbHZYblP+/C3DKrK8P4hlD21JGSKcWLpZYD/zAN0HC4Vl2St6wfaoG2P/y/Nje7ZX2a2q2lC3vemWqXKBU6cfUKn/3iAPbQVpgchDTOH5lXz9ul2PCBTR1Ib4oK1gawQ1cUzWE+z9lAubPCV/A5eEK3OGrhUs7P5IQMQFF60GiJ2reeel/SEY9AXvkYATJhQDm6cel3CjwCmvWmZxBwcfrudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVMpI92TMyyIfj6scHsxQYW606HpzP+9v8Ko7PObq5c=;
 b=Ew+V1Bmrb9vHoo9aovrM+wYPEXVC9TL55G1kCTVX1grba+6U6cbhsRqmX+v2AMBVJVy7d+O0iVu+Gr49nOYaWsAcDLc3DGfbyTWVRsgNhE4PYGS+eyovdMk81Xbm8W7gD9vrHqRhP25gvthIPyxlhqjFVGX7yZ/2e3+twXZtySw806ixafTY93TbVowp8lOj5x5MJJZEl9QaG6MTRnCoNim/FzJnSXxRVyZv+3BTBeHxh45uNtjFSBgjMhnNRkJUeDXVjskBHG8icwNJ17wgTvaBSRBOCyK53lFM/Cm/IZeB42eDGj7IXuO/lmGsfw4mSOUDUMPRZXt/6TAEE/3AIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB8490.eurprd08.prod.outlook.com
 (2603:10a6:20b:567::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 10:50:14 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 10:50:14 +0000
Message-ID: <9bad51d1-979b-432f-b77b-945b6d988e94@virtuozzo.com>
Date: Tue, 21 May 2024 12:50:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] iotests/271: add test cases for subcluster-based
 discard/unmap
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-12-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240513063203.113911-12-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::6) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 4222386e-6916-427b-ca06-08dc7983cba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDdDWWNVTkZCZk5vRHBFZkFQS2lkc0lDRW5yY2NFV1l4c0NDQlVIZEFvQU1m?=
 =?utf-8?B?ZGYvczdyS0dwakJJbVlzQU92Y1RjdmVYNmYxdnZaS2Y4Nm81TWIzcGYrY2JZ?=
 =?utf-8?B?YzlGY0NKb04xNVFBRzFscDdWWmJaSHZtbmhoWXZHNVpxcWdlalgrRFpnVWtM?=
 =?utf-8?B?YWsxRE9pWjF6NzJHdGhvRlZJTGd1NGVxR24rN2N5c2FLWUN6bkdEdS9FMnNH?=
 =?utf-8?B?eDZjU2VhQ1Ftb0w1TWcyUHVvR3ppaFpHOUt5TjQvbVNOaEVLaG5HaHBpRXVQ?=
 =?utf-8?B?aFlDYWFsYlZIelBlRGZPWVljaUo0NGF1dHBIU1krbzN0U0l3a2xIWWZ2L05V?=
 =?utf-8?B?Zk1xYnhPbENtV1B3ZEVUZDNOODBReTYrZWZkQzNmWkh1QjZrZEhHTGJxRzEx?=
 =?utf-8?B?b2lWYjRXMTFOb0wyK1dVektObElwNkpJcGE1UmJWK1VBTklUcHNZaHFhV2xl?=
 =?utf-8?B?TDZydUFFRVh2VGdMQXY1em1SQk95RWR6YmVDemZHVlJmWDJJclFPWkUxdnNp?=
 =?utf-8?B?UHl2UzhCbmhnTW1HZWV4OG93RmVpcGEyWWRoL0x5Njh4b1JONmZkQlZoUlpF?=
 =?utf-8?B?V1NTSHgyMmJiOVdzckV2WVBLRFRTWnJOc3VZeG1nV0dWT3JUTWRNd3FZWDkr?=
 =?utf-8?B?L01lejJmbXJpajFxejR1ckVkVmpETUZoeXVhT1Flc3EyeE1pU3ZVRHV5dmdP?=
 =?utf-8?B?a01pRk1WZFl1NVoySW5OcFBrRHIzcEwzaHR0U292MTltUEtrOS9SU1NLZGNj?=
 =?utf-8?B?TWNpOHhiVEthTDJsS1pzY2tia09ocFUxdnFuRVFvQW1EbzhFM21CVk92YTZs?=
 =?utf-8?B?ZzE5bGxMTTQrYmhTZ2wrZVREYWlmaTlrOERlczJUU1prUDZUN0NLSWJYeGJJ?=
 =?utf-8?B?bDhua1ZGZFRFNmdOSGVxaVZpanpFOE9nT2VzUXRKdEMrWExsVjdqM2MraHk5?=
 =?utf-8?B?OFBzMVFLSXhJYVp3S1psNjUvbi9MZFFIQXpqYXNFbmdZNzFQZkprUjE3Mmkx?=
 =?utf-8?B?eml1eXRCMEhsNW9SOEdTVS9ZbGc0bENTV3BLclg2ckUvNXJqOU5qUVJ3N2dj?=
 =?utf-8?B?Y0tDYUNIdkh4OTlodnpPYVlYbFVjejFWSTdaMVpSQVFVbHJRMzlINVRJRmN6?=
 =?utf-8?B?Z0RpeVd1czdxZk9jbDZxa3pUYWk0NG96RGc1TTRNSFlFZ0l3Kzd0TXVHb1RO?=
 =?utf-8?B?VDloYU9xYjFXSUk1NDZ3OS9WWWUzWnNLK053SHRkRFJsTFlZck5mcjV6ck9x?=
 =?utf-8?B?QXMrLzdXU1ZiUnpCalJrZXlnL05FUklSdjRTTmdtNTVESjBJUS9vUEltdmE1?=
 =?utf-8?B?WFZ6SDMzd3FZcktVTVYxa1VTVitKd2d6T3hhR2p4WGVyM3k4REY2eENVMzhq?=
 =?utf-8?B?aG1FS2EycmRnQy9UOFp2NmljMlBKenl3dFVOTzVRbTlObnVsakYwbTEwZTJz?=
 =?utf-8?B?c3J5V2owZXBUS05oVzY1bmI1RFFDSEVZQlVzaFJ1Mk4vVklwU0RBZHNXZHBi?=
 =?utf-8?B?eUFNbzlkZ1BlemppektlbGREY3d2bGIycXlleTF2L1VQMW1acVljYnoxYnJw?=
 =?utf-8?B?aGRueHdMeHNSb2xEcWsrdklZc3Y0U1VYZGtPSzFTMHZQdFB3cmNwempXTVhI?=
 =?utf-8?B?bCtlVHBRUncrK0V2N3ZQM2VmR3E2aUIycktOOVAydkVmZTB0Z016YWZveWRp?=
 =?utf-8?B?ekp2Y1F4dk03bWcrQ3ZlWXRtNXJGVElLOGxwWjBVZHZrZ0JvbTBuSnBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRHRzZzZmZKQ1UxckFEdUljdlArVTNzcDFydWlRTWxEL0NyOXoxK0dRYUVw?=
 =?utf-8?B?OFlXRkVvMFo2OW1Oem5Ka2JUZUtDVkh2cWFOMFl1MngxYzlsZ05nL3BKdGc1?=
 =?utf-8?B?ZVF1WXRIYWtLaXpicHQ4MnRHYU50Ym82ZDBjY25zMGt2RzlwTm1uYVNmbzJv?=
 =?utf-8?B?VjJsdFZkWVR2OXZSZGFnYWZ0OVU3MUNSZFlXcDMrVnVjblpvL0x6RWRxWXVG?=
 =?utf-8?B?QzgrWXN2ZGtlNTdqNG1XQ3hGQzBFRDVoRjdmVlZaUDZsL2ZoRnJSNkZTbjVW?=
 =?utf-8?B?RERZcmJUOFR0dVRuWFNkR3Q0NW9CUWxQUFZTSmxMamt6VzRCdG1teW5ZZnZZ?=
 =?utf-8?B?MDY3ZVFoSkgxcVNXVzhVZ05vMUtNeDhkSnVhMUEyZGtFV2R1SE1wQzVEWEUy?=
 =?utf-8?B?NVpaZkRCVzlYNCt2N01TZXFWTkI2SXRoWENiTGlLZ2xRSCtFQXcwMXQvOGlP?=
 =?utf-8?B?UnFFMHdKaU42NkRSQmRNeXA4Z1Bod1d1enpWRTlvWW9yNVA2Q1R1aEswdERz?=
 =?utf-8?B?eW94SDY4SFB2MkZiZm5wWVBoc2JZNHZWZnYyQnFSbjdOaXkzaEdQTTRTZW1O?=
 =?utf-8?B?N3BHZnQxalNKcWNLWnJMOEoyamdZMkZ0OVVCYlovbEd0TGJjN0ZUbWhGOFZZ?=
 =?utf-8?B?eUNHVlBRZ1c0WHIydTltSFRkMjI2V09RdGhTTXl5K2RNTUJ5bUtHelBxbDN4?=
 =?utf-8?B?aEE4MVk4NzQwemxXcWU4R2I4MHBhQWY2S2VGcVlKQUE3cnhNdVU2aGxWelpB?=
 =?utf-8?B?aG9GdTFFL3BoZXlReUUrWGJDWENFYzlJQTNCaitsbTQ3dG01a0lMdlJBR2JC?=
 =?utf-8?B?TXkyQ1R4a1lCVzJrb25kZ3Q3M3hrdTN2R1E4RWEyV1dOd0lzc0s3bjNvZDVp?=
 =?utf-8?B?Sm92SFBBTXZCWHdOVDBBcFc3Y2VxZWZJcXZnZXNlQmVRRFlJcDFyVWtoV3JD?=
 =?utf-8?B?Y1JuZ1dOSnh2dU1Ic0tKSTIvbkNkNXlaV2VmZlVXWnFzR1RxOEllb096T0F4?=
 =?utf-8?B?VUtFNlNUVGJ0emw5bTVVRlMyR2NyNU5MdXpyY2xxWEppV3MrelBaaDdzVVlR?=
 =?utf-8?B?Yng0U1BNN2VXb21nN0xjbEJpYk4zcmttSzVDYlI1YTF3U1c4T2VSYTNTRzg5?=
 =?utf-8?B?RmZZR29EdVh2VFhQWGZ3aVAwTlB6NW1JSEozVWxMekxZNCttNmZIeUxoY1Jt?=
 =?utf-8?B?UzkxbWYrTGx6QXRTdTVxUTdUbG5CVWRibVcya0xGR0w4K3ZaTmlKRXdmWEFM?=
 =?utf-8?B?QmRNWmN0T0FUZC95Mk9ORTV3dXlPT1NCSm1EQXBKK3Bkc1hDbTdFNm5iU2FO?=
 =?utf-8?B?MnVvb2xCSGJXdkZVWDU4c1orK2ZqTWFQVExtOTFKa2FLWlU0WGhJVm1PZWI2?=
 =?utf-8?B?NlhmckRhc3dxMXZXVFhDNVRNVGFmUHdncnhSZGRnNzRvT2dIY1ByYnl3U0Nt?=
 =?utf-8?B?eklWNnR2anFQQkovVzMvOTQrM2ZrR2Z2TnY5MEMvcFEyTXBPT3lmbjRSNEF0?=
 =?utf-8?B?d1EvcCsvU0h3c2YwaUtadHlTV2FDcjluTzhlVmNMQTBpMGFkYWRwTHdKMWJ0?=
 =?utf-8?B?ejdnV2NTaTBXaWxNaGs4L1BiVkxUZXdJNzJrQTdSYzJDMTBTRFYzT3hLU05J?=
 =?utf-8?B?elpRSUJyZjJVQ1NWeUtvbjlnd2pMNTE3d3dZcFcwdENFY1hjS3pqaHp2eGpN?=
 =?utf-8?B?RmhMOFNML29MeDRnMVNPUmJWdGpOS3UzUm5Pak55ZmFjNWFEQTdSS20zUmNu?=
 =?utf-8?B?TWFCK0QzME45MFQrQVduQTVnY09UcDBNNkZwR011c2txamhpVVRKVTQxQ21T?=
 =?utf-8?B?YStCNnIvVWQwUGowbXZneWdraFlSK21BQnNZNHUwOVhOaEJaU2oxYWFUNzJj?=
 =?utf-8?B?YXVLWTg3L0NHQngxMWNOaGxtTDZVTnYxQVo4SFhZenRMQjRxcUlOb1NwVjdI?=
 =?utf-8?B?Y3hScEVzaG9hTFQyVHU1c3c5NkRTcmx2Lyt3NWVGZEZWVDJESHVaMHUyVHhP?=
 =?utf-8?B?T0tZTGVDNU5FYzc5SnN3VGt3TUN4M2lLcHQrWmc1SHo1bmYyQVYzZnpFODRo?=
 =?utf-8?B?L1JxcTB6RGpja2czd1RKT3N1MW5tcUNSclAzRVAwaGxhVEhUblpEdmJuRFJC?=
 =?utf-8?B?dmcvZ0dzc0lkQ2JKRXZ6S0F0TTRSOTd6REwybUFWSFNEczNZWnpUdVpzZ3A3?=
 =?utf-8?Q?rV+awzoQ2qnh7TAgPRIkMNg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4222386e-6916-427b-ca06-08dc7983cba4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:50:14.5050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I83sAolrSc9OyDAJYBmSaGUKOF7UJHwm0jUXFawqG4390kTZlFq9l6fwjSlEIdFwociqO8WRWu03ULZNeeuWt8++uQwqkTy0CRfkxRGkYJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8490
Received-SPF: pass client-ip=2a01:111:f400:7e1a::71f;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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



On 5/13/24 08:32, Andrey Drobyshev wrote:
> Add a bunch of test cases covering new subclusters behaviour: unmap of
> last allocated subclusters; unmap of subclusters within unallocated
> cluster; discard of unallocated subclusters within a cluster; regular discard
> of subclusters within a cluster; discard of last allocated subclusters.
>
> Also make all discard/unmap operations enable trace point 'file_do_fallocate'
> so that actual fallocate() calls are visible.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/271     | 70 +++++++++++++++++++++++++++++---------
>   tests/qemu-iotests/271.out | 69 ++++++++++++++++++++++++++++++++++---
>   2 files changed, 119 insertions(+), 20 deletions(-)
>
> diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
> index 04c57813c2..8b80682cff 100755
> --- a/tests/qemu-iotests/271
> +++ b/tests/qemu-iotests/271
> @@ -81,6 +81,12 @@ _verify_l2_bitmap()
>       fi
>   }
>   
> +# Filter out trace params which we don't control (file fd)
> +_filter_trace_fallocate()
> +{
> +    sed -E 's/fd=[0-9]+/fd=N/g'
> +}
> +
>   # This should be called as _run_test c=XXX sc=XXX off=XXX len=XXX cmd=XXX
>   # c:   cluster number (0 if unset)
>   # sc:  subcluster number inside cluster @c (0 if unset)
> @@ -94,12 +100,13 @@ _verify_l2_bitmap()
>   #      discard  -> discard
>   _run_test()
>   {
> -    unset c sc off len cmd
> +    unset c sc off len cmd opt
>       for var in "$@"; do eval "$var"; done
>       case "${cmd:-write}" in
>           zero)
>               cmd="write -q -z";;
>           unmap)
> +            opt="--trace enable=file_do_fallocate"
>               cmd="write -q -z -u";;
>           compress)
>               pat=$((${pat:-0} + 1))
> @@ -108,6 +115,7 @@ _run_test()
>               pat=$((${pat:-0} + 1))
>               cmd="write -q -P ${pat}";;
>           discard)
> +            opt="--trace enable=file_do_fallocate"
>               cmd="discard -q";;
>           *)
>               echo "Unknown option $cmd"
> @@ -121,7 +129,7 @@ _run_test()
>       cmd="$cmd ${offset} ${len}"
>       raw_cmd=$(echo $cmd | sed s/-c//) # Raw images don't support -c
>       echo $cmd | sed 's/-P [0-9][0-9]\?/-P PATTERN/'
> -    $QEMU_IO -c "$cmd" "$TEST_IMG" | _filter_qemu_io
> +    $QEMU_IO $opt -c "$cmd" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_trace_fallocate
>       $QEMU_IO -c "$raw_cmd" -f raw "$TEST_IMG.raw" | _filter_qemu_io
>       _verify_img
>       _verify_l2_bitmap "$c"
> @@ -202,9 +210,10 @@ for use_backing_file in yes no; do
>       alloc="$(seq 16 31)"; zero="$(seq 0 15)"
>       _run_test sc=0 len=32k cmd=unmap
>   
> -    ### Zero and unmap cluster #0
> +    ### Zero and unmap second half of cluster #0 (this will unmap it and
> +    ### discard l2 entry)
>       alloc=""; zero="$(seq 0 31)"
> -    _run_test sc=0 len=64k cmd=unmap
> +    _run_test sc=16 len=32k cmd=unmap
>   
>       ### Write subcluster #1 (middle of subcluster)
>       alloc="1"; zero="0 $(seq 2 31)"
> @@ -439,6 +448,12 @@ for use_backing_file in yes no; do
>       _verify_l2_bitmap 16
>       _verify_l2_bitmap 17
>   
> +    # Unmap subclusters #0-#3 of an unallocated cluster #8.  Since
> +    # 'write -z -u' doesn't lead to full discard, subclusters should become
> +    # explicitly zeroized
> +    alloc=""; zero="$(seq 0 3)"
> +    _run_test c=8 sc=0 len=8k cmd=unmap
> +
>       # Cluster-aligned request from clusters #9 to #11
>       alloc=""; zero="$(seq 0 31)"
>       _run_test c=9 sc=0 len=192k cmd=unmap
> @@ -523,26 +538,45 @@ for use_backing_file in yes no; do
>       echo
>       echo "### Discarding clusters with non-zero bitmaps (backing file: $use_backing_file) ###"
>       echo
> +
> +    _reset_img 1M
> +
> +    # Write first half of cluster #0 and discard another half
> +    alloc="$(seq 0 15)"; zero=""
> +    _run_test sc=0 len=32k
> +    # When discarding unallocated subclusters, they only have to be
> +    # explicitly zeroized when the image has a backing file
>       if [ "$use_backing_file" = "yes" ]; then
> -        _make_test_img -o extended_l2=on -F raw -b "$TEST_IMG.base" 1M
> +        alloc="$(seq 0 15)"; zero="$(seq 16 31)"
>       else
> -        _make_test_img -o extended_l2=on 1M
> +        alloc="$(seq 0 15)"; zero=""
>       fi
> -    # Write clusters #0-#2 and then discard them
> -    $QEMU_IO -c 'write -q 0 128k' "$TEST_IMG"
> -    $QEMU_IO -c 'discard -q 0 128k' "$TEST_IMG"
> +    _run_test sc=16 len=32k cmd=discard
> +
> +    # Write cluster #0 and discard its subclusters #0-#3
> +    alloc="$(seq 0 31)"; zero=""
> +    _run_test sc=0 len=64k
> +    alloc="$(seq 4 31)"; zero="$(seq 0 3)"
> +    _run_test sc=0 len=8k cmd=discard
> +
> +    # Discard remaining subclusters #4-#32.  This should unmap the cluster
> +    # and discard its l2 entry
> +    alloc=""; zero="$(seq 0 31)"
> +    _run_test sc=4 len=56k cmd=discard
> +
> +    # Write clusters #0-#1 and then discard them
> +    alloc="$(seq 0 31)"; zero=""
> +    _run_test sc=0 len=128k
>       # 'qemu-io discard' doesn't do a full discard, it zeroizes the
> -    # cluster, so both clusters have all zero bits set now
> +    # cluster, so both clusters have all zero bits set after discard
>       alloc=""; zero="$(seq 0 31)"
> -    _verify_l2_bitmap 0
> +    _run_test sc=0 len=128k cmd=discard
>       _verify_l2_bitmap 1
> +
>       # Now mark the 2nd half of the subclusters from cluster #0 as unallocated
>       poke_file "$TEST_IMG" $(($l2_offset+8)) "\x00\x00"
> +
>       # Discard cluster #0 again to see how the zero bits have changed
> -    $QEMU_IO -c 'discard -q 0 64k' "$TEST_IMG"
> -    # And do a full discard of cluster #1 by shrinking and growing the image
> -    $QEMU_IMG resize --shrink "$TEST_IMG" 64k
> -    $QEMU_IMG resize "$TEST_IMG" 1M
>       # A normal discard sets all 'zero' bits only if the image has a
>       # backing file, otherwise it won't touch them.
>       if [ "$use_backing_file" = "yes" ]; then
> @@ -550,7 +584,11 @@ for use_backing_file in yes no; do
>       else
>           alloc=""; zero="$(seq 0 15)"
>       fi
> -    _verify_l2_bitmap 0
> +    _run_test sc=0 len=64k cmd=discard
> +
> +    # And do a full discard of cluster #1 by shrinking and growing the image
> +    $QEMU_IMG resize --shrink "$TEST_IMG" 64k
> +    $QEMU_IMG resize "$TEST_IMG" 1M
>       # A full discard should clear the L2 entry completely. However
>       # when growing an image with a backing file the new clusters are
>       # zeroized to hide the stale data from the backing file
> diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
> index 0b24d50159..c03e4c9bc2 100644
> --- a/tests/qemu-iotests/271.out
> +++ b/tests/qemu-iotests/271.out
> @@ -29,14 +29,17 @@ L2 entry #0: 0x8000000000050000 ffffffff00000000
>   write -q -P PATTERN 0 64k
>   L2 entry #0: 0x8000000000050000 00000000ffffffff
>   write -q -z -u 0 32k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=32768
>   L2 entry #0: 0x8000000000050000 0000ffffffff0000
> -write -q -z -u 0 64k
> +write -q -z -u 32k 32k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
>   L2 entry #0: 0x0000000000000000 ffffffff00000000
>   write -q -P PATTERN 3k 512
>   L2 entry #0: 0x8000000000050000 fffffffd00000002
>   write -q -P PATTERN 0 64k
>   L2 entry #0: 0x8000000000050000 00000000ffffffff
>   discard -q 0 64k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
>   L2 entry #0: 0x0000000000000000 ffffffff00000000
>   write -q -c -P PATTERN 0 64k
>   L2 entry #0: 0x4000000000050000 0000000000000000
> @@ -71,14 +74,17 @@ L2 entry #0: 0x8000000000050000 ffffffff00000000
>   write -q -P PATTERN 0 64k
>   L2 entry #0: 0x8000000000050000 00000000ffffffff
>   write -q -z -u 0 32k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=32768
>   L2 entry #0: 0x8000000000050000 0000ffffffff0000
> -write -q -z -u 0 64k
> +write -q -z -u 32k 32k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
>   L2 entry #0: 0x0000000000000000 ffffffff00000000
>   write -q -P PATTERN 3k 512
>   L2 entry #0: 0x8000000000050000 fffffffd00000002
>   write -q -P PATTERN 0 64k
>   L2 entry #0: 0x8000000000050000 00000000ffffffff
>   discard -q 0 64k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
>   L2 entry #0: 0x0000000000000000 ffffffff00000000
>   write -q -c -P PATTERN 0 64k
>   L2 entry #0: 0x4000000000050000 0000000000000000
> @@ -301,15 +307,20 @@ L2 entry #14: 0x80000000000a0000 00000000ffffffff
>   L2 entry #15: 0x80000000000b0000 00000000ffffffff
>   L2 entry #16: 0x80000000000c0000 00000000ffffffff
>   L2 entry #17: 0x80000000000d0000 00000000ffffffff
> +write -q -z -u 512k 8k
> +L2 entry #8: 0x0000000000000000 0000000f00000000
>   write -q -z -u 576k 192k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=196608
>   L2 entry #9: 0x0000000000000000 ffffffff00000000
>   L2 entry #10: 0x0000000000000000 ffffffff00000000
>   L2 entry #11: 0x0000000000000000 ffffffff00000000
>   write -q -z -u 800k 128k
> +file_do_fallocate fd=N mode=0x03 offset=557056 len=131072
>   L2 entry #12: 0x8000000000080000 ffff00000000ffff
>   L2 entry #13: 0x0000000000000000 ffffffff00000000
>   L2 entry #14: 0x80000000000a0000 0000ffffffff0000
>   write -q -z -u 991k 128k
> +file_do_fallocate fd=N mode=0x03 offset=753664 len=129024
>   L2 entry #15: 0x80000000000b0000 ffff00000000ffff
>   L2 entry #16: 0x0000000000000000 ffffffff00000000
>   L2 entry #17: 0x80000000000d0000 00007fffffff8000
> @@ -339,6 +350,7 @@ L2 entry #27: 0x4000000000120000 0000000000000000
>   write -q -c -P PATTERN 1792k 64k
>   L2 entry #28: 0x4000000000130000 0000000000000000
>   write -q -z -u 1152k 192k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=196608
>   L2 entry #18: 0x0000000000000000 ffffffff00000000
>   L2 entry #19: 0x0000000000000000 ffffffff00000000
>   L2 entry #20: 0x0000000000000000 ffffffff00000000
> @@ -351,6 +363,8 @@ L2 entry #24: 0x8000000000090000 00000000ffffffff
>   L2 entry #25: 0x80000000000e0000 00000000ffffffff
>   L2 entry #26: 0x80000000000f0000 00000000ffffffff
>   write -q -z -u 1759k 128k
> +file_do_fallocate fd=N mode=0x03 offset=819200 len=32768
> +file_do_fallocate fd=N mode=0x03 offset=1245184 len=65536
>   L2 entry #27: 0x80000000000c0000 ffff00000000ffff
>   L2 entry #28: 0x0000000000000000 ffffffff00000000
>   L2 entry #29: 0x8000000000100000 00007fff00008000
> @@ -369,15 +383,20 @@ L2 entry #14: 0x80000000000a0000 00000000ffffffff
>   L2 entry #15: 0x80000000000b0000 00000000ffffffff
>   L2 entry #16: 0x80000000000c0000 00000000ffffffff
>   L2 entry #17: 0x80000000000d0000 00000000ffffffff
> +write -q -z -u 512k 8k
> +L2 entry #8: 0x0000000000000000 0000000f00000000
>   write -q -z -u 576k 192k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=196608
>   L2 entry #9: 0x0000000000000000 ffffffff00000000
>   L2 entry #10: 0x0000000000000000 ffffffff00000000
>   L2 entry #11: 0x0000000000000000 ffffffff00000000
>   write -q -z -u 800k 128k
> +file_do_fallocate fd=N mode=0x03 offset=557056 len=131072
>   L2 entry #12: 0x8000000000080000 ffff00000000ffff
>   L2 entry #13: 0x0000000000000000 ffffffff00000000
>   L2 entry #14: 0x80000000000a0000 0000ffffffff0000
>   write -q -z -u 991k 128k
> +file_do_fallocate fd=N mode=0x03 offset=753664 len=129024
>   L2 entry #15: 0x80000000000b0000 ffff00000000ffff
>   L2 entry #16: 0x0000000000000000 ffffffff00000000
>   L2 entry #17: 0x80000000000d0000 00007fffffff8000
> @@ -407,6 +426,7 @@ L2 entry #27: 0x4000000000120000 0000000000000000
>   write -q -c -P PATTERN 1792k 64k
>   L2 entry #28: 0x4000000000130000 0000000000000000
>   write -q -z -u 1152k 192k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=196608
>   L2 entry #18: 0x0000000000000000 ffffffff00000000
>   L2 entry #19: 0x0000000000000000 ffffffff00000000
>   L2 entry #20: 0x0000000000000000 ffffffff00000000
> @@ -419,28 +439,69 @@ L2 entry #24: 0x8000000000090000 00000000ffffffff
>   L2 entry #25: 0x80000000000e0000 00000000ffffffff
>   L2 entry #26: 0x80000000000f0000 00000000ffffffff
>   write -q -z -u 1759k 128k
> +file_do_fallocate fd=N mode=0x03 offset=819200 len=32768
> +file_do_fallocate fd=N mode=0x03 offset=1245184 len=65536
>   L2 entry #27: 0x80000000000c0000 ffff00000000ffff
>   L2 entry #28: 0x0000000000000000 ffffffff00000000
>   L2 entry #29: 0x0000000000000000 0000ffff00000000
>   
>   ### Discarding clusters with non-zero bitmaps (backing file: yes) ###
>   
> +Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=raw size=1048576
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
> +write -q -P PATTERN 0 32k
> +L2 entry #0: 0x8000000000050000 000000000000ffff
> +discard -q 32k 32k
> +file_do_fallocate fd=N mode=0x03 offset=360448 len=32768
> +L2 entry #0: 0x8000000000050000 ffff00000000ffff
> +write -q -P PATTERN 0 64k
> +L2 entry #0: 0x8000000000050000 00000000ffffffff
> +discard -q 0 8k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=8192
> +L2 entry #0: 0x8000000000050000 0000000ffffffff0
> +discard -q 8k 56k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
> +L2 entry #0: 0x0000000000000000 ffffffff00000000
> +write -q -P PATTERN 0 128k
> +L2 entry #0: 0x8000000000050000 00000000ffffffff
> +discard -q 0 128k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=131072
>   L2 entry #0: 0x0000000000000000 ffffffff00000000
>   L2 entry #1: 0x0000000000000000 ffffffff00000000
> +discard -q 0 64k
> +L2 entry #0: 0x0000000000000000 ffffffff00000000
>   Image resized.
>   Image resized.
> -L2 entry #0: 0x0000000000000000 ffffffff00000000
>   L2 entry #1: 0x0000000000000000 ffffffff00000000
>   
>   ### Discarding clusters with non-zero bitmaps (backing file: no) ###
>   
> +Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> +write -q -P PATTERN 0 32k
> +L2 entry #0: 0x8000000000050000 000000000000ffff
> +discard -q 32k 32k
> +file_do_fallocate fd=N mode=0x03 offset=360448 len=32768
> +L2 entry #0: 0x8000000000050000 000000000000ffff
> +write -q -P PATTERN 0 64k
> +L2 entry #0: 0x8000000000050000 00000000ffffffff
> +discard -q 0 8k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=8192
> +L2 entry #0: 0x8000000000050000 0000000ffffffff0
> +discard -q 8k 56k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
> +L2 entry #0: 0x0000000000000000 ffffffff00000000
> +write -q -P PATTERN 0 128k
> +L2 entry #0: 0x8000000000050000 00000000ffffffff
> +discard -q 0 128k
> +file_do_fallocate fd=N mode=0x03 offset=327680 len=131072
>   L2 entry #0: 0x0000000000000000 ffffffff00000000
>   L2 entry #1: 0x0000000000000000 ffffffff00000000
> +discard -q 0 64k
> +L2 entry #0: 0x0000000000000000 0000ffff00000000
>   Image resized.
>   Image resized.
> -L2 entry #0: 0x0000000000000000 0000ffff00000000
>   L2 entry #1: 0x0000000000000000 0000000000000000
>   
>   ### Corrupted L2 entries - read test (allocated) ###
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


