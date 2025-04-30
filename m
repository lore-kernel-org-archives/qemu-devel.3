Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B88C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA88O-0005X9-8v; Wed, 30 Apr 2025 10:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uA88F-0005TS-PG
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:09:52 -0400
Received: from mail-am6eur05on2117.outbound.protection.outlook.com
 ([40.107.22.117] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uA88C-0004ZU-5V
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:09:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT+YmizKncPkFMOPx1YMLoQYAWDzs2TxqsAMbY40PovzSVNdfSHGelmQ1SGo3Ui5lEf0Hggjo602LeEekabinGtO7yOh9MEDsWZan3+4DIfx3AMdwR8dmlzVichXGiPcUCBSR+Vw3nWRRo8z3v27dgoDEMIJvtUNaItlP9mR5Tz2MLCE4U0fouGo3kbu+wW2nXR+omk2GyRGDcvLPKBS6pDnfotNz/pi4ek7wpP8cYHamQdu59E95yb9SDckP1erxsIE2qK41gzqOKLFTd3+RzCSOuQHl0Q4XntPE2n5xY3xETYBxMPzP3F3/lMf6oMr9vkK6XENsuKZxZLuzyroIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG6l6DuU0ZNJq3Og+/5KgAFoW8e8fVBd4ckNu+uV33c=;
 b=AFUlcS7yYOvbxpNqHVZwWvIDDPWnFnYMiz+zzhkIzgd6L3zKOdHVCNF48l5Y2WZRz/cg5Xl6eZIvIYUWp3aoQBk+iwqR3tagTa9CZ+bZdovwuzx37ZV9iI1I5/rfsoPiJs/+4faNoqTis71UhMBYG2WE8l9vuanOJLKHQl66WdUjCtz8XK1gSRnz3WUt6SQLtavxgzZMc7uzODHiDOV/kNaxKpUiTW6F4VOtHc5xDwpr7g+XUqWw0mlOHqqFqarbwj9Rd+knLCTUJZ5ZSLXOiWEyNXO1uHvPfgoszzknUXAsWkOoiw9pDa90Le7ljxjrdYv35NHhU63n9gM/SaJTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG6l6DuU0ZNJq3Og+/5KgAFoW8e8fVBd4ckNu+uV33c=;
 b=dMeqW9+P7wiS4hlsteC46VyUGiOMYh2e8+WUl/ej05Lo2B0H4YErWqybr7ix9U+j1Oj+38lRLtEeKtsfw8J6/f2HLem9hLWI0dqsn0LtXpMrZDo3FO++qnhGgHIYPZMzi4rucym3AS4OyqfgFeGckJ8UfbMrzN0ctHb80vTrGzd4lEE0O8yAu28PIk4NEg4QFZ47+nadc0RFxQaC8n7LqLiO2Kt1p9SuKw4J83x7ophGxtdQf/derdqaFIaCqJHvGHpuPbVQfZtxQwmeLEo9RwW4Zfc4Cd+z4yewCUcm61Q44GhCrGVn2ltRVsabEzWHtza9vGdadAHsgIF1hWUXnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU2PR08MB10232.eurprd08.prod.outlook.com
 (2603:10a6:10:49b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 14:04:39 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 14:04:39 +0000
Message-ID: <d6c6916a-5112-4c78-894c-d01fd756a2f7@virtuozzo.com>
Date: Wed, 30 Apr 2025 17:03:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] Block graph deadlock on job-dismiss
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
References: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
 <32df0a6d-93c7-4474-bae5-2254e6c1ecd2@proxmox.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <32df0a6d-93c7-4474-bae5-2254e6c1ecd2@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0193.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::23) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU2PR08MB10232:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d481a7-709a-4567-ace3-08dd87eff24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z293Z2JGWkJVVnMxcW9acUNhWmE3ZFJJd3dCbUdwSUt1R3l5Y2NuaFZRbThE?=
 =?utf-8?B?cm1neEZlMTg3T1Z0RkJEaUVkdnp0ZXBCK1BhU3V1KysrOFVZYlo5Q2p5aFRK?=
 =?utf-8?B?Z1V4c1dDUDE1TzR3UXhFYlhNOTkxRmp5OEdxeU9UMkJpVUkvWVdJVlcwdDRl?=
 =?utf-8?B?NVJwV2o5M3oxS0JwM3dGaEpFUUh5YU44MllqdWRJNFNxOCtrc1hvWkh1alJ1?=
 =?utf-8?B?QXlNWlowQnBqdWdoRllXREVTRXovSE1vUksvdzZKN3M3T0s1WW40MkZxblNw?=
 =?utf-8?B?VzhqaTJBczZpYXpGMWhGanBqeEFGRXNIc050dE0zOTdobWVPWFZ5REFpd3Uz?=
 =?utf-8?B?cUl3K3FWeXYyREQ1Znd6YmMyR3NMbGEzMDIyYUI4SWJHYnVkWlgyU0RpWFJV?=
 =?utf-8?B?ajRsQnMxUkIvbkp2TmEzVDYxQmlESXZKODM4TnA3UjlEcXZXeWEwNU1WQStn?=
 =?utf-8?B?V0RWcmhWd2x2QWdtalcvVDVsTER5dEh5Qm1zT0tycXhXczlPTUV5TWpzbmFL?=
 =?utf-8?B?RlBQY2VLUENaVVo1cnFWUG4xNlAzcWZXdGhDZ3Azb0ZMNW1BSVE5dnA1YjZQ?=
 =?utf-8?B?bnhIOC9XaElUTWdhOTR4RElZS1Y2UFJBakp3djlpTWpUMkM5dWlwWGo2Umhq?=
 =?utf-8?B?akRCMmhXUVlFNmhjMGpqTHlINDMyTVBuYVFnWHpiclpFanN4UUJPTFZRbU85?=
 =?utf-8?B?M1RTc0JXU3kzaDhmMWR3TzhoQVBLT2RxZHdPY3o5NUVXYjROb2c1NkZqcGtD?=
 =?utf-8?B?Z3dJRTVXU1l6bFdjQmhuS1BhcG1HMWF6RzI3aVRHQkk0ZUNhazluNkxFSVQv?=
 =?utf-8?B?ck9pNVo3Rlg5YUtyb3ppUUhZZld6VkZSMEE3dlkzbW1tV2ZsclgrUHJ1WW13?=
 =?utf-8?B?dlNYYlB4MEx0Q2RucFdJMU1NcHFEdlR3aUc4aVdKalFYVU1zYjlkWEJ2OU0w?=
 =?utf-8?B?V0dZRlJid05nRzBDTHdLbjZRMEVxWWkvaDlZTVZUNG1rZjNjOUREbjcvSktY?=
 =?utf-8?B?UU1YdGNZdlQrOUlNUkFXOHJSTUpMOXE5dmZTak9kdWozdVhnc3RkYmJycUlX?=
 =?utf-8?B?UGVFNC9qS3VWN2F0NkNPWUF1Z2xOR3JmQU1sVU5vOEtEWnFOUFR6a3dLVnN3?=
 =?utf-8?B?VENwR1BpT29zTVVxaFR4Z1hQRlB5dzIyYzV2bzJzdGF6eDFIS0hWSWkzbHgz?=
 =?utf-8?B?NHNoVXVMRGdOQlVzVTQ3L1lWNUNRMGVweFlaMXhraHExMVNtamRMak4wN0pO?=
 =?utf-8?B?c2hkZlkvVHpiRXB4eE9TZUtzdzZwRUpwcG41YmszaXFCY3RMVFlQOURHZFh2?=
 =?utf-8?B?YTRua0ljckJzRWxDT1NGMW5NeWZtUHVDWFdZRi8ybk1VSFRzY0tKcXBlMUUx?=
 =?utf-8?B?dkFiaXFJcFZYWnRwVTdMMThjSEJjbmE5aUNadlRkbXFKYW5jMzI2ejZZc05B?=
 =?utf-8?B?R21Mb2ZLTDdrMXRuc3FtSHVjTVkrTjNOckQ5SzJLWFF5OWlHM0ZUbDJ1d0xQ?=
 =?utf-8?B?VzBtUExLaE5SNnVkOHlpSGpGSDF2dVdJT3lzamxIbkQ5d0NzMXBXQ2x3WlFy?=
 =?utf-8?B?dTR6NWsrVGdEbFYrTnJMdWJoZnI3RTZBczFxVFFFclZSbHhoK0VRRWI2VUZG?=
 =?utf-8?B?cGk0N1I2R1hhV05vZW9KUkpWaVBPTERoQzJQVEJYeStVYWFDUEZ4eitHNkdY?=
 =?utf-8?B?b2pUQTREbTBSM0dsVnFYV3poamRORHJrbjVqVUdEOVlFVXZvemdBWVVaZ2dW?=
 =?utf-8?B?a2t3OUx4bEtMRmlOT3VYaTBMcHBiUkxHejhwQnZPUEp1elRkb3NWejZ1cXFG?=
 =?utf-8?B?SnNsczZybERZNGJYSWx3TFI0L3hXSURmZFVrbnM3Qm10U3Zpay9MUlk3MVY0?=
 =?utf-8?B?Z3lNQjZQU1BOZW9yWUtSYkNzSnJ4UTd2VWR4dFlTOVhKWlpuczdNbXU0RWR4?=
 =?utf-8?Q?hE35G3XPi+Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUIzMmFVUDNnVHBEU2tDZEpDTk5NWldnU1BPYUVab0FheXZwZjh6UmMxOUJV?=
 =?utf-8?B?MU9OUElydFFBeTRYZ0JETDlxSTBsN1Q3VUgrWU5zdmlzK0JVWlAyOEdXVDFo?=
 =?utf-8?B?b0prWGlMbFkrQ3hiQWpsN3VNWmoxbU5nVlZEbFNCZk02WjZ2RlFvK3FkSU82?=
 =?utf-8?B?aFlQbnVyZFl2MnMzOFhRbU9QSXRDZGpYajRtdUl3Tm9XSk9VTGFQSGdvOGhR?=
 =?utf-8?B?QnlNWXF0QWk5RGI0bjR1Z1RxTnlQbXZOeW9PcnpHWUdzMWtTdlg4dSs2UkZr?=
 =?utf-8?B?cHU3THp0MklOU3IwbjNqZWNTWDVzNmEyVC9vWnZJUzRrb2VGenE3dGVTYWQ0?=
 =?utf-8?B?Y2JpcTZBUmRNRUluTEJlSk9FdFJabmtNcWVXYnJDUENVMWJqc2VyRCswelln?=
 =?utf-8?B?RHRKN1lVUGpxTjNNRjRsanl1ZWtoQWdXblpGK2haNDBsZk5RYkZZbnpCZ2FB?=
 =?utf-8?B?Zm5FNVc5Q0NkcW1xSFY4UHB6cmMyRW8wbU9mWUNqVjFQc1ZtQ29LbkJ4Mk1X?=
 =?utf-8?B?V3Vxbnp6KzFLWmNtVGdiM1NqZWxkNXJuWUJWZ3p5TTJwT0h6bjJsU1lTUXZl?=
 =?utf-8?B?R3Q5VStCdVQrRkxCMDhhMnVTbVV6UUlTN2c2YlJFN1lmZFhDdERMem9BcjQz?=
 =?utf-8?B?eXc2QUhQMFRuUzNyWVhBRnpUbWh6dGVQV0pET25IMEVGbzE0N0tPeEx6UFB5?=
 =?utf-8?B?YW42L1lqNW5qeWxEMFlNb2plbjlvVjZTTWxBcURDRU1PcDdLOXBHb1luQnZs?=
 =?utf-8?B?N1JQd0VDY0VSQ01oOUpFeHRzQ252ZnF0MTJNaEFJMHdoalRZZmM3VFFCQXZS?=
 =?utf-8?B?Mk9mMnR5SlBIWkVoeVEvSjRuZU9yU3AxSi94RDBSOTd6cHRhZ20zeE9uMnBy?=
 =?utf-8?B?Y000R3NyQnphQ2ZNNlNPSE9SbDROOWpROVRucEtIYWRzQndoWi8rR2JiZHJN?=
 =?utf-8?B?N04yTGZST09lSGswbWFjV3NkcDcvMUd1OFVMZlVhVjl1OTBvY25DT0VWbjFM?=
 =?utf-8?B?cHFid0tWYzBjQStTb3FnMWROb1VaWTFsZC9aUHpPcXJPUE1ZZTk1ZDQreG5P?=
 =?utf-8?B?cnU1bWVJVjVhaGxiZ0lHR3NLc2xyWVVYcmkzcnRqN3NuU2h1aWRZQjc4TXdw?=
 =?utf-8?B?ZjBEMnl1MS95Ty92WXdrbGsyV3pCc3c0VEhEeGI5V0xnUEtCTWNQR0RoVzY1?=
 =?utf-8?B?a2t1K0lIcUdxMWNLOGo2TWZYSzlCRWNxOWJtbzZKVm45SW9UKzRLZjBaeGd2?=
 =?utf-8?B?cmNlLytnK3E3UUloRDVqY2pyL2VSQnkzOXlmT0ZSRjdjWUpwOUQ3bWh3ZVlM?=
 =?utf-8?B?eDd2OVRvdjZ3TVU3a0FLb0VuTHcrZk82VUpmUVhDNnJ6SXhQS0lDNGhVWlhI?=
 =?utf-8?B?UW1lSFQ3NEh5cFZWcWIxQ3VSZUplUFJQVWNkVU82Z0lPSzRqUkdIaUhENUJE?=
 =?utf-8?B?b2I5WldNUDlWU0NKOWJ1a2lNcFptVE50Yy9YMS9IOG1WMHBQSlp5K0ErNWVD?=
 =?utf-8?B?eFFCSHp5ZmJnbXRCQ0Q2YkNNSE5qWTg0aktrTW85OStWT2MwM0MrMFpWa0Nk?=
 =?utf-8?B?clVJYmNNbDZhZ1Z6SlVIc0c5UWRwaHN3T2xZSmRSTXBwMEI2T2ZXNHhNVks5?=
 =?utf-8?B?N3c3MTEzeWJ3MU96Q2tHTmJpbnp1Z0U2YWtDNFJ0SlFOTytSdFZ6enRMV01t?=
 =?utf-8?B?WUFPK2NzaG5GUUt4Z2FMWEgzR0NUTmFjWnB5ZHNTbVdmdjV2eGNmQzRNWFhz?=
 =?utf-8?B?a2E4dGRDdTIvU0Rvd0IxZnhXRHpHU09TS3dsckllcCs0cDRhbGVhZlpKaXRl?=
 =?utf-8?B?ODl6RU5qZmVjZjg4QVNjRXJHV0N2bzkrNXZGYmo4d3VKdzd3MWpTN2I2NkRB?=
 =?utf-8?B?RnpKQ2kwUVdKU09STS9VQUFEZTBvdnJjSjBTWm5IZHNpQUd5QWxvVW5NWkNK?=
 =?utf-8?B?UThVbDNMWFR2d3pGaHZNa2pVb0JIOHNBYTNrMHBBSm5NZzdEbWRjYkJvMHhZ?=
 =?utf-8?B?UElGR3hiMnhGYW1waDBiMGZleEwvTzdrdEg3NDl0eUoxQ1k4UmQxQituek9D?=
 =?utf-8?B?TlFJcTcvL2dSV3dlblpZMFNQOEVaNVk4azlDVnhaQnIxQWFBV0FsM0dySnJy?=
 =?utf-8?B?SFdJQ0w2bTVEQlRERy9naE51VkpuMXEycUpoMWVFd25JOXFVQlJ0Wm5kc2hH?=
 =?utf-8?Q?riRtPBrD5GeNGFNjD8EBKV4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d481a7-709a-4567-ace3-08dd87eff24b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 14:04:39.0353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7WvOP+r28T9J8ISxNpUnOzb6Z9BqvzX6NG7uaG6H2YgwRIibZh0SAJTxXA+bb4mAEI1NiEW2h8v3Kr5+u+iRtTOhZvuZ83oGn9zIeQXYQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10232
Received-SPF: pass client-ip=40.107.22.117;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/30/25 11:47 AM, Fiona Ebner wrote:
> Am 24.04.25 um 19:32 schrieb Andrey Drobyshev:
>> So it looks like main thread is processing job-dismiss request and is
>> holding write lock taken in block_job_remove_all_bdrv() (frame #20
>> above).  At the same time iothread spawns a coroutine which performs IO
>> request.  Before the coroutine is spawned, blk_aio_prwv() increases
>> 'in_flight' counter for Blk.  Then blk_co_do_preadv_part() (frame #5) is
>> trying to acquire the read lock.  But main thread isn't releasing the
>> lock as blk_root_drained_poll() returns true since blk->in_flight > 0.
>> Here's the deadlock.
> 
> And for the IO test you provided, it's client->nb_requests that behaves
> similarly to blk->in_flight here.
> 
> The issue also reproduces easily when issuing the following QMP command
> in a loop while doing IO on a device:
> 
>> void qmp_block_locked_drain(const char *node_name, Error **errp)
>> {
>>     BlockDriverState *bs;
>>
>>     bs = bdrv_find_node(node_name);
>>     if (!bs) {
>>         error_setg(errp, "node not found");
>>         return;
>>     }
>>
>>     bdrv_graph_wrlock();
>>     bdrv_drained_begin(bs);
>>     bdrv_drained_end(bs);
>>     bdrv_graph_wrunlock();
>> }
> 
> It seems like either it would be necessary to require:
> 1. not draining inside an exclusively locked section
> or
> 2. making sure that variables used by drained_poll routines are only set
> while holding the reader lock
> ?
> 
> Those seem to require rather involved changes, so a third option might
> be to make draining inside an exclusively locked section possible, by
> embedding such locked sections in a drained section:
> 
>> diff --git a/blockjob.c b/blockjob.c
>> index 32007f31a9..9b2f3b3ea9 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -198,6 +198,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
>>       * one to make sure that such a concurrent access does not attempt
>>       * to process an already freed BdrvChild.
>>       */
>> +    bdrv_drain_all_begin();
>>      bdrv_graph_wrlock();
>>      while (job->nodes) {
>>          GSList *l = job->nodes;
>> @@ -211,6 +212,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
>>          g_slist_free_1(l);
>>      }
>>      bdrv_graph_wrunlock();
>> +    bdrv_drain_all_end();
>>  }
>>  
>>  bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
> 
> This seems to fix the issue at hand. I can send a patch if this is
> considered an acceptable approach.
> 
> Best Regards,
> Fiona
> 

Hello Fiona,

Thanks for looking into it.  I've tried your 3rd option above and can
confirm it does fix the deadlock, at least I can't reproduce it.  Other
iotests also don't seem to be breaking.  So I personally am fine with
that patch.  Would be nice to hear a word from the maintainers though on
whether there're any caveats with such approach.

Andrey

