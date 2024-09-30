Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E74ACF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBVB-0004Sq-2S; Mon, 30 Sep 2024 04:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svBV8-0004FT-1D
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svBV6-00059C-54
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727683883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9smea9MQS9nrF0kQil3og1DBQ94/GfdG9cC42+9p/lY=;
 b=h65LFLnp9EUH6mfWnA9GAC+5yAa6qzbjQOsXv/BRPFHHzCAuj7Tlofv+hIxVZBhSogofWD
 R6glH17pwt/AXYu+FME235ja8A0aDanuHpx1VkZzBKA+EpPkwTxb/GDgdlKmrZ2dWDpRL3
 8uZRtAqWCrZdxqypLG6hpgSDmVNExi8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-6OO9GN7uNOa7MMAjiKqqRg-1; Mon, 30 Sep 2024 04:11:21 -0400
X-MC-Unique: 6OO9GN7uNOa7MMAjiKqqRg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6e000d68bb1so59520507b3.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683881; x=1728288681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9smea9MQS9nrF0kQil3og1DBQ94/GfdG9cC42+9p/lY=;
 b=KFAHQRFAeR4FkTW83R/JCuLlQP8tbI8OydVNcVj5SHq6uHimkJiYEAmHOWq3YKcyDU
 OnT/NFLEw75p5Nw2cSCwtaa0+7KT5bkPlSGtrn4nyrREFZTeLWHchNsCokVGsxCxNARr
 hvB7HdIqEoZWcBx9GFBeGas96VeGIZJ41t8GMl6bvXxo8ODB9XKsY+aSg8N6UQFqWIHN
 J5v732Rxai9g/Y1XKHmDVuXHkyfHVq+Y2yvycd4viiDR7WiX4gicwQg92O1DfRydf/g9
 M0/OPEwDa1ES9U2tawljOwaTeKYsLwfrLMVEdxHZ/3CyE+rtz8SpVGG2AJQnwKGgVROf
 AZLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUtHW+mUH0GORoR+Ro981FRh3MzZrSRSCufmYZDSlWcRwzyzeP2IWVJ8NvbznXGCGTaNH5KHNuIL2R@nongnu.org
X-Gm-Message-State: AOJu0YySN/bsJDIleunbWmGYug7vo2mPzRG2RveIH4YBWyJjHn9GSS6O
 9EyhVviZeDkC5I6kGS5mElXKA/0nZulcRI25eOJHaccZWC0A592upcM8XRt+o0H+oCp3pv4DrpB
 WrIrSuvQDmQGAmaO6GLne1FPyD9bOfp7fsGcmlppSiQDI1fdBJ/atbUBAFYbN0yu+XFp0+aXbFl
 Fxiing4jTZF2VYkke6utqprH3j7Us=
X-Received: by 2002:a25:d652:0:b0:e11:579f:9a6a with SMTP id
 3f1490d57ef6-e25ca9125c9mr9671260276.13.1727683881029; 
 Mon, 30 Sep 2024 01:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkA5X/p+DdvVLB9NA9xEwNqk7tDbE5DrPLf0cSWx/1r2lygEzEc9f0BntSjWqNgnkYWkWt+6DbuUwIg4xWA/4=
X-Received: by 2002:a25:d652:0:b0:e11:579f:9a6a with SMTP id
 3f1490d57ef6-e25ca9125c9mr9671215276.13.1727683880649; Mon, 30 Sep 2024
 01:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-19-marcandre.lureau@redhat.com>
 <swzpet5rpne5arwq32i5vrinpguremvrq4sqb73byfw5n2uuzx@s4hi7thksiif>
 <CAJaqyWeO925F6W6OgNRainpiqECXdB27AkDyUhF-6o9i7BPjoA@mail.gmail.com>
In-Reply-To: <CAJaqyWeO925F6W6OgNRainpiqECXdB27AkDyUhF-6o9i7BPjoA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 30 Sep 2024 10:11:09 +0200
Message-ID: <CAGxU2F6GJXZKcfs=1iaKqt8xy5=T+S2yJG6cOxptYmeZJmYfcA@mail.gmail.com>
Subject: Re: [PATCH v2 18/22] hw/virtio: fix -Werror=maybe-uninitialized
 false-positive
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Hyman Huang <yong.huang@smartx.com>, 
 Klaus Jensen <its@irrelevant.dk>, Alexandre Iooss <erdnaxe@crans.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Bin Meng <bin.meng@windriver.com>, 
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 27, 2024 at 3:08=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Sep 25, 2024 at 10:08=E2=80=AFAM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> >
> > On Tue, Sep 24, 2024 at 05:05:49PM GMT, marcandre.lureau@redhat.com wro=
te:
> > >From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > For the title: I don't think it is a false positive, but a real fix,
> > indeed maybe not a complete one.
> >
> > >
> > >../hw/virtio/vhost-shadow-virtqueue.c:545:13: error: =E2=80=98r=E2=80=
=99 may be used uninitialized [-Werror=3Dmaybe-uninitialized]
> > >
> > >Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >---
> > > hw/virtio/vhost-shadow-virtqueue.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shad=
ow-virtqueue.c
> > >index fc5f408f77..cd29cc795b 100644
> > >--- a/hw/virtio/vhost-shadow-virtqueue.c
> > >+++ b/hw/virtio/vhost-shadow-virtqueue.c
> > >@@ -526,7 +526,7 @@ static void vhost_svq_flush(VhostShadowVirtqueue *=
svq,
> > > size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
> > > {
> > >     size_t len =3D 0;
> > >-    uint32_t r;
> > >+    uint32_t r =3D 0;
> > >
> > >     while (num--) {
> >
> > I think we should move the initialization to 0 here in the loop:
> >
> >            uint32_t r =3D 0;
> >
> > >         int64_t start_us =3D g_get_monotonic_time();
> >
> > ...
> >
> >            vhost_svq_get_buf(svq, &r);
> >            len +=3D r;
> >        }
> >
> > This because we don't check vhost_svq_get_buf() return value.
> >
> > IIUC, in that function, `r` is set only if the return value of
> > vhost_svq_get_buf() is not null, so if we don't check its return value,
> > we should set `r` to 0 on every cycle (or check the return value of
> > course).
> >
>
> Sorry I missed this mail and I proposed the same :). I do think it is
> a real false positive though, in the sense that if we embed the
> vhost_svq_get_buf here the warning would go away.

I don't think so, I mean if we embed it and check the error path
better, yes, but now in vhost_svq_get_buf() if we fail, we return
NULL, but we don't set "len" to 0, so we would have the same warning.

Thanks,
Stefano

>
> But I understand it is better to change this function than trust the
> reviews long term.
>


