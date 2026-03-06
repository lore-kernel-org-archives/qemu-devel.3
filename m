Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE153F0182B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTxz-0002SU-5T; Fri, 06 Mar 2026 07:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTxp-0001vP-Mg
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:07:33 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTxm-0005sf-HS
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:07:29 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7986d231b3cso119504897b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772798844; cv=none;
 d=google.com; s=arc-20240605;
 b=fZwmS8um50n+UtdzYIoww8YEP3gC1YySI1BsXzEwsEqPFvT/rlwHic/SoP19CIKKcv
 g/wus3wsLjmG0rPCejlBe5RaA5XY/QpbpNmORU4atHS1rZEb86LIv14H5/aGDOt9b0n9
 sqAX5hc2AiRez/3vDK+yS+LJ6yb2lGZKdY/9Q+5eLk/jo7adRPKtAGxnFih4iUrIgDfw
 kEpEWIyXFfYHcR+cdxoczhMnP8pSSLQmep+5AjbM3GRiEISqlhXUJyjo7P6k2SBPTl2m
 +xzBDBFBcpZLxiY1F+DuI2342TYzH6wJJWsXEdCtX+reMLDoGJWQoQOhsdo8TSBY+DBT
 9FUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZRrZAUIqukQp1PtBABZb0rugG5yL8v3lsgHnAX6YP3M=;
 fh=+8Y1EIR8cKOiuPDhSRnpCIhx4gb0A0nwySZFFPdreKQ=;
 b=LMuXgz1qCBDhzvHTd+8KzUuT1Iy75vWtEQamUsQguvY8RKov9yKFOnuhn0b4gKAhFu
 7hIcarPwVf2WWBy8RgH17/ls1gY/CqF3Pkx7T86Mccuf6IBRk2T0MaUBbLCW0qHdCVL6
 SY7WZ8/Kd0KExrWQjoVXr5UNqWUHPBjNCN+rEkkxGkGYGBXBSZa3i6rhgjs/81FHvCBR
 PJkBYgAx+gKI34Xn9mRI22V4vo0E0Nc3Q4YVD0mk3KGFUWy7ZLfKgNMfNo64RHFRzgMB
 yBLIPPnFuXizKhIw2Uo5CyqkQpXTgzWcX8+9cyeVCAC4FELQtTxCVltS6qoiy1F38q6M
 ttvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772798844; x=1773403644; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRrZAUIqukQp1PtBABZb0rugG5yL8v3lsgHnAX6YP3M=;
 b=tOcptHL/u5sGoZm0fJ2IkMyoVVfio6dz3sP4BQgJqx6H0JNcU08vAkedjmfkJBqv/Y
 1PORjy0IAF/1RR/6u0/7wTe84K43hyDaF+iTLREVtfhIDKveUfrGLuZFxEA04AKA6+Dy
 OocE5fyE/eleOxy1Ypkd6fMxTHd/PgYoNvqm61pEwaKlqN3wywsVh9dVkZ/4QMzDP+Dj
 9l4AytsYSHqDooKud6860DpJKMVskwaeULw85ecYd2rjJFKBVCgRoDJ0yHCpwXy2bl63
 0MJau2Gb2ObuyY9qfoeWTzgIdyJ9fP0U4AScGnp/nKAZ+8mI5ywWZGAQAmJ8c9gLffRP
 a0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772798844; x=1773403644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRrZAUIqukQp1PtBABZb0rugG5yL8v3lsgHnAX6YP3M=;
 b=MtGure414a2xB4KAMFMb+rttgJGCRGKwYTRVFL/JRNa2S6GJ7cU0ZjAyj+UkUwz6jg
 gdrYS/WRhlP4WR+apeG+ylxgCcRb6DnV2Xh8PRoQxBKBUbX1KcZO0IekyL9QT3BzBahd
 ZjAIeysVjzvslR05wsG6c/TH+tRnjUjRX1sMCrg+KttTYq9t1hFJKdHdbrqVrdPqAjKA
 TdcRH+CZlNYscHwNBIbm0VUnObOty1neqNzLKoW6b1t8XOPcfSHsNjwFJOv3ELL9Y48x
 0ya4GTqfXfHww+UoXGDDhz6uytCSE8cCzUn3Kee2Q/fFx01Fy8I6rvLPWIbf34XuJ2W1
 N9Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl6+3ec7yIfuYAWGxuDpeT+CzN5iy0Pv6gMqZNCE/KjnFiauAd1szbShw1kkgxrykF4/6U4OgXlRPd@nongnu.org
X-Gm-Message-State: AOJu0Yx9n0+MRthTsPFP0aFpldQHLfjbosIi6vtoe7AXOgKOWx5IukFO
 2MYOEaYj0FsdoFy8/026AB78jVJmpnPO7kBvIyHUl4uVDSuU5sWjixFMKFpzQXlkMSxgx8h56XE
 C0FWfYgHewWez8bHmBe7gyqg20AmwkU9H6Ft+y24yHA==
X-Gm-Gg: ATEYQzwZrFg2QbV4PheNjKCudLZ1Jk1SPVusbzp4HDThoohR0ZB4QmTKokp5+MquLUl
 WeLQFyuX6BiYq+WRvn5aESHaDN3QQeTXta0UCmLRL7qiEEIWb8Z3tZXMyqj07Bghf24BmnASLRt
 KWMSjIBPJJbeZgh/UnmuH/q99ofw1zyPHIXHkzkEeVRBa60q2LeVYqq9KpI93RFdalRlFN2+hcJ
 LvRaBHY029ggLumA3chX0Dkmv0yy91goKaRcAjtLlxOGRVg1KQEVqCInO2UmqmlxNCSmZ1Ie7kt
 LPxVHFTRDUFVk+p4bBw7aJ37p//XCZeWQCr0gwTa9E0BJHT/8VR/VBa8IsVjHduMvFw=
X-Received: by 2002:a05:690e:1482:b0:64c:cfae:a9c4 with SMTP id
 956f58d0204a3-64d070f28f9mr4766672d50.15.1772798844429; Fri, 06 Mar 2026
 04:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
 <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
 <CAFEAcA8zTkc4pyHQKoDkTMhGPLQmxBaJS3bZiGRrPgux3rDLzw@mail.gmail.com>
 <CAAjaMXbXdrW9N1xLMPxL9OmjLqti6A3rqAmYipu6OkdBY8JPNQ@mail.gmail.com>
 <CAFEAcA_MuZH8d=Z=NfrNQ78k+Kv9mSx+=DLLt8AxZeEjccN8yw@mail.gmail.com>
 <CAAjaMXbq9A1NCO4jnF4aSL0XM2pzHsPsPyWfmqSCg_+2ZQpEHA@mail.gmail.com>
 <35FDE44D-63E2-426E-912C-6EB6CDA52116@unpredictable.fr>
 <CAFEAcA-Zgq43KW9EC-pteOqxHcZg==GE=1TAURZP-DGRh3OoHQ@mail.gmail.com>
 <CAAjaMXa3h1abx=-ijZqf13ku-T=9+eV+XK9g85kGwxeRB-on1g@mail.gmail.com>
In-Reply-To: <CAAjaMXa3h1abx=-ijZqf13ku-T=9+eV+XK9g85kGwxeRB-on1g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 12:07:12 +0000
X-Gm-Features: AaiRm52cfi6ei5UfM06eU8s_-9mpRBlboYrAo3er_JHd2j4n6pvL5u63Citalyw
Message-ID: <CAFEAcA-+x=SJ5E=owff6okoteN1ytNH5LesfFjwW7+tigPU44g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hvf/arm: handle FEAT_SME2 migration
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Fri, 6 Mar 2026 at 11:49, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> Patch v18 needs an adjustment, because clang prints warnings about the
> `static const struct sme_isar_regs` array.
>
>
> ../target/arm/hvf/hvf.c:1098:11: warning:
> 'HV_FEATURE_REG_ID_AA64SMFR0_EL1' is only available on macOS 15.2 or
> newer [-Wunguarded-availability-new]
>
> Peter,
>
> Maybe I should send a new revision since you haven't merged these
> patches anyway?

Yes please, if you could do that that would be really helpful.

-- PMM

