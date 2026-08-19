Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE26C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhRy-0000VG-UU; Wed, 19 Aug 2026 10:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwhRw-0000Uf-Hs
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:39:28 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwhRs-00059F-1v
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:39:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmdP3N62weWp3nmhvnQmdJN31pRt4EV4vLvPhRaYv0UtpkhS/vE/p46Gs4uEYulw8xYYaW+3qtv4f8Eg8DL0lkIr663rNJjIAclZ0hq3mzzbaowBeIMnJwH3gVk0LgCTvddO6Q7wd5kPRafYkqa0gztt37vmDkPAt0VS7bwC4XebJm9pwyAU09wd0oNEQVekUaqSPJC4lYIQg4lN5aE4Pr5meXtpD7GAUlh27JhgLuMmP1GmQbHE4VMATWv8D6WPlBfgTci9lnZwII9LTPhzaMBC+3RFmA5NPfan1oD307SfsnSUcHjOuiFxNKyQy4bM7NzJDxPKgWp5Fzu85kBTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViMQneHM3uEA7077rumf2hUv04iKQUvI1rLZKhSWDBs=;
 b=m18agOGa4O1BNAfwk4K+gsULZYj7lX4T0QuxDnkAtYuB84IOYBJA8Su/m/MKvUIFGTqdOZN/VoUhafnIx1rkTpGrHdMbnurHrBw/heFxZup5Bs3F6QieiqafzZMQ0xpBjJUWrQ13nouYiUH3809+nf2qJ6SKKVa3hkkBC1u4rkI8mYBNMKJD2fP+pQNdynz6xihu2bgHv3OqBi+Ad1vLKL6LJXB7HygbGUQOIzBKodHyTuiJXA5JTen2pGCBtuRly0Lly3AgtYxmSO3hs/2nhiNMCQ7S2/HQYiC5fuuoFvgPSPcsegVlRs9ERlY9UdEl1CuV2WzxwICHo/FIStjMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViMQneHM3uEA7077rumf2hUv04iKQUvI1rLZKhSWDBs=;
 b=VXeJKOIOicaU1nTw5ZvM/TxwJoQKWELNwlt9kFJR6tbTbkMFlziHbnydUK4nQs1P//UXLC7Xp1UIriuyObixrwaitllHy8T6Dis1oxRbs/b2kAaCaGF7X6MFv+k3quEjCigQ9CoA/D1FfkYa86fkho3yFc71A8RX/rXER/VErJxlaHuF/FBAeogdh/WSeo7WBsC23//rDVKBFaE6XCjYpc+Pn7eJBI6dWL5o7ot8v1UGUqbayA3Q7g/DDK52RtaXe1K0/HSBszHfO2lZq1NYsZfTkKashtClXkhm3lihFTUytuvTgWvD9CFMrlm2OdvZdfw20fy1DhX3cWy5/HmBIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by AS2PR08MB9104.eurprd08.prod.outlook.com (2603:10a6:20b:5fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 14:39:18 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 14:39:18 +0000
Message-ID: <af662eb8-310c-4ae7-b8ee-10a36bab7672@virtuozzo.com>
Date: Wed, 19 Aug 2026 17:39:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] migration/cpr: support vhost-vsock devices
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, mail@maciej.szmigiero.name
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <ee6fc8e2-dffd-4a93-8501-7894c593b760@maciej.szmigiero.name>
 <f335aadd-1157-4a57-bd8c-18bd6b76582c@virtuozzo.com>
 <dadd79c2-89c7-405a-b2c9-7973c3fe62d1@virtuozzo.com>
 <aoR62LTt0K7oWNb7@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aoR62LTt0K7oWNb7@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::7) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|AS2PR08MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c680eb7-53c3-42a6-bbd3-08defdffa685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /G2ZuUFeXSsKvU69OJPD/fXD0AcrT2aZSYyFt1ryeK8lgp7xEf1HoV1so01hGoiVLdzbmS+dDpPDyOXt2yUf4FC76wPDq91yfUINo5iYe+o8cgNmMNxar1mhczzlTA5l1yJJcaaDJ0KS5FjiD4EXMEfhR0gFqhQqzzfoWmgpOvXb+hrAGVLn5pZDoCxktovlQnF+WXL7qWw0AwnMiuNk9iLwecwIeOpARCixMR9e0kYp6GAEBkpONyZYtJZS8rZSGM5eWW3rtE0FYMSIRQiSlO+asCdi/Th8mS9FvrCd7ZZwWhD6+TIr82F6tSoBskeCJdrJTASwUfY28Zst/2qfkYHKSo93H2s9N/nI/k+E560NJdN7RGcwb39zN5Zxw+cAvgAkiLxooB5PE+BduQedC8jlNjD9qWllhDIik4vRhfHl+2gHy81JBHSxw7svYC7RtQBDCboQNo9rk2yWkEch6ibmprXPCGFg5IGgMR4/yWKvT9L8xHoJvjp81UrWONfeIsyLzQS8rv48BB4220hcx0/EPSitzuhEz/frh9pYuuvxDa1DIwy45tZEc7Oe5z4TSHKdlk9B7dhoBNLUVx1N3aKGZWJNe6ED4ThGzZT6YArm13NvaYxBPyqVdK+z+FOtHy+gawk1IEJNsOH+COUAMCxY0SlGbQU9SfHYf8xeIaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFRV1ZtcDZJb0dLQ0l0bitvemJ4dHpNeU5QWGtGVWZVVFBEcGFRdktXcCtY?=
 =?utf-8?B?MHQ3bmYyU3J1TUVJcVE2TlR0dVB6bHBTZldPeGc4eDR3WFlQdTBHS2Rra3E4?=
 =?utf-8?B?cWV2QnZzZ0xOdjgzN3kvbGlmbU1DNFJuZ0JwUjRKSUt6YTA3MzY0WVNobXVw?=
 =?utf-8?B?a25QajA3ZmlZS1BrQ01CVVFrNGNwQ0R1NTFwckZPMFgyWGtNOHkrWUdYWWgr?=
 =?utf-8?B?ZVFvWXJITVFRMmVGV2ZZRU1vSTdRYzB1enFtSk9JYmEwdWVoa3Jvdlkwc2Jo?=
 =?utf-8?B?dFJYRTQ2WUljeFRYem5VdUJNeXdWWEFNV2hORHJVa2FrbzVENzlrYWl1dTR3?=
 =?utf-8?B?RzRDTG15MzNOT1lkU0IwMDhqSm1TOHY5dDBHbUJXYlNieWJLZy8vSHo2REx2?=
 =?utf-8?B?Z05HcWE4azJLcHJTRzJFWVJQbkhQZXA3OGswaFY0VjFxOEszWGZHTlJsclhB?=
 =?utf-8?B?M0tFOWF6ZXhkRkdVZUpSSCtSQm1yR0NuREd6VVBueUZ2SVp4MFZhcnI2VEhV?=
 =?utf-8?B?eGx3RzNRNFlxdDFjNkQ0WFB2Q0cyMkc1eEtESjlwMHB6QnlxZmtKUm9heDdE?=
 =?utf-8?B?TnIzM0VIeS9DenB2TVNZNkZnNW9FRHZtWmNVMEVBVXZtS0dFSDAxblBmVDZv?=
 =?utf-8?B?TVFsZVpRWWpKUjRxeFdXMzlybVlXbVl1NGxEZlFYSTVpRTUzZUJYdUJDWEZ4?=
 =?utf-8?B?S2tZdFBuRGxVbStqNWtNTzNiTHhpa2JsS1ovMlhlOVZBMHppK3BLUzBDQWpW?=
 =?utf-8?B?MW16bmEzQWdmTFpZQVdlalBlNnRJVTQyVmZ0UWVVMC8wQ2pKVWxzWEVEQ3J4?=
 =?utf-8?B?WU81V3ZaWkpIT0tXdFRMeG4vL3FOOVZEMzdka3VGT0MyK2swUWZXYi9hS2Q5?=
 =?utf-8?B?SEhTNFRzdnR6WUw2WEh3bCsza3JuSmxsa3dIaUdQTit1NGpGc3gzZmR6MFJY?=
 =?utf-8?B?ZjNlY09POXpoL2NUOVNBbVFLdDdMMDcwdFdKTTJNRTBxYlEzUTFydVk2TFpF?=
 =?utf-8?B?amxWUWlIV3BHNjhpM3hiUmFBcGZacnZHNXZucVpuSDMyWUVmN2w1ZHNrL2k3?=
 =?utf-8?B?cklpbjJNdXB1NWNLRVcwT3J3bEdlb1hONFdKRXhTSGhadzVFVnorTmlrWjVk?=
 =?utf-8?B?YUladWw0TE9zQTRPTS9vRGRHSjhyazgza2xtbi9mTjV3bTBsMVg0MzBOd2pF?=
 =?utf-8?B?ZXBxMW1KelVWRkZBamVCVWhKaU9vZmNUUnE3Q0NLcVpqRkJLc2tyTk51aXFr?=
 =?utf-8?B?L2VwMDZKdFgvZk82TTJkK0ZHeTRiblkxbExaeDE1NmNYZ3NYYXk0R1dqTGNT?=
 =?utf-8?B?dFhpVnpxUWkrT3UvUHgxTjAxeGNqN1RsdS93c3RHUWxKaWc2ZGlQeDdEQVUv?=
 =?utf-8?B?dm90bWVsRi9tYXVrYTBGRFBlSy9CS0YwNXZVVS80UTVKSUNKTDc4cldXMkh6?=
 =?utf-8?B?WWhpcGJreVd2c0NjK21QRktxZG1YR0Z3Y0tNOHZaZjltQy9RNFQ0SGY2cm1I?=
 =?utf-8?B?UkRHNEFlUURSTzEyL2d4UzB0OWNzV0lpcncxNVBEUjVET2JCejh0bldEdE14?=
 =?utf-8?B?cE04TzM1dllYWmRpOG9CUWRKQjZ3UjJobVdMV1h3em83VnlxeGxMVUoxWGpy?=
 =?utf-8?B?M0ZjbEtsdXpLZUdJN0l3Vnh1aG9Vajk3NUk4WjMvdWkrNHBwOTVkUUM0ZmxQ?=
 =?utf-8?B?T1pjK2VqcVNaMlJlU3NzRGZaeEFiSnFieWFITG40MUpqRHhZYnBmSXhnMDR3?=
 =?utf-8?B?SUl5aTFtWkJJWXIxekx4ekNJYnNYMHk2TVVQbXpCazllUURROThDZFVXaUwr?=
 =?utf-8?B?ZXFIMThyNnE4eTRrdzRHcklpQXRzZXdHeXpqTDFQbGxsQ2lsUGRscytXallS?=
 =?utf-8?B?S2NmYnN0VGZjN0t5OForU0dQNXJKZW1hTU5nbFozMDBhYVdvL05YTW0yU2dt?=
 =?utf-8?B?NE1iUVBKQTlKVWw5OGEwMGhodHBYd2tZa0tvNkhSRzFZS3pNZ0ZNZXBkenYz?=
 =?utf-8?B?bEN3cFU4TU1pZVl5TVMzZGhha3VBdU9XaG1Pd0ZqRmNWZnhNclNLd2p3TjdH?=
 =?utf-8?B?ZzNnT25mVzJxakFiSktVRTlLeE5DQVdVU05YTHdZRXJqRzBhSlJqZ0o5aFM3?=
 =?utf-8?B?SkluZkF5SGp1U3pNaWkza0hxdHMzZmRWVGo0SFFiMjBLWGxKdGRBZmdVMUJs?=
 =?utf-8?B?bkI4NldTZTNIcEFuZ3d5SkdxbnN3TzA2TnFaT1ltSUpvT242N1dtRnVOR2xx?=
 =?utf-8?B?ZW5XRHU3SGIzZmhtSkJ1NDJQelFYOVNlZXBBT2ZVaHhtWFc3WGtqU2lqS3dV?=
 =?utf-8?B?bVd3bS9CeG1VUzVLdGNTZ01peWx4RVFRMzN1eVdMS2s3OUd5bUFsemlxWkJS?=
 =?utf-8?Q?ZLtttVXidT6+dDnE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c680eb7-53c3-42a6-bbd3-08defdffa685
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 14:39:18.6625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DjR0V6Up90x4sskgdOtHG7qImfr4W1jTA8is7SNUAlKeEsNQ1Ftgg7YZom7XCO8J3JJzScySv8ccAse4dk8iNlw9PIonmvrEQPuGyNTn+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9104
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 8/18/26 6:33 PM, Stefano Garzarella wrote:
> On Tue, Aug 18, 2026 at 02:02:10PM +0300, Andrey Drobyshev wrote:
>> On 8/11/26 5:12 PM, Andrey Drobyshev wrote:
>>> On 6/30/26 9:35 PM, Maciej S. Szmigiero wrote:
>>>> On 26.06.2026 18:46, Andrey Drobyshev wrote:
>>>>> v2 -> v3:
>>>>>
>>>>> Re-design device ownership hand-off (suggested by Dongli).  Do not rely
>>>>> on SETUP migration notifiers, as this approach forces us to reorder
>>>>> generic migration code (see v2 discussion).  Instead:
>>>>>
>>>>>    * .pre_save() releases ownership on the source (RESET_OWNER) once VM
>>>>>      is stopped;
>>>>>    * .realize() is adjusted to defer device ownership acquisition for an
>>>>>      incoming CPR;
>>>>>    * .post_load() actually claims the device (VHOST_SET_OWNER);
>>>>>    * FAILED migration event callback re-aquires the ownership on the
>>>>>      source after re_save released it.
>>>>>
>>>>> v2: https://lore.kernel.org/qemu-devel/57c9c9b3-d758-489b-95b8-d16c258b9b0c@virtuozzo.com
>>>>>
>>>>> Andrey Drobyshev (7):
>>>>>    vhost: add vhost_reset_owner op
>>>>>    vhost-vsock: don't reset connections during CPR
>>>>>    vhost-vsock: fix FD leak in realize()
>>>>>    vhost-vsock: preserve vhost FD during CPR
>>>>>    vhost: factor out vhost_dev_init_backend()
>>>>>    vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>>>>    vhost-vsock: hand off device ownership across CPR
>>>>>
>>>> These patches look okay CPR-wise, so:
>>>> Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for CPR
>>>>
>>>> But the vsock parts still need review by their maintainers/reviewers.
>>>>
>>>> Thanks,
>>>> Maciej
>>>>
>>>
>>> FYI the kernel counterpart series adding VHOST_RESET_OWNER ioctl to
>>> vsock ended up in Michael's vhost tree ([1], commits
>>> 6236e765f16d^..c7bfb8815d83).
>>>
>>> Therefore - friendly ping for this series.
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
>>>
>>> Andrey
>>
>> Another friendly ping
>>
> 
> Sorry for the long time on my side, and thanks for pings :-)
> 
> I left some comments, but overall LGTM.
> I'm not a CPR/migration expert, so my comments are more related to 
> vhost/vsock.
> 
> Thanks,
> Stefano
> 

Thanks for the review, most of the issues you commented on deserve
fixing.  I'll send an adjusted v4.

Thanks,
Andrey

