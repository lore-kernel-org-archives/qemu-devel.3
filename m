Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53157C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 06:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrMj-0005k1-By; Wed, 02 Jul 2025 02:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrMe-0005jh-Gr
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 02:54:42 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrMb-0006r3-06
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 02:54:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so4069099f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 23:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751439271; x=1752044071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K++mzfbnQA8tia9R43ZFI6VSUcxunM/GKnJ3kqbXUxQ=;
 b=NUyXPC+55ebCGm51qMHhLG+I+FgKn0P52cTXZMTUNo8P7uuWdVVYpSwfRzeJPcRveR
 Yqat9HacT0Ha2Ch8jT0xycL+W5W1U/pwFumRPgnfeWBO/3U8huVO5lWajS7OjbNJFJl9
 kOEwNeC3sP67luR4kol6RYoVsdv0Kb10I3Fv56gY4ZRNtwMnGyEIXfnA5aK0c99yHw9S
 gStM4hnIm8Q7Dhq1+T8zjbJzK3ZbsXhVQwbM/+jcybGn3gE246XfAl751fIE0h5+RQxJ
 GIoCXhO7Udkq291RGczjt3DaBTOjuOC/Rbgklc2coc30r/Px5OvB9OpCQ6tbHSAaP51c
 p1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751439271; x=1752044071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K++mzfbnQA8tia9R43ZFI6VSUcxunM/GKnJ3kqbXUxQ=;
 b=Y7goSFXQdC2Od9pciGix25gyt/ApdgtbRVaOi5yq2w4d/tMv83/1xTOvpjdW0A7Txn
 32A0T5FFKhENxIhrxydld7SSzAX00m6sXjNN466n69QNE1QMGULAKBlbpTSlL4KCuTJS
 liGTQFCMdWsxLRlU562/rmvvGAVwBCfEmyzyahLsXwtpwjO3qsJJ9iVarN71353uxUoj
 1Jq7Rc6KpyJGcb7dV6oZSNTe27OmW06GwjbP9f0OP8jNK6eS7Kw34EEibUSZ4qdvLnAK
 C2VVjIq5dbJ0aYjAlG+Xx9ehfBMR6TjLNvkP1LFWuXlJiWaMJhnlcFG+0+mUi1ArcZ4d
 LJ+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUU2cYTDr6pIsuBu9bVGLUnE0y10qRr6MW46c81Khvt7n2KYlYOG9hp8EszW2B6epvg9pO7hX3d050@nongnu.org
X-Gm-Message-State: AOJu0YxD6U0qlo54HYlwQWH+Ptqc0zp+BP9XrKasOImU4NO9voBsknLd
 gcvVzgr8odDLw9Kw2gP+rFSIQZFJhZLvRYFjKxptjiur5QIZSxPO/6T0cDQxDrrQ0t0=
X-Gm-Gg: ASbGnctoYNAUzwrFaJaFWr8O2/R760nb0X/r9N+fr9HyFox+o1IVCyPioQ58xWeRsf3
 JIBUOhR1SgW3L0lz/OdxljMuoM8wBnHWc9ekG7fLPGsz/npMVyCGKdL8LglzVcIEYqULy0iknLm
 teEsC3a8BtSp2QntrEfqjlbvq0NRh+1kMTDxNhIuAysgfROtBtGNZ6GMb7TUuHmNeILaC5XayR0
 OKgpn3BVPdcuJSVvCMDq2EzzD8M1eaWiEsCn69l/+IaZaursRU6vwMJZaNHJ7Rb9CU+V52wch4z
 9IGtDxaKgXm+k2+RRTsgbfDid5YZHOfRnTQh6TJL9XhBQ+ohVfvOsBQNBsA+fZPPr+P8EEo1S17
 bjuOeEWOxXnGmKL0q9DbwbUoahLVGibapQaCQeK39
X-Google-Smtp-Source: AGHT+IH2tdpx2CEPxZC5veah2sVknVlw7LH20MNexGy/HZESdHLvamO44OiTLHr9DZnhnRRQ68kIMg==
X-Received: by 2002:a05:6000:4718:b0:391:3aaf:1d5f with SMTP id
 ffacd0b85a97d-3b200e2a0e3mr1029602f8f.52.1751439271243; 
 Tue, 01 Jul 2025 23:54:31 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a390d4asm190722585e9.3.2025.07.01.23.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 23:54:30 -0700 (PDT)
Message-ID: <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
Date: Wed, 2 Jul 2025 08:54:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com>
 <aFpocfTpBLB34N3l@intel.com> <aGKryLSGlFTMSKHv@intel.com>
 <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 1/7/25 08:50, Xiaoyao Li wrote:
> On 6/30/2025 11:22 PM, Zhao Liu wrote:
>> (cc Thomas for bug reporting on kvm-unit-test...)
>>
>> On Tue, Jun 24, 2025 at 04:57:21PM +0800, Zhao Liu wrote:
>>> Date: Tue, 24 Jun 2025 16:57:21 +0800
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>> Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
>>>   instance_post_init calls
>>>
>>> On Mon, Jun 23, 2025 at 09:56:14AM -0700, Dongli Zhang wrote:
>>>> Date: Mon, 23 Jun 2025 09:56:14 -0700
>>>> From: Dongli Zhang <dongli.zhang@oracle.com>
>>>> Subject: [Regression] Re: [PULL 35/35] qom: reverse order of
>>>>   instance_post_init calls
>>>>
>>>> This commit may broken the "vendor=" configuration.
>>>>
>>>> For instance, the hypervisor CPU vendor is AMD.
>>>>
>>>> I am going to use "-cpu Skylake-Server,vendor=GenuineIntel".
>>>>
>>>>
>>>> Because of the commit, the vendor is still AMD.
>>>>
>>>> [root@vm ~]# cpuid -1 -l 0x0
>>>> CPU:
>>>>     vendor_id = "AuthenticAMD"
>>>>
>>>>
>>>> If I revert this patch, the vendor because the expected Intel.
>>>>
>>>> [root@vm ~]# cpuid -1 -l 0x0
>>>> CPU:
>>>>     vendor_id = "GenuineIntel"
>>>>
>>>>
>>>> Thank you very much!
>>>
>>> Thank you Dongli!
>>>
>>> (+Like)
>>>
>>> While testing my cache model series, I also noticed the similar behavior
>>> for KVM. Additionally, Like Xu reported to me that this commit caused
>>> a failure in a KVM unit test case. Your report helped me connect these
>>> two issues I met (though due to my environment issues, I haven't
>>> confirmed yet).
>>
>> Ok, now I can confirm this commit cause KUT failure:
>>   * On AMD platform, the "msr.flat" case fails since this case requires
>>     vendor=GenuineIntel (tested by Like).
>>   * On Intel platform, the "syscall.flat" case fails because it requires
>>     vendor=AuthenticAMD (tested by myself).
>>
>>> The "vendor" property from cli is registered as the global property in
>>> x86_cpu_parse_featurestr(), and is applied to x86 CPUs in
>>> device_post_init().
>>>
>>> With this commit, now KVM will override the "vendor" in
>>> host_cpu_instance_init() (called in x86_cpu_post_initfn()) after
>>> device_post_init(), regardless the previous global "vendor" property.
>>
>> This is the root cause for the above failure.
>>
>>> Back to this commit, I think current order of post_init  makes sense.
>>> Instead, the place of host_cpu_instance_init() doesn't seem quite
>>> right. So, I think this commit might have exposed some drawbacks in the
>>> previous x86 CPU initialization order:
>>>
>>> f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using 
>>> AccelCPUClass")
>>> 5b8978d80426 ("i386: do not call cpudef-only models functions for 
>>> max, host, base")
>>
>> To fix this issue, we need to initialize "vendor" property in the initfn
>> of max/host/named CPUs instead of current post_initfn.
>>
>> This will need to split the cpu_instance_init() of x86 kvm (and maybe 
>> hvf/tcg)
>> into 2 hooks:
>>   * AccelCPUClass.cpu_instance_init() - called in x86 CPUs' initfn.
>>   * AccelCPUClass.cpu_instance_post_init() - called in x86 CPUs'
>>     post_initfn.
> 
> Split accel.cpu_instance_init() into cpu's instance_init() and 
> post_instance_init() does not seem right way to go.

Yeah, please don't. I'm trying to consolidate this code but it takes
(too) long.

> The reason .post_instance_init() was implemented and put 
> accel_cpu_instance_init() in it for x86 cpu was that, we don't want to 
> scatter acceletor specific instance_init operation into different 
> subclass of x86 cpu (max/host/named cpu model).
> 
> I think something like below should be enough.
> 
> -----------8<-------------
> Author: Xiaoyao Li <xiaoyao.li@intel.com>
> Date:   Tue Jul 1 13:33:43 2025 +0800
> 
>      i386/cpu: Re-apply the global props as the last step of post_init
> 
>      Commit 220c739903ce ("qom: reverse order of instance_post_init calls")
>      reverses the order instance_post_init calls, which leads to
>      device_post_init() called before x86 cpu 
> specific .instance_post_init().
> 
>      However, x86 cpu replies on qdev_prop_set_globals() (inside
>      device_post_init()) to apply the cpu option like "feature[=foo]" 
> passed
>      via '-cpu' as the last step to make the '-cpu' option highest 
> priority.
> 
>      After the order change of .instance_post_init(), x86_cpu_post_initfn()
>      is called after device_post_init(), and it will change some property
>      value even though "-cpu" option specify a different one.
> 
>      Re-apply the global props as the last step to ensure "-cpu" option
>      always takes highest priority.
> 
>      Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0d35e95430fe..bf290262cbfe 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9044,6 +9044,12 @@ static void x86_cpu_post_initfn(Object *obj)
>               X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
>       }
>   #endif
> +
> +    /*
> +     * Re-apply the "feature[=foo]" from '-cpu' option since they might
> +     * be overwritten by above
> +     */
> +    qdev_prop_set_globals(DEVICE(obj));
>   }

This patch LGTM.

Regards,

Phil.

