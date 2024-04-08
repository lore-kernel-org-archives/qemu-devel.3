Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3B9C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 19:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtufE-000663-VO; Mon, 08 Apr 2024 15:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rtufC-00065Z-Uy
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:28:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rtuf9-0003E9-Ev
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:28:18 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 438HnFDh026547;
 Mon, 8 Apr 2024 12:28:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=eChDosC+qFLS
 rNRyHii0WeVG5gXWBLYKomdcZ0Etdds=; b=qnJQvgjGGs9aqT+iyC9uu7m/3rx7
 bfYdIZ+8FbfFiKwXWT4pNLI8RPc80g9Oa2QVGS6G5B6v130q0RGaNIgXKT9jMRmt
 BYvHmlRnu/AuDxPkiM3C07Ahpi2Le2nGBcMT3Q/QvU4lr65JbsAp2Tn7WQ4tYWEl
 O5W9f/pCJoxlOeirIDIRZg/clOI9s4SevKBgZuzUpay8hH7yyQf+VfsFQeqhfj2D
 xtll3mdbCI1D7s2K8Xg2rbh26L3QabwYAAIHVUvVxYFOYhQb8W3ox/0kghujRX9F
 twB0pemOgAFx+hGJz9FaAARCp8HBnEaSPmo2f/qrMbYHtKPPFigAJ5X6Hw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcnabr6w6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Apr 2024 12:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Civeg2EoJMxi13RTSheB3n7Xs8XSiG36oNL3nqhY7DNvJm5nfdAmccPsAG/JSHVpkjQeqa7ipIuWFDpDIDZbQo4eQ5UhptHezM4x3qiDJ+Y8GHYXPqojmSvnnPxdnuMKkJLzzbOe3YDOW+qGOdxKgdezCyUuaeJkje+w+m+6WU08LV12Nbr3C7cVoQxS4PKqhCmR4rohckn9MdmlQOuRr/pdgR/KrJnA/dUrYMnrveRbc3XFchhpmaqDLWq82tS48kW/Benz3qI2lX1mjDHq2QVWsqOFTQrHwuxmZk7fr5h4WsUAq65U/h2STmroUj5MLVZ70EQ0PzsJEiuzVPeTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eChDosC+qFLSrNRyHii0WeVG5gXWBLYKomdcZ0Etdds=;
 b=jvsy16vEbDHEfcnJL0uOPrrIBJd88Tpd0l9Loo2JV8Yix68FYE+npnSM813/1SZfEvZB+NQRORJsvUiEyy3xeh/2b79Vo8OTADlVHfsSL/keaWYqw9UGhZSqkUiItYxCUj770/HVXaKBK7OXVpjoTXmOh1jWD2Cu51ojMxttJ5ME1bLViHuVtcmuPXijog7BUOq5fLWwXXdJB33Xwi+EJQS1SSx6dKM/0Vs2IbEVGC/jwYX6JMLiiYCV3LoittjLc7/yhQPa+OyUSM5WPDSXWOyib0GsRhEmTfRwG+pQFRHEISX7ShwQ0GIoCx0pD205oW9aJjoHw4AlT5CidAwEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eChDosC+qFLSrNRyHii0WeVG5gXWBLYKomdcZ0Etdds=;
 b=Sjhgu102raiPpYYDKBwqwVZfGwhOuucapCMCldLeVNld80CNNpHF5UvLMQZj3S13KAQqalj4M7bq0iC9BGwC5QJDfzRVAH5ITnJRCza0enQU8G7BlPOdzJ+n/5p5uz4IiBWrLZgYuPCr6W+zN7dmtyvbr2G9im6rgHbQcv26WCRGs4tevJmdWy3gVlzwbnxr5HjaZaTWYJkKLtyAuw99ORm54pOndildJc2iJi+GFxhKJrHYFH8aVfU9r7Pn83UYlfW09+rUwNoBCMlCpd/ppQZjeNzKTqGYO8jfLTpGBzkIVSL5k7nb0h7OmFpXmCJarSa3zQ5+sYZhqcTKCQ0sug==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by PH0PR02MB8390.namprd02.prod.outlook.com (2603:10b6:510:108::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 19:28:10 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 19:28:09 +0000
Content-Type: multipart/alternative;
 boundary="------------NQi7Jbm8im8Gz0ioPqGwWdLF"
Message-ID: <92f5245e-0029-43dd-9b01-2a5ecceeebf6@nutanix.com>
Date: Tue, 9 Apr 2024 00:57:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Call args->connect_channels to actually test
 multifd_tcp_channels_none qtest
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com
References: <20240407132125.159528-1-het.gala@nutanix.com>
 <20240407132125.159528-3-het.gala@nutanix.com> <ZhQP45IJfh_8qBVV@x1n>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZhQP45IJfh_8qBVV@x1n>
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|PH0PR02MB8390:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIekKnDAR/xLOmicvGgpCegDMgV6Jl17eqnGyiKd0X6tBbExi7NiNU/cICLHy4YgwiMBRRuEX77YdxCWpLN0AKxD/hsRKetLfG2BWJiBI9gFVIDKkesMHSeWN7VweXkNJs3FoT1THblL+oOOitYfEjWEXJyKnL+NJSTTCozhdypVFfkjSeYl8uuG9M6QtN3btzyJ1i8zTUIVenSqsmjbjSyN2dwbovikF/Q0T+YiYBjXIVTOzvtXQpngcP/An8TgTFRXwDyKIkukxP2V9Y2ggjlK0QTMgv1p1qONenFRksfBUUx+/hyM+cyszI7BwUJvPDDSFrwrIlgmpnQdBPk82JyIZrnP4mvReeN6NyhvzbR/uZ55eiy0dSmjq4M6GMb6Oc+QK6GJHixTZ+fV7vt1OTO2ZSWQTUExlINercGZWn8RatWeNjGww23FzV3X99vPnPe0Ka8KnuzciUr5L56diXRoqrirb3wUJEHPJYUoK6qEIc5StoFuah/RF5mMi3+KZ2hpDq86K6YCHKlSOEpOsFZO6GP1tE+8PsBKYTcAKBA+Pgbxh2a6sPp9tOV3NLTl7AtN56XsR5ii+jVwtOco+Obeain1stG8XRmGC2CKohDxmkkgfaLuPoCUYv9vDY/YKa8IVGw9o9nnsGGFMF38CtPsGn4GvP1hA6MpoofMZgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzBMZXNzVDhtL0ZhTGdiUWlUWlpXTW1QeU0yV1BOcllrTEVMOCtIc0VjOGJh?=
 =?utf-8?B?WjJqd2xrVkIyQWI1ZU9va09QNFBvVnE2d3FWdzkzWHZMbllDY0RNRkowdVZq?=
 =?utf-8?B?VUgyejRUVGNrcUNKWTl4TGtkMS9ia2FKZ3FWcDcxQ0toNW5BdjBuTFVodEFP?=
 =?utf-8?B?NWNjRVRqZVZvVTJYWnVZQVVhTXpDTGhPYUlVMmUzL29GVzRVVEQ3R3hrTkNB?=
 =?utf-8?B?dkhuZTNUWnM4a1JJV1N4SXVuWnhEbG9KV1pDaFcwUkM3UjZyeFIvVnVlZmxz?=
 =?utf-8?B?SlRxNlVzTmFiMlByMktLblh4YW9HeEFDYmhOQmUyM1poaGRLNENLQ3dWZmNE?=
 =?utf-8?B?T1ZvcGE0TC83RmlMVGJLSW9DL2hnaHFoOUpKV0ViVlhEcVQ3U1VFSjRPaW0w?=
 =?utf-8?B?YjYvVEt4cjljdnEwRURQaCsycUdFMk5lbFAvR0RvOGt3NlFtTkhla0pvcGFX?=
 =?utf-8?B?MG1YU0pXUXllWWFCclMyd0dXRWN3K2JzQ1pKMVAwWFlSMUQ1Q1dRZlNEc2F6?=
 =?utf-8?B?UzA5TDU3ZERLa2NBOWphMjA5ejgvVjRJaTQ2OGNsT0JFQ2x6UzFGdVVzMUM1?=
 =?utf-8?B?QmRTMmJaRXhYMzVHZktMd1pwcmJrdm1rdU9ZcGR0VkRxTEJxVlJKbHFZZGdU?=
 =?utf-8?B?UzVDMmZWRDdHWVhEa1hKTGVXcUV2OXFKQnRDTzduU2lkVXd2Y0lmSWNlL1lo?=
 =?utf-8?B?ZnFFWWVCWHBWTk1vaUd0UjF3NUhKQW1pSWpLUVVEcU5EWUhPL3R2VENKVDZQ?=
 =?utf-8?B?L29NQ1JLb2lhQmZmTWdmT2YrWjhEVGpzeDkrdXBrSVVGMXBLNDdLMURDbXJw?=
 =?utf-8?B?Qi9EdDl5ZjkvQWVMemY2K1Q1OVFGbkU0R1RsY3dKWUVKaEc5dnhoSVZydDV4?=
 =?utf-8?B?Ync5a2wxMnBMbUpBK25LbHpVdWdLTkZNSlhqbExUSnRkd2lwcVFNMWQxdFhO?=
 =?utf-8?B?cXJtUVlGdGJsT200M3U1ell2VG1qV3dEM05yWUl4MXFudVl1Q29NUHZOQmxn?=
 =?utf-8?B?Znp1a0tRa0NhSFFNV29iZlVXNDVmRXRHbkRPYnVhWmtIYmRrS2E1NVZKOHoy?=
 =?utf-8?B?RlFEMU1LMjROMTZXNmdZOGhDaklyYVVCcnRvcUFWMmtuRzFCaHRFK2dpTWlj?=
 =?utf-8?B?VndBM2hmcXRQUFVGYytkUkhkenExUnRaZ2hjUncwMmF3RHV3dWoyYW1kbEFJ?=
 =?utf-8?B?S0lGbXFDVHV0NDM3ektWQlVIaW1RT1hvcEJtUTI5WkhyRE1EaTl1aHVhVlpw?=
 =?utf-8?B?Y09QMlhiM1Z4VWZpUDRCZEcxcU5MOGhvQU53YzJ2Mkk4S2ZJQVIybzVFSWlO?=
 =?utf-8?B?U1k0V0Y3Z0x3VnhXbldUbmJpQ0xSdVZwRzh4OGNLNkFZRzVqQzVzT1c2WmYy?=
 =?utf-8?B?MVR5c01qZkFMOFVNMVhJN1RBUk16eXZUVE5sZG1nenBaTlZyWlJqZm4ySUNR?=
 =?utf-8?B?MDZqQ25hU1EwOFoyN2ZhbXhlMVRqczdhemtTRFNFTlc1dzNQQ3JvZGFTYjRj?=
 =?utf-8?B?SGtLdTBxTEsvcmNtbVlTK0lhM3Qzc3pCSmhqSnNKVTVOS244aUI5UWhGKzNR?=
 =?utf-8?B?cHZJdWh5THJBcWoraUpMYmJ6MlRLdHk1RTVlY0hZWDl1UnJFSUtsTUR2dXA3?=
 =?utf-8?B?TWxMSUZmWTVkdVVHQjlTUHZJaDVhbnNHd2h6dGZMdVRkY2kvSk9ibEUreGds?=
 =?utf-8?B?d0FrcU8yTnBhcGx2V25IWVpWYkNGMjBxRWJlaVdrU3N4Q3Y4Ly95SE1uczBy?=
 =?utf-8?B?ejYyTTd5YjM2RmR3RFNGaTRMNUJpUW5HT1Z1ZmRnUVA2MUg1N2RoLzVpWnp3?=
 =?utf-8?B?L3FvZkRqbk5pQmFncGNsZHpVVXpDMkpaNmprSGY2T3ZTVkt2MDgyR1Jhd0V1?=
 =?utf-8?B?Y1BCRHREL1BMOFJldkkzcHViL3M3VHo1NjByT3hTZWg3dGRBN0dNb2NYOEc0?=
 =?utf-8?B?VVhtaEM5akJZVEoxVjlUVFFLTHo5T3Q3dGprU29mMnpJcWtJOVBacDQvcEF2?=
 =?utf-8?B?MnJSOHFTUVJkeFIrQTM3Q1MwdldlY01ESjMrSmcrY3NibzFnZ3cxNVh6Q3Qz?=
 =?utf-8?B?enZSWXRaM2FFNDN0RzkwNWFKTHBpR3ZPU3RpUVdramtaK1BySitGd3BuNVF2?=
 =?utf-8?B?VlNlY0oydWxZdk93YzFrNEhLK0dlRGJtZmt6am00NElpM0U2cTl4bVZlVGgx?=
 =?utf-8?Q?2J6RNa93UK56bIX0N3mHnM4UDTwPyE7kRaYksTwcAI6R?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599b677f-8dbd-40e9-6093-08dc580205dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 19:28:09.4381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9ZKfdKl5AzFPIR4AY4hQUne6Q3fZkE/xbDmrUE4suQGkSs4hayIYixtU1T08v9n8WIns85opvrskfwV7IAo9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8390
X-Proofpoint-ORIG-GUID: rvLFhXAti6ONWFe2FMn9N5ffer08lAR7
X-Proofpoint-GUID: rvLFhXAti6ONWFe2FMn9N5ffer08lAR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

--------------NQi7Jbm8im8Gz0ioPqGwWdLF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/04/24 9:10 pm, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Sun, Apr 07, 2024 at 01:21:25PM +0000, Het Gala wrote:
>> Earlier, without args->connect_channels, multifd_tcp_channels_none would
>> call uri internally even though connect_channels was introduced in
>> function definition. To actually call 'migrate' QAPI with modified syntax,
>> args->connect_channels need to be passed.
>> Double free happens while setting correct migration ports. Fix that.
>>
>> Fixes: (tests/qtest/migration: Add multifd_tcp_plain test using list of
>>          channels instead of uri)
> [1]
>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> ---
>>   tests/qtest/migration-helpers.c | 2 --
>>   tests/qtest/migration-test.c    | 2 +-
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index b2a90469fb..b1d06187ab 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -146,8 +146,6 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
>>                   qdict_put_str(addrdict, "port", addr_port);
>>           }
>>       }
>> -
>> -    qobject_unref(addr);
> Firstly, this doesn't belong to the commit you were pointing at above [1].
> Instead this line is part of:
>
>    tests/qtest/migration: Add migrate_set_ports into migrate_qmp to update migration port value
>
> You may want to split them?
Ack
> Side note: I didn't review carefully on the whole patchset, but I think
> it's preferred to not include any dead code like what you did with
> "tests/qtest/migration: Add migrate_set_ports into migrate_qmp to update
> migration port value".  It'll be better to me if we introduce code that
> will be used already otherwise reviewing such patch is a pain, same to when
> we follow up stuff later like this.
Yes Peter. My intention was to have the code which could actually take the
benefit of using 'channels' for the new QAPI syntax. But somehow I missed
adding connect_channels in the code, despite that the test passed because
it generated connect_uri with the help of listen_uri inside migrate_qmp.
And it generated migrate QMP command using old syntax. Also because it never
entered migrate_set_ports, couldn't catch double free issue while manual
testing as well as while the CI/CD pipeline was run.
> More importantly.. why free?  I'll paste whole thing over, and raise my
> questions.
>
> static void migrate_set_ports(QTestState *to, QList *channel_list)
> {
>      QDict *addr;
>      QListEntry *entry;
>      g_autofree const char *addr_port = NULL;   <--------- this points to sub-field of "addr", if we free "addr", why autofree here?
>
>      addr = migrate_get_connect_qdict(to);
>
>      QLIST_FOREACH_ENTRY(channel_list, entry) {
>          QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
>          QDict *addrdict = qdict_get_qdict(channel, "addr");
>
>          if (qdict_haskey(addrdict, "port") &&
>              qdict_haskey(addr, "port") &&
>              (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
>                  addr_port = qdict_get_str(addr, "port");
>                  qdict_put_str(addrdict, "port", addr_port);  <--------- shouldn't we g_strdup() instead of dropping the below unref()?
>          }
>      }
>
>      qobject_unref(addr);
> }
Yes, I got your point Peter. Will update in the new patch.
>>   }
>>   
>>   bool migrate_watch_for_events(QTestState *who, const char *name,
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 584d7c496f..5d6d8cd634 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -1728,7 +1728,7 @@ static void test_precopy_common(MigrateCommon *args)
>>           goto finish;
>>       }
>>   
>> -    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
>> +    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
>>   
>>       if (args->result != MIG_TEST_SUCCEED) {
>>           bool allow_active = args->result == MIG_TEST_FAIL;
>> -- 
>> 2.22.3
Regards,
Het Gala
--------------NQi7Jbm8im8Gz0ioPqGwWdLF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 08/04/24 9:10 pm, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZhQP45IJfh_8qBVV@x1n">
      <pre class="moz-quote-pre" wrap="">!-------------------------------------------------------------------|
  CAUTION: External Email

|-------------------------------------------------------------------!

On Sun, Apr 07, 2024 at 01:21:25PM +0000, Het Gala wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Earlier, without args-&gt;connect_channels, multifd_tcp_channels_none would
call uri internally even though connect_channels was introduced in
function definition. To actually call 'migrate' QAPI with modified syntax,
args-&gt;connect_channels need to be passed.
Double free happens while setting correct migration ports. Fix that.

Fixes: (tests/qtest/migration: Add multifd_tcp_plain test using list of
        channels instead of uri)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
[1]

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
---
 tests/qtest/migration-helpers.c | 2 --
 tests/qtest/migration-test.c    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b2a90469fb..b1d06187ab 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -146,8 +146,6 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
                 qdict_put_str(addrdict, &quot;port&quot;, addr_port);
         }
     }
-
-    qobject_unref(addr);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Firstly, this doesn't belong to the commit you were pointing at above [1].
Instead this line is part of:

  tests/qtest/migration: Add migrate_set_ports into migrate_qmp to update migration port value

You may want to split them?</pre>
    </blockquote>
    <font face="monospace">Ack</font><span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZhQP45IJfh_8qBVV@x1n">
      <pre class="moz-quote-pre" wrap="">Side note: I didn't review carefully on the whole patchset, but I think
it's preferred to not include any dead code like what you did with
&quot;tests/qtest/migration: Add migrate_set_ports into migrate_qmp to update
migration port value&quot;.  It'll be better to me if we introduce code that
will be used already otherwise reviewing such patch is a pain, same to when
we follow up stuff later like this.</pre>
    </blockquote>
    <font face="monospace">Yes Peter. My intention was to have the code
      which could actually take the<br>
      benefit of using 'channels' for the new QAPI syntax. But somehow I
      missed<br>
      adding connect_channels in the code, despite that the test passed
      because<br>
      it generated connect_uri with the help of listen_uri inside
      migrate_qmp.<br>
      And it generated migrate QMP command using old syntax. Also
      because it never<br>
      entered migrate_set_ports, couldn't catch double free issue while
      manual<br>
      testing as well as while the CI/CD pipeline was run.</font><span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZhQP45IJfh_8qBVV@x1n">
      <pre class="moz-quote-pre" wrap="">More importantly.. why free?  I'll paste whole thing over, and raise my
questions.

static void migrate_set_ports(QTestState *to, QList *channel_list)
{
    QDict *addr;
    QListEntry *entry;
    g_autofree const char *addr_port = NULL;   &lt;--------- this points to sub-field of &quot;addr&quot;, if we free &quot;addr&quot;, why autofree here?

    addr = migrate_get_connect_qdict(to);

    QLIST_FOREACH_ENTRY(channel_list, entry) {
        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
        QDict *addrdict = qdict_get_qdict(channel, &quot;addr&quot;);

        if (qdict_haskey(addrdict, &quot;port&quot;) &amp;&amp;
            qdict_haskey(addr, &quot;port&quot;) &amp;&amp;
            (strcmp(qdict_get_str(addrdict, &quot;port&quot;), &quot;0&quot;) == 0)) {
                addr_port = qdict_get_str(addr, &quot;port&quot;);
                qdict_put_str(addrdict, &quot;port&quot;, addr_port);  &lt;--------- shouldn't we g_strdup() instead of dropping the below unref()?
        }
    }

    qobject_unref(addr);
}</pre>
    </blockquote>
    <font face="monospace">Yes, I got your point Peter. Will update in
      the new patch.</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZhQP45IJfh_8qBVV@x1n">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> }
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 584d7c496f..5d6d8cd634 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1728,7 +1728,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, to, args-&gt;connect_uri, NULL, &quot;{}&quot;);
+    migrate_qmp(from, to, args-&gt;connect_uri, args-&gt;connect_channels, &quot;{}&quot;);
 
     if (args-&gt;result != MIG_TEST_SUCCEED) {
         bool allow_active = args-&gt;result == MIG_TEST_FAIL;
-- 
2.22.3
</pre>
      </blockquote>
    </blockquote>
    <span style="white-space: pre-wrap">
</span><font face="monospace">Regards,<br>
      Het Gala<br>
    </font>
  </body>
</html>

--------------NQi7Jbm8im8Gz0ioPqGwWdLF--

