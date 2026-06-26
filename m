Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA822CDE013
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3bs-0005lj-BW; Fri, 26 Jun 2026 06:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd3bm-0005lI-ED
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:16:26 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd3bk-0004ok-GT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:16:25 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-662dd616cdbso953812d50.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782468983; cv=none;
 d=google.com; s=arc-20260327;
 b=hHuAEeyUlY2BcNhqh5ULqU340foESwsWpZq7brlOJSpBJnp4wKEzSracF48vDYMckk
 VzLunAiPF9mr0awvCLqPdzDWO/3xPfUviSaziHKF7Boe4mqIK89ZWjs8RtpfgyZd1nt3
 KjRYOwPZjxIqskUj0utq+SRJG4xQFwMmP7EKqONTO4ttGaOXQPp9Twxf74SJkNV0s6Ss
 /JzdecIvU98ItMrHwIUlhL145fu5r25Zu8NLBFsRLtWS8f0BZpIAYXa/B6KePzcAAzVk
 TBhxuOHJY7u308w45d3MIzvQAF+k5JEAOcIox1NsPTXWp4HSbIx82lFe4JtrMsJUmn7y
 D9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uLH6Bg7iG99j8VqmS6X+55BGd7jMKKPuba13KM0DDg0=;
 fh=KNKF6X2+FYN9hQhGTutzNMceR82IcQPusagl/yicuJA=;
 b=cnliUyVA9qCvYTivNpmYF8XOxJz/diJ05ZrM5UyVCf50jHUcYRi923pFKCkcgRaJ54
 BZ4XCFXOESwGjw98th+QYYLPKL1XemUsIT77agBlYUHpfUBaJWKNbar8LOmX+iR/Kxd7
 RCelB2pzlqBOYyGvCu16KkKozbLUH3Og+8kFb997uTuuMldt1o7xfZpzgIfR74tB9nPp
 8V2IwNXa0lVHs2E9beHvf2usL7lw8J+IajEcUTmII663/z9mwL9YHh7sVuWrURDg8MCK
 p1rEI5VbTzWMncednsD82FIp0Umqc1FoW5VZOhLazRUwEnIdDtFUNPyBgVf4PVd09iuK
 LKNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782468983; x=1783073783; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLH6Bg7iG99j8VqmS6X+55BGd7jMKKPuba13KM0DDg0=;
 b=X3i908JMGIxvGk81xuCJ2+V4opa9OkqGGgdCPggiGmUr5GdkNY+A8BNMGl+mQIvUiw
 oku89cgGDncDrNy1lGUE32Se+MZ67DGgb38AN1vM8cgZHlZfL3JlXrDRpNEs22MHlwsi
 pccQwNHrbGGhY0YY9ro5rJE1jPEoRwMRI7xTEFTsQ1YRd6bcu0lmu5241BVZMdehWTD0
 apPkYt73XG2zFHoCIxGyip3vBGm201fjK48+eWF6gpRFdiVCdUm5S+g7J8kkwbQrI6oQ
 B9/6zKbCy5sfWiqRCSv4Wjl8nuPG71oNnFKb8iyCeM0BmF1oukxaeZ0anjML2k7x9BCi
 JbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782468983; x=1783073783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uLH6Bg7iG99j8VqmS6X+55BGd7jMKKPuba13KM0DDg0=;
 b=FxH32nBR7ag7M6e7u/lTsQRN8IfWo1WOvKObtmDj0nN7y9pnSuO8wTWrFJYRijeTvA
 EIbl8tzX9mn6kIOBckrua7J8u2QZNiXpJdPuaYWdqUWEPf2mti/MbulybbZW11H1P+6T
 aWTy0VsuuYSufQNLrCvcmLTaqYTNyMhJ6fQ824Mb3JIn68WCrTrFuDp9Rho2P5FxZP2e
 VjrU1oDQQxsPwf6gJNeLlxv4h5R2EmjdK+TRGp2UrwCL4c/YFz782NmGcd7YvxPerjKb
 9szEVL21rK8ciXvbsN205SbFtou3ul24sHhNwsX17+du4cUtC3dtf2o9FdXcFB2qGjT/
 TU6g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7kR3nRs33SvSxHPI4RHDPwYZWSsLV8OzypPne75sB0aqHRAgWCHBWtpVq7AbbavGgIV052C6YLCEe@nongnu.org
X-Gm-Message-State: AOJu0YwjRZUDQ1Lr7dc6nxIe33UyeoUAWA+6n3qgLAK5bJ5iYXKgQUvU
 J6wWYx+xUrFHjYOcMZYb506chPLq5V3wa77vRZ3aqLuEYYEwuQIGsIVZ+531NNbYo+lJUTuoqYR
 1Nr/NTaRCFBPFYPSOev/pgaZ/Eng8Ia7P8I3eGSYSjg==
X-Gm-Gg: AfdE7ckSVYF++y1zts6YNm8ictuGdmbtk4r2zFF029qiPwecL5iaqRECGlU6KaFuaxv
 cYfyM0v5TXcnjzcxMOchJegavCwhq/A134S87KNwf/47nkU8Uzb89Jgb62iRvBRvgdr1lDMmATB
 hKrAizi5T6yhBv4j/YHql3J9n88mdMvXoHw60bMsmSGqbFNcflMcwIH/ar6y/NWKS/gCn+yRqtu
 Jkk6w3PDVZt1vRMg4WXUKrAhNWAsSdg6x8JQAjqeYzvvwGUsWJe2wowu7Q4rAXxmRkMLvGx0DNd
 yibSvzAG8xB9BZ1RKGW3cTlWpsOvi3YHJ204SljaZUJDlt6xDT0CtNep
X-Received: by 2002:a05:690e:118a:b0:651:8d82:acc2 with SMTP id
 956f58d0204a3-6648837b980mr4887384d50.63.1782468982696; Fri, 26 Jun 2026
 03:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <87se69haxi.fsf@draig.linaro.org>
In-Reply-To: <87se69haxi.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 11:16:10 +0100
X-Gm-Features: AVVi8Cetq6nHRepOAX8D-37Ro_Ydf64NQ5JTLgO4S5AqcDOZKM27_OXcnE65fmc
Message-ID: <CAFEAcA9fR=iZ0tqk2xBQixrMdD-JJf6LZCLCArUwWZtQTW_UiA@mail.gmail.com>
Subject: Re: [PATCH 00/10] target/arm: Implement FEAT_SME_F8F16
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
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

On Fri, 26 Jun 2026 at 11:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > Another minor feature working toward SME2.2.
>
> This conflicts heavily with master - did a bunch of stuff get merged
> that broke it?

It'll be based on the F8F32 series that's not yet upstream
(it's in my target-arm.next queue).

-- PMM

