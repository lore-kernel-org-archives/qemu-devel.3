Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714C5C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4F4t-0003RG-DV; Wed, 09 Sep 2026 05:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x4F4s-0003R1-T4
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 05:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x4F4q-0005FI-IE
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 05:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788947926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQAvGu3eM3tGUeSDdTcHkVCnk9PemB1Xeb8RkMRRefY=;
 b=VGUnSq+w8yJMI4lbKdW+fnFRlAGl+xWg08WRgVxR+n79vXcZTaMzRdDI9DpcaXIZzegnBx
 PaeNqz/F5cFdl+/yng+kwqvvjSLnf+Ne7AJYhE2VaTx9thlxYPKjDRekEKBjVPSic61U3K
 L7TRU2wIfTko4/qQ3AwP66jb/9+91l4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-zMSa0iTDPiC_Gnz5CD1bYg-1; Wed, 09 Sep 2026 05:58:45 -0400
X-MC-Unique: zMSa0iTDPiC_Gnz5CD1bYg-1
X-Mimecast-MFC-AGG-ID: zMSa0iTDPiC_Gnz5CD1bYg_1788947924
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so11746318a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 02:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788947924; cv=none;
 d=google.com; s=arc-20260327;
 b=Y2jppTTDpngybo3fbUDuraSRLNkk8KBVOyY+YuOSAQi3oVwR+j13j4ESBXGEccOHrG
 92pY/lUbMaFr9SrotliRWr0eUArraAnyLEsTinL1g3mYwSImNGqx553CT7XqlWMSdH0G
 /Lid/+GPCrIJOsm+rNcE5pqgSUUZTZgL1CdzifTrLNX/57pUIio1EACb2oBCYJ4J3Q7M
 561xPYIhyITO2xbRylgrpatd4/nqA+zUe4ZRPFeDhDAN+VmVNb2pC4Ru+J0KBoA5f27p
 ltg0+GqotTxMFmLJ2ScXJnXlWo+TLlwfbPJyS0Aj4Jw2u8/dU3pvukKUyJjm3SIkbSW8
 YIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nQAvGu3eM3tGUeSDdTcHkVCnk9PemB1Xeb8RkMRRefY=;
 fh=qselUejVXDvP5pnXhKG7u8hdCcrrqPK9JJS1C6fp4Dg=;
 b=aTXEFr9aPvhHjNHvaIXCtCuLWJHb2V97bJ7WGxpoFsDi6R+7C3Kug0vZmWe1YpZbnZ
 H65hbWw+JBy5n/wdssocoRP4EZHEwO4IDIkIlwbllR/tOCTiYf/xnCPqVf3hKOEkBHFZ
 SHtHsNsReNGwTG6rFbAcBMD13mybf2R+22ooEx+B6VvMJkxSa0D/qJqOdH1F7KT/DEMN
 5xxRqdW41RydHHwSS/ZLPru4GKuTc3Y5swTKXSyOixDfDFDCLC7kJBR793OhqrfgnsAL
 0Wlld1EERhn3AV/akwvho5MQ9b6UgUIooODeUpmYhOeQUAY6DL8ReWmBZN1+5p1c8fWE
 VUQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788947924; x=1789552724; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nQAvGu3eM3tGUeSDdTcHkVCnk9PemB1Xeb8RkMRRefY=;
 b=RUnFOXugsQYi6MqBypmy1rluFZ0Q7+sMbVZSqVzEzPm7c0Ic2JxC2RGJOd+bBtDNnx
 9sJICA/EVSE44yW847qNFklKqLpO/YJTWvcNm9ocl9Zq3HimjPTkkhWBM0lhjFbhg+Yi
 N+O9rp4mGI1uWv38macWwIAXAS1QEYUyO6UbylguZOdkzlgbZUs7ZO1IJu5EVn7XDi4o
 bWzuiOwguohxK+j5Oa/ms5vIucAfMia8UVRE/Hj5WZUS75dNi01+IVdThDjm+jJvg4gP
 NUtUS5168guSHaZRAKbFCGMZfzI3DtfPTjPjfVezRcb/raNgrx2QgtsOmg6p/sMBeLlW
 aGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788947924; x=1789552724;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nQAvGu3eM3tGUeSDdTcHkVCnk9PemB1Xeb8RkMRRefY=;
 b=ss9hCcuvVBrOM9ppaS7nF+ecSe4yUy2Y8ilUMqi9j9Oc1f8RV7PwV53wAAGFhzF0DS
 e0XKc+219dlZKr3WoPwb9CGhoGt8ouAFNKeD5zVKKnhgzmbJmU8fWTc8gRFvVY6rViIP
 zrIJBM21p3DMaEOChL7MA+LjwS40vPX/Xpct/HMirrrGv+rz86Ktr6J84zPg06iFHWUp
 BtSsRfFBE9MrKQEvxG+Xyfb0H9bd5keEZWtcidzMTZfkg47YiKc07PhRyPP4vVk1OUqx
 1g8XPGRDXTdIxv+GeGZLXSpykRJoDbJHZ/FGJ/PHoJtRKQosMad53o8kPexdgs91NMwY
 JRug==
X-Gm-Message-State: AFuF++mlIrHQvrfWp5OzENFDNgpIFP4MYJC8x6ho1wXN589GKcZbIEeW
 Mig1+OnrvffNI9vG5zDubUIA+tn+Gr7GLAdRJgB9mO2jqh3gyF/znoU+ucEkx/0qRQKuqYJ3aye
 gs8HPWbpouPn/SgVHRTWtqRSGPDmu3xPfAqf3fZXtewht5+1VgawSwWCPDK1Ll/dL1txQu+creI
 5IILg8elIP9Il4hzf5JnCbXInjKwBjdt8=
X-Gm-Gg: AYBFou3jg8TF1XYVoTjO1YuT+hKldLJ7t/VZzuh9zsKQ8e9NAownHD1/g/ZPMxS6u2g
 +DKi2+O77IDBAqGgXnijZQMEE7SewSt9j+y2CkkDhFi/1ItJhVXzak4osPNZJfa3P+yzlB8SGza
 QEa8Zim/e1ygvPenWT20VVk9mtPzeQBLkyWdwE3iZqJYvevyMfWtjUnZ6klePm0/XQiJmeWOo3c
 swDWOFXXbZX9E3r49farN2zlEQBA8AEv86uBheZnE+0DJJjeVs/rGr1dD2S7InFyqFPCD6BtLW3
 aw==
X-Received: by 2002:a17:90b:440e:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-39b261e1011mr48099963a91.13.1788947923977; 
 Wed, 09 Sep 2026 02:58:43 -0700 (PDT)
X-Received: by 2002:a17:90b:440e:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-39b261e1011mr48099924a91.13.1788947923472; Wed, 09 Sep 2026
 02:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
 <20260908-gpu-v3-6-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260908-gpu-v3-6-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 9 Sep 2026 13:58:31 +0400
X-Gm-Features: AcwNN1U6mXPq1TmvHlImsoTWBjtVfSyfX_p4apJjFptTdnhfZ3MBOVH1kfTHxbA
Message-ID: <CAMxuvazGXs9d-32LFP8MYhipzqPvGskwMk7hmgJMA87QJ4fX1A@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 8, 2026 at 10:13=E2=80=AFAM Akihiko Odaki
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

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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


