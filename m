Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951A0C5B549
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 02:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMHqa-00014G-T3; Mon, 02 Jun 2025 22:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uMHqY-00013m-Hn
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 22:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uMHqW-0006XL-Sd
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 22:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748919466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cM7B7urnwtNcIJSjlDnca/bowSmMrJu7ceQXrTcaqDs=;
 b=Bgjy1++Fhfgswiq5cP5iyNZ7jpz8NnXZu1kOA1I1pDnhoIVulH0lkz3J3Z0qEOJhw3uIor
 mbKhOEJQo2xtRHx1mnCPZP9b82NOD2G5YdZKDoGxYi6NZ6MruK0iYR/pHm6wxRK1y9aski
 XQiNVCMxPj0a+37vk71LgG2ojL1LXdA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-yV72zFJ3NueMsDBbpEtNBA-1; Mon, 02 Jun 2025 22:57:43 -0400
X-MC-Unique: yV72zFJ3NueMsDBbpEtNBA-1
X-Mimecast-MFC-AGG-ID: yV72zFJ3NueMsDBbpEtNBA_1748919463
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31220ecc586so4357324a91.2
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 19:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748919463; x=1749524263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cM7B7urnwtNcIJSjlDnca/bowSmMrJu7ceQXrTcaqDs=;
 b=rVvrDZiuL3nLMNF8/pafvBt3NIi+MPeW3sUWzUC5PqIHbRCJFk116kf/i/pBjFJrST
 JILZskygbZrBCBiFAODFTH6Glq3RBcV7jHvX3R+tMdYFvp/6nf7zm1IYm2Hvcowf6rbs
 tRKkPhqRFc0qQ2dq4Zht9wo2A1dMfp9xp6kwrm/bOwhUGU+P/+jZV7qxOKdzZjP8R+At
 WwHa75HdWUfVS6ebu4Ys2Iizjs3VT1BlQs0YdY1v/vNmKuREJjeuxT2vdMFNyREXXUUx
 Gjk036w9qQYMdbzsUOvjHMobBJJqosiwZSnc9jHRBPGLTD/sIheUArQ7hADSUapxKhdN
 wn3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYDq0XRGQcMKzIrezdZ2jWyrmXDXilzh6Q5KGD13/m2bfs5jN0wfiCsYYCEqH0Nw/OILMMu6AYa1ry@nongnu.org
X-Gm-Message-State: AOJu0YxvUu/3GlFHzE+Ry3eF6tabX0bjubM0kHUV0INK8ycULtsWNAmo
 9//iCQtK+C95kFHSwT9Ijb4iM5QMM0Ftj0n4ltbF07Qzd4r4OUWakTMt85Lez69xmd+1h8oHaDL
 RB5IJsl6VL+WITfolSg/XVz4Dtr8MJ8Ke9Dd1nnbuHK892qLLYTIEoFewEdZZe3fxNzXDivY92x
 BIfqMqfBR9wm0DrMtIE34mnXjP98xp0MM=
X-Gm-Gg: ASbGncswVR0p6Qx9ifl+Pf1zgPJS6ajz5BVVN28ns3DHTTQjbVegAouiJal/lc4wJu6
 NhbIqCL1coUCs6cFkrzznZnyEW+jMD6+3VT6TeDaSs06ujjWzFL+kbRk+zbsgFbs4BBpEx1sKQ0
 GIuDU4
X-Received: by 2002:a17:90b:2688:b0:312:ec3b:82c0 with SMTP id
 98e67ed59e1d1-312ec3b8319mr294594a91.29.1748919462829; 
 Mon, 02 Jun 2025 19:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3So7QDPzYN8A+UpXlKNPXz6R7M6NEQKH7qz0h24LbBjWqmCYn+DrYoiUnfyeFz5ryvjYVqNcKQ/VbV/a1pNc=
X-Received: by 2002:a17:90b:2688:b0:312:ec3b:82c0 with SMTP id
 98e67ed59e1d1-312ec3b8319mr294564a91.29.1748919462369; Mon, 02 Jun 2025
 19:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250602085719.5058-1-nabelova31@gmail.com>
In-Reply-To: <20250602085719.5058-1-nabelova31@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 10:57:31 +0800
X-Gm-Features: AX0GCFvSVxW71qnTEzXup2XySAx-kLlIPRiQ-LBOQ0bMpl5-quEuDHkXxxxBhVg
Message-ID: <CACGkMEvvByArzZv9UG5auvdt5j1dhro=T_77_MhC2o6RcQANsA@mail.gmail.com>
Subject: Re: [PATCH] net: fix buffer overflow in af_xdp_umem_create()
To: Anastasia Belova <nabelova31@gmail.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 2, 2025 at 4:57=E2=80=AFPM Anastasia Belova <nabelova31@gmail.c=
om> wrote:
>
> s->pool has n_descs elements so maximum i should be
> n_descs - 1. Fix the upper bound.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: cb039ef3d9 ("net: add initial support for AF_XDP network backend")
> Signed-off-by: Anastasia Belova <nabelova31@gmail.com>
> ---
>  net/af-xdp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index 01c5fb914e..d022534d76 100644
> --- a/net/af-xdp.c
> +++ b/net/af-xdp.c
> @@ -323,7 +323,7 @@ static int af_xdp_umem_create(AFXDPState *s, int sock=
_fd, Error **errp)
>
>      s->pool =3D g_new(uint64_t, n_descs);
>      /* Fill the pool in the opposite order, because it's a LIFO queue. *=
/
> -    for (i =3D n_descs; i >=3D 0; i--) {
> +    for (i =3D n_descs - 1; i >=3D 0; i--) {
>          s->pool[i] =3D i * XSK_UMEM__DEFAULT_FRAME_SIZE;
>      }
>      s->n_pool =3D n_descs;
> --
> 2.47.0
>

Queued.

Thanks


