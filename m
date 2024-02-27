Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ABAC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf19D-0006HV-VD; Tue, 27 Feb 2024 12:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rf18u-0006EA-Mq
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:21:25 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rf18s-0000x4-CG
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:21:23 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso4895570a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 09:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709054480; x=1709659280; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2KfBsfSw3AQk6ca8hw7vMplw/8fGwK8SO5GqjuWlrKU=;
 b=eAIRNCxVJx9I5zYW5ap3lf6Jli8LWB/kU10xdMGH0E0xbIfxPDuq/1n5dCi0J4IDWF
 DeHQijDw6sXfzSS7EiG6dr3tgi1k2sRaRCp3pjJJs4v45iAQr54Cz7igPFxdAsyhIyjI
 n30G7ZejGBhbvJl9gMKdlF7wVSMdWjGZhyUrUfxgw0YT3MvVe/m/ZUJ/jGCBjbAowrRS
 S21El5aL6EvHMufacaqecD3JyglrjdTMEx4r20cNDWJV1AW/PiNeNFzvt1vvCS2PNP08
 l+39jBLOKSs904xWe5dm4ojYATBGw4anFe1dV5peFnvM2ks5MT45cdtY16qbKZzY9l7u
 7KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709054480; x=1709659280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2KfBsfSw3AQk6ca8hw7vMplw/8fGwK8SO5GqjuWlrKU=;
 b=HCZGSQdiz9OU5ZyE3npcP7Vk5QB4sp0LY7j4jr5X4Q/I+oURjfy2hGcpsSPE70GPA6
 s0BTyeNrxUfp256f/RgFdAAq0jowArpoGrAqInau/hWb932qKU3Uo12lhOJRl/TGevCL
 L3g/gEyX2HQ6Y6bf8Muw3JA1KlWVkgDal7l1XMqkoVYGAV16W7iFQtZM3Iush9VONNNA
 vOr9Hmm7TIS10xKbvlcP8UslixPwx+FrGrSKeKunZ023oq70DCmspuqKR6llBDzbB9kJ
 zoefAF/XjjWMU/8/g+GM4uSZBVzpt5qAAOPBlno2KOPX3YrhzwZg023chS6M2mLr7u2T
 v6GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxnF+jPCgcVIKvzZpO8PabR4H4XBr107VMcPX1ha/iMUsSC/kvElqWZ9azgOzFWrLtS6UeXZK/tkd9H5HRnY5wvtP9/+8=
X-Gm-Message-State: AOJu0YxkHyZ6fNUY7DfJgvquoB/nkf2Y2AV1ImWGnc450v0+KuEGyp5m
 LhhEWgCoNBe83154y7J9mSXOK1pS9M4KPcAv0mJpPyfSH97Xi/Zyw5ekSG+OqsTRBdcOjpLEt9y
 SWBxjnwvLrvIXAtAPwNhkLOLzypZL1IfNBN/K/A==
X-Google-Smtp-Source: AGHT+IGgmBeStlL3PViOA/OVvNU3/lf0kCvTd6O6Tq7ZWmCf822D6CBAhh9vdmq9tgykjelTQOoQ0ietRM+cuCfHdVs=
X-Received: by 2002:aa7:dd12:0:b0:565:7c9e:97e6 with SMTP id
 i18-20020aa7dd12000000b005657c9e97e6mr6398741edv.11.1709054479974; Tue, 27
 Feb 2024 09:21:19 -0800 (PST)
MIME-Version: 1.0
References: <20240227125201.414060-1-clg@kaod.org>
In-Reply-To: <20240227125201.414060-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 17:21:09 +0000
Message-ID: <CAFEAcA9SabyrJ=ydVmvAuAj+dqk5mPOaTLBdNjAE=pd9vzz_zA@mail.gmail.com>
Subject: Re: [PULL 0/2] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 27 Feb 2024 at 12:53, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The following changes since commit 1b330dafcdc34315f6837ff3af34dbb4b31063=
73:
>
>   Merge tag 'edk2-stable202402-20240226-pull-request' of https://gitlab.c=
om/kraxel/qemu into staging (2024-02-26 21:28:11 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20240227
>
> for you to fetch changes up to db052d0eafe86c336d512dba99a1ec7c5c553f63:
>
>   aspeed: fix hardcode boot address 0 (2024-02-27 13:47:05 +0100)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Add support for UART0, in preparation of AST2700 models


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

