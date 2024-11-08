Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32C0D5E12F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 11:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9NHu-0004Lt-Cl; Fri, 08 Nov 2024 06:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1t9NHs-0004LV-3x; Fri, 08 Nov 2024 06:36:24 -0500
Received: from mail-db8eur05on2072d.outbound.protection.outlook.com
 ([2a01:111:f403:2614::72d]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1t9NHq-0003q8-1u; Fri, 08 Nov 2024 06:36:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8AWzzVi6JMyK/8cQdRy74TUydqrj20m3nHra0/fVH53QhEUDHf+rAbZL7Ww6ed70mZg6sP2k9VnNrr6jl5OMLqsFfL2qQCuTm9QJmtEV26Zj/nh7bzxCZgzfj6PFsyd17Yx9xyZ8RBTN+g7gQLxMxiVaTPwl9nZmVPHIEyviPurt2RtD7fK3w5bJjjU86RXHjLvGt0EDmkM1/GfZxw4bEeCEUT5+OsJSXqBMQ9x4LDI5Wjbu/TYPDa/sI5Yl840wZbAlLKhr2jBviLqRudK7M70YcYKuLFUPkZ4u0DlodSvt78NI3Z6G/D/fyQ5sHTJi27dZad2Ki20uaY94HFybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI2/xStgOnHCn7iqdnDIqJTywuT9E6YNBAiLxTUaIPo=;
 b=OAU95Zr7eXpVMLtDeFKISs9q9Hg55MQdtfS76DTlIlVrDntaBBVFYJ0JhYUP5y9qi+j6i6JSF6wYs3ClnC1wzimIMBmTT2ij5e/p/kLVXBl7dKsxpNJ3ry31OhvkID5qscAalovpuMhpX3AVnVm6erNa2/P5sze48Wmj2CzGrXR37usfF4Bu210ukqhfxf1Gt5z1YmbG1pjmMPdtvuFD+xhON/1NOLUgP/R0xbDU9SO0XLSITiA87nSVlTMhzwDixu0e1I2qFYiGBKVi9Y4eV8pC7Zi+zPY5uBx9b84Lmzz9+SncWrrPJDLeVBWsMzLyHF+pbJsAUxIhPQogEiolbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI2/xStgOnHCn7iqdnDIqJTywuT9E6YNBAiLxTUaIPo=;
 b=vq8zgJd8+CNj50pn0gjkgw/+CsS6wkiU2SxQAa5YXYPcCwKzU5K0XD4zeDqgfnLym0Ytp1zsb7BH2WsNQA+/tHYsTuEQoP9wghjkZwMBlr01pFGM+xi0AOoc6+CQcb/yro+uOlsz1sy8hq9Ml/HhePIyQfcG5zPrTGHQ9QTezHtLdw7V/D9nXgmqp8DBV6Rg8buBoDaEkn1NeYnzYmwKKPufigOn2Qe41u3GXEC1i+HbeHxm4LUQbFxV1GB69fH/ZQFiI0Msy+/EFA6SMUIIen7kYBjaxZJfnEHMdP4n9zMDJFWlwuvKd2lWzPh94mqbrZJPMlD9dIiJPkXsQ9Vetw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU0PR08MB9300.eurprd08.prod.outlook.com (2603:10a6:10:41f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.34; Fri, 8 Nov
 2024 11:36:16 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 11:36:16 +0000
Message-ID: <7894af7b-d0e4-41f4-8c6e-f4f6de5f25aa@virtuozzo.com>
Date: Fri, 8 Nov 2024 12:36:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix possible int overflow
To: Kevin Wolf <kwolf@redhat.com>, Dmitry Frolov <frolov@swemel.ru>
Cc: stefanha@redhat.com, den@openvz.org, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20241106080521.219255-2-frolov@swemel.ru>
 <Zys8tLcKjADMtkqn@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <Zys8tLcKjADMtkqn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0253.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::26) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU0PR08MB9300:EE_
X-MS-Office365-Filtering-Correlation-Id: ed829880-918d-4f05-865a-08dcffe98e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHFtZ0puUnh5azRxYkxIek00M3JLMlFzcW1mOTUwckl6OHpuT3h5WmF0WTd3?=
 =?utf-8?B?aVdkdUhvZlY5b3RzOGFXcjVNSVBxSjFFQU5MamxHWmI2Ynp0WXJJK0xmeWE0?=
 =?utf-8?B?Smh2WkROa1piYXFadExvTDJwQXQ4Q04wenBHMG9CbWxZN09BR1BCVG9MamtH?=
 =?utf-8?B?OGxVR21QcUFqaHNHTytEeU9DVzNueG9EUWs0YnhNY0dYM010L0ZQZjd4S0NI?=
 =?utf-8?B?dHBscFJGeWdsVFpxbjVhc2oycENSVjgvTDJ3RXZYZ29YdjJwUU1RZ3FjN3ho?=
 =?utf-8?B?RTBwVWtsd09zNS9qQ0FPckVIaGpkNGt0REM0SFpabmlYQ2o1UmNjOTFIekJw?=
 =?utf-8?B?RllqMFBLdm9IU1EvYVhrbTg1UzJCTmlqNU0rdHVjSVJqMUg2Vlp1KzhSMlFS?=
 =?utf-8?B?OWtMUXU4dTJQVExIM1FpWHdHcWxmejlLV0dlT0w2UkZMd1NkVUsyaFY1OTI0?=
 =?utf-8?B?MzFTM0dJUDBQUjhOeWxHcnZWTmdrdERqUXQyVWNYK1QzTnBsRlYxMzZtSHhp?=
 =?utf-8?B?VG9rcUxFVitzUytibWozRVhrMGhNTmJ6SSttS3hWQUt0VTdXM1gweU5NcHE2?=
 =?utf-8?B?Y2tDRDA5TUFkMlpYb2VTZW5zU21wMUdyQ0RaQWVxMkt1MWVSQTBUSHBGclRr?=
 =?utf-8?B?a3gvMkZxNHlROVdla0dHMU5iVUJuSnh3L0xhTmdnYlcyMzRHdTJ6RFp1OEx3?=
 =?utf-8?B?ZHlEZDVnb3loY1VrbTFCWXVHK2RCbEV0cWRzTzMybFFTRmM2RmpSdmU2dTdh?=
 =?utf-8?B?UXkrdjZLbUdrYjBUVDZ3cDgrK1JHdU5zMlFRL3FLaHFJYVp4WEI0b2JQc1Jw?=
 =?utf-8?B?S3pDNEpHdDBVUmhxdjV5Y3cxOTFZSEZBbVVnMjM1d29jV3NEcUZ2RElFVERQ?=
 =?utf-8?B?aGVsZmxUeGVmUHdoS0twRnJIKzIrSnlZRUZHdGVFN2tudkFWZjFsNlg2RGFY?=
 =?utf-8?B?TURQSENaYjNLLzlTZFMwN3VGL0Vha1grQ2M2bVJyeVh4NTYyMGJLTDRhSk1l?=
 =?utf-8?B?aldCaHdKV0ZwNnZ6cHhRN2hGT3o4WDBUcG9vZ1Y2NDIrMWExM1VTcWVEem0y?=
 =?utf-8?B?UFVNQTI3ZkJjMHBxT0hrbXhKVTVqR05WRlhEVk5XSkx2WW54bWtIaEduMnp4?=
 =?utf-8?B?ZFk2aW1LYk9VSVBiU1JrcCtLRGlZVE5uYnkrVlpvTlpwVTdFY1hiWFBvSzd4?=
 =?utf-8?B?eVltVU9PU1F3TmF3blR6MVRLT3hpVlpFTEFzWnJjOXYxbFFLbkx5Ym9OQm1U?=
 =?utf-8?B?UFljM2dYWG95UUUrbFEyYU1CYmFaanN3SHQ4TVFuUzAwR0Z5bjBWWmZEUitO?=
 =?utf-8?B?THZWZWwxNWtDMThqTFdQNGxDOFhNdm5Udm5WSDF0NytBTkZpSDYyS1JhNCtB?=
 =?utf-8?B?TUpLWWw5a3NHQ3lXa2Fydm8vR0wrbnlSU2diZGJmM1MzWVcwalhVczA2dmU2?=
 =?utf-8?B?Nm56ZGxNOUJxWm5sc2ZtY3lDTWtvTk9DemowVnV2VlBXeXU1cHJuMXlpYWRi?=
 =?utf-8?B?QzFVVlJRN3huUjVOeG9MQms1a253VWRkbU5FQlVjd2pBRU1NT2xONXpGdXQ3?=
 =?utf-8?B?VGtVQ2RBWkZyWjdHdkRVeEpWalAyR09WbFBFQWhHUjRwSUZjS1NWYVR0bGlw?=
 =?utf-8?B?VWt2ZXN4eU9ld0ZENGgweG1Hek4vZFdOL2tXbXlvVDhzMFFSRy9TSXo1NHky?=
 =?utf-8?B?NklyRElFNXRkTEN5WlpZWm9mU0tzajZic3RxL0hIYUNZeWovamFpRUl0QWxJ?=
 =?utf-8?Q?JWyyNNRZvqG1T/xBW0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3ZDRGZ3aDZ5V255QW1XNHVXQjBsNW1MSXhNOGlFeWFKTmFNejY4KzRMbk1B?=
 =?utf-8?B?c3lPNGdNazlXL1p4ZDZIbGkvOFZSOTgvR2ZodjhlKy9VTnlseWRPSVlRWW8y?=
 =?utf-8?B?SXVTdW01MGNQVWFqNVg0Y29hb0xBbHlOTis2ZHJuM3VBL2J3bThqWVVwZ0RX?=
 =?utf-8?B?TXlVM1lEZDZwUlcxdFI0anQ3dzJTWmlUWDhPV3lsMGQzTVRhKzI4WG8zNytI?=
 =?utf-8?B?c2NxMnZQQXUzV0tvcnM2Mkc4R3NIZWpYWFVHSG9qcno3emtjWUVQaW1PL0Nn?=
 =?utf-8?B?anRLM1FEenlaMjJ6aWozNlg2YUh3MTVDNUZGTThPYmNOTXJRZ21MTlYrVFI0?=
 =?utf-8?B?TG14VXhWNWJQazY2MU0zM2dpWFJ2RGk5Nml0anc4WTB2M1N6NFRtRUFHZktr?=
 =?utf-8?B?UVdScEU3cTZxVXNCYWZUODBzb3ZpamxtMzNvMlJiSlpTQ0djTkZkbjRQeVN4?=
 =?utf-8?B?VHgzWklUZG95MTBLaXlvVXdaK3JWbUpRNENNYkZIM3FRc043dTBlKzNPb2Q4?=
 =?utf-8?B?WVNPVmozT1ZkMmF0WHRHMkUzMk9LdU5NcXJBUXUxTnNmUURNKzRpYWVzOG9W?=
 =?utf-8?B?d2syRGpWQnBrdGdYVENVY0RHYkwvVTFuQ0VZT3E3MGU4VmdiWTNTOGdkaUFJ?=
 =?utf-8?B?ZmNGMlN5aTE5ODFpb0Z0ck9SOUdmeGV5a2F3UzhpSkFqOXI0aW0zUk5ZYS9R?=
 =?utf-8?B?ekhDZEJaVkdHSlRkdk0rTmVzZFdXeUxraDlSeGgrM3ZzUXUwNHNzM0xvQkEr?=
 =?utf-8?B?dGp2MVV5V2orOTRmeXpYZ25QTXVHdXR6cTdXSXEyYlRnVkZEeGVrL2M2bWx5?=
 =?utf-8?B?Ui9iYUpua1N5U1VHMWdvakw4OHdvbHZKUDBRTlZVOTNjelFVQlF1Z2VkNmR5?=
 =?utf-8?B?V2JRZEh2cVppVWoyb1NzNWdSOEdwRXdXOUUwZzFCVkwrcEMzbk1OL290Vjlj?=
 =?utf-8?B?RjhFYTF1MXRGQTUySlNmQTBOdjdkR3VVNWR4eVVURTV0dG1GcHE3QXFtM2d2?=
 =?utf-8?B?NUdyUS9lK1k5U2ljNjRIQklxMDgzclppT3c1cHo5clZNYk1RVlZFeCtkTU5y?=
 =?utf-8?B?SXR4c2hpenNTSHlnS2JEeG5JOUhwRjUwS1JsZW4yalBHaERaTloydGNRaDB1?=
 =?utf-8?B?TUtrU0JsNHJLNmFiVkE2d0JxK2ptNFo5KzcyQldZRmdKUXo3WEdqTzdWS0tI?=
 =?utf-8?B?OENmZWppd2pMN0xLR2w3RFZFT3hqbk1saWkvNUlqeW1iRWVvbFlhMHlTZlVL?=
 =?utf-8?B?L1VaRWJYeHdMaEl2ZDZITHJrNzEyNk9MTCttUEhEcGJ2eUo2N2JSQlErNEY2?=
 =?utf-8?B?bTczVkk2SnVKU0FnRi9OaXFmdzZqcEVBZk9DSEZVbFJpbnlVYnhQamRLMkwv?=
 =?utf-8?B?SzdQSC9jblN6Y0VkQmt3L2xUeXY4K094RnpNcXZXRnArb0FWUEY0elJkMmFE?=
 =?utf-8?B?RFRTaW5qN1V6MkJqQ05MSE5sYTVEOWIzcFdBN0xSRW1Pc0hISXRRZytwVWZU?=
 =?utf-8?B?MXFEdE9Iend1VEhUazVHR1ZOeDJ1Tk12bGR2bVZOWGl5WGRLVnU5WWhJVUw4?=
 =?utf-8?B?dHIvU2czNFhsV3JZNnVtK2UrTE9ZK0FrcXp6dVRCSjZWcDhjTVNmWXBLTXhp?=
 =?utf-8?B?TEtyRUMzVW5RNUtEZ0F4NnM3azBpeWFtbi9UdGI1VUE5ZXBRbzErRDdUMUxD?=
 =?utf-8?B?NWhoTC9BdEozU0JVTW04bUdZbjBYa3VJSHVkczZva3ZIaXZCc1dPWk1tWGhJ?=
 =?utf-8?B?NjVrUWM3bFZJQVkrMUVQZlIxaTlMaGlxdXZtdVJnWWgxVjhRVWZuL0F4emRh?=
 =?utf-8?B?cmk3bHJhMHF3dzh4ZEtHUHBhcEtTZXdSZ0s0aUFTRFp3b0M0OHQyK0tPbGU3?=
 =?utf-8?B?a3V1SS85NE51N0ttaU9XakpQMXhLZnZkTmlXV3A3a3gzenh2anlUcllMOG1V?=
 =?utf-8?B?SGRFUCtXSE83SER1MUM1d2JVMDBnUG5IaWxlZ2ZNcVlkR0c2aUZyckh5L0d3?=
 =?utf-8?B?clA5cmI2Y01mMVU2SnNONWVCVnMrMnZCRjlLcEh2VjdGWUpBR0hnYnFRNGI2?=
 =?utf-8?B?b2JTWkJSdzdidU1xN0QxbFBOWDcwcFhPU2dRQnphL1ExWUdJRklsQW1kMkZ3?=
 =?utf-8?Q?5jheDyQjGxqlO8IlK851m8O2+?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed829880-918d-4f05-865a-08dcffe98e8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:36:16.5305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LecnfaZ8MQm5SNw6LSU3AADkD8qrL4FGSSAUVHYokffX2F1vaw077OeUk8l1rIfywyKqyLBQZqo8MtpkOus9Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9300
Received-SPF: pass client-ip=2a01:111:f403:2614::72d;
 envelope-from=den@virtuozzo.com;
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

On 11/6/24 10:53, Kevin Wolf wrote:
> [ Cc: qemu-block ]
>
> Am 06.11.2024 um 09:04 hat Dmitry Frolov geschrieben:
>> The sum "cluster_index + count" may overflow uint32_t.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> Thanks, applied to the block branch.
>
> While trying to check if this can be triggered in practice, I found this
> line in parallels_fill_used_bitmap():
>
>      s->used_bmap_size = DIV_ROUND_UP(payload_bytes, s->cluster_size);
>
> s->used_bmap_size is unsigned long, payload_bytes is the int64_t result
> of bdrv_getlength() for the image file, which could certainly be made
> more than 4 GB * cluster_size. I think we need an overflow check there,
> too.
>
> When allocate_clusters() calculates new_usedsize, it doesn't seem to
> consider the overflow case either.
>
> Denis, can you take a look?
>
> Kevin
>
We definitely have more places inside the code and I'll take a look.

Speaking about this particular change - this will not work. In general
we should signal corruption when the cluster number is overflowed.
This data would not be accessible due to format restrictions.

Den

