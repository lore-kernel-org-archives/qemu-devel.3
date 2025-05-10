Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C0DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 16:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDmhh-0001Ka-Et; Sat, 10 May 2025 12:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uDmhf-0001KG-4m
 for qemu-devel@nongnu.org; Sat, 10 May 2025 12:05:31 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uDmhd-0007ev-Ee
 for qemu-devel@nongnu.org; Sat, 10 May 2025 12:05:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso3010857b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746893128; x=1747497928; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7w6u/K+jjAGvqxuoEObDTwiO8Ld7zXcOM3VbP7umGmA=;
 b=ZqAyTmeKzarY1t6fb0xaAmeQBXWVGp8cWMCG545ZPsnHgqrNfhlqLWM+09GCSQpF3k
 JT5d8Y/PQShbM8POKT/DLkhwe1EeUqsM2Zb7QoQ5F8DLV6+rWgrGiCzH/v6iqUwzibec
 m/DIjD8+hVuVnQlE7RoysTk/XbK6upuvjmKguhAMGXPABfXLT2Syuft3/SmEtPnsLdSi
 zQ9D3G+yksrEmFsKsAEKL8Df1aGBMzQW5LuyBs2G4sE/NEDolSq1K9eNFgqlGPXryPXD
 /mhT2zppmIvkQK8dzAKMaH1Twl5cWxn9C4468hoQGzMNBY5bEY7aqW2DiNE/m8e8d9iv
 DmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746893128; x=1747497928;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7w6u/K+jjAGvqxuoEObDTwiO8Ld7zXcOM3VbP7umGmA=;
 b=NLKWyv0la8fgO2rehM9N2bRB0q18g0d54nzkXJF6XEHD6D4L/Ve147uF4sf4D0ubct
 924m6JZa1D3M+bAi6HWFgnrLWenHl9+Sgm9BI/wLAwFWJ5s+YbCOBraZQZ5rSDw3wwiW
 H7e6mFWQCHWQRpvxZdoalgPA26JbXqZYXMNsff9CwMNq8m31jBAqznUrEZ6+63hGe2uZ
 TZeyYRFuNhltBQI4tRbIzTb5wwrELDZPGLKka+y1LfgkUypaMhmQKYZLiVd/NbZ7eCSy
 5zyck9YTwq/PkMVWUOCi0J79OcbXMNzQhP3IAhsv9swr5+pEhOHV0elAQ/ZVK1QnC/1P
 OgQQ==
X-Gm-Message-State: AOJu0YxE/zA/CsnFv8ZpxhgR9xdSxXVD2q/AEPA1hH/o2vrtcyyhzeYj
 uglXAIvj6m8DbU6b5Wy7SGvXJP301bBd8JqA9zBFbjjfutFe8sxaItl8ynXp
X-Gm-Gg: ASbGncsmjN+ClPw5jKrQZEg9FXLFYLX3SWuWJ9XGmf8BLaOBJNPe2uw3nP28ECq1/gN
 X6zuFOHhqDgBDintk1redvNzmqG+a5AyFUR4msQGQqiqLprp/TmLa29jF7HsLwyJb9OzMtpxAcc
 QimwZmXEojOFDbvvoNBSt8A09YTGALe8Pdox6k5oGhfsmfR4aVjpbSESrzUx4EojyDW6u7O3ukH
 oiXZsywob6VlWela4ybCMFa2qA1C9J7gUo3e8bDpUwZGtJulRRfoHlQLlpfek5Y3QKw4cnUTjYm
 3e/iC0dqS/WrjHypS0j6Q5Le3I8dAlsRaPYOxi07T2gMjrhAPxGzgKIqp7m6WtdGaC1FFCA7WKQ
 =
X-Google-Smtp-Source: AGHT+IG5tBra8iMuYVtjtior9CZYn6pXhNjttxocz0qDZF2QmJxmAuz9PV4XW6wyLlk/k7aScy5Xwg==
X-Received: by 2002:a05:6a00:10c9:b0:740:6f69:dce9 with SMTP id
 d2e1a72fcca58-7423b2f7d37mr10595768b3a.0.1746893127630; 
 Sat, 10 May 2025 09:05:27 -0700 (PDT)
Received: from [192.168.31.160] ([117.143.179.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3d3e9sm3349469b3a.125.2025.05.10.09.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 09:05:27 -0700 (PDT)
Message-ID: <64502a9a9073d919c2524686ba8ef54929a30446.camel@gmail.com>
Subject: Re: [PATCH] ui/gtk: Properly apply x/y scale when rendering GL area
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, hikalium <hikalium@hikalium.com>, Alexander
 Orzechowski <orzechowski.alexander@gmail.com>, Gerd Hoffmann
 <kraxel@redhat.com>
Date: Sun, 11 May 2025 00:05:23 +0800
In-Reply-To: <CAJ+F1C+jPtvsY0yy9rZJLRLME9cC=p1bRGrXA3G1XQfJUmDXrg@mail.gmail.com>
References: <20250419094959.224954-1-weifeng.liu.z@gmail.com>
 <CAJ+F1C+jPtvsY0yy9rZJLRLME9cC=p1bRGrXA3G1XQfJUmDXrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x436.google.com
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

Hi Marc-Andr=C3=A9,

I am WIP on a patch set including a successor of this one as well as
other fixes, doc and refactoring regarding scale handling. Hopefully
the patch set would make scale handling into good shape. I will send
the patch set out ASAP.

Best regards,
Weifeng

On Mon, 2025-04-28 at 15:23 +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Sat, Apr 19, 2025 at 1:51=E2=80=AFPM Weifeng Liu <weifeng.liu.z@gmail.=
com> wrote:
> >=20
> > On startup, scale_x and scale_y were set to 1 that didn't reflect the
> > real situation of the scan-out, resulting in incorrect cursor
> > coordinates to be sent when moving the mouse pointer. Simply updating
> > the scales before rendering the image fixes this issue.
> >=20
> > Cc: hikalium <hikalium@hikalium.com>
> > Cc: Alexander Orzechowski <orzechowski.alexander@gmail.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
>=20
>=20
> Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> (Hopefully someone has enough motivation to actually understand this
> change better - otherwise I'll simply queue it?)
>=20
> > ---
> >  ui/gtk-gl-area.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> > index 2c9a0db425..01235f876a 100644
> > --- a/ui/gtk-gl-area.c
> > +++ b/ui/gtk-gl-area.c
> > @@ -42,6 +42,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
> >  #ifdef CONFIG_GBM
> >      QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
> >  #endif
> > +    int fbw, fbh;
> >      int ww, wh, ws, y1, y2;
> >=20
> >      if (!vc->gfx.gls) {
> > @@ -53,6 +54,11 @@ void gd_gl_area_draw(VirtualConsole *vc)
> >      ww =3D gtk_widget_get_allocated_width(vc->gfx.drawing_area) * ws;
> >      wh =3D gtk_widget_get_allocated_height(vc->gfx.drawing_area) * ws;
> >=20
> > +    fbw =3D surface_width(vc->gfx.ds);
> > +    fbh =3D surface_height(vc->gfx.ds);
> > +    vc->gfx.scale_x =3D (double)ww / fbw / ws;
> > +    vc->gfx.scale_y =3D (double)wh / fbh / ws;
> > +
> >      if (vc->gfx.scanout_mode) {
> >          if (!vc->gfx.guest_fb.framebuffer) {
> >              return;
> > --
> > 2.49.0
> >=20
> >=20
>=20

