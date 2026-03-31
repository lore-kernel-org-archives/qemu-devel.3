Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9292710F92E3
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7c31-0003po-JQ; Tue, 31 Mar 2026 12:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7c2w-0003pF-Mw
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:34:31 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7c2u-0006cM-9x
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:34:30 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ef161129bso7394531d50.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 09:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774974867; cv=none;
 d=google.com; s=arc-20240605;
 b=RLf+k1Kltmp3wBjifKgMYgU948SZk2j8OqkfUFVhLcBFg4azGrsYf1X1RazApx5/+g
 GaxRh5uJVh1il4OtkLDHWw7Et1NnfNdob7mRZ+rCgtZ4i4E7JC8Xsly4HzbU0pHRt+E0
 p36TxH2I+KL2im7w1dD6dKKSOToV0leGABZzvG8/mD3rQCu9UknM2Ul93LiNPbeHoHDK
 a8NbxZojlG+fgPJ1UIu0MnYPVXkPtGXjbYKi2E9PFVfKmgKcS/r5DP7AaOdBHBt1u/cB
 sWwtBtR+eW1CotsFPXEHXYQsxULF1SfcRs6Xl1NiIKddkLJ3Yhv2Y24SIFIOlC06eplm
 dmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bu+p+CnnNHaTFVlmDWcLVsqTAapaTGcXyGljBVztV6U=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=DgIMpk5m/UstWBeS+Mek48Nbm/d05LDZrk9kUKq11uk1FxBo82JK+SBAHwLHtIa/iq
 /XJgDX+xYSolgO5l7nlQA45FU1Yr4M1BYQ4oNGKmppzR7G9AcwhiXGeMGGBpuxDB/W8l
 0sA1NeSN07BtyyEdXgWd39VtIRRcMf9AnZPw/HA0SXW6IW/rD+5VQraADqLkD1fnDzdQ
 AWlaqytgfoPdETySeZMJrWrgxQJ21YTqjQ49a//X/+8kqsFzqI2UP2vaZHRZTIQVJ5OW
 c6xDWZA+4nLx1vGbEPZ3MSHsgpW+qsuiGs884Rg0YC2ZPqtvmT2eOOgUnfLm42oY+yyH
 UIng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774974867; x=1775579667; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bu+p+CnnNHaTFVlmDWcLVsqTAapaTGcXyGljBVztV6U=;
 b=A7g2ec0AXw9RvgS32tE4Lv7oyv39UMxdn+m8MSoI4AIt0Sp2lgqSIRh+hXEv1mHG1B
 JllkHJol2s+46AQOC7LhxmY70pQQBmZewJ3cCB7lbiivHr28so+Z90/rTpi++UYDcwPs
 HmZJM5dkdO3UfT17iaDzw+x3zxm1szaIsLcgte72EVByH/2kRb9zpTxJG37vCv56zLhS
 9Fh7afBy3cXphpC0W2P9t0UPlJbHdYVSINequGWJxr9A99fxXBcfpUPRJT5slKo2iBtv
 VW6T4q+xUEkTgxrhRcfuFP4wC3ixnX5FmgVsPdNwhpxPmtHGjb0PyOE249tUlnLhMmJB
 6a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774974867; x=1775579667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bu+p+CnnNHaTFVlmDWcLVsqTAapaTGcXyGljBVztV6U=;
 b=qAErpcSQqg6KNttB0QLRiWG+C/ecAZFiNXt1b2yPD7rGS/OGdjDyHuZz2PjxZ4CUbw
 QBTqK2Kb9lFkVX9Wa6zBtO0SqI1RKrOb3Zbw7rinQvSjzRJiOSZ3ucqmcVQ/nJlHrZHr
 v8M/qBAHfp//dik0pZdCGbBw56Od/yYmOt/eNDvbHu7RTuRtoIbivslKv7+d+aRO02bU
 DfrekuTvKLV4DNhI9iIpa6bGNFpZ6rdB6OtMw0amCBcFwniJVQCqBKJeE073oRX4u0x2
 qGvLQCxPs+68094gx4V1TmtA/CyKi1IUuj/uBdvMPa/yScJk+jJl+FQoIOALDJMLsNvC
 xvSg==
X-Gm-Message-State: AOJu0YzSOxsprROqgnp09uBiARbk/gBeSKHqGQ/JWnGMuIlAE7hdhgzY
 wviWLtJOS7ciyDykEmpuOo08UIynqd99zSbwei1GTUpybPiGw/EslbzQDY1iJARWRYB3HOnr5X/
 8vihka4Xjj8jwfPodm94y7dCDTldslZuPx7Own7OWhpsHSDLPm1qP5wI=
X-Gm-Gg: ATEYQzzlnyBMkr8V3BpQRuH+TcfB/8XBPt7on+gVsVfJMl2nN9UFcfexKNWQQkxOPOX
 hwCli7ob9KtJmTBFK7k7lxUSuBwBi1m7flXbxm0SquJqV623cKiRYNqxzRFWHT/eNdiShgntaP9
 z6ik4sd3tk133j0NHbZ0hqbang6EOUUgKyIz6hnSGD8g2pW78iEMPTwbo3BoIG9r6HTYMGEO9SV
 WEWVFyTnXGR27nQ+GjXrLjNQpmyu7ZJWhe7E2ByO1orBUd0luUCd4anGPv4PiyM7ix2O6glEbkB
 QCLdC2OIh8AGDKtG52A9JN/oXumvWwhGSQsn1Z0FsM3rr3uYQc1S+NtFoSXLITqcwSc=
X-Received: by 2002:a05:690e:11c8:b0:650:1c35:6f40 with SMTP id
 956f58d0204a3-6501c35bc21mr8328371d50.0.1774974866931; Tue, 31 Mar 2026
 09:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260331131514.21152-1-philmd@linaro.org>
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 17:34:14 +0100
X-Gm-Features: AQROBzBNrosDSvqPTs2wqnNSRMqPJqEAHI1TIstoObEPhNap7vvtd567Ib5tOEU
Message-ID: <CAFEAcA9XaPkT5qKJBegDnyN1BuZo=wMi0WHpF9Ap8xTqjiQT3Q@mail.gmail.com>
Subject: Re: [PULL 00/11] Misc HW patches for 2026-03-31
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 31 Mar 2026 at 14:15, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 49ea0100202fe448be1d0f3ea5384cd51b5e6a=
58:
>
>   Merge tag 'migration-20260330-pull-request' of https://gitlab.com/faros=
as/qemu into staging (2026-03-31 09:39:52 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20260331
>
> for you to fetch changes up to a4d5cfe3eed909c81b19c73309dd44a0262d59c7:
>
>   MAINTAINERS: fix OSUOSL typo (2026-03-31 15:12:45 +0200)
>
> ----------------------------------------------------------------
> Misc HW patches
>
> Few fixes and MAINTAINERS updates.
>
> ----------------------------------------------------------------
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

