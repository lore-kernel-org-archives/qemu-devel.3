Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B52D2F02F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjbG-0002Oa-T2; Tue, 27 Jan 2026 08:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkjbC-0002KF-8H
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:59:18 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkjb9-0006iN-UF
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:59:17 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-78fdb90b670so50892537b3.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 05:59:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769522354; cv=none;
 d=google.com; s=arc-20240605;
 b=DFr2A9ljnflbczWBMgKb44hEmB2SoLbxYR0fBtTY+OJuXVjjrp1+7H0B+QBZdT+3m8
 bjH1BLTUzbO92Sb0PE/vMgOu1vw7sjfsJxY+dUILb4dkpBREMQcgzZtEMemSfXS064yc
 YSdbuVX1o662M8eH/AgT8PK36rPmVBKjWc5hd9g5y1thwsJyxbXBLzAKlJ0CqHdEORXO
 LgTDueoNwmuqT183miNLiARMF8lxWCuMAdbddjjjJiml36ZZh/sIB1qo5EQHSMC/E9ei
 LP6gVzD/zSZIr59vxzEnJ4hQTfEciv+x5G/EwC0P3kMCBYfclSN6BWChg0h0mjrSaIdS
 xBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TwPOtPesy3OkrxhaJXTOb4FSRtMZ+ZFV0uv5PUVLPW0=;
 fh=xY81o1QTnI2XKDfOt2g2HcXUXRE4KU2wXXSPt0G4hU4=;
 b=ZR8nWOUG7MCqbxbFQhISawn/CaX6a63NIViBnfwT6Rfd+4GWxf72DINdORfloM1sCJ
 s6Fb6hux/nTtOoy/SMFBuEEu1CdvOJj3CtfiV1GSFWZMJYhxhFOAM1RvIn+X7SvdHZ55
 y0nlQu9qQ/Jzv2gmpFeNiLG9oXefjqvwb6hn3W4quU+mdo3AkmW/vPM4JskDlB4SVMF2
 HnaZ2uxgBmdVSftMcTXUs15kjOIGVFu2m5uujJl5qNpmbxpBGF7h4pP8f3HxVof3YCTk
 cb5ySBpZ2yq1pRTKWnZpt5r1b+/PONGAahn92l5gY4WK9aTAL9MSAQJVEXDNu7Xmc9f7
 Voxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769522354; x=1770127154; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwPOtPesy3OkrxhaJXTOb4FSRtMZ+ZFV0uv5PUVLPW0=;
 b=QNqORIwii724HyYvSyvwFNfG6emYyKAfe8Xfc7QTQ17XiitjR4HVrQpaeI/Qsd5EYE
 7geHBi+WovMQey6EEOUlKvJjct+RArKwFe7knHc1qDo0fKxe4YO0EcEVH6CrEmPrN05Q
 XNfV126GDcdfIzlKSR/NP3uEt/VTDUtf/IIrnBy1IwbAqW8SUB9mFdhGtNTjjgN1BftS
 VNdhgVa2TcjnEVFcwHTsdo3NsfHpzMym85cJjsvMHwnV+pmeniw1//emeVsyDhrQhKEp
 m4ll6roMoQy8WQ8iiULpZF+PNIc3K+GyQzKcziTJlS9t60iMU36Nke4SXWvki1a6JA9f
 pFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769522354; x=1770127154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TwPOtPesy3OkrxhaJXTOb4FSRtMZ+ZFV0uv5PUVLPW0=;
 b=G0zY8H2L2ivDpq4yCgEgEIXybHrs/7tnPC4Z04qcwW+68U9yFmEID7PBBiO7ETHqvE
 GW9rfbkclnjRswh60qi38pqKODibtTUGB1828YyzDKHM/himTmZxxyYQS0wE9Op6aNJM
 T6gJ84Zd7Fplsn56p7vxutAXOQiUf25lcpggUr23hfAYooej2szP7Hr3SjCHLTGXREvx
 LGWDX9evd5YDXEHk78m2d82GCxzy9mdCLTrnGqmO8nU+IWUPXt8lsRYSqPIjEWy44xQU
 gypSSMBqpHO5En/rMWDGzbr2heLuoS92TYSe2ZsIepk4TLAHIXNkaUG7mUTU7oza4En/
 CIdA==
X-Gm-Message-State: AOJu0YwIqBCZ3uLmINcR0djeFXW9wbnXAQM5MS3qyOIauZRvtPgRTwVX
 H2MDtj+1Q+28W+pKrhBLtIPxwM8lpDBzgeP77NFfJFaWtF+g+PMPXjBS4OZ+zOf9j5l2gRm5lWv
 NeKGjBtUcjZWyzqwDJJBZLeOqkCnXOaLfnuMUmB0oDg==
X-Gm-Gg: AZuq6aItDKZ0S5YuezqipOVBSPWiXGsSaOVqDGum29qAkAf3o+9Ru9Ojsip6B3z+6FZ
 Ci438lzW1iMUeC4x80RL5YmJKYGRnd+oxeJ3U0ZodlxY1GKneR1CPkrt/N5SUFMBjYJUchBVmxd
 Jc30PeBJiAHWJceOGQjqlu5GDcWzNiRh6P1gL+V0fzyCuVivY1bOhLGX/m33XWVFU3nDK0AEDyt
 MwgzMVPZJK+f6fzcMvXG5+8LRvelRz5V+5nLEd6yzsIFVuqUl/zuZXQqCNyL2VJdOI7XoLXOUq5
 uiMD
X-Received: by 2002:a05:690c:6b03:b0:794:722c:3a6a with SMTP id
 00721157ae682-7947ac7f221mr13590957b3.51.1769522354491; Tue, 27 Jan 2026
 05:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20260127134207.3043703-1-alex.bennee@linaro.org>
In-Reply-To: <20260127134207.3043703-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 13:59:02 +0000
X-Gm-Features: AZwV_Qjjp44k0a9ov3ueNa5c1Xp-ppPwzE6raS7PaIpZ-CYPSYlAd5m4bysZ_PE
Message-ID: <CAFEAcA_Ftefzk8iigCVaB4sWCfcBnOp_7zpvT7gabQZRDaLMAA@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/system: update FEAT_BBML[12] references
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 27 Jan 2026 at 13:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> It looks like the features were renamed to include the levels at some
> point. To make it easier to match features up to the Arm ARM update to
> use the full name.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/system/arm/emulation.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rs=
t
> index 3f30ea5a30e..22b5b659aaf 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -26,7 +26,8 @@ the following architecture extensions:
>  - FEAT_ASID16 (16 bit ASID)
>  - FEAT_ASID2 (Concurrent use of two ASIDs)
>  - FEAT_ATS1A (Address Translation operations that ignore stage 1 permiss=
ions)
> -- FEAT_BBM at level 2 (Translation table break-before-make levels)
> +- FEAT_BBML1 at level 1 (Translation table break-before-make levels)
> +- FEAT_BBML2 at level 2 (Translation table break-before-make levels)

If we have the 1 and 2 in the FEAT name we don't need the "at level ..."
part, which was the old FEAT_BBM terminology. So, using the description
from the Arm ARM:

 - FEAT_BBML1 (Translation table break-before-make level 1)
 - FEAT_BBML2 (Translation table break-before-make level 2)

thanks
-- PMM

