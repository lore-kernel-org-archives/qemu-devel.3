Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D092C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 07:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXyR1-0002rX-8x; Thu, 08 Feb 2024 02:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rXyQz-0002qv-Pw
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 02:02:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rXyQx-0000Sg-Sd
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 02:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707375774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuOkPrcjQWpjAy/uJcctTrgJH6SaMdCUC4FyGOz8VTg=;
 b=O3H67kGRAu5YPXk2CegC+dB2v6HcYJ6+mKcvqSfJLKGHqBbVRSER6f/6i2rnT6op9lRGHs
 EqpCRQUvze456aw3xb+JG+WAQzhW5iz8coc4Jl1pbF05rh9tUsI33RP+XH6UEiy4Ky9Ywa
 jWHpXKhcME5wgcmBO6dfqLAd3LXO/i8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-HnsWLvDyM_e5g4wcFZqpGA-1; Thu, 08 Feb 2024 02:02:52 -0500
X-MC-Unique: HnsWLvDyM_e5g4wcFZqpGA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5d8dd488e09so1538915a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 23:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707375771; x=1707980571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuOkPrcjQWpjAy/uJcctTrgJH6SaMdCUC4FyGOz8VTg=;
 b=mH/BBW4jk003fuQNQdqP2BwMoB2+x7dq9LQUiNAcGTyTAeI/bDtvwD6cD7NRRFu53k
 USrJe4+EhBnvEJuS0HclfHmOenLTBPscLNIeh47QMDYKQPY2HgXAvBxvXqLOS9YBez6T
 ZDqSYWCu+FjvOmQk8dV/p9QJGZ54RHBWZcQbdjZtwgQwkYInAW9TlmYCefa8ub8EnY5S
 cfEZRRsfkSOGTdbhxkn93vmBPe6g63bMN35itG1yLiY+42KJQL9iQJLq5OqpDY1/LSrS
 h1QnjO8pwJedxZNsFLaK339hlg8rBM4lH0cZgubhA8DXAglxRWOlDMBxRBPxRNm6lZTu
 lYew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ+RLRYMjZNpbwySkpEobYysonW9e1rCfG6pdhJ68k5fz2bZWRnk41m4ru5G10sVMioJwir7spbJkZvIY//yGvNHZB9AE=
X-Gm-Message-State: AOJu0YzZlwo9+/CJ5gMwDBX+bwptojOaZecONehCD3/LZDrc2HHfEOPa
 m2t5WK6eoNq8oKp66T2PLUn6ho/qNHPH5BuYE3KecXIkBNnS1mDYTGRWaY5eHDyBpTa3WD/mfaA
 ay5yh7iPW0/TP3NeeysBHHr0h9ye8zjbEVk6H789wbnCYcRM5EePdKEGmIK16NtQpdBUhTrn3yu
 hxcnLQMBAjn+0iomEF7nVEWza0BYs=
X-Received: by 2002:a05:6a20:c888:b0:19e:9a75:7851 with SMTP id
 hb8-20020a056a20c88800b0019e9a757851mr7872829pzb.3.1707375771449; 
 Wed, 07 Feb 2024 23:02:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlvX9wEu06fxCT8TQAJf53PHJsY6oDnsMyoai6xgksb1sl93gkmSuyibvV6C9Pm1yZfx/j9g5HEpKW9vDu7bs=
X-Received: by 2002:a05:6a20:c888:b0:19e:9a75:7851 with SMTP id
 hb8-20020a056a20c88800b0019e9a757851mr7872811pzb.3.1707375771158; Wed, 07 Feb
 2024 23:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20240202132521.32714-1-kwolf@redhat.com>
 <zmopxf5zt6m36nfujntn72idlinm7qmx23wjvwiazmq4b75lsa@a2omit34pjif>
 <CACGkMEvLpg+nPgHsE_6stFM1OGXbHpuE=j7XLwt_YxpxhWJgZw@mail.gmail.com>
 <nvk6n7ln3ryga2ww4a6evbprauptzcn7uz34ar3uecbxjfre2z@msikqqpuk2vh>
 <CACGkMEtODf_NGGa-XbyDMM7=z6CsCkazV9A-4z8W7oCOnu-Ybg@mail.gmail.com>
 <npcki5ojmtrr6znychok5l6w7zcmip347c5gd5dexlxpkac7qs@cwwyon5t4z3a>
In-Reply-To: <npcki5ojmtrr6znychok5l6w7zcmip347c5gd5dexlxpkac7qs@cwwyon5t4z3a>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Feb 2024 15:02:36 +0800
Message-ID: <CACGkMEsbC48+xnBg1s_5qrNv9FWXTfyFTmJw+4eKBHqcQ2W70Q@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 7, 2024 at 4:47=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Wed, Feb 07, 2024 at 11:17:34AM +0800, Jason Wang wrote:
> >On Tue, Feb 6, 2024 at 4:31=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >>
> >> On Tue, Feb 06, 2024 at 10:47:40AM +0800, Jason Wang wrote:
> >> >On Mon, Feb 5, 2024 at 6:51=E2=80=AFPM Stefano Garzarella <sgarzare@r=
edhat.com> wrote:
> >> >>
> >> >> On Fri, Feb 02, 2024 at 02:25:21PM +0100, Kevin Wolf wrote:
> >> >> >VDUSE requires that virtqueues are first enabled before the DRIVER=
_OK
> >> >> >status flag is set; with the current API of the kernel module, it =
is
> >> >> >impossible to enable the opposite order in our block export code b=
ecause
> >> >> >userspace is not notified when a virtqueue is enabled.
> >> >
> >> >Did this mean virtio-blk will enable a virtqueue after DRIVER_OK?
> >>
> >> It's not specific to virtio-blk, but to the generic vdpa device we hav=
e
> >> in QEMU (i.e. vhost-vdpa-device). Yep, after commit
> >> 6c4825476a4351530bcac17abab72295b75ffe98, virtqueues are enabled after
> >> DRIVER_OK.
> >
> >Right.
> >
> >>
> >> >Sepc is not clear about this and that's why we introduce
> >> >VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK.
> >>
> >> Ah, I didn't know about this new feature. So after commit
> >> 6c4825476a4351530bcac17abab72295b75ffe98 the vhost-vdpa-device is not
> >> complying with the specification, right?
> >
> >Kind of, but as stated, it's just because spec is unclear about the
> >behaviour. There's a chance that spec will explicitly support it in
> >the future.
> >
> >>
> >> >
> >> >>
> >> >> Yeah, IMHO the VDUSE protocol is missing a VDUSE_SET_VQ_READY messa=
ge,
> >> >
> >> >I think you meant when VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is
> >> >negotiated.
> >>
> >> At this point yes. But if VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is no=
t
> >> negotiated, should we return an error in vhost-vdpa kernel module if
> >> VHOST_VDPA_SET_VRING_ENABLE is called when DRIVER_OK is already set?
> >
> >I'm not sure if this can break some setups or not. It might be better
> >to leave it as is?
>
> As I also answered in the kernel patch, IMHO we have to return an error,
> because any setups are broken anyway (see the problem we're fixing with
 is > this patch),

For VDUSE probably yes, but not for other parents. It's easy to
mandate on day 0 but might be hard for now.

For mlx5e, it supports the semantic
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK even before the feature bit is
introduced.

And we don't do other checks like for example setting vq address, size
after DRIVER_OK.

We can hear from others.

> so at this point it's better to return an error, so they
> don't spend time figuring out why the VDUSE device doesn't work.
>
> >
> >Without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we don't know if
> >parent support vq_ready after driver_ok.
>
> So we have to assume that it doesn't support it, to be more
> conservative, right?
>
> >With VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we know parent support
> >vq_ready after driver_ok.
> >
> >>
> >> >If this is truth, it seems a little more complicated, for
> >> >example the get_backend_features needs to be forward to the userspace=
?
> >>
> >> I'm not understanding, don't we already have VHOST_GET_BACKEND_FEATURE=
S
> >> for this? Or do you mean userspace on the VDUSE side?
> >
> >Yes, since in this case the parent is in the userspace, there's no way
> >for VDUSE to know if user space supports vq_ready after driver_ok or
> >not.
> >
> >As you may have noticed, we don't have a message for vq_ready which
> >implies that vq_ready after driver_ok can't be supported.
>
> Yep, I see.
>
> >
> >>
> >> >This seems suboptimal to implement this in the spec first and then we
> >> >can leverage the features. Or we can have another parameter for the
> >> >ioctl that creates the vduse device.
> >>
> >> I got a little lost, though in vhost-user, the device can always expec=
t
> >> a vring_enable/disable, so I thought it was not complicated in VDUSE.
> >
> >Yes, the problem is assuming we have a message for vq_ready, there
> >could be  a "legacy" userspace that doesn't support that.  So in that
> >case, VDUSE needs to know if the userspace parent can support that or
> >not.
>
> I think VDUSE needs to negotiate features (if it doesn't already) as
> vhost-user does with the backend. Also for new future functionality.

It negotiates virtio features but not vhost backend features.

Thanks


