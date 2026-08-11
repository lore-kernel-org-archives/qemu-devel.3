Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DF7C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfyr-00037e-W4; Tue, 11 Aug 2026 02:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtfyn-00037G-SQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:28:54 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtfym-00016q-5z
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:28:53 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-930f4e5eed1so19598085a.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786429730; cv=none;
 d=google.com; s=arc-20260327;
 b=A8vkxIyTloOgdbTxzC4QJdrGCHKe+E2iod7VQO8BAAfBhe9s9zCz09JWUqWwAGQLiL
 AFsBvNIJbSuaRhnp+wtOQzIAFZfDS9HEid5AbFoWUMgrxg3G002PJlkfgTUIZcaco271
 DTtTN56NBbRrCyux4Xl2blO2pQOfd/2gRHiExOmEBoASyk6FXzkleipWZ6aLpVEUnuTy
 GS8QD05MdYh8VFTBETHNBgmYZkKHO20xWHC83bf25tizCqEt/Vcymdi39k/3oHAnxPgl
 wZPOuFeRiEB2+M9FMyAFVYOLpU3LNGj1PcieeBAhp2UmriK4BVBergPiOD5lHeXddBOu
 dRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qk+rCaZz7kJBNbLgETOFxIZK9svgbPsa00ch9b+croA=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=g2zqoa3d9FRoLWb9ZjVrec6KktGxJcHpClvYP49InlDHnn3cHLoeSxvGyxQzDaFPE6
 3FEalOcJOnC+Xuh4RBE+G1yywocDGkbbeA9xRy6jWREGkI3ZVkFUKbudRmaoyt760jE2
 ee5bnteXzIlP0Tr3KqPlhqGQGzvMVmebwqebIEEpCxQ7+JBFI3asIkdOrwF99QgUdKB6
 UbdQp1CMUwMe9f8XcLM2quZUNDtqKbdbc4gO3f/JXuoGcm1tu5Vi8C9T1CgDCGFWZm6+
 ajxbwcF96pziBUhko2lfdzMT1Lv9XubshBnFzn0EL9o/NKT72EmwBbwJ9mETtfEL2UjI
 asuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786429730; x=1787034530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qk+rCaZz7kJBNbLgETOFxIZK9svgbPsa00ch9b+croA=;
 b=EP6i2F6vT5fzS/0rTn53pNivhbdiilakxprcTaWJhd/PIuvm06w/go1WJLikPLYa11
 uaU4msMlVOQKSe57WKSa2F9a33vJI8m4AbUCx2XlCz1OVbMJ7mzeBiPF+91/dUDHy6cn
 7TSc5rHosOTJ2GTwcTV/AvsLwtxCEsFp6nMIoLf90VEvLncJfMCIW6Cv9PRyMOQ/gMRW
 JCVhJdq6oQTiwB18QhRyqdnZBJhYXlP9nKUTYBasUF22sh8QbPVkae5vQHD4AdQuhmc9
 TYtK7Uhr1ipLXGTt/sfVhTRgdxKrllsXLJWXVQSVOHjBbznZICdltmgSMxAfwuWt5wJM
 X99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786429730; x=1787034530;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qk+rCaZz7kJBNbLgETOFxIZK9svgbPsa00ch9b+croA=;
 b=AISClq4h8uGmHug8t66PzRAx9Bx5KlAJepF53QCgCaT005p0+eINZ4AyOXs1pXcGNk
 H7cVCd60VkH51nhgU3ZT5+8EHae35fMRtJdWsZ5gXgYFJ3ffgh7ccEzvedFviE10dmWZ
 nQdgzwdSpfM7V6oZtkYCwUaBJM/eRLdx+uaQqlReVuY6gaPQtg7/2z7oIQgx2IqcasQL
 xwC4q6erSwxbmGQVVZcGYTJJKv3sV2PSrWtuz6hyEC4KmwvuEnCm61yN2sQcuILo6mXA
 1ePNmMygNARvAeOueMctmb8Xq2WxFK5k8rs16QvVtuR0Hzl0B/TlJHcX81FH77ggVPUR
 V4YQ==
X-Gm-Message-State: AOJu0YzB63lVCiNWBtm7jtMFt/vE9OcsuYXUABRD1fwogVxPAneqrP+T
 QbuU4egZsxAZ7r/qLTA5ImAZs86gu/ezLdfWHsRUVngClH3l8OFsYqwMw88GW0M5DueaGQg08ja
 Ee7Wjz0AlKpHUFELXjRMqjgKy17/V4vI=
X-Gm-Gg: AR+sD13+7t94vpSQiD/cDk3eAwWpN86QyDkFL5YAW/3dyFIlMOqIesgA8ZH/W4dBEsY
 xH5b1/Viuc1x1LQIbeLh2D9jGg24a37W0CY5apkZ+fmrHgJN38UUpncZMasrNfQWKIfp0xtd3eR
 jxV8B2gDXT6egeplTsBNx55OiJMZsdzZYlf7lz6YFP76dVLjEQ3XfxsETZuobH3XpOWRLsQ8OpF
 DA6eaSUOy4nfchSCV4ptZtLOG41/+EwD25p+/3Wzr6IgqKiqieS86v4TE4XwCZT3iYaMieKb0fO
 zhCg5c5MIpR5CNXBrfealUdeytiWoNusBdhQ8T7AdF6VKowsJCdAfup7S8jiu0/+ZXEADBDfoXm
 3N+M=
X-Received: by 2002:a05:620a:d85:b0:92e:8a84:7041 with SMTP id
 af79cd13be357-936a8e6cae7mr73114885a.8.1786429729981; Mon, 10 Aug 2026
 23:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-14-6b97c439eb28@gmail.com>
 <f3ff63d6-6e88-4c82-9455-ca250aa42170@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <f3ff63d6-6e88-4c82-9455-ca250aa42170@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 10 Aug 2026 23:28:37 -0700
X-Gm-Features: AUfX_mzPDsezATrFYKlhOp6dhdhhkEzRtL-sBWPEdLTmR2c4JyFU57etfo2dkd4
Message-ID: <CA+spn3qLUh2CWoKMDV=jQrughZmZ9DgBE+gidbn1xmTxCqpNsQ@mail.gmail.com>
Subject: Re: [PATCH RFC 14/15] hw/virtio/vhost-user: handle data movement with
 shadow vqs
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=connorkite@gmail.com; helo=mail-qk1-x733.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 24, 2026 at 8:20=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
>
> This copies data in the reversed direction.
>

Good catch!  This will be fixed going forward.

...


> > +    DMAMap needle;
> > +    hwaddr *iova_base;
>
> Please make it void *.
>

Got it!

> > +
> > +    for (int i =3D 0; i < elem->out_num; i++) {
> > +        needle.translated_addr =3D elem->out_addr[i];
> > +        needle.size =3D elem->out_sg[i].iov_len - 1;
> > +        map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
>
> An error check is missing here. This translation does not seem to
> support IOMMU.
>

I have added in the error check.

Looking at vhost-vdpa, there is an
error when IOMMU is enabled at the same time as shadow virtqueues.
I'll need to dig into what, if any, work is needed to make svqs compatible
with IOMMU enabled.  For now, I can implement a similar check in
vhost_user_dev_start to that in vhost-vdpa.

> > +        offset =3D needle.translated_addr - map->translated_addr;
> > +        iova_base =3D (void *)(map->iova + offset);
> > +
> > +        elem->out_sg[i].iov_base =3D iova_base;
>
> elem->out_sg shouldn't be overwritten since virtqueue_unpop() will use
> it to unmap the element.
>
> > +        memcpy(iova_base, elem->out_sg[i].iov_base, needle.size + 1);
>
> This memcpy() is no-op. elem->out_sg[i].iov_base is already set to
> iova_base, so it's copying from iova_base to iova_base.
>

Roger!  There were a number of unnecessary adjustments to elem in
both handlers which should now be fixed.  As the IOVA and hva of the
isolation region are no longer the same (see Patch 11), there are some
additional changes required here, but the memcpy issues should also
be fixed for the next rev.

> > +    }
> > +
> > +    for (int i =3D 0; i < elem->in_num; i++) {
> > +        needle.translated_addr =3D elem->in_addr[i];
> > +        needle.size =3D elem->in_sg[i].iov_len - 1;
> > +        map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
> > +        offset =3D needle.translated_addr - map->translated_addr;
> > +        iova_base =3D (void *)(map->iova + offset);
> > +
> > +        elem->in_sg[i].iov_base =3D iova_base;
> > +        memcpy(iova_base, elem->in_sg[i].iov_base, needle.size + 1);
> > +    }
> > +
> > +    vhost_svq_add(svq, elem->out_sg, elem->out_num, elem->out_addr,
> > +                  elem->in_sg, elem->in_num, elem->in_addr, elem);
>
> An error is ignored here too.
>

This is added now.

> > +
> > +    return 0;
> > +}
> > +
> > +

...

> > +    for (int i =3D 0; i < u->shadow_vqs->len; i++) {
> > +        VirtQueue *vq =3D virtio_get_queue(dev->vdev, dev->vq_index + =
i);
> > +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(u->shadow_vqs,=
 i);
> > +        svq->base_addr =3D (hwaddr *) vring_base;
> > +        vhost_svq_start(svq, dev->vdev, vq, u->iso_iova_tree);
>
> Calling vhost_svq_start() here overwrites the shadow vring index
> configured in vhost_virtqueue_start().
>

I might not understand what you are referring to here. If I understand
correctly,
vhost_virtqueue_start() does not touch any shadow vring indexes, so I
don't think
vhost_svq_start() could overwrite something configured there.

However, I see that the assignment to addr.index followed by
vhost_user_set_vring_addr
might create a disconnect between the vq index and that sent to the
backend.  It's possible
my ordering is just right as is, but I will confirm by assigning
virtio_get_queue_index(vq) to
addr.index

> > +
> > +        struct vhost_vring_addr addr =3D {
> > +            .index =3D dev->vq_index + i,
> > +            .desc_user_addr =3D vring_base,
> > +            .avail_user_addr =3D vring_base + sizeof(vring_desc_t) *
> > +                svq->vring.num,
>
> This assumes the ring is split, but VIRTIO_F_RING_PACKED is not rejected.
>

Currently, shadow virtqueue does not support packed vrings, so I can't here=
.  It
is a good idea to add a check and reject VIRTIO_F_RING_PACKED.

> > +            .used_user_addr =3D vring_base + vhost_svq_driver_area_siz=
e(svq)
> > +        };
> > +
> > +        vhost_user_set_vring_addr(dev, &addr);
>
>
> The initial ring startup is ordered incorrectly. Generic startup
> suppresses SET_VRING_ADDR, installs SET_VRING_KICK, and injects a kick;
> only the later backend-start hook creates the shadow ring and sends its
> address. SET_VRING_KICK starts the ring, so the backend can process
> before receiving valid addresses. The late SET_VRING_ADDR result is also
> ignored.

I think to avoid this issue, I need to assign svq vring locations when the =
mem
table is getting set, rather than on device start, as the svq
implementation seems to
expect.

It is likely that the isolation mode implementation will end up moving
up to vhost rather than
vhost-user.  If that's the case, some of the complexity around
tracking order of operations should
be simplified.

Best,
Connor

