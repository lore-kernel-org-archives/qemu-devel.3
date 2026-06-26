Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F39BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6tt-0000mc-J3; Fri, 26 Jun 2026 09:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6tn-0000m1-NU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:47:15 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6tl-0002oP-VU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:47:15 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-664a10cd4a4so679142d50.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782481633; cv=none;
 d=google.com; s=arc-20260327;
 b=aUWW1o34DZLO2Zub4RKOddB8lO0TkITBzwP5F/7PQ1ywdB/SJMbKDjz0lqsI+Ew/tR
 m5+fALuB+LJoNQBCTjNecitF5+pORDJRCtSUZc5pQl8HnaiDjkJ/vRJNtzE3mKMizOW3
 QF29NZ5fPRz+1zatLooCXroIxA5RT++XzVWzq1ouU0sEC0rO4Uf/4GTmyTzkaK/CiVl2
 FaqSWBwUDBiV6Z9BIIWWp6ZvTLX9XMrhrEXKviLLfQw0mKvK/ww3n1RHez0UJqCLYf4i
 CN9ugv/30bZVaE6mSYO7D8utX+Ds6BFfdxdr9qvpI2LL07zVvBzLubfySFVFwAjtFBPS
 awtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+/E5LwBojcQniSFq8lq9on4QNig3ihY67w2LaHx0lfE=;
 fh=YoLpMh5YadSd1SUFRuzOwiR+EAmVcwfqZdaYDd98lIk=;
 b=caytIAmzPzfJxiyRYV/s9l/5WdLAtK9qml8bXlIOBiRZLj95T1qnQnhOCO66da5+u3
 l+ca8AS3gmG5O3SmnDVd3qmZPORSpQZZwQWM6ijjXIRJpi7DiaSzXd/WKlg9iovzyfnY
 EIk8rjyfMEWBAjqi28iZrXzZDhHz1VzxSLNLSqRgVfBBJFI+xqFhR5xNA8d7UnUV8gWj
 3ERP59z7dmn9bf5HKccXnn7mhMaAHy3LpwS8EGMtPuTEgZIa7XcECns1wBbS6Z9ijT2X
 JFn8KdLtWO+XhsoLluouVWvE8dWieYs4i4VRQ/b0eYe+VvXChqxpQzeIf4nAQX7FdD+9
 eUog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782481633; x=1783086433; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/E5LwBojcQniSFq8lq9on4QNig3ihY67w2LaHx0lfE=;
 b=k++3jmj3QBPTDX22X/MXwdQ16moJ9fhX3NDZ2cVI8vh/9YygGBQyVHnyI1VyvrrPxa
 JzRGBhg6T0jeiotBNVUdbmIpvHbYMN7qo6BaDuPH5cNob1T+Cd0wsm20ZQpBUwQ/xjmd
 SQUukTddBuYE2IUvPEtcuYKAQAQQkeR4j/0csE6Kojjbn8e5cs3p80p2tcd7srdlJ0ad
 OqXMktnuN3ndPebxDoWunIiyzQxPWdum5qupSmQQVxfs8v+82z833j+7RcWvEYW7Yf8X
 165H+Oxvk4o5C1DCgvCqlz+H2b4Yvc2ExU8Yjz3vCQJeTIvVoKmoRsp20iELwVre1Bma
 NO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782481633; x=1783086433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+/E5LwBojcQniSFq8lq9on4QNig3ihY67w2LaHx0lfE=;
 b=nGqUOkGioPS+XLrXAv7ycFa6ezKholDUjNigMiyywdUgI9zsfycYd1cEFMdHmx+6uE
 yjWlFNVtrbg0G16ZXMPWghTYKzrLTtf7zpVrH81zClEW8YNAlKHZkXGoWObUwaNWTxKT
 kcXX7Mixf0W30dyrUVPUBA9bqR3pANtMPp7ay299jam+WDg3W9sOcYOI688PiMsgRmit
 sCsg4E+y+8VOIR0s1EpuoKQs8ch4DKFot1Mmlqz3KNEqqgSqLiK/EpjQLCvyPzarJZm7
 YnctkrsQ9uiA22Msii1gltZPyiKPAok8kUdjgK/Guk74t4DE5PmeH72Kr7kKtwFcaUHl
 ZRzA==
X-Gm-Message-State: AOJu0Yw2jng7SPPiwdERmXGpFH3rdez1gu6/fXHtasLYQJPJyfj3Viml
 x8ycBj5+HJ5Iot2KM5/VGPfpPZ1KV86VWMiyP0glEap3vi9ffBBaWw8Vg1A9pBOCsKGTYl5inc5
 Qq8pfQ1L/KMzJJQ8RRuuNPlfv17l5rD9WlrEwagnV/g==
X-Gm-Gg: AfdE7cmDLk6kwtx14iDOyvEAt/rydpBvqBosPr5T8Cb01FJ8WsvoGL/jdNq68KvbdEX
 y/+lXZAbyzTrAmb/e0y1El6o52o/L0eG1sLwoA93Aa0PLWouS3v7T1CFWjL2doAHgm2OWShcNke
 hP8geuKm7GsgmU0lDRVZvfXsxT/AcXOWkAoLAGkqJNMU+jUBQPimG38mcPn+YNgROHOjdGmAfm7
 MGArCuHAaHwlYyhRYjjOOmgEW1Q/RSud7+UDgC+wLazRNpNl6FKnpIAbM0wLX2Z4ktncB7nKjGM
 c2eYf1kne7zI/QhpmK4Xjm8JH4tRvqvplVCQp47RC06hzFqi8ikbWxZ5
X-Received: by 2002:a53:ac9c:0:b0:65e:5110:a584 with SMTP id
 956f58d0204a3-66487ee3567mr5329785d50.52.1782481632612; Fri, 26 Jun 2026
 06:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260626094237.3788189-1-alex.bennee@linaro.org>
In-Reply-To: <20260626094237.3788189-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 14:47:00 +0100
X-Gm-Features: AVVi8CfhGgknN-0l2gjz_Ti9_n5kp0tigb0njnxIpxWUTvOoMr1Z16VS1hwPRZI
Message-ID: <CAFEAcA-LvWsadHomHBNzjUatsiU1sDg85V4gTCDTpoDJE+EXuw@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/system: rewrite gdb breakpoint and watchpoint
 explanation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 26 Jun 2026 at 10:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> There are a couple of gotchas we should point out:
>
>   - software breakpoints can fail on early boot
>   - TCG treats all breakpoints as "hardware" breakpoints
>
> Rewrite the text to explain this more clearly and call out the gotchas
> in a Note! section.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3596
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/system/gdb.rst | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
> index d50470b135e..f7878ca8606 100644
> --- a/docs/system/gdb.rst
> +++ b/docs/system/gdb.rst
> @@ -49,15 +49,32 @@ Here are some useful tips in order to use gdb on syst=
em code:
>  Breakpoint and Watchpoint support
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -While GDB can always fall back to inserting breakpoints into memory
> -(if writable) other features are very much dependent on support of the
> -accelerator. For TCG system emulation we advertise an infinite number
> -of hardware assisted breakpoints and watchpoints. For other
> -accelerators it will depend on if support has been added (see
> -supports_guest_debug and related hooks in AccelOpsClass).
> -
> -As TCG cannot track all memory accesses in user-mode there is no
> -support for watchpoints.
> +GDB supports two types of breakpoint - software and hardware. Software
> +breakpoints are simply implemented by writing the architecture's
> +breakpoint instruction into memory. Hardware breakpoints are less
> +invasive but rely on the support from the architecture which will
> +usually only be able to track a limited number of breakpoints at once.
> +Each accelerator will also need to specifically support enabling these
> +hardware features.
> +
> +.. note::
> +
> +  Software breakpoints may fail if the memory is not yet accessible,

"or the guest code is not yet at that address, "

> +  for example during early kernel boot before the MMU is enabled or

We should say "Linux kernel" here.

> +  before the kernel has relocated itself. In such cases, prefer

s/prefer/you should use/

> +  hardware-assisted breakpoints (e.g., ``hbreak`` in GDB) which do not
> +  require memory access.




 Due to the TCG accelerators complete control
> +  of the system all breakpoints are treated as hardware breakpoints
> +  and the number of them available is for all intents and purposes
> +  infinite.

I think this bit about TCG should be a separate "note::".

Maybe rephrase it something like:

If you are using the TCG accelerator, there is no limit on the
number of hardware breakpoints, and QEMU handles requests for
both software and hardware breakpoints identically, as if they
were hardware breakpoints.

?

> +
> +Watchpoints allow the debugger to watch for reads and writes to
> +various memory locations. The number of watchpoints available will be
> +a factor of the architecture and support of the accelerator. For the
> +TCG accelerator running system emulation we can support as many
> +watchpoints as memory allows. As TCG cannot track all memory accesses
> +in user-mode there is no support for watchpoints in that mode.
> +


-- PMM

