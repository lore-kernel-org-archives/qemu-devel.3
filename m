Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7342EEF06EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 03:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpHWV-0003xP-Vg; Sun, 08 Feb 2026 22:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vpHWU-0003xE-7G
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 22:01:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vpHWS-00066y-11
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 22:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770606069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXpCNgbgDEEpdr0YTHWBY5RDmAcO2WXjtzUuC6jlXvo=;
 b=FPScDhbD20//d2qFfV1CSgQeE3LGXWyAYZE8YUsCLg8+g5tfyxUvTp8Dm9+0Dc8KX/v0up
 ho6QnAt3GlMtwQbH2nEztmOFDJrb53BVIL7XGQ3LEs+w66UO+iiIg/ymILQUaY/hAK6Ln9
 L0UZ8Z8ftcTbkpg0WSi0wstCyis7U44=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-SDHZuyh_M2m0AMww2U4LVg-1; Sun, 08 Feb 2026 22:01:08 -0500
X-MC-Unique: SDHZuyh_M2m0AMww2U4LVg-1
X-Mimecast-MFC-AGG-ID: SDHZuyh_M2m0AMww2U4LVg_1770606067
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-948e77990c7so3667724241.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 19:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770606067; cv=none;
 d=google.com; s=arc-20240605;
 b=SD1f9gU/9VzY887CDqRORJhZ2sV65CA940nMf4hrjzHNEuowuUt4IXg1gEjBWhmFks
 FaManMG7ys4VcbMpla5thVbd1hKDuAJbM9gwuDGoG3cUmIabFN5TivErxnfJM8CFa6y/
 OELtyoBuQjbPKXfdDJx/Nqg/vDmsTclZrwEAcUSeWQMiyiIBYw0c50qZJ8yBDTSmgsGr
 ISKKplDt7zfGl5t6HDCSzxm+npw+i/kesA19l3/Saaj+cGRmm/0IVzJs4V58h180D9dk
 cIX/kerK7Qt69Y9fdbW2El1fFrO+zT5gBZwXTH0Rxpn7L/TRpnG8pUdH2C45DBe3c/UN
 vC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TXpCNgbgDEEpdr0YTHWBY5RDmAcO2WXjtzUuC6jlXvo=;
 fh=NnXwz0FzEaEfLG3DW696FTK+NluoXvLiS2D28ZYeJms=;
 b=GgSeHF3J/WMzgYsJoYa+C1v0Ik1ar3ktdHCxB8ZNVN08S/qLbaVErq5gr+T1yIA+MJ
 I9N2W/acQzLm5uRPXAqqfRCProCY2yyyKO/u85JvwXhqWoRwIOV7W6M6SRFCDXhA7y/v
 MZbF2Li7B8wiNA6K4mnkQSYTcTaFbVIa2lcjyKkbBBP7NeZ6t6DL4bDgn+QJN3ger89h
 4rOZN3pm+C62gxIPUMWULBT52Z6rS70uZsJsMqn2gdkRhOqtxUTXSdfJML6Uw8KFrppS
 YNlZ/lDwA63ZggTgytK1IePaV4Ixha6oeU4YEL9a7tTRkAKx8uINquTL5r0HKzbzont7
 qGig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770606067; x=1771210867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXpCNgbgDEEpdr0YTHWBY5RDmAcO2WXjtzUuC6jlXvo=;
 b=S8VbSnY3p0cevy0xxGKrsDpr9BiGZV6sCZ1ngnZmKRsLj7x4wwj32XrvdSfPov7wUx
 h9GL2TKimaP8+aVa3XSYBo3j6+AxhorG4DBlCJByxhPlJzDx3uV2nAT6Bj2vpoKslCPt
 9xgvsLv/cJqGcOCi9FXP4hvTQQhfUC6/mdqzWhKzy/b/IyAaTXTVMq9fT1mdofxpzl85
 Uf6rCVJBTktQsijHkvh5Mku1JEe71sQxKB6xf+UvjLj1FrSFc92t5sv5qigVprqZNSOj
 6zWfvh9qJbOTYOrTnvSU9SUj4lfaBty9f+wqDJsw/bmRcaZaMKYpFffy4h3h8TpHAfIe
 lBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770606067; x=1771210867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TXpCNgbgDEEpdr0YTHWBY5RDmAcO2WXjtzUuC6jlXvo=;
 b=w22dFLkKTPr7xP5BE4qqzWuTnJ7KPDFPdW3f4II8A5KgjkXCTvswiLQDVrO3h61Dpn
 LZj5mxghykQNHMX2eUJ7EMt+DK7AQKqKdOVk+K3QewM5LIy3oHAaZb+EdptEqMVhHn6Q
 tcmihl/+E+QH0fW28WVxM54cM0wivLExghMPDMBTCYMNhKcSHWcbSANYeNNd5NjzBO/b
 inTGHwUeSGiF/2LoHoCzB7Ul77y7IGVDQVyqYXShyTCwQbTs1qkiJew7nv3ZT33qwqOt
 OlXqGyoCsX3dcJ/AdI5DKpmoW1gn/PwE4PI7zCe6yMTM81neYfD8hBUJsxli+1W1utDq
 mlZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsUS5/RyUrBXAEzKgOollpfu3mT+YT/qRuAMqTHx2XuOB8OOc9TETVnf4pTbVoIaG5Nw1SzMIKjhWk@nongnu.org
X-Gm-Message-State: AOJu0YzVsX1WZfy/YsMcKahVEvc4Ejc789l3AoREoTxcb+Y+d7sJjTSC
 ASuSxr7XKar9oEtMSKwLIRPUoRRExeYOPNeUDvLvTHIEqhErJ3G5oRGAkPRqlUuhl8x016mTGKr
 579FzpP+M5+97vbZfKM/KtFGb3NgVvJgZrx+j4PieTHlwj4wjXYweG6ijZD4a3/iIhexqgLmtlp
 F4x/MMcefjoKCXlUWJwsm9aTwkh2xIS2G+/SpNM7R/Yw==
X-Gm-Gg: AZuq6aI/bC/J9I5UjNgAvW7aaVT/PQyShZybvTDhenNXRKzxEIaA8gZrvf1GbPmwX9M
 HiWsCpI4O/ZIS5BR3SaUDdaPuT/IgiozUwQOQr3Trudcl2gowyF0Yzlj4rOr9Z27jyOH9DYTnVO
 50IW8CpJVNLN/pz5BjOQQvNkayX4aiTLbdtL6Emf6ywWgf4SsYpOb0VCNiS5yM66ONrMA=
X-Received: by 2002:a05:6102:32c6:b0:5f5:32e2:5ea2 with SMTP id
 ada2fe7eead31-5fae8c20ab1mr2399869137.37.1770606067322; 
 Sun, 08 Feb 2026 19:01:07 -0800 (PST)
X-Received: by 2002:a05:6102:32c6:b0:5f5:32e2:5ea2 with SMTP id
 ada2fe7eead31-5fae8c20ab1mr2399864137.37.1770606066917; Sun, 08 Feb 2026
 19:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20260207134728.1495932-1-lulu@redhat.com>
 <20260207134728.1495932-9-lulu@redhat.com>
 <CACGkMEuP19cndgGqnmT8_CzvnduwCx7sOFRNMtoXQQWS8hyQ0w@mail.gmail.com>
In-Reply-To: <CACGkMEuP19cndgGqnmT8_CzvnduwCx7sOFRNMtoXQQWS8hyQ0w@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 9 Feb 2026 11:00:21 +0800
X-Gm-Features: AZwV_QjQ_4F-hQu5wVjeNMxB61YNCCfdYtO_YwOk3nraAMbdimXVX1VdbUADR70
Message-ID: <CACLfguXHrZa8OUvbL_vRahQZagHU8egVk0x3JpKz0w65UxboKA@mail.gmail.com>
Subject: Re: [PATCH 09/12] net/filter-mirror: treat redirector injections as
 raw frames
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, zhangckid@gmail.com, lizhijian@fujitsu.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Feb 9, 2026 at 9:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Sat, Feb 7, 2026 at 9:49=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Packets injected from the redirector chardev are raw Ethernet frames wi=
thout a
> > vnet_hdr prefix.
>
> This may not be true as it could be the traffic from a remote
> redirector that is redirecting virtio-net traffic?
>
> Thanks
>
Hi Jason
sorry I should make the commit log more clear, in the code.  I use the
s->vnet_hdr to check the if they use the vnet_hdr, if yes then remove
the head.
I should rewrite this commit log, what I mean is after this redirector
process all
the packet would be the marked as  RAW
Thanks
cindy

> > Mark them as RAW so downstream filters (e.g. dump) do not skip
> > vnet_hdr_len bytes, and strip the vnet_hdr prefix only when vnet_hdr_su=
pport is
> > enabled and a valid prefix is present.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  net/filter-mirror.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> > index c1b9dabacd..de32028246 100644
> > --- a/net/filter-mirror.c
> > +++ b/net/filter-mirror.c
> > @@ -146,6 +146,7 @@ static int filter_send(MirrorState *s,
> >  }
> >
> >  static void redirector_to_filter(NetFilterState *nf,
> > +                                 unsigned flags,
> >                                   const uint8_t *buf,
> >                                   int len)
> >  {
> > @@ -156,13 +157,13 @@ static void redirector_to_filter(NetFilterState *=
nf,
> >
> >      if (nf->direction =3D=3D NET_FILTER_DIRECTION_ALL ||
> >          nf->direction =3D=3D NET_FILTER_DIRECTION_TX) {
> > -        qemu_netfilter_pass_to_next(nf->netdev, 0, &iov, 1, nf);
> > +        qemu_netfilter_pass_to_next(nf->netdev, flags, &iov, 1, nf);
> >      }
> >
> >      if (nf->direction =3D=3D NET_FILTER_DIRECTION_ALL ||
> >          nf->direction =3D=3D NET_FILTER_DIRECTION_RX) {
> > -        qemu_netfilter_pass_to_next(nf->netdev->peer, 0, &iov, 1, nf);
> > -     }
> > +        qemu_netfilter_pass_to_next(nf->netdev->peer, flags, &iov, 1, =
nf);
> > +    }
> >  }
> >
> >  static int redirector_chr_can_read(void *opaque)
> > @@ -294,12 +295,31 @@ static void redirector_rs_finalize(SocketReadStat=
e *rs)
> >  {
> >      MirrorState *s =3D container_of(rs, MirrorState, rs);
> >      NetFilterState *nf =3D NETFILTER(s);
> > +    const uint8_t *buf =3D rs->buf;
> > +    int len =3D rs->packet_len;
> >
> >      /* Update indev statistics */
> >      s->indev_packets++;
> > -    s->indev_bytes +=3D rs->packet_len;
> > +    s->indev_bytes +=3D len;
> > +
> > +    /*
> > +     * If the sender enables vnet_hdr_support, received data includes =
a
> > +     * vnet_hdr prefix. Skip vnet_hdr_len bytes and pass the Ethernet =
frame.
> > +     */
> > +    if (s->vnet_hdr) {
> > +        if (rs->vnet_hdr_len <=3D 0 || rs->vnet_hdr_len >=3D len) {
> > +            return;
> > +        }
> > +        buf +=3D rs->vnet_hdr_len;
> > +        len -=3D rs->vnet_hdr_len;
> > +    }
> >
> > -    redirector_to_filter(nf, rs->buf, rs->packet_len);
> > +    /*
> > +     * Packets injected from the chardev are raw Ethernet frames witho=
ut a
> > +     * vnet_hdr prefix. Mark them as RAW so downstream filters (e.g. d=
ump)
> > +     * won't try to skip a vnet_hdr_len.
> > +     */
> > +    redirector_to_filter(nf, QEMU_NET_PACKET_FLAG_RAW, buf, len);
> >  }
> >
> >  static void filter_redirector_vm_state_change(void *opaque, bool runni=
ng,
> > --
> > 2.52.0
> >
>


