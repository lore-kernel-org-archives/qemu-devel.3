Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820ACD0D145
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXAD-0007d7-V8; Wed, 07 Jan 2026 12:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vdXAC-0007c2-1u
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vdXAA-000665-DW
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767806256;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ogQPloa2DzPuFTXZoNCOktVvP4bj4AUDgrYz/amyzc4=;
 b=gTRMrK/1mvvMnDw2hu91P0xSpxVBHFHZ3zG5zegxmWkOVJBqLDEbIrjN+0SKgMn5m6M2FQ
 w/WVW3HroreQM3bm2YIvYmyvJJKhwwbvGKNN2xYx6JpJ6jlvK7ka4lrW1z5qKMksh4Aqzr
 57O0nWRNFWSlunXCH8PvmPIb7+QJPQw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-eM0-NOY2P3Ss2DrYzJlACQ-1; Wed, 07 Jan 2026 12:17:35 -0500
X-MC-Unique: eM0-NOY2P3Ss2DrYzJlACQ-1
X-Mimecast-MFC-AGG-ID: eM0-NOY2P3Ss2DrYzJlACQ_1767806254
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b79fcc35ab2so15419166b.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 09:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767806254; x=1768411054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogQPloa2DzPuFTXZoNCOktVvP4bj4AUDgrYz/amyzc4=;
 b=mejMsvSLqf2m6lIpfLVlPaYJUNMW1+uObZjJPUSddwSugygc1nGjRHSg1pUm4o0UGC
 VmOTzlqLnSsggpp2RmHu2PQlHdK5uEDQCGhlDCyLExQYjr/szv+LY5LP7UQ+5Q4FZwNv
 1DjunI2Pe8cizR1OamDGLTcg5G3Iurdm65f+Sdo19Cq15yRj5RqQZ0hDbS2qvbX079Ql
 FyR837erc5lP4USuwS9jF1qZZSpq/kAPkLB0EqqLC7jfhgyWHs89uEISr3Rxqe/zxGgz
 76z5zMI4ieeU3yEIjl/ZMStyp3t8HRttQu5t34p7bBrgiUN3zLqXsgldF3/Pnk5Dl1vG
 EZMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXntwRe20HVHxgyvU8pY1Wff2bPK6UwLBJ8X3Wv+8BJfmyx1VbHCqmSDND/Yn0ZEIVV3ViXjIWtlUC@nongnu.org
X-Gm-Message-State: AOJu0YxLsF2pXaQWCjewGuKPjQmRPC74VMjSHHVp7Pnb6vZE1MSaCR/N
 +y3KEt0GB+InX9ZNF2qszYR5C/xDKClv8A/tP1HoTmj0mmzINiwDn7jRTUKtU0zASPMXtUPOd4m
 HDUcGAMc6PqKUjrXY4dPinEuOf8OrmzsQalD9HgviS3ukLTTVG2nw11Ds
X-Gm-Gg: AY/fxX7lSZcjxB7aOWuKp6ebeAQdU7oaiGvd7AiOjzW0fPMdGp1jPhub3xw05Hy3r63
 61wI/yRRDLzCNTyVBkTk0CHvqVyxcJLppKn36H5gGIgY8XhH5glW5dgEcfcx83ITbucwOTDVjG1
 mwRWi040Q6hcxCx/99cRJlA6hJWIYcyP4MwKshax2VBl8QO7ewoLGDeWgZmhERbzyf0dJ5Dtpxp
 TLqctwttGBgcGulf8vK3xdtN9EoAAW3110Q401tbqqyDle+3eep3wi+e4ln9zcSzJrUOX4B2rQY
 P5DMaOz4GSNrxRrFj32kR1g6924BrA0n83M273cM47/OGC5OYhlD6EUJhhiv41f13Wo+Yg0CmUV
 unWlUgtSiQ23plQSy1uD9U3CDpxq5XHBF0Ki5SQkDrsaU95eLKWQZoooTzA==
X-Received: by 2002:a17:906:ef0c:b0:b79:f4e4:b544 with SMTP id
 a640c23a62f3a-b8444f21f65mr357128366b.21.1767806253972; 
 Wed, 07 Jan 2026 09:17:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVUtFmIA8FeQ049X3xAPv+NPwcz/Wp4P4fpFIvGXHocKrZ1z7YPaya/DHo1T6Lqjt/lZ+PFA==
X-Received: by 2002:a17:906:ef0c:b0:b79:f4e4:b544 with SMTP id
 a640c23a62f3a-b8444f21f65mr357125666b.21.1767806253560; 
 Wed, 07 Jan 2026 09:17:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a22ff58sm560729466b.6.2026.01.07.09.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 09:17:33 -0800 (PST)
Message-ID: <90618806-8562-4bab-964e-19e0c5998774@redhat.com>
Date: Wed, 7 Jan 2026 18:17:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, gshan@redhat.com, ddutile@redhat.com,
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20251222134110.3649287-1-eric.auger@redhat.com>
 <efc862fb-d393-67a7-672d-9f6cfd2ed3a9@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <efc862fb-d393-67a7-672d-9f6cfd2ed3a9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Sebastian,

On 1/7/26 4:02 PM, Sebastian Ott wrote:
> Hey Eric,
>
> On Mon, 22 Dec 2025, Eric Auger wrote:
>> When migrating ARM guests accross same machines with different host
>> kernels we are likely to encounter failures such as:
>>
>> "failed to load cpu:cpreg_vmstate_array_len"
>>
>> This is due to the fact KVM exposes a different number of registers
>> to qemu on source and destination. When trying to migrate a bigger
>> register set to a smaller one, qemu cannot save the CPU state.
>>
>> For example, recently we faced such kind of situations with:
>> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>>  register from v6.16 onwards. Causes backward migration failure.
>> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>>  from v6.13 onwards. Causes forward migration failure.
>>
>> This situation is really problematic for distributions which want to
>> guarantee forward and backward migration of a given machine type
>> between different releases.
>>
>> While the series mainly targets KVM acceleration, this problem
>> also exists with TCG. For instance some registers may be exposed
>> while they shouldn't. Then it is tricky to fix that situation
>> without breaking forward migration. An example was provided by
>> Peter: 4f2b82f60 ("target/arm: Reinstate bogus AArch32 DBGDTRTX
>> register for migration compat).
>>
>> This series introduces 2 CPU array properties that list
>> - the CPU registers to hide from the exposes sysregs (aims
>>  at removing registers from the destination)
>> - The CPU registers that may not exist but which can be found
>>  in the incoming migration stream (aims at ignoring extra
>>  registers in the incoming state)
>>
>> An example is given to illustrate how those props
>> could be used to apply compats for machine types supposed to "see" the
>> same register set accross various host kernels.
>>
>> Mitigation of DBGDTRTX issue would be achived by setting
>> x-mig-safe-missing-regs=0x40200000200e0298 which matches
>> AArch32 DBGDTRTX register index.
>>
>> The first patch improves the tracing so that we can quickly detect
>> which registers do not match between the incoming stream and the
>> exposed sysregs
>>
>
> I've played around with these and for virt-10.1 I get:
> ./build/qemu-system-aarch64 -M virt-10.1 [...]
> Unexpected error in set_prop_array() at ../hw/core/qdev-properties.c:717:
> qemu-system-aarch64: can't apply global
> arm-cpu.x-mig-safe-missing-regs=0x603000000013c103,
> 0x603000000013c512, 0x603000000013c513: array size property
> x-mig-safe-missing-regs may not be set more than once
> Aborted (core dumped)
>
> Is it possible to aggregate these, when there are compats at more than
> one level? 
Thank you for testing!

The problem relates to my last patch (not to be upstreamed) that leads
x-mig-safe-missing-regs to be set twice.

virt_machine_10_1_options() calls virt_machine_10_2_options which sets
x-mig-safe-missing-regs to DBGDTRTX first (through arm_virt_compat_10_2
compat) and then sets it in virt_machine_10_1_options() to "TCE_EL1,
PIRE0_EL1, PIR_EL1 " (through arm_virt_kernel_compat_10_1). Effectively
this cannot be aggregated that way.

I need to rework that example.

Thanks

Eric
>
> Sebastian
>


