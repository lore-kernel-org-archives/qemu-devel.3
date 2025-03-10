Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D23C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trRqP-0002VF-8D; Sun, 09 Mar 2025 21:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRqN-0002Ul-7e
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:22:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRqL-0005Ha-1I
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:22:10 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bcbdf79cdso20945805e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 18:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741569727; x=1742174527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9e5aV7YQbUvontpDsTrK6eK7yd4RTpsE6tpVFvOqS/0=;
 b=GWxRsbjyYFu6yB+LH1fEguQPGyyzrpS4l3O67bNpf7g1YzEVlMMVHAauhJNywd9oPW
 nTQNIz+yZtMnFiT/3tBZIuqM9gfFWK+6udAvXSWwl82pGQ1sTxp57Jm7UlZJ5ovatfMO
 SeCkIbEYt3KABs6McgzyNjZIohiPuD5SexziewfkhODipK/GxGQDOHxO2vqQT+mvzxtJ
 u6RsEUUQ23qCIEbqoy98/I3ZIfjvSYjZxvUTxnPJeRqcGEPYFA0phJbroM82S/4d7fxc
 b7basBJYHdjUzuiWjC7oM/MqcL3MEkHdUryl27Hn8R8bJ+i2VBQnHGzxmkRUnj68zQIr
 WtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741569727; x=1742174527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9e5aV7YQbUvontpDsTrK6eK7yd4RTpsE6tpVFvOqS/0=;
 b=G5u/DXe9B3m45BGXeac1BjAjCCaT27xitbEHn1V+M/f7J+oDPNTKSuCw0RisZGzCgV
 OhOEcxse4fA+qftBJUX4Ub5/Wj4bgEvPJ7kpffUHxWbAQPrO5PFleAA40ZhsFfZs5tNs
 J6PSnwMD4PYrG/7pxHFxmx06hS8J5Z7E722FVYA0MIPY3P7igj3qelQDO2rxXieLsHC7
 7mzMW2km+LHGrae6CYp/n7uYGmFnMD1FT6dwIkEnEZNcAEe+nnhK5DESuAKWBAGl5UFm
 JaZCZ75K0rVNAWOhfDPkKB8b8YGZOUD4dHg+UDFjqO8DJ0KTcNnroC+9CR+rvrbD9eGF
 Lorg==
X-Gm-Message-State: AOJu0Yx+JgNeULvQKgo6FuKWYnSeBm+Ccrr9Qz3/vfiyEwq+fPGiG4W0
 gtyvKx1eTKkX8tjyTDDmkVtUV5+lx5XqIYM8pe+oX2OvbcEhNDgkKSFuuOKhb/LHJ2WDC/gG3QS
 Iyv8=
X-Gm-Gg: ASbGncsl5bfEI0RTWUurJkBOQdwsyJLhzlIcpL0IyZW7fXDOsJRAL0W5kEbmkUnItU2
 QbdUxe9K91tHOsmiDKyBN7gVhsUKD0k8Ipo4ERn/PLzc2YI7WqV++lVNBnrvXaGawBo7UYJkyT4
 uVOxseJPJvxGg+g4HIg+atY2+nEjuAmQOvKVYnx4+Tv+Pxmi/ZT1WNoVTpAlRt2rIbGOOYjQx29
 C/9Uj8Y9K6wYz2nOZhdQE1wMj7fCsCoEmkQUZcpDASTJllRI6uHTScra9LFoAcbjmRw4ePh9y6j
 +vxuDASlv1q5QMD2nr0mYqkSPOEV4iw9FvNN3oeJly+0qUrDGHunqSVbc/xhe8BK50Cbn7Zj2Z6
 t+MOxvLbbqVqm
X-Google-Smtp-Source: AGHT+IFxALTgduQBnsKg042rL06YID+DbqlSfiKHv6R04yAm6kzyfxeZFPan8cC7fBryE+35sSLwLQ==
X-Received: by 2002:a05:600c:a3a1:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-43ce47808eamr49833215e9.0.1741569726761; 
 Sun, 09 Mar 2025 18:22:06 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e1d67sm13334534f8f.74.2025.03.09.18.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 18:22:06 -0700 (PDT)
Message-ID: <6ab75235-0ba3-45be-a0cf-ec3ae96e856d@linaro.org>
Date: Mon, 10 Mar 2025 02:22:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/41] hw/vmapple/vmapple: Add vmapple machine type
To: qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alexander Graf <graf@amazon.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250305012157.96463-1-philmd@linaro.org>
 <20250305012157.96463-10-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250305012157.96463-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 5/3/25 02:21, Philippe Mathieu-Daudé wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Apple defines a new "vmapple" machine type as part of its proprietary
> macOS Virtualization.Framework vmm. This machine type is similar to the
> virt one, but with subtle differences in base devices, a few special
> vmapple device additions and a vastly different boot chain.
> 
> This patch reimplements this machine type in QEMU. To use it, you
> have to have a readily installed version of macOS for VMApple,
> run on macOS with -accel hvf, pass the Virtualization.Framework
> boot rom (AVPBooter) in via -bios, pass the aux and root volume as pflash
> and pass aux and root volume as virtio drives. In addition, you also
> need to find the machine UUID and pass that as -M vmapple,uuid= parameter:
> 
> $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
>      -bios /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/AVPBooter.vmapple2.bin
>      -drive file=aux,if=pflash,format=raw \
>      -drive file=root,if=pflash,format=raw \
>      -drive file=aux,if=none,id=aux,format=raw \
>      -device vmapple-virtio-blk-pci,variant=aux,drive=aux \
>      -drive file=root,if=none,id=root,format=raw \
>      -device vmapple-virtio-blk-pci,variant=root,drive=root
> 
> With all these in place, you should be able to see macOS booting
> successfully.
> 
> Known issues:
>   - Currently only macOS 12 guests are supported. The boot process for
>     13+ will need further investigation and adjustment.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-ID: <20241223221645.29911-15-phil@philjordan.eu>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                 |   1 +
>   docs/system/arm/vmapple.rst |  65 ++++
>   docs/system/target-arm.rst  |   1 +
>   hw/vmapple/vmapple.c        | 618 ++++++++++++++++++++++++++++++++++++
>   contrib/vmapple/uuid.sh     |  12 +
>   hw/vmapple/Kconfig          |  21 ++
>   hw/vmapple/meson.build      |   1 +
>   7 files changed, 719 insertions(+)
>   create mode 100644 docs/system/arm/vmapple.rst
>   create mode 100644 hw/vmapple/vmapple.c
>   create mode 100755 contrib/vmapple/uuid.sh


> +static void vmapple_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->init = mach_vmapple_init;
> +    mc->max_cpus = 32;
> +    mc->block_default_type = IF_VIRTIO;
> +    mc->no_cdrom = 1;
> +    mc->pci_allow_0_address = true;
> +    mc->minimum_page_bits = 12;
> +    mc->possible_cpu_arch_ids = vmapple_possible_cpu_arch_ids;
> +    mc->cpu_index_to_instance_props = vmapple_cpu_index_to_props;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("host");

Not sure how I missed that earlier, but I'm now getting:

$ make check-qtest-aarch64
qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF

> +    mc->get_default_cpu_node_id = vmapple_get_default_cpu_node_id;
> +    mc->default_ram_id = "mach-vmapple.ram";
> +    mc->desc = "Apple aarch64 Virtual Machine";
> +
> +    compat_props_add(mc->compat_props, vmapple_compat_defaults,
> +                     G_N_ELEMENTS(vmapple_compat_defaults));
> +}


