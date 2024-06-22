Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D440C2BB85
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 04:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKsRs-0003v6-EW; Sat, 22 Jun 2024 00:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sKsRr-0003us-Dk
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 00:33:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sKsRp-0006w0-A4
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 00:33:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f9b364faddso23248805ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 21:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719030836; x=1719635636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U928YwRXTXmHBUJIicNJdvuxM1L86valDlAMu1boHAA=;
 b=Y1TFHhD3LLhfNvThfXPCXVvCtt9KiVe0h5Ys3d7E3ilPSpwEtjtchiQlErG44JHPtU
 W0KBd+OXkK+cMJ96G5sckpu4jcRyQv4LmMpHwDCKHTm/28gUzRMNrRF/z2oplGr2I5Zk
 Lex/yUtwOSn3ONwTbIKuPmgibm39CmcG3AtHsloDlDi6RPjXzbpSOeflBm2ALpr5q7b0
 LW9S52jpVK5pSis8/n5gKNkS7YOCZRKcorA3NgItYK6MbWPKPJWO5ox72RO2MbUu6f7o
 aSItVFTUOPntWMleYD/x8eCXr9dnCanAFlCrgGigr3RMPrBmu0ltjiv5xjqMUEnWzYRv
 hEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719030836; x=1719635636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U928YwRXTXmHBUJIicNJdvuxM1L86valDlAMu1boHAA=;
 b=snyBF1Q6O8mNRHBKJuX9FxMH2CX0GuBrs7xEFUp3DqS7FINhu9YQucZ3XxBGsvxpIF
 TBnDD7rLVGMIVaAGPqKEABg9Vhsv5i13XlkL+KHncmvG0DBmCMSMuLFva1oapJs9lENp
 TsTras3PLSqT5sA+7uPNFXVBUlrdXEOMYSLsSK7s421Qmzxym1mBMZ0mWSvgopdMmz5a
 eb5H4ypQTL7zqO1HH7PcpgDHngzM2T5CgegWT3aRsoqEK58mrLOH1uNXssKttepFrpNy
 ZCvSu2cuzzFXA/y635qpJzFSMJPASIeM8rVOEoQHITqs28N95Sj35yYYir9WpV+jsGVc
 Aj9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM/Q+cbXPRhwGGvnbAKoaVXB592Fqo1xmQSApSfgefcMm8wnQnmKCLPMM2Sv0QcGgYL3inrq9fQgxa1pFtuSD4pIyD76k=
X-Gm-Message-State: AOJu0YxqyweW1q3WSGYIIIouOwDDoWm54zJ6vzNytBZbYUfaMI17Lulk
 v+VTteFQ9OzUiLFbXRFXnFmLGUaJAbbrgYQ9TgdWTqvFEcyvj4Cv
X-Google-Smtp-Source: AGHT+IGTkHvTTtgD/iPxeXzLJIV74SUnKThkG+zYZ995v3b6eAH3aYWhO9dqrvP2lA2QT0boDrFtTw==
X-Received: by 2002:a17:902:e5c6:b0:1f9:b681:1956 with SMTP id
 d9443c01a7336-1f9b6811d1dmr98362505ad.61.1719030835422; 
 Fri, 21 Jun 2024 21:33:55 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.83.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c5cf6sm22252615ad.156.2024.06.21.21.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 21:33:54 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC] vhost: Introduce packed vq and add buffer elements
Date: Sat, 22 Jun 2024 10:03:44 +0530
Message-ID: <3301839.44csPzL39Z@valdaarhun>
In-Reply-To: <CAJaqyWc8L2rZULeHgqmuieAqmQvePm9sicJFGq+POKPLYQMLJg@mail.gmail.com>
References: <20240618181834.14173-1-sahilcdq@proton.me>
 <CAJaqyWc8L2rZULeHgqmuieAqmQvePm9sicJFGq+POKPLYQMLJg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

On Wednesday, June 19, 2024 3:49:29=E2=80=AFPM GMT+5:30 Eugenio Perez Marti=
n wrote:
> [...]
> Hi Sahil,
>=20
> Just some nitpicks here and there,
>=20
> > [1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue
> >=20
> >  hw/virtio/vhost-shadow-virtqueue.c | 124 ++++++++++++++++++++++++++++-
> >  hw/virtio/vhost-shadow-virtqueue.h |  66 ++++++++++-----
> >  2 files changed, 167 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c
> > b/hw/virtio/vhost-shadow-virtqueue.c index fc5f408f77..e3b276a9e9 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -217,6 +217,122 @@ static bool vhost_svq_add_split(VhostShadowVirtqu=
eue *svq,
> >      return true;
> >  }
> >=20
> > +/**
> > + * Write descriptors to SVQ packed vring
> > + *
> > + * @svq: The shadow virtqueue
> > + * @sg: Cache for hwaddr
> > + * @out_sg: The iovec from the guest that is read-only for device
> > + * @out_num: iovec length
> > + * @in_sg: The iovec from the guest that is write-only for device
> > + * @in_num: iovec length
> > + * @head_flags: flags for first descriptor in list
> > + *
> > + * Return true if success, false otherwise and print error.
> > + */
> > +static bool vhost_svq_vring_write_descs_packed(VhostShadowVirtqueue *s=
vq, hwaddr *sg,
> > +                                        const struct iovec *out_sg, si=
ze_t out_num,
> > +                                        const struct iovec *in_sg, siz=
e_t in_num,
> > +                                        uint16_t *head_flags)
> > +{
> > +    uint16_t id, curr, head, i;
> > +    unsigned n;
> > +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc;
> > +    bool ok;
> > +
> > +    head =3D svq->vring_packed.next_avail_idx;
> > +    i =3D head;
> > +    id =3D svq->free_head;
> > +    curr =3D id;
> > +
> > +    size_t num =3D out_num + in_num;
> > +
> > +    if (num =3D=3D 0) {
> > +        return true;
> > +    }
>=20
> num =3D=3D 0 is impossible now, the caller checks for that.

Oh yes, I missed that.

>=20
> > +
> > +    ok =3D vhost_svq_translate_addr(svq, sg, out_sg, out_num);
> > +    if (unlikely(!ok)) {
> > +        return false;
> > +    }
> > +
> > +    ok =3D vhost_svq_translate_addr(svq, sg + out_num, in_sg, in_num);
> > +    if (unlikely(!ok)) {
> > +        return false;
> > +    }
> > +
> > +    for (n =3D 0; n < num; n++) {
> > +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_used_fl=
ags |
> > +                (n < out_num ? 0 : VRING_DESC_F_WRITE) |
> > +                (n + 1 =3D=3D num ? 0 : VRING_DESC_F_NEXT));
> > +        if (i =3D=3D head) {
> > +            *head_flags =3D flags;
> > +        } else {
> > +            descs[i].flags =3D flags;
> > +        }
> > +
> > +        descs[i].addr =3D cpu_to_le64(sg[n]);
> > +        descs[i].id =3D id;
> > +        if (n < out_num) {
> > +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
> > +        } else {
> > +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_len);
> > +        }
> > +
> > +        curr =3D cpu_to_le16(svq->desc_next[curr]);
> > +
> > +        if (++i >=3D svq->vring_packed.vring.num) {
> > +            i =3D 0;
> > +            svq->vring_packed.avail_used_flags ^=3D
> > +                    1 << VRING_PACKED_DESC_F_AVAIL |
> > +                    1 << VRING_PACKED_DESC_F_USED;
> > +        }
> > +    }
> > +
> > +    if (i <=3D head) {
> > +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> > +    }
> > +
> > +    svq->vring_packed.next_avail_idx =3D i;
> > +    svq->free_head =3D curr;
> > +    return true;
> > +}
> > +
> > +static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> > +                                const struct iovec *out_sg, size_t out=
_num,
> > +                                const struct iovec *in_sg, size_t in_n=
um,
> > +                                unsigned *head)
> > +{
> > +    bool ok;
> > +    uint16_t head_flags =3D 0;
> > +    g_autofree hwaddr *sgs =3D g_new(hwaddr, out_num + in_num);
> > +
> > +    *head =3D svq->vring_packed.next_avail_idx;
> > +
> > +    /* We need some descriptors here */
> > +    if (unlikely(!out_num && !in_num)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Guest provided element with no descriptors");
> > +        return false;
> > +    }
> > +
> > +    ok =3D vhost_svq_vring_write_descs_packed(svq, sgs, out_sg, out_nu=
m,
> > +                                            in_sg, in_num, &head_flags=
);
> > +    if (unlikely(!ok)) {
> > +        return false;
> > +    }
> > +
>=20
> Ok now I see why you switched sgs length from MAX to sum. But if we're
> here, why not just embed all vhost_svq_vring_write_descs_packed here?
> vhost_svq_vring_write_descs makes sense to split as we repeat the
> operation, but I think it adds nothing here. What do you think?

You're right. The function is called only once and there is nothing to reus=
e.
I'll move "vhost_svq_vring_write_descs_packed" to "vhost_svq_add_packed".

> > [...]
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.h
> > b/hw/virtio/vhost-shadow-virtqueue.h index 19c842a15b..ee1a87f523 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.h
> > +++ b/hw/virtio/vhost-shadow-virtqueue.h
> > @@ -46,10 +46,53 @@ typedef struct VhostShadowVirtqueueOps {
> >=20
> >      VirtQueueAvailCallback avail_handler;
> > =20
> >  } VhostShadowVirtqueueOps;
> >=20
> > +struct vring_packed {
> > +    /* Actual memory layout for this queue. */
> > +    struct {
> > +        unsigned int num;
> > +        struct vring_packed_desc *desc;
> > +        struct vring_packed_desc_event *driver;
> > +        struct vring_packed_desc_event *device;
> > +    } vring;
> > +
> > +    /* Avail used flags. */
> > +    uint16_t avail_used_flags;
> > +
> > +    /* Index of the next avail descriptor. */
> > +    uint16_t next_avail_idx;
> > +
> > +    /* Driver ring wrap counter */
> > +    bool avail_wrap_counter;
> > +};
> > +
> >=20
> >  /* Shadow virtqueue to relay notifications */
> >  typedef struct VhostShadowVirtqueue {
> >=20
> > +    /* Virtio queue shadowing */
> > +    VirtQueue *vq;
> > +
> > +    /* Virtio device */
> > +    VirtIODevice *vdev;
> > +
> > +    /* SVQ vring descriptors state */
> > +    SVQDescState *desc_state;
> > +
> > +    /*
> > +     * Backup next field for each descriptor so we can recover securel=
y,
> > not +     * needing to trust the device access.
> > +     */
> > +    uint16_t *desc_next;
> > +
> > +    /* Next free descriptor */
> > +    uint16_t free_head;
> > +
> > +    /* Size of SVQ vring free descriptors */
> > +    uint16_t num_free;
> > +
>=20
> Why the reorder of all of the previous members?

I was thinking of placing all the members that are common to packed and
split vring above the union while leaving the remaining members below the
union. I did this based on our discussion here [1]. I don't think this reor=
dering
serves any purpose implementation-wise. Please let me know if I should reve=
rt
this change.

> Apart from the nitpicks I don't see anything wrong with this part of
> the project. Looking forward to the next!
>=20

Thank you for the review.

Thanks,
Sahil

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg02591.html



