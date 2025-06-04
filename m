Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86771C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 10:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMllg-0001gY-3Z; Wed, 04 Jun 2025 06:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMlle-0001fv-PM
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:54:46 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMllc-0000WF-N3
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:54:46 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-87df943b6dcso1501994241.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749034483; x=1749639283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=apmfOP4Rp497ljxAggMmJaQTwC4oUaYLeroIYEOwTrs=;
 b=BEJE7QY8LLaOHSStMD37GFeWl5H1tMCpS2gYAkjV15YGH5JJaWDX/IQiHQHzvnYIN1
 PLLDB6oVXM75e84xN4j7RblDsWc1rvIt9qey53cnToLhOyJaoatMK0y/xt4YJGEgMuCz
 GuX4iMPEQJ2ESno4qQ82aHvpldaPhgSoPfeeTpqcJopQk71QtuF6aL+lSnYyYELDcrs3
 jycfiJqlMZHClk5eBzxnyty0y0Ma/OOPF+ZIvOSxu9ppReJU6rCAGidUXtweX8//c9nu
 gDge6dN0kxgwg7MxScE0/eWBPjuQ7d6ZaS+iF66NTBjSoECmHWSKBXwYA/nmGRfKsIT3
 BIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749034483; x=1749639283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=apmfOP4Rp497ljxAggMmJaQTwC4oUaYLeroIYEOwTrs=;
 b=QVvOq4pG0/jqyhO0QfcKtgV4VedpvzbAtDxLbCW6Vdg+Dj2P50gky8YMDCOrJ1jo2i
 hDg3GbssVbvIwY9mivVFKI5nLYFxKZjkT7X4NOUnjJQM5/RfDlEzhP6vLM138Me/ms7U
 TtgKlLcdfuwtdadrq+L6klNJUO6OOuEeXHgFt/jW0JKvhqPEdNj7DeY+fyzUyp+hNJhz
 CpmlgpSP0SFBakYxQUizBBMwE+9b21lMo92tRz80x8Yk05JEJtpk/Le2VlH6rN/0c2dN
 FLM3aH9HJxZGGgUcMy8nSAwb6iQTfVS2OsJJKkLnfjEMhMBBMPNuXR7ZgW8JCdRhWYEq
 oqZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRTF0DOoULKd7JZXlJTssyiDpHwECwcIz3fvEvgLyvVLLIBHiagDicxX1CN76NStCnJZFrR/+lOh4x@nongnu.org
X-Gm-Message-State: AOJu0Yz+KvdTlKFttKlvo2Kh5ylPfZU1cB7YOvOajezBd1cdBkAqARPI
 v9fqGBlt9H8l53NnW639WOWPSujq45ynDPNKP8dWE/UYxwTFTqB6rWpXVRnRifkr4Uo=
X-Gm-Gg: ASbGncsyt+VdPuvStGiGIMLGQ1wl22HEXm3Gjp19WPqmV2V39UROqZLYuSNaGsh+Wnt
 hwvZHXxHGyTaWkuUDK6BtFP2hdFot0NeMaKE2DiOmiGyIQ4hg3/GM/P/7RWii79szJv3Dc9+RjM
 4zE8MLECEPFXKLZCiheUy5qgi97x3RWJiCrQv0uNAIxZrX7PSP9o0WznuxJzzlYMDObRHZp+u+R
 psr3DPveqS7b2i6aOo6PZKMTzfsz7Dx9RZjPC3Hfg2HYz4f52w/bi5zazcNG+JQyV6aWfbyYJdf
 axx5UF1SgTjtN9V8MJbktfJgjppM/F1S8m8Se58FwnXeKvFULYoiRUGoExFCjeD85qaXLCBwIah
 444bV/QG/g8puJmlO5MQ71ruTUBtO8g==
X-Google-Smtp-Source: AGHT+IFwEdrNUo00/5f3h09p6IwauUnqxckpH9djuKmUSeSrar4YqB9+/U/J446QsEtt233hic3oIQ==
X-Received: by 2002:a05:6102:4406:b0:4e5:ac0f:582c with SMTP id
 ada2fe7eead31-4e746ddab63mr998957137.13.1749034482788; 
 Wed, 04 Jun 2025 03:54:42 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:8f02:a679:333c:d017:a155?
 ([2804:7f0:bcc0:8f02:a679:333c:d017:a155])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e6444964casm9865070137.13.2025.06.04.03.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 03:54:42 -0700 (PDT)
Message-ID: <c2b0fb25-8b17-4a69-a128-2f8cc9bbba76@ventanamicro.com>
Date: Wed, 4 Jun 2025 07:54:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: implement SBI debug console (DBCN) calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240425155012.581366-1-dbarboza@ventanamicro.com>
 <eb6bd3d7-c66b-4300-9573-c29830a3aff4@linaro.org>
 <102e2e67-4c4d-4912-a892-20f5136f241a@ventanamicro.com>
 <47327da2-be3c-4aaa-ab3d-36e8d0c25185@linaro.org>
 <0eb5bcf9-bc2e-46c6-9f54-1514039557e0@ventanamicro.com>
 <37e6fecd-948a-4840-9189-918d44c0be72@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <37e6fecd-948a-4840-9189-918d44c0be72@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/4/25 6:38 AM, Philippe Mathieu-Daudé wrote:
> (+Marc-André and Paolo who I forgot to Cc first)
> 
> On 4/6/25 11:17, Daniel Henrique Barboza wrote:
>>
>>
>> On 6/4/25 4:32 AM, Philippe Mathieu-Daudé wrote:
>>> On 3/6/25 20:04, Daniel Henrique Barboza wrote:
>>>>
>>>>
>>>> On 6/3/25 10:19 AM, Philippe Mathieu-Daudé wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> (now merged as commit a6b53378f537)
>>>>>
>>>>> On 25/4/24 17:50, Daniel Henrique Barboza wrote:
>>>>>> SBI defines a Debug Console extension "DBCN" that will, in time, replace
>>>>>> the legacy console putchar and getchar SBI extensions.
>>>>>>
>>>>>> The appeal of the DBCN extension is that it allows multiple bytes to be
>>>>>> read/written in the SBI console in a single SBI call.
>>>>>>
>>>>>> As far as KVM goes, the DBCN calls are forwarded by an in-kernel KVM
>>>>>> module to userspace. But this will only happens if the KVM module
>>>>>> actually supports this SBI extension and we activate it.
>>>>>>
>>>>>> We'll check for DBCN support during init time, checking if get-reg- list
>>>>>> is advertising KVM_RISCV_SBI_EXT_DBCN. In that case, we'll enable it via
>>>>>> kvm_set_one_reg() during kvm_arch_init_vcpu().
>>>>>>
>>>>>> Finally, change kvm_riscv_handle_sbi() to handle the incoming calls for
>>>>>> SBI_EXT_DBCN, reading and writing as required.
>>>>>>
>>>>>> A simple KVM guest with 'earlycon=sbi', running in an emulated RISC-V
>>>>>> host, takes around 20 seconds to boot without using DBCN. With this
>>>>>> patch we're taking around 14 seconds to boot due to the speed-up in the
>>>>>> terminal output.  There's no change in boot time if the guest isn't
>>>>>> using earlycon.
>>>>>>
>>>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>>>> ---
>>>>>>   target/riscv/kvm/kvm-cpu.c         | 111 ++++++++++++++++++++++++ +++++
>>>>>>   target/riscv/sbi_ecall_interface.h |  17 +++++
>>>>>>   2 files changed, 128 insertions(+)
>>>>>
>>>>>
>>>>>> +static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
>>>>>> +{
>>>>>> +    g_autofree uint8_t *buf = NULL;
>>>>>> +    RISCVCPU *cpu = RISCV_CPU(cs);
>>>>>> +    target_ulong num_bytes;
>>>>>> +    uint64_t addr;
>>>>>> +    unsigned char ch;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    switch (run->riscv_sbi.function_id) {
>>>>>> +    case SBI_EXT_DBCN_CONSOLE_READ:
>>>>>> +    case SBI_EXT_DBCN_CONSOLE_WRITE:
>>>>>> +        num_bytes = run->riscv_sbi.args[0];
>>>>>> +
>>>>>> +        if (num_bytes == 0) {
>>>>>> +            run->riscv_sbi.ret[0] = SBI_SUCCESS;
>>>>>> +            run->riscv_sbi.ret[1] = 0;
>>>>>> +            break;
>>>>>> +        }
>>>>>> +
>>>>>> +        addr = run->riscv_sbi.args[1];
>>>>>> +
>>>>>> +        /*
>>>>>> +         * Handle the case where a 32 bit CPU is running in a
>>>>>> +         * 64 bit addressing env.
>>>>>> +         */
>>>>>> +        if (riscv_cpu_mxl(&cpu->env) == MXL_RV32) {
>>>>>> +            addr |= (uint64_t)run->riscv_sbi.args[2] << 32;
>>>>>> +        }
>>>>>> +
>>>>>> +        buf = g_malloc0(num_bytes);
>>>>>> +
>>>>>> +        if (run->riscv_sbi.function_id == SBI_EXT_DBCN_CONSOLE_READ) {
>>>>>> +            ret = qemu_chr_fe_read_all(serial_hd(0)->be, buf, num_bytes);
>>>>>> +            if (ret < 0) {
>>>>>> +                error_report("SBI_EXT_DBCN_CONSOLE_READ: error when "
>>>>>> +                             "reading chardev");
>>>>>> +                exit(1);
>>>>>> +            }
>>>>>> +
>>>>>> +            cpu_physical_memory_write(addr, buf, ret);
>>>>>> +        } else {
>>>>>> +            cpu_physical_memory_read(addr, buf, num_bytes);
>>>>>> +
>>>>>> +            ret = qemu_chr_fe_write_all(serial_hd(0)->be, buf, num_bytes);
>>>>>> +            if (ret < 0) {
>>>>>> +                error_report("SBI_EXT_DBCN_CONSOLE_WRITE: error when "
>>>>>> +                             "writing chardev");
>>>>>> +                exit(1);
>>>>>> +            }
>>>>>> +        }
>>>>>> +
>>>>>> +        run->riscv_sbi.ret[0] = SBI_SUCCESS;
>>>>>> +        run->riscv_sbi.ret[1] = ret;
>>>>>> +        break;
>>>>>> +    case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
>>>>>> +        ch = run->riscv_sbi.args[0];
>>>>>> +        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
>>>>>> +
>>>>>> +        if (ret < 0) {
>>>>>> +            error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error when "
>>>>>> +                         "writing chardev");
>>>>>> +            exit(1);
>>>>>> +        }
>>>>>
>>>>> We are ignoring partial writes (non-blocking call returning 0 byte
>>>>> written), is that expected? If so, is it OK to add a comment we can
>>>>> safely discard not-yet-written DBCN_CONSOLE_WRITE_BYTE?
>>>>
>>>> Not sure what you meant. IIUC qemu_chr_fe_write() returns the number
>>>> of bytes consumed, 0 if no chardev is found, and -1 on error.
>>>
>>> I'm trying to address an issue Peter reported with qemu_chr_fe_write():
>>> https://lore.kernel.org/qemu-devel/ CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/
>>>
>>> Basically upon introduction in commit cd18720a294 in 2013
>>> ("char: introduce a blocking version of qemu_chr_fe_write") the API
>>> contract was "Returns: the number of bytes consumed" which could be 0,
>>> so some frontends return 0 for "wrote no bytes".
>>>
>>> Later in 2016 in commit fa394ed6257 ("char: make some qemu_chr_fe
>>> skip if no driver") the API documentation was changed:
>>>
>>> - * Returns: the number of bytes consumed
>>> + * Returns: the number of bytes consumed (0 if no assicated CharDriver)
>>>
>>> After this commit, some frontends started to handle '<=0' as error,
>>> while 0 is not an error.
>>
>> I think I got the gist of it, thanks.
>>
>> For this particular console call the spec says:
>>
>> "This is a blocking SBI call and it will only return after writing the specified
>> byte to the debug console. It will also return, with SBI_ERR_FAILED, if there are
>> I/O errors."
>>
>>
>> So I think it pairs well with the blocking version qemu_chr_fe_write_all()
>> instead. I can do this change and get out of your way in changing the callers
>> of qemu_chr_fe_write().
> 
> I appreciate if you post the patch (this is a 1 line change, but what
> matters here is the justification you just provided), but if you are
> busy I can do it, I have enough information to write the commit desc.

I can handle this change, don't worry about it. I'll send it out today.

> 
>>
>> But I still have questions, hehe. This blocking version has the following
>> doc:
>>
>> "(...) Unlike @qemu_chr_fe_write, this function will block if the back end
>> cannot consume all of the data attempted to be written. This function is
>> thread-safe.
>>
>> Returns: the number of bytes consumed (0 if no associated Chardev)
>> or -1 on error."
>>
>> Do we have plans to change this API like we're doing with the non-blocking
>> version? Because being a blocking call that promises "block until all bytes
>> are written", and I have len  > 0, I don't expect a ret = 0 to be interpret
>> as "no bytes were written".  I am ok with ret = 0 being 'no associated chardev'
>> and not handling it as an error (for now at least) but I would like to confirm
>> that qemu_chr_fe_write_all() will not interpret ret = 0 as a zero byte write.
>> In other words, if for some reason other than "no chardev present" we ended up
>> with zero bytes written I would like a ret < 0 return.
> 
> Correct. Clarifying this method is in my TODO. What about this example:
> 
> - frontend wants to block to write 8 bytes
> - backend writes 5 bytes, hits an unrecoverable link error
> 
> Should the backend support be responsible to re-establish link and retry
> (when possible) to complete?
> 
> If we return -1 for error, could the frontend try to reconnect and write
> the 8 bytes, ending with the first 5 bytes being transmitted twice?
> 
> Meanwhile I'm thinking to document as:
> 
> "Returns @len on success, or -1 on error (some data might has been written)".
> 

This make sense to me. It also goes in line with what Daniel mentioned in
his reply. I'll make the change with this semantic in mind.


Thanks,

Daniel




> Simpler API could be: "Returns 0 on success, otherwise -errno" but
> we'd need to rework all the callers.
> 
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>
>>>
>>>> Are you
>>>> saying that we should do a loop when there's no chardev found (ret = 0)
>>>> and wait a certain time until there's one available?
>>>>
>>>>
>>>> In fact, seeing how SBI_EXT_DBCN_CONSOLE_WRITE is written, I wonder if
>>>> we could use qemu_chr_fe_write_all() in this case too.
>>>
>>> This is certainly simpler.
>>>
>>> Regards,
>>>
>>> Phil.
>>
> 


