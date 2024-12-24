Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C3CE7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7Lb-0006bL-FD; Tue, 24 Dec 2024 11:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ7LX-0006Yr-AJ
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:01:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ7LR-0000uE-Gn
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735056076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i/ex+YEgFBQKbbutLwCLbMm2eOqg4ZA3JWMufpN6EJw=;
 b=a55Z36eTKvnstzEBqFTnPWrGClgnPSVyqjP4f88YD6G3l2CIyLjIXWdyPIUdq3Y9+Jnpo0
 1WjHgZ+xQUdzhllrIvK8xL2RKSoSIOlVhJrkBtpBdRJ8fBBRnSamS2LEr1VH6H5nNTrJmB
 6Dhg5JUO1rz3IGx6eHeYyCf1EYj+Bdw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-UJeTHiDrPdiSYXyGEgycdg-1; Tue, 24 Dec 2024 11:01:11 -0500
X-MC-Unique: UJeTHiDrPdiSYXyGEgycdg-1
X-Mimecast-MFC-AGG-ID: UJeTHiDrPdiSYXyGEgycdg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so2936236f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 08:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056070; x=1735660870;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i/ex+YEgFBQKbbutLwCLbMm2eOqg4ZA3JWMufpN6EJw=;
 b=ITcBaKFvMx37gCF30esXHsHWq3qI6AVIgOKuezB5dX4ozPZ4cMmkntOmG5ZuU+c8d4
 e7QNQM8mEfAxdc3xmQJ6kTmJr6reKgYfijDt8KFI6VxWXPw+ovckWHaDyohhhyDZZVEg
 4RKxvtNfa+btGi5JKexsxEr6b8CsCMBKioiEmd8uFRVH/iL4iF54CPC9ZV0JBZeqEzJ3
 y5iY7wAiE3NzSE1FrFjOoifscdbnDW6Xnq+hLSG9wDCL2PADUBWqwQB9sk191SOsPGsC
 GDrqgQAf5mnbDg18tdROVnkDKKVWEmHXWxGTCuDbQdmM94OacwjElkKRuXCKzHcTEeHI
 1ABw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2a6WRZE9PPqijCW+SnXYBRKUtiiNkd0nu0DWNDjf+JWPAGJmfWWP2GZJTsdI5AeYD1qBCeWT3jqCh@nongnu.org
X-Gm-Message-State: AOJu0YwtTap8FRvpbsEdvqam8UuHVKglZ5ArMDNoxBZ/HkfTsh2UBGE1
 O2KBIwjr9WgL5vem7TS/pUc8T33cVCWLaJZ6xM5hBxkFnQTcOLG5MtbF5aZe6mE7r2Xa0wMLz2Q
 n3EF7pK2ee2y0pn8mBMsmQAQ+FANn2svSAAPzG674Jvpxcm78LQiV
X-Gm-Gg: ASbGncsiqb8CHkTXoZ6TBo4x7vEkAWc1OIxd4/My7GPxpo+OdjzJrdiTCYUZnyR4yF6
 /dOuUTjuq0dul9BCSXF7oS8R5hQCiJHsnbFiIeLDbbnq5Rq0Qn8D7mV6Uqbq2DCvJPspDXM+IsZ
 m/TSJ5fRGc6cf2qqVwNgo/bqn/iXvu4R32S6B0y+sUc80wgWw/q9tRxNqPrxk5XcG3sUGM+5bOo
 TGBYVLWLUyO1SgFvqm6exImyV6omW5cb0E3UgAjuVvIbevw+Wt/BhOVU/q2
X-Received: by 2002:a05:6000:154f:b0:382:3efc:c6d8 with SMTP id
 ffacd0b85a97d-38a221ed2fdmr13709811f8f.12.1735056068842; 
 Tue, 24 Dec 2024 08:01:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlVVigMON3+v7GZf0Wd8e9A4bsNkgxk/ClDcoTANwHbuOSynV5cwu4x+Ht3c++w6w0CeHixQ==
X-Received: by 2002:a05:6000:154f:b0:382:3efc:c6d8 with SMTP id
 ffacd0b85a97d-38a221ed2fdmr13709747f8f.12.1735056068308; 
 Tue, 24 Dec 2024 08:01:08 -0800 (PST)
Received: from [192.168.10.27] ([151.62.105.73])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847513sm14570673f8f.49.2024.12.24.08.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 08:01:07 -0800 (PST)
Message-ID: <9bb6ea4b-dd40-446d-887d-4878d180c2a5@redhat.com>
Date: Tue, 24 Dec 2024 17:01:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/11] i386: miscellaneous cleanup
To: Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20241106030728.553238-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241106030728.553238-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/6/24 04:07, Zhao Liu wrote:
> Hi Paolo and all,
> 
> Is it necessary to include the first patch (AVX10 cleanup/fix) in v9.2?
> 
> Others are for v10.0.
> 
> Compared with v4 [1],
>   * patch 1 (AVX10 fix) and patch 9 (RAPL cleanup) are newly added.
>   * rebased on commit 9a7b0a8618b1 ("Merge tag 'pull-aspeed-20241104' of
>     https://github.com/legoater/qemu into staging").

Removed patches 5 and 11, fixed patch 4 to include CPUID_KVM_CLOCK2, and 
queued - thanks!

Paolo

> 
> Background and Introduction
> ===========================
> 
> This series picks cleanup from my previous kvmclock [2] (as other
> renaming attempts were temporarily put on hold).
> 
> In addition, this series also include the cleanup on a historically
> workaround, recent comment of coco interface [3] and error handling
> corner cases in kvm_arch_init().
> 
> Avoiding the fragmentation of these misc cleanups, I consolidated them
> all in one series and was able to tackle them in one go!
> 
> [1]: https://lore.kernel.org/qemu-devel/20240716161015.263031-1-zhao1.liu@intel.com/
> [2]: https://lore.kernel.org/qemu-devel/20240329101954.3954987-1-zhao1.liu@linux.intel.com/
> [3]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (11):
>    i386/cpu: Mark avx10_version filtered when prefix is NULL
>    target/i386/kvm: Add feature bit definitions for KVM CPUID
>    target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
>      MSR_KVM_SYSTEM_TIME definitions
>    target/i386/kvm: Only save/load kvmclock MSRs when kvmclock enabled
>    target/i386/kvm: Save/load MSRs of kvmclock2
>      (KVM_FEATURE_CLOCKSOURCE2)
>    target/i386/kvm: Drop workaround for KVM_X86_DISABLE_EXITS_HTL typo
>    target/i386/confidential-guest: Fix comment of
>      x86_confidential_guest_kvm_type()
>    target/i386/kvm: Clean up return values of MSR filter related
>      functions
>    target/i386/kvm: Return -1 when kvm_msr_energy_thread_init() fails
>    target/i386/kvm: Clean up error handling in kvm_arch_init()
>    target/i386/kvm: Replace ARRAY_SIZE(msr_handlers) with
>      KVM_MSR_FILTER_MAX_RANGES
> 
>   hw/i386/kvm/clock.c              |   5 +-
>   target/i386/confidential-guest.h |   2 +-
>   target/i386/cpu.c                |   6 +-
>   target/i386/cpu.h                |  25 ++++
>   target/i386/kvm/kvm.c            | 211 +++++++++++++++++--------------
>   5 files changed, 145 insertions(+), 104 deletions(-)
> 


