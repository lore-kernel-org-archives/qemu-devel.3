Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F4CC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9Gu-0005vY-Lo; Thu, 08 Feb 2024 13:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rY9Gq-0005qd-B5
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:37:13 -0500
Received: from mail-he1eur04on2130.outbound.protection.outlook.com
 ([40.107.7.130] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rY9Go-00031L-E2
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:37:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crrzPvK700PH79RLOAZosMRfuZuGP/Qc3ttKJY7o4465kZ8jXrBrWwy4Sfm7j3yWzOQUPoqhct1aWvRUDvvgnzMYGU/8vQDD4MQyOEMfjL0H4s/4xBvDBK22zck35/qjif52sgCSVI2P04RY7b2TilsJRJiZ+QpemFoieQAwaBZfc0w6X9xTMnrXyal0k5UF+xDYr+zVAjbh5o/4kas/yraVGg6gx+TvOwbG0vSntqMoyGq/XuC2/QQaE1BhrjgOSOGFgJsFpFwL56Utq1rei54+zTAydASeJ+3Fhp9FgVaWfmpNOy6oJk5mCODPdruYG7qAtzsxZ2TuI867/AB89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUBO9JkPzVPAUqb/BYQi1dXnCyB/Eqht9+UG3fvGBzc=;
 b=BVZVxxfouKMGlRJpLQ84/aEV91uon7k+ZD7X0k7bL40vUfXkpdklsNZLuk2XlxY/D1Bml9yp+6i7FdfprNFh+hx7mEK8x1F4lZxYE0UCzy0lcvbBjWhhOlISZVMRwbHW5xNzqhjDqJCs5uycKxiCAQe8D/DTS1D1kGDEdtkif5120o+ytlV7KbY9/7q85ll1xqOSChsiS2qHkhjnGN6UkrvFY11Y1AIE04rCEQrWQcB8YvHGWZfHQKGedTEk0yMU7H3airDzcaOENISe+KHrNywg2AGFWY9Wa2gdP5Ma82Ujty2sURjfsJbM1BfR6rm2BcuhXH4Bs6zELW1JdE+8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUBO9JkPzVPAUqb/BYQi1dXnCyB/Eqht9+UG3fvGBzc=;
 b=ufNNGy9xehvVr+YXzfcNMWwPk6E/gjq09gYi9MrLQEsfM2hPKO0EY8oqtdIbqVh3SZQVzWLszg8bEVsNgcVp7lnm4brw9ox9fLUEiZ2M5W0KJg+xbWhs/446yAdcdsL1S+JT0fHd2eMjk3Rzjd8wL/P/58Po8FQ3OKvW9EJDV5//dNjKZk1m/9osPtdqAttNsoXlkbtQ5txJV2rnPmKgftCihFnC9SMeUsW3b9bWRIeqUI64+4O3KHEBXMAFuhrz0Z9SZj9sh5OYpeBXBer5XXg5wWypn4mi/7pgCpU9hmJf9xJYif+IdRg6pSLX5+LB2m45EJDyamxHYvndJB+r6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by AS8PR08MB10098.eurprd08.prod.outlook.com (2603:10a6:20b:62a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Thu, 8 Feb
 2024 18:32:03 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::d027:c96c:6bb1:d5c3]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::d027:c96c:6bb1:d5c3%6]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 18:32:03 +0000
Message-ID: <c490a7ac-4bb5-494d-9e74-833b83da8e2b@virtuozzo.com>
Date: Thu, 8 Feb 2024 20:32:33 +0200
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
 <0e33c0ce-4052-4c2a-8405-13f1385e7947@virtuozzo.com>
In-Reply-To: <0e33c0ce-4052-4c2a-8405-13f1385e7947@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|AS8PR08MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 86187112-1e62-41e3-504a-08dc28d43edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vaM8MwiAR4AMn65DhhJ1f6lNsU4dNDCpg7iNUDzTRzZoXjhRXhqUqFGF7rqPD7str4yGhv/mQQChphDS8Lp5+XudH3UIwHGdaYKm7GMrzwBEvPKlIDl8B5NbDzKeVm6X1sGnWUmZ4Ye/EF4F/HuLjUvsXXKPNz21UQ82GfjvVYCPI34FdwBVghlNEZcdarEbFl9x8BPoROHeXh4lCMz5J5hsP/67sRlocLhZ4cMe3RjSTcJUrZH2uaMHA3FjoY3kJV7hS+c0yqgwlhn7e4nTPxx/1N3Sktjn9wiKEb4vaLFbuNk5cPUU2dWogOh+UXistGR2Kk00W6t0U8esKXB0M8YFGDSxnNyKYnp9L4dpvqeg1hhSR8RulJXgO7cPRbUXFUGbFYnbNSTNwZA20Ye2ofIWMf2LtMDprFkBs5Csy8CoSMz/QdsNSsL2m/5om0gA+5/kuscnyfzgrWCtaI8iX4t/oSTyOJULYCyEVIxQX4ixQbGT1XXdYCxGMtgUN7PvM360/13AgScbjuT6WP+WmOGQkgMOc/mcZIn/OIj27dnRInL1Qtr3XC0sdcVhc0Zn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(39850400004)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(2906002)(44832011)(5660300002)(41300700001)(83380400001)(31696002)(38100700002)(2616005)(26005)(86362001)(55236004)(6916009)(6512007)(66476007)(6486002)(6666004)(66946007)(6506007)(66556008)(478600001)(36756003)(8936002)(8676002)(53546011)(4326008)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU95a2hxa1hWaFZjVVh6WVNhMWlrQWhMejdPWGRVRlRLaWZ6UlU1d1F0NFZI?=
 =?utf-8?B?T2dqOVB3cGdpMGFWd01DR3N0WnB2U21MSzFpeTFhbmVaTWE1amNJRkdsMHBy?=
 =?utf-8?B?Z3lmTWUrbjN4NHFiTmRQNTV3dkxwWnl2dlNJdDJBNlc1alVpUWdBWmF4RER0?=
 =?utf-8?B?UzNmRVNmTkQrSnc2U283Ry9GSlIwQ1BqYjJhbjZab2JpOTlEY1RwTEZ2bEpi?=
 =?utf-8?B?Y2h0d1NuRHhVNDYrVXc0Y3l6RHRQYTdoazdZQWZZRzd3RWdhdnBxNzNOcWJ2?=
 =?utf-8?B?RU5nWDJRZ3Y1Ky91QmlYMkp0cStaQ2UrTFdOQWwrWTk3VFkvUlQyZVo4VFJN?=
 =?utf-8?B?Wnl2Y1JhNG9qWGx0b3NVcW9RdXkwTFR5YVRMd3ZKUWJYdXVDYXNHNExFYzlE?=
 =?utf-8?B?dHh0ODhGNFBIWUJBUHRlb0g2dHlvUERkZ0hLWGJGSDl6aURjNFRUVlR4bkFU?=
 =?utf-8?B?Y3lSMlZYUEI1ZExrSm92ZE5zbUdTMWlPMmNDUzRGZ3FqOWFyaWgveVZQeHp1?=
 =?utf-8?B?cERrUDJhbm9jVG5PZUt5S2xOVFVHaGtMbWdkekdVL2prQURqZ2o0QUNVaUFn?=
 =?utf-8?B?NWVFSUdIZUJaRjZyclZQVkw5TVR5ajA4L2ZTTDRXWHdzcjFjcjFrYTl3R3R3?=
 =?utf-8?B?Yk5uZ041M3pCRnAvbnVmK3FrakV0cjVCQTM2ZGFLV2xYMXovUDJKQmVtbjE3?=
 =?utf-8?B?anR3T3JBRG1MdVo5NkdFeDkzVEFLWnlzYU5sRWJZRVMzRGNQWkFpRml3TmUr?=
 =?utf-8?B?by8xOUJPS0UxWlErUk55Qm5UbmtrV0oraHlJektqVXFsdS84ZDNsWHJwcnBo?=
 =?utf-8?B?R0RZNHRlSFUwNnl3YmpIMUg0VEtnaFlTZFcvZUtxSkZ4WWd1VVlIMVFCbWo5?=
 =?utf-8?B?ajdrT2VYV0Ixa0ZkelZOQWNhOWt5Nm1Sb3pFNDE3dDhobFBzaHp1c2tXdzEz?=
 =?utf-8?B?a3dWSVB0ZW4zOE54SkFKWm5sZ3RBbStZMU5yQ3BqbGdSYzJhQkg0MUtWYnIr?=
 =?utf-8?B?ajVQKzIxcDNiQ3BDUitYdGorMFliVzNYbzYzdjBLd2EybFNkNm9ZZEdlbVht?=
 =?utf-8?B?Z3haRjVnY1MyTFhPWW9BcDVKa25YUXJEVTJuNE85WjVpSVBrRCtwcTl0cnJs?=
 =?utf-8?B?UVRLYm9MQjZ2WVpWSzR5OS9haTVnUGt2a1ZzbXNKOTZrcEZ3UGVZYmcveEwy?=
 =?utf-8?B?czZiQ0JEK1B1TEU3RnlOamFYYis2VmJQNXlWK3VZQ2ljVEJsN3ZTenVGblgy?=
 =?utf-8?B?Mjk5NFQ2WnVCTHFBcXJkUU1qSTk1clc2bEQvNU9iZ25hVlFJS2tFNGtreFBo?=
 =?utf-8?B?M1VaaUFKVmZkTThYSWxHUmhONFZPQjBtMXN0dTBNNThRWWZOanczQW5qMEN3?=
 =?utf-8?B?Sy8vWDBaYUZHcDRpMDdsVFRNM0pMZStkS2J2Mm9XOFA3Vmh0Unl6blhSRnNi?=
 =?utf-8?B?Y2pEVFJmcUhoZ05KbEtaN1NCZHA2UFpOYTBzMExuTytoVDJuMTh5OGp5Ui9n?=
 =?utf-8?B?ZEFmZ2RnOW1JUHQ2RlQ3TU9mK3J2SklPanNDMWVESmoybUNDWUFURmJTNmIy?=
 =?utf-8?B?WXFnU2xzUXkxYVVyaFJWN29KMVhLMXBTdG1LWC9LVmpyTWxGYUVYZ1laMWFz?=
 =?utf-8?B?RURBbXRkUHB2UXNYWWFQUnI2RG8zdlRnbUN0YXNPbUN6K2paYkxqbUIyUWdM?=
 =?utf-8?B?N0taemJ4VUpTK1JiVXdGSXJsL2k1NXk5NjhRWnBTODV3djlUeXpRQ2U3Mlk3?=
 =?utf-8?B?U09Wa1d6U2Vsa1VYN1p0eCtOTWtjR1BTQmdZN3d4SXRTL0E3Q0UzazQ1dE82?=
 =?utf-8?B?WFdaRGwvWTRESkxDTUZPdkd0aHVPT1d5bWtIdDlkL0hHM2lPWVNiNlZpa1hQ?=
 =?utf-8?B?MWpPeW95V3VlSHVIdEJMWTBJbS9kb3dUU3phRll5REZjN1NuRjg5SUxjZFdX?=
 =?utf-8?B?NVR0ZVRIRWRYRFd4V0RQaG5VejcvTm1WMWh2U1Fmd0VKbjh1NU03MUpzdlJo?=
 =?utf-8?B?anpHcUFYTm5EWDRnOUVzQUx2dGJCNXA3YWhYclA1MmtoZWhjTTl2UFh2Smpk?=
 =?utf-8?B?OHhvZXREWWFMWTlYaFNkZ1F5ZDFRUmxLMFI2bElnSEhZdEFrZnV3d2FkdHgv?=
 =?utf-8?B?aktzNHkyYlVMY0dMbGltZlIrait5a3lMcU54bG5DU1d4MkpVWjJDaDhCVVl0?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86187112-1e62-41e3-504a-08dc28d43edf
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 18:32:03.3990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN3JOVO4SZUNmmMDGdnkdQ72iBxve9B1kvF9qWox1h2H07PdbP895lbZ6alCGPITNndU5kPm0W6kuT0x6nqrSM5Ck7iWdMvr57T6ATDmC5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10098
Received-SPF: pass client-ip=40.107.7.130;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On 1/25/24 18:36, Andrey Drobyshev wrote:
> On 1/11/24 15:15, Andrey Drobyshev wrote:
>> On 11/1/23 18:13, Denis V. Lunev wrote:
>>> On 11/1/23 16:23, Andrey Drobyshev wrote:
>>>> Currently we emit GUEST_PANICKED event in case kvm_vcpu_ioctl() returns
>>>> KVM_EXIT_SYSTEM_EVENT with the event type KVM_SYSTEM_EVENT_CRASH.  Let's
>>>> extend this scenario and emit GUEST_PANICKED in case of an abnormal KVM
>>>> exit.  That's a natural thing to do since in this case guest is no
>>>> longer operational anyway.
>>>>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> Acked-by: Denis V. Lunev <den@virtuozzo.com>
>>>> ---
>>>>   accel/kvm/kvm-all.c | 19 +++++++++++++++----
>>>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>> index e39a810a4e..d74b3f0b0e 100644
>>>> --- a/accel/kvm/kvm-all.c
>>>> +++ b/accel/kvm/kvm-all.c
>>>> @@ -2816,6 +2816,14 @@ static void kvm_eat_signals(CPUState *cpu)
>>>>       } while (sigismember(&chkset, SIG_IPI));
>>>>   }
>>>>   +static void kvm_emit_guest_crash(CPUState *cpu)
>>>> +{
>>>> +    kvm_cpu_synchronize_state(cpu);
>>>> +    qemu_mutex_lock_iothread();
>>>> +    qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>>>> +    qemu_mutex_unlock_iothread();
>>>> +}
>>>> +
>>>>   int kvm_cpu_exec(CPUState *cpu)
>>>>   {
>>>>       struct kvm_run *run = cpu->kvm_run;
>>>> @@ -2969,21 +2977,24 @@ int kvm_cpu_exec(CPUState *cpu)
>>>>                   ret = EXCP_INTERRUPT;
>>>>                   break;
>>>>               case KVM_SYSTEM_EVENT_CRASH:
>>>> -                kvm_cpu_synchronize_state(cpu);
>>>> -                qemu_mutex_lock_iothread();
>>>> -                qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>>>> -                qemu_mutex_unlock_iothread();
>>>> +                kvm_emit_guest_crash(cpu);
>>>>                   ret = 0;
>>>>                   break;
>>>>               default:
>>>>                   DPRINTF("kvm_arch_handle_exit\n");
>>>>                   ret = kvm_arch_handle_exit(cpu, run);
>>>> +                if (ret < 0) {
>>>> +                    kvm_emit_guest_crash(cpu);
>>>> +                }
>>>>                   break;
>>>>               }
>>>>               break;
>>>>           default:
>>>>               DPRINTF("kvm_arch_handle_exit\n");
>>>>               ret = kvm_arch_handle_exit(cpu, run);
>>>> +            if (ret < 0) {
>>>> +                kvm_emit_guest_crash(cpu);
>>>> +            }
>>>>               break;
>>>>           }
>>>>       } while (ret == 0);
>>> This allows to gracefully handle this problem in production
>>> and reset the guest using on_crash action in libvirt.
>>
>> Ping
> 
> Ping

Yet another ping

