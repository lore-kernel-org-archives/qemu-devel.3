Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DC6EA854C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 03:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzR7M-0008Q4-R2; Sun, 08 Mar 2026 23:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzR7J-0008PL-2e
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 23:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzR7F-0002xm-7Z
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 23:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773026227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+mPxkTWQsgeLhLXg2L6mhTzw2WIzmrHTi0imdx0E3VA=;
 b=jFDPqbXVVctOY/HEcIiLPg6fSJfWhhQUogLZaMyBuWAp76fzcSn0z8amxO8VZe6CCf/yEE
 w9TMxHMS/w8PoO2b8RcQ6ISQQLITQqFoteNEMBXnTZ1U9Qn7W8Nrg+f+nXC38lkq6ntchs
 kgY3E/O0IZYl6azEBVTfEqdpL6AcWWo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-n8c9YkVePh-VabyQFhx0Hg-1; Sun, 08 Mar 2026 23:17:05 -0400
X-MC-Unique: n8c9YkVePh-VabyQFhx0Hg-1
X-Mimecast-MFC-AGG-ID: n8c9YkVePh-VabyQFhx0Hg_1773026225
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c73783c96baso2380303a12.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 20:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773026225; cv=none;
 d=google.com; s=arc-20240605;
 b=PBBZcr5ghYCccN7zNqhS7kR2JV4XP8zkOc6unUXDMbT6HuGekGNlZU0X6Ilq/90mXl
 HFuSSUstKJ9JTFdeV0YqKrZVnxEEMR0fFiBZmHuiYxd2hoA3c1AuQFXL+67IGINRLP0T
 oBNYgxJsWeAJ/joaMxTm4Sb7v6zOhEEiKzZDwaKRUmo+jgwH93hGHxU6YSd8W1q5S1dO
 QnNtl2iCsYSCoV24nmRNES3ZdBAjl5UjfsSDSfLy7vkEVNXs0mByFWCPWuhEdczqZuyf
 FzB+HLDVtdB+h4/o2w8ypaxv8xk4JtMZd0vaFL4F2558ByUKfdAY7ddVH+1qgQ6HXoCE
 y62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+mPxkTWQsgeLhLXg2L6mhTzw2WIzmrHTi0imdx0E3VA=;
 fh=CCzwMatiZjClffqXfYCT0E4TCmw+jdyoA/vgnnKOdRs=;
 b=ZB5P3KQmvPOWbzG6QrtjfHbmGxtADm2coimRZ4hWoi3xDjIAP7NdrQuL5/Nc9iOc3t
 XQQL0Wj0m7ByzoVSMCPxhzC84fh0BaroCdd7agoGPENXE7c1ffNrEqmnXrMllvXTpVAd
 3hh/2B0/oktkBfwB4DDEfRjeExK67Z7DjgOQhEFgGJqljxqi1U4CdLQ1995U6toBC78j
 9vVqXRfkDhaMZha9QsQxjQY5b+65p2/3RHwhYshJQrRNy3SAmCaNQtWX0DzEYafXMEC+
 AaQX8/d25XnFgCb2TVv0hAvob5GdGALIntLV9ofRnd/xxtLB+Y3cjSQJDABB8rZBIwWk
 Ij0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773026225; x=1773631025; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mPxkTWQsgeLhLXg2L6mhTzw2WIzmrHTi0imdx0E3VA=;
 b=kQ5j6wkIrF2bAzrzYLXrrZujzVe1akobLB5jZfqFmU+2GtOaAaiITEMi1CUw1w8M4U
 GyJyVm0REK0A9+fFsPz9TUOU7vthn3HWUqqC2OWHFG0jvUrsAxT1qUToyzPL1o5NIoAb
 T33yiizBSjJP8+wyXIbk/Owdmk8KQeromk6Fa4oRnQ6YHPd5elmh1yBHCLKA3JWOUEPR
 q7T1/n5n5j4AMC+5Y3+Ci8g6ILpmDX1Mdn0YS27g4R2ge8AgH7LsrnWFuKk1UuNppzr4
 uSYquYFeUmKh5N49KZX1FWg2hzJiBmATVzhjKsWng8Y/X6U9GsmvxGmOpnJqVOB1PoRK
 IDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773026225; x=1773631025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+mPxkTWQsgeLhLXg2L6mhTzw2WIzmrHTi0imdx0E3VA=;
 b=jsVbWv0BTSGAC0YbCXmVQI1rxZXcqBYbGRqZk+pAX1AIMU0lXN9fHIGDQaM9RyYag5
 Xl2Tmga3U/WVruqbJ9UyDIDaSdOzpmVWCki3oeQSg1ts7XCOuuz85eQ6w1ZNkVp69430
 GbzTm6it2Ce1Kqnn6WQcmJ1DHaZUATWogEJLmfSw1WX+lN5KJNDP/muVaW5LeWkFCuoE
 +BxjuEkOa1RVrtgoOp++cWanQSvMzAQj33drL/hA6SGsBCpo7W/hm6ovJzMI9I9xmewI
 5Z7n+wXcYIf+C8vl2UZ27zlfkHnmhSAHwRKH5dBlwtVfSOGucmOe4kfCtXWNP1YhuJ2F
 9ikg==
X-Gm-Message-State: AOJu0YyzBMoXtplhv9eP6MKLdNI6RHFX0wG3FXuxEQH9Hux+I5Fiu8SO
 8ga8EAKm/aKZV0WVF8V4Axt7Cf/SGElFtPqFRoFjyv6FgNdck3rizwm2I0MFW6GXpmgpIH19HPB
 xWThFa1stxxNCIfy9Fk/38Z/ZqLgxZtKHCGD6sYCBwb6gx4kq23OPnpwTVhNut5zXVctRLb9SZ4
 fRxNddgl5DG9vR+yYOG5zUTCG1mj9cXkw=
X-Gm-Gg: ATEYQzzjHktOKwxNqfPddUqQmWpv6/6SpH2193GwSVr/QoFLRoyp9BGBiU2jLYgVxTL
 yiK5oc18gVgv2m6ILS+D4w8ajzovgvmjvbv1+m6Z/izP1zFGrRa0eViMoTdN9pRerDD6dTCj5/A
 dMcim55iP9kdDcvOcAta7mM8qIAKc8Pl5lm6SQ1tojwKhLfFPlDrSCez1cvUn9DiB8oMlXAZPAo
 Okoy07A
X-Received: by 2002:a05:6a21:180a:b0:398:7791:fb16 with SMTP id
 adf61e73a8af0-3987791fdf9mr4245330637.57.1773026224848; 
 Sun, 08 Mar 2026 20:17:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:180a:b0:398:7791:fb16 with SMTP id
 adf61e73a8af0-3987791fdf9mr4245307637.57.1773026224433; Sun, 08 Mar 2026
 20:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-2-eperezma@redhat.com>
 <CACGkMEu5BGgdstpEVw8eH+wmXhi+nFdHRW2bXk7enZtxbAdsBQ@mail.gmail.com>
 <CAJaqyWfADYQHjszX+DGoW1Cah--619_pVztmfV6ctTN6-0-Q5g@mail.gmail.com>
In-Reply-To: <CAJaqyWfADYQHjszX+DGoW1Cah--619_pVztmfV6ctTN6-0-Q5g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Mar 2026 11:16:52 +0800
X-Gm-Features: AaiRm52Srsrj3_AdmJYauUdsArebnMTm3BN90LYeKtVjbMHNVpROLnGcaLLZY5M
Message-ID: <CACGkMEt09WkCgJmbrdmyDYdB8HUH=Y-DrwNChJGrfH2afua8QA@mail.gmail.com>
Subject: Re: [PATCH 1/7] virtio: Allow to fill a whole virtqueue in order
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea DE <dtatulea@nvidia.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Mar 6, 2026 at 2:23=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Fri, Mar 6, 2026 at 4:26=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, Mar 5, 2026 at 1:35=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > As the while steps < max_steps is already one less than the vq size, =
the
> > > right maximum max_steps variable is queue length, not the maximum
> > > possible remainder of % vq->vring.num.
> > >
> > > Fixes: b44135daa37 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORD=
ER support")
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > Personally I'd just remove max_steps and let it be vq->vring.num, but
> > > let's make the minimal changes for now.
> > > ---
> > >  hw/virtio/virtio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index e9d553295257..17f171551892 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -980,7 +980,7 @@ static void virtqueue_ordered_fill(VirtQueue *vq,=
 const VirtQueueElement *elem,
> > >       * We shouldn't need to increase 'i' by more than or equal to
> > >       * the distance between used_idx and last_avail_idx (max_steps).
> > >       */
> > > -    max_steps =3D (vq->last_avail_idx - vq->used_idx) % vq->vring.nu=
m;
> > > +    max_steps =3D MIN(vq->last_avail_idx - vq->used_idx, vq->vring.n=
um);
> > >
> > >      /* Search for element in vq->used_elems */
> > >      while (steps < max_steps) {
> >
> > Not directly related but I found that the virtqueue_ordered_fill() and
> > virtqueue_ordered_flush() can "emulate" an in-order device even if it
> > isn't one. I'm not sure this is good for the device that can benefit
> > from out of order completion like block devices.
> >
>
> I guess the benefit is significantly reduced if the device cannot use
> more than one descriptor in the same used entry.
>
> > It seems the correct approach is to let the device decide whether it
> > can operate in order, not the virtio core (as vhost-kernel did).
> >
>
> I agree with this.
>
> Currently, `in_order` is off by default but we could enable it by
> default per-device.

After further thought, there's another reason. For example, for a
networking device, virtio-net should know nothing about the networking
backend (though some tricks exist in the code). So it can't know if
the backend can handle OOO or not. Starting with this seems to be
fine.

Thanks

>


