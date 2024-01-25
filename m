Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D07C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2iN-0005YX-PA; Thu, 25 Jan 2024 11:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rT2i5-0005G4-Ey
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:36:13 -0500
Received: from mail-vi1eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2613::700]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rT2i3-0002kg-RW
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:36:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA0JtSr6cJT19YKaKKAcEkk8zdNQL8fg7+kFO0l8gnC0D0wUlMzVkejNVze7ZAn48FfKVXJKt/dEDqlLG6+8XZwQX6NJBK4JdwKU/Fwzo7Filh7SvSWdw0tuB1EK3/ezQ5lPcUnIR2wkBbDZE5+iXTX7+ewR1IvwDvwGMARvu3wQYwG/QTlRk0vL5FhJ9v/VG7D3ZhVmhnGiO/q6fI2NlM4Vf+L0jRqPA1kgayD2/EOoh7Iuj3iibjBByn64hMbZZQ264/4dfrwAc9MNOS5JQc6iC04KUNCB3YofFu6wK9M6sMXfm18wy/Bt7gVsjmhfOi3OPjMJXaBQqWkPMp8udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f9cd5lLLMpRlcPl+84723/8dYwPGD/ckQkmyM1lOGw=;
 b=i8R2kSLKdeQvkvQAVVzI6wzrROsoDoncduuS1bHx6OkA79kwfqbJb4bno7ylHT+bl/6uJ/PI0vmTTrTUhwUJynAzZHBYV6nPIigskMUJ1LeZgz7zvc7gEPp5ORo1ShVj/8Y88uo54hzAQ/6z7/R5vuvaK0Gn5PCGuc94bIzIKbmCBkNF0eeTn+hjFaUBnC82UOUeq/s75O3q69ekI4N6MNWYAoH6HmfKBn/P7a7qtYi2cWEaINyuGVtaSSd/viEkE/MsajtcwfgfxF4XQRpGk5jeFD1xQHHfLq5YzwPMD05oYHgrtTyMrvDyeDwq1sffxeEVOD5xQ/kF9RWMNwbGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f9cd5lLLMpRlcPl+84723/8dYwPGD/ckQkmyM1lOGw=;
 b=HFzndN+i2bbrODokz+pP7lXyq1+OmJFJ5b2nEpfUeiI7Fhtei31MaJm09eOaKyB1GX4TSF2b0b24vk0dmkTD0UlmQ15EPAuE3FFJ7Vw5Y6ektXkWxArRv2kDtn42DR5zfIeEcfb1V03lVAsgSIRlO3RQkoU08ZnGIzyNOBebN1/q39lpAJJTpXSLHM0z6+T6yQC0xB2ooFGwD1LuyiaKEwkzammecOzbhimAuyjaapp0wbnz3aIePK3KPi/CZNyO0Dn3ireul7cgrcFL91c/P0NUyEG+pCzycyn4xQXgGxd/gu5oHAx1QotTPtE9tUAXgEpAcj1Ac4qt8ZjfzY5DJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by PAWPR08MB9808.eurprd08.prod.outlook.com (2603:10a6:102:2ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 16:36:06 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::d027:c96c:6bb1:d5c3]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::d027:c96c:6bb1:d5c3%6]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 16:36:04 +0000
Message-ID: <0e33c0ce-4052-4c2a-8405-13f1385e7947@virtuozzo.com>
Date: Thu, 25 Jan 2024 18:36:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: emit GUEST_PANICKED event in case of abnormal KVM
 exit
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org, richard.henderson@linaro.org
References: <20231101152311.181817-1-andrey.drobyshev@virtuozzo.com>
 <f588c351-a7cc-48a7-9ac0-201171a9ed4b@virtuozzo.com>
 <de8eed0a-468d-4433-ab45-4ef2c666e6b6@virtuozzo.com>
In-Reply-To: <de8eed0a-468d-4433-ab45-4ef2c666e6b6@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|PAWPR08MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 601f7b3f-7b54-4bb5-8d6e-08dc1dc3b93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCW35HOWBnSCV8GEgiKPwEoEUajfjxWkjd9c/SJkVzc2cGW3+wUnELfrXuddYtKmktAZ3GFFdxRWpj8FYbBefr7xKeB9vF2TUjLkT6eqzcalZagzsPOTZoG8FOAG6kJd+hGo1IaD1bV31iffRpeTC2vlyE+4o1CSB4DfkV3O1QG/tJP7oGrmeXzjrrNfoQDNZYlZIu853O2l/mb6ERDzlZLQMWUVot91w1p1Hqn+3PttIgoijHptjEH7BHLMoD2magb4xpItcCsj0+lMNgUbY6Bwve0vFumQf3xf1A4f+gCAWVNJ/c0qGCJTSZVBVxR8TUFJHOZrkMQC3bYZD45lxsG2q2eu6RsYhnkADBsTMN1X1DZG9Qb2Akt4/Kfz+e6xg/C/oky6EWGPpGhu628Lxti8cxWesant5h89Qsut5Kl17yo9h/vu7NdM5XRHPEvCZAsk7w+s+OBDA5Cr2BNvNcR6vIB7quRl0W0dWRS4wHQidBemvkG1zo9AiSrVlRlSvYafxgImW0uw1K48RaoAqvIiaiWAbSd2WicOp7MDre/Frd3ujuY8iwsSOWbL9qTRI3uDYExnoXb3yaD/7Om48NQ2bkgsvVF2VXn86/V5LBcn7EMH/jsJOUxC57Wk8LgXfYxmf+xd10cdBclgLNA13Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39850400004)(346002)(396003)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(4326008)(38100700002)(31686004)(2616005)(6916009)(66476007)(66556008)(31696002)(66946007)(316002)(44832011)(83380400001)(2906002)(8676002)(26005)(8936002)(53546011)(6512007)(6666004)(55236004)(86362001)(6486002)(6506007)(5660300002)(478600001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RElXL0djQldLdTRmK3p2bUV6L2owSnkvbjJwbmlwRW9oaE43cVdVWFRVb2lq?=
 =?utf-8?B?RUJhUDc2S3NTZFh6MGowajJXdkEvN0tXVlNHMXBKSUg0ZkkxVGdNUmJidm9Y?=
 =?utf-8?B?RDhFL05QZXVFWGRaZ3MyTTgvbDk3NzFOZ3E2QkY4SU9LZ05ZbjJJWlU4SlhN?=
 =?utf-8?B?MTNvZnNmNEpQNExBNU10cVphYnNtdGdLQUthRDhDdzRUelFZSnI5eFhHNGNE?=
 =?utf-8?B?ZlplUVFEZ3hWZVdhZGprRS9mRTBTeC9aM2owY0VmWVJGc2NVUCtUVUxla1ZL?=
 =?utf-8?B?OXdUeCs5c2pXK0l3TE5heWVjODI0Y1BRcnh2TENmbndTeWYwVEpyZCs2V2g4?=
 =?utf-8?B?Rmlxa0JyWHh6OFlTazFseHAwTmZ6TkI5VjVONW5WdWZXL3ViWmlLYWlzS2N1?=
 =?utf-8?B?UWJ2WnR1Wk80K1J5Y3lLV3p3ejFJTXh3UmdjaDk0OXg3L0c4UEhJMGNOZklK?=
 =?utf-8?B?MTBacFpKS2IxdmFranhlUjhXN1JLOVVqcURGbEJCMTFxOHRaMGJ2ZHNpVENO?=
 =?utf-8?B?ck9kcGRPeTNXcGM3MW40TC82cXdoR0tCR2gybmtGb2k2SjVKOTF3dldwcC9R?=
 =?utf-8?B?OE1jZVFPeWVWbXlUWnJiL0IwZk5nSUprTGR6TTBnTGcwNTl6cFhUUWhWbTlr?=
 =?utf-8?B?dW4wNUNwRGFoYUxOMlFtMjQrTDNzRUF4YUxRKzJ1UFpjYUlwTGppd3k1d0lX?=
 =?utf-8?B?Z1Q1eVdlVEVzWVRDaWR6YVNZdTg4SFFWSUtzNHkraG9QWjRnejREU0wxc2RO?=
 =?utf-8?B?Mm1Xek5hYW94Y01HYndHVWExL0VPelRoN2M3TENxQmF5aThOa29wcHByUkJF?=
 =?utf-8?B?RlRhQThFeWMzd3lTMElPbUlSc1IvcUJmZkFrdSt5clVUYkNrNnFIYjNyYVdV?=
 =?utf-8?B?K2FHMGpwSE9seDVWbHFubUgxMVBiOG1BaVM1VFFGcVEwNTg5bzkrbWFvblQv?=
 =?utf-8?B?TlhzWG85T0xRTHQxVktyazdxZXlSVDZ5SGFGS3ZiWTR2WW5SQUkxMWtoOFpn?=
 =?utf-8?B?NzliNlVSNnFvTVcxMDYwRGpvcndRd01LTkd6cVRIMVBKc3pwc3RTbTgwTEI5?=
 =?utf-8?B?Y3V6K05zc3hhNGFxYVRxOU5LeFEvY2x4OVIxU0h6NWJIbWJNMWFlYWxCOVdk?=
 =?utf-8?B?Wm92U3ZyRmdZblp5N0VnWmtES0E5WHhMUmZCREREdExLTElZdFZ0Nk8vZmcy?=
 =?utf-8?B?VlNYbzNTaVBvVjg1NmtUT3lRckZUQTh4Y3ZvcVVJRnlDNGVkUHkvVDlKRGdo?=
 =?utf-8?B?TkYrVnR6Ty9RZWJ3aFJkZnZGQnVPOXB2VlNzdHN4djhiaHR6Y2I4N3RWQS9l?=
 =?utf-8?B?TFF2L09KRmRSdXNmb0RIS3d6dGNDSDBJVXRwbWhxWUZ2bzNqeHlSb0lwZENn?=
 =?utf-8?B?c3hrc1p6TS9VdEY0aHNyb0lOSjN6Nlp1R29panorU3lqZEYvTHVCV3VXUEVK?=
 =?utf-8?B?RXB1SFcrOTBvcG1sTDNmdTVXdm1KYitJK2JEWU9XcUZUMWRsM0VXaTN0L0RY?=
 =?utf-8?B?R3R5aUJlTUlVQitzd3ZPUzJSRWxNeDdvM3ZnbHNkL1VoaUhlczZ6Z3hIT2I3?=
 =?utf-8?B?Qit3UDRTb2FORkVMeDlMbHhWZm1pUnpQRHorMWFNYlFYaldTOEJXdW1PYUF1?=
 =?utf-8?B?VFY0Z2JFUi9sVy9vemRGeExDRTlLQlV6bVNGRWUycnBoakxraWZTYzh5S2ZX?=
 =?utf-8?B?d1kvcXFiZ0dIQ1lnSmpCS1ZkUVUvN3VRQktvM3FuUkYyY3Ftc1hhSHBuRlFE?=
 =?utf-8?B?cld1MDFpeFRGV1lFc1I5TDZiQ3ZsbDYxV0lLY2FEdFJFMjd5VTdWem5nMFhG?=
 =?utf-8?B?aC9RdWNxckxHTlVLZHp1K3l3YmpwdmZkVFhDQ2FmbkdIMVg4d1pYZ1BnTkxS?=
 =?utf-8?B?YURVeWtITTRFci9mOW03WEtuYi9YeHJXYkVyZ2d4VjF6b1BQUzYyeDRLMWJm?=
 =?utf-8?B?YjcxSW9scHZQb1VQZzkxOVgraFpVbTViOW8vUEtzWEVKcTlqSEdtWEMrZWxw?=
 =?utf-8?B?R2c0Y0U5UFlpVHY3MmhFbjArdFdKR0JMaWVaRGp1RGJUQ2IyQXdxc1VTb3NK?=
 =?utf-8?B?a3cxV2UyUXVrZFpqaUZjRDJlMmZIVHhiV2Y4LytVdkRiQU53RCtrLyt1c1E4?=
 =?utf-8?B?NG9tNFBGWmk5bmM2Q2R5U0k5UHhGbythczhPaU5WQUVjWjhJaUkzeDVGazV5?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601f7b3f-7b54-4bb5-8d6e-08dc1dc3b93d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:36:04.4422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8iCgqfxSdWvr4+qZRuiRBKPsEyQGEbSdWNUfikuHU1MyXLcuByxBsbBxMBvQ7/XVniS2kOn4c9tDGQYEAhvopSpw2vK4D9SfPEbc8m4K92o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9808
Received-SPF: pass client-ip=2a01:111:f403:2613::700;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 1/11/24 15:15, Andrey Drobyshev wrote:
> On 11/1/23 18:13, Denis V. Lunev wrote:
>> On 11/1/23 16:23, Andrey Drobyshev wrote:
>>> Currently we emit GUEST_PANICKED event in case kvm_vcpu_ioctl() returns
>>> KVM_EXIT_SYSTEM_EVENT with the event type KVM_SYSTEM_EVENT_CRASH.  Let's
>>> extend this scenario and emit GUEST_PANICKED in case of an abnormal KVM
>>> exit.  That's a natural thing to do since in this case guest is no
>>> longer operational anyway.
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> Acked-by: Denis V. Lunev <den@virtuozzo.com>
>>> ---
>>>   accel/kvm/kvm-all.c | 19 +++++++++++++++----
>>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index e39a810a4e..d74b3f0b0e 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -2816,6 +2816,14 @@ static void kvm_eat_signals(CPUState *cpu)
>>>       } while (sigismember(&chkset, SIG_IPI));
>>>   }
>>>   +static void kvm_emit_guest_crash(CPUState *cpu)
>>> +{
>>> +    kvm_cpu_synchronize_state(cpu);
>>> +    qemu_mutex_lock_iothread();
>>> +    qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>>> +    qemu_mutex_unlock_iothread();
>>> +}
>>> +
>>>   int kvm_cpu_exec(CPUState *cpu)
>>>   {
>>>       struct kvm_run *run = cpu->kvm_run;
>>> @@ -2969,21 +2977,24 @@ int kvm_cpu_exec(CPUState *cpu)
>>>                   ret = EXCP_INTERRUPT;
>>>                   break;
>>>               case KVM_SYSTEM_EVENT_CRASH:
>>> -                kvm_cpu_synchronize_state(cpu);
>>> -                qemu_mutex_lock_iothread();
>>> -                qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>>> -                qemu_mutex_unlock_iothread();
>>> +                kvm_emit_guest_crash(cpu);
>>>                   ret = 0;
>>>                   break;
>>>               default:
>>>                   DPRINTF("kvm_arch_handle_exit\n");
>>>                   ret = kvm_arch_handle_exit(cpu, run);
>>> +                if (ret < 0) {
>>> +                    kvm_emit_guest_crash(cpu);
>>> +                }
>>>                   break;
>>>               }
>>>               break;
>>>           default:
>>>               DPRINTF("kvm_arch_handle_exit\n");
>>>               ret = kvm_arch_handle_exit(cpu, run);
>>> +            if (ret < 0) {
>>> +                kvm_emit_guest_crash(cpu);
>>> +            }
>>>               break;
>>>           }
>>>       } while (ret == 0);
>> This allows to gracefully handle this problem in production
>> and reset the guest using on_crash action in libvirt.
> 
> Ping

Ping

