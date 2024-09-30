Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87784CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBoO-0001Lp-BL; Mon, 30 Sep 2024 04:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1svBoC-0000m3-Jj
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1svBoA-0007wC-W9
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727685066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psDTGQMBz4hvq024t8z5Oi5LT1Kq05u/xzwYHjKbfVI=;
 b=IAsa6zSHhKG9UaRPlYrGvVlKXUWDGH/rMwvVBVD1m6N997DXdcOoe3SLk0pZCz+ySxuT6U
 Y7OSccSlK5EQzFo1mUB89Kdj4pe6QTmVLKd9zk0c7ssVGvsklFk0x5uIhj114tAx0SyqaC
 +3md/+oiqs8DbKsj90i0tnDUfQLqhSQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-JePhArRpMG-YvHcUOycLgg-1; Mon, 30 Sep 2024 04:31:03 -0400
X-MC-Unique: JePhArRpMG-YvHcUOycLgg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6e20e22243dso63695177b3.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727685062; x=1728289862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psDTGQMBz4hvq024t8z5Oi5LT1Kq05u/xzwYHjKbfVI=;
 b=Ak6/o4ng7pulcGKFZQAcArRSG4Yi20xMvY7EYC2rFqQBIm+/y0Kt6/uyqmPBDAKyYY
 sMpnY6EI/1mTLc8B4dWbcL9TEmk0d1HdxaRMK7ykEYckyHt1LF3QruN3Hw+8izWAD+n5
 wfKeOyzJAIg2EtY8DGiWfIk4Ps+BPnhRPWieah+QHoUR0VPLAWRCLmGaTUqKQ31a9gj5
 d4r1iceZqgSczUcb3zYEF00vQMKWsM1huvkUl3PcAVuLIdTW6iEpwB0Wg8Samjcshpd/
 z1xMgKFnZl+qcsp34UmTrwBgqN2Q8RBNLkUavp4XKbLuDPpB7RtpuigqFHrvw5d7NdqF
 Zxfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXff2vY7DkKGW/K+NfmORxQUw+mT+Bful6j0XJItsOtpOXemmCCAIwEqxXmFaFsFDguVQOqOWrB4o+1@nongnu.org
X-Gm-Message-State: AOJu0YwYxN0n0/XpJosF/oUXQDvWrkuupKrx74x5DvtAF0gY5EnTGUp1
 BYGcqOJdW9sePfuFOjUMhE4M1Es6S9A1U9rWeO6surkCDCS5Pzayk54bKHfHiQu/CFMCnA5CUhU
 Hf689rDiSnQ7bNWvPibd4EV+3WsLkmLfUgF2oE+I65V0q7HpTOvgfPdTdpyfnN28mu65fUhNmc6
 ENTrK5nVYsBhL1Z4glHNiKQNRSJGA=
X-Received: by 2002:a05:690c:6910:b0:6e0:763:1ffa with SMTP id
 00721157ae682-6e2475d12afmr95913887b3.34.1727685062649; 
 Mon, 30 Sep 2024 01:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjtSoHLCxuNm4SCvkYEFcZg8KKTuIdTz9eCT+QzKn3SstAAr+BW/W+XtqY9iecZQq6W/YHDXw8zxWAfHvjoZI=
X-Received: by 2002:a05:690c:6910:b0:6e0:763:1ffa with SMTP id
 00721157ae682-6e2475d12afmr95913577b3.34.1727685062361; Mon, 30 Sep 2024
 01:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-19-marcandre.lureau@redhat.com>
 <swzpet5rpne5arwq32i5vrinpguremvrq4sqb73byfw5n2uuzx@s4hi7thksiif>
 <CAJaqyWeO925F6W6OgNRainpiqECXdB27AkDyUhF-6o9i7BPjoA@mail.gmail.com>
 <CAGxU2F6GJXZKcfs=1iaKqt8xy5=T+S2yJG6cOxptYmeZJmYfcA@mail.gmail.com>
In-Reply-To: <CAGxU2F6GJXZKcfs=1iaKqt8xy5=T+S2yJG6cOxptYmeZJmYfcA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 30 Sep 2024 10:30:26 +0200
Message-ID: <CAJaqyWcvFCRzw82NP6UsH5=kB0aevnMz3L87dX++Xrq3axrZsQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/22] hw/virtio: fix -Werror=maybe-uninitialized
 false-positive
To: Stefano Garzarella <sgarzare@redhat.com>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 30, 2024 at 10:11=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Fri, Sep 27, 2024 at 3:08=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 10:08=E2=80=AFAM Stefano Garzarella <sgarzare@r=
edhat.com> wrote:
> > >
> > > On Tue, Sep 24, 2024 at 05:05:49PM GMT, marcandre.lureau@redhat.com w=
rote:
> > > >From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > For the title: I don't think it is a false positive, but a real fix,
> > > indeed maybe not a complete one.
> > >
> > > >
> > > >../hw/virtio/vhost-shadow-virtqueue.c:545:13: error: =E2=80=98r=E2=
=80=99 may be used uninitialized [-Werror=3Dmaybe-uninitialized]
> > > >
> > > >Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > >---
> > > > hw/virtio/vhost-shadow-virtqueue.c | 2 +-
> > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > >diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-sh=
adow-virtqueue.c
> > > >index fc5f408f77..cd29cc795b 100644
> > > >--- a/hw/virtio/vhost-shadow-virtqueue.c
> > > >+++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > >@@ -526,7 +526,7 @@ static void vhost_svq_flush(VhostShadowVirtqueue=
 *svq,
> > > > size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
> > > > {
> > > >     size_t len =3D 0;
> > > >-    uint32_t r;
> > > >+    uint32_t r =3D 0;
> > > >
> > > >     while (num--) {
> > >
> > > I think we should move the initialization to 0 here in the loop:
> > >
> > >            uint32_t r =3D 0;
> > >
> > > >         int64_t start_us =3D g_get_monotonic_time();
> > >
> > > ...
> > >
> > >            vhost_svq_get_buf(svq, &r);
> > >            len +=3D r;
> > >        }
> > >
> > > This because we don't check vhost_svq_get_buf() return value.
> > >
> > > IIUC, in that function, `r` is set only if the return value of
> > > vhost_svq_get_buf() is not null, so if we don't check its return valu=
e,
> > > we should set `r` to 0 on every cycle (or check the return value of
> > > course).
> > >
> >
> > Sorry I missed this mail and I proposed the same :). I do think it is
> > a real false positive though, in the sense that if we embed the
> > vhost_svq_get_buf here the warning would go away.
>
> I don't think so, I mean if we embed it and check the error path
> better, yes, but now in vhost_svq_get_buf() if we fail, we return
> NULL, but we don't set "len" to 0, so we would have the same warning.
>

Ohh got it, I missed that path!

> Thanks,
> Stefano
>
> >
> > But I understand it is better to change this function than trust the
> > reviews long term.
> >
>


