Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C511C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 07:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcghH-0006u9-Ja; Wed, 21 Feb 2024 02:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rcghE-0006tN-Vp
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:07:13 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rcghB-0005Rx-HE
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:07:12 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41KJBaIu026182; Tue, 20 Feb 2024 23:07:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=BrahB9vIs/xD0ekbiruVfXrR7wUMz8wZsw4xW5GNH
 wo=; b=IeF+t4u6MwHSfItYTCdjSJOKDDPnhHHuDat7IrdCpBZmU/eWcrENtCDqE
 bRcr8VoQiSJeS2RRSFVy4E7ztb29lZwAqUmzwcxJaw6goAYC7DArIlQjxe3KiPos
 3tpEEchHOnFnQTH2cgxO9NFvp7dyYNopiUxGKkisZ1aUigR1ieViGMncObBzGSkN
 0TcJU4CmHESEz2Gfbv61gvMUdNvtkDbTM41V8dwQs2wmrV5tCe4Q0ajfwoZ2ITIv
 vhT9Cz/rFG/7UjZe/4uAWK3mlI1wYX3+i18UM261i0MjsNtVcgFoQXhHqm5jVAO+
 KBxdeUx2lM8Ci16vO4w11fV6Yr5lw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wd2181cp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 23:07:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTsl596++z5U5rMgUc9IiRhCjeHFdefxZ3JvSYGRzv4tQY4j1g+q7Z76fg3AAs1jhySR6oTgQOm57zXaDvSlnHLAiL8GItPI4RJ6gIoAyOGH+5OTJWvjZ5tqVx/sdE9U3J9qkJXx2jeiGhJFq9iwHOnZd5b63nJFp1aYg5JgJzMUuzf82gMyVKY2xGTE+vBV6y0sJfjZx3SgbxirQpmiMk9ONeJyyi8HfLeiHpwF4PcR6b/5aZWcLiuX4ZAo2VCUU9YqZYJhvwo7Ibr5+26Cuw9myiEmA8rQScH6tP4qj8Bnd7oz4a+v1SWIzzlLH2QSOiQYqwq7TZljaw0aWRP1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrahB9vIs/xD0ekbiruVfXrR7wUMz8wZsw4xW5GNHwo=;
 b=kB8MH/bLMZqXTRoRrwWIjIJnpR+ysJ22vX5tGUKSIVvZKkkY0mN1H0p7W7UbGW5aFF1GrKJA/BGGA861wb3R5Rwo/JbLTnmKNj+MjwDpE3Yh9U46xlaBCHPTU9AoRQYzmuDjHrgQCnJ94uqHcF2jKEPobK/qv8SevA10HaiBI4L4V/W6t0C66vHRC1yaCj8tAHpgstG6khBLFfFlmntUiWTSLM4wuz/++Jl4NmitdrTHZgOEiYCZsZfZo3AT94Z16aZLmhJH9ynBoT9G0+PgLakhxoNR7TXeuoMqfbZLaiAJTidG1wpcVEPKHc+dIh1mCtSEy5r4AYkxLxPM68SPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrahB9vIs/xD0ekbiruVfXrR7wUMz8wZsw4xW5GNHwo=;
 b=O4/WXo6lLA77fmpoNIcRVHuC54Dbq9pwJgfCMegHzyJoDrHGr519EKNU0PVGPB7ji6YgrIDRv6XCzI9g51DZ1IUXu2G5DKOLbFwmM54ppEVyH8JAXGDpDbcrAtq6uSotem1xIZ3LY3cDmKUeatKxPsf8mN/yuxuzjShmC+ZfelC54UaMBlPcN6G2RvkqX9LZXFqMTKx6q/NQjjNMFi1lEjT3j4P0ZRHmSXr3KMijhJIsur6gqXRGhizfmP4dcTTy0IrFR2kyNF1GUqYWPl2HToOhb7/4GCteeL1Yi56kuR+TZc1U+CEqV056mh0M3jJ0r02dtRIj0xYdbgAv9D0PTg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA1PR02MB8639.namprd02.prod.outlook.com (2603:10b6:806:1fe::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 07:07:04 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 07:07:04 +0000
Message-ID: <b1ce8254-24e8-487e-8da0-d8916f53fcb4@nutanix.com>
Date: Wed, 21 Feb 2024 12:36:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: Misc cleanups to migrate QAPIs
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Fabiano_Fid=C3=AAncio?= <fabiano@fidencio.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20240216195659.189091-1-het.gala@nutanix.com>
 <87edd61ezt.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87edd61ezt.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::15) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA1PR02MB8639:EE_
X-MS-Office365-Filtering-Correlation-Id: af43847d-8d2d-4bf4-4022-08dc32abb51c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiSexyOf0Ec7YIbsR6CbYtHv6EKvALfvaeQzgHQFoblesCvQsmQ17A704GRyg3JnwCaG9D4kIgB04F6S0TCdhO8tTDjb0V+VsDITMABgyncOSKOMH6ydrgmy5nwLAG0LcTuLgj4sgCW5sY9hAxGj9nnDmNynwoJdxfZFs1FTE27bubEinkcGxgz5cc1I1Nv2mf4g267Ocd3LvgXC5p+08DYwY5vopgTSG607vpLm0vKpzxZOPdyrhk8gqJs4TjR0W01UUY+ubAylbYNfRSfh8JDuI5PXCKsQcurmymo4mBGYYL2lMQJoL2+4tmXUt/NcefkFYZmdV2gCMowkJQGJzsG3rUag2qz/3XzkgY8j+uVk/jWeKy73Vpz4uKpL1Hy3Jx3X0AtDLYKxDadcUNbe6aMFJ7s4WCOe5qcFp1UJBnMA+AryOflD89Z+Gt1ZZLEv5Fl9HyALy0hl/Ql9cPKXPZoN2WZK5cYm6ERWy0YNEtuLaxI9ONxigQ+G4HrnDZ4Az9tKx83eAcao+5odPCObq7O2GkViVFTmEsLAPvZdCoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWN5VncrQ1RzQmlwMW9LQUZIemh1bDFmQUxmQ09ocjc4bXB3NTBaZkgyQ2tZ?=
 =?utf-8?B?cGwyckNNWk91NzZRTGs2VloxUDRRNXhjVGZtTWFlVVBUZGNpdC8xdUVlOVFF?=
 =?utf-8?B?U3JxeW8yMVNqTVlQQVhJSzdLaFVvSGg2dnFEbWsrRzNYd0UrWWlqdFFqdVpu?=
 =?utf-8?B?VnFsVDlPWUpyT1BXTHM3bm5FU0wzVmpCVkM2VVhXd2dFVHIrU3J0N0ZtY0Rw?=
 =?utf-8?B?VVY5QUtGaTVleWprb3VCajRhNjZicUpIQW0rYVpLZHFNa2MzdFkxV2ZVMDJj?=
 =?utf-8?B?Vmw5VW5JZ05yWTJiTU9HL3o4T3VkMHhkOTBDUW5nT1YyVXd2QUZSQjFSU3dM?=
 =?utf-8?B?OFF1dy9JNUkvVzlTMXNtVnFaN0R3cXlOWjAwT2tWUWs1U2E3czZJWk45YWpx?=
 =?utf-8?B?aHpNZGhlbVROZzNTNENjVGZvUUQ3OEVYWW11OE9nbFREeE9UWE85QVB2cElj?=
 =?utf-8?B?dXdHcXFRdTVZSjVlOUV4NDR3YTU3TVBwc1NOeFRlQXIwWFFObWpvUEd1bnRi?=
 =?utf-8?B?WWNqK1FQUGFRVEJZV0lTU1QvblZUcGJla3VXeUY4eUlWMFRaZW1NVlBCLzAv?=
 =?utf-8?B?ZWp4NkRrak1YS2sxWERGRGdHZEhIWFQxQ05CbW9tVncxbmJPT0laaUJ3TUNE?=
 =?utf-8?B?dTI2OTc4ZGRwWVBZUkdSOFVKbG9KMmJ6T08xS1F6NnhuQ1NsbVA1dzZnMW9V?=
 =?utf-8?B?YXp2WmlmSU4xNzRDM3J0MTVJWmJkeWtyZ3JSR0tZeVlNeitoaWFkVGlnUDBZ?=
 =?utf-8?B?RTI3RjJ3aFNIY2RFZHNMYUtjM2xNa2JFMGtoTlY2d0lOMWVuYnRJc0YzbTg0?=
 =?utf-8?B?ODhFT3JCejNoTDdCVVhqSlBKWk81Yy9yZlFxT2N3NHdZc0tEanY4ZnhYc1Vt?=
 =?utf-8?B?a0ZDY2pZZWpHOWpoblpBVTZvaXQxV2JnV0F2QmVKRFFqVVdOczByUEM0eXFs?=
 =?utf-8?B?TFcydFI4d0VYRU9Ca3daSU9leVdZb0pVUFN2TmlJNVdOc1VZWmxrNHhlMWl6?=
 =?utf-8?B?VnF4RTA2T2xNSG9Wd2FhM0x6NWRzK0F0b3NwWGU0czdwY2Z4VEV4dHUzQkhz?=
 =?utf-8?B?YjU4S0lQaXdUZDg5YU9kaGszS0t1UDMrVElITFdhVHdKSHVNU0thT2tocmZV?=
 =?utf-8?B?b0MvanRjTDExT2R2RVE2QUpOS1E3VUVCc0w5cU9KMTNVR3l3MEVqS2srWXBF?=
 =?utf-8?B?dksycWVVTXhYN0lwVlB2amVuNnFqdkExQzhNVlBYeXFmbXNuTzVTKzRSNE1R?=
 =?utf-8?B?bWpkckY3bldGZ0JsNVVZbllJbjdMMDFQNUtmT2VJRHZVLzJJOU56WmpMNmdM?=
 =?utf-8?B?Q1B6VlA3d1h0VHM3Mm1sQlE2WjczdjkwK0pyUEVIVEc1MTg5Um1XUE1TZzNF?=
 =?utf-8?B?ZTNlYkxTU0xVWTdlWGpUbE9qaDhvSm5CQ2hHMHJYMytIYmt6WW5lTXB2bEI5?=
 =?utf-8?B?d2xGbTI1TTh0Rnc5U0VkL0NuZ1N1empSNWJDcmdOTFU5VWMxQ3BWSW5CVEZF?=
 =?utf-8?B?OVFxSExlU0RDa2QwT08vRENzUFdnaTVmRExXMCtFR08vZ01KRzBvTGF6bUg5?=
 =?utf-8?B?QjlBSE5GNEtCODNwKzJ6Zlo2QXRkb0V0OUt4eWhpVzJuMzlRMjZlejJEY2xR?=
 =?utf-8?B?T1Yzc2ROb05zaWZPdkRxL1NXQlhaNHM2T3FNa1BWMU91a1ZTNlBQcU9sMGNm?=
 =?utf-8?B?SHhjTFNGeWsxazZUT1IwenNtTGFDdlZQU1JQQzcrYkRZQ08zNDJyT0JCbzBl?=
 =?utf-8?B?RnpNemNQdVluUDZGVW9oakdlVGRPbU50Snp3ZTlqdlB4bnFWOE5QYVJRSVBS?=
 =?utf-8?B?TDZNYVBHNHJsbGZWcEdRWnhmTEM2NG05SWhrMjhrdGhackRJSjhmR1lqY3Fs?=
 =?utf-8?B?T01OVWlmVVU4OEwxdHQ0d21KTjdCOE45VkgydmhOZFhVSHd6dEpZdlU1TW9U?=
 =?utf-8?B?QW42REt4SGl4cjI4RVlucUg2VXVWSFNTUFNDMk8zSXA5TWtUSW51Y2x3cDcr?=
 =?utf-8?B?S2QvZFZVVm5jKzFDUExTWXY0S2FPaEJaSHYrVWNYVDd5c0lvS2NPTmV4S0RS?=
 =?utf-8?B?QXNZNWFSaDdqYXlwUHJjNjkvMVp1ZGZlTi9Da2xldEFqRS82ZTljN0pYTk56?=
 =?utf-8?Q?y9fpzqRLEtFBcj7MNZVSCRKFE?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af43847d-8d2d-4bf4-4022-08dc32abb51c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 07:07:04.0194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+x7kLvmrC97LRRNeKXFRGaT8/73s+tWo5fvGPokgpsVWvqIRN7Ag+FnYZRFwJfqLWV0iFpxi8SSNUoFaQetwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8639
X-Proofpoint-ORIG-GUID: RU_15B-ABjWxBJe51RqMv2n_11KQTRLY
X-Proofpoint-GUID: RU_15B-ABjWxBJe51RqMv2n_11KQTRLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

Sorry Markus, firstly I thought its just regarding qapi documentation so 
migration maintainers might not be needed ? but then I realize the 
commit message fails to specify that

IIRC, you are one of the maintainers for qapi. So, just cc'd to you, but 
you are right, should have done to migration maintainers also.

Have we got the wrong Fabiano here ? Isn't Fabiano Rosas the migration 
maintainer ?

cc'ing to Fabiano Rosas too.

On 21/02/24 12:27 pm, Markus Armbruster wrote:
> You neglected to cc: migration maintainers; I'm doing that for you now.
>
> Peter or Fabiano, please have a look.
>
> Het Gala <het.gala@nutanix.com> writes:
>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   qapi/migration.json | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 5a565d9b8d..5756e650b0 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1728,6 +1728,7 @@
>>   #
>>   # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
>>   # <- { "return": {} }
>> +#
>>   # -> { "execute": "migrate",
>>   #      "arguments": {
>>   #          "channels": [ { "channel-type": "main",
>> @@ -1796,19 +1797,19 @@
>>   #
>>   #     3. The uri format is the same as for -incoming
>>   #
>> -#     5. For now, number of migration streams is restricted to one,
>> +#     4. For now, number of migration streams is restricted to one,
>>   #        i.e number of items in 'channels' list is just 1.
>>   #
>> -#     4. The 'uri' and 'channels' arguments are mutually exclusive;
>> +#     5. The 'uri' and 'channels' arguments are mutually exclusive;
>>   #        exactly one of the two should be present.
>>   #
>>   # Example:
>>   #
>>   # -> { "execute": "migrate-incoming",
>> -#      "arguments": { "uri": "tcp::4446" } }
>> +#      "arguments": { "uri": "tcp:0:4446" } }
>>   # <- { "return": {} }
>>   #
>> -# -> { "execute": "migrate",
>> +# -> { "execute": "migrate-incoming",
>>   #      "arguments": {
>>   #          "channels": [ { "channel-type": "main",
>>   #                          "addr": { "transport": "socket",
>> @@ -1817,7 +1818,7 @@
>>   #                                    "port": "1050" } } ] } }
>>   # <- { "return": {} }
>>   #
>> -# -> { "execute": "migrate",
>> +# -> { "execute": "migrate-incoming",
>>   #      "arguments": {
>>   #          "channels": [ { "channel-type": "main",
>>   #                          "addr": { "transport": "exec",
>> @@ -1825,7 +1826,7 @@
>>   #                                              "/some/sock" ] } } ] } }
>>   # <- { "return": {} }
>>   #
>> -# -> { "execute": "migrate",
>> +# -> { "execute": "migrate-incoming",
>>   #      "arguments": {
>>   #          "channels": [ { "channel-type": "main",
>>   #                          "addr": { "transport": "rdma",

Regards,

Het Gala


