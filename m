Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F02CC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 16:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqa8t-0004dC-Nu; Fri, 07 Mar 2025 11:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqa8r-0004by-IN
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:01:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqa8o-0002PP-ES
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:01:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bc48ff815so12679125e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 08:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741363293; x=1741968093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1X9inzUwK4qPxtU9MrOSFpWx6Z09ZFZE28S9gTUPiRs=;
 b=xzqbDXwLLpgoJKxUvRR3uF/hIXeMm+5AatK/7+PB9AANgYwGCp63/UdeUFLD9abWJv
 bw0XGwZkKOvLfN7YN65lZM2Cwx7JNOr9BR6hxVXPLphH74z5cqdK4u8Q+kmoU6YqCDRm
 Fq3l4IaePdeye8c9A+qSeRX9pCNimhYJCfjjCD3m4G2Fzv4fvMaVkwg9Fz+e5/40ZprJ
 M+lcC43UNetoJZ+duNsTKg9sKQh2RoD3+UKbBvBA3oX7h1y75WWqUBEfSp6Rj8itXAtj
 2PhTZIoDqKlG9/TPZwTJq6OhLEnXIOBwKXG9jEkEtMQIk7zKLobjF8RTWA51ZZ/Exb0H
 r0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741363293; x=1741968093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1X9inzUwK4qPxtU9MrOSFpWx6Z09ZFZE28S9gTUPiRs=;
 b=GR9Cpk7t3N522wrrLJm7KdgzXNbRbDOHZEVX1dDAyIvi77AGxhswB7mlEHaw3jF58H
 rTx3h1ogM78R0xJy9Xk9p/bRE3OTyOLW2V1VrbZt9po7yhHqsNaD/hCKkhI8llkGtbRa
 qX7tj3uHZfToYKies+X3urI9tYt5gkB6ARtPnnWnYpXbOtJ5FJy74EE1kCnLFxtun79E
 fu8PnUhiYa46jxjx75I6yMFmYksE/bSChyOkgDjalG6GIuISqk/ncgE222gzUhZBVkQS
 X8OYoBfUu32yf/WQm946yciMLgRuO7rpClkSmH8tXsiiOqO+8IAIivRAcvrDcqKTGeh1
 NgpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVophdnd2CmuYefnadMDNCasdZdqMyQJhUmgtxJSQxN+HUEwJrYH08kwGLYATswmBO8IbhD7trmqbg5@nongnu.org
X-Gm-Message-State: AOJu0YzXCkUFKg/w5Dlx5ZBKaMkk4X6is8sMxp3GbANg5JDQ4d/9ws0B
 kYHJIqBx740kTu/5f3DjfKOTV0w4Hz1VK0R2RlpBCCrQ1hU1+G+F0MNKmvnZiZo=
X-Gm-Gg: ASbGncs3glQH5MML3aPkTmHf7nlaKH+5SVIqioajCCctxCaOSprqZqwgx+ltuP/Fwl2
 tEXEYG3BxmhMHjaFA2VYW6FY4BxWkdU8v9XvqGjBHRkofrFKq+sQ3UFWVZGNy9CQfl9ojTQIJA/
 1I3GdHsBdnsTFSStXWryT68hSn2KBIe3Cdzo+oFrQ9BPkhfKGS5t+uRTOWw44ZCDRXuuCY2WQri
 VUMjf5tPkpkVEGw8FA+iY1t6OtanvPi3fFVMMIBwtJ0KQnc/24LiDbdZb+ZLUVn4enCaLnKl24g
 V8dtkWZ6vp13zJL+Hh6eO5ldn+4hezrFMB8UGZahbs2Lc+h6Gb9P3jFuwnSyCKm1v8Vq1ifgYyX
 As3vQ1XHHZYCI
X-Google-Smtp-Source: AGHT+IEBVQn3IB2BDQdcl58V3vMxW8H7j7qT1acDInjLZNrYFHUCuEhmRHaoZ3Ghw3ABmR5tpGNY3w==
X-Received: by 2002:a05:600c:558c:b0:439:91c7:895a with SMTP id
 5b1f17b1804b1-43ce4ace4abmr377095e9.7.1741363292708; 
 Fri, 07 Mar 2025 08:01:32 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b0425sm55765975e9.3.2025.03.07.08.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 08:01:32 -0800 (PST)
Message-ID: <15a3d344-20d0-4a64-be1b-216cc137bfdf@linaro.org>
Date: Fri, 7 Mar 2025 17:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/11] target/s390x: Add a CONFIG switch to disable legacy
 CPUs
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240624091043.177484-1-thuth@redhat.com>
 <20240624091043.177484-12-thuth@redhat.com>
 <ced1ce10-b211-4328-b944-20154c24da63@linaro.org>
 <92f9a303-6a25-452d-adc9-b246953baf50@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <92f9a303-6a25-452d-adc9-b246953baf50@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/3/25 16:33, Thomas Huth wrote:
> On 07/03/2025 16.27, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 24/6/24 11:10, Thomas Huth wrote:
>>> The oldest model that IBM still supports is the z13. Considering
>>> that each generation can "emulate" the previous two generations
>>> in hardware (via the "IBC" feature of the CPUs), this means that
>>> everything that is older than z114/196 is not an officially supported
>>> CPU model anymore. The Linux kernel still support the z10, so if
>>> we also take this into account, everything older than that can
>>> definitely be considered as a legacy CPU model.
>>>
>>> For downstream builds of QEMU, we would like to be able to disable
>>> these legacy CPUs in the build. Thus add a CONFIG switch that can be
>>> used to disable them (and old machine types that use them by default).
>>>
>>> Message-Id: <20240614125019.588928-1-thuth@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/s390x/s390-virtio-ccw.c | 5 +++++
>>>   target/s390x/cpu_models.c  | 9 +++++++++
>>>   target/s390x/Kconfig       | 5 +++++
>>>   3 files changed, 19 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 3d0bc3e7f2..cd063f8b64 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -47,6 +47,7 @@
>>>   #include "migration/blocker.h"
>>>   #include "qapi/visitor.h"
>>>   #include "hw/s390x/cpu-topology.h"
>>> +#include CONFIG_DEVICES
>>>   static Error *pv_mig_blocker;
>>> @@ -1126,6 +1127,8 @@ static void 
>>> ccw_machine_2_12_class_options(MachineClass *mc)
>>>   }
>>>   DEFINE_CCW_MACHINE(2_12, "2.12", false);
>>> +#ifdef CONFIG_S390X_LEGACY_CPUS
>>> +
>>>   static void ccw_machine_2_11_instance_options(MachineState *machine)
>>>   {
>>>       static const S390FeatInit qemu_cpu_feat = 
>>> { S390_FEAT_LIST_QEMU_V2_11 };
>>> @@ -1272,6 +1275,8 @@ static void 
>>> ccw_machine_2_4_class_options(MachineClass *mc)
>>>   }
>>>   DEFINE_CCW_MACHINE(2_4, "2.4", false);
>>> +#endif
>>> +
>>>   static void ccw_machine_register_types(void)
>>>   {
>>>       type_register_static(&ccw_machine_info);
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index efb508cd2e..a27f4b6f79 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -25,6 +25,7 @@
>>>   #ifndef CONFIG_USER_ONLY
>>>   #include "sysemu/sysemu.h"
>>>   #include "target/s390x/kvm/pv.h"
>>> +#include CONFIG_DEVICES
>>>   #endif
>>>   #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, 
>>> _desc) \
>>> @@ -47,6 +48,13 @@
>>>    * generation 15 one base feature and one optional feature have 
>>> been deprecated.
>>>    */
>>>   static S390CPUDef s390_cpu_defs[] = {
>>> +    /*
>>> +     * Linux requires at least z10 nowadays, and IBM only supports 
>>> recent CPUs
>>> +     * (see https://www.ibm.com/support/pages/ibm-mainframe-life- 
>>> cycle- history),
>>> +     * so we consider older CPUs as legacy that can optionally be 
>>> disabled via
>>> +     * the CONFIG_S390X_LEGACY_CPUS config switch.
>>> +     */
>>> +#if defined(CONFIG_S390X_LEGACY_CPUS) || defined(CONFIG_USER_ONLY)
>>>       CPUDEF_INIT(0x2064, 7, 1, 38, 0x00000000U, "z900", "IBM zSeries 
>>> 900 GA1"),
>>>       CPUDEF_INIT(0x2064, 7, 2, 38, 0x00000000U, "z900.2", "IBM 
>>> zSeries 900 GA2"),
>>>       CPUDEF_INIT(0x2064, 7, 3, 38, 0x00000000U, "z900.3", "IBM 
>>> zSeries 900 GA3"),
>>> @@ -64,6 +72,7 @@ static S390CPUDef s390_cpu_defs[] = {
>>>       CPUDEF_INIT(0x2096, 9, 2, 40, 0x00000000U, "z9BC", "IBM System 
>>> z9 BC GA1"),
>>>       CPUDEF_INIT(0x2094, 9, 3, 40, 0x00000000U, "z9EC.3", "IBM 
>>> System z9 EC GA3"),
>>>       CPUDEF_INIT(0x2096, 9, 3, 40, 0x00000000U, "z9BC.2", "IBM 
>>> System z9 BC GA2"),
>>> +#endif
>>>       CPUDEF_INIT(0x2097, 10, 1, 43, 0x00000000U, "z10EC", "IBM 
>>> System z10 EC GA1"),
>>>       CPUDEF_INIT(0x2097, 10, 2, 43, 0x00000000U, "z10EC.2", "IBM 
>>> System z10 EC GA2"),
>>>       CPUDEF_INIT(0x2098, 10, 2, 43, 0x00000000U, "z10BC", "IBM 
>>> System z10 BC GA1"),
>>> diff --git a/target/s390x/Kconfig b/target/s390x/Kconfig
>>> index d886be48b4..8a95f2bc3f 100644
>>> --- a/target/s390x/Kconfig
>>> +++ b/target/s390x/Kconfig
>>> @@ -2,3 +2,8 @@ config S390X
>>>       bool
>>>       select PCI
>>>       select S390_FLIC
>>> +
>>> +config S390X_LEGACY_CPUS
>>> +    bool
>>> +    default y
>>
>> Do we have plan to deprecate or switch that off?
> 
> No, this is mainly a config knob for downstream builds that do not want 
> to include legacy CPUs, but for upstream it should be fine to keep those 
> around.
> 
> Why do you ask?

WRT single binary, trying to split target/ VS hw/, I was hoping Kconfig
switches would only affect hw/. CPUs are odd devices sitting in between.

Generic registration of QOM types isn't a trivial task neither...

Anyway I can postpone this file analysis, since s390x is a "simple"
target in my setup :)

