Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94299C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 14:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Pfz-0000Q9-Br; Mon, 28 Apr 2025 10:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1u9Pfx-0000PU-DB
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:41:41 -0400
Received: from mail-am6eur05on2125.outbound.protection.outlook.com
 ([40.107.22.125] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1u9Pfv-0002fr-9y
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:41:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh+IBbNRt98QmP6Q4tv6vEzMAYw6z9lnksjmTh6d+TAQJeZp2lXMZIynH0hK0rCHjPYY34b1PKndaA5Opo1s6H2SLEbTIHgzq2vc9iDr5wkGN3XzWK3jK9GEM2Lv2uPmTb5sJ97pZ/0x0KWwN0QrZC7E8Sm07m86ga904n7AccNqmXT0Y4ieXc0s5gnm2kB2DjF8MZV9oEFdymRiu7qhHfQB47FNNkLBo7S+khn3P091tzsGe5Fde1ZFOkv4SpksU6vXtIeAy9xTn/37AFRF3v/FWt+Ze+qntIkdLctThyUDSPLNH3srQuf6qChtsJLYWhGRif4TWOvhVIl0D0V1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL0R45ARcKlcT723+tPDikCEJjCiHjEdhPTcLqbE3kQ=;
 b=VQhCEpTjrlUm4xDLpGwvc5klihJoOHL38D2J3JfJk6mnovrqupc5zQBQGUGkLuWIEfakvcGHfXe4ySuo1fbqDnFCX9RWXtnpK01aJegSvV+l04tamVR+wJqQ5Pz0DIqp04aJ6ndtVCGjZby+irTuiIPMaVARkNqGXI1B/9exTFOzmHTMmj6L9MFECNnqk9ld0201iyYFex8qnC6CdrNBq7TvuzfqhDVYKWYcB17bQARdR7Ms6hZRGormt9zT8GVqvx7Wng4cQmDbYNmEr4ZZbRS4wZoMmVXhGGfJfXmC3/Mdtwn3W+GhLbLENvPqFol4t0Ou7G0l3ugpwo81+MHKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL0R45ARcKlcT723+tPDikCEJjCiHjEdhPTcLqbE3kQ=;
 b=LvlRzSaK5FGmRKgH+n7XlEzw7AtDasWdRme6rud5JRFSFx8HDmjVZsmoE8g67o0iKDQUro65pREiYJaoWR6INC7mTlL77FfieyDOST+pqP4tzjrVbnovwjxX6FBeH21uOyLfEH/pzhPeIaaZ2MCJPZ2S4ybq/WUhmBrfTrHcU2JOv0ExceJJTmILaN4SEAwuGN6BecA7WcED7bNqUN60LKimbcyBYFKkE98geuRlSSN0BX1uhZRGlGmse79fB2ndhC3gn3f6DJTw9mxlk+svXK9ff0ltimXeTPban18xjr7rlaWVCnBsDF5rqL+hq/zRKmJxUU2ix6NpwEbtJdczpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB7937.eurprd08.prod.outlook.com
 (2603:10a6:150:8e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Mon, 28 Apr
 2025 14:36:28 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 14:36:27 +0000
Content-Type: multipart/mixed; boundary="------------Ts0ZmfPjfPrvTnRBMaNU5BmU"
Message-ID: <4a384d72-fae7-4b83-acfb-7b8abaf21de7@virtuozzo.com>
Date: Mon, 28 Apr 2025 17:34:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] Block graph deadlock on job-dismiss
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
X-ClientProxiedBy: FR5P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::16) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfdc359-c0b2-4c4e-4e27-08dd86620f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWs1YmE0L0VieHcxbEZRU21ZZjNCcmFXaTFrbXJBRWFZVjRBd3NLay9jaXRL?=
 =?utf-8?B?Tnc4cGQxMWU4NnNoV0NDNWpKSjUwU2JWZ29pUE1xYUZRUHpiemlNUVdHbnZR?=
 =?utf-8?B?citIbTQ0ZjNjMFVQR2JUU3NTdHd4M1huekt1VzBuWkMxd0NXcXQvKzZDSzlo?=
 =?utf-8?B?K1BQdVp6Z2NneTJQdUJIeS9UQW9mcURlSnNkZXhpcFdqakUvNnFEYjN5N25p?=
 =?utf-8?B?c25aVFgxKzdSRjRWNE1JWG1LUURBT2JRT1pMa2lnRUNhNTl3dkpwNm1HSlZT?=
 =?utf-8?B?Nm52alFXQUI4WW1hRE56bWM3QVJOMWNwRGlYTWM5YTI0K2Riakk3c2hrK0JU?=
 =?utf-8?B?T0xYbXY1dFM3cUFOYUM1ZTBXSHA1L1UwL1pHaXVZV0VLdG53Z2YvdXJ5b2NO?=
 =?utf-8?B?ZFRxaDNwU3BwcTlTQ3p1YUwrbUZvQXZhNG1pMlZLVWVTalZwTnQrKzhUWTNH?=
 =?utf-8?B?RmVhVWI4S0FsWWJINEdtTU5xS2hKRzRUcEV5RnMrYkJVY0ZkNEkvSE00UGhK?=
 =?utf-8?B?aDJxOC9NT1VPQW50bzAxQXJ0Um43djF2ZTl1Si8vVFFXN09ubElOdmNNbldE?=
 =?utf-8?B?akxoUDA2dFAvQnVVemh1WnpPdjBDRm5uVUgxOGxjbXNDSWFxbkdVZGtWOStJ?=
 =?utf-8?B?N240eXo1bG1zZE10cklHS2RmVGVKSHQzMDFVbDdqcVViWkRBM0xrelpQSWFR?=
 =?utf-8?B?TnpZaUV1TzY3c1dTQzZFMkdna2RJckNwYWJRNkZuTFNicVN3Sm1ScVRja1Vk?=
 =?utf-8?B?R3N0ZDVmNDRoUW1OTk9kbXlQUVYyZmo4TDBPbjFhL01qZ0ljQnZZNHhTK09Z?=
 =?utf-8?B?Z3BrWVVmOTVHdzVsR1NlY1pCaFFKSCswaEVQRDkrWXk0NnM1eFlCRC9ZcDU0?=
 =?utf-8?B?NkJaZm9lMjJCbE5TOTZoN3Y2bWFnQWVSK0ZYeFJ4MXFwdTJzVmg5SXd5bnc4?=
 =?utf-8?B?L3lZdGFudDNnSjdvZkVKeWtlYlJoVXppdlBKcTB4dWx3WkhFSWk1cDJrOXdR?=
 =?utf-8?B?UDlCbDdkdCtCOVpnZXhhSEFEL1ZJR1BDR0RZcy9CWW9tSTFOV2tUSUwwMk1l?=
 =?utf-8?B?YWJJNnpTK2licUNBY1hmMEg1SExoc0gzMkx1U0k1bFZxSGN1aHB1NCtoRDFj?=
 =?utf-8?B?MDhsMEl0a1VKNkE5eDlBNEw3RFVMdnllak9ySkRGMzlBMHF4Um84TFJPNzhw?=
 =?utf-8?B?RVFLWnROb25kSlRYTE9JeThKbVVFUVU0OGlnc2YwWXVBbk4zNXEyZ21IeWs3?=
 =?utf-8?B?cXJ0K3M4NDFwbU5XZXRsUFlzNTBlem9tS2pkd0huVXNWMDRNZjQ3bk5tTHNm?=
 =?utf-8?B?bE9PZE9hMEI4aXMxbVd3cTJFeEEybTFyQ09WcEVZMnF3YXJUcGxsQWl2a3Ri?=
 =?utf-8?B?TUpPT1NqWGRTTHRpOCt1KysybkhldTNWUWtTMHJrTEN0SEszd1JYSC9GZG4r?=
 =?utf-8?B?cHFVeHRXeFlNUTdXL2RzcFlDTExHOXNRMVk0d0ozTFM3WGkvQm1nMzJSbTlw?=
 =?utf-8?B?a1ZvSnI3U3FlWi9UN3kzSVpORUY3VU1MQ3ovekJDSEpNNkU5Y3ZWTE1lY09U?=
 =?utf-8?B?NjNtMDY2SjAyR3RtK2xNZ3QxaVRTS2t1WmhFb2RNR3B5UXNwTitnRXhtcVVY?=
 =?utf-8?B?bW9nL3YvcHhsSXZ0L1hRYkFwRUduMEpCV1BSMElCWG5WdTdyYmdOdENmKzZr?=
 =?utf-8?B?Q0pGYU54cVZzZnhIRWwxakxzdVRjWngzTUZNemk0b002QnhBVEVPY3VTc3F0?=
 =?utf-8?B?OHNEQkJuTHZ6ejRUc2RtRXl0bzVlUUZ3MW56YzEwOWlPd1hCNHViTUl1b2tj?=
 =?utf-8?B?WnZ6ZFB5Mm9pelBXMzcvVDlqN2ZLUHdwMzFGejBKMnNkeTFsb0M2QkZLbGZs?=
 =?utf-8?B?aHpsbmRwWEx1dmFQSmNNWjUyTkNhVE53RmxnemxQc2U2MFhKYzNNVlBHaDdn?=
 =?utf-8?Q?EyxbAq7VOXg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(4053099003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QitlSWUyMTZvd2RTMVVoczkwaGd2NTFuTzc2OG9QV0o3UXNXSWc1QzRQbStT?=
 =?utf-8?B?S0JlSi9mQXpHTHBTaEVRbkZBQlA3ZlpvUFF0MTYrb3hucGhqQW9icXZDRFhu?=
 =?utf-8?B?N0JSRllqZSs2MGdNd1BMZVgwOGhGNnlmakViSFl4QW1OK2Ribm0zSlFMUnpX?=
 =?utf-8?B?c3BTOFhRaEtoN0ZwL1d3QUhtZWFrc1h5bmJCWm9ITnB0bUZ6aEtjS1Rhd1hO?=
 =?utf-8?B?Z251TzZNRmhsS21oNDB5WXIvbHUzUzlvSEtjYlplN0RJei9KdU9xOXFER2Z5?=
 =?utf-8?B?UjNpTEdDTnVPYk8zMG5GZmhtQldVdjYwdU1OT0xZb0dpTGZURWY2TG5kdjZ3?=
 =?utf-8?B?R2ZHWjIxcnI4dnJZUDh6dlNxRUl5cnBCSVQ3Ym5wYVlyNVFYb3hQdDVTczBp?=
 =?utf-8?B?TlM1ajMxVVJ3WFJOUTlaVkRqR2ZkZExRZnNkbFZxZlR4dzd5S01qNEZsUU4w?=
 =?utf-8?B?K1VVQTZ4UUJhSHp2aWNzZEk5MXloSVVxbDV4Vi9NMVBNbWxiR2ovN0pVcERT?=
 =?utf-8?B?YWZtT3RRTjUyZ1FsR3RsTVZWS292SEdzOEFoZ2xuS1Eyakt6NURKbjB1Qnh5?=
 =?utf-8?B?bWJibmxhQVF5YmdJdzA0TlpsY2E4RFZxbmlQcGpaMzRoR2ZjVm5ZN3VkZXJM?=
 =?utf-8?B?NWI3dWs2bkp0NmltUVZaY0pyeGRoaWhMZ3hKdFVUcEFxVTZ3UEhhaDFOaEVO?=
 =?utf-8?B?bTVsVTBGZkE4allBblhyVHErZmRyUmdkWmxHbkI1YW9uSDZqdDU4eG1pYkdG?=
 =?utf-8?B?U1pHOFFCcDVUakVreDBTWmNVN29mVms3V29EaEhSeEVPZlorb3JMaHo4dVdI?=
 =?utf-8?B?SFYwcExJbnlpdlJKVVBkdGJSQ0hjcDQ0dkRzWmxxWlNHRWpGcFNXQUpNbWtr?=
 =?utf-8?B?NmdCMy9qSGw2OUoxSGRDdWhlQU12TmloNVFKaGpISzlwaHhtOVhJQS9Zckw5?=
 =?utf-8?B?M3B2OW9FTzJIN093d0IyMHkzb1IrYzM4dm1YODlhS3lad3V4VFVOd05ISjdC?=
 =?utf-8?B?aTFlNVFqNm81NmorMlY3cHdOeGJrNUFaWnJzN29vQVRjWk5MSm03YS8rajhq?=
 =?utf-8?B?cEtSczF6ZjhtNTFOS0I2b2pDS0VmR0NPcW9WM2dkWkdhYWo1Yk8rOStPM1RT?=
 =?utf-8?B?cHlLc0F0a2FSUGRqRkxYWXRnTnAyNjY3ZlFHaXl2V3RJRDVtcDVYVmNmbXF1?=
 =?utf-8?B?VTBVODBvY2dyZlVockFUTjNlNjhzVVBuTTVOL2ZNVjdCSkEyK2dlTFdZTy9Y?=
 =?utf-8?B?eW40bXV1Y2JxRzlEVTAzblV0ZVQ4Q3k1QTVWYUpoV1c2THBTb1dwLzBKbzRt?=
 =?utf-8?B?OGs3b0I2ZGdGVTlvUWVqNHVuQnNZWkdaOVBvRFFQN2prV2RkWW5hQnk1ZjI0?=
 =?utf-8?B?MFI1S2VaQ05NMnpDcU10Nm5iNGZkdHl4eGRScGo1MjRRQjVIcUV2Vjd4K25D?=
 =?utf-8?B?TzRtMzRsUnRCamlhUnZ0bkdMQlV5T0FkZkQ4NUx6WGs3ZXJEL2ZycmZ3d2Ez?=
 =?utf-8?B?NEc0c3lNQ1hLUU0vTVR6aTBpYjU0QTFmbVlZQ1pUMlRsK1dsQThicEpuU3Bl?=
 =?utf-8?B?eDF0WGVRMHRFZVU3MHRaOHZkZVpBOXZYbVFmbi9EVVc1eEgxR3JpMXo0R1Bi?=
 =?utf-8?B?UStDek0rVjN3czNTWWtaZVVUc1BIWnQ3a1FpcjhFT0RqczZOLzBleW00MFo1?=
 =?utf-8?B?TEszbVlCZTkwUCtkWWc1SDNFS3BaMXNUTWtjOUkrOXNKWjdUUFlJLzNPRmpV?=
 =?utf-8?B?ZEtsb1BzZE9jcXZIMFhMV3U4OGh4ZEp6L01xaEtnaHREcTFCcHVuTGN0WkhV?=
 =?utf-8?B?d21Rd0NybnJubXdrMDBGWGttN2doQ0s2aTl6RDdBdzVwcVBSVXg1c2NMTzNx?=
 =?utf-8?B?NGp6S1ZkaEJXOFB0b29XSzQzUGYxaEpnVXZmTWp3Sis5ZkwrU0VMSUlxRjVS?=
 =?utf-8?B?cXduNnhMVms5V0x0aWtMVGJLTU9yeG5xakR6cW1QQzhJUlZVTnRnVjRRS3g4?=
 =?utf-8?B?WHBwWXEvci80NEFsSmQ4VEYvTEcwekpVODFmbG5obGdRazlQcUc4OXk5SnJU?=
 =?utf-8?B?aFYrK0hVa1pZNldOeVh4dVFhUmdlaU5ZK25vRzNRSCtXZFU3a1Y1bDJhc2xP?=
 =?utf-8?B?R3VCdHFsOHBEeVFZODJWV2k3L3FmaUFjbGs5ckZBemJweXNaZVdhZDYxa25k?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfdc359-c0b2-4c4e-4e27-08dd86620f3b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:36:27.9067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y73d5ypwVNtSKL5BFxjvy0vtH1keCym4kHJOo0MMPumaoyu4TffcU+dPQG78pqYCbeeEQxGHimTZOcyloWwSCdx3XHv1HvQxQeYA4xfGiGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7937
Received-SPF: pass client-ip=40.107.22.125;
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

--------------Ts0ZmfPjfPrvTnRBMaNU5BmU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 8:32 PM, Andrey Drobyshev wrote:
> Hi all,
> 
> There's a bug in block layer which leads to block graph deadlock.
> Notably, it takes place when blockdev IO is processed within a separate
> iothread.
> 
> This was initially caught by our tests, and I was able to reduce it to a
> relatively simple reproducer.  Such deadlocks are probably supposed to
> be covered in iotests/graph-changes-while-io, but this deadlock isn't.
> 
> Basically what the reproducer does is launches QEMU with a drive having
> 'iothread' option set, creates a chain of 2 snapshots, launches
> block-commit job for a snapshot and then dismisses the job, starting
> from the lower snapshot.  If the guest is issuing IO at the same time,
> there's a race in acquiring block graph lock and a potential deadlock.
> 
> Here's how it can be reproduced:
> 
> [...]
> 

I took a closer look at iotests/graph-changes-while-io, and have managed
to reproduce the same deadlock in a much simpler setup, without a guest.

1. Run QSD:> ./build/storage-daemon/qemu-storage-daemon --object
iothread,id=iothread0 \
>     --blockdev null-co,node-name=node0,read-zeroes=true \                          
>     --nbd-server addr.type=unix,addr.path=/var/run/qsd_nbd.sock \                  
>     --export nbd,id=exp0,node-name=node0,iothread=iothread0,fixed-iothread=true,writable=true \
>     --chardev socket,id=qmp-sock,path=/var/run/qsd_qmp.sock,server=on,wait=off \
>     --monitor chardev=qmp-sock
2. Launch IO:
> qemu-img bench -f raw -c 2000000 'nbd+unix:///node0?socket=/var/run/qsd_nbd.sock'

3. Add 2 snapshots and remove lower one (script attached):> while
/bin/true ; do ./rls_qsd.sh ; done

And then it hangs.

I'll also send a patch with corresponding test case added directly to
iotests.

This reproduce seems to be hanging starting from Fiona's commit
67446e605dc ("blockjob: drop AioContext lock before calling
bdrv_graph_wrlock()").  AioContext locks were dropped entirely later on
in Stefan's commit b49f4755c7 ("block: remove AioContext locking"), but
the problem remains.

Andrey
--------------Ts0ZmfPjfPrvTnRBMaNU5BmU
Content-Type: application/x-shellscript; name="rls_qsd.sh"
Content-Disposition: attachment; filename="rls_qsd.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKClNSQ0RJUj0vcGF0aC90by9zcmNkaXIKUU1QU0hFTEw9JFNSQ0RJUi9zY3Jp
cHRzL3FtcC9xbXAtc2hlbGwKUU1QU09DSz0vdmFyL3J1bi9xc2RfcW1wLnNvY2sKCnFlbXUtaW1n
IGNyZWF0ZSAtZiBxY293MiAvcGF0aC90by9pbWcvc25hcDEucWNvdzIgMUcKcWVtdS1pbWcgY3Jl
YXRlIC1mIHFjb3cyIC9wYXRoL3RvL2ltZy9zbmFwMi5xY293MiAxRwoKZnVuY3Rpb24gd2FpdGpv
YigpIHsKICAgIGpvYmlkPSQxCgogICAgd2hpbGUgL2Jpbi90cnVlIDsgZG8KICAgICAgICBxYmpv
dXQ9JCgkUU1QU0hFTEwgLXAgJFFNUFNPQ0sgPDxFT0YKICAgICAgICAgICAgcXVlcnktYmxvY2st
am9icwpFT0YKICAgICAgICApCgogICAgICAgIGpvYnN0YXR1cz0kKGVjaG8gIiRxYmpvdXQiIHwg
Z3JlcCAnInN0YXR1cyInIHwgaGVhZCAtMSB8IGF3ayAne3ByaW50ICQyfScgfCBzZWQgJ3MvWyIs
XS8vZycpCgogICAgICAgIGlmIFsgIngke2pvYnN0YXR1c30iID09ICJ4cmVhZHkiIF0gOyB0aGVu
CiAgICAgICAgICAgIGVjaG8gLWUgIlxuIyMjIyMjIyMjIENvbXBsZXRlIGpvYiAkam9iaWQgIyMj
IyMjIyMjXG4iCiAgICAgICAgICAgICRRTVBTSEVMTCAtcCAkUU1QU09DSyA8PEVPRgogICAgICAg
ICAgICAgICAgam9iLWNvbXBsZXRlIGlkPSRqb2JpZApFT0YKICAgICAgICBlbGlmIFsgIngke2pv
YnN0YXR1c30iID09ICJ4Y29uY2x1ZGVkIiBdIDsgdGhlbgogICAgICAgICAgICBlY2hvIC1lICJc
biMjIyMjIyMjIyBEaXNtaXNzIGpvYiAkam9iaWQgIyMjIyMjIyMjXG4iCiAgICAgICAgICAgICRR
TVBTSEVMTCAtcCAkUU1QU09DSyA8PEVPRgogICAgICAgICAgICAgICAgam9iLWRpc21pc3MgaWQ9
JGpvYmlkCkVPRgogICAgICAgIGVsaWYgWyAieCR7am9ic3RhdHVzfSIgPT0gIngiIF0gOyB0aGVu
CiAgICAgICAgICAgIGJyZWFrCiAgICAgICAgZmkKCiAgICAgICAgc2xlZXAgMC41CiAgICBkb25l
Cn0KCiRRTVBTSEVMTCAtcCAkUU1QU09DSyA8PEVPRgogICAgYmxvY2tkZXYtYWRkIGRyaXZlcj1x
Y293MiBub2RlLW5hbWU9c25hcDEgZmlsZT17ImRyaXZlciI6ImZpbGUiLCJmaWxlbmFtZSI6IiRT
TkFQMSJ9CiAgICBibG9ja2Rldi1zbmFwc2hvdCBub2RlPW5vZGUwIG92ZXJsYXk9c25hcDEKRU9G
CgokUU1QU0hFTEwgLXAgJFFNUFNPQ0sgPDxFT0YKICAgIGJsb2NrZGV2LWFkZCBkcml2ZXI9cWNv
dzIgbm9kZS1uYW1lPXNuYXAyIGZpbGU9eyJkcml2ZXIiOiJmaWxlIiwiZmlsZW5hbWUiOiIkU05B
UDIifQogICAgYmxvY2tkZXYtc25hcHNob3Qgbm9kZT1zbmFwMSBvdmVybGF5PXNuYXAyCkVPRgoK
JFFNUFNIRUxMIC1wICRRTVBTT0NLIDw8RU9GCiAgICBibG9jay1jb21taXQgZGV2aWNlPXNuYXAy
IHRvcC1ub2RlPXNuYXAxIGJhc2Utbm9kZT1ub2RlMCBhdXRvLWZpbmFsaXplPXRydWUgYXV0by1k
aXNtaXNzPWZhbHNlIGpvYi1pZD1jb21taXQtc25hcDEKRU9GCndhaXRqb2IgY29tbWl0LXNuYXAx
CgokUU1QU0hFTEwgLXAgJFFNUFNPQ0sgPDxFT0YKICAgIGJsb2NrLWNvbW1pdCBkZXZpY2U9c25h
cDIgdG9wLW5vZGU9c25hcDIgYmFzZS1ub2RlPW5vZGUwIGF1dG8tZmluYWxpemU9dHJ1ZSBhdXRv
LWRpc21pc3M9ZmFsc2Ugam9iLWlkPWNvbW1pdC1zbmFwMgpFT0YKd2FpdGpvYiBjb21taXQtc25h
cDIKCiRRTVBTSEVMTCAtcCAkUU1QU09DSyA8PEVPRgogICAgYmxvY2tkZXYtZGVsIG5vZGUtbmFt
ZT1zbmFwMQogICAgYmxvY2tkZXYtZGVsIG5vZGUtbmFtZT1zbmFwMgpFT0YK

--------------Ts0ZmfPjfPrvTnRBMaNU5BmU--

