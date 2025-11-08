Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85ECCCFA18
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 19:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHoFG-0007cd-A7; Sat, 08 Nov 2025 14:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHoFF-0007cS-10
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 14:05:05 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHoFD-00045r-6T
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 14:05:04 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63e16fbdd50so1586343d50.2
 for <qemu-devel@nongnu.org>; Sat, 08 Nov 2025 11:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762628701; x=1763233501; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7vPgp0MYvMFKvwgWmTKhFg1YdgjiSPc61zY1fuJkPxk=;
 b=rbsuOKFxkqGXu29+WMmFeepgXrrDja9IP/67h0mxL9hXlgGMdqPFc8UW9WV0DMLWup
 OmgB4rnjkQ3xWn10y7tyz+hhcuMOncutDkK3gi14NY8XzxU9TsQqTuFLYrjwFT+Hb3cy
 fcYT4z59HGNzcmiQ+jEwG8alNZzefZ3frtH9WGHqWh9yKbP5QbhMF3vQnxu6cngHdRJG
 jXaNH9kDP1JIxcGx9rQTqUcnnfI+TCYLF3/1eJfrgaUzr1t5zjwzn6J54Aen6Lyb6bS0
 Dwmi8hNBrL51bc6Zer0mRJPO3MLXXB5xXyvdc3nDAZWJUac6+NTY82umccJrBQPwkLwM
 6emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762628701; x=1763233501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vPgp0MYvMFKvwgWmTKhFg1YdgjiSPc61zY1fuJkPxk=;
 b=DMNlpkskG44uWJqb0KHJXKU3YcpnsbKqBrPd3f9HvtW51pDglfhdix8EBIrZIcdOsJ
 NGJrAibkv37cyx/ieV04iaEUyrGLyc4YrnVPStvLwgEYX06f/Cd+86ftCvneB1bUvZSz
 OqgFGmxbP5hViXPQam3RbacAJX8pVUwvz2hmiXxqtxN+YhI+pWg9+lCmmiTAFQibSUCo
 Ag+8va852GbVKyIinM1EMIcNowhjzwaj/A7Mks4HknV8YfefG1e+XYvLTmvf0j913ThV
 8iC27VwPG5q8Hv6Hd2VLvhXnmO2qSH5h+2dDoYXL5D50ozZ1d+PrFyJnd9Rpbl7LdTYD
 e44g==
X-Gm-Message-State: AOJu0YwyS70p/Y+G+XiVoruX49MxOreeUAg25CFM36P++GlNVIV98NW1
 PptqscqcULN9iDj/s5izCeuOfjgxT8xV54FyQr+cn1I3R+w6xGDJ/KIyl8tFnuJ/VZ5jh0t1g9z
 IOAHu3dogWOT73sskD0f7yWdkmpY4KblWxLmBILDvrg==
X-Gm-Gg: ASbGncssNe3eGfSIc9svRH37AY2Q8uqQm9TXQ9i0RK9u3wFeGjuE4abHBgjz/gSgHXI
 M9mabw4cDAl1Wxml+KN9a6bqNjZXvLptCOmjwyVLWFuryyp4FteV3eChqaxLiY31Vdj48RwodBw
 PaziKakIjVPgQBDZMHnUHqs7e7wqzXmQ+yAzkabfFa9+ZCfwMhnOyx7KmtBbULXkyw63u9Z08+V
 qfxk1WH2PN7Vg62tIDvFSz0+uBzzNxkaXXqSXMAzStVRC2hmppfRejlRGzwfhFcLM60u4zKLFHa
 wdtgVSg=
X-Google-Smtp-Source: AGHT+IFGqDjPmHY5eRsohYpdntfuUYuh1Qa9z33873v7g962jccfITqEVXGrE7RlgB8tWvudjM5Ic3QWVfWWcjQ6RXY=
X-Received: by 2002:a05:690e:4301:b0:63f:9b00:70cf with SMTP id
 956f58d0204a3-640d453a821mr2285387d50.16.1762628700969; Sat, 08 Nov 2025
 11:05:00 -0800 (PST)
MIME-Version: 1.0
References: <AM9PR04MB8487562AFE05FFEF901244E587C0A@AM9PR04MB8487.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB8487562AFE05FFEF901244E587C0A@AM9PR04MB8487.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Nov 2025 19:04:49 +0000
X-Gm-Features: AWmQ_bk1iPuQaXO49L0Tx4sqvkMMrcL7gIAwcCpAauBn_7MTxZwUdxUBzl6CFdI
Message-ID: <CAFEAcA8wF30KdS=hdr1RfpEcgBA5epXgRXrJ=HvtCr=p8__EGQ@mail.gmail.com>
Subject: Re: [PATCH] Add support for the NXP i.MX8MM EVK (Evaluation Kit) board
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Sat, 8 Nov 2025 at 12:27, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> From: Gaurav Sharma gaurav.sharma_7@nxp.com
>
> Date: Sat, 8 Nov 2025 17:12:56 +0530
>
> Subject: [PATCH] Add support for the NXP i.MX8MM EVK (Evaluation Kit) board
>
> including: - i.MX8MM SoC implementation with CPU, memory, and peripherals -
>
> Board-specific configuration and device tree - Clock Control Module (CCM) for
>
> i.MX8MM - Analog mixed-signal controller - Updated GPT timer support for
>
> i.MX8MM - Documentation for the new board
>
>
>
> Signed-off-by: Gaurav Sharma gaurav.sharma_7@nxp.com"
>
> ---
>
> MAINTAINERS                     |  12 +
>
> docs/system/arm/imx8mm-evk.rst  |  69 ++++
>
> hw/arm/Kconfig                  |  24 ++
>
> hw/arm/fsl-imx8mm.c             | 675 ++++++++++++++++++++++++++++++++
>
> hw/arm/imx8mm-evk.c             | 103 +++++
>
> hw/arm/meson.build              |   2 +
>
> hw/misc/Kconfig                 |   6 +
>
> hw/misc/imx8mm_analog.c         | 160 ++++++++
>
> hw/misc/imx8mm_ccm.c            | 175 +++++++++
>
> hw/misc/meson.build             |   3 +
>
> hw/timer/imx_gpt.c              |  28 ++
>
> include/hw/arm/fsl-imx8mm.h     | 242 ++++++++++++
>
> include/hw/misc/imx8mm_analog.h |  81 ++++
>
> include/hw/misc/imx8mm_ccm.h    |  30 ++
>
> include/hw/timer/imx_gpt.h      |   3 +
>
> 15 files changed, 1613 insertions(+)

Please can you split this up into a multi-patch patch series
where each patch is a self-contained reasonably sized change?
You can look through the git history for examples, but typically
adding each individual new device model should be in its own
patch, for example.

Also, it looks like you've sent this as something other than
a plain text email. You'll probably find git send-email will
produce better results than sending it from your normal mail
client.

You can find our guidance on how to send patches here:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html
(which includes some tips about setting up tooling to send
patch emails).

Thanks for including documentation with the new board model.
Another thing that we like these days for new boards is
a simple functional test under tests/functional/ which
exercises the board by doing a simple "run a guest image
and check it boots" test. You can find various examples
under there to use as a template.

thanks
-- PMM

