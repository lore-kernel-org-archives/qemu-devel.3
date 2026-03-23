Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7961EEC01B6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4bsV-00008G-Pj; Mon, 23 Mar 2026 05:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4bsT-00007q-QO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4bsR-0001hO-HV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774259233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03IX4K4l4WBqfiN7JF0YuYEff+fUSnJPafwl0AA0GZg=;
 b=hwsJdZxTAfDpaNRJPkag66P5ii13qSyNLJmh3Upo+FTWcJSL4hvTzEb1RxrL36AvAO3iHd
 jRcxRTVB/809AtYYOzODMt5WZ46u+ChpRy7m7D5HENioH2hdCOHcG4nQXYnkZlk3Rdky35
 MAuvwBEtoGN7BbhgWdSmm/9cPqcnVoE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-pWcKDYw6NJyfnY-0rCYfmw-1; Mon, 23 Mar 2026 05:47:12 -0400
X-MC-Unique: pWcKDYw6NJyfnY-0rCYfmw-1
X-Mimecast-MFC-AGG-ID: pWcKDYw6NJyfnY-0rCYfmw_1774259232
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79ab2460d85so11546897b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774259232; cv=none;
 d=google.com; s=arc-20240605;
 b=DvrK7q2BG2o2axyK2JBWQD1Z8Rf2QfcbPdBa2JOjtz/yboMciJ1IbL6VwtS/aF5s1U
 cmPTTB4nVcDRIhVQ0VSAjAJXw2HbNqpelV8YS5NQvK5AOzKTETv4tnNWq78ChuUa3H37
 J7WljmIOmj8uifGa6bfAd65UpHfBEEtzG6ORcdXoAvpYBsnamuD+TbOJJtqfGAJHsfi9
 Id00/xutVitFlWWtojQWqAjgbyU+jh8qCORZl8n/f1RWGRZpAJG+Y05rrtwflh5bMj4k
 oFnd1UPMcs4YW14P3wlRkGjw+n1PXXNmmP0Q6F7LVfEIZiJ3X1Fcfq8ZMdBXS0I5UHBN
 4/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=03IX4K4l4WBqfiN7JF0YuYEff+fUSnJPafwl0AA0GZg=;
 fh=YWd1Q3HWQm37cadwbuH1smAtl/9JiSgdWcRaZLT5vrE=;
 b=jXKY4TwSjucInF6jDzQ9bjFC6Hgl5gmJBgcpaYMyehYjJgUf1kssQE/WNrabhF2rTF
 5IGWICZKYUPrfmYrYEXPO341f+eV8pbR5PHEf23CrmzaDEVEBZVIrBKKz7pN4Boogalk
 knfD9IQffsaijWzgKJHYJMT8QKehiPrqpi1QswXYLSW5Yj+1GqfJcVUAsAeEIuNbBvXe
 xHVVpVJjnoA4nEoYMX5BqGfJtEXOB5KhdVDe5KDV48QGJPV8AfnPC4HdArdvDzT7rroD
 3zXC/t40jcFrQfHNukPjPVon7BYuMH6ctOIIy7Fn3syip1fzgsqxs6C1tTjqMiYiH8vz
 YbEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774259232; x=1774864032; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03IX4K4l4WBqfiN7JF0YuYEff+fUSnJPafwl0AA0GZg=;
 b=Wg31hUI9oKA0DrOdcsqU2IuxZO1kXYMLqta7cVXAmFfufwi5M/RTHjcVTi69vp+bDb
 RO9kbEnNtpmZSoKIjnXA3phq5dKRZW5ipk1B4TbJakzwwiGiN3WmNE3Zq/yRP2/cPdRG
 f2qmhCT6VkG75DgklliMSDMf+Wm+QgEOQ/9ao4V08spIDKrFIVE7W5RGCvd4fcT26jtt
 afCON0xrJeTW0B28F396FVlcs6RDjCgPUh3j0j3H7kNSFfMMV89MBXXhzHyqluJsJzUm
 addq19kjNh71iMkvacgucM6O8kBsosvZc8awHGJi8ijtPsBN9pXUebTmfa1/fEPF6DcH
 74fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774259232; x=1774864032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=03IX4K4l4WBqfiN7JF0YuYEff+fUSnJPafwl0AA0GZg=;
 b=fSnbYR0JqqqETe9g8zwAGz5NzNMpCHyTCB13kHuw/v2i4vLHx8tS2lOIT1tvPQgHIh
 dYfw6Nph/h0V+WtLrkzTJlh6QqjoJkESySesKH0Ln6+gzmvNGaDuUIuw4ToAXCFIclyC
 5Cv8nwrL4NGrfqawhr6LQv3h2shf61NFW4hl+NsxFVHHhDSDaF+vjOny17oC8fpPrBua
 f/ITIgTbd3yoHvniv122QZ+enzf7GJjorAlzNf9XURZbHdhfnI2sAdCL7oXAQBMtiIdc
 0HqzwMdq9uXVSIyWrFrIZnBCFklWVysWkUCdETWXC+Isjx1t+0s85FZdTWEfX6ymJgfq
 G4gQ==
X-Gm-Message-State: AOJu0YyTYjiUdfjaMCDsfunMf6HKMsgoVBZ5uHY5hOqkrilvfHE/ci7L
 ehUNF3mTIm5mKK7dX3D8DYdjeydUk7JyF8wuWGMSVVo0q89OHIDNQmqc8GxQV6OZI59DLEZ8o9s
 m14vwVG2puoffoQe5cSkNcVb3XE8JStm8r6eUk90Cmov2k3d1b1l2gi/lR+B45yvROlBy3Gj/Wk
 iGvOkpDclKPPAWHwIELvUCeekeRl30ZOI=
X-Gm-Gg: ATEYQzx67m4sMiUfbiPxVqLsppzfkV/1nRgtJVbSbLjVQfwq2ZGTK7ZPGROkH6Xmmlj
 ER7d1d/PeHpJ+GpRA6i3+EdDcmWZQ2dxpyG7GoKV51yr1aw4LGWqrtrsjogvWUx4FZJjhmUtzdB
 ML9oz9CjhuXg0OghhZhzcgi68NbyFLW6k58r+R8fIrwPKcDbfDKMb9IcAAzDKaNwDiw++lmFrfl
 J6+Yw==
X-Received: by 2002:a05:690c:498f:b0:799:1:bf1 with SMTP id
 00721157ae682-79a90b80f96mr118179647b3.29.1774259231749; 
 Mon, 23 Mar 2026 02:47:11 -0700 (PDT)
X-Received: by 2002:a05:690c:498f:b0:799:1:bf1 with SMTP id
 00721157ae682-79a90b80f96mr118179427b3.29.1774259231300; Mon, 23 Mar 2026
 02:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260311132801.292173-1-kdutta@redhat.com>
 <CAJaqyWfHQ-6S1jNnnv0TrTmP5r-GQWdP+PeLtziuUikyg+TFYA@mail.gmail.com>
 <CALseRdf-2dUhKk51hKn8Kb=GiXA8QqbQG+n+txy6S-B+OJ3mMg@mail.gmail.com>
In-Reply-To: <CALseRdf-2dUhKk51hKn8Kb=GiXA8QqbQG+n+txy6S-B+OJ3mMg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Mar 2026 10:46:35 +0100
X-Gm-Features: AaiRm50t5wMmKAeN5kWOqR24DyMZWSBAGXQOTuGJ5-Z8og3hDB7lQHUVl5Q-Cmw
Message-ID: <CAJaqyWdMPQiUoJtuef3pzggRb-6wk4EJD8h8yy4z=HF_CwTKAQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net/virtio-net: add support for notification
 coalescing
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 23, 2026 at 9:39=E2=80=AFAM Koushik Dutta <kdutta@redhat.com> w=
rote:
>
> Hi Eugenio,
> Regarding the point about not enabling VIRTIO_NET_F_NOTF_COAL uncondition=
ally: since feature negotiation happens during VM bootup and coalescing is =
configured via ethtool after the VM has already booted, how would we handle=
 this under a conditional property?
>
> If the feature isn't negotiated at the start, we wouldn't be able to enab=
le it dynamically later. Could you clarify how you'd like the command-line =
regulation to interact with the guest's ability to enable it later?

Replying at the position of the comment, marked with [1]. Please
interleave your reply for the next time, as it makes revision easier
:) [2].

> ------------------------------------------------------------
>
> > @@ -37,6 +37,7 @@ bool vhost_svq_valid_features(uint64_t features, Erro=
r **errp)
> >          case VIRTIO_RING_F_INDIRECT_DESC:
> >              continue;
> >
> > +        case VIRTIO_F_RING_RESET:
>
> This patch does not handle VIRTIO_F_RING_RESET, so this should not be ena=
bled.
>
> =3D> I included VIRTIO_F_RING_RESET in the valid features list because th=
e vDPA host device offers it by default; without it, SVQ fails the feature =
negotiation check during initialization.
> qemu-system-x86_64: -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-=
0,id=3Dvhost-vdpa0,x-svq=3Don: SVQ Invalid device feature flags, offer: 0x1=
e0010330bfffa7, ok: 0x1e0000330bfffa7
>

Since you're testing the feature with nested virtualization, you can
disable the features in the L0 QEMU with:
-device virtio-net-pci,...,queue_reset=3Doff,iommu_platform=3Doff,guest_uso=
4=3Doff,guest_uso6=3Doff,host_uso=3Doff,guest_announce=3Doff

> Regards,
> Koushik Dutta
>
> On Thu, Mar 12, 2026 at 3:47=E2=80=AFPM Eugenio Perez Martin <eperezma@re=
dhat.com> wrote:
>>
>> On Wed, Mar 11, 2026 at 2:28=E2=80=AFPM Koushik Dutta <kdutta@redhat.com=
> wrote:
>> >

[...]

>> > +
>> > +static void virtio_net_add_queue(VirtIONet *n, int index)
>> > +{
>> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>> > +
>> > +    n->vqs[index].rx_vq =3D
>> > +        virtio_add_queue(vdev,
>> > +                         n->net_conf.rx_queue_size,
>> > +                         virtio_net_handle_rx);
>> > +
>> > +    n->vqs[index].tx_vq =3D
>> > +        virtio_add_queue(vdev,
>> > +                         n->net_conf.tx_queue_size,
>> > +                         virtio_net_handle_tx_dispatch);
>> > +
>> > +    n->vqs[index].tx_timer =3D
>> > +        timer_new_ns(QEMU_CLOCK_VIRTUAL,
>> > +                     virtio_net_tx_timer,
>> > +                     &n->vqs[index]);
>>
>> We should avoid creating a new timer if it will not be used by
>> default. Create it only if cmdline enables it or the guest enable it
>> via control vq.
>>

[1]

I'm proposing we switch this to something like:

if (!strcmp(n->net_conf.tx, "timer")) {
  n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
virtio_net_tx_timer, &n->vqs[index]);
}

And, in the CVQ code that you created,

if (n->tx_coal_usecs) {
  n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
virtio_net_tx_timer, &n->vqs[index]);
}

And the same applies to RX timers.

[2] https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replyin=
g


