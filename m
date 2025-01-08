Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9456E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 15:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXxD-0004GC-QP; Wed, 08 Jan 2025 10:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVXx9-0004Fz-FM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:26:39 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVXx7-0005kR-IF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:26:39 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3d479b1e6so24103476a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 07:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736349996; x=1736954796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBg96s0Kcm/1MgNrY2Htn1NRFX6F1QLIDun16/xvVO8=;
 b=ih9gr9enZ5aSomk0iivk6WCcUzAeowvAwKnVcnNlb2imiHoAhCIfhZVh5Cutx3Bzp0
 WatRn1VuRXC5cn2tmET0PlgA8nY1Ew1sr9/bSg4fdQc1ZwKLnozFbTmkqspdKTDvxGsi
 sjUHEvQPR1vx76ECe/Ig3W4k2E6G5egFsoGWlINDEx7a5ilgmd3ELtH/oksl1FmlQUs4
 bVvHBWzz/tLtHeoHZVjwH0bt/Y+M/6VHRTD4bAFINjQgWOPX0/Gb440TWPoheCbKw1Yq
 Ebgt95uqaOlmVtbZPGPoMzx1CMnRrMt+rODOz0Mk42+wF/RyAcSCKMTXPaIh1NwDNSso
 5EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736349996; x=1736954796;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hBg96s0Kcm/1MgNrY2Htn1NRFX6F1QLIDun16/xvVO8=;
 b=haM480/XEb7xL4+grNIqJzrL0Jsib4mkhlnKREuxKLROdVvnRZxxtxJZKS/GueCdzG
 tW2owniIgMQpk66btjifssXIL6gKOcG0EPrReqVvOr0FawBs09WAx/xfPZYji8e5KCLz
 +KoxXhZUi9YXKhNsL7DzYXQ2RR+VjlOpU2ywM7cswKy6zLchki6loP4/tdcXDHkOiBDY
 s8dRvHq6wQ0Whz1lCJGwW2j/XmKTa/mMjq/7+A8hUJHXcU9KE67Lhu7wEs8+AnGdsQ85
 l82KJqxTnyzMUakRziMnw6uaR/7voMUC8wxk/yF9HDMOSDsd/R6Fd0Yy8FBqfRUByDyt
 wWQA==
X-Gm-Message-State: AOJu0Yyd71kSsRNqYkqkroRcTW+rdmTV7/kT/GQ3PY557FJdrqc8uo84
 lbWgewqK+/D0F2gFsKIqaMFchFtyR8l5cbTIk5WwrMULpJeYEKYD++KRw33I7U01cHCF7DTTAt3
 1iWM=
X-Gm-Gg: ASbGncuv23CyRHDB6yfeQoh/TQyKanYAHfu16TERwkeaz/AcBbY3odPfP6vuqkRwXWv
 nde910BHkDwZyS+NCS2/MZmfMBM/olLtkSOE9Tks1jH4Zq9Vu7BgxXeX2/Th40xcwgKAzKJr0+E
 4iHdt1Y+YJb+8QNmXy0EM/1IG17J8SONub8/2SB/Pue7ncWeXYlzUs8cqCMPTLEBnGaoSM/P2CE
 YAaXqi9FI20F3m8kJ/Ctta2kCD31PXmmv4z5eZpqYB99WHbz7cj/r0=
X-Google-Smtp-Source: AGHT+IFaWxks5b3NO+/5dmzjf0dK4K2X19qc7LQx7IwGU7Sdrw26wWxDtrQUsvQiZ0ujPHa/1aOVQA==
X-Received: by 2002:a05:6402:1eca:b0:5d6:688d:b683 with SMTP id
 4fb4d7f45d1cf-5d972e0b18bmr6786112a12.9.1736349995788; 
 Wed, 08 Jan 2025 07:26:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f029072sm2470902066b.170.2025.01.08.07.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 07:26:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7DBFD5F8AC;
 Wed,  8 Jan 2025 15:26:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,  Kito Cheng
 <kito.cheng@sifive.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Keith Packard <keithp@keithp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH 0/5] semihosting: Reduce target specific code
In-Reply-To: <20250103171037.11265-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 3 Jan 2025 18:10:32
 +0100")
References: <20250103171037.11265-1-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 08 Jan 2025 15:26:34 +0000
Message-ID: <87h669ba39.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> This series makes semihosting config.c and console.c
> target agnostic, building them once, removing symbol
> collision of the following functions in the single
> binary:

Queued to semihosting/next, thanks.

>  - qemu_semihosting_chardev_init
>  - qemu_semihosting_config_options
>  - qemu_semihosting_config_opts
>  - qemu_semihosting_enable
>  - semihosting_arg_fallback
>  - semihosting_enabled
>  - semihosting_get_argc
>  - semihosting_get_target
>
> This function is still problematic, being built for
> each target:
>
>  - qemu_semihosting_guestfd_init
>
> Note, it depends on CONFIG_ARM_COMPATIBLE_SEMIHOSTING
> which is target specific, so doesn't scale in a
> heterogeneous setup like the ZynqMP machine, having
> ARM cores with CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy and
> MicroBlaze ones with CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dn.

Does MicroBlaze even do semihosting?

> I suppose the semihosting API needs rework to consider
> the CPUClass? I'll let that investigation for the
> maintainer ;)

Hmm most of it is already handled as EXCP_SEMIHOST exceptions are dealt
with withing the target specific exception handlers.
do_common_semihosting could be renamed though - do_armc_semihosting()
maybe?

If we have the full list of CPUs at qemu_semihosting_chardev_init() time
we could then selectively do the bits of qemu_semihosting_guestfd_init()
depending on what combination we have. For normal open/read/write stuff
I think they could co-exist.

Two independent cores could still write to stdout (0) though. Fixing
that would need a per-cpu semihosting config.

>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (5):
>   semihosting/syscalls: Include missing 'exec/cpu-defs.h' header
>   semihosting/uaccess: Include missing 'exec/cpu-all.h' header
>   semihosting/arm-compat: Include missing 'cpu.h' header
>   semihosting/console: Avoid including 'cpu.h'
>   semihosting/meson: Build config.o and console.o once
>
>  include/semihosting/console.h  | 2 --
>  include/semihosting/syscalls.h | 1 +
>  semihosting/arm-compat-semi.c  | 1 +
>  semihosting/console.c          | 3 ++-
>  semihosting/uaccess.c          | 1 +
>  semihosting/meson.build        | 9 ++++++---
>  6 files changed, 11 insertions(+), 6 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

