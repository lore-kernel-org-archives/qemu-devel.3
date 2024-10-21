Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DA9D0E6F1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qNI-0007Oa-E7; Mon, 21 Oct 2024 07:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t2qNF-0007OC-D6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t2qND-00074y-BC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729509292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wN7/9PwdN1K876oOX1TIfyRrvxSus3Ode7lg3FyU/Ic=;
 b=VyN1YX5JO3sBkqTsuy5bLMHPwfQWYX7LXKTQs/AuuTxGYymROaN5VNNE8MgZa12S7rqt6A
 xkvnXxmR/6p9lOBXCgkCVrZ7QQypZf1lpWCoiGsN5EGsK67wCspP1cFEBqEJLTytGxt5G8
 uSfEml0CUPK9obF76HPxE9MB7wVYQlU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-Uf1PXpO2PImV7VjJ2bLE6Q-1; Mon, 21 Oct 2024 07:14:51 -0400
X-MC-Unique: Uf1PXpO2PImV7VjJ2bLE6Q-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e290947f6f8so7444818276.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 04:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729509291; x=1730114091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wN7/9PwdN1K876oOX1TIfyRrvxSus3Ode7lg3FyU/Ic=;
 b=xC/bp/6KEucV6W9fBmjXm3u2h5WpM6m3dtyhW0mk/JBw7cKmvgdeuVmaK1FHWyRTf8
 pVJ+KQ7e2pGq8q+0zRW5NF9KI0pfkCe6KT7k9dUX0jaEZZmsXu4FzS/m338IWEVcGYbN
 NiAHJZUMRashGQPiM8jepaX8dEfsV/CBVSqMSDN1MXOVUyhs1R6l1oL1oDFeESs7SxNu
 vOFKJukZDJHq/3IXpH6cL4BxmyNE6UhftPj7azKKdVdXmB6V372nisqHvVjzfPXI6FJF
 /ABh9/iEjgOzpYLg7G6uVKDfRKV6MiBfMENW+4ApwNXjeg7lAh6EAYtZbLJDkCwHSip+
 39ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQVjf1NcdphZhjnsZ+DlX60d30BMK7iLfigus7UAjgqyxWzVFdVAkmX9PjL/5hGjU+1nXgNLaoofjh@nongnu.org
X-Gm-Message-State: AOJu0YzQ4ho54xUsGoKlmeZDVJcZ8p6hc9ediHoHMrFxFVhPa4DzW2Yr
 Uzg2ck3q2x4bYlqzHbdudwbWD5AT0RAnkVY3apIURY0/cOpe2jyhW/wPQwXmy+WfoIdyXjPQVWO
 nNSuYPB3/hscYf4kW1I71UExCHYGE8bJZ8ViXoMV3rQxtCRTvZsKaZSwqxL4TTTErwVa4+GVzvn
 +CD7BJYn9z74WCoNi01UY3kGYOtzA=
X-Received: by 2002:a05:6902:20c6:b0:e28:687e:c151 with SMTP id
 3f1490d57ef6-e2bb16c33a2mr9429454276.54.1729509291256; 
 Mon, 21 Oct 2024 04:14:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYbck/zun4az+mb4Szi0Cu+LkZxBz5m7pJRgNEX12wqo3QVLJ5fyMd5Fjtk7AhwjmAzhAEylha/fxvRqY0zyQ=
X-Received: by 2002:a05:6902:20c6:b0:e28:687e:c151 with SMTP id
 3f1490d57ef6-e2bb16c33a2mr9429432276.54.1729509290848; Mon, 21 Oct 2024
 04:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-2-roqueh@google.com>
In-Reply-To: <20241017215304.3916866-2-roqueh@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 21 Oct 2024 15:14:39 +0400
Message-ID: <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui: Allow injection of vnc display name
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: ankeesler@google.com, mst@redhat.com, qemu-devel@nongnu.org, 
 venture@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Roque

On Fri, Oct 18, 2024 at 1:53=E2=80=AFAM Roque Arcudia Hernandez
<roqueh@google.com> wrote:
>
> From: Andrew Keesler <ankeesler@google.com>
>
> Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display Identifi=
cation
> Data) is propagated by QEMU such that a virtual display presents legitima=
te
> metadata (e.g., name, serial number, preferred resolutions, etc.) to its
> connected guest.
>
> This change propagates an optional user-provided display name to
> QemuConsole. Future changes will update downstream devices to leverage th=
is
> display name for various uses, the primary one being providing a custom E=
DID
> name to guests. Future changes will also update other displays (e.g., spi=
ce)
> with a similar option to propagate a display name to downstream devices.
>
> Currently, every virtio-gpu virtual display has the same name: "QEMU
> Monitor". We hope to be able to inject the EDID name of virtual displays =
in
> order to test guest behavior that is specific to display names. We provid=
e the
> ability to inject the display name from the display configuration as that=
 most
> closely resembles how real displays work (hardware displays contain stati=
c EDID
> information that is provided to every connected host).
>
> It should also be noted that EDID names longer than 12 bytes will be trun=
cated
> per spec (I think?).
>
> Signed-off-by: Andrew Keesler <ankeesler@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>  include/ui/console.h | 1 +
>  ui/console-priv.h    | 1 +
>  ui/console.c         | 8 ++++++++
>  ui/vnc.c             | 8 +++++++-
>  4 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 5832d52a8a..74ab03ed72 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);
>  uint32_t qemu_console_get_head(QemuConsole *con);
>  int qemu_console_get_width(QemuConsole *con, int fallback);
>  int qemu_console_get_height(QemuConsole *con, int fallback);
> +void qemu_console_set_name(QemuConsole *con, const char *name);
>  /* Return the low-level window id for the console */
>  int qemu_console_get_window_id(QemuConsole *con);
>  /* Set the low-level window id for the console */
> diff --git a/ui/console-priv.h b/ui/console-priv.h
> index 43ceb8122f..9f2769843f 100644
> --- a/ui/console-priv.h
> +++ b/ui/console-priv.h
> @@ -18,6 +18,7 @@ struct QemuConsole {
>      Object parent;
>
>      int index;
> +    const char *name;
>      DisplayState *ds;
>      DisplaySurface *surface;
>      DisplayScanout scanout;
> diff --git a/ui/console.c b/ui/console.c
> index 5165f17125..f377fd8417 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *con, int =
fallback)
>      }
>  }
>
> +void qemu_console_set_name(QemuConsole *con, const char *name)
> +{
> +    if (con =3D=3D NULL) {
> +        return;
> +    }
> +    con->name =3D name;
> +}
> +
>  int qemu_invalidate_text_consoles(void)
>  {
>      QemuConsole *s;
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 93a8dbd253..7d6acc5c2e 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts =3D {
>          },{
>              .name =3D "power-control",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "name",
> +            .type =3D QEMU_OPT_STRING,
>          },
>          { /* end of list */ }
>      },
> @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error **errp)
>      QemuOpts *opts =3D qemu_opts_find(&qemu_vnc_opts, id);
>      g_autoptr(SocketAddressList) saddr_list =3D NULL;
>      g_autoptr(SocketAddressList) wsaddr_list =3D NULL;
> -    const char *share, *device_id;
> +    const char *share, *device_id, *name;
>      QemuConsole *con;
>      bool password =3D false;
>      bool reverse =3D false;
> @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error **errp)
>      }
>      qkbd_state_set_delay(vd->kbd, key_delay_ms);
>
> +    name =3D qemu_opt_get(opts, "name");
> +    qemu_console_set_name(vd->dcl.con, name);

Why not expose a "head_name" property in QemuGraphicConsole?

This way it should be possible to set the name with QMP qom-set.


