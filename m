Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58269FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdRu-0003xe-KU; Tue, 28 Apr 2026 04:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHdRr-0003vo-O9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:05:39 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHdRp-00040L-LC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:05:39 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6501725d888so9002984d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 01:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777363536; cv=none;
 d=google.com; s=arc-20240605;
 b=Od1fUHmbArB+c2faW33hIp2Utub8z3bAj+JM1S+7y2tzwRwcLH8wp+czvZVG+km9V3
 rnbVwk+nOF7IcA6s3AVG4+uLaVIj1bDKnvxF3AyNUxoLi0oJV1AHqpehtYafYN8h0dWM
 WJocDc2imvWDghuZIpd39PmW63GCg1Knwx95yi3vIOJpXq58tcUa9Syt6F14jNyywCfg
 chHZQfbhyDnl+MdkaXKRY5ML7F+j2QvTW7M5p7Gn8a5C2qPoOKcviaCKauGVluzjmgdS
 819Yknbk9HRt1pCi4RZz1OzUKIOcRJArLtCDt/qAql0ygLR1q2cTmyoARw9DReSZVQPT
 e4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3p6JM+SR761BTEBtVAwiHNtyumubWwYU22QwXID24vg=;
 fh=M/bNlt4bsN+Nhx06lHjVtTmXzFrq2ct96MDClRYMSKs=;
 b=h1WmfQPmjx101y4r/MCpNS/A31B9I5CqQMP7ND/bS64jwQASl3d5DiBSemMPQZX18N
 jlkhM1WMjbfDKME/nW/uJegR3T12kdkic7+4zJuxkXM+kTkcESNv+jMsYKx8OQuGIB/D
 X7cWWjPvzmRkxgRvTtbW2NHXBPQ6qADo+4o9un8k2y5VVE8QQx80JS1b9r3bOXTUSun/
 6EEUhqVi6q2h9wrv+StZa+u1Kqb64bl6/lRN71jwsv3OvAY0s+H7neK2ySyjSFknHNF3
 sIv+exDN4lEtn0ri85xVQ3eq8kgvGk3NV44FlIMw7UltYn72JZx1nF+CURN6P8ULwmWj
 W1gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777363536; x=1777968336; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3p6JM+SR761BTEBtVAwiHNtyumubWwYU22QwXID24vg=;
 b=bnf/iXPDo+Yt0geVTbEaiJygo1UBsONQc/RHwDqQVrXkpXuO9ewLcK0G0iLzaBBZXh
 1ouX079Y7Vnc/yYsTpi275zCvjQf3jCaq+fHZeGt4gmj+gc41gcAphitTjlaaGKi2kVW
 DLc9yTtiZ4/HOC8AkpbyE4I89EMCt2J1I0yLjFGVsBIYQu0BLGhd9jBS+74283wqc71G
 6PcPCBpNIZaHFGe+FVekdoaCoNDnuTFA3eSklZ+d1W5/g8i6GU7k0wIR50rO5odh3dqG
 HHmNbojqEUKoMvoxJdyUUAERCLCUWa65aHybWzkxhs34HAEDhYTgIyZr05bY9bT8REOv
 jF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777363536; x=1777968336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3p6JM+SR761BTEBtVAwiHNtyumubWwYU22QwXID24vg=;
 b=e0z1g6FSUY3YMyaMIpTsXjLwvyGivCQpEbhm4LBUJnBwqCNikUfZfqOJitC3Vn3jaO
 D2Tmqi4nCik0U02DTu3yD0Z0iJcIvJbmWM2DIQ+8iXnp2CtaL+VaInRvgJH1FEViKeNz
 LHWrTJVjU4drdMJICiuPJQsnz39S9q+xAG6d10exr9FaB8QWLyMPtiwZ5m9qESHyF11C
 Ees/W3O5B+Cix1sQxuMRoLFYaQwm5PGdWajQIp3dlh+0RjFQqe43xPzcTMLSnzWUAUAB
 i+HWVGMtxEBv6hCgyXpBnNgC6/L9ku9SFU2tASY7T/SFUO22E7eZMRJynrVcvQoUCIrW
 2vGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bZwCfZlQslqwUq+zRJez0xqRuGMzLEtvfMAfzD4iw5upwi8txPDtJDtz57ILTsUId8orSYEynatli@nongnu.org
X-Gm-Message-State: AOJu0YyOp7nhwgY6If4qz3VGwuAH4HnZA7YvnDVs3nyyYukIqFGO9Gjd
 /cxUYup4H/ER9c6QBSSNWisGqIBtVZGGM+j/Q2WM+4XVs4Us3h4AZyn5ak5k0QWJGLgnqgDB6zP
 VKytGdRQhU5yjXxuCBwPOGMjUAssjSb96trvamJfKnQ==
X-Gm-Gg: AeBDievjljcFDNYeqNjYRSsUmrCadWg3XMlgzju/gLU9uE/WVZzoDFCHzL25kSuhH1p
 1m/oA9Zg7DWHymx1XSiN18XgN8oSXISZrAgfP6YsYxxuV7L82Aw1Z5O6MM6ZwTAzWFbQ4PNu8PM
 5P0SepGglIWxnRnMUPYTbQ2u8eUDpSu7tYFgPKH6QxBq9YXkSFNnhhgTSMu5AkWu5wSH3Vfyav8
 uhuVbCG/eBMe3N3kK9El2q/74hqQD7BPF8TlCN3QDfqoAmYHLTGF1ZZWCS0kkjPvV5nm1+W3KNG
 UPq7kceasLHNR0fqxwwWa0EAatdL9+Nl65AWVjyB+DOuaY/Ds26xB0nnyEhTeaDdsU6wsQFOZQc
 5xcO1DoGHQJq5
X-Received: by 2002:a05:690e:14cc:b0:654:ea8a:f2e with SMTP id
 956f58d0204a3-65beed3d1cemr1676384d50.3.1777363536304; Tue, 28 Apr 2026
 01:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <CAFEAcA-8BeBte6CxH._5F5Zsk3wvs0zJJW6+=8cNaroRTBegK-M5A@mail.gmail.com>
 <20260427184540.80415-1-lucaaamaral@gmail.com>
 <CAFEAcA9yGmWq--JsyZpPnOQ74i=j7JeeO0Xf6be7wWxJGbXLdg@mail.gmail.com>
 <8A075A86-D6D9-4C97-BE31-C94D58F796FB@unpredictable.fr>
In-Reply-To: <8A075A86-D6D9-4C97-BE31-C94D58F796FB@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 09:05:25 +0100
X-Gm-Features: AVHnY4KeGH0WyyxQvKCaRKcMnc1goi-jzR7sy7-stK8-wqpk1UqkEuC8IRmENT0
Message-ID: <CAFEAcA_TOBD0p-Vom2f14DimmvSJMNUWZEXyg=0onjgn3OrB0g@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Lucas Amaral <lucaaamaral@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 27 Apr 2026 at 21:15, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
> > On 27. Apr 2026, at 22:02, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> > I would like any memory access emulation to come with an
> > attached description of what the guest workload is that
> > is triggering the requirement for it, so we can check that
> > it makes sense to do so. (Mohamed mentions the Windows TPM
> > device, though I am still not sure what exactly is going on
> > there and whether emulating the access is the right approach
> > to it.)
> >
> For the TPM:
>
> TL;DR is that currently we have a workaround in QEMU that maps the page
> to the guest for direct read but traps writes. As it=E2=80=99s an MMIO ra=
nge,
> it relies on FEAT_S2FWB to keep things consistent and misbehaves on CPUs
> without it.
>
> Emulating ldp is enough to get rid of that hack and instead map the TPM
> as a regular device.
>
> ldp/stp are also used by recent macOS guests to the GICv2m...

This feels to me like something that would be better fixed
in the guest -- doing LDP/STP to hardware is just asking for
problems under a hypervisor, and there's no good reason to
be doing it in the first place. But being a bit more practical,
it is a good reason for having emulation of ldp/stp I guess.

-- PMM

