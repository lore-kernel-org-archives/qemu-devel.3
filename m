Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43574C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEUj-0002Of-Vf; Mon, 13 Jul 2026 07:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wjEUi-0002Jb-RS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:06:40 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wjEUg-0005rF-RZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:06:40 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c9e30214d8fso2083974a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783940796; cv=none;
 d=google.com; s=arc-20260327;
 b=PdGaaX9Vm/Vfo2fhG2VgD0tYuvrULiIEt9vkRN5mnuDccUYpoVa+eArXqnCSJ/HAWm
 Z1yI4TrHuvFDFVUiMKlnMA1ycduz8WRKJ6I2kSOYzOKFz8n3KZjM/81y5CNevFtiHvEI
 SHwfr+a8lUQWozbRgGBPD+PRmTyMPuPCqT1BhCBqt3Uz9Zw81KRb1KFbJFRAimr7c/Y9
 9YR1FFpWFkEmbaeDJaNSfpj4+rQAbWauyu31WdfB5ZkGNKgH4TV5GOvqGrCwcz5B5JPR
 siAGjUm/uXuanA3heeZdXS8GVz5dQY0IBMcmq/ZI5MrpY0M6bc24b4I89MTzVwjcYJj8
 qBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=niKMadT/pElSr4cVTmCi+NPc9jojzrBp4LzQqVPLQe4=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=bHk2i3sWhnl8rEBUreWBixoDWj7dIHbnfLxSMwzi2xr+WXyvkw7jnP5x2U/4WhgLFg
 Byi6iSipKQ89uiy9Nn8Ps5AxFSmfaBS0Y2hboBhpYII8Gb6gtaQiuCBEp4j5jdcB7RGa
 RUPggVLzw4c1IrK4Dw9XbYLbTawioHU29vof+kMc1qm1Omqxxn0x1SBA8G6kuZLK0ZES
 dw4JI7iM4efq8qMWvAShjxTG5XAN/RCNzoEQ7KZlgjb0r1vGcwsMw/fUvqhR1CjEWf8e
 sGts/CYqO+Dti5dnBm1XVFokMe3nKYTFxWEnD7N1Nd0dUhDE/BLOie7MuATI10gzKFR3
 lyMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783940796; x=1784545596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=niKMadT/pElSr4cVTmCi+NPc9jojzrBp4LzQqVPLQe4=;
 b=P1jusTuQQGStYKwap84EdmKWG34AVumAuOhpPb8v7MU8c6aLx2vplsdFA0+E21xNWN
 AuHEG2QWSuBbxRpl7RGmZevq6EZWHgwC1Fmy4L3OdN08VopIDsloiLWvEqRZOzUZONgd
 ovfBLDh+vRf770QRDtJmkMWGVP/X6dyz37av0tGJGiRs6Bz/92WBcNt9IA0KekHF7gr8
 Pgd0PGH3gZ7USNR71dp/GRtDd4ocHKhLrnmuTp94Q8Cx3kZ16MGdY394XqSSrs3Us/Ub
 O9TfWE6E03owDTa0o6JnRuYgJo74tKmwgVwyk2lsy5OcSYznVAsAfLkGZWO4ydalk0Jq
 rSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940796; x=1784545596;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=niKMadT/pElSr4cVTmCi+NPc9jojzrBp4LzQqVPLQe4=;
 b=HTLp++MeDKnmOPUSc9Ti0P2u4KCxS1Ue0Zpmavcp/1ussUYP+IrEP7YhtkAcT2a+sU
 DNZN4nJusyZRdeZ1fytgkqGBdxkf87OGYMbnM4hrjbo4gou1nmWujZ/1o6dj0AszvyUN
 aEKy9oXxcOjfqrRbGzRlpHoUPMtTv9FN9lvucBwfa/Rjvvivx4y9bmzGz8Be99ObgF75
 EBKAmQLFZYRuQUL44N03+cVdHDJCpcZf76kivlkXzW71dy4P+x3u20QHjX4hUIgdRY0Q
 X9G1z7EunXyMOtGeVG870OeokMhkPcZ38tcG2anyAMJq4cwmL5qad9siFDoyHJGuiz9Q
 h7lw==
X-Gm-Message-State: AOJu0Ywb5XzeYDi+6tK7uSYZvIX7w6QG34Z1hyJSCgW0COJJfFgsYX3K
 vaJPYSbozkRPfwKpXp6myojDvVLstJ+rxZgVbdFQ9J36awy1Zc5R5S/UGh6afnUVywWS+HE80Nx
 smE9xvm2CnJE3A7JSFmsFBvW73FfIMZV8v6Aalzh3IA==
X-Gm-Gg: AfdE7ckVvLXFgyGVVkjOLVgGZHbCH8VeOj0CyocnYe3BTctUW1DcP3hNHPKAN7dul36
 P/d70m5YoC+uicr0PyPK3dxQdbqPNOVQH5MPM2rOfkTbORTrAWxhuZ7bec6XDD7sgJMm624IJYb
 pDVVmiLFeH3vLEji9IxtNWWygZRyBLTgmWT1n/ATLxtXhfF0GR+OfefGr4JTTGuOJtSYPG8gp0Q
 ESyFE0oY4s6kKtl11tAzbClYgU5OUVR2mfuL+LyEUGIFc2eWT3wQWWKAZlxJitvPLgIqf4+Qc/N
 W/ywt7ZqPzmiZrWS5X856paLt1In
X-Received: by 2002:a05:6a21:7d02:b0:3c0:e552:f2d with SMTP id
 adf61e73a8af0-3c1104eb7d8mr8929395637.34.1783940796398; Mon, 13 Jul 2026
 04:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260713100056.4104383-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260713100056.4104383-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 13 Jul 2026 15:06:24 +0400
X-Gm-Features: AUfX_mwsGxP20e9t1pkVtXGGLl-Hr-nLo1T6BhXIb_FCixlCxeD1Y5M9OEMASXg
Message-ID: <CAJ+F1CLapvuAO-Y_wXy-dGJe2dAwmVMCy7JL4uokLTDqMBcz9A@mail.gmail.com>
Subject: Re: [PATCH] ui/vnc: validate SetPixelFormat field ranges
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 13, 2026 at 2:02=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The VNC SetPixelFormat message carries red/green/blue_max as 16-bit
> values, but PixelFormat stores them as uint8_t. A client sending a
> max value above 255 (e.g. 0x0100) passes the existing non-zero check
> but silently truncates to 0 on assignment, leading to a division by
> zero in the Tight PNG palette path.
>
> Similarly, the shift values are read as uint8_t from the wire but
> used in left-shift expressions (red_max << red_shift). Shifts >=3D 32
> are undefined behavior in C for 32-bit operands.
>
> Add explicit range checks for both: reject the connection if any
> channel max exceeds UINT8_MAX, or any shift is >=3D 32.
>
> Fixes: CVE-2026-15578
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3976
> Reported-by: dong ling
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vnc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index dfc8262d42a..c4ee4738b28 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2276,6 +2276,16 @@ static void set_pixel_format(VncState *vs, int bit=
s_per_pixel,
>          return;
>      }
>
> +    if (red_max > UINT8_MAX || green_max > UINT8_MAX || blue_max > UINT8=
_MAX) {
> +        vnc_client_error(vs);
> +        return;
> +    }
> +
> +    if (red_shift >=3D 32 || green_shift >=3D 32 || blue_shift >=3D 32) =
{
> +        vnc_client_error(vs);
> +        return;
> +    }

I am dropping this block, it's already covered by earlier patch:
https://patchew.org/QEMU/20260706-fix-v1-0-4b83a70e9f3b@redhat.com/20260706=
-fix-v1-3-4b83a70e9f3b@redhat.com/

> +
>      vs->client_pf.rmax =3D red_max ? red_max : 0xFF;
>      vs->client_pf.rbits =3D ctpopl(red_max);
>      vs->client_pf.rshift =3D red_shift;
> --
> 2.55.0
>
>

