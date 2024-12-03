Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47176E69E9D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQFT-0003GJ-1M; Tue, 03 Dec 2024 05:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIQFQ-00039h-SR
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:35:16 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIQFP-0002bN-6O
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:35:16 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so6207708a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 02:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733222113; x=1733826913; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l95CEPSi7YmmSTnqeGCtY50/wllLQR2MmUelLISrR44=;
 b=NMWYStN/Rsxn8W1r2G07lHv0HkUXeGfjtlNURPEBc54nYxQbE3zLtYTuoAPIvi6IXr
 pI7BGMmw/vXtX/WoZIvDl6PeiHKNN4zVNFn4EolvlLBCYHQknuk4N9nRBLRMbs8K7xiL
 P9Lp/pqRaeg+ykqbcpr4YHq/NmuO+5aBcqrrFokHyTBQRtEsLoTmKS8fLWFzPpInYMYH
 aU0+n2uE4P5O6KPDU2g6nYcEfvVXqMGsmxetomUVJmUe+DyW5fpOIR2i5s4NkYHN/rt1
 v2OnOMX4R8sIwoTRGqE/Fo9WGtI6pHXl/0F7rYWI1evNYp1h2IpTVOOb7w1R7MiKJvuA
 ti9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733222113; x=1733826913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l95CEPSi7YmmSTnqeGCtY50/wllLQR2MmUelLISrR44=;
 b=ADrYiMis6n1cmHXS3j+VRvFuA/patO/J9XWhGINPzynueNEejvkZ4ut5/t3y4W4Jzy
 p6lQYrM4QAMdbtAXHlHLpc4lC0eJ7kmW4YefLuVW+l5fjAPOyoBshHpx4eRiLYX3oFXj
 dMRUKulTxOzhMX5K3OLK+7bPPu1LXuCFnZn6wAC4cfQLiI2MBXW7ybQMcaDZlNWAbjJz
 Y69yZZ1LQpj70zhnHiLP2wMefhG4lPKSU1tVU+/TY3KhHqO4F2XaXJo/T1u/zUkS8zrY
 qOqXjPjI/zeCQzHfeeGChye2B2L1mt/tL3wIH4epaUA/Jb5XAilIqfh4m9esycSgZ1/2
 X7NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbmlXjCYQGSzOcJshSRo+pQw6q+OETja7bBebXC+s1H4Z4lMasBcspHIh+QHok1izIfoVOCxbuhc+S@nongnu.org
X-Gm-Message-State: AOJu0YxguQVDQUYDIl45X3zycIu1DZnhBH4dnx6Y6+xVfVBm033/4v09
 QWk7j1SU/GqDwMzOFsY5zUN7MJ9ejBE4Oto1c141nBHEDl7m+T/c/Q142Lw0QsRIwRUVTwfostU
 4g+3jIlFqsMn+4iS0QGtlnVsS9bCmNyrzcWQuzbcO7pptfYeF
X-Gm-Gg: ASbGncuKfa/gbz0BkQCDsErDXtE7POUU0JwD068kdakPEweAvaJBrGRvfdRGAIz4eGv
 QSj5XBe/jMFhl7fhzGtOyL13TBsgJNsGk
X-Google-Smtp-Source: AGHT+IELLGcjby2YtXQitUkAB+XEjOulOmsVYRNr2M3s32394qmWIN2U9AGcETixoi+bZAJgnoDVKwg/GCwkvlfHdXI=
X-Received: by 2002:a05:6402:35c5:b0:5d0:b040:4616 with SMTP id
 4fb4d7f45d1cf-5d10cb98e7amr1860248a12.28.1733222113369; Tue, 03 Dec 2024
 02:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20241203094702.124748-1-abologna@redhat.com>
 <cb079b65-e5fc-4667-aa63-9ff347666b6e@linaro.org>
 <Z07a_kYh4duwWKWw@redhat.com>
In-Reply-To: <Z07a_kYh4duwWKWw@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 10:35:02 +0000
Message-ID: <CAFEAcA8BAW4=Yk5q0CgQNL4UZpUJXiwRV6VD-52_Rw0SN=E1Cg@mail.gmail.com>
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,
 64} part of the same family
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, 
 qemu-riscv <qemu-riscv@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, 
 David Abdurachmanov <davidlt@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Corbin <mark@dibsco.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=unavailable autolearn_force=no
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

On Tue, 3 Dec 2024 at 10:19, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> Separatley this from patch, we should also consider whether
> it is time to do the same for aarch64/arm7.
>
> If I look at this page:
>
>   https://gpages.juszkiewicz.com.pl/arm-socs-table/arm-socs.html
>
> and sort by 'announced' to see msot recent CPUs first, then
> almost all of them have "NO" in the "aarch32 support" column.
>
> IOW, on modern aarch64 CPUs, qemu-arm is the only viable way
> to run 32-bit usermode binaries AFAICT, and suggests we ought
> to be creating a binfmt rule for that on aarch64 hosts.

What happens if you have a host CPU that *does* support 32-bit
natively and you also register the binfmt rule? Does the
host kernel prefer to execute natively or does it invoke
QEMU? I don't think we want to roll out something that
silently downgrades native execution to emulation...

thanks
-- PMM

