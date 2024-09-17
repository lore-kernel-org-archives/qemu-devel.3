Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E367C35FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 13:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqYGL-0004Ev-Ch; Tue, 17 Sep 2024 09:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqYGG-0004Bd-Go
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 09:28:56 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqYG8-0001Xq-75
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 09:28:53 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EEC103F1E0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726579725;
 bh=+9JqzmxnIPvJunXbVafObTwwY3WDwz8ViieNzrF2UmQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=F40YMocGNV0uv5Gd0w9VutvrVYUv5BqIY5gLyVrJLS8xvoheKuHmpt5/MK+npAS8M
 m2PZHsAZuzVgYd6zcCWsO6+yK8Lel58z3cb4Vc3V8oHtE7vz5OkwMEEx7pvGKtEDPK
 nVC6l1wRTICoPBGR0xwrNRB7ooMFE0XF27+PxDWX25OpWZT7bGrWnRClvKo8n2eGq4
 rT/60ae0mTTgxmeuXnNf52GOWDY+lPo5ZQ6gY8yRJeulg+6PZn3e8J7pwDhjc8YMYC
 lJGzNPr7xa+YZMvgZudE/znXEdbXhpM1xH6AONOqVeCDfQZwmfqYSUAwsMYL9hfdTR
 I4+hr16C0eUdQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cceb06940so39779105e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 06:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726579725; x=1727184525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+9JqzmxnIPvJunXbVafObTwwY3WDwz8ViieNzrF2UmQ=;
 b=Um9dHpHQSQJAym8seMp+Hl4HfEqy7Vn1DI0MVYSTu1759Ew6AFkQRhWwpgMBH/WHrv
 0DaPxLC9Edj5u5fasOjIlLrAY9K+r8A49qLOktaLGi/RvfcpFldLH35KVDC1PJ6XsLSR
 0Qq3jqvyBXKbQBGFc2bFYcU0hqO05zoUAcAmGnCTJNDxgtUvl3Fnt70MTYTVJjRdviK4
 jWslmhlDnyROZZeFAAI551kmZ2rw3pQWC2IK7jYzUZSwHSBPaVul1hB+iQiIXfBRo0E9
 vsvYdFyT6JorF1TPVVV+1rmXMlXGEcGU/h/y+/57auOn72sMvLx5WzNqWqDr5+dsc5oR
 Q/ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzzKGqFAQ8MQ2be2FnbihHEzUma3kkn9L5JcNZDkUouoH10EYlU+WtMXmghvyFEh3giH/D0DGEubCe@nongnu.org
X-Gm-Message-State: AOJu0YzzaAQ8W/euOVTOauUOFs0+5nfQkKQc1Z2L+PUUTABNcAmXJE+Z
 hTnLw9oP4zcvlP07DEOZhuCccBH3cfBe93gnBe5zFqpji7Cr36H50QBgBluK17tprqkoRlZQVBE
 YZFhFLdXTtGFXL+o1AAg1jbQ1jSkvjtQZSIgHgtgypbQMQ84NpAq12M27ZiL7lER88lKR
X-Received: by 2002:a05:600c:468a:b0:42c:b309:8d18 with SMTP id
 5b1f17b1804b1-42cdb53be54mr126240155e9.19.1726579725265; 
 Tue, 17 Sep 2024 06:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtJH6TSZU5ZjrQN49f/7Zg6VVpJsXF+C7Pf4Kqbp5v0j3JIfvNC6RO/pqcsSyfYsIO8szemQ==
X-Received: by 2002:a05:600c:468a:b0:42c:b309:8d18 with SMTP id
 5b1f17b1804b1-42cdb53be54mr126239945e9.19.1726579724713; 
 Tue, 17 Sep 2024 06:28:44 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b1899efsm136849505e9.30.2024.09.17.06.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 06:28:44 -0700 (PDT)
Message-ID: <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
Date: Tue, 17 Sep 2024 15:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240917-f45624310204491aede04703@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 17.09.24 14:13, Andrew Jones wrote:
> On Mon, Sep 16, 2024 at 08:16:33PM GMT, Heinrich Schuchardt wrote:
>> OpenSBI enables the floating point in mstatus. For consistency QEMU/KVM
>> should do the same.
>>
>> Without this patch EDK II with TLS enabled crashes when hitting the first
>> floating point instruction while running QEMU with --accel kvm and runs
>> fine with --accel tcg.
>>
>> Additionally to this patch EDK II should be changed to make no assumptions
>> about the state of the floating point unit.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   target/riscv/cpu.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 4bda754b01..c32e2721d4 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -923,6 +923,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>       if (mcc->parent_phases.hold) {
>>           mcc->parent_phases.hold(obj, type);
>>       }
>> +    if (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD)) {
>> +        env->mstatus = set_field(env->mstatus, MSTATUS_FS, env->misa_mxl);
>> +        for (int regnr = 0; regnr < 32; ++regnr) {
>> +            env->fpr[regnr] = 0;
>> +        }
>> +        riscv_csrrw(env, CSR_FCSR, NULL, 0, -1);
>> +    }
> 
> If this is only fixing KVM, then I think it belongs in
> kvm_riscv_reset_vcpu(). But, I feel like we're working around an issue
> with KVM synchronization with this, as well as with the "clear CSR values"
> part of commit 8633951530cc ("target/riscv: Clear CSR values at reset and
> sync MPSTATE with host"). KVM knows how to reset VCPUs. It does so on
> VCPU creation and for any secondaries started with SBI HSM start. KVM's
> reset would set sstatus.FS to 1 ("Initial") and zero out all the fp
> registers and fcsr. So it seems like we're either synchronizing prior to
> KVM resetting the boot VCPU, not synchronizing at all, or KVM isn't doing
> the reset of the boot VCPU.
> 
> Thanks,
> drew

Hello Drew,

Thanks for reviewing.

Concerning the question whether kvm_riscv_reset_vcpu() would be a better 
place for the change:

Is there any specification prescribing what the state of the FS bits 
should be when entering M-mode and when entering S-mode?

Patch 8633951530cc seems not to touch the status register in QEMU's 
kvm_riscv_reset_vcpu(). So it is not obvious that this patch could have 
caused the problem.

Looking at the call sequences in Linux gives some ideas where to debug:

kvm_arch_vcpu_create calls kvm_riscv_reset_vcpu which calls
kvm_riscv_vcpu_fp_reset.

riscv_vcpu_set_isa_ext_single and kvm_riscv_vcpu_set_reg_config
only call kvm_riscv_vcpu_fp_reset if !vcpu->arch.ran_atleast_once.

kvm_riscv_vcpu_fp_reset sets FS bits to "initial"
if CONFIG_FPU=y and extension F or D is available.

It seems that in KVM only the creation of a vcpu will set the FS bits 
but rebooting will not.

Best regards

Heinrich

