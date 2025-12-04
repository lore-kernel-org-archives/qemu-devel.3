Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5800D1D88F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4Cg-0007FT-2d; Thu, 04 Dec 2025 02:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vR4Ce-0007FA-SS
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:56:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vR4Cd-0004vI-1Q
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764834997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kehcljs8cYZ9EDoWzSOP+JfWuHQqxe9siq9MeA9gtck=;
 b=a1IK3j7/0WhwQRcjgaz4a2mL/MehjOzSjop2ob6Icj+0K8xBZtVzqKDxfbzKBUO3PLCHRH
 oY2XlSMCNbunYkmyA6s1yWwy+t9wFPXVJ+nG6ps1nJWvCx5o0uOxrAJdCExtFhaJTho/H9
 OJToBgGcFPmoGyFJsBXVDsn9j+B+UDQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-sW1YlfuaPkyC-23FAkgTTg-1; Thu, 04 Dec 2025 02:56:35 -0500
X-MC-Unique: sW1YlfuaPkyC-23FAkgTTg-1
X-Mimecast-MFC-AGG-ID: sW1YlfuaPkyC-23FAkgTTg_1764834994
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3437b43eec4so910005a91.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 23:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764834994; x=1765439794; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kehcljs8cYZ9EDoWzSOP+JfWuHQqxe9siq9MeA9gtck=;
 b=tfZFJVMNQhXsWBqc7ViF2KRDiO+ePWuUYG/t6JYPO1b1WeUqiWoE/A3J9JR9tGYXTP
 /DOqc7QWemrjbkqrx5DRRxjAAkYTpDC52fE7HkRyAxUQWzvrL2hpPyZjZpVUWgzeJWoB
 mY6u47VeXkPLH6jwAO1m8eRvWcvwxGnhEhfK/SaiXbmGdytkNo1Ab44k5w/TzkOof0wM
 i3BVjAJ2/3jHP96VMjWlGtUoxszGZ88U/lMNCTkyLta3x8C0eaeF1TI2R9qBi4Ag1Clz
 qzcMIVCrYClgry9KOgSG59k+ZbUS6SQOBFOwhLC/Q5SseDkEEDtuXkZ+kc4dXCB0cTk9
 H/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764834994; x=1765439794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kehcljs8cYZ9EDoWzSOP+JfWuHQqxe9siq9MeA9gtck=;
 b=qI+JvdPLV8ZrrlL/K4L01prZnJx2pXTUm3KzqjHiypeIg0MC73Eec62Wp98ZNGwsQu
 W2RiSyzGDdE/tJnE/GTBu6fZ9tQ0q92hP+p9uJBndZtjIkITotdNFhI4a+PqXpXEn+uD
 GAMoPGsFnfWGTCVDnshNxzwZh0nXDhmDy1WOfvN4sSxmMegwgi/P9dlz8baqJoHzqVmI
 J6IvF1ONh+pMJTAUzcck1h8KM89OHQ9h3XqdbfFiDZRE1QtbCXT2sj1q3kEuYflNmyRK
 vsg+d9KesasUbVFMP+I7rumnu+RkpTQ5EnSCWDn3Y05fps8T0cLNpBEqB3ghTMNvGUw/
 eO2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRJbqAlNSHaXVRfBtnOGKL499N7taPsm57y+8M41y/L0VPGgbxEgbX+N8Wmqapf4vvz+PdpxBr8DWh@nongnu.org
X-Gm-Message-State: AOJu0Yx1JrLIP11PaLRWPSLsxjzx5/1pDhuiKpnXAQpKkg3Hokgp12nD
 yw3x7FTE5gC0dA0y3eEVoRaAV368KYFxnRxWGCDl9btAJ+l+CM7yf/xXbaCQjsGnAf675ieFqhB
 +bWEAeJ0Nj4WRv4BFrxNZTW+8i7zGJEYuNPbSF9RDEQaegqTRSsMST5WTfeDaDABBwAY1z3y1oa
 SWRcof/ygrbgpf5slO4vDSFu0PlqfYi9E=
X-Gm-Gg: ASbGncu6DgYJ+WGLFInYl/Yv0bGb1rNVj37V/kJCbC0c+Ti1+Xi/Hu/tcORl0Cjo05e
 TBCipc4qUT+/+rOi5y32RnN7/WarSIwDihyDs3eFW6o+klaeu3CwsCIsFLYtMzaDGC9dGb7q/dI
 7bgzm7NJuIOf+fjoT1n9K6bjICYsALQyasanvksEyXtWUoaO2BmVlMaFakJ9ey7nQYag8=
X-Received: by 2002:a17:90b:4b91:b0:339:a243:e96d with SMTP id
 98e67ed59e1d1-34912713809mr5344194a91.36.1764834994219; 
 Wed, 03 Dec 2025 23:56:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmfyb8nkXO4nNDCC1n79pa23r893mek8tMLOhO1n0Kn9J3oID7CdGaMOrsXAGWiFUmiSfU385EoBDV9t5+S2A=
X-Received: by 2002:a17:90b:4b91:b0:339:a243:e96d with SMTP id
 98e67ed59e1d1-34912713809mr5344175a91.36.1764834993818; Wed, 03 Dec 2025
 23:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20251204073750.8953-1-wafer@jaguarmicro.com>
In-Reply-To: <20251204073750.8953-1-wafer@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Dec 2025 15:56:21 +0800
X-Gm-Features: AWmQ_bljAVPnIqGaTi_XUhwhXXVSG4Oh2FJNRJfbJh6R0S6OKLqr058bUUhZWwU
Message-ID: <CACGkMEtsPO+aAk2cMCE75_RjWFGedHdfMr0NmX5hR7MQophJfg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add Split indirect descriptors for SVQ
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 4, 2025 at 3:38=E2=80=AFPM Wafer Xie <wafer@jaguarmicro.com> wr=
ote:
>
> This patch series adds support for VIRTIO split indirect descriptors.
> The feature is VIRTIO_RING_F_INDIRECT_DESC.
>
> Eugenio hs submitted a patch: vhost: accept indirect descriptors in shado=
w virtqueue
> https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg00056.html
> Therefore, this patch must be applied first.

I may miss something but svq can read indirect descriptors even though
it doesn't use indirect descriptor, that's sufficient for making it
claims to support indirect descriptors. That's what Eugenio said in
that series.

This series could be an optimization on top?

Thanks

>
>
> Wafer Xie (4):
>   vhost: add data structure of virtio indirect descriptors in SVQ
>   vdpa: implement the interfaces alloc/free for indirect desc
>   vhost: supported the virtio indirect desc of available ring
>   vhost: supported the viriot indriect desc of used ring
>
>  hw/virtio/vhost-shadow-virtqueue.c | 224 +++++++++++++++++++++++++++--
>  hw/virtio/vhost-shadow-virtqueue.h |  57 +++++++-
>  hw/virtio/vhost-vdpa.c             | 130 ++++++++++++++++-
>  3 files changed, 395 insertions(+), 16 deletions(-)
>
> --
> 2.34.1
>


