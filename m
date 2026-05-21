Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCC6CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Ya-0004Qx-3R; Thu, 21 May 2026 07:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wQ1YY-0004Qo-Dc
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:27:14 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wQ1YW-0003Q1-RG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:27:14 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-30246cfd41aso1145586eec.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 04:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779362831; cv=none;
 d=google.com; s=arc-20240605;
 b=RIPNw/pE0K1r8NdO3/hyyFH5wU6OoWd/ePh6mXZR0mRd2w6edlPvoq9Px6/nmnRf2K
 YmK141Gy+rdTHTfShXAX9hD5OBWZcSRVLTMv//xm8MgfcZFXeSLABYUpbG1XGeix3JY0
 794BmLIDhHrzkrkF2SkHXVPzv2r9l/IgOgS22eqYp/phdaaI6FRiTwk047+57UC66e7B
 Yd8cAvgXiNF9yoC0LmXb+Dw55lVi9Sxc66Z8bV6YFcFTG56szJ7kd8hmxBUxqdCg2htT
 ML60IyFaRoUVEzjN83PzoBza+QoIdCz9k+W5d+bvXJjOWKVSN7kl7WD233SVb0YhyA51
 ICEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MnJX8giKMMws4LZnKYZArQEPZSOO3hq9yp4C0wmi8Nw=;
 fh=WGtvPtDMCkAjRA4d/jtFzNmV+udS6Hs2/oRMXjHEAmY=;
 b=V6/Ns/iRiWBeIvbrpL7RWR9Aj/yNl5OyAyjvBwEFYV2e2aqTtnn6aFg5RTK/RJGX+y
 u1XKpJI0H3QHav3Tv9oRnl+SXjzGtXGWFDbC2FgySOvij/OhT6X4+trMGmBEpt5nvO23
 pfpFX/wIZMVko4ntda1Sl5x/aCEQgzFWGTXTy+sU+IInMUNtL84m55xhd4kmPd6eHEox
 +5aGbcTY9sVVCfAMHUVEa9/MTgZn2pANyWJ4PDvHbKVanji/1s+XDR1DJetO4RKjUEKD
 tRiTqq/A/LROM69Fc9GDxfQCLN18Y1rhJKkkiowJ8ye+pCwrQ8GMBOot2v55/y3gmHnv
 1LBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779362831; x=1779967631; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnJX8giKMMws4LZnKYZArQEPZSOO3hq9yp4C0wmi8Nw=;
 b=HY+qtwpRcQ38GHIz13qpRdBUFwlpFGfJD/G6KpKQUupsPY8od6iSpfz0iicmGbZrno
 cuAyv4By+ykMoq+HrnUwa3MMaGmvT/6RX0AlACkPZYO3+xdie7rnjS4og3/+xg9D3CRv
 LQLfSKFtSwsS7PzK5WE9esZIZoRM04Y/XEfyyWHrPZe2fnf/W7Ro/0QAWbwZRcjNbjbv
 TQ+GQW5bSO9nddBvULTxaEzU9kU3HNNPDWh+mAdRGrZbZZpx0RmEugnFX6xxWDr3kpvF
 fpb9mGLI6IYD85Hu1X1k+DvcckoirNsz8eHpFrvhrNSkuBK3zCBCGXN3JgD5ILkupuJf
 GHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779362831; x=1779967631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MnJX8giKMMws4LZnKYZArQEPZSOO3hq9yp4C0wmi8Nw=;
 b=LR5e3NLihxZnzRDuf6JUQB3+p9XrCalv/50D5PIr/y5O65XttY9Ow1QFhtTW3hEFZ1
 bZ/gqTKraR//JxRKkALRl1jTBdRrQpCRcvO9Np96NAf5CI6m5sVyV7LGPpDZFW0vZQ9o
 k4Q0kBOlu+VzNKPMarFhuzopXTE6e8uv8PKpdD3SS/9iC8dEwkSclijU1JNIHs39jr0Z
 hkg0FmADyrSq/IFSZQbF7K+yOT7bIJYN394SvPvUrreS977FWVHObXs4dfxSc6vS/VKb
 ajEmpUneKyayySO6LrtUqjZob9W3JdAY10IktpgGki1ElAUKYN3dnlhHJK3gbCXlAEa/
 rQfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/M+tcQKLdYHWh0Wwwmnh+t4BxMP23SwhOFGC4MMxNEL+2qSeKzNeNlJHJ09NNnMl2dFFQPXlpPXgJz@nongnu.org
X-Gm-Message-State: AOJu0YyTuoJq+lFzUePe08vqQzGgeNlG2JvAuwHmWfn7cwqRRpr2cX43
 QjGNJxh7kNAydeED7WRQog4X9qBYCd/6+xo5X5sEsgqAuzuqjoviiGrtrtOLL5zkHNR1FOl6aJn
 urU4MM0BAFw/79uTH9GykygHImuNpjEo=
X-Gm-Gg: Acq92OH2kIw4VOVyIo7SJmWpTbKbdUQSG6i6wO6DwC5EF6pdBSg8PP39FYP+3Cg8qdO
 mpLA2qYC9oy3uNIUjBfeRQX+5Q7bGubFIcBkb1VxmLffxh9ZSKT5DOdpNO1DLFzWXNRYYKI0eFr
 qgBot931usj3ilyODA+pv5FUk1qOcQuBLIlA+43jQlCI3E1fM1ODbt82yqXXHRzoVb56hZSgnff
 TuVx2XGxpyxs6zXayc0hOOpxWZOaq5NQPA47Psxo3ofd/JNT4SqwUYdK7w/gGzqR7tqfL65Nt/M
 k9EW6xrLo5Vh6Jw5IDOFZvF1NCW1MDstyI99WhH2nIXnbsuuFw==
X-Received: by 2002:a05:7300:6da0:b0:2df:919f:ce59 with SMTP id
 5a478bee46e88-3042f9ce3ccmr1416086eec.19.1779362831085; Thu, 21 May 2026
 04:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260521103353.1645561-1-berrange@redhat.com>
 <20260521103353.1645561-4-berrange@redhat.com>
 <33b6d382-b48b-4212-bf3c-6f01b742cad0@linaro.org>
In-Reply-To: <33b6d382-b48b-4212-bf3c-6f01b742cad0@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 15:26:57 +0400
X-Gm-Features: AVHnY4IpbqjxriSqeiiSFPhqiFJDmOqam9GbVkQsgNUYwhWi0BMPpaZ8qMkLfK0
Message-ID: <CAJ+F1C+KnGGmUchjQjs2851hVEXn4dyk8DN2RjHC+tDd+r4WDA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ui/vnc: fix OOB write in lossy rect worker code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1336.google.com
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

On Thu, May 21, 2026 at 3:22=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 21/5/26 12:33, Daniel P. Berrang=C3=A9 wrote:
> > Incorrect calculation of the boundary condition when tracking lossy
> > rectangles in the worker thread will result in an OOB write which
> > can corrupt further worker state, and/or trigger any guard pages
> > that may lie beyond the VncWorker struct. This can be triggered
> > through careful choice of the display resolution in the guest
> > OS by an unprivileged user.
> >
> > Fixes: CVE-2026-48002
> > Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   ui/vnc.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 56dd43d53f..ee567700a5 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -2982,13 +2982,13 @@ void vnc_sent_lossy_rect(VncWorker *worker, int=
 x, int y, int w, int h)
> >   {
> >       int i, j;
> >
> > -    w =3D (x + w) / VNC_STAT_RECT;
> > -    h =3D (y + h) / VNC_STAT_RECT;
> > +    w =3D DIV_ROUND_UP((x + w), VNC_STAT_RECT);
> > +    h =3D DIV_ROUND_UP((y + h), VNC_STAT_RECT);
>
>         assert(h < VNC_STAT_ROWS);
>         assert(w < VNC_STAT_COLS);
>

with <=3D, yes, I can add this while taking.

> >       x /=3D VNC_STAT_RECT;
> >       y /=3D VNC_STAT_RECT;
> >
> > -    for (j =3D y; j <=3D h; j++) {
> > -        for (i =3D x; i <=3D w; i++) {
> > +    for (j =3D y; j < h; j++) {
> > +        for (i =3D x; i < w; i++) {
> >               worker->lossy_rect[j][i] =3D 1;
> >           }
> >       }
>
>

