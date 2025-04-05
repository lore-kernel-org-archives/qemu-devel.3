Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F35C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 14:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u14kJ-0000VF-BU; Sat, 05 Apr 2025 10:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u14kI-0000UJ-5x
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:43:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u14kG-0000NY-CH
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:43:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso1711930f8f.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743864218; x=1744469018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XINWtuEyB8nAdjn+nKZgqjpd4oQLnzMy/dAbE5k9dvE=;
 b=xn+RdiMPxjOAGwk0l35It/u5r3bDo6pnNeSvpTfHvLh7WwY2vaAwnj0dEul4ZAV8Kq
 WfnJ3A0bXhGHcL+TM6srwCb6bsjDEW2W1hjTZIt0iK733chnLo+VjCaJt6BrsSfN1nPU
 VEVyaaCBM4Kcylj0BtEGBx6FcGOWb7IalhDenEbJl1inymrkV3chAN+reNcixkKXBu2e
 A4og7II+h3LYjiwPiIJ8YgWjhc5y/Thsh4Scb6dOz/NykjIJ6MomkO3xxbYOYV/HVCUx
 W1/79p9+RAFJH4zEGbRCmlaUMSr9MFdvHePFEs3lUW3l78oCEkSWNj75liMtZ8/74Ye1
 mmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743864218; x=1744469018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XINWtuEyB8nAdjn+nKZgqjpd4oQLnzMy/dAbE5k9dvE=;
 b=FkUF38e1yB6jrQl7TJ/Uy0U3iZ5XYX54lXe9zqzXwRYh21AIM8VtmipmNLYzigKxhh
 z+UJLy8IN7mAY14xJADuATvjkMQysYtdvJPwK/DK94JdUVU1QqIjZlSCppqn+5mVCXXS
 g5f5K0hoQpEONARyAGLU82+9ZFGH58K69aVagyH80N5frtOwRg80dqbeFQV91X9WNcTU
 NCdNg7W8Zaj5DsHzaFnEo8HVEyNRvQBdIQK2igaA0TEWcVajcBouwoZ2ZanDFOtGLWzR
 058goVqD153FjAQBiRzgj1EzQKpe9xtWJPZA3GPg0khAlPWSDTH4TFBKR0fl+bQVTN1D
 HbFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0DeCi1iPHaXmI2vEISsFMkcGphhybfcw8IqvRF0Jfe1P03jA2KCwHslb3Y9FlTbjp9spQb/atW1xP@nongnu.org
X-Gm-Message-State: AOJu0YxrGbFIVLXv/zzE6neWmXeyVNI5PbxWOSVA1yFiUZbW/p0Ff156
 WujUpmz5N2Bp3pDZNxQ1CA0dN99AQdfMxcioTLytA0Gn2II+EUPf32JHn4PbxIw=
X-Gm-Gg: ASbGnctLUSsiPsS4kBs7JBkGTogG27jbrcmOFeTbcAIyWyrVadK+751yboCKu+bfZ4k
 vUZcvn/luKFtjTISAqSNTJNnV8siZOwQYIHXa8MTeNNcga1CmPdvqM8+AgsiK0qB/ie1TlUd6T8
 qN8XFDZGOS38QV8Wn74nddQnd2HIgwubA70RCJ9vB6O013SJslcsqwqvAsZclkZfw7K4quban1f
 xZ5UoLHwysbhCrUth5kRLD/89lFx2AAJth7+hW/OWOvGlH0ZhOr7lKb4qrnYhmpJxII1oBJnXuA
 Dx+41yoB7uxesSPoFa23TZeXGcb3jvUDGVn01qzieDkwFKp2bSqk19Iaob2PFfvXt7zxi1SGZiN
 jXu9tTJJFHp7IGmExqw==
X-Google-Smtp-Source: AGHT+IE3yyxpe0jPJ3qRbQ8sQncVJoqPMfMzGAEKdAUhFZ2QBQSMv8SPW9nHKBxVZ/Mh0gPEltesnQ==
X-Received: by 2002:a05:6000:381:b0:391:2d97:7d0e with SMTP id
 ffacd0b85a97d-39cba933717mr3970949f8f.42.1743864218543; 
 Sat, 05 Apr 2025 07:43:38 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301ba3c4sm7211841f8f.59.2025.04.05.07.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 07:43:37 -0700 (PDT)
Message-ID: <cdd3bafb-fd69-463f-856b-ad1c95ee6978@linaro.org>
Date: Sat, 5 Apr 2025 16:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 20/39] target/arm: Extract PSCI definitions
 to 'psci.h'
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-21-philmd@linaro.org>
 <09bd795d-e62d-44fb-b80a-374efee32034@linaro.org>
 <49ff72e2-24ac-41a8-8aee-f923d9b48cee@linaro.org>
 <04e14ec2-dbfc-4c92-b061-dd7108cd66f2@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <04e14ec2-dbfc-4c92-b061-dd7108cd66f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 5/4/25 03:03, Pierrick Bouvier wrote:
> On 4/4/25 14:54, Philippe Mathieu-Daudé wrote:
>> On 4/4/25 20:21, Pierrick Bouvier wrote:
>>> On 4/3/25 16:58, Philippe Mathieu-Daudé wrote:
>>>> Extract PSCI definitions (which are not target specific)
>>>> to the new "target/arm/psci.h", so code from hw/arm/ can
>>>> use them without having to include the target specific
>>>> "cpu.h" header.
>>>>
>>>
>>> Including cpu.h is not a problem to have common code (per architecture),
>>> so there is no need to do any change here.
>>
>> Again, this is an old patch from my heterogeneous PoC branch.
>> I'll remove from this series to not distract you.
>>
> 
> It's not distracting, but simply not needed.

Not needed for single-binary, but needed for heterogeneous emulation,
as the same HW might use distinct architectures.

> 
>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    include/hw/arm/boot.h      |  3 ++-
>>>>    target/arm/cpu.h           |  6 ------
>>>>    target/arm/psci.h          | 18 ++++++++++++++++++
>>>>    hw/arm/bananapi_m2u.c      |  1 +
>>>>    hw/arm/boot.c              |  1 +
>>>>    hw/arm/highbank.c          |  1 +
>>>>    hw/arm/imx8mp-evk.c        |  1 +
>>>>    hw/arm/mcimx6ul-evk.c      |  1 +
>>>>    hw/arm/mcimx7d-sabre.c     |  1 +
>>>>    hw/arm/orangepi.c          |  1 +
>>>>    hw/arm/sbsa-ref.c          |  1 +
>>>>    hw/arm/virt-acpi-build.c   |  1 +
>>>>    hw/arm/virt.c              |  1 +
>>>>    hw/arm/xlnx-versal-virt.c  |  1 +
>>>>    hw/arm/xlnx-zcu102.c       |  1 +
>>>>    hw/vmapple/vmapple.c       |  1 +
>>>>    target/arm/helper.c        |  1 +
>>>>    target/arm/hvf/hvf.c       |  1 +
>>>>    target/arm/tcg/op_helper.c |  1 +
>>>>    target/arm/tcg/psci.c      |  1 +
>>>>    20 files changed, 37 insertions(+), 7 deletions(-)
>>>>    create mode 100644 target/arm/psci.h
>>
> 


