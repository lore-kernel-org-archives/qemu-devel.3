Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F28CCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHdwz-0002yN-FM; Fri, 16 Oct 2026 05:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHdwx-0002tB-Aw
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:10:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHdwv-0003Cc-7Y
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:10:02 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FMoXX3087465; Fri, 16 Oct 2026 02:09:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Ma3MZobNVFeM2VDAXgMiQCNSahNXpoNNIrebSd+TI
 Zk=; b=zrcG4S4AsR4TaP/0x1UZWpCtTJFJFJkBEVCcC3TT41EowtyTQp9Vjivri
 wVnUxrGQEPPut/dbUT4qN3vaF1g9qq9R8T1mjMJGG9gl3rKuT4olmM04ZRb5hiAK
 QbgAjS/F8CcsrJRmwPTOe/R/ME+p6P4W/NDpk1RCHc5QelsFrX01B4xJfUQhPIts
 wGfgCurastxu6a5Fd6iuUlz+L4nNTnoHpRCqzznaRI3VmF7DWXj230mupikZWrEo
 STPaJHJ4MFQK0jwWeQtNLLylEQyzl2aSzWYDza7atkayRycnxDZNCec248NjojrG
 TRmGIjOkF9Y3lfoxzduQVq6X2aLdA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023087.outbound.protection.outlook.com
 [40.93.196.87])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hb045jc48-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 02:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSafwWLZ3Ps1SwMkWh5oyRgCwQLJOdmsDpBi7i4jexsfhrWvdKUowazRTRYmHsVeHnOMMAuq4YgjvWhDLKJdbk/e7PRkW+i6CS+OdCr6SQga0PJsPtD+QlfsM3SqXXyewHBP2TLFUePfGdQo6xeWUwXdRyYyXRJEpb0tLppBAjq6E9L7PUToSYoVIDepdgcr9ibdFPTsfuBJEAtpB019YZxTjim6hzVo3/S9LM9x1riRlpERwIJ0TS9mA/xQWa3biW/xxGZ5upb1oMer6+rwA5AAC/tOITeTuePMIhB6LYJtzkHth0NGg6N9lraL8H6+EX9t8UDne6igHcCF7iaCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma3MZobNVFeM2VDAXgMiQCNSahNXpoNNIrebSd+TIZk=;
 b=rCkQzqlaUbRdQ19f7jDd9i5T37iYo1e2RraSVJ24Hf1cOw6SFVk1AesgDm702pHke4D0DU9GAepaq52VLf/HIKm2HBtBIX9kEo3PnO53Ptvq8+LAO6eBADw4rOUVH3XAw4oTdMBWzK2wmyqBZ+ByF5BOV3kMcII8YdTBKZJso6q9fSmYXW1lgZgny7UB5bxa9KAByxfrX9Gm5hV8QcRuQo4aEDV4QsMaWiiKsZbhBmxjl7noxDFjQLrqisrSHvYp9ei3i0s0AlN+PSGbgVqlCKeKAu/6G460BcTv6Nvh6qWtRbxZyCu0ZWgPpG96yGYCXGakU5g++M6Ie4fceCeqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma3MZobNVFeM2VDAXgMiQCNSahNXpoNNIrebSd+TIZk=;
 b=dcR0nqtCZtNmpBxAb8Zp6e0By1qTvwGQV7tRpNcf7Vwr0Ko7vrELxA94xTi6YW718ZZZxJ+dDMxIhkTCTLeBs5W5PJnvVcCy0VAR4H36kKoDn53Msu5PFCXJ5ESSwJiEvOL3ymXU/eQMGqwXcseGXNmI+2xk1lYvpM5QnMNdIdC8ngtKcz2QPW+QFwU1UCWKREzEinJ9Q5xWYjVZHthCqNXTtsic2vDnAwyR4xZlYI3y/2zc+6yVhDKGZ4Ezy7ntKNbjxJcHT9FPSlY4EKzthxqAEopy0cu4Cqr3nKdZUYRttO7faDarV76G0ZxCliCgGWJSwp82F6GrXphTBxEJnw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6529.namprd02.prod.outlook.com (2603:10b6:208:1c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 09:09:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 09:09:57 +0000
Message-ID: <bdf28ad1-a8ec-4e13-b49c-34b12d7580cc@nutanix.com>
Date: Fri, 16 Oct 2026 10:09:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261015163352.1751191-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2cae50-041a-4ab7-c784-08df2b653f9c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: WH4LxRCKx+TWEH0uoHTXUeBQPh1yfg0q65VlioLFwuZBAiaChnwypYQ9KWVvA0bKZT4N0HlUPl/B5N+wz0pi9pA4JXk3B3gpMtQNyC+vQxJWTTKH9JWcItubw36iWrdjKfGz0xRPt/mk5rs/Boh8C6gQ5IPJuiPE4dYuvgI40O5PY7mtQEmA8siRsE8yKjjU5p8e41aZo38nKYXsD0023LszjNDdCzgq3K/12IROyr4z0q80attYiIvDoZiZb51URofl4MMkLj6xGATAZwHZgHhryYZ36TXLenA/491u6fzCw5gqcpkU5u7WzTeiIOJ2p3kdqmy7MOtxvDQOCKU9k28pLIHKbxP99ZFELg5HdrRyBQdv8cWKmoQa4bFu+qO5hJ3Yntd2C3O0q9lTSnQ9btd5qT/5GyCuDqLt7V+bRHG3AdGG5ZuzBY0Xpg3iPQUUwgWBVNLdevah1HcbH88L0+Q/xN0m6IAEc6hG87TPL4boNA5bQbJfiNWyUDuYkh83Pl+VUMNlthvrGmwHenzBsJDMZQs9EQmaCa384XNwx6Xv4MNHd3Dw8Jl763GwQDeo9TPVc+WeXncXNPHfQoyq+BYCCnK+jOlFJLU2pB4gszOmytuwHqUNgR3dTJDKnhwf5u0hcmWIW9zp1mshab/zKSV0mK7+VpJThoUtbbAPXq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(261009223027099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFzOXh1ZmxRUXh0ZFVPSy9LWExnbXZ4elArNFZjOWx1NmUzbDRVQm5wUDhk?=
 =?utf-8?B?SGdoc2JqaE8zVTlUK3lzb05lSlNBZzRQQnB3a2dOeUM1Unk3RUladEJDZlA4?=
 =?utf-8?B?WDN2dERaVXpXdWNSRlBTMk4rOUtCOUg0N2NFSE16MVdCSTlKM0hvM2xaZUhx?=
 =?utf-8?B?bGxvSHJRWTBIeUdpcTkxTGVka0xpaWZGOGk3dGhkcDBNVUd3a3l5ZklONExT?=
 =?utf-8?B?bFVpZFpxS1RlU016dU5ITkF1TitlbWdGK3hWbGpUeWxmNEdmZWtkRGRzVGRR?=
 =?utf-8?B?QnJoZVJMdkhLN25MSC8wSzVvODQxYjBXRitxOUxjS3dPVStCVmxZU1JtRGRQ?=
 =?utf-8?B?NjhrcEFsQmh1YnROREd0am1zRGpObEY2SDYzL0R2K01qVVBJSEE2QW5UUDVt?=
 =?utf-8?B?Lzl2ZWdVZ01Wb3ZXU1krdDBuakR4UytNQ2N6cC9pQVdJZTM4Q2NCQkRma0hT?=
 =?utf-8?B?Nk5rbTF1MkwrQmhEYkF3V2YrL3YvaDB2RjViL29UcTllVTZYRmxDSVVPK0Rp?=
 =?utf-8?B?RVAyOU5TcFUzU3Y2Zkovb0VRb1VYR1lpcGwvNXlkUmpRT1VyT3hkYWdiMjVq?=
 =?utf-8?B?L21qQVVIOXROdXF3alRBdjNHcGRzeTRhZmV6cm5QMEptWUlCQWFwNVk3UXRu?=
 =?utf-8?B?cHJsTU9KYjZCZlgwOVAxcTVIb3h1WGhQdHRNWVBZRWtCRDVBNDZCNGhxTm1V?=
 =?utf-8?B?YlVNbkFxUVRVY2hzeHpiZzZlSTBkOXVhNzBFUWhvTXE1Yk1rM0l6bkRYUUNO?=
 =?utf-8?B?ZnU0SERPcHZBRnBhUWoyZ0RoZ1IweENRTFgwSWo4a2hqQXhtVkFZZWdmSFNY?=
 =?utf-8?B?a0VxaVJaVjk3UTJUMW1HTWk3UVBCZGkrS3BVdmdmMm1ScTdUZmNHUTRlOExR?=
 =?utf-8?B?QXJVdnQ0U3VVZ2FXWDhjeFV0US8yM1VBVjMySHJqVytQVGd3Q09xamhISjVx?=
 =?utf-8?B?ZFRRNDRWMndMTnNKWjRlNGpNak1mREx5eXRmQkpRKzIvMHJudE94elBXQUNN?=
 =?utf-8?B?cVJNcHphTmh0RWczWS9rZThQdno3UklpVVpncHBsUHFkamJTa0FjaDY3SWU4?=
 =?utf-8?B?V21kZnBXR3NVN1NtdzI3RWMzSFBIK052Q0tIVGR2YitiYmZlSEdWODE0NlBN?=
 =?utf-8?B?TzlrWE5QRjE0WDVsWHBiVUFaaWJkVUZnRmtrY3BGaGcrK2MrQXpkckFGNUZV?=
 =?utf-8?B?OHVnRjdKdk0xOURFRTFRZ0hwSXI0QzNjRSswTFZjajRRMUcyYjNXalRwOTRl?=
 =?utf-8?B?cEJKaStHYnVxaGx1OE1LTG5qc1lDcW1MZDJxbDhYZEkybHIwS0V6OWo5YlRD?=
 =?utf-8?B?ZVo1UEFtRFpXL0UxeEFDaTJ1RHllU2wvaUY1ZmhSQkhiY0VPQU15VjVBeFRM?=
 =?utf-8?B?b0ZqZnJhWXpGUkdZVHRUUldVdUt2aEg1VTJpNDVRcUN4SitRQmhnMGlyRHJJ?=
 =?utf-8?B?aFU2aGZiaCtpbnc0RlBjSnJqSDlRandmdW15ZEtpdVB5ZzJ0UjhrSUEyY2ZG?=
 =?utf-8?B?MFlULzlyY3lsQnJ2Y3lycHgySklZUk8vUXVNSTVNYWczQ2YyMXdyY0s1QjBJ?=
 =?utf-8?B?OVdQNEEwTVdBZUZiVEtzMVFIUWJleHBmWFBhTDJWMXBURGFMY3ViU3I5QThi?=
 =?utf-8?B?WWJYV2FhSmlRTVRIKzRTUFRRWTZoRDI1a2lQT05EU3JaNnNyL3JTTWJOL0pV?=
 =?utf-8?B?SGUyRkNFYnV6S1JwYTJwUHVnTXBGR0w4bUVObFFOQ01mSXNZY3FyWG1jRjE5?=
 =?utf-8?B?d3lSRytTblhMemNwQjNqeXlrcWJ3NlpqTDNnZlFVQVkyU09yZ0Z2Ukw2em40?=
 =?utf-8?B?bzR1T3AvOER6N0ZRMEp2ODQxYUU4VDBiQjFpOGpZNnlURUVTbHU1aGUwRUl4?=
 =?utf-8?B?ZnhLd29KN1ljVTliUEl5cTlxVk9rVjM3eG5zbHlNVFZWTG8zQTV2ZXAzMTEw?=
 =?utf-8?B?am5URjBuTVhyK3czeTVUSzhPV0lkNE54cUhWWWxka09Hc0xLcGlxclM5UzRU?=
 =?utf-8?B?MFJXQVZiWFllWm1zcXRHTTA5WWxacndud2lKWTZrRVdLL3dkT1Jmc2JRWkgw?=
 =?utf-8?B?eUZnVVd5bjlKWmRDeWNzMWF4N202U2NVT0VzWTJ2OEY1aENiRllyR1BHQ2FL?=
 =?utf-8?B?Zi9QM1VNQTJZSXRXckFoVU05dFgvSXdkQ21Ta3RuZk01OGJZME1XK0VQc2dU?=
 =?utf-8?B?dGUvTGw3ZkRYb2J2S2lYR3oveXVMU2xnSlVFcXJLR3FLcUdpZ0x2Y05remhl?=
 =?utf-8?B?TnJMVys5ODRZbmt2eWJYdEdtbEREY3Fta0ZVTWcwU1NDbDh4eHgvUktLY2RW?=
 =?utf-8?B?eEhKVm5iL0xGQVJNN1FRWExuL09XS3pzbVAvMWJSQ1ZuenBUdGdNNmsxak5x?=
 =?utf-8?Q?sYqpcEA4mD5U57w4=3D?=
X-Exchange-RoutingPolicyChecked: nbQUvI+XPAkoTsKeo4/0q+fRbp5UXUZW38E5mLQ9l5lx0uX6l1LZeonTRFKDJVN+DBkGvS7383bfl6EAQOO0KfBZvNikup7pnNBMuChx/Abvxux7drq2un+sX7jHpNDsnEgyLI6Y4t3i+q/oq7wA6aCRnNPDuZyKpcdv9f8Xr7UpkEuPyKiHuG4AE26f/Q6Dk6RkIL2aPt559jGYyb9uaxXsCSkkKXiICexnMzuJLUTfqYLXRCflOiJDC2gWMizZoTO7Ep3FOj1++lmjZtb1g0KNizUr+tnIKb9iA3F2UeEsIWkJzvN5eBAVjUzRHJo62ghtENcr4wuJxkAcqIK9hw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2cae50-041a-4ab7-c784-08df2b653f9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:09:57.1478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSNSEaal+iyLZbgV4yJF1g3/oqSmQ+bS1IBzLiTuioV6fWbPiX1gJRL4C0rnanvqwxKbb6lzMEwDiHc1/33vERGnTij85c8A4Nbu5ZX7Iuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6529
X-Proofpoint-ORIG-GUID: z7un18V0-_NXw-PBYdWhq2QBa8XvjTNN
X-Proofpoint-GUID: z7un18V0-_NXw-PBYdWhq2QBa8XvjTNN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX5R7mFLW8vDiV
 wTV/+NQ9mC8G00MvrfNEBtuWwoiXsMS4Y4kCi0VmfoMKb0IejTvrURIJan/dL4Vcpx0rbuFa/cs
 A8f/4C9oe68cbKa6e7oG9nTT+UJ7YNw/+ZBgEYImboeeKJ7q170psanp/UPhetOfa/Uc7sL8BOT
 IUjrMX9IbpVMH+VSsXA53Oolm1ekAcYi4sY8g+KLUSpFodZZwPPn3BeXtfCZCZ7L9ej+ZMxyrb4
 NZZc1aXHYx+giPXsZIA+ogAVxyydkNkl0FSIebs+hswKhwNaOMJ+e6PavC+ehMhWHKXNOfKdXJJ
 zPC62m7p4ueSJBaKkY9sBnR2KQZoi982iTdZ0loMNcrIf6wfrT+lYnUqG4CGtThaD/smP4EDM/N
 +UrYH70+RrLrLybT88kY4unCskK+cxoCOugB6f8fSkGqZwBCUtPUz1NTQpaMG8VLwOiOb3e9p6V
 OcBdSVsglAaCNXlxu8g==
X-Authority-Analysis: v=2.4 cv=V/ToQuni c=1 sm=1 tr=0 ts=6ad1e9e7 cx=c_pps
 a=DH6uOP27q4GouF/df79YRQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=MK5WDSJ5LuLbvcpWtJ8A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX8HgoqfQM/MJk
 vEG5o+WnWY5RZK/0wjj1BXzWJbAMv71O+c4YTK6UFRHEmylMcSC5MwulYxLyGFiup0XSHrudULh
 tcBLxsj+Ne/4c0bGOYzJwo3TNXTnXA0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 15/10/2026 17:33, Peter Maydell wrote:

> The documentation for device_class_set_parent_realize() suggests that
> the parent realize function pointer is "usually in the instance
> structure".  This is definitely wrong, because the function pointer
> is a class thing, and should live in a class struct, not an instance
> struct.  Update the documentation to correct this, instead
> recommending that it should be placed in the class struct for the
> child class.
> 
> At time of writing, of the 75 or so uses of this function, about 50
> put the parent_realize pointer in the child class struct, and about
> 25 in the parent class struct.  We recommend the former both because
> it is the more common choice, and also because it makes more logical
> sense: it's the child that knows (a) that it exists at all and that
> (b) it wants to have a realize method that will mean it needs to
> chain back to the parent, and we shouldn't need to edit the parent's
> class struct because we want to add a child class that chains to its
> realize method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/core/qdev.h | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> index 8e91e2fcb08..1330e0153d4 100644
> --- a/include/hw/core/qdev.h
> +++ b/include/hw/core/qdev.h
> @@ -953,9 +953,18 @@ void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n);
>    *
>    * This is intended to be used when the new realize function will
>    * eventually call its parent realization function during creation.
> - * This requires storing the function call somewhere (usually in the
> - * instance structure) so you can eventually call
> - * dc->parent_realize(dev, errp)
> + * @parent_realize should be where you want to save the pointer to
> + * the parent class realize function; the recommended location is a

Do we need something stronger than "recommended location" if we want to 
encourage people to always do it this way in future?

> + * field named "parent_realize" in your class's class struct.
> + * (Some existing code puts the field in the parent class's class
> + * struct; this will work but is not the preferred thing for new code.)
> + *
> + * In your realize function you should chain to your parent's
> + * realize function using something like::
> + *
> + *    MyThingClass *mc = MY_THING_GET_CLASS(dev);
> + *    (do your child class realize actions here)
> + *    mc->parent_realize(dev, errp);
>    */
>   void device_class_set_parent_realize(DeviceClass *dc,
>                                        DeviceRealize dev_realize,

Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


