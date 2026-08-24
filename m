Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B6DC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVML-00031j-4s; Mon, 24 Aug 2026 10:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wyVMJ-00030d-36
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wyVMH-0004W4-Be
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787580543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EaEEmJBAu+Kb2shHjmcuUYIYY3+qVjHPapvxAraAKfo=;
 b=eyXRNAcaNxpSChb/VTSJElruvQ1BRIcONufCab8C0Rl4U05hWlMEYQPo1fz0meWqT7GHSg
 /QQZ8qZmtWFKol0VKJ7ZhjNDH/6o/QjzOvaKRgLuOzdmGUp5COG+T+l+3pme+9Ex5KMb7Y
 zZhP9NePgYG3zH3TW/t/rNzEloo/a8M=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-AAaAJwIuM3OHGJNdsBaPQg-1; Mon, 24 Aug 2026 10:09:02 -0400
X-MC-Unique: AAaAJwIuM3OHGJNdsBaPQg-1
X-Mimecast-MFC-AGG-ID: AAaAJwIuM3OHGJNdsBaPQg_1787580541
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7fe835353acso63025567b3.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787580541; cv=none;
 d=google.com; s=arc-20260327;
 b=oBoNM8H5cIJHSgYfeBoMsx4U/c9u50Y5y12hUYeJg31fpLofaut8M/3wMlAzHvehZw
 Gccsrxotg/mN6Q7xG04UJg01EKEcR6mIHg+ASAP5fPo3DkyZ7CuJu499uN7AFdnPe+PN
 X2ZoYkz8yKovwVEkg3PpCrs038EwaIiKsN3JxrhGEfzclrC45pZqDpJm8ZOEvzghUtIC
 0pjCOuq/HQp1jsRvwryNwu9u7SOfAmV+8EeOJPQJx5V8iZ43TLHclU8cWa/qGZ+V5Orv
 glmhSI+e293ie7bHbz0HA6FIzB/nlnTD3hG7teV3LvBcRjytmz4BaxEjUfChlQbjBwg7
 WjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EaEEmJBAu+Kb2shHjmcuUYIYY3+qVjHPapvxAraAKfo=;
 fh=U+maFRf278azDLQbrKAGogscHVKhGWX+3xQ+8zXzxjQ=;
 b=qYmYoGfzejMQikwo9hkpOl6qbvcKMirBE3GHtIun6ifx6MlzeN/tp7eQfgwXrqXDmy
 ZwJTF/DO2Q/5zp0sk2N5Wyiq9VyWPFh46FWktAUH+jQ+zNiFMeE2RvORipRjPwiPvI9p
 MXjxUYJWP2RVRfmX8DoMPp4YI1HhNIShUL1gAqzNvbgAJjFdnrrB6xUuxdQfUF6YzByb
 2CYjpJB/JfUIuIUN/uUGEdjndk4JpFvKfb3rqROwkPvZin0crBgkYgvG/AoDS3cIGpjO
 B9ggkkjBfMmPFwE4hGgFBnAnxlhlZcX+SIco3vJcRuwfLbwxckWHJYJXcri0HpYqyjd1
 j8HQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787580541; x=1788185341; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EaEEmJBAu+Kb2shHjmcuUYIYY3+qVjHPapvxAraAKfo=;
 b=H21ZfK8ahQ5YIYngtWdGvx5mE76pYCr10QI3DP4URkLmmZ/jR8gAefrH2Wr4vHt5uh
 BVzakdCucr34Jpc20x8YBZCfj9sTDwI+pDQg916J4W8YMJtrMp9vNO7+C27BjBaRHEst
 oCmzb3HljUskCX1r3xyugNyTxkC5oQ3Wdt03VuKEwa0Cb5toA5+w/VTBBPUB/9sz/upD
 3R8Acuf8UejCYluccOQ9tGKuA36ntuOX+iqwOUb6Kq6pzBEWKfhAjARx4sg3F3sDjVnk
 AHDXxIBLCCOY1zvJFfOSgSlT3XdGR9jJ4q1NrvoE9ChNhbNF1QWuaDQ0JmoPgQ+Z1ksI
 jnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787580541; x=1788185341;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EaEEmJBAu+Kb2shHjmcuUYIYY3+qVjHPapvxAraAKfo=;
 b=gfL0u17NukBv+YM9p9U/DNx42jRlL4rUP5ohqD+cNH/vD88C9C4Syd5AgikxmkoAYs
 n3+CX9iawmS87fIW7nd4g556umN6yWjeS2+twnqZISYAGgTMHYuhTYpwHYtBk5RBqizA
 nmgEuascYqk09xWw/I9fCao+o+3kqCBH6lmb8vBbm97VSZFYNdHSWRF4omfipK1pqLr9
 SK4cP4rTxXWAAFFR8p2bIdo9eCi1it2O4qqk2kp6uJbdE05QaI4QuvnLkRUMIr/Vweui
 d5il/T5uL9vICQureNh7bu73xlSuNtmoFo78MBI7oyA5YpU9YYJTF+pht1BVzsssG5Cr
 6U8A==
X-Gm-Message-State: AFuF++lYcXBMUBtCZJiKmzQmPCkrTsWin4MeEup9sJ/E3IVl1UlGjYyB
 iSmogZRxwArjM4UdJ9unSEicDIw0qUQz+IbLMxGRgIL2mrdiTqCGehjKQgv7kXcuTKTZoUDZZ+M
 qNcjcWP9phze7OWP5XpFBxHkO5G5MMvUbA7mhmK2/iaQtopitu9bV/S7va/b4j28cx+KgO+7p9r
 JiQ15fudG4t2mCA1PbXNTuH1LzJkvWsDU=
X-Gm-Gg: AR+sD13Ptmf7gP8FJGq1I3gty19odpWj112By5MCGwWt6tYiHPX/aEV4zc7a11mSk0v
 QXIstvOAUgxDN/EsR8Seu6LhVCHPzBiIURv4Xk9G0aqw001lkj4noZ/ShqYIgj1AJdZMaKrHzwT
 ZYI76PJCvmBS1SGIHyLgV7wOMTWHH0BazaUs2yaE9NPgymeudLiKwKePRA72M9fMdgITS+SlLki
 g1OZiqYvvNsCH0KmUI91LVKwNGGirHu4SP8eNWd5UgKWS0doO4HohT5Z1g=
X-Received: by 2002:a53:a3d1:0:b0:66c:bbc4:9fb0 with SMTP id
 956f58d0204a3-66ce49d5549mr7283729d50.2.1787580541318; 
 Mon, 24 Aug 2026 07:09:01 -0700 (PDT)
X-Received: by 2002:a53:a3d1:0:b0:66c:bbc4:9fb0 with SMTP id
 956f58d0204a3-66ce49d5549mr7283703d50.2.1787580540868; Mon, 24 Aug 2026
 07:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260817233147.2867623-1-connorkite@gmail.com>
In-Reply-To: <20260817233147.2867623-1-connorkite@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Aug 2026 16:08:23 +0200
X-Gm-Features: AcwNN1WkXTeP8AndaKnDFMUSC6amiGfdmDwqFMcXJ7oCnfo_O61OXR2b1NzcuKI
Message-ID: <CAJaqyWc=Ge0P=J0W6mrt56kFuG-iceCpPo4=5M1xFC5cWzNOhw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/virtio/vhost-shadow-virtqueue: range boundary in
 translation
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Czenczek <hreitz@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Aug 18, 2026 at 1:32=E2=80=AFAM Connor Kite <connorkite@gmail.com> =
wrote:
>
> iova-tree expects inclusive range sizing when maps are allocated or searc=
hed.
> Currently, svqs use exclusive sizing when searching their
> vhost-iova-tree for a match to the region to be translated.  This could
> lead to errors if the region to be translated is at the edge of an iova
> region.
>
> Fix this by reducing `needle.size` by 1 in
> vhost_svq_translate_addr to bring it in line with DMAMap and iova-tree
> convention.
>
> The only current user of svq->iova_tree is hw/virtio/vhost-vdpa.c, which
> also treats size as inclusive when using the tree API.  In progress work
> on vhost-user isolation mode in hw/virtio.vhost-vdpa.c also uses
> inclusive sizing when interacting with the tree.
>
> This patch is an updated version of one from the patch series "vhost-user=
:
> isolated memory".  The patch has been isolated from the series as it
> is not tightly coupled with the rest of the series.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

I'd like to improve the patch subject by adding a verb and the object.
Something like (*add* range boundary in *vhost svq* translation).

Also, adding the Fixes tag,

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thank you very much for the catch!

> ---
> V2 Differences:
> - Context added about users of svq->iova_tree and their adoption of
>   inclusive sizing
>
>  hw/virtio/vhost-shadow-virtqueue.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index bcb7f2ffc7..c8831d52be 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -99,19 +99,25 @@ static bool vhost_svq_translate_addr(const VhostShado=
wVirtqueue *svq,
>          const DMAMap *map;
>          DMAMap needle;
>
> +        if (unlikely(iovec[i].iov_len =3D=3D 0)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Zero-sized buffer made available by guest");
> +            return false;
> +        }
> +
>          /* Check if the descriptor is backed by guest memory  */
>          if (gpas) {
>              /* Search the GPA->IOVA tree */
>              needle =3D (DMAMap) {
>                  .translated_addr =3D gpas[i],
> -                .size =3D iovec[i].iov_len,
> +                .size =3D iovec[i].iov_len - 1,  /* Inclusive */
>              };
>              map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
>          } else {
>              /* Search the IOVA->HVA tree */
>              needle =3D (DMAMap) {
>                  .translated_addr =3D (hwaddr)(uintptr_t)iovec[i].iov_bas=
e,
> -                .size =3D iovec[i].iov_len,
> +                .size =3D iovec[i].iov_len - 1, /* Inclusive */
>              };
>              map =3D vhost_iova_tree_find_iova(svq->iova_tree, &needle);
>          }
> --
> 2.43.0
>


