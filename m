Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD94CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjOo-0007yW-V3; Tue, 28 Oct 2025 09:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDjOn-0007xt-4X
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:06:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDjOi-0000qD-7L
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:06:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-475dd559b0bso44677825e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761656754; x=1762261554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mXfbEpAvx+wk43Zo4ZCte1quumNYK7zO7MKx3CFVRdM=;
 b=URJEBm5ePsSOvxdcaxJCTxqEkeE/YTKjhyhFEQkV5uKk39b2+22R853DqHJCw4PrBZ
 Sl81mfiWTAzdfxJTv1rneLWL5i86LQSAiVVXOQYqji8Gl72djxujj0ozYpQCiKeYL//5
 yVpB7kzExRBrOU95PZWau018RIkCprtNq4U5UdTGMsQbVtea1BvhZMDjZ2w9+SuKEMkZ
 zCRa936k94nU+jujv1HZvTjJJLFk9o+dM3L131Y41QKlRuvGUzf5xAtj/9Ba79rjyW5Q
 kwmvDrud07HwM908d0eU0PJWi51XN4bDXr/E9OIaezxUcSJ9ojHqdP8YFO41ajNNfCO/
 M1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761656754; x=1762261554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mXfbEpAvx+wk43Zo4ZCte1quumNYK7zO7MKx3CFVRdM=;
 b=aO/VoQSUvU4LSxArJcvQMTpOCqhl0eMYKs3BzvUhGzfG6JFeF0LlrODASacoIhVtDr
 kovRmNW5NvGVLqPAcZj3iX6juXE8HyeuAMJKRd3ZyhMSkNAqhddPVZn1tC2fswinPwQf
 WOL6tFqrXrsJnVEOp6Spn8BDifDDtXmz5DabYVIOiVSEMyWdHxSVwJvIzN6aJa7gORmp
 vmnmsYw0bEm2BfxQu8IzH6M+hGi7at6n4gCCJzpCIFkRZBU8Nm60Tx9ndrx8HeEsiW4S
 J1ahEodMqtdjTG61p9HL1CiTQ/eApOvMi4fR1UCfwLwwMTTKO2IQTOL2n7uCTGBI+EdT
 rttA==
X-Gm-Message-State: AOJu0YxlQTZHjAicKdyYFJeWMHC8NsNL3qji3eOAiz5kVzGZs1GQj0CX
 uuDsoMFCKkbHK4GkuoIesAIzRkIX/mOqX7WXNEe7WSBOUuD3uIa+O9DdZnToD0FHWeuo0JbRXau
 2ZbNv
X-Gm-Gg: ASbGnctaMzgf+1WF+tCU62ituyygwE59PeDHIka5N4Zj+eaKBxP7gnzM7fvw0QmhISh
 bqkgNTBm4teAU2yhQWpwQK23woZZOT/TS8Il+wJbcVKYDvqueEm6+puq2XaZb9TiNQKKK+DbzeQ
 94cAJjjyWtiNWyMIFiPllBXYJ8N9lEMLCcWdLypS1AzO9rmnh1yB/60sFwWIbAx33CgeAU4RGUt
 gHXJ7EfTE8Y5/r2OxLSO/cnwnKYBIyPNEkmflP7RN874r3M0TxAo3ZJZLZl7QaptnupREhmSmn9
 4q/pZA6t1EBb04IOU8EI4ZhWdOoGD2YBhYGcInvDPtmDTnbNgwpupO1VhiF+kKK5Cmzw4jfKwHH
 sAb5rUFIBUu5wEbbeprErq/0U4tt1ZBkKaPb1WQ9dY0hn/oh2/b/mH3AOl7gCW9zSKZpg7EFDY7
 CBVkn5RXw+Z8tJhUaGkbBqm+aL2IYoD4BAw/YaARFqaVdr0o4AHL3g+HQiGLPHZH7MEQ==
X-Google-Smtp-Source: AGHT+IE3ezY5Zvg5wIu7N7jFU/gtpj8cMQjB7HnyFKiSttcFlWRyhSha5DjqnxAbGVzwyt8KcdssfQ==
X-Received: by 2002:a05:600c:548f:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-47717e512dbmr25594555e9.23.1761656754202; 
 Tue, 28 Oct 2025 06:05:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6?
 ([2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952ca979sm20826224f8f.14.2025.10.28.06.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 06:05:53 -0700 (PDT)
Message-ID: <df404447-bed8-41cb-9514-fc581ef0824f@linaro.org>
Date: Tue, 28 Oct 2025 14:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
To: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
 <CAFEAcA9Rvvymu7oS0pPx00v9SdXzwr27vy1VmnZmwQ7ayZK+yQ@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9Rvvymu7oS0pPx00v9SdXzwr27vy1VmnZmwQ7ayZK+yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32d.google.com
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

On 2025-10-28 13:46, Peter Maydell wrote:
> On Sun, 29 Jun 2025 at 21:49, Bernhard Beschow <shentey@gmail.com> wrote:
>>
>> Allows the imx8mp-evk machine to be run with KVM acceleration as a guest.
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>> ---
>>   docs/system/arm/imx8mp-evk.rst |  7 +++++++
>>   hw/arm/fsl-imx8mp.c            | 33 ++++++++++++++++++++++++++++-----
>>   hw/arm/imx8mp-evk.c            | 11 +++++++++++
>>   hw/arm/Kconfig                 |  3 ++-
>>   hw/arm/meson.build             |  2 +-
>>   5 files changed, 49 insertions(+), 7 deletions(-)
>>
>> diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
>> index b2f7d29ade..1399820163 100644
>> --- a/docs/system/arm/imx8mp-evk.rst
>> +++ b/docs/system/arm/imx8mp-evk.rst
>> @@ -60,3 +60,10 @@ Now that everything is prepared the machine can be started as follows:
>>         -dtb imx8mp-evk.dtb \
>>         -append "root=/dev/mmcblk2p2" \
>>         -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
>> +
>> +
>> +KVM Virtualization
>> +------------------
>> +
>> +To enable hardware-assisted acceleration via KVM, append
>> +``-accel kvm -cpu host`` to the command line.
> 
> Coming back to this now we've resolved the "does this put
> things inside our security-promises that we don't want"
> question...
> 
> I think we should be a bit clearer in the documentation
> about what tradeoffs the user is making here when they select
> KVM. Specifically:
> 
>   * we should note that this is intended only to improve
>     performance, and is not covered by QEMU's security policy
>   * we should say that you will not get a Cortex-A53, so any
>     guest code with tight dependencies on the host CPU type
>     might not work correctly
>   * we should say that the guest will only be able to run
>     at EL1, and (unlike TCG) there is no EL2 or EL3
> 
>> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
>> index 866f4d1d74..7e61392abb 100644
>> --- a/hw/arm/fsl-imx8mp.c
>> +++ b/hw/arm/fsl-imx8mp.c
>> @@ -12,11 +12,13 @@
>>   #include "system/address-spaces.h"
>>   #include "hw/arm/bsa.h"
>>   #include "hw/arm/fsl-imx8mp.h"
>> -#include "hw/intc/arm_gicv3.h"
> 
> Why does this include get removed ?
> 
>>   #include "hw/misc/unimp.h"
>>   #include "hw/boards.h"
>> +#include "system/kvm.h"
>>   #include "system/system.h"
>> +#include "target/arm/cpu.h"
>>   #include "target/arm/cpu-qom.h"
>> +#include "target/arm/kvm_arm.h"
>>   #include "qapi/error.h"
>>   #include "qobject/qlist.h"
> 
>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>> index d90be8f4c9..a4212a6ab2 100644
>> --- a/hw/arm/meson.build
>> +++ b/hw/arm/meson.build
>> @@ -59,7 +59,7 @@ arm_common_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
>>   arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
>>   arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
>>   arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
>> -arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
>> +arm_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
>>   arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>>   arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>>   arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
> 
> Philippe, Pierrick: is it OK that this moves the
> fsl-imx8p.c file from arm_common to arm_ss, or is there
> a preferable way to do this from a single-binary point
> of view?
>

Looking at original patch, this is needed because an ifdef CONFIG_KVM is 
introduced.

  static void imx8mp_evk_machine_init(MachineClass *mc)
  {
+    static const char *const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a53"),
+#ifdef CONFIG_KVM
+        ARM_CPU_TYPE_NAME("host"),
+#endif /* CONFIG_KVM */
+        NULL
+    };
+

This is not needed, and valid_cpu_types array can be dynamically 
created, adding "host" only if kvm_enabled().

See this patch for reference:
https://lore.kernel.org/qemu-devel/20251021210144.58108-4-philmd@linaro.org/

> thanks
> -- PMM

Pierrick

