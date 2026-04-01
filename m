Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7563D35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7s6c-00062M-Pu; Wed, 01 Apr 2026 05:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7s6b-00061p-4s
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:43:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7s6Z-0008Ac-G0
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:43:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso65477625e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036598; x=1775641398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cuBwiUM39oOFyPXW9QKUmrD94Xs1RkDolFcLPjWhI24=;
 b=swrox1vQamE6ePXsqGbvLWF5jEE5oVjK3HEAvEGgF5So0NvtUV3xSAb98FgftHik1a
 vx5NIcf3z5iGjnGHKqj4i8YXBsiWSgunVvTjoU+8G4TEyCVC67gk8/hErY7cCvejJk1W
 WFHLFyFVlZZ37SpcmWBTTMQx5jh9NqMDp5zLvh/ijtE3Ug3naF8jiswNlAtsT4Pmwhku
 o+CbE/3frQLd23Qqgjes0aq5yV5rCFmby6PLcSb4Kob9KZtgDHUDYln017CVMth4n3J2
 ifJYZXZlK6tjNYLF+v2nP8ttJWt56nif8/eNjRJF1DhsoAsO1gpo8ZNbxx2hKDj30Tin
 TIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036598; x=1775641398;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cuBwiUM39oOFyPXW9QKUmrD94Xs1RkDolFcLPjWhI24=;
 b=VR4/OdX3W4iw1w4Hwx2+l2BCyJ/bO7ApHr3QeUczZzSUMiW4l8YDM1U1zuz61gssv1
 EVpIIiAYCUYzyCzZmWlt67KV/P+/Hxp1anyozhwMYK1duj0XEH+bHrnuMoBtcHGbP2dr
 QhNdPhvOPz5f7A0lHmirS5ucczc9Iq5X0i7hbuP2Ve2yKEu253beofpCnAZ+GZLu8qfi
 mxGPpRnArI+KmuArDwOdc/XjapckU2dxlk7Xm052yQTetk1jBMsjvuHEihlVqZvLt1e1
 DSLLXHR7G0k1LCzvKLCFWc7K4S21cBqQvtWfCNujPp1QoM0gJzvf1ES3IbM1pw3M5Onw
 xkrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvItmhbSjDL2vll4XdSMzGrKJ9UtuRCmJ5utTF7yip946vKqRT6r0L4IWIKXFC8nY4sRy0/zfnOsRF@nongnu.org
X-Gm-Message-State: AOJu0YwkJ85/Le768D5MIMV8HoTk2UgQio0GeCXR1Av4Fp+zW/c2CB2f
 wDYIaByWDyC6vsMWXJ3Un+er/k8RIg5yfpOnS1xKVOUmPbKFxqsyq4qJOFAPFMvJ5XIluWCuaG0
 Y0Q+xLb4=
X-Gm-Gg: ATEYQzwOfgC5I7zx2F2f34R1mSM+u3uuP6hANQ1ggXcdDNx9zQSt15db1CrBN720YqH
 N2CDk3Xy6DjTZ02Hppgbc+9ccxO0zj/IN2/4nXLUPPVRBwdYfEYKTWKmvKn4rJ3K+hZJw/ETt5X
 9Lt4bxJdPKx9R/K8qlrYBA7wuxqhGbFR6j/TiMa+BA14lx2+XtuJ+2eVMM0g0a82h/AewvA+Rl+
 mJp9YUiMpiNmXp++Fd53CyHwM/L6QHQHhaRIymPMTFT+zDFlrvX9QpjFy6El/V1Z3AHkMclRL6x
 ZwSMGCGX921BspzJLDVs7Rz7Eza5WuJDiD575hjFpUwtHevMyzKc6JRpTXsYD2ar4GDN0h+9GOg
 2BnO7U1ZHV37GsoW3StQpnHDwDTlm6UDqCT69MBduuvl/sJDjaugCaRcj7YrUAp5BZvTcMvJtZV
 jwXkYshQO2wJgfmDdzHhCwtJFKupAr7aDIrjiErkPo0lMDpssEUKYde1VO3mithVRBmg==
X-Received: by 2002:a05:600c:c107:b0:488:80b6:873a with SMTP id
 5b1f17b1804b1-4888359526cmr32196115e9.21.1775036597777; 
 Wed, 01 Apr 2026 02:43:17 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c536a7fsm90697795e9.1.2026.04.01.02.43.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:43:16 -0700 (PDT)
Message-ID: <60bb7524-a0c9-44bd-baa4-a443885b92f9@linaro.org>
Date: Wed, 1 Apr 2026 11:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 60/60] contrib/qemu-vnc: add standalone VNC server over
 D-Bus
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-60-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-60-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 17/3/26 09:51, Marc-André Lureau wrote:
> Add a standalone VNC server binary that connects to a running QEMU
> instance via the D-Bus display interface (org.qemu.Display1, via the bus
> or directly p2p). This allows serving a VNC display without compiling
> VNC support directly into the QEMU system emulator, and enables running
> the VNC server as a separate process with independent lifecycle and
> privilege domain.
> 
> Built only when both VNC and D-Bus display support are enabled.
> If we wanted to have qemu -vnc disabled, and qemu-vnc built, we would
> need to split CONFIG_VNC. This is left as a future exercise.
> 
> I left out for now:
>   - sasl & tls authz
>   - some runtime functionalities (better done by restarting)
>   - a few legacy options
>   - Windows support
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   MAINTAINERS                    |   5 +
>   docs/conf.py                   |   3 +
>   docs/interop/dbus-display.rst  |   2 +
>   docs/interop/dbus-vnc.rst      |  26 ++
>   docs/interop/index.rst         |   1 +
>   docs/meson.build               |   1 +
>   docs/tools/index.rst           |   1 +
>   docs/tools/qemu-vnc.rst        | 199 +++++++++++
>   meson.build                    |  17 +
>   contrib/qemu-vnc/qemu-vnc.h    |  46 +++
>   contrib/qemu-vnc/trace.h       |   4 +
>   contrib/qemu-vnc/audio.c       | 307 +++++++++++++++++
>   contrib/qemu-vnc/chardev.c     | 127 +++++++
>   contrib/qemu-vnc/clipboard.c   | 378 +++++++++++++++++++++
>   contrib/qemu-vnc/console.c     | 168 ++++++++++
>   contrib/qemu-vnc/dbus.c        | 439 ++++++++++++++++++++++++
>   contrib/qemu-vnc/display.c     | 456 +++++++++++++++++++++++++
>   contrib/qemu-vnc/input.c       | 239 ++++++++++++++
>   contrib/qemu-vnc/qemu-vnc.c    | 450 +++++++++++++++++++++++++
>   contrib/qemu-vnc/stubs.c       |  66 ++++
>   contrib/qemu-vnc/utils.c       |  59 ++++
>   tests/qtest/dbus-vnc-test.c    | 733 +++++++++++++++++++++++++++++++++++++++++
>   contrib/qemu-vnc/meson.build   |  26 ++
>   contrib/qemu-vnc/qemu-vnc1.xml | 174 ++++++++++
>   contrib/qemu-vnc/trace-events  |  20 ++
>   meson_options.txt              |   2 +
>   scripts/meson-buildoptions.sh  |   3 +
>   tests/dbus-daemon.sh           |  14 +-
>   tests/qtest/meson.build        |   8 +
>   29 files changed, 3971 insertions(+), 3 deletions(-)

This patch deserves its own series, isn't it?

