Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96178C3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 02:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEf4p-0007Kk-Im; Mon, 12 May 2025 22:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uEf4n-0007KY-Vl
 for qemu-devel@nongnu.org; Mon, 12 May 2025 22:09:02 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uEf4m-0004rs-37
 for qemu-devel@nongnu.org; Mon, 12 May 2025 22:09:01 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b245ff89c99so2918839a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 19:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747102138; x=1747706938; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZkYSlBDy6S/j+45bmjYfHQH87+y36T9uGExbE0z1iA=;
 b=EHOXCFrPFNMuDNi/JYISli5n5UtAgAO0+vYZklq9BQgCzVZ2hjUHAD3Evmnn5lCSF6
 2uaz8PNrbmu7dNxMZat+qgobPhiStY/i8tRNGk4oMUfz7fCQq+r923nY+9WfVHigKJCy
 eeXD5PgRK2cpEw1l+5kZK12qM+29zj6dmn8UJTNnZl75ysOc6yuPZ7PBMHCxzZcuzvT7
 W8M+BftYzoclDpQKBH8Z+5+/2/QauI1nERz35Vb1ldnmr3QZ5kenTPBcwvDq+axYhcR1
 PQuL3t2XO5Gcq9s4uWl2v/wmwJhR4/HPT74gSX+bBtspEwy2d9ujJsXd/14aETn2Gxl/
 f+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747102138; x=1747706938;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZkYSlBDy6S/j+45bmjYfHQH87+y36T9uGExbE0z1iA=;
 b=HqO72KqDhuOG9er3XzwXpkeDB6Fpw206Xibhgd1e3pgD7qGO4UBTb0mJWIN2NqLcK1
 +0fQQlCYr9kfT3bkCXCB1K5Zkp+sy3cgC0NmzlPIoYLJQlUiV6s7+zb8cLQo/5CEFyDv
 bJiLptSU7hgIlsi49fPX0ru+o2cpP1trfYlqEfzSUSNu3svaldZl0HermIRDJvj0daqv
 a+cRtD7+V/4u8sUUTUSdXg05zETP2fnZ4mXxwOuW7uPNJsHMizkS+SRdbKQm+jGY2RML
 VEpvj9+oiMzKud42XwoK5JnjH02xtkHHvzpgDQg3LhNhzuubxuSPGE7H85l+J4rOrPuT
 QprA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz80ifNudNB8wy99p+pQXF1S3nOBxpm6fENvF6KuiowVmW3VmL5f9+lsDfWsMYkNDiAyQLMo8XKunR@nongnu.org
X-Gm-Message-State: AOJu0Ywn9s70RpFgj+2WM08tBUtRkUT7H3IckuDJBhKS37sT5eJrLNDG
 y9SV8sOfkDFu5ErIqdGHk5yhZdp4c5FrH0V7GxtBRv70w740/luT
X-Gm-Gg: ASbGnctsdv0R77ikkIbtRrG03Jqi67N5/6ocLbnErf26Bie0bOdcUxZW+f7WdSurAPe
 fXMrkNxN64DKNPUEVYB7k18xMcPsJ81t6wlAf6GHKI2p04kF1pIauJbk1G/JPzSJ3yCjgHf3abk
 VLanG5YjECujqLDNEE0942ggbaLxsy7OaZA/3q4i5BIuy1snQVwrX5i8DjYhYq97Nd3p1xsh90z
 AqrUC6yo0ykiUI0axKOFGMBGaE+5Ms2M6tu6tsvFnJY32f7WmvuJovPvwjgYQKoIUryXMZ2k8Ch
 rtNlMYxPtvX/H7Vh/PrIr+1wE9ikoRun+Jx9J+6b2N4fwVpYaG0M0aV5uaWa47JBmjyV4ZgQpA=
 =
X-Google-Smtp-Source: AGHT+IGA0iAgt+aRJ6pTYvXA/eR08UhJ80WkRcn0DJwd4xhz3mgkgAk6nMDibfz2LTMyfLVg5Z4XUw==
X-Received: by 2002:a05:6a20:7f9c:b0:1fd:f4df:96ed with SMTP id
 adf61e73a8af0-215abc17b56mr21708956637.26.1747102137728; 
 Mon, 12 May 2025 19:08:57 -0700 (PDT)
Received: from [10.239.152.184] ([134.134.139.75])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2351b7a6bdsm6283865a12.69.2025.05.12.19.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 19:08:57 -0700 (PDT)
Message-ID: <c70f48302d69f447e306ca2ced2abe9f3d1b7631.camel@gmail.com>
Subject: Re: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Date: Tue, 13 May 2025 10:08:54 +0800
In-Reply-To: <PH8PR11MB6879A5858D3F4EA9F4EDB149FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-4-weifeng.liu.z@gmail.com>
 <PH8PR11MB6879A5858D3F4EA9F4EDB149FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pg1-x536.google.com
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

Hi Dongwon,

On Tue, 2025-05-13 at 01:26 +0000, Kim, Dongwon wrote:
> Hi,
>=20
> > Subject: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
> >=20
> > The code snippet updating scale_x/scale_y is general and will be
> > used in next
> > patch. Make it a function.
> >=20
> > Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> > ---
> > =C2=A0include/ui/gtk.h |=C2=A0 2 ++
> > =C2=A0ui/gtk.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 30 +++=
++++++++++++++++-----------
> > =C2=A02 files changed, 21 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/include/ui/gtk.h b/include/ui/gtk.h index
> > aa3d637029..d3944046db 100644
> > --- a/include/ui/gtk.h
> > +++ b/include/ui/gtk.h
> > @@ -224,4 +224,6 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
> > =C2=A0/* gtk-clipboard.c */
> > =C2=A0void gd_clipboard_init(GtkDisplayState *gd);
> >=20
> > +void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw,
> > int
> > +fbh);
> > +
> > =C2=A0#endif /* UI_GTK_H */
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index 8f5bb4b62e..47af49e387 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -801,6 +801,24 @@ void
> > gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget
> > *widget)
> > #endif=C2=A0 }
> >=20
> > +void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw,
> > int
> > +fbh) {
> > +=C2=A0=C2=A0=C2=A0 if (!vc) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 if (vc->s->full_screen) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc->gfx.scale_x =3D (double=
)ww / fbw;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc->gfx.scale_y =3D (double=
)wh / fbh;
> > +=C2=A0=C2=A0=C2=A0 } else if (vc->s->free_scale) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 double sx, sy;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sx =3D (double)ww / fbw;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sy =3D (double)wh / fbh;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc->gfx.scale_x =3D vc->gfx=
.scale_y =3D MIN(sx, sy);
> =C2=A0
> I assume you are trying to keep the w/h ratio same here in case free-
> scale =3D=3D true.
> Why would we do that? We can easily stretch the host window to any
> direction then the scale-x and scale-y
> could be different any time.
>=20
Currently, the code doesn=E2=80=99t clarify how we should handle aspect rat=
ios.
However, I noticed that in the gd_draw_event function, when free-
scale=3Dtrue, it preserves a fixed aspect ratio. I believe this is a
reasonable approach (in my humble opinion, it's unlikely that people
want to see distorted images), so I=E2=80=99ve decided to retain this behav=
ior
for now and align other parts to follow the same logic, ensuring a
consistent experience for users.

Best regards,
Weifeng

> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > =C2=A0/**
> > =C2=A0 * DOC: Coordinate handling.
> > =C2=A0 *
> > @@ -908,17 +926,7 @@ static gboolean gd_draw_event(GtkWidget
> > *widget,
> > cairo_t *cr, void *opaque)
> > =C2=A0=C2=A0=C2=A0=C2=A0 ww_widget =3D
> > gdk_window_get_width(gtk_widget_get_window(widget));
> > =C2=A0=C2=A0=C2=A0=C2=A0 wh_widget =3D
> > gdk_window_get_height(gtk_widget_get_window(widget));
> >=20
> > -=C2=A0=C2=A0=C2=A0 if (s->full_screen) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc->gfx.scale_x =3D (double=
)ww_widget / fbw;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc->gfx.scale_y =3D (double=
)wh_widget / fbh;
> > -=C2=A0=C2=A0=C2=A0 } else if (s->free_scale) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 double sx, sy;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sx =3D (double)ww_widget / =
fbw;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sy =3D (double)wh_widget / =
fbh;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc->gfx.scale_x =3D vc->gfx=
.scale_y =3D MIN(sx, sy);
> > -=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 gd_update_scale(vc, ww_widget, wh_widget, fbw, fbh)=
;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 ww_surface =3D fbw * vc->gfx.scale_x;
> > =C2=A0=C2=A0=C2=A0=C2=A0 wh_surface =3D fbh * vc->gfx.scale_y;
> > --
> > 2.49.0
> >=20

