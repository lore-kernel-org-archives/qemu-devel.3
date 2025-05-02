Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07975C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtQP-00066c-DD; Fri, 02 May 2025 12:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAtQO-00066D-LR
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:39:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAtQL-0004Oj-CZ
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:39:44 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so2244629b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746203980; x=1746808780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ov2+fSeigHznskBWAHFz17Xla4OiPqdPbenXGIwMlQQ=;
 b=iWXER99N55qyZPyVhViDadA3mAD/krmvorog4E/UZBFqMXv8VyKyhDXV6pfE1Y8LV9
 Y4VOrmlyrC0JckSdnfNvS/KPWINpKJtAIHXsijv6AA4l54tD3gfBAk1c1ZfHvy5qFgAD
 k5UZid04l00wvmSFRmOBZe7BnaiIYtWkPBwdByiF72R8dppEZdqGD//bS/a+xmJx8a9I
 d4QGJxEENAdRZloZti7YmS+tfh2tepM7dWriDj7Zx5ooSNyazwP3vXXfGix1odcO0evV
 beyp4xmYWd9AcvhQoNeXNO6izLvpAwmhy7rtN0naVAh71+sBsy/3/T88jdwuQN+d/fBD
 iTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746203980; x=1746808780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ov2+fSeigHznskBWAHFz17Xla4OiPqdPbenXGIwMlQQ=;
 b=qFWic+B55FXcixg1D/I/kzRQ2ul14+2/jOJRaQG05OlSf7BdcSY8VIlpMpMAhvUJy/
 9C0rpAM1dmSJKL7umI1PxuTZ30A3RUa4+1AbEcGdzu9jVRn2Xw8aQAYxifxWYmOSosnU
 nobK/r/tnKpz3S0iGq5ao8B7BGO/grBbeZNt2/bJ92e1YgB2srWgQFtqnEXzTFyzlPmd
 XgzCoTyruw2XuI9cVNX+Jze0BX+SlTKDUoiHO5vW4OSyUOO1/SdbDr5GLV2YevuurI4M
 5i+n0ZluWaR+3u7L+GT1lvQTLpwn+odYE95FetYTgA22bPs9SLsLimFrFkO9Xen4woba
 nm5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIDRWNYWzPsLIoRpmzms/7/ZKbB/EChQcwlMofV8Gl6LfkvIusXjgqUipDLaPajAzSgSRuLATDOQv0@nongnu.org
X-Gm-Message-State: AOJu0YyD22fuBqRWhLi5SNdUMPDNbI0CcljItRdPYNZvj6jk7fs2hNFY
 qHzmUphr8zPB9S7XJs5kGBJDjyKqJ1vtSDahjEP/6diVf3W5rHTxF0mGM+5K1YE=
X-Gm-Gg: ASbGncuV8Hh7gNpPStESgY47SnmyiW+8JVa2yJU+XZ8MG9K3SF9a9+QPg61oVGtU42v
 mHK1N3sBNhu84rvudlm7E6SOC3ayxzp8RD+GqZsP7s2bArf3vst9lsnqymMRkma+uMM0MNqUWpv
 OOixhM3DTJFef1+s/xCfpC57+q1tYaFLAEvxzNBV/P5mMlew0WyP5QvHoZ9yW2oXbi/cyL4s8/4
 tyHfNzF0Ed208F+FUGFczMw4msyWphHosu3DbbMUbuvmlNJD/sxYYyHPmWuOtxAjqZGzmA7yy04
 KAnjKxhq8ysR+HzdX5ezylXOXqItbR9xqMiBjphUN2YGEHvUPLMzVQ==
X-Google-Smtp-Source: AGHT+IHmVuFWCI2rlgJozk+6E57xaLTpIykHP1/vDuaDAViicHmCpsOUPQZ2ztzUWD8nXUVxU0xBOA==
X-Received: by 2002:a05:6a00:4ace:b0:739:50c0:b3fe with SMTP id
 d2e1a72fcca58-74058a1a76amr5976300b3a.8.1746203979630; 
 Fri, 02 May 2025 09:39:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3c6d5aasm977527a12.74.2025.05.02.09.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 09:39:39 -0700 (PDT)
Message-ID: <ff403231-a36a-46a8-9168-2ac32a44328a@linaro.org>
Date: Fri, 2 May 2025 09:39:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/virtio: Introduce CONFIG_VIRTIO_LEGACY to disable
 legacy support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250502132441.64723-1-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250502132441.64723-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/2/25 6:24 AM, Philippe Mathieu-Daudé wrote:
> Legacy VirtIO devices don't have their endianness clearly defined.
> QEMU infers it taking the endianness of the (target) binary, or,
> when a target support switching endianness at runtime, taking the
> endianness of the vCPU accessing the device.
>

Probably it's what you meant, but it is clearly defined by the standard 
[1]. It's just not fixed.

2.4.3 Legacy Interfaces: A Note on Virtqueue Endianness
Note that when using the legacy interface, transitional devices and 
drivers MUST use the native endian of the guest as the endian of fields 
and in the virtqueue. This is opposed to little-endian for non-legacy 
interface as specified by this standard. It is assumed that the host is 
already aware of the guest endian.

[1] 
https://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-250003

> Devices modelling shouldn't really change depending on a property
> of a CPU accessing it.
> 

Devices concerning various targets are aware of the cpu and its properties.

> For heterogeneous systems, it is simpler to break such dev <-> cpu
> dependency, only allowing generic device models, with no knowledge
> of CPU (or DMA controller) accesses.
>

At this point, we speculated it could be a problem, without really 
proving it. In case all accesses are done within a given vcpu thread, 
there is no ambiguity on the current endianness.
How about we wait to expose a crash in an heterogeneous system to take a 
decision?

> Therefore we introduce the VIRTIO_LEGACY Kconfig key. We keep the
> current default (enabled).
> New binaries can set CONFIG_VIRTIO_LEGACY=n to restrict models to
> the VirtIO version 1 spec.
>

I think it's a good change, regarding the legacy support.

However, if the only goal is to support a custom configuration for 
heterogeneous emulation, I think it's the wrong direction.

In essence, we are working hard right now to remove compile time 
configuration for various QEMU targets.
So seeing a new compile time configuration to solve something looks like 
the opposite of what we are trying to achive.
A possible alternative would be to enable virtio legacy support at 
runtime, based on a specific criteria. From what I remember, legacy vs 
modern is a property set by disable-modern=bool,disable-legacy=bool, and 
"modern" is the default.
Thus, we can simply restrict the disable-legacy=on in case we detect 
it's an heterogeneous emulation scenario.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 5 ++++-
>   hw/virtio/virtio.c                | 8 ++++++++
>   target/arm/cpu.c                  | 5 +++++
>   target/ppc/cpu_init.c             | 5 +++++
>   hw/virtio/Kconfig                 | 5 +++++
>   5 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> index 07aae69042a..b5b471711a6 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -20,7 +20,10 @@
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-bus.h"
>   
> -#if defined(TARGET_PPC64) || defined(TARGET_ARM)
> +#include CONFIG_DEVICES
> +
> +#if defined(CONFIG_VIRTIO_LEGACY) && \
> +    (defined(TARGET_PPC64) || defined(TARGET_ARM))
>   #define LEGACY_VIRTIO_IS_BIENDIAN 1
>   #endif
>   
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 480c2e50365..659ab3cb969 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -47,6 +47,8 @@
>   #include "standard-headers/linux/virtio_mem.h"
>   #include "standard-headers/linux/virtio_vsock.h"
>   
> +#include CONFIG_DEVICES
> +
>   /*
>    * Maximum size of virtio device config space
>    */
> @@ -3502,6 +3504,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
>   bool virtio_legacy_allowed(VirtIODevice *vdev)
>   {
>       switch (vdev->device_id) {
> +#ifdef CONFIG_VIRTIO_LEGACY
>       case VIRTIO_ID_NET:
>       case VIRTIO_ID_BLOCK:
>       case VIRTIO_ID_CONSOLE:
> @@ -3513,6 +3516,7 @@ bool virtio_legacy_allowed(VirtIODevice *vdev)
>       case VIRTIO_ID_RPROC_SERIAL:
>       case VIRTIO_ID_CAIF:
>           return true;
> +#endif
>       default:
>           return false;
>       }
> @@ -4014,8 +4018,10 @@ static const Property virtio_properties[] = {
>       DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
>       DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>       DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
> +#ifdef CONFIG_VIRTIO_LEGACY
>       DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
>                        disable_legacy_check, false),
> +#endif
>   };
>   
>   static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
> @@ -4151,7 +4157,9 @@ static void virtio_device_class_init(ObjectClass *klass, const void *data)
>       vdc->start_ioeventfd = virtio_device_start_ioeventfd_impl;
>       vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
>   
> +#ifdef CONFIG_VIRTIO_LEGACY
>       vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
> +#endif
>   }
>   
>   bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5e951675c60..d01fcb9fd1a 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -39,6 +39,7 @@
>   #if !defined(CONFIG_USER_ONLY)
>   #include "hw/loader.h"
>   #include "hw/boards.h"
> +#include CONFIG_DEVICES
>   #ifdef CONFIG_TCG
>   #include "hw/intc/armv7m_nvic.h"
>   #endif /* CONFIG_TCG */
> @@ -1130,6 +1131,7 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
>   #endif
>   }
>   
> +#ifdef CONFIG_VIRTIO_LEGACY
>   static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
> @@ -1138,6 +1140,7 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
>       cpu_synchronize_state(cs);
>       return arm_cpu_data_is_big_endian(env);
>   }
> +#endif
>   
>   #ifdef CONFIG_TCG
>   bool arm_cpu_exec_halt(CPUState *cs)
> @@ -2681,7 +2684,9 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
>       .asidx_from_attrs = arm_asidx_from_attrs,
>       .write_elf32_note = arm_cpu_write_elf32_note,
>       .write_elf64_note = arm_cpu_write_elf64_note,
> +#ifdef CONFIG_VIRTIO_LEGACY
>       .virtio_is_big_endian = arm_cpu_virtio_is_big_endian,
> +#endif
>       .legacy_vmsd = &vmstate_arm_cpu,
>   };
>   #endif
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index b0973b6df95..4b6c347bda8 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -50,6 +50,7 @@
>   #include "hw/boards.h"
>   #include "hw/intc/intc.h"
>   #include "kvm_ppc.h"
> +#include CONFIG_DEVICES
>   #endif
>   
>   #include "cpu_init.h"
> @@ -7352,12 +7353,14 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
>   
>   #ifndef CONFIG_USER_ONLY
>   
> +#ifdef CONFIG_VIRTIO_LEGACY
>   static bool ppc_cpu_is_big_endian(CPUState *cs)
>   {
>       cpu_synchronize_state(cs);
>   
>       return !FIELD_EX64(cpu_env(cs)->msr, MSR, LE);
>   }
> +#endif
>   
>   static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
>                                 uint64_t **irq_counts, unsigned int *nb_irqs)
> @@ -7470,7 +7473,9 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
>       .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
>       .write_elf32_note = ppc32_cpu_write_elf32_note,
>       .write_elf64_note = ppc64_cpu_write_elf64_note,
> +#ifdef CONFIG_VIRTIO_LEGACY
>       .virtio_is_big_endian = ppc_cpu_is_big_endian,
> +#endif
>       .legacy_vmsd = &vmstate_ppc_cpu,
>   };
>   #endif
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 7648a2d68da..314185f0016 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -1,6 +1,11 @@
>   config VIRTIO
>       bool
>   
> +config VIRTIO_LEGACY
> +    bool
> +    default y
> +    depends on VIRTIO
> +
>   config VIRTIO_RNG
>       bool
>       default y

If the goal is to condition virtio_legacy, to maybe deprecate it one 
day, then:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

