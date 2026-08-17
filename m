Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374D7C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4LX-0007Js-6s; Mon, 17 Aug 2026 16:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1ww4LB-0006zh-Ul
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:56 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1ww4L8-0006py-Mk
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:52 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-51c1372f84dso27597591cf.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787000029; cv=none;
 d=google.com; s=arc-20260327;
 b=hv2BBWrpuF5jcjzvXUvxcEPz+VXWeUYK5aY1Xp1kQ43Jyh5wR+vcK7J3Uy5VR6Fakw
 eUFo+Eux73R9yf0QdWSitPQXERdRDxUia9QMQ2xCm2oW2vfpvyPay58/1tOlho8KHJvo
 yHm53SnxvL44sUFlB8B67pgta5obwR51MsCg5bZdlmL/goIG6TG4T69V3eQ8arnUmfKu
 ExrXWG9RaKtqvdsCBsgG+ee34n/YGMk/Wyf2hE22ecANhHcXQlh3uHhtr+2PeOsJj0/s
 TfkC64wuQ0DePQz6sGbFWQC6LPNOXbEKuru8KFLkFduZYXUYq8A6bdalHwN2SO+Ifer8
 1gRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0n5MfU7yibKqE+ZJhzMTB35Y7Us/BO0Y6mv7YhPXB+E=;
 fh=x50nJBzqz+v5M8Pm4mrIW+J9ZsMO4Kfn7wHtfmb2xEg=;
 b=FZQnD3ERoTV+ZCnqVwrJkKh4Ijr6FEuHGsybQ0igvmYfoKoqSGk7EPi9nt7XqyC+wn
 UywnN7frgmPM9D+Wj6wMJ5A4OG4SqDYMtvi/NtQ6bWPngy8AeQOa6nvKhT5jydk0bizC
 v2wl1Hp6NamJYpM10HmyQjX5x3muQVd0enGdTltEHWj5BA+snLJtHWOw+ZVG0LDYAN9W
 rOniVsyVpgUKerU9Nn/bW2mEB2yFuJmu9w8WgCjsAaBxTun2qucy3pNK5a/0ccEhq/J9
 gGu8Pn5pGdOADwJGGwk2jZS5miIAWssv7PMMIzjjZFXq/NK0b9CGBPONb4eTODZnNLhV
 50Yw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787000029; x=1787604829; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0n5MfU7yibKqE+ZJhzMTB35Y7Us/BO0Y6mv7YhPXB+E=;
 b=klSTiBxOp7T1Nz/OfW/NraXI3C0Z9PTuj3psKGqQv5LofqLkxADktycKiqd+uXq/eB
 A9O1cLibiyYDXyVUu+5yVe9pMCMj0xfx0yKeCAvkWDJ7cT7CUkGtGNupdOh7hy7Wf5pf
 YHcHZhwyCDY4Q4uu+OuCg/d7zpeNil/iWg23G4yMcm/pYqXoQz4lWVpMMd20/IFh6PYD
 Gq+hDOt3c+2R8To8sUPIlqZvtzWU9zpIxXCWkYRYlQOWR7D+15ko/uIG96vq+SPIUYTU
 xyzkvcOixDuHaFfG8KAZVUup5MG21mjk/3EvAteLwTbTzn3aqQqZBMvoe8eNdrV4OQvB
 T87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787000029; x=1787604829;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0n5MfU7yibKqE+ZJhzMTB35Y7Us/BO0Y6mv7YhPXB+E=;
 b=HnMhj/7kiEEZyYZzKtXMJ7hF07QKR6+geyne6xG9Ot8m/q2cWYYpt3K3+JqSwf4RyO
 YTwvfa2YnrQ+3toci0ZgqLBqd6MHH/dp4mU2wX6auBC77nXl6McSwSc4Zw7nER9+a+bl
 PkAArZuOm6D8lJL5aNkKUSEdZi4alJglsfnrVLWSsflWXF84TbSQXsHuH6TGec+B430f
 i3MWR9eCkdhb3E2hrUh9qOwCa8gv38WIgtMeG949tc8igs5t2Dp5M+x3WetBlWPeNQS3
 ahsWoHE+85kVIy87eciBQ/b13QwQcQALmsfJb2F8M/wTRy73Q/619YdUKCBhcxrsBz/v
 NSbw==
X-Gm-Message-State: AOJu0YxRTT8WY2libsRrvkwTr/Q9vrelFtZBwbputEErIh4jHha52Vqo
 k3IS27TDruQB7AjYoC339pO/w/NMRCEQ9ov4D4wku2wsCarDAAS4dk3imS/uyjpbStW57XpxaKy
 vWbMIyjRYPbuv0RDor3VKFMa066tDHa4=
X-Gm-Gg: AR+sD12zg1Mre+lib8Y7Dt0oP/rzbAYx0NYdO0oRoq2Gz5gALacoSu/PtipGNfh+X5E
 NTu+L/MIE+utaE+yCVczWBaLI76lKd2EIptpGrK4nRChqJAwXTYTrezobmg3iPyUkdBIBt/Z7JZ
 1F4v7C1J3bQOP6NX0d7x4UIehApGv6KBCltFN8iYQzLmGRxGh80LARV0sMCFoutpgufCK8crUZM
 Mk+4XURtBNd1kxANNj5p+fuYOBpZlE8CtJFTqg0YvZGvFNOXm1zfHePRggQfmE0aEbbEf6Ozk8m
 Vhcap/apqVVJmv0fC2U3iZERuqPVapjizq+qwXIlmmcI5mhY21Kfv99+seUXRrni8w+wgOsEzIH
 y7g==
X-Received: by 2002:a05:622a:1104:b0:517:c65c:488b with SMTP id
 d75a77b69052e-52d8523888emr294661901cf.0.1787000029201; Mon, 17 Aug 2026
 13:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-15-6b97c439eb28@gmail.com>
 <1257210f-15f9-47ab-b5e9-05a3ee4ef8ba@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <1257210f-15f9-47ab-b5e9-05a3ee4ef8ba@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 13:53:37 -0700
X-Gm-Features: AcwNN1XcQxywyKXeKRa9EllVjvEsHt5XOsrfdWWYvqBRCJgOAfFKiLdxZi5NtD8
Message-ID: <CA+spn3osjNAokBGi-hERm4z-Gwz22ORQC1Ag65okv-HSrZ9JVQ@mail.gmail.com>
Subject: Re: [PATCH RFC 15/15] hw/virtio/vhost-user: shadow vq cleanup
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x829.google.com
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

On Fri, Jul 24, 2026 at 8:22=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/24 7:30, Connor Kite wrote:
> > Implements functionality to cleanup svqs on cleanup of isolation
> > regions.
> >
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > ---
> >   hw/virtio/vhost-user.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index e65f877f9a..bb4de78b95 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1140,6 +1140,15 @@ static int vhost_user_set_mem_table_postcopy(str=
uct vhost_dev *dev,
> >       return 0;
> >   }
> >
> > +static void vhost_user_svq_cleanup(struct vhost_user *u)
> > +{
> > +    for (int i =3D 0; i < u->shadow_vqs->len; i++) {
> > +        vhost_svq_stop(g_ptr_array_index(u->shadow_vqs, i));
> > +    }
> > +
> > +    g_ptr_array_free(u->shadow_vqs, true);
> > +}
> > +
> >   /* TODO: Is there any notifier cleanup required here?*/
> >   static void cleanup_isolation_regions(struct vhost_dev *dev)
> >   {
> > @@ -1147,6 +1156,7 @@ static void cleanup_isolation_regions(struct vhos=
t_dev *dev)
> >       if (u->iso_memory.base_addr) {
> >           vhost_iova_tree_delete(u->iso_iova_tree);
> >           u->iso_iova_tree =3D NULL;
> > +        vhost_user_svq_cleanup(u);
>
> Memory-table refresh frees live SVQs permanently.
> init_isolation_regions() uses cleanup for refreshes, but cleanup frees
> shadow_vqs; they are created only once during backend initialization.
>
> Regards,
> Akihiko Odaki

Got it!  This should now be resolved so that the svq array only gets
freed on final cleanup, rather than on reset.

