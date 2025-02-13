Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53916C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibC6-0007qr-Dt; Thu, 13 Feb 2025 10:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tibC1-0007qU-Rr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:31:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tibBz-0000xr-Vr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739460712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Urtwy09SmOZ1Ibkdub3YWL2Oj0x+ZtxhVl/eSwHMqHg=;
 b=ULTy70M5+DOjzbiciN3xNkX9fTaFz8OditbxD7f93gx7VPGa1261krZk8Q6X8DlOU1Vd8A
 lCoo2MOBiO112Q3orS9od1Uk3cuCHRh+qc6x8YxvDJNbjTeqyy1x5OrJPLuHVaY/E5+IMI
 ErXS51JLewg46Zd6TY4NAA2zlrn31Xk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-BGWSJEiDNE2sq8l54ahQtQ-1; Thu, 13 Feb 2025 10:31:49 -0500
X-MC-Unique: BGWSJEiDNE2sq8l54ahQtQ-1
X-Mimecast-MFC-AGG-ID: BGWSJEiDNE2sq8l54ahQtQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38ddf4fa345so724276f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739460708; x=1740065508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Urtwy09SmOZ1Ibkdub3YWL2Oj0x+ZtxhVl/eSwHMqHg=;
 b=YMmd7Nh5A94BLNWzrB1YlZn2OTgcznenevUPV7hTjiI1MJl4+xgd2c8MT9daDNyvsN
 BiryVzt8L9MVZSD10nN1lBfFcs7/af2swOACjZ005ShGJY0l8bTdlOt91MdOR/b8EEyW
 /qMCnM6PLO17xG3hD+p4XwV8lFa3qF9AdPKP8/tUWoKO22+1MONQbI96SEDGB9GeH2YD
 WFW7z6trXlbQshbnlgz11G4aOCWuF6UZ0XsHNCGUgzO58Y/o01LUejqPxjbGgjTbwyyu
 UAIVGxsWOm2h76wWxgzZgvuZ30z1qpiuZ96nfOYYYHgNIGMfSm8TALdLhJ350B6kHNUQ
 WScw==
X-Gm-Message-State: AOJu0YxZVbWp+z9oZwIYbJHDr9XGjBvVtDA8cG9RITl46oO3T/xKy0V1
 1871TQyotKKhMfyKXUAjIxjxjW6BM052ZTiJa8NeYrLd7/NdCgmVOVjNnetxHCfyobqHxC2M+fk
 DH2Tw97JmULvY6e5kLOCw5IWVu6Mg7FLMWZGw2nZrFJcF1mNQYr3h
X-Gm-Gg: ASbGncvS5JfAoDbXqbP5kFEMjznhnnFkI1I7pyROGkTqmeNYd7QA0TB1wzShr715Zzq
 W0o7SwLXz8NJq2H48pPtcAqVexH8zlCQV+PZz5/W0PYR0XdZu8zG1C6091Ei2JkYFYP7utkSDcN
 ZO/tmR3WmnrAXEOcE5l9R6+YzSr4KXBKVFraV5jEpiYGZbBoSMnZHvaYPaB+FVquUZWP4ct4wvP
 5619WRgiFxjEgm430mkLNzr9LgcC7vnhC4kbOUNOpr0Vme89DDBJv97UUHGn5/5Eakbv//+4Cq4
 j4A+lisQ26Y6NRAHBE9SuDhPt5KtBXLUaYN0jXP020wnpgiHXEOt1A==
X-Received: by 2002:a5d:6b85:0:b0:38f:2a3e:870c with SMTP id
 ffacd0b85a97d-38f2a3e882emr1426117f8f.16.1739460708469; 
 Thu, 13 Feb 2025 07:31:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHs5Kal6Qct/p6o+1O1suakT79z83yPk1euqjksJUf3DEi0xMO4pHnCr52xINX4gladonlV8g==
X-Received: by 2002:a5d:6b85:0:b0:38f:2a3e:870c with SMTP id
 ffacd0b85a97d-38f2a3e882emr1426049f8f.16.1739460707647; 
 Thu, 13 Feb 2025 07:31:47 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddbbdsm2205376f8f.37.2025.02.13.07.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 07:31:47 -0800 (PST)
Date: Thu, 13 Feb 2025 16:31:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] vhost-user-snd: Use virtio_get_config_size()
Message-ID: <z2bfkwpwfohvmj6xesdm2zmatlcwxta4aexq6x543lpnt47333@ayqfx3yxs5eb>
References: <20250213132513.767709-1-mvaralar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250213132513.767709-1-mvaralar@redhat.com>
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

For the title, what about this?

   vhost-user-snd: fix incorrect config_size computation

Or something like that, just to make clear that we are fixing a
real issue.

On Thu, Feb 13, 2025 at 02:25:13PM +0100, Matias Ezequiel Vara Larsen 
wrote:
>Use virtio_get_config_size() rather than sizeof(struct
>virtio_snd_config) for the config_size in the vhost-user-snd frontend.
>The frontend shall rely on device features for the size of the device
>configuration space. This fixes an issue introduced by commit ab0c7fb2

When we refer to a commit it's a good practice to put both the sha1, but
also the title, like this:
This fixes an issue introduced by commit ab0c7fb22b ("linux-headers:
update to current kvm/next") ...

>in which the optional field `control` is added to the virtio_snd_config

s/control/controls

I would also specify here that the presence of `controls` in the config
space depends on VIRTIO_SND_F_CTLS, citing the specification:

5.14.4 Device Configuration Layout
  ...
  controls
     (driver-read-only) indicates a total number of all available control
     elements if VIRTIO_SND_F_CTLS has been negotiated.

>structure. This breaks vhost-user-device backends that do not implement
>the `controls` field.
>

I'd suggest to add the fixes tag:

Fixes: ab0c7fb22b ("linux-headers: update to current kvm/next")

And maybe also:

Cc: qemu-stable@nongnu.org

>Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>---
> hw/virtio/vhost-user-snd.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)
>
>diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
>index 8610370af8..8da4309470 100644
>--- a/hw/virtio/vhost-user-snd.c
>+++ b/hw/virtio/vhost-user-snd.c
>@@ -16,6 +16,18 @@
> #include "standard-headers/linux/virtio_ids.h"
> #include "standard-headers/linux/virtio_snd.h"
>
>+static const VirtIOFeature feature_sizes[] = {
>+    {.flags = 1ULL << VIRTIO_SND_F_CTLS,
>+    .end = endof(struct virtio_snd_config, controls)},
>+    {}
>+};
>+
>+static const VirtIOConfigSizeParams cfg_size_params = {
>+    .min_size = endof(struct virtio_snd_config, chmaps),
>+    .max_size = sizeof(struct virtio_snd_config),
>+    .feature_sizes = feature_sizes
>+};
>+
> static const VMStateDescription vu_snd_vmstate = {
>     .name = "vhost-user-snd",
>     .unmigratable = 1,
>@@ -23,16 +35,20 @@ static const VMStateDescription vu_snd_vmstate = {
>
> static const Property vsnd_properties[] = {
>     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
>+    DEFINE_PROP_BIT64("config-controls", VHostUserBase,

In almost all other virtio/vhost-user devices, the property name does 
not have the prefix `config-`, but usually the thing after F_, in this 
case CTLS is cryptic, so IMO just `controls` should be fine.

The only example I found is `config-wce` for vhost-user-blk, but in that 
case the feature is actually called VIRTIO_BLK_F_CONFIG_WCE.

Thanks,
Stefano

>+                      parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
> };
>
> static void vu_snd_base_realize(DeviceState *dev, Error **errp)
> {
>     VHostUserBase *vub = VHOST_USER_BASE(dev);
>     VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
>+    VirtIODevice *vdev = &vub->parent_obj;
>
>     vub->virtio_id = VIRTIO_ID_SOUND;
>     vub->num_vqs = 4;
>-    vub->config_size = sizeof(struct virtio_snd_config);
>+    vub->config_size = virtio_get_config_size(&cfg_size_params,
>+                                              vdev->host_features);
>     vub->vq_size = 64;
>
>     vubs->parent_realize(dev, errp);
>-- 
>2.42.0
>


