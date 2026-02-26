Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04D5FC5935
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 11:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZoz-00082Y-Lt; Thu, 26 Feb 2026 06:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvZox-000827-EP
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:46:19 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvZov-0003Iz-UG
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:46:19 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64c9c8f8783so759870d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 03:46:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772106376; cv=none;
 d=google.com; s=arc-20240605;
 b=H8TMS4oclHsuYYgdtauTHMPyv00Hrig9aGrusAQ6OkBQ869GZIDyaLfBcjURLxtgCb
 JZKi9lAjF0UhJ0+GtNLb0KYLYpoaN1tTteNF076rPqesSlUAf0lSeKy82eaI8ntrk/gX
 Hqn3uZxVSFO5bkY3VlLxGnWQxElKNlHZSvg2peJvSEAxP5vAIKYGL7o9BL4jL1vbFuHJ
 PSDBPELD6eh5P+RfCmXkNhbHDuxafGISi86J1E0BxnxqPRFMbfEGuBSVaaAvPJsYH9I7
 CtaNlZu+5niuqmye2PRyrwpYw5nHVGpGiBdX6P+2meN4uBw3MMgZMEBqAP5fzoe+q7zF
 BxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/Aez1Kdnth4y80iFJd/7PoGi4+eP+jSI8m9FRnz1iqs=;
 fh=/n3FpJxKRtl5JzCJ4Z6i9nMvkJ/dhHpPbEgkIrjVKew=;
 b=iLXQeg44Ojz5yqTjQJMoJfrI5m3mX2z55op33Dq0K7DzuofUIcP06F69NJYDiIntoZ
 goPSS9Up/bX9KyErOvQXcR7N+HLqBX9k0msRz8LC5U188kw/6tpk6IAQp9x1yJENH6Je
 c/c5KyZ1URNZB9Os13poHLxu0np8vYL7rkLWql6Nx01VROatzzTBxt3TSqIecntDEoCO
 Xg7rZZU5wJRZ6PLxzlqRQzZs1s8VfjkzaQedWwfYx0gcX85Xt6hqtEaNZBLkaTbTXbZZ
 mpCyvbgS/hECq1TJ5idIXfISrNkn66Th3x/OVmOhH75WWMV9pHRzRU1w0Ydrs7Nlalho
 NJqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772106376; x=1772711176; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Aez1Kdnth4y80iFJd/7PoGi4+eP+jSI8m9FRnz1iqs=;
 b=t1+65Qj5ssf9pVORD9HadU9JSZ066p92YE5r+XBNf/iWJYnB0MzGeBBnel9dIyKVMe
 972/zi+rUAINN3+L4O54i58SXceluO11PzSsFGgfsecwuz2sHFlKHn2FTrfqUHKFqX/H
 x/XgoVO4PESRieGTEhAmUp/g34Fsxf5q9q8Sx4nHuLn7lQiCWeEihgHa4bLhlLdn1oZC
 RYTXSTpTbzpOpCLykrQaW1jQFTgY+zLeR45SGS6tiymy3cNxQp0vmhmZtgfZEKgE0Rt0
 0PXpHOu/VM+pPgQtY3ADcl1dXQYdfx6YyLPMpoyMHMQ09TAp6J8m4z4tTJSXWpgQ2pJy
 sgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772106376; x=1772711176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Aez1Kdnth4y80iFJd/7PoGi4+eP+jSI8m9FRnz1iqs=;
 b=SqXdHUPinLZy3g9yDXmc1dGBjjK6QrNGgFnasT5gZDsXhkjf4ngQjKRKMQ48b0rYM5
 MA6XcMUy/OWKxTNkJZJfGxAZH0Z6HSZT+hsPmQexh1ZFeuaM/9NkT7H6octlcvnxAPmx
 PnKZzPuhhhoKj19QSK1HGFS6txzBK4eEhXiNR65hZACmkCu9sVuIblGrS/N6iYCxOAM6
 eErgMLZ76Nyq2KrgEcTVv6CwRzGG/tkn3OFxRYXAELu79BOCDlaFJWI2swFjPWSFom+V
 OplPcLtbUH0Ntoa7bCVw/zyzn0qI92vSA5DwPzV+OTmbv1EnRQYWKt5gohdGnhXQirNp
 IqaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuFtCyIbvFZ172jDYWlp+2+/ai6l+2u65jOqjHpEfJKEEuO74iPpn7tdLAVbYMc4QFNMnSF5UnNIcm@nongnu.org
X-Gm-Message-State: AOJu0Yys2DvWL7v7CzJ6c7MRiJNzXM2OM2pUx4Q6PqT3nMosRYysXv5K
 Q4nZhqzuyWBZf20KfJN+Q62xX3QQPk4DJyvMNJk+kBEAejhRfqfq7vo9Fqmqd0KKmnQMoP18rN6
 y71CERDqZnQtOYKUtFv5JVmdBX4v/qUATwxbPK6u8Rw==
X-Gm-Gg: ATEYQzwGH+v0evOuN7dsxgngwSFHKlBG0v1fTurleB8pwRblSXmWtO1zK2kFv59DXcJ
 KlVB51944ZFA2l5bZRfZ8e/TZ4tspbvjhOGjxg3Y/WuhsvNvfsEdMalhixpGiJ/MV9y3PL8WG4g
 5PSV7Y5C9OY/uxnMyQ8lFGfoxBIwT6woun+mucqJXMklKQurrA2G/bXjDYA7J8ZIq68RdbPG+tE
 peRPG20NRUXBwS2DliDDuQ48s3PQ+8BmUlcS6AwE+zb7d35+7VEdEivrVgJc9FW8MhFx6lv6fnC
 G6Y+VhgqYVGCS6OuXwigHThtrd5cXdG3gfQ/e7DI7ucjFP2ltAEKNxcmyqf0MmsR5OU=
X-Received: by 2002:a05:690e:16db:b0:64a:e1e3:77d4 with SMTP id
 956f58d0204a3-64cb6f13152mr1285500d50.23.1772106376469; Thu, 26 Feb 2026
 03:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-2-peter.maydell@linaro.org>
 <de487ce6-8e8d-4f30-b4d7-cd55c488f36b@tls.msk.ru>
In-Reply-To: <de487ce6-8e8d-4f30-b4d7-cd55c488f36b@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 11:46:05 +0000
X-Gm-Features: AaiRm52bRuia-bcPT0VVSoWgrAnv7t4-xFfv_xOoRi3lvqE-HZA5ImAvwtUc9sU
Message-ID: <CAFEAcA8OPk=ufv7y3NjS1hAT46Dz5uZrS5NHhqVLAvE7Nihhdw@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] target/arm: Account for SME in
 aarch64_sve_narrow_vq() assertion
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Sat, 21 Feb 2026 at 07:14, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 02.02.2026 16:33, Peter Maydell wrote:
> > In aarch64_sve_narrow_vq() we assert that the new VQ is within
> > the maximum supported range for the CPU. We forgot to update
> > this to account for SME, which might have a different maximum.
> >
> > Update the assert to permit any VQ which is valid for either
> > SVE or SME.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> > CC stable on this one, because it might also be a problem for
> > a CPU with both SME and SVE but where the SVE max VL is less
> > than the SME max VL.
>
> Hi!
>
> I suppose this one makes sense for 10.0.x (LTS) series too. There,
> I had to cherry-pick another change for this one to work, -
> v10.0.0-1910-gc48d0471be "target/arm: Introduce ARMCPU.sme_max_vq" -
> it appears to be harmless for 10.0.x and makes this fix to work there.
>
> Please let me know if I should've resolved this in some different
> way, for example not picking up this change for 10.0.x :)
>
> The result are the topmost 2 commits at
> https://gitlab.com/mjt0k/qemu/-/commits/05271d6e00894ef47267133dedd6a69c2=
a3147a5

Yes, I think that's OK and it's reasonable to do this backport.
The combined 2 changes are at least safe, because the MAX()
means we're relaxing the assertion so it fires less often.

-- PMM

