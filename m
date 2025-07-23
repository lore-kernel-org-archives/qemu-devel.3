Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA90C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 15:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uebjJ-0003IH-NG; Wed, 23 Jul 2025 11:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uebjC-0003FW-De
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 11:49:59 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uebj9-0003DS-4A
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 11:49:56 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-70e5d953c0bso774627b3.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753285793; x=1753890593; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaLN0Vx3ld9S50gIhbWA/U9as2WkAODr+3HIu10m7qw=;
 b=dcuE4B32irzc8hgzRdffXU9pV9V2R9BTYAQ3bRYBP7KM5mGJKuYDJ8fwrZvhNGd7Q3
 5EQZ/lCotJgmo1S63hYCHtAn1wY7z7yI5PelZ3tQ7MghUHVm39k6Y0rXihB0judBDrDq
 14yIlObQB91g5yk22O+aFJn9l3xPQQXZKcfhVIMDINPyoTTnlDwpQIMaK6aM1rNzRo50
 sRZfYJq/w12Ktf9RAiXUZbm97IUJvwUSZpSe3UwuLSfqfWcD9t0SzOCRlYqyxnwqSi4F
 yG6+S9opCY/4ef7z5pjhZ61wQTlpkw7kzseY6bJg8cKL37L69EDLT71hbPMYZp56/N0U
 2Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753285793; x=1753890593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TaLN0Vx3ld9S50gIhbWA/U9as2WkAODr+3HIu10m7qw=;
 b=qTwxoMC/7He39BFpEFYxvoOPVA880YPU5IT7RRT9fNc6J2lPMyiLhOxtDMRVypjxMe
 Jf4Na2TKPXTw6R0exck2qCyxLQosqO42D86alUSUHbbu1RAAFC2VSk989eHSlAEQdV2L
 7cVGkETVLliBOck0Lhdj+xZOSd3Mir5R988hBljLjESMCMqVXFi8Ze3GKj4SWykvFC/L
 l3C4T+4AwXhOTYx+tgZlPQfkHJeyx8WIM/ItGP6IoFmh8pgAOoks6IWIRKyvRk2xrsZM
 u3WoKXNed1AsW19eePFzrND/xKqmehNfsGuQFPn3sZUflfpcnuUmE2Cp8l4GVII4oFZO
 A7WA==
X-Gm-Message-State: AOJu0YwwsehlVnGFUaGpIWzWrQnWGa2ST2lMNBFw1jT95vCJbzHmyekp
 Hq76j45fQ/dJXXUlO1b9ELW1PlWMsFGZU3K30h+i3SX2bQ0wZWn8QquUGoghef7BxiSAGBXkK/E
 i132zsCVCUwokIh5A21blxpQ3BgKq3HPx1iostxmz7Q==
X-Gm-Gg: ASbGncuOXfzek/oA1r+C0l/v6fRa3VOufIWiQ8z7B3GU3qr02Vp0p+pjLtCZBBEtCgE
 cZ7Nh9e2K++3ysIXPoaN77NoHpb7ERZt01ftfHAWGOkiSLaWfvVrf9QnZuH8vRMZvIIYJZVNaG4
 UZspwZ4qryhW2+DLwAT7cLS14pJQRXgtDgi0f2soLM0hl5LC7mCHOoT82W30Pu8hvVwZdxRzJmF
 YFuzk0u
X-Google-Smtp-Source: AGHT+IHUMaLXihYYm/GtmbmxwfleLM+GAJGIjg6BT9jUhejfSgXiXBzh/vgxifEj1rdH2yOyQ58Og3PbU/yljxbeuHc=
X-Received: by 2002:a05:690c:b14:b0:70e:142d:9c6e with SMTP id
 00721157ae682-719b433a10emr45716827b3.32.1753285793344; Wed, 23 Jul 2025
 08:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250723135156.85426-1-philmd@linaro.org>
 <20250723135156.85426-2-philmd@linaro.org>
In-Reply-To: <20250723135156.85426-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Jul 2025 16:49:41 +0100
X-Gm-Features: Ac12FXwDgegYZc9Bg5loOWYI3loOQ00j_NZBMSC6OLdDgt2Ll3hlHe4WGcYPJiY
Message-ID: <CAFEAcA-HH3pyWv4sF6ujLFdMAhtYV8H0TxjJ1Z6myHu5hbWusQ@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 v4 1/4] accel: Introduce
 AccelOpsClass::cpu_target_realize() hook
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Wed, 23 Jul 2025 at 14:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Allow accelerators to set vCPU properties before its realization.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/accel/accel-cpu-ops.h | 1 +
>  accel/accel-common.c          | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.=
h
> index 0674764914f..9c07a903ea0 100644
> --- a/include/accel/accel-cpu-ops.h
> +++ b/include/accel/accel-cpu-ops.h
> @@ -34,6 +34,7 @@ struct AccelOpsClass {
>      /* initialization function called when accel is chosen */
>      void (*ops_init)(AccelClass *ac);
>
> +    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
>      bool (*cpus_are_resettable)(void);
>      void (*cpu_reset_hold)(CPUState *cpu);
>
> diff --git a/accel/accel-common.c b/accel/accel-common.c
> index 850c5ab4b8e..eecb2a292af 100644
> --- a/accel/accel-common.c
> +++ b/accel/accel-common.c
> @@ -106,6 +106,11 @@ bool accel_cpu_common_realize(CPUState *cpu, Error *=
*errp)
>      if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) =
{
>          return false;
>      }
> +    if (acc->ops
> +        && acc->ops->cpu_target_realize
> +        && !acc->ops->cpu_target_realize(cpu, errp)) {
> +        return false;
> +    }

You don't need to check if acc->ops is NULL here: per the
comment in accel_init_ops_interfaces(), all accelerators
need to define ops, and we would have already crashed if
it was NULL.

thanks
-- PMM

