Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952BEC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jeZ-00019b-VI; Wed, 02 Sep 2026 08:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1jeY-00016s-6D
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:01:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1jeV-0006po-Qd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:01:17 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so1721225a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788350474; x=1788955274; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=etxuxkqAPn48hft5SGfyuehy13wdz8oxSfU7ME0C+Ag=;
 b=DpeusVOngjYmtzu82gVGQLqIfe+h2k1OthKtfll1ap4urMule2CogRcp0dgz6wN1Xg
 nvC1dOHg8Qj/NMsP7Jdn54dy5Af19ukncjZJAbN3JNJ+BdMy78uflNBcEqDmW9TNlqJq
 /wPAMcdkAlRIh70fXg9CYNKl2R/cAq23nIpFt2YMvdgUaujZFyk+pZMYMJJ6a+T0cNCZ
 H1s7IEAl4gQ+hVSHt7qP7K8LGlCBRmBpzNOBl1BPX8X+rDtg8hNRffm0yC/UnLtkO047
 9fipjkl4M20pmxDSvu+cYL8KEuR+fpDnPNANGzkOmx4zd9KfYZjYy0whPy3sX/nxElfc
 3VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350474; x=1788955274;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=etxuxkqAPn48hft5SGfyuehy13wdz8oxSfU7ME0C+Ag=;
 b=GoyzOFANZnUl8KfWq6FwTd5IGKmwC0/ecGvH35cZAjR+AMli01nV0GgwS9/6jOuuGe
 W2VArjV5GrEymMKktMDBN2ZvNFqOnxjdQa7Msf+gSyP/4g9Mbgi0rZBh49t9ntoe6p6z
 0+YdK9Omi8FGdaY8qzSbjttE/moJfrrgrNYyQU3xfoT3sfdfSQHlxwBRPFAjJ/o4EcWd
 TbkJ+XQILoAesYHj9UaoU19Uc92J+iwbPuuvPGRbYhM+SrVkjqjr5QY/foIvMWL52OAB
 oOMydHrKYRknOZ0cx987Y3JAhkGmWGYyXZUzH1e+UiE/o+YT0lCuqLcwWykD+MC8ei3P
 BL7w==
X-Gm-Message-State: AFuF++mIwOOesQkoMDXrWfbRqSnZSGE9MlgZ19rVBwuIIjH2OaQNn6s5
 qTJpYwUkSWPzGRDsKFyNwfRrulirOf50KN/8J7soFf7K+2cJOOfENHWqmNpZxgHOzig=
X-Gm-Gg: AYBFou3bZM9V0nYuAObr4ZIYIGVemKYHsWxagE1YdPqmUDwrqplv5lmMPMg8zNdgucG
 okkJr6eumVk+5UTxse19/BySsK5Z+IGsqYeiRFENXDAIVlp22aGN5EuyOGSvLPiwqAUYR22BY7l
 Y6OR4XsTelAeNaNC8CFRsPgCTcR5Mk74YKq0tDjpjqsYL52LSUYVn+BSpu7s6BaXIv4zkHy5pb6
 7/9OiUbrehhgmDAY+KjB0qtRP5uC3zPpF6zW6KiaDqdfew3GMxJa/p8vs8JZPYzh0SpK7atHkIg
 LHGZ8cOUYK8XYuY0hKtHepDRNxkhhJW9ZAPU/FBTFUCwcwY5jiaIcdvR1fKVKVUacawX2GeDqy6
 wgTdh2e8iY0M0+AhMF7lF1EOul056Fpjil9eM/kfhEeuRw5peLg5UzzjftBpvYww/gZm7H9ZY2x
 0zWIoJvyfWbHibpoPYPZ/HR2pwlskcfJtHTgRT3vxbM/UxsWoUrPMWPEf6Rhaj
X-Received: by 2002:a05:6402:24d7:b0:6a5:f9cc:748b with SMTP id
 4fb4d7f45d1cf-6a682555d1emr2778406a12.9.1788350474015; 
 Wed, 02 Sep 2026 05:01:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80745sm6060325f8f.15.2026.09.02.05.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:01:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 640A35F85F;
 Wed, 02 Sep 2026 13:01:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PATCH RFC v2 30/30] docs/system/arm: document Raspberry Pi Pico
In-Reply-To: <20260830061601.52136-16-gilles.grimaud@univ-lille.fr> (Gilles
 Grimaud's message of "Sun, 30 Aug 2026 08:16:01 +0200")
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260830061601.52136-16-gilles.grimaud@univ-lille.fr>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 02 Sep 2026 13:01:11 +0100
Message-ID: <87tso7rhfc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Gilles Grimaud <gilles.grimaud@univ-lille.fr> writes:

> From: gilles grimaud <gilles.grimaud@univ-lille.fr>
>
> Document the RP2040 machine lineage, supported and shallow devices, boot =
ROM profiles, ELF/UF2/raw loading, persistent flash, serial backends, machi=
ne properties, flash policy, Pico SDK exit compatibility, and known limitat=
ions.
>
> Add the board page to the Arm system manual and its ownership entry to MA=
INTAINERS.
>
> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
> ---
>  MAINTAINERS                    |   1 +
>  docs/system/arm/raspi-pico.rst | 641 +++++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst     |   1 +
>  3 files changed, 643 insertions(+)
>  create mode 100644 docs/system/arm/raspi-pico.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41494eff2a..0fa93d28c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1043,6 +1043,7 @@ F: hw/*/rp2040*
>  F: include/hw/*/rp2040*
>  F: hw/arm/raspi_pico.c
>  F: scripts/uf2-to-flash.py
> +F: docs/system/arm/raspi-pico.rst
>  F: tests/qtest/rp2040*
>  F: tests/tcg/arm/system/rp2040*
>=20=20
> diff --git a/docs/system/arm/raspi-pico.rst b/docs/system/arm/raspi-pico.=
rst
> new file mode 100644
> index 0000000000..d28cd20af8
> --- /dev/null
> +++ b/docs/system/arm/raspi-pico.rst
> @@ -0,0 +1,641 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Raspberry Pi Pico board (``raspi-pico``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ``raspi-pico`` machine models a minimal Raspberry Pi Pico 1 board ba=
sed
> +on the RP2040 microcontroller.  The current model is intended for bare-m=
etal
> +bring-up and tests that execute code from the RP2040 external flash XIP
> +window.
> +
> +RFC lineage
> +-----------
> +
> +This machine starts from Alex Bennee's 2022 RP2040/Pico RFC patch series.
> +The RP2040 SoC skeleton, Pico machine, and memory map are adapted from t=
hat
> +series to the current QEMU tree.  The RFC ``pc-bios/pipico.rom`` image w=
as
> +used for bring-up experiments, but it is not installed as a QEMU firmware
> +blob by this machine.
> +
> +RFC patch 0005's mask ROM loading logic is adapted for the current machi=
ne:
> +an external boot ROM can be supplied explicitly with ``-bios``.  QEMU st=
ill
> +uses a small synthetic boot ROM for direct XIP bring-up, so existing fir=
mware
> +tests remain stable without requiring an external firmware image.

I don't think you need to document the lineage in the user facing docs.
You can add Based-on: <msgid> tags to the individual commits where the
patch started out from one of mine if you wish.

The rest is a lot but I can't really complain about comprehensive
documentation. I do wonder how much is repeating stuff that could just
be pointing as RaspberryPi's extensive and good documentation?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

