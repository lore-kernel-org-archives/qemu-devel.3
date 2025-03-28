Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC81C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 06:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty3RS-0002tl-7A; Fri, 28 Mar 2025 02:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ty3RP-0002t6-R8
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 02:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ty3RN-0003wr-EI
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 02:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743144217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQahW0W/1AnV7OX8EQMx65YV0zyKr/k32VH2WuFL9TM=;
 b=asXv2pjcxnQvzsRsfiGIdJ64Dz3sgB0BQbdjiysHTa64NGeyO/nwAKZzbXDqSg0Gd3G0Uh
 bh6VnjuV0iosGj0+plQKsQ4zf1CM9VVKy1uhY3vAb8M33st/aezTpfL5Ck8HbG+7x7pbop
 A2du2/HCbojPDaW5aIW5yiYAjcJD9JU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-ispz_lnoOCGKuM3lNrTlTA-1; Fri, 28 Mar 2025 02:43:35 -0400
X-MC-Unique: ispz_lnoOCGKuM3lNrTlTA-1
X-Mimecast-MFC-AGG-ID: ispz_lnoOCGKuM3lNrTlTA_1743144214
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2254e0b4b85so31979305ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 23:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743144214; x=1743749014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQahW0W/1AnV7OX8EQMx65YV0zyKr/k32VH2WuFL9TM=;
 b=eAVvq8PxLlxXgnKTryFda1lkTxNdLlavb2xZx5ou0WOunOOPFC0inWfF+aHxdEztzy
 QwaNuv6YC0TBnooXjtwMqxl4GQ+/cPnOYxQCluDWJNpi+/Cs0IJibbH1nJ/ajfpvqfEn
 NjUC9txQfNgfiWt1o9hoibXesCNAJq//YOcxuWBPZea+NsRl5f1JbJRbN+p4Y29g93gT
 46QcmfYA6mtQow6Ruoo/ARPuXNqi+20lNzlO8CUzG3Ni5+quqPbl5SONy4tb3J4ocyU4
 54zfU1B6yvDYre0mtUVgxTzG5J/AWjx0Wdcr2b//xfgFDvonCLdhRM2UELuVVq+lBgpR
 V2Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlINneWls6RMKaD2gmxQFiL5dA1FUIbK8+fG6F4Km1YI3OCQMyhzgGCXFp+ywxHU75A6wbRmMyXSQu@nongnu.org
X-Gm-Message-State: AOJu0Yx6o1kJmLeCDXmy1GGm5nceHTTnBoDDbEjacDTDZOTeDAKi9EoH
 AJDWHw7o7/ugsf/YZaYe9GKQkO+DielT2yeBEqiNWL8BE0j212L8iEXRbRnqXHs8SXd67o9ahOY
 Ahr4oBXPlgIVPFo9U0vZURSer/OSWHFXFAFCcME74apMDVXH2xWJowQrfTjVALR9zvE/t7tjdEP
 eLhCf3UBZVhszdzHbKJ8nv/T1CrYk=
X-Gm-Gg: ASbGnctMpLHQ+0qPPptsa3Qf03Czt1PZ6oFBaVAlvsM3gCCCQuj70KcOtqnCyRHvLT7
 kZS671qFGjfTblGNc1kwT2m4Fo7Ft+TtlyT3kjInRLkhJNjnOLGgq3UnGyqp5z6DPbciG/o0=
X-Received: by 2002:a17:902:ebc6:b0:21f:6ce8:29df with SMTP id
 d9443c01a7336-22921c7981emr27478095ad.3.1743144213888; 
 Thu, 27 Mar 2025 23:43:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXKSNOSconUEJR8uW6rAeJTtFZFIMW4A5Tm2G8ePnlZNTck6X86/KS2v1uKBm4kLzdYlSamBQplgbT7qchuPg=
X-Received: by 2002:a17:902:ebc6:b0:21f:6ce8:29df with SMTP id
 d9443c01a7336-22921c7981emr27477735ad.3.1743144213372; Thu, 27 Mar 2025
 23:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-4-sahilcdq@proton.me>
 <CAJaqyWeRhwjTK8CZKNbDzv620664h90PkdWq+gHBs-n6JdkSsA@mail.gmail.com>
 <c8ccbb23-2f44-47a3-aeb5-afe6aa588f73@gmail.com>
In-Reply-To: <c8ccbb23-2f44-47a3-aeb5-afe6aa588f73@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 28 Mar 2025 07:42:56 +0100
X-Gm-Features: AQ5f1JpcKE-YhQXfDr8Mh7yMbpEgPbfi7p6HLRcZYFcRYIhIFecFML55nG-Yq08
Message-ID: <CAJaqyWeC7g+S13cvGZ_sBKPFMJjZ13ZVRzzKpa0Mmsktd7p5RA@mail.gmail.com>
Subject: Re: [RFC v5 3/7] vhost: Forward descriptors to device via packed SVQ
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 28, 2025 at 6:10=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> On 3/26/25 5:32 PM, Eugenio Perez Martin wrote:
> > On Mon, Mar 24, 2025 at 3:00=E2=80=AFPM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >>
> >> Implement the insertion of available buffers in the descriptor area of
> >> packed shadow virtqueues. It takes into account descriptor chains, but
> >> does not consider indirect descriptors.
> >>
> >> Enable the packed SVQ to forward the descriptors to the device.
> >>
> >> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> >> ---
> >> Changes from v4 -> v5:
> >> - This was commit #2 in v4. This has been reordered to commit #3
> >>    based on review comments.
> >> - vhost-shadow-virtqueue.c:
> >>    (vhost_svq_valid_features): Move addition of enums to commit #6
> >>    based on review comments.
> >>    (vhost_svq_add_packed): Set head_idx to buffer id instead of vring'=
s
> >>    index.
> >>    (vhost_svq_kick): Split into vhost_svq_kick_split and
> >>    vhost_svq_kick_packed.
> >>    (vhost_svq_add): Use new vhost_svq_kick_* functions.
> >>
> >>   hw/virtio/vhost-shadow-virtqueue.c | 117 +++++++++++++++++++++++++++=
--
> >>   1 file changed, 112 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shad=
ow-virtqueue.c
> >> index 4f74ad402a..6e16cd4bdf 100644
> >> --- a/hw/virtio/vhost-shadow-virtqueue.c
> >> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> >> @@ -193,10 +193,83 @@ static void vhost_svq_add_split(VhostShadowVirtq=
ueue *svq,
> >>       /* Update the avail index after write the descriptor */
> >>       smp_wmb();
> >>       avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
> >> +}
> >> +
> >> +/**
> >> + * Write descriptors to SVQ packed vring
> >> + *
> >> + * @svq: The shadow virtqueue
> >> + * @out_sg: The iovec to the guest
> >> + * @out_num: Outgoing iovec length
> >> + * @in_sg: The iovec from the guest
> >> + * @in_num: Incoming iovec length
> >> + * @sgs: Cache for hwaddr
> >> + * @head: Saves current free_head
> >> + */
> >> +static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> >> +                                 const struct iovec *out_sg, size_t o=
ut_num,
> >> +                                 const struct iovec *in_sg, size_t in=
_num,
> >> +                                 hwaddr *sgs, unsigned *head)
> >> +{
> >> +    uint16_t id, curr, i, head_flags =3D 0, head_idx;
> >> +    size_t num =3D out_num + in_num;
> >> +    unsigned n;
> >> +
> >> +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc;
> >> +
> >> +    head_idx =3D svq->vring_packed.next_avail_idx;
> >> +    i =3D head_idx;
> >> +    id =3D svq->free_head;
> >> +    curr =3D id;
> >> +    *head =3D id;
> >> +
> >> +    /* Write descriptors to SVQ packed vring */
> >> +    for (n =3D 0; n < num; n++) {
> >> +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_used_f=
lags |
> >> +                                     (n < out_num ? 0 : VRING_DESC_F_=
WRITE) |
> >> +                                     (n + 1 =3D=3D num ? 0 : VRING_DE=
SC_F_NEXT));
> >> +        if (i =3D=3D head_idx) {
> >> +            head_flags =3D flags;
> >> +        } else {
> >> +            descs[i].flags =3D flags;
> >> +        }
> >> +
> >> +        descs[i].addr =3D cpu_to_le64(sgs[n]);
> >> +        descs[i].id =3D id;
> >> +        if (n < out_num) {
> >> +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
> >> +        } else {
> >> +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_len);
> >> +        }
> >> +
> >> +        curr =3D cpu_to_le16(svq->desc_next[curr]);
> >> +
> >> +        if (++i >=3D svq->vring_packed.vring.num) {
> >> +            i =3D 0;
> >> +            svq->vring_packed.avail_used_flags ^=3D
> >> +                1 << VRING_PACKED_DESC_F_AVAIL |
> >> +                1 << VRING_PACKED_DESC_F_USED;
> >> +        }
> >> +    }
> >>
> >> +    if (i <=3D head_idx) {
> >> +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> >> +    }
> >> +
> >> +    svq->vring_packed.next_avail_idx =3D i;
> >> +    svq->shadow_avail_idx =3D i;
> >> +    svq->free_head =3D curr;
> >> +
> >> +    /*
> >> +     * A driver MUST NOT make the first descriptor in the list
> >> +     * available before all subsequent descriptors comprising
> >> +     * the list are made available.
> >> +     */
> >> +    smp_wmb();
> >> +    svq->vring_packed.vring.desc[head_idx].flags =3D head_flags;
> >>   }
> >>
> >> -static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> >> +static void vhost_svq_kick_split(VhostShadowVirtqueue *svq)
> >>   {
> >>       bool needs_kick;
> >>
> >> @@ -209,7 +282,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *s=
vq)
> >>       if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX))=
 {
> >>           uint16_t avail_event =3D le16_to_cpu(
> >>                   *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]=
));
> >> -        needs_kick =3D vring_need_event(avail_event, svq->shadow_avai=
l_idx, svq->shadow_avail_idx - 1);
> >> +        needs_kick =3D vring_need_event(avail_event, svq->shadow_avai=
l_idx,
> >> +                     svq->shadow_avail_idx - 1);
> >>       } else {
> >>           needs_kick =3D
> >>                   !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_=
NO_NOTIFY));
> >> @@ -222,6 +296,30 @@ static void vhost_svq_kick(VhostShadowVirtqueue *=
svq)
> >>       event_notifier_set(&svq->hdev_kick);
> >>   }
> >>
> >> +static void vhost_svq_kick_packed(VhostShadowVirtqueue *svq)
> >> +{
> >> +    bool needs_kick;
> >> +
> >> +    /*
> >> +     * We need to expose the available array entries before checking
> >> +     * notification suppressions.
> >> +     */
> >> +    smp_mb();
> >> +
> >> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) =
{
> >> +        return;
> >
> > It's weird SVQ does not need to kick if _F_EVENT_IDX. This should have
> > code checking the device ring flags etc.
> >
>
> Right, I haven't implemented this yet. Since the current implementation i=
s
> being tested with event_idx=3Doff (points 3 and 4 of the roadmap [1]), I =
thought
> I would leave this for later.
>
> Maybe I can add a comment in the implementation explaining this.
>

Sure that's fine, and probably even better than trying to address
everything in one shot :) Can you add a TODO in each place you
identify so we're sure we don't miss any?

> Thanks,
> Sahil
>
> [1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue
>


