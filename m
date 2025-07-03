Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822EDC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFxh-0000u8-9b; Thu, 03 Jul 2025 05:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXFxg-0000tS-1x
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:10:32 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXFxb-0001K9-IY
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:10:31 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-710fd2d0372so6245777b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751533826; x=1752138626; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KANvE0inrR17KctVR9drusYPwMQON/tTP6wjvM8ARco=;
 b=m5NSWaAy7Ud/R/xug2CjJgHCTjP7S4QtRVdl/UJ6Qw4EcHmIlsl4+Y+fLoQIrADtPX
 0jd2ObwuQZOFepVUZ/kGew2NoUHLhf+oNzKFcZJMw64cX5NqkPdK28sJFAN9nbPmvF/7
 T4RXjwqv57MpBzEaKhcwfTzc8SgYeVOOc8VsWlUyHz/UHY2Mgb1llCKSZ2mw6LaEmWud
 G7+vs4wNTtsbfWVm3bEQkaZXj5Mgm7iOKL4eEH3U1ldCroIqbS8gSCsvJe4lGnXXQI+m
 Gs3c2WPf8sAYQw6/caWs53ScQblurgVjBKvDW4xQNN86oVfMLXayQ3QvcHhzYIubypAn
 5VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533826; x=1752138626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KANvE0inrR17KctVR9drusYPwMQON/tTP6wjvM8ARco=;
 b=jGaluDDkdeTriI5sB+Tl2Ev4nEDXJzuisqJlK8JT85IJRQub4N5FIpVSD7tTWySCnm
 vixuooTqhY3vBX93lmqWrdvcYLn6zTJR8NvAKJ64skVN3XSKZ01I5KupmnjLBfN+B76O
 XD6GN6MWSxvc8LHDrKSlPRbx7PeB8MLnAMbsgQpAYd6KunJcFCcnC149z+qaefRF8j6W
 li1sDiyeQzcRCqlt35QHQm98gEcAXQAKP4PjBYjg6LuJT6Zyv5vrrQDruW4b4hcaFWsp
 Sx7kHN7duHg/CiblGhNe73qMxjKq4L8wvrsqmpajVqFB5oCUrJe1VqehQGfG5PIMRPkD
 /uAA==
X-Gm-Message-State: AOJu0Yw3U5HVzAJXg1xKs48Qr+2rGOE1Qw2+9Y+Uzq48oBLYtfV6AlCo
 tLDB0CxFs+l5wjqu/6JK3l7Vl2UGXBWIMWsNcnaqhNRuJONSvVt4w2EE5kzXFNTHZQSvWD6m/ju
 85X72p48wiH9ppUUbjwXs07xGKQN8uInzLZdTHLKigQ==
X-Gm-Gg: ASbGncs+CvMNVXtRJ+lBH7de0Hcg4NsfqCXuGGVNsn2EpHXvMPS9dW51l0dBiw2fUJI
 QRt2eybPQIDU5EFQRDOkmA+upGpejOeg7RhQ12Y9ElhnN8JkrAY98xJ4QG4ZEYcwG6wTvPGrEQ9
 nx99SFygCvj/yLlNUUE8Ja/6lMd2B4OzyuWXgpp53L7BQDApnK7eecnIQ=
X-Google-Smtp-Source: AGHT+IHsHzUMv4YdkIaYjnOnXctOl29k9itamMKbjLVlfsf0iYCI9DssFb5uESqGRDUb6uB/j9Co8l4qzssZAz5fNfY=
X-Received: by 2002:a05:690c:b:b0:712:c295:d012 with SMTP id
 00721157ae682-7165d15bd39mr17711597b3.13.1751533826054; Thu, 03 Jul 2025
 02:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250702122213.758588-1-richard.henderson@linaro.org>
 <20250702122213.758588-7-richard.henderson@linaro.org>
In-Reply-To: <20250702122213.758588-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:10:14 +0100
X-Gm-Features: Ac12FXyq4Hh6fDrPhIssnibB_y3xJskzIh4RMbQQYuW4al8kmCKbqxe8I7KVjkw
Message-ID: <CAFEAcA9jgUzvoWyEuk-d+NB_j=889Qgqx-aRBW0bej5sPHfoAg@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] target/arm: Disable FEAT_F64MM if maximum SVE
 vector size too small
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 2 Jul 2025 at 13:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All F64MM instructions operate on a 256-bit vector.
> If only 128-bit vectors is supported by the cpu,
> then the cpu cannot enable F64MM.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu64.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 200da1c489..c5c289eadf 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -237,6 +237,12 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>      /* From now on sve_max_vq is the actual maximum supported length. */
>      cpu->sve_max_vq = max_vq;
>      cpu->sve_vq.map = vq_map;
> +
> +    /* FEAT_F64MM requires the existence of a 256-bit vector size. */
> +    if (max_vq < 2) {
> +        cpu->isar.id_aa64zfr0 = FIELD_DP64(cpu->isar.id_aa64zfr0,
> +                                           ID_AA64ZFR0, F64MM, 0);
> +    }
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(with, as you say, the obvious fixup for the id register changes)

thanks
-- PMM

