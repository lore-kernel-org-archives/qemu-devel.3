Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA8FC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62vL-0003tm-L6; Mon, 14 Sep 2026 05:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62vH-0003op-EA
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:24:24 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62vF-0007Fb-Ry
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:24:23 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66bd7857841so2714246d50.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789377860; cv=none;
 d=google.com; s=arc-20260327;
 b=lGAFbIWD+69OSm0hqAjHpHGA+9RqSZ9QOvO7srJ7Gg7czEFNw4no7HDzQ0LMemajlE
 2QrdMNRi5k0YTfwpeza9PyKigdLQ+mbh8kDRmKdVEmixNw+Shn/61WzkGreGqFLa+pCB
 AW0vMkV3so+6mr0I1JfDEGOMcXs1i8Kr8q/gU+PYG44pJP7g+O2zaeBKioIj0vFdGhzY
 JtZQkIkOj+/8qFMUNz8MhSRy8cC08QZRWJ4Ipxi2bU7JRhPsaa4xbcUeXflV1HcQ0RTa
 V5l5Js/KeGc5bjcKtzrsrxyyWhIoqoBczuxIsh8QTGJHUsbBtknMutap006bv+jJQHbU
 A1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S0jGCMEOwyERVB/Q6xGZYgF8vtoajFbOFCS95ew2TQw=;
 fh=V4/Fk53ndankTtc1WBGT96/wJD2tS50dQDvAWjyR/MM=;
 b=qYek2X/6z31bWn1aQDyVgISnUkIg7UAHGoWdtcrlomk8BECrUL6WRHDfWi2tEfobhV
 vRG/TZZsBeDwUjYmEdRxwyGd99LyO1z+XAIOhU1D4Vtr/6PMQtOskodfxYMRvSlFm/vo
 JcHbo97gcEe6rbAQSb70LNAF9APEJ/gCYu8DfiYyyiAJDkSHOwyjKEmJbO1mMb8H4AKj
 +v5y7XTPJ+inIXtBd5kwKLCEaA8ipeagkgMhzu6l1IvP1gs6IpwGx+dENOQUjhyEdnXL
 QG2TzVRRb2htL13lK0q6Q+ebf+OU7mSSKdg4MHToJCpzcGM004SNocApwIdZEi7y9e8t
 lvwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789377860; x=1789982660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S0jGCMEOwyERVB/Q6xGZYgF8vtoajFbOFCS95ew2TQw=;
 b=vRSDUgICPynlM+LcZv+fANZVsdaJVoErxpItmRDw8tEagUj4EnBTHXaMvPBCzHPDo6
 hkfj6NBwdG0s2yU+v0bNKoanVQuJdQJNfuTu9EbEZXMx7q9dXo/VQan4ZE1sKMDQ2rve
 jcbJvcJt5RIujcRNtRFcTCH7YA1bRL6WVdaqlynDYuFMAZrXM5+6Df7gafe9vX+eMoXT
 lcmVMP6cBk2wHYPuVbuTLnYaZujBq3Tnz8hYw5bali2y5FAGnQ86JW4g9kLz9bW62tIa
 kcUPxdk0PNL787f5yBU0bsXTU3qnUJZ001HbGs66HtFx+LaB2alQ/gUfYbVJCCF1iuSt
 huVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377860; x=1789982660;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S0jGCMEOwyERVB/Q6xGZYgF8vtoajFbOFCS95ew2TQw=;
 b=Nhbhgaam4y1VBqVTNnhPNS5l9J+dr1sT1PAX39e8lojk97EXt1CHbLHMcii5quRBsA
 BcBXFJECQo5wj8klL43iFcPKMzOe7+uZOTLpnbNLExNJ1Ojsd7uURIei9aZa5p3JIXnT
 UVAQWcB3/b+9g5hkduq5/ghejjU5zQJVkg2FOBS6vb7AzaBPkjK0/JIrKcY2BhJ0X6xZ
 tFcEup3X17sr2YKqKR2ggBBvLxzr7iVFeDGSMniOEQofPhF/5WgElhl/RduSouOxf9iB
 nhxLzyYHv9o73hmNJlMaQjaN6sTdOT3rfNpYCsVLbJIzvL90AOEkD5QgplouvR7xUXbM
 k1TA==
X-Gm-Message-State: AFuF++m3IvkpkYgrZ4l4U21H5vWM0vHHsf8zrSf21X00KXOoOARQYrI8
 nV8cWJooCkcBZPSD9zVqNtLQvfbaqoi3RtEuFnH4s6drdq49Jvl4IFeWeKPmGxC/dJhHzyWBAuL
 vhXwRMmnPXfL664NbfnTtN2QjNGvxoVGUoydsHYzUyA==
X-Gm-Gg: AYBFou3eoek0RBDK/zNk7sMekW7vdC1zPlQPZ8o8N+YCAtj3XxLc0pY7hVezwzcUvk7
 P7CFvYTwy0vCdlWpxv+gul2o5SkO4iVi2iXAY5U7bTJTbS/TDzfTRaYqDuG1C2WrG9Dkv6JIuiH
 CQBmJ6yYJA0Z0XbllKVRu5vHcws21VGwAeS40T/rRONJE+kIBLehMjMzV3/nUYmQK80R15mQ6VX
 zr/+L4+ryoT95Ai3qXN0OozDxjgisHRzqbSH1ref5r6v3exatyeDqWloQNZt1NLeY7staCi8NmT
 OUHS8ab11cJZIFQ81j6R8VfpljQIlq9y8NzdhqGaC80ImJc8uIBlFacdg85pdjJYz9JgvHryKSX
 eFUgMYi6KLpjMuyt9GitvznQFYY5wGlB8lilcboUhFTmNHssbsFo=
X-Received: by 2002:a05:690e:43c2:b0:671:1bdd:899 with SMTP id
 956f58d0204a3-6714dfca922mr163710d50.13.1789377860361; Mon, 14 Sep 2026
 02:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260902165956.582901-1-alex.bennee@linaro.org>
In-Reply-To: <20260902165956.582901-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 10:24:08 +0100
X-Gm-Features: AcwNN1ULYW3B3qu_DEXBe3GgXmkfVuKpbMMw76NrNQQMKv1auyBqB0MGiCPo2o8
Message-ID: <CAFEAcA-FpLppmxP3bTnPhyz2b2=KQHQkTaw3LNyc482=TEV8QA@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart: Accept character input upon RDR
 read
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "open list:STM32L4x5 SoC Family" <qemu-arm@nongnu.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 2 Sept 2026 at 18:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Looking through existing serial devices this seems to be a common
> pattern so it makes sense to me this is the right fix and matches the
> API description.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4389
> Reported-by: Jan Brittenson (@bson)
> Suggested-by: Jan Brittenson (@bson)
> AI-used-for: fetch issue, apply proposed patch, verify build and qtests
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

