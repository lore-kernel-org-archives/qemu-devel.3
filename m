Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5325DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmig-00039B-Ol; Mon, 11 Mar 2024 16:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjmid-000372-Mi
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:57:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjmib-00020r-FY
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:57:59 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BBqaOf024444; Mon, 11 Mar 2024 13:57:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=LlEw0XFvqwBC
 2kGuzICc7KGnfoGyLPLRnvAw+U2ev0M=; b=hFRVigxPknXH2P1b+48rpkLllBJG
 eqVz5RkIVNVthtXdR3KfK/f+Ffh/8tZkYovkNHfM6s2eULSrVLF3CYI9kSDZXI6O
 D3EwiflUcbUXYWAt7TNWSGdrvduFnFI0C+xAsKmug0ar1EqEoRG/DkwfA2OKyusx
 A3aqH/mN4ban+NbfIvyqdR2mAk0eYOOsX61Qrs3C6CqbOKIXqyqTl6Mmi6wYfF1h
 tdXcT9HD8eedkCCHg5Zynfb15cRypQ5B/WCrY2BIfOs3phjJccHXHcJx2v4gBa7N
 7jiCuolF0al+6l/bZQDYQQgHgdY4ZEq/QxHQK1jJC7sgU13yHmSXecW8bw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrp6avcrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 13:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgYPzr/9LZh7T31gQQp+LyJOLHr8rOgR/om3KehM3yxg/8BTTSD3wHoIYKwBPcTuf+ETmbnIAjhx37sV9lZ03XIiOgLn3gWwu3rYisth/IGBWNnM+Z3Q23TQSgG051E48vrzAllnYolA9ZUA3JakqA5jAADl9bjOpZZbU0aZ22k8ZKalh5be84dSy6YP52Kw/K3G51IGsA1CRR45pvIi/F5PfFKoZ4ioP8b9vXk/HhvM+xX4pHhgBt97F9THPl5433oAdaB3lGrToclhthO7quzKEYifofqbG04JOQp3HITntcfCufDjXZ70DZMlbaFpV9NBS8sEvHnMVF1BJrYiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlEw0XFvqwBC2kGuzICc7KGnfoGyLPLRnvAw+U2ev0M=;
 b=FBMQJa67STtuv68H2ytx5xb5x6MwM1hn7FGSwwkTt2whdrlLANR6OYrbi2+9S9x5wvbiT5cxs/jrfjXfuaZYwvoXeM2vAjtF1fD4rwWBP3TZapF3JGuD+47Z9+BJfmnTODDifnl+gF1WUw1vW/Y8WrFT24oBJNjK1rpApF7rU2I2uANA8ZCU453aeVlJNFTmgrE4rJSq8eZGnSC1fpWe5GP76FRIYf+6TCyGyG9zEXb2rkQaHE+qWpExK6dMKDUGF7qa9qUlD3cwh25tg2ZcFdHpxvKzUhBu1EndtqIufBoeB1QS+b3AQFWKBRDj4iGL2NGH44st8QtrRNYkK9lNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlEw0XFvqwBC2kGuzICc7KGnfoGyLPLRnvAw+U2ev0M=;
 b=q413kt5ZbpIT3c6kKQPaH/QbsrvGsVljFBZQrWf09AY6OkVY2CkGj68f9c2eji7m8xUWvOYELaGTWsDRbDJXF0UDIQgsrQazBc+POM3fP8YCchjApDkHf2hrCK97ZM38T6yztlk1wCyaLsS+rQFIK3GZDgJ6zb+eJTcekZkIlLnS0X45AFZS93vyJfo7aalvRSCeEwjcBycXsn5Qpwv99ZCtsWwWoKi3fDuZx5RfUIyolaZzYwIGu1XlDOpAxIMSRIMozGsfiICqudpa6g/AWfZLmnhxkHKZKWdekewK0D+C2L7AG0uFhZd4xElaRY0qJJdBhG51dbYrvMZgbiQE0A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO6PR02MB7780.namprd02.prod.outlook.com (2603:10b6:303:ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 20:57:52 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 20:57:51 +0000
Content-Type: multipart/alternative;
 boundary="------------0qL9AIEWg0zhl338gN4JOrIP"
Message-ID: <3193a63f-c127-4673-a6fa-4872eeadd735@nutanix.com>
Date: Tue, 12 Mar 2024 02:27:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] Replace migrate_get_connect_uri inplace of
 migrate_get_socket_address
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <20240308205951.111747-4-het.gala@nutanix.com> <87wmq8my0s.fsf@suse.de>
 <2e9121cd-cbc9-4ac8-a058-815dbbff25dc@nutanix.com> <878r2omr0f.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <878r2omr0f.fsf@suse.de>
X-ClientProxiedBy: MA0PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::14) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CO6PR02MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: d312f842-f667-4367-b846-08dc420dea5f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVJU5Ig/Aa6Gq1UwxTpzFm3EfwknBaMu1j51Ksu0tbAR0Nuia6wEHTmtbemzPO5WdqI1eucxkT7u9Z0Mt+NgU6l6rgBXpw+a+TyX4tE+8WI1Ed7Vlhy60mV2K0maYZF3nf039zHTFbyHmFcDrNk5OlGoJ1G+Wsxy8fQcEKR2Ot6ixBGvllvKGMHaKGB22MYcIgNFc7u6mD7l/Lg/GjYfQ/w+72iQmiPVOsLm3NlLOgtay4smLkF8EA96DKsK91q6rLgZgn/AB5/aHsZHN3xGWZni3MUV3uENHNzx/67AttQsSQX1YBJUNDZLfWIGrJCN6hOlgb0m9+TT/etRhNomjeHvP/2+NjnEDekBqEd9N4gB/ppTeDSTrlxaEFaKoJLx1y1Td2+0x588tOTxmAvZDe6M+dVgT0JeHqPO1l+YBcc09sGRBC2uR7O08kizBtWmNb4Yc4tUITgnsKgwAmkpT3nTGXNSiOJ9RDeWiq0fgIuWQlJTzXfo2LM7lK0UJvzi7I3V/AQpODP+Pdw0pQNCUbfHcJ8Ht9fvCZx8IRweCf02KQg3chXXvGvBSDaEmuJgsX/qDBPzoaQb7HOAIs+ROS0XTqhwKfqwWAK/QYk/14jO1t7Nu8+CMOrFxTUNzAnQsDYJ7e7e6dhmh+VtCxuqXaBauUxUl16CRIPMXKEVOkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dkUThmd1RpRmkvcTA1M0NoL0NkY2ZocXU1ZjY3VmpZWjNWSm5idzU3dGYr?=
 =?utf-8?B?eXVCZFVSSWN1NnJ6NFNQVGZ1eDJjQlJmdzdrNCt1NW5TR25IK1lpYkpBZU1l?=
 =?utf-8?B?aVhXNmZobythR05nVXJzWCtkT1d6b21DMTZpcEJ0am9aZzFJU0YrTjRhcjZk?=
 =?utf-8?B?ZUdZd1NaMGdXVk4vdXowUzRRZUt2U1VRM0kyY0ZaUkJXRTRtK2VwVDB0dXY5?=
 =?utf-8?B?dzdhSjdjemdhclk0Z2htOUswZ002eEkvbk1uR1kxTUxIVEV6UHFZYllZbklt?=
 =?utf-8?B?bjNYdUdnRGl2QVhEVGVBMmE5ei8wTzhiQnpDVUlzYmU2SGprTXpOVUNmTGlI?=
 =?utf-8?B?NmFUZFdQNFFha0tQZ2FralZjL2ZCZ2ZyWDBhQjR3Y25GMlJBZ3dLZEQxN0lQ?=
 =?utf-8?B?ekEyY0VvbisvSFI0SnNSdzh3YkRjay9LZ2VORDFQVDlJend4d1ZMV1RKTEZt?=
 =?utf-8?B?M0V1QWdMTHJGNnpzRVdJZlg5VDJpT2NwaHJUbHd1L01odUhXYVR2QWVLbVZY?=
 =?utf-8?B?Um14ejlYZ1pxMEtBRmJLbERqdlpFRkNQQ2xxd09nQklmM0JjNUNVVk50S3dS?=
 =?utf-8?B?Zmd3VjhUK2FxL2lNUzN1Qm9aSzNUZTlCMCtBZDJaeDBFK3FmNTVhWlQzM1c5?=
 =?utf-8?B?d3RDUm01SWVSbWRwaisxMTFMTGF4b2RGdTBmUVczUVhZSGJpZWxBVnZGOXh3?=
 =?utf-8?B?YmhjaVhpU0ZMZVd4dDROd0ZIOUIxYnZZUVhUek41cDhVMFhLT0ZUczdkR1pt?=
 =?utf-8?B?dE0zME43UjJTUVphSmtHa3MrK3RJNVRDYy8rOFo2cnREZzRDMG4zWDB5bWE5?=
 =?utf-8?B?VWVtV2ZiTDBaRDlBTG1pc2R3dnIwL2tDRnp1aVJrMVhDMHlPYWRzbWVkK2FQ?=
 =?utf-8?B?aHQ5c3JsUWt2TmN0Ym5RN1ZpRVhuWUo0Y3B2d3pTNlNLbVI5T0MvdXI3UFht?=
 =?utf-8?B?eGhCMnpVdDFpMXltelVSRFFWZ09mK1hzYnJHdEkrem5waGFPMHdsdENmd1Qy?=
 =?utf-8?B?akZGellWZEp6WVZPSm5Ya3BuUEMxb1hwVFJmaE1oSzltTVNaK2k2cDVXTThk?=
 =?utf-8?B?MjlaMzJEZVoyK0dlVDFGL0dVNXZGZkVidFBRbEV2TU41NDcwbmRPcFVodWJi?=
 =?utf-8?B?RUg4TVE0SVhzQWhsUzZlazhkZ3V5VHdBRzQ4TFA2b0xtTDFaQWV0L0MxYWxE?=
 =?utf-8?B?ZDcyN2FhQnN4L0tHVXlvMy9sVmlhWkFYT2ROL011SEZkOWFtendXVVFreitJ?=
 =?utf-8?B?ampXMjY0MmRnV2pKRmpqMEF5dHlNbk1kTDFSRG5sUkEyOXEzQTE3TTgvNmo4?=
 =?utf-8?B?SlVDQUlEV1FhUUVpek43VnF2bTA2Z0dKbVMxYW9iTVhScEJJOWQ4dVAxMWxt?=
 =?utf-8?B?c3NheUQ3b0tZd2NLN0pkTUFBakp6RFcxcWdkS1pCbVp4cnJTRWZ2TkN4QkV6?=
 =?utf-8?B?M3EzUDd3TU1SckRTdzh1S3A0Vk94a3A0Wm1Wd2R2T0xnN1NnN2hCTWc0Qk1L?=
 =?utf-8?B?by95QTFjOVpVVVlwR3VaY0F6cXFMUkRLdll6bFM5ZGlIUlNjRlN2Znp5VHpm?=
 =?utf-8?B?N3NmQ3E2bDB2dDhpeVhZRUxMSjRFMGpjL21wb05mckNwT25vWXplSmJsTGF3?=
 =?utf-8?B?TER5d1ExRFFkMkJaTzF2OEVWYWFuVkJkV1RFUzU4S1FkUmE4UzFsaFUvSnlp?=
 =?utf-8?B?cU93SHdMU3NpMVllZmhFUkRMYjBhYklWOW10RFN0SzFLblJxc0RBZkVzMndn?=
 =?utf-8?B?dzA1eDJFK2ZET3ZXaE8wNHN4QU5iRlFZeTZLaDY1SG1MTnR4V0NmVG5CTkxQ?=
 =?utf-8?B?ZGk1NFZtSHhXVHhXY0xYZ0lrMzhEVm90YmpoNEpaS25nUjN5aXM3Q2FIUDVy?=
 =?utf-8?B?Ulc4OHJQUXJUK2ZvSENmYlI5R3hqTVZlekloMFpHdTZWaERIcXV2UTE5anZY?=
 =?utf-8?B?Nmc4WE0vVmxjT0RTT3ZTVXFMOFBza0pIY3ZoenZVNS9FOS9CcDhkOFRvSzVT?=
 =?utf-8?B?OCtoQ1NZL0Z5RDVQalA2ZGx0WG1ZTmFGK2srMWs3a05UVGhQMERENld4dnc3?=
 =?utf-8?B?RnFRS1pjVUlRSkRTUXY3eDF0THcxRTNMUkd2SnZpMEJrbkQ1aWNUYlNkL0Iy?=
 =?utf-8?Q?ySUEYz38lstnjDpUcGTr7Lm0N?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d312f842-f667-4367-b846-08dc420dea5f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 20:57:51.7047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1N4sJKZbwb2ZUN2EmdAVsF58JpK2ySiVXnqHIhSK+sfonJ6mX3uNLpBtdKdQwLwaK1uv8IR5l+x11jUavAzmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7780
X-Proofpoint-ORIG-GUID: SegMiFJTo4UeBMwTImzDovK139fmIGPu
X-Proofpoint-GUID: SegMiFJTo4UeBMwTImzDovK139fmIGPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

--------------0qL9AIEWg0zhl338gN4JOrIP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/03/24 2:21 am, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 11/03/24 11:49 pm, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>   writes:
>>>
>>>>    bool migrate_watch_for_events(QTestState *who, const char *name,
>>>> @@ -130,7 +140,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>>>    
>>>>        g_assert(!qdict_haskey(args, "uri"));
>>>>        if (!uri) {
>>>> -        connect_uri = migrate_get_socket_address(to, "socket-address");
>>>> +        connect_uri = migrate_get_connect_uri(to, "socket-address");
>>> What's the point of the "socket-address" argument here? Seems a bit
>>> nonsensical to me to call: migrate_get_socket_address(..., "socket-address").
>>>
>>> What about we just suppress this throughout the stack and directly call:
>>>
>>>       object = qdict_get(rsp, "socket-address");
>> Fabiano, I didn't get clearly understand your point here. From what I
>> understand,
>> you want to call just
>> 1. migrate_get_connect_uri(to) and migrate_get_connect_qdict(to)
> Yes.
Ack
>> 2. delete migrate_get_socket_address(..., "socket-address") altogether
> No, just the string argument, not the whole function:
>
> static char *migrate_get_socket_address(QTestState *who) <----
> {
>      QDict *rsp;
>      char *result;
>      SocketAddressList *addrs;
>      Visitor *iv = NULL;
>      QObject *object;
>
>      rsp = migrate_query(who);
>      object = qdict_get(rsp, "socket-address"); <-----
>      ...
> }
>
> If the thing is called migrate_get_SOCKET_ADDRESS(), it's obvious that
> the "socket-address" is the parameter we want. We even call
> SocketAddress_to_str, so there's no point in having that argument
> there. We will never call the function with something else in
> 'parameter'.
Ahh, okay. I got your point, and yes, it makes sense. Will just call
migrate_get_socket_address(to) and let the qdict_get() call 
"socket-address" internally.

Regards,

Het Gala

--------------0qL9AIEWg0zhl338gN4JOrIP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/03/24 2:21 am, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:878r2omr0f.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 11/03/24 11:49 pm, Fabiano Rosas wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>  writes:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
  bool migrate_watch_for_events(QTestState *who, const char *name,
@@ -130,7 +140,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
  
      g_assert(!qdict_haskey(args, &quot;uri&quot;));
      if (!uri) {
-        connect_uri = migrate_get_socket_address(to, &quot;socket-address&quot;);
+        connect_uri = migrate_get_connect_uri(to, &quot;socket-address&quot;);
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">What's the point of the &quot;socket-address&quot; argument here? Seems a bit
nonsensical to me to call: migrate_get_socket_address(..., &quot;socket-address&quot;).

What about we just suppress this throughout the stack and directly call:

     object = qdict_get(rsp, &quot;socket-address&quot;);
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Fabiano, I didn't get clearly understand your point here. From what I 
understand,
you want to call just
1. migrate_get_connect_uri(to) and migrate_get_connect_qdict(to)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yes.</pre>
    </blockquote>
    <font face="monospace">Ack</font><br>
    <blockquote type="cite" cite="mid:878r2omr0f.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">2. delete migrate_get_socket_address(..., &quot;socket-address&quot;) altogether 
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
No, just the string argument, not the whole function:

static char *migrate_get_socket_address(QTestState *who) &lt;----
{
    QDict *rsp;
    char *result;
    SocketAddressList *addrs;
    Visitor *iv = NULL;
    QObject *object;

    rsp = migrate_query(who);
    object = qdict_get(rsp, &quot;socket-address&quot;); &lt;-----
    ...
}

If the thing is called migrate_get_SOCKET_ADDRESS(), it's obvious that
the &quot;socket-address&quot; is the parameter we want. We even call
SocketAddress_to_str, so there's no point in having that argument
there. We will never call the function with something else in
'parameter'.</pre>
    </blockquote>
    <font face="monospace">Ahh, okay. I got your point, and yes, it
      makes sense. Will just call <br>
      <span style="white-space: pre-wrap">migrate_get_socket_address(to) and let the </span><span style="white-space: pre-wrap">qdict_get() call 
</span><span style="white-space: pre-wrap">&quot;socket-address&quot; internally.

</span></font>
    <p><font face="monospace"><span style="white-space: pre-wrap">Regards,</span></font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap">Het Gala
</span></font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap"></span></font></p>
  </body>
</html>

--------------0qL9AIEWg0zhl338gN4JOrIP--

