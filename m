Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E587C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 16:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scS9r-0006SD-Kp; Fri, 09 Aug 2024 12:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scS9j-00061Q-3p
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:07:58 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scS9f-0006MK-QJ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:07:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3687ea0521cso1567748f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723219669; x=1723824469; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqSPFHjD3td+vxIxqLFd2G/Ag3zTLuYYC83p3+RO8Dg=;
 b=yLCWAjwnRjIZUnBA4CZZ4AMe8Twwy5r8MF7pi7Xn5SxBkq3KrHw+Gc1Z+gPJLMz6ia
 OcjtR7u86klyzIpwxYyK7YSXeRKU9Ix6YCG939s9pSceq+IPvC91oSLNgpCNjSKoEEG0
 PBIcghmZWjLJeFwKZEkn+DolANKGp6Km2TCjA3RNxJ5gekssonH0l8sC3GP7caDnHL4x
 n3mRDZalpUp92K45Iu2PbyfZhWZa6qfU7s3Tlr/zoJxSfe/lTsqqnORM2X4KIHLmV00c
 ZkT4tUyLe6UbEMjG/7WbMtVyMheCExp4iH6RRKDZZRNz7p3ac7omsFtoPeMzq3Z0+eeA
 ZqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723219669; x=1723824469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqSPFHjD3td+vxIxqLFd2G/Ag3zTLuYYC83p3+RO8Dg=;
 b=jvMmTXeegLC0CO1Xsvj6srUIBuBly+MbQYNESc2PU5pGB9iisbC+zm5QAzqbSE5bk2
 uLNuxrmKW/4CiFjW9JydvQhXGlTPSN0ndPrhBds9DMIjXgLYcsq9g1mYneqnEp8JfEp/
 EHjx1E8/UrH2tlmod0HZnNMKDlm95uI8Fvtqrxn+zNsMvtTyvJUymgCNJqEHLmP22Rpz
 jaLWCdqZGlb6LaxypjVunaDM1iCzw9AZzdRTRxfXS/V+ml8efL3ZK2qLiGDindXuQh5c
 Y4razpDP+WDHceTAQQeCNTHV90RAwXDmyg8UBEK9ZqzCB16WUuan6dur9B1o0AzKO4FH
 XOWA==
X-Gm-Message-State: AOJu0YzZWECd5HeUtq2xp2vbvMXKVTFkqwFraF4/ehCdOGjyPvZ9fLm2
 Fz7bsTeZ9+k2zG4Z2EwMdq+T3vQJbVjC1PlHuYkDqksvaw7eJrCXsJiXRJOSJ/X2uH+Zrqg0tA5
 2C46vkSPOt1EJ7iIlZ3ILCp2n+uz9UCxUx9wXrFYpSvKfwgd+
X-Google-Smtp-Source: AGHT+IFDStPDSCeP9Mc2EB7Ua9V6tTvCmPOMQxkeE2sOmXvZy+BszwbXUFD6rmypwKzeDyYwaOy8dYw2lEl7ZIGJwF8=
X-Received: by 2002:a5d:680c:0:b0:367:4d9d:56a1 with SMTP id
 ffacd0b85a97d-36d5fd7eb0emr1744842f8f.45.1723219668868; Fri, 09 Aug 2024
 09:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
In-Reply-To: <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2024 17:07:31 +0100
Message-ID: <CAFEAcA9TzN-r0HV9wxhRw-QqLeUjGpfoicq+LbJ5XjbfA+dJLA@mail.gmail.com>
Subject: Re: [PULL 17/20] target/arm: Do memory type alignment check when
 translation disabled
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

On Sat, 25 May 2024 at 14:41, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 5. M=C3=A4rz 2024 13:52:34 UTC schrieb Peter Maydell <peter.maydell@li=
naro.org>:
> >From: Richard Henderson <richard.henderson@linaro.org>
> >
> >If translation is disabled, the default memory type is Device, which
> >requires alignment checking.  This is more optimally done early via
> >the MemOp given to the TCG memory operation.
> >
> >Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
> >Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >Message-id: 20240301204110.656742-6-richard.henderson@linaro.org
> >Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
> >Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Hi,
>
> This change causes an old 4.14.40 Linux kernel to panic on boot using the=
 sabrelite machine:
>
> [snip]
> Alignment trap: init (1) PC=3D0x76f1e3d4 Instr=3D0x14913004 Address=3D0x7=
6f34f3e FSR 0x001
> Alignment trap: init (1) PC=3D0x76f1e3d8 Instr=3D0x148c3004 Address=3D0x7=
e8492bd FSR 0x801
> Alignment trap: init (1) PC=3D0x76f0dab0 Instr=3D0x6823 Address=3D0x7e849=
fbb FSR 0x001
> Alignment trap: init (1) PC=3D0x76f0dab2 Instr=3D0x6864 Address=3D0x7e849=
fbf FSR 0x001
> scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI=
: 5
> fsl-asoc-card sound: ASoC: CODEC DAI sgtl5000 not registered
> imx-sgtl5000 sound: ASoC: CODEC DAI sgtl5000 not registered
> imx-sgtl5000 sound: snd_soc_register_card failed (-517)
> Alignment trap: init (1) PC=3D0x76eac95a Instr=3D0xf8dd5015 Address=3D0x7=
e849b05 FSR 0x001
> Alignment trap: not handling instruction f8dd5015 at [<76eac95a>]
> Unhandled fault: alignment exception (0x001) at 0x7e849b05
> pgd =3D 9c59c000
> [7e849b05] *pgd=3D2c552831, *pte=3D109eb34f, *ppte=3D109eb83f
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000007
>
> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=3D0=
x00000007

I think this is the same bug as reported in
https://gitlab.com/qemu-project/qemu/-/issues/2326
and which I've just sent a patchset for:
https://patchew.org/QEMU/20240809160430.1144805-1-peter.maydell@linaro.org/

(The problem was that we were looking at the wrong banked
SCTLR when running at Secure EL0.)

thanks
-- PMM

