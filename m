Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA18C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 07:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchFW-0004lk-NO; Wed, 21 Feb 2024 02:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rchFU-0004lH-HD
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:42:36 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rchFQ-0003TP-GJ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:42:36 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41KJBe7U006712; Tue, 20 Feb 2024 23:42:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=wU62Ptm7wLwh
 b8jvGasnY9XVm8eQu/QOL9HDV6X98JM=; b=ddd4V1UX4Lg7EkHBot88eyPKDE3i
 rkz+piSr/foFnbKRjYBQlaKrsweAxjsz8k7lMFV//L3mzivUOMjA1kLQJs/LVEyQ
 tVUUqqLSu0mjgADsdng3ZW+3Jf4z7dbYPlXjHbjUM9RKLiMlKfwGWmzFqz5cs2uF
 6bFXsocb1xRjWVs39rG1RbAJ4PRuZ3lg2MO/N1Fwr+6emWWsvlhvBcUv4B3wNa1F
 WsF/elqKGMwM0eYOEGx7x5AJKHWhaU5BNRpRfkNy6bfHbruRbhOokYsOT9aCv3Ve
 /RzxUUC4GWkcRqqTYqwI5Xh6MSM06dI9Fu5sEYaux2aHyHgFgnDktUXTRg==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wd218hesd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 23:42:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGKRm1IS9rMcJh6TcQIkpkMGyOMxtwxcF2c5XLB/g7iMN9lRDGJsdLze17M7OKL1s5HMaC5m6v8DX0WarwGJaXwjMeYDuwdPVgn0xc5p1vQ6Bu1G7d95i42lyJD4Byz/6kG47SKVj3lhWbs9TTlTfWuTxv/42rXCRBZwuVUFtIkXjfY+qfScfKIiNA15kA3/Jj8D6ebWqjeRWME4wtXYaw0dZi5QmOE3VLm1DQ6/nR+Tt3Ss52D4kkZ9nFzZNeg0hl6+PmOYI6Osng+P6tttdxOCFW1bRCSudDPn1IJ1zeyvGDMP5qyCOh4sUwQ0GG2JCCCRtREUALSjyZi/ppZt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU62Ptm7wLwhb8jvGasnY9XVm8eQu/QOL9HDV6X98JM=;
 b=N6092VbRe5mbBW1otPvKfVrhrLfXBGPPnNziUYVNoZZOxv2XVTef8nRTrKCNdv13c3GHluINsuTqWGsSwlVRJIvxrUAdyr8yMbMj8gBQ3Jsxp5pHDumJpw0x9lILaLXif+2kD85KaFhIGIGT1D9+0+zZ4jRHeL8D1sUK5Od2nYRGUO16cNvH6AIERiQn88yg7IexDZzApmIK4l6L+0f8upI53MblXj9M2SG11pC3RXozLxnF2Nm9KRZbWlHWuB0JdSZhVe8Zz2H4FIOzopOdMfxSle1880mzWYLFuSTIJTmPTHibjCpvyQorWp/KFaC6XqRUerYVKQMSLdpgdh4WDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU62Ptm7wLwhb8jvGasnY9XVm8eQu/QOL9HDV6X98JM=;
 b=kHoiaqOZ7Jeac5RASsawGILV8Y+cdSND2ZWzQC/LAmhIbZaDPKkhhjPT5dkQAVBFj2i/v3XA/PCyDpyZBMJs+OzrRPeoC65pTSNzrFhfuBsBXtn6AdQmxlwij+NdNvQ7hzk961F7J1fFhV+u/X64duCKuPWNXmxQa03KBEG0U53C/ccAGH704IMrhAfCU/zgvgpMOR12wiJfBJIpIVhYdwzWSQcYLayFnJDHvuT0uoXT+OwXmudMxl3D82F3zAZRvqXRUgDSXDoIQNu6vvu9SsHnWyy/WlbYAaJKNHrdDx4tOGy8fgTS8YtWmc9+Q8KxG1o8tBO2XLN7AwVqyIwJ/A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 07:42:24 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 07:42:24 +0000
Content-Type: multipart/alternative;
 boundary="------------QjgGzHpdZD0pTsCQoHTd8cdf"
Message-ID: <b692e737-41ba-4404-915b-2cd11e320747@nutanix.com>
Date: Wed, 21 Feb 2024 13:12:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qtest: migration: Enhance qtest migration functions
 to support 'channels' argument
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>
References: <20240216090624.75445-1-het.gala@nutanix.com>
 <20240216090624.75445-2-het.gala@nutanix.com> <ZdRAo3XJ9xvs6Z4Q@x1n>
 <SJ2PR02MB9955B1E7FDF128EE745F121E98502@SJ2PR02MB9955.namprd02.prod.outlook.com>
 <ZdVe2lC0xkxGgGJy@x1n>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZdVe2lC0xkxGgGJy@x1n>
X-ClientProxiedBy: MA0PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::19) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM8PR02MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 4852a0f1-e491-4d6e-7785-08dc32b0a4c9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55Og7ef6UbdhDKhTof4oalsiygGWxT9yUlB+NXRh4hiaFFcaiIM+szcvFpzXkOPNkSNBEZNpFmL2ABLPHbtr+A46rH26463zuHiQmxtI1qpUuR5FCyTyA9gk+rrlJyjndMHLnMl4eRLOs8p1KfrBQ3kCjWPAPxJcheTsHg7ddzvTIjGCKqAELfHppqZb9a+rbczDya5JDd5rB4aiqJZfSFF+gQ4L19bRttvtq693R7rNN0KfeN/0HfTkS2n1mJGTu7IYIff96aPHJqib6PjfOYkGBJ0fMll0nq6uD7yGlyZHooAVb2yrbwqVzlSehUoWLV3WAyifiAkqb4zAssxNtaqJDS4dDgRub9TXiY/dC3dEGSTE38+/h/k1FeUzI+PHGy/UmhtfiVq8drw58+FyEAjTDA25N6RE+UYA4p3NKWDnwb/D8djiP4/JBnipvLV7tA5qZxLavI70AZ82IpYkUSqsrXttuINePV8rACQH7t68wszqgJ/GikROcQ13S0a9hyaSEzOYbeCHhLuwTNfRwBi0Dd75Ep3PHR00ZrAw+iQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9tTk9ZM0J5RHR2czRkd0lsL3UvV24ySTVCTmpJSm42VVVPRXBhcWM0N3Fp?=
 =?utf-8?B?b3dndzhQTGdJUFptVnJGRUcweWVzZWJDaG1iWEVkMVpCcGdJVEM4ckkxckFF?=
 =?utf-8?B?cTdQMXZsNEV4dFBFSHZkNEsyV2QzblFiUnROVE52WWxKTGtmbXhad3AzeXpo?=
 =?utf-8?B?QStySjRmcnphVEUwSURIWi9yeW0xR3lIbnJwcHN6N21qN3Y3bVlTZGs0cGVE?=
 =?utf-8?B?T1F0YVRBZUpWRTlWbHJpY3M4ZWJ5NTU1dTFQT3dyWHpLTitYN2Fjekp3cHdJ?=
 =?utf-8?B?Vkp0NGdpQ1hJdjJCR09VcXQ0b2w1SnRSazZhQzFsS2taWmxlMFhwVXVwMWpL?=
 =?utf-8?B?cXF1R1lwT3lyaVg3TVdNa1FqeFd0YlRZanFXdHo3b25JSnFJMkRNTk9yWWF2?=
 =?utf-8?B?Rm05QTg0anlVdk5zTHI2M25ObXl4ck9YUUZpeXgwMXhVZG80ajFYSjVJQ1hD?=
 =?utf-8?B?T1lpcDc3ZVl1QVpqOUVsUVJNcHZNYWoyeFNuQW0xSzJ4SUQwOGdydzNvd2kv?=
 =?utf-8?B?N0NXM3hOeHRYQ2Q1dlR1MHRxNjlzbjdTVUlIczVmbU1vSEN4bS9Ta2FXUHdO?=
 =?utf-8?B?WHZKQTNpUHF6cnd1TlJHS21uTHc4WDhIOHNXV3U3ODhIeWgxQndWOTNKemRL?=
 =?utf-8?B?Sld4ejB6aWg3ZC9sTU1DalJXSGg3ckJpdm1ldE5JV2xpRXRCZXMyWkNKVmk0?=
 =?utf-8?B?VW95MTN0UDFBb1F3TndqNjlzNEtUS0IxdnVrdXJWR3pTak1QakNVRHd6eFBs?=
 =?utf-8?B?aGU3TGV6Y204cHFvd1QzMzJxaTNpT21KTUVGODhPUCtMdDJObVI0UWNRa25k?=
 =?utf-8?B?ZVltMG4zMG5pUnRvMUdjSlBMbVNkS1ZKR2RYK2JIMFVvSHFBQzBvQ0FuUGNn?=
 =?utf-8?B?eFRHa2g3WHhIWmlJYkJwczRpN1JYU2g1T2NmeXBxNk5IN2VqaCtGL3hEMnJY?=
 =?utf-8?B?VU1lY2R0S012dmtRR3E0V05iU1FmU1pUOHJ1dE5LQWl1SStpTWVxb1NUQXNr?=
 =?utf-8?B?NCtmeEFGYnpZQStPT1lualZlSi9zNFFaVi95VWJFclFBWG02R1NzYmtMd0VR?=
 =?utf-8?B?bk85NU1vamNhR1AzTStvV2ljMUJzUE43c3NBRVpvaDZLSzBrNlJYb05iTlN5?=
 =?utf-8?B?SFZ2V3o0RjB4MDVvUks5UStINkRYL0tiZHMyTGZJclNnc3lhb2VvQW1ReTkz?=
 =?utf-8?B?dGZEaVl5YmtvQTNCclBsWFFaQWs1bURwYXVsZkZYV3N4RHQvVzhkbDBNYU0x?=
 =?utf-8?B?OHAzOXJDTzhZU1RHMGI0QkhUM3F3dmhBZ2hMUDdrSjRVWkh3cFJpOGVNMVo4?=
 =?utf-8?B?V2t6Z2hmUGpaS2N5NkhhaTlnbFBBTVRwZDliRVg2VklDM2Vsdk5rVUVUTFZU?=
 =?utf-8?B?VVRONVUrSDc4dlZMMkNwdXNoTVVDeDZGREZVdlJKc2VxdStYdHVCOE9nVXpM?=
 =?utf-8?B?ZkxBM0ZEVHAyWnpIZTJrblJnUkYwcTBRQ0NKdzZUOFg1eHZQM1JCc3BXYXdQ?=
 =?utf-8?B?WlRLU045N0FEM1hIeDdwL1dwa2ZrVE9jZUlDN1dSUUVPVU9Sc1BGRnA4d2J1?=
 =?utf-8?B?STB3UGJBYnJVUjg0M21OS3JGVFdNYTJwMVpIdGVuZ2JnUG5KZkxlTEtCMHN1?=
 =?utf-8?B?ai92WlQ0VG8vRVdlYUdpVFNvTlNPMzZ5TDI0TU0zSGRxR2hwbE5lalpuOVBV?=
 =?utf-8?B?QnFRdU1INTVmcWM4Ym1UWkxWdFQydnRJb0F1cEF1NXU3dlVjSHVUTW9zVTlF?=
 =?utf-8?B?bU9oOWd5NmpnT3FwYU9VOFB6WEg0SWJhRnlnUXRNaUh6dmZOOXN4VzF6a3lV?=
 =?utf-8?B?d3NZcnBkbG9aYlhBcURUZlJKTE9MbzRNZUFFUjhYd0hnSWxVcGEyM3ZpQzRR?=
 =?utf-8?B?dEkyL0FTdXcvSXZQcUxZR3k0K0xDbGxUM0REc0Y5aWdmTzdVQ005cm5wblNj?=
 =?utf-8?B?WTlSdXNONTJ3MTU4OG1zeWt1MmpPTFhpaUxyd0lwT25pMTh5clFHTGNVekJR?=
 =?utf-8?B?dnphNWlHcjQ4eUQ0ajNiWUp4L2QzTk5mZytDSFF0MjBCbkUxUFNwNDc5Y3pZ?=
 =?utf-8?B?UjJTR1JZNWdWcUdWd3k1UDY3aVRzemVmV1FsTnNrRUI1bUZnWWpBRDdRNS84?=
 =?utf-8?Q?6n8owDgTouyS/tV9i014B9oWB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4852a0f1-e491-4d6e-7785-08dc32b0a4c9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 07:42:24.3012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnPvJhlQw7+f5p097NMJJ8FSh02NVEwOYhBSwZCX9boquq+YCU1Lu2yITEVPfnhqObbqSycZJ4SOsUGas06qFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-ORIG-GUID: SKzap6TVFhapNJbubiL9bQISVIX6-lq9
X-Proofpoint-GUID: SKzap6TVFhapNJbubiL9bQISVIX6-lq9
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

--------------QjgGzHpdZD0pTsCQoHTd8cdf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 21/02/24 7:54 am, Peter Xu wrote:
> On Tue, Feb 20, 2024 at 06:14:46PM +0000, Het Gala wrote:
>>
>> From: Peter Xu<peterx@redhat.com>
>> Date: Tuesday, 20 February 2024 at 11:33 AM
>> To: Het Gala<het.gala@nutanix.com>
>> Cc:qemu-devel@nongnu.org  <qemu-devel@nongnu.org>,armbru@redhat.com  <armbru@redhat.com>,berrange@redhat.com  <berrange@redhat.com>,farosas@suse.de  <farosas@suse.de>
>> Subject: Re: [PATCH 1/3] qtest: migration: Enhance qtest migration functions to support 'channels' argument
>> On Fri, Feb 16, 2024 at 09:06:22AM +0000, Het Gala wrote:
>>> Introduce support for adding a 'channels' argument to migrate_qmp_fail
>>> and migrate_qmp functions within the migration qtest framework, enabling
>>> enhanced control over migration scenarios.
>>>
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> ---
>>>   tests/qtest/dbus-vmstate-test.c |  2 +-
>>>   tests/qtest/migration-helpers.c | 93 ++++++++++++++++++++++++++++++---
>>>   tests/qtest/migration-helpers.h | 11 ++--
>>>   tests/qtest/migration-test.c    | 33 ++++++------
>>>   4 files changed, 112 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
>>> index 6c990864e3..0ca572e29b 100644
>>> --- a/tests/qtest/dbus-vmstate-test.c
>>> +++ b/tests/qtest/dbus-vmstate-test.c
>>> @@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)
>>>
>>>       thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
>>>
>>> -    migrate_qmp(src_qemu, uri, "{}");
>>> +    migrate_qmp(src_qemu, uri, NULL, "{}");
>>>       test->src_qemu = src_qemu;
>>>       if (test->migrate_fail) {
>>>           wait_for_migration_fail(src_qemu, true);
>>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>>> index e451dbdbed..d153677887 100644
>>> --- a/tests/qtest/migration-helpers.c
>>> +++ b/tests/qtest/migration-helpers.c
>>> @@ -13,6 +13,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qemu/ctype.h"
>>>   #include "qapi/qmp/qjson.h"
>>> +#include "qapi/qmp/qlist.h"
>>>
>>>   #include "migration-helpers.h"
>>>
>>> @@ -43,7 +44,70 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
>>>       return false;
>>>   }
>>>
>>> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
>>> +static char *socketAddressType_to_str(SocketAddressType type)
>>> +{
>>> +    switch (type) {
>>> +    case SOCKET_ADDRESS_TYPE_INET:
>>> +        return g_strdup("inet");
>>> +    case SOCKET_ADDRESS_TYPE_UNIX:
>>> +        return g_strdup("unix");
>>> +    case SOCKET_ADDRESS_TYPE_FD:
>>> +        return g_strdup("fd");
>>> +    case SOCKET_ADDRESS_TYPE_VSOCK:
>>> +        return g_strdup("vsock");
>>> +    default:
>>> +        return g_strdup("unknown address type");
>>> +    }
>>> +}
>> Use SocketAddressType_lookup?
>> Ack, I guess combination of using qapi_enum_parse() and qapi_enum_lookup() would help me eliminate the need for creating this function itself. Let me do the changes in the next patch.  Thanks!
> Ah, what I wanted to say was actually SocketAddressType_str.
Oh okay, got it !
>>> +
>>> +static QList *MigrationChannelList_to_QList(MigrationChannelList *channels)
>>> +{
>>> +    MigrationChannel *channel = NULL;
>>> +    MigrationAddress *addr = NULL;
>>> +    SocketAddress *saddr = NULL;
>>> +    g_autofree const char *addr_type = NULL;
>>> +    QList *channelList = qlist_new();
>>> +    QDict *channelDict = qdict_new();
>>> +    QDict *addrDict = qdict_new();
>>> +
>>> +    channel = channels->value;
>>> +    if (!channel || channel->channel_type == MIGRATION_CHANNEL_TYPE__MAX) {
>>> +        fprintf(stderr, "%s: Channel or its type is NULL\n",
>>> +                __func__);
>>> +    }
>>> +    g_assert(channel);
>>> +    if (channel->channel_type == MIGRATION_CHANNEL_TYPE_MAIN) {
>>> +        qdict_put_str(channelDict, "channel-type", g_strdup("main"));
>>> +    }
>>> +
>>> +    addr = channel->addr;
>>> +    if (!addr || addr->transport == MIGRATION_ADDRESS_TYPE__MAX) {
>>> +        fprintf(stderr, "%s: addr or its transport is NULL\n",
>>> +                __func__);
>>> +    }
>>> +    g_assert(addr);
>>> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>>> +        qdict_put_str(addrDict, "transport", g_strdup("socket"));
>>> +    }
>>> +
>>> +    saddr = &addr->u.socket;
>>> +    if (!saddr) {
>>> +        fprintf(stderr, "%s: saddr is NULL\n", __func__);
>>> +    }
>>> +    g_assert(saddr);
>>> +    addr_type = socketAddressType_to_str(saddr->type);
>>> +    qdict_put_str(addrDict, "type", addr_type);
>>> +    qdict_put_str(addrDict, "port", saddr->u.inet.port);
>>> +    qdict_put_str(addrDict, "host", saddr->u.inet.host);
>>> +
>>> +    qdict_put_obj(channelDict, "addr", QOBJECT(addrDict));
>>> +    qlist_append_obj(channelList, QOBJECT(channelDict));
>>> +
>>> +    return channelList;
>>> +}
>>> +
>>> +void migrate_qmp_fail(QTestState *who, const char *uri,
>>> +                      MigrationChannelList *channels, const char *fmt, ...)
>>>   {
>>>       va_list ap;
>>>       QDict *args, *err;
>>> @@ -52,8 +116,16 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
>>>       args = qdict_from_vjsonf_nofail(fmt, ap);
>>>       va_end(ap);
>>>
>>> -    g_assert(!qdict_haskey(args, "uri"));
>>> -    qdict_put_str(args, "uri", uri);
>>> +    if (uri) {
>>> +        g_assert(!qdict_haskey(args, "uri"));
>> IMHO we don't need to assert here?
>>
>> Rather than doing this, we can also have tests covering when both are set,
>> or when none are set, to make sure we fail properly in those wrong cases.
>> (Neglecting your comments here based on Patch 3/3 comment).
>>
>>> +        qdict_put_str(args, "uri", uri);
>>> +    }
>>> +
>>> +    if (channels) {
>>> +        g_assert(!qdict_haskey(args, "channels"));
>>> +        QList *channelList = MigrationChannelList_to_QList(channels);
>>> +        qdict_put_obj(args, "channels", QOBJECT(channelList));
>>> +    }
>>>
>>>       err = qtest_qmp_assert_failure_ref(
>>>           who, "{ 'execute': 'migrate', 'arguments': %p}", args);
>>> @@ -68,7 +140,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
>>>    * Arguments are built from @fmt... (formatted like
>>>    * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
>>>    */
>>> -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
>>> +void migrate_qmp(QTestState *who, const char *uri,
>>> +                 MigrationChannelList *channels, const char *fmt, ...)
>>>   {
>>>       va_list ap;
>>>       QDict *args;
>>> @@ -77,8 +150,16 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
>>>       args = qdict_from_vjsonf_nofail(fmt, ap);
>>>       va_end(ap);
>>>
>>> -    g_assert(!qdict_haskey(args, "uri"));
>>> -    qdict_put_str(args, "uri", uri);
>>> +    if (uri) {
>>> +        g_assert(!qdict_haskey(args, "uri"));
>>> +        qdict_put_str(args, "uri", uri);
>>> +    }
>>> +
>>> +    if (channels) {
>>> +        g_assert(!qdict_haskey(args, "channels"));
>>> +        QList *channelList = MigrationChannelList_to_QList(channels);
>>> +        qdict_put_obj(args, "channels", QOBJECT(channelList));
>>> +    }
>> Duplicated chunks; sign of adding some helper?
>> I didn’t think of adding a helper function here as it was just 2 lines of code, already calling MigrationChannelList_to_QList() to avoid duplication. Even then if you have something in your mind to create some helper function, please suggest :)
> migrate_qmp_attach_ports(QDict *args, const char *uri,
>                           MigrationChannelList *channels)
> {
>      if (uri) {
>          g_assert(!qdict_haskey(args, "uri"));
>          qdict_put_str(args, "uri", uri);
>      }
>
>      if (channels) {
>          g_assert(!qdict_haskey(args, "channels"));
>          QList *channelList = MigrationChannelList_to_QList(channels);
>          qdict_put_obj(args, "channels", QOBJECT(channelList));
>      }
> }
>
> If you plan to work on migrate_incoming_qmp(), it'll also be reusable
> there.
Ack, thanks!
>>>       qtest_qmp_assert_success(who,
>>>                                "{ 'execute': 'migrate', 'arguments': %p}", args);
>>> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
>>> index 3bf7ded1b9..52243bd2df 100644
>>> --- a/tests/qtest/migration-helpers.h
>>> +++ b/tests/qtest/migration-helpers.h
>>> @@ -14,6 +14,7 @@
>>>   #define MIGRATION_HELPERS_H
>>>
>>>   #include "libqtest.h"
>>> +#include "migration/migration.h"
>>>
>>>   typedef struct QTestMigrationState {
>>>       bool stop_seen;
>>> @@ -25,15 +26,17 @@ typedef struct QTestMigrationState {
>>>   bool migrate_watch_for_events(QTestState *who, const char *name,
>>>                                 QDict *event, void *opaque);
>>>
>>> -G_GNUC_PRINTF(3, 4)
>>> -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
>>> +G_GNUC_PRINTF(4, 5)
>>> +void migrate_qmp(QTestState *who, const char *uri,
>>> +                 MigrationChannelList *channels, const char *fmt, ...);
>>>
>>>   G_GNUC_PRINTF(3, 4)
>>>   void migrate_incoming_qmp(QTestState *who, const char *uri,
>>>                             const char *fmt, ...);
>> Just thinking, should also add ‘channels’ argument here I guess, would be helpful in future to add some tests where only ‘channels’ parameter wants to be added to the function ?
> Sounds good.
>
> Thanks,

Regards,

Het Gala

--------------QjgGzHpdZD0pTsCQoHTd8cdf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 21/02/24 7:54 am, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZdVe2lC0xkxGgGJy@x1n">
      <pre class="moz-quote-pre" wrap="">On Tue, Feb 20, 2024 at 06:14:46PM +0000, Het Gala wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

From: Peter Xu <a class="moz-txt-link-rfc2396E" href="mailto:peterx@redhat.com">&lt;peterx@redhat.com&gt;</a>
Date: Tuesday, 20 February 2024 at 11:33 AM
To: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:qemu-devel@nongnu.org">&lt;qemu-devel@nongnu.org&gt;</a>, <a class="moz-txt-link-abbreviated" href="mailto:armbru@redhat.com">armbru@redhat.com</a> <a class="moz-txt-link-rfc2396E" href="mailto:armbru@redhat.com">&lt;armbru@redhat.com&gt;</a>, <a class="moz-txt-link-abbreviated" href="mailto:berrange@redhat.com">berrange@redhat.com</a> <a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>, <a class="moz-txt-link-abbreviated" href="mailto:farosas@suse.de">farosas@suse.de</a> <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
Subject: Re: [PATCH 1/3] qtest: migration: Enhance qtest migration functions to support 'channels' argument
On Fri, Feb 16, 2024 at 09:06:22AM +0000, Het Gala wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Introduce support for adding a 'channels' argument to migrate_qmp_fail
and migrate_qmp functions within the migration qtest framework, enabling
enhanced control over migration scenarios.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
---
 tests/qtest/dbus-vmstate-test.c |  2 +-
 tests/qtest/migration-helpers.c | 93 ++++++++++++++++++++++++++++++---
 tests/qtest/migration-helpers.h | 11 ++--
 tests/qtest/migration-test.c    | 33 ++++++------
 4 files changed, 112 insertions(+), 27 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 6c990864e3..0ca572e29b 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)

     thread = g_thread_new(&quot;dbus-vmstate-thread&quot;, dbus_vmstate_thread, loop);

-    migrate_qmp(src_qemu, uri, &quot;{}&quot;);
+    migrate_qmp(src_qemu, uri, NULL, &quot;{}&quot;);
     test-&gt;src_qemu = src_qemu;
     if (test-&gt;migrate_fail) {
         wait_for_migration_fail(src_qemu, true);
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index e451dbdbed..d153677887 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -13,6 +13,7 @@
 #include &quot;qemu/osdep.h&quot;
 #include &quot;qemu/ctype.h&quot;
 #include &quot;qapi/qmp/qjson.h&quot;
+#include &quot;qapi/qmp/qlist.h&quot;

 #include &quot;migration-helpers.h&quot;

@@ -43,7 +44,70 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     return false;
 }

-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+static char *socketAddressType_to_str(SocketAddressType type)
+{
+    switch (type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        return g_strdup(&quot;inet&quot;);
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        return g_strdup(&quot;unix&quot;);
+    case SOCKET_ADDRESS_TYPE_FD:
+        return g_strdup(&quot;fd&quot;);
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        return g_strdup(&quot;vsock&quot;);
+    default:
+        return g_strdup(&quot;unknown address type&quot;);
+    }
+}
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Use SocketAddressType_lookup?
Ack, I guess combination of using qapi_enum_parse() and qapi_enum_lookup() would help me eliminate the need for creating this function itself. Let me do the changes in the next patch.  Thanks!
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Ah, what I wanted to say was actually SocketAddressType_str.</pre>
    </blockquote>
    Oh okay, got it !<span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZdVe2lC0xkxGgGJy@x1n">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+
+static QList *MigrationChannelList_to_QList(MigrationChannelList *channels)
+{
+    MigrationChannel *channel = NULL;
+    MigrationAddress *addr = NULL;
+    SocketAddress *saddr = NULL;
+    g_autofree const char *addr_type = NULL;
+    QList *channelList = qlist_new();
+    QDict *channelDict = qdict_new();
+    QDict *addrDict = qdict_new();
+
+    channel = channels-&gt;value;
+    if (!channel || channel-&gt;channel_type == MIGRATION_CHANNEL_TYPE__MAX) {
+        fprintf(stderr, &quot;%s: Channel or its type is NULL\n&quot;,
+                __func__);
+    }
+    g_assert(channel);
+    if (channel-&gt;channel_type == MIGRATION_CHANNEL_TYPE_MAIN) {
+        qdict_put_str(channelDict, &quot;channel-type&quot;, g_strdup(&quot;main&quot;));
+    }
+
+    addr = channel-&gt;addr;
+    if (!addr || addr-&gt;transport == MIGRATION_ADDRESS_TYPE__MAX) {
+        fprintf(stderr, &quot;%s: addr or its transport is NULL\n&quot;,
+                __func__);
+    }
+    g_assert(addr);
+    if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        qdict_put_str(addrDict, &quot;transport&quot;, g_strdup(&quot;socket&quot;));
+    }
+
+    saddr = &amp;addr-&gt;u.socket;
+    if (!saddr) {
+        fprintf(stderr, &quot;%s: saddr is NULL\n&quot;, __func__);
+    }
+    g_assert(saddr);
+    addr_type = socketAddressType_to_str(saddr-&gt;type);
+    qdict_put_str(addrDict, &quot;type&quot;, addr_type);
+    qdict_put_str(addrDict, &quot;port&quot;, saddr-&gt;u.inet.port);
+    qdict_put_str(addrDict, &quot;host&quot;, saddr-&gt;u.inet.host);
+
+    qdict_put_obj(channelDict, &quot;addr&quot;, QOBJECT(addrDict));
+    qlist_append_obj(channelList, QOBJECT(channelDict));
+
+    return channelList;
+}
+
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      MigrationChannelList *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -52,8 +116,16 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);

-    g_assert(!qdict_haskey(args, &quot;uri&quot;));
-    qdict_put_str(args, &quot;uri&quot;, uri);
+    if (uri) {
+        g_assert(!qdict_haskey(args, &quot;uri&quot;));
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
IMHO we don't need to assert here?

Rather than doing this, we can also have tests covering when both are set,
or when none are set, to make sure we fail properly in those wrong cases.
(Neglecting your comments here based on Patch 3/3 comment).

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+        qdict_put_str(args, &quot;uri&quot;, uri);
+    }
+
+    if (channels) {
+        g_assert(!qdict_haskey(args, &quot;channels&quot;));
+        QList *channelList = MigrationChannelList_to_QList(channels);
+        qdict_put_obj(args, &quot;channels&quot;, QOBJECT(channelList));
+    }

     err = qtest_qmp_assert_failure_ref(
         who, &quot;{ 'execute': 'migrate', 'arguments': %p}&quot;, args);
@@ -68,7 +140,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
  * Arguments are built from @fmt... (formatted like
  * qobject_from_jsonf_nofail()) with &quot;uri&quot;: @uri spliced in.
  */
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp(QTestState *who, const char *uri,
+                 MigrationChannelList *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
@@ -77,8 +150,16 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);

-    g_assert(!qdict_haskey(args, &quot;uri&quot;));
-    qdict_put_str(args, &quot;uri&quot;, uri);
+    if (uri) {
+        g_assert(!qdict_haskey(args, &quot;uri&quot;));
+        qdict_put_str(args, &quot;uri&quot;, uri);
+    }
+
+    if (channels) {
+        g_assert(!qdict_haskey(args, &quot;channels&quot;));
+        QList *channelList = MigrationChannelList_to_QList(channels);
+        qdict_put_obj(args, &quot;channels&quot;, QOBJECT(channelList));
+    }
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Duplicated chunks; sign of adding some helper?
I didn’t think of adding a helper function here as it was just 2 lines of code, already calling MigrationChannelList_to_QList() to avoid duplication. Even then if you have something in your mind to create some helper function, please suggest :)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
migrate_qmp_attach_ports(QDict *args, const char *uri,
                         MigrationChannelList *channels)
{
    if (uri) {
        g_assert(!qdict_haskey(args, &quot;uri&quot;));
        qdict_put_str(args, &quot;uri&quot;, uri);
    }

    if (channels) {
        g_assert(!qdict_haskey(args, &quot;channels&quot;));
        QList *channelList = MigrationChannelList_to_QList(channels);
        qdict_put_obj(args, &quot;channels&quot;, QOBJECT(channelList));
    }
}

If you plan to work on migrate_incoming_qmp(), it'll also be reusable
there.
</pre>
    </blockquote>
    Ack, thanks!<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZdVe2lC0xkxGgGJy@x1n">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
     qtest_qmp_assert_success(who,
                              &quot;{ 'execute': 'migrate', 'arguments': %p}&quot;, args);
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 3bf7ded1b9..52243bd2df 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -14,6 +14,7 @@
 #define MIGRATION_HELPERS_H

 #include &quot;libqtest.h&quot;
+#include &quot;migration/migration.h&quot;

 typedef struct QTestMigrationState {
     bool stop_seen;
@@ -25,15 +26,17 @@ typedef struct QTestMigrationState {
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);

-G_GNUC_PRINTF(3, 4)
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp(QTestState *who, const char *uri,
+                 MigrationChannelList *channels, const char *fmt, ...);

 G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
                           const char *fmt, ...);
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Just thinking, should also add ‘channels’ argument here I guess, would be helpful in future to add some tests where only ‘channels’ parameter wants to be added to the function ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Sounds good.

Thanks,
</pre>
    </blockquote>
    <p>Regards,</p>
    <p>Het Gala<br>
    </p>
    <blockquote type="cite" cite="mid:ZdVe2lC0xkxGgGJy@x1n">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------QjgGzHpdZD0pTsCQoHTd8cdf--

