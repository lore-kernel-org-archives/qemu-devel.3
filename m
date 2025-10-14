Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FCDCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hab-0001N3-E7; Tue, 14 Oct 2025 12:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8haX-0001Mj-FI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:09:25 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8haU-0005KP-02
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:09:25 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7815092cd06so9749037b3.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760458159; x=1761062959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsFaLEfLhcvzz++ZyZjgYONkG3EwSGLyjtHXvr32VQM=;
 b=G5c/xg7K3/uoRb4qmT3qar7+3piIFJ9zLIoDPyfHUhuxyRbQEBQ6t64DX/4o8DuxEo
 KrFl1F5uYFvtwZ2UikgPjRdArrhE/69MSMWexgFicF4zftX8Ym354WS2Niv0qxXLfbtf
 ZvOF1YcXl5Bg1oGBEiQ6LQesAH1p6qsxgzliPA+535HnQBuw2yKO7Q5XEBGK3kOxBtm1
 U8IqJMbl5u/sm54VeEhtF72YzzU7PVJfZWIm1omGUzYvNUQYA3D/4qvrmcmzO2Gl35PV
 9DbYpB6SP3+Z06qN+xSepuz8lnOJXDOSuNObKu5be9wjwscwMAMf9dEfuo/h4VXZlcY8
 w2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760458159; x=1761062959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsFaLEfLhcvzz++ZyZjgYONkG3EwSGLyjtHXvr32VQM=;
 b=RavvIolpmz0bjEjdzmZmwbmqKND2SPuLJ6dgqHuWMGc/faBG6ryhyQpQRWhEmKJ58V
 g0nDlrEeXHzmUGZ76liZung+A0FVmf0W8Ko0SHj4Ix9LOQCmPrv0Y7xHOss9X6VAWUMr
 wP/R0QJ3Jd4BfVQstQalj4R3hqA7PpvY2bbBt04aBnm/64eeAO5WBdMROdLiQmpGEAiN
 Dfkl+/FLsatpqco9sJnbcahVk2N18QE5FFrA3dG6d5rcpL8rU8fpZPQlTSLUZHwMolee
 RuLGAwRr/flSjbSBG6YKkN2FRogvIKQy2eMs09Bd7oA9NeLuKWe9zhiC0AEG2oOUbetf
 5j5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp1gnOJgwmvrN4OTjnFguDjGt+m4SJ9gR/mljDCBluEi628HeJsx6I3DFLO44lKtLeAXktzIAcOGrC@nongnu.org
X-Gm-Message-State: AOJu0YwRxPeCq9O5sg9WmjUrQUDneaN/D34FHBUBli6S8mpo+n2J/fOB
 tH7mTfs+nUfy1UD5eucLcoyBZ5Ob/ZcXN0bIJNq14PgBvIkl8A+Jw+mrAoYgD2cKSTk8cATqadm
 OcdIijs324Boy12SCS+lRn+1aW413GikBm428Bg/V/Q==
X-Gm-Gg: ASbGnctlTX77nEOhNhxHO3RBJNmgCHvQzDnQ5Y7b0bimV9WHzIcvAM+JZJE2ML1ibAr
 BJlob2hu7nnS6uaYdYCcczW+weXCKpjUhRwhVsFxJk2a62DMJiPGOCB2rhIl56IHYumJOMrnQvP
 qK2/njmLUN72kt5bV/KhjiLP6Bd9TxzsIeD18LhuvOx+n7My6ZHx5CZYZj82wt3YgrVHYvrnbEn
 XkBGHwPdCpBJKqb7Kfqs+roB3V/Y+DLMvZf+5g5Pw==
X-Google-Smtp-Source: AGHT+IHVZLMJJ1Y5tPQm2Dl1eW62thXEVO1rf9/5Fh4ZA41a3t4HFdokS6B+BYLD22UYFzuIqjIPX1TFyGsHccMnVEc=
X-Received: by 2002:a05:690e:2445:b0:63c:f5a6:f2d5 with SMTP id
 956f58d0204a3-63cf5a707d6mr7465735d50.55.1760458159183; Tue, 14 Oct 2025
 09:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <859f333e-37f9-4e76-bf88-a69d0641626a@siemens.com>
In-Reply-To: <859f333e-37f9-4e76-bf88-a69d0641626a@siemens.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 17:09:06 +0100
X-Gm-Features: AS18NWBvalo1Pjvnm3N-tDVrq0BJzM5OIdreqwRPEFJVUdjqID-tGVXqu7t1zLY
Message-ID: <CAFEAcA8HiZcLqxUAiU26XTS7e2xm6Uf0EUqQc7Ny7cvD8EhxJw@mail.gmail.com>
Subject: Re: [PATCH] hw/openrisc/openrisc_sim: Avoid false-positive overflow
 warning
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 14 Oct 2025 at 17:03, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Resolves this build breakage:
>
> ../hw/openrisc/openrisc_sim.c: In function =E2=80=98openrisc_sim_init=E2=
=80=99:
> ../hw/openrisc/openrisc_sim.c:284:45: error: =E2=80=98__builtin___snprint=
f_chk=E2=80=99 output may be truncated before the last format character [-W=
error=3Dformat-truncation=3D]
>      snprintf(alias, sizeof(alias), "serial%d", uart_idx);
>                                              ^
> In file included from /usr/include/stdio.h:964:0,
>                  from /data/qemu/include/qemu/osdep.h:114,
>                  from ../hw/openrisc/openrisc_sim.c:21:
> /usr/include/bits/stdio2.h:54:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output between 8 and 9 bytes into a destination of size 8
>    return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __glibc_objsize (__s), __fmt,
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __va_arg_pack ());
>         ~~~~~~~~~~~~~~~~~
>
> This is actually a false positive because uart_idx is 0..3, never larger
> or even negative.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/openrisc/openrisc_sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 880c8ebbb8..dcb1a7a00b 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -281,7 +281,7 @@ static void openrisc_sim_serial_init(Or1ksimState *st=
ate, hwaddr base,
>          /* The /chosen node is created during fdt creation. */
>          qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename)=
;
>      }
> -    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
> +    snprintf(alias, sizeof(alias), "serial%u", uart_idx);
>      qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);

If we're going to change this I think I'd prefer
   g_autofree char *alias =3D g_strdup_printf("serial%d", uart_idx);

(declaration at top of function as usual for our style)

thanks
-- PMM

