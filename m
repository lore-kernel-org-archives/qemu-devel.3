Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC18C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujIdF-0005kB-9i; Tue, 05 Aug 2025 10:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujIcj-0005ch-1H
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:26:47 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujIcg-0005a4-6W
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:26:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b7886bee77so4718720f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754403996; x=1755008796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vK3VjNTz6a/Hxs4VuHlZztEZAqh8hQ2FbtCNNj6B7A0=;
 b=ADZ8oPmkyED761ZVVOyTV3QDWPgrYB7yJ2s4Ndl027kqN7BMG4mE0oueaom5pOod0d
 qlQWaJwPu2akmyvkFgyHQdn7Vea6ktPKQ2JhdElUbGqj7f0xiBCnGpg+7kVUX3E/u7L4
 pZlYeCmwobpelyaT2tuMqbi58KHaqUG4nc7N9/GHYq2cQ9nsnw27q+ZA7LX2abH0vHG8
 YWZoogBmZOT5xqWqRGxiqKGq/I3MndMgdxtsPojudrMcQaE5s2nJnRBhyFdnO3bDdr+3
 6hb/EdZvUXkSKqsC3WX5SJrHqmv4MHHeNZO6tQvp6FGctBCp8ScWhEzUG+u6YofipOrQ
 PCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754403996; x=1755008796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vK3VjNTz6a/Hxs4VuHlZztEZAqh8hQ2FbtCNNj6B7A0=;
 b=upWePS2mEx8pRSsg20oB1DM6XcywG9Y3gcLvBzxn5jimDJR62pH9AUjffXeSnfbRPm
 HIR/MC0OeWzSEV/zyIaIRR6gP9S9dXVk5wjxqZziuAdnW0SJ0W2N67b6dNln89Qhoi1p
 hiKQikyD+UD/qsL3kcixjKMtRjb09VOrNg7eo06BFlVs7aVPJzyrW0l19KqFJ1ysOf84
 sfRavMGdPTuSpQSI44MA4Fy1ZyE4Oxr0fTys8FetNyUbsm8S9vKIDUs+Y939eDMrjEw4
 B3asmFnL6bvdeT9klBzHVNRrHFxLRyNljOGAAxfirywFnRlDgt20E1TzscXzZ6YCx6jl
 kXmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvzUQ+qwo98lUBvzDkkZn5yj8kco2usUO11/dlHc+JwOcpJREXrVNUhrXvM+85o2dAuEzJ1pc7cIw4@nongnu.org
X-Gm-Message-State: AOJu0YxB/JTLo2RKkbCeg7frWVSEImypBMDbERxCOB+AXMvAJ7cNWfkO
 eaRxe1JVYMcSOHiOLVLBKdOGJYN6hPJsXIANKjC6LP9Kbs9bqzW39MTO/Ud4CDIcwu/UFP9X6kd
 Ns9Uq
X-Gm-Gg: ASbGncu0Qpezp3EQB+VyDgHNDqbJhUvyegsLllLLinlBO8EuuJjTBpaS07knuj8tSCr
 WvxZbwRBg+AjrqpWfeJgk835oTS6ai1OW1PXihTnAf2JmTvuHK3kKVnbeEg908Kss0QEtBIYzFz
 neGEMlX5ft8418FKV4RsI65ltEHKhPfKoqTkgJ3/5fQgVd9gsBZWfsTOJCLkEBY3mTLXO6ujjMd
 EEc7DfqmnwCTJsHOd/pq5D2UlJz+zsKaCGiJUHAhwNeZIiNjDpwIKfDGmiCiL5tgwoJ5JDhmRVm
 qLErDmiW1svQtl48+fDhlYwF7TdP1fIchtSGphX3yyciYdJY6zWUx1FkVNPLE5cddu4v8cdWu2J
 FOk/NszuoxZhdQQi6HUTDRFjRNLZvi3xJ0gADg0dGdMPMJ4vlygg9b6tWLPspEx9ovQ==
X-Google-Smtp-Source: AGHT+IHFWCbKIF/ewZNV96lN+p4u12+4F66NbMLJbikpNv5rAbeR8Ut5lMLPmKBpUJC4TQr8Wp0pTg==
X-Received: by 2002:a05:6000:22c7:b0:3b8:893f:a184 with SMTP id
 ffacd0b85a97d-3b8d94ce5admr8934430f8f.52.1754403995894; 
 Tue, 05 Aug 2025 07:26:35 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dbba5210sm75383215e9.2.2025.08.05.07.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 07:26:35 -0700 (PDT)
Message-ID: <b37bd098-4553-4d16-be21-c230362c7c5b@linaro.org>
Date: Tue, 5 Aug 2025 16:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 10.1] microvm: Explicitly select ACPI_PCI
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 mst@redhat.com, kraxel@redhat.com, mjt@tls.msk.ru
References: <20250804152008.247673-1-eric.auger@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250804152008.247673-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/8/25 17:20, Eric Auger wrote:
> With a microvm-only build based on a custom device config,
> we get a link failure due to undefined reference to
> build_pci_host_bridge_osc_method() which is defined in hw/acpi/pci.c and
> whose compilation depends on CONFIG_ACPI_PCI. Although CONFIG_ACPI
> and CONFIG_PCI are set with such configuration, implied CONFIG_ACPI_PCI
> in config PCI_EXPRESS_GENERIC_BRIDGE is not selected as expected.
> 
> It Looks like CONFIG_ACPI_PCI must be enforced and this patch selects
> CONFIG_ACPI_PCI in MICROVM config directly as done for PC config.
> 
> Reproducer:
> 
> ../configure \
>   --without-default-features \
>   --target-list=x86_64-softmmu \
>   --enable-kvm --disable-tcg \
>   --enable-pixman \
>   --enable-vnc \
>   --audio-drv-list="" \
>   --without-default-devices \
>   --with-devices-x86_64=microvm \
>   --enable-vhost-user
> 
> with configs/devices/x86_64-softmmu/microvm.mak:
> CONFIG_PCI_DEVICES=n
> 
> CONFIG_MICROVM=y
> 
> CONFIG_VIRTIO_BLK=y
> CONFIG_VIRTIO_SERIAL=y
> CONFIG_VIRTIO_INPUT=y
> CONFIG_VIRTIO_INPUT_HOST=y
> CONFIG_VHOST_USER_INPUT=y
> CONFIG_VIRTIO_NET=y
> CONFIG_VIRTIO_SCSI=y
> CONFIG_VIRTIO_RNG=y
> CONFIG_VIRTIO_CRYPTO=y
> CONFIG_VIRTIO_BALLOON=y
> CONFIG_VIRTIO_GPU=y
> CONFIG_VHOST_USER_GPU=y
> 
> FAILED: qemu-system-x86_64
> cc -m64 @qemu-system-x86_64.rsp
> /usr/bin/ld: libsystem.a.p/hw_pci-host_gpex-acpi.c.o: in function `acpi_dsdt_add_host_bridge_methods':
> hw/pci-host/gpex-acpi.c:83:(.text+0x274): undefined reference to `build_pci_host_bridge_osc_method'
> collect2: error: ld returned 1 exit status
> 
> Fixes: af151d50eac24 "hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method"
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/i386/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Patch queued, thanks.

