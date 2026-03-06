Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9994DF513E9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyLpi-0001B2-Hg; Thu, 05 Mar 2026 22:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vyLpg-0001A8-8x
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:26:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vyLpe-0003RL-HU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772767589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P3Fau855G29AFslmbvbVqulj3qfM2dkSlQcwtLq+bUM=;
 b=Btlv35NfUfbw+CFbgo9G/t6yZkVJNk6fthg8rSjbjFzg3qL5nuO8gs3NupzGQo2Q529sbD
 axOvXL8jM+eOhPyQ7bz580B4IRopJPbloxhEoMVBRjjjxUAKNO9Z14b+ZymbS24kddRPPL
 bbFqwsxjf//X29z9JxyzXSC8giQ6pjU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-3kaDiQUKMxyBwxb7A-a0RQ-1; Thu, 05 Mar 2026 22:26:27 -0500
X-MC-Unique: 3kaDiQUKMxyBwxb7A-a0RQ-1
X-Mimecast-MFC-AGG-ID: 3kaDiQUKMxyBwxb7A-a0RQ_1772767586
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so5540258a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 19:26:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772767586; cv=none;
 d=google.com; s=arc-20240605;
 b=WsH4Iex3ROQ1soGuvp4AxgaZSdboOaGXNGMqzmK2LLyZg898zRjwqtCcHf+iR6ZVb+
 9Hpwo7X+1aOIsc/DbOjbKE62QxTZUb9THh23gVxSPW/g+Kv+Wm13llVbNiTJLMny7UCt
 mOr3FWwFDkkdly/E8mA7eAUjQtUGebm+OzIB3D0pPU7k+q1OIsvaXqN9Z1OR+Hlv45SF
 goxGZTe6R14dnNDAKbtNOSJckOaR2/ANmsDLCllWGE7I7M/yujzs0+PZFXfV1PsytI0x
 FtuA8EVHxGWdyaQcvNYK4znai2TrUiHaJRsliBYIa8tB07YjRmRqjXBD7rXpv4GHL/8N
 R+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P3Fau855G29AFslmbvbVqulj3qfM2dkSlQcwtLq+bUM=;
 fh=9rCAgRZzFqNjR/wNTxyQXAt8YRB1AGR74dADh0tp4w0=;
 b=AkMbAZg6RLTNT/DZrfDSf6NNXQjfr5lBa2og9ktS6g6/Ocxu92Wa+63BiAzLGhUvXX
 fL1nw/l4QQ3vZeugkirrje67mUO9wOMbv/NWvJ5RR5J+mHDNhmD+ZIW2Vtta/ZDOorcW
 Wegbb9yIOiqN8AeEJ1Qk60uJEPyaef3cBf3dKVrzhAwQ1/Sk8zk0/z4qAQ+FyMlF2Svp
 n9/UBosdk0lDJRa9LZYlSwc158MY7X/xws6YYuMy5mbLxA1/7XTbmurAWQYrTsvWlkN+
 3u1NXsFYsi1TgjAKGWrT8okE03HHhuhGOxGk0HLVtQ5Ldn9zfGjCHrDudJfOMPaO3V9Q
 om7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772767586; x=1773372386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3Fau855G29AFslmbvbVqulj3qfM2dkSlQcwtLq+bUM=;
 b=pL+GsCpu+FeL4V1uNVAKjE0wVxmKyAqh9FtirOwEuG3XbwjRqlt07LAjAFnjz9BfoP
 ZiKnzYfrW1NzHXj4MF+xcM2d2qM0rmD5nwNFuV99mRv/UujZO8r4tzNT2ubu2gdRSdl1
 lQKZ/aubYxqZbd1tf1yFCjxEqPp6acypL+phAzEMQynsBzl9hRpW0tgaKyWSx7bhB+Vy
 NPsmrxSjYHrdJaIcXIIzHZItpCsToZ+E9arDbG9vHFln2iKmSIRZa3n556EyKkfl11z0
 QMOEF0rzHeL/NChy6uC1k2EfVdE9Aa1paX1qwIBZmveu7w+BEwpLs8/dv3uU3vOgcpNt
 GCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772767586; x=1773372386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P3Fau855G29AFslmbvbVqulj3qfM2dkSlQcwtLq+bUM=;
 b=uMtUvb7ng3vMa5PWtCOzrQ3BSEmLOE3gdO2iEHSwiHvnWSGzeBSrcTB42YYp7AYcjH
 yGVVlRlHbnPmvOuL3Dp35xggu3lr7ksLqv8xMy1rmigbb7gd7FXm1QuMexqfaun62Lag
 zruAXXpQMelmCfZ1TL7sQDuikHz/H3MF2e8fJ9kiBb/JursI04x59cy82C68nUZTWWnP
 eoMpy3HujJzYCiiw7g250jas4ATQYvLonanajyhMWQF/6YwF3I4CVHuSNC0IhuoxX3Yc
 p808rM6esDjZnvPZfdvlChwSMWUpGJPwCqOdQCmJxVjbeACu9Ip0gPVLHQhRwjbawrEp
 6rTw==
X-Gm-Message-State: AOJu0YxpsVZOFrpysGSUMXdHFXAAaBvFamlgpB+SPBA80j/PVe0OfC7g
 wheAVwDAfHyrxCpM1f1Rf3UoKWfUlLPdSX7hRdkDM+Su664hJjitiATzKBK0w+kSVI/v9sCjqy+
 38yK4/Ld2rBpidN0vt19JqVrPuzulgC5kyfGDq4b8EEaoQxaYD8jf10roO5axl22Xn3rfihpb3H
 RQ26LW2KL6IRb6NDqKcjg6k/txd+1SGjY=
X-Gm-Gg: ATEYQzw0MGN5bzu7oNhuve5EHYaWrdNpmZVrCs0U1VOhpzMcUi841s5djfzit0H93/c
 zYtWoIwP9wjSPnRmJQ7q99zg9Cj0MRC+pr/q3j8lJU5Joa08XkGvbTpNt6aIEc2ovRjpgGMJRc2
 FUVNdxQNKJXYtZ9SwrwyEdKYcWU2jB0aAnP+pfxfMq9PviuD1lmPA0Wi1nwfiN20Cna2AEmpqi6
 t8vjORw
X-Received: by 2002:a05:6a21:730b:b0:38e:9ae0:3d5f with SMTP id
 adf61e73a8af0-39858fd70b4mr856678637.17.1772767586337; 
 Thu, 05 Mar 2026 19:26:26 -0800 (PST)
X-Received: by 2002:a05:6a21:730b:b0:38e:9ae0:3d5f with SMTP id
 adf61e73a8af0-39858fd70b4mr856653637.17.1772767585917; Thu, 05 Mar 2026
 19:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-2-eperezma@redhat.com>
In-Reply-To: <20260304173535.2702587-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Mar 2026 11:26:14 +0800
X-Gm-Features: AaiRm52Ii892xfWLC-V1TYU8SJp9arhhg-nvtndoEbzVORxr1WotUqvYFmTkDiw
Message-ID: <CACGkMEu5BGgdstpEVw8eH+wmXhi+nFdHRW2bXk7enZtxbAdsBQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] virtio: Allow to fill a whole virtqueue in order
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea DE <dtatulea@nvidia.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On Thu, Mar 5, 2026 at 1:35=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> As the while steps < max_steps is already one less than the vq size, the
> right maximum max_steps variable is queue length, not the maximum
> possible remainder of % vq->vring.num.
>
> Fixes: b44135daa37 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER s=
upport")
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> Personally I'd just remove max_steps and let it be vq->vring.num, but
> let's make the minimal changes for now.
> ---
>  hw/virtio/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index e9d553295257..17f171551892 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -980,7 +980,7 @@ static void virtqueue_ordered_fill(VirtQueue *vq, con=
st VirtQueueElement *elem,
>       * We shouldn't need to increase 'i' by more than or equal to
>       * the distance between used_idx and last_avail_idx (max_steps).
>       */
> -    max_steps =3D (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
> +    max_steps =3D MIN(vq->last_avail_idx - vq->used_idx, vq->vring.num);
>
>      /* Search for element in vq->used_elems */
>      while (steps < max_steps) {

Not directly related but I found that the virtqueue_ordered_fill() and
virtqueue_ordered_flush() can "emulate" an in-order device even if it
isn't one. I'm not sure this is good for the device that can benefit
from out of order completion like block devices.

It seems the correct approach is to let the device decide whether it
can operate in order, not the virtio core (as vhost-kernel did).

Thanks

> --
> 2.53.0
>


