Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC2EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGPf-0004qV-6p; Mon, 14 Jul 2025 06:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubGJU-0000BA-CC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:21:36 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubGJR-0003MQ-Qp
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:21:36 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60c01f70092so6964531a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752488491; x=1753093291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGzgXvVaNT4LpgWQpuwa5zMopP3wW3htxaD9+4IULfg=;
 b=NkJlm2OEf6UuOOHnPIZqahlwNT+52eiSWoR9wTF7O/i1XqFfFPfzhMj4/hAbS7i2QM
 rjtv21s1IwFGkVXD7LusCGvXFHTvkCMGAqMqlnq338Xmo1ok/qv8spFzAfTxaHbNBkNn
 ceGEESI0ToeeVYBsDzOB3Wd4ZJdk801GnMAfU9doO1ECNXEyWukUjGTlt//Z1NdRAh9u
 9vCZAnBiRBHeE0rhG9J+8zuYSUXp2Xo60t89GRdJ6JisDCt0ccpeh8RkJhD3kylRnL0U
 eNuw87oJTDUEORDYJsVPJixWqT4jTDgptXUPFOe/EyiA5DJaiS6VAlNRA6wfXVhVpaks
 F/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752488491; x=1753093291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGzgXvVaNT4LpgWQpuwa5zMopP3wW3htxaD9+4IULfg=;
 b=NzbO2p8CCoYROJy+dRIiS/t7qoVCL1+5iLKVBdeQ/t6g4SiuB//nCONp2nptPPWjKQ
 ukLBDjRKNuuzBR0Py4HcYzgwDxJbiZv7ZGcufIjvF4uAkGuJ6tXYj26kHsc4hZXeLgBl
 fgvTUs9fksa5ATG0nRVQV+GEa6EC9JSkPqDRrCRp2satT7tJusfMRhLiQCESO/BFDTqe
 3KiV/7sszl6LZGvIF9sQvtIsagxu3vyfu/flSYLZLRfnd9DAayWtXjGTpvLEKIDLUBUy
 Yzs9N5l+KEfaENKk8zztmEwTNHSQVyJJHi8xMndpAYMK9FIbhnx2O+BOJPyIVXnMGUVq
 gStA==
X-Gm-Message-State: AOJu0YzUmxe2fWFWd5ByYzKOAhpdNmSe2QyaH6ZQ/I/BzFQODBl64h4j
 VxYJyhOCwfXK0+V9jh7BH7zDkdtqRRNJzDreb5o2LcDx9fEghYiJxY5GU0paxiM/cTmC2OsQzAW
 bcare2gztqnb9rqKdb1re8BhdSZYzlYZfFE9yQiG5oM4a+3Xo5F6AKcg=
X-Gm-Gg: ASbGncvN2SYhzXuQqVcjcaxAIU4XJnyW3e4x9kecREFd2l9VYt1U8+wK91H727T/NpZ
 JlSqXi8Fkwit8edWajnH+D10FMUfifXzn/zaxchfStsjk0q6e2V+FVrjcjLepY7ceYugxfV0Y+V
 2tNPlCGLwx1ZoCn2p/Sj+/gNa0qKqhWqaqY7f53iIgOcu/46dVrb7wmKRbTmvsbeGuA8sLgJYqc
 gGppg==
X-Google-Smtp-Source: AGHT+IFg1o7YlRdhPcdidbOZpD1SDz2uXVycBuEiIhon8qpdHU5G+UCABKPTle0az8tds1dj03xHiGGixhQ3+6Vn9t8=
X-Received: by 2002:a50:cc89:0:b0:607:f63b:aa31 with SMTP id
 4fb4d7f45d1cf-611e760f113mr8278086a12.6.1752488490676; Mon, 14 Jul 2025
 03:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250714101156.30024-1-sgarzare@redhat.com>
In-Reply-To: <20250714101156.30024-1-sgarzare@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 14 Jul 2025 13:21:04 +0300
X-Gm-Features: Ac12FXxIlXOh-GAyLCx6o5UJt0FymhiE1facYzFNhiyEThkcGQanvLR196pPkQ0
Message-ID: <CAAjaMXZj+RYFhV0oPVvF9+=Tbay-Fi+rPJBNNe5MM7WXA2s05Q@mail.gmail.com>
Subject: Re: [PATCH] net/vdpa: fix potential fd leak in net_init_vhost_vdpa()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, Jul 14, 2025 at 1:14=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> Coverity reported a file descriptor leak (CID 1490785) that happens if
> `vhost_vdpa_get_max_queue_pairs()` returns 0, since in that case
> net_host_vdpa_init(), which should take ownership of the fd, is never
> called.
>
> vhost_vdpa_get_max_queue_pairs() returns 1 if VIRTIO_NET_F_MQ is not
> negotiated, or a negative error if the ioctl() fails, or the maximum
> number of queue pairs exposed by the device in the config space in the
> `max_virtqueue_pairs` field. In the VIRTIO spec we have:
>      The device MUST set max_virtqueue_pairs to between 1 and 0x8000
>      inclusive, if it offers VIRTIO_NET_F_MQ.
>
> So, if `vhost_vdpa_get_max_queue_pairs()` returns 0, it's really an
> error since the device is violating the VIRTIO spec.
>
> Treat also `queue_pairs =3D=3D 0` as an error, and jump to the `err` labe=
l,
> to return a negative value to the caller in any case.
>
> Coverity: CID 1490785
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vhost-vdpa.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 58d738945d..9dc7d2cb23 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1813,9 +1813,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const=
 char *name,
>
>      queue_pairs =3D vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, featu=
res,
>                                                   &has_cvq, errp);
> -    if (queue_pairs < 0) {
> -        qemu_close(vdpa_device_fd);
> -        return queue_pairs;
> +    if (queue_pairs <=3D 0) {
> +        goto err;
>      }
>
>      r =3D vhost_vdpa_get_iova_range(vdpa_device_fd, &iova_range);
> --
> 2.50.1
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

