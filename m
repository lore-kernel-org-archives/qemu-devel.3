Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27293D3B7CD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 03:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFQAM-0006X6-Is; Sun, 24 Nov 2024 22:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFQAL-0006Wy-W5
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 22:53:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFQAJ-00014D-Mk
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 22:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732506812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0Y7tdWbrSt99vbHd6v2eCBA0wvTSpRlZedaY/6YdiQ=;
 b=cJ4QKKQFitOe/3r7BlGv5Vq6rcdycCRpI9DKaLSbeRffQxhoBUq0HgkibLR8JjqxDOXAx7
 /dG+P2NP/F3nI/trDd4GEVhLJJiBKUI2SFC0xUdVP+MM22FdG9sFW0qtv1cmW6mUzJu6kH
 kGseNO3eayeprV5D+6jHHrj6KmAF5GQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-2IssIjMXPt2jpV4m8dnFOQ-1; Sun, 24 Nov 2024 22:53:26 -0500
X-MC-Unique: 2IssIjMXPt2jpV4m8dnFOQ-1
X-Mimecast-MFC-AGG-ID: 2IssIjMXPt2jpV4m8dnFOQ
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ea3c9178f6so4031997a91.1
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 19:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732506806; x=1733111606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0Y7tdWbrSt99vbHd6v2eCBA0wvTSpRlZedaY/6YdiQ=;
 b=rZFJQYGLegfXUtUH6c5I4cPtmDqDk6qwnCrKcBx64nyqp16atbWI0pSotVdk+mLqYM
 1Y/inv6hF074hE2lyq0F1Y4oDzkVi0ugxFME8s33uHnV6jGQM1TcSui2T2yoE7AoWXId
 YzpEXYnu2yO1yMnJAFmE3CXsRZ/T0uIzA6/4SjXq9dWrvFFgTB4A6s4lJETzsFDCTnCH
 C6hr9anNvdQ7lXJa55dtydqUwX8FbR0VkHNPi0N+1M292HcfgVOzaLFanG2YsrsY9n8w
 HUQ+QmbrUAI9Fen8qjkS6R2+fTeWNKO2ubf8K6vvK92mCGzt9LXCbY5GY7GHbtndrzBl
 SX+Q==
X-Gm-Message-State: AOJu0Yzx74lGLKbO4mtKIH/4BUsHmvqFbQpxktqFAx3relvP2cegiOP9
 iMJebSefAIwDJJQwTYDsW6TnOU5/1cMXhL3GXRbOBco7e/wYaX0Echr6cDk6TYxXELRES/uKWAd
 zNomRCZ5B97Yk2ipqHPDHv1TyAieaZ+vuaJ04CXhd+B4W0W+lAayNrH9wux+AP5fGov8vMqHONG
 s+o+GstsijEGrnyOOeF9cRM0uzZoA=
X-Gm-Gg: ASbGncuJrkSpSGrhcXcgFP6BsZgQt9QIkYRvmYBWEtZVDMcxHka3V/MYZHAu7jXz4QN
 d0RURn67mA+sXKYf8WVUqbyd/md08jbbE
X-Received: by 2002:a17:90b:224a:b0:2ea:aa56:4b0 with SMTP id
 98e67ed59e1d1-2eb0e1269eemr14840021a91.3.1732506805890; 
 Sun, 24 Nov 2024 19:53:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ0ub5XuZ1KUv2pTlMzQdSQS/4knXbKDhvuXST0050/9NsCb9+gQHwIiF+smCnZlNtp8mQP66Em7uMjzuxzzc=
X-Received: by 2002:a17:90b:224a:b0:2ea:aa56:4b0 with SMTP id
 98e67ed59e1d1-2eb0e1269eemr14840005a91.3.1732506805433; Sun, 24 Nov 2024
 19:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20241115080312.3184-1-zuoboqun@baidu.com>
In-Reply-To: <20241115080312.3184-1-zuoboqun@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Nov 2024 11:53:13 +0800
Message-ID: <CACGkMEuo1-AMwUnBZ49Xme2Q9qNeNSagEgzSVMQZjqX_Y5ffEg@mail.gmail.com>
Subject: Re: [PATCH v2] vhost_net: fix assertion triggered by batch of host
 notifiers processing
To: Zuo boqun <zuoboqun@baidu.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gao Shiyuan <gaoshiyuan@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Nov 15, 2024 at 4:03=E2=80=AFPM Zuo boqun <zuoboqun@baidu.com> wrot=
e:
>
> From: zuoboqun <zuoboqun@baidu.com>
>
> When the backend of vhost_net restarts during the vm is running, vhost_ne=
t
> is stopped and started. The virtio_device_grab_ioeventfd() fucntion in
> vhost_net_enable_notifiers() will result in a call to
> virtio_bus_set_host_notifier()(assign=3Dfalse).
>
> And now virtio_device_grab_ioeventfd() is batched in a single transaction
> with virtio_bus_set_host_notifier()(assign=3Dtrue).
>
> This triggers the following assertion:
>
> kvm_mem_ioeventfd_del: error deleting ioeventfd: Bad file descriptor
>
> This patch moves virtio_device_grab_ioeventfd() out of the batch to fix
> this problem.
>
> To be noted that the for loop to release ioeventfd should start from i+1,
> not i, because the i-th ioeventfd has already been released in
> vhost_dev_disable_notifiers_nvqs().
>
> Fixes: 6166799f6 ("vhost_net: configure all host notifiers in a single MR=
 transaction")
> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> Reported-by: Gao Shiyuan <gaoshiyuan@baidu.com>

I think we need cc stable for this.

>
> ---
>
> v1->v2:
>     *To explain why the for loop to release ioeventfd starts from i+1:
>       1) add a comment in the code
>       2) describe it in the commit message
> ---
>  hw/net/vhost_net.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 997aab0557..891f235a0a 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -229,9 +229,24 @@ static int vhost_net_enable_notifiers(VirtIODevice *=
dev,
>      int nvhosts =3D data_queue_pairs + cvq;
>      struct vhost_net *net;
>      struct vhost_dev *hdev;
> -    int r, i, j;
> +    int r, i, j, k;
>      NetClientState *peer;
>
> +    /*
> +     * We will pass the notifiers to the kernel, make sure that QEMU
> +     * doesn't interfere.
> +     */
> +    for (i =3D 0; i < nvhosts; i++) {
> +        r =3D virtio_device_grab_ioeventfd(dev);
> +        if (r < 0) {
> +            error_report("vhost %d binding does not support host notifie=
rs", i);
> +            for (k =3D 0; k < i; k++) {
> +                virtio_device_release_ioeventfd(dev);
> +            }
> +            return r;
> +        }

Could we tweak the code to reuse the fail_nvhosts?

> +    }
> +
>      /*
>       * Batch all the host notifiers in a single transaction to avoid
>       * quadratic time complexity in address_space_update_ioeventfds().
> @@ -247,16 +262,6 @@ static int vhost_net_enable_notifiers(VirtIODevice *=
dev,
>
>          net =3D get_vhost_net(peer);
>          hdev =3D &net->dev;
> -        /*
> -         * We will pass the notifiers to the kernel, make sure that QEMU
> -         * doesn't interfere.
> -         */
> -        r =3D virtio_device_grab_ioeventfd(dev);
> -        if (r < 0) {
> -            error_report("binding does not support host notifiers");
> -            memory_region_transaction_commit();
> -            goto fail_nvhosts;
> -        }
>
>          for (j =3D 0; j < hdev->nvqs; j++) {
>              r =3D virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
> @@ -277,6 +282,14 @@ static int vhost_net_enable_notifiers(VirtIODevice *=
dev,
>      return 0;
>  fail_nvhosts:
>      vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs, i);
> +    /*
> +     * This for loop starts from i+1, not i, because the i-th ioeventfd
> +     * has already been released in vhost_dev_disable_notifiers_nvqs().
> +     */
> +    for (k =3D i + 1; k < nvhosts; k++) {
> +        virtio_device_release_ioeventfd(dev);
> +    }
> +
>      return r;
>  }
>
> --
> 2.42.0.windows.2
>

Thanks


