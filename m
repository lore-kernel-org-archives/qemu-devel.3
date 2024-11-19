Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB44ED6C28D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTlz-00082j-DI; Tue, 19 Nov 2024 14:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTle-0007WQ-SI
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:20:09 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTld-0008OB-DD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:20:06 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ea8d322297so1697210a91.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732044003; x=1732648803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wht6cpDTrUupBJ4RYKBt4caH+gqq3dPRY/S+vBK0iN4=;
 b=gEZzugx1v3cUQo2k+A0HQVFL2Ctq470GoaQNfYvVJcku/jYjLWhMIsMBT6POx8IehM
 kbdl1RiVrjQVETF4hFNn7SSGYUbHh6yhZ7o9fLLX6KCc27Wu54THFWYO/IbHvbHc+Xmg
 mvhiyxkXXLJ0is6HCbb8cvtnwbw9RC9xOiRc99Lmy+pcBnyuGCKTPJfbsqb3HHMU8rXP
 ny4EOVkqWSRFkJJHNL/7WdkZZlVRNiLvhg+vaoB8tA0Hg/7cd2R8B4vV/wCZRi/2xG4a
 15P7Mmj0Lw8XP5dI4Kn+mBQm6Wy/Bl8TFrxZfpCAosvUZggiC/pn7VBfSLIxsR2np3+w
 24ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732044003; x=1732648803;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wht6cpDTrUupBJ4RYKBt4caH+gqq3dPRY/S+vBK0iN4=;
 b=CrbZL6uh/iz7uEQvDbYoHfAhKNycN/TddDA9BqSCFS6TlaMPNCO5ss9TaImiRa75Ch
 MT5B5Q/RqjThvMsT+4wAGSNKLenEj3rGXZmyKk5ReB3UQczcz52lgF7DDaH5ZTR3Xc3l
 uxi16fnLvtdBFq2V27yggx0SLKXKEBIcUaQElzNevgNrFce9RD6oAihiBLPLKfgH+N8y
 4fQ6GDIWrmq3/VEfTSMwCEnSl455uW0H0aWF8cF8UsEyB22V7mPVLs7OnJYoLo4QTvIv
 JFHnv0sF2iwcU1vpWrEKrLDXdzsYOf+N45sEgJs2HjfM81p3ozcaVTDMNpOlzGAM12gb
 JUVQ==
X-Gm-Message-State: AOJu0YzE98RjoqLHfRALR1pGSC9r8M0dgAtb18rp5Vd/X8V7gP4/lIXs
 3LAgSZIyETjZKP/rIkp1SXxJp50rfSieNdUebUbhlCP0GvTO/oPptf6qogR1j1TqBLF1QANDKtg
 T
X-Google-Smtp-Source: AGHT+IHfFfoUPxau6ZG8kxB7/rfpY3g8yPa01ErWa90j2nfHIjKis6QdgKpVeIX7qQUMt9NzNfSg1g==
X-Received: by 2002:a17:90b:3d91:b0:2ea:5c01:c1a8 with SMTP id
 98e67ed59e1d1-2ea5c01c429mr12261267a91.35.1732044002848; 
 Tue, 19 Nov 2024 11:20:02 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea4a6bc0a0sm5651853a91.18.2024.11.19.11.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 11:20:02 -0800 (PST)
Message-ID: <84839418-2011-47fa-a5bd-f51959fc395c@ventanamicro.com>
Date: Tue, 19 Nov 2024 16:19:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] riscv: AIA userspace irqchip_split support
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
 <CAKmqyKPFqwQ_H9umX17PAjZ=TmqYGPQHRFo76CkDYaF88amKzg@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKPFqwQ_H9umX17PAjZ=TmqYGPQHRFo76CkDYaF88amKzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102b.google.com
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



On 11/17/24 11:05 PM, Alistair Francis wrote:
> On Fri, Oct 11, 2024 at 5:04 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> Hi,
>>
>> This series adds AIA irqchip_split support, effective when using AIA
>> with aia=aplic-imsic and -accel kvm,kernel-irqchip=split.
>>
>> The main difference between what we currently have and irqchip_split()
>> mode is that, when using split mode, QEMU will emulate the APLIC
>> controller instead of using the in-kernel APLIC controller provided by
>> KVM.
>>
>> After this series this is the matrix of which interrupt controllers
>> we're emulating based on 'virt' machine configuration and accelerator
>> properties:
>>
>> Accel Accel props   AIA type    APLIC-m IMSIC-m APLIC-s   IMSIC-s
>> tcg      ----       aplic       emul    n/a     emul      n/a
>> tcg      ----       aplic-imsic emul    emul    emul      emul
>> kvm      ----       aplic       n/a     n/a     emul      n/a
>> kvm      none       aplic-imsic n/a     n/a     in-kernel in-kernel
>> kvm   irqchip=split aplic-imsic n/a     n/a     emul      in-kernel
>>
>>
>> Patches based on alistair/riscv-to-apply.next.
> 
> Thanks!
> 
> Do you mind rebasing this again?

Thanks for the reviews!

I'm not sure which branch should I use for rebasing (it doesn't seem that your
riscv-to-apply.next or riscv-to-apply.for-upstream branches are updated), so I rebased
it on top of 'master', fixed a couple of conflicts.

Let me know if you want a rebase based on a different branch. Thanks,

Daniel

> 
> Alistair


