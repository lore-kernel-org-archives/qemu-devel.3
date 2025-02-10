Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20347C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thV9d-00004w-EU; Mon, 10 Feb 2025 09:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thV9X-0008V2-Lg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:52:52 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thV9W-0003IX-2W
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:52:51 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e5b3dbd6732so3417630276.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739199168; x=1739803968; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dXZenGARfw3IOupKccrnIOuz9KweyoTKXdi5aucIOHo=;
 b=K4j+98/edOKEuXFW7eiL4vO9e+nNF67f7PD7sOIkwJmjfduv6l0ecR9Lt8saJ3OEaD
 Zzt5Bd0kRXgIpNdR4WZVweecRzzY8/ZLCL2xdi2PsXTMV2e53q3WaLDd3QCh/dP4HUBG
 sAfxSDHQhZe5q1ri4oFGSxyviY/NKG4/d9YuNdR97Fwmy1JxseZyDeTw85LxWh4i4yzI
 09udEDwTi3tzmgf0R9pNOAWqHOO7uqbR6FpnijP6wwlFcpKF8QruOrVX6rKB0S6+mngf
 nFcZSlg4/t00+lzvuMROrBDOU1cQvGInSaqth+mhhbkNUQehQ7Ov9tJBXBBIHkLhprkq
 KxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739199168; x=1739803968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dXZenGARfw3IOupKccrnIOuz9KweyoTKXdi5aucIOHo=;
 b=CACKeXD85MWNkXqrtMJyRbkVuvEsq/LF/buG2/5nuE0mD3VOYDWVfuimVdqhkFhqBP
 2T1+E7Zrrha45MVhdyBF8WUhQa1l+Djaan1kR2zRb6Q9ppOuPUcTuZIARIBbI0tq73mk
 WI5l15bOXQuKlKAeveOR1+txVgsMWTTu7MCxgq7sPOaLeQf+sxFNKWt+PESwIv5JYRVR
 LWN5fDje9JNHqvX5TiBMJIfsdqDZYj+iAbCEwTqWB6qTWpeU/B7+X4dmkypuOqktlCPY
 ANffOSjE9H9EMekdlaW+AwI0ohn22IJzWfBWRox4EzbnwH29qKe0fsyXqm/A4hHPN139
 sMDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOqio6ZW5ZBI4VG7Jq78kFiSWqP2UzK9/NFa08oCsYeWYdE5xlAkFjt/eHvVfdj5oubuQ6WDusfX7O@nongnu.org
X-Gm-Message-State: AOJu0Yz05E+j0W65l0SBbkOdakdrBWhmD320t8KAFX72cPoZmCWVozGc
 xu4C10CNtuQS7SEZQQZAJkPxjpK0P6m4H0lU4zQd6e4eMLTKbgzCXxmARDyB3Gigkp9SaX4Tm+d
 tT3YdHUaqnWxTmQ4wwKQLKm8tzeKPScEfnwRT4w==
X-Gm-Gg: ASbGncsqMj8pvVNO+wugRFNpvsLIlmZRnNQejtMNrOsMuP5kd6xwa5oc90uXiHVmjkp
 axRisvQqD6tg6dVeqoYcEcwWzUfboJS0KFjJCxRqPyNejfXZhwaniqzUr1C6JpoKPXms2Stuf0A
 ==
X-Google-Smtp-Source: AGHT+IEP0Ctoq22+/C4IGxu76403TZM9VKd2AyExbdyeFl7Gx3IQRxX/aM7vMSNO2mcdK0+Muv7UlbhNNGtjwUMpwyE=
X-Received: by 2002:a05:6902:18cb:b0:e58:dbf:ed09 with SMTP id
 3f1490d57ef6-e5b4617025bmr12243101276.3.1739199168696; Mon, 10 Feb 2025
 06:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
 <20250206221203.4187217-16-wuhaotsh@google.com>
In-Reply-To: <20250206221203.4187217-16-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 14:52:37 +0000
X-Gm-Features: AWEUYZlK86CxAfUXcKSQzwXTRt_0Le6ac4RFQ6NFPmX2kDqd92WmKwPTHXEXOvU
Message-ID: <CAFEAcA8wgvb7k56me7muy2PsLNL0GAa0ewySpQpPQocHQ2djYw@mail.gmail.com>
Subject: Re: [PATCH v4 15/17] hw/arm: Add NPCM8XX SoC
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com, 
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com, 
 titusr@google.com, chli30@nuvoton.corp-partner.google.com, 
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Thu, 6 Feb 2025 at 22:12, Hao Wu <wuhaotsh@google.com> wrote:
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  configs/devices/aarch64-softmmu/default.mak |   1 +
>  hw/arm/Kconfig                              |  13 +
>  hw/arm/meson.build                          |   1 +
>  hw/arm/npcm8xx.c                            | 804 ++++++++++++++++++++
>  include/hw/arm/npcm8xx.h                    | 107 +++
>  5 files changed, 926 insertions(+)
>  create mode 100644 hw/arm/npcm8xx.c
>  create mode 100644 include/hw/arm/npcm8xx.h


> +static void npcm8xx_init_fuses(NPCM8xxState *s)
> +{
> +    NPCM8xxClass *nc = NPCM8XX_GET_CLASS(s);
> +    uint32_t value;
> +
> +    /*
> +     * The initial mask of disabled modules indicates the chip derivative (e.g.
> +     * NPCM750 or NPCM730).
> +     */
> +    value = tswap32(nc->disabled_modules);
> +    npcm7xx_otp_array_write(&s->fuse_array, &value, NPCM7XX_FUSE_DERIVATIVE,
> +                            sizeof(value));
> +}

We're trying to get rid of tswap32() uses. Compare
npcm7xx_init_fuses(), which does
    value = cpu_to_le32(nc->disabled_modules);

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

