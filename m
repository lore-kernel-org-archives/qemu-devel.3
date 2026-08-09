Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B400FC5AC80
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 12:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wt2vQ-0005tn-SA; Sun, 09 Aug 2026 08:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wt2uu-0005sg-0p
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 08:46:17 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wt2us-0005lN-2O
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 08:46:15 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a1ff91dcedso990588a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 05:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786279571; cv=none;
 d=google.com; s=arc-20260327;
 b=DK6KSq/S1JbIJt/eo9Mkc6Cjy0ePzsd7gCTsMcwLh5vYrFru+artHunX9vEK9SoKOc
 t6RC8+moQrR+w4TSSDDZ1NuuI4+2vspdlgU1iBl9BObmgrz2P5lMLawgYhJkAerDggmt
 JV+6lw8qAUfAZ6FzPG98rEsuvA9OeRFo2Vq6lPGzY35bETBL7VqeVBSbSoi1HUAuA0dQ
 rhDmFMtmrZrvLqbKTm/jBWnSbW+L/SgnfvmP8MIY5d2iHyWcB6kBoOW7ikTC+dPE/U79
 9u5dRBb8Tl9qTNeKha2X18a1h/JogQF0Z/TSVyrCc453imc1k44NS2bq0IBX4PB4rcPi
 vtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r15bdyU8hRDc4yZd2Panpn71XRkn6Lst+ZGNfZ1X72Q=;
 fh=3pkPCiXOkslMbNex4Wx2fOXwhuRdrSGrH7jy67RKzT4=;
 b=ZI/um9fnjP5bmlAM/Utol/v0+HdoCZuWMIlgEU46OP+OovnFgzCNvUURM5jX1v0blp
 N+1aI+CkMO7iuYezUGvZghDKA17arKtFkdX3EnhjFrO5PgmgSPEQB1BiDh78+9vlkfW2
 CbXUYRvgqFVFUJ95eMUbryaX4227cURlKDHWWK1IV9iHIDodahqq1eSX4nz9OqzytkND
 x1zbR8MN9jl94ml8TLTikYYr6v4KpPFeGUW0ZlF9RJFU6R3zbNuVcDIzDNtgkwPpGsX8
 nG/dUoC9yIIBhMuc1N3ltGEBxyCGhRZVvCR6lRDe5GnAAfMx0MKDjuBpC1W3dIdYIOqB
 6G4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786279571; x=1786884371; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r15bdyU8hRDc4yZd2Panpn71XRkn6Lst+ZGNfZ1X72Q=;
 b=S54qgBY0xEu2WkyVV9BhNr9cfLJg3QyPZfIEf5sb3UheAj5QjUQC6SZyyYbTN/VvRk
 PSCYtvvNtRT3ThErgk7DjEm2Ldb7BFYMl+stx1zBolEe/17bmx9L/4w1Wpq5gvAZewKs
 BvE47YEsr4XUM9xSwAI1qeIF9FGhbKMhwbfTM3SjhSaRKec/HhhkQIf0er7VhG5MfZn9
 1J4utRbh549aE1rSwuCfFrELasqxAxT3KI2o1xHmf8imSlHUj4nWsu9wef4K11cHEhnr
 Q7A0Z8uMUcv1IB556tvT8LkDF4NsCvPDiS0OTCsqMCdPxLTNaNME0LmUSkx8RVwOQEZo
 btlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786279571; x=1786884371;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r15bdyU8hRDc4yZd2Panpn71XRkn6Lst+ZGNfZ1X72Q=;
 b=OMIoXglCNBgXnaz8J7Vx5LSIWhbuxZ8b2nQoD/tVnbbqSdwz70Aof7i/26gqIyUCB2
 /hqofoRyrQQXnpmgKJoqYYV1KtNIKbxi1aOK1KVdTB9RbipN4BwGwyeM4Pk67NDnMjX1
 KoYGrL3+3crn0WD/+nUFg1LY1Vf5vtfyWX5HLI26+p+Xk+wjM0OMiabHhS5ALP3qPhi/
 dct/s94+kGtz3zYyKp3YO86jo1MgO1qxcSTkZ5bmm+/OB1VewUqOFMIpTF/nNxpcIIxE
 Zj0pnu7v68h6a0gBfz34Ie6pMwkFYTnry5qfmN4Edv6ILR28ms9AxlfkWOKNi7YoQMqY
 gXog==
X-Gm-Message-State: AOJu0Yy1BE0Cdl+t2zmmmmoijRTFyHtfIyA4/LbQzZIZ7RxNh6TUv643
 L5CmT1pfXEtWgA2cpAcIPHiEkpGib2o9bOqZtVGu2rX85ckttnZdIST4K7ZckVYwrzKHltkgCzL
 KlUKcSyMZdrrzoOZ4cHa0IzHq/+AjMQM=
X-Gm-Gg: AR+sD11WSTMH2VNKLTS8LsH8JTj/PVD+wTumbp2QCmpADAuO5Cr5zVZZC8PE0V1d8GS
 0hK7EqlFt9AAzbH/xH7RFEuVSeU3Sovm5gyKk7dRQdM6KhcOkG/8H7ZOeLTSfsoubJHRqrvtsxn
 9Zi8IqORTtMJDuivRyoh55q2Jr7JTo+k8j+TEA1IC3fei3OK4/l37c6zW0JrLvwJwGAJ4zYFyw0
 wqBUJOWmpvffeAFgoh40qdmlk6IKtlDTqHhFgJr43Um9A1lvPdtpeyvXhOw8F0vBUWbbfuEgSi7
 2dD8G+WwzuaSEdLEYdNLhf2/riFf78nhF1JSFIp0tfgYx0ci29deLmzk8mLAPR7SIOnKYMpMg0g
 0hw==
X-Received: by 2002:a05:6402:1f85:b0:698:5610:76e5 with SMTP id
 4fb4d7f45d1cf-6a1e5ac27b2mr8510398a12.6.1786279570751; Sun, 09 Aug 2026
 05:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260808153057.2641831-1-connorkite@gmail.com>
In-Reply-To: <20260808153057.2641831-1-connorkite@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 9 Aug 2026 08:45:58 -0400
X-Gm-Features: AUfX_myI8ddcrsS-WYr1bX0Kpl5mbPSH0W_l2dNZXFdWT9ey5ndDRQsKJ20YW2k
Message-ID: <CAJSP0QUdZ36+oU9bHu+rYx8m03Ld7oBWjzNqKKLmX04gFqZocQ@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost-shadow-virtqueue: range boundary in
 translation
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
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

On Sat, Aug 8, 2026 at 11:32=E2=80=AFAM Connor Kite <connorkite@gmail.com> =
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
> This patch is an updated version of one from the patch series "vhost-user=
:
> isolated memory".  The patch has been isolated from the series as it
> is not tightly coupled with the rest of the series.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
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

It looks suspicious that only the vhost_iova_tree_find_gpa() calls are
modified, so I checked to see if other users of svq->iova_tree treat
.size as inclusive or exclusive. There is only one user,
hw/virtio/vhost-vdpa.c, and it treats .size as inclusive. This is not
obvious from the patch, but it does indeed make everything consistent.
(It would be helpful to include this kind of context in the commit
message in the future.)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

