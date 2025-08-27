Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFCECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDtl-0007VE-3U; Wed, 27 Aug 2025 07:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urDta-0007Sy-S9
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:00:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urDtV-0005rd-0C
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:00:50 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57R3k5Gp2972808; Wed, 27 Aug 2025 04:00:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CpkKmva5vxGWXwbqNjqznj5fDr5apI0MtOH1h/ixb
 pY=; b=d1Tl1Z1o5jPdHHH1g4T/N4Se2QOu0rwUbOQ+cjxz/C7j0VgyneQVS10f5
 yTCDWy7g0I/xkw+a3F6++TSchEyoCWDEdjMcxUYwYSzHiN0nef2vSfwfb1K6P0Mz
 fuk8RfmtkNeNAEQjsrhXleVG/SPjfpPfRetBdPYlg5SFS8ROKikR0SncG2Q4dw/M
 xBhJIQmJWJuqAZDfUwpRrtC6dCXEwRR3itvJiykUwy5wv7n8cuUnYa2mYRpYXfqx
 nOKCm7WTyv2AHksf+CgHOYLyuSPs9Lut9W3EV/jikfu2FqzVDZu3eq5+RCc4ewB/
 mR3W04A5SCFsdViI77E5Ue67B/GfA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2123.outbound.protection.outlook.com [40.107.92.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48sek3jfn2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 04:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQpcoASeNs/FILolZ3wkrbp7GI8WsCYB9mCw3pRanpTi/cdb5EzVBvLTfN1B+prObane/u5vaxgp5N1XOUisZyQRmP+9b73XMG0XpbS1mS7gKJO7O2Jc1h9IfWZL3e0qdaOa7sBCwNG23WtBmkZKWfvS9H1DBHOFv2X+BAFUPzFsQN6vfMNkrsWCBOzV3N4+LbAWFhsGz2Od+T5/JwkeW65gYcAD49h0j38aIr/sXRddAvCLJVGm+Yk+rqquNXdQfHajfllzuD0/wdV/Cl5HE1RFSmzpoRTl0L48/Kb0htq6V2Pz9jygiUmBD5dHn9WD/EeWphWnncOUgKb73cl49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpkKmva5vxGWXwbqNjqznj5fDr5apI0MtOH1h/ixbpY=;
 b=VHOpW1U6rYdazL0PASrIS2sVCnNGUFiRE+IKFAuCmojonK9eCQbSpX5Y1UZtWpkOFMqwS1CLH99yeY4ARjHAnqOnA3UFdh551vmfbAtULwnj+Itl+ttyuZaNEX1w5oTt5vCsHrZDjuPvIGmk7f3SZKUR1t6tOdGKsoeSr2mQV7NDH0i9WXxe4WN3Zi+LoNN4sp8ru4wlcHKAV6tHyTkYR9SRrHFOXOakOV0EH4dU8bxBAKqba/Jo8t2BOHAUk8IseqT87MmjZ6YKi3ioXkSB4Q/WkJ3yrLZbxryhYLSunvhV09/6ZOwdqfHEqDfSDafAEDsqOygSQa5v1vuDajCsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpkKmva5vxGWXwbqNjqznj5fDr5apI0MtOH1h/ixbpY=;
 b=vnpELs8Iyr6l5KDMzwupeGcIWoa2J9AkdchvWspepBBPuKjGGMyQhp/cLDcP/kttQrsnT/L7iTj7VTkmMCTseimhipDL/qrl6PCsL1DjI8wbmb63+xSZyKXtk27oTZfYW73dkhZOW67/k5leSAv8e6DU3vQButPhgsRYlc5pU7cpUIyBaPnBo0C6APeIs+8FJcvM6BWRnoLjqH+XpZ7U7sUQLpu7+/cuIPDWOBQNGcPpt1MGJV3Z4X7Yh+9BEdSN3kGuSxctgFKTRALauQUSYgHVZnJ87veLnyLM2Sq1vN7MjVUaMKBVTa2s2SMUyvWj5u8AoHLFmS59dMOood0mAA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM8PR02MB8200.namprd02.prod.outlook.com (2603:10b6:5:315::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 11:00:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 11:00:32 +0000
Message-ID: <fd631cee-4089-400a-a79f-0091341fec1f@nutanix.com>
Date: Wed, 27 Aug 2025 12:00:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
To: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-10-mark.caveayland@nutanix.com>
 <7fa8968e-c584-4441-8859-a40788067e95@intel.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <7fa8968e-c584-4441-8859-a40788067e95@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR08CA0004.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM8PR02MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 23dc9c2e-8a5d-4b04-f408-08dde558f0f0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUlFWFUvMitXNEkrU24xbG1mMXBaNkpUcGZiaUIybnROZmcwN3N5VzNGeTV5?=
 =?utf-8?B?NHhMeXI1V2tLWjRCZ3B3OTg0VDhVTWdXcXhpUkhnQXRLMHk4ckRGakZBTW9J?=
 =?utf-8?B?MEdXSDR1bXNvS3hkR1RlM2hlWS9hblZiRVdwTzk4TXBrUVhIcGZXcE5TQ0gv?=
 =?utf-8?B?TmtFaGtkSXZpSjBYOHdEVVNOQUZGc3UyOXQvVVNiNnl2RnhUZEE1MEIxQjRp?=
 =?utf-8?B?NWYwRXEyMnArMXhDYjNqaUd6MXp6MTVjRUdJWWZtQ1FXVlp1c1VTa2ttYlNt?=
 =?utf-8?B?WUtnNVEzcVpjQXRQVVArY2gwb2cxamQ2Q2VveTFLNmtta0pLZG1PZ2Y2VVZJ?=
 =?utf-8?B?KzZ2OTdhd0YyUHNuTmI4L0lJcXJrcUxPcGlSNy9pc3RNVTdoV1RSVXRFaDlD?=
 =?utf-8?B?bDV1Q3BFbHV4b2NKMXhNZ05yR2lvYzdPSThEVE9GRHBWMnZ4ZUtyNUltOTVS?=
 =?utf-8?B?dXRhbTBzWDBzVFRyclZhMnhKUDVsZk9jRVpaR1QzalRDRDY0T1dsb1ZSSUZB?=
 =?utf-8?B?YjRLd0hoSndtRGJhU24yR3d6Z04rUDJYcnJoTlRseWZMMDhsc0l5TnIvTXBq?=
 =?utf-8?B?bkorYmtwandGeklveFdKaHdTOHBQeHlzMVBWUUdMS2F0S3AySFpNSzRaQjJ0?=
 =?utf-8?B?TWhINEF5QUNzekxOWnFGZzZXR3Eyd3QrZU5VNSt4R3BHQ085UFVUK3BvY1FK?=
 =?utf-8?B?UWw2L2U3Q0JyQ3Z5Rkp4akllcHB4MmVDYjRlRHNsY1J2SFVNUGl5bVFJNlUr?=
 =?utf-8?B?emplNUVoNTVLT0ticmtwUVh2bVZPdktBRUl1Wk0xSXZqNWxRVFUwR0s2ZUlW?=
 =?utf-8?B?YTF5MkcvV2lzWXlXT2tMMFRFZFhTYVROKzVkMEkzR1dobDVDMjlrMWNvVDU5?=
 =?utf-8?B?RWNxWEJKMmxhdXc0QkZtWTMvNUcvUGhUUEtGdktqNzF0UGR1ZjAraFZieTNa?=
 =?utf-8?B?K3lnTFZqWDdjNTcvc3V2Mzd0cStlcWgzVUxRajNSNnJlVVZxcm13cVBpY3JQ?=
 =?utf-8?B?eGxoY1JOUEdyQUt3SCtSVjVXUmhNbHZMVTEvYncyQjZwZE1JNHBOajJwY0FV?=
 =?utf-8?B?aVJHT0w0NjlVZUFIOUFnMTBORk55VGY2c01ENHBwVXJMZWtXdHRxSDJpSlBw?=
 =?utf-8?B?WmVaK2lGSHJrOXJkR3dUdjV6RGt3TFU0OFRvSDJKU0JDV3VkMHpEMkFTNU1r?=
 =?utf-8?B?NjNTRngrU093dTBaTlZNb0ErZGdVN2QrcmtIY3lqTzg5a3NsVVhmMllUcjZB?=
 =?utf-8?B?dTU0MnluMHEvdGpUUDZ6Z3pCbXJGa2VsSlROdUVSVmd1ZnpCczg3cjJGd1RT?=
 =?utf-8?B?all3OVIyVDhSSytYODRVSjVtbGRsZ0ZoYk1lOUppZ3N4dzF6Y1VEMExyb2hn?=
 =?utf-8?B?SktuOWdsSjB0UUU4cWlNRm1LMlJheFZXa081ZHNoWGpzd1ZuWlZWOFlmT1R4?=
 =?utf-8?B?OGtxMTQxc1dJRWJ6Ry9HVmF4UjF2Rncxb25rdGNTVEdrQUIrQ0Q0U0J1dmdC?=
 =?utf-8?B?dyt5VnJRY3R2dTBFOVh1dWhsM3pNdTdzVTIxZjlOOTFvcVhaL081bWJra2dj?=
 =?utf-8?B?anZxL3NsMkJrUkMrbUNPckZoajZ0OWxoYmhXQkRCM3NzdTQxOHZPY2xDMTQz?=
 =?utf-8?B?QU1aWW9HK0ZWYSszRzA2OWZwTU5PdmE5azZsUDE2QWZSTktKd01aZElPNnFq?=
 =?utf-8?B?Tnc4S0pua3BtTFJ4UE04eTVIZXFyTUgyQkloNmd1a3ovMWoxWUpvSHJFT3RH?=
 =?utf-8?B?SGl3Vm9XTmx5czZRVzFFTlBiUGlCV3lpRCt4VjFSZW9WeHZmdTFhQ3pHZjJQ?=
 =?utf-8?B?QkIrdXRFRDlRUHdWM3p4bzNBcG9zYldMalVOalc0NDZaUkJ5aSsrakRYMGpS?=
 =?utf-8?B?RTB4WlE0WkhPcFBxa21IMGw0TVNmYkwxbjBleXhLOW80VnVqWTNwcGE2bExa?=
 =?utf-8?Q?T4vc0xuRgX8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZzMzl3Nm45YVVnS0RMcEJnTWNSUm1ybjdoVEg1ODhSTGJDVHdtcGFGRWYy?=
 =?utf-8?B?dUFPMlNoMzMrZTVCLzE4QUEwL2tJUHJlQ1JxdVhVbDZUODV6K0NsYnhYWk9a?=
 =?utf-8?B?SlpjOWdLaFFtZG1aaWs0OUlQaDREM1BMUHAzWEw1RHJUdnJCTThhTVo2K1Rk?=
 =?utf-8?B?clBIMmJqd3UwWmdVVHhDT1c0QmZlYzZodW9Zb1ptV1hvU2M2MlVINXdDczNm?=
 =?utf-8?B?a0tMSE5rdU91SFBIVFRRMTZwSENRZFhwRm5sU3ZVNVFPUlg1eXVjNGMydWgw?=
 =?utf-8?B?RVB3ZmtGamxFYi80QjhKRDQ2K0YwUFZVbS9TZTg4ckxWOFJuc1c2WmliYmlV?=
 =?utf-8?B?Y29uWE1OdEcwOXl3dUNRMVpyaEo2MWRoczllQjhsOXNjaldrcDExY3pJSWg4?=
 =?utf-8?B?eEpsVS9VUzY3UWMrR25hSnpNTU1ST1NFVjc0aWtpZkxTMG5EZTZZbGVrSXNB?=
 =?utf-8?B?NXZnWThRWVpWWTRRQVVmRXE5S2hkZ24wS21jTGhPYnJ1Z0hJbldVTEpyU1d4?=
 =?utf-8?B?WnM5ZUF2YStWKzUxNnh6SkU1RzZ4eWRFQ0RrYzl5OVdVWWNXaXhHQmRTNjg3?=
 =?utf-8?B?eUlKRHpSQSs5MGlTczRmT1VCVjRqYU1abE9nSTBnTkRTdEk2dVF3ZVl1cGR0?=
 =?utf-8?B?MzArN3I1UWhXL1hDaSt2WFpUZDl1VG5aRWhkOElNSEdSTEZpQjFyNXdtcDg0?=
 =?utf-8?B?c1NDcElKa0hZenErdzdMS2NZNE5SQSt2eHl0UVJlR0h3dEFGNE5qVE1kYldv?=
 =?utf-8?B?b2dRTEFqVXcwSEovV0szWE4xbHQ0b01ZV0hGQ3ZpaTUxR3ZHbVI4N2tCY1dW?=
 =?utf-8?B?d3A5NDBtRlhvczJ4dFhSd1FObkg2UG10VU5hWFRLaU5OamNIMFFBdkNRdnhP?=
 =?utf-8?B?ak91Tk9PbWhEQ3ZlMkdDenU2UC9xUFRlZFNKMFF0VFQ2SG1xbU1ISEpIK2Jo?=
 =?utf-8?B?OFAxOVMxRjV5Y3VlZk5ObHJnUi9YN3YrUzFqbGVLdUlxT3Vyd1dYdDNPazFX?=
 =?utf-8?B?L3lqaU5JWGJ4SkxjT2M1ZGcvSHlGai9XU25QNUxLaXd6dFJFbG5hWU1ONlFC?=
 =?utf-8?B?K3dBOVNlRUt0VElPdDB6UmRYNVdlMkZhWHNjMWowVzVQc2JhWGV0aWhqeExu?=
 =?utf-8?B?MHdheUZjenVWZTdSQTA5SzhYNjJkaURsNm1ON3ZoRmxlSi8yR201Nk9KSkhz?=
 =?utf-8?B?MEZBWVFJQXFXR2R2c29CREx4Uy9MYU92ZWFUbFRoZXpPemh5TStUN0hRbmRC?=
 =?utf-8?B?alFra2VFZ1A1R2RVKzRBUnY5S1VvQXF0YVBXWHRvd2N6YVhaQWpqVnNQWG1h?=
 =?utf-8?B?RVRKcnVvVDdOc1p1UkNsWFBKUURJWFhuVS9MT296TnJNQnFwUE1mSVVyTDNI?=
 =?utf-8?B?SzZsVllqdEJRUk52RUhzcEVTY1NEN3VXTXFBb0FLRFRmS1JFZ3cxTmJHbWlI?=
 =?utf-8?B?NlVMblErYmJuU2N4Njd6T1JIcTB0Mm9GeFFCVmV5bUtOaDVhYUFzWDZKK3Ax?=
 =?utf-8?B?OWp6NFQ4dUd2V2E5S3A5S294d2xNWWErSWlBaXNWQjVlcWRXSlpCOFZ0MEVO?=
 =?utf-8?B?WThVVitzTk1CUmR5NzNJZTZLb1dhM3F5RjQ5YzVZcmJranB3M2pVbVZPMG5u?=
 =?utf-8?B?SWZVSCsxcEs0T3h0S3EyUllsbTVtWHpvcW0rWFZubWdkN050UWlqZGNMWW5B?=
 =?utf-8?B?YUE2Q1Q2bGcrMUc3VFpsUi8vRElKU09qVDJIRXFKUWVtQjIzQW11SkF5U2k0?=
 =?utf-8?B?azBDcklySTZHUXlkZWxHZHNYeEhwY2NPQUFsR0g2Q1hZaThFRkxOc1VCc2Q0?=
 =?utf-8?B?ckdDWTNlUnFtZzFkS1dsMllTRUJTZEF0MG9iRE9vZWZHSHFQR0tsSVZjZ3Fx?=
 =?utf-8?B?SFVmZVY3NGhGMUZtR2l1WWM2dDdydnBlNFNyYmdzR2hEalZqV296MGxKckVz?=
 =?utf-8?B?OFlqL094dCtLVTlxd25nRFZuclR5ZS9DMS9ZRUplYkpSVkpUbFNOME9BUlpR?=
 =?utf-8?B?cXY3MUF1bkthUkNzSFV3L2ptK2xZSk91MHEyVVRIVUNibC81OUVvOEY0OE9B?=
 =?utf-8?B?Y1B2anV1bGxhcTdNYm1RTDFOWW44NE1PbGpSVVR2NjVxNmxNZC91a0RjMkky?=
 =?utf-8?B?Uy9ZcjhLNm94Yy9YVE5MUzNkNm80cDM3OVhHeGI1NGpobXBYLy93T0pTSGgw?=
 =?utf-8?B?Y0p1MzFHZnNWcmQrVVAyT0VlQnVlRXE0RWJHSjNQRzRNelBFV2FJQVM1NlRT?=
 =?utf-8?B?YWwrUEFBdnFVUzFEZHkrZFpPbFpBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dc9c2e-8a5d-4b04-f408-08dde558f0f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:00:32.0728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqDgSCB0RKP/LoopgzWLK2z9vx/kF0wtdx+JpYTSf8OQZ7qYmiDRK6Pw0Xl/6EQ8FKEwHFeZyX9xqXpn+893VQf9MBNKgvYtrBkRtVqnUMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8200
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDA5MyBTYWx0ZWRfX+wRegkIrOWPG
 UjuL/RpcyQ7hO6hQwYpgoS5dK8UnIvgum5hHoigbO6zuhLQs3dapXAarHcNq9grqCElN96hf6/m
 6H3NqqJuItRRKE7ySYZzAee2bggaR1g3Ib/sLDkNB3B1FKu2H8AvIecvfCGEzFLvGjdxUGHP5A2
 sehpqiZoH5zW7uQZJHKpGzjM9cD3h70FNQZcV4BZj0oCT+j4s26ai6MA3gz2ZaeG1MbND49VBaT
 3TIQRtQoJyWHatX7gi5SWypxWjoqkPN0LL89N7Slw91HdJnF6qViyrx8U6IwlTUPOj02Ld4Jl9L
 8lR1ZE5eGGHSwb0/4zmkJ9wveOzcGarusUqLNNEvWumd1Y8v87u8wOZzoJw6WM=
X-Proofpoint-GUID: LVxjFenP2b3JSXyKJ2SSm5XFc15hvL0y
X-Proofpoint-ORIG-GUID: LVxjFenP2b3JSXyKJ2SSm5XFc15hvL0y
X-Authority-Analysis: v=2.4 cv=WPd/XmsR c=1 sm=1 tr=0 ts=68aee552 cx=c_pps
 a=RfFfKCmWUWolPF9vms2niA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=7Q6wt5ZQ4_vXZ3oDq2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
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

On 26/08/2025 11:01, Xiaoyao Li wrote:

> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>> All isapc machines must have 32-bit CPUs and so the RAM split logic 
>> can be hardcoded
>> accordingly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/i386/pc_piix.c | 58 ++++-------------------------------------------
>>   1 file changed, 4 insertions(+), 54 deletions(-)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 816124c027..fc94937ad4 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -444,69 +444,19 @@ static void pc_init_isa(MachineState *machine)
>>       GSIState *gsi_state;
>>       MemoryRegion *ram_memory;
>>       MemoryRegion *rom_memory = system_memory;
>> -    ram_addr_t lowmem;
>>       uint64_t hole64_size = 0;
>>       /*
>> -     * Calculate ram split, for memory below and above 4G.  It's a bit
>> -     * complicated for backward compatibility reasons ...
>> -     *
>> -     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
>> -     *    default value for max_ram_below_4g now.
>> -     *
>> -     *  - Then, to gigabyte align the memory, we move the split to 3G
>> -     *    (lowmem = 0xc0000000).  But only in case we have to split in
>> -     *    the first place, i.e. ram_size is larger than (traditional)
>> -     *    lowmem.  And for new machine types (gigabyte_align = true)
>> -     *    only, for live migration compatibility reasons.
>> -     *
>> -     *  - Next the max-ram-below-4g option was added, which allowed to
>> -     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
>> -     *    window below 4G.  qemu doesn't enforce gigabyte alignment 
>> here,
>> -     *    but prints a warning.
>> -     *
>> -     *  - Finally max-ram-below-4g got updated to also allow raising 
>> lowmem,
>> -     *    so legacy non-PAE guests can get as much memory as possible in
>> -     *    the 32bit address space below 4G.
>> -     *
>> -     *  - Note that Xen has its own ram setup code in xen_ram_init(),
>> -     *    called via xen_hvm_init_pc().
>> -     *
>> -     * Examples:
>> -     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  
>> 512M high
>> -     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 
>> 1024M high
>> -     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 
>> 2048M high
>> -     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low 
>> (=4G-128M)
>> +     * There is no RAM split for the isapc machine
>>        */
>>       if (xen_enabled()) {
>>           xen_hvm_init_pc(pcms, &ram_memory);
>>       } else {
>>           ram_memory = machine->ram;
>> -        if (!pcms->max_ram_below_4g) {
>> -            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
>> -        }
>> -        lowmem = pcms->max_ram_below_4g;
>> -        if (machine->ram_size >= pcms->max_ram_below_4g) {
>> -            if (pcmc->gigabyte_align) {
>> -                if (lowmem > 0xc0000000) {
>> -                    lowmem = 0xc0000000;
>> -                }
>> -                if (lowmem & (1 * GiB - 1)) {
>> -                    warn_report("Large machine and max_ram_below_4g "
>> -                                "(%" PRIu64 ") not a multiple of 1G; "
>> -                                "possible bad performance.",
>> -                                pcms->max_ram_below_4g);
>> -                }
>> -            }
>> -        }
>> -        if (machine->ram_size >= lowmem) {
>> -            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
>> -            x86ms->below_4g_mem_size = lowmem;
>> -        } else {
>> -            x86ms->above_4g_mem_size = 0;
>> -            x86ms->below_4g_mem_size = machine->ram_size;
>> -        }
>> +        pcms->max_ram_below_4g = 4 * GiB;
>> +        x86ms->above_4g_mem_size = 0;
>> +        x86ms->below_4g_mem_size = machine->ram_size;
> 
> I think we need to sanity check the machine->ram_size is not bigger than 
> 4G, and error out if it exceeds.

Amazingly there is currently no limit for the isapc machine, but I shall 
add it in for v7.

>>       }
>>       /*


ATB,

Mark.


