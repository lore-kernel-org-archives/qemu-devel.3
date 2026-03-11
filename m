Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C48A1062884
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Id1-0004yC-UP; Wed, 11 Mar 2026 08:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w0Icz-0004xY-4n
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w0Icx-00020P-70
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773231920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5/Y/pecblIB+Fq9W7dXJOR6mYUtrdZD39gSrixDcHc=;
 b=dzvWnHOra5Z1EF12InJKB4dmorpK/DW25LCJgrZm6xA893JLDefHpMmUpYB4eKj6fsOiPB
 nBYBcpVlt76ItvcTB3QjMRR94T2MsypPsOmzTDDjU84613l+d2XYVVuCYngTQv1Wv27NYH
 yBEXeYUyOOpv8qxnJvFlr5Y7+4St7Fs=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-6NQySoe3Mg-n88A1FdaF9g-1; Wed, 11 Mar 2026 08:25:19 -0400
X-MC-Unique: 6NQySoe3Mg-n88A1FdaF9g-1
X-Mimecast-MFC-AGG-ID: 6NQySoe3Mg-n88A1FdaF9g_1773231919
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-64c98481d1eso50114d50.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 05:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773231918; cv=none;
 d=google.com; s=arc-20240605;
 b=lx2pKIxYqWUtjNcDycMqnDhwC483aSZWDi8Yrh5ba60csmwn5+9Dz1BEFLGe1u0b4a
 W394Gn/ayx706CBCCrfhypxt+7RMgklMWkR5oOVYS1hvuUG8LyZfAw+bvXAykpNN3o+S
 X4qqQ2ShETXt0oOeFz8QHZ5frkdTem06Sd/aOkNPT0QTjS9OTbKE1nZjvaPUoaNGC99T
 xnhGgpnSzOEmQyEcl2VVLFRT9N9Z5VWjKIv3Nwhw5t3tnuKqS64ekM/cQyQ4Cgsqe1pq
 DEzl3FMfhPuneAOMo44ts3UQG+QwF5Fm5scZGpCGevMElHPzphuYfk+FlAoEusM3fm6s
 oXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b5/Y/pecblIB+Fq9W7dXJOR6mYUtrdZD39gSrixDcHc=;
 fh=qQIh5SLks44F/6JsiiHgshqeYwAoWhQJaBRtUv/EPHk=;
 b=F1LoV5hSYPLGqePH5thRVDFgE1uEcEqm5UeV5zCr5+V5WTcYGkkGG0IJw8ZP8T1t6G
 x+Hrv6rEEIFisWxKR7JudeKSpSQqYk4aYTgeOA49/e4fMWfCgvHvAvXG+5Xg8ll1Ai86
 lEwHy86nZpbx2jur0wcV3fi2aI2RbijbKoh9JcJCTu0hWO7w1+Jsf2G3qWDYmOrW1HG/
 +S59PZUKUDsCWAepB80XcDGRk54pE4RPDiTDmUDG1gtWQTTKxZpBlJHaYTJ31PGEPIyS
 yzh7Sl8H7HD250NIrDz4Lm0eT1ZaFfpicVS+cd8X9ZU2Nr0wciabo96zPvtcIV25ZV8o
 mAEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773231918; x=1773836718; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5/Y/pecblIB+Fq9W7dXJOR6mYUtrdZD39gSrixDcHc=;
 b=KlE7X6erBx4PVpB3+rG7TLnUMOL8PuTNQanAS+rwH+obo9ZszaXOtl4k9SpYcoce8Z
 Uu+F6rgxucRLz1w63ogdm/f3QqoI+rt++3uMlSEq/QJMyqCgwGOGmTxeiGMTtbVq6MUb
 lsLK/TBlYbKExfiGoDaDsEun/TmZ2nZ2l1kso3rkt/0TfGe12uXtc5pOecaiJuG68oR8
 wwnMYFI9sgg/QnqgxyNXn2AqmKNsucYwl9jEXl1TO1/iN9rt9DYrEBaNrx/WrszDphG9
 JkmSnuOUd8W965odevbEdJ6NlP/11LdAAAhbXr454XFv6K9wKIoPqPfuBqsa/gDDdmzO
 9Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773231918; x=1773836718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b5/Y/pecblIB+Fq9W7dXJOR6mYUtrdZD39gSrixDcHc=;
 b=vT9M/oHKNiUawm7rayuChVXbuLVk1kFGLBfVMUqIPDvKCIoZuVPGQ3Rf9VFO7i7lOY
 Dr1aJbI9C9kBz9lDeWVkkanjr1MG3NQSsAzQdx18p2ewJNV0AAUklDkPX+RRNUzcuFIe
 KHP4VXQoGNR5Ehw7zwNqA25l0H5S8+fefzOyNILeCxReBUAR0uPt+nURY8fqKXSioBpN
 p5HHiGmWrFuzylycn6SAfs1c8g0Vp6DYwA5DsT1oL0sOdnYm46Fa9I1UL7BMEd4pTlrQ
 UjL+f4/DQ/XEGHDpeRDhCtILF25C+Khpawo/GEQbC8Vb8nfMZRH+8htt3wgZmOXFUujy
 d6Fg==
X-Gm-Message-State: AOJu0YzL3SnwuHQsxvuiF2JNY2w5orkP4Gfvgyl6rTGJsig6tTruFzxn
 faGaduvt9+k2gjGgXhq0kw+kEqw0xcvn1QvpmvjoEYe286nFsfhKz2/XKvH6H43RHi3N2s/yL4v
 xU4mY2SpR5IiAcMG2cNO2LWeirQXpyq0m2Bc7JBm/xPTKAiJyVyusdjkDKb4EZBQDwRhYlPHUMl
 PhxTKNhUKZ/zC9FepYhUjXzZHlIpkZp+Y=
X-Gm-Gg: ATEYQzwANxPxns0lIWAWAupxhTD72WQGvX6rINK7nY0R3nRL4wgc3Gthvdw3Zc4AIR4
 SHbAZtDEzdcrf/NZ/t+6sxS5O/5i5zPhhwR2ElXhRKHmXCDx2JI3gJJeyRskvqFNyTDZc1kr2sl
 eWNVwgtEGGnx+VDj3qEDyWP6N1HPQN/pLal7m9kDGxdqNsVrktMB5BGGd5gYtvK/89fwX93BMd7
 7GSRw==
X-Received: by 2002:a53:a606:0:b0:64c:a1b9:ffa4 with SMTP id
 956f58d0204a3-64d6568dee8mr1521124d50.4.1773231918675; 
 Wed, 11 Mar 2026 05:25:18 -0700 (PDT)
X-Received: by 2002:a53:a606:0:b0:64c:a1b9:ffa4 with SMTP id
 956f58d0204a3-64d6568dee8mr1521105d50.4.1773231918246; Wed, 11 Mar 2026
 05:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <fe9eeb1f-b964-43f3-8147-7e302bdef268@tls.msk.ru>
In-Reply-To: <fe9eeb1f-b964-43f3-8147-7e302bdef268@tls.msk.ru>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 11 Mar 2026 13:24:42 +0100
X-Gm-Features: AaiRm52SwRDYcQJPUA7cwfJjQ5mC0h8awwW8mRTT42STRGY14OtjboOeeWZ6uqY
Message-ID: <CAJaqyWfYXf8O1ECXuWQPPi2Th_ekdaPpFM6Gq7S7dRJByOW3EQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add VIRTIO_F_IN_ORDER support to vhost shadow
 virtqueue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, 
 Koushik Dutta <kdutta@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-stable@nongnu.org, 
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 12:50=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> On 04.03.2026 20:35, Eugenio P=C3=A9rez wrote:
> > This series adds support for the VIRTIO_F_IN_ORDER feature flag to vhos=
t shadow
> > virtqueue (SVQ), enabling migration of vDPA devices that offer this fea=
ture.
> > As SVQ acts as a virtio driver, the series follows the Linux kernel
> > implementation for the feature by Jason Wang.  This enables the live mi=
gration
> > of vhost-vdpa devices that supports IN_ORDER.
> >
> > The IN_ORDER feature allows virtio devices to use many descriptors in b=
atch,
> > just by marking the last one of the set as used.
> >
> > The series is structured in three parts.  First, max_steps calculation =
in
> > virtqueue_ordered_fill is fixed to allow filling the entire virtqueue a=
t once.
> > Otherwise, a full queue cannot be used with just one used entry.
> >
> > Afterwards, the series extracts helper functions for descriptor process=
ing to
> > prepare for in order changes:
> >
> > Finally, the series adds IN_ORDER support, first adding conditional log=
ic for
> > in-order vs regular processing and whitelisting the feature flag in SVQ=
.
> >
> > Eugenio P=C3=A9rez (7):
> >    virtio: Allow to fill a whole virtqueue in order
> >    vhost: move svq next desc array to descs state struct
> >    vhost: factor out the descriptor next fetching
> >    vhost: factor out the get of last used desc in SVQ
> >    vhost: factor out the detach buf logic in SVQ
> >    vhost: add in_order feature to shadow virtqueue
> >    vhost: accept in order feature flag
> >
> >   hw/virtio/vhost-shadow-virtqueue.c | 215 +++++++++++++++++++++++++---=
-
> >   hw/virtio/vhost-shadow-virtqueue.h |  38 ++++-
> >   hw/virtio/virtio.c                 |   2 +-
>
> Hi!
>
> This whole patchset is being Cc'ed to qemu-stable@.  Does this mean
> that whole patch set should be picked up for the qemu stable series?
> It's a rather unusual thing to do - to pick up new feature into a
> stable series.  Is it what you have in mind?
>

Hi,

No, only the first patch. Sorry for not being clear, I thought it was
enough with the Fixes: tag, but thinking it twice I see how it might
not be clear enough. I'll make it clearer in the cover letter next
time, or is there a better way to handle this?

Thanks!


