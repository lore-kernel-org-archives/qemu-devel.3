Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A030C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjm1S-0002K8-1O; Mon, 11 Mar 2024 16:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjm1Q-0002Ji-Fx
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:13:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjm1J-0002e5-TG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:13:20 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BISg8v002774; Mon, 11 Mar 2024 13:13:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=BXV6ESwEtbl1NZm2B00UB68XpgRyIR7vAL7ujJoz1
 Tw=; b=m8+i57w9zwoOZYugrW2ksscIEMwiee4xbqez8adX4VzWsWxIgjg10vD/f
 UaVU1BOkgyNoyTu+J+ROx0oCVgTqMST1IWLrSJUnwSItfCgYd1VUYd7QtX9inouZ
 UCS65FF+Vp1A+GmBlraygXuzaawcihr3ZFePTaqWlDKJyBsn8gsfFGfYt/byOQjU
 SbgLkPqct5nRsygcMmjX9Ldu8xZGNyLY7Yl5XczxM5Zkb/nqKbvWfZrT50fmQ7K+
 k2KYSAKrr0DHtGFQyiRQCX8XWvyvPqO/cwlJ0jDja/UAjwM+U4T/MU0IZSzy/AS/
 mSXQ7SJ+KvYm3fKEgHUkBkqlEqYgA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrmj9m9kr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 13:13:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqEeLhiUrB7ArQAFy4A84qIXv/4KP0uuluegyHZDtN9u4pFjqkodqtohB/JLgdrK1D6WGBdDtU92/Qp2lYlxE50zGBIanWXRySb9xJYFz9y66pmiZ0R4QZzCzSSBD6WPI4UYgtoXsCLIvlWcBnrMWtYrlADV+lt629vcfNmfBBVGM/Qs0j8dawaeJpPNc4+22lrt+9FkA3F9NdJKq5Zs9EZ1df3CIIoAJa4ODF1YzJ1DizOw6rwc1egJJ8vJKZwHjFhzhl6CJGeYl/Wo9F/2+aRIGKqdLvtFUv7cZXfW64orfMlH4B/QR64ENdmXNDON1Km9X230QZK33BbQN1YY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXV6ESwEtbl1NZm2B00UB68XpgRyIR7vAL7ujJoz1Tw=;
 b=HaIKeM/Ig7doZQGcs477Zrrcz4FUCE4bPzsixHxSXBTumjCdNq/OaMnUS9IH7bRYHloEZs4qSqnhdRYm6eNuTDNJezKoWtMzbuo6e5c2qZZj/VJJ5/4bgRcEh2cGKcDrnQJzODDa0DvdcetKcAlqFS9hkRClipRwLIcnrR38IHmtqCTSuojwjB0PzzVyusu2jm75lOsOgRk9KUsIMsU+nhRXBQq0IjzElLgnrKgcTagDp/ZjOJ110MyKEFMnU8qMyW9vB4JksaSQFZeoA9vcKLo0l3Cys3TBfCfOA8pj4dwAYXch7WH9DQA0nSz/GlHvgIqG075dFbKJXgOtltQ3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXV6ESwEtbl1NZm2B00UB68XpgRyIR7vAL7ujJoz1Tw=;
 b=YBIvEHEWO4IqwMZIfURB/JXdjNt6MJBq3ayDT2ANdVEbsPG/C2GNJigAjijppmBOoNtG3yMeDvlAf30heCrAUeTLqJVwqDnepjxui5gPr0hKeRCvgWNLRU1MukPDO5kgYjesWEXgrhqUF1FFSXozT5ByvFkjNHrmBvjBdM3qhH3Fa47lG6Ko+dMg+JqqLCfuFyhLgUxF8A0FWRt7bs/VTkiHGHioI79OvDJ7cDzZi06tak71kY4uJNT+fouI9z7UicDhmqTmoK8QGm+51hjE99ijQaa2JYNVxNjP0xVt4jyWco1VHVoM0vPQlpVplHvQN2dOcIfsNVaIe3uiWfgVGQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9195.namprd02.prod.outlook.com (2603:10b6:208:438::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 20:13:07 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 20:13:07 +0000
Message-ID: <cfb16b1e-2362-4f55-a963-578ff2e82f58@nutanix.com>
Date: Tue, 12 Mar 2024 01:43:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] Replace connect_uri and move
 migrate_get_socket_address inside migrate_qmp
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <20240308205951.111747-3-het.gala@nutanix.com> <87zfv4my6d.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87zfv4my6d.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::16) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: a986dedc-71e2-4e43-2c4f-08dc4207aa67
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8v8F/gsUZy9RTvRnqydy+cpML6rHhT1+H2tnuXjPJ6b+BQY5o6tJ+C4uFoviWl/By/gASPsbKmMPpZ5SWpuAcG036Qz8ozgzs0LdjiVMjti1V3xr5HEpm5LYBvxQ4NEv79u59/0S5S2oUtnDP8du+G1qf7J/LRq8+hlHKZDC+F+Wrld3KeDjW3n2ojz1FZqb8I591Q1gDcrr63wK1I/p+PG4AOxVgFvozqLhh03LVerdniKSpXEHlaeDhUFvycVVFNJ8bPao8MkuqrkHqSK07JOien8ViFg9pByshTz881To697GHH94UGCJUouQEfHgHv8NQXSzUIgHLZC2OAeCsljNfRK97rH4uBY59B88gM5TVsHu9BzQgccjmkjU5+ljEtnksLFhz+gBwyM/F0a5PbHI6vjGVUqnmkjs8W3YGrRKCVBSr2DU0jqYRrmUtZm4Bt0CquV3soDiZ2Rm7WaTpxPcwcuHvklqYTY0XxHE7lPpgcpmkz3z1mqxDazKte/ZdD6K9p6OUrdu0btaS5moMNYbL1bBR+WZlUeqjbYEdJNl12CnPyY5DLU5o9drKjMdEUtPOdetZDeWZ5VH6uzMq+rX7Dk+VTrh+RmokbHSHaUQlyf7m5BlVgjlCwSBWqD1nX64Yi0/Qw/b4TJY9JJ/Q/E2nTjmg7TZRnIKjmlYJTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dThobE5EV3dhTjMzNUxjUDVCZEdvQkw0dkxDYy8vYjRlTFlMN3doWU0zeEdW?=
 =?utf-8?B?cElrTEhVTGFIQzRkVXdMNGRRL01QRVRzVGpNVWI4b1RhK2h1NkZlYlBzT1Zs?=
 =?utf-8?B?eTZLb0JkbysrejFBNHd3YmZMdk5Gem1FTlNIOUJWc1lDZnpZdXoybGJDZFAw?=
 =?utf-8?B?eDNqbk1aYnZYS3lzSjRIVjlQTjB6bXEwZ0g3Vm9vUFgwOC9zdWdhTW1TSCtx?=
 =?utf-8?B?WFVIVW0wb2hNMktkYmFPWGpYZWlnbHVVOW5mU0t5MEpRRzFPOFo3U0xKSmtw?=
 =?utf-8?B?Q3Azak00MjNPVkkvcVRkV2ZWWUhVdjlmbGNydHRpampNUEFqN3k2N1FYbkR4?=
 =?utf-8?B?YWZiTllVQk4vcnphaHgyMnE5cEpQdUlYcE5nZFZuWG9yMXVSVHhOVW5vbVdo?=
 =?utf-8?B?VFFmdnkzbHpveEtuc0xMSVFWWnBmOXNEeVNFMlUrNmdMZ1NMa2NuY2huTGRI?=
 =?utf-8?B?QXk1T2dnQUtyeHJEM1FUdXhGZTZRU3dpQ1J2RkU0UGkxN2hyK0YvaGMxZnV0?=
 =?utf-8?B?Y1ZFdTF3VkFMOFE2c1VhVEozL3cxbER2MzkvVnZqY1dBc1JZSmE4WmNTOWVY?=
 =?utf-8?B?bHdITE81T2djcDdZcFpqVUw5S3ExTzM2UllUMjdhTjFWcFFYMzdPVmorYXRv?=
 =?utf-8?B?T1ZVclZ6Zkh1RlptalpuSEdZbUVxbWR0YjFrSDExLy9vVmhmcExyZ3JlUUls?=
 =?utf-8?B?NmRBaGNob1pRaTdIcU5rbWxmMUdaUm5mNjA5UjQrMUNhdFpubGU1clNscHdi?=
 =?utf-8?B?ZWluTFFnSWZ6V043N09kTjV1V0lmeFJxcWtkVTVjMG55cEZmZFgxdldFSnNS?=
 =?utf-8?B?UStaSFY5U2xKdVhaYXNBWXpqQVpjdzd0dXovVWV3dk05Ym12OWtiRFJaRTZK?=
 =?utf-8?B?bDFIZklzR0dzeTN5Ris0YmZDSkh3dWVQRjhZY0xDN1pNcGVEWlk0R0tha282?=
 =?utf-8?B?azVJbEVkR2hBNmhEc2FPUWthU1FHRXhWZUs2ZjM4N3NPR2t3UHJzYjNzZWVl?=
 =?utf-8?B?ZitVUENRVk5rRlIwcnBtVERpeXFjYm8zQ3IzSmdXUjJDVDBnSWYxWE5ISFIz?=
 =?utf-8?B?b0c0MGNHeVNQc2JqNFI4d015eEhRcDZkZHdTbHp0M29Bd2d3TTdqY05DTEx6?=
 =?utf-8?B?QzQxWVFBNnFyREZNMGhDWHNlRHV6WEJiYXluWVN0ZkNoR2lRWW9za3pvR0tH?=
 =?utf-8?B?VnlsZnJnYVI2WUNYSWs4UGk0MGVENDVCL0Fta3NYbGhHRFZBLzUreXp5WHdl?=
 =?utf-8?B?RzZTNlNiRXdEQm5WaHVyN1NETVJ1Tm9rSFhDWXhYdVppdXlId2NmTWJLWEVh?=
 =?utf-8?B?U1o5VVI4SDNsbGVZNVRxb0lqRzNyVkd5bVNDNXoveldRMUJJWHBrTkpZdnBI?=
 =?utf-8?B?dTlqRTFEUWd4L1Z2ZjFRajN0ZXozWUhUOUM0Q3JWbGIvYVh6ZVZReGZyMysr?=
 =?utf-8?B?YVF4YzFSUVZXVmlxTG42MnA3bHpnWWI0bng2MXdic0VuZjdLTG41cW1TelpU?=
 =?utf-8?B?VXMyYWVHQkN0RlZCSWVoL0JrUit4YzluUHpnU2ZLNlFyOFVsaEh5UG5FbGVl?=
 =?utf-8?B?eHVnVnFhWUdnUG1PaTZWNGFVNktTdXVXTUlwUVRWWTE0dGl5bFNUaktPdU5R?=
 =?utf-8?B?a2NIbW9adHE3SXdmcWwwUzFOS2VxQlVUUEtjZk90TDdlSC8vSms0cjZHbUtZ?=
 =?utf-8?B?THRkaUNIakZZWFNjd0RKbm91MyswNUFCdlRLZ255Q1VxaFA0dFYvZXBveE1W?=
 =?utf-8?B?b0haclZVUkVRbEdaVktjVFkxRzliaGVXaElmbmMwRVY2dldNMFBtNUxGUnpp?=
 =?utf-8?B?cDJ1YU9PQkMrMGw5N08xQkFqRnArUjg0aUgxSGxkWDZKVU1zUDZEUWdsOXpZ?=
 =?utf-8?B?UytUQnJnM3EreEk0YXpFYS9URUhKK3pvVUFHSmJCUmtsaDlGUGNta2pXbXRT?=
 =?utf-8?B?K1A2WXljRTI2emRPKzdENTh3eGV0NzZ1Y3FRTk9DMWd6UUMzSGY2UVRmMTBm?=
 =?utf-8?B?TlU0T0dnMHA2RHA1L3gzKzE1dGNieFZGbExtdEZFYUFGZC9KQ0k1aUZpNTJD?=
 =?utf-8?B?SWtZYWRDWjZmcEV6aHNuTHJleUREb0pxZldJYTI4ZVU0ZFlicStva01qeEhh?=
 =?utf-8?Q?wGuPtCf31TIeb3wfNPb4DlAPY?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a986dedc-71e2-4e43-2c4f-08dc4207aa67
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 20:13:07.3994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpQZzHNvwjsaAOS4jzH/mU6S+CgkyXRhRjb6Z8aOri/jVMYgOwmk0zQJG7IUmYbhIeOen2c1DHxne4E/2CCugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9195
X-Proofpoint-GUID: ezkf8gaTjnQEEGwaYI6JB3-ZKTOx7fKC
X-Proofpoint-ORIG-GUID: ezkf8gaTjnQEEGwaYI6JB3-ZKTOx7fKC
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 11/03/24 11:46 pm, Fabiano Rosas wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> Move the calls to migrate_get_socket_address() into migrate_qmp().
>> Get rid of connect_uri and replace it with args->connect_uri only
>> because 'to' object will help to generate connect_uri with the
>> correct port number.
>>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/qtest/migration-helpers.c | 55 ++++++++++++++++++++++-
>>   tests/qtest/migration-test.c    | 79 +++++----------------------------
>>   2 files changed, 64 insertions(+), 70 deletions(-)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index b6206a04fb..9af3c7d4d5 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -13,6 +13,10 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/ctype.h"
>>   #include "qapi/qmp/qjson.h"
>> +#include "qemu/sockets.h"
>> +#include "qapi/qapi-visit-sockets.h"
>> +#include "qapi/qobject-input-visitor.h"
>> +#include "qapi/error.h"
> Are any of these now superfluous at migration-test.c?

Yess, actually all of them are now redundant or not required from the 
migration-test.c. Will remove all imports from there


Regards,

Het Gala

>

