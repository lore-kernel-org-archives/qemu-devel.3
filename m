Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DE4C5B552
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 18:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMW0R-0003cQ-Sv; Tue, 03 Jun 2025 14:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMW0Q-0003c8-Pl
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:04:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMW0N-000126-Ah
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:04:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742c035f2afso3966464b3a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748973892; x=1749578692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DnmeDoz8g7+DS8V8jNjQKbLZQ/32aGZt6Q9zLWDgh8M=;
 b=i6qsHrk+sNEf+I1HPwq3Hpw9nVNOUwb3NvAkd9gMqwkt+wg32UC2PLRGZtvxlBgiBs
 Ujinilz+kUQMzdo0KEwq0JKa2blhTGrh4DpJvgRhMMHm5wKczNqNb+mHlEIlC9vecwXw
 ohkq8vjsV/5GQYpOshFVpzVANB4tQzQ1SsS5zLFzCj0gU3+AI2AktK+xDqFkOEw5Ir3E
 L20kO/osNXW4qtzvBHuy9K0n7uMY5vQh5QaD2FsaWlbC2+t9LZzazP6y0T9WOuWVr+Bv
 4uXHirxw/udPAoeBx1aqjgk9fZ+69N6erb6qV6UWrgOqXTFma3jFiuyduL+aWy29x6Sb
 OoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748973892; x=1749578692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DnmeDoz8g7+DS8V8jNjQKbLZQ/32aGZt6Q9zLWDgh8M=;
 b=iP11c/wJp5guC4rFpwJic/IzIOHl65iittsdMS/SqBGWaeC2aTL1zUyO4rzT6bBwPt
 UC3FGmUAbQM+qHqQs7ACoi7TLtXKMqxa0jVjmbYeRgbK75zlqZH1f5NicF71F0+W7mwn
 cD9quAjUw30fYMN0jUQ1TzWf7IrOdrckkq0aDpbve49peo/YHlO2kP8FqZjMP1OKEGmS
 EkGSlrdSGo3P38/A33Rn1DJ30VCzJyNaWiiP0hqLZKaKwp9Fr0BhPRGe2CQ7uP6taGzq
 n2knf849wzNsOds0LBM77vAGk3YsMTfNdUoFoyfewfqAhSflTBSRae5Jf85CrVX9wdGc
 pdBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWOt00DHnlQnE01tN/1oYjqqKx5DrdFaztc4gL9PlUMIWsIRR6PLR3pw9gWWhXS+QGd/5Ya3Wcs+AJ@nongnu.org
X-Gm-Message-State: AOJu0YwhbGGEprrVFKdAweKY1emqpTzhmYWc544UgrShUSlGGjX3Dgv9
 idXFjkuhpHv9RYSWaD1GQCXg/OZFqPNZsfUqEKBcol/ExeW6hOP+ZYWSVXd8T6a4UTJDMVWlfAQ
 O/BM+Z0s=
X-Gm-Gg: ASbGncvJNcBmkKE2wZfkWuKd1TDeS5kR91R6h4hEIK8/rj6HHCupyFMDj18tKUB8B57
 VTVm8e+a01YgcNcmj/iqie+Zq2Hr01SN0rtLYss2W/vXt1fWey19AUT0GO8kbrWkHfGXXu0OBTh
 DsOLZoef6zk9iiAPifaA95N+ryAXeJqi9KWdio0T3o5RgUGLKhqQUuTGCq6URjHT/qKHAygRrQv
 YykF1+7I+rj9lLvE3No6D3b5xA4lXT6GrtZxdJSryQLHPAUqumOB3ftItgCE5KE/KEdG5Ct8Y4q
 cDXNArv7p/DpsSSWESvKIPJIqh7AQ3nYPuwfW5STpyxm2fJfg9B4CZfnH+lApqAZJw4=
X-Google-Smtp-Source: AGHT+IGo2yhw1HC6Lz4jwAAxNbWYM8js2Q4bV0TrMvpdlR1vB+s9VdibJ0BC7s/Ues3qD/pMldENaQ==
X-Received: by 2002:a05:6a00:cc8:b0:742:a23e:2a68 with SMTP id
 d2e1a72fcca58-7480b48cfa1mr39984b3a.15.1748973892396; 
 Tue, 03 Jun 2025 11:04:52 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afff7407sm9937725b3a.178.2025.06.03.11.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 11:04:51 -0700 (PDT)
Message-ID: <102e2e67-4c4d-4912-a892-20f5136f241a@ventanamicro.com>
Date: Tue, 3 Jun 2025 15:04:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: implement SBI debug console (DBCN) calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20240425155012.581366-1-dbarboza@ventanamicro.com>
 <eb6bd3d7-c66b-4300-9573-c29830a3aff4@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <eb6bd3d7-c66b-4300-9573-c29830a3aff4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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



On 6/3/25 10:19 AM, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> (now merged as commit a6b53378f537)
> 
> On 25/4/24 17:50, Daniel Henrique Barboza wrote:
>> SBI defines a Debug Console extension "DBCN" that will, in time, replace
>> the legacy console putchar and getchar SBI extensions.
>>
>> The appeal of the DBCN extension is that it allows multiple bytes to be
>> read/written in the SBI console in a single SBI call.
>>
>> As far as KVM goes, the DBCN calls are forwarded by an in-kernel KVM
>> module to userspace. But this will only happens if the KVM module
>> actually supports this SBI extension and we activate it.
>>
>> We'll check for DBCN support during init time, checking if get-reg-list
>> is advertising KVM_RISCV_SBI_EXT_DBCN. In that case, we'll enable it via
>> kvm_set_one_reg() during kvm_arch_init_vcpu().
>>
>> Finally, change kvm_riscv_handle_sbi() to handle the incoming calls for
>> SBI_EXT_DBCN, reading and writing as required.
>>
>> A simple KVM guest with 'earlycon=sbi', running in an emulated RISC-V
>> host, takes around 20 seconds to boot without using DBCN. With this
>> patch we're taking around 14 seconds to boot due to the speed-up in the
>> terminal output.  There's no change in boot time if the guest isn't
>> using earlycon.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/kvm/kvm-cpu.c         | 111 +++++++++++++++++++++++++++++
>>   target/riscv/sbi_ecall_interface.h |  17 +++++
>>   2 files changed, 128 insertions(+)
> 
> 
>> +static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
>> +{
>> +    g_autofree uint8_t *buf = NULL;
>> +    RISCVCPU *cpu = RISCV_CPU(cs);
>> +    target_ulong num_bytes;
>> +    uint64_t addr;
>> +    unsigned char ch;
>> +    int ret;
>> +
>> +    switch (run->riscv_sbi.function_id) {
>> +    case SBI_EXT_DBCN_CONSOLE_READ:
>> +    case SBI_EXT_DBCN_CONSOLE_WRITE:
>> +        num_bytes = run->riscv_sbi.args[0];
>> +
>> +        if (num_bytes == 0) {
>> +            run->riscv_sbi.ret[0] = SBI_SUCCESS;
>> +            run->riscv_sbi.ret[1] = 0;
>> +            break;
>> +        }
>> +
>> +        addr = run->riscv_sbi.args[1];
>> +
>> +        /*
>> +         * Handle the case where a 32 bit CPU is running in a
>> +         * 64 bit addressing env.
>> +         */
>> +        if (riscv_cpu_mxl(&cpu->env) == MXL_RV32) {
>> +            addr |= (uint64_t)run->riscv_sbi.args[2] << 32;
>> +        }
>> +
>> +        buf = g_malloc0(num_bytes);
>> +
>> +        if (run->riscv_sbi.function_id == SBI_EXT_DBCN_CONSOLE_READ) {
>> +            ret = qemu_chr_fe_read_all(serial_hd(0)->be, buf, num_bytes);
>> +            if (ret < 0) {
>> +                error_report("SBI_EXT_DBCN_CONSOLE_READ: error when "
>> +                             "reading chardev");
>> +                exit(1);
>> +            }
>> +
>> +            cpu_physical_memory_write(addr, buf, ret);
>> +        } else {
>> +            cpu_physical_memory_read(addr, buf, num_bytes);
>> +
>> +            ret = qemu_chr_fe_write_all(serial_hd(0)->be, buf, num_bytes);
>> +            if (ret < 0) {
>> +                error_report("SBI_EXT_DBCN_CONSOLE_WRITE: error when "
>> +                             "writing chardev");
>> +                exit(1);
>> +            }
>> +        }
>> +
>> +        run->riscv_sbi.ret[0] = SBI_SUCCESS;
>> +        run->riscv_sbi.ret[1] = ret;
>> +        break;
>> +    case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
>> +        ch = run->riscv_sbi.args[0];
>> +        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
>> +
>> +        if (ret < 0) {
>> +            error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error when "
>> +                         "writing chardev");
>> +            exit(1);
>> +        }
> 
> We are ignoring partial writes (non-blocking call returning 0 byte
> written), is that expected? If so, is it OK to add a comment we can
> safely discard not-yet-written DBCN_CONSOLE_WRITE_BYTE?

Not sure what you meant. IIUC qemu_chr_fe_write() returns the number
of bytes consumed, 0 if no chardev is found, and -1 on error. Are you
saying that we should do a loop when there's no chardev found (ret = 0)
and wait a certain time until there's one available?


In fact, seeing how SBI_EXT_DBCN_CONSOLE_WRITE is written, I wonder if
we could use qemu_chr_fe_write_all() in this case too. Thanks,


Daniel



> 
>> +
>> +        run->riscv_sbi.ret[0] = SBI_SUCCESS;
>> +        run->riscv_sbi.ret[1] = 0;
>> +        break;
>> +    default:
>> +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
>> +    }
>> +}


