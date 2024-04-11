Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61239C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 14:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvDN-0005C2-5E; Thu, 11 Apr 2024 10:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruvDL-0005Bh-Aj
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:15:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruvDI-0007H7-Jb
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:15:42 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43BBh3KN009439;
 Thu, 11 Apr 2024 07:15:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=loBEy02ucxW/ILHD+9TA0ZVD2qF6vA0/8Uv4FbVOc
 Zc=; b=ksTpFpzdsRlIGjTmIt0kBG/dW1oM6hHbejVsNCZIrrP52bEve3ljF+0F8
 GiTkDGp4qR3HVjkCu7Wm7XIxTAMu73lsavVfKq5Doef7gHDcl1WQerVLqll7JMDw
 a+disXeRkT8BY7vCJHh53uM8vIWKvmolEzNva6xlYQxtLHk5+cpS7hjGLvGrD68Z
 +it78TkoznsaEmukx9Y1Oa9sKv+wqOuNcw3Qt4qsAsCLp1c7E+Z7ivcfBe9JsFCV
 RQTfpNf9co54lhfQ2KeouBZWPQfWDl/eRkfP2S5FbkugetztX6ViIMhIvWhiFbZr
 qqDUTLt65pO7sKHmIr8muli79wU8g==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcuymnwp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 07:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw9jYpymNIV/dni2CLbTxkIjMlw/o2Tao11ucl6wX6+rAUjqL/Vj1p1us4Az1feV5NMGho1eUnRq09t0qBqrkIw0ZgrpRKooj78ktgBenkAGDwLAAona6i/uUnNw2jDR+MnmDPkz+/fTPWy8aLcMReVFHqbvVAXMipcpe0z/wJ1Ncy/TDwQb07GsR3fY/1CyUj2SKo6MpsYHb0jjiF3m4bxta0KAQo06TY0BM9rGlF6pI6ZnD6vns6qj5g1I57WyC+xdafGWjmKLEgdw0FN/Pwl0oKqOnBtSlj7pTLoWznMVy4S2JfiXU4yxdHyZANVtQ9UmAXr0AbJTXQmzdHialQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loBEy02ucxW/ILHD+9TA0ZVD2qF6vA0/8Uv4FbVOcZc=;
 b=Bbyf7orMbOreaDbFEYOIHYflXJ1idGqz5EW9G2ELlvB932GwgaVF94YWv+q3lsXu9ZEggu4/5XTryhAy4Y934FK5jFwigseM2VTwtn8YCsg5MyXkrj7gyxDI0wr0ckfDQ7up+1yXP3tpsogF78SGhc5JMvDQb0QTscQpI/hB5YkNQdFjm9IwQvbnPtk1XDM0zs1ZfBQXDWYqF+ztu1Xu72dNGsMGICFJySJw6jWpacbHXZL36VK8bpNlcEhOcWjilKTQBtOztETVyUgar72T8sZLawvDdMmgNMweMJ+DLr2Kig5L0etTUXyHzjPCn/+ygBIL9YXiudvhIEizjVPNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loBEy02ucxW/ILHD+9TA0ZVD2qF6vA0/8Uv4FbVOcZc=;
 b=Nwf9kUqSZYoZ2Zk+ByVwaa2MCaTrjE2Vnk4xw9ctZYCS0Ui7RUPT/katjnHhZXec21aTI49CpSasg0mF9G/jbUb4A6/ZvC+R6b4AoOCiVr9at0dm4/+dDdsHGTtavDPQ8kKvLPv/iLH/QzpTEv7mTwvwolCZJHITqwjA+GrOWNNl4EIhpPmt+zkyD2meN7hwEybHDwXpKM0tl4hPCLbyzO0ahuTZsmzgUrAkmMmvEhjVLE/88sjfsJ71Bdoi4NGh5CPuAADYXMm2rDRFDLhy7lkV6TfojStPLKUe9BFxIQmGCxPlsJdwcsKInhEdxS+6TOSNeAFo9woc18I9Ewl/Zg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BL3PR02MB8098.namprd02.prod.outlook.com (2603:10b6:208:35d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 14:15:32 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 14:15:32 +0000
Message-ID: <8621e850-168a-454a-8f00-615f476eac31@nutanix.com>
Date: Thu, 11 Apr 2024 19:45:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none() to
 use new QAPI syntax"
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, prerna.saxena@nutanix.com
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-2-het.gala@nutanix.com> <874jc9v066.fsf@suse.de>
 <Zhan0Brg_CXzt79-@x1n>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <Zhan0Brg_CXzt79-@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BL3PR02MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d1d941-282c-4e5c-0111-08dc5a31d923
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksZOW4TqgYzBXaNc3jpGA+Jb2MUbsJF+YhQXa6hDcCP8vIW1u4aC4BDX53FEBv4RJDAM1MBi5Ql4ipCn489lz/2++ys+tt5Djl4vzgRTmLg9wsBrS2bOioKafY3PCtvhOgw9Bwi1geIMwBpONeVE+vvkNDPNhHVq3kXO/0SpL11WaAbMPovhYLTWZ6JOlI/IL9kURSp/3P0I/CGjp/Zq3YSm/mGamrh5Crk6LvtHjbs+OzRt+LBMMjx8AOctaI9Qb9R2V/VZhBsFbC0NFRdxzWPUxTCtehIbe7NJ7eb0DO4rwyxMVpLG1BxHWvOqpM9Hqgc5XDrMHlAGXtIQVFcCEuiWuZrP1lswvKST45VRsJur5CUgKSWMf/jKoSxSKwBnl+VzQ1e1noKlDw7tfekgg8t67uxk7O5PbSZSKr6l3OPXdaHI4ik6spIAghP7haw1QReEmmYTeto4iD1RmB5PRXbpzRdWQurWgFgD/9mpKvVdW7i/xxpFUs/tw6//Fy8TpFjZzfLw3YrSm6RXVqIZm/Fg3zfXIkAnbsG72IUMtWhOczRUdtgMBA75JOjIoYeSj0fGwWHnFM5oG3VBFnjxJKqhJQOOGl/IxH2QzmiA2BfYpzUzdtVX1o7KpRuUp4PUxHFY/kPPWIASVOrlzAKa3oW43fvvb07Q57w084G2vr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z05tUGRnNzhRaGxnc0NveVBMUDBua09ZazdHYXRURllJTGhXUTVMMUxQYjMz?=
 =?utf-8?B?dUZobTRnTDdsVjdPSG8ydS9zVTAzam5lcWNZTGZSa3R1cWNsY20zdjVpMEVm?=
 =?utf-8?B?eHUvR1hIemw2aGltR1JvWmdLUlBrRjVzdW9VcnRlZHF6alBnTWdubHVENTkx?=
 =?utf-8?B?KzRaZW40YTJ5ZmM0cW1TOHlWWExpdEYzTGxpbVU3OW84VmxqUENHU2s5UXAr?=
 =?utf-8?B?c09UcUIxbTFPeHlSeVAreEFFNWwxUTQzUW0wdDdzd29DcjBUQVJmSzBpczFk?=
 =?utf-8?B?bStndmZyRTZOeWpHZzN1alZ0c1dYL2hPSHNmTzBrcXRuZ3lYVEU0UnB1YlNy?=
 =?utf-8?B?K21uRWROMUxQUjBkaFhRZTdpbWQzK1Q0RWtxRzhNcFhUN3dDSWZxWDEwTXdo?=
 =?utf-8?B?cmRVNWpRNWJjUytCZ29MN3RUVklYcFR5a1VOd3R5ZzZseUVWOVQxQzRxcEdw?=
 =?utf-8?B?ajRZQnVJdG9zVnNDV2hEV2lKR3RTcmpPM0IrMWFmVCs3RkNlUDFNdGJoREhC?=
 =?utf-8?B?cTU2eCswVlU0Rnp0YXAwcytOdHRwTk9nQ3IvWmNqZzJ1ajE3bDByOHJZVEw2?=
 =?utf-8?B?WnZEMXVseDBvcEhEVWdid1BmTS94ZklYNHA5VGVTcUkvY1lrbElqcm5lK0w1?=
 =?utf-8?B?QTJsNnlFdGkxamlXcVVHZXRDbFhBT011OUJSRTVoNzFTNGhKOWFKTHZuQjZW?=
 =?utf-8?B?a2JiQ3ZhZzN4MDhrR1YzL1RyL1VkYUxnbkhPR0xuN0N6RmxVbVJOSXJEU0FO?=
 =?utf-8?B?QW84SFpnNGM2ZlUremVxc0tINmYybWVudGZabTZLRGQ4ckx1aG1TMDVIeXBK?=
 =?utf-8?B?SDNleFJGN0h3NEtTVGNWV3U2MkM5UGZtR0dyRnVPMVgvbzhpanB1Ynk1SGxS?=
 =?utf-8?B?aVhFa3QzTjh0RHI3SzNFdFFuRCtnb1h3WlVZdTZVNVhoeE42eEw2a3VMS3VL?=
 =?utf-8?B?VFo2YXlzN0x3TFdnVldwWjJqV3NmYmt4cGFVTFFBL011QlJNSEI0UEtuRHVs?=
 =?utf-8?B?TUEzYTVUQWFURVU1UVRoaG5zcHVrYW1LcjNscVZrVk4zTU1wRHpkcHhSbjAw?=
 =?utf-8?B?WVZUMWJScDRlT2lDRmNtY2hKRkNkSUVJQ2dVcmdxQkE3Q2xjN0JDL0JoNyti?=
 =?utf-8?B?TkdoUGF4QnlZdGtEbmxEcUJjc2R2Y3h5cy9CM3FaOElVcXhtZTYvdlRBc1po?=
 =?utf-8?B?VlZFSUFldnAycnY5OHJ1dXltSFlvc1kyY0NqU043K3F6R1ZTcGJlaEdYNnpw?=
 =?utf-8?B?YmdzcnQrbWZJRGJuWUIwVGxrYnp4S1hwMys4Y29UYWtJdFdzZzlpc0hZS09G?=
 =?utf-8?B?b3B6OE8yVlRZZFZTRUJ2OVZIRjBvOWFoc3lsa1JrRWhDK3VCVlo4R0ZMNUZl?=
 =?utf-8?B?b2Y0MGtGTFBkQzNnZTErRnNXNTdnK3ExUDd0VjlaTXJJRjZrQVp0bXp3bVF0?=
 =?utf-8?B?TTlCaDA5YVh4UUhtR1dsM1hRMFo2MStFU3RVSCtCK2pMb0J0TERFcURrYVJn?=
 =?utf-8?B?MXBxUUM1eGlSUGF4aW9CZkVhR3pIak5pRGpCOVRzZ1ZtR0w1b2lIWXQyRWRi?=
 =?utf-8?B?WWg2V0tpbndNN01xeDJBcW8zZGdMemRKdy85UmFuN0s1QzQ1ZGl6Z2tNN3JG?=
 =?utf-8?B?cnBqOG81TGtHZnpHcDFhU3EyQTJZSW5XS3h1TnVIOUlrOUh0bFdpSENOMk8x?=
 =?utf-8?B?WDhaN242R3B4NEVuOUZPWkVJZ0s3M0JKcmkzV0ZDeW5rR3QzQXhSTVY1Z3RC?=
 =?utf-8?B?Wm96N1VHb0g5VmJ5TnkrWGMwaWJYWVMyN040Tk9Ba1JTWTEveHRxaUxaWHFh?=
 =?utf-8?B?S0REeUltZVhFMmFOSlVxMlUrY0hrZ01OaFNyWGNxZ2kvRHAzbUtnUWZCd0Z1?=
 =?utf-8?B?NVAzUEdFVXdmSWsvTVZJSktiNUwyMGlYL0gramdScFBaQmk2SE84WmNwQVQy?=
 =?utf-8?B?dytoUytrVForNEdzSkFGWTgxOFdwUlozbWdYQlNhR1dSeFpkZE5LKzVrQlFV?=
 =?utf-8?B?MXRVRi92em9SUUo4VlprRFphMXJSZTdmdGZLMWRtYXNhOS9DNGJYNlBlNUhZ?=
 =?utf-8?B?Y3ljRWw3bm1zOVhNb0FFZjN6TWd2czdKdHlwQ0djSWF3NkFyQ1VzS1g3RU1D?=
 =?utf-8?Q?6dHtx+3qpAS3cU25QnSs8IG5T?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d1d941-282c-4e5c-0111-08dc5a31d923
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 14:15:32.5675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xglSGZZYbvyTqt2aB94mUj02Nf26XrD4s2oAzxzUv2G5e0wWJGWjOjX17Xx01WUjvdN+KqfIcVZF2MyPesn7mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8098
X-Proofpoint-GUID: Dxn0o6gFceMb3TqJ-DOATIyHfbxgAIEi
X-Proofpoint-ORIG-GUID: Dxn0o6gFceMb3TqJ-DOATIyHfbxgAIEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_07,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 10/04/24 8:23 pm, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Wed, Apr 10, 2024 at 10:04:33AM -0300, Fabiano Rosas wrote:
>> Het Gala <het.gala@nutanix.com> writes:
>>
>>> This reverts commit 8e3766eefbb4036cbc280c1f1a0d28537929f7fb
>>>
>>> After addition of 'channels' as the starting argument of new QAPI
>>> syntax inside postcopy test, even if the user entered the old QAPI
>>> syntax, test used the new syntax.
>>> It was a temporary patch added to have some presence of the new syntax
>>> since the migration qtest framework lacked any logic for introducing
>>> 'channels' argument.
>> That wasn't clear to me when we merged that. Was that really the case?
> Yeah these look all a bit confusing..
>
> I'm wondering whether do we need the new interface to cover both precopy
> and postcopy, or one would suffice?
>
> Both should share the same interface.  I think it means if we covered the
> channels interface in precopy, then perhaps we don't need to test anywhere
> else, as we got the code paths all covered.
>
> We actually do the same already for all kinds of channels for postcopy,
> where we stick with either tcp/unix but don't cover the rest.
Do we want to add other transports too (vsock, exec, rdma) with the new 
interface ?
I believe we have tests for fd based migration

Regards,
Het Gala

