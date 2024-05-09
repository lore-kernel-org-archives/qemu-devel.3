Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D09C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 12:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s52xb-0003Ia-G7; Thu, 09 May 2024 08:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s52xY-0003IB-3v
 for qemu-devel@nongnu.org; Thu, 09 May 2024 08:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s52xV-0007gH-9q
 for qemu-devel@nongnu.org; Thu, 09 May 2024 08:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715257992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTfIGJcFdzJQwTmvkwZdfYxzltdUjfBTO20WHVEG6aI=;
 b=US/s2jDfhXQJ2RrFJTaNVtutnDysBqCEpoW6B6jNfdQl2fyTf/g21mFswpVZuGALTXLa1b
 zwTDaTuOi7nGgRdps4w5ZcbOo3Lnh8933+PuuVzHQDMO6X+4Z9yWtdKTN0pUc0A6ytk/80
 JixG7xTAV/b8uPeoRdl5dSkaybpFd40=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-GSn67E_rP2K0JMV58HZOqQ-1; Thu, 09 May 2024 08:33:10 -0400
X-MC-Unique: GSn67E_rP2K0JMV58HZOqQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dcc0bcf9256so1275033276.3
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 05:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715257990; x=1715862790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTfIGJcFdzJQwTmvkwZdfYxzltdUjfBTO20WHVEG6aI=;
 b=WKJCAqRGSVxoy+ikACST3cJYMwYGeOTSLTYyayTlwGvrr9aIHv+f3F3xIzCDCud8TK
 FVBzFMuivTjjdrYMSDxyPsw/As6qR8QvQbUeCGh3wjCYkOYo4OoCaZg6O8uKmakSB/t9
 5NuHem27Vx5Sy0Rqns4FdaHrlW9d8LQ4sXP9Mz6NR6c43JCe184UC2Fgujv4XNyal2/r
 FDXfv2aj6vYdzSH77/DXVeufPxWNo4/eM8Yqc+8BfoddUL59DgDxfhLg+P9/AvqMBvRc
 LQnu1IAMr6Zhh6hiJuBZJfK0wlimx5InHD0IAtHC/MyDKbjMQSVJfWHqhVpC5rXOGk5d
 LVYQ==
X-Gm-Message-State: AOJu0YwzFvahGOZ510r75/TjSask+3ykVhPbKVFYsG80UCtBDVlfWXU7
 pRu6GjylWNulMlCAFiQTbvaojob5XciUd5gkSojhIGdrqTAwCMa2iq4l2oaQbyUxEECTPaJM5vg
 mHV58cO9D2DOK+KPPk2jvDz27Uf/qYG3oJJphnT5J296iXiMhijpA41shCGiCGUhqm0lKpcBiHq
 3hgQvYcrPTNXH8JQ7n9K/3a5BPqXc=
X-Received: by 2002:a25:868d:0:b0:de8:bdd3:c113 with SMTP id
 3f1490d57ef6-debb9d88cebmr5104902276.25.1715257990109; 
 Thu, 09 May 2024 05:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHd7wVkLpRhvoT2EdR+x4C4Ic3RUl/kFAq9rPrXBfXobueUXJ7fzEZdGAgcweZtMhLXG6IqtFWL9aLe40XY9I=
X-Received: by 2002:a25:868d:0:b0:de8:bdd3:c113 with SMTP id
 3f1490d57ef6-debb9d88cebmr5104857276.25.1715257988475; Thu, 09 May 2024
 05:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240506150428.1203387-1-jonah.palmer@oracle.com>
 <20240506150428.1203387-2-jonah.palmer@oracle.com>
In-Reply-To: <20240506150428.1203387-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 9 May 2024 14:32:32 +0200
Message-ID: <CAJaqyWeitQo0rqR5+q7e1OjBF=zWHpg++cwyH3dRhaNaM6bB+w@mail.gmail.com>
Subject: Re: [PATCH 1/6] virtio: Add bool to VirtQueueElement
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 6, 2024 at 5:06=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Add the boolean 'filled' member to the VirtQueueElement structure. The
> use of this boolean will signify if the element has been written to the
> used / descriptor ring or not. This boolean is used to support the
> VIRTIO_F_IN_ORDER feature.
>
> Tested-by: Lei Yang <leiyang@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  include/hw/virtio/virtio.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7d5ffdc145..9ed9c3763c 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -69,6 +69,7 @@ typedef struct VirtQueueElement
>      unsigned int ndescs;
>      unsigned int out_num;
>      unsigned int in_num;
> +    bool filled;

in_order_filled? I cannot come with a good name for this. Maybe we can
add a comment on top of the variable so we know what it is used for?

>      hwaddr *in_addr;
>      hwaddr *out_addr;
>      struct iovec *in_sg;
> --
> 2.39.3
>


