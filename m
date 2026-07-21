Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1659C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCEo-00067m-3R; Tue, 21 Jul 2026 11:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wmCEO-000653-JW
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:18:04 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wmCDq-00063P-Iz
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:18:04 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso10316922a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784647045; cv=none;
 d=google.com; s=arc-20260327;
 b=FNyjG3rH2OE+mGDoxQfaDOQ0HiFgCakyelv6p0seYkXfbWS+MyUO175D3tIqGl7i+v
 N2WXnkliRL+UVGCm07IG5jNoYTCOYjXbjqY/7FxtJEnLC30laTcN3O0RJlVNoNsj7UDP
 nCN69ZPqlZg0BRgjCDZJebHwItKIor/WuUuLTQFpvZQhycqz7RJLK0khd2wckD7wUSVl
 A2eI63Muo7oLEdYnZFQ2HSRzBFXCCdAPQjvPpy8xrIDUWaGjCnlSB+duiKyi1Ja1UIN8
 lJrbNqi+vwOMqoWJtMLC6EBTJYsRh3sQA9v/m+nrsFcWhXTL8jP0G97Gj1B/95YbAKjh
 nsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SVfYdCNryGt9SfK4otsREdqLEGOAoBwfWQWNa+qabOI=;
 fh=uW9LNDWDkxlbaGsIVS8TKlmBum2AicH6+5H5fWMzWG0=;
 b=B3nCZ3C5bw/i8F5/HaxV0+eef95Gzqixwxhk/fmmoJzoF2j5d7B9sOpiUw1OdskUUr
 L60oTv7BSZ/PGJA1ZmdE6xz4ta4v0Rv6egKnB9SkFgpT1Goj4Lntft98/9wD+RRbd1Aj
 VFW9jnT3GIE6mAWvFU4/adIq2XyceWSib4TJmat60ald0ECInDxlTFsgxE8/QIxM0J2s
 mOWKdADPSsRiyPYr+2rZVodpL72lFWas7BmLctsc/mMGzzNEhS4eOQOMnRn4ksrep2cE
 s9YS4+wPhx5SE7OvTAgWV/pxIy9rNS8u048ih7IiMUVjj67rgNpinLiCD/GryzPGELXa
 vzVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784647045; x=1785251845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SVfYdCNryGt9SfK4otsREdqLEGOAoBwfWQWNa+qabOI=;
 b=iYI+YmCh/+yJ9to3qWqZageTfgpImRysBX0fBLKINIFOB3RS9Y2ZkIeIrQjWtXGhxs
 3PtOXm9QewepBL6ORE1eWny4YzwKt/NAtbFOg24p5sGMg/V6kmH2Svy1Skk3cryBinff
 VczyQgfhZ5xD/ireVEmYgajnXCxbJoBkEFooP652HxJIDvB2CMY1xX+mHuJuHEWsUtQf
 veGeJayilO9ups81LXh82+4cz6fPfHSwt9S9W291d0XkUynQrtpOP1aKZQgYZsfxkFaR
 luZ726LG+NHHMhzmUuiZObryg8xP8GMnL4fuiGsTwrpAgBokOBV7zeYGGslp16hA1w5L
 03/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647045; x=1785251845;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SVfYdCNryGt9SfK4otsREdqLEGOAoBwfWQWNa+qabOI=;
 b=jo+NK5+Ot5IajITBEJbi1lHeV13znk52fefw9Vgt2poKiQiJX6Nm4Q0i5NHydvrG3k
 E54O7N/kZDhJDPtFIejf76ZrfvK9/LQSOJ5D64SuCxemin6EP1N9CpIm+UEhnTB0LFca
 qo3ym9VpPwnZVMyu07OtGU3qX5PIrfEeoD1kDY5si9y/fKCObTSI6vchoihTUVMGE5Uj
 rqMQVdscBZxFRGRw1bc1FzOXxObc43G4sTlYmvOhNz4MJrKn3NNEq719Osyp2+KAZPwE
 /DUFYDTIiRsvJ+5szOkykXTf3wtdUgLe8D2XoYeaexNpxd33TwMRr5nbZDeqczF87aT5
 7VQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRe6sT+pzjWZfVJhYKp7/adWg0kpFP3Llq+d3K37mHNZ0tK/lo9v7EmlEEgwdwq8RAG9RjcwbD9NyT@nongnu.org
X-Gm-Message-State: AOJu0YxcjqM+8qvpG84fqqgaA1g11UetPGziK19MbbgaDvWZWBE0q73f
 KE8IqxAbiqwEQK7bLiFhDalqL9iR7a2U2M9tYIXsySRmDT0rZk4ej6NfENLbsM2N6/Fnz5hAOCy
 TW7dP6ori0mWcJtkKFwQ0xuXEEQYcGZk=
X-Gm-Gg: AR+sD11RTu7kTMBFbBCq/2NcdbzsbohpXzjkIgZv5egVvVHZgEZoa9RhSQm85IIWJBh
 B03rvzmjaFe5QQM1SRBvzoUmPcSYx4V6H/Eijm5fqosT49GfEoghmtCo8bQhrDiKgfLiWVI22dx
 vG6R6uD90M0E88cOn10+UC//68D7bgq9eKjVZlGUSiG/gH3DS2J5k+cs0WcgUahZ3zw9seTAY7q
 ZgRxV82zS7ZXZLLE8JvF97C9dmZ0bGIHv8Q3UASyUsNxuF3rRBpingpm5mNqJ2cnUQA5WG7Xf1t
 q1pSiokLGlJxAMvHvEZg
X-Received: by 2002:a05:6402:190a:b0:698:9450:92b0 with SMTP id
 4fb4d7f45d1cf-69f3335e37dmr22220a12.1.1784647044346; Tue, 21 Jul 2026
 08:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260721134424.196337-1-stefanha@redhat.com>
 <456ab3b5-a2c9-410b-91d0-f8b13fc0b542@oss.qualcomm.com>
 <7c3b30b7-bc55-417d-a36d-5b3b1ee61b7d@oss.qualcomm.com>
In-Reply-To: <7c3b30b7-bc55-417d-a36d-5b3b1ee61b7d@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 21 Jul 2026 11:17:11 -0400
X-Gm-Features: AUfX_mxilsgoxOg6EtS3eY42lHA1touonGGuH1jL2EIQc8RsOt8au3XHdln0zqY
Message-ID: <CAJSP0QXwpNtQ5eBeD6YT+vXNB3p4QgXKTjZ+LvE8racFu4-qMQ@mail.gmail.com>
Subject: Re: [PATCH for-11.1] virtio: avoid packed vring virtio_queue_empty()
 infinite loops (CVE-2026-16457)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Anatol Belski <anbelski@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Tue, Jul 21, 2026 at 10:33=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 21/7/26 16:26, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
> > On 21/7/26 15:44, Stefan Hajnoczi wrote:
> >> Virtqueue handler functions in device emulation code often look
> >> something like this:
> >>
> >>    while (!virtio_queue_empty(vq)) {
> >>        ...pop and process virtqueue element...
> >>    }
> >>
> >> virtio-blk, virtio-scsi, virtio-crypto, and vhost-shadow-virtqueue use
> >> this pattern.
> >>
> >> The device may break (i.e. hit an error that requires device reset)
> >> during the loop. virtio_queue_empty() returns 1 for broken split vring=
s
> >> but not for broken packed vrings, leading to an infinite loop.
> >>
> >> Adjust the packed vring behavior to match split vrings and avoid
> >> infinite loops.
> >>
> >> Fixes: CVE-2026-16457
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3968
> >> Reported-by: Anatol Belski <anbelski@linux.microsoft.com>
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> ---
> >>   hw/virtio/virtio.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index f4d86a36553..3795e3c8c68 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -763,6 +763,10 @@ static int
> >> virtio_queue_packed_empty_rcu(VirtQueue *vq)
> >>       struct VRingPackedDesc desc;
> >>       VRingMemoryRegionCaches *cache;
> >> +    if (virtio_device_disabled(vq->vdev)) {
> >> +        return 1;
> >> +    }
> >
> > Correct, so:
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >
> > But why not run this check in virtio_queue_empty() entry?
>
> To be clear:
>
> -- >8 --
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index f4d86a36553..019c9c9e293 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -786,6 +786,9 @@ static int virtio_queue_packed_empty(VirtQueue *vq)
>
>   int virtio_queue_empty(VirtQueue *vq)
>   {
> +    if (virtio_device_disabled(vq->vdev)) {
> +        return 1;
> +    }

The _rcu() version of the functions still needs to check this as well,
so I don't think it can be extracted cleanly.

Stefan

>       if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
>           return virtio_queue_packed_empty(vq);
>       } else {
> ---
>
> Having:
>
> static inline bool virtio_device_disabled(VirtIODevice *vdev)
> {
>      return unlikely(vdev->disabled || vdev->broken);
> }
>
> that would avoid the RCU_READ_LOCK access.
>

