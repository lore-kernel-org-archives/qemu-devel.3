Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790A8C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpnC2-0005Qx-R1; Wed, 05 Mar 2025 06:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpnBX-0005Kt-P1
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:45:18 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpnBW-0001Nw-1A
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:45:11 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-390ec7c2d40so4938023f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 03:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741175107; x=1741779907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTggNXUww+YWPwGoUMFtXQUJkNqFzaaGF4Xq6al+Z3s=;
 b=b+P7GEw9FW7MzexRbZ6AWSXbKEi6hkfpit3562rQHo0+A3/Z7nMouULFwTr9NrIgpL
 8YiX9tQI2Sw9++tWGc64zpemsy+bFIhdiiwm8JrXtGDUZUmUsAFRLG7rimkH8iaQuahM
 R+Q2xIWoXsF0qQBqsQOLS5c0FpyzThH88P1fkV97CGHMDX6c9jEKHPNVGP+cgY5Y1cx/
 DTVzTUD3Zx9ud4ZNf17ihUCV53FT06Nn9B94WjX85EP5HSxgGjofMshwle6mH8dHFUWk
 WxmaXTocD0jabnpndhD6j66MxSOsQ8WfsG6g9f2REkozhDk015l5nGk3PUMz9RxcyVfd
 QX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741175107; x=1741779907;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UTggNXUww+YWPwGoUMFtXQUJkNqFzaaGF4Xq6al+Z3s=;
 b=N7TDcPwQ97iXObpFwKiSkGP2jovG3wGn68JgtE4hY+zCrh4GWAxkoSnutUS4roCUlO
 Bf6OSrqanqckZlFBu6g1mkBBmhxkXARRTucl8W3H9ruhrr9qnJD9eiFa5QnDwVHrto5o
 cfc8+y8RH08kQKUhsWzK1tznOCPs93/iCYtomjYO91TsLRHhXZFurZER8E0NbPLzfrDq
 yU87+D8iHV2GvNjDPwAvzmjrZf6XWdDPqkR6spH7d5zHPgi2dFd/tlRhhpqv/hu2CCQx
 KcbJ1ccrTTvOw2mDeZ9dLFj+v9ibtihTUGaAh9L/n6K6xZ39gdYRtTboe/CHf5lAUCqt
 5Gjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfRJ7yMr45p62q2WFTCsmzNrjE36QwQK1VIGLdTean3b2aBj0mMulQEHc0xPzyhOYSsWQfM8AVsUek@nongnu.org
X-Gm-Message-State: AOJu0YwF/n8IBg9fn4dkWPRML22UB8wwvQQWcftGtMpfLICl+dzM21QE
 Wd/9e0obNsk8Pyo6iiCfIJVA2B8HzC7e98h0f/nEtVguYUb47LagRSTJ+erYjLo=
X-Gm-Gg: ASbGncvIs9wNIKniOU7g9whJzhLW6u6KHJPF7M/pekBPTog/BXIQvIOyflnO6UjOOXC
 fbH0WxlliBIhQOS5+Uw+pzCTwLJHyVMbH9+vNAgTHJDgHM75VTpfNFBJbeVlLxkGgWT1HFbq+cB
 LA1yVEuCAQ1teQLi02Bi6PSVGPKHx42liccFhokTzys31hjOrajYyNSsFjcHGcO3gWuXsmYV0x9
 jgC4zBVf1aiGxIHe/ItYaRUeNu3YDFXaxrIDIqTitsx0XwnwOHiW1AusQpQ2lsHEyykRV8RMfEB
 63qzHDa7vecLGmb57+yrV1GtXxtZP1MGLe7NyY1IkwW0qDTIh82l1P7Gh+ojKa3tBUnmlJirIYV
 ub0lrCL1bfWwY
X-Google-Smtp-Source: AGHT+IFi3JoerRyGFg+LhxTb7W6DySL2DSTk4nQPyHgzSdr+ZQvAyEMjflQoSLoAdAB06XfwoQGsbg==
X-Received: by 2002:a5d:5f45:0:b0:390:e9ea:59b with SMTP id
 ffacd0b85a97d-3911f73589emr2097976f8f.18.1741175106890; 
 Wed, 05 Mar 2025 03:45:06 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6ccdsm20786072f8f.46.2025.03.05.03.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 03:45:06 -0800 (PST)
Message-ID: <66093554-5d13-44fb-8c80-3c042f0c12c4@linaro.org>
Date: Wed, 5 Mar 2025 12:45:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-platform: Deprecate all forms of vfio-platform
 devices
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 peter.maydell@linaro.org, clg@redhat.com
Cc: zhenzhong.duan@intel.com, will@kernel.org, maz@kernel.org
References: <20250305105800.949153-1-eric.auger@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250305105800.949153-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Eric,

On 5/3/25 11:58, Eric Auger wrote:
> As an outcome of KVM forum 2024 "vfio-platform: live and let die?"
> talk, let's deprecate vfio-platform devices.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   docs/about/deprecated.rst | 25 +++++++++++++++++++++++++
>   hw/vfio/amd-xgbe.c        |  2 ++
>   hw/vfio/calxeda-xgmac.c   |  2 ++
>   hw/vfio/platform.c        |  1 +
>   4 files changed, 30 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index abadf8de27..d11a7004df 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -434,6 +434,31 @@ Stream ``reconnect`` (since 9.2)
>   The ``reconnect`` option only allows specifiying second granularity timeouts,
>   which is not enough for all types of use cases, use ``reconnect-ms`` instead.
>   
> +VFIO device options
> +''''''''''''''''''
> +
> +``-device vfio-calxeda-xgmac`` (since v2.4)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

"since" in this file means "since when the option is deprecated",
so it should be "since 10.0".

> +The vfio-calxeda-xgmac device allows to assign a host Calxeda Highbank
> +10Gb XGMAC Ethernet controller device ("calxeda,hb-xgmac" compatibility
> +string) to a guest. Calxeda HW has been ewasted now and there is no point
> +keeping that device.
> +
> +``-device vfio-amd-xgbe`` (since v2.6)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ditto.

> +The vfio-amd-xgbe devices allows to assign a host AMD 10GbE controller
> +to a guest ("amd,xgbe-seattle-v1a" compatibility string). AMD "Seattle"
> +is not supported anymore and there is no point keeping that device.
> +
> +``-device vfio-platform`` (since v3.1)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ditto.

> +The vfio-platform device allows to assign a host platform device
> +to a guest in a generic manner. Integrating a new device into
> +the vfio-platform infrastructure requires some adaptation at
> +both kernel and qemu level. No such attempt has been done for years
> +and the conclusion is that vfio-platform has not got any traction.
> +PCIe passthrough shall be the mainline solution.


