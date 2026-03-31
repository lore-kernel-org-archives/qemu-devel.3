Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB84FF60DC
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7U6C-0003Oc-N3; Tue, 31 Mar 2026 04:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7U6A-0003Ml-4E
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:05:18 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7U67-000231-F2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:05:17 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6501e465a8eso4777315d50.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 01:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774944314; cv=none;
 d=google.com; s=arc-20240605;
 b=AmukLlMLeuSK/0mvwCSdPIF/G/xLWgiw/zRw4BSfzT9OStIxEitwf+NnchVCz0t2DV
 1GlANC7XK5azenNQ6JN/5d9h6GUsS1lg5jgClhcQeYF7vKN8LvxHyPHL14/rYMYAcde+
 OoNdgBAujLJ9WXcZt1pO1ke+JC3ijC1S4xYSC0ER/XQ2t6w3OFbkkfJc7DRGoKZbqbUf
 cLv5voSWG7UD/347eekSHI1Gg/LzB6Fx9XgJinjsxS1m9IZhSWnH54DNSSQ79Oy1l0DD
 WbcLnnjxlMThEFrkX7/TqzlANQJdI/kVBFaGKDj/+rx04xEziu9IrE5TZnmfwzQZVtFA
 C5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2SCSCG4h5fG8qPnYLPEt8MAeV8OXZKg8XY4JHE2gDfI=;
 fh=lSj/1hQsilLqqrIQB6s4Q1wh6081l/JyVKvt7e1AODI=;
 b=YxP7GespqBTuVIjLl+MYFa4adMRQHtEp7C2YFXUVuyAwpoM4kmYR8ueRGBZKv1HsQX
 iWI7+e5FaOOM0VYfbQtwUNm87WGi993Re/fw0wakLb7EG08qLqq3/2YlktFEIn4qZPSR
 zNCQb6qIF4R2W9uwNJquoeEKWwszK4sfO3ie7mCabxxOFCNum8lCGYJ1Qeq5E8SJ9hxh
 u6BVev0yiyqHDh64gBBQBLsxvaEnA4UnEKhDse3IdlF586yIZOSTR+v115A/TDbvoZ63
 LTj2I+FXIufJYWSfIXOZoN7BbKle/tL4bmKOTjxcLCkZZ/D0mNk5O5OrQ6+EDZrqqu0z
 cOLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774944314; x=1775549114; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2SCSCG4h5fG8qPnYLPEt8MAeV8OXZKg8XY4JHE2gDfI=;
 b=hM6mvRPagpBvtpNIWAK5tJwu9Mu4dx7p0GsnRqe18PRbGY7Cg1jAe5UZI5LwwAwd7Q
 hCVPKEN4M4aOQCLPyd0S9nzG9d2NuhKIQdA3SN7vWGgjIl6RCOJa1uRbVPCKMelYT8ES
 ljS2pLbB/lM77Nj0mGV7ncVH3zEIBc44PUG4N+H3VTMDPF8u6egVfCegAekKXBiZg8kF
 BZwxgdR9FAJ2qbX+3w1ggoGXfpCkE3L6kqejF594HT38tweSX82VnaEOAgSDJNyd3/ix
 QZSrVruEKtxwBvrWwyguifPfCwoiM3Q1w9HGAi6KfUaOGsXpTcnrbKjHbz5zDseUMJzS
 X22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774944314; x=1775549114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SCSCG4h5fG8qPnYLPEt8MAeV8OXZKg8XY4JHE2gDfI=;
 b=R/REctVex3L2dT+yIN2D6ilWOjRIjVIdTkP7tJ1oG/nEcyPsrId2nNIyh4DObvcp2y
 qrS8NFV1293Rbf8ZVR9Gk8Olth7dVzAwl2R7v1d8ve3F2f2naDCfgXwX+gp6Nexyae3l
 UtQEF+XHlXDpiYYy5Td7nrpHxsKQznH1fiA00dh7NyvtE9YqKjeMGF09Gw3er7y7zhNX
 RdElVdPDDln9o+wFt8gZJctshHNq3hneUhvSB5iZphQIei4zbJsdh2ctUEehhCOBXyjF
 wBiD6Vs2a7xLFYF0lNfVTA+F+pkmg1ZqFMUkUW8czeIOzzi1GprSBfntx2SAFhgzQD3q
 6QUw==
X-Gm-Message-State: AOJu0YxVzusOZSksXg1T8ZTCzSb79D1B8M7U5ZcsUjU+nSfB44kx63X8
 8v20sixn60Jg9Q4bqXF/0JKWhhlUrcd6tDG7uFNXOgtqyPeWHCXLNNSBE+nxUgtavrrDPrcWLU2
 OX8Y0+yrxcCcU1qgGnR9vdSDcvsIF29ul3iMNvjYdcLDOKuNkrI1pLTM=
X-Gm-Gg: ATEYQzyVq1N+2+gHV+ft27UL53hDqns8WtehEtkI2vJ09yTkMCu5P+CuLMVsgUiBCkt
 05i8uGLWovohgPznqNoup7OZRHgYD9PEo/WFp3x+B5O2qXZephwRrCUh5nhGHKk7bidBN3NRfxz
 GCnDIN/hdoFnw2CvI51Rv2pp2xeTqH3+2H5REBPL/EEBZyUderSbbal89EKfdRMFgwP4wE8seke
 v7J2BThixDuSXb9mki+CPvOXoImhj2LbMnmFLTls/i6wAUuWXbMmadzNyJ1u+koqsWd9qtLjY5y
 DyetdDvESZv7WOi5e+3rmAKBBp6P+DRRRmdbN9nRoOQVcsJCo7DeYbBtpI0cmbJdJhM=
X-Received: by 2002:a53:dd4e:0:b0:650:1cbb:50a8 with SMTP id
 956f58d0204a3-650267864e4mr1687622d50.26.1774944314347; Tue, 31 Mar 2026
 01:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774904832.git.balaton@eik.bme.hu>
 <541ffffdaa4c67b9dcbca6c2498e69b137bce95d.1774904832.git.balaton@eik.bme.hu>
In-Reply-To: <541ffffdaa4c67b9dcbca6c2498e69b137bce95d.1774904832.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 09:05:02 +0100
X-Gm-Features: AQROBzB-7QEHI4Hs9uDLhKJxkdSn4L7YVM9Ym2-aMucv54PlmXW69dh06Gf2oJA
Message-ID: <CAFEAcA8y1AD1v3J1A4ZFtm-8nzr75uiQtBwP93LibCznPQhK8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ati-vga: Add upper limit to x-linear-aper-size
 property
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 30 Mar 2026 at 22:09, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Coverity warns in CID 1645968 about possible integer overflow. This
> should never happen but to ensure that, add an upper limit on the
> x-linear-aper-size. This may not silence the warning but makes sure
> users cannot cause an overflow.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/ati.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index fc19737d1f..97d871b1e2 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1130,6 +1130,10 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>              s->linear_aper_sz = ATI_R100_LINEAR_APER_SIZE;
>          }
>      }
> +    if (s->linear_aper_sz > 256 * MiB) {
> +        error_setg(errp, "x-linear-aper-size is too large (maximum 256 MiB)");
> +        return;
> +    }
>      if (s->linear_aper_sz < 16 * MiB) {
>          error_setg(errp, "x-linear-aper-size is too small (minimum 16 MiB)");
>          return;
> --
> 2.41.3
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

