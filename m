Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235BDC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5lC-0002Bz-OK; Tue, 21 Jul 2026 04:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wm5lA-0002Ax-JM
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:23:28 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wm5l8-0002ZV-Qi
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:23:28 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38df94d4dd8so5587117a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784622205; cv=none;
 d=google.com; s=arc-20260327;
 b=MCc+a9Y00TFYyb5zwtil4F0vB9C/LkrpLnkblAaojptWKBTKvbY8+9qx0Ll5Qci5MW
 YHMdcH6qFvFG52wyqgOEgAavjmOXB5hl8R8SzN+mRXxDXEAEJ/N+UuQOjifiJuBMPZ3K
 r1BHO5kPUksdi+hC6ntI1GCVAETASrTnLbfcB8Ix4eBpaW4GXV2NcWoBhKdnCuZUFIx1
 CPI/6NNlUGuIqZzI9KO0NYlzL3tiiAkcFlkeUYpUf4AHO+SywEq+WP2MGCeO9KsbS/di
 pl9uMr80b5BqrG0e199ZbWH9U0H6b/N0gnLJpUU5wYkyhzt5J0SqFFAav71suIk+NGHS
 cmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=INYR4e+7+dTBOxPOL1ylOkobAciMTvW6KCHDN100P4k=;
 fh=DkcsS+wDAht8mg8Un44vEXzEP9PftsclVxpMktWLF+E=;
 b=UK1ajTNg1NBj1VaQrnmkaXUzFDRU/N+7Jr1KZ4rEGHAV1ubXQhitcwCGi/zumxEnyx
 NV+n4J8i9EtaDG8iLTj6g/2711djfwYom/GqA/x1vdIAvpooDiN1btT2D9Eh+m4eWWfx
 SaTfIj5R6+0WEMMSFPvuGdQb0vp4SDJu++m+RTHDrkMDqqZVooEe0rEIX6AqFV1GIRqB
 6fAuYUauH4PXpyh9LW75mdUVr9Hyrt/68rN6BHOJfxv1eZ0RIoOVis6JegM0fpwErN2m
 wm7M+OnBKhPey5orXG3m8BmVgwUf/VvzKWIDPlLqFqrZkzU/RWrxph4mBGnjNRjrGRgk
 VSvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784622205; x=1785227005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=INYR4e+7+dTBOxPOL1ylOkobAciMTvW6KCHDN100P4k=;
 b=tUPZbTXT7Hk8Y08o5Djo4uJbU3dZ2JRrCvNYu10l9nc3HHGx6frgyO/y6R0MoTUgB6
 4UuprvUONtn8HCuC3fy9E6nWCPcycJuE+FOhVdvP0SGk/5ENp8w9dIQ8tzk5FL3PKmyz
 wKlWPcSdNKc32QrHL3wKdl9s/JZmfkg/2Tgp/Zhqch6qGIaqQmkyjisrQtLzVMAclqfN
 WzCxTwy8pu9p37Fb/PogCNe+dF6mVdTeybTuR5nuQJ9Zh/SdISPstoezt8+zE6PqHdAC
 VTzS2FIK2QNego3CPXXMxj8b4nDg3wCQ3SYlnuEneDgVmcDZ3uUnR7zM5HuwJmjksHjW
 lgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622205; x=1785227005;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=INYR4e+7+dTBOxPOL1ylOkobAciMTvW6KCHDN100P4k=;
 b=Yp1tB0Xl+I5mhsUoKcYO7n1yKiovteA/OPChPRWASPBs0xPnuLV9RICeFXkggQLUCp
 SaGOVDRIqxTUuMbwXYh5HppfRjruLJ6Wtfl2hepHd8Hskpt1LNX0mcfCnr9Ta0YcecL6
 LXKEoYQVNpH76VxDZg4YmSguWyPV9SUbEhlLHQ7IMFpxpjIDMFJMIKdBUkCOmJ8uvqFW
 dwUrC5SgkHDMeeisEVhs2lxKVkv2MzVvtTV9nLTXo8y1de6u8O7DbYnwMTlEhb51c3ti
 VxXZtOU+JkJuortlhim85HYmhdbNfeqtcoW0mFSMcwjwM/lP1WojrzCsydEgBZohannV
 sdGQ==
X-Gm-Message-State: AOJu0Yw8tufgKbbEKfPrpnmTccjmwhzq1AfiV5PDfdTpPxC+3nlWW7EW
 axXOlBIxTP0L2fXyZwQuDzZ9fiugkt/QqP5HhJ/m5//bHoaBPoeSiF0l/Oy+hY+Q9b9k9Kk9PxP
 EB+htkNAh1J7HjRHa9VkJW04IJtnwIM7gBihpO1qdVQ==
X-Gm-Gg: AfdE7cmUY/7gwN1B76sbxapL5H7ZMuj6Ip20X7ehSXzCyEAEBO+YgtYmRUpT74U00Pv
 hC4Xadrs0aMqAqkv+hEY5Gf5YYElF7wJq+a++C11CXoC5G4TBfOJ3ZrH34D4moR8S2WCr/ZLEzt
 lxUEcnCe36M7z8lZevPy2mlEbaZpI/In7WUZXQmz1SuBMHxalRR+DAuEFJlbFbCVmlhpmFlWvYk
 OFwgnJxZd59iRGzcRZSm1nUOkopyqYLCIEawsNh5spADtffJxsbeRA5deRg/u0XZXzEoUJoTPfH
 +F2ig7IytKWo7bWBIQ==
X-Received: by 2002:a05:6a21:7d06:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3c3ad85e2f3mr18336253637.27.1784622204537; Tue, 21 Jul 2026
 01:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
 <20260717-fix-v1-7-cb9f7d49dc52@redhat.com>
 <CAFEAcA_jkg8G=hQdsS-FEaHd658SbJqTzMAWrmvjREmXXbx1hg@mail.gmail.com>
In-Reply-To: <CAFEAcA_jkg8G=hQdsS-FEaHd658SbJqTzMAWrmvjREmXXbx1hg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Jul 2026 12:23:11 +0400
X-Gm-Features: AUfX_mznjwXW-oyJXGXnoqO-rlFT83QfZs_rXXsUzbasjetxAfjiwIChgbns-TQ
Message-ID: <CAJ+F1C+mwgu_m48L-uGmuPuzmMr2W7jCPZeMQP00mxBx66wacw@mail.gmail.com>
Subject: Re: [GIT PULL 07/15] ui/vnc: fix out-of-bounds write in lossy refresh
 dirty marking
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x102e.google.com
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

On Tue, Jul 21, 2026 at 12:18=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Fri, 17 Jul 2026 at 12:54, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > vnc_refresh_lossy_rect() marks a full VNC_STAT_RECT (64) rows of the
> > dirty bitmap when refreshing a lossy tile. When the display height is
> > not a multiple of VNC_STAT_RECT, the last tile row is a partial tile an=
d
> > the loop writes past the end of vs->dirty[VNC_MAX_HEIGHT].
> >
> > For example, with a 2160-pixel-high display (VNC_MAX_HEIGHT), the last
> > stat tile starts at y=3D2112. The unconditional 64-row loop writes rows
> > 2112..2175, overflowing 16 rows (640 bytes) past the dirty bitmap into
> > subsequent VncState fields.
> >
> > Fix by passing the effective display height into
> > vnc_refresh_lossy_rect() and clamping the inner loop.
> >
> > Fixes: CVE-2026-61475
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3935
> > Reported-by: "Vulnerability Report" <vr@darknavy.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/vnc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 8d91cee4d9f..c957731877f 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -3000,18 +3000,18 @@ void vnc_sent_lossy_rect(VncWorker *worker, int=
 x, int y, int w, int h)
> >      }
> >  }
> >
> > -static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
> > +static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y,
> > +                                  int height)
> >  {
> >      VncState *vs;
> >      int sty =3D y / VNC_STAT_RECT;
> >      int stx =3D x / VNC_STAT_RECT;
> >      int has_dirty =3D 0;
> > -    int height =3D MIN(pixman_image_get_height(vd->guest.fb),
> > -                     pixman_image_get_height(vd->server));
> >      int rows;
> >
> >      y =3D QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
> >      x =3D QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
> > +    rows =3D MIN(VNC_STAT_RECT, height - y);
>
> Hi. Coverity points out (CID 1664010) that this added line...
>
> >      rows =3D MIN(VNC_STAT_RECT, height - y);
>
> ...is a duplicate of this pre-existing line, so it does nothing.
>
> Were you intending to clamp a different variable here ?

it's a rebase/merge mistake, original patch:

https://patchew.org/QEMU/20260710134921.2321027-1-marcandre.lureau@redhat.c=
om/

Are you sending a patch?

