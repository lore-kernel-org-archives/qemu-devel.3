Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCED0C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 08:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYLrh-0005gK-Hy; Fri, 09 Feb 2024 03:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rYLrg-0005fi-CI
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 03:04:04 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rYLre-0003em-4W
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 03:04:04 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 418L19pP022265; Fri, 9 Feb 2024 00:04:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=YZuFPUZQCWer6TxdJbiUF7df7YdDRBi2+ghPpo0ub
 kg=; b=MdzIep0lKTYriXnmK39nXWsJ+GPSh93tey6fVlHFvAZHYd8ITLtgVRLrj
 a8NaMkXpWn9dXy8ijmwDVi/8LDhAgnlkMp+ThWL3OvhNUwfkYosiKFiCaBGYcSPj
 t2iYSACwJOAKxy+MY9yM2J6gehAxoAdkaOFPlS5Y1xv/FLe99bvTl0vQK3kM/59j
 gAI5V23MciLGZ2DgIT6sVGIYAKxyl0Uzc3eA+fGUv5k1MJuW5gV3x5PQwC9aVNj9
 S1OZDcWcRYduobgeg/vRrB9c9Eoau49fvfs9MYb/IFzkKwSCsUCtd70G21q3DyIe
 9h+wC2EEtxRPjnYwOPs5Dv9/KQrAQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3w1kwam95b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Feb 2024 00:04:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwkrdpPhyDBZSrS5wKLz00UxemXlLkDaheM3yS1sqI7Xscrby3Z7g6W/hIkgZAN3QPJmAfuheAQ9tFNzdaMXOA/kT5G1sczISwCC18tcQUei41QyGtsQuzwa93aW08WGt/x47XIY2xNeC0USU2rJqmJ7eUuop3rGtIoFco931n1APdoQadYxtXlEcSR691TQZxQ68ZGxxZ+ALITUZ8yEyG+udHI0RRETXeEClJMZd1bZXjDsZQH1+qtFm89dKtjo6K4dLSJvMG0kF09U9rEJEvCiWxcRiDSP7J24FkIUGH1KUaSMzdOrLqsN7g19vlbJdLp4tSTT0XeeL8kdoyPrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZuFPUZQCWer6TxdJbiUF7df7YdDRBi2+ghPpo0ubkg=;
 b=aInwCzMWcHj1/unXtIXB86cAX6JUrgXBU8WPI+dIQL1FMO2S7Urmi0bvPvV534m6xRRNpzzTxfduhlp4HgAiGvpTAz55iG4y+qe8a+Ip8q6bNVxQBlE+N73TUBLzwdP/19Iv+zlF9FwYxJQ7lBEWd1QY5LkQjOc0PiVQ9s3r3bGTtD5pXRq+t1emYRvpqjwPIogK6ACaJ1VDtQn4VKwxWwiqZesLTSs7SQKWYSBpKPPpVuNHKR5G0lWijLMLWXP6ft6Cp4LtnqPZKa3oEhCI7+wPQLII5Bm9oOVj1VRGZ/5Rl4nX8eAXJfdKGwq4kEM9bk1x6OiWq+cli7UAhv2jVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZuFPUZQCWer6TxdJbiUF7df7YdDRBi2+ghPpo0ubkg=;
 b=Yo6+WyNIApaI/c16Dw1tJyiREgxPzWP0zZfTwAQOwD9dah75CXOW4xTKbDfCkzAkgg1MzxTRP0rhwUifg9rrz5LxjbjDiKwdgLRRwPxqDa2SjCsDUjWvoBXHtQguxLbpFRxa0Qj6DcXWyE57AXhK9DdSaoGha1xTFouqVkwiCi3eoAbSPP4JDD9lM5C8fop0hHZLk1WncmY86NRVpX0jUq0TA/FSSbiqZ2Pb8+prD/f5l/FVq4YvqIKMi9jV2rvtFhYIjnR3BHnJhnGf3zedJC5nanHawsUTiZULD2uHXBPBFrs13XcAr8PTNhbggsGh4nQNlBaZOJvp9wu8LyUsAA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by PH0PR02MB7765.namprd02.prod.outlook.com (2603:10b6:510:5a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.45; Fri, 9 Feb
 2024 08:03:57 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 08:03:57 +0000
Message-ID: <42395f38-d3e6-43a6-97eb-7f5cd6c2b3f3@nutanix.com>
Date: Fri, 9 Feb 2024 13:33:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qtest: migration: Add failure test for 'uri' and
 'channels' combination in 'migrate' QAPI
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peterx@redhat.com, farosas@suse.de
References: <20240209075128.226237-1-het.gala@nutanix.com>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20240209075128.226237-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|PH0PR02MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5b425f-ac4b-4fd4-0fe5-08dc2945aaa8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/c4RwjxjLnYRQI0IAEy/hmAlZUcQHNOLfyghcQ5pyFMpLbEvq9luTKovSLNJQHvF9k1hVqYcAeYGB32jcPfJW3wvyh5X/lGFwg3bMLhbPh442AKB4myy4vnbskg6x9IrrVtDOvJe9V+SWsYEi3jAHui2ySkKKqsMLq2D0qYAAglWWBkCxMkHnIv30Z8qi+zKxSzB3ZOrCkDR6rXn4yuCNuu5X2IWEoU+Ck+denzGgjKn+2spZHZBoClQ3Pw8uPA04d1pDB+Efl+levUvyNkunBp2Yx2ZZCSHb866Pz1+8HmSHPg+wC0BkAasYyOzdSKx9wnjU857TijeFo6mbaqWItCkxsAwi8EGa/k5jeC9nmKd5WsJ3fNOIBatIRCcJ6OtG0Pi6xGgQdCqggNmrfR8ZESz60CnuoW6VQhLCH5tw0Em/WqUCPhiXfFQcnmD4eMLNDyYgPixd56XwwEKNziL9IwxBfbYZKwgZGbt4jJ6NeV9tOoRh4DZQizYhBrKj4LaJ9/+T0KO3fQ4gn+ZVAzPZbGkEtETrch2T6AnnvI0rJT0AWbGATOzAp2os30tPhl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(66899024)(478600001)(6486002)(2616005)(26005)(53546011)(6506007)(83380400001)(6512007)(2906002)(316002)(5660300002)(6916009)(66556008)(66946007)(66476007)(4326008)(8676002)(8936002)(44832011)(36756003)(38100700002)(31696002)(86362001)(41300700001)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFNuSWVJQVpyODYwb3FZRUtlQ2dWWGlLbktrNFpUbTdJMHhhT3U2RjJaM0lG?=
 =?utf-8?B?eEZ0Wmo1S2hWUml6b05IbHdZNFpNRVY0ZUpyRGFvQ1RZNmJwcUlUN1pha3RN?=
 =?utf-8?B?YUtXWlpaL2oxakUySTE1TmlSUW13UEpFREhxTDJWVjI4UC83RFdaanYwSlA4?=
 =?utf-8?B?QkkwN0JYdnVydlp4ekVydzJRNlFxOEtUM2dQbGVmN1M2T29DUEVIeWVDcmlt?=
 =?utf-8?B?VUhJaXZCOUpNVkpOSWE4bld6ZkhoM0VUdFV5UUdsTFNIcDd6ekJqaUU3SHVG?=
 =?utf-8?B?YkU1ZWFIRm1ick1kczNHTGtwaTdacU5nTnAvK0p4R2NyNnFJN1N2bXczT3A0?=
 =?utf-8?B?NU1oUXdYQUFHcGU5MWxKSDJNYTc3Mm1pUWtlTWJBOVk5TVl1VjJyMVF3ellh?=
 =?utf-8?B?VFh4ZWZEdmVTSis5L3ZOUFRieWppeTlsS25LaXc3eWovWjZCZGJiSGQyMFE3?=
 =?utf-8?B?eWZlWDduS2c0ckMwenZlbnZsQkhNTzR5ejNOV091SVFGd1BDeHh4MFRGeUZR?=
 =?utf-8?B?SmQ4YnpZMDUrZjU4OU1LRTlEV1ZOYUtkeUVFS29BRE5TR0lCcnRPUFRWZk42?=
 =?utf-8?B?NitlWkZjc0dwUXVmZXhpaHRSZlhacC9oOWNFWFRWMU1QR1ZKRDFvajByL0FF?=
 =?utf-8?B?bHUzSjhNTE00N0R0N2QrSHJ2cWdSbUR1TC9LcnVoWE9lbnByRVkrSW1WYUlj?=
 =?utf-8?B?a1AxVnhqZTM2bjJtOGcyWkUrQlF5cytPRDFqWXFQRTErcWhCd2FLT2VvaHF4?=
 =?utf-8?B?NC9NSzZGQ1pjci9Ca1lOYVZtVi9kN0xrYjYxYnNFOEtXc01uVjNnbVZzYU84?=
 =?utf-8?B?Yjl2cWNMSDFraGd4TjlLYzNlZFU1OUJYZEsvdmhZOTdNWGNFa0pSR2p5RVdw?=
 =?utf-8?B?K1ZyUldwcmpVWGFmc3dQMTd6M3h0Qjc1TGs3YXNOUlBMK2xSTlpFdDREL0tZ?=
 =?utf-8?B?UG9JQTRDU0docFF4WE9TUDl5ZWNSVmRDeGF0TGFFanhVZEoyTVFkNk94L09a?=
 =?utf-8?B?SmN2Y0t0TEZsalBCN0J0OC9UZkZ6cjNnbWxVOXRJQ3ZneTlEb1JCNXJOYXEr?=
 =?utf-8?B?eDl1WXlWZG94dHVtd000czZyTWFIcDgzWFZIbjczR0M2blhnZjhDMldBNmJv?=
 =?utf-8?B?bmtMTG1QSklnL2QzWE4zdXZqZDRGbDd5MnlleEUwbEhXTFJqV0o4WGhaVTdX?=
 =?utf-8?B?R0Q3R0h6bWdhckRtU29KUlR2d3lDZE1mQUhDT1dQVWRPekRXVUlYZU52T3BV?=
 =?utf-8?B?cE80eWdiSnQxcitnYnVOdm1za1JuTGtMVHJCOXcrVVJVZmFNRXZFRlM3MjdQ?=
 =?utf-8?B?NzVzcHA2QVdYWlVCak90MGJHQXFsTFRCSlV0aWV6SVlzSGpEUWtoeDFYL0pa?=
 =?utf-8?B?NDJmWU5Sci9ZblZJQVo3Ylp6R09ISlAyRDVTVHRHL01ZZkMrT3ZQajE3NnB1?=
 =?utf-8?B?VEJYN2ljRDBGRktkTSs1dW80bWFEU0tDc3FQeEo0b3lhS1oxcXZuYjhKcDll?=
 =?utf-8?B?VVQzMlRlSElxb0QzM0pzcklSbXMrcHFNMzBjNWdmMGdZcm9mRVhMUGVCVkov?=
 =?utf-8?B?SStOUlFxR1ZwK2p2R0FQWTR6N0kxUCt6M01wOVlJdFh2SU5Tb0Ztd3dteGpD?=
 =?utf-8?B?K1hEc2xXczRSNWJhYU9lSk0vZUpTVTFwWmVlcUFPNE43RnZMVm5GaUd2RlIz?=
 =?utf-8?B?RFR6TFJDbUJlQm9rT0FrU0l5WE01ODh1YlNJRWtkSXRNY3ZaVStqZDI4NnM4?=
 =?utf-8?B?ZW05R2xiQWgwSWxQTkk3RWhLNk95Ri9PMjRtdWc4NXh5dGtrL3Z1OVVsNUNq?=
 =?utf-8?B?bVloVEVhVFRGNWxkalNtR1Z2TU52L2RNb1BmTVRXS01sOTdKTHYwYzZFN0Fa?=
 =?utf-8?B?eUc0YVpXRTlsaTRxazVNMTM0QTJEbDVhVEl1Q3FZQXF4V0xYVjk1TXFiUDh1?=
 =?utf-8?B?ZHhyREh5NXlSVzR2azJ4TUszSmN2bFFCcUErdnJXRlFsbHhVVkdKMThXbmRy?=
 =?utf-8?B?VzhmZ2ZZRVpPQUtTdHFjdGREcm55emlOTnNGS0Z5bytBaEpOY1ozUHRNVVkv?=
 =?utf-8?B?VVo5RG91ZU9MMGtOTWlqRDBxdkFwano0YXhQbmxVazRsWFYzQlNzWWFvcGNw?=
 =?utf-8?Q?gS9/CVtD69g9bMS2kkjvJ9I6l?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5b425f-ac4b-4fd4-0fe5-08dc2945aaa8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 08:03:57.5208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xqx4hcfPsXo7Dq3Bv/6U4kupTRPBOoy83dGP/5Clhf12viz5sS38ccBBzWS+4WVy80BpJU2TiwX8NleHu/ldfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7765
X-Proofpoint-ORIG-GUID: pU7bwgxpsxQaU500KZEdFeZ-A7rU34eM
X-Proofpoint-GUID: pU7bwgxpsxQaU500KZEdFeZ-A7rU34eM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

I wanted to share an update regarding the patch I've been working on. It 
seems that the patch is not yet fully ready as it encountered some 
issues during the check-qtest builds.

This is my first attempt at writing a test case related to migration, 
and I'm aware that there may be areas where I could use some guidance. 
If there are any gaps in my understanding of how to properly mock a 
migration or if there are any other issues with the test case, I would 
greatly appreciate your assistance. I'm also struggling to understand 
why the test is failing. If anyone could provide some insight or 
assistance with troubleshooting, it would be greatly appreciated.

I've cc'd Fabino, Daniel, as I believe they may have expertise in 
migration testing and could offer some valuable insights.

Thank you for your help with this, and I look forward to any feedback or 
assistance you can provide.

On 09/02/24 1:21 pm, Het Gala wrote:
> Ensure failure occurs while adding validation test for 'uri' and 'channels' arguments
> used simultaneously in the 'migrate' QAPI command.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>   tests/qtest/migration-helpers.c | 14 ++++++--
>   tests/qtest/migration-helpers.h |  5 +--
>   tests/qtest/migration-test.c    | 60 +++++++++++++++++++++++++++++++--
>   3 files changed, 72 insertions(+), 7 deletions(-)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index e451dbdbed..2dbb01e413 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -43,7 +43,8 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
>       return false;
>   }
>   
> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      const char *channels, const char *fmt, ...)
>   {
>       va_list ap;
>       QDict *args, *err;
> @@ -52,8 +53,15 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
>       args = qdict_from_vjsonf_nofail(fmt, ap);
>       va_end(ap);
>   
> -    g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> +    if (uri) {
> +        g_assert(!qdict_haskey(args, "uri"));
> +        qdict_put_str(args, "uri", uri);
> +    }
> +
> +    if (channels) {
> +        g_assert(!qdict_haskey(args, "channels"));
> +        qdict_put_str(args, "channels", channels);
> +    }
>   
>       err = qtest_qmp_assert_failure_ref(
>           who, "{ 'execute': 'migrate', 'arguments': %p}", args);
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 3bf7ded1b9..d49e289c51 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -32,8 +32,9 @@ G_GNUC_PRINTF(3, 4)
>   void migrate_incoming_qmp(QTestState *who, const char *uri,
>                             const char *fmt, ...);
>   
> -G_GNUC_PRINTF(3, 4)
> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
> +G_GNUC_PRINTF(4, 5)
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      const char *channels, const char *fmt, ...);
>   
>   void migrate_set_capability(QTestState *who, const char *capability,
>                               bool value);
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index d3066e119f..3aaffc2667 100644
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
> @@ -1773,7 +1774,7 @@ static void test_precopy_common(MigrateCommon *args)
>       }
>   
>       if (args->result == MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, connect_uri, "{}");
> +        migrate_qmp_fail(from, connect_uri, NULL, "{}");
>           goto finish;
>       }
>   
> @@ -1869,7 +1870,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
>       }
>   
>       if (args->result == MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, connect_uri, "{}");
> +        migrate_qmp_fail(from, connect_uri, NULL, "{}");
>           goto finish;
>       }
>   
> @@ -2508,6 +2509,59 @@ static void test_validate_uuid_dst_not_set(void)
>       do_test_validate_uuid(&args, false);
>   }
>   
> +static void do_test_validate_uri_channel(MigrateCommon *args, bool should_fail)
Not sure if should_fail is of any value here. The test ideally should 
not enter migration also. Should just fail even before making the 
connection, at the QMP level itself. I added it here, by taking the 
reference of validate_uuid tests.
> +{
> +    g_autofree const char *uri = "127.0.0.1:0";
> +    g_autofree const char *channels = "{"
> +               "   'channels': [ { 'channel-type': 'main',"
> +               "                   'addr': { 'transport': 'socket',"
> +               "                             'type': 'inet',"
> +               "                             'host': '127.0.0.1',"
> +               "                             'port': '0' } } ] }";
> +    QTestState *from, *to;
> +
> +    if (test_migrate_start(&from, &to, uri, &args->start)) {
> +        return;
> +    }
> +
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    /*
> +     * 'uri' and 'channels' validation is checked even before the migration
> +     * starts.
> +     */
> +    if (args->result == MIG_TEST_QMP_ERROR) {
> +        migrate_qmp_fail(from, uri, channels, "{}");
> +        goto finish;
> +    }
> +
> +    migrate_qmp(from, uri, "{}");
> +
> +    if (should_fail) {
> +        qtest_set_expected_status(to, EXIT_FAILURE);
> +        wait_for_migration_fail(from, false);
> +    } else {
> +        wait_for_migration_complete(from);
> +    }
> +
> +finish:
> +    test_migrate_end(from, to, args->result == MIG_TEST_QMP_ERROR);
> +}
> +
> +static void
> +test_validate_uri_channel_both_set(void)
> +{
> +    MigrateCommon args = {
> +        .start = {
> +            .hide_stderr = true,
> +        },
> +        .result = MIG_TEST_QMP_ERROR,
> +    };
> +
> +    do_test_validate_uri_channel(&args, true);
> +}
> +
>   /*
>    * The way auto_converge works, we need to do too many passes to
>    * run this test.  Auto_converge logic is only run once every
> @@ -3536,6 +3590,8 @@ int main(int argc, char **argv)
>                          test_validate_uuid_src_not_set);
>       migration_test_add("/migration/validate_uuid_dst_not_set",
>                          test_validate_uuid_dst_not_set);
> +    migration_test_add("/migration/validate_uri_channel_both_set",
> +                       test_validate_uri_channel_both_set);
>       /*
>        * See explanation why this test is slow on function definition
>        */

