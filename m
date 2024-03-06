Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F271CC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 15:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhtFU-0002S7-CP; Wed, 06 Mar 2024 10:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhtFN-0002Kb-T0
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:31:59 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhtFK-0005rE-Ht
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:31:57 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 426DMdFo011980; Wed, 6 Mar 2024 07:31:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=fMS3sNw7oLYYVXIcFmyesMfKHpwepCaMm3sNiyv1e
 ig=; b=bTjn7IDr3j9/VSsyreWzek4eaxSFYEsVMyv9g8j+fyKvmp+p6pFd0X47M
 6UFvVmZraqdap/qulX8IgU7z5HCd2phspl2v3D7MClYjAy6PvO65QKsfnzndDMdA
 mutmwyxVeu4YxdpZiiaMH/CcBs2rLPCPiqMMR+qvAV+3xNsnpS2kqCbfxkh/dIWf
 YCGJ3jQ12TX23tK5wGUYc3zhP2HCnMAEPM4dH4Q9PIHWtwTs2ZfQ+6McUXH9wIvg
 ZcoZBnpdRuPjNGP2j4ELjAph5KN7E1CyWonO9G/DaVh1gCa7kGbR2e8LKLGE9dKR
 wK/+zt2wKrQNpVtcE/gATo1zuLgWQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm1avs8hg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 07:31:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndFlFroOEgejAQqryHRiaeI/VRg27pGTksfGOoBGnqcXsjahQ4LDm6HtyCOHoXstZ2iElnknD2nxMSVhKNsVscmiLiVBZlEcNh8YjUP86xhJn9ysw7TBtUmIso9CQ2VI1QNR1eciu2B04h68DXcc99VmqPw13vd/bi1lwRNONakIYIMup8JzuIs8yROz7s2aG5DfAQcI+pXYkQNYoz0H2G7Q+6/XeOG7ZGFKFwwO98pZuWMzhGSMfS5jFJsU+ZwKeS7xrqEo5v9/4sJSFwL8t0hBoHdto37Swd//aTPXWdLdoQ0qbdcL3HWeinxdmtLzNTVXQ541DLptz64dPNPplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMS3sNw7oLYYVXIcFmyesMfKHpwepCaMm3sNiyv1eig=;
 b=niSMSPqN57a2DWPC4s+L/zwpMuPlhEBfg40brlsMaXZGvt+ed6+NrlNc1Vl18dQAvQQ55IjVO1xtqKxSnqRmSSTwrVyLPy9ioeczO67xl7Txble+zdsXiSs2EE/68WOVWDJI3SG5bGMTjIpM2q24PL1p01tSZy4xfjg08+usY+lWWXFjHeNzFw3eYj4LynrizVdkQ1sukqGxbDHqNUjVns5uA+ZJYlX0bfyd29mC50covhOwsw0TAJJGe88R6XhOApyZIGjM+RkjgKNz0zNmIiRDCXECuuS0w4OwR31lofei0jDlBlt3/1x44rUL8cqFEsPycVq1kYYriwLVegerrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMS3sNw7oLYYVXIcFmyesMfKHpwepCaMm3sNiyv1eig=;
 b=T/OYm+dzvWXvHKRBrHAI/obDszly8VruzSEUj7Pieketpfk2dU8HfG6GkHosranM/guyowEYoKquXGBEHxYiPq6W/kObN2q5Pea7PSRNqH6o5P+DxVyWSAFyGu3XFcHOWbvsDGi/nY2ZJS1yi7o4VOam8YmBSl2IqHuJuo69RWgrjJ2r7rtmnVakjDBQ/uUYWtSPl2AvodIECLiDHIPGdfQwDhOlyFk2DPiHgL4qpZf14VMOpM6NoRJ7Kh7+WI/6aM2pO7gLCXkppqjynnTV435NZ2sfHQoSBv897KueBMWnLzzbgqACoOxv4QVP5klWj/HmdtXng5LGJktLOQl8+g==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ0PR02MB8386.namprd02.prod.outlook.com (2603:10b6:a03:3f1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 15:31:32 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 15:31:31 +0000
Message-ID: <102d005f-5b41-4a44-9ad8-3a542817b72f@nutanix.com>
Date: Wed, 6 Mar 2024 21:01:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] Add channels parameter in migrate_qmp
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-6-het.gala@nutanix.com> <87h6hjs9qa.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87h6hjs9qa.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::18) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ0PR02MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d31f758-06c0-46ce-c3aa-08dc3df27f64
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vgms5EG1m9z1/SJUXb0TWoPJcg0oXJKxpiNeRwIZjfsH2N6pNA/Kkyxxfz3tOPq/thqkXZib3foPLm6h2cM6BdibDxdnAez29nBHmTqg+z+pWDoIPVw5+X0foI/tKoiogr9m7bgUl1CPkcga6duZIeZkjW6HoO7OFLh/heSQo1mHt1azW6fQO6+T2KhLXTP0If+ejhH8llT9oCV/unx7kY8/dCFC1KIsG7bsYWVj+kPGSWIJp3R3xbOSUz+xOS6HoRbKMpKJ1mXZgY6wxPoEmWT/Jxivq99zLrwmevymhFagJ8S3svT0UXKB1Gnlqk6lxGlmX88dkeaIgRFj5RcmUWmSoMjobt5TAOjNrK/+383nZGN0rPdvtJo3SL8JOS3gwHfwa48FpmIDxdoYRtNmxEiqAVW8GMyvGrmikBAb5MAvachkQNb2IiJlmZBKhhE7mSzpBh4jBhrKx59k3l7G8OQa+jQSmQEIbyxhdHT1TaeBc7B3jy3NS07HtjOpPKrb7n5Sw3nkrvR6nassoDJz/EqFxC1pZ3+EUJo3p1d0Qp0t+0u5YpB+pB8VggmSYvxEI6H5zXCgYXvevbIwJCGAvNb8jZFmBpiWEGNhOtZmKATGnAViNo+5C/2o8fQrslTMOuZa44rDn1LMlE+rDvk+n8WJfU0QrFtUMbow1q+Kt88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDlDKzdFSmhaK1l6Q2puQnVDRHB1SVZaV2tSTWFOeTVBVVVXbFNXdHdIRUQ2?=
 =?utf-8?B?TWFwdWNBdjF6bUtsdjFPMnY4NkJMTVp0UW5ZU3IvVHIyWEN0VzZDLzNJY3A4?=
 =?utf-8?B?RDhoN2pVU2pRUE1kcnNCdzJ4ZEtjRmx0eTJOenY4RmdFYVBwa0w2bW4rbVJZ?=
 =?utf-8?B?anZkN214TmEwK1M2TGhWVjdrdnl3ZVRLdHpJMy9QUW1KdWxEQit6Mmd3WHdE?=
 =?utf-8?B?ZkZUb2RUbkx0Sk0wTGtvNXRLS3dsVUludVY5WlpaT0c3cFZwNWQxY1FId0c1?=
 =?utf-8?B?b1ZQYjMrRThOMkRjMFdURHJjanhqQUFyUWVQL1paTlhSUW9kVWlYRHdocmRn?=
 =?utf-8?B?d3Zzc2VadkQ5dXF3SmI2TGw4RzcxM3NLZHphaHZFZUhOS2s5VzFRdDl2MHl6?=
 =?utf-8?B?dG5uYnZQUkhkTlFJYTRJclJaeVpEbVBmZUpHR0NDSGVJVnJqd2plT3FTbThM?=
 =?utf-8?B?aTVJUk5LK3Y4QTgxN2JjTXpZa256WjFqRW5LYXQ4djBNb3dMMUZEblZUS1FO?=
 =?utf-8?B?V2J1bS9Zd3NxMlB4U2RCQ0FNbTBWL3hWTFNZT3dEaEZVVGtDRVowUzJRMkZC?=
 =?utf-8?B?UWJ6U3hRMmFtcXVVckVkYzM1VjhuNkpYY0VYZ2tLZGtFc0VvajhJRjN5N1Vy?=
 =?utf-8?B?UjVJdjhVRGxKVE9OZmRSajdobFhxYzBISWVjVzA0VzdQb0dDM2JZdzB2cFZF?=
 =?utf-8?B?c2RYYnlOcXRZMWIzM3AwbVVNbG12WFNNZkxxSGprSE5vbXk0cnloUjFzRDl5?=
 =?utf-8?B?bnFMUys5b1NWb0lkL1QvelE2RHdWL1RkcmZDZW5BY1pIejJEMFlZcmt1ajhp?=
 =?utf-8?B?a2pETTkzdkdMWk8vaVp6WWFESzlOKzlzQ2tmbVNrOWFOTGFVcnp0UWFBbkRz?=
 =?utf-8?B?SVl4NHkzTkkyNnRVdlJ1UDlYejNFMHNlUEZDZGdCYjlqdFlONWIrTjNQa0Iv?=
 =?utf-8?B?dHBBQ2RIWHBIaXBYM2JxcFpWWGNjREEzS3MrQ0U4ckNmU01oYlNwRDd1UUNv?=
 =?utf-8?B?QzBCKzlpUmQ4aC9rR2NyRXR4YmZyUTdVRDRyeWJZUDJvamovaWhnWWdYeDFk?=
 =?utf-8?B?REs1ZkVyS0JNdlNsU25ENGhIaWFFTUlNdEVwWGk2YTBybUdQRngwSTBlQjlo?=
 =?utf-8?B?UmRES1R5Yk5DekRmbVdBZVlKNEV1cllCd1BGRW8vSDV3anhpRm4vUXVJeGZF?=
 =?utf-8?B?NG5VV3U2Qi9WL1dsYTh1Sk1JN2crUTNZMU5GcmNXQkR0K1d3b3NXejh0VFBj?=
 =?utf-8?B?dHhqWGZTb1BrL3Nzdi8waVZNNGxyMnJzZnBHcW8zRWh1UHlmRHM2U1c2K0FM?=
 =?utf-8?B?cGlIblNkSmllVkI0N01YOXBGRE1XY1BGQjJFbFBkV3NIMVJGZE9lSWZra3RF?=
 =?utf-8?B?Y253MnNjL0hUYlNIOXlWbGhWYzI1a216OXE0dDRYaFMzaFg3QkZrMENXODA5?=
 =?utf-8?B?eit0bjZRWldqYnl1V1dkRjdLcDlKT2lTMVEvM3ZpNTlBRjQyM0gxS2hGNVZy?=
 =?utf-8?B?QmlqRlZrZGpWZEtIaTQ4eWdOdmxvSWpQOXRnOTFPSFcrZUVibnVVRzIwbUhz?=
 =?utf-8?B?ZzRoamtRQXY4THdXbVBaeWdPcHhZaUczS3lPOC9sTkw4OWpsMTFjbGlLQkVN?=
 =?utf-8?B?Y0V5ZzVBNzZHL29ESXYyeExXZy9rYVl2QjNhZk9nbDcxVHRRT0R4MGFOcGRt?=
 =?utf-8?B?ZmRHb1ltV2dvZkpYaEQrQTMzaEpUd2UxNVFzUmFvbVpEdDJXK250a2pSQkdl?=
 =?utf-8?B?LzU0ZXBRU0pCTnNxZ2wxQVFMZmtmMUw5RzZlMkFuVnhVOWJpOGZiWVF1b3N5?=
 =?utf-8?B?VUgwU2doUGVaVW5FQ3hBREx5ZkQ1NXl4ZDN2emRDaENUY1FGYUE1MlliaEU3?=
 =?utf-8?B?VjFPU0J4TzFwSlROVFBpMGlHaVA4RWJNOFFhdUlOeEMxbmxqQnNma3hUdXhO?=
 =?utf-8?B?Yk9WMWp5ekFpL2o2UEw2NWpnWWN3dkVTTTlSbEJ0UGtKa3VJbjdOc2cxbXo1?=
 =?utf-8?B?RWp3SGVUSlFNOTZLMDBOS0ZETTkvdXpERk1JTDYrbW9LUDNpVXdhVWFYOWNm?=
 =?utf-8?B?UWgzRTF0dkpGVlZmaGVvdnpTa3V0WTZONjJwczYwMU9PNXNJT0dsWXJmREgx?=
 =?utf-8?B?WTUyWHQ0T1Zrd0tia2ZON0syeE4zeGZlWGlhZ2ozRW5HVXVGR3lhMFJtcEVn?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d31f758-06c0-46ce-c3aa-08dc3df27f64
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 15:31:31.1561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44csQnRVWqQl/FNy7SkdeBLvDW+14Col1aFcaItbwVfTApQOryk6U+CwHYj0DnmtFuSaXQeY3rqDoYEQ3M5+HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8386
X-Proofpoint-GUID: A2IGptRt8Zj6v4BzHHOSj26oVvAbLvvN
X-Proofpoint-ORIG-GUID: A2IGptRt8Zj6v4BzHHOSj26oVvAbLvvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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


On 06/03/24 8:12 pm, Fabiano Rosas wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> Alter migrate_qmp() to allow use of channels parameter, but only
>> fill the uri with correct port number if there are no channels.
>> Here we don't want to allow the wrong cases of having both or
>> none (ex: migrate_qmp_fail).
>>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/qtest/migration-helpers.c | 20 +++++++++++++++-----
>>   tests/qtest/migration-helpers.h |  4 ++--
>>   tests/qtest/migration-test.c    | 28 ++++++++++++++--------------
>>   3 files changed, 31 insertions(+), 21 deletions(-)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index df4978bf17..0b891351a5 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -19,7 +19,6 @@
>>   #include "qapi/error.h"
>>   #include "qapi/qmp/qlist.h"
>>   
>> -
>>   #include "migration-helpers.h"
>>   
>>   /*
>> @@ -154,10 +153,12 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
>>    * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
>>    */
>>   void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>> -                 const char *fmt, ...)
>> +                 const char *channels, const char *fmt, ...)
>>   {
>>       va_list ap;
>>       QDict *args;
>> +    Error *error_abort = NULL;
> Remove this.
Ack.
>
>> +    QObject *channels_obj = NULL;
>>       g_autofree char *connect_uri = NULL;
>>   
>>       va_start(ap, fmt);

Regards,

Het Gala


