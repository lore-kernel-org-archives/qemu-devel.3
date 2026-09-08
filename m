Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EF5C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3t2r-0005XL-BE; Tue, 08 Sep 2026 06:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3t2q-0005X3-8m
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:27:16 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3t2o-00040d-9l
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:27:16 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3964dfb5b9aso5446389a91.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788863232; cv=none;
 d=google.com; s=arc-20260327;
 b=MtU9gkXexjoh9FCwNzNhW+oy/ggyz3ZolJ4kXeKhUaBto2UjV1gIBweC5dqmX2Lxvg
 NH0xWNSTIeOVdTMsYmizHk3/kbKVtbWwRFqr4O9BqZMrOSV4gux7NF7iVjbWLxFSHIGL
 gWNLVq+QEv8RLEDEjXihaz7DH4cMgAB1NdUqdiTvs7kuu2wssHaEqiYAXcLG+Fm9+Apm
 6TaG/wYkw7xJm5AIT8jFhs9iqbgKk0IgUAosJNarpELdEkEhEDNLH4/xGDF+jUofTk8X
 fjxGTPV8Hotp6xT67Xo1biHqMi/CjnaMpchuMJ5779BtKKIsWS0yQs99n6MV2teeaWBm
 a+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SyGQtXe/fGVs7ORZYkYjVa2mY40t1hBK+QCp6iajFWY=;
 fh=qselUejVXDvP5pnXhKG7u8hdCcrrqPK9JJS1C6fp4Dg=;
 b=sDBrMiURwkLJCrL1tC7IHZTb1GD6IWlMqwnNWbcdaSp/24FA1MSpmU12PYuKfNWD/9
 reDxsDqu25F9e4S94wQWOsSVP+iR/F8kMNyOlhMnlHz6YJ+JKeEAhmSWavdn22c9DXDh
 YctTDi4BxbZo2ofWXiL8nYqdWUiQ+Et+rx1ejK96/JKbqGfauiRky4xRKpqWNrYj13VO
 RJhAzGe6oz8ewQAyf3F2okNoZ/8rP23Stvur1usD69ordLDHDMTB8rTZZR3D6aLYp1HE
 LZE5O563cz3dtSQjNkyBg7lMxbKmtTyuXx9msoUdL/+CtXWgNVg/gzYkjTpl9RI2Fppg
 sqJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788863232; x=1789468032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SyGQtXe/fGVs7ORZYkYjVa2mY40t1hBK+QCp6iajFWY=;
 b=aj1bZH4hPH3ZTIa7m2B6MLWfbzexmevte0SpteYnTrTZi97kpujN7nO8oHUMuU5fEd
 jH/rGMGorlAC96VUC4Mb1YgIsfrmfNQZphN9tIjAj4NPfX/cNTTwSThrAaJXG2ZmTy8D
 TzNaLYvlKMfE5pQlYaizOgFKpMD33CqcMbR0u1ddMWj86T9cLp6zys1NVVu7OS7tvOu0
 bU++qTG0xZwpoTwNhaicPLeAXX4f6JTgBntEDtTNcIAbqLMvjISnRecAEQkgUf/AVGmQ
 F3sKrrK1FCJkfyamfAwezqlLFCmGFZQGOVH9QpthP7FnFER6x8fW6EVc/ZKF/fJprWTi
 SMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788863232; x=1789468032;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SyGQtXe/fGVs7ORZYkYjVa2mY40t1hBK+QCp6iajFWY=;
 b=Q/AFM5QdMW49u23atP9Lcbu8jm+aa6QdQd/Z1XlC+CF+JQLsQXcP+Pg+eAM4f6G1cw
 yRXJprErhiSSidTxykttJ0QIsOhbcslW+lyYj/W/zkUHJaO+Wb3LxXcHnDXOJ+6ZwlFI
 D8RQz6L/C2HXFTuga1PkYcJ/mClMf/fkUZpBIF/Yk5SNtTO3bEMJ9+T3gbYIibmuvgpT
 rLvlDEZBma1wcaxAOXz3ItYocgGvpjLbRVhSGBJvvqHV5mcriXzYOmmydo/b3IwYoKGZ
 au+FFKWaxGlzoyXsWVMPp3PiRj0LVeignozIziMXkiOuc/WNwLz0OU/LS8tHfr4kl+Qx
 ggwg==
X-Gm-Message-State: AFuF++kmGkdZDscELDyEfKl7iWvtBLfOnUCGVJX9rLthljGac1M24ttK
 gxgeIxoNO553GW4KHqnE1jQmgzKxUYdKCHeMAjY5KmJsnMoR5eCwBPg+P2ASjMQ1UOvQg45pqh+
 MmOocQVkEEuxngmqshgD2zjOjLPo560s=
X-Gm-Gg: AYBFou1P2BBCBkYZZGgjUfQLP2onCiTsPBkUbu3OjoXpLhSTgNkqSEJKwEcF3xoPWdA
 NU47ex8FIzlUXy9ta3xSQXVqwkAZiSsX1CU7VM63lepQzpgB2EFQtuLvWFJ0NTKGuxWpsJ/4Q3d
 J5SqUNCAry5EHqBJHuVlS33iA6TpexUmUNXGLrT9eGESHaN/Pq7qpHF49Xu0T0LjUYNmYm8Lw/k
 cK9xKUoa9U8+bFlth1sySKAbiecjKO/VW8HgGGzMWalUy3xYJNr2ebRE0b4jiGBb3cAOEEt7V7O
 DveXHrg22djGMsLLgSWGxY20Uo4LQj2sgm4bh2GYRrAE5AzW2svgIy2CBXFsosbv2v2fU7fdqCk
 gKQ==
X-Received: by 2002:a17:90b:264c:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-39b2612f7dbmr42235607a91.10.1788863232283; Tue, 08 Sep 2026
 03:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
 <20260908-gpu-v3-6-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260908-gpu-v3-6-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 8 Sep 2026 14:27:00 +0400
X-Gm-Features: AcwNN1Um5XYiQQbVAg3nOvouvYDYQ53vEC5xbYWBozmG8pUA4Ghl03IV3Ug8Fz8
Message-ID: <CAJ+F1C+QiHZ3Pp3Q_Dy=KCzR=UCWpYAosdQxVaqgLTnQudkVeg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] hw/display/virtio-gpu: Fix fenced blob unmapping
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Tue, Sep 8, 2026 at 10:14=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Blob unmapping may be suspended because of remaining uses of the
> mapping. virtio_gpu_process_cmdq() uses the following condition to
> detect a suspended command:
>
>     !cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)
>
> However, the guest may set VIRTIO_GPU_FLAG_FENCE for a command that
> performs blob unmapping. Such a command will be incorrectly assumed
> as not being suspended. Add a dedicated flag for the suspended state
> to avoid overloading VIRTIO_GPU_FLAG_FENCE.
>
> Fixes: 640f9149c3dc ("virtio-gpu: Support suspension of commands processi=
ng")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  include/hw/virtio/virtio-gpu.h |  1 +
>  hw/display/virtio-gpu-virgl.c  | 17 +++++++----------
>  hw/display/virtio-gpu.c        |  5 ++---
>  3 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 9404e488208a..3eccc4bc39c3 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -141,6 +141,7 @@ struct virtio_gpu_ctrl_command {
>      struct virtio_gpu_ctrl_hdr cmd_hdr;
>      uint32_t error;
>      bool finished;
> +    bool suspended;

>      QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
>  };
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 9bda572426b2..c37df91e3ed1 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -440,8 +440,7 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
>  }
>
>  static void virgl_cmd_resource_unref(VirtIOGPU *g,
> -                                     struct virtio_gpu_ctrl_command *cmd=
,
> -                                     bool *cmd_suspended)
> +                                     struct virtio_gpu_ctrl_command *cmd=
)
>  {
>      struct virtio_gpu_resource_unref unref;
>      struct virtio_gpu_virgl_resource *res;
> @@ -457,7 +456,7 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>          return;
>      }
>
> -    virtio_gpu_virgl_resource_unref(g, res, cmd_suspended);
> +    virtio_gpu_virgl_resource_unref(g, res, &cmd->suspended);
>  }
>
>  void virtio_gpu_virgl_resource_destroy(VirtIOGPU *g,
> @@ -946,8 +945,7 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
>  }
>
>  static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
> -                                          struct virtio_gpu_ctrl_command=
 *cmd,
> -                                          bool *cmd_suspended)
> +                                          struct virtio_gpu_ctrl_command=
 *cmd)
>  {
>      struct virtio_gpu_resource_unmap_blob ublob;
>      struct virtio_gpu_virgl_resource *res;
> @@ -964,7 +962,7 @@ static void virgl_cmd_resource_unmap_blob(VirtIOGPU *=
g,
>          return;
>      }
>
> -    ret =3D virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended);
> +    ret =3D virtio_gpu_virgl_unmap_resource_blob(g, res, &cmd->suspended=
);
>      if (ret) {
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          return;
> @@ -1036,7 +1034,6 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g=
,
>  void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                        struct virtio_gpu_ctrl_command *cm=
d)
>  {
> -    bool cmd_suspended =3D false;
>      int ret;
>
>      VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
> @@ -1080,7 +1077,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>          virgl_cmd_resource_flush(g, cmd);
>          break;
>      case VIRTIO_GPU_CMD_RESOURCE_UNREF:
> -        virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
> +        virgl_cmd_resource_unref(g, cmd);
>          break;
>      case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
>          /* TODO add security */
> @@ -1110,7 +1107,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>          virgl_cmd_resource_map_blob(g, cmd);
>          break;
>      case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
> -        virgl_cmd_resource_unmap_blob(g, cmd, &cmd_suspended);
> +        virgl_cmd_resource_unmap_blob(g, cmd);
>          break;
>      case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
>          virgl_cmd_set_scanout_blob(g, cmd);
> @@ -1121,7 +1118,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>          break;
>      }
>
> -    if (cmd_suspended || cmd->finished) {
> +    if (cmd->suspended || cmd->finished) {
>          return;
>      }
>      if (cmd->error) {
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index d520f69e6453..dd6c09d1ddcf 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1193,11 +1193,10 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>              break;
>          }
>
> -        /* process command */
> +        cmd->suspended =3D false;

The field could be initialized after virtqueue_pop(), otherwise it has
a random allocation value. Then perhaps, drop this assignment?

>          vgc->process_cmd(g, cmd);
>
> -        /* command suspended */
> -        if (!cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FEN=
CE)) {
> +        if (cmd->suspended) {
>              trace_virtio_gpu_cmd_suspended(cmd->cmd_hdr.type);
>              break;
>          }
>
> --
> 2.55.0
>
>

