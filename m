Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62142C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDBX-0007qk-Ff; Thu, 07 Mar 2024 07:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDBV-0007q4-K4
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:49:17 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDBT-0002kc-2z
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:49:17 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5682360e095so67833a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 04:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709815753; x=1710420553; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlhpGeDgoOR6m0QuS4p5ZaDkH420pj9/t2sQw+n+Jqo=;
 b=t3LFh3obYoCnMb8u/qqHbpF3t4Qle96laH0Zxs1KdsquFHjQrfX9PeL7xEfVZstooO
 s8Ln1atBpGUxqPJ7CMe+aCf4a09y0tWkoOyJHH6pPcFn1iS7OkpUmwLJ84pM1ITkVq5m
 z3eIDt6jrAsPNzpmSEkK1oCivnbP9AOu2hAV3vWfVnkrsAP+W/1IVPWivEaM1mn3/lNt
 xti6z62OJroXj8vxLCcunSKLk2hSSDHX54G25IK1FYY35fvXxIHwhPJCpfAgill7mixd
 aw9E5c34NM1SrW2/25Akt8P5n/+CXV3Fq4LiOWX82fVWTqwtYG8wxbZMkUEYB13w+12h
 1Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709815753; x=1710420553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlhpGeDgoOR6m0QuS4p5ZaDkH420pj9/t2sQw+n+Jqo=;
 b=fVq6dy6OmiwkceawJvDImkndvz+A0OpRGYOve9k5w1eT8jCz37a1P3XS40efxso9ra
 h4Tnl0IUUx3WWKvt8CKlTVYOtLUDvU5CZWn16vI3blHwfwG3ArXtmRHLPGxxAdcSB06j
 Ynd3DND3DsKqOHqxppmhJFlXKDfbuedxlqK1cLv+2GOq2F4n8NvBnxBByiHuxFs33hGq
 yVrqpK5SOrP6j/OvKJ5j/CCFSCqhmXJKvmL9DQp98k2LHjeLO3hJdcnx3VV8CmUB49GC
 zSs8x/NKdTZ4Z+a0MR/yEOqnMK45/Eg9L7VQvNxFBEklEtXRHt5Edq7Temimx/nS878V
 Ns1A==
X-Gm-Message-State: AOJu0Yx0qeEfQbT8QzXi5X09C+BnGDT17IWCHWwUhSRhsDgNfe1tEWct
 NJITPIj0M7jt9MWgsZ8KoHT4wHkYP0jWG4Ztc2pI/7RFIvCbkKRl0+lRfoEeQw9aiNjQblAeI3E
 a6N1MOAzX4eRifYtcpQfgnoLBMJuHsou4ABMXjX2klgLpfLve
X-Google-Smtp-Source: AGHT+IE+azDNL66s6ASfIJQ5931w7u32Iwz9Ua8T1jM5brutl4NOH02a6mlQCE98X50jex7dMftcWbGpXe6Lgw6vDLw=
X-Received: by 2002:a05:6402:2267:b0:564:5764:a5d8 with SMTP id
 du7-20020a056402226700b005645764a5d8mr12750487edb.25.1709815753529; Thu, 07
 Mar 2024 04:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20240305210444.310665-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240305210444.310665-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 12:49:02 +0000
Message-ID: <CAFEAcA-3818ukCcer9rFed982_RJScFkvXrGCUdiBpWCxOLbsg@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Add device STM32L4x5 GPIO
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 5 Mar 2024 at 21:04, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> This patch adds a new device STM32L4x5 GPIO device and is part
> of a series implementing the STM32L4x5 with a few peripherals.
>



Applied to target-arm.next, thanks.

-- PMM

