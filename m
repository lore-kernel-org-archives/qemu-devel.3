Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E676EC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgUN-0001Ta-39; Tue, 19 Mar 2024 16:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmgUM-0001TQ-0v
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:55:14 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmgUJ-0004io-H4
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:55:13 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42JKP3pk028046; Tue, 19 Mar 2024 13:55:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=0j8U5EUwnjDM
 qAcXojIn3eMF2F4MzL51bzgOzlTkzoI=; b=IWB1FpD2ed2nPfLJiWg+q7FKSLv9
 PXIMq8IGLPsAxoEX2nGNVJxZEK7Kk2faU690mWXrXZrDrmqpznmTIhtoWLbRNXeM
 MSzozedmQRrrprdLvSrQCMZqTPuCobKlYi8i0G+b78IsEFMbGDZhYKkxy6fj+hXy
 zdIz9s+77xcni1fcyPQLc/uf5mUMhheCnpq3PYyvB9KhLV+32fhCb8g8xcfSae7K
 qCvYs6pxQ8xodr8uyKzi7C0L//qelYcVcyFTwqDkMNouaz1AHNr1bL7VdRpxWpnD
 aN32oabU6P3dzSUSBY80m/4kpDtqKwFFTIPUUYygOVGq4zcOEVN0v02PfQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wyhqmr1qy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Mar 2024 13:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3e6AoYMcZdPb1xbgCznQOnvqEs7yC+FwNOjbpVjHMf13vKh3oHJYKmWQfXP4jHtwFwUxTwFb1mLeUMMpy6DgB6ZX/3DsSYhr1+3/clXiRNG1HdT4u4QuC4p30CWkKz5NIs1SJG0SeIe4nUEalmRMuWm0in+oIbaK4HFK1eSLadOpsTm+7X9wIonXJ5U8fAhgqZoJ+c0beXUThQaZCPi5Xy+6oUV89UZjPxSFSKjbJL9TIXhmWLxTb/OoddJhqcu++lpsxZHzi62dEoqA7nis4ZRtUB+UTnD9hjmhSDA+sYgVorc/tFBu3dVU3/9NX8AQL0ELLkARxb4qR2rUPjZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0j8U5EUwnjDMqAcXojIn3eMF2F4MzL51bzgOzlTkzoI=;
 b=h032feIqZjcsPwovzKqrlLAWZAyBuPCl3hLd7W8nFEuaIoNYRu1XinFMulwMZz4bdp16Ro0F2HVmjKkyfL3k1gOwWDiJ51euGUs736go5eBzAFJAkgtNY2L5bd54BBGYqAAFKM0KKMPCs3PNY1yctTuSPk2x84aAeUTPOaoUYuqKzbDVhvEPsQ+XC4ZzsNYjPnegxjkPKCA3MiMGuuRP8wlW73GXPpR3oOBNu4WizyFV0i90u5+USuwQ91hrnSnUIIs/ETKgaoR5DR6BGi1yhLrN5WzEmGJjv6F0S1gt++ChPc1yiH8Ijn3mnJNfdsUwnGX3NmRc84mfudUHCVdaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j8U5EUwnjDMqAcXojIn3eMF2F4MzL51bzgOzlTkzoI=;
 b=eyxVoH9wftJvMFIDvqwbUpb8vkBCme9j/jILsQDzPxrZ0XJIv28sKyU8rauQraDEnBwlP/x0A7x9dLBUFFbcfYwOotGeOX3hG6f6hRPmwYQ8N1IV1o82neMdMWeKMYFxsvixvLfDqdMz3Mfunv02SsMkHWFpmrEpRlk0zssoJ8GI66RGmHYiSTQjku09ZFqT211BQUcrzBpfT+cKHUF3UuSrqOMtY+8QpP8jXCd/+PQaStb8BZThduuBEX8DQ6ARBf3knxv065EBthiAOrTxO8cxDwvzeM9IRlHw7VDQ6fB25d8y1pzPlMIu7mdoCHL5skkTL0tbUTTo/Lcg+axsDA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6998.namprd02.prod.outlook.com (2603:10b6:610:88::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 20:55:06 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 20:55:06 +0000
Content-Type: multipart/alternative;
 boundary="------------2ANTiUlTL0EquwI41QBbKp51"
Message-ID: <0a888d34-4c4b-4943-b7ae-214c47e74bd7@nutanix.com>
Date: Wed, 20 Mar 2024 02:24:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] tests/qtest/migration: Replace
 migrate_get_connect_uri inplace of migrate_get_socket_address
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240312202634.63349-1-het.gala@nutanix.com>
 <20240312202634.63349-4-het.gala@nutanix.com> <871q8b8xeg.fsf@suse.de>
 <c25c8cf7-ea28-4c5f-962a-1fe5abc51870@nutanix.com> <87bk7baamp.fsf@suse.de>
 <32c4cf1d-91d0-48ed-84a9-e21ad7bcc254@nutanix.com> <871q869h8r.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <871q869h8r.fsf@suse.de>
X-ClientProxiedBy: MAXP287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::22) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 10072c32-4d4a-496b-ad3c-08dc4856dad6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hhfp6eC88ejqTuxOwVHQE2BE50+F5QEYTQbYBMPe7cK7BNpRgWvBf5hfCKLhGKRMxPTmVjtpliGgG4gsYqomMu6wmEQCmWiwOzSPolBozpu1kJiH769bGf7ywfU4y6PIJVlDbvhLsgd/UXNbg+JAEEsIGxCwjLnd7HjklsA7FiRIvbWN7u36wxAHxfUrQ3Dt6smMcWRIFplJQuKSFUsVO4/Dj2m8iU/UMQhaqvFYKJKUuGxc88WqDcNJVYYTPRiy262l572bZ88bEpM1AjS59mPVjxIu7HN6gRZ65ohHGmieRvGiIyPdAwKB9x9XlrbFJg/fodMT3BL1uG5npwnJXrBl7PHDrXSoXMGm5YmamOUJR+kQWJFdO9YnZpgrRRwFy+JXM9p13CDu7Ttq8UKef8co8aAPX+rGp62UXUfKUR6+IlA+fyorF0mazQISO49tYBNkvPWYxxsDVxOZbAhckkBYmBligwNJasxOonaMLuqsj+ylFr7s5W8NDntqr0wixIp+QsllDxDN4Ffk3XvtOWSug2pZTMbm5/JhwbHzJKtRSEi7MYk+U1eVCIhY6+TLCQ/3b7g5n+KuJUDef9pH1X8DzpPy146pLM5O45Izx3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V25MQzFWK0lJTXhqVXZCVm1kMDJVOW9QSmZzUnNNcEt0VnBTREJuNEJFd3dS?=
 =?utf-8?B?Nk1aZmFoVXd5MEFUU2hneW5ZUi9LWVBOdy9qcXQ2WDE0ZzhtTlR5ZkNpYzlU?=
 =?utf-8?B?elZEakpWeElQbE9vUjdUNTl6TnRTWU40QUk2dksyM1RNN3hoVXkrTTlqVlkw?=
 =?utf-8?B?RXVSWDVEa2ZHa2VXSm50TXgyUTZwUjd1QkpISWFlK1o1NmYxd3RyVFF5V0xF?=
 =?utf-8?B?dkNnSmNXQ3VCWGF4NzBFaEpwbXBUTFdyVnZGcUFEYTIyZEc5c1MrMTEyc29z?=
 =?utf-8?B?YVlEaDc0aGROMDhTbFVOSWtkMUFMa0R4QXJLMVV6bnA5bDNsWU83c3J5RGhT?=
 =?utf-8?B?QXpiWkxBeHMvZHNMUlVvRVVyTElUYnpSem5TN1VtSUxvVEVPTjZLZUVjcmdK?=
 =?utf-8?B?T3Rrb1UyWlhtaHpEY2xhaEQxRFdJNkJXWGlkZ0FpYmNVYmZGU1hUWmgzT3ZM?=
 =?utf-8?B?ZUZmeEJ2d2pqVElpdFRraE9EeXBaRE1XWnJiVExzT0ZFZTVycGdYM3BYbnU3?=
 =?utf-8?B?RURaUG9jb2Nsd2V1ZDZjRjQyT0V4NS9yVXpBOGxCMFFMSmh5Z3k1OXZsQlJN?=
 =?utf-8?B?YnJZRktvTGJJNDMyMnJUSHk3V05jbXRtYUR1YThZZk9IK3U1aGtzYzk0a2Y3?=
 =?utf-8?B?ZUZTRm96MXl4WGdLV1IxNHN0WEFIQmZ6Vyt2aEFFdzIxY1VHazQzN0dSR3ky?=
 =?utf-8?B?NzdNTXVwNG1GK0tyZG54bzV4YXhJclR3WVJhamFqYzRKekNUbFVxOHlSdmxE?=
 =?utf-8?B?UGEwcmtwRnk5azl4M0VCRWdCWDJaNG1lRkVKK3BueE9TOVdVUzIxMEJxdmFY?=
 =?utf-8?B?VVRqUzlCWERFa3FVTThrbXc1cTRycHFSYjNmbnBuVGJ5Z3BHNXRNZkptTkVs?=
 =?utf-8?B?WUxQN2dKNDkzU2JUamtNL0QvMTBibmJOd1kreW12cmkrY3J1WTFFd1Z4aVFm?=
 =?utf-8?B?YWVBdlM2QkNaTWxvZEtXV2lHWnhiZTM1Z2RYbXhFMlhQQWpRZkljQVFkSy8x?=
 =?utf-8?B?UWVoT1A1dzEyay9uWGk1VmFTblpxZlRpT2o5Y1JxZXJkQk1TQkdPa2RLWFVF?=
 =?utf-8?B?UFlDeGZMM0FlY3BRb3Y2RHFsdzgwazhWN3FnUFdyQzlVd0szamlLamJEMzlO?=
 =?utf-8?B?d2pOdVdGbld0Q1ZNYkMraWdTb3RyTUY3UDlNUTRrbk5HbDlTeEg0R091TG9n?=
 =?utf-8?B?UElpMTdQLzkyWXZpdDNVaGpEdDQ0WVhiZFpGc3ovZFhXOGY3NUs2ZFZUeWlz?=
 =?utf-8?B?RGdnN3F1QytKOXpxL0sva01odFlVQVpraXlKRGZSTjVzaXNlbkZxYnY1Vzhh?=
 =?utf-8?B?NVpRZ01sN1Ztd3M5UHd4RzR1UFljUVJPRS84VGlQQ0FhN1RRTVJJU1lWZGl1?=
 =?utf-8?B?dElZZVZLeTFPYnRPR2h4OVRJdTZ1K0tuUVZuSXpRa2Z3Ry9OUWZaOHZ2UGxr?=
 =?utf-8?B?NzNkRnlYd1NIQUJzaVBBMVVGVGlvSmpiWCtnTGUya1JSUGlhQ2FKQ0RRcy82?=
 =?utf-8?B?VEs4NURiUVRlQVNXRGdNbWZBM3hhSDlmcytjcGtYUkFDaU5yVGI2anJmcHVv?=
 =?utf-8?B?RDRVUDNXem1sRG5TL2tQbktFYk40Z2FYTzlkQzNneEtSYjY2S3NWdTJxVnM3?=
 =?utf-8?B?VXZxTEdUOWZsSUFHWStTanJqSXl1OWxTMThvZkRhTXJneUJZcHp6dktlY2pW?=
 =?utf-8?B?a1h3L1JZSlB4S0hHakFycURnc25VVmt5d2pSYzJHalJlMUFRRW82YzBRT0pP?=
 =?utf-8?B?YkZEZzB4YkhIaFJacHA4V2FYUVVReEMycXVlNjNGTy94NDJUMnZqOVI0dzJE?=
 =?utf-8?B?RjlZdHdaTFArMmV3STFHdUV4bDJSL0l0M05TNEZKZXdBOEJqWG9EVzJOUkdl?=
 =?utf-8?B?SU14Q0ppbndUTXM1ZG85bnpPS2tmYjk3UUUwWDBnWWhwbWhPOUF2aTdiMlZ1?=
 =?utf-8?B?TU1TL1h5VFdMZkxVY1hxZGMvdkc1ZkdQY1VmQTFVZzFpQ2NOOVBMSGZDQy9J?=
 =?utf-8?B?Z1JtQ2g4aXQ4aVNQMGUySTlBdFNjWm1nZkY1cGFZTkJsSXR6SDRnZURZaDY2?=
 =?utf-8?B?bGZJSk1VUnJnM2JxWS9NaTdrb2oxK0lJSUhxMUlJM3pHZnN1Zkt3dWtlb1Q1?=
 =?utf-8?Q?7GxrFTlcTNNVEHlPHuUog9sPs?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10072c32-4d4a-496b-ad3c-08dc4856dad6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 20:55:05.8937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO6RKpxyZuSTRLn/0Ja39Zgh3yk8J69w9ug033Xvkyg0McDDiS3vOTAfz1ZpAHHCCoe67pszerCHlK35etR/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6998
X-Proofpoint-ORIG-GUID: 47bfQMEL2Nwl24vtiAKfktQLZsxgnAxl
X-Proofpoint-GUID: 47bfQMEL2Nwl24vtiAKfktQLZsxgnAxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
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

--------------2ANTiUlTL0EquwI41QBbKp51
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 20/03/24 12:33 am, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 18/03/24 7:46 pm, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>   writes:
>>>
>>>> On 15/03/24 6:28 pm, Fabiano Rosas wrote:
>>>>> Het Gala<het.gala@nutanix.com>    writes:
>>>>>
>>>>>> Refactor migrate_get_socket_address to internally utilize 'socket-address'
>>>>>> parameter, reducing redundancy in the function definition.
>>>>>>
>>>>>> migrate_get_socket_address implicitly converts SocketAddress into str.
>>>>>> Move migrate_get_socket_address inside migrate_get_connect_uri which
>>>>>> should return the uri string instead.
>>>>>>
>>>>>> -static char *
>>>>>> -migrate_get_socket_address(QTestState *who, const char *parameter)
>>>>>> +static SocketAddress *migrate_get_socket_address(QTestState *who)
>>>>>>     {
>>>>>>         QDict *rsp;
>>>>>> -    char *result;
>>>>>>         SocketAddressList *addrs;
>>>>>> +    SocketAddress *addr;
>>>>>>         Visitor *iv = NULL;
>>>>>>         QObject *object;
>>>>>>     
>>>>>>         rsp = migrate_query(who);
>>>>>> -    object = qdict_get(rsp, parameter);
>>>>>> +    object = qdict_get(rsp, "socket-address");
>>>>> Just a heads up, none of what I'm about to say applies to current
>>>>> master.
>>>>>
>>>>> This can return NULL if there is no socket-address, such as with a file
>>>>> migration. Then the visitor code below just barfs. It would be nice if
>>>>> we touched this up eventually.
>>>> Yes. I agree this is not full proof solution and covers for all the cases.
>>>> It would only for 'socket-address'. Could you elaborate on what other than
>>>> socket-address the QObject can have ?
>>> I can just not have the socket-address, AFAICS. We'd just need to not
>>> crash if that's the case.
>> value: {
>>       "status": "setup",
>>       "socket-address": [
>>           {
>>               "port": "46213",
>>               "ipv4": true,
>>               "host": "127.0.0.1",
>>               "type": "inet"
>>           }
>>       ]
>> }
>>
>> Okay, I understood your ask here. This is what gets printed from the QDict.
>> Let me raise a patch to return with a message if the QDict does not have key
>> with 'socket-address'. This would prevent the crash later on.
>>
>> I wanted to know what other than "socket-address" key can he QDict give us
>> because, if that's the case, for other than socket migration, then we can
>> make this function more generic rather than having it as
>> 'migrate_get_socket_address'
> For now, there's nothing else. Let's just ignore when socket-address is
> missing in the reply so we don't break future tests that use a
> non-socket type.
Okay, Done. Can find the build here: 
https://gitlab.com/galahet/Qemu/-/pipelines/1219841944
>>>>> I only noticed this because I was fiddling with the file migration API
>>>>> and this series helped me a lot to test my changes. So thanks for that,
>>>>> Het.
>>>>>
>>>>> Another point is: we really need to encourage people to write tests
>>>>> using the new channels API. I added the FileMigrationArgs with the
>>>>> 'offset' as a required parameter, not even knowing optional parameters
>>>>> were a thing. So it's obviously not enough to write support for the new
>>>>> API if no tests ever touch it.
>>>> Yes, definitely we need more tests with the new channels API to test other
>>>> than just tcp connection. I could give a try for vsock and unix with the
>>>> new QAPI syntax, and add some tests.
>>>>
>>>> I also wanted to bring in attention that, this solution I what i feel is
>>>> also
>>>> not complete. If we are using new channel syntax for migrate_qmp, then the
>>>> same syntax should also be used for migrate_qmp_incoming. But we haven't
>>>> touch that, and it still prints the old syntax. We might need a lot changes
>>>> in design maybe to incorporate that too in new tests totally with the new
>>>> syntax.
>>> Adding migrate_qmp_incoming support should be relatively simple. You had
>>> patches for that in another version, no?
>> No Fabiano, what I meant was, in migration-test.c, change in
>> migrate_incoming_qmp
>> would need to change the callback function and ultimately change all the
>> callback
>> handlers ? In that sense, it would require a big change ?
>> Inside the migrate_incoming_qmp function, adding implementation for
>> channels is
>> same as other migrate_* function.
> You could add the parameter to migrate_incoming_qmp and use NULL when
> calling. The callbacks don't need to be changed. When we add more tests
> then we'd alter the callbacks accordingly.
>
> I might convert the file tests soon, you can leave that part to me if
> you want.
Okay, sure. Will leave those changes to you.
>>>> Another thing that you also noted down while discussing on the patches that
>>>> we should have a standard pattern on how to define the migration tests. Even
>>>> that would be helpful for the users, on how to add new tests, where to add
>>>> new tests in the file, and which test is needed to run if a specific change
>>>> needs to be tested.
>>>>
>>>>>>     
>>>>>>         iv = qobject_input_visitor_new(object);
>>>>>>         visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
>>>>>> +    addr = addrs->value;
>>>>>>         visit_free(iv);
>>>>>>     
>>>>>> -    /* we are only using a single address */
>>>>>>
>>>>>>
Regards,
Het Gala
--------------2ANTiUlTL0EquwI41QBbKp51
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 20/03/24 12:33 am, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:871q869h8r.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 18/03/24 7:46 pm, Fabiano Rosas wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>  writes:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 15/03/24 6:28 pm, Fabiano Rosas wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>   writes:

</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">Refactor migrate_get_socket_address to internally utilize 'socket-address'
parameter, reducing redundancy in the function definition.

migrate_get_socket_address implicitly converts SocketAddress into str.
Move migrate_get_socket_address inside migrate_get_connect_uri which
should return the uri string instead.

-static char *
-migrate_get_socket_address(QTestState *who, const char *parameter)
+static SocketAddress *migrate_get_socket_address(QTestState *who)
   {
       QDict *rsp;
-    char *result;
       SocketAddressList *addrs;
+    SocketAddress *addr;
       Visitor *iv = NULL;
       QObject *object;
   
       rsp = migrate_query(who);
-    object = qdict_get(rsp, parameter);
+    object = qdict_get(rsp, &quot;socket-address&quot;);
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">Just a heads up, none of what I'm about to say applies to current
master.

This can return NULL if there is no socket-address, such as with a file
migration. Then the visitor code below just barfs. It would be nice if
we touched this up eventually.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Yes. I agree this is not full proof solution and covers for all the cases.
It would only for 'socket-address'. Could you elaborate on what other than
socket-address the QObject can have ?
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I can just not have the socket-address, AFAICS. We'd just need to not
crash if that's the case.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
value: {
 &nbsp;&nbsp;&nbsp; &quot;status&quot;: &quot;setup&quot;,
 &nbsp;&nbsp;&nbsp; &quot;socket-address&quot;: [
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;port&quot;: &quot;46213&quot;,
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ipv4&quot;: true,
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;host&quot;: &quot;127.0.0.1&quot;,
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;type&quot;: &quot;inet&quot;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
 &nbsp;&nbsp;&nbsp; ]
}

Okay, I understood your ask here. This is what gets printed from the QDict.
Let me raise a patch to return with a message if the QDict does not have key
with 'socket-address'. This would prevent the crash later on.

I wanted to know what other than &quot;socket-address&quot; key can he QDict give us
because, if that's the case, for other than socket migration, then we can
make this function more generic rather than having it as 
'migrate_get_socket_address'
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
For now, there's nothing else. Let's just ignore when socket-address is
missing in the reply so we don't break future tests that use a
non-socket type.</pre>
    </blockquote>
    <font face="monospace">Okay, Done. Can find the build here:
      <a class="moz-txt-link-freetext" href="https://gitlab.com/galahet/Qemu/-/pipelines/1219841944">https://gitlab.com/galahet/Qemu/-/pipelines/1219841944</a></font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:871q869h8r.fsf@suse.de">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">I only noticed this because I was fiddling with the file migration API
and this series helped me a lot to test my changes. So thanks for that,
Het.

Another point is: we really need to encourage people to write tests
using the new channels API. I added the FileMigrationArgs with the
'offset' as a required parameter, not even knowing optional parameters
were a thing. So it's obviously not enough to write support for the new
API if no tests ever touch it.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Yes, definitely we need more tests with the new channels API to test other
than just tcp connection. I could give a try for vsock and unix with the
new QAPI syntax, and add some tests.

I also wanted to bring in attention that, this solution I what i feel is
also
not complete. If we are using new channel syntax for migrate_qmp, then the
same syntax should also be used for migrate_qmp_incoming. But we haven't
touch that, and it still prints the old syntax. We might need a lot changes
in design maybe to incorporate that too in new tests totally with the new
syntax.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Adding migrate_qmp_incoming support should be relatively simple. You had
patches for that in another version, no?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">No Fabiano, what I meant was, in migration-test.c, change in 
migrate_incoming_qmp
would need to change the callback function and ultimately change all the 
callback
handlers ? In that sense, it would require a big change ?
Inside the migrate_incoming_qmp function, adding implementation for 
channels is
same as other migrate_* function.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
You could add the parameter to migrate_incoming_qmp and use NULL when
calling. The callbacks don't need to be changed. When we add more tests
then we'd alter the callbacks accordingly.

I might convert the file tests soon, you can leave that part to me if
you want.</pre>
    </blockquote>
    <font face="monospace">Okay, sure. Will leave those changes to you.</font><br>
    <blockquote type="cite" cite="mid:871q869h8r.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Another thing that you also noted down while discussing on the patches that
we should have a standard pattern on how to define the migration tests. Even
that would be helpful for the users, on how to add new tests, where to add
new tests in the file, and which test is needed to run if a specific change
needs to be tested.

</pre>
            <blockquote type="cite">
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">   
       iv = qobject_input_visitor_new(object);
       visit_type_SocketAddressList(iv, NULL, &amp;addrs, &amp;error_abort);
+    addr = addrs-&gt;value;
       visit_free(iv);
   
-    /* we are only using a single address */


</pre>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <font face="monospace">Regards,<br>
      Het Gala</font><br>
  </body>
</html>

--------------2ANTiUlTL0EquwI41QBbKp51--

