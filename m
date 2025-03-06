Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28464C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4j6-0002rr-5X; Thu, 06 Mar 2025 01:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq4j4-0002rU-RQ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:28:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq4j2-0004lu-A8
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:28:58 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso1140225e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741242533; x=1741847333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NPaT5zSTAAYjqNedo4wI+0l8RQ/7I68tSJCf7Y96kvw=;
 b=y/VNbIXP6VUzox1lqO3eeMh0oMbY337qOLkLUddAsCvYkdta5pBLwNC2Z5n01sxAFC
 ZUqh6WbWEgTfPJcu3JpZFlKDny0WGrUpUoyU3CEja+a5oKfbA62Ec0/CmmnkRol6LQ9c
 D3DzXhNKzxSnaohbuuHJqFTJLE1ul2QYHk5S41w5Ep5sNZFvZHH8vy46rMPrr71dNCmt
 pBZR6CFG8ytMyNbdLACTi5EjFgx4+HZno8ACjXkiIss0L/9Pd3XW+f3r4NrAedk06kpJ
 N0BXLKkUxYFL1vmoh6229CY2Xqpv8pVkUKrQE4CeKU0/VJouavZ8lA9RxhxP7xndL7J2
 60JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741242533; x=1741847333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NPaT5zSTAAYjqNedo4wI+0l8RQ/7I68tSJCf7Y96kvw=;
 b=sBTygxt9szNShbvVNhLXLWpcxG04oOBR+h2vX4KJ5Gf5eeKmIrfEcFpNm9/DfXZ6lj
 rZbcC5kYuV0sXT7fc97Vp8VNFwP6LToyOhMW1kneWT5log4Q7a646VtVeiA66g4RX3uZ
 I2OvMHquoL0Gk7Kqqwgngn2PFFzbLINGyn/BbTt0rDlcLc9BG1LMYt/hpDoX0j2j42ts
 3chxkeSEOh31Bs+65c/q1AUI75RX1tZDeRdUUNN7a4h6uSwxYdApqubyljBN2GVDCGq+
 vbf/TB9aDkKjdYrytBlbofEJFd4WJrTYAOqeGcmm3OZcPJ5hlctvP992PnAmdOShbYxm
 32nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtbFq/XVveQL0nWX3zgDewD6Odtu+zkblEkJ0CxnsReZAtl13FMCktolpyD8TpR0cvIcGnyJtx1mZf@nongnu.org
X-Gm-Message-State: AOJu0Yxs+5YUt7TRVPqeT5hvU9hnTzh5Ovyae9apMKQQmjxI2vHMOVai
 Ph+n8ePl+I+wpf8s7Ip/qvepbsjmjBNtm1NKuyCQQLu/mYQHJQu9YjpVQvjRfSQ=
X-Gm-Gg: ASbGncuuBC2Y1xYKnD8GTINoGMvR/1qOMgYjf6KvDekEhGkWfvwHDG/MhM9xrNWspQa
 XPrHT7FXnK2c1ELuYW8ZcyjOex823jPqYobauHnmmD9cbXSNaFIvCy04hWX6Qz3dCr+9Fek4ouI
 7/KlKpoUdkBPJd+tT++jPXEJqqhQbOp/OkLfc4sNDEKWuW0chr0wdU42P5AcTnbohIf1EBQ24+S
 ObF0uGj47b9BuM2KL1XwSgIX81GYBy0S/pII2o38/2yNg6Yxd1xOvrXYnp3fJgzILX9kpREu0Yi
 tK2jFWAWKcYyTglu/DIwKr66jf7+DyWk1tA/3Q/Rz/PuOZzEeRZ3L+ssBY3yVTEhLe8Fxbytqtq
 R2vyu4kpwr2JA
X-Google-Smtp-Source: AGHT+IFathu/HkfIZB1T0j0/2NKmYbesh2TVXHUiXZ8MTvkZbhVur0otdkevSmyxbIGwfGTawfxepA==
X-Received: by 2002:a05:600c:3149:b0:439:9698:d703 with SMTP id
 5b1f17b1804b1-43bd29bb5c5mr41942385e9.23.1741242533487; 
 Wed, 05 Mar 2025 22:28:53 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c102db1sm928135f8f.95.2025.03.05.22.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 22:28:53 -0800 (PST)
Message-ID: <5eabec82-3480-492b-82c3-978942bbd7b3@linaro.org>
Date: Thu, 6 Mar 2025 07:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v5 09/11] hw/arm: introduce xenpvh machine
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, vikram.garhwal@amd.com,
 Stefano Stabellini <stefano.stabellini@amd.com>, Edgar.Iglesias@amd.com
References: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
 <20230615235254.1366267-9-sstabellini@kernel.org>
 <a0982117-5602-49ee-9e0c-ef2f7c716e7b@linaro.org>
 <alpine.DEB.2.22.394.2503051519550.1303386@ubuntu-linux-20-04-desktop>
 <CAJy5ezrx8mYWfE1Ty16g-Do9-itWN2qn36pqM9u0mNDw5SbaLw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJy5ezrx8mYWfE1Ty16g-Do9-itWN2qn36pqM9u0mNDw5SbaLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 6/3/25 01:13, Edgar E. Iglesias wrote:
> 
> On Wed, Mar 5, 2025 at 5:22 PM Stefano Stabellini 
> <sstabellini@kernel.org <mailto:sstabellini@kernel.org>> wrote:
> 
>     +Edgar
> 
>     On Wed, 5 Mar 2025, Philippe Mathieu-Daudé wrote:
>      > On 16/6/23 01:52, Stefano Stabellini wrote:
>      > > From: Vikram Garhwal <vikram.garhwal@amd.com
>     <mailto:vikram.garhwal@amd.com>>
>      > >
>      > > Add a new machine xenpvh which creates a IOREQ server to
>     register/connect
>      > > with
>      > > Xen Hypervisor.
>      > >
>      > > Optional: When CONFIG_TPM is enabled, it also creates a tpm-
>     tis-device, adds
>      > > a
>      > > TPM emulator and connects to swtpm running on host machine via
>     chardev
>      > > socket
>      > > and support TPM functionalities for a guest domain.
>      > >
>      > > Extra command line for aarch64 xenpvh QEMU to connect to swtpm:
>      > >      -chardev socket,id=chrtpm,path=/tmp/myvtpm2/swtpm-sock \
>      > >      -tpmdev emulator,id=tpm0,chardev=chrtpm \
>      > >      -machine tpm-base-addr=0x0c000000 \
>      > >
>      > > swtpm implements a TPM software emulator(TPM 1.2 & TPM 2) built
>     on libtpms
>      > > and
>      > > provides access to TPM functionality over socket, chardev and CUSE
>      > > interface.
>      > > Github repo: https://github.com/stefanberger/swtpm <https://
>     github.com/stefanberger/swtpm>
>      > > Example for starting swtpm on host machine:
>      > >      mkdir /tmp/vtpm2
>      > >      swtpm socket --tpmstate dir=/tmp/vtpm2 \
>      > >      --ctrl type=unixio,path=/tmp/vtpm2/swtpm-sock &
>      > >
>      > > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com
>     <mailto:vikram.garhwal@amd.com>>
>      > > Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com
>     <mailto:stefano.stabellini@amd.com>>
>      > > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org
>     <mailto:sstabellini@kernel.org>>
>      > > ---
>      > >   docs/system/arm/xenpvh.rst    |  34 +++++++
>      > >   docs/system/target-arm.rst    |   1 +
>      > >   hw/arm/meson.build            |   2 +
>      > >   hw/arm/xen_arm.c              | 181 +++++++++++++++++++++++++
>     +++++++++
>      > >   include/hw/arm/xen_arch_hvm.h |   9 ++
>      > >   include/hw/xen/arch_hvm.h     |   2 +
>      > >   6 files changed, 229 insertions(+)
>      > >   create mode 100644 docs/system/arm/xenpvh.rst
>      > >   create mode 100644 hw/arm/xen_arm.c
>      > >   create mode 100644 include/hw/arm/xen_arch_hvm.h
>      >
>      >
>      > > diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
>      > > index 26674648d8..c7c515220d 100644
>      > > --- a/include/hw/xen/arch_hvm.h
>      > > +++ b/include/hw/xen/arch_hvm.h
>      > > @@ -1,3 +1,5 @@
>      > >   #if defined(TARGET_I386) || defined(TARGET_X86_64)
>      > >   #include "hw/i386/xen_arch_hvm.h"
>      > > +#elif defined(TARGET_ARM) || defined(TARGET_ARM_64)
>      >
>      > I suppose this is a typo and you meant TARGET_AARCH64 :)
>      > Luckily TARGET_AARCH64 defines TARGET_ARM.
> 
>     Hi Philippe, it looks like this is an older patch.
> 
>     Edgar, is this patch still valid?
> 
> 
> Hi,
> 
> Yes, I think Phil is right, this works by luck and should have been 
> TARGET_AARCH64.
> Phil, will you send a patch?

On the list:
https://lore.kernel.org/qemu-devel/20250305153929.43687-2-philmd@linaro.org/

But IIUC since there is no vCPU emulated in HVM I wonder why the
32/64-bit distinction matters here.

