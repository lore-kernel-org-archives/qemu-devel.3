Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A64CCF2D1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 09:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhlZZ-000502-Jb; Mon, 19 Jan 2026 04:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vhlZU-0004yP-Fb
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 04:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vhlZQ-0006n6-Ss
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 04:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768814951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hN5inahT4aNdDH9OxaAmjiXQ3W6WJz8DLLNmLNvsrP0=;
 b=hb8eBiuTUfnAsecsDgbHJLaCKDDColEj7+Kdw4fqk7IDNTPY+fB93Jub3lMnv+jiFwAm44
 VHcxQUdezD+DOEtJvOcPRsrVkZ/cdINKsZUhVWtLt/BTIHZNOuw4ERoYI7Tv7fA7IfpN+a
 M/lkdRweqmhlYWJJT36HerMOyABtp1g=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-OENCGkz7M_yrokUv-bkFEA-1; Mon, 19 Jan 2026 04:29:08 -0500
X-MC-Unique: OENCGkz7M_yrokUv-bkFEA-1
X-Mimecast-MFC-AGG-ID: OENCGkz7M_yrokUv-bkFEA_1768814948
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-792785bc7ffso52177367b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 01:29:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768814948; cv=none;
 d=google.com; s=arc-20240605;
 b=FblrU/erYL2xhTRI0wPvenObBdw67MhRJVf8PoKcO2EExwSuBkv4W7gSNi17KwgMRn
 aM99Qq7bTFRO2av+qFKgmVsXt3sk3ZunaJxliP2Vj7LpXgI+xFWUzyhdlHsO3xC4Gy1S
 n94ZZjHIYTsoJJEQjR7y9iJ/OfEgiIGAEM0gyfJMzGarM4C9J4YGBxz2+TQWP/BbHat4
 Gx9va9B5Sfnhr4Lg5rcxFwgutRf3oTwNkT5itu92PdTQ7gm+FxNNmfFZRvsp0OVJgGJT
 +OTShn9CDTUeA5RLfP2rUp7uCEcMtlsSXUKBhxB64hAU8qYe/c20mGx3UTphLRnP+i7Q
 VZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hN5inahT4aNdDH9OxaAmjiXQ3W6WJz8DLLNmLNvsrP0=;
 fh=59heqjf4IumyPuaFPOqRAkuJg58zwsac+vjAQ1Mg9do=;
 b=Gt321zUQ4g0AT5XptZHLiE5+xXIJ2iasehDaS3v01rZVSwMAfxH1U04W/95YKrTtpn
 vEvX1a+/oAIOXjjsrX54dNbAeA7YElVkDUAXBjRvZN0NKKwX5MgI9ktbJCB2rOZae+Rm
 /pIrWFK4F8nimI9/pXBm28Nfrg7AlNx6m0yXE+2PbnrXO2vASG2cud2UljPoXI8cRYav
 faUekmM0VpUusOciE1TbFEQLHuTJ5Mudmp4kD/OmtC8yphv+m8swaAJbV4YN2w6Gv8/O
 WCmZ2wVeZ1ZSjkxxN5XYHttaM8WDWzi0U4Zuj3eqOe8OSphZ0DF+B41ok7B503Cn3lx/
 QbUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768814948; x=1769419748; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hN5inahT4aNdDH9OxaAmjiXQ3W6WJz8DLLNmLNvsrP0=;
 b=iVUI82ZeYZqE9yb9jzstjeJ8M+dGkyiHzL/rZYq2p6BCJumH2i65rXwPZIa8IbWlNK
 MO23O21UxaWu9GPiUw+GVgtBD6soMA646xLWPIfrAIyxZ6GQOTw2ttTGTf0jgA1Gb1Lo
 qLwwpjL3qE7CYjqhKznrYR1yvvesICVJRRqv2RyUEDKw+3aHm1cRytB34p0JLUKIVQeJ
 Z+KCSn2PJVt/+dFyVF4Dh+cKCzjt3X7izXfOwGrCbezcgpGhZShEdf3eYnzVtFSjQK6W
 24ufifGp+E/T2KF2iT58H/oABnnxMGTIhyZkFwMXskfTF4vJc2OV99m6jOeaoyOyPrK6
 3PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768814948; x=1769419748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hN5inahT4aNdDH9OxaAmjiXQ3W6WJz8DLLNmLNvsrP0=;
 b=ORzekNozojMYQlo42fBzWA3x1NoZxW3YEU9U/2RjoeWnqMg+RV7+69uLRG6VIyhRCX
 bE/zGzIqMNKnYAy9Q0zbH9VRei0s4Q/Kdl98DB5affGgYvDS0AbsccyqKtIyzmhJaaVV
 azKQr5+4BWITc0pUB0Qb5J2G/SGskgmpUiruFJajuyA08OtHqz2fQXkbbReBb54xNih6
 O4BI0YFidmGLmZLh0GnTsCBh7qZCspym7TD9gp2pyfyLlpvQTEDgLroB33TomhHAiE0d
 n+9ledQatchKS41rAra5pJo9dUgDgKDzDI9X/JWx31TRhKtMFTXoxgBCF0jYd5L6ZGPc
 o/uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbiD1bTG7RWM6mHnfwMG2+kX5K53sqI7Mn3p2pBGPPrM6DkPzeHCeOYIbzmNLhynVKNk2N9y5PUMKt@nongnu.org
X-Gm-Message-State: AOJu0YxlyJPZZ2QanBnLS6TwbvVllvnJapa/8Vtw3elKj6FcJbB7TeZv
 eosLLq5JGXa/CfInbCHtd/xMCpSI991N8la9qS6fpBllPIA7BKTS7hyef6lUvH8YcwerGwXSgFI
 2NWVoY78tBuWu06WYTExMIyUVM9vxb3uuxLpvLhVPLanyEdW4+8yfEUEc8/j3tVIr53KsqQifVz
 o4U293MpSyzQaiIeXPPJdCRrTt/EC3IAs=
X-Gm-Gg: AZuq6aK5p5LcC71wcYC3IpCkiCJW7OvN97W/MShPDj3rAaYPeK79VDdPyGBYj7bhk5o
 LwwWggsIR/jurb+uzg1QUVte0xxQ5xTZQ6ifG9scturhGoSZ5mCp4d2/46vo8TRd17OfdVMmmQa
 sVGszJDYXVRWp1xFT8BdjHODCRSZokQ9xUVkOg9Wtnz2BWj8RDHaA33aMv5IO2UZ1zgA==
X-Received: by 2002:a05:690c:f96:b0:793:af69:83b2 with SMTP id
 00721157ae682-793c522d72dmr92373067b3.6.1768814948080; 
 Mon, 19 Jan 2026 01:29:08 -0800 (PST)
X-Received: by 2002:a05:690c:f96:b0:793:af69:83b2 with SMTP id
 00721157ae682-793c522d72dmr92372927b3.6.1768814947635; Mon, 19 Jan 2026
 01:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20251231110110.18201-1-wafer@jaguarmicro.com>
 <CAJaqyWerEFbYXuRZaRhit0vS5WZCgj5vfxwXCTxcvUuYEvOR+w@mail.gmail.com>
 <PUZPR06MB4713F96E5FB2078DD7F8B80FA28BA@PUZPR06MB4713.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB4713F96E5FB2078DD7F8B80FA28BA@PUZPR06MB4713.apcprd06.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 19 Jan 2026 10:28:31 +0100
X-Gm-Features: AZwV_QiVhvLPrRDdJqgPvlhihnU2dsFFvLp0suBcUwYyU_xWf7Xh9QAo1xsWoGM
Message-ID: <CAJaqyWf0GC6j6R=qVSDoqdNRbkJuo1jWpDZPanbcpb+n2QR8hw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vhost: SVQ add the indirect descriptors to
 available ring
To: Wafer <wafer@jaguarmicro.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leiyang@redhat.com" <leiyang@redhat.com>, 
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 Angus Chen <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Jan 18, 2026 at 9:31=E2=80=AFAM Wafer <wafer@jaguarmicro.com> wrote=
:
>
>
>
> > -----Original Message-----
> > From: Eugenio Perez Martin <eperezma@redhat.com>
> > Sent: 2026=E5=B9=B41=E6=9C=8815=E6=97=A5 18:56
> > To: Wafer <wafer@jaguarmicro.com>
> > Cc: mst@redhat.com; jasowang@redhat.com; qemu-devel@nongnu.org;
> > leiyang@redhat.com; sgarzare@redhat.com; Angus Chen
> > <angus.chen@jaguarmicro.com>
> > Subject: Re: [PATCH v4 4/4] vhost: SVQ add the indirect descriptors to
> > available ring
> >
> > External Mail: This email originated from OUTSIDE of the organization!
> > Do not click links, open attachments or provide ANY information unless =
you
> > recognize the sender and know the content is safe.
> >
> >
> > On Wed, Dec 31, 2025 at 12:01=E2=80=AFPM Wafer Xie <wafer@jaguarmicro.c=
om>
> > wrote:
> > >
> > > From: wafer Xie <wafer@jaguarmicro.com>
> > >
> > > Retrieve the target buffer from the indirect buffers by index, add th=
e
> > > elements sent by the guest into the buffer=E2=80=99s indirect descrip=
tors, and
> > > update freed_head and freed_number. If freed_number is zero, or if th=
e
> > > current buffer=E2=80=99s freed_number is less than the number of elem=
ents,
> > > update the buffer state to SVQ_INDIRECT_BUF_FREEING.
> > >
> > > If the current indirect buffer does not have enough freed descriptors
> > > to accommodate the SVQ descriptors, descriptors can be borrowed from
> > > the next indirect buffer.
> > >
> > > Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
> > > ---
> > >  hw/virtio/vhost-shadow-virtqueue.c | 341
> > > +++++++++++++++++++++++++----
> > >  1 file changed, 299 insertions(+), 42 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c
> > > b/hw/virtio/vhost-shadow-virtqueue.c
> > > index 4f564f514c..02a238548c 100644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > @@ -139,86 +139,340 @@ static bool vhost_svq_translate_addr(const
> > > VhostShadowVirtqueue *svq,  }
> > >
> > >  /**
> > > - * Write descriptors to SVQ vring
> > > + * Add a single descriptor to a descriptor table
> > > + *
> > > + * @desc: The descriptor to write to
> > > + * @addr: IOVA address
> > > + * @len: Length of the buffer
> > > + * @flags: Descriptor flags (VRING_DESC_F_WRITE, VRING_DESC_F_NEXT)
> > > + * @next: Next descriptor index (only used if VRING_DESC_F_NEXT is
> > > +set)  */ static void vhost_svq_vring_add_desc(vring_desc_t *desc,
> > > +                                       hwaddr addr,
> > > +                                       uint32_t len,
> > > +                                       uint16_t flags,
> > > +                                       uint16_t next) {
> > > +    desc->addr =3D cpu_to_le64(addr);
> > > +    desc->len =3D cpu_to_le32(len);
> > > +    desc->flags =3D flags;
> > > +    if (flags & cpu_to_le16(VRING_DESC_F_NEXT)) {
> > > +        desc->next =3D cpu_to_le16(next);
> > > +    }
> > > +}
> > > +
> > > +/**
> > > + * Write descriptors to a descriptor table (chain or indirect)
> > >   *
> > >   * @svq: The shadow virtqueue
> > >   * @sg: Cache for hwaddr
> > >   * @iovec: The iovec from the guest
> > >   * @num: iovec length
> > >   * @addr: Descriptors' GPAs, if backed by guest memory
> > > + * @descs: The descriptor table to write to
> > > + * @start_idx: Starting index in the descriptor table
> > > + * @offset_idx: Offset for next field calculation (used for indirect=
)
> > >   * @more_descs: True if more descriptors come in the chain
> > >   * @write: True if they are writeable descriptors
> > > + * @indirect: True if writing to indirect descriptor table
> > >   *
> > > - * Return true if success, false otherwise and print error.
> > > + * Return the next free descriptor index if success, -1 on error.
> > >   */
> > > -static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq,
> > hwaddr *sg,
> > > -                                        const struct iovec *iovec, s=
ize_t num,
> > > -                                        const hwaddr *addr, bool mor=
e_descs,
> > > -                                        bool write)
> > > +static int vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq,
> > > +                                       hwaddr *sg,
> > > +                                       const struct iovec *iovec,
> > > +                                       size_t num,
> > > +                                       const hwaddr *addr,
> > > +                                       vring_desc_t *descs,
> > > +                                       uint16_t start_idx,
> > > +                                       size_t offset_idx,
> > > +                                       bool more_descs,
> > > +                                       bool write,
> > > +                                       bool indirect)
> > >  {
> > > -    uint16_t i =3D svq->free_head, last =3D svq->free_head;
> > > -    unsigned n;
> > > +    uint16_t i =3D start_idx, last =3D start_idx;
> > >      uint16_t flags =3D write ? cpu_to_le16(VRING_DESC_F_WRITE) : 0;
> > > -    vring_desc_t *descs =3D svq->vring.desc;
> > >      bool ok;
> > >
> > >      if (num =3D=3D 0) {
> > > -        return true;
> > > +        return start_idx;
> > >      }
> > >
> > >      ok =3D vhost_svq_translate_addr(svq, sg, iovec, num, addr);
> > >      if (unlikely(!ok)) {
> > > -        return false;
> > > +        return -1;
> > >      }
> > >
> > > -    for (n =3D 0; n < num; n++) {
> > > -        if (more_descs || (n + 1 < num)) {
> > > -            descs[i].flags =3D flags | cpu_to_le16(VRING_DESC_F_NEXT=
);
> > > -            descs[i].next =3D cpu_to_le16(svq->desc_next[i]);
> > > +    for (size_t n =3D 0; n < num; n++) {
> > > +        uint16_t desc_flags =3D flags;
> > > +        uint16_t next;
> > > +
> > > +        if (indirect) {
> > > +            next =3D offset_idx + n + 1;
> > >          } else {
> > > -            descs[i].flags =3D flags;
> > > +            next =3D svq->desc_next[i];
> > >          }
> > > -        descs[i].addr =3D cpu_to_le64(sg[n]);
> > > -        descs[i].len =3D cpu_to_le32(iovec[n].iov_len);
> > >
> > > +        if (more_descs || (n + 1 < num)) {
> > > +            desc_flags |=3D cpu_to_le16(VRING_DESC_F_NEXT);
> > > +        }
> > > +        vhost_svq_vring_add_desc(&descs[i], sg[n],
> > > +                                   iovec[n].iov_len, desc_flags,
> > > + next);
> > >          last =3D i;
> > > -        i =3D svq->desc_next[i];
> > > +        if (indirect) {
> > > +            i++;
> > > +        } else {
> > > +            i =3D next;
> > > +        }
> > > +    }
> > > +
> > > +    /* Return the next free index */
> > > +    if (!indirect) {
> > > +        i =3D svq->desc_next[last];
> > > +    }
> > > +    return i;
> > > +}
> > > +
> > > +/**
> > > + * Add descriptors to SVQ vring using indirect descriptors
> > > +(dual-buffer)
> > > + *
> > > + * @svq: The shadow virtqueue
> > > + * @out_sg: The out iovec from the guest
> > > + * @out_num: The out iovec length
> > > + * @out_addr: The out descriptors' GPAs
> > > + * @in_sg: The in iovec from the guest
> > > + * @in_num: The in iovec length
> > > + * @in_addr: The in descriptors' GPAs
> > > + * @sgs: Cache for hwaddr
> > > + * @buf_idx: Index of the indirect buffer to use
> > > + *
> > > + * Return true if success, false otherwise and print error.
> > > + */
> > > +static bool vhost_svq_add_split_indirect(VhostShadowVirtqueue *svq,
> > > +                                         const struct iovec *out_sg,
> > > +                                         size_t out_num,
> > > +                                         const hwaddr *out_addr,
> > > +                                         const struct iovec *in_sg,
> > > +                                         size_t in_num,
> > > +                                         const hwaddr *in_addr,
> > > +                                         hwaddr *sgs, int buf_idx) {
> > > +    SVQIndirectDescBuf *buf =3D &svq->indirect.bufs[buf_idx];
> > > +    uint16_t start_idx =3D buf->start_idx + buf->freed_head;
> > > +    size_t total_descs =3D out_num + in_num;
> > > +    hwaddr indirect_iova;
> > > +    int ret;
> > > +
> > > +    /* Populate indirect descriptor table for out descriptors */
> > > +    ret =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num,
> > out_addr,
> > > +                                      svq->indirect.desc, start_idx,
> > > +                                      0, in_num > 0, false, true);
> > > +    if (unlikely(ret < 0)) {
> > > +        return false;
> > > +    }
> > > +
> > > +    /* Populate indirect descriptor table for in descriptors */
> > > +    ret =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_=
addr,
> > > +                                      svq->indirect.desc, start_idx =
+ out_num,
> > > +                                      out_num, false, true, true);
> > > +    if (unlikely(ret < 0)) {
> > > +        return false;
> > >      }
> > >
> > > -    svq->free_head =3D svq->desc_next[last];
> > > +    /* Calculate IOVA for this indirect descriptor range */
> > > +    indirect_iova =3D svq->indirect.iova + start_idx *
> > > + sizeof(vring_desc_t);
> > > +
> > > +    /* Add a single descriptor pointing to the indirect table */
> > > +    svq->vring.desc[svq->free_head].addr =3D cpu_to_le64(indirect_io=
va);
> > > +    svq->vring.desc[svq->free_head].len =3D
> > > +            cpu_to_le32(total_descs * sizeof(vring_desc_t));
> > > +    svq->vring.desc[svq->free_head].flags =3D
> > > + cpu_to_le16(VRING_DESC_F_INDIRECT);
> > > +
> > > +    /* Store indirect descriptor info in desc_state */
> > > +    svq->desc_state[svq->free_head].indirect_buf_idx =3D buf_idx;
> > > +
> > > +    /* Update buffer state */
> > > +    buf->freed_head +=3D total_descs;
> > > +    buf->freed_descs -=3D total_descs;
> > > +
> > > +    /* Move free_head forward */
> > > +    svq->free_head =3D svq->desc_next[svq->free_head];
> > > +
> > >      return true;
> > >  }
> > >
> > > -static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
> > > +/**
> > > + * Try to borrow descriptors from the next buffer segment
> > > + *
> > > + * @svq: The shadow virtqueue
> > > + * @buf_idx: Current buffer index
> > > + * @needed: Number of additional descriptors needed
> > > + *
> > > + * Returns true if successfully borrowed, false otherwise.
> > > + * Note: Last buffer cannot borrow from first buffer (IOVA not
> > contiguous).
> > > + */
> > > +static bool vhost_svq_borrow_from_next(VhostShadowVirtqueue *svq,
> > > +                                       int buf_idx, size_t needed) {
> > > +    SVQIndirectDescBuf *cur_buf =3D &svq->indirect.bufs[buf_idx];
> > > +    SVQIndirectDescBuf *next_buf;
> > > +    int next_idx;
> > > +
> > > +    /* Last buffer cannot borrow from first - IOVA would not be cont=
iguous
> > */
> > > +    if (buf_idx =3D=3D SVQ_NUM_INDIRECT_BUFS - 1) {
> > > +        return false;
> > > +    }
> > > +
> > > +    next_idx =3D buf_idx + 1;
> > > +    next_buf =3D &svq->indirect.bufs[next_idx];
> > > +
> > > +    /* Can borrow if next buffer is in FREED state and has freed_hea=
d at 0
> > */
> > > +    if (next_buf->state !=3D SVQ_INDIRECT_BUF_FREED ||
> > > +        next_buf->freed_head !=3D 0) {
> > > +        return false;
> > > +    }
> > > +
> > > +    /* Check if next buffer has enough free descriptors to lend */
> > > +    if (next_buf->freed_descs < needed) {
> > > +        return false;
> > > +    }
> > > +    /* Borrow descriptors: expand current buffer, shrink next buffer=
 */
> > > +    cur_buf->num_descs +=3D needed;
> > > +    cur_buf->borrowed_descs +=3D needed;
> > > +    cur_buf->freed_descs +=3D needed;
> > > +
> > > +    next_buf->start_idx +=3D needed;
> > > +    next_buf->num_descs -=3D needed;
> > > +    next_buf->freed_descs -=3D needed;
> > > +
> >
> > I don't think I understand the algorithm for indirect tables allocation=
 and
> > freeing. Let me know what I'm missing.
> >
> > We can have at max SVQ_NUM_INDIRECT_BUFS (4) indirect tables, as the
> > information we use to locate the indirect table itself is
> > svq->desc_state[used_elem.id].indirect_buf_idx. This is used to access
> > the svq->indirect.bufs, whose size is SVQ_NUM_INDIRECT_BUFS.
> >
> > These tables could grow until the maximum descriptors allowed, which is=
 the
> > size of the vring per VirtIO standard. The function virtqueue_pop alrea=
dy
> > checks this. But this code does not allow more than 4 indirect tables a=
nyway,
> > even if they were smaller than vq size and there is contiguous space in=
 the
> > mapped buffer for the indirect tables.
> >
>
>      Thank you for the detailed review! Let me clarify the design as I th=
ink
>      there may be some misunderstanding.
>
>      BUFFER ALLOCATION:
>      ------------------
>     # define CONFIG_MAX_SKB_FRAGS 17
>       In the Linux kernel, virtio-net limits the maximum scatterlist size=
 to 17 entries. With a vq_size of 256 and indirect descriptors enabled,
>       the virtio-net driver can therefore submit up to 256 * 17 scatter-g=
ather entries.
>
>       Based on this, the implementation allocates an indirect descriptor =
capacity about half of the theoretical maximum, specifically vq_size * 2 * =
4.
>
>      The total allocation is:
>
>        SVQ_NUM_INDIRECT_BUFS(4) * vq_size * 2 descriptors
>
>      Each buf[i] has capacity of 2*vq_size, not vq_size. So the full buff=
er
>      is divided into 4 segments, each capable of holding 2x the vring siz=
e.
>      There is no wasted space.
>
>      +-------------------------------------------------------------------=
--+
>      |         Total: 4 bufs * 2 * vq_size =3D 8 * vq_size descriptors   =
    |
>      +----------------+----------------+----------------+----------------=
--+
>      |     buf[0]     |     buf[1]     |     buf[2]     |      buf[3]    =
  |
>      |  2*vq_size cap |  2*vq_size cap |  2*vq_size cap |   2*vq_size cap=
  |
>      +----------------+----------------+----------------+----------------=
--+
>
>      WHY 2*vq_size PER BUFFER:
>      -------------------------
>      The reason each buffer has 2*vq_size capacity (instead of 1*vq_size)=
 is
>      to REDUCE the frequency of borrowing scenarios and improve performan=
ce.
>
>      With 2*vq_size capacity per buffer:
>      - Most requests can be satisfied within a single buffer
>      - Borrowing from next buffer only happens in rare edge cases
>      - Better cache locality and fewer cross-buffer operations
>
>      If we used 1*vq_size per buffer, borrowing would occur much more
>      frequently, adding overhead to the common path.
>
>      WHY BORROWING IS STILL NEEDED:
>      ------------------------------
>      Even with 2*vq_size capacity, the borrowing mechanism addresses edge
>      cases that you mentioned in your previous review about to reuse the =
free holes.
>
>      https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg02779.html
>
>      Consider this situation:
>
>        buf[0] state after heavy usage:
>        +------------------------------------------------------------+
>        | freed_descs =3D 4  (only 4 free at the tail)                 |
>        | freeing_descs =3D 100  (waiting for device to return)        |
>        | freed_head =3D 508                                           |
>        |                                                            |
>        | [0.....507: IN_USE/FREEING] [508,509,510,511: FREE]        |
>        +------------------------------------------------------------+
>
>      Now driver sends a request needing 8 descriptors:
>
>      WITHOUT borrowing:
>        - buf[0] has only 4 freed_descs < 8 needed
>        - buf[0] transitions to FREEING state
>        - Those 4 free descriptors are WASTED
>        - Must use buf[1] from scratch
>
>      WITH borrowing:
>        - buf[0] has 4 freed_descs, needs 4 more
>        - Borrow 4 from buf[1]'s head (IOVA is contiguous!)
>        - Now have 8 contiguous descriptors: [508-511 from buf[0]] + [0-3 =
from buf[1]]
>
>        buf[0]:                              buf[1]:
>        +--------------------------------+   +----------------------+
>        | [508,509,510,511,|0,1,2,3]     |   | start_idx: 4         |
>        |  <-- original --> <--borrowed->|   | num_descs: 2*vq-4    |
>        |      8 contiguous descs        |   |                      |
>        +--------------------------------+   +----------------------+
>               Contiguous IOVA!
>

I understand that algorithm, but I don't get what it buys. As you're
only allowing 4 indirect tables in flight at max, you are just moving
the descriptors you tag as "wasted" from the tail of the queue to the
inter-buf space. And this edge case has comparatively way more
complexity than the regular code path.

Let's try from a different angle, can you describe a buf[0,1,2,3]
state where forwarding an indirect table is not possible without
splitting it between many buffers?

>      BORROWING RULES:
>      ----------------
>      To keep the design simple and predictable:
>
>      1. Each buf[i] can only borrow ONCE from buf[i+1]
>      2. After borrowing, svq->indirect.current_buf is set to buf[i+1]
>      3. Subsequent requests will use buf[i+1] as the starting point
>
>      This ensures:
>      - No complex multi-level borrowing chains
>      - Predictable buffer rotation
>      - Simple bookkeeping (only track borrowed_descs per buffer)
>
>      Example flow:
>                  +-------------------------------------------------------=
------+
>        | current_buf =3D 0                                             |
>        | buf[0] needs to borrow from buf[1]                          |
>        |   -> borrow succeeds                                        |
>        |   -> current_buf =3D 1  (next requests start from buf[1])     |
>        |                                                             |
>        | Later, buf[1] needs to borrow from buf[2]                   |
>        |   -> borrow succeeds                                        |
>        |   -> current_buf =3D 2  (next requests start from buf[2])     |
>        +-------------------------------------------------------------+
>
>      DESIGN SUMMARY:
>      ---------------
>        +-------------------------------------------------------------+
>        |  2*vq_size per buffer  ->  Reduces borrowing frequency      |
>        |                            (performance optimization)       |
>        +-------------------------------------------------------------+
>        |  Borrowing mechanism   ->  Handles edge cases when buffer   |
>        |                            is almost full but not empty     |
>        |                            (avoids descriptor waste)        |
>        +-------------------------------------------------------------+
>        |  One-time borrow rule  ->  Simple state management          |
>        |                            (current_buf moves to next)      |
>        +-------------------------------------------------------------+
>
>      WHY NOT FIXED CHUNKS:
>      ---------------------
>      Fixed vq_size chunks would waste descriptors in the scenario above.
>      The 2*vq_size capacity + borrowing allows:
>
>      1. Single request can use up to 2*vq_size descs (exceeding vq_size)
>      2. Partially-used buffers can still contribute to new requests
>      3. Maximum utilization of the pre-allocated IOVA space
>
>      REGARDING BUDDY ALLOCATOR:
>      --------------------------
>      A buddy allocator would be more flexible, but adds complexity for
>      managing splits/merges. The current design with 4 large segments +
>      borrowing provides a good balance:
>      - Simple allocation (round-robin through 4 bufs)
>      - Efficient utilization (borrowing avoids waste)
>      - Predictable performance (no fragmentation)
>
>      Does this clarify the design? Please let me know if you have
>      further questions.
>
>      Thanks,
>
> > The code allocates a buffer big enough for 8 indirect tables in
> > vhost_vdpa_svq_init_indirect, as they can only be svq->vring.num big, s=
o
> > half of it will never be allocated under any circumstance.
> >
> > Now let's say the driver allocates 4 indirect tables (IT). The shared b=
uffer now
> > looks like:
> >
> > [
> >   [1st IT],
> >   [2nd IT],
> >   [3rd IT],
> >   [4th IT],
> >   [free size for at least 4 indirect tables more] ]
> >
> > Now the device starts freeing indirect descriptors and the dance of
> > reallocating could start. The condition for borrowing and returning
> > descriptors may be met at 2*vq_size boundaries. But, by that time, it i=
s
> > guaranteed that you can allocate an indirect table of vq_num descriptor=
s at
> > some position N*vq_num, with N between 0 and 7.
> >
> > Why complicate the code with this dance of resizing
> > svq->indirect.bufs[j] then? Why not divide all the mapped buffer in 8
> > chunks of vq size and never move them?
> >
> > I would prefer to remove the 4 (or any number) indirect tables limitati=
on and
> > use something like the IOVA allocator or the buddy allocator to find
> > contiguous space though.
> >
> > Thanks!
> >
> > > +    return true;
> > > +}
> > > +
> > > +/**
> > > + * Try to get a freed indirect buffer for use
> > > + *
> > > + * @svq: The shadow virtqueue
> > > + * @total_descs: Number of descriptors needed
> > > + *
> > > + * Returns buffer index (0 to SVQ_NUM_INDIRECT_BUFS-1)
> > > + * if available, -1 if none available.
> > > + */
> > > +static int vhost_svq_get_indirect_buf(VhostShadowVirtqueue *svq,
> > > +                                      size_t total_descs) {
> > > +    int cur =3D svq->indirect.current_buf;
> > > +    SVQIndirectDescBuf *buf;
> > > +
> > > +    if (!svq->indirect.enabled) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    if ( cur < 0) {
> > > +        cur =3D 0;
> > > +    }
> > > +    /* Start from current or first buffer, try all buffers in order =
*/
> > > +    for (int i =3D 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
> > > +        int idx =3D (cur + i) % SVQ_NUM_INDIRECT_BUFS;
> > > +        buf =3D &svq->indirect.bufs[idx];
> > > +
> > > +        if (buf->state !=3D SVQ_INDIRECT_BUF_FREED) {
> > > +            continue;
> > > +        }
> > > +
> > > +        /* Check if we have enough free descriptors */
> > > +        if (buf->freed_descs >=3D total_descs) {
> > > +            svq->indirect.current_buf =3D idx;
> > > +            return idx;
> > > +        }
> > > +
> > > +        /* Try to borrow from next buffer */
> > > +        size_t needed =3D total_descs - buf->freed_descs;
> > > +        if ((buf->freed_descs > 0) &&
> > > +            vhost_svq_borrow_from_next(svq, idx, needed)) {
> > > +            svq->indirect.current_buf =3D idx + 1;
> > > +            return idx;
> > > +        }
> > > +
> > > +        /* Not enough space, mark as FREEING if it's the current buf=
fer */
> > > +        buf->state =3D SVQ_INDIRECT_BUF_FREEING;
> > > +    }
> > > +
> > > +    /* All buffers unavailable, fallback to chain mode */
> > > +    return -1;
> > > +}
> > > +
> > > +static int vhost_svq_add_split(VhostShadowVirtqueue *svq,
> > >                                  const struct iovec *out_sg, size_t o=
ut_num,
> > >                                  const hwaddr *out_addr,
> > >                                  const struct iovec *in_sg, size_t in=
_num,
> > > -                                const hwaddr *in_addr, unsigned *hea=
d)
> > > +                                const hwaddr *in_addr, unsigned *hea=
d,
> > > +                                bool *used_indirect)
> > >  {
> > >      unsigned avail_idx;
> > >      vring_avail_t *avail =3D svq->vring.avail;
> > >      bool ok;
> > > +    int ret;
> > >      g_autofree hwaddr *sgs =3D g_new(hwaddr, MAX(out_num, in_num));
> > > +    size_t total_descs =3D out_num + in_num;
> > > +    int indirect_buf_idx =3D -1;
> > >
> > >      *head =3D svq->free_head;
> > > +    *used_indirect =3D false;
> > >
> > >      /* We need some descriptors here */
> > >      if (unlikely(!out_num && !in_num)) {
> > >          qemu_log_mask(LOG_GUEST_ERROR,
> > >                        "Guest provided element with no descriptors");
> > > -        return false;
> > > +        return -EINVAL;
> > >      }
> > >
> > > -    ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, ou=
t_addr,
> > > -                                     in_num > 0, false);
> > > -    if (unlikely(!ok)) {
> > > -        return false;
> > > +    /* Try to use indirect descriptors if feature is negotiated and =
total > 1 */
> > > +    if (virtio_vdev_has_feature(svq->vdev,
> > VIRTIO_RING_F_INDIRECT_DESC) &&
> > > +        total_descs > 1) {
> > > +        indirect_buf_idx =3D vhost_svq_get_indirect_buf(svq,
> > > + total_descs);
> > >      }
> > >
> > > -    ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_a=
ddr,
> > false,
> > > -                                     true);
> > > -    if (unlikely(!ok)) {
> > > -        return false;
> > > +    if (indirect_buf_idx >=3D 0) {
> > > +        /* Indirect mode: only need 1 main descriptor slot */
> > > +        if (unlikely(vhost_svq_available_slots(svq) < 1)) {
> > > +            return -ENOSPC;
> > > +        }
> > > +
> > > +        /* Use indirect mode */
> > > +        ok =3D vhost_svq_add_split_indirect(svq, out_sg, out_num, ou=
t_addr,
> > > +                                          in_sg, in_num, in_addr,
> > > +                                          sgs, indirect_buf_idx);
> > > +        if (unlikely(!ok)) {
> > > +            error_report("indirect error, out_num %zu in_num %zu "
> > > +                         "avail index %u head %u",
> > > +                         out_num, in_num, svq->shadow_avail_idx, *he=
ad);
> > > +            return -EINVAL;
> > > +        }
> > > +        *used_indirect =3D true;
> > > +    } else {
> > > +        /* Chain mode: need total_descs descriptor slots */
> > > +        if (unlikely(vhost_svq_available_slots(svq) < total_descs)) =
{
> > > +            return -ENOSPC;
> > > +        }
> > > +
> > > +        /* Use direct (chain) mode */
> > > +        svq->desc_state[svq->free_head].indirect_buf_idx =3D -1;
> > > +
> > > +        ret =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_nu=
m,
> > out_addr,
> > > +                                          svq->vring.desc, svq->free=
_head, 0,
> > > +                                          in_num > 0, false, false);
> > > +        if (unlikely(ret < 0)) {
> > > +            return -EINVAL;
> > > +        }
> > > +        svq->free_head =3D ret;
> > > +
> > > +        ret =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num,=
 in_addr,
> > > +                                          svq->vring.desc, svq->free=
_head, 0,
> > > +                                          false, true, false);
> > > +        if (unlikely(ret < 0)) {
> > > +            return -EINVAL;
> > > +        }
> > > +        svq->free_head =3D ret;
> > >      }
> > >
> > >      /*
> > > @@ -233,7 +487,7 @@ static bool
> > vhost_svq_add_split(VhostShadowVirtqueue *svq,
> > >      smp_wmb();
> > >      avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
> > >
> > > -    return true;
> > > +    return 0;
> > >  }
> > >
> > >  static void vhost_svq_kick(VhostShadowVirtqueue *svq) @@ -249,7
> > > +503,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> > >      if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX))=
 {
> > >          uint16_t avail_event =3D le16_to_cpu(
> > >                  *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]=
));
> > > -        needs_kick =3D vring_need_event(avail_event, svq->shadow_ava=
il_idx,
> > svq->shadow_avail_idx - 1);
> > > +        needs_kick =3D vring_need_event(avail_event, svq->shadow_ava=
il_idx,
> > > +                                      svq->shadow_avail_idx - 1);
> > >      } else {
> > >          needs_kick =3D
> > >                  !(svq->vring.used->flags &
> > > cpu_to_le16(VRING_USED_F_NO_NOTIFY));
> > > @@ -274,19 +529,21 @@ int vhost_svq_add(VhostShadowVirtqueue *svq,
> > > const struct iovec *out_sg,  {
> > >      unsigned qemu_head;
> > >      unsigned ndescs =3D in_num + out_num;
> > > -    bool ok;
> > > +    int r;
> > > +    bool used_indirect =3D false;
> > >
> > > -    if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
> > > -        return -ENOSPC;
> > > +    r =3D vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg,
> > in_num,
> > > +                             in_addr, &qemu_head, &used_indirect);
> > > +    if (unlikely(r !=3D 0)) {
> > > +        return r;
> > >      }
> > >
> > > -    ok =3D vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg=
,
> > in_num,
> > > -                             in_addr, &qemu_head);
> > > -    if (unlikely(!ok)) {
> > > -        return -EINVAL;
> > > +    /* If using indirect, only 1 main descriptor is used; otherwise =
ndescs */
> > > +    if (used_indirect) {
> > > +        svq->num_free -=3D 1;
> > > +    } else {
> > > +        svq->num_free -=3D ndescs;
> > >      }
> > > -
> > > -    svq->num_free -=3D ndescs;
> > >      svq->desc_state[qemu_head].elem =3D elem;
> > >      svq->desc_state[qemu_head].ndescs =3D ndescs;
> > >      vhost_svq_kick(svq);
> > > --
> > > 2.34.1
> > >
>
>


