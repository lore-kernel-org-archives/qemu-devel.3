Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B0BC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 12:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg2Im-0000l9-3D; Fri, 01 Mar 2024 07:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rg2Ik-0000kz-CT
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 07:47:46 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rg2Ih-0001TD-V4
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 07:47:46 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 421AghfG000542; Fri, 1 Mar 2024 04:47:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=JOTjHavhUVMpvXb5IxRiDBvE4TYbe5UsY9OpWuMfB
 fQ=; b=oHuts5Ms0I0DIngNi3BiDBNWc1w+6fqXwHE5FXQCgUrc5MlrMyMXM+uCN
 TVVHO/H6Couc13AEWK5L3XQMcjJsIknc6+VAJpqNn2e1JtnrSxtFqpZ6xOaqgkRH
 8U8RNouXJQxGTIMutoGOkRIuvjKiBWUxg1BNNubLQrD09DXX+CmmsM4oNK3Vnl8G
 PBhwhbUYFRPVb6KCHvtWOFFe9dGY88HInAzu9Y/UQtaO4E0QZWx9WuwDVp1cqyFv
 KwP2/AhdbY3VFLVoQoWmClch0JXBKZqETy8SHfkzRx3MDH4bS7JgocGhNHe8AiTV
 9n0Mdb2PcHLwSQwt8blCeYDUCZy1A==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wj9yevmcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Mar 2024 04:47:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URZ1HLZ4gAjc6AuN/t9uHKa24j1lRh2b+RAzh0MLp6zuDzi/yr1cJhGmeTqF/r7K4LrZLVloB2EA8fz2z5qpL8yMYpQQTgKLgnbWsg8y81ICiuR/8+VHYmDbGNikP3V8cXCAUo9M74rMS6Z65RcKYs6HgsSwTj3cBqn2G2kHP2of5oBo6k9xAqAefzlJOK5wd4BcXIG6zRXfp8l91OSjb2wnBZHmfZ1zu10Yuepg/VQ8ZaLkhIsvl26DBUTJqpFIoJ/nNZABDF5TvhwTtsMb0AnYXFZ4F2W3s3c7bQwxsvD3be1ngo9kvLS3f1IX3U/WTw2NqkE3W/73+R2Dvk/h6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOTjHavhUVMpvXb5IxRiDBvE4TYbe5UsY9OpWuMfBfQ=;
 b=Ky5awwcuZ5nRmHDK9/NheVGIZlyf7Gktd+tiulEgcEeb6qFiEvlsQuNoywmOQdnLK1wP2Dg7XxrKqP/DUmJK0D6inHj/UMGs+iNrvzqI/MNE4Y9huvulmnE+K/ECJ/wCruU24JFnRzzC4EksoLpC2IN8frqgjyhTBmvZ1Obm02fbBVVWJ9ghJd/a21vvd7D3kXXvrosOik9+y7Q5jHnmAwPnFhLJ1ejdC74bNB2Ho2962l69yZ10O8f0tdZnlv2LmVauXXwuamWulg2C4WGA2jsAU0PMHAXi4fbTASgDPP40VQ9bAuguvBHH7QTkrYaDNLNkZdX+WNB1mdlZTVHYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOTjHavhUVMpvXb5IxRiDBvE4TYbe5UsY9OpWuMfBfQ=;
 b=xRX05sFn0jFmfu5Dy6IyXsSbb8OjNqaOYvNMxJxmRHi67NpjZgVkdSAo/b9qb5BHPKCnKi1lvtaFVSNCUZ9uyNrasrc6cluMYB/f0wDahbPWi/y8t2QGcrO6Vj+cgt7j2uHBlgQy901qpsEEnLdjHb9EH4IXbkqh1UbrepSCG6+/BeJETEsF70AhB5N585QmAHRemCdJkC3xvcO6nj8c/vq3GI3n0VHubr1NOgNs48a4CYjZb4rDaw3VqLr0asUdSNQDU3CRMS4y9eyTNELubIkkXTB+3AYSinQ9Bxnawv4PUcUvKtEkXClsr5JL1+InI7U51yLF64Hq3Eb8dpUOBQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB10155.namprd02.prod.outlook.com (2603:10b6:610:197::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 12:47:37 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 12:47:37 +0000
Message-ID: <584cc08c-7847-401c-aa4a-516427ae1c4d@nutanix.com>
Date: Fri, 1 Mar 2024 18:17:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com> <87zfvr7xdn.fsf@suse.de>
 <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com> <87bk83bcqj.fsf@suse.de>
 <32687fa3-78dc-457b-ae50-854d2c72c922@nutanix.com>
 <894b5da4-0af1-4ca0-b8a7-da288bb20774@nutanix.com> <87o7c0rruo.fsf@suse.de>
 <0bf519e8-3bd2-4074-bc77-29d30a7af110@nutanix.com>
In-Reply-To: <0bf519e8-3bd2-4074-bc77-29d30a7af110@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH3PR02MB10155:EE_
X-MS-Office365-Filtering-Correlation-Id: 254b0512-6b45-4ccf-92be-08dc39edc5fd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCJy4LPx2uK37i0fhtDceShDJo5fSeKG7i5uJVlT1tJVU/ZmoZfY//C5ru2V6hdXiyu+8/stsNOxAWuJdPjU3ynmx4Ixzq4evtN4+8XlKOiEj+jUXJRv0xJqhSh7r0UI9Taga+P0aKMN8BbV/dZ/MF5qW5DvJigUukhB4YuQ39z0o4NUNMBlESX9cqx+9Zd91Rb1H4P3y7wmFTiNZ7E/w/XvWWFrBth0WR47mIfXEDkK999JQcUNp7M9XPNyP8GRtO2XRpQsezfsazAsCQGeCzGmwRRME0G1zOs3HmBdeszEloIOZcJs/T/nARUz1B5LdmqL6/BLSLZWqq4XWC8rQZErnlKnw9cmAklRbjtV2VyBBY8JNhn0ceuAjj807wuibY9oc7TlctyM2TqZ56dCJztT3iN+BkKECrmnkon4/uguabn158wrNUEYHR9C+s8QMkYcUA9MBbHcVP7krMpbfFRx8CyP8XufnFQLaqjoeLi9bSf+fzvr9qrmUAUyJEbKPfuGfkkEZjUlihT6MaqkgjooMMI8/KKwjqLkn/7tSrXBrKDZ9PcTn5k+AzUCfGBI/jhRRSSGgjdMPJb4kYbXq+RzvbnsHGK+OqPwvzcaG7IhuBUb//F750L9NtN4i8wI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REI4eGFTVXRITFl2cFlBa09EcUpsUVRWYjgwcENlT2FTeGFOUitwS0NRMURD?=
 =?utf-8?B?UFpBdEpLdDV3LzRISjAvQjdHWGZLNXBhQVpuWU85ekIzb3NIejE0Vzh6dFVT?=
 =?utf-8?B?OVRiV2JoOTI4ZWtxR1cxamJLRHhUWmVLNDUvYll0U0lEdzRkUmQwWjF1VTI0?=
 =?utf-8?B?MTVQZW9jSGlDZmVpa3J1bTY0ZG1BN3V1eFJBRVpaWm1NakUzUVJqYmVFZDY3?=
 =?utf-8?B?aU1JK0U3MkZuekdUQkJlSVNxZCtWTDRrQTMzaFBIc3JLR2p1THVOVWcvZWlt?=
 =?utf-8?B?amNjaHVQcXNudE15bXVxRjJFYjlhMFJvdUVKWEVVbjlxeGJIT2V6TDRnSlhJ?=
 =?utf-8?B?K05DSU5sdlBUZ1pNbmREcW5HRFZoU2lWTWpTWnV6K0RGSUVmZERXUkVSWDJ5?=
 =?utf-8?B?KzFBajdXNE0wUFFQcDVEaHpDS09FaXVaNE9pOURHek9UWksrTHRpcitUT0Fo?=
 =?utf-8?B?Q0pES2gvOU1JRXlUcE5tTVVNbnF3TWY1N3k5TEtWSW1WanlDZmx3MnR0ZWR0?=
 =?utf-8?B?VnFleVlBVCsralFLSVJsR3B5MmtQSkRXek1lOFNCbWhFOHMzSkxudlV1cHhr?=
 =?utf-8?B?UFRTaTNMZHFhT1JjQnlPYjN2VjEyd1U5bUNPUmdGcENZTGJ4RFY5YitQT2p5?=
 =?utf-8?B?WGxEY3hreUJ1QzBVQXBkb3F0QXFRTmFmaHFyOXRUTVVFUzlWYVJ3RTRTTkFU?=
 =?utf-8?B?U3hEV0x5SGpocjVEbTdxclpGSXJ3TFJBRnBLRm0vbCs3bkRLckh3UTVZclFm?=
 =?utf-8?B?WDd0dVJnd3NwR2NyVDlJOVhONVpRaEg3MDh6MERKSHNrWERkb2dJTTA0L2hW?=
 =?utf-8?B?M0xDdGg2aXlNaXVVSW8zeFZMZlFFWHlmQ28yc1FBTXFrMEpTbVUyOXVpcHRm?=
 =?utf-8?B?dHVtMjAzOXBWbXgyTE9qQkV0STFSb1o0bnJDalJjd2lDdUZ4QkFpWVprOXVi?=
 =?utf-8?B?NUl3OGZaT0JrU21YK1Z6cDI4cjg3TnovUkF3dldDWEt2UDJKMkhHSS9mSlI4?=
 =?utf-8?B?SEJDY1R6RkRzSVEzeXo2dlR1K2NPSEUvZlRseTNxWFY4QzFQUDM4Q09vLzJM?=
 =?utf-8?B?UUtvZjdSZ3ppdUN2NDYvakZTTnAzVFNhc0hFQXZDRVlQeUZ6clhLY2xoRXU5?=
 =?utf-8?B?RUhyKy9hRmpGaVY1TmJpN0pOWlJJUEJsOWxScldJTE5US2RrV1NKUXRhTUlY?=
 =?utf-8?B?SW5LTEVrRC80SXJHYk0rSTNTVFpTTHVUY1V5eWFPd2hPTHQzUHBxQ0lXU3lT?=
 =?utf-8?B?V3Bkbk93SkpXU3c3ejMxTnFTR3Z1cGJJbWdMcjRUT2tMZVI2V0ZqTG5NcEVT?=
 =?utf-8?B?ZVRtV1RibmJvK05NeW13cEZ3QzQwVGkwd2c3b2NCRTR6N2o5dWExZWxzY3hU?=
 =?utf-8?B?dFpUL3RFS05mQ0hKcDYzTGhySEl6azJ1R29Pb212enlLMTY3b200WlN2MUg5?=
 =?utf-8?B?bDFNZUVNMFMrWmlSU1h3K3hPVUJnN1dBUDlnczRoUjZjNStYS25oZWtSc1Zu?=
 =?utf-8?B?SnhwakdIREM3MDlNUXNpMUFmSC9nVTRFR09YTzl4SjZSYU01MjJRSlU0SXRG?=
 =?utf-8?B?ZnI0RTRqMXZHR3U1c1plS0ZLUzFlaFA2aEh4QktlT3VXRzVwTEJ5bktKS2dt?=
 =?utf-8?B?N3NiZlpEVVYwazFBV3NvVnNJM0FKQVk1V3c1ZzRRcWVHbEh3UC84Ymptemh0?=
 =?utf-8?B?VGkxN0lsOUpFRlZGMFVpQi93Qy8yVWxVOTc3dUhlcHFzL01jYnBKcEtxalR1?=
 =?utf-8?B?cEZlZXJUcW1qTk5mNVFKVDhKS3oyWGYzRWJ0aFBXWWNINzdYV2tXY0kwWHVk?=
 =?utf-8?B?U1Q3bi80ODdhYVJtVTY5K0tlNzVQT2JXMGdDRTFMSHNRaWZYelQ4Q2p2cDdI?=
 =?utf-8?B?REJtNFF6TGZGMG9LaHFWamhmNDlkYkFnTzB0UTRoNUZmVS9QSDJiS2J1YUNV?=
 =?utf-8?B?VFZiaGlMM1pseG5WNExUc3R3WWUrc1ZqTmsyd1oyVmRLd3p4YisvcnpwNW5y?=
 =?utf-8?B?RHUxVUZmOXBnQWZyUS9SQTdXVUJmM1hoL2pyNVltczFzL1d3Z1NBamVDY256?=
 =?utf-8?B?QTBnUnRMbXIzdVpzbm0wU2lsdWtxdDNseFFMV0c0dG9nKy9Tb1llOHdQaklR?=
 =?utf-8?Q?rEemKCEBzR44PwX4G03oBD11G?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254b0512-6b45-4ccf-92be-08dc39edc5fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:47:37.2597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBinJPWRcxl9nRMaPbKf6yHGbrGW0siCLwC14IrtYzIuDaH8YR4qAvSpH93FrWGZHyYSknpiOure7Q2NIryU8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10155
X-Proofpoint-ORIG-GUID: GORyDj3A4lnWYhhdrEEi3K5lGZ3CaxE8
X-Proofpoint-GUID: GORyDj3A4lnWYhhdrEEi3K5lGZ3CaxE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_12,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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


On 01/03/24 2:19 pm, Het Gala wrote:
>
> On 29/02/24 6:47 am, Fabiano Rosas wrote:
>> Het Gala <het.gala@nutanix.com> writes:
>>
>>> On 27/02/24 1:04 am, Het Gala wrote:
>>>>
>>>> On 26/02/24 6:31 pm, Fabiano Rosas wrote:
>>>>> Het Gala<het.gala@nutanix.com>  writes:
>>>>>
>>>>>> On 24/02/24 1:42 am, Fabiano Rosas wrote:
>>>>>> this was the same first approach that I attempted. It won't work 
>>>>>> because
>>>>>>
>>>>>> The final 'migrate' QAPI with channels string would look like
>>>>>>
[...]
>> I'm not sure what you tried. This works:
>>
>>      g_assert(!qdict_haskey(args, "channels"));
>>      if (channels) {
>>          channels_obj = qobject_from_json(channels, errp);
>>          qdict_put_obj(args, "channels", channels_obj);
>>      }
>
> Are you sure the above works ?

Sorry, please ignore the below doubt. I understood what silly mistakes I 
was doing. you were right, qobject_from_json() works fine and converts 
string to json object.

Will follow your latest reply and send out the patch really soon. Thank 
you for unblocking me here quickly :)

> [...]

Regards,

Het Gala


