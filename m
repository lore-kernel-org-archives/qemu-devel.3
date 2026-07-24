Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55222C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 20:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnMqH-00069s-W2; Fri, 24 Jul 2026 16:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wnMqF-000699-Cx
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 16:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wnMqC-0004rR-PA
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 16:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784926193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmnLuq5uNWuGm4Nu8wkmXno/RxMJKjaNXyOPEZepAAM=;
 b=MQLbXfbQC11GeFqNJ5BRFEKoTx/KxpLOzSp6p9cUxgMllhmgU9EPlnotVA92MYBUR28Vgt
 olKgmLaeA+jw1FeOVzug7KFKsYZuQZSTbHhRuJmc9T5p3Z4RqqCpqYU95g5Ud/GG7KE2DA
 Au7Tsifz0YKrPlsubQFHzy0IaGrwR4I=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-dq2UoOOyN6mNoccvxEqh8A-1; Fri, 24 Jul 2026 16:49:51 -0400
X-MC-Unique: dq2UoOOyN6mNoccvxEqh8A-1
X-Mimecast-MFC-AGG-ID: dq2UoOOyN6mNoccvxEqh8A_1784926191
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so513031a12.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 13:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784926191; cv=none;
 d=google.com; s=arc-20260327;
 b=oDyRYlWd+LhipvAlalnBO13Ap8W7M3GERWyK94i87NvI9o/AMlJXTZQ7GpkhT6CtJw
 z40wqtOvzN+wzDtfqMLkZIhUk24rjmT6Ggvv0XMgR+asdcDkdWNzQHwgy+pg0tLYOruD
 kxd4fxNoUT/u0LXGplLJzWeWFeDQ6r5codhLGPhUgNrph6/xpep49aKPQwuH6E7h6c4S
 dQicS9CULFVNj+aETA1sbu+Nvi6mC0llgPUlFskTyKBscpGC6VPKr/LtBPapu5bjjZmY
 KeHydI/DGi20/dVsCeFm/ImaoHCocgrs9FovXis25C2qXz5dFzQijs2qgxgWloPrMTgR
 DdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nmnLuq5uNWuGm4Nu8wkmXno/RxMJKjaNXyOPEZepAAM=;
 fh=KnxVq+/dNMGR5XtbHr3cm7WMCtMcRbEU6z8PkW8LG2I=;
 b=mAaS1aEc6c10QLJzXWQyby6glWM/O8pYwEAt4WYx3x+xGwyw4E6018NPou7ByCJQC5
 yT2Ty0AmRww1D2fU7uhC6lCrb9BVmlXO/V9cqrqqtdH1t8+Sd3eXcOAwEeDmgfJyPh8A
 Mn3il7otqZTCrbY/M4QqtjC1wcc0RffeBKR7HAPqJgI6iK6sMZCbj4ICZPqJijI14WZO
 6DO4CmCAycX0RzKNxubVQJBu9jIyvXannAhX+d2gDqFd0rIhfKiPQbQ9955GsE5KrrWj
 KtMo9j1yMVzrRxFXn6gkBOz10acJQcfQutk2v+f7hdzDY49hgP9Bd1QAfDcpizL/KNQP
 Mbeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784926191; x=1785530991; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nmnLuq5uNWuGm4Nu8wkmXno/RxMJKjaNXyOPEZepAAM=;
 b=n22tE3GZr6A/M5Z6KQ6qjS+VDDqGQPivBa+kxbZ+qgE5mmWLryPiaD4zWDzxsxXmaN
 CE+oer0+AlbFgq8K64k7eQ08YRzpn873Z0YBI1AHG2wo0p951aMbyKS6c5Nyr0JQ3edj
 G2TzN/h/zz/r3q8UJ4Hvts9XZN35slE5Pm6Wokru1tQyL0l+EnnaxS1bcmrQm0XFWhsQ
 YBaKOHkBupIVgWxGjwUPdGMHC7g6G+/dT12kTqJuFQ0BENkYS64wGp8LIyDh0SuDYIcB
 ZUX78gZURJ0jXF1Uf1GG1bABH+x79bWJ7+NbRx2GwY7YKE5jbedNJSqQJfzigrB3CSdF
 KKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784926191; x=1785530991;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nmnLuq5uNWuGm4Nu8wkmXno/RxMJKjaNXyOPEZepAAM=;
 b=o5XSaImbItSC6bC6lgW7WJm4jOccYeB5dGTX5TS6rd5ZCVjKB/Qjc6lmy0m205/ad1
 TLWhLq+JR7EVaWYq8ZuFKGhdL8eHi8fKqIbWeZSGCKuSQjn/by5fUXwcxSIb296pQk41
 d2KV3uObPC8n/7ODHeji2M8lYGHuacp7apT+UU6BpYZ1xZdh9ZaQ9xJaRPZ8D8dqEyQO
 W5gINuas0tPIASjYL/tkMSYQ/EbURosREBF6j7FRM1+ydLMiho1Escl7ay98vRPH2j9t
 4QB7bXbOWOCWLJpAU7j2ffXi//JAxJ+obka4HYWwVyLWfGVZcNv3LdLiiMpM/CpLnrTg
 uI/Q==
X-Gm-Message-State: AOJu0YzCEIDNcC8GyMjUsipyGLjMPw9YsZR8A/JaCEQMwhS/sFXNpgMi
 +AXB12NseEBsi9m08kwldE2p2nE1MI3Ljvn9IzPgs2BtvbA/WJkG9vPDFOd4X5XbKLZNNwf55e5
 4fhUGFSP+vKV4bVGTXpXIFpci2S5S6oRMJRxEw48Y6WTcvcsd7/ul5N7PCKDAg8cHoTCa/fjNHm
 uFfRmAVOBX3gDoubwAogYTa/hwuDVgQKQ=
X-Gm-Gg: AR+sD12AR4iyIGuLMDVvNI+9wolfMphEiNkIp+VNG5lNTpvrcvyQvMaMEjIJRg7aqGT
 gqszj/uE9QpAIwnEBIdc72w1FGJLxF0eur2gsvOrM4CKXPVTYm+en0U46UC2tJDrtIEbLkaIXHg
 aAqdY3QegubKJypXgFT9BiGGF97eZfSXN/MN/f3DDiH7K6XaYa8JQe3L7L89+GQjmY97OE4fq1Y
 k7eDTOf+kHC4aTneyt2AjTVaPPr2EUaS0jmfV0HSetG0xLSBcb1JDy9I0EOiC7XCHOo4n/OR0fE
 Wg==
X-Received: by 2002:a05:6a21:69a:b0:3bf:7498:9cd1 with SMTP id
 adf61e73a8af0-3c44b159054mr9904308637.45.1784926190664; 
 Fri, 24 Jul 2026 13:49:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:69a:b0:3bf:7498:9cd1 with SMTP id
 adf61e73a8af0-3c44b159054mr9904278637.45.1784926190086; Fri, 24 Jul 2026
 13:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260724040126.867935-1-marcandre.lureau@redhat.com>
 <c45bd86d-aef7-415d-bf49-8b436cd52231@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c45bd86d-aef7-415d-bf49-8b436cd52231@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 00:49:37 +0400
X-Gm-Features: AUfX_mwSYfmdWO8bJ4On08R8FeJUbUc0MtCEN5OMzq7XlhT82yWCElZWPvsjEiU
Message-ID: <CAMxuvay3Uz_nWq9_BoO6pN+FLJLCN5psn3vJojWh_YkcEb4bgw@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: fix offset truncation in
 scanout_blob_to_fb
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Fri, Jul 24, 2026 at 12:01=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/24 13:01, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > virtio_gpu_scanout_blob_to_fb() computes the framebuffer offset from
> > guest-controlled offsets[0], r.x, r.y and stride using uint32_t
> > arithmetic. The sum can wrap around, so a small fb->offset passes the
> > fbend > blob_size check even though the real offset lies outside the
> > blob. The wrapped value is later used as data + fb->offset in
> > virtio_gpu_do_set_scanout(), letting the guest point the scanout at
> > host memory beyond the blob.
>
> fbend is computed from the same wrapped fb->offset that is later used
> for data + fb->offset. Since fbend is checked against blob_size, the
> wrapped pointer and scanout extent remain within the blob. Wraparound
> can select a different in-bounds region, but the described host
> out-of-bounds access does not follow.

Right, I'll drop the CVE and just make is a correctness patch instead.

>
> >
> > Compute the offset in uint64_t, reject values wider than UINT32_MAX
> > (the width of fb->offset), and only store into fb->offset once both
> > range checks pass.
> >
> > Fixes: CVE-2026-66019
> > Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3871
> > Reported-by: Cyber_black <Cyberblackk@proton.me>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/virtio-gpu.c | 14 ++++++++------
> >   1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 36d2bd9edee6..d1e32840e223 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -784,7 +784,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gp=
u_framebuffer *fb,
> >                                      struct virtio_gpu_set_scanout_blob=
 *ss,
> >                                      uint64_t blob_size)
> >   {
> > -    uint64_t fbend;
> > +    uint64_t fbend, offset;
> >       uint32_t bytes_pp;
> >
> >       fb->format =3D virtio_gpu_get_pixman_format(ss->format);
> > @@ -814,18 +814,20 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_=
gpu_framebuffer *fb,
> >           return false;
> >       }
> >
> > -    fb->offset =3D ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb-=
>stride;
> > +    offset =3D (uint64_t)ss->offsets[0] + (uint64_t)ss->r.x * bytes_pp=
 +
> > +             (uint64_t)ss->r.y * fb->stride;
> >
> > -    fbend =3D fb->offset;
> > -    fbend +=3D (uint64_t) fb->stride * ss->r.height;
> > +    fbend =3D offset + (uint64_t)fb->stride * ss->r.height;
> >
> > -    if (fbend > blob_size) {
> > +    if (offset > UINT32_MAX || fbend > blob_size) {
> >           qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: fb end out of range\n",
> > +                      "%s: invalid fb bounds\n",
> >                         __func__);
> >           return false;
> >       }
> >
> > +    fb->offset =3D offset;
> > +
> >       return true;
> >   }
> >
>
> This patch does not apply to master and appears to be based on:
>
> Based-on: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
> ("[PATCH] hw/display/virtio-gpu: Remove the bytes_pp field")
>
> The dependency is not declared. Please record the prerequisite.
>
> Regards,
> Akihiko Odaki
>


