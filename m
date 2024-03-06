Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6903C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 19:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhx43-0000Rz-5I; Wed, 06 Mar 2024 14:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhx41-0000Rj-Da
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 14:36:29 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhx3w-000586-NT
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 14:36:29 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 426JRdtl022082; Wed, 6 Mar 2024 11:36:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=Xe3ED9jrQYXtkqcrVdhO1LVBRK4jOiTWHeAjP9CNr
 2E=; b=F0pcyA9i1aNEsMcl/EOka80vKGbYYBpoTPmQzE09YsoUfE4LwJbVUYc9f
 PqHW0ROiQOqPYqoq93tGakABKBMv+HsRx0p/k7zcKgxEByZ2mPtYsm2/lGXoT2aM
 aEsBBB/BQt9PLU4GOO4sZN5elz0q1l7qEqO2odT1M/PTD1aIAlRycuOgC0jma5cM
 4Y630HEWEANoUeETaVWEioqKpNsJcSy7ht0H3ijsch6S3Z+VCIDTmgA4A/9UKzi5
 xjT/eQmMu3781iXb21brn8nsfN2ekxeOK5LM/9yP9diE3jkptRXDVjMBdXIxNnHf
 InDiG04yZJgEiH6IfaaOlL/DgC4eQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm4h29kdt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 11:36:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG9y3MOJspG55ZZoxopTM6scTXUIFHsRnnpZKM/g6VefoLwqwHcra0UUfyx/GvVusBuu142vrKzezFSNM2hx7e+VqJktmwHGIh7iMaZyRWvaFjLZnbxarg+S21FAxIC6Aort0b1ccIgT8fD4BGzD5IoLK7AwgN9o36778DXH1O5/UKQ3qQ5RTj2roybXz5Ts55YrG7TeqITJrM9JbmIXLuQGB8y44rb3O6MC+BCQFzFbNydxRoZaU6vLEhzmmrpFLUWza8WCIJMrJ5NQeCbLYJWnTOGViftdi61ozKehUEiuScxBRuUbnWHVMzeTShEFhWUiBGkr5A0v39g+j9N4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe3ED9jrQYXtkqcrVdhO1LVBRK4jOiTWHeAjP9CNr2E=;
 b=hrwE4xYrmNmtX/v8ssN1bL7mtZhY/ekY3lvznxYmn2vmIm5v/uNfKnXRASfQCm/+ynJEo8UQaqhxapU1SfwnS7uLet17tfow2F6CUVTviQwz/Uf5IAi0oaeN2ChDffSYIqCp53RhjAUgxYL0K1Aq1QqdH5VVe4n4IiTUenbNEaujEA3y8PTkePueyAvJqLzHGOhZcj48utmOW8fvMExq+ps9MVDyT7w6ZdJ7jK3hUaTyrPCxQjTVBAyNzqV82H79O1UqgNjEFO5qgnjGKJCCkFu0quHy5yjIaibIXkORcUWXMe3LNJI2opjEufs00e7LOmKaAz1PsnR2VYOPC696Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xe3ED9jrQYXtkqcrVdhO1LVBRK4jOiTWHeAjP9CNr2E=;
 b=Av+ZROhnnYwfEP45wwlRSdYUzQ3pLBPrs48c4d/TBhxUW+AbK0RR3SLkvafGHqNn132BRVQHvtwEnZVMxAlX56HTILPsgkuX7+khnuZVRnNvdHQ6zYKuPRIMarhUVc8jBUDn+iaq8obNbfOB0AM1bYqcM8js1n9fXvb2Ww6jEk0Ki0R6Rio+6KMWvGlRFs+EVu3PT4VugjJO4DGnXG9nAhFSavNqsySyQ9qCQHsYJaRwXaUTGlptRhM06HQhb4g6b9nJKl8XLb2iz6ZywVi347bwRSiVcL6thEw1X4eP45ghlr69maUxOhGZP1QFeZ3Y9f1dVPesmWwA+97p3Q+aWw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MW4PR02MB7362.namprd02.prod.outlook.com (2603:10b6:303:7b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 19:36:18 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 19:36:18 +0000
Message-ID: <fe9c6245-c847-4044-b410-7e9e9b6bfc2a@nutanix.com>
Date: Thu, 7 Mar 2024 01:06:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] Add migrate_set_ports into migrate_qmp to change
 migration port number
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-5-het.gala@nutanix.com> <87sf13s9yz.fsf@suse.de>
 <0238e330-cb9f-4d72-9ca8-ca7a1b51dddf@nutanix.com> <878r2vs61j.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <878r2vs61j.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::6) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MW4PR02MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 1761553b-f64e-4725-faf7-08dc3e14b190
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tK5Ve1rrVf1fMXe8KEpY2Eo9w/dg/8mzTYho6vp+iSI23EIffCUsKe/m70Bj2AB+iYDEjy9Pw2ITLBbBWPIreyhLHAL8qt/HovkcMmp9tV79gt1LpseF63+uDebZlRQSa+Zcy+l91K0gw+JX8Nuxvcq9tjdbPcn9URYUYLBLJq0P8R9hhcADk0Prh/lB5YQdKAcFGGcDceRvIENHbadfsbWxg6PiL0baRSS972M2y8pgS41mKT9Wwhg4sagS4L3JRka1T4ovxBzOquKHoQM8ovFiYKtXkWKsSoCKk6vvY/YrOl5QO8XwfnhAphyscWtdYlKRxsL4hVbb0lDrdKPJY3KxzjZF5inVvjMFC6LJSFSiTHE0gM6a68n+fNlsxjxUZYRMj09GVLlm8sa8hUBwyxVf7JFmWe5G6CUkh++QV6yROEETMBW1jbOP0VVEQKabThtNJxnJrkwTH8cZuxKO5Umr1xZ91YimY/7XogthY47Yio/flKBNzmnruJytdulBcxhHujz+ZGCA6Nrd9Pb5YKRoKU9yySsV59EYu/3Pr/PVhKm/CXqIb52VEKMBAfAlsqm7k2ADo+RYupe/0MI/JB3eufjNCfzY6Ww8/EJBbUKLRp4W1CVdP9icZ8bhyTVhtbA4ZLHxON7E1gFb+YcWfkK7AjQVDGEOaCqpnpOZ6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDk0UXlDSlBITUZmMHc3c1JlNmIwNXZnc3dZL0w3dWl1ZG93bjVYYkJta1Zu?=
 =?utf-8?B?ZXVzT2tMZDBrTXJvaXNkWnZMTEZYMTAxeWd6V2J6ZmpMMzBqQmFLZzE5bklp?=
 =?utf-8?B?UGlmZ0J5RXl1NnAzKzlnVGdtdlV0eUJCa0o4UFhEbjBmcDVpNmhsZDJwMGdK?=
 =?utf-8?B?SjJaUE05VFhqTmNHY3Q0QzcwenozVzlWeFBXek50TTY4M0NWVEZGTU40Wm4x?=
 =?utf-8?B?QllOUnVXRXRqNVh1amV1K0F3MGVTQTI5QmxBWS9kTi9zRU5FYnM0K3QwUmR3?=
 =?utf-8?B?RTE4ZkFaRC9tcFVuamlEdXkvcWJOcjNxRitGTnFUMVN1VE8vbWhWM25kZDJm?=
 =?utf-8?B?bFZ2eTZjVDRlNkZpRmt4Y2pySlhvQWlaQzNDTm83dVBRSXBqdkZqdWkzYjVH?=
 =?utf-8?B?eVZrdXIyeXpQR1d2T01RbEpLaG9TUU1BMXNvem1kSkJOSGxSaTFpRXJpcEFu?=
 =?utf-8?B?NGYvNUNnQmJXS09aUjJKeXVobXJJTVBPVE12SE5wVGgyZkFmZUR1WWZtN2kw?=
 =?utf-8?B?T1pWSzFRcC80VmZiU0NTbjFiWVBPYkt6Wnd0dUk3dElFZnhIWUp3bDc2clBh?=
 =?utf-8?B?Q1krR09sSnkrWW1GZklIN3BCd2liZ3QyV1lkamJDeG1udzdOSHZHOWhIb0hn?=
 =?utf-8?B?THZ4bEhPNXhhUTBRSFlkYzFXTkpabGVScktiaGM1NHhQOTJ1RFNnamFOTGhl?=
 =?utf-8?B?K0lQYVRKT2lTdFh3S1dxaS96NG4va01hRHBLWkVzdEVzVU5pQVpvZk5lTm05?=
 =?utf-8?B?U0trNG5DSUhaNXNENHFITTNZbHFVYTFCVnJIZGpGbDR3Nlc1R1ltTmQwVjB2?=
 =?utf-8?B?QjBpdHUzd09JRGpCUk5VL0J5aEp6ZXM3UFFLaGVRU0ltc3pEc0JZTDAzUC9M?=
 =?utf-8?B?M2Zwd3I2VUs3SHJrb3BpN1l0MWRuR3Ztcy9YelN0OVBGRVMwRjQvL3J0Y1dD?=
 =?utf-8?B?S01EdG52akVsdG81NDR5T3FrTS9JSjhVcFVjME14VDRQYzZVUjNyZThIZnVU?=
 =?utf-8?B?bkRtQnoxOXBMZm1GUEdrWEYzTXlXQlN0b0hhdkhtYk1mcjFhYWNObFR6S2dG?=
 =?utf-8?B?UUYrZnRpaTNTRCtQYzV6Tm83RVhTNDdvV0ZLYThpZnBsYmR3aWovcDFLUUlk?=
 =?utf-8?B?U3E3UGdibldxT2JvQXpyelJGNzE0djBaR0xUa09TaFhZenlSVndMRFdneTAx?=
 =?utf-8?B?ZmdlRVdmVEdjaSs4aEg2TjBqMnlDR0xwNXhhTXlMNnBTaXpoZXRQWDlaaW12?=
 =?utf-8?B?ZlV3dUhHU1BJWGZsbUtRcERsTmdud0V1K1pxdmdoVTM2NEJ1RXhzV0pqUUc1?=
 =?utf-8?B?OGcwVlQ1b2dPd3FXNWRlRVlJWm9vMUlvdG5OWlh0YVNSUURqc0ZZdmhNUWhJ?=
 =?utf-8?B?VCsrQksyUGFJdHhoL0FlSXVGVnFLQmNKY240VTZrTlNXdktNcWxHQWM4RWlI?=
 =?utf-8?B?MXpRQVRoaGpEWE9CTlF0QUdxaHpQdkwwNjFwRGJxRTJucEgrbzJpUFYwSmdP?=
 =?utf-8?B?UzJrUU1ZdHhtNUxWVWtPbHhuMFBrUVdtUVQzd1NuSUV1WFZkejAxNFhZME83?=
 =?utf-8?B?MVhWWU9ndWUrdURUQk4wVTNwcWVhNXJieEpQUzVLMXJKWjRCMTMwdWdqR3ZD?=
 =?utf-8?B?TGZaY2V5eUIrTEFSUGhqZG0rRytGN1ViZENGdkg4S0RBc3BUdWhKb0dQa0g0?=
 =?utf-8?B?dmppR0I2ckdza2Ryd1YveUNqTlF2eHdKRlN5T0t3emJGalIrT1pRTGRKSCtk?=
 =?utf-8?B?ZHFrMzRsTnB4d0dpQ2lodjZ0UC9yNnV2dFJudmRWa202Q2lLakJzajBHRHpv?=
 =?utf-8?B?VHgySDZ3UFFCZGFpTnlpdm9sVW43Q1VnQ2psdXRremR4SmNOSjBxOFVKdlNC?=
 =?utf-8?B?S1VrVCtrMk5kRDFvVjdsM0VCSEROWjg4MkJrQlVBSjBTZ1R5OERBY2huRExW?=
 =?utf-8?B?RzlGQ0szL1RUVlhrQzZORUlKL1FwQlNDUnA5aXp5WC9rcm1OTVhaaE9Nd3RK?=
 =?utf-8?B?TWFpeW5DQTBiVS82aUpsSktOZHN6NHA1Z3E4SDJuQ0tNMTREUjEvWlBPK3RT?=
 =?utf-8?B?LzRJWWNRTmhtZUl0bS84TXVwMlpPcjhBNnVOYUtIbklKMlc4aTJkZWg2dm82?=
 =?utf-8?Q?T0ozQxSeAhKtlGANAohByaBPY?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1761553b-f64e-4725-faf7-08dc3e14b190
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 19:36:18.2847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1loK0OXH8LDHBxX6VXFEJ+9f8pj1znEseUAgjG05whtxI2xxZObQyt3dZV1+OQJ/G+vzIVwD8BaszDZeWxOYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7362
X-Proofpoint-ORIG-GUID: yHjTP1xtFzSAGPEtttwRKtV0uwQ4Y1Jb
X-Proofpoint-GUID: yHjTP1xtFzSAGPEtttwRKtV0uwQ4Y1Jb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 06/03/24 9:31 pm, Fabiano Rosas wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> On 06/03/24 8:06 pm, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>  writes:
>>>
>>>> Add a migrate_set_ports() function that from each QDict, fills in
>>>> the port in case it was 0 in the test.
>>>> Handle a list of channels so we can add a negative test that
>>>> passes more than one channel.
>>>>
>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>>> ---
>>>>    tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>>>> index 478c1f259b..df4978bf17 100644
>>>> --- a/tests/qtest/migration-helpers.c
>>>> +++ b/tests/qtest/migration-helpers.c
>>>> @@ -17,6 +17,8 @@
>>>>    #include "qapi/qapi-visit-sockets.h"
>>>>    #include "qapi/qobject-input-visitor.h"
>>>>    #include "qapi/error.h"
>>>> +#include "qapi/qmp/qlist.h"
>>>> +
>>> Extra line here. This is unwanted because it sometimes trips git into
>>> thinking there's a conflict here when another patch changes the
>>> surrounding lines.
>> Ack, that makes sense
>>>>    
>>>>    #include "migration-helpers.h"
>>>>    
>>>> @@ -73,6 +75,29 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
>>>>        return result;
>>>>    }
>>>>    
>>>> +static void migrate_set_ports(QTestState *to, QList *channelList)
>>>> +{
>>>> +    g_autofree char *addr = NULL;
>>>> +    g_autofree char *addr_port = NULL;
>>>> +    QListEntry *entry;
>>>> +
>>>> +    addr = migrate_get_socket_address(to, "socket-address");
>>>> +    addr_port = g_strsplit(addr, ":", 3)[2];
>>> Will this always do the right thing when the src/dst use different types
>>> of channels? If there is some kind of mismatch (say one side uses vsock
>>> and the other inet), it's better that this function doesn't touch the
>>> channels dict instead of putting garbage in the port field.
>> Yes you are right. This will fail if there is a mismatch in type of
>> channels.
>>
>> Better idea would be to check if 'port' key is present in both, i.e. in
>> 'addr'
>> as well as 'addrdict' and only then change the port ?
>>
> Yep, either parse the type from string or add a version of
> migrate_get_socket_address that returns a dict. Then check if type
> matches and port exists.
>
>>> Also what happens if the dst is using unix: or fd:?
>> yes in that case - how should the migration behaviour be ? src and dst
>> should be of the same type right
> Remember this is test code. If the test was written incorrectly either
> by developer mistake or on purpose to test some condition, then it's not
> this function's reponsibility to fix that.
>
> Replace the port only if the transport type allows for a port, there is
> a port in both addr and addrdict and port is 0. Anything else, leave the
> channelList untouched and let QEMU deal with the bad input.
>
>>>> +
>>>> +    QLIST_FOREACH_ENTRY(channelList, entry) {
>>>> +        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
>>>> +        QObject *addr_obj = qdict_get(channel, "addr");
>>>> +
>>>> +        if (qobject_type(addr_obj) == QTYPE_QDICT) {
>>>> +            QDict *addrdict = qobject_to(QDict, addr_obj);
>>> You might not need these two lines if at the start you use:
>>>
>>> QDict *addr = qdict_get_dict(channel, "addr");
>> If you are commenting regarding this two lines:
>>
>> +        if (qobject_type(addr_obj) == QTYPE_QDICT) {
>> +            QDict *addrdict = qobject_to(QDict, addr_obj);
>>
>> then, I am not sure, because addrdict and addr is different right? Also addrdict can also
>> be a QList, like in the case of exec migration, it can be a list instead of dict
>> ex:
>> # -> { "execute": "migrate",
>> #      "arguments": {
>> #          "channels": [ { "channel-type": "main",
>> #                          "addr": { "transport": "exec",
>> #                                    "args": [ "/bin/nc", "-p", "6000",
>> #                                              "/some/sock" ] } } ] } }
> "addr" is always a dict, no? Even in the example you just gave.

Sorry, my apologies. I had args <-> addrdict in back of my mind.
You are correct. Will make the changes in next patchset.

>>>> +            if (qdict_haskey(addrdict, "port") &&
>>>> +            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
>>>> +                qdict_put_str(addrdict, "port", addr_port);
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>>    bool migrate_watch_for_events(QTestState *who, const char *name,
>>>>                                  QDict *event, void *opaque)
>>>>    {
>>>> @@ -143,6 +168,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>>>        if (!uri) {
>>>>            connect_uri = migrate_get_socket_address(to, "socket-address");
>>>>        }
>>>> +    migrate_set_ports(to, NULL);
>>> migrate_set_ports is not prepared to take NULL. This breaks the tests in
>>> this commit. All individual commits should work, otherwise it will break
>>> bisecting.
>> Okay, so in that case, is it better to merge this with the next patch ?
>> because if I just
>> define the migrate_set_ports function and not use it anywhere, it gives
>> a warning/error
>> (depending upon what compiler is used)
> You can return early at migrate_set_ports if channelList is NULL.
>
> Also, I just noticed: s/channelList/channel_list/
Ack. Thanks


Regards,

Het Gala


