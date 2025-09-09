Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C452CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0MX-0002eQ-9M; Tue, 09 Sep 2025 11:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uw0MO-0002dT-V5; Tue, 09 Sep 2025 11:34:23 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uw0MB-00050I-5k; Tue, 09 Sep 2025 11:34:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 589FGMou2323355; Tue, 9 Sep 2025 08:33:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=5G79x7/HFuviwEvTXQGQUe65OGaw3Tpm/8g0M75zi
 bU=; b=yK7X/mChvBmg/SqHr1pA49wIlzmn81hmhVhYbXJ+n5Pk1/3GpIaL9mxcN
 pr8+vv+Fnkd6YFtpoP75aNzOqCcsLoeg9En4F0ChwlMCMx9OQ6F9Iaa5EG6db1TQ
 e173BHkays32ngbnoEgVd1u9bcBi/NlpWAnyZwMn31OYrYf4jEGFwO1W5ZAl3+H9
 buBVyVXe3TXCL9DjyIrQ/7SrkkMV9wMsXa/Xet5BlXH0G0pNR4R980mNuTwBy2+5
 Xlmm7ds/ZQDsOuS5z/fMlUGP3UKA4UpNF4nAwu+j/s7/gbH51twHCz7+vb6umGW1
 lp3wVtDhqQzkH0DxCHk4CAEtrRBKw==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2131.outbound.protection.outlook.com [40.107.101.131])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49244fagh5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 09 Sep 2025 08:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmdIM6QeACSUoCk9tyH5zr73jYO45gMKMHBevc5cI3j03TjF6XvwTerl/3pcuEklQ0f3BMCW8gZYgPCjhST1GWX2u2Xb6pltGCxVQbecfb9YCgas3OL2cc1mJi/RZpMG4u5Un4R5DkpGd87Qit5ZKGXmRaXjlE9kgU2Sq3hOBUeXLlnVOcGHvIvO0l1Cy3lJ/0zn7/l0ZCS74NtMMnlYkoiY9nt52BDMLfNloVcUJmbmIAKQ5RWa0qD5fCe0TYaOgp/Pf49e37cUnriGdVEpwFKmDygHWPnyTaqWv4KoLKijaYJut5XHmxjSYikUNM2Mv0BOPYbte7RAzN5ToWxWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G79x7/HFuviwEvTXQGQUe65OGaw3Tpm/8g0M75zibU=;
 b=B2kU6rimuODv+YAuKGYsg2zG+7+KaLkCpmpktzGckl4WS8emaKRizAnkHuNGBmD5w5yjbjUBcJOyCHaKz8v0uWEUi2LqS+K6kcy7VRRBSD+0WctSWr3piCvzB0ynLeIcXyEv6GLeoW5be33K1zwgNevDaXiPxi5f2nccGQXjYDwcKPkgcoh7tBYqnamdbt0I+j6fupeuWQNVd37lF9rg7v8Y0WhRgjtnBrBfhW+SlOic8qI2KZBKse457fMHE7zi0vdjFKbdEKWoCBevv1tfdl5S47peP24fWb/vXXvszK7AdqvXQkQD+Phg7ZLehwimq7O8ilbcEkRGzUDiWFQtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G79x7/HFuviwEvTXQGQUe65OGaw3Tpm/8g0M75zibU=;
 b=ppWp9FQIN7/Chj7qWEz5ujKmMBnoM+iLaALOA7uOxMdfKt5z1BXhSKJxTDWLHO9JPO0YqyOFV/XFV3zWNt0HurTGM9XS2F5K6GBrszh0Lv5i7AhX4bnTAZTcvFT7RXKVjayao20FhKx+NDp0VJaSWgB+2xMgcvvYPnkpOygtC5HxNaqhJKsF2dOxXukhFJMITbAX6aG4u61ycDDxGQu0Vln2i1Wjd6USgYZILYbmYvFP19U92iErzHFpfD0esOSLMJ2eL7RHgW4USJWPFgzIpcaqUDHev4GKjwFsYfbitPZ03/6NBJo8nptHV+tGgWk8i0HxITuu0xNlBGPnw9lnqQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7614.namprd02.prod.outlook.com (2603:10b6:a03:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:33:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:33:53 +0000
Message-ID: <25474f04-2baf-4766-8fea-898b9ea0c3fc@nutanix.com>
Date: Tue, 9 Sep 2025 16:33:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] vfio: improve use of QOM and coding guidelines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <999058e5-747f-487f-abc6-4ab29cfbb9f7@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <999058e5-747f-487f-abc6-4ab29cfbb9f7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR08CA0007.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 372db5e5-f5b3-4ef3-b8c1-08ddefb64886
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3RSeFY4bGVvWDE1WkkrNE9aRTNKTkcyRElQdHRweG9XZXhwdUdMTTdNRnpB?=
 =?utf-8?B?aEtnTEpEQzVRYWY4RU00NmtHa3JDcXhwUDZaZS9FbzdQK3ZlbHRkLzlrRWVE?=
 =?utf-8?B?dmphOS9RTlJFdWdjU3g3OEprRmlUTVNZcUxXTUZ4ZE1VcFF2bjIxaGlNd0oy?=
 =?utf-8?B?TnFEUUxrVGVSQjlzb1FnWVhJV1dWOXNUR2k5eVZOMkIxSTNvUnV1TFVnWUM0?=
 =?utf-8?B?YjBVVG9zODFORy9wU1owZXJzM2FON1J3aGloeHdJUi9qbkpiOGlTQk1EVHlj?=
 =?utf-8?B?Y1hEbythNjNONmVYK3pzN3QrQk1SbVFjS2h5L1dmUk0veXhGUGcyRW5BWFZo?=
 =?utf-8?B?OVdwNTlCM1hlVFh3WldjV2NJR2QvNmJjTk4zeGFKL3BOQUxVS09uQmw1a0dJ?=
 =?utf-8?B?bmlNdnVsYTg4a0UxdzBuYmhDdGNDL1VpRUNEazdQQjFYdmVrZ1ZTQ2xKdm4x?=
 =?utf-8?B?RjlJUkREN1ZRam8rVSsrTnFLTHI0M004eEtXWldFRGFDeUphYi9pUTRqWUFN?=
 =?utf-8?B?RzkzcTVzZEs4dnIzaDB2VytUUTAydGc1Ym80NlhGTTIyazdKdHFTU0xNbHFo?=
 =?utf-8?B?ZTUva0R6b1ZTNWc4b1lmbGFyUGZrbzF5MElCMC9YOHY0KzZPaEZ6bzlRT3Iz?=
 =?utf-8?B?enU2WG9kazNBVk4wMnBFVG5LSnJtd0VmOUZiM1RkMDhENmU4eDVHZ2l1ekpz?=
 =?utf-8?B?ZVlWZmd4TnBxakMrVFI0TzhIYlNVMzZHdEIrTk1pUDJwYWk0aXUxM1dOb3JU?=
 =?utf-8?B?MHFXTS9DSjN3OTU5aVRhejNVZCtVdHpCWVB6d3dJN3U5UmRqVU5ZbzVLWG9H?=
 =?utf-8?B?T25Ld09MV2JwSUc1WWpYc1lWcUI0Q0I5RTgySzFkZmF6bVM0TGF0Z1duZndz?=
 =?utf-8?B?YnNRYWtBMnVQeUszN3k5TmNiL1Y0SmY0NFBIaXlkWkFOWFBNNHcxdFc4d09u?=
 =?utf-8?B?M1IrY0RqMGVPZ1JOaklMVXZvaFlVL2tkS1c3N1AvZ3UyTmlEVFFncnZBK2RD?=
 =?utf-8?B?V1R1MHQyWUFFeUsxK1VYY29Cb1F0VW0wd2paMXlwaGY5NEw3Yi9DQjNiQnIw?=
 =?utf-8?B?ZkcxUURwVnd4c2pvY1V3Ylh4ZDBNSERoRzgyd3FwOC9WYTRlL2szNDJpb0tU?=
 =?utf-8?B?dy9zZC9kVWwzdVo2ODhvK0tBZVc3UDhReFlEOVNObkVzb3NYb3ZnMmZwM2tT?=
 =?utf-8?B?QW9HdzVDNUlwbFFDOU1lYXQ5OFVlVm12eDBmbHpyc0c2QTF6eklPbGNNSzY0?=
 =?utf-8?B?TU80SmVnK3ppU2NUM3h3V0tYN0tRUEtycXQvcktFQVpKYmpqTWR2clJDcUFK?=
 =?utf-8?B?NEg2TTRYQzVMNGNYMzVoSjRFd1dnc1AvSmNVSHMwK1QwM3c2VEdVeDVZUkw0?=
 =?utf-8?B?L096d2srY2VrK3pwUkFMZ3R3U1J5R3hWM1FvU1pFUlB4WlJyczBmUkxpODQ1?=
 =?utf-8?B?aGxnbUVsdFBQdkpTL0RCYm5EY3lneW5RcHVpYnBrRkhPNTluZFNHZWo1THFM?=
 =?utf-8?B?VmRWMkM3S1ZyNWxxZ2Y5dGRzdVJiOURNejdwbS9WK2VwM1hzL05nOWdVZ3c3?=
 =?utf-8?B?U0ZpM2libDFRV2Qyek5iZGI2dUtFK1diRW1lS3hONVl2TGVNWVFiNVVuZmRF?=
 =?utf-8?B?dUVDbEwyVURoSXk5d0RSdXBadEVpT05MNXBFUkdWWERaek1MNGxOQThObDVD?=
 =?utf-8?B?QnBnRTN1SkIyRnlrTURyTlZmeDYzSmN6OHlyb3RFUWNnYUFxWXZDZnZKSG1I?=
 =?utf-8?B?Rk1MMTl6R20wOEhKR3lhbXcyMVczc0pQcjNiOEF2SzlFa01VdTZtYXI5STR0?=
 =?utf-8?B?WjVwaWgzRzZZK0tNZDZjM0NwN1lyU1ErTHo2akdOTTNSNFFPRTJqK3RuU2V2?=
 =?utf-8?B?RkwzTEczb3lJNHoveTFUNlNLdjEwQjFsY21YRFh2QlJIMFRZVXhQK0pNdko4?=
 =?utf-8?B?WXIrMzIwbFdtMjVBZzFjR2tVeU5EOWlPdHRkRVV3L3M2RDM0ZVJaYk81T1Ja?=
 =?utf-8?B?YWJlOXZBbHlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7416014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9vSm9qZldCZXd1WDJXdXZ1T1lwbmprQUd5cWdZNkVQc0dtcERKRXZ2Vzln?=
 =?utf-8?B?S3pWOFFqSmtzQ1RxMHVRSXAzeng2UEg0UDU3bkRyOGpZUHFac3ZIUVAzaDNU?=
 =?utf-8?B?WVBpTUNLelFrTWpIUXo1MUFIdmJhWUEyK1llY0hqb01CR3NEdDExYWJ1MjZF?=
 =?utf-8?B?UnhYdzN6am45T1ZJaTJ1bitlelFWRlZkNnFrblcwVmpyQ3NGZHBTVnd2S1c3?=
 =?utf-8?B?SzN5Z2JkL3VsdXc0djJUMUlQUkVQNk1EUmZLNklJM3RJelN0OExBbkM5MFVC?=
 =?utf-8?B?Nms4TzU1UWNyWEJsbmZsU2dmQzAvK1pzN01NV1BCZ0QrWTI4M2RHWlRIZldZ?=
 =?utf-8?B?K2I2MGYwVmdiQVBiL3JrZWdReUhVR3kxMnN3d3Z3THZRN2xCang0azRNQjhk?=
 =?utf-8?B?OW5YZ0MwZUNxNm1KYk1xcE1FTVdVaVZpMTl5emRsK2NKS0NIVGVBa0hWc1Z4?=
 =?utf-8?B?WWNJdFlJMmgxZkNwd0lhVm1STlozc0JhUzFRMFJFQkZzZldrbmVhTFM0a0ZH?=
 =?utf-8?B?dy9UQ0Q4aE9iYjlad3dGOEdhU01tTUQxWTRvRmtpUEdrYWM5SGFmc1hBK0NW?=
 =?utf-8?B?UkkzOHlvSXhQa1RuOEJzaTAyV2FjUjJ0SVpLak5wT1JsTkJPa3QrZDh4L0Nw?=
 =?utf-8?B?UCtpMWtzNnFnTC9HMGlQVXV2YThhWW9QK3E1RWpzVzlEZENYUzFEamRreWpk?=
 =?utf-8?B?cjdOaFByNEZDZ25RS1FGQ0kraS9JalU4RHUySzU5M285a0NvTzZ2RmJSSmYv?=
 =?utf-8?B?VnoxSXVOeTZyb2QzTlRRbUFsSSs3MWlzOW83Z2Fmd29SKzQ4c3RaSEszaVhH?=
 =?utf-8?B?c1BkWFFRdUUxQVdGZDlJdlZqejFacXBYVGM1cDlEeVpmVlF2b2VNamJzS0g2?=
 =?utf-8?B?Vy8rK1g4VnRqRDBJRGljTEo4Y2JuZXN0Smg1UFo0TTlnam1Yc0Y1c1NJVG5o?=
 =?utf-8?B?d3lhRTk0SUo3czBpVWt6c0Y0cnZxckVGN0RtSGxLYWpzZDFLejZLTjFQZUYz?=
 =?utf-8?B?Ynl2WEVFSUJpMHBVRERjaHVrN21saXB6a3ZnZTM2NEFVcUIvbUdXbndlY0VX?=
 =?utf-8?B?U2lvckVZOXRabVdiYk9tSmU5MGtsYmp4MEZ2Q0hLTmx5Mmx6WklnTk0wSEVD?=
 =?utf-8?B?bTZLWFExN1FiRVpjSlEyZjNYTXh3TDFDOCtrR1MvcVE5RFNqd0J3cjhCbHV2?=
 =?utf-8?B?c2NVVUxFYmR1Z3ppaGYydmJ0R1dPSjU1OEhVU0JNYk9nUks4dHdHNGlWd29h?=
 =?utf-8?B?WVdaZVhocWVkeWV4V09qaVQvZGtXR1IyTHZhR2x1KzRUQXBIN2g5VzhLV3Z5?=
 =?utf-8?B?YjhLUG4vcVg1OVYwZVhTNGs5eDFjc1g1Tll1ekUrZnJXNU8yZExzZ0tkSnhH?=
 =?utf-8?B?Vm9wcFZtTGJodE1lbE9uMHFDYTc5ekFMdlVOTjNLZHg3aHYzOUJRYWpQVEdk?=
 =?utf-8?B?TVlNSmlubmdDeW1NUGQrVldHV2UyYU9CMGx5b0N2R1AvUGM3VEFZNU1uNHg0?=
 =?utf-8?B?anZVOTViY3FhQjI0WHpja2Jab1Y0R1JNNEI1Z0xia1hSOTNnNFBkVGhHbG4y?=
 =?utf-8?B?a0NDTFp2UlpXQit3YmNneEYwQzJacmRJOFk5cHAwbERtZnFvMEQxSUJKb3hl?=
 =?utf-8?B?VHMrMkEzTHc0TVh1ZFlJbzdROGxpU2xtbHRFSmdIVWVPelVUcVh5dHNHSEl4?=
 =?utf-8?B?RHdUVXBreGhLTmp1WjVFQzU0OVBnNzQ2Y0JwdE83UjhsMWw4eFRqTVczTFRK?=
 =?utf-8?B?NGJobWNkUXRYeDFGK1Z5VzA2RHptWVdLK3h5SjlKc3gvQWdzOWs4MmhWZlJl?=
 =?utf-8?B?bUprRVROQzJ1ZnBocngwa1o2ejQ0NWwxYnh0bXVnTkpjYjQ5MW5kQW1Oc2x4?=
 =?utf-8?B?QXVreC9YSGU3SjJDeUt0eDFTL1BIdEhwOGdHcWE3ZExzU1hJQzVpbXhoOWlu?=
 =?utf-8?B?RVk1WWtSVTU0OEtZVG5oOXBNYmtubXU0VzdVcUpqdVVUWlBiaXBIMDIyTEdr?=
 =?utf-8?B?NDRpNnpUNjEzOVlqWDlDa3dlVEpucDJwL0F1QU9GZkVYMnJwV05Mem82NGsw?=
 =?utf-8?B?SmxxY2kyUEhoZitsSG1Kd2dIWk5rNDJHeDVJQmRSeXRQZWRMWnlpbFVZeWpQ?=
 =?utf-8?B?M2xseE5nVGFWVEI1YW9XWXZ0OWE3eGFYYUdEcml0SzZ1T0tuMzBSSDMyYzB3?=
 =?utf-8?B?YlVYWGRUWE1PZmtMOWJvWHhya1ZiY0syb0RYczhFN1FxVVlKdUFOVDQzbElw?=
 =?utf-8?B?VHFVSnVBbnkzZzN6bjJ5RjVYYzR3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372db5e5-f5b3-4ef3-b8c1-08ddefb64886
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:33:53.8603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXe0z5nXihYfgjUorVOc5nFKjYs95VEp+lRZkF2484oW8rPXY6xURmsr/9NcgtbXF6HlgmPMaMbS6bukjV9dIuynCW1Ay8Xi0BvYqnI9TFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7614
X-Authority-Analysis: v=2.4 cv=WcQMa1hX c=1 sm=1 tr=0 ts=68c048e5 cx=c_pps
 a=2oCwWocI8GQpc5B8VATfjA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=ClRjCh_gx0gRYdYNi_wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qrt67ipZfaa0KJjfg3f5VEjnynif9Mb0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDE1MyBTYWx0ZWRfX8PIKGoOpzvsu
 C1hqiifXZy3yus44QhkXleiLRJVpzTpHpMsBL1lZChwDroN0YlhPWfobPiavgy8YI20K5pVHB8W
 61wifEnQzjAuy3t6PfrriJaW1osHCyd2sV8xQAKl6kOm4uAO2uQ9EssDvWznI6lrXoLcGDZQHHK
 Tagp99tLJFet0fP/c1BYHZ3y01vv5AOx3HWz1wyCzkDU9U5W0300/aNeOMhat2EaNeB905IYlpo
 vF5A8OFdVuUpt1fmoDWQZSOrC7ntb08cZKZ2BV0MZDcJSk/MMUuvdYy8xXahCPCDVKWZlNoZi1g
 LBANwaw+NhPPIeThwwEfDLjDB1qSLA4vtSnzzdk5YlszVZQ7j+CjRDsRcQGjQg=
X-Proofpoint-GUID: qrt67ipZfaa0KJjfg3f5VEjnynif9Mb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 08/09/2025 15:19, Cédric Le Goater wrote:

> On 7/15/25 11:25, Mark Cave-Ayland wrote:
>> This series attempts to improve use of QOM within the vfio subsystem 
>> which
>> appears to have been added at a later date. It's mostly mechanical 
>> changes
>> that do the following:
>>
>>    1) Format the QOM structs per our coding guidelines
>>
>>    2) Ensure the parent object is called parent_obj
>>
>>    3) Use QOM casts to access the parent object, instead of accessing
>>       the parent struct member directly
>>
>> The benefits of this are that the QOM casts included type checking to 
>> help
>> ensure the right object is being passed into the cast, and it also 
>> becomes
>> much easier to infer the class hierarchy from reading the code.
>>
>> Having produced this series, it feels to me that the readability could be
>> further improved by renaming the structs as follows:
>>
>>     VFIOContainer     -> VFIOLegacyContainer
>>     VFIOContainerBase -> VFIOContainer
>>
>> However I have left this for now given how close that we are to freeze.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>
>>
>> Mark Cave-Ayland (22):
>>    vfio/vfio-container-base.h: update VFIOContainerBase declaration
>>    vfio/vfio-container.h: update VFIOContainer declaration
>>    hw/vfio/cpr-legacy.c: use QOM casts where appropriate
>>    hw/vfio/container.c: use QOM casts where appropriate
>>    ppc/spapr_pci_vfio.c: use QOM casts where appropriate
>>    vfio/spapr.c: use QOM casts where appropriate
>>    vfio/vfio-container.h: rename VFIOContainer bcontainer field to
>>      parent_obj
>>    vfio-user/container.h: update VFIOUserContainer declaration
>>    vfio/container.c: use QOM casts where appropriate
>>    vfio-user/container.h: rename VFIOUserContainer bcontainer field to
>>      parent_obj
>>    vfio-user/pci.c: update VFIOUserPCIDevice declaration
>>    vfio-user/pci.c: use QOM casts where appropriate
>>    vfio-user/pci.c: rename VFIOUserPCIDevice device field to parent_obj
>>    vfio/pci.h: update VFIOPCIDevice declaration
>>    vfio/pci.h: use QOM casts where appropriate
>>    vfio/pci.c: use QOM casts where appropriate
>>    vfio/pci-quirks.c: use QOM casts where appropriate
>>    vfio/cpr.c: use QOM casts where appropriate
>>    vfio/igd.c: use QOM casts where appropriate
>>    vfio-user/pci.c: use QOM casts where appropriate
>>    s390x/s390-pci-vfio.c: use QOM casts where appropriate
>>    vfio/pci.h: rename VFIOPCIDevice pdev field to parent_obj
>>
>>   hw/ppc/spapr_pci_vfio.c               |   2 +-
>>   hw/s390x/s390-pci-vfio.c              |  14 +-
>>   hw/vfio-user/container.c              |  26 ++--
>>   hw/vfio-user/container.h              |   7 +-
>>   hw/vfio-user/pci.c                    |  16 +-
>>   hw/vfio/container.c                   |  31 ++--
>>   hw/vfio/cpr-legacy.c                  |  14 +-
>>   hw/vfio/cpr.c                         |  10 +-
>>   hw/vfio/igd.c                         |  38 ++---
>>   hw/vfio/pci-quirks.c                  |  48 +++---
>>   hw/vfio/pci.c                         | 206 +++++++++++++++-----------
>>   hw/vfio/pci.h                         |   5 +-
>>   hw/vfio/spapr.c                       |  16 +-
>>   include/hw/vfio/vfio-container-base.h |  13 +-
>>   include/hw/vfio/vfio-container.h      |   7 +-
>>   15 files changed, 249 insertions(+), 204 deletions(-)
>>
> 
> I did some tests with an IGB device and didn't see any performance
> regression.
> 
> Applied to vfio-next.

That's great news! Thanks for doing a performance check with this 
series, I'm currently investigating what environments are available here 
internally for performance testing.

> Thanks,
> 
> C.


ATB,

Mark.


