Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675F6C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3kf-00085f-RX; Tue, 26 Mar 2024 06:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rp3ke-00085I-7m
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rp3kc-0001JY-Hb
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711447789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvZPmz9vy0RCmtvYL34Y8frf70wRFwPX4tjmvWz7bfA=;
 b=UZovLN2cXC7JBHJ4C8DMXezfrr/Bas9rAjluXAW8GSHMtFuofq/oYy3gMojh6s5lv7N5oY
 kYXhiI8hM9wxqcrAWpwXtpoO5MzV0/hOUepK13wew9cKgBuKQuBtrHQuziAbjPP2sn3pva
 8f1QBdn2bgX9igaW1CmR8aUW3tF2/t4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-noFJGhFRNp2X4sTxQyBdEA-1; Tue, 26 Mar 2024 06:09:47 -0400
X-MC-Unique: noFJGhFRNp2X4sTxQyBdEA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33ec06aac83so3598382f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 03:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711447783; x=1712052583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bvZPmz9vy0RCmtvYL34Y8frf70wRFwPX4tjmvWz7bfA=;
 b=eq02mcXByVi306N5A6gG4d76IcIFMaSmzBj3vEUDQ293PPWg00gBROQX2DJf9iTGGQ
 MiiC67ZyonORxAjyER2gDru25/eyOiXrynVEX8OQsgXqOYBSfqoVh59OTn/PuD7FI2/2
 IhRkLeYWWSLvp372BxuuHzyb150DFxXocBfpAj4bCPxYc1rTj5+VAaKOfn2wTliNfSOi
 XNvzuZeSl/sC0QCS9kOeEwHRgQQRRZa04Gg5ByM4Pl4ZszCtoPbDJEjopWwSq/uSolIT
 DLyBBahUe2+0T3lK9Lmb9SkBYMmMByB8FlV9ZAvMj6QXwdESbQUtvPIAuAXnLTe7ZLXI
 WhIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNwoRI8T2Gpo+5B4DdUVFOGPlG552cbNvO8xsduUTDqLsbt5ghIhyCM2G3puqi712o4lqecdORY8GJzgyzyeyVWH5LxHQ=
X-Gm-Message-State: AOJu0Yxblb1BsvTBa2NdQd2GS5/bQNT81JRS/kFqmbo+WFZrYlSjc3rf
 XENgQUTQk/kKnYdL6lwAWjTLHwS7JzTN6YVwAAJEGE+mJJ4Zl6Bxe4PvTgdcqTJSm6MHbafIWq+
 0WGDJ3s/NHEiCoEnMICfPllSbgKwnhIvGqjRLIvXm8LjLgqMw0apC
X-Received: by 2002:a5d:43c9:0:b0:341:cfd6:42af with SMTP id
 v9-20020a5d43c9000000b00341cfd642afmr3333260wrr.31.1711447783122; 
 Tue, 26 Mar 2024 03:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG40lViCrK47vXtjWGxe/0UeiHGT3DJutqrbL5eHBd0mKYB/pIKlMBWBxWkaJkRaGG5rAghag==
X-Received: by 2002:a5d:43c9:0:b0:341:cfd6:42af with SMTP id
 v9-20020a5d43c9000000b00341cfd642afmr3333248wrr.31.1711447782788; 
 Tue, 26 Mar 2024 03:09:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 en9-20020a056000420900b00341b451a31asm5552312wrb.36.2024.03.26.03.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 03:09:42 -0700 (PDT)
Message-ID: <f4805b73-b485-46e0-938d-b0cf23ea2aa6@redhat.com>
Date: Tue, 26 Mar 2024 11:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/5] ARM Nested Virt Support
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, haibo.xu@linaro.org, richard.henderson@linaro.org,
 maz@kernel.org, gkulkarni@amperecomputing.com
References: <20240209160039.677865-1-eric.auger@redhat.com>
 <CAFEAcA_i7x=F-mDgkoa4Tma1xGH0no+WCfNt2Ljyk3DYhHNTiQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_i7x=F-mDgkoa4Tma1xGH0no+WCfNt2Ljyk3DYhHNTiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 3/5/24 17:57, Peter Maydell wrote:
> On Fri, 9 Feb 2024 at 16:00, Eric Auger <eric.auger@redhat.com> wrote:
>> This series adds ARM Nested Virtualization support in KVM mode.
>> This is a respin of previous contributions from Miguel [1] and Haibo [2].
>>
>> This was tested with Marc's v11 [3] on Ampere HW with fedora L1 guest and
>> L2 guests booted without EDK2. However it does not work yet with
>> EDK2 but it looks unrelated to this qemu integration (host hard lockups).
>>
>> The host needs to be booted with "kvm-arm.mode=nested" option and
>> qemu needs to be invoked with :
>>
>> -machine virt,virtualization=on
>>
>> There is a known issue with hosts supporting SVE. Kernel does not support both
>> SVE and NV2 and the current qemu integration has an issue with the
>> scratch_host_vcpu startup because both are enabled if exposed by the kernel.
>> This is independent on whether sve is disabled on the command line. Unfortunately
>> I lost access to the HW that expose that issue so I couldn't fix it in this
>> version.
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/v8.2-nv-rfcv2
>>
>> Previous version from Miguel:
>> [1] https://lore.kernel.org/all/20230227163718.62003-1-miguel.luis@oracle.com/
>> Previous version from Haibo:
>> [2] https://lore.kernel.org/qemu-devel/cover.1617281290.git.haibo.xu@linaro.org/
>> [3] Marc's kernel v11 series:
>>     [PATCH v11 00/43] KVM: arm64: Nested Virtualization support (FEAT_NV2 only)
>>     https://lore.kernel.org/linux-arm-kernel/20231120131027.854038-1-maz@kernel.org/T/
>>     available at: https://github.com/eauger/linux/tree/nv-6.8-nv2-v11
>>
>> Haibo Xu (5):
>>   [Placeholder] headers: Partial headers update for NV2 enablement
>>   hw/arm: Allow setting KVM vGIC maintenance IRQ
>>   target/arm/kvm: Add helper to detect EL2 when using KVM
>>   target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is supported
>>   hw/arm/virt: Allow virt extensions with KVM
>>
>>  hw/arm/virt.c                      |  6 +++++-
>>  hw/intc/arm_gicv3_common.c         |  1 +
>>  hw/intc/arm_gicv3_kvm.c            | 21 +++++++++++++++++++++
>>  include/hw/intc/arm_gicv3_common.h |  1 +
>>  linux-headers/asm-arm64/kvm.h      |  1 +
>>  linux-headers/linux/kvm.h          |  1 +
>>  target/arm/kvm.c                   | 21 +++++++++++++++++++++
>>  target/arm/kvm_arm.h               | 12 ++++++++++++
>>  8 files changed, 63 insertions(+), 1 deletion(-)
> All the patches in this series seem reasonable, but the series
> as a whole is so short I wonder if we're missing something :-)
> Does migration Just Work? (I guess as long as the kernel exposes
> all the EL2 sysregs via the ONE_REG ioctl interface it ought to...)
To be honest I have not tested yet. I would also guess there is no mig
blocker but that definitively deserves some testing. I will check before
sending the next version.
>
> Anyway, I don't think there's anything that stood out as needing
> major changes, so for now I guess we just wait for whenever the
> KVM side patches eventually land.

yup

Thanks

Eric
>
> thanks
> -- PMM
>


