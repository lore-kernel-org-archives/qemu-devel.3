Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F69C982FB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 19:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgprG-0001Qa-Gx; Fri, 16 Jan 2026 14:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vgpqa-0000Xr-7A
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 14:51:04 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vgpqY-0001No-Dp
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 14:51:03 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7cfcebf1725so1616763a34.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 11:50:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768593056; cv=none;
 d=google.com; s=arc-20240605;
 b=OO4cIZsglSAwpxkMDnKUQgnfE2n3wPJMd8XtBEsWJrnkrmTt2av2/O2R2ObdZqWaxa
 2tLvltpn9gdbutcqJ0oFh4WeoQJ4J+Ak5tAj1uj/TZ9OORHC8SZ11xBfFIimX0vJqnD1
 pSu4qZFxVFqizzRgJrMIFi3TSt6oiCIbYTa2e0iJ66gmWbMd1aQexT4Y9dRMKGrjhxOy
 QpTOJSVkytGqkC2pvzSInfaSFU4R72oRBNEc+/adT94+lAkHAEg8teufjgoru9i2nP/2
 RSobY5T+t7To7r+h3tocs1hsbDcSi+MfETbUJIINVwMxZCYOIPgg4yNIt4ndlVPy4JaU
 Q5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=teDDPgMWHLMcsEK7YMG91On4831FNcIesgnPi/nB9tM=;
 fh=hRvcaf7CRZnDmsdsAsI4IeE+AGX8S2VzN3Tp5gobNAk=;
 b=D+YI4uUECg9/OJFWu70rVHZ/YBrZ359DH+P1zYYM9h5iwZ/9+jcFoSD8FLpfN5gI3a
 TCGT9QYMUVXV5s7ZGZsBEMVMEUdsAU8vJFO1VLYD3Rr7/CAStWLAgq8D2ktojwEQQw40
 Hll+kP6TMZpRtyfS9/q8BERC79C510Qh4F961XDHX82VH1cImV0PSkvuDt+BlJJDVnMv
 EckkqZPS7vzmUFNK4HnJS0g4pZJRMokQ4zU7wl/bAOYNzagNP/nwPzGHxsxO4BWMfnN6
 RU09ebTNEygMTniKeKB6pC1lTvCvxen+3HZBTW5C9DGn7c/65pm1n8XZivcihh97qeij
 kWnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768593056; x=1769197856; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teDDPgMWHLMcsEK7YMG91On4831FNcIesgnPi/nB9tM=;
 b=H7uFHbN1Sk69fC0UpE/UHI9SQCtJHVXaqkWG05B8gYYapwjWh59uF9Pfo4znkDBlNR
 eStFxMddi/C43s2Ax8Yq2LXdvQkVR4y5C3kfVQIlGmVMtjd1sbmSQFm9fqmNOiuc0UYL
 Es4N19vgKZ5KnvuEkhn0KPN4qs6Y1l3dmTS5mwbh/MDxHOwnZM2fRLHb9dn4+TF+0S/Q
 eWclfL/84vaxYYLdrsUs7uKsESOUk1cdRb2ZdNgwX95maKK5cgLogjvSLHEAo7Vjcnum
 KP8WzIG6/xJVj3oDWEmJfGziC0FqwVGu+IeqXJR/xbnweqHIb51Q/cXt+tb4cNsCTAQJ
 3mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768593056; x=1769197856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=teDDPgMWHLMcsEK7YMG91On4831FNcIesgnPi/nB9tM=;
 b=r119zmv6P2/7RjaSHb+yiCZ49ddmKF61uQKN8BJzTJczpy+DRcIPMT2UlPSntUEk0j
 uA/llaS5Z/4SIZHAigcxayNdJgrcpXTOXexnjsdlIVZDDT6giYkmBW0dD9WcoL8fUtUT
 a3ZQFG/SAV4vbHMGPnaU86V0OgI77jpgUSMIdjGOwTET4Hx4JHVj3/ykOegL8ULshSJm
 zJgjtFjc8NeGQhAMNh/Hqq5Z45ddUFHY95LdMQggKoYnLrjPUZtJbwf0keWa/MTz3aWl
 sSDhx6hxOmvSythBXE4HpX61MXgcU95UM6vvxf9r10R8OeYJ7kL3ZZ/7AxjpH84QqV50
 RIug==
X-Gm-Message-State: AOJu0Yx9pAtU6P9RMc2QAi+mF6W1FVYB8/dH0oPBhcQbzPNkOf6AQfdB
 LParYdvdrPPrNba+FS50WhrphuHnO/lQsLeJJVcg9RtNsbE8ZF9X1YYo0aw9Zvqr/8Y5j+mX3WU
 /h3c9I3+n5S0zgUuw9lYMb+mSuZ/mqNA=
X-Gm-Gg: AY/fxX5G8qTek/RwcdvnyVpPkCoSwUmpAGgTJe+AF5G3SJ1HyMGimNv17mJsxS/Ov14
 YBZhQ5GEBkuE7FZuxGY22b/P/PPupJJTyeMLPZpMLvm1gv9SeOXR2eEP/R8Eyq+608z7Fgw0xHU
 y1NN+0lKzKYR7dXGsduQtivSb3Ni8J4mpoQ2ubQ6jbAPjnOucW07hn1m2+Vv+khnsTPAOWsRZ/Q
 2hBrtHp9RD2UgEIDHI2EnvyMxYAak+QbuBZmg/GCETMFSQChNAq1HRgPN0Z/J2dUO4Oa78b6xGW
 DizzWcCzeUNlQIacETb4YKn07g==
X-Received: by 2002:a05:6820:174a:b0:65e:f37f:93a4 with SMTP id
 006d021491bc7-66117959c64mr1764198eaf.8.1768593056108; Fri, 16 Jan 2026
 11:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20260115081103.655749-1-dtalexundeer@yandex-team.ru>
 <20260115081103.655749-6-dtalexundeer@yandex-team.ru>
In-Reply-To: <20260115081103.655749-6-dtalexundeer@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Fri, 16 Jan 2026 14:50:45 -0500
X-Gm-Features: AZwV_QiMN4DGVtzxgAKEZgmhbOBLU-3A6_s5nR0j38K8nCOVb7nHf8zJ0wBplr8
Message-ID: <CAFubqFtKrsPn++kMPEAOO2LdygY9BZyDmzb0nU7YbK1on2GNCw@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Apologies if I've missed something obvious here - what actually skips
the GET_VRING_BASE operation here? I was expecting something like:

--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -221,8 +221,9 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
         return 0;
     }

-    force_stop =3D s->skip_get_vring_base_on_force_shutdown &&
-                 qemu_force_shutdown_requested();
+    force_stop =3D (s->skip_get_vring_base_on_force_shutdown &&
+                 qemu_force_shutdown_requested()) ||
+                 s->inflight_migration; // FIXME: runstate check?

Without setting force_stop in vhost_user_blk_stop() I don't see how
the GET_VRING_BASE operation would be skipped.

On Thu, Jan 15, 2026 at 3:13=E2=80=AFAM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
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

