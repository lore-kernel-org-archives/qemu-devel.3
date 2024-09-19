Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF4DCE8D6E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 10:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srE8P-0004GK-0w; Thu, 19 Sep 2024 06:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1srE8M-0004EV-SB; Thu, 19 Sep 2024 06:11:34 -0400
Received: from mail-co1nam11on20721.outbound.protection.outlook.com
 ([2a01:111:f403:2416::721]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1srE8K-0003DT-Ne; Thu, 19 Sep 2024 06:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kw4u/IOiFHO/g1FWibJnN4txCl1xgt3gPi6/s0l+V0ZzlxoVhcd9hq7wbMYxJe8OEyJEsB5v2SJEgW24oR3ybwPbt/Kmo98jPS9Sfu9DcrT3o1LINkYPv6pL5QmWKUEjGXpyb6hb+wm8KDChO6srfNdoPv4vhktvKLVgbIodld8GTg1/Slf6gYEsuVWxT3Es/zOVL/aw5YIsmB7jT/08KKutAOrTYkS/g23781YYE7cCZyOVaoGFp3UKinYJPx0Re34X76tw/78u1ec2/cCBBJgOj20+B75sokaYSFDkwKdImRj0UPWiwJ8XdphLqTE2NP4ampsa6BvjMD3cLsSM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hT/Mp0N9VYna3PfiNrohvn6e0iuVBB1XuJtAAkSvb3U=;
 b=oxxyM8/7dUAWlnvrVN3JYSO/ZHjzDe598JbUIM1ym7CWQxDG6GCE+EN8fETwso3k/nqsY363JZDsusaaruW42QH2z/UTbQOTDWZ3xbS1YN40DrwytBhjUCOLOFxW806S/5WXrOJbpJEy/2/iMrPO8Ay2LgIyQ/lckanWWyXgaFleJHNP9fWRAOifl9VCtQB98dr2afuzeEiUCAg9kh19x3gzn9uhP37WK5nj2U2xEQqZ2jH5DqMUuSUrnvCVPjq9nQiFsIFv7W4M1PWCO4xkUU9tTuQGMYr3Tei4+d8pyb4jI/lnlcUIrjd1XD3tasi2+aQtxITJp0J9jnI09FnqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT/Mp0N9VYna3PfiNrohvn6e0iuVBB1XuJtAAkSvb3U=;
 b=tun63q8HK+z33LE/5yEG6Wym3WeZPPTqB4CAA2PpCpe8UwabzCZdofOdjVPBEUtuP76mqwJ6EjZPx3mVOyxToKM+sQDmzv3E0gEEC+4rTL+/bzX/BE7gd01IJEDVv3tYqy4AWWAtPv3/K9w1Tyb41k3kU7XnEeU7hB1uc+Jw8Ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ2PR01MB8658.prod.exchangelabs.com (2603:10b6:a03:56f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.22; Thu, 19 Sep 2024 10:11:25 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 10:11:25 +0000
Message-ID: <9a4db4c1-a5ea-4375-b5a0-592ec597567c@os.amperecomputing.com>
Date: Thu, 19 Sep 2024 15:41:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm/kvm: add support for MTE
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, darren@os.amperecomputing.com
References: <20240912091616.393685-1-gankulkarni@os.amperecomputing.com>
 <87bk0mtljv.fsf@redhat.com> <5a2696fe-7f11-4b4d-89cc-5763dc95a677@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <5a2696fe-7f11-4b4d-89cc-5763dc95a677@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ2PR01MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 34873171-d8b0-4670-3470-08dcd8936b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUJtaVhEWGhpc3paODF3WVB2RXN5WW9ueTludWlqbEdGWTdXWnUyWUV5TG9z?=
 =?utf-8?B?TVJjN0FxYmJWOStxeHA2aldNV3liTzVFRzZkajlDMlYvUUtzdk9BdldMQXYr?=
 =?utf-8?B?TUlhSkF1cnFvTmFVeUNJeFJKRnVLelg1NThmMWRDWTJYdm9VS3ByWDFaQzJm?=
 =?utf-8?B?blpxbWRLNkRsQ3E4QVpScWt2YUNNYTRKVXlVL3VNSEhMWWZWVlh6ekg0UnJF?=
 =?utf-8?B?TGtFU0tycE1DNDE5SWtrNzdnemovcXVFdmtsL3NJTTVJOUVRelBia1RuVk5a?=
 =?utf-8?B?YUduVUJ2b241bHo0QmZqWHdseTNDSWMwQjFCT3lzNUhZTUdkVHAwMUFrVFg0?=
 =?utf-8?B?amJ5N0QyS1JGUHpzN0dtZ2xRUnRIaFhSRmNYY0l1ZkpRZFlWUTVSbVMxQmxs?=
 =?utf-8?B?UlV4dW5PT1ZFa3VPOFJDNG9iRzUwVFJZd0VoWkxIOGtrT0pqZzJyRzB1elNk?=
 =?utf-8?B?bTM2OWRPOGRUQk5VMmltSTRUS20zV3EvWmFyeFJ3bmExRTRIUjc3SUl2TXlz?=
 =?utf-8?B?Q3V3cm5qb3RpSmc5U2t4c3huVkxkWVIxbVZrcy9TWG9MUWJHaE04bXZ6Y0R4?=
 =?utf-8?B?a09DeTF0R1VKL2ZBR3lYRVpKWkNjbE9qWDhwdGwrelhXbFJMZmtLWFdVWitV?=
 =?utf-8?B?L3lFMnlLSDNZTnlsK1hLVGlFOWZPb3I1VGZPQlJDT1BwZGhGNjlRUlZJOEtU?=
 =?utf-8?B?bFdMTDU1TG9EbGdnK2dWR2FvQXVZQ201NmhUc1YrOHFxSzNwZGhSaVJiVXZW?=
 =?utf-8?B?SUJBbWxjR0FmalhSZjNDS1ZoSEh0clI5cWRlVlJFNFU1UkNQWU5kYTNoZkJR?=
 =?utf-8?B?VkpSMUFEYXRDN2M4Mmxnc2lKV2o1K01lTUMrUWUyT2FyZ0wzR3hIMktHUlhy?=
 =?utf-8?B?T2ZIUTlJZWNrKzB6Nm8zMndDOCtMS1J2bUthNjhJai81MzMzVXdMd2s1cHpB?=
 =?utf-8?B?SS9PMWVZR001bGp0UUZZZmR3dzVpT3dIVGdjVEVpMVhLd1hoeWdBME1PZXkz?=
 =?utf-8?B?Y3JMbkRUdkIwN0hUS2VzZXlzWUJYcDdVTGhwcUgzQUlEVHdHREkzMTM3cFQv?=
 =?utf-8?B?M1Ryelhsb3hQM0tZcXc3R0txcFhrVmlzdEhWQ1lObFdGd3hTaXcrYnZFN3d6?=
 =?utf-8?B?Q3FXT1huY0xTdW9sTi82Q05kdDBUSThMZEhKaXhBa2tNNjJVdTJ3V20wZkli?=
 =?utf-8?B?WGdZTzMxeS9OOGpTVEt5dXoxSW5HRUhYcFdFVUltVGZHOGozY0xoSHhydHUz?=
 =?utf-8?B?Y013UmdIMkpoZHJmamdhSEYzTjN2YmtuOE5yY242QkF0TXRDY05KeGx3elNK?=
 =?utf-8?B?cXdoU3N3UVRuRGVJekVQUVZ2V1cyOVJhb1Z3TzhGK3VwdndWODcwS2swdEF3?=
 =?utf-8?B?RTh1RXlYeWtYaVB4aG12NDFTZkVKeWx4anQ0N2g2aW9BVnNvWGtLbnR2MUQ4?=
 =?utf-8?B?Tmc3bnQ0TGdBZmVSYjJXOEtIaHovcVRyRTl4ZS85citpT2w2c0ZUZTVIbU9j?=
 =?utf-8?B?N2VreGtaZkpBUjZ5QVE5dkczd21Gc050NEoxbVFROXltMUdyMGtRcWdJLzhK?=
 =?utf-8?B?UFR2U2tJWTk0NkZBMmJDTWQwRmFKditXWnJmTXNxYnRSRXVEMzdnZ3FCa0NU?=
 =?utf-8?B?ZVhRaG81VDJXazZVYlk3NWZWUS9qMzRnVmZHUG5NWTRONHZ4MkFtdGhzUkJh?=
 =?utf-8?B?QmdlV2EyaHUvZGNhYUNSYzAvTTdVZmRLZG1sQW5xWm1RYUpBUXhzNnRZY3FL?=
 =?utf-8?B?VlZmbCsvTFlRNUNwY3FTTXpXYlRHdjV2dGlDWEk0ZDNJWE9Fbk12QlNjSyt2?=
 =?utf-8?B?T2NrUDVNZ1Q4OHB5RjkzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXhRQTQ5Nm9ZN3JJSnIrY0dDNThiUFZ3Y2pia0gyT0NibG9VREJoRlk5VnlP?=
 =?utf-8?B?NEgremVpSm5RZi9ZRXBzVTNnZDBnWENNSHMwU2VHTjVIVC8vaU10SUxmT2lw?=
 =?utf-8?B?VUNvMWVtbzZNOXNFbmtoWWJjR1lBeG4zY0lLSHdEUEJUeGRiNUhKRHQwbUlU?=
 =?utf-8?B?cUdVUE5Qb3RJaTBBYURSVU5TWTJFd1lnQlQrMGJMRjhwdXJoZXBZL2VhTzQ5?=
 =?utf-8?B?SEx3UldJdEhqT1pKZnZQZzB2K3Q3dCt1ZURoQ3BiRmptcmhMa0VIWkpNUGJW?=
 =?utf-8?B?SkxOOC9HNU5DVzFhaXM1RHZ5cWJUTGM2QWl6N3JCR3VUQ2o0VkhqT3lyMGhl?=
 =?utf-8?B?RU8zL2NCZ2VrU1Z2dnFYMFdsZ1AyNXdaTmxZSFZ6Z3FXVzhiQUR2MEcwc0hG?=
 =?utf-8?B?RDl6b1g4Q3RIRE5panRORDdTVmhyT25kSGV2OHllTWxSeWhyMVZqeTEyRitl?=
 =?utf-8?B?OGdRbnJnQk9EVG9GR1NmQzI2ay94UjN6RzZHWXdzbUFWbjE3azVnejFmNGpT?=
 =?utf-8?B?ZnhyVUM2MmoydExWMHZNN1Y5cFRtZW9DRjZtbW5aVUxFTjYvbmtWQjhZU2kz?=
 =?utf-8?B?aTRmUmxGbElYVUpVY3FNS1RxR21YZEs4TnNiNDVzNFlNOXZndE1JNllOTjVH?=
 =?utf-8?B?RzRRR1J1SENpY2VEVlBjY1BCMkxXRFBERXhSZGJ2TkQzeXA3S1NxcTJDVUpx?=
 =?utf-8?B?bEJFRmxjSHpYTDZWdWlWeE81M0NSUWNTK28rYkE1ZG5taXJUZWg0dGI2VVVM?=
 =?utf-8?B?YUc1dm5BM0NCMGVWWXhHYk1FeWlwUDVPZWZubGdtM1RNV1hUSk43YW8yaUFT?=
 =?utf-8?B?KzVacTZaUTRpR0txUzh2OStlazU4OW1kUmo1ZzJGNzRSd2p0RWdQNUZURUgx?=
 =?utf-8?B?NmNXS2IxbnNiekhjM3pvbGxubzRqK25mMFpmNUt3R0daRmMwaG0vd1BBU3Fq?=
 =?utf-8?B?R0dCemZWMThuQmRqbUt4R1RjUGp6eHEyWnptMzM2a3orYWM2YmpKTVhLSzFK?=
 =?utf-8?B?VDcyVGFQMlZ1dWpEZ2d2aU01RlVmaERhKzN0MWxJTlhSZUxRNkdzOFMyUStB?=
 =?utf-8?B?bVJYVWJUbkpKVm1BU0NiTUFBZGdNQU9PNzk1SXZZc29IdW94OU0zbXpJeDBU?=
 =?utf-8?B?ZTdDNmtnRkNobUt2dGZMdnNWMUNiNllTTGpZOGtiWndpUFE4b1Y5dVBXME1a?=
 =?utf-8?B?Q0NVQytVL3hzRkM1a044alBseW1SaEo0Qjhkb29DcVRKWGJHNlpDTm9qdlZU?=
 =?utf-8?B?QjJJMnkxeHowSFRsUmRDNlc5UHhod1ZYR1JrMWJGMlJ1cEFDU3h4YTJNQVRZ?=
 =?utf-8?B?Rk8yVjVscTQvamsrUUpUTjh0QlZxdklwb1BPL1VmZXB4TDdDQkZvYmpoazhC?=
 =?utf-8?B?REN1d1NZangwb1RUeXVrdXl1c3U1emVlcVZKcXZ5UjJQU2k5MHJrN2NNbmRn?=
 =?utf-8?B?MmozYzk5anZRN1BjVCtyQjU5dStEbHZ3MzcwMTNOYldtMjNFcUxxSHFHSE91?=
 =?utf-8?B?MFJ0YStvaHJRMlk1MXpNbXJlblF4S0x5ZWJHZElYQ2NpSVVjMW0rUHZoVE9z?=
 =?utf-8?B?R1I0MEthYWxyMFdvMzUwVlRrNzk3QWRJT0tqckJhTG9tVVY3NWVyakVqU1ZJ?=
 =?utf-8?B?YU9wcUZlUHZzYTBCWmJVbDNKMUE5cFZSejAzeGN5Ukt2R204WTdPbERxTFoz?=
 =?utf-8?B?TVZnK3JWOEx1aS9UczlRa0N3TnFsSS9CaGpnVU51SmpUeHMxTkw1UzRhQzNM?=
 =?utf-8?B?T0R3REoycU5YL01RYzN3M0w0SU80RGtpMUx4Z3VYTXVYKzc2dEdhYTJpRytJ?=
 =?utf-8?B?VSsyM0ZiZWczK3V1cVFpTjZ0dEgrOG9yWUk5dFMvcGY1VVoyRWpjc1hNT2Z3?=
 =?utf-8?B?a3ZwWmVIWkM4U1c3dkQ1c0F5S21SUGY3dnN5cUpSYnExZ2w2dUlNS0hlS21s?=
 =?utf-8?B?TmUrQ2c2d0xmQklSbFljT0lLSHBvYko2NTVFSlBTcTgzZ1ZtRVBLZlBObUQ4?=
 =?utf-8?B?cExHejVlanF2WlA5RHk3TnV0OUlKRHV2bDhtZVhMWEEvbVFGRU1JSnEzWUp4?=
 =?utf-8?B?cDJMamZKNS9ZdXN4R3FDUmlDWVhuNDhUVFdubHRzbWVmblZycFo5dUNyN3N5?=
 =?utf-8?B?cTZMbVZmQXo0T2tjaktVQ25XZnZIRlZSbitIOHdxWm5Qbk1IV0c2bVg5WlZn?=
 =?utf-8?Q?rsc35QrRPp53BYwfocIPUHw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34873171-d8b0-4670-3470-08dcd8936b5b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 10:11:25.3810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iDgt2B1DRKcNQqSsuNQnVum+hKlL1v/WzO2xxtXkM40jfFmCUdeM+Nf3ttg1RAZewbnA2OU+uYxkMBWjvIaYtZnIpEQnroVmfQ6vBihZFiQxsMrIYlPy5GCHwqEO0j4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8658
Received-SPF: pass client-ip=2a01:111:f403:2416::721;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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


Hi Gustavo,

On 19-09-2024 08:31 am, Gustavo Romero wrote:
> Hi Cornelia and Ganapatrao,
> 
> On 9/17/24 11:13, Cornelia Huck wrote:
>> On Thu, Sep 12 2024, Ganapatrao Kulkarni 
>> <gankulkarni@os.amperecomputing.com> wrote:
>>
>>> Extend the 'mte' property for the virt machine to cover KVM as
>>> well. For KVM, we don't allocate tag memory, but instead enable
>>> the capability.
>>>
>>> If MTE has been enabled, we need to disable migration, as we do not
>>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>>> off with KVM unless requested explicitly.
>>>
>>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>>> which broke TCG since it made the TCG -cpu max
>>> report the presence of MTE to the guest even if the board hadn't
>>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>>> then tried to use MTE QEMU would segfault accessing the
>>> non-existent tag RAM.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>> ---
>>> Changes since V1:
>>>     Added code to enable MTE before reading register
>>> id_aa64pfr1 (unmasked MTE bits).
>>>
>>> This patch is boot tested on ARM64 with KVM and on X86 with TCG for 
>>> mte=on
>>> and default case(i.e, no mte).
>>>
>>>   hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
>>>   target/arm/cpu.c     |  7 +++--
>>>   target/arm/cpu.h     |  2 ++
>>>   target/arm/kvm.c     | 59 ++++++++++++++++++++++++++++++++++++
>>>   target/arm/kvm_arm.h | 19 ++++++++++++
>>>   5 files changed, 126 insertions(+), 33 deletions(-)
>>>
>> (...)
>>
>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>> index 849e2e21b3..29865609fb 100644
>>> --- a/target/arm/kvm.c
>>> +++ b/target/arm/kvm.c
>>> @@ -39,6 +39,7 @@
>>>   #include "hw/acpi/acpi.h"
>>>   #include "hw/acpi/ghes.h"
>>>   #include "target/arm/gtimer.h"
>>> +#include "migration/blocker.h"
>>>   const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>>>       KVM_CAP_LAST_INFO
>>> @@ -119,6 +120,21 @@ bool kvm_arm_create_scratch_host_vcpu(const 
>>> uint32_t *cpus_to_try,
>>>       if (vmfd < 0) {
>>>           goto err;
>>>       }
>>> +
>>> +    /*
>>> +     * MTE bits of register id_aa64pfr1 are masked if MTE is
>>> +     * not enabled and required to enable before VCPU
>>> +     * is created. Hence enable MTE(if supported) before VCPU
>>> +     * is created to read unmasked MTE bits.
>>> +     */
>> Maybe
>>
>> "KVM will mask the MTE bits in id_aa64pfr1 unless the VMM has enabled
>> the MTE KVM capability, so do it here for probing."
>>
>> ?
> 
> KVM_CAP_ARM_MTE must be set before creating the VCPUs, as
> 
> stated in the KVM API docs, so enabling this cap. here for later
> 
> probing the MTE bits correctly feels more like a consequence. So
> 
> I prefer the the original comment, which mentions that
> 
> requirement. But I think something shorter like the following
> 
> would work too:
> 
> "MTE capability must be enabled by the VMM before creating
> 
> any VCPUs. The MTE bits of the ID_AA64PFR1 register are masked
> 
> if MTE is not enabled, allowing them to be probed correctly."
> 
> 

Thanks, this comment seems more precise.

-- 
Thanks,
Ganapat/GK

