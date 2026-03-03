Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CE7EC145F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQuZ-0001Rn-26; Tue, 03 Mar 2026 09:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1vxLBy-0000HV-R8; Tue, 03 Mar 2026 03:33:24 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1vxLBw-0003aN-O7; Tue, 03 Mar 2026 03:33:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfN1xQrR+nDFlzW0IyynPYoHtsV8ibGZqhbp0r6qPXrZocEWGVREGa8On0kcLdPiIeH0GcqD6Mv1/p/7JxKlCs0NppPqm+NQgwbhInMQSbx084K8I20WUeUrZzyt0B3BQTHHderQ7FjYlbDaU/suqLIjQjApc61incyUOiSOrRC0Lad2krB6iHERGHvo23Wu8WAKvknomitVfwzHgJCHfa04McvFWwS00fLHPKasR77UuV/KvCakuKtx+h3tBaDzjmONlqhwdgnQ7yZrXzSKyfVW4UEopispVHEog8HZec5UF4iuNhNwMWpnO8+rnO81D2X+zaD+nBh5pBa+9sFANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VZYfcQPNt/Mkc+k+kGgQ9OVm7t2aQ0Qzqn7S7yheiQ=;
 b=in+E8llkKk6Y5Ph6bchCBdelufjMe0jNRFvAepyZCR8VS4/jdHqOSDNQAYBgp76L+YxDcgEdp34Im31/PFlZBkCv3ko1WOuAou932dJ0u/JVOwJacRNY8pAmaQcFYFgoFI9bGCYAao1Up9Tt/B9h4O00Xayt5vyuh3emPT3wjPhiixkFQQr2CSmzAfsA8ENRdRFrcXq6M9dtlcd5cgBqBLqznpUHVuefc3y4OIm02BhMmsStdww6NMFeXmd8/Xfw9AFJ3c/QkrUec/iU6VBazU+Z/YZeixZILrxyooxKgY7K6O1GW98u8qI+c2bpIJAKUC+QyXTzFmmGVvQSmJkZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VZYfcQPNt/Mkc+k+kGgQ9OVm7t2aQ0Qzqn7S7yheiQ=;
 b=KveDUSI6od7PoxSdOfLOP0N1xAZnTnSDeU/p8KTB+kqR+nUJJvZO55FheOVCEUcLXlsSJ86Yg1GmfccGSJuDOoDBFiqDyht7jEZJo/ZebAxhGdjehv3FjJ0Xibpf5PEmqtMc5kq6LIa3Gveq3YXSkW0ERrWupijLTx5HV9kbI5c0MLVNEZmF35Be2RP7qLNVbgmnvmAOgA+DRRB6zQ3hhpiY51nDLqphUYYkK0owLNxweF075rW5FGbJjk0s95C+u6Hi+eHU2Q8wwcfvVYy2H14JjF7TNgtXcC8lORwCdMvKEnr7drw1mcuUPXmO2sS1psxUXium+mWnVZ2ixuuriw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by SA1PR18MB4551.namprd18.prod.outlook.com (2603:10b6:806:1e2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Tue, 3 Mar
 2026 08:33:12 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9678.016; Tue, 3 Mar 2026
 08:33:12 +0000
Message-ID: <69691e3b-1605-4a5a-8ad5-0eec56ce3eed@axiado.com>
Date: Tue, 3 Mar 2026 16:33:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/char/cadence_uart: Add BXRS register
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, alistair@alistair23.me, edgar.iglesias@gmail.com
References: <20260212104432.4168886-1-kchiu@axiado.com>
 <CAFEAcA_u5B2RdVEaGycCQ6gCx1pQuT8rvGVGZpoKLTK+2s72+w@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA_u5B2RdVEaGycCQ6gCx1pQuT8rvGVGZpoKLTK+2s72+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::11) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|SA1PR18MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dab9c1c-690b-4f69-1fb1-08de78ff814e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: fywTCp02Ez16XTDNOq61/j7aZFbpD/xkr+iA8bLe7DUM3FNrgEXu3XehbOnrepHDAMSar7Kj/HziHTpU8rK7rP096xP03QTJQAP5desgo3p+z2tzBSuXPH0PzSgLE2plSx5j8oBbCAJs2N69vuhrQXaImaQyc1f5GJmjE/0TN/3KiX7ntkj6nPp3lk9PfHd4GohR03uB1FX+3iJbPkE8yOCH4ZBy5DAYdWhgWv62NVX6Gzntaji6ARGCmvLTm4xKe5x4o3tvKQNZK3X+zy/dMgVRYNav0Hb6iQdP1EnXtpKwPnnysQiVUUYRqlCgxAz1BuG5jGXFlf0XSzeJ13kE2LEOAtHR04aKsZmM9/WuyZQMtyzKxa0egecQIc0YKBohGBBhoDrS194a2b5zlISxsx+LdISgcT3rL6ZitH4zMzMQ/0vcX5gY/Q+UKB4wC/ApBFs7P35zO+RoCecL4xnMhlwk9UD+VMAzd5TbT7m9X6nVYgdWaICgvr4cPIqva1gbSRe26+x++6pDTValNRciwRlyFnceE4Jwj6qRxAvkb7twlwaLlEnOtEpZJ93PPv4qTwZUF6YQlHK0kHGzgakLkz5o+mvdyDJXUYd3glaRDhlSus0Q2q48KOF0nWPyZbaBK8kVxZML2I3zXtUCVMKioNEssmJICegq/4M4e/riLn3uC1suyhnL+xCehJPXqugeRphQNwe3MXhqNpQy8Y8Zgk0AlwZFFCpc0MG8UZdvu6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDVoemN6UG9Pb0lRL1pUNzF0eFhuWGZTQjJzVzdUVlkyYUVuVXlXQkdTMFJ3?=
 =?utf-8?B?cjhEY3ozdHQxaWl3aHpVOExxMmg2MFFrVVAzdnVZeDFPSFNaZm9aT0UyelhJ?=
 =?utf-8?B?VFFLcFh2RGRxM2hZUnNzVENpVXFBVjZkczFwc1BQdlVIYzJkVHpLNHNRSjJj?=
 =?utf-8?B?aTRJdEYvWUZQUnB3TW9wRm5uODduZjN6WEpZODB3Q2FrYVpUYjk4WkltZjBp?=
 =?utf-8?B?b0hjaytONHlJVFFZeVlJeUEzaXExUnIvWFRQMFhsWjhnMW1WK0xPWm5hQ05Q?=
 =?utf-8?B?WlpvclNlcmp0TFkrWUs3LzNCbmE5NTEwUklkVHNUTEZsUzlGQ3lxT05uclQ1?=
 =?utf-8?B?eEhIVndNclZNQVRkY09TTmlBYWxXa0VDSStIQ0tGb2FCdkpTRDBMN1JVWm0v?=
 =?utf-8?B?Vkh1cnVmdHc1ejZBZzdzRGlnN3l1bm1LTnFYY3lCdHk0L0k0ZFd2YnNhK1h4?=
 =?utf-8?B?eXkzMmg1ODJiR2lqYmRLNEo2MzdwdTd6SWNIRW50Y1ZickNIQm5pMlRndy80?=
 =?utf-8?B?eUN6VE1qWjVuczF4MTdORUdpRGRiMXNJNnFEZUhvNGp3QlNJT1RXdlNQTjB3?=
 =?utf-8?B?QTJVd2Iyb3cvRnpLK1p2YWJTTmllSFN0cjFUajNvbXh3OTladXY0djdzSWxX?=
 =?utf-8?B?WGxZZTlBTkhhOU15cUhoVTNhNFR3c0Jza2JVQnBsVEYrU2pQZzVjYXFFOUdk?=
 =?utf-8?B?enVxVjhXZVZ5VUpkN0t6WEtoN0pBRFE0T3VMUlBNYnBocVhzZzQ0eU5FL0p2?=
 =?utf-8?B?dFllaThYV3VWaW5PVkEwY0N6V2syM0ZIdXozWjg5RHpEdlRuNVd4RGFBUjQz?=
 =?utf-8?B?MHNHQmNoYVZ5QVRrT1hGNmd3L0dXeE5wYUFQbTZFYUMxVzlSRkxoT0o0Y0lo?=
 =?utf-8?B?RXJiTFRUZnptSmk2M1MyNGFwYnNJdmhzN2NCUDdvbC96SDJRdWg4bnVOR0s2?=
 =?utf-8?B?SnlKZCsyMXpyaGxnOGNwVmJUZ1FUSHNqVi9UUUJYdC9LRDNtd0RUSjJ6QUVU?=
 =?utf-8?B?M005d0N6ZXVWNWlWZWdjdDNqb1hiRkpsVEw3RUordzEzQjNJNFhBa0FhM1JT?=
 =?utf-8?B?MDhIVEZLNFZ1bjg4ckFLdWdVeWt5dnErck5iQmNZbS80Uy9KRnlqTnd3czlD?=
 =?utf-8?B?cGZOdUMvWTM5d2dpR0RpTWcwWlV3WndIWDZNNHRLc0dpQ1BnamI5NE5pU3c3?=
 =?utf-8?B?M0N0UXd6Kzd2MWMrWEgzS05PbjhtNGlhTExGOXptbG5TY3lVczliaHFRK25q?=
 =?utf-8?B?RjdZbVZIenlQaXhxZFNJWVVIdDBEcjZPMk0wNVBBNEdvOVlrY1Q5Nzg0SHk2?=
 =?utf-8?B?d1hibjQyTGpJOXpVVXNvOTBOcjhVOFdpZlJwL0FmeTJjd3l0aHdsbEk0WG1R?=
 =?utf-8?B?OFpiQzUvZFZoNDA3WCszTHR6YisyV3R2WThmNEFUOElENWVMWCt4ODNYb3lC?=
 =?utf-8?B?bmFDTlB3YytyZ05YZlVObkpQTEtNMEE2aVg4VkNXZ2JsT1lCMW5UcGZoZHpK?=
 =?utf-8?B?TU9RWUZTTUthV3piZjVJbmR4VHkwMXZOc294dU9hU25EeWtXUXlUMUltOWtP?=
 =?utf-8?B?LzJsKzVMWHR4REhUT0ZFNFZFeEZubTFRSmdlU1VkTllUakRVUXFHS09CdlZK?=
 =?utf-8?B?YWt6alBzbVJqTGx5WERFSVN4Q2h5TWQxWGw2MzRMTlBTSEcwTDRmc1NQZEIw?=
 =?utf-8?B?SmZDUzEvYnB6eE1vdVFBVFZXeG1BSko4Uno2TDloU2ZqbzFBVWJKZE9HbXlx?=
 =?utf-8?B?QkFiWlZsamJUV2hHb0V6d0tQWjZHZkNrRksyaElGa3lDaVVHdGZ6V0E0NWY5?=
 =?utf-8?B?RVNmY3F1clNzWEFRN3lQa0dvN0pOekpaMFlCa2xTT1pHSzBQSTB2V1dFZlZ2?=
 =?utf-8?B?Qjc5a2U1WnJnMnZrT0lTcHV3MHk2ZUJ3T3NJQ2VRV2h2R1pCSnU5cURUTmJC?=
 =?utf-8?B?ODNiV05URnhOYW1ENnBMRlJRdytuSmhuUW1aMmRuSFhSMS84ZDRiTVBqa1lp?=
 =?utf-8?B?K0xCRVhoMDdmMXRDeVdiNlk0UWJKY3YzdHpNdVN2aHFhUFlTK1dtOVNKUFR0?=
 =?utf-8?B?ZktWT2J3dXh5UDkwZ3RtWHA0dVF5MS9QZTRyWEVRcHE5NnR1QVo1SGQ4UHcz?=
 =?utf-8?B?Ym1LSUlBQmRQMmQ5MjVLUzJhOGw4cGxKcjZ4WlpvbUlWNjQxdVFXRnFyUU1t?=
 =?utf-8?B?bTVwcEZNbHNHVktGWW9iRDBMZ3QvbW9IM051enIwM1JjbUZOUi9MSGNEakk1?=
 =?utf-8?B?WnZhcVZzNVgrcEFXLy9Da1B1dkJ0VG1FU1I1aVhWNWY4N1hmZVZIYzdqdVFo?=
 =?utf-8?B?NU9RYlN5NXQ0MktIWFVXVGtxZisvYnJuT1k3NWRCMFpaU1IyR0x0Zz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dab9c1c-690b-4f69-1fb1-08de78ff814e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 08:33:11.9518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7D0VixQbtNfcGflP2rrbLXvYLl1O24aMKkE/yrCTxgnTsknsWhm/B2GvY0wZDC8BJm4gU5i1A5hMdOdyqxPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4551
Received-SPF: pass client-ip=2a01:111:f403:c107::1;
 envelope-from=kchiu@axiado.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Mar 2026 09:39:41 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

I was referring this commit of upstream kernel which xilinx added BXRS 
register in Cadence UART driver
serial: xuartps: Adds RXBS register support for zynqmp · 
torvalds/linux@3816b2f 
<https://github.com/torvalds/linux/commit/3816b2f886d0918d8a8ae593b2db203ab905a889>

Peter Maydell 於 2026/2/16 下午 06:53 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Thu, 12 Feb 2026 at 10:47, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> The new CADENCE UART driver in upstream kernel access BXRS register
>> This patch adds BXRS (RX FIFO byte status register) or there would be
>> kernel panic if user are using the new CADENCE UART driver
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> Hi; thanks for this patch.
>
>> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
>> index eff6a3c4d1..f57cad57a8 100644
>> --- a/hw/char/cadence_uart.c
>> +++ b/hw/char/cadence_uart.c
>> @@ -120,6 +120,7 @@
>>   #define R_PMIN     (0x3C/4)
>>   #define R_PWID     (0x40/4)
>>   #define R_TTRIG    (0x44/4)
>> +#define R_RXBS     (0x48/4)
> Where is this register documented? The cadence_uart.c file
> references the Zynq 7000 Soc TRM UG585; its URL for that
> is out of date, but looking at the copy on the AMD website,
> there is a table giving the register summary for the UART:
> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/UART-Controller-UART
> and it lists only registers from offsets 0 to 0x44.
>
> thanks
> -- PMM

