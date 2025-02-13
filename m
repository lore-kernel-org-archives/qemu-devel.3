Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CA6C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibzD-0004MF-UT; Thu, 13 Feb 2025 11:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tibz7-0004Lc-S0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tibz5-0000AS-Ug
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739463758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAkB0W8i3pTl71Cm0U1MSXsAyppYow3njArsfL75rcM=;
 b=chUqostUugG6Q6uibuIXYhFKAHLU2iAc01g3/ooQ+LmMuEBaKaPRQ+aKk/R0uaEyGfE9Wk
 MZrd/cv7cK1vikEz+f/HhiJeEe2Uubc3W9TbLScGwIxyvm6uxp150O684rNLZnRWcQkIIs
 OQ67BJfpC2uyljtF4uvPocRwzaN6nqU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-uAbs-ebBOBK7PKcTgzR8Dw-1; Thu, 13 Feb 2025 11:22:34 -0500
X-MC-Unique: uAbs-ebBOBK7PKcTgzR8Dw-1
X-Mimecast-MFC-AGG-ID: uAbs-ebBOBK7PKcTgzR8Dw
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6f2bdb560ecso17321157b3.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739463754; x=1740068554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jAkB0W8i3pTl71Cm0U1MSXsAyppYow3njArsfL75rcM=;
 b=E4PXn3H2tR9KNFF9gnNU6J41yz0qaw5GldCoTw7YPZowYNJLftV2Q+ZK6d2TEaIMaF
 5+rTIaAE0GHnDzpyvmm3lHYm5IVpmyyxDFbeuwxot+V3Y3PTd8c0eS0Z4XhlPumpPjlT
 EDNl9xUy6tUgRKdGd9fu0xefw7eCt/TQNcxVhsh07Fcx7C+9a7iMWW1UMgAPNI113Mgm
 bmfgucTWt0dZGeuYDxcix2gI8W/OC+i+DDsdLrNDGkRwNzIm2laxDCEpG9kmyn4jmbeB
 fn9PXLbWMr7/VHLvIFkTLzpoG1o9A0ODF1GGHmn9pVaFoLUH0ZI7d9u1yTnEeXbwU0GX
 aAuA==
X-Gm-Message-State: AOJu0YxbWOAjwEsuBDOj/ONwenzij3fGnzZViiQ/gCd8qDj1wLDVX23o
 991vq61riloJ3f0S98Awlpi3MJlJshnDORDj6GcILqeSKrnuSKQHsxTI5ccB01Ta8q5+bgExpmG
 srlFhAn3hk14GMbwlCUFALLk04xCH3c75yf0X4nIu0d0zm8+vkHBTvBNaQJ3U5Zt6+sLe9keoxo
 z+c+Yeks3lwcpqVZ7e424ZcFsvcSY=
X-Gm-Gg: ASbGncvLUCCQRYhM8+12/o5rGt2TjxPD6aRCvxZ6r/pgYsQ0WlTUkJ0l2iZrMB7j4uT
 La0ghVbbNNWrHvd5JZWb+rLMJ7fDjM1Sb1cVwJtf03SWDrHYedMDNHqc2lsES
X-Received: by 2002:a05:690c:4903:b0:6f5:4304:fb8 with SMTP id
 00721157ae682-6fb1f1c7654mr87388497b3.18.1739463754191; 
 Thu, 13 Feb 2025 08:22:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMid8IeXJU/qKYjm8szrXIGJZKgBqR2s2pEmx4j0u0lK0EpxUG/5aXs8MzOofLcZ/d9tB+YBuQYPRwQpf8vh0=
X-Received: by 2002:a05:690c:4903:b0:6f5:4304:fb8 with SMTP id
 00721157ae682-6fb1f1c7654mr87388317b3.18.1739463753829; Thu, 13 Feb 2025
 08:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20250213132513.767709-1-mvaralar@redhat.com>
 <z2bfkwpwfohvmj6xesdm2zmatlcwxta4aexq6x543lpnt47333@ayqfx3yxs5eb>
 <CAGxU2F4Jzi+16Z_JKjhQREJ2FBGPOHheLhSoCOJ=6O-XL+k1NA@mail.gmail.com>
In-Reply-To: <CAGxU2F4Jzi+16Z_JKjhQREJ2FBGPOHheLhSoCOJ=6O-XL+k1NA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 13 Feb 2025 17:22:22 +0100
X-Gm-Features: AWEUYZkHpKy1KCiMnuDVey09V1104-Ob3wIG7LdkbU1lRsFGloMHUzGQ1eajoBI
Message-ID: <CAGxU2F5FWUN8rU-cr9wZyEJBtGH7a8Wd1SQC-1_93G8zifM4aA@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-snd: Use virtio_get_config_size()
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, 13 Feb 2025 at 16:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Unrelated to this patch, but since we are talking about
> VIRTIO_SND_F_CTLS, I think it would be good to send a patch to Linux to
> make it clear that `controls` depends on VIRTIO_SND_F_CTLS.

Patch posted here:
https://lore.kernel.org/virtualization/20250213161825.139952-1-sgarzare@redhat.com/T/#u

Stefano

>
> For example in linux/include/uapi/linux/virtio_blk.h we have:
>
> struct virtio_blk_config {
>         /* The capacity (in 512-byte sectors). */
>         __virtio64 capacity;
>         /* The maximum segment size (if VIRTIO_BLK_F_SIZE_MAX) */
>         __virtio32 size_max;
>         /* The maximum number of segments (if VIRTIO_BLK_F_SEG_MAX) */
>         __virtio32 seg_max;
>         ....
>
> So I suggest something like this:
>
> diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_snd.h
> index 5f4100c2cf04..a4cfb9f6561a 100644
> --- a/include/uapi/linux/virtio_snd.h
> +++ b/include/uapi/linux/virtio_snd.h
> @@ -25,7 +25,7 @@ struct virtio_snd_config {
>         __le32 streams;
>         /* # of available channel maps */
>         __le32 chmaps;
> -       /* # of available control elements */
> +       /* # of available control elements (if VIRTIO_SND_F_CTLS) */
>         __le32 controls;
>  };
>
> Thanks,
> Stefano
>
>
> On Thu, 13 Feb 2025 at 16:31, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > For the title, what about this?
> >
> >    vhost-user-snd: fix incorrect config_size computation
> >
> > Or something like that, just to make clear that we are fixing a
> > real issue.
> >
> > On Thu, Feb 13, 2025 at 02:25:13PM +0100, Matias Ezequiel Vara Larsen
> > wrote:
> > >Use virtio_get_config_size() rather than sizeof(struct
> > >virtio_snd_config) for the config_size in the vhost-user-snd frontend.
> > >The frontend shall rely on device features for the size of the device
> > >configuration space. This fixes an issue introduced by commit ab0c7fb2
> >
> > When we refer to a commit it's a good practice to put both the sha1, but
> > also the title, like this:
> > This fixes an issue introduced by commit ab0c7fb22b ("linux-headers:
> > update to current kvm/next") ...
> >
> > >in which the optional field `control` is added to the virtio_snd_config
> >
> > s/control/controls
> >
> > I would also specify here that the presence of `controls` in the config
> > space depends on VIRTIO_SND_F_CTLS, citing the specification:
> >
> > 5.14.4 Device Configuration Layout
> >   ...
> >   controls
> >      (driver-read-only) indicates a total number of all available control
> >      elements if VIRTIO_SND_F_CTLS has been negotiated.
> >
> > >structure. This breaks vhost-user-device backends that do not implement
> > >the `controls` field.
> > >
> >
> > I'd suggest to add the fixes tag:
> >
> > Fixes: ab0c7fb22b ("linux-headers: update to current kvm/next")
> >
> > And maybe also:
> >
> > Cc: qemu-stable@nongnu.org
> >
> > >Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
> > >Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> > >Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> > >---
> > > hw/virtio/vhost-user-snd.c | 18 +++++++++++++++++-
> > > 1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > >diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
> > >index 8610370af8..8da4309470 100644
> > >--- a/hw/virtio/vhost-user-snd.c
> > >+++ b/hw/virtio/vhost-user-snd.c
> > >@@ -16,6 +16,18 @@
> > > #include "standard-headers/linux/virtio_ids.h"
> > > #include "standard-headers/linux/virtio_snd.h"
> > >
> > >+static const VirtIOFeature feature_sizes[] = {
> > >+    {.flags = 1ULL << VIRTIO_SND_F_CTLS,
> > >+    .end = endof(struct virtio_snd_config, controls)},
> > >+    {}
> > >+};
> > >+
> > >+static const VirtIOConfigSizeParams cfg_size_params = {
> > >+    .min_size = endof(struct virtio_snd_config, chmaps),
> > >+    .max_size = sizeof(struct virtio_snd_config),
> > >+    .feature_sizes = feature_sizes
> > >+};
> > >+
> > > static const VMStateDescription vu_snd_vmstate = {
> > >     .name = "vhost-user-snd",
> > >     .unmigratable = 1,
> > >@@ -23,16 +35,20 @@ static const VMStateDescription vu_snd_vmstate = {
> > >
> > > static const Property vsnd_properties[] = {
> > >     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> > >+    DEFINE_PROP_BIT64("config-controls", VHostUserBase,
> >
> > In almost all other virtio/vhost-user devices, the property name does
> > not have the prefix `config-`, but usually the thing after F_, in this
> > case CTLS is cryptic, so IMO just `controls` should be fine.
> >
> > The only example I found is `config-wce` for vhost-user-blk, but in that
> > case the feature is actually called VIRTIO_BLK_F_CONFIG_WCE.
> >
> > Thanks,
> > Stefano
> >
> > >+                      parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
> > > };
> > >
> > > static void vu_snd_base_realize(DeviceState *dev, Error **errp)
> > > {
> > >     VHostUserBase *vub = VHOST_USER_BASE(dev);
> > >     VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
> > >+    VirtIODevice *vdev = &vub->parent_obj;
> > >
> > >     vub->virtio_id = VIRTIO_ID_SOUND;
> > >     vub->num_vqs = 4;
> > >-    vub->config_size = sizeof(struct virtio_snd_config);
> > >+    vub->config_size = virtio_get_config_size(&cfg_size_params,
> > >+                                              vdev->host_features);
> > >     vub->vq_size = 64;
> > >
> > >     vubs->parent_realize(dev, errp);
> > >--
> > >2.42.0
> > >


