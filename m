Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9000CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQV6i-0003Vo-SZ; Fri, 22 May 2026 15:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQV6g-0003VL-IM
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:00:27 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQV6e-0003I2-7A
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:00:25 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-63319183a49so2900791137.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779476422; cv=none;
 d=google.com; s=arc-20240605;
 b=SjZsC0rv0jqR3sM21X8I0F0uxXSQYKdWaQSYRMEBKZ4lSjyYi4Hb5L20RvBYmT3Jp5
 2B5A8QEA45aoD1QPMu15dlEeWztvYQUeL5/Uu0qlLBHPM/aTSpqEKQHKiqHoVzpNpM39
 m6Gw/BnvFzR7GeL6SK1EDE9tgN9Rfcu+Rx7Hu6mPleGEP2/qlpWLOT5HpvnIE6yKICuA
 1qVRp5A4oKl2cvEAzIWzXJZhC539IclV9JFh1iv9H2gsM8v6z/P1AK23WQQSWShG2msl
 QQrs1FuEpUPZzDRYvOKGUo2heKIPc+/ZcCRH975mildrabdv69MJ8Gj8bdI1f0ojnUM9
 iY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LJPeMxwkiPLkjOpP3U+cEXz9Tpfn/aQoOcSM8gtHfRs=;
 fh=GTUPsNBhrKhcIgApgfu77UrsCgak6ozDr4MrYCEd4bk=;
 b=Ie9r/66GvcuAbpOSOvih/90Tfvj0+V+mMasdKI39NLRnw8ovdR9S4XQ3eCaZJMYuaR
 ve8J3fLvyCJrcOXlUPzJtWKso/1OncJoTi+GBL9Pl6etm86BoqQNilNoE9X/xwhCji92
 oC0DZlTFqL90hiDelPUi0WcmR7pLzARe9IAa184mhFD7yH8eOFpPWhoX1PFeLdW6p7dX
 sOLnhcc6St2kVgyMdv61b9RK/wpEe3lWCPl2klQ3DZfK9UpyzBhlT8emJBKHwn7YseF8
 ZQVaGMo3Tj0pMMTzUpfVOYjm9rCqcapgj+/+OtSwy/AbqgxD7SR2QClMmeclNBFjo69U
 tOUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779476422; x=1780081222; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJPeMxwkiPLkjOpP3U+cEXz9Tpfn/aQoOcSM8gtHfRs=;
 b=Poyh0TVXeWB7AU3RNuM5oVi/R0qJNY4zvBcX6UojAzVD9sg30viBeOUE8/ckgBkj7C
 O9F25kBC3I2D0ibxuOCLXxbocH8uDcG0d7JOAXS35b6OfLg5Q05DyNDO/X0ml1fQTQqv
 joEMvgYTgMO8lySWMjTKg/KtOdrhmmgM0CaaggdYj5O1CGl/zF8dM3u4qFzG8dHx9lUV
 p1+w1S9XcSh8xfBtxezkLJu/fF/AYegFPE2jVIg/f0MUcvijoCrJME6hldXG9QDWkCcC
 SCWSsDOYE0kr7IQpiZICsWzNSv1lNWUhSH9twarQDg6eT7sCdhBq2PZr0JISVgVp2hsl
 uLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779476422; x=1780081222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LJPeMxwkiPLkjOpP3U+cEXz9Tpfn/aQoOcSM8gtHfRs=;
 b=Uvp0njfkzmP8GsJTYxySx1u0xoz9QEvWObg+VKe1Sr7lAe9d8ytKSi64YHHiCk+wGT
 xbLC62R/pRsugzpc7ZXlyB7o6c5BWyBqIC7dOAghQ0SlsoUf8bOrfnQrjXqrx/7eI2IQ
 HMLMOK9XdEMKDoaQX1oeucfORpah2uWumhbamSmlrxbKSccJE651DDDeQlulJc6t06oU
 v5UHx0RnWF0Asz8Xp7SG3u/2w5l1zXn1BnLMhN7HsstuyjftXnstOcYAAYDWJyaBv+Yo
 fYRtG2rGTSsuX3A1ByW0kx7ZQ9pdwBQpcXpKh1dF878pmF9IscTBh73lxxfqWCd2No3P
 hnaQ==
X-Gm-Message-State: AOJu0YwHYTAY+uP2l4x1Bu+UIjLGxzxH25HhtOjMbjpWghzxx5Nbzbu7
 cqakrT7sHIXg8HUmC3kA/yVPSEJXUwEuVtajjFJ/yc19zzWaZCTyu6KCiHdr5TfMr6NGY56KyuP
 s6s3amrDVv7kRheR+18bRaDal8p8IgQE=
X-Gm-Gg: Acq92OESA7SI7J12ZMYF8ryOGrhEFBz55jUf5MDuh+6XI+0uVq79ouz3f6V74pfHvo5
 4n8rCOGoC2zFsk6Hc5MOt8FoMSJj4AnGnpzj53H6PK85iMAriJydWfyv2R9+wQZXtbptPq7gpEm
 H+5/BntXZw17wNpufWTYWAqNZtFI9BR0u2n3XQPuOCcDAr9QXRRlofjTJlQYL46mzRTAkpA1lv7
 yMKJiJ9PW44agyn4av3VKsds2kjIrlpBOo1L0dzq8MIW6ZDo/GEt2DEH1/oCLxL+UN9LbklS8Jd
 SqiLd852vq9X/12f/LnXSYfoHwLpCT8d9IfwBNLGWFG2LXJ4mg/N1tqcAlrY1TWbzlu8xT1EfII
 9O9s=
X-Received: by 2002:a05:6102:15a0:b0:632:425e:85eb with SMTP id
 ada2fe7eead31-67c7f83b985mr2645037137.21.1779476422386; Fri, 22 May 2026
 12:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-20-fbf08e164830@gmail.com>
 <942c3ac5-9e27-4dca-9d56-02a19f9edd00@linaro.org>
In-Reply-To: <942c3ac5-9e27-4dca-9d56-02a19f9edd00@linaro.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:00:10 -0600
X-Gm-Features: AVHnY4L05i_kFaN9MwGLUoLisIWxirzALYJQnZPgb2mbAiHE6Qe8QNSDmc2P6CU
Message-ID: <CADvTj4qwzxKpJwj=188m0k1r6q=+5GTe5CjBAwHScwGx+0ozLg@mail.gmail.com>
Subject: Re: [PATCH v14 20/22] target/mips: decode Octeon CHORD and LLM COP2
 selectors
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=james.hilliard1@gmail.com; helo=mail-vs1-xe29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, May 22, 2026 at 9:40=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/21/26 22:20, James Hilliard wrote:
> > Add explicit decodetree entries and translator bindings for the Octeon
> > CHORD and sparse LLM COP2 selectors.  CHORD and LLM use their own COP2
> > selector window rather than the crypto engine windows covered by the
> > preceding decode patches.
> >
> > This completes the explicit COP2 selector coverage by adding the
> > remaining CHORD and LLM register and operation selectors.
> >
> > Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> >
> > ---
> > Changes v13 -> v14:
> >    - Leave the CP2_Undef fallback in the register-selector patch and ke=
ep
> >      this patch limited to CHORD/LLM selector additions.
> >
> > Changes v9 -> v10:
> >    - Split CHORD/LLM selector decode out of the monolithic Octeon COP2
> >      selector decode patch.
> >    - Kept sparse LLM operations helper-backed.
> > ---
> >   target/mips/tcg/octeon.decode      | 13 +++++++++++++
> >   target/mips/tcg/octeon_translate.c | 13 +++++++++++++
> >   2 files changed, 26 insertions(+)
>
> Not present in the documentation I have, but it looks ok.

I checked this more closely. The CN50XX/CN71XX manuals document RDHWR
$30 as ChOrd. The SDK and this series use the all-caps CHORD spelling
for the same local pending tag-switch bit. I do not find the legacy
DMFC2 0x0400 alias in the manuals.

Mainline Linux uses that same CHORD spelling for the RDHWR path:

https://github.com/torvalds/linux/blob/v7.0/arch/mips/include/asm/octeon/cv=
mx-pow.h#L1302-L1331

The LLM selector bank also appears to be SDK/kernel ABI rather than
public-manual material. Cavium SDK cvmx-asm.h defines the
0x0400/0x0401/0x0402/0x0404/0x0405 + 8*set LLM selectors, and
cvmx-llm.h uses those selectors for narrow/wide LLM accesses while
documenting the 36-bit data/xxor format. Mainline Linux's Octeon
context switch code also saves/restores LLM state through DMFC2/DMTC2
selectors 0x0402 and 0x040a:

https://github.com/torvalds/linux/blob/v7.0/arch/mips/kernel/octeon_switch.=
S#L111-L117
https://github.com/torvalds/linux/blob/v7.0/arch/mips/kernel/octeon_switch.=
S#L276-L280

So RDHWR $30 is the documented ChOrd/CHORD path, while the DMFC2 CHORD
alias and the LLM selector bank are SDK-visible compatibility
interfaces.

>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~

