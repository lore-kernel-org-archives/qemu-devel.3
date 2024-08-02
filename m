Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF738C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 12:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZrV8-00055A-D1; Fri, 02 Aug 2024 08:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sZrV2-00052f-HG; Fri, 02 Aug 2024 08:35:14 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sZrV0-0001X8-39; Fri, 02 Aug 2024 08:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUSI0sE4tA/d41OD9oQGj8VOV9kioHrRC0Pl2a/jdG1Lpxh9PDOjwZz72uswj+TfE3q/EhXthb1UjqnZLIl0KH66u/521s7hUP67zbNRv5MAitbA78VO1x8LylVzy/l6OYxZG9VBa73mTxlAtH9F034TL8yuOYEHPy95XFay2Z7LfLpZ2iguZgJVCW9sOH8CNi9jXrWA5gYY6DgCAaJnyiHigFqXkh1g6FN9rXi8EY74anDhyVNk2k/gMU+Kduay63DdZ/ssYkTDtH0yDVFnOcZRVmESuvRywHUEnJ5qDK+8F2idpAeKV4zdu+c+z1wPP7xr2bYc8CTbo7F7XlBjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4xyXg9phgAAwP7QR9pGexLREBQgg8oJlmwSuoLdV74=;
 b=sw5yio2sZADdi4FYXDg7Ur5X66OVW1vVcTCkqpDrggcfAmtLiI1kwOGhQ0S8qEpGI7jD7v6eOeFWX1RclG2Hbwsl56Q9ZwzERci89EZqt8jXk4IQ+ALbbXQWFSbmaQKbp4rR2YCjLVu8LwYVrB7atcWRy7/0mmJcHL4naos+vyIwL/qvdQJcTjfIiGSkhg3duJ6LG+Q8yqrLDXDVjx7o+T4ESlHo4NUO7boxOByNfWaF8j61jKU05dhJvi+h7aSC2obXnodgIg9iq4wzDEZBUoU+ntD7TJeS0rLpIykFBN6lXKux6APuzuXMa5vV5ZHVBRWv0d5qfZQR+iBmByYUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4xyXg9phgAAwP7QR9pGexLREBQgg8oJlmwSuoLdV74=;
 b=UHzR29RpbmYk0y2/vguZ9psqfy8OjUdZwOKWK0T3t7Ft9LTkZnnkjLtOeQSCo+TCaf+y3pAmHoqbTbpe7Q0wboRQ6QtLQWTIOWmXGPkXcnfl1GALR3GtIrri+VB1Wuvnv5505I+YKj0LgMEpdPJzoFr9z7SEITQXrXkneio/vmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ2PR01MB8152.prod.exchangelabs.com (2603:10b6:a03:501::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.23; Fri, 2 Aug 2024 12:35:00 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 12:35:00 +0000
Message-ID: <a622440f-9f39-4d30-bdb6-ed571a152793@os.amperecomputing.com>
Date: Fri, 2 Aug 2024 18:04:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/kvm: add support for MTE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 darren@os.amperecomputing.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
 <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::14) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ2PR01MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d1b6ce-7d5e-490d-d612-08dcb2ef8543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmNwZXhyRE4rbTVXMEJIUi9rN0NnNHBsZmJ4RnM3RlFsQmZmOGp2OW1TTFJC?=
 =?utf-8?B?WEYxeDJFZjFicnN6eXNjck9xQ1M0YlNPaWJvOHlUbGJ4UUFIeXcvbS90NHF5?=
 =?utf-8?B?UlMvQTB0WkF4ZWJpMWgxNXdEWWROM0xwc21ibUJ2cVJBTmhVUFJqU2xZVm9k?=
 =?utf-8?B?YVZqTDYrZjJSMHhKKzJPOWhocEZPekdoNUZNOCtOTW0ydjUrVlZMOFlob0ZO?=
 =?utf-8?B?VTgzUjVqM2ZEQ2VlNno4TGV2ZWF4bVgyUXlzVCtldFYrOHo5cEROeDRQUXVn?=
 =?utf-8?B?cEN0RjBrcGMrOHgzaWFHSGd5V3dETVd5dWVhWkozYUZQSzhUYzdTYjF5Nldt?=
 =?utf-8?B?YVZMUzdibERVR3U2NGZDYW5wN1JNRjNPNE94NnNMelBSYmhCckZiZWdFRG5a?=
 =?utf-8?B?Rk90WXpIQnRsaVJxWmVRU1dCcTlhNEE2MXp1dnM1ZXh1aXlzSUpPS1lDaWdK?=
 =?utf-8?B?QWtDVCtmL0JOb3FIR2wxbHkwNEEyMm9zZFRjc2l3R0J3b3RLaWRkc1pSUWxC?=
 =?utf-8?B?WmJRc0lYZlRIMnVWR1Y3YkN4eDlPcTBySzZBVm03WTFZUFdVbFNkcXhHUW5C?=
 =?utf-8?B?aDNrY3JLeUZhME1mREVrRDIrcitoNm5HN1RkSDk5TSs5Z2c0UzBKYTJBd3JO?=
 =?utf-8?B?UXREeTc5UFhXNXNxMkZrak9BbnZmTjNUaFA2eGlCY2Noa0E1b2FxdVJXRytQ?=
 =?utf-8?B?UEJWS1RwUlJhbzRwWVM4QUx1V09MeldqUUlGQ05zN2pBc21MYlFsWE5BL2tk?=
 =?utf-8?B?Q21KQVRaMkJIUnpyeHpoMzdyM2tJaUkrczE0NnZwWUxxT3FyMURBQllKS1Vn?=
 =?utf-8?B?bVhEWU1IdWswRDFuMU01d2JUT3F0M3BJSnphc1NtNnhYMDRndHdxaC9rWHpt?=
 =?utf-8?B?aTMvRFBwV2djcTlIK1JKY0xtSFlTZHpObFpVUDgxQnd4R2xyWk5meDZaY2Vx?=
 =?utf-8?B?aEwybHVxbzZEaSs0bkVlYzkxL1pxOW1qZGVkYVFKUE95NUU5RFFFaXFxZ3Ju?=
 =?utf-8?B?SDc4ZVFoUlBFZXhSbTJGbmtaZmQwdldmZ3ZjSHVOMHhXME5iWXdzTURFZ0lB?=
 =?utf-8?B?dllOelJCbmdqVWN5Z0svbDN5Y0JVS0E5eGVjZ2pzRUVrUFpPbks3VVhEam5I?=
 =?utf-8?B?TGl3cU40cVNKYjRyNUwyUEVmMlZRSVNWbTNIaDBjSjVKVWhzTVpjSmlXV2I2?=
 =?utf-8?B?bFBZMU50eWUwNVhha1pnd0pVYkFybWZmTnRia2dqTHFGeC9mQmMwcGpYRlU3?=
 =?utf-8?B?aFhDc2ZXTUN6L0FucGFTWkJPb3lkbWtnbVc5V2N0ZlZqVTltMFg2ODkrMFJG?=
 =?utf-8?B?KzJBMWRJaERFT2lLTXV5YkE3RjVnNlZoNE1vT3hhM2dsOTIzZUV2Yi9URmFJ?=
 =?utf-8?B?L2tPS0NLZkUvVmVqYmJzR0hKTzBoSlcxSmlKV09lQjhHcDM0eUtXVlordVg0?=
 =?utf-8?B?ajBkbXVwNHA0Mnk5UGtkRHJlTjdZdjEzTVgvc2w0SnlOOHFnNzF6MzdCWU0z?=
 =?utf-8?B?Q2ZXQmd1VEFHNnRtWXRMdWxzSC82U2dodUZBNlpSS1hxLzZaaFZrR1VOWmRC?=
 =?utf-8?B?c2taWGR5SUM1N0N3Yjg4bXJ6SlNRcVZaSXVqRk1jS0pVQW5aSjYwcDhoSVl6?=
 =?utf-8?B?QzIvQXFuc1o2dXFXT0RCS0Y5U0NKWUVmNW1kazVsNjZtYzFUTDFiSjZ5Rjc2?=
 =?utf-8?B?TXVMZDZDVGVvVmhEN0RmRWFZeWphSzVzcVhha3hxSHRRQkFYSzh2Y042Vmdx?=
 =?utf-8?B?dC9XYjdJRjlhT2Jxa2RKZDBTLytqTnVpMFJVSy9kV2ZsYTFoSjFLS2V3cUQ2?=
 =?utf-8?B?ak1UQmcxK21uTHA0K25VQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTY4K09VcnAreXRjMzA0aDhtZmgvRFpFOUw4emxJcFhYd2NMai9pbFRCNlIx?=
 =?utf-8?B?OTNVSkJLTTFOMXpDWGVNYmVia0d4aXM1dndxclh2Yk5YbW1IM25ETkluMFM2?=
 =?utf-8?B?K2xoMFE1MVFtS2Z4aTluaUNERFUrSGt5VFFzT3hBbnM4S2tWZGc3clZITVZP?=
 =?utf-8?B?UTM5UFRaSDB0RkVnRllMeDJrbHhpMDhycFZrS0pMS1U5VXc4T3lSYy9IbXdT?=
 =?utf-8?B?b2pZZi9yOVFYdng3amd2K0kreXRuRlpuN1NLdk9Xam1RdDlpU0JOZ29jRUVt?=
 =?utf-8?B?L0RERW14YjI4Y2FqRGs3VEZzbUVjNjRxcWltZU9ycE1RU1VUV21nYmpKVjRB?=
 =?utf-8?B?S3RGT1NrcS9mZjVqa204SDFhMTFOMmFvVytTWHZkalBna1plV0MrOVJsbVNU?=
 =?utf-8?B?TC9Xc2tya09wS0g2d3JMWndIL1R4VnRYbm4zVEI1ZTV1cHJzV042VTd4WjM0?=
 =?utf-8?B?N3BidUdEeDU2YjNYcDd1U1VsMm05cDc3eDFINFFUYjBmWXpMd25vNTJsQ1dY?=
 =?utf-8?B?RVFyWlJtNTE5anphT0I3aGVUeVRnTk1DTzZiUTF0dmRvbks4L2FSck9kdU1a?=
 =?utf-8?B?SzVsYmo4Rzg2QndCZmhMaXcwcWdhcXRwaEZaeGd6cGtqUnpEbjczR3ZlNENz?=
 =?utf-8?B?YzMvTGd4QlJvZzNGTDJjMG9CeTZyNlFRbzI0RVRVOFdFcFUvYVFrSnJsQkpa?=
 =?utf-8?B?WHFqekVDQXBPYWJDMyt0TVdvVVY0VGxoR3dwbWVuL0VPREVPeFhHMnhMTXU1?=
 =?utf-8?B?ZFVjT0lkRDBaWjF3RHBUQjUzaXJPV1VkUTlpNE9RTjF1RGh5QzM3RGNZQVNs?=
 =?utf-8?B?SDRIZGswTmd5NXZ0UnpkM3BFaWNhYlJrUExrQWJpQWZtYWh3NUh4Z2dZU0dX?=
 =?utf-8?B?RlhrUzZpTmVNMjJjcWJLL3lvelUzWGxVdlRMY2hucHNiNkI3a1pHZHJGVWp1?=
 =?utf-8?B?c1QwMVFsYnUvSjA5cjNpR3RpcVFyL1NGRTZPa211TUo0S0dKN215Q3pHdTBk?=
 =?utf-8?B?a3BCclBxYXlXaE41QWZPaG05QnFYNlN2dEN3VGhVUmZ3TVlpZThoSkdxUWhq?=
 =?utf-8?B?MTVHcmZERENXNlBIV1pEN2w4M1kxbXV2ajFmbXFYY0FoMW1abHo3TkFvMlk4?=
 =?utf-8?B?dVpYRzBjK3R6UURsNzNWWG80RFh5c1BuQStxQ2xmN3VaNzkwSnZnWUw5MHd1?=
 =?utf-8?B?elI0SzlCaWJGY0lQbGJ0QkY1YWZzMDhLTlN2TURsVnludWl6a2lRZGhPYUZH?=
 =?utf-8?B?SENuNUJRWmFkVUlJQURWS0dTUkV3b0dwR2hYVXFiKzNsVzRQLytFRld6YXp1?=
 =?utf-8?B?dFAvREJEaUhWcWErN3FSSHNhOWNMWjlIaVBRR2lua2plVUF2TUwrSEFRTDVJ?=
 =?utf-8?B?WURmQlQ1ek16dGx0VjFIVnBSa3lRUzB2QjQvbmo1NlVqcHZZUVJiaitLVmVL?=
 =?utf-8?B?T0FHYTBma3FaNit1a0pISHhSd0wvNTR5eENPUnhVd0J2eVAwcit4SktyWVl5?=
 =?utf-8?B?RGNtOGNrR2NRQU5xc3hDeTd6NjAyUzByb3VjUnoxNG1wOWZhbFRmZGx5TFJp?=
 =?utf-8?B?OWVCQ2FFQWdjQ3h3U1h2SUF2eFFaVEZaZFkyRU4wVm5BanJJUkRGV2pSZCt2?=
 =?utf-8?B?WUREU2l3djU5U0g5Syt5NHpiSnNTcXdydW5UMFRXUHhTbWZuSXVhMFJjQmgv?=
 =?utf-8?B?Z0Ixc1hOQnUxbFN1cCtJSWlJbnFLREJVbllSQU1RbGVXSTlEWmpobVRON2t1?=
 =?utf-8?B?azVPbWVzMVRYQW5aNm1PTTFsYkowYjdUTGZqSGV3am5CUGVzVDhrNUx5UG1w?=
 =?utf-8?B?THQ5K1BEbWFEM203VFFYbmpNUWg2RERSTkNoY0crN0dscUw2dHNRK09LVjBM?=
 =?utf-8?B?SFFsVGFpMUlVb1pxVUVPS0ZGZnFqV3puZ2NZU0ZlaDlSZFBLYi90NGhXcWk1?=
 =?utf-8?B?RzNHbU1QM1I2M2RxVWhSZzM0ZHExbXdoRmY0V2xkRmsrclhEN3B3eERkSFZP?=
 =?utf-8?B?SnI3MGM1VmdGNWcyZ0JjYm5wR2xuOENQOTI5Rm8zcTlvRmRwdjFGWGdkTGZY?=
 =?utf-8?B?dStJQnkvUXlwOWFuV1JOWEZ1bHR6OGhHL1k3R25qWmovZnNnTEwxbWVTM3VE?=
 =?utf-8?B?UGNUMitqdWdZRXJudmZQVWhENFVGeE41ZTVvVHU2STNTTjNLSU83ZmxQZGtO?=
 =?utf-8?Q?P3VChTfaEzq9X4UpcTLZG6M=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d1b6ce-7d5e-490d-d612-08dcb2ef8543
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 12:35:00.3607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqyMjyNj2sQ0BJTdcz0pZ2AoHb7DZCHDNiqy40jSRNgyTSzllsgBkxPVmzbD4Gc1X4U0TIul3UBjxaD3wOWmgVhc2VwuNzY76i3J4uoDpJCg8IGbzP8l1alEIlsUV8pI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8152
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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


Hi Peter,

On 16-07-2024 09:15 pm, Peter Maydell wrote:
> On Tue, 9 Jul 2024 at 07:05, Ganapatrao Kulkarni
> <gankulkarni@os.amperecomputing.com> wrote:
>>
>> Extend the 'mte' property for the virt machine to cover KVM as
>> well. For KVM, we don't allocate tag memory, but instead enable
>> the capability.
>>
>> If MTE has been enabled, we need to disable migration, as we do not
>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>> off with KVM unless requested explicitly.
>>
>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>> which broke TCG since it made the TCG -cpu max
>> report the presence of MTE to the guest even if the board hadn't
>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>> then tried to use MTE QEMU would segfault accessing the
>> non-existent tag RAM.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
> 
> In target/arm/cpu.c:arm_cpu_realizefn() there is this code:
> 
>      if (cpu_isar_feature(aa64_mte, cpu)) {
>          /*
>           * The architectural range of GM blocksize is 2-6, however qemu
>           * doesn't support blocksize of 2 (see HELPER(ldgm)).
>           */
>          if (tcg_enabled()) {
>              assert(cpu->gm_blocksize >= 3 && cpu->gm_blocksize <= 6);
>          }
> 
> #ifndef CONFIG_USER_ONLY
>          /*
>           * If we do not have tag-memory provided by the machine,
>           * reduce MTE support to instructions enabled at EL0.
>           * This matches Cortex-A710 BROADCASTMTE input being LOW.
>           */
>          if (cpu->tag_memory == NULL) {
>              cpu->isar.id_aa64pfr1 =
>                  FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>          }
> #endif
>      }
> 
> With this patch, for KVM we will end up going through the
> "squash ID_AA64PFR1_EL1.MTE to 1" codepath, because KVM doesn't
> set cpu->tag_memory and this is still using that as its check.
> 
> More generally, how does the enabling of the MTE KVM cap
> interact with the ID_AA64PFR1_EL1 value that we read from
> the host in kvm_arm_get_host_cpu_features() ? We care that we
> have the right ID register values because we use ID field
> checks to determine whether the vcpu has a feature or not,
> even in the KVM case.

Using ID_AA64PFR1_EL1.MTE bits seems to have issues with the Linux 
kernel implementation.
This register is sensitized to user space and value read differs time to 
time. ID_AA64PFR1_EL1 register read at the beginning of qemu code will 
have the MTE bits cleared/masked. However ID_AA64PFR1_EL1.MTE bits are 
unmasked and shows the real value of MTE after ioctl KVM_CAP_ARM_MTE is 
executed to enable MTE.
In QEMU,. isar.id_aa64pfr1 is read at the very beginning and cached, by 
creating dummy(kvm_arm_create_scratch_host_vcpu) interfaces(fds) for 
kvm, vm and vcpu. At later stages use of isar.id_aa64pfr1.mte at 
function like arm_cpu_realizefn does not show the right value and code 
never enters the "if (cpu_isar_feature(aa64_mte, cpu)" loop.

Not sure about other feature bits, but for MTE, using isar.id_aa64pfr1 
may not be appropriate but I do see it is getting used already many 
places of the code. I am not sure how it is behaving on emulator/TCG mode?

Having said that, I have tried to remove the sensitization of 
ID_AA64PFR1_EL1 for MTE bits in the kernel, but that will have bigger 
problem like the VM boot crashes with the default compiled qemu binary 
with normal VM boot itself, since VM detects as MTE present and starts 
init of it.

> 
> Since Cornelia first wrote the patch this is based on, we've
> landed gdbstub support for MTE (so gdb can find out which
> addresses in the memory map have tags and read and write
> those tags). So I think the KVM MTE support now also needs to
> handle that. (See aarch64_cpu_register_gdb_commands() in
> target/arm/gdbstub64.c.)
> 
> thanks
> -- PMM

Thanks,
Ganapat

