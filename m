Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37C0EDF151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqZf-0006Ex-QI; Fri, 13 Feb 2026 05:38:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqZd-0006EX-Cu
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:38:57 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqZZ-0003i2-Hl
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:38:57 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9tvRU752405; Fri, 13 Feb 2026 02:38:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MlBxAx++y2TBBBJTlvTgpMyggdoA/KscVff6pYY2Z
 bM=; b=XIA0qoAQoAQPwNxZYiHBPxafS0efkwT83ALxFFl1+2046fsy0uYEdYK1F
 XuTQT2PfpnoyuLjQ4Zg5nvUf+gEYTNa91P4r/6iDzRs8JopqAhIkq/CZ8hJ4FXVA
 eLRQp7MHNZfJWQ8CW/J6+5s07ux/EqKflbGavcjNLmgFr5Gfai1ZMt5t5djXxx5H
 mhA4+dcDSv1/69XK7s9m1PMAMgSUR2q7iBNqtwHHzwbXY6aN4sJRUkl/QkRu+SQ9
 m6bK5g9GyCwIFjjh58KiCAmB4JEPN6Im0Jllhw6q22Ox8V6Ap4q92fhyYHLgrd9B
 TuRbwM0tz4CcY7ytJHEYHMMZTe0Hw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020099.outbound.protection.outlook.com [52.101.85.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8ctc8p7y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:38:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow9qQT1ia4j6h13g9Zny5qwhrHYLiVFu1ynFJ1BBxHuyKCd+OXD1Wsq/MlaF52AG6BP2xeKPNWs/JTO6+Gd6dsKmLVLmku5HBgubviWB7kogecY/90GXyxWUdXXHUcZ0laKxLWadDj/BtZ4dmlrc0zG5jlAaJeuRNC7rNRA7XJLk0klKPDgRzvRyxX7Cp2AZNsHwz2aRKT1zv2JhmVPghoBQipwhwNVrbvk1CvSw3rNsQgEJgF6aIME3c0LePo2zAgU7OF36vfDkKl4mYl3BXw+C58KEeyvUI+a5xGC8mK6r6DaoDWNQI7/5n0zKw/fQkzxBcpuLKPZ5h93L4do+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlBxAx++y2TBBBJTlvTgpMyggdoA/KscVff6pYY2ZbM=;
 b=EKB0xrhYzUcWUtwJOgmwI7/5Z6Sd/xpaOKX03+4YBYPtudM+GySqiwgGlZsa7qM9epO1wsytQNtoPwPqmfoqFLhEGvWVH3nT6q7+8j4CvtB13kPSO/fEIQuafO6/KhxHv/asBDqKtCte1wrPNRM2lXkV6GY0iavwmvbfoTYag7qEG62VLfnett7YgB/mhiF30tK69s8lD6Are5YqwcQoxCUq9RRPCJaZf5XP8IjxKpsi1IAU69GuNgRgAIy/pwqX9RlTmsif+7EaTGzjbt9YlVcUKc+OFY9NgL5D8enV2mysOp5QFQG6pvaNbjdn3gNh3kjmzCZPplYJFvkFGrAP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlBxAx++y2TBBBJTlvTgpMyggdoA/KscVff6pYY2ZbM=;
 b=lbD789FtsUHrOmGhpkuNu01OqV3c8QUxhFlAEWtjZc7WTFCnV+a8UWhb2ERnhDBTPgeijF2uYCo1DqH075kwnCRd4fWIo0OS9twG7zd826i+UftVdqVjAjBDgHB8PIqU9eDUUjrFdoxNEdetN795FKq901Dtx8SUU5pL146/tVHUTEBBumQZt9prPOh5wkj8HCKzQOeSdRgOZk9Ci/XiEXOxJf+OJciTEPAosA+BZsiEqRzyL4vhxZzlldYyaLsdHb71N2AAiphTjGfheJ6NbirkBOt1ZkyLW9xuUO3Cr/GIY8uWMkaCgfX3g7XX2S3vrjZyNGzBZkhupVVJo8PkVQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8618.namprd02.prod.outlook.com (2603:10b6:303:15d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:38:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:38:42 +0000
Message-ID: <6fdc2bfb-e156-4a42-b32c-381728b4781a@nutanix.com>
Date: Fri, 13 Feb 2026 10:38:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/43] audio: remove audio_driver
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-16-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8618:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b5615e-64b3-4075-1c23-08de6aec0e74
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHV4MFYyV1NIem1BMzdDMDJNcmFXWENQWWdsOUt0YzUvdzJ0SldjdTl0UjdD?=
 =?utf-8?B?MmlRVWJxWnNMeVozMU14ZWlpYTIxV09Ja09JNGF5V3A1akdtRUdxbkdwWlJK?=
 =?utf-8?B?U1gvblMyUG55b2ZJeFEvRUhQU3ZYNDNnc1oxMU41Ty81U0lUVHQvSWw0THhh?=
 =?utf-8?B?T1RrcURjN2x6QmQ2VGJiWStYQWw1Szc0MlE1L0tPRDJTRGI5M3BBd3hJNklo?=
 =?utf-8?B?VmQyNUZqN2M5WWwvMUFreERnOWtCZHdpcEU4Q1A3bG5mbW8waGlJZkRLZU1W?=
 =?utf-8?B?N1VXOUkvZGJmQkY5SS8zbDJwV245bXc1OWdoT043V1NrOTViMnBSWStTRGpI?=
 =?utf-8?B?cEhLTnVNUzFBUFFvU1c1NTFHRzRKMThOZzkzME0vem8vNEw0Sjd2Y1ptVDdr?=
 =?utf-8?B?OFJRRVB5NlZqS1lCeHZjV1RHS2tBb1BHbmc0cWxSWi9raHhNWGpGdFZHVm43?=
 =?utf-8?B?YVdPY015bWxKNG9oZHcxZTFXQVdJUGFkZnlmdXlRc0w4ZGxwS1NpT0l0OFo4?=
 =?utf-8?B?NW5SVVVUeFRmUitibUZQdG5EVHd1QUU0N0N1VDlKRldjdDAwZVVrNGNDcUxy?=
 =?utf-8?B?c0NlMWdRT2xiK0pWZGN1VExnWDFvcjBUb1l6VHVZaUoxZDhKeCt4S3ZXN0Vh?=
 =?utf-8?B?cWYvbXhsZWRnemZmZG1jNlNYMDk1cE8rS2dheWdldjVtZmFGQzJTcWVvZ2Vw?=
 =?utf-8?B?ZUJxVEJoRlBmUHNzVkV4ZkNKZ1RUREpHRmdaS3NoOGlBdVRCT0dYd2N3bG9t?=
 =?utf-8?B?Y1lXbytNMGRONUMxMUwzTGY0MkhURnM1ckJJR0EvL1VaSkgzQ1dNRkQ2K2JR?=
 =?utf-8?B?VEpzVXlpdjUyNkhJMmVZcWtaR2FWWkM2emM5QWdZNlViNW0zQk8yMUhPT2V1?=
 =?utf-8?B?dnBobmVidnBXUlczb1ppQWlqaGhUSGswNlY4Zm9GTStmaFZKb3FDRlB5Y1Qw?=
 =?utf-8?B?ZG5VVm9BZHQ1dGRtRjJPNjRvb1BvUlJrZ293V3FlajZ6bHFrbFJJRGMxS2li?=
 =?utf-8?B?dk5ocGFXZy9COVQwYzZwVzhjR05QcGlrN3gvMHFBdTc3YXBVTk9zNFo2eGN1?=
 =?utf-8?B?cmFia0VGaEovclJwTGRKa0drYVczTVJDV0JWb3liMXZUYWs4cUNmM1hKRU4z?=
 =?utf-8?B?RFF5RzAyMEYyb0ZCR0k2eVJYK1VuSEVuNmdvenNGUzRCWTVDMGROQVJnV3dM?=
 =?utf-8?B?MTB5YmVrOVJPeDVYRUxUOTNpdkcwd205Q2RPSDRCbXFSNUtvMVQ2UjlSRVZT?=
 =?utf-8?B?Z3lGdTl0VnVOUE94S3paYTFZWFFJSm9sQnVNeVplZWc4YWY5bnRKSTh2MFY0?=
 =?utf-8?B?TGFybUNHc0JrVTl5WUZTMlFlRnd1M2YrWWVBemdSMURNRjdDRkFjKzBZMFF3?=
 =?utf-8?B?aWg0dHA3TGxrYzdDcUNaZklIdlEzMCtiVkxQTVJ6bVUrK2FZL0tWMGVGZ1pr?=
 =?utf-8?B?Y0tQSzBzdHlzY3dBYm9hbFRXRVJRQW1ZN0FNOG92Y1pwaFdNSHltMUhxanFI?=
 =?utf-8?B?Rmo2N1BUaVFtUkExdXlLeGpDYTRrcWVkeDNYUUc3Zis0Z2h2T2R6b0pyY21J?=
 =?utf-8?B?NkU2cENjUDY2LzA4clBIOFpraFc2b3E3bXZ5ajd6THZNK1F3TGxETDhDRnA4?=
 =?utf-8?B?NTVIc1hDb05aTzBzM1BaUEptTVJHQ1dIaHpUWlFCV0ptVGQ0M1lpbXcwK2xI?=
 =?utf-8?B?RWVsTVlmdXJiZ0M2MkVMbFpsWVlQcmFhbDl0c1dOWFBNVnBDQ0w1N1V2YzhY?=
 =?utf-8?B?TWl2OFZUYlpnL0tFNkcrb0htNGlHd2I3WnlBT2RiVm4yZEorbnJ5VzY1ZkU0?=
 =?utf-8?B?UGg1N1RscjBLUERzM0V1cWMzY05UYWdCaGdKQTNWSkkycnY5TEZZZDRINERy?=
 =?utf-8?B?YVpoL1V1azFLWStqNmw3ZXFSckR3OVdYbnhkSEN4TGRUSTZ0Tm8rQ3JuQXo0?=
 =?utf-8?B?WldNTUl5ZFF2MU5Nc0xPc2JpSjZOVVdiVEhROTYyN3d0NFg1YnR4b0FlU2pn?=
 =?utf-8?B?VC9ZWTRwcXJTenRuNDhwb3FpTENSeSsrNlpqaVFqMW9uM3AxRHpwd2tGQ2JR?=
 =?utf-8?B?WjlNNDdta1pRTitVWElhSlJadnhtaUhaQi85RXZiWWRJNmI1MFZadkYzR3pM?=
 =?utf-8?Q?i8Fs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2tqd2NVNXZuZERYZG1kL2orN3NqTm54RU1CZVZaeGorZ2xqRi8rbGZqVWpn?=
 =?utf-8?B?MmFlTU9aMzVFNGVnRnVzTzI2SzFFN3pybThMQWpKMzNpQUZMY1ZVWHVna2xm?=
 =?utf-8?B?MENSOTZudkVxaVFUM2xDRmNWb21wWWFqc3NYQ2VuMGc3Z1BwV0lySGJrdVRR?=
 =?utf-8?B?YUpiTHhCZnMzNlhZVTFSWGpLVElYbm1vaUZsWFhvU3pubU1jb1J0ekU5ajN6?=
 =?utf-8?B?RmlsNHR1RUszdlJva3hqZjFDSGV6ZnI0MU5LMmxoV3MycDM2am5lZHdqNnpR?=
 =?utf-8?B?UTZ4TytBbWtDRmNYS2d1QXNRTUZYYy9PaEhvYUp4bFFrUTNMWmlPQmdWTktH?=
 =?utf-8?B?R1h4TDFXVVVRMEt2UW1pMnJoVzNCajBIb1R1SmNIZEhNU1NqK3prVGdwY2Fs?=
 =?utf-8?B?VW44bWxmRC9yTktaL21UTnAvZHI2a2Vqd041ZlZLNGpJaS9FaHJmRVc5ZG5u?=
 =?utf-8?B?UE1VZGExRWg4dlVqeDFNdnlJNE1GVWEvaFdZYjFwYzljbzdTWUIwc3Q1WEg0?=
 =?utf-8?B?SmRBTHpaTVRNUWNZTUVOOU5mVVpnNFRCZG9aOENpM3ZkckxzeWthcWNDOC9p?=
 =?utf-8?B?aTViQ3BGVWxVZTlTcFc1Z3dwZ21nRSt1S3ZMSjdpUDBORENac0xYYW1UMWxB?=
 =?utf-8?B?cFNhVWZQZGJtejJ1N2dsVVkzbHFpeVJycVk4ZGdIZHZXOGhvdmI0Nlc3dDMy?=
 =?utf-8?B?WXRQSk9mMWJWYlBmUldJR21SZW5KZE55WXFtTnlIbHJZWEd3TkhrUk4rS3la?=
 =?utf-8?B?MEY5OUh0cy9ob2gvYVlIbzMrdU92RWVVVTdQRWhiV0RLZFpDMzk5RzFjLy8r?=
 =?utf-8?B?a2NPSTJsUjF6WXlGUU9ueGlwR3F5UzNtaEFDSnZCZ0pNY3B3WDI4ajMvZmFO?=
 =?utf-8?B?SHJQSU82M29xeFpUaUFjdDFZQ2gwUlE4elIvbTU5bG1Ud3hCWE9tV2xRVThV?=
 =?utf-8?B?RzlBcEUxNkxSTk9ZM3BuT1ZydkVrMjI5N3JaSk1rdmVaeW5rQkNFNjdhZE5R?=
 =?utf-8?B?dU4ybmY3NzlERlI5bHMwNmc2NkU2blc2UllnOS9aSTlmcG5QdVFmQlJLMHV5?=
 =?utf-8?B?ZDBieEhiRUdkUEV1d2M3bE14ZlZUQWZLSEs3eHVQQjViNHpQaU5wNWt6K0VI?=
 =?utf-8?B?Z0hFN3YyWTJVRFFvcThjeFY5R0VhTHV1NGR2bUZ4NU41Y0lNaWNwVk5nMzNX?=
 =?utf-8?B?MjNwcHBkekNPYS81YmxzL0x0VnlJQ1ZoUHlpTHNBRmVIdmQ1Vkg4KzFpNFll?=
 =?utf-8?B?bmVBQ3VUUTk3QkdFUk5HNWprK3Z2UjJkV0hTcVFwSTRoWGM0WGdGTCtjUDhF?=
 =?utf-8?B?d2FqZWdseEVvQmp6QlRsbkF0bEREa2pVSkxKRDhEZ1l5N3duSWJJNTlLVnJD?=
 =?utf-8?B?MEU4dmhVQzFwOFdzNTIrcGdZZ1R3Ym8vWXZhVUxsZERjM3NQQUhrMHRmYzhs?=
 =?utf-8?B?UVZNU0pjais1WENOSVkwZU41Zm90TkNPKzcxMUdIbkg1bjIxZlBkRXdKc0dT?=
 =?utf-8?B?WnBKNktFbkhSOGdsMnpUQ0Z6dXJ5c0ptT2hXSGtDNUd6N010ME1tMjFBWnM3?=
 =?utf-8?B?WDJobXFvTWwxRmRaWVpOM01CRU05N0NxdGpROTQrTU41empBbDVuTHJheENZ?=
 =?utf-8?B?aFNTRHhCRm1wNkRMZTcyQjcyTjNDRkxnUzdueFdIdzMyWmZvMmUycHlJNGdj?=
 =?utf-8?B?c0Y4L2piVjRId1RrTG9ZWGJhMFJUUlV5V2lmc1oxeUIzRnRIeGwxUjBwYVhx?=
 =?utf-8?B?M3ZnV3VHUDFyQXp1anZtQXNPRVBvRzVwODR0UC9BZnRSM3lPUGovQjhYYnV6?=
 =?utf-8?B?SzB2M0lXNDd5Rmp2SVFaTjR1Tis0Q0hVSk9mVWoremNBeEg4VVU2dmdaRWtl?=
 =?utf-8?B?RmZEUVFja2lINmpzNU9YZ3NldjZXR0ZWL24rYWpUaWRpZU12YzhWRTlBVEJY?=
 =?utf-8?B?TEdObi9sQmhjK1hoaVRUU0xQdmRNMWxhSldqUTNmeGlPSC9qN0FqZEp0MWdj?=
 =?utf-8?B?NkN1dmpQRUNpYTZLaVN5dGpmM0JFdC9rb0poZzF0dkFzeTlGU2xZSzZSZW5x?=
 =?utf-8?B?T3QzemxrK1plUHNLQ2NDcUVlRk1iQlJhanVqZlVXeExXRzBrOG5zYVFPWThs?=
 =?utf-8?B?OTk4ZHZScFZrWlZ0OGk0WS9qK0hmWGtyb2xaT0dYVzM5RFV2YnFyMXV2cEVi?=
 =?utf-8?B?blFidUI2TnlkZ2lVUFBWOERSczJTbjJUNUM4L2RtN1NKaUgzT0g4akdaekRh?=
 =?utf-8?B?dkVtNnFWeW1NTitPSTlKcDhRRis4UzBpK25iSHpXbm9MZnRHMlBscjVlVnZC?=
 =?utf-8?B?TU5uQjdsNS9tMGRDWnZWNW1tNFRWTGNUVGpxVzBQNE9wdmFtOVh1a3d2WWx4?=
 =?utf-8?Q?nbgx0gpTXJO94aRM=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b5615e-64b3-4075-1c23-08de6aec0e74
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:38:42.3183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCLkKypHzpi7k9n97FehO/Nv+zPodtHfCme7lfK7Eqf2o/k2p6xh9c39YI7aJlHExue9ZI4MbvmTlDtodErl9e37I2kb56MnJXn5g1G50zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8618
X-Authority-Analysis: v=2.4 cv=Yd+wJgRf c=1 sm=1 tr=0 ts=698eff33 cx=c_pps
 a=GGH+j3rhJf5zTl2H81NwCw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=1bVPidsO81l_PVNai2YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ngJhYXre91YLcIRs3bmfj_p33jfKn6bV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4MiBTYWx0ZWRfX9ma86mUeUhPU
 NLt+mB4jTPxI0pvlG7KY6zqkzhnR0yshB3bxE0qI+e4sm7Zsytu5kEw+HJVGjs/0qlaiuNINbeE
 +zUmdeOTJyi4d09QcY8gL0JPPw3aQQQqG7Omp/jRqobXRx1OJP+L9PG1dFUSgzysFEA+j3rbcCL
 BlB985ArTcliXkWF3M92hn91GcazBgLXgYhxdKDCiF4AAl3BlU5aH6T8gK439f/NQ823fJt/V/3
 uzFObzL7eZHLeHZL4GEze0eHt/xCClPO4DNnvm1RUhqMeuH5Lzncd40N6Tw9GDpq+o6X3UVSaFQ
 ZxCbfS2LBZoRgL4x70kehOqPHKl04S9RYw32+ICg/Z8Wh6RGD8C056r3xl3yGy9cVvR+Sm7CfMo
 6t2eMO0dKsfYD4WRD9LJCBnQtxwotHgU5uE/PBhnRdj4PndlXQ2aagugysAz1bbwyLulerKKSOc
 i542xFrYqbktqq4Bybg==
X-Proofpoint-GUID: ngJhYXre91YLcIRs3bmfj_p33jfKn6bV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Move all fields from audio_driver directly into AudioMixengBackendClass,
> eliminating an unnecessary extra struct. Drivers now set class
> fields directly in class_init instead of creating a static audio_driver
> instance.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h       | 18 +++++--------
>   audio/audio_template.h  | 58 +++++++++++++++++++----------------------
>   audio/alsaaudio.c       | 17 +++++-------
>   audio/audio-mixeng-be.c | 20 +++++++-------
>   audio/dbusaudio.c       | 17 +++++-------
>   audio/dsoundaudio.c     | 17 +++++-------
>   audio/jackaudio.c       | 17 +++++-------
>   audio/noaudio.c         | 28 ++++++++------------
>   audio/ossaudio.c        | 17 +++++-------
>   audio/paaudio.c         | 17 +++++-------
>   audio/pwaudio.c         | 17 +++++-------
>   audio/sdlaudio.c        | 17 +++++-------
>   audio/sndioaudio.c      | 27 ++++++++-----------
>   audio/spiceaudio.c      | 36 +++++++++++--------------
>   audio/wavaudio.c        | 28 ++++++++------------
>   audio/coreaudio.m       | 28 ++++++++------------
>   16 files changed, 149 insertions(+), 230 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index fb5a9dd871e..bd9c7a29e41 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -136,16 +136,6 @@ struct SWVoiceIn {
>       QLIST_ENTRY (SWVoiceIn) entries;
>   };
>   
> -typedef struct audio_driver audio_driver;
> -struct audio_driver {
> -    const char *name;
> -    struct audio_pcm_ops *pcm_ops;
> -    int max_voices_out;
> -    int max_voices_in;
> -    size_t voice_size_out;
> -    size_t voice_size_in;
> -};
> -
>   struct audio_pcm_ops {
>       int    (*init_out)(HWVoiceOut *hw, audsettings *as);
>       void   (*fini_out)(HWVoiceOut *hw);
> @@ -229,13 +219,17 @@ struct SWVoiceCap {
>   struct AudioMixengBackendClass {
>       AudioBackendClass parent_class;
>   
> -    audio_driver *driver;
> +    const char *name;
> +    struct audio_pcm_ops *pcm_ops;
> +    int max_voices_out;
> +    int max_voices_in;
> +    size_t voice_size_out;
> +    size_t voice_size_in;
>   };
>   
>   struct AudioMixengBackend {
>       AudioBackend parent_obj;
>   
> -    struct audio_driver *drv;
>       Audiodev *dev;
>   
>       QEMUTimer *ts;
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 6c2d2ad5dca..7187571c668 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -37,41 +37,42 @@
>   #endif
>   
>   static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
> -                                              struct audio_driver *drv, int min_voices)
> +                                              AudioMixengBackendClass *k,
> +                                              int min_voices)
>   {
> -    int max_voices = glue (drv->max_voices_, TYPE);
> -    size_t voice_size = glue(drv->voice_size_, TYPE);
> +    int max_voices = glue(k->max_voices_, TYPE);
> +    size_t voice_size = glue(k->voice_size_, TYPE);
>   
> -    glue (s->nb_hw_voices_, TYPE) = glue(audio_get_pdo_, TYPE)(s->dev)->voices;
> -    if (glue (s->nb_hw_voices_, TYPE) > max_voices) {
> +    glue(s->nb_hw_voices_, TYPE) = glue(audio_get_pdo_, TYPE)(s->dev)->voices;
> +    if (glue(s->nb_hw_voices_, TYPE) > max_voices) {
>           if (!max_voices) {
>   #ifdef DAC
> -            dolog ("Driver `%s' does not support " NAME "\n", drv->name);
> +            dolog("Driver `%s' does not support " NAME "\n", k->name);
>   #endif
>           } else {
> -            dolog ("Driver `%s' does not support %d " NAME " voices, max %d\n",
> -                   drv->name,
> -                   glue (s->nb_hw_voices_, TYPE),
> +            dolog("Driver `%s' does not support %d " NAME " voices, max %d\n",
> +                   k->name,
> +                   glue(s->nb_hw_voices_, TYPE),
>                      max_voices);
>           }
> -        glue (s->nb_hw_voices_, TYPE) = max_voices;
> +        glue(s->nb_hw_voices_, TYPE) = max_voices;
>       }
>   
> -    if (glue (s->nb_hw_voices_, TYPE) < min_voices) {
> -        dolog ("Bogus number of " NAME " voices %d, setting to %d\n",
> -               glue (s->nb_hw_voices_, TYPE),
> +    if (glue(s->nb_hw_voices_, TYPE) < min_voices) {
> +        dolog("Bogus number of " NAME " voices %d, setting to %d\n",
> +               glue(s->nb_hw_voices_, TYPE),
>                  min_voices);
>       }
>   
>       if (audio_bug(__func__, !voice_size && max_voices)) {
> -        dolog ("drv=`%s' voice_size=0 max_voices=%d\n",
> -               drv->name, max_voices);
> -        glue (s->nb_hw_voices_, TYPE) = 0;
> +        dolog("drv=`%s' voice_size=0 max_voices=%d\n",
> +               k->name, max_voices);
> +        glue(s->nb_hw_voices_, TYPE) = 0;
>       }
>   
>       if (audio_bug(__func__, voice_size && !max_voices)) {
>           dolog("drv=`%s' voice_size=%zu max_voices=0\n",
> -              drv->name, voice_size);
> +              k->name, voice_size);
>       }
>   }
>   
> @@ -267,29 +268,24 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>                                                struct audsettings *as)
>   {
>       HW *hw;
> -    struct audio_driver *drv = s->drv;
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
>   
> -    if (!glue (s->nb_hw_voices_, TYPE)) {
> +    if (!glue(s->nb_hw_voices_, TYPE)) {
>           return NULL;
>       }
>   
> -    if (audio_bug(__func__, !drv)) {
> -        dolog ("No host audio driver\n");
> -        return NULL;
> -    }
> -
> -    if (audio_bug(__func__, !drv->pcm_ops)) {
> -        dolog ("Host audio driver without pcm_ops\n");
> +    if (audio_bug(__func__, !k->pcm_ops)) {
> +        dolog("No host audio driver or missing pcm_ops\n");
>           return NULL;
>       }
>   
>       /*
> -     * Since glue(s->nb_hw_voices_, TYPE) is != 0, glue(drv->voice_size_, TYPE)
> +     * Since glue(s->nb_hw_voices_, TYPE) is != 0, glue(k->voice_size_, TYPE)
>        * is guaranteed to be != 0. See the audio_init_nb_voices_* functions.
>        */
> -    hw = g_malloc0(glue(drv->voice_size_, TYPE));
> +    hw = g_malloc0(glue(k->voice_size_, TYPE));
>       hw->s = AUDIO_MIXENG_BACKEND(object_ref(s));
> -    hw->pcm_ops = drv->pcm_ops;
> +    hw->pcm_ops = k->pcm_ops;
>   
>       QLIST_INIT (&hw->sw_head);
>   #ifdef DAC
> @@ -517,8 +513,8 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>           goto fail;
>       }
>   
> -    if (audio_bug(__func__, !s->drv)) {
> -        dolog ("Can not open `%s' (no host audio driver)\n", name);
> +    if (audio_bug(__func__, !AUDIO_MIXENG_BACKEND_GET_CLASS(s)->pcm_ops)) {
> +        dolog("Can not open `%s' (no host audio driver)\n", name);
>           goto fail;
>       }
>   
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 0bb2ab5c462..a49da32cc4e 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -46,7 +46,6 @@ struct AudioALSA {
>       AudioMixengBackend parent;
>   };
>   
> -static struct audio_driver alsa_audio_driver;
>   
>   struct pollhlp {
>       snd_pcm_t *handle;
> @@ -938,15 +937,6 @@ static struct audio_pcm_ops alsa_pcm_ops = {
>       .enable_in = alsa_enable_in,
>   };
>   
> -static struct audio_driver alsa_audio_driver = {
> -    .name           = "alsa",
> -    .pcm_ops        = &alsa_pcm_ops,
> -    .max_voices_out = INT_MAX,
> -    .max_voices_in  = INT_MAX,
> -    .voice_size_out = sizeof (ALSAVoiceOut),
> -    .voice_size_in  = sizeof (ALSAVoiceIn)
> -};
> -
>   static void audio_alsa_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> @@ -955,7 +945,12 @@ static void audio_alsa_class_init(ObjectClass *klass, const void *data)
>       audio_alsa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_alsa_realize;
> -    k->driver = &alsa_audio_driver;
> +    k->name = "alsa";
> +    k->pcm_ops = &alsa_pcm_ops;
> +    k->max_voices_out = INT_MAX;
> +    k->max_voices_in = INT_MAX;
> +    k->voice_size_out = sizeof(ALSAVoiceOut);
> +    k->voice_size_in = sizeof(ALSAVoiceIn);
>   }
>   
>   static const TypeInfo audio_alsa_info = {
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 8024ca6bf9f..9d16fb5e654 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -1518,21 +1518,20 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
>                                            Audiodev *dev, Error **errp)
>   {
>       AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(abe);
> -    audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(be);
>   
>       be->dev = dev;
> -    if (!drv->pcm_ops->get_buffer_in) {
> -        drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
> -        drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
> +    if (!k->pcm_ops->get_buffer_in) {
> +        k->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
> +        k->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
>       }
> -    if (!drv->pcm_ops->get_buffer_out) {
> -        drv->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
> -        drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
> +    if (!k->pcm_ops->get_buffer_out) {
> +        k->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
> +        k->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
>       }
>   
> -    audio_init_nb_voices_out(be, drv, 1);
> -    audio_init_nb_voices_in(be, drv, 0);
> -    be->drv = drv;
> +    audio_init_nb_voices_out(be, k, 1);
> +    audio_init_nb_voices_in(be, k, 0);
>   
>       if (be->dev->timer_period <= 0) {
>           be->period_ticks = 1;
> @@ -1658,7 +1657,6 @@ static void audio_mixeng_backend_finalize(Object *obj)
>           QLIST_REMOVE(hwi, entries);
>       }
>   
> -    s->drv = NULL;
>       if (s->dev) {
>           qapi_free_Audiodev(s->dev);
>           s->dev = NULL;
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index a69baad4aec..d78d5799952 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -61,7 +61,6 @@ struct AudioDbus {
>       GHashTable *in_listeners;
>   };
>   
> -static struct audio_driver dbus_audio_driver;
>   
>   typedef struct DBusVoiceOut {
>       HWVoiceOut hw;
> @@ -709,15 +708,6 @@ static struct audio_pcm_ops dbus_pcm_ops = {
>       .volume_in = dbus_volume_in,
>   };
>   
> -static struct audio_driver dbus_audio_driver = {
> -    .name            = "dbus",
> -    .pcm_ops         = &dbus_pcm_ops,
> -    .max_voices_out  = INT_MAX,
> -    .max_voices_in   = INT_MAX,
> -    .voice_size_out  = sizeof(DBusVoiceOut),
> -    .voice_size_in   = sizeof(DBusVoiceIn)
> -};
> -
>   static void audio_dbus_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> @@ -727,7 +717,12 @@ static void audio_dbus_class_init(ObjectClass *klass, const void *data)
>   
>       b->realize = audio_dbus_realize;
>       b->set_dbus_server = dbus_audio_set_server;
> -    k->driver = &dbus_audio_driver;
> +    k->name = "dbus";
> +    k->pcm_ops = &dbus_pcm_ops;
> +    k->max_voices_out = INT_MAX;
> +    k->max_voices_in = INT_MAX;
> +    k->voice_size_out = sizeof(DBusVoiceOut);
> +    k->voice_size_in = sizeof(DBusVoiceIn);
>   }
>   
>   static const TypeInfo audio_dbus_info = {
> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index 4ecf2ade003..b8bc6c8c7be 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -55,7 +55,6 @@ struct AudioDsound {
>       struct audsettings settings;
>   };
>   
> -static struct audio_driver dsound_audio_driver;
>   
>   /* #define DEBUG_DSOUND */
>   
> @@ -685,15 +684,6 @@ static struct audio_pcm_ops dsound_pcm_ops = {
>       .enable_in = dsound_enable_in,
>   };
>   
> -static struct audio_driver dsound_audio_driver = {
> -    .name           = "dsound",
> -    .pcm_ops        = &dsound_pcm_ops,
> -    .max_voices_out = INT_MAX,
> -    .max_voices_in  = 1,
> -    .voice_size_out = sizeof (DSoundVoiceOut),
> -    .voice_size_in  = sizeof (DSoundVoiceIn)
> -};
> -
>   static void audio_dsound_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> @@ -702,7 +692,12 @@ static void audio_dsound_class_init(ObjectClass *klass, const void *data)
>       audio_dsound_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_dsound_realize;
> -    k->driver = &dsound_audio_driver;
> +    k->name = "dsound";
> +    k->pcm_ops = &dsound_pcm_ops;
> +    k->max_voices_out = INT_MAX;
> +    k->max_voices_in = 1;
> +    k->voice_size_out = sizeof(DSoundVoiceOut);
> +    k->voice_size_in = sizeof(DSoundVoiceIn);
>   }
>   
>   static const TypeInfo audio_dsound_info = {
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 650ec230846..e69b313afe5 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -42,7 +42,6 @@ struct AudioJack {
>       AudioMixengBackend parent;
>   };
>   
> -static struct audio_driver jack_driver;
>   
>   struct QJack;
>   
> @@ -668,15 +667,6 @@ static struct audio_pcm_ops jack_pcm_ops = {
>       .enable_in      = qjack_enable_in
>   };
>   
> -static struct audio_driver jack_driver = {
> -    .name           = "jack",
> -    .pcm_ops        = &jack_pcm_ops,
> -    .max_voices_out = INT_MAX,
> -    .max_voices_in  = INT_MAX,
> -    .voice_size_out = sizeof(QJackOut),
> -    .voice_size_in  = sizeof(QJackIn)
> -};
> -
>   static void qjack_error(const char *msg)
>   {
>       dolog("E: %s\n", msg);
> @@ -691,7 +681,12 @@ static void audio_jack_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>   
> -    k->driver = &jack_driver;
> +    k->name = "jack";
> +    k->pcm_ops = &jack_pcm_ops;
> +    k->max_voices_out = INT_MAX;
> +    k->max_voices_in = INT_MAX;
> +    k->voice_size_out = sizeof(QJackOut);
> +    k->voice_size_in = sizeof(QJackIn);
>   }
>   
>   static const TypeInfo audio_jack_info = {
> diff --git a/audio/noaudio.c b/audio/noaudio.c
> index 5c721ed69d0..d1fba117133 100644
> --- a/audio/noaudio.c
> +++ b/audio/noaudio.c
> @@ -37,15 +37,6 @@ struct AudioNone {
>       AudioMixengBackend parent;
>   };
>   
> -static struct audio_driver no_audio_driver;
> -
> -static void audio_none_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &no_audio_driver;
> -}
> -
>   typedef struct NoVoiceOut {
>       HWVoiceOut hw;
>       RateCtl rate;
> @@ -134,14 +125,17 @@ static struct audio_pcm_ops no_pcm_ops = {
>       .enable_in = no_enable_in
>   };
>   
> -static struct audio_driver no_audio_driver = {
> -    .name           = "none",
> -    .pcm_ops        = &no_pcm_ops,
> -    .max_voices_out = INT_MAX,
> -    .max_voices_in  = INT_MAX,
> -    .voice_size_out = sizeof (NoVoiceOut),
> -    .voice_size_in  = sizeof (NoVoiceIn)
> -};
> +static void audio_none_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->name = "none";
> +    k->pcm_ops = &no_pcm_ops;
> +    k->max_voices_out = INT_MAX;
> +    k->max_voices_in = INT_MAX;
> +    k->voice_size_out = sizeof(NoVoiceOut);
> +    k->voice_size_in = sizeof(NoVoiceIn);
> +}
>   
>   static const TypeInfo audio_none_info = {
>       .name = TYPE_AUDIO_NONE,
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index a4ee6ee3327..15fdf54eb3e 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -46,7 +46,6 @@ struct AudioOss {
>       AudioMixengBackend parent;
>   };
>   
> -static struct audio_driver oss_audio_driver;
>   
>   #if defined OSS_GETVERSION && defined SNDCTL_DSP_POLICY
>   #define USE_DSP_POLICY
> @@ -773,15 +772,6 @@ static struct audio_pcm_ops oss_pcm_ops = {
>       .enable_in = oss_enable_in
>   };
>   
> -static struct audio_driver oss_audio_driver = {
> -    .name           = "oss",
> -    .pcm_ops        = &oss_pcm_ops,
> -    .max_voices_out = INT_MAX,
> -    .max_voices_in  = INT_MAX,
> -    .voice_size_out = sizeof (OSSVoiceOut),
> -    .voice_size_in  = sizeof (OSSVoiceIn)
> -};
> -
>   static void audio_oss_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> @@ -790,7 +780,12 @@ static void audio_oss_class_init(ObjectClass *klass, const void *data)
>       audio_oss_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_oss_realize;
> -    k->driver = &oss_audio_driver;
> +    k->name = "oss";
> +    k->pcm_ops = &oss_pcm_ops;
> +    k->max_voices_out = INT_MAX;
> +    k->max_voices_in = INT_MAX;
> +    k->voice_size_out = sizeof(OSSVoiceOut);
> +    k->voice_size_in = sizeof(OSSVoiceIn);
>   }
>   
>   static const TypeInfo audio_oss_info = {
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 4d77f341b5f..056158755c6 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -16,7 +16,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(AudioPa, AUDIO_PA)
>   
>   static AudioBackendClass *audio_pa_parent_class;
>   
> -static struct audio_driver pa_audio_driver;
>   
>   typedef struct PAConnection {
>       char *server;
> @@ -931,15 +930,6 @@ static struct audio_pcm_ops qpa_pcm_ops = {
>       .volume_in = qpa_volume_in
>   };
>   
> -static struct audio_driver pa_audio_driver = {
> -    .name           = "pa",
> -    .pcm_ops        = &qpa_pcm_ops,
> -    .max_voices_out = INT_MAX,
> -    .max_voices_in  = INT_MAX,
> -    .voice_size_out = sizeof (PAVoiceOut),
> -    .voice_size_in  = sizeof (PAVoiceIn),
> -};
> -
>   static void audio_pa_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> @@ -948,7 +938,12 @@ static void audio_pa_class_init(ObjectClass *klass, const void *data)
>       audio_pa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_pa_realize;
> -    k->driver = &pa_audio_driver;
> +    k->name = "pa";
> +    k->pcm_ops = &qpa_pcm_ops;
> +    k->max_voices_out = INT_MAX;
> +    k->max_voices_in = INT_MAX;
> +    k->voice_size_out = sizeof(PAVoiceOut);
> +    k->voice_size_in = sizeof(PAVoiceIn);
>   }
>   
>   static const TypeInfo audio_pa_info = {
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index c1cc945e659..7cadf7121bb 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -44,7 +44,6 @@ struct AudioPw {
>       int last_seq, pending_seq, error;
>   };
>   
> -static struct audio_driver pw_audio_driver;
>   
>   typedef struct pwvolume {
>       uint32_t channels;
> @@ -840,15 +839,6 @@ static struct audio_pcm_ops qpw_pcm_ops = {
>       .enable_in = qpw_enable_in
>   };
>   
> -static struct audio_driver pw_audio_driver = {
> -    .name = "pipewire",
> -    .pcm_ops = &qpw_pcm_ops,
> -    .max_voices_out = INT_MAX,
> -    .max_voices_in = INT_MAX,
> -    .voice_size_out = sizeof(PWVoiceOut),
> -    .voice_size_in = sizeof(PWVoiceIn),
> -};
> -
>   static void audio_pw_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> @@ -857,7 +847,12 @@ static void audio_pw_class_init(ObjectClass *klass, const void *data)
>       audio_pw_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_pw_realize;
> -    k->driver = &pw_audio_driver;
> +    k->name = "pipewire";
> +    k->pcm_ops = &qpw_pcm_ops;
> +    k->max_voices_out = INT_MAX;
> +    k->max_voices_in = INT_MAX;
> +    k->voice_size_out = sizeof(PWVoiceOut);
> +    k->voice_size_in = sizeof(PWVoiceIn);
>   }
>   
>   static const TypeInfo audio_pw_info = {
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index 2e9bc255a41..90867c0c11d 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -50,7 +50,6 @@ struct AudioSdl {
>       AudioMixengBackend parent;
>   };
>   
> -static struct audio_driver sdl_audio_driver;
>   
>   typedef struct SDLVoiceOut {
>       HWVoiceOut hw;
> @@ -492,15 +491,6 @@ static struct audio_pcm_ops sdl_pcm_ops = {
>       .enable_in = sdl_enable_in,
>   };
>   
> -static struct audio_driver sdl_audio_driver = {
> -    .name           = "sdl",
> -    .pcm_ops        = &sdl_pcm_ops,
> -    .max_voices_out = INT_MAX,
> -    .max_voices_in  = INT_MAX,
> -    .voice_size_out = sizeof(SDLVoiceOut),
> -    .voice_size_in  = sizeof(SDLVoiceIn),
> -};
> -
>   static void audio_sdl_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> @@ -509,7 +499,12 @@ static void audio_sdl_class_init(ObjectClass *klass, const void *data)
>       audio_sdl_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_sdl_realize;
> -    k->driver = &sdl_audio_driver;
> +    k->name = "sdl";
> +    k->pcm_ops = &sdl_pcm_ops;
> +    k->max_voices_out = INT_MAX;
> +    k->max_voices_in = INT_MAX;
> +    k->voice_size_out = sizeof(SDLVoiceOut);
> +    k->voice_size_in = sizeof(SDLVoiceIn);
>   }
>   
>   static const TypeInfo audio_sdl_info = {
> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> index de2ee44fa0d..8be0efbc2d6 100644
> --- a/audio/sndioaudio.c
> +++ b/audio/sndioaudio.c
> @@ -32,14 +32,6 @@ struct AudioSndio {
>       AudioMixengBackend parent;
>   };
>   
> -static struct audio_driver sndio_audio_driver;
> -
> -static void audio_sndio_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &sndio_audio_driver;
> -}
>   
>   /* default latency in microseconds if no option is set */
>   #define SNDIO_LATENCY_US   50000
> @@ -551,14 +543,17 @@ static struct audio_pcm_ops sndio_pcm_ops = {
>       .put_buffer_in   = sndio_put_buffer_in,
>   };
>   
> -static struct audio_driver sndio_audio_driver = {
> -    .name           = "sndio",
> -    .pcm_ops        = &sndio_pcm_ops,
> -    .max_voices_out = INT_MAX,
> -    .max_voices_in  = INT_MAX,
> -    .voice_size_out = sizeof(SndioVoice),
> -    .voice_size_in  = sizeof(SndioVoice)
> -};
> +static void audio_sndio_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->name = "sndio";
> +    k->pcm_ops = &sndio_pcm_ops;
> +    k->max_voices_out = INT_MAX;
> +    k->max_voices_in = INT_MAX;
> +    k->voice_size_out = sizeof(SndioVoice);
> +    k->voice_size_in = sizeof(SndioVoice);
> +}
>   
>   static const TypeInfo audio_sndio_info = {
>       .name = TYPE_AUDIO_SNDIO,
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index 248249cef61..4f20f7f73a9 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -39,8 +39,6 @@ struct AudioSpice {
>       AudioMixengBackend parent;
>   };
>   
> -static struct audio_driver spice_audio_driver;
> -
>   static bool spice_audio_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>   {
>       if (!using_spice) {
> @@ -52,17 +50,6 @@ static bool spice_audio_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>       return audio_spice_parent_class->realize(abe, dev, errp);
>   }
>   
> -static void audio_spice_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    audio_spice_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> -
> -    b->realize = spice_audio_realize;
> -    k->driver = &spice_audio_driver;
> -}
> -
>   #if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
>   #define LINE_OUT_SAMPLES (480 * 4)
>   #else
> @@ -332,14 +319,21 @@ static struct audio_pcm_ops audio_callbacks = {
>   #endif
>   };
>   
> -static struct audio_driver spice_audio_driver = {
> -    .name           = "spice",
> -    .pcm_ops        = &audio_callbacks,
> -    .max_voices_out = 1,
> -    .max_voices_in  = 1,
> -    .voice_size_out = sizeof (SpiceVoiceOut),
> -    .voice_size_in  = sizeof (SpiceVoiceIn),
> -};
> +static void audio_spice_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    audio_spice_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> +
> +    b->realize = spice_audio_realize;
> +    k->name = "spice";
> +    k->pcm_ops = &audio_callbacks;
> +    k->max_voices_out = 1;
> +    k->max_voices_in = 1;
> +    k->voice_size_out = sizeof(SpiceVoiceOut);
> +    k->voice_size_in = sizeof(SpiceVoiceIn);
> +}
>   
>   static const TypeInfo audio_spice_info = {
>       .name = TYPE_AUDIO_SPICE,
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 56b3122938f..57a2e686785 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -37,15 +37,6 @@ struct AudioWav {
>       AudioMixengBackend parent;
>   };
>   
> -static struct audio_driver wav_audio_driver;
> -
> -static void audio_wav_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &wav_audio_driver;
> -}
> -
>   typedef struct WAVVoiceOut {
>       HWVoiceOut hw;
>       FILE *f;
> @@ -208,14 +199,17 @@ static struct audio_pcm_ops wav_pcm_ops = {
>       .enable_out = wav_enable_out,
>   };
>   
> -static struct audio_driver wav_audio_driver = {
> -    .name           = "wav",
> -    .pcm_ops        = &wav_pcm_ops,
> -    .max_voices_out = 1,
> -    .max_voices_in  = 0,
> -    .voice_size_out = sizeof (WAVVoiceOut),
> -    .voice_size_in  = 0
> -};
> +static void audio_wav_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->name = "wav";
> +    k->pcm_ops = &wav_pcm_ops;
> +    k->max_voices_out = 1;
> +    k->max_voices_in = 0;
> +    k->voice_size_out = sizeof(WAVVoiceOut);
> +    k->voice_size_in = 0;
> +}
>   
>   static const TypeInfo audio_wav_info = {
>       .name = TYPE_AUDIO_WAV,
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 925c68e8da4..c7602dad223 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -41,15 +41,6 @@
>       AudioMixengBackend parent;
>   };
>   
> -static struct audio_driver coreaudio_audio_driver;
> -
> -static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &coreaudio_audio_driver;
> -}
> -
>   typedef struct coreaudioVoiceOut {
>       HWVoiceOut hw;
>       pthread_mutex_t buf_mutex;
> @@ -669,14 +660,17 @@ static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
>       .enable_out = coreaudio_enable_out
>   };
>   
> -static struct audio_driver coreaudio_audio_driver = {
> -    .name           = "coreaudio",
> -    .pcm_ops        = &coreaudio_pcm_ops,
> -    .max_voices_out = 1,
> -    .max_voices_in  = 0,
> -    .voice_size_out = sizeof (coreaudioVoiceOut),
> -    .voice_size_in  = 0
> -};
> +static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->name = "coreaudio";
> +    k->pcm_ops = &coreaudio_pcm_ops;
> +    k->max_voices_out = 1;
> +    k->max_voices_in = 0;
> +    k->voice_size_out = sizeof(coreaudioVoiceOut);
> +    k->voice_size_in = 0;
> +}
>   
>   static const TypeInfo audio_coreaudio_info = {
>       .name = TYPE_AUDIO_COREAUDIO,

Excellent!

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


