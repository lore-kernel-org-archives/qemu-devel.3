Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE29C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfyaT-00005L-JO; Fri, 01 Mar 2024 03:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rfyaS-0008WQ-1Y
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:49:48 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rfyaP-0005sa-DX
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:49:47 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41TLYXZM023042; Fri, 1 Mar 2024 00:49:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=iXlLZZetGfeqs92D6HvYj9+p0YKMPVMBtDIw4woWF
 uY=; b=ITotZaAQW7axPX92LEvVtMtRDz10fqvPVBZ61YNUFqsTAG+LdpqDeONL+
 tnEQ8kVpU6+uQkS2D67xTAlAoabRwI3W7YJ+GCqu5brRSTQNsl2SH/T5Uf5uQ1ph
 ueX9bZdjPuQmqacrnRJTkZsQa/iUxm0GQV+mVZ2kfVET0xpogkkzjyT3TXj6DNmD
 Zmgj1Zz0alJgcdkYOIPeQTeCd9vwCK2NtTU64VDHGG49rW2L90h3YG4w1zAYtfyv
 5pkY+ieP7cpfriZfbqBLSK5onCIVKgRiDlE4PkwhPt5hznowrilWWjGn9y+cXROa
 gltGXMyyoHW6bJWHtj6+S4w+k54tg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wj9ybc1g9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Mar 2024 00:49:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYDUfza8jtfdUmU+m8oft0qAjka9ZELuZoiP2ufxEGYuAqj2U7cSetbykQz0HWUnM+8RQJz580BsAi917Sfd6AMvh/bTKQkNaFePx4riA/nJL3kqnosLjLwlYI+rzLtty+fLZvjZ3DvBh0bTTduUKrjw7vEQY78HJhuc5zpMJKYGP/GgdZKTXHq/O4ybpd/pwidUHEWWOZf6zV+m3HbsRKiLGfqh54dVaTcVr8VhyTElOy0BtMmf+XxHyAD7eUGFAclMT4z6eJVdGA0fTfGCkNw0Sstr4g0rlIW/Bsyc1fGCn6LoQVOwnYpcLC1HAZZ5d8AvUrE6nUElLBxUHf3UNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXlLZZetGfeqs92D6HvYj9+p0YKMPVMBtDIw4woWFuY=;
 b=dT94vB3qew4wplYC+BzjxKYKq/HwXtFgM5vs6Mf457N9J0hieg/ECQIlhWWapT7HFHXeBy5ozx9Ur3boqOc8V+kwQa0X//1KNOxYZFx4FHeXPTHk2dfN4eVFm99gs1q12rLKdqXtMNe6gU0hEUNgulTD0wcqlyWnz08K2c9OmQRbNa+mOBhCcgWuuGYOyKxo+HGl9H7TC6i5ZjQdIJF3qC5FZTkvcAEDDC3aAotTZGNRdYIFI8OzBsPfyc0SdbrnVco3RYHlyZr7b6BHyXF4BZF2aiVOmkoTytaVSA0wdLZm4ny3QIg9s8kP4EEitEtLujEPqqRGj1wqksnU/IvxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXlLZZetGfeqs92D6HvYj9+p0YKMPVMBtDIw4woWFuY=;
 b=qjV219VmTkk5fwO6g+IWadi5BSUQTEQP1U5K7QrXLMboSE3J8iWWSsak8Ur/8NiZbSl5V5PNxT+rZ0coGjiZjJs/3eHwSF2EQd9f8mW6ZO6snjxZjN5AfscLm42MuFpxofz9iOg4luOZ+LjDl+jRzO929iFN1C+433LArWLJUKNTPvCzQfkbuCBmySLMSLYHqxMy6Wit6fPpNagAt4Q+TH7j/bFIR7j0d9SIs1/zilZZdFBezsFj6kVCp/nX5QgUKjcOaFTa+Ca3o7tQY2n6BB+HxAXf1g9VgOfeKzIUC2Q1AsvEv5EzqxyXlzrggNrQIbBEZJDlpPukQK76gyGe1Q==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by PH0PR02MB8550.namprd02.prod.outlook.com (2603:10b6:510:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 08:49:38 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 08:49:38 +0000
Message-ID: <0bf519e8-3bd2-4074-bc77-29d30a7af110@nutanix.com>
Date: Fri, 1 Mar 2024 14:19:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com> <87zfvr7xdn.fsf@suse.de>
 <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com> <87bk83bcqj.fsf@suse.de>
 <32687fa3-78dc-457b-ae50-854d2c72c922@nutanix.com>
 <894b5da4-0af1-4ca0-b8a7-da288bb20774@nutanix.com> <87o7c0rruo.fsf@suse.de>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87o7c0rruo.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::23) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|PH0PR02MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a5fecf-5d9a-4a24-350f-08dc39cc8749
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLAiwbim/OuwHfXqWGmHv2N//OjnC+xM8V1oS61N7Urkc9GrpnPR/M1DAG6sELiRDL89lxjfmo5SmqM8b1vFzUhmbqGocV+Sxezq70mhNZXwk7a7z1LFP8JYzW7MvNm8/Ra2CLQtPhCjP3yFgOysAPdnnMqe8JXxDHkEaPO3JNzMODR2t5Ra42GVx7KddEEyeA94uzSsAZX7tL89Lz2jMg7FhwYtS1Cirou6earnTmL6QwvSqdC+jZZNFc52x+qU5QiAcXFnjC6bPlAmKG/YJ3CcKq1Vj4wvXUhH6pYjegKlrHI8q2fQ41Qei1V+SeVbkb8rL+zVk9R4VbX43zYLAF1CThJnQl0i5poz3GwDbQEH5xDviVwjcrxBs1f+i7F2CcPfzYhSLVoxCMXemA/vil6e1wzBW+Jf+FxkL6af+wg1kTMHh0O7GiRsOnX7UjyTbxcIugc+dvlWd2o7HJcnkB/hreO7m0auA19RunY+rxhJ7uAy7/lnqAAaBkP0C4vq1i2yGHg2YGT2m36VIlF8XxYKU6dDCtmAhZskPykPeoYqOJ8ZGhM16p0ToYk0+gwxGS4C9vLglxQ5fKJBJRkkTfL9+uBRCQnJ34xm22qXPpvY0Fp2pBHvpo5vQTqVPHWRBorIn7KuIm2533IQA3JixQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXFYNDBPMW1FT2thVmNjbE5JYy9seVgvVjViSktNMXE4NUk2eEg0MG1XRnhI?=
 =?utf-8?B?Umc4MWQ2bVZ5aER3ZlhBd0FNMTg5cE1XNms1WmU3NDlzMFBXREhJaVgyaEd4?=
 =?utf-8?B?TG8rdktHc2ppa1dUbDg3Z3YrRkVpZndiVytJSzg1M1lpVmJxV2p6eGU0L2hU?=
 =?utf-8?B?MFVmcE80R0NFT0dEMFh0V0pTeEE4bHh3MVRRcWUrelRWblJlTE1oYkZCaHJF?=
 =?utf-8?B?d2FOMkttcU02clAxeUNUV21yQWZjN1pVTytFbTIwaDJxelBLME8wTVZ4OWJU?=
 =?utf-8?B?MzluaVdkMmJHL0FTNlBTWFdxVUlLSGxjMFY5VHo5UW44em4xNnhWNkRvSFA1?=
 =?utf-8?B?eldNc1RYdE9FVWVmNy9wWHpYeUVoZjFoSlhFT3dMakhQOFgzdE1QZEFoOENh?=
 =?utf-8?B?akZqWjlGRTBDNXFHNGpGUHVCejZiay9lc0IrbS9XUGdDWWljdit5VXFiWlZE?=
 =?utf-8?B?UnFkNGhnTmpMSUQzWVF4ZjVscENKaDUrSlNqWjBqTGc1MmtvV2l6RTRvOTFU?=
 =?utf-8?B?cFRRTllFQ3JqZ04yZWU3RXNMTUhSOE9ZeEwwT0NuNE1mZGs1UXU1K1QzOXNt?=
 =?utf-8?B?LzNMc09Rbk1PRURkT1hHVXFtOFhLbmFqd25NMTIrWXVpM1o1NHVZZDl5a0th?=
 =?utf-8?B?c2JQai9HV2x3b3VNekV0VFR3dGl0RjI4SDhmaXMwK242VXR2UEhSYjRGTnRl?=
 =?utf-8?B?U2ZMdzZOS01wQ0xUeEY4cU1CdlQrZ0llYWJLaWtBM1dtcWlVSWlqOXhJK0Mw?=
 =?utf-8?B?RzdtcmdaSUY0a2VqbnJSalkzZ3Y3UmtEZThuK3J3QktzRkh3TkJDMExsUTQ4?=
 =?utf-8?B?bE5wL0NwMGNtNVhoMGVDZ2VnZHBheGJ6OG5GMmtoMHZZSnlUM2xIeGpHZzIv?=
 =?utf-8?B?Q0tvdWt6dmUzMWF2a28vbi83dWYwT09jay8yUzhyQXdGOXZ1Z0pNSWtITkti?=
 =?utf-8?B?cVVqYWNmTFdCdWoyY2llNVVvVDVacis0Y1dka0pwK0pLV0NRRFpqY1FpYVBP?=
 =?utf-8?B?Q2o5WVNtdDRnRHZrSnk1OThDZ0I0M3ZldnpTaEZCa2RURzM1elRaekhWY1pB?=
 =?utf-8?B?RXNCVm1tSkN5TktBaUV4ZnRZTXZxS2RpajM4MTBRTUVUUUNGd29DaG8wdHZn?=
 =?utf-8?B?RTZYenUreldzalF2aUR6U3BqcGM2VkkzTnhRWXVqdFByTFFNeGhmRHAwMHly?=
 =?utf-8?B?dlEvbmlkZE5mV25vSS9xWWIzTjREaUpQNlZPemNTZ2JqWldHbU1LNnBLbHhC?=
 =?utf-8?B?Q1Y4eGRKeHFGSkczaUx3dW4zOWREbDVXSXNhL2paM3gwTDZYTVNmOGtZNzRT?=
 =?utf-8?B?QzV4bjhKT3duVzR3cW9qblR0NmsrVStQcFo0UUNuQkZ2Z1EyRXhncmhQUHk2?=
 =?utf-8?B?czNqbFpzcVk3ZisyL3FkTCt2SGVsdlh3WHJodE93M3o2VllxcEFQQysxbTdI?=
 =?utf-8?B?d0hOM1UyVGxYbGdNY0d1Nkd5S2c1YVlHOEFxOHVCREUvZ21Ta1lHckxka3hr?=
 =?utf-8?B?dGxOM2dFV2tlSDNKa2pJZDc4NG1VRkpsSlJPdWxuVHFaTzNVeXVCWXpyTDYz?=
 =?utf-8?B?WC8zK2V4eHdabGpPSGZEcldNdGQ0aTVRSHZzY0RpMFdkSzlmR0hCU3Bpdjhi?=
 =?utf-8?B?cGxiME8yWUt5TnZRcXA1SUNmekRMdHdUT0luSGFHMWxtcEw0WUU1REFidklG?=
 =?utf-8?B?aFAvdm03bHZudEZvZVJxakQ3dVBsaVRtRGxsVnBSSFhUREI4YmF5TlBydHJK?=
 =?utf-8?B?TEVhVzBnWGhob1VPSUhvQllQelFUS2hRaEh2VFAyUjNhanBlVkVMdzZCYlYx?=
 =?utf-8?B?L3I2THhnNDdXNjV3bEpsWU9reWQ4SDBHYlBhcmFLRUxLd2ZXV1lxYVJ2b2dX?=
 =?utf-8?B?MGZrOUNwL09lZXVlZmZaTEowYzBhd3BxcHhwZXZzaGQxSmRhZDdTR09abllv?=
 =?utf-8?B?a2FMYXJFZGtldEpPWlNqYmJHVHhYMFFXMi9PU3g3Ly93VnJBSkE5aVVOdWlO?=
 =?utf-8?B?L0F6YXNZaXJOaHk0c2RPMlVDdmZhdGtLTkpBNWlLQlRrdzVHVE55QUpyeVZT?=
 =?utf-8?B?QzVIc0tIcUdOdzZIZGRMOUN0amtOQmorcEp5cDM2RDFkdXpsUmdxQ0d2WSsx?=
 =?utf-8?Q?+oTOIT4prtttRj0nCweI8dYUf?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a5fecf-5d9a-4a24-350f-08dc39cc8749
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 08:49:38.6538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITMua/8/hg2n1+Um9OQUKz1YmUozaO/guLwMVewX8VK2igBYA9oaxKK566p7cz3U3ndFO71oj+4Ajr1jgZwSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8550
X-Proofpoint-GUID: qHinz8Of3V82186yFsuTUPR05KrrjnR8
X-Proofpoint-ORIG-GUID: qHinz8Of3V82186yFsuTUPR05KrrjnR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_05,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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


On 29/02/24 6:47 am, Fabiano Rosas wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> On 27/02/24 1:04 am, Het Gala wrote:
>>>
>>> On 26/02/24 6:31 pm, Fabiano Rosas wrote:
>>>> Het Gala<het.gala@nutanix.com>  writes:
>>>>
>>>>> On 24/02/24 1:42 am, Fabiano Rosas wrote:
>>>>> this was the same first approach that I attempted. It won't work because
>>>>>
>>>>> The final 'migrate' QAPI with channels string would look like
>>>>>
>>>>> { "execute": "migrate", "arguments": { "channels": "[ { "channel-type":
>>>>> "main", "addr": { "transport": "socket", "type": "inet", "host":
>>>>> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ]" } }
>>>>>
>>>>> instead of
>>>>>
>>>>> { "execute": "migrate", "arguments": { "channels": [ { "channel-type":
>>>>> "main", "addr": { "transport": "socket", "type": "inet", "host":
>>>>> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ] } }
>>>>>
>>>>> It would complain, that channels should be an *array* and not a string.
>>>>>
>>>>> So, that's the reason parsing was required in qtest too.
>>>>>
>>>>> I would be glad to hear if there are any ideas to convert /string ->
>>>>> json object -> add it inside qdict along with uri/ ?
>>>>>
>>>> Isn't this what the various qobject_from_json do? How does it work with
>>>> the existing tests?
>>>>
>>>>       qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
>>>>                                "  'arguments': { "
>>>>                                "      'channels': [ { 'channel-type': 'main',"
>>>>                                "      'addr': { 'transport': 'socket',"
>>>>                                "                'type': 'inet',"
>>>>                                "                'host': '127.0.0.1',"
>>>>                                "                'port': '0' } } ] } }");
>>>>
>>>> We can pass this^ string successfully to QMP somehow...
>>> I think, here in qtest_qmp_assert_success, we actually can pass the
>>> whole QMP command, and it just asserts that return key is present in
>>> the response, though I am not very much familiar with qtest codebase
>>> to verify how swiftly we can convert string into an actual QObject.
>>>
>>> [...]
>>>
>> I tried with qobject_from_json type of utility functions and the error I
>> got was this :
>>
>> migration-test: /rpmbuild/SOURCES/qemu/include/qapi/qmp/qobject.h:126:
>> qobject_type: Assertion `QTYPE_NONE < obj->base.type && obj->base.type <
>> QTYPE__MAX' failed.
>>
>> And I suppose this was the case because, there are only limited types of
>> QTYPE available
>>
>> typedefenumQType{
>> QTYPE_NONE,
>> QTYPE_QNULL,
>> QTYPE_QNUM,
>> QTYPE_QSTRING,
>> QTYPE_QDICT,
>> QTYPE_QLIST,
>> QTYPE_QBOOL,
>> QTYPE__MAX,
>> } QType;
>>
>> And 'channels' is a mixture of QDICT and QLIST and hence it is not able
>> to easily convert from string to json.
>>
>> Thoughts on this ?
> I'm not sure what you tried. This works:
>
>      g_assert(!qdict_haskey(args, "channels"));
>      if (channels) {
>          channels_obj = qobject_from_json(channels, errp);
>          qdict_put_obj(args, "channels", channels_obj);
>      }

Are you sure the above works ?

Sorry I want to get this doubt cleared first, Let's me take a step back 
and just focus on the above part and not focus on port issue for now.

Adding a validation test for uri and channels both used together

migration_test_add("/migration/validate_uri/channels/both_set",
                    test_validate_uri_channels_both_set);
static void test_validate_uri_channels_both_set(void)
{

    QTestState *from, *to;

    MigrateCommon args = {
         .connect_channels = "'channels': [ { 'channel-type': 'main',"
                             "      'addr': { 'transport': 'socket',"
                             "                'type': 'inet',"
                             "                'host': '127.0.0.1',"
                             "                'port': '0' } } ]",
         .listen_uri = "tcp:127.0.0.1:0",
         .result = MIG_TEST_QMP_ERROR,

     };

     if (test_migrate_start(&from, &to, args.listen_uri, &args.start)) {
         return;
     }

     wait_for_serial("src_serial");

     if (args.result == MIG_TEST_QMP_ERROR) {
         migrate_qmp_fail(from, args.connect_uri, args.connect_channels, 
"{}");
     } else {
         migrate_qmp(from, args.connect_uri, args.connect_channels, "{}");
     }

     test_migrate_end(from, to, false);
}

In the migration-helpers.c file, inside migrate_qmp_fail function:

void migrate_qmp_fail(QTestState *who, const char *uri,
                       const char *channels, const char *fmt, ...)
{
     [...]

     Error **errp = NULL;
     QObject *channels_obj = NULL;

     [...]

     g_assert(!qdict_haskey(args, "channels"));
     if (channels) {
         channels_obj = qobject_from_json(channels, errp);
         if (!channels_obj) {
             fprintf(stdout, "Everything is right till here also ?\n");
             goto cleanup;
         }
         qdict_put_obj(args, "channels", channels_obj);
     }

     err = qtest_qmp_assert_failure_ref(
         who, "{ 'execute': 'migrate', 'arguments': %p}", args);

    [...]

cleanup:
     qobject_unref(channels_obj);
}

When I ran the test alone, test passed, but instead of giving output as

{"error": {"class": "GenericError", "desc": "need either 'uri' or 
'channels' argument"}}

It just passed, i.e. channels_obj for me was NULL and hence just ended 
the test. What wrong am I doing here according to you ? Because, IMO if 
qobject_from_json() is not working properly, this approach of passing 
channels as string might not work at all.


Regards,

Het Gala


