Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA51C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 18:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruyk4-0007Ta-Mh; Thu, 11 Apr 2024 14:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruyk3-0007TJ-7a
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 14:01:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruyjr-0003vM-51
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 14:01:42 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43BBuCHe009753;
 Thu, 11 Apr 2024 11:01:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=68d71GhSvr6BSM4A2Vku8QCcWFV4yDiPhOTux6F1D
 hk=; b=rCxnPjZ+UELOizoHOxPBEJm2YCIxOjmIUsug0DPTGj/neO/GfdwFJcgPq
 wVBxB18OWlK55eRmjaEP+fAHSHT24LnQZmkwgK5XoIJw7uVuHqdwsBDllMTuZ0tY
 pUwwtZaq9oYjnQvD4zkG/mk+NGq//7y4DmZ4usjEJrUscXJ9rusqHn5hO7HU47bW
 URqv+tP5SEcEgC00bmHTOrD5fxWxIA4Iagn0uJAPxP5l/sMgzRbVjRIZmixOcWOQ
 sm1tC1Hqv//UZQ7/1glyCuUKMXIpkf3DO3Ne8vBHAShQXrQ76aMCQXp1KO0Fq+Rq
 rf5zobOzXOKbmAXAY3eHD+zx0PfZg==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcuympd8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 11:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foRXsXP3JHiC+LTkS5LwFM8CkDckVCAakwJmi3S5oOCmvkfeSEiitZ/xVW/lxIdb7VAWrjbvw7Be8xlSo7d0a8ZiqSjaQScNrdnNDoVZf5RbRmeDeUuXler94+1QSWg/MzXLUM1BM/pr0GDbvVvIUX71aOiuLgdlycPVowVqgrRq4n973WUejl2aNNsqafQw9uuG0H1eYRcREELaHe/uXEvCQfWQt4GqcPUQCZ38B/SL5L+ViYGel9uaS+e9lA5Rv27PMJCUNx7cH4fNPYnby83k1EZdX4flekxDNPj+1lCE1TXkajlIHv5cJq6OnjLNvYJq776GTaG/9Ssq8CJ/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68d71GhSvr6BSM4A2Vku8QCcWFV4yDiPhOTux6F1Dhk=;
 b=YSEDgOHRIkdSjd6xpDQ7qijgPu9/mRy0wFGv61dZloH6YcweI1Z5OYcxYDh5ig7aYgB3c+vJH4ScB0DGsce5d3AwquB6NwpDqnM0XmCf2wVjzXbwqk0+44SebD37U9C/awY3YepnP56yn9r7BC1Fv2rw2ZsqTFdv18xhJGjeKrZLX4vXxaHHcDNLDGlUbwuge9QVNfxeoeB/mKBAfwvVW634YBa4PSoXhxGW2Xjgg/v//85rcXDR+FaUXAIbTsA5XzQYIV72T1rGjBn4mGGH5I2EAnsHhDsygcqPJY5J3np0fjSoC+mz3TwEP3Y+pGNnM7nbLBy26yIkVaRZSZpyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68d71GhSvr6BSM4A2Vku8QCcWFV4yDiPhOTux6F1Dhk=;
 b=YxPY0jCqyxhSfrpA/fnwwxzl2XQeJLlF3ZPSu3q/XE0eCSvdTmGp40AgZ2hdFidAHsyMIbra7Zu3eRLSxWypxjLqlRk5zPVRgo5g+nqnN0o25GX/DjB1MwAzDPmX+I3MLHHjQjS+z6o+n87f+DAP8y/A7qRHkipyXx0zsCY48txqnnn467OCknjc2hdPlVfKE8Ox8oBj/3XWPKCjsXwB1YP7uFtWc+Ex+KwsZGglM6C55utGRlmObUmbugBHHkIPRJCcu9hv6wCkGvqCuygyGrVjKrYzPK/yMlDpJRN9IBwNLZB2dueUqdcmChpiA/+RpmE6TZyE7LtxnL5fIR9Fqg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA2PR02MB7835.namprd02.prod.outlook.com (2603:10b6:806:142::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 18:01:16 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 18:01:16 +0000
Message-ID: <e0f41009-a2bc-4302-82d5-c396d95a5cff@nutanix.com>
Date: Thu, 11 Apr 2024 23:31:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none() to
 use new QAPI syntax"
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, thuth@redhat.com, 
 lvivier@redhat.com, pbonzini@redhat.com, prerna.saxena@nutanix.com
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-2-het.gala@nutanix.com> <874jc9v066.fsf@suse.de>
 <Zhan0Brg_CXzt79-@x1n> <8621e850-168a-454a-8f00-615f476eac31@nutanix.com>
 <ZhfzMt3t2oU7qt90@x1n>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZhfzMt3t2oU7qt90@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::33) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA2PR02MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 8462e56b-d6a8-44d4-ec84-08dc5a5161bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qP3Pvq/0upBqGCVe+4ZtH5sDesDri5gFtuDmG4WfL4WpjKZeYRGXUXhwNNDY+chWcWsN5yKGVkXWlevRVEQ65ScvDakdDYo6spZqhC0aSqWVxIW4wlZ/qDMv6+maMvxpHiL6Ukq2030SZjxCF7+wRQP4cAfp7Ax9T+VUJmtKLqDUHYwSvpDNMzV33cuF6zIx/aqRfwxRZwkJs4RdDvp0AmZb+76OUOjMHjkrcLFfkEIXhz4beeEOoaBvmr/B69UAM0DJOov6AyJaSEFf6v/mVelFkyG2szBzbNW5+k7rvD0iArFwdnY1lb/I0csoEN0LTrSBu5zS1JqzSijQU5V+NElWFS/+v0x0zhN26jlzOynTlSO360q0xeSJkd0wpujr9bZDhlUavvU9q3cBOPHZzc8ZR65AG92NCLt5/EeIUA15pdJcLzFsKrumZ6KvuF+CwK64SOtttqY7ZKh6gIE70XNUPaKC1kpJgQsVoEeNTMAPy4vt3ulLCfAno1jBqDEDNZ7oeFx5dGKYYlpABoAOTJsrPnby8MqJMJbu8U03uXqKAAMURPleAThK7kg4r1Xr/9oelrS+xYXq20LN7MtW6sEX25GuvDKnIJUUgxU6sxcsb9/nW5MqQLQPZBaqp9W23O1uppL3MGH0TLgWfa7+VGt9i0odKBsTegZxYCvji5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnlsZGh4cFBlOEZxNUJaaThZUFRkWFJJRnF1RWhEZEIxb242ckU0VGFWWFpT?=
 =?utf-8?B?Skl5WHRwRjlWS0swZERXNy9xRWVxSGxyTk05eW5qRGFaZjZBTDZtbzJ4czRt?=
 =?utf-8?B?aE5qZWo3WTZIN25RcGh5bkFMLzl2b2hrYnpEb0xNMU93eThsY3JmRVdCSjdu?=
 =?utf-8?B?eHRPeVN1a0ZOQ1E4QjkrM3lzME5kNUQ0a2FFVGdlTVA5OGdJT0tqTnpzVlh2?=
 =?utf-8?B?aVBiQkRxUTVBenNKQS8wL253RDF5UjVzaWw4b2ZidEQrWktLTUdQSzJ1RS9E?=
 =?utf-8?B?ajNUak5FRUdaeUhVRUxsVkxzd1BTRjY0bHY4YzlqRVBsUjJWSXlvNmd1VVhR?=
 =?utf-8?B?NmM5UldIV3FjdzM4U0ZTbXc4dDY3SHIvWUlsWmNOcnYvS3ZFVG9kNVRzaEFT?=
 =?utf-8?B?eERyekFOalZVTzBqd1JmSW51L25OanE2dGRyRlNlV1YrNnFidkFLL05HVTBU?=
 =?utf-8?B?VGhrcnc5RysxVmYyYnpwb016TVVkc0RKVG1SWVRPZFJxVW1pU0J6dlp0VUVk?=
 =?utf-8?B?bkFUWW1iTWtMSEZrc3FQRnRmVDI2MlZ2ZzdRVU5CL3BOQ3RQMHNOUFNEd2FW?=
 =?utf-8?B?QkgzY1lOdnRsOEc0d3g2S0dsUVBZVlRIbzk3MWNJOHMyVXVCQys3NnVrM3FV?=
 =?utf-8?B?QXhaM3M4emw4UE96ZE5KWGVyS3MzV3NjYnEvUTZlc01XMlA1aEMrY1l3RUpj?=
 =?utf-8?B?WXRjVzBER20vcDVIdDlrV1lTZEg0Nmx0bGhncHZNN1RXSG5Zd0ZIeDZKbWhU?=
 =?utf-8?B?RjFDRXRGVHpFSi9CUVBxWVRCdk01NE90M25PU1hkN0FEc3dmajFFc0lqR0lk?=
 =?utf-8?B?M1ljR25vNHdTT1Z1OUhTYUpIN1RXZHRhMnA4dG5xcHFDWGc0RWVudjh3OHlp?=
 =?utf-8?B?aEcyTEtCV283b3Fzci9qbGhCTTRtU0dDR0FpbzNPbjNtNkFLRzZWVnRyWDlL?=
 =?utf-8?B?c3hZZ0d6UEZONlNoRGYrV2ZuR0NXc0FRNGJoN0NIcExhOUx3VTdsUHBzNnBq?=
 =?utf-8?B?TmJDdG1KUEcyaHllVnkzRGFNY2JiMFk3bWp1RWN6Y2YxcGJBQUJHdy9waHFt?=
 =?utf-8?B?TEgvRnRCM2tWT1hOYnBLMU9QU1F4OXpsUUloUXJzZGVyc0xCUzJnb1oyZnYv?=
 =?utf-8?B?bWZRbFlXVDFwRVVaV2s1Wit1RVBtZmx6RUVUUFdXL3E0S056bm5DdFNRdTBh?=
 =?utf-8?B?L3ZER0I0dkVBOXRNT1ZiRG1lSGV4SnR2NDVmMW1vZm0zZGJDanFQM2lQc3J2?=
 =?utf-8?B?MTkvY1Z6cmZQZGFYbjZadTV5cjMwd0s2VkZtVFBJdjhjeUtFUEQwSG1zVzY4?=
 =?utf-8?B?M09Cb1VUT1lkQmJtemFyVDR2ODJWaC83MHY4NU5rRTU3SGxPV3lEOFFrZDZ1?=
 =?utf-8?B?U20xWTJsS0o2SzV1TkxqTENaTlVVNFIrUllYd1Y5NHVFNTA0ZGFwbUluYVBP?=
 =?utf-8?B?TlY4d205MHI1VTRNS3pkSkd4R3VDU3kyYisyL0hPVmVjUWVJZUF6Z1NheWJP?=
 =?utf-8?B?cmhtaUZyWU1BQVV3UUFXbG4wRzhHWmN4SFNPempsRDJKZEtiVEwzMk11Tm52?=
 =?utf-8?B?blpSMU1IeklRaTdFUUFKNlpyTmJ1aUlYMzNKQmdtdkYyVUx5Q0tqUC8ydmxB?=
 =?utf-8?B?aWlhVGN2SEdqSFNmUkhlcERuWHJHbjltdmhDd3RaaGxzT2RXeXVuQXBXQ2hy?=
 =?utf-8?B?eS80Y2d2QmFSKzNYYkcyWm1aV3lXTHZFMDM2Zm40Ymx3STM3c1VJR1FxOEp6?=
 =?utf-8?B?Qld6VDdkRERrZUJ2SjlzSUpWaGhFck5YU1lxRFk3aGQ2MlJEa0lqQmVPQ05H?=
 =?utf-8?B?dHA3TkJTaGhLNmVaMXFOc3ltNzdPbWYxNGlodXo5d1dSTFJkQkNKZk9DYjNW?=
 =?utf-8?B?QmZ3Y2wxRFdKMjFQbE5HbGZmMXdRNVZwWFFsQ0E3MTJFbkNsV0Vpd3duOWEy?=
 =?utf-8?B?dW1VWjJGVVVmcE9La2wzZnlqYThFVUdELzN6MEVyR1o0YXpsS1BGbitoOW9k?=
 =?utf-8?B?UjdkU1QyM1lGd2VmN0VMN2d0UWg5ZldwTmM1NUNqc3A2MmR5a1ZFNllPYmVI?=
 =?utf-8?B?YTczMk1wRkVraHRoUkl1UHhzdFlnb1VZV1BqSHczdFgwK3lQSERXUm1RcjFP?=
 =?utf-8?B?NDBqRWdpTmF6UFBDWkxVMGk4ZXFhMkVYQkl0dGpJYjdwNVY1dVNJWUExNUND?=
 =?utf-8?Q?QrZ3RjVBgBcJwouOr2C0UHey0CDdU6/YGdF+t60RSQKo?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8462e56b-d6a8-44d4-ec84-08dc5a5161bf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 18:01:16.1725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTx6LIHIEArh78tFOnddMA6nHPl5dQN6bgMedGYzFljkuhtD4c5aarBn/T47ooYWTRBWft+4xegi0mAI1+4rJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7835
X-Proofpoint-GUID: kDrBPh3Vn5zgI_WVEth-QcqwCkuVJR9N
X-Proofpoint-ORIG-GUID: kDrBPh3Vn5zgI_WVEth-QcqwCkuVJR9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
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


On 11/04/24 7:56 pm, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Thu, Apr 11, 2024 at 07:45:21PM +0530, Het Gala wrote:
>> On 10/04/24 8:23 pm, Peter Xu wrote:
>>> !-------------------------------------------------------------------|
>>>     CAUTION: External Email
>>>
>>> |-------------------------------------------------------------------!
>>>
>>> On Wed, Apr 10, 2024 at 10:04:33AM -0300, Fabiano Rosas wrote:
>>>> Het Gala <het.gala@nutanix.com> writes:
>>>>
>>>>> This reverts commit 8e3766eefbb4036cbc280c1f1a0d28537929f7fb
>>>>>
>>>>> After addition of 'channels' as the starting argument of new QAPI
>>>>> syntax inside postcopy test, even if the user entered the old QAPI
>>>>> syntax, test used the new syntax.
>>>>> It was a temporary patch added to have some presence of the new syntax
>>>>> since the migration qtest framework lacked any logic for introducing
>>>>> 'channels' argument.
>>>> That wasn't clear to me when we merged that. Was that really the case?
>>> Yeah these look all a bit confusing..
>>>
>>> I'm wondering whether do we need the new interface to cover both precopy
>>> and postcopy, or one would suffice?
>>>
>>> Both should share the same interface.  I think it means if we covered the
>>> channels interface in precopy, then perhaps we don't need to test anywhere
>>> else, as we got the code paths all covered.
>>>
>>> We actually do the same already for all kinds of channels for postcopy,
>>> where we stick with either tcp/unix but don't cover the rest.
>> Do we want to add other transports too (vsock, exec, rdma) with the new
>> interface ?
>> I believe we have tests for fd based migration
> Het,
>
> What I meant is we used to do white box testing for migration, trying to
> cover all the code paths would suffice for us in that case.
>
> It means maybe we don't need the postcopy test to cover the channels
> interface as long as precopy has covered that and also if that covered all
> the "channels" abi then we should be safe.
>
> What I worry is we keep extending the test matrix but we're actually
> testing the same code paths.  Then the test runs slower each time, we burn
> more cpus for each CI kick, but without a real beneift.


Yeah, I understood your concern Peter. Yes, since precopy and postcopy tests
cover the same code path, adding 'channels' postcopy qtests does not make
much sense after already having introduced in precopy qtests.

I just wanted to highlight couple of pointers:
1. though we are using 'channels' in the precopy tests for 'migrate' 
QAPI, we
    use the old uri for 'migrate-incoming' QAPI.
2. We do not cover other 'channels' abi, only have tcp path tested.

So, the TO-DOs could be:
1. Omit the 4th patch here, which introduced postcopy qtests with 'channels'
    interface OR have 'channels' interface with other than tcp transport
    (file, exec, vsock, etc) so as to cover different code paths.
2. Extend channels interface to migrate-incoming QAPI for precopy qtests


Regards,
Het Gala


