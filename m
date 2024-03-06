Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB04C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 15:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsqp-0007tm-10; Wed, 06 Mar 2024 10:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhsql-0007tA-ST
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:06:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhsqj-0003j3-Ji
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:06:31 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 426DTgjJ012610; Wed, 6 Mar 2024 07:06:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=9kojiadfzCBE
 50gcnzYUeEKZ1Jrwn84/yI7brX9xv3M=; b=CNGqyVScM1W4vOnIgjl+wVzLlxdP
 Z2EqT8YXwV3ejunozagA1qPfREltH975eWBGBmUBlNzXReI/opuBBwqKFeT+C30a
 AOet+ERMEe113+m6Nr1MVr/ZKk0jDnaMkpmOlWWh2kQdrhcC6+RJdfn3Kijx+67Y
 8i0+ZHeKu1D+oVGOGoewB2WxKnsRbjlZAQvq6PvXOULo4noCD6RtcNczpIqxnIkb
 mf+17XqfMpGVqTBzDUbobaSiYNIGzhcUxjGeIe8IkRx+HvjABl1XoogQGoebBtJQ
 UF2a9Pwd7V66czEerDzDcxOLp9A4avtzPY8rWc1ng9iH86IInq6YChxRvg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm4j0rwwc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 07:06:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA4Z75omSLO6oPtsl96r3xHti4SickZF/OGtjsvPWQ+cDPXpYLHr0C0Y6q1Ae4poTRAdBUfpv21zFrtOBSUieisyu6ESnpBqxOFgCksI8OpcCL3W2QmOSLHBxbdeQxy/QR0zS2ug82XtvRIbw3PucgJFY0nlCCfKx5qvwSmRHA1/KdXlqEU9rGXD5ty+czIg3QYDQGl396vw4ZOC6eAWrb3ZxtLJDOOuATVh7EyfMpz0GYsOV3HglDIa9WLNcvIp3TxS5GUX4WwzNUVyKDs5GMJcGFi3UWHZUt7YlEo6olEhcXchOU2yZ6a2ps9m8v+hmUQrgZ1kAnVBpcYiRUj7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kojiadfzCBE50gcnzYUeEKZ1Jrwn84/yI7brX9xv3M=;
 b=DgNduWHd7loDNP/mFcTcSKkUYsZA871cI76XNgnCY9Qr5GZMiVIC1J5zh6YXCnMv0oPcRJ3PKnWj/tctpat6SbYBcr3CHwLHK5sM363s0ous9M4uRsl5I+oaxJXjOGQJZd/ZPCJpru4b7PQvrBaTRx/LAUmERGqCFq2pSvNIpKeObbGh/6uZwlIrsQS1Bv8vgQJWv/iIkFPsbnaa+T0INqEMUEoCNI8RlftdOSUzihzgGz0lrQK+GIBO4RE3t6pM5W67Src+bvJwda9pTWmbBto1BcCOOTiCnARZeYdtvCU8xhCbkbAj7miR5zPxJr78eWgpygJlmY+CJIGxqB8wtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kojiadfzCBE50gcnzYUeEKZ1Jrwn84/yI7brX9xv3M=;
 b=Xs8RwXofRyeqVnL9i4ELEQ0kKqSno3vTgF5cvCpiWaS1xoEnyfqloRDRnRFUL3PTVEvjC7bfcA59ypqfo53wCTcdgcokN8FK300uTsgXAfvku2EelSqBrOuT28l4o7bIUV25EvuoDxwFcns/4p8Fo5grv3hZZCm0eiot97o7+V0yWo0kNcsWB0B6zwvdHf8BI6y19VDwncJt4pEvI+BHysiklX9ivBAoUQRQeSHBJq6/KeJulPCaYMk0GfzXNGOGZ+GS5l6dv1VSsAK/OdPTv0sbATV7Ata//0mGigzxCo+O8YfBkKoMiu6CNNUSQ1ElK7LVAgvzl3HpAj5aCHUTCQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA1PR02MB9061.namprd02.prod.outlook.com (2603:10b6:208:41b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 15:06:21 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 15:06:21 +0000
Content-Type: multipart/alternative;
 boundary="------------Jm4P3xFT5UZdSxIEsBxZmPnO"
Message-ID: <0238e330-cb9f-4d72-9ca8-ca7a1b51dddf@nutanix.com>
Date: Wed, 6 Mar 2024 20:36:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] Add migrate_set_ports into migrate_qmp to change
 migration port number
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-5-het.gala@nutanix.com> <87sf13s9yz.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87sf13s9yz.fsf@suse.de>
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA1PR02MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 323f3312-e5a6-4856-7403-08dc3deefb7a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 722VbKqlhiNxIlb+QXEV8mRimeTbTZg25KbrwuB+MalJN6zpPYElku+QqDZi9MwsqX7oY1A7mr5ss74c1d0KlYIwRiN/s2TYX63h8PbN4mLdHIZdOzkQIqKfYjQaK1XYAkv8QUwwovWqeYwqXKgBaMPVrWLiVZPyykGaX4KB7+Sd+/gyPyH3JG/suKfyN+yD602GbXSb2x5VPzVk8quZx0J5B+7mho19A8+esD/9+RDbAV7OQ86kdPqvJ4LMxgJXEoez1cjs8nPMobPbjyVtvcatKnJOvjpDSDwdTKv8HQwRq1aqj6Q41jZBAwDJv2ATXiuEHG5vbPf2OFOMjBXAo8R6ZbbxVZckAjWfvRw36UUmXMA3K7kvc2KuBKkq3GDNTOswOqQsVKE13b8L60Xy2IJk2xWOeyRnILmVZUt0hhMGFHSeDOyH1ZQ1V4BWc5EyRfQyp0ywLZbUfw2Okp2+d+86Mibmj5t+CJbDqvAAPl07X/ZqD7/8wS0+ub2GgLWnFfSj6FpMr6+j89kwDDklss6ufafKUFaW3hI36pvAOh8bexGUvbYrlwXq3nHNYlP0BGozPMXnaPHzWIQyqLffJbwadoSSE7SHiVvYpE7KJ2GxP0cSob7boI5R7Pmm/Ygaz03AZN+toe2UYN1xBbGI9wFyQ+VStMgTnKm06HU9S2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHJhZjBXZzRiUFpFZXhEZ0w2TWo4TURXRzhsSjhvd2R6dXN3OEJHeHVGTmp3?=
 =?utf-8?B?RTJZODAzVGtUTVhsZEFFYVJyNkJidDNMakY1b2JRWjFXdmh0alRLWjhhOXE2?=
 =?utf-8?B?N0FjNnF5OGZNbnVRYndSSnd6eENLSVh3ck15Qnl4cmM0UWxKdXl3bHhCNjg4?=
 =?utf-8?B?QVg5SW1xalExK2wwTXUrYy9xNk9MdDk1MVdSMW1HdE1ValhKMUdsVnY0Q0R2?=
 =?utf-8?B?K2tSbStJQkdUL2pPamJWb0NyTWNOd1dmM01XRnUzSm13SG1pMUtJWmtoQmJr?=
 =?utf-8?B?RnZiNGptc3plR1ZSbjJ5bUJia2dNUjgvbG00dUZjUXF6QTZlSXhnRU9sNktz?=
 =?utf-8?B?TWlNRUg1ZnJuaE5BT01xTWVDSlpQNVM2TlQ0RG1iVUtXbysxYWRlWnRxemN0?=
 =?utf-8?B?alZ1Z0syR3Y1ejhGamJHR1cwQitBYWFDMGo2UkFjTWxwUGp2anVJdmJib0w2?=
 =?utf-8?B?cElKazk2VlNMR0RvWDR4ek1pc251ZjExdlRuM3VSaU04WWMwbXh0bmtaVmwx?=
 =?utf-8?B?QU1MSlh3Tjg1M3ZxV0V1cC9VVDZkRURtNVJZdG9GanA5aUxERGR1M1JPbGVN?=
 =?utf-8?B?VVhjOTFtWWYvNUFQNHNBNEpET2U1a25PTUJLUXZac1dDbGhiNnpZa01aNHlh?=
 =?utf-8?B?SmN4OERvVTFKMUNPTHczYTV6cGZFVFFQZkx1WnBSUjdzVUFCd1p6VEt5TUwy?=
 =?utf-8?B?Zm5seFNUVXhFYzVXZ01taExpOFoyUGpUanZ2bFFPYUxLMmZYQ2VaZU1yUnpi?=
 =?utf-8?B?NXNDK1pWa1h3Y2xEbHUxU0FrdVp0SW4rY0dCSjhrQ3dkK3ZDa1lhWTBrUkZp?=
 =?utf-8?B?cTFZUXBJbXA2SDdNVWUzMWV6U2dzS1dlMU5OQlZrN1RqcnlGcFZKUWxVNFla?=
 =?utf-8?B?amtHTW93MHpxRW11M282MlFxNHRqTklhbzBvNm5YZVp4VkpUaDVNRmwyZXY4?=
 =?utf-8?B?OWNCU1J0VG9kWmJWeG9reEZQZm5rQ2RhcDdqNEgrS2JaaVVFTG00anFqMkMz?=
 =?utf-8?B?a3dCeURNUVJpcTVhemM3QzcvM2JkNklEM29iYUxEMTROYnVTcmx5WE92WWg2?=
 =?utf-8?B?aE1MMVcyOE1kbENVZU4vYjA2TVZkemtSallZQVhzMW41eXlhaDJOQnpERjJU?=
 =?utf-8?B?TzBBSVV0bGJmei9LdlBsRU96OE41LzhqaG5zSXpZSE00RGw0eXhLTkZLek1s?=
 =?utf-8?B?OHRnaFdWWTZQWmpYRi9Na3VyOXlZQVRhMWtLYVdtdkFUM3daT05VekJVaFZr?=
 =?utf-8?B?b3Y5UmJmcGswUkp3OW1RSlV2cGlqc1Zjd0pVdC9PUjMzc0JLU1ZGdndhZ3U0?=
 =?utf-8?B?NXJMRnNkVVdCd1pMWWtkckpaNlNMbThEMytzSTdtcFd4MUdUSktwZWwrYzVu?=
 =?utf-8?B?bG5YOHI2NmNuV2wrSDNQZHFDbnc1YzlDN0NXNkF3QzN5RWZQbXc5R3ZMakF6?=
 =?utf-8?B?aGNXZ05xRXlOVHEvdFowcnZkbkd4Smh4dThwb3ZscXY2L1RRQnpmdHdoMWNR?=
 =?utf-8?B?ZGx1aStNVFVpREMyYS9OVmMvTktDd00wQWhLUEVmZm54NW1WTVlJOCtQdGY1?=
 =?utf-8?B?Zlh0YUttdC8wMktLdWZ2SVpMZHBzaUxyTmVvWkZGamNnOHhHekFZaUxLSyt2?=
 =?utf-8?B?TFdwOWxIb0hGcFE4U3pkRHRZdmEzVUtGd1JvQmNua1dsS096aS84R2t5ZmJD?=
 =?utf-8?B?TDZvVmhFV0hhQUJiZVNzUTVsajdKaFpHbUdVM1BQQ0hZU1lPY295ZWNWYzVj?=
 =?utf-8?B?VmJiTWYxTWdoUDkvQnMwdnkvUVRvL0JvVEoxZWErK1RWaldTUDRqckVUOVdR?=
 =?utf-8?B?R2JWTnpjU1ZpWFFJNEEwRlJNV3ZKRFNramYzZVB0WGpobG5BcjdRTFdkVjVL?=
 =?utf-8?B?dnh2dVM0RGdKZHkvZnh3VnBsbWk2RzFTcXhmL0lOT3JUNGR5T1JqRkJJME83?=
 =?utf-8?B?b2MzMFFXcnBYeFljSFcrNC9DVUs3eTVmMEEyb3JmdUNLMWVhd3UyUElWbDQ4?=
 =?utf-8?B?YXZQc21zdktaOGdpeDFxRkxiRTlJRTJrV2d4Z3VsY2xuSm91KzNEQmJnTmNC?=
 =?utf-8?B?L3I3SEF6QWZjREdzZi9mSktYQmJYSXFoR091SU5FV1dudlBCZmp2aGtJQzd4?=
 =?utf-8?Q?sR0tmR9jmLxyQW8v42cvSELFx?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323f3312-e5a6-4856-7403-08dc3deefb7a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 15:06:21.1634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8VoNCSc3MmpEvITmvChzMfPEBByOx+KIeZhWOw7GBe9VP0BPpyijavTHSgfXuupHKFnFk9oPtfCtW5B2O53ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9061
X-Proofpoint-ORIG-GUID: 8Ven-FoNeJhpzRB_WNkevVcEDECljXfT
X-Proofpoint-GUID: 8Ven-FoNeJhpzRB_WNkevVcEDECljXfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_09,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

--------------Jm4P3xFT5UZdSxIEsBxZmPnO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/03/24 8:06 pm, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Add a migrate_set_ports() function that from each QDict, fills in
>> the port in case it was 0 in the test.
>> Handle a list of channels so we can add a negative test that
>> passes more than one channel.
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>> ---
>>   tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index 478c1f259b..df4978bf17 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -17,6 +17,8 @@
>>   #include "qapi/qapi-visit-sockets.h"
>>   #include "qapi/qobject-input-visitor.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qmp/qlist.h"
>> +
> Extra line here. This is unwanted because it sometimes trips git into
> thinking there's a conflict here when another patch changes the
> surrounding lines.
Ack, that makes sense
>>   
>>   #include "migration-helpers.h"
>>   
>> @@ -73,6 +75,29 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
>>       return result;
>>   }
>>   
>> +static void migrate_set_ports(QTestState *to, QList *channelList)
>> +{
>> +    g_autofree char *addr = NULL;
>> +    g_autofree char *addr_port = NULL;
>> +    QListEntry *entry;
>> +
>> +    addr = migrate_get_socket_address(to, "socket-address");
>> +    addr_port = g_strsplit(addr, ":", 3)[2];
> Will this always do the right thing when the src/dst use different types
> of channels? If there is some kind of mismatch (say one side uses vsock
> and the other inet), it's better that this function doesn't touch the
> channels dict instead of putting garbage in the port field.

Yes you are right. This will fail if there is a mismatch in type of 
channels.

Better idea would be to check if 'port' key is present in both, i.e. in 
'addr'
as well as 'addrdict' and only then change the port ?

> Also what happens if the dst is using unix: or fd:?
yes in that case - how should the migration behaviour be ? src and dst 
should be of the same type right
>> +
>> +    QLIST_FOREACH_ENTRY(channelList, entry) {
>> +        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
>> +        QObject *addr_obj = qdict_get(channel, "addr");
>> +
>> +        if (qobject_type(addr_obj) == QTYPE_QDICT) {
>> +            QDict *addrdict = qobject_to(QDict, addr_obj);
> You might not need these two lines if at the start you use:
>
> QDict *addr = qdict_get_dict(channel, "addr");

If you are commenting regarding this two lines:

+        if (qobject_type(addr_obj) == QTYPE_QDICT) {
+            QDict *addrdict = qobject_to(QDict, addr_obj);

then, I am not sure, because addrdict and addr is different right? Also addrdict can also
be a QList, like in the case of exec migration, it can be a list instead of dict
ex:
# -> { "execute": "migrate",
#      "arguments": {
#          "channels": [ { "channel-type": "main",
#                          "addr": { "transport": "exec",
#                                    "args": [ "/bin/nc", "-p", "6000",
#                                              "/some/sock" ] } } ] } }

>
>> +            if (qdict_haskey(addrdict, "port") &&
>> +            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
>> +                qdict_put_str(addrdict, "port", addr_port);
>> +            }
>> +        }
>> +    }
>> +}
>> +
>>   bool migrate_watch_for_events(QTestState *who, const char *name,
>>                                 QDict *event, void *opaque)
>>   {
>> @@ -143,6 +168,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>       if (!uri) {
>>           connect_uri = migrate_get_socket_address(to, "socket-address");
>>       }
>> +    migrate_set_ports(to, NULL);
> migrate_set_ports is not prepared to take NULL. This breaks the tests in
> this commit. All individual commits should work, otherwise it will break
> bisecting.
Okay, so in that case, is it better to merge this with the next patch ? 
because if I just
define the migrate_set_ports function and not use it anywhere, it gives 
a warning/error
(depending upon what compiler is used)
>>       qdict_put_str(args, "uri", uri ? uri : connect_uri);
>>   
>>       qtest_qmp_assert_success(who,

Regards,

Het Gala

--------------Jm4P3xFT5UZdSxIEsBxZmPnO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 06/03/24 8:06 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87sf13s9yz.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Add a migrate_set_ports() function that from each QDict, fills in
the port in case it was 0 in the test.
Handle a list of channels so we can add a negative test that
passes more than one channel.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
---
 tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 478c1f259b..df4978bf17 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -17,6 +17,8 @@
 #include &quot;qapi/qapi-visit-sockets.h&quot;
 #include &quot;qapi/qobject-input-visitor.h&quot;
 #include &quot;qapi/error.h&quot;
+#include &quot;qapi/qmp/qlist.h&quot;
+
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Extra line here. This is unwanted because it sometimes trips git into
thinking there's a conflict here when another patch changes the
surrounding lines.</pre>
    </blockquote>
    <font face="monospace">Ack, that makes sense</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87sf13s9yz.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
 #include &quot;migration-helpers.h&quot;
 
@@ -73,6 +75,29 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
     return result;
 }
 
+static void migrate_set_ports(QTestState *to, QList *channelList)
+{
+    g_autofree char *addr = NULL;
+    g_autofree char *addr_port = NULL;
+    QListEntry *entry;
+
+    addr = migrate_get_socket_address(to, &quot;socket-address&quot;);
+    addr_port = g_strsplit(addr, &quot;:&quot;, 3)[2];
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Will this always do the right thing when the src/dst use different types
of channels? If there is some kind of mismatch (say one side uses vsock
and the other inet), it's better that this function doesn't touch the
channels dict instead of putting garbage in the port field.</pre>
    </blockquote>
    <p><font face="monospace">Yes you are right. This will fail if there
        is a mismatch in type of channels.</font></p>
    <p><font face="monospace">Better idea would be to check if 'port'
        key is present in both, i.e. in 'addr'<br>
        as well as 'addrdict' and only then change the port ?<br>
      </font></p>
    <blockquote type="cite" cite="mid:87sf13s9yz.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">
Also what happens if the dst is using unix: or fd:?</pre>
    </blockquote>
    <font face="monospace">yes in that case - how should the migration
      behaviour be ? src and dst should be of the same type right</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87sf13s9yz.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
+    QLIST_FOREACH_ENTRY(channelList, entry) {
+        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
+        QObject *addr_obj = qdict_get(channel, &quot;addr&quot;);
+
+        if (qobject_type(addr_obj) == QTYPE_QDICT) {
+            QDict *addrdict = qobject_to(QDict, addr_obj);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
You might not need these two lines if at the start you use:

QDict *addr = qdict_get_dict(channel, &quot;addr&quot;);</pre>
    </blockquote>
    <p><font face="monospace">If you are commenting regarding this two
        lines:</font></p>
    <pre class="moz-quote-pre" wrap="">+        if (qobject_type(addr_obj) == QTYPE_QDICT) {
+            QDict *addrdict = qobject_to(QDict, addr_obj);

then, I am not sure, because addrdict and addr is different right? Also addrdict can also
be a QList, like in the case of exec migration, it can be a list instead of dict
ex: 
# -&gt; { &quot;execute&quot;: &quot;migrate&quot;,
#      &quot;arguments&quot;: {
#          &quot;channels&quot;: [ { &quot;channel-type&quot;: &quot;main&quot;,
#                          &quot;addr&quot;: { &quot;transport&quot;: &quot;exec&quot;,
#                                    &quot;args&quot;: [ &quot;/bin/nc&quot;, &quot;-p&quot;, &quot;6000&quot;,
#                                              &quot;/some/sock&quot; ] } } ] } }
</pre>
    <p></p>
    <blockquote type="cite" cite="mid:87sf13s9yz.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+            if (qdict_haskey(addrdict, &quot;port&quot;) &amp;&amp;
+            (strcmp(qdict_get_str(addrdict, &quot;port&quot;), &quot;0&quot;) == 0)) {
+                qdict_put_str(addrdict, &quot;port&quot;, addr_port);
+            }
+        }
+    }
+}
+
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
@@ -143,6 +168,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     if (!uri) {
         connect_uri = migrate_get_socket_address(to, &quot;socket-address&quot;);
     }
+    migrate_set_ports(to, NULL);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
migrate_set_ports is not prepared to take NULL. This breaks the tests in
this commit. All individual commits should work, otherwise it will break
bisecting.</pre>
    </blockquote>
    <font face="monospace">Okay, so in that case, is it better to merge
      this with the next patch ? because if I just<br>
      define the migrate_set_ports function and not use it anywhere, it
      gives a warning/error<br>
      (depending upon what compiler is used)</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87sf13s9yz.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">     qdict_put_str(args, &quot;uri&quot;, uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
</pre>
      </blockquote>
    </blockquote>
    <p><font face="monospace">Regards,</font></p>
    <p><font face="monospace">Het Gala</font><br>
    </p>
  </body>
</html>

--------------Jm4P3xFT5UZdSxIEsBxZmPnO--

