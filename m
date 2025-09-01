Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3691CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 14:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut5AZ-0005pl-Rk; Mon, 01 Sep 2025 10:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ut5AD-0005bf-H0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:05:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ut5A5-0007lo-K0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:05:35 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 581952de2806242; Mon, 1 Sep 2025 07:05:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+PKj9iKc5ABL4heImqyTQXVs9u7M5Jb9UbCvVnynK
 Zg=; b=beEbI8KjoH987naf41mpNmX8L2w2wYvnUFeCVk4roKP6ogLh7PnHl2Y9Z
 CsM62AZOOaw2sKzBqkq6ReP+M4CMUqoYdvTy3cliRthrbzgAp9ALTrEaf5qnYfhy
 +kgq5KIbrRE2ocLksSh9Q6721N4nFt0GMMD5yE43L9xVmWyMqiBprpDtsM2vdiPy
 iTDHf3/DecyVa9ZDXKeBnR5y5YTba6dIKhNrFm1xtW0gcbns1LJgrx3qZJZxumkh
 Gn05N3Cx4cKLlffIc1ewsMgJALF8w0xpB59wO7QkLK7asFoqG9W0rgiePgfKZIAu
 Zx8fYWqT1m8pYU1JK1uP0zfDWjzKw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2138.outbound.protection.outlook.com [40.107.244.138])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48uwmpbeyj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Sep 2025 07:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfojHjvttTuRRwonxgnRCgrbUXNSFvwGqnt4KQMZQWJ5IlhJsL+LiOsGcKrsKR+0nKffyj6e/Cxe8UV13GTNFVu2aH3HNVneOWKENq6T2bJcBYhA44WNErd1bO6G1ZfZeVrt8u4ufgxj0MfUGPi6tY4hNOmTyJrKF9/yVxDOR8TzSi9p/UoDahNZ9BxfsbwwNycxQvAGvDdtMHsd+WpHowMrSBjnMMAf0Gw3/snm/6XCKUcjVdiC5g+PHRUAwwA9sxEO6ba9bVtwDIP4Q2fWD+DeJTbZ+Cdi7giFgpQd8zElc2j1gRn1xOUHPwtaHcRU6tZ8Q5lbCmtt6urhPqJrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PKj9iKc5ABL4heImqyTQXVs9u7M5Jb9UbCvVnynKZg=;
 b=msLmhuLYdNQfinUwXj6vo1VDF0yzs4v79VcP8XyCBmNihh1RRv+rK011a2qaPAVbhlQs418jqbcag96kw95Pw+r81safogmq476l1ni8dks8PzK9ZzAb89P2NY1n+6vnHIpuIdSEmuTtPJx1J4rRShr8dRqvmmcfxqxQAZLkMGDUa2dJHTOENCGml2Wxi+P08pQu+Vh5pOBUSeiRYjCZiBY1GtnGDe4Yk+HUfZ9QODlu6BGV2jfaH+8c7BqOGlMQtnCnfL2Srq/DqmgaMZaanmsplVCjA4ZQor409W3s3IVF1+vyUmFb98LaCgXj6ot7SgKFpj6B9jOtYMP1ae88Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PKj9iKc5ABL4heImqyTQXVs9u7M5Jb9UbCvVnynKZg=;
 b=ehhN9Tz6NvIIwRzJbub7glFk6+EQYnWFyTuIuC6mSl6PBnMg1Wti3ysj4pZRsHc8E/4agEhD8gbwoVH6sxF6p0Ph7uiCuccS+ao+kkaWmDbqgdXd76Y5B7NXnfGMtU1tWSHSUvPBsD5psjGESTz2Px5NodPVFTGvRspVfboh4nae5pwMlyA8rZU7F1jLMzBlnD4ngzTnG+4tg57nC9A5rvRI0fyHdqJAC7Fg91LEHFH3h7IrgdJqsVwXRUKPOvcxYMVdwKb9bUInXgqOSHZiDhNigg3mJkTaL1LvkppTSK5T5Ucl1LhCui6nIOjI1ebphvtyyvbbKDN3XzNTgZjIiw==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by SA2PR02MB7513.namprd02.prod.outlook.com (2603:10b6:806:136::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 14:05:23 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%4]) with mapi id 15.20.9052.025; Mon, 1 Sep 2025
 14:05:23 +0000
Message-ID: <ec780a2b-9f0a-4b74-a059-62b09e61802a@nutanix.com>
Date: Mon, 1 Sep 2025 15:05:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc_piix.c: remove unnecessary if() from pc_init1()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250901132639.1123726-1-mark.caveayland@nutanix.com>
 <dc143cea-d559-4491-8154-1406f227e597@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <dc143cea-d559-4491-8154-1406f227e597@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::12) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|SA2PR02MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 961da0c6-c273-46ce-4e88-08dde96097b0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzFqZ1V1SU5ZQitXWlZucFg1YTNRSHhTRU9kUVlVUDVwV0pINFdqQnVQeEpK?=
 =?utf-8?B?dVRuK3ZuS1l3cytaQnNxYzcrRUpBRDh0cDkwRjNrZFZFNjdRNnhlREZCSkxw?=
 =?utf-8?B?SEZtVklacm5rY3RwYTE0TUxMb0dSM2dLbEMrZWNLYnFBeG1mSHo1b3ZvRTZX?=
 =?utf-8?B?YVE3UVNBRUNBSmVHenhxRjdZNnJUUW9yMkJ5cEgyQ2ZwbktFOWJ2K25xL0J0?=
 =?utf-8?B?OHBtQkM5TUlmd1FNZDc4ZStiaWFpS0hmK2RVOWJEQ09hWFlHYVVYcXVOcEsw?=
 =?utf-8?B?RTZleGdFaHV5QXR4NzFwbW5CQVpFSHRZcllNcmNqU1Q0bkV2UENaTjR4Ykxn?=
 =?utf-8?B?S3NUTFM2UURHdE1lZ3N4S0ZwMEZFMm5PY1h1QTUxM1dib0pDRmtRUkF0ZnFN?=
 =?utf-8?B?Y2NveE9QRFowYjkxUk51TDlmRjkvRTRoc2ljRjc5eVhIc2JEVWIwbkREK2sw?=
 =?utf-8?B?OFdSanluQVExeklST2RJbEhHbi94VGRYL3ZxVzV1bmRLRFF2T3lyS2NHOGti?=
 =?utf-8?B?aCtGeGI0TTVEa0NsRFVVaFhTWmNaU25FNWswM1BqR1NGanBEY0ROVGdKVUF4?=
 =?utf-8?B?WU9UUGhXdXo5ME9yMlZKLzV1L1dpTmsralM2RFIzQVp6cWlWUVZRY3Zjanlv?=
 =?utf-8?B?MW1xSkQzbWFDQkxMWHlOQkhxTDREWnROL0g4bjUwTDBmbDVqZitVRnVuSG9M?=
 =?utf-8?B?UHNQbExkSzVERFpYRzBXc0dTcFVHTHJsekdoZXRFWHhzeUpsV1dhajQ1c0NO?=
 =?utf-8?B?NG16dHhKVm1WVHA5SjVFTDQ5TXRwSUlQdXRNcVVWZVZxc0ZDRGVJeEM2cEdL?=
 =?utf-8?B?Y1dqVUphNURIN1puYm9aSUhGdkFVaG9ZVGRkVjJRUW96cjNwNjFmWk5YT0xh?=
 =?utf-8?B?N0hCUDJCaGZwUEV6NTQxWElJZHl1dmQvOFo0clFLMGdKbS9zNHVTYjJVR01V?=
 =?utf-8?B?b00xRGdBOVB4eGxvaDFUT3ZPSEdycXN2YkJFMjNLZUU5RnVVQnQzcklGSWEr?=
 =?utf-8?B?dFo3eGZSZTkycUdBSFEyeGFoaVM2ektlUDN4MWRsdzJRQkYxMzJzVUxDejRH?=
 =?utf-8?B?cW1YdWhlTjlBUXlRTC9kazd5MWRKTGM2dytIaVZYOU54NytGMWlmdnRiUVJT?=
 =?utf-8?B?L0R1OWpHM1IwOUlGaDk4UktDY0RIN0VOeUNXbE1OeGpIYVNiL242RW1qMTBh?=
 =?utf-8?B?YXFOV1JBU2hzKysybGhIWXgvSTlWa3BjME8vNHQyL2R3RkN0Rk5ia3ZSQThU?=
 =?utf-8?B?NTJ6Yk5tZktLVVhrLzV1UGc4V2pHVklLRjJpcVluV1ZzZE9ubnZPNFRTRjVW?=
 =?utf-8?B?b2dEV2tnbEJNNm1iMGZrblRnWWZyTmtCeWIxUUtNWVZYVC9JRDI2SndqNGVI?=
 =?utf-8?B?UWlBQ2RnUTVjWnQ1eDBkMzdZMDFRa2FSMEV2ck1ydVpTY3FVNzFvRHM0ZlVD?=
 =?utf-8?B?Y1orQ0tOVHMyeXY4MXV4Sjl5TWI0ci9KQlZMQ1crM1JKcC96aGtFNFEzWmxU?=
 =?utf-8?B?S2p2UWEwVnNzalBUODgzTXVjM2lERGQrRWJtOEZGUTJHWEtpM3ZoUlgwTGYr?=
 =?utf-8?B?Z0YrQ0hONVdvcHlPN2RGYjZwZmY4dTN0NUcrdSsvU2Z5Uk1NZkVPZ1l5Vzg1?=
 =?utf-8?B?RVBNQVdiNG1qQ2xsUGJwZVpxLy8yV0d5UkkxU2NSa3Y0R3ozL2tQTE0xK1pn?=
 =?utf-8?B?b3ova0dXVllwbE5Lc05lOS91ZEdvVkZoWVRudVRxRGc5TEs0L1VBMXdpbVRv?=
 =?utf-8?B?WW1ISzlDZDZyTGFFR1RaTUpsUzZiNXpaVnpWaUI5dk5ZdmcwaFZoRUJpdjNj?=
 =?utf-8?B?OUtXWW5Cb2UyeTlHc05WNnJsVHArOU1hQ2h0OTNWODdGaytHVG9Fdllwekxp?=
 =?utf-8?B?RkpRbmF2S2Q3ZVlxYTk2ZE5uRS9vdlo4dmxZVGVEdkUrWVVsZ3F4YzdYd093?=
 =?utf-8?Q?8K8R4/m/vS0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS85SzVqZmpnK0RDYjA0U3ZPRnpyZFdwRjJSVTdRSnV4aU9OT2JSY09kSC9t?=
 =?utf-8?B?Z1dpRyt4SFV0REJjTFc2YW1RUnpuNG1Ia1ZiRklKQ3JkdDhSY1RqOVVUZDdI?=
 =?utf-8?B?QTRock93eFdFQnpDN3NKM2FOcDZSenJVejFNek8yc3BFUy93NlZPOEw0VDVO?=
 =?utf-8?B?SE0xZHNDR1lRRVFNdGlmd1E0NFU3NitoVWV2UUE2R3dUUjkrY3UwUHMyWjdx?=
 =?utf-8?B?MTk4cEhwcE45eDhmSWR3WXFkc20yTXNEdUhzNnJDaXBxcFJrb2hDeC9hbXVN?=
 =?utf-8?B?Ymg2Sys5TFVWelFaM2tkeFFYc0dVcVdnQm4ra1VubHVEaFIrSHd0YnhXQ3BG?=
 =?utf-8?B?ckhQOHRDaXVhYTlIVHBqeHZCeittNEIvU2wzUGd2WjYxUmhBNTNhY3M3c0o2?=
 =?utf-8?B?NWNuM29vODdkbUhUeGw0WndSODFhcUZyU1J3OEZFd0RhUnQ3QVNLQUhFbkF5?=
 =?utf-8?B?UVRDMWtCZFQweXhTSEtSWm9xZVR4MitDN1Y2aWNPcjNDd0JZNXVkNnVyOHE4?=
 =?utf-8?B?c0N5NGx6bDUvQkhvcFN3cGJBTmNNQThwNTMxRWFQZ3JreGhDZjNjMFRvaUJL?=
 =?utf-8?B?SmNlM2R1S2ZzL1JyV2kwaEd4ZngybmJUYkZvc1EzQjloTzkrbFNuQXJVbGJ3?=
 =?utf-8?B?Q1l3NUxoMzIvcEt6NFlSUEk4UnhjT2ZhOFBNT01TMTZxWTM0aDgrb3U5Z2sw?=
 =?utf-8?B?OTRqN2FJbFArdEM1M0MvSjJqMlVQa1dIZ1RUODlTSncydVF0Z3hheXppUFlB?=
 =?utf-8?B?bEdrR2hXcWJOZlpvOHpNVFpDbDEyMFZZR0tPeDhFR28yZFplb3pkeWNNVVJs?=
 =?utf-8?B?UDlmajF1SktVYW9qNjlwL2QxV3NqTXNmMGpTbitxQi9iRWUwdVp3cUdLL0R4?=
 =?utf-8?B?Y3BPZE5VeHBmZ203UEJRY0VrM05rVkJXMytoVURRZjV1WWNCdjRXREFrUVpp?=
 =?utf-8?B?eW1EVWVGdzArNVMwQWFCTFJrSFVIckU3dGdoVTZ4RUplczlXUGo4WW1tU0lU?=
 =?utf-8?B?MnFIYW81NExnUU4wNFlpOFQ4VS9xalNuaVZlcFZFa3VGMlYvV3M4d0ZESlJt?=
 =?utf-8?B?WVByOXdobWdiVmEwSDhrVXVSeVJkNEVKVXBKSFU1NS9vQ0xzU1A4STRsbGRC?=
 =?utf-8?B?cGJWL3hIR21PVWxVOCszLytWc3FIR2t5bGV0M0Z5RmI0SHN3OVpicTZmUTI0?=
 =?utf-8?B?dEM2UXZsOVk5NHZFZVNOY281S0lUK05uQU5GUGhNY2dOZHB2Z3dhSENPT1lj?=
 =?utf-8?B?NFdXZC90d0toN1RkTzRxc2lRYlNhQTh0QzBBbGkxNG9JdURmT1pJZmRxNXNS?=
 =?utf-8?B?eFR4dnM0dXZzT0FhSlZ5MTZoSVM0NDhHR29wWHZzcG5NNHBmeExBNHE3QnBk?=
 =?utf-8?B?MERIVUxadExDb1FRa3RGMlkwSWJWWG5GRlpnVXpoSnlhejRGSU1mOXpDcEJy?=
 =?utf-8?B?Z1dPT2JEQWlONUFGS05DVCsvcjh6WDVINU9GMUpRL1dVL05mV0lGSk1nNmxJ?=
 =?utf-8?B?UkVxUUU1UVU2U3NSM2dUNDJ3SHp1eER1VS9EeXlaY3JHSHNabU1qSG43L2oz?=
 =?utf-8?B?c0o0Z1NQMjBQUE9QdjV1ZGs1RHpLd0tCZnZoUFF3cGpHVlRscllXRUlrZDEz?=
 =?utf-8?B?M05DbFE4dEJwOUZpN3RGSWN0Yms0RGtCdmppR1Q4dlNSZ3ZRd3lCVEhtTFEr?=
 =?utf-8?B?S2RONFVnb3lJam91MGprWHRlS2tvWXdvRm1hQ0k2UkJ0eGhDaWlvZWV1MTVQ?=
 =?utf-8?B?R0thTS81S2JzRHRMRitFa2labzE4aWxzVG8xT3RveUNtd1hFMFlKMTFtY3oz?=
 =?utf-8?B?VE1MV0RHSWt5MVNvN0Y5SzFXVUJFckFnTjBPZVg1Um05dmJsd1lubk1VUW1Q?=
 =?utf-8?B?SSs4aWR4eHVPQVJ4ai90S3BoMDBCckJFZTdCVmpjMlhmRlRCcXRaM0d6QTha?=
 =?utf-8?B?Y3h1NVQ0NWhxMEMxVWl1Z2ZNa3U4bStYTnprcllqM1FzTmJQSFpBV1dNZHpv?=
 =?utf-8?B?LzFKclFFRFdqcTNUaXEvQ0NrV3dWd0FmUzRhc2dIRGg3UUI0czVBNXNRTTV1?=
 =?utf-8?B?NkhtMmh4OGlqRVBtNFJteDBpcEUwQVVaSEZTdHVCcXNJK20vM3l3QndaQ0Jz?=
 =?utf-8?B?SGo2T0dmamJnM1NXbEtsd3V5cnBING9mdnRnQ2o1cU14L21pZnZlOVdlL1Ri?=
 =?utf-8?B?NHkrRDJ0bHNSQTRmcHFNWHo5Y25VZ1d5R1BxUFN5TTF2ZkwwOXF5bCtIeGdH?=
 =?utf-8?B?R1JlUHFuQnNpTFhCazRtR0laZ1B3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961da0c6-c273-46ce-4e88-08dde96097b0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:05:22.9918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzRfgajWeHUKKy+zGaGKxEuLCo103pxvWxrsKJtEHH8YT+W0B3Vj65gaFEg7SrAnt2S+xprhDvxZkyXb8c7Aw6dHUnZaSZEZXuyO6XccRCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7513
X-Proofpoint-ORIG-GUID: A1hAdA2spr0VPmn0kq8a50m9mYUzXQnK
X-Proofpoint-GUID: A1hAdA2spr0VPmn0kq8a50m9mYUzXQnK
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68b5a824 cx=c_pps
 a=8zEn50EW7sokACXIljcC9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=5-cWsfrM1Mqdh34-JJgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDE0OSBTYWx0ZWRfX/fB6IV2V40ZO
 AbZMnbLG2P6FyDITga8KbSOkGEpcgenDclcxowR9bHCQo+Z/0yRtY8R+OjBGdvBWGpjwgG4dD/V
 ojGE+fycZTfXsEB3SSsfT8RuMEjqLjGh7aRAK3Vb4qvgjFI563eDjGh7k/8XUhG8nbPS1UDYVla
 5LB0K3UJ5O+inM4uBFzokpK0pXn4xKdcxTi2fRPyL0aeQo1oNopM2MPCv/pZYfibyYdeDf3vvFw
 DuYUuoni/acgiUfzAdi2ccyrAhTp8Zllk4Z1yd44LOfc9zidNoBZzeX+tXd99LuJT2hjNY61H/B
 /WUUH2qUYLSEv2mOGij0VoeKzjPNe8oOimzamECEzbpd3KNg66TDUfq4y9DBZM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 01/09/2025 14:36, Philippe Mathieu-Daudé wrote:

> On 1/9/25 15:24, Mark Cave-Ayland wrote:
>> Now that the isapc logic has been split out of pc_piix.c, the PCI Host 
>> Bridge
>> (phb) object is now always set in pc_init1().
>>
>> Since phb is now guaranteed not to be NULL, Coverity reports that the 
>> if()
>> statement surrounding ioapic_init_gsi() is now unnecessary and can be 
>> removed
>> (CID 1620557).
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Fixes: 99d0630a45 ("hw/i386/pc_piix.c: assume pcmc->pci_enabled is 
>> always true in pc_init1()")
>> ---
>>   hw/i386/pc_piix.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 7e78b6daa6..b6d0cf411d 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -284,9 +284,7 @@ static void pc_init1(MachineState *machine, const 
>> char *pci_type)
> 
> Maybe also remove the pointless NULL-init?

Yeah that's a good point: I've just sent a v2 that also removes this, so 
maintainers can choose which version they prefer :)

>    -    Object *phb = NULL;
>    +    Object *phb;
> 
>>           pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>>       }
>> -    if (phb) {
>> -        ioapic_init_gsi(gsi_state, phb);
>> -    }
>> +    ioapic_init_gsi(gsi_state, phb);
>>       if (tcg_enabled()) {
>>           x86_register_ferr_irq(x86ms->gsi[13]);
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


ATB,

Mark.


