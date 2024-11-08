Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B01D5E15A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 11:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9NF5-0002L3-EJ; Fri, 08 Nov 2024 06:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1t9NF1-0002Ke-2P; Fri, 08 Nov 2024 06:33:27 -0500
Received: from mail-am0eur02on2072b.outbound.protection.outlook.com
 ([2a01:111:f403:2606::72b]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1t9NEz-0003QD-8a; Fri, 08 Nov 2024 06:33:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P45yYpPT10tUZrT4pfdyjmviSjfjPMupsDOUazR+aRJBzjhkyatXZ/SVUL99jpX2NVvGYSg9P80ihwl/THW5x/eL4CXimwiSWA6jws6srp/Dx7eAAnZlddtKiZNrM7PElRZi8n2JBln8m6PerZXFwgltw5A+Zh4N50W9/Y4aPzN22IemP+630TUtFd6cOFfqVGCB2AH+IsjCcyvPY5tLN2epgAji/5p61kEI+HFiMTi70pp+flGmibyL6WbCs8fob5hDD1CjVBdZHKl7VjHQ8LxJSqjjlcTyEQfB/QLUbLfa9iWwpMJFW8oQUB53eEXAUYuz2tjZI3bxRb4z3G/IpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv2ig7eCabgkIat2gl8LhXuZFYont2IlpJDEtsNmROU=;
 b=TyNKK6D25W9q4yhOTqyQ6lyvg6KOs8qIgQZyfOoLhQK9U+WcUCJM9FT/6hnxbONNWLPBQhfTU0dNvkkOukrmS2IIT9MTVghKGnJQJUaQ3WUwgued4iOQDFGUi9e3t5405Dt46NGkFFUpoQ5SSzl79O2jaGHcRu7JqPdtT7GVg5yNMw2GnYtE21CtT5p73VMKEyh7ksc9ohFWdT1yRyhQe5q5Swyc5QgQC93HlfN3Mte5xHaEQOJq2Mq92k44H/wyxv7Bnu+hMr4wCfT7DBgjH/dFUffbU0uyojnppK6XXb//3ZwFAicLvp/U/yHKndOBVNpeam0sBBTVMv+wv+KB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv2ig7eCabgkIat2gl8LhXuZFYont2IlpJDEtsNmROU=;
 b=othKeqvT1xnCriXMrW9z2qFEk9ocfTah7fNuzAtd10zlLCYx5sIuUZTmFpVrUm7QrNMNljlrvpWJ9jeT5R7UjCwtxNEw10p1GjQnuf/apVMIc+LHIqTRoL+3NHaj6Ap3Jb4OHFFvFEJroqRoKAQ9G9wbR1Nppo/lLP0uCVm20ME3e1rhAkCLZGlfEyuKRQyhvxzvunQsnxzi2a65hd5+fPDRkDStiJ0xoB1+PVkXe63JEIIhISieyR2WhEEyG2ZVl+KK0IFIS0NDoaaqUMw1wtxDN8oWgCWnZxmJZhmnRxrGKXgSFFTZouv0oIo8yufYF+dkL7q7k8+JS0CEds4qFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PA4PR08MB6045.eurprd08.prod.outlook.com (2603:10a6:102:ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 11:33:00 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 11:33:00 +0000
Message-ID: <09d5aa99-8b5f-4c8e-b7bf-d9ef4d40bfa0@virtuozzo.com>
Date: Fri, 8 Nov 2024 12:32:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix possible int overflow
To: Kevin Wolf <kwolf@redhat.com>
Cc: Dmitry Frolov <frolov@swemel.ru>, stefanha@redhat.com, den@openvz.org,
 sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20241106080521.219255-2-frolov@swemel.ru>
 <Zys8tLcKjADMtkqn@redhat.com>
 <cbd949dd-673d-46cb-8cd7-9fc94515afc0@virtuozzo.com>
 <ZyuSmIR0hL4pzieK@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <ZyuSmIR0hL4pzieK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::7) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PA4PR08MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: b0680fe7-d1ad-472b-bdf9-08dcffe91991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVFpQ1VvY0NQTjRRbTc5Q3QxeHRDejBpR1VydFBEN0o1czBUeDVuaXNSNnZo?=
 =?utf-8?B?dHZMd2QrbFhKeDBLOEhyOXF0ajNIWHlsVXRjVmF1eHZBRnc4eTk3MURDbW5W?=
 =?utf-8?B?by9TeVpWS2I3aHlpRXdhb1NBaHp5SnZyenFoV0VpSW9VOEljeS9TZmUwdGQ1?=
 =?utf-8?B?NnJyZmc3NC9kcW1sWlRTZGxWaDBkd1dHbnV6ZXJVSXRNcmttYWxBVFlQcDdU?=
 =?utf-8?B?V21EOGMwbUVpeGJBTTZpZWNqdWdQa1F5ZGtpa1VLUWxKcDNBQnVvd1JBZlYr?=
 =?utf-8?B?T1NPZmRlTHdEQ3pOK0tVdXBscVc0cFRGQ2NDYnJGNHNqUHc4cUVBSS9INncx?=
 =?utf-8?B?Yk91NENLUHN6bFZOSFRoSlRub0tiMTdQNG8vMllBWjNYcnhubEJOS3MrR1Bl?=
 =?utf-8?B?SGl1eEFNVCtwVXVyRXo1bzBkZHp2WVl6eVd5NGF5eDBEcTFwKzhoVHQvMTNi?=
 =?utf-8?B?MnoxVzdNTFQ4UjNMN2NscFhvVElublJnL0FzZHVmRnpFUHUwZWFBMEtCR3pT?=
 =?utf-8?B?QXRXdGFPL0VsU3pkdTVOSks0bTdoR0cxVWJ0UkVUMEx3QVY4QlpQdm14T2F5?=
 =?utf-8?B?emx0OFlPMDlDR2VIMEMySTJDa1B5K3JUbHZVVmY2YXpvcDdGalBTOWhLMk5L?=
 =?utf-8?B?cHZ4Vkk4MUkxTE9XcE5TQUlLQXlPc1hXbEo1TGJ4OXZidjJISWJaTHJLTDdQ?=
 =?utf-8?B?d2I5OEZuTU1tUDZTd3RrVlFZekh0RjB1aUo2a3RycUpwalowUzhpeEdEbXNY?=
 =?utf-8?B?RmsvaDE2RUdpNVRhNTVTTkhibEY3R1YxZ2lEMUpZMTlXWmorOG11NTh4TE4r?=
 =?utf-8?B?NGhZdG1iZ3VSZGQ3bVFobXNwYVBWTy9hclFSZUtTV0lPT2t6TzZCUUQxSjNu?=
 =?utf-8?B?R3dKcHVuNUg2OTRTMXpvK0pNOTZkWnNBM3N0eExoSlR5SFhnT3hMWmozZGZF?=
 =?utf-8?B?R0RaS3hvSy9jUWdSaE4vWGcxWDRpK3ZDTXZveUVSc2RwR0dvS09UbzdFaHor?=
 =?utf-8?B?SmVETzc5c1Fya0ZaK3hBbndWYUUzZTFlV3dLekR5R1B0SXZ3Ny9ManNOeXNI?=
 =?utf-8?B?Y3NGdThZWmxXSEJCeFc0bWVUT3Q1SWgvcWNDdGpTTzNWNU9MVHAxbllSKzAv?=
 =?utf-8?B?MFRSL1FRTVR5S0RKdlFvT1BaZjdDYUdLKzNNTW8zeXZreGZCRHJCd3Ezbkgv?=
 =?utf-8?B?cTd4YS9JS1V6bzhVQ3NWRFc1am1sTDFIUmVyVTJUVURIYlRUSm5ISFlRY21C?=
 =?utf-8?B?ZU1TeDc4SHRtZk5JZ28wM1J4LzVaaE8rSUROUU43TXJmOWsvWGtyV1BnTktF?=
 =?utf-8?B?ZzlxUG05L0J4VHBpWGVhcUJRVmM4TnVlOGZsTTZiNjg1dDN1b2pRY3BkOTE3?=
 =?utf-8?B?VkwvKzVNdkY0R3hGc25JaFEvblRXeDhIL0VUVCtPVCs1NDF4TDhaN0NEUGNa?=
 =?utf-8?B?VVRLbTU3bFVkd3FhcUdPMEo1N1hlbURQcjRKc3RKb3M2MDBsU1BxeHhVdERX?=
 =?utf-8?B?QUhnbHBhTTNuSXhHbUxob1A4NXZERGlpY2tXTHh0dE96OVVkS0VNNVJ5dEhs?=
 =?utf-8?B?VHB3ZEpnOGFtdlNwbDR0Y1FJWVNkT09wYXNWaGdlc2twcyt4Q0FkWUovT2xL?=
 =?utf-8?B?bUJYYzUrNFA2SHhvN2xhb0tod0p4SUlQUTZ5blNlKzFhQjJwL0JwQVlVMUo4?=
 =?utf-8?B?bVdrNzhwQlNRVUR6clVlbnJTSVNNT2Y3dTJyYXozZjVHaDlnc3hNM3IyMGZq?=
 =?utf-8?Q?WPl2d6LcASaTLQua7dzdW1dRYPzoNEf5972Sgrt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZC9nUXcvdGdGMVNmOGZhZ3lYUS9RZytsMkFZMUlMQUMzcW03MTU2VlJ0Q1Mx?=
 =?utf-8?B?dklxTHF6enZDNUdCS1RRdnJVZm83Zzhwb0ZGbFJzWDRzb0tPRVdERk8rclVQ?=
 =?utf-8?B?YlVBVC9YaXBqa2tOaGZNTzJHazM3V0lPL3ZUWmFGc1EzNkN0VmwrQWx5Vit3?=
 =?utf-8?B?TkVoZkFJRWVXNi90ZGk4eUdsUWxCTVU5WllPbnFYVXk3QVpJaGQ2ZFQrUzhq?=
 =?utf-8?B?cmR2TnkxQmdPeVQwYjF3QTRlaU8vZEJKajBaVTUrRE5wRVVSc3gvM3g3Vkxu?=
 =?utf-8?B?ZUhxRzA3UjhuQzloOW5nckc3dHo3d1hnamZVN2NNRWhJbWhxdVlabVBuZGVi?=
 =?utf-8?B?ZXMzS2Z0Q1BiT1F3SlFnVG04V0VGZ2NIR3VxMExJQ1RaRk9LNFBXZER3aDBj?=
 =?utf-8?B?NGFQN0R6MUxsMUpZcGd4Q2U1UWVGMUh3Ukp6YzVxYk9PK2Fmb1RUd2xWRTZD?=
 =?utf-8?B?UmU2ZytTTmppQVhoS0U2VlhHU3A2NHNyL3FETUlzYlYzZk5yRTBlSVV3d0VD?=
 =?utf-8?B?MzluVkUrTFRGSXRqSFV3TlNlNFpZbnpVOU1lU0dObDU0dGRqUmpGVnVJVWJ3?=
 =?utf-8?B?R2k5TG1Jem5wRkJXUHhJV2wxdUV1ZlNZS2JYd0p4ZEtJZXRDb1VLaXZhQTZO?=
 =?utf-8?B?OUpyOHZMclp1MFRsSXZTcy9WY1dTRlN1MU42STFjVTBjMlZiWHA4aTNkd2g2?=
 =?utf-8?B?SGE5dWJpRnpQRzRtdEM4Ny9LTWp1TDBYUlR1VjFVQVZGU0lneDI3UGsxbUc3?=
 =?utf-8?B?bDMwK1RNdmFnWldOUWp6Skh0SjI3VE9ObFZHa1hRWWdYNjhzblFXakNlbFhX?=
 =?utf-8?B?WkNFTk9rTzU2ZmRaQ2ExbXhaY3NuZE4vZkNER1VyUEhZMEhEdEVUaWx1UUlB?=
 =?utf-8?B?TXM4UmRmbXR3Y0tJbmVyWi9oNmtVanNNNWdoTzl5K21Sa3IvV2JndlVCZnVD?=
 =?utf-8?B?dTRWZFZHOHJvSXhZRHVEY0dUaXR1bm42WW5DUERibG8rZEM0VHQzcHdZV25X?=
 =?utf-8?B?SDVTc1pyRVQvakNtRmhMMWxtbHc4cUFabjdWRC9ZdjNOemhzTC8xOFRnbjgw?=
 =?utf-8?B?SUh4TkVzcC9FbGwvRDVTQkFwU29kMW1FUlV5SS8rUFhHREozUUNMQXpSdlJX?=
 =?utf-8?B?MDVLUlUyVElmelc1QkVaYlZWbnFLZEFkZVMyZmg4ZXNzUWV1ZmtCWUdsR0Nn?=
 =?utf-8?B?Wkd1cU10MStndXhHbUNDblM3alIvSnJxeXBZaDBwMnJvdHBsOHJVaW9YdXY1?=
 =?utf-8?B?VThzd3pKNGJ0K24wMisrUWdMY2xUclFXbHNUaElmWnRVenJ3MlFVYmJZK20w?=
 =?utf-8?B?Z0Y1Y2ptdG1HM1lyK1AyVk5FWGV0czZNTzZodTBmdzFnditvVGdFdDNkZEtx?=
 =?utf-8?B?TWEzbnBwQmErajBZNGF2Wm8vK0x5dFpNdWpQU1lpaFJXUzVHQ1hJWTlhWTZk?=
 =?utf-8?B?R2hlWURQeWVXRG5ERGV1d2FHOVJCWlNPRXp0ZWs1M2V2RkUzbWJCR1VGUDFa?=
 =?utf-8?B?QU1YQ1gvNnlsemN0RWhYRE94WHZmaFB0M216dDdxVXlZdkdLaXNqZG9Xb2NV?=
 =?utf-8?B?ZGhmVm5ROTlhVnRSVGk5bG1lZVcra2JoeFgvYWZRWE9BeUJndWphZzNXNXRQ?=
 =?utf-8?B?QUpLa0Q5d0R1Mmx1NU82Z0RIUkR0K2UwZlVyTllBd2dsT0VQUlJoOFZkbGpW?=
 =?utf-8?B?akl3a0NpUjVXVFBUT0toc0dSZng0SUx1T3VmWGRtWXA3dmlFRzZ6alloT0R5?=
 =?utf-8?B?VDNxRisvaGMvaDA4RFlUblQrN1o5WXY1c24ydENkWG5FOFlyVVkvZjFyc1o3?=
 =?utf-8?B?d0Y1VThRYlZmdkc3ZitnUlpDTTQxMzlwZFVVTytEcUhINUxucGtBaWFMWis3?=
 =?utf-8?B?bTg2VXFkd2ZhTFhkR05RbktTQmZCakZtMHFwNFRIQi8xdmdJUVU4VVRIa09i?=
 =?utf-8?B?Ny92cWpIeHJxcUVCaEQ4Vm1idytFdURJM0R5UFR1NlJlNDl0RVNXRi93UUpW?=
 =?utf-8?B?UXhFRTFCN2dMUXJKL29lNkphZW9DRzlzNUhRUFNaTFpPbGRsRWlVR3JwbnhC?=
 =?utf-8?B?TThlVDdGK0JGbmNldGphUFJ6WFJJc2YxeDZtS3JpaFlIYjBrdU9kWVpFQVVk?=
 =?utf-8?Q?8POUDa0KwygAMXUDgjI2lqDyX?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0680fe7-d1ad-472b-bdf9-08dcffe91991
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:33:00.2838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGl0W7KwLZSJmrdlhBqvNXL4PfqElemo7xduBoL6xUTOFpdtqLvvtrQgoVelDkbvi387BruekDmKD69Hv6595A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6045
Received-SPF: pass client-ip=2a01:111:f403:2606::72b;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
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

On 11/6/24 17:00, Kevin Wolf wrote:
> Am 06.11.2024 um 16:45 hat Denis V. Lunev geschrieben:
>> On 11/6/24 10:53, Kevin Wolf wrote:
>>> [ Cc: qemu-block ]
>>>
>>> Am 06.11.2024 um 09:04 hat Dmitry Frolov geschrieben:
>>>> The sum "cluster_index + count" may overflow uint32_t.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>
>>>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>>> Thanks, applied to the block branch.
>>>
>>> While trying to check if this can be triggered in practice, I found this
>>> line in parallels_fill_used_bitmap():
>>>
>>>       s->used_bmap_size = DIV_ROUND_UP(payload_bytes, s->cluster_size);
>>>
>>> s->used_bmap_size is unsigned long, payload_bytes is the int64_t result
>>> of bdrv_getlength() for the image file, which could certainly be made
>>> more than 4 GB * cluster_size. I think we need an overflow check there,
>>> too.
>>>
>>> When allocate_clusters() calculates new_usedsize, it doesn't seem to
>>> consider the overflow case either.
>>>
>>> Denis, can you take a look?
>>>
>>> Kevin
>>>
>> Hi, Kevin, Dmitry!
>>
>> In general, the situation is the following.
>>
>> On-disk format heavily uses offsets from the beginning of the disk
>> denominated in clusters. These offsets are saved in uint32 on disk.
>> This means that the image with 4T virtual size and 1M cluster size
>> will use offsets from 0 to 4 * 2^10 in different tables on disk.
>>
>> There is existing problem in the format specification that we
>> can not easily apply limits to the virtual size of the disk as
>> we also can have arbitrary size growing metadata like CBT, which
>> is kept in the same address space (cluster offsets).
>>
>> Though in reality I have never seen images with non-1 Mb cluster
>> size and in order to nearly overflow them we would need really
>> allocated images of 4 PB.
>>
>> Theoretically the problem is possible but it looks impractical
>> to me in the real life so far.
> It probably won't happen with normal images, but we need to consider
> malicious images, and I think they could be constructed in a way that
> causes integer overflows here.
>
> At least the one that directly takes bdrv_getlength() should be trivial
> to trigger, you just need to extend the file size enough outside of
> QEMU.
>
> Kevin
>
yah. That is reasonable and has to be fixed. You are correct.

Den

