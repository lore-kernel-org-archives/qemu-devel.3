Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE42C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvps-0001sr-LI; Fri, 28 Aug 2026 08:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wzvpi-0001sH-UQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:37:23 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wzvph-0005qd-1q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:37:22 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cc1ceadbd16so822471a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787920639; cv=none;
 d=google.com; s=arc-20260327;
 b=mKarLQnzbODfSllSRaGkXlC7ynYoDhQw+VOPPWNSujG0XUUX3/Lah/JUex18Dcgkbb
 i3TAABocJ87FwErsBmUQ+LM+AsHNsfbTh20aBW3FqbouNw+ABWIFKEu3No/mx3vpvMkq
 1cVPw9dlFn4Y4MwsFp4BJl+qEiJqepxK54/smVXozP2xpJPJnFDwDWTA6dvbtCwWm1G6
 BQnLTZKvHueX+Kjjc5YNBT9c8aHo/uo9VlWS1XfouL85tlYxpErnvPx1oAEO9pwfH8z/
 209Z8X4fZMw8vipFKcMviPU9A8VGTN8s7ag/iQAaE/pKuCYwryHh3MSN5S4suYzqIEnP
 y93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w+TvNFrB527qI0b3iMvuP8USPZnyG0G3rDlXBYUI65E=;
 fh=72UdCioTAzbcxYbLN7TVE3AZJYZp81beZoM76t1yHyQ=;
 b=FHOismAqDo/EvDuSuZIZqyOAGmnKkdCXKbdC9Mzd1VgAEJAeZI8DFKS3y9YTDL+Brp
 T7jR/rejClxXopL2Co+sRD4wuedlvAx+9h5zTYOKOSqZcUtbiYAMUUm68sI8edGaPzfa
 Z1y/OOiSpGyXco3kujd+21dxfcgS3bI90kaOYrsa0BSroaYlA5kQZhHbyLaTK7+w+No7
 zxKz+CUIzY8JGyq2Sr2/Jz/pJUBs3UryJ2/sQ3G1Mh0tYPDYNNLbkFXth2SgXvABxL17
 AT8yn3F7O/tnX1NyrU8Pth5EGgnB1inn3u+khdQ0Qf5ra9O4OL7GSbZkd9G3UCqpmGnN
 3gWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787920639; x=1788525439; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w+TvNFrB527qI0b3iMvuP8USPZnyG0G3rDlXBYUI65E=;
 b=oHOfobwexrVm2/4yw9dFjuVw2CxA+XTNT9GFfRzHtd9wde9zX8DRFDb6q8Dx5W0qa9
 bofLWpwFi/kkXhXdH4iZ7IO5zfBlKPoP804I3oNLs5QosT7ctxgwH4aFqotVgJecdnGS
 kfmxfaK+b3Kbd2Piq10932jArdlUkaRal3z7AZNI0+fwiFMnBJNessa25Fd3pez2X9Di
 Tc0HRo25ej4pZesFwGIzwqczpR7DPwhSO+Z1mWUTjKhhW75AyJ2acsZydn+jFhV9eXd0
 w40Io4ecuiSCWk6PGPmnE4+anbt+q+0NQNwAk8eyWC2m43WqAUHueJB9KLCht4aJIDoG
 /Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787920639; x=1788525439;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w+TvNFrB527qI0b3iMvuP8USPZnyG0G3rDlXBYUI65E=;
 b=pWspq+JkvKQpk+fpx+sn0rYe/xidCecO2cot/h3HbMiKahpohG6AaPk4a9atEAu/ZJ
 aWWwVnvlYcxxIJpm49pSC6CjkUyC2dvUosA+TV6GLhuyuwQ0EyFkrRDdIXM3s25/sh3e
 OoYI/9KyjX+4dw/6jMHtxph5yBS047uguxFwD/U52zT0US9xhSKjpQMKLgNejPeRoBlm
 +bqJOMB2FeH/2PU3E3bY/7t+3UD1/AJMlMT0iuGFZ+FblTfAtkUiM6CnqarcRiOh8twU
 dqKCdBRDDnPpMDwniUH4nXzM4YBh5GQ3C9N5Uzvv3Ahm5Gbnu/pJx7z4SCMNjTXSTnSU
 OkkA==
X-Gm-Message-State: AFuF++mlxg9Bd4CFPqg/anQJ6051ZBXFg3C8Du9Bd+CahG9EX2W4Icdp
 jbvjF+wMj+FCqOvPl0uV/gaEOCuoInnuBNc0LErHMeuE0P9PhmB4XoBXYxAbEuGsNI11WM32Q3+
 Qs/U1JgA9nLE3ThkSVit5Id9KyE/lJ8g=
X-Gm-Gg: AR+sD13HepJXUD6gDtanIwqEJuj24EC5O02qckCRTtSQ0gx8WwpxqDP9C+LpnljxFgO
 lFmUV+fWtHFb3v3NrguXCf/1YmVOF27ETmiuYlWpwOaNx2cF1FY8mTtEf4re2rEcEkx7SB0SRnl
 AaW0S7BFvxgUL8IBCR/NH1E5SI2R+Y8u43kPXGxe8raN0VnaEhCGgyB0PRYvQrDysF4e1OCf/8M
 pF6Om52rPh0EhLFts/7PEcglsabt/entPORwqcnCRBp8Va9W19BpzQsD8XCIS77dBF2CKzFIM3P
 9j/ghdyVLbIF/phZ0vk6Om+HGKECNNGwdW9PBQ09TkP9DI4gyCdJ8vmll7ahZI5siYBgJoFhudv
 M
X-Received: by 2002:a17:90b:180e:b0:396:5c22:b1f1 with SMTP id
 98e67ed59e1d1-396d0e26ca8mr11352503a91.8.1787920638740; Fri, 28 Aug 2026
 05:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
 <a0bd3ef2-91df-4a6d-a04f-67a568188b24@rsg.ci.i.u-tokyo.ac.jp>
 <d71116d3-2108-4f14-baa0-d2f1f878b5f4@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d71116d3-2108-4f14-baa0-d2f1f878b5f4@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:37:06 +0400
X-Gm-Features: AcwNN1WoGitMOVY0JnrM_Aq9EWz9J28o01c2Vj6SJJwhEJsMN5DeaHRhP9eVZow
Message-ID: <CAJ+F1C+BPPLcko6nqK5vCTn81D=CHv3m_bvqDiQzbc-shY1S2A@mail.gmail.com>
Subject: Re: [PATCH 00/18] RFC: various virtio-gpu/dmabuf related fixes
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, swing <swing@mail.exp.sh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Fri, Aug 28, 2026 at 4:29=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/08/28 21:26, Akihiko Odaki wrote:
> > On 2026/08/25 19:20, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi,
> >>
> >> While working on CVE-2026-66020 (which had a few revision on list), I
> >> kept finding several places where virtio-gpu scanout and dmabuf
> >> ownership was unclear.
> >>
> >> The CVE comes from using a blob after RESOURCE_DETACH_BACKING has
> >> unmapped its memory. Following that path also found stale dmabuf
> >> references, duplicated scanout bookkeeping, and inconsistent cleanup
> >> between display backends.
> >>
> >> This series makes each virtio_gpu_scanout own its current dmabuf and
> >> uses resource_id to track which resource it displays. It also makes
> >> QemuDmaBuf own its file descriptors and moves GTK fence state out of t=
he
> >> dmabuf.
> >>
> >> Those changes touch a lot of area and I have done basic testing with t=
he
> >> various backends. I would not recommend backporting them to stable:
> >> there is a high risk of introducing regressions. Yet, I don't know how
> >> to address all the problems uncovered by CVE-2026-66020 in a simple
> >> patch series. Help welcome!
> >
> > If you mean "all the problems", my coding agent tells there are some
> > problems remaining:
>
> I forgot to note that I manually reviewed the claims.
>
> I also think you can drop RFC. Though the series is large, each patch is
> small and I think reasonable.
>
> >
> > 1. Vhost-user still has duplicate, incomplete DMA-BUF ownership.
> >
> > VhostUserGPU retains its separate g->dmabuf[]. The contrib backend
> > disables a scanout using ordinary VHOST_USER_GPU_SCANOUT with zero
> > dimensions, but the QEMU frontend handles that by only calling
> > qemu_console_set_surface().
> >
> > Although that changes con->scanout.kind, it neither releases g-
> >  >dmabuf[id] nor invokes the frontend GL-disable callback. GTK/SDL can
> > therefore retain their private scanout mode and redraw the old buffer;
> > the wrapper and owned fd remain until another DMA-BUF message. Reset an=
d
> > finalize also never free this array.
> >
> > Separately, contrib=E2=80=99s virgl RESOURCE_UNREF destroys the rendere=
r
> > resource without disabling scanouts using it. The in-process virgl
> > backend fixes precisely this case, but contrib does not.
> >
> > 2. GTK DMA-BUF texture release lacks the required GL context.
> >
> > GTK=E2=80=99s release callback directly calls egl_dmabuf_release_textur=
e(),
> > which calls glDeleteTextures() and then unconditionally forgets the
> > texture ID. Neither it nor the core release dispatcher establishes the
> > owning context.
> >
> > This is reachable after another GTK console=E2=80=99s surface update le=
aves
> > EGL_NO_CONTEXT current. Deletion is then not guaranteed, yet the ID is
> > lost, leaking the GL import and backing. With another unshared context
> > current, a coincident texture name could be deleted from the wrong
> > context. SDL has the same missing-context pattern.
> >
> > 3. Rutabaga resource destruction remains incomplete.
> >
> > virtio_gpu_rutabaga_resource_unref() calls Rutabaga unref and frees the
> > QEMU resource, but does not clean res->iov/res->addrs or remove a mappe=
d
> > blob=E2=80=99s host-visible MemoryRegion. Only explicit RESOURCE_UNMAP_=
BLOB
> > removes that region.
> >
> > Consequently, MAP_BLOB =E2=86=92 RESOURCE_UNREF or reset can leave a
> > MemoryRegion pointing at storage destroyed by Rutabaga, as well as
> > pinned DMA mappings. This is adjacent to, rather than the original
> > scanout-detach CVE, but it is another unresolved blob-ownership problem=
.
> >
> > ...so there is still some work to be done.

Thanks for the analysis. Do you think we can review & apply this
series first before addressing the remaining issues? (and helping me
:)

> >
> > But when it comes to backporting, I think we can instead do focused
> > backporting to avoid extra trouble. Concretely, the patches you tagged
> > with "Fixes: CVE-2026-66020" can be backported, namely:
> >
> > - "[PATCH 10/18] virtio-gpu: disable blob scanouts on mapping cleanup" =
and
> > - "[PATCH 18/18] virtio-gpu: fix use-after-free on blob cursor after
> > detach"

Cc: qemu-stable for those two only? even if there are still corner
cases addressed by the other patches)?

thanks again

