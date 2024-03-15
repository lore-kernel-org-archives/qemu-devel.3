Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DE9C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 20:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlEGP-0005Jz-BY; Fri, 15 Mar 2024 16:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rlEGM-0005JV-LN
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 16:34:47 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rlEGH-0004hR-4Q
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 16:34:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42FFRe5B011623; Fri, 15 Mar 2024 13:34:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=nmUj8mSAA5xG
 tneH5NyWAhPOIC/IG8JSGLTVI5+J8A8=; b=emKELwuhUxYeG1zZcPTi7/nhhfd+
 fBeGxjaysgLvbzaILvhZQfXUITGeLuRXaqspEX0x0nj3iKBs6pv6RCGFspuGMxpl
 1keTfR6VA/CDrRWP5wQ56DfVKIvO8Q9ubHBUby7mPe6EVwthW7TYfdKIWsN0cJJg
 zHH+sotGiHuUkw7onNaodnDJSqHiUY1c8C6y7dS1C4WPlTmGe4lMx2ZHV1G1CKmu
 8qUmRjN2cqSdzavTCohePac5Qcp7wzbmJRfGh21EiwGGAAF/0JqWBFNODfzoo5k3
 aBDPDL7F9hhjSn4euwm/2mSF1CFgD0wxlhlMh+Bpz96+cfnd5AvIr3th0A==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wva09t4fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 13:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZu4TTM5UC6r6NuP4GghjS2FSqyXylma5+mhO1gzURWOIFA6dYdoCgL553qWRQ2gbV/TG/gnL4Q4PISb4pxFI+ACQIhA70QxJ7C6tWbqiAIpZlR9ddbpPsU7mjYM24g443HRgfCwXrI6NBteRDy+SSNGHzUzt8JwirwUSIxxoL1X6L5MldEFjW+tNDB8bEH0zHr/pUJX9Gbm1u3AeRij0UckAgLxnICcqv1QeboiG0AuZ1uCyvBoNl8Oh4SSoRYVjGOh5pxWhk5IFP/R+dopCd/9Pt7FpmhsMKG/0UV+4L1tBlEJZ8b7oR2vKfNNfMQoABl/f1qW06BcP0/74sMqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmUj8mSAA5xGtneH5NyWAhPOIC/IG8JSGLTVI5+J8A8=;
 b=JRq0wRZtmbXGRkLzkezlNvtHkXlP7BtVCD6Axb/LDpPmcnHSgEldiXC+E7lQLHTrPxZwix/JjazE3YDbhgMVsiadGQXxJWPtw5Sw1+OAFx+SF/fYPqPhECqPBn17I7jNZpzv/YsD4ZPTq7CEEKEM67R6vdlFFISoorQcwoesKlTHh0j4I7KCMWPNWn+BV9m28X0wCDPhdYWAXP02OAmAiU+8WEdWljt9kkP5qZy29mk9/JcTF9dBarpJimP/I2WeeS8AQn3vDBM0Afb5jZBrDYkkiQfZweXNppOWXbVkxtqWWDdS0txECtQT1s/uPw5K+szmhD3k/zXWBtQKnYoLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmUj8mSAA5xGtneH5NyWAhPOIC/IG8JSGLTVI5+J8A8=;
 b=N8ofyc8gPcnMTldjcwBhXdnhxKOg/ve4ZtdY4d5JgLrO+nZFRZM9nZo6elfoyzwmUEMl1i9JPCttYceu8KhMwJRLXkshDRL2817F9EWy78NgxrWJpYFPeR0tTAwEt6oUt+SpEe+6fMmv4hRLD6psuDCnPp4yB0Jye4ym4D7WA6BAu7MsDAkDdeJNIbEhvKT5atXLxK9ZKzHUhp2l0lpMhySxbQruHjpAEsghqjrXIRV2i31VT9PW68MLOn2772r4nCRHDSuzG9CXBS9AZvHB48KzS2wQX+gjlFkWLbFlRiqpT2dPKkL4ECtlnTBx0t7nbxBeDgWtdztebKVscco+fQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB10217.namprd02.prod.outlook.com (2603:10b6:610:1be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 20:34:35 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 20:34:34 +0000
Content-Type: multipart/alternative;
 boundary="------------UVhyv1tQIq5of3ieHTgJM1zT"
Message-ID: <c25c8cf7-ea28-4c5f-962a-1fe5abc51870@nutanix.com>
Date: Sat, 16 Mar 2024 02:04:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] tests/qtest/migration: Replace
 migrate_get_connect_uri inplace of migrate_get_socket_address
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240312202634.63349-1-het.gala@nutanix.com>
 <20240312202634.63349-4-het.gala@nutanix.com> <871q8b8xeg.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <871q8b8xeg.fsf@suse.de>
X-ClientProxiedBy: MA0PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::18) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH3PR02MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: 568b2463-b597-4ee6-555f-08dc452f5374
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31oKth+5vA/uR6YZIaOLusjb6SsErylx6PJEaOxW/XfB1JaJDUvgh/hCEu34VXHTVBoW82aiBnXJPB84DL4dUAg4RhGt6UNtZQcgGT5RhFkoRgRPliRZq17aAtblIjSRMQQ5zrgNZfpSK6B4zzB8ie2vgP6GXLB4WIVkHEqgbZwdr7nAwAJw1oMiSfTz+1vBcTGs0E8wLtdui1XHH53ncHHMja8Xc/tUTrNAR16s+8Q6BgNGD8etF9mjYsfS+Z0JNri6+Ppanb4s3PImgd6kVMdvneQoN2IWqjlF++vlkvjmj4ocXlvDtQ7JgZ+bVbcbb06fTD/Buub6ln/iGSDtigfdh5yI0r7aHXHyZk82AExUFJyD8/fI0un+gWGTVp67ZdWk54RDiNDsIGZbTsL1c7LoZS5G9LxnUBa4X4b1t4F7Jq8TELJBt8nSnDKL4pwnOJ5xidHMrUBwZjkTcc34yJ0yWdduy4oE7zMUM7/2zOQUJEgFmYjdjzHI5EIzgpHp852CNWwZ0Q7OkWKPURf35GbGbLlVp4WhtvuaHDSGRzp955OKd1guR6V1caBBD79ioiSep2lhi+WiIBS3dEGYrmxaBPsThGRD2flYZVeTge6UD6SPIAG9VSCJOlWIsTbFW7jpT58Iuxpff8jRv15w2oI8plMKchKvhYLRcUwyKVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5GU1U0bEt0MVc3Q2ZXemRCQnFYNzlENnBtSWxXTTdUUFpMemhUVnFRT3gv?=
 =?utf-8?B?Nm9tRDBoR25yQ2ZaOW1DdGJMYjJkNUNESFduWkNJNUh0bTlrUFZSeXFQUDMx?=
 =?utf-8?B?TUQ0dk5QN1I3Sy8wd1BFYW5DS1hFb3hDYWwxRXBEVWk4N0lNL2VmcFdUUlRB?=
 =?utf-8?B?Z2o2dkI5UTZOKzhRNnk3M3c4MXRsWlNLMUd4SWl6NjNBeU9iNkFlQ21COHRl?=
 =?utf-8?B?SVNiOXJkY3p4bm42aU92NHRzL2lvcEFvTUF2djRmcURmOEdXSlBUMEtGUDZa?=
 =?utf-8?B?aWp3QmNOOVBLVE10aDNvV2dCelpaQVBqRWhEaEFzNGpvUlErOXVIMU9wdWhk?=
 =?utf-8?B?dUlFY2taZVJmeERYTHFwM3dRUm1yVUVBaUVVMWhqL3g3djZaWld3VHBjZEwy?=
 =?utf-8?B?WmtZU1pBVUJ3YlR0elV6a0RKZG9BcXhIUUJQZE9mdXFhWHpxUDZwRjE1TFZX?=
 =?utf-8?B?aFdmd1RzVXU0WkdScDJKeFp1TXpydWRUdGlZLzVyV3FDL3lkNWFNV3NUREho?=
 =?utf-8?B?Ryszd25YWDN5VmZTamxiT0RhNCtFRjdHVktTZnlUNHB3K1ZRbHFrdjU0cGFM?=
 =?utf-8?B?TzFyQXk1anArbFdpVkd6akovTTkwMnhkWk9QdkVraW15N204SkdRYm0zbU5r?=
 =?utf-8?B?bDd0SXlzZWppMFd0dkpkZXJUdnVWcUtJUEs4ckRZcSswQ00wN1ROWm51WURv?=
 =?utf-8?B?UHBJdHJQMDN5TFdheHVBclhncXROU29rYnZhVHBtRE9Db3AvMHY0QmVONEZH?=
 =?utf-8?B?bDVVV3NKelYrL3pKVkd6ZEh0SEhDOEVpVFQvWW9pcHNSemtxcklCbGVmWkFQ?=
 =?utf-8?B?NUJKamxpTUpBa2orc0lnNlJXTEhMNzV6ZUtTM1Q1aTlTYjhTN3diczQxaWp4?=
 =?utf-8?B?ekdXMXkrMkZkYVM4UUFoTDlsekJ6ZDNEUHY2VVNoTlFDUllGcG9GMTkvZnNE?=
 =?utf-8?B?by9JWGlaUU1lc1p6dDhYS00wMmEvc3NCK3lWTlR2UEtZYU5LdjNVSFJRbTVq?=
 =?utf-8?B?bGZXN2l2UGZZTWhGcVFXOWtkczFOZkgvRkM4RHZYMUFWbnpDOUhQaFB1Nk0w?=
 =?utf-8?B?ZjBQemx5VlVoUVM0VWNyenFkTjJtb1JveE80YWNhTmJFelpFUGlsTHBMSXBL?=
 =?utf-8?B?Q0M0aDQ1bC9KV1NRdytiajBQYllCektVZ2hEbHMydlY2cy8xZEtmMy9RSEMv?=
 =?utf-8?B?Q1JhNTlvRFhSams1eWtqYU5Vay9nK1crSHhuc3ZZMTJzSW83dUhQalVwN3Bw?=
 =?utf-8?B?MEljaThCWjJCZUlJRHZTNDNyVGxyZGovcjFGYlA5Q0dnTUV2citKRThuaDhJ?=
 =?utf-8?B?RU95MytXYWxiN3p4SmI5T01abDduQ2FZK0RwdjdBdjRNQkpPZllweEUwQ1Bn?=
 =?utf-8?B?WnltSlpFcDVSUHVmME9aQTJ5L0pQQTVHOXJSS0t2OWQvc2MzZGsrelZQVUJ1?=
 =?utf-8?B?L0xFdlVlaTJDV2FuSlBlNFUyNlFCMUUwbjAxNWMyMlBuWkZTOHUySEtqSnM1?=
 =?utf-8?B?VTNZWkJLa1k5RkxoWHRscVlVOFNwR25mNDV1dThGdXo2cm4vZXQ4MnVsL1Jt?=
 =?utf-8?B?NmlNUzM5cUtSVWhMbDA2WXJDYStNM29ZVU9INWtUVWdzY2Y1ZmluKy9oWm1M?=
 =?utf-8?B?dmY3MXpGeHdFaTd4VEFZbDlDc2x2VWwwR0RLZFBvU3pEVkhkQjNqZlZiU3Fo?=
 =?utf-8?B?dzNrN3VUWUNSME14YTlSTlpoV01vblFzODJPN3BqLy9tWi9uR1R1MTJUVmM3?=
 =?utf-8?B?Z1VxWG1ocFJJamNwOFkrdzRSTktYSmtadU1qM1VCSTFJL0FtRG92MU5NSUZ6?=
 =?utf-8?B?YmlEWGhQd2lDcVRscG9jelVENEFIeWtrWW1Lc3gwWVZYZzVHSExYMU9IRERm?=
 =?utf-8?B?S0svd1h4QWoxNWJ1cDZrMFRFRFBHaWZlZ1ZhTVh5eGI2cVovTDZmZHhmbFRM?=
 =?utf-8?B?bStIekFwNFNIaEhheHp2VWh6Y1lVdWdTTWJBdzZ0ZjBYUzlYK3BsSkdlQW5l?=
 =?utf-8?B?UGFGY0VnY20xWnoyMmlKSHQxOFIrUUp5c0RFdG1QOWM2ODdUc29qNEJJVDE1?=
 =?utf-8?B?dkUvRDl4VTluOThKRURMWElRT1VoeHZXODR1Q2czMjJ3SkR4RndrczQwb29J?=
 =?utf-8?Q?MUZjgydjQupuqIyMOEKA5/Lgj?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568b2463-b597-4ee6-555f-08dc452f5374
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 20:34:34.8669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cxforlw3MFtobsWykhfkKmUEBOmvoElfh7bNcN4Yg96h91nIrHL0onMN2svS/hyVhAXyFuKwJ/NCthf3sp1GUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10217
X-Proofpoint-GUID: OrweHn9gEPnMiW152O_9343EqRvqLaf6
X-Proofpoint-ORIG-GUID: OrweHn9gEPnMiW152O_9343EqRvqLaf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_07,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

--------------UVhyv1tQIq5of3ieHTgJM1zT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 15/03/24 6:28 pm, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Refactor migrate_get_socket_address to internally utilize 'socket-address'
>> parameter, reducing redundancy in the function definition.
>>
>> migrate_get_socket_address implicitly converts SocketAddress into str.
>> Move migrate_get_socket_address inside migrate_get_connect_uri which
>> should return the uri string instead.
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>> Reviewed-by: Fabiano Rosas<farosas@suse.de>
>> ---
>>   tests/qtest/migration-helpers.c | 29 +++++++++++++++++++----------
>>   1 file changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index 3e8c19c4de..8806dc841e 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -48,28 +48,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
>>       }
>>   }
>>   
>> -static char *
>> -migrate_get_socket_address(QTestState *who, const char *parameter)
>> +static SocketAddress *migrate_get_socket_address(QTestState *who)
>>   {
>>       QDict *rsp;
>> -    char *result;
>>       SocketAddressList *addrs;
>> +    SocketAddress *addr;
>>       Visitor *iv = NULL;
>>       QObject *object;
>>   
>>       rsp = migrate_query(who);
>> -    object = qdict_get(rsp, parameter);
>> +    object = qdict_get(rsp, "socket-address");
> Just a heads up, none of what I'm about to say applies to current
> master.
>
> This can return NULL if there is no socket-address, such as with a file
> migration. Then the visitor code below just barfs. It would be nice if
> we touched this up eventually.

Yes. I agree this is not full proof solution and covers for all the cases.
It would only for 'socket-address'. Could you elaborate on what other than
socket-address the QObject can have ?

> I only noticed this because I was fiddling with the file migration API
> and this series helped me a lot to test my changes. So thanks for that,
> Het.
>
> Another point is: we really need to encourage people to write tests
> using the new channels API. I added the FileMigrationArgs with the
> 'offset' as a required parameter, not even knowing optional parameters
> were a thing. So it's obviously not enough to write support for the new
> API if no tests ever touch it.
Yes, definitely we need more tests with the new channels API to test other
than just tcp connection. I could give a try for vsock and unix with the
new QAPI syntax, and add some tests.

I also wanted to bring in attention that, this solution I what i feel is 
also
not complete. If we are using new channel syntax for migrate_qmp, then the
same syntax should also be used for migrate_qmp_incoming. But we haven't
touch that, and it still prints the old syntax. We might need a lot changes
in design maybe to incorporate that too in new tests totally with the new
syntax.

Another thing that you also noted down while discussing on the patches that
we should have a standard pattern on how to define the migration tests. Even
that would be helpful for the users, on how to add new tests, where to add
new tests in the file, and which test is needed to run if a specific change
needs to be tested.

>>   
>>       iv = qobject_input_visitor_new(object);
>>       visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
>> +    addr = addrs->value;
>>       visit_free(iv);
>>   
>> -    /* we are only using a single address */
>> -    result = SocketAddress_to_str(addrs->value);
>> -
>> -    qapi_free_SocketAddressList(addrs);
>>       qobject_unref(rsp);
>> -    return result;
>> +    return addr;
>> +}
>> +
>> +static char *
>> +migrate_get_connect_uri(QTestState *who)
>> +{
>> +    SocketAddress *addrs;
>> +    char *connect_uri;
>> +
>> +    addrs = migrate_get_socket_address(who);
>> +    connect_uri = SocketAddress_to_str(addrs);
>> +
>> +    qapi_free_SocketAddress(addrs);
>> +    return connect_uri;
>>   }
>>   
>>   bool migrate_watch_for_events(QTestState *who, const char *name,
>> @@ -129,7 +138,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>   
>>       g_assert(!qdict_haskey(args, "uri"));
>>       if (!uri) {
>> -        connect_uri = migrate_get_socket_address(to, "socket-address");
>> +        connect_uri = migrate_get_connect_uri(to);
>>       }
>>       qdict_put_str(args, "uri", uri ? uri : connect_uri);

Regards,
Het Gala

--------------UVhyv1tQIq5of3ieHTgJM1zT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 15/03/24 6:28 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:871q8b8xeg.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Refactor migrate_get_socket_address to internally utilize 'socket-address'
parameter, reducing redundancy in the function definition.

migrate_get_socket_address implicitly converts SocketAddress into str.
Move migrate_get_socket_address inside migrate_get_connect_uri which
should return the uri string instead.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
Reviewed-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
---
 tests/qtest/migration-helpers.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3e8c19c4de..8806dc841e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -48,28 +48,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
     }
 }
 
-static char *
-migrate_get_socket_address(QTestState *who, const char *parameter)
+static SocketAddress *migrate_get_socket_address(QTestState *who)
 {
     QDict *rsp;
-    char *result;
     SocketAddressList *addrs;
+    SocketAddress *addr;
     Visitor *iv = NULL;
     QObject *object;
 
     rsp = migrate_query(who);
-    object = qdict_get(rsp, parameter);
+    object = qdict_get(rsp, &quot;socket-address&quot;);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Just a heads up, none of what I'm about to say applies to current
master.

This can return NULL if there is no socket-address, such as with a file
migration. Then the visitor code below just barfs. It would be nice if
we touched this up eventually.</pre>
    </blockquote>
    <p><font face="monospace">Yes. </font><font face="monospace">I
        agree this is not full proof solution and covers for all the
        cases.</font><font face="monospace"><br>
        It would only for 'socket-address'. Could you elaborate on what
        other than<br>
        socket-address the QObject can have ?</font><span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:871q8b8xeg.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">I only noticed this because I was fiddling with the file migration API
and this series helped me a lot to test my changes. So thanks for that,
Het.

Another point is: we really need to encourage people to write tests
using the new channels API. I added the FileMigrationArgs with the
'offset' as a required parameter, not even knowing optional parameters
were a thing. So it's obviously not enough to write support for the new
API if no tests ever touch it.</pre>
    </blockquote>
    <font face="monospace">Yes, definitely we need more tests with the
      new channels API to test other<br>
      than just tcp connection. I could give a try for vsock and unix
      with the<br>
      new QAPI syntax, and add some tests.<br>
      <br>
      I also wanted to bring in attention that, this solution I what i
      feel is also<br>
      not complete. If we are using new channel syntax for migrate_qmp,
      then the<br>
      same syntax should also be used for migrate_qmp_incoming. But we
      haven't<br>
      touch that, and it still prints the old syntax. We might need a
      lot changes<br>
      in design maybe to incorporate that too in new tests totally with
      the new<br>
      syntax.<br>
      <br>
    </font>
    <p><font face="monospace">Another thing that you also noted down
        while discussing on the patches that<br>
        we should have a standard pattern on how to define the migration
        tests. Even<br>
        that would be helpful for the users, on how to add new tests,
        where to add<br>
        new tests in the file, and which test is needed to run if a
        specific change<br>
        needs to be tested.</font><span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:871q8b8xeg.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
     iv = qobject_input_visitor_new(object);
     visit_type_SocketAddressList(iv, NULL, &amp;addrs, &amp;error_abort);
+    addr = addrs-&gt;value;
     visit_free(iv);
 
-    /* we are only using a single address */
-    result = SocketAddress_to_str(addrs-&gt;value);
-
-    qapi_free_SocketAddressList(addrs);
     qobject_unref(rsp);
-    return result;
+    return addr;
+}
+
+static char *
+migrate_get_connect_uri(QTestState *who)
+{
+    SocketAddress *addrs;
+    char *connect_uri;
+
+    addrs = migrate_get_socket_address(who);
+    connect_uri = SocketAddress_to_str(addrs);
+
+    qapi_free_SocketAddress(addrs);
+    return connect_uri;
 }
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
@@ -129,7 +138,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 
     g_assert(!qdict_haskey(args, &quot;uri&quot;));
     if (!uri) {
-        connect_uri = migrate_get_socket_address(to, &quot;socket-address&quot;);
+        connect_uri = migrate_get_connect_uri(to);
     }
     qdict_put_str(args, &quot;uri&quot;, uri ? uri : connect_uri);</pre>
      </blockquote>
    </blockquote>
    <p><font face="monospace">Regards,<br>
        Het Gala<br>
      </font></p>
  </body>
</html>

--------------UVhyv1tQIq5of3ieHTgJM1zT--

