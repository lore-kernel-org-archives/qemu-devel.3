Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CDCE6FE22
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smaep-0001Vq-Hg; Fri, 06 Sep 2024 11:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smaeo-0001SV-KV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:13:54 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smaem-0003zn-Tf
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:13:54 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c25554ec1eso2357447a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725635631; x=1726240431; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jMNxfUcWPto3gHqfRBWq1thLRFYKqIOeb27j8OpohW8=;
 b=QNeCODmKZhfFgHmHB0eH16d9eRF5UI6jia62d5mj6Yet9rsk9s+EmJayFSAGoOKpLD
 eIOlplJ3TNut26Lx1aMi8eVOa+7nZ36NfRQJbIq6S574FBqVZtqxYB7Vd3U/fI+aXHrU
 I80TF6YUJIHPFMer4Lb4DLrsPhaHVBEw3mWguxA5lwbPn2phRI8shR1bdCMX/OklHsvN
 8Y6dLZ6tUafwAuxSO6x3+5gG0C48WIjsjUBg2TDnFHm/E8hyRfsexJWLwF71AUUDmjNB
 e/asx6q7oBYYrlN8UHU20jcvjKg7ISJ0w5ElXRm3/X+IaKYRm9jC6JjFsUh0V8FdTjB0
 e6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725635631; x=1726240431;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jMNxfUcWPto3gHqfRBWq1thLRFYKqIOeb27j8OpohW8=;
 b=HWzoictqXbQ15i/FvcLf7RrBnEwm1bM04cMKgI4iAC5WWUr0AvdpzKTMjylgaiLrOc
 fT6hnxXlG3gPHPTKx7cDANHJI3QOaism/n93VhqoaZfeg8PNjkSaMHKips3LdVMb/NXq
 oarg9mFOsnsdCT3uTr3nwNbwtvXD5rrMTLrBbBpZAXvWyfgd7gpPg7BnkePm0cgHwrf0
 F2DKOjss57dL25M2FNk60mt/+G/DG12I5qfwxMCzMC/nRlXVrTYVo9mNizVCOSIdPpVL
 SfkdfGYAMAaW8h60yIdMbAt38L6opiMcY7M2G9AQnKyJTcU90iyTOryh6VXYmj4Qd0WH
 Sm1A==
X-Gm-Message-State: AOJu0Yy50a7b1sN2R8yn9/2Tl955qYwFhBO3MtwYKSA0a1gVArcb6sRA
 dRAK6yBorGrvitF+gTG73/xjWYs5VU/Mkl+iMYq2K+Y0rOqFkkKfNptGAzGE5VUpLxGW6M/RoC0
 x+JyMl/A44FcWWrgR5Z4y2gLMs1ZDbWszk6uafdWd5r3o7cLo
X-Google-Smtp-Source: AGHT+IF+Lwz38lv7Czqwav9YoZQERaoviqN2qMQQcnCW8tPW8xloO9sV1YrrjYciRwcP8QrXunrubuv59PnkqdTn0Ck=
X-Received: by 2002:a05:6402:278d:b0:5c2:e888:4cd3 with SMTP id
 4fb4d7f45d1cf-5c2e8884e31mr5984002a12.35.1725635631077; Fri, 06 Sep 2024
 08:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240819144303.37852-1-peter.maydell@linaro.org>
In-Reply-To: <20240819144303.37852-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 16:13:40 +0100
Message-ID: <CAFEAcA8jCC=gkwc=dJxu8yhpM7=udGGf8dMDp12h0vwE1PuX1Q@mail.gmail.com>
Subject: Re: [PATCH] docs/system/cpu-hotplug: Update example's
 socket-id/core-id
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Aug 2024 at 15:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> At some point the way we allocate socket-id and core-id to CPUs
> by default changed; update the example of how to do CPU hotplug
> and unplug so the example commands work again. The differences
> in the sample input and output are:
>  * the second CPU is now socket-id=0 core-id=1,
>    not socket-id=1 core-id=0
>  * the order of fields from the qmp_shell is different (it seems
>    to now always be in alphabetical order)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I noticed this while I was playing around with vcpu hotplug trying to
> demonstrate a memory leak I want to fix...

Ping for review on this one, please?

thanks
-- PMM


>
>  docs/system/cpu-hotplug.rst | 54 ++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
>
> diff --git a/docs/system/cpu-hotplug.rst b/docs/system/cpu-hotplug.rst
> index 015ce2b6ec3..443ff226b90 100644
> --- a/docs/system/cpu-hotplug.rst
> +++ b/docs/system/cpu-hotplug.rst
> @@ -33,23 +33,23 @@ vCPU hotplug
>        {
>            "return": [
>                {
> -                  "type": "IvyBridge-IBRS-x86_64-cpu",
> -                  "vcpus-count": 1,
>                    "props": {
> -                      "socket-id": 1,
> -                      "core-id": 0,
> +                      "core-id": 1,
> +                      "socket-id": 0,
>                        "thread-id": 0
> -                  }
> +                  },
> +                  "type": "IvyBridge-IBRS-x86_64-cpu",
> +                  "vcpus-count": 1
>                },
>                {
> +                  "props": {
> +                      "core-id": 0,
> +                      "socket-id": 0,
> +                      "thread-id": 0
> +                  },
>                    "qom-path": "/machine/unattached/device[0]",
>                    "type": "IvyBridge-IBRS-x86_64-cpu",
> -                  "vcpus-count": 1,
> -                  "props": {
> -                      "socket-id": 0,
> -                      "core-id": 0,
> -                      "thread-id": 0
> -                  }
> +                  "vcpus-count": 1
>                }
>            ]
>        }
> @@ -58,18 +58,18 @@ vCPU hotplug
>  (4) The ``query-hotpluggable-cpus`` command returns an object for CPUs
>      that are present (containing a "qom-path" member) or which may be
>      hot-plugged (no "qom-path" member).  From its output in step (3), we
> -    can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0,
> -    while hot-plugging a CPU into socket 1 requires passing the listed
> +    can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0 core 0,
> +    while hot-plugging a CPU into socket 0 core 1 requires passing the listed
>      properties to QMP ``device_add``::
>
>        (QEMU) device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=1 core-id=0 thread-id=0
>        {
>            "execute": "device_add",
>            "arguments": {
> -              "socket-id": 1,
> +              "core-id": 1,
>                "driver": "IvyBridge-IBRS-x86_64-cpu",
>                "id": "cpu-2",
> -              "core-id": 0,
> +              "socket-id": 0,
>                "thread-id": 0
>            }
>        }
> @@ -83,34 +83,32 @@ vCPU hotplug
>
>        (QEMU) query-cpus-fast
>        {
> -          "execute": "query-cpus-fast",
>            "arguments": {}
> +          "execute": "query-cpus-fast",
>        }
>        {
>            "return": [
>                {
> -                  "qom-path": "/machine/unattached/device[0]",
> -                  "target": "x86_64",
> -                  "thread-id": 11534,
>                    "cpu-index": 0,
>                    "props": {
> -                      "socket-id": 0,
>                        "core-id": 0,
> +                      "socket-id": 0,
>                        "thread-id": 0
>                    },
> -                  "arch": "x86"
> +                  "qom-path": "/machine/unattached/device[0]",
> +                  "target": "x86_64",
> +                  "thread-id": 28957
>                },
>                {
> -                  "qom-path": "/machine/peripheral/cpu-2",
> -                  "target": "x86_64",
> -                  "thread-id": 12106,
>                    "cpu-index": 1,
>                    "props": {
> -                      "socket-id": 1,
> -                      "core-id": 0,
> +                      "core-id": 1,
> +                      "socket-id": 0,
>                        "thread-id": 0
>                    },
> -                  "arch": "x86"
> +                  "qom-path": "/machine/peripheral/cpu-2",
> +                  "target": "x86_64",
> +                  "thread-id": 29095
>                }
>            ]
>        }
> @@ -123,10 +121,10 @@ From the 'qmp-shell', invoke the QMP ``device_del`` command::
>
>        (QEMU) device_del id=cpu-2
>        {
> -          "execute": "device_del",
>            "arguments": {
>                "id": "cpu-2"
>            }
> +          "execute": "device_del",
>        }
>        {
>            "return": {}
> --
> 2.34.1
>

