Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8A8CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 05:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur967-0002jC-Gn; Wed, 27 Aug 2025 01:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1ur965-0002iq-A0; Wed, 27 Aug 2025 01:53:25 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1ur961-0000Qf-DQ; Wed, 27 Aug 2025 01:53:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gcj0lGLwPEKUOG7E7f3uIXfEHruzxN4ZD1l5XlxI5LScl2J3OA7y4dsf7soKO2uhh8LCAPqtRif2VezxX+VG6G1oV1oXyGnfTv6xeKxOeqCKAp7lO08X8jValKA1Byq8V4w9YVjaicYwo4vXA4y3ZMYZdWW8YgLKyrDzE0bx6FFNqjBy1B9KZZtvCIgrQVAO8aPAQtAgzihprs4nTXJ6x80i60+eU8/aRHU+fqUDyYgvRzSmsnlPVN/CUcPNBKnUZNEcFlLZcXWSMZ/rOEennUrq/QdQg7XKI/lgGFO98ilykTEx8vFKkaSwtPpDtY4uoV3nVB4qmdZL0CJdsZocPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttVTseOz70VuzS3/OA+4B5zRS0K9P6kZXv3GE+2qUbA=;
 b=bo58nQIoImumx4GBfz6ONZ7+lzmnLkwUsJIbmwUvnqWw6HSiPI2YTIoWFqcV+D8TCOGNqgr8SAB//TgYLJd2dDw1bso8oEjE4PTbV4OvY3MZq0WCuZ4rJnJEvK+MOjjHGjNZfoUsN9YG7graPjx8c/b01ta90n8xS9GsqCfVZztJL0z8muZ8oG6JGsmsZH6Z0vVY5WnF7JH+DYYFdiQSQ9ooSr2CXwA0EvnlRQLJ/fvu5zJzWBB3v5jzT22E8INvfqL+sLO8hawYDSdCGU01VhrkWQLzeLKv8XnvZPeHpkC7SA+kq309qG84j4DnDsy4NIIp18/kCAx64lmc5k/DEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttVTseOz70VuzS3/OA+4B5zRS0K9P6kZXv3GE+2qUbA=;
 b=AN3LF/8itZMOQIF1dRHnkmcyziFgd36Qa2Qaz5dibLYbDIS5qaNSfcXOviLcqWbITd1EkalBaWNcSv//u2bSEFTIfzjRx3MCZzKvHvr4Lis1s/CNovKe2irS9pWlxSXT5uaAGLiF32Ne89F95c1deIWFFomKq11x+Y46wMBhs21ZIjHPcblBqvtq+8Gsk9AJErznkeNUv62NRTE/CRyLsCXFMVTxcosSH57zeYPCTbPGm6lqukF+g9swd4ogTr0yT9lWFLIlvAiLl6Sin7pVxC044DLqKywkiX5MTXSmAM/Dy/4urmX5s4nkp1/CgBhIKI/eusa5gABXIX5kweItbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8500.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:231::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 05:53:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 05:53:13 +0000
Message-ID: <2a9cddd8-2d60-4565-b6a2-de606f96b2f6@siemens.com>
Date: Wed, 27 Aug 2025 07:53:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/sd/sdcard: Handle RPMB MAC field
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <8ea56ae040ef1037e44fc864c159e2f96f23f059.1756019920.git.jan.kiszka@siemens.com>
 <51a9f857-69ff-43f6-8f3d-c7e5d5870c99@linaro.org>
 <97fce5d7-eb6d-4698-950e-94d5468d5696@siemens.com>
 <c9f0e2e0-d533-4aa5-944e-cc5f0da30645@linaro.org>
 <aK2J8GFi7hRdK9Nq@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aK2J8GFi7hRdK9Nq@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0058.eurprd04.prod.outlook.com
 (2603:10a6:208:1::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 470689f0-7f7e-486a-fa29-08dde52e0291
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck45azRzc25GUmxLSUtUTGZxeWxTUWNKeTdVaG85SnRnYjF3RitnZUxqVGVL?=
 =?utf-8?B?dVM4aUNHODVSNUZNVVVMdnJEL1E0Q1VpNmh2eFFWSzJVWW9QVUlEK3RGdy9v?=
 =?utf-8?B?SmNxWGM5Z2ozY2djemRrYUVieXJqY2c4c1FoMHp6Qmo1OGZKa3dHeE5VS3M0?=
 =?utf-8?B?UmJGQ3NYV3BiQUpzczFTdzA2Mm1qblUwTTBiRjl6VjJxbHdOVFRrWS9mbis0?=
 =?utf-8?B?S3BkUHZSM1ZFZ2hOTFlrb2VWTDVuL3lVdGhKMFNBR0Z6QVlZOWJpdmRSdVN4?=
 =?utf-8?B?bVJhSzFiQ0ZaZVhGa0ZsTGRNSTNwdEExNFlBbm92WUdqcXJHeHJzdWY2aVp0?=
 =?utf-8?B?NFc0STkwdVc1dXVhMDVESEg5cmNQeTI5RDJTMTRYS2ZlLzZTcEtJRERKeFY5?=
 =?utf-8?B?OE5QbUZQcmhoMXlLeXlSbHNTc0pMM1FjdWVNSkVTSDRMNjBRWUVZamxhYktj?=
 =?utf-8?B?NitGR1U4NnhReWhScW5lV280YURnY0R5anVqZHMxUXIweXFuU1ZiWC9GQ2Fr?=
 =?utf-8?B?dytBTElGUjQyb2VjWTRkNHJ2ZzhkOE9TSFJzK1dONUV6bXh4OER3VWdORXJF?=
 =?utf-8?B?bG83QUZRWFI0VlV5ZHBJUHV0MzVlYUFqVUFqQ2F2YTZyVnRaa0dCbGFIRGpx?=
 =?utf-8?B?ejM2bThPd3dDQ1N5OEQvemZPbUdLZUZ4V25ONEZ3dHozellTN1BNNmJMcVNL?=
 =?utf-8?B?Mmt2NEZhNEpLaCsxNzFTOG5kdFhqOGs0aHc1R0V4ZzBlMWJGRmI3SVdkVGhO?=
 =?utf-8?B?YWZ5elBxNHBRT3pTbFpWcWd5cVp5WWNjS05ma2FxOGdWc0QwTVNla0xOWkVE?=
 =?utf-8?B?U1daRmhpaW5xejJmaDRJNDViaml0cFVLU2U5SklmOHdFRllrUHFVQ2U0d1ha?=
 =?utf-8?B?V1BSck43dlVXR1QxdUFGVHE5aDR1bCtjR0tLOCtYZjZwWGZmMmZkUHEwLy82?=
 =?utf-8?B?a3FHRG50QWcxTENicy9vV2QvRDNxQTBHMUhsU2FEQ25JVkladjNqaUJOQ3V4?=
 =?utf-8?B?d0Z1dFl5eVRLNFpHUnZ4WHNHRm1yalFpMG0wRFc1VVNZdEg2ZStHb05qR0tX?=
 =?utf-8?B?UmVkK0FJUG9nU1U4NmsvUHh6NjhpcEdya21zZEQ3eXU0NjFoMjcyOHhpQmRt?=
 =?utf-8?B?QUplVEFicEZjU3ZKZmlwZDFCRVNveUNlSGpVaERnZlNqNjg1OUdmNDFJbzk0?=
 =?utf-8?B?VHJMdmVoTEhhYTdBaVdUWkVIMjBKcUNPNCtFL3VESmg3NUhqMld6NlFka0E0?=
 =?utf-8?B?U0QwZFNsWXp2NnBWTGY4Q3dIdHVYNktFT1g4OG5QNVIzMzJDdnV4ZEllZ1h0?=
 =?utf-8?B?TFFBLzJhZGZ3UU5mZldXZ3VENWVXRUk1aXJXdS9OLy8yeTBOM0NzTmFNRGQ0?=
 =?utf-8?B?bkMyQUhEMWN4QWlmbDZqamVPVHhrZWR1TjI5SzU5SzQ3NkdmY09SUVZybmNP?=
 =?utf-8?B?MzQ2M0ZuRjV6K0xPeVA1S01iUHJTL0Y4QVBRUFFOcEZnSzluOXgrRHRCeEZ4?=
 =?utf-8?B?RGE1N3hPSGFPaUFwWFhGc0lGRmRsK3VGTmlIa0ZEOHhHOXhIcXAyUmRBNWRJ?=
 =?utf-8?B?NnhrQWMvQTF1enowWlZrZFZ2cXNNZURSemZWMlZVTTRseWRoV21EWDZ5cUdC?=
 =?utf-8?B?bTFSbll5M3hJak8wZzlnTHBmSE5qSTBib1pQWityUllYN2RSWHJ4SEVDaTh1?=
 =?utf-8?B?S3Y4ekNVTDF0VU9pZVZZQSttcGdWRkFnQ3dZY1lnUVJhUmxoYlhSZ1hrY1l6?=
 =?utf-8?B?TVh6QzhZYWlYc2Y2c1NvUkhETmcySGJiOG5RMS9ta3NhaGc0eHBadCtxWStX?=
 =?utf-8?B?anQvOHlOMUJMM3hSMTRMMDBMV0dDQ3lIQXhwYnlTYWxsQ21TNHdhWXBhdjcw?=
 =?utf-8?B?YlBSV054a2dEWWtabFNmdlhBSnFnWWpSa2JzQlI2cEFrcHJlYkI4aVpqK0lV?=
 =?utf-8?Q?Zv4G5EkO77A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHl2WGcvc0pvVTNibGhQZTZxZWpoWHVaMm5LYW42eWN4WlZoWHBxQkNVRm11?=
 =?utf-8?B?TERGakFOZHUzWmlEVjMxVWNRYzBMZkJTS3hjejFnWDg3Z25WK3h0YkxTY0VP?=
 =?utf-8?B?dFRTcGFxenV2QnJiWUdOTGJRZlJKU3JHME01QXJqMWpUa2lFZzMzcWRXcDZB?=
 =?utf-8?B?ZHc4a2crR3dFajc2eEtSUWF0LzVVYzdDa0VJbS9vZ3lqM3JHQ0pFeHNRWVh0?=
 =?utf-8?B?VG1yaGZZczVMQmdRY05VTzdlclpmbE11aFE1SFJhVU5zRmdiWEQvcFZxWGNO?=
 =?utf-8?B?ZUlrQ2dCZHFUUGtxNlUyeld5dEl1aHhPUEROQ1dOc2w5c0RTdU96c0IrcU91?=
 =?utf-8?B?Vlg1N25IT0VDcml2Ukt3WUpRMVpFVEpOQXNmWDZnWXR6OVVVc2JGeHFuUVpw?=
 =?utf-8?B?eHpUclA1VGp5RUtXU250eDhQMHJUZHh6SjJ1YXhrbjFoc0E0UlB1SDh2OTJ4?=
 =?utf-8?B?RzAvUkZnU2k3YkNnTWNCWFRrOStkUjFsTnU1RVZsdk5zZWtlQ1FnY1NobGZS?=
 =?utf-8?B?b0hjYXhvT0NLOGkxbVRpLzdxMU9GYWZ6Z1NEOXY4dDlwWW9JTmF3RTJmckhW?=
 =?utf-8?B?b1VsUm5JaTNZS3lxUkJNcWVGbXJFaEVHalhZMG9DZ2lHcURvWkRtd1pjNWUz?=
 =?utf-8?B?NmVERERTYW53QmlkaWR0TXlMRzdEMGRtZitXOWJaMWIzNzBKalZsK25SK2pn?=
 =?utf-8?B?cVczK294VzJwcEhsak9EbjNwQmRCZjllU3VCY1dCYW9JeE9sU2ZKcEJBY2NQ?=
 =?utf-8?B?Smo4SzluRnJMME1ZcHdQd210K0hxcHk5d3kyRW5xdi9udHVjaGlQVFl0MFBF?=
 =?utf-8?B?c0VSNk1ZY041MnJ6UG9Ud2dWUldxMkZabzRxamVlMytpZkw1WGZlZ0VSL1lU?=
 =?utf-8?B?UENpVEVNNkUwQzR5YTZ0Z3c5R1JLMW1DWUZWMFd0UXJQZk1aVElBN3FQcDJV?=
 =?utf-8?B?VEtMdTJpdlBSazVoU21JMlRtSVZhN2FsNkdNSmZDTEcxWnp1cUFQVEJyRklZ?=
 =?utf-8?B?WTNBdUJzdlJacTFWNDlIYWNaMXpjZ0d2M3JaempKaStvLzhKYVdWdzR3bm1v?=
 =?utf-8?B?Vkx6UnFkbnNtZzAxbWl3SzhhaVh4VzFJUVI5SW5FSXVZbitYRkpvZEJ3bXBS?=
 =?utf-8?B?WHdpYmVsRUNmRkFDa2xSNTNzOWZERzZsZjdrKzBqQ3U5NGRJbmlHOEtFazZs?=
 =?utf-8?B?T1V2SzJsNDFIZHhOZlBZamszY0Q4Kys1RGdzUVQ2eHE5SEtMOG5ZSlBiMU9G?=
 =?utf-8?B?N2RNV1VHN2VhbDZYbHFtT1drdjZCNVpxb01PS0w2WURPNk1VMTNiaXo4eklZ?=
 =?utf-8?B?YngxbHc1LzZKOU84TE5WRU4xc0sxMVNSOWs0ZENqUWlnSkRVeGczdHN0ejhi?=
 =?utf-8?B?S1R3UFRiVFovR056d3VFb3Yva1BpTFlqdEZ1L3puUjNJQnZtUE16Mm9GK2JK?=
 =?utf-8?B?SHQ5ejU4cmRrdEV1RDE1NEFyRENQL0ViZlEyQTJuQ0kzN0srRDV1djN4dFVK?=
 =?utf-8?B?QU5JSEJmZE5nZnF3LzN0VGhRZkg3dnJqa1kxRXpoMmQ2RktWSUVtQWNLVXZ6?=
 =?utf-8?B?dFlTY2oyRlRRNWhuK1h1empUT2tOTHc2RUdXdWV0ZGJLbVZrY0g4M2t4aXFJ?=
 =?utf-8?B?QS9MRXBoYWdGblZHK3R5WGhRMlcxUkJzRnBjSWlPS0w5QVl2NDQzb3VZakM0?=
 =?utf-8?B?NC9rY1dtNnNHVXZIK1MxcXQvOHJDQ1RNbERsb1NxaXRtMTAxd1JSdGoxMm9Z?=
 =?utf-8?B?ZjdFcFAwRC9ZZ3pYMm5tam93SFl0MDVyMUFyaXovT0E5TzJaZTd2NVBqT2p1?=
 =?utf-8?B?ZHJzSGZDRUpyc3IxZWlDK0ZsMEp5bm5TSFNnMVFtY29WUFdBOTBNTGRoTFRs?=
 =?utf-8?B?QlZ2QnA1bEVjeXg1Mnp5YUovTnlUY2tKRTZqZ0ZpaW1WQWtMak41LzNxNytw?=
 =?utf-8?B?Q0loNHRMRXRGckhqemluUFdqSjZzZmxPdXhkT1VzTnJzQ1RvQ0xJQVhjd09i?=
 =?utf-8?B?SVVUL2ZHWkMvNWUyU0E0VUpmMWtMRXhlWXNaNTJZWUhjdW1wOXpmc1p4U3VT?=
 =?utf-8?B?WXFGOXFQQTc0UHBnMm84bFl4NG90RzllWTFXanowSEFaMkV2cHdHdkFEZ0FR?=
 =?utf-8?B?OWovdmlPaHlzTUNRalhUYUppaWE1aGNqVVFCQStEVEVWNWVHbGNhMzlHSEhr?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470689f0-7f7e-486a-fa29-08dde52e0291
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:53:13.3171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ij88RBk005G6sPgBE6wdhzXK/7fdT05h4rHZ5G+Moh7Iy4CducLByTzUiyi47Q/mkP0fHNm1i7uOGKLrLT+OMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8500
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=jan.kiszka@siemens.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 26.08.25 12:18, Daniel P. Berrangé wrote:
> On Mon, Aug 25, 2025 at 06:30:52PM +0200, Philippe Mathieu-Daudé wrote:
>> +Dan
>>
>> On 25/8/25 18:12, Jan Kiszka wrote:
>>> On 25.08.25 11:47, Philippe Mathieu-Daudé wrote:
>>>> Hi Jan,
>>>>
>>>> On 24/8/25 09:18, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> Implement correct setting of the MAC field when passing RPMB frames back
>>>>> to the guest. Also check the MAC on authenticated write requests.
>>>>>
>>>>> As this depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256, only
>>>>> register the eMMC class if that is available.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>    hw/sd/sd.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>>    1 file changed, 89 insertions(+), 1 deletion(-)
>>>>
>>>>
>>>>> @@ -3122,6 +3201,7 @@ static const TypeInfo sd_types[] = {
>>>>>            .parent         = TYPE_SD_CARD,
>>>>>            .class_init     = sd_spi_class_init,
>>>>>        },
>>>>> +    /* must be last element */
>>>>>        {
>>>>>            .name           = TYPE_EMMC,
>>>>>            .parent         = TYPE_SDMMC_COMMON,
>>>>> @@ -3129,4 +3209,12 @@ static const TypeInfo sd_types[] = {
>>>>>        },
>>>>>    };
>>>>>    -DEFINE_TYPES(sd_types)
>>>>> +static void sd_register_types(void)
>>>>> +{
>>>>> +    int num = ARRAY_SIZE(sd_types);
>>>>> +    if (!qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256)) {
>>>>> +        num--;
>>>>
>>>> Instead, expose RPMB feature in CSD when HMAC supported?
>>>>
>>>> Something in emmc_set_ext_csd() in the lines of:
>>>>
>>>>    if (qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256)) {
>>>>        sd->ext_csd[EXT_CSD_REV] = 5;
>>>>        sd->ext_csd[EXT_CSD_RPMB_MULT] = sd->rpmb_part_size / (128 * KiB);
>>>>        sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0b111;
>>>>    } else {
>>>>        sd->ext_csd[EXT_CSD_REV] = 3;
>>>>    }
>>>
>>> I need to check if revision 5 still had RPMB as optional (current ones
>>> definitely require it), but I don't think rolling back to revision 3
>>> would be good idea. If start to add more features from newer revisions,
>>> that may cause even more weird results from the user perspective. I'm
>>> not saying we are fully compliant in one or the other version, rather
>>> that we need to work towards becoming so. Have to support multiple
>>> versions along that will not make it easier.
>>
>> Daniel, do you have a rough idea how many of our build config do
>> not support QCRYPTO_HASH_ALGO_SHA256?
>> (looking about making the SD device unconditional to it).
> 
> That's always available, since we can get it from 'glib' even when no
> crypto libs are linked.
> 

Perfect, makes things simpler.

So what is best practice, assert() availability or silently assume that
it is there?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

