Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6172CCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 13:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squOF-0004jY-Uk; Wed, 18 Sep 2024 09:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1squOE-0004ib-5e
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:06:38 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1squOB-0004Ln-SR
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:06:37 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 90C6E3F594
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726664792;
 bh=8l2x542gYIchymchoFuMWg32uMUCoYpfBV/jXlvRWAk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=PG7SvGYRuAHjL/d5F0CeYdwgdrZJZ09hIvIBF+xe6dHYse1SZgAFUxvqeUJJgoxrF
 xHEbXKid76HeNo1FkhEYH7sFO6+zlwpmzprUmE2C7BQpfZe6kovI6RiF99D1K0pOnM
 MKO1QLYKvvJE4y/c/HyzLtIc6y8vBjoA0c+rnAJwve8U4ChL6ClZYsWZ+lk7O7bxic
 dAKzXY9o0rRbfornP+y0jlcI0qaYcAsxbSMp8Mfviq/+ircRLev6zCxJUdJbXdAYUJ
 VE/sBDEsbFu+GnFHlmOgrOYSJpGHgp65bdMy/fAhnQlv+n7w3VN3IfNVpPLjghgNrU
 aXNLWxfu2KYLw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb236ad4aso44199405e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 06:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726664792; x=1727269592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8l2x542gYIchymchoFuMWg32uMUCoYpfBV/jXlvRWAk=;
 b=PoBYBaAMc9JJ7vXmvok7/Y9NmrPnZGywogVrs99zs3GXZU5RwukPCJ5QZCu1VzgSn4
 NJN65RSORdpnWCXCDBb8dhgOKA5mBpXvaRg+Uh0m+SmAE6jZJmyb5mmvSyTr2GbQNeuz
 z85QApEFZ36xtCwpw0EFhgfSt+KSxm2QRJbLOYWZvnEbgHqemppukqITE1M5VkPJIUGJ
 LDIq7RNO1Qc/hZY2JikROdTfrW5VOD7kQ5LCKE33vrtPwrGprZ9oabTgCEaCrG0hI7hv
 DyJNyF4HRiNVYn+UiSOzvUmotyNTIFqJYaC92PxAwTGfsoFAeRtsS0jetcM5mpU7cdEn
 P9tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnmNtfDk7vooz33pxkbSzESCnK9WkiBAG34gs5uWrKWiLvHQYzPq0Xe/kPibjPWDozdpMYdujDBQeU@nongnu.org
X-Gm-Message-State: AOJu0YzRjdEVy2BvocKxYH2IynJ6+xhrGbmmbE7hKk1u58aG575oMTQz
 orG1VOYbA4TP5LR1ugOBwWW9MuvjiFy1mj/gQNUmvwyEQteTV2pjapTdB8KBFfsW98PjP74Nw5H
 m3spfVF1Izr145BFYTrkoQg+d4PBHRBvREiapoPZxcGkt7PkZTaod0/PyaiTBB8CXI05M
X-Received: by 2002:a05:600c:511b:b0:42c:a72a:e8f4 with SMTP id
 5b1f17b1804b1-42cdb5317cbmr172610045e9.14.1726664791863; 
 Wed, 18 Sep 2024 06:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENUt5bat+VyuH/X8ftjxUcPkWydjb9viwhSYt5aRmGL/qmuhxrHiMPPpyLNd/r+qN+rQ2zTw==
X-Received: by 2002:a05:600c:511b:b0:42c:a72a:e8f4 with SMTP id
 5b1f17b1804b1-42cdb5317cbmr172609685e9.14.1726664791267; 
 Wed, 18 Sep 2024 06:06:31 -0700 (PDT)
Received: from [192.168.103.101]
 (dynamic-046-114-111-082.46.114.pool.telefonica.de. [46.114.111.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f99b0sm12303634f8f.60.2024.09.18.06.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 06:06:30 -0700 (PDT)
Message-ID: <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
Date: Wed, 18 Sep 2024 15:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel>
 <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
 <20240918-039d1e3bebf2231bd452a5ad@orel>
 <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 18.09.24 13:10, Peter Maydell wrote:
> On Wed, 18 Sept 2024 at 07:06, Andrew Jones <ajones@ventanamicro.com> wrote:
>>
>> On Tue, Sep 17, 2024 at 06:45:21PM GMT, Heinrich Schuchardt wrote:
>> ...
>>> When thinking about the migration of virtual machines shouldn't QEMU be in
>>> control of the initial state of vcpus instead of KVM?
>>>
>>
>> Thinking about this more, I'm inclined to agree. Initial state and reset
>> state should be traits of the VMM (potentially influenced by the user)
>> rather than KVM.
> 
> Mmm. IIRC the way this works on Arm at least is that at some point
> post-reset and before running the VM we do a QEMU->kernel state
> sync, which means that whatever the kernel does with the CPU state
> doesn't matter, only what QEMU's idea of reset is. Looking at the
> source I think the way this happens is that kvm_cpu_synchronize_post_reset()
> arranges to do a kvm_arch_put_registers(). (For Arm we have to do
> some fiddling around to make sure our CPU state is in the right
> place for that put_registers to DTRT, which is what kvm_arm_reset_vcpu()
> is doing, but that's a consequence of the way we chose to handle
> migration and in particular migration of system registers rather than
> something necessarily every architecture wants to be doing.)
> 
> This also works for reset of the vCPU on a guest-reboot. We don't
> tell KVM to reset the vCPU, we just set up the vCPU state on the
> QEMU side and then do a QEMU->kernel state sync of it.
> 
> -- PMM

Thanks Peter for looking into this.

QEMU's cpu_synchronize_all_post_init() and 
do_kvm_cpu_synchronize_post_reset() both end up in 
kvm_arch_put_registers() and that is long after Linux 
kvm_arch_vcpu_create() has been setting some FPU state. See the output 
below.

kvm_arch_put_registers() copies the CSRs by calling 
kvm_riscv_put_regs_csr(). Here we can find:

     KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);

This call enables or disables the FPU according to the value of 
env->mstatus.

So we need to set the desired state of the floating point unit in QEMU. 
And this is what the current patch does both for TCG and KVM.

Best regards

Heinrich


$ qemu-system-riscv64 -M virt -accel kvm -nographic -kernel payload.bin
QEMU qemu_init: Entry
QEMU qmp_x_exit_preconfig: Entry
[ 3503.369249] kvm_arch_vcpu_create: Entry
[ 3503.369669] kvm_riscv_vcpu_fp_reset: At entry FS=0
[ 3503.369966] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[ 3503.370256] kvm_arch_vcpu_create: Exit
[ 3503.378620] kvm_arch_vcpu_create: Entry
[ 3503.379123] kvm_riscv_vcpu_fp_reset: At entry FS=0
[ 3503.379610] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[ 3503.380111] kvm_arch_vcpu_create: Exit
[ 3503.394837] kvm_arch_vcpu_create: Entry
[ 3503.395238] kvm_riscv_vcpu_fp_reset: At entry FS=0
[ 3503.395585] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[ 3503.395947] kvm_arch_vcpu_create: Exit
[ 3503.397023] kvm_riscv_vcpu_set_reg_config:
[ 3503.398066] kvm_riscv_vcpu_set_reg_config:
[ 3503.398430] kvm_riscv_vcpu_set_reg_config:
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
QEMU qemu_machine_creation_done: Entry
QEMU qdev_machine_creation_done: Entry
QEMU cpu_synchronize_all_post_init: Entry
QEMU cpu_synchronize_post_init: Entry
QEMU kvm_cpu_synchronize_post_init: Entry
QEMU do_kvm_cpu_synchronize_post_init: Entry
QEMU kvm_arch_put_registers: Entry
QEMU kvm_riscv_put_regs_csr: Entry
QEMU kvm_riscv_put_regs_csr: Exit
QEMU kvm_arch_put_registers: Exit
QEMU do_kvm_cpu_synchronize_post_init: Exit
QEMU kvm_cpu_synchronize_post_init: Exit
QEMU cpu_synchronize_post_init: Exit
QEMU cpu_synchronize_all_post_init: Exit
QEMU qemu_system_reset: Entry
QEMU kvm_arch_get_registers: Entry
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
QEMU cpu_synchronize_all_post_reset: Entry
QEMU cpu_synchronize_post_reset: Entry
QEMU do_kvm_cpu_synchronize_post_reset: Entry
QEMU kvm_arch_put_registers: Entry
QEMU kvm_riscv_put_regs_csr: Entry
QEMU kvm_riscv_put_regs_csr: Exit
QEMU kvm_riscv_sync_mpstate_to_kvm: Entry
QEMU kvm_riscv_sync_mpstate_to_kvm: Exit
QEMU kvm_arch_put_registers: Exit
QEMU do_kvm_cpu_synchronize_post_reset: Exit
QEMU cpu_synchronize_post_reset: Exit
QEMU cpu_synchronize_all_post_reset: Exit
QEMU qemu_system_reset: Exit
QEMU qdev_machine_creation_done: Exit
QEMU qmp_x_exit_preconfig: Exit
QEMU qemu_init: Exit
QEMU kvm_cpu_exec: Entry
[ 3503.566493] kvm_arch_vcpu_ioctl_run: run->ext_reason 0
QEMU kvm_cpu_exec: Exit
QEMU kvm_cpu_exec: Entry
[ 3503.568338] kvm_arch_vcpu_ioctl_run: run->ext_reason 0
[ 3503.568740] kvm_riscv_check_vcpu_requests: Entry
[ 3503.569534] kvm_riscv_check_vcpu_requests: Entry

Test payload
============


