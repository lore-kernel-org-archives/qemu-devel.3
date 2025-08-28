Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868FEC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 08:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urYCX-0003g4-QM; Thu, 28 Aug 2025 04:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urYCV-0003fG-ES
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:41:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urYCS-00009x-Oh
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:41:43 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S0C5mE3582237; Thu, 28 Aug 2025 01:41:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1U5QrqG+v8PBUXPMyBap1xnYolXpCWcS3ybZPtd1A
 hY=; b=i7DDEoDUCB2FB9IQhEVlLDci3wNTLQh0kgbctFyWN3kRFl3cxoVmyRQIP
 BwP9U8cXh4qz+7RvqIkq/upq27/cQvppL2yE0c52dUT2hdGMIC0j6d9GFgeKkYMt
 xM32e+eOa437ZNjEdBY+dVIKGN3XJeSM/wjtX62WB6kEsyfPKhbYPsLfYRtngvxF
 LV/SM+NDlynwmzXoHWNGeWdQxBNjAr8bss5vYGBu7aFYtRo84HOwavA+tJoIo5Mf
 Rv4HTzhGvecS7Fog5HrlmNnvT7NmYHfeWVAgSkFrxRbk703spyTtxCXyervIBwvy
 SGvh3BigqI3TcF8h1KNxowMAuz2VQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11023143.outbound.protection.outlook.com [52.101.54.143])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48tcc30vbf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 01:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIhDx9se+RlmQL1zfMcB+/vAN89A/LuNMk8yxB8jnrb2ju06iUNtHACNjsVusFYw45RWnocMDAErd3y/HxOw06GtAw38Ri5sG15FZqYscCWg+I0ny2O9yBAQssq4CLgWu5Y4WVhou+9Ji9IPjgkqegaocICEMuKmysqewg6sgVEcpbBuXyuxe33LndsTiwcyf9rmbEFEpnm/qqdaDJbCv9f/Pi3YvzMqqgps3pTLXqGyRWhpNtuNHt3OdghFX3tR3Jlm4N9Yd67cJ++wLhh5ETrpPQP0Cj1jbjLNB5VBa8ARIDP3usQjGcPZSPz1MJfpuNaHW1zJSMB8vKs1JQlKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U5QrqG+v8PBUXPMyBap1xnYolXpCWcS3ybZPtd1AhY=;
 b=Mhszwwf5XR5vkZ/kH+oytlC9Iuq52SJP0RWQL9G3E0OkjeEk/Cnzu8fX89kvIAg4CeHgZyDbcLjNWFPcrx1Wi5IIDbjBq0SOaUJHrcZCP26YTXqI/KEqQoapLgT/zBkEh4666rdcc0NG81E95g3tQMIhPbD7oTlWU2XSG/4ZwK/+c+j+BShe2HvEVz6ALtI9UMCDyw8xheniXRdS4kdHBmOuRvy0v0GPQyPZREtt3wAiLYFPDAQkrJS9HcvY8JWb+Q4/i/z0GQ8CXwjoD+D//O2y+cKFVBSm/MSV7JWe/h0BmNH8JcStMygz+aoNC5SkbMLJ5mM8p1ZImqMRXA0Cqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U5QrqG+v8PBUXPMyBap1xnYolXpCWcS3ybZPtd1AhY=;
 b=um87tnn8UHRt8iRXuibSaqziztZpQjTbfpEZL5RXaG6yZP+PEt2XcOmJZ6P4t8QWEOP2WO7fnWU2/Y+Nlzcc9YEVbnRPvg5z2Gyj2nMowb6iXAfmltKX3L6JIF5ADKWH+htOiAHLWy+Nt+zIeFKhF0mXr2D7TXL51o5He+DNrOrcx4lwQQT3qKS18T0oBkVuX/isrqs0MWv+MYDFkrZ3dDpegdDUC6uwkPo8wu6+boLIa4IDEjo313wdSfN4jwQNJM54HrBQ3fNszHUMKExvZ61S5gUO7CCKUSwL+8k1YAyfKFMsdZxRgA6JBxgBLv/458QQVp5uJr6dVKjkhavGUg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB7060.namprd02.prod.outlook.com (2603:10b6:a03:236::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 08:41:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 08:41:29 +0000
Message-ID: <345b5031-c8e2-42d7-b944-5341747c7349@nutanix.com>
Date: Thu, 28 Aug 2025 09:41:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-10-mark.caveayland@nutanix.com>
 <7fa8968e-c584-4441-8859-a40788067e95@intel.com>
 <fd631cee-4089-400a-a79f-0091341fec1f@nutanix.com>
Content-Language: en-US
In-Reply-To: <fd631cee-4089-400a-a79f-0091341fec1f@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: f18587d4-f7ff-43cd-9834-08dde60eaeb7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UldneklIYTVXVUZZY2RVTnBkbDM0OGl1d2lSL0JScy9jeWh5ZzRWU1JSa2Y1?=
 =?utf-8?B?WXhSVjhVK3k3OFMvaFZnOGRlY0o1OEFjK1lPTFQ5d1Zha1VlaloreWVpYjR0?=
 =?utf-8?B?NWs5d05obVk3YytadkdJMDdrSkQzanZXR1AxMjBlVXVkcUEvczVXWkdiNVVm?=
 =?utf-8?B?WWtyWXpJL2tsUzlZcU4zK0NXczdVSitQRUo1ZzYyWUN2dzhmYXAveHhXZ2dn?=
 =?utf-8?B?UWVuNkN5WHU2aUlCT3huL2xUQ1h6eG1uU0xmYkZaM1l3Zk5PMEYzZERrem9o?=
 =?utf-8?B?L0tubDZpdVRjaENvNW1tVmR2bGMvSy9sTUR3elAxZEp5TDRqckFUNlZLVU1C?=
 =?utf-8?B?OTNqYXVpVWhmYU1oR1pJZ0tzcFRzVk9tOXJhU29XYi9YR3VVK1hudFF1OTRq?=
 =?utf-8?B?MWZVVmIyVTlmU0kxYVFwWDZUVDNkbllmNFFDWTducjY5UUtlbFh4bU1ReUor?=
 =?utf-8?B?Z0RZK1ZLcXpyejJtdE5sZGUyK21ScmJWS2prL1UzdnN2dzNTUjErQmQ5S3Nh?=
 =?utf-8?B?TVRMUzg0bm9pajhFUnZ1SVVHYmEvZmJUV3hJMHdydjlBcS9GazdOcjVubnZl?=
 =?utf-8?B?cjl3dkYzNjJSOHpwY0R6bjdTd0RmZFJ3ekY3ZmpyRXhqMTk2b1l0ZTFSaWxB?=
 =?utf-8?B?eWZtNElpeDYwKzBTU3dRVTA4ay8wL0NTNFhhdDBYTEtSMU5DQWhDYTJhOHdH?=
 =?utf-8?B?Vmo0QU9QL2MxNDFCWnRlWFVDVm5rbHZZT1dDQjR2ZVRvQTk1dGR4VTByekFB?=
 =?utf-8?B?c0xQVTM2WnRPM3duUUh3UFFRdjlpZzl3cVU3OFVTQkZCWnA5bXpYZ0VVZWgr?=
 =?utf-8?B?VmVTMDlONjJEaVdOUkpTdWgwUk5JTUVPL2YzQ0dhWUdzV3JDSGdSYWZZaXU3?=
 =?utf-8?B?WnNpV0xyRlMwaWtNVGRZWm8wS3kweW5lLzF3cDVZcHZQU2dsYkxpT0FjV3RP?=
 =?utf-8?B?NUtPTkFhemZKcXBHeHkxY1RCZjZRVWhpTk5kUGErQkFHaVQvMkgzeFJPbGlz?=
 =?utf-8?B?a1dqbXJ0Lzl5SE5IMERxWGxzN0dETlF4NEtMQmNINHRLK2xGWnA2YUZJMG95?=
 =?utf-8?B?VEhjQXM4WlN1a1RwZFJKUEVLNTJHWUt5ejFSVHFnTWZjRXpUSDNWSThQSnNt?=
 =?utf-8?B?ZVFsaFEzYi9zYThTbGhiR2tHTCtINFhKTWl3Znc4VXpyT0wxSnNFUTNUSzRI?=
 =?utf-8?B?T1BzVVA0eW9ZOFVKT1NFeGxoVUdmcm5Cc3JlWlJ1d3RxQWpyZUJsaVIxa1lo?=
 =?utf-8?B?SlVOSHZ2ZmJTRTg3bUZqQ0RISU93SWZTUTVuYWUrZlhDajJwem9PeGw5dGZy?=
 =?utf-8?B?ekM2S3lNM2pQSGIwYVFXdnIyYnBXRFZkSHh4RTlJVVJVUnVEYlpoZVFyTUFh?=
 =?utf-8?B?ZHorU0xCdnBFVGRFR1EvVFdSUFU3ZDJVZG5zZzNzWGx3VW5IZlY1VXp0OFdP?=
 =?utf-8?B?UVltT0FKUzNNWHdjYzA3RVViUFh5czNMcDRCN3lzT2xmcm9nUzlRN0VXRGRT?=
 =?utf-8?B?QVNnWVI2MExRYzRaUC9ub2l0TXV5NWtpY3FIaGdUUGxWVVpTTFJPSTRIbFRl?=
 =?utf-8?B?RDBnTkRHRDA2UldxNUsvS040WnRuNW1rSVZxeElmK0lNdHR3clBnQlhsUWxP?=
 =?utf-8?B?YTZLMWM5ZWpoVVhtbHdueWtWdHM4YjE1U3A5OThHVEpzd05xa0hhNzl2RDY2?=
 =?utf-8?B?aWpMS3FuL0lJN253R3JxVDVFMkRFcituZEY0dWs5NVgvK0V6UnNXMkt4Vyta?=
 =?utf-8?B?SC9jcGxzZzNpYUNUYkN3SS80UnEzR1BmQlkvejlZSkFBOE1lOEVvQzVoMG42?=
 =?utf-8?B?aEpkc28wOHVjZU51VStodWZPL3YvNUY0RHI4S0Y2UThpc1dSc1RQalVhbjNS?=
 =?utf-8?B?R2h1L1VxbTRkR0xVYTV4M0g2UEhEQmtIeXdHZnVEdEJDT2swZC82aFFnL2pV?=
 =?utf-8?Q?J+LEzDCQXtc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlRXcXBuUVRidW5RM21tS25QYVV3SmJWditCcnVaSEFXUTNGZlI0dTh2MWky?=
 =?utf-8?B?MTNPMi9yMnlSREpDaGRhcWFtY2lTcXlNOHd1eXdVRXRJRlJDZ0Vwak4zSUpF?=
 =?utf-8?B?MnV6TU5STFBWSnNIQXduZ1NpK2NCUVV6ZFNFUzdmcHh2WkJWREhnTzk5Qmgv?=
 =?utf-8?B?YU5naUU2S3V6K0ZXVFRwc2tCTkNTbmNKYm9KaTByVTlnUEhWZVlodFk0ZlBj?=
 =?utf-8?B?d0FYZFRFSjNTVnBnbkxKaVREbnhubjM5YnNCV205a3UzSnN2dEo2ZTRkeklz?=
 =?utf-8?B?MGt6c2Q0d1ZlVEUxd2g5cTJ3dWtSRllZYUpMTDZ5UnN4RjZZZWFMbHVoSFBa?=
 =?utf-8?B?TXpzS09yc2JWck1VWHVveHE3U1pFTmxkSU9EVTY5ZzlZT1JXemNBVVd4Q0dU?=
 =?utf-8?B?S1hnQ0Q2aHJCQThsYWZwQUlHSUh0RlNyY3h4Mm5LMUdJL2o0SGc4WmtwVWVO?=
 =?utf-8?B?T1ZOMWdMYms3UU11WHVBcE4wQVBSTE5ZWXNha1pFQnlSa3hnYzZIMHl4Uk5V?=
 =?utf-8?B?aTNnR2l4eGJ6b2cxdGFteXBnYWJ5WmZDU2tRTnNnVWhOR3ZOQlU3ajVzRTF5?=
 =?utf-8?B?NjlwYXlIQTdGMCs2bFAyZThPQ2E0a3REUkgzY3pZRWxjVnNGUG9SV0laV1Fq?=
 =?utf-8?B?WmZaWU52TVd1NUNPMnBKNnpvcE1oeGpjT3VmbmJzNDZYMVFyK1cwOUN6M1Ex?=
 =?utf-8?B?NTZFRzRLWGV0N0lUTGk5MUhiUThsaW5uQVMwcXhLTG11RnhSUUduV0lJYjhq?=
 =?utf-8?B?RFM0WmlYaDNlUmNaNHNyeks5R1FjQ21vMS9KNXRIWFB0MzlCRG1ha0djb2dO?=
 =?utf-8?B?Tmd2WFMyUm10UzRCaEJ0dDN1Y0s0WHZrczh0UTBLUGdqNTJNU2J5WjNrNzBi?=
 =?utf-8?B?TjVxS0hSYTNLSWV6Z3ErUlVuZVdCajUrQnhFWCt2enFhMXR3SlNqejJTZ1Y2?=
 =?utf-8?B?Zzd1Q3UxRFlhMzJ4emMvRW5OWU54Z05ENFExamp2UEdEenNXWDVGYXdacElx?=
 =?utf-8?B?aGFnclVYaCt2dkVSOWdEK2NzUFhEQlNQSWpPQk9jeEdQU1Z4dGFFS1RmQW50?=
 =?utf-8?B?ZzVIbDNPSXF5SkVJTlBUZU42ZGJxUmkrR0tHb3dHMmlFbFV4YkVEOWswTHI3?=
 =?utf-8?B?YW1RUWtHMDRPUUVEMHpUdGx0cXlJRTNhYUhZalJvQXNENVJTWDJjZDcwY05q?=
 =?utf-8?B?NGVKcDZYajdXOVp6NkJ4NEN0VDBONkE0eEhwZEtBOFF2U2doLzk1TDVQbVV4?=
 =?utf-8?B?cXh2RXpiU2RiZ3djTjJ1YTJkMkRYRnJZTTJadzVlVWtMd3N5TXRXZXJRT0lY?=
 =?utf-8?B?SXlRWmRKU29MSVpwd1BuMnk1TkVFVnBZaituVVJyemE2cmVtdGFXMTRSQk1m?=
 =?utf-8?B?MzFjaXZycmkxZnJ2bmw4NWUrM2RPbE9qckljbGY1QzR0MFFvb29wSzFYSVMx?=
 =?utf-8?B?bE1vaGQxank3WGdOL2JGSGxTQldjb1BDNlJvOUVSWlJKby93Y1RhRE5wL1g4?=
 =?utf-8?B?akhBaXpRYndicmNCakRSZ3BXUEtCaUJXT09RWUs0eE03a0NuMm81dm5ZMnVi?=
 =?utf-8?B?WHpLdEdwRGFHbzF1TGwyV3AwR2s3WVRmK3QrM3lzc3djYmRXM05kUk5hU1Nw?=
 =?utf-8?B?M25JZy82RFRRejkveE5wNFBQeVhCL1JDSm5aeURoLzk2a0w2TUduS0xPeXVz?=
 =?utf-8?B?bkh5VGFNZHY4MllEMEZOeWl1VGlOWFZvelBzTmRmcEk1UVQzaEMxTnBjWG9S?=
 =?utf-8?B?TVZ5aXlPMU1tbmVrTnJzbmlQNTFZSUFreW5rUmtEY2xxU2U0a0VVZ1I2eXA3?=
 =?utf-8?B?Z01Ha3lhQjdOU0IvSDZGTGYrc3JpV2wxVU5vdENuUHFRend0eStQeTZ1a0lH?=
 =?utf-8?B?VTBTOXhjWTFER1hSdlV1Y0dLaFV2UmcyYVJSdVMxQXFCV1R6bjlrWjR5eFNu?=
 =?utf-8?B?aSsxZXNSR1FjY0tqS3JMa1BWeURwMDJuL3p5ZkJ4dkQxcWpRelBkSVpJSlRQ?=
 =?utf-8?B?MWxMd1BVTTBFVUF2TXdzTUNidE5OYWxYNzJiRWNDOGFIeXJ6U0NuenZ3bGVX?=
 =?utf-8?B?T0ZqTzgwOXlUYTliOFIvVXBSeEpCZUpGTWdTM3pBOXhNRUs1ejJoNnQrdkwv?=
 =?utf-8?B?TFFwU1VrOWhOQTB0NkpWdzU3dnk1V3JkeVNPdmhmWm1ZdUdUbitKdGNpUXJK?=
 =?utf-8?B?WjlmeGVqUERhby9ud2FKYS9WcW5KUDdLV1FWdW44Zy9WWGViYkFvZnJ3aGZT?=
 =?utf-8?B?RmlQMG1peDhjVkZhQ2VKN205UGlRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18587d4-f7ff-43cd-9834-08dde60eaeb7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:41:29.4285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIKA26toY+0W1AwBqnJhKvYJiH5Y7Ovg61fl3h6ymow3M4Z9emzWu6GCCzb1QFZrJfG5ElTbXMuAAZV/dEvII7diFDu+Cbxpcs2mzSfW0b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA3MiBTYWx0ZWRfXyCsRWGGkXnlx
 ohNLLcmhB4tABe5knFXpdyzjBTvPnvDTahkdQ2FlwQLO3qPURQUI+AnnPeJch5ad/Ywe7fBk37Y
 qJGk3PSSRbTrYrFH016aaBP25YpBYyU09M56Sj0tk9iMlfpkbzmsDw8P2BB4vyqDOHIqZvJJkjk
 Cr8PjTHNxwciMJ18tUOmEigpv5RrNwgSEbulFsIUGf88mYk45R1NA6RXmF5Ef40Wzz7qg4IhuGx
 2f5UkDH7U0lXzFYIZXO3/beSH6UoEWZIqKN2WEHFMnrP6/b5GOBndnKUO9i2aBhLoAG6H76SPuJ
 DILc4n32+GK6zATiLJBwFitaB+DFbmwoUSycZfGtE53eVxzEwsPGGjl3KDPsQg=
X-Authority-Analysis: v=2.4 cv=JaS8rVKV c=1 sm=1 tr=0 ts=68b0163f cx=c_pps
 a=nFyb9+RW4Vn7xfSDTd+rIQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=dpeeZ51g4ZwX-gffGBMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: itjysqTyVKm4mfacpRCUKLBL-pOReSnM
X-Proofpoint-ORIG-GUID: itjysqTyVKm4mfacpRCUKLBL-pOReSnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 27/08/2025 12:00, Mark Cave-Ayland wrote:

> On 26/08/2025 11:01, Xiaoyao Li wrote:
> 
>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>>> All isapc machines must have 32-bit CPUs and so the RAM split logic 
>>> can be hardcoded
>>> accordingly.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> ---
>>>   hw/i386/pc_piix.c | 58 ++++-------------------------------------------
>>>   1 file changed, 4 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>> index 816124c027..fc94937ad4 100644
>>> --- a/hw/i386/pc_piix.c
>>> +++ b/hw/i386/pc_piix.c
>>> @@ -444,69 +444,19 @@ static void pc_init_isa(MachineState *machine)
>>>       GSIState *gsi_state;
>>>       MemoryRegion *ram_memory;
>>>       MemoryRegion *rom_memory = system_memory;
>>> -    ram_addr_t lowmem;
>>>       uint64_t hole64_size = 0;
>>>       /*
>>> -     * Calculate ram split, for memory below and above 4G.  It's a bit
>>> -     * complicated for backward compatibility reasons ...
>>> -     *
>>> -     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
>>> -     *    default value for max_ram_below_4g now.
>>> -     *
>>> -     *  - Then, to gigabyte align the memory, we move the split to 3G
>>> -     *    (lowmem = 0xc0000000).  But only in case we have to split in
>>> -     *    the first place, i.e. ram_size is larger than (traditional)
>>> -     *    lowmem.  And for new machine types (gigabyte_align = true)
>>> -     *    only, for live migration compatibility reasons.
>>> -     *
>>> -     *  - Next the max-ram-below-4g option was added, which allowed to
>>> -     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
>>> -     *    window below 4G.  qemu doesn't enforce gigabyte alignment 
>>> here,
>>> -     *    but prints a warning.
>>> -     *
>>> -     *  - Finally max-ram-below-4g got updated to also allow raising 
>>> lowmem,
>>> -     *    so legacy non-PAE guests can get as much memory as 
>>> possible in
>>> -     *    the 32bit address space below 4G.
>>> -     *
>>> -     *  - Note that Xen has its own ram setup code in xen_ram_init(),
>>> -     *    called via xen_hvm_init_pc().
>>> -     *
>>> -     * Examples:
>>> -     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low, 
>>> 512M high
>>> -     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 
>>> 1024M high
>>> -     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 
>>> 2048M high
>>> -     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low 
>>> (=4G-128M)
>>> +     * There is no RAM split for the isapc machine
>>>        */
>>>       if (xen_enabled()) {
>>>           xen_hvm_init_pc(pcms, &ram_memory);
>>>       } else {
>>>           ram_memory = machine->ram;
>>> -        if (!pcms->max_ram_below_4g) {
>>> -            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
>>> -        }
>>> -        lowmem = pcms->max_ram_below_4g;
>>> -        if (machine->ram_size >= pcms->max_ram_below_4g) {
>>> -            if (pcmc->gigabyte_align) {
>>> -                if (lowmem > 0xc0000000) {
>>> -                    lowmem = 0xc0000000;
>>> -                }
>>> -                if (lowmem & (1 * GiB - 1)) {
>>> -                    warn_report("Large machine and max_ram_below_4g "
>>> -                                "(%" PRIu64 ") not a multiple of 1G; "
>>> -                                "possible bad performance.",
>>> -                                pcms->max_ram_below_4g);
>>> -                }
>>> -            }
>>> -        }
>>> -        if (machine->ram_size >= lowmem) {
>>> -            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
>>> -            x86ms->below_4g_mem_size = lowmem;
>>> -        } else {
>>> -            x86ms->above_4g_mem_size = 0;
>>> -            x86ms->below_4g_mem_size = machine->ram_size;
>>> -        }
>>> +        pcms->max_ram_below_4g = 4 * GiB;
>>> +        x86ms->above_4g_mem_size = 0;
>>> +        x86ms->below_4g_mem_size = machine->ram_size;
>>
>> I think we need to sanity check the machine->ram_size is not bigger 
>> than 4G, and error out if it exceeds.
> 
> Amazingly there is currently no limit for the isapc machine, but I shall 
> add it in for v7.

With the PCI hole removed it appears that TCG and KVM have a different 
idea as to the maximum allowable amount of RAM available:

Fails with KVM:
./build/qemu-system-x86_64 -accel kvm -M isapc -m 4079M
qemu-system-x86_64: kvm_set_user_memory_region: 
KVM_SET_USER_MEMORY_REGION failed, slot=0, start=0x0, size=0xfef00000: 
File exists
kvm_set_phys_mem: error registering slot: File exists

Works with TCG:
./build/qemu-system-x86_64 -accel tcg -M isapc -m 4096M

Given that the original limit above is 3.5G I think it's best to revert 
back to using 3.5G instead of 4G so that both TCG and KVM behave the 
same, whilst also allowing a bit of wiggle room if required.


ATB,

Mark.


