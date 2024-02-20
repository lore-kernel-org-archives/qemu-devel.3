Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824BCC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVDu-00071M-OI; Tue, 20 Feb 2024 13:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rcVDp-0006xH-KT
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:52:07 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rcVDm-0000O8-If
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:52:05 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41KAMi9K030363; Tue, 20 Feb 2024 10:51:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=oVxIEkB7GlSo
 3Fp5jv6zYQBbilJtMc9ggZ4/rF9VX8c=; b=pfa/61FF2zaQb49X2B2lroZWla0F
 hgOojCIyNVQRz0BY9/94o3nUDFbCF8J23LLWMcDufBoBGdrfiM6jbBxQJvefxViu
 hi8Fm6RFtZJCQf2svnCVEDqElMUd9daUHAOs7jFTFgGkqvU+5FDGH0aynf4BKf/j
 ofd3LxvsVs2W83Tq5Mb8GzqLIukpo3ezjdy3hha87HOwRwEBXGLrKzzvlW9CRGUj
 AgS2nq3QMJckyyR3phIaK+WDowOr4EjlGkW/l5CagCBljgt3UU8P6iAezzTzp/h/
 jDXnX5H1E/amvmZnALmc/EsiKpCCZ4u/QggnoyKWE1G2fhfGTgAPaPpqEw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3waw80pq03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 10:51:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvVAO/5OXScjSdFZbsSsHurMttdiZg5ZcwgczKHl/nFj8YsC8RgusX2sTkejQfyFtXIWHaPNodmDeiQV9UwksGHvJC5w+c33EbJsE0JrAkHtB6BoYc65k2exrrCONkCzttab8jzYi5MQ1fiPmQtIzHykmxhkGP0CQGbQi+7GM+KhsHyWQdVvlmy1eTFnNizyVk/TTshshGki7DqM8dUAsCbRyA8j3PWhIfWCrexkLN890hwtxDsQfOEVhFaZUxyTs1SCpMQdZ4kJl8T8FrY5mbML5lEj+nVg+GyAtYQdYaRwewgDccYKM5ylYO/SKVWo9tzwmP8tLT4h8zrzm8uUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVxIEkB7GlSo3Fp5jv6zYQBbilJtMc9ggZ4/rF9VX8c=;
 b=A2H/+z7NHakrZMF5EwTR0P/OKCBgwr0r8jcfBhElKdYlOcgCpUc49CupfzUuHyud7rM/Z/hepLvZtDlZFf6y7fUmcgBzqhUIYFsOBntyQ7IFr6G3Q9/FUSvKXNEYpY6muFaIV+wgCZ1dR4X/uTwWmZZij+d6jRwkYig/7XUMrkJp4jDLcTDl0KNgcJV7I+2gS733GuvIFn1Q1WgsCzCjmnh2hINGoQM21WfpbuGfYvnHjWabsikd2UAOLC9wRRpxOXTFuECrJfafVss09BHVM0H3tCfNw83jXwzk9vvmaUH6NMwQrxKQE00SHkrmJiZxF2Vjw4F4GdTzyxoYnXYa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVxIEkB7GlSo3Fp5jv6zYQBbilJtMc9ggZ4/rF9VX8c=;
 b=Zi4hSg3+B7lwlyvc3b0yrrE+mKwid8WWRQyORZmr3W9Xes/BTYL8DEIXxkkr9k77vK918W5s1GQpPh36ax4Bik7FZxTq+avGWoZ4a9xllpmMNGlqKYsZ64a9rqu2yjlnm7GhXSfyeKu0L8l+37Qp7SO5YfIR69jOmcT7wv+zvejeYsRDSnqDbWQyuFblrZv7by8WWRmWMfINR75pc4FYysAhZS9fg9yeOLBApMEJ3EvQt3K1IG7ESky/ALWPhlDX4xJGAAFAXh1Ac0BQT6Drtt6rp1j9mKrNrZ+z5/hUAWeOSNzSOwt8LxG9V45pXK/Gx908L4Z/GDCNYcgMDB14EQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by LV3PR02MB10332.namprd02.prod.outlook.com (2603:10b6:408:1ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 18:51:55 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:51:55 +0000
Content-Type: multipart/alternative;
 boundary="------------UBwLi0eCrlBZB3lSxVxvFo8m"
Message-ID: <1b75feda-dedd-4a94-bb25-9b5a887e39f2@nutanix.com>
Date: Wed, 21 Feb 2024 00:21:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] qtest: migration: Add negative validation test for
 'uri' and 'channels' both set
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 farosas@suse.de
References: <20240216090624.75445-1-het.gala@nutanix.com>
 <20240216090624.75445-4-het.gala@nutanix.com> <ZdRGWE6JOwILipSu@x1n>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZdRGWE6JOwILipSu@x1n>
X-ClientProxiedBy: MA0PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::16) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|LV3PR02MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fde936-78f3-4684-1fb7-08dc32450210
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9XxA3VMYr1XX2tflHl7ymGWTyIl3P08HtLggnjSkT+XaGgOXHuFNMRkswPFpu1f854rRAVhBlKLgH41+z3y/e+HIu6hfNfKdjN9ZsG7EpudV1jdQNLwenJuOSpbg+OUm1ogrvDpSq1SORsY4hgpEYkHO41o5baC5C/RH4nf2T00TVcfloozFrXxTITOOco11gbJnxApXoO3jIL0firIuASE+wyVbtv3eTcYl3p5TcfPZ/uRl4m+UgRl61cy8JEY+EoEKn/aFXE/UMLt3ywy6IDsjmK4rp+Cjg9eKQJ72lWKFOHf6M10G9mro2KdUn+VThez8/8rBrsodJoQhZYNAR2GKhCTmRWvcv7hBPF8bFwgH3l1QYdh7H7xsJdH3A8U8H+ZYk7mGeKkaczpHO/2Vv8SfKulj66aNsMFwuho6LdaMvKurGaGOp9kwUSvOTLMmgAAo9m53bWb12hQPNCddkzqAuskN9qm81/etUPTIaH4e309/yRbZK7e7Y0aG5+zlAXgXko9EqnRp7l5b0GUZB1MkhLrNCzRpul5KK2tQrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzV4RERiWTFLclFwTTNYOTc0Z2Vyc01WZlZOTE4ybDBOaVBrUjFZYllOWWVu?=
 =?utf-8?B?ekt5WTZRZVdBNDlxSlpBaGVXQ1JLY1QvajBZSHRyUG1ZeUJ4M0p2cVVOaXVE?=
 =?utf-8?B?UTl6K3NmTXVaRHZvS2crTkp0M3p2cG1OejBmNmV5OHplalgrM1Q4QWpXNXRC?=
 =?utf-8?B?bCtZL2t3ekF1RGFuMCtVRk8yWHlDSkRRcERFNVoza1crbHFTT0s0S01qWUIw?=
 =?utf-8?B?TU5qYUJ1ZGFzQVJYZnRGazNGUXVRaTVCTXJMNEwvWGE4TU41SnlndnkxbVdo?=
 =?utf-8?B?b3BWdVdseFhlM09wZnRXWnFFUXEyb2Zwa0Z6SHRSSjA5UFcyVDcyUHREZGpJ?=
 =?utf-8?B?MHpCYTRWQ0I2aE1CV2xwbjYxMC9nd1JNNEdGNXRkY081YTlkdi9ldnhlVWo4?=
 =?utf-8?B?R2hVOHNaUHVRQktKNldGSHVMVkxMajJlc3RXbktMY3NJSEJ4QUVJY0RGanh2?=
 =?utf-8?B?M3F1MDlsOW51dndMK0p2ajBhMkpPR001ak5BOHBIakRnc0dwd0VVNnRRU1pE?=
 =?utf-8?B?RTc1VVVPTHZOWlhiUFRhR2pXNk1UOU9TdFYwY1VQaWlMaXNoenR1eG8xZW00?=
 =?utf-8?B?UVFjbkJEQWljTnkyMGpHZkE4M3h6aHlhNDRVOUhJQmR3SGVtb0ZwSC9YZmpK?=
 =?utf-8?B?cDAwSEMwb01kV2g2Z0UwbFM1R3Y5d1pncThkcFZrQU0zdVJMNGtrQW9yRVhY?=
 =?utf-8?B?L1BvVzYrdmR1eVEzMURWRWk1N1dZUUJvRVdzMHdLRHBFQVB0NmN4YU5hSmVP?=
 =?utf-8?B?a0pxanRFSlgrRFNBSE83a3d2SThkSGthb2RlQ1o0VmJtVUF4eWp6L05FWWZw?=
 =?utf-8?B?WldIblVBYVBtT3pCTW1YdWxJOGplZDJjTnRlMWtKZEpITkdGTGo4MlkzSGhj?=
 =?utf-8?B?emZ4TDQ2MnhndUk5TEo3SmoyQ0JFc2NsOC9xdmR2NGZBNW1VQkJjbnFpNVBG?=
 =?utf-8?B?cTZBbmlSN2dxV0NFNUw2dnJxbFJlMjgyQ2R5cmJjTi9mTitieWZiL2c0NVAv?=
 =?utf-8?B?cmszNmdLSk13Mlp0YUsrdVR6TFpkSXVlM3ZhMGFEM2hCOWliWTdLU2NNUE1J?=
 =?utf-8?B?SVpKYmpoWEhWTXVlUmkvTmZVdnJCckF3KzZJTjdWSmNnb1FEeE1Ham5aWHQ1?=
 =?utf-8?B?MkNJd1o0WEJGOHFJRHBHeVpxZnBJWHVTZlRnZnJLYXMvS3I0bG5DT1BENEdP?=
 =?utf-8?B?UGdBNDFaUGJIRTlTcTF1bnBuVm10R1pUdFZSaUFUUEEvT1RQMUh2VnU2enk5?=
 =?utf-8?B?TStVOU4yQWdTTVYwQUVpYUlBOEZRQ29tSGY3QXQzM0VRak5xU3k3U2V5WWV1?=
 =?utf-8?B?ZGZ4LzhwOU1ZOXdxK2pIMmNHYjhxbWk5SFpUa1IwczJVTVYyR1ZSSHdqUFNp?=
 =?utf-8?B?ZFlyVkJGZFlGZ0hKMG1JMnE0RUhsck9WSHlieGVDSFk3N0tac3JvV2NxMU9l?=
 =?utf-8?B?R2RKTUV5NjAvSFRHbFExTjdKek8xNzVRUWlNeUxDRzZFOUNXNnF5aUVYUm5E?=
 =?utf-8?B?QmF0OStKYzIxN2MzVDRhU2FNa2xtandnY25kS3VNUWFmdTVNTzFPV0tvVllC?=
 =?utf-8?B?V1JBdGtnNFU2eTRxZDFsUHdVSkRZVmJwQUFUSDNSbjFYWFpQUU5GTTJhdWJ6?=
 =?utf-8?B?d3NCMDZxNWNoSWxzbFRKV0ZCTFYxWERyenFyT25iWmpiWFNqRU84b1FkUTYy?=
 =?utf-8?B?OHQxaXlaNG9Mc1JiK29oSGN4bzdBRWVLeGRuY0xJZDlZR1RIYWFDbDlxQm1x?=
 =?utf-8?B?eWVLaGpwZ2NJSXo0eHlNeU9ZSGhhdDdoMzVZb3NxTGVKcTFyZDI5My9QSWsx?=
 =?utf-8?B?VGtFYjU4U0JxZFQ0a1Z3ejRpc0ZHYzZhaUdhbmtURmtNVU5Qc0l2Y1dLbHAy?=
 =?utf-8?B?eCsxRjNTZFBSYXZEdzl1S0thSjN0ZktJdEllZVdiVU9ESkI3dVZzQ1VPdEpj?=
 =?utf-8?B?UTRVbkJWOUtrUU1nRWQyb1VQQUEvYVVRN0s3RC9STlZRWDRJTHRHaDRYWDJh?=
 =?utf-8?B?Q3hHa2t0cjJHR2I4OVlBTyt1aW9ZUUorcHNNb3pPUUJVbkxrMUc0eUVGNkNk?=
 =?utf-8?B?NEszcVJPTzh1ZkpqclhPOFpmd28xUm9hR0pvVUtDUjRJQ1ltVFRKaXR3WHNI?=
 =?utf-8?Q?WV4zUZMo91VbeN/3KrjiyWeCm?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fde936-78f3-4684-1fb7-08dc32450210
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 18:51:55.1998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKxC4Qkm9KEkedILF4o/wxt+9PGa+ZJYOH78MW7E0/d8LktbEehRCRB0KSNs59eUHQ/6bslXuf2Y36oBWqfe0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10332
X-Proofpoint-GUID: tSFegzvNhLKyuBaMTtsd-Elsu8F2VUvE
X-Proofpoint-ORIG-GUID: tSFegzvNhLKyuBaMTtsd-Elsu8F2VUvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

--------------UBwLi0eCrlBZB3lSxVxvFo8m
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/02/24 11:57 am, Peter Xu wrote:
> On Fri, Feb 16, 2024 at 09:06:24AM +0000, Het Gala wrote:
>> Ideally QAPI 'migrate' and 'migrate-incoming' does not allow 'uri' and
>> 'channels' both arguments to be present in the arguments list as they
>> are mutually exhaustive.
>>
>> Add a negative test case to validate the same. Even before the migration
>> connection is established, qmp command will error out with
>> MIG_TEST_QMP_ERROR.
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> ---
>>   tests/qtest/migration-test.c | 83 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 0bc69b1943..9b9395307f 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -26,6 +26,7 @@
>>   #include "qapi/qobject-output-visitor.h"
>>   #include "crypto/tlscredspsk.h"
>>   #include "qapi/qmp/qlist.h"
>> +#include "qemu/cutils.h"
>>   
>>   #include "migration-helpers.h"
>>   #include "tests/migration/migration-test.h"
>> @@ -2516,6 +2517,86 @@ static void test_validate_uuid_dst_not_set(void)
>>       do_test_validate_uuid(&args, false);
>>   }
>>   
>> +static MigrationChannelList *uri_to_channels(const char *uri)
>> +{
>> +    MigrationChannelList *channels = g_new0(MigrationChannelList, 1);
>> +    MigrationChannel *val = g_new0(MigrationChannel, 1);
>> +    MigrationAddress *addr = g_new0(MigrationAddress, 1);
>> +    char **saddr;
>> +
>> +    addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
>> +
>> +    saddr = g_strsplit((char *)uri, ":", 3);
>> +    if (!saddr[0] || saddr[0] != g_strdup("tcp")) {
>> +        fprintf(stderr, "%s: Invalid URI: %s\n", __func__, uri);
> Can use g_assert() in such a test; stderr can be easily ignored and
> forgotten when it hits.
Ack. Will change that.
> I'd think parsing it from URI is a slight overkill, as we can pass in
> rubbish in the "channels" parameter, but it's still okay.
That's why I didn't make the dummy function of socket_parse(), which 
would have been a overkill, and just a split function was added. Let me 
have it for the v2 patchset. If it still feels like a overkill, will 
just have a dummy value for host and port, and type.
>> +    }
>> +    addr->u.socket.type = SOCKET_ADDRESS_TYPE_INET;
>> +    addr->u.socket.u.inet.host = g_strdup(saddr[1]);
>> +    addr->u.socket.u.inet.port = g_strdup(saddr[2]);
>> +    g_strfreev(saddr);
>> +
>> +    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
>> +    val->addr = addr;
>> +    channels->value = val;
>> +
>> +    return channels;
>> +}
>> +
>> +static void do_test_validate_uri_channel(MigrateCommon *args, bool should_fail)
>> +{
>> +    QTestState *from, *to;
>> +
>> +    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
>> +        return;
>> +    }
>> +
>> +    /* Wait for the first serial output from the source */
>> +    wait_for_serial("src_serial");
>> +
>> +    /*
>> +     * 'uri' and 'channels' validation is checked even before the migration
>> +     * starts.
>> +     */
>> +    if (args->result == MIG_TEST_QMP_ERROR) {
>> +        migrate_qmp_fail(from,
>> +                args->connect_uri ? args->connect_uri : NULL,
>> +                args->connect_channels ? args->connect_channels : NULL, "{}");
>> +        goto finish;
>> +    }
> IIUC below are dead code.  We can drop them.
I have kept it intentional, inorder to add positive test cases.In 
positive test cases, migration would be performed successfully. Will add 
a patch for positive test case too in v2 patchset series.
>> +
>> +    migrate_qmp(from,
>> +                args->connect_uri ? args->connect_uri : NULL,
>> +                args->connect_channels ? args->connect_channels : NULL, "{}");
>> +
>> +    if (should_fail) {
>> +        qtest_set_expected_status(to, EXIT_FAILURE);
>> +        wait_for_migration_fail(from, false);
>> +    } else {
>> +        wait_for_migration_complete(from);
>> +    }
>> +
>> +finish:
>> +    test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
>> +}
>> +
>> +static void
>> +test_validate_uri_channels_both_set(void)
>> +{
>> +    g_autofree char *uri = g_strdup("tcp:127.0.0.1:0");
>> +
>> +    MigrateCommon args = {
>> +        .start = {
>> +            .hide_stderr = true,
>> +        },
>> +        .connect_uri = uri,
>> +        .connect_channels = uri_to_channels(uri),
>> +        .listen_uri = "defer",
>> +        .result = MIG_TEST_QMP_ERROR,
>> +    };
> Instead of using MigrateCommon/MIG_TEST_QMP_ERROR, IMHO you can unwrap the
> whole do_test_validate_uri_channel() here, invoke migrate_qmp_fail()
> directly with the wrong parameter set.
Again, kept this for separating negative test cases from positive ones. 
If it still does not make sense in 2nd patchset, can unwrap into a 
single function itself.
> See, for excample, test_baddest().
>
> PS: please scratch my previous comment on patch 1 over the assertion; I
> just read that all wrongly.. sorry.
Ack, no worries.
>> +
>> +    do_test_validate_uri_channel(&args, true);
>> +}
>> +
>>   /*
>>    * The way auto_converge works, we need to do too many passes to
>>    * run this test.  Auto_converge logic is only run once every
>> @@ -3544,6 +3625,8 @@ int main(int argc, char **argv)
>>                          test_validate_uuid_src_not_set);
>>       migration_test_add("/migration/validate_uuid_dst_not_set",
>>                          test_validate_uuid_dst_not_set);
>> +    migration_test_add("/migration/validate_uri/channels/both_set",
>> +                       test_validate_uri_channels_both_set);
>>       /*
>>        * See explanation why this test is slow on function definition
>>        */
>> -- 
>> 2.22.3
>>
Regards,

Het Gala

--------------UBwLi0eCrlBZB3lSxVxvFo8m
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 20/02/24 11:57 am, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZdRGWE6JOwILipSu@x1n">
      <pre class="moz-quote-pre" wrap="">On Fri, Feb 16, 2024 at 09:06:24AM +0000, Het Gala wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Ideally QAPI 'migrate' and 'migrate-incoming' does not allow 'uri' and
'channels' both arguments to be present in the arguments list as they
are mutually exhaustive.

Add a negative test case to validate the same. Even before the migration
connection is established, qmp command will error out with
MIG_TEST_QMP_ERROR.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
---
 tests/qtest/migration-test.c | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0bc69b1943..9b9395307f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -26,6 +26,7 @@
 #include &quot;qapi/qobject-output-visitor.h&quot;
 #include &quot;crypto/tlscredspsk.h&quot;
 #include &quot;qapi/qmp/qlist.h&quot;
+#include &quot;qemu/cutils.h&quot;
 
 #include &quot;migration-helpers.h&quot;
 #include &quot;tests/migration/migration-test.h&quot;
@@ -2516,6 +2517,86 @@ static void test_validate_uuid_dst_not_set(void)
     do_test_validate_uuid(&amp;args, false);
 }
 
+static MigrationChannelList *uri_to_channels(const char *uri)
+{
+    MigrationChannelList *channels = g_new0(MigrationChannelList, 1);
+    MigrationChannel *val = g_new0(MigrationChannel, 1);
+    MigrationAddress *addr = g_new0(MigrationAddress, 1);
+    char **saddr;
+
+    addr-&gt;transport = MIGRATION_ADDRESS_TYPE_SOCKET;
+
+    saddr = g_strsplit((char *)uri, &quot;:&quot;, 3);
+    if (!saddr[0] || saddr[0] != g_strdup(&quot;tcp&quot;)) {
+        fprintf(stderr, &quot;%s: Invalid URI: %s\n&quot;, __func__, uri);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Can use g_assert() in such a test; stderr can be easily ignored and
forgotten when it hits.</pre>
    </blockquote>
    Ack. Will change that.<span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZdRGWE6JOwILipSu@x1n">
      <pre class="moz-quote-pre" wrap="">I'd think parsing it from URI is a slight overkill, as we can pass in
rubbish in the &quot;channels&quot; parameter, but it's still okay.</pre>
    </blockquote>
    That's why I didn't make the dummy function of socket_parse(), which
    would have been a overkill, and just a split function was added. Let
    me have it for the v2 patchset. If it still feels like a overkill,
    will just have a dummy value for host and port, and type<span style="white-space: pre-wrap">.
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZdRGWE6JOwILipSu@x1n">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    }
+    addr-&gt;u.socket.type = SOCKET_ADDRESS_TYPE_INET;
+    addr-&gt;u.socket.u.inet.host = g_strdup(saddr[1]);
+    addr-&gt;u.socket.u.inet.port = g_strdup(saddr[2]);
+    g_strfreev(saddr);
+
+    val-&gt;channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val-&gt;addr = addr;
+    channels-&gt;value = val;
+
+    return channels;
+}
+
+static void do_test_validate_uri_channel(MigrateCommon *args, bool should_fail)
+{
+    QTestState *from, *to;
+
+    if (test_migrate_start(&amp;from, &amp;to, args-&gt;listen_uri, &amp;args-&gt;start)) {
+        return;
+    }
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial(&quot;src_serial&quot;);
+
+    /*
+     * 'uri' and 'channels' validation is checked even before the migration
+     * starts.
+     */
+    if (args-&gt;result == MIG_TEST_QMP_ERROR) {
+        migrate_qmp_fail(from, 
+                args-&gt;connect_uri ? args-&gt;connect_uri : NULL,
+                args-&gt;connect_channels ? args-&gt;connect_channels : NULL, &quot;{}&quot;);
+        goto finish;
+    }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
IIUC below are dead code.  We can drop them.</pre>
    </blockquote>
    I have kept it intentional, inorder to add positive test cases.In
    positive test cases, migration would be performed successfully. Will
    add a patch for positive test case too in v2 patchset series.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZdRGWE6JOwILipSu@x1n">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
+    migrate_qmp(from,
+                args-&gt;connect_uri ? args-&gt;connect_uri : NULL,
+                args-&gt;connect_channels ? args-&gt;connect_channels : NULL, &quot;{}&quot;);
+
+    if (should_fail) {
+        qtest_set_expected_status(to, EXIT_FAILURE);
+        wait_for_migration_fail(from, false);
+    } else {
+        wait_for_migration_complete(from);
+    }
+
+finish:
+    test_migrate_end(from, to, args-&gt;result == MIG_TEST_SUCCEED);
+}
+
+static void
+test_validate_uri_channels_both_set(void)
+{
+    g_autofree char *uri = g_strdup(&quot;tcp:127.0.0.1:0&quot;);
+
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .connect_uri = uri,
+        .connect_channels = uri_to_channels(uri),
+        .listen_uri = &quot;defer&quot;,
+        .result = MIG_TEST_QMP_ERROR,
+    };
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Instead of using MigrateCommon/MIG_TEST_QMP_ERROR, IMHO you can unwrap the
whole do_test_validate_uri_channel() here, invoke migrate_qmp_fail()
directly with the wrong parameter set.</pre>
    </blockquote>
    Again, kept this for separating negative test cases from positive
    ones. If it still does not make sense in 2nd patchset, can unwrap
    into a single function itself.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZdRGWE6JOwILipSu@x1n">
      <pre class="moz-quote-pre" wrap="">
See, for excample, test_baddest().

PS: please scratch my previous comment on patch 1 over the assertion; I
just read that all wrongly.. sorry.</pre>
    </blockquote>
    Ack, no worries.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZdRGWE6JOwILipSu@x1n">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
+    do_test_validate_uri_channel(&amp;args, true);
+}
+
 /*
  * The way auto_converge works, we need to do too many passes to
  * run this test.  Auto_converge logic is only run once every
@@ -3544,6 +3625,8 @@ int main(int argc, char **argv)
                        test_validate_uuid_src_not_set);
     migration_test_add(&quot;/migration/validate_uuid_dst_not_set&quot;,
                        test_validate_uuid_dst_not_set);
+    migration_test_add(&quot;/migration/validate_uri/channels/both_set&quot;,
+                       test_validate_uri_channels_both_set);
     /*
      * See explanation why this test is slow on function definition
      */
-- 
2.22.3

</pre>
      </blockquote>
    </blockquote>
    <p>Regards,</p>
    <p>Het Gala<br>
    </p>
  </body>
</html>

--------------UBwLi0eCrlBZB3lSxVxvFo8m--

