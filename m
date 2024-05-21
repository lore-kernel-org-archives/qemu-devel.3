Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E1FC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Kv1-0004z5-7U; Tue, 21 May 2024 04:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9Kuz-0004xo-8m; Tue, 21 May 2024 04:32:21 -0400
Received: from mail-vi1eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2613::700]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9Kux-0006bl-HV; Tue, 21 May 2024 04:32:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6bkbCo5Kd4/KNPMBBpovYedAYb476ELaQNP8QUKNpT73yt3LhAleAstzNPJjoGq/gJB95w93OPhGUBCwRVNTJCy5wdhtPHpZIoAt7CjMmcTtj41e51Sj6ml1NKl15Zf71b74gxZIa+MUY86S+n4Buckrn3zdBJbB8ItODaKCEzBaqd9cGAMfd8YpvJsKJ9dWniCjQE0ZFyDZfDoMK3pCD/z/IUpF2xiibYKACY3OLxtS9dd+ZMrArNfFEwo6d2juHLgWFIkoA7HBsyZ1rxPD427bNXI2DYPVoosuVzDeHqgHsbw3CEKh2Qq/E9dDfAsnHk4nqm3P9FIKn/hR8rKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXQe8Y5ozV+fYMBGjHUbD5SerA1zoI5+26j/O53poiA=;
 b=WqmDzdHRfGb38oU3/f1h/4iVbxBr3mRiy1kkqC2Z2N0mXKp/YfsnAKRKHjo+MMKvoHHDd6mZ/xYWm/TLvh9XaOkzSdWh6leAzATptzBw9PapXZ9D7bVWIuSzGn0HQLamtLnznN+D/DH+QPnguhwUikcSWQm2rr3xWGy8SvAslFdrHvAuVmrSqOCDRQyzRSI692PGmWK8PsYNDS37MdYsOOiOzUx2GjfVJ94NTSPSxkwUeXGLAFlFE+CHomafLEk2DJAt9Kl1owsVvTXOS+NAUhFR1zpMxyqsQ5TebO4JdGC32DAp+8aWKG1UyHMgbhHLyJgNGjUp35UUy7OIfzARgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXQe8Y5ozV+fYMBGjHUbD5SerA1zoI5+26j/O53poiA=;
 b=GkUs3yV+aI6TpHUDMI65zW+hNDJ1g9ZmKJUgypQM3htd4K9DLdSN/KcJwHfBijXIQ1NoEzLW3m881ysmFYB1CxGBroHEk9MUZNTSznOiny1hx7HKGoCCVbmLIk37WhKss21GU6boiueg+Fehh28Uh73YAOyZMwwpQ370BBy/1OicqJiXGk2EIzibf5FopJv15q2X4cvYHfuPDj6g++y4CS7LThi5tqhnqpD+BOGgwH5xQLLcNwZxR+3d3FLco/YdFCNvKtWcHvCmZOAsK3ovig8Eidd1LUEYufg5P/jYvxuZ0iVsYqHKHQMw0lRR5cVwapzydTTbkMhmg64uB+a4iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PAWPR08MB9518.eurprd08.prod.outlook.com
 (2603:10a6:102:2ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:32:11 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 08:32:11 +0000
Message-ID: <1878d285-e50a-4818-82d8-1f17ddfa0cfd@virtuozzo.com>
Date: Tue, 21 May 2024 10:32:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] qcow2: simplify L2 entries accounting for
 discard-no-unref
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-3-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240513063203.113911-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::42) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PAWPR08MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: da1aed71-1b3b-4c10-cdeb-08dc79708282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OS8rNXQ1dFhxVmlyMGVnY3hhOU00N2JwY3R3TnduTjVyNFByWHlnM2NYWXJE?=
 =?utf-8?B?UlhSQm9WZytmMnJxR0xodVNINnNRK1N0SWkxeUZiaE44V21kd3VGWnhidWpO?=
 =?utf-8?B?VWNzU2FsYy9uLzBjS2hWbGRoWFZQeHVacGIvZGREdHRJeGZEZ0tVM2FRVk9K?=
 =?utf-8?B?bm0xTkdVRmpGekE2K0lEQW43Tkc5bzFLZHFWYVhoUXlpbEZXZmF3cmQySU53?=
 =?utf-8?B?RnRJTXhqaEpUb1dFcXhmWk5LanpveFEzbVFoak9JRkJLUjJsRzk4NUhsRWtw?=
 =?utf-8?B?ODcrOHBxWUN0YzJZd2pFOEFGZFo3S0RGTHhOUDdIclEvRHFNSnR5YmdBeSsw?=
 =?utf-8?B?SVAySmorSlpqV0FFbU9ISjMrZUJXNGtXUmFEOFkxa3h3RFVqK283NTExTVY4?=
 =?utf-8?B?bkZZSHMzQWkwY1lMaGxnNG5Nd3RWSmMxbDU3N2hyaXN6WUM5dFlZRFZ1TGNC?=
 =?utf-8?B?bGxlb2E0MTgrYWMySU1WQWRNTFdpMlphaWU1UExjQnVaaExFaWRNSGJKZ05M?=
 =?utf-8?B?RkJjOFdLTG83a29ZKzZqMzZYYy9SNEJQTHBibVEwZ0NwRkw4Z2hYSnN6bFpW?=
 =?utf-8?B?SEtMMlU1ekxQZlNlYjFrT1ArUUtGWERYdW5rQmNrZUZ6RDZhNnpNMHpzWWdS?=
 =?utf-8?B?T0lCWGlrSVVna2RGMjhGeWxKZE9XS21ySXA3S1FFV3BqeTlvZ0hJQTZYWkRC?=
 =?utf-8?B?NDF3a04zZmttL2pzVE1DeHR5R3hpVGhIVzVGVkt3bXZYd3JRM3NMdG9rWGpK?=
 =?utf-8?B?L3BHVS9RUXdoQ3V4Q3o2QmNIZUVGbTJnMEdHUWhybFZQOXhtSDBsNUY4UGhS?=
 =?utf-8?B?NFpYWHdJaDRNOSsyNkplY2JuRnVLc25JWVlHOWdqZkRoTlNJRFNhaExIc0Yy?=
 =?utf-8?B?SUorYkVUQTB0NjA1S2JuTjFMSXNycnF5MnJPbU1PajFGd2tYdVVJQXFmY0xR?=
 =?utf-8?B?TS84dExSV29nMjViUnYzZGlKOW9MM1RxR1loR25VVUNJRVNmMzd1UDkyTlg0?=
 =?utf-8?B?NzkwSjdPbEFkMXFWK0V3dHVhNFJFRjNSNlZkemRLNEJ6V0NwZVZNa1JSczRh?=
 =?utf-8?B?TTVSdzdmNlEzU2ZXZzkwUnVyWWpUVU4rZ0t0aVpyNG82RFJtYUdzZWhxTmZy?=
 =?utf-8?B?Z2hiWkpBbk51ZEx5cDc2OXdDUkdGdjhLZVJ2MkVRQTJvV1N2NFRLdEprSkps?=
 =?utf-8?B?MGlMNDBkK3lyeHNhSENBbzVpZWsrcDcrVmRIeEJGcGFLSmlGU2tIc0MvRk5O?=
 =?utf-8?B?QzBEeXp0MzJSYW9kNkMwVXFRS2dnMEM5VU9mV05pQnlrQlJUVVdHcnMyUnRt?=
 =?utf-8?B?dUo5Zk9oS3N3ZVdqN003WkwzMkpDbUZmQ3BEeHZiM3VpZjVMUW8rU1BaeWlY?=
 =?utf-8?B?bzdWOFdBM3JjR0lpVjAycUlyM3I1SEU0blVxMFlYOFBsNk4vNXZRaDB4d3RU?=
 =?utf-8?B?NDFSSGZoc0ZmRDBOellDMW4ycFIxYndjcW16RXBTRkswbmlIMVErU2NPYWc1?=
 =?utf-8?B?WkZqRHRyVGlaaEFHU0lCV0JwTEJpMFF2K3A0cEtwanlPVGljdFJsdElIS1Zn?=
 =?utf-8?B?dk9NdjdHQ0pxSUlHaW1pcmo2L0tkM0YxekZ1NTl4MzY2WldMS0o1eXp1aVp1?=
 =?utf-8?B?VXlqQ0RmYURZMUZJREwwamR4QzdLK2djYk1acUFQVE8xQ3VJendLdCtRbS9N?=
 =?utf-8?B?S2YzQkVXdEtEZzVERTI3eUJaS3VOdVZOL3ZrTmtKK0VTdnNHZGZvS093PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzBuNFM0bGFZLzMxMHVEV01xbkhsTnlEcVNjKytiTjhibzAzT1UwelJjUUQw?=
 =?utf-8?B?ZG5WWWV4d2Y1c0Q1aFNFWkU1dEswVzRTWjN5dVlkNENGZzFKc3grT3ZicUla?=
 =?utf-8?B?dU1mTGEzcm1WbWF5TVNrNmhtWTVOdWdndEJCajNsaUVmR2tSMmd0NmNYQmtN?=
 =?utf-8?B?YUJCMWRaYXoweVRRM1NFNFoveUJVck5UV3kxUTJMc0phbUs4QVhSdy9JZGR4?=
 =?utf-8?B?bEo3QzRvb2xWOFUwdEo5a01wUmp6b1dadVkwSFV5cEpRc1BBWjFZeDFiVkFo?=
 =?utf-8?B?aHBXbmp6SVg0Qi9wRzJGa0h5bGJYQThadUZndmtCeFh4L0JWVmRYM3RySTk3?=
 =?utf-8?B?TFB3Y3ppV1dwKzRiTnN5MThud1lBZmZ1N2drV0ZydHBSbytJR3RxOU9uYXBS?=
 =?utf-8?B?c21BTkJCWWFTbjlsa0RvTFc0VlZiTlBrcFovQkd3aCs3WWJsUll4a1ZHTzFO?=
 =?utf-8?B?YXpBOXd5LzZEdjNSdjlkRnA5TUhUVEhkS0NoN3RKVXE3WkNRYm5VUTUzVFlr?=
 =?utf-8?B?bFdFRmFwL3Z4cmpJcWpNZ2FxZGx3QUtFZHFQQjc2TnBIbzVZWnA3TWJ0L1ZC?=
 =?utf-8?B?M1dETktualZER3NvV0c5ZVJoR2FvZ1IrbmVTRmpvc0xjZnhKUXhDaUFoNUFU?=
 =?utf-8?B?Mm9wVndsS20zVnI1d2c0NnM0NnNhSGs0UGJiZkZvRVNMd1BiNVdJZStXdncr?=
 =?utf-8?B?OW5NWkptR1BvVUNBOEZuUnFjYjJUU3grQVFCTktCT1ova0ZIZGFTTFJZQXJK?=
 =?utf-8?B?THJtTW94QWNnUDV6YXhTZmNMS0NNdjBOOWpnZ2EzYXhISkR5dmJ2cEVjWTZN?=
 =?utf-8?B?OFAwUlpMYzF0QWhFVkhqS3drUFFuZ1MwTDBpQnRiL2tKRjR6TEplbUpoMXF5?=
 =?utf-8?B?U05QdnpnaFM2MllXYS9WVVdCcE90Zmk2aEVPSm5oQjRXREV0dGVoc0tzelRp?=
 =?utf-8?B?amVSRkJnRExtSm56cVdVR3owamlseG9adDlWWGlwUkozWG1ZQ3pacHlHUWpU?=
 =?utf-8?B?L2RVblhOeWJYY1JiWkpReUJtK2FHdnN4V25EYUxNR0NLNHN1TVVkYmZ3MDdP?=
 =?utf-8?B?ays1RGtjQ3JJVUpCQ2NyemthbDNkUWtqb0VHN0s1bittTFBOWUZ2aU96NXZ6?=
 =?utf-8?B?OWFQSndLNXdneEd5bGlndHpQOUhkMFRlMWZ1NklMck0yQnVMUEVOb3R1ZVlk?=
 =?utf-8?B?YWlYbnN4U2haWmNJUXZtWkVBYUUxMGVjTDVUL2xkT0E0ZWxMS2h2SWVvWERR?=
 =?utf-8?B?bnl6T2ZHdDFsUVdRTHhkaldyeTU1TDdEWDlSVlNncXhXSC91dkxtaGV3K09w?=
 =?utf-8?B?aDFHeEVKN0llTFlBNkVLZlgzdUtMcmdDUlU0eVY3eUZ1WnUrV2NTR2JEMlFC?=
 =?utf-8?B?c0dBQkNoc1lYb3h5bStoWFBQYTQvdlNyWHV3Z2tTN1V0bUVvRFlLMnhhRUdR?=
 =?utf-8?B?WUtpUXF6VjlnSTd2QWV1VHo4bmp2YmYwa2I1OHhWZFRUOW1yb2srUjc1dGhK?=
 =?utf-8?B?VVJ6ZGtrcE8yaTRqWUk2a2JjSExSNWJUMHlGRm5KQTRMQjBlNDFrdnZDWWlF?=
 =?utf-8?B?L0dnMTNxeHVZZmZiYm50OG1NcmIvVnl1VWt5dy9relBRTWMvUys4Y2hqV3ZJ?=
 =?utf-8?B?NzNkYWpqMzRkR2xiN1ZTempscUJFeGVHYkRrRDY2WStZQ2NLTklyYWJZT3Bm?=
 =?utf-8?B?TmhoY0FhNkV6Z1JEbVU4UG9jTzROOXQvdSszeW56WFFtVksxdUQxVUorS2RK?=
 =?utf-8?B?aFlIdXlrYTNtMmpSQW9RVWxUem1UTHdwanc4MGEzNTc0amVPTjJJaXVEaGkx?=
 =?utf-8?B?RzJDUHB2a010bVN5ODJObUpyU1NZVXVvdFRDc3ZkVEljWUhlR2NZV041RHFh?=
 =?utf-8?B?YmNxUkZjK1R3cWRlZ01PQldjNythdm14U3Z0dTZpU2xwa3lVdFJmdFVoeHZM?=
 =?utf-8?B?MGtZdXorZWV2MVYvNjhaY0haV3JFbzRzdFROOHpDa3hQQ2YzU1BUZnE1M2Vy?=
 =?utf-8?B?aXJvYmlTcDVWR0lWTDU5ZzVZWGtTWFNLL3czZXIrdE96THdaSTNXSlZ1djdn?=
 =?utf-8?B?YUI4b3Eva2w2UFhOR1RiU3RObDV5dUZQUmF0aDd6K3VOZ3RrbmJBSkhnTVFZ?=
 =?utf-8?B?dDgzdy9MaFFBdkdoVmt3ZkV6eDl1SDZJYm52T0JlSmJobXJSakVzMGRLZWlm?=
 =?utf-8?Q?BkLdFoZQp3BD6ytmho/kkaI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1aed71-1b3b-4c10-cdeb-08dc79708282
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:32:11.3822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUDK4QmY6wHUThee2hMkFFYuVmb0ex2FLUEP0IMAK6zRvk+5n1+VmUijXuoUC7gQQVu1K6N8H5ykEnH7RyxeKJ2e7qklmGhe1f38EkLwe2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9518
Received-SPF: pass client-ip=2a01:111:f403:2613::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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



On 5/13/24 08:31, Andrey Drobyshev wrote:
> Commits 42a2890a and b2b10904 introduce handling of discard-no-unref
> option in discard_in_l2_slice() and zero_in_l2_slice().  They add even
> more if's when chosing the right l2 entry.  What we really need for this
> option is the new entry simply to contain the same host cluster offset,
> no matter whether we unmap or zeroize the cluster.  For that OR'ing with
> the old entry is enough.
>
> This patch doesn't change the logic and is pure refactoring.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-cluster.c | 34 +++++++++++++++-------------------
>   1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index ce8c0076b3..5f057ba2fd 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1946,25 +1946,21 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
>               new_l2_entry = new_l2_bitmap = 0;
>           } else if (bs->backing || qcow2_cluster_is_allocated(cluster_type)) {
>               if (has_subclusters(s)) {
> -                if (keep_reference) {
> -                    new_l2_entry = old_l2_entry;
> -                } else {
> -                    new_l2_entry = 0;
> -                }
> +                new_l2_entry = 0;
>                   new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
>               } else {
> -                if (s->qcow_version >= 3) {
> -                    if (keep_reference) {
> -                        new_l2_entry |= QCOW_OFLAG_ZERO;
> -                    } else {
> -                        new_l2_entry = QCOW_OFLAG_ZERO;
> -                    }
> -                } else {
> -                    new_l2_entry = 0;
> -                }
> +                new_l2_entry = s->qcow_version >= 3 ? QCOW_OFLAG_ZERO : 0;
>               }
>           }
>   
> +        /*
> +         * No need to check for the QCOW version since discard-no-unref is
> +         * only allowed since version 3.
> +         */
> +        if (keep_reference) {
> +            new_l2_entry |= old_l2_entry;
> +        }
> +
>           if (old_l2_entry == new_l2_entry && old_l2_bitmap == new_l2_bitmap) {
>               continue;
>           }
> @@ -2064,19 +2060,19 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>               ((flags & BDRV_REQ_MAY_UNMAP) && qcow2_cluster_is_allocated(type));
>           bool keep_reference =
>               (s->discard_no_unref && type != QCOW2_CLUSTER_COMPRESSED);
> -        uint64_t new_l2_entry = old_l2_entry;
> +        uint64_t new_l2_entry = unmap ? 0 : old_l2_entry;
>           uint64_t new_l2_bitmap = old_l2_bitmap;
>   
> -        if (unmap && !keep_reference) {
> -            new_l2_entry = 0;
> -        }
> -
>           if (has_subclusters(s)) {
>               new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
>           } else {
>               new_l2_entry |= QCOW_OFLAG_ZERO;
>           }
>   
> +        if (keep_reference) {
> +            new_l2_entry |= old_l2_entry;
> +        }
> +
>           if (old_l2_entry == new_l2_entry && old_l2_bitmap == new_l2_bitmap) {
>               continue;
>           }
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


