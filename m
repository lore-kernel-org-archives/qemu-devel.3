Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7DCC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbCD-00011d-QX; Thu, 27 Aug 2026 10:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbCB-0000sP-G6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:35:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbC9-0002FY-DF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:35:11 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE8PA54182826
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:35:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sgTeCDT72iYxxEg44t/G3ZDtboB7Dy5n9NMKG1p8B
 fY=; b=B2m16SiXF+Zf0YEVvHf1sBAotA0K/ICN8uKPnikIhNMGf0VYVVMeExcxh
 iqWLCamvIuZxQVwxjo4xLFOHX+XydnWpa/fsI6WkQPrXirP/QgbZl4uqOa3Cr7rl
 N+2yhsRWij46wsO05OwRRNVzIAgILxB7Xr/ivg7RUYmmWgWA/1JaSxzJh71m2I3a
 x4zaSwshBZag64oPolTpDcTD86mAzchYhNS9wC370AGo91tCEvWayPsTY8fFFF2+
 UzNmhdmIuoEl2X0alkFMrHc8a8Yz+O+UbsGdGLMCPMOBLpuZAQIbzIKXjMVP0mMH
 uRBu0la/0uvorPPN+uzsLwlT3GHXg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021098.outbound.protection.outlook.com [52.101.52.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gafss12b1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bti075sj/LnHY3N+6fwxG79lQuhpfjGZePSZJsg24+/JXmvp4VmqoIqvYf8gj9BhpDlzhRo31YD4p6Ekp7m3GdXvBWhvZUstlRUPJKkA2yTwrgqXxCZcKlffPWPUOCtLjQ1oUIAY2t9pSJg4Z8Qcz61PXYEr2HD5XSXr1JjXL8D5zCQir9MB4G0KaA9hzy3ej4q2yNZh5w6ckAXHzI5t1MeIK18sGjl3AakgH00l2Gcue7s5fXwLpK6C9Eqv6aVTAALLg2Zm8k1T+DuZ+W1ocXqAfWkGnmbs99NyV/8DY9vsZZQUNPlUaXHWyCfdZH95ib3ytWrM81hBpm1AU06t2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgTeCDT72iYxxEg44t/G3ZDtboB7Dy5n9NMKG1p8BfY=;
 b=gaNNeFJiqi9oWP197yPJ6o6Bt0STzDNjxSyHMl0HN4pImN7H66wp+GoEK4GlYkhqd/YIUjyrHv381lZcuFVlggkD/UREkgWsvwrIEyO0FMAq6Cd18xp0otk5N4Ri7lyQzAgT/cR6ignFq1G+nA7U8dQ1Yg+QFDDFLFBwYkMKUjMkxIEtb5sT6q1OttOgNSXS9CDhNihaDYZzcp13v9+2cJjiwbaA3YCl/olAmJsF+pyCsNgnWoEBtqyZsPnCSxiMx35hG7jcW3PMlsAoaP0Vk6ZgGsuVbJKjLWp0NaYd1ZWWrD3WtiHDlDOiGeKKhEDCTqBzhBEQfs+2yYYFYekvqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgTeCDT72iYxxEg44t/G3ZDtboB7Dy5n9NMKG1p8BfY=;
 b=nNWU1ZYI80lOYIYmGA6sCvSt59cm6VqOjykqUvis0pge62xA9HCUJ/wJxYt0qDuAt1QeUjXj2DI1CYTz0caefu97/QnQBcXDayQ8SeDL/4sLtJl30HlyfJWwkAYx5iBUNhg00/vxzvBMVH+TS9zZQ1nmEcEWcYhivdJjbalRo6acgUblQdE+vVrwnHZQMKwn5AJdMYqwVXjODtEmk7wLwTarmikLSKT3Y1/akvUJ7uyfdVAgC0YMq8RB/V5Mmn14dbqC8k2od7XF0FBiaQTy6S6oje7WbMB3h7qwLYrrsxUwPP2oG3Ihw7EV5YQuxNdfSL3fWPVZOGSu/nom6Sm5NQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9251.namprd02.prod.outlook.com (2603:10b6:930:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 14:35:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:35:03 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE to a
 class prop
Date: Thu, 27 Aug 2026 15:33:37 +0100
Message-ID: <20260827143404.1393166-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0153.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: b761f01f-06bd-4c84-fc2f-08df044861cb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lQGspYTOT5K/b5xLBri8YOe0UmAsCP2oyfTf05DDX4vHZ8ihb0nTwFYyp27G19VhHjOrLFa53pVqPt7kTYVtjrgTYq3pc0ffWnCpoLtT4ouYBdB+dz29C8X2P+F5xoY827B+R9FGQ17fddEd+n12APLY/s/fvB46s+PcpoODoxl40vk0seKnlg9MvNpGjxJBqu+KqpHYhCXgGU5hAtuaff3mPAD3uAD3dUx30J61TkQaR96pGKxAd2bLXcMHgwe/SA7v/TJAjkqyqxizfbJogbx0v4EJ8t3S5iZro2P9pWoL/b5epEXRPQ14NUUY30s3ynxO63QkpYUBAKEerVIMR09P+WadTf8c4e+fKqqVkESyaK5fEjAZ1xuKBKQer0ryfWDcpC7gzFf/enbLvI4OMG0FrxfmnuxLIGTfxsNepLg4HnTTF7slY6Jc3V36ZrTQiIkCe4YisMelJxEE2I1/KUqX3TYwq5Y448UXXmDjYnNSnT7z4HZlprasD+e6nSup8NQ+hZOpArYaNhhA8xGXxY9p4d0A1Ow+Fj5vG0W4rznLFCNPuLH0ShJ8CGPJPobGsqH+xtv8jtbm39nymIxy8+KzmJZYciYz+QHjbCeXVtHk+QB/Uoj8bgypEC5YmZFMU6QukC/op6SGhgmNwigm8oAGYSd7UYtmXxl3OJ4gP/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytlZ3kvZzJGM3g5Z1U2cnNsK0lOOGIxQ2pTNVpocnpqQXlZUkpYdmFyakE4?=
 =?utf-8?B?ckprdE1HeUdFdFhWRy92b1JacFViR21WY0lHa21oTHo4RVFkek1KRXhUUG04?=
 =?utf-8?B?ZkNCd2k1SnBmMXczUjBzdXZ5TlJ2bGU1OVEzMWVEbitsbE54akYyaUFObHdC?=
 =?utf-8?B?b3JWMFcyWDAxZzhTUjBYbzl1NHNoQ1JKMEJLdTBjYVJJMFFHVklKRjNBS1Js?=
 =?utf-8?B?ZVJTTEVZdjhhb2l4OFRIMDhveGZGbjVaS0tIQThYSXdaN1R1eDhLOFc2OUw5?=
 =?utf-8?B?ckZ0b2llWmd6Z1Q5eENaeWxkODBXTnhrOGxwNWRPSmJMcGt0cnpzOVVDV1hm?=
 =?utf-8?B?OFpUY0JLSVhSTnVldGJ4WE03RXVTQncvdStVOFF5dDJiMTBlcisxNU4xM0lM?=
 =?utf-8?B?YjJZVUZwSWhZdHNzdzJkaVdQL0J5MzRoa2NKWFY1RnE5Zk5lOVR1Y2RhYnBW?=
 =?utf-8?B?YW1MRTB5cEgwS2JXTEFYcWt2eVVpOEYyZU00R3Vrek1IZVVEUnZMclNPTU1T?=
 =?utf-8?B?bVJMNzYxdmIwNDF1WDRXLzg1eE5rWEZvU3NYN1k1R0ZBOFU4WXlIUytZR0gy?=
 =?utf-8?B?TlI5ZkxOMER3aDFHS1Y5YWgzL1o3NkY3UG5yc0J1a0NNblpUbndxMC9BOWEy?=
 =?utf-8?B?MFN0VjA5VjhmZ3NtS3VkQXRvc1FQWXEvcEIyRGlDVkFWNHo3ODlMajV0OFBl?=
 =?utf-8?B?V1JnaUx4UTd6TU9WMXRWOTY5MHB6Vm5Jd2ZzZXBkdWFRZjJhcUFiTVlNTDlH?=
 =?utf-8?B?KzZjTGpNU3UwRGdnVnk0SnZ0TVZPaU5lM21vVXBUd084aTlZOWZoNkdtWU8y?=
 =?utf-8?B?YytHaUhPNkV6S1VTUmpnK3BkZm02cTIxR29GcngvZjhQZkxsSUJzcUR6OW1r?=
 =?utf-8?B?TXVzVzd3VnVCWTZvSVJuYXJndTUzRWx4NUZmaDYwa3Y2YUtOaWZVbDNpd3h0?=
 =?utf-8?B?a0Jna21MMlVNTWtKK3l5ekhnOTlxREEraWU1d0xNZzM0MjdSNExkTWViK0Vm?=
 =?utf-8?B?SFFXUnFPakxQd0huNUU4eUZWTXRCVXBFTktaMkpiUTZ6ZXZIVWkwcHZIT3po?=
 =?utf-8?B?Ti9kVVJqbmY1azhqU2NTZHBaVzhjbHBySlVORHhBSVlTdkFBTFNvZDNlRVhz?=
 =?utf-8?B?MnZVL2g4WGJEbE1WUGdqVFRINHNVV1B6TUFPdmcvY1NRc05yWWhhUEtJaTlF?=
 =?utf-8?B?Q0pLR1I3ZFAvZG9vYkhNeDJ6cm9icHR0OEtnUkJ3WTZGaC9mYmU5SUNoYTlt?=
 =?utf-8?B?bTZYVlhOM09heHF4cG1GWisxNHF6OW5qU2V6T3phZ1lUdytYRCtwNjRZSDJ5?=
 =?utf-8?B?ckx2cy9HVjIydkxRRTVoNXBJbXZLNEovWXZrS0QwMnMydlh2MlZ2VnMwd1ZH?=
 =?utf-8?B?UnpZTkZ5RkxIdUxMYW9BZDRqRUljL0FtRzJGNEFZVjlYbGNLeVQxL2VQam13?=
 =?utf-8?B?VndrTk5PdEduMVlwMWtvckpNVlpVdVZSY00za0FhUEtra2wwQzh2emdrKzFH?=
 =?utf-8?B?aFVBTklwM05PMnBPN2Q1TW1hYWZQR05VeTBTclp5RmpzZmV2YndjVkRObkJq?=
 =?utf-8?B?SjN5SzlNVUVGZk02T1JmYXU2SHRqWGRCU2pUNkR1YTYzMGtyTVMyWGZ3RUc0?=
 =?utf-8?B?YlVqcGlMZndacUhySGpiOTVoY3BoTFcrMzlzM05FQ1B6bFNEdk43RkFiUXVU?=
 =?utf-8?B?bjd2RzViaU5YaDQwL2JlWU4vMkpLaGdoNFNXQjNIU3BLMjkxYTRzWjlDWDNo?=
 =?utf-8?B?aG0yZ25HSkFnNFAwQVdGYXlWZjNWQnBrSzJLQjBZSnNOVlJlcUVYanVlbTlT?=
 =?utf-8?B?bzl4cnhneHNwRmNiSThpOTE0cUlaNzdRZ0RENzhubHR6TFJVZVdSSlU5UGxE?=
 =?utf-8?B?MmxBbHBCU0lqNXlicU1FNU5kWHpKc0U3Q3JWQms5NmFzTksyQjhIczJmYVRT?=
 =?utf-8?B?dGgrM3VYZjRzSzBkcm1lT0JTUmdiV0dNTEpjVjA1MHp1S1NyaEJCWVFRUW83?=
 =?utf-8?B?ZEF0M0NpN05OZEtKUGNwRkdrMVZMaXhsaHE0aHFXRC9WZ3RQNlBNODNNVnVu?=
 =?utf-8?B?cEoxRis4QWxLUSt2bzExVGh1cDRjdnN1RDhNNjc2bjFNK2FOSE1RMWVFb3dC?=
 =?utf-8?B?L2pqMTBVSUFZV2dkdDk1MWhQcWREbFRra01Qb3RxZ2EwTHBFcVo5WFVjUWpD?=
 =?utf-8?B?UEo0N0tHeFU1WEJzbGRUdTZrOW4rYVkzM3JoNDkyenBIRXd5M1prSXMvdkNN?=
 =?utf-8?B?TXBRd25LSVMwYUdpWUhVY2JENXplVTNHOWJISW9RVmdvQXlJSDdURUV0bThD?=
 =?utf-8?B?ZUtjNHdXYlhMOVlvSU1uRExJWGdMdkJaT0txU3VIYmJBRmNHSUFSRWdqMHVL?=
 =?utf-8?Q?KKvCa6TIVwiA6fo8=3D?=
X-Exchange-RoutingPolicyChecked: VveBDCcU/3/7AyNWhQ+s33h7cHH+yAcR9EzKDUFNEhAaINULnvvLGSrRAVk/dAo+jVYxwGNOEZH7UU5h4GQb2mvTQQydm330HwJSWTgTaG5lfCUwutQN/aTOhFica08chs3Bvy2rF0uUVf2F8SIgHixEiBRrLIc/JJ24ZW9X4baSl2UYPtA0gvfRSce9lWmtq1VrmX0yH21YJPUjWJ4nqbQCZVVhjkCj5hz7aM4FpHmLXKHqngiPvesYnERIvYOCJKF5VFB3Ss9IjeyolDRO+IulXQBGGt+EsPwwvN7YU5f2IBBfbhKihkVIvVJpZk4obUdVf7Lmd9SCdNbSsUTKlw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b761f01f-06bd-4c84-fc2f-08df044861cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:35:03.5729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4jOBhL9LPguTuG+JFwT37QNrjryltcBD5bDfs2nJZ1r2sm4tZD1+SPa0DrEgfKd2J0MwrUz66hxcodllm86moVtye8XynaIlG45CWFsZ7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9251
X-Authority-Analysis: v=2.4 cv=YOWvDxGx c=1 sm=1 tr=0 ts=6a904b1c cx=c_pps
 a=1GsU8nEb0rXVac2zXnn+jQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=c9ZGyLeeXaSXnXo35IYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: S1Hr76pE2DONOHlnFXCwkDHOaaGvfhGy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfXwZp4ZkQ/tF3q
 vHXh31f5JlDKfpXeLINmUME/Pwx3a1QV+bghW5pj1Egw6JyuHwF9z32vM1DfEz6YHuyzecxu215
 PsDkdmVXveNMeIqzf5do6F/YVcgh+ko=
X-Proofpoint-ORIG-GUID: S1Hr76pE2DONOHlnFXCwkDHOaaGvfhGy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX1dfZs5jZvW1Q
 HPK9DZ3CXFSBRhwnW+oTDC9ltlknoy+9+DRMRDug8aBQAPCt2GGy7SNLQK5LTZLUDdleQRiiEwL
 jeJWwYeZ1yrBMGbwsdfTmXjdf/v88l/7skyp56gz6SidFHz7TPs2Y8oeiW/xJov1xF3jMGsKfvc
 6o4IN2o/yo9zspa+ZHJqm5Y2LY6lJ9gDmL25kCucpP2xSgkNZVNduFqDDMPsGqvgbRC6/EJ5WG2
 S30sf4TDIpQGZQQv3lCeDJhbfJHOVZF1kyX9svdNzPeA3BcwTY7JDhV3iW5SEH9Wmzw0JAhfqLa
 Alh21iqAxCNwJTCTP91kJzJ76OZ9+1ZDkAQzrwIzRM+tS3yL2cIhA1yZXDy6o4WWm3VRTG8QZ0k
 xFnBWk2e5VoQtMHL2fC7Rvij94yiDcASopaqZ8WKqllBnrjtoPowZpi2pj8dAwhDRGo7z7rinpt
 kiItnR9GtzWuoemjOCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
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

ACPI_PM_PROP_PM_IO_BASE can be converted to use object_class_property_add_uint32_ptr().
Remove the now unused piix4_pm_add_properties() function.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-Id: <20260825134320.1039012-17-mark.caveayland@nutanix.com>
---
 hw/acpi/piix4.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6462ba970c..52bd61667f 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -405,12 +405,6 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
         (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
 }
 
-static void piix4_pm_add_properties(PIIX4PMState *s)
-{
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                   &s->io_base, OBJ_PROP_FLAG_READ);
-}
-
 static void piix4_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
@@ -439,6 +433,10 @@ static void piix4_pm_add_class_properties(ObjectClass *oc)
                                                 ACPI_PM_PROP_SCI_INT,
                                                 &sci_int,
                                                 OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc,
+                                         ACPI_PM_PROP_PM_IO_BASE,
+                                         offsetof(PIIX4PMState, io_base),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -494,8 +492,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
 
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-
-    piix4_pm_add_properties(s);
 }
 
 static void piix4_pm_init(Object *obj)
-- 
2.43.0


