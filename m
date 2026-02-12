Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04B1EB48EE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 09:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqTED-0001ey-3p; Thu, 12 Feb 2026 04:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vqTEB-0001eX-29
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 04:43:15 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vqTE9-0003Uk-GZ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 04:43:14 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-505e2e4c35fso26390441cf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 01:43:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770889392; cv=none;
 d=google.com; s=arc-20240605;
 b=ghs1v2SCwFevOfxONjNSWgUFZjbjF0jfbtpcCrOlfTXUzHKfg16CKdgXdswmffluu1
 +I3xoVrx/yFtudq9KNtWAubShQ5Xz91kuwtZdOim+Jz5V1jXKM90NJXeUznKvImsQExm
 67+LwnhOMJrxmLCHO1tcpTV79pg3EdCiiyxZdU+bFy/aFrTIsp1XAlJQyON/5Rg625mi
 AII/P9r+vKqNJcHu8cdbIuozAu/zlHJ8tUFwwdIOa3xeKoRQsf3b8RTrpvtF66HL7Tgx
 NCE6KohTVeGstIfFRU6cKcithSnE9xbZQzCMBuJ1C2QyAvv5VmWuX8ws74G/Zhsu5TT/
 K1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=psDClz7Euq9+MVJGiY5hhb/jKlxZuTXnyN8tFgjflTM=;
 fh=B0D6QSst0PSJ4741IRuZ8XVJLDah5uslvRzvvwIgTqY=;
 b=GsmtxIo+OtXHQt9w74t3tL8p56fSVOwAwIZ0yQW3qd4+fRPa1Ufk24PiEQvECaGmUy
 AY6HF8i7wtYMrZSNdk5tD/6OpfpcnjBHetOf39zEiFUeVN+fDx9M1Ij7wAc9AB3bGzg/
 vPSuK7qOhJfmN/Z5vhfQjKgBtq/8+1A3NESkk15JLzSQ/ZFmJ91zJfN2KjNKP8hCVKkO
 q3xIDHcS+oBndEAlYt10Ot1EFzQJ2pPg0VocwbnrRzDwX6I+Kqz9WYwXjf9Kkc2MdrWy
 VbhX05enRYff1BGe80M52nLr6MmAEpJ76so8fzc3liStiXOsZ7pbVIk3cNXVPh6rgixO
 C/KQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770889392; x=1771494192; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psDClz7Euq9+MVJGiY5hhb/jKlxZuTXnyN8tFgjflTM=;
 b=GSmDeRtdZqifRy+pw3FjDes9KlTrXhAWYzY0BCbW1M9ZbQWJKyTV9C/OPG4p2GGQ8B
 hnFezaCWjYaZmuDB8WpgbJTBTqIOhzSfPR1MfYmfDo/TI88dL+1DwDZgSBdlHETXXOin
 8cPf0ELQrusXS72aVdR9s+aQKK5XajL9pMlXJmPBIMiGmGfcIIv6XxqcOs1CylTlvU0Y
 IxzylGjC71jUXElqjPSCWhMDphdEcDaOB7hddsSP/STXSE8jREypO8PZTQoykQKU6IXx
 v7S9iwsVT3W6GtOVZzXwaul2FL6L/Nh5czymvhmnH31CSgU9CfQweNjadnIVn6Dj8Die
 UrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770889392; x=1771494192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=psDClz7Euq9+MVJGiY5hhb/jKlxZuTXnyN8tFgjflTM=;
 b=ZbKDfA0WGuKK0SpfOCgXAOfqI1Gmw45rSFMlTAcPtjudnIPm6RqjqGODgPjpC+WjX0
 KKceQwLnRc0i6qY3GvzDukC3ZUvayOa1qaQuVr9zJH7YyeZyjYrnc0gqHNpbblcNyKaJ
 kr1z9zXkn3q/O6pr3Y6gggRuQYi4HBuNeY4dox0OSxeeYjCJMJvPPGTPlY0ddES1KbjB
 bJAAqVaX37g0xZfQZV/CY9DNVMoHswJcvQNPJVYdLqeJZ80mek9FSJLLePQJPmM/v/5j
 0Ha6kDpEf574m1hg5do8C4wXeC89OP48hJiDfmzif+eQBHhoHSsWFKNTc7djfp0E+vNx
 eThg==
X-Gm-Message-State: AOJu0Yx/BgMcnwe/StZpguHQRH9k7u/BQ7a0tBRs5i76434+FBS3MIFd
 eksrEs5fZip/FB/Zrqsg2/I/7SP1WdoeIPBq4HaUQfzs3YT+laKeCFvh2YBB2GzMkI0WhVKtaDk
 wJCBzOhaQlw6dY/bHJ+TXk/NkTkrO374=
X-Gm-Gg: AZuq6aI6VvpuDX3yzbbj1OvQZk0gQUsjsEUw0qkD/DEE9zR0uTDH6VZ2hkNQO22be9T
 9WasOjjBXr4k44OcglLiH1rk2vwckCuINq/vvyiv201WIWjEPgqnfJZvhUTKfbrbQKYUGMcOIHg
 Gf3Ns5yssvE4dpivHP4ObicZIOd+Ig2+/s9bHZcqCmgHUkQOmLspEC3YZ8QXW/FuXvpnIPu2B1N
 jFBYcaJVcz6eSMwZ0ojS2DSCakLqidGAoLcFBVuZg7fY7moF9KI3x8u0LzSYKOZSQ5zDNbc9w4a
 sSZ+w/P816PpCrqHhWHG4W1Y1LEqCyRm5F6kgS4b
X-Received: by 2002:a05:622a:18a0:b0:4f4:ee07:91b9 with SMTP id
 d75a77b69052e-50694b99588mr15549421cf.47.1770889392260; Thu, 12 Feb 2026
 01:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20260211204445.4124071-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20260211204445.4124071-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 12 Feb 2026 13:43:01 +0400
X-Gm-Features: AZwV_Qi0xtlvcPIhcCGp_WjxydcfmGufP5BxeNpKLvyyQPA9u6huXCx2Pzj22fU
Message-ID: <CAJ+F1CKZUz6QDDYj9g2NeyKimOrcXDN-ZYG12CYg2pJn9s4Hjw@mail.gmail.com>
Subject: Re: [PATCH] baum: Add copy/paste bindings
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Feb 11, 2026 at 9:46=E2=80=AFPM Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>

Can you write a summary of how this work, where the protocol is
documented. Also higher-level doc for changelog would be nice.

> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  chardev/baum.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/baum.c b/chardev/baum.c
> index 157f8b9519..57fe60fe18 100644
> --- a/chardev/baum.c
> +++ b/chardev/baum.c
> @@ -1,7 +1,7 @@
>  /*
>   * QEMU Baum Braille Device
>   *
> - * Copyright (c) 2008, 2010-2011, 2016-2017 Samuel Thibault
> + * Copyright (c) 2008, 2010-2011, 2016-2017, 2026 Samuel Thibault
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
>   * of this software and associated documentation files (the "Software"),=
 to deal
> @@ -564,6 +564,30 @@ static void baum_chr_read(void *opaque)
>                  baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_=
KEY_CMD_ARG_MASK)+1);
>                  baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
>                  break;
> +            case BRLAPI_KEY_CMD_CLIP_NEW:
> +                baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TL1);
> +                baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_=
KEY_CMD_ARG_MASK)+1);
> +                baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
> +                baum_send_key(baum, BAUM_RSP_TopKeys, 0);
> +                break;
> +            case BRLAPI_KEY_CMD_CLIP_ADD: the dependency
> +                baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TL2);
> +                baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_=
KEY_CMD_ARG_MASK)+1);
> +                baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
> +                baum_send_key(baum, BAUM_RSP_TopKeys, 0);
> +                break;
> +            case BRLAPI_KEY_CMD_COPY_LINE:
> +                baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TR1);
> +                baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_=
KEY_CMD_ARG_MASK)+1);
> +                baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
> +                baum_send_key(baum, BAUM_RSP_TopKeys, 0);
> +                break;
> +            case BRLAPI_KEY_CMD_COPY_RECT:
> +                baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TR2);
> +                baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_=
KEY_CMD_ARG_MASK)+1);
> +                baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
> +                baum_send_key(baum, BAUM_RSP_TopKeys, 0);
> +                break;
>              case 0:
>                  switch (code & BRLAPI_KEY_CMD_ARG_MASK) {
>                  case BRLAPI_KEY_CMD_FWINLT:
> @@ -606,6 +630,10 @@ static void baum_chr_read(void *opaque)
>                      baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TL1|BAUM_=
TL3|BAUM_TR1);
>                      baum_send_key(baum, BAUM_RSP_TopKeys, 0);
>                      break;
> +                case BRLAPI_KEY_CMD_PASTE:
> +                    baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TL1|BAUM_=
TL2|BAUM_TL3|BAUM_TR1);
> +                    baum_send_key(baum, BAUM_RSP_TopKeys, 0);
> +                    break;
>                  }
>              }
>              break;
> --

Those commands date back from brltty 4.4 (June 7, 2012). I suggest we
add a version check to the brlapi dependency.


--=20
Marc-Andr=C3=A9 Lureau

