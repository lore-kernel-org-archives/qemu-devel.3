Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACD6C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 13:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruuS2-0001VE-O7; Thu, 11 Apr 2024 09:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruuS0-0001Ut-VJ
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 09:26:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruuRw-0006DX-Ax
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 09:26:48 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43BBUMli000864;
 Thu, 11 Apr 2024 06:26:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=MY+QZ6dN2Xtm
 s0Jtj/gZAwPPHx3euBmtQXC4LIUsdHQ=; b=jPgSzdAbrdrfg62Tp/zf1mBE+wo6
 B2S8zKl2GGBeeHmFvRdAHEmQ7qUPpd5nDPOJc6PJMde+fG4S70/rINl6PXSquvU8
 95yXKsuKZSpmb7yFIaZovsDnRlEV1dWD2Xanv3LR/H3HE2f7sHmYWXgw63sJphXL
 jk9uYFEg4xhCQN2W0ZycVlLktncCNbCUYrCjKnsdJCQanEIcEjBU3Qua4u92xgu/
 6aw5UWyBRKDw5K1r/DNDqEw993XoAMBa3mbX+jwAqctVmhlehXeyEkE6Cvjr4Ghh
 vI2LGWHSWVTgcPLR17KeTQJHRJr+1hDLRn6wN8aOlG0Bhfu8L+V0lwyCLA==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcwua5np0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 06:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnxSBpOLkU9aqm5NN6OBwEtdjcUHMnz8W7v4dUGAnGeeIl8mYD5R6z+gnUd0jvvJXOy52huevVnkf9y8gaAzxpBQQBRkVZbnge0QafQlwS5Uu+EdlHE1r4XpXhHBppG5KdHUhGhNczIAC429iEJMIVPNOQhMTgZNyabKdSJFmNfUYnxW0NXJv9ZtCxB3I8b5SIuhwy5of27zv5lOIJFG9Ku2TiiGBQvzhysKW8/IlaVFWPMzbl7QEWpkCE8YNmqPH0BRoNSYpqIh4RAL8TR9+O23CPdTZ3l4OX5Ckc2boqJ/K63yIBMPdgH2yhRxZ7FRFFhOkzka/6xEzugOwgJcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY+QZ6dN2Xtms0Jtj/gZAwPPHx3euBmtQXC4LIUsdHQ=;
 b=KSlhC7woeXrmQrZpjDgqq2MU1ZKxWKNjPGYCo7BIAgb8kG1Q2ZayehkgSvRtfFH35lBcukBx9TCeq+cSkXiPbV90eIyZbikFzaQzt0s6BGALvI/oGmxBEbLvw6liO1kNgH6dFPFUqiw8u/QIIfKgi/Fz+c/uX2GP2HE+IT/7+nOqqJN8l+2Fn8b5c1U05wx+LzSjkvxPQLTG4Bhh3u2polNGshRq0qIPW3qTPwb6z1exbk+XR/s8/DupHk81J8M0hPiHUbJ39bJ6mVmp1wZpRvoM0yHvhk33TnUrXzK1/Gl/pbwHNqPLQjTXQXRCJUUHV5yQNym5uHiDYpDyRSsoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY+QZ6dN2Xtms0Jtj/gZAwPPHx3euBmtQXC4LIUsdHQ=;
 b=tC7F4SyjHAdMW6DkAIyFkDFGQA8DweyjsJU20Ope3BlxvEGrPESgGcijgORcTNwdQrC0yt9kWjGaLzVM9GoS/qdwhOEVWanfVXDEHvZRd28jiYRiPkrJqx/PfavjzaKyPQMxLQouS6dcjxr9JxMDwTYtEbpxOGLS4leA3SRwv4U8kkkNNMFf5b90hcLE7gG7BYh1S/JFhN+SBWNCW+0rrK7YsjSnj/KnlFC2r8DFP2+YwQg2xUKYud/WWFDxY314yz9yY2K4N4f21RbzxOiqMAFgrXov9xhk95f3NHZ6zswTn+KjFp2urTEnTKI1WbDZB8LrbK/FSlF7ndqTCLY24Q==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CY8PR02MB9452.namprd02.prod.outlook.com (2603:10b6:930:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 13:26:38 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 13:26:38 +0000
Content-Type: multipart/alternative;
 boundary="------------6a18Fa2aUuMB465qNN6GDUuM"
Message-ID: <7a348f82-f17d-484d-98bf-3b3bc993700a@nutanix.com>
Date: Thu, 11 Apr 2024 18:56:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/qtest/migration: Add postcopy migration qtests
 to use 'channels' argument instead of uri
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, prerna.saxena@nutanix.com
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-5-het.gala@nutanix.com> <87v84ptl35.fsf@suse.de>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87v84ptl35.fsf@suse.de>
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CY8PR02MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 142e6f1f-27cf-4ad9-4664-08dc5a2b0467
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muqW+JeXCZzWSOJvI8VgXFPtCvMI55N2CHe2Bb/Ovlq0n0vni5gYg26A79LV6HUoTNpTSQEd1Jq38nIt7t46elS3KTmw0eKbxHmY9wYx52jWPc4/xxiEXU7AZO4aOnSLazqwUPU7hq6wEIx0wEhs4gPEGSTHDNUTCYjWPyJPHit/HOTCLJ0l/oSt0QsaelFvqO9ilypk9X8dQpR1O0Dfnn92vCfwWRb3z6feMfdxXIsuk/LGfaUes7NxtxdnIny6BM66Ot02rmtcABLxfRt9Sf8SrxnL2ZBgBrABkZfE8feQcBCVU8C+ZSaWP6Arq6PlEQHlQ1acJjOx8HT6EaqaEGR86O2gijlxS5NDn4+Y0pXKaW5n+9V8AxrcL8m05J7/Qjt9MyqoddmwXJF1UllxShrhA/g874DSv3gFc5ChWLfI2YrX4fFGn4VjSeZe5suqLjU1x4lDd4kz3DeaIXZGKsQhCHiaDT0Lm/7QyaJtJYOjz6s/++zb5CmuGBrLA4XS38/8W0KXJEkcT94mv2A9XSQMrvYl83eQG0uGvS2gVD1DxTVRBpGNRUadR4UUfLdif2anrZ3ded0LBp4ZJiZwhn9CMADSemN3Bt6pxwVRSKU5g3QqrmP+vXb2Yj4y3E5fleEuEq0wzchuAaONWQ5JYVmAehSlMFsWSk3j/JoYi7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzJObDNnTkh5VXdMb21FUEI5TTFGeGFhV0FjNWNCYUYweU1lMklYTG1WTGlx?=
 =?utf-8?B?dU0zNXR4UFZMaE1neVRPNG1BR3F6ZktVRjBaS3h2NVVqQ1ltVWJtb1R2KzdD?=
 =?utf-8?B?VW5OMUk2ZXhwZ0VKSHdIYno3MGYzWEN1RThVdWxsNUU1UVVrWnEzdEhKWDhm?=
 =?utf-8?B?YW0xeDBTWkwwc1Y4RkxtZUZMUEtoRlE1b0ROWHZlVW15MEZIaVZVYXhSbXA2?=
 =?utf-8?B?SUFUMWRndEdTZ1NLbHdNMXpNajJNVzA2Vk9Zc1lSOXIvcmdjamFBS0ZhaUto?=
 =?utf-8?B?MmY2TTRNaXRzdVNva2UxUEVGYWJnTTBHM09ianhSWE05WDF3K3BrY2h3aENj?=
 =?utf-8?B?YUNQdXdnQkcrNXRGT1dVTWNBbENua2k4WGZkT2ROZWVOamtVVDN6blZSQVVP?=
 =?utf-8?B?OWk1Si9Gcnk4K040WTk3RGtMVnVHa0tvaDlWSjRLQm1ON2dhUW5HNGpGQTgy?=
 =?utf-8?B?d29ydTBoS284NTl0RUtnSTF5dW9MSVVMT280WkUxYWNkbU5WYm9FSE8zTDM5?=
 =?utf-8?B?VS8yMDRoUXRrTW93a0JjVVpIWndidzg0VjBoODJOQWt1cE1qbGVFbWp5Z1lr?=
 =?utf-8?B?c0IwTXBoZUF2b1REejM5cWRWL2NwMHBVZzg0RHVTWEJsL1R1SGRBZi81K3Ix?=
 =?utf-8?B?ZFVpMExYL3h1SUF0b0V3RTB4dXlNV0NGVi93UWNXZlNIbWoxMzdJV2xMQ1Vn?=
 =?utf-8?B?N1ZLT2RPMXlHeURKSThONDU0dlJ2NFZaV1JFQXVodjdrVkZSZ1dlcmFURjBN?=
 =?utf-8?B?MEZ4bEg4VU9QTmgrVFp5ZWlFQ3U3VEVwZEd3UTA1L2grWlpUVmlNVEFEMDZU?=
 =?utf-8?B?S2hMcjNoRGY1US9JcWhLK1BZR0hNbHhab1pxbnZrUXNWcXRiWU12cWxZVnJF?=
 =?utf-8?B?MjRqd2Uwa2ppTWo5WXA4V0ZiT1RjT0pNWmtZUEhndG85V2ozcHpKL1hXWXor?=
 =?utf-8?B?QzFDa29rVisxRGYwNkY1RE1heW5OSy9RK282VnBOOVJ2cHB1VVlscGJwS3Zz?=
 =?utf-8?B?OEhLOVZGMHlPK0xsUWtSckRLUDBYeUNpZmM3RHJKaFBJTTJxbWVoNVg2Q3BI?=
 =?utf-8?B?R1Mybys2T1pWSC95a3VHSUh1YWFGbHdQWXorMFM0dUxheGp1N1kvTDNyT0FL?=
 =?utf-8?B?OTFrZmpDeFQ1OGJSekx0UHQwRlBVc29nVnJIOWJLZnhFYzRiK0dSUTIrMG45?=
 =?utf-8?B?am9ZZll4NFRpUkJ3akcwRDFYelBYdXVuMVdkTnFuZ1BodWEyNlM4U2h4aCtX?=
 =?utf-8?B?bXRwQmN0VmJNSmNBRC84TGVoemI5RWhBMGRqT0FodVpNc2psYXRsQ0lXWU00?=
 =?utf-8?B?OSswT0tBYm5vNXQ2eHZwYk5xdEQyQ1Z3NE1WcnZBTm80VEpsVXB5OFJ2aXJF?=
 =?utf-8?B?dFRkQ3hsdlVOVG9tUnFrT243cHJLTjlaV1I5b2tPME9RTS9NK1BSYjRwdUVC?=
 =?utf-8?B?RXY5UVQrT3BCb0FCckg5V3N3MU1HQnFydVJkdUVka0RyMGFCNGZoZTgvdURi?=
 =?utf-8?B?MHBEZmpoTjZSQ1VoYVh6K3VocUFiNmxzeTlMcGQ4RjQ0Q1NzSXByVDBTSm9J?=
 =?utf-8?B?SHIvSVk1dHVsVkZRNEI4NVZ1emtJYTRSbWFnaTYxV01ESUlMVkpBdE5oWERp?=
 =?utf-8?B?cythRHRTbHRJMXl0VGVLeHJaZU5XV3ZZcEE5L2hpRWJaNFpvYUdZT1QrNjBT?=
 =?utf-8?B?dGpYMnBzUGpzaENVam91LzdBSjUyTFJsVnI5N0lhWllUb0pFTkdRb3JORDlr?=
 =?utf-8?B?enl1R3A4M0xmRU9BTjFoTmVnSURLOTVEZVFNNzhwRDhUSGVsb3ZBdzlOc1VW?=
 =?utf-8?B?V3g4Y1gveGRwSW9QVmtVemZ5NWdBTGxWL3J1SDZiRUJIOURYdkVTdk1YRGl0?=
 =?utf-8?B?bVQ1VU1jZzhCWDFXeE5WKzJkaUQya1hGUWUrOVZ2eFpvUW9DeitxR1ZETUQ1?=
 =?utf-8?B?YU9KUExVZTAraXZJSnRZVXZ6L21OUHhWRHZYZE54TXNCRFdBNHNXN2xLUkp3?=
 =?utf-8?B?VktMQ3ZtNkdJNnNhWGhZajZvbUpIcVVTcStWRFFwZVNGbWl0Nlc1Vjh0ZCtp?=
 =?utf-8?B?bU82Umw0R3V0djIvNWt6ZnBSVVFYR2lIbkRWMUkwWURLb2c2dnI5MFN2MmEy?=
 =?utf-8?Q?tESx//3zvyF1Q0Y2s8C3h8Ph0?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142e6f1f-27cf-4ad9-4664-08dc5a2b0467
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 13:26:38.6779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qt9nsa2Sb36o2QB1isUZqLuCNlGLnyXhoNZgeBoDulYQVa44iaUnHJTWblM6JZhvhAL9XUGw5lGGfgxcdCEUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9452
X-Proofpoint-ORIG-GUID: -oXngIg1h26WDv17kRp0U8LEnQbMmCli
X-Proofpoint-GUID: -oXngIg1h26WDv17kRp0U8LEnQbMmCli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

--------------6a18Fa2aUuMB465qNN6GDUuM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/04/24 6:45 pm, Fabiano Rosas wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Add qtests to perform postcopy live migration by having list of
>> 'channels' argument as the starting point instead of uri string.
>> (Note: length of the list is restricted to 1 for now)
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> ---
>>   tests/qtest/migration-test.c | 38 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index fa8a860811..599018baa0 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -1296,13 +1296,17 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>>       migrate_ensure_non_converge(from);
>>   
>>       migrate_prepare_for_dirty_mem(from);
>> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>> +    if (args->connect_channels) {
>> +        migrate_incoming_qmp(to, NULL, args->connect_channels, "{}");
>> +    } else {
>> +        migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>> +    }
>  From an interface perspective it's a bit unexpected to need this
> conditional when the migrate_qmp below doesn't need it.
I think, migrate_qmp has an unique advantage here. Please correct me If 
my understanding
is not correct.
1. test_migrate_start starts the qemu cmd line with either --incoming 
tcp:127.0.0.1:0
    or "defer". If tcp uri is provided, then migrate_incoming_qmp is not 
necessary
2. If "defer" is passed, then only migrate_incoming_qmp is required with 
tcp uri string
3. migrate_qmp can get the uri anyway either from
        test_migrate_start -> defer + migrate_incoming_qmp -> 
tcp:127.0.0.1:0
test_migrate_start -> tcp:127.0.0.1:0
    with the help of migrate_get_connect_uri() with the correct 
migration port.
    Even if we always pass NULL, we are okay, But this is just for tcp 
transport, and
    not unix

We can't have the unique situation for migrate_incoming_qmp, hence 
avoiding conditional
earlier seemed to be necessary for me. But, with the hack suggested by 
you in previous
patch, will prevent us from using conditional if else
>>   
>>       /* Wait for the first serial output from the source */
>>       wait_for_serial("src_serial");
>>       wait_for_suspend(from, &src_state);
>>   
>> -    migrate_qmp(from, to, NULL, NULL, "{}");
>> +    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
>>   
>>       migrate_wait_for_dirty_mem(from, to);
>>   
>> @@ -1355,6 +1359,20 @@ static void test_postcopy(void)
>>       test_postcopy_common(&args);
>>   }
>>   
>> +static void test_postcopy_channels(void)
>> +{
>> +    MigrateCommon args = {
>> +        .listen_uri = "defer",
>> +        .connect_channels = "[ { 'channel-type': 'main',"
>> +                            "    'addr': { 'transport': 'socket',"
>> +                            "              'type': 'inet',"
>> +                            "              'host': '127.0.0.1',"
>> +                            "              'port': '0' } } ]",
>> +    };
>> +
>> +    test_postcopy_common(&args);
>> +}
>> +
>>   static void test_postcopy_suspend(void)
>>   {
>>       MigrateCommon args = {
>> @@ -1555,6 +1573,18 @@ static void test_postcopy_recovery(void)
>>       test_postcopy_recovery_common(&args);
>>   }
>>   
>> +static void test_postcopy_recovery_channels(void)
>> +{
>> +    MigrateCommon args = {
>> +        .connect_channels = "[ { 'channel-type': 'main',"
>> +                            "    'addr': { 'transport': 'socket',"
>> +                            "              'type': 'inet',"
>> +                            "              'host': '127.0.0.1',"
>> +                            "              'port': '0' } } ]",
>> +    };
>> +
>> +    test_postcopy_recovery_common(&args);
>> +}
>>   static void test_postcopy_recovery_compress(void)
>>   {
>>       MigrateCommon args = {
>> @@ -3585,8 +3615,12 @@ int main(int argc, char **argv)
>>   
>>       if (has_uffd) {
>>           migration_test_add("/migration/postcopy/plain", test_postcopy);
>> +        migration_test_add("/migration/postcopy/channels/plain",
>> +                           test_postcopy_channels);
>>           migration_test_add("/migration/postcopy/recovery/plain",
>>                              test_postcopy_recovery);
>> +        migration_test_add("/migration/postcopy/recovery/channels/plain",
>> +                           test_postcopy_recovery_channels);
>>           migration_test_add("/migration/postcopy/preempt/plain",
>>                              test_postcopy_preempt);
>>           migration_test_add("/migration/postcopy/preempt/recovery/plain",
Regards,
Het Gala
--------------6a18Fa2aUuMB465qNN6GDUuM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/04/24 6:45 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87v84ptl35.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">!-------------------------------------------------------------------|
  CAUTION: External Email

|-------------------------------------------------------------------!

Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Add qtests to perform postcopy live migration by having list of
'channels' argument as the starting point instead of uri string.
(Note: length of the list is restricted to 1 for now)

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
---
 tests/qtest/migration-test.c | 38 ++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index fa8a860811..599018baa0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1296,13 +1296,17 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     migrate_ensure_non_converge(from);
 
     migrate_prepare_for_dirty_mem(from);
-    migrate_incoming_qmp(to, &quot;tcp:127.0.0.1:0&quot;, NULL, &quot;{}&quot;);
+    if (args-&gt;connect_channels) {
+        migrate_incoming_qmp(to, NULL, args-&gt;connect_channels, &quot;{}&quot;);
+    } else {
+        migrate_incoming_qmp(to, &quot;tcp:127.0.0.1:0&quot;, NULL, &quot;{}&quot;);
+    }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
From an interface perspective it's a bit unexpected to need this
conditional when the migrate_qmp below doesn't need it.</pre>
    </blockquote>
    <font face="monospace">I think, migrate_qmp has an unique advantage
      here. Please correct me If my understanding<br>
      is not correct.<br>
      1. test_migrate_start starts the qemu cmd line with either
      --incoming tcp:127.0.0.1:0<br>
      &nbsp;&nbsp; or &quot;defer&quot;. If tcp uri is provided, then migrate_incoming_qmp
      is not necessary<br>
      2. If &quot;defer&quot; is passed, then only migrate_incoming_qmp is
      required with tcp uri string<br>
      3. migrate_qmp can get the uri anyway either from<br>
    </font><font face="monospace">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_migrate_start -&gt; defer
      + migrate_incoming_qmp -&gt; </font><font face="monospace">tcp:127.0.0.1:0<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font><font face="monospace">test_migrate_start -&gt; </font><font face="monospace">tcp:127.0.0.1:0<br>
      &nbsp;&nbsp; with the help of migrate_get_connect_uri() with the correct
      migration port.<br>
      &nbsp;&nbsp; Even if we always pass NULL, we are okay, But this is just for
      tcp transport, and<br>
      &nbsp;&nbsp; not unix<br>
      <br>
      We can't have the unique situation for migrate_incoming_qmp, hence
      avoiding conditional<br>
      earlier seemed to be necessary for me. But, with the hack
      suggested by you in previous<br>
      patch, will prevent us from using conditional if else</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87v84ptl35.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
     /* Wait for the first serial output from the source */
     wait_for_serial(&quot;src_serial&quot;);
     wait_for_suspend(from, &amp;src_state);
 
-    migrate_qmp(from, to, NULL, NULL, &quot;{}&quot;);
+    migrate_qmp(from, to, args-&gt;connect_uri, args-&gt;connect_channels, &quot;{}&quot;);
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1355,6 +1359,20 @@ static void test_postcopy(void)
     test_postcopy_common(&amp;args);
 }
 
+static void test_postcopy_channels(void)
+{
+    MigrateCommon args = {
+        .listen_uri = &quot;defer&quot;,
+        .connect_channels = &quot;[ { 'channel-type': 'main',&quot;
+                            &quot;    'addr': { 'transport': 'socket',&quot;
+                            &quot;              'type': 'inet',&quot;
+                            &quot;              'host': '127.0.0.1',&quot;
+                            &quot;              'port': '0' } } ]&quot;,
+    };
+
+    test_postcopy_common(&amp;args);
+}
+
 static void test_postcopy_suspend(void)
 {
     MigrateCommon args = {
@@ -1555,6 +1573,18 @@ static void test_postcopy_recovery(void)
     test_postcopy_recovery_common(&amp;args);
 }
 
+static void test_postcopy_recovery_channels(void)
+{
+    MigrateCommon args = {
+        .connect_channels = &quot;[ { 'channel-type': 'main',&quot;
+                            &quot;    'addr': { 'transport': 'socket',&quot;
+                            &quot;              'type': 'inet',&quot;
+                            &quot;              'host': '127.0.0.1',&quot;
+                            &quot;              'port': '0' } } ]&quot;,
+    };
+
+    test_postcopy_recovery_common(&amp;args);
+}
 static void test_postcopy_recovery_compress(void)
 {
     MigrateCommon args = {
@@ -3585,8 +3615,12 @@ int main(int argc, char **argv)
 
     if (has_uffd) {
         migration_test_add(&quot;/migration/postcopy/plain&quot;, test_postcopy);
+        migration_test_add(&quot;/migration/postcopy/channels/plain&quot;,
+                           test_postcopy_channels);
         migration_test_add(&quot;/migration/postcopy/recovery/plain&quot;,
                            test_postcopy_recovery);
+        migration_test_add(&quot;/migration/postcopy/recovery/channels/plain&quot;,
+                           test_postcopy_recovery_channels);
         migration_test_add(&quot;/migration/postcopy/preempt/plain&quot;,
                            test_postcopy_preempt);
         migration_test_add(&quot;/migration/postcopy/preempt/recovery/plain&quot;,
</pre>
      </blockquote>
    </blockquote>
    <font face="monospace">Regards,<br>
      Het Gala</font><br>
  </body>
</html>

--------------6a18Fa2aUuMB465qNN6GDUuM--

