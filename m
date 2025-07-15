Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B914BC83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbYU-0003a2-HJ; Tue, 15 Jul 2025 05:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubbYE-0003XI-J1
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:02:21 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubbYA-0004Fx-9N
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:02:13 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7k9RT003648;
 Tue, 15 Jul 2025 02:02:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TaPxf5fQQ+O3D1D7SXlIWD6FI3NsEDXBVc8XhfJOO
 u8=; b=gmoqmf59VUNNTSBAxvsIjJX01Ua6k67TK1y/9rJ+897HtbkyBT02rw1zD
 XFMsoZN74je01Kr8316ki1ONUsiZeGhxZam8TeD1N1qH0aTEVVbJ0BHtEqrX7I2y
 g0rguGKIklbdMiK8gaoWHqfQe7GyDNt5GupPfRwqcMsL5OBF2WU9uz7AlvGJcjll
 Mk12Ot641pZiQwgBgifcgLR3lOg+wR0R7Hgf/16Mynbb6cwwomF3H0aL7osv8vDS
 stXpEJMWa1dahLAiSyCQIx6P/DRhWClHJvh1uu7OUZG6IFzzMX2NHdKBhehjvHzW
 DfpJlqUaLmWmk4QoHKjrN6Q3wRzhg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2102.outbound.protection.outlook.com [40.107.243.102])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47ukmans4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U67+c9oIIR1HXEyPKJysrsgE2WCqjPHqhAvh+62Ah74f4dYcKnrKFyVRl8St6ko+4K2X64UK7IKyFvLeMDsW1HeNt/iuX9yEAn8MNAd0hxfyYu98FTZuJWLnHeqMxjbhN+c5sL3klqpHizl71mxN5CWiaj9MY1gIu4RE63+5mqGDH58t4ChMf054spHVMeBeRCukB0xMWNBGmH/kmPEf/iKSBBoRVl4RNy6+8KhHOrRTPGIkQtSbL4P6Dj31N4vlJngbdr1smBIwvx5hGfRjrCuH4QGo8HIRg4mugsJFX4+eigqZFplw2DWzhVgcRItM7QLuAomaaOmFsYjfz/eFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaPxf5fQQ+O3D1D7SXlIWD6FI3NsEDXBVc8XhfJOOu8=;
 b=hJGG6DBQjNLXTHXeXfIdvM2Z/+DQ164AD7tHqRMzPIqM2e1Z6+zrJdffNcn5zyTzGZhPj7sJ5qQb7mZISHN3+xi1ozeen9oXvHI3/rpT5E9LU1Fdp49AY1aXvg3Lpaf/Q5BjE8+4UtzkJ7tmuTmYbEFyZN157elalXD8T12hmMVXsP5TMNQMSbUlSxCkdlZhGkYlXkn2ilJePh9qLCTzp8TmrN7a7TUcwjOPEwm6x8WuczoA0Kb7Fo5dSjvEnEAxqgAWg7NzI68oJexen3V4YU2hx9ehvlyDtuL3RVvU1Q+dZ9Xxut8FHEkACVtuBovgf5QKiarBXYETIWpAORMchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaPxf5fQQ+O3D1D7SXlIWD6FI3NsEDXBVc8XhfJOOu8=;
 b=sDcXPhs1cDQVH4FQGuThhIMpkN4UBMClJZ8UZ4TonQ23vmRFCSLm/Phgt/kVR1k6nw+1tSnDqlBOyQTkkmqPHA/IBvou0DGrq84i4w2tI3FRxqA2+OORRwNCjxt1Mwzn5vL+KbRgslVD1tQvvg6iOfw4KCMEGYFnFmaQ1Y7ZU7H35TJ9jfK+QisLoXCNa4rmOcrbjBIOBn6Uxn9Qx5fswSrh0cvi1ghzd7BUnGnVltiWp1ikMYDDxutSuOmLKCqL1YH654J6qsfJu9rgXTFWVHCYhOk9lV3HujgInkUpDKBBhHm1Ljy8ecsxEL53Gc3+9YadzJzIUbVxigbzijJELQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB10246.namprd02.prod.outlook.com (2603:10b6:610:1c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.38; Tue, 15 Jul
 2025 09:02:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:02:03 +0000
Message-ID: <4e4d3102-050e-44c1-ab41-aa1da2d7f6d4@nutanix.com>
Date: Tue, 15 Jul 2025 10:01:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/vfio-user: wait for proxy close correctly
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250715055246.422834-1-john.levon@nutanix.com>
 <20250715055246.422834-4-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250715055246.422834-4-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0120.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB10246:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e47cdd-68a9-4968-77d3-08ddc37e4461
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3dRVWdLK3RES1dvMzdhMzlUa3pjR25UR1hYL0hvL3lXbnpjelRoL001K0ZD?=
 =?utf-8?B?QnVzV2FzRHk1bjZweE1zUloyenZMempuMHp5Q1IvVk43RjhvUmNydnM5ek00?=
 =?utf-8?B?QWxBdVp0ZXQyNC9yQVM0ZGd2VWl5dXJwMkxLVlFGcEdPdm4zM29LN0h3NS9x?=
 =?utf-8?B?UnJ1L3RoQWVXY2xMZnExTG1CZUZkWFRvUSsyc1NVbjhOa1lZSm1Bem50VVNa?=
 =?utf-8?B?aS9mMFJ1UDdDNDdlMnVVNUNSdStRcGorMXlqbU9SVTU2dnh6a3RlcHZaa2Js?=
 =?utf-8?B?dlg4Tk81eVYrakp3cXlpeUpuREltaXc0eFoxQnRtMU9sd08zMm9VaitHMGFw?=
 =?utf-8?B?U3lSYTBBZGhYamh5TWxpeVBneEk3WERPVmdLaHc5VWpNTkNEZ0tvYTFwRTYx?=
 =?utf-8?B?OG5zb3N2WTl2TjhSK3BZVERkNllwbUFDeFZUNkhyY0Q4eTNQZXpobWlJRUcr?=
 =?utf-8?B?MW5FemNMQmVlbkU3YmtxMHRJYzdwaVdKVUdaRlIydjBpbVQrWXlKbXpyY2tQ?=
 =?utf-8?B?bGI1ZjVMQ2ZPTzJVU0ZqQVo3S0Q0ZUJKWk01QndnWGhsYXJPYWRYejcrZGNo?=
 =?utf-8?B?NEVXZHZmaERsbUpTOGthU3l6bU93WVFLV085V0txZDB2RzJsZUg2N2xBam9p?=
 =?utf-8?B?UWNLdGltU3NDYnhIdG41YjgxNjJaNVA2aHJJeFhNVGl6TVNoMDl6Q2ovWnJZ?=
 =?utf-8?B?eFY5RTBhQ29CeEEzbGFLT3kvUjdhQ3NZQWdnR1dJaURHMXVQQTVuUk12WUlR?=
 =?utf-8?B?NmxKS25hdEx4WWdHWnJ4MEtLU0U0OUYxZklKTzZucm04aDdzUk85OUJ3Z1Fk?=
 =?utf-8?B?cVJ1RzdHdzg5WHpibWpWWUIwdElYYVpnSzRzSWNERDk5c0dxZEk2QUR6dmg5?=
 =?utf-8?B?Wnc1TTZNZi9xNlV0akJMb3IzclJtSGxQNEdaaGkrZVM1NlJMcm1tb3VkZEVU?=
 =?utf-8?B?RWdmbXdNOWNIWmdZL3lCQm9TZEw4N2JlV0grQWt4WHlrSTNYN0l4Ym4zNVcw?=
 =?utf-8?B?S0xPVm5YdXc1UHhXTk8zYlR3RXFZa0FuVHRKQkdoR0ZOaU1GQnJaT1IwRThn?=
 =?utf-8?B?bmxVRHA2V0dPZllhcmZwNjNaU2NkQkRLZTRZRXF5dlAySzA1bGdYU1lVbXpF?=
 =?utf-8?B?UHB0MkpSSnNsQzJrSG9WUmI0Wm0vVGwxWlNBMUYyaUlhWXBsZWIzSGFqRE4y?=
 =?utf-8?B?TWFNOHJJSWtjbEcrYW1IVUZHNXNjUCtDV1FvZHVWdVZ5eW1TWEZESFZCVndW?=
 =?utf-8?B?VWs3d3NTb05lR3NEZTFUSmhqenhIa3FoRTJDVDRxYXdPV2VkZ3dWU2hNOHd1?=
 =?utf-8?B?ZFlRam9vdTQ5MGFuZE9DSGx0OE9xWk1lS293QVRBT0VBMnNnZTFVb1NjNGpO?=
 =?utf-8?B?d3Q0cFU3eHJLVTFuTm5JbnZuaUtRMThWOTRVK0lXcGJDTzNXSUZrSUNCSzE3?=
 =?utf-8?B?RmtjVmZIOW5LUU9Sam9xclpWaFI1VVcyL1RsN1VrS1hsdk9iREdqNjZIandy?=
 =?utf-8?B?bG9tMlRzUmdpNnV6TlJFYUZYazl4aUhXQXJuR2ExL2N6cUt4aTJPY2ZPZ053?=
 =?utf-8?B?Z1oweXM5VVgzUDhsMTBWMFRLWlZZZ0Rqb3kwQ0t4aklyblo3Ylp4V3BDVmV3?=
 =?utf-8?B?eitISVg2enFkVlNSNndaOXJrRHQxcG1vQXI3S3IxTU1rM3h5R2ZXUEROK0ds?=
 =?utf-8?B?Q0xlalFVSTlMdzlyS0Y5VWVLdi9MaTZjblJVYWhkYzhQRHFlNzNBOG56Q0Va?=
 =?utf-8?B?Q0M4TVNGeFcra2JWY1ZXa2RwdWR4Nk9jUnphRHVOR0dKdm5xV0Jwd0ppL0hH?=
 =?utf-8?Q?H+VKrEC+siQbfsxkHgac3SLtLdIHHsXBv4aV0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0JVN2g0dG8yK3NzOEVnK1dwWm8rMzdGVTBhd2xDZXZrZkNKZTlqbHB2clJv?=
 =?utf-8?B?TTh2WHBlK3lOcW1DSWVMNGgrcXhlejk5NGlDckFsdlN5YTFZNE1KV1NDNkhq?=
 =?utf-8?B?cHJmN25MbG0zWVRyS29xSUlLSzNURW9weS9KRzZiSVBXUjc1d3hzckR1N0lW?=
 =?utf-8?B?bVBRdVVJbDFaKzBIbzV6V3FnTnNpeDFMMDhjcHpXbDRtYmFjNi9CNHpYWGFo?=
 =?utf-8?B?VnN1Z1BoRGQ0WHRmcUphTmRNK042S0pKZHlwUlNsNlloOUgrMDhaSGUyK2JD?=
 =?utf-8?B?eThRVE90TDk4NnBMWXN2Z0s2NklWMFcrZmFGOEQxemVTMno4eGdrbnNHMS83?=
 =?utf-8?B?MnoxOUFJWDlRTzhVVSsrT29MMEoyUVFzT2RCT0c5Y3JUL3QycjMra2VvWk9L?=
 =?utf-8?B?ZmFsbFQvdVZwL3hUdmdmclhjWGFiSWQxMXFUYko4SzJrWG5PekNFSms0UFQ2?=
 =?utf-8?B?bnpySHdoRTNrdXNlTmgyeEJDMDF6MHZWNGtLQitBM09YeG14dVd4dzczOEhx?=
 =?utf-8?B?Z2JPUmlFZFBFaWp2eUREODBpL0RUSTl5Z1VKMkFSVG9GWFJ6aGlZWlFaUzIv?=
 =?utf-8?B?bHRjTEJvd1dvbnpVMGRLb2VCVU1sZkV0cFZQU1BkaUg2K2FIMlo3amM4N3Jy?=
 =?utf-8?B?T2JxRjREYjFDdVArRjM4bi9ZKzVJeWZ3RmVzYnZnd0gwOWFDdm9pNGJSMmVS?=
 =?utf-8?B?bjZONG5qRmVxaDFQYkRyUVBNN1Y5NGNCZ0NibDQ4ME9HdHBsbFdOQjkzWkxF?=
 =?utf-8?B?UHlDSHVkWVNTcmRCbmRyYWpXSnhneis3RWx3amh5aE4wMWpQdnJQMDFZdHhQ?=
 =?utf-8?B?UWNaL3kydjNUayszMnBNZ2pwSjhxR1FrL09lQ2E2ck9KcTEyRm1jN3hwTnVi?=
 =?utf-8?B?TTRpWWlVUEE0YXdGUGR2YjdNL2Q0SGtZTGxRb2ZPb1JkR2k5TXpOemhNY2Zw?=
 =?utf-8?B?WmFkRHd4MW9vVzNWYUNMbThKR3FtR1o4N0JWN2RnQ2N4VVpFbi9VMllmaDN1?=
 =?utf-8?B?ZFk1SmcwVHI0OUZscmtPWUZFK0o4dTJheXBPREs0OHA2UTZCRDRBR3QwOHpS?=
 =?utf-8?B?YVl3S1BCdVNXZ0VoT0hWZng0ajkydk5qUmd4d3F0d2Q5Y2MwU3RER2NBUVc4?=
 =?utf-8?B?NGJod0FiUGE0ZURkYnhVckNxQ3FSdXgrbnFDeGQ2TnBCa1N3b2VSU0xNTXVi?=
 =?utf-8?B?bGVTbDhlcnkxMXpYWnJUbEJUL0V0WGUwRjJ3ZTlsdnByQVpkVy8zRWhVeUZ6?=
 =?utf-8?B?L04xMDZYWjFTc2V3TTJNNGt0a3RIM1VDcGlGZ0Q2YnVBenN1MHU1UUlnQTl2?=
 =?utf-8?B?eWluQktvbXVLMTBxR3ZkcWpLM1ByNmc2MEhmdkRJUUtBTytLZXY1WkxEK002?=
 =?utf-8?B?UXVkMHJRRXphQXpNZ3lSMENsK29oSjlwenYrZ1JhZjNWbERFZ2o2bHBZeGxK?=
 =?utf-8?B?V05FeVJwUmpBNy8zaXFPSkozK0JoUlFGM003Y0xvRVAwRStINFMvMmZxRFNF?=
 =?utf-8?B?a04wR2lVcllIUUFQNjl3MnRraytENlRONGRkVzBiTEJ4YTFBTmFtZ05ZVDNm?=
 =?utf-8?B?ZjllMkQ1V1lXem5yeGNvSzVFSUFLTWZqdjFHYTYwSHBycWxNTXY5aXhCQXRm?=
 =?utf-8?B?ZmgrVWhBck1NZDNRR1NwVnUrV2xvUE9mTy9YSlFnSkxlcGlJQUxrZ2lhNEIr?=
 =?utf-8?B?ZitySkNnTnF4MURiUjVuR2VIZVBrQmNTU0VNdVhQeDkrVVByM3BGL2lNSnVR?=
 =?utf-8?B?bWUycGxSZ1liTDgvQmJXWHZLRVlwaXV2YmV3WUZPSno5bzV4eG9iZThzWVYz?=
 =?utf-8?B?bG1WRU9wd1YrRWsyelpYaEwvRTRGZ3VCVjhlSEk5TkkvKy90Y2pLTmExQjho?=
 =?utf-8?B?bURFMFRvcTBKdGVTczhkdThZWjc1bUpUT1JMTURuQTBQQkVxKytDS2ZRUkdy?=
 =?utf-8?B?bkRrNTFsWDI3YzJ3UFRkd25QM3VubTg3TnlFSmtOV0xaOUNZc3cxV1lOTURt?=
 =?utf-8?B?SStDdFBoY0N2Y0JIa0wwUDg5V2NGaEVvYmZKTUJKc2JHb1FHQ3ZRbms0c2k4?=
 =?utf-8?B?YkVkN0JpNUtrV0V6bzEwNmdubzd1ZHlwRTFDTS9zeS9kT1RvNm5yWklZTVBY?=
 =?utf-8?B?KzVrdmczNy9RM2pHT0QzRDN6a3lUYnlqaisyNlFyNHlNd3V3eDZvRkVCekNr?=
 =?utf-8?B?aUpTRjJMMnRZYzRZSDludFpuQU1tblhmSTFlcGlXRm1CMkFieUk5N3VYeHc4?=
 =?utf-8?B?bVVFWU5mTmRrZkhmUXdxbEZmVm1BPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e47cdd-68a9-4968-77d3-08ddc37e4461
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:02:03.7947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ofb5qqDpdcCB2Uor90vl1m6dzPuBq4mwEPCm5w5GWst4vtKx/GFe+JPxk2WifJqn5Xze/fORNApl6CzImmpBoKkA/91j8m10b4Ld6CoqUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10246
X-Proofpoint-ORIG-GUID: waPx8PeRhVAsNHBLE9dtb9qR9GzQ7BtL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MSBTYWx0ZWRfXw05HonRhJz0G
 gLrlu/ARp5z+5fc0p0Wta8dtUYjAbTe8xSgS8FBtB+twbE5AsV2D5GTaThZI4MOVWriqTyh1Svp
 bvaDxoUSYxTd1xcYj4mrk6SuDqkaiZWkRccNZWEM5rpGbbvuVweQN7erg8KKIt8QA99Dtn0XiSH
 ZO37L7xEfsQHhjOnig3OXS/ss1F8qBrOsIM6zALn/IWJw49UbWVqPCrsADTFfLOyVrHUGQ9FJRh
 F8N5/ufMj4ZpZvQceoXSqtiXuWhqTi+B/XI8LwLdKaQbH7083asw5xX4wAp0Vhf0U8qOw0acqtp
 a4owfC46M8ycrFnsvqLhqSwk+trhOUHWLvlRq0PDjMKVmXsRyfho77wZHRHpyTxgSzils/P+M6A
 BPttuLQizr76vI2oH2RW5yvng5IXtE+PMo5Ut1vThMYP4YvBQe3D2awDT29DV8fUHP5PnSAw
X-Proofpoint-GUID: waPx8PeRhVAsNHBLE9dtb9qR9GzQ7BtL
X-Authority-Analysis: v=2.4 cv=UcVRSLSN c=1 sm=1 tr=0 ts=6876190e cx=c_pps
 a=soZXggRKP89Qtlu95z0jTA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=GaQpPoNlAAAA:8 a=64Cc0HZtAAAA:8 a=hqgRdkfO7dDFjfNRazAA:9 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
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

On 15/07/2025 06:52, John Levon wrote:

> Coverity reported:
> 
> CID 1611806: Concurrent data access violations (BAD_CHECK_OF_WAIT_COND)
> 
> A wait is performed without a loop. If there is a spurious wakeup, the
> condition may not be satisfied.
> 
> Fix this by checking ->state for VFIO_PROXY_CLOSED in a loop.
> 
> Resolves: Coverity CID 1611806
> Fixes: 0b3d881a ("vfio-user: implement message receive infrastructure")
> Signed-off-by: John Levon <john.levon@nutanix.com>

Is this definitely the right patch? The v2 posted at 
https://patchew.org/QEMU/20250711124500.1611628-1-john.levon@nutanix.com/ 
contains the updated commit message mentioning the rename of the 
callback, whereas this one doesn't?

> ---
>   hw/vfio-user/proxy.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index c418954440..2275d3fe39 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -32,7 +32,6 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
>   
>   static void vfio_user_recv(void *opaque);
>   static void vfio_user_send(void *opaque);
> -static void vfio_user_cb(void *opaque);
>   
>   static void vfio_user_request(void *opaque);
>   
> @@ -492,7 +491,7 @@ static void vfio_user_send(void *opaque)
>       }
>   }
>   
> -static void vfio_user_cb(void *opaque)
> +static void vfio_user_close_cb(void *opaque)
>   {
>       VFIOUserProxy *proxy = opaque;
>   
> @@ -984,8 +983,11 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
>        * handler to run after the proxy fd handlers were
>        * deleted above.
>        */
> -    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
> -    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
> +    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_close_cb, proxy);
> +
> +    while (proxy->state != VFIO_PROXY_CLOSED) {
> +        qemu_cond_wait(&proxy->close_cv, &proxy->lock);
> +    }
>   
>       /* we now hold the only ref to proxy */
>       qemu_mutex_unlock(&proxy->lock);


ATB,

Mark.


