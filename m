Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C343CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FQR-0000SR-Ev; Mon, 29 Sep 2025 11:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3FQK-0000RE-DT
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:04:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3FQG-0001ky-OF
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:04:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso2953666f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759158254; x=1759763054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8NtLNsGR2EIOOgIQ2USV2HKfWfiaq6p6LauMRb0fbVw=;
 b=HJQkl4kCaGlzsitxXvInkyXO1MQTMVyExQBi/NxXCU7bsLsvf/ub0hWVd/N4+o7wBy
 Y44bGoHGp65YuWJYzBTuGpAbzjXV4bbNJouf1fejySPkIpmalEEt0dnJAYR+G0e2vjsi
 mPN3y/0y5SCmfaNNBAGtyKGYndz/LEHl8HD1czmCquQN8X+j2heionEP/J/mfkDcvoYh
 DRdxEwaRvCSo36gJPemXQMN01esF3RfjYerycQN+Xfo4QfEBWdVBcFG7d0tFzzDgMGI2
 AtlXKGiKAQ4uW1WSZLN3aTflc4/1ZYZoDADxh5i+TLRHBXBk9cFb8Wlw3+1bQ9d7RW47
 /iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759158254; x=1759763054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8NtLNsGR2EIOOgIQ2USV2HKfWfiaq6p6LauMRb0fbVw=;
 b=pv11jcbx2EjEofrc1eyn8awRcagCXr/012djui2AQDy7LR4qMEvizB7gsH22BXXbuC
 hrDvpSLBDzKSU7h6s+I/WghkXFBkt3U7xyJ3EOW6cvH+/ZE3j25Bp0KtCoY+tjgQV3EC
 KHkYOwsy/jy71uqSHQ9KnR3nlR5PLamAQXILla3jARFpmFGxaKnxRBUOXSgmuXZQfNcO
 VbPVCcbTZGgjZntGEvy3eV53Af847PyHuauQ0vWDsYrPUGzPTCGA3B6kHnH0Kj6XTfhL
 1u9cvfKkgQi85+q91gAGL8xWLsDSy0cMBJktPw3MnrSmR6W3KYkcWPApTMbtddSA4KR+
 VvHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULpEcScFb5qhrBZE3otSNRqpjH5vWm0A+AUsFczBmfGledqeNgRUKDgMimbHfYDEMN3nxVh64n86xI@nongnu.org
X-Gm-Message-State: AOJu0Yz/ZPO4eCFNHfqxrmchYy3bCpGmhPID0wPCIcoJczcDBUdc+RTk
 d+wpDN7F8HFIxkpV91KTRqK8IRwLlviUNvh50bPLIcNfcwXPFxLGAeV8InBwN1wCD44=
X-Gm-Gg: ASbGncvHFt7pXPKUOXVdwhetOjnjN8jyfQn7/YMFJdIu36ufn4qXXbWCqcce1qwyEAb
 TyBjbo3tPiOypIUx1Gi0UVdjUOgUW3CXfs9ewxkGa1WBCrUhrwmOYRyOJKzf2yaI3G6d6iFLycx
 oYs/8pDembkjeKqhYSUqbO4qIewjW0Q6XHU1Sws6nwodBw7rAaqYVOCZpKtNQ8lO3LAgscILGd0
 I/xOXehO3m8WWwpy8+2YdOqXBvrcIuatC7SUtjlxvNT5C7rY9HZ0Oh9nqhBHpmO0AZ+xxNwb1r5
 XhS43y3wTYyrLYTzQ2DEBnailim147+AneG3mmHmRfVjJQECVhXOlqciNIcq182aWYR9cgkZawg
 Z4u8Wirhh7f8NFLq1GMv/avq92mKXMcBeaULPVzbXeCdL1r7SLYQBHSU5QSlmL9Zml5rid0HDwE
 nt
X-Google-Smtp-Source: AGHT+IF0R6K1RSZSnsJqrrIO2Ba96HMi8TRtskmj4Ea93wpJf4i6zgCRoLhFCJJVwWPGupqlyTpiIg==
X-Received: by 2002:a05:6000:2382:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-40e42502e84mr17244175f8f.5.1759158254125; 
 Mon, 29 Sep 2025 08:04:14 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc749b8f9sm18317570f8f.50.2025.09.29.08.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 08:04:13 -0700 (PDT)
Message-ID: <80d350a1-a926-41b9-9cd8-93652680484c@linaro.org>
Date: Mon, 29 Sep 2025 17:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] physmem: Destroy all CPU AddressSpaces on unrealize
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
 <20250929144228.1994037-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250929144228.1994037-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

On 29/9/25 16:42, Peter Maydell wrote:
> When we unrealize a CPU object (which happens on vCPU hot-unplug), we
> should destroy all the AddressSpace objects we created via calls to
> cpu_address_space_init() when the CPU was realized.
> 
> Commit 24bec42f3d6eae added a function to do this for a specific
> AddressSpace, but did not add any places where the function was
> called.
> 
> Since we always want to destroy all the AddressSpaces on unrealize,
> regardless of the target architecture, we don't need to try to keep
> track of how many are still undestroyed, or make the target
> architecture code manually call a destroy function for each AS it
> created.  Instead we can adjust the function to always completely
> destroy the whole cpu->ases array, and arrange for it to be called
> during CPU unrealize as part of the common code.
> 
> Without this fix, AddressSanitizer will report a leak like this
> from a run where we hot-plugged and then hot-unplugged an x86 KVM
> vCPU:
> 
> Direct leak of 416 byte(s) in 1 object(s) allocated from:
>      #0 0x5b638565053d in calloc (/data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/qemu-system-x86_64+0x1ee153d) (BuildId: c1cd6022b195142106e1bffeca23498c2b752bca)
>      #1 0x7c28083f77b1 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x637b1) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #2 0x5b6386999c7c in cpu_address_space_init /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../system/physmem.c:797:25
>      #3 0x5b638727f049 in kvm_cpu_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../target/i386/kvm/kvm-cpu.c:102:5
>      #4 0x5b6385745f40 in accel_cpu_common_realize /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../accel/accel-common.c:101:13
>      #5 0x5b638568fe3c in cpu_exec_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/cpu-common.c:232:10
>      #6 0x5b63874a2cd5 in x86_cpu_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../target/i386/cpu.c:9321:5
>      #7 0x5b6387a0469a in device_set_realized /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/qdev.c:494:13
>      #8 0x5b6387a27d9e in property_set_bool /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:2375:5
>      #9 0x5b6387a2090b in object_property_set /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:1450:5
>      #10 0x5b6387a35b05 in object_property_set_qobject /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/qom-qobject.c:28:10
>      #11 0x5b6387a21739 in object_property_set_bool /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:1520:15
>      #12 0x5b63879fe510 in qdev_realize /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/qdev.c:276:12
> 
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2517
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/exec/cpu-common.h          | 10 ++++-----
>   include/hw/core/cpu.h              |  1 -
>   hw/core/cpu-common.c               |  1 +
>   stubs/cpu-destroy-address-spaces.c | 15 +++++++++++++
>   system/physmem.c                   | 34 ++++++++++++++----------------
>   stubs/meson.build                  |  1 +
>   6 files changed, 38 insertions(+), 24 deletions(-)
>   create mode 100644 stubs/cpu-destroy-address-spaces.c


> -void cpu_address_space_destroy(CPUState *cpu, int asidx)
> +void cpu_destroy_address_spaces(CPUState *cpu)
>   {
>       CPUAddressSpace *cpuas;
> +    int asidx;
>   
>       assert(cpu->cpu_ases);
> -    assert(asidx >= 0 && asidx < cpu->num_ases);
>   
> -    cpuas = &cpu->cpu_ases[asidx];
> -    if (tcg_enabled()) {
> -        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    /* convenience alias just points to some cpu_ases[n] */
> +    cpu->as = NULL;
> +
> +    for (asidx = 0; asidx < cpu->num_ases; asidx++) {
> +        cpuas = &cpu->cpu_ases[asidx];
> +        if (!cpuas->as) {
> +            /* This index was never initialized; no deinit needed */
> +            continue;
> +        }
> +        if (tcg_enabled()) {
> +            memory_listener_unregister(&cpuas->tcg_as_listener);
> +        }
> +        g_clear_pointer(&cpuas->as, address_space_destroy_free);
>       }
>   
> -    address_space_destroy(cpuas->as);
> -    g_free_rcu(cpuas->as, rcu);
> -
> -    if (asidx == 0) {
> -        /* reset the convenience alias for address space 0 */
> -        cpu->as = NULL;
> -    }
> -
> -    if (--cpu->cpu_ases_count == 0) {
> -        g_free(cpu->cpu_ases);
> -        cpu->cpu_ases = NULL;
> -    }
> +    g_clear_pointer(&cpu->cpu_ases, g_free);
>   }

Good, this API respects Richard's suggestion on previous attempt:
https://lore.kernel.org/qemu-devel/594b2550-9a73-684f-6e54-29401dc6cd7a@linaro.org/

