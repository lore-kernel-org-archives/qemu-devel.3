Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E35CDD1A8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAhz-0007WN-PP; Fri, 27 Sep 2024 09:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1suAhw-0007R4-76
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 09:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1suAhu-0003DR-ND
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 09:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727442505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33bKtWAk7FxYP5FuM/e0xeWJ/BNiA+b7DOvmf488bAM=;
 b=GBP8wAOg/VqbXQsr7F74cWTJPP48ldBseDe+CcZvtk3E1/ppWRaqWNCCqoLdJMeHn6ySH8
 K477oXzAG9tbbCyjDToJ8znEU9EspgBG9dHJn8OIyJsa1cBn1haCfauBbT74OEsytxBj5U
 gW7+BY+X343f+iukP4H9k6IpPWa0dW0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-2EIPwMWaM5e3om36Yqy6vQ-1; Fri, 27 Sep 2024 09:08:23 -0400
X-MC-Unique: 2EIPwMWaM5e3om36Yqy6vQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-690404fd230so34961687b3.3
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 06:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727442503; x=1728047303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33bKtWAk7FxYP5FuM/e0xeWJ/BNiA+b7DOvmf488bAM=;
 b=fNA77fAZAEFqqQ8g+9jlzXEmnUM63tdBN5X+ZeMv07dUoYGdN/8ObBbE+SPd+6Y5jV
 NG3tltFFrAT4noTIoNWQFVg9xJ7yikFe6hcoFapjZ7pj+MCCs+GWpqCzKecwhiMxqrKf
 MFVJ3ZDD86d19uUwUuW71LwHW6o8YR5KkNINI/qFQcprUjMQ719j4ClBBfnN4gNcfmYH
 X82A3eH1qBDey7nWj3CTQeqMToqUPldKFwXvSG28JJfv5BD4aiIN3Qa9lEZBCF3s1gY8
 6/jZtzd2ipw52hhSfS+1BaMkzbMfzF0NmbL15kJ37pOwh75PpziM4aJgObEznaZwd/bu
 eSNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW210wRSt8m/YKX3Hc8/CoZJcSPAHSlPzDCkWjb8IOzcRaRk19r+ar5fHqCiAiadUMyUwFvOlbquer4@nongnu.org
X-Gm-Message-State: AOJu0YwqVc0TKqXnRmygiHdnTTC6lCsGbxJ6etB+f6Wscnhrjm+WEQ8P
 K3ahwZOkS2ZU7IoA/fMWNPst/sz4vfduSQPXKYxMNZFEM4SOpOAHnGmR5rFRIV+KPXqPDNqBzzi
 T7OnaR5DNH/IgX9pRRPhp22YOW8jI3gl1483862eoCJUPe7QRXEY0yLU0VqieuVQ5KVU13xOLAF
 cZ5HAc8tZnCLYQWVjdJhdEDwC9Gm4=
X-Received: by 2002:a05:690c:4b0d:b0:6dd:bde7:54d1 with SMTP id
 00721157ae682-6e24754742amr23925907b3.20.1727442503104; 
 Fri, 27 Sep 2024 06:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY6xU1ykY5EvCYpyPQz8cZtyFyFAttEYMj/EIaClni7pqlaEAHceEr73uiltZQTHgOYrCAVmOOuqtnu2qiNLM=
X-Received: by 2002:a05:690c:4b0d:b0:6dd:bde7:54d1 with SMTP id
 00721157ae682-6e24754742amr23925587b3.20.1727442502722; Fri, 27 Sep 2024
 06:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-19-marcandre.lureau@redhat.com>
 <swzpet5rpne5arwq32i5vrinpguremvrq4sqb73byfw5n2uuzx@s4hi7thksiif>
In-Reply-To: <swzpet5rpne5arwq32i5vrinpguremvrq4sqb73byfw5n2uuzx@s4hi7thksiif>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 27 Sep 2024 15:07:46 +0200
Message-ID: <CAJaqyWeO925F6W6OgNRainpiqECXdB27AkDyUhF-6o9i7BPjoA@mail.gmail.com>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 25, 2024 at 10:08=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Tue, Sep 24, 2024 at 05:05:49PM GMT, marcandre.lureau@redhat.com wrote=
:
> >From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> For the title: I don't think it is a false positive, but a real fix,
> indeed maybe not a complete one.
>
> >
> >../hw/virtio/vhost-shadow-virtqueue.c:545:13: error: =E2=80=98r=E2=80=99=
 may be used uninitialized [-Werror=3Dmaybe-uninitialized]
> >
> >Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >---
> > hw/virtio/vhost-shadow-virtqueue.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow=
-virtqueue.c
> >index fc5f408f77..cd29cc795b 100644
> >--- a/hw/virtio/vhost-shadow-virtqueue.c
> >+++ b/hw/virtio/vhost-shadow-virtqueue.c
> >@@ -526,7 +526,7 @@ static void vhost_svq_flush(VhostShadowVirtqueue *sv=
q,
> > size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
> > {
> >     size_t len =3D 0;
> >-    uint32_t r;
> >+    uint32_t r =3D 0;
> >
> >     while (num--) {
>
> I think we should move the initialization to 0 here in the loop:
>
>            uint32_t r =3D 0;
>
> >         int64_t start_us =3D g_get_monotonic_time();
>
> ...
>
>            vhost_svq_get_buf(svq, &r);
>            len +=3D r;
>        }
>
> This because we don't check vhost_svq_get_buf() return value.
>
> IIUC, in that function, `r` is set only if the return value of
> vhost_svq_get_buf() is not null, so if we don't check its return value,
> we should set `r` to 0 on every cycle (or check the return value of
> course).
>

Sorry I missed this mail and I proposed the same :). I do think it is
a real false positive though, in the sense that if we embed the
vhost_svq_get_buf here the warning would go away.

But I understand it is better to change this function than trust the
reviews long term.


