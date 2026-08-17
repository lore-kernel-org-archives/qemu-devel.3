Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E58DC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4Qw-0008Do-Sy; Mon, 17 Aug 2026 16:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1ww4Qr-0008DM-V4
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:59:47 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1ww4Qp-0007ZV-88
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:59:44 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-9349ad9c857so391907685a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787000382; cv=none;
 d=google.com; s=arc-20260327;
 b=a6XXwl91Q4i+0fR3xfOUO8gQX+5ruGP2zscu/nNOKJl1Z25M/o/gdIFfSUM73bzemP
 ZcPGXZmg8+5x/Kds7a+OpDExu4XlP+Vu7AMyDyy5z5lf59Wvx9RW4F7Ud0Xmgz7jYFLa
 da5IZseNTbfCZqWuSopSn5sAn0ZlhkNtYri/b7EJiNw2UJ5FWFUpflh97lAlX8zXvd/g
 VXHHnvNFJy9iopTr0dixGUtBEegb7Y+taHj7h3yCdNuxDMxOSm8hN/Zi6Hg+AXgrex2M
 1O9SK1EXa0Jd35CCck+UKUHZJq5Nc6m5c3fAPefWz3AQVF9GJwj/h/+9dpk0tVK6uSFx
 vwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CywJpCxBa55MICjC8H2ypNls5kl3yd+yzcdiaCO/VgA=;
 fh=v6x8tiW90eKtWR7kNflvHeIMyC+pbgQ8x5cCjmT6BsY=;
 b=mvNwvmmZnBdABKmjLWbQpWTmB+1Joj1drV2un74dCEFQmlxnGNOHLicI41OftEwK0J
 /ofhvT2KncakSTxsAGMT2isbAM6IMueIGCATPhcrFPU96loXsNvh63IKK4iEjZutP1p1
 /zBTqA0WwbuweKJrZAeBBiNXtp9TgQNSZT2i2j0wnwuBZj6JYGjYk8RfHk6+cX2ASFuS
 KgtvPX6b5R8YUIf8INICLY7sqe98I6GOjihZMJ9xr2NbNPBLe6nBn4HEZMgLielGlFr1
 1Z+hAp5Dc41GMsZXcJWD4lpq0M34IgpXwH1qSvj8Jla26ITtDoo+nkLC4Zf4hNhV2R15
 /k4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787000382; x=1787605182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CywJpCxBa55MICjC8H2ypNls5kl3yd+yzcdiaCO/VgA=;
 b=DMQ3UDIkJ7HVhDab6hQ0qxlkVDGr33x9LOaZSp86Ig3fpa2TKfG2QBmafTWp+C/4m7
 WsVJHvOduhrWO24NQFURhuABgaD66sL6aSVq6ZDbWwaiJXTnOFHu1zdZhZ/9ZqQINvS6
 JJoWyhLakPwapBhgLbPXwBtR/JnureK48pUZ5YmXfHeKOzRmmqwf45xNnsSiXymvrY60
 egNNRHatQR9DxHVehfwLQBA69E3Q6C/QNy+/oMl5g1EoC0mwS1PiCfzld75G+e6P3EpT
 RRa/c9cF+dQykvLUBPVDMgfsja7F28YvB78e60kisT4mDKAQDpOvxyCfAw/4Vk/XRj9U
 I4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787000382; x=1787605182;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CywJpCxBa55MICjC8H2ypNls5kl3yd+yzcdiaCO/VgA=;
 b=E9IkADGe9kYeawUngb0+uWyv++rqd766hV3uiOSquJ48MxWdfv1bHHuJuxe2Z0tHJ3
 uXlss9hSy9c4WU3oz6H3KEYXnmun8eJrkBsc+py4JkNXtHSrNijsrdAgbUN3mCfZil9S
 r8N8f9OV8hGJ5uHcPF5miaJuXHqyqNWXvlJevlAEgrjdGcti8YFFsaxWU5kXAd15O8we
 x0+JFiXFybbnvoJ6I28FuQHB8KupOeILzRFRXvyvXH45HbU6DwVocxzKBUcu2sNOxwsx
 BUPlyl70344R8RPpQoVag5ITRbbzRMk4FwEcYjhyoBrkRerSr8edQMkKKQoriShCx6dd
 M4+A==
X-Gm-Message-State: AOJu0YwTvF6VeGiRUW6Q1CJ/5JBJL8eav20aUZKE4sEzp7iK6Ky5iLIO
 w9qENXawsWm+Wc6Cj4ndiljXnXBjwt6TirTLvDiuA7OJRvx23puEm4vxw4scLE2OBlUfLKp26Bx
 cF1E4/ifQara4o3UuSPsEPD6Q4q5KRf4=
X-Gm-Gg: AR+sD13MO6hVI45na5X9aV9F2fzOxjomq3w/CJG1zu15tDYI4uncx3d879NO0vdpQzv
 6XUvUWYHrd0figMJ/HuxER4bNYtoV4uKsKE2sJBXntru+DGPcDRcxIfLeS0NF4hZwpv3Ahnqkc5
 WXaZLJxAMRNMBtmtbrBCOVqeS2Zbd4NqsqsImn6o6k5vjuJdJSp4yr23QR/ZXrton7c2Uq1nl8s
 eJFzIEyGgoh0XOyfeIri3PNj0nTpTInSkkC7U+qTeH9c5J3HqHRVGDV/jdRJbuTxkS1AmBzRTIi
 EMZZFHUgDnU8X+H1veox0dpyhmqbq6H/8rYwX5/FQIzsWnxbkaVl5Ip2C0OVYofWhesC3Q4V49E
 QlA==
X-Received: by 2002:a05:620a:214f:b0:92e:5cfd:154e with SMTP id
 af79cd13be357-936d2027e62mr2175714485a.14.1787000381994; Mon, 17 Aug 2026
 13:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260808153057.2641831-1-connorkite@gmail.com>
 <CAJSP0QUdZ36+oU9bHu+rYx8m03Ld7oBWjzNqKKLmX04gFqZocQ@mail.gmail.com>
In-Reply-To: <CAJSP0QUdZ36+oU9bHu+rYx8m03Ld7oBWjzNqKKLmX04gFqZocQ@mail.gmail.com>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 13:59:30 -0700
X-Gm-Features: AcwNN1V-Ezt-L04U-GmcXoTvZxxM5mK0cpICMGGdoLe-3eP2dslPsOLLnF9ozuo
Message-ID: <CA+spn3rO3+ag_raj+TDtrwarfSABcLP4ROo5_SaeH4=VVpGV_w@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost-shadow-virtqueue: range boundary in
 translation
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=connorkite@gmail.com; helo=mail-qk1-x72f.google.com
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

On Sun, Aug 9, 2026 at 5:46=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
>
> On Sat, Aug 8, 2026 at 11:32=E2=80=AFAM Connor Kite <connorkite@gmail.com=
> wrote:
> >
> > iova-tree expects inclusive range sizing when maps are allocated or sea=
rched.
> > Currently, svqs use exclusive sizing when searching their
> > vhost-iova-tree for a match to the region to be translated.  This could
> > lead to errors if the region to be translated is at the edge of an iova
> > region.
> >
> > Fix this by reducing `needle.size` by 1 in
> > vhost_svq_translate_addr to bring it in line with DMAMap and iova-tree
> > convention.
> >
> > This patch is an updated version of one from the patch series "vhost-us=
er:
> > isolated memory".  The patch has been isolated from the series as it
> > is not tightly coupled with the rest of the series.
> >
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > ---
> >  hw/virtio/vhost-shadow-virtqueue.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shado=
w-virtqueue.c
> > index bcb7f2ffc7..c8831d52be 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -99,19 +99,25 @@ static bool vhost_svq_translate_addr(const VhostSha=
dowVirtqueue *svq,
> >          const DMAMap *map;
> >          DMAMap needle;
> >
> > +        if (unlikely(iovec[i].iov_len =3D=3D 0)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "Zero-sized buffer made available by guest")=
;
> > +            return false;
> > +        }
> > +
> >          /* Check if the descriptor is backed by guest memory  */
> >          if (gpas) {
> >              /* Search the GPA->IOVA tree */
> >              needle =3D (DMAMap) {
> >                  .translated_addr =3D gpas[i],
> > -                .size =3D iovec[i].iov_len,
> > +                .size =3D iovec[i].iov_len - 1,  /* Inclusive */
> >              };
> >              map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
> >          } else {
> >              /* Search the IOVA->HVA tree */
> >              needle =3D (DMAMap) {
> >                  .translated_addr =3D (hwaddr)(uintptr_t)iovec[i].iov_b=
ase,
> > -                .size =3D iovec[i].iov_len,
> > +                .size =3D iovec[i].iov_len - 1, /* Inclusive */
> >              };
> >              map =3D vhost_iova_tree_find_iova(svq->iova_tree, &needle)=
;
> >          }
>
> It looks suspicious that only the vhost_iova_tree_find_gpa() calls are
> modified, so I checked to see if other users of svq->iova_tree treat
> .size as inclusive or exclusive. There is only one user,
> hw/virtio/vhost-vdpa.c, and it treats .size as inclusive. This is not
> obvious from the patch, but it does indeed make everything consistent.
> (It would be helpful to include this kind of context in the commit
> message in the future.)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Resending a message that was accidentally sent just to Stefan:

Yes, I think you will recall that I was also confused about the use of
inclusive sizes in iova-tree, and exclusive sizes virtually everywhere
else that does not touch iova-tree.

For clarity, is it worth making a REV2 of this patch with an updated messag=
e?

