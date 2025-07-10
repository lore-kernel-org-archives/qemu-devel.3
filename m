Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3960DC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZtKv-0004X7-7J; Thu, 10 Jul 2025 11:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZtDj-00082v-91
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:30:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZtDg-00035a-KV
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:29:58 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A7ckFH019105;
 Thu, 10 Jul 2025 08:29:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Y5wP5tTz1r8uWPngALw6x08alfvhlwFB5X8+tbhl/
 7E=; b=wBzHEXMQnQyTUxXUph9mZT77sXy+VK8NDOXygk5BBRBXu4rMtSYeJtLXJ
 B5ZMXhxPvkYeHQliyilmdoU5FGQmd7X4BCQ9ymOY3JmH/TImfKwCiBJBnvCpdlxz
 F+HEJvIcfMcJqAqvKozeEMqC9ETU2GnhkrmVsbd2SXT3dcdUwaIER00rt8g3cwW7
 gdm0pJb6E4EGLOc1OkVnLNgY4KM8U9W/GZTpbH3kDAK/kVBrb0RnhMEClx11FlEN
 lp2cXpE+CtuIEL1/dX3y6rkWb+SXJ+i2ZUsF4h0abnKUv33Nx/3oF7Ao/dsHxEe2
 sYi2k3p5a4MZiYz/2RjbLvJ2GrzDQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3k36cjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 08:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYQdmrVmcN769rtgGEyv4vuNT7ASr5vYaTY7zsRUvs8p+k7DWFluZPRhMMbzLQkghDrXB8/kpRPfn3rnUYcSoiH4GA3taRTEjASvK488J/CIguM92/2ZnRkJ4TpcN+IBTU0Sw+IqCv4oltjp9QNcspbkJB+xzkZNEgXY8QFxgzZ81FKt0W9/wImsDNyLQwxfPnxmAXFzfLE5L6GiGUlxPIV1wjzMvEYVZQCGBgmNTD4x3+iLiBAHGY+6TgpdoEuE+mdbOF0SMK8FMT0+PfVBBHnlkKiceU8GhUnvlVSEuIcj9mzE17r6gGXMM3lKvTrUtYtNQlifXCsZW7r2mMiXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5wP5tTz1r8uWPngALw6x08alfvhlwFB5X8+tbhl/7E=;
 b=H3leOaiXD8CXGbWKt+DrmrHify+7sjLt5yWR4mMp05qV9yYtt5RiOcAHakDoV6VbV2ma00AyvhwPxBjNQGD2OuDT77tGdyfrx7bFbDKCI7rkxMklH/vpI3vxeDQkg6P5DEhG+ocK0KKzEB8M3EkBUU9TY7mLFTpmzA0+pDAOuGQjmJMSmMIVxEr31quyLS8LWRUzXRn8YLAfoEBeWNATMDv9IZiHv8XIZ/dnM/rYoCzHLC0lhWFnuji9F9kl6tVGVkXcK5ynA+YmXlNuMODnJ9Oq8fG26duei52MbWjoP7luQCmak+ZZsByYCtqF5wcVC6L2/CJZrB0QFsN6mJqBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5wP5tTz1r8uWPngALw6x08alfvhlwFB5X8+tbhl/7E=;
 b=rCDyPRMd2Elo7RRFk2Ms75Oto5SWk4ZTY7TszfBQGvWUubtYO9wj26hpk3kTf5jUux0IEgkP60muVXzZH7Y3D91C/mBR6Tz8rBI8gbwxxaLjEVG7zvqVk3YB0DhvLAmobyfLnTkG6DDkSxtKjWrx+x4l/smjy3Zf3qfB+throw7XMvw4ss0LRILG8ddeuspGAgFxJ7UZTqAZlTQaPLCvNcQbCtVPeWnIbLzTE9JVRsmZ7XL8+4Pkf+iBG22IABilmipoJ9+Z8l/OiktiTk1tvlwcC5pRiBF6sQyMbgrjk6SdjrL2xxuUkcZX+juOOw1INIZrWNmlRwQXqWSLTbW7Ew==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10661.namprd02.prod.outlook.com (2603:10b6:8:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 15:29:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 15:29:50 +0000
Message-ID: <0cac2fbd-be21-458e-be86-930aa5dcf820@nutanix.com>
Date: Thu, 10 Jul 2025 16:29:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
 <20250704141018.674268-3-mark.caveayland@nutanix.com>
 <3ebf1793-6d55-4e07-a2b6-cb738d8634fb@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <3ebf1793-6d55-4e07-a2b6-cb738d8634fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:208:be::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a811a6-c52f-45d4-5f12-08ddbfc69c69
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXJwWGJ4ZzUwOEdUNjNpZVlaU1JWbXZhR3N5dklhQk1nbS8xNlhMemUwZmsz?=
 =?utf-8?B?Tm5heXI2Wm9sU3plb3gvanoxMk5rb0d6WnoxYWxndmtYTk1qNzM0MzlCTk83?=
 =?utf-8?B?WTIxd01TN0Q1a3FBdW8yaUFmeUNvbU9mWkwxNUlrYnNBUkRRa1I0MDJmMHla?=
 =?utf-8?B?TFNjWnhHS3RBM0ZPbkx4RElqK2g0UUJodFhobzVuUHRIRXpxcE9wOVBuYUNF?=
 =?utf-8?B?U3JwN0ZFeVFqSXRMQlpvbHhLSjA2MC9ENEQvNFVydHdNRFloN2M5Y3VGNkgz?=
 =?utf-8?B?eHM2TnplRFkxeVcrRFhyK3VUVUtCZGNsOFJIOWJkQ09GM2lhNSs5bDhxMS9B?=
 =?utf-8?B?RTMzR2JZb3RxR2NSbThBWGtPYXlDMWRYb0kxVzRmbStOK0ZuY3h2Tkd6U0F2?=
 =?utf-8?B?cW5GOHBYcTEvdjM5WVpnK2ozdlhKV3ZjSDA2MGhGZTNUajltWGhjZ3ZqaWU3?=
 =?utf-8?B?THpsN2s2L3MzU2dXR2NZSlBVVGdDcG9hQmhKcWJKa3ZraDRjaG95Q3JkZVVa?=
 =?utf-8?B?T0liR21ENFFlOTlHWmRKSUN3dmlhWXR0NXNDN3NvT1ZNaThYNUo3V1AxK2wy?=
 =?utf-8?B?T0xJYUJUSVIzbkJQWjZDS1YrakJuS2YvUlQwa1dYVmVLaWQwNkNxSFlpT1By?=
 =?utf-8?B?VFF2SXJiTFpIempNTHNQekpDL0hKcFo2TnIxWmdpdGJDOEJYU3luQVp4TStL?=
 =?utf-8?B?UFp0TnViQUdEaTF6bGQyZWsxR012ZTBJNm9FREVGaEtRMVI2Y3IzaGtJWWox?=
 =?utf-8?B?RXN3TTBnWG1ML0FQR3hBeThFTW81NW1QT3BmQ0R0VlBVd0J2b2owSG1QdG41?=
 =?utf-8?B?R3kwRE1EWUFKa0k4M0pkM0FMYmxvMWZEOHJ3eWZCY3dXWjBWcFd3S3lUYTM5?=
 =?utf-8?B?eExwcGJBQjAwUDB2NU9BeUI1Y2h3SVAyR3ZxRmRpSnJROFFKVUVIYWtORUFK?=
 =?utf-8?B?TFhaTnhuVmFGc2dkeXl3UWxldEd5THlEbWx2NE9yWEVaWEFFY3p6cm5PK1F4?=
 =?utf-8?B?RnJoa1l0Q1c2akxESVRVLzdHS0JWSTlvZk8zNG1TY2JhYXNaNnZtYnQrL0pD?=
 =?utf-8?B?UjNldGdKbkdPN0VTTjRWY2R3S2c1TndqdnRRaVdZc2FiZW44by90MG5yUTZ5?=
 =?utf-8?B?RWJVN0JiQ0E3K0g5cHF5N0xOejRWT09LMHh3clZiaW96ZU5kRXFjTkkrL2tK?=
 =?utf-8?B?LzVvaUNENDliNVc5N3ZBenJ0NXVWdk1RaG9EMncwK0twQXlWNW8zNytXMnF3?=
 =?utf-8?B?WVRVaVBLbUYreUZZYWh2dmlLV0NyLy9PNG9PcDBBUk9IRm44VWhOS3Z0aHFE?=
 =?utf-8?B?NWRGUjRLckQvSk9DMXMwR2VvNFUweGlKZjVqOXlkK094QWdEK09CS1hpQmFk?=
 =?utf-8?B?OWtiVHJKd0NnbXdCbjJ6TURFeGZiVEFha1VwUE5qZzR0NFdKVkRHL2l1WVJC?=
 =?utf-8?B?OUhsUWQ2SUovTDRYVHB2c21xZ21ZeFJBaWh2TkdTVU9uUjNXWkdhT3Q1STNX?=
 =?utf-8?B?cVFaK2Z1aklNNGwyMXczN2lCVSswWjdrd0M5V3NEZWtmWFVnSUdCRGFvWHJn?=
 =?utf-8?B?T2VFY2tpT3c2RTR2RWVNUUtlWHlxb0I1eENZV3gvbzhUYmpjNmxWWDlXbVZt?=
 =?utf-8?B?RmVNVVBoei9nSWR2elB2RlM4bHN5UHN1VnJFeUlvU3hHaDc4VXFHUnFUdVll?=
 =?utf-8?B?UkdXeW9zekRvSjgxTDRaYXR2dUZ3Q0Njd3poZTRlWXg3eWNpYXdvYmNkd2FV?=
 =?utf-8?B?RW1yM3NpTWxWRWd3ZE1LRzdGc1YzaWV4a2htQmhlV04vQVRzK3pEaVNLZmMy?=
 =?utf-8?B?REdha2VLd2xMeTVHbW1nYnBzVW9XV1NWckltYWJ3SXhzSFEwN2VONGI0S2Rw?=
 =?utf-8?B?S1cyRnBMbnUwLzBMclppMThiNFBuTHdvczY5Q1VOcHZXVVFwTktsOW13WmJa?=
 =?utf-8?Q?GaZj4TRRq0U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVJPVS9HOTNIWjVDUmY5S3N6VUkrTTh4aG1tQVdMRzdTMXpjVUpCQXBRaWFH?=
 =?utf-8?B?KzJ0SXhnWWVLcDNQOHY0R1k0Q0hZdUN4eHlrSWV2ZGlueGtNaFdGVkRMSWVU?=
 =?utf-8?B?c0dnQk5kQVNJYi9xbWhXVDVMUEw0dW9SVytSbm5vZTMwZHJkNmlqb0RaTzhG?=
 =?utf-8?B?citjZDlqdjIrQm9xVGZGTkNxUW1zcFJGbVl0ZnRROHVSQ1lBUXdsV0RFL0Zy?=
 =?utf-8?B?V1k0a0xYRzdEVU9FU0l5OTNLUDkxNFlGM3QyY1Vrb0VqeWNJSXhCbHRaR3JY?=
 =?utf-8?B?RjB2Y0FxY01uZ1B0SUozaUdzWVZaT2NFMlpDTHdGU1ZVbzNMTHRTRDBZbFJt?=
 =?utf-8?B?QjhFcFYxb1dHbXMxVHlORzhRbkQ5TTJIc0JyT296cCs1WEhUVGFvblVUbDlN?=
 =?utf-8?B?MHNxT3ZTcHE1bmlFTDg5Q3Y1SHhhbzJ4czNTU25Wcm1PRm84NThpMnRYM0Yy?=
 =?utf-8?B?MkMrZEtLVktUYTFaZ2dmMHZVaVlUOWZqZjBWeXhzMS95bm5SMkpVaHovRlV5?=
 =?utf-8?B?WkpIenlMaUF3RC9oMzcvZHdvTDVhbXU4bE15M2lBYW9GSFpwb1h0cU9OckVX?=
 =?utf-8?B?OHJCV2lOZU84S0Q2R2h3TmFJZXJDQ0ZJaEVaZnE4bWhrV2k3RkhOUDVLaHlr?=
 =?utf-8?B?NUlmSnI4MFZSS01qaCtVLzlULzZMaERWemV6VUZQY1g2dE5sZ28xMzJKcGZp?=
 =?utf-8?B?YmNDNjYvQSsxdFRIMUxnRkdRWlNqM3h5L1lVQk5mTTBobEpZcW1Qc0c5MjhK?=
 =?utf-8?B?bmc4YTVtbm5BRkIwNFhkYjRBdUd0L0JTaE1XVTByY1JrVUpwendJa29SMmhU?=
 =?utf-8?B?MGFnRWl3QnJNeldZNHBoOVA1UkVUSHp6YXZkb0ZJNzZLTXhGZzBReTNtOFcv?=
 =?utf-8?B?ZXF5TzY1dG5WQW9rMU1UNy9pUG9YY2NEL3VCU0Vxc3VJMC9ReUJxOTNocEFv?=
 =?utf-8?B?TWRFTFRYZDc5d0FxVVhLWDdjQ09zSnVhWDRmcWhJTldXUmo0UC9PaVdmQkMx?=
 =?utf-8?B?Q2krTEFLeDJ4YmphMVJVUXRkK2N0a2NIZDcweERremZaUi8zS3VSWDI0eGYv?=
 =?utf-8?B?bm9qY3pUZ2NReGRZa1NCenpJNW90S0dnMkRVeTBCb1pSTWdBd1hpNmhiMEpp?=
 =?utf-8?B?emh2U016M3pwU2hxTGg3SzJ0R2NHZWFPVVNDN2ZNaDZvRFd4T1N4UEZUSnZx?=
 =?utf-8?B?a2V4dzYyamtHRGh1eFp6cldaaU1HZFF1bk16cjdJcG9kc0kzdFJHaDJjaHVS?=
 =?utf-8?B?UEh0d05sTW9aOTZUeGdjWUJncXAvSjV4b29PdG56Tm9CNlBoMy9yaWUyWmov?=
 =?utf-8?B?VmlncnEzNGpuZnN6MTRVYkhVUXl6U25qRUNSY3pVcGsrcXpDTDAvMXZkRUpQ?=
 =?utf-8?B?U1hMMWRYYnBRSmVBeGhES1BTQlFmZ0sxWU1FNnBYWDFHOGoyUG5zVjJ2Z0VN?=
 =?utf-8?B?MU85Y1IvRnVLaGJiNXJlaE5mNm5Yd1ZuYVNpTDhXNlFYZFo5emJLeFVhNER4?=
 =?utf-8?B?TUlmMFVGYzJqbnZQdEY2REtQb201U2phQVBLTGd2MHNobjQvdEpHWHpZY2px?=
 =?utf-8?B?bHVjcHlPVlIvcmgyZSs2azhkeE5iSGJvWnl4d1JTa25OaFJQUlpzVUhLUk1O?=
 =?utf-8?B?cGNTV3VOMkNJTTNtN3IzeldLbGk1NkcwbkVCRy9VaGFpNTlhdkcvQWdta0Jp?=
 =?utf-8?B?Qk8rZE9nVDNUSzBTUXZqVTV3UEtkcVk2UHIwMHVybThKMC9QWDVGQTYxeUN5?=
 =?utf-8?B?Vkw1d2R1anZ3Rm1OZEdpdjdUV1FDNTFHUUpuRmxYTFIwaWlXR0lnUWdMWnFO?=
 =?utf-8?B?TmM1c3YyVSt1TW9FdkVhMWp6R3p4RlduZXYyaUt4Z0F0dHZtbHNyc0FTSng3?=
 =?utf-8?B?eG9NOHE4WW03YXJBOUdhOEhqRHRRNkFaOS9lTi9iMEhkK1lLL3BPbFZzaS8v?=
 =?utf-8?B?SHJJL2QzQTU1WDlNdnNnVnlkVUt1T1M5a3NFeG4rM0d1emlJS01vNEF5ZS9F?=
 =?utf-8?B?V3kyYVJMZHplbmx4N3grOG15UEdwUHlXaXdIQXhZN2JRTnJuaGhUWFY3cVdM?=
 =?utf-8?B?L2tPZnRSZHdpakF3RzdkVS80d1BVemszRjNEZW1CUmk1UmUrNmFKMjhUWDU3?=
 =?utf-8?B?a295TVlXOFE4VDM4Tnc4S0ZnTWd0eU81bkowaWxpVFpRb3A1OUJXU0kxYjR0?=
 =?utf-8?B?NytKRFpmc1YvYVNmenpmcjBWZjdFL01LNDQrbHVjVkdHdi81OUF0b1A1bytY?=
 =?utf-8?B?bHFxZy9pQmpNSDZsbktpMUZLbnZRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a811a6-c52f-45d4-5f12-08ddbfc69c69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:29:50.7501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0Hm6CJVGUh5ivQZ2P9zPIoOCy5ru1GabBGgFX1VH8c7lws1CmGlPOGwDUTo7p8rFchDvH4X1GIf1nqlqmmWBNpU3U88nmzNxR6K5lUtcrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10661
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=686fdc71 cx=c_pps
 a=SWO9grYKeR/AU/Iit+pPqg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=pX6o070tOcvsR0-muEoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eWDnXJzgFzxenoyaj_zzWyMfIqzGXedI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzMyBTYWx0ZWRfX4+VoJcm1R9te
 J6gi6qvaVC63l6vXVxMHwZ40xr8p87Fi1EUDVwvwhH5HGkAnPuMkWiWyoyZ0WLUqjAQluMSAYyV
 9KrjKdf1oFxnavpz0SKPYws8rX6X/wpl3uvot/vjPBy7OCcPms50+n8rGb3dUCV7DgbAc51SfQV
 EPptVgOcnln+1nvWjAuYLxfTbvKcew+o7xAFjO2DD/jmOdZrtf2PSc4dSeUrbCIuywP+JzV7I8f
 K8v4DDgQ8uEV7SE1jUh79uZZqn+x4u/QdQeQUvcoD93SZZtleocAB6/CW0UGBNLXhnQbN+g0Uop
 792Fr7sxuj2ljjw66GUx0fIR4OslQeM4l9L3H3f2biYFX+xZAY9cBMLm50zXkXGPGJgwSBP8xZh
 YsD2RTgZCTnVUu4IXefUgxIIDuLi3kcnWMvzkhtk5cLzxL0sFE4BCvIMjnpvntCshpZR5gyR
X-Proofpoint-GUID: eWDnXJzgFzxenoyaj_zzWyMfIqzGXedI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/07/2025 11:38, Philippe Mathieu-Daudé wrote:

> On 4/7/25 16:09, Mark Cave-Ayland wrote:
>> This is to prepare for splitting the isapc machine into its own 
>> separate file.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/i386/pc_piix.c | 261 +++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 260 insertions(+), 1 deletion(-)
> 
> Further possible cleanup:
> 
> -- >8 --
>      hw/i386/pc_piix: Inline pc_xen_hvm_init_pci()
> 
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ede7b68946b..4cec4f44764 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -362,14 +362,6 @@ static void pc_set_south_bridge(Object *obj, int 
> value, Error **errp)
>   }
> 
>   #ifdef CONFIG_XEN
> -static void pc_xen_hvm_init_pci(MachineState *machine)
> -{
> -    const char *pci_type = xen_igd_gfx_pt_enabled() ?
> -                TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : 
> TYPE_I440FX_PCI_DEVICE;
> -
> -    pc_init1(machine, pci_type);
> -}
> -
>   static void pc_xen_hvm_init(MachineState *machine)
>   {
>       PCMachineState *pcms = PC_MACHINE(machine);
> @@ -379,7 +371,9 @@ static void pc_xen_hvm_init(MachineState *machine)
>           exit(1);
>       }
> 
> -    pc_xen_hvm_init_pci(machine);
> +    pc_init1(machine, xen_igd_gfx_pt_enabled()
> +                      ? TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE
> +                      : TYPE_I440FX_PCI_DEVICE);
>       xen_igd_reserve_slot(pcms->pcibus);
>       pci_create_simple(pcms->pcibus, -1, "xen-platform");
>   }

Looks reasonable to me: I'll add this into v5.


ATB,

Mark.



