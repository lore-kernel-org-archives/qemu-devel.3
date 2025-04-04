Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA617C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 14:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0iDW-0002UM-0m; Fri, 04 Apr 2025 10:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0iDT-0002U5-Ss
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:40:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0iDR-0002vc-MS
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:40:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so14533675e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743777615; x=1744382415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7TwIoD1PQujucCYAoWo/gLYpE1VYWQRS9mS2q3hGAz0=;
 b=hH5njUFMJt/YrL6PXTxf0D9I++fHMFbR4fEnc+oWSwk6OHWiAq3lWGi6XoVm+idGmA
 bihNXxl2d75jVzvi9CyNtchw6hl9pcEC+Lwyg/RXdiHTdzqSnF12gAOY4CIwvFTJ01sj
 QWw1WcGhsWomicWejSWWXwD4QmmTE706bkktqHcVpSqTMnTmH8wLiYomKOteWCdPGbMS
 JJb+QIXMDcX0P43FO1jRF1LUv108YQ9a8qB5v/I+tUZuOxTPj7w9JwTG02jiWw67nR1V
 ccWJZfM02B69EITRYnCmN6PaAsImLVau17rU3dLkvbJOvTAammbi6rj06TorVcSJLh/G
 /kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743777615; x=1744382415;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7TwIoD1PQujucCYAoWo/gLYpE1VYWQRS9mS2q3hGAz0=;
 b=nhpMLACVqtsXgR3HzH/jphtTlJdRgkbB8UlUNw2ArIXkKEV4kpr71fNdO9cSGLKaSC
 QGjT828aJdB+b2i2/ULSIqKjwxoyxGa2wRxj3MR3KIukA5Q42+0Q2a41PLXfeCnhgad1
 9mEIpahuNcCj84yI9edTO+exFf1rDu3DlPdSGKWqKuKE9+hmDiNqJBEjJfYX98ulHkRf
 bnq4jtVIeReP/DN8tq55SNtdWKK0WlaTST3RXgOqL4tONkI7h6zMbxLkH37SCYX0UTlm
 s6p9PvgyEn/FJOAGqCD14j7jeXY2Ae7NkuhgT0Q3S93fhgfF9NmFL0Te2glHm1D3UkXr
 3EXg==
X-Gm-Message-State: AOJu0YzD6AXk3Ogx09hvJSzwnsYAjNCK2u+K5HCj2cZUsf5pzVttf6Yg
 BO4vVkq7E94u9iTKfXNwxYSWhbIHe4xZdFT/ieQfSna32RUHVWHYg5aI7y7ITj+yZWJwVj+GTMz
 b
X-Gm-Gg: ASbGncuDltAiC3ZoTAwP9MyuD9MLWxUb6vg1dnRzhuPJHkcbygUdHaNs9B84npWByn0
 hM5rVEf53Gy36MTG0x9ZQZgrfnZdFQgP3Dl0ma8NjnYDN5ZQCU85XD3Qm+yMIKO7CDVMEcplQ5H
 ryw8uMTvVM0JPkD/Lcuizuv7lU6AM5hOQEghcsClng8Wn44zMXxgMnZF0078vAjFvhZikcsyx4W
 ZiRYaWpWlMfksysBQv44pzxvzGO4N82Jxo//LiW74cwB304vfzBWdzl5bJYUVXtgVzIVSsdHI96
 Dk1XizHyLHGhqU3aPn3YGSvlo5/oWYeNQofVkhxj4o4ECDCAFpvuiVIRtuuyRXUQf5u4L+iok/N
 xd+g1RAd7hsGdKVrLyq7Wmis=
X-Google-Smtp-Source: AGHT+IGC0niX1KSne0Hxy6W87yNs9dKj3bpVZd3MaiTQDxQtU2JG61J6x/S6H4oHKMkX4f5W/e4XDQ==
X-Received: by 2002:a05:600c:3548:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-43ed0b5e285mr28122385e9.4.1743777615394; 
 Fri, 04 Apr 2025 07:40:15 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630ddesm51096125e9.5.2025.04.04.07.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 07:40:14 -0700 (PDT)
Message-ID: <1f47ee6c-cc71-4b24-85c6-1afe534adf52@linaro.org>
Date: Fri, 4 Apr 2025 16:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 38/39] hw/arm: Move xen files to
 arm_common_ss[]
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-39-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20250403235821.9909-39-philmd@linaro.org>
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

On 4/4/25 01:58, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> XXX untested

Now with Xen setup accessible, so tested. What is missing:

-- >8 --
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index d1509bd235..8e81947c7d 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -12,3 +12,2 @@
  #include "hw/xen/xen-pvh-common.h"
-#include "hw/xen/arch_hvm.h"

diff --git a/hw/arm/xen-stubs.c b/hw/arm/xen-stubs.c
index 5551584dc2..f3681835d7 100644
--- a/hw/arm/xen-stubs.c
+++ b/hw/arm/xen-stubs.c
@@ -11,3 +11,3 @@
  #include "hw/xen/xen-hvm-common.h"
-#include "hw/xen/arch_hvm.h"
+#include "hw/arm/xen_arch_hvm.h"

---

Otherwise we get:

In file included from ../../hw/arm/xen-pvh.c:13:
include/hw/xen/arch_hvm.h:1:13: error: attempt to use poisoned "TARGET_I386"
     1 | #if defined(TARGET_I386) || defined(TARGET_X86_64)
       |             ^
include/hw/xen/arch_hvm.h:1:37: error: attempt to use poisoned 
"TARGET_X86_64"
     1 | #if defined(TARGET_I386) || defined(TARGET_X86_64)
       |                                     ^

> ---
>   hw/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index c46e5036722..61f145f901f 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -63,7 +63,7 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
>   arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>   arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>   arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
> -arm_ss.add(when: 'CONFIG_XEN', if_true: files(
> +arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
>     'xen-stubs.c',
>     'xen-pvh.c',
>   ))


