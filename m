Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3D0C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyV1c-0001wT-NR; Mon, 24 Aug 2026 09:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyV1X-0001vS-0A; Mon, 24 Aug 2026 09:47:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyV1U-00064w-2Y; Mon, 24 Aug 2026 09:47:38 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OCwEug3092386; Mon, 24 Aug 2026 06:47:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aoO/X/LBw+mV3osLk23TVXhlgFWgm0Lx1/04XFuGf
 Mg=; b=MjUFgLDITypn1awkpYD2ir/eQIVp8ZDj3FbFhX5jYfBN556V3vcOA8b3F
 wRPHiINITfuX3IOn9h13OXR+8tUJKghh9HzEgb82mu4pCPTxCu18tT83RSvOjmM+
 MSGPcKdYSgm43thzsRh7dN2p+A1aac6jVlKz1qjvVsagULgSIoW5ug7MTTo4nucw
 RgrRcd0CSnpjLCR057EjnSXBKI/qW6AO+d8huxa0FmYutkBuVUij4mJPJnLwYUoF
 1e5FT85JaCeZMx88Spt3MvlfSaxOpugzBiZLRJ9TwBSNZcXD6Yg8wBWsSynmxS/j
 C1ECLkp+VqpAj4sIr0uY6Xh2+o4MQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020116.outbound.protection.outlook.com [52.101.85.116])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g79a6kh8d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 06:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efUq57BTnppcU8+nt14BUdbgnn6J0dOVA1/UNyGp8SzAVjYhVERma9O9YLY7A7x0ycof14N8/JkN7I5kvsDbVo+WIQCt8mfnK/w8Rm0EGFgE14jxdBK7Wb3tLNBUMN72FgH+iZ5DPQM/qYV6ju5l92lJTiQ706RvGp3kDRI8kjGh5EDQ/o74X1Ll7LzKMAm+xo659j7fa42R/lcTEffKTON9K5R//cfJWwIxUbu29AKZa64SggQzeY8lwI5BVtYBh0CUzHtfdspTBgywk05pwD7fjIqRmArqMaUBi+0qu/J2T2EQk/JrUzitQeRYQMIX6h6lGelN1eciifYoZkBLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoO/X/LBw+mV3osLk23TVXhlgFWgm0Lx1/04XFuGfMg=;
 b=NBdkvRs3vCrybfoyIGzxagih+OHLhuBtEB3fCIfIDMon12Y7C2r6rza2WYLjc+MgvNO7+3+f+2zvHOP7RU4bjJw9Y3V1C5glWRUfPNINfeS2lznMjiHrMqkbFBXBbU35KHAC/v74uhHgLA2GnmgHXOTo9UlXqCmETfVd7cvsCyM/uONE/gTfkUzx9FX9Mk8IRYvUuec2WztCpEp+2DKxnd6XynTVIBFMj8RHBLDMXPXQPTCwaVoInBgYED6X0FjOSSU/YQWX19z15Zv/3/Q5zuj9Oc2OPFcnkA8/Mkbgkxe1EEivQCECm+BIjuiVGxONoKDbhsHvFRe+iySfKIUY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoO/X/LBw+mV3osLk23TVXhlgFWgm0Lx1/04XFuGfMg=;
 b=qOCpvW05FkGn6Vxb30H9Vu5b1Zz/C1erBtlvgOMdPyyYx0Ky4iOtK8atBb1vurjJv61FgQXjV+0haTA12NV1wSK1OyFp+NN7YQ7MCj8bpUDF1jG/DM/IDreVnM7hQnVNQV9rMG5i0PwsysAiNUpK/M4ta4hJhYgGHauCpTcbzRcfya/61Erz7mTEm9qwtp+y31GJspfJztWz4iX3sJtC9WjLKPdXtTn3S3UmTJT4gnRk/JRBoIzleiXqZL7XylEl22tVJT3HEjgdISmsW0G4Rci820erQMh08pzP08y0zcxCFFasxXPATKG+7/j1bJGZigzmm/2tW2q8Pzv3XBT/Jw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9470.namprd02.prod.outlook.com (2603:10b6:930:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:47:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:47:19 +0000
Message-ID: <1fd9946e-1d2a-462a-93e3-238f2c67a1b6@nutanix.com>
Date: Mon, 24 Aug 2026 14:47:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL
 from object prop to class prop
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
 <20260821111550.276011-15-mark.caveayland@nutanix.com>
 <aoxBd0tGArc8rwdf@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aoxBd0tGArc8rwdf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 787f27c6-2175-4efe-83aa-08df01e63745
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LI1H4xDK3+u6loCPCwutuJ03r8fRV4B09IRHsJNPcyGpQVolvuJ4bbA4kYp1z1oEgRv70aOWoUHW+B3/7uG+ZbqtGwS/xmQJwkHyLq7P3CfvjJKkyUz6w9q2zaDQVlaZvm0pRrvDhB7Km2Qw2Pyo1pQlNKkRFkz7gqPtK66X3E0Im+bRK31SXAwAVYXeS8XJuXAxvgtt0FlMeaKSlFp1KCB9gTvFttZJsdbWWh1g1lv8sUACj4onvAFz+TXfREWF5BQf/ZXGAjYmuRKtqcI/RupteVJjX6lwie87oclY6Hx9ybx7kmxtd9G7Ccx8qWF3LDJGJ3krn2LIj+pQxtjMuYHo3qmpCAFK0Lv8dfeGyD5OG71/79+6R6pzA9S1/h2fRGK3yZQzKnRR0UwZLrPrInkVKdEY+HdD/QVBI3g7FdAOrckRXbZgHGkunDNkqabBcCiRFHaeU2YtvbO0mtG4OBNbl111mqK28+tMopRbCC7d9lqiMJtKZr5l5iyaK52gtdHv3h3VyUomhA846tL1dhABNgGxI6LDk8FWxmnXfpuKbJfNrqvYWjYOsIILUuTGKqcOKBCQdGj6uBYQP6k1+ghs5aWWPnLShmdvVXS3xCVgrwrt/h6w+42zFD8HKbdxNB01/6V/T9ySKSeRu3YrtrJjMjJIhOJQy1oq2d0CjAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnUxREgxdDNKS3N2R3hJeStJNDNIWmVTQS9DaGJNTWFaSXIwRTk5RFgxY2RT?=
 =?utf-8?B?WjcrbFpTWWcwR0hyZWx3SkhuZmd6TVplT3VvNDZxenNPdWkrRG1BNmFsZ2p5?=
 =?utf-8?B?ODRsQ2ZyN051UkpDaHNkdW9jaUhQaHcwKzVobEVWTDhNdm4rVWJUQ2xuNnBR?=
 =?utf-8?B?RHJCZjYvUmdLd0hZdVFUL3FDSkRHZ0FpY2pHZUFaYkwzandXRnNHREJSdGg0?=
 =?utf-8?B?bXFxVXlCWWxQODZUZ2IrRUdhN0lXNXF3WTloWWRIR3ZvNjlFVEZxZFllSGND?=
 =?utf-8?B?WEFQUy9HNUFvendDR1paUDdXMklvbTBLVDZHMnBWVWtScThwd3VTa2VRT3pP?=
 =?utf-8?B?N1V4ZFlqUHdUV09RN2pocXFHVEZPdHg3dXRqWGdZTDBzaFd2NE5Uc2tJUU1K?=
 =?utf-8?B?TFlyREFqeW9MTTBDblFVaElVS21OWlhRNVFJNisyQUtleVM4c2svdkVmVEdZ?=
 =?utf-8?B?M3NtL1Znc0V1NjhuaDgvWll6QnNUbGI3eStvMUVRakdVS2w3b2EwcGp5REg0?=
 =?utf-8?B?NGhKMXlPSGV2NkJZZkdtZytHMGNhMHh3Q29BejNhbUU3UlVZU2VZVmZkUERl?=
 =?utf-8?B?L0lKczBIU3ZqaG9teTJqaVh2Z09RYTI3RUZ0cThqejJyL2NkMG9XMVVyTHRr?=
 =?utf-8?B?ano0dkRISk9QL1N2WHUzZUxzMXI2a0JObGVuSktHb2FTSW9BUUh1bFBvU2tu?=
 =?utf-8?B?OXhmV2EydlF5Q1dqYWtDcEY2OFB0a0ZvZWFYeldHdjlrSkFzZzlMMHVhZWRC?=
 =?utf-8?B?ZnlQMGxzQVZGQi8zT2lVUldBL2JkZ2poVkZZTmN6SEozMlBrcFJ3WStGdlh2?=
 =?utf-8?B?dDVSbk5Wd1JhbUNvVWJDOEoycDRBcFc0VGdpNlA1Z3NzK1F6OHpUWlBraENw?=
 =?utf-8?B?UDBxY2ZLOU9KU1l0MVB0anRKMlVlK3BKeGVIeGRiUlJqMFRndkcvdGk2UUEx?=
 =?utf-8?B?ZGZoN2ZhR3B6dCtuTllnZ1lIZWd5WGNUUHRJOVFNMldWUy9hRlpWQVFKWk04?=
 =?utf-8?B?eDUrNS9DdG9CWnc0a1A3YW1uOWJ5c3ZDV1FCWXhKZ0p4MGpCRncveTU4V29j?=
 =?utf-8?B?WVpkdFBZdHE0SG9La3hmR2trWmlGTERmNjJTYWVhUjJQYkI0cGtUVWttbHU5?=
 =?utf-8?B?djhoLzJ2U3JITGhEUXlMa244amd1WUplQUt5NFluVlE3TktTanpGb1pVaEZV?=
 =?utf-8?B?ZDNKUFcyc1AxdUNuMmQwaG9LN09FSUJSTW1TZWZGTWgxSnFkaGd5bmQrMjUr?=
 =?utf-8?B?a2Rxd21qUE5zdkRueG1BRkllaGg3OXhOWnY5YUJNT1BFM1dBUUQ0Z2pFRTJ5?=
 =?utf-8?B?R3BaWnBQeUNvMnR3bFpkSVpOYTJ0dUpEOWRwaENNbERiMWcvc2ZCZVVBMHNq?=
 =?utf-8?B?eFZRVHJmN0NOeC9OcUhveHV4RlNZZ2lLai9tQkJscUhjTUZ0TEtSZU5HV205?=
 =?utf-8?B?d043N1hxNXE2UDgzSDluRy9mcEZJd1d1QndSa3lEU0VjN3p1OFA2bGRGZDVl?=
 =?utf-8?B?T051TURHUlNBT0ZEVFMzQ1NqRUhWYmI3eHZaUTJ2UllkdjRrQk9NZkFRSmt6?=
 =?utf-8?B?Y3c3UVRrcVNjVnE5dkpnRWhhQzRYdlc1eTBONHBteFJ3MDdHRWlUbWE1UjJK?=
 =?utf-8?B?OFJCMU8ra0E0NWlBY3M0ekJVRCtTcUM4YTFKTy9qVnl0dXR3Y2ZLY2xGblV0?=
 =?utf-8?B?dXBjbHlCcHF1blRPYWdNQml5eG93NnBscE9YTkEreUgrOXhjeForaWhCbE93?=
 =?utf-8?B?SDRHb0g0RDdGR0VBZTNXZzBobzBpWjR2SnJyM1pOaGpvNWJaWkNmOEhrS0xT?=
 =?utf-8?B?SzN0VWtDbVk1K2g4SHNjRGhGUnZWRmF4Q2tMMHNZY3UxWGVhUklJZTFJWkNR?=
 =?utf-8?B?aFpiN3RrRzlJRXUxdUVnN3RZSElISjBWSVhzU25JakRSWWs3RG02czh4TmZX?=
 =?utf-8?B?bjl1cFhsc2pEZjgranZPa0Nwd1pvME8vc3MwUVJnR1V3UXFKTEJkYS9rK1JC?=
 =?utf-8?B?bTJKTG9SeDdJcVZUd0dRRFFpaFE0WlhRN0k1TURKTEtPR3EvUzBwZEJUZUI1?=
 =?utf-8?B?dVhucGFTNS9Ga3VQT1ZrSGloR0doaXZrSWEvUlBtc1dOcXpZRFRETkNiNzY2?=
 =?utf-8?B?eXhVNnpBMC9Jb3ZGS2dMUnhZY2RRaEtHcUphUHZ2TWdJZ1JQMzBhZG1md2hI?=
 =?utf-8?B?aFRFdzRXZDJFcW10RjZpb1ZnQm44MktrbW5oUFVlbjhBTmdiR2JycE9FbEtV?=
 =?utf-8?B?N2NXUTBtNStHaEJsUWZnbCsyUEVSK3dZL0RUTEZCYzBwMysreXdjV204SWpE?=
 =?utf-8?B?Z2pQUXFoRXI1SGRwT0g2N3B4WGZwZERDTm5zMzFtN2I3bG5YbHZiZTN4WWEy?=
 =?utf-8?Q?FwR7ualOAhmxSKk4=3D?=
X-Exchange-RoutingPolicyChecked: OvXY+UeQUK6A/WXvMh1yOMT7tqjIFY6ZZMKGPe5tfDhI9NT8T0taUmbaNj0H62Bo+iILBeqzoWNnO936dkR3BMc6aYcX4pcBp7F3s6/1aM0n9VJrBJlZfOPewqidGmgTWhFd1rqKY8nbdub9926WodkiOaDH7x1RBxNqYS753iZuQgYbqzSCluDnefutw1nUIo7c4/zSgVPTjK8ni2cBm3K3/P1rm7llUaWm67W99T+ekRd73CLHRgS2Wq/STBkhW8pM2XHr+Vh67XKCgTgGFhDVdL3ORjk4HJpgzuacEKfYFTSXiOTZ+TzWspnf7xIoWRQSfxUYbQJNYCNBnjh5rg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787f27c6-2175-4efe-83aa-08df01e63745
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:47:19.2044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZovk9o4QpR7lpHYg27106WqT1M4XlQym6vk2skSGxVEs6fJuQFzgMO0paXLjIHEp6+DFN7K046lNJXlk1GUgPMcV8k1ey+BoxRZr8ZWvl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9470
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNiBTYWx0ZWRfX4Jxa3yhdA6pz
 NCKsNfGqpsgH3Guj/hdWHNIUceEl3miAXa7fXIqiTMG0l4qwAKj0sal0EuLekYH98CfG3Y/c7ix
 UwrwK+aZbHA98x4uMKDNuQfc9eko98T7gn+rlw4QWMzRXMJZ7VSIU1Sl16iyYGN5O4con7w+gyD
 aPFCf/TIk2mOSNyU5raaPt0b/V8iKqEKEL4xrGB0IXLFLl2u4CQOO1vfD5oebPOjHMk0h55l6id
 fecsNbz9YZuwuP2j4N6dddO6oHGdnflQD/WLUHI96ymGqInenSrI0az24cBwBGgAdnZItC8aXCx
 Tv9MgTg8HAu2GOL2bcjgOWa6nmtuz7wdYNKNwvw9iGVlXVt9rF0ifyJjdOno/J1lrnJ3wmOa+6y
 RuF07yjD+GyEKJ8TstTqThTtxur76j1Rd/4qEPY52Nc75D0XR42SeMO0QKifygeRDK3YVeHPtIG
 CXnE/8+MT6n4hc5PhJQ==
X-Proofpoint-ORIG-GUID: VQUh62Wu4WpPpqjUKnDJE59shop1Yucj
X-Authority-Analysis: v=2.4 cv=eLsjSnp1 c=1 sm=1 tr=0 ts=6a8c4b69 cx=c_pps
 a=/2nJIMlxEBAz38jMsEt+9g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=Y5V25eB0uHKgSxSIyT4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VQUh62Wu4WpPpqjUKnDJE59shop1Yucj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNiBTYWx0ZWRfX4E6YQQKoTuas
 olJD1zpMui5a/sXgr5VeA9K3+AdkHQ6xOII8phMM8/QOlWiCG21bR9/NXWfywLWpnuiKT1z74w4
 iy1xM/dOfr8KBifjFnwVrzb5++SDtx0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On 24/08/2026 14:04, Daniel P. Berrangé wrote:

> On Fri, Aug 21, 2026 at 12:14:26PM +0100, Mark Cave-Ayland wrote:
>> Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update all
>> callers accordingly.
>>
>> Since the existing logic checks for the existence of the ACPI_PCIHP_PROP_BSEL
>> property to enable the relevant ACPI changes, set the type of the underlying
>> variable to uint32_t with a default value of UINT32_MAX indicating that the
>> property has not been set.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   include/hw/pci/pci_bus.h |  2 ++
>>   hw/acpi/pci-bridge.c     |  9 ++++++++-
>>   hw/acpi/pcihp.c          | 30 ++++++++++++++----------------
>>   hw/arm/virt-acpi-build.c |  7 ++++++-
>>   hw/i386/acpi-build.c     |  7 ++++++-
>>   hw/pci/pci.c             |  7 +++++++
>>   6 files changed, 43 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
>> index c738446788..7ecb23d13c 100644
>> --- a/include/hw/pci/pci_bus.h
>> +++ b/include/hw/pci/pci_bus.h
>> @@ -56,6 +56,8 @@ struct PCIBus {
>>       int *irq_count;
>>   
>>       Notifier machine_done;
>> +
>> +    uint32_t acpi_pcihp_bsel_val;
>>   };
>>   
>>   static inline bool pci_bus_is_cxl(PCIBus *bus)
>> diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
>> index 394a919479..1bfc5431f2 100644
>> --- a/hw/acpi/pci-bridge.c
>> +++ b/hw/acpi/pci-bridge.c
>> @@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
>>   
>>       if (!DEVICE(br)->hotplugged) {
>>           PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
>> +        Error *local_err = NULL;
>> +        uint32_t bsel;
>>   
>>           build_append_pci_bus_devices(scope, sec_bus);
>>   
>> @@ -30,9 +32,14 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
>>            * generate hotplug slots descriptors if
>>            * bridge has ACPI PCI hotplug attached,
>>            */
>> -        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
>> +        bsel = object_property_get_uint(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL,
>> +                                        &local_err);
>> +
>> +        if (local_err == NULL && bsel != UINT32_MAX) {
>>               build_append_pcihp_slots(scope, sec_bus);
>>           }
>> +
>> +        error_free(local_err);
> 
> IIUC, in this new approach the property should always exist and so I'd
> expect object_property_get_uint to always succeed.
> 
> IOW, is something stopping us using &error_abort and merely checking
> 
>    if (bsel != UINT32_MAX)
> 
> ?

I think that would work, although in the back of my mind I have a memory 
that we should try avoiding error_abort where at all possible.

Markus, any thoughts/comments on error_abort usage?

>>       }
>>   }
>>   
>> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>> index a91f523c93..b26ddf0a26 100644
>> --- a/hw/acpi/pcihp.c
>> +++ b/hw/acpi/pcihp.c
>> @@ -58,7 +58,7 @@ typedef struct AcpiPciHpFind {
>>   static int acpi_pcihp_get_bsel(PCIBus *bus)
>>   {
>>       Error *local_err = NULL;
>> -    uint64_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
>> +    uint32_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
>>                                                &local_err);
>>   
>>       if (local_err || bsel >= ACPI_PCIHP_MAX_HOTPLUG_BUS) {
>> @@ -78,18 +78,14 @@ typedef struct {
>>   static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>>   {
>>       BSELInfo *info = opaque;
>> -    unsigned *bus_bsel;
>>       DeviceState *br = bus->qbus.parent;
>>       bool is_bridge = IS_PCI_BRIDGE(br);
>>   
>>       /* hotplugged bridges can't be described in ACPI ignore them */
>>       if (qbus_is_hotpluggable(BUS(bus))) {
>>           if (!is_bridge || (!br->hotplugged && info->has_bridge_hotplug)) {
>> -            bus_bsel = g_malloc(sizeof *bus_bsel);
>> -
>> -            *bus_bsel = info->bsel_alloc++;
>> -            object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
>> -                                           bus_bsel, OBJ_PROP_FLAG_READ);
>> +            object_property_set_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
>> +                                     info->bsel_alloc++, NULL);
>>           }
>>       }
>>   
>> @@ -730,14 +726,16 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
>>       /* If bus supports hotplug select it and notify about local events */
>>       bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
>>       if (bsel) {
>> -        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>> -
>> -        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
>> -        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
>> -                                     aml_int(1))); /* Device Check */
>> -        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
>> -                                     aml_int(3))); /* Eject Request */
>> -        nr_notifiers++;
>> +        uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>> +
>> +        if (bsel_val != UINT32_MAX) {
>> +            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
>> +            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
>> +                                         aml_int(1))); /* Device Check */
>> +            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
>> +                                         aml_int(3))); /* Eject Request */
>> +            nr_notifiers++;
>> +        }
>>       }
>>   
>>       /* Notify about child bus events in any case */
>> @@ -848,7 +846,7 @@ void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
>>       Aml *dev, *notify_method = NULL, *method;
>>       QObject *bsel = object_property_get_qobject(OBJECT(bus),
>>                           ACPI_PCIHP_PROP_BSEL, NULL);
>> -    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>> +    uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>>       qobject_unref(bsel);
>>   
>>       aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index f6386088b6..7ba7b38773 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -1207,6 +1207,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>       AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
>>                           .oem_table_id = vms->oem_table_id };
>>       Aml *pci0_scope;
>> +    Error *local_err = NULL;
>> +    uint32_t bsel;
>>   
>>       acpi_table_begin(&table, table_data);
>>       dsdt = init_aml_allocator();
>> @@ -1269,9 +1271,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>   
>>       aml_append(pci0_scope, build_pci_bridge_edsm());
>>       build_append_pci_bus_devices(pci0_scope, vms->bus);
>> -    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
>> +    bsel = object_property_get_uint(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL,
>> +                                    &local_err);
>> +    if (local_err == NULL && bsel != UINT32_MAX) {
>>           build_append_pcihp_slots(pci0_scope, vms->bus);
>>       }
>> +    error_free(local_err);
>>   
>>       if (vms->acpi_dev) {
>>           bool acpi_pcihp;
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 8837b69687..cc0b6e5633 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1198,15 +1198,20 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>       sb_scope = aml_scope("\\_SB");
>>       {
>>           Object *pci_host = acpi_get_i386_pci_host();
>> +        Error *local_err = NULL;
>> +        uint32_t bsel;
>>   
>>           if (pci_host) {
>>               PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
>>               Aml *ascope = aml_scope("PCI0");
>>               /* Scan all PCI buses. Generate tables to support hotplug. */
>>               build_append_pci_bus_devices(ascope, pbus);
>> -            if (object_property_find(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL)) {
>> +            bsel = object_property_get_uint(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL,
>> +                                            &local_err);
>> +            if (local_err == NULL && bsel != UINT32_MAX) {
>>                   build_append_pcihp_slots(ascope, pbus);
>>               }
>> +            error_free(local_err);
>>               aml_append(sb_scope, ascope);
>>           }
>>       }
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index d3191609e2..e8e8a3b767 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -25,6 +25,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/datadir.h"
>>   #include "qemu/units.h"
>> +#include "hw/acpi/pcihp.h"
>>   #include "hw/core/irq.h"
>>   #include "hw/pci/pci.h"
>>   #include "hw/pci/pci_bridge.h"
>> @@ -187,6 +188,8 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
>>       bus->machine_done.notify = pcibus_machine_done;
>>       qemu_add_machine_init_done_notifier(&bus->machine_done);
>>   
>> +    bus->acpi_pcihp_bsel_val = UINT32_MAX;
>> +
>>       vmstate_register_any(NULL, &vmstate_pcibus, bus);
>>   }
>>   
>> @@ -302,6 +305,10 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
>>       pbc->numa_node = pcibus_numa_node;
>>   
>>       fwgc->get_data = pci_bus_fw_cfg_gen_data;
>> +
>> +    object_class_property_add_uint32_ptr(klass, ACPI_PCIHP_PROP_BSEL,
>> +                                         offsetof(PCIBus, acpi_pcihp_bsel_val),
>> +                                         OBJ_PROP_FLAG_READWRITE);
>>   }
>>   
>>   static const TypeInfo pci_bus_info = {
>> -- 
>> 2.43.0

ATB,

Mark.


