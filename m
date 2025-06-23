Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11E0C7EE39
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjoS-0007NT-I6; Mon, 23 Jun 2025 12:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uTjoR-0007NI-MA
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:14:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uTjoP-00020F-Td
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:14:27 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NAkBGT032068;
 Mon, 23 Jun 2025 09:14:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EfZk8WZQwwY/b8alUH6Pr2eX2aivtNqGfCF7KpHjZ
 y4=; b=ZcANBRKPSpFNS9G8BlvpKatwPyfPA1l+Tdy4PLgTB9hkHVmscihjXH6FY
 TiYqZ6PKSbcgvm9SH8EWljanfiex1LJ6e2HxAdn8UyZ9D6p81l3Me2/HZRtax1CC
 rAc4lEkCuqw0egtXDv3sjJ0q2cVWiIMpDKSzz2A00KgCHyrhowj94MTtPcgphHPa
 Z6YbPtf588gdx/GfrBZquDoE3JE6cYPz+MzhrQc6Fg2r0L37/5EqhJ1N+DLyT02U
 xsmha7zmF/7XVtv5pYX4MJ+15ZsMVaevq9mLfQsFq7yHv6ir8NWefm3AFs274HRr
 F2gNPeeF9sSucigCOpGIcFWip/gzg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022118.outbound.protection.outlook.com [52.101.43.118])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47dt9c3u7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 09:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jS5G40oPNXjLNU0N3TwTfsLRH7B/N/LY0EHZm5wYDq3qZ1H16eBGA3hRuv/e6P0BjLkz3ZsZFtd7Rk8z9OM0RECCtZC5tiXL1gHnNtTvayBh/GSy12gKDkrIscdWs9SqIl/Mq0LkE0ha5aPPzRPp9gKJo8Ww6NDpsFye8lG0hYi8Nb5T0azAk0VlS8shxsk1zZubHA5wkKHy9KrWE+H3j7dX15nPWaVPztaCNDd2MgTC2SWUqSu9PazbP6gdMmWRd9sKVozuBPuUS/MpbrDuULtt5xDcc9qSAU8RrvIaPf8I8W1QKkPlLhEmVHWmGDRJEn0GNx5JpHUCfGObUYOHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfZk8WZQwwY/b8alUH6Pr2eX2aivtNqGfCF7KpHjZy4=;
 b=k8I9y9QMv4VpLcMzNjLiBmz4m6OIej1T+oUkrJXeRgT1TKiIkHmVzVRwS0CdcwedBR+jIgwvLbFkDTPh/AaLlDIsQ4bPd856XLBH4Ew2+EfsSdTxa7buiGC8B/ExVCjN7ah0UCkfuyuaC+PyYdBV0WcBNUCpT42UfGm6en2CE6SrLBrf6E0VlFzWmfGyY7l/VQs7f8KNkVPhuVai9a+V5brbX+2BBQlk+CPT02Fe2YGBjzWznhO9zrWTEbfOfGBdtQUTztA++Pnn0GQCLhFe7YgRD/UQCV4rf692zUztHpwv1ezogcHiFtBWdiK3FueXCkriEaNA+OR4BX7AbaZX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfZk8WZQwwY/b8alUH6Pr2eX2aivtNqGfCF7KpHjZy4=;
 b=AMCYWFchqFjzORS+TvCEyOPr+ba23m1hrWJufRpBXGXd8v1iKQ2k/tvmrYQ48LzRUJQglK2PhwIpzTJ0JvMWo+qlMsra0DU4ivJEFlB06MXcFq+3RzIAhtQbyxtsEeNAC3xVlwWLPNSauLY3dFnevKYD8dyE+hbx6W4yxlKRcoo1kASPz18+ZiJCeJ+gYOAOBWfccXK/ZMPMhsy7/F6+HEIBPsItUoY/HwZI76cqWCxue5fb/qoQ1IjwAoVcW93swew9g5jlooVPvTzGefGAkxo5hLLRQUxIITWSl3Bv11va46jlYaMerWy8TiWkmuN2GyCwmldIHltr2bTEhfkEFA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV3PR02MB10641.namprd02.prod.outlook.com (2603:10b6:408:287::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 16:14:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8857.021; Mon, 23 Jun 2025
 16:14:20 +0000
Message-ID: <76e34011-4772-45e2-a35f-612b727c38ff@nutanix.com>
Date: Mon, 23 Jun 2025 17:14:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/23] vfio-user client
To: John Levon <john.levon@nutanix.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <b6be1ca0-0ba0-4691-8a2c-f7d3ddc2f85e@redhat.com> <aErh-v3SfFo-2Br0@lent>
 <c18de4a2-63d0-4ad2-9547-fe8bc221a887@redhat.com>
 <3b311f79-fc87-4b1b-8ba5-728d696a14b3@nutanix.com>
 <65274f7d-59ee-407e-a57f-dbf9e47890b5@redhat.com> <aFakD1PqE6Ew8whG@lent>
 <e27a3a2f-9277-490b-a8ba-22202bb57c70@redhat.com> <aFkSKX5Z_a_rND6_@lent>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aFkSKX5Z_a_rND6_@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0140.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::45) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV3PR02MB10641:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b4079d-c59d-4155-5ebe-08ddb27102ad
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2QvS0dLWDhFV3Bvc1hoRlY5YURXNDlNbFR2MnIzRnh6Ti9ZcU9RYlpaemhw?=
 =?utf-8?B?bzFhL1N5MnRybEpnQm9TbXpoeXRMcXh6cXhUM0JLampSTTVkcFFHU3o5V29t?=
 =?utf-8?B?bmY0ZUx4cHdFaWZWQnFHMkZFUFFEY280eW9ITktJRzlLLzd0Nk4yTG03amVT?=
 =?utf-8?B?allyZWhQTG1KWlBvWHF2c2xoQXora0dIdHREVG9WZmhrQTliaVQyaXo0dVpv?=
 =?utf-8?B?M2R5c3hVeUJQRDZ0U0V3NlJQTURHT2Q5V3k3SzJqNDFRTGtWUG9xV2Yya2ts?=
 =?utf-8?B?NXNPZ1hNeEEzR3FpTG01Q1BVSnFzY3ByTEVVejRlZUQyaC9lQ1lydHE0ZVhs?=
 =?utf-8?B?endOZHNzQzdXS3VLSVdTTE5kbEtKcW9iSHJtWVlVdFI0Sm5UK0l2aUx5Wld1?=
 =?utf-8?B?Tm1oaUl4bXc5azhiSUREaUVISFdxem9MSzFBL2pKTitqdFlmNHE4WGNkdnBr?=
 =?utf-8?B?UlFKQktIZUJ5UUJrZ2k2QXY0TzVFWXp4eFYybS9SL1hJTE9qeVlwbW53bHNG?=
 =?utf-8?B?NnpMNEEzTWdGbGZwNHJVMitVY2VCV1I4cVdnL2tEcFJtR1BFTk1BV1Vvd21H?=
 =?utf-8?B?dkRqTTBKRStEUGFnN2hjYmd2aUR4S1JTSDkxZXY1Rm9pYit1T1VWNEtDMWo3?=
 =?utf-8?B?S1QrZVZoWHZUMk9zKzZDQWtjb1oxNDE1WjA2SUdQR0toejAwVUZjdFlsWmhi?=
 =?utf-8?B?UnRHS2NIQ0xwVkJ6TlNFdXpyWldpeGtQS1V6WkZlcmMwMkQ2aFYxVnZWQzVY?=
 =?utf-8?B?MnpPdGFwWHhpcmlLQkVtYU9nWW1IWEErOTJvRCtmNHltZ3FXbzR0SFY2T0l4?=
 =?utf-8?B?VnR4RjdCTjMxR2FaK2JHUVJ5MzFORWxiWkJNbWczVzhLbnMxTzZRbXkrTjRa?=
 =?utf-8?B?TmlubTQ1dWwvY2twckYvQlVMMkJxR002V1lRa2FvY0NsYlVWR0krSHNuTTJ1?=
 =?utf-8?B?Z3JKQ0tMZFVwY1BXMmNyS3cweURtY0NlSEk1WDRUQU8wYVlQZFJwUWYvTHhV?=
 =?utf-8?B?NW44cGhTak9YSDdGTUxJY1hEZENBa2txaktMUEd1MzY3YXAxZXFVZG1tSlZl?=
 =?utf-8?B?cGQwRUZYb3FaaWJnN0tlVktCU2xscEpLMzlFRHpqVHkrZ3BQQVVnYlV0alNX?=
 =?utf-8?B?emVvRUcwek9CZGlaVlhxcVJJVnZsL3VCbGVqR3doYUhSM3lRVUtQMExKaXNQ?=
 =?utf-8?B?TTcwK2F2c2h3dU5jQmlpb3lhRTdZelZ1WWdNcVdaUXhoWFdUR2haL2VrOXJy?=
 =?utf-8?B?VFFFYm56NFhSU0FMMkdSU1V5b0JuQWFMMHhjbm8raG1rdWY1M2Y3cHZGTlpP?=
 =?utf-8?B?UkRGVmhuZFhhcHd0eHRKRFdjSk11a3hONjQwc2ZiWXN2cFdHRUZpUlVNVlRX?=
 =?utf-8?B?OVVrbnBTSEVtazk3WFlNa3h3NXUwaDh0S1N1T2ZSY0JtYTg1UFdBc1dpK0Rz?=
 =?utf-8?B?dVRKL0ltYW9sQkFPc09OV1YxdjAyZW1oNG5EV3NCUTZEZjhYQVhkYytJc1Jk?=
 =?utf-8?B?QjNQSVVNMjcxTUpicDdVYTY3KzZreFpYTmlTZGpURnIrUjFLczN4bmRPTW1U?=
 =?utf-8?B?T2l4TXk4Rm5sVU5aMnV3dTdZdzhVcHY3Y2dzNTd2eUhIQnRRd1ZQZUYyZHBp?=
 =?utf-8?B?UXczVkluclQvaG1jaEhkdGo0NkJVQ0tEdENVQVhDbXJMSzFIWWVnR3F2RG1y?=
 =?utf-8?B?S0JMNUN4UkFzM0MrY0JzdFhoRU5ZdnNUU1gzeEUvL3FKY0JPcGJyaVhNMTNq?=
 =?utf-8?B?eUNoTjFHQ2ZJeEN2OFNZOVhIMmcreldYRUNGV2gzYkc1Qjd3ZGtJU3lYKzZw?=
 =?utf-8?B?aWhTN1VVaFlUVHRDb0x5TnVxcDIvcHRiNVlqRlZ2TUhTU3FRMHFOWEpsWHJ1?=
 =?utf-8?B?Z1JxQ3grbmVxRytWeWE3amFTd3BwcndtNTBiNGdaN2RXY2Y1T280VGtOSzFq?=
 =?utf-8?Q?uxRAu67keG0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0U4b0h2b2VOOVNlczV4K0xTL3lVMTl0Ulk1Q2ZNakI5eWVRamV3NzBYMlR4?=
 =?utf-8?B?U2ZKZkREbU0xZ1h2ejhVcXEyQldLamY0SEtrYXg3bk13T3pVODNuc0ZicERQ?=
 =?utf-8?B?bEVPVjV4VCtyeG1IRTN5c2VsU09UWXJtZ0FLZnlLS3Nvd0creFZSWDdwSHha?=
 =?utf-8?B?d1E1bjdnSzRacm4yNm51anYwdnlPbkhnRVEvcXE2aWhscE5va2JoN1oyQ2o4?=
 =?utf-8?B?MHlaOVFZSEVpSFJKaWxOdnR4QlYwR3hPL3dEazhpMGwvR3hOa2tGcUhSNzBk?=
 =?utf-8?B?WDlJdHhsMzdCYmppbEkrcUJHUFJydjRmMEVxM0tEdDRJVUYxd2lJNjNqY24r?=
 =?utf-8?B?Tm1DcGcyQTZWU1lXTWQwaURpNVFSUjdYbkVVMlhpbXhQdFZRZnFiVW5qWHo3?=
 =?utf-8?B?dFc1M3VpRHNZeUJLajluL2NvK21CMFdMNDA1WnB1RVRidXBVRW0yT3o5NzQr?=
 =?utf-8?B?bGw3VXJveC84NUxhaDEyanJWeDJZTVM4UnhRTlBOTVRQWXBhVmZXMFV5Z01D?=
 =?utf-8?B?MzlNU3A2bnQ0RVQzVEY4a2pPajZXNi83RUVWTTRFTkZHMTRTMEw3WWtPRkRZ?=
 =?utf-8?B?V2Q2YlcyMjcwWXVHbHVIREkrWW9iclZ4QXJkOUdMVlRodjFWeTZBNjRLS2g4?=
 =?utf-8?B?ajdhVm5FSmZ6ajIzT2k5ZzRLbXJoYXNSUUQvTk5TUVdlTE9aSU5iU1ZXWUJp?=
 =?utf-8?B?Zk96NmRBdnVyZm1nS0tVSnZBYkFZNFg3a2J1MTBGZWVIWTNZN2U0bFovdGJm?=
 =?utf-8?B?eHprSUZSUkcwQlRCR0Z0cTV3TUZIZVJzWWdhUGY3endjRjRBdG5qRG9uVzht?=
 =?utf-8?B?cE1rZGl1VldZM2hVN3RvenRVUjF6VFJNVm1KVEMyVVBoUWplRm1mVGZIV0ZN?=
 =?utf-8?B?SzJnSUIxbFFBeVJZNnJqNmQxSkhHcC9PV1hhQytKZHc1OCtGU2tac0cwb01Z?=
 =?utf-8?B?R29TRjBXMlRKTG0reUZ4N0hFOVNSSUwyay9TVEpMWEZ2SFhQdEMwWXA3U3BK?=
 =?utf-8?B?b2FiUFgvR1Vka1R6Zk5QZ3JkT0dGM201ZXJSMlR3cUd0aWQxNVZjRUc3K3BI?=
 =?utf-8?B?b2hvRy9ML0h6U05vU1E1VUt3WTB5R2swa1drTU1hZXgxdXRUb3lIYUYrMzNt?=
 =?utf-8?B?TkdDOEdURmRVZk1ldmNGd0JYd1dpZ0ZNRG5jcGZnVTB0UWh2VldiQkRlNkpS?=
 =?utf-8?B?N2tSdjB4Q2dZY01PaXJvdzczWmVwT1N3TE0vbVE3R2k5c3ZSeks4QVpCYi9F?=
 =?utf-8?B?MzAya3NVV1l4bU5GczFJelVJRnV0RXZ2NVhaa0ZFa1JsMlJOc1p0bEc4aUNi?=
 =?utf-8?B?elBrSno3ZE5RTGNxMlZ0K2l5eTlWa1Z5aTREeVJ6N1RBMTNlMi9YYTF2WElC?=
 =?utf-8?B?aE9YQ2t4dGpkRXAxODlYMTFZcERBaHpVNnRjc1Jqc2RBcVdvYXM1c3lmeUk5?=
 =?utf-8?B?UVR2OStrSDQyd0djY1VuSEdraGxzMGhiazVTWFJUY0J2MjVxU3VUWTA5VXNw?=
 =?utf-8?B?aVpwUzg2SzhSRTJGWnU5cmFEa25kTXhpblU4NnlRdkRPcmdCSlAyamxLemxX?=
 =?utf-8?B?WHhHdVVMOGc2YXBwS0JsVFMxOW5WcnErWWtLT1p1MUV6WkNIR0owQTJBUzVp?=
 =?utf-8?B?dDBTN3l1TUk0SzIwdklSN2QvcEp2Ry8ycDd6cytqYVQ1SkJCVkFoeitMNkcx?=
 =?utf-8?B?K3pSOXkyUWZYMDVUOUFpZ3JNbGxtaTRxenphYmc0dE9sK215TUxjS1krc1BT?=
 =?utf-8?B?RldkODNJRE5TYlY1QzdtMmtpdDNIa014T1BXbXYrTnpKb040aHQ1eTVtUG8r?=
 =?utf-8?B?VGVaSHZGM0RkeXdaaE9BUFg0NWI3VEE5ZkFYU0cyTEFMQjB5S2ZGRjRoclRt?=
 =?utf-8?B?YnlnU1lzemU3UVpGa3F5R2UzQTdOUUtsdkhRalAvN1VoeXpSeE1JaVQrYno0?=
 =?utf-8?B?S0xQQkM5U00vZmZsWE5GNm1VazFPRzNqRjZ4RW9vMks0WVR6SXJsdEJsa1A4?=
 =?utf-8?B?MWFEb0hYNFo0QnNsRG5sT0tDQ1VjRHVMTjVoV0c0TGNRZTBzSFZpYy9kc1Qv?=
 =?utf-8?B?MG1ER1pMSDlmK2hGU05RdWpXZzMxQXNuSGY1THo5RWI2RkZYV29XTksxL1hz?=
 =?utf-8?B?QUo3ZVRaSWlvOHJCeWw1eHVIUFFNOW5NcnlyN3hJT1FSbHdlSzhURFp1T285?=
 =?utf-8?B?SklOZTR4Y0gzMzBZeksycWdaRWswbVRQY2hPUGtiNm12QmdBRUJseGZGUS9S?=
 =?utf-8?B?NFZZejBIaDgxWkV1OVFka25NU1JnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b4079d-c59d-4155-5ebe-08ddb27102ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:14:20.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOAey5W75pKLRzghPyuU2TDUuoqTi1ZAWS2zZqilDij+oj0aXqKfIDpIVZ85o6S0CXi/tJf/k2bLzy11mMAIZ2ApROMHNPFDp+58hlGgglE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10641
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5OCBTYWx0ZWRfX3bmauGQ+gKkW
 It7f43lItzpgPjEZbGQtG73cF5hsr15Na355u8ML3lVSEnIvlfPEPW7kyPHMvOA2GEhoPDUYilf
 Tz/KMY0XIdn6cbSuFLUyaXxSndGeGwJne2FixxePVfjd3Yl6WkejF8yXHJ+3jZI+Lny08tKjihP
 Fgkm08pOUoYYuZFwdTmRKFJpgTwxFthGZSIDUQnI+08FtJFF0HhHExjbM5CNtmhf1U7PKH0G3JT
 lnkOvShRbClGoKbupWFXXP5E7HiszkmHVKgC7HeTiPxOXeqxrilcU1uWK40WrBi9+4bYXYnLbGa
 MuE7x38vV/ecLmMvRKBcIcf7yAQrIv07mLlruODubu2SoPs1DxyJpo9gjXeMUMG2MoqeaLb2pQU
 OXY187Ai1VuAUDRtgapbLEfOj8OV0/2gU5mXgEECgZ+plUG4fJuhJISUoADHnm4Alnb8C5+c
X-Proofpoint-ORIG-GUID: crzv8z9Y_i-0pPxnFY5rfU9GvKD0I89-
X-Authority-Analysis: v=2.4 cv=MeVsu4/f c=1 sm=1 tr=0 ts=68597d5f cx=c_pps
 a=IM9eEZCEoeE/lAIW3pMUqA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=l2Fv0bN1wfH8xLIJA2AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: crzv8z9Y_i-0pPxnFY5rfU9GvKD0I89-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/06/2025 09:36, John Levon wrote:

> On Sun, Jun 22, 2025 at 02:57:57PM +0200, Cédric Le Goater wrote:
> 
>> PCI enumeration work but the kernel module won't load on ubuntu 24.04
> 
> Sorry, I forgot - there's a kernel bug in the Ubuntu LTS kernel for this driver.
> Mark has a fix - Mark, can you share?

I did have a bit of a dig into this a few weeks ago, and I think there 
are at least 2 bugs related to recent changes to the kernel regmap code. 
I was able to persuade the module to load with a couple of hacks, but I 
think there was still something else required to get the basic test up 
and running...


ATB,

Mark.


