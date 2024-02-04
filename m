Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC866C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 01:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRPz-0001oi-SN; Sat, 03 Feb 2024 20:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRPx-0001oZ-Ra
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:35:33 -0500
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRPv-0005pZ-27
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:35:32 -0500
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7bfd527d443so138164039f.3
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 17:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707010529; x=1707615329; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XWJWkzhsYGpY8WiBg8vO0Z53XrmPgRJdp/m+zBnXpk=;
 b=VKLjtKdSvvkXqmj8mfXJOw/rcUsiK2zGQm+SXH7Dunxar4wFVGdAy8HG8HP3sJF+ZO
 2X6Hzkkyow4ZrV1o/9gK96YhbEOcRwnJqHlK6JLG5RcyQEBoOkMgMngbKOqCdOI94cSD
 hCdM7SMQmJKw7NbetLS/ZViH1qp+vTL5bZIGPgh7XKUolV2JJ8NVC95BlpUD9+MHNUsv
 BrWrZAOYDoTY2NR+td4Cujv1++5A8ifPlUTyYJac6kQkwtg65m5LmoMAUTvBFdr5rTUW
 Veisgw2fovPNPU0/loh/7XinkfgoHhSbBX/aozSVtWjGq32iSdjIQe6qCTFoplp1UlA+
 sMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707010529; x=1707615329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XWJWkzhsYGpY8WiBg8vO0Z53XrmPgRJdp/m+zBnXpk=;
 b=shSaGfjrhwVjC0BiNR2XjNkGweGGfiQRtzsQPmJTrJg1a38653AAE/HjtpqOvwUIPM
 +AF2uiqlJgA/suybHsE/CiGfdbvJkDB/endYoiruSzhAHBky37CXS0S1obNWhnReRFKy
 fMkdRtGcGphQddRYMblFxrlSD85sb/ONo0FrHDtsXzHQv47jeO+QNfufNvdtDG23jm0U
 0aR76X4tzhDPrptEZQ5FTtfwIU6pUxJlkDXZaVdmfz6t05pZcfAv7/ViCKq4kCCcxFad
 5CoBnDhvxR+lkJ/menIn5z4jpaPMreY5E7YBRCGRHh9b8YOmR5LVaRkB1f2y4BqDWVZ4
 Joxg==
X-Gm-Message-State: AOJu0Yyawa7GzsKOhgLXoNEUC6tMFsKxbNrherWFDU+4OCajNrgVlbKq
 Rw/CaE+ycEOH5DbLXtWuy4cK+5B3ccVTej8F+gicqi9DeL6p5o709JuOMqkeEo2A+mDhb6S9Ptx
 YYussI6ECsdW+0jdTqIC4xLp09+E=
X-Google-Smtp-Source: AGHT+IEmuxcDQkoMbu3DTmd7mwfy+L+0SiAVmpONx7sn4oyl6UxnZ7J1ua48x/YB1A60dw7/WMFoy8axyxjXtlGuZ3E=
X-Received: by 2002:a05:6602:184b:b0:7c0:3353:3112 with SMTP id
 d11-20020a056602184b00b007c033533112mr10224637ioi.5.1707010529303; Sat, 03
 Feb 2024 17:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-2-david@redhat.com>
In-Reply-To: <20240202215332.118728-2-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 20:35:18 -0500
Message-ID: <CAFubqFuiQ5vEzELv0_y2+9KwhLDs3mNJQXMfeR4_YFMumo-x_g@mail.gmail.com>
Subject: Re: [PATCH v1 01/15] libvhost-user: Fix msg_region->userspace_addr
 computation
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As a heads up, I've left Nutanix and updated it in MAINTAINERS. Will
be updating it again shortly so tagging these with my new work email.

On Fri, Feb 2, 2024 at 4:54=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> We barely had mmap_offset set in the past. With virtio-mem and
> dynamic-memslots that will change.
>
> In vu_add_mem_reg() and vu_set_mem_table_exec_postcopy(), we are
> performing pointer arithmetics, which is wrong. Let's simply
> use dev_region->mmap_addr instead of "void *mmap_addr".
>
> Fixes: ec94c8e621de ("Support adding individual regions in libvhost-user"=
)
> Fixes: 9bb38019942c ("vhost+postcopy: Send address back to qemu")
> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index a3b158c671..7e515ed15d 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -800,8 +800,8 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>           * Return the address to QEMU so that it can translate the ufd
>           * fault addresses back.
>           */
> -        msg_region->userspace_addr =3D (uintptr_t)(mmap_addr +
> -                                                 dev_region->mmap_offset=
);
> +        msg_region->userspace_addr =3D dev_region->mmap_addr +
> +                                     dev_region->mmap_offset;
>
>          /* Send the message back to qemu with the addresses filled in. *=
/
>          vmsg->fd_num =3D 0;
> @@ -969,8 +969,8 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserM=
sg *vmsg)
>          /* Return the address to QEMU so that it can translate the ufd
>           * fault addresses back.
>           */
> -        msg_region->userspace_addr =3D (uintptr_t)(mmap_addr +
> -                                                 dev_region->mmap_offset=
);
> +        msg_region->userspace_addr =3D dev_region->mmap_addr +
> +                                     dev_region->mmap_offset;
>          close(vmsg->fds[i]);
>      }
>
> --
> 2.43.0
>
>

