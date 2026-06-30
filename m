Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE4CC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVgn-0000nU-Uo; Tue, 30 Jun 2026 06:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weVgl-0000mf-UR
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:27:35 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weVgi-0006S5-St
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:27:35 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-30e9eefa268so175891eec.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 03:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782815251; cv=none;
 d=google.com; s=arc-20260327;
 b=a7DtvAV7VXHMSnuGIqbp/gst+F+c0FleBvs+Mb9ktvZCuQ5WCig3JxFQngTH2jj3+L
 E9gLpFdMd0YdhUKSPDhPruNO9ykIWQTBlhc+psjb+D3C2aH3tgusKqlykupO0vMsUEfn
 6ZhB5thl1iMazCkOyZK8c464Zr6Kcqd882oi51kIYtGwN9HZlUhU/LpHkTXO1hoPYjuI
 WFX6oaK+Nt/EN0p4W8uqTTHFY8c04GaJUjpWOu0AxK8lyTv/+PjHa0FO9mDXEkrLAqrJ
 izLj5VFH3kstGyu0JrOXRiA/g/+ihGieaTRpjYJe8KJodZGHOVcjE4smvclu4M8VjVii
 qQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=olz5IO/9nCkIveP2YP2rNfItXDo2ws5ArCaOiHTZe08=;
 fh=gP7RdfkoFupDb4wxvincWeBNKaMCWcANwH4AOs7ZxQ4=;
 b=TngVngqoUSoWdHoRiwLCSQZkRAtCMNOJPviimb/a40xAHwF/XuBukEnU8L26aF42hA
 znTAJdHorsiJalL3kvaaaW6w5fsOhdFd/k3a8DQfZ/02euTKLapNkHlLjb4FtaK1wEa5
 +dw7n4OtWpcqb/TNYv4jJKUKIxm0FLA3MGSEHTBJhNGVRaBE/s1BHADGTy+k7aiybSVb
 cvUDKKOo50InXuyir+KXLMNvHtM/oqlzkIpqJF8mOHfcZZhzs+3vA0+nU+ThiRwZw5jd
 jOe4Z2GgGib7Oh8bAcYjuW193fmoCn5X5GVhr5/lzvCUZ4a3VjZ5+E8zay4qHV2xKg4f
 72lw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782815251; x=1783420051; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olz5IO/9nCkIveP2YP2rNfItXDo2ws5ArCaOiHTZe08=;
 b=qWbXjFFEFuADq3ont+nmrOlWAh7aZKZcPeu9AS5MeQezj+scU7alNo7a4njJ+O8Msw
 dAAYdSoRc62O/6ggM0c+3rlPUh6LVGv7LZXGHC064bwT0MjgDfqU10lyOoTEBMI6kJaU
 a5Qw4jxsRos/uSIJ+n4amp3opbSvg6kpuPIz6Wm8jNdO+S/C0dMLxXewgDBr1gYLe5JF
 tlYl7AP3oD7AFHI0Xkhd15LBYTCTK1b0kkuCF3mygfZJE5rtsmOsvwCrp2bs0NLT90ZF
 /sm85J3gG8VSCDYr667SO7u5aH6ebesU3AGzHTyt+WOrd92qVRX03lZ6nXlkM4dq9fS0
 6TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782815251; x=1783420051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=olz5IO/9nCkIveP2YP2rNfItXDo2ws5ArCaOiHTZe08=;
 b=EEFHAtu0ec/Tu54jv6/iurTM9IrquKoi36Yq836LTqs1e0dtuO6zfGctBtJkHMj4Lb
 bGRTxxUWY3W/j4zkqse5z7aV/bAw58LWiRan8pTvJl+k7v0XGhYhMpQ2TwMpWRRKKUpn
 Bl0Fj1apRbGSB9SKXsBzrb5b1+V+ielPueixMtyotxQTKoxfL5RGV5GaohkDlkALXZQ3
 egIKtAmR/V4Bo50k/26NYDxHpm+uSRFHMPFKVTGS35kN4c+SHIAn2qPDt86uNr4cy2SN
 WNXk/dBUvupaITfS70+Ah/gF7U+kfW/LBCPLNXliGuDHd6b8pscUEEXn/T/FfrFpfZ5S
 SI0Q==
X-Gm-Message-State: AOJu0YwiYAL3s1I1gbopAmePf3zolHdqK1m7yH6KrZ1fvrjdafWIhHIJ
 N3z/SOIxdX0cBFASdmXIcKrauH5sPV3XPAqVZL7ufXC5i/8k6JOIjWDM6FVevQqeHRKs08TQ65r
 URUTOZXsQyOMw64ZEqqHHI5iuXG6nTTo=
X-Gm-Gg: AfdE7cl76ESXlvM/ugjD8Ck/t2y1N9/h6SOx6UDaaA7f00p4Ww5GKPgtsQtfc+bGYKs
 jGuaQRrJGzycqOaZoIsdYRgPhlgjO+sPRTGEWKgjSOIYNS0D/odsOpywkd17Ed8Pt7trtAPnq+J
 0K+emTATJM9qqRIDNOEw4V1gRmOc4npOEOnpXXVuxCDUQ6SsvSjNJUnHjQsd8d+LiFvI06stjeT
 HX8B+Sejf4afr6V1yzkrkYT2S2F0LJEjcg3sfsuLFXnj0dWttKVaCRt/TaILE2jJ21ih7ilYdFc
 fKy24OM6Uh2OeyFKk5xRqHQPfBfa
X-Received: by 2002:a05:7300:4342:b0:30e:d6ca:61ac with SMTP id
 5a478bee46e88-30ee13e52d4mr2453015eec.34.1782815250929; Tue, 30 Jun 2026
 03:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260630101022.379057-1-thuth@redhat.com>
In-Reply-To: <20260630101022.379057-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 14:27:18 +0400
X-Gm-Features: AVVi8CesBUVHGmgB3pxe3kSPmpkXu5mr-BkeEL4YtLLkI6CeTw8RP7vXvR1NpXg
Message-ID: <CAJ+F1CJR0+eaEZZm541J349atXXK3DRrTVce=7HTwgzz8A_tWg@mail.gmail.com>
Subject: Re: [PATCH] hw/display/qxl: Fix mono cursor validation that can read
 past a cursor chunk
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

On Tue, Jun 30, 2026 at 2:11=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> From: Thomas Huth <thuth@redhat.com>
>
> qxl_render_cursor() maps the guest-provided QXLCursor object using the
> guest-controlled cursor->chunk.data_size.
> For a mono cursor, qxl_cursor() then validates the expected bitmap size
> against cursor->data_size, but it does not validate that the first chunk
> actually contains that many bytes.
> A guest could set cursor->data_size to the correct full mono cursor size
> while setting cursor->chunk.data_size to zero. In that case, cursor_set_m=
ono()
> reads the AND/XOR masks starting at cursor->chunk.data. If the cursor obj=
ect
> is placed at the end of the QXL RAM BAR, those reads cross the mapped RAM
> region and could crash the QEMU process (e.g. under ASan).
>
> Fix it by double-checking cursor->chunk.data_size for the correct size.
>
> This patch is based on the suggested changes by the reporter in the bug
> ticket.
>
> Reported-by: huntr bubble
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3646
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/display/qxl-render.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
> index 7b692d5a854..3bf634ee059 100644
> --- a/hw/display/qxl-render.c
> +++ b/hw/display/qxl-render.c
> @@ -272,9 +272,11 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXL=
Cursor *cursor,
>      case SPICE_CURSOR_TYPE_MONO:
>          /* Assume that the full cursor is available in a single chunk. *=
/
>          size =3D 2 * cursor_get_mono_bpl(c) * c->height;
> -        if (size !=3D cursor->data_size) {
> -            fprintf(stderr, "%s: bad monochrome cursor %ux%u with size %=
u\n",
> -                    __func__, c->width, c->height, cursor->data_size);
> +        if (size !=3D cursor->data_size || cursor->chunk.data_size < siz=
e) {
> +            qxl_set_guest_bug(qxl, "%s: bad monochrome cursor %ux%u"
> +                              " data_size %u chunk_size %u",
> +                              __func__, c->width, c->height,
> +                              cursor->data_size, cursor->chunk.data_size=
);

Hopefully spice does chunk.data_size validation..
Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

