Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C12C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tps30-0003L5-Ci; Wed, 05 Mar 2025 11:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1tps2y-0003KM-Sq
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:56:40 -0500
Received: from mail-am6eur05on2124.outbound.protection.outlook.com
 ([40.107.22.124] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1tps2v-0006sU-NF
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:56:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt35hfJRye2aIK/Y2WB9xfEQzS7xfWls4KEv6Hs6ifs3w4a5OifZLl+93ix1uALC/7QPou6OGYEcWFyat/6dieOO1kniYRV/KmObxT/74vrG0LcSo78mcdIFby5KJLbrrQZV/K2m6w99lRo1ti2uhjYo3MSQHYaK8wsKQJBua5BJjrzcl2wDn6ojpHFN1keYYczKZ5b9GS4bv8iYcVzvR+kfUM/CEROyzkyZ4eSzbWsI+Qbjg6DrWiy8HV5cibeA+yPR26ayTFpUe/++3gE31YiAtwqmg5MNMUXbAsdta2oGFb8rkexkbPMRtJ7KJRjywy5wVLWPMuVgej8JZ+fCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtTucC6Yn+wS1s+JP+xtO7NXgNd9HrGj6vwdy3a2vhA=;
 b=bBJQq/q4Ry7w90s0a3NWFfEqWuyYSlHGapSnqlZf4vzaw0GYL49Rii3XcfIJRIHBxAdtZmmNnXd0TCcl3uub/B4ZrD1rD3Wede8KJE6ZiVXOrs2ecu8vwXD/sqBpfujfxYxz4qKKaQgBPrlDr1F3wO7jKWkwO1xiaDR66a+Hua+zeCiLEAJT3A3BJQY5rgt0n/4QsP/KMxWTahkL4PDanN1SrPaFaxpr96N+0Qf1Gp06b15rAGF8bYiR8hwwKCVN+coBN62bkLZ+vWA2aL/rgQLflvZvX+OI+hqB4KfVCzM7bi74H/OmgTIUddOcRiSL4KK1Yjt7TkTsWrdd5xhQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtTucC6Yn+wS1s+JP+xtO7NXgNd9HrGj6vwdy3a2vhA=;
 b=ngOhfot+3EEN1zRf9Il8LISx5HRGN4EHJr1+K/AHnpGmLwVMUT+dfECubN10vNA8kHB2PrESe7903HW8I2hDd6XANU7bDAGpLnanLcnCLrz1dHJd5n4Z9uJLIfqVnlVai81yt4oVjqXvVjOKAqfiz9IyTrFVkJxa0lob5FmZjrULzbHWRtjrcMWIGyYdnRaxJ41hpw1USaEnpsSC9Db+eVzTHZtQXrEfzzhFMVfDjvyyGD6JCgONz/sGVvEXwsfdMr4pG9EGTtAspaMVNRQ9KWPYPcffUhje9HrrsdrIfqGWlNVtOf70xP8kzhFz4g8wuz1X1mnzJ3Q0t8y8lOZN4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB8676.eurprd08.prod.outlook.com
 (2603:10a6:10:3d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 16:51:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 16:51:29 +0000
Content-Type: multipart/mixed; boundary="------------aTWw3BptY0bWSrbHFU0SKniK"
Message-ID: <063ee0ac-0568-4413-835b-e620f8d70761@virtuozzo.com>
Date: Wed, 5 Mar 2025 18:50:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
 <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
 <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
 <d03329c3-a55a-4818-8d41-7efb2e6af1c7@virtuozzo.com>
 <d5a37291-e183-42b5-9b9f-7ed736f0c367@oracle.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <d5a37291-e183-42b5-9b9f-7ed736f0c367@oracle.com>
X-ClientProxiedBy: FR4P281CA0417.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB8676:EE_
X-MS-Office365-Filtering-Correlation-Id: dab5fa0c-e4db-4386-dd49-08dd5c05f9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3Y3TnFrbElETTRucTBYdzl2OWl6VEF1THRaZzFPVGFIQ1pvYnV3bWxtbmJC?=
 =?utf-8?B?b012eExkU2JZUXRxZFliOTdWbVZvV1ExZDNmMkc2U21QRGVjQjFZNDhxSE1q?=
 =?utf-8?B?Q1M5Z2EvNzV1TnorWnhCQm5FYWFwVjkxWTlnOGlFMHhoTllMT051aS80R0hE?=
 =?utf-8?B?QmV3eU5qTDZsTzRHVTIvQzdQa0ltMXVhc2w5MHdZcVllSnY5cUxqeVZLb09w?=
 =?utf-8?B?UGNpYVVLdHVSa3ZOdVF6TVZoZWdDSW9DTDQ0WVdLZHp1MFNTZ01rcTFMRnRO?=
 =?utf-8?B?QldEbGdNWGVhSDZBdFVGdDM0RFR5ckZVQ3ZTdUMwVnlER2FmUGtudlhPVWla?=
 =?utf-8?B?UzNJRkVjNmdnOXhoQUp2a1RVbFJQTENIVEp1QlhJK2JOdjZMTkdrOUpFcEF0?=
 =?utf-8?B?dTJGY3JqSVNQakhBQ3dmVzVtdUxkM0toazNYeTdUUG5vdFhpNVJieFU5VmJk?=
 =?utf-8?B?NFhSczhxNUZWU2ltdUE1cFNSZDVSdG4wbGpFTmFQZ3FGbVozMzVZbXFSYjFC?=
 =?utf-8?B?TnllWHQxSVlmdDNIUUc3cnlwNnJxRWVRQlEyYzRNRTRmc0E4MVNYcU9HbmVx?=
 =?utf-8?B?U1B0aEFOcEZNL0luK3gzZFJkTDhEWGp0bGRwS2xpNm9UNGJubURzNFZ4UjFK?=
 =?utf-8?B?OXlQMVFmWWFuUXVBRnZHZnFnMHZZcjJvMFk3SjMyUGlRNnVjK3NoM3Q4NU1H?=
 =?utf-8?B?N1JBNy9rcktFUi9TUURlQWZ5VkxMSk9WN1VvU2JBbjZJZml6NDJGZGZUNm82?=
 =?utf-8?B?RFpxdnlyRkhma3pWamNDNWVyV2l0VmZ1cW94TnVFYXFVa0cxUkN3enpuQ0pI?=
 =?utf-8?B?WXRrTDVZeEVOR25FRmJxdGtTUDUwYXJBdEEzQkp5TGpuZW94L3BnYmxJZGgw?=
 =?utf-8?B?Q0FOWHkyL2drK2Q5VkVIbzdkYnlnQ1lMTmo3ZVRRWUEyNlFGd3B1NTMvMVdt?=
 =?utf-8?B?cDEwL2tERnN1MkpmWmdhSmM3WjNMUnV5dGEyUTd3bUJwZU9IRDZvOUpxZENr?=
 =?utf-8?B?Y3k1QUJYa3hGNHVxN1VNWVdJU1RmMWhVNDhDVjBERm1OZGNXOGs5cnhJSXNK?=
 =?utf-8?B?NFJlNzNTM3loenZ5MXBwOW16blhURWFJcjJ6S3ZYdTRTWThlSnBvZGNRRThm?=
 =?utf-8?B?bW8yZTZUQ01vK0dtT1o5K3gzQUJCanllaU1BK0h5MnM1NnZVWmVmK0Jib0tm?=
 =?utf-8?B?V0NOM0JPYjZ3TkJ0R1ByVFBwTmxSY1VPL1k4bURvZk1wZVJ3RTdmUDJkTGZX?=
 =?utf-8?B?dlVydkh6RWN3dytCaWhNem96TGRxRVBDWHgvV3ZaYjV0bTNUZzNES2VhQ09W?=
 =?utf-8?B?UHYzN1F0YTVxTEM2TGRjTUtxbkNxWXp5T0RDdzFtaGd5ajlWM2l3TGZrU3JX?=
 =?utf-8?B?SXEzZDE0aFlDeUl4dHpKS3JhemNHbVZ4alY5TGYzRXU1YXQ0ejN3MnVwTkY0?=
 =?utf-8?B?SVlLWXRhaWUvSUE3dHNyWlM1SXNNVndTWG9KMHBuVDFmWGRPcFV3NkZVZE8x?=
 =?utf-8?B?VXQyeGkxbC9McVhNNmVkVlhpNFRrZlo5OWg1Mms3K3hsMVVXVkk5NzVXRmE4?=
 =?utf-8?B?R0VEYmp6cmpFR0ZsYjRHRFdVcWI4cUI4WStTUkExZ0xvakZ3cFVGdGZNaDVx?=
 =?utf-8?B?Z3I5YUhDMzI2NGlGTnFlZXZTaG1LWGhLTkRKQ0gzcG5RYVZ1Y0xBYW9DWGtJ?=
 =?utf-8?B?WDVDWWpCNWgxSWNJNGJRQm8wNThQU3Z5TTRpZFpsYW5od3ErZVQvSnR6L0tn?=
 =?utf-8?B?bGc5anRsWkRpNnh1WVRtYk8rU1pFSkN5SXRmRU1JNmphTVRYNHIyUHRqYW5l?=
 =?utf-8?B?N2RvdE1sSWdpQVlwUVNUQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4053099003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTVpYWpEVnNnNW5wVG5TVlYzQlU5QlRKWkZqbGlJNHozK08vSHdjWUIzOFJa?=
 =?utf-8?B?Q1d4N3JhQzFXMWliMitndzczbGppTXlCRU5SNVVwWVFkREJOUWJwT0ZWK2tn?=
 =?utf-8?B?ZnlsSzhQN3U5aWQyNEltb2hkblVQWFlpQ3pZVlZwaVh6N0Jac2ZvS3F5OEMr?=
 =?utf-8?B?d1RlcDdSeW5JMkJjNHFENktRWXFPRDVzTGZob0xWM05xOUxQY3hQY3JGMlBa?=
 =?utf-8?B?bmV1WkExeU5Pb1pRd1NqdlorWTR2YVcxa2k3Y1g1R3ZxdXNHQktseEhyaU5Q?=
 =?utf-8?B?Mm9PTmZldzZyYjZXbUtXKzRNUmN0MXMvcFk2dzkvZDdpN2NENUk0S2l1cFVN?=
 =?utf-8?B?a3RlMjR4d1laOGdDNkZvOHRQcnhhM1ZxNDdKT1dzbTQvUUhIV3EzQkZhY20x?=
 =?utf-8?B?K040MFgwR1QrTUptQnkvWlhwL3lza0pvL1ZsQUtDeGR6V1gvdXVqK3JJUGVN?=
 =?utf-8?B?bnVJQnRRTGErOVpsYjZ5YVBMNit2eUROcXhxd2g0S2JLOTRXaTZDZFhtTE8z?=
 =?utf-8?B?OWwxYlRZeXZVbk5LSGdsNGt3WVdDMVhMeFhMS3daNFIxMnlJRS92Sk9BVHRa?=
 =?utf-8?B?b3l1SThNV1Z3MFhlWThvdnRxWUxYOVBNVlE2UUFpS1JNS0RLemFJWmNIbkFn?=
 =?utf-8?B?bm42bkRqQnJoOC9KTFdsZjZlL1Y3L0dERkxQQ0JxSVRhWUtXMmFqVTVqVHJq?=
 =?utf-8?B?UjJ1RG9EOEFLWnRFTnVLeGd4VVc3RFRwTVJTR0JLbVFTSm9NMy81eXY1VFEx?=
 =?utf-8?B?eVV1ZnJON20rT2VDb3RHZi9NTUMvb3RJMzIrdCtiT2E0WTJrbmxTNkZjeVVN?=
 =?utf-8?B?aHI1SkM2OEVyR0hlY21pOTFwNVB6TE1TaUU1L2RrdG1nMi9WNldJWVhEblRN?=
 =?utf-8?B?T0I3dHdqTW40bkdvdy9YV1BtUmZvY05TcEcyY3EyK0IwS2FJZGRrNUhYWGdx?=
 =?utf-8?B?R0ZzZVFGMzhvQXkzdE02Q0F1ekhPQTFMdjJxRFJKUVVHOGZ0NlRMRmM0NDVE?=
 =?utf-8?B?dGhpT09sa2xSYzRsL0xITkJ1cmp6MU9sMTh6ZEwzWUpjeEZ5K0Fxa0dHYnEx?=
 =?utf-8?B?eVJXT2FqODREWGoxeFNtRGhZNm5qcEhLajRKVmZnb0tMYW50Mll3azRNUkZW?=
 =?utf-8?B?V3hNNWpCUVk5TTl5K1JNT20xTHdUdzNLd1BxakUzTVRtaFFROHY5QzBOK2R5?=
 =?utf-8?B?VnBiY1R6bkhCZlplNkpBSm1kdFFiUFBIbXIvQ0lVWFlVNFhxdzJWeXVIUzZk?=
 =?utf-8?B?MlZuZnZRZmlLL3pEOFBDbWY4dUFNajRuYzRWdHdKOGZIMm15SUFhZTRZbTRT?=
 =?utf-8?B?clBXUFQwMXYxS2o1cHRObFoxc1lINTNETzRXTEpDQzlUdnZFNHlpcms5UlFN?=
 =?utf-8?B?VkdNRWtMSjBWZmd3cXRETFRmdmJFcGpjL0NuOHJNRU9GWHJTZmVPVzB2NERQ?=
 =?utf-8?B?d3c5QktoK2lNU1cvU2J0WTdnc1pxWnhrSU9ZV2dDOVdhck15MEVPMG9DWU1q?=
 =?utf-8?B?WDYzTHJza1JvMjdFY3J2dklsT3dCWXd0K1NZT29JaUt3am1mc2M1WTN4SzRH?=
 =?utf-8?B?TmFzMkI1SHFVc3dtRXBmVTh6OEVVYlhrWFJPZmlsbGdtald5dUFyc0h6Ny84?=
 =?utf-8?B?aUVWc09wb3RpUGtueXBLcnViMHhvWjZXODJ6VlpWRDcwNU5IenA1cTVPbjBx?=
 =?utf-8?B?M21LM2lQQWlERXJzMG1GSUFNejU2RUUvakVCZUswVWJHLzZIbVN2YTFGZFI3?=
 =?utf-8?B?SjJrVmd0KzM3Wm05QndiUWVJbnhFM3FRNmlNUWpnYTFNV29jU0R4dVJGMy9o?=
 =?utf-8?B?Z0phZ1FuLzlGcmVWcVB2WnhNa1BsUUE3NjEyR2VKZkdBR3hYWjNRS1Z5Yi9T?=
 =?utf-8?B?ay9zK05GekhlNTZzTE9FVzRiT3lVTzI4Yi8ySW45OVo5K0F0dlJWN3NKTkRJ?=
 =?utf-8?B?Y05LN2pTUlVySWRSUXNvZlJVZytqN1BESXVIYmxwK1ErUXpGaEJ4TXQ3c0Uw?=
 =?utf-8?B?ZlNkYWdxL3dDVVE1anpzVm9KbDE4Sk0wdTE1MUlDekkyMXl0cGZXUE1PS2p5?=
 =?utf-8?B?clU1V2hJN0hIQkdSN05kT25mS0VUMEFlUjRyVE5BaW5jYk1RNERnU0hpVVJu?=
 =?utf-8?B?Q0J4eEtFSVdWdlZDRzV3Y0ZNMjg1NUNWTUVVUG01WXRNUVJtNVM3M3dIMFpC?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab5fa0c-e4db-4386-dd49-08dd5c05f9ca
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:51:29.4000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yT3SRXVGk3dyNYaWo/5pZj1TK6lApPd5+NWNF7Pqo9tKGIOr7jhicebhkpZbJ8jwve8oe8ZIWDPMCHGBNVPpWK+/o5T7sF1Ic2wvxzZNqeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8676
Received-SPF: pass client-ip=40.107.22.124;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--------------aTWw3BptY0bWSrbHFU0SKniK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/4/25 9:05 PM, Steven Sistare wrote:
> On 2/28/2025 1:37 PM, Andrey Drobyshev wrote:
>> On 2/28/25 8:35 PM, Andrey Drobyshev wrote:
>>> On 2/28/25 8:20 PM, Steven Sistare wrote:
>>>> On 2/28/2025 1:13 PM, Steven Sistare wrote:
>>>>> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> We've been experimenting with cpr-transfer migration mode recently
>>>>>> and
>>>>>> have discovered the following issue with the guest QXL driver:
>>>>>>
>>>>>> Run migration source:
>>>>>>> EMULATOR=/path/to/emulator
>>>>>>> ROOTFS=/path/to/image
>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>
>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>       -machine q35 \
>>>>>>>       -cpu host -smp 2 -m 2G \
>>>>>>>       -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>>>>> ram0,share=on\
>>>>>>>       -machine memory-backend=ram0 \
>>>>>>>       -machine aux-ram-share=on \
>>>>>>>       -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>       -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>       -nographic \
>>>>>>>       -device qxl-vga
>>>>>>
>>>>>> Run migration target:
>>>>>>> EMULATOR=/path/to/emulator
>>>>>>> ROOTFS=/path/to/image
>>>>>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>       -machine q35 \
>>>>>>>       -cpu host -smp 2 -m 2G \
>>>>>>>       -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>>>>> ram0,share=on\
>>>>>>>       -machine memory-backend=ram0 \
>>>>>>>       -machine aux-ram-share=on \
>>>>>>>       -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>       -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>       -nographic \
>>>>>>>       -device qxl-vga \
>>>>>>>       -incoming tcp:0:44444 \
>>>>>>>       -incoming '{"channel-type": "cpr", "addr": { "transport":
>>>>>>> "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>>>>>
>>>>>>
>>>>>> Launch the migration:
>>>>>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>
>>>>>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>>>>>       migrate-set-parameters mode=cpr-transfer
>>>>>>>       migrate channels=[{"channel-type":"main","addr":
>>>>>>> {"transport":"socket","type":"inet","host":"0","port":"44444"}},
>>>>>>> {"channel-type":"cpr","addr":
>>>>>>> {"transport":"socket","type":"unix","path":"/var/run/alma8cpr-
>>>>>>> dst.sock"}}]
>>>>>>> EOF
>>>>>>
>>>>>> Then, after a while, QXL guest driver on target crashes spewing the
>>>>>> following messages:
>>>>>>> [   73.962002] [TTM] Buffer eviction failed
>>>>>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824,
>>>>>>> 0x00000001)
>>>>>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to
>>>>>>> allocate VRAM BO
>>>>>>
>>>>>> That seems to be a known kernel QXL driver bug:
>>>>>>
>>>>>> https://lore.kernel.org/all/20220907094423.93581-1-
>>>>>> min_halo@163.com/T/
>>>>>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>>>>>
>>>>>> (the latter discussion contains that reproduce script which speeds up
>>>>>> the crash in the guest):
>>>>>>> #!/bin/bash
>>>>>>>
>>>>>>> chvt 3
>>>>>>>
>>>>>>> for j in $(seq 80); do
>>>>>>>           echo "$(date) starting round $j"
>>>>>>>           if [ "$(journalctl --boot | grep "failed to allocate VRAM
>>>>>>> BO")" != "" ]; then
>>>>>>>                   echo "bug was reproduced after $j tries"
>>>>>>>                   exit 1
>>>>>>>           fi
>>>>>>>           for i in $(seq 100); do
>>>>>>>                   dmesg > /dev/tty3
>>>>>>>           done
>>>>>>> done
>>>>>>>
>>>>>>> echo "bug could not be reproduced"
>>>>>>> exit 0
>>>>>>
>>>>>> The bug itself seems to remain unfixed, as I was able to reproduce
>>>>>> that
>>>>>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>>>>>> cpr-transfer code also seems to be buggy as it triggers the crash -
>>>>>> without the cpr-transfer migration the above reproduce doesn't
>>>>>> lead to
>>>>>> crash on the source VM.
>>>>>>
>>>>>> I suspect that, as cpr-transfer doesn't migrate the guest memory, but
>>>>>> rather passes it through the memory backend object, our code might
>>>>>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>>>>>> corruption so far.
>>>>>>
>>>>>> Could somebody help the investigation and take a look into this?  Any
>>>>>> suggestions would be appreciated.  Thanks!
>>>>>
>>>>> Possibly some memory region created by qxl is not being preserved.
>>>>> Try adding these traces to see what is preserved:
>>>>>
>>>>> -trace enable='*cpr*'
>>>>> -trace enable='*ram_alloc*'
>>>>
>>>> Also try adding this patch to see if it flags any ram blocks as not
>>>> compatible with cpr.  A message is printed at migration start time.
>>>>    https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-
>>>> email-
>>>> steven.sistare@oracle.com/
>>>>
>>>> - Steve
>>>>
>>>
>>> With the traces enabled + the "migration: ram block cpr blockers" patch
>>> applied:
>>>
>>> Source:
>>>> cpr_find_fd pc.bios, id 0 returns -1
>>>> cpr_save_fd pc.bios, id 0, fd 22
>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 22 host
>>>> 0x7fec18e00000
>>>> cpr_find_fd pc.rom, id 0 returns -1
>>>> cpr_save_fd pc.rom, id 0, fd 23
>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 23 host
>>>> 0x7fec18c00000
>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns -1
>>>> cpr_save_fd 0000:00:01.0/e1000e.rom, id 0, fd 24
>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>> 262144 fd 24 host 0x7fec18a00000
>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
>>>> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 25
>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>> 67108864 fd 25 host 0x7feb77e00000
>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns -1
>>>> cpr_save_fd 0000:00:02.0/qxl.vrom, id 0, fd 27
>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>> fd 27 host 0x7fec18800000
>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns -1
>>>> cpr_save_fd 0000:00:02.0/qxl.vram, id 0, fd 28
>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>> 67108864 fd 28 host 0x7feb73c00000
>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns -1
>>>> cpr_save_fd 0000:00:02.0/qxl.rom, id 0, fd 34
>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>> fd 34 host 0x7fec18600000
>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
>>>> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 35
>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>> 2097152 fd 35 host 0x7fec18200000
>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
>>>> cpr_save_fd /rom@etc/table-loader, id 0, fd 36
>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>> fd 36 host 0x7feb8b600000
>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
>>>> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 37
>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>> 37 host 0x7feb8b400000
>>>>
>>>> cpr_state_save cpr-transfer mode
>>>> cpr_transfer_output /var/run/alma8cpr-dst.sock
>>>
>>> Target:
>>>> cpr_transfer_input /var/run/alma8cpr-dst.sock
>>>> cpr_state_load cpr-transfer mode
>>>> cpr_find_fd pc.bios, id 0 returns 20
>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 20 host
>>>> 0x7fcdc9800000
>>>> cpr_find_fd pc.rom, id 0 returns 19
>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 19 host
>>>> 0x7fcdc9600000
>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns 18
>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>> 262144 fd 18 host 0x7fcdc9400000
>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 17
>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>> 67108864 fd 17 host 0x7fcd27e00000
>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns 16
>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>> fd 16 host 0x7fcdc9200000
>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns 15
>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>> 67108864 fd 15 host 0x7fcd23c00000
>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns 14
>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>> fd 14 host 0x7fcdc8800000
>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 13
>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>> 2097152 fd 13 host 0x7fcdc8400000
>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns 11
>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>> fd 11 host 0x7fcdc8200000
>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 10
>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>> 10 host 0x7fcd3be00000
>>>
>>> Looks like both vga.vram and qxl.vram are being preserved (with the same
>>> addresses), and no incompatible ram blocks are found during migration.
>>
>> Sorry, addressed are not the same, of course.  However corresponding ram
>> blocks do seem to be preserved and initialized.
> 
> So far, I have not reproduced the guest driver failure.
> 
> However, I have isolated places where new QEMU improperly writes to
> the qxl memory regions prior to starting the guest, by mmap'ing them
> readonly after cpr:
> 
>   qemu_ram_alloc_internal()
>     if (reused && (strstr(name, "qxl") || strstr("name", "vga")))
>         ram_flags |= RAM_READONLY;
>     new_block = qemu_ram_alloc_from_fd(...)
> 
> I have attached a draft fix; try it and let me know.
> My console window looks fine before and after cpr, using
> -vnc $hostip:0 -vga qxl
> 
> - Steve

Regarding the reproduce: when I launch the buggy version with the same
options as you, i.e. "-vnc 0.0.0.0:$port -vga qxl", and do cpr-transfer,
my VNC client silently hangs on the target after a while.  Could it
happen on your stand as well?  Could you try launching VM with
"-nographic -device qxl-vga"?  That way VM's serial console is given you
directly in the shell, so when qxl driver crashes you're still able to
inspect the kernel messages.

As for your patch, I can report that it doesn't resolve the issue as it
is.  But I was able to track down another possible memory corruption
using your approach with readonly mmap'ing:

> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
> 412         d->ram->magic       = cpu_to_le32(QXL_RAM_MAGIC);
> [Current thread is 1 (Thread 0x7f1a4f83b480 (LWP 229798))]
> (gdb) bt
> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
> #1  0x0000563896e7f467 in qxl_realize_common (qxl=0x5638996e0e70, errp=0x7ffd3c2b8170) at ../hw/display/qxl.c:2142
> #2  0x0000563896e7fda1 in qxl_realize_primary (dev=0x5638996e0e70, errp=0x7ffd3c2b81d0) at ../hw/display/qxl.c:2257
> #3  0x0000563896c7e8f2 in pci_qdev_realize (qdev=0x5638996e0e70, errp=0x7ffd3c2b8250) at ../hw/pci/pci.c:2174
> #4  0x00005638970eb54b in device_set_realized (obj=0x5638996e0e70, value=true, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:494
> #5  0x00005638970f5e14 in property_set_bool (obj=0x5638996e0e70, v=0x5638996f3770, name=0x56389759b141 "realized", opaque=0x5638987893d0, errp=0x7ffd3c2b84e0)
>     at ../qom/object.c:2374
> #6  0x00005638970f39f8 in object_property_set (obj=0x5638996e0e70, name=0x56389759b141 "realized", v=0x5638996f3770, errp=0x7ffd3c2b84e0)
>     at ../qom/object.c:1449
> #7  0x00005638970f8586 in object_property_set_qobject (obj=0x5638996e0e70, name=0x56389759b141 "realized", value=0x5638996df900, errp=0x7ffd3c2b84e0)
>     at ../qom/qom-qobject.c:28
> #8  0x00005638970f3d8d in object_property_set_bool (obj=0x5638996e0e70, name=0x56389759b141 "realized", value=true, errp=0x7ffd3c2b84e0)
>     at ../qom/object.c:1519
> #9  0x00005638970eacb0 in qdev_realize (dev=0x5638996e0e70, bus=0x563898cf3c20, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:276
> #10 0x0000563896dba675 in qdev_device_add_from_qdict (opts=0x5638996dfe50, from_json=false, errp=0x7ffd3c2b84e0) at ../system/qdev-monitor.c:714
> #11 0x0000563896dba721 in qdev_device_add (opts=0x563898786150, errp=0x56389855dc40 <error_fatal>) at ../system/qdev-monitor.c:733
> #12 0x0000563896dc48f1 in device_init_func (opaque=0x0, opts=0x563898786150, errp=0x56389855dc40 <error_fatal>) at ../system/vl.c:1207
> #13 0x000056389737a6cc in qemu_opts_foreach
>     (list=0x563898427b60 <qemu_device_opts>, func=0x563896dc48ca <device_init_func>, opaque=0x0, errp=0x56389855dc40 <error_fatal>)
>     at ../util/qemu-option.c:1135
> #14 0x0000563896dc89b5 in qemu_create_cli_devices () at ../system/vl.c:2745
> #15 0x0000563896dc8c00 in qmp_x_exit_preconfig (errp=0x56389855dc40 <error_fatal>) at ../system/vl.c:2806
> #16 0x0000563896dcb5de in qemu_init (argc=33, argv=0x7ffd3c2b8948) at ../system/vl.c:3838
> #17 0x0000563897297323 in main (argc=33, argv=0x7ffd3c2b8948) at ../system/main.c:72

So the attached adjusted version of your patch does seem to help.  At
least I can't reproduce the crash on my stand.

I'm wondering, could it be useful to explicitly mark all the reused
memory regions readonly upon cpr-transfer, and then make them writable
back again after the migration is done?  That way we will be segfaulting
early on instead of debugging tricky memory corruptions.

Andrey
--------------aTWw3BptY0bWSrbHFU0SKniK
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hw-qxl-cpr-support-preliminary.patch"
Content-Disposition: attachment;
 filename="0001-hw-qxl-cpr-support-preliminary.patch"
Content-Transfer-Encoding: base64

RnJvbSBlZWQwMzIxYzY5MzgyMDRjYzYzOWNlNzljZGQ5M2UzMTFjZDYzYTNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUu
Y29tPgpEYXRlOiBUdWUsIDQgTWFyIDIwMjUgMTA6NDc6NDAgLTA4MDAKU3ViamVjdDogW1BBVENI
XSBody9xeGw6IGNwciBzdXBwb3J0IChwcmVsaW1pbmFyeSkKCkR1cmluZyBub3JtYWwgbWlncmF0
aW9uLCBuZXcgUUVNVSBjcmVhdGVzIGFuZCBpbml0aWFsaXplcyBxeGwgcmFtIGFuZCByb20KbWVt
b3J5IHJlZ2lvbnMsIHRoZW4gbG9hZHMgdGhlIHByZXNlcnZlZCBjb250ZW50cyBvZiB0aG9zZSBy
ZWdpb25zIGZyb20Kdm1zdGF0ZS4KCkR1cmluZyBDUFIsIHRoZSBtZW1vcnkgcmVnaW9ucyBhcmUg
cHJlc2VydmVkIGluIHBsYWNlLCB0aGVuIG5ldyBRRU1VIHVzZXMKdGhvc2UgcmVnaW9ucywgYnV0
IHJlLWluaXRpYWxpemVzIHRoZW0sIHdoaWNoIGlzIHdyb25nLiAgU3VwcHJlc3Mgd3JpdGVzCnRv
IHRoZSBxeGwgbWVtb3J5IHJlZ2lvbnMgZHVyaW5nIENQUiBsb2FkLgoKU2lnbmVkLW9mZi1ieTog
U3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4KLS0tCiBody9kaXNwbGF5
L3F4bC5jIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvaHcvZGlzcGxheS9xeGwuYyBiL2h3L2Rpc3BsYXkvcXhsLmMKaW5kZXggMmVmZGM3N2U2
MS4uYzlhMmFjNjdlMyAxMDA2NDQKLS0tIGEvaHcvZGlzcGxheS9xeGwuYworKysgYi9ody9kaXNw
bGF5L3F4bC5jCkBAIC0zMCw2ICszMCw3IEBACiAjaW5jbHVkZSAicWVtdS9tb2R1bGUuaCIKICNp
bmNsdWRlICJody9xZGV2LXByb3BlcnRpZXMuaCIKICNpbmNsdWRlICJzeXN0ZW0vcnVuc3RhdGUu
aCIKKyNpbmNsdWRlICJtaWdyYXRpb24vY3ByLmgiCiAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3Rh
dGUuaCIKICNpbmNsdWRlICJ0cmFjZS5oIgogCkBAIC0zMzMsNiArMzM0LDEwIEBAIHN0YXRpYyB2
b2lkIGluaXRfcXhsX3JvbShQQ0lRWExEZXZpY2UgKmQpCiAgICAgdWludDMyX3QgZmI7CiAgICAg
aW50IGksIG47CiAKKyAgICBpZiAoY3ByX2dldF9pbmNvbWluZ19tb2RlKCkgIT0gTUlHX01PREVf
Tk9ORSkgeworICAgICAgICBnb3RvIHNraXBfaW5pdDsKKyAgICB9CisKICAgICBtZW1zZXQocm9t
LCAwLCBkLT5yb21fc2l6ZSk7CiAKICAgICByb20tPm1hZ2ljICAgICAgICAgPSBjcHVfdG9fbGUz
MihRWExfUk9NX01BR0lDKTsKQEAgLTM5MCw2ICszOTUsNyBAQCBzdGF0aWMgdm9pZCBpbml0X3F4
bF9yb20oUENJUVhMRGV2aWNlICpkKQogICAgICAgICAgICAgc2l6ZW9mKHJvbS0+Y2xpZW50X21v
bml0b3JzX2NvbmZpZykpOwogICAgIH0KIAorc2tpcF9pbml0OgogICAgIGQtPnNoYWRvd19yb20g
PSAqcm9tOwogICAgIGQtPnJvbSAgICAgICAgPSByb207CiAgICAgZC0+bW9kZXMgICAgICA9IG1v
ZGVzOwpAQCAtNDAwLDI0ICs0MDYsMzAgQEAgc3RhdGljIHZvaWQgaW5pdF9xeGxfcmFtKFBDSVFY
TERldmljZSAqZCkKICAgICB1aW50OF90ICpidWY7CiAgICAgdWludDMyX3QgcHJvZDsKICAgICBR
WExSZWxlYXNlUmluZyAqcmluZzsKKyAgICBib29sIGNwcl90cmFuc2ZlciA9IChjcHJfZ2V0X2lu
Y29taW5nX21vZGUoKSAhPSBNSUdfTU9ERV9OT05FKTsKIAogICAgIGJ1ZiA9IGQtPnZnYS52cmFt
X3B0cjsKICAgICBkLT5yYW0gPSAoUVhMUmFtICopKGJ1ZiArIGxlMzJfdG9fY3B1KGQtPnNoYWRv
d19yb20ucmFtX2hlYWRlcl9vZmZzZXQpKTsKLSAgICBkLT5yYW0tPm1hZ2ljICAgICAgID0gY3B1
X3RvX2xlMzIoUVhMX1JBTV9NQUdJQyk7Ci0gICAgZC0+cmFtLT5pbnRfcGVuZGluZyA9IGNwdV90
b19sZTMyKDApOwotICAgIGQtPnJhbS0+aW50X21hc2sgICAgPSBjcHVfdG9fbGUzMigwKTsKLSAg
ICBkLT5yYW0tPnVwZGF0ZV9zdXJmYWNlID0gMDsKLSAgICBkLT5yYW0tPm1vbml0b3JzX2NvbmZp
ZyA9IDA7Ci0gICAgU1BJQ0VfUklOR19JTklUKCZkLT5yYW0tPmNtZF9yaW5nKTsKLSAgICBTUElD
RV9SSU5HX0lOSVQoJmQtPnJhbS0+Y3Vyc29yX3JpbmcpOwotICAgIFNQSUNFX1JJTkdfSU5JVCgm
ZC0+cmFtLT5yZWxlYXNlX3JpbmcpOworCisgICAgaWYgKCFjcHJfdHJhbnNmZXIpIHsKKyAgICAg
ICAgZC0+cmFtLT5tYWdpYyAgICAgICA9IGNwdV90b19sZTMyKFFYTF9SQU1fTUFHSUMpOworICAg
ICAgICBkLT5yYW0tPmludF9wZW5kaW5nID0gY3B1X3RvX2xlMzIoMCk7CisgICAgICAgIGQtPnJh
bS0+aW50X21hc2sgICAgPSBjcHVfdG9fbGUzMigwKTsKKyAgICAgICAgZC0+cmFtLT51cGRhdGVf
c3VyZmFjZSA9IDA7CisgICAgICAgIGQtPnJhbS0+bW9uaXRvcnNfY29uZmlnID0gMDsKKyAgICAg
ICAgU1BJQ0VfUklOR19JTklUKCZkLT5yYW0tPmNtZF9yaW5nKTsKKyAgICAgICAgU1BJQ0VfUklO
R19JTklUKCZkLT5yYW0tPmN1cnNvcl9yaW5nKTsKKyAgICAgICAgU1BJQ0VfUklOR19JTklUKCZk
LT5yYW0tPnJlbGVhc2VfcmluZyk7CisgICAgfQogCiAgICAgcmluZyA9ICZkLT5yYW0tPnJlbGVh
c2VfcmluZzsKICAgICBwcm9kID0gcmluZy0+cHJvZCAmIFNQSUNFX1JJTkdfSU5ERVhfTUFTSyhy
aW5nKTsKICAgICBhc3NlcnQocHJvZCA8IEFSUkFZX1NJWkUocmluZy0+aXRlbXMpKTsKLSAgICBy
aW5nLT5pdGVtc1twcm9kXS5lbCA9IDA7CiAKLSAgICBxeGxfcmluZ19zZXRfZGlydHkoZCk7Cisg
ICAgaWYgKCFjcHJfdHJhbnNmZXIpIHsKKyAgICAgICAgcmluZy0+aXRlbXNbcHJvZF0uZWwgPSAw
OworICAgICAgICBxeGxfcmluZ19zZXRfZGlydHkoZCk7CisgICAgfQogfQogCiAvKiBjYW4gYmUg
Y2FsbGVkIGZyb20gc3BpY2Ugc2VydmVyIHRocmVhZCBjb250ZXh0ICovCkBAIC01MzksNyArNTUx
LDkgQEAgc3RhdGljIHZvaWQgaW50ZXJmYWNlX3NldF9jb21wcmVzc2lvbl9sZXZlbChRWExJbnN0
YW5jZSAqc2luLCBpbnQgbGV2ZWwpCiAKICAgICB0cmFjZV9xeGxfaW50ZXJmYWNlX3NldF9jb21w
cmVzc2lvbl9sZXZlbChxeGwtPmlkLCBsZXZlbCk7CiAgICAgcXhsLT5zaGFkb3dfcm9tLmNvbXBy
ZXNzaW9uX2xldmVsID0gY3B1X3RvX2xlMzIobGV2ZWwpOwotICAgIHF4bC0+cm9tLT5jb21wcmVz
c2lvbl9sZXZlbCA9IGNwdV90b19sZTMyKGxldmVsKTsKKyAgICBpZiAoY3ByX2dldF9pbmNvbWlu
Z19tb2RlKCkgPT0gTUlHX01PREVfTk9ORSkgeworICAgICAgICBxeGwtPnJvbS0+Y29tcHJlc3Np
b25fbGV2ZWwgPSBjcHVfdG9fbGUzMihsZXZlbCk7CisgICAgfQogICAgIHF4bF9yb21fc2V0X2Rp
cnR5KHF4bCk7CiB9CiAKQEAgLTEyNDUsNyArMTI1OSw3IEBAIHN0YXRpYyB2b2lkIHF4bF9oYXJk
X3Jlc2V0KFBDSVFYTERldmljZSAqZCwgaW50IGxvYWR2bSkKICAgICAvKiBwcmUgbG9hZHZtIHJl
c2V0IG11c3Qgbm90IHRvdWNoIFFYTFJhbS4gIFRoaXMgbGl2ZXMgaW4KICAgICAgKiBkZXZpY2Ug
bWVtb3J5LCBpcyBtaWdyYXRlZCB0b2dldGhlciB3aXRoIFJBTSBhbmQgdGh1cwogICAgICAqIGFs
cmVhZHkgbG9hZGVkIGF0IHRoaXMgcG9pbnQgKi8KLSAgICBpZiAoIWxvYWR2bSkgeworICAgIGlm
ICghbG9hZHZtICYmIGNwcl9nZXRfaW5jb21pbmdfbW9kZSgpID09IE1JR19NT0RFX05PTkUpIHsK
ICAgICAgICAgcXhsX3Jlc2V0X3N0YXRlKGQpOwogICAgIH0KICAgICBxZW11X3NwaWNlX2NyZWF0
ZV9ob3N0X21lbXNsb3QoJmQtPnNzZCk7CkBAIC0yMjA2LDcgKzIyMjAsOSBAQCBzdGF0aWMgdm9p
ZCBxeGxfcmVhbGl6ZV9jb21tb24oUENJUVhMRGV2aWNlICpxeGwsIEVycm9yICoqZXJycCkKIAog
ICAgIHF4bC0+dXBkYXRlX2lycSA9IHFlbXVfYmhfbmV3X2d1YXJkZWQocXhsX3VwZGF0ZV9pcnFf
YmgsIHF4bCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZERVZJ
Q0UocXhsKS0+bWVtX3JlZW50cmFuY3lfZ3VhcmQpOwotICAgIHF4bF9yZXNldF9zdGF0ZShxeGwp
OworICAgIGlmIChjcHJfZ2V0X2luY29taW5nX21vZGUoKSA9PSBNSUdfTU9ERV9OT05FKSB7Cisg
ICAgICAgIHF4bF9yZXNldF9zdGF0ZShxeGwpOworICAgIH0KIAogICAgIHF4bC0+dXBkYXRlX2Fy
ZWFfYmggPSBxZW11X2JoX25ld19ndWFyZGVkKHF4bF9yZW5kZXJfdXBkYXRlX2FyZWFfYmgsIHF4
bCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmREVWSUNF
KHF4bCktPm1lbV9yZWVudHJhbmN5X2d1YXJkKTsKLS0gCjIuNDMuNQoK

--------------aTWw3BptY0bWSrbHFU0SKniK--

