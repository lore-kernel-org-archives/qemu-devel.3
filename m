Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3E5D2ECF5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 23:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhySs-0000jO-Hm; Mon, 19 Jan 2026 18:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vhySq-0000ih-Tn
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 18:15:16 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vhySp-0008En-87
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 18:15:16 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6611cab8ca3so2049966eaf.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 15:15:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768864513; cv=none;
 d=google.com; s=arc-20240605;
 b=hgg+PMqSsIcQ/z61+OUvodyURWGsQsVOs4+7Kx760HLZRL9u0L55woFh1Pp7EWkH7s
 u+bxc9UNgJXjWimFgx4N32WTR2YXOAgHtOxcCG/s/mkObWTOnpqIEdr1a/XKAv0CgZpo
 9LLxim+i8XGREIr/6Wa3Nf3bkzJY5tFPu0psJev5HzSM4Tj227RstKvc5qTepNTfwGz/
 uQHIGoUUii0wtPYxIBuqAOWemvm7FLq2/QV0QJH6cww13bKCVE2tFqZFjiVECh80JgnP
 8E38jHVOgvEZtoZ0IFfswVwhqOUFYKs6w9UVYGU/xJ9FqgPz7nySd0UqPkeRPSddhyc8
 VzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b+Hd3Asq8WC9ZEPhp/CLp9qzeOTiNgZr6eSimimG1rw=;
 fh=hRvcaf7CRZnDmsdsAsI4IeE+AGX8S2VzN3Tp5gobNAk=;
 b=kCVtim7MqXmwxEalkKbPIx08f+3Xcx1N2MIty9Plu50s5/rc8WCYja2YFGVflq1QpF
 7ARSzYH3K0RrGI51N5RupBcyO2ZmB1Vg1JCfm0GCAd1oxTa7NMzB0RBDfyNGzYPEaixW
 827a5L0vihXg6ebrZmeVslVO87cjmqcl8/G4F8Qeo1umiCErKDWVUTbErU/lF88iYkAu
 1M9FusZ7s6LLpTe8wueUBRcc4/kzPI7RvH4VFOF48fTbY+TzR2pkWGV+udIxrdVpjTnD
 hr95h5FO+bmQtREYlDf9gE3QRqHP1BAq1sifc7Zsi2VisuT4yR3Kw+YK1XH+Sb7eYh5a
 xzHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768864513; x=1769469313; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+Hd3Asq8WC9ZEPhp/CLp9qzeOTiNgZr6eSimimG1rw=;
 b=K23ikjc7huGramvnrmjh0OVtH0IG8+2iakIudZ/5f+hp0igh5o2Y1kZWPUrewPI4D9
 4NPqHfvlpmhnfTasaepVze1id/2dfQ76lh68rSMuHXOFg0FoOAdba799/bliyZS+a88l
 X1IfeCk3OEbO+Ri5t/J4+pODowWKnYgZPXL22Hv3bP+oQJvFbNGEucMwZoUUEYF6QBYq
 qkilEV3iULIpAdIvpRRleBJqINqBCnV/5rSiyRHfwi/2+hwnsAP5ZFuJio5s0K8dXszj
 3Lh7146B5p3xPGdMXj5syyLiYYBCx/0bNJPePBNmMGv7lgtJca68cqOrahwUaBCI9s7V
 ig0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768864513; x=1769469313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b+Hd3Asq8WC9ZEPhp/CLp9qzeOTiNgZr6eSimimG1rw=;
 b=PuM6iF+ZjXTslySf4YiGB1ejIVqg0iwVb8QjRVT30eM7oh9INrsoIj7NAbiTV41zV5
 0LmB/XUgQr+iKt4xGWEprxfZQteCTS8etE3xq9WYlQa1oZWIOSgrQxc0PKmgYe9L2eWT
 RURFosnVb8e13IBOKMzf/GhLgctOQ4PRvZLtXBV3PWrSxte6oQoWRnzKyym8ESCf2rNb
 2pntLuECKanCPOJzUJmj7o6ywmwp1JG+EsIX5lApN4Y+sAlhJw3blYyyBYdBmEVoMRCx
 LIN3VJYuwPqMRHMHeFAaAg65I+xY9qJSeEH6dspLMXsdTCcXWzzHBAR6ZTvaoWs/O2hr
 nGlA==
X-Gm-Message-State: AOJu0Yy8nnZDwI7UJwYzvHG+Bnj690AkbBsioGBip4pz+m15Bkkj8KFV
 fp7U7opMzZ4igaOP/wsuehI0Ou9zyzQmLJTzxnNxXWynVc0sQ/e4NipXMVFdXfarvrm3TG1bqxj
 dn/AFCveXKXJlrgWmaYq/G8itNjqs6Sg=
X-Gm-Gg: AY/fxX4U2JhKMPhv7eTmT9ExuLqO7/UkMFqcWWRM6EYa6KJvijZHD7acKl8eItO3cED
 +xPBeLq7WFIYsBJEdVS+w/gSe0hFUXQGkGBXeUamvRBLy71aH9E0BOLpZyyaIqlzeWGSoxiSSPJ
 31F/8pJuzITkxiYjs9/u+jbipcz9dmtFa7BCICQ8wNcvxnBhSyE2C87uJ/i0h0+xF61IXaVZIdz
 OCLlIVTdBeOqyhAVXpDGBWhXpvtOf04Wk6PHbG1lb68bhPbVh82ugrM+u+5a66i9njnwTlHE2M1
 Ky0WrBCSQ+Tjaj2etOp81d3tEFU=
X-Received: by 2002:a4a:dc0b:0:b0:65f:5bc0:7b2f with SMTP id
 006d021491bc7-662b00414afmr2947eaf.46.1768864513559; Mon, 19 Jan 2026
 15:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20260115081103.655749-1-dtalexundeer@yandex-team.ru>
 <20260115081103.655749-6-dtalexundeer@yandex-team.ru>
 <CAFubqFtKrsPn++kMPEAOO2LdygY9BZyDmzb0nU7YbK1on2GNCw@mail.gmail.com>
 <947c2ef9-dbd8-46ea-b61d-1817fb4c33aa@yandex-team.ru>
In-Reply-To: <947c2ef9-dbd8-46ea-b61d-1817fb4c33aa@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 19 Jan 2026 18:15:02 -0500
X-Gm-Features: AZwV_Qh8KYBBkrQiABxnWQx3jgc2uhAUOJxN0j2UCDiP1lqDbBfjpRSSaBdlLX8
Message-ID: <CAFubqFuNAMVsVn47AjUGDi6mRCxKRwvnchmCHbZSEY7HgtG54w@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] vhost-user-blk: support inter-host inflight
 migration
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 Zhenwei Pi <pizhenwei@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, mzamazal@redhat.com,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, 
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

ACK on your explanation. Then for the series:

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Mon, Jan 19, 2026 at 1:44=E2=80=AFAM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
>
> On 1/17/26 00:50, Raphael Norwitz wrote:
>
> Apologies if I've missed something obvious here - what actually skips
> the GET_VRING_BASE operation here? I was expecting something like:
>
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -221,8 +221,9 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>          return 0;
>      }
>
> -    force_stop =3D s->skip_get_vring_base_on_force_shutdown &&
> -                 qemu_force_shutdown_requested();
> +    force_stop =3D (s->skip_get_vring_base_on_force_shutdown &&
> +                 qemu_force_shutdown_requested()) ||
> +                 s->inflight_migration; // FIXME: runstate check?
>
> Without setting force_stop in vhost_user_blk_stop() I don't see how
> the GET_VRING_BASE operation would be skipped.
>
> Nothing skip GET_VRING_BASE) In the first versions of the patch, this was=
 done, but then I realized that this was the wrong way, because the last_av=
ail_idx and avail_idx counters may be incorrect after migration.
>
> Therefore, it is now implemented that on GET_VRING_BASE the backend needs=
 to either wait for all in-flight requests or not (depending on protocol_fe=
ature).
>
> On Thu, Jan 15, 2026 at 3:13=E2=80=AFAM Alexandr Moshkov
> <dtalexundeer@yandex-team.ru> wrote:
>
> During inter-host migration, waiting for disk requests to be drained
> in the vhost-user backend can incur significant downtime.
>
> This can be avoided if QEMU migrates the inflight region in
> vhost-user-blk.
> Thus, during the qemu migration, with feature flag the vhost-user
> back-end can immediately stop vrings, so all in-flight requests will be
> migrated to another host.
>
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/vhost-user-blk.c          | 27 +++++++++++++++++++++++++++
>  include/hw/virtio/vhost-user-blk.h |  1 +
>  include/hw/virtio/vhost.h          |  6 ++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 4d81d2dc34..c151e83677 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -353,6 +353,7 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>      vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>
>      s->vhost_user.supports_config =3D true;
> +    s->vhost_user.supports_inflight_migration =3D s->inflight_migration;
>      ret =3D vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_U=
SER, 0,
>                           errp);
>      if (ret < 0) {
> @@ -568,6 +569,26 @@ static struct vhost_dev *vhost_user_blk_get_vhost(Vi=
rtIODevice *vdev)
>      return &s->dev;
>  }
>
> +static bool vhost_user_blk_inflight_needed(void *opaque)
> +{
> +    struct VHostUserBlk *s =3D opaque;
> +
> +    bool inflight_migration =3D virtio_has_feature(s->dev.protocol_featu=
res,
> +                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFL=
IGHT);
> +
> +    return inflight_migration;
> +}
> +
> +static const VMStateDescription vmstate_vhost_user_blk_inflight =3D {
> +    .name =3D "vhost-user-blk/inflight",
> +    .version_id =3D 1,
> +    .needed =3D vhost_user_blk_inflight_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_vhost_user_blk =3D {
>      .name =3D "vhost-user-blk",
>      .minimum_version_id =3D 1,
> @@ -576,6 +597,10 @@ static const VMStateDescription vmstate_vhost_user_b=
lk =3D {
>          VMSTATE_VIRTIO_DEVICE,
>          VMSTATE_END_OF_LIST()
>      },
> +    .subsections =3D (const VMStateDescription * const []) {
> +        &vmstate_vhost_user_blk_inflight,
> +        NULL
> +    }
>  };
>
>  static const Property vhost_user_blk_properties[] =3D {
> @@ -591,6 +616,8 @@ static const Property vhost_user_blk_properties[] =3D=
 {
>                        VIRTIO_BLK_F_WRITE_ZEROES, true),
>      DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserB=
lk,
>                       skip_get_vring_base_on_force_shutdown, false),
> +    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
> +                     inflight_migration, false),
>  };
>
>  static void vhost_user_blk_class_init(ObjectClass *klass, const void *da=
ta)
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
> index 8158d4673d..1e41a2bcdf 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -52,6 +52,7 @@ struct VHostUserBlk {
>      bool started_vu;
>
>      bool skip_get_vring_base_on_force_shutdown;
> +    bool inflight_migration;
>  };
>
>  #endif
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 08bbb4dfe9..89817bd848 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -554,4 +554,10 @@ static inline int vhost_load_backend_state(struct vh=
ost_dev *dev, QEMUFile *f,
>  }
>  #endif
>
> +extern const VMStateDescription vmstate_vhost_inflight_region;
> +#define VMSTATE_VHOST_INFLIGHT_REGION(_field, _state) \
> +    VMSTATE_STRUCT_POINTER(_field, _state, \
> +                           vmstate_vhost_inflight_region, \
> +                           struct vhost_inflight)
> +
>  #endif
> --
> 2.34.1
>
>

