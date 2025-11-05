Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52070CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 12:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGcnP-0001a3-GX; Wed, 05 Nov 2025 07:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vGcnE-0001ZQ-Fs
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:39:16 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vGcnC-00044w-Uz
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:39:16 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640b06fa959so6049016a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 04:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762346353; x=1762951153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ln9SzCuPTtvoPf9iZzeFHd3CaqYThr5+Q6LZSHThtXU=;
 b=oag+xCgpXYui+LAhQ03I17hadNazLxe+abilCh+911VIMEA7RjwWHj2eu6AFbmwcD9
 d9fEC6Q8bRExAG1fCWbbWc99tT/mVjS5bOp/nnbxc6YOEcOAqvTIBElbEYOZ6+whcC6K
 reGrxC9nihlwo7UXTWMyKkiWsD+R72B8o3DYgA+cx7aIxnHKd3AAhLrHitcW8ZZCGdW0
 C79KE+qh0TlfieqJZIxJeey+KK9z1jf1soq1BEL62+UNywSD6uEDdBuK3ZivI1OVl/k5
 e9on6foMiGuRL+nZNkv026mzu+h9rfFvrJvShpy+QrasUTtk4bgd/hOnGilF246txLPm
 3qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762346353; x=1762951153;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ln9SzCuPTtvoPf9iZzeFHd3CaqYThr5+Q6LZSHThtXU=;
 b=Q5qnKYokUee1etzQ8AXJS+59eXRj9Mtn+YNW68ihHtn7lO7Rz1VaKNjAa6zTnqcMxd
 TEgmBY+qvvrS8hhjiFu48HxYTawLimLSoURujTCEvmBxE72B0BLk+Z4OQSrBtWrc5JiU
 SGnm/auYpGP0Ls3tW2naDo+ndrpLIePcWM+HWSj/uBknVEYcpdArTa5OpDGBLUlbQ8zJ
 vas+hVfibWp3UNA6ZYOPumg6eQ+7szOce/5B5lj+/+JGfHpE9UIcsoarRR1Miehrz7Rf
 1ILWcQx1gW6J5aZKjCMGjHw9v9n1cqK/+7dChFLvT+hVJyuC+0SO+RZrZTw6tGj9oZCf
 dvBA==
X-Gm-Message-State: AOJu0YwaHPJgBPGCPnx/3X7R+tAoNhICbjRVn9jHGQ2JgVDiF+rr4COi
 7wfycyPsPiVIzoQ14on50jqMdKbGjW7aWX6/l7bdX2Hbz/3jjULfr+lW4MAnnztdwIc=
X-Gm-Gg: ASbGncspq9a8oJzPxWWkSFuEkiaIcDh2HuoUM2FYxzYAESttb+ixUVbksxNBDKXKH+E
 hz3sF9NbqPx/SocDZf0Kge45fKSRs/YRf0I6Wt90axi8MFUAQDvwGWi6sd8+J36CZg+tRKJwxGU
 4iBXuHJLOWiiPDnzuZ0tbqr6o4k4pkvlsEXZUDcOIbefPnTCTzDP+jZ0gGr7vQQ8Dw5wuflnkHX
 0WLyA/iBDn5hEzUuWaNnzzJXb4AIo4SuMZk9EIzbfZCsUZpkjHddk+nrQmFO5qige4/1LpA+sFD
 Kp8xZ1dhCunLrJFLFLRtO1casy2AxdyAWQdzRVSCT8GWw6AKVSy1cvo5ONpQTBR1wwx7c+QfO0q
 VaEI5wLIYEZzCRMmSlFyXPXZB3vmrcLifG4Dqa4YB5WzoQ2ZEv/pLflJIWtfHr4PehsktT20rD5
 fITXhgHG4qx3Y=
X-Google-Smtp-Source: AGHT+IFnUGiplE9xpsmMKyHevGs/41+kxGvCKFudJE4u07+D1bl84urwVb93qBecn4nUoo5T5BewOA==
X-Received: by 2002:a17:907:94d4:b0:b47:2be3:bc75 with SMTP id
 a640c23a62f3a-b72655a6fa5mr331112966b.60.1762346352869; 
 Wed, 05 Nov 2025 04:39:12 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fe37cb9sm478099766b.61.2025.11.05.04.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 04:39:12 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7DFB35F88E;
 Wed, 05 Nov 2025 12:39:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,
 bill.mills@linaro.org,  edgar.iglesias@amd.com
Subject: Re: [PATCH v1 2/5] virtio: Add virtio_queue_get_rings
In-Reply-To: <20251028152351.1247812-3-edgar.iglesias@gmail.com> (Edgar E.
 Iglesias's message of "Tue, 28 Oct 2025 16:23:47 +0100")
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
 <20251028152351.1247812-3-edgar.iglesias@gmail.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Wed, 05 Nov 2025 12:39:11 +0000
Message-ID: <875xbovekw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"Edgar E. Iglesias" <edgar.iglesias@gmail.com> writes:

> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/virtio/virtio.c         | 16 ++++++++++++++++
>  include/hw/virtio/virtio.h |  2 ++
>  2 files changed, 18 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 8a53fb5f93..fe7c635390 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2379,6 +2379,22 @@ void virtio_queue_set_rings(VirtIODevice *vdev, in=
t n, hwaddr desc,
>      virtio_init_region_cache(vdev, n);
>  }
>=20=20
> +void virtio_queue_get_rings(VirtIODevice *vdev, int n, hwaddr *desc,
> +                            hwaddr *avail, hwaddr *used)
> +{
> +    assert(vdev->vq[n].vring.num);
> +
> +    if (desc) {
> +        *desc =3D vdev->vq[n].vring.desc;
> +    }
> +    if (avail) {
> +        *avail =3D vdev->vq[n].vring.avail;
> +    }
> +    if (used) {
> +        *used =3D vdev->vq[n].vring.used;
> +    }
> +}
> +
>  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
>  {
>      /* Don't allow guest to flip queue between existent and
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index d97529c3f1..8bceb115a3 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -361,6 +361,8 @@ int virtio_queue_get_max_num(VirtIODevice *vdev, int =
n);
>  int virtio_get_num_queues(VirtIODevice *vdev);
>  void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
>                              hwaddr avail, hwaddr used);
> +void virtio_queue_get_rings(VirtIODevice *vdev, int n, hwaddr *desc,
> +                            hwaddr *avail, hwaddr *used);

Same as last comment, lets start documenting the API.

>  void virtio_queue_update_rings(VirtIODevice *vdev, int n);
>  void virtio_init_region_cache(VirtIODevice *vdev, int n);
>  void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

