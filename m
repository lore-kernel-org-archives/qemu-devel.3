Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687CBC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 21:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhyqs-0005F5-1k; Wed, 06 Mar 2024 16:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhyqq-0005EO-My
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 16:31:00 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhyqo-0005wu-2x
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 16:31:00 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 426JRd3W008789; Wed, 6 Mar 2024 13:30:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=P3gKmMaVbSRU
 FkQsbeRNb+3/oKoLC9NNOyQHYBKzRSk=; b=At8NAX/sM6M6I88CMWq5KtqrhMI3
 0dd6VqfifVO1NvnY+ECBx/zC5YQMzdOZ7tUvGuLqKYvdGOxbliEhR7rqTqqepyOo
 cdGZZXR6JebPTTYXG7S3da3R/VhpNMwaq1umUBhdv1XZ/4eQhQRp1iLQB/nYHLJH
 EpGb6BVaQgnQO0jexgLNGgofFiw3mvSZOzAzb6CGlepPfRg7azYFiw2HSiL8VBYV
 P1PQBLvZYOztQ+9w8dcFmfVbftLtiqd3yz6WxiVhy2nBshDArpLN6uk1rMcvfyj0
 7YS2Wx8fE+9G8DW26xCgQorVkDAGsK+X/47VAq82XEBElg4wiIbvm9AhIQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm1avsykh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 13:30:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REV82Q4r3iJvsJn92IxFLod3iljjcNDQ0SC0l5V6moibteI220mJSFVTA7GhyAzd0GV//u6qmzgIRENAe4IZq3ZDQZSxY6kbjtP6GCXnOXxEAJa8d7MNG9/myK/fN7xjsQw8k8LEqBhVTfeUnACMcne1o0NUgI9PiHORo9SmT8eMW23mVGb1UGDX/E9ClHLIqU+6SnQUl+c/vzkXfcOAUF8f1YGzXnasEYX3VeEFC3t70t7ohI1bRD3yEaHr3WfKd6tYcceSuxTUIZCob/Wr4KNbiUV3PhGGiOlfPIM0+kpgpsezPdvCJZ/cy9fgtiFCfKf4utvbrIpICuN5rI4ojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3gKmMaVbSRUFkQsbeRNb+3/oKoLC9NNOyQHYBKzRSk=;
 b=LZtgbmJEJpron6ZO7+cJ1tevIhGNOT6Jr+gFJ87JHBzZt8G7HTmQelc52qc4I7gfCv8jMCzxF9eA9iw5CCakzT+hLP5nHmHcaGJe0O//j7UJjm91+6av49JYeM9VODeaybkgjXNfwFQcMMPIFo8A5jzMf7WWBkuWid+Fj5PvDhyduUPteLcrY7b+/KnRFiACywdcpDfTEP8JJCZJb6tA1olX33SqmCtBXeWctb0MpBXgTkKoERTS4DtLBvAAVnBEWpEJFahDupSKM8/OJOVcqL8OT9APhMJpzTNK0CPgPjbp3BfZHJxusNMoyEHZpTxeUTDTa5Z0uRISckeHDfdCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3gKmMaVbSRUFkQsbeRNb+3/oKoLC9NNOyQHYBKzRSk=;
 b=yRFEgkZyDVUxP3TOvoJD1of0YgJmF+mmzkyyTTi5egrBIGJk27W/7MZ28SfxgKSIX3Ahr+1wx/AoKT/owyjozfGlULX4cLA2zCRyKeb9fjp5W0VbLKCmxFizYqcY7BtJ1dJ1gGEBAls3Cp3UKdZ53sxdBttXDd25sDr9MAC+liKkSnlrBkRwr5/jTzing64sW1p4uxFMosU6mO38y07DrOA2yxO4wzW3j07O3NrVPCdMaq304NlgMD/FXIU4lAkfsDvNAQTBTzlL3pv1Mtzy3N/pdln7GiA3uB726QbAerF9IY7HdH3nO4caMVudgDT8IlNHf5I6V9TPHmLT2oUdYg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ0PR02MB7646.namprd02.prod.outlook.com (2603:10b6:a03:318::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 21:30:51 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 21:30:51 +0000
Content-Type: multipart/alternative;
 boundary="------------haOlHo5rsUxKDM9LFNxjLT3a"
Message-ID: <28018429-e5ab-4dec-b742-99d7daa416b2@nutanix.com>
Date: Thu, 7 Mar 2024 03:00:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] Add migrate_set_ports into migrate_qmp to change
 migration port number
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-5-het.gala@nutanix.com> <87sf13s9yz.fsf@suse.de>
 <0238e330-cb9f-4d72-9ca8-ca7a1b51dddf@nutanix.com> <878r2vs61j.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <878r2vs61j.fsf@suse.de>
X-ClientProxiedBy: MA1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::23) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ0PR02MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: fca667aa-3e78-46f9-7c36-08dc3e24b208
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TB5QJ7pWfZnG3HYzwVub3lc+8KgrduQSbtw563C6ro0IJlKGD9C8IVQ0PT6dkA5T/iow57OTNfa68o8Ws7k+h2Ak5EmpHKX7q1p+etyuMSRNZBYKw0+S60HlzFLAH3jpQSmsbo/iKFcJaJaosD8N3vZhuOCZyVDePEy2hmw8SxjcIs2PD4j6ArQOP6Sy8+WrDSGHVJUKqh4ft8h+rlnZU9anzn1ul8e0eunJ6asrqXwFrE7fLfwOiMagM10k7Q5DYJCrb63p4NzG1hTGV4zK84WUOxhnr6GP3I7d3sN5mdYycHbc0NDcS6SxohVhV0jDH2yF1JmFpYeM2+tJdCvUQkP0xV7Lz+dp+guOuiNJCSAVbb5Vgr3NWBflNF6yWVLwBSD5IkZPHubqTTVfys3OM+MGd4nlOmzV4I586iiOZJDregdcD5kXe0/23dpTQ2Wur5frQAwXooOEDNjiYHrG72KbPomYBgGK9uDgdIS8cssbehOltX9dxpnlM/+3yNSNOhNByk0kG1boPzV08HSfUh2Y5Z/weFiZGD5s/ncCTW5LQqE4lsAz1DCRqgUeLDZB2gG8UuZHrmnouthNWeO3Q+fiFo3ELTv4nMHGBiZNWVM1sPtOuA714Gpdl7I/P9kuyc7fDoQp6vbVwAG1I04IvUr7FrWfOp7RBWz8TAhFAnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0F3U1Q4eEpLaHhTWlZuaTR5WTNmdFRVTmVCcFB2cWY5aGZhWVVDWlQvWkV5?=
 =?utf-8?B?VEJmYVZqTklzVDFaa2JmSVVQVENuM1FTMnNDK05IdnV6S2tWWFluKzFNTkdV?=
 =?utf-8?B?aWNrbjJUSjNtRmE4WmpNd3cvUm5Bd2RTTzVKWVN3cSttckFMc0FnL3hpOXMx?=
 =?utf-8?B?ZU43WDRVR3ZodUcxQjRPTHZCVXdGZjdUT29PNlJSV3F1L3NYYjFTeHpPYzM2?=
 =?utf-8?B?MnFXYW1zbVU4b081QS8wSFdYdmIvNWk1dzNsZWFjaWxwdy9JaWhpcGJVNWRs?=
 =?utf-8?B?QklpOVNwZVlLNU5wVWxwbTUvcGc4MGF2OS8zbkk5NkNaRWVuTzgwSGYxOXpB?=
 =?utf-8?B?ZE1MVnJtR05pdTFrQ0laejJxeGNiTW1MNzI4K3VGTFFZSzZ3UC9hMkNEd1FP?=
 =?utf-8?B?dTRPMjVVbC93aGxmRnFXSzQ3ZHYwelNqelV3ZUROcmluV0RGeTE0cm1TdWpi?=
 =?utf-8?B?Q1VJcG1nL1pFdENxdGp5TWVkZENiUHFhajhvUU8xOWRnbExsdEYybzlBbmtX?=
 =?utf-8?B?Vk96eWJOaFhyUzBTdC8xbmNZQXQ4R1VoVVM4bHlZTnZqNVlEV3Jna2Qzb2FL?=
 =?utf-8?B?SXVEejk0SU5SV1RzekZvRis0UGRqMXdIeHVGWnNXZ1MxanRkZzduMVo5NE40?=
 =?utf-8?B?NEx2Y0hlSFZjaExaaTFrdTNuSytTdC9yRnVHN051dGQwL3dQNVc4QzRqaHQ2?=
 =?utf-8?B?M01RemlpcjJTcHZmSGpFem5xajFHVGN1U09tSkhpVDA3dmJSc21GSGdORm9k?=
 =?utf-8?B?ejl6RkgxcFFHbEVqYW9VWEFaSTY3M0JnOG9XUEN1cHUvZitJeEdVQjkvUzYw?=
 =?utf-8?B?QUt0RTVCV0p4SVd5dGwvN2JrbWx1YTY4VUlHZHplVGNJVkd1U3lOMzIrRWZV?=
 =?utf-8?B?MENqRSt0QXZVY0tNdXVlTlI0c2N6ZloreDhoKy8rK0hIdWxpUFlhZEJaOGNo?=
 =?utf-8?B?OHE4MEFSY010MFdNWDE2NmlUTWRURWQyS1FhclB2L0J6VWh5eWhtekZyUGcx?=
 =?utf-8?B?dzlJaVJBYXVDNktlL01KcGVzN3h0V3hUTkx4b0grWFRvc250TjZWdEFteVpx?=
 =?utf-8?B?eXRPakVGOWdEWDZEYzg5Y25SMEFkclh6eUtYUENpWkcySmMyL29tRXZVYUt0?=
 =?utf-8?B?UWtWRzNja0lUclZEejNyQkNjNXB4ZCtQNXJJYmhmREU1NUxHcGZtVjd6WmQ0?=
 =?utf-8?B?Rk5DMTVBLytyaWY1MkFCZnVpT0M4cmVjYjJHRXUrNzFnNEF1dmdVaUlnMmJJ?=
 =?utf-8?B?ZlZsSENiQWd5SFBGS0Ztekcyb3R6STZxZTc3Q0J5UzdEQTVXOUdSU0M5anFL?=
 =?utf-8?B?MGloaWlaZFJ4QnFVeG5vL2pNd3pDL2EzVlhCSXJYVzlKcHVodWVUdld2aGhP?=
 =?utf-8?B?OXQxQy9BZ3lsNmhwY0I4WFpjendhOEdUVFVsMnp0b1A5M3g4SG5TWkNDQlkz?=
 =?utf-8?B?eWtxQlRzU2c1aVY1YXQwMURuQkk4Wm5nQmsvaGd1TThiMkIrWkRoR3hId24r?=
 =?utf-8?B?YjVqNkVRaWprb1RIbkN6YTlFSDMvcTRnTGt5L2hpRzhkRlFLODhDaDNVUThX?=
 =?utf-8?B?TFlFQnE0K2lCb3ZITGxaV0V6YmVpU1oxaDk0elhkV2RRWmxCRkY1eTBiK0sv?=
 =?utf-8?B?TU9yUkFjZjZ0ZHJ2VHhRL3hsZm9CTjhGRWJrY0NwRzd0L1VLQVdubWhQSnFG?=
 =?utf-8?B?bmNVTXNHVXUvTmlwd3FpdjhkQkd0YXp2YlI3dHB6WFI1ZVlVOThOZ3UvQ3Fa?=
 =?utf-8?B?bmtLZHFENVR5Z1d6SDlRa2xqRjBJZ1JXcUtLZncrb1IxcWtlRDIyQW9KdGRQ?=
 =?utf-8?B?a01NNzlWTnJaZy8weUpNb3JyK0daMlFDQUVUUEZlNXNlNlNacVJlVVFWNEsv?=
 =?utf-8?B?MUhrUEx5dlFzdlBDWHRIMXVNYWxhV213WGFwVTFwSzl0Q1ZsYzEvbUpnTURL?=
 =?utf-8?B?SUlOcW1KZ2w5eUZRN3RKVXZTMEJoRGg0aEtGMU5TUHE4ZUxTTVl6R2w1UDQ3?=
 =?utf-8?B?TXlLQ0ttb094azZjUVhNTVFNYmE5S1VieUJ4NkFzVGU3bzByQ21vc294ZGFw?=
 =?utf-8?B?a0E0ZU1Qb2cyanM3aGJIMEF5TkkzTGdSSmFPcThaSFcydzByZXpRSVFFZjRG?=
 =?utf-8?Q?siZGsUX1il5UJBVx93XofJz1R?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca667aa-3e78-46f9-7c36-08dc3e24b208
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 21:30:50.9698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS+Xw+dnsnCot5IVjFvURiEJcYNdyXRVEixa6Vs04h5aXW2ntwlbSmQZEK034nlmMK1vzSNmT3VMVXM2j6w+4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7646
X-Proofpoint-GUID: 4g6CcBPn4SxDpDLs-A0AtU-nifPgqkqY
X-Proofpoint-ORIG-GUID: 4g6CcBPn4SxDpDLs-A0AtU-nifPgqkqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

--------------haOlHo5rsUxKDM9LFNxjLT3a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/03/24 9:31 pm, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 06/03/24 8:06 pm, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>   writes:
>>>
>>>> Add a migrate_set_ports() function that from each QDict, fills in
>>>> the port in case it was 0 in the test.
>>>> Handle a list of channels so we can add a negative test that
>>>> passes more than one channel.
>>>>
>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>>> ---
>>>>    tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>>>> index 478c1f259b..df4978bf17 100644
>>>> --- a/tests/qtest/migration-helpers.c
>>>> +++ b/tests/qtest/migration-helpers.c
>>>> @@ -17,6 +17,8 @@
>>>>    #include "qapi/qapi-visit-sockets.h"
>>>>    #include "qapi/qobject-input-visitor.h"
>>>>    #include "qapi/error.h"
>>>> +#include "qapi/qmp/qlist.h"
>>>> +
>>> Extra line here. This is unwanted because it sometimes trips git into
>>> thinking there's a conflict here when another patch changes the
>>> surrounding lines.
>> Ack, that makes sense
>>>>    
>>>>    #include "migration-helpers.h"
>>>>    
>>>> @@ -73,6 +75,29 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
>>>>        return result;
>>>>    }
>>>>    
>>>> +static void migrate_set_ports(QTestState *to, QList *channelList)
>>>> +{
>>>> +    g_autofree char *addr = NULL;
>>>> +    g_autofree char *addr_port = NULL;
>>>> +    QListEntry *entry;
>>>> +
>>>> +    addr = migrate_get_socket_address(to, "socket-address");
>>>> +    addr_port = g_strsplit(addr, ":", 3)[2];
>>> Will this always do the right thing when the src/dst use different types
>>> of channels? If there is some kind of mismatch (say one side uses vsock
>>> and the other inet), it's better that this function doesn't touch the
>>> channels dict instead of putting garbage in the port field.
>> Yes you are right. This will fail if there is a mismatch in type of
>> channels.
>>
>> Better idea would be to check if 'port' key is present in both, i.e. in
>> 'addr'
>> as well as 'addrdict' and only then change the port ?
>>
> Yep, either parse the type from string or add a version of
> migrate_get_socket_address that returns a dict. Then check if type
> matches and port exists.

one silly question here, why are we not having tests for exec and rdma 
specifically ?

Another suggestion required: Parsing uri to qdict is easy to implement 
but (little)
messy codewise, and the other hand migrate_get_qdict looks clean, but 
under the hood we would convert it to socketaddress and then call 
SocketAddress_to_qdict. Which one we can prefer more here ?

Regards,

Het Gala

--------------haOlHo5rsUxKDM9LFNxjLT3a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 06/03/24 9:31 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:878r2vs61j.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 06/03/24 8:06 pm, Fabiano Rosas wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>  writes:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Add a migrate_set_ports() function that from each QDict, fills in
the port in case it was 0 in the test.
Handle a list of channels so we can add a negative test that
passes more than one channel.

Signed-off-by: Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas<a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
---
  tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
  1 file changed, 26 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 478c1f259b..df4978bf17 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -17,6 +17,8 @@
  #include &quot;qapi/qapi-visit-sockets.h&quot;
  #include &quot;qapi/qobject-input-visitor.h&quot;
  #include &quot;qapi/error.h&quot;
+#include &quot;qapi/qmp/qlist.h&quot;
+
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Extra line here. This is unwanted because it sometimes trips git into
thinking there's a conflict here when another patch changes the
surrounding lines.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Ack, that makes sense
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">  
  #include &quot;migration-helpers.h&quot;
  
@@ -73,6 +75,29 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
      return result;
  }
  
+static void migrate_set_ports(QTestState *to, QList *channelList)
+{
+    g_autofree char *addr = NULL;
+    g_autofree char *addr_port = NULL;
+    QListEntry *entry;
+
+    addr = migrate_get_socket_address(to, &quot;socket-address&quot;);
+    addr_port = g_strsplit(addr, &quot;:&quot;, 3)[2];
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Will this always do the right thing when the src/dst use different types
of channels? If there is some kind of mismatch (say one side uses vsock
and the other inet), it's better that this function doesn't touch the
channels dict instead of putting garbage in the port field.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Yes you are right. This will fail if there is a mismatch in type of 
channels.

Better idea would be to check if 'port' key is present in both, i.e. in 
'addr'
as well as 'addrdict' and only then change the port ?

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yep, either parse the type from string or add a version of
migrate_get_socket_address that returns a dict. Then check if type
matches and port exists.</pre>
    </blockquote>
    <p><font face="monospace">one silly question here, why are we not
        having tests for exec and rdma specifically ?</font></p>
    <p><font face="monospace">Another suggestion required: Parsing uri
        to qdict is easy to implement but (little)<br>
        messy codewise, and the other hand <span style="white-space: pre-wrap">migrate_get_qdict looks clean, but under the hood
we would convert it to socketaddress and then call SocketAddress_to_qdict. Which one
we can prefer more here ?</span></font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap">Regards,</span></font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap">Het Gala
</span></font></p>
  </body>
</html>

--------------haOlHo5rsUxKDM9LFNxjLT3a--

