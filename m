Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD30C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYCZ-0006ik-Kw; Fri, 23 Feb 2024 11:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdXvi-0000l1-C8
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:57:42 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdXvb-0000NB-Lf
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:57:41 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41N76ohJ006114; Fri, 23 Feb 2024 07:57:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=JyaciDWa8BG2NUwZSzhNeBPoU2PWFnXjGxx8BLW8O
 30=; b=h5vchWsNeGh23h62oPpxuPqml5luiiRl3c4a88er6BdNle4tro8A13WDf
 GdbxnzlAKDOkJu7/1spVjHLAox3rdQ85j5v4hKziiItYUhpTXYIh7dDC61VXq+//
 cXigs1mB6BZTt+SOIcMV1wEys52URBB9sZHknCbtXTWnUZ28idzjFPWsCCPIZUXt
 oDe3G4ErufMbhcarQpS84+owp+FlxbzNd3/AWKNchscVKFFo6gr3exiQUO0+wUMc
 cUaqLavTRSErLLSAZ4tUAMyU7bev26Dxz9VlVuVyNksVsp3Vwd6ziHhgWDjZLMKx
 Ks12jOVvhgSWzUeG67vAigfax4Pcw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wd21884mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Feb 2024 07:57:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpT60OK79HHDplYz+9Mxa1vYxkZxHjkEffEgcUTV2E0Vj4AcO8CAQGRaHx2RIZiGCN9X6IuYec8SoEJwMFpIf3uAefdOxhKJWDiE8VHCzT7JUlBLh42Ul0q6Ez+FKLlZmJSQoJ/3nJ6RTLKZo/vexO62NB935HyI7I7O/KzuK7bpmZ/i7dwBuwJsFYR8Wqi/CJ5PzZors351IWSLCvZ17h3nv72HKOtEhyONFgYaN6Xwr0Z0sIGlWgZ0u/m/mWv6vT0e03o7Ls/KRH5VpzliwXlGCILeqRv0dzcLn8v4DuSDzSptkGPTooHo6/hP4dtnMKgmbLzy67Or7QfyXRyl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyaciDWa8BG2NUwZSzhNeBPoU2PWFnXjGxx8BLW8O30=;
 b=ewT/FK6Wc8BjPt1ihOficng+fCPYbyntGXN3qizM+bVHGtK6R3STA7ATfTdxV8W6CKWcdnRutSIEnLeNZoBnBywVcEu5NwR3km6ySwHA72cTtMXohsb/5OaD49wG8JnsyCrrVhYgo5TOWB2K5iSyrQ3tdh4I0xtFLT8DcsR4wfpcukncKHCneZOAV0sGth+X+FnORP4HU8y0qovN4KiVstJvA4HFz5wKWtlz1x4Gfc7PDOWwTxws10euPc74f8fbI/OsLPF4rtQVlVD/l22ws989N7ddv9h4Ra6rOE7861rQ9nIlWJdwoLx1Z1g3MSUoxnilnD3X9g0HZpdO5KP2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyaciDWa8BG2NUwZSzhNeBPoU2PWFnXjGxx8BLW8O30=;
 b=KcMQtMQ/obQR0bO4/UbcFfYC9KUQuPMnEpoKQmLbcGL//GeybKXojWx02+VLPOKEs8whmSkIpr42uvLCvkCkYV1uMOnGCAvlEsEHghLomzVSh8Lg6wpygV68oGmNOICd/CB5naKBpq9zqI46NKY+VW9NNl1UaoDi2yiSoDXtk84ixFrDhYrxFuLEMMwos6mRWqmNMxkvppQHr/hlXfueiUaLz4Rj3JITLDPz04jVQeA60QWCXomeH5UInwWkYuRGf/j3FYAOXpZsXdWw8C7HkEdvcuy22zAU+sUkXXwzwxv6/9T+GEy0/KlTcTpviu+NBiAdAmHrhL5PaleKa4J9LQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB7015.namprd02.prod.outlook.com (2603:10b6:610:5f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 15:57:28 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 15:57:28 +0000
Message-ID: <1d0a0a55-0b5c-47a4-9fbc-cf0637759c36@nutanix.com>
Date: Fri, 23 Feb 2024 21:27:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20240223152517.7834-2-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::22) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e80180-5fe2-4c69-1337-08dc34882250
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAM1fQI410UOKjEKUGjfDovIjgrNXxrWEmWtFDFoZI+GduDEv07qJwsYWJFzrEXmyXUzAfo860uLa01C6cqS504Ywx/rD/bIVJuwMxh173G/aMyyJmpr+YIYoyoQKxHxaSpnaohH+UPFdfYVNwox6zkZVEUR/JslGlJ2Ti50bQIMcHpmeLkediKc2IFQS69NlCgmubGrFtr5byXl51JfQGEHOqFs1fq3zZr8blNVnmLVJVveDEixjo5HhYhcpNwbwKW4BZxeHu8hG/eVaGbOTMQK7RRUJREDroZhX5rgiTrwWvF0bOuz7rpMYlfCEXfhTq4zgwQJZtSJWZ9+dBetMGCB+gLN1KxbpLbV2EH0ikt47lepWTQDwqnYUQLUAbve4H+QK7YVztHCir4dpgXciMDYhLGs6TUDyBOPZI2tsCVlv3CbqymXVIcYtC0gAMWqtDs8Fd/SWwFdn5IqJds0DVpIC4AYtRkWjOaQqK31neNfQHknt6ZrWo8XwcfOTH6WKfh9HU9lAXA7VPj14zEaPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWEwbkFCQzlKNWpzbmJvSGVtWlJvT3Rla2IvRmcreTUyVFU4RlNaWGNPWm92?=
 =?utf-8?B?VDJ2NXVXb3FxalIyS3R2bTZnT1UyU0hwSjZpeVRZQnZLMWdXWGJqbEF4dUhU?=
 =?utf-8?B?Rlpob2ZhMHZqWXFLUTZ5c3gzZjBEbDAybnNyclJ0T2R5d0s4cFl0bTBxNVJN?=
 =?utf-8?B?cS9INHpNaDNmREFSK2lBVmtmUFFYb1NBVHNCcUxjanczYUZNeXlOaWY4TUtX?=
 =?utf-8?B?Q1kxdHZoQ2NhV1luMkIvWFN1ZXpGZkJqUk8rbVNrSGxGWXVjakx0K1NneXRS?=
 =?utf-8?B?ZFlBcGxYV2xDT2lQNHVXYkxMRVhReXZBQ3ZlVTJnZjQyaUpLeWRFeDRrcjZh?=
 =?utf-8?B?OVNnWHAzL0VWakdjUkVUYXByQUhPQ0tUeXhJSFBOM2RYZWtBZ2tDMzJWVUtL?=
 =?utf-8?B?M24vd1FTT3FXV3ZMVUN4UFhteXhDRkVISVZKMFR4cTJmVWdUV2VITDhmU3JB?=
 =?utf-8?B?RXZsYytxeU1vOTVGNHFkKytVNThvcEUyYXBoYTRJSWF3NFU3Mnh5SUc1d3FE?=
 =?utf-8?B?bm1CSUVsWDFJd3dNMWlNOEdHazRzTXQ3amtrWmZoVDdlZWtPMGtNMmpvOEdl?=
 =?utf-8?B?TVZGeWp4UUcwamlVNG50bHFXdXNHUnl6YkUxeWNMUzU5Z2pzUDh0ZjQrM09m?=
 =?utf-8?B?N2xiVThYUXNoNzB4MTRydjNwNnZoNVBzTVNKSUlaV3ZzdytJeWF6U0hYblhm?=
 =?utf-8?B?alAwQmlDTTBlaHlzdlI4ZXFXZThJdHoxNC9PRXFISzlPMDdtS3pEWFZMMm0x?=
 =?utf-8?B?b3hyUUlpOVY4NU5LVWhhYVZNbVlxeTBWMlJRWU9mQ0w1N3FNVmJZOTRGQkVE?=
 =?utf-8?B?MEN2TG14U1N6ZkgzZi90ZGZBN2JGMTBoMS9mWlZXemxuQjVpb25ieVRVYkhR?=
 =?utf-8?B?M0EwRkRRbzFWZEFzUVFxbHFudVE5OXkxMW5Nc0lBODhsWDhLdS95a1R0QjFT?=
 =?utf-8?B?OVQrSHpSeGJEZ1lySmNXbXRNejZUSzdKUnJUQkpnR21OcklpWUh6TXZxZm9n?=
 =?utf-8?B?WDJZR3lZeVROSjlOSUs3T0ErUEphZFg3TDNoUVR3Y3k5MGZYUlhLUTdCTWcx?=
 =?utf-8?B?R2ZWZTlOMXNUb0V6Sk82Zlh1YnpqTWxJMDltOW91SlpzZFM4Q3Rxd0xLTVhJ?=
 =?utf-8?B?d3MzV21henMzcWpNMkJFaGpNWFQrWE16V25SRk5Vejd3aGh0MTlpWVMwdnpW?=
 =?utf-8?B?K2VlTmhsTXE5OC9WcWQ1SlIySURVTTVXOTc3VFdtNXFxYkJicHB4Z2hQWEYz?=
 =?utf-8?B?TWt2NVREL2ZpbFk2eTVTQU8wNEFGN3h4aUhocVlMQmJMb0hDV0hjY0swUzZV?=
 =?utf-8?B?cGNpZXhwdzg5QTlxejA1aXhLbjN6Y08yWkQwR05HSHpFNEtOdHhSWThjRWFQ?=
 =?utf-8?B?MlA4NjdoeDJBcklDcVdYd2lKVlpoM1g3cHBQSS9OaU9VTG82L0R4Z3V6U1lB?=
 =?utf-8?B?a0lmSWh5OHQ2a2t5TlY0OEFtZDdpMFlZdnUxRVFMTlpvS1h0Yy8zTFFUaWds?=
 =?utf-8?B?OVUzM0t4NXhpZmE2ZFZnYk9BR3REWVhCV1ZTL2U4MFdzQS94MkRNajVOazdV?=
 =?utf-8?B?emJzWEc3NTJzak94Smo4Rkt4SS9FaHlPMlhpdUJUbUh3UFVJaml3SlNVTGRn?=
 =?utf-8?B?YlUvTTF4K1NJbXZHL2pwWFVMV0krSjZXdzFhQldNc1JYdHBObFE4bXFSNUxz?=
 =?utf-8?B?RERXME1WNVpqR1pDWDBRYTZ3ZG1CWCtBbVNURUdsZzZJR0N1VUREcm9PaXFR?=
 =?utf-8?B?dGhLaWxzTC92S0lZOUd1UjUwb2pmT2d4M1hNZVBqWjR0OU5CdGNkR1VsbWtp?=
 =?utf-8?B?Y1p1TTFkK0ovVmpzd0NLWjh5UjVwSDRQOC9FOHh6QWgybVpMZnlUcE1CNXgr?=
 =?utf-8?B?ZUJBUGxBSHordTNibjFoeEQvVUFpL1VUMjFaWSsvc3ZLdzZybE1PcWZwa21w?=
 =?utf-8?B?VURyTFR3bnFPOUo5clgyVHNhcVNTZE1TOVFkK0lRbndMSUxNVUxROGsvMEtn?=
 =?utf-8?B?bTYza1hUMGUzeVlndXFYY0VQK0hDcjcwS3ZyckFkZVMxY0VEM2tBZ0tTeXJw?=
 =?utf-8?B?cHJkTStOU1JHWldla1RMS2xDVUU1Mk5NL1VHTHZuMzBLakdQRXNpclFWMFZ4?=
 =?utf-8?Q?NaihD/1PsEyR17EOcuiW3ro7V?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e80180-5fe2-4c69-1337-08dc34882250
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:57:28.1588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P62fag8IncCi1aW8uBsy7FpsqO5dLvYFX9AK4q36Nxb4kRpWKECPP6KTeRBLjUV2sTkJc6n9ksFN5SuAyZkhbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7015
X-Proofpoint-ORIG-GUID: PMvF_yn-TOxX7JZpEoyKQOGdbvhhDHwi
X-Proofpoint-GUID: PMvF_yn-TOxX7JZpEoyKQOGdbvhhDHwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

CI Run for the whole patchset series: 
https://gitlab.com/galahet/Qemu/-/pipelines/1188155391

On 23/02/24 8:55 pm, Het Gala wrote:
> Introduce support for adding a 'channels' argument to migrate_qmp_fail,
> migrate_incoming_qmp and migrate_qmp functions within the migration qtest
> framework, enabling enhanced control over migration scenarios.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>   tests/qtest/dbus-vmstate-test.c   |  2 +-
>   tests/qtest/migration-helpers.c   | 78 +++++++++++++++++++++++++++----
>   tests/qtest/migration-helpers.h   | 15 +++---
>   tests/qtest/migration-test.c      | 43 ++++++++---------
>   tests/qtest/virtio-net-failover.c |  8 ++--
>   5 files changed, 105 insertions(+), 41 deletions(-)
>
> diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
> index 6c990864e3..0ca572e29b 100644
> --- a/tests/qtest/dbus-vmstate-test.c
> +++ b/tests/qtest/dbus-vmstate-test.c
> @@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)
>   
>       thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
>   
> -    migrate_qmp(src_qemu, uri, "{}");
> +    migrate_qmp(src_qemu, uri, NULL, "{}");
>       test->src_qemu = src_qemu;
>       if (test->migrate_fail) {
>           wait_for_migration_fail(src_qemu, true);
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index e451dbdbed..15c3650b55 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -13,6 +13,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/ctype.h"
>   #include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qlist.h"
>   
>   #include "migration-helpers.h"
>   
> @@ -43,7 +44,67 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
>       return false;
>   }
>   
> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
> +static QList *MigrationChannelList_to_QList(MigrationChannelList *channels)
> +{
> +    MigrationChannel *channel = NULL;
> +    MigrationAddress *addr = NULL;
> +    SocketAddress *saddr = NULL;
> +    QList *channelList = qlist_new();
> +    QDict *channelDict = qdict_new();
> +    QDict *addrDict = qdict_new();
> +
> +    channel = channels->value;
> +    if (!channel || channel->channel_type == MIGRATION_CHANNEL_TYPE__MAX) {
> +        fprintf(stderr, "%s: Channel or its type is NULL\n",
> +                __func__);
> +    }
> +    g_assert(channel);
> +    if (channel->channel_type == MIGRATION_CHANNEL_TYPE_MAIN) {
> +        qdict_put_str(channelDict, "channel-type", g_strdup("main"));
> +    }
> +
> +    addr = channel->addr;
> +    if (!addr || addr->transport == MIGRATION_ADDRESS_TYPE__MAX) {
> +        fprintf(stderr, "%s: addr or its transport is NULL\n",
> +                __func__);
> +    }
> +    g_assert(addr);
> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> +        qdict_put_str(addrDict, "transport", g_strdup("socket"));
> +    }
> +
> +    saddr = &addr->u.socket;
> +    if (!saddr) {
> +        fprintf(stderr, "%s: saddr is NULL\n", __func__);
> +    }
> +    g_assert(saddr);
> +    qdict_put_str(addrDict, "type", SocketAddressType_str(saddr->type));
> +    qdict_put_str(addrDict, "port", saddr->u.inet.port);
> +    qdict_put_str(addrDict, "host", saddr->u.inet.host);
> +
> +    qdict_put_obj(channelDict, "addr", QOBJECT(addrDict));
> +    qlist_append_obj(channelList, QOBJECT(channelDict));
> +
> +    return channelList;
> +}
> +
> +static void migrate_qmp_attach_ports(QDict *args, const char *uri,
> +                         MigrationChannelList *channels)
> +{
> +    if (uri) {
> +        g_assert(!qdict_haskey(args, "uri"));
> +        qdict_put_str(args, "uri", uri);
> +    }
> +
> +    if (channels) {
> +        g_assert(!qdict_haskey(args, "channels"));
> +        QList *channelList = MigrationChannelList_to_QList(channels);
> +        qdict_put_obj(args, "channels", QOBJECT(channelList));
> +    }
> +}
> +
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      MigrationChannelList *channels, const char *fmt, ...)
>   {
>       va_list ap;
>       QDict *args, *err;
> @@ -52,8 +113,7 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
>       args = qdict_from_vjsonf_nofail(fmt, ap);
>       va_end(ap);
>   
> -    g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> +    migrate_qmp_attach_ports(args, uri, channels);
>   
>       err = qtest_qmp_assert_failure_ref(
>           who, "{ 'execute': 'migrate', 'arguments': %p}", args);
> @@ -68,7 +128,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
>    * Arguments are built from @fmt... (formatted like
>    * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
>    */
> -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
> +void migrate_qmp(QTestState *who, const char *uri,
> +                 MigrationChannelList *channels, const char *fmt, ...)
>   {
>       va_list ap;
>       QDict *args;
> @@ -77,8 +138,7 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
>       args = qdict_from_vjsonf_nofail(fmt, ap);
>       va_end(ap);
>   
> -    g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> +    migrate_qmp_attach_ports(args, uri, channels);
>   
>       qtest_qmp_assert_success(who,
>                                "{ 'execute': 'migrate', 'arguments': %p}", args);
> @@ -95,7 +155,8 @@ void migrate_set_capability(QTestState *who, const char *capability,
>                                capability, value);
>   }
>   
> -void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
> +void migrate_incoming_qmp(QTestState *to, const char *uri,
> +                          MigrationChannelList *channels, const char *fmt, ...)
>   {
>       va_list ap;
>       QDict *args, *rsp, *data;
> @@ -104,8 +165,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
>       args = qdict_from_vjsonf_nofail(fmt, ap);
>       va_end(ap);
>   
> -    g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> +    migrate_qmp_attach_ports(args, uri, channels);
>   
>       migrate_set_capability(to, "events", true);
>   
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 3bf7ded1b9..390e386274 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -14,6 +14,7 @@
>   #define MIGRATION_HELPERS_H
>   
>   #include "libqtest.h"
> +#include "migration/migration.h"
>   
>   typedef struct QTestMigrationState {
>       bool stop_seen;
> @@ -25,15 +26,17 @@ typedef struct QTestMigrationState {
>   bool migrate_watch_for_events(QTestState *who, const char *name,
>                                 QDict *event, void *opaque);
>   
> -G_GNUC_PRINTF(3, 4)
> -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
> +G_GNUC_PRINTF(4, 5)
> +void migrate_qmp(QTestState *who, const char *uri,
> +                 MigrationChannelList *channels, const char *fmt, ...);
>   
> -G_GNUC_PRINTF(3, 4)
> +G_GNUC_PRINTF(4, 5)
>   void migrate_incoming_qmp(QTestState *who, const char *uri,
> -                          const char *fmt, ...);
> +                        MigrationChannelList *channels, const char *fmt, ...);
>   
> -G_GNUC_PRINTF(3, 4)
> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
> +G_GNUC_PRINTF(4, 5)
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      MigrationChannelList *channels, const char *fmt, ...);
>   
>   void migrate_set_capability(QTestState *who, const char *capability,
>                               bool value);
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 8a5bb1752e..e5547b8746 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -18,6 +18,7 @@
>   #include "qemu/module.h"
>   #include "qemu/option.h"
>   #include "qemu/range.h"
> +#include "migration/migration.h"
>   #include "qemu/sockets.h"
>   #include "chardev/char.h"
>   #include "qapi/qapi-visit-sockets.h"
> @@ -1350,7 +1351,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>       wait_for_suspend(from, &src_state);
>   
>       g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>   
>       migrate_wait_for_dirty_mem(from, to);
>   
> @@ -1500,7 +1501,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
>       g_assert_cmpint(ret, ==, 1);
>   
>       migrate_recover(to, "fd:fd-mig");
> -    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
> +    migrate_qmp(from, "fd:fd-mig", NULL, "{'resume': true}");
>   
>       /*
>        * Make sure both QEMU instances will go into RECOVER stage, then test
> @@ -1588,7 +1589,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
>        * Try to rebuild the migration channel using the resume flag and
>        * the newly created channel
>        */
> -    migrate_qmp(from, uri, "{'resume': true}");
> +    migrate_qmp(from, uri, NULL, "{'resume': true}");
>   
>       /* Restore the postcopy bandwidth to unlimited */
>       migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
> @@ -1669,7 +1670,7 @@ static void test_baddest(void)
>       if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
>           return;
>       }
> -    migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
> +    migrate_qmp(from, "tcp:127.0.0.1:0", NULL, "{}");
>       wait_for_migration_fail(from, false);
>       test_migrate_end(from, to, false);
>   }
> @@ -1708,7 +1709,7 @@ static void test_analyze_script(void)
>       uri = g_strdup_printf("exec:cat > %s", file);
>   
>       migrate_ensure_converge(from);
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>       wait_for_migration_complete(from);
>   
>       pid = fork();
> @@ -1773,11 +1774,11 @@ static void test_precopy_common(MigrateCommon *args)
>       }
>   
>       if (args->result == MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, connect_uri, "{}");
> +        migrate_qmp_fail(from, connect_uri, NULL, "{}");
>           goto finish;
>       }
>   
> -    migrate_qmp(from, connect_uri, "{}");
> +    migrate_qmp(from, connect_uri, NULL, "{}");
>   
>       if (args->result != MIG_TEST_SUCCEED) {
>           bool allow_active = args->result == MIG_TEST_FAIL;
> @@ -1869,18 +1870,18 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
>       }
>   
>       if (args->result == MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, connect_uri, "{}");
> +        migrate_qmp_fail(from, connect_uri, NULL, "{}");
>           goto finish;
>       }
>   
> -    migrate_qmp(from, connect_uri, "{}");
> +    migrate_qmp(from, connect_uri, NULL, "{}");
>       wait_for_migration_complete(from);
>   
>       /*
>        * We need to wait for the source to finish before starting the
>        * destination.
>        */
> -    migrate_incoming_qmp(to, connect_uri, "{}");
> +    migrate_incoming_qmp(to, connect_uri, NULL, "{}");
>       wait_for_migration_complete(to);
>   
>       if (stop_src) {
> @@ -2029,7 +2030,7 @@ static void test_ignore_shared(void)
>       /* Wait for the first serial output from the source */
>       wait_for_serial("src_serial");
>   
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>   
>       migrate_wait_for_dirty_mem(from, to);
>   
> @@ -2387,7 +2388,7 @@ static void *test_migrate_fd_start_hook(QTestState *from,
>       close(pair[0]);
>   
>       /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
> +    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
>   
>       /* Send the 2nd socket to the target */
>       qtest_qmp_fds_assert_success(from, &pair[1], 1,
> @@ -2455,7 +2456,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
>       /* Wait for the first serial output from the source */
>       wait_for_serial("src_serial");
>   
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>   
>       if (should_fail) {
>           qtest_set_expected_status(to, EXIT_FAILURE);
> @@ -2558,7 +2559,7 @@ static void test_migrate_auto_converge(void)
>       /* Wait for the first serial output from the source */
>       wait_for_serial("src_serial");
>   
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>   
>       /* Wait for throttling begins */
>       percentage = 0;
> @@ -2609,7 +2610,7 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
>       migrate_set_capability(to, "multifd", true);
>   
>       /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>   
>       return NULL;
>   }
> @@ -2862,14 +2863,14 @@ static void test_multifd_tcp_cancel(void)
>       migrate_set_capability(to, "multifd", true);
>   
>       /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>   
>       /* Wait for the first serial output from the source */
>       wait_for_serial("src_serial");
>   
>       uri = migrate_get_socket_address(to, "socket-address");
>   
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>   
>       migrate_wait_for_dirty_mem(from, to);
>   
> @@ -2892,7 +2893,7 @@ static void test_multifd_tcp_cancel(void)
>       migrate_set_capability(to2, "multifd", true);
>   
>       /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
> +    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
>   
>       g_free(uri);
>       uri = migrate_get_socket_address(to2, "socket-address");
> @@ -2901,7 +2902,7 @@ static void test_multifd_tcp_cancel(void)
>   
>       migrate_ensure_non_converge(from);
>   
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>   
>       migrate_wait_for_dirty_mem(from, to2);
>   
> @@ -3234,7 +3235,7 @@ static void test_migrate_dirty_limit(void)
>       migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
>   
>       /* Start migrate */
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>   
>       /* Wait for dirty limit throttle begin */
>       throttle_us_per_full = 0;
> @@ -3275,7 +3276,7 @@ static void test_migrate_dirty_limit(void)
>       }
>   
>       /* Start migrate */
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>   
>       /* Wait for dirty limit throttle begin */
>       throttle_us_per_full = 0;
> diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
> index 73dfabc272..e263ecd80e 100644
> --- a/tests/qtest/virtio-net-failover.c
> +++ b/tests/qtest/virtio-net-failover.c
> @@ -772,7 +772,7 @@ static void test_migrate_in(gconstpointer opaque)
>       check_one_card(qts, true, "standby0", MAC_STANDBY0);
>       check_one_card(qts, false, "primary0", MAC_PRIMARY0);
>   
> -    migrate_incoming_qmp(qts, uri, "{}");
> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>   
>       resp = get_failover_negociated_event(qts);
>       g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
> @@ -894,7 +894,7 @@ static void test_off_migrate_in(gconstpointer opaque)
>       check_one_card(qts, true, "standby0", MAC_STANDBY0);
>       check_one_card(qts, true, "primary0", MAC_PRIMARY0);
>   
> -    migrate_incoming_qmp(qts, uri, "{}");
> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>   
>       check_one_card(qts, true, "standby0", MAC_STANDBY0);
>       check_one_card(qts, true, "primary0", MAC_PRIMARY0);
> @@ -1021,7 +1021,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
>       check_one_card(qts, true, "standby0", MAC_STANDBY0);
>       check_one_card(qts, false, "primary0", MAC_PRIMARY0);
>   
> -    migrate_incoming_qmp(qts, uri, "{}");
> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>   
>       check_one_card(qts, true, "standby0", MAC_STANDBY0);
>       check_one_card(qts, false, "primary0", MAC_PRIMARY0);
> @@ -1746,7 +1746,7 @@ static void test_multi_in(gconstpointer opaque)
>       check_one_card(qts, true, "standby1", MAC_STANDBY1);
>       check_one_card(qts, false, "primary1", MAC_PRIMARY1);
>   
> -    migrate_incoming_qmp(qts, uri, "{}");
> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>   
>       resp = get_failover_negociated_event(qts);
>       g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");

