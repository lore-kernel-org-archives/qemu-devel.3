Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E598CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgaj-0001CA-NW; Tue, 28 Oct 2025 06:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDgab-0001At-VX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDgaV-0008Ep-RL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761645957;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsAJpch/WrERbVg5Jp3u+BpZuSIpOMCrX2yp0ECL3XQ=;
 b=iIDCD97QwyUzV+8AdiPHPTWtDmaphOH3Ve80OgLj9AitsBVaNRFdPn6N8GjQUoimntRqoK
 lCMtlrOquzdg4qx1q6ew1qNnsa+wDsAVAFIzZVtH/mOb3LcMliGfGxUCw4H7cg6BSctccB
 +IJt1OYfiQnJd7uvy0iLNPaX5w4FUJE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-489AaQW5PWaTUqDpka8vcA-1; Tue, 28 Oct 2025 06:05:56 -0400
X-MC-Unique: 489AaQW5PWaTUqDpka8vcA-1
X-Mimecast-MFC-AGG-ID: 489AaQW5PWaTUqDpka8vcA_1761645955
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47111dc7c5dso33800665e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761645955; x=1762250755;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xsAJpch/WrERbVg5Jp3u+BpZuSIpOMCrX2yp0ECL3XQ=;
 b=UG0zx+hd/KPvRQh45qsbX0VH2hHhb/60v0NTh8KCM7gW4ASMlDWdsPp+QIwebexr51
 5Y6iWaVdmn4owx/TX1O0pzmzb0XubYLLILJ8ifN3X5VzgY9o9PtWRXAPp/XH9Bk3Zm+7
 N8X1WfKAIX9IIibseM3wJtGXsH+JZfWVWLgnHwVNOmzXSS4tnjk3hNpp75fA+hX3odyR
 ULbLVaIclWv3203RSKgkLmPvGr3YVLaYVcW+xWy3VCyJhcI77Du/KngpoN/n0y9Mzx5k
 rEVV31qAT8DPrAh4pa+fiwqZzMyM/SVstUCZR6lApD5vf2xvSHg4HL+yDA01S/lBmmYG
 fVcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLbLcaUKR+o+EPOV5R3A04Xf9uflf4xeU9JUGkNlk/Vf8smwDiPVJhliR/5eA0OUEj8YptJfJXwfjX@nongnu.org
X-Gm-Message-State: AOJu0YydbH0utTrRyu1p4DvMk0XLad3/hErxqtXpeiUrgav8pqAPpxAV
 LD5K5MVcZd84SsUOE33At/LaE24TxVq+qbjrvFGlMZbZJ48nPf1OjMBJ/qvvDHnydrmuXcxViCs
 FF7G4YmC7Ee1VXF9gghx+UJUsxGwStDZuZWNZ0xD2qIrFz+YsRdKA9Wn5
X-Gm-Gg: ASbGncsriDUfVKNZkAa5C9lwLx2dv3EI2oNOcsHNxxQEUUCzMsgjUNUK7P36MFjW56a
 4/GdQ/sFvfOpBzZGDKyzA9ImdIxMOodeqDa93k6KBOVm9bUwdBGxHwRP+OiEWFOMeNY8tZNjp0q
 1u3KB56zlNeNLo5xjYC3h6kWDugt7Fa1V1If+tAe7SS7bt3D4RQsnLOlb7o1brldE4yq8n7MRN5
 eZiCC6DVxzwRZ19nfxzduJDar1PWQvuhJ4GvAbtJiaKqp1XYjBA1K4aDytzGLFybyDv+e4Rkf1O
 nHcjucT0XFNqNwgX6sLozE3rIcstSRoKyyLIep/3vKrb3JNe8BbLyUF5Q+mQO6WVL9gPbeuhPZr
 oN19X871JF2zaYzHHoLlzYarZU/D0UrJqqOG66aSPx8ym0w==
X-Received: by 2002:a05:600c:2052:b0:475:dc32:5600 with SMTP id
 5b1f17b1804b1-477181a9835mr17765555e9.19.1761645955032; 
 Tue, 28 Oct 2025 03:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9oX9XjYv4M/5CIZntxDzIOfwzUyn4DqVQPHb3UpiGqEcJ97czb+kPT+m9pQDLW63leSxUkA==
X-Received: by 2002:a05:600c:2052:b0:475:dc32:5600 with SMTP id
 5b1f17b1804b1-477181a9835mr17765145e9.19.1761645954542; 
 Tue, 28 Oct 2025 03:05:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb55asm19518873f8f.17.2025.10.28.03.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 03:05:53 -0700 (PDT)
Message-ID: <3c963761-8587-4905-8c8b-60dda381262f@redhat.com>
Date: Tue, 28 Oct 2025 11:05:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 0/7] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Content-Language: en-US
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20251016140039.250111-1-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251016140039.250111-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 10/16/25 3:59 PM, Eric Auger wrote:
> When migrating ARM guests accross same machines with different host
> kernels we are likely to encounter failures such as:
>
> "failed to load cpu:cpreg_vmstate_array_len"
>
> This is due to the fact KVM exposes a different number of registers
> to qemu on source and destination. When trying to migrate a bigger
> register set to a smaller one, qemu cannot save the CPU state.
>
> For example, recently we faced such kind of situations with:
> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>   register from v6.16 onwards. Causes backward migration failure.
> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>   from v6.13 onwards. Causes forward migration failure.
>
> This situation is really problematic for distributions which want to
> guarantee forward and backward migration of a given machine type
> between different releases.
>
> This small series tries to address that issue by introducing CPU
> array properties that list the registers to ignore or to fake according
> to the situation. An example is given to illustrate how those props
> could be used to apply compats for machine types supposed to "see" the
> same register set accross various host kernels.
>
> The first patch improves the tracing so that we can quickly detect
> which registers are unexpected and cause the migration failure. Missing
> registers are also traced. Those do not fail migration but their default
> value is kept on the destination.
>
> Then we introduce the infrastructure to handle 'hidden' registers and
> 'fake' registers.
>
> Eric Auger (7):
>   target/arm/machine: Improve traces on register mismatch during
>     migration
>   target/arm/kvm: Introduce the concept of hidden KVM regs
>   target/arm/kvm: Introduce the concept of enforced/fake registers
>   kvm-all: Add the capability to blacklist some KVM regs
>   target/arm/cpu: Implement hide_reg callback()
>   target/arm/kvm: Expose kvm-hidden-regs and kvm-fake-regs properties
>   hw/arm/virt: [DO NOT UPSTREAM] Enforce compatibility with older
>     kernels

Gentle ping.

Any comments on the approach?

Thanks

Eric
>
>  include/hw/core/cpu.h   |  2 ++
>  target/arm/cpu.h        | 42 ++++++++++++++++++++++++
>  accel/kvm/kvm-all.c     | 12 +++++++
>  hw/arm/virt.c           | 19 +++++++++++
>  target/arm/cpu.c        | 12 +++++++
>  target/arm/kvm.c        | 73 ++++++++++++++++++++++++++++++++++++++++-
>  target/arm/machine.c    | 71 +++++++++++++++++++++++++++++++++++----
>  target/arm/trace-events | 11 +++++++
>  8 files changed, 235 insertions(+), 7 deletions(-)
>


