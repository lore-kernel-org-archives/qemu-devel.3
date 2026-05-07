Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C6ECD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtaU-0001Zv-26; Thu, 07 May 2026 03:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKtaS-0001XZ-Mo
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKtaR-0002lQ-0X
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778140557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sUYLIe1HSMtuP3qpLZZgmhDcGyc81igB3SkHEFSR4s8=;
 b=LeusSieflEytMhabcNJDW2U32RgK0/YujxnAyBjHcxKiZDpJT1C9jlhxetvNCkX7wcjh+l
 UuHw6bekWQNpJAZ4/F5VrRlnuSwdvgeLbKR1R2rjuaok5RYThjFK+v3DMtVZx6cwtaoKeY
 ujYe1DtTDpSNuhnQT7RR3Cqymp7F6NI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-QNYu78OON_ObWqdnDKfAwQ-1; Thu, 07 May 2026 03:55:54 -0400
X-MC-Unique: QNYu78OON_ObWqdnDKfAwQ-1
X-Mimecast-MFC-AGG-ID: QNYu78OON_ObWqdnDKfAwQ_1778140553
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48919890a95so3181065e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778140553; x=1778745353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sUYLIe1HSMtuP3qpLZZgmhDcGyc81igB3SkHEFSR4s8=;
 b=OJTrQzHtK4TWqFcmDvkHQlf1Zsp1gZudcN22YjTsEaXojBPZnSDy2flI7l+RR98x+N
 Ojf8hKmEthhnwaFEE2rRYeDdOvqX3d0JCu8OAukkvyIr+JhbJb7TXUpoH8IkEK0KHtPM
 i4w+4o4hLHAqM1YDzJ0jkvMO+tnqjqVXXfmdzvz3e0wQub+Oo6fCmZeJ/rRiusofE6cF
 okYnC1iuxPgGyc0hoNwLbW06XTHiaRDWmS4tGwxUYDZXfhArHhZ70DTcipZDCYLk9CoN
 5kBjTsARwhcNsYIapV4RRAQajZYHS18hHdiunRewwkaBMKJqJDxfKXL66ybRvIoicHm/
 unWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778140553; x=1778745353;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUYLIe1HSMtuP3qpLZZgmhDcGyc81igB3SkHEFSR4s8=;
 b=ovh/8OXPiierxVdgK6mb/lCG0RkrjdyIv+oXw9fVq7mpir9CueLu8gC4ZW+qdJOr0h
 fbA4RduIe9fXnwz95lE6fpoN/LdPmKoB5BVIxLQzx/s3eOV08k8rNK6cZJ5pvQXkgOyt
 e8/OSjAVqNWme/+YH6hHPwT2hAfSg5oZd92HHZYHhjlxiSn6WOpxbuya8JC2PrEBQT8t
 GlS6NhrPrHFZQw7cIPkLhjn+fcVh+oTAZW6rsntOJBbVhpBVaKgY1rXxyufo1wOakzse
 Hny1i9vmqy4o02mh0u48PvILmkjnmTmmZMRGMl4lBrdVeuslpmsq5VH9YPAQ8AEdgrPX
 Jg4A==
X-Gm-Message-State: AOJu0Yz58LciYlDA7JdrIDwozotsAMq9dKVW/Iid+AD1BC+8gR/VV+st
 zX8nTNHLdVZ69o+cqh+CMi+pun67VZ7DR6d0RUYaaeqGQqOVyu3RTUaISfMsufoEYwSobzRXMBy
 y3JmFOtAwJ52jaT2aNK8xLrqYzEhkL9fdqGDTnh5nreGCAUlPN2/9MsH/
X-Gm-Gg: AeBDieukEbx0hIw0fY99HRcP9IgbkXtnnATXY7j+x6qyyRL3gbhVAM0nU28QwvfLKVS
 BK8EEYLJQXY74v/NBYyNI7tmP8uW7ka/ngCVg6oXF8qd783+2ejFqB+iHVfW6Pb0jBQB1kzwXkK
 v8DQwqPEZnfxUWGqbtV2Lk/VwRoxOduDWiaczQu80qzbV4F6bXsGg/vlrncg+MhVXzklkvbLgDY
 VgTSuy1pPZDexQsLDCvEtIxirPKSz/fcbS4sq2u+oe1z3tqZ0XThO+9P0QUHljg5O80oy2phED4
 lrlFBgKzgXB/soaNlaF2gOUlQw9Miq9gYqsE2zJ0kqmOCYBkqMrz6MKBGNOdzTLBebasrKybXLq
 UM5/8dHBTROz0Kam/60k686i/ZViuwjhqv+jI1pRx9sR1PbkchKXIByVyxUObpjaV4zR5Cro=
X-Received: by 2002:a05:600c:8211:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-48e51f40ecemr124693325e9.27.1778140553112; 
 Thu, 07 May 2026 00:55:53 -0700 (PDT)
X-Received: by 2002:a05:600c:8211:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-48e51f40ecemr124692415e9.27.1778140552647; 
 Thu, 07 May 2026 00:55:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53116a9fsm49333735e9.8.2026.05.07.00.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 00:55:52 -0700 (PDT)
Message-ID: <f1f78c0b-5792-4046-a9a1-c4c725193284@redhat.com>
Date: Thu, 7 May 2026 09:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] linux-headers: update to Linux 7.1-rc1
To: Song Gao <gaosong@loongson.cn>, maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn,
 pbonzini@redhat.com, cohuck@redhat.com, thuth@redhat.com, mst@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org,
 gaosong <gaosong@loongson.cn>
References: <20260427070029.1059386-1-gaosong@loongson.cn>
 <20260427070029.1059386-3-gaosong@loongson.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260427070029.1059386-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

+ Song Gao

On 4/27/26 09:00, Song Gao wrote:
> Update headers to retrieve the latest KVM caps for LoongArch.
> This commit was created automatically by update-linux-headers.sh.
> 
> Cc: clg@redhat.com
> Cc: pbonzini@redhat.com
> Cc: cohuck@redhat.com
> Cc: thuth@redhat.com
> Cc: mst@redhat.com
> Cc: peter.maydell@linaro.org
> Cc: richard.henderson@linaro.org
> Cc: philmd@linaro.org
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   include/standard-headers/drm/drm_fourcc.h     |  28 +-
>   include/standard-headers/linux/const.h        |  18 +
>   include/standard-headers/linux/ethtool.h      |  28 +-
>   .../linux/input-event-codes.h                 |  13 +
>   include/standard-headers/linux/pci_regs.h     |  71 ++-
>   include/standard-headers/linux/typelimits.h   |   8 +
>   include/standard-headers/linux/virtio_ring.h  |   3 +-
>   include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
>   include/standard-headers/linux/vmclock-abi.h  |  20 +
>   linux-headers/asm-arm64/kvm.h                 |   1 +
>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>   linux-headers/asm-generic/unistd.h            |   5 +-
>   linux-headers/asm-loongarch/kvm.h             |   5 +
>   linux-headers/asm-loongarch/kvm_para.h        |   1 +
>   linux-headers/asm-loongarch/unistd_64.h       |   2 +
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/kvm.h                 |  11 +-
>   linux-headers/asm-riscv/ptrace.h              |  37 ++
>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>   linux-headers/asm-s390/unistd_32.h            | 446 ------------------
>   linux-headers/asm-s390/unistd_64.h            |   1 +
>   linux-headers/asm-x86/kvm.h                   |  21 +-
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/const.h                   |  18 +
>   linux-headers/linux/iommufd.h                 |  48 ++
>   linux-headers/linux/kvm.h                     |  46 +-
>   linux-headers/linux/mshv.h                    |   4 +-
>   linux-headers/linux/psp-sev.h                 |   2 +-
>   linux-headers/linux/stddef.h                  |   4 +
>   linux-headers/linux/vduse.h                   |  85 +++-
>   linux-headers/linux/vfio.h                    |  30 +-
>   38 files changed, 711 insertions(+), 493 deletions(-)
>   create mode 100644 include/standard-headers/linux/typelimits.h
>   create mode 100644 include/standard-headers/linux/virtio_rtc.h
>   delete mode 100644 linux-headers/asm-s390/unistd_32.h


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


