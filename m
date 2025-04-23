Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ABDC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XBf-0000Vn-Bo; Wed, 23 Apr 2025 06:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7XBe-0000VY-AS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:18:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7XBb-0003oN-EK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:18:37 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N9X96m018221;
 Wed, 23 Apr 2025 03:18:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=guh8wT37+BZ6gHeg9uz83c1iOuhQJp9QFetPXc6iu
 +M=; b=DjRY+G8vkMjyHL/eMdWR7fnn7Ey7yg4padm1m0Rh3qFOF4Jj5mnoN2cSa
 2rmoL4VPDnmaZjZz0WI6LEUB3DAaLwn2S0CY2QvSTxFdqmU2atSDOB79vF4WKtDz
 FZVyvAv2Bq9jmNJGF1SwQkVQJllFai7uJHwAjVe1MU/hw/aKOoiId4Pym2kXMyst
 V4WSo3tl0dSul1SkzLXuklI4zT+OvUG2s+6Mr2MiILbh7f6ZVyfq2iWCkPqnNne/
 1Uxc1LatclyLXLXcPr1OGVdW4Lf875wbgvhbxlVS9yI0he8w1T8UNwut8ahDy4kw
 yoR1IXj69apy4Bvq0aVGPkzG1knrQ==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhw1dq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 03:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ck9J3fMhXxcoUdQIPYRZ7iG6kmMpMyAPGAQKptwC0EOOG3r7gE5EhsjjlYPudHKAMBLzl+GXgzSehFfeejvoL1YtVtO8pS6D23n/wAjQh4fh59j53Xbg6LrvylLaRwkX01PAhq6038lYMgUg+qekXaXsfxuS27TfH5LjdgFTFnrx0qpLFLzJ9GbQYQ5t99PZ6NEnQ57Iuz0JoWZpJjZe7Uoh4T6Vpcyb1QNEqLmCkKPJSUq5ETGjQo6wlax8W61L45elhyvA5jo3MljBslM5Ds4mZ/die9rLvmltZYk1iIg0uz5gF46L7CqUFJmV4EjT3sZimKMQlZxjjv1w9yZNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guh8wT37+BZ6gHeg9uz83c1iOuhQJp9QFetPXc6iu+M=;
 b=QM4vM5aZeZhot3kAKw0dWvXdwRveAcModjS+9Q5DFt+K9mz1+vnW41WE2BUNKuzrUyFbEimbo78m3ym1zuE7635/ycPO5O6eshtbRcnYvAsbjINPY5pf3JZpoV/5D/pN3NUK5Xz9vtbQ52nzGx43XvT6AHdsX1N/wwkaB+ABJ3FMxwo4kSyV7MIQJEuZjMxDU3+CnU89ETILNVfPUBMmaUrQx3JlCIc1s6SA9zPGq+DZAUZ/HYDedYeCReAi9Nf/3KNyR0zvWWi7KoiBWLEJaJr1ZB+O2cbSxnSqbIflA8hqzD6eV0Xz5QB3OWtbPYYCvYvDQ78miWz9Obw3a9Cc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guh8wT37+BZ6gHeg9uz83c1iOuhQJp9QFetPXc6iu+M=;
 b=HBJc5jNyoebUZi3681jGwiYiYAiedyXnwosNF4/ltpxVJr+eRDcQ4zFEtsVkMWOaEbo9tPN54CLgjEXt12bOyxcumJT+oqzOqsSUiV/FZapCmu/oVpvOMDdPQt8rPSrJvVAbZi+T7gQHlZdnjcjifcaGms7WfFp1qgUczF6jCwAZ5hDl5jpn9SOrZfv9O06uWZstQG8OOjw32gbVz6/qVPVAY2yZc695LIpZfD9raAL8Sy7HHOa3dSb/B+3ERm1+7/KzI8l5BsKn2ts6jKyJTlIY60c2rgtFuCBGCP9YH4UHTZW2odDBP7t+L4SbHkRcO3Pm9HAwik82zET2UC6iMw==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 PH0PR02MB7221.namprd02.prod.outlook.com (2603:10b6:510:b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.22; Wed, 23 Apr 2025 10:18:19 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Wed, 23 Apr 2025
 10:18:18 +0000
Message-ID: <f3501944-f278-45a8-91a7-0dab5a5416e0@nutanix.com>
Date: Wed, 23 Apr 2025 11:18:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Move device tree files in a subdir in pc-bios
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: "Edgar E.Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 philmd@linaro.org
References: <cover.1745402140.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <cover.1745402140.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0111.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::8) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|PH0PR02MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: b0045e21-1224-41e3-8473-08dd82502ada
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1hseWcrRmFmeSsrRjd1aVNWbS9nTmhNZVVObVdWVi9YcThsaFNGMjZlMEtR?=
 =?utf-8?B?N0lRbVhMQWZ0NmxrNTJCTWp3YWhJbEJHZlI1V09tbFNBTzkwSGdGMUtVbG5s?=
 =?utf-8?B?OXhyV0x2ZVZqcHZHZUU5Q055eExORUxFSzREQjBtTGxBdjV6Y2lPMit4S2Vs?=
 =?utf-8?B?VURiK2FFcngwc1YvcFo0Uks1MkpDdTZFNCsyMzlqOFJNRkg3UGtqUGNQcldx?=
 =?utf-8?B?MU43RG1UdkxUK0tmRXdWRkxMN0pMNkFaQlJWa2pBWisxbVVHblhrczA1Sk5t?=
 =?utf-8?B?SHBiUUpWSHJPOXhLYUJScEMwV2tTRXRDRTZacWZQWjl0L1Y3M0RPN29aaUo2?=
 =?utf-8?B?OHdDanBCRFpSY0tVdE1FUkNTY1R3aFN6NnNjRGNiVDZVeFpKa2FpaS9sUzlL?=
 =?utf-8?B?R3V1WEx4RUIxbHBSVlZaSXZ0K1RCRldJMi9wU3J6V2c2eENITkRUNmNYdFl3?=
 =?utf-8?B?OG5QbWJwd0dicUdvUmdCNzZpQXFhZVFweWZLeXkvNlVNakVENGp5eHA2S0xk?=
 =?utf-8?B?aG5uRVNtaWY4VkxoZFBMYVBJQjlNYll4cWtCeFY1cTVnbVUrY0gvTTI0TjhV?=
 =?utf-8?B?ZTZUTmRSQ3AzYUc5K1h3aFB4V0lpTmg0TmthU1JvY05hbUhPTHBuYVhodlFH?=
 =?utf-8?B?YTVlYnhJUWlZZ2Z4bUtYQTV6YkprVytKeW9nUEY5QWwzdVY1bUhQVExXS2FK?=
 =?utf-8?B?VlQxbHIvZjVZdUNuY2FSQWNaYlM4RVhQYnA1ODFBelhvRHF5U0dIZHF6b0pP?=
 =?utf-8?B?RmdWUTRUYXY5ZEhqWmFzcUZSZUlmbThIWEtOb3ZXdnRrWEViSkgwMTZOZGNC?=
 =?utf-8?B?L0pvUmZGbVZxYXVKT1M0bmpYbVVBN0xjL1FDOGlkNGNaS3pMMjlIWi9ZaXlB?=
 =?utf-8?B?VkNJWEJpRGpHNUNKR05TNHdYUXF4OElVV1FENDNsYitINkUxNXNHMzZ0Z1lI?=
 =?utf-8?B?QTc3Q3hudUJ5R1R6OHlBWWZsQk9FR3Z0aUNWaVBvZXVOYWdRaW5DWm12dzFx?=
 =?utf-8?B?eHNSc2xxeDFPSjB6M0JDdVpLSTFxV3Byb0tkaDJ3WGVsZy9GV3g2cGkvSjJ0?=
 =?utf-8?B?RmxiRUhmQTJ0TUUxNGZFTWxXL3F1dG1zcmttNUtWbUhNUHZoTFBwUFRLL1Jo?=
 =?utf-8?B?OUQ3NGU3RHBlTERuSjIySVl4S095eEp3dk1nME4zN0tpL2Y2MDhxNW1jdjNp?=
 =?utf-8?B?M0dYeTFMVGl3QkZXbXl6VlhuM1krQ2NCdXBHUkdRenl6Ny9mRFJNR1pwT3FU?=
 =?utf-8?B?cHlUK05Xb204bnh0LzVxdGhJeCtUK1BWd1hScVpQVGxQT1BmK2YyWStHOFli?=
 =?utf-8?B?VzJMa3g0eW9VOVVyUDFUNmgrL3pSVTVkckZ3Q0paRy9iU1RCWUpYMnByNW11?=
 =?utf-8?B?ckdxUWFPYWIvTXRxQWNGd2RiSEJhQTR3WVRJb3pFbXBXVmtTbEt2Z0Z2VXU1?=
 =?utf-8?B?WklCT2VCMTlLNWsyL05pTG8yMWdGay9SNnJ3NXBKbHVyNnpHaHdHRVhKaW03?=
 =?utf-8?B?VFNIdE9ySm14bi9XWmYzQVc3SDd3VmNCOUJ4b21YdFpVSnFHMXg2SXp2dzVs?=
 =?utf-8?B?ZnBsZngxc0tCNk1IdEoyWGNpdWJDbGMzbWdtSzRMUzgwUkFWRk9tZWJ4eFlC?=
 =?utf-8?B?UkU3aW1EaXM2d1NuR0E3ZU9zVjJJL3FLaWt0ZGEzcnNyVFdkU3pneGgwbldE?=
 =?utf-8?B?Qm44OXpiczYxdEh6Y3VpRHhQU0lVaFB2ZmtJeTZYZTR5dGFSdzZGbGZOU2or?=
 =?utf-8?B?c1owS1BvQTdGU1pNYnByUTlGZFUrdmNDR2tGTDFTR1Y4bGtyaHlOektlZUR5?=
 =?utf-8?B?NERWbml6WG5nNDg0ZVYrZzZjWUthc3RaZVlkV0VGdzI1cUtYT2p3NkhBUldy?=
 =?utf-8?B?NWVIUGZnSk9PTWZSdklwQnRsS2FwYnhFWTEzajhteUZNblBZckdHYmNiWk51?=
 =?utf-8?Q?wAWc0E3bgDg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJ5SC9QNms0bm1YSmFmdmJVeHN0REJsV2FhQ1lGWjJmZzhmbHFnTlphOUdU?=
 =?utf-8?B?aThUY1ZzcHMrRVR2NlBjRFAySHFkbXhsenBDTGk0bFBXQ3h5MVl6OTFJUW5M?=
 =?utf-8?B?N280RjM5MTc1SGpNWmZ0Y05oODFieDBTNWRDN0hIajl2RWNLYVVMQTF6SzBa?=
 =?utf-8?B?OHNpdUNHRm9Ma240NUtNRS9TTEY1VDFqcEFEb0Qwa081NlJEUGJjOVpRb3o4?=
 =?utf-8?B?c2dBWkdkM0plRkNvWFVEdExJb1VLNE9icGQ1cmVQMDYrRk5FVkhTWFZFc1FR?=
 =?utf-8?B?NVViaHRGZ2xSNEpNcEpqSUlkQ0ZxS2J2VElsVTFIcnhUYWxDYTdUeDlkK2dr?=
 =?utf-8?B?eU4wcThubEJpMEROT2owZWZqTWh0NU5KTk05NVgxWjVmMGE5QmNiWWJIbW93?=
 =?utf-8?B?N3M3WlRpM1FKZDlHVmtlTzEvRS9lenpUc1dJTU04SFRqQXRmQUFaRDY0Nnlq?=
 =?utf-8?B?M0RvMkE2cjlOV1g2WEhWMHVWa3owb2FId2ZaMkFiY1RnbG8yY2lzZFhVSUwx?=
 =?utf-8?B?WFVQcFhWdHVEcWZUUnRYMkVKMVB0dU8vQUx0UjlnYmNJNVlwbTdCamVQS3Vh?=
 =?utf-8?B?R2ROd3V0NHdtekdvektsUVlodTNjNldBWkZLQ3I5bWcyRUhLcW9Ec2hONnc0?=
 =?utf-8?B?M2lXMCtsR1JrWEZaRjNMeGpDN0pEOGMwUnpTZDQvMHJGNlFYRExJbjE1amRa?=
 =?utf-8?B?TEJiMThFTzM3enRZV1ZHRnU0YTdFNG9yS0MzLzBZTWdBSkdiWCtJaURrL3B3?=
 =?utf-8?B?RTBqdVRXdHl0K1UyOGdveXk0ZENmNldxQWYzTE45bXJqWHgyWkErWE1uV3ds?=
 =?utf-8?B?ODZlQXE3dHRkbTdmN1BvZ1F4enNxaGVabGNTeUg4VTdUOXJKM2todUUzbW5T?=
 =?utf-8?B?SUxQZ0NlaFg2emtpK0liREdMVlBaTVVYV2p1ZWRvZmdRa2ZEOGxONDh4d2Rk?=
 =?utf-8?B?UTR2WTdSWlQxYlpaL0pPSDVjVmhJY1VpVDJmVExQUDd1MEU4NGFCYzM5RTFu?=
 =?utf-8?B?eDAwRFRrUkFJYkVZMHA4a3pYY1FzeDM2NEpINmdaTGx5VlhHRC9ackVUWVUw?=
 =?utf-8?B?VTIrY1FrU1JKVlFnN3hLcTV4dkg3dXFTZHhzUGYyOU5Jb2d0eHNGWHFsamNx?=
 =?utf-8?B?WHczWEtMQjFHQm5qeXo2TFZJdTFlaUNQUnhUaldJL1AvOHAyWUNaMHFlaDI4?=
 =?utf-8?B?cXlSZEEvL3plblM3QWg3YzNxS2t3QUFIT1JxVitieW1tWHVPc3ByMWQrNVVl?=
 =?utf-8?B?ZjB4ZkowSzhONTBkRHBIL2c4STNSK0NlUU5FRHovZ1QzblJlb2tlRXlXM29H?=
 =?utf-8?B?UC9kb2VGOVhVTXRhbldoY2svQlZ4NlJxTWIrQ2J1RWtzd0lFSU8xK0tFdlVF?=
 =?utf-8?B?UWl1dk1EZVFxOVJMQ2t6MkRrNndRcFVGemxhZkEwek1wbVJKdERQUFRCb2hx?=
 =?utf-8?B?cGFudHZBZU01RUg1ZDA3Q1p1Z2o0MEdxUHRPYy9GaXBtTkVwSk5QRTIycU9J?=
 =?utf-8?B?cU1ydndDQTB1b0t6aDFaSUI2VHBZeUZERktSZlMvdEdHeWZmb1dPWUltYlZ3?=
 =?utf-8?B?NVRsVnBISlRlYjU5WFppNUYxMHhrUENZZUNvYXZveFQ0S1FKU2YvclU4S1FS?=
 =?utf-8?B?TkUvenJZM0kxNDNlZWZXYlpDdzdVa0Y0bGp3NnVETG92aDF0TWlXUTBkTnhP?=
 =?utf-8?B?RUl1K2FySStqN3lkbFJXNnlTSHpOTFBsUjBsY0Z4dnBkWFU0NExWdnlvK081?=
 =?utf-8?B?OHlzZTZtTlNSQkFZN2FhajlBTnV2NnN1WTArYWxtenBEQjh0SGlLdHNvYXI1?=
 =?utf-8?B?UFFMRlN5Nm04QkdHLzNwM3gyOGVHL2IrTVRma2UzZDVoeDZNWUd6LzhVbXhX?=
 =?utf-8?B?S2lVVjJoVHI1UGQ0ckJHVE0vYkV2V24rQUEyM2FaTFM5Um5rWVhWS3lndmJr?=
 =?utf-8?B?WkQ4L0NlejFBejNuU0VIcnZ5S1I5OWRlaWVtUDVBWC9KWTIvUERjY3pBeVZj?=
 =?utf-8?B?SWFqUnAyYXdlZ0IrUEhGZlpSK1FCWTUrazBhWnJhQnNTL2xnRDFBN2l3Q25w?=
 =?utf-8?B?VVNKNS9sQUJQNVdzaWhqRmxXRGU0SkErNkZuR2F6WUxYRTU3bmJtZ3czekNt?=
 =?utf-8?B?Z2JvdnM0Ukk0alN6OFJuN1VIWi94SnIrRVRiYTY5OUZoSU1oUU9ZeEFjNjZr?=
 =?utf-8?B?NDVOWEdjM2NwNVMvY2UvZDJxNUlQZEZkb3VJaitGcjFoZy93OTh3UWxibFRM?=
 =?utf-8?B?NnUwdVlPNXlESGVWUjQ5QnF1ZzZBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0045e21-1224-41e3-8473-08dd82502ada
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:18:18.7097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDYnfy/9cOigDy9Q4nq99SeG5funfRFR+ue78vMs1CaGiOgWtfdCP14BHGQdQvpfMgbpZYPqdsJ701CvM/58NO7aSd6m0uoQV9Oz5Kw2Zv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7221
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA3MCBTYWx0ZWRfX8lcKt2kh2Owz
 izwhqr5Gwn1HDhiz62OoDX4HqsRE92o3HlW5WLN/z0wRZkM2z8SbMjAcZ8AeubtcPpsEQ4Xeg5Y
 /f4rl1Fg1Cu2IZC3V6cWBpWF+7yZVZQsXNKxjfIlIodg+yetMXzmGgCouwDmzrC9t65BkaCANi1
 qdt8ZdJ0YBNuXele5pn7Hi0MAAjiolf39Us6vH1FXSi3FA15pTD7h5Otxuu2amySeE6bHaNQs5f
 BrDwWBiHhedy6MV9ONgKYRG96ABl3qQgDWzE1EWbNU26oAECh+JmacfUysHn7asaybsp18kXOUL
 LGh3HlVOoragbuGrxL3dFkKXXBHOgYSqDmLU3EYP3ddNA5lRFU+QZcDYtra30hWjn4RR40tgK2N
 cFduXb52rjTdbb5XbnLCzb0SfaSNoh7epWtW1I1uOKk2F0xj0oj4yl790brZYwHdKGJ9ylmh
X-Proofpoint-GUID: 9NvaT6v8IpH8PlelyP9HFOwhOZ9NDkmN
X-Proofpoint-ORIG-GUID: 9NvaT6v8IpH8PlelyP9HFOwhOZ9NDkmN
X-Authority-Analysis: v=2.4 cv=FpYF/3rq c=1 sm=1 tr=0 ts=6808be6c cx=c_pps
 a=6nUVeFXZkCqfDP2MWDHPNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=SFTpjHGecaNKiId_L58A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/04/2025 11:02, BALATON Zoltan wrote:

> Simple series doing what the subject says.
> 
> v2:
> - Added changes to qemu.nsi (Philippe)
> - Changed order of enum to keep it sorted. This changes value of
> existing define but the value is not relevant, always used by name.
> 
> BALATON Zoltan (2):
>    system/datadir: Add new type constant for DTB files
>    pc-bios: Move device tree files in their own subdir
> 
>   MAINTAINERS                                |   2 +-
>   hw/microblaze/boot.c                       |   2 +-
>   hw/ppc/ppc440_bamboo.c                     |   2 +-
>   hw/ppc/sam460ex.c                          |   2 +-
>   hw/ppc/virtex_ml507.c                      |   2 +-
>   include/qemu/datadir.h                     |  11 +++++++---
>   pc-bios/{ => dtb}/bamboo.dtb               | Bin
>   pc-bios/{ => dtb}/bamboo.dts               |   0
>   pc-bios/{ => dtb}/canyonlands.dtb          | Bin
>   pc-bios/{ => dtb}/canyonlands.dts          |   0
>   pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
>   pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
>   pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
>   pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
>   pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
>   pc-bios/meson.build                        |  23 +--------------------
>   qemu.nsi                                   |   2 +-
>   system/datadir.c                           |   5 ++++-
>   18 files changed, 42 insertions(+), 32 deletions(-)
>   rename pc-bios/{ => dtb}/bamboo.dtb (100%)
>   rename pc-bios/{ => dtb}/bamboo.dts (100%)
>   rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
>   rename pc-bios/{ => dtb}/canyonlands.dts (100%)
>   create mode 100644 pc-bios/dtb/meson.build
>   rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
>   rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
>   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
>   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)

In previous discussions we've had around what to do with pc-bios, wasn't 
the consensus that we should aim towards dividing up the directory on a 
per-target basis? I'm wondering if this is going in right direction, as 
I can certainly see that a per-target split would be more useful to 
packagers.


ATB,

Mark.


