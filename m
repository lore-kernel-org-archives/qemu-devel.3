Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A567BCDD548
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 16:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqxWW-000475-76; Wed, 18 Sep 2024 12:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqxWU-00043X-7U
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 12:27:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqxWR-0005Ha-8G
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 12:27:21 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4958A3F45F
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726676837;
 bh=iEkJdohtSWik4fNSGLkaPeBerSCz1v1hA1g/Oi9GQoQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=UYyx+gTQCLAkdDMwi+P+AG5lftwMLxLjZe9/ZyxzRxzoRH0V84EMx9KEzmo1t0D4Z
 2AMEEZ2lL5eaz+M2uncEPXQt5gZo7FX2zWWHUMTQWVqjOHvrR7JGrLB1XhIuupldaW
 u3y19hsfjHRQx18uj8zLfaXL1i95sMhxalk7TTRCFclm2/LYSe1J+bcK/+GI2KUUg3
 W0v3n/s9buzg8q5Upd5w9yRM/KxRNtbiJhb44OZWgXH3foGSFAGGxuex6VfcqKkW2q
 9YXWW9SBw2Cly091i5fzL1d/M0YL+Oqvqn+GNLRC9DFuQr6duM2WauREjPFnvLz8/d
 lVEMxuic3gh4w==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374c9b0daf3so2411081f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 09:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726676836; x=1727281636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iEkJdohtSWik4fNSGLkaPeBerSCz1v1hA1g/Oi9GQoQ=;
 b=pa5qBs+hNSAOBZp6S9zrXqZL5Nr7R+cZoOrIzdjdpoyaAJmBEeybaFcdgJ88iRvbyB
 S8JqR5oIba4FHBCZ16NAWj37Su4zAjzWOafAAh4TqPL8sARCaLsrCte/uSw1dP/pAMRG
 2BErkR/3a6E82BEo75KkRyS5ev3GdMOXbwhfXXDfhAe95277WMzF8Cqqg/riD13tnduu
 qyHcmn0NApi+1HD3W30EPbnjRawf3uux4JLEtpZKEIjDUfJzebvj2B0X/lTFTznf6PqF
 t2x2fUV5x9DESuWVEqZ+RRIZ0wjb67pvbs/rpwl/wvsVFU+ErWDfIp8vsz9sEo/0nEXq
 0Bug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFmEy0RPjJnLA2HY0ogSRtQfJYlydV0Jie3oyPG9kJQXK6jlurL1Z1eCBn0XFWldrVls8W3K4CPHL0@nongnu.org
X-Gm-Message-State: AOJu0Yw1SOzFS+OwyMQdSCi00NAg23q4Srf9bc8SocW5oA6sA011PRPl
 1KZQzcDP0vqVMhgKoSFMNGA4H6ahigDeYVsUTiuP0ZJdfABUEXWfjC0yYfgvddBFDPiFFRyGAAx
 WVbqR7Dz5EbRabcslAS9mtxC5AtkO8Bs9zG4ntaLI+/7eZRDa03D9nZu98L3uznI2jn7k
X-Received: by 2002:a5d:66c4:0:b0:371:8845:a3af with SMTP id
 ffacd0b85a97d-378d623b7d4mr11461417f8f.39.1726676836340; 
 Wed, 18 Sep 2024 09:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq7GTsYYXDPhTkQjL35nwxJT/xKz4RyECHixjHF7LH26VDJ/F0Ct2Etb+lGYO2yRNM4mRfMA==
X-Received: by 2002:a5d:66c4:0:b0:371:8845:a3af with SMTP id
 ffacd0b85a97d-378d623b7d4mr11461375f8f.39.1726676835857; 
 Wed, 18 Sep 2024 09:27:15 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780519esm12698302f8f.103.2024.09.18.09.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 09:27:15 -0700 (PDT)
Message-ID: <ca16bb60-9745-478d-afba-1330b385027e@canonical.com>
Date: Wed, 18 Sep 2024 18:27:14 +0200
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
 <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
 <CAFEAcA-L7sQfK6MNt1ZbZqUMk+TJor=uD3Jj-Pc6Vy9j9JHhYQ@mail.gmail.com>
 <f1e41b95-c499-4e06-91cb-006dcd9d29e6@canonical.com>
 <CAFEAcA_ePVwnpVVWJSx8=-8v2h_z2imfSdyAZd62RhXaZUTojA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFEAcA_ePVwnpVVWJSx8=-8v2h_z2imfSdyAZd62RhXaZUTojA@mail.gmail.com>
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

On 18.09.24 17:32, Peter Maydell wrote:
> On Wed, 18 Sept 2024 at 14:49, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 18.09.24 15:12, Peter Maydell wrote:
>>> On Wed, 18 Sept 2024 at 14:06, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>> Thanks Peter for looking into this.
>>>>
>>>> QEMU's cpu_synchronize_all_post_init() and
>>>> do_kvm_cpu_synchronize_post_reset() both end up in
>>>> kvm_arch_put_registers() and that is long after Linux
>>>> kvm_arch_vcpu_create() has been setting some FPU state. See the output
>>>> below.
>>>>
>>>> kvm_arch_put_registers() copies the CSRs by calling
>>>> kvm_riscv_put_regs_csr(). Here we can find:
>>>>
>>>>        KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
>>>>
>>>> This call enables or disables the FPU according to the value of
>>>> env->mstatus.
>>>>
>>>> So we need to set the desired state of the floating point unit in QEMU.
>>>> And this is what the current patch does both for TCG and KVM.
>>>
>>> If it does this for both TCG and KVM then I don't understand
>>> this bit from the commit message:
>>>
>>> # Without this patch EDK II with TLS enabled crashes when hitting the first
>>> # floating point instruction while running QEMU with --accel kvm and runs
>>> # fine with --accel tcg.
>>>
>>> Shouldn't this guest crash the same way with both KVM and TCG without
>>> this patch, because the FPU state is the same for both?
> 
>> By default `qemu-system-riscv64 --accel tcg` runs OpenSBI as firmware
>> which enables the FPU.
>>
>> If you would choose a different SBI implementation which does not enable
>> the FPU you could experience the same crash.
> 
> Ah, so KVM vs TCG is a red herring and it's actually "some guest
> firmware doesn't enable the FPU itself, and if you run that then it will
> fall over, whether you do it in KVM or TCG" ? That makes more sense.
> 
> I don't have an opinion on whether you want to do that or not,
> not knowing what the riscv architecture mandates. (On Arm this
> would be fairly clearly "the guest software is broken and
> should be fixed", but that's because the Arm architecture
> says you can't assume the FPU is enabled from reset.)
> 
> I do think the commit message could use clarification to
> explain this.
> 
> thanks
> -- PMM

I have not found a specification defining what the status of the FPU 
should be when M-Mode is stared and when moving from M-Mode to S-Mode.

OpenSBI (which is the dominating M-Mode firmware and invoked by default 
in TCG mode) enables the FPU before jumping to S-Mode. KVM should to the 
same for consistency.

Best regards

Heinrich

