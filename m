Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2F8CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtN0-0007K0-RD; Fri, 15 May 2026 10:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtMx-00072c-Vh
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:18:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtMv-0006Q1-QM
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:18:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so5681803f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854704; cv=none;
 d=google.com; s=arc-20240605;
 b=HbwITH8daFAsGhClEJ9YTrYhCMSBdBlZLcOoVDnBY+UNQaJJ9jimGRd9GLe9bJqwrr
 9QbaJN9K5oXyRDR0QegZy7vitNGHtLzJXqrdi+oxeLDCaKPVx3v7peZIuBKmglz34sVD
 KXNaJ58EydjuCp0GgMzAGUaPYsIBWdorWMfL8cwIRg4o4lYrIwr+so9BUtoPTfLr3PLv
 3vlbO7Tg15V6lSQ5eBbyDcEZrvC9Fj/DZQ9VjbYJhi6pQu5zf8SgZNDaAI45fQcY/QcY
 mkPm4+I3QQHOhVbYRVjYHwFf2tOzyjH1yRklYnGu8FJeGZey8+peKHwQob0U0G+sUwYW
 SsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EvQU+QSER8GC8iOu9SVuyi0uv46LoKdT8nCm6IzRewU=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=N8Ud4TSWPAFWWWdtOXRbhkENisx28XXum0HPSBkH46YSR+mDL+ue1e3w2jIvHG+2x4
 XhYIIxxb+A+AwoVqQjYAi1TIo3VLUCyL0x/TlioUxhv7vnAg7zoaV5W7qqJHHwlNfedT
 s1obD+loKu06KBPBJdHI3hXwCcA8HWHVB5OlPAFIgE9Ylf7vM10o64KEMGKf+KbAoFdk
 Fx/vvN4gWwYIcuMOWSUNUikJY/aumMJpnmRCCxsF+CATvKNSpf59je8Hps2o2YWefeqO
 ayQvDc631iws71UMdihYkaF4bc9rJ9iw6j4M3cHSwGWU1iyYyQxxF0X2taIoPScP/59u
 zNPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854704; x=1779459504; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvQU+QSER8GC8iOu9SVuyi0uv46LoKdT8nCm6IzRewU=;
 b=yxcQB6J6WZFcNVctWSU93vcxXNh8826ec0+t6aRhWj4/bzcBrTelWm+9EaFJPVzg/Y
 AVmIAwit3je3oVoSkFtxNmYqMkcy6YueN2OgV9XYbsBg5OQTousXewpi805bFBlNaUld
 +UPHYWi6nCAm3unTQ+rCuRv2KcuGvoULiHp4YiMZjwKGygwefps0KrT5zC6aWf3wioFC
 PIIYRreRQ46I081qH9a7FCMn/qaWact4nI1BgiBwD+gcRc/++/Odv+qNM89CnpJxqSzD
 BdtgXC9wF4pbOVmqd/gjX+dPUP1TlR83o4Zz6Cb97r8RmllybkhEvpoPxGFKJIZzUgeD
 i4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854704; x=1779459504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EvQU+QSER8GC8iOu9SVuyi0uv46LoKdT8nCm6IzRewU=;
 b=laO6LjvF2KGl1kStcoG7WcOEvPkNN4OJ9RLFeNE/4TOsskYG435NLu4zRHW8vzU1oB
 KCG6mG+YmkhbRbYH/V+b92X/f1BrQKuKpAYqwjqKXSVGLaOpHtCtCh6/0khzgqEDuacI
 vcxJ5N+RUV6v4I5HDgueFggJl8i4NyOl7V+XJ4iJpB17+Z7RXeq72ukKTFY5xVuDdZvc
 NL1Ej+h83yGObkh5my/NAVO2/yQzixlKLR9iIOnCMG6frmNV5wZwK6rVsTAPCJ6R+aAD
 dN+uy/synEXgNJyTry3TOZOb1x1QFvBi1kDDuoj9Y7SPsdJ8w/tgZ3bI8Z5aFP00n0XU
 1nhg==
X-Gm-Message-State: AOJu0YzRF65JCVgu79cvqYwTvDzYAA/Smltx9694lmBuqQN7s95ZNwb8
 F/T31d5PSJ/4q968p25jmtz/VDVJt+BcBTNI/W9xDVJbuuscbxj26vm26w5AW1nC8hWWVZvHZtp
 CD2+JaLN/E0XlOJ1o3wKPMGesJyhso3BjohTcpFzPzA==
X-Gm-Gg: Acq92OFiatKx0xeS1CtYVVcqXR2pW+Zh2cvRxA11yVVAgpuPABmFl7QLl98VHsB+cpN
 QnIQjLdqx9ikjRWDokFZwuWdzGRMuTa7NCQrmsGjvxzuFmU5Lvia9RLGTN6fZXjXleebXxCwm38
 iJWS8Orz6iZSig5hdj3v4NELSoPm/Su984gpD9Wk8N25HOqsfOWNL5PKYyosAJFH2wD6se8oFgs
 34k3hp7SVf6bgyh9ZFWzouS4dHI9u3qyGfJHPaYsq9/VzmvuzOdW5gnb6bUsqoW97dHsm+XsoM+
 FobQDbkzjWUUdaxAiUWDzVC5FFWjNyqEBrh+ejENZyxZrj89Gw==
X-Received: by 2002:a05:6000:2503:b0:452:65d:e108 with SMTP id
 ffacd0b85a97d-45e5c5a5e99mr5733070f8f.3.1778854703809; Fri, 15 May 2026
 07:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-9-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-9-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:17:57 +0300
X-Gm-Features: AVHnY4J_7fOx1zYgOcibyWf5n8XYaq_f6lbZ3u-c40fIQVdUSFWLmuvuYaO_TZU
Message-ID: <CAAjaMXbZm-4WHehg5EfUKJhiLN6-01DJcSUd3=QxdTf3p+6S7w@mail.gmail.com>
Subject: Re: [PATCH v6 08/20] target/arm: Build gdbstub64.o as common object
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Fri, May 15, 2026 at 5:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> While gdbstub64.o is already built once, build it as
> common object, reducing target-specific set in arm_ss[].
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index e56fc943bdf..5376be2e3bc 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -11,7 +11,6 @@ arm_user_ss.add(files('gdbstub.c'))
>
>  arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>    'cpu64.c',
> -  'gdbstub64.c'
>  ))
>
>  arm_common_ss.add(files(
> @@ -24,6 +23,9 @@ arm_common_user_system_ss.add(files(
>    'helper.c',
>    'vfp_fpscr.c',
>  ))
> +arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> +  'gdbstub64.c'
> +))
>
>  arm_common_system_ss.add(files(
>    'arm-qmp-cmds.c',
> --
> 2.53.0
>

