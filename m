Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD26BC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnh9l-00019H-HD; Thu, 27 Feb 2025 11:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tnh9g-00016I-Kd
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:54:37 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tnh9V-0000va-3z
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:54:36 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RBqlsY022413;
 Thu, 27 Feb 2025 08:54:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WE0ZeOTbdUk83fjKBeSSqt98HZNgiyJDYILolccTq
 Tk=; b=zTgDisFOa86pEoOw5c41p5ll0lk6hwMle3XHqtporSndFX4FyB8z8FxC0
 vbI1TCtEmsUYcuZ7AOflqnA8PCY9EwPQWnf6DTiC8pKNxIjsCCB29o+xDgyrNa3T
 NFWp/pJ/ZLJwnyOf6UGQzJXwMz//Ed6dGAqQXQg46xBHs2EiX5dkWIFeaEttdAam
 ribnLWmc7SFcAGWTMmofHpD1cA8popeIksatQttCkE1Bq93N/7LXU5T0O3q7F8Hc
 djz5I9dOPUfioUxK3d8lWZTcUdny5dbaltu51OIKSzRExNLpun8IUSXoYwm4JMZM
 QGRhcbwVMteH5eKwOkh2aBQumTOiw==
Received: from bl0pr05cu006.outbound.protection.outlook.com
 (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.10])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44yehte3ef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 08:54:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecVFNnVkt+H8DErAhtAyrq9rxP4xVSfhyK14k5nIxJxWyxw4eEZnPVrnH3OWCFUMGr0E6MEZSNbMbJLD2gPon014Ng7a3CeQwRIL2o8KxiGgnBxhDOSW5qR7Ua3FV7h0WqgZZIZms2A+JD7416uGW+XakHIU7I4iRBFvE0gbTHu8KffY3jEmG8eLgfUD2yrUmJVqrqTzQ8GozUBtfAi6BWG4UM3XqqCVN2QCqieeYqMAA4yg0AeXJ5nj3YDgNW+R3VSPPc/uk+xO+MYH0QdsoK5lgdA6ObDgI5QP2HHmsuFnP/yEZXk5eSj/J4kJxPvWmm3wNpD5Skg22vVjrQ7wQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE0ZeOTbdUk83fjKBeSSqt98HZNgiyJDYILolccTqTk=;
 b=oj96kfHqaRhZQtecWLUZdfNKsAtyrhWmwppYpH7whjQCU02GxEAbS2ZXUbesswoQdMll1GofS9eSq9gXbGrzUpuyfO/PpLYCAO0zxAbXoGDr0/aS3SG4SuIYFuRxqwbER2/OBm83X8mAgyUQ/TzWIm2QNZHEk5cs1Bl+NMhcor6Mqrg5OTfHQEyWgjdxP+AjPePGRkj0/i+CJKXDbbP4L/UThYh+voq5bTmwYFA8Fhq5k8aL/Ezo6pXD4jsTeKR0ofbWgI9WrIDwETKxKRzodcdnBkyZWze4mBbit59lRHfxUqAoXpAnJdb4DLhniEeYHJmEdHSvh4DxXYmcJhIa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE0ZeOTbdUk83fjKBeSSqt98HZNgiyJDYILolccTqTk=;
 b=RKhnj6H0BUrYlGF1dmJnbl8nS9C4I/IuwGogmDSGjXS5gWDE4zC33ctGmoI8NdxRDSqebVmZTGGInackF4KFU9gfWB8yYHBCoprz+GSXSyDxoEEbvQOpjYjJFU2XHBbTCgsA4lg4hb1Hb8PYeFiAtP51n0knzytQCW/N5McVUR1uzKJO0clnUcOFP2Y6pZXDXIehZGzwVn53kuAu4fvmzuNBwVzdl5/qLL5HPnowBEGp9OF1GJigZXhluUxJz36oB8ZdONN6m33G6/WWjJ25UoDXDvRP2qL6X0JF5s7vz3yEMjX5mpoaawZL6eW6eKvMYYZtdeZ+KeCoX5t4wj68bw==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by PH0PR02MB7575.namprd02.prod.outlook.com (2603:10b6:510:5b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 16:54:13 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%6]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 16:54:13 +0000
Message-ID: <5e68ad81-be6e-4a48-8620-1bf2ff868ab0@nutanix.com>
Date: Thu, 27 Feb 2025 22:24:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] QIOChannelSocket: Flush zerocopy socket error queue on
 ENOBUF failure for sendmsg
Content-Language: en-GB
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, leobras@redhat.com, berrange@redhat.com,
 Fabiano Rosas <farosas@suse.de>
References: <20250221094448.206845-1-manish.mishra@nutanix.com>
 <Z7zX9fz1lFDdi-rA@x1.local>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <Z7zX9fz1lFDdi-rA@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::11) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|PH0PR02MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcb5443-63f0-4b55-a758-08dd574f5d51
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|52116014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RldNWjU5WktxRUVmSy9tZ253WVhSODZVamtxdmlQd2RzMm5qOElNQ2dwb1NQ?=
 =?utf-8?B?eGN0WFFaN1NMUkY2UlBjRk9vN3N0NS9MdFlXYjlwWFpjOFZuT2FlODVHSDd3?=
 =?utf-8?B?ZDZOcjY5NWdXS1MzZ3NhMFZIN1htMUFUMDhEdTFaMUFlc0RUeHFFVUVsMGRs?=
 =?utf-8?B?ZnFJWjlvTDZMODlLemF0cGFUZitTVmZkS1FqNEcxZ2lWVHVQclB3b2lkUHdm?=
 =?utf-8?B?Sk1oQXAxV0dOUCsydE16Ni91THZLa3hWRUtEYnhibWZ3N3psdjkzOXJMaHJk?=
 =?utf-8?B?OGhBZjFQY1FPK0JFbDJiVGpRUkZOZmhBNjkrSXdpZ2lHcE1BSTJvTUJUeWVr?=
 =?utf-8?B?VEloL2VIaWxMWFR0dTZiTmdyZUtxVjRUNTJ4dCt1eEVsSlpNNm5meGhxKzR0?=
 =?utf-8?B?TTdCdmUrdHZ2MldhdGZ5VDg2WjlNS3RsNWZvMUhtRFV0aTAwWjJpTXYwUlo4?=
 =?utf-8?B?ZytkM0kyTVM2NHVEM0Y1ZUlCWFFMOWZIei8wTi8rdm0zdEdMcGxOTnlZN2sv?=
 =?utf-8?B?RWg1Y1Zob2lQVlhsYWd3eEc4WUgzaUZUUURiY1VzL200TXlnNS9vZnI5WFR1?=
 =?utf-8?B?OXprZUFLZ3BwL3RUMndmYW5PbklJZlE1bEtMWXYxNXdEMVg3QndUUFZwSTdQ?=
 =?utf-8?B?TElIZ0g2YzQ0Q0JuYWkvdEUyYlpBcFFIVjcrMDkrbytkMEJMenBaRU8rYWg5?=
 =?utf-8?B?N1hmUC80WjRwL1VSRzlJTlFxb0NyUWRwWUY3N1FhYkozdnBweTZRUlpFdUN4?=
 =?utf-8?B?TDFIRThUYU1EeVFSSjJVRk5zaTZnZFdaSHczMjZSazNlOFJzcUl4c3gyb3M3?=
 =?utf-8?B?WURuZ1NZa1JkREVGSUhaU084aUtlWXh0bVU5bjFYMVFYRjFqc0pKK080TWpk?=
 =?utf-8?B?M3l2NGNxd2E1d0VXRVRRREdFN0pXSEJjVVN5WHlhcm93NXR0eXoxYTBqeDc0?=
 =?utf-8?B?ZFo2TVNvWDFlSmhlR1o0MmdiWEZrMHZKYTIvbHk1UGlWQ3VLL0E2d3dLQ2M3?=
 =?utf-8?B?amJjZHRWbUVWWUdYSUtPbGp6UkwxWWdyTk1Bc0pvbDBwTVNEb2xReTM0bkdn?=
 =?utf-8?B?UjR6NWlLQjJTaTdieDZJQXd5bW04WUlrWGZ6ck8wQjJmZ3lGc3dmcEtIOHJX?=
 =?utf-8?B?RzMwVTJ6YVY5dGswU3dVY0Y5NkVZamhNY0p5bGtTRVArRDg2SC9NVlIwYVdC?=
 =?utf-8?B?V1RDTmxPeHh0OWhrMVByVFJnUlFLdXVlS2hYSjRnOExoK1RYTXhPbGg2aVZD?=
 =?utf-8?B?eE13ZDUrcC9ubHZYdU5jQkZtN1VzTEhDTkJzNzhzWXhoekJRbEpreU1ncnl3?=
 =?utf-8?B?eUpXeEVxWnRrQThqTFJVeGZ1T29jNldvSUZXRGx3QzREbXZXbFhoeW5qVFNv?=
 =?utf-8?B?OGUvTEVZQVJsNGtOWXNKNlpGUkF5UWp0VzV0eGtEYkpKWFdjMWlkUUVka24w?=
 =?utf-8?B?a3NzUmhqUW4xRnBvclN4V0JNVEcvMjh0RHE3LzExd2NRTXlkMitoZUZCbnZz?=
 =?utf-8?B?NmdoeFY4Y0JqSTRESEo1ZVFyWE1EOTRqYUtKU0xqZDFsU2QwazQxS09nbHBC?=
 =?utf-8?B?TnhsZWxSUXJMTkZxMWg4bWFUQjhpNmRWWXYyMmNhbnpiOUZsNHd3Y0tNVTdi?=
 =?utf-8?B?cXYxNnM0dlJlRWRYYlU4aFVVd0dJZ1lFeTlsa2VkU3NZV29NZmF0ZHFOYWY5?=
 =?utf-8?B?ZFEvUURCQXNRN1B3cy8wWmhyR2cyTmZ6SVpGY2VlTng1OWxnRWI0WjBpRlVw?=
 =?utf-8?B?RWRBSkpTeWhYbkpPZFhCRXNpalZCYjZ1OEpFRWxGMURYSExTTE41QjJ5RENO?=
 =?utf-8?B?OUZkK0hKa1hNaUVvcXRSdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(52116014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJLVDV0SXVlb213azVselliT0dzb1JzMUlrV2ZES1drYWV5YUkvZHBNU1dp?=
 =?utf-8?B?dk1BSDNtR0NSOGFhd29ya3daVVpUNW1LM0RZK29HZmpxb2ZrdHVyeHN0SU1H?=
 =?utf-8?B?enRXT2NNQ3Q5SUxmVDNTa3lJVTV1QlU2M3JzVWxGWG0xaGZSMmlaYXpRMDdC?=
 =?utf-8?B?azk5T0Npd29ZZGUxMjd5dTJ2VFdudk0ySzNzbDVDV2JJLy9hQUtxSnUwcXZk?=
 =?utf-8?B?WWNHMndsZ3MrWUN2b2kwWnFTVTRXRWthL01Xa1U5L3R2WlRXekpGZzh3L1BG?=
 =?utf-8?B?dGpXdmxlV3RZNnNJUXNwZHVzN3hXRDlDWlJ3L3Y3a0piaDBZTDhNT1lya251?=
 =?utf-8?B?blcrTE5BUHk1OFE4S0RESXdnRmtQMFBUZ0RyNDFQUFFzbm9GVm96ald2S1BW?=
 =?utf-8?B?dGExWTJRUzNkYlFUZ09qVllaNFdWWmdQYVNVM3NCWlNidjFvZlMwbktWUmM0?=
 =?utf-8?B?WXl0YXE3QW1HbURkWUpTNVh0OGF5L25xZVBzWDZ6N25VUUtwMjFqd0tVdFpV?=
 =?utf-8?B?bEFkdzMrdjQ2WSt0Rk1iamF0dDMzUTgwK0lCOHRaWCtBYVBQVzhPV05qRXd3?=
 =?utf-8?B?RWc4Y0dKL2NjaklPUCt0eHhhQTJ6c1FoVCtXRitnQUV0di96ZHBBNHhjSjRX?=
 =?utf-8?B?ZU9CMDRhclVoL2xGRzVQdGNNTVNWZ0cwQ2t5WXo1SjA3WVZQcEpVTFlFM0tD?=
 =?utf-8?B?NEtORUlSWkREaFNkMzh4Uld4YUJCLzhIb3J1eTJIcVhvWFRYbm9qT3dHRGlo?=
 =?utf-8?B?R3R5NFJCZk9xWnR4NGErNXFIa0RCMHVLazluSUwzS2d6VjRtTTVYQXNxSlN1?=
 =?utf-8?B?OE1WeS8yc2lqOUlaRFlUc281THRyelV1LzM2azlTZVQvSExvaFhtOXlPbHNY?=
 =?utf-8?B?MG4wRXUwdUNkYzVVY2pvNmg1OWFFcnZnV0NoWjNhVDRXL0VCd0RhdmJrcEpp?=
 =?utf-8?B?eFl3ang2OS85Wkh1d1NTdDE2OGROd0c2ZXJSWFFTZ2NxRHBDdXcxMjl4Mm9x?=
 =?utf-8?B?Z3lJck9sRWhmZWJhREhVR2hRM1dXNnRYZDZQQk1tT2hsMXNEcUM2U3p1T3ll?=
 =?utf-8?B?MWFLUEVDNkxEYzIwTzdiWllOL3JqQWJhQ1pZM2ZCRW1TT0J3S1AxbkRsTXBF?=
 =?utf-8?B?OVd1TnN2VnIzY0IvbjR1U0wwV3NUY3JLcUtPRnpMRE5FdTdPVmZNbXBQd3RT?=
 =?utf-8?B?YWpnSHlPWmRIL0JQUnZHb0M0L0EyZ2Z5TXRZM0JhbTBxQ1p6VzNLNjFtWko0?=
 =?utf-8?B?NmJQeWNkM1FjRk83eHA3NENUVm1kU0xTSVlDQjU0ZHk5aGpLL1RKeGR3NFZ1?=
 =?utf-8?B?QXFNVFNMTndXcUtZc0JXalRHNWhaamxHRHppREVuVkhFaFBzQWZxVTNFL1Fu?=
 =?utf-8?B?NWQ1a2FzbU1heUVOa1kwN2ExZ3BtR2h5Ulh1cnZVVThveW9obnR5NGNmZ0xE?=
 =?utf-8?B?eUxDL2RkRUp0S2txMnFwT2FSMEQ3RHdjTWNIQ1UxV29uT3c3U1p3WWM1dU1r?=
 =?utf-8?B?YWpvU0xrTHUrNm01VW82SUROd3pkMlhiY0EvU2c0MkJ1UVp0MUovUWRFdndJ?=
 =?utf-8?B?dTcxd0E3OUpzNVpOb3AxNjVTZW51ck1va28va1lYYnMvaGszTUh6UTNONVF0?=
 =?utf-8?B?clFoaGF4WCs4emZLRnNRV2hlRm9hQW9ZUVdNZzFRV3gwaC9xNUlqY0ZaZTFH?=
 =?utf-8?B?MDFjdXZZNmtsb24zWjVLOVZaWWNZUHp3TGVEbmFDSERhTHlycHBFMVhJSEhr?=
 =?utf-8?B?OHpOeGtBZE14QllzdnRUQy9uRkI1czBNTDNVVitJUXZaVkFnemFCbEZKS3FM?=
 =?utf-8?B?WGMwS3NXQ2ZWc2xMdkk3Y256OVlzVTl6N0M5OHZiMHFyZnJLSjI0ZVkzTWYw?=
 =?utf-8?B?RXJaWGFSQk8xS3lpZHpwdUhETmpuc1RXZU9haWJiYndNLzJnTEl0SEgvZlJQ?=
 =?utf-8?B?Z1M1cG1iNG4wVnFSRlhJdTF1WldKNGFka2R0UXJrd1RIZWRBYXRsOWFMdG9w?=
 =?utf-8?B?c1Bib0VWM0lIS2NBeEsyRnlxcyt5QWZZSDdUS3kxa3NCN2JsTU5ib29DRlh5?=
 =?utf-8?B?UGRqTnMwbURqdWNhUVdDQkdiNGFJd1FYTGo0V0w5TFlOWEtuM2tLa3VHYVoy?=
 =?utf-8?B?TUtldXI2Z042ZStmbjZha3FUU2NpempLcGwwekl1THJidksvZXMwN1A0cDJS?=
 =?utf-8?B?Vzdub1ErYU9leXVZV1lVMmVmMFhMWW9hTFVZRjNOL2RxZWFHUkFHWXQ4WDlV?=
 =?utf-8?B?MnAxdGRsRy9hdmRXZlZFZ2Q2MFJBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcb5443-63f0-4b55-a758-08dd574f5d51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:54:13.7386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1Zri6WYXfPgITtVQS1LFS/R2MgGl7qaCNeQ00V/2FElAq7+wxBInRhx585R3v5lWXH4Fk81BvlDzQ0dnHtZtfMhNawa0VAbetmEmIm1Pso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7575
X-Proofpoint-GUID: ZKXhhVK-j2dJBSrhFLKjaQ3AF6RIz1SE
X-Proofpoint-ORIG-GUID: ZKXhhVK-j2dJBSrhFLKjaQ3AF6RIz1SE
X-Authority-Analysis: v=2.4 cv=XtoAOUF9 c=1 sm=1 tr=0 ts=67c098ba cx=c_pps
 a=yMWSg8qzqeR5zS7X5rtM7A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=0kUYKlekyDsA:10
 a=NEAV23lmAAAA:8 a=64Cc0HZtAAAA:8 a=q1aaYWqR5AX_KREM78kA:9 a=QEXdDO2ut3YA:10
 a=ardqhNu-6oL_yQwRi0m1:22 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Really sorry, looks like there is some issue with my mail filters. I was 
not aware this patch was already reviewed. Just checked by chance 
qemu-devels weblink and saw reviews. Sorry for missing it. I will 
re-post by early next week.


On 25/02/25 2:05 am, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Fri, Feb 21, 2025 at 04:44:48AM -0500, Manish Mishra wrote:
>> We allocate extra metadata SKBs in case of zerocopy send. This metadata memory
>> is accounted for in the OPTMEM limit. If there is any error with sending
>> zerocopy data or if zerocopy was skipped, these metadata SKBs are queued in the
>> socket error queue. This error queue is freed when userspace reads it.
>>
>> Usually, if there are continuous failures, we merge the metadata into a single
>> SKB and free another one. However, if there is any out-of-order processing or
>> an intermittent zerocopy failures, this error chain can grow significantly,
>> exhausting the OPTMEM limit. As a result, all new sendmsg requests fail to
>> allocate any new SKB, leading to an ENOBUF error.
>>
>> To workaround this, if we encounter an ENOBUF error with a zerocopy sendmsg,
>> we flush the error queue and retry once more.
> Could you add some more info on how this issue could be reproduced?  When
> it happens, it should only report zerocopy skipped and that's the only case
> below would be helpful, am I right?  (otherwise it should fail sendmsg()
> anyway in other form)

We allocate some memory for zerocopy metadata, this is not accounted in 
tcp_send_queue but it is accounted in optmem_limit.

https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1607

Also when the zerocopy data is sent and acked, we try to free this 
allocated skb as we can see in below code.

https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1751

In case, we get __msg_zerocopy_callback() on continous ranges and 
skb_zerocopy_notify_extend() passes, we merge the ranges and free up the 
current skb. But if that is not the case, we insert that skb in error 
queue and it won't be freed until we do error flush from userspace. This 
is possible when either zerocopy packets are skipped in between or it is 
always skipped but we get out of order acks on packets. As a result this 
error chain keeps growing, exhausthing the optmem_limit. As a result 
when new zerocopy sendmsg request comes, it won't be able to allocate 
the metadata and returns with ENOBUF.

I understand there is another bug of why zerocopy pakcets are getting 
skipped and which could be our deployment specific. But anyway live 
migrations should not fail, it is fine to mark zerocopy skipped but not 
fail?


>
> Please copy Fabiano when repost.

sure

>
>> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
>> ---
>>   include/io/channel-socket.h |  1 +
>>   io/channel-socket.c         | 52 ++++++++++++++++++++++++++++++++-----
>>   2 files changed, 46 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>> index ab15577d38..6cfc66eb5b 100644
>> --- a/include/io/channel-socket.h
>> +++ b/include/io/channel-socket.h
>> @@ -49,6 +49,7 @@ struct QIOChannelSocket {
>>       socklen_t remoteAddrLen;
>>       ssize_t zero_copy_queued;
>>       ssize_t zero_copy_sent;
>> +    bool new_zero_copy_sent_success;
>>   };
>>   
>>   
>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>> index 608bcf066e..c7f576290f 100644
>> --- a/io/channel-socket.c
>> +++ b/io/channel-socket.c
>> @@ -37,6 +37,11 @@
>>   
>>   #define SOCKET_MAX_FDS 16
>>   
>> +#ifdef QEMU_MSG_ZEROCOPY
>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>> +                                             Error **errp);
>> +#endif
>> +
>>   SocketAddress *
>>   qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>>                                        Error **errp)
>> @@ -65,6 +70,7 @@ qio_channel_socket_new(void)
>>       sioc->fd = -1;
>>       sioc->zero_copy_queued = 0;
>>       sioc->zero_copy_sent = 0;
>> +    sioc->new_zero_copy_sent_success = FALSE;
>>   
>>       ioc = QIO_CHANNEL(sioc);
>>       qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
>> @@ -566,6 +572,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>       size_t fdsize = sizeof(int) * nfds;
>>       struct cmsghdr *cmsg;
>>       int sflags = 0;
>> +    bool zero_copy_flush_pending = TRUE;
> It'll be nice to add some comment above this variable explaining the issue.

sure

>
>>   
>>       memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>>   
>> @@ -612,9 +619,21 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>               goto retry;
>>           case ENOBUFS:
>>               if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
>> -                error_setg_errno(errp, errno,
>> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
>> -                return -1;
>> +                if (zero_copy_flush_pending) {
>> +                    ret = qio_channel_socket_flush_internal(ioc, errp);
> Calling a socket specific helper in generic qiochannel path may not be a
> good idea.
>
> Maybe we could still stick with qio_channel_flush(), but insteadx add a new
> parameter to qio_channel_flush(..., bool *succeeded), only pass in
> "succeeded == NULL" here, not collect the cached result. Then the other
> multifd use case it can pass in a valid "succeeded" pointer.

sure

>
>> +                    if (ret < 0) {
>> +                        error_setg_errno(errp, errno,
>> +                                         "Zerocopy flush failed");
>> +                        return -1;
>> +                    }
>> +                    zero_copy_flush_pending = FALSE;
>> +                    goto retry;
>> +                } else {
>> +                    error_setg_errno(errp, errno,
>> +                                     "Process can't lock enough memory for "
>> +                                     "using MSG_ZEROCOPY");
>> +                    return -1;
>> +                }
>>               }
>>               break;
>>           }
>> @@ -725,8 +744,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>   
>>   
>>   #ifdef QEMU_MSG_ZEROCOPY
>> -static int qio_channel_socket_flush(QIOChannel *ioc,
>> -                                    Error **errp)
>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>> +                                             Error **errp)
>>   {
>>       QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>>       struct msghdr msg = {};
>> @@ -791,15 +810,34 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>>           /* No errors, count successfully finished sendmsg()*/
>>           sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>>   
>> -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
>> +        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
>>           if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
>> -            ret = 0;
> After this change, IIUC this function will return either -1 or 1, never 0.
> Not sure whether it's intended.  May worth add a comment above the function.

yes, this function won't return 0, but it is anyway a new and internal 
functions?

qio_channel_socket_flush() will still have the same behavior.

>> +            sioc->new_zero_copy_sent_success = TRUE;
>>           }
>>       }
>>   
>>       return ret;
>>   }
>>   
>> +static int qio_channel_socket_flush(QIOChannel *ioc,
>> +                                    Error **errp)
>> +{
>> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>> +    int ret;
>> +
>> +    ret = qio_channel_socket_flush_internal(ioc, errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (sioc->new_zero_copy_sent_success) {
>> +        sioc->new_zero_copy_sent_success = FALSE;
>> +        ret = 0;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   #endif /* QEMU_MSG_ZEROCOPY */
>>   
>>   static int
>> -- 
>> 2.43.0
>>

