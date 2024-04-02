Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A798C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 18:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrjA4-0001M2-Aa; Tue, 02 Apr 2024 14:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rrjA2-0001Lm-10
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 14:47:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rrj9z-0008FA-I5
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 14:47:05 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 432DoXNe016401;
 Tue, 2 Apr 2024 11:46:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:from:to:cc:references
 :in-reply-to:mime-version; s=proofpoint20171006; bh=s7IW0jFxF3sc
 Ik2T9GIQqESHn+yRHJcvzRz1sIvirN8=; b=qbDcTHcHdDQM+JqBQmUK/45NTO2m
 wKKAuV6zIltQNi8si7JeFMut/I7GHZyRWtkkpt6fZHC+fDheGYrCanJcyjf/0jje
 ryrs8644s61Z/5z9gf3pXQ+NN5yIqVOJgd8gYIKZUf+ujEIibJrx/wI6AHEV3S98
 swYC2r3D6x27xcvxzL5j85IVWE9m8a5VGN1UXwwjrPkqkcjGZP/N67eqvNalaUWn
 nKPjHDywhPLhl9cKFSTOSRCF/9Omz616mqHf3xQ0ATmPiutMoly8f1i+lglLdd3J
 uhnKL0/rNuyBsxn3kGDhTxxfdkcegunM+finrwYRTc53LqZhG6KEAvDnJg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3x88dva4a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Apr 2024 11:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KECi9uZlG8LB5dDUBNK6XK8DTcGdrYZoYhqFhAs12wtbtvJyuJM/TxNae37Q0PbTfF8LCXTxFAYul2UXaB0XMJ0oKj5e0rd7SuXfncmzz1S8wQo+iKZgUr5X574FrKITU5ZMRk+C28TWyNbPgHAUS0fPWOyqEHtAavaejtZG+EeLYicETK1E9S9KY0vEujQ4cYi0WgX5f97JZLRvkWuAXRCCLrbySF9tFMVp3Jy7wffkpfUHIfEcEvupDlxWN3if5y9IC2NdsYpkgKe21wmdOppoi2VmCuZ5Nx1sRY2LegKNxAFj2It5Et9VpohQ8xTy2lUTjMztXehYmFPyTDd/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7IW0jFxF3scIk2T9GIQqESHn+yRHJcvzRz1sIvirN8=;
 b=mZXyd11ZFjn+b6FkHZRb/7GsvzjMaF6Zn8Z/lYvlPLVoL7c50Cd+r6V21gYFKomzh+uEKZ9uERW/Q5xDAjrz0DCFBECBWCVELvfVNz+hNZYfRFgfu3UEnNF5uG7JuYQ6Odeu9V+ie/DbdHZymryIJi486Yntb+GbUGFlJs9du6LnzGvJMQ7TR6Wh+KKDC2dnfYKsnZi7jg41y6d4Y4s1jIVG/cD5coh3dpIIefnPkNpeZ4+VBroNltZ6KjUH5AvwOPktzJGsvueslfA5MzvORfjDrSXyRQts1aOBuTnLPTIJIVbEy2Qrj+xsxiSEGiq5Wbj2whHgK8P830YlECkCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7IW0jFxF3scIk2T9GIQqESHn+yRHJcvzRz1sIvirN8=;
 b=PFAuNc/x8UpJFVV7kKuaczPZi3XpXPM01BisOknUAxjnnV8swJ6ilDUpPovx66GApuWkocD00bysHlj44eexOAblzhSASy4M8x4nnEN/Hg+lw1WNh9iYaF0wg/gJaI0Meg7aaD2NnhTbPGmvaJOsEgsogul5KdjXZaAgEnxW7Ja3GuVMJCIGnCbD0JbAJHmSR5M7FRaAZEzkA0E5ohrtOtlt0ICgf9+aeafGR0I5FYnvwa8W/PKB8lQRvEcCKpDAg2ndX2LoDq2HWiS34emZz2LM9otknSMW6q1XaW0sgMETZVlhBI3XQ1cZs9XojTdbhDDUiuYjcRyJ+/CwYePwyg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by PH0PR02MB7526.namprd02.prod.outlook.com (2603:10b6:510:5f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 18:46:54 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 18:46:54 +0000
Content-Type: multipart/alternative;
 boundary="------------M51ru4Be2uLgrXmuAF9VmFwh"
Message-ID: <882749e1-b08f-4b27-b83a-a808ea5521b4@nutanix.com>
Date: Wed, 3 Apr 2024 00:16:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Standardize qtest function caller strings.
From: Het Gala <het.gala@nutanix.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com
References: <20240326193843.8444-1-het.gala@nutanix.com>
 <87zfukvh0r.fsf@suse.de> <1f336795-5c5d-4320-8783-3cbe238f894c@nutanix.com>
Content-Language: en-US
In-Reply-To: <1f336795-5c5d-4320-8783-3cbe238f894c@nutanix.com>
X-ClientProxiedBy: MAXP287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::31) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|PH0PR02MB7526:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfihRjicr475nbWogIRl0I3Vo/VJLpRcJM5VaFlOArqZaBUBe0oC4KXDPaj1WahDcItAP3L5r8vUVjsVa92077ogApwmQOvI6f2mnknzu/RYwP7kQdpMphHJIurf8A31UghD3fy4u+LT6SPyseYOA5/K6ZAdrnzB2p4bm81JEp5IZlVBFeFDiVJMejC5vubb/gQVPuvr5/Pzzoly6x7yqq5+fbIigmwEE1nZeM/lrqRuQt4/R8S+M5bN0zi3UeRagVQra+1H242tTWVsS2KmpdFMJ6wChb+54S+vZpVCVFh4tE3sGP1we1sZE951sa2AceUr5NHHfPYrD0M8/Xp/7ieE8WOQBly9X6U4ycG+MjKVaYkfYKsa+PvhW86Ylx4QTmyMPfrrjYyjRKLktknSTnIL/CDqAj91kMSAGlvBa44WY1jVzIGHrf6kGHMznsBmWmToGZ6NTysxJh3VofLKTucoewkB+SQRmfYOpmrWnBRDYEX4ZkqC44mJ7vasEqIfbpBqYiJYqUXyp+R+QOjaHixQ/vJ4doQ/sJj6t7eru8z0pBjiGFGAONs8/P7SQG1MVtcvN247kC96C3GUIqp2ATXsoB4qwrQnH1OYQHCpA2lg8+xvI5fZPcWO2OmCk2nJqlRNYTRORE8nGJBRzCX34uXh7b57DCYY3jxbdQAUWnk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUVkczhBWU42UUdjQ1BJdGJoWW44YWw5VmsvT0EyVkgvWTZGTk5vU01wR1JM?=
 =?utf-8?B?bzVVQ0NiMzVIUzFDb2pBNlhlTXE3cVQ4TytJOUJucU9jcmtWSXRTS0JUOXFE?=
 =?utf-8?B?MWdKWnRQczNGTjNMWDFQUlNKaVhlZjBsVWM2SUxhWjFTV3l6enU5aFZXNTZW?=
 =?utf-8?B?aFhmQVNlTWNNR2VuSitiaEFmVnQ1d0lOTjArdjFkVHZkTGN2KytocUJDK3V5?=
 =?utf-8?B?cTJ2Sy9NUXdNcVRFTjBpSkhScVFYSEJ4b0pPWGQ4bkVTS1lzR2ZTUDByaldX?=
 =?utf-8?B?TXZaUUFST1Y4Z3RCdCtaUVZ1MnYxNVRLZkczbkQ3RHVrTEY5bTdXZ3h6K1hz?=
 =?utf-8?B?TGdhYzJBTkFyS2duWVViTUVXb2o3c28yWklCcmJ1T1pwVE43cFhuZGpYelRW?=
 =?utf-8?B?d3FYb0ozL3BtampmQ2ZpQW1EdFhMU3BRcm1WMjU2cmhESDhYQnVySFlNWk1t?=
 =?utf-8?B?VkRXd1BHMnlKMUl2T1IvVFNqc1dKa2FIazl2TU1KRjQzQWRvZCtueWdlVzJz?=
 =?utf-8?B?QW9Sczltd2tCTkkxcC9Ob0VtbENQcU9LR3dNOGhIOVdkU1NPQkN5MmQ1Zk9Q?=
 =?utf-8?B?UjBMWHFrZVVLWlMweUtEV0wvSk1EdVB1ME5KdjBFOFJFYUJnQTZDbnNBcXhx?=
 =?utf-8?B?R0JRV1dnaTdxTGUxQ3Z5UE1rSHJqaURQY3pMYThTbW9ZQnhLRTgyb2tPWnh6?=
 =?utf-8?B?cHJCa1BmS0l4eTJmVGh5a3FYaFRJcUFycGxuQ1oyZjlMWTlwSmE4b01UU1NG?=
 =?utf-8?B?K0R0bWJQRzl5UDNtNkxIT2pzMzZTNVpKWEtSY2J1QXVIL1ZFd0pnWFRhSHFh?=
 =?utf-8?B?WC9GRGRvcXgxbm5lcHlrK0lGOWYxTDJoRUpqK0dKUWlrT0RRRjcxVkpMVVV6?=
 =?utf-8?B?dDRaZ1k2MDV1MWpZWGR5N3RSQ2ovdktZbVZNUzRJNW80eXNaSVJnbU40V2tY?=
 =?utf-8?B?WWZlejJ4WFIvMFVMdXNSVWFTM01yYkNFQ2xXR1NuaG9nWHFuMm0vYkZjN1dm?=
 =?utf-8?B?a1R6RVpjVHMvSTVEc0ZFZTVsMHBoNzFiUEFjZWFBYTFRTGFERTliUDMya0NK?=
 =?utf-8?B?Q0dNa3hFVHFSc1I5SEpkM0c5RjFiY3FUaUZpOXJyU3BiWDhmNDBPMTRlVXJo?=
 =?utf-8?B?TlFTNkxrRGNhQ1BFcFZ5L20vQUpUYUdjUVAzcU5LTWdrcGkzd2dLZjZzY3hO?=
 =?utf-8?B?Y0V4QzQ3b0ZSemtXSXZWT2F1T2JiQzRjY2htQXdCQUlLQlN1UnFIb0p5SWRO?=
 =?utf-8?B?N2JYdktrR1J3SWxnMXdqRnlMUjdwZnl1VkRBUGdhQkVkaStVQ2p2M1ZVT3Zs?=
 =?utf-8?B?VzhCaU5EcmhsYmtYMll2SHlxSnZGN2pWRlRkM1I5TjdrbndwbE5OZDRaRWYz?=
 =?utf-8?B?Z1BxZTI3WDZ6RkcrRXRMS1N0UUdERVp2bmF6UGRWdzBzeGZGeDZJaEdCVElP?=
 =?utf-8?B?bmlXa1AyMHdIajIyc3ZuQ2Q4Z1VzbVM4MzI5V2cxdno4RG9yb0Q3MG9kckl2?=
 =?utf-8?B?Wk9vYzZDTk5YYkZMNXY3MzZocVNvdlhyenpWZTZGb2REdE5lWU5kZWttQ1dT?=
 =?utf-8?B?K01abTliODhHY1RORXBTUEFqOVlNcUc2NEdkcWNwOUNqbHliaUc3YTN6bGpD?=
 =?utf-8?B?YVkrMXFrNzVjWnRaR1RlSThrWFAvN1Jzdk5PYUtWRmFGY3lrazZlRTEyTE1F?=
 =?utf-8?B?Sjc2bkJiTGNNZTFsaXE0K1NRM1o4eUlvZlZOYURKZnd2R0JhK0JmMFU4ZEJJ?=
 =?utf-8?B?SXdnY2hubTMrK1NFVksyUVdNcFdpUnM5VUgrb01vcHdkZDUvQ2xWTDhudTcy?=
 =?utf-8?B?bEQxQ1NsSW9xSlp2YngwSXhGa0FhUGVySmNmeWNtWHRYbHpPNTk2ZlJ2U3Aw?=
 =?utf-8?B?eXJuNjAxcE9OdUNJRnJnMFIrTXMzZllzVW5HaEJKWENOQ2ZxV3hDQTBpRXVH?=
 =?utf-8?B?V2t6S3A5VVRrNWZLajBmQ0RvcDArV01TQng2Y2YvTCswVTltUlNIYXgvdG5B?=
 =?utf-8?B?azcxVlRKQnI5TWo2azdUSGZXc1BhMHlDc1lzRU5zQ2hMT21uTWkzTTNDRDZ2?=
 =?utf-8?B?bU1BRkovNW44QnpEazNDSUk1blN2Mmx4WGR0U1VKY29iNGZOREtUVlpLeGl1?=
 =?utf-8?B?SmZsOTRHbGNjd3NlZGhxRUgxNGZydGFXUEVONUd6MXEwR1NNZDFTVklLQmdM?=
 =?utf-8?Q?nlkFqITYrSDf4IbwXB+UclbavDuuL+AGYS3nMfnDVmBn?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1c2eb3-8a78-4f9c-4fca-08dc5345440f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 18:46:54.2677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Q/8mz79GqqBi1VsJuACY7+Ylxw/yUY+6e3SdzZKnmxykFY6jpbw1gegqa/Lo0mM2amkvyM9J1cCyFOv9ttd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7526
X-Proofpoint-GUID: uLmnEso-SxmzbfID6sLa9Rwd9GbINcbS
X-Proofpoint-ORIG-GUID: uLmnEso-SxmzbfID6sLa9Rwd9GbINcbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

--------------M51ru4Be2uLgrXmuAF9VmFwh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

ping !

On 27/03/24 4:18 pm, Het Gala wrote:
>
>
> On 27/03/24 2:37 am, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>> Some comments, mostly just thinking out loud...
>>
>>> For <test-type> --> migrate
>>> /<test-type>/<migration-mode>/<method>/<transport>/<invocation>/
>>> <compression>/<encryption>/O:<others>/...
>>>
>>> For <test-type> --> validate
>>> /<test-type>/<validate-variable>/O:<transport>/O:<invocation>/
>>> <validate-test-result>/O:<test-reason>/O:<others>/...
>> Do we need an optional 'capability' element? I'm not sure how practical
>> is to leave that as 'others', because that puts it at the end of the
>> string. We'd want the element that's more important/with more variants
>> to be towards the start of the string so we can run all tests of the
>> same kind with the -r option.
> While also looking at different functions for figuring out the transport
> and invocation, my observation was that, there might be many capabilities
> added to the same test, while it might not be important also.
> Ex: /migrate/multifd/tcp/plain
> 1. multifd is defined as a migration mode.
> 2. It is also a capability, and comes in 2 parts [multifd, 
> multifd-channels]
>    though one is a capability and another is parameter
> Similarly in other examples of compression, there are many capabilities
> and parameters added, but it might be not important to mention that ?
>
> Secondly, there are multiple migration capabilities IIRC (> 15). And a 
> test
> requiring multiple capabilities, the overall string would be too long, and
> not that important also to mention all capabilities.
>
> Just thinking out of mind - Can we have selective list of capabilities 
> ? 1. multifd 2. compress (again, there might be confusion with multifd 
> compression methods like zstd, zlib and just 'compress') 3. zero-page 
> (This will have sub capabilities ?)
>
>>> test-type            :: migrate | validate
>> We could alternatively drop migration|migrate|validate. They are kind of
>> superfluous.
> I agree with the above comment. 'migrate' and 'validate' have a different
> set of variables required, some necessary, while other optional. IMO this
> will help is in streamlining the design further.
>>> migration-mode
>>>    a. migrate -->     :: precopy | postcopy | multifd
>>>    b. validate -->    :: (what to validate)
>>> methods              :: preempt | recovery | reboot | suspend | simple
> I want some inputs here.
> 1. is there a better variable name rather than 'methods'
> 2. 'simple' does not fit perfect here IMO.
>>> transport            :: tcp | fd | unix | file
>>> invocation           :: uri | channels | both
>>> CompressionType      :: zlib | zstd | none
>> s/none/nocomp/ ? We're already familiar with that.
> Ack. Will change that.
>>> encryptionType       :: tls | plain
>> s/plain/notls/ ?
> What if there is another encryption technique in future ?
>> Or maybe we simply omit the noop options. It would make the string way
>> shorter in most cases.
> This might be a better approach. Can have some keys/variables as optional
> while some necessary. For ex: for 'migrate' - transport and invocation
> might be necessary while it might not be necessary for 'validate' qtests
>>> validate-test-result :: success | failure
>>> others               :: other comments/capability that needs to be
>>>                          addressed. Can be multiple
>>>
>>> (more than one applicable, separated by using '-' in between)
>>> O: optional
>>>
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>> ---
>>>   tests/qtest/migration-test.c | 143 ++++++++++++++++++-----------------
>>>   1 file changed, 72 insertions(+), 71 deletions(-)
>>>
>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>> index bd9f4b9dbb..bf4d000b76 100644
>>> --- a/tests/qtest/migration-test.c
>>> +++ b/tests/qtest/migration-test.c
> Regards,
> Het Gala
Regards,
Het Gala
--------------M51ru4Be2uLgrXmuAF9VmFwh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font face="monospace">ping !</font><br>
    </p>
    <div class="moz-cite-prefix">On 27/03/24 4:18 pm, Het Gala wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1f336795-5c5d-4320-8783-3cbe238f894c@nutanix.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 27/03/24 2:37 am, Fabiano Rosas
        wrote:<span style="white-space: pre-wrap">
</span></div>
      <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
        <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com" moz-do-not-send="true">&lt;het.gala@nutanix.com&gt;</a> writes:

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
        <pre class="moz-quote-pre" wrap="">Do we need an optional 'capability' element? I'm not sure how practical
is to leave that as 'others', because that puts it at the end of the
string. We'd want the element that's more important/with more variants
to be towards the start of the string so we can run all tests of the
same kind with the -r option.</pre>
      </blockquote>
      <font face="monospace">While also looking at different functions
        for figuring out the transport<br>
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
      </font><font face="monospace">and parameters added, but it might
        be not important to mention that ?</font>
      <p><font face="monospace">Secondly, there are multiple migration
          capabilities IIRC (&gt; 15). And a test<br>
          requiring multiple capabilities, the overall string would be
          too long, and<br>
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
          <pre class="moz-quote-pre" wrap="">test-type            :: migrate | validate
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">We could alternatively drop migration|migrate|validate. They are kind of
superfluous.</pre>
      </blockquote>
      <font face="monospace">I agree with the above comment. 'migrate'
        and 'validate' have a different<br>
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
          <pre class="moz-quote-pre" wrap="">transport            :: tcp | fd | unix | file
invocation           :: uri | channels | both
CompressionType      :: zlib | zstd | none
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">s/none/nocomp/ ? We're already familiar with that.</pre>
      </blockquote>
      <font face="monospace">Ack. Will change that.</font><span style="white-space: pre-wrap">
</span>
      <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">encryptionType       :: tls | plain
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">s/plain/notls/ ?</pre>
      </blockquote>
      <font face="monospace">What if there is another encryption
        technique in future ?</font><span style="white-space: pre-wrap">
</span>
      <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
        <pre class="moz-quote-pre" wrap="">Or maybe we simply omit the noop options. It would make the string way
shorter in most cases.</pre>
      </blockquote>
      <font face="monospace">This might be a better approach. Can have
        some keys/variables as optional<br>
        while some necessary. For ex: for 'migrate' - transport and
        invocation<br>
        might be necessary while it might not be necessary for
        'validate' qtests</font><span style="white-space: pre-wrap">
</span>
      <blockquote type="cite" cite="mid:87zfukvh0r.fsf@suse.de">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">validate-test-result :: success | failure
others               :: other comments/capability that needs to be
                        addressed. Can be multiple

(more than one applicable, separated by using '-' in between)
O: optional

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com" moz-do-not-send="true">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de" moz-do-not-send="true">&lt;farosas@suse.de&gt;</a>
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
    </blockquote>
    <font face="monospace">Regards,<br>
      Het Gala</font><br>
  </body>
</html>

--------------M51ru4Be2uLgrXmuAF9VmFwh--

