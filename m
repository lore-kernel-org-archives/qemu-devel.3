Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61B1C7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 18:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVE0Q-0006wi-QT; Fri, 27 Jun 2025 14:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVE0E-0006wC-Oh
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:40:47 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVE0C-0000yx-7s
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:40:46 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so2962125b3a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 11:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751049641; x=1751654441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ufQEAchrVQLn4z7H9UfnWG9Q3CUOeJ7muRmSJSSKOS0=;
 b=JAS2Tt9G9asKzbNbHWB68M7oeerQzh14dvKkl3miIFsseKyY3n/IP7f6EGzEku6Zst
 9kt82ZMASI7a8hEN8eHUxXKbw5V3vkXHP0GOb3wo/MNG3SbBaqmuT6KBvy6pugatFTKy
 +pDMD0vPJrOBq8C6CqH+8zTbtd0cNr20D7jsc7BIlLp1C8vtSpRd9IhVxi6J9h3C/rsZ
 XsIDk0PKtaFx09KioEtAmQruJq6VTgXxOkD16zy6G/ci58ua3bkfqIPZMgmF5A2TOiwY
 GzHI55kF7OkcCa6XJ9U+4gs/0D6d6mKQH2mOA/dRwFKJ6VbO6qJzvDd/Wy/2JX6LWkqT
 G+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751049641; x=1751654441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ufQEAchrVQLn4z7H9UfnWG9Q3CUOeJ7muRmSJSSKOS0=;
 b=dsAPMqKOpi6mTv8wPzwJBoKXw7uRPQqndUzAoSUVZ/nalFZ2q8c+Z6WhL3ld3cw/lI
 0FbdG7PEFt6a1kajkNuQv4tYExxkMFjlxctfsQRfQO5/fRurr6z4AEyrwx3RtHb6qRwH
 FS3+j3xzFOARWnrJ9cg/+/fl17jRXMXXZwngJO2tZmpAWpkORL4A0vNffQ1jQC8K6lOL
 OufKHkuLvCO0L+3PFLPuAozJfTc7FnsRrEePXxlX24hSCEXNl63gtSPECE2rWlCAnUEK
 +Q4gWE61zN1frcBW8pBwx4saW4+Mjdh97J9PgXOnGmElQcn3hVe/ze/4nakeBcc+F85Z
 HpXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEtQLw7oJdma3SDCBlxUmvMbpo2kYlwQquPGRNWcdFq/wn0IDb26LDpfWrjLFlpZ8k1K5xq6VoqX3s@nongnu.org
X-Gm-Message-State: AOJu0YxEfayLJkf2nPZO89PRgfn2lpxrCODw0GVlHVncbPnH6gUsAQC+
 sPsSNym2warAsvAe6ovqsArE0m8G4UCTWoSV10gEFqQr6478JA0Fx0f9NqqwZ2CpWRM=
X-Gm-Gg: ASbGncs7h+c2Fqden6dpM/JtK1mwzmgx8ina4ZKA8lZ3pllz31KsUYCo+nCiL0WXA2Q
 2t3jNwamLaHEUNrmdyE6GSGIRoQloa0LaxLgi9a1vGjwbGHtWoXyfvj2LxIQoQKhuTBWRECmYHv
 psJ4lfUvzvGPGLlRBtuavXiaheKJ/HQxfzAVvS/bNi5xl/lkY553dGNfQd2GP6iqHswhXdU+KBM
 SZSRRnD+r8NikRwI24DIvFCS9Zf56RSwkHyXbuRK9iiKnVqBZW8omUPvCiaGxZwtt8pJ8f61cCq
 J/xCsjvWAH8AWbB+lYWNNe8YbOE+DIehypV7x8BMuL46OCzHCN0znpi7Uahx74dF+eOvHxLP3XU
 =
X-Google-Smtp-Source: AGHT+IHYNj+Zz9W+Nvz371RvDA+BriEKE1JeCLYHXFjXxc9dgF7C3sSKckhbhIHtkvXG0vVut6q+yA==
X-Received: by 2002:a17:903:3d0d:b0:235:ea0d:ae21 with SMTP id
 d9443c01a7336-23ac487c9b4mr71972485ad.35.1751049641485; 
 Fri, 27 Jun 2025 11:40:41 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39bfbesm23708625ad.109.2025.06.27.11.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 11:40:41 -0700 (PDT)
Message-ID: <166ab200-63b5-4023-b338-7b8a98238a1d@linaro.org>
Date: Fri, 27 Jun 2025 11:40:40 -0700
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
 <5f50e512-818f-465a-970e-04873ee2dc77@linaro.org>
 <871pr5yrah.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <871pr5yrah.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 6/27/25 11:26 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 6/27/25 2:17 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>
>>>> On 6/26/25 9:37 AM, Alex Bennée wrote:
>>>>> Alex Bennée <alex.bennee@linaro.org> writes:
>>>>>
>>>>>> Rowan Hart <rowanbhart@gmail.com> writes:
>>>>>>
>>>>>>> This patch series adds several new API functions focused on enabling use
>>>>>>> cases around reading and writing guest memory from QEMU plugins. To support
>>>>>>> these new APIs, some utility functionality around retrieving information about
>>>>>>> address spaces is added as well.
>>>>>>
>>>>>> Queued to plugins/next, thanks.
>>>>> So this fails a number of the CI tests, mostly due to 32 bit issues:
>>>>>      https://gitlab.com/stsquad/qemu/-/pipelines/1890883927/failures
>>>>> The tci failure is easy enough:
>>>>> --8<---------------cut here---------------start------------->8---
>>>>> modified   tests/tcg/x86_64/Makefile.softmmu-target
>>>>> @@ -34,9 +34,11 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
>>>>>     # Running
>>>>>     QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
>>>>>     +ifeq ($(CONFIG_PLUGIN),y)
>>>>>     run-plugin-patch-target-with-libpatch.so:		\
>>>>>     	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true
>>>>>     run-plugin-patch-target-with-libpatch.so:		\
>>>>>     	CHECK_PLUGIN_OUTPUT_COMMAND=$(X64_SYSTEM_SRC)/validate-patch.py $@.out
>>>>>     run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
>>>>>     EXTRA_RUNS+=run-plugin-patch-target-with-libpatch.so
>>>>> +endif
>>>>> --8<---------------cut here---------------end--------------->8---
>>>>> The other problem is trying to stuff a uint64_t into a void * on 32
>>>>> bit.
>>>>> We did disable plugins for 32 bit but then reverted because we were able
>>>>> to fixup the cases:
>>>>>     cf2a78cbbb (deprecation: don't enable TCG plugins by default on 32
>>>>> bit hosts)
>>>>>     db7a06ade1 (configure: reenable plugins by default for 32-bit hosts)
>>>>> So I don't what is easier:
>>>>>     - re-deprecate for 32 bit systems
>>>>>     - only build libpatch on 64 bit systems
>>>>>     - fix libpatch to handle being built on 32 bit systems
>>>>>
>>>>
>>>> More context:
>>>> ../tests/tcg/plugins/patch.c: In function ‘patch_hwaddr’:
>>>> ../tests/tcg/plugins/patch.c:50:21: error: cast from pointer to
>>>> integer of different size [-Werror=pointer-to-int-cast]
>>>>      50 |     uint64_t addr = (uint64_t)userdata;
>>>>         |                     ^
>>>> ../tests/tcg/plugins/patch.c: In function ‘patch_vaddr’:
>>>> ../tests/tcg/plugins/patch.c:93:21: error: cast from pointer to
>>>> integer of different size [-Werror=pointer-to-int-cast]
>>>>      93 |     uint64_t addr = (uint64_t)userdata;
>>>>         |                     ^
>>>> ../tests/tcg/plugins/patch.c: In function ‘vcpu_tb_trans_cb’:
>>>> ../tests/tcg/plugins/patch.c:159:54: error: cast to pointer from
>>>> integer of different size [-Werror=int-to-pointer-cast]
>>>>     159 |                                                      (void *)addr);
>>>>         |                                                      ^
>>>> ../tests/tcg/plugins/patch.c:163:54: error: cast to pointer from
>>>> integer of different size [-Werror=int-to-pointer-cast]
>>>>     163 |                                                      (void *)addr);
>>>>         |
>>>>
>>>> Since we disabled 64 bit targets on 32 bit hosts, and that data passed
>>>> by pointers concern addresses, it should be safe to cast values to
>>>> (uintptr_t) instead of (uint64_t).
>>> Something like this?
>>> --8<---------------cut here---------------start------------->8---
>>> modified   tests/tcg/plugins/patch.c
>>> @@ -47,10 +47,10 @@ static GByteArray *str_to_bytes(const char *str)
>>>      static void patch_hwaddr(unsigned int vcpu_index, void
>>> *userdata)
>>>    {
>>> -    uint64_t addr = (uint64_t)userdata;
>>> +    uintptr_t addr = (uintptr_t) userdata;
>>>        g_autoptr(GString) str = g_string_new(NULL);
>>>        g_string_printf(str, "patching: @0x%"
>>> -                    PRIx64 "\n",
>>> +                    PRIxPTR "\n",
>>>                        addr);
>>>        qemu_plugin_outs(str->str);
>>>    @@ -90,7 +90,7 @@ static void patch_hwaddr(unsigned int
>>> vcpu_index, void *userdata)
>>>      static void patch_vaddr(unsigned int vcpu_index, void *userdata)
>>>    {
>>> -    uint64_t addr = (uint64_t)userdata;
>>> +    uintptr_t addr = (uintptr_t) userdata;
>>>        uint64_t hwaddr = 0;
>>>        if (!qemu_plugin_translate_vaddr(addr, &hwaddr)) {
>>>            qemu_plugin_outs("Failed to translate vaddr\n");
>>> @@ -98,7 +98,7 @@ static void patch_vaddr(unsigned int vcpu_index, void *userdata)
>>>        }
>>>        g_autoptr(GString) str = g_string_new(NULL);
>>>        g_string_printf(str, "patching: @0x%"
>>> -                    PRIx64 " hw: @0x%" PRIx64 "\n",
>>> +                    PRIxPTR " hw: @0x%" PRIx64 "\n",
>>>                        addr, hwaddr);
>>>        qemu_plugin_outs(str->str);
>>>    @@ -132,19 +132,29 @@ static void patch_vaddr(unsigned int
>>> vcpu_index, void *userdata)
>>>     */
>>>    static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>>    {
>>> -    uint64_t addr = 0;
>>>        g_autoptr(GByteArray) insn_data = g_byte_array_new();
>>> +    uintptr_t addr = 0;
>>> +
>>>        for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
>>>            struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
>>> +        uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
>>>              if (use_hwaddr) {
>>> -            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
>>> -            if (!qemu_plugin_translate_vaddr(vaddr, &addr)) {
>>> +            uint64_t hwaddr = 0;
>>> +            if (!qemu_plugin_translate_vaddr(vaddr, &hwaddr)) {
>>>                    qemu_plugin_outs("Failed to translate vaddr\n");
>>>                    continue;
>>>                }
>>> +            /*
>>> +             * As we cannot emulate 64 bit systems on 32 bit hosts we
>>> +             * should never see the top bits set, hence we can safely
>>> +             * cast to uintptr_t.
>>> +             */
>>> +            g_assert(!(hwaddr & ~UINTPTR_MAX));
>>
>> We would have so many other problems before plugins if this hypothesis
>> was not true (all the usage of vaddr type in the codebase would be
>> broken). So the assert will not detect anything we are not aware about
>> already.
>>
>> If we want to mention this assumption for plugins users, the plugins
>> documentation is probably a better place than one random plugin.
> 
> Well we could change the API function signature to return uintptr_t?
>

While it's possible, I personally would favor a fixed ABI for types 
independently of which host config we have. It's less surprising and 
easier to reason about.

For tcg, we have a reason to optimize this, to avoid manipulating 64 
bits data, when we know it's only 32 in reality.

That said, one thing we could enhance on plugins side is to ease passing 
immediate data to a callback, without relying on pointer casting, which 
can be subtly wrong on 32 bits hosts. It's definitely out of the scope 
for this series though.

