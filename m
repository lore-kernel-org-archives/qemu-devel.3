Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A1A106ACC9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0j12-0001IP-5P; Thu, 12 Mar 2026 12:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0j0z-0001GP-GF; Thu, 12 Mar 2026 12:36:02 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0j0w-0008Ux-NO; Thu, 12 Mar 2026 12:36:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9hfpVjZdpIslyqbfRVf2Zj+t1Aq6vmoEhwFQeT1HqnJLP2qcrdOWjB/FnxqqashYpaGZ3VB4lUdVuHwt2aC5xOSpjO3ypirJpjnXUM8FQV8lRMQgDBOdCOOhqjc1z5agu+JRBudBjENRfYYDosWNjzndWrn7pFzB434k0GNr+Vu0+XFuUZxCUBhFheT9TnS6ZtjWZCikFdbB7A9W1prJh41Uc5tNFJLtpbAvLDaqYtqzWGieXxoagdoQj7Et2p+1G/sUK7gFiF1ejCAdPbEhsLyhktxF6ikzH2P1231BxNtRxQNZH1KHInkeAVsG42sjBEuID3pmIZJ8++7LG0x+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WD6K82SZ5uBCopRPJvSVnOaZSCRtY3FH0ODUxpyfk8=;
 b=PN1G1cLtTLhuDE5oMLxAt75fyWf8APDglvlfvuPFQtxRwSyqpwsU7VIAsX34xA/mprhS896uXrQH2GYD4CEhn5Wv4XMKrNJjUryMliAZ+5o7VaXSLXA2NxS1mZ3F6ymWKd+ampIc8CI1p1a10ELbimVElGF1436nlGFv9Zp1Rhuwunq75XjTyZLPWO/WfE5l6L797jGpxY4HIVK7tQk9oLQCHdDqGJFRAHB4SXyATUbeUn8a0YYSgNHITEYyzO+meSLDq5oIxsIgo+MjzRyUtMeM2CPr+Ai75AvBfANzA9j8+pu1+BAAXgw9yNEWaHEbM2gk4/b+1kQba8kOxuKskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WD6K82SZ5uBCopRPJvSVnOaZSCRtY3FH0ODUxpyfk8=;
 b=lsfcTg+nxQ4bcOIAgz+dSBrrrlinZmPz9GnDoU2WmimWMY0mtkPa7/fwgrY8XbenB4TRAJEBJqjD+co3pFkJUSolaL3LSAKQlCeVbE3cE0xfWSZtUMsPPa3Eahc5UG4P1HxnNrd0X79tx1v0L2SbW+aEd1oW+HHbPCH9neJjWdFkVt+8cRIbayrZt5qWzEqdkPxuesgb7K5dZQXg+EncYQw4kWducTKwcPNAbdnZCbwjT5bsKatZ1xYdHZsd/2cJXiaKGSiP51VP+hj66VDQeZqIxcE217FuowYokvxbFguht6b2MuQ6oTibvlmQi4x6W3bPVK80IldKHcPP5ehrkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 16:35:48 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 16:35:48 +0000
Message-ID: <ca5edbdf-f4f6-4280-b9f2-ae00c330c480@nvidia.com>
Date: Thu, 12 Mar 2026 09:35:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support for
 ATS
To: eric.auger@redhat.com, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-3-nathanc@nvidia.com> <87pl5cnp06.fsf@pond.sub.org>
 <98e7dd71-6669-4a82-bec8-f1dae2d861c3@redhat.com>
 <0bdcf7d7-136e-42f4-9fa9-d31f6ae6e19f@nvidia.com>
 <fd34b7a2-65ac-486f-bc17-23dd4f96a3df@redhat.com>
 <87o6ktxwzn.fsf@pond.sub.org>
 <fbf594fe-dc8d-4747-94e7-7398749f03ef@redhat.com>
 <87y0jxwghz.fsf@pond.sub.org>
 <eb5280cc-ea00-40c3-9235-b0330d7fc6fe@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <eb5280cc-ea00-40c3-9235-b0330d7fc6fe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: e935fb9c-c6bd-4438-b264-08de80556a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|7053199007|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: zM3EXwgoUCP3xyabrcqVKHzqzUMYtfG+XeTPIhk+CdMz3FpBntcDgwpBESMKACgwCOGaNE23gx385xnskm6NAkRKYbeVKwcnJDkTyEajuv/iUI2Ar5LKVjNdmbBkrkyKrd6PyhDIj1q+SvbXk/J/6AzFJLmdIAWvSh3TBKZNGwxaSLZ31+JTw2QhVz2yc//nZzS4hEJRsY7QZHHbUNy1q7Zeuu2fmxBBfBBUxUhzrdD6UyoYNfJPJ0drloeUpst8fH/tpdnhtgref3VOqG0w5ygA3mCersmTVqunSL5syYnJIP0hcF9kHmD+birYSiLICRdJogqr70z7TduAFV0S1wRKjBZmgDxHzf+7utHXzKqI+xBoHe/cXTuheEd3XKLdPR1cblxps1HBCX7u00JdUbMvdkMg6nG1+5J3YpVSvA1EGFDsipFHduhSPq8RaQCoLmY6YYBJYXL/QWzN0QNXuO/9NGMtnxa0lzejHDyAPu9LBEB4Y4l5Kfs8WK7AE5H+L4929jO3OyHo+8IlpWs3fC6sd/5+OZKyjYvihv/H6B+c9j5+WqXq6YEPmT2/A7MLSU61XapSAbexDeKnO7mvnY1+giqFd5IMV9lSjCvXjBobk/tsBCS6/yF/qDpLCBGWCkZ7taxu3sPkudIAVyg9wprlcOy7+DVJc0xRt9s+yePYs5hKfKxFJ/bPaGjEKrKYgAmjz+YA/V8QCSs58ffCmNAIwpg3sTRp1NKStyi90Uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(7053199007)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUE0a3loclM2Tmo0VEFyZmZpNDVYYU1IYUJOSDIxYU1oOUNqVEdrYzFodHF0?=
 =?utf-8?B?cW1nQ2p5TWlpNlRDTGNLSzZiUW91RjlPdjJzZjQzYzUxTU80bXZDT2hYWmJq?=
 =?utf-8?B?N1BZRGVNT1R6YTVneGc5QVNoRitqQ2JkTlFnbWNJYTRWRmlCZGtYQmpHV2FK?=
 =?utf-8?B?T0FxOVVwc0VnNVNjczQ1Wm5UTlhNTU1yMmx0RE1zc2h3NDZmZEVUaXJ2aGU1?=
 =?utf-8?B?UVZ0QmFjc0RFWEIzV1JkMVI5NVpzeHgyQzlnRFJZblRDNjJEY1Rqa0NyaTB5?=
 =?utf-8?B?cFY2NVcwRXhCaWR0YWZtWnVzL0pRYzZUNk5pMjQzUXlqNkRJaVIyQUNsTkhF?=
 =?utf-8?B?UU9tL3JVckhubnNDM0YyQVNPNTFydk9sdHp1L0hLc0RUcnJUR3NWVnFqRFVo?=
 =?utf-8?B?cm04dlB1a0VDMTlvODRGcGhGVkp0N2FqNEQ5T3hmZERvdDJweklwaEFTb3U2?=
 =?utf-8?B?ZzBsVVhCd2pGa3V4K0RoRVlUdnBTdWRsWGF5bUhaaHZOSDl0UFRoakdtcjAy?=
 =?utf-8?B?VS9wdVBRUVRJZnVNVDdtK2xnOGJOY1krVm1GTHZ4cytDS1NyUXF3cGRvckVw?=
 =?utf-8?B?Um5yclduSGwxQ1N2REY5T3hka1RtazhPbVQzTy83VndWRUpBT0JUQlN1T29M?=
 =?utf-8?B?M0c2U0c5MzFQU3JHV01BL3Z1d0xGWG9KaXhlbkw3SlFIYllVaUlZTjVMSUcz?=
 =?utf-8?B?TXU3eURCaU81NUJ4ZXRLd0lHV082Y29OTWdWdVVQU0NjcVVUZzJTY3B4WFdB?=
 =?utf-8?B?Sk0xVlVlekhvaFFmbmh5Ylo3ZE51K08wTndVelE1UkRvZzhENEowVk03alhy?=
 =?utf-8?B?Uk1Qbm5DVE95MmNrNEhkUXU0QisrNldzV0tvbjUwcGZDQmhFQ3EzU1FrSGMx?=
 =?utf-8?B?N05Sb2VWeGkzWFJKUSs0ZFdpNDZSVXU3QnhHWm1VL3VncjBuOURNWnM5WUNq?=
 =?utf-8?B?elFmQlFJSzFlOXI1KzZDei9TY1YxSmxML0dvbkVQWWpiUGJvaUl0ZSs3WFZB?=
 =?utf-8?B?bzc2eGhGKzljSFFmME9renBab0dRQWpEQjg1cDY1WFlHVGxPV01Vcjg5Q2c0?=
 =?utf-8?B?eFc4ZEtMSXU3QmZOSDJFQzQ0MXFGaUtqMVI4Y3FDZ01VcVFVb2gxM2pvSUQz?=
 =?utf-8?B?QmxBTk0zWDFNMTl4R0I2b0ZsVHFBUTRQY091NEF6blY4enEvNnBRN1o0cVJR?=
 =?utf-8?B?cU1nRDB1eWJGVFNwSWg3djlCS0VVTlJ2elJNUE04ekY1L09BOUZtTVowRzlQ?=
 =?utf-8?B?QXJxT2NHWmk3NU9reG1pSGRQZnFrdUd5Ym1xVFEwSmN5TXNDSzd5d2pxT080?=
 =?utf-8?B?MXRwT1o3dHBBa0JNU1F1cVJGdDkxR21ZQUF2amtaekZ5T0VUY3IraFFxWkw4?=
 =?utf-8?B?UHRxbzlPMktKUWE4ZzVyRlFMSGhQVU8xM1BwS3E0b2w0WU5QTGw0UE56ZWNr?=
 =?utf-8?B?WFlGaUI0SmgyMUIyYUw4NVd1S0RyMUw5d3ArVVU4QmhhbGxVb1hFZDFySHVm?=
 =?utf-8?B?U2haZ3MvUzRWb1d0alpJR09XUUxsWWRlVHFLN21zcWludHdtREFqR01JN2Jk?=
 =?utf-8?B?dGViRUNNZlhCN0J2Ty9zNDJEU05sTXJFekx0d2s2RTZqMEtjNWM0Y09LcDB1?=
 =?utf-8?B?eXpCQXVpWVZnWGEyS3BHVVdRYXJ5YlkzVTNUem9ETHRJNUtLZXdlSjZNRFBY?=
 =?utf-8?B?RmtveGdZY2F2aERhUXRFZkE4TXZiTndrQnlEcGJOZ3Fnb0Q1dVNxQ1FCaEpu?=
 =?utf-8?B?bDdYa3VrQlZQT1NiYWE0dU14d015NmdhWHJIR3ZZdnkxVkJRbEZsQzZOTDBm?=
 =?utf-8?B?K0taTWlFcVVQcXdBb0lmQWVsei8zcDl6QTY4cXg2ZWVWZnZWU01vbi90LzFJ?=
 =?utf-8?B?OGl5SUtmelp2V1NaY2lHYUpyaEc4TzhubEUyWCthS1RtZnh6QUtQd3ZQNDQz?=
 =?utf-8?B?SmJpcUJrSE53aXB5TVlDN2EyOVJZaHdxN2pkazROS0dLZ0x4Zm1SbTZ2Vml2?=
 =?utf-8?B?RFo5SEM2MWU0TkpyU3ZQN3ZlZzVYb0VJMHVVQ2VLbkJsdXEzUVZkN2lVR0NM?=
 =?utf-8?B?bHR2NThDWDBlQXhsV0NoOEV1MTBJQkJ1R0NTLzE5R3pLMEtJeVAwNk9kRFJE?=
 =?utf-8?B?UnhqaVl2cUxjTVlUTXMvNzB1U3lIQ2YvZlg0cnlWUVV3dHFWeUhOWitjTFpX?=
 =?utf-8?B?RnBvL2pqZ2NibnJCbG9zdHZVcUI1M0pLQ2NoQTlpOGxJRWVEa3hNUFJEUEdH?=
 =?utf-8?B?WXpEOFFzSk5TRk9ReEpRZEhtYy9CeGMrbklNUnJHVjFmWW0rKzJHeDFSNnN6?=
 =?utf-8?B?WnZqSlN1WW1OMnlTSVlnMTRVaVN2UUppU0Fralc0SWJzajQvNWZXdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e935fb9c-c6bd-4438-b264-08de80556a92
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:35:48.3082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISwfp2UEPR2IrCXKaFaLk05FdB8p09OZPI7/NN1YgN6cuDV4Ic9bfSY+8Y5VrX/9WalWUA0yTZkmOfJw9Y1g/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nathanc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 3/12/2026 2:25 AM, Eric Auger wrote:
> On 3/12/26 10:20 AM, Markus Armbruster wrote:
>> Eric Auger<eric.auger@redhat.com> writes:
>>
>>> On 3/12/26 9:39 AM, Markus Armbruster wrote:
>> [...]
>>
>>>> We promise to follow a certain process when changing external
>>>> interfaces: docs/about/deprecated.rst.
>>>>
>>>> This is why I inquired about external access.  No external access, no
>>>> compatibility worries.
>>>>
>>>> I specifically asked about JSON, because going from bool to OnOffAuto is
>>>> mostly compatible in key=value syntax: values "on" and "off" keep
>>>> working.
>>>>
>>>> Mostly compatible, because qapi_bool_parse() also recognizes "yes",
>>>> "true", "y", "no", "false", and "n" for convenience, and these stop
>>>> working.  We have a knack for inventing convenience features that later
>>>> bite us.
>>>>
>>>> JSON breaks entirely, of course: all values stop working.
>>>>
>>>> Even with external access, compatibility worries start only after we
>>>> shipped the interface in a release.  Did we?
>>> those options were introduced in qemu 11.0. Fixing them in -rc is still
>>> an option but it is a very tight schedule
>> If it turns out to be too tight, rever them or declare them
>> experimental?  Then you can revise them without process hassle in the
>> next release.
> Maybe Nathan, in a first step, you could just respin and convert the
> options to the auto form, keeping the current default value and not
> implementing the auto mode yet.
> + the ATS check fix? Shameer, Nathan, would that be sensible within the
> qemu 11.0 -rc timeframe.

Yes, we will respin with just the auto form conversion and include the 
ATS check fix.

Thanks,
Nathan

