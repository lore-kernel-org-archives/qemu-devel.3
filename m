Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8C8C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 00:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wufOC-0005CJ-4R; Thu, 13 Aug 2026 20:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wufO9-0005Ba-Vi
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 20:03:10 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wufO8-0001rl-1l
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 20:03:09 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-52b3934af3fso5197341cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 17:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786665786; cv=none;
 d=google.com; s=arc-20260327;
 b=fF24dHExWywvB4KX9kkgrcEbmPzzDQu5laEyRh66u4uNaGr/M/07v0+276tas9sC78
 DI++IqlcE0jEguxWfm/bzu7OhPRvQL051tyZGiBXF7QSCOdHcxEIXfLKZ6JWAW+Apai+
 wF7MamEn6iaNF6Cron8aJd+seUIMux89RkrcBTz3LO6NkfLcyCQKyrtnUAFySLMaQPel
 NHecwg04iepPl5FZvcpgSaKLY515kETCKL11l10Yys+zABtJPDUrXnK+aF+MxAS8nlTU
 vXXG8CIXTram2eoimymD8ObrC/QLEkv9vl9zhgPq8kb6wOtJVpxXJvvWkg9gq90xxeMx
 i1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u7OtRASg8DB2m86V8Edb6D9/poU/y5LEwaT9mbL/IAQ=;
 fh=xsRg86ZwBm0LGRQZIEC1R+b8QTOodxCX7/oSmDWEnOY=;
 b=Wvytv0QSBBKFoWsgdtGGkGOq8SmmmcRJUCrT6e5/GVXxbdz6Oh9Jqx0Xdm/7nC10HJ
 STSwJ3VPhF0YMco2odh6x0pQ0au+ImNtm9PFrwFfJTXiRtQ9DazCw1waPyQ8ys6cu1oO
 1MHF0jchZbD3Me05ky0hMVm3TlTHOSEieHCseiXPS2DBsXAloCY9MyOK3kvowPxl6crV
 HLf+8D9prs83GCpGRPQAcbzcLtxZ4DdIuL07tdlrUZUblTHz+fMfM6V07u+Q5blKC6jM
 Kwpg9CKNikTVXa2Rij8NC5oeH5TybBl6sxsQUKWPtecEydT5VO2rdnf6VQ9tN09gPdlp
 hoQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786665786; x=1787270586; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u7OtRASg8DB2m86V8Edb6D9/poU/y5LEwaT9mbL/IAQ=;
 b=fKkpabVThHP+HIlvUKHc5Lv3uMQ5ROphzmoDAhpcHDXDVx7VEpQAd+B3u8xdtGKx/V
 KPvbvkA4KDMakW39jHJWAVk0feISm6AJu6rqUtetmhky2LOx6AmkqSkFmMECjiLaXvzs
 +SxVQWahMfc0gHWoiBLgV3Qo9iLQTHQSl0SXjqpv5gPioW3GY1lPj5X3SfoCvLDRdMUF
 A+lQMR3u2W1IMv90wAI4hEXlgaus3MB/SOFXsd4YvovVvawTGFcj+fI54DP2+lhi6iVB
 GCjvgYaamKeMaSg1XBzSFfXlq6SmQB9bTQ3keFaBVLUbyF3f1sm3P7yq+bV+X5NOzKOw
 BCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786665786; x=1787270586;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u7OtRASg8DB2m86V8Edb6D9/poU/y5LEwaT9mbL/IAQ=;
 b=I0q3m/bIhKqIQU6WMoQK0IGQchUs8rztNntzV5s9JlKJPIWrzuIooYyE8Sicc+PUhx
 it65+/bP2iA7PwXEX6pWshpxYgBPK68fbJMzx+yMHTtXFTwGoSfA3Vxqr2jup4jf41lQ
 Z04D+/W9P4o82W55BMDUIGFx4rkPoKACJipIfpx1yqjZ8yUAgwq5W0oUIGZSSzxZNQ29
 ldpnvNF+3mg+KpGn391ib4IJKqBkfYGXsmA58okWMCXA4/AmfrvT1Wdd5P0OXpAs9Iy3
 kvymQX+cnitWM5b9+mUdFnaVouhAZn1yNBKreMB3VsYDBWIYrk6ACzWuPyofgwckBUiL
 EIDA==
X-Gm-Message-State: AOJu0YwmS2sFUDD/+z9cSbx+6nZbP5ILzbW9+7VXDwJQnPNbBRXZiR5G
 +a/2M8NyUaSZRN1qw0ySjnOrfp4ii3qaCRTkmLS2pcudUMDKZhk7OtjYhHSiywVNe4vurMgy9um
 bsMofoxbSRYY7gQTSl5umblhZsF/vxt0=
X-Gm-Gg: AR+sD12uLI0m572yjcGWkyCeHfQfZumbiwiHAFrA9/8mkcbbhGBND98FXFB3Exp9Q84
 R/Ot6upHthU8lkEZo9V3ZK+zoEXwMMpMXo1rFheAfjOG/mWBMP4KRme4F4sE7XMcqtbJINRVP59
 ovF5Kj3g5cfGDiVNstHdaeDABzC+6MIi8Z0OVFgZkS28YzaCkcowIxnnFq2sJXrWGbEuOZvwgEA
 yL3a3EMq2c5rdqhdrgSK4tpggJE5Ik4n9v9ffBPP/cRlNyvEy5MTBx0VvwPzlS1Cms4LZKysoH5
 5ibRZmgYutoFI/bSeRten/pgj9p4q4LcSAc3LNzH6OqSf2DpsErk3SkMdEh6D2TpBu3GfVnEgPM
 a1w==
X-Received: by 2002:a05:622a:4d4c:b0:51b:fd82:22dd with SMTP id
 d75a77b69052e-52d853621dcmr25554081cf.15.1786665786564; Thu, 13 Aug 2026
 17:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-14-6b97c439eb28@gmail.com>
 <31183362-f4b6-4afd-8c6d-2e1b5db35225@redhat.com>
In-Reply-To: <31183362-f4b6-4afd-8c6d-2e1b5db35225@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 13 Aug 2026 17:02:55 -0700
X-Gm-Features: AUfX_mz22qa9zpcH9_K3CSX5pHnkrpyDOp-6UI8yg-Y10S5wzIgI8sUoiiq6vKQ
Message-ID: <CA+spn3rAetqaW7YEL2cyAW8PY6wUJZaBEN6ce8LP0SU4W70xvQ@mail.gmail.com>
Subject: Re: [PATCH RFC 14/15] hw/virtio/vhost-user: handle data movement with
 shadow vqs
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x830.google.com
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

On Mon, Aug 3, 2026 at 7:10=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> On 24.07.26 00:30, Connor Kite wrote:
> > - Add start logic for shadow virtqueues, which sets vring addresses.
> > - Update logic for sending vring addresses to backend to point
> >    to the shadow vrings when isolation mode is active.
> > - Implement handlers for intercepted avail and used descriptors. These
> >    handlers copy buffer contents between bounce buffers in the isolatio=
n
> >    region and the buffers made available by the guest
> > - Implement logic to stop svqs
> >
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > ---
> >   hw/virtio/vhost-user.c | 167 ++++++++++++++++++++++++++++++++++++++++=
++++++++-
> >   1 file changed, 166 insertions(+), 1 deletion(-)
>
> In general, I find it strange to use two completely separate data
> structures for the address translation in either direction (avail/used).
> I suppose we could have a map of in-flight translations, adding entries
> in avail, and looking for them in used, removing them from the map.
>
> I mean, sure, right now, we can calculate the addresses, because we
> =E2=80=9Cduplicate=E2=80=9D the whole range of guest memory for each devi=
ce, but that is
> clearly a waste and it would be better to use a smaller size in the
> future; and then each request will need to allocate from that smaller
> device memory, get a random address, and that will need such a map for
> tracking.
>

Definitely agreed that the mapping could be done smarter to avoid
allocating such
a large region.  I think this would a reasonable optimization for when
the project is
more mature.

For your first sentence, are you talking about the svq and vhost_iova_tree =
data
structures?
...

> > +static int vhost_user_svq_handle_used(VhostShadowVirtqueue *svq,
> > +                                      VirtQueueElement *elem,
> > +                                      void *opaque)
> > +{
> > +    hwaddr hva;
> > +    int r;
> > +    struct vhost_dev *dev =3D opaque;
> > +
> > +    for (int i =3D 0; i < elem->in_num; i++) {
> > +        r =3D vhost_user_memory_lookup(dev, elem->in_addr[i], &hva);
>
> This function only looks for the starting address, so it is not
> guaranteed that the whole buffer is within one memory region.
>

For the next rev, both handlers will be looking at whether the last address
in the buffer fits in a single memory memory region and will copy from/to
multiple memory regions if necessary.  See below

> > +        if (r < 0) {
> > +            return r;
> > +        }
> > +
> > +        memcpy((void *) hva, elem->in_sg[i].iov_base, elem->in_sg[i].i=
ov_len);
> > +        elem->in_sg[i].iov_base =3D (void *) hva;
> > +    }
> > +
> > +    for (int i =3D 0; i < elem->out_num; i++) {
> > +        r =3D vhost_user_memory_lookup(dev, elem->out_addr[i], &hva);
> > +        if (r < 0) {
> > +            return r;
> > +        }
> > +
> > +        memcpy((void *) hva, elem->out_sg[i].iov_base, elem->out_sg[i]=
.iov_len);
>
> I don=E2=80=99t think we need this `memcpy()` here, as the device may onl=
y write
> to IN buffers, not OUT buffers.
>

You are right! This is removed now.

> > +        elem->out_sg[i].iov_base =3D (void *) hva;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int vhost_user_svq_handle_avail(VhostShadowVirtqueue *svq,
> > +                                       VirtQueueElement *elem,
> > +                                       void *opaque)
> > +{
> > +    hwaddr offset;
> > +    const DMAMap *map;
> > +    DMAMap needle;
> > +    hwaddr *iova_base;
> > +
> > +    for (int i =3D 0; i < elem->out_num; i++) {
> > +        needle.translated_addr =3D elem->out_addr[i];
> > +        needle.size =3D elem->out_sg[i].iov_len - 1;
> > +        map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
>
> Is it guaranteed that the returned `map` will fully contain `needle`?
>

It is not guaranteed.  If the needle range covers multiple regions, the ret=
urned
map would only represent the lowest matching addresses. Care also needs to =
be
taken in copying back to buffers made available by the guest. While the IOV=
A and
iso region hva spaces are all allocated with no gaps, there is no
guarantee the guest
buffers reside in a single region.

The next version I have implemented copies to multiple regions if
necessary, and also uses bounds checking to confirm that:

    1. bounce buffers are fully encompassed by the isolation region
    2. hva addresses in the element actually back the gpa addresses in same

> > +        offset =3D needle.translated_addr - map->translated_addr;
> > +        iova_base =3D (void *)(map->iova + offset);
> > +
> > +        elem->out_sg[i].iov_base =3D iova_base;
> > +        memcpy(iova_base, elem->out_sg[i].iov_base, needle.size + 1);
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
>
> I don=E2=80=99t think we need this `memcpy()` here as the device is to st=
rictly
> write to IN buffers, not read from them.
>

You are correct.  This is removed now.

> > +    }
> > +
> > +    vhost_svq_add(svq, elem->out_sg, elem->out_num, elem->out_addr,
> > +                  elem->in_sg, elem->in_num, elem->in_addr, elem);
>
> Might make sense to make vhost_svq_add_element() public and use it here.
>

Done!  Definitely easier to read.  I guess this adds the overhead of anothe=
r
function call, but that's probably small relative to overhead due to the ex=
tra
interrupts and copying.  We could probably make use of "inline" if trying
to really optimize.

...

> > @@ -1779,6 +1872,25 @@ static int vhost_user_set_vring_addr(struct vhos=
t_dev *dev,
> >           .hdr.size =3D sizeof(msg.payload.addr),
> >       };
> >
> > +    if (u->user->memory_isolation) {
> > +        if (!u->svqs_allocated) {
> > +            return 0;
> > +        }
> > +
> > +        int svq_idx =3D addr->index - dev->vq_index;
> > +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(u->shadow_vqs,
> > +                                                      svq_idx);
>
> Again, bounds checking via `vhost_user_get_vq_index()` would be good.
>

This will be added for next rev.

...

> >
> > +static bool vhost_user_svqs_start(struct vhost_dev *dev)
> > +{
> > +    struct vhost_user *u =3D dev->opaque;
> > +    uint64_t vring_base =3D u->iso_memory.vring_base_addr;
> > +    u->svqs_allocated =3D true;
>
> I don=E2=80=99t like setting this before it actually being the case very =
much. I
> understand that it is necessary for how you decided to set up
> `vhost_user_set_vring_addr()`, but there should at least be a comment
> (because reading this code, there is the obvious question: Why is this
> set when it is not true?); or the code should be different. I.e. having
> a `vhost_user_set_shadow_vring_addr()` function, maybe, which would not
> even take an `addr` argument and could be used both below and in
> `vhost_user_set_vring_addr()`.
>

svqs_allocated should be going away as svq vring addresses will get
mapped earlier
to intercept when vhost allocates vrings.

> > +
> > +    for (int i =3D 0; i < u->shadow_vqs->len; i++) {
> > +        VirtQueue *vq =3D virtio_get_queue(dev->vdev, dev->vq_index + =
i);
> > +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(u->shadow_vqs,=
 i);
> > +        svq->base_addr =3D (hwaddr *) vring_base;
>
> I really do not like the lack of bounds checking here again. There
> should be something, somewhere (i.e. in the =E2=80=9CIsolated memory data=
=E2=80=9D
> portion, maybe in `struct IsolationRegion`), that tells how much memory
> has been allocated for the shadow virtqueues, and we need to check that
> we do not overflow.
>

Got it!  From now on, the total size of the vring allocation is
stored, and bounds
checking occurs as each svq's vrings are allocated.

> > +        vhost_svq_start(svq, dev->vdev, vq, u->iso_iova_tree);
> > +
> > +        struct vhost_vring_addr addr =3D {
> > +            .index =3D dev->vq_index + i,
> > +            .desc_user_addr =3D vring_base,
> > +            .avail_user_addr =3D vring_base + sizeof(vring_desc_t) *
> > +                svq->vring.num,
> > +            .used_user_addr =3D vring_base + vhost_svq_driver_area_siz=
e(svq)
>
> All values set here are effectively ignored, right? Because
> `vhost_user_set_vring_addr()` just overwrites them. (Having a
> `vhost_user_set_shadow_vring_addr()` could maybe save us from having to
> set this up.)
>
> Not that it=E2=80=99s currently wrong to set them this way, just asking.
>
> Hanna
>

You are right about overwriting the values.  I will remove those statements=
 from
vhost_user_svqs_start.

