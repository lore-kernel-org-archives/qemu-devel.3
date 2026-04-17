Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FE1F8DFEA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDenv-0001V8-HM; Fri, 17 Apr 2026 04:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDenu-0001Uv-2s
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:43:58 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDens-00012m-N7
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:43:57 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-652f220595fso456506d50.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 01:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776415435; cv=none;
 d=google.com; s=arc-20240605;
 b=gI4K34XodFsOT4HMUc5kozawKQ0H+zmf7wJvr4ey0762HgTze91jeG1cOHQ6CXkqnF
 Di9/+wmldn8YhclTfr/7N4W0YQd9OSi6B7POtiHMSPgQB208UGh66YxjZETmeV09FUOV
 474j9E8EcHrrlxMVnIefQMtmLrTLqJNb/XhSy582BLy1WclHF2kWZ54vsieaKqc/wEQY
 nvTt9jN5D+KpKbaVuvolUiJfrr2p7oCpB8PDUVuIAhBFSkyv02zlvWakb+WK4BaVJYiF
 zxtV97bN7ZcuRChRU0fVqJYGZRsgNJTGsDn8S9csfj7WjzMP999+hVlwE01Lo2bGdjiA
 LgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/813ie6XoJ0lr4BFbyLghmjpn3wZ8S+jGcW494Xq8Bo=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=kuTTVpABZmlDVgnJXYnwEQhxQ4r6F/SZnmY8xWLHCR+6J9KZ0zpnJO83OzLh873ovi
 SNujd0D3NuyJEzrUMIGEclr3ZKQdyra8gd0TC4hzsdh4gNvS/+4VHNZ2QUCOT9c4ttUe
 wHmz8yChIRxeoxqyc511psi0biwEAiE9BhgecTy0eeqGt3OWSt6Qv2xq0qOXw/MFf0D1
 SNxlk5Oo0qVJdtGkKIL+mfZ+4D3/izLAi+odnJ4di0FP1qRxkYhBVCpxHRpVneE+jxOF
 RMRtbSoqKwwWOKlaZWEK1BQUMq9tdVy4ijOxTHs9+9x9yeQEzaADJdKowCtAOg8EtPp7
 l3Lg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776415435; x=1777020235; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/813ie6XoJ0lr4BFbyLghmjpn3wZ8S+jGcW494Xq8Bo=;
 b=K/dp0/TCeM8VizCs77rFykciKhaZ+/b5o0DN76JIPKqdo1kgq8I8xNWufHvxZ5lbmQ
 sCztWuuqbsUf2WztvbHA00alu7kQ+PlwT9AHG4WLdm1ygFmTLuMp8QGDzFKKX+XtGYbm
 mAlO1Voaz1YDu/zFynwK2ebuQ+jjCeRiqXCZPJWNGumW4PPNfivvqMVH2dA39thLDwQz
 mXy2qUv0D/Ri4q0vx3gqMz8fkUVZW3dHMEPzEl+bbLfoZ5wF2r4peY5fLdAaHDpIEWdG
 p3zNiz7N2eIcquVclerJ65210JKN1uAAtPKFvoA5k4P9wJqIXXjlrSEAbyiTOuMrpZer
 a2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776415435; x=1777020235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/813ie6XoJ0lr4BFbyLghmjpn3wZ8S+jGcW494Xq8Bo=;
 b=M2PzNpEtx6w3UcJkW6AgFsjeCf319WMk/Eo3iMf9JON7oATXD9H6tvB0VYj+i0+/8d
 XBmp0mQvyFFKtyFiUsUCerhyGm9euGgg/keUv0RTwmaC/zeab6zta5ah/d0QujL+OHp8
 NyGE8f8TBlJ5D8zTIRwlnljeZW2Rk/QP7OMhVsSTv9Nvk6w6w1NnVTvnPDhQZWq8A4kP
 CIzNFa0kTf1ltSHLrrE6923eYdAZefbI67+fvDYXV2KsW3KcIZHkOr7qAKp00JN840nZ
 J35QCcCrWok/gvQc9g3BjkvwLMyBoIfIJkO3IkMWZDYeqMe/LWws+T2ZSyNKdYeRtrrA
 0nCw==
X-Gm-Message-State: AOJu0Yz6A5+ir8272DjnRSAyLABB5SK/Q7hDAj7AEUZMNxOUoCwHtk5t
 A0giQ8UrEXBdGiVOTGQbPLyZWHE6rg6i3W4OpwQrio8vX0ZxUZj1g5EJOx4kwJ7ZkSwwJKm2KH3
 D1q3ipeY5qcgrvx311jw/UIXdh5XCAtizo8A6eIvYvNOd3bPdyBcltFc=
X-Gm-Gg: AeBDievt8boARPfCa+dnA3RtUTc99NnxIqx06AzIxto65+K3DqSt8hFh7byR3y+jxx8
 IiH5TUTnlXHbWq7huftbeV0zjZHt/iRKSoiOAsyF0wdC5TVkrtaOSFpbLMGKKp46vTPgWqaoRB/
 wosT1iL/JW673fl9KuyWfsYD/UZQD6ZRJVAogAox9HkOTbluUSx4BtKs/GrWy3wMgwytjHiC+vE
 z/btR01pTQ+9drJoTZRAq2v6T0XOO3GYjuf8DG+Cd1ux9a4j4G1LWPn6aXtoAqAlnO3lxLA2Gc4
 q6+pxXLWq080IMIknU/zqPHc2G95DI3ozmZq4iS4bjDq5Y7Pnr/ynqMI9MqXxKZNI8rW7P7BdCX
 4HH5ZhRkGl4yO
X-Received: by 2002:a05:690e:12c7:b0:651:b962:bc22 with SMTP id
 956f58d0204a3-65310abe2dbmr1722782d50.63.1776415435204; Fri, 17 Apr 2026
 01:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260416-jmac-feat_rme_gdi-v1-0-d9fa0781ed58@linaro.org>
 <20260416-jmac-feat_rme_gdi-v1-1-d9fa0781ed58@linaro.org>
 <f68c53a0-1ea0-4265-9fe6-8b726cca7029@linaro.org>
In-Reply-To: <f68c53a0-1ea0-4265-9fe6-8b726cca7029@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2026 09:43:43 +0100
X-Gm-Features: AQROBzASgnXMeinJivqbhiG5liuXkmNnhFSET7qIhb0ygkKroQmNRckKLcGlE5c
Message-ID: <CAFEAcA9=DCPKkhUDohxW0d3JmPnmSWM5UC9d5opLVZoGc1T-KA@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/arm/cpu-features.c: Add RMEGDI to AA64MMFR4
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 16 Apr 2026 at 23:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/16/26 21:12, Jim MacArthur wrote:
> > Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> > ---
> >   target/arm/cpu-features.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> > index b683c9551a..3f2a9a0c36 100644
> > --- a/target/arm/cpu-features.h
> > +++ b/target/arm/cpu-features.h
> > @@ -348,6 +348,7 @@ FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
> >
> >   FIELD(ID_AA64MMFR4, ASID2, 8, 4)
> >   FIELD(ID_AA64MMFR4, E2H0, 24, 4)
> > +FIELD(ID_AA64MMFR4, RMEGDI, 28, 4)
> >
> >   FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
> >   FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
> >
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> It's often worthwhile to simply sync the entire register with the docs.
> The current M.a.a document has 10 fields here.

FYI, as of last week the current version of the Arm ARM is M.b :-)

-- PMM

