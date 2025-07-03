Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FB7C83F09
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXH6K-0000ti-IF; Thu, 03 Jul 2025 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXH6I-0000rn-Mx
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:23:30 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXH6G-0005Uv-1S
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:23:30 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7086dcab64bso51055977b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538205; x=1752143005; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e/oZafQ1SHFXKtFHR9vOE777S/3glDUbnaZXGFCDRLw=;
 b=hX0xtgZ/BStin2OxAFmnEjvcMGH08V4ZK/MMMMBNmGs5V+pIj3qsoSMJ7n8aokhsy/
 bkdlCMXQreOdkXfe+zUFEA+Dhm0EuZYjvAm/6cQeNNKy4PU6j57Eeyf0nZdrMEBi1KMc
 BP+KJyXxL26s9GvXzP0mDkG5JBp7ghodP5eOGyfVXSaadeGMT3/6tu8hXOEkUvlzKTmp
 DoQbwfm0u2ThjRaEeZ/Fpfhq2ioF97oh9aZDCLjnEhDo90oEZerc3mzm6TxFhi0fnyuh
 bvpWpPKdnMZr3pYpTWrlMWtOtRrWeZ60+UyxH+4ZwUKbFWnjRoSVpNOA83QCvLf+cex6
 yDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538205; x=1752143005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e/oZafQ1SHFXKtFHR9vOE777S/3glDUbnaZXGFCDRLw=;
 b=tJNzd3AEyyiJuX8yOVBiSnw3j9TKyT8vmLPrv22I9mYfnQrW1720Nj8zruZWQ/DWL+
 qY4IqDi5jnTUz0nxq8XJr1cMaU8gY3vKyNhyJ25uumejqOh60LTTExeYObhKR4czKcK2
 FO5LQ7I1UzOPa7Iln+mER8+xALHOS4v1MbXiUN5NA3jVbkIeMbXCrNHL8vTIdMJwzqW3
 Sx88HH4hz8XH/yyQdfW4+R2UBpx4cWb1xeF4cxULRdlM599f5gL+FTpSCFXz5VVyBnKI
 qSuZwlnHM1Tphj2WQw5/jIWHDzFft7lkS9iQsuAxB8QxsYvvdHPOGVVi5oi9Tz/h/hv6
 csJg==
X-Gm-Message-State: AOJu0YyuCdQmeZ8bLMo+PVipuN1g4asAeXrWDZm7hZX2UCCMkqzpXzYg
 QIlMXeuxVbKYgn1TNcKzAe0bjZmo2GXcoTDhpiR0/k19dub1GAbRj9wAAN7KeGCzLYh3PiNuiiQ
 VJWM8YWHW1LUzETGPZ8HXC5VRPZaZwiN7SyoHn6SJt3J3BK7amadm
X-Gm-Gg: ASbGnctm4d4wuommxG0XwjWxLWa7bgdx4bgP3zBvgw1Ed7MH20ZsxPv/cX+k21gmI5x
 0vhFYE5jZER7P3zNYnGH5QXPA/YK2yDV7W8F2RPxm7Zdb1brGnRIOpqpK1ef/v6DH7YqG6yxZD7
 T+4jhMX4FRconVOwuEjyL0/dqAUtjaaUU+wr3np3Y/Uw0J
X-Google-Smtp-Source: AGHT+IGTEuMtKgsBgFN0qZXdj3Ngb0Ub8qKzDieQVxRw1ErY7apgQYVxWw2odOnXO9SxLoW3agSrH0+koGetoD9AWxY=
X-Received: by 2002:a05:690c:4:b0:70d:ed5d:b4b4 with SMTP id
 00721157ae682-7164d3f1568mr87072597b3.24.1751538205370; Thu, 03 Jul 2025
 03:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-52-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-52-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:23:14 +0100
X-Gm-Features: Ac12FXyvuCqiz7Z_h0heyZeK8LEa39VLJv7yOKD2rBrsjfFsCDyS898QFcACAHo
Message-ID: <CAFEAcA_2pQAQ6gnoq14xDBEFJKNg0jiuW0dtU2g-tca9f7JSXw@mail.gmail.com>
Subject: Re: [PATCH v3 51/97] target/arm: Implement SME2 SUNPK, UUNPK
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


> +#define UNPK(NAME, SREG, TW, TN, HW, HN)                        \
> +void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
> +{                                                               \
> +    ARMVectorReg scratch[SREG];                                 \
> +    size_t oprsz = simd_oprsz(desc);                            \
> +    size_t n = oprsz / sizeof(TW);                              \
> +    if ((vs - vd) < 2 * SREG * sizeof(ARMVectorReg)) {          \
> +        vs = memcpy(scratch, vs, sizeof(scratch));              \
> +    }                                                           \
> +    for (size_t r = 0; r < SREG; ++r) {                         \
> +        TN *s = vs + r * sizeof(ARMVectorReg);                  \
> +        for (size_t i = 0; i < 2; ++i) {                        \
> +            TW *d = vd + (2 * r + i) * sizeof(ARMVectorReg);    \
> +            for (size_t e = 0; e < n; ++e) {                    \
> +                d[HW(e)] = s[i * n + HN(e)];                    \
> +            }                                                   \
> +        }                                                       \
> +    }                                                           \
> +}

Similar remarks about the "when do we need to copy" check
and the H macros as patch 49, but otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

