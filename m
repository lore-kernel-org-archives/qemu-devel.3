Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F81C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtYIy-0006om-W0; Mon, 10 Aug 2026 18:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtYIx-0006oA-AT
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:17:11 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtYIv-0005TI-H9
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:17:11 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-5218927884fso23253791cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786400228; cv=none;
 d=google.com; s=arc-20260327;
 b=DP+1sXHokS1phEBwGEmdYtFKGqlOCXpbuKqi91dExsvOIes5zJX5QInh7PXm5Ib7Vw
 PeprGOcFdhZqQ4LurJ2SMqgjiaYq+U/VQEJsaR+Iyni3PPkPk8UUfb5U7sqRdqWHegHZ
 xbumqTveOgs63dF7N14V8a8KDGBuRxP+Ja8LQP0AW7wJMp1uRSk09P807Xoptn2a6E3v
 6ThtE+yHdWy+UPfiEr2DIJh993cIp+ncQnmf/bb9EzHMe2TYqZO2qWf+KnFb4ORwPNf6
 BahNxoA7pstb3fh4l/sPzFu4peZBHz2cHWco0T7q2qY6T+0f0uPylkdKYDnoZNEhr9Yp
 lG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f6D6gbor0YNO+WmjnO+LpeTVG1lSL/c2F8d3w+GaXw4=;
 fh=azakwI4Xb9f6DnAcztET+ugSHXzSSw4voANLU4fk32Q=;
 b=D1GIpOy82GKDCffCJVVG+GreS/IS5ithMdaI1ZvX0mxK5+31bgFu8Crp5DNo7IJWQU
 enBJaHeQ11P+VhNLkpRh4Cc1Bnzxt70IrKzB+g1PKKoavzkXSDb/bZjev4CcyD4wjQe7
 zp9h8PXMIlqDssnYAZvbbdHDKX76nhSUjer0xsNhQDiAgDEk5j7MwywDtkXlES2ZOSqy
 C1SGA1gEnOnqxHnf6dWzxeE4TXrbhzpnm0jKckTR/evlf6V62IRHbdXNcYJxVoVM7KpW
 XiYLEMySa4eAHVJuiDOLL81kMiN05bDyonbUSgUKgmvFwIsdJ2k31PsTVpjLBTSviMdV
 ukDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786400228; x=1787005028; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f6D6gbor0YNO+WmjnO+LpeTVG1lSL/c2F8d3w+GaXw4=;
 b=ERRp56ruW3SsAT5MX3OcGanKpYoWMrJVBOi4zQDiF2yRxH2Bx51/juIaBRjm2eBzR1
 FAFtZC6iSLWFpjtT54wSu2oU2GbHWZTzNJa5PRqSPmUvo9pYk6KetoD3J4LHRCTe4GJn
 eCZHuADfNy8oyh9i92qHAcjwU2eWynd3AdbicpXfKDwb6yCDe/OUWJr4hB4oCBkMLUko
 BVh8Hl0EGAkvgydJ7bumBIxtaKGiT24TH6aivIQmI2zxO8tC+VCY+wWGCvRjbBfvDX3e
 Obrx4RrkJrmO+lZBIVyB1Eii+s7TuoelgpBa7fEMSZQSF0niEvtwjFk0sLEdh5PxbKSn
 UrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786400228; x=1787005028;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f6D6gbor0YNO+WmjnO+LpeTVG1lSL/c2F8d3w+GaXw4=;
 b=JJSZcGtV64b/UJAh8bh+rGG6RvyonCH20gwyCjTyWXzQmG3Bi9HClh2dXg7QSP3tD3
 ZNcnR2wMdbWwFUqyUDI9S9lUbFG/pnJiK69JwyG+aMKF+MtNaCv+7guiz0k4bM542ooE
 5a5aKXF4lUvKZjSSpg61mmjR+8OgDVCPB7V7WgDPQZLs0Ta6ual8bfKnz2MLxg7ibQaG
 wz0S7JQ4ykFlHdH11NTJ9c0NPxoShowIosOX1FcKPY3ImnQ0dU8IF959rNukZ3VWnpFk
 pgR6FfV7GiuTtf52G2CVnOf+nArWlKioivvWn/+nLMEtjkULGHSYXzKFyxRvLUarjExS
 HBwA==
X-Gm-Message-State: AOJu0YzL/DXqi9TTHpK0LTITrcXSf0sOmlCzDe8NmT8MkeajIKry/88W
 D/Hs6LCSA/e/LzxEDyJYVzkc4VUBSSY9GMsLqphUAkeJPkp2z/iX3IfXr1Xvt0SdmFDFJR8IQkT
 oxUvsUhlINFgOQ8XbrF2dsk9tTpqLFNw=
X-Gm-Gg: AR+sD13YyHpa13pW3DAGicTd7YfeYjOY4Z4xWQm/WaatAvp68T3eryisNgY0m/SLA58
 //HkcN4oaftDiewGwm9fGcwbA/V5945RDibmJYetLytMJMNzdR31j2/iuahEdVtE2S76XsZanQ+
 0NqeX7LcZuOp/ErxLe+YpkF2vSa8jDg9laEeITHykfIdSeDIYnGfFZzcP50nhH4/yMNwkNJC2kB
 0OZYz5WndPnmqYtfn8Sg1qOFfhdS9gh9ut97ApNIAwqZ22h1wuPDb4C/8+2c3ZQZvzB7A4dX6tu
 Rm8308Mwm3L0otKYHSnHp6L0YSgWEpYWpcPnGV4HAO2LqkUhOtNF1SMet6HKIQYAovlw/LFwgUk
 UWAM=
X-Received: by 2002:ac8:5cc4:0:b0:51c:239:42da with SMTP id
 d75a77b69052e-52d4bba4276mr65739571cf.15.1786400228320; Mon, 10 Aug 2026
 15:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-12-6b97c439eb28@gmail.com>
 <9478d870-641b-4f3c-a5da-9026a0ec137d@redhat.com>
In-Reply-To: <9478d870-641b-4f3c-a5da-9026a0ec137d@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 10 Aug 2026 15:16:56 -0700
X-Gm-Features: AUfX_myccA-zhgRVZD7-2mOnxFmk9MjBYGEJGwyeZxrB-0TE5jnA0X_Yc_F-r78
Message-ID: <CA+spn3qP5n3=-MZQ4Y4BxYF3=LLbUicLVC0kDM9yGoZ-2pNakQ@mail.gmail.com>
Subject: Re: [PATCH RFC 12/15] hw/virtio/vhost-user: send isolation regions to
 device
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Aug 3, 2026 at 6:46=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
>
> This function name doesn=E2=80=99t really say what the function does, and=
 more
> describes its type.
>

I will change it to vhost_user_fill_msg_reg_from_tree since it is now doing
the filling directly rather than calling another function to do so.

> > +{
> > +    struct iova_tree_traversal_args *args =3D data;
> > +    struct vhost_memory_region msg_region;
> > +    VhostUserMemoryRegion region_buffer;
> > +    DMAMap *map =3D key;
> > +    args->fds[*args->fd_num] =3D args->u->iso_memory.iso_fd;
>
> Generally: I find it quite hard to read code where general statements
> come after a list of declarations without an empty line, especially if
> there is an empty line later. Visually, this last line to me looks like
> another variable declaration.
>

Got it!  The declarations and statements are now getting separated for clar=
ity.

> > +
> > +    msg_region.guest_phys_addr =3D map->iova;
> > +    msg_region.memory_size =3D map->size + 1;
> > +    msg_region.userspace_addr =3D map->iova;
> > +    vhost_user_fill_msg_region_iso(&region_buffer, args->u, &msg_regio=
n);
> > +    args->msg->payload.memory.regions[*args->fd_num] =3D region_buffer=
;
>
> Why does `vhost_user_fill_msg_region_iso()` exist when this is the only
> caller, and we could just fill `regions[i]` here directly?
>
> > +    (*args->fd_num)++;
>

vhost_user_fill_msg_region_iso existed before the iova_tree was integrated =
in
the code base.  I agree that the traversal function can absorb it for
added clarity.

> As noted by Akihiko, there needs to be some bounds checking. At least
> against `VHOST_MEMORY_BASELINE_NREGIONS`, but even better against the
> array size of `args->msg->payload.memory.regions` and the caller should
> pass the size of `fds[]` via `args`.
>
> (And I=E2=80=99m also with Stefan, something with `index` would be better=
. Maybe
> `region_idx`.)
>

With the current state of the refactor, the size of fds should be the same =
as
dev->mem->nregions, so I will pass that value in via args and do the check.

The fd_num field is now called idx.

> > +
> > +    return false;
> > +}
> > +
> >   static int init_isolation_regions(struct vhost_dev *dev,
> >                                     VhostUserMsg *msg,
> >                                     int *fds, size_t *fd_num)
> > @@ -1234,6 +1275,24 @@ static int init_isolation_regions(struct vhost_d=
ev *dev,
> >                                         map->translated_addr);
> >       }
> >
> > +    struct iova_tree_traversal_args args =3D {
> > +        .fd_num =3D fd_num,
> > +        .fds =3D fds,
> > +        .msg =3D msg,
> > +        .u =3D u
> > +    };
>
> Personal preference: I would like `*fd_num =3D 0` somewhere here, or
> `assert(*fd_num =3D=3D 0)` before the iteration. Yes, the caller initiali=
zes
> it to zero, but it is just not obvious here, and it seems necessary for
> correct semantics.
>
> (And the open question whether `fd_num` should be renamed here, too, or
> can keep that name. Not sure.)
>

I will set *fd_num =3D 0 here.   I can see how it makes it easier to see
what is going on.

It may make sense to keep it named fd_num here.  Whereas its main use in th=
e
traversal function is as an index, here and in vhost_user_set_mem_table it =
is
primarily providing a count of the number of elements in
msg->payload.memory.regions
that have been filled.

> > +
> > +    vhost_iova_tree_foreach(u->iso_iova_tree,
> > +                            vhost_user_iova_tree_traverse_funct, &args=
);
> > +
> > +    msg->payload.memory.nregions =3D *fd_num;
> > +
> > +    assert(*fd_num !=3D 0);
>
> Am I wrong or should `*fd_num =3D=3D nregions`? Is it possible that
> `*fd_num` is less because regions end up joined? Can you add a comment
> on when they would differ?
>
> Hanna

I updated this to check against nregions.  In the current revision, I
do not think
this assertion would be reached if there was an issue with allocating eleme=
nts
on the iova-tree or filling out the message payloads, but the final sanity =
check
doesn't hurt.

Best,
Connor

