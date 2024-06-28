Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43440C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 10:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN8fP-0008FB-DA; Fri, 28 Jun 2024 06:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sN8fM-0008El-I2; Fri, 28 Jun 2024 06:17:16 -0400
Received: from mail-dbaeur03on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260d::701]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sN8fJ-0001qL-Qa; Fri, 28 Jun 2024 06:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdE2wK5n/C0vpIGk5LgsgnPLfVHkmD5hjhodLP/Ez16wxhfjel7MiQviV5C8Kgel2CH9DhrVeQwNkvc0pdgZbr/8TfR9EEvZq4u+Oous3p5UUM7LbM1GLtQc/JmpEJPrZO8rNeXibysUcUVW3zuYlyIvGtU7oeSwH0D95HpvrHXFezQqQaKRSwLowqbhY8gSpk8ke+kfyzXhiwGhA2PqMc7GtB+5Cilqt4y9IqDX71tWudWyLuQrzeumKjKJPOVugS7NUESuHWOQuDBAR1c77qN1OZCjutQcXg9RcIM8x31AoPuWor+MSyaH6cxqBdkW6P5weQYrOFJX44sWViZN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGEtN47diJoTfESyDZWlwGLbpWib78FEyEFeXhkiKkI=;
 b=kBEif7K8r3sd4m16X3YPVrjZXed4AZQx5RAabChSONqiO1S1R9FVaDr44lAwtlLn6iSyGF7G29SgNFQlxEbEDPhV3vr04RctMHwxmB/F6NcApxh76j+YasFhvdw23JWImzrFpwM0VdG69qiu252k2ZFmazEmyBtNZqQQ0p8+TUyY3C/hwLlQ446lQsuXynZw5ffPT4KdmrJMpne6STIvLM6CvKp39nN/B8twy+/IOwXyguqg7o2MQXQQBeYegOa42Z1wb0PyCqz6bKJsMiz72B/iaJiFz5cAqy0gtS7kCyg+JwoIz/sSl48eP0MDe1pEtfRDWdFl3TcCjeulaEo0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGEtN47diJoTfESyDZWlwGLbpWib78FEyEFeXhkiKkI=;
 b=p636nJu8wakgqsqBln5jMsXapKSifB49I/FZOgd9pQv3Lg4Xfk6XlNOSWdtTaSwbvxiEg2XqOyFOGNHIVhzcnJHrqOgQ8ANXUzmLlvnzv/jxP4YoKB+AlGbwHhb2wMiJDVyOjneiUE/xiIvmdYlkQ23dzDkuCg645DhZPPhDQcrW4yrC3kpoMwnFlBkC+Ju8dsYT/NQAYj3b+a1j8nvFvmO6sxYWabXCp6GU7/dEoiqF8y9C5SiJK/SJOtwVUH0Wnu+FCvv5TP9GJAvVaI9bMbeUI4p/wywb3UUSkFVcK7g4iUMVE2gOPn0ey8v2RuXEAESRrq8WnIudo/c0MsoPZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by PAVPR08MB8942.eurprd08.prod.outlook.com (2603:10a6:102:320::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 10:17:06 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::1bc:d7fe:62d3:bc14]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::1bc:d7fe:62d3:bc14%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 10:17:06 +0000
Message-ID: <48f9fc4c-911d-4276-bf08-d68afa28455a@virtuozzo.com>
Date: Fri, 28 Jun 2024 12:17:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: Use LVM tools for LV block device truncation
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20240315085838.226506-1-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <20240315085838.226506-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0302.eurprd07.prod.outlook.com
 (2603:10a6:800:130::30) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|PAVPR08MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: ab43481b-b566-4423-af49-08dc975b7653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWlGNWYybGtZcElUOXFUT1ozcHprV2EzTnlyME9JTUpydDA2TXlDLzJOdzdH?=
 =?utf-8?B?RWJYZHdaMm1EcXJJSVliVVNuRCtnZ3JxaGxPa0czVC9uTUtMdWdoSDBmZnJ6?=
 =?utf-8?B?SmVMNm04NnJXYTdxUjRmK1NST3dvbTB6eDhmcUZNMHFGZXBmT2dvano4Y0Mr?=
 =?utf-8?B?T0lrQ2RiVVlSWG5kR0dkazgzamc5cTNIWGVQbHRac3M2ZEVzVHNEUkZHQTlO?=
 =?utf-8?B?MTVPaW9rem51WW1iWWtoNnhuWWgyejcyL2o5bGpYeUFLMzVGNmpPWjZJdlB1?=
 =?utf-8?B?YXZBYURxQWppNVNkdFhkNTZNNDBZK1ZHOWpuMERHUkJSRFB1N2dpVDdCcEx6?=
 =?utf-8?B?aHYrK09aY2IxdXJxMkF5b2hiUTZsbmx1bGNLc2ovM2pTMXlGNE4yaHVUK1Bs?=
 =?utf-8?B?ZlhjMzlTUE5mY0psbytoWWxFTzZ3UW9IQlAvaTdwK1hGdEJIMnc2dUIzRk8y?=
 =?utf-8?B?V1R6dm90YnduMGlZeE9Cc216VklUamNpNncwVTdzd0hWUGFzMGNHbkt5S2Z5?=
 =?utf-8?B?NXNsTHNDbzFhZkNWWTdFRDZnYlRHa1Z1bkFLdVViVE4raWN4Z2NFZ0xLTm5v?=
 =?utf-8?B?R052UTJpVTNBZVZNY0g1TEdRaXZkVlFzNDlWRytib3FkbmZoVlVhZk9tdExI?=
 =?utf-8?B?dTFjcjBjcVFjOEY3enZJOU1uL1pQZjBTeG5GZGkyYktlZGRKRXJ1aStrY2g5?=
 =?utf-8?B?VjlINitQNE9yWHFFNFIvc0VISitzTU1YZnJ5WjI0VTA5NjJsdzBmc1ZVSUI2?=
 =?utf-8?B?b2dKcEVqVUJpdHdoanZrRTEza2w1L2lwMVlsVWQvMXY3Z1VucElkTTdnQzV3?=
 =?utf-8?B?MW9pNDh1RFc4TWIrQjdPOExFUm5adDhVN2VtZHM3dU9JMWJLN2J5U2UxRkdJ?=
 =?utf-8?B?MVM4OWMvdXVhLytPa2YxNE1xS3VVSnM4enpSbERRTWFuVmxWM1pEZ1EvQnhW?=
 =?utf-8?B?aXZTTVo1Tm8rbFNxdWtQMWduWitiNVdJVklibXNKU25IT1Q2d2lkUnJoUFFU?=
 =?utf-8?B?RzNSclhQNXFuVGYvOS9yNHdiUmFUNTZEOTBheDErS0NTZFViekR1YW9mbXNs?=
 =?utf-8?B?d0UrTVRKV09NN1VIVVU3RGFqeXJQM1E0WHFuS3FaN09HeVZ0TWIyMFpWYWNu?=
 =?utf-8?B?cXN2UlhFS0tscEVRQWMvbEkva2szdFB1N3YySy80dUdwL2lOVXJJblhWKzVZ?=
 =?utf-8?B?K042TmpLdmUxNGFPdVpsZnBRalVPSG1YdkVHMmhEbnorME1Jbk44dGcxRFpK?=
 =?utf-8?B?NDJrT2pua1ljNHA3ZjArZjhvQUJ2QzNBUjd5VXZmYTYvS3Y3Y1BkYS8wbDQz?=
 =?utf-8?B?L29IVllyVlJZRFZSZXg5bzBEcVZTWU9ZM0s3QmJSaTFPbFdEb1ZVbDRtZWcx?=
 =?utf-8?B?V2ZKUEVlM3FLcVBPYU45cXp3eGgyOUJ0Z3U2bDU4eEhFSnlNTWpXdHNFT21C?=
 =?utf-8?B?cnlXZVErQkQ0NzZFek9TdlFVMUJ2eThBV3JwNmthOE5Eb2gyY3dJcmFDTFgw?=
 =?utf-8?B?eG1qT1lQcHhBZ3BZUTZMb3hEVEcvUi8xTXhQenpWcEtUREpwMnNHWGZhc2pp?=
 =?utf-8?B?TkVwMW9vWlRPSkt4L3ViWFh5aHBhOUhkcERIODZQSXRsa3BGOFVvNWdWUlB5?=
 =?utf-8?B?UU9wOVoyRjJzRDVHeTRpanJtbzVpN1piSEgwdGtQQkdsUFN2RWRraEt4OGEr?=
 =?utf-8?B?aEZGcjRHNytPdkhsMEcrR1BWMXZVdXlEWi9aNEtXR1RrRnVESHY1YVFvUXlB?=
 =?utf-8?B?UTFGVFl2NVUwTFp6SmVtMk1vaEdYcFpySkdjQWxPSVBqUVhvU0NsRkhxWkN0?=
 =?utf-8?B?cFRDejFGK3hWaDhEdkcxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzdhZk9vOFFGS29YOEJwbm5FWThScFhvbno3K3M0bHAwUkxoY1RRdTdPdnBI?=
 =?utf-8?B?TVNCYTBibUxQYTJpb0FrYVp6MFU0anQ3Vk02Q1A0TGpjU1dUNWsycG1yVGhr?=
 =?utf-8?B?UkNEVEtuYzUrbVZ4bE1hcGdjRmZiZ0R2WG9NZGRQaWU2Sm5lRG9JTU1hTkRz?=
 =?utf-8?B?eW1oeDIyZnE2a3lGSldiNkhJaVJveFk1eU1ZbU9rbmxQdjhYdjFUVWMzaVMy?=
 =?utf-8?B?OVNPSDVFUFBJZ2JPUHh4ckxEM1dIOEpMZlVBOU92Vzh4ZGVEZFpaMWxLKzF1?=
 =?utf-8?B?RHpWWWk2eWc0MHhLUWY2TnZxWVRETmYxZ2FvNHNYWmFqWllOeEd2TjlVTWNl?=
 =?utf-8?B?TDVyQiswdi85ZjZGNHQySHVlY291ajQ1YlNKNm1FR1JHbGUxM3F5VU5JRjJP?=
 =?utf-8?B?akllSHcrWGRNdWVTU0RqVG8zRWxFNVRWajBRWjgzcEVpYlVQYm52bi80cmtQ?=
 =?utf-8?B?aGxEbUpKa3VJWnhXczNiTlduWEJ2S3pqY3QwVTdIVVhmNFNSNDA1SHJSQ0dS?=
 =?utf-8?B?c3NKeUlYbWJZQW9yVlE5NU1DNEN2TCtzQmR2V0NscWVsTTFXNzdmOVBpNC9H?=
 =?utf-8?B?cVpORTRSRjMrL2hQSHMwc0tGQm1NQzBRTzJuS1NXMTBjMWZRQ3lZWnNVQkR1?=
 =?utf-8?B?bXZKM2Vlb1JLck5xbFNuR1BYV2Yzb25YaEM1K0djUHRjMW8rRWk3NXN1em1q?=
 =?utf-8?B?RllGVEo2YzVRMUZFSXQ4WWRZZWRCMTVoZ0krcHBuN1ZMbkF2UnNieWtDMFRC?=
 =?utf-8?B?cHVhY1hMczdoSkxoa0tuRUFzVWhCQkx1WlJCRVJVUERrSm10VE5DUldlcVVh?=
 =?utf-8?B?a2cvYVlwWkdUaFphN0JYMlllbXRIbVZIWTF1R092RHFuOFpTb0prTkFuWVpQ?=
 =?utf-8?B?TUI1SnZ2WEpBaUpSNmIzQTY3Nlg3ajBNcWdoS1ZydzBGRWs1WlB4Z0JFVXRH?=
 =?utf-8?B?WWk0T3JTMXJVTHhMTzNMUDNjRGs2T0UrTXIvTWpPeGQzd293TXZ6OEZjY0k4?=
 =?utf-8?B?OHF0ZDVMTHBZSW0wcHA0ZUZvQ2V0bHdVOWR2YWdDZjJGVGxvSTBaNEM5ZE1F?=
 =?utf-8?B?aFRzaG9RdzhiNXJJWWp6SzdtdGxCdUd5eGFjd0Uvekt0YndWQXN0aVBPUnlz?=
 =?utf-8?B?U2U3VVY1NkdmS2J6VVZUTE1mdXIxbjh1Q0RjUXhrV0ttSThkUDdGeG1jcXNN?=
 =?utf-8?B?ZWlYdXZhYVB4WjJlbHN3YStxWUYrNjNzVHpzdXpQTXVicXRkSXdiZkg1Z3RI?=
 =?utf-8?B?RzFQeDJ6eUFLc2VyZGMwQjJXZ1dhenBxckJDZ1RUbEh3MDQzOUJvbCsrZDRl?=
 =?utf-8?B?bWVrYTlRNG0zb2thVThldkVDWkR2MTIxRG9rUzNLTEJPQmNFWHFkRTcvSXAw?=
 =?utf-8?B?ZEVSSEJLcVJ6Y0JmaXJOR29oNDZ1Z3VHUTNmYW1SYjRyb1ByTWRkR1BvMTZ6?=
 =?utf-8?B?alNTZzBaWDZtWEd5enlRMllnaElIbzk1Q2lZalNiOVpCSGVwYkRSOXR2NGVx?=
 =?utf-8?B?eVoxd1dMQ21WN1N0ZW4zaGVPczN6bm1xUHVFbk5mc0cvMUJFaVBEaEFxakRm?=
 =?utf-8?B?amtFYXVITC85bVpPemE4cUZYR1JRS29oaE91am9qQzhxSmZQRjBxbVJQckEw?=
 =?utf-8?B?WEt2MHZERTV4UDY1VEpqVFRQUHJZeWZMT3JwR29uN2xpUWV1ZUpNRmlFQXI4?=
 =?utf-8?B?Zm9ncDNwd2VEYTVKWEE1bzMwc0NFYzRHUjNMQjdCd1h0UnlKUEhmZy96V2Qw?=
 =?utf-8?B?N1pMK3Vpc1l4dGJwVWNQdmNhOUZoeUlScmZTMlFNRThPRFVINmpaMExta0hQ?=
 =?utf-8?B?cVNnVTA1YWl5R1BkS29lZGRzdG5RaGFoOGtLSUNUNFVCRTA1TU11VldsVDNJ?=
 =?utf-8?B?b2xoUnNqbmtXMTduOTF0WHRhdERGVWE1K3diL3NOSHRmRzcxbFduZ015Mnc3?=
 =?utf-8?B?a1RhWDl4cHF1Ymg0K0NEenoxb29JdFZKSVlsTy9uUzdwL2l0SUtIelh3L2ZO?=
 =?utf-8?B?UzAxVnpWUXZoczNZbVlKYXBZWFcwdnZ1bU93V01zK2cyMGZQaWxNc3pBcUIv?=
 =?utf-8?B?MnNtUklPWmV5dnRLaGNSYmFDT0Zma1E0Wkdlc1pXa285MzZxZzVsdTRtZXFt?=
 =?utf-8?B?ZWY5SWEzY1l4RXFnaVcrSlY4OGM4T3lLdXdxYmxyUC9YY0xra0pwQldIT2xs?=
 =?utf-8?Q?H+ZNXCNzmSpbiXBKUHUuuBU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab43481b-b566-4423-af49-08dc975b7653
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 10:17:06.4117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufEX7VTdFglb3OYhqDYUkQnBUmqlAHo0nHzLAEVHwd9MkkHZHHSa6BJIY9tYBPeDrHhQ4Yzo4tDbHdxLlllDOBP6AnIt/2CAHN8CUjEVvJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8942
Received-SPF: pass client-ip=2a01:111:f403:260d::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

One more ping...

On 3/15/24 09:58, Alexander Ivanov wrote:
> If a block device is an LVM logical volume we can resize it using
> standard LVM tools.
>
> Add a helper to detect if a device is a DM device. In raw_co_truncate()
> check if the block device is DM and resize it executing lvresize.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..af17a43fe9 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2642,6 +2642,38 @@ raw_regular_truncate(BlockDriverState *bs, int fd, int64_t offset,
>       return raw_thread_pool_submit(handle_aiocb_truncate, &acb);
>   }
>   
> +static bool device_is_dm(struct stat *st)
> +{
> +    unsigned int maj, maj2;
> +    char line[32], devname[16];
> +    bool ret = false;
> +    FILE *f;
> +
> +    if (!S_ISBLK(st->st_mode)) {
> +        return false;
> +    }
> +
> +    f = fopen("/proc/devices", "r");
> +    if (!f) {
> +        return false;
> +    }
> +
> +    maj = major(st->st_rdev);
> +
> +    while (fgets(line, sizeof(line), f)) {
> +        if (sscanf(line, "%u %15s", &maj2, devname) != 2) {
> +            continue;
> +        }
> +        if (strcmp(devname, "device-mapper") == 0) {
> +            ret = (maj == maj2);
> +            break;
> +        }
> +    }
> +
> +    fclose(f);
> +    return ret;
> +}
> +
>   static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>                                           bool exact, PreallocMode prealloc,
>                                           BdrvRequestFlags flags, Error **errp)
> @@ -2670,6 +2702,35 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>       if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
>           int64_t cur_length = raw_getlength(bs);
>   
> +        /*
> +         * Try to resize an LVM device using LVM tools.
> +         */
> +        if (device_is_dm(&st) && offset > 0) {
> +            int spawn_flags = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL;
> +            int status;
> +            bool success;
> +            char *err;
> +            GError *gerr = NULL, *gerr_exit = NULL;
> +            g_autofree char *size_str = g_strdup_printf("%" PRId64 "B", offset);
> +            const char *cmd[] = {"lvresize", "-f", "-L",
> +                                 size_str, bs->filename, NULL};
> +
> +            success = g_spawn_sync(NULL, (gchar **)cmd, NULL, spawn_flags,
> +                                   NULL, NULL, NULL, &err, &status, &gerr);
> +
> +            if (success && g_spawn_check_exit_status(status, &gerr_exit)) {
> +                return 0;
> +            }
> +
> +            if (success) {
> +                error_setg(errp, "%s: %s", gerr_exit->message, err);
> +            } else {
> +                error_setg(errp, "lvresize execution error: %s", gerr->message);
> +            }
> +
> +            return -EINVAL;
> +        }
> +
>           if (offset != cur_length && exact) {
>               error_setg(errp, "Cannot resize device files");
>               return -ENOTSUP;

-- 
Best regards,
Alexander Ivanov


