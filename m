Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DF8C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 16:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVBmB-0003Vb-K4; Fri, 27 Jun 2025 12:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVBmA-0003VK-9b
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 12:18:06 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVBm7-0007ro-Qb
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 12:18:05 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-748d982e92cso2017601b3a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751041082; x=1751645882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VkzgF/n1E77l61snMr0EOF4qiFj3fQhuwAnqCf1S2Dk=;
 b=Yacs03YU0bJXY/91hzPYQsluzbj5+fyM/uKqWsNBD8LSJ0IOQ0elUV49FnBvi8qCHq
 nm/N6eP5fBfcQvEOsf3ovKOrOUTSbthR4Rf63SEVoEMJ7QqyTxa5XbyEt3JbM0E7rk3w
 3FGYAhALDjwZEHf8CklkQ9q78eOmLWmvvOIEAUKqf16U2vjBMhso+O8djgNECO3EHx2Q
 RJzhHMuaAYh/bklKuWbrGBhpNnqgR7zFnWalYhYZD4FVk6V0M8a+uQNJNJBGkK8/Jivo
 aDdHwm4TbIx/oC4ZMbf2zJmriVd2nSJ57yGPg41zVZUU8jw0yG9s+911YNpDvNGy9r0S
 vkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751041082; x=1751645882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VkzgF/n1E77l61snMr0EOF4qiFj3fQhuwAnqCf1S2Dk=;
 b=sdRSau1Aldl9t3+vALZBU9oCKH9jv/wUqlNdbkf509EJLwRllU3puNjIg69W6Fsroi
 axLXZVyQPn+EPoTj9Tnm9FJH/v5oxBrkpOwnoQQUw67UYV0Kb+yQzPQbdbZUfZdFr3g9
 AJz9Nn/V06YhR865mnsqJMMKETzSpfwIk/q2toqyvWNk1esanr5JrDl8afLronNTX4RW
 rS/GXW/DUJwe7n9dBPPkhGGhEq9QrQZo06bTG7sHTe/2rOy8WVNIAEPLT9LkDbLGtaFv
 rm1bYRSujIBQGpID7OQrwc8SWmH0LoSGWfQx7s1xjR+ZzQmTeG+acHS4QQ073P0UwpIS
 fPyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKBemBYil76Ilqkr5AXc8hr1vIL+BEMzdu1aB9TINpJxCrFN2e2shJRh8/kNiDaI+wa4GXKJqIQSqc@nongnu.org
X-Gm-Message-State: AOJu0YwaaUp7JqOIusOLVmGpdRNopPTQJrLHEBR+wi+DhIZ7mWVQtpPS
 xm87IpccD0w0Mg5sR+1hJbCSlpy2wfpmALDKQBv1Kvv9aQPt/ktFNWjKg8kyL4dS7BY=
X-Gm-Gg: ASbGncsx9obzR61d1VtIh/je7Q/YL/mhUCQxpq3XLUG6MO6CiBnrWgWr4zgv65U7YU9
 5ae8FBF2Ad0LXLKW4fvNOVvN3+K//yHq8YHltudFUwJpNNS2YIIgS1z7cLXtcYSLkKgJSI/NFz+
 WDFud3DvSYSI13SvZfuaA+RkP66Oq1XBqOqm6gGA0Bfife2PFfMQCbvJS3iNSpPnCGnWcgkmJ26
 fOCbElBvMc3GUcUnF6VQeTXBC69x8T4GKqbHqn2Wz+rVhqx1qW3tERH9Pk1nRHnQYxwLFLg67mj
 GD8cthxVnojU0rjA1kVMAaZ3+J9tpG2k6uUCuntneUiMLC7CfyHPUQrq7+esk2sd7mHP+ihlSq0
 =
X-Google-Smtp-Source: AGHT+IHA2eZyhJfXDxi/mrMwmdb/wkEYcJlpz/O7WK+45CcS6VgfwQztFZS+kaRvCGGG7WIaPp3xxw==
X-Received: by 2002:a17:903:3a88:b0:234:ed31:fc94 with SMTP id
 d9443c01a7336-23ac4633e37mr65914535ad.26.1751041082001; 
 Fri, 27 Jun 2025 09:18:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e3badsm20020965ad.21.2025.06.27.09.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 09:18:01 -0700 (PDT)
Message-ID: <5f50e512-818f-465a-970e-04873ee2dc77@linaro.org>
Date: Fri, 27 Jun 2025 09:18:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/8] Add additional plugin API functions to read and
 write memory and registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250624175351.440780-1-rowanbhart@gmail.com>
 <87o6ubzxfw.fsf@draig.linaro.org> <87cyaqzcft.fsf@draig.linaro.org>
 <5606f27e-48c1-40fa-9453-f76f87fecd2e@linaro.org>
 <877c0xzgpw.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <877c0xzgpw.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/27/25 2:17 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 6/26/25 9:37 AM, Alex Bennée wrote:
>>> Alex Bennée <alex.bennee@linaro.org> writes:
>>>
>>>> Rowan Hart <rowanbhart@gmail.com> writes:
>>>>
>>>>> This patch series adds several new API functions focused on enabling use
>>>>> cases around reading and writing guest memory from QEMU plugins. To support
>>>>> these new APIs, some utility functionality around retrieving information about
>>>>> address spaces is added as well.
>>>>
>>>> Queued to plugins/next, thanks.
>>> So this fails a number of the CI tests, mostly due to 32 bit issues:
>>>     https://gitlab.com/stsquad/qemu/-/pipelines/1890883927/failures
>>> The tci failure is easy enough:
>>> --8<---------------cut here---------------start------------->8---
>>> modified   tests/tcg/x86_64/Makefile.softmmu-target
>>> @@ -34,9 +34,11 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
>>>    # Running
>>>    QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
>>>    +ifeq ($(CONFIG_PLUGIN),y)
>>>    run-plugin-patch-target-with-libpatch.so:		\
>>>    	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true
>>>    run-plugin-patch-target-with-libpatch.so:		\
>>>    	CHECK_PLUGIN_OUTPUT_COMMAND=$(X64_SYSTEM_SRC)/validate-patch.py $@.out
>>>    run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
>>>    EXTRA_RUNS+=run-plugin-patch-target-with-libpatch.so
>>> +endif
>>> --8<---------------cut here---------------end--------------->8---
>>> The other problem is trying to stuff a uint64_t into a void * on 32
>>> bit.
>>> We did disable plugins for 32 bit but then reverted because we were able
>>> to fixup the cases:
>>>    cf2a78cbbb (deprecation: don't enable TCG plugins by default on 32
>>> bit hosts)
>>>    db7a06ade1 (configure: reenable plugins by default for 32-bit hosts)
>>> So I don't what is easier:
>>>    - re-deprecate for 32 bit systems
>>>    - only build libpatch on 64 bit systems
>>>    - fix libpatch to handle being built on 32 bit systems
>>>
>>
>> More context:
>> ../tests/tcg/plugins/patch.c: In function ‘patch_hwaddr’:
>> ../tests/tcg/plugins/patch.c:50:21: error: cast from pointer to
>> integer of different size [-Werror=pointer-to-int-cast]
>>     50 |     uint64_t addr = (uint64_t)userdata;
>>        |                     ^
>> ../tests/tcg/plugins/patch.c: In function ‘patch_vaddr’:
>> ../tests/tcg/plugins/patch.c:93:21: error: cast from pointer to
>> integer of different size [-Werror=pointer-to-int-cast]
>>     93 |     uint64_t addr = (uint64_t)userdata;
>>        |                     ^
>> ../tests/tcg/plugins/patch.c: In function ‘vcpu_tb_trans_cb’:
>> ../tests/tcg/plugins/patch.c:159:54: error: cast to pointer from
>> integer of different size [-Werror=int-to-pointer-cast]
>>    159 |                                                      (void *)addr);
>>        |                                                      ^
>> ../tests/tcg/plugins/patch.c:163:54: error: cast to pointer from
>> integer of different size [-Werror=int-to-pointer-cast]
>>    163 |                                                      (void *)addr);
>>        |
>>
>> Since we disabled 64 bit targets on 32 bit hosts, and that data passed
>> by pointers concern addresses, it should be safe to cast values to
>> (uintptr_t) instead of (uint64_t).
> 
> Something like this?
> 
> --8<---------------cut here---------------start------------->8---
> modified   tests/tcg/plugins/patch.c
> @@ -47,10 +47,10 @@ static GByteArray *str_to_bytes(const char *str)
>   
>   static void patch_hwaddr(unsigned int vcpu_index, void *userdata)
>   {
> -    uint64_t addr = (uint64_t)userdata;
> +    uintptr_t addr = (uintptr_t) userdata;
>       g_autoptr(GString) str = g_string_new(NULL);
>       g_string_printf(str, "patching: @0x%"
> -                    PRIx64 "\n",
> +                    PRIxPTR "\n",
>                       addr);
>       qemu_plugin_outs(str->str);
>   
> @@ -90,7 +90,7 @@ static void patch_hwaddr(unsigned int vcpu_index, void *userdata)
>   
>   static void patch_vaddr(unsigned int vcpu_index, void *userdata)
>   {
> -    uint64_t addr = (uint64_t)userdata;
> +    uintptr_t addr = (uintptr_t) userdata;
>       uint64_t hwaddr = 0;
>       if (!qemu_plugin_translate_vaddr(addr, &hwaddr)) {
>           qemu_plugin_outs("Failed to translate vaddr\n");
> @@ -98,7 +98,7 @@ static void patch_vaddr(unsigned int vcpu_index, void *userdata)
>       }
>       g_autoptr(GString) str = g_string_new(NULL);
>       g_string_printf(str, "patching: @0x%"
> -                    PRIx64 " hw: @0x%" PRIx64 "\n",
> +                    PRIxPTR " hw: @0x%" PRIx64 "\n",
>                       addr, hwaddr);
>       qemu_plugin_outs(str->str);
>   
> @@ -132,19 +132,29 @@ static void patch_vaddr(unsigned int vcpu_index, void *userdata)
>    */
>   static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>   {
> -    uint64_t addr = 0;
>       g_autoptr(GByteArray) insn_data = g_byte_array_new();
> +    uintptr_t addr = 0;
> +
>       for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> +        uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
>   
>           if (use_hwaddr) {
> -            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
> -            if (!qemu_plugin_translate_vaddr(vaddr, &addr)) {
> +            uint64_t hwaddr = 0;
> +            if (!qemu_plugin_translate_vaddr(vaddr, &hwaddr)) {
>                   qemu_plugin_outs("Failed to translate vaddr\n");
>                   continue;
>               }
> +            /*
> +             * As we cannot emulate 64 bit systems on 32 bit hosts we
> +             * should never see the top bits set, hence we can safely
> +             * cast to uintptr_t.
> +             */
> +            g_assert(!(hwaddr & ~UINTPTR_MAX));

We would have so many other problems before plugins if this hypothesis 
was not true (all the usage of vaddr type in the codebase would be 
broken). So the assert will not detect anything we are not aware about 
already.

If we want to mention this assumption for plugins users, the plugins 
documentation is probably a better place than one random plugin.

> +            addr = (uintptr_t) hwaddr;
>           } else {
> -            addr = qemu_plugin_insn_vaddr(insn);
> +            g_assert(!(vaddr & ~UINTPTR_MAX));
> +            addr = (uintptr_t) vaddr;
>           }
>   
>           g_byte_array_set_size(insn_data, qemu_plugin_insn_size(insn));
> @@ -156,11 +166,11 @@ static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>               if (use_hwaddr) {
>                   qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_hwaddr,
>                                                        QEMU_PLUGIN_CB_NO_REGS,
> -                                                     (void *)addr);
> +                                                     (void *) addr);
>               } else {
>                   qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_vaddr,
>                                                        QEMU_PLUGIN_CB_NO_REGS,
> -                                                     (void *)addr);
> +                                                     (void *) addr);
>               }
>           }
>       }
> --8<---------------cut here---------------end--------------->8---
> 
> 
>>
>> Pierrick
> 

For the rest, it looks good to me.

Thanks,
Pierrick

