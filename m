Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2244DCEF14B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7Ex-000185-3r; Tue, 08 Oct 2024 06:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1sy7Eu-00017n-Oy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:14:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1sy7Et-00053D-3W
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:14:48 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4989F0X8018521;
 Tue, 8 Oct 2024 03:14:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=OE2POxYcUHdFY
 tb8QGWaIquHA4oigRBEk1haw0YW4U0=; b=m+ogXvY9Mr4mcDNOxlSByzMEQg0I4
 wF9NXKAkOSh/FiLBbCDJ3YVnI2MTXurK99XPLIaoHS4utX73dHHppSrlbhHJk3qh
 vk64b3qMKNv+WpY9DWATc5UgGN8ivkMQI8UeRTl9hA5sG7uHVs+sInBrdVtGprsu
 yXtUYKmUQiYuw05i8eQbknr++iNscG1RAF5jEQQRYcpX2cls9tPIYNHVpS4JusfP
 +5QEFgmSn4NrrORIKNB5+Xe1bdfqIYn74//byBIXUfz61EKF+K1N2TwXS5rGdI68
 4xQpPIrbiGhRB539GKQ+ydjcMws0mfzJhyez28aLDtBC/fPPm+6Ha1wyA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 423500wv2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 03:14:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeT9Lni5XNotBAae8jJO/Jei7rUxIKaJw/UAIR7ctuFPMJc54U2wddHHcgL7NXSwIdKpeJQ1XlXcpq6oHdNEu+TIJykdYkdLCndnAVXaulsNcL7G+2Crt0/UUmX5vwwiVjhvj5NLY74PnG/RPm/OIPMgM11v6t2TqKN9vZfu4tct76H+69L+OFNKlPKcibkVM3an+1hejYJd9mvrF/a+Seq2+/vt2etT3xDVlOHYAC4oH2Al3yJomce+lMRbGtaVFwk7aW6FiNca/HpoumcodgIzsUPYEGQxyi+3988buIFTKAqSMmR2myGTRlgV2m5PPlQm++RqxiwpXnvygREYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE2POxYcUHdFYtb8QGWaIquHA4oigRBEk1haw0YW4U0=;
 b=g/WWJmWUj6V8/4haMGLhky1FRs4amcRMev+VNzEHJuQvCcIw24vleb5ldkEVwPHSPqNwM3GxD21o5y/m/oQzCV/MsN0KBDJpC/PIneuPXF8mFrqYpoMAnlmDkPhsR6JbQFvJh4rRwv5lfsD5mkS94vaYtOqDxmvsrCW9OmQccw5FQO72clJKYsk9aYctN8Y1qNaDGKG+EnK1WrkGqhBelvrenbiPU8d6McmfkktZGwBrA/H8i31sX7ZKHEDDNueaw1AD27LUh79iGPCA9pwmrcr4ERVIz0CtK1+coonzif0zVs5jqaAJDtg79Y5ooz80wfKmsW6cyrf586xWHVQTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE2POxYcUHdFYtb8QGWaIquHA4oigRBEk1haw0YW4U0=;
 b=P37YoV4zAYRgZnvkEbPk6ZE3swLRhBM93TWkXt6I2h4gA7R+F3sJ/yMYxDexNgbCsKtYR4XWdL6r9WJV34kY876L+sw8aCmJ+UkUBQR8QfX28sKlOH0uHFX2GnLjPSxJePpd3KIBUcTmJLBaKVnqCFIhua2LcO65rqGNGVctDlYGE+/xhylIHUe1jcpPxKOnxWZ8W3qRqh/FRjKn9g94VfRz96d3CU1+rHTLsaJAEOoMoMVVHivtSbjue0rnor/doKZBgfWawadlaqIerggbS2BCbrQifMR8c9ckrqEeYEVYMtoxrBDOqwjVaRKNYuJk2/0nn9FxzW308eN/A7qfyg==
Received: from MWHPR0201MB3594.namprd02.prod.outlook.com
 (2603:10b6:301:7b::33) by CY5PR02MB8919.namprd02.prod.outlook.com
 (2603:10b6:930:39::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 10:14:39 +0000
Received: from MWHPR0201MB3594.namprd02.prod.outlook.com
 ([fe80::5d3a:7078:5384:8916]) by MWHPR0201MB3594.namprd02.prod.outlook.com
 ([fe80::5d3a:7078:5384:8916%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 10:14:38 +0000
Message-ID: <9d0e5db9-aaf9-4536-ad9f-2f5c86523627@nutanix.com>
Date: Tue, 8 Oct 2024 15:44:33 +0530
User-Agent: Mozilla Thunderbird
From: Tejus GK <tejus.gk@nutanix.com>
Subject: pcie-root-port limits for q35?
To: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
Content-Language: en-US
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To MWHPR0201MB3594.namprd02.prod.outlook.com
 (2603:10b6:301:7b::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3594:EE_|CY5PR02MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bcc129-6340-4eee-4154-08dce7820459
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RytsQTJKMU5iaEdWME9jTXI0blFBVjdSc2hNQWtnbWlDN0RRMTUxc3B5TnJQ?=
 =?utf-8?B?aFh6d0dPa01CYUR3eWRDdGhWTDZEYnJJdWxCbktQdHVUYzJtd2RRRG01RmJu?=
 =?utf-8?B?dkhtNTJGRXNNS3FhNTNUaUlFYnpaS1dFT3JrSHZTU0pYWEZmdEtubXd0SHNF?=
 =?utf-8?B?c05pWGU0TEQ0SUMvTGNydEIxYlY0T0Jyem5tNXBiMHl5UjVkUEkzeTVtL2Jn?=
 =?utf-8?B?MTQwYzlpWVVldU5EYi9IK280WEpFeHhQb3orZVFrZytCak5ic0tZMHp2QlRW?=
 =?utf-8?B?Ylo5akJ0L2Zxdkl5NUE3MzFCU2N4dkxzbGV1eUh1M25haGRoaWhHREVOYUdS?=
 =?utf-8?B?eTlqY0Njc0JybEt1NzNVdEtTenFiUlJaRGZYNXBKR0JWSGVjdk5DWFdQZjl1?=
 =?utf-8?B?K1VxaDlzUDJRRnordDZJK1hQNGR4OVkvTXY4UmsrcmcwZ0ZLQjFJVTFiN01S?=
 =?utf-8?B?ZFh3cTlVTi9PbklGMGZTQVh0Vkk3OHhVdGpoYUVBcDZieVdtNnp6V3BXYVJk?=
 =?utf-8?B?eXVsYUVENDVpR0ltdHRvQ2Z2a3B1MjN6K3JhZ2dzZVJLS2VOVUErMG9oaitW?=
 =?utf-8?B?ZWdHaDNla0dwT2Z0bkJ1TmdUVUZRdTFtdXQva3ZWWG5IT1N6VkwvTG5DWFR1?=
 =?utf-8?B?RGlBUkFnSlhGZUxDanE2YVZrc3l1aEtPdldOaWN0dVlGWUYxUkY5S0lLR3pa?=
 =?utf-8?B?RVdScHlOSDlMVFMvWEh4bmp2N3NMMkJwVDZBYjd2ZEdrQVQxdGJWYW5JdTkw?=
 =?utf-8?B?Y3oydFJ6TXFPRnBmUkhmRVo3RFp0QVlIREx5YlJpNDByNkU4U1pBdkxpM2J1?=
 =?utf-8?B?UmZ0Y2FDSitVNHVUOVE1eVlXSVNqQ29LZUNWU0ovUG5ueUU5WFVBLzVKblNs?=
 =?utf-8?B?THR6VFB0ZmdBV0ZQMlprNDdGSWltaFlJQ3hXR3lEc3JzRDNSSTUrOWFpOE56?=
 =?utf-8?B?Z0RZQ3NHWjFBOE9WN2drSkFUVDcyVjFWMHpsa0VGaXA5VTNPSnRnVUV4NWhr?=
 =?utf-8?B?anBVSFZhMzdKNldpSGJZV01uL0UwcHRqdTNVdGNQZ2N0VUVGWWQvQlZ6RVlZ?=
 =?utf-8?B?R2NWb0pPNERWekVGZk56S2t6VTd1cHpYcU45SFlFR3JvU2pCL094clVDZTM4?=
 =?utf-8?B?UHR3azdsZFNmNGlnejcvcUFjbEFyY0ZDc1dLc1NXOUpGdmF0LzZ4c3QvbFhj?=
 =?utf-8?B?LytJcVh6SmhYVkJFM2NlbDlIYXBHdjZOVlRsSlh6dGRuZVBlNk1hc2xnY1dV?=
 =?utf-8?B?eEtmWW5xUW5UaU1pNWJXTzNwbXFzNlhSU042YjNpbFJETHpyV3UwaER4cTA4?=
 =?utf-8?B?c0p4VW9NR3U5TzJicXB4UnhPM05WKytyeTUvaU1jOVdxNHpUNlY0UVNxQisw?=
 =?utf-8?B?R09TMjhJakR2b0YxanFNWkd3MG5Mc2gxdTBUT0JlcUVsZU5HZDFDbnZvSlBU?=
 =?utf-8?B?YWY2M1ljNkZaZzFBUTFyelZKWlhZcnVIZUxwenpHQUxsYnNkY0ZmWllXVU1h?=
 =?utf-8?B?b2t4YXphWmx2bjM4dnRpK01pUUxnMlpCWkdLS2VOUy9mdjlTMXNuTDRicklt?=
 =?utf-8?B?TS9TRHdHa3FjYjQrMjdtN1BKamx1aW8vQldHREZoeFRBKzRwdm5NSHdHUzJL?=
 =?utf-8?B?M2tXUkhLZEQ4cjFITEJmUDB3cnZ6NFplVjFMQjIrcUxXQ0Z2MTdxcWNIOXlw?=
 =?utf-8?B?RGNqMEZqZWFWYzN0YkFMM3gyNXIraWJwTDEvMi82NG1Tclh4YWwzVVBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3594.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MndJZTdhd1B0UlhyNFM1emNiemVIRWNVYkRxcEtxL2x4VjNlanlFWnl3VWJO?=
 =?utf-8?B?WlA4aVlkMElrVG9sdEVtVVo2cnJCaTBFd05ROHdPc2tVTjRrVk5MQ293VE92?=
 =?utf-8?B?SGxXV2YyMGx2VjNDYlRLRWdNU2J4dDBxL0JJeFVGYkxIK05OaW0vbFNtaEt4?=
 =?utf-8?B?V0s3bVZET3h6SnBqbVRTRkdKejZWSkk3L0Y5VWczOThWSDdLUDVJUDc1K2hR?=
 =?utf-8?B?VHdqRm9aWTh5SmNkVmhuYnZSVXY2TndGMVdmWjNTcGRJaDI4SC80VXI1UHdj?=
 =?utf-8?B?b3UvcnNFcm9XRllsVjBDaXBrTitnQUlsRm9UTlh3ZENkOEdLenRFWkZISzhP?=
 =?utf-8?B?NlZlZExJVmY5K3pSN24wN1BURHpFdkdRN2I0QUMxSHNBWEVFN3JXeGFYTFBq?=
 =?utf-8?B?QWRIZTBKeTJXZisrL243SlVSRy9RZ09ocTUwUUUxRmVpVDRnYzgyRGhEZkNB?=
 =?utf-8?B?NG1lakY5Z3dBQjJ6ZW5reU1GTUhaS2J2bk9rUHJVY3pYaFJUczExRUZYWVY5?=
 =?utf-8?B?VUhNdUsvOW9JMUJyUyt5N1dKclVxYVJJM0VmcGtPZFVnWkFZNElDYXlYSkhX?=
 =?utf-8?B?WGpIUHFyTGtvckVweGFVUFFyWFBma2owU1hXWXJIU0pPbnZOMzlMNDFDWkcw?=
 =?utf-8?B?R0ZYVldCUFVSeFkxbnBDbTdZcDNmMWpNcWQvdTNXcDBaQVdLWHYzWU1MMkt3?=
 =?utf-8?B?bXBPZlpxVUVKdmp6blN6TzM5bTZrdXB3ZjdXSkE4L21XZ3BRdFpBOUNUZ2NC?=
 =?utf-8?B?eGk1NWh6ckcyZzJKU1Z6Q1BveHVXQ1FWbXhRY0JsY09LdS9BQTdPY21RVjZS?=
 =?utf-8?B?VDZnQ0lHakV5cjh2c2ZFNnBvSkhsVk5pbytsRTlxSkxrZ0paNlFkNE80NUR1?=
 =?utf-8?B?TXdqQTZ4ZjI1NS8zNXdnS2pxNkhIeGhMNGkvYkVaT2U3NzlMT1pkaFNxbWJJ?=
 =?utf-8?B?K0Q1Mld1WXZxYnI3NVh1WUNFSTYxa1RqM1FCTGJ0aGhGK2NKZTl5ZThmZ2xu?=
 =?utf-8?B?eDRXTVloQlM2bm85Mk9McHhweHExUzVQdTEzQnh0K25mcndHUmJUMGxrUlhT?=
 =?utf-8?B?Q1JWUjMrSnFDRkxmTHQ4U1dMMHl1bHd0MVp0aXdtMjB6eE1KYmt6bUZXcnhB?=
 =?utf-8?B?VkxUN09WaUlVNEpBZkZmRDk4TXVIeUR0eFNoOTJjYTk4ZHFPRTA4T1J5N1hl?=
 =?utf-8?B?U3pGOGROTHp0ejFmb0JoSHZiM2htdVZDbXo1cWxpekNad0pKeDB4anhqcWhH?=
 =?utf-8?B?aVVabjRLN3I3cUxYdnVkOVNVRGZpbjZ0aVhYendDZHI1NW16QzdaOHlFZXU1?=
 =?utf-8?B?Slh5dDFVaW94ZlFoQXhHT2NtaHBZWU9HWE5WOTJNR3RVbm5lTEU2K1ZXRXNR?=
 =?utf-8?B?dVFFcXd1L093MzFaZmJyKzRQSkxBZG5jdE5VRDJvbmc3YnFENHBzdjhERnRU?=
 =?utf-8?B?UVp6WkhtMDhyNHhTTTY2S2FydVRkY3JVUnFocCtBanFWY3NSTy9ONk91Wndw?=
 =?utf-8?B?dTY3ZHRDaGE3Q0Jqd1Y5Y0s1bWhXNGZoVkJDUUw0QkpVdzE3Q0c0d1ozNkZ0?=
 =?utf-8?B?aVJVV3dKWXhUNGdmZWtBOG0wQzBLQitqMnVsRFVGLzEwQStza0Rwd3kzMXdw?=
 =?utf-8?B?YlhrMmhURGdRTzlPd2FIL0dtelloUVUwd0tnQ043Q2d0a0NTRlUrVFlBbEQ2?=
 =?utf-8?B?YXV0S2NzR0Jncm4zNDk1QllEZGNLdnoxbC95Tjg0SFg3WjdLWUhMdzgvZVdP?=
 =?utf-8?B?d3FzZ0RjNER1WWlHU3dUaE5hYWV3SUI2blQyUUdnR1ZvOFhhNE9LNm5FVUdp?=
 =?utf-8?B?dU9aZlo0TXhkUzNiNG5qTE1Xbm5oQVE1Z3Iwbk9ZUUZSQktsSTNnYVZRYldW?=
 =?utf-8?B?K2h1T0x3bzBreDAzNVM4eFpIclE0T0lIYURmRlEyVTB4UmY4WUN3ay9CdlVy?=
 =?utf-8?B?dEtockZ6SU1JbENvcXNBMDNjdDVxK0VkYlZsRXZrUW1BK2owNUFzemJtbElE?=
 =?utf-8?B?T2xkME9LME5RM2EwbUJRVWRzZnNwMEVSR0trazFydUpmeUFaYjJPVi84Ymky?=
 =?utf-8?B?M0NFMFdRQUMrcnZITFBQUWFoQm94SWo2dnlHRW92eWJhUnozNW9Yb0JqR0lI?=
 =?utf-8?Q?eyC9kYklMuyFVgYkw6y6l6d78?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bcc129-6340-4eee-4154-08dce7820459
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0201MB3594.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:14:38.7898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXgtqCghlcmKrqTV09mGplDwm7zFxmTt3dRQFFn1bBLyNquAXNqrllOA5WKnClDmTtjq33FkPLv4UFyqM6e4LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8919
X-Proofpoint-GUID: r8aBxixxCc6aCkmdlsJECG2igYw5aMkT
X-Authority-Analysis: v=2.4 cv=WJotXWsR c=1 sm=1 tr=0 ts=67050612 cx=c_pps
 a=+1/HLBYLL4tv2yjlBWnClw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=VleI90h4E-16oJAT8FsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r8aBxixxCc6aCkmdlsJECG2igYw5aMkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_09,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

Hi, recently I was trying to play with the PCIe limits on the q35 
machine type. I see that docs/pcie.txt mentions:

> The IO space is very limited, to 65536 byte-wide IO ports, and may
> even be fragmented by fixed IO ports owned by platform devices
> resulting in at most 10 PCI Express Root Ports or PCI Express
> Downstream Ports per system if devices with IO BARs are used in the
> PCI Express hierarchy

But in my own experimental setup, I was able to successfully create and 
power on a VM with 232 pcie-root-ports, with each root port hosting a 
virtio-net device on it. The root ports, and the network devices end up 
appearing inside the VM's PCI enumeration as well. So I'm left wondering 
where this limit exactly come from? And I'm not sure if I am missing 
something here, since I'm able to go way above the limit mentioned above.


regards,
tejus

