Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E3CCD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 20:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQA0n-0000Am-Tt; Thu, 21 May 2026 16:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQA0k-0000AI-SM
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:28:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQA0i-0000sw-Rk
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:28:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4903974854dso10532995e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779395331; x=1780000131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7AlX1zOnsIRlw1I2xhuzDkfrP1AIvNyFk5r/QJiaPo=;
 b=Vj0isDAW2ewh5r28Y2uQIyMZGy+YqbTGOzBOYX+mDZ3B++fsIdaqV35+k4W8s3GPlu
 wMyP9ywCrvrZ7z6f8etqEEnwEM7uSMybXfYiBYHxeb1fsTOedt31WbOfXWh+PKYXfvOu
 8SHhSACLXQz/bXVaKceKJwtM57ededmDBK/8Pdb336I/ySzcsZmSxm6OBOepqA33UpjB
 w8Vdm4HkpDz9qKNjlRaIggUK4s8fDcJ2eAb+CLY1cjRI9p2sS3DYrBJQ1Sq/OAFZL0E+
 L4MxOuBmGcABTjbTZM+41wdg0rH069WSOvzOh3qf3vKKhx3zYv4QTRzNIpp5XxgQaE3z
 LMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779395331; x=1780000131;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y7AlX1zOnsIRlw1I2xhuzDkfrP1AIvNyFk5r/QJiaPo=;
 b=ZHIANFOSIQQo4lHXXukbszACP85TRX+OUbH8x3Ict5ObKzyEJ9pFM4/iqKN21M6Pi/
 HwcigtHW7g+U5uNQz84FfudHDHdvWXNnx6kz7GsJ1nOQwWXYZD8CVlXEaJ+rv7rnI9zh
 LrQQe5HoZk8FvVo0Caa4yvHfcB+Qdq3IlML/iFPjxfvGZsvnDz0ClluuJIn6kyXF4Ib9
 QEx7qFj1CGOiwO1NSwcIs05zXASKp1f0HkWliZzmU7D5zqwf4bosFSObyNA+HOPKxDZg
 unVotFGW867HQFiWyM8xlTHBXmmGzwdrzhCaP9+21h7g9I8uzzWA4oPd8epigq53UjFO
 Mraw==
X-Gm-Message-State: AOJu0Yyav1wBQGRD0DouPbWl7vpYsdzD/dEG+i6bV748IrVok7ZlP2Qn
 eA2xUBwysJs/fNQwJ6PXyhLEaFv7EAM99nprPR+uImonqjJgeV2/Hz2uM7x9T0d7qX9T8vB4Ny5
 QDn/RJlY=
X-Gm-Gg: Acq92OH6Bxe3FTDWRzXoFd2+hCs+r6XuFRgiHsI4PYg2M+nXCXC72s3Zxi22ZHUuqvE
 kGUH98bFipOeGbsxndG1lJcoElcdBuFYt3AL4sIIhwTZG8orABj29PavqkiNwKjQGf1VtuAMfQH
 TJejUI5UNx6Zz2Yy6XR8ZhzKmsJIkQMcQQNUT4i0ZirwQkW4FED7UvSb4MD2E2Davuo8CzKBYrh
 v+HCbgp9HQxXXBzK939feGuh4mZnJlYPjheaR/uEUsdgKCjam/usVU87hmS/FiiTIEI49KiCgqb
 fA84SuK816h439QMOoo2/mOZXoHnxEqAZwayR0yeHU3kn0RHaEc/VUEU9869eEBu6mVF6P0E2sW
 nWfboTnn1x3Z++ieHmHjAIZ5RUJZc11uXp6eRkemC887DaOarNG5uV5rXlZJ5HNGsXz6muSyAWk
 DUhQFZYMnNq89dmY9DUzScg/A=
X-Received: by 2002:a05:600c:8599:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-490426b49a3mr2698075e9.14.1779395331224; 
 Thu, 21 May 2026 13:28:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7cf1c2sm5531479f8f.4.2026.05.21.13.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 13:28:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB7805F886;
 Thu, 21 May 2026 21:28:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: gustavo menezes <gumenezes2019@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC] Add initial Qualcomm MSM7201A platform emulation
In-Reply-To: <CA+YAEjo9BdN6RuRbg=bfVqke4kf24my21Jk3P4aJDzR8A5yqyw@mail.gmail.com>
 (gustavo menezes's message of "Thu, 21 May 2026 15:30:11 -0300")
References: <CA+YAEjo9BdN6RuRbg=bfVqke4kf24my21Jk3P4aJDzR8A5yqyw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 21 May 2026 21:28:49 +0100
Message-ID: <87h5o0mrr2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

gustavo menezes <gumenezes2019@gmail.com> writes:

> Hello,
>
> I am interested in developing initial support for the Qualcomm MSM7201A
> SoC family in QEMU.
>
> The goal is to emulate early Qualcomm MSM7K-based smartphones such as
> the HTC Dream / T-Mobile G1 and related Windows Mobile devices.

That sounds like quite a lot of work for one person. Have you done much
device modelling or reverse engineering before?

>
> Initial targets would include:
> - ARM1136 core support integration

We already have at least one board that uses this so that is done.

> - UART
> - Interrupt controller
> - Timers

Are these all Arm IP blocks or something QC specific?

> - NAND flash controller
> - Minimal Linux/Android boot capability

While Android can boot on QEMU (specifically the Cuttlefish Android
target) you may need to model/stub a lot of devices to get through the
boot of an unmodified image.

> Longer term goals may include:
> - LCD/framebuffer support
> - Audio
> - Modem/DSP stubs
> - Power management
> - Windows Mobile compatibility
>
> Potential use cases:
> - Preservation of early smartphone platforms
> - Android historical research
> - Embedded Linux development
> - Reverse engineering research

For reverse engineering you should ensure any devices you model work
appropriately with record/replay.=20

>
> I would appreciate feedback regarding:
> - Existing related efforts

There are a number of downstream forks of QEMU that model various things
including at least one that claims to emulate a full iPhone so such
things are possible. However most of the upstream models are either
aimed at virtualisation, model various developer/reference boards and a
large number of system controller boards.

> - Preferred machine model structure

I'll leave that for others - however the general advice is to be wary of
copying and pasting for older models which often use old/legacy APIs and
haven't bee converted.

> - Maintainership expectations

No one is expecting full security support for random board models (see
security.rst) however neither are drive-by code dumps particularly
useful to the project. Orphaned sections of code are liable to
eventually get removed especially if there is little evidence of it
being useful to people. You should be prepared to at least field bug
reports and review incoming patches even if the patches are eventually
merged through some higher level maintainer tree.

> - Upstream acceptance concerns

All code added to QEMU adds some degree to the maintenance burden. As
code is likely to be re-factored by many people the most useful thing to
address are:

  - Good comments and references to source documents of what behaviour
    should be
  - Testing, having some way to ensure functionality doesn't bit rot
  - Try and keep changes localised - QEMU is pretty modular but if you
    need to make changes to wider code expect to justify it.

Plus all the usual things about project coding and commit style and what
developer focused documentation we have:

  https://qemu.readthedocs.io/en/master/devel/index.html
=20=20


>
> Thanks

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

