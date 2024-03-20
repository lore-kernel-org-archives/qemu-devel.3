Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1138CC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 05:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmoKb-0005O2-BN; Wed, 20 Mar 2024 01:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmoKS-0005Nf-HE
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 01:17:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmoKQ-0004Di-FG
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 01:17:32 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42JKP2uH011247; Tue, 19 Mar 2024 22:17:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=WW2Dhf8WIXTJ
 iOvaLqOPGyeYMdKZr1ZPVm47yPF1kF4=; b=HyRcmk8GK0wF4anQh+8x2JEyBfuB
 evyTXd/GkeSvIe9ZS6VY7O1g8E5wvmzJewOyafFcarMKU5eixJAxa3WWJK+ewWXf
 4HVHe5MdpZ+awvuJq8BZlG3uj2RpB6ogNClV1ksp2yUpOJngb61t82BDJ2mp01mi
 NC9vrKmJJoMSNO+MnHvkf0JXA57e9CxJ0l/wB60XNl1vu4CxepiynY0tYhevztRx
 BgKhbyFLoA53ORxAqXSzHQJu+/AJ/fk+VAxsE6DEBuB9MkEmZwx6HVVyUEzujIm1
 lGU5IDV665BpbpPocP8E+gd1LWqBY7GYj468YzcTAFRYAyuBMFOBKuZymg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wyhqmrrew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Mar 2024 22:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaWt6DADX4+OX8QIXWJzOy4FjJ9LkapA3rb99UFnGJP+Hxw9Stb9XCG+XsA/xjRETHKwulyS6kGCYEKC65bvgoshc2yIcZ4Ib5wF3tFFL7qeTzn3GzJljnC26CxV9IfGiZK2tjTslPhYuP4quex1hOAdzPRl0P3Lt0jcRnb1orjhT30tz4C+1cfwM+xtmq0oy0ENC4aIHgHmXI9I4fXzLQik4AeVFb0wKy4jb8vf2lLwQ5pQ0i5t/y3S9n6tmGjl6uJlC472qN51SYPxu6YKO/HQ9U2qoS/UIaumt+4EvgeMOBIcm58XtvP3hYpToLtyqZaN19M++6iNP+bAvdfS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW2Dhf8WIXTJiOvaLqOPGyeYMdKZr1ZPVm47yPF1kF4=;
 b=CShmOAQZ/R929/687WVOhtT9fFYDv8L0K9bVfvVJObQRgUYeUqza07EFaDJHIKHXOJsoxQnCS/Hdn1x8bLBrtMEv+k2KOpX997w17qkDjojYAe56NB4Rclss4CW6FxswM2oZr0EZPPHK3+O6JfEssWZPlGZjpkz4Mn+2MPtcTS3d2cds3rhAivTMd7hfwoNeO8tkeqMM8NpIUDEMJKNF3zPbfNep5pE8D68RA6y5w45Q7wG8Jg6pIdQPkJrDVxaLa2/OINfst0Kycwxk9XQUUh4DuN6Bc9kYRWAk4KUt8dyfqUBamYapOVQDek7WHaneGL/cD4FMJjpa5VB3boEozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW2Dhf8WIXTJiOvaLqOPGyeYMdKZr1ZPVm47yPF1kF4=;
 b=Ih5KXDnxi56oRRcfxXbEdrMvqZoCf5bwwuClDUjGEtE3ikWJK0tubxgrIIny59iCVcUCk6lEuyAyVxdAvW3AYSWlJhyVGWPShrVvXmK/d+pIAn4XKQgIYAqTZrEP2yRVl4zjdkWZL9sKE6gvMgwibScgv8ln/94zuNcM4Fmiy0pYOyVIAXUuCUhCVrmC6c9Sns9rGY7ttkf9aCrh0dksAHhD1sj/e6bz4fpxOuOzqlgwH06aERpDD1Jez9VOOVinVOdLTYUHZsSo39ifIQuhVb2H13BipmIUP7bfpo7JEhfPgzJTjt00Qj5JBi+6ajyKX/0AorIC6GOmvu0VoXIqag==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM6PR02MB6953.namprd02.prod.outlook.com (2603:10b6:5:253::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 05:17:26 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 05:17:25 +0000
Content-Type: multipart/alternative;
 boundary="------------bO07oGRvRJ4Xjx0TZ5dzrTL0"
Message-ID: <56ed1452-87ed-4cfb-912f-b15bc74609c1@nutanix.com>
Date: Wed, 20 Mar 2024 10:47:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/qtest/migration: Ignore if socket-address is
 missing to avoid crash below
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, farosas@suse.de
References: <20240319204840.211632-1-het.gala@nutanix.com>
 <ZfoKSgJ9LN1Q7R1V@x1n>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZfoKSgJ9LN1Q7R1V@x1n>
X-ClientProxiedBy: MA0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::8) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM6PR02MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: bd746099-d3d8-4a26-30cf-08dc489d0783
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROxYC63Y7RiQbQWgQtjEkLqyhaa3hyli+fr4A+kFu+LK3OQVmHc/79uTE534a6F2rc9n6+jAwVEJmeEkPyVBtlimJPne0gXixHOLQscFWYs+ld8/sSnSeXfq4R6Z4ilYj4p5ckG+QzS+7oe33yQLXtY/02+H86JOXejKOY148Egxd2dhFWCpSJfdyudxq4wf050lR1WYRkU8PvcfRtXwZVg9XesnSllJXzI1VuA56JMJDSB7u4h/t7lB4REMASkGtd0C52m/dBE7BD0qz9jDGEldF2w1t/aAUeM/RuZavNKvJIbbU7bql1jLw8N1QY/IpHkdJQRytEn63NqbwN1PrD2mB663gQy8assK2jCM0o0BJhFsQU67db42VYP7qmwbo5oVx/hvNIx3R+efk9xCrMgrDg+ApTHk6DkXza+edtaRc0tOtGEDR0jGFKTXOLk4X5jpvVIrk4n3C+Z9WonG4RZ0mdJn1iK2Y8DKPbLCDhDYJT5jKRAC+Fysmj4Dxz0OZdd0EQZb45VTGjHhW10REglDF1OZQGEZFRy8C1W+K9EvxGJZuMucirqJNJM40txL4RSUl0DUIezICORB13j3Csul64mMHUi7Bi1bJbwFg7u7pr/dWj0o/gzkpCuf3fmivCirPP3nldB8NUdMUw5SK8I6ZxBVgrHYL8sX8qEkSWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NtdGdabzVwZHoyUHBKNTB1UmhBOFV5akd5anlEci81NE04WmJXdlhzVndX?=
 =?utf-8?B?K0NpeVp1OC9BZFdETzIwMk56NFpWb0xtaDFwNHR1RVVNcCtYQXFpb2JkZkpq?=
 =?utf-8?B?bTBHVVEwUFNZODkrQ0JFZjJBTGN0QkE1dTZ3UzNMKzJYS2RocTFvYW5NK3h0?=
 =?utf-8?B?QTlRd1ExRjNhNk1LMnUxcWlSSVJqWGZlcEpLQVFPOExZL2hySjlkRGFJWW9u?=
 =?utf-8?B?RnJHT2tMSmhjdVdkaWFETllxOWdjeXpJT01HRldTU2NneDBEV0lNKytzbzl6?=
 =?utf-8?B?bm10cEtYblkyS2RIaUt1VFVIdklRcERVeEM4dGI3LzlDeDRFc1E0ZGc2dnU1?=
 =?utf-8?B?WUJ4Y0xSZ2VhbldUVHdYNDNNZktLeU5Ba3NRaXFkMDRTN0hjWS9VSVpQVVlm?=
 =?utf-8?B?NjNTZ3ZMQ2ExTVRTTVlOMjBMR3h6Z0I2ZWoxQmZYZmNSTjhLeGo2TVYxU05m?=
 =?utf-8?B?ek9nQ0htTmdsRUMzcEk2NFpFYjhpNTltR2RSd2ZHMm5jcnRiR0tXMFVNL1dy?=
 =?utf-8?B?Y21mNTArZEVWRFJjYnRwNmMzR09wN1hBcVpheHhPTDgvUFF0NVNUN29rRFRJ?=
 =?utf-8?B?cWhwRmw1WU82VDZZWGF3WXUrSWZucERrWUc2YkJueFZqRk40Sitva0VDb3NL?=
 =?utf-8?B?UVN0SGtYRzFMQzJCMDZBNCsrK2xCQy8yc0x6UnZ6SkVNSXcxazJYV3dweCtJ?=
 =?utf-8?B?NmdubGxENkZMK1Y2UUJHOUpWZytMNHU5Vi8zdnRvOEZCOWcybm5aUEEzNnRI?=
 =?utf-8?B?Y2pLSjQ1aEdVc0xpdDVTRVVDSTJwQmJURjF4Rkl5ODBOdlhOTEgrS25tSmpw?=
 =?utf-8?B?UFRmVDJDM1RraGpXbUw1Y2x5YTI1S0V3VnhhVjdHVW05SnRreWhLQ29iMVZM?=
 =?utf-8?B?REdEemRpcTMvVit6OFZkZUxPcDFTOEVpZTNvaEtHNklIeHo3NmxWNERSRkJs?=
 =?utf-8?B?b2E1U3ZLSzAxb2F3a1VDWUl6K1dGSFR4bTdiaWRBT0tPbnpqZDZXZjRRYTVp?=
 =?utf-8?B?YlVENUs4R2J2Y1FlemIzQTcrcDhlejNQaEE4RG5PbjlXeFFmTXBRSU93dTFq?=
 =?utf-8?B?RlJOaVIxVnFtOWgzVDliMmRCWGtRdGRlZDF2Z0VCbUhQemZuV2cxNUVvOFNW?=
 =?utf-8?B?QVFjbEtSV05XajAzcnRRdU9HdStyQ3VzMWltVDg0K01jQWh2MDN6dmtOQXB3?=
 =?utf-8?B?dFdodFBoWjZ1WHRaMnZvYUVmY3p5bkFNRWw1cG13Qm5iNjJ5YWJpcEZvL0V0?=
 =?utf-8?B?NWN6dWU5b3J2cjJSeHhyazhyQXM5NTREaEk1R0lRTWVaVjJsZ0h3YjBtM25N?=
 =?utf-8?B?Qm9YcWx5TDRFZTUwdnI2R2FGL3cxZzl3WmNjQ0ZRbDBrY3hBZmY3NHA5Q051?=
 =?utf-8?B?b3hXSVFBUWxESjhDZU4vN3F5K09vQ2VyT2FKeE9yNGRmOTNBRW5vcG9IY3VQ?=
 =?utf-8?B?Ni9aazEwRmNJdG5rdnJpdGFXZ244aXo4TUJwUXFqS2dsY2x6REpYMXJuYkVR?=
 =?utf-8?B?b1ZGQkhSYmt5cE8yNzFtSndRWHJPa1lFWVRqUmN5Nzh0N080QVQ1djU5N0pZ?=
 =?utf-8?B?SFBiSE5nOWNKeG9BRmlPbHNrd05GWU5CdkpUY3Fsd1UzcXpvU3Raa04xS2Ez?=
 =?utf-8?B?UkVTV0hDcGVpeFBvbmxXc1VWblhjWk1ZbDNRcHRTeDJJQVZEVmxKME1RMzFS?=
 =?utf-8?B?UC8zbjdRK2xqRDhuTG5MV2gxYTVSdGtMbFlHcCt0bGNTYVhlZzNxcGR5WHYv?=
 =?utf-8?B?cExtRmZMTU9kYmhmZkFTZWdJQlU5YXI1WC9peStoUDJJblJweEhoVWZIYUF2?=
 =?utf-8?B?S0hQNUQ3U21wTitSTTlxeUI5Yjd5VkF1emF3QWtYQmtuWnJmdUVQbmphVGxz?=
 =?utf-8?B?U0JzWkplOXh4SVltOFRIbjlmNjhEWVE5cjQrWlZCNTN5eGxKL1hSWEdMdHBw?=
 =?utf-8?B?dWpQRHRFUkhEUURZM3hLUFcwWGM0aUh4SWU4cDlscVBtUVY4VmNHSlZLdEcy?=
 =?utf-8?B?L0tNRlNnT0Q5ZW0vc3A2dGZscXVNUEZJZnBNNlZ3V1A3a1ZramE3RHdRRi9m?=
 =?utf-8?B?TlVCSXlobHAwK3lzeldkMHBzMlo2RlBBOUhQTlh4VEt3UGwraXZPMVpvMzZm?=
 =?utf-8?Q?qnGWYYETuIDklhYHgl07REOrK?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd746099-d3d8-4a26-30cf-08dc489d0783
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 05:17:25.4003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJH6SuqdR89CdcUDytlZ+sHYkPMsJ2Gss+SxtNRrXrWPktDusfYl5RQNqFxJ+SO7k0msZc15rdPSOWESzqTo/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6953
X-Proofpoint-ORIG-GUID: lCdjC08R1dMgIg1erb7U4KjzPhLaoE5-
X-Proofpoint-GUID: lCdjC08R1dMgIg1erb7U4KjzPhLaoE5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_02,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--------------bO07oGRvRJ4Xjx0TZ5dzrTL0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/03/24 3:27 am, Peter Xu wrote:
> On Tue, Mar 19, 2024 at 08:48:39PM +0000, Het Gala wrote:
>> 'object' can return NULL if there is no socket-address, such as with a
>> file migration. Then the visitor code below fails and the test crashes.
>>
>> Ignore and return NULL when socket-address is missing in the reply so
>> we don't break future tests that use a non-socket type.
> Hmm, this patch isn't as clear to me.  Even if this can return NULL now,
> it'll soon crash at some later point, no?
It won't crash IMO, the next function SocketAddress_to_str for a non-socket
type would return an proper error ?
> IMHO such patch is more suitable to be included in the same patch where
> such new tests will be introduced, then we're addressing some real test
> code changes that will work, rather than worrying on what will happen in
> the future (and as I mentioned, i don't think it fully resolved that either..)
>
> Thanks,
Maybe, Fabiano can pick this patch, and add along file migration qtests 
patch ?
>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> ---
>>   tests/qtest/migration-helpers.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index b2a90469fb..fb7156f09a 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -90,6 +90,10 @@ static SocketAddress *migrate_get_socket_address(QTestState *who)
>>       QObject *object;
>>   
>>       rsp = migrate_query(who);
>> +
>> +    if (!qdict_haskey(rsp, "socket-address")) {
>> +        return NULL;
>> +    }
>>       object = qdict_get(rsp, "socket-address");
>>   
>>       iv = qobject_input_visitor_new(object);
>> -- 
>> 2.22.3
>>
Regards,
Het Gala

--------------bO07oGRvRJ4Xjx0TZ5dzrTL0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 20/03/24 3:27 am, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZfoKSgJ9LN1Q7R1V@x1n">
      <pre class="moz-quote-pre" wrap="">On Tue, Mar 19, 2024 at 08:48:39PM +0000, Het Gala wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">'object' can return NULL if there is no socket-address, such as with a
file migration. Then the visitor code below fails and the test crashes.

Ignore and return NULL when socket-address is missing in the reply so
we don't break future tests that use a non-socket type.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Hmm, this patch isn't as clear to me.  Even if this can return NULL now,
it'll soon crash at some later point, no?</pre>
    </blockquote>
    <font face="monospace">It won't crash IMO, the next function
      SocketAddress_to_str for a non-socket<br>
      type would return an proper error ?</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZfoKSgJ9LN1Q7R1V@x1n">
      <pre class="moz-quote-pre" wrap="">IMHO such patch is more suitable to be included in the same patch where
such new tests will be introduced, then we're addressing some real test
code changes that will work, rather than worrying on what will happen in
the future (and as I mentioned, i don't think it fully resolved that either..)

Thanks,</pre>
    </blockquote>
    <font face="monospace">Maybe, Fabiano can pick this patch, and add
      along file migration qtests patch ?</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZfoKSgJ9LN1Q7R1V@x1n">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Suggested-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
---
 tests/qtest/migration-helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b2a90469fb..fb7156f09a 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -90,6 +90,10 @@ static SocketAddress *migrate_get_socket_address(QTestState *who)
     QObject *object;
 
     rsp = migrate_query(who);
+
+    if (!qdict_haskey(rsp, &quot;socket-address&quot;)) {
+        return NULL;
+    }
     object = qdict_get(rsp, &quot;socket-address&quot;);
 
     iv = qobject_input_visitor_new(object);
-- 
2.22.3

</pre>
      </blockquote>
    </blockquote>
    <p><font face="monospace">Regards,<br>
        Het Gala<br>
      </font></p>
  </body>
</html>

--------------bO07oGRvRJ4Xjx0TZ5dzrTL0--

