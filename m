Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C0DC5B555
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMRYW-0006a3-Q2; Tue, 03 Jun 2025 09:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMRYP-0006Yl-6A
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 09:19:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMRYK-0007jK-SQ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 09:19:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so22748785e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748956777; x=1749561577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pT2eBUGhOkjoueuI1Sf97uLzV4Sk7Vq1sawGHZtgE+c=;
 b=GMAhF1Jsg1MuKq8CtHUYY3iRazrAm4zWyV7iaEmR3gRdNrP101K76KUlsGCWWcqbuJ
 YK0CCVedr0SNXxQdxR3oUj7BAe8EVEyC0+qjdjR8ASS7D+gAEnH/nqEFFFInRINom5Hc
 KAyjEbKL2FJuccYVo0fMMhPgha2WDa7RLsyrQ/qlc04P7gFWp9aZw02ZZxCZbJgDq8bp
 wE0CXGzhikP/pO1mbMB0Y1u/EyMHlGfrB/BPXl3obpzz+qJ5cgv79c5neWftmbPyjryr
 2bKFVTrABeCFBz3boQlMDua/FyFg6vMEd+XGJZwDSRTFbu70+OMuB8tPw/1jEj4CowHf
 puGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748956777; x=1749561577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pT2eBUGhOkjoueuI1Sf97uLzV4Sk7Vq1sawGHZtgE+c=;
 b=XtVxaV13Cn8r3lq6s6QQ944tg0JnHC5tKpB1wH+K5WS3h33aZWBziedQo7A6Xuwn7R
 SJXMSX+IcnfZGTWn/lIh1/tlKrPuHNaGuLyYh+/fMO3kuh+z7/ovHeyhqBCaAf2Q6E0w
 OIB1CdX2WXoTuc8D8BdOrMGwpxj68FQ66D0gYWQEzGCZCyzr8TwKyKSPVFWoOdfKkbdb
 sdJjdBIdF72Uh5bp8wyCBDMk6L/WCgL0S+DEfqY+gILBoZFOgbKNNi1Ep7uPtz0c3jLR
 IMaO7QxKPnIWVOJZkawn5BOoPmZqORKP+HouFIO6dawC6X7Er7MutYCNPv9aV+c4xaxu
 95Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcMHgyVvBYm+VHDDcRZTtR+3zd0MYMHo009JvIL0NbsvzpcghrIO25jz4E2+waZQdCiukGWnKy0bw5@nongnu.org
X-Gm-Message-State: AOJu0YxBoDXMfVgfz+x9abPWE5eidB5Wrn+48rjCNxYIxwGuMnMsw0GP
 jWVw/nNDmg4f18HZIJnSrBteuLBpXj0ojfaVZCeNtXdydXCUPCodEjMM5knXlUMYBq9Hkyx3dOw
 3ugUtOZ0=
X-Gm-Gg: ASbGncs+dK/euQmA0SXMtbBdycOEbIr2azC8UtPiDIo4boqYLEu5Z29bbaOolFzzUxi
 7wMrcIB4XkomoptiLgAH8QYKDd26vXHCvHHrNnXu9QOMMg51VEeEeZGUjaITgi0EXdeNe70AjrF
 6PsBEGeyVRkOiz2bnh8hAPsxY2gnKYiknNouCUw5OBy3djhpI3MXPgyaLM48w4tr2Q+GVJxQQZm
 c53PSbZTLErsaEBknC8i8aAClv3njVS8CrjR6mUoNqNKJ//CUi6qDLOuM77mL1WGAQeGsHWGfIE
 jsSF7UL1wT9fQbXXCkU847Jo2LlnKW8jaaFMSiFIZyMZ2lESlbbh2N2hQOyC1qTm5Esg0bPfkxW
 3/2iKSCOa4G3CVjCVRQ9XNkduFWKBggjervI=
X-Google-Smtp-Source: AGHT+IHxQ82b6ar1O4FPf34PrTHNJY9aomusPKxyHye9JbMt+qdZ6V71eISnSz/wyRgUUcpFIDk8Yg==
X-Received: by 2002:a05:6000:250d:b0:3a4:d7ba:941e with SMTP id
 ffacd0b85a97d-3a4f7a353e4mr13503633f8f.25.1748956776695; 
 Tue, 03 Jun 2025 06:19:36 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b7a5sm18465376f8f.15.2025.06.03.06.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 06:19:36 -0700 (PDT)
Message-ID: <eb6bd3d7-c66b-4300-9573-c29830a3aff4@linaro.org>
Date: Tue, 3 Jun 2025 15:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: implement SBI debug console (DBCN) calls
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20240425155012.581366-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240425155012.581366-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Daniel,

(now merged as commit a6b53378f537)

On 25/4/24 17:50, Daniel Henrique Barboza wrote:
> SBI defines a Debug Console extension "DBCN" that will, in time, replace
> the legacy console putchar and getchar SBI extensions.
> 
> The appeal of the DBCN extension is that it allows multiple bytes to be
> read/written in the SBI console in a single SBI call.
> 
> As far as KVM goes, the DBCN calls are forwarded by an in-kernel KVM
> module to userspace. But this will only happens if the KVM module
> actually supports this SBI extension and we activate it.
> 
> We'll check for DBCN support during init time, checking if get-reg-list
> is advertising KVM_RISCV_SBI_EXT_DBCN. In that case, we'll enable it via
> kvm_set_one_reg() during kvm_arch_init_vcpu().
> 
> Finally, change kvm_riscv_handle_sbi() to handle the incoming calls for
> SBI_EXT_DBCN, reading and writing as required.
> 
> A simple KVM guest with 'earlycon=sbi', running in an emulated RISC-V
> host, takes around 20 seconds to boot without using DBCN. With this
> patch we're taking around 14 seconds to boot due to the speed-up in the
> terminal output.  There's no change in boot time if the guest isn't
> using earlycon.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/kvm/kvm-cpu.c         | 111 +++++++++++++++++++++++++++++
>   target/riscv/sbi_ecall_interface.h |  17 +++++
>   2 files changed, 128 insertions(+)


> +static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
> +{
> +    g_autofree uint8_t *buf = NULL;
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    target_ulong num_bytes;
> +    uint64_t addr;
> +    unsigned char ch;
> +    int ret;
> +
> +    switch (run->riscv_sbi.function_id) {
> +    case SBI_EXT_DBCN_CONSOLE_READ:
> +    case SBI_EXT_DBCN_CONSOLE_WRITE:
> +        num_bytes = run->riscv_sbi.args[0];
> +
> +        if (num_bytes == 0) {
> +            run->riscv_sbi.ret[0] = SBI_SUCCESS;
> +            run->riscv_sbi.ret[1] = 0;
> +            break;
> +        }
> +
> +        addr = run->riscv_sbi.args[1];
> +
> +        /*
> +         * Handle the case where a 32 bit CPU is running in a
> +         * 64 bit addressing env.
> +         */
> +        if (riscv_cpu_mxl(&cpu->env) == MXL_RV32) {
> +            addr |= (uint64_t)run->riscv_sbi.args[2] << 32;
> +        }
> +
> +        buf = g_malloc0(num_bytes);
> +
> +        if (run->riscv_sbi.function_id == SBI_EXT_DBCN_CONSOLE_READ) {
> +            ret = qemu_chr_fe_read_all(serial_hd(0)->be, buf, num_bytes);
> +            if (ret < 0) {
> +                error_report("SBI_EXT_DBCN_CONSOLE_READ: error when "
> +                             "reading chardev");
> +                exit(1);
> +            }
> +
> +            cpu_physical_memory_write(addr, buf, ret);
> +        } else {
> +            cpu_physical_memory_read(addr, buf, num_bytes);
> +
> +            ret = qemu_chr_fe_write_all(serial_hd(0)->be, buf, num_bytes);
> +            if (ret < 0) {
> +                error_report("SBI_EXT_DBCN_CONSOLE_WRITE: error when "
> +                             "writing chardev");
> +                exit(1);
> +            }
> +        }
> +
> +        run->riscv_sbi.ret[0] = SBI_SUCCESS;
> +        run->riscv_sbi.ret[1] = ret;
> +        break;
> +    case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
> +        ch = run->riscv_sbi.args[0];
> +        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
> +
> +        if (ret < 0) {
> +            error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error when "
> +                         "writing chardev");
> +            exit(1);
> +        }

We are ignoring partial writes (non-blocking call returning 0 byte
written), is that expected? If so, is it OK to add a comment we can
safely discard not-yet-written DBCN_CONSOLE_WRITE_BYTE?

> +
> +        run->riscv_sbi.ret[0] = SBI_SUCCESS;
> +        run->riscv_sbi.ret[1] = 0;
> +        break;
> +    default:
> +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
> +    }
> +}

