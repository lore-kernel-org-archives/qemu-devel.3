Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C076BC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmzc-0000FJ-29; Mon, 11 Mar 2024 17:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjmzY-0000Dh-J0
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:15:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjmzN-0004o0-Ky
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:15:28 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BIY7e7028152; Mon, 11 Mar 2024 14:15:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=AhoZtH5DvG8f
 AjMMl4I0iLK3ZlcIdSCNfISck2QoBWY=; b=UcX/NG1DZ9BU0IFIvgScpC0dJlYP
 a2UYfGir4rWwVWLWXpg9n9086AjlFRYqeIkNsSSJsAif8iGcw8suO9p0ExKaunCP
 stDDAhAiyFG/Q/fyEa50l7hds2lwKoyjBuRdwr/9lYOj0fjrZiUDPzW8l91GSO6O
 27oqJIUyBTI98KPTq/0CAGnjRt3YCkClNuD7Elg6ffXltj++Y12BvicxPxDYWh70
 YHi2VMxC75atIYCLExtmAISz29V0pPUlR6jqPOtgjIY4VHiUg7gY+GUD8E1TiZha
 knvoHkY0mtX47bwaC6yNCATaI0zLRz2L5xr3P964JFZRWVcpiuhHHv9v+A==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr70v400-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaVeSuBXclEbdoVsBMRKAWXJ8jAs7snNvpwCxvbYSWfoxQOaeF28/4LVZPAvgL/VX9bdgmwp9vX/5QX/oIBG9rAfz+AURNmcp7K0UjODJGUSQdLugqk6VbFHqeLJmnI/BujiGWhHjzVSyEgrhqm+TrH0KoFpB/8Avd/3xFCKPK2qoIy+fYU7/x8VPU8V8M+TcPtGOxSEu8IS7Oel2cgOD3Wm/e6vNA6O7hlXqnO/zF27DFrceWw/E7Z3kD5mVuyYS32z0Whk31vgnwDoO0viP1XrqYrNS0hoBp7iMZ0nd9jsDxr8wkZc4zx9L2R5iI3Igiq/W8VO+ISTVLkkQoYFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhoZtH5DvG8fAjMMl4I0iLK3ZlcIdSCNfISck2QoBWY=;
 b=T9BqP7ymSunpX8P9QhwovWicse+zFj7hDVT03QYiNydEBwTOQ1b2iKczvWgr1TllXE1zDrF9FaatYWp35qgkSCn2HQ9tq3i7bffZw7geJ6scSs9UwSCXqT/JFuqwzdtEvWtfmQNtn0lsHrSyMd3SttUt/RX0elFLewMSHQrHyIG7cvlGV0KynED+EwxTbmWG/SHcNphZMT7Dkdy5ja2N8hedEvMc39eeMlZ3yAk19/4w0j02cQNHohtcnlHB4NPu3m+TRByh+MGy5PtFmcpikYCK02YFf9+1tlgh/EOf8KIb+nTcLxP8PpcD/WQkF6woDM1X+27FRY7CLHc8OkTJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhoZtH5DvG8fAjMMl4I0iLK3ZlcIdSCNfISck2QoBWY=;
 b=YZRhPXg7AM0gI8MnUDWda8CkRehpyD/vOfUDi2wQlUox5GodC8m/VOq9st1pzOVssDfhXrZzbhu7vDPJ9bsdvY8wqXNq+EPEMIiJz2QizRVOn7Le+v4u1RkxJWzDYL5jtMGwcSLT0WG835nDchcsXMJFn5yW2zNVAVNYAQof55p5g34sk4GDOxJ8Kx6BFPJHdkTKuKXNOqvGSa89Q8xVvUKT+J/DfqPfmRcS6MA98BDrLC8VYpg7APhuDlnLD5rXuEZkrV63nvyrS2TbNsZBeJ5NtJy98X32wtHSFUKeoGBYyYO2t6+tSHVi75qbJBQMbx6N+86ATwwphmKDOrYnrw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by LV8PR02MB10336.namprd02.prod.outlook.com (2603:10b6:408:1f5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 21:15:09 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:15:08 +0000
Content-Type: multipart/alternative;
 boundary="------------K71uJXTwzdJBdTFUc7ZE9aWR"
Message-ID: <e63d530f-11a0-47db-8377-da855f1bab10@nutanix.com>
Date: Tue, 12 Mar 2024 02:45:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] Add migrate_set_ports into migrate_qmp to update
 migration port value
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <20240308205951.111747-6-het.gala@nutanix.com> <87r0ggmwzm.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87r0ggmwzm.fsf@suse.de>
X-ClientProxiedBy: MA1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::36) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|LV8PR02MB10336:EE_
X-MS-Office365-Filtering-Correlation-Id: 193420ef-83dc-4ae4-9f68-08dc42105494
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAgjZ5mFOBhDTMrhtuXpaYABOYtaWfzxp2MoAyzeY+MTPOHZOYu2TTe6qwqnLMl7Sm0rX9JSS1JRweuMiwQvvm6wQBmf5Pyo1zFgMJ58IfFRP7sCTlbjo/9R6Z4ASUo63ndWOhh9tyL2nTBhmcsJCARr8omBOGUNIUbk3NQZwfH4o+6IHbU2NUKw6D6u/rRitXv+TWXXIpyWqEtV+mwWqh0S1p6XWi2ed3Bw5vehcCb130K1lHUIOd6z/9dpfhqzoaN4dxEjLjI0nMN8tQvq+LiapfB69EIx+jJZwHJPubJgQU2v78Z0aQ+6/aDNRWN1tTb/prt4xNMT/GZ+mV6wZG+b0Mw5Vr0yVeCRRtjmI1rWg/Pl8OD9QCBstq+2X8ttOwqzypQbayX38ah4Rtvbik4qxu+vKLHISXB/Nu8zooT9kM9ekl8Ce36bxc2Mq0tbHLNimnxsnukDpwIYe1UBW8RMHixFuJeVT5Qa9lXGkPDp4k64ilRsUC/Jd9mwK3ycQa11bn4p8VcVRBuMR/FpKv0L+8/bOe8BT3XiaTYCN7ELnUX7vK0gbBtLg0hGWUqu1aLgX7jUDba7kikTF9KB5jb0v2G1pDEWbZAOB6Il2QYVw/5Kfn+DY5LSbWOrA3eXF8JciSPXZyKOqXFwNDB/Xl9K8TMx5bRcx1LP4w9yFyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elpUd0lXb0N2S2xZNnlCUEp4MzRLcTkzUm5RTlFHVkJmNklvOWQ0a3ZQOVZX?=
 =?utf-8?B?bjZtSHZ0bHVLZW9oNkdGd0JLSHlEaUl3a3VKK2pxazdWbXhxMzZyN0dFTTJY?=
 =?utf-8?B?Q3dXQ0NlaC9reHl4UHJZZFRHM3c0ZmllKzBIdkcvekpzUG1nalY0S1gxUlpJ?=
 =?utf-8?B?Qk02WmtUdVZuZHJhOG5kQjZ3Wmp5QWJrUjQ0QjY0Z2VNTE9qekhjMlJIcGhm?=
 =?utf-8?B?Qytzem1TSndWZDhuTWwwN2lTdEVCNHVlUTFIVEdVVC8wazFrS2VLQWNERmpH?=
 =?utf-8?B?Z21vNEEzR09YUlZiaHVlSm1Tcm9QaHdWSnRpcy9lcFhBais2VktaWXhhZkdq?=
 =?utf-8?B?Q3BUWEhkNkc3STlkSm5EVGVpNXlzYzhtYWNYNklkaXJpaTVoWHZybHZFeTBq?=
 =?utf-8?B?OFJYTVhGYldhRzM0cEsreVJONVFEWkpFKzRTNzh1N05VZ0tweXdCRjNsSU41?=
 =?utf-8?B?TEtmMkozL1FIR2NMOEhJRkF5UUZQRHlMbHBBYjZUakFzYnNBbE1qZ2lqVEw3?=
 =?utf-8?B?MXAwaFZvRmZQQkNvaGFHRlAxMkMrR3MrTWZlTDhybUgvK2YrSGdqaGN6cUpy?=
 =?utf-8?B?a0ovRW5mTDZFTHFjOEdtczAxdk4rNWdNd1ErQVRyRjhOMWE3Sk5PZFZ3Yi9S?=
 =?utf-8?B?UHI0OFlTdWRteFNNMVZ4Tlo4UTlKSmorMEIrQlYwUWFabjRQeXRSeWFGYnNH?=
 =?utf-8?B?dWFhOERMU1BUOWFaZnFsbFd5WTJqYnhLaTlneElKNWIyRERGZC9xSCt1RnhJ?=
 =?utf-8?B?TmxTbUxPbEkyZ1E0SWg2aU85dU9XOFpWNDZvTUs4eU9wZ1hVb1VMTHlJQ2Iz?=
 =?utf-8?B?S1I3MUdiT1BYNHhzZ090Y1dlcE1uajJBV2lJNUgrcCt2ODdoNlFQZE5zRWVY?=
 =?utf-8?B?cGVDUFVGWmJ4OWttMWdLaDdqaVFkSk92M1NZdndpZGZBNm84bDlxak1TdVR1?=
 =?utf-8?B?cWowcGFLOXRlbFN1eDBrbUNVcGZ3ampScU5NSUhNUi9FRGFJRkdUZ2lVVkdF?=
 =?utf-8?B?eXU4NFpIeGFFdndwMlVaMXYyYUFmYnhVSU4yM3RpVUw4ZFl0bE1jdHJiWE1n?=
 =?utf-8?B?OFg1OEFlV1ZFbDJ1a2N4Q2FsZitLM2NiVUx2UTdHM0Mzb0RqcnBERXd5YkRS?=
 =?utf-8?B?N1QwdFRKSDJUa2thdXo0bXdhbW9sMXJvdERPeWZjQ3hlbWNKNTh2T0JqU1Ey?=
 =?utf-8?B?WFMwL1pHUSsvQjJZNGd1QWpONG5zT3l4enEwMG50M0dCb2xIRG5rQjN6Tmtp?=
 =?utf-8?B?bGhkZlhjVTlvQmVYYzMrVGljeFpxL1J0NzJwWTVJaWVvaW5jbWVFR1hORmd5?=
 =?utf-8?B?ODJZeFYwcS9RNHVEb21ST2xSTHYxQXpSSTBWNFJ4Y0syRlpVVWh5OG5wSGw5?=
 =?utf-8?B?YVB2SXZvWlNCNzU3SkRoQlB0dklmMXN1SUZtRjE2cEo2OGVYZklOTHVVdElK?=
 =?utf-8?B?aVJUemtadm1YZU5CN2YzWFdTeW1KQkxWeHNZV2Zrcy84ZWVxYzBZVWpHZDJh?=
 =?utf-8?B?bjF1NVQ4RzU0ak1OdHErT2N6dE5xNWtuRGdhcS9lclc3eUNERzkxeUR4cDl6?=
 =?utf-8?B?OWZydHRTNS9mbFRHZXFxYXNsbWFKeExZZEYwY25sVUdza1JLRmRoRFU5VTY2?=
 =?utf-8?B?YnNueEdFTHBud2RkWGZBMUdCN3dEYk9PUE1jKzg4V00vTENQVHFub29FazBu?=
 =?utf-8?B?RnJ2VW90Q0lkZVQrNXNOcUNhRkxJVzJTajV1bG14bUx3NXVkQndDUmQ4UGMx?=
 =?utf-8?B?RWpVRGtORFYyVjFmU25OM0JEdGRsMjlhYVhpS2xtVSsvc1NSZlUrUkVpMjBq?=
 =?utf-8?B?VXZNcXhQUkdieGw3Mjk3UDNuYi8rRitEdGZIaTBvK0FyT1NzOHpEV0g3Q0xE?=
 =?utf-8?B?WFFBb2hTZ29GeDNBQTFCUC9obkIzN0lwWmwrNkVnMlFFU05Ld0xZNjU1d1hJ?=
 =?utf-8?B?cEZhalVBQnJmSGhYNUJGeGRSbUMwZVc0bktKNnJLemU5YkxBYmNYWGJRUzEy?=
 =?utf-8?B?aStsZXBRUHNwaW1mT3FZdkNaYlN4d2VoMStlKzYxS3FqdVU2WDBuVjJ1b1Nv?=
 =?utf-8?B?cXdqZFgrMlVkMUlsMXNPMGpKZjlPZEtjQmFCNVFFRWhnWk9NYlpCWkpHeFVo?=
 =?utf-8?Q?BYnSLPl8RDvWReq2jdMzexOnJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193420ef-83dc-4ae4-9f68-08dc42105494
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:15:08.8722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGdUny/ZP6J/eYYPUlQyeqp46gSplBeSzN4stGxHIzHkUtOqkZJoQniJ4hbgxjyQlfqvHafjwr97dvf3xUIQgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10336
X-Proofpoint-ORIG-GUID: N9homX5qzn_vsKk3o5smtNNVaJorjXpV
X-Proofpoint-GUID: N9homX5qzn_vsKk3o5smtNNVaJorjXpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--------------K71uJXTwzdJBdTFUc7ZE9aWR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/03/24 12:12 am, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> migrate_set_get_qdict gets qdict with the dst QEMU parameters
> s/set_//
Ack
>> migrate_set_ports() from list of channels reads each QDict for port,
>> and fills the port with correct value in case it was 0 in the test.
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>> ---
>>   tests/qtest/migration-helpers.c | 73 +++++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index 91c8a817d2..7c17d78d6b 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -17,6 +17,8 @@
>>   #include "qapi/qapi-visit-sockets.h"
>>   #include "qapi/qobject-input-visitor.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qmp/qlist.h"
>> +#include "include/qemu/cutils.h"
> Extra "include/" here?
Ack
>>   
>>   #include "migration-helpers.h"
>>   
>> @@ -49,6 +51,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
>>       }
>>   }
>>   
>> +static QDict *SocketAddress_to_qdict(SocketAddress *addr)
>> +{
>> +    QDict *dict = qdict_new();
>> +
>> +    switch (addr->type) {
>> +    case SOCKET_ADDRESS_TYPE_INET:
>> +        qdict_put_str(dict, "type", "inet");
>> +        qdict_put_str(dict, "host", addr->u.inet.host);
>> +        qdict_put_str(dict, "port", addr->u.inet.port);
>> +        break;
>> +    case SOCKET_ADDRESS_TYPE_UNIX:
>> +        qdict_put_str(dict, "type", "unix");
>> +        qdict_put_str(dict, "path", addr->u.q_unix.path);
>> +        break;
>> +    case SOCKET_ADDRESS_TYPE_FD:
>> +        qdict_put_str(dict, "type", "fd");
>> +        qdict_put_str(dict, "str", addr->u.fd.str);
>> +        break;
>> +    case SOCKET_ADDRESS_TYPE_VSOCK:
>> +        qdict_put_str(dict, "type", "vsock");
>> +        qdict_put_str(dict, "cid", addr->u.vsock.cid);
>> +        qdict_put_str(dict, "port", addr->u.vsock.port);
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +        break;
>> +    }
>> +
>> +    return dict;
>> +}
>> +
>>   static SocketAddress *
>>   migrate_get_socket_address(QTestState *who, const char *parameter)
>>   {
>> @@ -83,6 +116,44 @@ migrate_get_connect_uri(QTestState *who, const char *parameter)
>>       return connect_uri;
>>   }
>>   
>> +static QDict *
>> +migrate_get_connect_qdict(QTestState *who, const char *parameter)
>> +{
>> +    SocketAddress *addrs;
>> +    QDict *connect_qdict;
>> +
>> +    addrs = migrate_get_socket_address(who, parameter);
>> +    connect_qdict = SocketAddress_to_qdict(addrs);
>> +
>> +    qapi_free_SocketAddress(addrs);
>> +    return connect_qdict;
>> +}
>> +
>> +static void migrate_set_ports(QTestState *to, QList *channel_list)
>> +{
>> +    QDict *addr;
>> +    QListEntry *entry;
>> +    g_autofree const char *addr_port = NULL;
>> +
>> +    if (channel_list == NULL) {
>> +        return;
>> +    }
>> +
>> +    addr = migrate_get_connect_qdict(to, "socket-address");
> addr needs to be freed.
Ack. Thanks for pointing this out
>> +
>> +    QLIST_FOREACH_ENTRY(channel_list, entry) {
>> +        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
>> +        QDict *addrdict = qdict_get_qdict(channel, "addr");
>> +
>> +        if (qdict_haskey(addrdict, "port") &&
>> +            qdict_haskey(addr, "port") &&
>> +            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
>> +                addr_port = qdict_get_str(addr, "port");
>> +                qdict_put_str(addrdict, "port", addr_port);
>> +        }
>> +    }
>> +}
>> +
>>   bool migrate_watch_for_events(QTestState *who, const char *name,
>>                                 QDict *event, void *opaque)
>>   {
>> @@ -141,6 +212,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>   {
>>       va_list ap;
>>       QDict *args;
>> +    QList *channel_list = NULL;
>>       g_autofree char *connect_uri = NULL;
>>   
>>       va_start(ap, fmt);
>> @@ -151,6 +223,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>       if (!uri) {
>>           connect_uri = migrate_get_connect_uri(to, "socket-address");
>>       }
>> +    migrate_set_ports(to, channel_list);
>>       qdict_put_str(args, "uri", uri ? uri : connect_uri);
>>   
>>       qtest_qmp_assert_success(who,
Regards,
Het Gala
--------------K71uJXTwzdJBdTFUc7ZE9aWR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/03/24 12:12 am, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87r0ggmwzm.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">migrate_set_get_qdict gets qdict with the dst QEMU parameters
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
s/set_//</pre>
    </blockquote>
    <font face="monospace">Ack</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87r0ggmwzm.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">migrate_set_ports() from list of channels reads each QDict for port,
and fills the port with correct value in case it was 0 in the test.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
---
 tests/qtest/migration-helpers.c | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 91c8a817d2..7c17d78d6b 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -17,6 +17,8 @@
 #include &quot;qapi/qapi-visit-sockets.h&quot;
 #include &quot;qapi/qobject-input-visitor.h&quot;
 #include &quot;qapi/error.h&quot;
+#include &quot;qapi/qmp/qlist.h&quot;
+#include &quot;include/qemu/cutils.h&quot;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Extra &quot;include/&quot; here?</pre>
    </blockquote>
    <font face="monospace">Ack</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87r0ggmwzm.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
 #include &quot;migration-helpers.h&quot;
 
@@ -49,6 +51,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
     }
 }
 
+static QDict *SocketAddress_to_qdict(SocketAddress *addr)
+{
+    QDict *dict = qdict_new();
+
+    switch (addr-&gt;type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        qdict_put_str(dict, &quot;type&quot;, &quot;inet&quot;);
+        qdict_put_str(dict, &quot;host&quot;, addr-&gt;u.inet.host);
+        qdict_put_str(dict, &quot;port&quot;, addr-&gt;u.inet.port);
+        break;
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        qdict_put_str(dict, &quot;type&quot;, &quot;unix&quot;);
+        qdict_put_str(dict, &quot;path&quot;, addr-&gt;u.q_unix.path);
+        break;
+    case SOCKET_ADDRESS_TYPE_FD:
+        qdict_put_str(dict, &quot;type&quot;, &quot;fd&quot;);
+        qdict_put_str(dict, &quot;str&quot;, addr-&gt;u.fd.str);
+        break;
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        qdict_put_str(dict, &quot;type&quot;, &quot;vsock&quot;);
+        qdict_put_str(dict, &quot;cid&quot;, addr-&gt;u.vsock.cid);
+        qdict_put_str(dict, &quot;port&quot;, addr-&gt;u.vsock.port);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    return dict;
+}
+
 static SocketAddress *
 migrate_get_socket_address(QTestState *who, const char *parameter)
 {
@@ -83,6 +116,44 @@ migrate_get_connect_uri(QTestState *who, const char *parameter)
     return connect_uri;
 }
 
+static QDict *
+migrate_get_connect_qdict(QTestState *who, const char *parameter)
+{
+    SocketAddress *addrs;
+    QDict *connect_qdict;
+
+    addrs = migrate_get_socket_address(who, parameter);
+    connect_qdict = SocketAddress_to_qdict(addrs);
+
+    qapi_free_SocketAddress(addrs);
+    return connect_qdict;
+}
+
+static void migrate_set_ports(QTestState *to, QList *channel_list)
+{
+    QDict *addr;
+    QListEntry *entry;
+    g_autofree const char *addr_port = NULL;
+
+    if (channel_list == NULL) {
+        return;
+    }
+
+    addr = migrate_get_connect_qdict(to, &quot;socket-address&quot;);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
addr needs to be freed.</pre>
    </blockquote>
    <font face="monospace">Ack. Thanks for pointing this out</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87r0ggmwzm.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
+    QLIST_FOREACH_ENTRY(channel_list, entry) {
+        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
+        QDict *addrdict = qdict_get_qdict(channel, &quot;addr&quot;);
+
+        if (qdict_haskey(addrdict, &quot;port&quot;) &amp;&amp;
+            qdict_haskey(addr, &quot;port&quot;) &amp;&amp;
+            (strcmp(qdict_get_str(addrdict, &quot;port&quot;), &quot;0&quot;) == 0)) {
+                addr_port = qdict_get_str(addr, &quot;port&quot;);
+                qdict_put_str(addrdict, &quot;port&quot;, addr_port);
+        }
+    }
+}
+
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
@@ -141,6 +212,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 {
     va_list ap;
     QDict *args;
+    QList *channel_list = NULL;
     g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
@@ -151,6 +223,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     if (!uri) {
         connect_uri = migrate_get_connect_uri(to, &quot;socket-address&quot;);
     }
+    migrate_set_ports(to, channel_list);
     qdict_put_str(args, &quot;uri&quot;, uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
</pre>
      </blockquote>
    </blockquote>
    <font face="monospace">Regards,<br>
      Het Gala</font><br>
  </body>
</html>

--------------K71uJXTwzdJBdTFUc7ZE9aWR--

