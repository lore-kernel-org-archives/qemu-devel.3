Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC78C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQq9-0007tk-L3; Wed, 27 Mar 2024 06:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rpQq7-0007qH-J2
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:49:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rpQq3-0005WT-Vx
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:49:03 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42QNuMTt020002; Wed, 27 Mar 2024 03:48:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=j+TFqOktVWYc
 kT1hwnmGKmqDTesLXj14tN988C6V+B4=; b=lUSGdIsuSjcFDS56KPR2swEosJMK
 hgblVRDd+0KoWKxqgn66L3lkTx8ej00neJDtGRja8ZVDy78NHGlx8+3us39QdLQb
 laamNzW8d3tJjQtlcdjzfSsZTzeR87M8Uas8sLwkUve+h8AV/O1kc6h+uQKUl8so
 AVVYRWE7b3QMx82ajaXdaxYC7luD43q5VYIFGifzGxW/EBk9YZWyZoKWHY5DNbnu
 Nngq+dq756Vt0YHyGq5uKIC5BdRW7/GNPEm9y+jEp0QYJhqDI1CnDxkPk9gs7fLG
 1d4WE2xOSvIKSQb7nuiC5XiflRGYyyuYcAHP/kBHmShxXF7KVPsES6dNMA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3x1u070fwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 03:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnOVQxDi4cz3Y636VmNbMD+20MeJgMxyjy3qdO9DvPwVQnmQymHM4otGlgzWZnmHjUQQUmiuHUb9gjSWMrz1lB0fVNmWhK8n0EAoS68rdu1fjv/+mrpxWV/eLX5tDN9NvmOm9QDEBFSLRyj4QdNmTH0T8IXBB++QHK6xqZbelR9DM61IZX7L32hwfapibptpOjx5Fc6JRP+dFJrI89/NHxJYxseI2/bFG4K1/z09nau0wWZukJlwz/upo1vaAZtvmFXWZj6Ulglu16+Cr2R9iaADiJ7rrcQs6czHZqSG8lO+pa2/pLWszW8JyAXh4hMkGq+p9pT5Bvd5lWRnSTJfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+TFqOktVWYckT1hwnmGKmqDTesLXj14tN988C6V+B4=;
 b=PtztSspmQfdL4JC1Gau6+0wXH9uyLx02Grvw5B3ehvMp3dlLuqqpce8ssHxhaYPyoZmy8yD4C9leQb4cyb3mYgq4Im6wRw6IGMM+48qVDkJRhHkwPZM+4aC9j32uBEDe6hKL66uYkpOfx6kWDYlU3wRXSU6UYzwQdmx1KvDsfDzJzPvRGJFHWsu2Wk2xUs5avWm0/iRlFbdG6z22PYTAMPcQw7Zz7pdpXMdXy8lYNhSUnSMVlJWcBtzUxnVzuElK+v4t3elkEYfxuTbsQ1rW1awhUnzMRkdIkJ0N2aQ2/bTtcm5KsjLKM5TG8vAwKar9enQK9wKPRcz7es73f6Scrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+TFqOktVWYckT1hwnmGKmqDTesLXj14tN988C6V+B4=;
 b=QcIf9tzdFP/bdY5Pq3eJYmeg6HYIkULcGlMDsExGaNc9zums/Eht0ZNDfcYQxIfyaNQUPf9YgAWmVc7W6p06POofixj1H6iz1PAcr4RE3YOKrbLjD3BRaY8vvsoSCaapJoqoMXrPtFDaNNg8JW96nzkuSTxn9AydAuOXHQUh8G3D5TX6rn8kL1kX27PadubVRoBUuVaGbBlmGxbTWpGgAULEZ/1xK5Y8AopkVRVqdSCbkH0D/Yok0qsHfzImDgZ25O8qEmsPKeyAnHUjl36RiUefoYntC7I2Ukhg1UV7SkcsGiJ3QKV+reIhQTxiRIroqN28g/LIosq2r1541x9h8A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MW4PR02MB7411.namprd02.prod.outlook.com (2603:10b6:303:7c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 10:48:54 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 10:48:53 +0000
Content-Type: multipart/alternative;
 boundary="------------xfySB2Xd8iMdBH00sRZIlzLS"
Message-ID: <1f336795-5c5d-4320-8783-3cbe238f894c@nutanix.com>
Date: Wed, 27 Mar 2024 16:18:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Standardize qtest function caller strings.
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com
References: <20240326193843.8444-1-het.gala@nutanix.com>
 <87zfukvh0r.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87zfukvh0r.fsf@suse.de>
X-ClientProxiedBy: MA0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::13) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MW4PR02MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 4954e063-609c-4681-6555-08dc4e4b7ed6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlMEWIdcYRQ7Fq1tktew3cx7tumQw/dgHD4pLk6cIzUyDXN5khj5ehpWTu+wvBkS0UxK9Z9Wo2F1MTSVcnaSIEttXHTlfBcz+OX6KFYt0il4iuSiQ2QRRq330w2i/TKcXLdYQmpL7ODIW9oLwdu7OV5Pejn5GUdNiLBF/fLilHUTY6i4Ghnrc4ZXooJpdvS3lkEvrRuo82QRNgFLqG3XMN2KkLA9s5wWSTa47LDAMfWBLQxtS9tl9MTJXt+ITiQnQLg6IsQGOdTOlgAXLkgrMPminbf6+4MOfiHZNbuzmk3VWT3+RG2mIM5zeXQLdbytXzpsmi8L7CZThkECDFM9vcZhT/DadNq45FM2tc02MzIhUH6mbAr9/AFUzkrITy1vKkWCABt6/OkPBhQfCj/wQqjsew4X8eNX+DlRiH5BViYBdIC0cgwIbxCvALjveE67tbm7Hi+Lt7giFrE6xRLyGtshtIIKYK7BvHhsg7H6oqAXA1mAk9tgLA4Bug6eopG+s1mCC4HJ+LgB17paM3FO4NKr/RYvk76cmPbQzQIlwcZPzFzAM5W6QZ2anlcw8XpLcoKei6jLQTZKoUhXRESnEPtMTKd57t9UdmSB+0cJpykEljEafMKal4pWFy+GiMjOx41ZfPHp6hr3XMUY0LdTyEEA0BZMltjJA4002XmccHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a01UNmxkWkVHR3VBcTZHc3Y2MGF0eVZpZlA2cHBMY2FRVVpMdjJHTGhDR2tw?=
 =?utf-8?B?MlBheVRIT01tWE14S2JLa0RYM0Jkckw2WnR0MEpRR0s3bDZ0THQyREFCeldK?=
 =?utf-8?B?enpaWHpzZStKc25WemFmSUhYTW11dkt2YU5OVUIvOEFZMVRaYy9Pb29ZL3Rn?=
 =?utf-8?B?cFZiYWFkQlR6R2JBYVVuUmdrMHFvMlpBS29VSU1YV3pLYVg2K1c5K2VBZisw?=
 =?utf-8?B?SHIyR3VwU0NVakxHQzQ3dGhxL2J6aHpYWDMrRHIxcm14akNvT0E0c1Bzbk5q?=
 =?utf-8?B?cHpoWUVJREQrcUUvQUNxVjl3Q0puSU84Y3BZdGxKWU5mY1pFbittNmJpZzlW?=
 =?utf-8?B?VmQ1Zk1qUzhqRWphalh2QTJlWGtWY0w1WTgrNGJsaTdqRmpuV0RuSDM5SVp2?=
 =?utf-8?B?cHlQWDBrbWpGWjkwOWMzcXY3di8yQy8rNXF2NXRNa2c4c2tGaVdJejhPWGdu?=
 =?utf-8?B?VDNoTXFaN1FvdXdmR1ZZMytkZk1VdkpYeGJCNHdCdWJKeWJLRndoMm43RDUw?=
 =?utf-8?B?aENPZGxNaHRQUWRHRkl3d3B4QUozSEJ4UFFUZXhtbWRxd2NCM01hYStpVDJ2?=
 =?utf-8?B?UXk2U0ZGQjQ0aUJhVEw0ZE95NVUxRC9ZY0s0RGZsejQzZFl1WEpIUmFuRzVZ?=
 =?utf-8?B?Qm1VOE9zVWllTktRTHNNQ0gva0ZpbGQ1cjBYT2pQb2EwNlJHMnBQOTJ0YVRB?=
 =?utf-8?B?a0t5UERLQ3ZicEhBRTJ1a2QydE1EaThRZVRtWnRrOG9tbjBob3U2cUZQOTVD?=
 =?utf-8?B?MFg3WDAzZ1I2WUVOZnFzL1ExSGhPaHg2cCtXeWpERkhBWllUOFBCbHI3UktL?=
 =?utf-8?B?eWd5elVTbldCMVFkT1JxYjJ4S0MxVHFQdEd0ZVFlU2lrU0V5aVppL3kyZWFE?=
 =?utf-8?B?MlhzWVFKU2lFbEoxaUl4UHREUWEzQ3BzZXlsVGZSakt5N1U4U2RXdTRhZjhZ?=
 =?utf-8?B?QUhZUERKUG4zMUJ1RWxjTGNqamlUZTlVbVVOcUxaUVhDTVg3V3lJc1RETFFF?=
 =?utf-8?B?dDBkdHA3LzdUSVkyeElyMjZtYTYwT1JsNmFMN1F3eUM3NFhveGlOQUpXRzVa?=
 =?utf-8?B?NGgxdHNmQldsYi9WQTVlUDVyZXdWcjZkTjBDKzRuQ0NFc2lnWjIvcDRqK1RW?=
 =?utf-8?B?RXhFNXBjKy9aNTA5SjU3UWQ1RzAybWFHaE9tSEJFOUtGMnhKVGh3cGpHNzZr?=
 =?utf-8?B?SGRUTHlIU0JvWE1KQlRRc3hwVzRqTVRnOHVOeU1WNVR5R3dQWmdEZzRtRVFV?=
 =?utf-8?B?c0xmVmJVakVMNnllMkluLzhQUmJCdldSV3owNjM4M1FZVGJHZm9QdDhQUWQy?=
 =?utf-8?B?d2gxMFZ5REJKRUVOK1B1eTcrZEdmdlFISkliSm9vRW5XMEpsNWJkS0hwcDhh?=
 =?utf-8?B?OWpFL2ZYZTlZRTIyZmpoOUhkWWhQWldhRjUxcmdkRm5GdzBSTUUwdW5HeWlF?=
 =?utf-8?B?eGx3NXJVVEoxdWNDOXlxekErbkZIaDNlZCsxNjB3MjJLWjBienloS2tSMHM0?=
 =?utf-8?B?a3libjM0T2UyTUZRcDFJQU1GcFV2U1o0RHFESkRTTGpaWk5NRHV3R2hQMjdi?=
 =?utf-8?B?N0VmTkptbzNnSTdSZXdpY2V1SGYwTEw2cys4THdNVWpTdXZvZmY5c2dvczNq?=
 =?utf-8?B?WnlhaW00dGlDb2ZvNFZEdHJzc0Foa2VxUUJWbTlmWUFkZS9HbFcybENobnVh?=
 =?utf-8?B?bnJ5ZDQxM0puUkRzZFE4dHpuMUJibUFnanY4bkpLcFVZVVQxQlRXc3UzTGR5?=
 =?utf-8?B?Wm1ZQU9ZK3NlQmZqM1RxZUovdTNhZm9hQmRMbjF0KzJHb1pWdGRlUUFBcVVQ?=
 =?utf-8?B?OWp4cjJ3NlZBODNvOFNQaG9Jc3FQdVhHblFGeTlvb1pWQlVua0xRQlJ3c05y?=
 =?utf-8?B?ZDRzZ21pbXJObVNhbmZ4V1hmWEsrWU5qaXliRjM3TkhETVZ1UzlpYVpVcW9J?=
 =?utf-8?B?Sk85NzUxdUtYY2EvbkVjUjgrM1BLQU5jaTAzUDlpSzkyOXYxWmo1NUJZNi9T?=
 =?utf-8?B?VE1QK0QrSmhUd0NaVTVSL2RNZVBaSTJaWUUyMUl1VVVPeFhXM2dzWTZCYUNj?=
 =?utf-8?B?UmVZbFUxR2ZyTS9TYVVlcUV6SElKMzZqaHh6MEdlaUFBaGtmT3RPU01oOXlU?=
 =?utf-8?Q?HYcOQec5pxJv4lAVDEkIhmlg5?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4954e063-609c-4681-6555-08dc4e4b7ed6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 10:48:53.8226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHFizFTcoFnWLjEOEXD9kttgULG3jU+caC6ISWCSpiiASMS5dMpahNyGX5A+aBwoL6oOjNWdyHosfYENsu4k8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7411
X-Proofpoint-GUID: wJf6ca3k11Q3ZqunApWXVwG8dIkAPY2n
X-Proofpoint-ORIG-GUID: wJf6ca3k11Q3ZqunApWXVwG8dIkAPY2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------xfySB2Xd8iMdBH00sRZIlzLS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 27/03/24 2:37 am, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
> Some comments, mostly just thinking out loud...
>
>> For <test-type> --> migrate
>> /<test-type>/<migration-mode>/<method>/<transport>/<invocation>/
>> <compression>/<encryption>/O:<others>/...
>>
>> For <test-type> --> validate
>> /<test-type>/<validate-variable>/O:<transport>/O:<invocation>/
>> <validate-test-result>/O:<test-reason>/O:<others>/...
> Do we need an optional 'capability' element? I'm not sure how practical
> is to leave that as 'others', because that puts it at the end of the
> string. We'd want the element that's more important/with more variants
> to be towards the start of the string so we can run all tests of the
> same kind with the -r option.
While also looking at different functions for figuring out the transport
and invocation, my observation was that, there might be many capabilities
added to the same test, while it might not be important also.
Ex: /migrate/multifd/tcp/plain
1. multifd is defined as a migration mode.
2. It is also a capability, and comes in 2 parts [multifd, multifd-channels]
    though one is a capability and another is parameter
Similarly in other examples of compression, there are many capabilities
and parameters added, but it might be not important to mention that ?

Secondly, there are multiple migration capabilities IIRC (> 15). And a test
requiring multiple capabilities, the overall string would be too long, and
not that important also to mention all capabilities.

Just thinking out of mind - Can we have selective list of capabilities ? 
1. multifd 2. compress (again, there might be confusion with multifd 
compression methods like zstd, zlib and just 'compress') 3. zero-page 
(This will have sub capabilities ?)

>> test-type            :: migrate | validate
> We could alternatively drop migration|migrate|validate. They are kind of
> superfluous.
I agree with the above comment. 'migrate' and 'validate' have a different
set of variables required, some necessary, while other optional. IMO this
will help is in streamlining the design further.
>> migration-mode
>>    a. migrate -->     :: precopy | postcopy | multifd
>>    b. validate -->    :: (what to validate)
>> methods              :: preempt | recovery | reboot | suspend | simple
I want some inputs here.
1. is there a better variable name rather than 'methods'
2. 'simple' does not fit perfect here IMO.
>> transport            :: tcp | fd | unix | file
>> invocation           :: uri | channels | both
>> CompressionType      :: zlib | zstd | none
> s/none/nocomp/ ? We're already familiar with that.
Ack. Will change that.
>> encryptionType       :: tls | plain
> s/plain/notls/ ?
What if there is another encryption technique in future ?
> Or maybe we simply omit the noop options. It would make the string way
> shorter in most cases.
This might be a better approach. Can have some keys/variables as optional
while some necessary. For ex: for 'migrate' - transport and invocation
might be necessary while it might not be necessary for 'validate' qtests
>> validate-test-result :: success | failure
>> others               :: other comments/capability that needs to be
>>                          addressed. Can be multiple
>>
>> (more than one applicable, separated by using '-' in between)
>> O: optional
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>> ---
>>   tests/qtest/migration-test.c | 143 ++++++++++++++++++-----------------
>>   1 file changed, 72 insertions(+), 71 deletions(-)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index bd9f4b9dbb..bf4d000b76 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
Regards,
Het Gala
--------------xfySB2Xd8iMdBH00sRZIlzLS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 27/03/24 2:37 am, Fabiano Rosas
      wrote:<span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">
Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

Some comments, mostly just thinking out loud...

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">For &lt;test-type&gt; --&gt; migrate
/&lt;test-type&gt;/&lt;migration-mode&gt;/&lt;method&gt;/&lt;transport&gt;/&lt;invocation&gt;/
&lt;compression&gt;/&lt;encryption&gt;/O:&lt;others&gt;/...

For &lt;test-type&gt; --&gt; validate
/&lt;test-type&gt;/&lt;validate-variable&gt;/O:&lt;transport&gt;/O:&lt;invocation&gt;/
&lt;validate-test-result&gt;/O:&lt;test-reason&gt;/O:&lt;others&gt;/...
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Do we need an optional 'capability' element? I'm not sure how practical
is to leave that as 'others', because that puts it at the end of the
string. We'd want the element that's more important/with more variants
to be towards the start of the string so we can run all tests of the
same kind with the -r option.</pre>
    </blockquote>
    <font face="monospace">While also looking at different functions for
      figuring out the transport<br>
      and invocation, my observation was that, there might be many
      capabilities<br>
      added to the same test, while it might not be important also.<br>
      Ex: /migrate/multifd/tcp/plain<br>
      1. multifd is defined as a migration mode.<br>
      2. It is also a capability, and comes in 2 parts [multifd,
      multifd-channels]<br>
      &nbsp;&nbsp; though one is a capability and another is parameter<br>
    </font><font face="monospace">Similarly in other examples of
      compression, there are many capabilities<br>
    </font><font face="monospace">and parameters added, but it might be
      not important to mention that ?</font>
    <p><font face="monospace">Secondly, there are multiple migration
        capabilities IIRC (&gt; 15). And a test<br>
        requiring multiple capabilities, the overall string would be too
        long, and<br>
        not that important also to mention all capabilities.</font></p>
    <p><span style="white-space: pre-wrap"><font face="monospace">Just thinking out of mind - Can we have selective list of capabilities ?
1. multifd
2. compress (again, there might be confusion with multifd compression methods
             like zstd, zlib and just 'compress')
3. zero-page (This will have sub capabilities ?)
</font>
</span></p>
    <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
test-type            :: migrate | validate
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
We could alternatively drop migration|migrate|validate. They are kind of
superfluous.</pre>
    </blockquote>
    <font face="monospace">I agree with the above comment. 'migrate' and
      'validate' have a different<br>
      set of variables required, some necessary, while other optional.
      IMO this<br>
      will help is in streamlining the design further.</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">migration-mode
  a. migrate --&gt;     :: precopy | postcopy | multifd
  b. validate --&gt;    :: (what to validate)
methods              :: preempt | recovery | reboot | suspend | simple</pre>
      </blockquote>
    </blockquote>
    <font face="monospace">I want some inputs here.<br>
      1. is there a better variable name rather than 'methods'<br>
      2. 'simple' does not fit perfect here IMO.</font><br>
    <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
transport            :: tcp | fd | unix | file
invocation           :: uri | channels | both
CompressionType      :: zlib | zstd | none
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
s/none/nocomp/ ? We're already familiar with that.</pre>
    </blockquote>
    <font face="monospace">Ack. Will change that.</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">encryptionType       :: tls | plain
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
s/plain/notls/ ?</pre>
    </blockquote>
    <font face="monospace">What if there is another encryption technique
      in future ?</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Or maybe we simply omit the noop options. It would make the string way
shorter in most cases.</pre>
    </blockquote>
    <font face="monospace">This might be a better approach. Can have
      some keys/variables as optional<br>
      while some necessary. For ex: for 'migrate' - transport and
      invocation<br>
      might be necessary while it might not be necessary for 'validate'
      qtests</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">validate-test-result :: success | failure
others               :: other comments/capability that needs to be
                        addressed. Can be multiple

(more than one applicable, separated by using '-' in between)
O: optional

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
---
 tests/qtest/migration-test.c | 143 ++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index bd9f4b9dbb..bf4d000b76 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
</pre>
      </blockquote>
    </blockquote>
    <font face="monospace">Regards,<br>
      Het Gala</font><br>
  </body>
</html>

--------------xfySB2Xd8iMdBH00sRZIlzLS--

