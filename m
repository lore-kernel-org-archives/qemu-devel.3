Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDA4CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 12:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruX8x-0004vd-5W; Wed, 10 Apr 2024 08:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruX8r-0004vQ-SM
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 08:33:31 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruX8o-0006Sp-EZ
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 08:33:29 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ABLCOd032685;
 Wed, 10 Apr 2024 05:33:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=bKQtCOFRIV4m
 Jf0AlF3Yr5cgObH3UOlD3olUDndrChQ=; b=20O1SsN1hEBK4zDW8dmmdseoIASw
 b8EF0rojdIVnvfUcVlv+5V4nnsffNVi9l4DMFWbbdzYQH+c79+hkJcICfT+ZKxde
 tcIpgB5CKrkMhkA3jNI9qD/jfICmdpEzC1R2WDmyycWosffydchVt+jPsB/e+AfU
 0jjy4293/aeO5faQZBDciSdZb6dzMG00uiSyaSJm6qxff5B9eFjRWKlcj3PWlC21
 f3ofD2K2LwvMoSjbQaiSu2TeZ0VpiIQd31+oA2Aweamd4uWrLwAHa099bNQ/RIL3
 QcBtSikfm4zPUVpoS//gWa/7Hr9bz7Bp77tCwEIoaL25zzdwO0uaj7R2/g==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcs433b2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Apr 2024 05:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Quuha0pBFNelCcr9LwCgZJv1H0Imu5gbrMvV55OZ3Wy2vIN27gFlwsMJqHdTZfrIrs4+C1YuzBLcefG3uj2BM1ePnJ/WV0lzRqmVbkuFT0rOupN3kp53THcK9sovwZViGPi5V5DDlKytgWB2K+x2aTCLqJkODuM5AIvAbSOgzc1Hx4nlI/FOsMtVZw8x0wMutB/IcpnrOuuKmucGbWk3Q+I63RmlUi2c64VaYMHytUe/u3gkonz45sYydN5/vvctdDnUitoe5kLQ3Vo/YAtfzFvrQTmFSCdb4gOkigG+p4FICT0XDK9yFgzUsR09Ty8powvbWfyKMQ/1jgsV38c8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKQtCOFRIV4mJf0AlF3Yr5cgObH3UOlD3olUDndrChQ=;
 b=PpUWjr+yHRpQX/n4miwB80bMpcgKibNMts28zErjjQ1UB1pJh9QHsOLUqvkdXiiSuLRaM309sA5BPqAc58gLi2rlR743eOh/fz8Z6RMO/qGvyAk3S1DA2wdc9tjr1YvCQixYwqz29eA5sMps2+NYhHFACHeQVCAtOvBR/Y1x3phxMK3V0YI89jst81IutRqCUDcJU/a/yqhBr6rydgrr1jzEisUiJiV1ovogHtH03Xjd3EOm8RB0/CBkQuhrQoaOhOnQLuBs7NMII8Jd1/jykNg3NcSCQdxQXrKpE+dgTN5sTclZTRlM6919EWQc4XdECUZViaVh5Q3JgV1kCGu4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKQtCOFRIV4mJf0AlF3Yr5cgObH3UOlD3olUDndrChQ=;
 b=nEralr3NrxG0jMRpIECKjN9SCfX94sMVRUf+Q9jkTQRSOeK4pwXdcwKhfDRZjem56qsdXvYeTC2FAW5QcnjYDo7bvRgdMaGlp29naPFHqXOzw5pwy6w3YJPooGWLYiNnTo8CrT0EK4vnsctvDqni/UcP5QLao1tHm+x9E3sdO/k2GkGxnPdX/HNqNID1VBjZrIMcWCmBUA8P3hIypw9AuB42QyRqYO8QOBIT5TxxvQpqwibiKBAXrOjO9VxpRg1+XBKv3TvniPJeUDc0aTDpq6HBmrpbRCelDKt8pdZzZrVCzPP7Aro+O1yS+DzBQTOXQ9nx6uCW8fWrJLPHozL/8w==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6520.namprd02.prod.outlook.com (2603:10b6:a03:1d3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 12:33:21 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 12:33:21 +0000
Content-Type: multipart/alternative;
 boundary="------------HObxJJxg0kshhoi9OvIToPrf"
Message-ID: <84e782ab-d4d2-4e66-8d55-28206e313bb8@nutanix.com>
Date: Wed, 10 Apr 2024 18:03:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Standardize qtest function caller strings.
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com
References: <20240326193843.8444-1-het.gala@nutanix.com>
 <87zfukvh0r.fsf@suse.de> <1f336795-5c5d-4320-8783-3cbe238f894c@nutanix.com>
 <87a5m7vq73.fsf@suse.de>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87a5m7vq73.fsf@suse.de>
X-ClientProxiedBy: MA1PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::11) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6520:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTXwycESg8MyKxNraylsJNwpktX8AvforssOg6cu8QRReWf+hE+pU2EaKw8M4FXckLUSlxi69pZFWG5GBU17vlpIcEbnYXvEss1SKW+yD6u3EZmAJlnstOB0c8UdfYqGdbcIlbBnj1farQ8/ijhN/mKj3nZ/dvwyF5OBpuJEvlk0WobbR34Rf49hDAgHz6j2shXoa8QOGrqQ4iTOt7V9SR7JgvUFLvVmIiRni3WbjiYrvwRJetXxdfENz0gK9XT957bfrT3iI7wKBvkVJFNsNE0cqcP05LRXDrCYkcK7Rtl+iJL5Cj6dZa29at6sD+5DQug/kscmdauHcpkrZ0kQx1rNcUEjuQVqCAT6g7A7uRQLLuQ4kTdt2m+1WmQNqh3igmb/OmIrSmCR/AkA5J7AnYzWf2wEwdCLvjg8Y/b6wMQ/nbXNWPFdZC4GHUpOMkLpye2Ymmfrjmyd50G+zBm4fqkQ9zGSnyEx3ZBKUZwzupu/PEKHaBsAzaqGE4iQdx0PO27GhyfyNDi7T0nRQ+xTKAA/aEn0fVGIAQRDYZgBM2NMwh0vp2KaH9zNfonwYvHrFNevX7Uc2EGOMrEEmySpLy92nYiXLfjsfRnbzWSlUtuh1cyXTPHj34JaPjSJpqK5HEPFmE3erd+JGRxhGb22CJoaaacNQbhPc1tyTjzG8wM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1grL0c3Ukt2QndCL2ExOUhiaDhRUmljL1MrR1NLTXM0QmpNMHRPSUwyS3E5?=
 =?utf-8?B?YzhSVVR4YkhqUU1RQ2RHbWtSY3ZUMTl3WEJHTkhOVEdsK1lubGpub3Y5ZG5Y?=
 =?utf-8?B?Vi9QaW8yT3VuRmtCdnI0RlJzeXh5aWs4YStHeWFMaWlGL1YzTk1JbjdhQjBv?=
 =?utf-8?B?TURaeHRNcGNuQkdzcEJJdG9VRWNMTjIzVWJyMTcwYmkyTVBPanBuTDRkMmdw?=
 =?utf-8?B?MlB1d09iV0JadDl4bWNRaGcweGQwTEpDV0JlWWtQV1RzWjBMblBwbVJTTCtS?=
 =?utf-8?B?L2lOYjh0ZG9Vb00xQmxsL2F5WGwyNFlqVk15NVZqSWJiMStWS0JpU0tlQzlm?=
 =?utf-8?B?YXI5ZjN3YUNrcDhRUjJyOWNQb25HSk41cTVpNjJmalRmaDFoSkJGckxaTjhE?=
 =?utf-8?B?QnlrTjFhbFlKN1NJYTdJQXZuaE1HbHczZk9VMWZWcWhjbGdKNFBjOGxwNjV2?=
 =?utf-8?B?Q1Q5N21UUk9XcWtsQlprdGMwQXFrVHRKMS94T0drRlNxemRHTUNOY1NRWk9S?=
 =?utf-8?B?SEE1d0E3ZTIyTDhTcEF2SjhheTFSUG8xeGtKL0FDQnFJN0g5SGxGNEt2VXFY?=
 =?utf-8?B?ZGtPK1VReGNFWXcwZURxTVA3MHZodEdaN3JHcHdIWlRxejdMYkNsL3lvODhY?=
 =?utf-8?B?Yk5jdUtzUVNVUUhOalU5S3JTYmpOTXRKbzUyOHdaOFQ5SXlUczBad1BFYVpz?=
 =?utf-8?B?Y0R2V1VUSWJwbzFhZERyYTVtT1NXTUFYc1YwRzJJbXFsbEdpTFNmRE5CdEpo?=
 =?utf-8?B?eDdQRmp4OFRwbzJ5cWhXZ09TMG5waXZCMENranRmK092TDMyaGw1Zms2d3NR?=
 =?utf-8?B?TlVHWExxdHJ0aU81SExzNlE4Zm5qdFVEb3NaZ2d1M2doaWhKMGJYeEJtT0Qv?=
 =?utf-8?B?TUkrQTd1YmlibjU1aGRsbGdOQXRPQUIyem1Pd2RocURhT1VLTFpRR01POHh2?=
 =?utf-8?B?V0dJQ2Q5SXVCUE1VMXo5OTlGQWxhRkQxeng2OVBZVGRLenpMMmZOalVHcTky?=
 =?utf-8?B?RFUvekVBdFZCQmxKODdmTFJmUzkzU0k1Q2lwSWw1VDIyajNhbUZKL204L3l5?=
 =?utf-8?B?elVYWUhua2lidXBYMnpoRGVGbWxOWFh1QUhidGdhd2ViZjZrVWZORytkaXhv?=
 =?utf-8?B?MFFqcklKQU5GWnp5c3oxcjc0WjdRNVc5V1cySnMyT1FkZlRCb3BFbFZncXIx?=
 =?utf-8?B?YnM1eGN1UnZscHl3YUlHNmhxamVGa28wVFgwemRQSlBkL3FIT1BmYXNPaUhl?=
 =?utf-8?B?N1hvRXExb2ZiUlFJUTB2RDhYdEpLZnZDdmV0YVNxRGNleEFPOTlJNnoyN2Np?=
 =?utf-8?B?SGNpRlg2bzdLNDdkZTlhV0hDaGxLcyt5bkNlbXlSRGc5aEZGZ2VacWVUWUFT?=
 =?utf-8?B?cE1BbjdlVGpiRXVyaVVSa043ellYNjZ6eTF5QmhEcDNERE1HY1NIVEhMKzVE?=
 =?utf-8?B?YXdVemlzVTJKN1RqS1d5QnFLdEJWemJxb2FTZnpmS0ZISjBhUzN0U2FCUVdm?=
 =?utf-8?B?S1ZCWHdLbkNpMFpja2IrZm11ZE5sNnk3OXRPQVQxcGNwc1RJODJtZjFHb2V4?=
 =?utf-8?B?anRBTi9IeTAxN2NEL0IvUThGdVU3OUowSmFKNXlSbFU3K25LbVRSNW9BakR3?=
 =?utf-8?B?NXlTTkozVnJHeVRReG9RWkZaQlV0M012dGlSams2MlVyTzNMRHNiRnJHMi9U?=
 =?utf-8?B?OUZzc3g1YkZUTWlGTEtVSkdnWDRPTHQ4Z1ZLc1B1N3hVUHJiOHAvNy9JRnd4?=
 =?utf-8?B?RVpvMVB2WHdaaU55K1B3MXNWbytuUnN3YWlDWlZZbHNYczJRTEprTzdBZE9l?=
 =?utf-8?B?NitpMVkyT1VrVGF1cTVVRy9HRUpUUFcvdVMzK2QwVjhMNmJoK0JrS1FPT2x6?=
 =?utf-8?B?WGFaak9nWHo5TGl4QWFTNHYyYUVaZFhCY2FQb3VZYmtzemY1QkNYaytONlh2?=
 =?utf-8?B?LytVWlFkeVBOMmNROFIvZmlpck9XaVJNdysrSDREYlY1d0lPMXVyVWRLeE1Z?=
 =?utf-8?B?RkZidTEzMm0vc1B0cTQ5SW1MWUk0TERQeW8xajhZK1JybXRqL3A1a3kxTlBU?=
 =?utf-8?B?YXZHQlpEZ2tkVVNVWnRRZkYxaUFWYXJnMVdMR04xQmdtQUJlaDNaQ09OZi9w?=
 =?utf-8?Q?/ikrRFAeKWAxmc0rbkW1LXkqm?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cdcb30-ccb9-46fa-ae24-08dc595a681c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 12:33:21.1665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDRBekNR7zVjgNEGNaoIA4/iZAGgI0Gt3HDGqXRWx02vCIWzlfwzMsdLBt0t6VNYMUwWSrySBtMN1ZGeE2ybIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6520
X-Proofpoint-GUID: xXv7-lncsHE8qac0mb2eTP1ykKiKYdG7
X-Proofpoint-ORIG-GUID: xXv7-lncsHE8qac0mb2eTP1ykKiKYdG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

--------------HObxJJxg0kshhoi9OvIToPrf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/04/24 7:58 pm, Fabiano Rosas wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 27/03/24 2:37 am, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>   writes:
>>>
>>> Some comments, mostly just thinking out loud...
>>>
>>>> For <test-type> --> migrate
>>>> /<test-type>/<migration-mode>/<method>/<transport>/<invocation>/
>>>> <compression>/<encryption>/O:<others>/...
>>>>
>>>> For <test-type> --> validate
>>>> /<test-type>/<validate-variable>/O:<transport>/O:<invocation>/
>>>> <validate-test-result>/O:<test-reason>/O:<others>/...
>>> Do we need an optional 'capability' element? I'm not sure how practical
>>> is to leave that as 'others', because that puts it at the end of the
>>> string. We'd want the element that's more important/with more variants
>>> to be towards the start of the string so we can run all tests of the
>>> same kind with the -r option.
>> While also looking at different functions for figuring out the transport
>> and invocation, my observation was that, there might be many capabilities
>> added to the same test, while it might not be important also.
>> Ex: /migrate/multifd/tcp/plain
>> 1. multifd is defined as a migration mode.
>> 2. It is also a capability, and comes in 2 parts [multifd, multifd-channels]
>>      though one is a capability and another is parameter
>> Similarly in other examples of compression, there are many capabilities
>> and parameters added, but it might be not important to mention that ?
>>
>> Secondly, there are multiple migration capabilities IIRC (> 15). And a test
>> requiring multiple capabilities, the overall string would be too long, and
>> not that important also to mention all capabilities.
>>
>> Just thinking out of mind - Can we have selective list of capabilities ?
>> 1. multifd 2. compress (again, there might be confusion with multifd
>> compression methods like zstd, zlib and just 'compress') 3. zero-page
>> (This will have sub capabilities ?)
> I was thinking of keeping that part more open-ended. So not specifying
> capabilities one by one, but more like "if you're testing a capability,
> it comes here".
>
> About multifd, it's a bit special since it cannot be seen as just a
> "feature" anymore. It's a core part of the migration code. I wouldn't
> classify it as capability for the purposes of the tests.
Ack, got it.
>>>> test-type            :: migrate | validate
>>> We could alternatively drop migration|migrate|validate. They are kind of
>>> superfluous.
>> I agree with the above comment. 'migrate' and 'validate' have a different
>> set of variables required, some necessary, while other optional. IMO this
>> will help is in streamlining the design further.
>>>> migration-mode
>>>>     a. migrate -->     :: precopy | postcopy | multifd
>>>>     b. validate -->    :: (what to validate)
>>>> methods              :: preempt | recovery | reboot | suspend | simple
>> I want some inputs here.
>> 1. is there a better variable name rather than 'methods'
> Does this fall into the "mode" terminology that Steven introduced?
Yes, as we decided that we don't want 'migration-mode' key-value pair,
naming 'mode' would be a better term.

In cases, where multiple modes are to be used ex: postcopy_preempt_recovery
I feel it might be a good idea to separate multiple modes by '-'
For example - .../preempty-recovery/...
Similarly for other keys too if required
>> 2. 'simple' does not fit perfect here IMO.
> Can we go without it?
You mean omit the key itself in case of a no-op ?
>>>> transport            :: tcp | fd | unix | file
>>>> invocation           :: uri | channels | both
>>>> CompressionType      :: zlib | zstd | none
>>> s/none/nocomp/ ? We're already familiar with that.
>> Ack. Will change that.
>>>> encryptionType       :: tls | plain
>>> s/plain/notls/ ?
>> What if there is another encryption technique in future ?
>>> Or maybe we simply omit the noop options. It would make the string way
>>> shorter in most cases.
>> This might be a better approach. Can have some keys/variables as optional
>> while some necessary. For ex: for 'migrate' - transport and invocation
>> might be necessary while it might not be necessary for 'validate' qtests
> Yep
Ack, will do that!
>>>> validate-test-result :: success | failure
>>>> others               :: other comments/capability that needs to be
>>>>                           addressed. Can be multiple
>>>>
>>>> (more than one applicable, separated by using '-' in between)
>>>> O: optional
>>>>
>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>>> ---
>>>>    tests/qtest/migration-test.c | 143 ++++++++++++++++++-----------------
>>>>    1 file changed, 72 insertions(+), 71 deletions(-)
>>>>
>>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>>> index bd9f4b9dbb..bf4d000b76 100644
>>>> --- a/tests/qtest/migration-test.c
>>>> +++ b/tests/qtest/migration-test.c
>> Regards,
>> Het Gala
> I'm wondering whether we should leave the existing tests untouched and
> require the new format only for new tests. Going through a git bisection
> with a change in the middle that alters test names would be infuriating.
Hmm yup. I had this doubt on, how would we be enforcing the new design
for any new qtests that gets added from now on ?
Can we have this design started for validation tests maybe for now, the
number is low and might get some feedback to improve this ?


Regards,
Het Gala
--------------HObxJJxg0kshhoi9OvIToPrf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 05/04/24 7:58 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87a5m7vq73.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">!-------------------------------------------------------------------|
  CAUTION: External Email

|-------------------------------------------------------------------!

Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 27/03/24 2:37 am, Fabiano Rosas wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>  writes:

Some comments, mostly just thinking out loud...

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">For &lt;test-type&gt; --&gt; migrate
/&lt;test-type&gt;/&lt;migration-mode&gt;/&lt;method&gt;/&lt;transport&gt;/&lt;invocation&gt;/
&lt;compression&gt;/&lt;encryption&gt;/O:&lt;others&gt;/...

For &lt;test-type&gt; --&gt; validate
/&lt;test-type&gt;/&lt;validate-variable&gt;/O:&lt;transport&gt;/O:&lt;invocation&gt;/
&lt;validate-test-result&gt;/O:&lt;test-reason&gt;/O:&lt;others&gt;/...
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Do we need an optional 'capability' element? I'm not sure how practical
is to leave that as 'others', because that puts it at the end of the
string. We'd want the element that's more important/with more variants
to be towards the start of the string so we can run all tests of the
same kind with the -r option.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">While also looking at different functions for figuring out the transport
and invocation, my observation was that, there might be many capabilities
added to the same test, while it might not be important also.
Ex: /migrate/multifd/tcp/plain
1. multifd is defined as a migration mode.
2. It is also a capability, and comes in 2 parts [multifd, multifd-channels]
 &nbsp;&nbsp; though one is a capability and another is parameter
Similarly in other examples of compression, there are many capabilities
and parameters added, but it might be not important to mention that ?

Secondly, there are multiple migration capabilities IIRC (&gt; 15). And a test
requiring multiple capabilities, the overall string would be too long, and
not that important also to mention all capabilities.

Just thinking out of mind - Can we have selective list of capabilities ? 
1. multifd 2. compress (again, there might be confusion with multifd 
compression methods like zstd, zlib and just 'compress') 3. zero-page 
(This will have sub capabilities ?)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I was thinking of keeping that part more open-ended. So not specifying
capabilities one by one, but more like &quot;if you're testing a capability,
it comes here&quot;.

About multifd, it's a bit special since it cannot be seen as just a
&quot;feature&quot; anymore. It's a core part of the migration code. I wouldn't
classify it as capability for the purposes of the tests.</pre>
    </blockquote>
    <font face="monospace">Ack, got it.</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87a5m7vq73.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">test-type            :: migrate | validate
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">We could alternatively drop migration|migrate|validate. They are kind of
superfluous.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I agree with the above comment. 'migrate' and 'validate' have a different
set of variables required, some necessary, while other optional. IMO this
will help is in streamlining the design further.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">migration-mode
   a. migrate --&gt;     :: precopy | postcopy | multifd
   b. validate --&gt;    :: (what to validate)
methods              :: preempt | recovery | reboot | suspend | simple
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I want some inputs here.
1. is there a better variable name rather than 'methods'
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Does this fall into the &quot;mode&quot; terminology that Steven introduced?</pre>
    </blockquote>
    <font face="monospace">Yes, as we decided that we don't want
      'migration-mode' key-value pair,<br>
      naming 'mode' would be a better term.<br>
      <br>
      In cases, where multiple modes are to be used ex:
      postcopy_preempt_recovery<br>
      I feel it might be a good idea to separate multiple modes by '-'<br>
      For example - .../preempty-recovery/...</font><br>
    <font face="monospace">Similarly for other keys too if required&nbsp;</font><span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87a5m7vq73.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">2. 'simple' does not fit perfect here IMO.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Can we go without it?</pre>
    </blockquote>
    <font face="monospace">You mean omit the key itself in case of a
      no-op ?</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87a5m7vq73.fsf@suse.de">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">transport            :: tcp | fd | unix | file
invocation           :: uri | channels | both
CompressionType      :: zlib | zstd | none
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">s/none/nocomp/ ? We're already familiar with that.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Ack. Will change that.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">encryptionType       :: tls | plain
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">s/plain/notls/ ?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">What if there is another encryption technique in future ?
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Or maybe we simply omit the noop options. It would make the string way
shorter in most cases.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">This might be a better approach. Can have some keys/variables as optional
while some necessary. For ex: for 'migrate' - transport and invocation
might be necessary while it might not be necessary for 'validate' qtests
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yep</pre>
    </blockquote>
    <font face="monospace">Ack, will do that!</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87a5m7vq73.fsf@suse.de">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">validate-test-result :: success | failure
others               :: other comments/capability that needs to be
                         addressed. Can be multiple

(more than one applicable, separated by using '-' in between)
O: optional

Signed-off-by: Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas<a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
---
  tests/qtest/migration-test.c | 143 ++++++++++++++++++-----------------
  1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index bd9f4b9dbb..bf4d000b76 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Regards,
Het Gala
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'm wondering whether we should leave the existing tests untouched and
require the new format only for new tests. Going through a git bisection
with a change in the middle that alters test names would be infuriating.</pre>
    </blockquote>
    <font face="monospace">Hmm yup. I had this doubt on, how would we be
      enforcing the new design<br>
      for any new qtests that gets added from now on ?<br>
      Can we have this design started for validation tests maybe for
      now, the<br>
      number is low and might get some feedback to improve this ?<br>
      <br>
      <br>
      Regards,<br>
      Het Gala</font><span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------HObxJJxg0kshhoi9OvIToPrf--

